library PluginSCR1300xtc;
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

{
 Plugin DLL pour caméra SCR1300xtc sur port //
 Usage réservé à Teleauto

 IMPORTANT : Code expérimental et non garanti (pour toutes les unités)

 Nécessite : scr1300xtc.dll

 -------------------------------------------------------------------------------
 Le plugin est livré "comme tel", il contient sûrement des bugs
 mais des tests sur matériel sont indispensables pour finaliser
 le code.

 Avant de commencer les tests, pointer un objet fixe faites la mise au point
 à l'aide du logiciel fourni avec la caméra. Puis lancer Teleauto.

 Les tests doivent être faits de jour de préférence.

Test conversion couleur :

 Aux fins de tests, un mode debug est possible, il suffit
 d'appeler la fonction PluginSetDebug. Cette fonction
 désactive la transformation de l'image au format natif en format RGB Classique.
 Mais elle permet d'avoir une image brute sauvegardée au format CFA RGB.

 Pour les tous premiers tests, activer cette fonction puis si l'image peut
 être sauvegardée, désactiver le mode debug.

 Pour désactiver appeler PluginUnsetDebug.

 Pour tester uniquement la conversion couleur sans tester l'acquisition :

 1) créer un fichier testcfa.pic contenant une image colorée au format natif de la scr1300xtc
 et au binning 1x1
 2) mettre un  DEFINE DEBUG dans ce fichier et dans CFAColor.pas
 3) vous aurez un fichier bmp testcfa.bmp
 4) lancer une fausse acquisition dans TA


 A FAIRE :
 Prévoir une fiche de dialogue

}

// {$DEFINE DEBUG}

{$IFDEF MSWINDOWS}
 uses
  SysUtils,
  Windows,
  CFAColor in 'CFAColor.pas';

 function Initialize(lpt,delay:integer):integer;cdecl;external 'scr1300xtc.dll';
 function Integrate(nbx,nby,bin,posX,posY:integer;pause_s:single;gain,offset:integer):integer;cdecl;external 'scr1300xtc.dll';
 function ReadImage(pixels:PWord):integer;cdecl;external 'scr1300xtc.dll';
 procedure AbortReading;cdecl;external 'scr1300xtc.dll';
 procedure SetCLISTI(value:boolean);cdecl;external 'scr1300xtc.dll';
{$ENDIF}
{$IFDEF LINUX}
 uses Libc,SysUtils;

 function Initialize(lpt,delay:integer):integer;cdecl;external 'libscr1300xtc.so';
 function Integrate(nbx,nby,bin,posX,posY:integer;pause_s:single;gain,offset:integer):integer;cdecl;external 'libscr1300xtc.so';
 function ReadImage(pixels:PWord):integer;cdecl;external 'libscr1300xtc.so';
 procedure AbortReading;cdecl;external 'libscr1300xtc.so';
 procedure SetCLISTI(value:boolean);cdecl;external 'libscr1300xtc.so';
{$ENDIF}

type
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
  DateTimeBegin:TDateTime;       // The time of the expose begining
  DateTimeEnd:TDateTime;         // The time of the expose begining
  DateTime:TDateTime;
  PCMinusUT:Double;              // Difference hour PC minus hour UT
  OSiSNT:Boolean;                // Ta is used under NT ?

  // Variables used in this driver
  YearBegin,MonthBegin,DayBegin,HourBegin,MinBegin,SecBegin,MSecBegin:Word;
  YearEnd,MonthEnd,DayEnd,HourEnd,MinEnd,SecEnd,MSecEnd:Word;

  // scr1300xt
  XTImage:pointer;
  XTAmpli:integer;
  XTOffset:integer;
  HWBaseTime:integer;
  connected:boolean;

  //pour DEBUG
  indexraw:integer;
  imgraw:file;
  RDebug:boolean;

//Gestion du temps

{$IFDEF MSWINDOWS}
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
{$ENDIF}
{$IFDEF LINUX}
function GetRealDateTime:TDateTime;
begin
 result:=Now;
end;
{$ENDIF}


procedure PluginGetCCDDateBegin(var Year,Month,Day:Word); cdecl;
begin
 DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure PluginGetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); cdecl;
begin
 DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure PluginGetCCDDateEnd(var Year,Month,Day:Word); cdecl;
begin
 DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure PluginGetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); cdecl;
begin
 DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

procedure PluginSetHourServer(ServerAdress:Pointer); cdecl;
begin
 @GetHour:=ServerAdress;
end;

procedure PluginSetPCMinusUT(_PCMinusUT:Double); cdecl;
begin
 PCMinusUT:=_PCMinusUT;
end;

//Gestion de la caméra

function PluginGetXSize:Integer; cdecl;
begin
 Result:=1280;
end;

function PluginGetYSize:Integer; cdecl;
begin
 Result:=1024;
end;

procedure PluginSetPort(_Adress:Word); cdecl;
begin
 Adress:=_Adress;
end;

function PluginSetWindow(_x1,_y1,_x2,_y2:Integer):Boolean; cdecl;
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
begin
{$IFDEF DEBUG}
 binning:=1;
 result:=true;
 exit;
{$ENDIF}
if (_Binning=1) or (_Binning=2) { or (_Binning=4) or (_Binning=8) } then
   begin
   Binning:=_Binning;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetPose(_Pose:Double):Boolean; cdecl;
begin
 Result:=false;
 if _Pose < 0 then exit;
 if (_Pose * HWBaseTime) < 0.001 then Pose:=0.001;
 if (_Pose * HWBaseTime) > 16383 then Pose:=16383;
 Result:=True;
end;

//A REVOIR
procedure SetHWDelay(tps:integer);cdecl;
begin
 HWBaseTime:=tps;
end;

function GetBaseTime:integer;
begin
 result:=1;
end;

function PluginIsConnectedAndOK:Boolean; cdecl;
begin
 result:=false;
 HWBaseTime:=GetBaseTime;
 if HWBaseTime=0 then exit;
{$IFDEF DEBUG}
 if connected=false then getmem(XTimage,1280 * 1024 * 2);
 if XTimage=NIL then exit;
 connected:=true;
 result:=true;
 exit;
{$ENDIF}
 if (initialize(Adress,HWBaseTime) = 0) then
  begin
   if connected=false then getmem(XTimage,1280 * 1024 * 2);
   if XTimage=NIL then exit;
   connected:=true;
   result:=true;
  end;
end;

function PluginStartPose:Boolean; cdecl;
begin
 Sx:=(x2-x1+1) div Binning;
 Sy:=(y2-y1+1) div Binning;
{$IFDEF DEBUG}
 Result:=true;
 exit;
{$ENDIF}
 Integrate(1280,1024,binning,0,0,pose,XTAmpli,XTOffset);
 GetHour(YearBegin,MonthBegin,DayBegin,HourBegin,MinBegin,SecBegin,MSecBegin);
 Result:=true;
end;

function PluginStopPose:Boolean; cdecl;
begin
 Result:=False;
end;

procedure QuickErase;assembler;stdcall;
asm
 push edi
 push eax
 push ecx
 mov edi,XTImage
 mov ecx,50000h
 xor eax,eax
 rep stosd
 pop ecx
 pop eax
 pop edi
end;

{$IFDEF DEBUG}
procedure LoadTestImg;
begin
 assignfile(imgraw,'testcfa.pic');
{$I-}
 reset(imgraw,1);
{$I+}
 if ioresult <> 0 then exit;
 seek(imgraw,290);
 blockread(imgraw,XTImage^,1280 * 1024 * 2);
 closefile(imgraw);
end;
{$ENDIF}

function PluginReadCCD(TabImgInt:PTabImgInt;ImgSx,ImgSy:Integer):Boolean; cdecl;
var
 RCode:integer;
 StiCli:boolean;
begin
 Result:=true;
 if OSisNT then SetCLISTI(false) else SetCLISTI(true);
 QuickErase;
{$IFDEF DEBUG}
 LoadTestImg;
 RCode:=0;
{$ELSE}
 RCode:=ReadImage(XTimage);
{$ENDIF}
//Si erreur renvoie une image noire
 if RCode <> 0 then
  begin
   Result:=False;
   exit;
  end;
{$IFDEF DEBUG}
 if (binning <> 1) then exit;
 if (RDebug=true) then
  begin
   assign(ImgRAW,'xtc1310'+ inttostr(indexraw) + '.raw');
{$I-}
   rewrite(ImgRAW,1);
{$I+}
   if ioresult <> 0 then exit;
   CFA_CMY2RGB(XTimage,1280,1024);
   blockwrite(ImgRAW,XTimage^,1280 * 1024 *2);
   closefile(ImgRAW);
  end
 else
  CMYCFA2Color(XTImage,TabImgInt,1280,1024);
{$ELSE}
 if (RDebug=true) then
  begin
   assign(ImgRAW,'xtc1310'+ inttostr(indexraw) + '.raw');
{$I-}
   rewrite(ImgRAW,1);
{$I+}
   if ioresult <> 0 then exit;
   CFA_CMY2RGB(XTimage,1280,1024);
   blockwrite(ImgRAW,XTimage^,1280 * 1024 *2);
   closefile(ImgRAW);
  end
 else
  CMYCFA2Color(XTImage,TabImgInt,ImgSx,ImgSy);
{$ENDIF}
 GetHour(YearEnd,MonthEnd,DayEnd,HourEnd,MinEnd,SecEnd,MSecEnd);
end;


procedure PluginStopRead;
begin
 AbortReading;
end;

function PluginSetAmpli(gain:integer):boolean;
begin
  if gain < 0 then gain:=0;
 if gain > 63 then gain:=63;
 XTampli:=gain;
 result:=true;
end;

function PluginSetOffset(offset:integer):boolean;
begin
 if Offset < 0 then Offset:=0;
 if Offset > 32 then Offset:=32;
 XTOffset:=Offset;
 result:=true;
end;

procedure PluginAmpliOn; cdecl;
begin
 XTampli:=1;
end;

procedure PluginAmpliOff; cdecl;
begin
 XTampli:=0;
end;

function PluginGetName:PChar; cdecl;
begin
 Result:='PlugIn Synonyme scr1300xtc';
end;

function PluginGetSaturationLevel:Integer; cdecl;
begin
 Result:=1024;
end;

function PluginGetXPixelSize:Double; cdecl;
begin
 Result:=6;
end;

function PluginGetYPixelSize:Double; cdecl;
begin
 Result:=6;
end;

function PluginGetNbplans:Integer; cdecl;
begin
 Result:=3;
end;

function PluginGetTypeData:Integer; cdecl;
// Here you must provide the image data type :
// 2 for single plane 16 bits integer.
// 7 for three plane color image with 16 bits integer each plane.
begin
 Result:=7;
end;

function PluginIsAValidBinning(Binning:Byte):Boolean; cdecl;
begin
 case Binning of
  1,2{,4,8}:Result:=True;
 else
  Result:=False;
 end;
end;

function PluginHasTemperature:Boolean; cdecl;
begin
 Result:=False;
end;

function PluginCanCutAmpli:Boolean; cdecl;
begin
 Result:=True;
end;

function PluginNeedEmptyingDelay:Boolean; cdecl;
begin
 Result:=False;
end;

function PluginNeedReadingDelay:Boolean; cdecl;
begin
 Result:=False;
end;

function PluginHasAShutter:Boolean; cdecl;
begin
 Result:=False;
end;


procedure PluginIsUsedUnderNT; cdecl;
begin
 OSiSNT:=True;
end;


procedure PluginIsNotUsedUnderNT; cdecl;
begin
 OSiSNT:=False;
end;

{ Fonctions inutiles }

function PluginNeedCloseShutterDelay:Boolean; cdecl;
begin
 result:=false;
end;

function PluginSetEmptyingDelay(_EmptyingDelay:Double):Boolean; cdecl;
begin
 result:=false;
end;

function PluginSetReadingDelay(_ReadingDelay:Double):Boolean; cdecl;
begin
 result:=false;
end;

function PluginGetDelayToSwitchOffAmpli:Double; cdecl;
begin
 result:=0;
end;

function PluginGetDelayToSwitchOnAmpli:Double; cdecl;
begin
 result:=0;
end;

function PluginGetTemperature:Double; cdecl;
begin
 result:=0;
end;

procedure PluginSetTemperature(TargetTemperature:Double); cdecl;
begin
end;

procedure PluginShutterOpen; cdecl;
begin
end;

procedure PluginShutterClosed; cdecl;
begin
end;


procedure PluginShutterSynchro; cdecl;
begin
end;

function PluginSetShutterCloseDelay(Delay:Double):Boolean; cdecl;
begin
 result:=false;
end;

function PluginIs16Bits:boolean;cdecl;
begin
 result:=false;
end;

function PluginOpen:Boolean; cdecl;
begin
Result:=True;
end;

procedure PluginClose; cdecl;
begin
 if XTImage <> NIL then freemem(XTImage);
end;

procedure PluginSetDebug;cdecl;
begin
 rdebug:=true;
end;

procedure PluginUnsetDebug;cdecl;
begin
 rdebug:=false;
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
PluginShowCfgWindow,

//nouvelles fonctions scr1300xt
PluginSetAmpli,
PluginSetOffset,
SetHWDelay,
PluginStopRead,
//pour débogage
PluginSetDebug,
PluginUnsetDebug;


begin
 XTImage:=NIL;
 connected:=false;
 indexraw:=0;
 RDebug:=false;
 MessageBox(0,'En mode debug, vous aurez une image CFA RGB Bayer','Information plugin scr1300xtc',MB_ICONINFORMATION);
end.







