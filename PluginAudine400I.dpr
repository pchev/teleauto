library PluginAudine400I;

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

{$UNDEF COLOR}

uses
  SysUtils,
  Classes;

// Shutter state
const
  ShutterIsSynchro       = 0;
  ShutterIsAllwaysOpen   = 1;
  ShutterIsAllwaysClosed = 2;

type
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
    ShutterState:Byte;

// Variables used in this driver
    YearBegin,MonthBegin,DayBegin,HourBegin,MinBegin,SecBegin,MSecBegin:Word;
    YearEnd,MonthEnd,DayEnd,HourEnd,MinEnd,SecEnd,MSecEnd:Word;

procedure do_sleep(sleeptime:double);
var
time_start:Tdatetime;
begin
        time_start:=time;
        while Time<Time_start+sleeptime/60/60/24 do;
end;

procedure PortWrite(Contenu:Byte;Adresse:Word);
asm
    mov AL,Contenu
    mov DX,Adresse
    out DX,AL
end;


function PortRead(Adresse:Word):Byte;
asm
    mov DX,Adresse
    in AL,DX
    mov @Result,Al
end;
    
procedure AmpliOn; cdecl;
begin
PortWrite((PortRead(Adress+2) and $FE) xor $04, Adress+2);
end;

procedure AmpliOff; cdecl;
begin
PortWrite((PortRead(Adress+2) or $01) xor $04, Adress+2);
end;

procedure ShutterOpen; cdecl;
// Here you put the code to open the CCD shutter if needed
begin
// Driver normal :
// portwrite((portread(Adress+2) or $02) xor $04, Adress+2);
PortWrite((PortRead(Adress+2) and $FD) xor $04, Adress+2);
end;

procedure ShutterClosed; cdecl;
begin
// Driver normal :
// portwrite((portread(Adress+2) and $FD) xor $04, Adress+2);
PortWrite((PortRead(Adress+2) or $02) xor $04, Adress+2);
end;

{$R *.RES}
procedure Audine_read_pel_fast;
var
   LocalAdress:Word;
begin
LocalAdress:=Adress;
asm
   mov  dx,LocalAdress
   mov  al,$F7
   out  dx,al
   mov  al,$FF
   out  dx,al
   mov  al,$FB
   out  dx,al
end;
end;

{audineshiftlignetoserial}
{/******************** zi_zh ********************/
 /* Audine                                      */
 /*=============================================*/
 /* Transfert zone image -> registre horizontal */
 /***********************************************/}
procedure Audine_zi_zh;
var
   LocalAdress:Word;
begin
     LocalAdress:=Adress;
     asm
      mov dx,LocalAdress
      mov al,$FB
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FA
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$F9
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FA
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FB
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      end;
end;


procedure Audine_fast_line;
var
i:integer;
begin
     for i:=0 to 793 do
     begin
          audine_read_pel_fast;
     end;
end;

procedure Audine_fast_vidage;
var
i,j,k:integer;
{/*---- LECTURE DU REGISTRE HORIZONTAL ----*/}
begin
    for i:=1 to 129 do
    begin
       for j:=0 to 3 do audine_zi_zh;
       for k:=1 to 793 do audine_read_pel_fast;
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
if (_Binning=1) or (_Binning=2) or (_Binning=3) or (_Binning=4) then
   begin
   Binning:=_Binning;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetPose(_Pose:Double):Boolean; cdecl;
// TeleAuto gives you here the pose to use for the exposure in seconds
begin
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
begin
Result:=True;
end;

function PluginOpen:Boolean; cdecl;
// Here you must put the instruction needed to initialise the CCD camera before to use it
// This procedure is used only when connecting the CCD camera to TeleAuto
begin
//if UseAmpli then AmpliOn; // Necessaire ?
ShutterState:=ShutterIsSynchro;
Result:=True;
end;

procedure PluginClose; cdecl;
// Here you must put the instruction needed to close the CCD camera after using it
// This procedure is used only when disconnecting the CCD camera to TeleAuto
begin

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
   i:Integer;
   temp:tdatetime;
   PoseCamera:Integer;
begin
Result:=True;

PoseCamera:=Round(Pose*1000);

// if (getamplistate and ampliisused and (Pose > GetDelayToSwitchOffAmpli)) then
if (Pose > 4) then AmpliOff;

// vidage matrice
for i:=1 to 5 do Audine_fast_vidage;

// ouvrir l obtu si il est synchro
if (ShutterState=ShutterIsSynchro) and (pose > ShutterCloseDelay) then
   begin
   ShutterOpen;
   end;

// You can now call to the TeleAuto function giving precise hour
// TeleAuto will correct this time to save the middle exposure time in the image file
// You save the begining of the exposure to give it to TeleAuto later
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
   x,a1,a2,a3,a4:integer ;
   i,j,k,toto,z:integer;
   ligne:array [1..2000] of word;
begin
   result:=true; // Par defaut, pas d'erreur
   // On rallume l'ampli
{   if UseAmpli then
        AmpliOn;}
   // On ferme l'obturateur si il est synchro
   if (ShutterState=ShutterIsSynchro) and (Pose>shutterclosedelay) then
   begin
      ShutterClosed;
      do_sleep(ShutterCloseDelay);
   end;

   {/**** on retire les 4 premières lignes ****/ }
   for i:=0 to 3 do audine_zi_zh;
        audine_fast_line;

   for i:=1 to ((y1-1) div 4) do
   begin
        for j:=0 to 3 do audine_zi_zh;
        audine_fast_line;
   end;
   for j:=1 to((y1-1) mod 4) do audine_zi_zh;
   audine_fast_line;

   for i:=1 to (y2-y1+1) div binning do
   begin
      if not OSIsNT then asm cli end;
      audine_fast_line;
      {2 fois en b2, 3 en b3...}
      for k:=1 to binning do audine_zi_zh;
      {/**** on retire les 14 premiers pixels ****/ }
      for k:=1 to (14+x1-1) do audine_read_pel_fast; //0 to 13 do audine_read_pel_fast(Port);
      for j:=1 to (x2-x1+1) div binning do
      begin
         // reset
         portwrite(247,Adress);
         // palier de reference
         for toto:=1 to 5 do portwrite(255,Adress);
         // clamp
         portwrite(239,Adress);
         {on ne lit que les n pixels}
         for toto:=1 to binning do begin portwrite(255,Adress); portwrite(251,Adress); end;
         for toto:=1 to 4 do portwrite(251,Adress);
         for toto:=1 to 6 do portwrite(219,Adress);
         {numerisation}
         a1:=integer(portread(Adress+1)) shr 4;
         portwrite(91,Adress);
         a2:=integer(portread(Adress+1)) shr 4;
         portwrite(155,Adress);
         a3:=integer(portread(Adress+1)) shr 4;
         portwrite(27,Adress);
         a4:=integer(portread(Adress+1)) shr 4;

         x:=(a1+(a2 shl 4)+(a3 shl 8)+(a4 shl 12)) Xor $8888;  // pourquoi 34952 au fait ?
         if (x>32767) then x:=32767;
         // cast
         ligne[j]:=word(x);
      end;
      // on met dans DataInt
      for j:=1 to ((x2-x1+1) div binning) do
      begin
          if Ligne[j] >32767 then TabImgInt^[1]^[i]^[j]:=32767 else TabImgInt^[1]^[i]^[j]:=ligne[j];
      end;
      {/**** on retire 10 pixels à la fin ****/ }
      //for z:=1 to 20+x1-x0 do audine_read_pel_fast(Port);
      for z:=1 to 10 do audine_read_pel_fast;
   end;

//   DateTimeEnd:=GetHourDT;
   // You can now call the TeleAuto function giving precise hour
   // TeleAuto will correct this time to save the middle exposure time in the image file
   // Save the end of the exposure to give it to TeleAuto later
   GetHour(YearEnd,MonthEnd,DayEnd,HourEnd,MinEnd,SecEnd,MSecEnd);

//   result:=true; //et si il y a eu une erreur ?
   if not OSIsNT then asm sti end;

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
   ShutterOpen;
end;

procedure PluginShutterClosed; cdecl;
// Here you put the code to close the CCD shutter if needed
begin
   ShutterClosed;
end;

procedure PluginShutterSynchro; cdecl;
// Here you put the code to synchronise the CCD shutter with the exposure if needed
begin
   ShutterState:=ShutterIsSynchro;
end;

function PluginGetName:PChar; cdecl;
// Here you must provide then name of the camera
begin
Result:=PChar('Audine 400 avec Oturateur');
end;

function PluginGetSaturationLevel:Integer; cdecl;
// Here you must provide the saturation level of your camera
begin
Result:=16383; 
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
{$IFDEF COLOR}
Result:=3;
{$ELSE}
Result:=1;
{$ENDIF}
end;

function PluginGetTypeData:Integer; cdecl;
// Here you must provide the image data type :
// 2 for single plane 16 bits integer.
// 7 for three plane color image with 16 bits integer each plane.
begin
{$IFDEF COLOR}
Result:=7;
{$ELSE}
Result:=2;
{$ENDIF}
end;

function PluginIsAValidBinning(Binning:Byte):Boolean; cdecl;
// Here you must return true if the value of Binning is a valid binning value
// Only 1,2,3 and 4 are valid. 3 replace 4 if it exists
begin
if (Binning=1) or (Binning=2) or (Binning=3) then Result:=True // To modify
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
Result:=True;
end;

function PluginGetDelayToSwitchOffAmpli:Double; cdecl;
// Here you return the delay between the beginning of the exposure and the
// switch off of the output of the amplifier in seconds
begin
Result:=4;
end;

function PluginGetDelayToSwitchOnAmpli:Double; cdecl;
// Here you return the delay between the switch on of the output of the amplifier
// and the end of the exposure in seconds
begin
Result:=1;
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
Result:=True; // To modify
end;

function PluginHasAShutter:Boolean; cdecl;
// Here you return true if the CCD has a shutter
begin
Result:=True; // To modify
end;

// New in version 2.96
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
end.
