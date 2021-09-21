unit pu_camera;

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
  pu_image, Editnbre, SyncObjs;

const
  Intervalle=100;

type
{  TMyWaitEndAcq=class(TThread)
  private
  protected
   procedure Execute; override;
  public
   constructor Create;
  end;}

  TThreadPose = class(TThread)
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

  TThreadPoseAuto = class(TThread)
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

  TThreadPose1 = class(TThread)
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

  TThreadPose2 = class(TThread)
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

  TThreadPose4= class(TThread)
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

  TThreadReadAuto = class(TThread)
    private
    protected
     NbImage:Integer;
     procedure BeforeLecture;
     procedure AfterLecture;
     procedure Execute; override;
    public
     constructor Create;
    end;

  Tpop_camera = class(TForm)
    pages_ccd: TPageControl;
    Acq: TTabSheet;
    GroupBox14: TGroupBox;
    outLabel32: TLabel;
    outLabel35: TLabel;
    outLabel36: TLabel;
    outLabel37: TLabel;
    win_x1: TEdit;
    win_x2: TEdit;
    win_y1: TEdit;
    win_y2: TEdit;
    RadioGroup1: TRadioGroup;
    GroupBox5: TGroupBox;
    Label8: TLabel;
    outLabel9: TLabel;
    exp_b1: TEdit;
    SpinButton2: TSpinButton;
    outAcqB1: TButton;
    GroupBox6: TGroupBox;
    Label18: TLabel;
    outLabel20: TLabel;
    outAcqB2: TButton;
    exp_b2: TEdit;
    SpinButton3: TSpinButton;
    GroupBox7: TGroupBox;
    Label19: TLabel;
    outLabel21: TLabel;
    outAcqB4: TButton;
    exp_b4: TEdit;
    SpinButton4: TSpinButton;
    GroupBox8: TGroupBox;
    Label16: TLabel;
    Label13: TLabel;
    cb_bouclage: TCheckBox;
    nb_bouclage: TSpinEdit;
    cb_autosave: TCheckBox;
    index: TSpinEdit;
    img_name: TEdit;
    PageFiltres: TTabSheet;
    GroupBox13: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    progress: TProgressBar;
    memo_stats: TMemo;
    Panel6: TPanel;
    Label1: TLabel;
    Stop1: TButton;
    Stop2: TButton;
    Stop4: TButton;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    Edit6: TEdit;
    Label10: TLabel;
    Label25: TLabel;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    CheckBox1: TCheckBox;
    TimerInter4: TTimer;
    TimerInter1: TTimer;
    TimerInter2: TTimer;
    TimerTemp: TTimer;
    TimerInter: TTimer;
    TabSheet1: TTabSheet;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    NbreEdit1: NbreEdit;
    Label6: TLabel;
    Label7: TLabel;
    SpinEdit1: TSpinEdit;
    Label9: TLabel;
    SpinEdit2: TSpinEdit;
    Label11: TLabel;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    CheckBox2: TCheckBox;
    TabSheet2: TTabSheet;
    RadioGroup12: TRadioGroup;
    Panel3: TPanel;
    Label169: TLabel;
    Label170: TLabel;
    NbreEdit24: NbreEdit;
    NbreEdit25: NbreEdit;
    SpeedButton2: TSpeedButton;
    // temperature
    procedure TimerTempTimer(Sender: TObject);
    procedure outAcqB1Click(Sender: TObject);
    procedure outAcqB2Click(Sender: TObject);
    procedure outAcqB4Click(Sender: TObject);
    procedure SpinButton2DownClick(Sender: TObject);
    procedure SpinButton2UpClick(Sender: TObject);
    procedure img_nameChange(Sender: TObject);
    procedure SpinButton3DownClick(Sender: TObject);
    procedure SpinButton4DownClick(Sender: TObject);
    procedure SpinButton3UpClick(Sender: TObject);
    procedure SpinButton4UpClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure btn_closeClick(Sender: TObject);
    // filtres
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure update_stats(x,y:integer; min,mediane,max,moy,ecart:double);
    procedure FormShow(Sender: TObject);
    procedure Stop1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure TimerInter4Timer(Sender: TObject);
    procedure TimerInter2Timer(Sender: TObject);
    procedure TimerInter1Timer(Sender: TObject);
    procedure TimerInterTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox2Click(Sender: TObject);
    procedure RadioGroup12Click(Sender: TObject);
    procedure NbreEdit24Change(Sender: TObject);
    procedure NbreEdit25Change(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    // Track
    MemPicTrack,MemPicTrackNoir,VignetteNoir:PTabImgInt;
    sxTrack,SyTrack:Integer;
    TpsIntTrack:Integer;
    XCcdTrack1,YCcdTrack1,XCcdTrack2,YCcdTrack2:Integer;

    BinningX,BinningY,WinX1,WinY1,WinX2,WinY2:Integer;
    PoseEnCours,PoseTrackEnCours:Boolean;
    PoseR:Double;
    NomPic:String;
    isNoir:Boolean;
//    ObturateurOuvert:Boolean; // non utilise
    XTrack,YTrack,XTrackXMoins,YTrackXMoins,XTrackXPlus,YTrackXPlus:Single;
    XTrackYMoins,YTrackYMoins,XTrackYPlus,YTrackYPlus:Single;
    StopMap,StopSuivi:Boolean;
    NbInterValCourant,NbInterValPose:Integer;
//    NbInterValCourantTrack,NbInterValPoseTrack:Integer;
    Binning:Integer;
    XCcd1,YCcd1,XCcd2,YCcd2:Integer;
    TpsInt:Integer;
    pop_image_acq:tpop_image;
    Nombre:Integer;
    TimeInit,TimeCourant,TimeFin:TDateTime;
    TempsRestant:Double;
    FinPose:Boolean;
    PoseCamera:Double;
    ShutterClosedCamera:Boolean;
    YearBegin,MonthBegin,DayBegin:Word;
    HourBegin,MinBegin,SecBegin,MSecBegin:Word;
    YearEnd,MonthEnd,DayEnd:Word;
    HourEnd,MinEnd,SecEnd,MSecEnd:Word;
    TimeBegin,TimeEnd:TDateTime;
    CountBoucle:Integer;
    StopPose:Boolean;
    x1,y1,x2,y2:Integer;

    x1Glob,y1Glob,x2Glob,y2Glob:Integer;
    PoseGlob:Double;
    BinGlob:Integer;
    ShutterClosedGlob:Boolean;

    DataInt:PTabImgInt;
    Somme,SommeSave:Double;
    NbDetecte,NbImages:Integer;
    Fin:Boolean;
    PoseMini:Double;
    AlphaAcq,DeltaAcq:Double;

//    function AcqNonSatur(var x,y:Integer):Boolean;
    function AcqMaximum(var x,y:Integer):Boolean;
    function AcqMaximumBinning(var x,y:Integer):Boolean;
{    function StartAcquisition(x1,y1,x2,y2:Integer;
                              Pose:Double;
                              Bin:Integer;
                              ShutterClosed:Boolean):Boolean;
    procedure WaitUntilEndOfPose;}
    function Acquisition(x1,y1,x2,y2:Integer;
                         Pose:Double;
                         Bin:Integer;
                         ShutterClosed:Boolean):Boolean;
    function AcquisitionAuto(x1,y1,x2,y2:Integer;
                             Pose:Double;
                             Bin:Integer;
                             ShutterClosed:Boolean):Boolean;
    procedure UpDateForCCDChange;

    // Scripts
    procedure StartB1;
    procedure StartB2;
    procedure StartB3;
    procedure SetPoseB1(Pose:Single);
    procedure SetPoseB2(Pose:Single);
    procedure SetPoseB3(Pose:Single);
    procedure SetLoopNb(Nb:Integer);
    procedure SetStartIndex(Nb:Integer);
    procedure SetImgName(Name:string);
    procedure SetLoopOn;
    procedure SetLoopOff;
    procedure SetAutoSaveOn;
    procedure SetAutoSaveOff;
    procedure SetImgType(ImgType:Integer);
    procedure WaitEndAcq;
    procedure WaitEndPose;
    procedure SetWindow(x1,y1,x2,y2:Integer);
    procedure InitWindow;
    procedure SetStatOn;
    procedure SetStatOff;
    function SetFilter(FilterNb:Integer):Boolean;
    procedure StartWatch;
    procedure SetWatchWait(Wait:Single);
    procedure SetWatchImgNb(Nb:Integer);
    procedure SetWatchStart(Percent:Integer);    
    procedure GetImg(var Img:Tpop_Image);
  end;

var
  pop_camera:Tpop_camera;
  StopGetPos:Boolean;
//  EventEndPose:THandle;
  EventEndAcq,EventPose,EventEndPose:TEvent;
//  EventPose,EventEndPose:THandle;
//  EventEndAcq,
  ThreadPose:TThreadPose;
  ThreadPoseAuto:TThreadPoseAuto;
  ThreadReadAuto:TThreadReadAuto;  
  ThreadPose1:TThreadPose1;
  ThreadPose2:TThreadPose2;
  ThreadPose4:TThreadPose4;

implementation

uses u_file_io,
     u_constants,
     u_math,
     u_driver_st7,
     u_driver_st7_nt,
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
     pu_camera_suivi,
     u_hour_servers,
     pu_track;

{$R *.DFM}

{constructor TMyWaitEndAcq.Create;
begin
inherited Create(True);
Priority:=tpNormal;
FreeOnTerminate:=True;
Resume;
end;

procedure TMyWaitEndAcq.Execute;
begin
EventEndAcq.WaitFor(INFINITE);
EventEndAcq.ResetEvent;
end;}

procedure ccd_makeimage(exp:double;bin,x1,y1,x2,y2,shutterstate:integer;
   imagename:string);
var
   TimeCourant,TimeInit:TDateTime;
   i,j,k,sx,sy,typedata,nbplans,PosEsp:Integer;
   InterI:SmallInt;
   resultat:boolean;
   ax,bx,ay,by:double;
   DataInt:PTabImgInt;         // TypeData=2
   DataDouble:PTabImgDouble;
   ImgInfos:TImgInfos;         // Autres infos

   YearBegin,MonthBegin,DayBegin:Word;
   HourBegin,MinBegin,SecBegin,MSecBegin:Word;
   YearEnd,MonthEnd,DayEnd:Word;
   HourEnd,MinEnd,SecEnd,MSecEnd:Word;
   TimeBegin,TimeEnd:TDateTime;
   Line:string;
begin
         if x1>Camera.GetXSize div bin then x1:=Camera.GetXSize div bin;
         if x2>Camera.GetXSize div bin then x2:=Camera.GetXSize div bin;
         if y1>Camera.GetYSize div bin then y1:=Camera.GetYSize div bin;
         if y2>Camera.GetYSize div bin then y2:=Camera.GetYSize div bin;
         if x1<1 then x1:=1;
         if x2<1 then x2:=1;
         if y1<1 then y1:=1;
         if y2<1 then y2:=1;
         // y=ax+b
         ax:=(Camera.GetXSize-1)/((Camera.GetXSize div bin)-1);
         bx:=1-ax;
         ay:=(Camera.GetYSize-1)/((Camera.GetYSize div bin)-1);
         by:=1-ay;
         // init
         // Si la camera a un CAN 16 bits, on stocke dans des reels
         TypeData:=Camera.GetTypeData;
         NbPlans:=Camera.GetNbPlans;
         if exp<Camera.GetMinimalPose then exp:=Camera.GetMinimalPose;
         // taille image
         Sx:=(x2-x1+1);
         Sy:=(y2-y1+1);
         // miroir
         if Config.MirrorX then
            begin
            x1:=Camera.GetXSize div bin-x1+1;
            x2:=Camera.GetXSize div bin-x2+1;
            end;
         if Config.MirrorY then
            begin
            y1:=Camera.GetYSize div bin-y1+1;
            y2:=Camera.GetYSize div bin-y2+1;
            end;
         // memoire
         Getmem(DataInt,4*NbPlans);
         for k:=1 to Nbplans do
         begin
              Getmem(DataInt^[k],4*Sy);
              for i:=1 to Sy do Getmem(DataInt^[k]^[i],Sx*2);
         end;
         // set camera

         Camera.SetWindow(Round(ax*x1+bx),Round(ay*y1+by),Round(ax*x2+bx),Round(ay*y2+by));
         WriteSpy(Camera.GetName+lang(' Fenêtre : (')+IntToStr(Round(ax*x1+bx))+','+IntToStr(Round(ay*y1+by))+
            ')/('+IntToStr(Round(ax*x2+bx))+','+IntToStr(Round(ay*y2+by))+')'); //nolang
         camera.SetBinning(bin);
         WriteSpy(Camera.GetName+lang(' Binning : ')+IntToStr(Bin));
         Camera.SetPose(exp);
         WriteSpy(Camera.GetName+lang(' Temps de pose : ')+MyFloatToStr(exp,3)
            +lang(' s'));
         if (ShutterState=1) and Camera.HasAShutter then
            Camera.SetShutterClosed;
         // go
         WriteSpy(lang('Début de la pose sur la caméra principale'));
         if Assigned(pop_track) then pop_track.AddMessage(lang('Début de la pose sur la caméra principale'));
         Resultat:=Camera.StartPose;
         EventEndPose.ResetEvent;

         if Config.TelescopeBranche then
            if Config.GoodPos then
               begin
               pop_camera.AlphaAcq:=Config.AlphaScope;
               pop_camera.DeltaAcq:=Config.DeltaScope;
               end
            else
               begin
               WriteSpy(lang('Le télescope ne veut pas donner sa position'));
               pop_Main.AfficheMessage(lang('Erreur'),
                  lang('Le télescope ne veut pas donner sa position'));
               end;

         if Resultat then
         begin
              if ((Camera.CanCutAmpli) and (Camera.AmpliIsUsed) and (not
                 camera.getamplistate)) and
                 (exp > Camera.GetDelayToSwitchOffAmpli) then
                 begin
                      MySleep(round(exp-(Camera.GetDelayToSwitchOnAmpli/1000)));
                      Camera.AmpliOn;
                      camera.setamplistatetrue;
                      MySleep(round(camera.GetDelayToSwitchOnAmpli/1000));
                 end
                 else
                 begin
                      MySleep(round(exp));
                 end;
         end;
         pop_camera.Stop1.Enabled:=False;
         pop_camera.Stop2.Enabled:=False;
         pop_camera.Stop4.Enabled:=False;
         pop_camera.outAcqB1.Enabled:=False;
         pop_camera.outAcqB2.Enabled:=False;
         pop_camera.outAcqB4.Enabled:=False;
         try
         try
         EventEndPose.SetEvent;
         Camera.ReadCCD(DataInt,sx,sy);
         if Camera.Is16Bits then
            begin
            ImgInfos.BZero:=32768;
            ConvertFITSIntToReal(DataInt,DataDouble,ImgInfos);
            end;
         except
         Config.CameraBranchee:=False;
         end;
         finally
         pop_camera.Stop1.Enabled:=True;
         pop_camera.Stop2.Enabled:=True;
         pop_camera.Stop4.Enabled:=True;
         pop_camera.outAcqB1.Enabled:=True;
         pop_camera.outAcqB2.Enabled:=True;
         pop_camera.outAcqB4.Enabled:=True;
         end;

         Camera.GetCCDDateBegin(YearBegin,MonthBegin,DayBegin);
         Camera.GetCCDTimeBegin(HourBegin,MinBegin,SecBegin,MSecBegin);
         Camera.GetCCDDateEnd(YearEnd,MonthEnd,DayEnd);
         Camera.GetCCDTimeEnd(HourEnd,MinEnd,SecEnd,MSecEnd);
         try
         TimeBegin:=EncodeDate(YearBegin,MonthBegin,DayBegin)+EncodeTime(HourBegin,MinBegin,SecBegin,MSecBegin);
         TimeEnd:=EncodeDate(YearEnd,MonthEnd,DayEnd)+EncodeTime(HourEnd,MinEnd,SecEnd,MSecEnd);
         except
         if Config.Verbose then
            begin
            WriteSpy(lang('Begin Annee = ')+IntToSTr(YearBegin)); //nolang
            WriteSpy(lang('Begin Mois = ')+IntToSTr(MonthBegin)); //nolang
            WriteSpy(lang('Begin Jours = ')+IntToSTr(DayBegin)); //nolang
            WriteSpy(lang('Begin Heure = ')+IntToSTr(HourBegin)); //nolang
            WriteSpy(lang('Begin Minutes = ')+IntToSTr(MinBegin)); //nolang
            WriteSpy(lang('Begin Secondes = ')+IntToSTr(SecBegin)); //nolang
            WriteSpy(lang('Begin MilliSecondes = ')+IntToSTr(MSecBegin)); //nolang

            WriteSpy(lang('End Annee = ')+IntToSTr(YearEnd)); //nolang
            WriteSpy(lang('End Mois = ')+IntToSTr(MonthEnd)); //nolang
            WriteSpy(lang('End Jours = ')+IntToSTr(DayEnd)); //nolang
            WriteSpy(lang('End Heure = ')+IntToSTr(HourEnd)); //nolang
            WriteSpy(lang('End Minutes = ')+IntToSTr(MinEnd)); //nolang
            WriteSpy(lang('End Secondes = ')+IntToSTr(SecEnd)); //nolang
            WriteSpy(lang('End MilliSecondes = ')+IntToSTr(MSecEnd)); //nolang
            end;
         end;

         // miroirs
         if config.MirrorX then
            if Camera.Is16Bits then
               MiroirHorizontal(DataInt,DataDouble,5,NBPlans,Sx,Sy)
            else
               MiroirHorizontal(DataInt,DataDouble,2,NBPlans,Sx,Sy);
         if config.MirrorY then
            if Camera.Is16Bits then
               MiroirVertical(DataInt,DataDouble,5,NBPlans,Sx,Sy)
            else
               MiroirVertical(DataInt,DataDouble,2,NBPlans,Sx,Sy);

{         for k:=1 to Nbplans do
            for j:=1 to Sy do
               for i:=1 to Sx div 2 do
                  begin
                  InterI:=DataInt^[k]^[j]^[i];
                  DataInt^[k]^[j]^[i]:=DataInt^[k]^[j]^[Sx-i+1];
                  DataInt^[k]^[j]^[Sx-i+1]:=InterI;
                  end;
         if config.MirrorY then
         for k:=1 to Nbplans do
            for j:=1 to Sx do
               for i:=1 to Sy div 2 do
                  begin
                  InterI:=DataInt^[k]^[i]^[j];
                  DataInt^[k]^[i]^[j]:=DataInt^[k]^[Sy-i+1]^[j];
                  DataInt^[k]^[Sy-i+1]^[j]:=InterI;
                  end;}
         // Imginfos
         InitImgInfos(ImgInfos);
         ImgInfos.TempsPose:=Round((TimeEnd-TimeBegin)*24*3600*1000);
         ImgInfos.DateTime:=TimeBegin+(TimeEnd-TimeBegin)/2;
//         ImgInfos.TempsPose:=Round(exp); // Conversion s -> ms
//         ImgInfos.DateTime:=TimeInit+(exp*1000)/24/3600/2;
         ImgInfos.BinningX:=bin;
         ImgInfos.BinningY:=bin;
         ImgInfos.MiroirX:=config.MirrorX;
         ImgInfos.MiroirY:=config.MirrorY;
         ImgInfos.Telescope:=config.Telescope;
         ImgInfos.Observateur:=config.Observateur;
         ImgInfos.Camera:=Camera.GetName;
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
         ImgInfos.OrientationCCD:=config.OrientationCCD;
         ImgInfos.Seeing:=Config.Seeing;
         if Config.SuiviEnCours and (pop_track<>nil) then
            begin
            Line:=pop_track.Panel17.Caption;
            PosEsp:=Pos(' ',Line);
            Line:=Copy(Line,1,PosEsp-1);
            ImgInfos.RMSGuideError:=MyStrToFloat(Line);
            end;
         ImgInfos.TemperatureCCD:=999;
         ImgInfos.BScale:=1;
         ImgInfos.BZero:=0;
         ImgInfos.PixX:=Camera.GetXPixelSize;
         ImgInfos.PixY:=Camera.GetYPixelSize;
         ImgInfos.X1:=x1;
         ImgInfos.Y1:=y1;
         ImgInfos.X2:=x2;
         ImgInfos.Y2:=y2;

         ImgInfos.Alpha:=pop_camera.AlphaAcq;
         ImgInfos.Delta:=pop_camera.DeltaAcq;

         // save
         saveimagegenerique(imagename,dataint,DataDouble,ImgInfos);
         // kill
         for k:=1 to Nbplans do
         begin
              for i:=1 to Sy do Freemem(DataInt^[k]^[i],Sx*2);
              Freemem(DataInt^[k],4*Sy);
         end;
         Freemem(DataInt,4*Nbplans);
end;

// lecture cameras
// N'est plus utilisé
procedure Tpop_camera.SpinButton3DownClick(Sender: TObject);
var
Pose1,Pose2:Single;
begin
Pose1:=MyStrToFloat(exp_b2.Text);
Pose2:=DecrementePose(Pose1);
if Config.SuiviEnCours then
   if Pose2<PoseMini then Pose2:=PoseMini;
if Pose1<>Pose2 then exp_b2.Text:=MyFloatToStr(Pose2,3);
end;

procedure Tpop_camera.SpinButton4DownClick(Sender: TObject);
var
Pose1,Pose2:Single;
begin
Pose1:=MyStrToFloat(exp_b4.Text);
Pose2:=DecrementePose(Pose1);
if Config.SuiviEnCours then
   if Pose2<PoseMini then Pose2:=PoseMini;
if Pose1<>Pose2 then exp_b4.Text:=MyFloatToStr(Pose2,3);
end;

procedure Tpop_camera.SpinButton3UpClick(Sender: TObject);
var
Pose1,Pose2:Single;
begin
Pose1:=MyStrToFloat(exp_b2.Text);
Pose2:=IncrementePose(Pose1);
if Pose2=0 then Pose2:=0.001;
if Pose1<>Pose2 then exp_b2.Text:=MyFloatToStr(Pose2,3);
end;

procedure Tpop_camera.SpinButton4UpClick(Sender: TObject);
var
Pose1,Pose2:Single;
begin
Pose1:=MyStrToFloat(exp_b4.Text);
Pose2:=IncrementePose(Pose1);
if Pose2=0 then Pose2:=0.001;
if Pose1<>Pose2 then exp_b4.Text:=MyFloatToStr(Pose2,3);
end;

procedure Tpop_camera.SpinButton2DownClick(Sender: TObject);
var
Pose1,Pose2:Single;
begin
Pose1:=MyStrToFloat(exp_b1.Text);
Pose2:=DecrementePose(Pose1);
if Config.SuiviEnCours then
   if Pose2<PoseMini then Pose2:=PoseMini;
if Pose1<>Pose2 then exp_b1.Text:=MyFloatToStr(Pose2,3);
end;

procedure Tpop_camera.SpinButton2UpClick(Sender: TObject);
var
Pose1,Pose2:Single;
begin
Pose1:=MyStrToFloat(exp_b1.Text);
Pose2:=IncrementePose(Pose1);
if Pose2=0 then Pose2:=0.001;
if Pose1<>Pose2 then exp_b1.Text:=MyFloatToStr(Pose2,3);
end;

procedure Tpop_camera.img_nameChange(Sender: TObject);
var rep,ext : string;
    i : integer;
begin
case RadioGroup1.ItemIndex of
   0:Rep:=config.RepImagesAcq;
   1:Rep:=config.RepOffsets;
   2:Rep:=config.RepNoirs;
   3:Rep:=config.RepPlus;
end;
case config.FormatSaveInt of
   0:ext:='.fit';   //nolang
   1,5:ext:='.cpa'; //nolang
   2:ext:='.pic';   //nolang
   3:ext:='.bmp';   //nolang
   4:ext:='.jpg';   //nolang
end;
// Non ca faout la merde dans les scripts
//FindHighIndex(Rep+'\'+img_name.Text,ext,i);
//index.Value:=i+1;
end;

// Choses a faire quand on change la caméra
procedure Tpop_camera.UpDateForCCDChange;
var
   Temperature:Double;
begin
   Panel6.Caption:=lang('Inconnue');  // Toujours par defaut
   config.InTimerTrack:=False;

   try
   if not Config.InPopConf then
      if Camera.HasTemperature then
         begin
         Temperature:=Camera.GetTemperature;
         panel6.Caption:=FloatToStr(Round(Temperature*10)/10);
         TimerTemp.Enabled:=True;
         end;

   // change la dimension de la fenetre quand on passe en ST8
   if Camera.IsAValidBinning(4) then GroupBox7.Caption:='Binning 4x4' //nolang
   else if Camera.IsAValidBinning(3) then GroupBox7.Caption:='Binning 3x3'; //nolang
//   if strtoint(win_x2.text)>camera.getXsize then win_x2.text:=inttostr(camera.getXsize);
//   if strtoint(win_y2.text)>camera.getYsize then win_y2.text:=inttostr(camera.getYsize);
   win_x2.text:=inttostr(camera.getXsize);
   win_y2.text:=inttostr(camera.getYsize);

   Update;

   except
   Config.CameraBranchee:=False;
   pop_main.UpdateGUICamera;
   end;

end;

procedure Tpop_camera.outAcqB2Click(Sender: TObject);
var
Ecart:double;
i,j,k:integer;
Alpha,Delta:Double;
Rep:string;
Resultat:Boolean;
ax,bx,ay,by:Double;
begin
   EventEndAcq.ResetEvent;
//   ResetEvent(EventEndAcq);
   pop_scope.CheckBox3.Enabled:=False;
   pop_scope.Label8.Enabled:=False;

   StopPose:=False;

   Stop1.Visible:=True;
   outAcqB1.Visible:=False;
   Stop2.Visible:=True;
   outAcqB2.Visible:=False;
   Stop4.Visible:=True;
   outAcqB4.Visible:=False;
   
   // On attends un bon guidage
   // On le met a false et c'est au guidage de le remetre a true
   if Config.SuiviEnCours then
      begin
      Panel1.Caption:=lang('Attente');
      WriteSpy(lang('Attente d''un bon guidage'));
      if Assigned(pop_track) then pop_track.AddMessage(lang('Attente d''un bon guidage'));
      TrackGood:=False;
      while not(TrackGood) and Config.SuiviEnCours do
         begin
         Application.ProcessMessages;
         if StopPose then
            begin
            pop_scope.CheckBox3.Enabled:=True;
            pop_scope.Label8.Enabled:=True;
            Exit;
            end;
         pop_scope.CheckBox3.Enabled:=True;
         pop_scope.Label8.Enabled:=True;
         end;
      if Config.SuiviEnCours then WriteSpy(lang('Le guidage est bon maintenant'));
      if Assigned(pop_track) then
         begin
         pop_track.AddMarque(HeureToJourJulien(GetHourDT),config.XMesure,config.YMesure);
         pop_track.RAZErreur;
         end;
      end;

   try
   CountBoucle:=1;
   x1:=StrToInt(win_x1.Text);
   x2:=StrToInt(win_x2.Text);
   y1:=StrToInt(win_y1.Text);
   y2:=StrToInt(win_y2.Text);
   if x1>Camera.GetXSize div 2 then x1:=Camera.GetXSize div 2;
   if x2>Camera.GetXSize div 2 then x2:=Camera.GetXSize div 2;
   if y1>Camera.GetYSize div 2 then y1:=Camera.GetYSize div 2;
   if y2>Camera.GetYSize div 2 then y2:=Camera.GetYSize div 2;
   if x1<1 then x1:=1;
   if x2<1 then x2:=1;
   if y1<1 then y1:=1;
   if y2<1 then y2:=1;

   // y=ax+b
   ax:=(Camera.GetXSize-1)/((Camera.GetXSize div 2)-1);
   bx:=1-ax;
   ay:=(Camera.GetYSize-1)/((Camera.GetYSize div 2)-1);
   by:=1-ay;

   if cb_bouclage.Checked then Nombre:=nb_bouclage.Value else Nombre:=1;
   i:=1;

   // si l'image n'existe pas, on la cree
   if pop_image_acq=nil then
      begin
      pop_image_acq:=tpop_image.Create(Application);
      pop_image_acq.IsUsedForAcq:=True;
      pop_image_acq.ImgInfos.BZero:=0;
      pop_image_acq.ImgInfos.BScale:=1;
      end;

   Progress.Min:=0;
   Progress.Max:=round(MyStrToFloat(exp_b2.text));
   Progress.Position:=0;

   // Si un guidage est en cours on attends on bon guidage
//   if Config.SuiviEnCours then
//      repeat
//      until (pop_camera_suivi.ErreurX<0.5) and (pop_camera_suivi.ErreurY<0.5);

   pop_image_acq.AcqRunning:=True;
   if (RadioGroup1.ItemIndex=1) or (RadioGroup1.ItemIndex=2) then
      ShutterClosedCamera:=True else ShutterClosedCamera:=False;

   PoseEnCours:=True;

   if Camera.Is16Bits and (pop_image_acq<>nil) and (pop_image_acq.DataDouble<>nil) then
      begin
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
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
   pop_image_acq.ImgInfos.TypeData:=Camera.GetTypeData;
   pop_image_acq.ImgInfos.Nbplans:=Camera.GetNbPlans;

   PoseCamera:=MyStrToFloat(exp_b2.Text);
   if PoseCamera<Camera.GetMinimalPose then begin
      PoseCamera:=Camera.GetMinimalPose;
      exp_b2.Text:=floattostr(PoseCamera);
   end;
   TpsInt:=Round(PoseCamera*1000);

   pop_image_acq.ImgInfos.Sx:=(x2-x1+1);
   pop_image_acq.ImgInfos.Sy:=(y2-y1+1);

   if Config.MirrorX then
      begin
      x1:=Camera.GetXSize div 2-x1+1;
      x2:=Camera.GetXSize div 2-x2+1;
      end;
   if Config.MirrorY then
      begin
      y1:=Camera.GetYSize div 2-y1+1;
      y2:=Camera.GetYSize div 2-y2+1;
      end;

   Getmem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
   for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
     Getmem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
     for i:=1 to pop_image_acq.ImgInfos.Sy do Getmem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
   end;
   NbInterValCourant:=0;
   NbIntervalPose:=Round(TpsInt/Intervalle);

//   Camera.SetWindow((x1-1)*2+1,(y1-1)*2+1,(x2-1)*2+1,(y2-1)*2+1);
   Camera.SetWindow(Round(ax*x1+bx),Round(ay*y1+by),Round(ax*x2+bx),Round(ay*y2+by));
   WriteSpy(Camera.GetName+lang(' Fenêtre : (')+IntToStr(Round(ax*x1+bx))+','+IntToStr(Round(ay*y1+by))+lang(')/(')+
      IntToStr(Round(ax*x2+bx))+','+IntToStr(Round(ay*y2+by))+')');
   Camera.SetBinning(2);
   WriteSpy(Camera.GetName+lang(' Binning : 2'));
   Camera.SetPose(PoseCamera);
   WriteSpy(Camera.GetName+lang(' Temps de pose : ')+MyFloatToStr(PoseCamera,3)
      +lang(' s'));   
   if ShutterClosedCamera then
      if Camera.HasAShutter then Camera.SetShutterClosed;
   WriteSpy(lang('Début de la pose sur la caméra principale'));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Début de la pose sur la caméra principale'));      
   Resultat:=Camera.StartPose;
   EventEndPose.ResetEvent;   

   if Config.TelescopeBranche then
      if Config.GoodPos then
         begin
         AlphaAcq:=Config.AlphaScope;
         DeltaAcq:=Config.DeltaScope;
         end
      else
         begin
         WriteSpy(lang('Le télescope ne veut pas donner sa position'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope ne veut pas donner sa position'));
         end;

   if Resultat then
      begin
      // Pendant la pose, on ne lit pas la température pour pas ralentir le timer
      TimerTemp.Enabled:=False;
//      TimerPose2.Enabled:=True;
      ThreadPose2:=TThreadPose2.Create;
      StopPose:=False;
      end;
   except
   pop_main.SeuilsEnable;
   pop_image_acq.AcqRunning:=False;
   panel1.caption:=lang('Stop');
   cb_bouclage.Checked:=False;
   Stop1.Visible:=False;
   outAcqB1.Visible:=True;
   Stop2.Visible:=False;
   outAcqB2.Visible:=True;
   Stop4.Visible:=False;
   outAcqB4.Visible:=True;
//   TimerPose2.enabled:=False;
   ThreadPose2.Terminate;
   end;
end;

procedure Tpop_camera.outAcqB4Click(Sender: TObject);
var
   AMax,Moy,Ecart:double;
   i,j,k:integer;
   Alpha,Delta:Double;
   Rep:string;
   Resultat:Boolean;
   LocalBinning:Byte;
   ax,bx,ay,by:Double;
begin
   EventEndAcq.ResetEvent;
//   ResetEvent(EventEndAcq);
   pop_scope.CheckBox3.Enabled:=True;
   pop_scope.Label8.Enabled:=True;

   StopPose:=False;
      
   Stop1.Visible:=True;
   outAcqB1.Visible:=False;
   Stop2.Visible:=True;
   outAcqB2.Visible:=False;
   Stop4.Visible:=True;
   outAcqB4.Visible:=False;

   // On attends un bon guidage
   // On le met a false et c'est au guidage de le remetre a true
   if Config.SuiviEnCours then
      begin
      if Config.SuiviEnCours then
         begin
         Panel1.Caption:=lang('Attente');
         WriteSpy('Attente d''un bon guidage');
         if Assigned(pop_track) then pop_track.AddMessage(lang('Attente d''un bon guidage'));
         TrackGood:=False;
         while not(TrackGood) and Config.SuiviEnCours do
            begin
            Application.ProcessMessages;
            if StopPose then
               begin
               pop_scope.CheckBox3.Enabled:=True;
               pop_scope.Label8.Enabled:=True;
               Exit;
               end;
            pop_scope.CheckBox3.Enabled:=True;
            pop_scope.Label8.Enabled:=True;
            end;
         if Config.SuiviEnCours then WriteSpy(lang('Le guidage est bon maintenant'));
         if Assigned(pop_track) then
            begin
            pop_track.AddMarque(HeureToJourJulien(GetHourDT),config.XMesure,config.YMesure);
            pop_track.RAZErreur;
            end;
         end;
      end;

   try
   CountBoucle:=1;

   if Camera.IsAValidBinning(4) then LocalBinning:=4 else LocalBinning:=3;

   x1:=StrToInt(win_x1.Text);
   x2:=StrToInt(win_x2.Text);
   y1:=StrToInt(win_y1.Text);
   y2:=StrToInt(win_y2.Text);
   if x1>Camera.GetXSize div LocalBinning then x1:=Camera.GetXSize div LocalBinning;
   if x2>Camera.GetXSize div LocalBinning then x2:=Camera.GetXSize div LocalBinning;
   if y1>Camera.GetYSize div LocalBinning then y1:=Camera.GetYSize div LocalBinning;
   if y2>Camera.GetYSize div LocalBinning then y2:=Camera.GetYSize div LocalBinning;

   if x1<1 then x1:=1;
   if x2<1 then x2:=1;
   if y1<1 then y1:=1;
   if y2<1 then y2:=1;

   // y=ax+b
   ax:=(Camera.GetXSize-1)/((Camera.GetXSize div LocalBinning)-1);
   bx:=1-ax;
   ay:=(Camera.GetYSize-1)/((Camera.GetYSize div LocalBinning)-1);
   by:=1-ay;

   if cb_bouclage.Checked then Nombre:=nb_bouclage.Value else Nombre:=1;
   i:=1;

   // si l'image n'existe pas, on la cree
   if pop_image_acq=nil then
      begin
      pop_image_acq:=tpop_image.Create(Application);
      pop_image_acq.IsUsedForAcq:=True;
      pop_image_acq.ImgInfos.BZero:=0;
      pop_image_acq.ImgInfos.BScale:=1;
      end;

   Progress.Min:=0;
   Progress.Max:=round(MyStrToFloat(exp_b4.text));
   Progress.Position:=0;

   pop_image_acq.AcqRunning:=True;
   if (RadioGroup1.ItemIndex=1) or (RadioGroup1.ItemIndex=2) then
      ShutterClosedCamera:=True else ShutterClosedCamera:=False;

   PoseEnCours:=True;

   if Camera.Is16Bits and (pop_image_acq<>nil) and (pop_image_acq.DataDouble<>nil) then
      begin
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
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
   pop_image_acq.ImgInfos.TypeData:=Camera.GetTypeData;
   pop_image_acq.ImgInfos.Nbplans:=Camera.GetNbPlans;

   PoseCamera:=MyStrToFloat(exp_b4.Text);
   if PoseCamera<Camera.GetMinimalPose then begin
      PoseCamera:=Camera.GetMinimalPose;
      exp_b4.Text:=floattostr(PoseCamera);
   end;
   TpsInt:=Round(PoseCamera*1000);
   pop_image_acq.ImgInfos.Sx:=(x2-x1+1);
   pop_image_acq.ImgInfos.Sy:=(y2-y1+1);

   if Config.MirrorX then
      begin
      x1:=Camera.GetXSize div LocalBinning-x1+1;
      x2:=Camera.GetXSize div LocalBinning-x2+1;
      end;
   if Config.MirrorY then
      begin
      y1:=Camera.GetYSize div LocalBinning-y1+1;
      y2:=Camera.GetYSize div LocalBinning-y2+1;
      end;

   Getmem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
   for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
     Getmem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
     for i:=1 to pop_image_acq.ImgInfos.Sy do Getmem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
   end;
   NbInterValCourant:=0;
   NbIntervalPose:=Round(TpsInt/Intervalle);

   Camera.SetWindow(Round(ax*x1+bx),Round(ay*y1+by),Round(ax*x2+bx),Round(ay*y2+by));
   WriteSpy(Camera.GetName+lang(' Fenêtre : (')+IntToStr(Round(ax*x1+bx))+','+IntToStr(Round(ay*y1+by))+lang(')/(')+
      IntToStr(Round(ax*x2+bx))+','+IntToStr(Round(ay*y2+by))+')');

   Camera.SetBinning(LocalBinning);
   WriteSpy(Camera.GetName+lang(' Binning : ')+IntToStr(LocalBinning));
   Camera.SetPose(PoseCamera);
   WriteSpy(Camera.GetName+lang(' Temps de pose : ')+MyFloatToStr(PoseCamera,3)+
      lang(' s'));   
   if ShutterClosedCamera then
      if Camera.HasAShutter then Camera.SetShutterClosed;
   WriteSpy(lang('Début de la pose sur la caméra principale'));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Début de la pose sur la caméra principale'));      
   Resultat:=Camera.StartPose;
   EventEndPose.ResetEvent;   

   if Config.TelescopeBranche then
      if Config.GoodPos then
         begin
         AlphaAcq:=Config.AlphaScope;
         DeltaAcq:=Config.DeltaScope;
         end
      else
         begin
         WriteSpy(lang('Le télescope ne veut pas donner sa position'));
         pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope ne veut pas donner sa position'));
         end;

   if Resultat then
      begin
      // Pendant la pose, on ne lit pas la température pour pas ralentir le timer
      TimerTemp.Enabled:=False;
//      TimerPose4.Enabled:=True;
      ThreadPose4:=TThreadPose4.Create;
      StopPose:=False;
      end;
   except
   pop_main.SeuilsEnable;
   pop_image_acq.AcqRunning:=False;
   panel1.caption:=lang('Stop');
   cb_bouclage.Checked:=False;
   Stop1.Visible:=False;
   outAcqB1.Visible:=True;
   Stop2.Visible:=False;
   outAcqB2.Visible:=True;
   Stop4.Visible:=False;
   outAcqB4.Visible:=True;
//   TimerPose2.enabled:=False;
   ThreadPose2.Terminate;
   end;
end;

procedure Tpop_camera.TimerInter4Timer(Sender: TObject);
var
   AMin,Mediane,AMax,Moy,Ecart:double;
   i,j,k,nbimage,ii,PosEsp:Integer;
   InterI:SmallInt;
   Rep:string;
   Alpha,Delta:Double;
   LocalBinning:Byte;
   ax,bx,ay,by:double;
   Resultat:boolean;
   Line:string;
begin
   // Si le timer est pas actif on sort de suite
   if not TimerInter4.Enabled then Exit;

   // On arrete ce timer
   TimerInter4.Enabled:=False;

   // On libere le Thread du timer haute resolution
//   TimerPose4.Enabled:=False;
   ThreadPose4.Terminate;

   try

//   Progress.Position:=0;
   Panel1.Caption:=lang('Lecture');
   if pop_builder<>nil then pop_builder.temps_de_pose.text:=lang('Lecture');
   Panel1.Update;

   Stop1.Enabled:=False;
   Stop2.Enabled:=False;
   Stop4.Enabled:=False;
   outAcqB1.Enabled:=False;
   outAcqB2.Enabled:=False;
   outAcqB4.Enabled:=False;
   try
   try
   EventEndPose.SetEvent;   
   Camera.ReadCCD(pop_image_acq.DataInt,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   if Camera.Is16Bits then
      begin
      pop_image_acq.ImgInfos.BZero:=32768;
      ConvertFITSIntToReal(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos);
      end;
   finally
   Stop1.Enabled:=True;
   Stop2.Enabled:=True;
   Stop4.Enabled:=True;
   outAcqB1.Enabled:=True;
   outAcqB2.Enabled:=True;
   outAcqB4.Enabled:=True;
   end;

   except
   Config.CameraBranchee:=False;
   pop_main.UpdateGUICamera;
   end;

   Camera.GetCCDDateBegin(YearBegin,MonthBegin,DayBegin);
   Camera.GetCCDTimeBegin(HourBegin,MinBegin,SecBegin,MSecBegin);
   Camera.GetCCDDateEnd(YearEnd,MonthEnd,DayEnd);
   Camera.GetCCDTimeEnd(HourEnd,MinEnd,SecEnd,MSecEnd);
   try
   TimeBegin:=EncodeDate(YearBegin,MonthBegin,DayBegin)+EncodeTime(HourBegin,MinBegin,SecBegin,MSecBegin);
   TimeEnd:=EncodeDate(YearEnd,MonthEnd,DayEnd)+EncodeTime(HourEnd,MinEnd,SecEnd,MSecEnd);
   except
   if Config.Verbose then
      begin
      WriteSpy(lang('Begin Annee = ')+IntToSTr(YearBegin)); //nolang
      WriteSpy(lang('Begin Mois = ')+IntToSTr(MonthBegin)); //nolang
      WriteSpy(lang('Begin Jours = ')+IntToSTr(DayBegin)); //nolang
      WriteSpy(lang('Begin Heure = ')+IntToSTr(HourBegin)); //nolang
      WriteSpy(lang('Begin Minutes = ')+IntToSTr(MinBegin)); //nolang
      WriteSpy(lang('Begin Secondes = ')+IntToSTr(SecBegin)); //nolang
      WriteSpy(lang('Begin MilliSecondes = ')+IntToSTr(MSecBegin)); //nolang

      WriteSpy(lang('End Annee = ')+IntToSTr(YearEnd)); //nolang
      WriteSpy(lang('End Mois = ')+IntToSTr(MonthEnd)); //nolang
      WriteSpy(lang('End Jours = ')+IntToSTr(DayEnd)); //nolang
      WriteSpy(lang('End Heure = ')+IntToSTr(HourEnd)); //nolang
      WriteSpy(lang('End Minutes = ')+IntToSTr(MinEnd)); //nolang
      WriteSpy(lang('End Secondes = ')+IntToSTr(SecEnd)); //nolang
      WriteSpy(lang('End MilliSecondes = ')+IntToSTr(MSecEnd)); //nolang
      end;
   end;


   if pop_builder<>nil then pop_builder.temps_de_pose.text:='';

   PoseEnCours:=False;
   // affichage du nombre total d'image
   Camera.AdjustIntervalePose(NbInterValCourant,nbimage,Intervalle);
   if nbimage>0 then Edit6.text:=inttostr(nbimage);
   // il faut que la nouvelle image soit active a la fin de la pose
   pop_image_acq.setfocus ; // rend le focus a l'image finale
   pop_main.LastChild:=pop_image_acq; //il faut un peu forcer les choses car onActivate n'est pas appeler si la fiche active precedente n'est pas un enfant MDI.}

   // On lit le température à nouveau
   TimerTemp.Enabled:=True;

   if ShutterClosedCamera then
      if Camera.HasAShutter then Camera.SetShutterSynchro;

   if config.MirrorX then
      if Camera.Is16Bits then
         MiroirHorizontal(pop_image_acq.DataInt,pop_image_acq.DataDouble,5,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy)
      else
         MiroirHorizontal(pop_image_acq.DataInt,pop_image_acq.DataDouble,2,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   if config.MirrorY then
      if Camera.Is16Bits then
         MiroirVertical(pop_image_acq.DataInt,pop_image_acq.DataDouble,5,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy)
      else
         MiroirVertical(pop_image_acq.DataInt,pop_image_acq.DataDouble,2,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);

{   if config.MirrorX then
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do
         for j:=1 to pop_image_acq.ImgInfos.Sy do
            for i:=1 to pop_image_acq.ImgInfos.Sx div 2 do
               begin
               InterI:=pop_image_acq.DataInt^[k]^[j]^[i];
               pop_image_acq.DataInt^[k]^[j]^[i]:=pop_image_acq.DataInt^[k]^[j]^[pop_image_acq.ImgInfos.Sx-i+1];
               pop_image_acq.DataInt^[k]^[j]^[pop_image_acq.ImgInfos.Sx-i+1]:=InterI;
               end;
   if config.MirrorY then
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
      if Camera.IsAValidBinning(4) then ImgInfos.BinningX:=4 else ImgInfos.BinningX:=3;
      if Camera.IsAValidBinning(4) then ImgInfos.BinningY:=4 else ImgInfos.BinningY:=3;
      ImgInfos.MiroirX:=config.MirrorX;
      ImgInfos.MiroirY:=config.MirrorY;
      ImgInfos.Telescope:=config.Telescope;
      ImgInfos.Observateur:=config.Observateur;
      ImgInfos.Camera:=Camera.GetName;
      if Config.UseCFW8 then
         begin
         if RadioButton1.Checked then ImgInfos.Filtre:=RadioButton1.Caption;
         if RadioButton2.Checked then ImgInfos.Filtre:=RadioButton2.Caption;
         if RadioButton3.Checked then ImgInfos.Filtre:=RadioButton3.Caption;
         if RadioButton4.Checked then ImgInfos.Filtre:=RadioButton4.Caption;
         if RadioButton5.Checked then ImgInfos.Filtre:=RadioButton5.Caption;
         end
      else ImgInfos.Filtre:=config.Filtre;
      ImgInfos.Observatoire:=config.Observatoire;
      ImgInfos.Lat:=Config.Lat;
      ImgInfos.Long:=Config.Long;
      ImgInfos.Focale:=config.FocaleTele;
      ImgInfos.Diametre:=config.Diametre;
      ImgInfos.OrientationCCD:=config.OrientationCCD;
      ImgInfos.Seeing:=Config.Seeing;
      if Config.SuiviEnCours and (pop_track<>nil) then
         begin
         Line:=pop_track.Panel17.Caption;
         PosEsp:=Pos(' ',Line);
         Line:=Copy(Line,1,PosEsp-1);
         ImgInfos.RMSGuideError:=MyStrToFloat(Line);
         end;
      ImgInfos.BScale:=1;
      ImgInfos.BZero:=0;
      try
      if Panel6.Caption<>lang('Inconnue') then ImgInfos.TemperatureCCD:=MyStrToFloat(Panel6.Caption)
                                          else ImgInfos.TemperatureCCD:=999;
      except
      ImgInfos.TemperatureCCD:=999;
      end;

      ImgInfos.Alpha:=AlphaAcq;
      ImgInfos.Delta:=DeltaAcq;

      ImgInfos.PixX:=Camera.GetXPixelSize;
      ImgInfos.PixY:=Camera.GetYPixelSize;
      ImgInfos.X1:=x1;
      ImgInfos.Y1:=y1;
      ImgInfos.X2:=x2;
      ImgInfos.Y2:=y2;
      end;

   if Checkbox1.Checked then
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
   if cb_autosave.Checked then
      begin
      case RadioGroup1.ItemIndex of
         0:Rep:=config.RepImagesAcq;
         1:Rep:=config.RepOffsets;
         2:Rep:=config.RepNoirs;
         3:Rep:=config.RepPlus;
         end;
      pop_image_acq.SaveImage(Rep+'\'+img_name.Text+IntToStr(index.Value));
      if Assigned(pop_track) then pop_track.AddMessage(lang('Sauvegarde de : '+img_name.Text+IntToStr(index.Value)));

      if not(cb_bouclage.Checked) then index.Value:=index.Value+1;
      end;

   if cb_bouclage.Checked then index.Value:=index.Value+1;
   if Config.TelescopeBranche and Telescope.StoreCoordinates then
      if RadioGroup1.ItemIndex=3 then
         begin
         if Config.GoodPos then
            begin
            Alpha:=Config.AlphaScope;
            Delta:=Config.DeltaScope;
            if not Telescope.Pointe(Alpha+0.01666666,Delta) then
               begin
               WriteSpy(lang('Le télescope ne veut pas pointer les coordonnées'));
               pop_Main.AfficheMessage(lang('Erreur'),
                  lang('Le télescope ne veut pas pointer les coordonnées'));
               end;
            if not Telescope.WaitPoint(Alpha+0.01666666,Delta) then
               begin
               WriteSpy('Le télescope n''est pas arrivé sur les coordonnées demandées');
               pop_Main.AfficheMessage(lang('Erreur'),
                  'Le télescope n''est pas arrivé sur les coordonnées demandées');
               end
            else if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
            end
         else
            begin
            WriteSpy(lang('Le télescope ne veut pas donner sa position'));
            pop_Main.AfficheMessage(lang('Erreur'),
               lang('Le télescope ne veut pas donner sa position'));
            end;
         end;

   // On remet à 0 pour pouvoir continuer le guidage
   NbIntervalPose:=0;

   // On recommence le bouclage
   if cb_Bouclage.Checked and (CountBoucle<nb_Bouclage.Value) and not(StopPose) then
      begin
      // On attends un bon guidage
      // si on est en guidage !
      if Config.SuiviEnCours then
         begin
        // On attends un peu
         MySleep(1000);
         // Decalage
         if Config.UseDecalages and (Config.NbDecalageSuivi<>0) then
            begin
            ii:=CountBoucle mod (Config.NbDecalageSuivi+1);
            if ii=0 then
               begin
               Config.xDeplaceSuivi:=0;
               Config.yDeplaceSuivi:=0;
               end
            else
               begin
               Config.xDeplaceSuivi:=Config.DecalageSuiviX^[ii];
               Config.yDeplaceSuivi:=Config.DecalageSuiviY^[ii];
               end;
            WriteSpy(lang('Decalage X =')+MyFloatToStr(Config.xDeplaceSuivi,2));
            if Assigned(pop_track) then pop_track.AddMessage(lang('Decalage X =')+MyFloatToStr(Config.xDeplaceSuivi,2));
            WriteSpy(lang('Decalage Y =')+MyFloatToStr(Config.yDeplaceSuivi,2));
            if Assigned(pop_track) then pop_track.AddMessage(lang('Decalage Y =')+MyFloatToStr(Config.yDeplaceSuivi,2));
            end;

         // On le met a false et c'est au guidage de le remetre a true
         if Config.SuiviEnCours then
            begin
            Panel1.Caption:=lang('Attente');
            WriteSpy('Attente d''un bon guidage');
            if Assigned(pop_track) then pop_track.AddMessage(lang('Attente d''un bon guidage'));
            TrackGood:=False;
            while not(TrackGood) and Config.SuiviEnCours do
               begin
               Application.ProcessMessages;
               if StopPose then
                  begin
                  pop_scope.CheckBox3.Enabled:=True;
                  pop_scope.Label8.Enabled:=True;
                  Exit;
                  end;
               pop_scope.CheckBox3.Enabled:=True;
               pop_scope.Label8.Enabled:=True;
               end;
            if Config.SuiviEnCours then WriteSpy(lang('Le guidage est bon maintenant'));
            if Assigned(pop_track) then
               begin
               pop_track.AddMarque(HeureToJourJulien(GetHourDT),config.XMesure,config.YMesure);
               pop_track.RAZErreur;
               end;
            end;
         end;

      Inc(CountBoucle);

      // On relance la pose
      Stop1.Visible:=True;
      outAcqB1.Visible:=False;
      Stop2.Visible:=True;
      outAcqB2.Visible:=False;
      Stop4.Visible:=True;
      outAcqB4.Visible:=False;

      if Camera.IsAValidBinning(4) then LocalBinning:=4 else LocalBinning:=3;

      x1:=StrToInt(win_x1.Text);
      x2:=StrToInt(win_x2.Text);
      y1:=StrToInt(win_y1.Text);
      y2:=StrToInt(win_y2.Text);
      if x1>Camera.GetXSize div LocalBinning then x1:=Camera.GetXSize div LocalBinning;
      if x2>Camera.GetXSize div LocalBinning then x2:=Camera.GetXSize div LocalBinning;
      if y1>Camera.GetYSize div LocalBinning then y1:=Camera.GetYSize div LocalBinning;
      if y2>Camera.GetYSize div LocalBinning then y2:=Camera.GetYSize div LocalBinning;
      if x1<1 then x1:=1;
      if x2<1 then x2:=1;
      if y1<1 then y1:=1;
      if y2<1 then y2:=1;

      // y=ax+b
      ax:=(Camera.GetXSize-1)/((Camera.GetXSize div LocalBinning)-1);
      bx:=1-ax;
      ay:=(Camera.GetYSize-1)/((Camera.GetYSize div LocalBinning)-1);
      by:=1-ay;

{         progress.min:=0;
      progress.max:=round(MyStrToFloat(exp_b4.text));
      progress.position:=0;}

      // Si un guidage est en cours on attends on bon guidage
//         if Config.SuiviEnCours then
//            repeat
//            until (pop_camera_suivi.ErreurX<0.5) and (pop_camera_suivi.ErreurY<0.5);

      pop_image_acq.AcqRunning:=True;
      if (RadioGroup1.ItemIndex=1) or (RadioGroup1.ItemIndex=2) then
         ShutterClosedCamera:=True else ShutterClosedCamera:=False;

      PoseEnCours:=True;

      if Camera.Is16Bits and (pop_image_acq<>nil) and (pop_image_acq.DataDouble<>nil) then
         begin
         for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
            for i:=1 to pop_image_acq.ImgInfos.Sy do Freemem(pop_image_acq.DataDouble^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
            Freemem(pop_image_acq.DataDouble^[k],4*pop_image_acq.ImgInfos.Sy);
         end;
         Freemem(pop_image_acq.DataDouble,4*pop_image_acq.ImgInfos.Nbplans);
         end;
      if (pop_image_acq<>nil) and (pop_image_acq.DataInt<>nil) then
         begin
         for k:=1 to pop_image_acq.ImgInfos.Nbplans do
            begin
            for i:=1 to pop_image_acq.ImgInfos.Sy do Freemem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
            Freemem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
            end;
         Freemem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
         end;

      pop_image_acq.ImgInfos.min[1]:=0;
      pop_image_acq.ImgInfos.max[1]:=0;
      pop_image_acq.ImgInfos.TypeData:=Camera.GetTypeData;
      pop_image_acq.ImgInfos.Nbplans:=Camera.GetNbPlans;

      TpsInt:=Round(MyStrToFloat(exp_b4.Text)*1000);

      pop_image_acq.ImgInfos.Sx:=(x2-x1+1);
      pop_image_acq.ImgInfos.Sy:=(y2-y1+1);

      if Config.MirrorX then
         begin
         x1:=Camera.GetXSize-x1+1;
         x2:=Camera.GetXSize-x2+1;
         end;
      if Config.MirrorY then
         begin
         y1:=Camera.GetYSize-y1+1;
         y2:=Camera.GetYSize-y2+1;
         end;

      Getmem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do
         begin
         Getmem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
         for i:=1 to pop_image_acq.ImgInfos.Sy do Getmem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
         end;
      NbInterValCourant:=0;
      NbIntervalPose:=Round(TpsInt/Intervalle);

      Camera.SetWindow(Round(ax*x1+bx),Round(ay*y1+by),Round(ax*x2+bx),Round(ay*y2+by));
      WriteSpy(Camera.GetName+lang(' Fenêtre : (')+IntToStr(Round(ax*x1+bx))+','+IntToStr(Round(ay*y1+by))+lang(')/(')+
         IntToStr(Round(ax*x2+bx))+','+IntToStr(Round(ay*y2+by))+')');
      Camera.SetBinning(LocalBinning);
      WriteSpy(Camera.GetName+lang(' Binning : ')+IntToStr(LocalBinning));
      Camera.SetPose(MyStrToFloat(exp_b4.Text));
      WriteSpy(Camera.GetName+lang(' Temps de pose : ')+exp_b4.Text+
         lang(' s'));
      if ShutterClosedCamera then
         if Camera.HasAShutter then Camera.SetShutterClosed;
      WriteSpy(lang('Début de la pose sur la caméra principale'));
      if Assigned(pop_track) then pop_track.AddMessage(lang('Début de la pose sur la caméra principale'));         
      Resultat:=Camera.StartPose;
      EventEndPose.ResetEvent;      

      if Config.TelescopeBranche then
         if Config.GoodPos then
            begin
            AlphaAcq:=Config.AlphaScope;
            DeltaAcq:=Config.DeltaScope;
            end
         else
            begin
            WriteSpy(lang('Le télescope ne veut pas donner sa position'));
            pop_Main.AfficheMessage(lang('Erreur'),
               lang('Le télescope ne veut pas donner sa position'));
            end;

      if Resultat then
         begin
         // Pendant la pose, on ne lit pas la température pour pas ralentir le timer
         TimerTemp.Enabled:=False;
//         TimerPose4.Enabled:=True;
         ThreadPose4:=TThreadPose4.Create;
         StopPose:=False;
         end;
      end
   else
      begin
      pop_main.SeuilsEnable;
      pop_image_acq.AcqRunning:=False;
      panel1.caption:=lang('Stop');
      cb_bouclage.Checked:=False;
      Stop1.Visible:=False;
      outAcqB1.Visible:=True;
      Stop2.Visible:=False;
      outAcqB2.Visible:=True;
      Stop4.Visible:=False;
      outAcqB4.Visible:=True;
      Progress.Position:=0;
      EventEndAcq.SetEvent;
//      SetEvent(EventEndAcq);
      end;

   except
   pop_main.SeuilsEnable;
   pop_image_acq.AcqRunning:=False;
   panel1.caption:=lang('Stop');
   cb_bouclage.Checked:=False;
   Stop1.Visible:=False;
   outAcqB1.Visible:=True;
   Stop2.Visible:=False;
   outAcqB2.Visible:=True;
   Stop4.Visible:=False;
   outAcqB4.Visible:=True;
//   TimerPose4.enabled:=False;
   ThreadPose4.Terminate;
   TimerInter4.Enabled:=False;
   end;
end;

procedure tpop_camera.update_stats(x,y:integer; min,mediane,max,moy,ecart:double);
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
// J'enleve ca pour l'instant car ca plante le bouclage !
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

procedure Tpop_camera.RadioGroup1Click(Sender: TObject);
begin
IsNoir:=False;
if RadioGroup1.ItemIndex<>0 then
   begin
   cb_bouclage.Checked:=True;
   cb_autosave.Checked:=True;
   end
else
   begin
   cb_bouclage.Checked:=False;
   cb_autosave.Checked:=False;
   img_name.Text:='';
   end;

if RadioGroup1.ItemIndex=0 then img_name.Text:='';
if RadioGroup1.ItemIndex=1 then
   begin
   img_name.Text:=Config.ConfigPretrait.NomOffset;
   exp_b1.Text:='0';
   exp_b2.Text:='0';
   exp_b4.Text:='0';
   IsNoir:=True;
   end
else
   begin
   exp_b1.Text:=MyFloatToStr(config.Pose1,2);
   exp_b2.Text:=MyFloatToStr(config.Pose2,2);
   exp_b4.Text:=MyFloatToStr(config.Pose4,2);
   end;
if RadioGroup1.ItemIndex=2 then
   begin
   img_name.Text:=Config.ConfigPretrait.NomNoir;
   IsNoir:=True;
   end;
if RadioGroup1.ItemIndex=3 then img_name.Text:=config.ConfigPretrait.NomFlat;
end;


procedure Tpop_camera.btn_closeClick(Sender: TObject);
begin
Close;
end;

{gestion raquettes}

// filtres
procedure Tpop_camera.RadioButton1Click(Sender: TObject);
var
   Error:Word;
begin
if (Config.TypeCamera=ST7) or (Config.TypeCamera=ST8) or (Config.TypeCamera=ST9)
   or (Config.TypeCamera=ST10) or (Config.TypeCamera=STTrack) then
   begin
   TimerTemp.Enabled:=False;
   case Config.TypeOS of
      0:Error:=PutFilterSbig(1);
      1:Error:=PutFilterSbigNT(1);
      end;
   if Error<>0 then ShowMessage(lang('Erreur : ')+GetErrorSbig(Error));
   TimerTemp.Enabled:=True;
   end;
end;

procedure Tpop_camera.RadioButton2Click(Sender: TObject);
var
   Error:Word;
begin
if (Config.TypeCamera=ST7) or (Config.TypeCamera=ST8) or (Config.TypeCamera=ST9)
   or (Config.TypeCamera=ST10) or (Config.TypeCamera=STTrack) then
   begin
   TimerTemp.Enabled:=False;
   case Config.TypeOS of
      0:Error:=PutFilterSbig(2);
      1:Error:=PutFilterSbigNT(2);
      end;
   if Error<>0 then ShowMessage(lang('Erreur : ')+GetErrorSbig(Error));
   TimerTemp.Enabled:=True;
   end;
end;

procedure Tpop_camera.RadioButton3Click(Sender: TObject);
var
   Error:Word;
begin
if (Config.TypeCamera=ST7) or (Config.TypeCamera=ST8) or (Config.TypeCamera=ST9)
   or (Config.TypeCamera=ST10) or (Config.TypeCamera=STTrack) then
   begin
   TimerTemp.Enabled:=False;
   case Config.TypeOS of
      0:Error:=PutFilterSbig(3);
      1:Error:=PutFilterSbigNT(3);
      end;
   if Error<>0 then ShowMessage(lang('Erreur : ')+GetErrorSbig(Error));
   TimerTemp.Enabled:=True;
   end;
end;

procedure Tpop_camera.RadioButton4Click(Sender: TObject);
var
   Error:Word;
begin
if (Config.TypeCamera=ST7) or (Config.TypeCamera=ST8) or (Config.TypeCamera=ST9)
   or (Config.TypeCamera=ST10) or (Config.TypeCamera=STTrack) then
   begin
   TimerTemp.Enabled:=False;
   case Config.TypeOS of
      0:Error:=PutFilterSbig(4);
      1:Error:=PutFilterSbigNT(4);
      end;
   if Error<>0 then ShowMessage(lang('Erreur : ')+GetErrorSbig(Error));
   TimerTemp.Enabled:=True;
   end;
end;

procedure Tpop_camera.RadioButton5Click(Sender: TObject);
var
   Error:Word;
begin
if (Config.TypeCamera=ST7) or (Config.TypeCamera=ST8) or (Config.TypeCamera=ST9)
   or (Config.TypeCamera=ST10) or (Config.TypeCamera=STTrack) then
   begin
   TimerTemp.Enabled:=False;
   case Config.TypeOS of
      0:Error:=PutFilterSbig(5);
      1:Error:=PutFilterSbigNT(5);
      end;
   if Error<>0 then ShowMessage(lang('Erreur : ')+GetErrorSbig(Error));
   TimerTemp.Enabled:=True;
   end;
end;

procedure Tpop_camera.FormShow(Sender: TObject);
var
   Ini:TMemIniFile;
   Path:string;
   Valeur:Integer;
begin
// Lit la pos
Path:=ExtractFilePath(Application.Exename);
Ini:=TMemIniFile.Create(Path+'TeleAuto.ini'); //nolang
try
Valeur:=StrToInt(Ini.ReadString('WindowsPos','CCDTop',IntToStr(Self.Top)));
if Valeur<>0 then Top:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','CCDLeft',IntToStr(Self.Left)));
if Valeur<>0 then Left:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','CCDWidth',IntToStr(Self.Width)));
if Valeur<>0 then Width:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','CCDHeight',IntToStr(Self.Height)));
if Valeur<>0 then Height:=Valeur;
finally
Ini.UpdateFile;
Ini.Free;
end;

StopSuivi:=False;
PoseEnCours:=False;
PoseTrackEnCours:=False;
nb_bouclage.Value:=config.NbBouclage;
exp_b1.Text:=MyFloatToStr(config.Pose1,2);
exp_b2.Text:=MyFloatToStr(config.Pose2,2);
exp_b4.Text:=MyFloatToStr(config.Pose4,2);
if Config.SuiviEnCours then
   begin
   if config.Pose1<PoseMini then exp_b1.Text:=MyFloatToStr(PoseMini,2);
   if config.Pose2<PoseMini then exp_b2.Text:=MyFloatToStr(PoseMini,2);
   if config.Pose4<PoseMini then exp_b4.Text:=MyFloatToStr(PoseMini,2);
   end;

//  filtres
RadioButton1.Caption:=config.NameFilter[1];
RadioButton2.Caption:=config.NameFilter[2];
RadioButton3.Caption:=config.NameFilter[3];
RadioButton4.Caption:=config.NameFilter[4];
RadioButton5.Caption:=config.NameFilter[5];

UpDateForCCDChange;

Caption:=lang('CCD Principal : ')+Camera.GetName;
Left:=Screen.Width-Width;
pages_ccd.ActivePage:=Acq;

// webcam
panel2.visible:=false;
panel2.sendtoback;
if Camera.ShowConfigPanel(false) then
   begin
   panel2.visible:=true;
   panel2.bringtofront;
   end;

UpDateLang(Self);
Label2.Caption:=lang('Luminosité = ')+MyFloatToStr(0,0);
Label3.Caption:='Attente d''un mouvement';
Label4.Caption:='Nombre d''images = '+IntToStr(0);
Button2.Visible:=False;

//CFW8
if config.UseCFW8 then
   begin
   Checkbox2.Checked:=True;
   GroupBox13.Enabled:=True;
   RadioButton1.Enabled:=True;
   RadioButton2.Enabled:=True;
   RadioButton3.Enabled:=True;
   RadioButton4.Enabled:=True;
   RadioButton5.Enabled:=True;
   end
else
   begin
   Checkbox2.Checked:=False;
   GroupBox13.Enabled:=False;
   RadioButton1.Enabled:=False;
   RadioButton2.Enabled:=False;
   RadioButton3.Enabled:=False;
   RadioButton4.Enabled:=False;
   RadioButton5.Enabled:=False;
   end;
   
//Config.SeuilCamera:=RadioGroup12.ItemIndex;
RadioGroup12.ItemIndex:=Config.SeuilCamera;
end;

//Methode 1
procedure Tpop_camera.Stop1Click(Sender: TObject);
begin
Config.xDeplaceSuivi:=0;
Config.yDeplaceSuivi:=0;

// Si il y a un guidage en cours attendre la fin de la pose de guidage avant finir la pose principale
if Config.SuiviEnCours then
   begin
   Config.BloqueGuidage:=True;
   while pop_camera_suivi.PoseEnCours do Application.ProcessMessages;
   end;

if ThreadPose1<>nil then
   if not ThreadPose1.Terminated then
      begin
      ThreadPose1.Terminate;
      TimerInter1.Enabled:=True;
      end;
if ThreadPose2<>nil then
   if not ThreadPose2.Terminated then
      begin
      ThreadPose2.Terminate;
      TimerInter2.Enabled:=True;
      end;
if ThreadPose4<>nil then
   if not ThreadPose4.Terminated then
      begin
      ThreadPose4.Terminate;
      TimerInter4.Enabled:=True;
      end;

NbInterValCourant:=NbIntervalPose;

Config.BloqueGuidage:=False;

StopPose:=True;
cb_bouclage.Checked:=False;
if pop_image_acq<>nil then pop_image_acq.AcqRunning:=False;
Stop1.Visible:=False;
outAcqB1.Visible:=True;
Stop2.Visible:=False;
outAcqB2.Visible:=True;
Stop4.Visible:=False;
outAcqB4.Visible:=True;
Camera.StopPose;
mySleep(100);
Panel1.Caption:=lang('Stop');
end;

//Methode 2
{procedure Tpop_camera.Stop1Click(Sender: TObject);
begin
if (cb_autosave.Checked)and     // enregistrement AVI (seulement Webcam et binning 1x1)
   (config.TypeCamera=Webcam)and
   (pop_webcam.radiogroup2.itemindex=1) then
   begin
   cb_bouclage.Checked:=False;
   Nombre:=1;
   AVIshowmenu:=true;
   pu_webcam.StopAVI;
   Stop1.Visible:=False;
   outAcqB1.Visible:=True;
   Stop2.Visible:=False;
   outAcqB2.Visible:=True;
   Stop4.Visible:=False;
   outAcqB4.Visible:=True;
   end
else
   begin  // traitement normal
   if config.TypeCamera=Webcam then webcam_Nimage:=webcam_MaxImage+1;
   cb_bouclage.Checked:=False;
   pop_image_acq.AcqRunning:=False;
   Nombre:=1;
   index.Value:=1;
   Stop1.Visible:=False;
   outAcqB1.Visible:=True;
   Stop2.Visible:=False;
   outAcqB2.Visible:=True;
   Stop4.Visible:=False;
   outAcqB4.Visible:=True;
   Camera.StopPose;
//   NbInterValCourant:=nbintervalpose+1;
   FinPose:=True;
   end;
end;}

{function Tpop_camera.AcqNonSatur(var x,y:Integer):Boolean;
var
Tps:Double;
Valeur:Double;
ImgNil:PTabImgDouble;
LocalBinning:Byte;
begin
   Result:=False;

   WriteSpy(lang('AcqNonSatur : Recherche de la position de l''étoile'));

   Tps:=0.5;
   if Camera.IsAValidBinning(4) then LocalBinning:=4 else LocalBinning:=3;
   if Acquisition(1,1,Camera.GetXSize,Camera.GetYSize,Tps,LocalBinning,False) then
      begin
      Getmax(pop_image_acq.DataInt,ImgNil,2,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,x,y,Valeur);
//      while (Valeur>config.Satur) and (Tps>config.MinPose) do
      while (Valeur>Camera.GetSaturationLevel) and (Tps>config.MinPose) do
         begin
         Tps:=Tps/2;
         Acquisition(1,1,Camera.GetXSize,Camera.GetYSize,Tps,LocalBinning,False);
         pop_image_acq.AjusteFenetre;
         pop_image_acq.VisuAutoEtoiles;
         getmax(pop_image_acq.DataInt,ImgNil,2,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,x,y,Valeur);
         end;
//      while (Valeur<config.Satur/4) and (Tps<config.MaxPose) do
      while (Valeur<Camera.GetSaturationLevel/4) and (Tps<config.MaxPose) do
         begin
//         Tps:=Tps*config.Satur/4/Valeur;
         Tps:=Tps*Camera.GetSaturationLevel/4/Valeur;
         Acquisition(1,1,Camera.GetXSize,Camera.GetYSize,Tps,LocalBinning,False);
         pop_image_acq.AjusteFenetre;         
         pop_image_acq.VisuAutoEtoiles;
         Getmax(pop_image_acq.DataInt,ImgNil,2,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,x,y,Valeur);
         end;

      WriteSpy(lang('AcqNonSatur : Position de l''étoile ')+IntToStr(x)+'/'+IntToStr(y)
         +'/'+Format('%0.3f',[Valeur])); //nolang

      Result:=True;
      end;
end;}

procedure Tpop_camera.BitBtn1Click(Sender: TObject);
begin
Camera.ShowConfigPanel(false);
end;

procedure Tpop_camera.SpeedButton1Click(Sender: TObject);
begin
win_x1.Text:='1'; //nolang
win_x2.Text:=IntToStr(Camera.GetXSize);
win_y1.Text:='1'; //nolang
win_y2.Text:=IntToStr(Camera.GetYSize);
end;

procedure Tpop_camera.FormHide(Sender: TObject);
begin
if (Config.TypeCamera<>0) then
// Surtout pas, ca fait un truc bizarre si on quitte TA avec cette fenêtre ouverte
//   if Camera.HasTemperature then
if TimerTemp.Enabled then
   TimerTemp.Enabled:=False;
pop_main.ToolButton6.Down:=False;
end;

procedure Tpop_camera.TimerInter2Timer(Sender: TObject);
var
   AMin,Mediane,AMax,Moy,Ecart:double;
   i,j,k,nbimage,ii,PosEsp:Integer;
   InterI:SmallInt;
   Rep,Line:string;
   Alpha,Delta:Double;
   LocalBinning:Byte;
   ax,bx,ay,by:double;
   Resultat:boolean;
begin
   // Si le timer est pas actif on sort de suite
   if not TimerInter2.Enabled then Exit;
   // On libere the Thread du timer haute resolution
//   TimerPose2.Enabled:=False;
   ThreadPose2.Terminate;
   // On arrete ce timer
   TimerInter2.Enabled:=False;

   try
//   progress.position:=0;
   WriteSpy(lang('Lecture'));
   Panel1.Caption:=lang('Lecture');
   if pop_builder<>nil then pop_builder.temps_de_pose.text:=lang('Lecture');
   Panel1.Update;

   Stop1.Enabled:=False;
   Stop2.Enabled:=False;
   Stop4.Enabled:=False;
   outAcqB1.Enabled:=False;
   outAcqB2.Enabled:=False;
   outAcqB4.Enabled:=False;
   try
   try
   EventEndPose.SetEvent;   
   Camera.ReadCCD(pop_image_acq.DataInt,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   if Camera.Is16Bits then
      begin
      pop_image_acq.ImgInfos.BZero:=32768;
      ConvertFITSIntToReal(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos);
      end;
   except
   Config.CameraBranchee:=False;
   pop_main.UpdateGUICamera;
   end;
   finally
   Stop1.Enabled:=True;
   Stop2.Enabled:=True;
   Stop4.Enabled:=True;
   outAcqB1.Enabled:=True;
   outAcqB2.Enabled:=True;
   outAcqB4.Enabled:=True;
   end;


   Camera.GetCCDDateBegin(YearBegin,MonthBegin,DayBegin);
   Camera.GetCCDTimeBegin(HourBegin,MinBegin,SecBegin,MSecBegin);
   Camera.GetCCDDateEnd(YearEnd,MonthEnd,DayEnd);
   Camera.GetCCDTimeEnd(HourEnd,MinEnd,SecEnd,MSecEnd);
   try
   TimeBegin:=EncodeDate(YearBegin,MonthBegin,DayBegin)+EncodeTime(HourBegin,MinBegin,SecBegin,MSecBegin);
   TimeEnd:=EncodeDate(YearEnd,MonthEnd,DayEnd)+EncodeTime(HourEnd,MinEnd,SecEnd,MSecEnd);
   except
   if Config.Verbose then
      begin
      WriteSpy(lang('Begin Annee = ')+IntToSTr(YearBegin)); //nolang
      WriteSpy(lang('Begin Mois = ')+IntToSTr(MonthBegin)); //nolang
      WriteSpy(lang('Begin Jours = ')+IntToSTr(DayBegin)); //nolang
      WriteSpy(lang('Begin Heure = ')+IntToSTr(HourBegin)); //nolang
      WriteSpy(lang('Begin Minutes = ')+IntToSTr(MinBegin)); //nolang
      WriteSpy(lang('Begin Secondes = ')+IntToSTr(SecBegin)); //nolang
      WriteSpy(lang('Begin MilliSecondes = ')+IntToSTr(MSecBegin)); //nolang

      WriteSpy(lang('End Annee = ')+IntToSTr(YearEnd)); //nolang
      WriteSpy(lang('End Mois = ')+IntToSTr(MonthEnd)); //nolang
      WriteSpy(lang('End Jours = ')+IntToSTr(DayEnd)); //nolang
      WriteSpy(lang('End Heure = ')+IntToSTr(HourEnd)); //nolang
      WriteSpy(lang('End Minutes = ')+IntToSTr(MinEnd)); //nolang
      WriteSpy(lang('End Secondes = ')+IntToSTr(SecEnd)); //nolang
      WriteSpy(lang('End MilliSecondes = ')+IntToSTr(MSecEnd)); //nolang
      end;
   end;

   if pop_builder<>nil then pop_builder.temps_de_pose.text:='';

   PoseEnCours:=False;
   // affichage du nombre total d'image
   Camera.AdjustIntervalePose(NbInterValCourant,nbimage,Intervalle);
   if nbimage>0 then Edit6.text:=inttostr(nbimage);
   // il faut que la nouvelle image soit active a la fin de la pose
   pop_image_acq.setfocus ; // rend le focus a l'image finale
   pop_main.LastChild:=pop_image_acq; //il faut un peu forcer les choses car onActivate n'est pas appeler si la fiche active precedente n'est pas un enfant MDI.

   // On lit le température à nouveau
   TimerTemp.Enabled:=True;

   if ShutterClosedCamera then
      if Camera.HasAShutter then Camera.SetShutterSynchro;

   if config.MirrorX then
      if Camera.Is16Bits then
         MiroirHorizontal(pop_image_acq.DataInt,pop_image_acq.DataDouble,5,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy)
      else
         MiroirHorizontal(pop_image_acq.DataInt,pop_image_acq.DataDouble,2,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   if config.MirrorY then
      if Camera.Is16Bits then
         MiroirVertical(pop_image_acq.DataInt,pop_image_acq.DataDouble,5,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy)
      else
         MiroirVertical(pop_image_acq.DataInt,pop_image_acq.DataDouble,2,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);

{   if config.MirrorX then
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do
         for j:=1 to pop_image_acq.ImgInfos.Sy do
            for i:=1 to pop_image_acq.ImgInfos.Sx div 2 do
               begin
               InterI:=pop_image_acq.DataInt^[k]^[j]^[i];
               pop_image_acq.DataInt^[k]^[j]^[i]:=pop_image_acq.DataInt^[k]^[j]^[pop_image_acq.ImgInfos.Sx-i+1];
               pop_image_acq.DataInt^[k]^[j]^[pop_image_acq.ImgInfos.Sx-i+1]:=InterI;
               end;
   if config.MirrorY then
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
      ImgInfos.BinningX:=2;
      ImgInfos.BinningY:=2;
      ImgInfos.MiroirX:=config.MirrorX;
      ImgInfos.MiroirY:=config.MirrorY;
      ImgInfos.Telescope:=config.Telescope;
      ImgInfos.Observateur:=config.Observateur;
      ImgInfos.Camera:=Camera.GetName;
      if Config.UseCFW8 then
         begin
         if RadioButton1.Checked then ImgInfos.Filtre:=RadioButton1.Caption;
         if RadioButton2.Checked then ImgInfos.Filtre:=RadioButton2.Caption;
         if RadioButton3.Checked then ImgInfos.Filtre:=RadioButton3.Caption;
         if RadioButton4.Checked then ImgInfos.Filtre:=RadioButton4.Caption;
         if RadioButton5.Checked then ImgInfos.Filtre:=RadioButton5.Caption;
         end
      else ImgInfos.Filtre:=config.Filtre;
      ImgInfos.Observatoire:=config.Observatoire;
      ImgInfos.Lat:=Config.Lat;
      ImgInfos.Long:=Config.Long;
      ImgInfos.Focale:=config.FocaleTele;
      ImgInfos.Diametre:=config.Diametre;
      ImgInfos.OrientationCCD:=config.OrientationCCD;
      ImgInfos.Seeing:=Config.Seeing;
      if Config.SuiviEnCours and (pop_track<>nil) then
         begin
         Line:=pop_track.Panel17.Caption;
         PosEsp:=Pos(' ',Line);
         Line:=Copy(Line,1,PosEsp-1);
         ImgInfos.RMSGuideError:=MyStrToFloat(Line);
         end;
      ImgInfos.BScale:=1;
      ImgInfos.BZero:=0;
      try
      if Panel6.Caption<>lang('Inconnue') then ImgInfos.TemperatureCCD:=MyStrToFloat(Panel6.Caption)
                                          else ImgInfos.TemperatureCCD:=999;
      except
      ImgInfos.TemperatureCCD:=999;
      end;

      ImgInfos.Alpha:=AlphaAcq;
      ImgInfos.Delta:=DeltaAcq;

      ImgInfos.PixX:=Camera.GetXPixelSize;
      ImgInfos.PixY:=Camera.GetYPixelSize;
      ImgInfos.X1:=x1;
      ImgInfos.Y1:=y1;
      ImgInfos.X2:=x2;
      ImgInfos.Y2:=y2;
      end;

   if Checkbox1.Checked then
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
   if cb_autosave.Checked then
      begin
      case RadioGroup1.ItemIndex of
         0:Rep:=config.RepImagesAcq;
         1:Rep:=config.RepOffsets;
         2:Rep:=config.RepNoirs;
         3:Rep:=config.RepPlus;
         end;
      pop_image_acq.SaveImage(Rep+'\'+img_name.Text+IntToStr(index.Value));
      if Assigned(pop_track) then pop_track.AddMessage(lang('Sauvegarde de : '+img_name.Text+IntToStr(index.Value)));

      if not(cb_bouclage.Checked) then index.Value:=index.Value+1;
      end;

   if cb_bouclage.Checked then index.Value:=index.Value+1;
   if Config.TelescopeBranche and Telescope.StoreCoordinates then
      if RadioGroup1.ItemIndex=3 then
         begin
         if Config.GoodPos then
            begin
            Alpha:=Config.AlphaScope;
            Delta:=Config.DeltaScope;
            if not Telescope.Pointe(Alpha+0.01666666,Delta) then
               begin
               WriteSpy(lang('Le télescope ne veut pas pointer les coordonnées'));
               pop_Main.AfficheMessage(lang('Erreur'),
                  lang('Le télescope ne veut pas pointer les coordonnées'));
               end;
            if not Telescope.WaitPoint(Alpha+0.01666666,Delta) then
               begin
               WriteSpy('Le télescope n''est pas arrivé sur les coordonnées demandées');
               pop_Main.AfficheMessage(lang('Erreur'),
                  'Le télescope n''est pas arrivé sur les coordonnées demandées');
               end
            else if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
            end
         else
            begin
            WriteSpy(lang('Le télescope ne veut pas donner sa position'));
            pop_Main.AfficheMessage(lang('Erreur'),
               lang('Le télescope ne veut pas donner sa position'));
            end;
         end;

   // On remet à 0 pour pouvoir continuer le guidage
   NbIntervalPose:=0;

   // On recommence le bouclage
   if cb_Bouclage.Checked and (CountBoucle<nb_Bouclage.Value) and not(StopPose) then
      begin
      // si on est en guidage !
      if Config.SuiviEnCours then
         begin
         // On attends un peu
         MySleep(1000);
         // Decalage
         if Config.UseDecalages and (Config.NbDecalageSuivi<>0) then
            begin
            ii:=CountBoucle mod (Config.NbDecalageSuivi+1);
            if ii=0 then
               begin
               Config.xDeplaceSuivi:=0;
               Config.yDeplaceSuivi:=0;
               end
            else
               begin
               Config.xDeplaceSuivi:=Config.DecalageSuiviX^[ii];
               Config.yDeplaceSuivi:=Config.DecalageSuiviY^[ii];
               end;
            WriteSpy(lang('Decalage X =')+MyFloatToStr(Config.xDeplaceSuivi,2));
            if Assigned(pop_track) then pop_track.AddMessage(lang('Decalage X =')+MyFloatToStr(Config.xDeplaceSuivi,2));
            WriteSpy(lang('Decalage Y =')+MyFloatToStr(Config.yDeplaceSuivi,2));
            if Assigned(pop_track) then pop_track.AddMessage(lang('Decalage Y =')+MyFloatToStr(Config.yDeplaceSuivi,2));
            end;

         // On attends un bon guidage
         if Config.SuiviEnCours then
            begin
            Panel1.Caption:=lang('Attente');
            WriteSpy('Attente d''un bon guidage');
            if Assigned(pop_track) then pop_track.AddMessage(lang('Attente d''un bon guidage'));
            TrackGood:=False;
            while not(TrackGood) and Config.SuiviEnCours do
               begin
               Application.ProcessMessages;
               if StopPose then
                  begin
                  pop_scope.CheckBox3.Enabled:=True;
                  pop_scope.Label8.Enabled:=True;
                  Exit;
                  end;
               pop_scope.CheckBox3.Enabled:=True;
               pop_scope.Label8.Enabled:=True;
               end;
            if Config.SuiviEnCours then WriteSpy(lang('Le guidage est bon maintenant'));
            if Assigned(pop_track) then
               begin
               pop_track.AddMarque(HeureToJourJulien(GetHourDT),config.XMesure,config.YMesure);
               pop_track.RAZErreur;
               end;
            end;
         end;

      Inc(CountBoucle);

      // On relance la pose
      // Copie de start / Pas genial / Changer plus tard
      Stop1.Visible:=True;
      outAcqB1.Visible:=False;
      Stop2.Visible:=True;
      outAcqB2.Visible:=False;
      Stop4.Visible:=True;
      outAcqB4.Visible:=False;
      x1:=StrToInt(win_x1.Text);
      x2:=StrToInt(win_x2.Text);
      y1:=StrToInt(win_y1.Text);
      y2:=StrToInt(win_y2.Text);
      if x1>Camera.GetXSize div 2 then x1:=Camera.GetXSize div 2;
      if x2>Camera.GetXSize div 2 then x2:=Camera.GetXSize div 2;
      if y1>Camera.GetYSize div 2 then y1:=Camera.GetYSize div 2;
      if y2>Camera.GetYSize div 2 then y2:=Camera.GetYSize div 2;
      if x1<1 then x1:=1;
      if x2<1 then x2:=1;
      if y1<1 then y1:=1;
      if y2<1 then y2:=1;

      // y=ax+b
      ax:=(Camera.GetXSize-1)/((Camera.GetXSize div 2)-1);
      bx:=1-ax;
      ay:=(Camera.GetYSize-1)/((Camera.GetYSize div 2)-1);
      by:=1-ay;

      Progress.Min:=0;
      Progress.Max:=round(MyStrToFloat(exp_b2.text));
      Progress.Position:=0;

      pop_image_acq.AcqRunning:=True;
      if (RadioGroup1.ItemIndex=1) or (RadioGroup1.ItemIndex=2) then
         ShutterClosedCamera:=True else ShutterClosedCamera:=False;

         PoseEnCours:=True;

      if Camera.Is16Bits and (pop_image_acq<>nil) and (pop_image_acq.DataDouble<>nil) then
         begin
         for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
            for i:=1 to pop_image_acq.ImgInfos.Sy do Freemem(pop_image_acq.DataDouble^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
            Freemem(pop_image_acq.DataDouble^[k],4*pop_image_acq.ImgInfos.Sy);
         end;
         Freemem(pop_image_acq.DataDouble,4*pop_image_acq.ImgInfos.Nbplans);
         end;
      if (pop_image_acq <> nil) and (pop_image_acq.DataInt<>nil) then
         begin
         for k:=1 to pop_image_acq.ImgInfos.Nbplans do
            begin
            for i:=1 to pop_image_acq.ImgInfos.Sy do Freemem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
            Freemem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
            end;
         Freemem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
         end;

      pop_image_acq.ImgInfos.min[1]:=0;
      pop_image_acq.ImgInfos.max[1]:=0;
      pop_image_acq.ImgInfos.TypeData:=Camera.GetTypeData;
      pop_image_acq.ImgInfos.Nbplans:=Camera.GetNbPlans;

      TpsInt:=Round(MyStrToFloat(exp_b2.Text)*1000);

      pop_image_acq.ImgInfos.Sx:=(x2-x1+1);
      pop_image_acq.ImgInfos.Sy:=(y2-y1+1);

      if Config.MirrorX then
         begin
         x1:=Camera.GetXSize-x1+1;
         x2:=Camera.GetXSize-x2+1;
         end;
      if Config.MirrorY then
         begin
         y1:=Camera.GetYSize-y1+1;
         y2:=Camera.GetYSize-y2+1;
         end;

      Getmem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
          Getmem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
          for i:=1 to pop_image_acq.ImgInfos.Sy do Getmem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
      end;
      NbInterValCourant:=0;
      NbIntervalPose:=Round(TpsInt/Intervalle);

      Camera.SetWindow(Round(ax*x1+bx),Round(ay*y1+by),Round(ax*x2+bx),Round(ay*y2+by));
      WriteSpy(Camera.GetName+lang(' Fenêtre : (')+IntToStr(Round(ax*x1+bx))+','+IntToStr(Round(ay*y1+by))+lang(')/(')+
         IntToStr(Round(ax*x2+bx))+','+IntToStr(Round(ay*y2+by))+')');
      Camera.SetBinning(2);
      WriteSpy(Camera.GetName+lang(' Binning : 2'));      
      Camera.SetPose(MyStrToFloat(exp_b2.Text));
      WriteSpy(Camera.GetName+lang(' Temps de pose : ')+exp_b2.Text+
         lang(' s'));      
      if ShutterClosedCamera then
         if Camera.HasAShutter then Camera.SetShutterClosed;
      WriteSpy(lang('Début de la pose sur la caméra principale'));
      if Assigned(pop_track) then pop_track.AddMessage(lang('Début de la pose sur la caméra principale'));
      Resultat:=Camera.StartPose;
      EventEndPose.ResetEvent;      

      if Config.TelescopeBranche then
         if Config.GoodPos then
            begin
            AlphaAcq:=Config.AlphaScope;
            DeltaAcq:=Config.DeltaScope;
            end
         else
            begin
            WriteSpy(lang('Le télescope ne veut pas donner sa position'));
            pop_Main.AfficheMessage(lang('Erreur'),
               lang('Le télescope ne veut pas donner sa position'));
            end;
      
      if Resultat then
         begin
         // Pendant la pose, on ne lit pas la température pour pas ralentir le timer
         TimerTemp.Enabled:=False;
//         TimerPose2.Enabled:=True;
         ThreadPose2:=TThreadPose2.Create;         
         StopPose:=False;
         end;
      end
   else
      begin
      pop_main.SeuilsEnable;
      pop_image_acq.AcqRunning:=False;
      panel1.caption:=lang('Stop');
      cb_bouclage.Checked:=False;
      Stop1.Visible:=False;
      outAcqB1.Visible:=True;
      Stop2.Visible:=False;
      outAcqB2.Visible:=True;
      Stop4.Visible:=False;
      outAcqB4.Visible:=True;
      Progress.Position:=0;
      EventEndAcq.SetEvent;
//      SetEvent(EventEndAcq);
      end;

   except
   pop_main.SeuilsEnable;
   pop_image_acq.AcqRunning:=False;
   panel1.caption:=lang('Stop');
   cb_bouclage.Checked:=False;
   Stop1.Visible:=False;
   outAcqB1.Visible:=True;
   Stop2.Visible:=False;
   outAcqB2.Visible:=True;
   Stop4.Visible:=False;
   outAcqB4.Visible:=True;
//   TimerPose2.enabled:=False;
   ThreadPose2.Terminate;
   TimerInter2.Enabled:=False;
   end;
end;

// temperature
procedure tpop_camera.TimerTempTimer(Sender: TObject);
var
   Temperature:Double;
begin
   try
   if not Config.InPopConf then
      if Config.CameraBranchee then
         if Camera.HasTemperature then
            begin
            Temperature:=Camera.GetTemperature;
            panel6.Caption:=FloatToStr(Round(Temperature*10)/10);
            end;
   except
   Config.CameraBranchee:=False;
   pop_main.UpdateGUICamera;
   end;
end;

function Tpop_camera.Acquisition(x1,y1,x2,y2:Integer;
                                 Pose:Double;
                                 Bin:Integer;
                                 ShutterClosed:Boolean):Boolean;
var
   i,j,k,PosEsp:Integer;
   InterI:SmallInt;
   InterP:Pointer;
   Resultat:Boolean;
   Line:string;
   AMin,Mediane,AMax,Moy,Ecart:double;
begin
   Result:=True;
   PoseEnCours:=True;

   if Camera.Is16Bits and (pop_image_acq<>nil) and (pop_image_acq.DataDouble<>nil) then
      begin
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
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
   pop_image_acq.ImgInfos.BScale:=1;
   pop_image_acq.ImgInfos.BZero:=0;
   pop_image_acq.ImgInfos.TypeData:=Camera.GetTypeData;
   pop_image_acq.ImgInfos.Nbplans:=Camera.GetNbPlans;

   if Pose<Camera.GetMinimalPose then begin
      Pose:=Camera.GetMinimalPose;
   end;
   TpsInt:=Round(Pose*1000);

   pop_image_acq.ImgInfos.Sx:=(x2-x1+1) div Bin;
   pop_image_acq.ImgInfos.Sy:=(y2-y1+1) div Bin;

   if Config.MirrorX then
      begin
      x1:=Camera.GetXSize-x1+1;
      x2:=Camera.GetXSize-x2+1;
      end;
   if Config.MirrorY then
      begin
      y1:=Camera.GetYSize-y1+1;
      y2:=Camera.GetYSize-y2+1;
      end;

   Getmem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
   for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
     Getmem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
     for i:=1 to pop_image_acq.ImgInfos.Sy do Getmem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
   end;
   NbInterValCourant:=0;
// Pourquoi le -2 ?????
//   NbIntervalPose:=Round(TpsInt/Intervalle-2);
   NbIntervalPose:=Round(TpsInt/Intervalle);

   Camera.SetWindow(x1,y1,x2,y2);
   if Config.Verbose then WriteSpy(Camera.GetName+lang(' Fenêtre : (')+IntToStr(x1)+','+IntToStr(y1)+lang(')/(')+
      IntToStr(x2)+','+IntToStr(y2)+')');
   Camera.SetBinning(Bin);
   if Config.Verbose then WriteSpy(Camera.GetName+lang(' Binning : ')+IntToStr(Bin));
   Camera.SetPose(Pose);
   if Config.Verbose then WriteSpy(Camera.GetName+lang(' Temps de pose : ')+MyFloatToStr(Pose,3)+
      lang(' s'));
   ShutterClosedCamera:=ShutterClosed;
   if ShutterClosed then
      if Camera.HasAShutter then Camera.SetShutterClosed;
   if Config.Verbose then WriteSpy(lang('Début de la pose sur la caméra principale'));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Début de la pose sur la caméra principale'));      
   Resultat:=Camera.StartPose;
   EventEndPose.ResetEvent;   

   if Config.GoodPos then
      begin
      AlphaAcq:=Config.AlphaScope;
      DeltaAcq:=Config.DeltaScope;
      end
   else
      begin
      WriteSpy(lang('Le télescope ne veut pas donner sa position'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope ne veut pas donner sa position'));
      end;

   if Resultat then
      begin
      // Pendant la pose, on ne lit pas la température pour pas ralentir le timer
      TimerTemp.Enabled:=False;
//      TimerPose.Enabled:=True;
      ThreadPose:=TThreadPose.Create;
      while PoseEnCours do Application.ProcessMessages; // Pas terrible car bloque le PC !!!!

      // On lit le température à nouveau
      TimerTemp.Enabled:=True;
      // On remet à 0 pour pouvoir continuer le guidage
      NbIntervalPose:=0;
      if ShutterClosed then
         if Camera.HasAShutter then Camera.SetShutterSynchro;

   if config.MirrorX then
      if Camera.Is16Bits then
         MiroirHorizontal(pop_image_acq.DataInt,pop_image_acq.DataDouble,5,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy)
      else
         MiroirHorizontal(pop_image_acq.DataInt,pop_image_acq.DataDouble,2,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   if config.MirrorY then
      if Camera.Is16Bits then
         MiroirVertical(pop_image_acq.DataInt,pop_image_acq.DataDouble,5,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy)
      else
         MiroirVertical(pop_image_acq.DataInt,pop_image_acq.DataDouble,2,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);

{      if config.MirrorX then
         for k:=1 to pop_image_acq.ImgInfos.Nbplans do
            for j:=1 to pop_image_acq.ImgInfos.Sy do
               for i:=1 to pop_image_acq.ImgInfos.Sx div 2 do
                  begin
                  InterI:=pop_image_acq.DataInt^[k]^[j]^[i];
                  pop_image_acq.DataInt^[k]^[j]^[i]:=pop_image_acq.DataInt^[k]^[j]^[pop_image_acq.ImgInfos.Sx-i+1];
                  pop_image_acq.DataInt^[k]^[j]^[pop_image_acq.ImgInfos.Sx-i+1]:=InterI;
                  end;
      if config.MirrorY then
         for k:=1 to pop_image_acq.ImgInfos.Nbplans do
            for j:=1 to pop_image_acq.ImgInfos.Sx do
               for i:=1 to pop_image_acq.ImgInfos.Sy div 2 do
                  begin
                  InterI:=pop_image_acq.DataInt^[k]^[i]^[j];
                  pop_image_acq.DataInt^[k]^[i]^[j]:=pop_image_acq.DataInt^[k]^[pop_image_acq.ImgInfos.Sy-i+1]^[j];
                  pop_image_acq.DataInt^[k]^[pop_image_acq.ImgInfos.Sy-i+1]^[j]:=InterI;
                  end;}

//      Camera.GetCCDDateBegin(YearBegin,MonthBegin,DayBegin);
//      Camera.GetCCDTimeBegin(HourBegin,MinBegin,SecBegin,MSecBegin);
//      Camera.GetCCDDateEnd(YearEnd,MonthEnd,DayEnd);
//      Camera.GetCCDTimeEnd(HourEnd,MinEnd,SecEnd,MSecEnd);
//      TimeBegin:=EncodeDate(YearBegin,MonthBegin,DayBegin)+EncodeTime(HourBegin,MinBegin,SecBegin,MSecBegin);
//      TimeEnd:=EncodeDate(YearEnd,MonthEnd,DayEnd)+EncodeTime(HourEnd,MinEnd,SecEnd,MSecEnd);
                  
      // Remplissage du ImgInfos
      InitImgInfos(pop_image_acq.ImgInfos);
      pop_image_acq.ImgInfos.TempsPose:=Round((TimeEnd-TimeBegin)*24*3600*1000);
      pop_image_acq.ImgInfos.DateTime:=TimeBegin+(TimeEnd-TimeBegin)/2;
      pop_image_acq.ImgInfos.BinningX:=Bin;
      pop_image_acq.ImgInfos.BinningY:=Bin;
      pop_image_acq.ImgInfos.MiroirX:=config.MirrorX;
      pop_image_acq.ImgInfos.MiroirY:=config.MirrorY;
      pop_image_acq.ImgInfos.Telescope:=config.Telescope;
      pop_image_acq.ImgInfos.Observateur:=config.Observateur;
      pop_image_acq.ImgInfos.Camera:=Camera.GetName;
      if Config.UseCFW8 then
         begin
         if RadioButton1.Checked then pop_image_acq.ImgInfos.Filtre:=RadioButton1.Caption;
         if RadioButton2.Checked then pop_image_acq.ImgInfos.Filtre:=RadioButton2.Caption;
         if RadioButton3.Checked then pop_image_acq.ImgInfos.Filtre:=RadioButton3.Caption;
         if RadioButton4.Checked then pop_image_acq.ImgInfos.Filtre:=RadioButton4.Caption;
         if RadioButton5.Checked then pop_image_acq.ImgInfos.Filtre:=RadioButton5.Caption;
         end
      else pop_image_acq.ImgInfos.Filtre:=config.Filtre;
      pop_image_acq.ImgInfos.Observatoire:=config.Observatoire;
      pop_image_acq.ImgInfos.Lat:=Config.Lat;
      pop_image_acq.ImgInfos.Long:=Config.Long;
      pop_image_acq.ImgInfos.Focale:=config.FocaleTele;
      pop_image_acq.ImgInfos.Diametre:=config.Diametre;
      pop_image_acq.ImgInfos.OrientationCCD:=config.OrientationCCD;
      pop_image_acq.ImgInfos.Seeing:=Config.Seeing;
      if Config.SuiviEnCours and (pop_track<>nil) then
         begin
         Line:=pop_track.Panel17.Caption;
         PosEsp:=Pos(' ',Line);
         Line:=Copy(Line,1,PosEsp-1);
         pop_image_acq.ImgInfos.RMSGuideError:=MyStrToFloat(Line);
         end;
      pop_image_acq.ImgInfos.BScale:=1;
      pop_image_acq.ImgInfos.BZero:=0;
      try
      if Panel6.Caption<>lang('Inconnue') then pop_image_acq.ImgInfos.TemperatureCCD:=MyStrToFloat(Panel6.Caption)
                                          else pop_image_acq.ImgInfos.TemperatureCCD:=999;
      except
      pop_image_acq.ImgInfos.TemperatureCCD:=999;
      end;

      pop_image_acq.ImgInfos.Alpha:=AlphaAcq;
      pop_image_acq.ImgInfos.Delta:=DeltaAcq;

      pop_image_acq.ImgInfos.PixX:=Camera.GetXPixelSize;
      pop_image_acq.ImgInfos.PixY:=Camera.GetYPixelSize;
      pop_image_acq.ImgInfos.X1:=x1;
      pop_image_acq.ImgInfos.Y1:=y1;
      pop_image_acq.ImgInfos.X2:=x2;
      pop_image_acq.ImgInfos.Y2:=y2;

      if Checkbox1.Checked then
         begin
         Statistiques(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos.TypeData,1,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,1,aMin,Mediane,aMax,Moy,Ecart);
         update_stats(pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy,amin,mediane,amax,moy,ecart);
         end
      else memo_stats.lines.clear;
      end
   else
      begin
      Config.CameraBranchee:=False;
      pop_main.UpdateGUICamera;
      end;

   Result:=Resultat;
end;

procedure Tpop_camera.TimerInterTimer(Sender: TObject);
begin
   // Si le timer est pas actif on sort de suite
   if not TimerInter.Enabled then Exit;
   // On libere le Thread du timer haute resolution
//   TimerPose.Enabled:=False;
   ThreadPose.Terminate;
   // On arrete ce timer
   TimerInter.Enabled:=False;

//   Progress.Position:=0;
   Panel1.Caption:=lang('Lecture');
   if pop_builder<>nil then pop_builder.temps_de_pose.text:=lang('Lecture');
   Panel1.Update;

   Stop1.Enabled:=False;
   Stop2.Enabled:=False;
   Stop4.Enabled:=False;
   outAcqB1.Enabled:=False;
   outAcqB2.Enabled:=False;
   outAcqB4.Enabled:=False;
   try
   try
   EventEndPose.SetEvent;
   Camera.ReadCCD(pop_image_acq.DataInt,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   if Camera.Is16Bits then
      begin
      pop_image_acq.ImgInfos.BZero:=32768;
      ConvertFITSIntToReal(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos);
      end;
   except
   Config.CameraBranchee:=False;
   pop_main.UpdateGUICamera;
   end;
   finally
   Stop1.Enabled:=True;
   Stop2.Enabled:=True;
   Stop4.Enabled:=True;
   outAcqB1.Enabled:=True;
   outAcqB2.Enabled:=True;
   outAcqB4.Enabled:=True;
   end;

   Camera.GetCCDDateBegin(YearBegin,MonthBegin,DayBegin);
   Camera.GetCCDTimeBegin(HourBegin,MinBegin,SecBegin,MSecBegin);
   Camera.GetCCDDateEnd(YearEnd,MonthEnd,DayEnd);
   Camera.GetCCDTimeEnd(HourEnd,MinEnd,SecEnd,MSecEnd);
   try
   TimeBegin:=EncodeDate(YearBegin,MonthBegin,DayBegin)+EncodeTime(HourBegin,MinBegin,SecBegin,MSecBegin);
   TimeEnd:=EncodeDate(YearEnd,MonthEnd,DayEnd)+EncodeTime(HourEnd,MinEnd,SecEnd,MSecEnd);
   except
   if Config.Verbose then
      begin
      WriteSpy(lang('Begin Annee = ')+IntToSTr(YearBegin)); //nolang
      WriteSpy(lang('Begin Mois = ')+IntToSTr(MonthBegin)); //nolang
      WriteSpy(lang('Begin Jours = ')+IntToSTr(DayBegin)); //nolang
      WriteSpy(lang('Begin Heure = ')+IntToSTr(HourBegin)); //nolang
      WriteSpy(lang('Begin Minutes = ')+IntToSTr(MinBegin)); //nolang
      WriteSpy(lang('Begin Secondes = ')+IntToSTr(SecBegin)); //nolang
      WriteSpy(lang('Begin MilliSecondes = ')+IntToSTr(MSecBegin)); //nolang

      WriteSpy(lang('End Annee = ')+IntToSTr(YearEnd)); //nolang
      WriteSpy(lang('End Mois = ')+IntToSTr(MonthEnd)); //nolang
      WriteSpy(lang('End Jours = ')+IntToSTr(DayEnd)); //nolang
      WriteSpy(lang('End Heure = ')+IntToSTr(HourEnd)); //nolang
      WriteSpy(lang('End Minutes = ')+IntToSTr(MinEnd)); //nolang
      WriteSpy(lang('End Secondes = ')+IntToSTr(SecEnd)); //nolang
      WriteSpy(lang('End MilliSecondes = ')+IntToSTr(MSecEnd)); //nolang
      end;
   end;

   // On met a jour le temps de pose avec le temps de pose reel mesuré !
   pop_image_acq.ImgInfos.TempsPose:=Round((TimeEnd-TimeBegin)*24*3600*1000);
   // On met a jour le temps de milieu de pose avec le temps de pose reel mesuré !
   pop_image_acq.ImgInfos.DateTime:=TimeBegin+(TimeEnd-TimeBegin)/2;

   if pop_builder<>nil then pop_builder.temps_de_pose.text:='';

   Panel1.Caption:=lang('Stop');

   PoseEnCours:=False;
end;

function Tpop_camera.AcqMaximum(var x,y:Integer):Boolean;
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
   if pop_camera.pop_image_acq=nil then
      begin
      pop_camera.pop_image_acq:=tpop_image.Create(Application);
      pop_camera.pop_image_acq.IsUsedForTrack:=True;
      pop_image_acq.ImgInfos.BZero:=0;
      pop_image_acq.ImgInfos.BScale:=1;
      end;
   pop_camera.pop_image_acq.AcqRunning:=True;
   if Acquisition(1,1,Camera.GetXSize,Camera.GetYSize,Tps,1,False) then
      begin
      GetMax(pop_camera.pop_image_acq.dataInt,pop_camera.pop_image_acq.dataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData
         ,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,x,y,Valeur);

      WriteSpy(lang('AcqMaximum : Position de l''étoile ')+IntToStr(x)+'/'+IntToStr(y)
         +'/'+Format('%0.3f',[Valeur])); //nolang
      pop_image_acq.AjusteFenetre;   
      pop_camera.pop_image_acq.VisuAutoEtoiles;
      Result:=True;
      end;

   pop_camera.pop_image_acq.AcqRunning:=False;

end;

{function Tpop_camera.AcqMaximum(var x,y:Integer):Boolean;
var
Tps:Double;
Valeur:Double;
SMin,Mediane,SMax:Smallint;
Moy,Ecart:Double;
ImgNil:PTabImgDouble;
LocalBinning:Byte;
begin
   if Camera.IsAValidBinning(4) then LocalBinning:=4 else LocalBinning:=3;

   Result:=False;

   WriteSpy(lang('AcqMaximum : Recherche de la position de l''étoile'));
   Tps:=1;
   if pop_image_acq=nil then
      begin
      pop_image_acq:=tpop_image.Create(Application);
      pop_image_acq.IsUsedForAcq:=True;
      end;
   pop_image_acq.AcqRunning:=True;
   if Acquisition(1,1,Camera.GetXSize,Camera.GetYSize,Tps,LocalBinning,False) then
      begin
      Getmax(pop_image_acq.DataInt,ImgNil,2,pop_image_acq.ImgInfos.Sx,
             pop_image_acq.ImgInfos.Sy,x,y,Valeur);
      WriteSpy(lang('AcqMaximum : Position de l''étoile ')+IntToStr(x)+'/'+IntToStr(y)
         +'/'+Format('%0.3f',[Valeur])); //nolang
      pop_image_acq.AjusteFenetre;      
      pop_image_acq.VisuAutoEtoiles;
      Result:=True;
      end;
   pop_image_acq.AcqRunning:=False;
end;}

function Tpop_camera.AcqMaximumBinning(var x,y:Integer):Boolean;
var
   Tps:Double;
   Valeur:Double;
   SMin,Mediane,SMax:Smallint;
   Moy,Ecart:Double;
   ImgNil:PTabImgDouble;
   LocalBinning:Byte;
begin
   if Camera.IsAValidBinning(4) then LocalBinning:=4 else LocalBinning:=3;

   Result:=False;

   WriteSpy(lang('AcqMaximumBinning : Recherche de la position de l''étoile'));
   Tps:=1;
   if pop_camera.pop_image_acq=nil then
      begin
      pop_camera.pop_image_acq:=tpop_image.Create(Application);
      pop_camera.pop_image_acq.IsUsedForTrack:=True;
      pop_image_acq.ImgInfos.BZero:=0;
      pop_image_acq.ImgInfos.BScale:=1;
      end;
   pop_camera.pop_image_acq.AcqRunning:=True;
   if Acquisition(1,1,Camera.GetXSize,Camera.GetYSize,Tps,LocalBinning,False) then
      begin
      GetMax(pop_camera.pop_image_acq.dataInt,pop_camera.pop_image_acq.dataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData
         ,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,x,y,Valeur);

      WriteSpy(lang('AcqMaximumBinning : Position de l''étoile ')+IntToStr(x)+'/'+IntToStr(y)
         +'/'+Format('%0.3f',[Valeur])); //nolang
      pop_image_acq.AjusteFenetre;      
      pop_camera.pop_image_acq.VisuAutoEtoiles;
      Result:=True;
      end;
   pop_camera.pop_image_acq.AcqRunning:=False;
end;

procedure Tpop_camera.Button1Click(Sender: TObject);
var
   i,j,k,Sx,Sy:Integer;
   NbPlans:Byte;
   Rep:string;
begin
   Rep:=LowerCase(ExtractFilePath(Application.ExeName));

   Button2.Visible:=True;
   Button1.Visible:=False;

   NbImages:=0;

   // si l'image n'existe pas, on la cree
   if pop_image_acq=nil then
      begin
      pop_image_acq:=tpop_image.Create(Application);
      pop_image_acq.IsUsedForAcq:=True;
      pop_image_acq.ImgInfos.TypeData:=Camera.GetTypeData;
      pop_image_acq.ImgInfos.Nbplans:=Camera.GetNbPlans;
      end;

   x1:=StrToInt(win_x1.Text);
   x2:=StrToInt(win_x2.Text);
   y1:=StrToInt(win_y1.Text);
   y2:=StrToInt(win_y2.Text);
   if x1>Camera.GetXSize then x1:=Camera.GetXSize;
   if x2>Camera.GetXSize then x2:=Camera.GetXSize;
   if y1>Camera.GetYSize then y1:=Camera.GetYSize;
   if y2>Camera.GetYSize then y2:=Camera.GetYSize;
   if x1<1 then x1:=1;
   if x2<1 then x2:=1;
   if y1<1 then y1:=1;
   if y2<1 then y2:=1;

   Sx:=(x2-x1+1);
   Sy:=(y2-y1+1);

   NbPlans:=Camera.GetNbPlans;

   Getmem(DataInt,4*NbPlans);
   for k:=1 to Nbplans do begin
     Getmem(DataInt^[k],4*Sy);
     for i:=1 to Sy do Getmem(DataInt^[k]^[i],Sx*2);
     end;

   Fin:=False;
   while not Fin do
      begin
      Inc(NbImages);
      Label4.Caption:='Nombre d''images = '+IntToStr(NBImages);

      pop_camera.Acquisition(x1,y1,x2,y2,MyStrToFloat(pop_camera.exp_b1.Text),1,False);

      // Ca a bouge ?
      Somme:=0;
      for i:=1 to pop_camera.pop_image_acq.ImgInfos.Sx do
         for j:=1 to pop_camera.pop_image_acq.ImgInfos.Sy do
            Somme:=Somme+Abs(pop_camera.pop_image_acq.DataInt^[1]^[j]^[i]-DataInt^[1]^[j]^[i]);

      Label2.Caption:=lang('Luminosité = ')+MyFloatToStr(Somme,0);

      if (NbImages>10) then
         if (Somme>SommeSave*(1+SpinEdit2.Value/100)) or (Somme<SommeSave*(1-SpinEdit2.Value/100))  then
            begin
            Label3.Caption:=lang('Mouvement détecte !');
            NbDetecte:=SpinEdit1.Value;
            end
         else Label3.Caption:='Attente d''un mouvement';

      pop_image_acq.AjusteFenetre;         
      case config.SeuilCamera of
         0 : pop_image_acq.VisuAutoEtoiles;
         1 : pop_image_acq.VisuAutoPlanetes;
         2 : pop_image_acq.VisuAutoMinMax;
         3 : pop_image_acq.VisuMiniMaxi(config.SeuilBasFixe,config.SeuilHautFixe);
         end;

      if NbDetecte>0 then
         begin
         Dec(NbDetecte);
         pop_camera.pop_image_acq.SaveImage(config.RepImagesAcq+'\'+lang('Image')+IntToStr(NbImages));
         if Assigned(pop_track) then pop_track.AddMessage(lang('Sauvegarde de : '+
            lang('Image')+IntToStr(NbImages)));
         end;

      // Passage en reserve
      SommeSave:=Somme;
      for i:=1 to pop_camera.pop_image_acq.ImgInfos.Sx do
         for j:=1 to pop_camera.pop_image_acq.ImgInfos.Sy do
            DataInt^[1]^[j]^[i]:=pop_camera.pop_image_acq.DataInt^[1]^[j]^[i];

      if Fin then Exit;
      MySleep(Round(MyStrToFloat(NbreEdit1.Text)*1000));

      end;

end;

procedure Tpop_camera.Button2Click(Sender: TObject);
begin
Fin:=True;

Button2.Visible:=False;
Button1.Visible:=True;
end;

procedure Tpop_camera.FormCreate(Sender: TObject);
begin
EventEndAcq:=TEvent.Create(nil,True,FALSE,'');
EventEndPose:=TEvent.Create(nil,True,FALSE,'');
EventPose:=TEvent.Create(nil,True,FALSE,'');

Panel6.Caption:=lang('Inconnue')
//EventEndAcq:=CreateEvent(nil, False, False, nil);
//EventPose:=CreateEvent(nil, False, False, nil);
//EventEndPose:=CreateEvent(nil, False, False, nil);
end;

procedure Tpop_camera.FormClose(Sender: TObject; var Action: TCloseAction);
var
   Ini:TMemIniFile;
   Path:string;
begin
// Sauve la pos
Path:=ExtractFilePath(Application.Exename);
Ini:=TMemIniFile.Create(Path+lang('TeleAuto.ini')); //nolang
try
Ini.WriteString('WindowsPos','CCDTop',IntToStr(Top));
Ini.WriteString('WindowsPos','CCDLeft',IntToStr(Left));
Ini.WriteString('WindowsPos','CCDWidth',IntToStr(Width));
Ini.WriteString('WindowsPos','CCDHeight',IntToStr(Height));
finally
Ini.UpdateFile;
Ini.Free;
end;

// Surtout pas car c'est appele par la croix !
//if EventPose<>nil then
//   begin
//   EventPose.Free;
//   EventPose:=nil;
//   end;

Action:=caHide;
//CloseHandle(EventEndAcq);
//CloseHandle(EventPose);
//CloseHandle(EventEndPose); 
end;

procedure Tpop_camera.CheckBox2Click(Sender: TObject);
begin
GroupBox13.Enabled:=CheckBox2.Checked;
RadioButton1.Enabled:=CheckBox2.Checked;
RadioButton2.Enabled:=CheckBox2.Checked;
RadioButton3.Enabled:=CheckBox2.Checked;
RadioButton4.Enabled:=CheckBox2.Checked;
RadioButton5.Enabled:=CheckBox2.Checked;
config.UseCFW8:=CheckBox2.Checked;
end;

//****************************************************************************
//*******************************   scripts   ********************************
//****************************************************************************

procedure Tpop_camera.WaitEndAcq;
var
   Fin:Boolean;
//   MyWaitEndAcq:TMyWaitEndAcq;
begin
Fin:=False;
while not Fin do
   begin
   if EventEndAcq.WaitFor(0)<>wrTimeout then Fin:=True;
   Application.ProcessMessages;
   end;
//MyWaitEndAcq:=TMyWaitEndAcq.Create;
//MyWaitEndAcq.WaitFor;
//WaitForSingleObject(EventEndAcq,Infinite);
end;

procedure Tpop_camera.WaitEndPose;
var
   Fin:Boolean;
begin
Fin:=False;
while not Fin do
   begin
   if EventEndPose.WaitFor(0)<>wrTimeout then Fin:=True;
   Application.ProcessMessages;
   end;
end;

procedure Tpop_camera.StartB1;
begin
outAcqB1Click(Self);
end;

procedure Tpop_camera.StartB2;
begin
outAcqB2Click(Self);
end;

procedure Tpop_camera.StartB3;
begin
outAcqB4Click(Self);
end;

procedure Tpop_camera.SetPoseB1(Pose:Single);
begin
exp_b1.Text:=MyFloatToStr(Pose,2);
end;

procedure Tpop_camera.SetPoseB2(Pose:Single);
begin
exp_b2.Text:=MyFloatToStr(Pose,2);
end;

procedure Tpop_camera.SetPoseB3(Pose:Single);
begin
exp_b4.Text:=MyFloatToStr(Pose,2);
end;

procedure Tpop_camera.SetLoopNb(Nb:Integer);
begin
Nb_Bouclage.Value:=Nb;
end;

procedure Tpop_camera.SetStartIndex(Nb:Integer);
begin
Index.Value:=Nb;
end;

procedure Tpop_camera.SetImgName(Name:string);
begin
img_name.Text:=Name;
end;

procedure Tpop_camera.SetLoopOn;
begin
cb_Bouclage.Checked:=True;
end;

procedure Tpop_camera.SetLoopOff;
begin
cb_Bouclage.Checked:=False;
end;

procedure Tpop_camera.SetAutoSaveOn;
begin
cb_AutoSave.Checked:=True;
end;

procedure Tpop_camera.SetAutoSaveOff;
begin
cb_AutoSave.Checked:=False;
end;

procedure Tpop_camera.SetImgType(ImgType:Integer);
begin
RadioGroup1.ItemIndex:=ImgType-1;
end;

procedure Tpop_camera.SetWindow(x1,y1,x2,y2:Integer);
begin
win_x1.Text:=IntToStr(x1);
win_y1.Text:=IntToStr(y1);
win_x2.Text:=IntToStr(x2);
win_y2.Text:=IntToStr(y2);
end;

procedure Tpop_camera.InitWindow;
begin
SpeedButton1Click(Self);
end;

procedure Tpop_camera.SetStatOn;
begin
CheckBox1.Checked:=True;
end;

procedure Tpop_camera.SetStatOff;
begin
CheckBox1.Checked:=False;
end;

function Tpop_camera.SetFilter(FilterNb:Integer):Boolean;
var
   Error:Word;
begin
if (Config.TypeCamera=ST7) or (Config.TypeCamera=ST8) or (Config.TypeCamera=ST9)
   or (Config.TypeCamera=ST10) or (Config.TypeCamera=STTrack) then
   begin
   Error:=PutFilterSbig(FilterNb);
   Result:=Error<>0;
   end
else Result:=False;

case FilterNb of
   1:RadioButton1.Checked:=True;
   2:RadioButton2.Checked:=True;
   3:RadioButton3.Checked:=True;
   4:RadioButton4.Checked:=True;
   5:RadioButton5.Checked:=True;
   end;
end;

procedure Tpop_camera.StartWatch;
begin
Button1Click(Self);
end;

procedure Tpop_camera.SetWatchWait(Wait:Single);
begin
NbreEdit1.Text:=MyFloatToStr(Wait,2);
end;

procedure Tpop_camera.SetWatchImgNb(Nb:Integer);
begin
SpinEdit1.Text:=IntToStr(Nb);
end;

procedure Tpop_camera.SetWatchStart(Percent:Integer);
begin
SpinEdit2.Text:=IntToStr(Percent);
end;

procedure Tpop_camera.GetImg(var Img:Tpop_Image);
begin
Img:=pop_image_acq;
end;

procedure Tpop_camera.outAcqB1Click(Sender: TObject);
var
   AMin,Mediane,AMax,Moy,Ecart:double;
   i,j,k:integer;
   Alpha,Delta:Double;
   Rep:string;
   Resultat:Boolean;
begin
   EventEndAcq.ResetEvent;
//   ResetEvent(EventEndAcq);
   pop_scope.CheckBox3.Enabled:=False;
   pop_scope.Label8.Enabled:=False;

   StopPose:=False;
      
   Stop1.Visible:=True;
   outAcqB1.Visible:=False;
   Stop2.Visible:=True;
   outAcqB2.Visible:=False;
   Stop4.Visible:=True;
   outAcqB4.Visible:=False;

   // On attends un bon guidage
   // On le met a false et c'est au guidage de le remetre a true
   if Config.SuiviEnCours then
      begin
      Panel1.Caption:=lang('Attente');
      WriteSpy('Attente d''un bon guidage');
      if Assigned(pop_track) then pop_track.AddMessage(lang('Attente d''un bon guidage'));
      TrackGood:=False;
      while not(TrackGood) and Config.SuiviEnCours do
         begin
         Application.ProcessMessages;
         if StopPose then
            begin
            pop_scope.CheckBox3.Enabled:=True;
            pop_scope.Label8.Enabled:=True;
            Exit;
            end;
         end;
      if Config.SuiviEnCours then WriteSpy(lang('Le guidage est bon maintenant'));
      if Assigned(pop_track) then
         begin
         pop_track.AddMarque(HeureToJourJulien(GetHourDT),config.XMesure,config.YMesure);
         pop_track.RAZErreur;
         end;
      end;

   try
   CountBoucle:=1;
   x1:=StrToInt(win_x1.Text);
   x2:=StrToInt(win_x2.Text);
   y1:=StrToInt(win_y1.Text);
   y2:=StrToInt(win_y2.Text);
   if x1>Camera.GetXSize then x1:=Camera.GetXSize;
   if x2>Camera.GetXSize then x2:=Camera.GetXSize;
   if y1>Camera.GetYSize then y1:=Camera.GetYSize;
   if y2>Camera.GetYSize then y2:=Camera.GetYSize;
   if x1<1 then x1:=1;
   if x2<1 then x2:=1;
   if y1<1 then y1:=1;
   if y2<1 then y2:=1;

   // si l'image n'existe pas, on la cree
   if pop_image_acq=nil then
      begin
      pop_image_acq:=tpop_image.Create(Application);
      pop_image_acq.IsUsedForAcq:=True;
      pop_image_acq.ImgInfos.BZero:=0;
      pop_image_acq.ImgInfos.BScale:=1;
      end;

   Progress.Min:=0;
   Progress.Max:=Round(MyStrToFloat(exp_b1.text));
   Progress.Position:=0;

   pop_image_acq.AcqRunning:=True;
   if (RadioGroup1.ItemIndex=1) or (RadioGroup1.ItemIndex=2) then
      ShutterClosedCamera:=True else ShutterClosedCamera:=False;

   PoseEnCours:=True;

   if Camera.Is16Bits and (pop_image_acq<>nil) and (pop_image_acq.DataDouble<>nil) then
      begin
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
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

   pop_image_acq.ImgInfos.TypeData:=Camera.GetTypeData;
   pop_image_acq.ImgInfos.Nbplans:=Camera.GetNbPlans;

   PoseCamera:=MyStrToFloat(exp_b1.Text);
   if PoseCamera<Camera.GetMinimalPose then
      begin
      PoseCamera:=Camera.GetMinimalPose;
      exp_b1.Text:=FloatToStr(PoseCamera);
      end;
   TpsInt:=Round(PoseCamera*1000);
   pop_image_acq.ImgInfos.Sx:=(x2-x1+1);
   pop_image_acq.ImgInfos.Sy:=(y2-y1+1);

   if Config.MirrorX then
      begin
      x1:=Camera.GetXSize-x1+1;
      x2:=Camera.GetXSize-x2+1;
      end;
   if Config.MirrorY then
      begin
      y1:=Camera.GetYSize-y1+1;
      y2:=Camera.GetYSize-y2+1;
      end;

//       Getmem(ImgInt,4*NbPlans);
//       for k:=1 to NbPlans do
//          begin
//          Getmem(ImgInt^[k],Sy*4);
//          for j:=1 to Sy do
//             begin
//             Getmem(ImgInt^[k]^[j],Sx*2);
//             FillChar(ImgInt^[k]^[j]^,Sx*2,0);
//             end;
//          end;

   Getmem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
   for k:=1 to pop_image_acq.ImgInfos.Nbplans do
      begin
      Getmem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
      for i:=1 to pop_image_acq.ImgInfos.Sy do Getmem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
      end;

   NbInterValCourant:=0;
// Pourquoi le -2 ?????
//   NbIntervalPose:=Round(TpsInt/TimerPose.Interval-2);
   NbIntervalPose:=Round(TpsInt/Intervalle);

   Camera.SetWindow(x1,y1,x2,y2);
   WriteSpy(Camera.GetName+lang(' Fenêtre : (')+IntToStr(x1)+','+IntToStr(y1)+lang(')/(')+
      IntToStr(x2)+','+IntToStr(y2)+')');
   Camera.SetBinning(1);
   WriteSpy(Camera.GetName+lang(' Binning : 1'));
   Camera.SetPose(PoseCamera);
   WriteSpy(Camera.GetName+lang(' Temps de pose : ')+MyFloatToStr(PoseCamera,3)+
      lang(' s'));
   if ShutterClosedCamera then
      if Camera.HasAShutter then Camera.SetShutterClosed;
   WriteSpy(lang('Début de la pose sur la caméra principale'));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Début de la pose sur la caméra principale'));
   Resultat:=Camera.StartPose;
   EventEndPose.ResetEvent;   

   if Config.TelescopeBranche then
      if Config.GoodPos then
         begin
         AlphaAcq:=Config.AlphaScope;
         DeltaAcq:=Config.DeltaScope;
         end
      else
         begin
         WriteSpy(lang('Le télescope ne veut pas donner sa position'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope ne veut pas donner sa position'));
         end;

   if Resultat then
      begin
      // Pendant la pose, on ne lit pas la température pour pas ralentir le timer
      TimerTemp.Enabled:=False;
//      TimerPose1.Enabled:=True;
      ThreadPose1:=TThreadPose1.Create;
      StopPose:=False;
      end;

   except
   pop_main.SeuilsEnable;
   pop_image_acq.AcqRunning:=False;
   panel1.caption:=lang('Stop');
   cb_bouclage.Checked:=False;
   Stop1.Visible:=False;
   outAcqB1.Visible:=True;
   Stop2.Visible:=False;
   outAcqB2.Visible:=True;
   Stop4.Visible:=False;
   outAcqB4.Visible:=True;
//   TimerPose1.enabled:=False;
   ThreadPose1.Terminate;
   end;
end;

procedure Tpop_camera.TimerInter1Timer(Sender: TObject);
var
   AMin,Mediane,AMax,Moy,Ecart:double;
   i,j,k,nbimage,ii,PosEsp:Integer;
   InterI:SmallInt;
   Rep:string;
   Alpha,Delta:Double;
   LocalBinning:Byte;
   ax,bx,ay,by:double;
   Resultat:boolean;
   Line:string;
begin
   // Si le timer est pas actif on sort de suite
   if not TimerInter1.Enabled then Exit;
   // On arrete ce timer
   TimerInter1.Enabled:=False;

   // On libere le Thread du timer haute resolution (on pouvait pas avant)
//   TimerPose1.Enabled:=False;
   ThreadPose1.Terminate;

   try

//   Progress.position:=0;
   Panel1.Caption:=lang('Lecture');
   if pop_builder<>nil then pop_builder.temps_de_pose.text:=lang('Lecture');
   Panel1.Update;

   Stop1.Enabled:=False;
   Stop2.Enabled:=False;
   Stop4.Enabled:=False;
   outAcqB1.Enabled:=False;
   outAcqB2.Enabled:=False;
   outAcqB4.Enabled:=False;
   try
   try
   EventEndPose.SetEvent;   
   Camera.ReadCCD(pop_image_acq.DataInt,pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   if Camera.Is16Bits then
      begin
      pop_image_acq.ImgInfos.BZero:=32768;
      ConvertFITSIntToReal(pop_image_acq.DataInt,pop_image_acq.DataDouble,pop_image_acq.ImgInfos);
      end;
   except
   Config.CameraBranchee:=False;
   pop_main.UpdateGUICamera;
   end;
   finally
   Stop1.Enabled:=True;
   Stop2.Enabled:=True;
   Stop4.Enabled:=True;
   outAcqB1.Enabled:=True;
   outAcqB2.Enabled:=True;
   outAcqB4.Enabled:=True;
   end;

   Camera.GetCCDDateBegin(YearBegin,MonthBegin,DayBegin);
   Camera.GetCCDTimeBegin(HourBegin,MinBegin,SecBegin,MSecBegin);
   Camera.GetCCDDateEnd(YearEnd,MonthEnd,DayEnd);
   Camera.GetCCDTimeEnd(HourEnd,MinEnd,SecEnd,MSecEnd);
   try
   TimeBegin:=EncodeDate(YearBegin,MonthBegin,DayBegin)+EncodeTime(HourBegin,MinBegin,SecBegin,MSecBegin);
   TimeEnd:=EncodeDate(YearEnd,MonthEnd,DayEnd)+EncodeTime(HourEnd,MinEnd,SecEnd,MSecEnd);
   except
   if Config.Verbose then
      begin
      WriteSpy(lang('Begin Annee = ')+IntToSTr(YearBegin)); //nolang
      WriteSpy(lang('Begin Mois = ')+IntToSTr(MonthBegin)); //nolang
      WriteSpy(lang('Begin Jours = ')+IntToSTr(DayBegin)); //nolang
      WriteSpy(lang('Begin Heure = ')+IntToSTr(HourBegin)); //nolang
      WriteSpy(lang('Begin Minutes = ')+IntToSTr(MinBegin)); //nolang
      WriteSpy(lang('Begin Secondes = ')+IntToSTr(SecBegin)); //nolang
      WriteSpy(lang('Begin MilliSecondes = ')+IntToSTr(MSecBegin)); //nolang

      WriteSpy(lang('End Annee = ')+IntToSTr(YearEnd)); //nolang
      WriteSpy(lang('End Mois = ')+IntToSTr(MonthEnd)); //nolang
      WriteSpy(lang('End Jours = ')+IntToSTr(DayEnd)); //nolang
      WriteSpy(lang('End Heure = ')+IntToSTr(HourEnd)); //nolang
      WriteSpy(lang('End Minutes = ')+IntToSTr(MinEnd)); //nolang
      WriteSpy(lang('End Secondes = ')+IntToSTr(SecEnd)); //nolang
      WriteSpy(lang('End MilliSecondes = ')+IntToSTr(MSecEnd)); //nolang
      end;
   end;

   if pop_builder<>nil then pop_builder.temps_de_pose.text:='';

   PoseEnCours:=False;
   // affichage du nombre total d'image
   Camera.AdjustIntervalePose(NbInterValCourant,nbimage,Intervalle);
   if nbimage>0 then Edit6.text:=inttostr(nbimage);
   // il faut que la nouvelle image soit active a la fin de la pose
   pop_image_acq.setfocus ; // rend le focus a l'image finale
   pop_main.LastChild:=pop_image_acq; //il faut un peu forcer les choses car onActivate n'est pas appeler si la fiche active precedente n'est pas un enfant MDI.

   // On lit le température à nouveau
   TimerTemp.Enabled:=True;
   
   if ShutterClosedCamera then
      if Camera.HasAShutter then Camera.SetShutterSynchro;

   if config.MirrorX then
      if Camera.Is16Bits then
         MiroirHorizontal(pop_image_acq.DataInt,pop_image_acq.DataDouble,5,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy)
      else
         MiroirHorizontal(pop_image_acq.DataInt,pop_image_acq.DataDouble,2,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);
   if config.MirrorY then
      if Camera.Is16Bits then
         MiroirVertical(pop_image_acq.DataInt,pop_image_acq.DataDouble,5,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy)
      else
         MiroirVertical(pop_image_acq.DataInt,pop_image_acq.DataDouble,2,pop_image_acq.ImgInfos.NBPlans,
            pop_image_acq.ImgInfos.Sx,pop_image_acq.ImgInfos.Sy);

{   if config.MirrorX then
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do
         for j:=1 to pop_image_acq.ImgInfos.Sy do
            for i:=1 to pop_image_acq.ImgInfos.Sx div 2 do
               begin
               InterI:=pop_image_acq.DataInt^[k]^[j]^[i];
               pop_image_acq.DataInt^[k]^[j]^[i]:=pop_image_acq.DataInt^[k]^[j]^[pop_image_acq.ImgInfos.Sx-i+1];
               pop_image_acq.DataInt^[k]^[j]^[pop_image_acq.ImgInfos.Sx-i+1]:=InterI;
               end;
   if config.MirrorY then
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
      ImgInfos.MiroirX:=config.MirrorX;
      ImgInfos.MiroirY:=config.MirrorY;
      ImgInfos.Telescope:=config.Telescope;
      ImgInfos.Observateur:=config.Observateur;
      ImgInfos.Camera:=Camera.GetName;
      if Config.UseCFW8 then
         begin
         if RadioButton1.Checked then ImgInfos.Filtre:=RadioButton1.Caption;
         if RadioButton2.Checked then ImgInfos.Filtre:=RadioButton2.Caption;
         if RadioButton3.Checked then ImgInfos.Filtre:=RadioButton3.Caption;
         if RadioButton4.Checked then ImgInfos.Filtre:=RadioButton4.Caption;
         if RadioButton5.Checked then ImgInfos.Filtre:=RadioButton5.Caption;
         end
      else ImgInfos.Filtre:=config.Filtre;
      ImgInfos.Observatoire:=config.Observatoire;
      ImgInfos.Lat:=Config.Lat;
      ImgInfos.Long:=Config.Long;
      ImgInfos.Focale:=config.FocaleTele;
      ImgInfos.Diametre:=config.Diametre;
      ImgInfos.OrientationCCD:=config.OrientationCCD;
      ImgInfos.Seeing:=Config.Seeing;
      if Config.SuiviEnCours and (pop_track<>nil) then
         begin
         Line:=pop_track.Panel17.Caption;
         PosEsp:=Pos(' ',Line);
         Line:=Copy(Line,1,PosEsp-1);
         ImgInfos.RMSGuideError:=MyStrToFloat(Line);
         end;
      ImgInfos.BScale:=1;
      ImgInfos.BZero:=0;
      try
      if Panel6.Caption<>lang('Inconnue') then ImgInfos.TemperatureCCD:=MyStrToFloat(Panel6.Caption)
                                          else ImgInfos.TemperatureCCD:=999;
      except
      ImgInfos.TemperatureCCD:=999;
      end;

      ImgInfos.Alpha:=AlphaAcq;
      ImgInfos.Delta:=DeltaAcq;

      ImgInfos.PixX:=Camera.GetXPixelSize;
      ImgInfos.PixY:=Camera.GetYPixelSize;
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
   case Config.SeuilCamera of
      0 : pop_image_acq.VisuAutoEtoiles;
      1 : pop_image_acq.VisuAutoPlanetes;
      2 : pop_image_acq.VisuAutoMinMax;
      3 : pop_image_acq.VisuMiniMaxi(config.SeuilBasFixe,config.SeuilHautFixe);
      end;

   if cb_autosave.Checked then
      begin
      case RadioGroup1.ItemIndex of
         0:Rep:=config.RepImagesAcq;
         1:Rep:=config.RepOffsets;
         2:Rep:=config.RepNoirs;
         3:Rep:=config.RepPlus;
         end;
      pop_image_acq.SaveImage(Rep+'\'+img_name.Text+IntToStr(index.Value));
      if Assigned(pop_track) then pop_track.AddMessage(lang('Sauvegarde de : '+img_name.Text+IntToStr(index.Value)));

      if not(cb_bouclage.Checked) then index.Value:=index.Value+1;
      end;

   if cb_bouclage.Checked then index.Value:=index.Value+1;
   if Config.TelescopeBranche and Telescope.StoreCoordinates then
      if RadioGroup1.ItemIndex=3 then
         begin
         if Config.GoodPos then
            begin
            Alpha:=Config.AlphaScope;
            Delta:=Config.DeltaScope;
            if not Telescope.Pointe(Alpha+0.01666666,Delta) then
               begin
               WriteSpy(lang('Le télescope ne veut pas pointer les coordonnées'));
               pop_Main.AfficheMessage(lang('Erreur'),
                   lang('Le télescope ne veut pas pointer les coordonnées'));
               end;
            if not Telescope.WaitPoint(Alpha+0.01666666,Delta) then
               begin
               WriteSpy('Le télescope n''est pas arrivé sur les coordonnées demandées');
               pop_Main.AfficheMessage(lang('Erreur'),
                  'Le télescope n''est pas arrivé sur les coordonnées demandées');
               end
            else if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
            end
         else
            begin
            WriteSpy(lang('Le télescope ne veut pas donner sa position'));
            pop_Main.AfficheMessage(lang('Erreur'),
               lang('Le télescope ne veut pas donner sa position'));
            end;
         end;

   // On remet à 0 pour pouvoir continuer le guidage
   NbIntervalPose:=0;

   // On recommence le bouclage
   if cb_Bouclage.Checked and (CountBoucle<nb_Bouclage.Value) and not(StopPose) then
      begin
      // On attends un bon guidage
      // si on est en guidage !
      if Config.SuiviEnCours then
         begin
         // On attends un peu
         MySleep(1000);
         // Decalage
         if Config.UseDecalages and (Config.NbDecalageSuivi<>0) then
            begin
            ii:=CountBoucle mod (Config.NbDecalageSuivi+1);
            if ii=0 then
               begin
               Config.xDeplaceSuivi:=0;
               Config.yDeplaceSuivi:=0;
               end
            else
               begin
               Config.xDeplaceSuivi:=Config.DecalageSuiviX^[ii];
               Config.yDeplaceSuivi:=Config.DecalageSuiviY^[ii];
               end;
            WriteSpy(lang('Decalage X =')+MyFloatToStr(Config.xDeplaceSuivi,2));
            if Assigned(pop_track) then pop_track.AddMessage(lang('Decalage X =')+MyFloatToStr(Config.xDeplaceSuivi,2));
            WriteSpy(lang('Decalage Y =')+MyFloatToStr(Config.yDeplaceSuivi,2));
            if Assigned(pop_track) then pop_track.AddMessage(lang('Decalage Y =')+MyFloatToStr(Config.yDeplaceSuivi,2));
            end;

         // On le met a false et c'est au guidage de le remetre a true
         if Config.SuiviEnCours then
            begin
            Panel1.Caption:=lang('Attente');
            WriteSpy('Attente d''un bon guidage');
            if Assigned(pop_track) then pop_track.AddMessage(lang('Attente d''un bon guidage'));
            TrackGood:=False;
            while not(TrackGood) and Config.SuiviEnCours do
               begin
               Application.ProcessMessages;
               if StopPose then
                  begin
                  pop_scope.CheckBox3.Enabled:=True;
                  pop_scope.Label8.Enabled:=True;
                  Exit;
                  end;
               pop_scope.CheckBox3.Enabled:=True;
               pop_scope.Label8.Enabled:=True;
               end;
            if Config.SuiviEnCours then WriteSpy(lang('Le guidage est bon maintenant'));
            if Assigned(pop_track) then
               begin
               pop_track.AddMarque(HeureToJourJulien(GetHourDT),config.XMesure,config.YMesure);
               pop_track.RAZErreur;
               end;
            end;
         end;

      Inc(CountBoucle);

      // On relance la pose
      // Copie de start / Pas genial / Changer plus tard
      Stop1.Visible:=True;
      outAcqB1.Visible:=False;
      Stop2.Visible:=True;
      outAcqB2.Visible:=False;
      Stop4.Visible:=True;
      outAcqB4.Visible:=False;
      x1:=StrToInt(win_x1.Text);
      x2:=StrToInt(win_x2.Text);
      y1:=StrToInt(win_y1.Text);
      y2:=StrToInt(win_y2.Text);
      if x1>Camera.GetXSize then x1:=Camera.GetXSize;
      if x2>Camera.GetXSize then x2:=Camera.GetXSize;
      if y1>Camera.GetYSize then y1:=Camera.GetYSize;
      if y2>Camera.GetYSize then y2:=Camera.GetYSize;
      if x1<1 then x1:=1;
      if x2<1 then x2:=1;
      if y1<1 then y1:=1;
      if y2<1 then y2:=1;

      Progress.Min:=0;
      Progress.Max:=round(MyStrToFloat(exp_b1.text));
      Progress.Position:=0;

      pop_image_acq.AcqRunning:=True;
      if (RadioGroup1.ItemIndex=1) or (RadioGroup1.ItemIndex=2) then
         ShutterClosedCamera:=True else ShutterClosedCamera:=False;

      PoseEnCours:=True;

      if Camera.Is16Bits and (pop_image_acq<>nil) and (pop_image_acq.DataDouble<>nil) then
         begin
         for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
            for i:=1 to pop_image_acq.ImgInfos.Sy do Freemem(pop_image_acq.DataDouble^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
            Freemem(pop_image_acq.DataDouble^[k],4*pop_image_acq.ImgInfos.Sy);
         end;
         Freemem(pop_image_acq.DataDouble,4*pop_image_acq.ImgInfos.Nbplans);
         end;
      if (pop_image_acq <> nil) and (pop_image_acq.DataInt<>nil) then
         begin
         for k:=1 to pop_image_acq.ImgInfos.Nbplans do
            begin
            for i:=1 to pop_image_acq.ImgInfos.Sy do Freemem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
            Freemem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
            end;
         Freemem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
         end;

      pop_image_acq.ImgInfos.min[1]:=0;
      pop_image_acq.ImgInfos.max[1]:=0;
      pop_image_acq.ImgInfos.TypeData:=Camera.GetTypeData;
      pop_image_acq.ImgInfos.Nbplans:=Camera.GetNbPlans;

      TpsInt:=Round(MyStrToFloat(exp_b1.Text)*1000);

      pop_image_acq.ImgInfos.Sx:=(x2-x1+1);
      pop_image_acq.ImgInfos.Sy:=(y2-y1+1);

      if Config.MirrorX then
         begin
         x1:=Camera.GetXSize-x1+1;
         x2:=Camera.GetXSize-x2+1;
         end;
      if Config.MirrorY then
         begin
         y1:=Camera.GetYSize-y1+1;
         y2:=Camera.GetYSize-y2+1;
         end;

      Getmem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do
         begin
         Getmem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
         for i:=1 to pop_image_acq.ImgInfos.Sy do Getmem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
         end;
         
      NbInterValCourant:=0;
      NbIntervalPose:=Round(TpsInt/Intervalle);

      Camera.SetWindow(x1,y1,x2,y2);
      WriteSpy(Camera.GetName+lang(' Fenêtre : (')+IntToStr(x1)+','+IntToStr(y1)+lang(')/(')+
         IntToStr(x2)+','+IntToStr(y2)+')');
      Camera.SetBinning(1);
      WriteSpy(Camera.GetName+lang(' Binning : 1'));      
      Camera.SetPose(MyStrToFloat(exp_b1.Text));
      WriteSpy(Camera.GetName+lang(' Temps de pose : ')+exp_b1.Text+
         lang(' s'));
      if ShutterClosedCamera then
         if Camera.HasAShutter then Camera.SetShutterClosed;
      WriteSpy(lang('Début de la pose sur la caméra principale'));
      if Assigned(pop_track) then pop_track.AddMessage(lang('Début de la pose sur la caméra principale'));
      Resultat:=Camera.StartPose;
      EventEndPose.ResetEvent;      

      if Config.TelescopeBranche then
         if Config.GoodPos then
            begin
            AlphaAcq:=Config.AlphaScope;
            DeltaAcq:=Config.DeltaScope;
            end
         else
            begin
            WriteSpy(lang('Le télescope ne veut pas donner sa position'));
            pop_Main.AfficheMessage(lang('Erreur'),
               lang('Le télescope ne veut pas donner sa position'));
            end;

      if Resultat then
         begin
         // Pendant la pose, on ne lit pas la température pour pas ralentir le timer
         TimerTemp.Enabled:=False;
//         TimerPose1.Enabled:=True;
         ThreadPose1:=TThreadPose1.Create;
         StopPose:=False;
         end;
      end
   else
      begin
      pop_main.SeuilsEnable;
      pop_image_acq.AcqRunning:=False;
      panel1.caption:=lang('Stop');
      cb_bouclage.Checked:=False;
      Stop1.Visible:=False;
      outAcqB1.Visible:=True;
      Stop2.Visible:=False;
      outAcqB2.Visible:=True;
      Stop4.Visible:=False;
      outAcqB4.Visible:=True;
      Progress.Position:=0;      
      EventEndAcq.SetEvent;
//      SetEvent(EventEndAcq);
      end;

   except
   pop_main.SeuilsEnable;
   pop_image_acq.AcqRunning:=False;
   panel1.caption:=lang('Stop');
   cb_bouclage.Checked:=False;
   Stop1.Visible:=False;
   outAcqB1.Visible:=True;
   Stop2.Visible:=False;
   outAcqB2.Visible:=True;
   Stop4.Visible:=False;
   outAcqB4.Visible:=True;
//   TimerPose1.enabled:=False;
   ThreadPose1.Terminate;
   TimerInter1.Enabled:=False;
   end;
end;

constructor TThreadPose.Create;
begin
inherited Create(True);
//Priority:=tpHighest;
Priority:=tpNormal;
//Priority:=tpLower;
FreeOnTerminate:=True;
Resume;
end;

procedure TThreadPose.AfficheInfos;
var
   NBImage:Integer;
begin
ProgressPos:=Pop_Camera.Progress.Max-Round((Pop_Camera.NbInterValPose-Pop_Camera.NbInterValCourant)
   *Intervalle/1000);
PoseStr:=FloatToStrF((Pop_Camera.NbInterValPose-Pop_Camera.NbInterValCourant)
   *Intervalle/1000,ffFixed,4,1);

// ajuste le temp de pose restant
Camera.AdjustIntervalePose(Pop_Camera.NbInterValCourant,NBImage,Intervalle);
if NBImage>0 then NBImageThread:=IntToStr(NBImage);

// on coupe l ampli pendant la pose et on rallume une seconde avant la pose
if ((Camera.CanCutAmpli) and (Camera.AmpliIsUsed) and (not camera.getamplistate)) and
   (Pop_Camera.nbintervalpose*Intervalle/1000>Camera.GetDelayToSwitchOffAmpli) and
   (Pop_Camera.nbintervalcourant*Intervalle/1000>(Pop_Camera.nbintervalpose*Intervalle/1000)-
    Camera.GetDelayToSwitchOnAmpli) then
   begin
   Camera.AmpliOn;
   Camera.SetAmpliStateTrue;
   PoseStr:=lang('Ampli on');
   end;

pop_Camera.Edit6.Text:=NBImageThread;
pop_Camera.Progress.Position:=ProgressPos;
pop_Camera.Panel1.Caption:=PoseStr;
end;

procedure TThreadPose.Execute;
begin
Fin:=False;
try
repeat
//if not(((Pop_Camera.NbInterValCourant>=Pop_Camera.NbInterValPose) and Camera.CanStopNow) or Pop_Camera.StopPose) then
if Pop_Camera.NbInterValCourant<Pop_Camera.NbInterValPose then
   begin
//   if WaitForSingleObject(Pop_Camera.EventPose, 100) = WAIT_TIMEOUT then
   if EventPose.WaitFor(Intervalle)=wrTimeout then
      begin
      Inc(Pop_Camera.NbInterValCourant);
      // Mega Important, ne pas enlever
      Application.ProcessMessages;
      Synchronize(AfficheInfos);
      end;
   end
else
   begin
   if not Fin then
      begin
      Pop_Camera.TimerInter.Enabled:=True;
      Application.ProcessMessages;
      Fin:=True;
      end;
   end;
//if Fin then WaitForSingleObject(Pop_Camera.EventPose,1000);
if Fin then EventPose.WaitFor(Intervalle);
Application.ProcessMessages;
until Terminated;
except
end;
end;

constructor TThreadPose1.Create;
begin
inherited Create(True);
//Priority:=tpHighest;
Priority:=tpNormal;
//Priority:=tpLower;
FreeOnTerminate:=True;
Resume;
end;

procedure TThreadPose1.AfficheInfos;
var
   NBImage:Integer;
begin
ProgressPos:=Pop_Camera.Progress.Max-Round((Pop_Camera.NbInterValPose-Pop_Camera.NbInterValCourant)
   *Intervalle/1000);
PoseStr:=FloatToStrF((Pop_Camera.NbInterValPose-Pop_Camera.NbInterValCourant)
   *Intervalle/1000,ffFixed,4,1);

// ajuste le temp de pose restant
Camera.AdjustIntervalePose(Pop_Camera.NbInterValCourant,NBImage,Intervalle);
if NBImage>0 then NBImageThread:=IntToStr(NBImage);

// on coupe l ampli pendant la pose et on rallume une seconde avant la pose
if ((Camera.CanCutAmpli) and (Camera.AmpliIsUsed) and (not camera.getamplistate)) and
   (Pop_Camera.nbintervalpose*Intervalle/1000>Camera.GetDelayToSwitchOffAmpli) and
   (Pop_Camera.nbintervalcourant*Intervalle/1000>(Pop_Camera.nbintervalpose*Intervalle/1000)-
    Camera.GetDelayToSwitchOnAmpli) then
   begin
   Camera.AmpliOn;
   Camera.SetAmpliStateTrue;
   PoseStr:=lang('Ampli on');
   end;

pop_Camera.Edit6.Text:=NBImageThread;
pop_Camera.Progress.Position:=ProgressPos;
pop_Camera.Panel1.Caption:=PoseStr;
end;

procedure TThreadPose1.Execute;
begin
Fin:=False;
try
repeat
//if not(((Pop_Camera.NbInterValCourant>=Pop_Camera.NbInterValPose) and Camera.CanStopNow) or Pop_Camera.StopPose) then
if Pop_Camera.NbInterValCourant<Pop_Camera.NbInterValPose then
   begin
//   if WaitForSingleObject(Pop_Camera.EventPose, 100) = WAIT_TIMEOUT then
   if EventPose.WaitFor(Intervalle)=wrTimeout then
      begin
      Inc(Pop_Camera.NbInterValCourant);
      // Mega Important, ne pas enlever
      Application.ProcessMessages;
      Synchronize(AfficheInfos);
      end;
   end
else
   begin
   if not Fin then
      begin
      Pop_Camera.TimerInter1.Enabled:=True;
      Application.ProcessMessages;
      Fin:=True;
      end;
   end;
//if Fin then WaitForSingleObject(Pop_Camera.EventPose,1000);
if Fin then EventPose.WaitFor(Intervalle);
Application.ProcessMessages;
until Terminated;
except
end;
end;

constructor TThreadPose2.Create;
begin
inherited Create(True);
//Priority:=tpHighest;
Priority:=tpNormal;
//Priority:=tpLower;
FreeOnTerminate:=True;
Resume;
end;

procedure TThreadPose2.AfficheInfos;
var
   NBImage:Integer;
begin
ProgressPos:=Pop_Camera.Progress.Max-Round((Pop_Camera.NbInterValPose-Pop_Camera.NbInterValCourant)
   *Intervalle/1000);
PoseStr:=FloatToStrF((Pop_Camera.NbInterValPose-Pop_Camera.NbInterValCourant)
   *Intervalle/1000,ffFixed,4,1);

// ajuste le temp de pose restant
Camera.AdjustIntervalePose(Pop_Camera.NbInterValCourant,NBImage,Intervalle);
if NBImage>0 then NBImageThread:=IntToStr(NBImage);

// on coupe l ampli pendant la pose et on rallume une seconde avant la pose
if ((Camera.CanCutAmpli) and (Camera.AmpliIsUsed) and (not camera.getamplistate)) and
   (Pop_Camera.nbintervalpose*Intervalle/1000>Camera.GetDelayToSwitchOffAmpli) and
   (Pop_Camera.nbintervalcourant*Intervalle/1000>(Pop_Camera.nbintervalpose*Intervalle/1000)-
    Camera.GetDelayToSwitchOnAmpli) then
   begin
   Camera.AmpliOn;
   Camera.SetAmpliStateTrue;
   PoseStr:=lang('Ampli on');
   end;

pop_Camera.Edit6.Text:=NBImageThread;
pop_Camera.Progress.Position:=ProgressPos;
pop_Camera.Panel1.Caption:=PoseStr;
end;

procedure TThreadPose2.Execute;
begin
Fin:=False;
try
repeat
//if not(((Pop_Camera.NbInterValCourant>=Pop_Camera.NbInterValPose) and Camera.CanStopNow) or Pop_Camera.StopPose) then
if Pop_Camera.NbInterValCourant<Pop_Camera.NbInterValPose then
   begin
//   if WaitForSingleObject(Pop_Camera.EventPose, Intervalle) = WAIT_TIMEOUT then
   if EventPose.WaitFor(Intervalle)=wrTimeout then
      begin
      Inc(Pop_Camera.NbInterValCourant);
      // Mega Important, ne pas enlever
      Application.ProcessMessages;
      Synchronize(AfficheInfos);
      end;
   end
else
   begin
   if not Fin then
      begin
      Pop_Camera.TimerInter2.Enabled:=True;
      Application.ProcessMessages;
      Fin:=True;
      end;
   end;
//if Fin then WaitForSingleObject(Pop_Camera.EventPose,1000);
if Fin then EventPose.WaitFor(Intervalle);
Application.ProcessMessages;
until Terminated;
except
end;
end;

constructor TThreadPose4.Create;
begin
inherited Create(True);
//Priority:=tpHighest;
Priority:=tpNormal;
//Priority:=tpLower;
FreeOnTerminate:=True;
Resume;
end;

procedure TThreadPose4.AfficheInfos;
var
   NBImage:Integer;
begin
ProgressPos:=Pop_Camera.Progress.Max-Round((Pop_Camera.NbInterValPose-Pop_Camera.NbInterValCourant)
   *Intervalle/1000);
PoseStr:=FloatToStrF((Pop_Camera.NbInterValPose-Pop_Camera.NbInterValCourant)
   *Intervalle/1000,ffFixed,4,1);

// ajuste le temp de pose restant
Camera.AdjustIntervalePose(Pop_Camera.NbInterValCourant,NBImage,Intervalle);
if NBImage>0 then NBImageThread:=IntToStr(NBImage);

// on coupe l ampli pendant la pose et on rallume une seconde avant la pose
if ((Camera.CanCutAmpli) and (Camera.AmpliIsUsed) and (not camera.getamplistate)) and
   (Pop_Camera.nbintervalpose*Intervalle/1000>Camera.GetDelayToSwitchOffAmpli) and
   (Pop_Camera.nbintervalcourant*Intervalle/1000>(Pop_Camera.nbintervalpose*Intervalle/1000)-
    Camera.GetDelayToSwitchOnAmpli) then
   begin
   Camera.AmpliOn;
   Camera.SetAmpliStateTrue;
   PoseStr:=lang('Ampli on');
   end;

pop_Camera.Edit6.Text:=NBImageThread;
pop_Camera.Progress.Position:=ProgressPos;
pop_Camera.Panel1.Caption:=PoseStr;
end;

procedure TThreadPose4.Execute;
begin
Fin:=False;
try
repeat
//if not(((Pop_Camera.NbInterValCourant>=Pop_Camera.NbInterValPose) and Camera.CanStopNow) or Pop_Camera.StopPose) then
if Pop_Camera.NbInterValCourant<Pop_Camera.NbInterValPose then
   begin
//   if WaitForSingleObject(Pop_Camera.EventPose, Intervalle) = WAIT_TIMEOUT then
   if EventPose.WaitFor(Intervalle)=wrTimeout then
      begin
      Inc(Pop_Camera.NbInterValCourant);
      // Mega Important, ne pas enlever
      Application.ProcessMessages;
      Synchronize(AfficheInfos);
      end;
   end
else
   begin
   if not Fin then
      begin
      Pop_Camera.TimerInter4.Enabled:=True;
      Application.ProcessMessages;
      Fin:=True;
      end;
   end;
//if Fin then WaitForSingleObject(Pop_Camera.EventPose,1000);
if Fin then EventPose.WaitFor(Intervalle);
Application.ProcessMessages;
until Terminated;
except
end;
end;

procedure Tpop_camera.RadioGroup12Click(Sender: TObject);
begin
if RadioGroup12.ItemIndex=3 then
   begin
   Panel3.Visible:=True;
   if pop_image_acq<>nil then
      begin
      NbreEdit24.Text:=MyFloatToStr(pop_image_acq.ImgInfos.Min[1],2);
      NbreEdit25.Text:=MyFloatToStr(pop_image_acq.ImgInfos.Max[1],2);
      end
   else
      begin
      NbreEdit24.Text:='0';
      NbreEdit25.Text:=MyFloatToStr(Camera.GetSaturationLevel,2);
      end
   end
else Panel3.Visible:=False;
Config.SeuilCamera:=RadioGroup12.ItemIndex;
Config.SeuilBasFixe:=MyStrtoFloat(NbreEdit24.Text);
Config.SeuilHautFixe:=MyStrtoFloat(NbreEdit25.Text);
end;

procedure Tpop_camera.NbreEdit24Change(Sender: TObject);
begin
if NbreEdit24.Text<>'' then
   Config.SeuilBasFixe:=MyStrToFloat(NbreEdit24.Text);
end;

procedure Tpop_camera.NbreEdit25Change(Sender: TObject);
begin
if NbreEdit25.Text<>'' then
   Config.SeuilHautFixe:=MyStrToFloat(NbreEdit25.Text);
end;

procedure Tpop_camera.SpeedButton2Click(Sender: TObject);
begin
if pop_image_acq<>nil then
   begin
   NbreEdit24.Text:=MyFloatToStr(pop_image_acq.ImgInfos.Min[1],2);
   NbreEdit25.Text:=MyFloatToStr(pop_image_acq.ImgInfos.Max[1],2);
   end
else
   begin
   NbreEdit24.Text:='0';
   NbreEdit25.Text:=MyFloatToStr(Camera.GetSaturationLevel,2);
   end;
Config.SeuilBasFixe:=MyStrtoFloat(NbreEdit24.Text);
Config.SeuilHautFixe:=MyStrtoFloat(NbreEdit25.Text);
end;

function Tpop_camera.AcquisitionAuto(x1,y1,x2,y2:Integer;
                                     Pose:Double;
                                     Bin:Integer;
                                     ShutterClosed:Boolean):Boolean;
var
   AMin,Mediane,AMax,Moy,Ecart:double;
   i,j,k:integer;
   Alpha,Delta:Double;
   Rep:string;
   Resultat:Boolean;
   ax,bx,ay,by:Double;
begin
   EventEndAcq.ResetEvent;
//   ResetEvent(EventEndAcq);
   pop_scope.CheckBox3.Enabled:=False;
   pop_scope.Label8.Enabled:=False;

   StopPose:=False;

   Stop1.Visible:=True;
   outAcqB1.Visible:=False;
   Stop2.Visible:=True;
   outAcqB2.Visible:=False;
   Stop4.Visible:=True;
   outAcqB4.Visible:=False;

   // On attends un bon guidage
   // On le met a false et c'est au guidage de le remetre a true
   if Config.SuiviEnCours then
      begin
      Panel1.Caption:=lang('Attente');
      WriteSpy('Attente d''un bon guidage');
      if Assigned(pop_track) then pop_track.AddMessage(lang('Attente d''un bon guidage'));
      TrackGood:=False;
      while not(TrackGood) and Config.SuiviEnCours do
         begin
         Application.ProcessMessages;
         if StopPose then
            begin
            pop_scope.CheckBox3.Enabled:=True;
            pop_scope.Label8.Enabled:=True;
            Exit;
            end;
         end;
      if Config.SuiviEnCours then WriteSpy(lang('Le guidage est bon maintenant'));
      if Assigned(pop_track) then
         begin
         pop_track.AddMarque(HeureToJourJulien(GetHourDT),config.XMesure,config.YMesure);
         pop_track.RAZErreur;
         end;
      end;

   try
   CountBoucle:=1;
//   x1:=StrToInt(win_x1.Text);
//   x2:=StrToInt(win_x2.Text);
//   y1:=StrToInt(win_y1.Text);
//   y2:=StrToInt(win_y2.Text);
   if x1>Camera.GetXSize div 2 then x1:=Camera.GetXSize div Bin;
   if x2>Camera.GetXSize div 2 then x2:=Camera.GetXSize div Bin;
   if y1>Camera.GetYSize div 2 then y1:=Camera.GetYSize div Bin;
   if y2>Camera.GetYSize div 2 then y2:=Camera.GetYSize div Bin;
//   if x1>Camera.GetXSize then x1:=Camera.GetXSize;
//   if x2>Camera.GetXSize then x2:=Camera.GetXSize;
//   if y1>Camera.GetYSize then y1:=Camera.GetYSize;
//   if y2>Camera.GetYSize then y2:=Camera.GetYSize;
   if x1<1 then x1:=1;
   if x2<1 then x2:=1;
   if y1<1 then y1:=1;
   if y2<1 then y2:=1;
   pop_camera.x1:=x1;
   pop_camera.y1:=y1;
   pop_camera.x2:=x2;
   pop_camera.y2:=y2;

   // y=ax+b
   ax:=(Camera.GetXSize-1)/((Camera.GetXSize div 2)-1);
   bx:=1-ax;
   ay:=(Camera.GetYSize-1)/((Camera.GetYSize div 2)-1);
   by:=1-ay;
   
   // si l'image n'existe pas, on la cree
   if pop_image_acq=nil then
      begin
      pop_image_acq:=tpop_image.Create(Application);
      pop_image_acq.IsUsedForAcq:=True;
      pop_image_acq.ImgInfos.BZero:=0;
      pop_image_acq.ImgInfos.BScale:=1;
      end;

   Progress.Min:=0;
   Progress.Max:=Round(Pose);
   Progress.Position:=0;

   pop_image_acq.AcqRunning:=True;

//   if (RadioGroup1.ItemIndex=1) or (RadioGroup1.ItemIndex=2) then
//      ShutterClosed:=True else ShutterClosed:=False;

   PoseEnCours:=True;

   if Camera.Is16Bits and (pop_image_acq<>nil) and (pop_image_acq.DataDouble<>nil) then
      begin
      for k:=1 to pop_image_acq.ImgInfos.Nbplans do begin
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

   pop_image_acq.ImgInfos.TypeData:=Camera.GetTypeData;
   pop_image_acq.ImgInfos.Nbplans:=Camera.GetNbPlans;

//   PoseCamera:=MyStrToFloat(exp_b1.Text);
   PoseCamera:=Pose;
   if PoseCamera<Camera.GetMinimalPose then
      begin
      PoseCamera:=Camera.GetMinimalPose;
      exp_b1.Text:=FloatToStr(PoseCamera);
      end;
   TpsInt:=Round(PoseCamera*1000);
   pop_image_acq.ImgInfos.Sx:=(x2-x1+1);
   pop_image_acq.ImgInfos.Sy:=(y2-y1+1);

   if Config.MirrorX then
      begin
      x1:=Camera.GetXSize-x1+1;
      x2:=Camera.GetXSize-x2+1;
      end;
   if Config.MirrorY then
      begin
      y1:=Camera.GetYSize-y1+1;
      y2:=Camera.GetYSize-y2+1;
      end;

//       Getmem(ImgInt,4*NbPlans);
//       for k:=1 to NbPlans do
//          begin
//          Getmem(ImgInt^[k],Sy*4);
//          for j:=1 to Sy do
//             begin
//             Getmem(ImgInt^[k]^[j],Sx*2);
//             FillChar(ImgInt^[k]^[j]^,Sx*2,0);
//             end;
//          end;

   Getmem(pop_image_acq.DataInt,4*pop_image_acq.ImgInfos.Nbplans);
   for k:=1 to pop_image_acq.ImgInfos.Nbplans do
      begin
      Getmem(pop_image_acq.DataInt^[k],4*pop_image_acq.ImgInfos.Sy);
      for i:=1 to pop_image_acq.ImgInfos.Sy do Getmem(pop_image_acq.DataInt^[k]^[i],pop_image_acq.ImgInfos.Sx*2);
      end;

   NbInterValCourant:=0;
// Pourquoi le -2 ?????
//   NbIntervalPose:=Round(TpsInt/TimerPose.Interval-2);
   NbIntervalPose:=Round(TpsInt/Intervalle);

   Camera.SetWindow(Round(ax*x1+bx),Round(ay*y1+by),Round(ax*x2+bx),Round(ay*y2+by));
   WriteSpy(Camera.GetName+lang(' Fenêtre : (')+IntToStr(Round(ax*x1+bx))+','+IntToStr(Round(ay*y1+by))+lang(')/(')+
      IntToStr(Round(ax*x2+bx))+','+IntToStr(Round(ay*y2+by))+')');
//   Camera.SetWindow(x1,y1,x2,y2);
//   WriteSpy(Camera.GetName+lang(' Fenêtre : (')+IntToStr(x1)+','+IntToStr(y1)+lang(')/(')+
//      IntToStr(x2)+','+IntToStr(y2)+')');
   Camera.SetBinning(Bin);
   WriteSpy(Camera.GetName+lang(' Binning : 1'));
   Camera.SetPose(PoseCamera);
   WriteSpy(Camera.GetName+lang(' Temps de pose : ')+MyFloatToStr(PoseCamera,3)+
      lang(' s'));
   ShutterClosedCamera:=False;
   if ShutterClosed then
      begin
      if Camera.HasAShutter then Camera.SetShutterClosed;
      ShutterClosedCamera:=True;
      end;

   WriteSpy(lang('Début de la pose sur la caméra principale'));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Début de la pose sur la caméra principale'));
   Resultat:=Camera.StartPose;
   EventEndPose.ResetEvent;

   if Config.TelescopeBranche then
      if Config.GoodPos then
         begin
         AlphaAcq:=Config.AlphaScope;
         DeltaAcq:=Config.DeltaScope;
         end
      else
         begin
         WriteSpy(lang('Le télescope ne veut pas donner sa position'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope ne veut pas donner sa position'));
         end;

   if Resultat then
      begin
      // Pendant la pose, on ne lit pas la température pour pas ralentir le timer
      TimerTemp.Enabled:=False;
//      TimerPose1.Enabled:=True;
      ThreadPoseAuto:=TThreadPoseAuto.Create;
      StopPose:=False;
      end;

   except
   pop_main.SeuilsEnable;
   pop_image_acq.AcqRunning:=False;
   panel1.caption:=lang('Stop');
   cb_bouclage.Checked:=False;
   Stop1.Visible:=False;
   outAcqB1.Visible:=True;
   Stop2.Visible:=False;
   outAcqB2.Visible:=True;
   Stop4.Visible:=False;
   outAcqB4.Visible:=True;
//   TimerPose1.enabled:=False;
   ThreadPose1.Terminate;
   end;
end;

constructor TThreadPoseAuto.Create;
begin
inherited Create(True);
//Priority:=tpHighest;
Priority:=tpNormal;
//Priority:=tpLower;
FreeOnTerminate:=True;
Resume;
end;

procedure TThreadPoseAuto.AfficheInfos;
var
   NBImage:Integer;
begin
ProgressPos:=Pop_Camera.Progress.Max-Round((Pop_Camera.NbInterValPose-Pop_Camera.NbInterValCourant)
   *Intervalle/1000);
PoseStr:=FloatToStrF((Pop_Camera.NbInterValPose-Pop_Camera.NbInterValCourant)
   *Intervalle/1000,ffFixed,4,1);

// ajuste le temp de pose restant
Camera.AdjustIntervalePose(Pop_Camera.NbInterValCourant,NBImage,Intervalle);
if NBImage>0 then NBImageThread:=IntToStr(NBImage);

// on coupe l ampli pendant la pose et on rallume une seconde avant la pose
if ((Camera.CanCutAmpli) and (Camera.AmpliIsUsed) and (not camera.getamplistate)) and
   (Pop_Camera.nbintervalpose*Intervalle/1000>Camera.GetDelayToSwitchOffAmpli) and
   (Pop_Camera.nbintervalcourant*Intervalle/1000>(Pop_Camera.nbintervalpose*Intervalle/1000)-
    Camera.GetDelayToSwitchOnAmpli) then
   begin
   Camera.AmpliOn;
   Camera.SetAmpliStateTrue;
   PoseStr:=lang('Ampli on');
   end;

pop_Camera.Edit6.Text:=NBImageThread;
pop_Camera.Progress.Position:=ProgressPos;
pop_Camera.Panel1.Caption:=PoseStr;
end;

procedure TThreadPoseAuto.Execute;
begin
Fin:=False;
try
repeat
//if not(((Pop_Camera.NbInterValCourant>=Pop_Camera.NbInterValPose) and Camera.CanStopNow) or Pop_Camera.StopPose) then
if Pop_Camera.NbInterValCourant<Pop_Camera.NbInterValPose then
   begin
//   if WaitForSingleObject(Pop_Camera.EventPose, 100) = WAIT_TIMEOUT then
   if EventPose.WaitFor(Intervalle)=wrTimeout then
      begin
      Inc(Pop_Camera.NbInterValCourant);
      // Mega Important, ne pas enlever
      Application.ProcessMessages;
      Synchronize(AfficheInfos);
      end;
   end
else
   begin
   if not Fin then
      begin
//      Pop_Camera.TimerInter1.Enabled:=True;
      ThreadReadAuto:=TThreadReadAuto.Create;
      Application.ProcessMessages;
      Fin:=True;
      end;
   end;
//if Fin then WaitForSingleObject(Pop_Camera.EventPose,1000);
if Fin then EventPose.WaitFor(Intervalle);
Application.ProcessMessages;
until Terminated;
except
end;
end;

constructor TThreadReadAuto.Create;
begin
inherited Create(True);
//Priority:=tpHighest;
Priority:=tpNormal;
//Priority:=tpLower;
FreeOnTerminate:=True;
Resume;
end;

procedure TThreadReadAuto.BeforeLecture;
begin
pop_camera.Panel1.Caption:=lang('Lecture');
pop_camera.Panel1.Update;
pop_camera.Stop1.Enabled:=False;
pop_camera.Stop2.Enabled:=False;
pop_camera.Stop4.Enabled:=False;
pop_camera.outAcqB1.Enabled:=False;
pop_camera.outAcqB2.Enabled:=False;
pop_camera.outAcqB4.Enabled:=False;
end;

procedure TThreadReadAuto.AfterLecture;
var
   Line:string;
   PosEsp:Integer;
   AMin,Mediane,AMax,Moy,Ecart:double;
begin
if Config.UseCFW8 then
   begin
   if pop_camera.RadioButton1.Checked then pop_camera.pop_image_acq.ImgInfos.Filtre:=pop_camera.RadioButton1.Caption;
   if pop_camera.RadioButton2.Checked then pop_camera.pop_image_acq.ImgInfos.Filtre:=pop_camera.RadioButton2.Caption;
   if pop_camera.RadioButton3.Checked then pop_camera.pop_image_acq.ImgInfos.Filtre:=pop_camera.RadioButton3.Caption;
   if pop_camera.RadioButton4.Checked then pop_camera.pop_image_acq.ImgInfos.Filtre:=pop_camera.RadioButton4.Caption;
   if pop_camera.RadioButton5.Checked then pop_camera.pop_image_acq.ImgInfos.Filtre:=pop_camera.RadioButton5.Caption;
   end
else pop_camera.pop_image_acq.ImgInfos.Filtre:=config.Filtre;

if nbimage>0 then pop_camera.Edit6.text:=inttostr(nbimage);
// il faut que la nouvelle image soit active a la fin de la pose
pop_camera.pop_image_acq.setfocus ; // rend le focus a l'image finale
if Config.SuiviEnCours and (pop_track<>nil) then
   begin
   Line:=pop_track.Panel17.Caption;
   PosEsp:=Pos(' ',Line);
   Line:=Copy(Line,1,PosEsp-1);
   pop_camera.pop_image_acq.ImgInfos.RMSGuideError:=MyStrToFloat(Line);
   end;
try
if pop_camera.Panel6.Caption<>lang('Inconnue') then
   pop_camera.pop_image_acq.ImgInfos.TemperatureCCD:=MyStrToFloat(pop_camera.Panel6.Caption)
else pop_camera.pop_image_acq.ImgInfos.TemperatureCCD:=999;
except
pop_camera.pop_image_acq.ImgInfos.TemperatureCCD:=999;
end;

if pop_camera.checkbox1.checked then
   begin
   Statistiques(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,
      pop_camera.pop_image_acq.ImgInfos.TypeData,1,pop_camera.pop_image_acq.ImgInfos.Sx,
      pop_camera.pop_image_acq.ImgInfos.Sy,1,aMin,Mediane,aMax,Moy,Ecart);
   pop_camera.update_stats(pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
      amin,mediane,amax,moy,ecart);
   end
else pop_camera.memo_stats.lines.clear;
pop_camera.pop_image_acq.AjusteFenetre;
case Config.SeuilCamera of
   0 : pop_camera.pop_image_acq.VisuAutoEtoiles;
   1 : pop_camera.pop_image_acq.VisuAutoPlanetes;
   2 : pop_camera.pop_image_acq.VisuAutoMinMax;
   3 : pop_camera.pop_image_acq.VisuMiniMaxi(config.SeuilBasFixe,config.SeuilHautFixe);
   end;

pop_main.SeuilsEnable;
pop_camera.pop_image_acq.AcqRunning:=False;
pop_camera.panel1.caption:=lang('Stop');
pop_camera.cb_bouclage.Checked:=False;
pop_camera.Stop1.Visible:=False;
pop_camera.outAcqB1.Visible:=True;
pop_camera.Stop2.Visible:=False;
pop_camera.outAcqB2.Visible:=True;
pop_camera.Stop4.Visible:=False;
pop_camera.outAcqB4.Visible:=True;
pop_camera.Progress.Position:=0;
EventEndAcq.SetEvent;
end;


procedure TThreadReadAuto.Execute;
var
   i,j,k,ii:Integer;
   InterI:SmallInt;
   Rep:string;
   Alpha,Delta:Double;
   LocalBinning:Byte;
   ax,bx,ay,by:double;
   Resultat:boolean;
begin
ThreadPoseAuto.Terminate;

Synchronize(BeforeLecture);

EventEndPose.SetEvent;
Camera.ReadCCD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.ImgInfos.Sx,
   pop_camera.pop_image_acq.ImgInfos.Sy);
if Camera.Is16Bits then
   begin
   pop_camera.pop_image_acq.ImgInfos.BZero:=32768;
   ConvertFITSIntToReal(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,
      pop_camera.pop_image_acq.ImgInfos);
   end;

Camera.GetCCDDateBegin(pop_camera.YearBegin,pop_camera.MonthBegin,pop_camera.DayBegin);
Camera.GetCCDTimeBegin(pop_camera.HourBegin,pop_camera.MinBegin,pop_camera.SecBegin,pop_camera.MSecBegin);
Camera.GetCCDDateEnd(pop_camera.YearEnd,pop_camera.MonthEnd,pop_camera.DayEnd);
Camera.GetCCDTimeEnd(pop_camera.HourEnd,pop_camera.MinEnd,pop_camera.SecEnd,pop_camera.MSecEnd);

pop_camera.TimeBegin:=EncodeDate(pop_camera.YearBegin,pop_camera.MonthBegin,pop_camera.DayBegin)
   +EncodeTime(pop_camera.HourBegin,pop_camera.MinBegin,pop_camera.SecBegin,pop_camera.MSecBegin);
pop_camera.TimeEnd:=EncodeDate(pop_camera.YearEnd,pop_camera.MonthEnd,pop_camera.DayEnd)
   +EncodeTime(pop_camera.HourEnd,pop_camera.MinEnd,pop_camera.SecEnd,pop_camera.MSecEnd);

pop_camera.PoseEnCours:=False;
// affichage du nombre total d'image
Camera.AdjustIntervalePose(pop_camera.NbInterValCourant,nbimage,Intervalle);

pop_main.LastChild:=pop_camera.pop_image_acq; //il faut un peu forcer les choses car onActivate n'est pas appeler si la fiche active precedente n'est pas un enfant MDI.

// On lit le température à nouveau
pop_camera.TimerTemp.Enabled:=True;

if pop_camera.ShutterClosedCamera then
   if Camera.HasAShutter then Camera.SetShutterSynchro;

if config.MirrorX then
   if Camera.Is16Bits then
      MiroirHorizontal(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,
         5,pop_camera.pop_image_acq.ImgInfos.NBPlans,pop_camera.pop_image_acq.ImgInfos.Sx,
         pop_camera.pop_image_acq.ImgInfos.Sy)
   else
      MiroirHorizontal(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,2,
         pop_camera.pop_image_acq.ImgInfos.NBPlans,pop_camera.pop_image_acq.ImgInfos.Sx,
         pop_camera.pop_image_acq.ImgInfos.Sy);
if config.MirrorY then
   if Camera.Is16Bits then
      MiroirVertical(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,
         5,pop_camera.pop_image_acq.ImgInfos.NBPlans,pop_camera.pop_image_acq.ImgInfos.Sx,
         pop_camera.pop_image_acq.ImgInfos.Sy)
   else
      MiroirVertical(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,
         2,pop_camera.pop_image_acq.ImgInfos.NBPlans,pop_camera.pop_image_acq.ImgInfos.Sx,
         pop_camera.pop_image_acq.ImgInfos.Sy);

{   if config.MirrorX then
   for k:=1 to pop_image_acq.ImgInfos.Nbplans do
      for j:=1 to pop_image_acq.ImgInfos.Sy do
         for i:=1 to pop_image_acq.ImgInfos.Sx div 2 do
            begin
            InterI:=pop_image_acq.DataInt^[k]^[j]^[i];
            pop_image_acq.DataInt^[k]^[j]^[i]:=pop_image_acq.DataInt^[k]^[j]^[pop_image_acq.ImgInfos.Sx-i+1];
            pop_image_acq.DataInt^[k]^[j]^[pop_image_acq.ImgInfos.Sx-i+1]:=InterI;
            end;
if config.MirrorY then
   for k:=1 to pop_image_acq.ImgInfos.Nbplans do
      for j:=1 to pop_image_acq.ImgInfos.Sx do
         for i:=1 to pop_image_acq.ImgInfos.Sy div 2 do
            begin
            InterI:=pop_image_acq.DataInt^[k]^[i]^[j];
            pop_image_acq.DataInt^[k]^[i]^[j]:=pop_image_acq.DataInt^[k]^[pop_image_acq.ImgInfos.Sy-i+1]^[j];
            pop_image_acq.DataInt^[k]^[pop_image_acq.ImgInfos.Sy-i+1]^[j]:=InterI;
            end;}

// Remplissage du ImgInfos
with pop_camera.pop_image_acq do
   begin
   InitImgInfos(ImgInfos);
   ImgInfos.TempsPose:=Round((pop_camera.TimeEnd-pop_camera.TimeBegin)*24*3600*1000);
   ImgInfos.DateTime:=pop_camera.TimeBegin+(pop_camera.TimeEnd-pop_camera.TimeBegin)/2;
//         ImgInfos.TempsPose:=Round(PoseCamera*1000); // Conversion s -> ms
   // On met a jour le temps de milieu de pose avec le temps de pose reel mesuré !
//         ImgInfos.DateTime:=TimeInit+PoseCamera/24/3600/2;
   ImgInfos.BinningX:=1;
   ImgInfos.BinningY:=1;
   ImgInfos.MiroirX:=config.MirrorX;
   ImgInfos.MiroirY:=config.MirrorY;
   ImgInfos.Telescope:=config.Telescope;
   ImgInfos.Observateur:=config.Observateur;
   ImgInfos.Camera:=Camera.GetName;
   ImgInfos.Observatoire:=config.Observatoire;
   ImgInfos.Lat:=Config.Lat;
   ImgInfos.Long:=Config.Long;
   ImgInfos.Focale:=config.FocaleTele;
   ImgInfos.Diametre:=config.Diametre;
   ImgInfos.OrientationCCD:=config.OrientationCCD;
   ImgInfos.Seeing:=Config.Seeing;
   ImgInfos.BScale:=1;
   ImgInfos.BZero:=0;
   ImgInfos.Alpha:=pop_camera.AlphaAcq;
   ImgInfos.Delta:=pop_camera.DeltaAcq;
   ImgInfos.PixX:=Camera.GetXPixelSize;
   ImgInfos.PixY:=Camera.GetYPixelSize;
   ImgInfos.X1:=pop_camera.x1;
   ImgInfos.Y1:=pop_camera.y1;
   ImgInfos.X2:=pop_camera.x2;
   ImgInfos.Y2:=pop_camera.y2;
   end;

Synchronize(AfterLecture);

// On remet à 0 pour pouvoir continuer le guidage
pop_camera.NbIntervalPose:=0;
end;

end.




