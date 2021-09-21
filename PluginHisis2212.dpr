library PluginHisis2212;

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

{ Camera Plugin exemple for TeleAuto
  Allow to drive the Hisis 22 camera
  Direct conversion of the original capt14.pas driver of Gilles Revillon
  Doesn't leave he shutter closed for darks}

uses
  SysUtils,
  Classes,
  Windows; // Only for the sleep function;

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
  // Variables provided by the TeleAuto user to set up the CD camera
  Adress:Word;                   // The adress of the paralel port used by the camera
  x1,y1,x2,y2:Integer;           // The window to acquire in equivalent binning 1x1
  Sx,Sy:Integer;                 // Size of the CCD detector
  Binning:Integer;               // Binning used
  Pose:Double;                   // The pose in seconds
  EmptyingDelay:Double;          // Delay needed to empty the CCD (Hisis cameras)
  ReadingDelay:Double;           // Reading delay (Hisis cameras)
  DateTimeBegin:TDateTime;       // The time of the expose begining
  DateTimeEnd:TDateTime;         // The time of the expose begining
  PCMinusUT:Double;              // Difference hour PC minus hour UT
  OSiSNT:Boolean;                // Ta is used under NT ?

  // Variables used in this driver
  YearBegin,MonthBegin,DayBegin,HourBegin,MinBegin,SecBegin,MSecBegin:Word;
  YearEnd,MonthEnd,DayEnd,HourEnd,MinEnd,SecEnd,MSecEnd:Word;

  // Hisis 22 specific variables
  PoseLo : Word;
  PoseHi : Byte;
  PoseI  : LongInt absolute PoseLo;

{$R *.RES}

// Give BIOS hour
// Give only seconds
function GetRealDateTime:TDateTime;
var
Heures,Minutes,Secondes,Siecles,Annees,Mois,Jours:Byte;
WHeures,WMinutes,WSecondes,WAnnees,WMois,WJours:Word;
begin
  asm
  // Hour
  mov ah,02
  int $1a
  mov Heures,ch
  mov Minutes,cl
  mov Secondes,dh

  // Date
  mov ah,04
  int $1a
  mov Siecles,ch
  mov Annees,cl
  mov Mois,dh
  mov Jours,dl
  end;

  // BCD Convertion
  WHeures:=((Heures and $f0) shr 4)*10+(Heures and $0f);
  WMinutes:=((Minutes and $f0) shr 4)*10+(Minutes and $0f);
  WSecondes:=((Secondes and $f0) shr 4)*10+(Secondes and $0f);
  WAnnees:=(((Siecles and $f0) shr 4)*10+(Siecles and $0f))*100+((Annees and $f0) shr 4)*10+(Annees and $0f);
  WMois:=((Mois and $f0) shr 4)*10+(Mois and $0f);
  WJours:=((Jours and $f0) shr 4)*10+(Jours and $0f);
  Result:=EncodeTime(WHeures,WMinutes,WSecondes,0)+EncodeDate(WAnnees,WMois,WJours)-PCMinusUT/24;
end;

// Functions to read/write on the // port

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


// Hisis 22 Specific Function
function WritePar(Adress:Word;Par:Byte):Boolean;
var
i:integer;
begin
Result:=True;
i:=0;
repeat inc(i) until ((PortRead(Adress+1) and $40)=$40) or (i>10000);
if i>10000 then begin Result:=False; Exit; end;
PortWrite(Par,Adress);
for i:=1 to 10000 do;
PortWrite($0D,Adress+2);
i:=0;
repeat inc(i) until ((PortRead(Adress+1) and $40)=0) or (i>10000);
if i>10000 then begin Result:=False; Exit; end;
PortWrite($0C,Adress+2);
end;

function PluginGetXSize:Integer; cdecl;
// Here you must provide x size of the CCD chip in pixels
begin
Result:=768;
end;

function PluginGetYSize:Integer; cdecl;
// Here you must provide y size of the CCD chip in pixels
begin
Result:=512;
end;

procedure PluginSetPort(_Adress:Word); cdecl;
// The adress of the // port to use
begin
Adress:=_Adress;
end;

function PluginSetWindow(_x1,_y1,_x2,_y2:Integer):Boolean; cdecl;
// The window to use for the exposure
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
// The binning to use for the exposure
begin
if (_Binning=1) or (_Binning=2) or (_Binning=3) or (_Binning=4) then
   begin
   Binning:=_Binning;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetPose(_Pose:Double):Boolean; cdecl;
// The pose to use for the exposure in seconds
begin
if _Pose>0 then
   begin
   if _Pose>50331.645 then _Pose:=50331.645;
   Pose:=_Pose;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetEmptyingDelay(_EmptyingDelay:Double):Boolean; cdecl;
// The time taken to empty the CCD chip (for Hisis 22 cameras)
begin
if (_EmptyingDelay>0) then
   begin
   EmptyingDelay:=_EmptyingDelay;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetReadingDelay(_ReadingDelay:Double):Boolean; cdecl;
// The reading delay to slow down the // port speed (Hisis 22)
begin
if (_ReadingDelay>0) then
   begin
   ReadingDelay:=_ReadingDelay;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetShutterCloseDelay(Delay:Double):Boolean; cdecl;
// The closing delay of the shutter (Audine/Genesis with R. David shutter)
begin
// Not used
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
// Nothing to do
Result:=True;
end;

procedure PluginClose; cdecl;
// Here you must put the instruction needed to close the CCD camera after using it
// This procedure is used only when closing TeleAuto
begin
// Nothing to do
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
   TimeInit:TDateTime;
   Good:Boolean;
   LocalAdress:Word;
begin
   LocalAdress:=Adress;
   Result:=True;

   Sx:=(x2-x1+1) div Binning;
   Sy:=(y2-y1+1) div Binning;

   //InitPortParallele;
   PortWrite($ff,Adress);

   //WriteCapture
   PoseI:=Round(Pose*1000/3);
   PoseHi:=PoseI shr 16;
   PortWrite($81,Adress);    // présentation de la commande
                             // $81 est le code de la commande d'initialisation de la caméra
   PortWrite($0C,Adress+2);  // génération du front descendant
   PortWrite($0C,Adress+2);  // sur la ligne ComValid
   PortWrite($0D,Adress+2);  // ComValid = 0
   PortWrite($0D,Adress+2);  // ComValid = 0
   i:=0;
   Good:=True;
   repeat Inc(i) until ((PortRead(Adress+1) and $40)=0) or (i>10000);
   if i>10000 then begin Result:=False; Exit; end;
   // La camera se referme ici mais on peut pas l'enlever sinon ca merde
   PortWrite($0C,Adress+2);      // ComValid = 1
   //if Good and pop_camera.ObturateurOuvert then WritePar(Ord('o')); // pas utilise
//   if Good and IsDark then Good:=WritePar(Adress,Ord('c'));
   if Good then Good:=WritePar(Adress,$96); // $96 est le code de la commande de prise d'images
                                            // $4C est utilis‚ pour interrompre une pose *)
   if Good then Good:=WritePar(Adress,PoseHi);
   if Good then Good:=WritePar(Adress,Hi(PoseLo));
   if Good then Good:=WritePar(Adress,Lo(PoseLo));
   if Good then Good:=WritePar(Adress,Hi(x1));
   if Good then Good:=WritePar(Adress,Lo(x1));
   if Good then Good:=WritePar(Adress,Hi(y1));
   if Good then Good:=WritePar(Adress,Lo(y1));
   if Good then Good:=WritePar(Adress,Hi(x2));
   if Good then Good:=WritePar(Adress,Lo(x2));
   if Good then Good:=WritePar(Adress,Hi(y2));
   if Good then Good:=WritePar(Adress,Lo(y2));
   if Good then Good:=WritePar(Adress,(Binning shl 4)+Binning);
   if Good then Good:=WritePar(Adress,1); // sequence
   // L'ordre de photographier est lance ici apres la sequence
   //WritePar(Ord('o'));

   if not(Good) then
      begin
      Result:=False;
      Exit;
      end;

   asm
    push edx
    push eax

    mov  dx,LocalAdress
    inc  dx
    inc  dx
    mov  al,00001100b
    out  dx,al
    out  dx,al

    pop eax
    pop edx
   end;

   TimeInit:=Time;
   while Time<TimeInit+EmptyingDelay/60/60/24 do;

// You can now call to the TeleAuto function giving precise hour
// TeleAuto will correct this time to save the middle exposure time in the image file
// Here you save the begining of the exposure to give it to TeleAuto later
GetHour(YearBegin,MonthBegin,DayBegin,HourBegin,MinBegin,SecBegin,MSecBegin);

//   DateTimeBegin:=GetRealDateTime;  // To have BIOS hour
//   DateTime:=Now;  // To have Windows hour (Shifted during exposures)
end;

function PluginStopPose:Boolean; cdecl;
// Here you must put the code to stop the exposure before the normal end given
// in the PluginStartPose function
// Return true if everything is OK
begin
   WritePar(Adress,$4C);
   Result:=True;
end;

function PluginReadCCD(TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; cdecl;
// Here you must provide the image in a PTabImgInt form
// You must not allocate memory because it is already done in TeleAuto
// Return true if everything is OK
var
   i,j,k:Integer;
   Pixel,CountPixel,CountLine:Word;
   Fin:Boolean;
   Synchro:Byte;
   Line:array[1..768] of Word;
   LocalDelai:Integer;
   LocalAdress:Word;
begin
LocalDelai:=Round(ReadingDelay);
LocalAdress:=Adress;
Result:=True;

CountLine:=0;
CountPixel:=0;
FillChar(Line,SizeOf(Line),0);

// If TeleAuto is used under NT/2000/XP with portalk, you can't use cli
if not OSIsNT then asm cli end;

Fin:=False;
repeat
   asm
   push dx
   push bx
   push ax

   mov  dx,$378
   inc  dx
@loop1:

   mov ecx,LocalDelai
@bl1:
   in   al,dx
   dec ecx
   jne @bl1

   mov  bh,al
   and  al,80h
   jz   @loop1

   mov  al,bh
   and  al,40h
   mov  Synchro,al
   and  bh,30h

   inc  dx
   mov  al,00000100b
   out  dx,al

   dec  dx

   mov ecx,LocalDelai
@bl2:
   in   al,dx
   dec ecx
   jne @bl2

   mov  cl,4
   shr  al,cl
   add  bh,al

   inc  dx
   mov  al,00000000b
   out  dx,al
   dec  dx

   mov ecx,LocalDelai
@bl3:
   in   al,dx
   dec ecx
   jne @bl3

   mov  cl,4
   shr  al,cl
   mov  bl,al

   inc  dx
   mov  al,00001010b
   out  dx,al
   dec  dx

   mov ecx,LocalDelai
@bl4:
   in   al,dx
   dec ecx
   jne @bl4

   and  al,0F0h
   add  bl,al

   inc  dx
   mov  al,00001110b
   out  dx,al

   xor  bx,888h
   mov  Pixel,bx
   inc  CountPixel

   dec  dx

   mov ecx,LocalDelai
@bl5:
   in   al,dx
   dec ecx
   jne @bl5

@loop2:
   in   al,dx
   and  al,80h
   jnz  @loop2

   inc  dx
   mov  al,00001100b
   out  dx,al

   pop ax
   pop bx
   pop dx
   end;

 Line[CountPixel]:=Pixel;
 if CountPixel>=Sx then
    begin
    Inc(CountLine);
    for i:=1 to Sx do TabImgInt^[1]^[CountLine]^[i]:=Line[i];
    if CountLine>=Sy then
       begin
       Fin:=True;
       end;
    CountPixel:=0;
    end;
until Fin;

// You can now call the TeleAuto function giving precise hour
// TeleAuto will correct this time to save the middle exposure time in the image file
// Here you save the end of the exposure to give it to TeleAuto later
GetHour(YearEnd,MonthEnd,DayEnd,HourEnd,MinEnd,SecEnd,MSecEnd);

// If TeleAuto is used under NT/2000/XP with portalk, you can't use sti
if not OSiSNT then asm sti end;
end;

// Replace PluginGetCCDDate / New in Version 2.8
procedure PluginGetCCDDateBegin(var Year,Month,Day:Word); cdecl;
// Here you must provide the date of the begin of the exposure
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

// Replace PluginGetCCDTime / New in Version 2.8
procedure PluginGetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); cdecl;
// Here you must provide the time of the begin of the exposure
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

// New in Version 2.8
procedure PluginGetCCDDateEnd(var Year,Month,Day:Word); cdecl;
// Here you must provide the date of the end of the exposure
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

// New in Version 2.8
procedure PluginGetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); cdecl;
// Here you must provide the time of the end of the exposure
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
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
//Not used
end;

procedure PluginSetTemperature(TargetTemperature:Double); cdecl;
// Here you send the setpoint temperature TargetTemperature provided by TeleAuto
// to the CCD camera
begin
//Not used
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
//Not used
end;

procedure PluginAmpliOff; cdecl;
// Here you put the code to switch off the CCD output amplifier if needed
begin
//Not used
end;

procedure PluginShutterOpen; cdecl;
// Here you put the code to open the CCD shutter if needed
begin
//Not used ih this driver
end;

procedure PluginShutterClosed; cdecl;
// Here you put the code to close the CCD shutter if needed
begin
//Not used ih this driver
end;

procedure PluginShutterSynchro; cdecl;
// Here you put the code to synchronise the CCD shutter with the exposure if needed
begin
//Not used ih this driver
end;

function PluginGetName:PChar; cdecl;
// Here you must provide then name of then camera
begin
Result:='Hisis 22 12 bits';
end;

function PluginGetSaturationLevel:Integer; cdecl;
// Here you must provide the saturation level of youy camera
begin
Result:=4096;
end;

function PluginGetXPixelSize:Double; cdecl;
// Here you must provide x size of the CCD chip pixel
begin
Result:=9;
end;

function PluginGetYPixelSize:Double; cdecl;
// Here you must provide y size of the CCD chip pixel
begin
Result:=9;
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
begin
if (Binning=1) or (Binning=2) or (Binning=4) then Result:=True // To modify
else Result:=False;
end;

function PluginHasTemperature:Boolean; cdecl;
// Here you must return true if CCD camera has CCD chip temperature information
begin
Result:=False;
end;

function PluginCanCutAmpli:Boolean; cdecl;
// Here you can return true output amplifier of the CCD camera can be cut during
// exposure
begin
Result:=False;
end;

function PluginGetDelayToSwitchOffAmpli:Double; cdecl;
// Here you return the delay between the beginning of the exposure and the
// switch off of the output of the amplifier in seconds
begin
// Not used
end;

function PluginGetDelayToSwitchOnAmpli:Double; cdecl;
// Here you return the delay the switch on of the output of the amplifier
// and the end of the exposure in seconds
begin
// Not used
end;

function PluginNeedEmptyingDelay:Boolean; cdecl;
// Here you return true if you need to know the emptying delay of the CCD camera
// provided by the user
begin
Result:=True;
end;

function PluginNeedReadingDelay:Boolean; cdecl;
// Here you return true if you need to know the reading delay of the CCD camera
// provided by the user
begin
Result:=True;
end;

function PluginNeedCloseShutterDelay:Boolean; cdecl;
// Here you return true if you need to know the closing delay of the shuetter
// provided by the user
begin
Result:=False;
end;

function PluginHasAShutter:Boolean; cdecl;
// Here you return true if the CCD has a shutter
begin
Result:=False; // Shutter not used in this driver
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
PluginGetCCDDateBegin,
PluginGetCCDTimeBegin,
PluginGetCCDDateEnd,
PluginGetCCDTimeEnd,
PluginSetHourServer,
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
