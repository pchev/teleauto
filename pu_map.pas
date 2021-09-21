unit pu_map;

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
  ExtCtrls, StdCtrls, ComCtrls, Spin, Buttons, u_class, Math, IniFiles;

type
  Tpop_map = class(TForm)
    btn_auto: TButton;
    btn_manuel: TButton;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    delai_ms: TEdit;
    SpinButton1: TSpinButton;
    GroupBox2: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    TrackBar1: TTrackBar;
    cb_cmde_corr: TCheckBox;
    GroupBox1: TGroupBox;
    img_last_command: TImage;
    GroupBox5: TGroupBox;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    Panel1: TPanel;
    Button2: TButton;
    Edit1: TEdit;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Label4: TLabel;
    Edit5: TEdit;
    SpinButton2: TSpinButton;
    Label5: TLabel;
    SpinEdit1: TSpinEdit;
    Button5: TButton;
    CheckBox1: TCheckBox;
    Button6: TButton;
    Timer1: TTimer;
    Button7: TButton;
    Button8: TButton;
    procedure btn_autoClick(Sender: TObject);
    procedure btn_manuelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormHide(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure SpinButton2UpClick(Sender: TObject);
    procedure SpinButton2DownClick(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button6Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);

  private
    { Private declarations }
    MoveFocuser:Boolean;
  public
    StopMap:Boolean;
    Pose:Double;
    XMap,YMap:Integer;

    { Public declarations }
    function Desature(var ValMax:Double;Error:Boolean):Integer;
    procedure AcqNoir;
    function AcqEtMesure:Byte;

    function  MAPAutoA:Boolean;
    function  MAPOptim:Boolean;
    procedure MAPAutoV;
    procedure MAPManuel;

    procedure WriteMessage(Msg:string);

    function Serie(var Fwhm:TVecteur;
                   NbMesures:Integer;
                   Add:Boolean;
                   NbAdd:Integer;
                   TypeMesureFWHM:Byte;
                   UseMoyenne:Boolean;
                   var FWHMOut:Double;
                   ErrorSature:Boolean;
                   ShowMarque:Boolean;
                   Color:TColor):Double;
  end;

var
   pop_map:Tpop_map;
   // Pour tracer l'aquisition en Focuser manuelle pour empecher les manoeuvres du focuseur en meme temps
   // Fonction de MAP manuelle en service
   MapManuelle:Boolean;
   // Pour savoir si on est dans une serie de mouvements
   DansSerie:Boolean;
   DoMap:Boolean;
   TimeBeginMap,TimeEndMap:TDateTime;
   TimeMap:Double;
   TypeMap:string;
   NoirMAPAcquis:Boolean;
   MemPicNoir,VignetteNoir:PTabImgInt;
   MemPicNoirDouble,VignetteNoirDouble:PTabImgDouble;   
   SxNoir,SyNoir:Integer;
   // Pour savoir quelle map démarrer dans le moniteur de map
   TypeMapMonitor:string;

implementation

uses u_general,
     u_file_io,
     pu_camera,
     u_constants,
     u_math,
     u_meca,
     pu_map_monitor,
     pu_main,
     pu_image,
     u_modelisation,
     u_analyse,
     u_lang,
     u_focusers,
     u_cameras,
     u_hour_servers,
     u_geometrie,
     u_arithmetique,
     pu_calib_autov, pu_calib_cmde_corr;

{$R *.DFM}

function Tpop_map.MAPAutoA:Boolean;
var
   xx,yy,i,j,k,l:Integer;
   Fwhm0,Fwhm1,Fwhm2,FwhmMin,FwhmMed,kd,ld:Double;
   Somme:Double;
   Fwhm:array[1..20] of Double;
   ValMax:Double;
   PSF:TPSF;
   Vitesse,Direction:Integer;
   TimeInit:TDateTime;
   DelaiFoc:Double;
   NbReusit,NbEchec,LargFen:Integer;
   Trouve:Boolean;
   Retournement,Marque,CorrectionSave:Boolean;
   XCentre,YCentre,Diametre:Double;
   xxd,yyd,Seeing:Double;
   TypeStr,TypeStrMoy,TypeStrMin:string;
   MyMessage:string;
   OK:Boolean;
   ValDesature:Integer;
begin
// Pour les tests
FWHMTestCourant:=5;

btn_manuel.Enabled:=False;
btn_auto.Enabled:=False;
Button1.Enabled:=False;
Button5.Enabled:=False;
Edit5.Enabled:=False;
SpinButton2.Enabled:=False;

if pop_map_monitor=nil then pop_map_monitor:=tpop_map_monitor.create(application);
pop_map_monitor.RAZ;
pop_map_monitor.Show;
pop_map_monitor.SetMesure(Config.NbEssaiFocFast);

TesteFocalisation:=True;
OK:=Focuser.GetCorrection(CorrectionSave);
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   FocuserDisconnect;
   raise MyError.Create(MyMessage);
   end;

case Config.TypeMesureFWHM of
   0:begin
     TypeStr:=lang('FWHM');
     TypeStrMoy:=lang('FWHM moyenne');
     TypeStrMin:=lang('FWHM minimale');
     pop_map_monitor.TypeStr:=lang('FWHM');
     pop_map_monitor.TypeStrMoy:=lang('FWHM moyenne');
     pop_map_monitor.TypeStrMin:=lang('FWHM minimale');
     end;
   1:begin
     TypeStr:=lang('HFD');
     TypeStrMoy:=lang('HFD moyen');
     TypeStrMin:=lang('HFD minimal');
     pop_map_monitor.TypeStr:=lang('HFD');
     pop_map_monitor.TypeStrMoy:=lang('HFD moyen');
     pop_map_monitor.TypeStrMin:=lang('HFD minimal');
     end;
   end;

if Config.UseMoyenne then
   begin
   pop_map_monitor.Label5.Caption:=TypeStr+lang(' moy (pixels)');
   pop_map_monitor.Label9.Caption:=TypeStr+lang(' moy (arcsec)');
   end
else
   begin
   pop_map_monitor.Label5.Caption:=TypeStr+lang(' min (pixels)');
   pop_map_monitor.Label9.Caption:=TypeStr+lang(' min (arcsec)');
   end;

if pop_camera.pop_image_acq=nil then
    pop_camera.pop_image_acq:=tpop_image.Create(Application);

pop_camera.pop_image_acq.Bloque:=True;
pop_camera.pop_image_acq.IsUsedForAcq:=True;

Pose:=MyStrToFloat(Edit5.text);
WriteSpy(lang('Temps de pose = ')+MyFloatToStr(Pose,2)
   +' secondes');
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Temps de pose = ')+MyFloatToStr(Pose,2)
   +' secondes');

if not NoirMAPAcquis and CheckBox1.Checked then
   begin
   WriteSpy(lang('Acquisition du noir'));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Acquisition du noir'));
   AcqNoir;
   NoirMAPAcquis:=True;
   end;

try

LargFen:=config.LargFoc;

WriteSpy(lang('Début de la mise au point automatique'));
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Début de la mise au point automatique'));

// Trouver ses coordonnees en Binning 4x4
WriteSpy(lang('Recherche des coordonnées de l''étoile la plus brillante'));
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Recherche des coordonnées de l''étoile la plus brillante'));
//AcqNonSatur(x,y);
pop_camera.AcqMaximumBinning(XMap,YMap);
if Camera.IsAValidBinning(4) then
   begin
   XMap:=XMap*4;
   YMap:=YMap*4;
   end
else
   begin
   XMap:=XMap*3;
   YMap:=YMap*3;
   end;

WriteSpy(lang('Coordonnées de l''étoile X = ')+IntToStr(XMap)
   +' Y = '+IntToStr(YMap)); //nolang
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Coordonnées de l''étoile X = ')+IntToStr(XMap)
   +' Y = '+IntToStr(YMap)); //nolang
// Premiere aquisition de l'etoile
WriteSpy(lang('Passage en vignette'));
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Passage en vignette'));
if (XMap>LargFen+1) and (YMap>LargFen+1) and (XMap<Camera.GetXSize-LargFen) and (YMap<Camera.GetYSize-LargFen) then
   begin
   pop_camera.Acquisition(XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen,Pose,1,False);

   //Soustraction du noir
   if NoirMAPAcquis  and CheckBox1.Checked then
      begin
      GetImgPart(MemPicNoir,MemPicNoirDouble,VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
         1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,pop_map.XMap-LargFen,pop_map.YMap-LargFen,
         pop_map.XMap+LargFen,pop_map.YMap+LargFen);
      Soust(pop_camera.pop_image_acq.DataInt,VignetteNoir,pop_camera.pop_image_acq.DataDouble,VignetteNoirDouble,
         pop_camera.pop_image_acq.ImgInfos.TypeData,1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
         pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy);
      FreememImg(VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
         pop_camera.pop_image_acq.ImgInfos.TypeData,1);
      end;

   pop_camera.pop_image_acq.AjusteFenetre;
   pop_camera.pop_image_acq.VisuAutoEtoiles;
   if Assigned(pop_map_monitor) then pop_map_monitor.AfficheImage(pop_camera.pop_image_acq);
   end
else
   begin
   WriteSpy(lang('Etoile trop près du bord'));
   WriteSpy(lang('On arrête'));
   if Assigned(pop_map_monitor) then
      begin
      pop_map_monitor.AddMessage(lang('Etoile trop près du bord'));
      pop_map_monitor.AddMessage(lang('On arrête'));
      pop_map_monitor.Button3.Enabled:=True;
      pop_map_monitor.Button4.Enabled:=False;
      end;
   Result:=False;
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;

// Pour Valmax
GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
   pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);

// Pour centrer
case Config.TypeMesureFWHM of
   0:begin
     XMap:=XMap-LargFen+Round(xx);
     YMap:=YMap-LargFen+Round(yy);
     end;
   1:begin
     HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,2*LargFen+1,
        2*LargFen+1,xxd,yyd,Diametre);
     XMap:=XMap-LargFen+Round(xxd);
     YMap:=YMap-LargFen+Round(yyd);
     end;
   end;

// Desaturer en 1x1
// Si le maxi est sature on baisse le temps de pose
//WriteSpy(lang('Désaturation de l''étoile si nécessaire'));
//if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Désaturation de l''étoile si nécessaire'));
//while (ValMax>config.Satur) and (Pose>config.MinPose) do

if Config.Verbose then
   begin
   WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
//   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
   end;

{if ValMax>=Camera.GetSaturationLevel then
   begin
   WriteSpy(lang('Etoile saturée, on tente de la désaturer'));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Etoile saturée, on tente de la désaturer'));
   end;}

{if ValMax>=Camera.GetSaturationLevel then if Desature(ValMax)<>0 then
   begin
   if Assigned(pop_map_monitor) then
      begin
      pop_map_monitor.Button3.Enabled:=True;
      pop_map_monitor.Button4.Enabled:=False;
      end;
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;}

{while (ValMax>=Camera.GetSaturationLevel) and (Pose>config.MinPose) do
   begin

   if StopMap then
      begin
      while pop_camera.PoseEnCours do Application.ProcessMessages;
      WriteSpy(lang('Arrêt de la mise au point effectué'));
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('Arrêt de la mise au point effectué'));
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      StopMap:=False;
      pop_camera.pop_image_acq.Bloque:=False;

      Exit;
      end;

   if (Pose/2>config.MinPose) then
      begin
      WriteSpy(lang('On divise le temps de pose par 2'));
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('On divise le temps de pose par 2'));
      Pose:=Pose/2;
      end
   else
      begin
      Pose:=config.MinPose;
      WriteSpy(lang('Temps de pose minimum atteint'));
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Temps de pose minimum atteint'));
      end;
   WriteSpy(lang('Temps de pose = ')+MyFloatToStr(Pose,2));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Temps de pose = ')+MyFloatToStr(Pose,2));

   if (XMap>LargFen+1) and (YMap>LargFen+1) and (XMap<Camera.GetXSize-LargFen) and (YMap<Camera.GetYSize-LargFen) then
      begin
      pop_camera.Acquisition(XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen,Pose,1,False);

      //Soustraction du noir
      if NoirMAPAcquis and CheckBox1.Checked then
         begin
         GetImgPart(MemPicNoir,ImgDoubleNil,VignetteNoir,ImgDoubleNil,2,1,pop_camera.pop_image_acq.ImgInfos.Sx,
            pop_camera.pop_image_acq.ImgInfos.Sy,XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen);
         Soust(pop_camera.pop_image_acq.DataInt,VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_camera.pop_image_acq.ImgInfos.Sx,
            pop_camera.pop_image_acq.ImgInfos.Sy,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy);
         FreememImg(VignetteNoir,ImgDoubleNil,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,2,1);
         end;

      pop_camera.pop_image_acq.AjusteFenetre;
      pop_camera.pop_image_acq.VisuAutoEtoiles;
      if Assigned(pop_map_monitor) then pop_map_monitor.AfficheImage(pop_camera.pop_image_acq);
      end
   else
      begin
      WriteSpy(lang('Etoile trop près du bord'));
      WriteSpy(lang('On arrête'));
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('Etoile trop près du bord'));
         pop_map_monitor.AddMessage(lang('On arrête'));
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      Result:=False;
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;

   end;

if ValMax>=Camera.GetSaturationLevel then
   begin
   WriteSpy(lang('L''étoile reste saturée, on arrête'));
   WriteSpy(lang('Cherchez une étoile moins brillante'));
   if Assigned(pop_map_monitor) then
      begin
      pop_map_monitor.AddMessage(lang('L''étoile reste saturée, on arrête'));
      pop_map_monitor.AddMessage(lang('Cherchez une étoile moins brillante'));
      end;
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end
else
   begin
   if Unsature then
      begin
      WriteSpy(lang('L''étoile n''est plus saturée, on peut continuer'));
      pop_map_monitor.AddMessage(lang('L''étoile n''est plus saturée, on peut continuer'));
      end;
   end;}

// On va commencer par bouger pendant ?
DelaiFoc:=config.DelaiFocFastInit;

// NbEssaiFocFast : Nombre d'essais en rapide

// Corriger les coordonnées pour mettre l'etoile au centre
// Corriger x et y en fonction de xx et yy
//GetMax(pop_camera.pop_image_acq.dataInt,ImgNil,2,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);
// Pour centrer
case Config.TypeMesureFWHM of
   0:begin
     XMap:=XMap-LargFen+Round(xx);
     YMap:=YMap-LargFen+Round(yy);
     end;
   1:begin
     HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,2*LargFen+1,
        2*LargFen+1,xxd,yyd,Diametre);
     XMap:=XMap-LargFen+Round(xxd);
     YMap:=YMap-LargFen+Round(yyd);
     end;
   end;

// On regle la commande corrigee selon la demande
if Config.CorrectionAutoFast then OK:=Focuser.SetCorrectionOn else OK:=Focuser.SetCorrectionOff;
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   FocuserDisconnect;
   raise MyError.Create(MyMessage);
   end;


// Première mesure de la FWHM avant deplacement initial
FwhmMin:=999;
i:=0;
NbReusit:=0;
NbEchec:=0;
while (NbReusit<config.NbEssaiFocFast) and (NbEchec<config.NbEssaiCentroMaxi) do
   begin
   if StopMap then
      begin
      while pop_camera.PoseEnCours do Application.ProcessMessages;
      WriteSpy(lang('Arrêt de la mise au point effectué'));
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('Arrêt de la mise au point effectué'));
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      StopMap:=False;
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;

   if (XMap>LargFen+1) and (YMap>LargFen+1) and (XMap<Camera.GetXSize-LargFen) and (YMap<Camera.GetYSize-LargFen) then
      begin
      pop_camera.Acquisition(XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen,Pose,1,False);
      pop_camera.pop_image_acq.AjusteFenetre;
      pop_camera.pop_image_acq.VisuAutoEtoiles;

      GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
         pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);

      if Config.Verbose then
         begin
         WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
//         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
         end;
      if ValMax>=Camera.GetSaturationLevel then
         begin
         ValDesature:=Desature(ValMax,True);
         if ValDesature<0 then
            begin
            if Assigned(pop_map_monitor) then
               begin
               pop_map_monitor.Button3.Enabled:=True;
               pop_map_monitor.Button4.Enabled:=False;
               end;
            pop_camera.pop_image_acq.Bloque:=False;
            Exit;
            end;
         end;

      //Soustraction du noir
      if NoirMAPAcquis  and CheckBox1.Checked then
         begin
         GetImgPart(MemPicNoir,MemPicNoirDouble,VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
            1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,pop_map.XMap-LargFen,pop_map.YMap-LargFen,
            pop_map.XMap+LargFen,pop_map.YMap+LargFen);
         Soust(pop_camera.pop_image_acq.DataInt,VignetteNoir,pop_camera.pop_image_acq.DataDouble,VignetteNoirDouble,
            pop_camera.pop_image_acq.ImgInfos.TypeData,1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
            pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy);
         FreememImg(VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
            pop_camera.pop_image_acq.ImgInfos.TypeData,1);
         end;

      if Assigned(pop_map_monitor) then pop_map_monitor.AfficheImage(pop_camera.pop_image_acq);
      end
   else
      begin
      WriteSpy(lang('Etoile trop près du bord'));
      WriteSpy(lang('On arrête'));
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('Etoile trop près du bord'));
         pop_map_monitor.AddMessage(lang('On arrête'));
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      Result:=False;
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;

   case Config.TypeMesureFWHM of
//      0:ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*LargFen+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
      0:ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
           2*LargFen+1,TGauss,LowPrecision,LowSelect,0,PSF);
      1:begin
        HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,2*LargFen+1,
           2*LargFen+1,XCentre,YCentre,Diametre);
        // Pour corriger la difference entre les deux mesures pour FWHM=4
//        Diametre:=Diametre/4.5*3.75;
        PSF.Flux:=0;
        if Diametre=-1 then PSF.Flux:=-1;
        PSF.X:=XCentre;
        PSF.Y:=YCentre;
        PSF.Sigma:=Diametre;
//        if Diametre<4 then ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*LargFen+1,xx,yy,TGauss,LowPrecision,0,PSF);
        end;
     end;


   if PSF.Flux=-1 then
      begin
      Inc(NbEchec);
      WriteSpy(lang('Echec de la modélisation n° ')+IntToStr(NbEchec));
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Echec de la modélisation n° ')+IntToStr(NbEchec));
      end
   else
      begin

//      GetMax(pop_camera.pop_image_acq.dataInt,ImgNil,2,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);
      XMap:=XMap-LargFen+Round(PSF.X);
      YMap:=YMap-LargFen+Round(PSF.Y);

      WriteSpy(lang('Mesure ')+IntToStr(NbReusit+1)
         +' '+TypeStr+' = '+MyFloatToStr(PSF.Sigma,2)); //nolang
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Mesure ')+IntToStr(NbReusit+1)
         +' '+TypeStr+' = '+MyFloatToStr(PSF.Sigma,2)); //nolang
      if PSF.Sigma<FwhmMin then FwhmMin:=PSF.Sigma;


      Marque:=False;
      if NbReusit=config.NbEssaiFocFast-1 then Marque:=True;
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.Add(HeureToJourJulien(GetHourDT),PSF.Sigma,Marque,clRed);
         pop_map_monitor.AfficheCercle(PSF.X,PSF.Y,PSF.Sigma);
         end;

      Inc(NbReusit);
      Fwhm[NbReusit]:=PSF.Sigma;

{      if NbReusit>1 then
         begin
         Trouve:=True;
         while Trouve do
            begin
            Trouve:=False;
            for j:=1 to NbReusit-1 do
               if Fwhm[j]>Fwhm[j+1] then
                  begin
                  Trouve:=True;
                  FwhmTmp:=Fwhm[j];
                  Fwhm[j]:=Fwhm[j+1];
                  Fwhm[j+1]:=FwhmTmp;
                  end;
            end;
         FwhmMed:=Fwhm[NbReusit div 2+1];
         end;}
      end;

   Inc(i);
   end;

// Trop d'echec de la modélisation
if NbEchec=config.NbEssaiCentroMaxi then
   begin
   WriteSpy(lang('On a atteint le nombre maxi d''échecs de modélisation, on arrête'));
   WriteSpy('Changez d''étoile et/ou agrandissez la fenêtre de modélisation');
   if Assigned(pop_map_monitor) then
      begin
      pop_map_monitor.AddMessage(lang('On a atteint le nombre maxi d''échecs de modélisation, on arrête'));
      pop_map_monitor.AddMessage('Changez d''étoile et/ou agrandissez la fenêtre de modélisation');
      pop_map_monitor.Button3.Enabled:=True;
      pop_map_monitor.Button4.Enabled:=False;
      end;
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;

if Config.UseMoyenne then
   begin
   // Calcul de la moyenne
   Somme:=0;
   for j:=1 to NbReusit do
      Somme:=Somme+Fwhm[j];
   Fwhm0:=Somme/NbReusit;

   WriteSpy(TypeStrMoy+lang(' avant déplacement initial = ')+MyFloatToStr(Fwhm0,2));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(TypeStrMoy+lang(' avant déplacement initial = ')
      +MyFloatToStr(Fwhm0,2));
   end
else
   begin
   Fwhm0:=FwhmMin;

   WriteSpy(TypeStrMin+lang(' avant déplacement initial = ')+MyFloatToStr(Fwhm0,2));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(TypeStrMin+lang(' avant déplacement initial = ')
      +MyFloatToStr(Fwhm0,2));
   end;

// La mise au point commence par un petit deplacement en arriere
// avec une impulsion de config.DelaiFocSlowMin ms a vitesse lente
OK:=Focuser.FocuserMoveTime(mapArriere,mapLent,config.DelaiFocSlowMin);
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   FocuserDisconnect;
   raise MyError.Create(MyMessage);
   end;

// Deuxieme mesure de la FWHM aprés déplacement initial
FwhmMin:=999;
i:=0;
NbReusit:=0;
NbEchec:=0;
while (NbReusit<config.NbEssaiFocFast) and (NbEchec<config.NbEssaiCentroMaxi) do
   begin
   if StopMap then
      begin
      while pop_camera.PoseEnCours do Application.ProcessMessages;
      WriteSpy(lang('Arrêt de la mise au point effectué'));
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('Arrêt de la mise au point effectué'));
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      StopMap:=False;
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;

   if (XMap>LargFen+1) and (YMap>LargFen+1) and (XMap<Camera.GetXSize-LargFen) and (YMap<Camera.GetYSize-LargFen) then
      begin
      pop_camera.Acquisition(XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen,Pose,1,False);

      GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
         pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);

      if Config.Verbose then
         begin
         WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
//         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
         end;
      if ValMax>=Camera.GetSaturationLevel then
         begin
         ValDesature:=Desature(ValMax,True);
         if ValDesature<0 then
            begin
            if Assigned(pop_map_monitor) then
               begin
               pop_map_monitor.Button3.Enabled:=True;
               pop_map_monitor.Button4.Enabled:=False;
               end;
            pop_camera.pop_image_acq.Bloque:=False;
            Exit;
            end;
         end;
      
      //Soustraction du noir
      if NoirMAPAcquis  and CheckBox1.Checked then
         begin
         GetImgPart(MemPicNoir,MemPicNoirDouble,VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
            1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,pop_map.XMap-LargFen,pop_map.YMap-LargFen,
            pop_map.XMap+LargFen,pop_map.YMap+LargFen);
         Soust(pop_camera.pop_image_acq.DataInt,VignetteNoir,pop_camera.pop_image_acq.DataDouble,VignetteNoirDouble,
            pop_camera.pop_image_acq.ImgInfos.TypeData,1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
            pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy);
         FreememImg(VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
            pop_camera.pop_image_acq.ImgInfos.TypeData,1);
         end;

      pop_camera.pop_image_acq.AjusteFenetre;
      pop_camera.pop_image_acq.VisuAutoEtoiles;
      if Assigned(pop_map_monitor) then pop_map_monitor.AfficheImage(pop_camera.pop_image_acq);
      end
   else
      begin
      WriteSpy(lang('Etoile trop près du bord'));
      WriteSpy(lang('On arrête'));
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('Etoile trop près du bord'));
         pop_map_monitor.AddMessage(lang('On arrête'));
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      Result:=False;
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;

   case Config.TypeMesureFWHM of
//      0:ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*LargFen+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
      0:ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
           2*LargFen+1,TGauss,LowPrecision,LowSelect,0,PSF);
      1:begin
        HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,2*LargFen+1,
           2*LargFen+1,XCentre,YCentre,Diametre);
        // Pour corriger la difference entre les deux mesures pour FWHM=4
//        Diametre:=Diametre/4.5*3.75;
        PSF.Flux:=0;
        if Diametre=-1 then PSF.Flux:=-1;
        PSF.X:=XCentre;
        PSF.Y:=YCentre;
        PSF.Sigma:=Diametre;
//        if Diametre<4 then ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*LargFen+1,xx,yy,TGauss,LowPrecision,0,PSF);
        end;
      end;

   if PSF.Flux=-1 then
      begin
      Inc(NbEchec);
      WriteSpy(lang('Echec de la modélisation n° ')+IntToStr(NbEchec));
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Echec de la modélisation n° ')+IntToStr(NbEchec));
      end
   else
      begin

//      GetMax(pop_camera.pop_image_acq.dataInt,ImgNil,2,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);
      XMap:=XMap-LargFen+Round(PSF.X);
      YMap:=YMap-LargFen+Round(PSF.Y);

      WriteSpy(lang('Mesure ')+IntToStr(NbReusit+1)
         +' '+TypeStr+' = '+MyFloatToStr(PSF.Sigma,2)); //nolang
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Mesure ')+IntToStr(NbReusit+1)
         +' '+TypeStr+' = '+MyFloatToStr(PSF.Sigma,2)); //nolang
      if PSF.Sigma<FwhmMin then FwhmMin:=PSF.Sigma;

      Marque:=False;
      if NbReusit=config.NbEssaiFocFast-1 then Marque:=True;
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.Add(HeureToJourJulien(GetHourDT),PSF.Sigma,Marque,clRed);
         pop_map_monitor.AfficheCercle(PSF.X,PSF.Y,PSF.Sigma);
         end;

      Inc(NbReusit);
      Fwhm[NbReusit]:=PSF.Sigma;

{      if NbReusit>1 then
         begin
         Trouve:=True;
         while Trouve do
            begin
            Trouve:=False;
            for j:=1 to NbReusit-1 do
               if Fwhm[j]>Fwhm[j+1] then
                  begin
                  Trouve:=True;
                  FwhmTmp:=Fwhm[j];
                  Fwhm[j]:=Fwhm[j+1];
                  Fwhm[j+1]:=FwhmTmp;
                  end;
            end;
         FwhmMed:=Fwhm[NbReusit div 2+1];
         end;}
      end;

   Inc(i);
   end;

// Trop d'echec de la modélisation
if NbEchec=config.NbEssaiCentroMaxi then
   begin
   WriteSpy(lang('On a atteint le nombre maxi d''échecs de modélisation, on arrête'));
   WriteSpy('Changez d''étoile et/ou agrandissez la fenêtre de modélisation');
   if Assigned(pop_map_monitor) then
      begin
      pop_map_monitor.AddMessage(lang('On a atteint le nombre maxi d''échecs de modélisation, on arrête'));
      pop_map_monitor.AddMessage('Changez d''étoile et/ou agrandissez la fenêtre de modélisation');      
      end;
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;

if Config.UseMoyenne then
   begin
   // Calcul de la moyenne
   Somme:=0;
   for j:=1 to NbReusit do
      Somme:=Somme+Fwhm[j];
   Fwhm1:=Somme/NbReusit;

   WriteSpy(TypeStrMoy+lang(' aprés déplacement initial = ')+MyFloatToStr(Fwhm1,2));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(TypeStrMoy+lang(' aprés déplacement initial = ')
      +MyFloatToStr(Fwhm1,2));
   end
else
   begin
   Fwhm1:=FwhmMin;

   WriteSpy(TypeStrMin+lang(' aprés déplacement initial = ')+MyFloatToStr(Fwhm1,2));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(TypeStrMin+lang(' aprés déplacement initial = ')
      +MyFloatToStr(Fwhm1,2));
   end;

// D'abord on teste si le réglage rapide est nécessaire
if Fwhm1<=config.FwhmStopFast then
   begin
   WriteSpy(TypeStr+'<'+TypeStr+lang(' d''arrêt en vitesse rapide, on saute le réglage en vitesse rapide'));
   if Assigned(pop_map_monitor) then
      pop_map_monitor.AddMessage(TypeStr+'<'+TypeStr+lang(' d''arrêt en vitesse rapide, on saute le réglage en vitesse rapide'));
   end;

// D'abord on regle rapidement la Focuser si nécessaire
if Fwhm1>config.FwhmStopFast then
   begin
   WriteSpy(lang('Passage à la vitesse rapide de mise au point'));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Passage à la vitesse rapide de mise au point'));
   Vitesse:=mapRapide;
   end;

// Reglage de la direction
if Fwhm1>Fwhm0 then
   begin
   WriteSpy(lang('C''est moins bien, on commence par un déplacement avant'));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('C''est moins bien, on commence par un déplacement avant'));
   Direction:=mapAvant;
   end
else
   begin
   WriteSpy(lang('C''est mieux, on commence par un déplacement arrière'));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('C''est mieux, on commence par un déplacement arrière'));
   Direction:=mapArriere;
   end;

// Et on bouge si necessaire
if Fwhm1>config.FwhmStopFast then
   begin
   OK:=Focuser.FocuserMoveTime(Direction,Vitesse,DelaiFoc);
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      FocuserDisconnect;
      raise MyError.Create(MyMessage);
      end;
   end;

// Boucle de reglage en vitesse rapide
while Fwhm1>config.FwhmStopFast do
   begin
   if StopMap then
      begin
      while pop_camera.PoseEnCours do Application.ProcessMessages;
      WriteSpy(lang('Arrêt de la mise au point effectué'));
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('Arrêt de la mise au point effectué'));
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      StopMap:=False;
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;
   // Faire le centroide initial
   // NbEssaiFoc : Nombre d'essais
   FwhmMin:=999;

   i:=0;
   NbReusit:=0;
   NbEchec:=0;
   while (NbReusit<config.NbEssaiFocFast) and (NbEchec<config.NbEssaiCentroMaxi) do
      begin
      if StopMap then
         begin
         while pop_camera.PoseEnCours do Application.ProcessMessages;
         WriteSpy(lang('Arrêt de la mise au point effectué'));
         if Assigned(pop_map_monitor) then
            begin
            pop_map_monitor.AddMessage(lang('Arrêt de la mise au point effectué'));
            pop_map_monitor.Button3.Enabled:=True;
            pop_map_monitor.Button4.Enabled:=False;
            end;
         StopMap:=False;
         pop_camera.pop_image_acq.Bloque:=False;
         Exit;
         end;
      if (XMap>LargFen+1) and (YMap>LargFen+1) and (XMap<Camera.GetXSize-LargFen) and (YMap<Camera.GetYSize-LargFen) then
         begin
         pop_camera.Acquisition(XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen,Pose,1,False);

         GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
            pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);

         if Config.Verbose then
            begin
            WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
//            if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
            end;
         if ValMax>=Camera.GetSaturationLevel then
            begin
            ValDesature:=Desature(ValMax,True);
            if ValDesature<0 then
               begin
               if Assigned(pop_map_monitor) then
                  begin
                  pop_map_monitor.Button3.Enabled:=True;
                  pop_map_monitor.Button4.Enabled:=False;
                  end;
               pop_camera.pop_image_acq.Bloque:=False;
               Exit;
               end;
            end;

         //Soustraction du noir
         if NoirMAPAcquis  and CheckBox1.Checked then
            begin
            GetImgPart(MemPicNoir,MemPicNoirDouble,VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
               1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,pop_map.XMap-LargFen,pop_map.YMap-LargFen,
               pop_map.XMap+LargFen,pop_map.YMap+LargFen);
            Soust(pop_camera.pop_image_acq.DataInt,VignetteNoir,pop_camera.pop_image_acq.DataDouble,VignetteNoirDouble,
               pop_camera.pop_image_acq.ImgInfos.TypeData,1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
               pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy);
            FreememImg(VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
               pop_camera.pop_image_acq.ImgInfos.TypeData,1);
            end;

         pop_camera.pop_image_acq.AjusteFenetre;      
         pop_camera.pop_image_acq.VisuAutoEtoiles;
         if Assigned(pop_map_monitor) then pop_map_monitor.AfficheImage(pop_camera.pop_image_acq);
         end
      else
         begin
         WriteSpy(lang('Etoile trop près du bord'));
         WriteSpy(lang('On arrête'));
         if Assigned(pop_map_monitor) then
            begin
            pop_map_monitor.AddMessage(lang('Etoile trop près du bord'));
            pop_map_monitor.AddMessage(lang('On arrête'));
            pop_map_monitor.Button3.Enabled:=True;
            pop_map_monitor.Button4.Enabled:=False;
            end;
         Result:=False;
         pop_camera.pop_image_acq.Bloque:=False;         
         Exit;
         end;

      case Config.TypeMesureFWHM of
//         0:ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*LargFen+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
         0:ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
              2*LargFen+1,TGauss,LowPrecision,LowSelect,0,PSF);
         1:begin
           HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,2*LargFen+1,
              2*LargFen+1,XCentre,YCentre,Diametre);
           // Pour corriger la difference entre les deux mesures pour FWHM=4
//           Diametre:=Diametre/4.5*3.75;
           PSF.Flux:=0;
           if Diametre=-1 then PSF.Flux:=-1;
           PSF.X:=XCentre;
           PSF.Y:=YCentre;
           PSF.Sigma:=Diametre;
//           if Diametre<4 then ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*LargFen+1,xx,yy,TGauss,LowPrecision,0,PSF);
           end;
         end;

      if PSF.Flux=-1 then
         begin
         Inc(NbEchec);
         WriteSpy(lang('Echec de la modélisation n° ')+IntToStr(NbEchec));
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Echec de la modélisation n° ')+IntToStr(NbEchec));
         end
      else
         begin

//         GetMax(pop_camera.pop_image_acq.dataInt,ImgNil,2,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);
         XMap:=XMap-LargFen+Round(PSF.X);
         YMap:=YMap-LargFen+Round(PSF.Y);

         WriteSpy(lang('Mesure ')+IntToStr(NbReusit+1)
            +' '+TypeStr+' = '+MyFloatToStr(PSF.Sigma,2)); //nolang
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Mesure ')+IntToStr(NbReusit+1)
            +' '+TypeStr+' = '+MyFloatToStr(PSF.Sigma,2)); //nolang
         if PSF.Sigma<FwhmMin then FwhmMin:=PSF.Sigma;

         Marque:=False;
         if NbReusit=config.NbEssaiFocFast-1 then Marque:=True;
         if Assigned(pop_map_monitor) then
            begin
            pop_map_monitor.Add(HeureToJourJulien(GetHourDT),PSF.Sigma,Marque,clRed);
            pop_map_monitor.AfficheCercle(PSF.X,PSF.Y,PSF.Sigma);
            end;

         Inc(NbReusit);
         Fwhm[NbReusit]:=PSF.Sigma;

{         if NbReusit>1 then
            begin
            Trouve:=True;
            while Trouve do
               begin
               Trouve:=False;
               for j:=1 to NbReusit-1 do
                  if Fwhm[j]>Fwhm[j+1] then
                     begin
                     Trouve:=True;
                     FwhmTmp:=Fwhm[j];
                     Fwhm[j]:=Fwhm[j+1];
                     Fwhm[j+1]:=FwhmTmp;
                     end;
               end;
            FwhmMed:=Fwhm[NbReusit div 2+1];
            end;}
         end;
      Inc(i);
      end;

   if NbEchec=config.NbEssaiCentroMaxi then
      begin
      WriteSpy(lang('On a atteint le nombre maxi d''échecs de modélisation, on arrête'));
      WriteSpy('Changez d''étoile et/ou agrandissez la fenêtre de modélisation');
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('On a atteint le nombre maxi d''échecs de modélisation, on arrête'));
         pop_map_monitor.AddMessage('Changez d''étoile et/ou agrandissez la fenêtre de modélisation');
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;

   if Config.UseMoyenne then
      begin
      // Calcul de la moyenne
      Somme:=0;
      for j:=1 to NbReusit do
         Somme:=Somme+Fwhm[j];
      Fwhm2:=Somme/NbReusit;

//      WriteSpy(TypeStrMoy+lang(' = ')+MyFloatToStr(Fwhm2,2)); //nolang
//      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(TypeStrMoy+lang(' = ')+MyFloatToStr(Fwhm2,2)); //nolang
      end
   else
      begin
      Fwhm2:=FwhmMin;

//      WriteSpy(TypeStrMin+lang(' = ')+MyFloatToStr(Fwhm2,2)); //nolang
//      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(TypeStrMin+lang(' = ')+MyFloatToStr(Fwhm2,2)); //nolang
      end;

   if Fwhm2>config.FwhmStopFast then
      begin
      Retournement:=False;
      // Si c'est moins bien de plus que la tolerance, on inverse, et on divise par 2
//      if Fwhm2>Fwhm1+Config.ToleranceFwhm/100*Config.FwhmStopFast then
      if Fwhm2>Fwhm1 then
         begin
         WriteSpy(lang('C''est moins bien, on change de sens'));
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('C''est moins bien, on change de sens'));
         Retournement:=True;
         if Direction=mapAvant then Direction:=mapArriere else Direction:=mapAvant;
         if Direction=mapAvant then
            begin
            WriteSpy(lang('Direction vers l''avant'));
            if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Direction vers l''avant'));
            end;
         if Direction=mapArriere then
            begin
            WriteSpy(lang('Direction vers l''arrière'));
            if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Direction vers l''arrière'));
            end;
         if DelaiFoc>2*config.DelaiFocFastMin then DelaiFoc:=DelaiFoc/2 else DelaiFoc:=config.DelaiFocFastMin;
         end
      else
        // Si c'est mieux on continue pareil
         begin
         WriteSpy(lang('C''est mieux, on continue dans le même sens'));
         if Assigned(pop_map_monitor) then
            pop_map_monitor.AddMessage(lang('C''est mieux, on continue dans le même sens'));
         end;

      // Et on bouge
      OK:=Focuser.FocuserMoveTime(Direction,Vitesse,DelaiFoc);
      if not OK then
         begin
         MyMessage:=Focuser.GetError;
         WriteSpy(MyMessage);
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
         FocuserDisconnect;
         raise MyError.Create(MyMessage);
         end;
      end;

   Fwhm1:=Fwhm2;
   end;

// Ensuite on affine lentement la Focuser
if Assigned(pop_map_monitor) then
   begin
{   if (Fwhm1<config.FwhmStopFast) then
      begin
      WriteSpy(lang('FWHM<FWHM d''arrêt vitesse rapide'));
      pop_map_monitor.AddMessage(lang('FWHM<FWHM d''arrêt vitesse rapide'));
      end;}
{   WriteSpy(lang('Passage à Focuser lente'));
   pop_map_monitor.AddMessage(lang('Passage à Focuser lente'));}
   end;

// On regle la commande corrigee selon la demande
if Config.CorrectionAutoSlow then Focuser.SetCorrectionOn else Focuser.SetCorrectionOff;
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   FocuserDisconnect;
   raise MyError.Create(MyMessage);
   end;

// D'abord on teste si le réglage lent est nécessaire
if Fwhm1<=config.FwhmStopSlow then
   begin
   WriteSpy(TypeStr+'<'+TypeStr+lang(' d''arrêt en vitesse lente, on saute le réglage en vitesse lente'));
   if Assigned(pop_map_monitor) then
      pop_map_monitor.AddMessage(TypeStr+'<'+TypeStr+lang(' d''arrêt en vitesse lente, on saute le réglage en vitesse lente'));
   end;

WriteSpy(TypeStrMin+lang(' avant Focuseur lente = ')+MyFloatToStr(Fwhm1,2));
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(TypeStrMin+lang(' avant Focuseur lente = ')+MyFloatToStr(Fwhm1,2));

if Fwhm1>config.FwhmStopSlow then
   begin
   WriteSpy(lang('Passage à la vitesse lente de mise au point'));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Passage à la vitesse lente de mise au point'));
   Vitesse:=mapLent;
   end;

// On va commencer par bouger pendant ?
DelaiFoc:=config.DelaiFocSlowInit;
// Et on bouge si necessaire
if Fwhm1>config.FwhmStopSlow then
   begin
   OK:=Focuser.FocuserMoveTime(Direction,Vitesse,DelaiFoc);
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      FocuserDisconnect;
      raise MyError.Create(MyMessage);
      end;
   end;

// Boucle de reglage en vitesse lente
while Fwhm1>config.FwhmStopSlow do
   begin
   if StopMap then
      begin
      while pop_camera.PoseEnCours do Application.ProcessMessages;
      WriteSpy(lang('Arrêt de la mise au point effectué'));
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('Arrêt de la mise au point effectué'));
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      StopMap:=False;
      pop_camera.pop_image_acq.Bloque:=False;      
      Exit;
      end;
   // Faire le centroide initial
   // NbEssaiFoc : Nombre d'essais
   FwhmMin:=999;

   i:=0;
   NbReusit:=0;
   NbEchec:=0;
   while (NbReusit<config.NbEssaiFocSlow) and (NbEchec<config.NbEssaiCentroMaxi) do
      begin
      if StopMap then
         begin
         while pop_camera.PoseEnCours do Application.ProcessMessages;
         WriteSpy(lang('Arrêt de la mise au point effectué'));
         if Assigned(pop_map_monitor) then
            begin
            pop_map_monitor.AddMessage(lang('Arrêt de la mise au point effectué'));
            pop_map_monitor.Button3.Enabled:=True;
            pop_map_monitor.Button4.Enabled:=False;
            end;
         StopMap:=False;
         pop_camera.pop_image_acq.Bloque:=False;         
         Exit;
         end;
      if (XMap>LargFen+1) and (YMap>LargFen+1) and (XMap<Camera.GetXSize-LargFen) and (YMap<Camera.GetYSize-LargFen) then
         begin
         pop_camera.Acquisition(XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen,Pose,1,False);

         GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
            pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);

         if Config.Verbose then
            begin
            WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
//            if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
            end;
         if ValMax>=Camera.GetSaturationLevel then
            begin
            ValDesature:=Desature(ValMax,True);
            if ValDesature<0 then
               begin
               if Assigned(pop_map_monitor) then
                  begin
                  pop_map_monitor.Button3.Enabled:=True;
                  pop_map_monitor.Button4.Enabled:=False;
                  end;
               pop_camera.pop_image_acq.Bloque:=False;
               Exit;
               end;
            end;

         //Soustraction du noir
         if NoirMAPAcquis  and CheckBox1.Checked then
            begin
            GetImgPart(MemPicNoir,MemPicNoirDouble,VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
               1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,pop_map.XMap-LargFen,pop_map.YMap-LargFen,
               pop_map.XMap+LargFen,pop_map.YMap+LargFen);
            Soust(pop_camera.pop_image_acq.DataInt,VignetteNoir,pop_camera.pop_image_acq.DataDouble,VignetteNoirDouble,
               pop_camera.pop_image_acq.ImgInfos.TypeData,1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
               pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy);
            FreememImg(VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
               pop_camera.pop_image_acq.ImgInfos.TypeData,1);
            end;

         pop_camera.pop_image_acq.AjusteFenetre;   
         pop_camera.pop_image_acq.VisuAutoEtoiles;
         if Assigned(pop_map_monitor) then pop_map_monitor.AfficheImage(pop_camera.pop_image_acq);
         end
      else
         begin
         WriteSpy(lang('Etoile trop près du bord'));
         WriteSpy(lang('On arrête'));
         if Assigned(pop_map_monitor) then
            begin
            pop_map_monitor.AddMessage(lang('Etoile trop près du bord'));
            pop_map_monitor.AddMessage(lang('On arrête'));
            pop_map_monitor.Button3.Enabled:=True;
            pop_map_monitor.Button4.Enabled:=False;
            end;
         Result:=False;
         pop_camera.pop_image_acq.Bloque:=False;
         Exit;
         end;

      case Config.TypeMesureFWHM of
//         0:ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*LargFen+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
         0:ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
              2*LargFen+1,TGauss,LowPrecision,LowSelect,0,PSF);
         1:begin
           HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,2*LargFen+1,
              2*LargFen+1,XCentre,YCentre,Diametre);
           // Pour corriger la difference entre les deux mesures pour FWHM=4
//           Diametre:=Diametre/4.5*3.75;
           PSF.Flux:=0;
           if Diametre=-1 then PSF.Flux:=-1;
           PSF.X:=XCentre;
           PSF.Y:=YCentre;
           PSF.Sigma:=Diametre;
//           if Diametre<4 then ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*LargFen+1,xx,yy,TGauss,LowPrecision,0,PSF);
           end;
         end;

      if PSF.Flux=-1 then
         begin
         Inc(NbEchec);
         WriteSpy(lang('Echec de la modélisation n° ')+IntToStr(NbEchec));
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Echec de la modélisation n° ')+IntToStr(NbEchec));
         end
      else
         begin

//         GetMax(pop_camera.pop_image_acq.dataInt,ImgNil,2,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);
         XMap:=XMap-LargFen+Round(PSF.X);
         YMap:=YMap-LargFen+Round(PSF.Y);

         WriteSpy(lang('Mesure ')+IntToStr(NbReusit+1)
            +' '+TypeStr+' = '+MyFloatToStr(PSF.Sigma,2)); //nolang
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Mesure ')+IntToStr(NbReusit+1)
            +' '+TypeStr+' = '+MyFloatToStr(PSF.Sigma,2)); //nolang
         if PSF.Sigma<FwhmMin then FwhmMin:=PSF.Sigma;

         Marque:=False;
         if NbReusit=config.NbEssaiFocSlow-1 then Marque:=True;
         if Assigned(pop_map_monitor) then
            begin
            pop_map_monitor.Add(HeureToJourJulien(GetHourDT),PSF.Sigma,Marque,clRed);
            pop_map_monitor.AfficheCercle(PSF.X,PSF.Y,PSF.Sigma);
            end;

         Inc(NbReusit);
         Fwhm[NbReusit]:=PSF.Sigma;

{         if NbReusit>1 then
            begin
            Trouve:=True;
            while Trouve do
               begin
               Trouve:=False;
               for i:=1 to NbReusit-1 do
                  if Fwhm[j]>Fwhm[j+1] then
                     begin
                     Trouve:=True;
                     FwhmTmp:=Fwhm[j];
                     Fwhm[j]:=Fwhm[j+1];
                     Fwhm[j+1]:=FwhmTmp;
                     end;
               end;
            FwhmMed:=Fwhm[NbReusit div 2+1];
            end;}

         end;

      Inc(i);
      end;

   if NbEchec=config.NbEssaiCentroMaxi then
      begin
      WriteSpy(lang('On a atteint le nombre maxi d''échecs de modélisation, on arrête'));
      WriteSpy('Changez d''étoile et/ou agrandissez la fenêtre de modélisation');
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('On a atteint le nombre maxi d''échecs de modélisation, on arrête'));
         pop_map_monitor.AddMessage('Changez d''étoile et/ou agrandissez la fenêtre de modélisation');
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;

   if Config.UseMoyenne then
      begin
      // Calcul de la moyenne
      Somme:=0;
      for j:=1 to NbReusit do
         Somme:=Somme+Fwhm[j];
      Fwhm2:=Somme/NbReusit;

//      WriteSpy(TypeStrMoy+lang(' = ')+MyFloatToStr(Fwhm2,2)); //nolang
//      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(TypeStrMoy+lang(' = ')+MyFloatToStr(Fwhm2,2)); //nolang
      end
   else
      begin
      Fwhm2:=FwhmMin;

//      WriteSpy(TypeStrMin+lang(' = ')+MyFloatToStr(Fwhm2,2)); //nolang
//      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(TypeStrMin+lang(' = ')+MyFloatToStr(Fwhm2,2)); //nolang
      end;

   if Fwhm2>config.FwhmStopSlow then
      begin
      Retournement:=False;
      // Si c'est moins bien de plus que la tolerance, on inverse, et on divise par 2
//      if Fwhm2>Fwhm1+Config.ToleranceFwhm/100*Config.FwhmStopSlow then
      if Fwhm2>Fwhm1 then
         begin
         Retournement:=True;
         WriteSpy(lang('C''est moins bien, on change de sens'));
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('C''est moins bien, on change de sens'));
         if Direction=mapAvant then Direction:=mapArriere else Direction:=mapAvant;
         if Direction=mapAvant then
            begin
            WriteSpy(lang('Direction vers l''avant'));
            if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Direction vers l''avant'));
            end;
         if Direction=mapArriere then
            begin
            WriteSpy(lang('Direction vers l''arrière'));
            if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Direction vers l''arrière'));
            end;
         if DelaiFoc>2*config.DelaiFocSlowMin then DelaiFoc:=DelaiFoc/2 else DelaiFoc:=Config.DelaiFocSlowMin;
         end
      else
      // Si c'est mieux on continue pareil
         begin
         WriteSpy(lang('C''est mieux, on continue dans le même sens'));
         if Assigned(pop_map_monitor) then
            pop_map_monitor.AddMessage(lang('C''est mieux, on continue dans le même sens'));
         end;

      Focuser.FocuserMoveTime(Direction,Vitesse,DelaiFoc);
      if not OK then
         begin
         MyMessage:=Focuser.GetError;
         WriteSpy(MyMessage);
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
         FocuserDisconnect;
         raise MyError.Create(MyMessage);
         end;
      end;

   Fwhm1:=Fwhm2;
   end;

// Mise au point finie
WriteSpy(TypeStr+'<'+TypeStr+lang(' d''arrêt vitesse lente'));
WriteSpy(lang('Réussie'));
if Assigned(pop_map_monitor) then
   begin
   pop_map_monitor.AddMessage(TypeStr+'<'+TypeStr+lang(' d''arrêt vitesse lente'));
   pop_map_monitor.AddMessage(lang('Réussie'));
   end;

// Seeing a ajouter
Seeing:=ArcTan(Sqrt((Sqr(Fwhm2*Camera.GetXPixelSize/1e6)/2
   +Sqr(Fwhm2*Camera.GetYPixelSize/1e6)/2))/Config.FocaleTele*1000)*180/Pi*3600;

WriteSpy(lang('Seeing = ')+MyFloatToStr(Seeing,2)+
   lang(' ArcSec ( ')+MyFloatToStr(Fwhm2,2)+
   lang(' Pixels )'));
if Assigned(pop_map_monitor) then
   pop_map_monitor.AddMessage(lang('Seeing = ')+MyFloatToStr(Seeing,2)+
      lang(' ArcSec ( ')+MyFloatToStr(Fwhm2,2)+
      lang(' Pixels )'));


finally
pop_camera.pop_image_acq.Bloque:=False;
TesteFocalisation:=False;
if CorrectionSave then Focuser.SetCorrectionOn else Focuser.SetCorrectionOff;
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   FocuserDisconnect;
   raise MyError.Create(MyMessage);
   end;
btn_manuel.Enabled:=True;
btn_auto.Enabled:=True;
Button1.Enabled:=True;
Button5.Enabled:=True;
Edit5.Enabled:=True;
SpinButton2.Enabled:=True;
end;

end;

procedure Tpop_map.btn_autoClick(Sender: TObject);
begin
TypeMapMonitor:='AutoA'; //nolang

if pop_map_monitor=nil then pop_map_monitor:=tpop_map_monitor.Create(Application)
else
   begin
   pop_map_monitor.RAZ;
   pop_map_monitor.Update;
   end;
pop_map_monitor.Show;
StopMap:=False;
//MapAuto;
end;

procedure Tpop_map.btn_manuelClick(Sender: TObject);
begin
// Pour les tests
FWHMTestCourant:=5;

TypeMapMonitor:='Manuel'; //nolang

if pop_map_monitor=nil then pop_map_monitor:=tpop_map_monitor.Create(Application)
else
   begin
   pop_map_monitor.RAZ;
   pop_map_monitor.Update;
   end;
pop_map_monitor.Show;
StopMap:=False;
//Manuel;
end;

procedure Tpop_map.MAPManuel;
var
   xx,yy:Integer;
   xxd,yyd:Double;
   ValMax:Double;
   LargFen:Integer;
   Fin:Boolean;
   PSF:TPSF;
   Max,Min,Mediane:SmallInt;
   Moy,Ecart:Double;
   DateTime:TDateTime;
   ImgNil:PTabImgDouble;
   Vitesse:Integer;
   XCentre,YCentre,Diametre:Double;
   ImgDoubleNil:PTabImgDouble;
   OK:Boolean;
   MyMessage:string;
   NbEchec:Integer;
   ValDesature:Integer;
   Hour,JJ:Double;
begin
TypeMapMonitor:='Manuel'; //nolang

btn_manuel.Enabled:=False;
btn_auto.Enabled:=False;
Button5.Enabled:=False;
Button6.Enabled:=False;
Button1.Enabled:=False;
Edit5.Enabled:=False;
SpinButton2.Enabled:=False;

TesteFocalisation:=True;

if pop_camera.pop_image_acq=nil then
    pop_camera.pop_image_acq:=tpop_image.Create(Application);
pop_camera.pop_image_acq.Bloque:=True;
pop_camera.pop_image_acq.IsUsedForAcq:=True;
if pop_map_monitor=nil then pop_map_monitor:=tpop_map_monitor.create(application);
pop_map_monitor.RAZ;
pop_map_monitor.Show;
pop_map_monitor.NbPointsSerie:=1;

case Config.TypeMesureFWHM of
   0:begin
     pop_map_monitor.TypeStr:=lang('FWHM');
     pop_map_monitor.TypeStrMoy:=lang('FWHM moyenne');
     pop_map_monitor.TypeStrMin:=lang('FWHM minimale');
     end;
   1:begin
     pop_map_monitor.TypeStr:=lang('HFD');
     pop_map_monitor.TypeStrMoy:=lang('HFD moyen');
     pop_map_monitor.TypeStrMin:=lang('HFD minimal');
     end;
   end;

if Config.UseMoyenne then
   begin
   pop_map_monitor.Label5.Caption:=pop_map_monitor.TypeStr+lang(' moy (pixels)');
   pop_map_monitor.Label9.Caption:=pop_map_monitor.TypeStr+lang(' moy (arcsec)');
   end
else
   begin
   pop_map_monitor.Label5.Caption:=pop_map_monitor.TypeStr+lang(' min (pixels)');
   pop_map_monitor.Label9.Caption:=pop_map_monitor.TypeStr+lang(' min (arcsec)');
   end;

case pop_map.TrackBar1.Position of
   0:pop_map_monitor.SetMesure(Config.NbEssaiFocFast);
   1:pop_map_monitor.SetMesure(Config.NbEssaiFocSlow);
   end;

StopMap:=False;

Pose:=MyStrToFloat(Edit5.text);
WriteSpy(lang('Temps de pose = ')+MyFloatToStr(Pose,2)
   +' secondes');
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Temps de pose = ')+MyFloatToStr(Pose,2)
   +' secondes');

if not NoirMAPAcquis  and CheckBox1.Checked then
   begin
   WriteSpy(lang('Acquisition du noir'));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Acquisition du noir'));
   AcqNoir;
   NoirMAPAcquis:=True;
   end;

try

LargFen:=config.LargFoc;

WriteSpy(lang('Début de la mise au point manuelle'));
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Début de la mise au point manuelle'));

WriteSpy(lang('Recherche des coordonnées de l''étoile la plus brillante'));
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Recherche des coordonnées de l''étoile la plus brillante'));
// Trouver ses coordonnee en Binning 4x4
pop_camera.AcqMaximumBinning(XMap,YMap);
pop_main.SeuilsEnable;
if Camera.IsAValidBinning(4) then
   begin
   XMap:=XMap*4;
   YMap:=YMap*4;
   end
else
   begin
   XMap:=XMap*3;
   YMap:=YMap*3;
   end;

WriteSpy(lang('Coordonnées de l''étoile X = ')+IntToStr(XMap)
   +' Y = '+IntToStr(YMap)); //nolang
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Coordonnées de l''étoile X = ')+IntToStr(XMap)
   +' Y = '+IntToStr(YMap)); //nolang
// Premiere aquisition de l'etoile
WriteSpy(lang('Passage en vignette'));
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Passage en vignette'));

if (XMap>LargFen+1) and (YMap>LargFen+1) and (XMap<Camera.GetXSize-LargFen) and (YMap<Camera.GetYSize-LargFen) then
   begin
   pop_camera.Acquisition(XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen,Pose,1,False);

   // Pour Valmax
   GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);


   //Soustraction du noir
   if NoirMAPAcquis  and CheckBox1.Checked then
      begin
      GetImgPart(MemPicNoir,MemPicNoirDouble,VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
         1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,pop_map.XMap-LargFen,pop_map.YMap-LargFen,
         pop_map.XMap+LargFen,pop_map.YMap+LargFen);
      Soust(pop_camera.pop_image_acq.DataInt,VignetteNoir,pop_camera.pop_image_acq.DataDouble,VignetteNoirDouble,
         pop_camera.pop_image_acq.ImgInfos.TypeData,1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
         pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy);
      FreememImg(VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
         pop_camera.pop_image_acq.ImgInfos.TypeData,1);
      end;

   pop_camera.pop_image_acq.AjusteFenetre;   
   pop_camera.pop_image_acq.VisuAutoEtoiles;
   if Assigned(pop_map_monitor) then pop_map_monitor.AfficheImage(pop_camera.pop_image_acq);
   end
// A FAIRE Plus tard -> trouver une autre etoile
else
   begin
   WriteSpy(lang('Etoile trop près du bord'));
   WriteSpy(lang('Arrêt de la mise au point manuelle'));
   if Assigned(pop_map_monitor) then
      begin
      pop_map_monitor.AddMessage(lang('Etoile trop près du bord'));
      pop_map_monitor.AddMessage(lang('Arrêt de la mise au point manuelle'));
      pop_map_monitor.Button3.Enabled:=True;
      pop_map_monitor.Button4.Enabled:=False;
      end;
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;

// Pour centrer
case Config.TypeMesureFWHM of
   0:begin
     XMap:=XMap-LargFen+Round(xx);
     YMap:=YMap-LargFen+Round(yy);
     end;
   1:begin
     HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,2*LargFen+1,
        2*LargFen+1,xxd,yyd,Diametre);
     XMap:=XMap-LargFen+Round(xxd);
     YMap:=YMap-LargFen+Round(yyd);
     end;
   end;

if Config.Verbose then
   begin
   WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
//   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
   end;

{UnSature:=False;
if ValMax>=Camera.GetSaturationLevel then
   begin
   WriteSpy(lang('Etoile saturée, on tente de la désaturer'));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Etoile saturée, on tente de la désaturer'));
   UnSature:=True;
   end;}

{if ValMax>=Camera.GetSaturationLevel then if Desature(ValMax)<>0 then
   begin
   if Assigned(pop_map_monitor) then
      begin
      pop_map_monitor.Button3.Enabled:=True;
      pop_map_monitor.Button4.Enabled:=False;
      end;
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;}

{while (ValMax>=Camera.GetSaturationLevel) and (Pose>config.MinPose) do
   begin

   if StopMap then
      begin
      while pop_camera.PoseEnCours do Application.ProcessMessages;
      WriteSpy(lang('Arrêt de la mise au point effectué'));
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Arrêt de la mise au point effectué'));
      StopMap:=False;
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;

   if (Pose/2>config.MinPose) then
      begin
      WriteSpy(lang('On divise le temps de pose par 2'));
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('On divise le temps de pose par 2'));
      Pose:=Pose/2;
      end
   else
      begin
      Pose:=config.MinPose;
      WriteSpy(lang('Temps de pose minimum atteint'));
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Temps de pose minimum atteint'));
      end;
   WriteSpy(lang('Temps de pose = ')+MyFloatToStr(Pose,2));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Temps de pose = ')+MyFloatToStr(Pose,2));

   if (XMap>LargFen+1) and (YMap>LargFen+1) and (XMap<Camera.GetXSize-LargFen) and (YMap<Camera.GetYSize-LargFen) then
      begin
      pop_camera.Acquisition(XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen,Pose,1,False);

      // Pour Valmax
      GetMax(pop_camera.pop_image_acq.dataInt,ImgNil,2,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);

      //Soustraction du noir
      if NoirMAPAcquis  and CheckBox1.Checked then
         begin
         GetImgPart(MemPicNoir,ImgDoubleNil,VignetteNoir,ImgDoubleNil,2,1,pop_camera.pop_image_acq.ImgInfos.Sx,
            pop_camera.pop_image_acq.ImgInfos.Sy,XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen);
         Soust(pop_camera.pop_image_acq.DataInt,VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_camera.pop_image_acq.ImgInfos.Sx,
            pop_camera.pop_image_acq.ImgInfos.Sy,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy);
         FreememImg(VignetteNoir,ImgDoubleNil,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,2,1);
         end;

      pop_camera.pop_image_acq.AjusteFenetre;
      pop_camera.pop_image_acq.VisuAutoEtoiles;
      if Assigned(pop_map_monitor) then pop_map_monitor.AfficheImage(pop_camera.pop_image_acq);
      end
   else
      begin
      WriteSpy(lang('Etoile trop près du bord'));
      WriteSpy(lang('On arrête'));
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('Etoile trop près du bord'));
         pop_map_monitor.AddMessage(lang('On arrête'));
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;

   end;

if ValMax>=Camera.GetSaturationLevel then
   begin
   WriteSpy(lang('L''étoile reste saturée, on arrête'));
   WriteSpy(lang('Cherchez une étoile moins brillante'));
   if Assigned(pop_map_monitor) then
      begin
      pop_map_monitor.AddMessage(lang('L''étoile reste saturée, on arrête'));
      pop_map_monitor.AddMessage(lang('Cherchez une étoile moins brillante'));
      end;
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end
else
   begin
   if Unsature then
      begin
      WriteSpy(lang('L''étoile n''est plus saturée, on peut continuer'));
      pop_map_monitor.AddMessage(lang('L''étoile n''est plus saturée, on peut continuer'));
      end;
   end;}

{// Desaturer en 1x1
// Si le maxi est sature on baisse le temps de pose
WriteSpy(lang('Désaturation de l''étoile si nécessaire'));
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Désaturation de l''étoile si nécessaire'));
//while (ValMax>config.Satur) and (Pose>config.MinPose) do
while (ValMax>=Camera.GetSaturationLevel) and (Pose>config.MinPose) do
   begin
   if StopMap then
      begin
      while pop_camera.PoseEnCours do Application.ProcessMessages;
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Arrêt de la mise au point manuelle'));
      StopMap:=False;
      MapManuelle:=False;
      Exit;
      pop_camera.pop_image_acq.Bloque:=False;
      end;
   Pose:=Pose/2;
   if (x>LargFen+1) and (y>LargFen+1) and (x<Camera.GetXSize-LargFen) and (y<Camera.GetYSize-LargFen) then
      begin
      pop_camera.Acquisition(x-LargFen,y-LargFen,x+LargFen,y+LargFen,Pose,1,False);
      pop_camera.pop_image_acq.AjusteFenetre;
      pop_camera.pop_image_acq.VisuAutoEtoiles;
      if Assigned(pop_map_monitor) then pop_map_monitor.AfficheImage(pop_camera.pop_image_acq);
      end
   else
      begin
      WriteSpy(lang('Etoile trop près du bord'));
      WriteSpy(lang('Arrêt de la mise au point manuelle'));
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('Etoile trop près du bord'));
         pop_map_monitor.AddMessage(lang('Arrêt de la mise au point manuelle'));
         end;
      Exit;
      pop_camera.pop_image_acq.Bloque:=False;
      end;
   GetMax(pop_camera.pop_image_acq.dataInt,ImgNil,2,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);
   x:=x-LargFen+xx;
   y:=y-LargFen+yy;
   end;
if Pose<=config.MinPose then
   begin
   WriteSpy(lang('Temps de pose mini atteint j''arrête'));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Temps de pose mini atteint j''arrête'));
   end;}

Max:=Round(ValMax/2);

// Corriger les coordonnées pour mettre l'etoile au centre
// Corriger x et y en fonction de xx et yy
//GetMax(pop_camera.pop_image_acq.DataInt,ImgNil,2,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);
//x:=x-LargFen+xx;
//y:=y-LargFen+yy;

Fin:=False;
MapManuelle:=True;
StopGetPos:=True;

try

NbEchec:=0; //toto
while not(Fin) and (NbEchec<config.NbEssaiCentroMaxi) do
   begin
   if StopMap then
      begin
      while pop_camera.PoseEnCours do Application.ProcessMessages;
      WriteSpy(lang('Arrêt de la mise au point effectué'));
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Arrêt de la mise au point effectué'));
      StopMap:=False;
      MapManuelle:=False;
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;

   // Aquisition
   if (XMap>LargFen+1) and (YMap>LargFen+1) and (XMap<Camera.GetXSize-LargFen) and (YMap<Camera.GetYSize-LargFen) then
      begin
      pop_camera.Acquisition(XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen,Pose,1,False);

      GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
         pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);

      if Config.Verbose then
         begin
         WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
//         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
         end;
      if ValMax>=Camera.GetSaturationLevel then
         begin
         ValDesature:=Desature(ValMax,True);
         if ValDesature<0 then
            begin
            MapManuelle:=False;
            pop_camera.pop_image_acq.Bloque:=False;
            Exit;
            end;
         end;

      //Soustraction du noir
      if NoirMAPAcquis  and CheckBox1.Checked then
         begin
         GetImgPart(MemPicNoir,MemPicNoirDouble,VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
            1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,pop_map.XMap-LargFen,pop_map.YMap-LargFen,
            pop_map.XMap+LargFen,pop_map.YMap+LargFen);
         Soust(pop_camera.pop_image_acq.DataInt,VignetteNoir,pop_camera.pop_image_acq.DataDouble,VignetteNoirDouble,
            pop_camera.pop_image_acq.ImgInfos.TypeData,1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
            pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy);
         FreememImg(VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
            pop_camera.pop_image_acq.ImgInfos.TypeData,1);
         end;

      pop_camera.pop_image_acq.AjusteFenetre;
      pop_camera.pop_image_acq.VisuAutoEtoiles;
      if Assigned(pop_map_monitor) then pop_map_monitor.AfficheImage(pop_camera.pop_image_acq);
      end
   else
      begin
      WriteSpy(lang('Etoile trop près du bord'));
      WriteSpy(lang('Arrêt de la mise au point manuelle'));
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('Etoile trop près du bord'));
         pop_map_monitor.AddMessage(lang('Arrêt de la mise au point manuelle'));
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;

   // Modelisation
   case Config.TypeMesureFWHM of
//      0:ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*LargFen+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
      0:ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
           2*LargFen+1,TGauss,LowPrecision,LowSelect,0,PSF);
      1:begin
        HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,2*LargFen+1,
           2*LargFen+1,XCentre,YCentre,Diametre);
        // Pour corriger la difference entre les deux mesures pour FWHM=4
//        Diametre:=Diametre/4.5*3.75;
        PSF.Flux:=0;
        if Diametre=-1 then PSF.Flux:=-1;
        PSF.X:=XCentre;
        PSF.Y:=YCentre;
        PSF.Sigma:=Diametre;
//        if Diametre<4 then ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*LargFen+1,xx,yy,TGauss,LowPrecision,0,PSF);
        end;
      end;

   if PSF.Flux=-1 then
      begin
      Inc(NbEchec);
      WriteSpy(lang('Echec de la modélisation n° ')+IntToStr(NbEchec));
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Echec de la modélisation n° ')+IntToStr(NbEchec));
      end
   else
      begin
      NbEchec:=0;
      // Affichage de la FWHM
//      GetMax(pop_camera.pop_image_acq.dataInt,ImgNil,2,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);
      if Config.TypeCamera<>Virtuelle then
         begin
         XMap:=XMap-LargFen+Round(PSF.X);
         YMap:=YMap-LargFen+Round(PSF.Y);
         end;
//      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(IntToStr(XMap)+'/'+IntToStr(YMap));

      Hour:=GetHourDT;
      WriteSpy('GetHourDT = '+FloatToStr(Hour));
      JJ:=HeureToJourJulien(Hour);
      WriteSpy('JJ = '+FloatToStr(JJ));      
      pop_map_monitor.AddWithMessage(JJ,PSF.Sigma,False);
      pop_map_monitor.AfficheCercle(PSF.X,PSF.Y,PSF.Sigma);

//      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('FWHM = ')+MyFloatToStr(PSF.Sigma,2));
      end;

   if DoMap then
      begin
      pop_map_monitor.AddMarque(HeureToJourJulien(GetHourDT),PSF.Sigma);

      if TypeMap=lang('Avant') then
         begin
         if TrackBar1.Position=0 then Vitesse:=mapRapide else Vitesse:=mapLent;
         Ok:=Focuser.FocuserMoveTime(mapAvant,Vitesse,TimeMap);
         if not OK then
            begin
            MyMessage:=Focuser.GetError;
            WriteSpy(MyMessage);
            if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
            FocuserDisconnect;
            raise MyError.Create(MyMessage);
            end;
         end;

      if TypeMap=lang('Arriere') then
         begin
         if TrackBar1.Position=0 then Vitesse:=mapRapide else Vitesse:=mapLent;
         OK:=Focuser.FocuserMoveTime(mapArriere,Vitesse,TimeMap);
         if not OK then
            begin
            MyMessage:=Focuser.GetError;
            WriteSpy(MyMessage);
            if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
            FocuserDisconnect;
            raise MyError.Create(MyMessage);
            end;
         end;

      DoMap:=False;

      if not MapManuelle then
         begin
         btn_manuel.Enabled:=True;
         btn_auto.Enabled:=True;
         Button5.Enabled:=True;
         Button1.Enabled:=True;
         end;

      BitBtn1.Enabled:=True;
      BitBtn2.Enabled:=True;
      BitBtn3.Enabled:=True;
      BitBtn4.Enabled:=True;
      delai_ms.Enabled:=True;
      SpinButton1.Enabled:=True;
      Button2.Enabled:=True;
      Button3.Enabled:=True;
      Button4.Enabled:=True;
      Edit1.Enabled:=True;
      Label1.Enabled:=True;
      Panel1.Enabled:=True;
      TrackBar1.Enabled:=True;

      end;
   end;

// Trop d'echec de la modélisation
if NbEchec=config.NbEssaiCentroMaxi then
   begin
   WriteSpy(lang('On a atteint le nombre maxi d''échecs de modélisation, on arrête'));
   WriteSpy('Changez d''étoile et/ou agrandissez la fenêtre de modélisation');
   if Assigned(pop_map_monitor) then
      begin
      pop_map_monitor.AddMessage(lang('On a atteint le nombre maxi d''échecs de modélisation, on arrête'));
      pop_map_monitor.AddMessage('Changez d''étoile et/ou agrandissez la fenêtre de modélisation');
      pop_map_monitor.Button3.Enabled:=True;
      pop_map_monitor.Button4.Enabled:=False;
      end;
   pop_camera.pop_image_acq.Bloque:=False;

   end;

finally
MapManuelle:=False;
StopGetPos:=False;
TesteFocalisation:=False;
end;

finally
pop_camera.pop_image_acq.Bloque:=False;
//btn_manuel.Enabled:=True;
//btn_auto.Enabled:=True;
//Button5.Enabled:=True;
//Button6.Enabled:=True;
//Button1.Enabled:=True;
//Edit5.Enabled:=True;
//SpinButton2.Enabled:=True;
end;
end;

procedure Tpop_map.FormCreate(Sender: TObject);
begin
StopMap:=False;
MapManuelle:=False;
MoveFocuser:=False;

if Config.CameraBranchee then
   begin
   btn_auto.Enabled:=True;
   Button1.Enabled:=True;
   btn_manuel.Enabled:=True;
   Button5.Enabled:=True;
   Button6.Enabled:=True;
   Button7.Enabled:=True;
   Button8.Enabled:=True;
   end
else
   begin
   btn_auto.Enabled:=False;
   Button1.Enabled:=False;
   btn_manuel.Enabled:=False;
   Button5.Enabled:=False;
   Button6.Enabled:=False;
   Button7.Enabled:=False;
   Button8.Enabled:=False;         
   end;

{if not(FileExists('AutoV.txt')) then //nolang
   begin
   Button5.Visible:=False;
   Button6.Visible:=False;
   Button7.Visible:=False;
   end;}
end;

procedure Tpop_map.FormShow(Sender: TObject);
var
   Position:Integer;
   OK:Boolean;
   MyMessage:string;
   Ini:TMemIniFile;
   Path:string;
   Valeur:Integer;
begin
// Lit la pos
Path:=ExtractFilePath(Application.Exename);
Ini:=TMemIniFile.Create(Path+'TeleAuto.ini'); //nolang
try
Valeur:=StrToInt(Ini.ReadString('WindowsPos','MapTop',IntToStr(Self.Top)));
if Valeur<>0 then Top:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','MapLeft',IntToStr(Self.Left)));
if Valeur<>0 then Left:=Valeur;
finally
Ini.UpdateFile;
Ini.Free;
end;

Left:=Screen.Width-Width;
UpDateLang(Self);

DansSerie:=False;
DoMap:=False;

if Config.CameraBranchee then
   begin
   btn_auto.Enabled:=True;
   Button1.Enabled:=True;
   btn_manuel.Enabled:=True;
   Button5.Enabled:=True;
   Button6.Enabled:=True;
   Button7.Enabled:=True;
   Button8.Enabled:=True;
   end
else
   begin
   btn_auto.Enabled:=False;
   Button1.Enabled:=False;
   btn_manuel.Enabled:=False;
   Button5.Enabled:=False;
   Button6.Enabled:=False;
   Button7.Enabled:=False;
   Button8.Enabled:=False;   
   end;

if cb_cmde_corr.Checked then OK:=Focuser.SetCorrectionOn else OK:=Focuser.SetCorrectionOff;
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   ShowMessage(MyMessage);
   FocuserDisconnect;
   end;

if not Focuser.Has2Vitesses then Groupbox2.Visible:=False;
if Focuser.PasAPas then
   begin
   Label10.Caption:=lang('Déplacement :');
   Label11.Caption:=lang('Pas');
   Delai_ms.Text:='100'; //nolang
   cb_cmde_corr.Visible:=False;
   GroupBox4.Caption:=lang('Raquette par pas');
   OK:=Focuser.GetPosition(Position);
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      FocuserDisconnect;
      raise MyError.Create(MyMessage);
      end;
   Panel1.Caption:=IntToStr(Position);
   Edit1.Text:=IntToStr(Position);
//   Height:=446;
   Height:=422;
   end
else
   begin
   Groupbox5.Visible:=False;
//   Height:=345;
   Height:=321;
   end;


end;

procedure Tpop_map.Button2Click(Sender: TObject);
var
   Position:Integer;
   OK:boolean;
   MyMessage:string;
begin
OK:=Focuser.GetPosition(Position);
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   ShowMessage(MyMessage);
   FocuserDisconnect;
   end
else
   Panel1.Caption:=IntToStr(Position);
end;

procedure Tpop_map.Button3Click(Sender: TObject);
var
   Position:Integer;
   OK:boolean;
   MyMessage:string;
begin
OK:=Focuser.SetPosition(StrToInt(Edit1.Text));
OK:=Focuser.GetPosition(Position);
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   ShowMessage(MyMessage);
   FocuserDisconnect;
   end
else
   Panel1.Caption:=IntToStr(Position);
end;

procedure Tpop_map.Button4Click(Sender: TObject);
var
   Position:Integer;
   OK:boolean;
   MyMessage:string;
begin
OK:=Focuser.GotoPosition(StrToInt(Edit1.Text));
OK:=Focuser.GetPosition(Position);
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   ShowMessage(MyMessage);
   FocuserDisconnect;
   end
else
Panel1.Caption:=IntToStr(Position);
end;

procedure Tpop_map.BitBtn1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   Vitesse:Integer;
   OK:Boolean;
   MyMessage,StrVitesse,StrSens:string;
begin
btn_auto.Enabled:=False;
Button1.Enabled:=False;
btn_manuel.Enabled:=False;
Button5.Enabled:=False;
Button6.Enabled:=False;
Button7.Enabled:=False;
Button8.Enabled:=False;

BitBtn2.Enabled:=False;
BitBtn3.Enabled:=False;
BitBtn4.Enabled:=False;
delai_ms.Enabled:=False;
SpinButton1.Enabled:=False;
Button2.Enabled:=False;
Button3.Enabled:=False;
Button4.Enabled:=False;
Edit1.Enabled:=False;
Label1.Enabled:=False;
Panel1.Enabled:=False;
TrackBar1.Enabled:=False;

img_last_command.Picture.Bitmap.Assign(BitBtn1.Glyph);

if TrackBar1.Position=0 then Vitesse:=mapRapide else Vitesse:=mapLent;
if Vitesse=MapLent then StrVitesse:=lang('Vitesse lente');
if Vitesse=MapRapide then StrVitesse:=lang('Vitesse rapide');
StrSens:=lang('Marche avant');
WriteSpy(lang('Focuseur : ')+
   StrSens+' / '+StrVitesse);

if not(MoveFocuser) then
   begin
   MoveFocuser:=True;
   WriteSpy('Début de l''impulsion');
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage('Début de l''impulsion');
   if Config.FocInversion then
      OK:=Focuser.DeplaceMapTime(mapArriere,Vitesse)
   else
      OK:=Focuser.DeplaceMapTime(mapAvant,Vitesse);
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      ShowMessage(MyMessage);
      end;
   end;
end;

procedure Tpop_map.BitBtn1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   Position:Integer;
   OK:boolean;
   MyMessage:string;
begin
try

if MoveFocuser then
   begin
   MoveFocuser:=False;

   WriteSpy('Fin de l''impulsion');
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage('Fin de l''impulsion');
   OK:=Focuser.ArreteMapTime;
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      raise MyError.Create(MyMessage);
      end;

   if Focuser.PasAPas then
      begin
      OK:=Focuser.GetPosition(Position);
      if not OK then
         begin
         MyMessage:=Focuser.GetError;
         WriteSpy(MyMessage);
         raise MyError.Create(MyMessage);
         end
      else
         Panel1.Caption:=IntToStr(Position);
      end;

   end;

finally
if not MapManuelle then
   begin
   btn_auto.Enabled:=True;
   Button1.Enabled:=True;
   btn_manuel.Enabled:=True;
   end;

if Config.CameraBranchee then
   begin
   btn_auto.Enabled:=True;
   Button1.Enabled:=True;
   btn_manuel.Enabled:=True;
   Button5.Enabled:=True;
   Button6.Enabled:=True;
   Button7.Enabled:=True;
   Button8.Enabled:=True;
   end
else
   begin
   btn_auto.Enabled:=False;
   Button1.Enabled:=False;
   btn_manuel.Enabled:=False;
   Button5.Enabled:=False;
   Button6.Enabled:=False;
   Button7.Enabled:=False;
   Button8.Enabled:=False;   
   end;

BitBtn2.Enabled:=True;
BitBtn3.Enabled:=True;
BitBtn4.Enabled:=True;
delai_ms.Enabled:=True;
SpinButton1.Enabled:=True;
Button2.Enabled:=True;
Button3.Enabled:=True;
Button4.Enabled:=True;
Edit1.Enabled:=True;
Label1.Enabled:=True;
Panel1.Enabled:=True;
TrackBar1.Enabled:=True;
end;
end;

procedure Tpop_map.BitBtn2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   Vitesse:Integer;
   OK:Boolean;
   MyMessage,StrVitesse,StrSens:string;
begin
btn_auto.Enabled:=False;
Button1.Enabled:=False;
btn_manuel.Enabled:=False;
Button5.Enabled:=False;
Button6.Enabled:=False;
Button7.Enabled:=False;
Button8.Enabled:=False;

BitBtn1.Enabled:=False;
BitBtn3.Enabled:=False;
BitBtn4.Enabled:=False;
delai_ms.Enabled:=False;
SpinButton1.Enabled:=False;
Button2.Enabled:=False;
Button3.Enabled:=False;
Button4.Enabled:=False;
Edit1.Enabled:=False;
Label1.Enabled:=False;
Panel1.Enabled:=False;
TrackBar1.Enabled:=False;

img_last_command.Picture.Bitmap.Assign(BitBtn2.Glyph);

if TrackBar1.Position=0 then Vitesse:=mapRapide else Vitesse:=mapLent;
if Vitesse=MapLent then StrVitesse:=lang('Vitesse lente');
if Vitesse=MapRapide then StrVitesse:=lang('Vitesse rapide');
StrSens:=lang('Marche arrière');
WriteSpy(lang('Focuseur : ')+
   StrSens+' / '+StrVitesse); //nolang

if not(MoveFocuser) then
   begin
   MoveFocuser:=True;
   WriteSpy('Début de l''impulsion');
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage('Début de l''impulsion');
   if Config.FocInversion then
      OK:=Focuser.DeplaceMapTime(mapAvant,Vitesse)
   else
      OK:=Focuser.DeplaceMapTime(mapArriere,Vitesse);
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      ShowMessage(MyMessage);
      end;
   end;
end;

procedure Tpop_map.BitBtn2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   Position:Integer;
   OK,IsPasAPas:boolean;
   MyMessage:string;
begin
try

if MoveFocuser then
   begin
   MoveFocuser:=False;
   WriteSpy('Fin de l''impulsion');
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage('Fin de l''impulsion');
   OK:=Focuser.ArreteMapTime;
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      raise MyError.Create(MyMessage);
      end;

   if Focuser.PasAPas then
      begin
      OK:=Focuser.GetPosition(Position);
      if not OK then
         begin
         MyMessage:=Focuser.GetError;
         WriteSpy(MyMessage);
         raise MyError.Create(MyMessage);
         end
      else
         Panel1.Caption:=IntToStr(Position);
      end;
   end;

finally
if not MapManuelle then
   begin
   btn_auto.Enabled:=True;
   Button1.Enabled:=True;
   btn_manuel.Enabled:=True;
   end;

if Config.CameraBranchee then
   begin
   btn_auto.Enabled:=True;
   Button1.Enabled:=True;
   btn_manuel.Enabled:=True;
   Button5.Enabled:=True;
   Button6.Enabled:=True;
   Button7.Enabled:=True;
   Button8.Enabled:=True;
   end
else
   begin
   btn_auto.Enabled:=False;
   Button1.Enabled:=False;
   btn_manuel.Enabled:=False;
   Button5.Enabled:=False;
   Button6.Enabled:=False;
   Button7.Enabled:=False;
   Button8.Enabled:=False;
   end;
   
BitBtn1.Enabled:=True;
BitBtn3.Enabled:=True;
BitBtn4.Enabled:=True;
delai_ms.Enabled:=True;
SpinButton1.Enabled:=True;
Button2.Enabled:=True;
Button3.Enabled:=True;
Button4.Enabled:=True;
Edit1.Enabled:=True;
Label1.Enabled:=True;
Panel1.Enabled:=True;
TrackBar1.Enabled:=True;
end;
end;


function Tpop_map.AcqEtMesure:Byte;
var
   xx,yy,LargFen:Integer;
   ImgDoubleNil:PTabImgDouble;
   PSF:TPSF;
   XCentre,YCentre,Diametre:Double;
begin
Result:=0;

LargFen:=config.LargFoc;

// Aquisition
if (XMap>LargFen+1) and (YMap>LargFen+1) and (XMap<Camera.GetXSize-LargFen) and (YMap<Camera.GetYSize-LargFen) then
   begin
   pop_camera.Acquisition(XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen,Pose,1,False);

   //Soustraction du noir
   if NoirMAPAcquis  and CheckBox1.Checked then
      begin
      GetImgPart(MemPicNoir,MemPicNoirDouble,VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
         1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,pop_map.XMap-LargFen,pop_map.YMap-LargFen,
         pop_map.XMap+LargFen,pop_map.YMap+LargFen);
      Soust(pop_camera.pop_image_acq.DataInt,VignetteNoir,pop_camera.pop_image_acq.DataDouble,VignetteNoirDouble,
         pop_camera.pop_image_acq.ImgInfos.TypeData,1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
         pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy);
      FreememImg(VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
         pop_camera.pop_image_acq.ImgInfos.TypeData,1);
      end;

   pop_camera.pop_image_acq.AjusteFenetre;
   pop_camera.pop_image_acq.VisuAutoEtoiles;
   if Assigned(pop_map_monitor) then pop_map_monitor.AfficheImage(pop_camera.pop_image_acq);
   end
else
   begin
   WriteSpy(lang('Etoile trop près du bord'));
   WriteSpy(lang('Arrêt de la mise au point manuelle'));
   if Assigned(pop_map_monitor) then
      begin
      pop_map_monitor.AddMessage(lang('Etoile trop près du bord'));
      pop_map_monitor.AddMessage(lang('Arrêt de la mise au point manuelle'));
      pop_map_monitor.Button3.Enabled:=True;
      pop_map_monitor.Button4.Enabled:=False;
      end;
   Result:=1;
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;

// Modelisation
case Config.TypeMesureFWHM of
//   0:ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*LargFen+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
   0:ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
        2*LargFen+1,TGauss,LowPrecision,LowSelect,0,PSF);
   1:begin
     HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,2*LargFen+1,
        2*LargFen+1,XCentre,YCentre,Diametre);
     PSF.Flux:=0;
     if Diametre=-1 then PSF.Flux:=-1;
     PSF.X:=XCentre;
     PSF.Y:=YCentre;
     PSF.Sigma:=Diametre;
     end;
   end;

if PSF.Flux=-1 then
   begin
   WriteSpy(lang('Echec de la modélisation'));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Echec de la modélisation'));
   Result:=2;
   end
else
   begin
   XMap:=XMap-LargFen+Round(PSF.X);
   YMap:=YMap-LargFen+Round(PSF.Y);

   pop_map_monitor.AddMarque(HeureToJourJulien(GetHourDT),PSF.Sigma);   
   pop_map_monitor.AddWithMessage(HeureToJourJulien(GetHourDT),PSF.Sigma,False);
   pop_map_monitor.AfficheCercle(PSF.X,PSF.Y,PSF.Sigma);
   end;
end;

procedure Tpop_map.BitBtn3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   OK:boolean;
   MyMessage:string;
   TimeInit:TDateTime;
   TimeFirst:Double;
   Vitesse,i:Integer;
begin
if cb_cmde_corr.Checked then OK:=Focuser.SetCorrectionOn else OK:=Focuser.SetCorrectionOff;
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   raise MyError.Create(MyMessage);
   end;

btn_auto.Enabled:=False;
Button1.Enabled:=False;
btn_manuel.Enabled:=False;

btn_auto.Enabled:=False;
Button1.Enabled:=False;
btn_manuel.Enabled:=False;
Button5.Enabled:=False;
Button6.Enabled:=False;
Button7.Enabled:=False;
Button8.Enabled:=False;

BitBtn1.Enabled:=False;
BitBtn2.Enabled:=False;
BitBtn3.Enabled:=False;
BitBtn4.Enabled:=False;
delai_ms.Enabled:=False;
SpinButton1.Enabled:=False;
Button2.Enabled:=False;
Button3.Enabled:=False;
Button4.Enabled:=False;
Edit1.Enabled:=False;
Label1.Enabled:=False;
Panel1.Enabled:=False;
TrackBar1.Enabled:=False;

img_last_command.Picture.Bitmap.Assign(BitBtn3.Glyph);

try
try

if SpinEdit1.Value>1 then
   begin
   for i:=1 to SpinEdit1.Value do
      begin
      DansSerie:=True;
      try
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Manoeuvre ')+IntToStr(i));
      if TrackBar1.Position=0 then Vitesse:=mapRapide else Vitesse:=mapLent;
      OK:=Focuser.FocuserMoveTime(mapAvant,Vitesse,MyStrToFloat(delai_ms.Text));
      if not OK then
         begin
         MyMessage:=Focuser.GetError;
         WriteSpy(MyMessage);
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
         raise MyError.Create(MyMessage);
         end;
      if MapManuelle then AcqEtMesure;

      if StopMap then
         begin
         while pop_camera.PoseEnCours do Application.ProcessMessages;
         WriteSpy(lang('Arrêt de la série effectué'));
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Arrêt de la série effectué'));
         StopMap:=False;

         if not MapManuelle then
            begin
            btn_manuel.Enabled:=True;
            btn_auto.Enabled:=True;
            Button1.Enabled:=True;
            end;

         if Config.CameraBranchee then
            begin
            btn_auto.Enabled:=True;
            Button1.Enabled:=True;
            btn_manuel.Enabled:=True;
            Button5.Enabled:=True;
            Button6.Enabled:=True;
            Button7.Enabled:=True;
            Button8.Enabled:=True;
            end
         else
            begin
            btn_auto.Enabled:=False;
            Button1.Enabled:=False;
            btn_manuel.Enabled:=False;
            Button5.Enabled:=False;
            Button6.Enabled:=False;
            Button7.Enabled:=False;
            Button8.Enabled:=False;
            end;

         BitBtn1.Enabled:=True;
         BitBtn2.Enabled:=True;
         BitBtn3.Enabled:=True;
         BitBtn4.Enabled:=True;
         delai_ms.Enabled:=True;
         SpinButton1.Enabled:=True;
         Button2.Enabled:=True;
         Button3.Enabled:=True;
         Button4.Enabled:=True;
         Edit1.Enabled:=True;
         Label1.Enabled:=True;
         Panel1.Enabled:=True;
         TrackBar1.Enabled:=True;

         Exit;
         end;
      finally
      DansSerie:=False;
      end;
      end;

   if not MapManuelle then
      begin
      btn_manuel.Enabled:=True;
      btn_auto.Enabled:=True;
      Button1.Enabled:=True;
      end;

   if Config.CameraBranchee then
      begin
      btn_auto.Enabled:=True;
      Button1.Enabled:=True;
      btn_manuel.Enabled:=True;
      Button5.Enabled:=True;
      Button6.Enabled:=True;
      Button7.Enabled:=True;
      Button8.Enabled:=True;
      end
   else
      begin
      btn_auto.Enabled:=False;
      Button1.Enabled:=False;
      btn_manuel.Enabled:=False;
      Button5.Enabled:=False;
      Button6.Enabled:=False;
      Button7.Enabled:=False;
      Button8.Enabled:=False;
      end;
      
   BitBtn1.Enabled:=True;
   BitBtn2.Enabled:=True;
   BitBtn3.Enabled:=True;
   BitBtn4.Enabled:=True;
   delai_ms.Enabled:=True;
   SpinButton1.Enabled:=True;
   Button2.Enabled:=True;
   Button3.Enabled:=True;
   Button4.Enabled:=True;
   Edit1.Enabled:=True;
   Label1.Enabled:=True;
   Panel1.Enabled:=True;
   TrackBar1.Enabled:=True;
   end
else
   begin
   if MapManuelle then
      begin
      TimeMap:=MyStrToFloat(delai_ms.Text);
      TypeMap:=lang('Avant');
      DoMap:=True;
      Exit;
      end;

   if TrackBar1.Position=0 then Vitesse:=mapRapide else Vitesse:=mapLent;
   OK:=Focuser.FocuserMoveTime(mapAvant,Vitesse,MyStrToFloat(delai_ms.Text));
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      raise MyError.Create(MyMessage);
      end;

   if not MapManuelle then
      begin
      btn_manuel.Enabled:=True;
      btn_auto.Enabled:=True;
      Button1.Enabled:=True;
      end;

   if Config.CameraBranchee then
      begin
      btn_auto.Enabled:=True;
      Button1.Enabled:=True;
      btn_manuel.Enabled:=True;
      Button5.Enabled:=True;
      Button6.Enabled:=True;
      Button7.Enabled:=True;
      Button8.Enabled:=True;
      end
   else
      begin
      btn_auto.Enabled:=False;
      Button1.Enabled:=False;
      btn_manuel.Enabled:=False;
      Button5.Enabled:=False;
      Button6.Enabled:=False;
      Button7.Enabled:=False;
      Button8.Enabled:=False;
      end;
      
   BitBtn1.Enabled:=True;
   BitBtn2.Enabled:=True;
   BitBtn3.Enabled:=True;
   BitBtn4.Enabled:=True;
   delai_ms.Enabled:=True;
   SpinButton1.Enabled:=True;
   Button2.Enabled:=True;
   Button3.Enabled:=True;
   Button4.Enabled:=True;
   Edit1.Enabled:=True;
   Label1.Enabled:=True;
   Panel1.Enabled:=True;
   TrackBar1.Enabled:=True;

   end;

except
on E:Exception do
   begin
   ShowMessage(E.Message);
   Config.FocuserBranche:=False;
   pop_main.UpdateGUIFocuser;
   end;
end;

finally
end;
end;

procedure Tpop_map.BitBtn4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   TimeInit:TDateTime;
   TimeFirst:Double;
   Vitesse,i:Integer;
   OK:boolean;
   MyMessage:string;
begin
if cb_cmde_corr.Checked then Focuser.SetCorrectionOn else Focuser.SetCorrectionOff;
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   raise MyError.Create(MyMessage);
   end;

btn_auto.Enabled:=False;
Button1.Enabled:=False;
btn_manuel.Enabled:=False;

btn_auto.Enabled:=False;
Button1.Enabled:=False;
btn_manuel.Enabled:=False;
Button5.Enabled:=False;
Button6.Enabled:=False;
Button7.Enabled:=False;
Button8.Enabled:=False;

BitBtn1.Enabled:=False;
BitBtn2.Enabled:=False;
BitBtn3.Enabled:=False;
BitBtn4.Enabled:=False;
delai_ms.Enabled:=False;
SpinButton1.Enabled:=False;
Button2.Enabled:=False;
Button3.Enabled:=False;
Button4.Enabled:=False;
Edit1.Enabled:=False;
Label1.Enabled:=False;
Panel1.Enabled:=False;
TrackBar1.Enabled:=False;

try
try

if SpinEdit1.Value>1 then
   begin
   for i:=1 to SpinEdit1.Value do
      begin
      DansSerie:=True;
      try
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Manoeuvre ')+IntToStr(i));
      if TrackBar1.Position=0 then Vitesse:=mapRapide else Vitesse:=mapLent;
      OK:=Focuser.FocuserMoveTime(mapArriere,Vitesse,MyStrToFloat(delai_ms.Text));
      if not OK then
         begin
         MyMessage:=Focuser.GetError;
         WriteSpy(MyMessage);
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
         raise MyError.Create(MyMessage);
         end;

      if MapManuelle then AcqEtMesure;

      if StopMap then
         begin
         while pop_camera.PoseEnCours do Application.ProcessMessages;
         WriteSpy(lang('Arrêt de la série effectué'));
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Arrêt de la série effectué'));
         StopMap:=False;

         if not MapManuelle then
            begin
            btn_manuel.Enabled:=True;
            btn_auto.Enabled:=True;
            Button1.Enabled:=True;
            end;

         if Config.CameraBranchee then
            begin
            btn_auto.Enabled:=True;
            Button1.Enabled:=True;
            btn_manuel.Enabled:=True;
            Button5.Enabled:=True;
            Button6.Enabled:=True;
            Button7.Enabled:=True;
            Button8.Enabled:=True;
            end
         else
            begin
            btn_auto.Enabled:=False;
            Button1.Enabled:=False;
            btn_manuel.Enabled:=False;
            Button5.Enabled:=False;
            Button6.Enabled:=False;
            Button7.Enabled:=False;
            Button8.Enabled:=False;
            end;
            
         BitBtn1.Enabled:=True;
         BitBtn2.Enabled:=True;
         BitBtn3.Enabled:=True;
         BitBtn4.Enabled:=True;
         delai_ms.Enabled:=True;
         SpinButton1.Enabled:=True;
         Button2.Enabled:=True;
         Button3.Enabled:=True;
         Button4.Enabled:=True;
         Edit1.Enabled:=True;
         Label1.Enabled:=True;
         Panel1.Enabled:=True;
         TrackBar1.Enabled:=True;

         Exit;
         end;
      finally
      DansSerie:=False;
      end;
      end;

   if not MapManuelle then
      begin
      btn_manuel.Enabled:=True;
      btn_auto.Enabled:=True;
      Button1.Enabled:=True;
      end;

   if Config.CameraBranchee then
      begin
      btn_auto.Enabled:=True;
      Button1.Enabled:=True;
      btn_manuel.Enabled:=True;
      Button5.Enabled:=True;
      Button6.Enabled:=True;
      Button7.Enabled:=True;
      Button8.Enabled:=True;
      end
   else
      begin
      btn_auto.Enabled:=False;
      Button1.Enabled:=False;
      btn_manuel.Enabled:=False;
      Button5.Enabled:=False;
      Button6.Enabled:=False;
      Button7.Enabled:=False;
      Button8.Enabled:=False;
      end;

   BitBtn1.Enabled:=True;
   BitBtn2.Enabled:=True;
   BitBtn3.Enabled:=True;
   BitBtn4.Enabled:=True;
   delai_ms.Enabled:=True;
   SpinButton1.Enabled:=True;
   Button2.Enabled:=True;
   Button3.Enabled:=True;
   Button4.Enabled:=True;
   Edit1.Enabled:=True;
   Label1.Enabled:=True;
   Panel1.Enabled:=True;
   TrackBar1.Enabled:=True;
   end
else
   begin
   if MapManuelle then
      begin
      TimeMap:=MyStrToFloat(delai_ms.Text);
      TypeMap:=lang('Arriere');
      DoMap:=True;
      Exit;
      end;

   img_last_command.Picture.Bitmap.Assign(BitBtn4.Glyph);

   if TrackBar1.Position=0 then Vitesse:=mapRapide else Vitesse:=mapLent;
   OK:=Focuser.FocuserMoveTime(mapArriere,Vitesse,MyStrToFloat(delai_ms.Text));
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      raise MyError.Create(MyMessage);
      end;

   if not MapManuelle then
      begin
      btn_auto.Enabled:=True;
      Button1.Enabled:=True;
      btn_manuel.Enabled:=True;
      end;

   if Config.CameraBranchee then
      begin
      btn_auto.Enabled:=True;
      Button1.Enabled:=True;
      btn_manuel.Enabled:=True;
      Button5.Enabled:=True;
      Button6.Enabled:=True;
      Button7.Enabled:=True;
      Button8.Enabled:=True;
      end
   else
      begin
      btn_auto.Enabled:=False;
      Button1.Enabled:=False;
      btn_manuel.Enabled:=False;
      Button5.Enabled:=False;
      Button6.Enabled:=False;
      Button7.Enabled:=False;
      Button8.Enabled:=False;
      end;
      
   BitBtn1.Enabled:=True;
   BitBtn2.Enabled:=True;
   BitBtn3.Enabled:=True;
   BitBtn4.Enabled:=True;
   delai_ms.Enabled:=True;
   SpinButton1.Enabled:=True;
   Button2.Enabled:=True;
   Button3.Enabled:=True;
   Button4.Enabled:=True;
   Edit1.Enabled:=True;
   Label1.Enabled:=True;
   Panel1.Enabled:=True;
   TrackBar1.Enabled:=True;
   end;

except
on E:Exception do
   begin
   ShowMessage(E.Message);
   Config.FocuserBranche:=False;
   pop_main.UpdateGUIFocuser;
   end;
end;

finally
end;
end;

procedure Tpop_map.FormHide(Sender: TObject);
begin
pop_main.ToolButton5.Down:=False;
end;

procedure Tpop_map.AcqNoir;
var
   i:Integer;
begin
// si l'image n'existe pas, on la cree
if pop_camera.pop_image_acq=nil then
   begin
   pop_camera.pop_image_acq:=tpop_image.Create(Application);
   pop_camera.pop_image_acq.IsUsedForTrack:=True;
   pop_camera.pop_image_acq.ImgInfos.TypeData:=CameraSuivi.GetTypeData;
   pop_camera.pop_image_acq.ImgInfos.NbPlans:=CameraSuivi.GetNbPlans;
   end;

VAcqNoir:=True;
pop_camera.Acquisition(1,1,Camera.GetXSize,Camera.GetYSize,1,1,True);
VAcqNoir:=False;

pop_camera.pop_image_acq.AjusteFenetre;
case config.SeuilCamera of
   0:pop_camera.pop_image_acq.VisuAutoEtoiles;
   1:pop_camera.pop_image_acq.VisuAutoPlanetes;
   2:pop_camera.pop_image_acq.VisuAutoMinMax;
   end;
pop_main.SeuilsEnable;

if MemPicNoir<>nil then
   begin
   if Camera.Is16Bits then
      begin
      for i:=1 to SyNoir do Freemem(MemPicNoirDouble^[1]^[i],SxNoir*8);
      Freemem(MemPicNoirDouble^[1],4*SyNoir);
      Freemem(MemPicNoirDouble,4);
      end
   else
      begin
      for i:=1 to SyNoir do Freemem(MemPicNoir^[1]^[i],SxNoir*2);
      Freemem(MemPicNoir^[1],4*SyNoir);
      Freemem(MemPicNoir,4);
      end;
   end;

SxNoir:=pop_camera.pop_image_acq.ImgInfos.Sx;
SyNoir:=pop_camera.pop_image_acq.ImgInfos.Sy;

if Camera.Is16Bits then
   begin
   Getmem(MemPicNoirDouble,4);
   Getmem(MemPicNoirDouble^[1],SyNoir*4);
   for i:=1 to SyNoir do
      begin
      Getmem(MemPicNoirDouble^[1]^[i],SxNoir*8);
      Move(pop_camera.pop_image_acq.DataDouble^[1]^[i]^,MemPicNoirDouble^[1]^[i]^,SxNoir*8);
      end;
   end
else
   begin
   Getmem(MemPicNoir,4);
   Getmem(MemPicNoir^[1],SyNoir*4);
   for i:=1 to SyNoir do
      begin
      Getmem(MemPicNoir^[1]^[i],SxNoir*2);
      Move(pop_camera.pop_image_acq.DataInt^[1]^[i]^,MemPicNoir^[1]^[i]^,SxNoir*2);
      end;
   end;
end;

procedure Tpop_map.Button1Click(Sender: TObject);
begin
WriteSpy(lang('Acquisition du noir'));
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Acquisition du noir'));
AcqNoir;
NoirMAPAcquis:=True;
end;

procedure Tpop_map.TrackBar1Change(Sender: TObject);
begin
//pop_map_monitor.ChangeSpeed;
if Assigned(pop_map_monitor) then
   case pop_map.TrackBar1.Position of
      0:pop_map_monitor.SetMesure(Config.NbEssaiFocFast);
      1:pop_map_monitor.SetMesure(Config.NbEssaiFocSlow);
      end;

end;

procedure Tpop_map.SpinButton2UpClick(Sender: TObject);
var
Pose1,Pose2:Single;
begin
Pose1:=MyStrToFloat(Edit5.Text);
Pose2:=IncrementePose(Pose1);
if Pose1<>Pose2 then Edit5.Text:=MyFloatToStr(Pose2,2);
end;

procedure Tpop_map.SpinButton2DownClick(Sender: TObject);
var
   Pose1,Pose2:Double;
begin
Pose1:=MyStrToFloat(Edit5.Text);
Pose2:=DecrementePose(Pose1);
if Pose1<>Pose2 then Edit5.Text:=MyFloatToStr(Pose2,2);
end;

procedure Tpop_map.SpinButton1DownClick(Sender: TObject);
var
Pose:Single;
begin
Pose:=MyStrToFloat(delai_ms.Text)/2;
if Pose<1 then Pose:=1;
delai_ms.Text:=MyFloatToStr(Pose,2);
end;

procedure Tpop_map.SpinButton1UpClick(Sender: TObject);
var
Pose:Single;
begin
Pose:=MyStrToFloat(delai_ms.Text)*2;
if Pose>5000 then Pose:=5000;
delai_ms.Text:=MyFloatToStr(Pose,2);
end;

procedure Tpop_map.Edit5Change(Sender: TObject);
begin
NoirMAPAcquis:=False;
end;

procedure Tpop_map.WriteMessage(Msg:string);
begin
WriteSpy(Msg);
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(Msg);
if Assigned(pop_calib_autov) then pop_calib_autov.AddMessage(Msg);
end;

//  TVecteur= Array [1..55] of Double;
// FWHMOut est utilisé pour la mesure en même temps du HFD et de la FWHM
// pour la dernière mesure de l'AutoFocusV
function Tpop_map.Serie(var Fwhm:TVecteur;
                        NbMesures:Integer;
                        Add:Boolean;
                        NbAdd:Integer;
                        TypeMesureFWHM:Byte;
                        UseMoyenne:Boolean;
                        var FWHMOut:Double;
                        ErrorSature:Boolean;
                        ShowMarque:Boolean;
                        Color:TColor):Double;
var
   FwhmMin,FwhmMin1,Fwhm0:Double;
   xx,yy,i,j,NbReusit,NbEchec,LargFen:Integer;
   ImgDoubleNil:PTabImgDouble;
   PSF,PSF1:TPSF;
   XCentre,YCentre,Diametre:Double;
   TypeStr,TypeStrMoy,TypeStrMin:string;
   Marque:Boolean;
   Fwhm1:TVecteur;
   Somme:Double;
   ImgNil:PTabImgDouble;
   ValMax:Double;
   ValDesature:Integer;
begin
if not Add then nbAdd:=0;

case TypeMesureFWHM of
   0:begin
     TypeStr:=lang('FWHM');
     TypeStrMoy:=lang('FWHM moyenne');
     TypeStrMin:=lang('FWHM minimale');
     end;
   1,3:begin
     TypeStr:=lang('HFD');
     TypeStrMoy:=lang('HFD moyen');
     TypeStrMin:=lang('HFD minimal');
     end;
   end;

LargFen:=config.LargFoc;

if Assigned(pop_map_monitor) then
   begin
   pop_map_monitor.TypeStr:=TypeStr;
   pop_map_monitor.TypeStrMoy:=TypeStrMoy;
   pop_map_monitor.TypeStrMin:=TypeStrMin;
   if not Add then pop_map_monitor.SetMesure(NbMesures)
   else pop_map_monitor.SetMesureAdd(NbMesures+NbAdd);
   end;

// Première mesure de la FWHM avant deplacement initial
FwhmMin:=MaxDouble;
FwhmMin1:=MaxDouble;
i:=0;
if not Add then NbReusit:=0 else NbReusit:=NbMesures;
NbEchec:=0;
while (NbReusit<NbMesures+NbAdd) and (NbEchec<config.NbEssaiCentroMaxi) do
   begin
   if StopMap then
      begin
      Result:=-2;
      Exit;
      end;

//   WriteMessage(IntToStr(XMap)+' / '+IntToStr(YMap));
   if (XMap>LargFen+1) and (YMap>LargFen+1) and (XMap<Camera.GetXSize-LargFen) and (YMap<Camera.GetYSize-LargFen) then
      begin
      pop_camera.Acquisition(XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen,Pose,1,False);

      // Pour Valmax
      GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
         pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);

      if Config.Verbose then
         WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));

      if ValMax>=Camera.GetSaturationLevel then
         begin
         ValDesature:=Desature(ValMax,ErrorSature);
         // Saturation
         if ValDesature<0 then
            begin
            Result:=ValDesature;
            Exit;
            end;
         end;

      pop_camera.pop_image_acq.AjusteFenetre;
      pop_camera.pop_image_acq.VisuAutoEtoiles;

      // Soustraction du noir
      if NoirMAPAcquis  and CheckBox1.Checked then
         begin
         GetImgPart(MemPicNoir,MemPicNoirDouble,VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
            1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,pop_map.XMap-LargFen,pop_map.YMap-LargFen,
            pop_map.XMap+LargFen,pop_map.YMap+LargFen);
         Soust(pop_camera.pop_image_acq.DataInt,VignetteNoir,pop_camera.pop_image_acq.DataDouble,VignetteNoirDouble,
            pop_camera.pop_image_acq.ImgInfos.TypeData,1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
            pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy);
         FreememImg(VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
            pop_camera.pop_image_acq.ImgInfos.TypeData,1);
         end;

      if Assigned(pop_map_monitor) then pop_map_monitor.AfficheImage(pop_camera.pop_image_acq);
      end
   else
      begin
      WriteMessage(lang('Etoile trop près du bord'));
      WriteMessage(lang('On arrête'));
      WriteMessage('Recentrez l''étoile');      
      Result:=-4;
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;

   case TypeMesureFWHM of
//      0:ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*LargFen+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
      0:ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
           2*LargFen+1,TGauss,LowPrecision,LowSelect,0,PSF);
      1:begin
        HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,2*LargFen+1,
           2*LargFen+1,XCentre,YCentre,Diametre);
        // Pour corriger la difference entre les deux mesures pour FWHM=4
//        Diametre:=Diametre/4.5*3.75;
        PSF.Flux:=0;
        if Diametre=-1 then PSF.Flux:=-1;
        PSF.X:=XCentre;
        PSF.Y:=YCentre;
        PSF.Sigma:=Diametre;
        end;
      3:begin
        ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
           2*LargFen+1,TGauss,LowPrecision,LowSelect,0,PSF1);

        HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,2*LargFen+1,
           2*LargFen+1,XCentre,YCentre,Diametre);
        PSF.Flux:=0;
        if Diametre=-1 then PSF.Flux:=-1;
        PSF.X:=XCentre;
        PSF.Y:=YCentre;
        PSF.Sigma:=Diametre;
        end;
     end;


   if PSF.Flux=-1 then
      begin
      Inc(NbEchec);
      WriteMessage(lang('Echec de la modélisation n° ')+IntToStr(NbEchec));
      end
   else
      begin
//      GetMax(pop_camera.pop_image_acq.dataInt,ImgNil,2,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);
      // En virtuel, ça dérive
//      if Config.TypeCamera<>Plugin then
      if Config.TypeCamera<>Virtuelle then
//      if not(TesteFocalisation) then
         begin
         XMap:=XMap-LargFen+Round(PSF.X);
         YMap:=YMap-LargFen+Round(PSF.Y);
         end;

      if TypeMesureFWHM<>3 then
         begin
         WriteMessage(lang('Mesure ')+IntToStr(NbReusit+1)
            +' '+TypeStr+' = '+MyFloatToStr(PSF.Sigma,2)); //nolang
         if PSF.Sigma<FwhmMin then FwhmMin:=PSF.Sigma;
         end
      else
         begin
         WriteMessage(lang('Mesure ')+IntToStr(NbReusit+1)
            +' HFD = '+MyFloatToStr(PSF.Sigma,2)); //nolang
         WriteMessage(lang('Mesure ')+IntToStr(NbReusit+1)
            +' FWHM = '+MyFloatToStr(PSF1.Sigma,2)); //nolang
         if PSF.Sigma<FwhmMin then FwhmMin:=PSF.Sigma;
         if PSF1.Sigma<FwhmMin1 then FwhmMin1:=PSF1.Sigma;
         end;

      Marque:=False;
      if ShowMarque then
         if NbReusit=NbMesures+NbAdd-1 then Marque:=True;
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.Add(HeureToJourJulien(GetHourDT),PSF.Sigma,Marque,Color);
         pop_map_monitor.AfficheCercle(PSF.X,PSF.Y,PSF.Sigma);
         end;

      Inc(NbReusit);
      Fwhm[NbReusit]:=PSF.Sigma;
      if TypeMesureFWHM=3 then Fwhm1[NbReusit]:=PSF1.Sigma;
      end;

   Inc(i);
   end;

// Trop d'echec de la modélisation
if NbEchec=config.NbEssaiCentroMaxi then
   begin
   WriteMessage(lang('On a atteint le nombre maxi d''échecs de modélisation'));
   WriteMessage(lang('On arrête'));
   WriteMessage('Changez d''étoile ou augmentez la largeur de la fenêtre de modélisation');
//   WriteMessage('Changez d''étoile et/ou agrandissez la fenêtre de modélisation');
   Result:=-1;
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;

if Config.UseMoyenne then
   begin
   // Calcul de la moyenne
   Somme:=0;
   for j:=1 to NbReusit do Somme:=Somme+Fwhm[j];
   Fwhm0:=Somme/NbReusit;

   if TypeMesureFWHM=3 then
      begin
      Somme:=0;
      for j:=1 to NbReusit do Somme:=Somme+Fwhm1[j];
      FWHMOut:=Somme/NbReusit;
      end;
//   WriteMessage(TypeStrMoy+' = '+MyFloatToStr(Fwhm0,2))
   end
else
   begin
   Fwhm0:=FwhmMin;
   if TypeMesureFWHM=3 then FWHMOut:=FwhmMin1;

//   WriteMessage(TypeStrMin+' = '+MyFloatToStr(Fwhm0,2));
   end;

Result:=Fwhm0;
end;

procedure Tpop_map.Button5Click(Sender: TObject);
begin
TypeMapMonitor:='AutoV'; //nolang
//Config.TypeMesureFWHM:=1; // HFD

if pop_map_monitor=nil then pop_map_monitor:=tpop_map_monitor.Create(Application)
else
   begin
   pop_map_monitor.RAZ;
   pop_map_monitor.Update;
   end;
pop_map_monitor.Show;
StopMap:=False;
end;

function Tpop_map.Desature(var ValMax:Double;Error:Boolean):Integer;
var
   LargFen:Integer;
   ImgNil:PTabImgDouble;
   ImgDoubleNil:PTabImgDouble;
   xx,yy:Integer;
begin
Result:=0;
LargFen:=Config.LargFoc;

if (Pose<=config.MinPose) then
   begin
   WriteSpy(lang('Etoile saturée, on arrête'));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Etoile saturée, on arrête'));
   if Assigned(pop_cmde_corr) then pop_cmde_corr.AddMessage(lang('Etoile saturée, on arrête'));
   if Assigned(pop_calib_autov) then pop_calib_autov.AddMessage(lang('Etoile saturée, on arrête'));
   Result:=-3;
   Exit;
   end;

// Pas besoin, il y a déjà le même message avant de diviser le temps de pose par 2 plus loin
//WriteSpy(lang('Etoile saturée, on tente de la désaturer'));
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Etoile saturée, on tente de la désaturer'));
if Assigned(pop_cmde_corr) then pop_cmde_corr.AddMessage(lang('Etoile saturée, on tente de la désaturer'));
if Assigned(pop_calib_autov) then pop_calib_autov.AddMessage(lang('Etoile saturée, on tente de la désaturer'));

while (ValMax>=Camera.GetSaturationLevel) and (Pose>config.MinPose) do
   begin

   if StopMap then
      begin
      while pop_camera.PoseEnCours do Application.ProcessMessages;
      WriteSpy(lang('Arrêt de la mise au point effectué'));
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('Arrêt de la mise au point effectué'));
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      if Assigned(pop_cmde_corr) then
         begin
         pop_cmde_corr.AddMessage(lang('Arrêt de la mise au point effectué'));
         pop_cmde_corr.Button1.Enabled:=True;
         pop_cmde_corr.Button2.Enabled:=False;
         end;
      if Assigned(pop_calib_autov) then
         begin
         pop_calib_autov.AddMessage(lang('Arrêt de la mise au point effectué'));
         pop_calib_autov.Button1.Enabled:=True;
         pop_calib_autov.Button2.Enabled:=False;
         end;
      StopMap:=False;
      pop_camera.pop_image_acq.Bloque:=False;
      Result:=-2;
      Exit;
      end;

   if (Pose/2>config.MinPose) then
      begin
      WriteSpy(lang('L''étoile est saturée, on tente de la désaturer'));
      WriteSpy(lang('On divise le temps de pose par 2'));
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('On divise le temps de pose par 2'));
      if Assigned(pop_cmde_corr) then pop_cmde_corr.AddMessage(lang('On divise le temps de pose par 2'));
      if Assigned(pop_calib_autov) then pop_calib_autov.AddMessage(lang('On divise le temps de pose par 2'));
      Pose:=Pose/2;
      end
   else
      begin
      Pose:=config.MinPose;
      WriteSpy(lang('Temps de pose minimum atteint'));
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Temps de pose minimum atteint'));
      if Assigned(pop_cmde_corr) then pop_cmde_corr.AddMessage(lang('Temps de pose minimum atteint'));
      if Assigned(pop_calib_autov) then pop_calib_autov.AddMessage(lang('Temps de pose minimum atteint'));      
      end;
   WriteSpy(lang('Temps de pose = ')+MyFloatToStr(Pose,2));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Temps de pose = ')+MyFloatToStr(Pose,2));
   if Assigned(pop_cmde_corr) then pop_cmde_corr.AddMessage(lang('Temps de pose = ')+MyFloatToStr(Pose,2));
   if Assigned(pop_calib_autov) then pop_calib_autov.AddMessage(lang('Temps de pose = ')+MyFloatToStr(Pose,2));

   if (XMap>LargFen+1) and (YMap>LargFen+1) and (XMap<Camera.GetXSize-LargFen) and (YMap<Camera.GetYSize-LargFen) then
      begin
      pop_camera.Acquisition(XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen,Pose,1,False);

      // Pour Valmax
      GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
         pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);

      if Config.Verbose then
         begin
         WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
//         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
         end;

      //Soustraction du noir
      if NoirMAPAcquis  and CheckBox1.Checked then
         begin
         GetImgPart(MemPicNoir,MemPicNoirDouble,VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
            1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,pop_map.XMap-LargFen,pop_map.YMap-LargFen,
            pop_map.XMap+LargFen,pop_map.YMap+LargFen);
         Soust(pop_camera.pop_image_acq.DataInt,VignetteNoir,pop_camera.pop_image_acq.DataDouble,VignetteNoirDouble,
            pop_camera.pop_image_acq.ImgInfos.TypeData,1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
            pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy);
         FreememImg(VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
            pop_camera.pop_image_acq.ImgInfos.TypeData,1);
         end;

      pop_camera.pop_image_acq.AjusteFenetre;
      pop_camera.pop_image_acq.VisuAutoEtoiles;
      if Assigned(pop_map_monitor) then pop_map_monitor.AfficheImage(pop_camera.pop_image_acq);
      end
   else
      begin
      WriteSpy(lang('Etoile trop près du bord'));
      WriteSpy(lang('On arrête'));
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('Etoile trop près du bord'));
         pop_map_monitor.AddMessage(lang('On arrête'));
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      if Assigned(pop_cmde_corr) then
         begin
         pop_cmde_corr.AddMessage(lang('Etoile trop près du bord'));
         pop_cmde_corr.AddMessage(lang('On arrête'));
         pop_cmde_corr.Button1.Enabled:=True;
         pop_cmde_corr.Button2.Enabled:=False;
         end;
      if Assigned(pop_calib_autov) then
         begin
         pop_calib_autov.AddMessage(lang('Etoile trop près du bord'));
         pop_calib_autov.AddMessage(lang('On arrête'));
         pop_calib_autov.Button1.Enabled:=True;
         pop_calib_autov.Button2.Enabled:=False;
         end;
      pop_camera.pop_image_acq.Bloque:=False;
      Result:=-4;
      Exit;
      end;

   end;

if ValMax>=Camera.GetSaturationLevel then
   begin
   WriteSpy(lang('L''étoile reste saturée, on arrête'));
   if Error then WriteSpy(lang('Cherchez une étoile moins brillante'));
   if Assigned(pop_map_monitor) then
      begin
      pop_map_monitor.AddMessage(lang('L''étoile reste saturée, on arrête'));
      if Error then pop_map_monitor.AddMessage(lang('Cherchez une étoile moins brillante'));
      end;
   if Assigned(pop_cmde_corr) then
      begin
      pop_cmde_corr.AddMessage(lang('L''étoile reste saturée, on arrête'));
      if Error then pop_cmde_corr.AddMessage(lang('Cherchez une étoile moins brillante'));
      end;
   if Assigned(pop_calib_autov) then
      begin
      pop_calib_autov.AddMessage(lang('L''étoile reste saturée, on arrête'));
      if Error then pop_calib_autov.AddMessage(lang('Cherchez une étoile moins brillante'));
      end;
   pop_camera.pop_image_acq.Bloque:=False;
   Result:=-3;
   Exit;
   end
else
   begin
   WriteSpy(lang('L''étoile n''est plus saturée, on peut continuer'));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('L''étoile n''est plus saturée, on peut continuer'));
   if Assigned(pop_cmde_corr) then pop_cmde_corr.AddMessage(lang('L''étoile n''est plus saturée, on peut continuer'));
   if Assigned(pop_calib_autov) then pop_calib_autov.AddMessage(lang('L''étoile n''est plus saturée, on peut continuer'));   
   Result:=0;
   end;
end;

procedure Tpop_map.MAPAutoV;
var
   CorrectionSave:Boolean;
   i,LargFen:Integer;
   ImgDoubleNil:PTabImgDouble;
   ImgNil:PTabImgDouble;
   xx,yy:Integer;
   ValMax:Double;
   xxd,yyd:Double;
   Diametre,Mesure1,Mesure2,MesureTemp,Duree:Double;
   Vitesse,Direction:Integer;
   x:Double;
   TypeMesureFWHMSave:Byte;
   UseMoyenneSave,OK:Boolean;
   MyMessage:string;
   Fwhm:TVecteur;
   TimeDebut,TimeFin:TDateTime;
   DureeAF:Double;
   NbManoeuvres:Integer;
   Temp:Double;
   FWHMLast:Double;
begin
//FWHMTestCourant:=5;

TypeMapMonitor:='AutoV'; //nolang

try

NbManoeuvres:=0;
btn_manuel.Enabled:=False;
btn_auto.Enabled:=False;
Button1.Enabled:=False;
Button5.Enabled:=False;
Edit5.Enabled:=False;
SpinButton2.Enabled:=False;
TesteFocalisation:=True;
StopMap:=False;

if pop_map_monitor=nil then pop_map_monitor:=tpop_map_monitor.create(application);
pop_map_monitor.RAZ;
pop_map_monitor.Show;

// On passe en HFD
TypeMesureFWHMSave:=Config.TypeMesureFWHM;
Config.TypeMesureFWHM:=1;
pop_map_monitor.TypeStr:=lang('HFD');
pop_map_monitor.TypeStrMoy:=lang('HFD moyen');
pop_map_monitor.TypeStrMin:=lang('HFD minimal');
pop_map_monitor.Label5.Caption:=pop_map_monitor.TypeStr+lang(' moy (pixels)');
pop_map_monitor.Label9.Caption:=pop_map_monitor.TypeStr+lang(' moy (arcsec)');

// On passe a la moyenne
UseMoyenneSave:=Config.UseMoyenne;
Config.UseMoyenne:=True;
pop_map_monitor.Label5.Caption:=pop_map_monitor.TypeStr+lang(' moy (pixels)');
pop_map_monitor.Label9.Caption:=pop_map_monitor.TypeStr+lang(' moy (arcsec)');

OK:=Focuser.GetCorrection(CorrectionSave);
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   raise MyError.Create(MyMessage);
   end;

if pop_camera.pop_image_acq=nil then
    pop_camera.pop_image_acq:=tpop_image.Create(Application);

pop_camera.pop_image_acq.Bloque:=True;
pop_camera.pop_image_acq.IsUsedForAcq:=True;

Pose:=MyStrToFloat(Edit5.text);
WriteSpy(lang('Temps de pose = ')+MyFloatToStr(Pose,2)
   +' secondes');
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Temps de pose = ')+MyFloatToStr(Pose,2)
   +' secondes');

if not NoirMAPAcquis  and CheckBox1.Checked then
   begin
   WriteSpy(lang('Acquisition du noir'));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Acquisition du noir'));
   AcqNoir;
   NoirMAPAcquis:=True;
   end;

LargFen:=Config.LargFoc;

TimeDebut:=Now;
WriteSpy(lang('Début de l''AutofocusV'));
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Début de l''AutofocusV'));

if Config.FocInversion then
   begin
   WriteSpy(lang('Sens de marche inversé'));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Sens de marche inversé'));
   end;

// Trouver ses coordonnees en Binning 4x4
WriteSpy(lang('Recherche des coordonnées de l''étoile la plus brillante'));
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Recherche des coordonnées de l''étoile la plus brillante'));
//AcqNonSatur(x,y);
pop_camera.AcqMaximumBinning(XMap,YMap);
if Camera.IsAValidBinning(4) then
   begin
   XMap:=XMap*4;
   YMap:=YMap*4;
   end
else
   begin
   XMap:=XMap*3;
   YMap:=YMap*3;
   end;

WriteSpy(lang('Coordonnées de l''étoile X = ')+IntToStr(XMap)
   +' Y = '+IntToStr(YMap)); //nolang
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Coordonnées de l''étoile X = ')+IntToStr(XMap)
   +' Y = '+IntToStr(YMap)); //nolang
// Premiere aquisition de l'etoile
WriteSpy(lang('Passage en vignette'));
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Passage en vignette'));
if (XMap>LargFen+1) and (YMap>LargFen+1) and (XMap<Camera.GetXSize-LargFen) and (YMap<Camera.GetYSize-LargFen) then
   begin
   pop_camera.Acquisition(XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen,Pose,1,False);

   // Pour Valmax
   GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);

   //Soustraction du noir
   if NoirMAPAcquis  and CheckBox1.Checked then
      begin
      GetImgPart(MemPicNoir,MemPicNoirDouble,VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
         1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,pop_map.XMap-LargFen,pop_map.YMap-LargFen,
         pop_map.XMap+LargFen,pop_map.YMap+LargFen);
      Soust(pop_camera.pop_image_acq.DataInt,VignetteNoir,pop_camera.pop_image_acq.DataDouble,VignetteNoirDouble,
         pop_camera.pop_image_acq.ImgInfos.TypeData,1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
         pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy);
      FreememImg(VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
         pop_camera.pop_image_acq.ImgInfos.TypeData,1);
      end;

   pop_camera.pop_image_acq.AjusteFenetre;
   pop_camera.pop_image_acq.VisuAutoEtoiles;
   if Assigned(pop_map_monitor) then pop_map_monitor.AfficheImage(pop_camera.pop_image_acq);
   end
else
   begin
   WriteSpy(lang('Etoile trop près du bord'));
   WriteSpy(lang('On arrête'));
   if Assigned(pop_map_monitor) then
      begin
      pop_map_monitor.AddMessage(lang('Etoile trop près du bord'));
      pop_map_monitor.AddMessage(lang('On arrête'));
      pop_map_monitor.Button3.Enabled:=True;
      pop_map_monitor.Button4.Enabled:=False;
      end;
   pop_camera.pop_image_acq.Bloque:=False;      
   Exit;
   end;

// Pour centrer
case Config.TypeMesureFWHM of
   0:begin
     XMap:=XMap-LargFen+Round(xx);
     YMap:=YMap-LargFen+Round(yy);
     end;
   1:begin
     HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,2*LargFen+1,
        2*LargFen+1,xxd,yyd,Diametre);
     XMap:=XMap-LargFen+Round(xxd);
     YMap:=YMap-LargFen+Round(yyd);
     end;
   end;

if Config.Verbose then
   WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));

// Corriger les coordonnées pour mettre l'etoile au centre
// Corriger x et y en fonction de xx et yy
// Pour centrer
case Config.TypeMesureFWHM of
   0:begin
     GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
        pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);

     XMap:=XMap-LargFen+Round(xx);
     YMap:=YMap-LargFen+Round(yy);
     end;
   1:begin
     HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,2*LargFen+1,
        2*LargFen+1,xxd,yyd,Diametre);
     XMap:=XMap-LargFen+Round(xxd);
     YMap:=YMap-LargFen+Round(yyd);
     end;
   end;

// On commence par une serie courte
Mesure1:=Serie(Fwhm,Config.NbEssaiFocFast,False,0,Config.TypeMesureFWHM,Config.UseMoyenne,Temp,True,True,clRed);
if Mesure1<0 then
   begin
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;

pop_map_monitor.AddV(Mesure1,0);

// Si >De-Ms on arrête
// Position extreme
if Mesure1>(Config.DiametreExtreme-Config.MargeSecurite) then
   begin
   WriteSpy(lang('Le HFD est supérieur à [De-Ms] pixels, on arrête'));
   WriteSpy(lang('Commandez le focuseur manuellement pour réduire le HFD'));
   if Assigned(pop_map_monitor) then
      begin
      pop_map_monitor.AddMessage(lang('Le FHD est supérieur à [De-Ms] pixels, on arrête'));
      pop_map_monitor.AddMessage(lang('Commandez le focuseur manuellement pour réduire le HFD'));
      end;
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;

// Si >Dp on cherche de quel côté on est
if Mesure1>Config.DiametreProche then
   begin
   WriteSpy(lang('On est sur une des deux zones linéaires, on recule pour tester'));
   if Assigned(pop_map_monitor) then
      pop_map_monitor.AddMessage(lang('On est sur une des deux zones linéaires, on recule pour tester'));

   if Config.UseCmdCorrLenteAutoV then
      OK:=Focuser.SetCorrectionOn
   else
      OK:=Focuser.SetCorrectionOff;
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      raise MyError.Create(MyMessage);
      end;

   // Recul en vitesse lente de durée égale à 0.75*Ms/vl
   Duree:=0.75*Config.MargeSecurite/Config.VitesseLente*1000;
   OK:=Focuser.FocuserMoveTime(mapArriere,mapLent,Duree);
   Inc(NbManoeuvres);
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      raise MyError.Create(MyMessage);
      end;

   // Suivi d'une série courte
   Mesure2:=Serie(Fwhm,Config.NbEssaiFocFast,False,0,Config.TypeMesureFWHM,Config.UseMoyenne,Temp,True,True,clRed);
   if Mesure2<0 then
      begin
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;

   // Ici il faut se baser sur la premiere mesure car :
   // Après un départ transfocal proche, le point n°1 doit revenir sur la branche linéaire
   // ascendante, même si le recul de test fait passer en-dessous du diamètre proche.
   if Mesure1>Config.DiametreProche then
      begin
      if (Mesure2<Mesure1) then pop_map_monitor.AddV(Mesure2,1)
      else pop_map_monitor.AddV(Mesure2,-1);
      end
   else pop_map_monitor.AddV(Mesure2,0);
   end
// Sinon Mesure2=Mesure1<Config.DiametreProche pour sauter la boucle suivante
else Mesure2:=Mesure1;

// Si on est en zone transfocale , on change de côté
// On manoeuvre tant que Mesure2<Mesure1 et Mesure2>Config.DiametreProche
while (Mesure2<Mesure1) and (Mesure2>Config.DiametreProche) do
   begin
   if StopMap then
      begin
      while pop_camera.PoseEnCours do Application.ProcessMessages;
      WriteSpy(lang('Arrêt de la mise au point effectué'));
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('Arrêt de la mise au point effectué'));
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      StopMap:=False;
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;

   WriteSpy(lang('On est du côté transfocal, on recule pour basculer de l''autre côté'));
   if Assigned(pop_map_monitor) then
      pop_map_monitor.AddMessage(lang('On est du côté transfocal, on recule pour basculer de l''autre côté'));
   // Basculement
   // Recul de duree (D+Dp+Ms)/v
//   Duree:=(Mesure2+Config.DiametreProche+Config.MargeSecurite)/Config.VitesseLente*1000;
   Duree:=Mesure2/Config.VitesseLente*1000;
   if (Duree>Config.DureeMaxManoeuvre) and Config.UseVitesseRapide then Vitesse:=mapRapide else Vitesse:=mapLent;
//   if Config.UseVitesseRapide or (Duree>Config.DureeMaxManoeuvre) then Vitesse:=mapRapide else Vitesse:=mapLent;
   if Vitesse=mapRapide then
      begin
      Duree:=Mesure2/Config.VitesseRapide*1000;
      if Config.UseCmdCorrRapideAutoV then
         OK:=Focuser.SetCorrectionOn
      else
         OK:=Focuser.SetCorrectionOff;
      if not OK then
         begin
         MyMessage:=Focuser.GetError;
         WriteSpy(MyMessage);
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
         raise MyError.Create(MyMessage);
         end;
      end
   else
      begin
      if Config.UseCmdCorrLenteAutoV then
         OK:=Focuser.SetCorrectionOn
      else
         OK:=Focuser.SetCorrectionOff;
      if not OK then
         begin
         MyMessage:=Focuser.GetError;
         WriteSpy(MyMessage);
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
         raise MyError.Create(MyMessage);
         end;
      end;
   OK:=Focuser.FocuserMoveTime(mapArriere,Vitesse,Duree);
   Inc(NbManoeuvres);
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      raise MyError.Create(MyMessage);
      end;

   Mesure1:=Mesure2;
   Mesure2:=Serie(Fwhm,Config.NbEssaiFocFast,False,0,Config.TypeMesureFWHM,Config.UseMoyenne,Temp,True,True,clRed);
   if Mesure2<0 then
      begin
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;

   if Mesure2>Config.DiametreProche then
      begin
      if (Mesure2<Mesure1) then pop_map_monitor.AddV(Mesure2,1)
      else pop_map_monitor.AddV(Mesure2,-1);
      end
   else pop_map_monitor.AddV(Mesure2,0);
   end;

// Tant qu'on est en dehors de [Dp,Dp+Ms], il faut s'approcher
while (Mesure2<Config.DiametreProche) or (Mesure2>Config.DiametreProche+Config.MargeSecurite) do
   begin
   if StopMap then
      begin
      while pop_camera.PoseEnCours do Application.ProcessMessages;
      WriteSpy(lang('Arrêt de la mise au point effectué'));
      if Assigned(pop_map_monitor) then
         begin
         pop_map_monitor.AddMessage(lang('Arrêt de la mise au point effectué'));
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      StopMap:=False;
      pop_camera.pop_image_acq.Bloque:=False;      
      Exit;
      end;

   // Si on est dans la zone parafocale
   // On va vers la préfocale
   if Mesure2<Config.DiametreProche then
      begin
      WriteSpy(lang('On est dans la zone parafocale, on recule pour s''en extraire'));
      if Assigned(pop_map_monitor) then
         pop_map_monitor.AddMessage(lang('On est dans la zone parafocale, on recule pour s''en extraire'));
      // Extraction
      // Recul de duree d'extraction
      Duree:=Config.DureeExtraction/100*2*Config.DiametreProche/Config.VitesseLente*1000;
      if (Duree>Config.DureeMaxManoeuvre) and Config.UseVitesseRapide then Vitesse:=mapRapide else Vitesse:=mapLent;
//      if Config.UseVitesseRapide or (Duree>Config.DureeMaxManoeuvre) then Vitesse:=mapRapide else Vitesse:=mapLent;
      if Vitesse=mapRapide then
         begin
         Duree:=Config.DureeExtraction/100*2*Config.DiametreProche/Config.VitesseRapide*1000;
         if Config.UseCmdCorrRapideAutoV then
            OK:=Focuser.SetCorrectionOn
         else
            OK:=Focuser.SetCorrectionOff;
         if not OK then
            begin
            MyMessage:=Focuser.GetError;
            WriteSpy(MyMessage);
            if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
            raise MyError.Create(MyMessage);
            end;
         end
      else
         begin
         if Config.UseCmdCorrLenteAutoV then
            OK:=Focuser.SetCorrectionOn
         else
            OK:=Focuser.SetCorrectionOff;
         if not OK then
            begin
            MyMessage:=Focuser.GetError;
            WriteSpy(MyMessage);
            if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
            raise MyError.Create(MyMessage);
            end;
         end;
      OK:=Focuser.FocuserMoveTime(mapArriere,Vitesse,Duree);
      Inc(NbManoeuvres);
      if not OK then
         begin
         MyMessage:=Focuser.GetError;
         WriteSpy(MyMessage);
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
         raise MyError.Create(MyMessage);
         end;

      Mesure2:=Serie(Fwhm,Config.NbEssaiFocFast,False,0,Config.TypeMesureFWHM,Config.UseMoyenne,Temp,True,True,clRed);
      if Mesure2<0 then
         begin
         pop_camera.pop_image_acq.Bloque:=False;
         Exit;
         end;

      if Mesure2>Config.DiametreProche then
         pop_map_monitor.AddV(Mesure2,-1)
      else pop_map_monitor.AddV(Mesure2,0);
//      pop_map_monitor.AddV(Mesure2,0); non !
      end;

   // Si on est dans la zone préfocale
   // On s'apporche de la parafocale
   if Mesure2>Config.DiametreProche+Config.MargeSecurite then
      begin
      WriteSpy(lang('On est du côté préfocal, on avance pour se prépositionner'));
      if Assigned(pop_map_monitor) then
         pop_map_monitor.AddMessage(lang('On est du côté préfocal, on avance pour se prépositionner'));
      // Prepositionement
      // Avance de duree (D-Dp-Ms/2)/v
      Duree:=(Mesure2-Config.DiametreProche-Config.MargeSecurite/2)/Config.VitesseLente*1000;
      if (Duree>Config.DureeMaxManoeuvre) and Config.UseVitesseRapide then Vitesse:=mapRapide else Vitesse:=mapLent;
      if Vitesse=mapRapide then
         begin
         Duree:=(Mesure2-Config.DiametreProche-Config.MargeSecurite/2)/Config.VitesseRapide*1000;
         if Config.UseCmdCorrRapideAutoV then
            OK:=Focuser.SetCorrectionOn
         else
            OK:=Focuser.SetCorrectionOff;
         if not OK then
            begin
            MyMessage:=Focuser.GetError;
            WriteSpy(MyMessage);
            if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
            raise MyError.Create(MyMessage);
            end;
         end
      else
         begin
         if Config.UseCmdCorrLenteAutoV then
            OK:=Focuser.SetCorrectionOn
         else
            OK:=Focuser.SetCorrectionOff;
         if not OK then
            begin
            MyMessage:=Focuser.GetError;
            WriteSpy(MyMessage);
            if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
            raise MyError.Create(MyMessage);
            end;
         end;
      OK:=Focuser.FocuserMoveTime(mapAvant,Vitesse,Duree);
      Inc(NbManoeuvres);
      if not OK then
         begin
         MyMessage:=Focuser.GetError;
         WriteSpy(MyMessage);
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
         raise MyError.Create(MyMessage);
         end;


      Mesure2:=Serie(Fwhm,Config.NbEssaiFocFast,False,0,Config.TypeMesureFWHM,Config.UseMoyenne,Temp,True,True,clRed);
      if Mesure2<0 then
         begin
         pop_camera.pop_image_acq.Bloque:=False;
         Exit;
         end;

      if Mesure2>Config.DiametreProche then
         pop_map_monitor.AddV(Mesure2,-1)
      else pop_map_monitor.AddV(Mesure2,0);
      MesureTemp:=Mesure2;
      end;
   end;

WriteSpy(lang('On est prépositionné, on avance pour accoster'));
if Assigned(pop_map_monitor) then
   pop_map_monitor.AddMessage(lang('On est prépositionné, on avance pour accoster'));

// On est en position proche
// Accostage
// Serie Normale
Mesure2:=Serie(Fwhm,Config.NbEssaiFocFast,True,Config.NbEssaiFocSlow-Config.NbEssaiFocFast,
   Config.TypeMesureFWHM,Config.UseMoyenne,Temp,True,True,clRed);
if Mesure2<0 then // Erreur de modélisation
   begin
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;

// On affiche le point que quand la valeur a changé
//if Mesure2<>MesureTemp then pop_map_monitor.AddV(Mesure2,-1);
// Deplacement
Duree:=Mesure2/Config.VitesseLente*1000;
MyMessage:='Durée totale d''accostage : '+MyFloatToStr(Duree,2)
   +' ms'; //nolang
WriteSpy(MyMessage);
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
x:=Duree/Config.DureeImpulsionIncrementale;
Vitesse:=mapLent;
if Config.UseCmdCorrLenteAutoV then
   OK:=Focuser.SetCorrectionOn
else
   OK:=Focuser.SetCorrectionOff;
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   raise MyError.Create(MyMessage);
   end;
for i:=1 to Floor(x) do
   begin
   OK:=Focuser.FocuserMoveTime(mapAvant,Vitesse,Config.DureeImpulsionIncrementale);
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      raise MyError.Create(MyMessage);
      end;
   end;

OK:=Focuser.FocuserMoveTime(mapAvant,Vitesse,Frac(x)*Config.DureeImpulsionIncrementale);
Inc(NbManoeuvres);
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   raise MyError.Create(MyMessage);
   end;

Config.TypeMesureFWHM:=0;

// On force la simu a l'optimum !
FWHMTestCourant:=0;

pop_map_monitor.TypeStr:=lang('FWHM');
pop_map_monitor.TypeStrMoy:=lang('FWHM moyenne');
pop_map_monitor.TypeStrMin:=lang('FWHM minimale');

// Serie normale
//Mesure2:=Serie(Fwhm,Config.NbEssaiFocSlow,False,0,Config.TypeMesureFWHM,Config.UseMoyenne,FWHMLast);
Mesure2:=Serie(Fwhm,Config.NbEssaiFocSlow,False,0,3,Config.UseMoyenne,FWHMLast,False,True,clRed);
// Saturation
if (Mesure2<>-3) and (Mesure2<0) then
   begin
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;
pop_map_monitor.AddVLast(Mesure2,0);

WriteSpy('FWHM moyenne = '+MyFloatToStr(FWHMLast,2));
if Assigned(pop_map_monitor) then
   pop_map_monitor.AddMessage('FWHM moyenne'+MyFloatToStr(FWHMLast,2));

pop_map_monitor.Label5.Caption:=pop_map_monitor.TypeStr+lang(' moy (pixels)');
pop_map_monitor.Label9.Caption:=pop_map_monitor.TypeStr+lang(' moy (arcsec)');

WriteSpy('Fin de l''AutofocusV');
if Assigned(pop_map_monitor) then
   pop_map_monitor.AddMessage('Fin de l''AutofocusV');

if Mesure2=-3 then //Saturation
   begin
   // Pour Valmax
//   if Config.Verbose then
//      begin
//      WriteSpy(lang('Intensité maximale dans l''image brute finale = ')+MyFloatToStr(Camera.GetSaturationLevel,2));
//      if Assigned(pop_map_monitor) then
//         pop_map_monitor.AddMessage(lang('Intensité maximale dans l''image brute finale = ')+MyFloatToStr(Camera.GetSaturationLevel,2));
//      end;

//   WriteSpy(lang('L''étoile est saturée'));
   WriteSpy(lang('Focalisation correcte mais mesure du seeing impossible'));
   if Assigned(pop_map_monitor) then
      begin
//      pop_map_monitor.AddMessage(lang('L''étoile est saturée'));
      pop_map_monitor.AddMessage(lang('Focalisation correcte mais mesure du seeing impossible'));
      end;
   end
else
   begin
   // Pour Valmax
   GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);
//   WriteSpy(lang('Intensité maximale dans l''image finale = ')+MyFloatToStr(ValMax,2));
//   if Assigned(pop_map_monitor) then
//      pop_map_monitor.AddMessage(lang('Intensité maximale dans l''image finale = ')+MyFloatToStr(ValMax,2));

   // Seeing a ajouter
   //Config.Seeing:=ArcTan(Sqrt((Sqr(Mesure2*Camera.GetXPixelSize/1e6)/2
   //   +Sqr(Mesure2*Camera.GetYPixelSize/1e6)/2))/Config.FocaleTele*1000)*180/Pi*3600;
   Config.Seeing:=ArcTan(Sqrt((Sqr(FWHMLast*Camera.GetXPixelSize/1e6)/2
      +Sqr(FWHMLast*Camera.GetYPixelSize/1e6)/2))/Config.FocaleTele*1000)*180/Pi*3600;

   WriteSpy(lang('Seeing = ')+MyFloatToStr(Config.Seeing,2)+
      lang(' ArcSec ( ')+MyFloatToStr(FWHMLast,2)+
      lang(' Pixels )'));
   if Assigned(pop_map_monitor) then
      pop_map_monitor.AddMessage(lang('Seeing = ')+MyFloatToStr(Config.Seeing,2)+
         lang(' ArcSec ( ')+MyFloatToStr(FWHMLast,2)+
         lang(' Pixels )'));
   end;

TimeFin:=Now;
DureeAF:=(TimeFin-TimeDebut)*24*60;
if DureeAF>=1 then
   begin
   WriteSpy('Durée de l''Autofocus = '+MyFloatToStr(Int(DureeAF),0)+lang(' Minutes ')
      +MyFloatToStr(Frac(DureeAF)*60,0)+lang(' Secondes'));
   if Assigned(pop_map_monitor) then
      pop_map_monitor.AddMessage('Durée de l''Autofocus = '+MyFloatToStr(Int(DureeAF),0)+lang(' Minutes ')
         +MyFloatToStr(Frac(DureeAF)*60,0)+lang(' Secondes'));
   end
else
   begin
   WriteSpy('Durée de l''Autofocus = '+MyFloatToStr(DureeAF*60,0)+lang(' Secondes'));
   if Assigned(pop_map_monitor) then
      pop_map_monitor.AddMessage('Durée de l''Autofocus = '+MyFloatToStr(DureeAF*60,0)+lang(' Secondes'));
   end;

WriteSpy(lang('Nombre de manoeuvres = ')+IntToStr(NbManoeuvres));
if Assigned(pop_map_monitor) then
   pop_map_monitor.AddMessage(lang('Nombre de manoeuvres = ')+IntToStr(NbManoeuvres));

finally
FWHMTestCourant:=FWHMTestCourantInit;
btn_manuel.Enabled:=True;
btn_auto.Enabled:=True;
Button1.Enabled:=True;
Button5.Enabled:=True;
Edit5.Enabled:=True;
SpinButton2.Enabled:=True;
Config.TypeMesureFWHM:=TypeMesureFWHMSave;  
Config.UseMoyenne:=UseMoyenneSave;
pop_camera.pop_image_acq.Bloque:=False;
TesteFocalisation:=False;
if Assigned(pop_map_monitor) then
   begin
   pop_map_monitor.Button3.Enabled:=True;
   pop_map_monitor.Button4.Enabled:=False;

   pop_map_monitor.Button2.Enabled:=True;
   pop_map_monitor.Button5.Enabled:=True;
   pop_map_monitor.Button1.Enabled:=True;
   end;
if CorrectionSave then Focuser.SetCorrectionOn else Focuser.SetCorrectionOff;
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   raise MyError.Create(MyMessage);
   end;
end;

end;

procedure Tpop_map.FormClose(Sender: TObject; var Action: TCloseAction);
var
   Ini:TMemIniFile;
   Path:string;
begin
// Sauve la pos
Path:=ExtractFilePath(Application.Exename);
Ini:=TMemIniFile.Create(Path+'TeleAuto.ini'); //nolang
try
Ini.WriteString('WindowsPos','MapTop',IntToStr(Top));
Ini.WriteString('WindowsPos','MapLeft',IntToStr(Left));
Ini.WriteString('WindowsPos','MapWidth',IntToStr(Width));
Ini.WriteString('WindowsPos','MapHeight',IntToStr(Height));
finally
Ini.UpdateFile;
Ini.Free;
end;
end;

procedure Tpop_map.Button6Click(Sender: TObject);
begin
pop_calib_autov:=Tpop_calib_autov.Create(Application);
pop_calib_autov.Show;
end;

procedure Tpop_map.Timer1Timer(Sender: TObject);
begin
Hide;
Timer1.Enabled:=False;
end;

procedure Tpop_map.Button7Click(Sender: TObject);
begin
pop_cmde_corr:=Tpop_cmde_corr.Create(Application);
pop_cmde_corr.Show;
end;

procedure Tpop_map.Button8Click(Sender: TObject);
begin
// Pour les tests
FWHMTestCourant:=5;

TypeMapMonitor:='Optim'; //nolang

if pop_map_monitor=nil then pop_map_monitor:=tpop_map_monitor.Create(Application)
else
   begin
   pop_map_monitor.RAZ;
   pop_map_monitor.Update;
   end;
pop_map_monitor.Show;
StopMap:=False;
end;

function Tpop_map.MAPOptim:Boolean;
var
   TypeMesureFWHMSave:Byte;
   UseMoyenneSave:Boolean;
   Mesure1,Mesure2,Mesure3,MesureMini,MesureCible:Double;
   Fwhm:TVecteur;
   Temp:Double;
   Fin:Boolean;
   Tolerance:Double;
   xx,yy:Integer;
   Fwhm2:Double;
   ValMax:Double;
   Direction:Integer;
   DelaiFoc:Double;
   LargFen:Integer;
   CorrectionSave:Boolean;
   Diametre:Double;
   xxd,yyd,Seeing:Double;
   TypeStr,TypeStrMoy,TypeStrMin:string;
   MyMessage:string;
   OK:Boolean;
   TimeDebut,TimeFin:TDateTime;
   DureeAF:Double;
   NbManoeuvres:Integer;      
begin
// Pour les tests
TesteFocalisation:=True;
FWHMTestCourant:=5;
NbManoeuvres:=0;
MesureMini:=MaxDouble;

btn_manuel.Enabled:=False;
btn_auto.Enabled:=False;
Button1.Enabled:=False;
Button5.Enabled:=False;
Button8.Enabled:=False;
Edit5.Enabled:=False;
SpinButton2.Enabled:=False;

if pop_map_monitor=nil then pop_map_monitor:=tpop_map_monitor.create(application);
pop_map_monitor.RAZ;
pop_map_monitor.Show;


//-nombre de mesures par série = normal
pop_map_monitor.SetMesure(config.NbEssaiFocSlow);
//-vitesse = lente

//-type de modélisation = FWHM
TypeMesureFWHMSave:=Config.TypeMesureFWHM;
Config.TypeMesureFWHM:=0;
TypeStr:=lang('FWHM');
TypeStrMoy:=lang('FWHM moyenne');
TypeStrMin:=lang('FWHM minimale');
pop_map_monitor.TypeStr:=lang('FWHM');
pop_map_monitor.TypeStrMoy:=lang('FWHM moyenne');
pop_map_monitor.TypeStrMin:=lang('FWHM minimale');

//-valeur typique des séries = moyenne
UseMoyenneSave:=Config.UseMoyenne;
Config.UseMoyenne:=True;
pop_map_monitor.Label5.Caption:=TypeStr+lang(' moy (pixels)');
pop_map_monitor.Label9.Caption:=TypeStr+lang(' moy (arcsec)');

// Sauver la commande corrigee
OK:=Focuser.GetCorrection(CorrectionSave);
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   raise MyError.Create(MyMessage);
   end;

// Activer le commande corrigee
if Config.CorrectionOptim then
   OK:=Focuser.SetCorrectionOn
else
   OK:=Focuser.SetCorrectionOff;
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   raise MyError.Create(MyMessage);
   end;

if pop_camera.pop_image_acq=nil then
    pop_camera.pop_image_acq:=tpop_image.Create(Application);

pop_camera.pop_image_acq.Bloque:=True;
pop_camera.pop_image_acq.IsUsedForAcq:=True;

Pose:=MyStrToFloat(Edit5.text);
WriteSpy(lang('Temps de pose = ')+MyFloatToStr(Pose,2)
   +' secondes');
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Temps de pose = ')+MyFloatToStr(Pose,2)
   +' secondes');

if not NoirMAPAcquis and CheckBox1.Checked then
   begin
   WriteSpy(lang('Acquisition du noir'));
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Acquisition du noir'));
   AcqNoir;
   NoirMAPAcquis:=True;
   end;

try

LargFen:=config.LargFoc;

TimeDebut:=Now;
WriteSpy(lang('Début de l''optimisation'));
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Début de l''optimisation'));

// Trouver ses coordonnees en Binning 4x4
WriteSpy(lang('Recherche des coordonnées de l''étoile la plus brillante'));
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Recherche des coordonnées de l''étoile la plus brillante'));
//AcqNonSatur(x,y);
pop_camera.AcqMaximumBinning(XMap,YMap);
if Camera.IsAValidBinning(4) then
   begin
   XMap:=XMap*4;
   YMap:=YMap*4;
   end
else
   begin
   XMap:=XMap*3;
   YMap:=YMap*3;
   end;

WriteSpy(lang('Coordonnées de l''étoile X = ')+IntToStr(XMap)
   +' Y = '+IntToStr(YMap)); //nolang
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Coordonnées de l''étoile X = ')+IntToStr(XMap)
   +' Y = '+IntToStr(YMap)); //nolang
// Premiere aquisition de l'etoile
WriteSpy(lang('Passage en vignette'));
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(lang('Passage en vignette'));
if (XMap>LargFen+1) and (YMap>LargFen+1) and (XMap<Camera.GetXSize-LargFen) and (YMap<Camera.GetYSize-LargFen) then
   begin
   pop_camera.Acquisition(XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen,Pose,1,False);

   //Soustraction du noir
   if NoirMAPAcquis  and CheckBox1.Checked then
      begin
      GetImgPart(MemPicNoir,MemPicNoirDouble,VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
         1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,pop_map.XMap-LargFen,pop_map.YMap-LargFen,
         pop_map.XMap+LargFen,pop_map.YMap+LargFen);
      Soust(pop_camera.pop_image_acq.DataInt,VignetteNoir,pop_camera.pop_image_acq.DataDouble,VignetteNoirDouble,
         pop_camera.pop_image_acq.ImgInfos.TypeData,1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
         pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy);
      FreememImg(VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
         pop_camera.pop_image_acq.ImgInfos.TypeData,1);
      end;

   pop_camera.pop_image_acq.AjusteFenetre;
   pop_camera.pop_image_acq.VisuAutoEtoiles;
   if Assigned(pop_map_monitor) then pop_map_monitor.AfficheImage(pop_camera.pop_image_acq);
   end
else
   begin
   WriteSpy(lang('Etoile trop près du bord'));
   WriteSpy(lang('On arrête'));
   if Assigned(pop_map_monitor) then
      begin
      pop_map_monitor.AddMessage(lang('Etoile trop près du bord'));
      pop_map_monitor.AddMessage(lang('On arrête'));
      pop_map_monitor.Button3.Enabled:=True;
      pop_map_monitor.Button4.Enabled:=False;
      end;
   Result:=False;
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;

// Pour Valmax
GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
   pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);

// Pour centrer
case Config.TypeMesureFWHM of
   0:begin
     XMap:=XMap-LargFen+Round(xx);
     YMap:=YMap-LargFen+Round(yy);
     end;
   1:begin
     HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,2*LargFen+1,
        2*LargFen+1,xxd,yyd,Diametre);
     XMap:=XMap-LargFen+Round(xxd);
     YMap:=YMap-LargFen+Round(yyd);
     end;
   end;

if Config.Verbose then
   WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));

// On va bouger pendant Config.DelaiFocOptim
DelaiFoc:=Config.DelaiFocOptim;

// Corriger les coordonnées pour mettre l'etoile au centre
// Corriger x et y en fonction de xx et yy
//GetMax(pop_camera.pop_image_acq.dataInt,ImgNil,2,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);
// Pour centrer
case Config.TypeMesureFWHM of
   0:begin
     XMap:=XMap-LargFen+Round(xx);
     YMap:=YMap-LargFen+Round(yy);
     end;
   1:begin
     HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,2*LargFen+1,
        2*LargFen+1,xxd,yyd,Diametre);
     XMap:=XMap-LargFen+Round(xxd);
     YMap:=YMap-LargFen+Round(yyd);
     end;
   end;

// On fait une mesure initiale
//Mesure D1
MyMessage:='On fait une mesure initiale';
WriteSpy(MyMessage);
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
Mesure1:=Serie(Fwhm,Config.NbEssaiFocSlow,False,0,Config.TypeMesureFWHM,Config.UseMoyenne,Temp,True,True,clBlack);
if Mesure1<0 then
   begin
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;
if Mesure1<MesureMini then MesureMini:=Mesure1;

// puis une manœuvre en marche arrière.
//Déplacement arrière
MyMessage:='Puis une manoeuvre en marche arrière';
WriteSpy(MyMessage);
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
OK:=Focuser.FocuserMoveTime(mapArriere,mapLent,Config.DelaiFocOptim);
Inc(NbManoeuvres);
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   raise MyError.Create(MyMessage);
   end;

// Puis une deuxieme mesure
//Mesure D2
MyMessage:='Puis une deuxieme mesure';
WriteSpy(MyMessage);
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
Mesure2:=Serie(Fwhm,Config.NbEssaiFocSlow,False,0,Config.TypeMesureFWHM,Config.UseMoyenne,Temp,True,True,clRed);
if Mesure2<0 then
   begin
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;
if Mesure2<MesureMini then MesureMini:=Mesure2;   

// Premier cas:
// Si c'est moins bien, on inverse
// D2 > D1: inversion
if Mesure2>Mesure1 then
   begin
//   Le diamètre a augmenté, on inverse : manœuvre en avant..
//   MyMessage:='C''est moins bien, on inverse';
   MyMessage:='Le diamètre a augmenté, on inverse : manoeuvre en avant..';
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   // déplacement avant
   Direction:=mapAvant;
   OK:=Focuser.FocuserMoveTime(mapAvant,mapLent,Config.DelaiFocOptim);
   Inc(NbManoeuvres);
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      raise MyError.Create(MyMessage);
      end;

   //Mesure D3
   Mesure3:=Serie(Fwhm,Config.NbEssaiFocSlow,False,0,Config.TypeMesureFWHM,Config.UseMoyenne,Temp,True,True,clGreen);
   if Mesure3<0 then
      begin
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;
   if Mesure3<MesureMini then MesureMini:=Mesure3;

   //Tant que D3 < D2 : déplacement avant
   while Mesure3<Mesure2 do
      begin
//1.Mettre "Le diamètre a "diminué (augmenté)" au lieu de "C'est mieux (moins bien)"
//      MyMessage:='C''est mieux, on continue';
      MyMessage:='Le diamètre a diminué';
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);

      Mesure2:=Mesure3;

      MyMessage:='Manoeuvre en avant';
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      OK:=Focuser.FocuserMoveTime(mapAvant,mapLent,Config.DelaiFocOptim);
      Inc(NbManoeuvres);
      if not OK then
         begin
         MyMessage:=Focuser.GetError;
         WriteSpy(MyMessage);
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
         raise MyError.Create(MyMessage);
         end;

      //Mesure D3
      Mesure3:=Serie(Fwhm,Config.NbEssaiFocSlow,False,0,Config.TypeMesureFWHM,Config.UseMoyenne,Temp,True,True,clGreen);
      if Mesure3<0 then
         begin
         pop_camera.pop_image_acq.Bloque:=False;
         Exit;
         end;
      if Mesure3<MesureMini then MesureMini:=Mesure3;

      end;
   //Dés que D3 > D2 : inversion, déplacement arrière (D2 est le diamètre-cible)
   MesureCible:=MesureMini;
   if Assigned(pop_map_monitor) then pop_map_monitor.ShowLine(MesureCible);
   end
else
   begin
   //Deuxième cas :
   //D2 < D1 :
   //déplacement arrière
//1.Mettre "Le diamètre a "diminué (augmenté)" au lieu de "C'est mieux (moins bien)"
//      MyMessage:='C''est mieux, on continue';
   MyMessage:='Le diamètre a diminué';
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);

   MyMessage:='Manoeuvre en arrière';
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   Direction:=mapArriere;
   OK:=Focuser.FocuserMoveTime(mapArriere,mapLent,Config.DelaiFocOptim);
   Inc(NbManoeuvres);   
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      raise MyError.Create(MyMessage);
      end;

   //Mesure D3
   Mesure3:=Serie(Fwhm,Config.NbEssaiFocSlow,False,0,Config.TypeMesureFWHM,Config.UseMoyenne,Temp,True,True,clRed);
   if Mesure3<0 then
      begin
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;
   if Mesure3<MesureMini then MesureMini:=Mesure3;

   //Tant que D3 < D2 : déplacement arrière
   while Mesure3<Mesure2 do
      begin
//1.Mettre "Le diamètre a "diminué (augmenté)" au lieu de "C'est mieux (moins bien)"
//      MyMessage:='C''est mieux, on continue';
      MyMessage:='Le diamètre a diminué';
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);

      Mesure2:=Mesure3;

      MyMessage:='Manoeuvre en arrière';
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      OK:=Focuser.FocuserMoveTime(mapArriere,mapLent,Config.DelaiFocOptim);
      Inc(NbManoeuvres);      
      if not OK then
         begin
         MyMessage:=Focuser.GetError;
         WriteSpy(MyMessage);
         if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
         raise MyError.Create(MyMessage);
         end;

      //Mesure D3
      Mesure3:=Serie(Fwhm,Config.NbEssaiFocSlow,False,0,Config.TypeMesureFWHM,Config.UseMoyenne,Temp,True,True,clRed);
      if Mesure3<0 then
         begin
         pop_camera.pop_image_acq.Bloque:=False;
         Exit;
         end;
      if Mesure3<MesureMini then MesureMini:=Mesure3;
      end;

   //Dés que D3 > D2 : inversion, déplacement avant (D2 est le diamètre-cible)
   MesureCible:=MesureMini;
   if Assigned(pop_map_monitor) then pop_map_monitor.ShowLine(MesureCible);   
   end;

MyMessage:='On a franchi le minimum';
WriteSpy(MyMessage);
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);

MyMessage:='Diamètre Cible = '+MyFloatToStr(MesureCible,3);
WriteSpy(MyMessage);
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);

// On inverse
MyMessage:='On inverse';
WriteSpy(MyMessage);
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
if Direction=mapArriere then Direction:=mapAvant else Direction:=mapArriere;

Mesure2:=Mesure3;

// On se deplace un coup
if Direction=MapAvant then
   MyMessage:='Manoeuvre en avant'
else
   MyMessage:='Manoeuvre en arrière';
WriteSpy(MyMessage);
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
OK:=Focuser.FocuserMoveTime(Direction,mapLent,Config.DelaiFocOptim);
Inc(NbManoeuvres);
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   raise MyError.Create(MyMessage);
   end;

//Mesure D3
if Direction=MapAvant then Color:=clGreen else Color:=clRed;
Mesure3:=Serie(Fwhm,Config.NbEssaiFocSlow,False,0,Config.TypeMesureFWHM,Config.UseMoyenne,Temp,True,True,Color);
if Mesure3<0 then
   begin
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;
if Mesure3<MesureMini then MesureMini:=Mesure3;

Tolerance:=Config.Tolerance;
MyMessage:='Tolérance = '+MyFloatToStr(Tolerance,3)+' %';
WriteSpy(MyMessage);
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
while Mesure3>MesureCible*(1+Tolerance/100) do
   begin
//14:15:35 Le diamètre est supérieur à 7,626 + 0.2 %
//14:15:35 Le diamètre a augmenté, on inverse : manœuvre en avant.
//14:15:35 Nouvelle tolérance = 0,4 %

//   MyMessage:='Inférieur à la cible, on continue';
   MyMessage:='Le diamètre est supérieur à '+MyFloatToStr(MesureCible,3)+' + '+MyFloatToStr(Tolerance,3)+' %';
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);

   Mesure2:=Mesure3;

   // On se deplace un coup
   if Direction=MapAvant then
      MyMessage:='Manoeuvre en avant'
   else
      MyMessage:='Manoeuvre en arrière';
   OK:=Focuser.FocuserMoveTime(Direction,mapLent,Config.DelaiFocOptim);
   Inc(NbManoeuvres);
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      raise MyError.Create(MyMessage);
      end;

   //Mesure D3
   if Direction=MapAvant then Color:=clGreen else Color:=clRed;
   Mesure3:=Serie(Fwhm,Config.NbEssaiFocSlow,False,0,Config.TypeMesureFWHM,Config.UseMoyenne,Temp,True,True,Color);
   if Mesure3<0 then
      begin
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;
   if Mesure3<MesureMini then MesureMini:=Mesure3;

   // Inversion
   if Mesure3>Mesure2 then
      begin
//      Le diamètre a augmenté, on inverse : manœuvre en avant..
//      MyMessage:='C''est moins bien, on inverse';
      if Direction=mapArriere then
         begin
         Direction:=mapAvant;
         MyMessage:='Le diamètre a augmenté, on inverse : manoeuvre en avant..';
         end
      else
         begin
         Direction:=mapArriere;
         MyMessage:='Le diamètre a augmenté, on inverse : manoeuvre en arrière..';
         end;

      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);

      //14:15:35 Nouvelle tolérance = 0,4 %
      Tolerance:=Tolerance*Config.FacteurInflation;
      MyMessage:='Nouvelle tolérance = '+MyFloatToStr(Tolerance,3)+' %';
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      end;
   end;

//14:15:49 On est sous la valeur du diamètre-cible augmenté de la tolérance
//Pour les raisons indiquées  plus haut, ce serait peut-être mieux de mettre :
//14:15:49 Le diamètre est inférieur à 7,626 + 0.4 %
//MyMessage:='On est sous la valeur du diamètre-cible augmenté de la tolérance';
MyMessage:='Le diamètre est inférieur à '+MyFloatToStr(MesureCible,3)+' + '+MyFloatToStr(Tolerance,3)+' %';
WriteSpy(MyMessage);
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);

MyMessage:='Fin de l''optimisation ';
WriteSpy(MyMessage);
if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);

// Seeing a ajouter
Seeing:=ArcTan(Sqrt((Sqr(Mesure3*Camera.GetXPixelSize/1e6)/2
   +Sqr(Fwhm2*Camera.GetYPixelSize/1e6)/2))/Config.FocaleTele*1000)*180/Pi*3600;

WriteSpy(lang('Seeing = ')+MyFloatToStr(Seeing,2)+
   lang(' ArcSec ( ')+MyFloatToStr(Mesure3,2)+
   lang(' Pixels )'));
if Assigned(pop_map_monitor) then
   pop_map_monitor.AddMessage(lang('Seeing = ')+MyFloatToStr(Seeing,2)+
      lang(' ArcSec ( ')+MyFloatToStr(Mesure3,2)+
      lang(' Pixels )'));


TimeFin:=Now;
DureeAF:=(TimeFin-TimeDebut)*24*60;
if DureeAF>=1 then
   begin
   WriteSpy('Durée de l''Autofocus = '+MyFloatToStr(Int(DureeAF),0)+lang(' Minutes ')
      +MyFloatToStr(Frac(DureeAF)*60,0)+lang(' Secondes'));
   if Assigned(pop_map_monitor) then
      pop_map_monitor.AddMessage('Durée de l''Autofocus = '+MyFloatToStr(Int(DureeAF),0)+lang(' Minutes ')
         +MyFloatToStr(Frac(DureeAF)*60,0)+lang(' Secondes'));
   end
else
   begin
   WriteSpy('Durée de l''Autofocus = '+MyFloatToStr(DureeAF*60,0)+lang(' Secondes'));
   if Assigned(pop_map_monitor) then
      pop_map_monitor.AddMessage('Durée de l''Autofocus = '+MyFloatToStr(DureeAF*60,0)+lang(' Secondes'));
   end;

WriteSpy(lang('Nombre de manoeuvres = ')+IntToStr(NbManoeuvres));
if Assigned(pop_map_monitor) then
   pop_map_monitor.AddMessage(lang('Nombre de manoeuvres = ')+IntToStr(NbManoeuvres));

finally
Config.TypeMesureFWHM:=TypeMesureFWHMSave;
Config.UseMoyenne:=UseMoyenneSave;
pop_camera.pop_image_acq.Bloque:=False;
TesteFocalisation:=False;
if CorrectionSave then Focuser.SetCorrectionOn else Focuser.SetCorrectionOff;
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   FocuserDisconnect;
   raise MyError.Create(MyMessage);
   end;
pop_map_monitor.Button3.Enabled:=True;
pop_map_monitor.Button4.Enabled:=False;
pop_map_monitor.Button2.Enabled:=True;
pop_map_monitor.Button5.Enabled:=True;
pop_map_monitor.Button1.Enabled:=True;
btn_manuel.Enabled:=True;
btn_auto.Enabled:=True;
Button1.Enabled:=True;
Button5.Enabled:=True;
Edit5.Enabled:=True;
SpinButton2.Enabled:=True;
end;

end;

end.
