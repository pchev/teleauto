unit pu_conf;

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
  StdCtrls, Buttons, ComCtrls, Spin, ExtCtrls, IniFiles, Editnbre,
  Mask, ImgList, PBFolderDialog;

type
  Tpop_conf = class(TForm)
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    load_config: TOpenDialog;
    save_config: TSaveDialog;
    outTabSheet1: TTabSheet;
    Label3: TLabel;
    Label6: TLabel;
    Label11: TLabel;
    Label22: TLabel;
    Label19: TLabel;
    Edit3: TEdit;
    outComboBox1: TComboBox;
    outTabSheet2: TTabSheet;
    Label8: TLabel;
    CheckBox7: TCheckBox;
    CheckBox6: TCheckBox;
    Edit8: TEdit;
    outTabSheet3: TTabSheet;
    Label71: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label40: TLabel;
    Edit35: TEdit;
    Edit9: TEdit;
    outTabSheet4: TTabSheet;
    Label23: TLabel;
    Label7: TLabel;
    Label14: TLabel;
    Label29: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label30: TLabel;
    Edit7: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    outTabSheet5: TTabSheet;
    outTabSheet6: TTabSheet;
    GroupBox2: TGroupBox;
    Label51: TLabel;
    Label59: TLabel;
    Label61: TLabel;
    Edit24: TEdit;
    Edit32: TEdit;
    Edit25: TEdit;
    GroupBox1: TGroupBox;
    Label63: TLabel;
    Label64: TLabel;
    Label68: TLabel;
    Edit30: TEdit;
    Edit33: TEdit;
    Edit31: TEdit;
    outTabSheet7: TTabSheet;
    outTabSheet8: TTabSheet;
    outTabSheet9: TTabSheet;
    Label24: TLabel;
    Label25: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Edit36: TEdit;
    Edit37: TEdit;
    Edit38: TEdit;
    Edit39: TEdit;
    Edit40: TEdit;
    outTabSheet12: TTabSheet;
    outTabSheet10: TTabSheet;
    outPageControl1: TPageControl;
    CheckBox15: TCheckBox;
    Label52: TLabel;
    Label88: TLabel;
    Pixels: TLabel;
    Label87: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    outTabSheet11: TTabSheet;
    RadioGroup3: TRadioGroup;
    RadioGroup4: TRadioGroup;
    TreeView1: TTreeView;
    outTabSheet13: TTabSheet;
    outTabSheet14: TTabSheet;
    GroupBox5: TGroupBox;
    Label65: TLabel;
    Label37: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Button8: TButton;
    Button10: TButton;
    outPanel8: TPanel;
    outPanel9: TPanel;
    outPanel7: TPanel;
    outPanel10: TPanel;
    outPanel11: TPanel;
    Button7: TButton;
    Button9: TButton;
    Button11: TButton;
    GroupBox4: TGroupBox;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    outPanel1: TPanel;
    outPanel2: TPanel;
    outPanel3: TPanel;
    outPanel4: TPanel;
    Button5: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    outTabSheet15: TTabSheet;
    outTabSheet16: TTabSheet;
    outTabSheet17: TTabSheet;
    outTabSheet19: TTabSheet;
    outTabSheet20: TTabSheet;
    outTabSheet21: TTabSheet;
    outTabSheet22: TTabSheet;
    outTabSheet23: TTabSheet;
    TabSheet24: TTabSheet;
    btn_load: TBitBtn;
    btn_save: TBitBtn;
    outTabSheet25: TTabSheet;
    Label56: TLabel;
    Label58: TLabel;
    Edit21: TEdit;
    Edit20: TEdit;
    Label54: TLabel;
    Label55: TLabel;
    Label45: TLabel;
    Label69: TLabel;
    Edit26: TEdit;
    SpinEdit4: TSpinEdit;
    RadioGroup2: TRadioGroup;
    Label4: TLabel;
    Edit4: TEdit;
    Label20: TLabel;
    Label57: TLabel;
    outTabSheet26: TTabSheet;
    outTabSheet18: TTabSheet;
    Edit34: TEdit;
    Label49: TLabel;
    Label60: TLabel;
    NbreEdit2: NbreEdit;
    Label96: TLabel;
    NbreEdit3: NbreEdit;
    Label97: TLabel;
    GroupBox3: TGroupBox;
    Label48: TLabel;
    Label62: TLabel;
    NbreEdit4: NbreEdit;
    NbreEdit5: NbreEdit;
    Label66: TLabel;
    Label67: TLabel;
    cb_park_real: TCheckBox;
    Label100: TLabel;
    park_meridian: TEdit;
    Label101: TLabel;
    dec_park: TEdit;
    ListBox1: TListBox;
    Label98: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    GroupBox6: TGroupBox;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    NbreEdit6: NbreEdit;
    NbreEdit7: NbreEdit;
    NbreEdit8: NbreEdit;
    NbreEdit9: NbreEdit;
    NbreEdit10: NbreEdit;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    GroupBox7: TGroupBox;
    Label119: TLabel;
    Label120: TLabel;
    NbreEdit11: NbreEdit;
    NbreEdit12: NbreEdit;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    RadioGroup5: TRadioGroup;
    GroupBox8: TGroupBox;
    Label126: TLabel;
    Label127: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    NbreEdit13: NbreEdit;
    NbreEdit14: NbreEdit;
    NbreEdit15: NbreEdit;
    NbreEdit16: NbreEdit;
    NbreEdit17: NbreEdit;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    RadioGroup6: TRadioGroup;
    GroupBox9: TGroupBox;
    Label53: TLabel;
    SpinEdit6: TSpinEdit;
    Label145: TLabel;
    GroupBox11: TGroupBox;
    Label102: TLabel;
    SpinEdit7: TSpinEdit;
    GroupBox12: TGroupBox;
    Label141: TLabel;
    Edit29: TEdit;
    Edit28: TEdit;
    Label142: TLabel;
    Edit23: TEdit;
    Label144: TLabel;
    Edit27: TEdit;
    Label143: TLabel;
    Label146: TLabel;
    Label2: TLabel;
    outComboBox3: TComboBox;
    RadioGroup8: TRadioGroup;
    Label18: TLabel;
    Label26: TLabel;
    Label151: TLabel;
    Label152: TLabel;
    cb_coupe_ampli: TCheckBox;
    SpinEdit9: TSpinEdit;
    RadioGroup9: TRadioGroup;
    Label155: TLabel;
    Edit6: TEdit;
    RadioGroup10: TRadioGroup;
    RadioGroup11: TRadioGroup;
    Label164: TLabel;
    outComboBox4: TComboBox;
    CheckBox1: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    RadioGroup12: TRadioGroup;
    Panel1: TPanel;
    Label169: TLabel;
    Label170: TLabel;
    NbreEdit24: NbreEdit;
    NbreEdit25: NbreEdit;
    TabSheet1: TTabSheet;
    Label171: TLabel;
    e_mysql_bin: TEdit;
    Label172: TLabel;
    e_mysql_engine: TEdit;
    mysql_led: TEdit;
    l_mysql_status: TLabel;
    GroupBox23: TGroupBox;
    CheckBox3: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    Label176: TLabel;
    MaskLong: TMaskEdit;
    MaskLat: TMaskEdit;
    CheckBox13: TCheckBox;
    GroupBox24: TGroupBox;
    Label183: TLabel;
    NbreEdit27: NbreEdit;
    Label184: TLabel;
    LabelAlphaSep: TLabel;
    ComboBoxAlphaSep: TComboBox;
    ComboBoxDeltaSep: TComboBox;
    LabelDeltaSep: TLabel;
    LabelAdressCom: TLabel;
    outComboBoxAdressCom: TComboBox;
    Label1: TLabel;
    EditCosmetic: TEdit;
    Button6: TButton;
    Label17: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label177: TLabel;
    CheckBoxInvFoc: TCheckBox;
    LabelInvFoc1: TLabel;
    LabelInvFoc2: TLabel;
    LabelInvFoc3: TLabel;
    LabelVitRap: TLabel;
    LabelVitLent: TLabel;
    LabelImpArr: TLabel;
    LabelTpsStab: TLabel;
    LabelImpAv: TLabel;
    LabelSurArr: TLabel;
    NbreEditImpArrRap: NbreEdit;
    NbreEditImpArrLent: NbreEdit;
    NbreEditStabRap: NbreEdit;
    NbreEditStabLent: NbreEdit;
    NbreEditImpAvRap: NbreEdit;
    NbreEditImpAvLent: NbreEdit;
    NbreEditSurRap: NbreEdit;
    NbreEditSurLent: NbreEdit;
    CheckBoxCloseQuery: TCheckBox;
    RadioGroupHS: TRadioGroup;
    GroupBoxPortHS: TGroupBox;
    Label1HS: TLabel;
    Label2HS: TLabel;
    Label3HS: TLabel;
    Label4HS: TLabel;
    Label5HS: TLabel;
    Label6HS: TLabel;
    Label7HS: TLabel;
    Label8HS: TLabel;
    Label9HS: TLabel;
    Label10HS: TLabel;
    NbreEdit1HS: NbreEdit;
    NbreEdit2HS: NbreEdit;
    NbreEdit3HS: NbreEdit;
    NbreEdit4HS: NbreEdit;
    NbreEdit5HS: NbreEdit;
    Label11HS: TLabel;
    Label12HS: TLabel;
    Label13HS: TLabel;
    Label14HS: TLabel;
    LabelPortHS: TLabel;
    outComboBoxPortHS: TComboBox;
    LabelFwhm1: TLabel;
    LabelFwhm2: TLabel;
    LabelInvFoc4: TLabel;
    LabelInvFoc5: TLabel;
    Label38: TLabel;
    SpinEdit1: TSpinEdit;
    Label39: TLabel;
    CheckBoxCorFast: TCheckBox;
    CheckBoxCorSlow: TCheckBox;
    GroupBox13: TGroupBox;
    Label47: TLabel;
    SpinEdit3: TSpinEdit;
    SpinEdit10: TSpinEdit;
    Label28: TLabel;
    Label32: TLabel;
    ComboBox1: TComboBox;
    Label46: TLabel;
    SpinEdit2: TSpinEdit;
    ComboBoxModel: TComboBox;
    LabelModel: TLabel;
    GroupBox25: TGroupBox;
    GroupBox26: TGroupBox;
    GroupBox27: TGroupBox;
    Label36: TLabel;
    Label50: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    NbreEdit30: NbreEdit;
    NbreEdit31: NbreEdit;
    NbreEdit32: NbreEdit;
    NbreEdit33: NbreEdit;
    NbreEdit34: NbreEdit;
    NbreEdit35: NbreEdit;
    NbreEdit36: NbreEdit;
    NbreEdit37: NbreEdit;
    CheckBox2: TCheckBox;
    CheckBox4: TCheckBox;
    Label89: TLabel;
    CheckBox5: TCheckBox;
    Label90: TLabel;
    Label93: TLabel;
    Label147: TLabel;
    Label148: TLabel;
    Label159: TLabel;
    Label160: TLabel;
    Label178: TLabel;
    Label179: TLabel;
    Label180: TLabel;
    Label181: TLabel;
    Label182: TLabel;
    Label185: TLabel;
    Label76: TLabel;
    Edit41: TEdit;
    Label77: TLabel;
    Label149: TLabel;
    NbreEdit18: NbreEdit;
    Label150: TLabel;
    Label31: TLabel;
    Edit11: TEdit;
    Label82: TLabel;
    Label83: TLabel;
    audine_obtu_text: TEdit;
    Label81: TLabel;
    Label167: TLabel;
    NbreEdit22: NbreEdit;
    Label168: TLabel;
    NbreEdit23: NbreEdit;
    Label154: TLabel;
    Label187: TLabel;
    Label188: TLabel;
    Edit2: TEdit;
    Label157: TLabel;
    NbreEdit19: NbreEdit;
    Label158: TLabel;
    Label70: TLabel;
    Edit10: TEdit;
    Label156: TLabel;
    Label162: TLabel;
    Edit47: TEdit;
    Label163: TLabel;
    Label165: TLabel;
    NbreEdit20: NbreEdit;
    NbreEdit21: NbreEdit;
    Label166: TLabel;
    Label161: TLabel;
    Edit46: TEdit;
    Label189: TLabel;
    Label190: TLabel;
    PBFolderDialog1: TPBFolderDialog;
    Label198: TLabel;
    Edit12: TEdit;
    Label199: TLabel;
    Label200: TLabel;
    Edit17: TEdit;
    Label201: TLabel;
    Edit18: TEdit;
    NbreEdit40: NbreEdit;
    CheckBox10: TCheckBox;
    RadioGroup1: TRadioGroup;
    GroupBox14: TGroupBox;
    Label173: TLabel;
    Label174: TLabel;
    NbreEdit26: NbreEdit;
    NbreEdit41: NbreEdit;
    Label175: TLabel;
    Label202: TLabel;
    RadioGroup13: TRadioGroup;
    GroupBox15: TGroupBox;
    Label196: TLabel;
    Label75: TLabel;
    Edit1: TEdit;
    Edit44: TEdit;
    Label86: TLabel;
    Label197: TLabel;
    Label203: TLabel;
    Label204: TLabel;
    NbreEdit42: NbreEdit;
    Label205: TLabel;
    Label206: TLabel;
    NbreEdit43: NbreEdit;
    Label207: TLabel;
    CheckBox14: TCheckBox;
    GroupBox16: TGroupBox;
    Label99: TLabel;
    NbreEdit1: NbreEdit;
    Label33: TLabel;
    Label34: TLabel;
    NbreEdit29: NbreEdit;
    Label35: TLabel;
    CheckBox16: TCheckBox;
    Button12: TButton;
    GroupBox17: TGroupBox;
    Label10: TLabel;
    Label153: TLabel;
    SpinEdit5: TSpinEdit;
    SpinEdit8: TSpinEdit;
    GroupBox18: TGroupBox;
    Label192: TLabel;
    Label193: TLabel;
    SpinEdit12: TSpinEdit;
    SpinEdit13: TSpinEdit;
    Label5: TLabel;
    Label21: TLabel;
    Button13: TButton;
    CheckBox18: TCheckBox;
    Label195: TLabel;
    NbreEdit38: NbreEdit;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    Label194: TLabel;
    Edit5: TEdit;
    Label27: TLabel;
    Label208: TLabel;
    Label209: TLabel;
    Label210: TLabel;
    Label211: TLabel;
    CheckBox23: TCheckBox;
    Edit13: TEdit;
    Edit19: TEdit;
    Edit22: TEdit;
    CheckBox17: TCheckBox;
    Label191: TLabel;
    Label140: TLabel;
    Label186: TLabel;
    outComboBox2: TComboBox;
    SpinEdit11: TSpinEdit;
    Label212: TLabel;
    SpinEdit14: TSpinEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure btn_loadClick(Sender: TObject);
    procedure btn_saveClick(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure CheckBox15Click(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioGroup5Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure RadioGroup11Click(Sender: TObject);
    procedure NbreEdit20Change(Sender: TObject);
    procedure NbreEdit21Change(Sender: TObject);
    procedure NbreEdit22Change(Sender: TObject);
    procedure NbreEdit23Change(Sender: TObject);
    procedure RadioGroup12Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup10Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure NbreEdit2Change(Sender: TObject);
    procedure NbreEdit27Change(Sender: TObject);
    procedure CheckBoxInvFocClick(Sender: TObject);
    procedure Edit25Change(Sender: TObject);
    procedure Edit31Change(Sender: TObject);
    procedure RadioGroupHSClick(Sender: TObject);
    procedure CheckBoxCorFastClick(Sender: TObject);
    procedure CheckBoxCorSlowClick(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure RadioGroup6Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit46Change(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure CheckBox16Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure CheckBox19Click(Sender: TObject);
    procedure RadioGroup9Click(Sender: TObject);
    procedure ComboBoxModelChange(Sender: TObject);


  private
    { Private declarations }
    procedure update_conf_edits;
    procedure DisplayOptions(s:string);

    procedure HideNode(NodeName:string);
    procedure ShowNode(NodeName,ParentNode:string);

    procedure UpdateCat;
    procedure UpdateCameraConf;
    procedure UpdateCameraSuiviConf;
    procedure UpdateScope;
    procedure UpdateFocuser;
    procedure UpdateDome;
    procedure UdpateHourServer;
    procedure UpdateFWHM;
    procedure UpdateStop;
  public
    { Public declarations }
    NameOfTabToDisplay:string;
    UpdatingControls:Boolean;
    CameraBrancheeSave,CameraSuiviBrancheeSave,TelescopeBrancheSave,FocuserBrancheSave:Boolean;
    DomeBrancheSave,HourServerBrancheSave:Boolean;

  end;

  procedure SaveParametres(FileName:string);
  procedure LoadParametres(Filename:string);

  var pop_conf:Tpop_conf;

implementation

{$R *.DFM}

uses pu_main,
     pu_camera,
     u_constants,
     u_driver_st7,
     catalogues,
     u_file_io,
     u_general,
     pu_seuils,
     pu_scope,
     pu_image,
     pu_script_builder,
     pu_webcam,
     u_lang,
     u_cameras,
     u_focusers,
     u_dome,
     u_telescopes,
     pu_camera_suivi,
     pu_dome,
     pu_map,
     u_hour_servers,
     pu_hour_server,
     pu_anal_modele,
     pu_decalage_obs;


procedure Tpop_conf.BitBtn2Click(Sender: TObject);
begin
Close;
end;

procedure Tpop_conf.BitBtn1Click(Sender: TObject);
var
   Path:string;
   Error:Word;
   NoCamera:Word;
   Temp,Angle:Double;
begin
    // Mise a jour des parametres de config
    config.park_physique:=cb_park_real.checked;
    config.park_meridien:=park_meridian.text;
    config.park_decli:=dec_park.text;
    config.temperature:=MyStrToFloat(edit41.text);
    config.ObtuCloseDelay:=MyStrToFloat(audine_obtu_text.text);
    config.ObtuCloseDelaySuivi:=MyStrToFloat(Edit47.text);
    Path:=ExtractFilePath(Application.ExeName);
    case config.typeGSC of
       0:setgsccpath(config.RepGSC);
       1:setgscfpath(config.RepGSC);
       end;

    //mysql
{    config.mysql_bin:=e_mysql_bin.text;
    config.mysql_engine:=e_mysql_engine.text;
    config.mysql_installed:=fileexists(config.mysql_bin+'\'+config.mysql_engine);
    if not config.mysql_installed then
       pop_main.imagedb1.enabled:=false
    else
       pop_main.imagedb1.enabled:=true;

    Config.MySqlHost:=Edit12.Text;
    Config.MySqlPort:=StrToInt(NbreEdit40.Text);
    Config.MySqlUserName:=Edit17.Text;
    Config.MySqlUserPassWord:=Edit18.Text;
    Config.MySqlAskPassword:=CheckBox10.Checked;}

    setusnoapath(config.RepUSNO);
    setmctpath(config.RepMicrocat);
    setbscpath(config.RepCatalogsBase+'\BSC'); //nolang
    setngcpath(config.RepCatalogsBase+'\NGC'); //nolang
    setpgcpath(config.RepCatalogsBase+'\PGC'); //nolang
    setrc3path(config.RepCatalogsBase+'\RC3'); //nolang
    setwdspath(config.RepCatalogsBase+'\WDS'); //nolang
    setgcvpath(config.RepCatalogsBase+'\GCVS'); //nolang
    //
    config.FocaleTele:=MyStrToFloat(Edit3.Text);
    config.Diametre:=MyStrToFloat(Edit34.Text);

    Angle:=MyStrToFloat(NbreEdit2.Text);
    if (Config.TypeCamera=ST7) or (Config.TypeCamera=ST8) then
       if (Config.TypeCameraSuivi=STTrack) then
          begin
          if pop_camera_suivi.CheckBox2.Checked then Angle:=Angle+180;
          if Angle>180 then Angle:=Angle-360;
          if Angle<=-180 then Angle:=Angle+360;
          end;
    config.OrientationCCD:=Angle;

    Angle:=MyStrToFloat(NbreEdit27.Text);
    if pop_camera_suivi.CheckBox2.Checked then Angle:=Angle+180;
    if Angle>180 then Angle:=Angle-360;
    if Angle<=-180 then Angle:=Angle+360;
    config.OrientationCCDGuidage:=Angle;

    config.Seeing:=MyStrToFloat(NbreEdit3.Text);
    config.MinPose:=MyStrToFloat(Edit4.Text);
//    config.MaxPose:=MyStrToFloat(Edit5.Text);
    config.Vitesse:=SpinEdit9.Value;
    config.DeltaMax:=MyStrToFloat(Edit7.Text);
    config.TelescopeComPort:=outComboBox1.Text;
    config.AdresseComPort:=outComboBoxAdressCom.Text;
    config.MapComPort:=outComboBox2.Text;
    Config.UseMoyenne:=ComboBox1.Text=lang('Moyenne');
    config.Lat:=StrToDelta(MaskLat.Text);
    config.Long:=StrToDelta(MaskLong.Text);
    config.HauteurMini:=MyStrToFloat(Edit14.Text);
    config.Profil:=Edit15.Text;
    config.Attente:=MyStrToFloat(Edit16.Text);
    config.TypeCamera:=RadioGroup2.ItemIndex;
    config.TypeCameraSuivi:=RadioGroup11.ItemIndex;
    config.TypeFocuser:=RadioGroup6.ItemIndex;
    config.TypeHourServer:=RadioGroupHS.ItemIndex;
    config.FormatSaveInt:=RadioGroup3.ItemIndex;
    config.FormatCouleur:=RadioGroup4.ItemIndex;
    config.ReadingDelai:=StrToInt(Edit11.Text);
    config.ReadingDelaiSuivi:=StrToInt(Edit10.Text);
    config.MirrorX:=CheckBox6.Checked;
    config.MirrorY:=CheckBox7.Checked;
    config.MirrorXSuivi:=CheckBox1.Checked;
    config.MirrorYSuivi:=CheckBox8.Checked;
    config.PCMoinsTU:=SpinEdit1.Value;
    config.Pose1:=MyStrToFloat(Edit20.Text);
    config.Pose2:=MyStrToFloat(Edit26.Text);
    config.Pose4:=MyStrToFloat(Edit21.Text);
    config.NbBouclage:=SpinEdit4.Value;
    config.NbEssaiCentroMaxi:=SpinEdit2.Value;
    config.NbEssaiFocFast:=SpinEdit3.Value;
    config.NbEssaiFocSlow:=SpinEdit10.Value;    
    config.LargFoc:=SpinEdit6.Value div 2; // Largeur -> Demi-Largeur
    config.DelaiFocFastInit:=MyStrToFloat(Edit24.Text);
    config.DelaiFocSlowInit:=MyStrToFloat(Edit30.Text);
    config.FwhmStopFast:=MyStrToFloat(Edit25.Text);
    config.FwhmStopSlow:=MyStrToFloat(Edit31.Text);
    config.DelaiFocFastMin:=MyStrToFloat(Edit32.Text);
    config.DelaiFocSlowMin:=MyStrToFloat(Edit33.Text);
    config.ConfigPretrait.NomOffset:=Edit29.Text;
    config.ConfigPretrait.NomNoir:=Edit28.Text;
    config.ConfigPretrait.NomNoirFlat:=Edit27.Text;
    config.ConfigPretrait.NomFlat:=Edit23.Text;
    config.ConfigPretrait.NomCosmetiques:=EditCosmetic.Text;
    Config.TypeTelescope:=RadioGroup10.ItemIndex;
    config.Observatoire:=Edit35.Text;
    config.Observateur:=Edit9.Text;
    config.Filtre:=Edit8.Text;
    config.NameFilter[1]:=Edit36.Text;
    config.NameFilter[2]:=Edit37.Text;
    config.NameFilter[3]:=Edit38.Text;
    config.NameFilter[4]:=Edit39.Text;
    config.NameFilter[5]:=Edit40.Text;
    config.DelaiRattrapageSuiviNS:=MyStrToFloat(Edit1.Text);    
    config.DelaiCalibrationSuiviNS:=MyStrToFloat(Edit44.Text);
    config.DelaiCalibrationSuiviEO:=config.DelaiCalibrationSuiviNS;
    config.CoefLimitationNS:=MyStrToFloat(NbreEdit1.Text);
    config.CoefLimitationEO:=config.CoefLimitationNS;
    config.JpegQuality:=SpinEdit7.Value;

    config.SeuilBasPourCent:=MyStrToFloat(NbreEdit4.Text);
    config.SeuilHautPourCent:=MyStrToFloat(NbreEdit5.Text);
    Config.MultBas:=MyStrToFloat(NbreEdit41.Text);
    Config.MultHaut:=MyStrToFloat(NbreEdit26.Text);
    config.SeuilCamera:=RadioGroup12.itemindex;
    config.SeuilBasFixe:=StrtoInt(NbreEdit24.Text);
    config.SeuilHautFixe:=StrtoInt(NbreEdit25.Text);

    config.ReadIntervalTimeout:=StrToInt(NbreEdit6.Text);
    config.ReadTotalTimeoutMultiplier:=StrToInt(NbreEdit7.Text);
    config.ReadTotalTimeoutConstant:=StrToInt(NbreEdit8.Text);
    config.WriteTotalTimeoutMultiplier:=StrToInt(NbreEdit9.Text);
    config.WriteTotalTimeoutConstant:=StrToInt(NbreEdit10.Text);

    config.HourServerReadIntervalTimeout:=StrToInt(NbreEdit1HS.Text);
    config.HourServerReadTotalTimeoutMultiplier:=StrToInt(NbreEdit2HS.Text);
    config.HourServerReadTotalTimeoutConstant:=StrToInt(NbreEdit3HS.Text);
    config.HourServerWriteTotalTimeoutMultiplier:=StrToInt(NbreEdit4HS.Text);
    config.HourServerWriteTotalTimeoutConstant:=StrToInt(NbreEdit5HS.Text);

    config.MapReadIntervalTimeout:=StrToInt(NbreEdit13.Text);
    config.MapReadTotalTimeoutMultiplier:=StrToInt(NbreEdit14.Text);
    config.MapReadTotalTimeoutConstant:=StrToInt(NbreEdit15.Text);
    config.MapWriteTotalTimeoutMultiplier:=StrToInt(NbreEdit16.Text);
    config.MapWriteTotalTimeoutConstant:=StrToInt(NbreEdit17.Text);

    config.ErreurPointingAlpha:=MyStrToFloat(NbreEdit11.Text);
    config.ErreurPointingDelta:=MyStrToFloat(NbreEdit12.Text);

    config.TypeSaveFits:=RadioGroup13.ItemIndex;
    config.DelaiVidage:=MyStrToFloat(NbreEdit18.Text);
    config.DelaiVidageSuivi:=MyStrToFloat(NbreEdit19.Text);

    config.FormeModelePhotometrie:=RadioGroup8.ItemIndex+1;
    config.DegreCielPhotometrie:=SpinEdit5.Value;
    config.LargModelisePhotometrie:=SpinEdit8.Value;
    Config.ApertureInt:=SpinEdit12.Value;
    Config.ApertureOut:=SpinEdit13.Value;
    Config.ApertureMid:=SpinEdit14.Value;        

    if outComboBox3.Text='LPT1 ($378)' then Config.AdresseCamera:=$378; //nolang
    if outComboBox3.Text='LPT2 ($278)' then Config.AdresseCamera:=$278; //nolang
    if outComboBox3.Text='LPT3 ($3BC)' then Config.AdresseCamera:=$3BC; //nolang

    if outComboBox4.Text='LPT1 ($378)' then Config.AdresseCameraSuivi:=$378; //nolang
    if outComboBox4.Text='LPT2 ($278)' then Config.AdresseCameraSuivi:=$278; //nolang
    if outComboBox4.Text='LPT3 ($3BC)' then Config.AdresseCameraSuivi:=$3BC; //nolang

    config.cutampli:=cb_coupe_ampli.checked;
    config.cutampliSuivi:=CheckBox9.checked;

    config.CameraPlugin:=Edit2.Text;
    config.FocuserPlugin:=Edit5.Text;    
    config.CameraPluginSuivi:=Edit46.Text;
    config.DomePlugin:=Edit6.Text;

    config.TypeDome:=RadioGroup9.ItemIndex;

    config.Webcam_pixelsizeX:=mystrtofloat(NbreEdit20.text);
    config.Webcam_pixelsizeY:=mystrtofloat(NbreEdit21.text);

//    config.CCDOriente:=CheckBox2.Checked;
//    config.CCDTrackOriente:=CheckBox10.Checked;

    config.MesureParSuperStar:=CheckBox3.Checked;
    config.MesureParReference:=CheckBox11.Checked;
    config.MesureParRegressionLineaire:=CheckBox12.Checked;

    Config.UseLongFormat:=CheckBox13.Checked;
    Config.Allemande:=CheckBox18.Checked;

    // 16h05m15s
    // 16h05m15
    // 16:05:15
    Config.TypeSeparateurAlpha:=ComboBoxAlphaSep.ItemIndex;
    case ComboBoxAlphaSep.ItemIndex of
       0:begin
         Config.SeparateurHeuresMinutesAlpha:='h';
         Config.SeparateurMinutesSecondesAlpha:='m';
         Config.UnitesSecondesAlpha:='s';
         end;
       1:begin
         Config.SeparateurHeuresMinutesAlpha:='h';
         Config.SeparateurMinutesSecondesAlpha:='m';
         Config.UnitesSecondesAlpha:=' ';
         end;
       2:begin
         Config.SeparateurHeuresMinutesAlpha:=':';
         Config.SeparateurMinutesSecondesAlpha:=':';
         Config.UnitesSecondesAlpha:=' ';
         end;
       end;

    // 75d45m02s
    // 75d45m02
    // 75°45'02"
    // 75°45'02
    Config.TypeSeparateurDelta:=ComboBoxDeltaSep.ItemIndex;
    case ComboBoxDeltaSep.ItemIndex of
       0:begin
         Config.SeparateurDegresMinutesDelta:='d';
         Config.SeparateurMinutesSecondesDelta:='m';
         Config.UnitesSecondesDelta:='s';
         end;
       1:begin
         Config.SeparateurDegresMinutesDelta:='d';
         Config.SeparateurMinutesSecondesDelta:='m';
         Config.UnitesSecondesDelta:=' ';
         end;
       2:begin
         Config.SeparateurDegresMinutesDelta:='°';
         Config.SeparateurMinutesSecondesDelta:='''';
         Config.UnitesSecondesDelta:='"';
         end;
       3:begin
         Config.SeparateurDegresMinutesDelta:='°';
         Config.SeparateurMinutesSecondesDelta:='''';
         Config.UnitesSecondesDelta:=' ';
         end;
       end;

    Config.ImpulsionArriereRapide:=MyStrToFloat(NbreEditImpArrRap.Text);
    Config.ImpulsionArriereLente:=MyStrToFloat(NbreEditImpArrLent.Text);
    Config.StabilisationRapide:=MyStrToFloat(NbreEditStabRap.Text);
    Config.StabilisationLente:=MyStrToFloat(NbreEditStabLent.Text);
    Config.ImpulsionAvantRapide:=MyStrToFloat(NbreEditImpAvRap.Text);
    Config.ImpulsionAvantLente:=MyStrToFloat(NbreEditImpAvLent.Text);
    Config.SurvitesseRapide:=MyStrToFloat(NbreEditSurRap.Text);
    Config.SurvitesseLente:=MyStrToFloat(NbreEditSurLent.Text);

    Config.DiametreExtreme:=MyStrToFloat(NbreEdit30.Text);
    Config.DiametreProche:=MyStrToFloat(NbreEdit31.Text);
    Config.MargeSecurite:=MyStrToFloat(NbreEdit32.Text);
    Config.DureeExtraction:=MyStrToFloat(NbreEdit33.Text);
    Config.VitesseRapide:=MyStrToFloat(NbreEdit34.Text);
    Config.VitesseLente:=MyStrToFloat(NbreEdit35.Text);
    Config.DureeImpulsionIncrementale:=MyStrToFloat(NbreEdit36.Text);
    Config.DureeMaxManoeuvre:=MyStrToFloat(NbreEdit37.Text);
    Config.UseVitesseRapide:=CheckBox2.Checked;
    Config.UseCmdCorrRapideAutoV:=CheckBox4.Checked;
    Config.UseCmdCorrLenteAutoV:=CheckBox5.Checked;

    Config.CloseQuery:=CheckBoxCloseQuery.Checked;
    Config.AskToCalibrate:=CheckBox14.Checked;
    Config.MsgFocuser:=CheckBox17.Checked;

    Config.HourServerComPort:=outComboBoxPortHS.Text;

    config.ErreurGoodTrack:=MyStrToFloat(NbreEdit29.Text);

    config.TypeMesureFWHM:=ComboBoxModel.ItemIndex;

    config.MaxPosFocuser:=SpinEdit11.Value;

    config.ErreurPositionGuidage:=MyStrToFloat(NbreEdit42.Text);
    config.ErreurAngleGuidage:=MyStrToFloat(NbreEdit43.Text);

    Config.TypeSeuil:=RadioGroup1.ItemIndex;

    Config.DomeUpdate:=CheckBox19.Checked;
    Config.DomeCoordUpdate:=MyStrToFloat(NbreEdit38.Text);

    Config.Verbose:=CheckBox20.Checked;
    Config.Periodic:=CheckBox21.Checked;
    Config.UseProfil:=CheckBox22.Checked;

    Config.DelaiFocOptim:=MyStrToFloat(Edit13.Text);
    Config.Tolerance:=MyStrToFloat(Edit19.Text);
    Config.FacteurInflation:=MyStrToFloat(Edit22.Text);
    Config.CorrectionOptim:=CheckBox23.Checked;

    Path:=LowerCase(ExtractFilePath(Application.ExeName));
    SaveParametres(Path+'TeleAuto.ini');  //nolang

    pop_main.UpdateGUITypeFichier;

//    Config.InPopConf:=False;
    Close;
end;

procedure Tpop_conf.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   // On rebranche les équipements
   try
   CameraConnect;
   except
   end;

   try
   CameraSuiviConnect;
   except
   end;


   try
   TelescopeConnect; //Connecter Telescope toujours avant focuseur !!!
   Config.Telescope:=Telescope.GetName;
   except
   end;

   try
   FocuserConnect;
   except
   end;

   try
   DomeConnect;
   except
   end;

   try
   HourServerConnect;
   except
   end;

   Config.InPopConf:=False;
   Action:=caFree;
end;

procedure tpop_conf.update_conf_edits;
var
   DistFast,DistSlow,Angle:Double;
begin
    UpdatingControls:=True;
    // mysql
    e_mysql_bin.text:=config.mysql_bin;
    e_mysql_engine.text:=config.mysql_engine;
    if fileexists(config.mysql_bin+'\'+config.mysql_engine) then
       begin
       mysql_led.color:=cllime;
       l_mysql_status.caption:='Online'; //nolang
       config.mysql_installed:=true;
       end
    else
       begin
       mysql_led.color:=clred;
       l_mysql_status.caption:='Offline'; //nolang
       config.mysql_installed:=false;
       end;

    Edit12.Text:=Config.MySqlHost;
    NbreEdit40.Text:=IntToStr(Config.MySqlPort);
    Edit17.Text:=Config.MySqlUserName;
    Edit18.Text:=Config.MySqlUserPassWord;
    CheckBox10.Checked:=Config.MySqlAskPassword;

    // park
    cb_park_real.checked:=config.park_physique;
    park_meridian.text:=config.park_meridien;
    dec_park.text:=config.park_decli;

//    Edit1.Text:=MyFloatToStr(config.SautDePuce,1);
    Edit3.Text:=MyFloatToStr(config.FocaleTele,2);
    Edit34.Text:=MyFloatToStr(config.Diametre,2);

    Angle:=Config.OrientationCCD;
    if (Config.TypeCamera=ST7) or (Config.TypeCamera=ST8) then
       if (Config.TypeCameraSuivi=STTrack) then
          begin
          if pop_camera_suivi.CheckBox2.Checked then Angle:=Angle+180;
          if Angle>180 then Angle:=Angle-360;
          if Angle<=-180 then Angle:=Angle+360;
          end;
    NbreEdit2.Text:=MyFloatToStr(Angle,2);

    Angle:=Config.OrientationCCDGuidage;
    if pop_camera_suivi.CheckBox2.Checked then Angle:=Angle+180;
    if Angle>180 then Angle:=Angle-360;
    if Angle<=-180 then Angle:=Angle+360;
    NbreEdit27.Text:=MyFloatToStr(Angle,2);

    NbreEdit3.Text:=MyFloatToStr(Config.Seeing,2);

    Edit4.Text:=MyFloatToStr(config.MinPose,3);
//    Edit5.Text:=MyFloatToStr(config.MaxPose,3);
    SpinEdit9.Value:=Round(config.Vitesse);
    Edit7.Text:=MyFloatToStr(config.DeltaMax,1);
    if config.TelescopeComPort='COM8' then //nolang
       outComboBox1.ItemIndex:=7
    else if config.TelescopeComPort='COM7' then //nolang
       outComboBox1.ItemIndex:=6
    else if config.TelescopeComPort='COM6' then //nolang
       outComboBox1.ItemIndex:=5
    else if config.TelescopeComPort='COM5' then //nolang
       outComboBox1.ItemIndex:=4
    else if config.TelescopeComPort='COM4' then //nolang
       outComboBox1.ItemIndex:=3
    else if config.TelescopeComPort='COM3' then //nolang
       outComboBox1.ItemIndex:=2
    else if config.TelescopeComPort='COM2' then //nolang
       outComboBox1.ItemIndex:=1
    else if config.TelescopeComPort='COM1' then //nolang
       outComboBox1.ItemIndex:=0;

    if config.AdresseComPort='3F8' then //nolang
       outComboBoxAdressCom.ItemIndex:=0
    else if config.AdresseComPort='2F8' then //nolang
       outComboBoxAdressCom.ItemIndex:=1
    else if config.AdresseComPort='3E8' then //nolang
       outComboBoxAdressCom.ItemIndex:=2
    else if config.AdresseComPort='2E8' then //nolang
       outComboBoxAdressCom.ItemIndex:=3;

    if config.MapComPort='COM8' then //nolang
       outComboBox2.ItemIndex:=7
    else if config.MapComPort='COM7' then //nolang
       outComboBox2.ItemIndex:=6
    else if config.MapComPort='COM6' then //nolang
       outComboBox2.ItemIndex:=5
    else if config.MapComPort='COM5' then //nolang
       outComboBox2.ItemIndex:=4
    else if config.MapComPort='COM4' then //nolang
       outComboBox2.ItemIndex:=3
    else if config.MapComPort='COM3' then //nolang
       outComboBox2.ItemIndex:=2
    else if config.MapComPort='COM2' then //nolang
       outComboBox2.ItemIndex:=1
    else if config.MapComPort='COM1' then //nolang
       outComboBox2.ItemIndex:=0;

    if Config.UseMoyenne then ComboBox1.Text:=lang('Moyenne')
    else ComboBox1.Text:=lang('Minimale');

    if config.HourServerComPort='COM8' then //nolang
       outComboBoxPortHS.ItemIndex:=7
    else if config.HourServerComPort='COM7' then //nolang
       outComboBoxPortHS.ItemIndex:=6
    else if config.HourServerComPort='COM6' then //nolang
       outComboBoxPortHS.ItemIndex:=5
    else if config.HourServerComPort='COM5' then //nolang
       outComboBoxPortHS.ItemIndex:=4
    else if config.HourServerComPort='COM4' then //nolang
       outComboBoxPortHS.ItemIndex:=3
    else if config.HourServerComPort='COM3' then //nolang
       outComboBoxPortHS.ItemIndex:=2
    else if config.HourServerComPort='COM2' then //nolang
       outComboBoxPortHS.ItemIndex:=1
    else if config.HourServerComPort='COM1' then //nolang
       outComboBoxPortHS.ItemIndex:=0;

    MaskLat.Text:=DeltaToStr(config.Lat);
    MaskLong.Text:=DeltaToStr(config.Long);
//    Edit12.Text:=MyFloatToStr(config.Lat,5);
//    Edit13.Text:=MyFloatToStr(config.Long,5);
    Edit14.Text:=MyFloatToStr(config.HauteurMini,0);
    Edit15.Text:=config.Profil;
    Edit16.Text:=MyFloatToStr(config.Attente,0);
    RadioGroup2.ItemIndex:=config.TypeCamera;
    RadioGroup11.ItemIndex:=config.TypeCameraSuivi;
    RadioGroup6.ItemIndex:=config.TypeFocuser;
    RadioGroupHS.ItemIndex:=config.TypeHourServer;
    RadioGroup3.ItemIndex:=config.FormatSaveInt;
    RadioGroup4.ItemIndex:=config.FormatCouleur;
//    CheckBox4.Checked:=config.TrackError;
    Edit11.Text:=IntToStr(config.ReadingDelai);
    Edit10.Text:=IntToStr(config.ReadingDelaiSuivi);    
{    if config.TypeUtilisation='Standalone' then RadioGroup1.ItemIndex:=0; //nolang
    if config.TypeUtilisation='Serveur' then RadioGroup1.ItemIndex:=1;    //nolang
    if config.TypeUtilisation='Client' then                               //nolang
       begin
           RadioGroup1.ItemIndex:=2;
           Label32.Enabled:=True;
           Edit17.Enabled:=True;
           Label33.Enabled:=True;
           Label34.Enabled:=True;
           Label35.Enabled:=True;
           Label36.Enabled:=True;
           Edit18.Enabled:=True;
           Edit19.Enabled:=True;
       end;
    Edit17.Text:=config.ServeurAdress;}
//    CheckBox5.Checked:=not(config.PointeFinal);
    CheckBox6.Checked:=config.MirrorX;
    CheckBox7.Checked:=config.MirrorY;
    CheckBox1.Checked:=config.MirrorXSuivi;
    CheckBox8.Checked:=config.MirrorYSuivi;
    SpinEdit1.Value:=config.PCMoinsTU;
    //CheckBox1.Checked:=config.UseRep;
    outPanel1.Caption:=comprimetexte(LowerCase(config.RepImagesAcq),30);
    outPanel2.Caption:=comprimetexte(LowerCase(config.RepOffsets),30);
    outPanel3.Caption:=comprimetexte(LowerCase(config.RepNoirs),30);
    outPanel4.Caption:=comprimetexte(LowerCase(config.RepPlus),30);
    outPanel7.Caption:=comprimetexte(LowerCase(config.RepGSC),30);
    outPanel8.Caption:=comprimetexte(LowerCase(config.RepCatalogsBase),30);
    outPanel9.Caption:=comprimetexte(LowerCase(config.RepTycho2),30);
    outPanel10.Caption:=comprimetexte(LowerCase(config.RepUsno),30);
    outPanel11.Caption:=comprimetexte(LowerCase(config.RepMicrocat),30);
    RadioGroup5.ItemIndex:=config.TypeGSC;
    SpinEdit3.Value:=config.NbEssaiFocFast;
    SpinEdit10.Value:=config.NbEssaiFocSlow;
    SpinEdit2.Value:=config.NbEssaiCentroMaxi;
    SpinEdit6.Value:=config.LargFoc*2+1; // Demi-Largeur -> Largeur
//    Edit42.Text:=MyFloatToStr(config.DelaiHysteresisFast,1);
//    Edit43.Text:=MyFloatToStr(config.DelaiHysteresisSlow,1);
//    Edit22.text:=MyFloatToStr(config.TempsMiniMoteur,1);
    Edit24.Text:=MyFloatToStr(config.DelaiFocFastInit,1);
    Edit30.Text:=MyFloatToStr(config.DelaiFocSlowInit,1);
    Edit25.Text:=MyFloatToStr(config.FwhmStopFast,1);
    Edit31.Text:=MyFloatToStr(config.FwhmStopSlow,1);
    Edit32.Text:=MyFloatToStr(config.DelaiFocFastMin,1);
    Edit33.Text:=MyFloatToStr(config.DelaiFocSlowMin,1);
    Edit29.Text:=config.ConfigPretrait.NomOffset;
    Edit28.Text:=config.ConfigPretrait.NomNoir;
    Edit27.Text:=config.ConfigPretrait.NomNoirFlat;
    Edit23.Text:=config.ConfigPretrait.NomFlat;
    EditCosmetic.Text:=config.ConfigPretrait.NomCosmetiques;
    RadioGroup10.ItemIndex:=Config.TypeTelescope;
    Edit35.Text:=config.Observatoire;
    Edit9.Text:=config.Observateur;
    Edit8.Text:=config.Filtre;

    Edit41.Text:=MyFloatToStr(config.Temperature,1);

    Edit1.Text:=MyFloatToStr(config.DelaiRattrapageSuiviNS,5);
    Edit44.Text:=MyFloatToStr(config.DelaiCalibrationSuiviNS,5);
    NbreEdit1.Text:=MyFloatToStr(config.CoefLimitationNS,2);

    Edit20.Text:=MyFloatToStr(config.Pose1,2);
    Edit26.Text:=MyFloatToStr(config.Pose2,2);
    Edit21.Text:=MyFloatToStr(config.Pose4,2);
    SpinEdit4.Value:=config.NbBouclage;
    outPageControl1.ActivePage:=outTabSheet1;
    Edit36.Text:=config.NameFilter[1];
    Edit37.Text:=config.NameFilter[2];
    Edit38.Text:=config.NameFilter[3];
    Edit39.Text:=config.NameFilter[4];
    Edit40.Text:=config.NameFilter[5];
    cb_coupe_ampli.checked:=config.CutAmpli;
    CheckBox9.checked:=config.CutAmpliSuivi;
//    if config.audine_obtu  then cb_obtu.checked:=true else cb_obtu.checked:=false;
    audine_obtu_text.text:=myfloattostr(config.ObtuCloseDelay,2);
    Edit47.text:=myfloattostr(config.ObtuCloseDelaySuivi,2);
    if config.UseTrackST7 then CheckBox15.Checked:=False else CheckBox15.Checked:=True;
    if config.UseDecalages then
       begin
       CheckBox16.Checked:=True;
       Button12.Enabled:=True;
       end
    else
       begin
       CheckBox16.Checked:=False;
       Button12.Enabled:=False;
       end;

    NbreEdit4.Text:=MyFloatToStr(config.SeuilBasPourCent,2);
    NbreEdit5.Text:=MyFloatToStr(config.SeuilHautPourCent,2);
    NbreEdit41.Text:=MyFloatToStr(Config.MultBas,2);
    NbreEdit26.Text:=MyFloatToStr(Config.MultHaut,2);
    RadioGroup12.ItemIndex:=config.SeuilCamera;
    NbreEdit24.Text:=MyFloatToStr(config.SeuilBasFixe,2);
    NbreEdit25.Text:=MyFloatToStr(config.SeuilHautFixe,2);

    NbreEdit6.Text:=IntToStr(config.ReadIntervalTimeout);
    NbreEdit7.Text:=IntToStr(config.ReadTotalTimeoutMultiplier);
    NbreEdit8.Text:=IntToStr(config.ReadTotalTimeoutConstant);
    NbreEdit9.Text:=IntToStr(config.WriteTotalTimeoutMultiplier);
    NbreEdit10.Text:=IntToStr(config.WriteTotalTimeoutConstant);

    NbreEdit1HS.Text:=IntToStr(config.HourServerReadIntervalTimeout);
    NbreEdit2HS.Text:=IntToStr(config.HourServerReadTotalTimeoutMultiplier);
    NbreEdit3HS.Text:=IntToStr(config.HourServerReadTotalTimeoutConstant);
    NbreEdit4HS.Text:=IntToStr(config.HourServerWriteTotalTimeoutMultiplier);
    NbreEdit5HS.Text:=IntToStr(config.HourServerWriteTotalTimeoutConstant);

    NbreEdit13.Text:=IntToStr(config.MapReadIntervalTimeout);
    NbreEdit14.Text:=IntToStr(config.MapReadTotalTimeoutMultiplier);
    NbreEdit15.Text:=IntToStr(config.MapReadTotalTimeoutConstant);
    NbreEdit16.Text:=IntToStr(config.MapWriteTotalTimeoutMultiplier);
    NbreEdit17.Text:=IntToStr(config.MapWriteTotalTimeoutConstant);

    NbreEdit11.Text:=MyFloatToStr(config.ErreurPointingAlpha,3);
    NbreEdit12.Text:=MyFloatToStr(config.ErreurPointingDelta,3);

    RadioGroup13.ItemIndex:=config.TypeSaveFits;

    NbreEdit18.Text:=MyFloatToStr(config.DelaiVidage,2);
    NbreEdit19.Text:=MyFloatToStr(config.DelaiVidageSuivi,2);

    SpinEdit7.Value:=config.JpegQuality;

    RadioGroup8.ItemIndex:=config.FormeModelePhotometrie-1;
    SpinEdit5.Value:=config.DegreCielPhotometrie;
    SpinEdit8.Value:=config.LargModelisePhotometrie;
    SpinEdit12.Value:=Config.ApertureInt;
    SpinEdit13.Value:=Config.ApertureOut;
    SpinEdit14.Value:=Config.ApertureMid;    

    if Config.AdresseCamera=$378 then outComboBox3.ItemIndex:=0;
    if Config.AdresseCamera=$278 then outComboBox3.ItemIndex:=1;
    if Config.AdresseCamera=$3BC then outComboBox3.ItemIndex:=2;

    if Config.AdresseCameraSuivi=$378 then outComboBox4.ItemIndex:=0;
    if Config.AdresseCameraSuivi=$278 then outComboBox4.ItemIndex:=1;
    if Config.AdresseCameraSuivi=$3BC then outComboBox4.ItemIndex:=2;

    Edit2.Text:=config.CameraPlugin;
    Edit5.Text:=config.FocuserPlugin;    
    Edit46.Text:=config.CameraPluginSuivi;
    Edit6.Text:=config.DomePlugin;

    RadioGroup9.ItemIndex:=config.TypeDome;

    NbreEdit20.text:=myfloattostr(config.Webcam_pixelsizeX,2);
    NbreEdit21.text:=myfloattostr(config.Webcam_pixelsizeY,2);

//    CheckBox2.Checked:=config.CCDOriente;
//    CheckBox10.Checked:=config.CCDTrackOriente;

    CheckBox3.Checked:=config.MesureParSuperStar;
    CheckBox11.Checked:=config.MesureParReference;
    CheckBox12.Checked:=config.MesureParRegressionLineaire;

    CheckBox13.Checked:=Config.UseLongFormat;
    CheckBox18.Checked:=Config.Allemande;

    ComboBoxAlphaSep.ItemIndex:=Config.TypeSeparateurAlpha;
    ComboBoxDeltaSep.ItemIndex:=Config.TypeSeparateurDelta;

    CheckBoxInvFoc.Checked:=Config.FocInversion;
    CheckBoxCorFast.Checked:=Config.CorrectionAutoFast;
    CheckBoxCorSlow.Checked:=Config.CorrectionAutoSlow;

    NbreEditImpArrRap.Text:=MyFloatToStr(Config.ImpulsionArriereRapide,2);
    NbreEditImpArrLent.Text:=MyFloatToStr(Config.ImpulsionArriereLente,2);
    NbreEditStabRap.Text:=MyFloatToStr(Config.StabilisationRapide,2);
    NbreEditStabLent.Text:=MyFloatToStr(Config.StabilisationLente,2);
    NbreEditImpAvRap.Text:=MyFloatToStr(Config.ImpulsionAvantRapide,2);
    NbreEditImpAvLent.Text:=MyFloatToStr(Config.ImpulsionAvantLente,2);
    NbreEditSurRap.Text:=MyFloatToStr(Config.SurvitesseRapide,2);
    NbreEditSurLent.Text:=MyFloatToStr(Config.SurvitesseLente,2);

    NbreEdit30.Text:=MyFloatToStr(Config.DiametreExtreme,1);
    NbreEdit31.Text:=MyFloatToStr(Config.DiametreProche,1);
    NbreEdit32.Text:=MyFloatToStr(Config.MargeSecurite,1);
    NbreEdit33.Text:=MyFloatToStr(Config.DureeExtraction,1);
    NbreEdit34.Text:=MyFloatToStr(Config.VitesseRapide,2);
    NbreEdit35.Text:=MyFloatToStr(Config.VitesseLente,2);
    NbreEdit36.Text:=MyFloatToStr(Config.DureeImpulsionIncrementale,0);
    NbreEdit37.Text:=MyFloatToStr(Config.DureeMaxManoeuvre,0);
    CheckBox2.Checked:=Config.UseVitesseRapide;
    CheckBox4.Checked:=Config.UseCmdCorrRapideAutoV;
    CheckBox5.Checked:=Config.UseCmdCorrLenteAutoV;

    CheckBoxCloseQuery.Checked:=Config.CloseQuery;
    CheckBox14.Checked:=Config.AskToCalibrate;
    CheckBox17.Checked:=Config.MsgFocuser;

    NbreEdit29.Text:=MyFloatToStr(config.ErreurGoodTrack,2);

    if config.TypeMesureFWHM=2 then config.TypeMesureFWHM:=1;
    ComboBoxModel.ItemIndex:=config.TypeMesureFWHM;
    UpdateStop;

    SpinEdit11.Value:=config.MaxPosFocuser;

    NbreEdit42.Text:=MyFloatToStr(config.ErreurPositionGuidage,2);
    NbreEdit43.Text:=MyFloatToStr(config.ErreurAngleGuidage,2);

    RadioGroup1.ItemIndex:=Config.TypeSeuil;

    CheckBox19.Checked:=Config.DomeUpdate;
    NbreEdit38.Text:=MyFloatToStr(Config.DomeCoordUpdate,2);

    CheckBox20.Checked:=Config.Verbose;
    CheckBox21.Checked:=Config.Periodic;
    CheckBox22.Checked:=Config.UseProfil;

    Edit13.Text:=MyFloatToStr(Config.DelaiFocOptim,2);
    Edit19.Text:=MyFloatToStr(Config.Tolerance,2);
    Edit22.Text:=MyFloatToStr(Config.FacteurInflation,2);
    CheckBox23.Checked:=Config.CorrectionOptim;

    UpdatingControls:=False;

    UpdateFWHM;

    UpdateCameraConf;
    UpdateCameraSuiviConf;
    UpdateScope;
    UpdateFocuser;
    UpdateDome;
    UdpateHourServer;
end;


procedure Tpop_conf.Button1Click(Sender: TObject);
begin
    PBFolderDialog1.Folder:=config.RepImagesAcq;
    if PBFolderDialog1.Execute then
       if Length(PBFolderDialog1.Folder)<>0 then
          begin
          config.RepImagesAcq:=PBFolderDialog1.Folder;
          if (config.RepImagesAcq[Length(config.RepImagesAcq)]<>'\') then
             config.RepImagesAcq:=config.RepImagesAcq+'\';
          outPanel1.Caption:=comprimetexte(config.RepImagesAcq,30);
          end;
end;

procedure Tpop_conf.Button2Click(Sender: TObject);
begin
PBFolderDialog1.Folder:=config.RepOffsets;
if  PBFolderDialog1.Execute then
   if Length(PBFolderDialog1.Folder)<>0 then
      begin
      config.RepOffsets:=PBFolderDialog1.Folder;
      if (config.RepOffsets[Length(config.RepOffsets)]<>'\') then
         config.RepOffsets:=config.RepOffsets+'\';
      outPanel2.Caption:=comprimetexte(config.RepOffsets,30);
      end;
end;

procedure Tpop_conf.Button3Click(Sender: TObject);
begin
PBFolderDialog1.Folder:=config.RepNoirs;
if PBFolderDialog1.Execute then
   if Length(PBFolderDialog1.Folder)<>0 then
      begin
      config.RepNoirs:=PBFolderDialog1.Folder;
      if (config.RepNoirs[Length(config.RepNoirs)]<>'\') then
         config.RepNoirs:=config.RepNoirs+'\';
      outPanel3.Caption:=comprimetexte(config.RepNoirs,30);
      end;
end;

procedure Tpop_conf.Button4Click(Sender: TObject);
begin
PBFolderDialog1.Folder:=config.RepPlus;
if PBFolderDialog1.Execute then
   if Length(PBFolderDialog1.Folder)<>0 then
      begin
      config.RepPlus:=PBFolderDialog1.Folder;
      if (config.RepPlus[Length(config.RepPlus)]<>'\') then
         config.RepPlus:=config.RepPlus+'\';
      outPanel4.Caption:=comprimetexte(config.RepPlus,30);
      end;
end;

procedure Tpop_conf.Button5Click(Sender: TObject);
begin
config.RepOffsets  :=config.RepImagesAcq;
config.RepNoirs    :=config.RepImagesAcq;
config.RepPlus     :=config.RepImagesAcq;
outPanel2.Caption:=comprimetexte(config.RepOffsets,30);
outPanel3.Caption:=comprimetexte(config.RepNoirs,30);
outPanel4.Caption:=comprimetexte(config.RepPlus,30);
end;

procedure Tpop_conf.btn_loadClick(Sender: TObject);
var
Path:string;
begin
Path:=LowerCase(ExtractFilePath(Application.ExeName));
load_config.initialdir:=Path;
load_config.Filter:=lang('Fichiers *.ini|*.ini');
if load_config.execute then
   if messagedlg(lang('Changer toute la configuration ?'),mtwarning,[mbyes,mbno],0)=mryes then
      begin
      // charge la nouvelle configuration
      LoadParametres(load_config.FileName);
      update_conf_edits;
      end;
end;

procedure Tpop_conf.btn_saveClick(Sender: TObject);
var
Path,Name:string;
begin
Path:=LowerCase(ExtractFilePath(Application.ExeName));
save_config.initialdir:=Path;
if save_config.execute then
   begin
   if messagedlg(lang('Enregistrer la configuration actuelle ?'),mtconfirmation,[mbyes,mbno],0)=mryes then
      begin
      Name:=save_config.filename;
      if UpperCase(ExtractFileExt(Name))<>'.INI' then Name:=Name+'.ini'; //nolang
      SaveParametres(Name);
      end;
   end;
end;

procedure SaveParametres(FileName:string);
var
   Ini:TMemIniFile;
   FText:TextFile;
   Path:string;
begin
Ini:=TMemIniFile.Create(FileName);

try
// mysql
ini.writestring('MySQL','bin',config.mysql_bin);
ini.writestring('MySQL','engine',config.mysql_engine);
ini.writestring('MySQL','Host',Config.MySqlHost);
ini.writestring('MySQL','Port',IntToStr(Config.MySqlPort));
ini.writestring('MySQL','UserName',Config.MySqlUserName);
ini.writestring('MySQL','UserPassWord',Config.MySqlUserPassWord);
if Config.MySqlAskPassword then ini.writestring('MySQL','AskPassWord','oui')
else ini.writestring('MySQL','AskPassWord','non');

{park/unpark}
if config.park_physique then Ini.writestring('Park','Physique','oui') else
                             ini.writestring('Park','Physique','non');
ini.writestring('Park','Meridien',config.park_meridien);
ini.writestring('Park','Declinaison',config.park_decli);
{telescope}
//Ini.WriteString('Telescope','DeplaceMaxi',FloatToStr(config.SautDePuce));
Ini.WriteString('Telescope','Focale',FloatToStr(config.FocaleTele));
Ini.WriteString('Telescope','Diametre',FloatToStr(config.Diametre));
Ini.WriteString('CCD','OrientationCCD',FloatToStr(config.OrientationCCD));
Ini.WriteString('Suivi','OrientationCCDGuidage',FloatToStr(config.OrientationCCDGuidage));
Ini.WriteString('Suivi','VitesseGuidageApparenteDelta',FloatToStr(Config.VitesseGuidageApparenteDelta));
Ini.WriteString('Suivi','VitesseGuidageReelleDelta',FloatToStr(Config.VitesseGuidageReelleDelta));
Ini.WriteString('Suivi','VitesseGuidageApparenteAlpha',FloatToStr(config.VitesseGuidageApparenteAlpha));
Ini.WriteString('Soft','Seeing',FloatToStr(config.Seeing));
Ini.WriteString('Telescope','Vitesse',FloatToStr(config.Vitesse));
Ini.WriteString('Telescope','DeltaMaxi',FloatToStr(config.DeltaMax));
Ini.WriteString('Telescope','HauteurMini',FloatToStr(config.HauteurMini));
Ini.WriteString('Telescope','DecalAlpha',FloatToStr(config.DecalAlpha));
Ini.WriteString('Telescope','DecalDelta',FloatToStr(config.DecalDelta));
//Ini.WriteString('Telescope','Type',config.Telescope);
{CCD}
//Ini.WriteString('CCD','TaillePixel',FloatToStr(config.SizePixel));
Ini.WriteString('CCD','PoseMini',FloatToStr(config.MinPose));
//Ini.WriteString('CCD','PoseMaxi',FloatToStr(config.MaxPose));
//Ini.WriteString('CCD','Saturation',FloatToStr(config.Satur));
Ini.WriteString('CCD','TypeCamera',IntToStr(config.TypeCamera));
Ini.WriteString('Suivi','TypeCamera',IntToStr(config.TypeCameraSuivi));
Ini.WriteString('Telescope','TypeTelescope',IntToStr(config.TypeTelescope));
Ini.WriteString('Focuser','TypeFocuser',IntToStr(config.TypeFocuser));
Ini.WriteString('HourServer','TypeHourServer',IntToStr(config.TypeHourServer));
Ini.WriteString('Soft','FormatSaveInt',IntToStr(config.FormatSaveInt));
Ini.WriteString('Soft','FormatCouleur',IntToStr(config.FormatCouleur));
Ini.WriteString('CCD','Delai',IntToStr(config.ReadingDelai));
Ini.WriteString('Suivi','Delai',IntToStr(config.ReadingDelaiSuivi));
if config.MirrorX then Ini.WriteString('CCD','MirrorX','Oui')
else Ini.WriteString('CCD','MirrorX','Non');
if config.MirrorY then Ini.WriteString('CCD','MirrorY','Oui')
else Ini.WriteString('CCD','MirrorY','Non');
if config.MirrorXSuivi then Ini.WriteString('Suivi','MirrorX','Oui')
else Ini.WriteString('Suivi','MirrorX','Non');
if config.MirrorYSuivi then Ini.WriteString('Suivi','MirrorY','Oui')
else Ini.WriteString('Suivi','MirrorY','Non');
Ini.WriteString('CCD','Pose1',FloatToStr(config.Pose1));
Ini.WriteString('CCD','Pose2',FloatToStr(config.Pose2));
Ini.WriteString('CCD','Pose4',FloatToStr(config.Pose4));
Ini.WriteString('CCD','NbBouclage',IntToStr(config.NbBouclage));
Ini.WriteString('CCD','Filtre',config.Filtre);
Ini.Writestring('CCD','Temperature',floattostr(config.temperature));

if config.CutAmpli then ini.writestring('CCD','AudineAmpli','oui') else
                     ini.writestring('CCD','AudineAmpli','non');
if config.CutAmpliSuivi then ini.writestring('Suivi','AudineAmpli','oui') else
                     ini.writestring('Suivi','AudineAmpli','non');
ini.writestring ('CCD','ObtuCloseDelay',floattostr(config.ObtuCloseDelay));
ini.writestring ('Suivi','ObtuCloseDelay',floattostr(config.ObtuCloseDelaySuivi));
{FILTRE}
Ini.WriteString('Filtre','Filtre1',config.NameFilter[1]);
Ini.WriteString('Filtre','Filtre2',config.NameFilter[2]);
Ini.WriteString('Filtre','Filtre3',config.NameFilter[3]);
Ini.WriteString('Filtre','Filtre4',config.NameFilter[4]);
Ini.WriteString('Filtre','Filtre5',config.NameFilter[5]);

{SOFT}
Ini.WriteString('Soft','Port',config.TelescopeComPort);
Ini.WriteString('Soft','AdressPort',config.AdresseComPort);
Ini.WriteString('Focuser','Port',config.MapComPort);
Ini.WriteString('HourServer','Port',config.HourServerComPort);
Ini.WriteString('Site','Latitude',FloatToStr(config.Lat));
Ini.WriteString('Site','Longitude',FloatToStr(config.Long));
Ini.WriteString('Site','Profil',config.Profil);
Ini.WriteString('Soft','Attente',FloatToStr(config.Attente));
//if config.TrackError then Ini.WriteString('Soft','TrackError','Oui')
//                     else Ini.WriteString('Soft','TrackError','Non');
if config.keep_in_profile then Ini.WriteString('Soft','StayInProfile','Oui')
                            else Ini.WriteString('Soft','StayInProfile','Non');
//Ini.WriteString('Soft','Utilisation',config.TypeUtilisation);
//Ini.WriteString('Soft','ServeurAdress',config.ServeurAdress);
//if config.PointeFinal then Ini.WriteString('Soft','PointeFinal','Oui')
//else Ini.WriteString('Soft','PointeFinal','Non');
Ini.WriteString('Soft','PCMoinsTU',IntToStr(config.PCMoinsTU));
//if config.UseRep then Ini.WriteString('Soft','UseRep','Oui')
//else Ini.WriteString('Soft','UseRep','Non');
Ini.WriteString('Soft','RepImages',config.RepImages);
Ini.WriteString('Soft','RepOffsets',config.RepOffsets);
Ini.WriteString('Soft','RepNoirs',config.RepNoirs);
Ini.WriteString('Soft','RepPlus',config.RepPlus);
Ini.WriteString('Soft','RepImagesAcq',config.RepImagesAcq);
Ini.WriteString('Soft','Observatoire',config.Observatoire);

Ini.WriteString('Soft','Observateur',config.Observateur);
Ini.WriteString('Soft','Language',config.Language);

{MAP}
Ini.WriteString('MAP','NbEssaiCentroMaxi',IntToStr(config.NbEssaiCentroMaxi));
Ini.WriteString('MAP','NbEssaiFocFast',IntToStr(config.NbEssaiFocFast));
Ini.WriteString('MAP','NbEssaiFocSlow',IntToStr(config.NbEssaiFocSlow));
Ini.WriteString('MAP','LargFoc',IntToStr(config.LargFoc));
Ini.WriteString('MAP','DelaiFocFastInit',FloatToStr(config.DelaiFocFastInit));
Ini.WriteString('MAP','DelaiFocSlowInit',FloatToStr(config.DelaiFocSlowInit));
Ini.WriteString('MAP','FwhmStopFast',FloatToStr(config.FwhmStopFast));
Ini.WriteString('MAP','FwhmStopSlow',FloatToStr(config.FwhmStopSlow));
Ini.WriteString('MAP','DelaiFocFastMin',FloatToStr(config.DelaiFocFastMin));
Ini.WriteString('MAP','DelaiFocSlowMin',FloatToStr(config.DelaiFocSlowMin));
if Config.FocInversion then ini.writestring('MAP','FocInversion','Oui')
else ini.writestring('MAP','FocInversion','Non');
if Config.UseMoyenne then ini.writestring('MAP','UseMean','Oui')
else ini.writestring('MAP','UseMean','Non');
if Config.CorrectionAutoFast then ini.writestring('MAP','CorrectAutoFast','Oui')
else ini.writestring('MAP','CorrectAutoFast','Non');
if Config.CorrectionAutoSlow then ini.writestring('MAP','CorrectAutoSlow','Oui')
else ini.writestring('MAP','CorrectAutoSlow','Non');
ini.writestring('MAP','TypeMeasureFWHM',IntToStr(Config.TypeMesureFWHM));
Ini.WriteString('MAP','MaxPosFocuser',IntToStr(config.MaxPosFocuser));
Ini.WriteString('MAP','DelaiFocOptim',FloatToStr(config.DelaiFocOptim));
Ini.WriteString('MAP','Tolerance',FloatToStr(config.Tolerance));
Ini.WriteString('MAP','FacteurInflation',FloatToStr(config.FacteurInflation));
if Config.CorrectionOptim then ini.writestring('MAP','CorrectionOptim','Oui')
else ini.writestring('MAP','CorrectionOptim','Non');

// Catalogues
Ini.WriteString('Catalogs','GSC',config.RepGSC); //nolang
Ini.WriteString('Catalogs','Base',config.RepCatalogsBase); //nolang
Ini.WriteString('Catalogs','Tycho2',config.RepTycho2); //nolang
Ini.WriteString('Catalogs','USNO',config.RepUSNO); //nolang
Ini.WriteString('Catalogs','Microcat',config.RepMicrocat); //nolang
Ini.WriteInteger('Catalogs','TypeGSC',config.TypeGSC); //nolang

// Recentrage
if config.CalibrateRecentrage then ini.writestring('Center','Calibrate','Oui')
else ini.writestring('Center','Calibrate','Non');
ini.writestring('Center','VectorNorthX',FloatToStr(config.VecteurNordXRecentrage));
ini.writestring('Center','VectorNorthY',FloatToStr(config.VecteurNordYRecentrage));
ini.writestring('Center','VectorSouthX',FloatToStr(config.VecteurSudXRecentrage));
ini.writestring('Center','VectorSouthY',FloatToStr(config.VecteurSudYRecentrage));
ini.writestring('Center','VectorEastX',FloatToStr(config.VecteurEstXRecentrage));
ini.writestring('Center','VectorEastY',FloatToStr(config.VecteurEstYRecentrage));
ini.writestring('Center','VectorWestX',FloatToStr(config.VecteurOuestXRecentrage));
ini.writestring('Center','VectorWestY',FloatToStr(config.VecteurOuestYRecentrage));
Ini.writeString('Center','DelayCalibration',FloatToStr(config.DelaiCalibrationRecentrage));
Ini.writeString('Center','Delta',FloatToStr(config.DeltaRecentrage));
Ini.writeString('Center','Iterations',IntToStr(config.IterRecentrage));

// Recentrage Guidage
if config.CalibrateRecentrageSuivi then ini.writestring('CenterTrack','Calibrate','Oui')
else ini.writestring('CenterTrack','Calibrate','Non');
ini.writestring('CenterTrack','VectorNorthX',FloatToStr(config.VecteurNordXRecentrageSuivi));
ini.writestring('CenterTrack','VectorNorthY',FloatToStr(config.VecteurNordYRecentrageSuivi));
ini.writestring('CenterTrack','VectorSouthX',FloatToStr(config.VecteurSudXRecentrageSuivi));
ini.writestring('CenterTrack','VectorSouthY',FloatToStr(config.VecteurSudYRecentrageSuivi));
ini.writestring('CenterTrack','VectorEastX',FloatToStr(config.VecteurEstXRecentrageSuivi));
ini.writestring('CenterTrack','VectorEastY',FloatToStr(config.VecteurEstYRecentrageSuivi));
ini.writestring('CenterTrack','VectorWestX',FloatToStr(config.VecteurOuestXRecentrageSuivi));
ini.writestring('CenterTrack','VectorWestY',FloatToStr(config.VecteurOuestYRecentrageSuivi));
//Ini.writeString('CenterTrack','DelayCalibration',FloatToStr(config.DelaiCalibrationRecentrageSuivi));
Ini.writeString('CenterTrack','Delta',FloatToStr(config.DeltaRecentrageSuivi));
Ini.writeString('CenterTrack','Iterations',IntToStr(config.IterRecentrageSuivi));

// Tracking
if config.CalibrateSuivi then ini.writestring('Tracking','Calibrate','Oui')
else ini.writestring('Tracking','Calibrate','Non');
if config.Limite then ini.writestring('Tracking','Limite','Oui')
else ini.writestring('Tracking','Limite','Non');
if config.UseTrackSt7 then ini.writestring('Tracking','UseTrackSt7','Oui')
else ini.writestring('Tracking','UseTrackSt7','Non');

if config.UseDecalages then ini.writestring('Tracking','UseDecalages','Oui')
else ini.writestring('Tracking','UseDecalages','Non');

ini.writestring('Tracking','VecteurNordX',FloatToStr(config.VecteurNordX));
ini.writestring('Tracking','VecteurNordY',FloatToStr(config.VecteurNordY));
ini.writestring('Tracking','VecteurSudX',FloatToStr(config.VecteurSudX));
ini.writestring('Tracking','VecteurSudY',FloatToStr(config.VecteurSudY));
ini.writestring('Tracking','VecteurEstX',FloatToStr(config.VecteurEstX));
ini.writestring('Tracking','VecteurEstY',FloatToStr(config.VecteurEstY));
ini.writestring('Tracking','VecteurOuestX',FloatToStr(config.VecteurOuestX));
ini.writestring('Tracking','VecteurOuestY',FloatToStr(config.VecteurOuestY));
Ini.writeString('Tracking','DelaiRattrapageNS',FloatToStr(config.DelaiRattrapageSuiviNS));
Ini.writeString('Tracking','DelaiCalibrationNS',FloatToStr(config.DelaiCalibrationSuiviNS));
Ini.writeString('Tracking','DelaiCalibrationEO',FloatToStr(config.DelaiCalibrationSuiviEO));
Ini.writeString('Tracking','DeltaSuivi',FloatToStr(Config.DeltaSuivi));
Ini.writeString('Tracking','AHSuivi',FloatToStr(Config.AHSuivi));
//if config.DeltaSuiviAuto then ini.writestring('Tracking','DeltaSuiviAuto','Oui')
//else ini.writestring('Tracking','DeltaSuiviAuto','Non');
Ini.writeString('Tracking','CoefLimitationNS',FloatToStr(config.CoefLimitationNS));
Ini.writeString('Tracking','CoefLimitationEO',FloatToStr(config.CoefLimitationEO));
Ini.writeString('Tracking','ErrorGoodTrack',FloatToStr(config.ErreurGoodTrack));
Ini.writeString('Tracking','TrackPosError',FloatToStr(config.ErreurPositionGuidage));
Ini.writeString('Tracking','TrackAngleError',FloatToStr(config.ErreurAngleGuidage));

Path:=ExtractFilePath(Application.ExeName);
{if config.TrackError then
   if not(FileExists(Path+'AimError.txt')) then //nolang
      begin
      AssignFile(FText,Path+'AimError.txt'); //nolang
      Rewrite(FText);
      CloseFile(FText);
      end;}
{Pointage}
Ini.WriteString('Pointage','DelaiCalibration',FloatToStr(config.DelaiCalibrationPointage));
ini.writestring('Pointage','VecteurNordX',FloatToStr(config.VecteurNordXPointe));
ini.writestring('Pointage','VecteurNordY',FloatToStr(config.VecteurNordYPointe));
ini.writestring('Pointage','VecteurSudX',FloatToStr(config.VecteurSudXPointe));
ini.writestring('Pointage','VecteurSudY',FloatToStr(config.VecteurSudYPointe));
ini.writestring('Pointage','VecteurEstX',FloatToStr(config.VecteurEstXPointe));
ini.writestring('Pointage','VecteurEstY',FloatToStr(config.VecteurEstYPointe));
ini.writestring('Pointage','VecteurOuestX',FloatToStr(config.VecteurOuestXPointe));
ini.writestring('Pointage','VecteurOuestY',FloatToStr(config.VecteurOuestYPointe));

if config.InversionNS then ini.writestring('Telescope','InversionNS','Oui')
else ini.writestring('Telescope','InversionNS','Non');
if config.InversionEO then ini.writestring('Telescope','InversionEO','Oui')
else ini.writestring('Telescope','InversionEO','Non');
{script}
// criteres de recherche
ini.writestring('Script','MagHigh',MyFloatTostr(config.mag_hi,1));
ini.writestring('Script','MagLow',MyFloatTostr(config.mag_lo,1));
ini.writestring('Script','SizeHigh',MyFloatTostr(config.size_hi,1));
ini.writestring('Script','SizeLow',MyFloatTostr(config.size_lo,1));
ini.writestring('Script','ObjetType',inttostr(config.type_objet));
ini.writestring('Script','ObjetDist',inttostr(config.distance_objet));
// limites optimiseur
if config.azimut_active=true then ini.writestring('Script','AzimutLimit','oui') else
                           ini.writestring('Script','AzimutLimit','non');
ini.writestring('Script','AzimutHigh',MyFloatToStr(config.azimut_max,1));
ini.writestring('Script','AzimutLow',MyFloatToStr(config.azimut_min,1));

if config.hauteur_active then ini.writestring('Script','HauteurLimit','oui') else
                       ini.writestring('Script','HauteurLimit','non');
ini.writestring('Script','HauteurHigh',MyFloatToStr(config.hauteur_max,1));
ini.writestring('Script','HauteurLow',MyFloatToStr(config.hauteur_min,1));

if config.moon_active=true then ini.writestring('Script','MoonLimit','oui') else
                         ini.writestring('Script','MoonLimit','non');
ini.writestring('Script','MoonDist',Myfloattostr(config.moon_min_distance,1));
ini.writestring('Script','MoonBright',Myfloattostr(config.moon_brightness,1));
Ini.WriteString('Soft','JpegQuality',IntToStr(config.JpegQuality));

// Pretraitements
if Config.ConfigPretrait.CreeOffset then Ini.WriteString('Preprocessing','CreateOffset','Oui')
else Ini.Writestring('Preprocessing','CreateOffset','Non');
if Config.ConfigPretrait.UsePreviousFiles then Ini.WriteString('Preprocessing','UsePreviousFiles','Oui')
else Ini.Writestring('Preprocessing','UsePreviousFiles','Non');
if Config.ConfigPretrait.EnleveOffsetAuxNoirs then Ini.WriteString('Preprocessing','SubOffsetToBlacks','Oui')
else Ini.Writestring('Preprocessing','SubOffsetToBlacks','Non');
if Config.ConfigPretrait.CreeNoir then Ini.WriteString('Preprocessing','CreateBlack','Oui')
else Ini.Writestring('Preprocessing','CreateBlack','Non');
if Config.ConfigPretrait.EnleveOffsetAuxNoirsFlats then Ini.WriteString('Preprocessing','SubOffsetToBlacksFlats','Oui')
else Ini.Writestring('Preprocessing','SubOffsetToBlacksFlats','Non');
if Config.ConfigPretrait.CreeNoirFlats then Ini.WriteString('Preprocessing','CreateBlackFlats','Oui')
else Ini.Writestring('Preprocessing','CreateBlackFlats','Non');
if Config.ConfigPretrait.EnleveOffsetAuxFlats then Ini.WriteString('Preprocessing','SubOffsetToFlats','Oui')
else Ini.Writestring('Preprocessing','SubOffsetToFlats','Non');
if Config.ConfigPretrait.EnleveNoirsFlatsAuxFlats then Ini.WriteString('Preprocessing','SubBlacksFlatsToFlats','Oui')
else Ini.Writestring('Preprocessing','SubBlacksFlatsToFlats','Non');
if Config.ConfigPretrait.MoyenneIdentiqueDesFlats then Ini.WriteString('Preprocessing','SameMeanFlats','Oui')
else Ini.Writestring('Preprocessing','SameMeanFlats','Non');
if Config.ConfigPretrait.CreeFlat then Ini.WriteString('Preprocessing','CreateFlat','Oui')
else Ini.Writestring('Preprocessing','CreateFlat','Non');
if Config.ConfigPretrait.EnleveOffsetAuxImages then Ini.WriteString('Preprocessing','SubOffsetToImages','Oui')
else Ini.Writestring('Preprocessing','SubOffsetToImages','Non');
if Config.ConfigPretrait.EnleveNoirAuxImages then Ini.WriteString('Preprocessing','SubBlackToImages','Oui')
else Ini.Writestring('Preprocessing','SubBlackToImages','Non');
if Config.ConfigPretrait.CorrigeImagesDuFlat then Ini.WriteString('Preprocessing','CorrectImagesFlat','Oui')
else Ini.Writestring('Preprocessing','CorrectImagesFlat','Non');
if Config.ConfigPretrait.RecaleImages then Ini.WriteString('Preprocessing','AlignImages','Oui')
else Ini.Writestring('Preprocessing','AlignImages','Non');
if Config.ConfigPretrait.CompositeImages then Ini.WriteString('Preprocessing','AddImages','Oui')
else Ini.Writestring('Preprocessing','AddImages','Non');
if Config.ConfigPretrait.SupprimmerImages then Ini.WriteString('Preprocessing','DelTempImages','Oui')
else Ini.Writestring('Preprocessing','DelTempImages','Non');
if Config.ConfigPretrait.CorrigeCosmetique then Ini.WriteString('Preprocessing','CorrectCosmetics','Oui')
else Ini.Writestring('Preprocessing','CorrectCosmetics','Non');
if Config.ConfigPretrait.AppliqueMedian then Ini.WriteString('Preprocessing','ApplyMedian','Oui')
else Ini.Writestring('Preprocessing','ApplyMedian','Non');
if Config.ConfigPretrait.OptimiseNoir then Ini.WriteString('Preprocessing','OptimizeDark','Oui')
else Ini.Writestring('Preprocessing','OptimizeDark','Non');
Ini.WriteString('Preprocessing','TypeCreateOffset',IntToStr(Config.ConfigPretrait.TypeCreationOffset));
Ini.WriteString('Preprocessing','TypeCreateBlack',IntToStr(Config.ConfigPretrait.TypeCreationNoir));
Ini.WriteString('Preprocessing','TypeCreateFlat',IntToStr(Config.ConfigPretrait.TypeCreationFlat));
Ini.WriteString('Preprocessing','TypeCreateNoirFlat',IntToStr(Config.ConfigPretrait.TypeCreationNoirFlat));
Ini.WriteString('Preprocessing','TypeAlignImage',IntToStr(Config.ConfigPretrait.TypeRecalageImages));
Ini.WriteString('Preprocessing','TypeAddImages',IntToStr(Config.ConfigPretrait.TypeCompositageImages));
Ini.Writestring('Preprocessing','NbSigmaOffset',FloatToStr(Config.ConfigPretrait.NbSigmaOffset));
Ini.Writestring('Preprocessing','ErrorRealignImg',FloatToStr(Config.ConfigPretrait.ErreurRecaleImages));
Ini.Writestring('Preprocessing','NbSigmaNoir',FloatToStr(Config.ConfigPretrait.NbSigmaNoir));
Ini.Writestring('Preprocessing','NbSigmaFlat',FloatToStr(Config.ConfigPretrait.NbSigmaFlat));
Ini.Writestring('Preprocessing','NbSigmaNoirFlat',FloatToStr(Config.ConfigPretrait.NbSigmaNoirFlat));
Ini.Writestring('Preprocessing','NbSigmaImage',FloatToStr(Config.ConfigPretrait.NbSigmaImage));
Ini.Writestring('Preprocessing','NomOffset',Config.ConfigPretrait.NomOffset);
Ini.Writestring('Preprocessing','NomNoir',Config.ConfigPretrait.NomNoir);
Ini.Writestring('Preprocessing','NomNoirFlat',Config.ConfigPretrait.NomNoirFlat);
Ini.Writestring('Preprocessing','NomFlat',Config.ConfigPretrait.NomFlat);
Ini.Writestring('Preprocessing','NomCosmetic',Config.ConfigPretrait.NomCosmetiques);
if Config.ConfigPretrait.TypeCCDSoft then Ini.Writestring('Preprocessing','TypeCCDSoft','Oui')
else Ini.Writestring('Preprocessing','TypeCCDSoft','Non');

//Seuils
Ini.Writestring('Soft','SeuilBasAuto',FloatToStr(Config.SeuilBasPourCent));
Ini.Writestring('Soft','SeuilHautAuto',FloatToStr(Config.SeuilHautPourCent));
Ini.Writestring('Soft','SeuilMultBas',FloatToStr(Config.MultBas));
Ini.Writestring('Soft','SeuilMultHaut',FloatToStr(Config.MultHaut));

Ini.WriteString('Soft','TypeSeuil',IntToStr(config.TypeSeuil));
Ini.WriteInteger('Soft','SeuilCamera',Config.SeuilCamera); //nolang
Ini.WriteString('Soft','SeuilBasFixe',FloatToStr(Config.SeuilBasFixe));
Ini.WriteString('Soft','SeuilHautFixe',FloatToStr(Config.SeuilHautFixe));

// Timeouts port série télescope
Ini.WriteString('Soft','ReadIntervalTimeout',        IntToStr(Config.ReadIntervalTimeout));
Ini.WriteString('Soft','ReadTotalTimeoutMultiplier', IntToStr(Config.ReadTotalTimeoutMultiplier));
Ini.WriteString('Soft','ReadTotalTimeoutConstant',   IntToStr(Config.ReadTotalTimeoutConstant));
Ini.WriteString('Soft','WriteTotalTimeoutMultiplier',IntToStr(Config.WriteTotalTimeoutMultiplier));
Ini.WriteString('Soft','WriteTotalTimeoutConstant',  IntToStr(Config.WriteTotalTimeoutConstant));
// Timeouts port série serveur d'heure
Ini.WriteString('HourServer','HourServerReadIntervalTimeout',        IntToStr(Config.HourServerReadIntervalTimeout));
Ini.WriteString('HourServer','HourServerReadTotalTimeoutMultiplier', IntToStr(Config.HourServerReadTotalTimeoutMultiplier));
Ini.WriteString('HourServer','HourServerReadTotalTimeoutConstant',   IntToStr(Config.HourServerReadTotalTimeoutConstant));
Ini.WriteString('HourServer','HourServerWriteTotalTimeoutMultiplier',IntToStr(Config.HourServerWriteTotalTimeoutMultiplier));
Ini.WriteString('HourServer','HourServerWriteTotalTimeoutConstant',  IntToStr(Config.HourServerWriteTotalTimeoutConstant));
// Timeouts port série map
Ini.WriteString('Soft','MapReadIntervalTimeout',        IntToStr(Config.MapReadIntervalTimeout));
Ini.WriteString('Soft','MapReadTotalTimeoutMultiplier', IntToStr(Config.MapReadTotalTimeoutMultiplier));
Ini.WriteString('Soft','MapReadTotalTimeoutConstant',   IntToStr(Config.MapReadTotalTimeoutConstant));
Ini.WriteString('Soft','MapWriteTotalTimeoutMultiplier',IntToStr(Config.MapWriteTotalTimeoutMultiplier));
Ini.WriteString('Soft','MapWriteTotalTimeoutConstant',  IntToStr(Config.MapWriteTotalTimeoutConstant));

Ini.WriteString('Telescope','ErreurPointingAlpha',FloatToStr(config.ErreurPointingAlpha));
Ini.WriteString('Telescope','ErreurPointingDelta',FloatToStr(config.ErreurPointingDelta));

Ini.WriteString('Soft','TypeSaveFits',IntToStr(config.TypeSaveFits));

Ini.WriteString('CCD','DelaiVidage',FloatToStr(config.DelaiVidage));
Ini.WriteString('Suivi','DelaiVidage',FloatToStr(config.DelaiVidageSuivi));

Ini.WriteString('Soft','FormeModelePhotometrie',IntToStr(config.FormeModelePhotometrie));
Ini.WriteString('Soft','DegreCielPhotometrie',IntToStr(config.DegreCielPhotometrie));
Ini.WriteString('Soft','LargModelisePhotometrie',IntToStr(config.LargModelisePhotometrie));
Ini.WriteString('Soft','ApertureInt',IntToStr(config.ApertureInt));
Ini.WriteString('Soft','ApertureOut',IntToStr(config.ApertureOut));
Ini.WriteString('Soft','ApertureMid',IntToStr(config.ApertureMid));

// Webcam
Ini.WriteFloat('Webcam','ImagesParSecondes',config.Webcam_imgs); //nolang
Ini.WriteInteger('Webcam','NombreNoir',config.Webcam_nbdark);    //nolang
Ini.WriteFloat('Webcam','PixelsizeX',config.Webcam_pixelsizeX);  //nolang
Ini.WriteFloat('Webcam','PixelsizeY',config.Webcam_pixelsizeY);  //nolang
Ini.WriteInteger('Webcam','Couleur',config.Webcam_color);        //nolang
Ini.WriteInteger('Webcam','Recadrage',config.Webcam_recadrage);  //nolang
Ini.WriteBool('Webcam','Autoconnect',config.Webcam_Autoconnect); //nolang
Ini.WriteString('Webcam','DriverName',config.Webcam_DriverName); //nolang
Ini.WriteBool('Webcam','Preview',config.Webcam_preview);         //nolang
Ini.WriteBool('Webcam','ViewPose',config.Webcam_viewpose);       //nolang

if Config.AdresseCamera=$378 then Ini.WriteString('CCD','Port','$378');
if Config.AdresseCamera=$278 then Ini.WriteString('CCD','Port','$278');
if Config.AdresseCamera=$3BC then Ini.WriteString('CCD','Port','$3BC');

if Config.AdresseCameraSuivi=$378 then Ini.WriteString('Suivi','Port','$378');
if Config.AdresseCameraSuivi=$278 then Ini.WriteString('Suivi','Port','$278');
if Config.AdresseCameraSuivi=$3BC then Ini.WriteString('Suivi','Port','$3BC');

Ini.WriteString('CCD','CameraPlugin',config.CameraPlugin);
Ini.WriteString('MAP','FocuserPlugin',config.FocuserPlugin);
Ini.WriteString('Suivi','CameraPlugin',config.CameraPluginSuivi);
Ini.WriteString('Dome','DomePlugin',config.DomePlugin);

Ini.WriteString('Dome','TypeDome',IntToStr(config.TypeDome));

//if config.CCDOriente then Ini.WriteString('CCD','CCDOriente','Oui')
//else Ini.WriteString('CCD','CCDOriente','Non');
//if config.CCDTrackOriente then Ini.WriteString('Track','CCDOriente','Oui')
//else Ini.WriteString('Track','CCDOriente','Non');

if config.MesureParSuperStar then ini.writestring('Soft','SuperStar','Oui')
else ini.writestring('Soft','SuperStar','Non');

if config.MesureParReference then ini.writestring('Soft','Reference','Oui')
else ini.writestring('Soft','Reference','Non');
if config.MesureParRegressionLineaire then ini.writestring('Soft','Regression','Oui')
else ini.writestring('Soft','Regression','Non');

if Config.UseLongFormat then ini.writestring('Telescope','UseLongFormat','Oui')
else ini.writestring('Telescope','UseLongFormat','Non');

if Config.Allemande then ini.writestring('Telescope','German','Oui')
else ini.writestring('Telescope','German','Non');

if config.UseModelePointage then ini.writestring('Telescope','UseTPoint','Oui')
else ini.writestring('Telescope','UseTPoint','Non');

if config.ModelePointageCalibre then ini.writestring('Telescope','TPointCalibrated','Oui')
else ini.writestring('Telescope','TPointCalibrated','Non');

if Correction.DoCH then ini.writestring('Telescope','DoCH','Oui')
else ini.writestring('Telescope','DoCH','Non');
if Correction.DoNP then ini.writestring('Telescope','DoNP','Oui')
else ini.writestring('Telescope','DoNP','Non');
if Correction.DoMA then ini.writestring('Telescope','DoMA','Oui')
else ini.writestring('Telescope','DoMA','Non');
if Correction.DoME then ini.writestring('Telescope','DoME','Oui')
else ini.writestring('Telescope','DoME','Non');
if Correction.DoTF then ini.writestring('Telescope','DoTF','Oui')
else ini.writestring('Telescope','DoTF','Non');
if Correction.DoFO then ini.writestring('Telescope','DoFO','Oui')
else ini.writestring('Telescope','DoFO','Non');
if Correction.DoDAF then ini.writestring('Telescope','DoDAF','Oui')
else ini.writestring('Telescope','DoDAF','Non');
if Correction.DoPHH1D0 then ini.writestring('Telescope','DoPHH1D0','Oui')
else ini.writestring('Telescope','DoPHH1D0','Non');
if Correction.DoPDH1D0 then ini.writestring('Telescope','DoPDH1D0','Oui')
else ini.writestring('Telescope','DoPDH1D0','Non');
if Correction.DoPHH0D1 then ini.writestring('Telescope','DoPHH0D1','Oui')
else ini.writestring('Telescope','DoPHH0D1','Non');
if Correction.DoPDH0D1 then ini.writestring('Telescope','DoPDH0D1','Oui')
else ini.writestring('Telescope','DoPDH0D1','Non');
if Correction.DoPHH2D0 then ini.writestring('Telescope','DoPHH2D0','Oui')
else ini.writestring('Telescope','DoPHH2D0','Non');
if Correction.DoPDH2D0 then ini.writestring('Telescope','DoPDH2D0','Oui')
else ini.writestring('Telescope','DoPDH2D0','Non');
if Correction.DoPHH1D1 then ini.writestring('Telescope','DoPHH1D1','Oui')
else ini.writestring('Telescope','DoPHH1D1','Non');
if Correction.DoPDH1D1 then ini.writestring('Telescope','DoPDH1D1','Oui')
else ini.writestring('Telescope','DoPDH1D1','Non');
if Correction.DoPHH0D2 then ini.writestring('Telescope','DoPHH0D2','Oui')
else ini.writestring('Telescope','DoPHH0D2','Non');
if Correction.DoPDH0D2 then ini.writestring('Telescope','DoPDH0D2','Oui')
else ini.writestring('Telescope','DoPDH0D2','Non');

Ini.WriteString('Soft','TypeSeparateurAlpha',IntToStr(config.TypeSeparateurAlpha));
Ini.WriteString('Soft','TypeSeparateurDelta',IntToStr(config.TypeSeparateurDelta));

if Config.CloseQuery then ini.writestring('Soft','CloseQuery','Oui')
else ini.writestring('Soft','CloseQuery','Non');
if Config.AskToCalibrate then ini.writestring('Soft','AskToCalibrate','Oui')
else ini.writestring('Soft','AskToCalibrate','Non');
if Config.MsgFocuser then ini.writestring('Soft','MsgFocuser','Oui')
else ini.writestring('Soft','MsgFocuser','Non');
if Config.UseCFW8 then ini.writestring('Soft','UseCFW8','Oui')
else ini.writestring('Soft','UseCFW8','Non');

Ini.writeString('MAP','ImpulsionArriereRapide',FloatToStr(Config.ImpulsionArriereRapide));
Ini.writeString('MAP','ImpulsionArriereLente',FloatToStr(Config.ImpulsionArriereLente));
Ini.writeString('MAP','StabilisationRapide',FloatToStr(Config.StabilisationRapide));
Ini.writeString('MAP','StabilisationLente',FloatToStr(Config.StabilisationLente));
Ini.writeString('MAP','ImpulsionAvantRapide',FloatToStr(Config.ImpulsionAvantRapide));
Ini.writeString('MAP','ImpulsionAvantLente',FloatToStr(Config.ImpulsionAvantLente));
Ini.writeString('MAP','SurvitesseRapide',FloatToStr(Config.SurvitesseRapide));
Ini.writeString('MAP','SurvitesseLente',FloatToStr(Config.SurvitesseLente));

Ini.writeString('MAP','DiametreExtreme',FloatToStr(Config.DiametreExtreme));
Ini.writeString('MAP','DiametreProche',FloatToStr(Config.DiametreProche));
Ini.writeString('MAP','MargeSecurite',FloatToStr(Config.MargeSecurite));
Ini.writeString('MAP','DureeExtraction',FloatToStr(Config.DureeExtraction));
Ini.writeString('MAP','VitesseRapide',FloatToStr(Config.VitesseRapide));
Ini.writeString('MAP','VitesseLente',FloatToStr(Config.VitesseLente));
Ini.writeString('MAP','DureeImpulsionIncrementale',FloatToStr(Config.DureeImpulsionIncrementale));
Ini.writeString('MAP','DureeMaxManoeuvre',FloatToStr(Config.DureeMaxManoeuvre));
if Config.UseVitesseRapide then Ini.WriteString('MAP','UseVitesseRapide','Oui')
else Ini.WriteString('MAP','UseVitesseRapide','Non');
if Config.UseCmdCorrRapideAutoV then Ini.WriteString('MAP','UseCmdCorrRapide','Oui')
else Ini.WriteString('MAP','UseCmdCorrRapide','Non');
if Config.UseCmdCorrLenteAutoV then Ini.WriteString('MAP','UseCmdCorrLente','Oui')
else Ini.WriteString('MAP','UseCmdCorrLente','Non');

Ini.writeString('MAP','FWHMTest',FloatToStr(FWHMTestCourantInit));

Ini.WriteString('Soft','Version',FloatToStr(VersionNb));

Ini.WriteString('Soft','BestOfDFWHM',FloatToStr(Config.BestOfDFWHM));
Ini.WriteString('Soft','BestOfFWHMMax',FloatToStr(Config.BestOfFWHMMax));

if Config.DomeUpdate then Ini.WriteString('Dome','DomeUpdate','Oui')
else Ini.WriteString('Dome','DomeUpdate','Non');
Ini.WriteString('Dome','CoordUpdate',FloatToStr(config.DomeCoordUpdate));

if Config.Verbose then Ini.Writestring('Soft','Verbose','Oui')
else ini.writestring('Soft','Verbose','Non');

if Config.Periodic then Ini.Writestring('Telescope','Periodic','Oui')
else ini.writestring('Telescope','Periodic','Non');

if Config.UseProfil then Ini.Writestring('Telescope','UseProfile','Oui')
else ini.writestring('Telescope','UseProfil','Non');

finally
Ini.UpdateFile;
Ini.Free;
end;
end;

procedure LoadParametres(Filename:String);
var
Ini:TMemIniFile;
Path,Str:string;
i:integer;
SaveDecimalSeparator:Char;
begin
SaveDecimalSeparator:=DecimalSeparator;

Path:=LowerCase(ExtractFilePath(Application.ExeName));

try

Ini:=TMemIniFile.Create(FileName);

// mysql
config.mysql_bin:=ini.readstring('MySQL','bin','c:\mysql\bin');
if Config.TypeOS=1 then
   config.mysql_engine:=ini.readstring('MySQL','engine','mysqld-nt.exe')
else
   config.mysql_engine:=ini.readstring('MySQL','engine','mysqld-opt.exe');
if fileexists(config.mysql_bin+'\'+config.mysql_engine) then
   config.mysql_installed:=true
else
   config.mysql_installed:=false;

Config.MySqlHost:=ini.readstring('MySQL','Host','localhost');
Config.MySqlPort:=StrToInt(ini.readstring('MySQL','Port','3306'));
Config.MySqlUserName:=ini.readstring('MySQL','UserName','root');
Config.MySqlUserPassWord:=ini.readstring('MySQL','UserPassWord','');
Config.MySqlAskPassword:=ini.readstring('MySQL','AskPassWord','oui')='oui';

config.park_physique:=ini.readstring('Park','Physique','non')='oui';
config.park_meridien:=ini.readstring('Park','Meridien','0');
config.park_decli:=ini.readstring('Park','Declinaison','0');

config.FocaleTele:=MyStrToFloat(Ini.ReadString('Telescope','Focale','825')); // Focale en mm !!!
config.Diametre:=MyStrToFloat(Ini.ReadString('Telescope','Diametre','254'));
config.Vitesse:=MyStrToFloat(Ini.ReadString('Telescope','Vitesse','8'));
config.DeltaMax:=MyStrToFloat(Ini.ReadString('Telescope','DeltaMaxi','65'));
config.TelescopeComPort:=Ini.ReadString('Soft','Port','COM1');
config.AdresseComPort:=Ini.ReadString('Soft','AdressPort','3F8');

config.OrientationCCD:=MyStrToFloat(Ini.ReadString('CCD','OrientationCCD','0'));
config.OrientationCCDGuidage:=MyStrToFloat(Ini.ReadString('Suivi','OrientationCCDGuidage','0'));

Config.VitesseGuidageApparenteDelta:=MyStrToFloat(Ini.ReadString('Suivi','VitesseGuidageApparenteDelta','0'));
Config.VitesseGuidageReelleDelta:=MyStrToFloat(Ini.ReadString('Suivi','VitesseGuidageReelleDelta','0'));
Config.VitesseGuidageApparenteAlpha:=MyStrToFloat(Ini.ReadString('Suivi','VitesseGuidageApparenteAlpha','0'));

config.Seeing:=MyStrToFloat(Ini.ReadString('Soft','Seeing','0'));

config.MinPose:=MyStrToFloat(Ini.ReadString('CCD','PoseMini','0.03'));
//config.MaxPose:=MyStrToFloat(Ini.ReadString('CCD','PoseMaxi','5.0'));

config.MapComPort:=Ini.ReadString('Focuser','Port','COM1');

config.HourServerComPort:=Ini.ReadString('HourServer','Port','COM1');

config.Lat:=MyStrToFloat(Ini.ReadString('Site','Latitude','43.20138888889'));

config.Long:=MyStrToFloat(Ini.ReadString('Site','Longitude','3.081388888889'));

config.HauteurMini:=MyStrToFloat(Ini.ReadString('Telescope','HauteurMini','10'));

config.Profil:=Ini.ReadString('Site','Profil','Profil.Prf');

config.Attente:=MyStrToFloat(Ini.ReadString('Soft','Attente','500'));

config.TypeCamera:=StrToInt(Ini.ReadString('CCD','TypeCamera','0'));

config.TypeCameraSuivi:=StrToInt(Ini.ReadString('Suivi','TypeCamera','0'));

config.TypeTelescope:=StrToInt(Ini.ReadString('Telescope','TypeTelescope','0'));

config.TypeDome:=StrToInt(Ini.ReadString('Dome','TypeDome','0'));

config.TypeFocuser:=StrToInt(Ini.ReadString('Focuser','TypeFocuser','0'));

config.TypeHourServer:=StrToInt(Ini.ReadString('HourServer','TypeHourServer','1'));

config.FormatSaveInt:=StrToInt(Ini.ReadString('Soft','FormatSaveInt','0'));

config.FormatCouleur:=StrToInt(Ini.ReadString('Soft','FormatCouleur','1'));

config.ReadingDelai:=StrToInt(Ini.ReadString('CCD','Delai','3'));

config.ReadingDelaiSuivi:=StrToInt(Ini.ReadString('Suivi','Delai','3'));

config.keep_in_profile:=Ini.ReadString('Soft','StayInProfile','Non')='Oui';

config.MirrorX:=Ini.ReadString('CCD','MirrorX','Non')='Oui';

//config.CCDOriente:=Ini.ReadString('CCD','CCDOriente','Non')='Oui';
//config.CCDTrackOriente:=Ini.ReadString('Track','CCDOriente','Non')='Oui';

config.MirrorY:=Ini.ReadString('CCD','MirrorY','Non')='Oui';

config.MirrorXSuivi:=Ini.ReadString('Suivi','MirrorX','Non')='Oui';

config.MirrorYSuivi:=Ini.ReadString('Suivi','MirrorY','Non')='Oui';

config.DecalAlpha:=MyStrToFloat(Ini.ReadString('Telescope','DecalAlpha','0'));

config.DecalDelta:=MyStrToFloat(Ini.ReadString('Telescope','DecalDelta','0'));

//WriteSpy(lang('LoadConfig : Version du programme = ')+VersionTeleAuto);

config.PCMoinsTU:=StrToInt(Ini.ReadString('Soft','PCMoinsTU','0'));

config.RepImages:=Ini.ReadString('Soft','RepImages',Path);
if config.RepImages='' then config.RepImages:=Path; //nolang
config.RepOffsets:=Ini.ReadString('Soft','RepOffsets',Path);
if config.RepOffsets='' then config.RepOffsets:=Path; //nolang
config.RepNoirs:=Ini.ReadString('Soft','RepNoirs',Path);
if config.RepNoirs='' then config.RepNoirs:=Path; //nolang
config.RepPlus:=Ini.ReadString('Soft','RepPlus',Path);
if config.RepPlus='' then config.RepPlus:=Path; //nolang
config.RepImagesAcq:=Ini.ReadString('Soft','RepImagesAcq',Path);
if config.RepImagesAcq='' then config.RepImagesAcq:=Path; //nolang

Config.Temperature:=MyStrToFloat(Ini.ReadString('CCD','Temperature','-20'));

config.Pose1:=MyStrToFloat(Ini.ReadString('CCD','Pose1','60'));
config.Pose2:=MyStrToFloat(Ini.ReadString('CCD','Pose2','60'));
config.Pose4:=MyStrToFloat(Ini.ReadString('CCD','Pose4','0.1'));
config.NbBouclage:=StrToInt(Ini.ReadString('CCD','NbBouclage','15'));

// Focuseur
Config.NbEssaiFocFast:=StrToInt(Ini.ReadString('MAP','NbEssaiFocFast','5'));
Config.NbEssaiFocSlow:=StrToInt(Ini.ReadString('MAP','NbEssaiFocSlow','5'));
Config.NbEssaiCentroMaxi:=StrToInt(Ini.ReadString('MAP','NbEssaiCentroMaxi','20'));
Config.LargFoc:=StrToInt(Ini.ReadString('MAP','LargFoc','15'));
Config.DelaiFocFastInit:=MyStrToFloat(Ini.ReadString('MAP','DelaiFocFastInit','8'));
Config.DelaiFocSlowInit:=MyStrToFloat(Ini.ReadString('MAP','DelaiFocSlowInit','32'));
Config.FwhmStopFast:=MyStrToFloat(Ini.ReadString('MAP','FwhmStopFast','3'));
Config.FwhmStopSlow:=MyStrToFloat(Ini.ReadString('MAP','FwhmStopSlow','2.3'));
Config.DelaiFocFastMin:=MyStrToFloat(Ini.ReadString ('MAP','DelaiFocFastMin','8'));
Config.DelaiFocSlowMin:=MyStrToFloat(Ini.ReadString('MAP','DelaiFocSlowMin','32'));
Config.FocInversion:=Ini.ReadString('MAP','FocInversion','Non')='Oui';
Config.UseMoyenne:=Ini.ReadString('MAP','UseMean','Non')='Oui';
Config.TypeMesureFWHM:=StrToInt(Ini.ReadString('MAP','TypeMeasureFWHM','0'));
Config.CorrectionAutoFast:=Ini.ReadString('MAP','CorrectAutoFast','Non')='Oui';
Config.CorrectionAutoSlow:=Ini.ReadString('MAP','CorrectAutoSlow','Non')='Oui';
Config.MaxPosFocuser:=StrToInt(Ini.ReadString('MAP','MaxPosFocuser','65500'));
Config.DelaiFocOptim:=MyStrToFloat(Ini.ReadString('MAP','DelaiFocOptim','100'));
Config.Tolerance:=MyStrToFloat(Ini.ReadString('MAP','Tolerance','1'));
Config.FacteurInflation:=MyStrToFloat(Ini.ReadString('MAP','FacteurInflation','1.5'));
Config.CorrectionOptim:=Ini.ReadString('MAP','CorrectionOptim','Non')='Oui';

config.Observatoire:=Ini.ReadString('Soft','Observatoire','');
config.Observateur:=Ini.ReadString('Soft','Observateur','');
config.Filtre:=Ini.ReadString('CCD','Filtre','Aucun');
config.NameFilter[1]:=Ini.ReadString('Filtre','Filtre1','');
config.NameFilter[2]:=Ini.ReadString('Filtre','Filtre2','');
config.NameFilter[3]:=Ini.ReadString('Filtre','Filtre3','');
config.NameFilter[4]:=Ini.ReadString('Filtre','Filtre4','');
config.NameFilter[5]:=Ini.ReadString('Filtre','Filtre5','');

{Audine ... euh non pas forcement}
config.CutAmpli:=ini.readstring('CCD','AudineAmpli','oui')='oui';
config.CutAmpliSuivi:=ini.readstring('Suivi','AudineAmpli','oui')='oui';
config.ObtuCloseDelay:=mystrtofloat(ini.readstring('CCD','ObtuCloseDelay','0.1'));
config.ObtuCloseDelaySuivi:=mystrtofloat(ini.readstring('Suivi','ObtuCloseDelay','0.1'));

// Recentrage
config.CalibrateRecentrage:=Ini.ReadString('Center','Calibrate','Non')='Oui';
config.VecteurNordXRecentrage:=MyStrToFloat(Ini.ReadString('Center','VectorNorthX','0'));
config.VecteurNordYRecentrage:=MyStrToFloat(Ini.ReadString('Center','VectorNorthY','0'));
config.VecteurSudXRecentrage:=MyStrToFloat(Ini.ReadString('Center','VectorSouthX','0'));
config.VecteurSudYRecentrage:=MyStrToFloat(Ini.ReadString('Center','VectorSouthY','0'));
config.VecteurEstXRecentrage:=MyStrToFloat(Ini.ReadString('Center','VectorEastX','0'));
config.VecteurEstYRecentrage:=MyStrToFloat(Ini.ReadString('Center','VectorEastY','0'));
config.VecteurOuestXRecentrage:=MyStrToFloat(Ini.ReadString('Center','VectorWestX','0'));
config.VecteurOuestYRecentrage:=MyStrToFloat(Ini.ReadString('Center','VectorWestY','0'));
config.DelaiCalibrationRecentrage:=MyStrToFloat(Ini.ReadString('Center','DelayCalibration','10'));
config.DeltaRecentrage:=MyStrToFloat(Ini.ReadString('Center','Delta','0'));
config.IterRecentrage:=StrToInt(Ini.ReadString('Center','Iterations','2'));

// Recentrage Guidage
config.CalibrateRecentrageSuivi:=Ini.ReadString('CenterTrack','Calibrate','Non')='Oui';
config.VecteurNordXRecentrageSuivi:=MyStrToFloat(Ini.ReadString('CenterTrack','VectorNorthX','0'));
config.VecteurNordYRecentrageSuivi:=MyStrToFloat(Ini.ReadString('CenterTrack','VectorNorthY','0'));
config.VecteurSudXRecentrageSuivi:=MyStrToFloat(Ini.ReadString('CenterTrack','VectorSouthX','0'));
config.VecteurSudYRecentrageSuivi:=MyStrToFloat(Ini.ReadString('CenterTrack','VectorSouthY','0'));
config.VecteurEstXRecentrageSuivi:=MyStrToFloat(Ini.ReadString('CenterTrack','VectorEastX','0'));
config.VecteurEstYRecentrageSuivi:=MyStrToFloat(Ini.ReadString('CenterTrack','VectorEastY','0'));
config.VecteurOuestXRecentrageSuivi:=MyStrToFloat(Ini.ReadString('CenterTrack','VectorWestX','0'));
config.VecteurOuestYRecentrageSuivi:=MyStrToFloat(Ini.ReadString('CenterTrack','VectorWestY','0'));
//config.DelaiCalibrationRecentrageSuivi:=MyStrToFloat(Ini.ReadString('CenterTrack','DelayCalibration','10'));
config.DeltaRecentrageSuivi:=MyStrToFloat(Ini.ReadString('CenterTrack','Delta','0'));
config.IterRecentrageSuivi:=StrToInt(Ini.ReadString('CenterTrack','Iterations','2'));

// Tracking
config.CalibrateSuivi:=Ini.ReadString('Tracking','Calibrate','Non')='Oui';
config.Limite:=Ini.ReadString('Tracking','Limite','Non')='Oui';
config.UseTrackSt7:=Ini.ReadString('Tracking','UseTrackSt7','Non')='Oui';
config.UseDecalages:=Ini.ReadString('Tracking','UseDecalages','Non')='Oui';

//config.DeltaSuiviAuto:=Ini.ReadString('Tracking','DeltaSuiviAuto','Oui')='Oui';
config.VecteurNordX:=MyStrToFloat(Ini.ReadString('Tracking','VecteurNordX','0'));
config.VecteurNordY:=MyStrToFloat(Ini.ReadString('Tracking','VecteurNordY','0'));
config.VecteurSudX:=MyStrToFloat(Ini.ReadString('Tracking','VecteurSudX','0'));
config.VecteurSudY:=MyStrToFloat(Ini.ReadString('Tracking','VecteurSudY','0'));
config.VecteurEstX:=MyStrToFloat(Ini.ReadString('Tracking','VecteurEstX','0'));
config.VecteurEstY:=MyStrToFloat(Ini.ReadString('Tracking','VecteurEstY','0'));
config.VecteurOuestX:=MyStrToFloat(Ini.ReadString('Tracking','VecteurOuestX','0'));
config.VecteurOuestY:=MyStrToFloat(Ini.ReadString('Tracking','VecteurOuestY','0'));
config.DelaiRattrapageSuiviNS:=MyStrToFloat(Ini.ReadString('Tracking','DelaiRattrapageNS','3'));
config.DelaiCalibrationSuiviNS:=MyStrToFloat(Ini.ReadString('Tracking','DelaiCalibrationNS','10'));
config.DelaiCalibrationSuiviEO:=MyStrToFloat(Ini.ReadString('Tracking','DelaiCalibrationEO','10'));
config.DeltaSuivi:=MyStrToFloat(Ini.ReadString('Tracking','DeltaSuivi','0'));
config.AHSuivi:=MyStrToFloat(Ini.ReadString('Tracking','AHSuivi','0'));
config.CoefLimitationNS:=MyStrToFloat(Ini.ReadString('Tracking','CoefLimitationNS','0.5'));
config.CoefLimitationEO:=MyStrToFloat(Ini.ReadString('Tracking','CoefLimitationEO','0.5'));
config.ErreurGoodTrack:=MyStrToFloat(Ini.ReadString('Tracking','ErrorGoodTrack','0.5'));
config.ErreurPositionGuidage:=MyStrToFloat(Ini.ReadString('Tracking','TrackPosError','2'));
config.ErreurAngleGuidage:=MyStrToFloat(Ini.ReadString('Tracking','TrackAngleError','10'));

config.InversionNS:=False;
if Ini.ReadString('Telescope','InversionNS','Non')='Oui' then config.InversionNS:=True;
config.InversionEO:=False;
if Ini.ReadString('Telescope','InversionEO','Non')='Oui' then config.InversionEO:=True;

{Initialisation du chemin vers les catalogues et les fichiers d ephemerides}
// Guide Star catalog (version produite par convgsc.exe)
config.TypeGSC:=ini.readInteger('Catalogs','TypeGSC',0); //nolang
//config.RepGSC:=ini.readstring('Catalogs','GSC',RepTeleAuto+'\cat\gsc'); //nolang
//config.RepGSC:=ini.readstring('Catalogs','GSC',Path+'\cat\gsc'); //nolang
config.RepGSC:=ini.readstring('Catalogs','GSC',''); //nolang

case config.typeGSC of
   0:SetGsccPath(Config.RepGSC);
   1:SetGscfPath(Config.RepGSC);
   end;

// US Naval Observatory USNO-A1,SA1,A2,SA2 catalog
config.RepUSNO:=ini.readstring('Catalogs','USNO',Path+'\cat\usno');
setusnoapath(config.RepUSNO);

// Tycho-2 catalog
//config.RepTycho2:=ini.readstring('Catalogs','Tycho2',Path+'\cat\thyco2');
config.RepTycho2:=ini.readstring('Catalogs','Tycho2','');
SetTY2path(config.RepTycho2);

// MicroCat
config.RepMicrocat:=ini.readstring('catalogs','Microcat',Path+'\cat\microcat');
setmctpath(config.RepMicrocat);

config.RepCatalogsBase:=ini.readstring('Catalogs','Base',Path+'\cat');

// Bright Stars Catalog
setbscpath(config.RepCatalogsBase+'\BSC'); //nolang

// NGC 2000
setngcpath(config.RepCatalogsBase+'\NGC'); //nolang

// Catalogue of Principal Galaxies (PGC)
setpgcpath(config.RepCatalogsBase+'\PGC'); //nolang

// Third Reference Cat. of Bright Galaxies (RC3)
setrc3path(config.RepCatalogsBase+'\RC3'); //nolang

//  Washington Visual Double Star Catalog
setwdspath(config.RepCatalogsBase+'\WDS'); //nolang

// General Catalog of Variable Stars (+NSV +EVS)
setgcvpath(config.RepCatalogsBase+'\GCVS'); //nolang

// script
config.mag_hi:=Mystrtofloat(ini.readstring('Script','MagHigh','15'));

config.mag_lo:=Mystrtofloat(ini.readstring('Script','MagLow','0'));

config.size_hi:=Mystrtofloat(ini.readstring('Script','SizeHigh','30'));

config.size_lo:=Mystrtofloat(ini.readstring('Script','SizeLow','0'));

config.type_objet:=strtoint(ini.ReadString('Script','ObjetType','0'));

config.distance_objet:=strtoint(ini.ReadString('Script','ObjetDist','7500'));

// on initialise les variables de contraintes pour l execution des scripts
config.azimut_active:=ini.readstring('Script','AzimutLimit','non')='oui';

if config.azimut_active then
   begin
   config.azimut_min:=mystrtofloat(ini.readstring('Script','AzimutLow','0'));
   config.azimut_max:=mystrtofloat(ini.readstring('Script','AzimutHigh','0'));
   end;

config.hauteur_active:=ini.readstring('Script','HauteurLimit','non')='oui';

if config.hauteur_active then
   begin
   config.hauteur_min:=mystrtofloat(ini.readstring('Script','HauteurLow','0'));
   config.hauteur_max:=mystrtofloat(ini.readstring('Script','HauteurHigh','0'));
   end;

config.moon_active:=ini.readstring('Script','MoonLimit','non')='oui';

if config.moon_active then
   begin
   config.moon_min_distance:=mystrtofloat(ini.readstring('Script','MoonDist','0'));
   config.moon_brightness:=mystrtofloat(ini.readstring('Script','MoonBright','0'));
   end;

Config.JpegQuality:=StrToInt(Ini.ReadString('Soft','JpegQuality','80'));

// Pretraitements
Config.ConfigPretrait.CreeOffset:=Ini.ReadString('Preprocessing','CreateOffset','Oui')='Oui';
Config.ConfigPretrait.UsePreviousFiles:=Ini.ReadString('Preprocessing','UsePreviousFiles','Oui')='Oui';
Config.ConfigPretrait.EnleveOffsetAuxNoirs:=Ini.ReadString('Preprocessing','SubOffsetToBlacks','Oui')='Oui';
Config.ConfigPretrait.CreeNoir:=Ini.ReadString('Preprocessing','CreateBlack','Oui')='Oui';
Config.ConfigPretrait.EnleveOffsetAuxNoirsFlats:=Ini.ReadString('Preprocessing','SubOffsetToBlacksFlats','Oui')='Oui';
Config.ConfigPretrait.CreeNoirFlats:=Ini.ReadString('Preprocessing','CreateBlackFlats','Oui')='Oui';
Config.ConfigPretrait.EnleveOffsetAuxFlats:=Ini.ReadString('Preprocessing','SubOffsetToFlats','Oui')='Oui';
Config.ConfigPretrait.EnleveNoirsFlatsAuxFlats:=Ini.ReadString('Preprocessing','SubBlacksFlatsToFlats','Oui')='Oui';
Config.ConfigPretrait.MoyenneIdentiqueDesFlats:=Ini.ReadString('Preprocessing','SameMeanFlats','Oui')='Oui';
Config.ConfigPretrait.CreeFlat:=Ini.ReadString('Preprocessing','CreateFlat','Oui')='Oui';
Config.ConfigPretrait.EnleveOffsetAuxImages:=Ini.ReadString('Preprocessing','SubOffsetToImages','Oui')='Oui';
Config.ConfigPretrait.EnleveNoirAuxImages:=Ini.ReadString('Preprocessing','SubBlackToImages','Oui')='Oui';
Config.ConfigPretrait.CorrigeImagesDuFlat:=Ini.ReadString('Preprocessing','CorrectImagesFlat','Oui')='Oui';
Config.ConfigPretrait.RecaleImages:=Ini.ReadString('Preprocessing','AlignImages','Oui')='Oui';
Config.ConfigPretrait.CompositeImages:=Ini.ReadString('Preprocessing','AddImages','Oui')='Oui';
Config.ConfigPretrait.SupprimmerImages:=Ini.ReadString('Preprocessing','DelTempImages','Oui')='Oui';
Config.ConfigPretrait.CorrigeCosmetique:=Ini.ReadString('Preprocessing','CorrectCosmetics','Oui')='Oui';
Config.ConfigPretrait.AppliqueMedian:=Ini.ReadString('Preprocessing','ApplyMedian','Non')='Oui';
Config.ConfigPretrait.OptimiseNoir:=Ini.ReadString('Preprocessing','OptimizeDark','Oui')='Oui';
Config.ConfigPretrait.TypeCreationOffset:=StrToInt(Ini.ReadString('Preprocessing','TypeCreateOffset','0'));
Config.ConfigPretrait.TypeCreationNoir:=StrToInt(Ini.ReadString('Preprocessing','TypeCreateBlack','1'));
Config.ConfigPretrait.TypeCreationFlat:=StrToInt(Ini.ReadString('Preprocessing','TypeCreateFlat','0'));
Config.ConfigPretrait.TypeCreationNoirFlat:=StrToInt(Ini.ReadString('Preprocessing','TypeCreateNoirFlat','0'));
Config.ConfigPretrait.TypeRecalageImages:=StrToInt(Ini.ReadString('Preprocessing','TypeAlignImage','0'));
Config.ConfigPretrait.TypeCompositageImages:=StrToInt(Ini.ReadString('Preprocessing','TypeAddImages','1'));
Config.ConfigPretrait.NbSigmaOffset:=MyStrToFloat(Ini.ReadString('Preprocessing','NbSigmaOffset','3'));
Config.ConfigPretrait.ErreurRecaleImages:=MyStrToFloat(Ini.ReadString('Preprocessing','ErrorRealignImg','0.1'));
Config.ConfigPretrait.NbSigmaNoir:=MyStrToFloat(Ini.ReadString('Preprocessing','NbSigmaNoir','3'));
Config.ConfigPretrait.NbSigmaFlat:=MyStrToFloat(Ini.ReadString('Preprocessing','NbSigmaFlat','3'));
Config.ConfigPretrait.NbSigmaNoirFlat:=MyStrToFloat(Ini.ReadString('Preprocessing','NbSigmaNoirFlat','3'));
Config.ConfigPretrait.NbSigmaImage:=MyStrToFloat(Ini.ReadString('Preprocessing','NbSigmaImage','3'));
Config.ConfigPretrait.NomOffset:=Ini.ReadString('Preprocessing','NomOffset','Offset');
Config.ConfigPretrait.NomNoir:=Ini.ReadString('Preprocessing','NomNoir','Noir');
Config.ConfigPretrait.NomNoirFlat:=Ini.ReadString('Preprocessing','NomNoirFlat','NoirFlat');
Config.ConfigPretrait.NomFlat:=Ini.ReadString('Preprocessing','NomFlat','Flat');
Config.ConfigPretrait.NomCosmetiques:=Ini.ReadString('Preprocessing','NomCosmetic','Cosmetic');
Config.ConfigPretrait.TypeCCDSoft:=Ini.ReadString('Preprocessing','TypeCCDSoft','Non')='Oui';

Config.TypeSeuil:=StrToInt(Ini.ReadString('Soft','TypeSeuil','1'));
Config.SeuilBasPourCent:=MyStrToFloat(Ini.ReadString('Soft','SeuilBasAuto','0.5'));
Config.SeuilHautPourCent:=MyStrToFloat(Ini.ReadString('Soft','SeuilHautAuto','99.5'));
Config.MultBas:=MyStrToFloat(Ini.ReadString('Soft','SeuilMultBas','-0.25'));
Config.MultHaut:=MyStrToFloat(Ini.ReadString('Soft','SeuilMultHaut','2'));
Config.SeuilCamera:=Ini.ReadInteger('Soft','SeuilCamera',0); //nolang
Config.SeuilBasFixe:=Ini.ReadInteger('Soft','SeuilBasFixe',0); //nolang
Config.SeuilHautFixe:=Ini.ReadInteger('Soft','SeuilHautFixe',255); //nolang

Config.ReadIntervalTimeout:=StrToInt(Ini.ReadString('Soft','ReadIntervalTimeout','10'));
Config.ReadTotalTimeoutMultiplier:=StrToInt(Ini.ReadString('Soft','ReadTotalTimeoutMultiplier','10'));
Config.ReadTotalTimeoutConstant:=StrToInt(Ini.ReadString('Soft','ReadTotalTimeoutConstant','250'));
Config.WriteTotalTimeoutMultiplier:=StrToInt(Ini.ReadString('Soft','WriteTotalTimeoutMultiplier','10'));
Config.WriteTotalTimeoutConstant:=StrToInt(Ini.ReadString('Soft','WriteTotalTimeoutConstant','500'));

Config.HourServerReadIntervalTimeout:=StrToInt(Ini.ReadString('HourServer','HourServerReadIntervalTimeout','10'));
Config.HourServerReadTotalTimeoutMultiplier:=StrToInt(Ini.ReadString('HourServer','HourServerReadTotalTimeoutMultiplier','10'));
Config.HourServerReadTotalTimeoutConstant:=StrToInt(Ini.ReadString('HourServer','HourServerReadTotalTimeoutConstant','250'));
Config.HourServerWriteTotalTimeoutMultiplier:=StrToInt(Ini.ReadString('HourServer','HourServerWriteTotalTimeoutMultiplier','10'));
Config.HourServerWriteTotalTimeoutConstant:=StrToInt(Ini.ReadString('HourServer','HourServerWriteTotalTimeoutConstant','500'));

Config.MapReadIntervalTimeout:=StrToInt(Ini.ReadString('Soft','MapReadIntervalTimeout','10'));
Config.MapReadTotalTimeoutMultiplier:=StrToInt(Ini.ReadString('Soft','MapReadTotalTimeoutMultiplier','10'));
Config.MapReadTotalTimeoutConstant:=StrToInt(Ini.ReadString('Soft','MapReadTotalTimeoutConstant','10'));
Config.MapWriteTotalTimeoutMultiplier:=StrToInt(Ini.ReadString('Soft','MapWriteTotalTimeoutMultiplier','10'));
Config.MapWriteTotalTimeoutConstant:=StrToInt(Ini.ReadString('Soft','MapWriteTotalTimeoutConstant','10'));

config.ErreurPointingAlpha:=MyStrToFloat(Ini.ReadString('Telescope','ErreurPointingAlpha',FloatToStr(6)));
config.ErreurPointingDelta:=MyStrToFloat(Ini.ReadString('Telescope','ErreurPointingDelta',FloatToStr(60)));

config.TypeSaveFits:=StrToInt(Ini.ReadString('Soft','TypeSaveFits','0'));

config.DelaiVidage:=MyStrToFloat(Ini.ReadString('CCD','DelaiVidage','0.7'));

config.DelaiVidageSuivi:=MyStrToFloat(Ini.ReadString('Suivi','DelaiVidage','0.7'));

config.FormeModelePhotometrie:=StrToInt(Ini.ReadString('Soft','FormeModelePhotometrie','2'));
Config.DegreCielPhotometrie:=StrToInt(Ini.ReadString('Soft','DegreCielPhotometrie','1'));
Config.LargModelisePhotometrie:=StrToInt(Ini.ReadString('Soft','LargModelisePhotometrie','9'));
Config.ApertureInt:=StrToInt(Ini.ReadString('Soft','ApertureInt','10'));
Config.ApertureOut:=StrToInt(Ini.ReadString('Soft','ApertureOut','20'));
Config.ApertureMid:=StrToInt(Ini.ReadString('Soft','ApertureMid','15'));

// Webcam
config.Webcam_imgs:=Ini.ReadFloat('Webcam','ImagesParSecondes',2); //nolang
config.Webcam_nbdark:=Ini.ReadInteger('Webcam','NombreNoir',5); //nolang
config.Webcam_pixelsizeX:=Ini.ReadFloat('Webcam','PixelsizeX',10); //nolang
config.Webcam_pixelsizeY:=Ini.ReadFloat('Webcam','PixelsizeY',10); //nolang
config.Webcam_color:=Ini.ReadInteger('Webcam','Couleur',0); //nolang
config.Webcam_recadrage:=Ini.ReadInteger('Webcam','Recadrage',0); //nolang
config.Webcam_autoconnect:=Ini.ReadBool('Webcam','Autoconnect',false); //nolang
//if config.Webcam_autoconnect then WriteSpy(lang('LoadConfig : Webcam : Autoconnect = oui'))
//                             else WriteSpy(lang('LoadConfig : Webcam : Autoconnect = non'));
config.Webcam_drivername:=Ini.ReadString('Webcam','DriverName','');

config.Webcam_Preview:=Ini.ReadBool('Webcam','Preview',true); //nolang
config.Webcam_ViewPose:=Ini.ReadBool('Webcam','ViewPose',true); //nolang

if Ini.ReadString('CCD','Port','$378')='$378' then Config.AdresseCamera:=$378;
if Ini.ReadString('CCD','Port','$378')='$278' then Config.AdresseCamera:=$278;
if Ini.ReadString('CCD','Port','$378')='$3BC' then Config.AdresseCamera:=$3BC;

if Ini.ReadString('Suivi','Port','$378')='$378' then Config.AdresseCameraSuivi:=$378;
if Ini.ReadString('Suivi','Port','$378')='$278' then Config.AdresseCameraSuivi:=$278;
if Ini.ReadString('Suivi','Port','$378')='$3BC' then Config.AdresseCameraSuivi:=$3BC;

config.CameraPlugin:=Ini.ReadString('CCD','CameraPlugin','plugin.dll');
config.FocuserPlugin:=Ini.ReadString('MAP','FocuserPlugin','PluginTestFocuser.dll');

config.CameraPluginSuivi:=Ini.ReadString('Suivi','CameraPlugin','plugin.dll');

config.DomePlugin:=Ini.ReadString('Dome','DomePlugin','PluginTestDome.dll');

config.UseTrackSt7:=Ini.ReadString('Tracking','UseTrackSt7','Non')='Oui';

Config.MesureParSuperStar:=Ini.ReadString('Soft','SuperStar','Oui')='Oui';
Config.MesureParReference:=Ini.ReadString('Soft','Reference','Non')='Oui';
Config.MesureParRegressionLineaire:=Ini.ReadString('Soft','Regression','Non')='Oui';

Config.UseLongFormat:=Ini.ReadString('Telescope','UseLongFormat','Oui')='Oui';

Config.Allemande:=Ini.ReadString('Telescope','German','Oui')='Oui';

Config.UseModelePointage:=Ini.ReadString('Telescope','UseTPoint','Non')='Oui';
Config.ModelePointageCalibre:=Ini.ReadString('Telescope','TPointCalibrated','Non')='Oui';
Correction.DoCH:=Ini.ReadString('Telescope','DoCH','Non')='Oui';
Correction.DoNP:=Ini.ReadString('Telescope','DoNP','Non')='Oui';
Correction.DoMA:=Ini.ReadString('Telescope','DoMA','Non')='Oui';
Correction.DoME:=Ini.ReadString('Telescope','DoME','Non')='Oui';
Correction.DoTF:=Ini.ReadString('Telescope','DoTF','Non')='Oui';
Correction.DoFO:=Ini.ReadString('Telescope','DoFO','Non')='Oui';
Correction.DoDAF:=Ini.ReadString('Telescope','DoDAF','Non')='Oui';
Correction.DoPHH1D0:=Ini.ReadString('Telescope','DoPHH1D0','Non')='Oui';
Correction.DoPDH1D0:=Ini.ReadString('Telescope','DoPDH1D0','Non')='Oui';
Correction.DoPHH0D1:=Ini.ReadString('Telescope','DoPHH0D1','Non')='Oui';
Correction.DoPDH0D1:=Ini.ReadString('Telescope','DoPDH0D1','Non')='Oui';
Correction.DoPHH2D0:=Ini.ReadString('Telescope','DoPHH2D0','Non')='Oui';
Correction.DoPDH2D0:=Ini.ReadString('Telescope','DoPDH2D0','Non')='Oui';
Correction.DoPHH1D1:=Ini.ReadString('Telescope','DoPHH1D1','Non')='Oui';
Correction.DoPDH1D1:=Ini.ReadString('Telescope','DoPDH1D1','Non')='Oui';
Correction.DoPHH0D2:=Ini.ReadString('Telescope','DoPHH0D2','Non')='Oui';
Correction.DoPDH0D2:=Ini.ReadString('Telescope','DoPDH0D2','Non')='Oui';

config.TypeSeparateurAlpha:=StrToInt(Ini.ReadString('Soft','TypeSeparateurAlpha','0'));
config.TypeSeparateurDelta:=StrToInt(Ini.ReadString('Soft','TypeSeparateurDelta','0'));
if config.TypeSeparateurAlpha<0 then config.TypeSeparateurAlpha:=0;
if config.TypeSeparateurDelta<0 then config.TypeSeparateurDelta:=0;
if config.TypeSeparateurAlpha>2 then config.TypeSeparateurAlpha:=2;
if config.TypeSeparateurDelta>2 then config.TypeSeparateurDelta:=2;

// 16h05m15s
// 16h05m15
// 16:05:15
case config.TypeSeparateurAlpha of
   0:begin
    Config.SeparateurHeuresMinutesAlpha:='h';
    Config.SeparateurMinutesSecondesAlpha:='m';
    Config.UnitesSecondesAlpha:='s';
    end;
  1:begin
    Config.SeparateurHeuresMinutesAlpha:='h';
    Config.SeparateurMinutesSecondesAlpha:='m';
    Config.UnitesSecondesAlpha:=' ';
    end;
  2:begin
    Config.SeparateurHeuresMinutesAlpha:=':';
    Config.SeparateurMinutesSecondesAlpha:=':';
    Config.UnitesSecondesAlpha:=' ';
    end;
  end;

// 75d45m02s
// 75d45m02
// 75°45'02"
// 75°45'02
case config.TypeSeparateurDelta of
   0:begin
     Config.SeparateurDegresMinutesDelta:='d';
     Config.SeparateurMinutesSecondesDelta:='m';
     Config.UnitesSecondesDelta:='s';
     end;
   1:begin
     Config.SeparateurDegresMinutesDelta:='d';
     Config.SeparateurMinutesSecondesDelta:='m';
     Config.UnitesSecondesDelta:=' ';
     end;
   2:begin
     Config.SeparateurDegresMinutesDelta:='°';
     Config.SeparateurMinutesSecondesDelta:='''';
     Config.UnitesSecondesDelta:='"';
     end;
   3:begin
     Config.SeparateurDegresMinutesDelta:='°';
     Config.SeparateurMinutesSecondesDelta:='''';
     Config.UnitesSecondesDelta:=' ';
     end;
   end;

Config.CloseQuery:=Ini.ReadString('Soft','CloseQuery','Oui')='Oui';
Config.AskToCalibrate:=Ini.ReadString('Soft','AskToCalibrate','Oui')='Oui';
Config.MsgFocuser:=Ini.ReadString('Soft','MsgFocuser','Oui')='Oui';
Config.UseCFW8:=Ini.ReadString('Soft','UseCFW8','Oui')='Oui';

Config.ImpulsionArriereRapide:=MyStrToFloat(Ini.ReadString('MAP','ImpulsionArriereRapide','40'));
Config.ImpulsionArriereLente:=MyStrToFloat(Ini.ReadString('MAP','ImpulsionArriereLente','300'));
Config.StabilisationRapide:=MyStrToFloat(Ini.ReadString('MAP','StabilisationRapide','300'));
Config.StabilisationLente:=MyStrToFloat(Ini.ReadString('MAP','StabilisationLente','300'));
Config.ImpulsionAvantRapide:=MyStrToFloat(Ini.ReadString('MAP','ImpulsionAvantRapide','40'));
Config.ImpulsionAvantLente:=MyStrToFloat(Ini.ReadString('MAP','ImpulsionAvantLente','300'));
Config.SurvitesseRapide:=MyStrToFloat(Ini.ReadString('MAP','SurvitesseRapide','0'));
Config.SurvitesseLente:=MyStrToFloat(Ini.ReadString('MAP','SurvitesseLente','0'));

Config.DiametreExtreme:=MyStrToFloat(Ini.ReadString('MAP','DiametreExtreme','22'));
Config.DiametreProche:=MyStrToFloat(Ini.ReadString('MAP','DiametreProche','5'));
Config.MargeSecurite:=MyStrToFloat(Ini.ReadString('MAP','MargeSecurite','1.3'));
Config.DureeExtraction:=MyStrToFloat(Ini.ReadString('MAP','DureeExtraction','60'));
Config.VitesseRapide:=MyStrToFloat(Ini.ReadString('MAP','VitesseRapide','21.8'));
Config.VitesseLente:=MyStrToFloat(Ini.ReadString('MAP','VitesseLente','2.85'));
Config.DureeImpulsionIncrementale:=MyStrToFloat(Ini.ReadString('MAP','DureeImpulsionIncrementale','500'));
Config.DureeMaxManoeuvre:=MyStrToFloat(Ini.ReadString('MAP','DureeMaxManoeuvre','2000'));
Config.UseVitesseRapide:=Ini.ReadString('MAP','UseVitesseRapide','Oui')='Oui';
Config.UseCmdCorrRapideAutoV:=Ini.ReadString('MAP','UseCmdCorrRapide','Oui')='Oui';
Config.UseCmdCorrLenteAutoV:=Ini.ReadString('MAP','UseCmdCorrLente','Oui')='Oui';

FWHMTestCourantInit:=MyStrToFloat(Ini.ReadString('MAP','FWHMTest',FloatToStr((Config.DiametreExtreme-Config.DiametreProche)/2)));
FWHMTestCourant:=FWHMTestCourantInit;

Config.OldVersion:=MyStrToFloat(Ini.ReadString('Soft','Version','-1'));

Config.BestOfDFWHM:=MyStrToFloat(Ini.ReadString('Soft','BestOfDFWHM','0.3'));
Config.BestOfFWHMMax:=MyStrToFloat(Ini.ReadString('Soft','BestOfFWHMMax','10'));

Config.DomeUpdate:=Ini.ReadString('Dome','DomeUpdate','Oui')='Oui';
Config.DomeCoordUpdate:=MyStrToFloat(Ini.ReadString('Dome','CoordUpdate','10'));

Config.Verbose:=Ini.ReadString('Soft','Verbose','Non')='Oui';
Config.Periodic:=Ini.ReadString('Telescope','Periodic','Oui')='Oui';
Config.UseProfil:=Ini.ReadString('Telescope','UseProfil','Oui')='Oui';

finally
if ini <> nil then
   begin
   Ini.UpdateFile;
   Ini.Free;
   end;
end;
end;

procedure Tpop_conf.Button7Click(Sender: TObject);
begin
PBFolderDialog1.Folder:=config.RepGSC;
if PBFolderDialog1.Execute then
   if Length(PBFolderDialog1.Folder)<>0 then
      begin
      config.RepGSC:=PBFolderDialog1.Folder;
      outPanel7.Caption:=comprimetexte(config.RepGSC,30);
      UpdateCat;
      end;
end;


procedure Tpop_conf.Button8Click(Sender: TObject);
begin
PBFolderDialog1.Folder:=config.RepCatalogsBase;
if PBFolderDialog1.Execute then
   if Length(PBFolderDialog1.Folder)<>0 then
      begin
      config.RepCatalogsBase:=PBFolderDialog1.Folder;
      outPanel8.Caption:=comprimetexte(config.RepCatalogsBase,30);
      UpdateCat;
      end;
end;

procedure Tpop_conf.Button10Click(Sender: TObject);
begin
PBFolderDialog1.Folder:=config.RepTycho2;
if PBFolderDialog1.Execute then
   if Length(PBFolderDialog1.Folder)<>0 then
      begin
      config.RepTycho2:=PBFolderDialog1.Folder;
      outPanel9.Caption:=comprimetexte(config.RepTycho2,30);
      UpdateCat;
      end;
end;

procedure Tpop_conf.Button9Click(Sender: TObject);
begin
PBFolderDialog1.Folder:=config.RepUSNO;
if PBFolderDialog1.Execute then
   if Length(PBFolderDialog1.Folder)<>0 then
      begin
      config.RepUSNO:=PBFolderDialog1.Folder;
      outPanel10.Caption:=comprimetexte(config.RepUSNO,30);
      UpdateCat;
      end;
end;

procedure Tpop_conf.Button11Click(Sender: TObject);
begin
PBFolderDialog1.Folder:=config.RepMicroCat;
if PBFolderDialog1.Execute then
   if Length(PBFolderDialog1.Folder)<>0 then
      begin
      config.RepMicroCat:=PBFolderDialog1.Folder;
      outPanel11.Caption:=comprimetexte(config.RepMicroCat,30);
      UpdateCat;
      end;
end;

procedure Tpop_conf.CheckBox15Click(Sender: TObject);
begin
if not(UpdatingControls) then config.CalibrateSuivi:=False;
if CheckBox15.Checked then config.UseTrackSt7:=False else config.UseTrackSt7:=True;
end;

procedure Tpop_conf.TreeView1Click(Sender: TObject);
var
   i:Integer;
   s:string;
   Found:Boolean;
begin
Found:=False;
for i:=0 to TreeView1.Items.Count-1 do
   begin
   if (TreeView1.Items[i].Selected) then //and (treeview1.items[i].level>0) then
      begin
      s:=TreeView1.Items[i].Text;
      DisplayOptions(s);
      Break;
      Found:=True;
      end;
   if Found then Exit;
   end;
end;


procedure Tpop_conf.DisplayOptions(s:string);
var
   i:Integer;
   Keep:Integer;
   t:TTabSheet;
begin
Keep:=-1;
if s=lang('Système') then keep:=0;
if s=lang('Répertoires Images') then keep:=1;
if s=lang('Répertoires Catalogues') then keep:=2;
if s=lang('Photométrie') then keep:=4;
if s=lang('Lieu') then keep:=5;
if s=lang('Sauvegarde des images') then keep:=6;
if s=lang('Visualisation') then keep:=7;
if s=lang('Port série télescope') then keep:=8;
if s=lang('Port série map') then keep:=9;
if s=lang('Télescope') then keep:=10;
if s=lang('Pointage') then keep:=11;
if s=lang('Guidage') then keep:=12;
if s=lang('Park') then keep:=13;
if s=lang('Mise au Point') then begin keep:=14; s:='Focuseur'; end;
if s=lang('Dome') then keep:=15;
if s=lang('Commande corrigée') then keep:=16;
if s=lang('Port Série Serveur d''Heure') then keep:=17;
if s=lang('Serveur d''heure') then keep:=18;

if s=lang('Optimisation') then keep:=19;

if s=lang('Caméra Principale') then keep:=20;
if s=lang('Caméra de Guidage') then keep:=21;
if s=lang('Mesures') then keep:=22;
if s=lang('Pose') then keep:=23;
if s='CFW8' then keep:=24; //nolang

if s=lang('Autofocus A') then keep:=25;
if s=lang('Autofocus V') then keep:=3;

if s='MySQL' then keep:=26;     //nolang   //Dernier

for i:=0 to outpagecontrol1.PageCount-1 do outpagecontrol1.pages[i].tabvisible:=false;

if keep<>-1 then
   begin
   outpagecontrol1.Pages[keep].tabvisible:=true;
   outpagecontrol1.Pages[keep].caption:=s;
   outpagecontrol1.visible:=true;
   end;
end;

procedure Tpop_conf.FormShow(Sender: TObject);
var
   i,j:Integer;
begin
outPageControl1.Height:=373;
Height:=430;
BitBtn1.Top:=377;
BitBtn2.Top:=377;

UpDateLang(Self);

// On sauve l'état du matériel
CameraBrancheeSave:=Config.CameraBranchee;
CameraSuiviBrancheeSave:=Config.CameraSuiviBranchee;
TelescopeBrancheSave:=Config.TelescopeBranche;
FocuserBrancheSave:=Config.FocuserBranche;
DomeBrancheSave:=Config.DomeBranche;
HourServerBrancheSave:=Config.HourServerBranche;

// On déconnecte le matériel
CameraDisconnect;
CameraSuiviDisconnect;
if not Focuser.IsDependantOfTheScope then FocuserDisconnect;
TelescopeDisconnect;
DomeDisconnect;
HourServerDisconnect;

update_conf_edits;
UpdateCat;
UpdateCameraConf;
UpdateCameraSuiviConf;

// Pour appeller une des pages de config à partir des menus
// Pas moyen de faire autrement !
if NameOfTabToDisplay<>'' then
   begin
   for i:=0 to TreeView1.Items.Count-1 do
      if TreeView1.Items[i].Text=NameOfTabToDisplay then j:=i;
   TreeView1.Selected:=TreeView1.Items[j];
   Treeview1.Items[j].Selected:=True;
   TreeView1Click(Sender);
   end;
end;

procedure Tpop_conf.UpdateCat;
begin
   CheckCat;
   // Listbox
   ListBox1.Clear;
   if Config.CatNGCPresent then ListBox1.Items.Add('NGC');     //nolang
   if Config.CatBSCPresent then ListBox1.Items.Add('BSC');     //nolang
   if Config.CatPGCPresent then ListBox1.Items.Add('PGC');     //nolang
   if Config.CatRC3Present then ListBox1.Items.Add('RC3');     //nolang
   if Config.CatWDSPresent then ListBox1.Items.Add('WDS');     //nolang
   if Config.CatGCVPresent then ListBox1.Items.Add('GCV');     //nolang
   if Config.CatMCTPresent then ListBox1.Items.Add('MCT');     //nolang
   if Config.CatUSNOPresent then ListBox1.Items.Add('USNO');   //nolang
   if Config.CatGSCCPresent then ListBox1.Items.Add('GSC');    //nolang
   if Config.CatTY2Present then ListBox1.Items.Add('TYCHO2');  //nolang
end;

procedure Tpop_conf.RadioGroup5Click(Sender: TObject);
begin
  config.TypeGSC:=radiogroup5.ItemIndex;
  UpdateCat;
end;

procedure Tpop_conf.UpdateCameraConf;
var
   Path:string;
begin
Path:=ExtractFilePath(Application.ExeName);
PluginCameraSuivi:=False;

// Attention si c'est le plugin, faut tester si il existe avant sinon ca crashe a coup sur !!!!
if RadioGroup2.ItemIndex=Plugin then
   begin
   Label188.Visible:=True;
   Edit2.Visible:=True;
   if not(FileExists(Path+Edit2.Text)) then
      begin
      WriteSpy(Path+Edit2.Text+' n''existe pas');
      Exit;
      end;
   Config.CameraPlugin:=Edit2.Text;
   end
else
   begin
   Label188.Visible:=False;
   Edit2.Visible:=False;
   end;

// On cree la camera choisie
case RadioGroup2.ItemIndex of
             Aucune:Camera:=TCameraVirtual.Create;
      Hisis2214Bits:Camera:=TCameraHisis14.Create;
      Hisis2212Bits:Camera:=TCameraHisis12.Create;
                ST7:Camera:=TCameraST7.Create;
                ST8:Camera:=TCameraST8.Create;
          Audine400:Camera:=TCameraAudine400.Create;
      AudineObtu400:Camera:=TCameraAudineObtu400.Create;
         Audine1600:Camera:=TCameraAudine1600.Create;
     AudineObtu1600:Camera:=TCameraAudineObtu1600.Create;
             Plugin:Camera:=TCameraPlugin.Create;
             Webcam:Camera:=TCameraWebcam.Create;
            STTrack:Camera:=TCameraSTTrack.Create;
          Virtuelle:Camera:=TCameraVirtual.Create;
         Audine3200:Camera:=TCameraAudine3200.Create;
     AudineObtu3200:Camera:=TCameraAudineObtu3200.Create;
                ST9:Camera:=TCameraST9.Create;
               ST10:Camera:=TCameraST10.Create;
   end;

try
// On affiche que les controles utiles
if Camera.HasTemperature then
   begin
   Label76.Visible:=True;
   Edit41.Visible:=True;
   Label77.Visible:=True;
   end
else
   begin
   Label76.Visible:=False;
   Edit41.Visible:=False;
   Label77.Visible:=False;
   end;

if Camera.NeedEmptyingDelay then
   begin
   Label149.Visible:=True;
   NbreEdit18.Visible:=True;
   Label150.Visible:=True;
   end
else
   begin
   Label149.Visible:=False;
   NbreEdit18.Visible:=False;
   Label150.Visible:=False;
   end;

if Camera.NeedReadingDelay then
   begin
   Label31.Visible:=True;
   Edit11.Visible:=True;
   Label82.Visible:=True;
   end
else
   begin
   Label31.Visible:=False;
   Edit11.Visible:=False;
   Label82.Visible:=False;
   end;

if Camera.NeedCloseShutterDelay then
   begin
   Label83.Visible:=True;
   audine_obtu_text.Visible:=True;
   Label81.Visible:=True;
   end
else
   begin
   Label83.Visible:=False;
   audine_obtu_text.Visible:=False;
   Label81.Visible:=False;
   end;

if Camera.NeedPixelSize then
   begin
   Label167.Visible:=True;
   Label168.Visible:=True;
   Label154.Visible:=True;
   Label187.Visible:=True;
   NbreEdit22.Visible:=True;
   NbreEdit23.Visible:=True;
   end
else
   begin
   Label167.Visible:=False;
   Label168.Visible:=False;
   Label154.Visible:=False;
   Label187.Visible:=False;
   NbreEdit22.Visible:=False;
   NbreEdit23.Visible:=False;
   end;

//if (RadioGroup2.ItemIndex=3) or (RadioGroup2.ItemIndex=7) or (RadioGroup2.ItemIndex=8) then
//   cb_coupe_ampli.Visible:=True else cb_coupe_ampli.Visible:=False;
if Camera.CanCutAmpli then cb_coupe_ampli.Visible:=True
else cb_coupe_ampli.Visible:=False;

//if (RadioGroup2.ItemIndex=4) or (RadioGroup2.ItemIndex=5) then
//   Label58.Caption:=lang('Pose 3x3 :')
//else Label58.Caption:=lang('Pose 4x4 :');
if Camera.IsAValidBinning(3) then Label58.Caption:=lang('Pose 3x3 :');

if Camera.HasCfgWindow then Button13.Visible:=True else Button13.Visible:=False;



finally
// On libere le camera courant
Camera.Free;
end;
end;

procedure Tpop_conf.UpdateCameraSuiviConf;
var
   Path:string;
begin
Path:=ExtractFilePath(Application.ExeName);
PluginCameraSuivi:=True;

// Attention si c'est le plugin, faut tester si il existe avant sinon ca crashe a coup sur !!!!
if RadioGroup11.ItemIndex=Plugin then
   begin
   Label161.Visible:=True;
   Edit46.Visible:=True;
   if not(FileExists(Path+Edit46.Text)) then Exit;
   Config.CameraPluginSuivi:=Edit46.Text;
   end
else
   begin
   Label161.Visible:=False;
   Edit46.Visible:=False;
   end;

// On cree la camera choisie
case RadioGroup11.ItemIndex of
             Aucune:CameraSuivi:=TCameraVirtual.Create;
      Hisis2214Bits:CameraSuivi:=TCameraHisis14.Create;
      Hisis2212Bits:CameraSuivi:=TCameraHisis12.Create;
                ST7:CameraSuivi:=TCameraST7.Create;
                ST8:CameraSuivi:=TCameraST8.Create;
          Audine400:CameraSuivi:=TCameraAudine400.Create;
      AudineObtu400:CameraSuivi:=TCameraAudineObtu400.Create;
         Audine1600:CameraSuivi:=TCameraAudine1600.Create;
     AudineObtu1600:CameraSuivi:=TCameraAudineObtu1600.Create;
             Plugin:CameraSuivi:=TCameraPlugin.Create;
             Webcam:CameraSuivi:=TCameraWebcam.Create;
            STTrack:CameraSuivi:=TCameraSTTrack.Create;
          Virtuelle:CameraSuivi:=TCameraVirtual.Create;
         Audine3200:CameraSuivi:=TCameraAudine3200.Create;
     AudineObtu3200:CameraSuivi:=TCameraAudineObtu3200.Create;
                ST9:CameraSuivi:=TCameraST9.Create;
               ST10:CameraSuivi:=TCameraST10.Create;
   end;

try
// On affiche que les controles utiles
if CameraSuivi.NeedEmptyingDelay then
   begin
   Label157.Visible:=True;
   NbreEdit19.Visible:=True;
   Label158.Visible:=True;
   end
else
   begin
   Label157.Visible:=False;
   NbreEdit19.Visible:=False;
   Label158.Visible:=False;
   end;

if CameraSuivi.NeedReadingDelay then
   begin
   Label70.Visible:=True;
   Edit10.Visible:=True;
   Label156.Visible:=True;
   end
else
   begin
   Label70.Visible:=False;
   Edit10.Visible:=False;
   Label156.Visible:=False;
   end;

if CameraSuivi.NeedCloseShutterDelay then
   begin
   Label162.Visible:=True;
   Edit47.Visible:=True;
   Label163.Visible:=True;
   end
else
   begin
   Label162.Visible:=False;
   Edit47.Visible:=False;
   Label163.Visible:=False;
   end;

if CameraSuivi.NeedPixelSize then
   begin
   Label165.Visible:=True;
   Label166.Visible:=True;
   Label189.Visible:=True;
   Label190.Visible:=True;
   NbreEdit20.Visible:=True;
   NbreEdit21.Visible:=True;
   end
else
   begin
   Label165.Visible:=False;
   Label166.Visible:=False;
   Label189.Visible:=False;
   Label190.Visible:=False;
   NbreEdit20.Visible:=False;
   NbreEdit21.Visible:=False;
   end;

//if (RadioGroup2.ItemIndex=3) or (RadioGroup2.ItemIndex=7) or (RadioGroup2.ItemIndex=8) then
//   cb_coupe_ampli.Visible:=True else cb_coupe_ampli.Visible:=False;
if CameraSuivi.CanCutAmpli then CheckBox9.Visible:=True
else CheckBox9.Visible:=False;

finally
// On libere le camera courant
CameraSuivi.Free;
end;

{case RadioGroup11.ItemIndex of
   0:NoteBook2.ActivePage:='Aucune';             //nolang
   1:NoteBook2.ActivePage:='Hisis';              //nolang
   2:NoteBook2.ActivePage:='Hisis';              //nolang
   3:NoteBook2.ActivePage:='AudineSansObtu';     //nolang
   4:NoteBook2.ActivePage:='ST7';                //nolang
   5:NoteBook2.ActivePage:='ST7';                //nolang
   6:NoteBook2.ActivePage:='Webcam';             //nolang
   7:NoteBook2.ActivePage:='Plugin';             //nolang
   8:NoteBook2.ActivePage:='AudineObtuDavid';    //nolang
   9:NoteBook2.ActivePage:='STTrack';            //nolang
   10:NoteBook2.ActivePage:='Virtuelle';         //nolang
   11:NoteBook2.ActivePage:='AudineSansObtu';    //nolang
   12:NoteBook2.ActivePage:='AudineObtuDavid';   //nolang
   13:NoteBook2.ActivePage:='AudineSansObtu';    //nolang
   14:NoteBook2.ActivePage:='AudineObtuDavid';   //nolang
   15:NoteBook2.ActivePage:='ST7';               //nolang
   16:NoteBook2.ActivePage:='ST7';               //nolang
   end;
if (RadioGroup11.ItemIndex=3) or (RadioGroup11.ItemIndex=8) then
   CheckBox9.Visible:=True else CheckBox9.Visible:=False;}
end;

procedure Tpop_conf.RadioGroup2Click(Sender: TObject);
begin
if (Radiogroup2.ItemIndex=Webcam) and (Radiogroup11.ItemIndex=Webcam) then
   begin
   Showmessage(lang('Les caméras principale et de suivit ne peuvent pas être deux Webcam.'));
   Radiogroup2.ItemIndex:=0;
   end;
if not UpdatingControls then UpdateFWHM;
UpdateCameraConf;
end;

procedure Tpop_conf.RadioGroup11Click(Sender: TObject);
begin
if (Radiogroup2.ItemIndex=Webcam) and (Radiogroup11.ItemIndex=Webcam) then
   begin
   Showmessage(lang('Les caméras principale et de suivit ne peuvent pas être deux Webcam.'));
   Radiogroup11.ItemIndex:=0;
   end;
UpdateCameraSuiviConf;
end;

procedure Tpop_conf.NbreEdit20Change(Sender: TObject);
begin
 NbreEdit22.text:=NbreEdit20.text;
end;

procedure Tpop_conf.NbreEdit21Change(Sender: TObject);
begin
 NbreEdit23.text:=NbreEdit21.text;
end;

procedure Tpop_conf.NbreEdit22Change(Sender: TObject);
begin
 NbreEdit20.text:=NbreEdit22.text;
end;

procedure Tpop_conf.NbreEdit23Change(Sender: TObject);
begin
 NbreEdit21.text:=NbreEdit23.text;
end;

procedure Tpop_conf.RadioGroup12Click(Sender: TObject);
begin
if radiogroup12.itemindex=3 then panel1.visible:=true
                            else panel1.visible:=false;
end;

procedure Tpop_conf.FormCreate(Sender: TObject);
var
   i:Integer;
begin
// Pour indiquer qu'on est en config !
Config.InPopConf:=True;
NameOfTabToDisplay:='';
MaskLat.EditMask:='!#90'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
   Config.UnitesSecondesDelta+';1;_'; //nolang
MaskLong.EditMask:='!#90'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
   Config.UnitesSecondesDelta+';1;_'; //nolang

for i:=Pop_Main.MDIChildCount-1 downto 0 do
   if Pop_Main.MDIChildren[i] is TPop_Image then
      begin
      (Pop_Main.MDIChildren[i] as TPop_Image).ReinitialisePhotometrie;
      (Pop_Main.MDIChildren[i] as TPop_Image).VisuImg;
      end;
end;

procedure Tpop_conf.UpdateScope;
begin
// On cree le scope choisi
case RadioGroup10.ItemIndex of
   0:Telescope:=TTelescopeNone.Create;
   1:Telescope:=TTelescopeLX200.Create;
   2:Telescope:=TTelescopeC3.Create;
   3:Telescope:=TTelescopeVirtuel.Create;
   4:Telescope:=TTelescopeAPGTO.Create;
   5:Telescope:=TTelescopePISCO.Create;
   6:Telescope:=TTelescopeNone.Create;
   7:Telescope:=TTelescopeAutoStar.Create;
   end;

try

if (RadioGroup10.ItemIndex=0) or (RadioGroup10.ItemIndex=6) then
   begin
   Label3.Visible:=False;
   Label49.Visible:=False;
   Label19.Visible:=False;
   Label60.Visible:=False;
   Edit3.Visible:=False;
   Edit34.Visible:=False;
   CheckBox18.Visible:=False;
   CheckBox13.Visible:=False;
   CheckBox21.Visible:=False;
   GroupBox7.Visible:=False;
   HideNode(Lang('Pointage'));
   HideNode(Lang('Park'));
   HideNode(Lang('Port série télescope'));
   end
else
   begin
   Label3.Visible:=True;
   Label49.Visible:=True;
   Label19.Visible:=True;
   Label60.Visible:=True;
   Edit3.Visible:=True;
   Edit34.Visible:=True;
   CheckBox18.Visible:=True;
   CheckBox13.Visible:=True;
   CheckBox21.Visible:=True;
   GroupBox7.Visible:=True;
   ShowNode(Lang('Pointage'),Lang('Télescope'));
   ShowNode(Lang('Park'),Lang('Télescope'));
   end;

// On affiche que les controles utiles
if Telescope.NeedComName or Telescope.NeedComAdress then
   ShowNode(Lang('Port série télescope'),Lang('Télescope'))
else
   HideNode(Lang('Port série télescope'));

if Telescope.NeedComName then
   begin
   Label11.Visible:=True;
   outComboBox1.Visible:=True;
   end
else
   begin
   Label11.Visible:=False;
   outComboBox1.Visible:=False;
   end;

if Telescope.NeedComAdress then
   begin
   LabelAdressCom.Visible:=True;
   outComboBoxAdressCom.Visible:=True;
   end
else
   begin
   LabelAdressCom.Visible:=False;
   outComboBoxAdressCom.Visible:=False;
   end;

if Telescope.CanSetSpeed then
   begin
   Label6.Visible:=True;
   Label22.Visible:=True;
   SpinEdit9.Visible:=True;
   end
else
   begin
   Label6.Visible:=False;
   Label22.Visible:=False;
   SpinEdit9.Visible:=False;
   end;

finally
// On libere le telescope courant
Telescope.Free;
Telescope:=nil;
end;
end;

procedure Tpop_conf.UpdateDome;
begin
// On cree le focuseur choisi
case RadioGroup9.ItemIndex of
   0:Dome:=TDomeNone.Create;
   1:Dome:=TDomePlugin.Create;
   end;

{Dome.Open;
Config.DomeBranche:=Dome.IsConnectedAndOK;
if not Config.DomeBranche then
   begin
   Dome.Free;
   RadioGroup9.ItemIndex:=0;
   Dome:=TDomeNone.Create;
   end;}

{if RadioGroup9.ItemIndex=1 then
   begin
   Label155.Visible:=True;
   Edit6.Visible:=True;
   end
else
   begin
   Label155.Visible:=False;
   Edit6.Visible:=False;
   end;}

{if Dome.NeedCoordinates then
   begin
   CheckBox19.Visible:=True;
   NbreEdit38.Visible:=True;
   Label195.Visible:=True;
   end
else
   begin
   CheckBox19.Visible:=False;
   NbreEdit38.Visible:=False;
   Label195.Visible:=False;
   end;}

try
// On affiche que les controles utiles

finally
// On libere le focuseur courant
Dome.Free;
end;
end;

procedure Tpop_conf.HideNode(NodeName:string);
var
   i:Integer;
begin
i:=0;
while i<=TreeView1.Items.Count-1 do
   begin
   if TreeView1.Items[i].Text=NodeName then
      TreeView1.Items[i].Delete
   else Inc(i);
   end;
end;

procedure Tpop_conf.ShowNode(NodeName,ParentNode:string);
var
   i:Integer;
   Found:Boolean;
   MyTreeNode1,MyTreeNode2:TTreeNode;
begin
i:=0;
Found:=False;
while i<=TreeView1.Items.Count-1 do
   begin
   if TreeView1.Items[i].Text=NodeName then Found:=True;
   Inc(i);
   end;

if not Found then
   begin
   i:=0;
   while i<=TreeView1.Items.Count-1 do
      begin
      if TreeView1.Items[i].Text=ParentNode then
         MyTreeNode1:=TreeView1.Items[i];
      Inc(i);
      end;

   TreeView1.Items.AddNode(nil,MyTreeNode1,NodeName,nil,naAddChild);
   end;
end;

procedure Tpop_conf.UpdateFocuser;
var
   Path:string;
begin
Path:=ExtractFilePath(Application.ExeName);

// On cree le focuseur choisi
case RadioGroup6.ItemIndex of
   0:Focuser:=TFocuserVirtuel.Create;
   1:Focuser:=TFocuserLX200.Create;
   2:Focuser:=TFocuserRoboFocus.Create;
   3:Focuser:=TFocuserVirtuel.Create;
   4:Focuser:=TFocuserLX200GPS.Create;
   5:Focuser:=TFocuserPlugin.Create;
   end;

try

if RadioGroup6.ItemIndex=0 then
   begin
   CheckBoxInvFoc.Visible:=False;
   LabelInvFoc1.Visible:=False;
   LabelInvFoc2.Visible:=False;
   LabelInvFoc3.Visible:=False;
   LabelInvFoc4.Visible:=False;
   LabelInvFoc5.Visible:=False;

   HideNode(Lang('Mesures'));
   HideNode(Lang('Commande corrigée'));
   HideNode(Lang('Autofocus A'));
   HideNode(Lang('Autofocus V'));
   HideNode(Lang('Optimisation'));
   end
else
   begin
   CheckBoxInvFoc.Visible:=True;
   LabelInvFoc1.Visible:=True;
   LabelInvFoc2.Visible:=True;
   LabelInvFoc3.Visible:=True;
   LabelInvFoc4.Visible:=True;
   LabelInvFoc5.Visible:=True;

   ShowNode(Lang('Mesures'),Lang('Mise au Point'));
   ShowNode(Lang('Commande corrigée'),Lang('Mise au Point'));
   ShowNode(Lang('Autofocus A'),Lang('Mise au Point'));
   ShowNode(Lang('Autofocus V'),Lang('Mise au Point'));
   ShowNode(Lang('Optimisation'),Lang('Mise au Point'));
   end;

// Attention si c'est le plugin, faut tester si il existe avant sinon ca crashe a coup sur !!!!
if RadioGroup6.ItemIndex=5 then
   begin
   Label194.Visible:=True;
   Edit5.Visible:=True;
   if not(FileExists(Path+Edit5.Text)) then
      begin
      WriteSpy(Path+Edit5.Text+' n''existe pas');
      Exit;
      end;
   Config.FocuserPlugin:=Edit5.Text;
   end
else
   begin
   Label194.Visible:=False;
   Edit5.Visible:=False;
   end;

if Focuser.IsDependantOfTheScope then
   begin
   CheckBox17.Visible:=True;
   Label191.Visible:=True;
   end
else
   begin
   CheckBox17.Visible:=False;
   Label191.Visible:=False;
   end;

if Focuser.IsDependantOfTheScope or not(Focuser.UseComPort) then
   begin
   Label140.Visible:=False;
   outCombobox2.Visible:=False;

   HideNode(Lang('Port série map'));
   end
else
   begin
   Label140.Visible:=True;
   outCombobox2.Visible:=True;

   ShowNode(Lang('Port série map'),Lang('Mise au Point'));
   end;

// On affiche que les controles utiles
if Focuser.MustSetMaxPosition then
   begin
   Label186.Visible:=True;
   SpinEdit11.Visible:=True;
   end
else
   begin
   Label186.Visible:=False;
   SpinEdit11.Visible:=False;
   end

finally
// On libere le focuseur courant
Focuser.Free;
end;
end;

procedure Tpop_conf.RadioGroup10Click(Sender: TObject);
begin
UpdateScope;
end;

procedure Tpop_conf.Button6Click(Sender: TObject);
begin
load_config.InitialDir:=Config.RepImagesAcq;
load_config.Filter:=lang('Fichier cosmétique (*.cos)|*.cos');
if load_config.Execute then
   begin
   EditCosmetic.Text:=ExtractFileName(load_config.FileName);
   end;
end;

procedure Tpop_conf.NbreEdit2Change(Sender: TObject);
begin
if (Config.TypeCamera=ST7) or (Config.TypeCamera=ST8) then
   if (Config.TypeCameraSuivi=STTrack) then
      if NbreEdit2.Text<>'' then
         begin
         Config.OrientationCCD:=MyStrToFloat(NbreEdit2.Text);
         Config.OrientationCCDGuidage:=Config.OrientationCCD;
         NbreEdit27.Text:=NbreEdit2.Text;
         end;
end;

procedure Tpop_conf.NbreEdit27Change(Sender: TObject);
begin
if (Config.TypeCamera=ST7) or (Config.TypeCamera=ST8) then
   if (Config.TypeCameraSuivi=STTrack) then
      if NbreEdit27.Text<>'' then
         begin
         Config.OrientationCCDGuidage:=MyStrToFloat(NbreEdit27.Text);
         Config.OrientationCCD:=Config.OrientationCCDGuidage;
         NbreEdit2.Text:=NbreEdit27.Text;
         end;
end;

procedure Tpop_conf.CheckBoxInvFocClick(Sender: TObject);
begin
Config.FocInversion:=CheckBoxInvFoc.Checked;
end;

procedure Tpop_conf.UpdateFWHM;
var
   DistFast:Double;
   DistSlow:Double;
begin
PluginCameraSuivi:=false;
case Config.TypeCamera of
          Aucune:Camera:=TCameraVirtual.Create;
   Hisis2214Bits:Camera:=TCameraHisis14.Create;
   Hisis2212Bits:Camera:=TCameraHisis12.Create;
             ST7:Camera:=TCameraST7.Create;
             ST8:Camera:=TCameraST8.Create;
       Audine400:Camera:=TCameraAudine400.Create;
   AudineObtu400:Camera:=TCameraAudineObtu400.Create;
      Audine1600:Camera:=TCameraAudine1600.Create;
  AudineObtu1600:Camera:=TCameraAudineObtu1600.Create;
          Plugin:Camera:=TCameraPlugin.Create;
          Webcam:Camera:=TCameraWebcam.Create;
         STTrack:Camera:=TCameraSTTrack.Create;
       Virtuelle:Camera:=TCameraVirtual.Create;
      Audine3200:Camera:=TCameraAudine3200.Create;
  AudineObtu3200:Camera:=TCameraAudineObtu3200.Create;
             ST9:Camera:=TCameraST9.Create;
            ST10:Camera:=TCameraST10.Create;
      end;

try

if Edit25.Text<>'' then
   begin
   config.FwhmStopFast:=MyStrToFloat(Edit25.Text);
   if Config.FocaleTele<>0 then
      begin
      DistFast:=ArcTan(Sqrt((Sqr(config.FwhmStopFast*Camera.GetXPixelSize/1e6)/2
         +Sqr(config.FwhmStopFast*Camera.GetYPixelSize/1e6)/2))/Config.FocaleTele*1000)*180/Pi*3600;
      LabelFwhm1.Caption:='FWHM de transition = '+MyFloatToStr(DistFast,2)
         +' arcsec'; //nolang
      end
   else
      LabelFwhm1.Caption:='FWHM de transition = ??? arcsec';
   end;

if Edit31.Text<>'' then
   begin
   config.FwhmStopSlow:=MyStrToFloat(Edit31.Text);
   if Config.FocaleTele<>0 then
      begin
      DistSlow:=ArcTan(Sqrt((Sqr(config.FwhmStopSlow*Camera.GetXPixelSize/1e6)/2
         +Sqr(config.FwhmStopSlow*Camera.GetYPixelSize/1e6)/2))/Config.FocaleTele*1000)*180/Pi*3600;
      LabelFwhm2.Caption:='FWHM d''arrêt = '+MyFloatToStr(DistSlow,2)
         +' arcsec'; //nolang
      end
   else
      LabelFwhm2.Caption:='FWHM d''arrêt = ??? arcsec';
   end;

UpdateStop;

finally
Camera.Free;
end;
end;

procedure Tpop_conf.Edit25Change(Sender: TObject);
begin
if not UpdatingControls then UpdateFWHM;
end;

procedure Tpop_conf.Edit31Change(Sender: TObject);
begin
if not UpdatingControls then UpdateFWHM;
end;

procedure Tpop_conf.UdpateHourServer;
begin
// On cree le serveur d'heure choisi
case RadioGroupHS.ItemIndex of
   0:HourServer:=THourServerCMOS.Create;
   1:HourServer:=THourServerCMOS2.Create;
   2:HourServer:=THourServerWindows.Create;
   3:HourServer:=THourServerEventMarker.Create;
   end;

try
// On affiche que les controles utiles
if HourServer.UseComPort then
   begin
   LabelPortHS.Visible:=True;
   outComboBoxPortHS.Visible:=True;
   end
else
   begin
   LabelPortHS.Visible:=False;
   outComboBoxPortHS.Visible:=False;
   end;

finally
// On liberer le serveur d'heure courant
HourServer.Free;
end;
end;

procedure Tpop_conf.RadioGroupHSClick(Sender: TObject);
begin
UdpateHourServer
end;

procedure Tpop_conf.CheckBoxCorFastClick(Sender: TObject);
begin
Config.CorrectionAutoFast:=CheckBoxCorFast.Checked;
end;

procedure Tpop_conf.CheckBoxCorSlowClick(Sender: TObject);
begin
Config.CorrectionAutoSlow:=CheckBoxCorSlow.Checked;
end;

procedure Tpop_conf.Button12Click(Sender: TObject);
var
   pop_decalage_obs:Tpop_decalage_obs;
begin
   if Config.NbDecalageSuivi<>0 then
      begin
      Freemem(Config.DecalageSuiviX,Config.NbDecalageSuivi*8);
      Freemem(Config.DecalageSuiviY,Config.NbDecalageSuivi*8);
      Config.NbDecalageSuivi:=0;
      end;

   pop_decalage_obs:=Tpop_decalage_obs.Create(Application);
   pop_decalage_obs.ShowModal;

   pop_main.OpenDcl;
end;

procedure Tpop_conf.RadioGroup6Click(Sender: TObject);
begin
UpdateFocuser;
end;

procedure Tpop_conf.Edit2Change(Sender: TObject);
begin
UpdateCameraConf;
end;

procedure Tpop_conf.Edit46Change(Sender: TObject);
begin
UpdateCameraSuiviConf;
end;

procedure Tpop_conf.CheckBox10Click(Sender: TObject);
begin
if CheckBox10.Checked then
   begin
   Label201.Enabled:=False;
   Edit18.Enabled:=False;
   end
else
   begin
   Label201.Enabled:=True;
   Edit18.Enabled:=True;
   end;
end;

procedure Tpop_conf.CheckBox16Click(Sender: TObject);
begin
if CheckBox16.Checked then
   begin
   Config.UseDecalages:=True;
   Button12.Enabled:=True;
   end
else
   begin
   Config.UseDecalages:=False;
   Button12.Enabled:=False;
   end;
end;

procedure Tpop_conf.Button13Click(Sender: TObject);
begin
PluginCameraSuivi:=False;

// On cree la camera choisie
case RadioGroup2.ItemIndex of
             Aucune:Camera:=TCameraVirtual.Create;
      Hisis2214Bits:Camera:=TCameraHisis14.Create;
      Hisis2212Bits:Camera:=TCameraHisis12.Create;
                ST7:Camera:=TCameraST7.Create;
                ST8:Camera:=TCameraST8.Create;
          Audine400:Camera:=TCameraAudine400.Create;
      AudineObtu400:Camera:=TCameraAudineObtu400.Create;
         Audine1600:Camera:=TCameraAudine1600.Create;
     AudineObtu1600:Camera:=TCameraAudineObtu1600.Create;
             Plugin:Camera:=TCameraPlugin.Create;
             Webcam:Camera:=TCameraWebcam.Create;
            STTrack:Camera:=TCameraSTTrack.Create;
          Virtuelle:Camera:=TCameraVirtual.Create;
         Audine3200:Camera:=TCameraAudine3200.Create;
     AudineObtu3200:Camera:=TCameraAudineObtu3200.Create;
                ST9:Camera:=TCameraST9.Create;
               ST10:Camera:=TCameraST10.Create;
   end;

try

Camera.ShowCfgWindow;

finally
// On libere le camera courant
Camera.Free;
end;
end;

procedure Tpop_conf.CheckBox19Click(Sender: TObject);
begin
if CheckBox19.Checked then
   begin
   NbreEdit38.Enabled:=True;
   Label195.Enabled:=True;
   end
else
   begin
   NbreEdit38.Enabled:=False;
   Label195.Enabled:=False;
   end;
end;

procedure Tpop_conf.RadioGroup9Click(Sender: TObject);
begin
UpdateDome;
end;

procedure Tpop_conf.UpdateStop;
var
   PosEsp:Integer;
   S:string;
begin
case ComboBoxModel.ItemIndex of
   0:begin
     Label59.Caption:='FWHM de transition :';
     Label64.Caption:='FWHM d''arrêt :';

     S:=LabelFwhm1.Caption;
     PosEsp:=Pos('HFD',S);
     if PosEsp<>0 then
        begin
        Delete(S,1,3);
        LabelFwhm1.Caption:='FWHM'+S;
        end;

     S:=LabelFwhm2.Caption;
     PosEsp:=Pos('HFD',S);
     if PosEsp<>0 then
        begin
        Delete(S,1,3);
        LabelFwhm2.Caption:='FWHM'+S;
        end;
     end;
   1:begin
     Label59.Caption:='HFD de transition :';
     Label64.Caption:='HFD d''arrêt :';

     S:=LabelFwhm1.Caption;
     PosEsp:=Pos('FWHM',S);
     if PosEsp<>0 then
        begin
        Delete(S,1,4);
        LabelFwhm1.Caption:='HFD'+S;
        end;

     S:=LabelFwhm2.Caption;
     PosEsp:=Pos('FWHM',S);
     if PosEsp<>0 then
        begin
        Delete(S,1,4);
        LabelFwhm2.Caption:='HFD'+S;
        end;
     end;
   end;
end;

procedure Tpop_conf.ComboBoxModelChange(Sender: TObject);
begin
UpdateStop;
end;

end.
