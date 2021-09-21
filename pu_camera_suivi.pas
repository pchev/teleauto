unit pu_camera_suivi;

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
  ComCtrls, Buttons, ExtCtrls, Spin, StdCtrls, HiResTim, math, u_class, inifiles,
  pu_image, Mask, Editnbre, pu_dlg_standard, SyncObjs;

type
  TThreadPoseSuivi1 = class(TThread)
    private
    protected
     NbImageThread,PoseStr:string;
     ProgressPos:Integer;
     Fin:Boolean;
     procedure AfficheInfos;
     procedure Execute; override;
    public
     constructor Create;
    end;

  TThreadPoseSuivi2 = class(TThread)
    private
    protected
     NbImageThread,PoseStr:string;
     ProgressPos:Integer;
     Fin:Boolean;
     procedure AfficheInfos;
     procedure Execute; override;
    public
     constructor Create;
    end;

  TThreadPoseSuivi4 = class(TThread)
    private
    protected
     NbImageThread,PoseStr:string;
     ProgressPos:Integer;
     Fin:Boolean;
     procedure AfficheInfos;
     procedure Execute; override;
    public
     constructor Create;
    end;

  TMyWaitGuide=class(TThread)
  private
  protected
   procedure Execute; override;
  public
   constructor Create;
  end;

  Tpop_camera_suivi = class(TForm)
    progress: TProgressBar;
    memo_stats: TMemo;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    Edit6: TEdit;
    Label10: TLabel;
    Label25: TLabel;
    Panel1: TPanel;
    GroupBox14: TGroupBox;
    outLabel32: TLabel;
    outLabel35: TLabel;
    outLabel36: TLabel;
    outLabel37: TLabel;
    win_x1: TEdit;
    win_x2: TEdit;
    win_y1: TEdit;
    win_y2: TEdit;
    GroupBox1: TGroupBox;
    outAcqB1: TButton;
    outAcqB4: TButton;
    outAcqB2: TButton;
    Stop: TButton;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Edit5: TEdit;
    SpinButton1: TSpinButton;
    Label7: TLabel;
    GroupBox3: TGroupBox;
    btn_calibrer: TButton;
    btnChercher: TButton;
    btn_track_start: TButton;
    btn_track_stop: TButton;
    SpeedButton1: TSpeedButton;
    Button1: TButton;
    Label1: TLabel;
    NbreEdit1: NbreEdit;
    Label2: TLabel;
    TimerInter1: TTimer;
    TimerInter2: TTimer;
    TimerInter4: TTimer;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure outAcqB2Click(Sender: TObject);
    procedure outAcqB4Click(Sender: TObject);
    procedure btn_closeClick(Sender: TObject);
    procedure Btn_calibrerClick(Sender: TObject);
    procedure outbtn_trackClick(Sender: TObject);
    procedure btn_track_startClick(Sender: TObject);
    procedure btn_track_stopClick(Sender: TObject);
    procedure update_stats(x,y:integer; min,mediane,max,moy,ecart:double);
    procedure FormShow(Sender: TObject);
    procedure Stop1Click(Sender: TObject);
    procedure outButton1Click(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnChercherClick(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure outAcqB1Click(Sender: TObject);
    procedure TimerInter1Timer(Sender: TObject);
    procedure TimerInter2Timer(Sender: TObject);
    procedure TimerInter4Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    // Track
    MemPicTrackNoir,MemPicTrackNoirBinning,VignetteNoir:PTabImgInt;
    SxNoir,SyNoir,SxNoirBinning,SyNoirBinning:Integer;
    TpsIntTrack:Integer;
    XCcdTrack1,YCcdTrack1,XCcdTrack2,YCcdTrack2:Integer;

    PoseEnCours:Boolean;
    XTrack,YTrack,XTrackXMoins,YTrackXMoins,XTrackXPlus,YTrackXPlus:Double;
    XTrack0,YTrack0,XTrackXMoins0,YTrackXMoins0:Double;
    XTrackYMoins,YTrackYMoins,XTrackYPlus,YTrackYPlus:Double;
    StopSuivi,ChercherEnCours:Boolean;
    NbInterValCourant,NbInterValPose:Integer;
    NbInterValCourantTrack,NbInterValPoseTrack:Integer;
    Binning:Integer;
    XCcd1,YCcd1,XCcd2,YCcd2:Integer;
    TpsInt:Integer;
    pop_image_acq:tpop_image;
    NoirAcquis:Boolean;
    NoirBinningAcquis:Boolean;
    ErreurX,ErreurY:Double;
    StopPose:Boolean;
    YearBegin,MonthBegin,DayBegin:Word;
    HourBegin,MinBegin,SecBegin,MSecBegin:Word;
    YearEnd,MonthEnd,DayEnd:Word;
    HourEnd,MinEnd,SecEnd,MSecEnd:Word;
    TimeBegin,TimeEnd:TDateTime;
    x1,y1,x2,y2:Integer;
    pop_image1,pop_image2,pop_image3,pop_image4,pop_image5,pop_image6,pop_image7:Tpop_image;

//    function AcqNonSatur(var x,y:Integer):Boolean;
    function AcqMaximumBinning(var x,y:Integer):Boolean;
    function AcqMaximum(var x,y:Integer):Boolean;
    function Acquisition(x1,y1,x2,y2:Integer;
                         Pose:Double;
                         Bin:Integer;
                         ShutterClosed:Boolean;
                         var Sx,Sy:Integer;
                         var ImgInfos:TImgInfos):Boolean;
    procedure AcqNoir;
    procedure AcqNoirBinning(Binning:Byte);

    procedure DeplaceScope(Duree:Double;Direction:Byte);

    procedure StartB1;
    procedure StartB2;
    procedure StartB3;
    procedure SetPose(Pose:Single);
    procedure StartGuide;
    procedure StopGuide;
    function GetError:string;
    procedure WaitGuide;
  end;

  TSuiviThread = class(TThread)
    private
    protected
     procedure AfficheMoniteur;
     procedure CreeImage;
     procedure Execute; override;
    public
     constructor Create;
    end;

var
  pop_camera_suivi:Tpop_camera_suivi;
  TrackGood,MesureEnCours:Boolean;
  EventGuide:TEvent;
  GuideError:string;
  ThreadPoseSuivi1:TThreadPoseSuivi1;
  ThreadPoseSuivi2:TThreadPoseSuivi2;
  ThreadPoseSuivi4:TThreadPoseSuivi4;
  EventPoseSuivi:TEvent;


implementation

uses u_file_io,
     u_constants,
     u_math,
     u_driver_st7,
     u_general,
     u_meca,
     pu_seuils,
     pu_scope,
     pu_conf,
     pu_main,
     u_modelisation,
     u_arithmetique,
     u_geometrie,
     pu_script_builder,
     u_analyse,
     pu_webcam,
     u_lang,
     u_cameras,
     u_telescopes,
     pu_camera,
     pu_track,
     pu_calibrate_track,
     pu_dessin,
     u_hour_servers,
     pu_rapport;

{$R *.DFM}

constructor TMyWaitGuide.Create;
begin
inherited Create(True);
Priority:=tpNormal;
FreeOnTerminate:=True;
Resume;
end;

procedure TMyWaitGuide.Execute;
begin
EventGuide.WaitFor(INFINITE);
EventGuide.ResetEvent;
end;


function Tpop_camera_suivi.Acquisition(x1,y1,x2,y2:Integer;
                                       Pose:Double;
                                       Bin:Integer;
                                       ShutterClosed:Boolean;
                                       var Sx,Sy:Integer;
                                       var ImgInfos:TImgInfos):Boolean;
var
i,j,k,nbimage:Integer;
InterI:SmallInt;
InterP:Pointer;
Resultat:Boolean;
TimeInit,TimeFin,TimeCourant,TimeBegin,TimeEnd:TDateTime;
TempsRestant:Double;
YearBegin,MonthBegin,DayBegin:Word;
HourBegin,MinBegin,SecBegin,MSecBegin:Word;
YearEnd,MonthEnd,DayEnd:Word;
HourEnd,MinEnd,SecEnd,MSecEnd:Word;
Angle:Double;
begin
Result:=True;
PoseEnCours:=True;

try

if CameraSuivi.Is16Bits and (pop_image_acq<>nil) and (pop_image_acq.DataDouble<>nil) then
   begin
   for k:=1 to pop_image_acq.ImgInfos.Nbplans do
      begin
      for i:=1 to pop_image_acq.ImgInfos.Sy do Freemem(pop_image_acq.DataDouble^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
      Freemem(pop_image_acq.DataDouble^[k],4*pop_image_acq.ImgInfos.Sy);
      end;
   Freemem(pop_image_acq.DataDouble,4*pop_image_acq.ImgInfos.Nbplans);
   end;

if (pop_image_acq<>nil) and (pop_image_acq.DataInt<>nil) then
   begin
   for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
      for i:=1 to Sy do Freemem(pop_image_acq.DataInt^[k]^[i],Sx*2);
      Freemem(pop_image_acq.DataInt^[k],4*Sy);
   end;
   Freemem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
   end;

pop_image_acq.ImgInfos.min[1]:=0;
pop_image_acq.ImgInfos.max[1]:=0;
pop_image_acq.ImgInfos.TypeData:=CameraSuivi.GetTypeData;
pop_image_acq.ImgInfos.Nbplans:=CameraSuivi.GetNbPlans;

if Pose<CameraSuivi.GetMinimalPose then begin
   Pose:=CameraSuivi.GetMinimalPose;
end;
TpsInt:=Round(Pose*1000);

Sx:=(x2-x1+1) div Bin;
Sy:=(y2-y1+1) div Bin;

if Config.MirrorXSuivi then
   begin
   x1:=CameraSuivi.GetXSize-x1+1;
   x2:=CameraSuivi.GetXSize-x2+1;
   end;
if Config.MirrorYSuivi then
   begin
   y1:=CameraSuivi.GetYSize-y1+1;
   y2:=CameraSuivi.GetYSize-y2+1;
   end;

Getmem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
  Getmem(pop_image_acq.DataInt^[k],4*Sy);
  for i:=1 to Sy do Getmem(pop_image_acq.DataInt^[k]^[i],Sx*2);
end;
CameraSuivi.SetWindow(x1,y1,x2,y2);
if not Config.SuiviEnCours then
   WriteSpy(CameraSuivi.GetName+lang(' Fenêtre : (')+IntToStr(x1)+','+IntToStr(y1)+lang(')/(')+
      IntToStr(x2)+','+IntToStr(y2)+')');
CameraSuivi.SetBinning(Bin);
if not Config.SuiviEnCours then
   WriteSpy(CameraSuivi.GetName+lang(' Binning : ')+IntToStr(Bin));
CameraSuivi.SetPose(Pose);
if not Config.SuiviEnCours then
   WriteSpy(CameraSuivi.GetName+lang(' Temps de pose : ')+MyFloatToStr(Pose,3)+
      lang(' s'));
if ShutterClosed then
   if CameraSuivi.HasAShutter then CameraSuivi.SetShutterClosed;
//ImgInfos.TempsPose:=Round(Pose*1000); // Conversion s -> ms
if not Config.SuiviEnCours then
   WriteSpy(lang('Début de la pose sur la caméra de guidage'));
Resultat:=CameraSuivi.StartPose;
if Resultat then
   begin
   // On attends prendant le temps de pose
   TempsRestant:=Pose;
//   TimeCourant:=Now-config.PCMoinsTU/24;
   TimeCourant:=GetHourDT;

   TimeInit:=TimeCourant;
   TimeFin:=TimeInit+Pose/60/60/24;
   while TimeCourant<TimeFin do
      begin
//      TimeCourant:=Now-config.PCMoinsTU/24;
      TimeCourant:=GetHourDT;
      Application.ProcessMessages;
      TempsRestant:=(TimeFin-TimeCourant)*24*60*60;
      progress.position:=progress.max-round(TempsRestant);
      Panel1.Caption:=FloatToStrF(TempsRestant,ffFixed,4,1);

      // on coupe l ampli pendant la pose et on rallume une seconde avant la pose
      if ((CameraSuivi.CanCutAmpli) and (CameraSuivi.AmpliIsUsed) and (not cameraSuivi.getamplistate)) and
         ((TimeCourant-TimeInit)*24*60*60>CameraSuivi.GetDelayToSwitchOffAmpli) and
         ((TimeCourant-TimeInit)*24*60*60>TimeFin-CameraSuivi.GetDelayToSwitchOnAmpli) then
         begin
         CameraSuivi.AmpliOn;
         cameraSuivi.setamplistatetrue;
         Panel1.Caption:=lang('Ampli on');
         end;

      end;

   // On lit le capteur
   progress.position:=0;
   Panel1.Caption:=lang('Lecture');
   Panel1.Update;

   Stop.Enabled:=False;
   outAcqB1.Enabled:=False;
   outAcqB2.Enabled:=False;
   outAcqB4.Enabled:=False;
   try
   try
   CameraSuivi.ReadCCD(pop_image_acq.DataInt,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   if CameraSuivi.Is16Bits then
      begin
      ImgInfos.BZero:=32768;
      ConvertFITSIntToReal(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos);
      end;
   except
   Config.CameraSuiviBranchee:=False;
   pop_main.UpdateGUICameraSuivi;
   end;
   finally
   Stop.Enabled:=True;
   outAcqB1.Enabled:=True;
   outAcqB2.Enabled:=True;
   outAcqB4.Enabled:=True;
   end;


   CameraSuivi.GetCCDDateBegin(YearBegin,MonthBegin,DayBegin);
   CameraSuivi.GetCCDTimeBegin(HourBegin,MinBegin,SecBegin,MSecBegin);
   CameraSuivi.GetCCDDateEnd(YearEnd,MonthEnd,DayEnd);
   CameraSuivi.GetCCDTimeEnd(HourEnd,MinEnd,SecEnd,MSecEnd);
   TimeBegin:=EncodeDate(YearBegin,MonthBegin,DayBegin)+EncodeTime(HourBegin,MinBegin,SecBegin,MSecBegin);
   TimeEnd:=EncodeDate(YearEnd,MonthEnd,DayEnd)+EncodeTime(HourEnd,MinEnd,SecEnd,MSecEnd);

   Panel1.Caption:=lang('Stop');
   // affichage du nombre total d'image
   CameraSuivi.AdjustIntervalePose(NbInterValCourant,nbimage,Intervalle);
   if nbimage>0 then Edit6.text:=inttostr(nbimage);
   if ShutterClosed then
      if CameraSuivi.HasAShutter then CameraSuivi.SetShutterSynchro;

   if config.MirrorXSuivi then
      if CameraSuivi.Is16Bits then
         MiroirHorizontal(pop_image_acq.DataInt,pop_image_acq.DataDouble,5,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy)
      else
         MiroirHorizontal(pop_image_acq.DataInt,pop_image_acq.DataDouble,2,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   if config.MirrorYSuivi then
      if CameraSuivi.Is16Bits then
         MiroirVertical(pop_image_acq.DataInt,pop_image_acq.DataDouble,5,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy)
      else
         MiroirVertical(pop_image_acq.DataInt,pop_image_acq.DataDouble,2,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);

{   if config.MirrorXSuivi then
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do
         for j:=1 to Sy do
            for i:=1 to Sx div 2 do
               begin
               InterI:=pop_image_acq.DataInt^[k]^[j]^[i];
               pop_image_acq.DataInt^[k]^[j]^[i]:=pop_image_acq.DataInt^[k]^[j]^[Sx-i+1];
               pop_image_acq.DataInt^[k]^[j]^[Sx-i+1]:=InterI;
               end;
   if config.MirrorYSuivi then
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do
         for j:=1 to Sx do
            for i:=1 to Sy div 2 do
               begin
               InterI:=pop_image_acq.DataInt^[k]^[i]^[j];
               pop_image_acq.DataInt^[k]^[i]^[j]:=pop_image_acq.DataInt^[k]^[pop_image_acq.ImgInfos.Sy-i+1]^[j];
               pop_image_acq.DataInt^[k]^[pop_image_acq.ImgInfos.Sy-i+1]^[j]:=InterI;
               end;}
   with pop_image_acq do
      begin
      InitImgInfos(ImgInfos);
//      ImgInfos.TempsPose:=Round(Pose*1000); // Conversion s -> ms
      ImgInfos.TempsPose:=Round((TimeEnd-TimeBegin)*24*3600*1000);
      // On met a jour le temps de milieu de pose avec le temps de pose reel mesuré !
//      ImgInfos.DateTime:=TimeInit+Pose/24/3600/2;
      ImgInfos.DateTime:=TimeBegin+(TimeEnd-TimeBegin)/2;
      ImgInfos.BinningX:=Bin;
      ImgInfos.BinningY:=Bin;
      ImgInfos.MiroirX:=config.MirrorXSuivi;
      ImgInfos.MiroirY:=config.MirrorYSuivi;
      ImgInfos.Telescope:=config.Telescope;
      ImgInfos.Observateur:=config.Observateur;
      ImgInfos.Camera:=CameraSuivi.GetName;
      if Config.UseCFW8 then
         begin
         if Pop_Camera.RadioButton1.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton1.Caption;
         if Pop_Camera.RadioButton2.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton2.Caption;
         if Pop_Camera.RadioButton3.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton3.Caption;
         if Pop_Camera.RadioButton4.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton4.Caption;
         if Pop_Camera.RadioButton5.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton5.Caption;
         end
      else ImgInfos.Filtre:=config.Filtre;
      ImgInfos.Observatoire:=config.Observatoire;
      ImgInfos.Lat:=Config.Lat;
      ImgInfos.Long:=Config.Long;
      ImgInfos.Focale:=config.FocaleTele;
      ImgInfos.Diametre:=config.Diametre;

      Angle:=Config.OrientationCCDGuidage;
      if CheckBox2.Checked then Angle:=Angle+180;
      if Angle>360 then Angle:=Angle-360;
      ImgInfos.OrientationCCD:=Angle;

      ImgInfos.Seeing:=Config.Seeing;
      ImgInfos.BScale:=1;
      ImgInfos.BZero:=0;
      if Config.GoodPos then
         begin
         ImgInfos.Alpha:=Config.AlphaScope;
         ImgInfos.Delta:=Config.DeltaScope;
         end
      else
         begin
         WriteSpy(lang('Le télescope ne veut pas donner sa position'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope ne veut pas donner sa position'));
         end;
      ImgInfos.PixX:=CameraSuivi.GetXPixelSize;
      ImgInfos.PixY:=CameraSuivi.GetYPixelSize;
      ImgInfos.X1:=x1;
      ImgInfos.Y1:=y1;
      ImgInfos.X2:=x2;
      ImgInfos.Y2:=y2;
      end;

   end
else
   begin
   Config.CameraSuiviBranchee:=False;
   pop_main.UpdateGUICameraSuivi;
   end;

Result:=Resultat;

finally
PoseEnCours:=False;
end;
end;

constructor TSuiviThread.Create;
begin
inherited Create(True);
//Priority:=tpNormal;
Priority:=tpLower;
FreeOnTerminate:=True;
Resume;
end;

procedure TSuiviThread.AfficheMoniteur;
begin
if pop_track=nil then pop_track:=tpop_track.create(application);
pop_track.RAZ;
pop_track.Show;
end;

procedure TSuiviThread.CreeImage;
begin
if pop_camera_suivi.pop_image_acq=nil then
   begin
   pop_camera_suivi.pop_image_acq:=tpop_image.Create(Application);
   pop_camera_suivi.pop_image_acq.IsUsedForTrack:=True;
   pop_camera_suivi.pop_image_acq.ImgInfos.BZero:=0;
   pop_camera_suivi.pop_image_acq.ImgInfos.BScale:=1;
   end;
end;

procedure TSuiviThread.Execute;
var
xx,yy,i:Integer;
TimeInit:TDateTime;
ValMax:Double;
Reussit,MesureOK:Boolean;
DeltaX,DeltaY:Double;
TimeMove:Double;
DeplacementNord,DeplacementSud,DeplacementEst,DeplacementOuest:Double;
TimeMoveST7_1,TimeMoveST7_2:Integer;
PSF:TPSF;
ImgDoubleNil:PTabImgDouble;
ImgNil:PTabImgDouble;
LimiteSous:Double;
Time1,Time2:TDateTime;
DeltaCourant:Double;
Alpha:Double;
NbEchec:Integer;
Inv:Integer;
begin
LimiteSous:=0.9;
Config.xDeplaceSuivi:=0;
Config.yDeplaceSuivi:=0;

if pop_camera_suivi.CheckBox2.Checked then Inv:=-1 else Inv:=1;

config.TempsDePoseTrack:=MyStrToFloat(pop_camera_suivi.Edit5.Text);

WriteSpy(lang('Début du guidage sur la caméra de guidage'));

//On lis la déclinaison courante pour corriger la calibration
Alpha:=0;
DeltaCourant:=0;
if Telescope.StoreCoordinates then
   begin
   if Config.GoodPos then
      begin
      Alpha:=Config.AlphaScope;
      DeltaCourant:=Config.DeltaScope;
      end
   else
      begin
      WriteSpy(lang('Le télescope ne veut pas donner sa position'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope ne veut pas donner sa position'));
      WriteSpy(lang('Arrêt du guidage'));
      if Assigned(pop_track) then pop_track.AddMessage(lang('Arrêt du guidage'));
      pop_camera_suivi.btnChercher.Enabled:=True;
      pop_camera_suivi.btn_calibrer.Enabled:=True;
      pop_camera_suivi.Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         pop_camera_suivi.btn_track_start.enabled:=True;
         pop_camera_suivi.CheckBox2.Enabled:=True;
         end;
      StopGetPos:=False;
      pop_camera_suivi.StopSuivi:=False;
      GuideError:=lang('Le télescope ne veut pas donner sa position');
      EventGuide.SetEvent;
      Free;
      end;

   pop_camera_suivi.NbreEdit1.Text:=MyFloatToStr(DeltaCourant,2);
   end
else DeltaCourant:=MyStrToFloat(pop_camera_suivi.NbreEdit1.Text);

config.LargFenSuivi:=9;
pop_camera_suivi.StopSuivi:=False;

config.LimiteNord :=config.CoefLimitationNS;
config.LimiteSud  :=config.CoefLimitationNS;
config.LimiteEst  :=config.CoefLimitationEO;
config.LimiteOuest:=config.CoefLimitationEO;

Synchronize(AfficheMoniteur);

pop_camera_suivi.btnChercher.Enabled:=False;
pop_camera_suivi.btn_calibrer.Enabled:=False;
pop_camera_suivi.btn_track_start.Enabled:=False;
pop_camera_suivi.Button1.Enabled:=False;
pop_camera_suivi.CheckBox2.Enabled:=False;
StopGetPos:=True;

try
try

Synchronize(CreeImage);
pop_camera_suivi.pop_image_acq.Bloque:=True;

if config.UseTrackSt7 then
   begin
   WriteSpy(lang('Utilisation de la liaison Télescope-ST7'));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Utilisation de la liaison Télescope-ST7'));
   end
else
   begin
   WriteSpy(lang('Commande directe du télescope'));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Commande directe du télescope'));

   WriteSpy(lang('Passage en vitesse de guidage'));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Passage en vitesse de guidage'));

   if not Telescope.MotionRate(Telescope.GetTrackSpeedNumber) then
      begin
      WriteSpy(lang('Le télescope refuse le réglage de vitesse'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse le réglage de vitesse'));
      WriteSpy(lang('Arrêt du guidage'));
      if Assigned(pop_track) then pop_track.AddMessage(lang('Arrêt du guidage'));
      pop_camera_suivi.btnChercher.Enabled:=True;
      pop_camera_suivi.btn_calibrer.Enabled:=True;
      pop_camera_suivi.Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         pop_camera_suivi.btn_track_start.enabled:=True;
         pop_camera_suivi.CheckBox2.Enabled:=True;
         end;
      pop_camera_suivi.StopSuivi:=False;
      StopGetPos:=False;
      GuideError:=lang('Le télescope refuse le réglage de vitesse');
      EventGuide.SetEvent;
      Free;
      end;

   case Telescope.GetTrackSpeedNumber of
      1:pop_scope.btnSpeed1.Down:=True;
      2:pop_scope.btnSpeed2.Down:=True;
      3:pop_scope.btnSpeed3.Down:=True;
      4:pop_scope.btnSpeed4.Down:=True;
      end;
   end;

// Acquisition du noir en binning
if not pop_camera_suivi.NoirBinningAcquis then
   begin
   if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
      begin
      WriteSpy(lang('Acquisition du noir en binning'));
      if Assigned(pop_track) then pop_track.AddMessage(lang('Acquisition du noir en binning'));
      if CameraSuivi.IsAValidBinning(4) then pop_camera_suivi.AcqNoirBinning(4) else pop_camera_suivi.AcqNoirBinning(3);
      pop_camera_suivi.NoirBinningAcquis:=True;
      end;
   end;

// Acquisition du noir sans binning
if not pop_camera_suivi.NoirAcquis then
   begin
   WriteSpy(lang('Acquisition du noir'));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Acquisition du noir'));
   pop_camera_suivi.AcqNoir;
   pop_camera_suivi.NoirAcquis:=True;
   end;

Config.SuiviEnCours:=True;

WriteSpy(lang('Recherche de l''étoile la plus brillante'));
if Assigned(pop_track) then pop_track.AddMessage(lang('Recherche de l''étoile la plus brillante'));

if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
   begin
   pop_camera_suivi.AcqMaximumBinning(config.xCentreSuivi,config.yCentreSuivi);
   if CameraSuivi.IsAValidBinning(4) then
      begin
      config.xCentreSuivi:=config.xCentreSuivi*4;
      config.yCentreSuivi:=config.yCentreSuivi*4;
      end
   else
      begin
      config.xCentreSuivi:=config.xCentreSuivi*3;
      config.yCentreSuivi:=config.yCentreSuivi*3;
      end;
   end
else pop_camera_suivi.AcqMaximum(config.xCentreSuivi,config.yCentreSuivi);

WriteSpy(lang('Coordonnées de l''étoile X=')+IntToStr(config.xCentreSuivi)
   +' Y='+IntToStr(config.yCentreSuivi)); //nolang
if Assigned(pop_track) then pop_track.AddMessage(lang('Coordonnées de l''étoile X=')+IntToStr(config.xCentreSuivi)
   +' Y='+IntToStr(config.yCentreSuivi)); //nolang

if (config.xCentreSuivi<=9) or (config.xCentreSuivi>CameraSuivi.GetXSize-9) or
   (config.yCentreSuivi<=9) or (config.yCentreSuivi>CameraSuivi.GetYSize-9) then
   begin
   WriteSpy(lang('Etoile trop prés du bord'));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Etoile trop prés du bord'));
   pop_camera_suivi.btnChercher.Enabled:=True;
   pop_camera_suivi.btn_calibrer.Enabled:=True;
   pop_camera_suivi.Button1.Enabled:=True;
   if config.CalibrateSuivi then
      begin
      pop_camera_suivi.btn_track_start.enabled:=True;
      pop_camera_suivi.CheckBox2.Enabled:=True;
//      pop_camera_suivi.Button2.Enabled:=True;
      end;
   pop_camera_suivi.StopSuivi:=False;
   StopGetPos:=False;
   GuideError:=lang('Etoile trop prés du bord');
   EventGuide.SetEvent;
//   Terminate;
   Free;
   end;

// Fenetrage en binning 1x1
Config.SuiviRef:=True;
//if CameraSuivi.IsTrackCCD then
   Time1:=Time;
pop_camera_suivi.Acquisition(config.xCentreSuivi-config.LargFenSuivi,config.yCentreSuivi-config.LargFenSuivi,
   config.xCentreSuivi+config.LargFenSuivi,config.yCentreSuivi+config.LargFenSuivi,config.TempsDePoseTrack,
   1,False,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos);

// Juste pour mesurer le max
GetMax(pop_camera_suivi.pop_image_acq.DataInt,pop_camera_suivi.pop_image_acq.dataDouble,pop_camera_suivi.pop_image_acq.ImgInfos.TypeData
   ,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);

//Soustraction du noir
if pop_camera_suivi.NoirAcquis then
   begin
   GetImgPart(pop_camera_suivi.MemPicTrackNoir,ImgDoubleNil,pop_camera_suivi.VignetteNoir,ImgDoubleNil,2,1,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
      pop_camera_suivi.pop_image_acq.ImgInfos.Sy,config.xCentreSuivi-config.LargFenSuivi,config.yCentreSuivi-config.LargFenSuivi,
         config.xCentreSuivi+config.LargFenSuivi,config.yCentreSuivi+config.LargFenSuivi);
   Soust(pop_camera_suivi.pop_image_acq.DataInt,pop_camera_suivi.VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
      pop_camera_suivi.pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy);
   FreememImg(pop_camera_suivi.VignetteNoir,ImgDoubleNil,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,2,1);
   end;

pop_camera_suivi.pop_image_acq.AjusteFenetre;
pop_camera_suivi.pop_image_acq.VisuAutoEtoiles;

//GetMax(pop_camera_suivi.pop_image_acq.DataInt,ImgNil,2,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);

// Si on ne peut pas lire en meme temps le CCD principale et le CCD de guidage (Sbig)
// On mesure le temps de lecture du CCD de guidage pour ne pas prendre
// D'image de guidage juste avant de lire la le CCD principal
//if CameraSuivi.IsTrackCCD then
//   begin
   Time2:=Time;
   Config.TimeAcqTrack:=(Time2-Time1)*24*60*60;
   WriteSpy(lang('Temps d''acquisition : ')+MyFloatToStr(Config.TimeAcqTrack,2)
      +' s'); //nolang
   if Assigned(pop_track) then pop_track.AddMessage(lang('Temps d''acquisition : '+MyFloatToStr(Config.TimeAcqTrack,2)
      +' s')); //nolang
//   end;

// Changer le mini des poses du CCD Principal
if MyStrToFloat(pop_camera.exp_b1.Text)<Config.TimeAcqTrack then
   pop_camera.exp_b1.Text:=MyFloatToStr(Config.TimeAcqTrack,3);
if MyStrToFloat(pop_camera.exp_b2.Text)<Config.TimeAcqTrack then
   pop_camera.exp_b2.Text:=MyFloatToStr(Config.TimeAcqTrack,3);
if MyStrToFloat(pop_camera.exp_b4.Text)<Config.TimeAcqTrack then
   pop_camera.exp_b4.Text:=MyFloatToStr(Config.TimeAcqTrack,3);
pop_camera.PoseMini:=Config.TimeAcqTrack;

// Désaturer en 1x1
WriteSpy(lang('Désaturation de l''étoile si nécessaire'));
if Assigned(pop_track) then pop_track.AddMessage(lang('Désaturation de l''étoile si nécessaire'));
//while (ValMax>config.Satur) and (config.TempsDePoseTrack>config.MinPose) do

// Affichage du max pour vérifier la non saturation
WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
if Assigned(pop_track) then pop_track.AddMessage(
   lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));

while (ValMax>CameraSuivi.GetSaturationLevel) and (config.TempsDePoseTrack>config.MinPose) do
   begin
   if pop_camera_suivi.StopSuivi then
      begin
      pop_camera_suivi.StopSuivi:=False;
      WriteSpy(lang('Arrêt du guidage'));
      if Assigned(pop_track) then pop_track.AddMessage(lang('Arrêt du guidage'));
      pop_camera_suivi.btnChercher.Enabled:=True;
      pop_camera_suivi.btn_calibrer.Enabled:=True;
      pop_camera_suivi.Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         pop_camera_suivi.btn_track_start.enabled:=True;
         pop_camera_suivi.CheckBox2.Enabled:=True;
         end;
      Config.SuiviEnCours:=False;
      StopGetPos:=False;
      GuideError:=lang('Arrêt du guidage');
      EventGuide.SetEvent;
      Free;
      end;
   config.TempsDePoseTrack:=config.TempsDePoseTrack/2;
   WriteSpy(lang('Nouveau temps de pose = '+MyFloatToStr(config.TempsDePoseTrack,2)));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Nouveau temps de pose = '+MyFloatToStr(config.TempsDePoseTrack,2)));

   pop_camera_suivi.Acquisition(config.xCentreSuivi-config.LargFenSuivi,config.yCentreSuivi-config.LargFenSuivi,
      config.xCentreSuivi+config.LargFenSuivi,config.yCentreSuivi+config.LargFenSuivi,config.TempsDePoseTrack,
      1,False,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos);

   //Soustraction du noir
   if pop_camera_suivi.NoirAcquis then
      begin
      GetImgPart(pop_camera_suivi.MemPicTrackNoir,ImgDoubleNil,pop_camera_suivi.VignetteNoir,ImgDoubleNil,2,1,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
         pop_camera_suivi.pop_image_acq.ImgInfos.Sy,config.xCentreSuivi-config.LargFenSuivi,config.yCentreSuivi-config.LargFenSuivi,
            config.xCentreSuivi+config.LargFenSuivi,config.yCentreSuivi+config.LargFenSuivi);
      Soust(pop_camera_suivi.pop_image_acq.DataInt,pop_camera_suivi.VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,
         pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi. pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
         pop_camera_suivi.pop_image_acq.ImgInfos.Sy);
      FreememImg(pop_camera_suivi.VignetteNoir,ImgDoubleNil,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,2,1);
      end;

   pop_camera_suivi.pop_image_acq.AjusteFenetre;
   pop_camera_suivi.pop_image_acq.VisuAutoEtoiles;

   // Juste pour mesurer le max
   GetMax(pop_camera_suivi.pop_image_acq.DataInt,pop_camera_suivi.pop_image_acq.dataDouble,pop_camera_suivi.pop_image_acq.ImgInfos.TypeData
      ,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);
   end;

if ValMax>=CameraSuivi.GetSaturationLevel then
   begin
   WriteSpy(lang('Attention Etoile saturée'));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Attention Etoile saturée'));
   end;

// Premier mesure des coordonnées
// On les garde car il faudra laisser l'etoile sur ces coordonnées
pop_camera_suivi.Acquisition(config.xCentreSuivi-config.LargFenSuivi,config.yCentreSuivi-config.LargFenSuivi,
   config.xCentreSuivi+config.LargFenSuivi,config.yCentreSuivi+config.LargFenSuivi,config.TempsDePoseTrack,
   1,False,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos);

WriteSpy(CameraSuivi.GetName+lang(' Fenêtre : (')+IntToStr(config.xCentreSuivi-config.LargFenSuivi)+','+
   IntToStr(config.yCentreSuivi-config.LargFenSuivi)+lang(')/(')+IntToStr(config.xCentreSuivi+config.LargFenSuivi)+','+
   IntToStr(config.yCentreSuivi+config.LargFenSuivi)+')');
WriteSpy(CameraSuivi.GetName+lang(' Binning : 1'));
WriteSpy(CameraSuivi.GetName+lang(' Temps de pose : ')+MyFloatToStr(config.TempsDePoseTrack,3)+
   lang(' s'));

//Soustraction du noir
if pop_camera_suivi.NoirAcquis then
   begin
   GetImgPart(pop_camera_suivi.MemPicTrackNoir,ImgDoubleNil,pop_camera_suivi.VignetteNoir,ImgDoubleNil,2,1,
      pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,config.xCentreSuivi-config.LargFenSuivi,
      config.yCentreSuivi-config.LargFenSuivi,config.xCentreSuivi+config.LargFenSuivi,
      config.yCentreSuivi+config.LargFenSuivi);
   Soust(pop_camera_suivi.pop_image_acq.DataInt,pop_camera_suivi.VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,
      pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi. pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
      pop_camera_suivi.pop_image_acq.ImgInfos.Sy);
   FreememImg(pop_camera_suivi.VignetteNoir,ImgDoubleNil,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,2,1);
   end;

pop_camera_suivi.pop_image_acq.AjusteFenetre;
pop_camera_suivi.pop_image_acq.VisuAutoEtoiles;

Config.SuiviRef:=False;

GetMax(pop_camera_suivi.pop_image_acq.DataInt,pop_camera_suivi.pop_image_acq.dataDouble,pop_camera_suivi.pop_image_acq.ImgInfos.TypeData
   ,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);
// Recentrage sur la position mesuree par GetMax
//config.xCentreSuivi:=config.xCentreSuivi-config.LargFenSuivi+xx;
//config.yCentreSuivi:=config.yCentreSuivi-config.LargFenSuivi+yy;
//ModeliseEtoile(pop_camera_suivi.pop_image_acq.DataInt,nil,2,2*config.LargFenSuivi+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
ModeliseEtoile(pop_camera_suivi.pop_image_acq.DataInt,pop_camera_suivi.pop_image_acq.DataDouble,
   pop_camera_suivi.pop_image_acq.ImgInfos.TypeData,2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);

if PSF.Flux=-1 then
   begin
   WriteSpy(lang('Echec de la modélisation'));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Echec de la modélisation'));
   pop_camera_suivi.btnChercher.Enabled:=True;
   pop_camera_suivi.btn_calibrer.Enabled:=True;
   pop_camera_suivi.Button1.Enabled:=True;
   if config.CalibrateSuivi then
      begin
      pop_camera_suivi.btn_track_start.enabled:=True;
      pop_camera_suivi.CheckBox2.Enabled:=True;
//      pop_camera_suivi.Button2.Enabled:=True;
      end;
   pop_camera_suivi.StopSuivi:=False;
   Config.SuiviEnCours:=False;
   StopGetPos:=False;
   GuideError:=lang('Echec de la modélisation');
   EventGuide.SetEvent;
//   Terminate;
   Free;
   end
else
   begin
   Reussit:=True;
//   config.XSuivi:=config.xCentreSuivi-config.LargFenSuivi+PSF.X-1;
//   config.YSuivi:=config.yCentreSuivi-config.LargFenSuivi+PSF.Y-1;
   config.XSuivi:=config.xCentreSuivi-config.LargFenSuivi+PSF.X;
   config.YSuivi:=config.yCentreSuivi-config.LargFenSuivi+PSF.Y;
   if (Assigned(pop_track)) and (PSF.Flux<>-1) then
      pop_track.Add(HeureToJourJulien(GetHourDT),config.XSuivi,config.YSuivi);
   WriteSpy(lang('Coordonnées de référence x = ')+MyFloatToStr(config.XSuivi,2)
      +' / y = '+MyFloatToStr(config.YSuivi,2)); //nolang
   if Assigned(pop_track) then
   pop_track.AddMessage(lang('Coordonnées de référence x = ')+MyFloatToStr(config.XSuivi,2)
      +' / y = '+MyFloatToStr(config.YSuivi,2)); //nolang
   WriteSpy(lang('Erreur de guidage x = ')+MyFloatToStr(0,2)
     +' / y = '+MyFloatToStr(0,2)); //nolang
   if Assigned(pop_track) then
   pop_track.AddErreurSuivi(0,0);
   end;

pop_track.AddLimiteNord(config.LimiteNord);
pop_track.AddLimiteSud(config.LimiteSud);
pop_track.AddLimiteEst(config.LimiteEst);
pop_track.AddLimiteOuest(config.LimiteOuest);
pop_track.AddMoveNord(0);
pop_track.AddMoveSud(0);
pop_track.AddMoveEst(0);
pop_track.AddMoveOuest(0);

// Le guidage est OK !
EventGuide.SetEvent;
//**********************************************************************************************
//**********************************************************************************************
//******************************         Boucle de guidage         *****************************
//**********************************************************************************************
//**********************************************************************************************
config.NbMesure:=1;
NbEchec:=0;
while not(pop_camera_suivi.StopSuivi) and (NbEchec<config.NbEssaiCentroMaxi) do
   begin
   if pop_camera_suivi.StopSuivi then
      begin
      pop_camera_suivi.StopSuivi:=False;
      WriteSpy(lang('Arrêt du guidage'));
      if Assigned(pop_track) then pop_track.AddMessage(lang('Arrêt du guidage'));
      pop_camera_suivi.btnChercher.Enabled:=True;
      pop_camera_suivi.btn_calibrer.Enabled:=True;
      pop_camera_suivi.Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         pop_camera_suivi.btn_track_start.enabled:=True;
         pop_camera_suivi.CheckBox2.Enabled:=True;
//         pop_camera_suivi.Button2.Enabled:=True;
         end;
      Config.SuiviEnCours:=False;
      StopGetPos:=False;
//      Terminate;
      Free;
      end;

   // Attention a la pose du CCD principal (1 seconde de marge)
   // C'est bien pop_camera et non pop_camera_suivi !!!!!!
   // BloqueGuidage sert a bloquer le guidage si l'utilisateur stoppe la pose principale pendant une pose de guidage
   if (((pop_camera.NbInterValPose-pop_camera.NbInterValCourant)*Intervalle/1000>Config.TimeAcqTrack+1) or
      (pop_camera.NbInterValPose=0)) and // Si pas d'acquisition en cours
      not(Config.BloqueGuidage) then
      begin
      MesureEnCours:=True;
      pop_camera_suivi.Acquisition(config.xCentreSuivi-config.LargFenSuivi,config.yCentreSuivi-config.LargFenSuivi,
         config.xCentreSuivi+config.LargFenSuivi,config.yCentreSuivi+config.LargFenSuivi,
         config.TempsDePoseTrack,1,False,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,
         pop_camera_suivi.pop_image_acq.ImgInfos);
      //Soustraction du noir
      if pop_camera_suivi.NoirAcquis then
         begin
         GetImgPart(pop_camera_suivi.MemPicTrackNoir,ImgDoubleNil,pop_camera_suivi.VignetteNoir,ImgDoubleNil,2,1,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
            pop_camera_suivi.pop_image_acq.ImgInfos.Sy,config.xCentreSuivi-config.LargFenSuivi,config.yCentreSuivi-config.LargFenSuivi,
            config.xCentreSuivi+config.LargFenSuivi,config.yCentreSuivi+config.LargFenSuivi);
         Soust(pop_camera_suivi.pop_image_acq.DataInt,pop_camera_suivi.VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
            pop_camera_suivi.pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy);
         FreememImg(pop_camera_suivi.VignetteNoir,ImgDoubleNil,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,2,1);
         end;

      pop_camera_suivi.pop_image_acq.AjusteFenetre;
      pop_camera_suivi.pop_image_acq.VisuAutoEtoiles;
      ModeliseEtoile(pop_camera_suivi.pop_image_acq.DataInt,pop_camera_suivi.pop_image_acq.DataDouble,
         pop_camera_suivi.pop_image_acq.ImgInfos.TypeData,2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);


      if PSF.Flux=-1 then
         begin
         WriteSpy(lang('Echec de la modélisation'));
         if Assigned(pop_track) then pop_track.AddMessage(lang('Echec de la modélisation'));
         Inc(NbEchec);
         end
      else
         begin
         NbEchec:=0;
         Inc(config.NbMesure);

         // On affiche le positon de l'etoile de guidage
//         config.XMesure:=config.xCentreSuivi-config.LargFenSuivi+PSF.X-1;
//         config.YMesure:=config.yCentreSuivi-config.LargFenSuivi+PSF.Y-1;
         config.XMesure:=config.xCentreSuivi-config.LargFenSuivi+PSF.X;
         config.YMesure:=config.yCentreSuivi-config.LargFenSuivi+PSF.Y;

         // Recentrage sur la position mesuree
         if Config.TypeCameraSuivi<>Virtuelle then
            begin
            config.xCentreSuivi:=Round(config.xCentreSuivi-config.LargFenSuivi+PSF.X);
            config.yCentreSuivi:=Round(config.yCentreSuivi-config.LargFenSuivi+PSF.Y);
            end;

         if Assigned(pop_track) then
            pop_track.Add(HeureToJourJulien(GetHourDT),config.XMesure,config.YMesure);
         WriteSpy(lang('Coordonnées actuelles x = ')+MyFloatToStr(config.XMesure,2)
           +' / y = '+MyFloatToStr(config.YMesure,2)); //nolang
         // On affiche l'erreur de guidage
         pop_camera_suivi.ErreurX:=config.XMesure-(config.XSuivi+Config.xDeplaceSuivi);
         pop_camera_suivi.ErreurY:=config.YMesure-(config.YSuivi+Config.yDeplaceSuivi);
         // C'est good ?
//         TrackGood:=False;
         MesureEnCours:=False;
         if (Abs(pop_camera_suivi.ErreurX)<Config.ErreurGoodTrack) and
            (Abs(pop_camera_suivi.ErreurY)<Config.ErreurGoodTrack) then
            TrackGood:=True;

         WriteSpy(lang('Erreur de guidage x = ')+MyFloatToStr(pop_camera_suivi.ErreurX,2)
           +' / y = '+MyFloatToStr(pop_camera_suivi.ErreurY,2)); //nolang
         if Assigned(pop_track) then
            pop_track.AddErreurSuivi(pop_camera_suivi.ErreurX,pop_camera_suivi.ErreurY);

         // Phase de deplacement
         DeltaX:=((config.XSuivi+Config.xDeplaceSuivi)-config.XMesure)*CameraSuivi.GetXPixelSize;
         DeltaY:=((config.YSuivi+Config.yDeplaceSuivi)-config.YMesure)*CameraSuivi.GetYPixelSize;

         // Si le deplacement est superieur au deplacement mini
         if Hypot(DeltaX,DeltaY)>MoveMini then
            begin
            DeplacementNord:=0;
            DeplacementSud:=0;
            DeplacementEst:=0;
            DeplacementOuest:=0;
            TimeMoveST7_1:=0;
            TimeMoveST7_2:=0;
            TimeMove:=0;

            // Produit scalaire sur chaque vecteurs pour trouver les composantes du deplacement
            DeplacementNord:=(DeltaX*config.VecteurNordX+DeltaY*config.VecteurNordY)/
               Hypot(config.VecteurNordX,config.VecteurNordY);
            DeplacementSud:=(DeltaX*config.VecteurSudX+DeltaY*config.VecteurSudY)/
               Hypot(config.VecteurSudX,config.VecteurSudY);
            DeplacementEst:=(DeltaX*config.VecteurEstX+DeltaY*config.VecteurEstY)/
               Hypot(config.VecteurEstX,config.VecteurEstY)*Inv;
            DeplacementOuest:=(DeltaX*config.VecteurOuestX+DeltaY*config.VecteurOuestY)/
               Hypot(config.VecteurOuestX,config.VecteurOuestY)*Inv;

            if DeplacementNord>0 then
               WriteSpy(lang('Déplacement vers le Nord / Distance = ')+MyFloatToStr(DeplacementNord,2)
                  +' microns'); //nolang
            if DeplacementSud>0 then
               WriteSpy(lang('Déplacement vers le Sud / Distance = ')+MyFloatToStr(DeplacementSud,2)
                  +' microns'); //nolang
            if DeplacementEst>0 then
               WriteSpy(lang('Déplacement vers l''Est / Distance = ')+MyFloatToStr(DeplacementEst,2)
                  +' microns'); //nolang
            if DeplacementOuest>0 then
               WriteSpy(lang('Déplacement vers l''Ouest / Distance = ')+MyFloatToStr(DeplacementOuest,2)
                  +' microns'); //nolang

            // On limite le deplacement a 1
   //               if DeplacementNord>1 then DeplacementNord:=1;
   //               if DeplacementSud>1 then DeplacementSud:=1;
   //               if DeplacementEst>1 then DeplacementEst:=1;
   //               if DeplacementOuest>1 then DeplacementOuest:=1;

            // Pas possible si une seule mesure
            if Config.NbMesure>1 then
               begin
               // Si l'adaptation de la limitation est activee
               if Config.Limite and (Config.NbMesure>2) then
                  begin
                  if (Config.OldDeplacementNord>0) and (DeplacementNord<0) then
                     begin
                     //Surcorrection
                     if config.LimiteNord>0.1 then config.LimiteNord:=config.LimiteNord-0.1;
                     WriteSpy(lang('Surcorrection vers le nord / Modération Nord - 0.1 = ')+MyFloatToStr(config.LimiteNord,2));
//                     if Assigned(pop_track) then
//                        pop_track.AddMessage(lang('Surcorrection vers le nord / LimiteNord-0.1 = ')+FloatToStrF(config.LimiteNord,ffFixed,4,2));
                     if Assigned(pop_track) then
                        pop_track.AddLimiteNord(config.LimiteNord);
                     end;
                  if (config.OldDeplacementNord>0) and (DeplacementNord>0) then
                     begin
                     //Souscorrection
                     if config.LimiteNord<LimiteSous then config.LimiteNord:=config.LimiteNord+0.1;
                     WriteSpy(lang('Souscorrection vers le nord / Modération Nord + 0.1 = ')+MyFloatToStr(config.LimiteNord,2));
//                     if Assigned(pop_track) then
//                        pop_track.AddMessage(lang('Souscorrection vers le nord / LimiteNord+0.1 = ')+FloatToStrF(config.LimiteNord,ffFixed,4,2));
                     if Assigned(pop_track) then
                        pop_track.AddLimiteNord(config.LimiteNord);
                     end;

                  if (config.OldDeplacementSud>0) and (DeplacementSud<0) then
                     begin
                     //Surcorrection
                     if config.LimiteSud>0.1 then config.LimiteSud:=config.LimiteSud-0.1;
                     WriteSpy(lang('Surcorrection vers le sud / Modération Sud - 0.1 = ')+MyFloatToStr(config.LimiteSud,2));
//                     if Assigned(pop_track) then
//                        pop_track.AddMessage(lang('Surcorrection vers le sud / LimiteSud-0.1 = ')+FloatToStrF(config.LimiteSud,ffFixed,4,2));
                     if Assigned(pop_track) then
                        pop_track.AddLimiteSud(config.LimiteSud);
                     end;
                  if (config.OldDeplacementSud>0) and (DeplacementSud>0) then
                     begin
                     //Souscorrection
                     if config.LimiteSud<LimiteSous then config.LimiteSud:=config.LimiteSud+0.1;
                     WriteSpy(lang('Souscorrection vers le sud / Modération Sud + 0.1 = ')+MyFloatToStr(config.LimiteSud,2));
//                     if Assigned(pop_track) then
//                        pop_track.AddMessage(lang('Souscorrection vers le sud / LimiteSud+0.1 = ')+FloatToStrF(config.LimiteSud,ffFixed,4,2));
                     if Assigned(pop_track) then
                        pop_track.AddLimiteSud(config.LimiteSud);
                     end;

                  if (config.OldDeplacementEst>0) and (DeplacementEst<0) then
                     begin
                     //Surcorrection
                     if config.LimiteEst>0.1 then config.LimiteEst:=config.LimiteEst-0.1;
                     WriteSpy(lang('Surcorrection vers l''est / Modération Est - 0.1 = ')+MyFloatToStr(config.LimiteEst,2));
//                     if Assigned(pop_track) then
//                        pop_track.AddMessage(lang('Surcorrection vers l''est / LimiteEst-0.1 = ')+FloatToStrF(config.LimiteEst,ffFixed,4,2));
                     if Assigned(pop_track) then
                        pop_track.AddLimiteEst(config.LimiteEst);
                     end;
                  if (config.OldDeplacementEst>0) and (DeplacementEst>0) then
                     begin
                     //Souscorrection
                     if config.LimiteEst<LimiteSous then config.LimiteEst:=config.LimiteEst+0.1;
                     WriteSpy(lang('Souscorrection vers l''est / Modération Est + 0.1 = ')+MyFloatToStr(config.LimiteEst,2));
//                     if Assigned(pop_track) then
//                        pop_track.AddMessage(lang('Souscorrection vers l''est / LimiteEst+0.1 = ')+FloatToStrF(config.LimiteEst,ffFixed,4,2));
                     if Assigned(pop_track) then
                        pop_track.AddLimiteEst(config.LimiteEst);
                     end;

                  if (config.OldDeplacementOuest>0) and (DeplacementOuest<0) then
                     begin
                     //Surcorrection
                     if config.LimiteOuest>0.1 then config.LimiteOuest:=config.LimiteOuest-0.1;
                     WriteSpy(lang('Surcorrection vers l''ouest / Modération Ouest - 0.1 = ')+MyFloatToStr(config.LimiteOuest,2));
//                     if Assigned(pop_track) then
//                        pop_track.AddMessage(lang('Surcorrection vers l''ouest / LimiteOuest-0.1 = ')+FloatToStrF(config.LimiteOuest,ffFixed,4,2));
                     if Assigned(pop_track) then
                        pop_track.AddLimiteOuest(config.LimiteOuest);
                     end;
                  if (config.OldDeplacementOuest>0) and (DeplacementOuest>0) then
                     begin
                     //Souscorrection
                     if config.LimiteOuest<LimiteSous then config.LimiteOuest:=config.LimiteOuest+0.1;
                     WriteSpy(lang('Souscorrection vers l''ouest / Modération Ouest + 0.1 = ')+MyFloatToStr(config.LimiteOuest,2));
//                     if Assigned(pop_track) then
//                        pop_track.AddMessage(lang('Souscorrection vers l''ouest / LimiteOuest+0.1 = ')+FloatToStrF(config.LimiteOuest,ffFixed,4,2));
                     if Assigned(pop_track) then
                        pop_track.AddLimiteOuest(config.LimiteOuest);
                     end;
                  end;
               end;

            // Sauvegarde ce qui sera le deplacement precedent
            config.OldDeplacementNord:=DeplacementNord;
            config.OldDeplacementSud:=DeplacementSud;
            config.OldDeplacementEst:=DeplacementEst;
            config.OldDeplacementOuest:=DeplacementOuest;

            // On se deplace
            // Si c'est la ST7, on utilise la liaison ST7/LX
            if config.UseTrackST7 then
               begin
               if DeplacementNord>0 then
                  begin
                  TimeMoveST7_1:=Round(100*DeplacementNord*config.DelaiCalibrationSuiviNS/
                                      Hypot(config.VecteurNordX,config.VecteurNordY)*config.LimiteNord);
                  WriteSpy(lang('Déplacement vers le Nord / Durée = ')+MyFloatToStr(TimeMoveST7_1*10,0)
                     +' ms'); //nolang
//                  if Assigned(pop_track) then
//                     pop_track.AddMessage(lang('Déplacement vers le Nord / Durée = ')
//                        +MyFloatToStr(TimeMoveST7_1*10,0)+' ms'); //nolang
                  if Assigned(pop_track) then pop_track.AddMoveNord(TimeMoveST7_1/100);
                  end;
               if DeplacementSud>0 then
                  begin
                  TimeMoveST7_1:=Round(-100*DeplacementSud*config.DelaiCalibrationSuiviNS/
                                    Hypot(config.VecteurSudX,config.VecteurSudY)*config.LimiteSud);
                  WriteSpy(lang('Déplacement vers le Sud / Durée = ')
                     +MyFloatToStr(TimeMoveST7_1*10,0)+' ms'); //nolang
//                  if Assigned(pop_track) then
//                     pop_track.AddMessage(lang('Déplacement vers le Sud / Durée = ')
//                        +MyFloatToStr(TimeMoveST7_1*10,0)+' s'); //nolang
                  if Assigned(pop_track) then pop_track.AddMoveSud(TimeMoveST7_1/100);
                  end;
               if DeplacementEst>0 then
                  begin
                  TimeMoveST7_2:=Round(100*DeplacementEst*config.DelaiCalibrationSuiviEO/
                     Hypot(config.VecteurEstX,config.VecteurEstY)*config.LimiteEst*Cos(Config.DeltaSuivi/180*pi)/Cos(DeltaCourant/180*pi));
                  WriteSpy(lang('Déplacement vers l''Est / Durée = ')
                     +MyFloatToStr(TimeMoveST7_2*10,0)+' ms'); //nolang
//                  if Assigned(pop_track) then
//                     pop_track.AddMessage(lang('Déplacement vers l''Est / Durée = ')
//                        +MyFloatToStr(TimeMoveST7_2*10,0)+' ms'); //nolang
                  if Assigned(pop_track) then pop_track.AddMoveEst(TimeMoveST7_2/100);
                  end;
               if DeplacementOuest>0 then
                  begin
                  TimeMoveST7_2:=Round(-100*DeplacementOuest*config.DelaiCalibrationSuiviEO/
                  Hypot(config.VecteurOuestX,config.VecteurOuestY)*config.LimiteOuest*Cos(Config.DeltaSuivi/180*pi)/Cos(DeltaCourant/180*pi));
                  WriteSpy(lang('Déplacement vers l''Ouest / Durée = ')
                     +MyFloatToStr(TimeMoveST7_2*10,0)+' ms'); //nolang
//                  if Assigned(pop_track) then
//                     pop_track.AddMessage(lang('Déplacement vers l''Ouest / Durée = ')
//                        +MyFloatToStr(TimeMoveST7_2*10,0)+' ms'); //nolang
                  if Assigned(pop_track) then pop_track.AddMoveOuest(TimeMoveST7_2/100);
                  end;

               ActivateRelaySbig(TimeMoveST7_2,TimeMoveST7_1);

               // On attends
               TimeInit:=Time;
               if TimeMoveST7_1>TimeMoveST7_2 then
                  while Time<TimeInit+(TimeMoveST7_1/100+1)/60/60/24 do Application.ProcessMessages
               else
                  while Time<TimeInit+(TimeMoveST7_2/100+1)/60/60/24 do Application.ProcessMessages;


               end
            else
               // Sinon on utilise la liaison PC-LX
               begin
               if DeplacementNord>0 then
                  begin
                  TimeMove:=DeplacementNord*config.DelaiCalibrationSuiviNS/
                     Hypot(config.VecteurNordX,config.VecteurNordY)*config.LimiteNord;
                  WriteSpy(lang('Déplacement vers le Nord / Durée = ')
                     +MyFloatToStr(TimeMove*1000,0)+' ms'); //nolang
//                  if Assigned(pop_track) then
//                     pop_track.AddMessage(lang('Déplacement vers le Nord / Durée = ')
//                        +MyFloatToStr(TimeMove*1000,0)+' ms'); //nolang
                  if Assigned(pop_track) then pop_track.AddMoveNord(TimeMove);

                  if not Telescope.StartMotion('N') then
                     begin
                     WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
                     pop_Main.AfficheMessage(lang('Erreur'),
                        lang('Le télescope refuse de démarrer le déplacement'));
                     Exit;
                     end;

                  TimeInit:=Time;
                  while Time<TimeInit+TimeMove/60/60/24 do Application.ProcessMessages;

                  if not Telescope.StopMotion('N') then
                     begin
                     WriteSpy('Panique ! Le télescope refuse de s''arrêter');
                     pop_Main.AfficheMessage(lang('Erreur'),
                        'Panique ! Le télescope refuse de s''arrêter');
                     end;

                  end;
               if DeplacementSud>0 then
                  begin
                  TimeMove:=DeplacementSud*config.DelaiCalibrationSuiviNS/
                     Hypot(config.VecteurSudX,config.VecteurSudY)*config.LimiteSud;
                  WriteSpy(lang('Déplacement vers le Sud / Durée = ')
                     +MyFloatToStr(TimeMove*1000,0)+' ms'); //nolang
//                  if Assigned(pop_track) then
//                     pop_track.AddMessage(lang('Déplacement vers le Sud / Durée = ')
//                        +MyFloatToStr(TimeMove*1000,0)+' ms'); //nolang
                  if Assigned(pop_track) then pop_track.AddMoveSud(TimeMove);

                  if not Telescope.StartMotion('S') then
                     begin
                     WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
                     pop_Main.AfficheMessage(lang('Erreur'),
                        lang('Le télescope refuse de démarrer le déplacement'));
                     Exit;
                     end;

                  TimeInit:=Time;
                  while Time<TimeInit+TimeMove/60/60/24 do Application.ProcessMessages;

                  if not Telescope.StopMotion('S') then
                     begin
                     WriteSpy('Panique ! Le télescope refuse de s''arrêter');
                     pop_Main.AfficheMessage(lang('Erreur'),
                        'Panique ! Le télescope refuse de s''arrêter');
                     end;

                  end;
               if DeplacementEst>0 then
                  begin
                  TimeMove:=DeplacementEst*config.DelaiCalibrationSuiviEO/
                     Hypot(config.VecteurEstX,config.VecteurEstY)*config.LimiteEst*
                     Cos(Config.DeltaSuivi/180*pi)/Cos(DeltaCourant/180*pi);
                  WriteSpy(lang('Déplacement vers l''Est / Durée = ')
                     +MyFloatToStr(TimeMove*1000,0)+' ms'); //nolang
//                  if Assigned(pop_track) then
//                     pop_track.AddMessage(lang('Déplacement vers l''Est / Durée = ')
//                        +MyFloatToStr(TimeMove*1000,0)+' ms'); //nolang
                  if Assigned(pop_track) then pop_track.AddMoveEst(TimeMove);

                  if not Telescope.StartMotion('E') then
                     begin
                     WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
                     pop_Main.AfficheMessage(lang('Erreur'),
                        lang('Le télescope refuse de démarrer le déplacement'));
                     Exit;
                     end;

                  TimeInit:=Time;
                  while Time<TimeInit+TimeMove/60/60/24 do Application.ProcessMessages;

                  if not Telescope.StopMotion('E') then
                     begin
                     WriteSpy('Panique ! Le télescope refuse de s''arrêter');
                     pop_Main.AfficheMessage(lang('Erreur'),
                        'Panique ! Le télescope refuse de s''arrêter');
                     end;

                  end;
               if DeplacementOuest>0 then
                  begin
                  TimeMove:=DeplacementOuest*config.DelaiCalibrationSuiviEO/
                     Hypot(config.VecteurOuestX,config.VecteurOuestY)*config.LimiteOuest*
                     Cos(Config.DeltaSuivi/180*pi)/Cos(DeltaCourant/180*pi);
                  WriteSpy(lang('Déplacement vers l''Ouest / Durée = ')
                     +MyFloatToStr(TimeMove*1000,0)+' ms'); //nolang
//                  if Assigned(pop_track) then
//                     pop_track.AddMessage(lang('Déplacement vers l''Ouest / Durée = ')
//                        +MyFloatToStr(TimeMove*1000,0)+' ms'); //nolang
                  if Assigned(pop_track) then pop_track.AddMoveOuest(TimeMove);

                  if not Telescope.StartMotion('W') then
                     begin
                     WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
                     pop_Main.AfficheMessage(lang('Erreur'),
                        lang('Le télescope refuse de démarrer le déplacement'));
                     Exit;
                     end;

                  TimeInit:=Time;
                  while Time<TimeInit+TimeMove/60/60/24 do Application.ProcessMessages;

                  if not Telescope.StopMotion('W') then
                     begin
                     WriteSpy('Panique ! Le télescope refuse de s''arrêter');
                     pop_Main.AfficheMessage(lang('Erreur'),
                        'Panique ! Le télescope refuse de s''arrêter');
                     end;

                  end;
               end;
            end;
         end;
      end;
   end;

if NbEchec=config.NbEssaiCentroMaxi then
   begin
   WriteSpy('On a atteint le nombre maxi d''échecs de modélisation, on arrête');
   WriteSpy('Changez d''étoile ou recentrez la');
   if Assigned(pop_track) then
      begin
      pop_track.AddMessage('On a atteint le nombre maxi d''échecs de modélisation, on arrête');
      pop_track.AddMessage('Changez d''étoile ou recentrez la');
      end;
   end;

WriteSpy(lang('Arrêt du guidage'));
if Assigned(pop_track) then pop_track.AddMessage(lang('Arrêt du guidage'));

except
Config.CameraSuiviBranchee:=False;
pop_main.UpDateGUICameraSuivi;
end;
finally
Config.SuiviEnCours:=False;
//CameraSuivi.SetTrackRunning(False);
if pop_camera_suivi.pop_image_acq<>nil then pop_camera_suivi.pop_image_acq.Bloque:=False;
pop_camera_suivi.btnChercher.Enabled:=True;
pop_camera_suivi.btn_calibrer.Enabled:=True;
pop_camera_suivi.Button1.Enabled:=True;
if config.CalibrateSuivi then
   begin
   pop_camera_suivi.btn_track_start.enabled:=True;
   pop_camera_suivi.CheckBox2.Enabled:=True;
//   pop_camera_suivi.Button2.Enabled:=True;
   end
else pop_camera_suivi.btn_track_start.enabled:=False;
StopGetPos:=False;
end;
end;

// lecture cameras
procedure Tpop_camera_suivi.FormCreate(Sender: TObject);
begin
EventGuide:=TEvent.Create(nil,True,FALSE,'');
EventPoseSuivi:=TEvent.Create(nil,True,FALSE,'');

StopSuivi:=False;
StopGetPos:=False;
PoseEnCours:=False;
Edit5.Text:='1';
end;

procedure tpop_camera_suivi.update_stats(x,y:integer; min,mediane,max,moy,ecart:double);
var
listitem:tlistitem;
size:integer;
begin
     memo_stats.lines.clear;
     memo_stats.lines.add(lang('Minimum: ')+#13#10+FloatToStrF(min,ffFixed,10,2));
     memo_stats.Lines.add('------------------'); //nolang
     memo_stats.lines.add(lang('Maximum: ')+#13#10+FloatToStrF(max,ffFixed,10,2));
          memo_stats.Lines.add('------------------'); //nolang
     memo_stats.lines.add(lang('Mediane: ')+#13#10+FloatToStrF(mediane,ffFixed,10,2));
          memo_stats.Lines.add('------------------'); //nolang
     memo_stats.lines.add(lang('Moyenne: ')+#13#10+floattostrf(moy,fffixed,10,2));
          memo_stats.Lines.add('------------------'); //nolang
     memo_stats.lines.add(lang('Sigma  : ')+#13#10+floattostrf(ecart,fffixed,10,2)); 
          memo_stats.Lines.add('------------------'); //nolang
{     with pop_stats.lv_statinfo do
     begin
          listitem:=items.add;
          listitem.caption:=FloatToStrF(min,fffixed,10,2);
          listitem.SubItems.Add(FloatToStrF(max,fffixed,10,2));
          listitem.subitems.add(FloatToStrF(mediane,fffixed,10,2));
          listitem.subitems.add(floattostrf(moy,fffixed,10,2));
          listitem.subitems.add(floattostrf(ecart,fffixed,10,2));
          size:=x*y*2 div 1024;
          listitem.subitems.add(inttostr(size))
     end;;}
end;


procedure Tpop_camera_suivi.btn_closeClick(Sender: TObject);
begin
   Close;
end;

{gestion raquettes}

// Fonction de guidage auto sur une étoile
// Verifier l'impact des miroirs sur la localisation de l'étoile
procedure tpop_camera_suivi.btn_track_startClick(Sender: TObject);
var
   ThreadSuivi:TSuiviThread;
   Alpha,AH:Double;
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   i:Integer;
   Guide:Boolean;
begin
Guide:=True;

// Est-on du meme cote du meridien que la calibration ?
if Telescope.StoreCoordinates then
   begin
   if Config.GoodPos then
      begin
      Alpha:=Config.AlphaScope;
      AH:=GetHourAngle(GetHourDT,Alpha,Config.Long)/15; //Degres -> heure
      end
   else
      begin
      WriteSpy(lang('Le télescope ne veut pas donner sa position'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope ne veut pas donner sa position'));
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      Exit;
      end;

   if (AH-12)*(Config.AHSuivi-12)<0 then
      begin
      try
      New(TabItems);

      for i:=1 to NbMaxItems do TabItems^[i].Msg:='';

      with TabItems^[1] do
         begin
         TypeItem:=tiLabel;
         Msg:=lang('Le télescope est passé de l’autre côté du plan méridien depuis la calibration.'+#13
           +'S''il est resté dans la zône de sécurité vous devez cocher la case « Inverser l’orientation »'+#13
           +lang('dans la fenètre de guidage »'));
         end;

      DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,200);
      DlgStandard.SetOKButton(lang('Guider'));
      DlgStandard.Caption:=lang('Calibration');
      if DlgStandard.ShowModal<>mrOK then Guide:=False;

      finally
      Dispose(TabItems);
      end;

      end;
   end;

if Guide then
   begin
   EventGuide.ResetEvent;
   GuideError:='';
   ThreadSuivi:=TSuiviThread.Create;
   end;

end;

procedure tpop_camera_suivi.btn_track_stopClick(Sender: TObject);
begin
StopSuivi:=True;
config.CalibrationEnCours:=False;
//CameraSuivi.SetTrackRunning(False);
if Config.CalibrationEnCours then
   begin
   WriteSpy(lang('Demande de l''arrêt de la calibration'));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Demande de l''arrêt de la calibration'));
   end;
if Config.SuiviEnCours then
   begin
   WriteSpy(lang('Demande de l''arrêt du guidage'));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Demande de l''arrêt du guidage'));
   end;
StopGetPos:=False;
// Si la CCD principale est en attente d'un bon guidage, on l'arrete
if Config.SuiviEnCours then
//if Config.SuiviEnCours and not TrackGood  then
   pop_camera.Stop1Click(Sender);
config.SuiviEnCours:=False;   
end;

procedure Tpop_camera_suivi.FormShow(Sender: TObject);
var
   Ini:TMemIniFile;
   Path:string;
   Valeur:Integer;
begin
// Lit la pos
Path:=ExtractFilePath(Application.Exename);
Ini:=TMemIniFile.Create(Path+'TeleAuto.ini'); //nolang
try
Valeur:=StrToInt(Ini.ReadString('WindowsPos','CCDTrackTop',IntToStr(Self.Top)));
if Valeur<>0 then Top:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','CCDTrackLeft',IntToStr(Self.Left)));
if Valeur<>0 then Left:=Valeur;
finally
Ini.UpdateFile;
Ini.Free;
end;

Caption:=lang('CCD de guidage : ')+CameraSuivi.GetName;
Left:=Screen.Width-Width;

if config.CalibrateSuivi then
   begin
   btn_track_start.enabled:=True;
   Button2.Enabled:=True;
   CheckBox2.Enabled:=True;
   end
else
   begin
   btn_track_start.enabled:=False;
   Button2.Enabled:=False;
   CheckBox2.Enabled:=False;
   end;

if not(Config.TelescopeBranche) then
   begin
   btnChercher.Enabled:=False;
   btn_Calibrer.Enabled:=False;
   btn_track_start.Enabled:=False;
   btn_track_stop.Enabled:=False;
   Button2.Enabled:=False;
   // Oui mais si c'est une ST7 Track avec commande par liaision ST7-LX ca marche
   if (Config.TypeCameraSuivi=STTrack) and (Config.UseTrackSt7) then
      begin
      btnChercher.Enabled:=True;
      btn_Calibrer.Enabled:=True;
      btn_track_start.Enabled:=True;
      btn_track_stop.Enabled:=True;
      end;
   end
else
   begin
   btnChercher.Enabled:=True;
   btn_Calibrer.Enabled:=True;
   end;

if Config.TypeCamera<>ST7 then
   begin
//   outbtn_track.Enabled:=False; // CCD -> Guidage
//   outButton1.Enabled:=False; // Guidage -> CCD
   end;

NoirAcquis:=False;

if not(CameraSuivi.IsAValidBinning(4)) and not(CameraSuivi.IsAValidBinning(3))then
   begin
   outAcqB4.Visible:=False;
   outAcqB1.Width:=Stop.Width div 2;
   outAcqB2.Left:=Stop.Left+Stop.Width div 2;
   outAcqB2.Width:=Stop.Width div 2;
   end;

// webcam

panel2.visible:=false;
panel2.sendtoback;
if CameraSuivi.ShowConfigPanel(false) then
   begin
   panel2.visible:=true;
   panel2.bringtofront;
   end;

if Config.TelescopeBranche and not Telescope.StoreCoordinates then
   begin
   NbreEdit1.Visible:=False;
   Label1.Visible:=False;
   Label2.Visible:=False;

   Button2.Top:=108;
   Label25.Top:=284;
   Panel1.Top:=276;
   Panel2.Top:=268;
   CheckBox1.Top:=244;
   CheckBox2.Top:=110;
   GroupBox3.Height:=137;
   memo_stats.Height:=265;
   progress.Height:=265;
   Height:=330;
   end
else
   begin
   NbreEdit1.Visible:=True;
   Label1.Visible:=True;
   Label2.Visible:=True;

   Button2.Top:=116;
   Label25.Top:=296;
   Panel1.Top:=288;
   Panel2.Top:=276;
   CheckBox1.Top:=252;
   CheckBox2.Top:=104;
   GroupBox3.Height:=149;
   memo_stats.Height:=273;
   progress.Height:=273;
   Height:=342;
   end;

NbreEdit1.Text:='0';

UpDateLang(Self);
end;

procedure Tpop_camera_suivi.Stop1Click(Sender: TObject);
begin
   pop_image_acq.AcqRunning:=False;
   outAcqB1.Visible:=True;
   outAcqB2.Visible:=True;
   Stop.Visible:=False;
   outAcqB4.Visible:=True;
   CameraSuivi.StopPose;
   StopPose:=True;
end;

{function Tpop_camera_suivi.AcqNonSatur(var x,y:Integer):Boolean;
var
   Tps:Double;
   Valeur:Double;
   SMin,Mediane,SMax:Smallint;
   Moy,Ecart:Double;
   ImgNil:PTabImgDouble;
   LocalBinning:Byte;
begin
   Result:=False;

   WriteSpy(lang('AcqNonSatur : Recherche de la position de l''étoile'));

   Tps:=0.5;
   if CameraSuivi.IsAValidBinning(4) then LocalBinning:=4 else LocalBinning:=3;
   if Acquisition(1,1,CameraSuivi.GetXSize,CameraSuivi.GetYSize,Tps,LocalBinning,False,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos) then
      begin
      Getmax(pop_image_acq.DataInt,ImgNil,2,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,x,y,Valeur);
//      while (Valeur>config.Satur) and (Tps>config.MinPose) do
      while (Valeur>CameraSuivi.GetSaturationLevel) and (Tps>config.MinPose) do
         begin
         Tps:=Tps/2;
         Acquisition(1,1,CameraSuivi.GetXSize,CameraSuivi.GetYSize,Tps,LocalBinning,False,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos);
         pop_image_acq.AjusteFenetre;
         pop_image_acq.VisuAutoEtoiles;
         getmax(pop_image_acq.DataInt,ImgNil,2,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,x,y,Valeur);
         end;
//      while (Valeur<config.Satur/4) and (Tps<config.MaxPose) do
      while (Valeur<CameraSuivi.GetSaturationLevel/4) and (Tps<config.MaxPose) do
         begin
//         Tps:=Tps*config.Satur/4/Valeur;
         Tps:=Tps*CameraSuivi.GetSaturationLevel/4/Valeur;
         Acquisition(1,1,CameraSuivi.GetXSize,CameraSuivi.GetYSize,Tps,LocalBinning,False,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos);
         pop_image_acq.AjusteFenetre;
         pop_image_acq.VisuAutoEtoiles;
         Getmax(pop_image_acq.DataInt,ImgNil,2,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,x,y,Valeur);
         end;

      WriteSpy(lang('AcqNonSatur : Position de l''étoile ')+IntToStr(x)+'/'+IntToStr(y)
         +'/'+Format('%0.3f',[Valeur])); //nolang

      Result:=True;
      end;
end;}

function Tpop_camera_suivi.AcqMaximumBinning(var x,y:Integer):Boolean;
var
   Tps:Double;
   Valeur:Double;
   SMin,Mediane,SMax:Smallint;
   Moy,Ecart:Double;
   ImgNil:PTabImgDouble;
   LocalBinning:Byte;
begin
   if CameraSuivi.IsAValidBinning(4) then LocalBinning:=4 else LocalBinning:=3;

   Result:=False;

   WriteSpy(lang('AcqMaximumBinning : Recherche de la position de l''étoile'));
   Tps:=1;
   if pop_image_acq=nil then
      begin
      pop_image_acq:=tpop_image.Create(Application);
      pop_image_acq.IsUsedForTrack:=True;
      pop_image_acq.ImgInfos.BZero:=0;
      pop_image_acq.ImgInfos.BScale:=1;
      end;
   pop_image_acq.AcqRunning:=True;
   if Acquisition(1,1,CameraSuivi.GetXSize,CameraSuivi.GetYSize,Tps,LocalBinning,False,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos) then
      begin
      if NoirBinningAcquis then Soust(pop_image_acq.DataInt,MemPicTrackNoirBinning,ImgNil,ImgNil,2,1,
         CameraSuivi.GetXSize div LocalBinning,CameraSuivi.GetYSize div LocalBinning,
         CameraSuivi.GetXSize div LocalBinning,CameraSuivi.GetYSize div LocalBinning);

      GetMax(pop_image_acq.DataInt,pop_image_acq.dataDouble,pop_image_acq.ImgInfos.TypeData
         ,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,x,y,Valeur);

      WriteSpy(lang('AcqMaximumBinning : Position de l''étoile ')+IntToStr(x)+'/'+IntToStr(y)
         +'/'+Format('%0.3f',[Valeur])); //nolang
      pop_image_acq.AjusteFenetre;
      pop_image_acq.VisuAutoEtoiles;

      Result:=True;
      end;
   pop_image_acq.AcqRunning:=False;
end;

function Tpop_camera_suivi.AcqMaximum(var x,y:Integer):Boolean;
var
   Tps:Double;
   Valeur:Double;
   SMin,Mediane,SMax:Smallint;
   Moy,Ecart:Double;
   ImgNil:PTabImgDouble;
begin
   Result:=False;

   WriteSpy(lang('AcqMaximum : Recherche de la position de l''étoile'));
   Tps:=1;
   if pop_image_acq=nil then
      begin
      pop_image_acq:=tpop_image.Create(Application);
      pop_image_acq.IsUsedForTrack:=True;
      pop_image_acq.ImgInfos.BZero:=0;
      pop_image_acq.ImgInfos.BScale:=1;
      end;
   pop_image_acq.AcqRunning:=True;
   if Acquisition(1,1,CameraSuivi.GetXSize,CameraSuivi.GetYSize,Tps,1,False,
      pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos) then
      begin
      if NoirAcquis then Soust(pop_image_acq.DataInt,MemPicTrackNoir,ImgNil,ImgNil,2,1,
         CameraSuivi.GetXSize,CameraSuivi.GetYSize,CameraSuivi.GetXSize,CameraSuivi.GetYSize);

      GetMax(pop_image_acq.DataInt,pop_image_acq.dataDouble,pop_image_acq.ImgInfos.TypeData
         ,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,x,y,Valeur);

      WriteSpy(lang('AcqMaximum : Position de l''étoile ')+IntToStr(x)+'/'+IntToStr(y)
         +'/'+Format('%0.3f',[Valeur])); //nolang
      pop_image_acq.AjusteFenetre;
      pop_image_acq.VisuAutoEtoiles;

      Result:=True;
      end;

   pop_image_acq.AcqRunning:=False;
end;

// Passage d'une étoile du CCD principal au CCD de guidage
procedure tpop_camera_suivi.outbtn_trackClick(Sender: TObject);
var
Delai,Vitesse:Double;
Alpha,Delta:Double;
Error,NoCamera:Word;
TimeInit:TDateTime;
DeltaX,DeltaY:Double;
DeplacementNord,DeplacementSud,DeplacementEst,DeplacementOuest:Double;
begin
// On passe en vitesse Center
if not Telescope.MotionRate(Telescope.GetCenterSpeedNumber) then
   begin
   WriteSpy(lang('Le télescope refuse le réglage de vitesse'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope refuse le réglage de vitesse'));
   Exit;
   end;

//pop_scope.btn_Centrer.Down:=True;
// Vitesse Center = 32x la vitesse siderale ! En rad/s ca donne :
Vitesse:=32*2*pi/24/3600;
Delai:=2*ArcTan2(6/1000,2*config.FocaleTele/1000)/config.Vitesse; // FocaleTele est mm depuis la V2.66b
// Prendre en compte la calibration
if config.CalibratePointage then
   begin
   // Calcul du vecteur deplacement en pixels du capteur principal
   // Vitesse 16 x plus grande que la vitesse de guidage
   // Capteur de guidage dans le sens des y négatifs
   DeltaX:=0;
   DeltaY:=6/1000/(CameraSuivi.GetYPixelSize*1e-6);
   DeplacementNord:=(DeltaX*config.VecteurNordXPointe+DeltaY*config.VecteurNordYPointe)/Hypot(config.VecteurNordXPointe,config.VecteurNordYPointe);
   DeplacementSud:=(DeltaX*config.VecteurSudXPointe+DeltaY*config.VecteurSudYPointe)/Hypot(config.VecteurSudXPointe,config.VecteurSudYPointe);
   DeplacementEst:=(DeltaX*config.VecteurEstXPointe+DeltaY*config.VecteurEstYPointe)/Hypot(config.VecteurEstXPointe,config.VecteurEstYPointe);
   DeplacementOuest:=(DeltaX*config.VecteurOuestXPointe+DeltaY*config.VecteurOuestYPointe)/Hypot(config.VecteurOuestXPointe,config.VecteurOuestYPointe);
   if DeplacementNord>0 then
      begin
      Delai:=DeplacementNord*config.DelaiCalibrationPointage/Hypot(config.VecteurNordXPointe,config.VecteurNordYPointe);

      if not Telescope.StartMotion('N') then
         begin
         WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope refuse de démarrer le déplacement'));
         Exit;
         end;

      TimeInit:=Time;
      while Time<TimeInit+Delai/60/60/24 do Application.ProcessMessages;

      if not Telescope.StopMotion('N') then
         begin
         WriteSpy('Panique ! Le télescope refuse de s''arrêter');
         pop_Main.AfficheMessage(lang('Erreur'),
            'Panique ! Le télescope refuse de s''arrêter');
         end;

      end;
   if DeplacementSud>0 then
      begin
      Delai:=DeplacementSud*config.DelaiCalibrationPointage/Hypot(config.VecteurSudXPointe,config.VecteurSudYPointe);

      if not Telescope.StartMotion('S') then
         begin
         WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope refuse de démarrer le déplacement'));
         Exit;
         end;

      TimeInit:=Time;
      while Time<TimeInit+Delai/60/60/24 do Application.ProcessMessages;

      if not Telescope.StopMotion('S') then
         begin
         WriteSpy('Panique ! Le télescope refuse de s''arrêter');
         pop_Main.AfficheMessage(lang('Erreur'),
            'Panique ! Le télescope refuse de s''arrêter');
         end;

      end;
   if DeplacementEst>0 then
      begin
      Delai:=DeplacementEst*config.DelaiCalibrationPointage/Hypot(config.VecteurEstXPointe,config.VecteurEstYPointe);

      if not Telescope.StartMotion('E') then
         begin
         WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope refuse de démarrer le déplacement'));
         Exit;
         end;

      TimeInit:=Time;
      while Time<TimeInit+Delai/60/60/24 do Application.ProcessMessages;

      if not Telescope.StopMotion('E') then
         begin
         WriteSpy('Panique ! Le télescope refuse de s''arrêter');
         pop_Main.AfficheMessage(lang('Erreur'),
            'Panique ! Le télescope refuse de s''arrêter');
         end;

      end;
   if DeplacementOuest>0 then
      begin
      Delai:=DeplacementOuest*config.DelaiCalibrationPointage/Hypot(config.VecteurOuestXPointe,config.VecteurOuestYPointe);

      if not Telescope.StartMotion('W') then
         begin
         WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope refuse de démarrer le déplacement'));
         Exit;
         end;

      TimeInit:=Time;
      while Time<TimeInit+Delai/60/60/24 do Application.ProcessMessages;

      if not Telescope.StopMotion('W') then
         begin
         WriteSpy('Panique ! Le télescope refuse de s''arrêter');
         pop_Main.AfficheMessage(lang('Erreur'),
            'Panique ! Le télescope refuse de s''arrêter');
         end;

      end;
   end
else
   begin
   // 6 mm entre les deux capteurs => calcul du delai en secondes
   Delai:=2*ArcTan2(6/1000,2*config.FocaleTele/1000)/config.Vitesse; // FocaleTele est mm depuis la V2.66b
   // On commence le déplacement
   if not Telescope.StartMotion('S') then
      begin
      WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse de démarrer le déplacement'));
      Exit;
      end;

   // On attends
   TimeInit:=Time;
   while Time<TimeInit+Delai/60/60/24 do Application.ProcessMessages;
   // On arrête
   if not Telescope.StopMotion('S') then
      begin
      WriteSpy('Panique ! Le télescope refuse de s''arrêter');
      pop_Main.AfficheMessage(lang('Erreur'),
         'Panique ! Le télescope refuse de s''arrêter');
      end;

   end;

WriteSpy(lang('Passage au capteur de guidage effectué'));
end;

// Passage d'une étoile du CCD de guidage au CCD principal
procedure Tpop_camera_suivi.outButton1Click(Sender: TObject);
var
Delai,Vitesse:Double;
Alpha,Delta:Double;
Error,NoCamera:Word;
TimeInit:TDateTime;
DeltaX,DeltaY:Double;
DeplacementNord,DeplacementSud,DeplacementEst,DeplacementOuest:Double;
begin
if not Telescope.MotionRate(Telescope.GetCenterSpeedNumber) then
   begin
   WriteSpy(lang('Le télescope refuse le réglage de vitesse'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope refuse le réglage de vitesse'));
   Exit;
   end;

//pop_scope.btn_Centrer.Down:=True;
// Vitesse Center = 32x la vitesse siderale ! En rad/s ca donne :
Vitesse:=32*2*pi/24/3600;
// Prendre en compte la calibration
if config.CalibratePointage then
   begin
   // Calcul du vecteur deplacement en pixels du capteur principal
   // Vitesse 16 x plus grande que la vitesse de guidage
   // Capteur de guidage dans le sens des y négatifs
   DeltaX:=0;
   DeltaY:=-6/1000/(CameraSuivi.GetYPixelSize*1e-6);
   DeplacementNord:=(DeltaX*config.VecteurNordXPointe+DeltaY*config.VecteurNordYPointe)/Hypot(config.VecteurNordXPointe,config.VecteurNordYPointe);
   DeplacementSud:=(DeltaX*config.VecteurSudXPointe+DeltaY*config.VecteurSudYPointe)/Hypot(config.VecteurSudXPointe,config.VecteurSudYPointe);
   DeplacementEst:=(DeltaX*config.VecteurEstXPointe+DeltaY*config.VecteurEstYPointe)/Hypot(config.VecteurEstXPointe,config.VecteurEstYPointe);
   DeplacementOuest:=(DeltaX*config.VecteurOuestXPointe+DeltaY*config.VecteurOuestYPointe)/Hypot(config.VecteurOuestXPointe,config.VecteurOuestYPointe);
   if DeplacementNord>0 then
      begin
      Delai:=DeplacementNord*config.DelaiCalibrationPointage/Hypot(config.VecteurNordXPointe,config.VecteurNordYPointe);

      if not Telescope.StartMotion('N') then
         begin
         WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope refuse de démarrer le déplacement'));
         Exit;
         end;

      TimeInit:=Time;
      while Time<TimeInit+Delai/60/60/24 do Application.ProcessMessages;

      if not Telescope.StopMotion('N') then
         begin
         WriteSpy('Panique ! Le télescope refuse de s''arrêter');
         pop_Main.AfficheMessage(lang('Erreur'),
            'Panique ! Le télescope refuse de s''arrêter');
         end;

      end;
   if DeplacementSud>0 then
      begin
      Delai:=DeplacementSud*config.DelaiCalibrationPointage/Hypot(config.VecteurSudXPointe,config.VecteurSudYPointe);
//      ScopeStartMotion('S');

      if not Telescope.StartMotion('S') then
         begin
         WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope refuse de démarrer le déplacement'));
         Exit;
         end;

      TimeInit:=Time;
      while Time<TimeInit+Delai/60/60/24 do Application.ProcessMessages;

      if not Telescope.StopMotion('S') then
         begin
         WriteSpy('Panique ! Le télescope refuse de s''arrêter');
         pop_Main.AfficheMessage(lang('Erreur'),
            'Panique ! Le télescope refuse de s''arrêter');
         end;

      end;
   if DeplacementEst>0 then
      begin
      Delai:=DeplacementEst*config.DelaiCalibrationPointage/Hypot(config.VecteurEstXPointe,config.VecteurEstYPointe);

      if not Telescope.StartMotion('E') then
         begin
         WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope refuse de démarrer le déplacement'));
         Exit;
         end;

      TimeInit:=Time;
      while Time<TimeInit+Delai/60/60/24 do Application.ProcessMessages;

      if not Telescope.StopMotion('E') then
         begin
         WriteSpy('Panique ! Le télescope refuse de s''arrêter');
         pop_Main.AfficheMessage(lang('Erreur'),
            'Panique ! Le télescope refuse de s''arrêter');
         end;

      end;
   if DeplacementOuest>0 then
      begin
      Delai:=DeplacementOuest*config.DelaiCalibrationPointage/Hypot(config.VecteurOuestXPointe,config.VecteurOuestYPointe);

      if not Telescope.StartMotion('W') then
         begin
         WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope refuse de démarrer le déplacement'));
         Exit;
         end;

      TimeInit:=Time;
      while Time<TimeInit+Delai/60/60/24 do Application.ProcessMessages;

      if not Telescope.StopMotion('W') then
         begin
         WriteSpy('Panique ! Le télescope refuse de s''arrêter');
         pop_Main.AfficheMessage(lang('Erreur'),
            'Panique ! Le télescope refuse de s''arrêter');
         end;

      end;
   end
else
   begin
   // 6 mm entre les deux capteurs => calcul du delai en secondes
   Delai:=2*ArcTan2(6/1000,2*config.FocaleTele/1000)/config.Vitesse; // FocaleTele est mm depuis la V2.66b
   // On commence le déplacement

   if not Telescope.StartMotion('N') then
      begin
      WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse de démarrer le déplacement'));
      Exit;
      end;

   // On attends
   TimeInit:=Time;
   while Time<TimeInit+Delai/60/60/24 do Application.ProcessMessages;
   // On arrête
   if not Telescope.StopMotion('N') then
      begin
      WriteSpy('Panique ! Le télescope refuse de s''arrêter');
      pop_Main.AfficheMessage(lang('Erreur'),
         'Panique ! Le télescope refuse de s''arrêter');
      end;

   end;

WriteSpy(lang('Passage au capteur de guidage effectué'));
end;

procedure Tpop_camera_suivi.SpinButton1UpClick(Sender: TObject);
var
Pose1,Pose2:Single;
begin
Pose1:=MyStrToFloat(Edit5.Text);
Pose2:=IncrementePose(Pose1);
if Pose2=0 then Pose2:=0.001;
if Pose1<>Pose2 then Edit5.Text:=MyFloatToStr(Pose2,3);
end;

procedure Tpop_camera_suivi.BitBtn1Click(Sender: TObject);
begin
CameraSuivi.ShowConfigPanel(false);
end;

procedure Tpop_camera_suivi.btnChercherClick(Sender: TObject);
var
   AMin,Mediane,AMax,Moy,Ecart:double;
   LocalBinning:Byte;
   ImgNil:PTabImgDouble;
   Alpha:Double;
begin
ChercherEnCours:=True;
btnChercher.Enabled:=False;
btn_calibrer.Enabled:=False;
btn_track_start.Enabled:=False;
Button1.Enabled:=False;
Button2.Enabled:=False;

try
try

// Acquisition du noir
if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
   begin
   if not NoirBinningAcquis then
      begin
      WriteSpy(lang('Acquisition du noir en binning'));
      if Assigned(pop_track) then pop_track.AddMessage(lang('Acquisition du noir en binning'));
      if CameraSuivi.IsAValidBinning(4) then AcqNoirBinning(4) else AcqNoirBinning(3);
      NoirBinningAcquis:=True;
      end;
   end
else
   begin
   if not NoirAcquis then
      begin
      WriteSpy(lang('Acquisition du noir'));
      if Assigned(pop_track) then pop_track.AddMessage(lang('Acquisition du noir'));
      AcqNoir;
      NoirAcquis:=True;
      end;
   end;

StopSuivi:=False;
while not StopSuivi do
   begin
   progress.min:=0;
   progress.max:=round(MyStrToFloat(Edit5.text));
   progress.position:=0;

   // si l'image n'existe pas, on la cree
   if pop_image_acq=nil then
      begin
      pop_image_acq:=tpop_image.Create(Application);
      pop_image_acq.IsUsedForTrack:=True;
      pop_image_acq.ImgInfos.TypeData:=CameraSuivi.GetTypeData;
      pop_image_acq.ImgInfos.Nbplans:=CameraSuivi.GetNbPlans;
      pop_image_acq.ImgInfos.BZero:=0;
      pop_image_acq.ImgInfos.BScale:=1;
      end;
   pop_image_acq.AcqRunning:=True;

   if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
      begin
      if CameraSuivi.IsAValidBinning(4) then LocalBinning:=4 else LocalBinning:=3;
      end
   else LocalBinning:=1;

   if Acquisition(1,1,CameraSuivi.GetXSize,CameraSuivi.GetySize,
                  MyStrToFloat(Edit5.Text),LocalBinning,False,pop_image_acq.ImgInfos.Sx,
                  pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos) then
      begin
      if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
         begin
         if NoirBinningAcquis then Soust(pop_image_acq.DataInt,MemPicTrackNoirBinning,ImgNil,ImgNil,2,1,
            CameraSuivi.GetXSize div LocalBinning,CameraSuivi.GetYSize div LocalBinning,
            CameraSuivi.GetXSize div LocalBinning,CameraSuivi.GetYSize div LocalBinning);
         end
      else
         begin
         if NoirAcquis then Soust(pop_image_acq.DataInt,MemPicTrackNoir,ImgNil,ImgNil,2,1,
            CameraSuivi.GetXSize,CameraSuivi.GetYSize,CameraSuivi.GetXSize,CameraSuivi.GetYSize);
         end;

      Statistiques(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,1,
         pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,1,aMin,Mediane,aMax,Moy,Ecart);
      update_stats(pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,amin,mediane,amax,moy,ecart);
      pop_image_acq.AjusteFenetre;
      case config.SeuilCamera of
         0 : pop_image_acq.VisuAutoEtoiles;
         1 : pop_image_acq.VisuAutoPlanetes;
         2 : pop_image_acq.VisuAutoMinMax;
         end;

      pop_main.SeuilsEnable;
      pop_image_acq.AcqRunning:=False;
      end
   else
      begin
      NbInterValCourant:=nbintervalpose+1;
      panel1.caption:=lang('Stop');
      pop_image_acq.AcqRunning:=False;
      ShowMessage(lang('Erreur de communication'));
      Config.CameraSuiviBranchee:=False;
      pop_main.UpDateGUICameraSuivi;
      Exit;
      end;

   if StopSuivi then
      begin
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         end
      else btn_track_start.enabled:=False;

      StopSuivi:=False;
      WriteSpy(lang('Arrêt du guidage'));
      if Assigned(pop_track) then pop_track.AddMessage(lang('Arrêt du guidage'));
      Config.SuiviEnCours:=False;      
      Exit;
      end;
   end;

except
Config.CameraSuiviBranchee:=False;
pop_main.UpDateGUICameraSuivi;
end;
finally
btnChercher.Enabled:=True;
btn_calibrer.Enabled:=True;
Button1.Enabled:=True;
if config.CalibrateSuivi then
   begin
   btn_track_start.enabled:=True;
   Button2.Enabled:=True;
   end
else btn_track_start.enabled:=False;
ChercherEnCours:=False;
end;
end;

procedure Tpop_camera_suivi.AcqNoir;
var
AMin,Mediane,AMax,Moy,Ecart:double;
Alpha,Delta:Double;
Rep:String;
i:Integer;
begin
progress.min:=0;
progress.max:=round(MyStrToFloat(Edit5.text));
progress.position:=0;
// si l'image n'existe pas, on la cree
if pop_image_acq=nil then
   begin
   pop_image_acq:=tpop_image.Create(Application);
   pop_image_acq.IsUsedForTrack:=True;
   pop_image_acq.ImgInfos.TypeData:=CameraSuivi.GetTypeData;
   pop_image_acq.ImgInfos.Nbplans:=CameraSuivi.GetNbPlans;
   pop_image_acq.ImgInfos.BZero:=0;
   pop_image_acq.ImgInfos.BScale:=1;
   end;
pop_image_acq.AcqRunning:=True;
if Acquisition(1,1,CameraSuivi.GetXSize,CameraSuivi.GetYSize,
               MyStrToFloat(Edit5.Text),1,True,pop_image_acq.ImgInfos.Sx,
               pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos) then
   begin
   Statistiques(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,1,
      pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,1,aMin,Mediane,aMax,Moy,Ecart);
   update_stats(pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,amin,mediane,amax,moy,ecart);
   pop_image_acq.AjusteFenetre;
   case config.SeuilCamera of
      0 : pop_image_acq.VisuAutoEtoiles;
      1 : pop_image_acq.VisuAutoPlanetes;
      2 : pop_image_acq.VisuAutoMinMax;
      end;
   pop_main.SeuilsEnable;
   pop_image_acq.AcqRunning:=False;

   if MemPicTrackNoir<>nil then
      begin
      for i:=1 to SyNoir do Freemem(MemPicTrackNoir^[1]^[i],SxNoir*2);
      Freemem(MemPicTrackNoir^[1],4*SyNoir);
      Freemem(MemPicTrackNoir,4);
      end;

   SxNoir:=pop_image_acq.ImgInfos.Sx;
   SyNoir:=pop_image_acq.ImgInfos.Sy;

   Getmem(MemPicTrackNoir,4);
   Getmem(MemPicTrackNoir^[1],SyNoir*4);
   for i:=1 to SyNoir do
      begin
      Getmem(MemPicTrackNoir^[1]^[i],SxNoir*2);
      Move(pop_image_acq.DataInt^[1]^[i]^,MemPicTrackNoir^[1]^[i]^,SxNoir*2);
      end;

   end
else
   begin
   NbInterValCourant:=nbintervalpose+1;
   pop_image_acq.AcqRunning:=False;
   ShowMessage(lang('Erreur de communication'));
   Config.CameraSuiviBranchee:=False;
   pop_main.UpDateGUICameraSuivi;
   Exit;
   end;

end;

procedure Tpop_camera_suivi.AcqNoirBinning(Binning:Byte);
var
AMin,Mediane,AMax,Moy,Ecart:double;
Alpha,Delta:Double;
Rep:String;
i:Integer;
begin
progress.min:=0;
progress.max:=round(MyStrToFloat(Edit5.text));
progress.position:=0;
// si l'image n'existe pas, on la cree
if pop_image_acq=nil then
   begin
   pop_image_acq:=tpop_image.Create(Application);
   pop_image_acq.IsUsedForTrack:=True;
   pop_image_acq.ImgInfos.TypeData:=CameraSuivi.GetTypeData;
   pop_image_acq.ImgInfos.Nbplans:=CameraSuivi.GetNbPlans;
   pop_image_acq.ImgInfos.BZero:=0;
   pop_image_acq.ImgInfos.BScale:=1;
   end;
pop_image_acq.AcqRunning:=True;
if Acquisition(1,1,CameraSuivi.GetXSize,CameraSuivi.GetYSize,
               MyStrToFloat(Edit5.Text),Binning,True,pop_image_acq.ImgInfos.Sx,
               pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos) then
   begin
   Statistiques(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,1,
      pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,1,aMin,Mediane,aMax,Moy,Ecart);
   update_stats(pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,amin,mediane,amax,moy,ecart);
   pop_image_acq.AjusteFenetre;
   case config.SeuilCamera of
      0 : pop_image_acq.VisuAutoEtoiles;
      1 : pop_image_acq.VisuAutoPlanetes;
      2 : pop_image_acq.VisuAutoMinMax;
      end;
   pop_main.SeuilsEnable;
   pop_image_acq.AcqRunning:=False;

   if MemPicTrackNoirBinning<>nil then
      begin
      for i:=1 to SyNoirBinning do Freemem(MemPicTrackNoirBinning^[1]^[i],SxNoirBinning*2);
      Freemem(MemPicTrackNoirBinning^[1],4*SyNoirBinning);
      Freemem(MemPicTrackNoirBinning,4);
      end;

   SxNoirBinning:=pop_image_acq.ImgInfos.Sx;
   SyNoirBinning:=pop_image_acq.ImgInfos.Sy;

   Getmem(MemPicTrackNoirBinning,4);
   Getmem(MemPicTrackNoirBinning^[1],SyNoirBinning*4);
   for i:=1 to SyNoirBinning do
      begin
      Getmem(MemPicTrackNoirBinning^[1]^[i],SxNoirBinning*2);
      Move(pop_image_acq.DataInt^[1]^[i]^,MemPicTrackNoirBinning^[1]^[i]^,SxNoirBinning*2);
      end;

   end
else
   begin //5
   NbInterValCourant:=nbintervalpose+1;
   pop_image_acq.AcqRunning:=False;
   ShowMessage(lang('Erreur de communication'));
   Config.CameraSuiviBranchee:=False;
   pop_main.UpDateGUICameraSuivi;
   Exit;
   end; //5

end;

procedure Tpop_camera_suivi.SpinButton1DownClick(Sender: TObject);
var
   Pose1,Pose2:Double;
begin
Pose1:=MyStrToFloat(Edit5.Text);
Pose2:=DecrementePose(Pose1);
if Pose1<>Pose2 then Edit5.Text:=MyFloatToStr(Pose2,3);
end;

procedure Tpop_camera_suivi.SpeedButton1Click(Sender: TObject);
begin
win_x1.Text:='1'; //nolang
win_x2.Text:=IntToStr(CameraSuivi.GetXSize);
win_y1.Text:='1'; //nolang
win_y2.Text:=IntToStr(CameraSuivi.GetYSize);
end;

procedure Tpop_camera_suivi.Button1Click(Sender: TObject);
begin
// Acquisition du noir
if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
   begin
   WriteSpy(lang('Acquisition du noir en binning'));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Acquisition du noir en binning'));
   if CameraSuivi.IsAValidBinning(4) then AcqNoirBinning(4) else AcqNoirBinning(3);
   NoirBinningAcquis:=True;
   end;

WriteSpy(lang('Acquisition du noir'));
if Assigned(pop_track) then pop_track.AddMessage(lang('Acquisition du noir'));
AcqNoir;
NoirAcquis:=True;
end;

procedure Tpop_camera_suivi.FormHide(Sender: TObject);
begin
pop_main.ToolButton7.Down:=False;
btn_track_stopClick(Sender);
end;

procedure Tpop_camera_suivi.outAcqB1Click(Sender: TObject);
var
   AMin,Mediane,AMax,Moy,Ecart:double;
   i,j,k:integer;
   Alpha,Delta:Double;
   Rep:string;
   ShutterClosed:Boolean;
   Resultat:Boolean;
   Pose:Double;
begin
   try
   Stop.Visible:=True;
   outAcqB1.Visible:=False;
   outAcqB2.Visible:=False;
   outAcqB4.Visible:=False;
   x1:=StrToInt(win_x1.Text);
   x2:=StrToInt(win_x2.Text);
   y1:=StrToInt(win_y1.Text);
   y2:=StrToInt(win_y2.Text);
   if x1>CameraSuivi.GetXSize then x1:=CameraSuivi.GetXSize;
   if x2>CameraSuivi.GetXSize then x2:=CameraSuivi.GetXSize;
   if y1>CameraSuivi.GetYSize then y1:=CameraSuivi.GetYSize;
   if y2>CameraSuivi.GetYSize then y2:=CameraSuivi.GetYSize;
   if x1<1 then x1:=1;
   if x2<1 then x2:=1;
   if y1<1 then y1:=1;
   if y2<1 then y2:=1;

   // si l'image n'existe pas, on la cree
   if pop_image_acq=nil then
      begin
      pop_image_acq:=tpop_image.Create(Application);
      pop_image_acq.IsUsedForTrack:=True;
      pop_image_acq.ImgInfos.TypeData:=CameraSuivi.GetTypeData;
      pop_image_acq.ImgInfos.Nbplans:=CameraSuivi.GetNbPlans;
      pop_image_acq.ImgInfos.BZero:=0;
      pop_image_acq.ImgInfos.BScale:=1;
      end;

   progress.min:=0;
   progress.max:=round(MyStrToFloat(Edit5.text));
   progress.position:=0;

   pop_image_acq.AcqRunning:=True;

   PoseEnCours:=True;

   if CameraSuivi.Is16Bits and (pop_image_acq<>nil) and (pop_image_acq.DataDouble<>nil) then
      begin
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do
         begin
         for i:=1 to pop_image_acq.ImgInfos.Sy do Freemem(pop_image_acq.DataDouble^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
         Freemem(pop_image_acq.DataDouble^[k],4*pop_image_acq.ImgInfos.Sy);
         end;
      Freemem(pop_image_acq.DataDouble,4*pop_image_acq.ImgInfos.Nbplans);
      end;
      
   if (pop_image_acq<>nil) and (pop_image_acq.DataInt<>nil) then
      begin
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
         for i:=1 to pop_image_acq.ImgInfos.Sy do Freemem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
         Freemem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
      end;
      Freemem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
      end;

   pop_image_acq.ImgInfos.min[1]:=0;
   pop_image_acq.ImgInfos.max[1]:=0;
   pop_image_acq.ImgInfos.TypeData:=CameraSuivi.GetTypeData;
   pop_image_acq.ImgInfos.Nbplans:=CameraSuivi.GetNbPlans;

   Pose:=MyStrToFloat(Edit5.Text);
   if Pose<CameraSuivi.GetMinimalPose then begin
      Pose:=CameraSuivi.GetMinimalPose;
      Edit5.Text:=floattostr(Pose);
   end;
   TpsInt:=Round(Pose*1000);
   pop_image_acq.ImgInfos.Sx:=(x2-x1+1);
   pop_image_acq.ImgInfos.Sy:=(y2-y1+1);

   if Config.MirrorXSuivi then
      begin
      x1:=CameraSuivi.GetXSize-x1+1;
      x2:=CameraSuivi.GetXSize-x2+1;
      end;
   if Config.MirrorYSuivi then
      begin
      y1:=CameraSuivi.GetYSize-y1+1;
      y2:=CameraSuivi.GetYSize-y2+1;
      end;

   Getmem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
   for k:=1 to pop_image_acq.ImgInfos.Nbplans do
      begin
      Getmem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
      for i:=1 to pop_image_acq.ImgInfos.Sy do Getmem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
      end;
   NbInterValCourant:=0;
   NbIntervalPose:=Round(TpsInt/Intervalle);

   CameraSuivi.SetWindow(x1,y1,x2,y2);
   WriteSpy(CameraSuivi.GetName+lang(' Fenêtre : (')+IntToStr(x1)+','+IntToStr(y1)+lang(')/(')+
      IntToStr(x2)+','+IntToStr(y2)+')');
   CameraSuivi.SetBinning(1);
   WriteSpy(CameraSuivi.GetName+lang(' Binning : 1'));   
   CameraSuivi.SetPose(Pose);
   WriteSpy(CameraSuivi.GetName+lang(' Temps de pose : ')+MyFloatToStr(Pose,3)+
      lang(' s'));   
   if ShutterClosed then
      if CameraSuivi.HasAShutter then CameraSuivi.SetShutterClosed;

   WriteSpy(lang('Début de la pose sur la caméra de guidage'));
   Resultat:=CameraSuivi.StartPose;

   if Resultat then
      begin
//      TimerPose1.Enabled:=True;
      ThreadPoseSuivi1:=TThreadPoseSuivi1.Create;
      StopPose:=False;
      end;
   except
   pop_main.SeuilsEnable;
   pop_image_acq.AcqRunning:=False;
   panel1.caption:=lang('Stop');
   Stop.Visible:=False;
   outAcqB1.Visible:=True;
   outAcqB2.Visible:=True;
   outAcqB4.Visible:=True;
//   TimerPose1.Enabled:=False;
   ThreadPoseSuivi1.Terminate;   
   end;
end;

procedure Tpop_camera_suivi.TimerInter1Timer(Sender: TObject);
var
   AMin,Mediane,AMax,Moy,Ecart:double;
   i,j,k,nbimage:Integer;
   InterI:SmallInt;
   Rep:string;
   Alpha,Delta:Double;
   LocalBinning:Byte;
   ax,bx,ay,by:double;
   Resultat:boolean;
   Angle:Double;
begin
   // Si le timer est pas actif on sort de suite
   if not TimerInter1.Enabled then Exit;
   // On libere the Thread du timer haute resolution
//   TimerPose1.Enabled:=False;
   ThreadPoseSuivi1.Terminate;
   // On arrete ce timer
   TimerInter1.Enabled:=False;

   try

   progress.position:=0;
   Panel1.Caption:=lang('Lecture');
   Panel1.Update;

   Stop.Enabled:=False;
   outAcqB1.Enabled:=False;
   outAcqB2.Enabled:=False;
   outAcqB4.Enabled:=False;
   try
   try
   CameraSuivi.ReadCCD(pop_image_acq.DataInt,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   if CameraSuivi.Is16Bits then
      begin
      pop_image_acq.ImgInfos.BZero:=32768;
      ConvertFITSIntToReal(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos);
      end;
   except
   Config.CameraSuiviBranchee:=False;
   pop_main.UpdateGUICameraSuivi;
   end;
   finally
   Stop.Enabled:=True;
   outAcqB1.Enabled:=True;
   outAcqB2.Enabled:=True;
   outAcqB4.Enabled:=True;
   end;

   CameraSuivi.GetCCDDateBegin(YearBegin,MonthBegin,DayBegin);
   CameraSuivi.GetCCDTimeBegin(HourBegin,MinBegin,SecBegin,MSecBegin);
   CameraSuivi.GetCCDDateEnd(YearEnd,MonthEnd,DayEnd);
   CameraSuivi.GetCCDTimeEnd(HourEnd,MinEnd,SecEnd,MSecEnd);
   TimeBegin:=EncodeDate(YearBegin,MonthBegin,DayBegin)+EncodeTime(HourBegin,MinBegin,SecBegin,MSecBegin);
   TimeEnd:=EncodeDate(YearEnd,MonthEnd,DayEnd)+EncodeTime(HourEnd,MinEnd,SecEnd,MSecEnd);

   PoseEnCours:=False;
   // affichage du nombre total d'image
   CameraSuivi.AdjustIntervalePose(NbInterValCourant,nbimage,Intervalle);
   if nbimage>0 then Edit6.text:=inttostr(nbimage);
   // il faut que la nouvelle image soit active a la fin de la pose
   pop_image_acq.setfocus ; // rend le focus a l'image finale
   pop_main.LastChild:=pop_image_acq; //il faut un peu forcer les choses car onActivate n'est pas appeler si la fiche active precedente n'est pas un enfant MDI.

   // On remet à 0 pour pouvoir continuer le guidage
   NbIntervalPose:=0;

   if config.MirrorXSuivi then
      if CameraSuivi.Is16Bits then
         MiroirHorizontal(pop_image_acq.DataInt,pop_image_acq.DataDouble,5,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy)
      else
         MiroirHorizontal(pop_image_acq.DataInt,pop_image_acq.DataDouble,2,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   if config.MirrorYSuivi then
      if CameraSuivi.Is16Bits then
         MiroirVertical(pop_image_acq.DataInt,pop_image_acq.DataDouble,5,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy)
      else
         MiroirVertical(pop_image_acq.DataInt,pop_image_acq.DataDouble,2,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);

{   if config.MirrorXSuivi then
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do
         for j:=1 to pop_image_acq.ImgInfos.Sy do
            for i:=1 to pop_image_acq.ImgInfos.Sx div 2 do
               begin
               InterI:=pop_image_acq.DataInt^[k]^[j]^[i];
               pop_image_acq.DataInt^[k]^[j]^[i]:=pop_image_acq.DataInt^[k]^[j]^[pop_image_acq.ImgInfos.Sx-i+1];
               pop_image_acq.DataInt^[k]^[j]^[pop_image_acq.ImgInfos.Sx-i+1]:=InterI;
               end;
   if config.MirrorYSuivi then
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do
         for j:=1 to pop_image_acq.ImgInfos.Sx do
            for i:=1 to pop_image_acq.ImgInfos.Sy div 2 do
               begin
               InterI:=pop_image_acq.DataInt^[k]^[i]^[j];
               pop_image_acq.DataInt^[k]^[i]^[j]:=pop_image_acq.DataInt^[k]^[pop_image_acq.ImgInfos.Sy-i+1]^[j];
               pop_image_acq.DataInt^[k]^[pop_image_acq.ImgInfos.Sy-i+1]^[j]:=InterI;
               end;}

   // Remplissage du ImgInfos
   with pop_image_acq do
      begin
      InitImgInfos(ImgInfos);
      ImgInfos.TempsPose:=Round((TimeEnd-TimeBegin)*24*3600*1000);
      ImgInfos.DateTime:=TimeBegin+(TimeEnd-TimeBegin)/2;
//         ImgInfos.TempsPose:=Round(PoseCamera*1000); // Conversion s -> ms
      // On met a jour le temps de milieu de pose avec le temps de pose reel mesuré !
//         ImgInfos.DateTime:=TimeInit+PoseCamera/24/3600/2;
      ImgInfos.BinningX:=1;
      ImgInfos.BinningY:=1;
      ImgInfos.MiroirX:=config.MirrorXSuivi;
      ImgInfos.MiroirY:=config.MirrorYSuivi;
      ImgInfos.Telescope:=config.Telescope;
      ImgInfos.Observateur:=config.Observateur;
      ImgInfos.Camera:=Camerasuivi.GetName;
      if Config.UseCFW8 then
         begin
         if Pop_Camera.RadioButton1.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton1.Caption;
         if Pop_Camera.RadioButton2.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton2.Caption;
         if Pop_Camera.RadioButton3.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton3.Caption;
         if Pop_Camera.RadioButton4.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton4.Caption;
         if Pop_Camera.RadioButton5.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton5.Caption;
         end
      else ImgInfos.Filtre:=config.Filtre;
      ImgInfos.Observatoire:=config.Observatoire;
      ImgInfos.Lat:=Config.Lat;
      ImgInfos.Long:=Config.Long;
      ImgInfos.Focale:=config.FocaleTele;
      ImgInfos.Diametre:=config.Diametre;

      Angle:=Config.OrientationCCDGuidage;
      if CheckBox2.Checked then Angle:=Angle+180;
      if Angle>360 then Angle:=Angle-360;
      ImgInfos.OrientationCCD:=Angle;

      ImgInfos.Seeing:=Config.Seeing;
      ImgInfos.BScale:=1;
      ImgInfos.BZero:=0;
      if Config.GoodPos then
         begin
         ImgInfos.Alpha:=Config.AlphaScope;
         ImgInfos.Delta:=Config.DeltaScope;
         end
      else
         begin
         WriteSpy(lang('Le télescope ne veut pas donner sa position'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope ne veut pas donner sa position'));
         end;
      ImgInfos.PixX:=CameraSuivi.GetXPixelSize;
      ImgInfos.PixY:=CameraSuivi.GetYPixelSize;
      ImgInfos.X1:=x1;
      ImgInfos.Y1:=y1;
      ImgInfos.X2:=x2;
      ImgInfos.Y2:=y2;
      end;

   if checkbox1.checked then
      begin
      Statistiques(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,1,
         pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,1,aMin,Mediane,aMax,Moy,Ecart);
      update_stats(pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,amin,mediane,amax,moy,ecart);
      end
   else memo_stats.lines.clear;
   pop_image_acq.AjusteFenetre;
   case config.SeuilCamera of
      0 : pop_image_acq.VisuAutoEtoiles;
      1 : pop_image_acq.VisuAutoPlanetes;
      2 : pop_image_acq.VisuAutoMinMax;
      3 : pop_image_acq.VisuMiniMaxi(config.SeuilBasFixe,config.SeuilHautFixe);
      end;

   finally
   pop_main.SeuilsEnable;
   pop_image_acq.AcqRunning:=False;
   panel1.caption:=lang('Stop');
   Stop.Visible:=False;
   outAcqB1.Visible:=True;
   outAcqB2.Visible:=True;
   outAcqB4.Visible:=True;
//   TimerPose1.Enabled:=False;
   ThreadPoseSuivi1.Terminate;
   end;
end;

procedure Tpop_camera_suivi.outAcqB2Click(Sender: TObject);
var
AMin,Mediane,AMax,Moy,Ecart:double;
i,j,k:integer;
Alpha,Delta:Double;
Rep:string;
ShutterClosed:Boolean;
Resultat:Boolean;
ax,bx,ay,by:Double;
Pose:Double;
begin
   try
   Stop.Visible:=True;
   outAcqB1.Visible:=False;
   outAcqB2.Visible:=False;
   outAcqB4.Visible:=False;
   x1:=StrToInt(win_x1.Text);
   x2:=StrToInt(win_x2.Text);
   y1:=StrToInt(win_y1.Text);
   y2:=StrToInt(win_y2.Text);
   if x1>CameraSuivi.GetXSize div 2 then x1:=CameraSuivi.GetXSize div 2;
   if x2>CameraSuivi.GetXSize div 2 then x2:=CameraSuivi.GetXSize div 2;
   if y1>CameraSuivi.GetYSize div 2 then y1:=CameraSuivi.GetYSize div 2;
   if y2>CameraSuivi.GetYSize div 2 then y2:=CameraSuivi.GetYSize div 2;
   if x1<1 then x1:=1;
   if x2<1 then x2:=1;
   if y1<1 then y1:=1;
   if y2<1 then y2:=1;

   // y=ax+b
   ax:=(CameraSuivi.GetXSize-1)/((CameraSuivi.GetXSize div 2)-1);
   bx:=1-ax;
   ay:=(CameraSuivi.GetYSize-1)/((CameraSuivi.GetYSize div 2)-1);
   by:=1-ay;

   // si l'image n'existe pas, on la cree
   if pop_image_acq=nil then
      begin
      pop_image_acq:=tpop_image.Create(Application);
      pop_image_acq.IsUsedForTrack:=True;
      pop_image_acq.ImgInfos.TypeData:=CameraSuivi.GetTypeData;
      pop_image_acq.ImgInfos.Nbplans:=CameraSuivi.GetNbPlans;
      pop_image_acq.ImgInfos.BZero:=0;
      pop_image_acq.ImgInfos.BScale:=1;
      end;

   progress.min:=0;
   progress.max:=round(MyStrToFloat(Edit5.text));
   progress.position:=0;

   // Si un guidage est en cours on attends on bon guidage
//   if Config.SuiviEnCours then
//      repeat
//      until (pop_camera_suivi.ErreurX<0.5) and (pop_camera_suivi.ErreurY<0.5);

   pop_image_acq.AcqRunning:=True;

   PoseEnCours:=True;

   if CameraSuivi.Is16Bits and (pop_image_acq<>nil) and (pop_image_acq.DataDouble<>nil) then
      begin
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do
         begin
         for i:=1 to pop_image_acq.ImgInfos.Sy do Freemem(pop_image_acq.DataDouble^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
         Freemem(pop_image_acq.DataDouble^[k],4*pop_image_acq.ImgInfos.Sy);
         end;
      Freemem(pop_image_acq.DataDouble,4*pop_image_acq.ImgInfos.Nbplans);
      end;
      
   if (pop_image_acq<>nil) and (pop_image_acq.DataInt<>nil) then
      begin
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
         for i:=1 to pop_image_acq.ImgInfos.Sy do Freemem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
         Freemem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
      end;
      Freemem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
      end;

   pop_image_acq.ImgInfos.min[1]:=0;
   pop_image_acq.ImgInfos.max[1]:=0;
   pop_image_acq.ImgInfos.TypeData:=CameraSuivi.GetTypeData;
   pop_image_acq.ImgInfos.Nbplans:=CameraSuivi.GetNbPlans;

   Pose:=MyStrToFloat(Edit5.Text);
   if Pose<CameraSuivi.GetMinimalPose then begin
      Pose:=CameraSuivi.GetMinimalPose;
      Edit5.Text:=floattostr(Pose);
   end;
   TpsInt:=Round(Pose*1000);

   pop_image_acq.ImgInfos.Sx:=(x2-x1+1);
   pop_image_acq.ImgInfos.Sy:=(y2-y1+1);

   if Config.MirrorXSuivi then
      begin
      x1:=CameraSuivi.GetXSize div 2-x1+1;
      x2:=CameraSuivi.GetXSize div 2-x2+1;
      end;
   if Config.MirrorYSuivi then
      begin
      y1:=CameraSuivi.GetYSize div 2-y1+1;
      y2:=CameraSuivi.GetYSize div 2-y2+1;
      end;

   Getmem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
   for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
     Getmem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
     for i:=1 to pop_image_acq.ImgInfos.Sy do Getmem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
   end;
   NbInterValCourant:=0;
   NbIntervalPose:=Round(TpsInt/Intervalle);

   CameraSuivi.SetWindow(Round(ax*x1+bx),Round(ay*y1+by),Round(ax*x2+bx),Round(ay*y2+by));
   WriteSpy(CameraSuivi.GetName+lang(' Fenêtre : (')+IntToStr(Round(ax*x1+bx))+','+IntToStr(Round(ay*y1+by))+lang(')/(')+
      IntToStr(Round(ax*x2+bx))+','+IntToStr(Round(ay*y2+by))+')');
   CameraSuivi.SetBinning(2);
   WriteSpy(CameraSuivi.GetName+lang(' Binning : 2'));   
   CameraSuivi.SetPose(Pose);
   WriteSpy(CameraSuivi.GetName+lang(' Temps de pose : ')+MyFloatToStr(Pose,3)+
      lang(' s'));   
   if ShutterClosed then
      if CameraSuivi.HasAShutter then CameraSuivi.SetShutterClosed;
   WriteSpy(lang('Début de la pose sur la caméra de guidage'));      
   Resultat:=CameraSuivi.StartPose;
   if Resultat then
      begin
//      TimerPose2.Enabled:=True;
      ThreadPoseSuivi2:=TThreadPoseSuivi2.Create;
      StopPose:=False;
      end;
   except
   pop_main.SeuilsEnable;
   pop_image_acq.AcqRunning:=False;
   panel1.caption:=lang('Stop');
   Stop.Visible:=False;
   outAcqB1.Visible:=True;
   outAcqB2.Visible:=True;
   outAcqB4.Visible:=True;
//   TimerPose2.enabled:=False;
   ThreadPoseSuivi2.Terminate;   
   end;
end;

procedure Tpop_camera_suivi.TimerInter2Timer(Sender: TObject);
var
   AMin,Mediane,AMax,Moy,Ecart:double;
   i,j,k,nbimage:Integer;
   InterI:SmallInt;
   Rep:string;
   Alpha,Delta:Double;
   LocalBinning:Byte;
   ax,bx,ay,by:double;
   Resultat:boolean;
   Angle:Double;
begin
   // Si le timer est pas actif on sort de suite
   if not TimerInter2.Enabled then Exit;
   // On libere the Thread du timer haute resolution
//   TimerPose2.Enabled:=False;
   ThreadPoseSuivi2.Terminate;
   // On arrete ce timer
   TimerInter2.Enabled:=False;

   try
   progress.position:=0;
   Panel1.Caption:=lang('Lecture');
   Panel1.Update;

   Stop.Enabled:=False;
   outAcqB1.Enabled:=False;
   outAcqB2.Enabled:=False;
   outAcqB4.Enabled:=False;
   try
   try
   CameraSuivi.ReadCCD(pop_image_acq.DataInt,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   if CameraSuivi.Is16Bits then
      begin
      pop_image_acq.ImgInfos.BZero:=32768;
      ConvertFITSIntToReal(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos);
      end;
   except
   Config.CameraSuiviBranchee:=False;
   pop_main.UpdateGUICameraSuivi;
   end;
   finally
   Stop.Enabled:=True;
   outAcqB1.Enabled:=True;
   outAcqB2.Enabled:=True;
   outAcqB4.Enabled:=True;
   end;

   CameraSuivi.GetCCDDateBegin(YearBegin,MonthBegin,DayBegin);
   CameraSuivi.GetCCDTimeBegin(HourBegin,MinBegin,SecBegin,MSecBegin);
   CameraSuivi.GetCCDDateEnd(YearEnd,MonthEnd,DayEnd);
   CameraSuivi.GetCCDTimeEnd(HourEnd,MinEnd,SecEnd,MSecEnd);
   TimeBegin:=EncodeDate(YearBegin,MonthBegin,DayBegin)+EncodeTime(HourBegin,MinBegin,SecBegin,MSecBegin);
   TimeEnd:=EncodeDate(YearEnd,MonthEnd,DayEnd)+EncodeTime(HourEnd,MinEnd,SecEnd,MSecEnd);

   PoseEnCours:=False;
   // affichage du nombre total d'image
   CameraSuivi.AdjustIntervalePose(NbInterValCourant,nbimage,Intervalle);
   if nbimage>0 then Edit6.text:=inttostr(nbimage);
   // il faut que la nouvelle image soit active a la fin de la pose
   pop_image_acq.setfocus ; // rend le focus a l'image finale
   pop_main.LastChild:=pop_image_acq; //il faut un peu forcer les choses car onActivate n'est pas appeler si la fiche active precedente n'est pas un enfant MDI.

   // On remet à 0 pour pouvoir continuer le guidage
   NbIntervalPose:=0;

   if config.MirrorXSuivi then
      if CameraSuivi.Is16Bits then
         MiroirHorizontal(pop_image_acq.DataInt,pop_image_acq.DataDouble,5,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy)
      else
         MiroirHorizontal(pop_image_acq.DataInt,pop_image_acq.DataDouble,2,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   if config.MirrorYSuivi then
      if CameraSuivi.Is16Bits then
         MiroirVertical(pop_image_acq.DataInt,pop_image_acq.DataDouble,5,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy)
      else
         MiroirVertical(pop_image_acq.DataInt,pop_image_acq.DataDouble,2,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);

{   if config.MirrorXSuivi then
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do
         for j:=1 to pop_image_acq.ImgInfos.Sy do
            for i:=1 to pop_image_acq.ImgInfos.Sx div 2 do
               begin
               InterI:=pop_image_acq.DataInt^[k]^[j]^[i];
               pop_image_acq.DataInt^[k]^[j]^[i]:=pop_image_acq.DataInt^[k]^[j]^[pop_image_acq.ImgInfos.Sx-i+1];
               pop_image_acq.DataInt^[k]^[j]^[pop_image_acq.ImgInfos.Sx-i+1]:=InterI;
               end;
   if config.MirrorYSuivi then
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do
         for j:=1 to pop_image_acq.ImgInfos.Sx do
            for i:=1 to pop_image_acq.ImgInfos.Sy div 2 do
               begin
               InterI:=pop_image_acq.DataInt^[k]^[i]^[j];
               pop_image_acq.DataInt^[k]^[i]^[j]:=pop_image_acq.DataInt^[k]^[pop_image_acq.ImgInfos.Sy-i+1]^[j];
               pop_image_acq.DataInt^[k]^[pop_image_acq.ImgInfos.Sy-i+1]^[j]:=InterI;
               end;}

   // Remplissage du ImgInfos
   with pop_image_acq do
      begin
      InitImgInfos(ImgInfos);
      ImgInfos.TempsPose:=Round((TimeEnd-TimeBegin)*24*3600*1000);
      ImgInfos.DateTime:=TimeBegin+(TimeEnd-TimeBegin)/2;
      ImgInfos.BinningX:=2;
      ImgInfos.BinningY:=2;
      ImgInfos.MiroirX:=config.MirrorXSuivi;
      ImgInfos.MiroirY:=config.MirrorYSuivi;
      ImgInfos.Telescope:=config.Telescope;
      ImgInfos.Observateur:=config.Observateur;
      ImgInfos.Camera:=CameraSuivi.GetName;
      if Config.UseCFW8 then
         begin
         if Pop_Camera.RadioButton1.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton1.Caption;
         if Pop_Camera.RadioButton2.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton2.Caption;
         if Pop_Camera.RadioButton3.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton3.Caption;
         if Pop_Camera.RadioButton4.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton4.Caption;
         if Pop_Camera.RadioButton5.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton5.Caption;
         end
      else ImgInfos.Filtre:=config.Filtre;
      ImgInfos.Observatoire:=config.Observatoire;
      ImgInfos.Lat:=Config.Lat;
      ImgInfos.Long:=Config.Long;
      ImgInfos.Focale:=config.FocaleTele;
      ImgInfos.Diametre:=config.Diametre;

      Angle:=Config.OrientationCCDGuidage;
      if CheckBox2.Checked then Angle:=Angle+180;
      if Angle>360 then Angle:=Angle-360;
      ImgInfos.OrientationCCD:=Angle;

      ImgInfos.Seeing:=Config.Seeing;
      ImgInfos.BScale:=1;
      ImgInfos.BZero:=0;
      ImgInfos.TemperatureCCD:=999;
      if Config.GoodPos then
         begin
         ImgInfos.Alpha:=Config.AlphaScope;
         ImgInfos.Delta:=Config.DeltaScope;
         end
      else
         begin
         WriteSpy(lang('Le télescope ne veut pas donner sa position'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope ne veut pas donner sa position'));
         end;
      ImgInfos.PixX:=CameraSuivi.GetXPixelSize;
      ImgInfos.PixY:=CameraSuivi.GetYPixelSize;
      ImgInfos.X1:=x1;
      ImgInfos.Y1:=y1;
      ImgInfos.X2:=x2;
      ImgInfos.Y2:=y2;
      end;

   if checkbox1.checked then
      begin
      Statistiques(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,1,
         pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,1,aMin,Mediane,aMax,Moy,Ecart);
      update_stats(pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,amin,mediane,amax,moy,ecart);
      end
   else memo_stats.lines.clear;
   pop_image_acq.AjusteFenetre;
   case config.SeuilCamera of
      0 : pop_image_acq.VisuAutoEtoiles;
      1 : pop_image_acq.VisuAutoPlanetes;
      2 : pop_image_acq.VisuAutoMinMax;
      3 : pop_image_acq.VisuMiniMaxi(config.SeuilBasFixe,config.SeuilHautFixe);
      end;

   finally
   pop_main.SeuilsEnable;
   pop_image_acq.AcqRunning:=False;
   panel1.caption:=lang('Stop');
   Stop.Visible:=False;
   outAcqB1.Visible:=True;
   outAcqB2.Visible:=True;
   outAcqB4.Visible:=True;
//   TimerPose2.enabled:=False;
   ThreadPoseSuivi2.Terminate;
   end;
end;

procedure Tpop_camera_suivi.outAcqB4Click(Sender: TObject);
var
   AMin,Mediane,AMax,Moy,Ecart:double;
   i,j,k:integer;
   Alpha,Delta:Double;
   Rep:string;
   ShutterClosed:Boolean;
   Resultat:Boolean;
   LocalBinning:Byte;
   ax,bx,ay,by:Double;
   Pose:Double;
begin
   try
   Stop.Visible:=True;
   outAcqB1.Visible:=False;
   outAcqB2.Visible:=False;
   outAcqB4.Visible:=False;

   if CameraSuivi.IsAValidBinning(4) then LocalBinning:=4 else LocalBinning:=3;

   x1:=StrToInt(win_x1.Text);
   x2:=StrToInt(win_x2.Text);
   y1:=StrToInt(win_y1.Text);
   y2:=StrToInt(win_y2.Text);
   if x1>CameraSuivi.GetXSize div LocalBinning then x1:=CameraSuivi.GetXSize div LocalBinning;
   if x2>CameraSuivi.GetXSize div LocalBinning then x2:=CameraSuivi.GetXSize div LocalBinning;
   if y1>CameraSuivi.GetYSize div LocalBinning then y1:=CameraSuivi.GetYSize div LocalBinning;
   if y2>CameraSuivi.GetYSize div LocalBinning then y2:=CameraSuivi.GetYSize div LocalBinning;

   if x1<1 then x1:=1;
   if x2<1 then x2:=1;
   if y1<1 then y1:=1;
   if y2<1 then y2:=1;

   // y=ax+b
   ax:=(CameraSuivi.GetXSize-1)/((CameraSuivi.GetXSize div LocalBinning)-1);
   bx:=1-ax;
   ay:=(CameraSuivi.GetYSize-1)/((CameraSuivi.GetYSize div LocalBinning)-1);
   by:=1-ay;

   // si l'image n'existe pas, on la cree
   if pop_image_acq=nil then
      begin
      pop_image_acq:=tpop_image.Create(Application);
      pop_image_acq.IsUsedForTrack:=True;
      pop_image_acq.ImgInfos.TypeData:=CameraSuivi.GetTypeData;
      pop_image_acq.ImgInfos.Nbplans:=CameraSuivi.GetNbPlans;
      pop_image_acq.ImgInfos.BZero:=0;
      pop_image_acq.ImgInfos.BScale:=1;
      end;

   progress.min:=0;
   progress.max:=round(MyStrToFloat(Edit5.text));
   progress.position:=0;

   pop_image_acq.AcqRunning:=True;

   PoseEnCours:=True;

   if CameraSuivi.Is16Bits and (pop_image_acq<>nil) and (pop_image_acq.DataDouble<>nil) then
      begin
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do
         begin
         for i:=1 to pop_image_acq.ImgInfos.Sy do Freemem(pop_image_acq.DataDouble^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
         Freemem(pop_image_acq.DataDouble^[k],4*pop_image_acq.ImgInfos.Sy);
         end;
      Freemem(pop_image_acq.DataDouble,4*pop_image_acq.ImgInfos.Nbplans);
      end;
      
   if (pop_image_acq<>nil) and (pop_image_acq.DataInt<>nil) then
      begin
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
         for i:=1 to pop_image_acq.ImgInfos.Sy do Freemem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
         Freemem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
      end;
      Freemem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
      end;

   pop_image_acq.ImgInfos.min[1]:=0;
   pop_image_acq.ImgInfos.max[1]:=0;
   pop_image_acq.ImgInfos.TypeData:=CameraSuivi.GetTypeData;
   pop_image_acq.ImgInfos.Nbplans:=CameraSuivi.GetNbPlans;

   Pose:=MyStrToFloat(Edit5.Text);
   if Pose<CameraSuivi.GetMinimalPose then begin
      Pose:=CameraSuivi.GetMinimalPose;
      Edit5.Text:=floattostr(Pose);
   end;
   TpsInt:=Round(Pose*1000);

   pop_image_acq.ImgInfos.Sx:=x2-x1+1;
   pop_image_acq.ImgInfos.Sy:=y2-y1+1;

   if Config.MirrorXSuivi then
      begin
      x1:=CameraSuivi.GetXSize div LocalBinning-x1+1;
      x2:=CameraSuivi.GetXSize div LocalBinning-x2+1;
      end;
   if Config.MirrorYSuivi then
      begin
      y1:=CameraSuivi.GetYSize div LocalBinning-y1+1;
      y2:=CameraSuivi.GetYSize div LocalBinning-y2+1;
      end;

   Getmem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
   for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
     Getmem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
     for i:=1 to pop_image_acq.ImgInfos.Sy do Getmem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
   end;
   NbInterValCourant:=0;
   NbIntervalPose:=Round(TpsInt/Intervalle);

   CameraSuivi.SetWindow(Round(ax*x1+bx),Round(ay*y1+by),Round(ax*x2+bx),Round(ay*y2+by));
   WriteSpy(CameraSuivi.GetName+lang(' Fenêtre : (')+IntToStr(Round(ax*x1+bx))+','+IntToStr(Round(ay*y1+by))+lang(')/(')+
      IntToStr(Round(ax*x2+bx))+','+IntToStr(Round(ay*y2+by))+')');
   CameraSuivi.SetBinning(LocalBinning);
   WriteSpy(CameraSuivi.GetName+lang(' Binning : ')+IntToStr(LocalBinning));   
   CameraSuivi.SetPose(Pose);
   WriteSpy(CameraSuivi.GetName+lang(' Temps de pose : ')+MyFloatToStr(Pose,3)+
      lang(' s'));   
   if ShutterClosed then
      if CameraSuivi.HasAShutter then CameraSuivi.SetShutterClosed;
   WriteSpy(lang('Début de la pose sur la caméra de guidage'));      
   Resultat:=CameraSuivi.StartPose;
   if Resultat then
      begin
//      TimerPose4.Enabled:=True;
      ThreadPoseSuivi4:=TThreadPoseSuivi4.Create;
      StopPose:=False;
      end;
   except
   pop_main.SeuilsEnable;
   pop_image_acq.AcqRunning:=False;
   panel1.caption:=lang('Stop');
   Stop.Visible:=False;
   outAcqB1.Visible:=True;
   outAcqB2.Visible:=True;
   outAcqB4.Visible:=True;
//   TimerPose2.enabled:=False;
   ThreadPoseSuivi2.Terminate;
   end;
end;

procedure Tpop_camera_suivi.TimerInter4Timer(Sender: TObject);
var
   AMin,Mediane,AMax,Moy,Ecart:double;
   i,j,k,nbimage:Integer;
   InterI:SmallInt;
   Rep:string;
   Alpha,Delta:Double;
   LocalBinning:Byte;
   ax,bx,ay,by:double;
   Resultat:boolean;
   Angle:Double;
begin
   // Si le timer est pas actif on sort de suite
   if not TimerInter4.Enabled then Exit;
   // On libere the Thread du timer haute resolution
//   TimerPose4.Enabled:=False;
   ThreadPoseSuivi4.Terminate;
   // On arrete ce timer
   TimerInter4.Enabled:=False;

   try

   progress.position:=0;
   Panel1.Caption:=lang('Lecture');
   Panel1.Update;

   Stop.Enabled:=False;
   outAcqB1.Enabled:=False;
   outAcqB2.Enabled:=False;
   outAcqB4.Enabled:=False;
   try
   try
   CameraSuivi.ReadCCD(pop_image_acq.DataInt,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   if CameraSuivi.Is16Bits then
      begin
      pop_image_acq.ImgInfos.BZero:=32768;
      ConvertFITSIntToReal(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos);
      end;
   except
   Config.CameraSuiviBranchee:=False;
   pop_main.UpdateGUICameraSuivi;
   end;
   finally
   Stop.Enabled:=True;
   outAcqB1.Enabled:=True;
   outAcqB2.Enabled:=True;
   outAcqB4.Enabled:=True;
   end;

   CameraSuivi.GetCCDDateBegin(YearBegin,MonthBegin,DayBegin);
   CameraSuivi.GetCCDTimeBegin(HourBegin,MinBegin,SecBegin,MSecBegin);
   CameraSuivi.GetCCDDateEnd(YearEnd,MonthEnd,DayEnd);
   CameraSuivi.GetCCDTimeEnd(HourEnd,MinEnd,SecEnd,MSecEnd);
   TimeBegin:=EncodeDate(YearBegin,MonthBegin,DayBegin)+EncodeTime(HourBegin,MinBegin,SecBegin,MSecBegin);
   TimeEnd:=EncodeDate(YearEnd,MonthEnd,DayEnd)+EncodeTime(HourEnd,MinEnd,SecEnd,MSecEnd);

   PoseEnCours:=False;
   // affichage du nombre total d'image
   CameraSuivi.AdjustIntervalePose(NbInterValCourant,nbimage,Intervalle);
   if nbimage>0 then Edit6.text:=inttostr(nbimage);
   // il faut que la nouvelle image soit active a la fin de la pose
   pop_image_acq.setfocus ; // rend le focus a l'image finale
   pop_main.LastChild:=pop_image_acq; //il faut un peu forcer les choses car onActivate n'est pas appeler si la fiche active precedente n'est pas un enfant MDI.}

   // On remet à 0 pour pouvoir continuer le guidage
   NbIntervalPose:=0;

   if config.MirrorXSuivi then
      if CameraSuivi.Is16Bits then
         MiroirHorizontal(pop_image_acq.DataInt,pop_image_acq.DataDouble,5,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy)
      else
         MiroirHorizontal(pop_image_acq.DataInt,pop_image_acq.DataDouble,2,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   if config.MirrorYSuivi then
      if CameraSuivi.Is16Bits then
         MiroirVertical(pop_image_acq.DataInt,pop_image_acq.DataDouble,5,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy)
      else
         MiroirVertical(pop_image_acq.DataInt,pop_image_acq.DataDouble,2,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);

{   if config.MirrorXSuivi then
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do
         for j:=1 to pop_image_acq.ImgInfos.Sy do
            for i:=1 to pop_image_acq.ImgInfos.Sx div 2 do
               begin
               InterI:=pop_image_acq.DataInt^[k]^[j]^[i];
               pop_image_acq.DataInt^[k]^[j]^[i]:=pop_image_acq.DataInt^[k]^[j]^[pop_image_acq.ImgInfos.Sx-i+1];
               pop_image_acq.DataInt^[k]^[j]^[pop_image_acq.ImgInfos.Sx-i+1]:=InterI;
               end;
   if config.MirrorYSuivi then
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do
         for j:=1 to pop_image_acq.ImgInfos.Sx do
            for i:=1 to pop_image_acq.ImgInfos.Sy div 2 do
               begin
               InterI:=pop_image_acq.DataInt^[k]^[i]^[j];
               pop_image_acq.DataInt^[k]^[i]^[j]:=pop_image_acq.DataInt^[k]^[pop_image_acq.ImgInfos.Sy-i+1]^[j];
               pop_image_acq.DataInt^[k]^[pop_image_acq.ImgInfos.Sy-i+1]^[j]:=InterI;
               end;}

   // Remplissage du ImgInfos
   with pop_image_acq do
      begin
      InitImgInfos(ImgInfos);
      ImgInfos.TempsPose:=Round((TimeEnd-TimeBegin)*24*3600*1000);
      ImgInfos.DateTime:=TimeBegin+(TimeEnd-TimeBegin)/2;
//         ImgInfos.TempsPose:=Round(PoseCamera*1000); // Conversion s -> ms
      // On met a jour le temps de milieu de pose avec le temps de pose reel mesuré !
//         ImgInfos.DateTime:=TimeInit+PoseCamera/24/3600/2;
      if CameraSuivi.IsAValidBinning(4) then ImgInfos.BinningX:=4 else ImgInfos.BinningX:=3;
      if CameraSuivi.IsAValidBinning(4) then ImgInfos.BinningY:=4 else ImgInfos.BinningY:=3;
      ImgInfos.MiroirX:=config.MirrorXSuivi;
      ImgInfos.MiroirY:=config.MirrorYSuivi;
      ImgInfos.Telescope:=config.Telescope;
      ImgInfos.Observateur:=config.Observateur;
      ImgInfos.Camera:=CameraSuivi.GetName;
      if Config.UseCFW8 then
         begin
         if Pop_Camera.RadioButton1.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton1.Caption;
         if Pop_Camera.RadioButton2.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton2.Caption;
         if Pop_Camera.RadioButton3.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton3.Caption;
         if Pop_Camera.RadioButton4.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton4.Caption;
         if Pop_Camera.RadioButton5.Checked then ImgInfos.Filtre:=Pop_Camera.RadioButton5.Caption;
         end
      else ImgInfos.Filtre:=config.Filtre;
      ImgInfos.Observatoire:=config.Observatoire;
      ImgInfos.Lat:=Config.Lat;
      ImgInfos.Long:=Config.Long;
      ImgInfos.Focale:=config.FocaleTele;
      ImgInfos.Diametre:=config.Diametre;

      Angle:=Config.OrientationCCDGuidage;
      if CheckBox2.Checked then Angle:=Angle+180;
      if Angle>360 then Angle:=Angle-360;
      ImgInfos.OrientationCCD:=Angle;

      ImgInfos.Seeing:=Config.Seeing;
      ImgInfos.BScale:=1;
      ImgInfos.BZero:=0;
      if Config.GoodPos then
         begin
         ImgInfos.Alpha:=Config.AlphaScope;
         ImgInfos.Delta:=Config.DeltaScope;
         end
      else
         begin
         WriteSpy(lang('Le télescope ne veut pas donner sa position'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope ne veut pas donner sa position'));
         end;
      ImgInfos.PixX:=CameraSuivi.GetXPixelSize;
      ImgInfos.PixY:=CameraSuivi.GetYPixelSize;
      ImgInfos.X1:=x1;
      ImgInfos.Y1:=y1;
      ImgInfos.X2:=x2;
      ImgInfos.Y2:=y2;
      end;

   if checkbox1.checked then
      begin
      Statistiques(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,1,
         pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,1,aMin,Mediane,aMax,Moy,Ecart);
      update_stats(pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,amin,mediane,amax,moy,ecart);
      end
   else memo_stats.lines.clear;
   pop_image_acq.AjusteFenetre;
   case config.SeuilCamera of
      0 : pop_image_acq.VisuAutoEtoiles;
      1 : pop_image_acq.VisuAutoPlanetes;
      2 : pop_image_acq.VisuAutoMinMax;
      3 : pop_image_acq.VisuMiniMaxi(config.SeuilBasFixe,config.SeuilHautFixe);
      end;

   finally
   pop_main.SeuilsEnable;
   pop_image_acq.AcqRunning:=False;
   panel1.caption:=lang('Stop');
   Stop.Visible:=False;
   outAcqB1.Visible:=True;
   outAcqB2.Visible:=True;
   outAcqB4.Visible:=True;
//   TimerPose4.enabled:=False;
   ThreadPoseSuivi4.Terminate;
   end;
end;

procedure tpop_camera_suivi.DeplaceScope(Duree:Double;Direction:Byte);
var
   StrDir:string;
   TimeInit:TDateTime;
   DelaiAttente:Double;
begin
   DelaiAttente:=2;

   case Direction of
      diNord:
         begin
         StrDir:='N';
         WriteSpy(lang('On demande le déplacement vers le Nord pendant '+
            MyFloatToStr(Duree*1000,0)+' ms')); //nolang
         if Assigned(pop_calibrate_track) then
            pop_calibrate_track.AddMessage(lang('On demande le déplacement vers le Nord pendant '+
               MyFloatToStr(Duree*1000,0)+' ms')); //nolang
//         WriteSpy(lang('L''étoile va donc se déplacer vers le sud'));
//         if Assigned(pop_calibrate_track) then
//            pop_calibrate_track.AddMessage(lang('L''étoile va donc se déplacer vers le sud'));
         end;
      diSud:
         begin
         StrDir:='S';
         WriteSpy(lang('On demande le déplacement vers le Sud pendant '+
            MyFloatToStr(Duree*1000,0)+' ms')); //nolang
         if Assigned(pop_calibrate_track) then
            pop_calibrate_track.AddMessage(lang('On demande le déplacement vers le Sud pendant '+
               MyFloatToStr(Duree*1000,0)+' ms')); //nolang
//         WriteSpy(lang('L''étoile va donc se déplacer vers le nord'));
//         if Assigned(pop_calibrate_track) then
//            pop_calibrate_track.AddMessage(lang('L''étoile va donc se déplacer vers le nord'));
         end;
      diEst:
         begin
         StrDir:='E';
         WriteSpy(lang('On demande le déplacement vers l''Est pendant '+
            MyFloatToStr(Duree*1000,0)+' ms')); //nolang
         if Assigned(pop_calibrate_track) then
            pop_calibrate_track.AddMessage(lang('On demande le déplacement vers l''Est pendant '+
               MyFloatToStr(Duree*1000,0)+' ms')); //nolang
         WriteSpy(lang('L''étoile va donc se déplacer vers l''ouest'));
         if Assigned(pop_calibrate_track) then
            pop_calibrate_track.AddMessage(lang('L''étoile va donc se déplacer vers l''ouest'));
         end;
      diOuest:
         begin
         StrDir:='W';
         WriteSpy(lang('On demande le déplacement vers l''Ouest pendant '+
            MyFloatToStr(Duree*1000,0)+' ms')); //nolang
         if Assigned(pop_calibrate_track) then
            pop_calibrate_track.AddMessage(lang('On demande le déplacement vers l''Ouest pendant '+
               MyFloatToStr(Duree*1000,0)+' ms')); //nolang
         WriteSpy(lang('L''étoile va donc se déplacer vers l''est'));
         if Assigned(pop_calibrate_track) then
            pop_calibrate_track.AddMessage(lang('L''étoile va donc se déplacer vers l''est'));
         end;
      end;

   Update;

   if config.UseTrackSt7 then
      begin
      case Direction of
         diNord:ActivateRelaySbig(0,Round(Duree*100));
         diSud:ActivateRelaySbig(0,Round(-Duree*100));
         diEst:ActivateRelaySbig(Round(Duree*100),0);
         diOuest:ActivateRelaySbig(Round(-Duree*100),0);
         end;

      // On attends
      TimeInit:=Time;
      while Time<TimeInit+Duree/60/60/24 do Application.ProcessMessages;

      TimeInit:=Time;
      while Time<TimeInit+DelaiAttente/60/60/24 do Application.ProcessMessages;
      end
   else
      begin

      if not Telescope.StartMotion(StrDir) then
         begin
         WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope refuse de démarrer le déplacement'));
         Exit;
         end;

      // On attends
      TimeInit:=Time;
      while Time<TimeInit+Duree/60/60/24 do Application.ProcessMessages;

      if not Telescope.StopMotion(StrDir) then
         begin
         WriteSpy('Panique ! Le télescope refuse de s''arrêter');
         pop_Main.AfficheMessage(lang('Erreur'),
            'Panique ! Le télescope refuse de s''arrêter');
         end;

      TimeInit:=Time;
      while Time<TimeInit+DelaiAttente/60/60/24 do Application.ProcessMessages;
      end;
   end;

// Calibrer le tracking
procedure tpop_camera_suivi.Btn_calibrerClick(Sender: TObject);
var
   TempsDePose:Double;
   x,y,xx,yy:Integer;
   ValMax:Double;
   PSF:TPSF;
   Error,NoCamera:Word;
   TimeInit:TDateTime;
   Erreur:Boolean;
   OldUseTrackSt7,OldUseMainCCD:Boolean;
   Angle,Valeur:Double;
   ImgDoubleNil:PTabImgDouble;
   JeuDelta,JeuAlpha,DimTest,XPixelSize,YPixelSize:Double;
   JeuDeltaOK:Boolean;
   NbTryJeuDelta:Integer;
   DeplacementNSMaxi,DeplacementEOMaxi:Double;
   ModuleNord,ModuleSud,ModuleEst,ModuleOuest:Double;
   Jeu,Facteur:Double;
   Alpha,Alpha1,Delta1,Alpha2,Delta2:Double;
   NotPerpend,TooSlowEW,TooSlowNS:Boolean;
   Ini:TMemIniFile;
   VecteurRatrapSudX,VecteurRatrapSudY,VecteurRatrapNordX,VecteurRatrapNordY:Double;
   VecteurSudTotalX,VecteurSudTotalY,VecteurNordTotalX,VecteurNordTotalY:Double;
   ProduitVectorielSudEst:Double;
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   Path:string;
   i:Integer;
begin
if Config.AskToCalibrate then
   begin
   try
   New(TabItems);

   for i:=1 to NbMaxItems do TabItems^[i].Msg:='';

   with TabItems^[1] do
      begin
      TypeItem:=tiLabel;
      Msg:=lang('Lancer la calibration ?');
      end;

   with TabItems^[2] do
      begin
      TypeItem:=tiCheckBox;
      Msg:=lang('Ne plus poser cette question');
      ValeurCheckDefaut:=False;
      end;

   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,200);
   DlgStandard.SetOKButton(lang('Calibrer'));
   DlgStandard.Caption:=lang('Calibration');
   if DlgStandard.ShowModal=mrOK then
      begin
      Config.AskToCalibrate:=TabItems^[2].ValeurSortie=0;

      Path:=LowerCase(ExtractFilePath(Application.ExeName));
      SaveParametres(Path+'TeleAuto.ini');  //nolang
      end
   else Exit;


   finally
   Dispose(TabItems);
   end;
   end;

Config.CalibrationEnCours:=True;

TempsDePose:=MyStrToFloat(Edit5.Text);

pop_dessin:=Tpop_dessin.Create(Application);
pop_dessin.SetSize(CameraSuivi.GetXSize,CameraSuivi.GetYSize);
pop_dessin.Caption:=lang('Graphe de contrôle');
pop_dessin.Show;

Config.EtapeCalibration:=0;

config.LargFenSuivi:=9;

config.CalibrateSuivi:=False;

if pop_image_acq=nil then
   begin
   pop_image_acq:=tpop_image.Create(Application);
   pop_image_acq.IsUsedForTrack:=True;
   pop_image_acq.ImgInfos.BZero:=0;
   pop_image_acq.ImgInfos.BScale:=1;
   end;
pop_image_acq.Bloque:=True;

btnChercher.Enabled:=False;
btn_calibrer.Enabled:=False;
btn_track_start.Enabled:=False;
Button1.Enabled:=False;
Button2.Enabled:=False;
CheckBox2.Enabled:=False;
StopGetPos:=True;

try
try

JeuDeltaOK:=False;
NbTryJeuDelta:=1;
// On recommence tant que le jeu en Delta est mal pris en compte
// On arrete quand meme si on a recommence 2 fois car c'est qu'il y a un probleme
while not(JeuDeltaOK) and (NbTryJeuDelta<=2) do
   begin

   if pop_calibrate_track=nil then pop_calibrate_track:=tpop_calibrate_track.create(application);
   pop_calibrate_track.Show;

   WriteSpy(lang('Début de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Début de la calibration'));

   if config.UseTrackSt7 then
      begin
      WriteSpy(lang('Utilisation de la liaison Télescope-ST7'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Utilisation de la liaison Télescope-ST7'));
      end
   else
      begin
      WriteSpy(lang('Commande directe du télescope'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Commande directe du télescope'));

      // On passe le LX en vitesse de guidage
      WriteSpy(lang('Passage en vitesse de guidage'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Passage en vitesse de guidage'));

      if not Telescope.MotionRate(Telescope.GetTrackSpeedNumber) then
         begin
         WriteSpy(lang('Le télescope refuse le réglage de vitesse'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope refuse le réglage de vitesse'));
         Config.CalibrationEnCours:=False;
         pop_image_acq.Bloque:=False;
         btnChercher.Enabled:=True;
         btn_calibrer.Enabled:=True;
         Button1.Enabled:=True;
         if config.CalibrateSuivi then
            begin
            btn_track_start.enabled:=True;
            Button2.Enabled:=True;
            CheckBox2.Enabled:=True;
            end
         else
            begin
            btn_track_start.enabled:=False;
            Button2.Enabled:=True;
            CheckBox2.Enabled:=False;
            end;
         StopGetPos:=False;

         StopSuivi:=False;
         Config.SuiviEnCours:=False;
         WriteSpy(lang('Arrêt de la calibration'));
         if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
         Exit;
         end;

      end;

   // Acquisition des noirs si ce n'est pas deja fait
   if not NoirBinningAcquis then
      begin
      if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
         begin
         WriteSpy(lang('Acquisition du noir en binning'));
         if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Acquisition du noir en binning'));
         if CameraSuivi.IsAValidBinning(4) then AcqNoirBinning(4) else AcqNoirBinning(3);
         NoirBinningAcquis:=True;
         end;
      end;

   if not NoirAcquis then
      begin
      WriteSpy(lang('Acquisition du noir'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Acquisition du noir'));
      AcqNoir;
      NoirAcquis:=True;
      end;

   if StopSuivi then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;

      StopSuivi:=False;
      Config.SuiviEnCours:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   Config.EtapeCalibration:=1;
   WriteSpy(lang('Recherche des coordonnées de l''étoile la plus brillante'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche des coordonnées de l''étoile la plus brillante'));
   if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
      begin
      AcqMaximumBinning(x,y);
      if CameraSuivi.IsAValidBinning(4) then
         begin
         x:=x*4;
         y:=y*4;
         end
      else
         begin
         x:=x*3;
         y:=y*3;
         end;
      end
   else AcqMaximum(x,y);

   WriteSpy(lang('Coordonnées  = ')+IntToStr(x)+'/'+IntToStr(y));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Coordonnées  = ')+IntToStr(x)+'/'+IntToStr(y));

   if Config.KeepImage then
      begin
      pop_image1:=tpop_image.create(application);
      DupliquerImage(pop_image_acq,pop_image1,lang('Acquisition'));
      pop_image1.Caption:=pop_main.GiveName(lang('Acquisition'),pop_image1);
      pop_image1.Calib1:=True;
      pop_main.MiseAJourMenu(Self);
      end;

   if StopSuivi then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;

      StopSuivi:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Config.SuiviEnCours:=False;      
      Exit;
      end;

   if (x<=config.LargFenSuivi) or (x>CameraSuivi.GetXSize-config.LargFenSuivi) or
      (y<=config.LargFenSuivi) or (y>CameraSuivi.GetYSize-config.LargFenSuivi) then
      begin
      StopSuivi:=False;
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
            
      WriteSpy(lang('Etoile de calibration trop prés du bord'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Etoile de calibration trop prés du bord'));
      Exit;
      end;

   WriteSpy(lang('Fenêtrage de l''étoile'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

   if StopSuivi then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;

      StopSuivi:=False;
      Config.SuiviEnCours:=False;      
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   // Aquisition en vignette
   Config.EtapeCalibration:=1;
   Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
      y+config.LargFenSuivi,TempsDePose,1,False,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,
      pop_image_acq.ImgInfos);

   GetMax(pop_image_acq.DataInt,pop_image_acq.dataDouble,pop_image_acq.ImgInfos.TypeData
      ,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);

   //Soustraction du noir
   if NoirAcquis then
      begin
      GetImgPart(MemPicTrackNoir,ImgDoubleNil,VignetteNoir,ImgDoubleNil,2,1,pop_image_acq.ImgInfos.Sx,
         pop_image_acq.ImgInfos.Sy,x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
         y+config.LargFenSuivi);
      Soust(pop_image_acq.DataInt,VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_image_acq.ImgInfos.Sx,
         pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
      FreememImg(VignetteNoir,ImgDoubleNil,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,2,1);
      end;

   pop_image_acq.AjusteFenetre;
   pop_image_acq.VisuAutoEtoiles;

   // Affichage du max pour vérifier la non saturation
   WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(
      lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));

   ModeliseEtoile(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,
      2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);

   if PSF.Flux=-1 then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
      
      StopSuivi:=False;
      WriteSpy(lang('Erreur de modélisation'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
      Exit;
      end;

   XTrack0:=x-config.LargFenSuivi+PSF.X-1;
   YTrack0:=y-config.LargFenSuivi+PSF.Y-1;

   WriteSpy(lang('Coordonnées de l''étoile X=')+
      MyFloatToStr(XTrack0,2)+' Y='+MyFloatToStr(YTRack0,2)); //nolang
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(
      lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrack0,2)+
      ' Y='+MyFloatToStr(YTrack0,2)); //nolang
   pop_dessin.AddPosition('',XTrack0,YTrack0,8,0,8);

   Alpha1:=0;
   Delta1:=0;
   if Telescope.StoreCoordinates then
      begin
      if Config.GoodPos then
         begin
         Alpha1:=Config.AlphaScope;
         Delta1:=Config.DeltaScope;
         end
      else
         begin
         WriteSpy(lang('Le télescope ne veut pas donner sa position'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope ne veut pas donner sa position'));
         Config.CalibrationEnCours:=False;
         pop_image_acq.Bloque:=False;
         btnChercher.Enabled:=True;
         btn_calibrer.Enabled:=True;
         Button1.Enabled:=True;
         if config.CalibrateSuivi then
            begin
            btn_track_start.enabled:=True;
            Button2.Enabled:=True;
            CheckBox2.Enabled:=True;
            end
         else
            begin
            btn_track_start.enabled:=False;
            Button2.Enabled:=True;
            CheckBox2.Enabled:=False;
            end;
         StopGetPos:=False;

         StopSuivi:=False;
         WriteSpy(lang('Arrêt de la calibration'));
         if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
         Config.SuiviEnCours:=False;
         Exit;
         end;
      end;

   WriteSpy(lang('Déclinaison initiale = '+MyFloatToStr(Delta1,2)));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Déclinaison initiale = '+MyFloatToStr(Delta1,2)));

   //***************************************************************************************************
   //**************************************         SUD        *****************************************
   //***************************************************************************************************
//   a/.On demande le deplacement vers le S pendant 3 secondes.
   DeplaceScope(config.DelaiRattrapageSuiviNS,diSud);

   Config.EtapeCalibration:=4;
   WriteSpy(lang('Recherche de l''étoile la plus brillante'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche de l''étoile la plus brillante'));
   if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
      begin
      AcqMaximumBinning(x,y);
      if CameraSuivi.IsAValidBinning(4) then
         begin
         x:=x*4;
         y:=y*4;
         end
      else
         begin
         x:=x*3;
         y:=y*3;
         end;
      end
   else AcqMaximum(x,y);

   if Config.KeepImage then
      begin
      pop_image2:=tpop_image.create(application);
      DupliquerImage(pop_image_acq,pop_image2,lang('Acquisition'));
      pop_image2.Caption:=pop_main.GiveName(lang('Acquisition'),pop_image2);
      pop_image2.Calib2:=True;
      pop_main.MiseAJourMenu(Self);
      end;

   if StopSuivi then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;

      StopSuivi:=False;
      WriteSpy(lang('Arrêt du guidage'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt du guidage'));
      Config.SuiviEnCours:=False;
      Exit;
      end;

   if (x<=config.LargFenSuivi) or (x>CameraSuivi.GetXSize-config.LargFenSuivi) or
      (y<=config.LargFenSuivi) or (y>CameraSuivi.GetYSize-config.LargFenSuivi) then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
      
      StopSuivi:=False;
      WriteSpy(lang('Etoile de calibration trop prés du bord'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Etoile de calibration trop prés du bord'));
      Exit;
      end;

   WriteSpy(lang('Fenêtrage de l''étoile'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

   if StopSuivi then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;

      StopSuivi:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Config.SuiviEnCours:=False;      
      Exit;
      end;

   Config.EtapeCalibration:=1;
   Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
      y+config.LargFenSuivi,TempsDePose,1,False,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,
      pop_image_acq.ImgInfos);

   GetMax(pop_image_acq.DataInt,pop_image_acq.dataDouble,pop_image_acq.ImgInfos.TypeData
      ,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);

         
   //Soustraction du noir
   if NoirAcquis then
      begin
      GetImgPart(MemPicTrackNoir,ImgDoubleNil,VignetteNoir,ImgDoubleNil,2,1,pop_image_acq.ImgInfos.Sx,
         pop_image_acq.ImgInfos.Sy,x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
         y+config.LargFenSuivi);
      Soust(pop_image_acq.DataInt,VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_image_acq.ImgInfos.Sx,
         pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
      FreememImg(VignetteNoir,ImgDoubleNil,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,2,1);
      end;

   pop_image_acq.AjusteFenetre;
   pop_image_acq.VisuAutoEtoiles;

   // Affichage du max pour vérifier la non saturation
   WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(
      lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));

   ModeliseEtoile(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,
      2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);

   if PSF.Flux=-1 then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
      
      StopSuivi:=False;
      WriteSpy(lang('Erreur de modélisation'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
      Exit;
      end;

   XTrack:=x-config.LargFenSuivi+PSF.X-1;
   YTrack:=y-config.LargFenSuivi+PSF.Y-1;

   WriteSpy(lang('Coordonnées de l''étoile X=')+
      MyFloatToStr(XTrack,2)+' Y='+MyFloatToStr(YTRack,2)); //nolang
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(
      lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrack,2)+
      ' Y='+MyFloatToStr(YTrack,2)); //nolang

   VecteurRatrapSudX:=(XTrack-XTrack0)*CameraSuivi.GetXPixelSize;
   VecteurRatrapSudY:=(YTrack-YTrack0)*CameraSuivi.GetYPixelSize;

   Jeu:=Hypot(VecteurRatrapSudX,VecteurRatrapSudY);
   WriteSpy(lang('Déplacement de rattrapage Sud = ')+MyFloatToStr(Jeu,2)
      +' microns'); //nolang
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Déplacement de rattrapage Sud = ')+MyFloatToStr(Jeu,2)
      +' microns'); //nolang
   XPixelSize:=CameraSuivi.GetXPixelSize;
   YPixelSize:=CameraSuivi.GetYPixelSize;
   if YPixelSize>XPixelSize then
      DimTest:=Config.ErreurPositionGuidage*XPixelSize
   else
      DimTest:=Config.ErreurPositionGuidage*YPixelSize;
   WriteSpy(lang('Déplacement minimal toléré =  ')+MyFloatToStr(DimTest,2)
      +' microns'); //nolang
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Déplacement minimal toléré =  ')+MyFloatToStr(DimTest,2)
         +' microns'); //nolang
   if Jeu<DimTest then
      begin
      WriteSpy(lang('Le déplacement de rattrapage est insuffisant, on arrête la calibration'));
      WriteSpy(lang('Augmentez le temps de rattrappage N/S'));
      if Assigned(pop_calibrate_track) then
         begin
         pop_calibrate_track.AddMessage(lang('Le déplacement de rattrapage est insuffisant, on arrête la calibration'));
         pop_calibrate_track.AddMessage(lang('Augmentez le temps de rattrappage N/S'));
         end;
      Exit;
      end
   else
      begin
      WriteSpy(lang('Le déplacement de rattrapage est suffisant, on continue'));
      if Assigned(pop_calibrate_track) then
         pop_calibrate_track.AddMessage(lang('Le déplacement de rattrapage est suffisant, on continue'));
      end;

   // b/. On demande le deplacement vers le S pendant 9 secondes.
   DeplaceScope(config.DelaiCalibrationSuiviNS,diSud);

   Config.EtapeCalibration:=2;
   WriteSpy(lang('Recherche de l''étoile la plus brillante'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche de l''étoile la plus brillante'));
   if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
      begin
      AcqMaximumBinning(x,y);
      if CameraSuivi.IsAValidBinning(4) then
         begin
         x:=x*4;
         y:=y*4;
         end
      else
         begin
         x:=x*3;
         y:=y*3;
         end;
      end
   else AcqMaximum(x,y);

   if Config.KeepImage then
      begin
      pop_image3:=tpop_image.create(application);
      DupliquerImage(pop_image_acq,pop_image3,lang('Acquisition'));
      pop_image3.Caption:=pop_main.GiveName(lang('Acquisition'),pop_image3);
      pop_image3.Calib3:=True;      
      pop_main.MiseAJourMenu(Self);
      end;

   if StopSuivi then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;

      StopSuivi:=False;
      WriteSpy(lang('Arrêt du guidage'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt du guidage'));
      Config.SuiviEnCours:=False;      
      Exit;
      end;

   if (x<=config.LargFenSuivi) or (x>CameraSuivi.GetXSize-config.LargFenSuivi) or
      (y<=config.LargFenSuivi) or (y>CameraSuivi.GetYSize-config.LargFenSuivi) then
      begin
      StopSuivi:=False;
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
      
      WriteSpy(lang('Etoile de calibration trop prés du bord'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Etoile de calibration trop prés du bord'));
      Exit;
      end;

   WriteSpy(lang('Fenêtrage de l''étoile'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

   if StopSuivi then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;

      StopSuivi:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Config.SuiviEnCours:=False;
      Exit;
      end;

   Config.EtapeCalibration:=1;
   Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
      y+config.LargFenSuivi,TempsDePose,1,False,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos);

   //Soustraction du noir
   if NoirAcquis then
      begin
      GetImgPart(MemPicTrackNoir,ImgDoubleNil,VignetteNoir,ImgDoubleNil,2,1,pop_image_acq.ImgInfos.Sx,
         pop_image_acq.ImgInfos.Sy,x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
         y+config.LargFenSuivi);
      Soust(pop_image_acq.DataInt,VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_image_acq.ImgInfos.Sx,
         pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
      FreememImg(VignetteNoir,ImgDoubleNil,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,2,1);
      end;

   pop_image_acq.AjusteFenetre;
   pop_image_acq.VisuAutoEtoiles;

   GetMax(pop_image_acq.DataInt,pop_image_acq.dataDouble,pop_image_acq.ImgInfos.TypeData
      ,2*config.LargFenSuivi+1,2*config.LargFenSuivi+1,xx,yy,ValMax);

   ModeliseEtoile(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,
      2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);

   if PSF.Flux=-1 then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;

      StopSuivi:=False;
      WriteSpy(lang('Erreur de modélisation'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
      Config.SuiviEnCours:=False;      
      Exit;
      end;

   XTrackXMoins0:=x-config.LargFenSuivi+PSF.X-1;
   YTrackXMoins0:=y-config.LargFenSuivi+PSF.Y-1;

   WriteSpy(lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrackXMoins0,2)+
      ' Y='+MyFloatToStr(YTrackXMoins0,2)); //nolang
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(
      lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrackXMoins0,2)+
      ' Y='+MyFloatToStr(YTrackXMoins0,2)); //nolang
// On ajoute N ou S aprés le mouvement vers l'Est
{   if Telescope.StoreCoordinates then
      begin
      if Delta2-Delta1<0 then
         pop_dessin.AddPosition('N',XTrackXMoins0,YTrackXMoins0,8,8,4)
      else
         pop_dessin.AddPosition('S',XTrackXMoins0,YTrackXMoins0,8,8,4);
      end;}
   pop_dessin.AddPosition('',XTrackXMoins0,YTrackXMoins0,8,8,4);

   if StopSuivi then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
      
      StopSuivi:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Config.SuiviEnCours:=False;      
      Exit;
      end;

//   VecteurRatrapSudX:=(XTrack-XTrack0)*CameraSuivi.GetXPixelSize;
//   VecteurRatrapSudY:=(YTrack-YTrack0)*CameraSuivi.GetYPixelSize;
   config.VecteurSudX:=(XTrackXMoins0-XTrack)*CameraSuivi.GetXPixelSize;
   config.VecteurSudY:=(YTrackXMoins0-YTrack)*CameraSuivi.GetYPixelSize;
   VecteurSudTotalX:=config.VecteurSudX+VecteurRatrapSudX;
   VecteurSudTotalY:=config.VecteurSudY+VecteurRatrapSudY;

   WriteSpy(lang('SudX = ')+FloatToStrF(config.VecteurSudX,ffFixed,4,2)
      +' microns'); //nolang
   WriteSpy(lang('SudY = ')+FloatToStrF(config.VecteurSudY,ffFixed,4,2)
      +' microns'); //nolang
   if Assigned(pop_calibrate_track) then
      begin
      pop_calibrate_track.AddMessage(lang('SudX = ')+FloatToStrF(config.VecteurSudX,ffFixed,4,2)
         +' microns'); //nolang
      pop_calibrate_track.AddMessage(lang('SudY = ')+FloatToStrF(config.VecteurSudY,ffFixed,4,2)
         +' microns'); //nolang
      end;

   // Et ici
   //***************************************************************************************************
   //**************************************         NORD       *****************************************
   //***************************************************************************************************
   // c/. On demande le deplacement vers le N pendant 3 secondes.
   DeplaceScope(config.DelaiRattrapageSuiviNS,diNord);

   Config.EtapeCalibration:=5;
   WriteSpy(lang('Recherche de l''étoile la plus brillante'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche de l''étoile la plus brillante'));
   if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
      begin
      AcqMaximumBinning(x,y);
      if CameraSuivi.IsAValidBinning(4) then
         begin
         x:=x*4;
         y:=y*4;
         end
      else
         begin
         x:=x*3;
         y:=y*3;
         end;
      end
   else AcqMaximum(x,y);

   if Config.KeepImage then
      begin
      pop_image4:=tpop_image.create(application);
      DupliquerImage(pop_image_acq,pop_image4,lang('Acquisition'));
      pop_image4.Caption:=pop_main.GiveName(lang('Acquisition'),pop_image4);
      pop_image4.Calib4:=True;      
      pop_main.MiseAJourMenu(Self);
      end;

   if StopSuivi then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
      
      StopSuivi:=False;
      WriteSpy(lang('Arrêt du guidage'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt du guidage'));
      Config.SuiviEnCours:=False;      
      Exit;
      end;

   if (x<=config.LargFenSuivi) or (x>CameraSuivi.GetXSize-config.LargFenSuivi) or
      (y<=config.LargFenSuivi) or (y>CameraSuivi.GetYSize-config.LargFenSuivi) then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
      
      StopSuivi:=False;
      WriteSpy(lang('Etoile de calibration trop prés du bord'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Etoile de calibration trop prés du bord'));
      Config.SuiviEnCours:=False;      
      Exit;
      end;

   WriteSpy(lang('Fenêtrage de l''étoile'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

   if StopSuivi then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
      
      StopSuivi:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Config.SuiviEnCours:=False;      
      Exit;
      end;

   Config.EtapeCalibration:=1;
   Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
      y+config.LargFenSuivi,TempsDePose,1,False,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,
      pop_image_acq.ImgInfos);

   GetMax(pop_image_acq.DataInt,ImgDoubleNil,2,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);      

   //Soustraction du noir
   if NoirAcquis then
      begin
      GetImgPart(MemPicTrackNoir,ImgDoubleNil,VignetteNoir,ImgDoubleNil,2,1,pop_image_acq.ImgInfos.Sx,
         pop_image_acq.ImgInfos.Sy,x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
         y+config.LargFenSuivi);
      Soust(pop_image_acq.DataInt,VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_image_acq.ImgInfos.Sx,
         pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
      FreememImg(VignetteNoir,ImgDoubleNil,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,2,1);
      end;

   pop_image_acq.AjusteFenetre;
   pop_image_acq.VisuAutoEtoiles;

   // Affichage du max pour vérifier la non saturation
   WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(
      lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));

   ModeliseEtoile(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,
      2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);

   if PSF.Flux=-1 then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
      
      StopSuivi:=False;
      WriteSpy(lang('Erreur de modélisation'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
      Config.SuiviEnCours:=False;      
      Exit;
      end;

   XTrackXMoins:=x-config.LargFenSuivi+PSF.X-1;
   YTrackXMoins:=y-config.LargFenSuivi+PSF.Y-1;

   WriteSpy(lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrackXMoins,2)+
      ' Y='+MyFloatToStr(YTrackXMoins,2)); //nolang
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(
      lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrackXMoins,2)+
      ' Y='+MyFloatToStr(YTrackXMoins,2)); //nolang

   VecteurRatrapNordX:=(XTrackXMoins-XTrackXMoins0)*CameraSuivi.GetXPixelSize;
   VecteurRatrapNordY:=(YTrackXMoins-YTrackXMoins0)*CameraSuivi.GetYPixelSize;

   Jeu:=Hypot(VecteurRatrapNordX,VecteurRatrapNordY);
   WriteSpy(lang('Déplacement de rattrapage Nord = '+MyFloatToStr(Jeu,2))
      +' microns'); //nolang
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Déplacement de rattrapage Nord = '+MyFloatToStr(Jeu,2))
      +' microns'); //nolang
   XPixelSize:=CameraSuivi.GetXPixelSize;
   YPixelSize:=CameraSuivi.GetYPixelSize;
   if YPixelSize>XPixelSize then
      DimTest:=Config.ErreurPositionGuidage*XPixelSize
   else
      DimTest:=Config.ErreurPositionGuidage*YPixelSize;
   WriteSpy(lang('Déplacement minimal toléré =  '+MyFloatToStr(DimTest,2))
      +' microns'); //nolang
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Déplacement minimal toléré =  '+MyFloatToStr(DimTest,2))
         +' microns'); //nolang
   if Jeu<DimTest then
      begin
      WriteSpy(lang('Le déplacement de rattrapage est insuffisant, on arrête la calibration'));
      WriteSpy(lang('Augmentez le temps de rattrappage N/S'));
      if Assigned(pop_calibrate_track) then
         begin
         pop_calibrate_track.AddMessage(lang('Le déplacement de rattrapage est insuffisant, on arrête la calibration'));
         pop_calibrate_track.AddMessage(lang('Augmentez le temps de rattrappage N/S'));
         end;
      Exit;
      end
   else
      begin
      WriteSpy(lang('Le déplacement de rattrapage est suffisant, on continue'));
      if Assigned(pop_calibrate_track) then
         pop_calibrate_track.AddMessage(lang('Le déplacement de rattrapage est suffisant, on continue'));
      end;

   // d/. On demande le deplacement vers le N pendant 9 secondes.
   DeplaceScope(config.DelaiCalibrationSuiviNS,diNord);

   if StopSuivi then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
      
      StopSuivi:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calbration'));
      Config.SuiviEnCours:=False;      
      Exit;
      end;

   Config.EtapeCalibration:=1;
   WriteSpy(lang('Recherche de l''étoile la plus brillante'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche de l''étoile la plus brillante'));
   if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
      begin
      AcqMaximumBinning(x,y);
      if CameraSuivi.IsAValidBinning(4) then
         begin
         x:=x*4;
         y:=y*4;
         end
      else
         begin
         x:=x*3;
         y:=y*3;
         end;
      end
   else AcqMaximum(x,y);

   if Config.KeepImage then
      begin
      pop_image5:=tpop_image.create(application);
      DupliquerImage(pop_image_acq,pop_image5,lang('Acquisition'));
      pop_image5.Caption:=pop_main.GiveName(lang('Acquisition'),pop_image5);
      pop_image5.Calib5:=True;      
      pop_main.MiseAJourMenu(Self);
      end;

   if StopSuivi then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
      
      StopSuivi:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Config.SuiviEnCours:=False;      
      Exit;
      end;

   if (x<=config.LargFenSuivi) or (x>CameraSuivi.GetXSize-config.LargFenSuivi) or
      (y<=config.LargFenSuivi) or (y>CameraSuivi.GetYSize-config.LargFenSuivi) then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
      
      StopSuivi:=False;
      WriteSpy(lang('Etoile de calibration trop prés du bord'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Etoile de calibration trop prés du bord'));
      Config.SuiviEnCours:=False;      
      Exit;
      end;

   WriteSpy(lang('Fenêtrage de l''étoile'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

   if StopSuivi then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
      
      StopSuivi:=False;
      WriteSpy(lang('Arrêt du de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Config.SuiviEnCours:=False;      
      Exit;
      end;

   Config.EtapeCalibration:=1;
   Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,y+config.LargFenSuivi,
      TempsDePose,1,False,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos);

   //Soustraction du noir
   if NoirAcquis then
      begin
      GetImgPart(MemPicTrackNoir,ImgDoubleNil,VignetteNoir,ImgDoubleNil,2,1,pop_image_acq.ImgInfos.Sx,
         pop_image_acq.ImgInfos.Sy,x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
         y+config.LargFenSuivi);
      Soust(pop_image_acq.DataInt,VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_image_acq.ImgInfos.Sx,
         pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
      FreememImg(VignetteNoir,ImgDoubleNil,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,2,1);
      end;

   pop_image_acq.AjusteFenetre;
   pop_image_acq.VisuAutoEtoiles;

   GetMax(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,2*config.LargFenSuivi+1,
      2*config.LargFenSuivi+1,xx,yy,ValMax);
   ModeliseEtoile(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,
      2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);


   if PSF.Flux=-1 then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
      
      StopSuivi:=False;
      WriteSpy(lang('Erreur de modélisation'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
      Config.SuiviEnCours:=False;      
      Exit;
      end;

   XTrackXPlus:=x-config.LargFenSuivi+PSF.X-1;
   YTrackXPlus:=y-config.LargFenSuivi+PSF.Y-1;

   WriteSpy(lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrackXPlus,2)+
      ' Y='+MyFloatToStr(YTrackXPlus,2)); //nolang
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(
      lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrackXPlus,2)+
      ' Y='+MyFloatToStr(YTrackXPlus,2)); //nolang
   pop_dessin.AddPosition('',XTrackXPlus,YTrackXPlus,8,16,4);

   if StopSuivi then
      begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
      
      StopSuivi:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Config.SuiviEnCours:=False;      
      Exit;
      end;

   config.VecteurNordX:=(XTrackXPlus-XTrackXMoins)*CameraSuivi.GetXPixelSize;
   config.VecteurNordY:=(YTrackXPlus-YTrackXMoins)*CameraSuivi.GetYPixelSize;
   VecteurNordTotalX:=config.VecteurNordX+VecteurRatrapNordX;
   VecteurNordTotalY:=config.VecteurNordY+VecteurRatrapNordY;

//   JeuDelta:=Abs(Hypot(config.VecteurSudX,config.VecteurSudY)-Hypot(config.VecteurNordX,config.VecteurNordY));
   JeuDelta:=Hypot((XTrackXPlus-XTrack0)*CameraSuivi.GetXPixelSize,(YTrackXPlus-YTrack0)*CameraSuivi.GetYPixelSize);
   WriteSpy(lang('Erreur sur la position de retour Nord/Sud =  '+MyFloatToStr(JeuDelta,2))
      +' microns'); //nolang
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Difference de deplacement Nord/Sud = '+MyFloatToStr(JeuDelta,2))
      +' microns'); //nolang
   XPixelSize:=CameraSuivi.GetXPixelSize;
   YPixelSize:=CameraSuivi.GetYPixelSize;
   if YPixelSize>XPixelSize then
      DimTest:=Config.ErreurPositionGuidage*XPixelSize
   else
      DimTest:=Config.ErreurPositionGuidage*YPixelSize;
   WriteSpy(lang('Erreur maximale tolérée =  '+MyFloatToStr(DimTest,2))
      +' microns'); //nolang
   if JeuDelta>DimTest then
      begin
      if NbTryJeuDelta<>2 then
         begin
         WriteSpy(lang('Jeu mal pris en compte dans le mouvement Nord/Sud'));
         if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Jeu mal pris en compte dans le mouvement Nord/Sud'));
         WriteSpy(lang('On relance la calibration'));
         if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('On relance la calibration'));
         end;
      pop_dessin.Efface;
      Inc(NbTryJeuDelta)
      end
   else
      begin
      WriteSpy(lang('Jeu bien pris en compte dans le mouvement Nord/Sud'));
      WriteSpy(lang('On continue la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Jeu bien pris en compte dans le mouvement Nord/Sud'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('On continue la calibration'));
      JeuDeltaOK:=True;
      end;
   end;

if NbTryJeuDelta=3 then
   begin
   WriteSpy(lang('L''erreur sur le retour à la position N/S reste supérieure à la tolérance'));
   WriteSpy(lang('La calibration a échoué, on arrête'));
   WriteSpy(lang('Augmentez la tolérance ou changez d''étoile'));
   if Assigned(pop_calibrate_track) then
      begin
      pop_calibrate_track.AddMessage(lang('L''erreur sur le retour à la position N/S reste supérieure à la tolérance'));
      pop_calibrate_track.AddMessage(lang('La calibration a échoué, on arrête'));
      pop_calibrate_track.AddMessage(lang('Augmentez la tolérance ou changez d''étoile'));
      end;
   Exit;
   end;

WriteSpy(lang('NordX = ')+FloatToStrF(config.VecteurNordX,ffFixed,4,2)
   +' microns'); //nolang
WriteSpy(lang('NordY = ')+FloatToStrF(config.VecteurNordY,ffFixed,4,2)
   +' microns'); //nolang
if Assigned(pop_calibrate_track) then
   begin
   pop_calibrate_track.AddMessage(lang('NordX = ')+FloatToStrF(config.VecteurNordX,ffFixed,4,2)
      +' microns'); //nolang
   pop_calibrate_track.AddMessage(lang('NordY = ')+FloatToStrF(config.VecteurNordY,ffFixed,4,2)
      +' microns'); //nolang
   end;

//***************************************************************************************************
//**************************************         EST        *****************************************
//***************************************************************************************************
DeplaceScope(config.DelaiCalibrationSuiviEO,diEst);

Config.EtapeCalibration:=3;
WriteSpy(lang('Recherche de l''étoile la plus brillante'));
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche de l''étoile la plus brillante'));
if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
   begin
   AcqMaximumBinning(x,y);
   if CameraSuivi.IsAValidBinning(4) then
      begin
      x:=x*4;
      y:=y*4;
      end
   else
      begin
      x:=x*3;
      y:=y*3;
      end;
   end
else AcqMaximum(x,y);

if Config.KeepImage then
   begin
   pop_image6:=tpop_image.create(application);
   DupliquerImage(pop_image_acq,pop_image6,lang('Acquisition'));
   pop_image6.Caption:=pop_main.GiveName(lang('Acquisition'),pop_image6);
   pop_image6.Calib6:=True;   
   pop_main.MiseAJourMenu(Self);
   end;

if StopSuivi then
   begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
   
   StopSuivi:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Config.SuiviEnCours:=False;   
   Exit;
   end;

if (x<=config.LargFenSuivi) or (x>CameraSuivi.GetXSize-config.LargFenSuivi) or
   (y<=config.LargFenSuivi) or (y>CameraSuivi.GetYSize-config.LargFenSuivi) then
   begin
   StopSuivi:=False;
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
   
   WriteSpy(lang('Etoile de calibration trop prés du bord'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Etoile de calibration trop prés du bord'));
   Config.SuiviEnCours:=False;   
   Exit;
   end;

WriteSpy(lang('Fenêtrage de l''étoile'));
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

if StopSuivi then
   begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
   
   StopSuivi:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Config.SuiviEnCours:=False;   
   Exit;
   end;

Config.EtapeCalibration:=1;
Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,y+config.LargFenSuivi,
   TempsDePose,1,False,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos);

//Soustraction du noir
if NoirAcquis then
   begin
   GetImgPart(MemPicTrackNoir,ImgDoubleNil,VignetteNoir,ImgDoubleNil,2,1,pop_image_acq.ImgInfos.Sx,
      pop_image_acq.ImgInfos.Sy,x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
      y+config.LargFenSuivi);
   Soust(pop_image_acq.DataInt,VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_image_acq.ImgInfos.Sx,
      pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   FreememImg(VignetteNoir,ImgDoubleNil,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,2,1);
   end;

pop_image_acq.AjusteFenetre;
pop_image_acq.VisuAutoEtoiles;

GetMax(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,2*config.LargFenSuivi+1,
   2*config.LargFenSuivi+1,xx,yy,ValMax);

//ModeliseEtoile(pop_image_acq.DataInt,nil,2,2*config.LargFenSuivi+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
ModeliseEtoile(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,
   2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);


if PSF.Flux=-1 then
   begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
   
   StopSuivi:=False;
   WriteSpy(lang('Erreur de modélisation'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
   Config.SuiviEnCours:=False;   
   Exit;
   end;

XTrackYPlus:=x-config.LargFenSuivi+PSF.X-1;
YTrackYPlus:=y-config.LargFenSuivi+PSF.Y-1;

WriteSpy(lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrackYPlus,2)+
   ' Y='+MyFloatToStr(YTrackYPlus,2)); //nolang
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(
   lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrackYPlus,2)+
   ' Y='+MyFloatToStr(YTrackYPlus,2)); //nolang
pop_dessin.AddPosition('W',XTrackYPlus,YTrackYPlus,8,8,4);

if StopSuivi then
   begin
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;
   
   StopSuivi:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Config.SuiviEnCours:=False;   
   Exit;
   end;

config.VecteurEstX:=(XTrackYPlus-XTrackXPlus)*CameraSuivi.GetXPixelSize;
config.VecteurEstY:=(YTrackYPlus-YTrackXPlus)*CameraSuivi.GetYPixelSize;

WriteSpy(lang('EstX = ')+FloatToStrF(config.VecteurEstX,ffFixed,4,2)
   +' microns'); //nolang
WriteSpy(lang('EstY = ')+FloatToStrF(config.VecteurEstY,ffFixed,4,2)
   +' microns'); //nolang
if Assigned(pop_calibrate_track) then
   begin
   pop_calibrate_track.AddMessage(lang('EstX = ')+FloatToStrF(config.VecteurEstX,ffFixed,4,2)
      +' microns'); //nolang
   pop_calibrate_track.AddMessage(lang('EstY = ')+FloatToStrF(config.VecteurEstY,ffFixed,4,2)
      +' microns'); //nolang
   end;

// On ajoute N ou S maintenant
// En se fondant sur le signe du produit vectoriel entre le mouvement sud et le mouvement est
ProduitVectorielSudEst:=config.VecteurSudX*config.VecteurEstY-config.VecteurSudY*config.VecteurEstX;
if ProduitVectorielSudEst>=0 then
   begin
   pop_dessin.AddPosition('S',XTrackXMoins0,YTrackXMoins0,8,8,4);
   WriteSpy(lang('Le vecteur Est fait un angle de +90 degrés avec le vecteur Sud'));
   WriteSpy('Aprés le premier mouvement Nord/Sud l''étoile s''était donc déplacée vers le Sud');
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Le vecteur Est fait un angle de +90 degrés avec le vecteur Sud'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage('Aprés le premier mouvement Nord/Sud l''étoile s''était donc déplacée vers le Sud');
   end
else
   begin
   pop_dessin.AddPosition('N',XTrackXMoins0,YTrackXMoins0,8,8,4);
   WriteSpy(lang('Le vecteur Est fait un angle de -90 degrés avec le vecteur Sud'));
   WriteSpy('Aprés le premier mouvement Nord/Sud l''étoile s''était donc déplacée vers le Nord');
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Le vecteur Est fait un angle de -90 degrés avec le vecteur Sud'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage('Aprés le premier mouvement Nord/Sud l''étoile s''était donc déplacée vers le Nord');
   end;

//***************************************************************************************************
//**************************************       OUEST        *****************************************
//***************************************************************************************************
DeplaceScope(config.DelaiCalibrationSuiviEO,diOuest);

Config.EtapeCalibration:=1;
WriteSpy(lang('Recherche de l''étoile la plus brillante'));
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche de l''étoile la plus brillante'));
if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
   begin
   AcqMaximumBinning(x,y);
   if CameraSuivi.IsAValidBinning(4) then
      begin
      x:=x*4;
      y:=y*4;
      end
   else
      begin
      x:=x*3;
      y:=y*3;
      end;
   end
else AcqMaximum(x,y);

if Config.KeepImage then
   begin
   pop_image7:=tpop_image.create(application);
   DupliquerImage(pop_image_acq,pop_image7,lang('Acquisition'));
   pop_image7.Caption:=pop_main.GiveName(lang('Acquisition'),pop_image7);
   pop_image7.Calib7:=True;   
   pop_main.MiseAJourMenu(Self);
   end;

if StopSuivi then
   begin
   Config.CalibrationEnCours:=False;
   pop_image_acq.Bloque:=False;
   btnChercher.Enabled:=True;
   btn_calibrer.Enabled:=True;
   Button1.Enabled:=True;
   if config.CalibrateSuivi then
      begin
      btn_track_start.enabled:=True;
      Button2.Enabled:=True;
      CheckBox2.Enabled:=True;
      end
   else
      begin
      btn_track_start.enabled:=False;
      Button2.Enabled:=True;
      CheckBox2.Enabled:=False;
      end;
   StopGetPos:=False;

   StopSuivi:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Config.SuiviEnCours:=False;   
   Exit;
   end;

if (x<=config.LargFenSuivi) or (x>CameraSuivi.GetXSize-config.LargFenSuivi) or
   (y<=config.LargFenSuivi) or (y>CameraSuivi.GetYSize-config.LargFenSuivi) then
   begin
   Config.CalibrationEnCours:=False;
   pop_image_acq.Bloque:=False;
   btnChercher.Enabled:=True;
   btn_calibrer.Enabled:=True;
   Button1.Enabled:=True;
   if config.CalibrateSuivi then
      begin
      btn_track_start.enabled:=True;
      Button2.Enabled:=True;
      CheckBox2.Enabled:=True;
      end
   else
      begin
      btn_track_start.enabled:=False;
      Button2.Enabled:=True;
      CheckBox2.Enabled:=False;
      end;
   StopGetPos:=False;
   
   StopSuivi:=False;
   WriteSpy(lang('Etoile de calibration trop prés du bord'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Etoile de calibration trop prés du bord'));
   Config.SuiviEnCours:=False;   
   Exit;
   end;

WriteSpy(lang('Fenêtrage de l''étoile'));
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

if StopSuivi then
   begin
   Config.CalibrationEnCours:=False;
   pop_image_acq.Bloque:=False;
   btnChercher.Enabled:=True;
   btn_calibrer.Enabled:=True;
   Button1.Enabled:=True;
   if config.CalibrateSuivi then
      begin
      btn_track_start.enabled:=True;
      Button2.Enabled:=True;
      CheckBox2.Enabled:=True;
      end
   else
      begin
      btn_track_start.enabled:=False;
      Button2.Enabled:=True;
      CheckBox2.Enabled:=False;
      end;
   StopGetPos:=False;

   StopSuivi:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Config.SuiviEnCours:=False;   
   Exit;
   end;

Config.EtapeCalibration:=1;
Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,y+config.LargFenSuivi,
   TempsDePose,1,False,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos);

//Soustraction du noir
if NoirAcquis then
   begin
   GetImgPart(MemPicTrackNoir,ImgDoubleNil,VignetteNoir,ImgDoubleNil,2,1,pop_image_acq.ImgInfos.Sx,
      pop_image_acq.ImgInfos.Sy,x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
      y+config.LargFenSuivi);
   Soust(pop_image_acq.DataInt,VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_image_acq.ImgInfos.Sx,
      pop_image_acq.ImgInfos.Sy,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   FreememImg(VignetteNoir,ImgDoubleNil,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,2,1);
   end;

pop_image_acq.AjusteFenetre;
pop_image_acq.VisuAutoEtoiles;

GetMax(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,2*config.LargFenSuivi+1,
   2*config.LargFenSuivi+1,xx,yy,ValMax);

ModeliseEtoile(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,
   2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);

if PSF.Flux=-1 then
   begin
   Config.CalibrationEnCours:=False;
   pop_image_acq.Bloque:=False;
   btnChercher.Enabled:=True;
   btn_calibrer.Enabled:=True;
   Button1.Enabled:=True;
   if config.CalibrateSuivi then
      begin
      btn_track_start.enabled:=True;
      Button2.Enabled:=True;
      CheckBox2.Enabled:=True;
      end
   else
      begin
      btn_track_start.enabled:=False;
      Button2.Enabled:=True;
      CheckBox2.Enabled:=False;
      end;
   StopGetPos:=False;
   
   StopSuivi:=False;
   WriteSpy(lang('Erreur de modélisation'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
   Config.SuiviEnCours:=False;   
   Exit;
   end;

XTrackYMoins:=x-config.LargFenSuivi+PSF.X-1;
YTrackYMoins:=y-config.LargFenSuivi+PSF.Y-1;

WriteSpy(lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrackYMoins,2)+
   ' Y='+MyFloatToStr(YTrackYMoins,2)); //nolang
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(
   lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrackYMoins,2)+
   ' Y='+MyFloatToStr(YTrackYMoins,2)); //nolang
pop_dessin.AddPosition('',XTrackYMoins,YTrackYMoins,8,-16,4);

if StopSuivi then
   begin
   Config.CalibrationEnCours:=False;
   pop_image_acq.Bloque:=False;
   btnChercher.Enabled:=True;
   btn_calibrer.Enabled:=True;
   Button1.Enabled:=True;
   if config.CalibrateSuivi then
      begin
      btn_track_start.enabled:=True;
      Button2.Enabled:=True;
      CheckBox2.Enabled:=True;
      end
   else
      begin
      btn_track_start.enabled:=False;
      Button2.Enabled:=True;
      CheckBox2.Enabled:=False;
      end;
   StopGetPos:=False;

   StopSuivi:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Config.SuiviEnCours:=False;   
   Exit;
   end;

config.VecteurOuestX:=(XTrackYMoins-XTrackYPlus)*CameraSuivi.GetXPixelSize;
config.VecteurOuestY:=(YTrackYMoins-YTrackYPlus)*CameraSuivi.GetYPixelSize;

WriteSpy(lang('OuestX = ')+FloatToStrF(config.VecteurOuestX,ffFixed,4,2)
   +' microns'); //nolang
WriteSpy(lang('OuestY = ')+FloatToStrF(config.VecteurOuestY,ffFixed,4,2)
   +' microns'); //nolang
if Assigned(pop_calibrate_track) then
   begin
   pop_calibrate_track.AddMessage(lang('OuestX = ')+FloatToStrF(config.VecteurOuestX,ffFixed,4,2)
      +' microns'); //nolang
   pop_calibrate_track.AddMessage(lang('OuestY = ')+FloatToStrF(config.VecteurOuestY,ffFixed,4,2)
      +' microns'); //nolang
   end;

// Test si on revient au meme endroit
JeuAlpha:=Abs(Hypot(config.VecteurEstX,config.VecteurEstY)-Hypot(config.VecteurOuestX,config.VecteurOuestY));
WriteSpy(lang('Erreur sur la position de retour Est/Ouest =  '+MyFloatToStr(JeuAlpha,2))
   +' microns'); //nolang
if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Difference de deplacement Est/Ouest = '+MyFloatToStr(JeuAlpha,2))
      +' microns'); //nolang
XPixelSize:=CameraSuivi.GetXPixelSize;
YPixelSize:=CameraSuivi.GetYPixelSize;
if YPixelSize>XPixelSize then DimTest:=2*XPixelSize else DimTest:=2*YPixelSize;
WriteSpy(lang('Erreur maximale tolérée =  '+MyFloatToStr(DimTest,2))
   +' microns'); //nolang
if JeuAlpha>2*DimTest then
   begin
   WriteSpy(lang('L''erreur sur le retour à la position E/W est supérieure à la tolérance'));
   WriteSpy(lang('La calibration a échoue, on arrête'));
   WriteSpy(lang('Augmentez la tolérance ou changez d''étoile'));
   if Assigned(pop_calibrate_track) then
      begin
      pop_calibrate_track.AddMessage(lang('L''erreur sur le retour à la position E/W est supérieure à la tolérance'));
      pop_calibrate_track.AddMessage(lang('La calibration a échoue, on arrête'));
      pop_calibrate_track.AddMessage(lang('Augmentez la tolérance ou changez d''étoile'));
      end;
   end;

//*****************************************************************************************************
//*****************************************************************************************************
//*****************************************************************************************************
//*****************************************************************************************************
//*****************************************************************************************************

// Test de la calibration
Erreur:=False;
TooSlowNS:=False;
TooSlowEW:=False;
if Hypot(config.VecteurNordX,config.VecteurNordY)<10 then
   begin
   WriteSpy(lang('Vecteur Nord trop court (<10), augmentez le temps de calibration'));
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Vecteur Nord trop court (<10), augmentez le temps de calibration'));
   Erreur:=True;
   TooSlowNS:=True;
   end;
if Hypot(config.VecteurSudX,config.VecteurSudY)<10 then
   begin
   WriteSpy(lang('Vecteur Sud trop court (<10), augmentez le temps de calibration'));
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Vecteur Sud trop court (<10), augmentez le temps de calibration'));
   Erreur:=True;
   TooSlowNS:=True;
   end;
if Hypot(config.VecteurEstX,config.VecteurEstY)<10 then
   begin
   WriteSpy(lang('Vecteur Est trop court (<10), augmentez le temps de calibration ou diminuez la déclinaison'));
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Vecteur Est trop court (<10), augmentez le temps de calibration ou diminuez la déclinaison'));
   Erreur:=True;
   TooSlowEW:=True;
   end;
if Hypot(config.VecteurOuestX,config.VecteurOuestY)<10 then
   begin
   WriteSpy(lang('Vecteur Ouest trop court (<10), augmentez le temps de calibration ou diminuez la déclinaison'));
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Vecteur Ouest trop court (<10), augmentez le temps de calibration ou diminuez la déclinaison'));
   Erreur:=True;
   TooSlowEW:=True;
   end;

if TooSlowNS then
   begin
   WriteSpy(lang('Le déplacement Nord/Sud est trop petit, augmentez le temps de calibration Nord/Sud'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Le déplacement Nord/Sud est trop petit, augmentez le temps de calibration Nord/Sud'));
   WriteSpy(lang('Echec de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Echec de la calibration'));
   Exit;
   end;
if TooSlowEW then
   begin
   WriteSpy(lang('Le déplacement Est/Ouest est trop petit, augmentez le temps de calibration Est/Ouest'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Le déplacement Est/Ouest est trop petit, augmentez le temps de calibration Est/Ouest'));
   WriteSpy(lang('Echec de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Echec de la calibration'));
   Exit;
   end;

NotPerpend:=False;
Angle:=ArcCos((config.VecteurNordX*Config.VecteurOuestX+config.VecteurNordY*Config.VecteurOuestY)/
       Hypot(config.VecteurNordX,config.VecteurNordY)/Hypot(config.VecteurOuestX,config.VecteurOuestY))*180/pi;
WriteSpy(lang('Angle entre les vecteurs Nord et Ouest : ')+MyFloatToStr(Angle,2));
if Assigned(pop_calibrate_track) then
   pop_calibrate_track.AddMessage(lang('Angle entre les vecteurs Nord et Ouest : ')+MyFloatToStr(Angle,2));
if Abs(90-Angle)>Config.ErreurAngleGuidage then
   begin
   WriteSpy(lang('Vecteurs Nord et Ouest non perpendiculaires'));
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Vecteurs Nord et Ouest non perpendiculaires'));
   Erreur:=True;
   NotPerpend:=True;
   end;
Angle:=ArcCos((config.VecteurOuestX*Config.VecteurSudX+config.VecteurOuestY*Config.VecteurSudY)/
       Hypot(config.VecteurSudX,config.VecteurSudY)/Hypot(config.VecteurOuestX,config.VecteurOuestY))*180/pi;
WriteSpy(lang('Angle entre les vecteurs Ouest et Sud : ')+MyFloatToStr(Angle,2));
if Assigned(pop_calibrate_track) then
   pop_calibrate_track.AddMessage(lang('Angle entre les vecteurs Ouest et Sud : ')+MyFloatToStr(Angle,2));
if Abs(90-Angle)>Config.ErreurAngleGuidage then
   begin
   WriteSpy(lang('Vecteurs Ouest et Sud non perpendiculaires'));
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Vecteurs Ouest et Sud non perpendiculaires'));
   Erreur:=True;
   NotPerpend:=True;
   end;
Angle:=ArcCos((config.VecteurSudX*Config.VecteurEstX+config.VecteurSudY*Config.VecteurEstY)/
       Hypot(config.VecteurSudX,config.VecteurSudY)/Hypot(config.VecteurEstX,config.VecteurEstY))*180/pi;
WriteSpy(lang('Angle entre les vecteurs Sud et Est : ')+MyFloatToStr(Angle,2));
if Assigned(pop_calibrate_track) then
   pop_calibrate_track.AddMessage(lang('Angle entre les vecteurs Sud et Est : ')+MyFloatToStr(Angle,2));
if Abs(90-Angle)>Config.ErreurAngleGuidage then
   begin
   WriteSpy(lang('Vecteurs Sud et Est non perpendiculaires'));
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Vecteurs Sud et Est non perpendiculaires'));
   Erreur:=True;
   NotPerpend:=True;
   end;
Angle:=ArcCos((config.VecteurEstX*Config.VecteurNordX+config.VecteurEstY*Config.VecteurNordY)/
       Hypot(config.VecteurNordX,config.VecteurNordY)/Hypot(config.VecteurEstX,config.VecteurEstY))*180/pi;
WriteSpy(lang('Angle entre les vecteurs Est et Nord : ')+MyFloatToStr(Angle,2));
if Assigned(pop_calibrate_track) then
   pop_calibrate_track.AddMessage(lang('Angle entre les vecteurs Est et Nord : ')+MyFloatToStr(Angle,2));
if Abs(90-Angle)>Config.ErreurAngleGuidage then
   begin
   WriteSpy(lang('Vecteurs Est et Nord non perpendiculaires'));
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Vecteurs Est et Nord non perpendiculaires'));
   Erreur:=True;
   NotPerpend:=True;
   end;

if NotPerpend then
   begin
   WriteSpy('L''erreur d''orthogonalité est supérieure à la tolérance');
   WriteSpy(lang('La calibration a échoué, on arrête'));
   WriteSpy('Augmentez la tolérance ou changez d''étoile');
   if Assigned(pop_calibrate_track) then
      begin
      pop_calibrate_track.AddMessage('L''erreur d''orthogonalité est supérieure à la tolérance');
      pop_calibrate_track.AddMessage(lang('La calibration a échoué, on arrête'));
      pop_calibrate_track.AddMessage('Augmentez la tolérance ou changez d''étoile');
      end;
   Exit;
   end;

// Entre -180 et +180 degres
{ ArcTan2 calculates ArcTan(Y/X), and returns an angle in the correct quadrant.
  IN: |Y| < 2^64, |X| < 2^64, X <> 0   OUT: [-PI..PI] radians }
//if Telescope.StoreCoordinates then
//   begin
//   if Delta2-Delta1<0 then
   if ProduitVectorielSudEst<=0 then
      Config.OrientationCCDGuidage:=90+ArcTan2(config.VecteurNordY,config.VecteurNordX)*180/pi
   else
      Config.OrientationCCDGuidage:=-90+ArcTan2(config.VecteurNordY,config.VecteurNordX)*180/pi;
   if Config.OrientationCCDGuidage<=-180 then Config.OrientationCCDGuidage:=Config.OrientationCCDGuidage+360;
   if Config.OrientationCCDGuidage>180 then Config.OrientationCCDGuidage:=Config.OrientationCCDGuidage-360;
//   end;

// Si la camera principale est une ST7 ou une ST8 CCD Principal et que
// la camera de guidage est une STTrack, on considere que c'est la meme
// camera donc que les deux CCD sont orientes pareil
if (Config.TypeCamera=ST7) or (Config.TypeCamera=ST8) then
   if (Config.TypeCameraSuivi=STTrack) then
      Config.OrientationCCD:=Config.OrientationCCDGuidage;

//Direction du N a xx° du 1/2 axe des y dans le sens trigo.
WriteSpy(lang('La direction du Nord est à '+MyFloatToStr(Config.OrientationCCDGuidage,2)
   +lang('° du 1/2 axe des y du CCD de guidage dans le sens trigo')));
if Assigned(pop_calibrate_track) then
   begin
   pop_calibrate_track.AddMessage(lang('La direction du Nord est à '+
      MyFloatToStr(Config.OrientationCCDGuidage,2)+lang('° du 1/2 axe des y du CCD de guidage dans le sens trigo')));
   end;

//24 h = 86400 s.
//La vitesse siderale est
//S = 2*3.1416/86400 rad/s
//Si F est la distance focale, la vitesse siderale dans le plan focal est Vs telle que:
//Vs = S*F en mm/s si F est comptee en mm
//Vs = (1/1000)*S*F en mu/s si F est comptee en mm.
Config.VitesseGuidage:=2*pi*Config.FocaleTele*Telescope.GetGuideSpeed/86400*1000; // Microns/Secondes
//Vitesse nominale de correction = 78.9 mu/s.
{if Config.VitesseGuidage<>0 then
   begin
   WriteSpy(lang('Vitesse nominale de correction = '+MyFloatToStr(Config.VitesseGuidage,2)
      +lang(' microns/secondes')));
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Vitesse nominale de correction = '+MyFloatToStr(Config.VitesseGuidage,2)
         +lang(' microns/secondes')));
  end;}

//-apparente en divisant le deplacement total par 12s (9s+3s)
//   VecteurSudTotalX:=config.VecteurSudX+VecteurRatrapSudX;
//   VecteurSudTotalY:=config.VecteurSudY+VecteurRatrapSudY;
ModuleNord:=Hypot(VecteurNordTotalX,VecteurNordTotalY);
ModuleSud:=Hypot(VecteurSudTotalX,VecteurSudTotalY);
if ModuleNord>ModuleSud then DeplacementNSMaxi:=ModuleNord else DeplacementNSMaxi:=ModuleSud;
Config.VitesseGuidageApparenteDelta:=DeplacementNSMaxi/(Config.DelaiCalibrationSuiviNS+Config.DelaiRattrapageSuiviNS);
//Vitesse apparente de correction en delta =
if Config.VitesseGuidageApparenteDelta<>0 then
   begin
   WriteSpy(lang('Vitesse apparente de guidage en N/S = '+MyFloatToStr(Config.VitesseGuidageApparenteDelta,2)
      +lang(' microns/secondes')));
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Vitesse apparente de guidage en N/S = '+
         MyFloatToStr(Config.VitesseGuidageApparenteDelta,2)+lang(' microns/secondes')));
  end;

//3.1.Vitesse reelle de correction en delta.
//Elle prend la place de l'actuelle "Vitesse nominale de correction"
//On prend la valeur la plus grande des vitesses reelles mesurees en b/. et en d/ .
//On mesure les vitesses de correction vers le S :
//-reelle en divisant le 2e deplacement par 9s
//-apparente en divisant le deplacement total par 12s (9s+3s)
//C'est cette vitesse qui sera utilisee par le guidage.
//Elle est mentionnee dans le releve, par exemple :
//Vitesse reelle de correction en delta = 78.9 microns par seconde.
ModuleNord:=Hypot(Config.VecteurNordX,Config.VecteurNordY);
ModuleSud:=Hypot(Config.VecteurSudX,Config.VecteurSudY);
if ModuleNord>ModuleSud then DeplacementNSMaxi:=ModuleNord else DeplacementNSMaxi:=ModuleSud;
Config.VitesseGuidageReelleDelta:=DeplacementNSMaxi/Config.DelaiCalibrationSuiviNS;
WriteSpy(lang('Vitesse réelle de guidage en N/S = '+MyFloatToStr(Config.VitesseGuidageReelleDelta,2)
   +lang(' microns/secondes')));
if Assigned(pop_calibrate_track) then
   pop_calibrate_track.AddMessage(lang('Vitesse réelle de guidage en N/S = '+
      MyFloatToStr(Config.VitesseGuidageReelleDelta,2)+lang(' microns/secondes')));

//Vitesse relle de correction en alpha = 59.2 mu/s
{ModuleNord:=Hypot(Config.VecteurNordX,Config.VecteurNordY);
ModuleSud:=Hypot(Config.VecteurSudX,Config.VecteurSudY);
if ModuleNord>ModuleSud then DeplacementNSMini:=ModuleSud else DeplacementNSMini:=ModuleNord;
Config.VitesseGuidageApparenteDelta:=DeplacementNSMini/Config.DelaiCalibrationSuiviNS;
WriteSpy(lang('Vitesse apparente de correction en delta = '+MyFloatToStr(Config.VitesseGuidageApparenteDelta,2)
   +lang(' microns/secondes')));
if Assigned(pop_calibrate_track) then
   pop_calibrate_track.AddMessage(lang('Vitesse apparente de correction en delta = '+MyFloatToStr(Config.VitesseGuidageApparenteDelta,2)
      +lang(' microns/secondes')));}

//Vitesse relle de correction en alpha = 59.2 mu/s
ModuleEst:=Hypot(Config.VecteurEstX,Config.VecteurEstY);
ModuleOuest:=Hypot(Config.VecteurOuestX,Config.VecteurOuestY);
if ModuleEst>ModuleOuest then DeplacementEOMaxi:=ModuleEst else DeplacementEOMaxi:=ModuleOuest;
Config.VitesseGuidageApparenteAlpha:=DeplacementEOMaxi/Config.DelaiCalibrationSuiviEO;
WriteSpy(lang('Vitesse de calibration en E/W = '+MyFloatToStr(Config.VitesseGuidageApparenteAlpha,2)
   +lang(' microns/secondes')));
if Assigned(pop_calibrate_track) then
   pop_calibrate_track.AddMessage(lang('Vitesse de calibration en E/W = '+MyFloatToStr(Config.VitesseGuidageApparenteAlpha,2)
      +lang(' microns/secondes')));

//3.2.Jeu en delta.
//Il se calcule comme actuellement.
//Appelons :
//-Va = vitesse apparente (la plus grande de celles calculees en b/. et en d/), par exemple  49.33 mu/s
//-Vr = vitesse reelle (donnee en 3.1.), ici 78.9 mu/s
//-T = le temps total (rattrapage + calibration), ici 12s
//-j = jeu de la monture en delta.
//On peut voir que
//j = T (1-Va/Vr) soit ici 12 (1 - 49.33 / 78.9) = 4.5 s
//Cette valeur est annoncee dans le releve :
//Jeu en delta = 4.5 secondes.

if Config.VitesseGuidageReelleDelta<>0 then
   begin
   Jeu:=(Config.DelaiCalibrationSuiviNS+Config.DelaiRattrapageSuiviNS)*
      (1-Config.VitesseGuidageApparenteDelta/Config.VitesseGuidageReelleDelta);
   WriteSpy(lang('Jeu en N/S = '+MyFloatToStr(Jeu,2)
      +lang(' secondes')));
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Jeu en N/S = '+MyFloatToStr(Jeu,2)
      +lang(' secondes')));
   end;

//Jeu en delta = 4.7 s.
//j = tNS (1 - Va/V0)
{if Config.VitesseGuidage<>0 then
   begin
   Jeu:=Config.DelaiCalibrationSuiviNS*(1-Config.VitesseGuidageApparenteDelta/Config.VitesseGuidage);
   WriteSpy(lang('Jeu en delta = '+MyFloatToStr(Jeu,2)
      +lang(' secondes')));
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Jeu en delta = '+MyFloatToStr(Jeu,2)
      +lang(' secondes')));
   end;}

//Facteur maximal de moderation recommande = 0.62.
//k = Va/V0
{if Config.VitesseGuidage<>0 then
   begin
   Facteur:=Config.VitesseGuidageApparenteDelta/Config.VitesseGuidage;
   WriteSpy(lang('Facteur maximal de moderation Nord/Sud recommande = '+MyFloatToStr(Facteur,2)));
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Facteur maximal de moderation Nord/Sud recommande = '+MyFloatToStr(Facteur,2)));
   end;}

Alpha:=0;
Config.DeltaSuivi:=0;
if Telescope.StoreCoordinates then
   begin
   if Config.GoodPos then
      begin
      Alpha:=Config.AlphaScope;
      Config.DeltaSuivi:=Config.DeltaScope;

      Config.AHSuivi:=GetHourAngle(GetHourDT,Alpha,Config.Long)/15; //Degres -> heure
      WriteSpy(lang('Angle Horaire aprés calibration du guidage = ')+AlphaToStr(Config.AHSuivi));
      if Assigned(pop_calibrate_track) then
         pop_calibrate_track.AddMessage(lang('Angle Horaire aprés calibration du guidage = ')+AlphaToStr(Config.AHSuivi));
      pop_camera_suivi.NbreEdit1.Text:=MyFloatToStr(Config.DeltaSuivi,2);
      end
   else
      begin
      WriteSpy(lang('Le télescope ne veut pas donner sa position'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope ne veut pas donner sa position'));
      Config.CalibrationEnCours:=False;
      pop_image_acq.Bloque:=False;
      btnChercher.Enabled:=True;
      btn_calibrer.Enabled:=True;
      Button1.Enabled:=True;
      if config.CalibrateSuivi then
         begin
         btn_track_start.enabled:=True;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=True;
         end
      else
         begin
         btn_track_start.enabled:=False;
         Button2.Enabled:=True;
         CheckBox2.Enabled:=False;
         end;
      StopGetPos:=False;

      StopSuivi:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Config.SuiviEnCours:=False;
      Exit;
      end;
   end
else Config.DeltaSuivi:=MyStrToFloat(NbreEdit1.Text);

if not Erreur then
   begin
   config.CalibrateSuivi:=True;
   CheckBox2.Enabled:=True;
   CheckBox2.Checked:=False;
   btn_track_start.enabled:=True;
   Button1.Enabled:=True;
   Button2.Enabled:=True;
   WriteSpy(lang('Calibration réussie'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Calibration réussie'));
   end;

Ini:=TMemIniFile.Create(LowerCase(ExtractFilePath(Application.ExeName))+'TeleAuto.ini'); //nolang
try
if config.CalibrateSuivi then ini.writestring('Tracking','Calibrate','Oui')
else ini.writestring('Tracking','Calibrate','Non');
finally
Ini.UpdateFile;
Ini.Free;
end;

except
Config.CameraSuiviBranchee:=False;
pop_main.UpDateGUICameraSuivi;
end;

finally
Config.CalibrationEnCours:=False;
pop_image_acq.Bloque:=False;
btnChercher.Enabled:=True;
btn_calibrer.Enabled:=True;
Button1.Enabled:=True;
if config.CalibrateSuivi then
   begin
   btn_track_start.enabled:=True;
   Button2.Enabled:=True;
   CheckBox2.Enabled:=True;
   end
else
   begin
   btn_track_start.enabled:=False;
   Button2.Enabled:=True;
   CheckBox2.Enabled:=False;
   end;
Config.EtapeCalibration:=0;
StopGetPos:=False;
end;
end;

procedure Tpop_camera_suivi.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
   Ini:TMemIniFile;
   Path:string;
begin
// Sauve la pos
Path:=ExtractFilePath(Application.Exename);
Ini:=TMemIniFile.Create(Path+'TeleAuto.ini'); //nolang
try
Ini.WriteString('WindowsPos','CCDTrackTop',IntToStr(Top));
Ini.WriteString('WindowsPos','CCDTrackLeft',IntToStr(Left));
finally
Ini.UpdateFile;
Ini.Free;
end;

if EventPoseSuivi<>nil then
   begin
   EventPoseSuivi.Free;
   EventPoseSuivi:=nil;
   end;

end;

procedure Tpop_camera_suivi.Button2Click(Sender: TObject);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   i:Integer;
   Alpha,Delta,Angle:Double;
   T:TextFile;
   Name,Str:string;

begin
//_____________________________________________________________
//!_PARAMETRES DE GUIDAGE_____________________________________!
//!                                                           !
//!  Coordonnees de calibration                               !
//!  Declinaison                        +15°12'36"            !
//!  Angle horaire                      7:15:27               !
//!  Resultats de la calibration                              !
//!  Vitesse reelle de guidage en N/S   74.76 microns / sec   !
//!  Vitesse de calibration en E/W      73.20 microns / sec   !
//!  Orientation (angle Noy )           -178° 25'             !
//!  Corrections de position                                  !
//!  Correction de declinaison          0.923                 !  Cette correction peut etre > ou < 1
//!  Inversion de l'orientation         oui                   !
//!  Correction de moderation                                 !
//!  Facteur de moderation              0.65                  !
//!   ______                                                  !
//!  ! OK    !                                                !
//!___________________________________________________________!


New(TabItems);

try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiLabel;
   UnderLine:=True;
   Msg:=lang('Coordonnées de calibration');
   end;

with TabItems^[2] do
   begin
   TypeItem:=tiEdit;
   Msg:=lang('Déclinaison :');
   ValeurStrDefaut:=DeltaToStr(Config.DeltaSuivi);
   EditWidth:=100;
   ReadOnly:=True;
   end;

with TabItems^[3] do
   begin
   TypeItem:=tiEdit;
   Msg:=lang('Angle horaire :');
   ValeurStrDefaut:=AlphaToStr(Config.AHSuivi);
   EditWidth:=100;
   ReadOnly:=True;
   end;

with TabItems^[4] do
   begin
   TypeItem:=tiLabel;
   UnderLine:=True;
   Msg:=lang('Résultats de la calibration');
   end;

with TabItems^[5] do
   begin
   TypeItem:=tiEdit;
   Msg:=lang('Vitesse réelle de guidage en N/S (microns/sec) :');
   ValeurStrDefaut:=MyFloatToStr(Config.VitesseGuidageReelleDelta,2);
   EditWidth:=100;
   ReadOnly:=True;
   end;

with TabItems^[6] do
   begin
   TypeItem:=tiEdit;
   Msg:=lang('Vitesse de calibration en E/W (microns/sec) :');
   ValeurStrDefaut:=MyFloatToStr(Config.VitesseGuidageApparenteAlpha,2);
   EditWidth:=100;
   ReadOnly:=True;
   end;

Angle:=Config.OrientationCCDGuidage;
//if CheckBox2.Checked then Angle:=Angle+180;
if Angle>180 then Angle:=Angle-360;
if Angle<=-180 then Angle:=Angle+360;
with TabItems^[7] do
   begin
   TypeItem:=tiEdit;
   Msg:=lang('Orientation (angle Noy) (degrés) :');
   ValeurStrDefaut:=MyFloatToStr(Angle,2);
   EditWidth:=100;
   ReadOnly:=True;
   end;

with TabItems^[8] do
   begin
   TypeItem:=tiLabel;
   UnderLine:=True;
   Msg:=lang('Corrections de position');
   end;

Alpha:=0;
Delta:=0;
if Telescope.StoreCoordinates then
   begin
   if Config.GoodPos then
      begin
      Alpha:=Config.AlphaScope;
      Delta:=Config.DeltaScope;
      pop_camera_suivi.NbreEdit1.Text:=MyFloatToStr(Delta,2);
      end
   else
      begin
      WriteSpy(lang('Le télescope ne veut pas donner sa position'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope ne veut pas donner sa position'));
      end;
   end
else Delta:=MyStrToFloat(pop_camera_suivi.NbreEdit1.Text);

// correction de declinaison = (cosDg/cosDc)
with TabItems^[9] do
   begin
   TypeItem:=tiEdit;
   Msg:=lang('Correction de déclinaison :');
//*Cos(Config.DeltaSuivi/180*pi)/Cos(DeltaCourant/180*pi)
   ValeurStrDefaut:=MyFloatToStr(Cos(Delta/180*pi)/Cos(Config.DeltaSuivi/180*pi),3);
   EditWidth:=100;
   ReadOnly:=True;
   end;

//!  Inversion de l'orientation         oui                   !
with TabItems^[10] do
   begin
   TypeItem:=tiEdit;
   Msg:=lang('Inversion de l''orientation :');
   if CheckBox2.Checked then ValeurStrDefaut:=lang('Oui')
   else ValeurStrDefaut:=lang('Non');
   EditWidth:=100;
   ReadOnly:=True;
   end;

with TabItems^[11] do
   begin
   TypeItem:=tiLabel;
   UnderLine:=True;
   Msg:=lang('Correction de modération');
   end;

with TabItems^[12] do
   begin
   TypeItem:=tiEdit;
   Msg:=lang('Facteur de moderation :');
   ValeurStrDefaut:=MyFloatToStr(Config.CoefLimitationNS,2);
   EditWidth:=100;
   ReadOnly:=True;
   end;

with TabItems^[13] do
   begin
   TypeItem:=tiCheckBox;
   Msg:=lang('Sauvegarder les paramètres à la sortie');
   ValeurCheckDefaut:=False;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,400);
DlgStandard.HideUndo;
DlgStandard.Caption:=lang('Paramètres de guidage');
DlgStandard.ShowModal;

if TabItems^[13].ValeurSortie<>0 then
   begin
   pop_main.SaveDialog.Filter:=lang('Fichiers Textes *.txt|*.txt');
   if pop_main.SaveDialog.Execute then
      begin
      Name:=pop_main.SaveDialog.FileName;
      if UpperCase(ExtractFileExt(Name))<>'.TXT' then Name:=Name+'.txt'; //nolang
      AssignFile(T,Name);
      Rewrite(T);
      try
      Writeln(T,lang('Coordonnées de calibration'));
      Writeln(T,lang('Déclinaison : ')+DeltaToStr(Config.DeltaSuivi));
      Writeln(T,lang('Angle horaire : ')+AlphaToStr(Config.AHSuivi));
      Writeln(T,lang('Résultats de la calibration'));
      Writeln(T,lang('Vitesse réelle de guidage en N/S (microns/sec) : ')+MyFloatToStr(Config.VitesseGuidageReelleDelta,2));
      Writeln(T,lang('Vitesse de calibration en E/W (microns/sec) : ')+MyFloatToStr(Config.VitesseGuidageApparenteAlpha,2));
      Writeln(T,lang('Orientation (angle Noy) (degrés) : ')+MyFloatToStr(Angle,2));
      Writeln(T,lang('Corrections de position'));
      Writeln(T,lang('Correction de déclinaison : ')+MyFloatToStr(Cos(Delta/180*pi)/Cos(Config.DeltaSuivi/180*pi),3));
      if CheckBox2.Checked then Str:=lang('Oui')
      else Str:=lang('Non');
      Writeln(T,'Inversion de l''orientation : '+Str);
      Writeln(T,lang('Correction de modération'));
      Writeln(T,lang('Facteur de moderation : ')+MyFloatToStr(Config.CoefLimitationNS,2));
      finally
      System.Close(T);
      end;
      end;
   end;

finally
DlgStandard.Free;
Dispose(TabItems);
end;


{   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try

   Rapport.AddLine('Vecteur Nord : ');
   Rapport.AddLine('X = '+MyFloatToStr(Config.VecteurNordX,2)+' microns');
   Rapport.AddLine('Y = '+MyFloatToStr(Config.VecteurNordY,2)+' microns');
   Rapport.AddLine('Vecteur Sud : ');
   Rapport.AddLine('X = '+MyFloatToStr(Config.VecteurSudX,2)+' microns');
   Rapport.AddLine('Y = '+MyFloatToStr(Config.VecteurSudY,2)+' microns');
   Rapport.AddLine('Vecteur Est : ');
   Rapport.AddLine('X = '+MyFloatToStr(Config.VecteurEstX,2)+' microns');
   Rapport.AddLine('Y = '+MyFloatToStr(Config.VecteurEstY,2)+' microns');
   Rapport.AddLine('Vecteur Ouest : ');
   Rapport.AddLine('X = '+MyFloatToStr(Config.VecteurOuestX,2)+' microns');
   Rapport.AddLine('Y = '+MyFloatToStr(Config.VecteurOuestY,2)+' microns');

   Rapport.AddLine(lang('La direction du Nord est à '+MyFloatToStr(Config.OrientationCCDGuidage,2)
      +lang('° du 1/2 axe des y du CCD de guidage dans le sens trigo')));
   Rapport.AddLine(lang('Vitesse apparente de guidage en N/S = '+MyFloatToStr(Config.VitesseGuidageApparenteDelta,2)
      +lang(' microns/secondes')));
   Rapport.AddLine(lang('Vitesse réelle de guidage en N/S = '+MyFloatToStr(Config.VitesseGuidageReelleDelta,2)
      +lang(' microns/secondes')));
   Rapport.AddLine(lang('Vitesse réelle de calibration en E/W = '+MyFloatToStr(Config.VitesseGuidageApparenteAlpha,2)
      +lang(' microns/secondes')));
   if Config.VitesseGuidageReelleDelta<>0 then
      begin
      Jeu:=(Config.DelaiCalibrationSuiviNS+Config.DelaiRattrapageSuiviNS)*
         (1-Config.VitesseGuidageApparenteDelta/Config.VitesseGuidageReelleDelta);
      Rapport.AddLine(lang('Jeu en N/S = ')+MyFloatToStr(Jeu,2)
         +lang(' secondes'));
      end;
   Rapport.AddLine(lang('Déclinaison de calibration = ')+DeltaToStr(Config.DeltaSuivi));

   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;
   end;}
end;

//****************************************************************************
//*******************************   scripts   ********************************
//****************************************************************************

procedure Tpop_camera_suivi.StartB1;
begin
outAcqB1Click(Self);
end;

procedure Tpop_camera_suivi.StartB2;
begin
outAcqB2Click(Self);
end;

procedure Tpop_camera_suivi.StartB3;
begin
outAcqB4Click(Self);
end;

procedure Tpop_camera_suivi.SetPose(Pose:Single);
begin
Edit5.Text:=MyFloatToStr(Pose,2);
end;

procedure Tpop_camera_suivi.StartGuide;
begin
btn_track_startClick(Self);
end;

procedure Tpop_camera_suivi.StopGuide;
begin
btn_track_stopClick(Self);
end;

function Tpop_camera_suivi.GetError:string;
begin
Result:=GuideError;
end;

procedure Tpop_camera_suivi.WaitGuide;
var
   Fin:Boolean;
begin
Fin:=False;
while not Fin do
   begin
   if EventGuide.WaitFor(0)<>wrTimeout then Fin:=True;
   Application.ProcessMessages;
   end;
end;

{procedure Tpop_camera_suivi.WaitGuide;
var
   MyWaitGuide:TMyWaitGuide;
begin
MyWaitGuide:=TMyWaitGuide.Create;
MyWaitGuide.WaitFor;
end;}

constructor TThreadPoseSuivi1.Create;
begin
inherited Create(True);
//Priority:=tpHighest;
Priority:=tpNormal;
//Priority:=tpLower;
FreeOnTerminate:=True;
Resume;
end;

procedure TThreadPoseSuivi1.AfficheInfos;
var
   NBImage:Integer;
begin
ProgressPos:=Pop_Camera_Suivi.Progress.Max-Round((Pop_Camera_Suivi.NbInterValPose-Pop_Camera_Suivi.NbInterValCourant)
   *Intervalle/1000);
PoseStr:=FloatToStrF((Pop_Camera_Suivi.NbInterValPose-Pop_Camera_Suivi.NbInterValCourant)
   *Intervalle/1000,ffFixed,4,1);

// ajuste le temp de pose restant
CameraSuivi.AdjustIntervalePose(Pop_Camera_Suivi.NbInterValCourant,NBImage,Intervalle);
if NBImage>0 then NBImageThread:=IntToStr(NBImage);

// on coupe l ampli pendant la pose et on rallume une seconde avant la pose
if ((CameraSuivi.CanCutAmpli) and (CameraSuivi.AmpliIsUsed) and (not cameraSuivi.getamplistate)) and
   (Pop_Camera_Suivi.nbintervalpose*Intervalle/1000>CameraSuivi.GetDelayToSwitchOffAmpli) and
   (Pop_Camera_Suivi.nbintervalcourant*Intervalle/1000>(Pop_Camera_Suivi.nbintervalpose*Intervalle/1000)-
    CameraSuivi.GetDelayToSwitchOnAmpli) then
   begin
   CameraSuivi.AmpliOn;
   CameraSuivi.SetAmpliStateTrue;
   PoseStr:=lang('Ampli on');
   end;

pop_Camera_Suivi.Edit6.Text:=NBImageThread;
pop_Camera_Suivi.Progress.Position:=ProgressPos;
pop_Camera_Suivi.Panel1.Caption:=PoseStr;
end;

procedure TThreadPoseSuivi1.Execute;
begin
Fin:=False;
try
repeat
//if not(((Pop_Camera.NbInterValCourant>=Pop_Camera.NbInterValPose) and Camera.CanStopNow) or Pop_Camera.StopPose) then
if Pop_Camera_Suivi.NbInterValCourant<Pop_Camera_Suivi.NbInterValPose then
   begin
//   if WaitForSingleObject(Pop_Camera.EventPose, 100) = WAIT_TIMEOUT then
   if EventPoseSuivi.WaitFor(Intervalle)=wrTimeout then
      begin
      Inc(Pop_Camera_Suivi.NbInterValCourant);
      // Mega Important, ne pas enlever
      Application.ProcessMessages;
      Synchronize(AfficheInfos);
      end;
   end
else
   begin
   if not Fin then
      begin
      Pop_Camera_Suivi.TimerInter1.Enabled:=True;
      Application.ProcessMessages;
      Fin:=True;
      end;
   end;
//if Fin then WaitForSingleObject(Pop_Camera.EventPose,1000);
if Fin then EventPoseSuivi.WaitFor(Intervalle);
Application.ProcessMessages;
until Terminated;
except
end;
end;

constructor TThreadPoseSuivi2.Create;
begin
inherited Create(True);
//Priority:=tpHighest;
Priority:=tpNormal;
//Priority:=tpLower;
FreeOnTerminate:=True;
Resume;
end;

procedure TThreadPoseSuivi2.AfficheInfos;
var
   NBImage:Integer;
begin
ProgressPos:=Pop_Camera_Suivi.Progress.Max-Round((Pop_Camera_Suivi.NbInterValPose-Pop_Camera_Suivi.NbInterValCourant)
   *Intervalle/1000);
PoseStr:=FloatToStrF((Pop_Camera_Suivi.NbInterValPose-Pop_Camera_Suivi.NbInterValCourant)
   *Intervalle/1000,ffFixed,4,1);

// ajuste le temp de pose restant
CameraSuivi.AdjustIntervalePose(Pop_Camera_Suivi.NbInterValCourant,NBImage,Intervalle);
if NBImage>0 then NBImageThread:=IntToStr(NBImage);

// on coupe l ampli pendant la pose et on rallume une seconde avant la pose
if ((CameraSuivi.CanCutAmpli) and (CameraSuivi.AmpliIsUsed) and (not cameraSuivi.getamplistate)) and
   (Pop_Camera_Suivi.nbintervalpose*Intervalle/1000>CameraSuivi.GetDelayToSwitchOffAmpli) and
   (Pop_Camera_Suivi.nbintervalcourant*Intervalle/1000>(Pop_Camera_Suivi.nbintervalpose*Intervalle/1000)-
    CameraSuivi.GetDelayToSwitchOnAmpli) then
   begin
   CameraSuivi.AmpliOn;
   CameraSuivi.SetAmpliStateTrue;
   PoseStr:=lang('Ampli on');
   end;

pop_Camera_Suivi.Edit6.Text:=NBImageThread;
pop_Camera_Suivi.Progress.Position:=ProgressPos;
pop_Camera_Suivi.Panel1.Caption:=PoseStr;
end;

procedure TThreadPoseSuivi2.Execute;
begin
Fin:=False;
try
repeat
//if not(((Pop_Camera.NbInterValCourant>=Pop_Camera.NbInterValPose) and Camera.CanStopNow) or Pop_Camera.StopPose) then
if Pop_Camera_Suivi.NbInterValCourant<Pop_Camera_Suivi.NbInterValPose then
   begin
//   if WaitForSingleObject(Pop_Camera.EventPose, Intervalle) = WAIT_TIMEOUT then
   if EventPoseSuivi.WaitFor(Intervalle)=wrTimeout then
      begin
      Inc(Pop_Camera_Suivi.NbInterValCourant);
      // Mega Important, ne pas enlever
      Application.ProcessMessages;
      Synchronize(AfficheInfos);
      end;
   end
else
   begin
   if not Fin then
      begin
      Pop_Camera_Suivi.TimerInter2.Enabled:=True;
      Application.ProcessMessages;
      Fin:=True;
      end;
   end;
//if Fin then WaitForSingleObject(Pop_Camera.EventPose,1000);
if Fin then EventPoseSuivi.WaitFor(Intervalle);
Application.ProcessMessages;
until Terminated;
except
end;
end;

constructor TThreadPoseSuivi4.Create;
begin
inherited Create(True);
//Priority:=tpHighest;
Priority:=tpNormal;
//Priority:=tpLower;
FreeOnTerminate:=True;
Resume;
end;

procedure TThreadPoseSuivi4.AfficheInfos;
var
   NBImage:Integer;
begin
ProgressPos:=Pop_Camera_Suivi.Progress.Max-Round((Pop_Camera_Suivi.NbInterValPose-Pop_Camera_Suivi.NbInterValCourant)
   *Intervalle/1000);
PoseStr:=FloatToStrF((Pop_Camera_Suivi.NbInterValPose-Pop_Camera_Suivi.NbInterValCourant)
   *Intervalle/1000,ffFixed,4,1);

// ajuste le temp de pose restant
CameraSuivi.AdjustIntervalePose(Pop_Camera_Suivi.NbInterValCourant,NBImage,Intervalle);
if NBImage>0 then NBImageThread:=IntToStr(NBImage);

// on coupe l ampli pendant la pose et on rallume une seconde avant la pose
if ((CameraSuivi.CanCutAmpli) and (CameraSuivi.AmpliIsUsed) and (not cameraSuivi.getamplistate)) and
   (Pop_Camera_Suivi.nbintervalpose*Intervalle/1000>CameraSuivi.GetDelayToSwitchOffAmpli) and
   (Pop_Camera_Suivi.nbintervalcourant*Intervalle/1000>(Pop_Camera_Suivi.nbintervalpose*Intervalle/1000)-
    CameraSuivi.GetDelayToSwitchOnAmpli) then
   begin
   CameraSuivi.AmpliOn;
   CameraSuivi.SetAmpliStateTrue;
   PoseStr:=lang('Ampli on');
   end;

pop_Camera_Suivi.Edit6.Text:=NBImageThread;
pop_Camera_Suivi.Progress.Position:=ProgressPos;
pop_Camera_Suivi.Panel1.Caption:=PoseStr;
end;

procedure TThreadPoseSuivi4.Execute;
begin
Fin:=False;
try
repeat
//if not(((Pop_Camera.NbInterValCourant>=Pop_Camera.NbInterValPose) and Camera.CanStopNow) or Pop_Camera.StopPose) then
if Pop_Camera_Suivi.NbInterValCourant<Pop_Camera_Suivi.NbInterValPose then
   begin
//   if WaitForSingleObject(Pop_Camera.EventPose, Intervalle) = WAIT_TIMEOUT then
   if EventPoseSuivi.WaitFor(Intervalle)=wrTimeout then
      begin
      Inc(Pop_Camera_Suivi.NbInterValCourant);
      // Mega Important, ne pas enlever
      Application.ProcessMessages;
      Synchronize(AfficheInfos);
      end;
   end
else
   begin
   if not Fin then
      begin
      Pop_Camera_Suivi.TimerInter4.Enabled:=True;
      Application.ProcessMessages;
      Fin:=True;
      end;
   end;
//if Fin then WaitForSingleObject(Pop_Camera.EventPose,1000);
if Fin then EventPoseSuivi.WaitFor(Intervalle);
Application.ProcessMessages;
until Terminated;
except
end;
end;

end.




