unit pu_webcam;

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

{$UNDEF DEBUG}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Videocap, VFW, Buttons, ExtCtrls, math,
  u_class, pu_image,pu_rapport, ComCtrls, Editnbre, Spin, u_cameras;

type
  Tpop_webcam = class(TForm)
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    outLabel4: TLabel;
    outLabel5: TLabel;
    outLabel6: TLabel;
    Label8: TLabel;
    outLabel9: TLabel;
    VideoCap1: TVideoCap;
    Panel2: TPanel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    AVITimer: TTimer;
    Panel3: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    outComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label12: TLabel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    outComboBox2: TComboBox;
    GroupBox4: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    CheckBox1: TCheckBox;
    BitBtn7: TBitBtn;
    Edit1: TEdit;
    RadioGroup1: TRadioGroup;
    RadioGroup3: TRadioGroup;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    TabSheet3: TTabSheet;
    GroupBox5: TGroupBox;
    NomAVI: TEdit;
    SeqAVI: TSpinEdit;
    Nboucle: TSpinEdit;
    TempsAVI: TSpinEdit;
    BitBtn8: TBitBtn;
    Label13: TLabel;
    Label5: TLabel;
    Label19: TLabel;
    Label4: TLabel;
    WebCamTimer: TTimer;
    Label6: TLabel;
    outLabel10: TLabel;
    BitBtn9: TBitBtn;
    CheckBox5: TCheckBox;
    QCNB: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure outComboBox2Change(Sender: TObject);
    procedure WebCamTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure AVITimerTimer(Sender: TObject);
    procedure VideoCap1StatusCallback(Sender: TObject; nID: Integer;
      status: String);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn9Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure QCNBClick(Sender: TObject);
  private
    { Déclarations privées }
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
  public
    { Déclarations publiques }
  end;

Procedure StartCapture;
Procedure StopCapture;
Procedure StartAVI(avifile : string; exp : double) ;
Procedure StopAVI;
function ReadWebCam(TabImgInt:PTabImgInt;X1,Y1,X2,Y2,Bin,ImgSx,ImgSy:Integer; var dtend:Tdatetime):Boolean;
function StartWebcamAcquisition(x1,y1,x2,y2:Integer;Pose:Double;Bin:Integer;var DateTime:TDateTime):Boolean;
procedure WebcamAddImage;
function VideoStreamCallback(hWnd:Hwnd; lpVHdr:PVIDEOHDR):longint; stdcall;
function FrameCallback(hWnd: HWnd; lpVHDR: PVideoHdr): DWord; stdcall;

var
  pop_webcam: Tpop_webcam;
  webcam_x : integer = 2048;
  webcam_y : integer = 2048;
  webcam_color, webcam_sx, webcam_sy : integer;
  webcam_msframe,WebCam_NImage,WebCam_MaxImage,Webcam_NBdark,RealMsFrame : integer; //Webcamcumul_TypeData,WebCamCumul_NbPlans
  FrIma : Tbitmap;
  WebCamEnCours, WebCamAddEnCours, WebCam_Use_Videostream, AVIEnCours, AVIshowmenu : boolean;
  WebCamCumul: tpop_image;         // accumulation des images webcam
  WebCamDark,Webcamwork:  PTabImgInt;         // noir dynamique et image de travail pour les images webcam
  WebCam_UseDark, WebCamColor, WebcamPseudoTrack, WebcamShowCumul, isBwQc : Boolean;
  Webcam_arrdetections_A,Webcam_arrdetections_B:plistepsf;
  Webcam_ndetect_a,Webcam_ndetect_B, Webcam_ori_x, Webcam_ori_y, Webcam_OffsetError :integer;
  WebcamRapport:tpop_rapport;
  BtnAVIStart : boolean = true;

//******************************************************************************
//**************************         Camera Webcam        **********************
//******************************************************************************

type
  TCameraWebcam=class(TCamera)
    private
    public

    // Fonctionnement
    function  SetWindow(_x1,_y1,_x2,_y2:Integer):Boolean; override;
    function  SetBinning(_Binning:Integer):Boolean; override;
    function  SetPose(_Pose:Double):Boolean; override;
    function  CanStopNow:Boolean; override;
    procedure AdjustIntervalePose(var NbInterValCourant,NbSubImage : integer; Interval : integer); override;
    function  IsConnectedAndOK:Boolean; override;
    function  Open:Boolean; override;
    procedure Close; override;
    function  StartPose:Boolean; override;
    function  StopPose:Boolean; override;
    function  ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; override;
    procedure GetCCDDateBegin(var Year,Month,Day:Word); override;
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); override;
    procedure GetCCDDateEnd(var Year,Month,Day:Word); override;
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); override;
    procedure SetHourServer(ServerAdress:Pointer); override;    
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    function  ShowCfgWindow:Boolean; override;

    // Caracteristiques
    function GetName:PChar; override;
    function GetSaturationLevel:Integer; override;
    function GetXSize:Integer; override;
    function GetYSize:Integer; override;
    function GetXPixelSize:Double; override;
    function GetYPixelSize:Double; override;
    function GetTypeData:Integer; override;
    function GetNbPlans:Integer; override;
    function IsAValidBinning(Binning:Byte):Boolean; override;
    function HasTemperature:Boolean; override;
    function CanCutAmpli:Boolean; override;
    function NeedEmptyingDelay:Boolean; override;
    function NeedReadingDelay:Boolean; override;
    function NeedCloseShutterDelay:Boolean; override;
    function HasAShutter:Boolean; override;
    function ShowConfigPanel(IsModal:boolean):Boolean; override;
    function GetMinimalPose:double; override;
    function IsTrackCCD:Boolean; override;
    function NeedPixelSize:Boolean; override;
    function Is16Bits:Boolean; override;
    function HasCfgWindow:Boolean; override;
    end;

implementation

{$R *.DFM}

uses
     u_math,
     pu_main,
     u_general,
     u_analyse,
     clipbrd,
     u_file_io,
     u_constants,
     u_geometrie,
     u_modelisation,
     u_hour_servers,
     u_lang;

var
//  FrInf:TBitmapInfo;
  NbDark, CurDark, AVIexposure,Nombre : integer;
  AVIstarttime : double;
  dark_x, dark_y : integer;
  Acquisitiondark : boolean = false;
  WebCamTmp,WebCamTmpR,WebCamTmpG,WebCamTmpB:  PTabImgInt;         // image temporaire pour le dark
  workTypedata,workNbplans, winx1, winy1, winx2, winy2 : Integer;
  LockWebcamtimer,ProcessFrame : boolean;
  lastframedate : tdatetime;

const
  WebcamSatur=16387;  // valeur raisonable pour permettre des traitements
  WebCam_Timer_Interval = 50;

function secmsec:string;
begin
result:=formatdatetime('ss.zzz',now)+' '; //nolang
end;

//******************************************************************************
//   fonction de prise de vue webcam
//******************************************************************************

function StartWebcamAcquisition(x1,y1,x2,y2:Integer;Pose:Double;Bin:Integer;var DateTime:TDateTime):Boolean;
var i,j,k : integer;
begin
{$IFDEF DEBUG}  writespy(secmsec+'StartWebcamAcquisition'); {$ENDIF} //nolang

    if pop_webcam=nil then Application.CreateForm(Tpop_webcam, pop_webcam);
    if not pop_webcam.VideoCap1.DriverOpen then begin //1
        if pop_webcam.Visible then pop_webcam.Hide;
        if not pop_webcam.VideoCap1.DriverOpen then pop_webcam.showmodal;
        if not pop_webcam.VideoCap1.DriverOpen then begin //2
           result:=false;
           exit;
        end; //2
    end;   //1

    webcam_sx:=X2-X1+1;
    webcam_sy:=Y2-Y1+1;
    winx1:=minintvalue([x1,webcam_x-1]);
    winY1:=minintvalue([y1,webcam_y-1]);
    winX2:=minintvalue([x2,webcam_x]);
    winY2:=minintvalue([y2,webcam_y]);

    if (pop_webcam.RadioGroup1.ItemIndex=1)
       then WebCamColor:=true
       else WebCamColor:=false;

      // initialisation de l'image resultat avec mise a zero pour le cas ou
      // l'image demandee est plus grande que le format de la webcam
      // et initialisation de l'image cumul (obligatoire a cause du binning)
      if WebCamColor then begin  //1
         workTypedata:=7;
         workNbplans:=3;
         Getmem(webcamwork,12);
         for k:=1 to 3 do begin //2
         Getmem(webcamwork^[k],4*webcam_sy);
          for i:=1 to webcam_sy do begin //3
            Getmem(webcamwork^[k]^[i],webcam_sx*2);
          end; //3
         end; //2
      end //1
      else begin  //1
         workTypedata:=2;
         workNbplans:=1;
         Getmem(webcamwork,4);
         Getmem(webcamwork^[1],4*webcam_sy);
         for i:=1 to webcam_sy do begin //2
           Getmem(webcamwork^[1]^[i],webcam_sx*2);
         end;  //2
      end;  //1

    Webcam_MaxImage:=maxintvalue([1,Round(Pose*1000) div webcam_msframe]);

    // selon le nombre d'image a cumuler :
    WebcamShowCumul:=false;
    WebcamPseudoTrack:=false;
    if Webcam_MaxImage>1 then begin //1
     // image de cumul car plus d'une image
     // et initialisation de l'image cumul (obligatoire a cause du binning)
     if webcamcumul=nil then webcamcumul:=tpop_image.Create(Application)
     else if WebCamCumul.datadouble<>nil then begin //2
          // libere l'image cumul
          if WebCamCumul.ImgInfos.NbPlans=3 then begin //3
            for k:=1 to 3 do begin //4
                for i:=1 to WebCamCumul.ImgInfos.Sy do Freemem(WebCamCumul.datadouble^[k]^[i],WebCamCumul.ImgInfos.Sx*8);
                Freemem(WebCamCumul.datadouble^[k],4*WebCamCumul.ImgInfos.Sy);
            end; //4
            Freemem(WebCamCumul.datadouble,12);
          end else begin //3
            for i:=1 to WebCamCumul.ImgInfos.sy do Freemem(WebCamCumul.datadouble^[1]^[i],WebCamCumul.ImgInfos.sx*8);
            Freemem(WebCamCumul.datadouble^[1],4*WebCamCumul.ImgInfos.sy);
            Freemem(WebCamCumul.datadouble,4);
     end; //3
     end; //2
     webcamcumul.top:=70; // Sinon, la fenetre est trop haute et on peut pas la fermer
     webcamcumul.IsUsedForWebCam:=true;
     webcamcumul.bloque:=true;
     webcamcumul.caption:=lang('Pose Webcam en cours');
     // pour les petites poses de mise au point. il faudra aussi le supprimer en cas de vrai tracking lx200
     WebcamPseudoTrack:=(pop_webcam.radiogroup3.itemindex>0)and(bin=1) and (Pose>=2);
     WebcamShowCumul:= pop_webcam.checkbox4.checked and (Pose>=2);
     if WebCamColor then begin  //2
      WebCamCumul.ImgInfos.typedata:=8;
      WebCamCumul.ImgInfos.nbplans:=3;
      Webcamcumul.ImgInfos.sx:=webcam_sx;
      Webcamcumul.ImgInfos.sy:=webcam_sy;
      Getmem(WebCamCumul.datadouble,12);
      for k:=1 to 3 do begin //3
          Getmem(WebCamCumul.datadouble^[k],4*webcam_sy);
          for i:=1 to webcam_sy do begin  //4
              Getmem(WebCamCumul.datadouble^[k]^[i],webcam_sx*8);
              for j:=1 to webcam_sx do WebCamCumul.datadouble^[k]^[i]^[j]:=0;
          end;  //4
      end;  //3
     end //2
     else begin //2
       WebCamCumul.ImgInfos.typedata:=5;
       WebCamCumul.ImgInfos.nbplans:=1;
       Webcamcumul.ImgInfos.sx:=webcam_sx;
       Webcamcumul.ImgInfos.sy:=webcam_sy;
       Getmem(WebCamCumul.datadouble,4);
       Getmem(WebCamCumul.datadouble^[1],4*webcam_sy);
       for i:=1 to webcam_sy do begin //3
           Getmem(WebCamCumul.datadouble^[1]^[i],webcam_sx*8);
           for j:=1 to webcam_sx do WebCamCumul.datadouble^[1]^[i]^[j]:=0;
       end; //3
     end; //2
     if not WebcamShowCumul then webcamcumul.Windowstate:=wsMinimized
        else begin
         webcamcumul.top:=70; // Sinon, la fenetre est trop haute et on peut pas la fermer
         webcamcumul.left:=20;
         webcamcumul.Windowstate:=wsMinimized;
         if (WebcamRapport=nil)or(WebcamRapport.ListBox1=nil) then WebcamRapport:=tpop_rapport.Create(Application)
                              else WebcamRapport.ListBox1.clear;
         WebcamRapport.Show;
         WebcamRapport.Quitter.Enabled:=False;
         WebcamRapport.BitBtn1.Enabled:=False;
         WebcamRapport.BitBtn2.Enabled:=False;
         WebcamRapport.BitBtn3.Enabled:=True;
         WebcamRapport.caption:=lang('Rapport pose WebCam');
    end;

    end;  //1  if Webcam_MaxImage>1

    // lance la capture video
    WebCam_NImage:=0;
    Webcam_OffsetError:=0;
    WebcamEnCours:=true;

    pu_webcam.StartCapture;
    // top chrono
//    DateTime:=Now-config.PCMoinsTU/24;
    DateTime:=GetHourDT;
    pop_main.CurrentTimeDate:=DateTime;  // utilisé par WebcamAddImage

{$IFDEF DEBUG}    writespy(secmsec+'Startcapture'); {$ENDIF} //nolang

    Result:=True;

end;

function ReadWebCam(TabImgInt:PTabImgInt;X1,Y1,X2,Y2,Bin,ImgSx,ImgSy:Integer; var dtend:Tdatetime):Boolean;
var i,j,k,sx,sy,sx1,sy1,TD,NbP : integer;
    ImgInt : PTabImgInt;
    ImgDbl : PTabImgDouble;
    pose_coef : double;
    p : PByteArray;
    value,r,g,b : integer;
const fmt1='%5.1f'; //nolang
begin
try
{$IFDEF DEBUG} writespy(secmsec+'Readwebcam'); {$ENDIF} //nolang
// stop la capture video
pu_webcam.StopCapture;
WebcamEnCours:=false;
// Ca bloque les poses >1 s avec visu de l'image pendant la pose sans mode flux
// car il peut y avoir un appel bloque a WebcamAddImage pendant un readimage
// Je vois pas comment faire autrement que de l'enlever
// La derniere image sera pas traitee dans certains cas
//while WebcamAddEnCours do application.processmessages; // attendre la fin du traitement de la derniere image
DTEnd:=GetHourDT;
// vide l'image
if webcamcolor then nbp:=3 else nbp:=1;
for k:=1 to Nbp do
 for i:=1 to ImgSy do
  for j:=1 to ImgSx do
      TabImgInt^[k]^[i]^[j]:=0;
// traitement pour une seule image
if webcam_MaxImage=1 then begin
// lecture du bitmap
if bin=1 then begin
{$IFDEF DEBUG} writespy(secmsec+'Readwebcam binning 1x1'); {$ENDIF} //nolang
// sans binning
// controle de la taille de l'image
sx1:=webcam_sx;
if sx1>ImgSx then sx1:=ImgSx;
sy1:=webcam_sy;
if sy1>ImgSx then sy1:=ImgSy;
for i:=1 to sy1 do
   begin
      p:=FrIma.scanline[webcam_y - Y1 - i + 1];
      for j:=1 to sx1 do
          begin
          if WebCamColor then begin
          b:=P[3*(X1+j-2)];
          g:=P[3*(X1+j-2)+1];
          r:=P[3*(X1+j-2)+2];
          if Webcam_UseDark and (Webcam_NBdark=3) then begin
             r:=r-WebCamDark^[1]^[Y1+i-1]^[X1+j-1];
             g:=g-WebCamDark^[2]^[Y1+i-1]^[X1+j-1];
             b:=b-WebCamDark^[3]^[Y1+i-1]^[X1+j-1];
          end;
          TabImgInt^[1]^[i]^[j]:= r;
          TabImgInt^[2]^[i]^[j]:= g;
          TabImgInt^[3]^[i]^[j]:= b;
          end else begin
          value:=(P[3*(X1+j-2)]+P[3*(X1+j-2)+1]+P[3*(X1+j-2)+2]) div 3;
          if Webcam_UseDark then value:=value-WebCamDark^[1]^[Y1+i-1]^[X1+j-1];
          TabImgInt^[1]^[i]^[j]:= value;
          end;
          end;
   end;
end else begin
// avec binning
// controle de la taille de l'image
sx:=webcam_sx;
if sx>(ImgSx*bin) then sx:=(ImgSx*bin);
sy:=webcam_sy;
if sy>(ImgSy*bin) then sy:=(ImgSy*bin);
sx1:=sx; sy1:=sy;
if WebCamColor then begin
TD:=7;
NbP:=3;
Getmem(ImgInt,12);
for k:=1 to 3 do begin
Getmem(ImgInt^[k],4*sy);
for i:=1 to sy do begin
    Getmem(ImgInt^[k]^[i],sx*2);
    for j:=1 to sx do ImgInt^[k]^[i]^[j]:=0;
end;
end;
end else begin
TD:=2;
NbP:=1;
Getmem(ImgInt,4);
Getmem(ImgInt^[1],4*sy);
for i:=1 to sy do begin
    Getmem(ImgInt^[1]^[i],sx*2);
    for j:=1 to sx do ImgInt^[1]^[i]^[j]:=0;
end;
end;
for i:=1 to webcam_sy do
   begin
      p:=FrIma.scanline[webcam_y - Y1 - i + 1];
      for j:=1 to webcam_sx do
          begin
          if WebCamColor then begin
          b:=P[3*(X1+j-2)];
          g:=P[3*(X1+j-2)+1];
          r:=P[3*(X1+j-2)+2];
          if Webcam_UseDark and (Webcam_NBdark=3) then begin
             r:=r-WebCamDark^[1]^[Y1+i-1]^[X1+j-1];
             g:=g-WebCamDark^[2]^[Y1+i-1]^[X1+j-1];
             b:=b-WebCamDark^[3]^[Y1+i-1]^[X1+j-1];
          end;
          ImgInt^[1]^[i]^[j]:= r;
          ImgInt^[2]^[i]^[j]:= g;
          ImgInt^[3]^[i]^[j]:= b;
          end else begin
          value:=(P[3*(X1+j-2)]+P[3*(X1+j-2)+1]+P[3*(X1+j-2)+2]) div 3;
          if Webcam_UseDark then value:=value-WebCamDark^[1]^[Y1+i-1]^[X1+j-1];
          ImgInt^[1]^[i]^[j]:= value;
          end;
          end;
   end;
// binning logiciel
if Bin>1 then begin
   Binning(ImgInt,Imgdbl,sx,sy,TD,NbP,Bin,Bin);
end;
// copie du resultat
for i:=1 to sy do
   begin
      for j:=1 to sx do
          begin
          if WebCamColor then begin
               TabImgInt^[1]^[i]^[j]:= ImgInt^[1]^[i]^[j];
               TabImgInt^[2]^[i]^[j]:= ImgInt^[2]^[i]^[j];;
               TabImgInt^[3]^[i]^[j]:= ImgInt^[3]^[i]^[j];;
          end
          else TabImgInt^[1]^[i]^[j]:= ImgInt^[1]^[i]^[j];;
          end;
end;
// libere l'image temporaire
if WebCamColor then begin
  for k:=1 to 3 do begin
  for i:=1 to sy do Freemem(ImgInt^[k]^[i],sx*2);
  Freemem(ImgInt^[k],4*sy);
  end;
  Freemem(ImgInt,12);
end else begin
  for i:=1 to sy do Freemem(ImgInt^[1]^[i],sx*2);
  Freemem(ImgInt^[1],4*sy);
  Freemem(ImgInt,4);
end;
end;

end else begin
// traitement pour plusieurs images
if WebcamShowCumul then begin
//   WebcamRapport.AddLine(lang('Nombre d''images par seconde : ')+Format(fmt1,[Webcam_Nimage/(24*3600*((Now-config.PCMoinsTU/24)-pop_main.CurrentTimeDate))]));
   WebcamRapport.AddLine(lang('Nombre d''images par seconde : ')+Format(fmt1,[Webcam_Nimage/(24*3600*(GetHourDT-pop_main.CurrentTimeDate))]));
   WebcamRapport.AddLine(lang('Nombre d''images total : ')+Inttostr(Webcam_Nimage));
   WebcamRapport.AddLine(' '); //nolang
end;
// binning logiciel
sx:=webcam_sx;
sy:=webcam_sy;
if Bin>1 then begin
   Binning(ImgInt,WebCamCumul.datadouble,webcamcumul.ImgInfos.sx,webcamcumul.ImgInfos.sy,
      Webcamcumul.ImgInfos.TypeData,WebCamCumul.ImgInfos.NbPlans,Bin,Bin);
   sx:=webcamcumul.ImgInfos.sx;
   sy:=webcamcumul.ImgInfos.sy;
end;
if Webcam_NImage>0 then pose_coef:=WebcamSatur/(Webcam_NImage*255)
                   else pose_coef:=WebcamSatur/255;
if pose_coef>1 then pose_coef:=1;
// copie du resultat
if sx>ImgSx then sx:=ImgSx;
if sy>ImgSx then sy:=ImgSy;
for i:=1 to sy do
   begin
      for j:=1 to sx do
          begin
          if WebCamColor then begin
               TabImgInt^[1]^[i]^[j]:= round(WebCamCumul.datadouble^[1]^[i]^[j]*pose_coef);
               TabImgInt^[2]^[i]^[j]:= round(WebCamCumul.datadouble^[2]^[i]^[j]*pose_coef);
               TabImgInt^[3]^[i]^[j]:= round(WebCamCumul.datadouble^[3]^[i]^[j]*pose_coef);
          end
          else TabImgInt^[1]^[i]^[j]:= round(WebCamCumul.datadouble^[1]^[i]^[j]*pose_coef);
          end;
end;
webcamcumul.Windowstate:=wsMinimized;
webcamcumul.bloque:=false;
if WebcamShowCumul then begin
   WebcamRapport.Quitter.Enabled:=True;
   WebcamRapport.BitBtn1.Enabled:=True;
   WebcamRapport.BitBtn2.Enabled:=True;
   WebcamRapport.BitBtn3.Enabled:=True;
end;
end;
{$IFDEF DEBUG} writespy(secmsec+'Read OK'); {$ENDIF} //nolang
result:=true;
finally
// libere l'image de travail
if WebCamColor then begin
  for k:=1 to 3 do begin
  for i:=1 to webcam_sy do Freemem(webcamwork^[k]^[i],webcam_sx*2);
  Freemem(webcamwork^[k],4*webcam_sy);
  end;
  Freemem(webcamwork,12);
end else begin
  for i:=1 to webcam_sy do Freemem(webcamwork^[1]^[i],webcam_sx*2);
  Freemem(webcamwork^[1],4*webcam_sy);
  Freemem(webcamwork,4);
end;
{$IFDEF DEBUG} writespy(secmsec+'Read Terminé'); {$ENDIF} //nolang
end;
end;

procedure WebcamOffset(var dx,dy :double; var ok: boolean );
var xx,yy,i : integer;
    valeur : double;
    Error:Byte;
    gagnants:tlist;
    m:P_Matcher;
    NbStar:Integer;
    x,y,x1,x2,sigx,sigy:PLigDouble;
    a,b:DoubleArrayRow;
    covara,covarb:DoubleArray;
    chisqa,chisqb:Double;
    Rapport:tpop_rapport;
const fmt1='%5.1f'; //nolang
begin
ok:=false;
if Webcam_NImage = 1 then begin
   case pop_webcam.radiogroup3.itemindex of
   1 : begin
       Getmax(WebcamWork,Nil,2,webcam_Sx,webcam_Sy,xx,yy,Valeur);
       Webcam_ori_x:=xx;
       Webcam_ori_y:=yy;
       if WebcamShowCumul then WebcamRapport.AddLine(lang('Position de l''étoile de référence : ')+IntToStr(xx)+' '+IntToStr(yy));
       ok:=true;
       end;
   2 : begin
       modelisesources(WebcamWork,Nil,2,1,webcam_Sx,webcam_Sy,9,Webcam_arrdetections_A,TGauss,LowPrecision,LowSelect,Webcam_ndetect_A,15,False,'',False);
       if Webcam_NDetect_A<3 then
          begin
          WebcamRapport.AddLine(lang('Pas assez d''étoiles dans l''image de référence'));
          Exit;
          end;
       if WebcamShowCumul then WebcamRapport.AddLine(lang('Nombres des étoiles de la première image : ')+IntToStr(Webcam_ndetect_A));
       ok:=true;
       end;
   end;
   dx:=0;
   dy:=0;
end else begin
   case pop_webcam.radiogroup3.itemindex of
   1 : begin
       Getmax(WebcamWork,Nil,2,webcam_Sx,webcam_Sy,xx,yy,Valeur);
       dx:=Webcam_ori_x-xx;
       dy:=Webcam_ori_y-yy;
       if WebcamShowCumul then WebcamRapport.AddLine(lang('Offset de l''image ')+IntToStr(webcam_Nimage)
          +' : '+Format(fmt1,[dx])+' '+Format(fmt1,[dy])); //nolang
       ok:=true;
       end;
   2 : begin
       // copié et adapté de RecaleEtoileLot de u_pretraitement
       modelisesources(WebcamWork,Nil,2,1,webcam_Sx,webcam_Sy,9,Webcam_arrdetections_B,TGauss,LowPrecision,LowSelect,Webcam_ndetect_B,15,False,'',False);
       if Webcam_NDetect_B<3 then
          begin
          WebcamRapport.AddLine(lang('Pas assez d''étoiles dans l''image '+inttostr(webcam_Nimage)));
          Exit;
          end;
       if WebcamShowCumul then WebcamRapport.AddLine(lang('Nombres des étoiles de l''image ')+IntToStr(webcam_Nimage)
          +' : '+IntToStr(Webcam_ndetect_B)); //nolang
       Error:=MatchMarty(Webcam_arrdetections_A,Webcam_arrdetections_B,Webcam_ndetect_A,Webcam_ndetect_B,20,gagnants,Rapport);
       NbStar:=gagnants.count;
       if NbStar=0 then begin if WebcamShowCumul then WebcamRapport.AddLine(lang('Correspondance entre étoiles non trouvée'));exit;end;       
       if WebcamShowCumul then WebcamRapport.AddLine(lang('Nombres d''étoiles en correspondance : ')+IntToStr(NbStar));
       Getmem(x,8*NbStar);
       Getmem(y,8*NbStar);
       Getmem(x1,8*NbStar);
       Getmem(x2,8*NbStar);
       Getmem(Sigx,8*NbStar);
       Getmem(Sigy,8*NbStar);
       try
       // Changement de forme des donnees
       for i:=0 to NbStar-1 do
          begin
          m:=gagnants[i];
          x1^[i+1]:=m.ref_x;
          x2^[i+1]:=m.ref_y;
          x^[i+1]:=m.det_x;
          y^[i+1]:=m.det_y;
          sigx^[i+1]:=m.det_dx;
          sigy^[i+1]:=m.det_dy;
          end;
//       Degre:=1;
       // Calcul du polynome de passage en X
//       lfitAstro(x1,x2,x,sigx,NbStar,a,covara,chisqa,degre);
       lfitLin(x1,x,sigx,NbStar,a,covara,chisqa);
       // Calcul du polynome de passage en Y
//       lfitAstro(x1,x2,y,sigy,NbStar,b,covarb,chisqb,degre);
       lfitLin(x2,y,sigx,NbStar,b,covarb,chisqb);
       Dx:=-a[1];
       Dy:=-b[1];
       if WebcamShowCumul then WebcamRapport.AddLine(lang('Offset de l''image ')+IntToStr(webcam_Nimage)
          +' : '+Format(fmt1,[dx])+' '+Format(fmt1,[dy])); //nolang
       ok:=true;
       finally
         Freemem(x,8*NbStar);
         Freemem(y,8*NbStar);
         Freemem(x1,8*NbStar);
         Freemem(x2,8*NbStar);
         Freemem(Sigx,8*NbStar);
         Freemem(Sigy,8*NbStar);
       end;
       end;
   end;
end;
end;

Procedure WebcamAddImage;
var i,j : integer;
    p : PByteArray;
    dx,dy,minval,maxval : double;
    ImgDoublenil : PTabImgDouble;
    ok : boolean;
const fmt1='%6.1f'; //nolang
begin
{$IFDEF DEBUG}  writespy(secmsec+'WebcamAddImage'); {$ENDIF} //nolang
if (Webcam_NImage>=Webcam_MaxImage) then exit;
inc(Webcam_NImage);
if (Webcam_MaxImage=1) then begin
{$IFDEF DEBUG}   writespy(secmsec+'WebcamAddImage 1 image'); {$ENDIF} //nolang
   StopCapture;
   exit;
end;
try
// lire l'image et soustraction du dark
WebCamAddEnCours:=true;
for i:=1 to webcam_sy do
   begin
      p:=FrIma.scanline[webcam_y - winY1 - i + 1];
      for j:=1 to webcam_sx do
          begin
          if WebCamColor then begin
             WebCamWork^[3]^[i]^[j]:=P[3*(winX1+j-2)];     //b
             WebCamWork^[2]^[i]^[j]:=P[3*(winX1+j-2)+1];   //g
             WebCamWork^[1]^[i]^[j]:=P[3*(winX1+j-2)+2];   //r
             if Webcam_UseDark and (Webcam_NBdark=3) then begin
                WebCamWork^[1]^[i]^[j]:=WebCamWork^[1]^[i]^[j]-WebCamDark^[1]^[winY1+i-1]^[winX1+j-1];
                WebCamWork^[2]^[i]^[j]:=WebCamWork^[2]^[i]^[j]-WebCamDark^[2]^[winY1+i-1]^[winX1+j-1];
                WebCamWork^[3]^[i]^[j]:=WebCamWork^[3]^[i]^[j]-WebCamDark^[3]^[winY1+i-1]^[winX1+j-1];
             end;
          end else begin
             WebCamWork^[1]^[i]^[j]:=(P[3*(winX1+j-2)]+P[3*(winX1+j-2)+1]+P[3*(winX1+j-2)+2]) div 3;
             if Webcam_UseDark then WebCamWork^[1]^[i]^[j]:=WebCamWork^[1]^[i]^[j]-WebCamDark^[1]^[winY1+i-1]^[winX1+j-1];
          end;
      end;
end;
// recalage
if WebcamPseudoTrack  then begin
   WebcamOffset(Dx,Dy,ok);
   if not ok then begin    // erreur de modelisation
      inc(Webcam_OffsetError);
      if Webcam_OffsetError>5 then begin
         if WebcamShowCumul then WebcamRapport.AddLine(lang('Trop d''erreurs d''alignement, on abandonne.'));
         StopCapture;
         WebCamAddEnCours:=false;
         exit;
      end else begin
         dec(webcam_Nimage);  // on ignore cette image et on essaye de continuer
         WebCamAddEnCours:=false;
         exit;
      end;
   end else Webcam_OffsetError:=0;  // on ne compte que les erreurs successives
   if (dx<>0) or (dy<>0) then Translation(WebCamWork,ImgDoubleNil,webcam_Sx,webcam_Sy,workTypeData,workNbPlans,Dx,Dy);
end;
// cumule
minval:=1e99;
maxval:=1e-99;
for i:=1 to webcam_sy do
   begin
      for j:=1 to webcam_sx do
          begin
          if WebCamColor then begin
          WebCamCumul.datadouble^[1]^[i]^[j]:= WebCamCumul.datadouble^[1]^[i]^[j]+WebCamWork^[1]^[i]^[j];
          WebCamCumul.datadouble^[2]^[i]^[j]:= WebCamCumul.datadouble^[2]^[i]^[j]+WebCamWork^[2]^[i]^[j];
          WebCamCumul.datadouble^[3]^[i]^[j]:= WebCamCumul.datadouble^[3]^[i]^[j]+WebCamWork^[3]^[i]^[j];
          maxval:=maxvalue([maxval,WebCamCumul.datadouble^[1]^[i]^[j],WebCamCumul.datadouble^[2]^[i]^[j],WebCamCumul.datadouble^[3]^[i]^[j]]);
          minval:=minvalue([minval,WebCamCumul.datadouble^[1]^[i]^[j],WebCamCumul.datadouble^[2]^[i]^[j],WebCamCumul.datadouble^[3]^[i]^[j]]);
          end else begin
          WebCamCumul.datadouble^[1]^[i]^[j]:= WebCamCumul.datadouble^[1]^[i]^[j]+WebCamWork^[1]^[i]^[j];
          maxval:=max(maxval,WebCamCumul.datadouble^[1]^[i]^[j]);
          minval:=min(minval,WebCamCumul.datadouble^[1]^[i]^[j]);
          end;
          end;
   end;
   if WebcamShowCumul then begin
      WebCamCumul.imginfos.min[1]:=minval;
      WebCamCumul.imginfos.min[2]:=minval;
      WebCamCumul.imginfos.min[3]:=minval;
      WebCamCumul.imginfos.max[1]:=maxval;
      WebCamCumul.imginfos.max[2]:=maxval;
      WebCamCumul.imginfos.max[3]:=maxval;
      WebCamCumul.VisuImg;
      WebcamCumul.Windowstate:=wsNormal;
   end;
   if WebcamShowCumul then WebcamRapport.AddLine(lang('Seuils : ')+Format(fmt1,[minval])+' '+Format(fmt1,[maxval]));
finally
WebCamAddEnCours:=false;
{$IFDEF DEBUG}  writespy(secmsec+'WebcamAddImage fin'); {$ENDIF}  //nolang
end;
end;

//******************************************************************************
//**************************         Camera Webcam        **********************
//******************************************************************************

// Fonctionnement

function  TCameraWebcam.SetWindow(_x1,_y1,_x2,_y2:Integer):Boolean;
begin
  x1 := _x1 ;
  y1 := _y1 ;
  x2 := _x2 ;
  y2 := _y2 ;
  result:=true;
end;

function  TCameraWebcam.SetBinning(_Binning:Integer):Boolean;
begin
binning := _Binning;
result:=true;
end;

function  TCameraWebcam.SetPose(_Pose:Double):Boolean;
begin
pose := _Pose ;
result:=true;
end;

function TCameraWebcam.IsConnectedAndOK:Boolean;
begin
result:=true;
end;

function TCameraWebcam.Open:Boolean;
begin
//  if pop_webcam=nil then Application.CreateForm(Tpop_webcam, pop_webcam);
//  pop_webcam.showmodal;
Result:=True;
end;

procedure TCameraWebcam.Close;
begin
//  if pop_webcam<>nil then pop_webcam.BitBtn2.Click;
end;

function TCameraWebcam.StartPose:Boolean;
begin
Result:=StartWebCamAcquisition(x1,y1,x2,y2,Pose,Binning,DateTimeBegin);
end;

function TCameraWebcam.StopPose:Boolean;
begin
webcam_Nimage:=webcam_MaxImage+1;  // on arrete vraiment la pose quand le nombre d'image est atteint.
Result:=True;
end;

function  TCameraWebcam.CanStopNow:Boolean;
begin
// avec la webcam il faut avoir un nombre d'image cumulé identique a chaque fois
if (Webcam_NImage<Webcam_MaxImage)
   then result:=false
   else result:=true;
end;

procedure TCameraWebcam.AdjustIntervalePose(var NbInterValCourant,NbSubImage : integer; Interval : integer);
begin
// ajuste le temp de pose restant pour tenir compte du temps de traitement
//NbInterValCourant:=round(24*3600*1000*((Now-config.PCMoinsTU/24)-pop_main.CurrentTimeDate)/Interval);
NbInterValCourant:=round(24*3600*1000*(GetHourDT-pop_main.CurrentTimeDate)/Interval);
NbSubImage:=maxintvalue([Webcam_Nimage,1]);
end;

function TCameraWebcam.ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean;
begin
ReadWebCam(TabImgInt,x1,y1,x2,y2,Binning,ImgSx,ImgSy,DatetimeEnd);
Result:=True;
end;

// Caracteristiques
function TCameraWebcam.GetName:PChar;
begin
Result:='Webcam'; //nolang
end;

function TCameraWebcam.GetSaturationLevel:Integer;
begin
//Result:=255; // Ca ca devrait être juste !
Result:=WebcamSatur; // Ben non! on peut facilement allez plus loin en cummulant des poses.
               // et ca laisse un peu de marge pour le traitement.
               // Zut meme la j'ai faux !
end;

function TCameraWebcam.GetXSize:Integer;
begin
Result:=webcam_x;
end;

function TCameraWebcam.GetYSize:Integer;
begin
Result:=webcam_y;
end;

function TCameraWebcam.GetXPixelSize:Double;
begin
//Result:=9; // Todo : Comment faire ?
// seule solution : demander a l'utilisateur
Result:=round(config.webcam_pixelsizeX);
end;

function TCameraWebcam.GetYPixelSize:Double;
begin
//Result:=9; // Todo : Comment faire ?
// seule solution : demander a l'utilisateur
Result:=round(config.webcam_pixelsizeY);
end;

function TCameraWebcam.IsAValidBinning(Binning:Byte):Boolean;
begin
if (Binning=1) or (Binning=2) or (Binning=4) then Result:=True
else Result:=False
end;

function TCameraWebcam.HasTemperature:Boolean;
begin
Result:=False;
end;

function TCameraWebcam.CanCutAmpli:Boolean;
begin
Result:=False;
end;

function TCameraWebcam.NeedEmptyingDelay:Boolean;
begin
Result:=False;
end;

function TCameraWebcam.NeedReadingDelay:Boolean;
begin
Result:=False;
end;

function TCameraWebcam.NeedCloseShutterDelay:Boolean;
begin
Result:=False;
end;

function TCameraWebcam.HasAShutter:Boolean;
begin
Result:=False;
end;

procedure TCameraWebcam.GetCCDDateBegin(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure TCameraWebcam.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure TCameraWebcam.GetCCDDateEnd(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure TCameraWebcam.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

function TCameraWebcam.ShowConfigPanel(IsModal:boolean):Boolean;
begin
  if pop_webcam=nil then Application.CreateForm(Tpop_webcam, pop_webcam);
  if pop_webcam.WindowState=wsMinimized then pop_webcam.WindowState:=wsNormal;
  if IsModal then pop_webcam.showmodal
             else pop_webcam.show ;
  result:=true;
end;

function TCameraWebcam.GetTypeData:Integer;
begin
if WebCamColor then result:=7
               else result:=2;
end;

function TCameraWebcam.GetNbPlans:Integer;
begin
if WebCamColor then result:=3
               else result:=1;
end;

function TCameraWebcam.GetMinimalPose:double;
begin
result:=webcam_msframe/1000;  // en secondes
end;

procedure TCameraWebcam.SetPCMinusUT(PCMinusUT:Double);
begin
// Pas besoin en interne pour l'instant ?
end;

function TCameraWebcam.ShowCfgWindow:Boolean;
begin
Result:=True;
end;

function TCameraWebcam.IsTrackCCD:Boolean;
begin
Result:=False;
end;

function TCameraWebcam.NeedPixelSize:Boolean;
begin
Result:=True;
end;

procedure TCameraWebcam.SetHourServer(ServerAdress:Pointer);
begin
HourServerAdress:=ServerAdress;
end;

function TCameraWebcam.Is16Bits:Boolean;
begin
Result:=False;
end;

function TCameraWebcam.HasCfgWindow:Boolean;
begin
Result:=False;
end;

//******************************************************************************
//        Form pop_webcam
//******************************************************************************

procedure Tpop_webcam.FormCreate(Sender: TObject);
Var DrvList:TStrings;
    i : integer;
begin
FrIma:=TBitmap.create;
FrIma.PixelFormat:=pf24bit;
drvList:=  GetDriverList;
outCombobox1.Items:= drvList;
VideoCap1.DriverOpen:= false;
outComboBox1.Itemindex:=0;
processframe:=false;
for i:=0 to outCombobox1.Items.count do
    if outCombobox1.Items[i]=config.Webcam_drivername then outComboBox1.Itemindex:=i;
if config.webcam_imgs<=0 then config.webcam_imgs:=2;
outcombobox2.text:=floattostr(config.webcam_imgs);
if config.webcam_nbdark<=0 then config.webcam_nbdark:=5;
edit1.text:=inttostr(config.Webcam_nbdark);
radiogroup1.ItemIndex:=config.Webcam_color;
webcamcolor:=(radiogroup1.itemindex=1);
radiogroup3.ItemIndex:=config.Webcam_recadrage;
checkbox2.Checked:=config.Webcam_autoconnect;
checkbox3.Checked:=config.Webcam_preview;
checkbox4.Checked:=config.Webcam_viewpose;
if checkbox2.Checked then begin //autoconnect
   BitBtn1Click(Sender);  // connexion
   BitBtn5Click(Sender);  // exit
end;
end;

Function DarkValid : boolean;
begin
result:=false;
with pop_webcam do begin
if (Webcam_NBdark<>1)and(Webcam_NBdark<>3) then exit;
if (RadioGroup1.ItemIndex=1)and(Webcam_NBdark<>3) then exit;
if (RadioGroup1.ItemIndex=0)and(Webcam_NBdark<>1) then exit;
if dark_x<>webcam_x then exit;
if dark_y<>webcam_y then exit;
if (webcam_color<>24)and(Webcam_NBdark=3) then exit;
end;
result:=true;
end;

Procedure GetVideoFormat;
begin
pop_webcam.videocap1.GetVideoFormat(1,isBwQc);
//FrInf:= pop_webcam.VideoCap1.BitmapInfo;
webcam_x:=FStreamBIH.biWidth;
webcam_y:=FStreamBIH.biHeight;
//webcam_x:=FrInf.bmiHeader.biWidth;
//webcam_y:=FrInf.bmiHeader.biHeight;
webcam_color:=FStreamBIH.biBitCount;
WebCam_Use_Videostream :=pop_webcam.checkbox5.checked;
webcam_msframe:=round(1000/maxvalue([0.001,mystrtofloat(pop_webcam.outcombobox2.text)]));
pop_webcam.outlabel4.caption:=inttostr(webcam_x);
pop_webcam.outlabel5.caption:=inttostr(webcam_y);
pop_webcam.outlabel6.caption:=inttostr(webcam_color);
pop_webcam.CheckBox1.checked:=pop_webcam.CheckBox1.checked and DarkValid;
end;

procedure Tpop_webcam.BitBtn1Click(Sender: TObject);
var i : integer;
begin
VideoCap1.DriverIndex:= outcombobox1.ItemIndex;
VideoCap1.DriverOpen:= true;
if VideoCap1.DriverOpen then begin
   videocap.CreateVideoInfo;
   capSetCallbackOnVideoStream(videocap1.hcapWnd, @VideoStreamCallback);
   capSetCallbackOnFrame(videocap1.hcapWnd, @FrameCallback);
   VideoCap1.Yield:=true;
   VideoCap1.PreviewScaleProportional:=true;
   VideoCap1.PreviewScaleToWindow:=true;
   i:= strtointdef(outCombobox2.Text,2);
   if (i > 0) and ( i < 30) then VideoCap1.PreviewRate:=i
                            else VideoCap1.PreviewRate:=2;
   VideoCap1.VideoPreview:=CheckBox3.checked;
   CheckBox3.Enabled:=true;
   BitBtn3.Enabled:=true;
   BitBtn4.Enabled:=true;
   BitBtn5.Enabled:=true;
   BitBtn7.Enabled:=true;
   BitBtn8.Enabled:=true;
   outCombobox2.Enabled:=true;
   GetVideoFormat;
end;
end;

procedure Tpop_webcam.BitBtn2Click(Sender: TObject);
begin
VideoCap1.VideoPreview:=false;
VideoCap1.DriverOpen:= false;
CheckBox3.Enabled:=false;
BitBtn3.Enabled:=false;
BitBtn4.Enabled:=false;
BitBtn5.Enabled:=false;
BitBtn7.Enabled:=false;
BitBtn8.Enabled:=false;
outCombobox2.Enabled:=false;
end;

procedure Tpop_webcam.BitBtn3Click(Sender: TObject);
begin
 VideoCap1.DlgVSource;
 GetVideoFormat;
end;

procedure Tpop_webcam.BitBtn4Click(Sender: TObject);
begin
 VideoCap1.DlgVFormat;
 GetVideoFormat;
end;

procedure StopCapture;
begin
if webcam_use_videostream then begin
   if pop_webcam.VideoCap1.CapInProgess then pop_webcam.VideoCap1.StopCapture;
end else begin
   pop_webcam.WebCamTimer.enabled:=false;
end;
end;

Procedure StartCapture;
begin
pop_webcam.Videocap1.captimeLimit:=0;
pop_webcam.Videocap1.MicroSecPerFrame:=1000*webcam_msframe;
pop_webcam.Videocap1.CaptoFile:=false;
if webcam_use_videostream then begin
   pop_webcam.VideoCap1.StartCapture;
end else begin
   LockWebcamtimer:=false;
   pop_webcam.WebCamTimer.interval:=WebCam_Timer_Interval;
   pop_webcam.WebCamTimer.enabled:=true;
end;
end;

Procedure Mediane(Img: PtabImgint; nbplans,sx,sy : integer);
var Numero:PLigInt;
    Nombre:PLigDouble;
    i,j,l,m : integer;
    IntTmp:Smallint;
begin
  // Calcul de la médiane par tri à bulle  ( adapté de u_pretraitement )
  Getmem(Numero,2*NbPlans);
  Getmem(Nombre,8*NbPlans);
  for i:=1 to NbPlans do Nombre^[i]:=0;
  for j:=1 to sy do
   for i:=1 to sx do
      begin
      for l:=1 to NbPlans do Numero^[l]:=l;
      for l:=1 to NbPlans-1 do
         for m:=NbPlans downto l+1 do
            if Img^[l]^[j]^[i]>Img^[m]^[j]^[i] then
               begin
               IntTmp:=Img^[l]^[j]^[i];
               Img^[l]^[j]^[i]:=Img^[m]^[j]^[i];
               Img^[m]^[j]^[i]:=IntTmp;
               IntTmp:=Numero^[l];
               Numero^[l]:=Numero^[m];
               Numero^[m]:=IntTmp;
               end;
      Nombre^[Numero^[NbPlans div 2]]:=Nombre^[Numero^[NbPlans div 2]]+1;
      end;
  Freemem(Numero,2*Nbplans);
  Freemem(Nombre,8*Nbplans);
end;

Procedure AddDark;
var i,j : integer;
    p : PByteArray;
begin
inc(CurDark);
pop_webcam.Edit1.text:=inttostr(CurDark); pop_webcam.Edit1.Refresh;
for i:=1 to dark_y do
   begin
      p:=FrIma.scanline[dark_y - i];
      for j:=1 to dark_x do
          begin
          case Webcam_NBdark of
          1 : WebCamTmp^[CurDark]^[i]^[j]:= (P[3*(j-1)]+P[3*(j-1)+1]+P[3*(j-1)+2]) div 3;
          3 : begin
              WebCamTmpB^[CurDark]^[i]^[j]:= P[3*(j-1)];
              WebCamTmpG^[CurDark]^[i]^[j]:= P[3*(j-1)+1];
              WebCamTmpR^[CurDark]^[i]^[j]:= P[3*(j-1)+2];
              end;
          end;
          end;
   end;
if CurDark>=NbDark then begin  // fin de l'acquisition du noir
  StopCapture;
  Acquisitiondark:=false;
  WebcamEnCours:=false;
  // Calcul de la médiane
  case WebCam_NBdark of
  1: begin
     Mediane(webcamtmp,NbDark,dark_x,dark_y);
     for j:=1 to dark_y do
         for i:=1 to dark_x do
             WebCamDark^[1]^[j]^[i]:=WebCamTmp^[NbDark div 2]^[j]^[i];
     end;
  3: begin
     Mediane(webcamtmpR,NbDark,dark_x,dark_y);
     Mediane(webcamtmpG,NbDark,dark_x,dark_y);
     Mediane(webcamtmpB,NbDark,dark_x,dark_y);
     for j:=1 to dark_y do
         for i:=1 to dark_x do begin
             WebCamDark^[1]^[j]^[i]:=WebCamTmpR^[NbDark div 2]^[j]^[i];
             WebCamDark^[2]^[j]^[i]:=WebCamTmpG^[NbDark div 2]^[j]^[i];
             WebCamDark^[3]^[j]^[i]:=WebCamTmpB^[NbDark div 2]^[j]^[i];
             end;
     end;
  end;
  // liberation images temporaire
  case WebCam_NBdark of
  1: begin
     for j:=1 to NbDark do
       begin
            for i:=1 to dark_y do Freemem(WebCamTmp^[j]^[i],4*dark_x);
            Freemem(WebCamTmp^[j],4*dark_y);
       end;
       Freemem(WebCamTmp,4*NbDark);
     end;
  3: begin
     for j:=1 to NbDark do
       begin
            for i:=1 to dark_y do Freemem(WebCamTmpR^[j]^[i],4*dark_x);
            Freemem(WebCamTmpR^[j],4*dark_y);
            for i:=1 to dark_y do Freemem(WebCamTmpG^[j]^[i],4*dark_x);
            Freemem(WebCamTmpG^[j],4*dark_y);
            for i:=1 to dark_y do Freemem(WebCamTmpB^[j]^[i],4*dark_x);
            Freemem(WebCamTmpB^[j],4*dark_y);
       end;
       Freemem(WebCamTmpR,4*NbDark);
       Freemem(WebCamTmpG,4*NbDark);
       Freemem(WebCamTmpB,4*NbDark);
     end;
  end;
  pop_webcam.CheckBox1.Enabled:=true;
  pop_webcam.CheckBox1.Checked:=true;
  pop_webcam.BitBtn5.Enabled:=true;
end;
end;


function VideoStreamCallback(hWnd:Hwnd; lpVHdr:PVIDEOHDR):longint; stdcall;
begin   // reception d'une image 24 bits
result:=1;
if not WebcamEnCours then exit;
Videocap.GetBitmap(FrIma,lpVhdr);
FrIma.pixelformat:=pf24bit;
if AcquisitionDark then AddDark
                   else WebcamAddImage;
Application.processmessages;
end;

procedure Tpop_webcam.WebCamTimerTimer(Sender: TObject);
begin   // reception d'une image 8 bits
{$IFDEF DEBUG}  writespy(secmsec+'WebCamTimer'); {$ENDIF} //nolang
if not WebcamEnCours then exit;
if LockWebcamtimer then begin   // en cas de blocage on revient voir plus souvent
   pop_webcam.WebCamTimer.interval:=10;
   {$IFDEF DEBUG}  writespy(secmsec+'WebCamTimer Lock'); {$ENDIF} //nolang
   exit;
end;
try
LockWebcamtimer:=true;
pop_webcam.WebCamTimer.interval:=WebCam_Timer_Interval;
{$IFDEF DEBUG}  writespy(secmsec+'WebCamTimer GrabFrame'); {$ENDIF} //nolang
ProcessFrame:=true;
if pop_webcam.VideoCap1.VideoPreview then
   pop_webcam.Videocap1.GrabFrameNoStop
else
   pop_webcam.Videocap1.GrabFrame;
Application.processmessages;
finally
LockWebcamtimer:=false;
end;
end;

procedure Tpop_webcam.FormDestroy(Sender: TObject);
begin
FrIma.Free;
end;

procedure Tpop_webcam.outComboBox2Change(Sender: TObject);
var i : double;
    code:integer;
begin
val(outCombobox2.Text,i,code);
if code>0 then begin
   beep;
   outCombobox2.SetFocus;
   exit;
end;
if i< 0.01 then i:=0.01;
if i>30 then i:=30;
VideoCap1.PreviewRate:=maxintvalue([round(i),1]);
outCombobox2.Text:=formatfloat('0.##',i); //nolang 
webcam_msframe:=round(1000/i);
end;

procedure Tpop_webcam.FormShow(Sender: TObject);
begin
if not VideoCap1.DriverOpen then begin
   VideoCap1.VideoPreview:=false;
   CheckBox3.Enabled:=false;
   BitBtn3.Enabled:=false;
   BitBtn4.Enabled:=false;
   BitBtn5.Enabled:=false;
   BitBtn7.Enabled:=false;
   BitBtn8.Enabled:=false;
   outCombobox2.Enabled:=false;
end;
UpDateLang(Self);
end;

procedure Tpop_webcam.BitBtn7Click(Sender: TObject);
var i,j,k : integer;
begin
// liberation de l'ancien dark
if webcamdark<>nil then begin
   for k:=1 to Webcam_NBdark do begin
    for i:=1 to dark_y do Freemem(WebCamDark^[k]^[i],dark_x*2);
    Freemem(WebCamDark^[k],4*dark_y);
   end;
   Freemem(WebCamDark,4*Webcam_NBdark);
end;
// initialisation du dark
NbDark:=strtointdef(edit1.text,5);
if NbDark>49 then NbDark:=49;
if NbDark<3 then NbDark:=3;
if RadioGroup1.ItemIndex=1 then Webcam_NBdark:=3 else Webcam_NBdark:=1;
case Webcam_NBdark of
1 : begin
    Getmem(WebCamTmp,4*NbDark);
    for j:=1 to NbDark do
        begin
        Getmem(WebCamTmp^[j],4*webcam_y);
        for i:=1 to webcam_y do Getmem(WebCamTmp^[j]^[i],2*webcam_x);
        end;
    end;
3 : begin
    Getmem(WebCamTmpR,4*NbDark);
    Getmem(WebCamTmpG,4*NbDark);
    Getmem(WebCamTmpB,4*NbDark);
    for j:=1 to NbDark do
        begin
        Getmem(WebCamTmpR^[j],4*webcam_y);
        for i:=1 to webcam_y do Getmem(WebCamTmpR^[j]^[i],2*webcam_x);
        Getmem(WebCamTmpG^[j],4*webcam_y);
        for i:=1 to webcam_y do Getmem(WebCamTmpG^[j]^[i],2*webcam_x);
        Getmem(WebCamTmpB^[j],4*webcam_y);
        for i:=1 to webcam_y do Getmem(WebCamTmpB^[j]^[i],2*webcam_x);
        end;
    end;
end;
Getmem(WebCamDark,4*Webcam_NBdark);
for k:=1 to Webcam_NBdark do begin
  Getmem(WebCamDark^[k],4*webcam_y);
  for i:=1 to webcam_y do begin
      Getmem(WebCamDark^[k]^[i],webcam_x*2);
      for j:=1 to webcam_x do WebCamDark^[k]^[i]^[j]:=0;
end;
end;
dark_x:=webcam_x;
dark_y:=webcam_y;
CurDark:=0;
Acquisitiondark:=true;
WebcamEnCours:=true;
BitBtn5.Enabled:=false;
StartCapture;
end;

procedure Tpop_webcam.CheckBox1Click(Sender: TObject);
begin
WebCam_UseDark:=CheckBox1.checked;
if CheckBox1.checked then CheckBox1.checked:=DarkValid;
end;

procedure Tpop_webcam.RadioGroup1Click(Sender: TObject);
begin
if VideoCap1.DriverOpen and (webcam_color<>24) then radiogroup1.itemindex:=0;
CheckBox1.checked:=CheckBox1.checked and DarkValid;
webcamcolor:=(radiogroup1.itemindex=1);
end;

procedure Tpop_webcam.BitBtn5Click(Sender: TObject);
begin
config.webcam_imgs:=Mystrtofloat(outcombobox2.text);
config.Webcam_nbdark:=strtointdef(edit1.text,5);
config.Webcam_color:=radiogroup1.ItemIndex;
config.Webcam_recadrage:=radiogroup3.ItemIndex;
config.Webcam_drivername:=outCombobox1.text;
config.Webcam_autoconnect:=checkbox2.checked;
config.Webcam_preview:=checkbox3.checked;
config.Webcam_viewpose:=checkbox4.checked;
close;
end;

procedure Tpop_webcam.BitBtn6Click(Sender: TObject);
begin
close;
end;

Procedure StopAVI;
begin
 if pop_webcam.VideoCap1.CapInProgess then
 begin
  pop_webcam.VideoCap1.StopCapture ;
  while pop_webcam.VideoCap1.CapInProgess do Application.ProcessMessages;
 end;
 AVIEnCours:=False;
 pop_webcam.groupbox3.visible:=AVIshowmenu;
 pop_webcam.panel3.visible:= not AVIshowmenu;
end;

Procedure StartAVI(avifile : string; exp : double) ;
begin
pop_webcam.groupbox3.visible:=false;
pop_webcam.panel3.visible:= true;
pop_webcam.show;
application.processmessages;
pop_webcam.VideoCap1.VideoFileName:=config.RepImagesAcq+'\'+changefileext(Avifile,'.avi'); //nolang
AVIexposure:=round(exp);
pop_webcam.videoCap1.CapTimeLimit:=AVIexposure;
pop_webcam.Videocap1.CaptoFile:=true;
AVIstarttime:=time;
pop_webcam.VideoCap1.StartCapture;
pop_webcam.AVITimer.enabled:=true;
AVIEnCours:=True;
end;

procedure Tpop_webcam.AVITimerTimer(Sender: TObject);
begin
if not VideoCap1.CapInProgess then begin
   AVITimer.enabled:=false;
   StopAVI;
end;
end;

procedure Tpop_webcam.VideoCap1StatusCallback(Sender: TObject;
  nID: Integer; status: String);
begin
panel3.caption:= status;
end;

procedure Tpop_webcam.CheckBox2Click(Sender: TObject);
begin
config.Webcam_autoconnect:=checkbox2.checked;
end;

procedure Tpop_webcam.CheckBox3Click(Sender: TObject);
begin
if CheckBox3.Enabled then begin
  if not CheckBox3.checked then begin
    if MessageDlg(lang('Attention !')+chr(13)+'Certaines webcam ne supporte pas bien que l''on supprime la prévisualisation.'+chr(13)
       +lang('Cette option ne devrait être utilisée que pour améliorer les performances de la Quickcam N/B.')+chr(13)
       +lang('Voulez-vous vraiment la supprimer ?'),mtWarning,[mbYes,mbNo],0)=mrYes then
           CheckBox3.checked:=false
      else CheckBox3.checked:=true;
  end;
  VideoCap1.VideoPreview:=CheckBox3.checked;
end;
end;

procedure Tpop_webcam.BitBtn8Click(Sender: TObject);
var i : integer;
begin
if BtnAVIStart then begin    // Start AVI
   Nombre:=Nboucle.value;
   i:=1;
   BtnAVIStart:=false;
   BitBtn8.Caption:='Stop'; // nolang
   while (i<=Nombre) do
      begin
      AVIshowmenu:=(i=Nombre);
      pu_webcam.StartAVI(NomAVI.text+IntToStr(SeqAVI.Value),MyStrToFloat(TempsAVI.Text));
      while AVIEnCours do Application.ProcessMessages;
      SeqAVi.Value:=SeqAVI.Value+1;
      inc(i);
      end;
   BtnAVIStart:=true;
   BitBtn8.Caption:='Start'; // nolang
   end
else begin  // STOP AVI
   Nombre:=1;
   AVIshowmenu:=true;
   pu_webcam.StopAVI;
end
end;

procedure Tpop_webcam.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if VideoCap1.DriverOpen then action:=caMinimize;
end;

function FrameCallback(hWnd: HWnd; lpVHDR: PVideoHdr): DWord; stdcall;
var t : tdatetime;
begin
result:=1;
{$IFDEF DEBUG}  writespy(secmsec+'FrameCallback'); {$ENDIF} //nolang
If ProcessFrame then begin
{$IFDEF DEBUG}  writespy(secmsec+'FrameCallback GetBitmap'); {$ENDIF} //nolang
  ProcessFrame:=false;
  Videocap.GetBitmap(FrIma,lpVhdr);
  FrIma.pixelformat:=pf24bit;
  if AcquisitionDark then AddDark
                     else WebcamAddImage;
end else begin
t:=now;
RealMsFrame:=trunc((t-lastframedate)*86400*1000);
pop_webcam.outlabel9.caption:=inttostr(RealMsFrame);
pop_webcam.outlabel10.caption:=FormatFloat('0.#',1/(RealMsFrame/1000)); //nolang
lastframedate:=t;
end;
end;

procedure Tpop_webcam.BitBtn9Click(Sender: TObject);
begin
outComboBox2.text:=outLabel10.caption;
outComboBox2change(sender);
end;

procedure Tpop_webcam.WMMove(var Message: TWMMove);
begin
  inherited;
  // after move of form
  if videocap1<>nil then videocap1.resetcap;
end;

procedure Tpop_webcam.CheckBox5Click(Sender: TObject);
begin
if CheckBox5.checked then begin
    MessageDlg(lang('Attention !')+chr(13)
       +lang('Certaines webcam peuvent bloquer le programme avec cette option.')+chr(13)
       +lang('Merci de faire des tests avant de l''utiliser'),mtWarning,[mbOK],0);
end;
GetVideoFormat;
end;

procedure Tpop_webcam.QCNBClick(Sender: TObject);
begin
isBwQc:=QCNB.checked;
if videocap1.driveropen then GetVideoFormat;
end;

end.

