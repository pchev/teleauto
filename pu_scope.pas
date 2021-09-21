unit pu_scope;

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
  StdCtrls, Buttons, ComCtrls, Mask, ExtCtrls, u_class, IniFiles,
  Spin, Editnbre;

type
  Tpop_scope = class(TForm)
    PageControl1: TPageControl;
    pad: TTabSheet;
    pointage: TTabSheet;
    GroupBoxDeplacement: TGroupBox;
    btnSpeed1: TSpeedButton;
    btnSpeed2: TSpeedButton;
    btnSpeed3: TSpeedButton;
    btnSpeed4: TSpeedButton;
    GroupBoxInversion: TGroupBox;
    cb_inversionNS: TCheckBox;
    cb_InversionEO: TCheckBox;
    GroupBox11: TGroupBox;
    id: TEdit;
    btn_pointer_objet: TButton;
    btn_realigner_objet: TButton;
    GroupBox10: TGroupBox;
    outLabel17: TLabel;
    outLabel22: TLabel;
    mask_alpha: TMaskEdit;
    Mask_delta: TMaskEdit;
    btn_pointer: TButton;
    btn_realigner: TButton;
    OpenDialog: TOpenDialog;
    outLabel30: TLabel;
    outLabel31: TLabel;
    PnlAlpha: TPanel;
    PnlDelta: TPanel;
    outPark_tab: TTabSheet;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    img_last_command: TImage;
    GroupBox1: TGroupBox;
    outButton2: TButton;
    cb_physique: TCheckBox;
    outButton3: TButton;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    NbreEdit1: NbreEdit;
    BitBtn5: TBitBtn;
    Timer2: TTimer;
    HourAngle: TPanel;
    LST: TPanel;
    PanelAirmass: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    TabSheet1: TTabSheet;
    Button4: TButton;
    Button5: TButton;
    CheckBox2: TCheckBox;
    TabSheet2: TTabSheet;
    Label75: TLabel;
    Edit44: TEdit;
    Label86: TLabel;
    Button6: TButton;
    Label7: TLabel;
    SpinEdit2: TSpinEdit;
    Button7: TButton;
    btn_RecenterStar: TButton;
    CheckBox3: TCheckBox;
    Label8: TLabel;
    Button1: TButton;
    BitBtn7: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    BitBtn6: TBitBtn;
    BitBtn8: TBitBtn;
    CheckBox4: TCheckBox;

    // GOTO
    procedure btnSpeed1Click(Sender: TObject);
    procedure btnSpeed2Click(Sender: TObject);
    procedure btnSpeed3Click(Sender: TObject);
    procedure btnSpeed4Click(Sender: TObject);
    procedure btn_pointerClick(Sender: TObject);
    procedure btn_realignerClick(Sender: TObject);
    procedure cbo_catalogChange(Sender: TObject);
    procedure btn_realigner_objetClick(Sender: TObject);
    procedure btn_pointer_objetClick(Sender: TObject);
    procedure btn_RecenterStarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cb_inversionNSClick(Sender: TObject);
    procedure cb_InversionEOClick(Sender: TObject);
    procedure outButton2Click(Sender: TObject);
    procedure outButton3Click(Sender: TObject);
    procedure BitBtn1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpinEdit1Change(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Edit44Change(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    NbImpulsionsCourantes,NbImpulsions:Integer;
    StopCalibrate:Boolean;
    XTrack,YTrack,XTrackXMoins,YTrackXMoins,XTrackXPlus,YTrackXPlus:Double;
    XTrackYMoins,YTrackYMoins,XTrackYPlus,YTrackYPlus:Double;
    Error:string;

    procedure CalibrerRecentrage(TempsDePose:Double);
    procedure CalibrerRecentrageGuidage(TempsDePose:Double);
    procedure Recentre(XMarque,YMarque:Integer;SurMarque:Boolean);
    procedure RecentreGuidage(XMarque,YMarque:Integer;SurMarque:Boolean);

    procedure CheckScopeComm;
    procedure EnableButtons;
    procedure DesableButtons;
    procedure EnablePadButtons;
    procedure DesablePadButtons;

    // Scripts
    procedure SetObjectName(Name:string);
    procedure PointObject;
    procedure RealignObject;
    procedure SetAlphaCoordinates(Alpha:Double);
    procedure SetDeltaCoordinates(Delta:Double);
    procedure PointCoordinates;
    procedure RealignCoordinates;
    procedure MainCCDCenter;
    procedure GuideCCDCenter;
    procedure StopScope;
    procedure SetMarkOn;
    procedure SetMarkOff;
    
    procedure SetPulseOn;
    procedure SetPulseOff;
    procedure SetPulseDelay(Delay:Double);
    procedure Speed1;
    procedure Speed2;
    procedure Speed3;
    procedure Speed4;
    procedure SetInvertNSOn;
    procedure SetInvertNSOff;
    procedure SetInvertEWOn;
    procedure SetInvertEWOff;
    procedure NorthMouseDown;
    procedure NorthMouseUp;
    procedure SouthMouseDown;
    procedure SouthMouseUp;
    procedure WestMouseDown;
    procedure WestMouseUp;
    procedure EastMouseDown;
    procedure EastMouseUp;

    procedure ScriptPark;
    procedure ScriptUnPark;
    procedure SetPhysicalParkOn;
    procedure SetPhysicalParkOff;
    procedure SetFastSpeed(Speed:Byte);

    function GetPosition(var Alpha,Delta:Double):Boolean;
    function Point(Alpha,Delta:Double):Boolean;
    function GetError:string;
    function Wait(Alpha,Delta:Double):Boolean;
    function WaitObjectName(ObjectName:string):Boolean;    
    function PointObjectName(ObjectName:string):Boolean;
    function Realign(Alpha,Delta:Double):Boolean;
    function RealignObjectName(ObjectName:string):Boolean;
    function StartMotion(Direction:string):Boolean;
    function StopMotion(Direction:string):Boolean;
    function MotionRate(MotionNumber:Integer):Boolean;
    function Quit:Boolean;

  end;

var
  pop_scope:Tpop_scope;

implementation

uses u_general,
     u_math,
     u_meca,
     u_file_io,
     catalogues,
     pu_camera,
     u_constants,
     pu_main,
     u_lang,
     u_cameras,
     pu_conf,
     u_telescopes,
     u_hour_servers,
     pu_calib_modele,
     pu_anal_modele,
     u_modele_pointage,
     pu_dessin,
     pu_calibrate_track,
     pu_track,
     pu_camera_suivi,
     pu_image,
     u_analyse,
     u_modelisation,
     Math,
     u_geometrie,
     u_arithmetique;

{$R *.DFM}


{-------------------------- Park / Unpark -------------------------------------}

function ParkScope:Boolean;
var
   Ini:TMemIniFile;
   Alpha,Delta,Hauteur,Azimuth:Double;
   DateTime:TDateTime;
   Path:String;
   Year,Month,Day,Hour,Min,Sec,MSec:Word;
begin
Result:=True;

Path:=LowerCase(ExtractFilePath(Application.ExeName));
Ini:=TMemIniFile.create(Path+'teleauto.ini'); //nolang

try
if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);

GetHour(Year,Month,Day,Hour,Min,Sec,MSec);
DateTime:=EncodeDate(Year,Month,Day)+EncodeTime(Hour,Min,Sec,MSec);

if Config.GoodPos then
   begin
   Alpha:=Config.AlphaScope;
   Delta:=Config.DeltaScope;

   Hauteur:=GetElevation(DateTime,Alpha,Delta,config.Lat,config.Long);
   Azimuth:=GetAzimuth(DateTime,Alpha,Delta,config.Lat,config.Long);

   Ini.writestring('Park','Hauteur',FloatToStr(Hauteur));
   Ini.writestring('Park','Azimuth',FloatToStr(Azimuth));
   Ini.writestring('Park','DateTime',FloatToStr(DateTime));
   end
else
   begin
   Result:=False;
   WriteSpy(lang('Le télescope ne veut pas donner sa position'));
   WriteSpy('Park : '+ //nolang
      lang('Erreur'));
   end;

finally
Ini.UpdateFile;
Ini.free;
end;
end;

function UnPark:Boolean;
var
GoodHauteur,GoodAzimuth:boolean;
StrHauteur,StrAzimuth:string;

Ini:TMemIniFile;
Hauteur,Azimuth,Alpha,Delta,Alpha1,Delta1:Double;
DateTime:TDateTime;
Path:String;
Year,Month,Day,Hour,Min,Sec,MSec:Word;
begin
Result:=True;

Path:=LowerCase(ExtractFilePath(Application.ExeName));
Ini:=TMemIniFile.create(Path+'teleauto.ini'); //nolang

try

StrHauteur:=ini.readstring('Park','Hauteur','Erreur');
GoodHauteur:=StrHauteur<>'Erreur'; //nolang
StrAzimuth:=ini.readstring('Park','Azimuth','Erreur');
GoodAzimuth:=StrAzimuth<>'Erreur'; //nolang

if GoodHauteur and GoodAzimuth then
   begin
   Hauteur:=MyStrTofloat(StrHAuteur);
   Azimuth:=MyStrTofloat(StrAzimuth);

   GetHour(Year,Month,Day,Hour,Min,Sec,MSec);
   DateTime:=EncodeDate(Year,Month,Day)+EncodeTime(Hour,Min,Sec,MSec);

   GetAlphaDeltaFromHor(DateTime,Hauteur,Azimuth,config.Lat,config.Long,Alpha,Delta);

   pop_Scope.Mask_Alpha.Text:=AlphaToStr(Alpha);
   pop_Scope.Mask_Delta.Text:=DeltaToStr(Delta);

   if not Telescope.Sync(Alpha,Delta) then
      begin
      WriteSpy(lang('Le télescope refuse de se synchroniser'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse de se synchroniser'));
      Result:=False;
      end;
   end
else Result:=False;

finally
Ini.UpdateFile;
Ini.Free;
end;
end;


function ParkReal:Boolean;
var
   Ini:TMemIniFile;
   Alpha,Delta,H,A,azimut,hauteur:Double;
   sid,dttm:TDateTime;
   Path:string;
   Year,Month,Day,Hour,Min,Sec,MSec:Word;
   Error:string;
begin
Result:=True;
Path:=LowerCase(ExtractFilePath(Application.ExeName));
Ini:=TMemIniFile.create(Path+'teleauto.ini'); //nolang
GetHour(Year,Month,Day,Hour,Min,Sec,MSec);
dttm:=EncodeDate(Year,Month,Day)+EncodeTime(Hour,Min,Sec,MSec);
try
a:=MyStrToFloat(Config.park_meridien);
h:=MyStrToFloat(Config.park_decli);
GetAlphaDeltaFromHor(dttm,h,a,config.lat,config.long,alpha,delta);

if not Telescope.Pointe(Alpha,Delta) then
   begin
   ShowMessage(lang('Le télescope ne veut pas pointer les coordonnées'));
   TelescopeErreurFatale;
   Result:=False;
   Exit;
   end;

Error:=Telescope.GetError;
if Error<>'' then
   begin
   WriteSpy(Error);
   Result:=False;
   Exit;
   end
else
   begin
   if not Telescope.WaitPoint(Alpha,Delta) then
      begin
      WriteSpy('Le télescope n''est pas arrivé sur les coordonnées demandées');
      Result:=False;
      Exit;
      end;
   if not Telescope.MotionRate(Telescope.GetTrackSpeedNumber) then
      begin
      WriteSpy(lang('Le télescope refuse le réglage de vitesse'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse le réglage de vitesse'));
      Exit;
      end;
   if not Telescope.StopMotion('E') then
      begin
      WriteSpy('Panique ! Le télescope refuse de s''arrêter');
      pop_Main.AfficheMessage(lang('Erreur'),
         'Panique ! Le télescope refuse de s''arrêter');
      Exit;
      end;
   // On attends une lecture de la position aprés le déplacement
   if Config.Periodic then MySleep(2000)
   else SetEvent(Pop_main.HTimerGetPosEvent);
   if Config.GoodPos then
      begin
      Alpha:=Config.AlphaScope;
      Delta:=Config.DeltaScope;
      // on convertit en horizontal
      azimut:=GetAzimuth(dttm,alpha,delta,config.lat,config.long);
      hauteur:=GetElevation(dttm,alpha,delta,config.lat,config.long);
      Ini.writestring('Park','Hauteur',FloatToStr(Hauteur));
      Ini.writestring('Park','Azimuth',FloatToStr(Azimut));
      Ini.writestring('Park','DateTime',FloatToStr(dttm));
      end
   else
      begin
      Result:=False;
      WriteSpy(lang('Le télescope ne veut pas donner sa position'));
      WriteSpy('ParkReal : '+ //nolang
         lang('Erreur'));
      end;

   end;

finally
Ini.UpdateFile;
Ini.Free;
end;
end;


// RAQUETTE

procedure Tpop_scope.btnSpeed1Click(Sender: TObject);
begin
   DesableButtons;
   try

   if not Telescope.MotionRate(1) then
      begin
      WriteSpy(lang('Le télescope refuse le réglage de vitesse'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse le réglage de vitesse'));
      end;

   finally
   CheckScopeComm;
   EnableButtons;
   end;
end;

procedure Tpop_scope.btnSpeed2Click(Sender: TObject);
begin
   DesableButtons;
   try

   if not Telescope.MotionRate(2) then
      begin
      WriteSpy(lang('Le télescope refuse le réglage de vitesse'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse le réglage de vitesse'));
      end;

   finally
   CheckScopeComm;   
   EnableButtons;
   end;
end;

procedure Tpop_scope.btnSpeed3Click(Sender: TObject);
begin
   DesableButtons;
   try

   if not Telescope.MotionRate(3) then
      begin
      WriteSpy(lang('Le télescope refuse le réglage de vitesse'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse le réglage de vitesse'));
      end;

   finally
   CheckScopeComm;
   EnableButtons;
   end;
end;

procedure Tpop_scope.btnSpeed4Click(Sender: TObject);
begin
   DesableButtons;
   try

   if not Telescope.MotionRate(4) then
      begin
      WriteSpy(lang('Le télescope refuse le réglage de vitesse'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse le réglage de vitesse'));
      end;

   finally
   CheckScopeComm;   
   EnableButtons;
   end;
end;

// GOTO
procedure Tpop_scope.btn_pointerClick(Sender: TObject);
var
   Alpha,Delta,Azimuth,Hauteur:Double;
begin
DesableButtons;
try
if not CheckBox4.Checked then
   begin
   Alpha:=StrToAlpha(mask_alpha.text);
   Delta:=StrToDelta(mask_delta.text);
   end
else
   begin
   Azimuth:=StrToDelta(mask_alpha.text);
   Hauteur:=StrToDelta(mask_delta.text);
   GetAlphaDeltaFromHor(GetHourDT,Hauteur,Azimuth,Config.Lat,Config.Long,Alpha,Delta);
   end;

// Ajout de la gestion d'erreur !!!
// Les exceptions ne doivent etre utilisee que pour les erreurs fatales !!!
if not Telescope.Pointe(Alpha,Delta) then
   begin
   WriteSpy(lang('Le télescope ne veut pas pointer les coordonnées'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope ne veut pas pointer les coordonnées'));
   TelescopeErreurFatale;
   Exit;
   end;

Error:=Telescope.GetError;
if Error<>'' then
   MessageDlg(Error,mtError,[mbOk],0)
else
   begin
   if not Telescope.WaitPoint(Alpha,Delta) then
      begin
      WriteSpy('Le télescope n''est pas arrivé sur les coordonnées demandées');
      pop_Main.AfficheMessage(lang('Erreur'),
         'Le télescope n''est pas arrivé sur les coordonnées demandées');
      end
   else if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
   end;

finally
CheckScopeComm;
EnableButtons;
end;
end;

procedure Tpop_scope.btn_realignerClick(Sender: TObject);
var
Alpha,Delta,Azimuth,Hauteur:Double;
begin
DesableButtons;
try

if not CheckBox4.Checked then
   begin
   Alpha:=StrToAlpha(mask_alpha.text);
   Delta:=StrToDelta(mask_delta.text);
   end
else
   begin
   Azimuth:=StrToDelta(mask_alpha.text);
   Hauteur:=StrToDelta(mask_delta.text);
   GetAlphaDeltaFromHor(GetHourDT,Hauteur,Azimuth,Config.Lat,Config.Long,Alpha,Delta);
   end;

if not Telescope.Sync(Alpha,Delta) then
   begin
   WriteSpy(lang('Le télescope refuse de se synchroniser'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope refuse de se synchroniser'));
   end
else if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);

finally
CheckScopeComm;
EnableButtons;
end;
end;

procedure Tpop_scope.cbo_catalogChange(Sender: TObject);
begin
     id.SetFocus;
end;


procedure Tpop_scope.btn_realigner_objetClick(Sender: TObject);
var
Alpha,Delta,HA,Azimuth,Hauteur:Double;
OK:Boolean;
begin
DesableButtons;

try
if id.text='' then exit;

OK:=NameToAlphaDelta(id.text,Alpha,Delta);
if not OK then
   begin
   MessageDlg(lang('Objet inconnu !'),mtError,[mbOk],0);
   Exit;
   end;

if not Checkbox4.Checked then
   begin
   Mask_Alpha.Text:=AlphaToStr(Alpha);
   Mask_Delta.Text:=DeltaToStr(Delta);
   end
else
   begin
   HA:=GetHourAngle(GetHourDT,Config.AlphaScope,Config.Long)/15; //Degres -> heure
   HA:=HA*15;
   while HA>=360 do HA:=HA-360;
   while HA<0 do HA:=HA+360;
   GetHorFromAlphaDelta(HA,Delta,Config.Lat,Azimuth,Hauteur);
   Mask_Alpha.Text:=DeltaToStr(Azimuth);
   Mask_Delta.Text:=DeltaToStr(Hauteur);
   end;

if not Telescope.Sync(Alpha,Delta) then
   begin
   WriteSpy(lang('Le télescope refuse de se synchroniser'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope refuse de se synchroniser'));
   end
else
   begin
   if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
   end;

finally
CheckScopeComm;
EnableButtons;
end;
end;

procedure Tpop_scope.btn_pointer_objetClick(Sender: TObject);
var
   Alpha,Delta:Double;
   ha_str,Line:String;
   ha:double;
   savepcmoinstu:integer;
   Azimuth,Hauteur,HauteurFin,AzimuthFin:Double;
   local,lst_num:tdatetime;
   a,b,Azimuth1,Azimuth2,Hauteur1,Hauteur2,Hauteur3:Double;
   slew_permit:boolean;
   Year,Month,Day,Hour,Min,Sec,MSec:Word;
   AH,AHCorrige,AlphaCorrige,DeltaCorrige:Double;
   OK:Boolean;
   Error,tmp:string;
begin
DesableButtons;
try
Line:=id.Text;
WriteSpy(lang('Pointe : Demande de pointage sur : ')+line);
if id.text='' then exit;
OK:=NameToAlphaDelta(id.text,Alpha,Delta);
if not OK then
   begin
   MessageDlg(lang('Objet inconnu !'),mtError,[mbOk],0);
   Exit;
   end;

WriteSpy(lang('Pointe : Demande = ')+AlphaToStr(Alpha)+'/'+DeltaToStr(Delta));

//WriteSpy('Alpha demandé = '+AlphaToStr(Alpha));
//WriteSpy('Delta demandé = '+AlphaToStr(Delta));

if not Checkbox4.Checked then
   begin
   Mask_Alpha.Text:=AlphaToStr(Alpha);
   Mask_Delta.Text:=DeltaToStr(Delta);
   end
else
   begin
   HA:=GetHourAngle(GetHourDT,Config.AlphaScope,Config.Long)/15; //Degres -> heure
   HA:=HA*15;
   while HA>=360 do HA:=HA-360;
   while HA<0 do HA:=HA+360;
   GetHorFromAlphaDelta(HA,Delta,Config.Lat,Azimuth,Hauteur);
   tmp:=DeltaToStr(Azimuth);
   Mask_Alpha.Text:=tmp;
   Mask_Delta.Text:=DeltaToStr(Hauteur);
   end;

//WriteSpy('Alpha Mask = '+Mask_Alpha.Text);
//WriteSpy('Delta Mask = '+Mask_Delta.Text);

Mask_Alpha.Text:=AlphaToStr(Alpha);
Mask_Delta.Text:=DeltaToStr(Delta);
if not Telescope.Pointe(Alpha,Delta) then
   begin
   WriteSpy(lang('Le télescope ne veut pas pointer les coordonnées'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope ne veut pas pointer les coordonnées'));
   TelescopeErreurFatale;
   Exit;
   end;

Error:=Telescope.GetError;
if Error<>'' then
   MessageDlg(Error,mtError,[mbOk],0)
else
   begin
   if not Telescope.WaitPoint(Alpha,Delta) then
      begin
      WriteSpy('Le télescope n''est pas arrivé sur les coordonnées demandées');
      pop_Main.AfficheMessage(lang('Erreur'),
         'Le télescope n''est pas arrivé sur les coordonnées demandées');
      end
   else
      if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
   end;

finally
EnableButtons;
end;
end;

procedure TPop_scope.btn_RecenterStarClick(Sender: TObject);
begin
DesableButtons;
btn_RecenterStar.Enabled:=False;
Button7.Enabled:=False;

if pop_camera.pop_image_acq=nil then pop_camera.pop_image_acq:=tpop_image.Create(Application);
pop_camera.pop_image_acq.Bloque:=True;

try
if CheckBox3.Checked then
   begin
   if pop_camera.Pop_image_acq.AjouterMarque1.Checked then
      Recentre(pop_camera.Pop_image_acq.XMarque,pop_camera.Pop_image_acq.YMarque,True)
   else ShowMessage('Pas de marque dans l''image');
   end
else
   Recentre(0,0,False);

if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
   
finally
CheckScopeComm;
btn_RecenterStar.Enabled:=True;
Button7.Enabled:=True;
EnableButtons;
end;
end;

procedure Tpop_scope.FormShow(Sender: TObject);
var
   Alpha,Delta,sidtime,t,x:Double;
   savepcmoinstu,i:integer;
   res:smallint;
   local,lst_num:tdatetime;
   NbButtonSpeed:Integer;
   Year,Month,Day,Hour,Min,Sec,MSec:Word;
   Ini:TMemIniFile;
   Path:string;
   Valeur:Integer;
   OK:Boolean;
begin
Config.InPopScopeFormShow:=True;
try

// Lit la pos
Path:=ExtractFilePath(Application.Exename);
Ini:=TMemIniFile.Create(Path+'TeleAuto.ini'); //nolang
try
Valeur:=StrToInt(Ini.ReadString('WindowsPos','ScopeTop',IntToStr(Self.Top)));
if Valeur<>0 then Top:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','ScopeLeft',IntToStr(Self.Left)));
if Valeur<>0 then Left:=Valeur;
finally
Ini.UpdateFile;
Ini.Free;
end;

Height:=300;
BitBtn8.Visible:=True;
Left:=Screen.Width-Width;
PageControl1.ActivePage:=pad;
UpDateLang(Self);

PnlAlpha.Caption:='';
PnlDelta.Caption:='';

Mask_Alpha.Text:=AlphaToStr(0);
Mask_Delta.Text:=DeltaToStr(90);

if config.InversionNS then cb_InversionNS.Checked:=True;
if config.InversionEO then cb_InversionEO.Checked:=True;

SpinEdit1.Value:=Round(Config.Vitesse);

// Fonctions nécessitant une caméra !
if Config.CameraBranchee then
   begin
   btn_RecenterStar.Enabled:=True;
   end
else
   begin
   btn_RecenterStar.Enabled:=False;
   end;

// Fonctions nécessitant une caméra de guidage !
if Config.CameraBranchee then
   begin
   Button7.Enabled:=True;
   end
else
   begin
   Button7.Enabled:=False;
   end;

if btnSpeed1.Down then OK:=Telescope.MotionRate(1);
if btnSpeed2.Down then OK:=Telescope.MotionRate(2);
if btnSpeed3.Down then OK:=Telescope.MotionRate(3);
if btnSpeed4.Down then OK:=Telescope.MotionRate(4);
if not OK then
   begin
   WriteSpy(lang('Le télescope refuse le réglage de vitesse'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope refuse le réglage de vitesse'));
   end;

try
if (Telescope.CanSetSpeed) then
   begin
   Telescope.SetSpeed(Round(Config.Vitesse));
   GroupBox2.Visible:=True; //nolang
   end
else
   begin
   GroupBox2.Visible:=False; //nolang
   end;
except
TelescopeDisconnect;
// On peut pas fermer une fenetre dans son OnShow
//   pop_Main.UpDateGUITelescope;
end;

if not(Telescope.StoreCoordinates) then
   begin
   PageControl1.pages[1].TabVisible:=False;
   PageControl1.pages[2].TabVisible:=False;
   Height:=260;
   end;

NbButtonSpeed:=Telescope.GetTrackSpeedNumber;

if NbButtonSpeed<=1 then GroupBoxDeplacement.Visible:=False;
if NbButtonSpeed>=2 then
   begin
   btnSpeed1.Visible:=True;
   btnSpeed2.Visible:=True;
   end
else
   begin
   btnSpeed1.Visible:=False;
   btnSpeed2.Visible:=False;
   end;
if NbButtonSpeed>=3 then btnSpeed3.Visible:=True else btnSpeed3.Visible:=False;
if NbButtonSpeed>=4 then btnSpeed4.Visible:=True else btnSpeed4.Visible:=False;

GroupBoxDeplacement.Height:=20+NbButtonSpeed*btnSpeed1.Height;
if GroupBoxDeplacement.Height>117 then GroupBoxDeplacement.Height:=117;
GroupBoxDeplacement.Top:=(pad.Height-GroupBoxDeplacement.Height) div 2;
if GroupBoxDeplacement.Top<44 then GroupBoxDeplacement.Top:=44;

CheckBox2.Checked:=Config.UseModelePointage;
CheckBox2.Enabled:=Config.ModelePointageCalibre;

Edit44.Text:=MyFloatToStr(config.DelaiCalibrationRecentrage,2);
SpinEdit2.Text:=IntToStr(Config.IterRecentrage);

if config.CalibrateRecentrage then
   begin
   btn_RecenterStar.Enabled:=True;
   end
else
   begin
   btn_RecenterStar.Enabled:=False;
   end;

if config.CalibrateRecentrageSuivi then
   begin
   Button7.Enabled:=True;
   end
else
   begin
   Button7.Enabled:=False;
   end;

if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);

finally
Config.InPopScopeFormShow:=False
end;
end;

procedure Tpop_scope.cb_inversionNSClick(Sender: TObject);
begin
if cb_InversionNS.Checked then config.InversionNS:=True else config.InversionNS:=False;
end;

procedure Tpop_scope.cb_InversionEOClick(Sender: TObject);
begin
if cb_InversionEO.Checked then config.InversionEO:=True else config.InversionEO:=False;
end;

procedure Tpop_scope.outButton2Click(Sender: TObject);
begin
DesableButtons;

if not cb_physique.checked then
   begin
   if ParkScope then ShowMessage(lang('Coordonnées locales enregistrées, ne tardez pas à éteindre votre télescope !'))
   else ShowMessage(lang('Erreur à l''enregistrement des coordonnées locales'));
   end
else
   begin
   if ParkReal then ShowMessage(lang('Coordonnées locales enregistrées, ne tardez pas à éteindre votre télescope !')+
      #13#10+lang('** Télescope Parqué **')) else
   ShowMessage(lang('Erreur à l''enregistrement des coordonnées locales'));
   end;
end;

procedure Tpop_scope.outButton3Click(Sender: TObject);
begin
DesableButtons;
try

if UnPark then ShowMessage(lang('Coordonnées du télescope mises à jour'))
else ShowMessage(lang('Erreur à la mise à jour des coordonnées du télescope '));

if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);

finally
CheckScopeComm;
EnableButtons;
end;
end;

procedure Tpop_scope.BitBtn1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   Alpha,Delta:Double;
   TimeInit:TDateTime;
   TimeToWait:Double;
   NotError:Boolean;
begin
   BitBtn2.Enabled:=False;
   BitBtn3.Enabled:=False;
   BitBtn4.Enabled:=False;
   DesablePadButtons;

   img_last_command.Picture.Bitmap.Assign(BitBtn1.Glyph);
   TimeToWait:=MyStrToFloat(NbreEdit1.Text);

   if Cb_InversionNS.checked then NotError:=Telescope.StartMotion('S')
   else NotError:=Telescope.StartMotion('N');

   if NotError then
      begin
      if CheckBox1.Checked then
         begin
         BitBtn1.Enabled:=False;
         Timer2.Enabled:=True;
         NbImpulsionsCourantes:=0;
         NbImpulsions:=Round(TimeToWait*10);
         end;
      end
   else
      begin
      WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse de démarrer le déplacement'));
      end;

end;

procedure Tpop_scope.BitBtn1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   Alpha,Delta:Double;
   NotError:Boolean;
begin
try

if not(CheckBox1.Checked) then
   begin
   if Cb_InversionNS.checked then NotError:=Telescope.StopMotion('S')
   else NotError:=Telescope.StopMotion('N');

  if not NotError then
     begin
     WriteSpy('Panique ! Le télescope refuse de s''arrêter');
     pop_Main.AfficheMessage(lang('Erreur'),
        'Panique ! Le télescope refuse de s''arrêter');
     end;

   if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
   end;

finally
CheckScopeComm;
BitBtn1.Enabled:=True;
BitBtn2.Enabled:=True;
BitBtn3.Enabled:=True;
BitBtn4.Enabled:=True;
EnablePadButtons;
end;
end;

procedure Tpop_scope.BitBtn2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   Alpha,Delta:Double;
   TimeInit:TDateTime;
   TimeToWait:Double;
   NotError:Boolean;
begin
   BitBtn1.Enabled:=False;
   BitBtn3.Enabled:=False;
   BitBtn4.Enabled:=False;
   DesablePadButtons;

   img_last_command.Picture.Bitmap.Assign(BitBtn2.Glyph);
   TimeToWait:=MyStrToFloat(NbreEdit1.Text);

   if Cb_InversionNS.checked then NotError:=Telescope.StartMotion('N')
   else NotError:=Telescope.StartMotion('S');

   if NotError then
      begin
      if CheckBox1.Checked then
         begin
         BitBtn2.Enabled:=False;
         Timer2.Enabled:=True;
         NbImpulsionsCourantes:=0;
         NbImpulsions:=Round(TimeToWait*10);
         end
      end
   else
      begin
      WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse de démarrer le déplacement'));
      end;
end;

procedure Tpop_scope.BitBtn2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   Alpha,Delta:Double;
   NotError:Boolean;
begin
try

if not(CheckBox1.Checked) then
   begin
   if Cb_InversionNS.checked then NotError:=Telescope.StopMotion('N')
   else NotError:=Telescope.StopMotion('S');

  if not NotError then
     begin
     WriteSpy('Panique ! Le télescope refuse de s''arrêter');
     pop_Main.AfficheMessage(lang('Erreur'),
        'Panique ! Le télescope refuse de s''arrêter');
     end;

   if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
   end;

finally
CheckScopeComm;
BitBtn1.Enabled:=True;
BitBtn2.Enabled:=True;
BitBtn3.Enabled:=True;
BitBtn4.Enabled:=True;
EnablePadButtons;
end;
end;

procedure Tpop_scope.BitBtn3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   Alpha,Delta:Double;
   TimeInit:TDateTime;
   TimeToWait:Double;
   NotError:Boolean;
begin
   BitBtn1.Enabled:=False;
   BitBtn2.Enabled:=False;
   BitBtn4.Enabled:=False;
   DesablePadButtons;

   img_last_command.Picture.Bitmap.Assign(BitBtn3.Glyph);

   if Cb_InversionEO.checked then NotError:=Telescope.StartMotion('E')
   else NotError:=Telescope.StartMotion('W');

   if NotError then
      begin
      if CheckBox1.Checked then
         begin
         TimeToWait:=MyStrToFloat(NbreEdit1.Text);
         BitBtn3.Enabled:=False;
         Timer2.Enabled:=True;
         NbImpulsionsCourantes:=0;
         NbImpulsions:=Round(TimeToWait*10);
         end;
      end
   else
      begin
      WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse de démarrer le déplacement'));
      end;
end;

procedure Tpop_scope.BitBtn3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   Alpha,Delta:Double;
   NotError:Boolean;
begin
try

if not(CheckBox1.Checked) then
   begin
   if Cb_InversionEO.checked then NotError:=Telescope.StopMotion('E')
   else NotError:=Telescope.StopMotion('W');

   if not NotError then
     begin
     WriteSpy('Panique ! Le télescope refuse de s''arrêter');
     pop_Main.AfficheMessage(lang('Erreur'),
        'Panique ! Le télescope refuse de s''arrêter');
     end;

   if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
   end;

finally
CheckScopeComm;
BitBtn1.Enabled:=True;
BitBtn2.Enabled:=True;
BitBtn3.Enabled:=True;
BitBtn4.Enabled:=True;
EnablePadButtons;
end;
end;

procedure Tpop_scope.BitBtn4MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   Alpha,Delta:Double;
   TimeInit:TDateTime;
   TimeToWait:Double;
   NotError:Boolean;
begin
   BitBtn1.Enabled:=False;
   BitBtn2.Enabled:=False;
   BitBtn3.Enabled:=False;
   DesablePadButtons;

   img_last_command.Picture.Bitmap.Assign(BitBtn4.Glyph);
   TimeToWait:=MyStrToFloat(NbreEdit1.Text);

   if Cb_InversionEO.checked then NotError:=Telescope.StartMotion('W')
   else NotError:=Telescope.StartMotion('E');

   if NotError then
      begin
      if CheckBox1.Checked then
         begin
         BitBtn4.Enabled:=False;
         Timer2.Enabled:=True;
         NbImpulsionsCourantes:=0;
         NbImpulsions:=Round(TimeToWait*10);
         end;
      end
   else
      begin
      WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse de démarrer le déplacement'));
      end;
end;

procedure Tpop_scope.BitBtn4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   Alpha,Delta:Double;
   NotError:Boolean;
begin
try

if not(CheckBox1.Checked) then
   begin
   if Cb_InversionEO.checked then NotError:=Telescope.StopMotion('W')
   else NotError:=Telescope.StopMotion('E');

   if Not NotError then
     begin
     WriteSpy('Panique ! Le télescope refuse de s''arrêter');
     pop_Main.AfficheMessage(lang('Erreur'),
        'Panique ! Le télescope refuse de s''arrêter');
     end;

   if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
   end;

finally
CheckScopeComm;
BitBtn1.Enabled:=True;
BitBtn2.Enabled:=True;
BitBtn3.Enabled:=True;
BitBtn4.Enabled:=True;
EnablePadButtons;
end;
end;

procedure Tpop_scope.CheckScopeComm;
var
Alpha,Delta:Double;
begin
   if not(Config.TelescopeBranche) then
      ShowMessage(lang('Perte de la communication avec le télescope'));
end;

procedure Tpop_scope.DesablePadButtons;
begin
btnSpeed1.Enabled:=False;
btnSpeed2.Enabled:=False;
btnSpeed3.Enabled:=False;
btnSpeed4.Enabled:=False;
btn_pointer.Enabled:=False;
btn_pointer_objet.Enabled:=False;
btn_realigner_objet.Enabled:=False;
btn_realigner.Enabled:=False;

btn_RecenterStar.Enabled:=False;
Button7.Enabled:=False;
outButton2.Enabled:=False;
outButton3.Enabled:=False;
end;

procedure Tpop_scope.EnablePadButtons;
begin
btnSpeed1.Enabled:=True;
btnSpeed2.Enabled:=True;
btnSpeed3.Enabled:=True;
btnSpeed4.Enabled:=True;
btn_pointer.Enabled:=True;
btn_pointer_objet.Enabled:=True;
btn_realigner_objet.Enabled:=True;
btn_realigner.Enabled:=True;
btn_RecenterStar.Enabled:=True;
Button7.Enabled:=True;
outButton2.Enabled:=True;
outButton3.Enabled:=True;
end;

procedure Tpop_scope.DesableButtons;
begin
btn_pointer.Enabled:=False;
btn_pointer_objet.Enabled:=False;
btn_realigner_objet.Enabled:=False;
btn_realigner.Enabled:=False;
outButton2.Enabled:=False;
outButton3.Enabled:=False;
BitBtn1.Enabled:=False;
BitBtn2.Enabled:=False;
BitBtn3.Enabled:=False;
BitBtn4.Enabled:=False;
btnSpeed1.Enabled:=False;
btnSpeed2.Enabled:=False;
btnSpeed3.Enabled:=False;
btnSpeed4.Enabled:=False;
end;

procedure Tpop_scope.EnableButtons;
begin
btn_pointer.Enabled:=True;
btn_pointer_objet.Enabled:=True;
btn_realigner_objet.Enabled:=True;
btn_realigner.Enabled:=True;
outButton2.Enabled:=True;
outButton3.Enabled:=True;
BitBtn1.Enabled:=True;
BitBtn2.Enabled:=True;
BitBtn3.Enabled:=True;
BitBtn4.Enabled:=True;
btnSpeed1.Enabled:=True;
btnSpeed2.Enabled:=True;
btnSpeed3.Enabled:=True;
btnSpeed4.Enabled:=True;
end;

procedure Tpop_scope.SpinEdit1Change(Sender: TObject);
var
Path:string;
begin
if SpinEdit1.Text<>'' then
   begin
   try

//   ScopeSetSpeed(SpinEdit1.Value);
   try
   if Telescope.CanSetSpeed then
      begin
      Telescope.SetSpeed(SpinEdit1.Value);
      Config.Vitesse:=SpinEdit1.Value;
      end;
   except
   TelescopeDisconnect;
   end;

   Path:=LowerCase(ExtractFilePath(Application.ExeName));
   SaveParametres(Path+'TeleAuto.ini');  //nolang

   finally
   CheckScopeComm;
   end;

   end;
end;

procedure Tpop_scope.Timer2Timer(Sender: TObject);
var
   Alpha,Delta:Double;
   OK:Boolean;
begin
Inc(NbImpulsionsCourantes);
if NbImpulsionsCourantes>NbImpulsions then
   begin
   try
   OK:=Telescope.Quit;
   OK:=Telescope.StopMotion('N');
   OK:=Telescope.StopMotion('S');
   OK:=Telescope.StopMotion('E');
   OK:=Telescope.StopMotion('W');
   if not OK then
      begin
      WriteSpy('Panique ! Le télescope refuse de s''arrêter');
      pop_Main.AfficheMessage(lang('Erreur'),
         'Panique ! Le télescope refuse de s''arrêter');
      end;

   if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
   
   finally
   Timer2.Enabled:=False;
   CheckScopeComm;
   BitBtn1.Enabled:=True;
   BitBtn2.Enabled:=True;
   BitBtn3.Enabled:=True;
   BitBtn4.Enabled:=True;
   EnablePadButtons;
   end;
   end;
end;

procedure Tpop_scope.BitBtn5Click(Sender: TObject);
var
   Alpha,Delta:Double;
   NotError:Boolean;
begin
try

Telescope.Quit;
NotError:=Telescope.StopMotion('N');
NotError:=Telescope.StopMotion('S');
NotError:=Telescope.StopMotion('E');
NotError:=Telescope.StopMotion('W');
if not NotError then
   begin
   WriteSpy('Panique ! Le télescope refuse de s''arrêter');
   pop_Main.AfficheMessage(lang('Erreur'),
      'Panique ! Le télescope refuse de s''arrêter');
   end;

if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
   
finally
Timer2.Enabled:=False;
CheckScopeComm;
BitBtn1.Enabled:=True;
BitBtn2.Enabled:=True;
BitBtn3.Enabled:=True;
BitBtn4.Enabled:=True;
EnablePadButtons;
end;
end;

procedure Tpop_scope.FormCreate(Sender: TObject);
var t:double;
begin
Mask_Alpha.EditMask:='!90'+Config.SeparateurHeuresMinutesAlpha+'00'+Config.SeparateurMinutesSecondesAlpha+'00'+ //nolang
   Config.UnitesSecondesAlpha+';1;_'; //nolang
Mask_Delta.EditMask:='!#90'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
   Config.UnitesSecondesDelta+';1;_'; //nolang
end;

procedure Tpop_scope.FormHide(Sender: TObject);
begin
pop_main.ToolButton4.Down:=False;
end;

procedure Tpop_scope.Button4Click(Sender: TObject);
var
  pop_calib_modele:Tpop_calib_modele;
begin
  pop_calib_modele:=Tpop_calib_modele.Create(Application);
  pop_calib_modele.Show;
end;

procedure Tpop_scope.Button5Click(Sender: TObject);
var
   pop_anal_modele: Tpop_anal_modele;
begin
   pop_anal_modele:=Tpop_anal_modele.Create(Application);
   pop_anal_modele.ShowModal;
end;

procedure Tpop_scope.CheckBox2Click(Sender: TObject);
var
   Path:string;
begin
Config.UseModelePointage:=CheckBox2.Checked;
Path:=ExtractFilePath(Application.Exename);
SaveParametres(Path+'TeleAuto.ini'); //nolang
end;

// recentrage
procedure tpop_scope.CalibrerRecentrage(TempsDePose:Double);
var
x,y,xx,yy:Integer;
ValMax:Double;
PSF:TPSF;
Error,NoCamera:Word;
TimeInit:TDateTime;
Erreur:Boolean;
OldUseTrackSt7,OldUseMainCCD:Boolean;
DelaiAttente,Angle,Valeur:Double;
ImgDoubleNil:PTabImgDouble;
JeuDelta,DimTest,XPixelSize,YPixelSize:Double;
JeuDeltaOK:Boolean;
NbTryJeuDelta:Integer;
DeplacementNSMini,DeplacementEOMaxi:Double;
ModuleNord,ModuleSud,ModuleEst,ModuleOuest:Double;
Jeu,Facteur:Double;
Alpha,Alpha1,Delta1,Alpha2,Delta2:Double;
NotPerpend,TooSlowEW,TooSlowNS:Boolean;
begin
pop_dessin:=Tpop_dessin.Create(Application);
pop_dessin.SetSize(Camera.GetXSize,Camera.GetYSize);
pop_dessin.Caption:=lang('Contrôle de la calibration du recentrage');
pop_dessin.Show;


if pop_calibrate_track=nil then pop_calibrate_track:=tpop_calibrate_track.create(application);
pop_calibrate_track.Show;

Config.EtapeCalibration:=0;

// Allez, on fait avec ca pour l'instant
config.LargFenSuivi:=9;
DelaiAttente:=2;

config.CalibrateRecentrage:=False;

if pop_camera.pop_image_acq=nil then pop_camera.pop_image_acq:=tpop_image.Create(Application);
pop_camera.pop_image_acq.Bloque:=True;

try

JeuDeltaOK:=False;
NbTryJeuDelta:=1;
// On recommence tant que le jeu en Delta est mal pris en compte
// On arrete quand meme si on a recommence 3 fois car c'est qu'il y a un probleme
while not(JeuDeltaOK) and (NbTryJeuDelta<3) do
   begin
   WriteSpy(lang('Début de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Début de la calibration du recentrage'));

   // On passe le LX en vitesse de centrage
   WriteSpy(lang('Passage en vitesse de centrage'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Passage en vitesse de centrage'));

   if not Telescope.MotionRate(Telescope.GetCenterSpeedNumber) then
      begin
      WriteSpy(lang('Le télescope refuse le réglage de vitesse'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse le réglage de vitesse'));
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   Config.EtapeCalibration:=1;
   WriteSpy(lang('Recherche des coordonnées de l''étoile la plus brillante'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche des coordonnées de l''étoile la plus brillante'));
   if (Camera.GetXSize>192) or (Camera.GetYSize>164) then
      begin
      pop_camera.AcqMaximumBinning(x,y);
      if Camera.IsAValidBinning(4) then
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
   else pop_camera.AcqMaximum(x,y);

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   if (x<=config.LargFenSuivi) or (x>Camera.GetXSize-config.LargFenSuivi) or
      (y<=config.LargFenSuivi) or (y>Camera.GetYSize-config.LargFenSuivi) then
      begin
      WriteSpy(lang('Etoile de calibration trop prés du bord'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Etoile de calibration trop prés du bord'));
      StopCalibrate:=False;      
      Exit;
      end;

   WriteSpy(lang('Fenêtrage de l''étoile'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   // Aquitision en vignette
   Config.EtapeCalibration:=1;
   pop_camera.Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
      y+config.LargFenSuivi,TempsDePose,1,False);

   pop_camera.pop_image_acq.AjusteFenetre;
   pop_camera.pop_image_acq.VisuAutoEtoiles;

   GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);

   // Affichage du max pour vérifier la non saturation
   WriteSpy(lang('Intensité maximale dans l''image = ')+IntToStr(Round(ValMax)));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Intensité maximale dans l''image = ')+IntToStr(Round(ValMax)));

//   ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*config.LargFenSuivi+1,xx,yy,TGauss,
//      LowPrecision,LowSelect,0,PSF);
   ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);

   if PSF.Flux=-1 then
      begin
      WriteSpy(lang('Erreur de modélisation'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
      StopCalibrate:=False;      
      Exit;
      end;

   XTrack:=x-config.LargFenSuivi+PSF.X-1;
   YTrack:=y-config.LargFenSuivi+PSF.Y-1;

   WriteSpy(lang('Coordonnées de l''étoile X=')+
      MyFloatToStr(XTrack,2)+' Y='+MyFloatToStr(YTRack,2)); //nolang
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(
      lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrack,2)+
      ' Y='+MyFloatToStr(YTrack,2)); //nolang
   pop_dessin.AddPosition('',XTrack,YTrack,8,0,8);

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
         end;
      end;

   WriteSpy(lang('Déclinaison initiale = '+MyFloatToStr(Delta1,2)));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Déclinaison initiale = '+MyFloatToStr(Delta1,2)));

   WriteSpy(lang('On demande le déplacement vers le Sud pendant '+MyFloatToStr(config.DelaiCalibrationRecentrage,2)
      +' s')); //nolang
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('On demande le déplacement vers le Sud pendant '+MyFloatToStr(config.DelaiCalibrationRecentrage,2)
      +' s')); //nolang

   if not Telescope.StartMotion('S') then
      begin
      WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse de démarrer le déplacement'));
      Exit;
      end;

   // On attends
   TimeInit:=Time;
   while Time<TimeInit+config.DelaiCalibrationRecentrage/60/60/24 do Application.ProcessMessages;

   if not Telescope.StopMotion('S') then
      begin
      WriteSpy('Panique ! Le télescope refuse de s''arrêter');
      pop_Main.AfficheMessage(lang('Erreur'),
         'Panique ! Le télescope refuse de s''arrêter');
      end;

   TimeInit:=Time;
   while Time<TimeInit+DelaiAttente/60/60/24 do Application.ProcessMessages;

   Alpha2:=0;
   Delta2:=0;
   if Telescope.StoreCoordinates then
      begin
      if Config.GoodPos then
         begin
         Alpha2:=Config.AlphaScope;
         Delta2:=Config.DeltaScope;
         end
      else
         begin
         WriteSpy(lang('Le télescope ne veut pas donner sa position'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope ne veut pas donner sa position'));
         end;
      end;

   WriteSpy(lang('Déclinaison aprés déplacement = '+MyFloatToStr(Delta2,2)));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Déclinaison aprés déplacement = '+MyFloatToStr(Delta2,2)));
   if Delta2-Delta1<0 then
      begin
      WriteSpy(lang('La déclinaison est plus petite, le télescope s''est déplacé vers le Sud'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('La déclinaison est plus petite, le télescope s''est déplacé vers le Sud'));
      end
   else
      begin
      WriteSpy(lang('La déclinaison est plus grande, le télescope s''est déplacé vers le Nord'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('La déclinaison est plus grande, le télescope s''est déplacé vers le Nord'));
      end;

   Config.EtapeCalibration:=2;
   WriteSpy(lang('Recherche de l''étoile la plus brillante'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche de l''étoile la plus brillante'));
   if (Camera.GetXSize>192) or (Camera.GetYSize>164) then
      begin
      pop_camera.AcqMaximumBinning(x,y);
      if Camera.IsAValidBinning(4) then
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
   else pop_camera.AcqMaximum(x,y);

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   if (x<=config.LargFenSuivi) or (x>Camera.GetXSize-config.LargFenSuivi) or
      (y<=config.LargFenSuivi) or (y>Camera.GetYSize-config.LargFenSuivi) then
      begin
      WriteSpy(lang('Etoile de calibration trop prés du bord'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Etoile de calibration trop prés du bord'));
      StopCalibrate:=False;
      Exit;
      end;

   WriteSpy(lang('Fenêtrage de l''étoile'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   Config.EtapeCalibration:=1;
   pop_camera.Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
      y+config.LargFenSuivi,TempsDePose,1,False);

   pop_camera.pop_image_acq.AjusteFenetre;      
   pop_camera.pop_image_acq.VisuAutoEtoiles;

   GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      2*config.LargFenSuivi+1,2*config.LargFenSuivi+1,xx,yy,ValMax);

//   ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*config.LargFenSuivi+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
   ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);


   if PSF.Flux=-1 then
      begin
      WriteSpy(lang('Erreur de modélisation'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
      StopCalibrate:=False;
      Exit;
      end;

   XTrackXMoins:=x-config.LargFenSuivi+PSF.X-1;
   YTrackXMoins:=y-config.LargFenSuivi+PSF.Y-1;

   WriteSpy(lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrackXMoins,2)+
      ' Y='+MyFloatToStr(YTrackXMoins,2)); //nolang
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(
      lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrackXMoins,2)+
      ' Y='+MyFloatToStr(YTrackXMoins,2)); //nolang
   if Delta2-Delta1<0 then
      pop_dessin.AddPosition('S',XTrackXMoins,YTrackXMoins,8,8,4)
   else
      pop_dessin.AddPosition('N',XTrackXMoins,YTrackXMoins,8,8,4);

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   config.VecteurSudXRecentrage:=(XTrackXMoins-XTrack)*Camera.GetXPixelSize;
   config.VecteurSudYRecentrage:=(YTrackXMoins-YTrack)*Camera.GetYPixelSize;

   WriteSpy(lang('SudX = ')+FloatToStrF(config.VecteurSudXRecentrage,ffFixed,4,2)
      +' microns'); //nolang
   WriteSpy(lang('SudY = ')+FloatToStrF(config.VecteurSudYRecentrage,ffFixed,4,2)
      +' microns'); //nolang
   if Assigned(pop_calibrate_track) then
      begin
      pop_calibrate_track.AddMessage(lang('SudX = ')+FloatToStrF(config.VecteurSudXRecentrage,ffFixed,4,2)
         +' microns'); //nolang
      pop_calibrate_track.AddMessage(lang('SudY = ')+FloatToStrF(config.VecteurSudYRecentrage,ffFixed,4,2)
         +' microns'); //nolang
      end;

   // Et ici
   WriteSpy(lang('On demande le déplacement vers le Nord pendant '+MyFloatToStr(config.DelaiCalibrationRecentrage,2)
     +' s')); //nolang
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('On demande le déplacement vers le Nord pendant '+MyFloatToStr(config.DelaiCalibrationRecentrage,2)
     +' s')); //nolang
   Update;

   if not Telescope.StartMotion('N') then
      begin
      WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse de démarrer le déplacement'));
      Exit;
      end;

   // On attends
   TimeInit:=Time;
   while Time<TimeInit+config.DelaiCalibrationRecentrage/60/60/24 do Application.ProcessMessages;

   if not Telescope.StopMotion('N') then
      begin
      WriteSpy('Panique ! Le télescope refuse de s''arrêter');
      pop_Main.AfficheMessage(lang('Erreur'),
         'Panique ! Le télescope refuse de s''arrêter');
      end;

   TimeInit:=Time;
   while Time<TimeInit+DelaiAttente/60/60/24 do Application.ProcessMessages;

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   Config.EtapeCalibration:=1;
   WriteSpy(lang('Recherche de l''étoile la plus brillante'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche de l''étoile la plus brillante'));
   if (Camera.GetXSize>192) or (Camera.GetYSize>164) then
      begin
      pop_camera.AcqMaximumBinning(x,y);
      if Camera.IsAValidBinning(4) then
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
   else pop_camera.AcqMaximum(x,y);

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   if (x<=config.LargFenSuivi) or (x>Camera.GetXSize-config.LargFenSuivi) or
      (y<=config.LargFenSuivi) or (y>Camera.GetYSize-config.LargFenSuivi) then
      begin
      WriteSpy(lang('étoile de calibration trop prés du bord'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('étoile de calibration trop prés du bord'));
      StopCalibrate:=False;
      Exit;
      end;

   WriteSpy(lang('Fenêtrage de l''étoile'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   Config.EtapeCalibration:=1;
   pop_camera.Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,y+config.LargFenSuivi,
      TempsDePose,1,False);

   pop_camera.pop_image_acq.AjusteFenetre;      
   pop_camera.pop_image_acq.VisuAutoEtoiles;

   GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      2*config.LargFenSuivi+1,2*config.LargFenSuivi+1,xx,yy,ValMax);

//   ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*config.LargFenSuivi+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
   ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);


   if PSF.Flux=-1 then
      begin
      WriteSpy(lang('Erreur de modélisation'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
      StopCalibrate:=False;
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

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   config.VecteurNordXRecentrage:=(XTrackXPlus-XTrackXMoins)*Camera.GetXPixelSize;
   config.VecteurNordYRecentrage:=(YTrackXPlus-YTrackXMoins)*Camera.GetYPixelSize;

   JeuDelta:=Abs(Hypot(config.VecteurSudXRecentrage,config.VecteurSudYRecentrage)
      -Hypot(config.VecteurNordXRecentrage,config.VecteurNordYRecentrage));
   WriteSpy(lang('Différence de déplacement Nord/Sud =  '+MyFloatToStr(JeuDelta,2))
      +' microns'); //nolang
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Difference de deplacement Nord/Sud = '+MyFloatToStr(JeuDelta,2))
      +' microns'); //nolang
   XPixelSize:=Camera.GetXPixelSize;
   YPixelSize:=Camera.GetYPixelSize;
   if YPixelSize>XPixelSize then DimTest:=2*XPixelSize else DimTest:=2*YPixelSize;
   WriteSpy(lang('Différence maximum tolérée =  '+MyFloatToStr(DimTest,2))
      +' microns'); //nolang
   if JeuDelta>2*DimTest then
      begin
      WriteSpy(lang('Jeu mal pris en compte dans le mouvement Nord/Sud'));
      WriteSpy(lang('On relance la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Jeu mal pris en compte dans le mouvement Nord/Sud'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('On relance la calibration'));
      pop_dessin.Efface;
      end
   else
      begin
      WriteSpy(lang('Jeu bien pris en compte dans le mouvement Nord/Sud'));
      WriteSpy(lang('On continue la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Jeu bien pris en compte dans le mouvement Nord/Sud'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('On continue la calibration'));
      JeuDeltaOK:=True;
      Inc(NbTryJeuDelta)
      end;
   end;

if NbTryJeuDelta=3 then
   begin
   WriteSpy(lang('Attention ! Le jeu mal est pris en compte dans le mouvement Nord/Sud'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Attention ! Le jeu est mal pris en compte dans le mouvement Nord/Sud'));
   end;

WriteSpy(lang('NordX = ')+FloatToStrF(config.VecteurNordXRecentrage,ffFixed,4,2)
   +' microns'); //nolang
WriteSpy(lang('NordY = ')+FloatToStrF(config.VecteurNordYRecentrage,ffFixed,4,2)
   +' microns'); //nolang
if Assigned(pop_calibrate_track) then
   begin
   pop_calibrate_track.AddMessage(lang('NordX = ')+FloatToStrF(config.VecteurNordXRecentrage,ffFixed,4,2)
      +' microns'); //nolang
   pop_calibrate_track.AddMessage(lang('NordY = ')+FloatToStrF(config.VecteurNordYRecentrage,ffFixed,4,2)
      +' microns'); //nolang
   end;

WriteSpy(lang('On demande le déplacement vers l''Est pendant '+MyFloatToStr(config.DelaiCalibrationRecentrage,2)
   +' s')); //nolang
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('On demande le déplacement vers l''Est pendant '+MyFloatToStr(config.DelaiCalibrationRecentrage,2)
   +' s')); //nolang

if not Telescope.StartMotion('E') then
   begin
   WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope refuse de démarrer le déplacement'));
   Exit;
   end;


TimeInit:=Time;
while Time<TimeInit+config.DelaiCalibrationRecentrage/60/60/24 do Application.ProcessMessages;

if not Telescope.StopMotion('E') then
   begin
   WriteSpy('Panique ! Le télescope refuse de s''arrêter');
   pop_Main.AfficheMessage(lang('Erreur'),
      'Panique ! Le télescope refuse de s''arrêter');
   end;

TimeInit:=Time;
while Time<TimeInit+DelaiAttente/60/60/24 do Application.ProcessMessages;

Config.EtapeCalibration:=3;
WriteSpy(lang('Recherche de l''étoile la plus brillante'));
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche de l''étoile la plus brillante'));
if (Camera.GetXSize>192) or (Camera.GetYSize>164) then
   begin
   pop_camera.AcqMaximumBinning(x,y);
   if Camera.IsAValidBinning(4) then
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
else pop_camera.AcqMaximum(x,y);

if StopCalibrate then
   begin
   StopCalibrate:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Exit;
   end;

if (x<=config.LargFenSuivi) or (x>Camera.GetXSize-config.LargFenSuivi) or
   (y<=config.LargFenSuivi) or (y>Camera.GetYSize-config.LargFenSuivi) then
   begin
   WriteSpy(lang('Etoile de calibration trop prés du bord'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Etoile de calibration trop prés du bord'));
   StopCalibrate:=False;   
   Exit;
   end;

WriteSpy(lang('Fenêtrage de l''étoile'));
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

if StopCalibrate then
   begin
   StopCalibrate:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Exit;
   end;

Config.EtapeCalibration:=1;
pop_camera.Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,y+config.LargFenSuivi,
   TempsDePose,1,False);

pop_camera.pop_image_acq.AjusteFenetre;   
pop_camera.pop_image_acq.VisuAutoEtoiles;

GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
   2*config.LargFenSuivi+1,2*config.LargFenSuivi+1,xx,yy,ValMax);
//ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*config.LargFenSuivi+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
   2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);

if PSF.Flux=-1 then
   begin
   WriteSpy(lang('Erreur de modélisation'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
   StopCalibrate:=False;   
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

if StopCalibrate then
   begin
   StopCalibrate:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Exit;
   end;

config.VecteurEstXRecentrage:=(XTrackYPlus-XTrackXPlus)*Camera.GetXPixelSize;
config.VecteurEstYRecentrage:=(YTrackYPlus-YTrackXPlus)*Camera.GetYPixelSize;

WriteSpy(lang('EstX = ')+FloatToStrF(config.VecteurEstXRecentrage,ffFixed,4,2)
   +' microns'); //nolang
WriteSpy(lang('EstY = ')+FloatToStrF(config.VecteurEstYRecentrage,ffFixed,4,2)
   +' microns'); //nolang
if Assigned(pop_calibrate_track) then
   begin
   pop_calibrate_track.AddMessage(lang('EstX = ')+FloatToStrF(config.VecteurEstXRecentrage,ffFixed,4,2)
      +' microns'); //nolang
   pop_calibrate_track.AddMessage(lang('EstY = ')+FloatToStrF(config.VecteurEstYRecentrage,ffFixed,4,2)
      +' microns'); //nolang
   end;

WriteSpy(lang('On demande le déplacement vers l''Ouest pendant '+MyFloatToStr(config.DelaiCalibrationRecentrage,2)
   +' s')); //nolang
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('On demande le déplacement l''Ouest pendant '+MyFloatToStr(config.DelaiCalibrationRecentrage,2)
   +' s')); //nolang

if not Telescope.StartMotion('W') then
   begin
   WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope refuse de démarrer le déplacement'));
   Exit;
   end;

// On attends
TimeInit:=Time;
while Time<TimeInit+config.DelaiCalibrationRecentrage/60/60/24 do Application.ProcessMessages;

if not Telescope.StopMotion('W') then
   begin
   WriteSpy('Panique ! Le télescope refuse de s''arrêter');
   pop_Main.AfficheMessage(lang('Erreur'),
      'Panique ! Le télescope refuse de s''arrêter');
   end;

TimeInit:=Time;
while Time<TimeInit+DelaiAttente/60/60/24 do Application.ProcessMessages;

Config.EtapeCalibration:=1;
WriteSpy(lang('Recherche de l''étoile la plus brillante'));
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche de l''étoile la plus brillante'));
if (Camera.GetXSize>192) or (Camera.GetYSize>164) then
   begin
   pop_camera.AcqMaximumBinning(x,y);
   if Camera.IsAValidBinning(4) then
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
else pop_camera.AcqMaximum(x,y);

if StopCalibrate then
   begin
   StopCalibrate:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Exit;
   end;

if (x<=config.LargFenSuivi) or (x>Camera.GetXSize-config.LargFenSuivi) or
   (y<=config.LargFenSuivi) or (y>Camera.GetYSize-config.LargFenSuivi) then
   begin
   WriteSpy(lang('Etoile de calibration trop prés du bord'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Etoile de calibration trop prés du bord'));
   StopCalibrate:=False;   
   Exit;
   end;

WriteSpy(lang('Fenêtrage de l''étoile'));
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

if StopCalibrate then
   begin
   StopCalibrate:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Exit;
   end;

Config.EtapeCalibration:=1;
pop_camera.Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,y+config.LargFenSuivi,
   TempsDePose,1,False);

pop_camera.pop_image_acq.AjusteFenetre;
pop_camera.pop_image_acq.VisuAutoEtoiles;

GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
   2*config.LargFenSuivi+1,2*config.LargFenSuivi+1,xx,yy,ValMax);
//ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*config.LargFenSuivi+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
  2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);

if PSF.Flux=-1 then
   begin
   WriteSpy(lang('Erreur de modélisation'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
   StopCalibrate:=False;
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

if StopCalibrate then
   begin
   StopCalibrate:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Exit;
   end;

config.VecteurOuestXRecentrage:=(XTrackYMoins-XTrackYPlus)*Camera.GetXPixelSize;
config.VecteurOuestYRecentrage:=(YTrackYMoins-YTrackYPlus)*Camera.GetYPixelSize;

WriteSpy(lang('OuestX = ')+FloatToStrF(config.VecteurOuestXRecentrage,ffFixed,4,2)
   +' microns'); //nolang
WriteSpy(lang('OuestY = ')+FloatToStrF(config.VecteurOuestYRecentrage,ffFixed,4,2)
   +' microns'); //nolang
if Assigned(pop_calibrate_track) then
   begin
   pop_calibrate_track.AddMessage(lang('OuestX = ')+FloatToStrF(config.VecteurOuestXRecentrage,ffFixed,4,2)
      +' microns'); //nolang
   pop_calibrate_track.AddMessage(lang('OuestY = ')+FloatToStrF(config.VecteurOuestYRecentrage,ffFixed,4,2)
      +' microns'); //nolang
   end;

// Test de la calibration
Erreur:=False;
TooSlowNS:=False;
TooSlowEW:=False;
if Hypot(config.VecteurNordXRecentrage,config.VecteurNordYRecentrage)<10 then
   begin
   WriteSpy(lang('Vecteur Nord trop court (<10), augmentez le temps de calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Vecteur Nord trop court (<10), augmentez le temps de calibration'));
   Erreur:=True;
   TooSlowNS:=True;
   end;
if Hypot(config.VecteurSudXRecentrage,config.VecteurSudYRecentrage)<10 then
   begin
   WriteSpy(lang('Vecteur Sud trop court (<10), augmentez le temps de calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Vecteur Sud trop court (<10), augmentez le temps de calibration'));
   Erreur:=True;
   TooSlowNS:=True;
   end;
if Hypot(config.VecteurEstXRecentrage,config.VecteurEstYRecentrage)<1 then
   begin
   WriteSpy(lang('Vecteur Est trop court (<10), augmentez le temps de calibration ou diminuez la déclinaison'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Vecteur Est trop court (<10), augmentez le temps de calibration ou diminuez la déclinaison'));
   Erreur:=True;
   TooSlowEW:=True;
   end;
if Hypot(config.VecteurOuestXRecentrage,config.VecteurOuestYRecentrage)<10 then
   begin
   WriteSpy(lang('Vecteur Ouest trop court (<10), augmentez le temps de calibration ou diminuez la déclinaison'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Vecteur Ouest trop court (<10), augmentez le temps de calibration ou diminuez la déclinaison'));
   Erreur:=True;
   TooSlowEW:=True;
   end;

NotPerpend:=False;
Angle:=ArcCos((config.VecteurNordXRecentrage*Config.VecteurOuestXRecentrage+config.VecteurNordYRecentrage*Config.VecteurOuestYRecentrage)/
       Hypot(config.VecteurNordXRecentrage,config.VecteurNordYRecentrage)/Hypot(config.VecteurOuestXRecentrage,config.VecteurOuestYRecentrage))*180/pi;
if Abs(90-Angle)>10 then
   begin
   WriteSpy(lang('Vecteurs Nord et Ouest non perpendiculaires (DAngle>10°)'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Vecteurs Nord et Ouest non perpendiculaires (DAngle>10°)'));
   Erreur:=True;
   NotPerpend:=True;
   end;
Angle:=ArcCos((config.VecteurOuestXRecentrage*Config.VecteurSudXRecentrage+config.VecteurOuestYRecentrage*Config.VecteurSudYRecentrage)/
       Hypot(config.VecteurSudXRecentrage,config.VecteurSudYRecentrage)/Hypot(config.VecteurOuestXRecentrage,config.VecteurOuestYRecentrage))*180/pi;
if Abs(90-Angle)>10 then
   begin
   WriteSpy(lang('Vecteurs Ouest et Sud non perpendiculaires (DAngle>10°)'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Vecteurs Ouest et Sud non perpendiculaires (DAngle>10°)'));
   Erreur:=True;
   NotPerpend:=True;
   end;
Angle:=ArcCos((config.VecteurSudXRecentrage*Config.VecteurEstXRecentrage+config.VecteurSudYRecentrage*Config.VecteurEstYRecentrage)/
       Hypot(config.VecteurSudXRecentrage,config.VecteurSudYRecentrage)/Hypot(config.VecteurEstXRecentrage,config.VecteurEstYRecentrage))*180/pi;
if Abs(90-Angle)>10 then
   begin
   WriteSpy(lang('Vecteurs Sud et Est non perpendiculaires (DAngle>10°)'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Vecteurs Sud et Est non perpendiculaires (DAngle>10°)'));
   Erreur:=True;
   NotPerpend:=True;
   end;
Angle:=ArcCos((config.VecteurEstXRecentrage*Config.VecteurNordXRecentrage+config.VecteurEstYRecentrage*Config.VecteurNordYRecentrage)/
       Hypot(config.VecteurNordXRecentrage,config.VecteurNordYRecentrage)/Hypot(config.VecteurEstXRecentrage,config.VecteurEstYRecentrage))*180/pi;
if Abs(90-Angle)>10 then
   begin
   WriteSpy(lang('Vecteurs Est et Nord non perpendiculaires (DAngle>10°)'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Vecteurs Est et Nord non perpendiculaires (DAngle>10°)'));
   Erreur:=True;
   NotPerpend:=True;
   end;

// Entre -180 et +180 degres
{ ArcTan2 calculates ArcTan(Y/X), and returns an angle in the correct quadrant.
  IN: |Y| < 2^64, |X| < 2^64, X <> 0   OUT: [-PI..PI] radians }
if Delta2-Delta1<0 then
   Config.OrientationCCD:=90+ArcTan2(config.VecteurNordYRecentrage,config.VecteurNordXRecentrage)*180/pi
else
   Config.OrientationCCD:=-90+ArcTan2(config.VecteurNordYRecentrage,config.VecteurNordXRecentrage)*180/pi;
if Config.OrientationCCD<=-180 then Config.OrientationCCD:=Config.OrientationCCD+360;
if Config.OrientationCCD>180 then Config.OrientationCCD:=Config.OrientationCCD-360;

// Si la camera principale est une ST7 ou une ST8 CCD Principal et que
// la camera de guidage est une STTrack, on considere que c'est la meme
// camera donc que les deux CCD sont orientes pareil
if (Config.TypeCamera=ST7) or (Config.TypeCamera=ST8) then
   if (Config.TypeCamera=STTrack) then
      Config.OrientationCCDGuidage:=Config.OrientationCCD;

//Direction du N a xx° du 1/2 axe des y dans le sens trigo.
WriteSpy(lang('La direction apparente du Nord est à '+MyFloatToStr(Config.OrientationCCD,2)
   +lang('° du 1/2 axe des y du CCD')));
WriteSpy(lang('dans le sens trigo'));
if Assigned(pop_calibrate_track) then
   begin
   pop_calibrate_track.AddMessage(lang('La direction apparente du Nord est à '+
      MyFloatToStr(Config.OrientationCCD,2)+lang('° du 1/2 axe des y du CCD')));
   pop_calibrate_track.AddMessage(lang('dans le sens trigo'));
   end;

config.CalibrateRecentrage:=True;
btn_RecenterStar.Enabled:=True;

Alpha:=0;
Config.DeltaRecentrage:=0;
if Telescope.StoreCoordinates then
   begin
   if Config.GoodPos then
      begin
      Alpha:=Config.AlphaScope;
      Config.DeltaRecentrage:=Config.DeltaScope;
      end
   else
      begin
      WriteSpy(lang('Le télescope ne veut pas donner sa position'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope ne veut pas donner sa position'));
      end;
   end;

if not Erreur then
   begin
   WriteSpy(lang('Calibration réussie'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Calibration réussie'));
   end
else
   begin
   WriteSpy(lang('Echec de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Echec de la calibration'));
   if NotPerpend then
      begin
      WriteSpy(lang('Les déplacements N/S et E/W ne sont pas orthogonaux, Changez d''étoile'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Les déplacements N/S et E/W ne sont pas orthogonaux, Changez d''étoile'));
      end;
   if TooSlowNS then
      begin
      WriteSpy(lang('Le déplacement Nord/Sud est trop petit, augmentez le temps de calibration Nord/Sud'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Le déplacement Nord/Sud est trop petit, augmentez le temps de calibration Nord/Sud'));
      end;
   if TooSlowEW then
      begin
      WriteSpy(lang('Le déplacement Est/Ouest est trop petit, augmentez le temps de calibration Est/Ouest'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Le déplacement Est/Ouest est trop petit, augmentez le temps de calibration Est/Ouest'));
      end;
   end

finally
pop_camera.pop_image_acq.Bloque:=False;
Config.EtapeCalibration:=0;
end;
end;

procedure Tpop_scope.Edit44Change(Sender: TObject);
begin
if Edit44.Text<>'' then
  config.DelaiCalibrationRecentrage:=MyStrToFloat(Edit44.Text);
end;

procedure Tpop_scope.Button6Click(Sender: TObject);
begin
CalibrerRecentrage(1);
if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
end;

procedure Tpop_scope.Recentre(XMarque,YMarque:Integer;SurMarque:Boolean);
var
xx,yy,i,ii:Integer;
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
Time1,Time2:TDateTime;
DeltaCourant:Double;
Alpha:Double;
XMes,YMes:Integer;
ErreurX,ErreurY:Double;
LocalIterRecentrage:Integer;
begin
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
      end;
   end;

config.LargFenSuivi:=9;

config.LimiteNordRecentrage :=1;
config.LimiteSudRecentrage  :=1;
config.LimiteEstRecentrage  :=1;
config.LimiteOuestRecentrage:=1;

StopGetPos:=True;  // Arrêter de demander les coordonnées du LX200

try

if pop_camera.pop_image_acq=nil then pop_camera.pop_image_acq:=tpop_image.Create(Application);
pop_camera.pop_image_acq.Bloque:=True;

WriteSpy(lang('Passage en vitesse de centrage'));

if not Telescope.MotionRate(Telescope.GetCenterSpeedNumber) then
   begin
   WriteSpy(lang('Le télescope refuse le réglage de vitesse'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope refuse le réglage de vitesse'));
   Exit;
   end;

case Telescope.GetCenterSpeedNumber of
   1:pop_scope.btnSpeed1.Down:=True;
   2:pop_scope.btnSpeed2.Down:=True;
   3:pop_scope.btnSpeed3.Down:=True;
   4:pop_scope.btnSpeed4.Down:=True;
   end;

//La cible est au milieu
config.XSuivi:=Camera.GetXSize div 2;
config.YSuivi:=Camera.GetYSize div 2;

if SurMarque then LocalIterRecentrage:=1
else LocalIterRecentrage:=Config.IterRecentrage;

for ii:=1 to LocalIterRecentrage do
   begin
   if SurMarque then
      begin
      if (Camera.GetXSize>192) or (Camera.GetYSize>164) then
         begin
         if Camera.IsAValidBinning(4) then
            begin
            xMes:=XMarque*4;
            yMes:=YMarque*4;
            end
         else
            begin
            xMes:=XMarque*3;
            yMes:=YMarque*3;
            end;
         end
      else
         begin
         xMes:=XMarque;
         yMes:=YMarque;
         end;
      end
   else
      begin
      // Recherche des cooordonnees de l'etoile la plus brillante
      WriteSpy(lang('Recherche de l''étoile la plus brillante'));

      if (Camera.GetXSize>192) or (Camera.GetYSize>164) then
         begin
         pop_camera.AcqMaximumBinning(xMes,yMes);
         if Camera.IsAValidBinning(4) then
            begin
            xMes:=xMes*4;
            yMes:=yMes*4;
            end
         else
            begin
            xMes:=xMes*3;
            yMes:=yMes*3;
            end;
         end
      else pop_camera.AcqMaximum(xMes,yMes);
      end;

   WriteSpy(lang('Coordonnées actuelles x = ')+FloatToStrF(XMes,ffFixed,4,2)
     +' / y = '+FloatToStrF(YMes,ffFixed,4,2)); //nolang
   // On affiche l'erreur de guidage
   ErreurX:=XMes-config.XSuivi;
   ErreurY:=YMes-config.YSuivi;
   // On envoie le message si c'est good
   WriteSpy(lang('Erreur de recentrage x = ')+FloatToStrF(ErreurX,ffFixed,4,2)
     +' / y = '+FloatToStrF(ErreurY,ffFixed,4,2)); //nolang

   // Phase de deplacement
   DeltaX:=(config.XSuivi-XMes)*Camera.GetXPixelSize;
   DeltaY:=(config.YSuivi-YMes)*Camera.GetYPixelSize;

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
      DeplacementNord:=(DeltaX*config.VecteurNordXRecentrage+DeltaY*config.VecteurNordYRecentrage)/
         Hypot(config.VecteurNordXRecentrage,config.VecteurNordYRecentrage);
      DeplacementSud:=(DeltaX*config.VecteurSudXRecentrage+DeltaY*config.VecteurSudYRecentrage)/
         Hypot(config.VecteurSudXRecentrage,config.VecteurSudYRecentrage);
      DeplacementEst:=(DeltaX*config.VecteurEstXRecentrage+DeltaY*config.VecteurEstYRecentrage)/
         Hypot(config.VecteurEstXRecentrage,config.VecteurEstYRecentrage);
      DeplacementOuest:=(DeltaX*config.VecteurOuestXRecentrage+DeltaY*config.VecteurOuestYRecentrage)/
         Hypot(config.VecteurOuestXRecentrage,config.VecteurOuestYRecentrage);

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
         WriteSpy(lang('Déplacement vers le Ouest / Distance = ')+MyFloatToStr(DeplacementOuest,2)
            +' microns'); //nolang

      // On se deplace
      if DeplacementNord>0 then
         begin
         TimeMove:=DeplacementNord*config.DelaiCalibrationRecentrage/
         Hypot(config.VecteurNordXRecentrage,config.VecteurNordYRecentrage)*config.LimiteNordRecentrage;
         WriteSpy(lang('Déplacement vers le Nord / Durée = ')
            +FloatToStrF(TimeMove,ffFixed,4,2)+' s'); //nolang

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
         TimeMove:=DeplacementSud*config.DelaiCalibrationRecentrage/
         Hypot(config.VecteurSudXRecentrage,config.VecteurSudYRecentrage)*config.LimiteSudRecentrage;
         WriteSpy(lang('Déplacement vers le Sud / Durée = ')
            +FloatToStrF(TimeMove,ffFixed,4,2)+' s'); //nolang

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
         TimeMove:=DeplacementEst*config.DelaiCalibrationRecentrage/
            Hypot(config.VecteurEstXRecentrage,config.VecteurEstYRecentrage)*config.LimiteEstRecentrage*Cos(Config.DeltaRecentrage/180*pi)/Cos(DeltaCourant/180*pi);
         WriteSpy(lang('Déplacement vers l''Est / Durée = ')
            +FloatToStrF(TimeMove,ffFixed,4,2)+' s'); //nolang

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
         TimeMove:=DeplacementOuest*config.DelaiCalibrationRecentrage/
            Hypot(config.VecteurOuestXRecentrage,config.VecteurOuestYRecentrage)*config.LimiteOuestRecentrage*Cos(Config.DeltaRecentrage/180*pi)/Cos(DeltaCourant/180*pi);
         WriteSpy(lang('Déplacement vers l''Ouest / Durée = ')
            +FloatToStrF(TimeMove,ffFixed,4,2)+' s'); //nolang

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

// Derniere image
if (Camera.GetXSize>192) or (Camera.GetYSize>164) then
   begin
   pop_camera.AcqMaximumBinning(xMes,yMes);
   if Camera.IsAValidBinning(4) then
      begin
      xMes:=xMes*4;
      yMes:=yMes*4;
      end
   else
      begin
      xMes:=xMes*3;
      yMes:=yMes*3;
      end;
   end
else pop_camera.AcqMaximum(xMes,yMes);

WriteSpy(lang('Arrêt du recentrage'));

finally
StopGetPos:=False;
if pop_camera.pop_image_acq<>nil then pop_camera.pop_image_acq.Bloque:=False;
end;
end;

procedure Tpop_scope.SpinEdit2Change(Sender: TObject);
begin
if SpinEdit2.Text<>'' then
   Config.IterRecentrage:=StrToInt(SpinEdit2.Text);
end;

procedure Tpop_scope.RecentreGuidage(XMarque,YMarque:Integer;SurMarque:Boolean);
var
xx,yy,i,ii:Integer;
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
Time1,Time2:TDateTime;
DeltaCourant:Double;
Alpha:Double;
XMes,YMes:Integer;
ErreurX,ErreurY:Double;
LocalIterRecentrage:Integer;
begin
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
      end;
   end;

config.LargFenSuivi:=9;

config.LimiteNordRecentrage :=1;
config.LimiteSudRecentrage  :=1;
config.LimiteEstRecentrage  :=1;
config.LimiteOuestRecentrage:=1;

StopGetPos:=True;  // Arrêter de demander les coordonnées du LX200

// Acquisition du noir en binning
if not pop_camera_suivi.NoirBinningAcquis then
   begin
   if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
      begin
      WriteSpy(lang('Acquisition du noir en binning'));
      if CameraSuivi.IsAValidBinning(4) then pop_camera_suivi.AcqNoirBinning(4) else pop_camera_suivi.AcqNoirBinning(3);
      pop_camera_suivi.NoirBinningAcquis:=True;
      end;
   end;

// Acquisition du noir sans binning
if not pop_camera_suivi.NoirAcquis then
   begin
   WriteSpy(lang('Acquisition du noir'));
   pop_camera_suivi.AcqNoir;
   pop_camera_suivi.NoirAcquis:=True;
   end;

try

WriteSpy(lang('Passage en vitesse de centrage'));

if not Telescope.MotionRate(Telescope.GetCenterSpeedNumber) then
   begin
   WriteSpy(lang('Le télescope refuse le réglage de vitesse'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope refuse le réglage de vitesse'));
   Exit;
   end;

case Telescope.GetCenterSpeedNumber of
   1:pop_scope.btnSpeed1.Down:=True;
   2:pop_scope.btnSpeed2.Down:=True;
   3:pop_scope.btnSpeed3.Down:=True;
   4:pop_scope.btnSpeed4.Down:=True;
   end;

//La cible est au milieu
config.XSuivi:=CameraSuivi.GetXSize div 2;
config.YSuivi:=CameraSuivi.GetYSize div 2;

if SurMarque then LocalIterRecentrage:=1
else LocalIterRecentrage:=Config.IterRecentrage;

for ii:=1 to LocalIterRecentrage do
   begin
   if SurMarque then
      begin
      if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
         begin
         if CameraSuivi.IsAValidBinning(4) then
            begin
            xMes:=XMarque*4;
            yMes:=YMarque*4;
            end
         else
            begin
            xMes:=XMarque*3;
            yMes:=YMarque*3;
            end;
         end
      else
         begin
         xMes:=XMarque;
         yMes:=YMarque;
         end;
      end
   else
      begin
      // Recherche des cooordonnees de l'etoile la plus brillante
      WriteSpy(lang('Recherche de l''étoile la plus brillante'));

      if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
         begin
         pop_camera_suivi.AcqMaximumBinning(xMes,yMes);
         if CameraSuivi.IsAValidBinning(4) then
            begin
            xMes:=xMes*4;
            yMes:=yMes*4;
            end
         else
            begin
            xMes:=xMes*3;
            yMes:=yMes*3;
            end;
         end
      else pop_camera_suivi.AcqMaximum(xMes,yMes);
      end;

   WriteSpy(lang('Coordonnées actuelles x = ')+FloatToStrF(XMes,ffFixed,4,2)
     +' / y = '+FloatToStrF(YMes,ffFixed,4,2)); //nolang
   // On affiche l'erreur de guidage
   ErreurX:=XMes-config.XSuivi;
   ErreurY:=YMes-config.YSuivi;
   // On envoie le message si c'est good
   WriteSpy(lang('Erreur de recentrage x = ')+FloatToStrF(ErreurX,ffFixed,4,2)
     +' / y = '+FloatToStrF(ErreurY,ffFixed,4,2)); //nolang

   // Phase de deplacement
   DeltaX:=(config.XSuivi-XMes)*CameraSuivi.GetXPixelSize;
   DeltaY:=(config.YSuivi-YMes)*CameraSuivi.GetYPixelSize;

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
      DeplacementNord:=(DeltaX*config.VecteurNordXRecentrageSuivi+DeltaY*config.VecteurNordYRecentrageSuivi)/
         Hypot(config.VecteurNordXRecentrageSuivi,config.VecteurNordYRecentrageSuivi);
      DeplacementSud:=(DeltaX*config.VecteurSudXRecentrageSuivi+DeltaY*config.VecteurSudYRecentrageSuivi)/
         Hypot(config.VecteurSudXRecentrageSuivi,config.VecteurSudYRecentrageSuivi);
      DeplacementEst:=(DeltaX*config.VecteurEstXRecentrageSuivi+DeltaY*config.VecteurEstYRecentrageSuivi)/
         Hypot(config.VecteurEstXRecentrageSuivi,config.VecteurEstYRecentrageSuivi);
      DeplacementOuest:=(DeltaX*config.VecteurOuestXRecentrageSuivi+DeltaY*config.VecteurOuestYRecentrageSuivi)/
         Hypot(config.VecteurOuestXRecentrageSuivi,config.VecteurOuestYRecentrageSuivi);

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
         WriteSpy(lang('Déplacement vers le Ouest / Distance = ')+MyFloatToStr(DeplacementOuest,2)
            +' microns'); //nolang

      // On se deplace
      if DeplacementNord>0 then
         begin
         TimeMove:=DeplacementNord*config.DelaiCalibrationRecentrage/
         Hypot(config.VecteurNordXRecentrageSuivi,config.VecteurNordYRecentrageSuivi)*config.LimiteNordRecentrage;
         WriteSpy(lang('Déplacement vers le Nord / Durée = ')
            +FloatToStrF(TimeMove,ffFixed,4,2)+' s'); //nolang

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
         TimeMove:=DeplacementSud*config.DelaiCalibrationRecentrage/
         Hypot(config.VecteurSudXRecentrageSuivi,config.VecteurSudYRecentrageSuivi)*config.LimiteSudRecentrage;
         WriteSpy(lang('Déplacement vers le Sud / Durée = ')
            +FloatToStrF(TimeMove,ffFixed,4,2)+' s'); //nolang

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
         TimeMove:=DeplacementEst*config.DelaiCalibrationRecentrage/
            Hypot(config.VecteurEstXRecentrageSuivi,config.VecteurEstYRecentrageSuivi)*config.LimiteEstRecentrage*Cos(Config.DeltaRecentrageSuivi/180*pi)/Cos(DeltaCourant/180*pi);
         WriteSpy(lang('Déplacement vers l''Est / Durée = ')
            +FloatToStrF(TimeMove,ffFixed,4,2)+' s'); //nolang

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
         TimeMove:=DeplacementOuest*config.DelaiCalibrationRecentrage/
            Hypot(config.VecteurOuestXRecentrageSuivi,config.VecteurOuestYRecentrageSuivi)*config.LimiteOuestRecentrage*Cos(Config.DeltaRecentrageSuivi/180*pi)/Cos(DeltaCourant/180*pi);
         WriteSpy(lang('Déplacement vers l''Ouest / Durée = ')
            +FloatToStrF(TimeMove,ffFixed,4,2)+' s'); //nolang

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

// Derniere image
if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
   begin
   pop_camera_suivi.AcqMaximumBinning(xMes,yMes);
   if CameraSuivi.IsAValidBinning(4) then
      begin
      xMes:=xMes*4;
      yMes:=yMes*4;
      end
   else
      begin
      xMes:=xMes*3;
      yMes:=yMes*3;
      end;
   end
else pop_camera_suivi.AcqMaximum(xMes,yMes);

WriteSpy(lang('Arrêt du recentrage'));

finally
StopGetPos:=False;
if pop_camera_suivi.pop_image_acq<>nil then pop_camera_suivi.pop_image_acq.Bloque:=False;
end;
end;

procedure Tpop_scope.Button7Click(Sender: TObject);
begin
DesableButtons;
btn_RecenterStar.Enabled:=False;
Button7.Enabled:=False;

if pop_camera_suivi.pop_image_acq=nil then pop_camera_suivi.pop_image_acq:=tpop_image.Create(Application);
pop_camera_suivi.pop_image_acq.Bloque:=True;

try
if CheckBox3.Checked then
   begin
   if pop_camera_suivi.Pop_image_acq.AjouterMarque1.Checked then
      RecentreGuidage(pop_camera_suivi.Pop_image_acq.XMarque,pop_camera_suivi.Pop_image_acq.YMarque,True)
   else ShowMessage('Pas de marque dans l''image');
   end
else
   RecentreGuidage(0,0,False);

if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
   
finally
CheckScopeComm;
btn_RecenterStar.Enabled:=True;
Button7.Enabled:=True;
EnableButtons;
end;
end;

// recentrage sur capteur de guidage
procedure tpop_scope.CalibrerRecentrageGuidage(TempsDePose:Double);
var
x,y,xx,yy:Integer;
ValMax:Double;
PSF:TPSF;
Error,NoCamera:Word;
TimeInit:TDateTime;
Erreur:Boolean;
OldUseTrackSt7,OldUseMainCCD:Boolean;
DelaiAttente,Angle,Valeur:Double;
ImgDoubleNil:PTabImgDouble;
JeuDelta,DimTest,XPixelSize,YPixelSize:Double;
JeuDeltaOK:Boolean;
NbTryJeuDelta:Integer;
DeplacementNSMini,DeplacementEOMaxi:Double;
ModuleNord,ModuleSud,ModuleEst,ModuleOuest:Double;
Jeu,Facteur:Double;
Alpha,Alpha1,Delta1,Alpha2,Delta2:Double;
NotPerpend,TooSlowEW,TooSlowNS:Boolean;
begin
pop_dessin:=Tpop_dessin.Create(Application);
pop_dessin.SetSize(CameraSuivi.GetXSize,CameraSuivi.GetYSize);
pop_dessin.Caption:=lang('Contrôle de la calibration du recentrage');
pop_dessin.Show;


if pop_calibrate_track=nil then pop_calibrate_track:=tpop_calibrate_track.create(application);
pop_calibrate_track.Show;

Config.EtapeCalibration:=0;

// Allez, on fait avec ca pour l'instant
config.LargFenSuivi:=9;
DelaiAttente:=2;

config.CalibrateRecentrageSuivi:=False;

if pop_camera_suivi.pop_image_acq=nil then pop_camera_suivi.pop_image_acq:=tpop_image.Create(Application);
pop_camera_suivi.pop_image_acq.Bloque:=True;

try

JeuDeltaOK:=False;
NbTryJeuDelta:=1;
// On recommence tant que le jeu en Delta est mal pris en compte
// On arrete quand meme si on a recommence 3 fois car c'est qu'il y a un probleme
while not(JeuDeltaOK) and (NbTryJeuDelta<3) do
   begin
   WriteSpy(lang('Début de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Début de la calibration du recentrage'));

   // On passe le LX en vitesse de centrage
   WriteSpy(lang('Passage en vitesse de centrage'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Passage en vitesse de centrage'));

   if not Telescope.MotionRate(Telescope.GetCenterSpeedNumber) then
      begin
      WriteSpy(lang('Le télescope refuse le réglage de vitesse'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse le réglage de vitesse'));
      pop_camera_suivi.pop_image_acq.Bloque:=False;
      Exit;
      end;

   // Acquisition du noir en binning
   if not pop_camera_suivi.NoirBinningAcquis then
      begin
      if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
         begin
         WriteSpy(lang('Acquisition du noir en binning'));
         if CameraSuivi.IsAValidBinning(4) then pop_camera_suivi.AcqNoirBinning(4) else pop_camera_suivi.AcqNoirBinning(3);
         pop_camera_suivi.NoirBinningAcquis:=True;
         end;
      end;

   // Acquisition du noir sans binning
   if not pop_camera_suivi.NoirAcquis then
      begin
      WriteSpy(lang('Acquisition du noir'));
      pop_camera_suivi.AcqNoir;
      pop_camera_suivi.NoirAcquis:=True;
      end;

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   Config.EtapeCalibration:=1;
   WriteSpy(lang('Recherche des coordonnées de l''étoile la plus brillante'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche des coordonnées de l''étoile la plus brillante'));
   if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
      begin
      pop_camera_suivi.AcqMaximumBinning(x,y);
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
   else pop_camera_suivi.AcqMaximum(x,y);

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   if (x<=config.LargFenSuivi) or (x>CameraSuivi.GetXSize-config.LargFenSuivi) or
      (y<=config.LargFenSuivi) or (y>CameraSuivi.GetYSize-config.LargFenSuivi) then
      begin
      WriteSpy(lang('Etoile de calibration trop prés du bord'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Etoile de calibration trop prés du bord'));
      StopCalibrate:=False;      
      Exit;
      end;

   WriteSpy(lang('Fenêtrage de l''étoile'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   // Aquitision en vignette
   Config.EtapeCalibration:=1;
   pop_camera_suivi.Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
      y+config.LargFenSuivi,TempsDePose,1,False,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos);

   GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);

   //Soustraction du noir
   if pop_camera_suivi.NoirAcquis then
      begin
      GetImgPart(pop_camera_suivi.MemPicTrackNoir,ImgDoubleNil,pop_camera_suivi.VignetteNoir,ImgDoubleNil,2,1,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
         pop_camera_suivi.pop_image_acq.ImgInfos.Sy,x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
         y+config.LargFenSuivi);
      Soust(pop_camera_suivi.pop_image_acq.DataInt,pop_camera_suivi.VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
         pop_camera_suivi.pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy);
      FreememImg(pop_camera_suivi.VignetteNoir,ImgDoubleNil,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,2,1);
      end;

   pop_camera_suivi.pop_image_acq.AjusteFenetre;
   pop_camera_suivi.pop_image_acq.VisuAutoEtoiles;

   // Affichage du max pour vérifier la non saturation
   WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
   if Assigned(pop_track) then pop_track.AddMessage(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));

//   ModeliseEtoile(pop_camera_suivi.pop_image_acq.DataInt,nil,2,2*config.LargFenSuivi+1,xx,yy,TGauss,
//      LowPrecision,LowSelect,0,PSF);
   ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);

   if PSF.Flux=-1 then
      begin
      WriteSpy(lang('Erreur de modélisation'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
      StopCalibrate:=False;
      Exit;
      end;

   XTrack:=x-config.LargFenSuivi+PSF.X-1;
   YTrack:=y-config.LargFenSuivi+PSF.Y-1;

   WriteSpy(lang('Coordonnées de l''étoile X=')+
      MyFloatToStr(XTrack,2)+' Y='+MyFloatToStr(YTRack,2)); //nolang
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(
      lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrack,2)+
      ' Y='+MyFloatToStr(YTrack,2)); //nolang
   pop_dessin.AddPosition('',XTrack,YTrack,8,0,8);

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
         end;
      end;

   WriteSpy(lang('Déclinaison initiale = '+MyFloatToStr(Delta1,2)));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Déclinaison initiale = '+MyFloatToStr(Delta1,2)));

   WriteSpy(lang('On demande le déplacement vers le Sud pendant '+MyFloatToStr(config.DelaiCalibrationRecentrage,2)
      +' s')); //nolang
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('On demande le déplacement vers le Sud pendant '+MyFloatToStr(config.DelaiCalibrationRecentrage,2)
      +' s')); //nolang

   if not Telescope.StartMotion('S') then
      begin
      WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse de démarrer le déplacement'));
      Exit;
      end;

   // On attends
   TimeInit:=Time;
   while Time<TimeInit+config.DelaiCalibrationRecentrage/60/60/24 do Application.ProcessMessages;

   if not Telescope.StopMotion('S') then
      begin
      WriteSpy('Panique ! Le télescope refuse de s''arrêter');
      pop_Main.AfficheMessage(lang('Erreur'),
         'Panique ! Le télescope refuse de s''arrêter');
      end;

   TimeInit:=Time;
   while Time<TimeInit+DelaiAttente/60/60/24 do Application.ProcessMessages;

   Alpha2:=0;
   Delta2:=0;
   if Telescope.StoreCoordinates then
      begin
      if Config.GoodPos then
         begin
         Alpha2:=Config.AlphaScope;
         Delta2:=Config.DeltaScope;
         end
      else
         begin
         WriteSpy(lang('Le télescope ne veut pas donner sa position'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope ne veut pas donner sa position'));
         end;
      end;

   WriteSpy(lang('Déclinaison aprés déplacement = '+MyFloatToStr(Delta2,2)));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Déclinaison aprés déplacement = '+MyFloatToStr(Delta2,2)));
   if Delta2-Delta1<0 then
      begin
      WriteSpy(lang('La déclinaison est plus petite, le télescope s''est déplacé vers le Sud'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('La déclinaison est plus petite, le télescope s''est déplacé vers le Sud'));
      end
   else
      begin
      WriteSpy(lang('La déclinaison est plus grande, le télescope s''est déplacé vers le Nord'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('La déclinaison est plus grande, le télescope s''est déplacé vers le Nord'));
      end;

   Config.EtapeCalibration:=2;
   WriteSpy(lang('Recherche de l''étoile la plus brillante'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche de l''étoile la plus brillante'));
   if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
      begin
      pop_camera_suivi.AcqMaximumBinning(x,y);
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
   else pop_camera_suivi.AcqMaximum(x,y);

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   if (x<=config.LargFenSuivi) or (x>CameraSuivi.GetXSize-config.LargFenSuivi) or
      (y<=config.LargFenSuivi) or (y>CameraSuivi.GetYSize-config.LargFenSuivi) then
      begin
      WriteSpy(lang('Etoile de calibration trop prés du bord'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Etoile de calibration trop prés du bord'));
      StopCalibrate:=False;
      Exit;
      end;

   WriteSpy(lang('Fenêtrage de l''étoile'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   Config.EtapeCalibration:=1;
   pop_camera_suivi.Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
      y+config.LargFenSuivi,TempsDePose,1,False,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos);

   //Soustraction du noir
   if pop_camera_suivi.NoirAcquis then
      begin
      GetImgPart(pop_camera_suivi.MemPicTrackNoir,ImgDoubleNil,pop_camera_suivi.VignetteNoir,ImgDoubleNil,2,1,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
         pop_camera_suivi.pop_image_acq.ImgInfos.Sy,x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
         y+config.LargFenSuivi);
      Soust(pop_camera_suivi.pop_image_acq.DataInt,pop_camera_suivi.VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
         pop_camera_suivi.pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy);
      FreememImg(pop_camera_suivi.VignetteNoir,ImgDoubleNil,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,2,1);
      end;

   pop_camera_suivi.pop_image_acq.AjusteFenetre;   
   pop_camera_suivi.pop_image_acq.VisuAutoEtoiles;

   GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      2*config.LargFenSuivi+1,2*config.LargFenSuivi+1,xx,yy,ValMax);
//   ModeliseEtoile(pop_camera_suivi.pop_image_acq.DataInt,nil,2,2*config.LargFenSuivi+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
   ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);

   if PSF.Flux=-1 then
      begin
      WriteSpy(lang('Erreur de modélisation'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
      StopCalibrate:=False;
      Exit;
      end;

   XTrackXMoins:=x-config.LargFenSuivi+PSF.X-1;
   YTrackXMoins:=y-config.LargFenSuivi+PSF.Y-1;

   WriteSpy(lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrackXMoins,2)+
      ' Y='+MyFloatToStr(YTrackXMoins,2)); //nolang
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(
      lang('Coordonnées de l''étoile X=')+MyFloatToStr(XTrackXMoins,2)+
      ' Y='+MyFloatToStr(YTrackXMoins,2)); //nolang
   if Delta2-Delta1<0 then
      pop_dessin.AddPosition('S',XTrackXMoins,YTrackXMoins,8,8,4)
   else
      pop_dessin.AddPosition('N',XTrackXMoins,YTrackXMoins,8,8,4);

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   config.VecteurSudXRecentrageSuivi:=(XTrackXMoins-XTrack)*CameraSuivi.GetXPixelSize;
   config.VecteurSudYRecentrageSuivi:=(YTrackXMoins-YTrack)*CameraSuivi.GetYPixelSize;

   WriteSpy(lang('SudX = ')+FloatToStrF(config.VecteurSudXRecentrageSuivi,ffFixed,4,2)
      +' microns'); //nolang
   WriteSpy(lang('SudY = ')+FloatToStrF(config.VecteurSudYRecentrageSuivi,ffFixed,4,2)
      +' microns'); //nolang
   if Assigned(pop_calibrate_track) then
      begin
      pop_calibrate_track.AddMessage(lang('SudX = ')+FloatToStrF(config.VecteurSudXRecentrageSuivi,ffFixed,4,2)
         +' microns'); //nolang
      pop_calibrate_track.AddMessage(lang('SudY = ')+FloatToStrF(config.VecteurSudYRecentrageSuivi,ffFixed,4,2)
         +' microns'); //nolang
      end;

   // Et ici
   WriteSpy(lang('On demande le déplacement vers le Nord pendant '+MyFloatToStr(config.DelaiCalibrationRecentrage,2)
      +' s')); //nolang
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('On demande le déplacement vers le Nord pendant '+MyFloatToStr(config.DelaiCalibrationRecentrage,2)
      +' s')); //nolang
   Update;

   if not Telescope.StartMotion('N') then
      begin
      WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope refuse de démarrer le déplacement'));
      Exit;
      end;

   // On attends
   TimeInit:=Time;
   while Time<TimeInit+config.DelaiCalibrationRecentrage/60/60/24 do Application.ProcessMessages;

   if not Telescope.StopMotion('N') then
      begin
      WriteSpy('Panique ! Le télescope refuse de s''arrêter');
      pop_Main.AfficheMessage(lang('Erreur'),
         'Panique ! Le télescope refuse de s''arrêter');
      end;

   TimeInit:=Time;
   while Time<TimeInit+DelaiAttente/60/60/24 do Application.ProcessMessages;

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   Config.EtapeCalibration:=1;
   WriteSpy(lang('Recherche de l''étoile la plus brillante'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche de l''étoile la plus brillante'));
   if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
      begin
      pop_camera_suivi.AcqMaximumBinning(x,y);
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
   else pop_camera_suivi.AcqMaximum(x,y);

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   if (x<=config.LargFenSuivi) or (x>CameraSuivi.GetXSize-config.LargFenSuivi) or
      (y<=config.LargFenSuivi) or (y>CameraSuivi.GetYSize-config.LargFenSuivi) then
      begin
      WriteSpy(lang('étoile de calibration trop prés du bord'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('étoile de calibration trop prés du bord'));
      StopCalibrate:=False;
      Exit;
      end;

   WriteSpy(lang('Fenêtrage de l''étoile'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   Config.EtapeCalibration:=1;
   pop_camera_suivi.Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,y+config.LargFenSuivi,
      TempsDePose,1,False,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos);

   //Soustraction du noir
   if pop_camera_suivi.NoirAcquis then
      begin
      GetImgPart(pop_camera_suivi.MemPicTrackNoir,ImgDoubleNil,pop_camera_suivi.VignetteNoir,ImgDoubleNil,2,1,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
         pop_camera_suivi.pop_image_acq.ImgInfos.Sy,x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
         y+config.LargFenSuivi);
      Soust(pop_camera_suivi.pop_image_acq.DataInt,pop_camera_suivi.VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
         pop_camera_suivi.pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy);
      FreememImg(pop_camera_suivi.VignetteNoir,ImgDoubleNil,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,2,1);
      end;

   pop_camera_suivi.pop_image_acq.AjusteFenetre;      
   pop_camera_suivi.pop_image_acq.VisuAutoEtoiles;

   GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      2*config.LargFenSuivi+1,2*config.LargFenSuivi+1,xx,yy,ValMax);
//   ModeliseEtoile(pop_camera_suivi.pop_image_acq.DataInt,nil,2,2*config.LargFenSuivi+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
   ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);

   if PSF.Flux=-1 then
      begin
      WriteSpy(lang('Erreur de modélisation'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
      StopCalibrate:=False;
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

   if StopCalibrate then
      begin
      StopCalibrate:=False;
      WriteSpy(lang('Arrêt de la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
      Exit;
      end;

   config.VecteurNordXRecentrageSuivi:=(XTrackXPlus-XTrackXMoins)*CameraSuivi.GetXPixelSize;
   config.VecteurNordYRecentrageSuivi:=(YTrackXPlus-YTrackXMoins)*CameraSuivi.GetYPixelSize;

   JeuDelta:=Abs(Hypot(config.VecteurSudXRecentrage,config.VecteurSudYRecentrage)
      -Hypot(config.VecteurNordXRecentrage,config.VecteurNordYRecentrage));
   WriteSpy(lang('Différence de déplacement Nord/Sud =  '+MyFloatToStr(JeuDelta,2))
      +' microns'); //nolang
   if Assigned(pop_calibrate_track) then
      pop_calibrate_track.AddMessage(lang('Difference de deplacement Nord/Sud = '+MyFloatToStr(JeuDelta,2))
      +' microns'); //nolang
   XPixelSize:=CameraSuivi.GetXPixelSize;
   YPixelSize:=CameraSuivi.GetYPixelSize;
   if YPixelSize>XPixelSize then DimTest:=2*XPixelSize else DimTest:=2*YPixelSize;
   WriteSpy(lang('Différence maximum tolérée =  '+MyFloatToStr(DimTest,2))
      +' microns'); //nolang
   if JeuDelta>2*DimTest then
      begin
      WriteSpy(lang('Jeu mal pris en compte dans le mouvement Nord/Sud'));
      WriteSpy(lang('On relance la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Jeu mal pris en compte dans le mouvement Nord/Sud'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('On relance la calibration'));
      pop_dessin.Efface;
      end
   else
      begin
      WriteSpy(lang('Jeu bien pris en compte dans le mouvement Nord/Sud'));
      WriteSpy(lang('On continue la calibration'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Jeu bien pris en compte dans le mouvement Nord/Sud'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('On continue la calibration'));
      JeuDeltaOK:=True;
      Inc(NbTryJeuDelta)
      end;
   end;

if NbTryJeuDelta=3 then
   begin
   WriteSpy(lang('Attention ! Le jeu mal est pris en compte dans le mouvement Nord/Sud'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Attention ! Le jeu est mal pris en compte dans le mouvement Nord/Sud'));
   end;

WriteSpy(lang('NordX = ')+FloatToStrF(config.VecteurNordXRecentrageSuivi,ffFixed,4,2)
   +' microns'); //nolang
WriteSpy(lang('NordY = ')+FloatToStrF(config.VecteurNordYRecentrageSuivi,ffFixed,4,2)
   +' microns'); //nolang
if Assigned(pop_calibrate_track) then
   begin
   pop_calibrate_track.AddMessage(lang('NordX = ')+FloatToStrF(config.VecteurNordXRecentrageSuivi,ffFixed,4,2)
      +' microns'); //nolang
   pop_calibrate_track.AddMessage(lang('NordY = ')+FloatToStrF(config.VecteurNordYRecentrageSuivi,ffFixed,4,2)
      +' microns'); //nolang
   end;

WriteSpy(lang('On demande le déplacement vers l''Est pendant '+MyFloatToStr(config.DelaiCalibrationRecentrage,2)
   +' s')); //nolang
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('On demande le déplacement vers l''Est pendant '+MyFloatToStr(config.DelaiCalibrationRecentrage,2)
   +' s')); //nolang

if not Telescope.StartMotion('E') then
   begin
   WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope refuse de démarrer le déplacement'));
   Exit;
   end;

TimeInit:=Time;
while Time<TimeInit+config.DelaiCalibrationRecentrage/60/60/24 do Application.ProcessMessages;

if not Telescope.StopMotion('E') then
   begin
   WriteSpy('Panique ! Le télescope refuse de s''arrêter');
   pop_Main.AfficheMessage(lang('Erreur'),
      'Panique ! Le télescope refuse de s''arrêter');
   end;

TimeInit:=Time;
while Time<TimeInit+DelaiAttente/60/60/24 do Application.ProcessMessages;

Config.EtapeCalibration:=3;
WriteSpy(lang('Recherche de l''étoile la plus brillante'));
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche de l''étoile la plus brillante'));
if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
   begin
   pop_camera_suivi.AcqMaximumBinning(x,y);
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
else pop_camera_suivi.AcqMaximum(x,y);

if StopCalibrate then
   begin
   StopCalibrate:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Exit;
   end;

if (x<=config.LargFenSuivi) or (x>CameraSuivi.GetXSize-config.LargFenSuivi) or
   (y<=config.LargFenSuivi) or (y>CameraSuivi.GetYSize-config.LargFenSuivi) then
   begin
   WriteSpy(lang('Etoile de calibration trop prés du bord'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Etoile de calibration trop prés du bord'));
   StopCalibrate:=False;
   Exit;
   end;

WriteSpy(lang('Fenêtrage de l''étoile'));
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

if StopCalibrate then
   begin
   StopCalibrate:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Exit;
   end;

Config.EtapeCalibration:=1;
pop_camera_suivi.Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,y+config.LargFenSuivi,
   TempsDePose,1,False,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos);

//Soustraction du noir
if pop_camera_suivi.NoirAcquis then
   begin
   GetImgPart(pop_camera_suivi.MemPicTrackNoir,ImgDoubleNil,pop_camera_suivi.VignetteNoir,ImgDoubleNil,2,1,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
      pop_camera_suivi.pop_image_acq.ImgInfos.Sy,x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
      y+config.LargFenSuivi);
   Soust(pop_camera_suivi.pop_image_acq.DataInt,pop_camera_suivi.VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
      pop_camera_suivi.pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy);
   FreememImg(pop_camera_suivi.VignetteNoir,ImgDoubleNil,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,2,1);
   end;

pop_camera_suivi.pop_image_acq.AjusteFenetre;   
pop_camera_suivi.pop_image_acq.VisuAutoEtoiles;

GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
   2*config.LargFenSuivi+1,2*config.LargFenSuivi+1,xx,yy,ValMax);
//ModeliseEtoile(pop_camera_suivi.pop_image_acq.DataInt,nil,2,2*config.LargFenSuivi+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
  2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);

if PSF.Flux=-1 then
   begin
   WriteSpy(lang('Erreur de modélisation'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
   StopCalibrate:=False;   
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

if StopCalibrate then
   begin
   StopCalibrate:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Exit;
   end;

config.VecteurEstXRecentrageSuivi:=(XTrackYPlus-XTrackXPlus)*CameraSuivi.GetXPixelSize;
config.VecteurEstYRecentrageSuivi:=(YTrackYPlus-YTrackXPlus)*CameraSuivi.GetYPixelSize;

WriteSpy(lang('EstX = ')+FloatToStrF(config.VecteurEstXRecentrageSuivi,ffFixed,4,2)
   +' microns'); //nolang
WriteSpy(lang('EstY = ')+FloatToStrF(config.VecteurEstYRecentrageSuivi,ffFixed,4,2)
   +' microns'); //nolang
if Assigned(pop_calibrate_track) then
   begin
   pop_calibrate_track.AddMessage(lang('EstX = ')+FloatToStrF(config.VecteurEstXRecentrageSuivi,ffFixed,4,2)
      +' microns'); //nolang
   pop_calibrate_track.AddMessage(lang('EstY = ')+FloatToStrF(config.VecteurEstYRecentrageSuivi,ffFixed,4,2)
      +' microns'); //nolang
   end;

WriteSpy(lang('On demande le déplacement vers l''Ouest pendant '+MyFloatToStr(config.DelaiCalibrationRecentrage,2)
   +' s')); //nolang
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('On demande le déplacement l''Ouest pendant '+MyFloatToStr(config.DelaiCalibrationRecentrage,2)
   +' s')); //nolang

if not Telescope.StartMotion('W') then
   begin
   WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope refuse de démarrer le déplacement'));
   Exit;
   end;

// On attends
TimeInit:=Time;
while Time<TimeInit+config.DelaiCalibrationRecentrage/60/60/24 do Application.ProcessMessages;

if not Telescope.StopMotion('W') then
   begin
   WriteSpy('Panique ! Le télescope refuse de s''arrêter');
   pop_Main.AfficheMessage(lang('Erreur'),
      'Panique ! Le télescope refuse de s''arrêter');
   end;

TimeInit:=Time;
while Time<TimeInit+DelaiAttente/60/60/24 do Application.ProcessMessages;

Config.EtapeCalibration:=1;
WriteSpy(lang('Recherche de l''étoile la plus brillante'));
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Recherche de l''étoile la plus brillante'));
if (CameraSuivi.GetXSize>192) or (CameraSuivi.GetYSize>164) then
   begin
   pop_camera_suivi.AcqMaximumBinning(x,y);
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
else pop_camera_suivi.AcqMaximum(x,y);

if StopCalibrate then
   begin
   StopCalibrate:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Exit;
   end;

if (x<=config.LargFenSuivi) or (x>CameraSuivi.GetXSize-config.LargFenSuivi) or
   (y<=config.LargFenSuivi) or (y>CameraSuivi.GetYSize-config.LargFenSuivi) then
   begin
   WriteSpy(lang('Etoile de calibration trop prés du bord'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Etoile de calibration trop prés du bord'));
   StopCalibrate:=False;   
   Exit;
   end;

WriteSpy(lang('Fenêtrage de l''étoile'));
if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Fenêtrage de l''étoile'));

if StopCalibrate then
   begin
   StopCalibrate:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Exit;
   end;

Config.EtapeCalibration:=1;
pop_camera_suivi.Acquisition(x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,y+config.LargFenSuivi,
   TempsDePose,1,False,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos);

//Soustraction du noir
if pop_camera_suivi.NoirAcquis then
   begin
   GetImgPart(pop_camera_suivi.MemPicTrackNoir,ImgDoubleNil,pop_camera_suivi.VignetteNoir,ImgDoubleNil,2,1,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
      pop_camera_suivi.pop_image_acq.ImgInfos.Sy,x-config.LargFenSuivi,y-config.LargFenSuivi,x+config.LargFenSuivi,
      y+config.LargFenSuivi);
   Soust(pop_camera_suivi.pop_image_acq.DataInt,pop_camera_suivi.VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,
      pop_camera_suivi.pop_image_acq.ImgInfos.Sy,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy);
   FreememImg(pop_camera_suivi.VignetteNoir,ImgDoubleNil,pop_camera_suivi.pop_image_acq.ImgInfos.Sx,pop_camera_suivi.pop_image_acq.ImgInfos.Sy,2,1);
   end;

pop_camera_suivi.pop_image_acq.AjusteFenetre;   
pop_camera_suivi.pop_image_acq.VisuAutoEtoiles;

GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
   2*config.LargFenSuivi+1,2*config.LargFenSuivi+1,xx,yy,ValMax);
//ModeliseEtoile(pop_camera_suivi.pop_image_acq.DataInt,nil,2,2*config.LargFenSuivi+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
  2*config.LargFenSuivi+1,TGauss,LowPrecision,LowSelect,0,PSF);

if PSF.Flux=-1 then
   begin
   WriteSpy(lang('Erreur de modélisation'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Erreur de modélisation'));
   StopCalibrate:=False;   
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

if StopCalibrate then
   begin
   StopCalibrate:=False;
   WriteSpy(lang('Arrêt de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Arrêt de la calibration'));
   Exit;
   end;

config.VecteurOuestXRecentrageSuivi:=(XTrackYMoins-XTrackYPlus)*CameraSuivi.GetXPixelSize;
config.VecteurOuestYRecentrageSuivi:=(YTrackYMoins-YTrackYPlus)*CameraSuivi.GetYPixelSize;

WriteSpy(lang('OuestX = ')+FloatToStrF(config.VecteurOuestXRecentrageSuivi,ffFixed,4,2)
   +' microns'); //nolang
WriteSpy(lang('OuestY = ')+FloatToStrF(config.VecteurOuestYRecentrageSuivi,ffFixed,4,2)
   +' microns'); //nolang
if Assigned(pop_calibrate_track) then
   begin
   pop_calibrate_track.AddMessage(lang('OuestX = ')+FloatToStrF(config.VecteurOuestXRecentrageSuivi,ffFixed,4,2)
      +' microns'); //nolang
   pop_calibrate_track.AddMessage(lang('OuestY = ')+FloatToStrF(config.VecteurOuestYRecentrageSuivi,ffFixed,4,2)
      +' microns'); //nolang
   end;

// Test de la calibration
Erreur:=False;
TooSlowNS:=False;
TooSlowEW:=False;
if Hypot(config.VecteurNordXRecentrageSuivi,config.VecteurNordYRecentrageSuivi)<10 then
   begin
   WriteSpy(lang('Vecteur Nord trop court (<10), augmentez le temps de calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Vecteur Nord trop court (<10), augmentez le temps de calibration'));
   Erreur:=True;
   TooSlowNS:=True;
   end;
if Hypot(config.VecteurSudXRecentrageSuivi,config.VecteurSudYRecentrageSuivi)<10 then
   begin
   WriteSpy(lang('Vecteur Sud trop court (<10), augmentez le temps de calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Vecteur Sud trop court (<10), augmentez le temps de calibration'));
   Erreur:=True;
   TooSlowNS:=True;
   end;
if Hypot(config.VecteurEstXRecentrageSuivi,config.VecteurEstYRecentrageSuivi)<1 then
   begin
   WriteSpy(lang('Vecteur Est trop court (<10), augmentez le temps de calibration ou diminuez la déclinaison'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Vecteur Est trop court (<10), augmentez le temps de calibration ou diminuez la déclinaison'));
   Erreur:=True;
   TooSlowEW:=True;
   end;
if Hypot(config.VecteurOuestXRecentrageSuivi,config.VecteurOuestYRecentrageSuivi)<10 then
   begin
   WriteSpy(lang('Vecteur Ouest trop court (<10), augmentez le temps de calibration ou diminuez la déclinaison'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Vecteur Ouest trop court (<10), augmentez le temps de calibration ou diminuez la déclinaison'));
   Erreur:=True;
   TooSlowEW:=True;
   end;

NotPerpend:=False;
Angle:=ArcCos((config.VecteurNordXRecentrageSuivi*Config.VecteurOuestXRecentrageSuivi+config.VecteurNordYRecentrageSuivi*Config.VecteurOuestYRecentrageSuivi)/
       Hypot(config.VecteurNordXRecentrageSuivi,config.VecteurNordYRecentrageSuivi)/Hypot(config.VecteurOuestXRecentrageSuivi,config.VecteurOuestYRecentrageSuivi))*180/pi;
if Abs(90-Angle)>10 then
   begin
   WriteSpy(lang('Vecteurs Nord et Ouest non perpendiculaires (DAngle>10°)'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Vecteurs Nord et Ouest non perpendiculaires (DAngle>10°)'));
   Erreur:=True;
   NotPerpend:=True;
   end;
Angle:=ArcCos((config.VecteurOuestXRecentrageSuivi*Config.VecteurSudXRecentrageSuivi+config.VecteurOuestYRecentrageSuivi*Config.VecteurSudYRecentrageSuivi)/
       Hypot(config.VecteurSudXRecentrageSuivi,config.VecteurSudYRecentrageSuivi)/Hypot(config.VecteurOuestXRecentrageSuivi,config.VecteurOuestYRecentrageSuivi))*180/pi;
if Abs(90-Angle)>10 then
   begin
   WriteSpy(lang('Vecteurs Ouest et Sud non perpendiculaires (DAngle>10°)'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Vecteurs Ouest et Sud non perpendiculaires (DAngle>10°)'));
   Erreur:=True;
   NotPerpend:=True;
   end;
Angle:=ArcCos((config.VecteurSudXRecentrageSuivi*Config.VecteurEstXRecentrageSuivi+config.VecteurSudYRecentrageSuivi*Config.VecteurEstYRecentrageSuivi)/
       Hypot(config.VecteurSudXRecentrageSuivi,config.VecteurSudYRecentrageSuivi)/Hypot(config.VecteurEstXRecentrageSuivi,config.VecteurEstYRecentrageSuivi))*180/pi;
if Abs(90-Angle)>10 then
   begin
   WriteSpy(lang('Vecteurs Sud et Est non perpendiculaires (DAngle>10°)'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Vecteurs Sud et Est non perpendiculaires (DAngle>10°)'));
   Erreur:=True;
   NotPerpend:=True;
   end;
Angle:=ArcCos((config.VecteurEstXRecentrageSuivi*Config.VecteurNordXRecentrageSuivi+config.VecteurEstYRecentrageSuivi*Config.VecteurNordYRecentrageSuivi)/
       Hypot(config.VecteurNordXRecentrageSuivi,config.VecteurNordYRecentrageSuivi)/Hypot(config.VecteurEstXRecentrageSuivi,config.VecteurEstYRecentrageSuivi))*180/pi;
if Abs(90-Angle)>10 then
   begin
   WriteSpy(lang('Vecteurs Est et Nord non perpendiculaires (DAngle>10°)'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Vecteurs Est et Nord non perpendiculaires (DAngle>10°)'));
   Erreur:=True;
   NotPerpend:=True;
   end;

// Entre -180 et +180 degres
{ ArcTan2 calculates ArcTan(Y/X), and returns an angle in the correct quadrant.
  IN: |Y| < 2^64, |X| < 2^64, X <> 0   OUT: [-PI..PI] radians }
if Delta2-Delta1<0 then
   Config.OrientationCCDGuidage:=90+ArcTan2(config.VecteurNordYRecentrageSuivi,config.VecteurNordXRecentrageSuivi)*180/pi
else
   Config.OrientationCCDGuidage:=-90+ArcTan2(config.VecteurNordYRecentrageSuivi,config.VecteurNordXRecentrageSuivi)*180/pi;
if Config.OrientationCCDGuidage<=-180 then Config.OrientationCCDGuidage:=Config.OrientationCCDGuidage+360;
if Config.OrientationCCDGuidage>180 then Config.OrientationCCDGuidage:=Config.OrientationCCDGuidage-360;

// Si la Camera principale est une ST7 ou une ST8 CCD Principal et que
// la Camera de guidage est une STTrack, on considere que c'est la meme
// Camera donc que les deux CCD sont orientes pareil
if (Config.TypeCamera=ST7) or (Config.TypeCamera=ST8) then
   if (Config.TypeCamera=STTrack) then
      Config.OrientationCCD:=Config.OrientationCCDGuidage;

//Direction du N a xx° du 1/2 axe des y dans le sens trigo.
WriteSpy(lang('La direction apparente du Nord est à '+MyFloatToStr(Config.OrientationCCDGuidage,2)
   +lang('° du 1/2 axe des y du CCD')));
WriteSpy(lang('dans le sens trigo'));
if Assigned(pop_calibrate_track) then
   begin
   pop_calibrate_track.AddMessage(lang('La direction apparente du Nord est à '+
      MyFloatToStr(Config.OrientationCCDGuidage,2)+lang('° du 1/2 axe des y du CCD')));
   pop_calibrate_track.AddMessage(lang('dans le sens trigo'));
   end;

config.CalibrateRecentrageSuivi:=True;
Button7.Enabled:=True;

Alpha:=0;
Config.DeltaRecentrage:=0;
if Telescope.StoreCoordinates then
   begin
   if Config.GoodPos then
      begin
      Alpha:=Config.AlphaScope;
      Config.DeltaRecentrage:=Config.DeltaScope;
      end
   else
      begin
      WriteSpy(lang('Le télescope ne veut pas donner sa position'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope ne veut pas donner sa position'));
      end;
   end;

if not Erreur then
   begin
   WriteSpy(lang('Calibration réussie'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Calibration réussie'));
   end
else
   begin
   WriteSpy(lang('Echec de la calibration'));
   if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Echec de la calibration'));
   if NotPerpend then
      begin
      WriteSpy(lang('Les déplacements N/S et E/W ne sont pas orthogonaux, Changez d''étoile'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Les déplacements N/S et E/W ne sont pas orthogonaux, Changez d''étoile'));
      end;
   if TooSlowNS then
      begin
      WriteSpy(lang('Le déplacement Nord/Sud est trop petit, augmentez le temps de calibration Nord/Sud'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Le déplacement Nord/Sud est trop petit, augmentez le temps de calibration Nord/Sud'));
      end;
   if TooSlowEW then
      begin
      WriteSpy(lang('Le déplacement Est/Ouest est trop petit, augmentez le temps de calibration Est/Ouest'));
      if Assigned(pop_calibrate_track) then pop_calibrate_track.AddMessage(lang('Le déplacement Est/Ouest est trop petit, augmentez le temps de calibration Est/Ouest'));
      end;
   end

finally
pop_camera_suivi.pop_image_acq.Bloque:=False;
Config.EtapeCalibration:=0;
end;
end;

procedure Tpop_scope.Button1Click(Sender: TObject);
begin
CalibrerRecentrageGuidage(1);
if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
end;

procedure Tpop_scope.FormClose(Sender: TObject; var Action: TCloseAction);
var
   Ini:TMemIniFile;
   Path:string;
begin
// Sauve la pos
Path:=ExtractFilePath(Application.Exename);
Ini:=TMemIniFile.Create(Path+'TeleAuto.ini'); //nolang
try
Ini.WriteString('WindowsPos','ScopeTop',IntToStr(Top));
Ini.WriteString('WindowsPos','ScopeLeft',IntToStr(Left));
finally
Ini.UpdateFile;
Ini.Free;
end;
end;

//****************************************************************************
//*******************************   scripts   ********************************
//****************************************************************************

procedure Tpop_scope.SetObjectName(Name:string);
begin
id.Text:=Name;
end;

procedure Tpop_scope.PointObject;
begin
btn_pointer_objetClick(Self);
end;

procedure Tpop_scope.RealignObject;
begin
btn_realigner_objetClick(Self);
end;

procedure Tpop_scope.SetAlphaCoordinates(Alpha:Double);
begin
Mask_Alpha.Text:=AlphaToStr(Alpha);
end;

procedure Tpop_scope.SetDeltaCoordinates(Delta:Double);
begin
Mask_Delta.Text:=DeltaToStr(Delta);
end;

procedure Tpop_scope.PointCoordinates;
begin
btn_pointerClick(Self);
end;

procedure Tpop_scope.RealignCoordinates;
begin
btn_realignerClick(Self);
end;

procedure Tpop_scope.MainCCDCenter;
begin
btn_RecenterStarClick(Self);
end;

procedure Tpop_scope.GuideCCDCenter;
begin
Button7Click(Self);
end;

procedure Tpop_scope.StopScope;
begin
BitBtn5Click(Self);
end;

procedure Tpop_scope.SetMarkOn;
begin
CheckBox3.Checked:=True;
end;

procedure Tpop_scope.SetMarkOff;
begin
CheckBox3.Checked:=False;
end;

//*******************************

procedure Tpop_scope.SetPulseOn;
begin
CheckBox1.Checked:=True;
end;

procedure Tpop_scope.SetPulseOff;
begin
CheckBox1.Checked:=False;
end;

procedure Tpop_scope.SetPulseDelay(Delay:Double);
begin
NbreEdit1.Text:=MyFloatToStr(Delay,3);
end;

procedure Tpop_scope.Speed1;
begin
btnSpeed1.Down:=True;
btnSpeed1Click(Self);
end;

procedure Tpop_scope.Speed2;
begin
btnSpeed2.Down:=True;
btnSpeed2Click(Self);
end;

procedure Tpop_scope.Speed3;
begin
btnSpeed3.Down:=True;
btnSpeed3Click(Self);
end;

procedure Tpop_scope.Speed4;
begin
btnSpeed4.Down:=True;
btnSpeed4Click(Self);
end;

procedure Tpop_scope.SetInvertNSOn;
begin
cb_InversionNS.Checked:=True;
end;

procedure Tpop_scope.SetInvertNSOff;
begin
cb_InversionNS.Checked:=False;
end;

procedure Tpop_scope.SetInvertEWOn;
begin
cb_InversionEO.Checked:=True;
end;

procedure Tpop_scope.SetInvertEWOff;
begin
cb_InversionEO.Checked:=False;
end;

procedure Tpop_scope.NorthMouseDown;
begin
BitBtn1MouseDown(Self,mbLeft,[],BitBtn1.Left+10,BitBtn1.Top+5);
end;

procedure Tpop_scope.NorthMouseUp;
begin
BitBtn1MouseUp(Self,mbLeft,[],BitBtn1.Left+10,BitBtn1.Top+5);
end;

procedure Tpop_scope.SouthMouseDown;
begin
BitBtn2MouseDown(Self,mbLeft,[],BitBtn2.Left+10,BitBtn1.Top+5);
end;

procedure Tpop_scope.SouthMouseUp;
begin
BitBtn2MouseUp(Self,mbLeft,[],BitBtn2.Left+10,BitBtn1.Top+5);
end;

procedure Tpop_scope.WestMouseDown;
begin
BitBtn3MouseDown(Self,mbLeft,[],BitBtn3.Left+10,BitBtn1.Top+5);
end;

procedure Tpop_scope.WestMouseUp;
begin
BitBtn3MouseUp(Self,mbLeft,[],BitBtn3.Left+10,BitBtn1.Top+5);
end;

procedure Tpop_scope.EastMouseDown;
begin
BitBtn4MouseDown(Self,mbLeft,[],BitBtn4.Left+10,BitBtn1.Top+5);
end;

procedure Tpop_scope.EastMouseUp;
begin
BitBtn4MouseUp(Self,mbLeft,[],BitBtn4.Left+10,BitBtn1.Top+5);
end;

procedure Tpop_scope.ScriptPark;
begin
outButton2Click(Self);
end;

procedure Tpop_scope.ScriptUnPark;
begin
outButton3Click(Self);
end;

procedure Tpop_scope.SetPhysicalParkOn;
begin
cb_Physique.Checked:=True;
end;

procedure Tpop_scope.SetPhysicalParkOff;
begin
cb_Physique.Checked:=False;
end;

procedure Tpop_scope.SetFastSpeed(Speed:Byte);
begin
SpinEdit1.Text:=IntToStr(Speed);
end;

// Script Direct

function Tpop_scope.GetPosition(var Alpha,Delta:Double):Boolean;
begin
Error:='';
Result:=True;

if Config.TelescopeBranche then
   begin
   if Telescope.StoreCoordinates then
      begin
      if Config.GoodPos then
         begin
         Alpha:=Config.AlphaScope;
         Delta:=Config.DeltaScope;
         end
      else
         begin
         WriteSpy(lang('Le télescope ne veut pas donner sa position'));
         Error:=lang('Le télescope ne veut pas donner sa position');
         Result:=False;
         end;
      end;
   end
else
   begin
   WriteSpy('Le télescope n''est pas connecté');
   Error:='Le télescope n''est pas connecté';
   Result:=False;
   end;

end;

function Tpop_scope.Point(Alpha,Delta:Double):Boolean;
begin
Error:='';
Result:=True;
if Config.TelescopeBranche then
   begin
   if not Telescope.Pointe(Alpha,Delta) then
      begin
      Result:=False;
      WriteSpy(lang('Le télescope ne veut pas pointer les coordonnées'));
      Error:=lang('Le télescope ne veut pas pointer les coordonnées');
      TelescopeErreurFatale;
      Exit;
      end;
   end
else
   begin
   WriteSpy('Le télescope n''est pas connecté');
   Error:='Le télescope n''est pas connecté';
   Result:=False;
   end;

Error:=Telescope.GetError;
end;

function Tpop_scope.GetError:string;
begin
Result:=Error;
end;

function Tpop_scope.Wait(Alpha,Delta:Double):Boolean;
begin
Error:='';
Result:=True;
if Config.TelescopeBranche then
   begin
   if not Telescope.WaitPoint(Alpha,Delta) then
      begin
      Result:=False;
      WriteSpy('Le télescope n''est pas arrivé sur les coordonnées demandées');
      Error:='Le télescope n''est pas arrivé sur les coordonnées demandées';
      end
   else if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
   end
else
   begin
   WriteSpy('Le télescope n''est pas connecté');
   Error:='Le télescope n''est pas connecté';
   Result:=False;
   end;
end;

function Tpop_scope.WaitObjectName(ObjectName:string):Boolean;
var
   OK:Boolean;
   Alpha,Delta:Double;
begin
Error:='';
Result:=True;

OK:=NameToAlphaDelta(ObjectName,Alpha,Delta);
if not OK then
   begin
   Result:=False;
   WriteSpy(lang('Objet inconnu !'));
   Error:=lang('Objet inconnu !');
   Exit;
   end;

if Config.TelescopeBranche then
   begin
   if not Telescope.WaitPoint(Alpha,Delta) then
      begin
      Result:=False;
      WriteSpy('Le télescope n''est pas arrivé sur les coordonnées demandées');
      Error:='Le télescope n''est pas arrivé sur les coordonnées demandées';
      end
   else if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
   end
else
   begin
   WriteSpy('Le télescope n''est pas connecté');
   Error:='Le télescope n''est pas connecté';
   Result:=False;
   end;

end;

function Tpop_scope.PointObjectName(ObjectName:string):Boolean;
var
   OK:Boolean;
   Alpha,Delta:Double;
begin
Error:='';
Result:=True;

if Config.TelescopeBranche then
   begin
   OK:=NameToAlphaDelta(ObjectName,Alpha,Delta);
   if not OK then
      begin
      Result:=False;
      WriteSpy(lang('Objet inconnu !'));
      Error:=lang('Objet inconnu !');
      Exit;
      end;

   WriteSpy(lang('Pointe : Demande = ')+AlphaToStr(Alpha)+'/'+DeltaToStr(Delta));

   if not Telescope.Pointe(Alpha,Delta) then
      begin
      Result:=False;
      WriteSpy(lang('Le télescope ne veut pas pointer les coordonnées'));
      Error:=lang('Le télescope ne veut pas pointer les coordonnées');
      TelescopeErreurFatale;
      Exit;
      end;

   Error:=Telescope.GetError;
   end
else
   begin
   WriteSpy('Le télescope n''est pas connecté');
   Error:='Le télescope n''est pas connecté';
   Result:=False;
   end;

end;

function Tpop_scope.Realign(Alpha,Delta:Double):Boolean;
begin
Error:='';
Result:=True;
if Config.TelescopeBranche then
   begin
   if not Telescope.Sync(Alpha,Delta) then
      begin
      Result:=False;
      WriteSpy(lang('Le télescope refuse de se synchroniser'));
      Error:=lang('Le télescope refuse de se synchroniser');
      end
   else if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
   end
else
   begin
   WriteSpy('Le télescope n''est pas connecté');
   Error:='Le télescope n''est pas connecté';
   Result:=False;
   end;
end;

function Tpop_scope.RealignObjectName(ObjectName:string):Boolean;
var
   OK:Boolean;
   Alpha,Delta:Double;
begin
Error:='';
Result:=True;

if Config.TelescopeBranche then
   begin
   OK:=NameToAlphaDelta(ObjectName,Alpha,Delta);
   if not OK then
      begin
      Result:=False;
      WriteSpy(lang('Objet inconnu !'));
      Error:=lang('Objet inconnu !');
      Exit;
      end;

   if not Telescope.Sync(Alpha,Delta) then
      begin
      Result:=False;
      WriteSpy(lang('Le télescope refuse de se synchroniser'));
      Error:=lang('Le télescope refuse de se synchroniser');
      end
   else if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
   end
else
   begin
   WriteSpy('Le télescope n''est pas connecté');
   Error:='Le télescope n''est pas connecté';
   Result:=False;
   end;
end;

function Tpop_scope.StartMotion(Direction:string):Boolean;
var
   OK:Boolean;
begin
Error:='';
Result:=True;

if Config.TelescopeBranche then
   begin
   OK:=Telescope.StartMotion(Direction);

   if not OK then
      begin
      WriteSpy(lang('Le télescope refuse de démarrer le déplacement'));
      Error:=lang('Le télescope refuse de démarrer le déplacement');
      Result:=False;
      end;
   end
else
   begin
   WriteSpy('Le télescope n''est pas connecté');
   Error:='Le télescope n''est pas connecté';
   Result:=False;
   end;
end;

function Tpop_scope.StopMotion(Direction:string):Boolean;
var
   OK:Boolean;
begin
Error:='';
Result:=True;

if Config.TelescopeBranche then
   begin
   OK:=Telescope.StopMotion(Direction);

   if not OK then
      begin
      WriteSpy('Panique ! Le télescope refuse de s''arrêter');
      Error:='Panique ! Le télescope refuse de s''arrêter';
      Result:=False;
      end;
   end
else
   begin
   WriteSpy('Le télescope n''est pas connecté');
   Error:='Le télescope n''est pas connecté';
   Result:=False;
   end;
end;

function Tpop_scope.Quit:Boolean;
var
   OK:Boolean;
begin
Error:='';
Result:=True;

if Config.TelescopeBranche then
   begin
   OK:=Telescope.Quit;
   OK:=Telescope.StopMotion('N');
   OK:=Telescope.StopMotion('S');
   OK:=Telescope.StopMotion('E');
   OK:=Telescope.StopMotion('W');
   if not OK then
      begin
      WriteSpy('Panique ! Le télescope refuse de s''arrêter');
      Error:='Panique ! Le télescope refuse de s''arrêter';
      Result:=False;
      end;
   end
else
   begin
   WriteSpy('Le télescope n''est pas connecté');
   Error:='Le télescope n''est pas connecté';
   Result:=False;
   end;

end;

function Tpop_scope.MotionRate(MotionNumber:Integer):Boolean;
begin
Error:='';
Result:=True;

if Config.TelescopeBranche then
   begin
   if not Telescope.MotionRate(MotionNumber) then
      begin
      WriteSpy(lang('Le télescope refuse le réglage de vitesse'));
      Error:=lang('Le télescope refuse le réglage de vitesse');
      Result:=False;
      end;
   end
else
   begin
   WriteSpy('Le télescope n''est pas connecté');
   Error:='Le télescope n''est pas connecté';
   Result:=False;
   end;

end;

procedure Tpop_scope.BitBtn8Click(Sender: TObject);
begin
Height:=404;
BitBtn8.Visible:=False;
end;

procedure Tpop_scope.BitBtn6Click(Sender: TObject);
begin
Height:=300;
BitBtn8.Visible:=True;
end;

procedure Tpop_scope.CheckBox4Click(Sender: TObject);
begin
if CheckBox4.Checked then
   begin
   outLabel17.Caption:='Azimuth :';
   outLabel22.Caption:='Hauteur :';
   Mask_Alpha.EditMask:='!#990'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
      Config.UnitesSecondesDelta+';1;_'; //nolang
   Mask_Delta.EditMask:='!#90'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
      Config.UnitesSecondesDelta+';1;_'; //nolang
   Mask_Alpha.Text:='+180'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
      Config.UnitesSecondesDelta; //nolang
   Mask_Delta.Text:='+90'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
      Config.UnitesSecondesDelta; //nolang
   end
else
   begin
   outLabel17.Caption:='Alpha :';
   outLabel22.Caption:='Delta :';
   Mask_Alpha.EditMask:='!90'+Config.SeparateurHeuresMinutesAlpha+'00'+Config.SeparateurMinutesSecondesAlpha+'00'+ //nolang
      Config.UnitesSecondesAlpha+';1;_'; //nolang
   Mask_Delta.EditMask:='!#90'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
      Config.UnitesSecondesDelta+';1;_'; //nolang
   Mask_Alpha.Text:='__'+Config.SeparateurHeuresMinutesAlpha+'__'+Config.SeparateurMinutesSecondesAlpha+'__'+ //nolang
      Config.UnitesSecondesAlpha; //nolang
   Mask_Delta.Text:='___'+Config.SeparateurDegresMinutesDelta+'__'+Config.SeparateurMinutesSecondesDelta+'__'+ //nolang
      Config.UnitesSecondesDelta; //nolang
   end
end;

end.

