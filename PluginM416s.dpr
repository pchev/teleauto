library PluginM416s;

{
Copyright (C) Philippe Martinole

http://www.teleauto.org/
philippe.martinole@teleauto.org

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
}

uses
  SysUtils,
  Classes,
  Forms;

type
  TLigInt=array[1..999999] of SmallInt;
  PLigInt=^TLigInt;
  TImgInt=array[1..999999] of PLigInt;
  PImgInt=^TImgInt;
  TTabImgInt=array[1..255] of PImgInt;
  PTabImgInt=^TTabImgInt;

  TBuffer=array[1..768*512*2] of byte;
  PBuffer=^TBuffer;

  // Prototype of the TeleAuto function you can call to have precise hour // New in version 2.8
  TGetHour = procedure (var Year,Month,Day,Hour,Min,Sec,MSec:Word);

var
  // TeleAuto function giving precise hour // New in version 2.8
  GetHour:TGetHour;

var
// Variables provided by TeleAuto to setup ans use the CD camera
    Adress:Word;                   // The adress of the paralel port used by the camera
    x1,y1,x2,y2:Integer;           // The window to acquire in equivalent binning 1x1
    Binning:Integer;               // Binning used
    Pose:Double;                   // The pose in seconds
    EmptyingDelay:Double;          // Delay needed to empty the CCD (Hisis cameras)
    ReadingDelay:Double;           // Reading delay (Hisis cameras)
    ShutterCloseDelay:Double;      // Closing delay of the shutter
    PCMinusUT:Double;              // Difference hour PC minus hour UT
    OSiSNT:Boolean;                // Ta is used under NT ?
    ShutterClosed:Boolean;

// Variables used in this driver
    YearBegin,MonthBegin,DayBegin,HourBegin,MinBegin,SecBegin,MSecBegin:Word;
    YearEnd,MonthEnd,DayEnd,HourEnd,MinEnd,SecEnd,MSecEnd:Word;

    F:TextFile;

  function Connect(Messag:PChar):Integer; cdecl; external 'M416SCSI.dll' name 'Connect'; //nolang
  function Disconnect:Integer; cdecl; external 'M416SCSI.dll' name 'Disconnect'; //nolang
  procedure SetTemperature(Tenth:Integer); cdecl; external 'M416SCSI.dll' name 'SetTemperature'; //nolang
  function GetCoolingInfo(var Power:Integer):Integer; cdecl; external 'M416SCSI.dll' name 'GetCoolingInfo'; //nolang
  function Expose(expTime,dark,bin,w,h,x,y:Integer):Integer; cdecl; external 'M416SCSI.dll' name 'Expose'; //nolang
  function Download(Buffer:PBuffer):Integer; cdecl; external 'M416SCSI.dll' name 'Download'; //nolang
  function Ready:Integer; cdecl; external 'M416SCSI.dll' name 'Ready'; //nolang

{$R *.RES}

procedure MySleep(Temps:Integer);
var
   TimeInit:TDateTime;
begin
// On attends
TimeInit:=Time;
while Time<TimeInit +Temps/1000/60/60/24 do Application.ProcessMessages;
end;

// Ecrit dans le fichier Espion
procedure WriteSpy(Line:String);
var
   DT:TDateTime;
   Year,Month,Day,Hour,Min,Sec,MSec:Word;
   Tps,SHour,SMin,SSec:string;
begin
   AssignFile(F,'SpyM416.log'); //nolang
   try
   Append(F);

   DT:=Now;
   DecodeDate(DT,Year,Month,Day);
   DecodeTime(DT,Hour,Min,Sec,MSec);

   if Hour<10 then SHour:='0'+IntToStr(Hour) else SHour:=IntToStr(Hour);
   if Min<10 then SMin:='0'+IntToStr(Min) else SMin:=IntToStr(Min);
   if Sec<10 then SSec:='0'+IntToStr(Sec) else SSec:=IntToStr(Sec);

   Tps:=SHour+':'+Smin+':'+SSec;


   Writeln(F,Tps+' '+Line);

   finally
   CloseFile(F);
   end;

end;

function PluginGetXSize:Integer; cdecl;
// Here you must provide x size of the CCD chip in pixels
begin
Result:=768; // To modify
end;

function PluginGetYSize:Integer; cdecl;
// Here you must provide y size of the CCD chip in pixels
begin
Result:=512; // To modify
end;

procedure PluginSetPort(_Adress:Word); cdecl;
// TeleAuto gives you here the adress of the // port given by the user
begin
Adress:=_Adress;
end;

function PluginSetWindow(_x1,_y1,_x2,_y2:Integer):Boolean; cdecl;
// TeleAuto gives you here the window to use for the exposure
begin
if (_x1>0) and (_x2>0) and (_x1<PluginGetXSize+1) and (_x2<PluginGetXSize+1) and
   (_y1>0) and (_y2>0) and (_y1<PluginGetYSize+1) and (_y2<PluginGetYSize+1) and
   (_x2>_x1) and (_y2>_y1) then
   begin
   x1:=_x1;
   y1:=_y1;
   x2:=_x2;
   y2:=_y2;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetBinning(_Binning:Integer):Boolean; cdecl;
// TeleAuto gives you here the binning to use for the exposure
begin
if (_Binning=1) or (_Binning=2) then
   begin
   Binning:=_Binning;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetPose(_Pose:Double):Boolean; cdecl;
// TeleAuto gives you here the pose to use for the exposure in seconds
begin
if (_Pose>0) and (_Pose<50331.645) then
   begin
   Pose:=_Pose;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetEmptyingDelay(_EmptyingDelay:Double):Boolean; cdecl;
// TeleAuto gives you here the time taken to empty the CCD chip if given by the user
begin
if (_EmptyingDelay>0) then
   begin
   EmptyingDelay:=_EmptyingDelay;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetReadingDelay(_ReadingDelay:Double):Boolean; cdecl;
// TeleAuto gives you here the reading delay to slow down the // port speed (Hisis 22)
begin
if (_ReadingDelay>0) then
   begin
   ReadingDelay:=_ReadingDelay;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetShutterCloseDelay(Delay:Double):Boolean; cdecl;
// TeleAuto gives you here the closing delay of the shutter (Audine/Genesis with R. David shutter)
begin
if (Delay>0) then
   begin
   ShutterCloseDelay:=Delay;
   Result:=True;
   end
else Result:=False;
end;

function PluginIsConnectedAndOK:Boolean; cdecl;
// Here you must provide a function used by TeleAuto to know if the CCD camera is connected and operating
// Return true if everything is OK
var
   Test:Integer;
//   Messag:PChar;
   Messag:array[0..255] of Char;
   Str:String;
begin
WriteSpy('Connection ...');
Test:=Connect(Messag);
Result:=True;
if Test=0 then
   begin
   WriteSpy('Error at connection');
   Str:=Messag;
   WriteSpy('ErrorMessage = \'+Str+'\');
   Result:=False;
   end
else WriteSpy('Connection OK');
end;

function PluginOpen:Boolean; cdecl;
// Here you must put the instruction needed to initialise the CCD camera before to use it
// This procedure is used only when connecting the CCD camera to TeleAuto
begin
Result:=True;
end;

procedure PluginClose; cdecl;
// Here you must put the instruction needed to close the CCD camera after using it
// This procedure is used only when disconnecting the CCD camera to TeleAuto
begin
WriteSpy('Disconnection');
Disconnect;
end;

function PluginStartPose:Boolean; cdecl;
// Here you must put the instruction needed to start the pose
// The variables to use here are
//    Adress:Word;
//    x1,y1,x2,y2:Integer;
//    Sx,Sy:Integer;
//    Pose:Double;
//    Binning:Integer;
// Return true if everything is OK
var
   Dark:Integer;
   Error:Integer;
begin
if ShutterClosed then Dark:=1 else Dark:=0;
WriteSpy('Pose = '+IntToStr(Round(Pose*1000)));
WriteSpy('Dark = '+IntToStr(Dark));
WriteSpy('Binning = '+IntToStr(Binning-1));
WriteSpy('w = '+IntToStr(x2-x1+1));
WriteSpy('h = '+IntToStr(y2-y1+1));
WriteSpy('x = '+IntToStr(x1-1));
WriteSpy('y = '+IntToStr(y1-1));
WriteSpy('Start exposure');
Error:=Expose(Round(Pose*1000),Dark,Binning-1,x2-x1+1,y2-y1+1,x1-1,y1-1);
Result:=True;
if Error=0 then
  begin
  WriteSpy('Error Starting exposure');
  Result:=False;
  end
else WriteSpy('Start exposure OK');

// You can now call to the TeleAuto function giving precise hour
// TeleAuto will correct this time to save the middle exposure time in the image file
// You save the begining of the exposure to give it to TeleAuto later
GetHour(YearBegin,MonthBegin,DayBegin,HourBegin,MinBegin,SecBegin,MSecBegin);

Result:=True;
end;

function PluginStopPose:Boolean; cdecl;
// Here you must put the code to stop the exposure before the normal end given
// in the PluginStartPose function
// Return true if everything is OK
begin
Result:=True;
end;

function PluginReadCCD(TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; cdecl;
// Here you meux provide the image in a PTabImgInt form
// You must not allocate memory for the TabImgInt because it is already done in TeleAuto
// Return true if everything is OK
var
   i,j,sx1,sy1,Error,Index:Integer;
   Buffer:TBuffer;
   Val:Word;
begin
Result:=True;
// check to not trespass the allocated image size
sx1:=(x2-x1+1) div Binning;
if sx1>ImgSx then sx1:=ImgSx;
sy1:=(y2-y1+1) div Binning;
if sy1>ImgSy then sy1:=ImgSy;

// You can now call the TeleAuto function giving precise hour
// TeleAuto will correct this time to save the middle exposure time in the image file
// Save the end of the exposure to give it to TeleAuto later
GetHour(YearEnd,MonthEnd,DayEnd,HourEnd,MinEnd,SecEnd,MSecEnd);

WriteSpy('Waiting camera ready ...');
while Ready=0 do
   begin
   WriteSpy('Not ready ...');
   MySleep(500);
   end;
WriteSpy('Ready ...');

WriteSpy('Downloading Image ...');
Download(@Buffer);
Result:=True;
if Error=0 then
  begin
  WriteSpy('Error downloading image');
  Result:=False;
  end
else WriteSpy('Image download OK');

// check to not trespass the allocated image size
Sx1:=(x2-x1+1) div Binning;
if Sx1>ImgSx then sx1:=ImgSx;
Sy1:=(y2-y1+1) div Binning;
if Sy1>ImgSy then sy1:=ImgSy;

Index:=1;
for j:=1 to Sy1 do
   for i:=1 to Sx1 do
      begin
      if Index>(Sx1*Sy1*2) then WriteSpy('Index Overflow');
      Val:=Buffer[Index]*256+Buffer[Index+1];
      if Val>32767 then Val:=32767;
      TabImgInt^[1]^[j]^[i]:=Val; // TabImgInt^[1]^[j]^[i]:=-32768 for a 16 bits ADC camera
      Index:=Index+2;
      end;

end;

// Old PluginGetCCDDate / New in Version 2.8
procedure PluginGetCCDDateBegin(var Year,Month,Day:Word); cdecl;
// Here you must provide the date of the begin of the exposure
begin
Year:=YearBegin;
Month:=MonthBegin;
Day:=DayBegin;
end;

// Old PluginGetCCDTime / New in Version 2.8
procedure PluginGetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); cdecl;
// Here you must provide the time of the begin of the exposure
begin
Hour:=HourBegin;
Min:=MinBegin;
Sec:=SecBegin;
MSec:=MSecBegin;
end;

// New in Version 2.8
procedure PluginGetCCDDateEnd(var Year,Month,Day:Word); cdecl;
// Here you must provide the date of the end of the exposure
begin
Year:=YearEnd;
Month:=MonthEnd;
Day:=DayEnd;
end;

// New in Version 2.8
procedure PluginGetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); cdecl;
// Here you must provide the time of the end of the exposure
begin
Hour:=HourEnd;
Min:=MinEnd;
Sec:=SecEnd;
MSec:=MSecEnd;
end;

// New in Version 2.8
procedure PluginSetHourServer(ServerAdress:Pointer); cdecl;
begin
// This is the adress of the TeleAuto function giving precise hour
@GetHour:=ServerAdress;
end;

function PluginGetTemperature:Double; cdecl;
// Here you provide the CCD temperature of the CCD camera
var
   Power,Temp:Integer;
begin
//WriteSpy('Getting temperature ...');
Temp:=GetCoolingInfo(Power);
//WriteSpy('Temperature = '+IntToStr(Temp));
//WriteSpy('Power = '+IntToStr(Power));
Result:=Temp/10;
end;

procedure PluginSetTemperature(TargetTemperature:Double); cdecl;
// Here you send the setpoint temperature TargetTemperature provided by TeleAuto
// to the CCD camera
begin
//WriteSpy('Setting temperature ...');
//WriteSpy('Temperature = '+IntToStr(Round(TargetTemperature*10)));
SetTemperature(Round(TargetTemperature*10));
end;

procedure PluginSetPCMinusUT(_PCMinusUT:Double); cdecl;
// Here you get the difference between the hour of the PC and the UT hour
// You an use this value to correct the PC date and hour before to give it to TeleAuto
begin
PCMinusUT:=_PCMinusUT;
end;

procedure PluginAmpliOn; cdecl;
// Here you put the code to switch on the CCD output amplifier
begin

end;

procedure PluginAmpliOff; cdecl;
// Here you put the code to switch off the CCD output amplifier if needed
begin

end;

procedure PluginShutterOpen; cdecl;
// Here you put the code to open the CCD shutter if needed
begin
ShutterClosed:=False;
end;

procedure PluginShutterClosed; cdecl;
// Here you put the code to close the CCD shutter if needed
begin
ShutterClosed:=True;
end;

procedure PluginShutterSynchro; cdecl;
// Here you put the code to synchronise the CCD shutter with the exposure if needed
begin
ShutterClosed:=False;
end;

function PluginGetName:PChar; cdecl;
// Here you must provide then name of the camera
begin
Result:='Pictor 416 SCSI'; // To modify
end;

function PluginGetSaturationLevel:Integer; cdecl;
// Here you must provide the saturation level of your camera
begin
Result:=65535; // To modify
end;

function PluginGetXPixelSize:Double; cdecl;
// Here you must provide the x size of the CCD chip pixel
begin
Result:=9; // To modify
end;

function PluginGetYPixelSize:Double; cdecl;
// Here you must provide the y size of the CCD chip pixel
begin
Result:=9; // To modify
end;

function PluginGetNbplans:Integer; cdecl;
// Here you must provide the number of color plane for the image
begin
Result:=1;
end;

function PluginGetTypeData:Integer; cdecl;
// Here you must provide the image data type :
// 2 for single plane 16 bits integer.
// 7 for three plane color image with 16 bits integer each plane.
begin
Result:=2;
end;

function PluginIsAValidBinning(Binning:Byte):Boolean; cdecl;
// Here you must return true if the value of Binning is a valid binning value
// Only 1,2,3 and 4 are valid. 3 replace 4 if it exists
begin
if (Binning=1) or (Binning=2) then Result:=True // To modify
else Result:=False;
end;

function PluginHasTemperature:Boolean; cdecl;
// Here you must return true if CCD camera has CCD chip temperature information
begin
Result:=True; // To modify
end;

function PluginCanCutAmpli:Boolean; cdecl;
// Here you can return true if the output amplifier of the CCD camera can be cut during
// exposure
begin
Result:=False; // To modify
end;

function PluginGetDelayToSwitchOffAmpli:Double; cdecl;
// Here you return the delay between the beginning of the exposure and the
// switch off of the output of the amplifier in seconds
begin
Result:=1; // To modify
end;

function PluginGetDelayToSwitchOnAmpli:Double; cdecl;
// Here you return the delay betwenn the switch on of the output of the amplifier
// and the end of the exposure in seconds
begin
Result:=4; // To modify
end;

function PluginNeedEmptyingDelay:Boolean; cdecl;
// Here you return true if you need to know the emptying delay of the CCD camera
// provided by the user
begin
Result:=False; // To modify
end;

function PluginNeedReadingDelay:Boolean; cdecl;
// Here you return true if you need to know the reading delay of the CCD camera
// provided by the user
begin
Result:=False; // To modify
end;

function PluginNeedCloseShutterDelay:Boolean; cdecl;
// Here you return true if you need to know the closing delay of the shutter
// provided by the user
begin
Result:=False; // To modify
end;

// New in version 2.96
function PluginHasAShutter:Boolean; cdecl;
// Here you return true if the CCD has a shutter
begin
Result:=True; // To modify
end;

function PluginIs16Bits:Boolean; cdecl;
// Here you return true if the CCD has a 16 bits ADC
begin
Result:=False; // To modify
end;

// New in Version 2.8
procedure PluginIsUsedUnderNT; cdecl;
// Now you know TA is used on NT/2000/XP OS with PortTalk
// You must not use cli/sti assembleur functions to stop interruptions
// Exemple :
// if not OSiSNT then asm cli end;
begin
OSiSNT:=True;
end;

// New in Version 2.8
procedure PluginIsNotUsedUnderNT; cdecl;
// Now you know TA is not used on NT/2000/XP OS with PortTalk
// You can use cli/sti assembleur functions to stop interruptions
begin
OSiSNT:=False;
end;

// New in Version 2.98
function PluginHasCfgWindow:Boolean; cdecl;
// Here you must return true if this plugin can display a configuration window
begin
Result:=False; // To modify
end;

// New in Version 2.98
function PluginShowCfgWindow:Boolean; cdecl;
// Here you can show the custom configuration window
begin
Result:=True;
end;

exports

PluginSetPort,
PluginSetWindow,
PluginSetBinning,
PluginSetPose,
PluginSetEmptyingDelay,
PluginSetReadingDelay,
PluginSetShutterCloseDelay,
PluginIsConnectedAndOK,
PluginOpen,
PluginClose,
PluginStartPose,
PluginSetHourServer,
PluginGetCCDDateBegin,
PluginGetCCDDateEnd,
PluginGetCCDTimeBegin,
PluginGetCCDTimeEnd,
PluginStopPose,
PluginReadCCD,
PluginGetTemperature,
PluginSetTemperature,
PluginSetPCMinusUT,
PluginAmpliOn,
PluginAmpliOff,
PluginShutterOpen,
PluginShutterClosed,
PluginShutterSynchro,
PluginGetName,
PluginGetSaturationLevel,
PluginGetXSize,
PluginGetYSize,
PluginGetXPixelSize,
PluginGetYPixelSize,
PluginGetNbplans,
PluginGetTypeData,
PluginIsAValidBinning,
PluginHasTemperature,
PluginCanCutAmpli,
PluginGetDelayToSwitchOffAmpli,
PluginGetDelayToSwitchOnAmpli,
PluginNeedEmptyingDelay,
PluginNeedReadingDelay,
PluginNeedCloseShutterDelay,
PluginHasAShutter,
PluginIsUsedUnderNT,
PluginIsNotUsedUnderNT,
PluginIs16Bits,
PluginHasCfgWindow,
PluginShowCfgWindow;

begin
AssignFile(F,'SpyM416.log');        //nolang
Rewrite(F);
CloseFile(F);
end.
