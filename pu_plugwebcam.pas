unit pu_plugwebcam;

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
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Videocap, vfw, inifiles;

type
  Tpop_plugwebcam = class(TForm)
    MainMenu1: TMainMenu;
    VideoSource1: TMenuItem;
    VideoFormat1: TMenuItem;
    SelectDriver1: TMenuItem;
    VideoCap1: TVideoCap;
    Color1: TMenuItem;
    Options1: TMenuItem;
    AutoConnect1: TMenuItem;
    Preview1: TMenuItem;
    procedure SelectDriver1Click(Sender: TObject);
    procedure VideoSource1Click(Sender: TObject);
    procedure VideoFormat1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Color1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AutoConnect1Click(Sender: TObject);
    procedure Preview1Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  public
    { Déclarations publiques }
  end;

type
  TLigInt=array[1..999999] of SmallInt;
  PLigInt=^TLigInt;
  TImgInt=array[1..999999] of PLigInt;
  PImgInt=^TImgInt;
  TTabImgInt=array[1..255] of PImgInt;
  PTabImgInt=^TTabImgInt;
  TGetHour = procedure (var Year,Month,Day,Hour,Min,Sec,MSec:Word);

var
  // TeleAuto function giving precise hour // New in version 2.8
  GetHour:TGetHour;
  HourServerAvailable:boolean = false;

function PluginGetXSize:Integer; cdecl;
function PluginGetYSize:Integer; cdecl;
procedure PluginSetPort(_Adress:Word); cdecl;
function PluginSetWindow(_x1,_y1,_x2,_y2:Integer):Boolean; cdecl;
function PluginSetBinning(_Binning:Integer):Boolean; cdecl;
procedure PluginSetPCMinusUT(_PCMinusUT:Double); cdecl;
procedure PluginSetHourServer(ServerAdress:Pointer); cdecl;
function PluginSetPose(_Pose:Double):Boolean; cdecl;
function PluginSetEmptyingDelay(_EmptyingDelay:Double):Boolean; cdecl;
function PluginSetReadingDelay(_ReadingDelay:Double):Boolean; cdecl;
function PluginSetShutterCloseDelay(Delay:Double):Boolean; cdecl;
function PluginIsConnectedAndOK:Boolean; cdecl;
function PluginOpen:Boolean; cdecl;
procedure PluginClose; cdecl;
function PluginStartPose:Boolean; cdecl;
function PluginStopPose:Boolean; cdecl;
function PluginReadCCD(TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; cdecl;
procedure PluginGetCCDDateBegin(var Year,Month,Day:Word); cdecl;
procedure PluginGetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); cdecl;
procedure PluginGetCCDDateEnd(var Year,Month,Day:Word); cdecl;
procedure PluginGetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); cdecl;
function PluginGetTemperature:Double; cdecl;
procedure PluginSetTemperature(TargetTemperature:Double); cdecl;
procedure PluginAmpliOn; cdecl;
procedure PluginAmpliOff; cdecl;
procedure PluginShutterOpen; cdecl;
procedure PluginShutterClosed; cdecl;
procedure PluginShutterSynchro; cdecl;
function PluginGetName:PChar; cdecl;
function PluginGetSaturationLevel:Integer; cdecl;
function PluginGetXPixelSize:Double; cdecl;
function PluginGetYPixelSize:Double; cdecl;
function PluginGetNbplans:Integer; cdecl;
function PluginGetTypeData:Integer; cdecl;
function PluginIsAValidBinning(Binning:Byte):Boolean; cdecl;
function PluginHasTemperature:Boolean; cdecl;
function PluginCanCutAmpli:Boolean; cdecl;
function PluginGetDelayToSwitchOffAmpli:Double; cdecl;
function PluginGetDelayToSwitchOnAmpli:Double; cdecl;
function PluginNeedEmptyingDelay:Boolean; cdecl;
function PluginNeedReadingDelay:Boolean; cdecl;
function PluginNeedCloseShutterDelay:Boolean; cdecl;
function PluginHasAShutter:Boolean; cdecl;
procedure PluginIsNotUsedUnderNT; cdecl;
procedure PluginIsUsedUnderNT; cdecl;
function PluginIs16Bits:Boolean; cdecl;
function PluginHasCfgWindow:Boolean; cdecl;
function PluginShowCfgWindow:Boolean; cdecl;

function FrameCallback(hWd: HWnd; lpVHDR: PVideoHdr): DWord; stdcall;
procedure LoadConfig;

var
  pop_plugwebcam: Tpop_plugwebcam;

implementation

uses pu_webcamselect;

{$R *.DFM}

var
// Variables provided by the TeleAuto user to setup the CD camera
    Adress:Word;                   // The adress of the paralel port used by the camera
    x1,y1,x2,y2:Integer;           // The window to acquire in equivalent binning 1x1
    Binning:Integer;               // Binning used
    Pose:Double;                   // The pose in seconds
    EmptyingDelay:Double;          // Delay needed to empty the CCD (Hisis cameras)
    ReadingDelay:Double;           // Reading delay (Hisis cameras)
    ShutterCloseDelay:Double;      // Closing delay of the shutter
    PCMinusUT:Double;              // Difference hour PC minus hour UT
    OSiSNT:Boolean;                // Ta is used under NT ?

// Variables used in this driver
    YearBegin,MonthBegin,DayBegin,HourBegin,MinBegin,SecBegin,MSecBegin:Word;
    YearEnd,MonthEnd,DayEnd,HourEnd,MinEnd,SecEnd,MSecEnd:Word;

// webcam variables
  FrIma : Tbitmap;
  FrInf : TBitmapInfo;
  LPstatus,LPrate,vestaquality : integer;
  Sx, Sy, webcam_sx, webcam_sy : integer;
  Multithread, webcamcolor, LockClose : boolean;
  debutpose : Tdatetime;
  UToffset : double;
  appdir : string;
  VestaSCTop,VestaSCLeft,VestaSCWidth,VestaSCHeight,Driver : Integer;
  AutoConnectOn,PreviewOn : Boolean;

//////////////////////////////////////////
//      Vesta SC functions
//////////////////////////////////////////

Procedure StartVestaLP;
begin
with pop_plugwebcam do begin
  Videocap1.PreviewRate:=1000 div LPrate;
  videocap1.Yield:=Multithread;
  videocap1.abortkey:=0;
  if HourServerAvailable then GetHour(YearBegin,MonthBegin,DayBegin,HourBegin,MinBegin,SecBegin,MSecBegin)
                         else begin Decodetime(now-utoffset,HourBegin,MinBegin,SecBegin,MSecBegin);
                                    Decodedate(now-utoffset,YearBegin,MonthBegin,DayBegin);
                              end;
  debutpose:=now;
  LPstatus:=1;
  VideoCap1.VideoPreview:=true;
end;
end;

//////////////////////////////////////////
//      fonction Binning copiée de u_geometrie
//      + seulement entier
//      + passage de l'image de sortie pour eviter les recopies
//      + ne pas modifier sx sy
//////////////////////////////////////////

procedure Bin(var ImgIntIn,ImgInt :PTabImgInt;
                  Sx,Sy:Integer;
                  TypeData,NbPlans:Byte;
                  BinningX,BinningY:Integer);
var
//ImgInt:PTabImgInt;
//ImgDouble:PTabImgDouble;
SxNew,SyNew,i,j,k,l,m:Integer;
Somme:Double;
begin
SxNew:=Sx div BinningX;
SyNew:=Sy div BinningY;
for m:=1 to NbPlans do
   for j:=1 to SyNew do
      begin
      case TypeData of
         2,7:begin
             for i:=1 to SxNew do
                begin
                Somme:=0;
                for k:=1 to BinningY do
                   for l:=1 to BinningX do
                      Somme:=Somme+ImgIntIn^[m]^[(j-1)*BinningY+k]^[(i-1)*BinningX+l];
                Somme:=Somme/BinningY/BinningX;
                if Somme>32767 then Somme:=32767;
                if Somme<-32768 then Somme:=-32768;
                ImgInt^[m]^[j]^[i]:=Round(Somme);
                end;
             end;
         end;
      end;
end;

//////////////////////////////////////////
//      Plugin functions
//////////////////////////////////////////

function PluginGetXSize:Integer; cdecl;
// Here you must provide x size then CCD chip in pixels
begin
Result:=webcam_sx;
end;

function PluginGetYSize:Integer; cdecl;
// Here you must provide y size then CCD chip in pixels
begin
Result:=webcam_sy;
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
if (_Binning=1) or (_Binning=2) or (_Binning=4) then
   begin
   Binning:=_Binning;
   Result:=True;
   end
else Result:=False;
end;

procedure PluginSetPCMinusUT(_PCMinusUT:Double); cdecl;
// Here you get the difference between the hour of the PC and the UT hour
// You an use this value to correct the PC date and hour before to give it to TeleAuto
begin
PCMinusUT:=_PCMinusUT;
UToffset:=PCMinusUT/24;
end;

function PluginSetPose(_Pose:Double):Boolean; cdecl;
// The pose to use for the exposure in seconds
begin
if (_Pose>0) and (_Pose<99999) then
   begin
   Pose:=_Pose;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetEmptyingDelay(_EmptyingDelay:Double):Boolean; cdecl;
// The time taken to empty the CCD chip
begin
if (_EmptyingDelay>0) then
   begin
   EmptyingDelay:=_EmptyingDelay;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetReadingDelay(_ReadingDelay:Double):Boolean; cdecl;
// The readign delay to slow down the // port speed (Hisis 22)
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
Result:=pop_plugwebcam.VideoCap1.DriverOpen;
end;

function PluginOpen:Boolean; cdecl;
// Here you must put the instruction needed to initialise the CCD camera before to use it
// This procedure is used only when connecting the CCD camera to TeleAuto
begin
Result:=True;
LockClose:=true;
if pop_plugwebcam=nil then pop_plugwebcam:=Tpop_plugwebcam.Create(nil);
if FrIma=nil then FrIma:=TBitmap.create;
if not pop_plugwebcam.videocap1.driveropen then pop_plugwebcam.SelectDriver1Click(pop_plugwebcam);
pop_plugwebcam.Show;
end;

procedure PluginClose; cdecl;
// Here you must put the instruction needed to close the CCD camera after using it
// This procedure is used only when closing TeleAuto
begin
pop_plugwebcam.VideoCap1.DriverOpen:=false;
if not LockClose then exit;
LockClose:=false;
pop_plugwebcam.Close;
end;

function PluginStartPose:Boolean; cdecl;
// Here you must put the instruction needed to start the pose
// The variables to uses here are
//    Adress:Word;
//    x1,y1,x2,y2:Integer;
//    Sx,Sy:Integer;
//    Pose:Double;
//    Binning:Integer;
// Return true if everything is OK
begin
Sx:=(x2-x1+binning) div Binning;
Sy:=(y2-y1+binning) div Binning;
StartVestaLP;
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
// You must not allocate memory because the TabImgInt it is already done in TeleAuto
// Return true if everything is OK
var
   i,j,k :Integer;
   p : PByteArray;
   value,r,g,b,sx1,sy1,td,nbp : integer;
   ImgInt : PtabImgInt;
   timeout: Tdatetime;
begin
Result:=True;
timeout:=now+0.00006; // ~5 sec.
while LPstatus<>5 do begin
      application.processmessages;
      if now>timeout then begin
         result:=false;
         exit;
      end;
end;
LPstatus:=0;
pop_plugwebcam.Videocap1.PreviewRate:=1;
pop_plugwebcam.VideoCap1.VideoPreview:=pop_plugwebcam.Preview1.checked;
if binning=1 then begin
// sans binning
sx1:=ImgSx;
if sx1>webcam_sx then sx1:=webcam_sx;
sy1:=ImgSy;
if sy1>webcam_sy then sy1:=webcam_sy;
for i:=1 to Sy1 do
   begin
      p:=FrIma.scanline[webcam_sy - y1 - i + 1];
      for j:=1 to Sx1 do
          begin
          if webcamcolor then begin
             b:=P[3*(x1+j-2)];
             g:=P[3*(x1+j-2)+1];
             r:=P[3*(x1+j-2)+2];
             TabImgInt^[1]^[i]^[j]:= r;
             TabImgInt^[2]^[i]^[j]:= g;
             TabImgInt^[3]^[i]^[j]:= b;
          end else begin
             value:=(P[3*(x1+j-2)]+P[3*(x1+j-2)+1]+P[3*(x1+j-2)+2]) div 3;
             TabImgInt^[1]^[i]^[j]:= value;
          end;
          end;
   end;
end else begin
// avec binning
sx1:=ImgSx*binning;
if sx1>webcam_sx then sx1:=webcam_sx;
sy1:=ImgSy*binning;
if sy1>webcam_sy then sy1:=webcam_sy;
if WebCamColor then begin
  TD:=7;
  NbP:=3;
end else begin
  TD:=2;
  NbP:=1;
end;
Getmem(ImgInt,4*NbP);
for k:=1 to NbP do begin
 Getmem(ImgInt^[k],4*sy1);
 for i:=1 to sy1 do begin
    Getmem(ImgInt^[k]^[i],sx1*2);
//    for j:=1 to sx1 do ImgInt^[k]^[i]^[j]:=0;
 end;
end;
for i:=1 to sy1 do
   begin
      p:=FrIma.scanline[webcam_sy - y1 - i + 1];
      for j:=1 to sx1 do
          begin
          if webcamcolor then begin
             b:=P[3*(x1+j-2)];
             g:=P[3*(x1+j-2)+1];
             r:=P[3*(x1+j-2)+2];
             ImgInt^[1]^[i]^[j]:= r;
             ImgInt^[2]^[i]^[j]:= g;
             ImgInt^[3]^[i]^[j]:= b;
          end else begin
             value:=(P[3*(x1+j-2)]+P[3*(x1+j-2)+1]+P[3*(x1+j-2)+2]) div 3;
             ImgInt^[1]^[i]^[j]:= value;
          end;
          end;
   end;
// binning logiciel
Bin(ImgInt,TabImgInt,sx1,sy1,TD,NbP,Binning,Binning);
// libere l'image temporaire
for k:=1 to NbP do begin
  for i:=1 to sy1 do Freemem(ImgInt^[k]^[i],sx1*2);
  Freemem(ImgInt^[k],4*sy1);
end;
Freemem(ImgInt,4*NbP);
end;
end;

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

end;

procedure PluginShutterClosed; cdecl;
// Here you put the code to close the CCD shutter if needed
begin

end;

procedure PluginShutterSynchro; cdecl;
// Here you put the code to synchronise the CCD shutter with the exposure if needed
begin

end;

function PluginGetName:PChar; cdecl;
// Here you must provide then name of then camera
begin
Result:='Plugin-Webcam'; //nolang
end;

function PluginGetSaturationLevel:Integer; cdecl;
// Here you must provide the saturation level of youy camera
begin
Result:=255;
end;

function PluginGetXPixelSize:Double; cdecl;
// Here you must provide x size of the CCD chip pixel
begin
Result:=5.6;
end;

function PluginGetYPixelSize:Double; cdecl;
// Here you must provide y size of the CCD chip pixel
begin
Result:=5.6;
end;

function PluginGetNbplans:Integer; cdecl;
begin
if webcamcolor then Result:=3
               else Result:=1;
end;

function PluginGetTypeData:Integer; cdecl;
begin
if webcamcolor then Result:=7
               else Result:=2;
end;

function PluginIsAValidBinning(Binning:Byte):Boolean; cdecl;
// Here you must return true if the value of Binning is a valid binning value
begin
if (Binning=1) or (Binning=2) or (Binning=4) then Result:=True
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
Result:=true;
end;

function PluginGetDelayToSwitchOffAmpli:Double; cdecl;
// Here you return the delay between the beginning of the exposure and the
// switch off of the output of the amplifier in seconds
begin
Result:=9;
end;

function PluginGetDelayToSwitchOnAmpli:Double; cdecl;
// Here you return the delay the switch on of the output of the amplifier
// and the end of the exposure in seconds
begin
Result:=5;
end;

function PluginNeedEmptyingDelay:Boolean; cdecl;
// Here you return true if you need to know the emptying delay of the CCD camera
// provided by the user
begin
Result:=False;
end;

function PluginNeedReadingDelay:Boolean; cdecl;
// Here you return true if you need to know the reading delay of the CCD camera
// provided by the user
begin
Result:=False;
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
Result:=False;
end;

// New in version 2.96
function PluginIs16Bits:Boolean; cdecl;
// Here you return true if the CCD has a 16 bits ADC
begin
Result:=False; 
end;

procedure PluginSetHourServer(ServerAdress:Pointer); cdecl;
begin
// This is the adress of the TeleAuto function giving precise hour
@GetHour:=ServerAdress;
HourServerAvailable:=true;
end;

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


//////////////////////////////////////////
//      Form functions
//////////////////////////////////////////

function FrameCallback(hWd: HWnd; lpVHDR: PVideoHdr): DWord; stdcall;
begin
result:=1;
case LPstatus of
    1 : begin
         if now>=debutpose+pose/3600/24 then begin
            FrIma.Width := pop_plugwebcam.videocap1.CapWidth;
            FrIma.Height := pop_plugwebcam.videocap1.CapHeight;
            if HourServerAvailable then GetHour(YearEnd,MonthEnd,DayEnd,HourEnd,MinEnd,SecEnd,MSecEnd)
                           else begin Decodetime(now-utoffset,HourEnd,MinEnd,SecEnd,MSecEnd);
                                      Decodedate(now-utoffset,YearEnd,MonthEnd,DayEnd);
                                end;
            GetBitmap(Frima,lpVHDR);
            LPstatus:=5;
        end;
        end;
end;
//ExpTimer;
//Application.processmessages;
end;

Function GetUToffset : double;
var lt,st : TSystemTime;
begin
 GetLocalTime(lt);GetSystemTime(st);
 result:=round(24000000*(SystemTimeToDateTime(lt)-SystemTimeToDateTime(st)))/1000000;
end;

procedure Tpop_plugwebcam.SelectDriver1Click(Sender: TObject);
var DrvList:TStrings;
begin
if AutoconnectOn then begin
 VideoCap1.DriverOpen:= false;
 Videocap.CloseVideoInfo;
 VideoCap1.DriverOpen:= true;
 Videocap.CreateVideoInfo;
end else begin
 pop_WebcamSelect:=Tpop_WebcamSelect.Create(pop_plugwebcam);
 pop_WebcamSelect.Caption:='Webcam Capture Driver'; //nolang
 drvList:=  GetDriverList;
 pop_WebcamSelect.Combobox1.Items:= drvList;
 VideoCap1.DriverOpen:= false;
 Videocap.CloseVideoInfo;
 if  VideoCap1.DriverIndex >= 0 then pop_WebcamSelect.ComboBox1.Itemindex:= VideoCap1.DriverIndex
                                else pop_WebcamSelect.ComboBox1.Itemindex:=0;
 if pop_WebcamSelect.ShowModal = mrOK then
    begin
      videoCap1.DriverIndex:= pop_WebcamSelect.combobox1.ItemIndex;
      VideoCap1.DriverOpen:= true;
      Videocap.CreateVideoInfo;
      Driver:=videoCap1.DriverIndex;
    end;
 pop_WebcamSelect.Free;
 drvList.Clear;
 drvList.Free;
end;
LPstatus:=0;
Vestaquality:=1;
if VideoCap1.DriverOpen then begin
    capSetCallbackOnFrame(videocap1.hcapWnd, @FrameCallback);
    VideoCap1.Yield:=Multithread;
    FrInf:= VideoCap1.BitmapInfo;
    webcam_sx:=FrInf.bmiHeader.biWidth;
    webcam_sy:=FrInf.bmiHeader.biHeight;
    Videocap1.GetVideoFormat(VestaQuality,false);
    Videocap1.PreviewRate:=1;
    VideoCap1.VideoPreview:=PreviewOn;
    Videocap1.stopcapture;
end;
end;

procedure Tpop_plugwebcam.VideoSource1Click(Sender: TObject);
begin
 VideoCap1.DlgVSource;
 videocap1.GetVideoFormat(VestaQuality,false);
end;

procedure Tpop_plugwebcam.VideoFormat1Click(Sender: TObject);
begin
 videoCap1.DlgVFormat;
 videocap1.GetVideoFormat(VestaQuality,false);
 FrInf:= VideoCap1.BitmapInfo;
 webcam_sx:=FrInf.bmiHeader.biWidth;
 webcam_sy:=FrInf.bmiHeader.biHeight;
end;

procedure Tpop_plugwebcam.FormCreate(Sender: TObject);
begin
decimalseparator:='.';
appdir:=getcurrentdir;
FrIma:=TBitmap.create;
FrIma.PixelFormat:=pf24bit;
chdir(appdir);
VideoCap1.Driverindex:=Driver;
Color1.Checked:=Webcamcolor;
Preview1.Checked:=PreviewOn;
AutoConnect1.Checked:=AutoconnectOn;
UToffset:=0;
//UToffset:=GetUToffset / 24;
end;

procedure Tpop_plugwebcam.FormDestroy(Sender: TObject);
begin
Frima.free;
end;

procedure Tpop_plugwebcam.WMMove(var Message: TWMMove);
begin
  inherited;
  // after move of form
  if videocap1<>nil then videocap1.resetcap;
end;

procedure Tpop_plugwebcam.WMSize(var Message: TWMSize);
begin
  inherited;
  // after size
  if LockClose and (message.SizeType=SIZE_MINIMIZED) then pop_plugwebcam.windowstate:=wsNormal;
end;

procedure Tpop_plugwebcam.Color1Click(Sender: TObject);
begin
Color1.Checked:= not Color1.Checked;
webcamcolor:=Color1.Checked;
end;

procedure Tpop_plugwebcam.FormClose(Sender: TObject; var Action: TCloseAction);
var ini:TInifile;
begin
If LockClose then begin
   Action:=caNone;
   pop_plugwebcam.Height:=80;
   pop_plugwebcam.Width:=100;
end else begin
   Action:=caHide;
   chdir(appdir);
   ini:= TInifile.Create('.\plugwebcam.ini'); //nolang
   ini.writeInteger('Options','index',videoCap1.Driverindex); //nolang
   ini.writebool('Options','MultiThread',MultiThread); //nolang
   ini.writebool('Options','Color',Color1.Checked); //nolang
   ini.writebool('Options','Preview',Preview1.Checked); //nolang
   ini.writebool('Options','AutoConnect',AutoConnect1.Checked); //nolang
   ini.writeinteger('Options','Rate',LPrate); //nolang
   ini.writeinteger('Options','Top',pop_plugwebcam.Top); //nolang
   ini.writeinteger('Options','Left',pop_plugwebcam.Left); //nolang
   ini.writeinteger('Options','Width',pop_plugwebcam.Width); //nolang
   ini.writeinteger('Options','Height',pop_plugwebcam.Height); //nolang
   ini.free;
end;
end;

procedure Tpop_plugwebcam.AutoConnect1Click(Sender: TObject);
begin
AutoConnect1.Checked:= not AutoConnect1.Checked;
AutoconnectOn:=AutoConnect1.Checked;
end;

procedure Tpop_plugwebcam.Preview1Click(Sender: TObject);
begin
Preview1.Checked:= not Preview1.Checked;
PreviewOn:=Preview1.Checked;
VideoCap1.VideoPreview:=Preview1.checked;
end;

procedure Tpop_plugwebcam.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
if NewWidth<100 then Newwidth:=100;
if NewHeight<80 then Newheight:=80;
Resize:=true;
end;

procedure Tpop_plugwebcam.FormShow(Sender: TObject);
begin
pop_plugwebcam.Top:=VestaSCTop;
pop_plugwebcam.Left:=VestaSCLeft;
pop_plugwebcam.Width:=VestaSCWidth;
pop_plugwebcam.Height:=VestaSCHeight;
end;

procedure LoadConfig;
var ini:TInifile;
begin
ini:= TInifile.Create('.\plugwebcam.ini'); //nolang
Driver:=ini.readInteger('Options','index',-1); //nolang
MultiThread:=ini.readbool('Options','MultiThread',true); //nolang
WebcamColor:=ini.readbool('Options','Color',true); //nolang
PreviewOn:=ini.readbool('Options','Preview',false); //nolang
AutoConnectOn:=ini.readbool('Options','AutoConnect',false); //nolang
LPrate:=ini.readinteger('Options','Rate',100); //nolang
VestaSCTop:=ini.readinteger('Options','Top',70); //nolang
VestaSCLeft:=ini.readinteger('Options','Left',2); //nolang
VestaSCWidth:=ini.readinteger('Options','Width',140); //nolang
VestaSCHeight:=ini.readinteger('Options','Height',80); //nolang
ini.free;
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

end.
