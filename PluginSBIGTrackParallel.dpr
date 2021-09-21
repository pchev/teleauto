library PluginSBIGTrackParallel;

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
  SysUtils, Classes, u_driver_sbig_univ;

// Shutter state
const
  ShutterIsSynchro       = 0;
  ShutterIsAllwaysOpen   = 1;
  ShutterIsAllwaysClosed = 2;

type
  TLigWord=array[1..999999] of Word;
  PLigWord=^TLigWord;

  TLigInt=array[1..999999] of SmallInt;
  PLigInt=^TLigInt;
  TImgInt=array[1..999999] of PLigInt;
  PImgInt=^TImgInt;
  TTabImgInt=array[1..255] of PImgInt;
  PTabImgInt=^TTabImgInt;

  // Prototype of the TeleAuto function you can call to have precise hour // New in version 2.8
  TGetHour = procedure (var Year,Month,Day,Hour,Min,Sec,MSec:Word);

var
  // TeleAuto function giving precise hour // New in version 2.8
  GetHour:TGetHour;

var
    F:TextFile;
// Variables provided by TeleAuto to setup ans use the CD camera
    AdressCamera:Word;             // The adress of the paralel port used by the camera
    x1,y1,x2,y2:Integer;           // The window to acquire in equivalent binning 1x1
    Binning:Integer;               // Binning used
    Pose:Double;                   // The pose in seconds
    EmptyingDelay:Double;          // Delay needed to empty the CCD (Hisis cameras)
    ReadingDelay:Double;           // Reading delay (Hisis cameras)
    ShutterCloseDelay:Double;      // Closing delay of the shutter
    PCMinusUT:Double;              // Difference hour PC minus hour UT
    OSiSNT:Boolean;                // Ta is used under NT ?
    ShutterState:Byte;

// Variables used in this driver
    YearBegin,MonthBegin,DayBegin,HourBegin,MinBegin,SecBegin,MSecBegin:Word;
    YearEnd,MonthEnd,DayEnd,HourEnd,MinEnd,SecEnd,MSecEnd:Word;

{$R *.RES}

// Ecrit dans le fichier Espion
procedure WriteSpy(Line:string);
var
   DT:TDateTime;
   Year,Month,Day,Hour,Min,Sec,MSec:Word;
   Tps,SHour,SMin,SSec:string;
begin
AssignFile(F,'sbigtrack.log');
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

procedure AmpliOn; cdecl;
begin
end;

procedure AmpliOff; cdecl;
begin
end;

procedure ShutterOpen; cdecl;
// Here you put the code to open the CCD shutter if needed
begin

end;

procedure ShutterClosed; cdecl;
begin

end;

function PluginGetXSize:Integer; cdecl;
// Here you must provide x size of the CCD chip in pixels
var
   Value:Word;
   Error:Word;
begin
Error:=GetCameraTrackWidthSbig(Value);
if Error<>0 then
   begin
   WriteSpy('GetCameraTrackWidthSbig : '+GetErrorSbig(Error));
   Exit;
   end;
Result:=Value;
end;

function PluginGetYSize:Integer; cdecl;
// Here you must provide y size of the CCD chip in pixels
var
   Value:Word;
   Error:Word;
begin
Error:=GetCameraTrackHeightSbig(Value);
if Error<>0 then
   begin
   WriteSpy('GetCameraTrackHeightSbig : '+GetErrorSbig(Error));
   Exit;
   end;
Result:=Value;
end;

procedure PluginSetPort(_Adress:Word); cdecl;
// TeleAuto gives you here the adress of the // port given by the user
begin
WriteSpy('PluginSetPort AdressCamera = '+IntToStr(_Adress));
AdressCamera:=_Adress;
end;

function PluginSetWindow(_x1,_y1,_x2,_y2:Integer):Boolean; cdecl;
// TeleAuto gives you here the window to use for the exposure
begin
WriteSpy('PluginSetWindow');
WriteSpy('PluginSetWindow x1 = '+IntToStr(_x1));
WriteSpy('PluginSetWindow y1 = '+IntToStr(_y1));
WriteSpy('PluginSetWindow x2 = '+IntToStr(_x2));
WriteSpy('PluginSetWindow y2 = '+IntToStr(_y2));
if (_x1>0) and (_x2>0) and (_x1<PluginGetXSize+1) and (_x2<PluginGetXSize+1) and
   (_y1>0) and (_y2>0) and (_y1<PluginGetYSize+1) and (_y2<PluginGetYSize+1) and
   (_x2>_x1) and (_y2>_y1) then
   begin
   WriteSpy('PluginSetWindow OK');
   x1:=_x1;
   y1:=_y1;
   x2:=_x2;
   y2:=_y2;
   Result:=True;
   end
else
   begin
   WriteSpy('PluginSetWindow Not OK');
   Result:=False;
   end;
end;

function PluginSetBinning(_Binning:Integer):Boolean; cdecl;
// TeleAuto gives you here the binning to use for the exposure
begin
WriteSpy('PluginSetBinning = '+IntToStr(_Binning));
if (_Binning=1) or (_Binning=2) or (_Binning=3) then
   begin
   WriteSpy('Binning OK');
   Binning:=_Binning;
   Result:=True;
   end
else
   begin
   WriteSpy('Binning Not OK');
   Result:=False;
   end;
end;

function PluginSetPose(_Pose:Double):Boolean; cdecl;
// TeleAuto gives you here the pose to use for the exposure in seconds
begin
WriteSpy('PluginSetPose = '+FloatToStr(_Pose));
Pose:=_Pose;
Result:=True;
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
   Name:PChar;
   Error:Word;
begin
Result:=False;
Error:=GetCameraTrackNameSbig(Name);
if Error<>0 then
   begin
   WriteSpy('GetCameraTrackNameSbig : '+GetErrorSbig(Error));
   Exit;
   end;
WriteSpy('PluginIsConnectedAndOK : '+Name);
if Copy(Name,1,4)='SBIG' then Result:=True;
end;

function PluginOpen:Boolean; cdecl;
// Here you must put the instruction needed to initialise the CCD camera before to use it
// This procedure is used only when connecting the CCD camera to TeleAuto
var
   Error:Word;
   NoCamera:Word;
   NoPort:Byte;
begin
Result:=True;

Error:=OpenDriverSbig;
if Error<>0 then
   begin
   WriteSpy('OpenDriverSbig : '+GetErrorSbig(Error));
   Result:=False;
   Exit;
   end;
if AdressCamera=$378 then NoPort:=1;
if AdressCamera=$278 then NoPort:=2;
if AdressCamera=$3BC then NoPort:=3;
Error:=OpenDeviceSbigParallel(NoPort,AdressCamera);
if Error<>0 then
   begin
   WriteSpy('OpenDeviceSbig : '+GetErrorSbig(Error));
   Result:=False;
   Exit;
   end;
Error:=EstablishLinkSbig(NoCamera);
if Error<>0 then
  begin
  WriteSpy('EstablishLinkSbig : '+GetErrorSbig(Error));
  Result:=False;
  Exit;
  end;
end;

procedure PluginClose; cdecl;
// Here you must put the instruction needed to close the CCD camera after using it
// This procedure is used only when disconnecting the CCD camera to TeleAuto
var
   Error:Word;
begin
Error:=CloseDeviceSbig;
if Error<>0 then WriteSpy('CloseDeviceSbig : '+GetErrorSbig(Error));
Error:=CloseDriverSbig;
if Error<>0 then WriteSpy('CloseDriverSbig : '+GetErrorSbig(Error));
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
   PoseCamera:Integer;
   Error:Word;
begin
Result:=True;

PoseCamera:=Round(Pose*100);

if ShutterState=ShutterIsAllwaysClosed then Error:=StartExposureTrackSbig(2,PoseCamera);
if ShutterState=ShutterIsSynchro then Error:=StartExposureTrackSbig(1,PoseCamera);
if Error<>0 then
   begin
   WriteSpy('StartExposureTrackSbig : '+GetErrorSbig(Error));
   Result:=False;
   Exit;
   end;

GetHour(YearBegin,MonthBegin,DayBegin,HourBegin,MinBegin,SecBegin,MSecBegin);
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
   Lig:PLigWord;
   Error,Valeur:Word;
   i,j:Integer;
   ReadoutLineParams:TReadoutLineParams;
begin
Getmem(Lig,768*2);

try

GetHour(YearEnd,MonthEnd,DayEnd,HourEnd,MinEnd,SecEnd,MSecEnd);
EndExposureTrackSbig;

// Virer les premieres lignes
DumpLineTrackSbig(Binning-1,(Y1-1) div Binning);

for j:=1 to ((Y2-Y1+1) div Binning) do
   begin
   ReadoutLineParams.Ccd:=1;
   ReadoutLineParams.ReadoutMode:=Binning-1;
   ReadoutLineParams.PixelStart:=X1 div Binning;
   ReadoutLineParams.PixelLength:=(X2-X1+1) div Binning;
//   ParDeviceCommandNH(CC_READOUT_LINE,ReadoutLineParams,Lig^);
   SBIGUnivDrvCommand(CC_READOUT_LINE,ReadoutLineParams,Lig^);

   for i:=1 to ((X2-X1+1) div Binning) do
      begin
      Valeur:=Lig^[i];
      if Valeur>32767 then TabImgInt^[1]^[j]^[i]:=32767 else TabImgInt^[1]^[j]^[i]:=Lig^[i];
      end;

//   Application.ProcessMessages;
   end;

EndReadoutTrackSbig;

finally
Freemem(Lig,768*2);
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
begin
Result:=0;
end;

procedure PluginSetTemperature(TargetTemperature:Double); cdecl;
// Here you send the setpoint temperature TargetTemperature provided by TeleAuto
// to the CCD camera
begin
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
AmpliOn;
end;

procedure PluginAmpliOff; cdecl;
// Here you put the code to switch off the CCD output amplifier if needed
begin
AmpliOff;
end;

procedure PluginShutterOpen; cdecl;
// Here you put the code to open the CCD shutter if needed
begin
ShutterState:=ShutterIsAllwaysOpen;
ShutterOpen;
end;

procedure PluginShutterClosed; cdecl;
// Here you put the code to close the CCD shutter if needed
begin
ShutterState:=ShutterIsAllwaysClosed;
ShutterClosed;
end;

procedure PluginShutterSynchro; cdecl;
// Here you put the code to synchronise the CCD shutter with the exposure if needed
begin
ShutterState:=ShutterIsSynchro;
end;

function PluginGetName:PChar; cdecl;
// Here you must provide then name of the camera
var
   NameCamera:PChar;
   Error:Word;
begin
Error:=GetCameraNameSbig(NameCamera);
if Error<>0 then
   begin
   WriteSpy('GetCameraNameSbig : '+GetErrorSbig(Error));
   Exit;
   end;
WriteSpy('PluginGetName = '+NameCamera);
Result:=NameCamera;
end;

function PluginGetSaturationLevel:Integer; cdecl;
// Here you must provide the saturation level of your camera
var
   ADSize:Word;
   Value:Word;
   Error:Word;
begin
Error:=GetADSizeSbig(ADSize);
if Error<>0 then
   begin
   WriteSpy('GetADSbig : '+GetErrorSbig(Error));
   Exit;
   end;
if ADSize=12 then Value:=16383;
if ADSize=16 then Value:=65535;
WriteSpy('PluginGetSaturationLevel = '+IntToStr(Value));
Result:=Value;
end;

function PluginGetXPixelSize:Double; cdecl;
// Here you must provide the x size of the CCD chip pixel
var
   Value:Double;
   Error:Word;
begin
Error:=GetPixelTrackWidthSbig(Value);
if Error<>0 then
   begin
   WriteSpy('GetTrackPixelWidth : '+GetErrorSbig(Error));
   Exit;
   end;
WriteSpy('PluginGetXPixelSize = '+FloatToStr(Value));
Result:=Value;
end;

function PluginGetYPixelSize:Double; cdecl;
// Here you must provide the y size of the CCD chip pixel
var
   Value:Double;
   Error:Word;
begin
Error:=GetPixelTrackHeightSbig(Value);
if Error<>0 then
   begin
   WriteSpy('GetTrackPixelHeight : '+GetErrorSbig(Error));
   Exit;
   end;
WriteSpy('PluginGetYPixelSize = '+FloatToStr(Value));
Result:=Value;
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
if (Binning=1) or (Binning=2) or (Binning=3) then Result:=True
else Result:=False;
end;

function PluginHasTemperature:Boolean; cdecl;
// Here you must return true if CCD camera has CCD chip temperature information
begin
Result:=False;
end;

function PluginCanCutAmpli:Boolean; cdecl;
// Here you can return true if the output amplifier of the CCD camera can be cut during
// exposure
begin
Result:=False;
end;

function PluginGetDelayToSwitchOffAmpli:Double; cdecl;
// Here you return the delay between the beginning of the exposure and the
// switch off of the output of the amplifier in seconds
begin
Result:=0;
end;

function PluginGetDelayToSwitchOnAmpli:Double; cdecl;
// Here you return the delay between the switch on of the output of the amplifier
// and the end of the exposure in seconds
begin
Result:=0;
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

function PluginHasAShutter:Boolean; cdecl;
// Here you return true if the CCD has a shutter
begin
Result:=True; // To modify
end;

// New in version 2.96
function PluginIs16Bits:Boolean; cdecl;
// Here you return true if the CCD has a 16 bits ADC
var
   ADSize:Word;
   Error:Word;
begin
Result:=False;
Error:=GetADSizeSbig(ADSize);
if Error<>0 then
   begin
   WriteSpy('GetADSizeSbig : '+GetErrorSbig(Error));
   Result:=False;
   Exit;
   end;
if ADSize=16 then
   begin
   WriteSpy('PluginIs16Bits : True');
   Result:=True;
   end
else WriteSpy('PluginIs16Bits : False');
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
AssignFile(F,'sbigtrack.log');
Rewrite(F);
CloseFile(F);
end.
