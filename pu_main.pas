unit pu_main;

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

{*********************************   TODO   ************************************

- Creer la fonction de recalage d'un lot

- Mettre Degre=0 dans RecaleEtoileLot

- Créer le plugin Scope
- Gros boulot à faire sur le modèle de pointage
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls, Grids, ComCtrls,
  Buttons, Printers, Spin, Mask, Math, IniFiles,  ScktComp, HiResTim,
  u_constants, u_class, ImgList, ToolWin,  pu_image, ActnList, pu_dlg_standard,
  typInfo, AppEvnts, OleCtnrs, WinSvc, Twainy, ShellAPI, TAGraph, PBFolderDialog;

type
  Tpop_main = class(TForm)
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    About1: TMenuItem;
    Configuration1: TMenuItem;
    Outils1: TMenuItem;
    Horloge1: TMenuItem;
    Systeme1: TMenuItem;
    Fichier1: TMenuItem;
    Ouvrir1: TMenuItem;
    Sauver1: TMenuItem;
    Quitter1: TMenuItem;
    Fenetre1: TMenuItem;
    Cascade1: TMenuItem;
    Mosaique1: TMenuItem;
    Aide1: TMenuItem;
    Fermer1: TMenuItem;
    ToutFermer1: TMenuItem;
    N1: TMenuItem;
    Rorganiserlesiconnes1: TMenuItem;
    Toutrduire1: TMenuItem;
    Prtaitements1: TMenuItem;
    Additiondunlot1: TMenuItem;
    Spy1: TMenuItem;
    Covertionde1: TMenuItem;
    Jourlulien1: TMenuItem;
    Moyennedunlot1: TMenuItem;
    Raquettes1: TMenuItem;
    Camra1: TMenuItem;
    Tlescope1: TMenuItem;
    Miseaupoint1: TMenuItem;
    Astrometrie1: TMenuItem;
    Medianedunlot1: TMenuItem;
    Moyenneidentique1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Soustraireuneimageunlot1: TMenuItem;
    Diviserunlotparuneimage1: TMenuItem;
    N4: TMenuItem;
    Lireunheader1: TMenuItem;
    Chercher1: TMenuItem;
    N5: TMenuItem;
    Recalagedunlot1: TMenuItem;
    DownloaderDSS: TMenuItem;
    MecaniqueCeleste1: TMenuItem;
    outVaisala1: TMenuItem;
    RapportGino1: TMenuItem;
    PositionAsteroide1: TMenuItem;
    Asteroide1: TMenuItem;
    CreerFichiertea1: TMenuItem;
    Compositageplantaire1: TMenuItem;
    Sauversous1: TMenuItem;
    outBmp1: TMenuItem;
    outJpeg1: TMenuItem;
    outFits1: TMenuItem;
    outCpa1: TMenuItem;
    outPic1: TMenuItem;
    Analyse1: TMenuItem;
    Statistiquesdunlot1: TMenuItem;
    Prtraitement1: TMenuItem;
    N6: TMenuItem;
    SigmaKappadunlot1: TMenuItem;
    N7: TMenuItem;
    ConnecterleTlescope1: TMenuItem;
    BestofStellaire1: TMenuItem;
    outCodage1: TMenuItem;
    outMettreajourledico1: TMenuItem;
    outMettreajourledicomodele1: TMenuItem;
    outMettreajourlessources1: TMenuItem;
    N8: TMenuItem;
    Changerlelanguage1: TMenuItem;
    Crerunnouveaulanguage1: TMenuItem;
    CpaVersoin4d1: TMenuItem;
    Misejourdunlanguage1: TMenuItem;
    Editiondunlanguage1: TMenuItem;
    outLangMettrejourtouslesdicos1: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    Ajusterlimage1: TMenuItem;
    outLangDetecterlesdoublons1: TMenuItem;
    outLangDtecterlesincohrencesaumodle1: TMenuItem;
    Texte1: TMenuItem;
    Occultations1: TMenuItem;
    ConnecterleFocuser1: TMenuItem;
    Connecterlacamra1: TMenuItem;
    History1: TMenuItem;
    OutIntegrale1: TMenuItem;
    BestofPlantaire1: TMenuItem;
    N11: TMenuItem;
    ProjectionTeleacopique1: TMenuItem;
    ConnecterleDome1: TMenuItem;
    Dome1: TMenuItem;
    Analysemonture1: TMenuItem;
    Connecterlacamradesuivi1: TMenuItem;
    Camradesuivi1: TMenuItem;
    N12: TMenuItem;
    Convertiondetypedefichiers1: TMenuItem;
    ConversionAVI: TMenuItem;
    Conversion1: TMenuItem;
    Miseaupointmanuelle1: TMenuItem;
    Timer1: TTimer;
    OutCadre1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    outTestMoindrescarrs1: TMenuItem;
    outTestMoindrescarrsdegr01: TMenuItem;
    outTestSvdFitAstro1: TMenuItem;
    outTestSvdFitAstrosurcasreel1: TMenuItem;
    DetectionAutomatique1: TMenuItem;
    Crerunprofil1: TMenuItem;
    Nouvellecarteduciel1: TMenuItem;
    ImageList3: TImageList;
    outLangRecherchedelangetnolang1: TMenuItem;
    N13: TMenuItem;
    Gnrelistedepixelschauds1: TMenuItem;
    Prtraiterunlot1: TMenuItem;
    ConnecterleServeurdheure1: TMenuItem;
    Serveurdheure1: TMenuItem;
    Observationrcurente1: TMenuItem;
    Scripts1: TMenuItem;
    Twainy1: TTwainy;
    AcqurirTwain1: TMenuItem;
    NouvelleImage1: TMenuItem;
    PBFolderDialog1: TPBFolderDialog;
    Recalagedimages1: TMenuItem;
    RecalagedimagesstellairesRVB1: TMenuItem;
    Fitsvirgule1: TMenuItem;
    Timer2: TTimer;
    TimerGetPos: TTimer;
    Ouvrirgraphe1: TMenuItem;
    LangTestersurunfichier1: TMenuItem;
    LangTesterlamisejourdessourcessurunfichier1: TMenuItem;
    LangEnleverlesaccents1: TMenuItem;
    AdobePSD1: TMenuItem;
    Sauver2: TMenuItem;
    Bmp1: TMenuItem;
    jpeg1: TMenuItem;
    LangCompleteravecunanciendico1: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    ToolButton29: TToolButton;
    ToolButton30: TToolButton;
    ToolButton31: TToolButton;
    ToolButton32: TToolButton;
    ToolButton33: TToolButton;
    ToolButton34: TToolButton;
    ToolButton35: TToolButton;
    ToolBar2: TToolBar;
    ToolButton36: TToolButton;
    ToolButton37: TToolButton;
    ToolButton38: TToolButton;
    ToolButton39: TToolButton;
    ToolButton40: TToolButton;
    ToolButton41: TToolButton;
    ToolButton42: TToolButton;
    ToolButton43: TToolButton;
    Registration1: TMenuItem;
    Registrationdimagesstellaires1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure About1Click(Sender: TObject);
    procedure Configuration1Click(Sender: TObject);
    procedure Horloge1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure ToutFermer1Click(Sender: TObject);
    procedure Cascade1Click(Sender: TObject);
    procedure Mosaique1Click(Sender: TObject);
    procedure Rorganiserlesiconnes1Click(Sender: TObject);
    procedure Toutrduire1Click(Sender: TObject);
    procedure Additiondunlot1Click(Sender: TObject);
    procedure Spy1Click(Sender: TObject);
    procedure Covertionde1Click(Sender: TObject);
    procedure Jourlulien1Click(Sender: TObject);
    procedure Moyennedunlot1Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure Camra1Click(Sender: TObject);
    procedure Tlescope1Click(Sender: TObject);
    procedure Medianedunlot1Click(Sender: TObject);
    procedure Moyenneidentique1Click(Sender: TObject);
    procedure display_hints(sender:Tobject);
    procedure Soustraireuneimageunlot1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure MiseAJourMenu(Sender: TObject);
    procedure Diviserunlotparuneimage1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Lireunheader1Click(Sender: TObject);
    procedure Chercher1Click(Sender: TObject);
    procedure Recalagedunlot1Click(Sender: TObject);
    procedure DownloaderDSSClick(Sender: TObject);
    procedure outVaisala1Click(Sender: TObject);
    procedure RapportGino1Click(Sender: TObject);
    procedure Compositageplantaire1Click(Sender: TObject);
    procedure outBmp1Click(Sender: TObject);
    procedure outJpeg1Click(Sender: TObject);
    procedure outFits1Click(Sender: TObject);
    procedure outCpa1Click(Sender: TObject);
    procedure outPic1Click(Sender: TObject);
    procedure Statistiquesdunlot1Click(Sender: TObject);
    procedure Miseaupoint1Click(Sender: TObject);
    procedure Prtraitement1Click(Sender: TObject);
    procedure SigmaKappadunlot1Click(Sender: TObject);
    procedure ToolbarButton9718Click(Sender: TObject);
    procedure ConnecterleTlescope1Click(Sender: TObject);
    procedure BestofStellaire1Click(Sender: TObject);
    procedure outMettreajourledico1Click(Sender: TObject);
    procedure outMettreajourledicomodele1Click(Sender: TObject);
    procedure outMettreajourlessources1Click(Sender: TObject);
    procedure Changerlelanguage1Click(Sender: TObject);
    procedure Crerunnouveaulanguage1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CpaVersoin4d1Click(Sender: TObject);
    procedure Misejourdunlanguage1Click(Sender: TObject);
    procedure Editiondunlanguage1Click(Sender: TObject);
    procedure outLangMettrejourtouslesdicos1Click(Sender: TObject);
    procedure Ajusterlimage1Click(Sender: TObject);
    procedure outLangDtecterlesincohrencesaumodle1Click(Sender: TObject);
    procedure Texte1Click(Sender: TObject);
    procedure Occultations1Click(Sender: TObject);
    procedure ConversionAVIClick(Sender: TObject);
    procedure ConnecterleFocuser1Click(Sender: TObject);
    procedure Connecterlacamra1Click(Sender: TObject);
    procedure History1Click(Sender: TObject);
    procedure OutIntegrale1Click(Sender: TObject);
    procedure BestofPlantaire1Click(Sender: TObject);
    procedure ProjectionTeleacopique1Click(Sender: TObject);
    procedure ConnecterleDome1Click(Sender: TObject);
    procedure Analysemonture1Click(Sender: TObject);
    procedure Connecterlacamradesuivi1Click(Sender: TObject);
    procedure Convertiondetypedefichiers1Click(Sender: TObject);
    procedure Miseaupointmanuelle1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure OutCadre1Click(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure outTestMoindrescarrs1Click(Sender: TObject);
    procedure outTestMoindrescarrsdegr01Click(Sender: TObject);
    procedure outTestSvdFitAstro1Click(Sender: TObject);
    procedure outTestSvdFitAstrosurcasreel1Click(Sender: TObject);
    procedure Crerunprofil1Click(Sender: TObject);
    procedure Nouvellecarteduciel1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure outLangRecherchedelangetnolang1Click(Sender: TObject);
    procedure Gnrelistedepixelschauds1Click(Sender: TObject);
    procedure Prtraiterunlot1Click(Sender: TObject);
    procedure ConnecterleServeurdheure1Click(Sender: TObject);
    procedure Dome1Click(Sender: TObject);
    procedure Serveurdheure1Click(Sender: TObject);
    procedure Observationrcurente1Click(Sender: TObject);
    procedure Scripts1Click(Sender: TObject);
    procedure AcqurirTwain1Click(Sender: TObject);
    procedure Twainy1ChangeBitmap(Sender: TObject);
    procedure NouvelleImage1Click(Sender: TObject);
    procedure Recalagedimages1Click(Sender: TObject);
    procedure RecalagedimagesstellairesRVB1Click(Sender: TObject);
    procedure Camradesuivi1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Fitsvirgule1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Imagedetest21Click(Sender: TObject);
    procedure TimerGetPosTimer(Sender: TObject);
    procedure Ouvrirgraphe1Click(Sender: TObject);
    procedure LangTestersurunfichier1Click(Sender: TObject);
    procedure LangTesterlamisejourdessourcessurunfichier1Click(
      Sender: TObject);
    procedure LangEnleverlesaccents1Click(Sender: TObject);
    procedure AdobePSD1Click(Sender: TObject);
    procedure Bmp1Click(Sender: TObject);
    procedure jpeg1Click(Sender: TObject);
    procedure LangCompleteravecunanciendico1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure ToolButton18Click(Sender: TObject);
    procedure ToolButton20Click(Sender: TObject);
    procedure ToolButton21Click(Sender: TObject);
    procedure ToolButton22Click(Sender: TObject);
    procedure ToolButton24Click(Sender: TObject);
    procedure ToolButton25Click(Sender: TObject);
    procedure ToolButton26Click(Sender: TObject);
    procedure ToolButton27Click(Sender: TObject);
    procedure ToolButton29Click(Sender: TObject);
    procedure ToolButton30Click(Sender: TObject);
    procedure ToolButton32Click(Sender: TObject);
    procedure ToolButton33Click(Sender: TObject);
    procedure ToolButton35Click(Sender: TObject);
    procedure ToolButton36Click(Sender: TObject);
    procedure ToolButton37Click(Sender: TObject);
    procedure ToolButton38Click(Sender: TObject);
    procedure ToolButton39Click(Sender: TObject);
    procedure ToolButton41Click(Sender: TObject);
    procedure ToolButton40Click(Sender: TObject);
    procedure ToolButton42Click(Sender: TObject);
    procedure ToolButton43Click(Sender: TObject);
    procedure Registration1Click(Sender: TObject);
    procedure Registrationdimagesstellaires1Click(Sender: TObject);

  private
    { Déclarations privées }

  public

    LastChild:TForm;

    CurrentTimeDate:TDateTime;  // laisser ca
    IAlpha,IDelta:Double;

    // Catalogue BSC a remplacer par celui de Patrick 
//    NomCat:array[1..NbStar] of Str7;
//    AlphaCat,DeltaCat:array[1..NbStar] of Real;
//    MagnCat:array[1..NbStar] of Single;

    AzimuthPRF,HauteurPRF:array[0..360] of Double;

    PosAlphaCourante,PosDeltaCourante:Double;

    CloseRequest:Boolean;

    IdentificationClient:Integer;
    CanContinue:Boolean;
    TabConnect:array[1..1024] of Boolean;
    TexteRecu,CommandRecu:string;
    Reception:Boolean;
    PhotoFini:Boolean;
    StopAnalMonture:Boolean;
    AnalMonture:Boolean;
    InTimer:Boolean;

    HTimerGetPosEvent: THandle;

    procedure SeuilsEnable;
    procedure SeuilsDesable;

    function GiveName(Name:String;Image:Tpop_image):String;

    procedure UpDateGUITelescope;
    procedure UpDateGUIFocuser;
    procedure UpdateGUICamera;
    procedure UpDateGUICameraSuivi;
    procedure UpdateGUIDome;
    procedure UpDateGUIHourServer;
    procedure UpdateGUITypeFichier;

    // Fichier décalage
    procedure OpenDcl;

    procedure AfficheMessage(Titre,MyMessage:string);

    function OpenImage(var pop_image:tpop_image):Boolean;    
    end;

  TThreadGetPos = class(TThread)
    private
     AlphaStr,DeltaStr,LstStr,HAStr,AirMassStr,AzimuthStr,HauteurStr:string;
    protected
     procedure AfficheInfos;
     procedure Execute; override;     
    public
     constructor Create;
    end;
   
    {--------------------------------------------------------------------------}

var
    pop_main: Tpop_main;
    config:tconfig;
    Dico:TStringList;
    IndexDic:array[0..40] of Integer;
    SpyLines:TStrings;
    FWHMTestCourant,FWHMTestCourantInit:Double;
    InitMain:Boolean;
    ThreadGetPos:TThreadGetPos;


implementation

uses pu_conf,
     u_math,
     u_general,
     u_file_io,
     pu_catalogs,
     catalogues,
     u_driver_st7,
     pu_scope,
     pu_spy,
     pu_about,
     pu_info_hdr,
     pu_camera,
     pu_vaisala,
     pu_seuils,
     pu_clock,
     pu_select_lot,
     u_pretraitement,
     pu_rapport,
     pu_conv_coord,
     pu_jour_julien,
     pu_splash,
     pu_script_builder,
     pu_map,
     pu_select_img,
     u_meca,
     u_ephem,
     pu_choix_planete,
     pu_progression,
     pu_dss,
     u_visu,
     u_analyse,
     pu_seuils_color,
     pu_infos_image,
     pu_pretraitements,
     u_lang,
     pu_choose_lang,
     pu_edit_dico,
     pu_avi,
     pu_occult,
     u_focusers,
     pu_calib_astrom,
     u_modelisation,
     u_cameras,
     pu_image_index,
     pu_cree_proj,
     u_filtrage,
     u_dome,
     pu_dome,
     u_telescopes,
     pu_camera_suivi,
     pu_clock_monitor,
     pu_webcam,
     pu_create_prf,
     pu_skychart,
     skychart,
     u_porttalk,
     pu_pretraite_lot,
     u_hour_servers,
     pu_hour_server,
     pu_anal_monture,
     pu_obs_recurrente,
     pu_anal_modele,
     u_modele_pointage,
     pu_graph,
     u_arithmetique;


{$R *.DFM}

{------------------------------------------------------------------------------}

procedure Tpop_main.UpdateGUITypeFichier;
begin
// on indique le format courant dans le menu de conversion
  Conversion1.caption:=lang('Conversion au format ');
  case config.FormatSaveInt of
  0 : Conversion1.caption:=Conversion1.caption+'FITS'; // nolang
  1 : Conversion1.caption:=Conversion1.caption+'CPA V3'; // nolang
  2 : Conversion1.caption:=Conversion1.caption+'PIC'; // nolang
  3 : Conversion1.caption:=Conversion1.caption+'BMP'; // nolang
  4 : Conversion1.caption:=Conversion1.caption+'JPEG'; // nolang
  5 : Conversion1.caption:=Conversion1.caption+'CPA V4'; // nolang
  end;
end;

// Ici on decide ce qui est visible dans les menus et Toolbar
// en fonction des fenêtres MDI actives
procedure Tpop_main.MiseAJourMenu(Sender: TObject);
var
ImgImage:Tpop_Image;
begin
//Img:=ActiveMdiChild as Tpop_Image;
if ActiveMdiChild is Tpop_Image then
  begin
  ImgImage:=ActiveMdiChild as Tpop_Image;
  Soustraireuneimageunlot1.Visible:=True;
  Diviserunlotparuneimage1.Visible:=True;
  N3.Visible:=True;
  // 19->35
  ToolButton19.Visible:=True;
  ToolButton20.Visible:=True;
  ToolButton21.Visible:=True;
  ToolButton22.Visible:=True;
  ToolButton23.Visible:=True;
  ToolButton24.Visible:=True;
  ToolButton25.Visible:=True;
  ToolButton26.Visible:=True;
  ToolButton27.Visible:=True;
  ToolButton28.Visible:=True;
  ToolButton29.Visible:=True;
  ToolButton30.Visible:=True;
  ToolButton31.Visible:=True;
  ToolButton32.Visible:=True;
  ToolButton33.Visible:=True;
  ToolButton34.Visible:=True;
  ToolButton35.Visible:=True;

  Sauversous1.Visible:=True;
//  outFits1.Visible:=      (Img.Typedata in [2,7])     and (Img.NbPlans in [1,3]);
  outCpa1.Visible :=      (ImgImage.ImgInfos.Typedata in [2,7])     and (ImgImage.ImgInfos.NbPlans in [1,3]);
  CpaVersoin4d1.Visible :=(ImgImage.ImgInfos.Typedata in [2,7])     and (ImgImage.ImgInfos.NbPlans in [1,3]);
  outPic1.Visible :=      (ImgImage.ImgInfos.Typedata in [2])       and (ImgImage.ImgInfos.NbPlans=1);
  outBmp1.Visible :=      (ImgImage.ImgInfos.Typedata in [2,5,7,8]) and (ImgImage.ImgInfos.NbPlans in [1,3]);
  outJpeg1.Visible:=      (ImgImage.ImgInfos.Typedata in [2,5,7,8]) and (ImgImage.ImgInfos.NbPlans in [1,3]);
  N10.Visible:=True;
  Ajusterlimage1.Visible:=True;
  Gnrelistedepixelschauds1.Visible:=True;
  end
else
  begin
  Soustraireuneimageunlot1.Visible:=False;
  Diviserunlotparuneimage1.Visible:=False;
  N3.Visible:=False;
  // 19->35
  ToolButton19.Visible:=False;
  ToolButton20.Visible:=False;
  ToolButton21.Visible:=False;
  ToolButton22.Visible:=False;
  ToolButton23.Visible:=False;
  ToolButton24.Visible:=False;
  ToolButton25.Visible:=False;
  ToolButton26.Visible:=False;
  ToolButton27.Visible:=False;
  ToolButton28.Visible:=False;
  ToolButton29.Visible:=False;
  ToolButton30.Visible:=False;
  ToolButton31.Visible:=False;
  ToolButton32.Visible:=False;
  ToolButton33.Visible:=False;
  ToolButton34.Visible:=False;
  ToolButton35.Visible:=False;


  Sauversous1.Visible:=False;
  N10.Visible:=False;
  Ajusterlimage1.Visible:=False;
  Gnrelistedepixelschauds1.Visible:=False;
  end;
if ActiveMdiChild is Tpop_skychart then
   begin
   Toolbar2.Visible:=True;
   Toolbar1.Show;
   end
else
   begin
   Toolbar2.Hide;
   end;
end;

procedure Tpop_main.SeuilsEnable;
begin
if pop_seuils<>nil then // Ca arrive
    begin
    pop_seuils.editsh.Enabled:=True;
    pop_seuils.editsb.Enabled:=True;
    pop_seuils.scrollbarsh.Enabled:=True;
    pop_seuils.scrollbarsb.Enabled:=True;
    pop_seuils.GroupBox1.Enabled:=True;
    pop_seuils.Fast.Enabled:=True;
    pop_seuils.Normal.Enabled:=True;
    pop_seuils.Slow.Enabled:=True;
    pop_seuils.ButtonLummm.Enabled:=True;
    pop_seuils.ButtonLumm.Enabled:=True;
    pop_seuils.ButtonLumpp.Enabled:=True;
    pop_seuils.ButtonLump.Enabled:=True;
    pop_seuils.ButtonConmm.Enabled:=True;
    pop_seuils.ButtonConm.Enabled:=True;
    pop_seuils.ButtonConpp.Enabled:=True;
    pop_seuils.ButtonConp.Enabled:=True;
    pop_seuils.Inverser.Enabled:=True;
    pop_seuils.Stellaires.Enabled:=True;
    pop_seuils.Planetes.Enabled:=True;
    pop_seuils.FileListBox2.Enabled:=True;
    end;
end;

procedure Tpop_main.SeuilsDesable;
begin
    pop_seuils.editsh.Enabled:=False;
    pop_seuils.editsb.Enabled:=False;
    pop_seuils.scrollbarsh.Enabled:=False;
    pop_seuils.scrollbarsb.Enabled:=False;
    pop_seuils.GroupBox1.Enabled:=False;
    pop_seuils.Fast.Enabled:=False;
    pop_seuils.Normal.Enabled:=False;
    pop_seuils.Slow.Enabled:=False;
    pop_seuils.ButtonLummm.Enabled:=False;
    pop_seuils.ButtonLumm.Enabled:=False;
    pop_seuils.ButtonLumpp.Enabled:=False;
    pop_seuils.ButtonLump.Enabled:=False;
    pop_seuils.ButtonConmm.Enabled:=False;
    pop_seuils.ButtonConm.Enabled:=False;
    pop_seuils.ButtonConpp.Enabled:=False;
    pop_seuils.ButtonConp.Enabled:=False;
    pop_seuils.Inverser.Enabled:=False;
    pop_seuils.Stellaires.Enabled:=False;
    pop_seuils.Planetes.Enabled:=False;
    pop_seuils.FileListBox2.Enabled:=False;
end;



////////////////////////////////////////////////////////////////////////////////
/////////////////////        Gestion du programme         //////////////////////
////////////////////////////////////////////////////////////////////////////////

procedure tpop_main.display_hints(sender:Tobject);
begin
     statusbar1.panels[1].text:=application.hint;
end;

procedure Tpop_main.FormCreate(Sender: TObject);
var
   Nom,Line:String;
   FText:TextFile;
   i,j,PosEsp:Integer;
   OK:Boolean;
   Path:String;
   Ini:TMemIniFile;
   T:TextFile;
   Name,SaveDir,Item:string;
   FPoint:TStringList;
   NData:Integer;
   AHPointe,DeltaPointe,AHReel,DeltaReel,ErreurAH,ErreurDelta:PLigDouble;
   Covar:DoubleArray;
   Chisq:Double;
   FTHreadID:LongWord;
begin
Config:=TConfig.Create;      // Laisser ici en première ligne du FormCreate !
Config.Initialisation:=True; // Laisser ici en deuxième ligne du FormCreate !

Path:=LowerCase(ExtractFilePath(Application.ExeName));
FWHMTestCourant:=5;

Config.CreeErreur:=False;
Config.GoodPos:=True;

try

// Laisser ici au debut du FormCreate sinon ca plante lamentablement !
AssignFile(FText,'Spy.log');        //nolang
Rewrite(FText);
CloseFile(FText);

SpyLines:=TStringList.Create;
SpyLines.Capacity:=10000;

// Sur quel OS on tourne ?
// Par defaut W95
// il faut laisser ca au tout debut avant le moindre writespy
// sinon ca plante sous NT , tant pis pour la langue du premier message
//      Config.TypeOS:=0;
//      lpVersionInformation.dwOSVersionInfoSize:=sizeof(TOSVersionInfo);
//      GetVersionEx(lpVersionInformation);
//      if lpVersionInformation.dwPlatformId=VER_PLATFORM_WIN32_NT then
//         begin
//         Config.TypeOS:=1;
//         WriteSpy('Windows NT kernel detected');      //nolang
//         end
//      else
//         if lpVersionInformation.dwPlatformId=VER_PLATFORM_WIN32_WINDOWS
//            then WriteSpy('Windows 95 kernel detected')       //nolang
//         else WriteSpy('Unknow Windows Version');      //nolang

Config.NomOS:=getos;
//      WriteSpy('OS : '+Config.NomOS); //nolang  //Non car WriteSpy demande l'heure !!!

Config.TypeOS:=0;
if (Config.NomOS='Win32 NT3') or (Config.NomOS='Win32 NT4') or (Config.NomOS='Win32 XP') //nolang
   or (Config.NomOS='Win32 2K') then Config.TypeOS:=1; //nolang
if (Config.NomOS='Win32 95') or (Config.NomOS='Win32 95OSR2') then Config.TypeOS:=0; //nolang

//WriteSpy('OS : '+Config.NomOS); //nolang  //Non car WriteSpy demande l'heure !!!

// Demarrage de PortTalk
if Config.TypeOS=1 then
   begin
   StartPortTalk;
   Config.PortTalkOpen:=True;
   end;

// Faut lire le language des le debut !
Ini:=TMemIniFile.Create(ExtractFilePath(Application.ExeName)+'TeleAuto.ini'); //nolang
try
Config.Language:=Ini.ReadString('Soft','Language','Francais'); //nolang
WriteSpy('LoadConfig : Language = '+config.Language);  //nolang
finally
Ini.UpdateFile;
Ini.free;
end;

Dico:=TStringList.Create;
Dico.Sorted:=True;
Dico.CaseSensitive:=True;
//Dico.Duplicates:=dupIgnore;
Dico.Capacity:=10000;

if Config.Language<>'Francais' then //nolang
   if not(FileExists(Path+'\'+config.Language+'.lng')) then //nolang
      begin
      ShowMessage('The language '+config.Language+' doesn''t exists, I use French instead'); //nolang
      Config.Language:='Francais'; //nolang
      end;

if Config.Language<>'Francais' then //nolang
   begin
   Dico.LoadFromFile(Path+'\'+config.Language+'.lng'); //nolang
   // Classement OK
{   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   for i:=0 to Dico.Count-1 do
      Rapport.AddLine(IntToStr(i)+'/'+Dico.Strings[i]);
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;
   end;}

   // Création de l'index
   j:=0;
   i:=0;
   while j<26 do
      begin
      if j=10 then j:=11;
      Item:=Dico[i];
      while Item[2]<>Chr(Ord('A')+j) do
         begin
         Inc(i);
         Item:=Dico[i];
         end;
//      ShowMessage(IntToStr(j)+'/'+Chr(j+Ord('A'))+'/'+IntToStr(i));
      IndexDic[j]:=i;
      inc(j);
      end;
   end;

WriteSpy(lang('Create : Lancement du programme'));
WriteSpy(VersionTeleAuto);

// On cache le menu codage et le reste
if not(FileExists('codage.txt')) then //nolang
   begin
//         Nouvellecarteduciel1.Visible:=False;
   outCodage1.Visible:=False;
//         Timer1.Enabled:=False;
   end
else
   begin
   // Trace pour le debug de la mort qui tue !
   AssignFile(FText,'Debug.txt');        //nolang
   Rewrite(FText);
   CloseFile(FText);
   end;

Path:=ExtractFileDir(Application.ExeName);

// Valeurs par défaut de paramètres de config
config.ReadIntervalTimeout:=10;
config.ReadTotalTimeoutMultiplier:=10;
config.ReadTotalTimeoutConstant:=10;
config.WriteTotalTimeoutMultiplier:=10;
config.WriteTotalTimeoutConstant:=10;

config.MapReadIntervalTimeout:=10;
config.MapReadTotalTimeoutMultiplier:=10;
config.MapReadTotalTimeoutConstant:=10;
config.MapWriteTotalTimeoutMultiplier:=10;
config.MapWriteTotalTimeoutConstant:=10;

config.ErreurPointingAlpha:=6;
config.ErreurPointingDelta:=60;

config.RepImages:=Path;
config.RepOffsets:=Path;
config.RepNoirs:=Path;
config.RepPlus:=Path;
config.RepImagesAcq:=Path;

//      config.RepGSC:=Path+'cat\gsc'; //nolang
//      config.RepUSNO:=Path+'cat\usno'; //nolang
//      config.RepTycho2:=Path+'cat\tycho2'; //nolang
//      config.RepMicrocat:=Path+'cat\microcat'; //nolang
//      config.RepCatalogsBase:=Path+'cat'; //nolang
config.RepScript:=Path+'script'; //nolang
config.TypeGSC := 0;

config.SeuilBasPourCent:=0.5;        // Seuil bas en % de l'histogramme cumulé
config.SeuilHautPourCent:=99.5;      // Seuil haut en % de l'histogramme cumulé

config.LargModelise:=9;
config.CalibrateSuivi:=False;
config.CalibratePointage:=False;
config.NoirTrackPris:=False;
config.NoirTrackVignettePris:=False;
config.UseTrackSt7:=False;
config.CCDAlphaTrack:=192;
config.CCDDeltaTrack:=164;
config.ConfigPretrait.NomOffset:='Offset';         //nolang
config.ConfigPretrait.NomNoir:='Noir';             //nolang
config.ConfigPretrait.NomNoirFlat:='NoirFlat';     //nolang
config.ConfigPretrait.NomFlat:='Flat';             //nolang
config.ConfigPretrait.ErreurRecaleImages:=0.1;
config.ConfigPretrait.SupprimmerImages:=True;
Config.EtapeCalibration:=0;

config.TypeHourServer:=1;

InitMain:=False;

Screen.OnActiveFormChange:=MiseAJourMenu;
Application.Onhint:=display_hints;

Config.MySqlAskPassword:=True;
Config.KeepImage:=True;

Config.BloqueGuidage:=False;

//      config.TrackError:=False;
//      config.PointeFinal:=True;
// Pos init virtuelles
//   HHhMMmSSs = Ascension droite
PosAlphaCourante:=StrToAlpha('21:18:00'); //nolang
//   sDDdMMmSSs = declinaison
PosDeltaCourante:=StrToDelta('+62°35''00"'); //nolang
CloseRequest:=False;
PalGrise(Pal);
//pop_seuils.PalExpl;

Nom:='';

Path:=LowerCase(ExtractFilePath(Application.ExeName));

LoadParametres(Path+'TeleAuto.ini'); //nolang

// Teste si les répertoires existent toujours
SaveDir:=GetCurrentDir;
if not(SetCurrentDir(config.RepImages))    then config.RepImages:=Path;
if not(SetCurrentDir(config.RepOffsets))   then config.RepOffsets:=Path;
if not(SetCurrentDir(config.RepNoirs))     then config.RepNoirs:=Path;
if not(SetCurrentDir(config.RepPlus))      then config.RepPlus:=Path;
if not(SetCurrentDir(config.RepImagesAcq)) then config.RepImagesAcq:=Path;
SetCurrentDir(SaveDir);

WriteSpy(lang('Create : Chargement du Profil'));
// Charge le profil
for i:=0 to 360 do
   begin
   AzimuthPRF[i]:=i;
   HauteurPRF[i]:=0;
   end;

OK:=False;

if FileExists(config.Profil) then
   begin
   AssignFile(FText,config.Profil);
   Reset(FText);

   for i:=0 to 360 do
      begin
      Readln(FText,Line);

      if DecimalSeparator=',' then
         if Pos('.',Line)<>0 then Line[Pos('.',Line)]:=',';
      if DecimalSeparator='.' then
         if Pos(',',Line)<>0 then Line[Pos('.',Line)]:='.';

      PosEsp:=Pos(' ',Line);
      AzimuthPRF[i]:=MyStrToFloat(Copy(Line,1,PosEsp-1));
      Delete(Line,1,PosEsp);

      HauteurPRF[i]:=MyStrToFloat(Trim(Line));
      if i=360 then OK:=True;
      end;

   CloseFile(FText);
   end;

if not(OK) then WriteSpy(lang('Create : Erreur au chargement du fichier Profil => horizon plat !'));

PhotoFini:=True;

config.UsePort1:=False;
config.UsePort2:=False;
config.UsePort3:=False;
config.UsePort4:=False;

case config.typeGSC of
   0:setgsccpath(config.RepGSC);
   1:setgscfpath(config.RepGSC);
   end;

Config.BuidingCosmeticFile:=False;

// controle des catalogues installes
CheckCat;

// Modele de pointage
if Config.UseModelePointage and Config.ModelePointageCalibre then
  begin
  FPoint:=TStringList.Create;

  try

  Name:='TPoint.txt'; //nolang
  AssignFile(T,Name);
  Reset(T);
  try
  i:=0;
  while not Eof(T) do
     begin
     Readln(T,Line);
     FPoint.Add(Line);
     Inc(i);
     end;
  finally
  System.Close(T);
  end;

  NData:=FPoint.Count;

  Getmem(AHPointe,8*NData );
  Getmem(DeltaPointe,8*NData);
  Getmem(AHReel,8*NData);
  Getmem(DeltaReel,8*NData);
  Getmem(ErreurAH,8*NData);
  Getmem(ErreurDelta,8*NData);

  try

  for i:=0 to NData-1 do
     begin
     Line:=FPoint[i];

     PosEsp:=Pos(' ',Line);
     AHPointe[i+1]:=StrToAlpha(Copy(Line,1,PosEsp-1));
     Delete(Line,1,PosEsp);

     PosEsp:=Pos(' ',Line);
     DeltaPointe[i+1]:=StrToDelta(Copy(Line,1,PosEsp-1));
     Delete(Line,1,PosEsp);

     PosEsp:=Pos(' ',Line);
     AHReel[i+1]:=StrToAlpha(Copy(Line,1,PosEsp-1));
     Delete(Line,1,PosEsp);

     DeltaReel[i+1]:=StrToDelta(Trim(Line));

     ErreurAH[i+1]:=(AHReel[i+1]-AHPointe[i+1])*15;
     ErreurDelta[i+1]:=(DeltaReel[i+1]-DeltaPointe[i+1]);
     end;

  for i:=1 to MaxArray do Correction.Modele[i]:=0;

  Correction.Latitude:=Config.Lat/180*Pi;
  FitModelePointage(AHPointe,DeltaPointe,ErreurAH,ErreurDelta,NData,Correction,Covar,Chisq);

  finally
  Freemem(AHPointe,8*NData);
  Freemem(DeltaPointe,8*NData);
  Freemem(AHReel,8*NData);
  Freemem(DeltaReel,8*NData);
  Freemem(ErreurAH,8*NData);
  Freemem(ErreurDelta,8*NData);
  end;

  finally
  FPoint.Free;
  end;

  end;

AnalMonture:=False;

Config.NbDecalageSuivi:=0;
OpenDcl;

NoirMAPAcquis:=False;
VAcqNoir:=False;
Config.SuiviEnCours:=False;
Config.CalibrationEnCours:=False;

//FTHreadID:=GetCurrentThreadID;
//ShowMessage('FormCreate : '+IntToHex(GetCurrentThreadID,4));

// Connection auto des matériels
CameraConnect;
CameraSuiviConnect;
TelescopeConnect; // Telescope toujours avant pour le focuser LX200
FocuserConnect;
DomeConnect;
HourserverConnect;

HTimerGetPosEvent:=CreateEvent(nil,FALSE,FALSE,nil);

//      raise Error.Create('Test d''exception'); // Pour les tests
finally
outpop_Splash.Free;
config.Initialisation:=False; // Laisser ici a la fin de form create !
end;
end;

Procedure SaveWinColor;
var
   n:Integer;
begin
for n:=0 to 28 do Config.SavWinCol[n]:=GetSysColor(n);
end;

Procedure ResetWinColor;
const
   elem29:array[0..28] of integer=(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28);
begin
SetSysColors(29,elem29,config.savwincol);
end;

procedure Tpop_main.FormClose(Sender: TObject; var Action: TCloseAction);
var
   Path,FileName:string;
   i:Integer;
   FText:TextFile;
begin
   // Si une aquisition est en cours on ferme pas !
   if MapManuelle or Config.SuiviEnCours or Config.CalibrationEnCours then
      begin
      MessageDlg(lang('Fermeture impossible durant la mise au point ou le guidage'),mtWarning,[mbOK],0);
      Action:=caNone;
      Exit;
      end;

   pop_builder.timer_script.enabled:=false;
   Timer1.Enabled:=False;

   // On ferme les fenetres d'acquisition avant
   if pop_camera.pop_image_acq<>nil then
      begin
      pop_camera.pop_image_acq.AcqRunning:=False;
      pop_camera.pop_image_acq.AcqTrackRunning:=False;
      pop_camera.pop_image_acq.Bloque:=False;
      pop_camera.pop_image_acq.Close;
      end;
   if pop_camera_suivi.pop_image_acq<>nil then
      begin
      pop_camera_suivi.pop_image_acq.AcqRunning:=False;
      pop_camera_suivi.pop_image_acq.AcqTrackRunning:=False;
      pop_camera_suivi.pop_image_acq.Bloque:=False;
      pop_camera_suivi.pop_image_acq.Close;
      end;
   Application.ProcessMessages;

   if Config.Nightvision then ResetWinColor;

   Path:=ExtractFilePath(Application.Exename);
   SaveParametres(Path+'TeleAuto.ini'); //nolang

   // Sauvegarde et fermeture des images ouvertes toto
   AssignFile(FText,Path+'Images.lst'); //nolang
   Rewrite(FText);
   for i:=MDIChildCount-1 downto 0 do
      if MDIChildren[i] is TPop_Image then
         begin
         FileName:=(MDIChildren[i] as TPop_Image).ImgInfos.FileName;
         Writeln(FText,FileName);
         MDIChildren[i].Close;
         end;
   CloseFile(FText);

   // Arreter les timers avant de liberer le hardware qui s'en sert !
   pop_hour_server.HiresTimer1.Enabled:=False;
   pop_dome.Timer2.Enabled:=False;
   pop_dome.Timer1.Enabled:=False;   
   pop_camera.TimerTemp.Enabled:=False;

   // Déconnexion des matériels
   HourServerDisconnect;
   DomeDisConnect;
   CameraDisconnect;
   CameraSuiviDisconnect;
   if Config.FocuserBranche then
      if not Focuser.IsDependantOfTheScope then
         FocuserDisconnect;
   TelescopeDisconnect;

   // On libere l'evenement de fin de pose  en dehors du formclose !
   if EventEndAcq<>nil then
      begin
      EventEndAcq.Free;
      EventEndAcq:=nil;
      end;

   if EventEndPose<>nil then
      begin
      EventEndAcq.Free;
      EventEndAcq:=nil;
      end;

   if EventPose<>nil then
      begin
      EventPose.Free;
      EventPose:=nil;
     end;

   if EventGuide<>nil then
      begin
      EventGuide.Free;
      EventGuide:=nil;
      end;



   // Fermeture des fenetres pour activer le onclose
   pop_Camera.Close;
   pop_Camera_Suivi.Close;
   pop_Scope.Close;
   pop_Map.Close;
   pop_Dome.Close;
   pop_Hour_Server.Close;

   if Config.TypeOS=1 then
      if Config.PortTalkOpen then
         begin
         ClosePortTalk;
         Config.PortTalkOpen:=False;
         end;

   if Config.NbDecalageSuivi<>0 then
      begin
      if Config.DecalageSuiviX<>nil then
         begin
         Freemem(Config.DecalageSuiviX,Config.NbDecalageSuivi*8);
         Config.DecalageSuiviX:=nil;
         end;
      if Config.DecalageSuiviY<>nil then
         begin
         Freemem(Config.DecalageSuiviY,Config.NbDecalageSuivi*8);
         Config.DecalageSuiviY:=nil;
         end;
      end;

//   WriteSpy(lang('Close : Arrêt du programme d''observation'));

   if Dico<>nil then
      begin
      Dico.Free;
      Dico:=nil;
      end;

   if SpyLines<>nil then
      begin
      SpyLines.Free;
      SpyLines:=nil;
      end;

   CloseHandle(HTimerGetPosEvent);

   Action:=caFree;
end;

procedure Tpop_main.About1Click(Sender: TObject);
var
   pop_about:TPop_about;
begin
pop_about:=tpop_about.create(application);
pop_about.ShowModal;
end;

procedure Tpop_main.Configuration1Click(Sender: TObject);
var
FormConf:Tpop_conf;
begin
// Si une aquisition est en cours on affiche pas !
if MapManuelle or Config.SuiviEnCours or Config.CalibrationEnCours then
   begin
   MessageDlg(lang('Configuration impossible durant la mise au point ou le guidage'),mtWarning,[mbOK],0);
   Exit;
   end
else
   begin
   FormConf:=Tpop_conf.Create(Application);
   FormConf.Showmodal;
   end;
end;

procedure Tpop_main.Horloge1Click(Sender: TObject);
var
   pop_clock:tpop_clock;
begin
pop_clock:=tpop_clock.create(application);
pop_clock.show;
end;

procedure Tpop_main.Fermer1Click(Sender: TObject);
begin
if ActiveMDIChild<> nil then ActiveMDIChild.Close;
end;

procedure Tpop_main.ToutFermer1Click(Sender: TObject);
begin
while MDIChildCount<>0 do ActiveMDIChild.Free;
end;

procedure Tpop_main.Cascade1Click(Sender: TObject);
begin
Cascade;
end;

procedure Tpop_main.Mosaique1Click(Sender: TObject);
begin
Tile;
end;

procedure Tpop_main.Rorganiserlesiconnes1Click(Sender: TObject);
begin
ArrangeIcons;
end;

procedure Tpop_main.Toutrduire1Click(Sender: TObject);
var
i:Integer;
begin
{ Must be done backwards through the MDIChildren array }
for I := MDIChildCount - 1 downto 0 do
   MDIChildren[I].WindowState := wsMinimized;
end;

procedure Tpop_main.Additiondunlot1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory,Nom:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
pop_image:tpop_image;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and (pop_select_lot.ListBox.Items.Count<>0) then
   begin
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   Directory:=pop_select_lot.DirectoryListBox1.Directory;
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   VerifieLot(Directory,ListeImg,Rapport,True);
   pop_image:=tpop_image.create(application);
   try
   AddLot(Directory,ListeImg,pop_image.DataInt,pop_image.DataDouble,pop_image.ImgInfos,Rapport,False);
   Nom:=GetNomGenerique(pop_select_lot.Listbox.Items[0]);
   pop_image.Caption:=GiveName(Nom,pop_image);
   pop_image.ImgInfos.TypeComplexe:=1;
   pop_image.AjusteFenetre;
   pop_image.VisuAutoEtoiles;
   except
   pop_image.Free;
   end;
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;
end;

procedure Tpop_main.Spy1Click(Sender: TObject);
begin
pop_spy.show;
end;

// donner un nome différent à chaque image
function Tpop_main.GiveName(Name:String;Image:Tpop_image):String;
var
i,Numero,NumeroFinal,PosCrochetOuvert,PosCrochetFerme:Integer;
Trouve:Boolean;
Name2:String;
begin
Image.Caption:=Name;
PosCrochetOuvert:=Pos('[',Name);
if PosCrochetOuvert<>0 then Name:=Copy(Name,1,PosCrochetOuvert-2);

NumeroFinal:=-1;
Trouve:=False;
for i:=0 to MDIChildCount-1 do
   begin
   if MdiChildren[i] is tpop_image then
      begin
      Name2:=(MdiChildren[i] as tpop_image).Caption;
      PosCrochetOuvert:=Pos('[',Name2);
      PosCrochetFerme:=Pos(']',Name2);
      if PosCrochetOuvert<>0 then
         begin
         Numero:=StrToInt(Copy(Name2,PosCrochetOuvert+1,PosCrochetFerme-PosCrochetOuvert-1));
         Name2:=Copy(Name2,1,PosCrochetOuvert-2 );
         end
      else Numero:=0;
      if (Name=Name2) and ((MdiChildren[i] as tpop_image)<>Image) then
         Trouve:=True;
      end;
   if Trouve then
      if Numero>NumeroFinal then NumeroFinal:=Numero;
   end;

if Trouve then
   begin
   if NumeroFinal=0 then Result:=Name+' [1]'                      //nolang
   else Result:=Name+' ['+IntToStr(NumeroFinal+1)+']';            //nolang
   end
else
   Result:=Name;
end;

procedure Tpop_main.Covertionde1Click(Sender: TObject);
var
pop_conv_coord:Tpop_conv_coord;
begin
pop_conv_coord:=Tpop_conv_coord.Create(Application);
pop_conv_coord.Show;
end;

procedure Tpop_main.Jourlulien1Click(Sender: TObject);
var
pop_jour_julien:Tpop_jour_julien;
begin
pop_jour_julien:=Tpop_jour_julien.Create(Application);
pop_jour_julien.show;
end;

procedure Tpop_main.Moyennedunlot1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory,Nom:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
pop_image:tpop_image;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and (pop_select_lot.ListBox.Items.Count<>0) then
   begin
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   Directory:=pop_select_lot.DirectoryListBox1.Directory;
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   VerifieLot(Directory,ListeImg,Rapport,True);
   pop_image:=tpop_image.create(application);
   try
   AddLot(Directory,ListeImg,pop_image.DataInt,pop_image.DataDouble,pop_image.ImgInfos,Rapport,True);
   Nom:=GetNomGenerique(pop_select_lot.Listbox.Items[0]);
   pop_image.Caption:=GiveName(Nom,pop_image);
   pop_image.ImgInfos.TypeComplexe:=1;
   pop_image.AjusteFenetre;   
   pop_image.VisuAutoEtoiles;
   except
   pop_image.Free
   end;
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;      
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;
end;


procedure Tpop_main.ToolButton10Click(Sender: TObject);
begin
     pop_seuils.show;
end;

procedure Tpop_main.Camra1Click(Sender: TObject);
begin
if ToolButton6.Down then
   pop_camera.Hide
else
   begin
   pop_camera.Show;
   ToolButton6.Down:=True;
   end;
end;

procedure Tpop_main.Tlescope1Click(Sender: TObject);
begin
if ToolButton4.Down then
   pop_scope.Hide
else
   begin
   pop_scope.Show;
   ToolButton4.Down:=True;
   end;
end;

procedure Tpop_main.Medianedunlot1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory,Nom:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
pop_image:tpop_image;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and
(pop_select_lot.ListBox.Items.Count<>0) then
   begin
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   Directory:=pop_select_lot.DirectoryListBox1.Directory;
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   VerifieLot(Directory,ListeImg,Rapport,True);
   pop_image:=tpop_image.create(application);
   try
   MedianLot(Directory,ListeImg,pop_image.DataInt,pop_image.DataDouble,pop_image.ImgInfos,Rapport);
   Nom:=GetNomGenerique(pop_select_lot.Listbox.Items[0]);
   pop_image.Caption:=GiveName(Nom,pop_image);
   pop_image.ImgInfos.TypeComplexe:=1;
   pop_image.AjusteFenetre;   
   pop_image.VisuAutoEtoiles;
   except
   pop_image.Free
   end;
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;
end;

procedure Tpop_main.Moyenneidentique1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and
(pop_select_lot.ListBox.Items.Count<>0) then
   begin
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   Directory:=pop_select_lot.DirectoryListBox1.Directory;
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   VerifieLot(Directory,ListeImg,Rapport,True);
   MoyenneIdentique(Directory,ListeImg,Rapport);
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;

end;

procedure Tpop_main.Soustraireuneimageunlot1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
Image:Tpop_Image;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and (pop_select_lot.ListBox.Items.Count<>0) then
   begin
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   Directory:=pop_select_lot.DirectoryListBox1.Directory;
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   VerifieLot(Directory,ListeImg,Rapport,True);
   Image:=ActiveMdiChild as Tpop_Image;
   ArithmetiqueLot(Directory,Image.DataInt,Image.DataDouble,ListeImg,Image.ImgInfos,Rapport,alSoustraction);
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;   
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;
end;

procedure Tpop_main.Diviserunlotparuneimage1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
Image:Tpop_Image;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and (pop_select_lot.ListBox.Items.Count<>0) then
   begin
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   Directory:=pop_select_lot.DirectoryListBox1.Directory;
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   VerifieLot(Directory,ListeImg,Rapport,True);
   Image:=ActiveMdiChild as Tpop_Image;
   ArithmetiqueLot(Directory,Image.DataInt,Image.DataDouble,ListeImg,Image.ImgInfos,Rapport,alDivision);
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;   
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;
end;

procedure Tpop_main.Quitter1Click(Sender: TObject);
begin
     Close;
end;

// Oups, ne pas oublier de l'enlever à la fin !
procedure Tpop_main.FormDestroy(Sender: TObject);
begin
     Screen.OnActiveFormChange:=nil;
end;

procedure Tpop_main.Lireunheader1Click(Sender: TObject);
var
  pop_info_hdr:Tpop_info_hdr;
begin
Opendialog.Filter:=lang('Fichiers Pic Cpa Fits|*.pic;*.cpa;*.fit*;*.fts');
Opendialog.Initialdir:=Config.RepImages;
if Opendialog.Execute then
   begin
   Config.RepImages:=ExtractFilePath(Opendialog.Filename);
   pop_info_hdr:=tpop_info_hdr.Create(Application);
   pop_info_hdr.load_the_header(Opendialog.Filename);
   pop_info_hdr.Show;
   end;
end;

procedure Tpop_main.Chercher1Click(Sender: TObject);
begin
SearchFile;
end;

procedure Tpop_main.DownloaderDSSClick(Sender: TObject);
var
pop_dss:tpop_dss;
begin
     pop_dss:=tpop_dss.create(application);
     pop_dss.show;
end;

procedure Tpop_main.outVaisala1Click(Sender: TObject);
var
vaisala:tpop_vaisala;
begin
     vaisala:=tpop_vaisala.create(application);
     vaisala.show;
end;

procedure Tpop_main.RapportGino1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory:string;
ListeImg:TStringList;
Rapport:tpop_rapport;

i:Integer;
DT1:TDateTime;
Pose1:Double;
Trouve:Boolean;
STps,Slc1,Slc2,Saph,Sbc,SDae,SDap,SHauteur,SMoyStat,SMaxStat,SSigStat,Line:String;
aph,lc1,lc2,bc,dae,dap,ad,dc,th0,ap,apl,Hauteur:Double;

Nb:Integer;
TabImgInt:PTabImgInt;
TabImgDouble:PTabImgDouble;
Sx,Sy:Integer;
Min,Max:TSeuils;
CurrentTimeDate:TDateTime;

DT,Pose,MoyStat,MaxStat,SigStat:PLigDouble;

Mini,Mediane,Maxi,Moy,Ecart:Double;

pop_choix_planet:Tpop_choix_planet;
pop_progression:Tpop_progression;

TypeDonnees:Byte;
ImgInfos:TImgInfos;
NbPlans:Byte;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
pop_choix_planet:=Tpop_choix_planet.Create(Application);
ListeImg:=TStringList.Create;
try
if pop_choix_planet.Showmodal=mrOK then
   begin
   pop_select_lot.CacheRef;
   if (pop_select_lot.Showmodal=mrOK) and (pop_select_lot.ListBox.Items.Count<>0) then
      begin
      pop_progression:=Tpop_progression.Create(Application);
      pop_progression.Show;
      Rapport:=tpop_rapport.Create(Application);
      Rapport.Show;
      try
      Directory:=pop_select_lot.DirectoryListBox1.Directory;
      ListeImg.Assign(pop_select_lot.Listbox.Items);

      //************************************************************************

      Nb:=ListeImg.Count;

      GetMem(DT,Nb*8);
      GetMem(Pose,Nb*8);
      GetMem(MoyStat,Nb*8);
      GetMem(MaxStat,Nb*8);
      GetMem(SigStat,Nb*8);

      // Chargement
      for i:=0 to Nb-1 do
         begin
         pop_progression.ProgressBar1.Position:=i*100 div Nb;

         ReadImageGenerique(ListeImg.Strings[i],TabImgInt,TabImgDouble,ImgInfos);

         DT[i+1]:=ImgInfos.DateTime;
         Pose[i+1]:=ImgInfos.TempsPose/1000;

         Statistiques(TabImgInt,nil,TypeDonnees,1,Sx,Sy,1,Mini,Mediane,Maxi,Moy,Ecart);
         MaxStat[i+1]:=Maxi;
         MoyStat[i+1]:=Moy;
         SigStat[i+1]:=Sqrt(Ecart);

         Application.ProcessMessages;
         end;

      // Classement
      Trouve:=True;
      while Trouve do
         begin
         Trouve:=False;
         for i:=1 to Nb-1 do
            begin
            if DT[i+1]<DT[i] then
               begin
               ListeImg.Exchange(i-1,i);
               DT1:=DT[i];
               DT[i]:=DT[i+1];
               DT[i+1]:=DT1;
               Pose1:=Pose[i];
               Pose[i]:=Pose[i+1];
               Pose[i+1]:=Pose1;
               Trouve:=True;
               end;
            end;
         end;


      Trouve:=False;
      i:=1;
      while not(Trouve) and (i<=Nb) do
          begin
          if DT[i]<>0 then
             begin
             Trouve:=True;
             DT1:=DT[i];
             if Frac(DT1)>0.5 then DT1:=DT1-0.5;
             rapport.AddLine(lang(' Date = ')+DateToStr(DT[i])); 

             if pop_choix_planet.RadioGroup1.ItemIndex=0 then
                MarsPhys(DT1,ad,dc,aph,lc1,bc,dae,dap,th0,ap,apl);
             if pop_choix_planet.RadioGroup1.ItemIndex=1 then
                JupPhys(DT1,ad,dc,aph,lc1,lc2,bc,dae,dap,th0,ap,apl);
             if pop_choix_planet.RadioGroup1.ItemIndex=2 then
                SatPhys(DT1,ad,dc,aph,lc1,lc2,bc,dae,dap,th0,ap,apl);

             Hauteur:=GetElevation(DT1,ad,dc,config.Lat,config.Long);

             Saph:=FloatToStrF(-aph,ffFixed,15,2);
             while Length(Saph)<6 do Saph:=Saph+' ';
             Sbc:=FloatToStrF(bc,ffFixed,15,2);
             while Length(Sbc)<6 do Sbc:=Sbc+' ';
             Sdae:=FloatToStrF(dae,ffFixed,15,2);
             while Length(Sdae)<6 do Sdae:=Sdae+' ';
             Sdap:=FloatToStrF(dap,ffFixed,15,2);
             while Length(Sdap)<6 do Sdap:=Sdap+' ';

             rapport.AddLine(lang(' Phase =')+Saph
                +lang(' Latitude =')+Sbc+
                lang(' Diamètre Equatorial =')+Sdae+
                lang(' Diamètre Polaire =')+Sdap);

             end;
          inc(i);
          end;

      rapport.AddLine(' ');
      rapport.AddLine(lang(' Heure      Pose     W1       W2       Hauteur  Moy        Max     Sigma      Nom     '));

      for i:=1 to Nb do
         begin
         if UpperCase(ListeImg.Strings[i-1][1])='M' then MarsPhys(DT[i],ad,dc,aph,lc1,bc,dae,dap,th0,ap,apl)
         else if UpperCase(ListeImg.Strings[i-1][1])='J' then JupPhys(DT[i],ad,dc,aph,lc1,lc2,bc,dae,dap,th0,ap,apl)
         else if UpperCase(ListeImg.Strings[i-1][1])='S' then SatPhys(DT[i],ad,dc,aph,lc1,lc2,bc,dae,dap,th0,ap,apl);

         STps:=FloatToStrF(Pose[i],ffFixed,15,3);
         while Length(STps)<6 do STps:=Stps+' ';
         Slc1:=FloatToStrF(lc1,ffFixed,15,2);
         while Length(Slc1)<6 do Slc1:=Slc1+' ';
         Slc2:=FloatToStrF(lc2,ffFixed,15,2);
         while Length(Slc2)<6 do Slc2:=Slc2+' ';
         SHauteur:=FloatToStrF(Hauteur,ffFixed,15,2);
         while Length(SHauteur)<6 do SHauteur:=SHauteur+' ';
         SMoyStat:=FloatToStrF(MoyStat[i],ffFixed,15,2);
         while Length(SMoyStat)<8 do SMoyStat:=SMoyStat+' ';
         SMaxStat:=FloatToStrF(MaxStat[i],ffFixed,15,0);
         while Length(SMaxStat)<5 do SMaxStat:=SMaxStat+' ';
         SSigStat:=FloatToStrF(SigStat[i],ffFixed,15,2);
         while Length(SSigStat)<8 do SSigStat:=SSigStat+' ';

         Line:=' '+TimeToStr(DT[i])+' : '+STps+' : '; //nolang
         if UpperCase(ListeImg.Strings[i-1][1])='M' then Line:=Line+Slc1+' :        : '+SHauteur+' : '               //nolang
         else if UpperCase(ListeImg.Strings[i-1][1])='S' then Line:=Line+Slc1+' : '+Slc2+' : '+SHauteur+' : '        //nolang
         else if UpperCase(ListeImg.Strings[i-1][1])='J' then Line:=Line+Slc1+' : '+Slc2+' : '+SHauteur+' : '        //nolang
         else
            Line:=Line+'       :        :        : ';                                                                //nolang
         Line:=Line+SMoyStat+' : '+SMaxStat+' : '+SSigStat+' : '+ExtractFileName(ListeImg.Strings[i-1]);             //nolang

         rapport.AddLine(Line);
         end;

      finally
      FreeMem(DT,Nb*8);
      FreeMem(Pose,Nb*8);
      FreeMem(MoyStat,Nb*8);
      FreeMem(MaxStat,Nb*8);
      FreeMem(SigStat,Nb*8);

      Rapport.Quitter.Enabled:=True;
      Rapport.BitBtn1.Enabled:=True;
      Rapport.BitBtn2.Enabled:=True;
      Rapport.BitBtn3.Enabled:=True;      

      pop_progression.Free;
      end;
      end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
pop_choix_planet.Free;
end;
end;

procedure Tpop_main.outBmp1Click(Sender: TObject);
var
nom:String;
Image:Tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   SaveDialog.InitialDir:=config.RepImages;
   SaveDialog.Filter:=lang('Fichiers Image BMP|*.BMP');
   if SaveDialog.Execute then
      begin
      Image:=ActiveMDIChild as Tpop_Image;
      Nom:=SaveDialog.Filename;
      if Uppercase(ExtractFileExt(Nom))<>'.BMP' then Nom:=Nom+'.bmp'; //nolang
      config.RepImages:=ExtractFilePath(Nom);
      Image.Caption:=GiveName(ExtractFileName(Nom),Image);
//      SaveBMPHandle(Nom,Image.DataInt,Image.DataDouble,Image.ImgInfos,Image.Img_Box.Picture.Bitmap.Handle);
      SaveBMP(Nom,Image.DataInt,Image.DataDouble,Image.ImgInfos);
//      Image.VisuImg;
      end;
   end;
end;

procedure Tpop_main.outJpeg1Click(Sender: TObject);
var
   nom:String;
   Image:Tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   SaveDialog.InitialDir:=config.RepImages;
   SaveDialog.Filter:=lang('Fichiers image Jpeg|*.JPEG;*.JPG');
   if SaveDialog.Execute then
      begin
      Image:=ActiveMDIChild as Tpop_Image;
      Nom:=SaveDialog.Filename;
      if (Uppercase(ExtractFileExt(Nom))<>'.JPG') and (Uppercase(ExtractFileExt(Nom))<>'.JEPG') then Nom:=Nom+'.jpg'; //nolang
      config.RepImages:=ExtractFilePath(Nom);
      Image.Caption:=GiveName(ExtractFileName(Nom),Image);
      SaveJPG(Nom,Image.DataInt,Image.DataDouble,Image.ImgInfos);
      end;
   end;
end;

procedure Tpop_main.outCpa1Click(Sender: TObject);
var
nom,n,ext:String;
Image:Tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   SaveDialog.InitialDir:=config.RepImages;
   SaveDialog.Filter:=lang('Fichiers image Cpa|*.CPA');
   SaveDialog.FileName:=ChangeExt(Image.Caption,'.cpa');  //nolang
   if SaveDialog.Execute then
      begin
      Nom:=SaveDialog.Filename;
      if Uppercase(ExtractFileExt(Nom))<>'.CPA' then Nom:=Nom+'.cpa'; //nolang
      config.RepImages:=ExtractFilePath(Nom);
      Image.Caption:=GiveName(ExtractFileName(Nom),Image);
      if (Image.ImgInfos.Sx = 7)and(Image.ImgInfos.NbPlans = 3) then
        if config.FormatCouleur=0 then begin
           n:=extractfilename(nom);
           ext:=ExtractFileExt(Nom);
           SaveCPAV3(n+'_R'+ext,Image.DataInt,1,Image.ImgInfos);  // un fichier par couleur //nolang
           SaveCPAV3(n+'_G'+ext,Image.DataInt,2,Image.ImgInfos);                            //nolang
           SaveCPAV3(n+'_B'+ext,Image.DataInt,3,Image.ImgInfos);                            //nolang
         end else begin
           SaveCPAV3(nom,Image.DataInt,1,Image.ImgInfos);   // fichier RGB
      end
      else SaveCPAV3(Nom,Image.DataInt,1,Image.ImgInfos);   // pas en couleur
      end;
   end;
end;

procedure Tpop_main.outPic1Click(Sender: TObject);
var
nom:String;
Image:Tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   SaveDialog.InitialDir:=config.RepImages;
   SaveDialog.Filter:=lang('Fichiers image Pic|*.PIC');
   SaveDialog.FileName:=ChangeExt(Image.Caption,lang('.pic'));
   if SaveDialog.Execute then
      begin
      Nom:=SaveDialog.Filename;
      if Uppercase(ExtractFileExt(Nom))<>'.PIC' then Nom:=Nom+'.pic'; //nolang
      config.RepImages:=ExtractFilePath(Nom);
      Image.Caption:=GiveName(ExtractFileName(Nom),Image);
      SavePIC(Nom,Image.DataInt,Image.ImgInfos);
      end;
   end;
end;

procedure Tpop_main.Statistiquesdunlot1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and
   (pop_select_lot.ListBox.Items.Count<>0) then
   begin
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   Directory:=pop_select_lot.DirectoryListBox1.Directory;
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   VerifieLot(Directory,ListeImg,Rapport,True);
   StatistiqueLot(Directory,ListeImg,Rapport);
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;   
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;
end;

// vision nocturne
procedure Tpop_main.Miseaupoint1Click(Sender: TObject);
begin
if ToolButton5.Down then
   pop_map.Hide
else
   begin
   pop_map.Show;
   ToolButton5.Down:=True;
   end;
end;

procedure Tpop_main.SigmaKappadunlot1Click(Sender: TObject);
var
   pop_select_lot:Tpop_select_lot;
   Directory,Nom:string;
   ListeImg:TStringList;
   Rapport:tpop_rapport;

   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   NbSigma:Double;
   pop_image:tpop_image;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and
(pop_select_lot.ListBox.Items.Count<>0) then
   begin
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   Directory:=pop_select_lot.DirectoryListBox1.Directory;
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   VerifieLot(Directory,ListeImg,Rapport,True);
   pop_image:=tpop_image.create(application);
   try
   New(TabItems);
   try
   IniTabItems(TabItems);

   with TabItems^[1] do
      begin
      TypeItem:=tiReal;
      Msg:=lang('Nombres d''écart-type de réjection : ');
      ValeurDefaut:=3;
      ValeurMin:=0.1;
      ValeurMax:=100;
      end;

   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
   DlgStandard.Caption:='Sigma Kappa'; //nolang
   if DlgStandard.ShowModal=mrOK then
      begin
      NbSigma:=TabItems^[1].ValeurSortie;

      SigmaKappaLot(Directory,ListeImg,pop_image.DataInt,pop_image.DataDouble,pop_image.ImgInfos,NbSigma,Rapport);
      Nom:=GetNomGenerique(pop_select_lot.Listbox.Items[0]);
      pop_image.Caption:=GiveName(Nom,pop_image);
      pop_image.ImgInfos.TypeComplexe:=1;
      pop_image.AjusteFenetre;
      pop_image.VisuAutoEtoiles;
      end
   else
      begin
      pop_image.Free;
      DlgStandard.Free;
      end;

   finally
   Dispose(TabItems);
   end;

   except
   pop_image.Free
   end;
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;   
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;
end;

procedure Tpop_main.Prtraitement1Click(Sender: TObject);
var
   pop_pretraitements:Tpop_pretraitements;
   Directory:string;
   ListeOffsets:TStringList;
   ListeNoirs:TStringList;
   ListeNoirsFlats:TStringList;
   ListeFlats:TStringList;
   ListeImages:TStringList;
   ImagesFinales:TStringList;
   Rapport:tpop_rapport;
   SaveFormat : Byte;
   i:Integer;
   pop_image:tpop_image;
begin
SaveFormat:=config.FormatSaveInt;
pop_pretraitements:=Tpop_pretraitements.Create(Application);
ListeOffsets:=TStringList.Create;
ListeNoirs:=TStringList.Create;
ListeNoirsFlats:=TStringList.Create;
ListeFlats:=TStringList.Create;
ListeImages:=TStringList.Create;
ImagesFinales:=TStringList.Create;
try
Directory:=Config.RepImagesAcq;
pop_pretraitements.FileListBox.Directory:=Directory;
if (pop_pretraitements.Showmodal=mrOK) and
   (pop_pretraitements.ListBoxImages.Items.Count<>0) then
   begin
   Directory:=pop_pretraitements.FileListBox.Directory;
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try

   ListeOffsets.Assign(pop_pretraitements.ListboxOffsets.Items);
   ListeNoirs.Assign(pop_pretraitements.ListboxNoirs.Items);
   ListeNoirsFlats.Assign(pop_pretraitements.ListboxNoirsFlats.Items);
   ListeFlats.Assign(pop_pretraitements.ListboxFlats.Items);
   ListeImages.Assign(pop_pretraitements.ListboxImages.Items);
   if ListeOffsets.Count<>0 then VerifieLot(Directory,ListeOffsets,Rapport,True);
   if ListeNoirs.Count<>0 then VerifieLot(Directory,ListeNoirs,Rapport,True);
   if ListeNoirsFlats.Count<>0 then VerifieLot(Directory,ListeNoirsFlats,Rapport,True);
   if ListeFlats.Count<>0 then VerifieLot(Directory,ListeFlats,Rapport,True);
   if ListeImages.Count<>0 then
      begin
//      VerifieLot(Directory,ListeImages,Rapport,True);
      // les fichiers traité ne sont pas forcement dans le format préferé de sauvegarde
      // Oui mais veut il utiliser les format des images ou le format qu'il dit preferer ?
{      Ext:=UpperCase(ExtractFileExt(ListeImages.Strings[0]));
      if (Ext='.FIT') or (Ext='.FTS') or (Ext='.FITS') then config.FormatSaveInt:=0    //nolang
      else if (Ext='.CPA') and (config.FormatSaveInt<>5) then config.FormatSaveInt:=1  //nolang
      else if (Ext='.PIC') then config.FormatSaveInt:=2                                //nolang
      else if (Ext='.BMP') then config.FormatSaveInt:=3                                //nolang
      else if (Ext='.JPG') then config.FormatSaveInt:=4;                               //nolang}
      Pretraitements(Directory,ListeOffsets,ListeNoirs,ListeNoirsFlats,ListeFlats,
                     ListeImages,ImagesFinales,Config.ConfigPretrait,Rapport);

      // Afficahge des images
      for i:=0 to ImagesFinales.Count-1 do
         begin
         pop_image:=tpop_image.create(application);
         try
         pop_image.ReadImage(ImagesFinales.Strings[i]);
         if FileExists(ImagesFinales.Strings[i]) then pop_image_index.addline(ImagesFinales.Strings[i],0);
         except
         on E: Exception do
            begin
            ShowMessage(E.Message);
            pop_image.free;
            end;
         end;
         end;

      end
   else raise MyError.Create(lang('Vous devez sélectionner des images à prétraiter'));
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;
   end;
   end;
finally
ListeOffsets.Free;
ListeNoirs.Free;
ListeNoirsFlats.Free;
ListeFlats.Free;
ListeImages.Free;
pop_pretraitements.Free;
config.FormatSaveInt:=SaveFormat;
end;
end;

// Avec ajout APN
procedure Tpop_main.ConnecterleTlescope1Click(Sender: TObject);
begin
   if not(Config.TelescopeBranche) then
      begin
      TelescopeConnect;
      if not(Config.TelescopeBranche) then
         ShowMessage(lang('Aucun télescope détecté'));
      end
   else TelescopeDisconnect;
end;

procedure Tpop_main.ConnecterleFocuser1Click(Sender: TObject);
begin
   if not(Config.FocuserBranche) then
      begin
      FocuserConnect;
      if not(Config.FocuserBranche) then
         ShowMessage(lang('Aucun focuseur détecté'));
      end
   else FocuserDisconnect;
end;

procedure Tpop_main.Connecterlacamra1Click(Sender: TObject);
begin
   if not(Config.CameraBranchee) then
      begin
      CameraConnect;
      if not(Config.CameraBranchee) then
         ShowMessage(lang('Aucune caméra principale détectée'));
      end
   else CameraDisconnect;
end;

procedure Tpop_main.ConnecterleDome1Click(Sender: TObject);
begin
   if not(Config.DomeBranche) then
      begin
      DomeConnect;
      if not(Config.DomeBranche) then
         ShowMessage(lang('Aucun dome détecté'));
      end
   else DomeDisconnect;
end;

procedure Tpop_main.outMettreajourledico1Click(Sender: TObject);
begin
CreerDico(True,Application);
end;

procedure Tpop_main.outMettreajourledicomodele1Click(Sender: TObject);
begin
CreerDico(False,Application);
end;

procedure Tpop_main.outMettreajourlessources1Click(Sender: TObject);
begin
ModifSources;
end;

procedure Tpop_main.Changerlelanguage1Click(Sender: TObject);
var
pop_choose_lang:Tpop_choose_lang;
i,j:Integer;
Path,Item:string;
begin
pop_choose_lang:=Tpop_choose_lang.Create(Application);
try
if pop_choose_lang.ShowModal=mrOK then
   begin
   for i:=0 to pop_choose_lang.Listbox1.Items.Count-1 do
      if pop_choose_lang.Listbox1.Selected[i] then j:=i;

   if Config.Language<>'Francais' then //nolang
      begin
      // Toutes les fiches à autocréer
      ReturnToFrench(Self);
      ReturnToFrench(pop_spy);
      ReturnToFrench(pop_seuils);
      ReturnToFrench(pop_seuils_color);
      ReturnToFrench(pop_camera);
      ReturnToFrench(pop_scope);
      end;

   Config.Language:=pop_choose_lang.ListBox1.Items[j];

   Path:=ExtractFilePath(Application.Exename);
   SaveParametres(Path+'TeleAuto.ini'); //nolang

   Dico.Clear;

   if config.Language<>'Francais' then //nolang
      begin
      Dico.LoadFromFile(Path+'\'+Config.Language+'.lng'); //nolang

      // Création de l'index
      j:=0;
      i:=0;
      while j<26 do
         begin
         if j=10 then j:=11;
         Item:=Dico[i];
         while Item[2]<>Chr(Ord('A')+j) do
            begin
            Inc(i);
            Item:=Dico[i];
            end;
         //ShowMessage(IntToStr(j)+'/'+Chr(j+Ord('A'))+'/'+IntToStr(i));
         IndexDic[j]:=i;
         inc(j);
         end;

      for i:=MDIChildCount-1 downto 0 do UpDateLang(MDIChildren[I]);
      UpDateLang(Self);
//      UpDateLang(pop_spy);
//      UpDateLang(pop_seuils);
//      UpDateLang(pop_seuils_color);
//      UpDateLang(pop_camera);
//      UpDateLang(pop_scope);
      end;

   end;
finally
pop_choose_lang.Free;
end
end;

procedure Tpop_main.Crerunnouveaulanguage1Click(Sender: TObject);
var
TabItems:PTabItems;
DlgStandard:Tpop_dlg_standard;
i:Integer;
NomLanguage,WordDico,Path:string;
pop_edit_dico:Tpop_edit_dico;
FLang:TextFile;
begin
Path:=ExtractFileDir(Application.ExeName);

New(TabItems);

try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiEdit;
   Msg:=lang('Nouveau langage :');
   ValeurStrDefaut:='Newlang'; // nolang
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.Caption:=lang('Langage');
if DlgStandard.ShowModal=mrOK then
   begin
   NomLanguage:=TabItems^[1].ValeurStrSortie;
   if UpperCase(ExtractFileExt(NomLanguage))<>'' then NomLanguage:=GetNomGenerique(NomLanguage); //nolang

   pop_edit_dico:=Tpop_edit_dico.Create(Application);
   pop_edit_dico.Panel1.Caption:='Français'; //nolang
   pop_edit_dico.Panel2.Caption:=NomLanguage;
   try

   if FileExists(Path+'\Model.lng') then //nolang
      begin
      AssignFile(FLang,Path+'\Model.lng'); //nolang
      Reset(FLang);
      try

      pop_edit_dico.LangueRef:=TStringList.Create;
      pop_edit_dico.NewLangue:=TStringList.Create;

      while not Eof(FLang) do
         begin
         Readln(FLang,WordDico);
         WordDico:=Copy(WordDico,2,Length(WordDico)-3);

         pop_edit_dico.LangueRef.Add(WordDico);
         pop_edit_dico.NewLangue.Add('');
         end;

      finally
      CloseFile(FLang);
      end;

      if pop_edit_dico.ShowModal=mrOk then
         begin
         AssignFile(FLang,Path+'\'+NomLanguage+'.lng'); //nolang
         ReWrite(FLang);

         for i:=0 to pop_edit_dico.LangueRef.Count-1 do
            Writeln(FLang,''''+pop_edit_dico.LangueRef.Strings[i]+'''=''' //nolang
            +pop_edit_dico.NewLangue.Strings[i]+'''');                    //nolang

         CloseFile(FLang);
         end;
      end
   else
   MessageDlg('Veuillez installer le dictionnaire de référence Model.lng',Dialogs.mtError,[mbOK],0);
//   MessageDlg('Fin de l''application Pascal Objet.', mtInformation,[mbOk], 0);

//   MessageDlg(lang('Veuillez installer le dictionnaire de référence Model.lng'),mtError,[mbOK],0);

   finally
   pop_edit_dico.Free;
   end;

   end;


finally
DlgStandard.Free;
Dispose(TabItems);
end;
end;

procedure Tpop_main.FormShow(Sender: TObject);
begin
// Laisser ca ici, c'est essentiel
//Dock974.Height:=27;
// A mettre dans le onshow de toutes les unités
UpDateLang(Self);
UpdateGUITypeFichier;
end;

procedure Tpop_main.CpaVersoin4d1Click(Sender: TObject);
var
nom,n,ext:String;
Image:Tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   SaveDialog.InitialDir:=config.RepImages;
   SaveDialog.Filter:=lang('Fichiers image Cpa|*.CPA');
   SaveDialog.FileName:=ChangeExt(Image.Caption,lang('.cpa'));
   if SaveDialog.Execute then
      begin
      Nom:=SaveDialog.Filename;
      if Uppercase(ExtractFileExt(Nom))<>'.CPA' then Nom:=Nom+'.cpa'; //nolang
      config.RepImages:=ExtractFilePath(Nom);
      Image.Caption:=GiveName(ExtractFileName(Nom),Image);
      if (Image.ImgInfos.Sx = 7)and(Image.ImgInfos.NbPlans = 3) then
        if config.FormatCouleur=0 then begin
           n:=extractfilename(nom);
           ext:=ExtractFileExt(Nom);
           SaveCPAV4d(n+'_R'+ext,Image.DataInt,1,Image.ImgInfos);  // un fichier par couleur //nolang
         SaveCPAV4d(n+'_G'+ext,Image.DataInt,2,Image.ImgInfos);                            //nolang
           SaveCPAV4d(n+'_B'+ext,Image.DataInt,3,Image.ImgInfos);                            //nolang
         end else begin
           SaveCPAV4d(nom,Image.DataInt,1,Image.ImgInfos);   // fichier RGB
      end
      else SaveCPAV4d(Nom,Image.DataInt,1,Image.ImgInfos);   // pas en couleur
      end;
   end;
end;

procedure Tpop_main.Misejourdunlanguage1Click(Sender: TObject);
var
pop_choose_lang:Tpop_choose_lang;
FModel,FLang,FTemp:TextFile;
i,j,k:Integer;
NomLanguage,WordDico,NewWord,NewWordRef,NewWordTrad,Path:string;
Trouve:Boolean;
pop_progression:Tpop_progression;
begin
Path:=ExtractFileDir(Application.ExeName);

pop_choose_lang:=Tpop_choose_lang.Create(Application);
try
pop_choose_lang.Label1.Caption:=lang('Langage :');
pop_choose_lang.CacheFrancais;
if pop_choose_lang.ShowModal=mrOK then
   begin
   for i:=0 to pop_choose_lang.Listbox1.Items.Count-1 do
      if pop_choose_lang.Listbox1.Selected[i] then j:=i;
   NomLanguage:=pop_choose_lang.ListBox1.Items[j];

   pop_edit_dico:=Tpop_edit_dico.Create(Application);
   pop_edit_dico.Panel1.Caption:='Français'; //nolang
   pop_edit_dico.Panel2.Caption:=NomLanguage;
   try

   if FileExists(Path+'\Model.lng') then //nolang
      begin
      AssignFile(FModel,Path+'\Model.lng'); //nolang
      Reset(FModel);
      try

      pop_edit_dico.LangueRef:=TStringList.Create;
      pop_edit_dico.NewLangue:=TStringList.Create;

      pop_progression:=Tpop_progression.Create(Application);
      pop_progression.Show;
      try

      AssignFile(FLang,Path+'\'+NomLanguage+'.lng'); //nolang
      Reset(FLang);
      try
      k:=0;
      while not Eof(FLang) do
         begin
         Readln(FLang,WordDico);
         Inc(k);
         end;
      finally
      CloseFile(FLang);
      end;

      j:=0;
      while not Eof(FModel) do
         begin
         Readln(FModel,WordDico);
         Inc(j);
         if (j mod 16)=0 then pop_progression.ProgressBar1.Position:=j*100 div k;
         Trouve:=False;
         AssignFile(FLang,Path+'\'+NomLanguage+'.lng'); //nolang
         Reset(FLang);
         try
         while not Eof(FLang) do
            begin
            Readln(FLang,NewWord);
            NewWordRef:=Copy(NewWord,1,Length(WordDico));
            NewWordTrad:=Copy(NewWord,Length(WordDico)+1,Length(NewWord)-Length(WordDico));
            if NewWordRef=WordDico then
               begin
               Trouve:=True;
               Break;
               end;
            end;
         finally
         CloseFile(FLang);
         end;

   //      if NewWordRef=WordDico then
         if not(Trouve) or (NewWordTrad='''''') then //nolang
            begin
            NewWordRef:=Copy(NewWordRef,2,Length(NewWordRef)-3);
            pop_edit_dico.LangueRef.Add(NewWordRef);
            pop_edit_dico.NewLangue.Add('');
            end;
         end;

      finally
      pop_progression.Free;
      end;

      finally
      CloseFile(FModel);
      end;

      if pop_edit_dico.LangueRef.Count<>0 then
         begin
         if pop_edit_dico.ShowModal=mrOk then
            begin
            AssignFile(FTemp,Path+'\Temp.lng'); //nolang
            Rewrite(FTemp);
            try

            AssignFile(FLang,Path+'\'+NomLanguage+'.lng'); //nolang
            Reset(FLang);
            try

            while not Eof(FLang) do
               begin
               Readln(FLang,NewWord);
               SplitLangLine(NewWord,NewWordRef,NewWordTrad);

               Trouve:=False;
               for i:=0 to pop_edit_dico.LangueRef.Count-1 do
                  if NewWordRef=pop_edit_dico.LangueRef.Strings[i] then
                     begin
                     Trouve:=True;
                     Break;
                     end;
               if not Trouve then Writeln(FTemp,NewWord)
               else Writeln(FTemp,''''+NewWordRef+'''='''   //nolang
                  +pop_edit_dico.NewLangue.Strings[i]+'''') //nolang

               end;

            finally
            CloseFile(FLang);
            end;

            finally
            CloseFile(FTemp);
            end;

            DeleteFile(Path+'\'+NomLanguage+'.lng'); //nolang
            RenameFile(Path+'\Temp.lng',Path+'\'+NomLanguage+'.lng'); //nolang
            end;
         end
      else ShowMessage(lang('Mise à jour inutile'));
      end
   else MessageDlg(lang('Veuillez installer le dictionnaire de référence Model.lng'),Dialogs.mtError,[mbOK],0);

   finally
   pop_edit_dico.Free;
   end;
   end;
finally
pop_choose_lang.Free;
UpDateLang(Self);
end
end;

procedure Tpop_main.Editiondunlanguage1Click(Sender: TObject);
var
pop_choose_lang:Tpop_choose_lang;
FLang,FTemp:TextFile;
i,j:Integer;
NomLanguage,NewWord,NewWordRef,NewWordTrad,Path:string;
begin
Path:=ExtractFileDir(Application.ExeName);

pop_choose_lang:=Tpop_choose_lang.Create(Application);
try
pop_choose_lang.Label1.Caption:=lang('Langage :');
pop_choose_lang.CacheFrancais;
if pop_choose_lang.ShowModal=mrOK then
   begin
   for i:=0 to pop_choose_lang.Listbox1.Items.Count-1 do
      if pop_choose_lang.Listbox1.Selected[i] then j:=i;
   NomLanguage:=pop_choose_lang.ListBox1.Items[j];

   pop_edit_dico:=Tpop_edit_dico.Create(Application);
   pop_edit_dico.Panel1.Caption:='Français'; //nolang
   pop_edit_dico.Panel2.Caption:=NomLanguage;
   try

   pop_edit_dico.LangueRef:=TStringList.Create;
   pop_edit_dico.NewLangue:=TStringList.Create;

   AssignFile(FLang,Path+'\'+NomLanguage+'.lng'); //nolang
   Reset(FLang);
   try

   while not Eof(FLang) do
      begin
      Readln(FLang,NewWord);
      SplitLangLine(NewWord,NewWordRef,NewWordTrad);
      pop_edit_dico.LangueRef.Add(NewWordRef);
      pop_edit_dico.NewLangue.Add(NewWordTrad);
      end;

   finally
   CloseFile(FLang);
   end;

   if pop_edit_dico.ShowModal=mrOk then
      begin
      AssignFile(FTemp,Path+'\Temp.lng'); //nolang
      Rewrite(FTemp);
      try

      for i:=0 to pop_edit_dico.NewLangue.Count-1 do
         Writeln(FTemp,''''+pop_edit_dico.LangueRef.Strings[i]+'''='''   //nolang
            +pop_edit_dico.NewLangue.Strings[i]+'''')                    //nolang

      finally
      CloseFile(FTemp);
      end;

      DeleteFile(Path+'\'+NomLanguage+'.lng'); //nolang
      RenameFile(Path+'\Temp.lng',Path+'\'+NomLanguage+'.lng'); //nolang
      end;

   finally
   pop_edit_dico.Free;
   end;
   end
finally
pop_choose_lang.Free;
UpDateLang(Self);
end
end;

procedure Tpop_main.outLangMettrejourtouslesdicos1Click(Sender: TObject);
begin
UpdateAllDico;
end;

procedure Tpop_main.BestofStellaire1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
FWHMMax,DFWHMMax:Double;
NbMaxImages:Integer;
TabItems:PTabItems;
DlgStandard:Tpop_dlg_standard;
ShowGraph:Boolean;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and (pop_select_lot.ListBox.Items.Count<>0) then
   begin
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   Directory:=pop_select_lot.DirectoryListBox1.Directory;
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   VerifieLot(Directory,ListeImg,Rapport,True);

   New(TabItems);
   try
   IniTabItems(TabItems);

   with TabItems^[1] do
      begin
      TypeItem:=tiReal;
      Msg:=lang('FWHMX-FWHMY max : ');
      ValeurDefaut:=Config.BestOfDFWHM;
      ValeurMin:=0;
      ValeurMax:=100;
      end;

   with TabItems^[2] do
      begin
      TypeItem:=tiReal;
      Msg:=lang('FWHM max : ');
      ValeurDefaut:=Config.BestOfFWHMMAx;
      ValeurMin:=0;
      ValeurMax:=100;
      end;

   with TabItems^[3] do
      begin
      TypeItem:=tiInteger;
      Msg:=lang('Nombre max d''images finales : ');
      ValeurIncrement:=1;
      ValeurDefaut:=ListeImg.Count;
      ValeurMin:=2;
      ValeurMax:=ListeImg.Count;
      end;

   with TabItems^[4] do
      begin
      TypeItem:=tiCheckBox;
      Msg:=lang('Graphes');
      ValeurCheckDefaut:=False;
      end;


   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
   DlgStandard.Caption:=lang('Best of stellaire');
   if DlgStandard.ShowModal=mrOK then
      begin
      DFWHMMax:=TabItems^[1].ValeurSortie;
      FWHMMax:=TabItems^[2].ValeurSortie;
      NbMaxImages:=Round(TabItems^[3].ValeurSortie);
      ShowGraph:=TabItems^[4].ValeurSortie<>0;

      Config.BestOfDFWHM:=DFWHMMax;
      Config.BestOfFWHMMax:=FWHMMax;

      BestOfStellaire(Directory,ListeImg,DFWHMMax,FWHMMax,NbMaxImages,ShowGraph,Rapport);
      end
   else DlgStandard.Free;

   finally
   Dispose(TabItems);
   end;

   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;   
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;
end;

procedure Tpop_main.Ajusterlimage1Click(Sender: TObject);
var
Img:Tpop_Image;
begin
Img:=ActiveMdiChild as Tpop_Image;
if Img is Tpop_Image then (Img as Tpop_Image).Redimensioner1Click(Sender);
end;

procedure Tpop_main.outLangDtecterlesincohrencesaumodle1Click(Sender: TObject);
var
pop_choose_lang:Tpop_choose_lang;
FModel,FLang:TextFile;
i,j:Integer;
NomLanguage,WordDico,NewWord,NewWordRef,NewWordTrad,Path:string;
Trouve:Boolean;
begin
Path:=ExtractFileDir(Application.ExeName);
pop_choose_lang:=Tpop_choose_lang.Create(Application);
try
pop_choose_lang.Label1.Caption:=lang('Langage :');
pop_choose_lang.CacheFrancais;
if pop_choose_lang.ShowModal=mrOK then
   begin
   for i:=0 to pop_choose_lang.Listbox1.Items.Count-1 do
      if pop_choose_lang.Listbox1.Selected[i] then j:=i;
   NomLanguage:=pop_choose_lang.ListBox1.Items[j];


   // Verifier que tous les items du dico language sont dans le dico modele
   AssignFile(FLang,Path+'\'+NomLanguage+'.lng'); //nolang
   Reset(FLang);
   try

   j:=0;
   while not Eof(FLang) do
      begin
      Readln(FLang,NewWord);
      Inc(j);
      Trouve:=False;
      AssignFile(FModel,Path+'\Model.lng'); //nolang
      Reset(FModel);
      try
      while not Eof(FModel) do
         begin
         Readln(FModel,WordDico);
         NewWordRef:=Copy(NewWord,1,Length(WordDico));
         NewWordTrad:=Copy(NewWord,Length(WordDico)+1,Length(NewWord)-Length(WordDico));
         if NewWordRef=WordDico then
            begin
            Trouve:=True;
            Break;
            end;
         end;
      finally
      CloseFile(FModel);
      end;

      if not(Trouve) then
         ShowMessage(lang('En trop dans le langage : ')+NewWord);
      end;


   finally
   CloseFile(FLang);
   end;

   // Verifier que tous les items du dico modele sont dans le dico languge
   AssignFile(FLang,Path+'\Model.lng'); //nolang
   Reset(FModel);
   try

   j:=0;
   while not Eof(FModel) do
      begin
      Readln(FModel,WordDico);
      Inc(j);
      Trouve:=False;
      AssignFile(FLang,Path+'\'+NomLanguage+'.lng'); //nolang
      Reset(FLang);
      try
      while not Eof(FLang) do
         begin
         Readln(FLang,NewWord);
         NewWordRef:=Copy(NewWord,1,Length(WordDico));
         NewWordTrad:=Copy(NewWord,Length(WordDico)+1,Length(NewWord)-Length(WordDico));
         if NewWordRef=WordDico then
            begin
            Trouve:=True;
            Break;
            end;
         end;
      finally
      CloseFile(FLang);
      end;

      if not(Trouve) then
         ShowMessage(lang('En trop dans le modele : ')+WordDico);
      end;


   finally
   CloseFile(FModel);
   end;

   end;

finally
pop_choose_lang.Free;
end

end;

procedure Tpop_main.Texte1Click(Sender: TObject);
var
nom:String;
Image:Tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;   
   SaveDialog.InitialDir:=config.RepImages;
   SaveDialog.Filter:=lang('Fichiers texte txt|*.TXT');
   SaveDialog.FileName:=ChangeExt(Image.Caption,'.txt'); //nolang
   if SaveDialog.Execute then
      begin
      Nom:=SaveDialog.Filename;
      if (Uppercase(ExtractFileExt(Nom))<>'.TXT') then Nom:=Nom+'.txt'; //nolang
      config.RepImages:=ExtractFilePath(Nom);
      SaveText(Nom,Image.DataInt,Image.DataDouble,Image.ImgInfos.Sx,Image.ImgInfos.Sy,Image.ImgInfos.Min,Image.ImgInfos.Max,
         pop_image.ImgInfos.Sx,pop_image.ImgInfos.NbPlans,pop_image.ImgInfos.TypeComplexe);
      end;
   end;
end;

procedure Tpop_main.Occultations1Click(Sender: TObject);
begin
pop_occult:=Tpop_occult.Create(Application);
pop_occult.ShowModal;
end;

procedure Tpop_main.UpDateGUITelescope;
begin
// Griser la raquette telescope
if Config.TelescopeBranche then
   begin
   //ConnecterleTlescope1.Enabled:=False;
   ConnecterleTlescope1.Caption:=lang('Dé&connecter le Télescope');
   ToolButton4.Enabled:=True;
   Tlescope1.Enabled:=True;
   end
else
   begin
   //ConnecterleTlescope1.Enabled:=True;
   ConnecterleTlescope1.Caption:=lang('&Connecter le Télescope');
   ToolButton4.Enabled:=False;
   Tlescope1.Enabled:=False;

   if not Config.InPopScopeFormShow then // On peut pas !
      if Assigned(pop_scope) then pop_scope.Hide;
   end;
end;

procedure Tpop_main.UpDateGUIFocuser;
begin
// Griser la raquette focuseur
if Config.FocuserBranche then
   begin
   ConnecterleFocuser1.Caption:=lang('Déc&onnecter le Focuseur');
   //ConnecterleFocuser1.Enabled:=False;
   Miseaupoint1.Enabled:=True;
   ToolButton5.Enabled:=True;
   end
else
   begin
   ConnecterleFocuser1.Caption:=lang('C&onnecter le Focuseur');
   //ConnecterleFocuser1.Enabled:=True;
   Miseaupoint1.Enabled:=False;
   ToolButton5.Enabled:=False;
   //if Assigned(pop_map) then pop_map.Close;
   //if Assigned(pop_map) then pop_map.Hide;
   if Assigned(pop_map) then pop_map.Timer1.Enabled:=True;
   end;
end;

procedure Tpop_main.UpDateGUICamera;
begin
// Griser la raquette camera
if Config.CameraBranchee then
   begin
   Connecterlacamra1.Caption:=lang('Déconn&ecter la Caméra principale');
   Camra1.Enabled:=True;
   Miseaupointmanuelle1.Enabled:=True;
   ToolButton6.Enabled:=True;
   Analysemonture1.Enabled:=True;
   end
else
   begin
   Connecterlacamra1.Caption:=lang('Conn&ecter la Caméra principale');
   Camra1.Enabled:=False;
   Miseaupointmanuelle1.Enabled:=False;
   ToolButton6.Enabled:=False;
   if Assigned(pop_camera) then pop_camera.Hide;
   Analysemonture1.Enabled:=False;
   end;
end;

procedure Tpop_main.UpDateGUICameraSuivi;
begin
// Griser la raquette camera de guidage
if Config.CameraSuiviBranchee then
   begin
   Connecterlacamradesuivi1.Caption:=lang('Déconnec&ter la Caméra de guidage');
   Camradesuivi1.Enabled:=True;
   ToolButton7.Enabled:=True;
   end
else
   begin
   Connecterlacamradesuivi1.Caption:=lang('Connec&ter la Caméra de guidage');
   Camradesuivi1.Enabled:=False;
   ToolButton7.Enabled:=False;
   //if Assigned(pop_camera_suivi) then pop_camera_suivi.Close;
   if Assigned(pop_camera_suivi) then pop_camera_suivi.Hide;
   end;
end;

procedure Tpop_main.UpDateGUIDome;
begin
   if Config.DomeBranche then
      begin
      ConnecterleDome1.Caption:=lang('Déconnecter le &Dome');
      Dome1.Enabled:=True;
      ToolButton8.Enabled:=True;
      end
   else
      begin
      ConnecterleDome1.Caption:=lang('Connecter le &Dome');
      Dome1.Enabled:=False;
      ToolButton8.Enabled:=False;
      if Assigned(pop_dome) then pop_dome.Close;
      end;
end;

procedure Tpop_main.UpDateGUIHourServer;
begin
if Config.HourServerBranche then
   begin
   ConnecterleServeurdheure1.Caption:=lang('Déconnecter le &Serveur d''heure');
   Serveurdheure1.Enabled:=True;
   ToolButton9.Enabled:=True;
   end
else
   begin
   ConnecterleServeurdheure1.Caption:=lang('Connecter le &Serveur d''heure');
   Serveurdheure1.Enabled:=False;
   ToolButton9.Enabled:=False;
   //if Assigned(pop_dome) then pop_dome.Close;
   end;
end;

procedure Tpop_main.ConversionAVIClick(Sender: TObject);
var pop_avi:TPop_Avi;
begin
 pop_avi:=TPop_Avi.Create(application);
 pop_avi.showmodal;
 pop_avi.Free;
end;

procedure Tpop_main.History1Click(Sender: TObject);
begin
     pop_image_index.show;
end;

procedure Tpop_main.OutIntegrale1Click(Sender: TObject);
var
   pop_image:Tpop_image;
   ImgDouble:PImgDouble;
   Note:Double;
   i:Integer;
begin
Getmem(ImgDouble,3*4);
for i:=1 to 3 do Getmem(ImgDouble^[i],3*8);

ImgDouble^[1]^[1]:=-1; ImgDouble^[1]^[2]:=-1; ImgDouble^[1]^[3]:=-1;
ImgDouble^[2]^[1]:=-1; ImgDouble^[2]^[2]:= 5; ImgDouble^[2]^[3]:=-1;
ImgDouble^[3]^[1]:=-1; ImgDouble^[3]^[2]:=-1; ImgDouble^[3]^[3]:=-1;

try

if LastChild is Tpop_Image then
   begin
   pop_image:=pop_main.LastChild as Tpop_Image;
   Matrice(pop_image.DataInt,pop_image.DataDouble,ImgDouble,3,pop_image.ImgInfos.TypeData,
      pop_image.ImgInfos.NbPlans,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy);
   Note:=IntegraleAbs(pop_image.DataInt,pop_image.DataDouble,pop_image.ImgInfos.TypeData,
      pop_image.ImgInfos.NbPlans,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy);
   ShowMessage(MyFloatToStr(Note,2));
   end;



finally
for i:=1 to 3 do Freemem(ImgDouble^[i],3*8);
Freemem(ImgDouble,3*4);
end;
end;

procedure Tpop_main.BestofPlantaire1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
NbMaxImages:Integer;
TabItems:PTabItems;
DlgStandard:Tpop_dlg_standard;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and (pop_select_lot.ListBox.Items.Count<>0) then
   begin
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   Directory:=pop_select_lot.DirectoryListBox1.Directory;
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   VerifieLot(Directory,ListeImg,Rapport,True);

   New(TabItems);
   try

   IniTabItems(TabItems);

   with TabItems^[1] do
      begin
      TypeItem:=tiInteger;
      Msg:=lang('Nombre max d''images finales : ');
      ValeurIncrement:=1;
      ValeurDefaut:=ListeImg.Count;
      ValeurMin:=2;
      ValeurMax:=ListeImg.Count;
      end;

   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
   DlgStandard.Caption:=lang('Best of planétaire');
   if DlgStandard.ShowModal=mrOK then
      begin
      NbMaxImages:=Round(TabItems^[1].ValeurSortie);
      BestOfPlanetaire(Directory,ListeImg,NbMaxImages,Rapport);
      end
   else DlgStandard.Free;

   finally
   Dispose(TabItems);
   end;

   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;   
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;
end;

procedure Tpop_main.ProjectionTeleacopique1Click(Sender: TObject);
var
   pop_cree_proj:Tpop_cree_proj;
   Image:Tpop_Image;
   AstrometrieInfos:TAstrometrieInfos;
   i:Integer;
   FluxMag14:Double;
   Rapport:tpop_rapport;
begin
   pop_cree_proj:=Tpop_cree_proj.Create(Application);
   if Config.FocaleTele<>0 then
      pop_cree_proj.NbreEdit1.Text:=MyFloatToStr(Config.FocaleTele,2)
   else pop_cree_proj.NbreEdit1.Text:='1';
   if Camera.GetXPixelSize<>0 then
      pop_cree_proj.NbreEdit2.Text:=MyFloatToStr(Camera.GetXPixelSize,2)
   else pop_cree_proj.NbreEdit2.Text:='9';
   if Camera.GetYPixelSize<>0 then
      pop_cree_proj.NbreEdit3.Text:=MyFloatToStr(Camera.GetYPixelSize,2)
   else pop_cree_proj.NbreEdit3.Text:='9';
   if pop_cree_proj.ShowModal=mrOK then
      begin
      AstrometrieInfos.Alpha0:=StrToAlpha(pop_cree_proj.Mask_Alpha.Text);
      AstrometrieInfos.Delta0:=StrToDelta(pop_cree_proj.Mask_Delta.Text);
      AstrometrieInfos.Sx:=StrToInt(pop_cree_proj.SpinEdit1.Text);
      AstrometrieInfos.Sy:=StrToInt(pop_cree_proj.SpinEdit2.Text);
      AstrometrieInfos.Focale:=MyStrToFloat(pop_cree_proj.NbreEdit1.Text);
      AstrometrieInfos.TaillePixelX:=MyStrToFloat(pop_cree_proj.NbreEdit2.Text);
      AstrometrieInfos.TaillePixelY:=MyStrToFloat(pop_cree_proj.NbreEdit2.Text);      
      if pop_cree_proj.CheckBox1.Checked then FluxMag14:=-1000
      else FluxMag14:=MyStrToFloat(pop_cree_proj.Edit1.Text);
      AstrometrieInfos.USNOSelected:=False;
      AstrometrieInfos.GSCCSelected:=False;
      AstrometrieInfos.TY2Selected:=False;
      AstrometrieInfos.MCT1Selected:=False;
      AstrometrieInfos.MCT2Selected:=False;
      AstrometrieInfos.MCT3Selected:=False;
      AstrometrieInfos.BSCSelected:=False;
      for i:=0 to pop_cree_proj.outListbox1.Items.Count-1 do
         begin
         if pop_cree_proj.outListbox1.Items[i]='USNO' then //nolang
            if pop_cree_proj.outListbox1.Selected[i] then
               AstrometrieInfos.USNOSelected:=True;
         if pop_cree_proj.outListbox1.Items[i]='GSC' then //nolang
            if pop_cree_proj.outListbox1.Selected[i] then
               AstrometrieInfos.GSCCSelected:=True;
         if pop_cree_proj.outListbox1.Items[i]='Tycho2' then //nolang
            if pop_cree_proj.outListbox1.Selected[i] then
               AstrometrieInfos.TY2Selected:=True;
         if pop_cree_proj.outListbox1.Items[i]='MicroCat' then //nolang
            if pop_cree_proj.outListbox1.Selected[i] then
               AstrometrieInfos.MCT3Selected:=True;
         if pop_cree_proj.outListbox1.Items[i]='BSC' then //nolang
            if pop_cree_proj.outListbox1.Selected[i] then
               AstrometrieInfos.BSCSelected:=True;
         AstrometrieInfos.TypeGSC:=Config.TypeGSC;
         end;

      Image:=ActiveMDIChild as Tpop_Image;
      pop_image:=tpop_image.create(application);

      try
      pop_image.ImgInfos.Sx:=StrToInt(pop_cree_proj.SpinEdit1.Text);
      pop_image.ImgInfos.Sy:=StrToInt(pop_cree_proj.SpinEdit2.Text);;
      pop_image.ImgInfos.TypeData:=2;
      pop_image.ImgInfos.NbPlans:=1;
      GetmemImg(pop_image.DataInt,pop_image.DataDouble,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy,
                pop_image.ImgInfos.TypeData,pop_image.ImgInfos.NbPlans);
      pop_image.ImgInfos.Min[1]:=0;
      pop_image.ImgInfos.Max[1]:=2000;
      pop_image.Caption:=GiveName(lang('Projection'),pop_image);

      pop_image.SaveUndo;
      Screen.Cursor:=crHourGlass;
      try
      Rapport:=tpop_rapport.Create(Application);
      Rapport.Show;
      try
      CreeProjTelescope(pop_image.DataInt,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy,AstrometrieInfos,FluxMag14,Rapport);
      pop_image.AjusteFenetre;
      pop_image.VisuImg;
      pop_image.ChangerMenu;
      SeuilsEnable;
      finally
      Rapport.Quitter.Enabled:=True;
      Rapport.BitBtn1.Enabled:=True;
      Rapport.BitBtn2.Enabled:=True;
      Rapport.BitBtn3.Enabled:=True;      
      end;
      finally
      Screen.Cursor:=crDefault;
      end;

      except
      pop_image.Free;
      end;

      end;
end;

procedure Tpop_main.Analysemonture1Click(Sender: TObject);
var
x,y,xx,yy:Integer;
Pose:Double;
ValMax:Double;
LargFen:Integer;
Fin:Boolean;
PSF:TPSF;
ImgNil:PTabImgDouble;
NbEchecs:Integer;
begin
TesteFocalisation:=True;

Analysemonture1.Enabled:=False;
try
if AnalMonture then Exit;
AnalMonture:=True;

NbEchecs:=0;

if pop_camera.pop_image_acq=nil then
    pop_camera.pop_image_acq:=tpop_image.Create(Application);
pop_camera.pop_image_acq.Bloque:=True;
pop_camera.pop_image_acq.IsUsedForAcq:=True;
if pop_anal_monture=nil then pop_anal_monture:=tpop_anal_monture.create(application);
pop_anal_monture.Show;
StopAnalMonture:=False;

LargFen:=config.LargFoc;

WriteSpy(lang('Recherche des coordonnées de l''étoile la plus brillante'));
if Assigned(pop_anal_monture) then
   pop_anal_monture.AddMessage(lang('Recherche des coordonnées de l''étoile la plus brillante'));
// Trouver ses coordonnee en Binning 4x4
//AcqNonSatur(x,y);
pop_camera.AcqMaximumBinning(x,y);
pop_main.SeuilsEnable;
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

if StopAnalMonture then
   begin
   WriteSpy(lang('Arrêt de l''analyse de la monture'));
   if Assigned(pop_anal_monture) then pop_anal_monture.AddMessage(lang('Arrêt de l''analyse de la monture'));
   StopAnalMonture:=False;
   Exit;
   pop_camera.pop_image_acq.Bloque:=False;
   end;

WriteSpy(lang('Coordonnées de l''étoile X=')+IntToStr(x)
   +' Y='+IntToStr(y)); //nolang
if Assigned(pop_anal_monture) then pop_anal_monture.AddMessage(lang('Coordonnées de l''étoile X=')+IntToStr(x)
   +' Y='+IntToStr(y)); //nolang
// Premiere aquisition de l'etoile
WriteSpy(lang('Passage en vignette'));
if Assigned(pop_anal_monture) then pop_anal_monture.AddMessage(lang('Passage en vignette'));
Pose:=1;
if (x>LargFen+1) and (y>LargFen+1) and (x<Camera.GetXSize-LargFen) and (y<Camera.GetYSize-LargFen) then
   begin
   pop_camera.Acquisition(x-LargFen,y-LargFen,x+LargFen,y+LargFen,Pose,1,False)
   end
// A FAIRE Plus tard -> trouver une autre etoile
else
   begin
   WriteSpy(lang('Etoile trop près du bord'));
   WriteSpy(lang('Arrêt de l''analyse de la monture'));
   if Assigned(pop_anal_monture) then
      begin
      pop_anal_monture.AddMessage(lang('Etoile trop près du bord'));
      pop_anal_monture.AddMessage(lang('Arrêt de l''analyse de la monture'));
      end;
   Exit;
   pop_camera.pop_image_acq.Bloque:=False;
   end;
pop_camera.pop_image_acq.AjusteFenetre;
pop_camera.pop_image_acq.VisuAutoEtoiles;

if StopAnalMonture then
   begin
   WriteSpy(lang('Arrêt de l''analyse de la monture'));
   if Assigned(pop_anal_monture) then pop_anal_monture.AddMessage(lang('Arrêt de l''analyse de la monture'));
   StopAnalMonture:=False;
   Exit;
   pop_camera.pop_image_acq.Bloque:=False;
   end;

GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
   pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);
// Desaturer en 1x1
// Si le maxi est sature on baisse le temps de pose
WriteSpy(lang('Désaturation de l''étoile si nécessaire'));
if Assigned(pop_anal_monture) then pop_anal_monture.AddMessage(lang('Désaturation de l''étoile si nécessaire'));
//while (ValMax>config.Satur) and (Pose>config.MinPose) do
while (ValMax>Camera.GetSaturationLevel) and (Pose>config.MinPose) do
   begin
   if StopAnalMonture then
      begin
      WriteSpy(lang('Arrêt de l''analyse de la monture'));
      if Assigned(pop_anal_monture) then pop_anal_monture.AddMessage(lang('Arrêt de l''analyse de la monture'));
      StopAnalMonture:=False;
      Exit;
      pop_camera.pop_image_acq.Bloque:=False;
      end;
   Pose:=Pose/2;
   if (x>LargFen+1) and (y>LargFen+1) and (x<Camera.GetXSize-LargFen) and (y<Camera.GetYSize-LargFen) then
      begin
      pop_camera.Acquisition(x-LargFen,y-LargFen,x+LargFen,y+LargFen,Pose,1,False)
      end
   else
      begin
      WriteSpy(lang('Etoile trop près du bord'));
      WriteSpy(lang('Arrêt de l''analyse de la monture'));
      if Assigned(pop_anal_monture) then
         begin
         pop_anal_monture.AddMessage(lang('Etoile trop près du bord'));
         pop_anal_monture.AddMessage(lang('Arrêt de l''analyse de la monture'));
         end;
      Exit;
      pop_camera.pop_image_acq.Bloque:=False;
      end;
   GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);

   pop_camera.pop_image_acq.AjusteFenetre;   
   pop_camera.pop_image_acq.VisuAutoEtoiles;
   end;
if Pose<=config.MinPose then
   begin
   WriteSpy(lang('Temps de pose mini atteint j''arrête'));
   if Assigned(pop_anal_monture) then pop_anal_monture.AddMessage(lang('Temps de pose mini atteint j''arrête'));
   end;

// Corriger les coordonnées pour mettre l'etoile au centre
// Corriger x et y en fonction de xx et yy
GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
   pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);

//if config.MirrorX then x:=x+LargFen-xx else x:=x-LargFen+xx;
//if config.MirrorY then y:=y+LargFen-yy else y:=y-LargFen+yy;
x:=x-LargFen+xx;
x:=x-LargFen+xx;

Fin:=False;
while not(Fin) and (NbEchecs<=5) do
   begin
   if StopAnalMonture then
      begin
      WriteSpy(lang('Arrêt de l''analyse de la monture'));
      if Assigned(pop_anal_monture) then
         pop_anal_monture.AddMessage(lang('Arrêt de l''analyse de la monture'));
      StopAnalMonture:=False;
      Exit;
      pop_camera.pop_image_acq.Bloque:=False;
      end;
   if (x>LargFen+1) and (y>LargFen+1) and (x<Camera.GetXSize-LargFen) and (y<Camera.GetYSize-LargFen) then
      begin
      pop_camera.Acquisition(x-LargFen,y-LargFen,x+LargFen,y+LargFen,Pose,1,False)
      end
   else
      begin
      WriteSpy(lang('Etoile trop près du bord'));
      WriteSpy(lang('Arrêt de l''analyse de la monture'));
      if Assigned(pop_anal_monture) then
         begin
         pop_anal_monture.AddMessage(lang('Etoile trop près du bord'));
         pop_anal_monture.AddMessage(lang('Arrêt de l''analyse de la monture'));
         end;
      Exit;
      pop_camera.pop_image_acq.Bloque:=False;
      end;

   pop_camera.pop_image_acq.AjusteFenetre;   
   pop_camera.pop_image_acq.VisuAutoEtoiles;

//   ModeliseEtoile(pop_camera.pop_image_acq.DataInt,nil,2,2*LargFen+1,xx,yy,TGauss,LowPrecision,LowSelect,0,PSF);
   ModeliseEtoile(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
      2*LargFen+1,TGauss,LowPrecision,LowSelect,0,PSF);

   if (Assigned(pop_anal_monture)) and (PSF.Flux<>-1) then
      pop_anal_monture.Add(HeureToJourJulien(GetHourDT),x-LargFen+PSF.X,y-LargFen+PSF.Y,PSF.Sigma);

   if PSF.Flux=-1 then
      begin
      Inc(NbEchecs);
      WriteSpy(lang('Echec de la modélisation'));
      if Assigned(pop_anal_monture) then pop_anal_monture.AddMessage(lang('Echec de la modélisation'));
      end
   else
      begin

      GetMax(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
         pop_camera.pop_image_acq.ImgInfos.sx,pop_camera.pop_image_acq.ImgInfos.sy,xx,yy,ValMax);

//      if config.MirrorX then x:=x+LargFen-xx else x:=x-LargFen+xx;
//      if config.MirrorY then y:=y+LargFen-yy else y:=y-LargFen+yy;
      x:=x-LargFen+xx;
      y:=y-LargFen+yy;
      end
   end;

if NbEchecs>5 then pop_anal_monture.Close;

finally
pop_camera.pop_image_acq.Bloque:=False;
AnalMonture:=False;
Analysemonture1.Enabled:=True;
end;
end;

procedure Tpop_main.Connecterlacamradesuivi1Click(Sender: TObject);
begin
   if not(Config.CameraSuiviBranchee) then
      begin
      CameraSuiviConnect;
      if not(Config.CameraSuiviBranchee) then
      ShowMessage(lang('Aucune caméra de guidage détectée'));
      end
   else CameraSuiviDisconnect;
end;

procedure Tpop_main.Convertiondetypedefichiers1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
pop_image:tpop_image;
i:Integer;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and
(pop_select_lot.ListBox.Items.Count<>0) then
   begin

   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   Directory:=config.RepImages;
   try
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   config.RepImages:=pop_select_lot.DirectoryListBox1.Directory;
   pop_image:=tpop_image.create(application);
   for i:=0 to ListeImg.Count-1 do
      begin
      try
      Rapport.AddLine(lang('Conversion l''image ')+ListeImg[i]);
      pop_image.ReadImage(ListeImg[i]);
      pop_image.SaveImage('c_'+ListeImg[i]); //nolang
      if i <> ListeImg.Count-1 then
         begin
         freememimg(pop_image.DataInt,pop_image.DataDouble,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy,
                    pop_image.ImgInfos.TypeData,pop_image.ImgInfos.NbPlans);
         end;
      except
      on E: Exception do
         begin
         ShowMessage(E.Message);
         end;
      end;
   end;
   MiseAJourMenu(Sender);
   finally
   config.RepImages:=Directory;
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;   
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;
end;

procedure Tpop_main.Miseaupointmanuelle1Click(Sender: TObject);
begin
TesteFocalisation:=True;
pop_map.btn_manuelClick(Sender);
end;

procedure Tpop_main.Timer1Timer(Sender: TObject);
var
   HeapStatus:THeapStatus;
   F:TextFile;
begin
Timer1.Enabled:=False;
try
HeapStatus:=System.GetHeapStatus;
Caption:='TeleAuto '+VersionTeleAuto+' '+IntToStr((HeapStatus.TotalAllocated div 1024))+'kb'; //nolang
except
end;

if not InSpy and (SpyLines.Count<>0) then
   begin
   AssignFile(F,ExtractFilePath(Application.ExeName)+'Spy.log'); //nolang
   try
   Append(F);

   while SpyLines.Count<>0 do
      begin
      Writeln(F,SpyLines[0]);
      if not(config.Initialisation) and Assigned(pop_spy) then
         begin
         pop_spy.list_spy.items.Add(SpyLines[0]);
         if pop_spy.list_spy.Items.Count>7 then pop_spy.list_spy.TopIndex:=pop_spy.list_spy.Items.Count-7;
         end;
      SpyLines.Delete(0);
      end;

   finally
   CloseFile(F);
   end;
   end;
Timer1.Enabled:=True;   
end;

procedure Tpop_main.OutCadre1Click(Sender: TObject);
var
   pop_image:Tpop_image;
   i,j,k:Integer;
begin
   pop_image:=tpop_image.create(application);
   pop_image.ImgInfos.TypeData:=2;
   pop_image.ImgInfos.NbPlans:=1;
   pop_image.ImgInfos.Sx:=3000;
   pop_image.ImgInfos.Sy:=pop_image.ImgInfos.Sx;
   pop_image.ImgInfos.Min[1]:=0;
   pop_image.ImgInfos.Max[1]:=32767;
   pop_image.ChangerMenu;
   GetmemImg(pop_image.DataInt,pop_image.DataDouble,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy,
      pop_image.ImgInfos.TypeData,pop_image.ImgInfos.NbPlans);

   for i:=1 to pop_image.ImgInfos.Sx do
      for j:=1 to pop_image.ImgInfos.Sy do
         pop_image.DataInt^[1]^[j]^[i]:=0;

   for i:=1 to pop_image.ImgInfos.Sx do
      begin
      pop_image.DataInt^[1]^[2]^[i]:=32767;
      pop_image.DataInt^[1]^[pop_image.ImgInfos.Sy-1]^[i]:=32767;
      end;
   for i:=1 to pop_image.ImgInfos.Sy do
      begin
      pop_image.DataInt^[1]^[i]^[2]:=32767;
      pop_image.DataInt^[1]^[i]^[pop_image.ImgInfos.Sx-1]:=32767;
      end;

   for k:=1 to (pop_image.ImgInfos.Sx div 2) do
      begin
      if (k mod 50)=0 then
         begin
         for i:=1 to pop_image.ImgInfos.Sx do
            begin
            pop_image.DataInt^[1]^[k]^[i]:=32767;
//            pop_image.DataInt^[1]^[pop_image.ImgInfos.Sx-k]^[i]:=32767;
            end;
         for i:=1 to pop_image.ImgInfos.Sy do
            begin
            pop_image.DataInt^[1]^[i]^[k]:=32767;
//            pop_image.DataInt^[1]^[i]^[pop_image.ImgInfos.Sy-k]:=32767;
            end;
         end;
      end;

   pop_image.DataInt^[1]^[pop_image.ImgInfos.Sy-10]^[10]:=32767;      

   pop_image.AjusteFenetre;
   pop_image.visuImg;
   pop_image.ChangerMenu;
   SeuilsEnable;
end;

procedure Tpop_main.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
if not(Config.Initialisation) then WriteSpy('Exception Raised : '+E.Message); //nolang
// Securite ! non ca empire les choses
//if (Config.TypeTelescope<>0) and Config.TelescopeBranche then Telescope.Quit;
//if (Config.TypeFocuser<>0) and Config.FocuserBranche then MAP.ArreteMapTime;
end;

procedure Tpop_main.outTestMoindrescarrs1Click(Sender: TObject);
var
   i,N,Nb,k:Integer;
   x,y,sig:PLigDouble;
   a:DoubleArrayRow;
   covar:DoubleArray;
   Da,Chisq,Moy,Ecart,Dx,Me1:Double;
begin
   k:=100;
   Nb:=100;

   if not(Assigned(Rapport)) then Rapport:=Tpop_Rapport.Create(Self);
   Rapport.Show;
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;   

   // Calcul par moyenne
   // Fonction a fitter : y=b
   // Avec
   // y = Magnitude de l'etalon+2.5 x log du flux de l'étalon
   Getmem(x,8*Nb);
   Getmem(y,8*Nb);
   Getmem(Sig,8*Nb);
   try

   Moy:=0;
   Ecart:=0;
   N:=0;
   for i:=1 to Nb do
      begin
      y^[i]:=Round(1000+RandN(k)*100);
      inc(N);
      Dx:=y^[i]-Moy;
      Moy:=Moy+Dx/N;
      Ecart:=Ecart+Dx*(y^[i]-Moy);
      Sig^[i]:=1; // On sait pas a priori
      end;
   Ecart:=Sqrt(Ecart/N);
{procedure lfitCste(var y,sig:PLigDouble;
                   ndata:Integer;
                   var a:DoubleArrayRow;
                   var covar:DoubleArray;
                   var chisq:Double);}
   lfitCste(y,Sig,Nb,a,Covar,Chisq);
//   me1=Sqrt(Chisq/(N-n))/s
   Me1:=Sqrt(Chisq/(Nb-1));
   // On corrige l'incertitude si on a surestime les incertitudes avec Sig=1
   Da:=Sqrt(Abs(Covar[1,1])*Chisq/(Nb-1));

   Rapport.AddLine('Moindres carrés = '+MyFloatToStr(a[1],6)+'+/-'+MyFloatToStr(Da,6)); //nolang
   Rapport.AddLine('Moyenne/Sigma = '+MyFloatToStr(Moy,6)+'+/-'+MyFloatToStr(Ecart,6)); //nolang
   Rapport.AddLine('Chisq = '+MyFloatToStr(Chisq,6)); //nolang
   Rapport.AddLine('Me1 = '+MyFloatToStr(Me1,6)); //nolang
   Rapport.AddLine(' '); //nolang
   Rapport.AddLine('Moyenne/Sigma Réels = 1000/100'); //nolang


   finally
   Freemem(x,8*Nb);
   Freemem(y,8*Nb);
   Freemem(Sig,8*Nb);
   end;
end;

procedure Tpop_main.outTestMoindrescarrsdegr01Click(Sender: TObject);
var
   i,Nb,k:Integer;
   x,y,sig:PLigDouble;
   a:DoubleArrayRow;
   covar:DoubleArray;
   Da,Db,Chisq,Somme,ValCalcul:Double;
begin
   k:=100;
   Nb:=10000;

   if not(Assigned(Rapport)) then Rapport:=Tpop_Rapport.Create(Self);
   Rapport.Show;
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;

   // Calcul par moyenne
   // Fonction a fitter : y=b
   // Avec
   // y = Magnitude de l'etalon+2.5 x log du flux de l'étalon
   Getmem(x,8*Nb);
   Getmem(y,8*Nb);
   Getmem(Sig,8*Nb);
   try

   for i:=1 to Nb do
      begin
      x^[i]:=i;
      y^[i]:=1000+2.5*i+RandN(k)*100;
//      y^[i]:=1000+2.5*i;
      Sig^[i]:=1;
      end;
   lfitLin(x,y,Sig,Nb,a,Covar,Chisq);
   Da:=Sqrt(Abs(Covar[1,1])*Chisq);
   Db:=Sqrt(Abs(Covar[2,2])*Chisq);
//   Da:=Sqrt(Abs(Covar[1,1]));
//   Db:=Sqrt(Abs(Covar[2,2]));

   // Verif du chi2
   Somme:=0;
   for i:=1 to Nb do
      begin
      ValCalcul:=a[2]*x^[i]+a[1];
      Somme:=Somme+Sqr(ValCalcul-y^[i]);
      end;
//   Somme:=Sqrt(Somme/Nb);

   Rapport.AddLine('a = '+MyFloatToStr(a[1],6)+'+/-'+MyFloatToStr(Da,6)); //nolang
   Rapport.AddLine('b = '+MyFloatToStr(a[2],6)+'+/-'+MyFloatToStr(Db,6)); //nolang
   Rapport.AddLine('Chisq = '+MyFloatToStr(Chisq,6)); //nolang
   Rapport.AddLine('Verif Chisq = '+MyFloatToStr(Somme,6)); //nolang
   Rapport.AddLine('Chi = '+MyFloatToStr(Sqrt(Chisq),6)); //nolang
   Rapport.AddLine('Chi/Nb = '+MyFloatToStr(Sqrt(Chisq)/Nb,6)); //nolang
   Rapport.AddLine('(Chi/(Nb-2))^2 = '+MyFloatToStr(Sqrt(Chisq/(Nb-2)),6)+' -> C''est bien cela !'); //nolang
   // Nb-2 = Stetson :
   // The sum of the squares of these residuals is divided by N - 2 instead of N to eliminate a bias
   // in the estimate of the scatter : any two points define a straight line perfectly, so if there
   // are two data points the residuals from the "best" fit will always be zero regardless of the
   // true errors in the yi. It works similarly for other values of N : since we have used our data
   // points to determine two previously unknown quantities, the observed scatter of the data about
   // the best fit will always be a little bit less than the actual scatter about the true relationship.
   // Dividing by N - 2 instead of N completely removes this bias; you can find a mathematical proof of
   // this statement in a text on the theory of statistics.
   Rapport.AddLine(' ');
   Rapport.AddLine('Réel y=2.5x+1000'); //nolang
   Rapport.AddLine('Sigma Réel s=100'); //nolang


   finally
   Freemem(x,8*Nb);
   Freemem(y,8*Nb);
   Freemem(Sig,8*Nb);
   end;
end;

procedure Tpop_main.outTestSvdFitAstro1Click(Sender: TObject);
var
   Nb,i,j,k,l,ma:Integer;
   x,x1,x2,SigX:PLigDouble;
   PolyX:DoubleArrayRow;
   // svd
   u,v,cvm:DoubleArray;
   w:DoubleArrayRow;
   ChisqX:Double;
begin

if not(Assigned(Rapport)) then Rapport:=Tpop_Rapport.Create(Self);
Rapport.Show;
Rapport.Quitter.Enabled:=True;
Rapport.BitBtn1.Enabled:=True;
Rapport.BitBtn2.Enabled:=True;
Rapport.BitBtn3.Enabled:=True;

Nb:=25;

Getmem(x,8*Nb);
Getmem(x1,8*Nb);
Getmem(x2,8*Nb);
Getmem(Sigx,8*Nb);

try

k:=0;
for i:=1 to 5 do
   for j:=1 to 5 do
      begin
      inc(k);
      x1^[k]:=i;
      x2^[k]:=j;
//      x^[k]:=1113+1.2*x1[k]-2.5*x2[k]+0.5*x1[k]*x1[k]+0.2*x1[k]*x2[k]+0.1*x2[k]*x2[k];
      x^[k]:=202.14-0.227*x1^[k]+0.967*x2^[k];
//      x^[k]:=1113+1.2*x1[k]-2.5*x2[k]+RandN(l)*1;
      sigx^[k]:=1;
      end;

// Recherche du polynôme de passage en X
//lfitAstro(x1,x2,x,SigX,NbStarGagnant,AstrometrieInfos.PolyX,CovarX,ChisqX,degre+1);
SvdFitAstro(x1,x2,x,SigX,Nb,PolyX,u,v,w,ChisqX,3);
SvdVarAstro(v,w,cvm,3);

ma:=1;
for i:=1 to 3 do ma:=ma+i+1;

Rapport.AddLine(' ');
Rapport.AddLine(lang('Polynômes de passage en X'));
for i:=1 to ma do Rapport.AddLine(Format('a[%d] = %6.3f +/- %6.10f', //nolang
   [i,PolyX[i],Sqrt(Abs(cvm[i,i]))])); //nolang

Rapport.AddLine(' ');
Rapport.AddLine(lang('Reel : '));
Rapport.AddLine('1113'); //nolang
Rapport.AddLine('1.2'); //nolang
Rapport.AddLine('-2.5'); //nolang
Rapport.AddLine('0.5'); //nolang
Rapport.AddLine('0.2'); //nolang
Rapport.AddLine('0.1'); //nolang

finally
Freemem(x,8*Nb);
Freemem(x1,8*Nb);
Freemem(x2,8*Nb);
Freemem(Sigx,8*Nb);
end
end;

procedure Tpop_main.outTestSvdFitAstrosurcasreel1Click(Sender: TObject);
var
   Nb,i,ma,Degre:Integer;
   x,x1,x2,SigX:PLigDouble;
   PolyX:DoubleArrayRow;
   // svd
   cvm:DoubleArray;
   ChisqX:Double;
begin
if not(Assigned(Rapport)) then Rapport:=Tpop_Rapport.Create(Self);
Rapport.Show;
Rapport.Quitter.Enabled:=True;
Rapport.BitBtn1.Enabled:=True;
Rapport.BitBtn2.Enabled:=True;
Rapport.BitBtn3.Enabled:=True;

Nb:=29;
Degre:=5;

Getmem(x,8*Nb);
Getmem(x1,8*Nb);
Getmem(x2,8*Nb);
Getmem(Sigx,8*Nb);

try

x1^[1]:= 472.096; x2^[1]:= 226.353; x^[1]:= 313.516;
x1^[2]:= 152.366; x2^[2]:= 368.445; x^[2]:= 523.582;
x1^[3]:= 476.121; x2^[3]:= 464.588; x^[3]:= 542.633;
x1^[4]:= 302.779; x2^[4]:= 350.228; x^[4]:= 472.419;
x1^[5]:= 687.722; x2^[5]:= 337.100; x^[5]:= 371.698;
x1^[6]:= 159.960; x2^[6]:= 318.445; x^[6]:= 473.926;
x1^[7]:= 694.378; x2^[7]:= 427.456; x^[7]:= 457.685;
x1^[8]:= 396.720; x2^[8]:= 350.753; x^[8]:= 451.121;
x1^[9]:= 749.495; x2^[9]:= 400.652; x^[9]:= 419.145;
x1^[10]:=432.227; x2^[10]:=476.266; x^[10]:=564.571;
x1^[11]:=494.553; x2^[11]:=446.707; x^[11]:=521.688;
x1^[12]:=382.231; x2^[12]:=106.072; x^[12]:=217.780;
x1^[13]:=713.646; x2^[13]:=328.752; x^[13]:=357.809;
x1^[14]:=554.479; x2^[14]:=187.076; x^[14]:=256.849;
x1^[15]:=198.887; x2^[15]:=300.683; x^[15]:=447.655;
x1^[16]:=230.961; x2^[16]:=103.235; x^[16]:=249.408;
x1^[17]:=537.910; x2^[17]:=156.318; x^[17]:=231.032;
x1^[18]:=636.162; x2^[18]:=184.227; x^[18]:=235.643;
x1^[19]:=141.815; x2^[19]:=353.808; x^[19]:=511.811;
x1^[20]:=621.020; x2^[20]:=487.365; x^[20]:=532.218;
x1^[21]:=561.131; x2^[21]:=143.857; x^[21]:=213.541;
x1^[22]:=700.808; x2^[22]:=495.570; x^[22]:=522.088;
x1^[23]:=369.367; x2^[23]:=164.428; x^[23]:=277.083;
x1^[24]:=292.765; x2^[24]:=197.808; x^[24]:=326.506;
x1^[25]:=472.018; x2^[25]:=135.954; x^[25]:=226.228;
x1^[26]:=261.353; x2^[26]:= 44.207; x^[26]:=185.788;
x1^[27]:=699.785; x2^[27]:=180.494; x^[27]:=217.545;
x1^[28]:=422.940; x2^[28]:=278.080; x^[28]:=374.978;
x1^[29]:=671.185; x2^[29]:= 62.230; x^[29]:=109.945;

{x1^[1]:= 472.096; x2^[1]:= 226.353;
x1^[2]:= 152.366; x2^[2]:= 368.445;
x1^[3]:= 476.121; x2^[3]:= 464.588;
x1^[4]:= 302.779; x2^[4]:= 350.228;
x1^[5]:= 687.722; x2^[5]:= 337.100;
x1^[6]:= 159.960; x2^[6]:= 318.445;
x1^[7]:= 694.378; x2^[7]:= 427.456;
x1^[8]:= 396.720; x2^[8]:= 350.753;
x1^[9]:= 749.495; x2^[9]:= 400.652;
x1^[10]:=432.227; x2^[10]:=476.266;
x1^[11]:=494.553; x2^[11]:=446.707;
x1^[12]:=382.231; x2^[12]:=106.072;
x1^[13]:=713.646; x2^[13]:=328.752;
x1^[14]:=554.479; x2^[14]:=187.076;
x1^[15]:=198.887; x2^[15]:=300.683;
x1^[16]:=230.961; x2^[16]:=103.235;
x1^[17]:=537.910; x2^[17]:=156.318;
x1^[18]:=636.162; x2^[18]:=184.227;
x1^[19]:=141.815; x2^[19]:=353.808;
x1^[20]:=621.020; x2^[20]:=487.365;
x1^[21]:=561.131; x2^[21]:=143.857;
x1^[22]:=700.808; x2^[22]:=495.570;
x1^[23]:=369.367; x2^[23]:=164.428;
x1^[24]:=292.765; x2^[24]:=197.808;
x1^[25]:=472.018; x2^[25]:=135.954;
x1^[26]:=261.353; x2^[26]:= 44.207;
x1^[27]:=699.785; x2^[27]:=180.494;
x1^[28]:=422.940; x2^[28]:=278.080;
x1^[29]:=671.185; x2^[29]:= 62.230;}

for i:=1 to 29 do
  begin
  SigX^[i]:=0.0001;
//  x^[i]:=202.14-0.227*x1^[i]+0.967*x2^[i];
  end;

// Recherche du polynôme de passage en X
lfitAstro(x1,x2,x,SigX,Nb,PolyX,cvm,ChisqX,degre);
//SvdFitAstro(x1,x2,x,SigX,Nb,PolyX,u,v,w,ChisqX,Degre);
//SvdVarAstro(v,w,cvm,Degre);

ma:=1;
for i:=1 to Degre do ma:=ma+i+1;

Rapport.AddLine(' ');
Rapport.AddLine(lang('Polynômes de passage en X'));
for i:=1 to ma do Rapport.AddLine(Format('a[%d] = %6.3f +/- %6.10f', //nolang
   [i,PolyX[i],Sqrt(Abs(cvm[i,i]))])); //nolang

for i:=1 to 29 do
   begin
   Rapport.AddLine(Format('%6.10f',[x^[i]-CalcPolynomeXY(x1^[i],x2^[i],PolyX,Degre)])); //nolang
   end;


finally
Freemem(x,8*Nb);
Freemem(x1,8*Nb);
Freemem(x2,8*Nb);
Freemem(Sigx,8*Nb);
end
end;

procedure Tpop_main.Crerunprofil1Click(Sender: TObject);
var
   pop_create_prf:Tpop_create_prf;
begin
pop_create_prf:=Tpop_create_prf.Create(Application);
pop_create_prf.ShowModal;
end;

procedure Tpop_main.Nouvellecarteduciel1Click(Sender: TObject);
var
   pop_skychart: Tpop_skychart;
begin
pop_skychart:=Tpop_skychart.Create(Application);
pop_skychart.Show;
end;

procedure Tpop_main.ToolbarButton9718Click(Sender: TObject);
var
   Image:tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   Image.Informations1Click(Sender);;
   end;
end;

procedure Tpop_main.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   Path:string;
begin
if Config.CloseQuery then
   begin
   CanClose:=False;

   try
   New(TabItems);

   IniTabItems(TabItems);

   with TabItems^[1] do
      begin
      TypeItem:=tiLabel;
      Msg:=lang('Souhaitez-vous quitter TeleAuto ?');
      end;

   with TabItems^[2] do
      begin
      TypeItem:=tiCheckBox;
      Msg:=lang('Ne plus poser cette question');
      ValeurCheckDefaut:=False;
      end;

   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
   DlgStandard.SetOKButton(lang('Quitter'));
   DlgStandard.Caption:=lang('Confirmation');
   if DlgStandard.ShowModal=mrOK then
      begin
      CanClose:=True;
      Config.CloseQuery:=TabItems^[2].ValeurSortie=0;

      Path:=LowerCase(ExtractFilePath(Application.ExeName));
      SaveParametres(Path+'TeleAuto.ini');  //nolang
      end;

   finally
   Dispose(TabItems);
   end;
   end
else CanClose:=True;

end;

procedure Tpop_main.outLangRecherchedelangetnolang1Click(Sender: TObject);
var
   FIn,FOut:TextFile;
   LineCode,Rep:string;
   Pos1,Pos2:Integer;
 	sr:TSearchRec;
begin
	Rep:=extractFileDir(application.exeName)+'\';

  	AssignFile(FOut,Rep+'Detect.txt'); //nolang
   Rewrite(FOut);

   // Search string resources in pas files}
	if FindFirst(Rep+'*.pas',faAnyFile,sr)=0 then  //nolang
   	repeat
   	AssignFile(FIn,Rep+sr.name);
      Reset(FIn);

      while not(Eof(FIn)) do
         begin
         Readln(FIn,LineCode);

         Pos1:=Pos('lang(',LineCode); //nolang
         Pos2:=Pos('nolang',LineCode); //nolang

         if (Pos1<>0) and (Pos2<>0) then Writeln(FOut,sr.name+lang(' / ')+LineCode); //nolang
         end;

      CloseFile(FIn);
//      FileClose(sr.findHandle);
      until findNext(sr)<>0;
   CloseFile(FOut);
   FindClose(sr);
end;

procedure Tpop_main.Gnrelistedepixelschauds1Click(Sender: TObject);
var
Image:tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   Image.GenerePixelsChauds;
   end;
end;

procedure Tpop_main.Prtraiterunlot1Click(Sender: TObject);
var
pop_pretraite_lot:Tpop_pretraite_lot;
pop_select_lot:Tpop_select_lot;
Directory:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
pop_pretraite_lot:=Tpop_pretraite_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
pop_pretraite_lot.Edit1.Text:=Config.ConfigPretrait.NomOffset;
pop_pretraite_lot.Edit2.Text:=Config.ConfigPretrait.NomNoir;
pop_pretraite_lot.Edit3.Text:=Config.ConfigPretrait.NomFlat;
pop_pretraite_lot.Edit4.Text:=Config.ConfigPretrait.NomCosmetiques;
pop_pretraite_lot.CheckBox1.Checked:=False;
if Config.ConfigPretrait.OptimiseNoir then pop_pretraite_lot.CheckBox1.Checked:=True;
if (pop_pretraite_lot.Showmodal=mrOK) then
   begin
   Config.ConfigPretrait.NomOffset:=pop_pretraite_lot.Edit1.Text;
   Config.ConfigPretrait.NomNoir:=pop_pretraite_lot.Edit2.Text;
   Config.ConfigPretrait.NomFlat:=pop_pretraite_lot.Edit3.Text;
   Config.ConfigPretrait.NomCosmetiques:=pop_pretraite_lot.Edit4.Text;
   Config.ConfigPretrait.OptimiseNoir:=pop_pretraite_lot.CheckBox1.Checked;
   if (pop_select_lot.Showmodal=mrOK) and
      (pop_select_lot.ListBox.Items.Count<>0) then
      begin
      Rapport:=tpop_rapport.Create(Application);
      Rapport.Show;
      try
      Directory:=pop_select_lot.DirectoryListBox1.Directory;
      ListeImg.Assign(pop_select_lot.Listbox.Items);
      VerifieLot(Directory,ListeImg,Rapport,True);
      // les fichiers traités ne sont pas forcement dans le format préferé de sauvegarde
      // Oui mais veut il utiliser les format des images ou le format qu'il dit preferer ?
//      Ext:=UpperCase(ExtractFileExt(ListeImg.Strings[0]));
//      if (Ext='.FIT') or (Ext='.FTS') or (Ext='.FITS') then config.FormatSaveInt:=0    //nolang
//      else if (Ext='.CPA') and (config.FormatSaveInt<>5) then config.FormatSaveInt:=1  //nolang
//      else if (Ext='.PIC') then config.FormatSaveInt:=2                                //nolang
//      else if (Ext='.BMP') then config.FormatSaveInt:=3                                //nolang
//      else if (Ext='.JPG') then config.FormatSaveInt:=4;                               //nolang
      PretraiteLot(Directory,ListeImg,Config.ConfigPretrait,Rapport);
      finally
      Rapport.Quitter.Enabled:=True;
      Rapport.BitBtn1.Enabled:=True;
      Rapport.BitBtn2.Enabled:=True;
      Rapport.BitBtn3.Enabled:=True;
      end;
      end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
pop_pretraite_lot.Free;
//config.FormatSaveInt:=SaveFormat;
end;
end;

procedure Tpop_main.ConnecterleServeurdheure1Click(Sender: TObject);
begin
   if not(Config.HourServerBranche) then
      begin
      HourServerConnect;
      if not(Config.HourServerBranche) then
         ShowMessage('Aucun serveur d''heure détecté');
      end
   else HourServerDisconnect;
end;

procedure Tpop_main.Dome1Click(Sender: TObject);
begin
if ToolButton8.Down then
   pop_dome.Hide
else
   begin
   pop_dome.Show;
   ToolButton8.Down:=True;
   end;
end;

procedure Tpop_main.Serveurdheure1Click(Sender: TObject);
begin
if ToolButton9.Down then
   pop_hour_server.Hide
else
   begin
   pop_hour_server.Show;
   ToolButton9.Down:=True;
   end;
end;

procedure Tpop_main.Observationrcurente1Click(Sender: TObject);
var
  pop_obs_recurrente: Tpop_obs_recurrente;
begin
   pop_obs_recurrente:=Tpop_obs_recurrente.Create(Application);
   pop_obs_recurrente.ShowModal;
end;

procedure Tpop_main.OpenDcl;
var
   F:TextFile;
   Line:string;
   PosEsp,i:Integer;
   T:TStringList;
   Path:string;
begin
   Path:=ExtractFileDir(Application.ExeName);
   T:=TStringList.Create;

   try

   if FileExists(Path+'Shift.dcl') then //nolang
      begin
      AssignFile(F,Path+'Shift.dcl'); //nolang
      Reset(F);
      try
      while not(Eof(F)) do
         begin
         Readln(F,Line);
         T.Add(Line);
         end;

      Config.NbDecalageSuivi:=T.Count;
      Getmem(Config.DecalageSuiviX,Config.NbDecalageSuivi*8);
      Getmem(Config.DecalageSuiviY,Config.NbDecalageSuivi*8);

      for i:=0 to Config.NbDecalageSuivi-1 do
         begin
         Line:=T[i];

         PosEsp:=Pos(' ',Line);
         Config.DecalageSuiviX^[i+1]:=MyStrToFloat(Copy(Line,1,PosEsp-1));
         Delete(Line,1,PosEsp);

         Config.DecalageSuiviY^[i+1]:=MyStrToFloat(Trim(Line));
         end;

      finally
      CloseFile(F);
      end;
      end;

   finally
   T.Free;
   end;
end;

procedure Tpop_main.Scripts1Click(Sender: TObject);
begin
pop_builder.show;
pop_builder.timer_script.enabled:=true;
end;

procedure Tpop_main.AcqurirTwain1Click(Sender: TObject);
begin
Twainy1.SelectSource;
Twainy1.Acquire;
end;

procedure Tpop_main.Twainy1ChangeBitmap(Sender: TObject);
var
   pop_image:tpop_image;
   Bitmap:TBitmap;
   MyBitmap:TMemoryStream;
begin
Bitmap:=Twainy1.ScannedBmp;

MyBitmap:=TMemoryStream.Create;
try
Bitmap.SaveToStream(MyBitmap);
pop_image:=tpop_image.create(application);
ConvertFromBMPStream(MyBitmap,pop_image.DataInt,pop_image.ImgInfos);

pop_image.VisuMiniMaxi(0,31);

finally
MyBitmap.Free;
MiseAJourMenu(Sender);
end;
end;

procedure Tpop_main.NouvelleImage1Click(Sender: TObject);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
begin
New(TabItems);

try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiRadioGroup;
   Msg:=lang('Type : ');
   ValeurStrDefaut:=lang('Entier|A virgule|');
   end;

with TabItems^[2] do
   begin
   TypeItem:=tiInteger;
   Msg:=lang('Nombre de plans :');
   ValeurIncrement:=1;
   ValeurDefaut:=1;
   ValeurMin:=1;
   ValeurMax:=255;
   end;

with TabItems^[3] do
   begin
   TypeItem:=tiInteger;
   Msg:=lang('Largeur :');
   ValeurIncrement:=10;
   ValeurDefaut:=256;
   ValeurMin:=10;
   ValeurMax:=65535;
   end;

with TabItems^[4] do
   begin
   TypeItem:=tiInteger;
   Msg:=lang('Hauteur :');
   ValeurIncrement:=10;
   ValeurDefaut:=256;
   ValeurMin:=10;
   ValeurMax:=65535;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.Caption:=lang('Nouvelle Image');
if DlgStandard.ShowModal=mrOK then
   begin
   pop_image:=tpop_image.create(application);

   try
   pop_image.ImgInfos.Sx:=Round(TabItems^[3].ValeurSortie);
   pop_image.ImgInfos.Sy:=Round(TabItems^[4].ValeurSortie);
   pop_image.ImgInfos.PixX:=9;
   pop_image.ImgInfos.PixY:=9;
   pop_image.ImgInfos.Focale:=1000;
   pop_image.ImgInfos.NbPlans:=Round(TabItems^[2].ValeurSortie);
   if (Round(TabItems^[1].ValeurSortie)=0) and (pop_image.ImgInfos.NbPlans<>3) then pop_image.ImgInfos.TypeData:=2;
   if (Round(TabItems^[1].ValeurSortie)=0) and (pop_image.ImgInfos.NbPlans=3) then pop_image.ImgInfos.TypeData:=7;
   if (Round(TabItems^[1].ValeurSortie)=1) and (pop_image.ImgInfos.NbPlans<>3) then pop_image.ImgInfos.TypeData:=5;
   if (Round(TabItems^[1].ValeurSortie)=1) and (pop_image.ImgInfos.NbPlans=3) then pop_image.ImgInfos.TypeData:=8;

   GetmemImg(pop_image.DataInt,pop_image.DataDouble,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy,
             pop_image.ImgInfos.TypeData,pop_image.ImgInfos.NbPlans);
   pop_image.ImgInfos.Min[1]:=0;
   pop_image.ImgInfos.Max[1]:=1000;
   pop_image.Caption:=GiveName(lang('Nouvelle Image'),pop_image);

   pop_image.AjusteFenetre;
   pop_image.visuImg;
   pop_image.ChangerMenu;

   except
   pop_image.free;
   end;
   end;

finally
DlgStandard.Free;
Dispose(TabItems);
end;
end;

procedure Tpop_main.Compositageplantaire1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and (pop_select_lot.ListBox.Items.Count<>0) then
   begin
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   Directory:=pop_select_lot.DirectoryListBox1.Directory;
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   VerifieLot(Directory,ListeImg,Rapport,True);
   RecalePlanetLot(Directory,ListeImg,Rapport,True);
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;
end;

procedure Tpop_main.Recalagedimages1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and (pop_select_lot.ListBox.Items.Count<>0) then
   begin
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   Directory:=pop_select_lot.DirectoryListBox1.Directory;
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   VerifieLot(Directory,ListeImg,Rapport,False);
   RecalePlanetLot(Directory,ListeImg,Rapport,False);
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;
end;

procedure Tpop_main.Recalagedunlot1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and (pop_select_lot.ListBox.Items.Count<>0) then
   begin
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   Directory:=pop_select_lot.DirectoryListBox1.Directory;
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   VerifieLot(Directory,ListeImg,Rapport,False);
   RecaleEtoileLot(Directory,ListeImg,Config.ConfigPretrait.ErreurRecaleImages,Rapport,True);
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;
end;

procedure Tpop_main.RecalagedimagesstellairesRVB1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and (pop_select_lot.ListBox.Items.Count<>0) then
   begin
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   Directory:=pop_select_lot.DirectoryListBox1.Directory;
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   VerifieLot(Directory,ListeImg,Rapport,False);
   RecaleEtoileLot(Directory,ListeImg,Config.ConfigPretrait.ErreurRecaleImages,Rapport,False);
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;
end;

procedure Tpop_main.Camradesuivi1Click(Sender: TObject);
begin
if ToolButton7.Down then
   pop_camera_suivi.Hide
else
   begin
   pop_camera_suivi.Show;
   ToolButton7.Down:=True;
   end;
end;

procedure Tpop_main.FormPaint(Sender: TObject);
var
   FText:TextFile;
   FileName:string;
   pop_image:Tpop_image;
begin
// Une seule fois !
if not(InitMain) then
   begin
   InitMain:=True;
   // Lectures des images ouvertes
   if FileExists('Images.lst') then //nolang
      begin
      AssignFile(FText,'Images.lst'); //nolang
      Reset(FText);
      while not(Eof(FText)) do
         begin                                
         Readln(FText,FileName);
         if FileExists(FileName) then
            begin
            pop_image:=tpop_image.create(application);

            try

            pop_image.ReadImage(FileName);
//            pop_image_index.addline(FileName,0);

            except
            on E: Exception do
               begin
               ShowMessage(E.Message);
               pop_image.free;
               end;
            end;

         end;

         end;
      CloseFile(FText);
      end;
   end;
end;

procedure Tpop_main.outFits1Click(Sender: TObject);
var
nom,n,ext:String;
Image:Tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   SaveDialog.InitialDir:=config.RepImages;
   SaveDialog.Filter:=lang('Fichiers image Fits|*.FTS;*.FIT*');
   SaveDialog.FileName:=ChangeExt(Image.Caption,'.fit'); //nolang
   if SaveDialog.Execute then
      begin
      Nom:=SaveDialog.Filename;
      if (Uppercase(ExtractFileExt(Nom))<>'.FTS') and                                                    //nolang
         (Uppercase(ExtractFileExt(Nom))<>'.FIT') and                                                    //nolang
         (Uppercase(ExtractFileExt(Nom))<>'.FITS') then Nom:=Nom+'.fit';                                 //nolang
      config.RepImages:=ExtractFilePath(Nom);
      Image.Caption:=GiveName(ExtractFileName(Nom),Image);

      case Image.ImgInfos.TypeData of
         2:SaveFITS(Nom,Image.DataInt,Image.DataDouble,1,Image.ImgInfos.NbPlans,Image.ImgInfos);
         5,6:begin
             ConvertFITSRealToInt(Image.DataDouble,Image.DataInt,Image.ImgInfos);
             Image.ChangerMenu;
             MiseAJourMenu(Sender);
             SaveFITS(Nom,Image.DataInt,Image.DataDouble,1,Image.ImgInfos.NbPlans,Image.ImgInfos);
             ConvertFITSIntToReal(Image.DataInt,Image.DataDouble,Image.ImgInfos);
             end;
         7:begin
           if config.FormatCouleur=0 then
              begin
              n:=extractfilename(nom);
              ext:=ExtractFileExt(Nom);
              SaveFITS(n+'_R'+ext,Image.DataInt,Image.DataDouble,1,1,Image.ImgInfos);  // un fichier par couleur //nolang
              SaveFITS(n+'_G'+ext,Image.DataInt,Image.DataDouble,2,1,Image.ImgInfos);                            //nolang
              SaveFITS(n+'_B'+ext,Image.DataInt,Image.DataDouble,3,1,Image.ImgInfos);                            //nolang
              end
           else
              begin
              SaveFITS(Nom,Image.DataInt,Image.DataDouble,1,3,Image.ImgInfos);   // fichier RGB
              end;
           end;
         8:begin
           ConvertFITSRealToInt(Image.DataDouble,Image.DataInt,Image.ImgInfos);
           Image.ChangerMenu;
           MiseAJourMenu(Sender);
           if config.FormatCouleur=0 then
              begin
              n:=extractfilename(nom);
              ext:=ExtractFileExt(Nom);
              SaveFITS(n+'_R'+ext,Image.DataInt,Image.DataDouble,1,1,Image.ImgInfos);  // un fichier par couleur //nolang
              SaveFITS(n+'_G'+ext,Image.DataInt,Image.DataDouble,2,1,Image.ImgInfos);                            //nolang
              SaveFITS(n+'_B'+ext,Image.DataInt,Image.DataDouble,3,1,Image.ImgInfos);                            //nolang
              end
           else
              begin
              SaveFITS(Nom,Image.DataInt,Image.DataDouble,1,3,Image.ImgInfos);   // fichier RGB
              end;
           ConvertFITSIntToReal(Image.DataInt,Image.DataDouble,Image.ImgInfos);
           end;
         end;

      end;
   end;
end;

procedure Tpop_main.Fitsvirgule1Click(Sender: TObject);
var
nom,n,ext:String;
Image:Tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   SaveDialog.InitialDir:=config.RepImages;
   SaveDialog.Filter:=lang('Fichiers image Fits|*.FTS;*.FIT*');
   SaveDialog.FileName:=ChangeExt(Image.Caption,'.fit'); //nolang
   if SaveDialog.Execute then
      begin
      Nom:=SaveDialog.Filename;
      if (Uppercase(ExtractFileExt(Nom))<>'.FTS') and                                                    //nolang
         (Uppercase(ExtractFileExt(Nom))<>'.FIT') and                                                    //nolang
         (Uppercase(ExtractFileExt(Nom))<>'.FITS') then Nom:=Nom+'.fit';                                 //nolang
      config.RepImages:=ExtractFilePath(Nom);
      Image.Caption:=GiveName(ExtractFileName(Nom),Image);

      case Image.ImgInfos.TypeData of
         2:begin
           ConvertIntToReal(Image.DataInt,Image.DataDouble,Image.ImgInfos.NbPlans,Image.ImgInfos.Sx,Image.ImgInfos.Sy);
           Image.ImgInfos.Typedata:=5;
           Image.ChangerMenu;
           MiseAJourMenu(Sender);
           SaveFITS(nom,Image.DataInt,Image.DataDouble,1,Image.ImgInfos.NbPlans,Image.ImgInfos);
           end;
         5,6:SaveFITS(nom,Image.DataInt,Image.DataDouble,1,Image.ImgInfos.NbPlans,Image.ImgInfos);
         7:begin
           ConvertIntToReal(Image.DataInt,Image.DataDouble,Image.ImgInfos.NbPlans,Image.ImgInfos.Sx,Image.ImgInfos.Sy);
           Image.ImgInfos.Typedata:=8;
           Image.ChangerMenu;
           MiseAJourMenu(Sender);
           if config.FormatCouleur=0 then
              begin
              n:=extractfilename(nom);
              ext:=ExtractFileExt(Nom);
              SaveFITS(N+'_R'+Ext,Image.DataInt,Image.DataDouble,1,1,Image.ImgInfos);  // un fichier par couleur //nolang
              SaveFITS(N+'_G'+Ext,Image.DataInt,Image.DataDouble,2,1,Image.ImgInfos);                            //nolang
              SaveFITS(N+'_B'+Ext,Image.DataInt,Image.DataDouble,3,1,Image.ImgInfos);                            //nolang
              end
           else
              begin
              SaveFITS(nom,Image.DataInt,Image.DataDouble,1,3,Image.ImgInfos);   // fichier RGB
              end
           end;
         8:begin
           if config.FormatCouleur=0 then
              begin
              N:=extractfilename(nom);
              Ext:=ExtractFileExt(Nom);
              SaveFITS(N+'_R'+Ext,Image.DataInt,Image.DataDouble,1,1,Image.ImgInfos);  // un fichier par couleur //nolang
              SaveFITS(N+'_G'+Ext,Image.DataInt,Image.DataDouble,2,1,Image.ImgInfos);                            //nolang
              SaveFITS(N+'_B'+Ext,Image.DataInt,Image.DataDouble,3,1,Image.ImgInfos);                            //nolang
              end
           else
              begin
              SaveFITS(nom,Image.DataInt,Image.DataDouble,1,3,Image.ImgInfos);   // fichier RGB
              end
           end;
         end;
      end;
   end;
end;

procedure Tpop_main.Timer2Timer(Sender: TObject);
begin
if not Config.GoodPos and Telescope.StoreCoordinates then
   begin
   Timer2.Enabled:=False;
   WriteSpy(lang('Le télescope ne veut pas donner sa position'));
   ShowMessage(lang('Le télescope ne veut pas donner sa position'));
   TelescopeErreurFatale;
   Exit;
   end;
end;

procedure Tpop_main.AfficheMessage(Titre,MyMessage:string);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
begin
New(TabItems);
try

IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiLabel;
   Msg:=MyMessage;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.HideUndo;
DlgStandard.SetFreeOnClose;
DlgStandard.SetCloseOnOK;
DlgStandard.Caption:=Titre; //nolang
DlgStandard.Show;

finally
Dispose(TabItems);
end;
end;

// Uniquement un ThreadedTimer pour ca car c'est appelle dans un sychronise !!!!
procedure Tpop_main.Imagedetest21Click(Sender: TObject);
var
   pop_image:Tpop_image;
   i,j:Integer;
   PSF:TPSF;
begin
   pop_image:=tpop_image.create(application);
   pop_image.ImgInfos.TypeData:=2;
   pop_image.ImgInfos.NbPlans:=1;
   pop_image.ImgInfos.Sx:=300;
   pop_image.ImgInfos.Sy:=pop_image.ImgInfos.Sx;
   pop_image.ImgInfos.Min[1]:=0;
   pop_image.ImgInfos.Max[1]:=2000;
   pop_image.ChangerMenu;
   GetmemImg(pop_image.DataInt,pop_image.DataDouble,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy,
      pop_image.ImgInfos.TypeData,pop_image.ImgInfos.NbPlans);

   for i:=1 to pop_image.ImgInfos.Sx do
      for j:=1 to pop_image.ImgInfos.Sy do
         pop_image.DataInt^[1]^[j]^[i]:=0;


   PSF.SigmaX:=2;
   PSF.SigmaY:=2;
   PSF.IntensiteMax:=16000;
   PSF.Angle:=0;
   AddStar(pop_image.DataInt,pop_image.DataDouble,2,300,300,PSF,100,100);
   AddStar(pop_image.DataInt,pop_image.DataDouble,2,300,300,PSF,100,200);   

   pop_image.AjusteFenetre;
   pop_image.visuImg;
   pop_image.ChangerMenu;
   SeuilsEnable;
end;

constructor TThreadGetPos.Create;
begin
inherited Create(True);
Priority:=tpNormal;
//Priority:=tpLower;
FreeOnTerminate:=True;
Resume;
end;

procedure TThreadGetPos.AfficheInfos;
var
   i:integer;
//   FThreadID:Longword;
begin
// FTHreadID:=GetCurrentThreadID;
// ShowMessage('ThreadedTimer1Timer : '+IntToHex(GetCurrentThreadID,4));

try
if (Config.TelescopeBranche) and Telescope.StoreCoordinates and not StopGetPos
   and not Config.InPopConf and (pop_scope<>nil) then //Pas de serveur d'heure
      begin
//      WriteSpy('Test');
      pop_scope.PnlAlpha.Caption:=AlphaStr;
      pop_scope.PnlDelta.Caption:=DeltaStr;
      pop_scope.Lst.Caption:=LstStr;
      pop_scope.HourAngle.Caption:=HAStr;
      pop_scope.PanelAirMass.Caption:=AirMassStr;
      pop_scope.Panel1.Caption:=AzimuthStr;
      pop_scope.Panel2.Caption:=HauteurStr;

      for i:=pop_main.MDIChildCount-1 downto 0 do
         if pop_main.MDIChildren[i] is TPop_SkyChart then
            begin
            (pop_main.MDIChildren[i] as TPop_SkyChart).DrawScope(Config.AlphaScope,Config.DeltaScope);
            end;

      end;
except
end;
end;

procedure TThreadGetPos.Execute;
var
   Local,LstNum:TDateTime;
   HA:double;
   Azimuth,Hauteur:Double; 
begin
try
while not Terminated do
   begin
   WaitForSingleObject(pop_main.HTimerGetPosEvent,INFINITE);
   if (Config.TelescopeBranche) and Telescope.StoreCoordinates and not StopGetPos then
      if not Config.InPopConf then //Pas de serveur d'heure
         if not(Telescope.IsBusy) then //Priorite au reste !
            begin
            Config.GoodPos:=Telescope.GetPos(Config.AlphaScope,Config.DeltaScope);
            if Config.GoodPos then
               begin
               // Alpha et Delta
               AlphaStr:=AlphaToStr(Config.AlphaScope);
               DeltaStr:=DeltaToStr(Config.DeltaScope);

               //Temps sidéral local
               Local:=GetHourDT;
               LstNum:=LocalSidTim(Local,Config.Long)/15;
               if LstNum>24 then LstNum:=LstNum-24;
               LstStr:=AlphaToStr(LstNum);

               // angle horaire
               HA:=GetHourAngle(GetHourDT,Config.AlphaScope,Config.Long)/15; //Degres -> heure
               if HA < 0 then
                  HAStr:='- '+AlphaToStr(Abs(HA)) //nolang
               else
                  HAStr:='+ '+AlphaToStr(Abs(HA)); //nolang

               // Masse d'air
               AirMassStr:=MyFloatToStr(AirMass(Config.DeltaScope,HA),1);

               //Azimuth et Hauteur
               HA:=HA*15;
               while HA>=360 do HA:=HA-360;
               while HA<0 do HA:=HA+360;
               GetHorFromAlphaDelta(HA,Config.DeltaScope,Config.Lat,Azimuth,Hauteur);
               Config.AzimuthScope:=Azimuth;
               Config.ScopeHauteur:=Hauteur;
               AzimuthStr:=DeltaToStr(Azimuth);
               HauteurStr:=DeltaToStr(Hauteur);
               end;
            end;

   Synchronize(AfficheInfos);
   end;
except
end;
end;

function Tpop_main.OpenImage(var pop_image:tpop_image):Boolean;
var
   i:Integer;
   Ext:string;
begin
Result:=True;
OpenDialog.Filter:=lang('Fichiers image Pic Cpa Fits Bmp Jpeg|*.pic;*.cpa;*.fit*;*.fits;*.fts;*.bmp;*.jpg;*.jpeg'+
                        lang('|Fichiers image Fits|*.fit*;*.fits')+
                        lang('|Fichiers image Cpa|*.cpa*')+
                        lang('|Fichiers image Pic|*.pic*')+
                        lang('|Fichiers image Bmp|*.bmp*')+
                        lang('|Fichiers image Jpeg|*.jpg*;*.jpeg'));
OpenDialog.InitialDir:=Config.RepImages;
OpenDialog.Options:=[ofHideReadOnly,ofAllowMultiSelect];
if OpenDialog.Execute then
   begin
   Config.RepImages:=ExtractFilePath(Opendialog.Files[0]);
   Ext:=UpperCase(ExtractFileExt(opendialog.Files[0]));
   for i:=0 to Opendialog.Files.Count-1 do
      begin
      pop_image:=tpop_image.create(application);
      try
      if (Ext='.FIT') or (Ext='.FTS') or (Ext='.FITS') or (Ext='.CPA') or (Ext='.PIC') //nolang
         or (Ext='.BMP') or (Ext='.JPG') then //nolang
            if FileExists(OpenDialog.Files[i]) then
               begin
               pop_image.ReadImage(opendialog.Files[i]);
               pop_image_index.addline(opendialog.Files[i],0);
               end;
      except
      on E: Exception do
         begin
         Result:=False;
         pop_image.free;
         end;
      end;
      end;
   end;
MiseAJourMenu(Self);
end;

{procedure Tpop_main.ThreadedTimer1Timer(Sender: TObject);
var
   i:integer;
   Local,LstNum:tdatetime;
   HA:double;
   FThreadID:Longword;
begin
// FTHreadID:=GetCurrentThreadID;
// ShowMessage('ThreadedTimer1Timer : '+IntToHex(GetCurrentThreadID,4));

try
if (Config.TelescopeBranche) and Telescope.StoreCoordinates and not StopGetPos
   and not Config.InPopConf and (pop_scope<>nil) then //Pas de serveur d'heure
      begin
      pop_scope.PnlAlpha.Caption:=AlphaToStr(Config.AlphaScope);
      pop_scope.PnlDelta.Caption:=DeltaToStr(Config.DeltaScope);

      // LST
      Local:=GetHourDT;
      LstNum:=SidTim(Local,Config.Long)/15;
      if LstNum > 24 then LstNum := LstNum-24;
      pop_scope.Lst.Caption:=AlphaToStr(LstNum);
      // angle horaire
      HA:=0;
      if pop_scope.PnlAlpha.Caption<>'' then
         begin
         HA:=GetAngleHoraire(GetHourDT,StrToAlpha(pop_scope.PnlAlpha.Caption),Config.Long)/15; //Degres -> heure
         if HA < 0 then
            pop_scope.HourAngle.Caption:='- '+AlphaToStr(Abs(HA)) //nolnag
         else
            pop_scope.HourAngle.Caption:='+ '+AlphaToStr(Abs(HA)); //nolang
         end;
      // Masse d'air
      pop_scope.AirMass.Caption:=MyFloatToStr(Air_Mass(Config.DeltaScope,HA),1);

      for i:=MDIChildCount-1 downto 0 do
         if MDIChildren[i] is TPop_SkyChart then
            begin
            (MDIChildren[i] as TPop_SkyChart).DrawScope(Config.AlphaScope,Config.DeltaScope);
            end;

      end;
except
end;
end;}

procedure Tpop_main.TimerGetPosTimer(Sender: TObject);
begin
{if InTimer then Exit;
InTimer:=True;
try
if (Config.TelescopeBranche) and Telescope.StoreCoordinates and not StopGetPos then
   if not Config.InPopConf then //Pas de serveur d'heure
      if not(Telescope.IsBusy) then //Priorite au reste !
         begin
         // On ferme si il y a eu un probleme
//         if not Config.TelescopeBranche then pop_Main.UpDateGUITelescope;

         Config.GoodPos:=Telescope.GetPos(Config.AlphaScope,Config.DeltaScope);
         // C'est pas critique si ça merde un peu
//            WriteSpy(lang('Le télescope ne veut pas donner sa position'));
         end;
finally
InTimer:=False;
end;}
if Config.Periodic then SetEvent(HTimerGetPosEvent);
end;

procedure Tpop_main.Ouvrirgraphe1Click(Sender: TObject);
var
   Graphe:TPop_Graphe;
   i,j,PosEsp:Integer;
   Ext,Line:string;
   Serie:TTASerie;
   FText:TextFile;
   X,Y:Double;
   Color:TColor;
begin
Randomize;
OpenDialog.Filter:=lang('Fichiers texte *.txt|*.txt');
OpenDialog.InitialDir:=Config.RepImages;
OpenDialog.Options:=[ofHideReadOnly,ofAllowMultiSelect];
if OpenDialog.Execute then
   begin
   Config.RepImages:=ExtractFilePath(Opendialog.Files[0]);
   Ext:=UpperCase(ExtractFileExt(Opendialog.Files[0]));
   for i:=0 to Opendialog.Files.Count-1 do
      begin
      Graphe:=TPop_Graphe.Create(Application);
      try
      if (Ext='.TXT') then //nolang
         if FileExists(OpenDialog.Files[i]) then
            begin
            Graphe:=TPop_Graphe.Create(Application);
            Graphe.Show;

            Serie:=TTASerie.Create(Application);
            Graphe.TAChart1.Title:=OpenDialog.Files[i];
            Graphe.TAChart1.AddSerie(Serie);

            AssignFile(FText,OpenDialog.Files[i]);
            Reset(FText);
            j:=1;
            Color:=(Random(255) or (Random(255) shl 8) or (Random(255) shl 16));
            while not(Eof(FText)) do
               begin
               Readln(FText,Line);
               Line:=Trim(Line);
               if Line <>'' then
                  begin
                  PosEsp:=Pos(' ',Line);
                  if PosEsp=0 then
                     begin
                     Serie.AddXY(j,MyStrToFloat(Trim(Line)),Color);
                     Application.ProcessMessages;
                     end
                  else
                     begin
                     X:=MyStrToFloat(Copy(Line,1,PosEsp-1));
                     Delete(Line,1,PosEsp);
                     Y:=MyStrToFloat(Trim(Line));
                     Serie.AddXY(X,Y,clBlack);
                     Application.ProcessMessages;
                     end;
                  end;
               inc(j);
               end;

            CloseFile(FText);
            end;
      except
      on E: Exception do
         begin
         ShowMessage(E.Message);
         Graphe.free;
         end;
      end;
      end;
   end;
end;

procedure Tpop_main.LangTestersurunfichier1Click(Sender: TObject);
begin
CreerDicoTest('test.pas'); //nolang
end;

procedure Tpop_main.LangTesterlamisejourdessourcessurunfichier1Click(
  Sender: TObject);
begin
ModifSourcesTest('Test.pas'); //nolang
end;

procedure Tpop_main.LangEnleverlesaccents1Click(Sender: TObject);
var
   Liste:TStringList;
   Path,Msg,Gauche,Droite:string;
   i:Integer;
   Pos1,Pos2,Pos3,Pos4,Pos5,Pos6:Integer;
begin
Path:=LowerCase(ExtractFilePath(Application.ExeName));

OpenDialog.Filter:='Fichiers langue *.lng|*.lng'; //nolang
OpenDialog.InitialDir:=Config.RepImages;
if OpenDialog.Execute then
   begin
   Liste:=TStringList.Create;
   try

   Liste.LoadFromFile(OpenDialog.FileName); //nolang

   for i:=0 to Liste.Count-1 do
      begin
      Msg:=Liste[i];
      SplitLangLine(Msg,Gauche,Droite);


      Pos1:=Pos('é',Gauche);
      Pos2:=Pos('è',Gauche);
      Pos3:=Pos('à',Gauche);
      Pos4:=Pos('ç',Gauche);
      Pos5:=Pos('ê',Gauche);
      Pos6:=Pos('ù',Gauche);

      // On recommence sans les accents
      if Pos1+Pos2+Pos3+Pos4+Pos5+Pos6<>0 then
         begin
         if Pos1<>0 then Gauche[Pos1]:='e';
         if Pos2<>0 then Gauche[Pos2]:='e';
         if Pos3<>0 then Gauche[Pos3]:='a';
         if Pos4<>0 then Gauche[Pos4]:='c';
         if Pos5<>0 then Gauche[Pos5]:='e';
         if Pos6<>0 then Gauche[Pos6]:='u';

         Liste[i]:=''''+Gauche+'''='''+Droite+'''';  //nolang
         end;
      end;

   Liste.SaveToFile(Path+'\Tmp.lng'); //nolang

   finally
   Liste.Free;
   end;
   end;
end;

procedure Tpop_main.AdobePSD1Click(Sender: TObject);
var
   nom:string;
   Image:Tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   SaveDialog.InitialDir:=config.RepImages;
   SaveDialog.Filter:=lang('Fichiers image Psd|*.PSD');
   SaveDialog.FileName:=ChangeExt(Image.Caption,'.psd'); //nolang
   if SaveDialog.Execute then
      begin
      Nom:=SaveDialog.Filename;
      if Uppercase(ExtractFileExt(Nom))<>'.PSD' then Nom:=Nom+'.psd'; //nolang
      config.RepImages:=ExtractFilePath(Nom);
      Image.Caption:=GiveName(ExtractFileName(Nom),Image);
      if messagebox(0,Pchar(lang('Enregistrer avec ordre MSB ?')),
         Pchar(lang('Confirmation')),MB_YESNO)=IDYES then
       SavePSD(Nom,Image.DataInt,Image.ImgInfos,true)
      else
       SavePSD(Nom,Image.DataInt,Image.ImgInfos,false);
      end;
   end;
end;

procedure Tpop_main.Bmp1Click(Sender: TObject);
var
   Nom:string;
   Image:Tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   SaveDialog.InitialDir:=config.RepImages;
   SaveDialog.Filter:=lang('Fichiers Image BMP|*.BMP');
   if SaveDialog.Execute then
      begin
      Image:=ActiveMDIChild as Tpop_Image;
      Nom:=SaveDialog.Filename;
      if Uppercase(ExtractFileExt(Nom))<>'.BMP' then Nom:=Nom+'.bmp'; //nolang
      config.RepImages:=ExtractFilePath(Nom);
      Image.Caption:=GiveName(ExtractFileName(Nom),Image);
      SaveBMPHandle(Nom,Image.DataInt,Image.DataDouble,Image.ImgInfos,Image.Img_Box.Picture.Bitmap.Handle);
      Image.VisuImg;
      end;
   end;
end;

procedure Tpop_main.jpeg1Click(Sender: TObject);
var
   Nom:string;
   Image:Tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   SaveDialog.InitialDir:=config.RepImages;
   SaveDialog.Filter:=lang('Fichiers image Jpeg|*.JPEG;*.JPG');
   if SaveDialog.Execute then
      begin
      Image:=ActiveMDIChild as Tpop_Image;
      Nom:=SaveDialog.Filename;
      if (Uppercase(ExtractFileExt(Nom))<>'.JPG') and (Uppercase(ExtractFileExt(Nom))<>'.JEPG') then Nom:=Nom+'.jpg'; //nolang
      config.RepImages:=ExtractFilePath(Nom);
      Image.Caption:=GiveName(ExtractFileName(Nom),Image);
      SaveJPGHandle(Nom,Image.DataInt,Image.DataDouble,Image.ImgInfos,Image.Img_box.Picture.Bitmap.Handle);
      Image.VisuImg;
      end;
   end;
end;

procedure Tpop_main.LangCompleteravecunanciendico1Click(Sender: TObject);
var
   NewDico,OldDico:string;
   Path:String;
begin
NewDico:='';
OldDico:='';
Opendialog.Title:='Nouveau dico'; //nolang
Opendialog.Filter:=lang('Fichiers lng|*.lng'); //nolang
Path:=ExtractFilePath(Application.ExeName);
Opendialog.Initialdir:=Path;
if Opendialog.Execute then NewDico:=OpenDialog.FileName;

Opendialog.Title:='Ancien dico'; //nolang
Opendialog.Filter:=lang('Fichiers lng|*.lng'); //nolang
Path:=ExtractFilePath(Application.ExeName);
Opendialog.Initialdir:=Path+'lng'; //nolang
if Opendialog.Execute then OldDico:=OpenDialog.FileName;

if (NewDico<>'') and (OldDico<>'') then UpdateWithOldDico(NewDico,OldDico);
end;

procedure Tpop_main.ToolButton1Click(Sender: TObject);
var
pop_image:tpop_image;
i:Integer;
Ext:string;
begin
OpenDialog.Filter:=lang('Fichiers image Pic Cpa Fits Bmp Jpeg Apn|*.pic;*.cpa;*.fit*;*.fits;*.fts;*.bmp;*.jpg;*.jpeg;*.crw;*.nef'+
                        lang('|Fichiers image Fits|*.fit*;*.fits')+
                        lang('|Fichiers image Cpa|*.cpa*')+
                        lang('|Fichiers image Pic|*.pic*')+
                        lang('|Fichiers image Bmp|*.bmp*')+
                        lang('|Fichiers image Jpeg|*.jpg* ')+
                        lang('|Photo numérique (données RGB)|*.crw;*.nef') +
                        lang('|Photo numérique (données brutes)|*.crw;*.nef;*.pef;*.cr2;*.mrw;*.raf;*.orf;*.thm;*.x3f'));
//                        lang('|toutes|*.*'));
OpenDialog.InitialDir:=Config.RepImages;
OpenDialog.Options:=[ofHideReadOnly,ofAllowMultiSelect];
if OpenDialog.Execute then
   begin
   Config.RepImages:=ExtractFilePath(Opendialog.Files[0]);
   Ext:=UpperCase(ExtractFileExt(opendialog.Files[0]));
   for i:=0 to Opendialog.Files.Count-1 do
      begin
      try
          if FileExists(OpenDialog.Files[i]) then
             begin
              pop_image:=tpop_image.create(application);
              pop_image.Width:=32;
              pop_image.Height:=16;
              screen.Cursor:=crHourGlass;
              pop_main.StatusBar1.Panels.Items[1].Text:=lang('Chargement en cours...');
              application.ProcessMessages;
              if (opendialog.FilterIndex = 8) then
               pop_image.ImgInfos.RawCfa:=true
              else
               pop_image.ImgInfos.RawCfa:=false;
              pop_image.ReadImage(opendialog.Files[i]);
              pop_image_index.addline(opendialog.Files[i],0);
              pop_main.StatusBar1.Panels.Items[1].Text:='';
              screen.Cursor:=crDefault;
            end;
      except
      on E: Exception do
         begin
         pop_main.StatusBar1.Panels.Items[1].Text:='';
         screen.Cursor:=crDefault;
         ShowMessage(E.Message);
         pop_image.free;
         end;
      end;
      end;
   end;
MiseAJourMenu(Sender);
end;

procedure Tpop_main.ToolButton2Click(Sender: TObject);
var
nom:string;
Image:Tpop_image;
begin
Image:=ActiveMDIChild as Tpop_Image;
if Image is Tpop_image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   SaveDialog.FileName:=Image.Caption;
   SaveDialog.InitialDir:=config.RepImages;
   case Image.ImgInfos.TypeData of
      2:case config.FormatSaveInt of
           0  :begin
               SaveDialog.Filter:=lang('Fichiers image Fits|*.FIT*;*.FTS');
               SaveDialog.FileName:=ChangeExt(Image.Caption,'.fit'); //nolang
               end;
           1,5:begin
               SaveDialog.Filter:=lang('Fichiers image Cpa|*.CPA');
               SaveDialog.FileName:=ChangeExt(Image.Caption,'.cpa'); //nolang
               end;
           2  :begin
               SaveDialog.Filter:=lang('Fichiers image Pic|*.PIC');
               SaveDialog.FileName:=ChangeExt(Image.Caption,'.pic'); //nolang
               end;
           3  :begin
               SaveDialog.Filter:=lang('Fichiers image Bmp|*.BMP');
               SaveDialog.FileName:=ChangeExt(Image.Caption,'.bmp'); //nolang
               end;
           4  :begin
               SaveDialog.Filter:=lang('Fichiers image Jpeg|*.JPG;*.JPEG');
               SaveDialog.FileName:=ChangeExt(Image.Caption,'.jpg'); //nolang
               end;
           end;
      5,6:case config.FormatSaveInt of
           0      :begin
                   SaveDialog.Filter:=lang('Fichiers image Fits|*.FIT*;*.FTS');
                   SaveDialog.FileName:=ChangeExt(Image.Caption,'.fit'); //nolang
                   end;
           1,2,3,5:begin
                   SaveDialog.Filter:=lang('Fichiers image Bmp|*.BMP');
                   SaveDialog.FileName:=ChangeExt(Image.Caption,'.bmp'); //nolang
                   end;
           4      :begin
                   SaveDialog.Filter:=lang('Fichiers image Jpeg|*.JPG;*.JPEG');
                   SaveDialog.FileName:=ChangeExt(Image.Caption,'.jpg'); //nolang
                   end;
           end;
      7,8:case config.FormatSaveInt of
           0  :begin
               SaveDialog.Filter:=lang('Fichiers image Fits|*.FIT*;*.FTS');
               SaveDialog.FileName:=ChangeExt(Image.Caption,'.fit'); //nolang
               end;
           1,5:begin
               SaveDialog.Filter:=lang('Fichiers image Cpa|*.CPA');
               SaveDialog.FileName:=ChangeExt(Image.Caption,'.cpa'); //nolang
               end;
           2,3:begin
               SaveDialog.Filter:=lang('Fichiers image Bmp|*.BMP');
               SaveDialog.FileName:=ChangeExt(Image.Caption,'.bmp'); //nolang
               end;
           4  :begin
               SaveDialog.Filter:=lang('Fichiers image Jpeg|*.JPG;*.JPEG');
               SaveDialog.FileName:=ChangeExt(Image.Caption,'.jpg'); //nolang
               end;
           end;
      end;
   if SaveDialog.Execute then
      begin
      Nom:=SaveDialog.Filename;
      config.RepImages:=ExtractFilePath(Nom);
      Image.Caption:=GiveName(ExtractFileName(Nom),Image);
      SaveImageGenerique(Nom,Image.DataInt,Image.DataDouble,Image.ImgInfos);
      end;
   end;
end;

procedure Tpop_main.ToolButton4Click(Sender: TObject);
begin
if pop_scope.Visible then pop_scope.Hide else pop_scope.Show;
end;

procedure Tpop_main.ToolButton5Click(Sender: TObject);
begin
if pop_map.Visible then pop_map.Hide else pop_map.Show;
end;

procedure Tpop_main.ToolButton6Click(Sender: TObject);
begin
if pop_camera.Visible then pop_camera.Hide else pop_camera.Show;
end;

procedure Tpop_main.ToolButton7Click(Sender: TObject);
begin
if pop_camera_suivi.Visible then pop_camera_suivi.Hide else pop_camera_suivi.Show;
end;

procedure Tpop_main.ToolButton8Click(Sender: TObject);
begin
if pop_dome.Visible then pop_dome.Hide else pop_dome.Show;
end;

procedure Tpop_main.ToolButton9Click(Sender: TObject);
begin
if pop_hour_server.Visible then pop_hour_server.Hide else pop_hour_server.Show;
end;

procedure Tpop_main.ToolButton11Click(Sender: TObject);
const clair = $006060ff;
      moyen = $004040e0;
      fonce = $00000080;
      elem : array[0..24] of integer = (COLOR_BACKGROUND,COLOR_BTNFACE,COLOR_ACTIVEBORDER,COLOR_ACTIVECAPTION,COLOR_BTNTEXT,COLOR_CAPTIONTEXT,COLOR_HIGHLIGHT,COLOR_BTNHIGHLIGHT,COLOR_HIGHLIGHTTEXT,COLOR_INACTIVECAPTION,COLOR_APPWORKSPACE,COLOR_INACTIVECAPTIONTEXT,COLOR_INFOBK,COLOR_INFOTEXT,COLOR_MENU,COLOR_MENUTEXT,COLOR_SCROLLBAR,COLOR_WINDOW,COLOR_WINDOWTEXT,COLOR_WINDOWFRAME,COLOR_3DDKSHADOW,COLOR_3DLIGHT,COLOR_BTNSHADOW,COLOR_CAPTIONTEXT,COLOR_GRAYTEXT);
      rgb  : array[0..24] of Tcolor =  (clBlack         ,fonce        ,fonce             ,clblack            ,clBlack      ,moyen            ,fonce          ,fonce             ,clair              ,clBlack              ,clBlack           ,fonce                    ,clBlack     ,moyen         ,clBlack   ,moyen         ,clBlack        ,clBlack     ,moyen           ,clBlack          ,clBlack         ,moyen        ,clBlack        ,fonce            ,fonce         );
begin
config.nightvision:= not config.nightvision;
try
screen.cursor:=crHourGlass;
if config.nightvision then begin
   SaveWinColor;
   setsyscolors(25,elem,rgb);
   StatusBar1.Color:=fonce;   // celle la aussi
   ToolButton11.Hint:=lang('Passage en couleur jour');
end else begin
   ResetWinColor;
   StatusBar1.Color:=clBtnFace;
   ToolButton11.Hint:=lang('Passage en couleur nuit');
end;
finally
screen.cursor:=crDefault;
end;
end;

procedure Tpop_main.ToolButton14Click(Sender: TObject);
begin
pop_builder.show;
pop_builder.timer_script.enabled:=true;
end;

procedure Tpop_main.ToolButton18Click(Sender: TObject);
begin
if ActiveMDIChild is Tpop_Image then
   (ActiveMDIChild as Tpop_Image).RestaureUndo;
end;

procedure Tpop_main.ToolButton20Click(Sender: TObject);
var
   Image:tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   Image.ZoomAvant1Click(Sender);
   end;
end;

procedure Tpop_main.ToolButton21Click(Sender: TObject);
var
   Image:tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   Image.ZoomArrire1Click(Sender);
   end;
end;

procedure Tpop_main.ToolButton22Click(Sender: TObject);
var
   Image:tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   Image.Rglerlesseuils1Click(Sender);
   end;
end;

procedure Tpop_main.ToolButton24Click(Sender: TObject);
var
   Image:tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   Image.Fenttrage1Click(Sender);
   end;
end;

procedure Tpop_main.ToolButton25Click(Sender: TObject);
var
   Image:tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   Image.Rotation901Click(Sender);
   end;
end;

procedure Tpop_main.ToolButton26Click(Sender: TObject);
var
   Image:tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   Image.MiroirHorizontal1Click(Sender);
   end;
end;

procedure Tpop_main.ToolButton27Click(Sender: TObject);
var
   Image:tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   Image.MiroirVertical1Click(Sender);
   end;
end;

procedure Tpop_main.ToolButton29Click(Sender: TObject);
var
   Image:tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   Image.MasqueFlou1Click(Sender);
   end;
end;

procedure Tpop_main.ToolButton30Click(Sender: TObject);
var
   Image:tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   Image.Log1Click(Sender);
   end;
end;

procedure Tpop_main.ToolButton32Click(Sender: TObject);
var
   Image:tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   Image.Statistiques1Click(Sender);
   end;
end;

procedure Tpop_main.ToolButton33Click(Sender: TObject);
var
   Image:tpop_image;
begin
if ActiveMDIChild is Tpop_Image then
   begin
   Image:=ActiveMDIChild as Tpop_Image;
   Image.Informations1Click(Sender);;
   end;
end;

procedure Tpop_main.ToolButton35Click(Sender: TObject);
var
   FormConf:Tpop_conf;
begin
FormConf:=Tpop_conf.Create(Application);

// Pas moyen de faire autrement !
FormConf.NameOfTabToDisplay:=lang('Photométrie');
FormConf.Showmodal;
end;

procedure Tpop_main.ToolButton36Click(Sender: TObject);
var
   SkyChart:tpop_SkyChart;
begin
if ActiveMDIChild is Tpop_SkyChart then
   begin
   SkyChart:=ActiveMDIChild as Tpop_SkyChart;
   if SkyChart.SkyChart1.ChartPosition.FOV<180 then
      SkyChart.SkyChart1.ChartPosition.FOV:=SkyChart.SkyChart1.ChartPosition.FOV*2
   else
      SkyChart.SkyChart1.ChartPosition.FOV:=360;
   SkyChart.SkyChart1.Draw;
   end;
end;

procedure Tpop_main.ToolButton37Click(Sender: TObject);
var
   SkyChart:tpop_SkyChart;
begin
if ActiveMDIChild is Tpop_SkyChart then
   begin
   SkyChart:=ActiveMDIChild as Tpop_SkyChart;
   SkyChart.SkyChart1.ChartPosition.FOV:=SkyChart.SkyChart1.ChartPosition.FOV/2;
   SkyChart.SkyChart1.Draw;
   end;
end;

procedure Tpop_main.ToolButton38Click(Sender: TObject);
var
   SkyChart:tpop_SkyChart;
   AlphaNew,DeltaNew:Double;
begin
if ActiveMDIChild is Tpop_SkyChart then
   begin
   SkyChart:=ActiveMDIChild as Tpop_SkyChart;
   SkyChart.SkyChart1.Projection1(SkyChart.SkyChart1.Width div 2,
      SkyChart.SkyChart1.Height div 2+SkyChart.Signe*SkyChart.SkyChart1.Height div 8,AlphaNew,DeltaNew);
   if AlphaNew>24 then AlphaNew:=AlphaNew-24;
   if AlphaNew<0 then AlphaNew:=AlphaNew+24;
   SkyChart.Skychart1.ChartPosition.ra:=AlphaNew;
   SkyChart.Skychart1.ChartPosition.dec:=DeltaNew;
   SkyChart.Statusbar1.Panels[0].Text:=AlphaToStr(AlphaNew)+' '+DeltaToStr(DeltaNew);
   SkyChart.SkyChart1.Draw;
   end;
end;

procedure Tpop_main.ToolButton39Click(Sender: TObject);
var
   SkyChart:tpop_SkyChart;
   Alpha,Delta:Double;
begin
if ActiveMDIChild is Tpop_SkyChart then
   begin
   SkyChart:=ActiveMDIChild as Tpop_SkyChart;
   SkyChart.SkyChart1.Projection1(SkyChart.SkyChart1.Width div 2,SkyChart.SkyChart1.Height div 2-SkyChart.SkyChart1.Height div 8,Alpha,Delta);
   if Alpha>24 then Alpha:=Alpha-24;
   if Alpha<0 then Alpha:=Alpha+24;
   SkyChart.Skychart1.ChartPosition.ra:=Alpha;
   SkyChart.Skychart1.ChartPosition.dec:=Delta;
   SkyChart.Statusbar1.Panels[0].Text:=AlphaToStr(Alpha)+' '+DeltaToStr(Delta);
   SkyChart.SkyChart1.Draw;
   end;
end;

procedure Tpop_main.ToolButton41Click(Sender: TObject);
var
   SkyChart:tpop_SkyChart;
   Alpha,Delta:Double;
begin
if ActiveMDIChild is Tpop_SkyChart then
   begin
   SkyChart:=ActiveMDIChild as Tpop_SkyChart;
   SkyChart.SkyChart1.Projection1(SkyChart.SkyChart1.Width div 2+SkyChart.SkyChart1.Width div 8,SkyChart.SkyChart1.Height div 2,Alpha,Delta);
   if Alpha>24 then Alpha:=Alpha-24;
   if Alpha<0 then Alpha:=Alpha+24;
   SkyChart.Skychart1.ChartPosition.ra:=Alpha;
   SkyChart.Skychart1.ChartPosition.dec:=Delta;
   SkyChart.Statusbar1.Panels[0].Text:=AlphaToStr(Alpha)+' '+DeltaToStr(Delta);
   SkyChart.SkyChart1.Draw;
   end;
end;

procedure Tpop_main.ToolButton40Click(Sender: TObject);
var
   SkyChart:tpop_SkyChart;
   Alpha,Delta:Double;
begin
if ActiveMDIChild is Tpop_SkyChart then
   begin
   SkyChart:=ActiveMDIChild as Tpop_SkyChart;
   SkyChart.SkyChart1.Projection1(SkyChart.SkyChart1.Width div 2-SkyChart.SkyChart1.Width div 8,SkyChart.SkyChart1.Height div 2,Alpha,Delta);
   if Alpha>24 then Alpha:=Alpha-24;
   if Alpha<0 then Alpha:=Alpha+24;
   SkyChart.Skychart1.ChartPosition.ra:=Alpha;
   SkyChart.Skychart1.ChartPosition.dec:=Delta;
   SkyChart.Statusbar1.Panels[0].Text:=AlphaToStr(Alpha)+' '+DeltaToStr(Delta);
   SkyChart.SkyChart1.Draw;
   end;
end;

procedure Tpop_main.ToolButton42Click(Sender: TObject);
var
   SkyChart:tpop_SkyChart;
   Alpha,Delta:Double;
begin
if ActiveMDIChild is Tpop_SkyChart then
   begin
   SkyChart:=ActiveMDIChild as Tpop_SkyChart;
   Alpha:=StrToAlpha(pop_scope.PnlAlpha.Caption);
   Delta:=StrToDelta(pop_scope.PnlDelta.Caption);
   SkyChart.Skychart1.ChartPosition.ra:=Alpha;
   SkyChart.Skychart1.ChartPosition.dec:=Delta;
   SkyChart.SkyChart1.Draw;
   end;
end;

procedure Tpop_main.ToolButton43Click(Sender: TObject);
var
   SkyChart:tpop_SkyChart;
   Txt:string;
   Alpha,Delta:double;
begin
if ActiveMDIChild is Tpop_SkyChart then
   begin
   SkyChart:=ActiveMDIChild as Tpop_SkyChart;
   if MyInputQuery(lang('Centrer la carte sur :'),
       lang('Nom de l''objet (vega,M31,...) :'),Txt) then
      begin
      if not NameToAlphaDelta(Txt,Alpha,Delta) then
         begin
         ShowMessage(lang('Objet Inconnu'));
         Exit;
         end
      else
         begin
         Skychart.Skychart1.ChartPosition.Ra:=Alpha;
         Skychart.Skychart1.ChartPosition.Dec:=Delta;
         end;
      end;
   Skychart.Skychart1.Draw;
   end;
end;

procedure Tpop_main.Registration1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and (pop_select_lot.ListBox.Items.Count<>0) then
   begin
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   Directory:=pop_select_lot.DirectoryListBox1.Directory;
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   VerifieLot(Directory,ListeImg,Rapport,False);
   RegistrationEtoileLot(Directory,ListeImg,Config.ConfigPretrait.ErreurRecaleImages,Rapport,True);
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;
end;

procedure Tpop_main.Registrationdimagesstellaires1Click(Sender: TObject);
var
pop_select_lot:Tpop_select_lot;
Directory:string;
ListeImg:TStringList;
Rapport:tpop_rapport;
begin
pop_select_lot:=Tpop_select_lot.Create(Application);
ListeImg:=TStringList.Create;
try
pop_select_lot.CacheRef;
if (pop_select_lot.Showmodal=mrOK) and (pop_select_lot.ListBox.Items.Count<>0) then
   begin
   Rapport:=tpop_rapport.Create(Application);
   Rapport.Show;
   try
   Directory:=pop_select_lot.DirectoryListBox1.Directory;
   ListeImg.Assign(pop_select_lot.Listbox.Items);
   VerifieLot(Directory,ListeImg,Rapport,False);
   RegistrationEtoileLot(Directory,ListeImg,Config.ConfigPretrait.ErreurRecaleImages,Rapport,False);
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;
   end;
   end;
finally
ListeImg.Free;
pop_select_lot.Free;
end;
end;

end.


