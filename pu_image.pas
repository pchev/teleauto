unit pu_image;

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
  ExtCtrls, Math, u_class, Menus, u_filtrage, u_math, u_arithmetique, u_general,
  pu_dlg_standard, pu_filtre, StdCtrls, pu_profil2, TAGraph, ImgList,
  ComCtrls, pu_rapport, Buttons;

type
  Tpop_image = class(TForm)
    MainMenu1: TMainMenu;
    Filtres1: TMenuItem;
    ExtraitOndelette1: TMenuItem;
    Aritmthique1: TMenuItem;
    Ajouterconstante1: TMenuItem;
    Multiplierconstante1: TMenuItem;
    N1: TMenuItem;
    AjouterImage1: TMenuItem;
    SoustraireImage1: TMenuItem;
    Muli1: TMenuItem;
    DiviserImage1: TMenuItem;
    img_box: TImage;
    PopupMenu1: TPopupMenu;
    Analyse1: TMenuItem;
    Photomtrie1: TMenuItem;
    Etalonnage1: TMenuItem;
    Mesure1: TMenuItem;
    Gomtrie1: TMenuItem;
    Binninglogiciel1: TMenuItem;
    N3: TMenuItem;
    Modliseunetoile1: TMenuItem;
    Modlisetouteslestoiles1: TMenuItem;
    outZoom1: TMenuItem;
    N4: TMenuItem;
    Translation1: TMenuItem;
    Rotation1: TMenuItem;
    MiroirHorizontal1: TMenuItem;
    MiroirVertical1: TMenuItem;
    Rotation901: TMenuItem;
    Rotation902: TMenuItem;
    Rotation1801: TMenuItem;
    N2: TMenuItem;
    N5: TMenuItem;
    Dtourage1: TMenuItem;
    N6: TMenuItem;
    Entourage1: TMenuItem;
    Fenttrage1: TMenuItem;
    Gaussienne1: TMenuItem;
    N7: TMenuItem;
    MasqueFlou1: TMenuItem;
    N8: TMenuItem;
    Log1: TMenuItem;
    N9: TMenuItem;
    ClipMin1: TMenuItem;
    Seuillagemaximum1: TMenuItem;
    Binarisation1: TMenuItem;
    Couperltoile1: TMenuItem;
    CollerEtoileIci: TMenuItem;
    Copierltoile1: TMenuItem;
    N11: TMenuItem;
    CollerEtoile: TMenuItem;
    N10: TMenuItem;
    FFT1: TMenuItem;
    FFTInverse1: TMenuItem;
    Creruneetoile1: TMenuItem;
    N12: TMenuItem;
    Conversiondetype1: TMenuItem;
    EntiersversRels1: TMenuItem;
    Relsversentiers1: TMenuItem;
    Statistiques1: TMenuItem;
    N13: TMenuItem;
    Statistiquesfentres1: TMenuItem;
    N14: TMenuItem;
    Produitdintercorrlation1: TMenuItem;
    Produitdautocorrelation1: TMenuItem;
    ValeurAbsolue1: TMenuItem;
    outBlink1: TMenuItem;
    Compositage1: TMenuItem;
    N15: TMenuItem;
    Statistiquesdunlot1: TMenuItem;
    N16: TMenuItem;
    Matriciel1: TMenuItem;
    Passebas1: TMenuItem;
    Faible1: TMenuItem;
    TrsFaible1: TMenuItem;
    TrsFort1: TMenuItem;
    Fort1: TMenuItem;
    Passsehaut1: TMenuItem;
    TrsFort2: TMenuItem;
    Fort2: TMenuItem;
    Faible2: TMenuItem;
    TrsFaible2: TMenuItem;
    ExtraitOndelettes1: TMenuItem;
    Renforcementdondelettes1: TMenuItem;
    N17: TMenuItem;
    Mdian1: TMenuItem;
    Erosion1: TMenuItem;
    Dilatation1: TMenuItem;
    Fermeture1: TMenuItem;
    Ouverture1: TMenuItem;
    RankOrder1: TMenuItem;
    Valeursextrmes1: TMenuItem;
    PasseHautAdaptatif1: TMenuItem;
    ProjectionTlescopique1: TMenuItem;
    Histogramme1: TMenuItem;
    HorizScrollBar: TScrollBar;
    VerticScrollBar: TScrollBar;
    Rinitialiser1: TMenuItem;
    Confi1: TMenuItem;
    Enleveruntalon1: TMenuItem;
    Ajouterunesuppression1: TMenuItem;
    N18: TMenuItem;
    Cicatriseruneligne1: TMenuItem;
    Cicatriserunecolonne1: TMenuItem;
    CicatriserPixel1: TMenuItem;
    Zoom1: TMenuItem;
    outN251: TMenuItem;
    outN501: TMenuItem;
    outN751: TMenuItem;
    outN1001: TMenuItem;
    outN2001: TMenuItem;
    outN3001: TMenuItem;
    outN4001: TMenuItem;
    outN5001: TMenuItem;
    outN6001: TMenuItem;
    outN7001: TMenuItem;
    outN8001: TMenuItem;
    outN9001: TMenuItem;
    outN10001: TMenuItem;
    ImageMenu: TMenuItem;
    Dupliquer1: TMenuItem;
    N19: TMenuItem;
    AjouterplansRougeetVert1: TMenuItem;
    Sparerlesplans1: TMenuItem;
    Ajouterunplan1: TMenuItem;
    Supprimerunplan1: TMenuItem;
    Extrairedesplans1: TMenuItem;
    Permuter2plans1: TMenuItem;
    Astromtrie1: TMenuItem;
    Etalonnage2: TMenuItem;
    N20: TMenuItem;
    Mesure2: TMenuItem;
    Rinitialiser2: TMenuItem;
    Toutmesurer1: TMenuItem;
    Configuration1: TMenuItem;
    Rglerlesseuils1: TMenuItem;
    ImageList1: TImageList;
    N21: TMenuItem;
    ZoomAvant1: TMenuItem;
    ZoomArrire1: TMenuItem;
    Zoom2: TMenuItem;
    outN252: TMenuItem;
    outN502: TMenuItem;
    outN752: TMenuItem;
    outN1002: TMenuItem;
    outN2002: TMenuItem;
    outN3002: TMenuItem;
    outN4002: TMenuItem;
    outN5002: TMenuItem;
    outN6002: TMenuItem;
    outN7002: TMenuItem;
    outN8002: TMenuItem;
    outN9002: TMenuItem;
    outN10002: TMenuItem;
    N22: TMenuItem;
    Informations1: TMenuItem;
    Coupephotomtrique2: TMenuItem;
    Coupephotomtrique1: TMenuItem;
    N23: TMenuItem;
    Cosmtique1: TMenuItem;
    Cicatriseruneligne2: TMenuItem;
    Cicatriserunecolonne2: TMenuItem;
    Cicatriserunpixel1: TMenuItem;
    N24: TMenuItem;
    Enregisterfichiercosmetique1: TMenuItem;
    Appliquerunscript1: TMenuItem;
    Affichecible1: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    Driveversladroite1: TMenuItem;
    Driveversladroite2: TMenuItem;
    Driveverslebas1: TMenuItem;
    Driveverslehaut1: TMenuItem;
    Normedugradient1: TMenuItem;
    Extractiondecontours1: TMenuItem;
    Gradient1: TMenuItem;
    Extractiondecontour1: TMenuItem;
    Simplifieavecfiltrage1: TMenuItem;
    AjouterMarque1: TMenuItem;
    N27: TMenuItem;
    Fermer1: TMenuItem;
    Isophotes1: TMenuItem;
    RV1: TMenuItem;
    CFABayerRGB1: TMenuItem;
    Balancedescouleurs1: TMenuItem;
    procedure img_boxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExtraitOndelette1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Redimensioner1Click(Sender: TObject);
    procedure Ajouterconstante1Click(Sender: TObject);
    procedure Multiplierconstante1Click(Sender: TObject);
    procedure AjouterImage1Click(Sender: TObject);
    procedure SoustraireImage1Click(Sender: TObject);
    procedure Muli1Click(Sender: TObject);
    procedure DiviserImage1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure outClipOff2Click(Sender: TObject);
    procedure Etalonnage1Click(Sender: TObject);
    procedure img_boxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Mesure1Click(Sender: TObject);
    procedure Binninglogiciel1Click(Sender: TObject);
    procedure Modliseunetoile1Click(Sender: TObject);
    procedure Modlisetouteslestoiles1Click(Sender: TObject);
    procedure outZoom1Click(Sender: TObject);
    procedure Translation1Click(Sender: TObject);
    procedure Rotation1Click(Sender: TObject);
    procedure MiroirHorizontal1Click(Sender: TObject);
    procedure MiroirVertical1Click(Sender: TObject);
    procedure Rotation901Click(Sender: TObject);
    procedure Rotation902Click(Sender: TObject);
    procedure Rotation1801Click(Sender: TObject);
    procedure Dtourage1Click(Sender: TObject);
    procedure Entourage1Click(Sender: TObject);
    procedure Fenttrage1Click(Sender: TObject);
    procedure Gaussienne1Click(Sender: TObject);
    procedure MasqueFlou1Click(Sender: TObject);
    procedure Log1Click(Sender: TObject);
    procedure ClipMin1Click(Sender: TObject);
    procedure Seuillagemaximum1Click(Sender: TObject);
    procedure Binarisation1Click(Sender: TObject);
    procedure Couperltoile1Click(Sender: TObject);
    procedure CollerEtoileIciClick(Sender: TObject);
    procedure Copierltoile1Click(Sender: TObject);
    procedure CollerEtoileClick(Sender: TObject);
    procedure FFT1Click(Sender: TObject);
    procedure FFTInverse1Click(Sender: TObject);
    procedure Creruneetoile1Click(Sender: TObject);
    procedure EntiersversRels1Click(Sender: TObject);
    procedure Relsversentiers1Click(Sender: TObject);
    procedure Statistiques1Click(Sender: TObject);
    procedure Statistiquesfentres1Click(Sender: TObject);
    procedure Produitdintercorrlation1Click(Sender: TObject);
    procedure Produitdautocorrelation1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ValeurAbsolue1Click(Sender: TObject);
    procedure outBlink1Click(Sender: TObject);
    procedure Compositage1Click(Sender: TObject);
    procedure Statistiquesdunlot1Click(Sender: TObject);
    procedure Matriciel1Click(Sender: TObject);
    procedure TrsFort1Click(Sender: TObject);
    procedure Fort1Click(Sender: TObject);
    procedure Faible1Click(Sender: TObject);
    procedure TrsFaible1Click(Sender: TObject);
    procedure TrsFort2Click(Sender: TObject);
    procedure Fort2Click(Sender: TObject);
    procedure Faible2Click(Sender: TObject);
    procedure TrsFaible2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ExtraitOndelettes1Click(Sender: TObject);
    procedure Renforcementdondelettes1Click(Sender: TObject);
    procedure Mdian1Click(Sender: TObject);
    procedure Erosion1Click(Sender: TObject);
    procedure Dilatation1Click(Sender: TObject);
    procedure Fermeture1Click(Sender: TObject);
    procedure Ouverture1Click(Sender: TObject);
    procedure RankOrder1Click(Sender: TObject);
    procedure Valeursextrmes1Click(Sender: TObject);
    procedure PasseHautAdaptatif1Click(Sender: TObject);
    procedure ProjectionTlescopique1Click(Sender: TObject);
    procedure Histogramme1Click(Sender: TObject);
    procedure VerticScrollBarScroll(Sender: TObject;
      ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure HorizScrollBarScroll(Sender: TObject;
      ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure FormResize(Sender: TObject);
    procedure img_boxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Rinitialiser1Click(Sender: TObject);
    procedure Confi1Click(Sender: TObject);
    procedure Enleveruntalon1Click(Sender: TObject);
    procedure Ajouterunesuppression1Click(Sender: TObject);
    procedure CicatriserPixel1Click(Sender: TObject);
    procedure Cicatriserunecolonne1Click(Sender: TObject);
    procedure Cicatriseruneligne1Click(Sender: TObject);
    procedure outN251Click(Sender: TObject);
    procedure outN501Click(Sender: TObject);
    procedure outN751Click(Sender: TObject);
    procedure outN1001Click(Sender: TObject);
    procedure outN2001Click(Sender: TObject);
    procedure outN3001Click(Sender: TObject);
    procedure outN4001Click(Sender: TObject);
    procedure outN5001Click(Sender: TObject);
    procedure outN6001Click(Sender: TObject);
    procedure outN7001Click(Sender: TObject);
    procedure outN8001Click(Sender: TObject);
    procedure outN9001Click(Sender: TObject);
    procedure outN10001Click(Sender: TObject);
    procedure Dupliquer1Click(Sender: TObject);
    procedure AjouterplansRougeetVert1Click(Sender: TObject);
    procedure Sparerlesplans1Click(Sender: TObject);
    procedure Ajouterunplan1Click(Sender: TObject);
    procedure Supprimerunplan1Click(Sender: TObject);
    procedure Extrairedesplans1Click(Sender: TObject);
    procedure Permuter2plans1Click(Sender: TObject);
    procedure Etalonnage2Click(Sender: TObject);
    procedure Mesure2Click(Sender: TObject);
    procedure Rinitialiser2Click(Sender: TObject);
    procedure Toutmesurer1Click(Sender: TObject);
    procedure Configuration1Click(Sender: TObject);
    procedure Rglerlesseuils1Click(Sender: TObject);
    procedure ZoomAvant1Click(Sender: TObject);
    procedure ZoomArrire1Click(Sender: TObject);
    procedure outN252Click(Sender: TObject);
    procedure outN502Click(Sender: TObject);
    procedure outN752Click(Sender: TObject);
    procedure outN1002Click(Sender: TObject);
    procedure outN2002Click(Sender: TObject);
    procedure outN3002Click(Sender: TObject);
    procedure outN4002Click(Sender: TObject);
    procedure outN5002Click(Sender: TObject);
    procedure outN6002Click(Sender: TObject);
    procedure outN7002Click(Sender: TObject);
    procedure outN8002Click(Sender: TObject);
    procedure outN9002Click(Sender: TObject);
    procedure outN10002Click(Sender: TObject);
    procedure Informations1Click(Sender: TObject);
    procedure Coupephotomtrique2Click(Sender: TObject);
    procedure img_boxClick(Sender: TObject);
    procedure Cicatriseruneligne2Click(Sender: TObject);
    procedure Cicatriserunecolonne2Click(Sender: TObject);
    procedure Cicatriserunpixel1Click(Sender: TObject);
    procedure Enregisterfichiercosmetique1Click(Sender: TObject);
    procedure Appliquerunscript1Click(Sender: TObject);
    procedure Affichecible1Click(Sender: TObject);
    procedure Driveversladroite1Click(Sender: TObject);
    procedure Driveversladroite2Click(Sender: TObject);
    procedure Driveverslebas1Click(Sender: TObject);
    procedure Driveverslehaut1Click(Sender: TObject);
    procedure Normedugradient1Click(Sender: TObject);
    procedure Extractiondecontours1Click(Sender: TObject);
    procedure Simplifieavecfiltrage1Click(Sender: TObject);
    procedure AjouterMarque1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure Isophotes1Click(Sender: TObject);
    procedure RV1Click(Sender: TObject);
    procedure CFABayerRGB1Click(Sender: TObject);
    procedure Balancedescouleurs1Click(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
//    Sx,Sy:Integer;              // Dimensions a passer un jour dans TImgInfos
    ImgInfos:TImgInfos;         // Autres infos
    ZoomFactor:Double;

//    ImgInfos.NbPlans:Byte;               // Nombre de plans Couleur:3 Complexe:2
//    TypeData:Byte;              // Type des donnees :
    DataByte:PTabImgByte;       // TypeData=1
    DataInt:PTabImgInt;         // TypeData=2
    DataWord:PTabImgWord;       // TypeData=3
    DataSingle:PTabImgSingle;   // TypeData=4
    DataDouble:PTabImgDouble;   // TypeData=5
    // Complexes                // TypeData=6 et ImgInfos.NbPlans=2
    //                          // Trichromie entière TypeData=7 et ImgInfos.NbPlans=3
    //                          // Trichromie réelle TypeData=8 et ImgInfos.NbPlans=3

//    TypeComplexe:Byte; // Type de visu complexe
    // 1 : Module
    // 2 : Angle
    // 3 : Partie Réelle ( dans plan 1 )
    // 4 : Partie Imaginaire ( sans plan 2 )

    // Pour le Undo
    DateTimeUndo:TDateTime;
    CanUndo:Boolean;
    SxUndo,SyUndo:Integer;
    MinUndo,MaxUndo:TSeuils;
    ImgInfosUndo:TImgInfos;
    NbPlansUndo:Byte;
    TypeDataUndo:Byte;
    DataByteUndo:PTabImgByte;
    DataIntUndo:PTabImgInt;
    DataWordUndo:PTabImgWord;
    DataSingleUndo:PTabImgSingle;
    DataDoubleUndo:PTabImgDouble;
    TypeComplexeUndo:Byte;

    // Pointages
    TypePointage,FormePointage:Byte;
    ClipIsOn:Boolean;
    OldX,OldY,Xinit,Yinit:Integer;

    // Fenetre de rapport
    Rapport:Tpop_Rapport;

    // Gestion de l'image d'acqusition
    IsUsedForAcq,IsUsedForTrack,IsUsedForWebCam :Boolean;
    AcqRunning,AcqTrackRunning:Boolean;

    //Empecher la fermeture ( MAP ... )
    Bloque:Boolean;

    // Affichage de l'etoile
    VisuEtoile:Boolean;

    // Copier Coller d'étoiles
    PSFCopie:TPSF;
    XimgCopie,YimgCopie:Integer;

    // Mode Expert
    NameScript:string;

    // Ajustage de la visu
    AjustageEnCours:Boolean;

    // Deplacement a la min de l'image
    DeplaceALaMain:Boolean;
    XMain,YMain:Integer;

    // Photometrie
    FluxEtalon,ErreurFluxEtalon,MagnitudeEtalon:Double;
    FluxEtoile,ErreurFluxEtoile,MagnitudeEtoile,ErreurMagnitudeEtoile:Double;
    // SuperStar
    FluxEtalonTheorique,MagnitudeSuperStar,FluxSuperStar,ErreurFluxSuperStar:Double;
    ErreurMagnitudeSuperStar:Double;
    MagnitudeMesuree:Boolean;
    // Liste chainée d'étalons pour la photométrie
    FirstEtalon,EtalonCourant,OldEtalon,EtalonPrecedent:PEtalon;
    Etoile:TEtalon;
    NbEtalons:Integer;
    // Liste chainée d'étalons pour la suppression
    FirstEtalonSupp,EtalonCourantSupp,OldEtalonSupp,EtalonPrecedentSupp:PEtalon;
    NbEtalonsSupp:Integer;

    ReticulePresent:Boolean;

    // Astrometrie
    AstrometrieInfos:TAstrometrieInfos;
    AstrometrieCalibree:Boolean;
    // Liste chainée de mesures pour l'astrometrie
    FirstAstrom,AstromCourant,OldAstrom,AstromPrecedent:PAstrom;
    NbAstrom:Integer;

    // Coupe
    SelectPhotoLine:TRect;

    // Marque
    XMarque,YMarque:Integer;

    Calib1,Calib2,Calib3,Calib4,Calib5,Calib6,Calib7:Boolean;

    procedure ChangerMenu;
    procedure VisuImg;
    procedure VisuHighLight(MinH,MaxH:Double);
    function ReadImage(FileName:string):Boolean;
    procedure SaveImage(FileName:String);

    procedure EcranToImage(var X,Y:Integer);
    procedure ImageToEcran(var X,Y:Integer);
    procedure SetZoom(NewZoomFactor:Double);
    function GetLargeurMaxWindow:Integer;
    function GetHauteurMaxWindow:Integer;
    procedure AjusteScrollbars(CanResize:Boolean);
    procedure AjusteFenetre;
    procedure AjusteImage;
    procedure VisuAutoEtoiles;
    procedure VisuAutoEtoilesPlan(i:Integer);
    procedure VisuAutoPlanetes;
    procedure VisuAutoPlanetesPlan(i:Integer);
    procedure VisuAutoMinMax;
    procedure VisuMiniMaxi(Mini,Maxi : double);
    procedure VisuMinMaxPlane(Plane:Byte;Mini,Maxi:Single);
    procedure ClipOn;
    procedure ClipOff;

    // Photométrie
    procedure EtalonnePhotometrie(X,Y:Integer);
    procedure DoSupprimeEtalon(X,Y:Integer);
    procedure DoEnleveEtalon(X,Y:Integer);
    procedure MesurePhotometrie(X,Y:Integer);
    procedure MesureEtoile(X,Y:Integer);
    procedure CalculPhotometrie;
    procedure ReinitialisePhotometrie;
    procedure VisuPhotometrie;

    // Copier coller d'étoiles
    procedure CopieEtoile(X,Y:Integer);
    procedure CoupeEtoile(X,Y:Integer);
    procedure ColleEtoile;
    procedure ColleEtoileIci(X,Y:Integer);
    procedure CreerEtoile(X,Y:Integer);

    procedure StatFenetre(X1,Y1,X2,Y2:Integer);
    procedure MiseAJourSeuils;

    // Undo
    procedure SaveUndo;
    procedure RestaureUndo;

    // Dessins sur l'image
    procedure Cercle(XImg,YImg:Integer);
    procedure CercleStr(XImg,YImg:Integer;Line:string;Color:TColor);

    // Astrometrie
    procedure MesureAstrometrie(X,Y:Integer);
    procedure VisuAstrometrie;
    procedure ReinitialiseAstrometrie;

    //coupe
    procedure DisplayCoupePhotometrique(x,y,x1,y1:integer);

    procedure GenerePixelsChauds;


    // Scripts
    procedure VisuStar;
    procedure VisuStarPlane(Nb:Integer);
    procedure VisuPlanet;
    procedure VisuPlanetPlane(Nb:Integer);
    procedure VisuMinMax;
    procedure Visu(Mini,Maxi:Single);
    procedure VisuPlane(Plane:Byte;Mini,Maxi:Single);
    procedure AjusteMinMaxSeuils(NoPlans:Byte;SeuilBas,SeuilHaut:Double);

    procedure SaveFITSInt(FileName:string);
    procedure SaveFITSFloat(FileName:string);
    procedure SaveImgCPAV3(FileName:string);
    procedure SaveImgCPAV4(FileName:string);
    procedure SaveImgPIC(FileName:string);
    procedure SaveImgBMP(FileName:string);
    procedure SaveImgJPG(FileName:string);
    procedure SaveImgTXT(FileName:string);
  end;

var
   pop_image:tpop_image;

implementation

uses pu_seuils,
     u_file_io,
     pu_select_img,
     u_constants,
     u_geometrie,
     pu_2integer_dlg,
     pu_main,
     pu_camera,
     pu_zoom,
     u_modelisation,
     u_visu,
     u_analyse,
     pu_blink,
     pu_seuils_color,
     u_lang,
     pu_webcam,
     pu_ondelettes,
     pu_histo,
     pu_camera_suivi,
     pu_conf,
     pu_calib_Astrom,
     u_cameras,
     u_astrometrie,
     pu_cree_proj,
     u_meca,
     pu_fit_astom,
     pu_graph,
     pu_infos_image,
     pu_edit_text,
     pu_balance,
     pu_cfadlg;

{$R *.DFM}

// Ici on efface les fonction du menu
// En fonction du type des donnnees, du nombre de plans ...
procedure Tpop_Image.ChangerMenu;
begin
//Modliseunetoile1.Visible:=(Typedata in [2,5]) and (ImgInfos.NbPlans=1);
//Modlisetouteslestoiles1.Visible:=(Typedata in [2,5]) and (ImgInfos.NbPlans=1);
Photomtrie1.Visible:=(ImgInfos.Typedata in [2,5]) and (ImgInfos.NbPlans=1);
//Compositage1.Visible:=(Typedata in [2,5]) and (ImgInfos.NbPlans=1);
Compositage1.Visible:=(ImgInfos.Typedata in [2,7,5,8]);

Fenttrage1.Visible:=ImgInfos.Typedata in [2,7,5,6,8];
Translation1.Visible:=ImgInfos.Typedata in [2,7,5,6,8];
Rotation1.Visible:=ImgInfos.Typedata in [2,7,5,6,8];
Rotation901.Visible:=ImgInfos.Typedata in [2,7,5,6,8];
Rotation902.Visible:=ImgInfos.Typedata in [2,7,5,6,8];
outZoom1.Visible:=ImgInfos.Typedata in [2,7,5,6,8];
MiroirHorizontal1.Visible:=ImgInfos.Typedata in [2,7,5,6,8];
MiroirVertical1.Visible:=ImgInfos.Typedata in [2,7,5,6,8];
Rotation1801.Visible:=ImgInfos.Typedata in [2,7,5,6,8];
Dtourage1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];
Entourage1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];
Binninglogiciel1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];

//******************************************************************************

FFT1.Visible:=(ImgInfos.Typedata in [2,5]) and (ImgInfos.NbPlans=1);
FFTInverse1.Visible:=(ImgInfos.Typedata in [6]) and (ImgInfos.NbPlans=2);

Ajouterconstante1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];
Multiplierconstante1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];
AjouterImage1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];
SoustraireImage1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];
Muli1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];
DiviserImage1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];
Log1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];
ClipMin1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];
Seuillagemaximum1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];
Binarisation1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];
Gaussienne1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];
MasqueFlou1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];
ExtraitOndelette1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];
ValeurAbsolue1.Visible:=ImgInfos.Typedata in [2,5,6,7,8];
Conversiondetype1.Visible:=ImgInfos.Typedata in [2,5,7,8];
EntiersversRels1.Visible:=ImgInfos.Typedata in [2,7];
Relsversentiers1.Visible:=ImgInfos.Typedata in [5,8];

AjouterplansRougeetVert1.Visible:=(ImgInfos.Typedata in [2,5]) and (ImgInfos.NbPlans=1);
Sparerlesplans1.Visible:=ImgInfos.NbPlans>1;
Permuter2plans1.Visible:=ImgInfos.NbPlans>1;

//******************************************************************************
// Menu contextuel
Creruneetoile1.Visible:=(ImgInfos.Typedata in [2,5]) and (ImgInfos.NbPlans=1);
Copierltoile1.Visible:=(ImgInfos.Typedata in [2,5]) and (ImgInfos.NbPlans=1);
Couperltoile1.Visible:=(ImgInfos.Typedata in [2,5]) and (ImgInfos.NbPlans=1);
CollerEtoile.Visible:=(ImgInfos.Typedata in [2,5]) and (ImgInfos.NbPlans=1);
CollerEtoileIci.Visible:=(ImgInfos.Typedata in [2,5]) and (ImgInfos.NbPlans=1);


N1.Visible:=(ImgInfos.Typedata in [2]) and (ImgInfos.NbPlans=1);
N2.Visible:=(ImgInfos.Typedata in [2]) and (ImgInfos.NbPlans=1);
N4.Visible:=(ImgInfos.Typedata in [2]) and (ImgInfos.NbPlans=1);
N5.Visible:=(ImgInfos.Typedata in [2]) and (ImgInfos.NbPlans=1);
N7.Visible:=(ImgInfos.Typedata in [2]) and (ImgInfos.NbPlans=1);
N10.Visible:=(ImgInfos.Typedata in [2]) and (ImgInfos.NbPlans=1);
N15.Visible:=(ImgInfos.Typedata in [2]) and (ImgInfos.NbPlans=1);

RV1.Visible:=(ImgInfos.Typedata in [7,8]) and (ImgInfos.NbPlans=3);

CFABayerRGB1.Visible:=(ImgInfos.Typedata in [2]) and (ImgInfos.NbPlans=1);
Balancedescouleurs1.Visible:=(ImgInfos.Typedata in [7,8]) and (ImgInfos.NbPlans=3);

//pop_main.ToolbarButton9711.Enabled:=(ImgInfos.Typedata in [2,7,8]);
//pop_main.ToolbarButton9713.Enabled:=(ImgInfos.Typedata in [2,7,8]);
//pop_main.ToolbarButton9714.Enabled:=(ImgInfos.Typedata in [2,7,8]);
//pop_main.ToolbarSep976.Enabled:=(ImgInfos.Typedata in [2,7,8]);
//pop_main.ToolbarButton9715.Enabled:=(ImgInfos.Typedata in [2,7,8]);
//pop_main.ToolbarButton9716.Enabled:=(ImgInfos.Typedata in [2,5,6,7,8]);
end;

procedure Tpop_image.img_boxMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
ax,bx,ay,by:Double;
ax1,bx1,ay1,by1:Double;
XinitEcran,YinitEcran,XEcran,YEcran:Integer;
Position,Point:TPoint;
Line:string;
i:Integer;
XProj,YProj,Alpha,Delta,XProjPU,YProjPU:Double;
begin
if (Shift=[ssLeft]) and (formepointage=CoupePhoto) then
   begin
   Img_Box.canvas.MoveTo(SelectPhotoLine.left,SelectPhotoLine.top);
   Img_Box.canvas.LineTo(SelectPhotoLine.right,SelectPhotoLine.bottom);
   Img_Box.canvas.MoveTo(SelectPhotoLine.left,SelectPhotoLine.top);
   Img_Box.canvas.LineTo(x,y);
   SelectPhotoLine.right:=x;
   SelectPhotoLine.bottom:=y;
   end;

Line:='';

ax1:=(ImgInfos.Sx-1)/(ZoomFactor*ImgInfos.Sx-ZoomFactor);
bx1:=1-ax1;
ay1:=(ImgInfos.Sy-1)/(ZoomFactor*ImgInfos.Sy-ZoomFactor);
by1:=1-ay1;

ax:=(Img_Box.Width-1)/ZoomFactor/(Img_Box.Width-1);
bx:=ax1*Round(HorizScrollBar.Position)+bx1;
ay:=(Img_Box.Height-1)/ZoomFactor/(Img_Box.Height-1);
// Merde faut pas inverser ici / Pourquoi ? / Mystere et boule de gomme !
by:=ay1*Round(VerticScrollBar.Position)+by1;

XEcran:=Trunc(ax*X+bx);
YEcran:=Trunc(ay*Y+by);
Application.ProcessMessages;
XinitEcran:=Trunc(ax*Xinit+bx);
YinitEcran:=Trunc(ay*YInit+by);

if (FormePointage=Rectangle) or (FormePointage=Ligne) then
   begin
   if (YEcran>0) and (YEcran<=ImgInfos.Sy) and (XEcran>0) and (XEcran<=ImgInfos.Sx) then
      Line:=Line+'X1='+IntToStr(XinitEcran)                                        //nolang
       // Pourquoi cette adaptation ? Mystere et boule de gomme !
//         +' Y1='+IntToStr(Sy-YInitEcran+1)+' X2='+IntToStr(XEcran)               //nolang
//         +' Y2='+IntToStr(Sy-YEcran+1)+' DX='+IntToStr(Abs(X-Xinit))             //nolang
         +' Y1='+IntToStr(ImgInfos.Sy-YInitEcran+1)+' X2='+IntToStr(XEcran-1)               //nolang
         +' Y2='+IntToStr(ImgInfos.Sy-YEcran+2)+' DX='+IntToStr(Abs(XEcran-XinitEcran))     //nolang
         +' DY='+IntToStr(Abs(YInitEcran-YEcran));                                 //nolang
   end
else
   begin
   if (YEcran>0) and (YEcran<=ImgInfos.Sy) and (XEcran>0) and (XEcran<=ImgInfos.Sx) then
      case ImgInfos.Typedata of
         2:begin
           Line:=Line+'X='+IntToStr(XEcran)+' Y='+IntToStr(ImgInfos.Sy-YEcran+1)+'     ';                    //nolang
           for i:=1 to ImgInfos.NbPlans do Line:=Line+' I'+IntToStr(i)+'='+                                  //nolang
              MyFloatToStr(DataInt^[i]^[ImgInfos.Sy-YEcran+1]^[XEcran],2);    //nolang
           end;
         5:begin
           Line:=Line+'X='+IntToStr(XEcran)+' Y='+IntToStr(ImgInfos.Sy-YEcran+1)+'     ';                    //nolang
           for i:=1 to ImgInfos.NbPlans do Line:=Line+' I'+IntToStr(i)+'='+                                  //nolang
              MyFloatToStr(DataDouble^[i]^[ImgInfos.Sy-YEcran+1]^[XEcran],2);                   //nolang
           end;
         6:Line:=Line+'X='+IntToStr(XEcran)                                                                  //nolang
              +' Y='+IntToStr(ImgInfos.Sy-YEcran+1)+'      '                                                 //nolang
              +'I='+FloatToStrF(DataDouble^[1]^[ImgInfos.Sy-YEcran+1]^[XEcran],ffFixed,6,2)     //nolang
              +'+i'+FloatToStrF(DataDouble^[2]^[ImgInfos.Sy-YEcran+1]^[XEcran],ffFixed,6,2);    //nolang
         7:Line:=Line+'X='+IntToStr(XEcran)                                                                  //nolang
              +' Y='+IntToStr(ImgInfos.Sy-YEcran+1)+'     '                                                  //nolang
              +' Ir='+MyFloatToStr(DataInt^[1]^[ImgInfos.Sy-YEcran+1]^[XEcran],2)               //nolang
              +' Iv='+MyFloatToStr(DataInt^[2]^[ImgInfos.Sy-YEcran+1]^[XEcran],2)                 //nolang
              +' Ib='+MyFloatToStr(DataInt^[3]^[ImgInfos.Sy-YEcran+1]^[XEcran],2);                //nolang
         8:Line:=Line+'X='+IntToStr(XEcran)                                                                  //nolang
              +' Y='+IntToStr(ImgInfos.Sy-YEcran+1)+'     '                                                  //nolang
              +' Ir='+FloatToStrF(DataDouble^[1]^[ImgInfos.Sy-YEcran+1]^[XEcran],ffFixed,6,2)   //nolang
              +' Iv='+FloatToStrF(DataDouble^[2]^[ImgInfos.Sy-YEcran+1]^[XEcran],ffFixed,6,2)   //nolang
              +' Ib='+FloatToStrF(DataDouble^[3]^[ImgInfos.Sy-YEcran+1]^[XEcran],ffFixed,6,2);  //nolang
         end;
   end;

// Astrometrie
if AstrometrieCalibree then
   begin
//   XProj:=CalcPolynomeXY(XEcran,ImgInfos.Sy-YEcran+1,AstrometrieInfos.PolyX,AstrometrieInfos.DegrePoly);
//   YProj:=CalcPolynomeXY(XEcran,ImgInfos.Sy-YEcran+1,AstrometrieInfos.PolyY,AstrometrieInfos.DegrePoly);
   XProj:=CalcPolynomeXY(XEcran-ImgInfos.Sx div 2,(ImgInfos.Sy-YEcran+1)-ImgInfos.Sy div 2,AstrometrieInfos.PolyX,AstrometrieInfos.DegrePoly);
   YProj:=CalcPolynomeXY(XEcran-ImgInfos.Sx div 2,(ImgInfos.Sy-YEcran+1)-ImgInfos.Sy div 2,AstrometrieInfos.PolyY,AstrometrieInfos.DegrePoly);
//   XProjPU:=(-(ImgInfos.Sx div 2)+XProj)*AstrometrieInfos.TaillePixel/AstrometrieInfos.Focale*1000/1e6;
//   YProjPU:=(-(ImgInfos.Sy div 2)+YProj)*AstrometrieInfos.TaillePixel/AstrometrieInfos.Focale*1000/1e6;
   XProjPU:=XProj*AstrometrieInfos.TaillePixelX/AstrometrieInfos.Focale*1000/1e6;
   YProjPU:=YProj*AstrometrieInfos.TaillePixelY/AstrometrieInfos.Focale*1000/1e6;
//   pop_main.Label1.Caption:=MyFloatToStr(XProjPU,12);
//   pop_main.Label2.Caption:=MyFloatToStr(YProjPU,12);

   XYToAlphaDelta(XProjPU,YProjPU,AstrometrieInfos.Alpha0,AstrometrieInfos.Delta0,Alpha,Delta);
   Line:=Line+'   '+AlphaToStr(Alpha)+'/'+DeltaToStr(Delta); //nolang
   end;

pop_main.StatusBar1.Panels[0].Text:=Line;

if ClipIsOn then
   begin
   if ((FormePointage=Reticule) or (FormePointage=Ligne)) and ReticulePresent then
      begin
      // On efface le reticule à l'ancienne position
//      WriteSpy('Reticule Off mousemove');
      ReticulePresent:=False;
      Img_Box.Canvas.Pen.Color:=ClWhite;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=PmXor;
      Img_Box.Canvas.Brush.Style:=bsClear;
      Img_Box.Canvas.MoveTo(OldX,0);
      Img_Box.Canvas.LineTo(OldX,Img_Box.Height);
      Img_Box.Canvas.MoveTo(0,OldY);
      Img_Box.Canvas.LineTo(Img_Box.Width,OldY);
      end;
   if FormePointage=Rectangle then
      begin
      // On efface le rectangle à l'ancienne position
      Img_Box.Canvas.Pen.Color:=ClWhite;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=PmXor;
      Img_Box.Canvas.Brush.Style:=bsClear;
      Img_Box.Canvas.Rectangle(Xinit,Yinit,OldX,OldY);
      end;
   if FormePointage=Ligne then
      begin
      // On efface la ligne à l'ancienne position
      Img_Box.Canvas.pen.Mode:=pmXor;
      Img_Box.Canvas.MoveTo(Xinit,Yinit);
      Img_Box.Canvas.LineTo(OldX,OldY);
      end;

   // Marche pas pour le pointage des rectangle
   // Faudrait garder en memoire les coordonnes images
   // Trop complique
   if (FormePointage<>Rectangle) and (FormePointage<>Ligne) then
      begin
      if X+Img_Box.Left<=1 then
         begin
         HorizScrollBar.Position:=HorizScrollBar.Position-HorizScrollBar.SmallChange;
         VisuImg;
         Update;
         end;
      if X+Img_Box.Left>=Img_Box.Width-1 then
         begin
         HorizScrollBar.Position:=HorizScrollBar.Position+HorizScrollBar.SmallChange;
         VisuImg;
         Update;
         end;
      if Y+Img_Box.Top<=1 then
         begin
         VerticScrollBar.Position:=VerticScrollBar.Position-VerticScrollBar.SmallChange;
         VisuImg;
         Update;
         end;
      if Y+Img_Box.Top>=Img_Box.Height-1 then
         begin
         VerticScrollBar.Position:=VerticScrollBar.Position+VerticScrollBar.SmallChange;
         VisuImg;
         Update;
         end;
      end;

   if ((FormePointage=Reticule) or (FormePointage=Ligne)) and not ReticulePresent then
      begin
      // On affiche le reticule à la nouvelle position
      ReticulePresent:=True;
//      WriteSpy('Reticule On mousemove');
      Img_Box.Canvas.Pen.Color:=ClWhite;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=PmXor;
      Img_Box.Canvas.Brush.Style:=bsClear;
      Img_Box.Canvas.MoveTo(X,0);
      Img_Box.Canvas.LineTo(X,Img_Box.Height);
      Img_Box.Canvas.MoveTo(0,Y);
      Img_Box.Canvas.LineTo(Img_Box.Width,Y);
      end;
   if FormePointage=Rectangle then
      begin
      // On affiche le rectangle à la nouvelle position
      Img_Box.Canvas.Pen.Color:=ClWhite;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=PmXor;
      Img_Box.Canvas.Brush.Style:=bsClear;
      Img_Box.Canvas.Rectangle(Xinit,Yinit,X,Y);
      end;
   if FormePointage=Ligne then
      begin
      // On affiche la ligne à l'ancienne position
      Img_Box.Canvas.pen.Mode:=pmXor;
      Img_Box.Canvas.MoveTo(Xinit,Yinit);
      Img_Box.Canvas.LineTo(X,Y);
      end;

   end;

OldX:=X;
OldY:=Y;

if DeplaceALaMain and (Shift=[ssLeft]) and not(TypePointage=PointeFenetrage) then
   begin
   HorizScrollBar.Position:=HorizScrollBar.Position+(XMain-X);
   VerticScrollBar.Position:=VerticScrollBar.Position+(YMain-Y);
   VisuImg;
   Update;

   XMain:=X;
   YMain:=Y;
   end;
end;

// Sauvegarde en vu du Undo
procedure Tpop_image.SaveUndo;
begin
// Liberer la memoire precedente !
if TraductionEnCours then Exit;
if CanUndo then FreememImg(DataIntUndo,DataDoubleUndo,SxUndo,SyUndo,TypedataUndo,NbPlansUndo);
SxUndo:=ImgInfos.Sx;
SyUndo:=ImgInfos.Sy;
ImgInfosUndo:=ImgInfos;
NbPlansUndo:=ImgInfos.NbPlans;
TypedataUndo:=ImgInfos.Typedata;
TypeComplexeUndo:=ImgInfos.TypeComplexe;
GetmemImg(DataIntUndo,DataDoubleUndo,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans);
Transfert(DataInt,DataIntUndo,DataDouble,DataDoubleUndo,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
CanUndo:=True;
end;

// Restauration du Undo
procedure Tpop_image.RestaureUndo;
var
DataIntTmp:PTabImgInt;
DataDoubleTmp:PTabImgDouble;
IntTmp:Integer;
ByteTmp:Byte;
SxSave,SySave:Integer;
TypedataSave,NbPlansSave:Byte;
ImgInfosTmp:TImgInfos;
begin
if CanUndo then
   begin
   SxSave:=ImgInfos.Sx;
   SySave:=ImgInfos.Sy;
   TypedataSave:=ImgInfos.Typedata;
   NbPlansSave:=ImgInfos.NbPlans;

   GetmemImg(DataIntTmp,DataDoubleTmp,SxSave,SySave,TypedataSave,NbPlansSave);
   try
   Transfert(DataInt,DataIntTmp,DataDouble,DataDoubleTmp,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
   FreememImg(DataInt,DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans);

   IntTmp:=ImgInfos.Sx;
   ImgInfos.Sx:=SxUndo;
   SxUndo:=IntTmp;
   IntTmp:=ImgInfos.Sy;
   ImgInfos.Sy:=SyUndo;
   SyUndo:=IntTmp;

   ImgInfosTmp:=ImgInfos;
   ImgInfos:=ImgInfosUndo;
   ImgInfosUndo:=ImgInfosTmp;

   ByteTmp:=ImgInfos.NbPlans;
   ImgInfos.NbPlans:=NbPlansUndo;
   NbPlansUndo:=ByteTmp;
   ByteTmp:=ImgInfos.Typedata;
   ImgInfos.Typedata:=TypedataUndo;
   TypedataUndo:=ByteTmp;
   ByteTmp:=ImgInfos.TypeComplexe;
   ImgInfos.TypeComplexe:=TypeComplexeUndo;
   TypeComplexeUndo:=ByteTmp;

   GetmemImg(DataInt,DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans);
   Transfert(DataIntUndo,DataInt,DataDoubleUndo,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
   FreememImg(DataIntUndo,DataDoubleUndo,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans);
   GetmemImg(DataIntUndo,DataDoubleUndo,SxUndo,SyUndo,TypedataUndo,NbPlansUndo);
   Transfert(DataIntTmp,DataIntUndo,DataDoubleTmp,DataDoubleUndo,TypedataUndo,NbPlansUndo,SxUndo,SyUndo);
   AjusteFenetre;
   VisuImg;
   finally
   FreememImg(DataIntTmp,DataDoubleTmp,SxSave,SySave,TypedataSave,NbPlansSave);
   end;
   end;
end;

procedure Tpop_image.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
//  var i:integer;
begin
// Est ce vraiment necessaire ?
// N'est ce pas fait automatiquement ?
//if DataInt<>nil then
//   begin
//  for i:=1 to ImgInfos.Sy do Freemem(DataInt^[1]^[i],ImgInfos.Sx*2);
//   Freemem(DataInt^[1],4*ImgInfos.Sy);
//   end;
// Reponse : Oui c'est fait automatiquement
// Et non ! Mais on le fait dans FormClose
CanClose:=True;
end;

procedure Tpop_image.FormClose(Sender: TObject; var Action: TCloseAction);
var
i,NbImages:Integer;
begin
// Si une aquisition est en cours on ferme pas !
if AcqRunning or AcqTrackRunning or Bloque then
   begin
   Action:=caNone;
   Exit;
   end;

// Si il y a plus d'images, on mets le reglage des seuils HS
NbImages:=0;
for i:=0 to pop_main.MDIChildCount-1 do
   if pop_main.MdiChildren[i] is tpop_image then inc(NbImages);
if NbImages=1 then pop_main.SeuilsDesable;

// Non de dieu ! Il faut liberer la memoire avant qu'elle explose !
FreeMemImg(DataInt,DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans);
// Liberer la memoire precedente !
if CanUndo then
   FreememImg(DataIntUndo,DataDoubleUndo,SxUndo,SyUndo,TypedataUndo,NbPlansUndo);

ReinitialisePhotometrie;
ReinitialiseAstrometrie;

// Si c'est l'image d'aquisition mettre a jour le pointeur de pop_camera
if IsUsedForAcq then
   begin
//   pop_camera.pop_image_acq.Free;
   pop_camera.pop_image_acq:=nil;
   end;
if IsUsedForTrack then
   begin
//   pop_camera_suivi.pop_image_acq.Free;
   pop_camera_suivi.pop_image_acq:=nil;
   end;
if IsUsedForWebCam then pu_webcam.webcamcumul:=nil;

if Calib1 then pop_camera_suivi.pop_image1:=nil;
if Calib2 then pop_camera_suivi.pop_image2:=nil;
if Calib3 then pop_camera_suivi.pop_image3:=nil;
if Calib4 then pop_camera_suivi.pop_image4:=nil;
if Calib5 then pop_camera_suivi.pop_image5:=nil;
if Calib6 then pop_camera_suivi.pop_image6:=nil;
if Calib7 then pop_camera_suivi.pop_image7:=nil;
                                          
// Non ! (memproof)
//DeleteObject(img_box.Picture.Bitmap.Handle);

action:=cafree;
end;

procedure Tpop_image.ExtraitOndelette1Click(Sender: TObject);
var
NoOnd,MaxDim,i:Integer;
pop_image:tpop_image;

TabItems:PTabItems;
DlgStandard:Tpop_dlg_standard;
begin
if ImgInfos.Sx>ImgInfos.Sy then MaxDim:=ImgInfos.Sx else MaxDim:=ImgInfos.Sy;

New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiInteger;
   Msg:=lang('Numéro du plan à extraire : ');
   ValeurIncrement:=1;
   ValeurDefaut:=2;
   ValeurMin:=1;
   ValeurMax:=ln(3*MaxDim/4)/ln(2);
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.Caption:=lang('Extrait plan d''ondelettes');
if DlgStandard.ShowModal=mrOK then
   begin
   NoOnd:=Round(TabItems^[1].ValeurSortie);

   pop_image:=tpop_image.create(application);
   try
   pop_image.ImgInfos.Sx:=ImgInfos.Sx;
   pop_image.ImgInfos.Sy:=ImgInfos.Sy;

   Screen.Cursor:=crHourGlass;
   try
   ExtractPlanOndelette(DataInt,DataDouble,pop_image.DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,
                        ImgInfos.Sx,ImgInfos.Sy,NoOnd);
   finally
   Screen.Cursor:=crDefault;
   end;

   pop_image.ImgInfos.NbPlans:=ImgInfos.NbPlans;

   case ImgInfos.Typedata of
      2,5:pop_image.ImgInfos.Typedata:=5;
      7,8:pop_image.ImgInfos.Typedata:=8;
      end;

   pop_image.AjusteFenetre;   
   pop_image.VisuAutoEtoiles;
   pop_image.Caption:=pop_main.GiveName(Caption+lang(' {plan')+IntToStr(NoOnd)+'}',pop_image);

   except
   pop_image.Free;
   end;

   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;

end;

// Retourne la largeur Maximum que peut prendre la fenetre d'affichage de l'image
function Tpop_image.GetLargeurMaxWindow:Integer;
var
   XBorder:Integer;
begin
   XBorder:=GetSystemMetrics(SM_CXBORDER);
   Result:=pop_main.ClientWidth-2*XBorder-5;
end;

// Retourne la hauteur Maximum que peut prendre la fenetre d'affichage de l'image
function Tpop_image.GetHauteurMaxWindow:Integer;
var
   YBorder:Integer;
begin
   YBorder:=GetSystemMetrics(SM_CYBORDER);
   Result:=pop_main.ClientHeight-pop_main.Toolbar1.Height-pop_main.Toolbar2.Height-
      pop_main.StatusBar1.Height-2*YBorder-5;
end;

// Calcul automatique la largeur de la fenetre
procedure Tpop_image.AjusteFenetre;
var
XBorder,YBorder,YCaption,LargeurDemande,HauteurDemande,LargeurMax,HauteurMax:Integer;
begin
   AjustageEnCours:=True;
   try

//   SizeScrollBar:=GetImgInfos.SystemMetrics(SM_CYHSCROLL);

   XBorder:=GetSystemMetrics(SM_CXBORDER);
   YBorder:=GetSystemMetrics(SM_CYBORDER);
   YCaption:=GetSystemMetrics(SM_CYCAPTION);
   WindowState:=wsNormal;
   HauteurDemande:=Round(ImgInfos.Sy*ZoomFactor+2*YBorder+YCaption+6);
   LargeurDemande:=Round(ImgInfos.Sx*ZoomFactor+2*XBorder+6);
   HauteurMax:=pop_main.ClientHeight-pop_main.Toolbar1.Height-pop_main.Toolbar2.Height-
      pop_main.StatusBar1.Height-2*YBorder-5;
   LargeurMax:=pop_main.ClientWidth-2*XBorder-5;

   if (LargeurDemande>=LargeurMax) and
      (HauteurDemande>=HauteurMax) then
      begin
      Height:=HauteurMax;
      Width:=LargeurMax;
      end;
   if (LargeurDemande<LargeurMax) and
      (HauteurDemande<HauteurMax) then
      begin
      Height:=HauteurDemande;
      Width:=LargeurDemande;
      HorizScrollBar.Visible:=False;
      VerticScrollBar.Visible:=False;
      end;
   if (LargeurDemande>=LargeurMax) and
      (HauteurDemande<HauteurMax) then
      begin
      Left:=0;
      Height:=HauteurDemande;
      Width:=LargeurMax;
      end;
   if (LargeurDemande<LargeurMax) and
      (HauteurDemande>=HauteurMax) then
      begin
      Top:=0;
      Height:=HauteurMax;
      Width:=LargeurDemande;
      end;

   AjusteScrollbars(True);

   finally
   AjustageEnCours:=False;
   end;
end;

// Mise en position des scrollbars
// CanResize:=false quand l'utilisateur a choisi explicitement la taille de la fenetre (OnResize)
// CanResize:=True quand le programme affiche lui meme la fenetre (AjusteFenetre)
procedure Tpop_image.AjusteScrollbars(CanResize:Boolean);
var
   XBorder,YBorder,YCaption,LargeurDemande,HauteurDemande,LargeurMax,HauteurMax:Integer;
   HauteurWindowMax,LargeurWindowMax:Integer;
begin
   AjustageEnCours:=True;
   try

   XBorder:=GetSystemMetrics(SM_CXBORDER);
   YBorder:=GetSystemMetrics(SM_CYBORDER);
   YCaption:=GetSystemMetrics(SM_CYCAPTION);
//   HauteurDemande:=Round(ImgInfos.Sy*ZoomFactor+2*YBorder+YCaption+6);
//   LargeurDemande:=Round(ImgInfos.Sx*ZoomFactor+2*XBorder+6);
   HauteurWindowMax:=pop_main.ClientHeight-pop_main.Toolbar1.Height-pop_main.Toolbar2.Height
      -pop_main.StatusBar1.Height-2*YBorder-6;
   LargeurWindowMax:=pop_main.ClientWidth-2*XBorder-6;

//   HauteurDemande:=Round(ImgInfos.Sy*ZoomFactor);
//   LargeurDemande:=Round(ImgInfos.Sx*ZoomFactor);
   HauteurDemande:=Trunc(ImgInfos.Sy*ZoomFactor);
   LargeurDemande:=Trunc(ImgInfos.Sx*ZoomFactor);
   if not(CanResize) then
      begin
      if ClientHeight>Round(ImgInfos.Sy*ZoomFactor) then Height:=Round(ImgInfos.Sy*ZoomFactor+2*XBorder+YCaption+6);
      if ClientWidth >Round(ImgInfos.Sx*ZoomFactor) then Width :=Round(ImgInfos.Sx*ZoomFactor+2*XBorder+6);
      end;
   HauteurMax:=ClientHeight;
   LargeurMax:=ClientWidth;

   HorizScrollBar.Visible:=False;
   VerticScrollBar.Visible:=False;

   if (LargeurDemande>LargeurMax) and
      (HauteurDemande>HauteurMax) then
      begin
      VerticScrollBar.Left:=ClientWidth-15; //16
      VerticScrollBar.Top:=0;
      VerticScrollBar.Height:=ClientHeight-16;
      VerticScrollBar.Visible:=True;
      HorizScrollBar.Left:=0;
      HorizScrollBar.Top:=ClientHeight-15; //16
      HorizScrollBar.Width:=ClientWidth-16;
      HorizScrollBar.Visible:=True;
      end;
   if (LargeurDemande<=LargeurMax) and
      (HauteurDemande<=HauteurMax) then
      begin
      HorizScrollBar.Visible:=False;
      VerticScrollBar.Visible:=False;
      end;
   if (LargeurDemande>LargeurMax) and
      (HauteurDemande<=HauteurMax) then
      begin
      if HorizScrollBar.Visible=False then
         begin
         HorizScrollBar.Left:=0;
         HorizScrollBar.Width:=ClientWidth;
         HorizScrollBar.Visible:=True;
         // On affiche la scrollbar horizontale
         // On essaye d'agrandir la hauteur si possible
         // Si possible on agrandit la hauteur sans afficher le scrollbar vertical
         if Height+16<=HauteurWindowMax then Height:=Height+16
         // Sinon on agrandi au maxi et on affiche le scrollbar vertical
         else
            begin
            Height:=HauteurWindowMax;
            VerticScrollBar.Top:=0;
            VerticScrollBar.Left:=ClientWidth-16; //16
            VerticScrollBar.Height:=ClientHeight;
            VerticScrollBar.Visible:=True;
            end;
        end;
      HorizScrollBar.Top:=ClientHeight-16; //16
      end;
   if (LargeurDemande<=LargeurMax) and
      (HauteurDemande>HauteurMax) then
      begin
      if VerticScrollBar.Visible=False then
         begin
         VerticScrollBar.Top:=0;
         VerticScrollBar.Height:=ClientHeight;
         VerticScrollBar.Visible:=True;
         // On affiche la scrollbar verticale
         // Donc on essaye d'agrandir la largeur si possible
         // Si possible on agrandit la largeur sans afficher le scrollbar horizontal
         if Width+16<=LargeurWindowMax then Width:=Width+16
         // Sinon on agrandi au maxi et on affiche le scrollbar horizontal
         else
            begin
            Width:=LargeurWindowMax;
            HorizScrollBar.Left:=0;
            HorizScrollBar.Top:=ClientHeight-16;
            HorizScrollBar.Width:=ClientWidth;
            HorizScrollBar.Visible:=True;
            end;
         end;
      VerticScrollBar.Left:=ClientWidth-16; //16
      end;

   AjusteImage;

   finally
   AjustageEnCours:=False;
   end;
end;

// Mise en position de l'image
procedure Tpop_image.AjusteImage;
begin
img_box.Left:=0;
img_box.Top:=0;

img_box.Stretch:=False;

if VerticScrollbar.Visible then img_box.Width:=ClientWidth-16 else img_box.Width:=ClientWidth;     //-16-1
if HorizScrollbar.Visible then img_box.Height:=ClientHeight-16 else img_box.Height:=ClientHeight;  //-16-1

if img_box.Width>ImgInfos.Sx*ZoomFactor then img_box.Width:=Round(ImgInfos.Sx*ZoomFactor);
if img_box.Height>ImgInfos.Sy*ZoomFactor then img_box.Height:=Round(ImgInfos.Sy*ZoomFactor);

img_box.Update;

VerticScrollBar.Min:=1;
if VerticScrollbar.Visible then
   begin
   VerticScrollBar.Position:=1;
   VerticScrollBar.Max:=Trunc(ImgInfos.Sy*ZoomFactor);
   VerticScrollBar.LargeChange:=img_box.Height;
   VerticScrollBar.SmallChange:=img_box.Height div 10;
   VerticScrollBar.PageSize:=img_box.Height;
   end;

HorizScrollBar.Min:=1;
if HorizScrollbar.Visible then
   begin
   HorizScrollBar.Position:=1;   
   HorizScrollBar.Max:=Trunc(ImgInfos.Sx*ZoomFactor);
   HorizScrollBar.LargeChange:=img_box.Width;
   HorizScrollBar.SmallChange:=img_box.Width div 10;
   HorizScrollBar.PageSize:=img_box.Width;
   end;
end;

procedure Tpop_image.VisuImg;
var
   XTmp,YTmp:Integer;
begin
//Img_Box.Invalidate;

// On peut depasser le max pendant le zoom arriere
if HorizScrollBar.Position>Round(ImgInfos.Sx*ZoomFactor-img_box.Width+1) then
   HorizScrollBar.Position:=Round(ImgInfos.Sx*ZoomFactor-img_box.Width+1);
if VerticScrollBar.Position>Round(ImgInfos.Sy*ZoomFactor-img_box.Height+1) then
   VerticScrollBar.Position:=Round(ImgInfos.Sy*ZoomFactor-img_box.Height+1);

img_box.Picture.Bitmap.Handle:=VisuImgAPI(DataInt,DataDouble,ImgInfos,ZoomFactor,
   Round(HorizScrollBar.Position),
   Round(ImgInfos.Sy*ZoomFactor-img_box.Height+1-VerticScrollBar.Position+1),
   Round(HorizScrollBar.Position+Img_Box.Width),
//   Round(ImgInfos.Sy*ZoomFactor-img_box.Height+1-(VerticScrollBar.Position+Img_Box.Height)+1),
   Round(ImgInfos.Sy*ZoomFactor-img_box.Height+1-VerticScrollBar.Position+Img_Box.Height+1),
   img_box.Width,img_box.Height);

img_box.Stretch:=True;

// Visu de la photometrie
if NbEtalons<>0 then VisuPhotometrie;
if NbAstrom<>0 then VisuAstrometrie;

// Cible centrale sur l'image pour le centrage d'étoiles
if Affichecible1.Checked then
   begin
   Img_Box.Canvas.Pen.Color:=ClRed;
   Img_Box.Canvas.Pen.Style:=PsSolid;
//   Img_Box.Canvas.Pen.Mode:=PmXor;
   Img_Box.Canvas.Brush.Style:=bsClear;
   Img_Box.Canvas.MoveTo(Img_Box.Width div 2,0);
   Img_Box.Canvas.LineTo(Img_Box.Width div 2,Img_Box.Height);
   Img_Box.Canvas.MoveTo(0,Img_Box.Height div 2);
   Img_Box.Canvas.LineTo(Img_Box.Width,Img_Box.Height div 2);
   Img_Box.Canvas.Ellipse(Img_Box.Width div 2-10,Img_Box.Height div 2-10,Img_Box.Width div 2+10,Img_Box.Height div 2+10);
   Img_Box.Canvas.Ellipse(Img_Box.Width div 2-20,Img_Box.Height div 2-20,Img_Box.Width div 2+20,Img_Box.Height div 2+20);
   end;

// Cible centrale sur l'image pour le centrage d'étoiles
if AjouterMarque1.Checked then
   begin
   XTmp:=XMarque;
   YTmp:=YMarque;
   ImageToEcran(XTmp,YTmp);
   Img_Box.Canvas.Pen.Color:=ClRed;
   Img_Box.Canvas.Pen.Style:=PsSolid;
//   Img_Box.Canvas.Pen.Mode:=PmXor;
   Img_Box.Canvas.Brush.Style:=bsClear;
   Img_Box.Canvas.MoveTo(XTmp,YTmp-10);
   Img_Box.Canvas.LineTo(XTmp,YTmp+10);
   Img_Box.Canvas.MoveTo(XTmp-10,YTmp);
   Img_Box.Canvas.LineTo(XTmp+10,YTmp);
   Img_Box.Canvas.Ellipse(XTmp-5,YTmp-5,XTmp+5,YTmp+5);
   end;

MiseAJourSeuils;
end;

procedure Tpop_image.VisuHighLight(MinH,MaxH:Double);
begin
img_box.Picture.Bitmap.Handle:=VisuImgHighLight(DataInt,DataDouble,ImgInfos.TypeData,
   ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,
   ImgInfos.Min,ImgInfos.Max,MinH,MaxH,ZoomFactor,
   Round(HorizScrollBar.Position),
   Round(ImgInfos.Sy*ZoomFactor-img_box.Height+1-VerticScrollBar.Position+1),
   Round(HorizScrollBar.Position+Img_Box.Width),
   Round(ImgInfos.Sy*ZoomFactor-img_box.Height+1-(VerticScrollBar.Position+Img_Box.Height)+1),
   img_box.Width,img_box.Height);

MiseAJourSeuils;
end;

procedure Tpop_image.AjusteMinMaxSeuils(NoPlans:Byte;SeuilBas,SeuilHaut:Double);
var
   ValBas,ValHaut:Double;
begin
case NoPlans of
   1:begin
     ValBas:=SeuilBas;
     ValHaut:=SeuilHaut;

     if pop_seuils<>nil then
        begin
        if ValHaut>pop_seuils.ScrollBarSh.Max then pop_seuils.ScrollBarSh.Max:=Round(ValHaut);
        if ValHaut>pop_seuils.ScrollBarSb.Max then pop_seuils.ScrollBarSb.Max:=Round(ValHaut);
        if ValHaut<pop_seuils.ScrollBarSh.Min then pop_seuils.ScrollBarSh.Min:=Round(ValHaut);
        if ValHaut<pop_seuils.ScrollBarSb.Min then pop_seuils.ScrollBarSb.Min:=Round(ValHaut);
        if ValBas<pop_seuils.ScrollBarSh.Min  then pop_seuils.ScrollBarSh.Min:=Round(ValBas);
        if ValBas<pop_seuils.ScrollBarSb.Min  then pop_seuils.ScrollBarSb.Min:=Round(ValBas);
        if ValBas>pop_seuils.ScrollBarSh.Max  then pop_seuils.ScrollBarSh.Max:=Round(ValBas);
        if ValBas>pop_seuils.ScrollBarSb.Max  then pop_seuils.ScrollBarSb.Max:=Round(ValBas);

        pop_seuils.ScrollBarsh.Position:=Round(ValHaut);
        pop_seuils.ScrollBarsb.Position:=Round(ValBas);
        pop_seuils.Editsh.text:=IntToStr(pop_seuils.ScrollBarsh.Position);
        pop_seuils.Editsb.text:=IntToStr(pop_seuils.ScrollBarsb.Position);
        end;

     if pop_seuils_color<>nil then
        begin
        pop_seuils_color.ScrollBarsh.Position:=Round(ValHaut);
        pop_seuils_color.ScrollBarsb.Position:=Round(ValBas);
        pop_seuils_color.Editsh.text:=IntToStr(pop_seuils_color.ScrollBarsh.Position);
        pop_seuils_color.Editsb.text:=IntToStr(pop_seuils_color.ScrollBarsb.Position);
        end;
     end;
   2:begin
     ValBas:=SeuilBas;
     ValHaut:=SeuilHaut;
     if pop_seuils_color<>nil then
        begin
        if ValHaut>pop_seuils_color.ScrollBar2.Max then pop_seuils_color.ScrollBar2.Max:=Round(ValHaut);
        if ValHaut>pop_seuils_color.ScrollBar1.Max then pop_seuils_color.ScrollBar1.Max:=Round(ValHaut);
        if ValHaut<pop_seuils_color.ScrollBar2.Min then pop_seuils_color.ScrollBar2.Min:=Round(ValHaut);
        if ValHaut<pop_seuils_color.ScrollBar1.Min then pop_seuils_color.ScrollBar1.Min:=Round(ValHaut);
        if ValBas<pop_seuils_color.ScrollBar2.Min then pop_seuils_color.ScrollBar2.Min:=Round(ValBas);
        if ValBas<pop_seuils_color.ScrollBar1.Min then pop_seuils_color.ScrollBar1.Min:=Round(ValBas);
        if ValBas>pop_seuils_color.ScrollBar2.Max then pop_seuils_color.ScrollBar2.Max:=Round(ValBas);
        if ValBas>pop_seuils_color.ScrollBar1.Max then pop_seuils_color.ScrollBar1.Max:=Round(ValBas);
        pop_seuils_color.ScrollBar2.Position:=Round(ValHaut);
        pop_seuils_color.ScrollBar1.Position:=Round(ValBas);
        pop_seuils_color.Edit1.text:=IntToStr(pop_seuils_color.ScrollBar2.Position);
        pop_seuils_color.Edit2.text:=IntToStr(pop_seuils_color.ScrollBar1.Position);
        end;
     end;
   3:begin
     ValBas:=SeuilBas;
     ValHaut:=SeuilHaut;
     if pop_seuils_color<>nil then
        begin
        if ValHaut>pop_seuils_color.ScrollBar4.Max then pop_seuils_color.ScrollBar4.Max:=Round(ValHaut);
        if ValHaut>pop_seuils_color.ScrollBar3.Max then pop_seuils_color.ScrollBar3.Max:=Round(ValHaut);
        if ValHaut<pop_seuils_color.ScrollBar4.Min then pop_seuils_color.ScrollBar4.Min:=Round(ValHaut);
        if ValHaut<pop_seuils_color.ScrollBar3.Min then pop_seuils_color.ScrollBar3.Min:=Round(ValHaut);
        if ValBas<pop_seuils_color.ScrollBar4.Min then pop_seuils_color.ScrollBar4.Min:=Round(ValBas);
        if ValBas<pop_seuils_color.ScrollBar3.Min then pop_seuils_color.ScrollBar3.Min:=Round(ValBas);
        if ValBas>pop_seuils_color.ScrollBar4.Max then pop_seuils_color.ScrollBar4.Max:=Round(ValBas);
        if ValBas>pop_seuils_color.ScrollBar3.Max then pop_seuils_color.ScrollBar3.Max:=Round(ValBas);
        pop_seuils_color.ScrollBar4.Position:=Round(ValHaut);
        pop_seuils_color.ScrollBar3.Position:=Round(ValBas);
        pop_seuils_color.Edit3.text:=IntToStr(pop_seuils_color.ScrollBar4.Position);
        pop_seuils_color.Edit4.text:=IntToStr(pop_seuils_color.ScrollBar3.Position);
        end;
     end;
   end;

end;

{ On met a jour les seuils }
procedure Tpop_image.MiseAJourSeuils;
var
   ValMax,ValMin:Double;
begin
case ImgInfos.Typedata of
    2,5,6:AjusteMinMaxSeuils(1,ImgInfos.Min[1],ImgInfos.Max[1]);
    7:begin
      AjusteMinMaxSeuils(1,ImgInfos.Min[1],ImgInfos.Max[1]);
      AjusteMinMaxSeuils(2,ImgInfos.Min[2],ImgInfos.Max[2]);
      AjusteMinMaxSeuils(3,ImgInfos.Min[3],ImgInfos.Max[3]);
      end;
    end;
end;

procedure Tpop_image.FormResize(Sender: TObject);
begin
if not(AjustageEnCours) then
   begin
   AjusteScrollbars(False);
   VisuImg;
   end;
end;

procedure Tpop_image.VisuAutoEtoiles;
var
SB1,SH1,SB2,SH2,SB3,SH3:Double;
ValBas,ValHaut:Double;
Mini,mediane,Maxi,Moy,Ecart:Double;
begin
case ImgInfos.Typedata of
   2,5,6:begin
         case Config.TypeSeuil of
            0:begin
              RechercheSeuilsVisu(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,config.SeuilBasPourCent,
                 config.SeuilHautPourCent,SB1,SH1);
              end;
            1:begin
              StatistiquesVisu(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,Mini,mediane,Maxi,Moy,Ecart);
              SB1:=Mediane+Config.MultBas*Ecart;
              SH1:=Mediane+Config.MultHaut*Ecart;
              end;
            end;

         if SB1=SH1 then
            begin
            SB1:=SB1-1;
            SH1:=SH1+1;
            end;

         ImgInfos.Min[1]:=SB1;
         ImgInfos.Max[1]:=SH1;

         AjusteMinMaxSeuils(1,SB1,SH1);
         end;
 7,8:begin
     case Config.TypeSeuil of
        0:begin
        RechercheSeuilsVisu(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,config.SeuilBasPourCent,
           config.SeuilHautPourCent,SB1,SH1);
        end;
        1:begin
          StatistiquesVisu(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,Mini,mediane,Maxi,Moy,Ecart);
          SB1:=Mediane+Config.MultBas*Ecart;
          SH1:=Mediane+Config.MultHaut*Ecart;
          end;
        end;

     if SB1=SH1 then
        begin
        SB1:=SB1-1;
        SH1:=SH1+1;
        end;

     ImgInfos.min[1]:=SB1;
     ImgInfos.max[1]:=SH1;

     AjusteMinMaxSeuils(1,SB1,SH1);

     case Config.TypeSeuil of
        0:begin
        RechercheSeuilsVisu(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,config.SeuilBasPourCent,
           config.SeuilHautPourCent,SB2,SH2);
        end;
        1:begin
          StatistiquesVisu(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,Mini,mediane,Maxi,Moy,Ecart);
          SB2:=Mediane+Config.MultBas*Ecart;
          SH2:=Mediane+Config.MultHaut*Ecart;
          end;
        end;

     if SB2=SH2 then
        begin
        SB2:=SB2-1;
        SH2:=SH2+1;
        end;

     ImgInfos.min[2]:=SB2;
     ImgInfos.max[2]:=SH2;

     AjusteMinMaxSeuils(2,SB2,SH2);

     case Config.TypeSeuil of
        0:begin
        RechercheSeuilsVisu(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,config.SeuilBasPourCent,
           config.SeuilHautPourCent,SB3,SH3);
        end;
        1:begin
          StatistiquesVisu(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,Mini,mediane,Maxi,Moy,Ecart);
          SB3:=Mediane+Config.MultBas*Ecart;
          SH3:=Mediane+Config.MultHaut*Ecart;
          end;
        end;

     if SB3=SH3 then
        begin
        SB3:=SB3-1;
        SH3:=SH3+1;
        end;

     ImgInfos.min[3]:=SB3;
     ImgInfos.max[3]:=SH3;

     AjusteMinMaxSeuils(3,SB3,SH3);
     end;
   end;

//AjusteFenetre;
VisuImg;
end;

procedure Tpop_image.VisuAutoEtoilesPlan(i:Integer);
var
SB,SH,ValBas,ValHaut:Double;
Mini,mediane,Maxi,Moy,Ecart:Double;
begin
case ImgInfos.Typedata of
   7,8:begin
     case Config.TypeSeuil of
        0:begin
        RechercheSeuilsVisu(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,config.SeuilBasPourCent,
           config.SeuilHautPourCent,SB,SH);
        end;
        1:begin
          StatistiquesVisu(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,Mini,mediane,Maxi,Moy,Ecart);
          SB:=Mediane+Config.MultBas*Ecart;
          SH:=Mediane+Config.MultHaut*Ecart;
          end;
        end;

     if SB=SH then
        begin
        SB:=SB-1;
        SH:=SH+1;
        end;

     ImgInfos.min[i]:=SB;
     ImgInfos.max[i]:=SH;

     AjusteMinMaxSeuils(1,SB,SH);

     //AjusteFenetre;
     VisuImg;

     AjusteMinMaxSeuils(i,SB,SH);
     end;
   end;

end;

procedure Tpop_image.VisuMiniMaxi(Mini,Maxi: double);
begin
if Mini=Maxi then
   begin
   Mini:=Mini-1;
   Maxi:=Maxi+1;
   end;

case ImgInfos.Typedata of
   2,5,6:begin
         ImgInfos.min[1]:=Mini;
         ImgInfos.max[1]:=Maxi;

         AjusteMinMaxSeuils(1,Mini,Maxi);
         end;
   7,8:begin
       ImgInfos.min[1]:=Mini;
       ImgInfos.max[1]:=Maxi;
       ImgInfos.min[2]:=Mini;
       ImgInfos.max[2]:=Maxi;
       ImgInfos.min[3]:=Mini;
       ImgInfos.max[3]:=Maxi;

       AjusteMinMaxSeuils(1,Mini,Maxi);
       AjusteMinMaxSeuils(2,Mini,Maxi);
       AjusteMinMaxSeuils(3,Mini,Maxi);
       end;
   end;

//AjusteFenetre;
VisuImg;


end;

procedure Tpop_image.VisuAutoMinMax;
var
Maxi,Mini,max,min,Mediane,Moy,Ecart:Double;
begin
case ImgInfos.Typedata of
   2,5,6:begin
         Statistiques(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,Mini,mediane,Maxi,Moy,Ecart);
         end;
   7,8:begin
     Mini:=32767;
     Maxi:=0;
     Statistiques(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,Min,mediane,Max,Moy,Ecart);
     Mini:=minvalue([Mini,min]);  Maxi:=maxvalue([Maxi,max]);
     Statistiques(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,2,Min,mediane,Max,Moy,Ecart);
     Mini:=minvalue([Mini,min]);  Maxi:=maxvalue([Maxi,max]);
     Statistiques(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,3,Min,mediane,Max,Moy,Ecart);
     Mini:=minvalue([Mini,min]);  Maxi:=maxvalue([Maxi,max]);
     end;
end;

VisuMiniMaxi(Mini,Maxi);
end;

procedure Tpop_image.VisuMinMaxPlane(Plane:Byte;Mini,Maxi:Single);
begin
if Mini=Maxi then
   begin
   Mini:=Mini-1;
   Maxi:=Maxi+1;
   end;

case ImgInfos.Typedata of
   7,8:begin
     ImgInfos.min[Plane]:=Mini;
     ImgInfos.max[Plane]:=Maxi;
     end;
   end;

//AjusteFenetre;
VisuImg;

AjusteMinMaxSeuils(Plane,Mini,Maxi);
end;

procedure Tpop_image.VisuAutoPlanetes;
var
Mini,mediane,Maxi,Moy,Ecart:Double;
begin
case ImgInfos.Typedata of
   2,5,6:begin
         Statistiques(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,Mini,mediane,Maxi,Moy,Ecart);

         if Mediane=Maxi then
            begin
            Mediane:=Mediane-1;
            Maxi:=Maxi+1;
            end;

         ImgInfos.min[1]:=Mediane;
         ImgInfos.max[1]:=Maxi;

         AjusteMinMaxSeuils(1,Mediane,Maxi);
         end;
   7,8:begin
     Statistiques(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,Mini,mediane,Maxi,Moy,Ecart);

     if Mediane=Maxi then
        begin
        Mediane:=Mediane-1;
        Maxi:=Maxi+1;
        end;

     ImgInfos.min[1]:=Mediane;
     ImgInfos.max[1]:=Maxi;

     AjusteMinMaxSeuils(1,Mediane,Maxi);

     Statistiques(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,2,Mini,mediane,Maxi,Moy,Ecart);

     if Mediane=Maxi then
        begin
        Mediane:=Mediane-1;
        Maxi:=Maxi+1;
        end;

     ImgInfos.min[2]:=Mediane;
     ImgInfos.max[2]:=Maxi;

     AjusteMinMaxSeuils(2,Mediane,Maxi);

     Statistiques(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,3,Mini,mediane,Maxi,Moy,Ecart);

     if Mediane=Maxi then
        begin
        Mediane:=Mediane-1;
        Maxi:=Maxi+1;
        end;

     ImgInfos.min[3]:=Mediane;
     ImgInfos.max[3]:=Maxi;

     AjusteMinMaxSeuils(3,Mediane,Maxi);
     end;
   end;

//AjusteFenetre;
VisuImg;
end;

procedure Tpop_image.VisuAutoPlanetesPlan(i:Integer);
var
Mini,mediane,Maxi,Moy,Ecart:Double;
begin
//case ImgInfos.Typedata of
//   7:begin
     Statistiques(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,i,Mini,mediane,Maxi,Moy,Ecart);
     ImgInfos.min[i]:=Mediane;
     ImgInfos.max[i]:=Maxi;
//     end;
//   end;

//AjusteFenetre;
VisuImg;

AjusteMinMaxSeuils(i,Mediane,Maxi);
end;

procedure Tpop_image.FormActivate(Sender: TObject);
begin
{ La derniere fenetre  est celle ci }
if pop_main.ActiveMDIChild is tpop_image then
   pop_main.LastChild:=(pop_main.ActiveMDIChild as tpop_image);

MiseAjourSeuils;
ChangerMenu;
pop_main.MiseAJourMenu(Sender);
end;

function Tpop_image.ReadImage(FileName:string):Boolean;
begin
Result:=True;
if not FileExists(FileName) then
   begin
   Result:=False;
   Exit;
   end;

ImgInfos.Typedata:=2; // Par defaut c'est des entiers
ImgInfos.NbPlans:=1;  // Par defaut un seul plan

MagnitudeMesuree:=False;
ReinitialisePhotometrie;
AstrometrieCalibree:=False;
ReinitialiseAstrometrie;

ReadImageGenerique(FileName,DataInt,DataDouble,ImgInfos);
ImgInfos.FileName:=FileName;
Caption:=pop_main.GiveName(ExtractFileName(Filename),Self);

// Au debut on position tout a 1
VerticScrollBar.Position:=1;
HorizScrollBar.Position:=1;

AjusteFenetre;
VisuImg;

MiseAJourSeuils;
ChangerMenu;
pop_main.MiseAJourMenu(nil);
end;

procedure Tpop_image.SaveImage(FileName:string);
begin
Screen.Cursor:=crHourGlass;
try
SaveImageGenerique(FileName,DataInt,DataDouble,ImgInfos);
ChangerMenu;
pop_main.MiseAJourMenu(Self);
finally
Screen.Cursor:=crDefault;
end;
end;

procedure Tpop_image.Redimensioner1Click(Sender: TObject);
begin
Screen.Cursor:=crHourGlass;
try
AjusteFenetre;
VisuImg;
finally
Screen.Cursor:=crDefault;
end;
end;

procedure Tpop_image.Ajouterconstante1Click(Sender: TObject);
var
Valeur:string;
ValSingle:Single;
i:Integer;
begin
Valeur:='1000'; //nolang
if MyInputQuery(lang('Ajouter un offset'),
   lang('Valeur de l''offset :'),Valeur) then
   begin
   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   Offset(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,StrToInt(Valeur));
   for i:=1 to ImgInfos.NbPlans do
      begin
      ValSingle:=ImgInfos.Max[i]+StrToInt(Valeur);
      if ValSingle>32767 then ValSingle:=32767;
      if ValSingle<-32768 then ValSingle:=-32768;
      ImgInfos.Max[i]:=Round(ValSingle);
      end;
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;
   end;
end;

procedure Tpop_image.Multiplierconstante1Click(Sender: TObject);
var
Valeur:string;
ValSingle:Single;
i:Integer;
begin
Valeur:='0.5'; //nolang
if MyInputQuery(lang('Multiplier par une constante'),
   lang('Valeur du gain :'),Valeur) then
   begin
   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   Gain(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,MyStrToFloat(Valeur));
   for i:=1 to ImgInfos.NbPlans do
      begin
      ValSingle:=Round(ImgInfos.Max[i]*MyStrToFloat(Valeur));
      if ValSingle>32767 then ValSingle:=32767;
      if ValSingle<-32768 then ValSingle:=-32768;
      ImgInfos.Max[i]:=Round(ValSingle);
      ValSingle:=Round(ImgInfos.Min[i]*MyStrToFloat(Valeur));
      if ValSingle>32767 then ValSingle:=32767;
      if ValSingle<-32768 then ValSingle:=-32768;
      ImgInfos.Min[i]:=Round(ValSingle);
      end;
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;
   end;
end;

procedure Tpop_image.AjouterImage1Click(Sender: TObject);
var
pop_select_img:Tpop_select_img;
ValSingle:Single;
i:Integer;
begin
pop_select_img:=Tpop_select_img.Create(Application);
try
pop_select_img.LabelImgCourante.Caption:=lang('Image courante : ')+Caption;
pop_select_img.LabelQuestion.Caption:=lang('Sélectionnez l''image à ajouter');
if (pop_select_img.ShowModal=mrOK) and (pop_select_img.image_selectionnee<>nil) then
   begin
   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   Add(DataInt,pop_select_img.image_selectionnee.DataInt,
       DataDouble,pop_select_img.image_selectionnee.DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,
       ImgInfos.Sx,ImgInfos.Sy,pop_select_img.image_selectionnee.ImgInfos.Sx,
       pop_select_img.image_selectionnee.ImgInfos.Sy);
   for i:=1 to ImgInfos.NbPlans do
      begin
      ValSingle:=ImgInfos.max[i]+pop_select_img.image_selectionnee.ImgInfos.max[i];
      if ValSingle>32767 then ValSingle:=32767;
      if ValSingle<-32768 then ValSingle:=-32768;
      ImgInfos.Max[i]:=Round(ValSingle);
      ValSingle:=ImgInfos.min[i]+pop_select_img.image_selectionnee.ImgInfos.min[i];
      if ValSingle>32767 then ValSingle:=32767;
      if ValSingle<-32768 then ValSingle:=-32768;
      ImgInfos.Min[i]:=Round(ValSingle);
      end;
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;
   end;
finally
pop_select_img.Free;
end;
end;

procedure Tpop_image.SoustraireImage1Click(Sender: TObject);
var
pop_select_img:Tpop_select_img;
ValSingle:Single;
i:Integer;
begin
pop_select_img:=Tpop_select_img.Create(Application);
try
pop_select_img.LabelImgCourante.Caption:=lang('Image courante : ')+Caption;
pop_select_img.LabelQuestion.Caption:=lang('Sélectionnez l''image à soustraire');
if pop_select_img.ShowModal=mrOK then
   begin
   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   Soust(DataInt,pop_select_img.image_selectionnee.DataInt,
       DataDouble,pop_select_img.image_selectionnee.DataDouble,
       ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,pop_select_img.image_selectionnee.ImgInfos.Sx,
       pop_select_img.image_selectionnee.ImgInfos.Sy);
   for i:=1 to ImgInfos.NbPlans do
      begin
      ValSingle:=ImgInfos.max[i]+pop_select_img.image_selectionnee.ImgInfos.max[i];
      if ValSingle>32767 then ValSingle:=32767;
      if ValSingle<-32768 then ValSingle:=-32768;
      ImgInfos.Max[i]:=Round(ValSingle);
      ValSingle:=ImgInfos.min[i]+pop_select_img.image_selectionnee.ImgInfos.min[i];
      if ValSingle>32767 then ValSingle:=32767;
      if ValSingle<-32768 then ValSingle:=-32768;
      ImgInfos.Min[i]:=Round(ValSingle);
      end;
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;
   end;
finally
pop_select_img.Free;
end;
end;

procedure Tpop_image.Muli1Click(Sender: TObject);
var
pop_select_img:Tpop_select_img;
ValSingle:Single;
ValMult:string;
begin
pop_select_img:=Tpop_select_img.Create(Application);
try
pop_select_img.LabelImgCourante.Caption:=lang('Image courante : ')+Caption;
pop_select_img.LabelQuestion.Caption:=lang('Sélectionnez l''image à multiplier');
if pop_select_img.ShowModal=mrOK then
   begin
   ValMult:='1';
   if MyInputQuery(lang('Valeur du diviseur'),
      lang('Valeur du diviseur :'),ValMult) then
      begin
      Screen.Cursor:=crHourGlass;
      try
      SaveUndo;
      Mult(DataInt,pop_select_img.image_selectionnee.DataInt,
           DataDouble,pop_select_img.image_selectionnee.DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,
           ImgInfos.Sx,ImgInfos.Sy,pop_select_img.image_selectionnee.ImgInfos.Sx,
           pop_select_img.image_selectionnee.ImgInfos.Sy,MyStrToFloat(ValMult));
      ValSingle:=ImgInfos.max[1]+pop_select_img.image_selectionnee.ImgInfos.max[1];
      if ValSingle>32767 then ValSingle:=32767;
      if ValSingle<-32768 then ValSingle:=-32768;
      ImgInfos.Max[1]:=Round(ValSingle);
      ValSingle:=ImgInfos.min[1]+pop_select_img.image_selectionnee.ImgInfos.min[1];
      if ValSingle>32767 then ValSingle:=32767;
      if ValSingle<-32768 then ValSingle:=-32768;
      ImgInfos.Min[1]:=Round(ValSingle);
      VisuImg;
      finally
      Screen.Cursor:=crDefault;
      end;
      end;
   end;
finally
pop_select_img.Free;
end;
end;

procedure Tpop_image.DiviserImage1Click(Sender: TObject);
var
pop_select_img:Tpop_select_img;
ValSingle:Single;
ValDiv:string;
begin
pop_select_img:=Tpop_select_img.Create(Application);
try
pop_select_img.LabelImgCourante.Caption:=lang('Image courante : ')+Caption;
pop_select_img.LabelQuestion.Caption:=lang('Sélectionnez l''image diviseur');
if pop_select_img.ShowModal=mrOK then
   begin
   ValDiv:='1';
   if MyInputQuery(lang('Valeur du gain'),
      lang('Valeur du gain :'),ValDiv) then
      begin
      Screen.Cursor:=crHourGlass;
      try
      SaveUndo;
      Divi(DataInt,pop_select_img.image_selectionnee.DataInt,
           DataDouble,pop_select_img.image_selectionnee.DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,
           ImgInfos.Sx,ImgInfos.Sy,pop_select_img.image_selectionnee.ImgInfos.Sx,
           pop_select_img.image_selectionnee.ImgInfos.Sy,MyStrToFloat(ValDiv));
      ValSingle:=ImgInfos.max[1]+pop_select_img.image_selectionnee.ImgInfos.max[1];
      if ValSingle>32767 then ValSingle:=32767;
      if ValSingle<-32768 then ValSingle:=-32768;
      ImgInfos.Max[1]:=Round(ValSingle);
      ValSingle:=ImgInfos.min[1]+pop_select_img.image_selectionnee.ImgInfos.min[1];
      if ValSingle>32767 then ValSingle:=32767;
      if ValSingle<-32768 then ValSingle:=-32768;
      ImgInfos.Min[1]:=Round(ValSingle);
      VisuImg;
      finally
      Screen.Cursor:=crDefault;
      end;
      end;
   end;
finally
pop_select_img.Free;
end;
end;


procedure Tpop_image.ClipOn;
var
Rect:PRect;
Point:TPoint;
begin
New(Rect);

// On efface le curseur de la souris
ShowCursor(False);
ShowCursor(False);

// Limitation du deplacement de la souris
Point.X:=Img_Box.Left;
Point.Y:=Img_Box.Top;
Point:=ClientToScreen(Point);
Rect.Left:=Point.X;
Rect.Top:=Point.Y;

//Point.X:=ClientRect.Right;
//Point.Y:=ClientRect.Bottom;
Point.X:=Img_Box.Left+Img_Box.Width;
Point.Y:=Img_Box.Top+Img_Box.Height;
Point:=ClientToScreen(Point);
Rect.Right:=Point.X;
Rect.Bottom:=Point.Y;

ClipCursor(Rect);

// Affichage du reticule
if ((FormePointage=Reticule) or (FormePointage=Ligne)) and not ReticulePresent then
   begin
   // Placement de la souris au milieu de l'image
   ReticulePresent:=True;
//   WriteSpy('Reticule On clipon');   
   Point.X:=ClientWidth div 2;
   Point.Y:=ClientHeight div 2;
   Point:=ClientToScreen(Point);
   SetCursorPos(Point.X,Point.Y);

   Point:=Img_Box.ScreenToClient(Point);
   Img_Box.Canvas.Pen.Color:=ClWhite;
   Img_Box.Canvas.Pen.Style:=PsSolid;
   Img_Box.Canvas.Pen.Mode:=PmXor;
   Img_Box.Canvas.MoveTo(Point.X,0);
   Img_Box.Canvas.LineTo(Point.X,Img_Box.Height);
   Img_Box.Canvas.MoveTo(0,Point.Y);
   Img_Box.Canvas.LineTo(Img_Box.Width,Point.Y);
   Xinit:=Point.X;
   Yinit:=Point.Y;
   end;

// Affichage du rectangle
if FormePointage=Rectangle then
   begin
   GetCursorPos(Point);
   Point:=Img_Box.ScreenToClient(Point);
   Img_Box.Canvas.Pen.Color:=ClWhite;
   Img_Box.Canvas.Pen.Style:=PsSolid;
   Img_Box.Canvas.Pen.Mode:=PmXor;
   Img_Box.Canvas.Brush.Style:=bsClear;
   Img_Box.Canvas.Rectangle(Point.X,Point.Y,Point.X,Point.Y);
   Xinit:=Point.X;
   Yinit:=Point.Y;
   end;

// Enregistrement de la positon
OldX:=Point.X;
OldY:=Point.Y;

Dispose(Rect);
ClipIsOn:=True;
end;

procedure Tpop_image.ClipOff;
begin
// On montre le curseur de la souris
ShowCursor(True);
ShowCursor(True);
// La souris peut aller partout
ClipCursor(nil);
ClipIsOn:=False;
DeplaceALaMain:=False;
end;

procedure Tpop_image.FormCreate(Sender: TObject);
var
   Path:string;
begin
Calib1:=False;
Calib2:=False;
Calib3:=False;
Calib4:=False;
Calib5:=False;
Calib6:=False;
Calib7:=False;
Path:=ExtractFileDir(Application.ExeName);
ZoomFactor:=1;
CanUndo:=False;
TypePointage:=PointeOff;
ClipIsOn:=False;
IsUsedForAcq:=False;
IsUsedForTrack:=False;
IsUsedForWebCam:=False;
AcqRunning:=False;
AcqTrackRunning:=False;
VisuEtoile:=False;
Left:=0;
Top:=0;
HorzScrollBar.Visible:=False;
VertScrollBar.Visible:=False;
// Putain, j'y comprends rien !
// Je peux pas les cacher sinon, ca plante TeleAuto dans certains cas !!!
// Bug de la VCL ????
VerticScrollBar.Left:=-100;
HorizScrollBar.Top:=-100;
//HorizScrollBar.Visible:=False;
//VerticScrollBar.Visible:=False;
NbEtalons:=0;
MagnitudeMesuree:=False;
AstrometrieCalibree:=False;

// On cache le menu codage et le reste
if not(FileExists(Path+'\codage.txt')) then //nolang
   begin
   Ajouterunesuppression1.Visible:=False;
   end;
end;

procedure Tpop_image.outClipOff2Click(Sender: TObject);
begin
// On efface le réticule
if ((FormePointage=Reticule) or (FormePointage=Ligne)) and ReticulePresent then
   begin
//   ReticulePresent:=False;
//   WriteSpy('Reticule Off outclipoff2');
   Img_Box.Canvas.Pen.Color:=ClWhite;
   Img_Box.Canvas.Pen.Style:=PsSolid;
   Img_Box.Canvas.Pen.Mode:=PmXor;
   Img_Box.Canvas.MoveTo(OldX,0);
   Img_Box.Canvas.LineTo(OldX,Img_Box.Height);
   Img_Box.Canvas.MoveTo(0,OldY);
   Img_Box.Canvas.LineTo(Img_Box.Width,OldY);
   Img_Box.Update;   
   end;

ClipOff;
TypePointage:=PointeOff;
FormePointage:=Off;
end;

//Penser a mettre aussi a jour Tpop_image.FormKeyDown
procedure Tpop_image.img_boxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//Penser a mettre aussi a jour Tpop_image.FormKeyDown
if Button=mbRight then
   begin
   if ((FormePointage=Reticule) or (FormePointage=Ligne)) and ReticulePresent then
      begin
      // On efface le réticule
      ReticulePresent:=False;
//      WriteSpy('Reticule Off mousedown');
      Img_Box.Canvas.Pen.Color:=ClWhite;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=PmXor;
      Img_Box.Canvas.MoveTo(OldX,0);
      Img_Box.Canvas.LineTo(OldX,Img_Box.Height);
      Img_Box.Canvas.MoveTo(0,OldY);
      Img_Box.Canvas.LineTo(Img_Box.Width,OldY);
      Img_Box.Update;
      ClipOff;
      end;
   if FormePointage=Rectangle then
      begin
      // On efface le rectangle à l'ancienne position
      Img_Box.Canvas.Pen.Color:=ClWhite;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=PmXor;
      Img_Box.Canvas.Brush.Style:=bsClear;
      Img_Box.Canvas.Rectangle(Xinit,Yinit,OldX,OldY);
      Img_Box.Update;
      ClipOff;
      end;
   if FormePointage=Ligne then
      begin
      // On efface la ligne à l'ancienne position
      Img_Box.Canvas.pen.Mode:=pmXor;
      Img_Box.Canvas.MoveTo(Xinit,Yinit);
      Img_Box.Canvas.LineTo(OldX,OldY);
      end;
   TypePointage:=PointeOff;
   FormePointage:=Off;
   end;

   DeplaceALaMain:=True;
   XMain:=X;
   YMain:=Y;
//   VisuImg;
end;
//Penser a mettre aussi a jour Tpop_image.FormKeyDown

procedure Tpop_image.Etalonnage1Click(Sender: TObject);
begin
if TypePointage=PointeOff then
   begin
   TypePointage:=PointeEtalon;
   FormePointage:=Reticule;
   ClipOn;
   end;
end;

procedure Tpop_image.VisuPhotometrie;
var
   i,Xaff,Yaff:Integer;
   ax,bx,ay,by:Double;
   ax1,bx1,ay1,by1:Double;
begin
   // Passage coordonee images -> coordonnee fenetre
   ax1:=(ImgInfos.Sx-1)/(ZoomFactor*ImgInfos.Sx-ZoomFactor);
   bx1:=1-ax1;
   ay1:=(ImgInfos.Sy-1)/(ZoomFactor*ImgInfos.Sy-ZoomFactor);
   by1:=1-ay1;

   ax:=(Img_Box.Width-1)/ZoomFactor/(Img_Box.Width-1);
   bx:=ax1*Round(HorizScrollBar.Position)+bx1;
   ay:=(Img_Box.Height-1)/ZoomFactor/(Img_Box.Height-1);
   by:=ay1*Round(VerticScrollBar.Position)+by1;

   EtalonCourant:=FirstEtalon;
   for i:=1 to NbEtalons do
      begin
      Xaff:=EtalonCourant.X; //toto
      Yaff:=EtalonCourant.Y;
      ImageToEcran(Xaff,Yaff);
//      Xaff:=Round((EtalonCourant.X-bx)/ax);
//      Yaff:=Round(((ImgInfos.Sy-EtalonCourant.Y+1)-by)/ay);

      Img_Box.Canvas.Pen.Color:=ClRed;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=pmCopy;
      Img_Box.Canvas.Pen.Width:=Round(ZoomFactor);
      if Img_Box.Canvas.Pen.Width=0 then Img_Box.Canvas.Pen.Width:=1;
      Img_Box.Canvas.Brush.Style:=bsClear;

      if Config.FormeModelePhotometrie<>4 then
         Img_Box.Canvas.Ellipse(Round(Xaff+1-8*ZoomFactor),Round(Yaff+1-8*ZoomFactor),
            Round(Xaff+1+8*ZoomFactor),Round(Yaff+1+8*ZoomFactor))
      else
         begin
         Img_Box.Canvas.Ellipse(Round(Xaff-Config.ApertureInt*ZoomFactor),Round(Yaff-Config.ApertureInt*ZoomFactor),
            Round(Xaff+Config.ApertureInt*ZoomFactor),Round(Yaff+Config.ApertureInt*ZoomFactor));
         Img_Box.Canvas.Ellipse(Round(Xaff-Config.ApertureMid*ZoomFactor),Round(Yaff-Config.ApertureMid*ZoomFactor),
            Round(Xaff+Config.ApertureMid*ZoomFactor),Round(Yaff+Config.ApertureMid*ZoomFactor));
         Img_Box.Canvas.Ellipse(Round(Xaff-Config.ApertureOut*ZoomFactor),Round(Yaff-Config.ApertureOut*ZoomFactor),
            Round(Xaff+Config.ApertureOut*ZoomFactor),Round(Yaff+Config.ApertureOut*ZoomFactor));
         end;

      Img_Box.Canvas.Font.Name:='Arial'; //nolang
//      Img_Box.Canvas.Font.Size:=Round(9*ZoomFactor);
      Img_Box.Canvas.Font.Size:=9;
      if Img_Box.Canvas.Font.Size<5 then Img_Box.Canvas.Font.Size:=5;
      Img_Box.Canvas.Font.Pitch:=fpFixed;
      Img_Box.Canvas.Font.Color:=clRed;
      Img_Box.Canvas.Font.Style:=[fsBold];
      Img_Box.Canvas.TextOut(Round(Xaff+8*ZoomFactor),Round(Yaff+8*ZoomFactor),
         MyFloatToStr(EtalonCourant.Magnitude,3));
      Img_Box.Update;

      EtalonCourant:=EtalonCourant.Suivant;
      end;

   EtalonCourantSupp:=FirstEtalonSupp;
   for i:=1 to NbEtalonsSupp do
      begin
      Xaff:=EtalonCourantSupp.X; //toto
      Yaff:=EtalonCourantSupp.Y;
      ImageToEcran(Xaff,Yaff);
//      Xaff:=Round((EtalonCourantSupp.X-bx)/ax);
//      Yaff:=Round(((ImgInfos.Sy-EtalonCourantSupp.Y+1)-by)/ay);

      Img_Box.Canvas.Pen.Color:=ClBlue;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=pmCopy;
      Img_Box.Canvas.Pen.Width:=Round(ZoomFactor);
      if Img_Box.Canvas.Pen.Width=0 then Img_Box.Canvas.Pen.Width:=1;
      Img_Box.Canvas.Brush.Style:=bsClear;

      Img_Box.Canvas.Ellipse(Round(Xaff-8*ZoomFactor),Round(Yaff-8*ZoomFactor),
         Round(Xaff+8*ZoomFactor),Round(Yaff+8*ZoomFactor));

      Img_Box.Update;

      EtalonCourantSupp:=EtalonCourantSupp.Suivant;
      end;

   if MagnitudeMesuree then
      begin
      Xaff:=Etoile.X;
      Yaff:=Etoile.Y;
      ImageToEcran(Xaff,Yaff);
//      Xaff:=Round((Etoile.X-bx)/ax); //toto
//      Yaff:=Round(((ImgInfos.Sy-Etoile.Y+1)-by)/ay);

      Img_Box.Canvas.Pen.Color:=ClGreen;
      Img_Box.Canvas.Pen.Width:=Round(ZoomFactor);
      if Img_Box.Canvas.Pen.Width=0 then Img_Box.Canvas.Pen.Width:=1;

      if Config.FormeModelePhotometrie<>4 then
         Img_Box.Canvas.Ellipse(Round(Xaff+1-8*ZoomFactor),Round(Yaff+1-8*ZoomFactor),
            Round(Xaff+1+8*ZoomFactor),Round(Yaff+1+8*ZoomFactor))
      else
         begin
         Img_Box.Canvas.Ellipse(Round(Xaff-Config.ApertureInt*ZoomFactor),Round(Yaff-Config.ApertureInt*ZoomFactor),
            Round(Xaff+Config.ApertureInt*ZoomFactor),Round(Yaff+Config.ApertureInt*ZoomFactor));
         Img_Box.Canvas.Ellipse(Round(Xaff-Config.ApertureMid*ZoomFactor),Round(Yaff-Config.ApertureMid*ZoomFactor),
            Round(Xaff+Config.ApertureMid*ZoomFactor),Round(Yaff+Config.ApertureMid*ZoomFactor));
         Img_Box.Canvas.Ellipse(Round(Xaff-Config.ApertureOut*ZoomFactor),Round(Yaff-Config.ApertureOut*ZoomFactor),
            Round(Xaff+Config.ApertureOut*ZoomFactor),Round(Yaff+Config.ApertureOut*ZoomFactor));
         end;

//      Img_Box.Canvas.Ellipse(Round(Xaff-8*ZoomFactor),Round(Yaff-8*ZoomFactor),
//         Round(Xaff+8*ZoomFactor),Round(Yaff+8*ZoomFactor));

      Img_Box.Canvas.Font.Color:=clGreen;
      Img_Box.Canvas.Font.Size:=Round(9*ZoomFactor);
      if Img_Box.Canvas.Font.Size<5 then Img_Box.Canvas.Font.Size:=5;
      Img_Box.Canvas.TextOut(Round(Xaff+8*ZoomFactor),Round(Yaff+8*ZoomFactor),
         MyFloatToStr(Etoile.Magnitude,3)+'+/-'+MyFloatToStr(Etoile.ErreurMagnitude,3)); //nolang
      Img_Box.Update;

      end;
end;

procedure Tpop_image.DoEnleveEtalon(X,Y:Integer);
var
PSF:TPSF;
ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
Ximg,YImg,Larg,i:Integer;
Img:Tpop_image;
begin
Larg:=2*Config.LargModelisePhotometrie+1;

try

if (X>Config.LargModelisePhotometrie) and (X<ImgInfos.Sx-Config.LargModelisePhotometrie+1) and
   (Y>Config.LargModelisePhotometrie) and (Y<ImgInfos.Sy-Config.LargModelisePhotometrie+1) then
   begin
   Ximg:=X+1;
   Yimg:=ImgInfos.Sy-Y;

   if VisuEtoile then
      begin
      Img:=Tpop_image.Create(Application);
      GetImgPart(DataInt,DataDouble,Img.DataInt,Img.DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,
         ImgInfos.Sx,ImgInfos.Sy,Ximg-Config.LargModelisePhotometrie,Yimg-Config.LargModelisePhotometrie,
         Ximg+Config.LargModelisePhotometrie,Yimg+Config.LargModelisePhotometrie);
      Img.ImgInfos.Typedata:=ImgInfos.Typedata;
      Img.ImgInfos.Sx:=Larg;
      Img.ImgInfos.Sy:=Larg;
      Img.AjusteFenetre;
      Img.VisuAutoEtoiles;
      end;

   GetImgPart(DataInt,DataDouble,ImgInt,ImgDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,
      Ximg-Config.LargModelisePhotometrie,Yimg-Config.LargModelisePhotometrie,
      Ximg+Config.LargModelisePhotometrie,Yimg+Config.LargModelisePhotometrie);
//   ModeliseEtoile(ImgInt,ImgDouble,ImgInfos.Typedata,Larg,Config.LargModelisePhotometrie+1,
//      Config.LargModelisePhotometrie+1,config.FormeModelePhotometrie,HighPrecision,LowSelect,
//      config.DegreCielPhotometrie,PSF);
   ModeliseEtoile(ImgInt,ImgDouble,ImgInfos.Typedata,Larg,config.FormeModelePhotometrie,HighPrecision,LowSelect,
      config.DegreCielPhotometrie,PSF);

   if PSF.Flux=-1 then
      begin
      ShowMessage(lang('Erreur de modélisation'));
      Exit;
      end;

//   if PSF.Flux=-1 then
//      raise ErrorModelisation.Create(lang('Erreur de modélisation'));

   EtalonCourant:=FirstEtalon;
   for i:=1 to NbEtalons do
      begin
      if (Abs(EtalonCourant.X-Round(Ximg-Config.LargModelisePhotometrie-1+PSF.X))<2) and
         (Abs(EtalonCourant.Y-Round(Yimg-Config.LargModelisePhotometrie-1+PSF.Y))<2) then
            begin
            if EtalonCourant=FirstEtalon then
               begin
               FirstEtalon:=EtalonCourant.Suivant;
               end
            else if EtalonCourant.Suivant<>nil then
               begin
               EtalonPrecedent.Suivant:=EtalonCourant.Suivant;
               end;
            Freemem(EtalonCourant,Sizeof(TEtalon));
            Dec(NbEtalons);
            Break;
            end;
      EtalonPrecedent:=EtalonCourant;
      EtalonCourant:=EtalonCourant.Suivant;
      end;

   EtalonCourantSupp:=FirstEtalonSupp;
   for i:=1 to NbEtalonsSupp do
      begin
      if (Abs(EtalonCourantSupp.X-Round(Ximg-Config.LargModelisePhotometrie-1+PSF.X))<2) and
         (Abs(EtalonCourantSupp.Y-Round(Yimg-Config.LargModelisePhotometrie-1+PSF.Y))<2) then
            begin
            if EtalonCourantSupp=FirstEtalonSupp then
               begin
               FirstEtalonSupp:=EtalonCourantSupp.Suivant;
               end
            else if EtalonCourantSupp.Suivant<>nil then
               begin
               EtalonPrecedentSupp.Suivant:=EtalonCourantSupp.Suivant;
               end;
            Freemem(EtalonCourantSupp,Sizeof(TEtalon));
            Dec(NbEtalonsSupp);
            Break;
            end;
      EtalonPrecedentSupp:=EtalonCourantSupp;
      EtalonCourantSupp:=EtalonCourantSupp.Suivant;
      end;

   VisuImg;

   if MagnitudeMesuree then CalculPhotometrie;
   end
else
   ShowMessage(lang('Erreur de modélisation'));

finally
case ImgInfos.Typedata of
   2:begin
     for i:=1 to Larg do Freemem(ImgInt^[1]^[i],Larg*2);
     Freemem(ImgInt^[1],Larg*4);
     Freemem(ImgInt,4);
     end;
   5:begin
     for i:=1 to Larg do Freemem(ImgDouble^[1]^[i],Larg*8);
     Freemem(ImgDouble^[1],Larg*4);
     Freemem(ImgDouble,4);
     end;
   end;
end;
end;

procedure Tpop_image.DoSupprimeEtalon(X,Y:Integer);
var
PSF:TPSF;
ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
Ximg,YImg,Larg,i:Integer;
Img:Tpop_image;
begin
Larg:=2*Config.LargModelisePhotometrie+1;

try

if (X>Config.LargModelisePhotometrie) and (X<ImgInfos.Sx-Config.LargModelisePhotometrie+1) and
   (Y>Config.LargModelisePhotometrie) and (Y<ImgInfos.Sy-Config.LargModelisePhotometrie+1) then
   begin
   Ximg:=X+1;
   Yimg:=ImgInfos.Sy-Y;

   if VisuEtoile then
      begin
      Img:=Tpop_image.Create(Application);
      GetImgPart(DataInt,DataDouble,Img.DataInt,Img.DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,
         ImgInfos.Sx,ImgInfos.Sy,Ximg-Config.LargModelisePhotometrie,Yimg-Config.LargModelisePhotometrie,
         Ximg+Config.LargModelisePhotometrie,Yimg+Config.LargModelisePhotometrie);
      Img.ImgInfos.Typedata:=ImgInfos.Typedata;
      Img.ImgInfos.Sx:=Larg;
      Img.ImgInfos.Sy:=Larg;
      Img.AjusteFenetre;
      Img.VisuAutoEtoiles;
      end;

   GetImgPart(DataInt,DataDouble,ImgInt,ImgDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,
      Ximg-Config.LargModelisePhotometrie,Yimg-Config.LargModelisePhotometrie,
      Ximg+Config.LargModelisePhotometrie,Yimg+Config.LargModelisePhotometrie);
//   ModeliseEtoile(ImgInt,ImgDouble,ImgInfos.Typedata,Larg,Config.LargModelisePhotometrie+1,
//      Config.LargModelisePhotometrie+1,config.FormeModelePhotometrie,HighPrecision,LowSelect,
//      config.DegreCielPhotometrie,PSF);
   ModeliseEtoile(ImgInt,ImgDouble,ImgInfos.Typedata,Larg,config.FormeModelePhotometrie,HighPrecision,LowSelect,
      config.DegreCielPhotometrie,PSF);

   if PSF.Flux=-1 then
      begin
      ShowMessage(lang('Erreur de modélisation'));
      Exit;
      end;

//   if PSF.Flux=-1 then
//      raise ErrorModelisation.Create(lang('Erreur de modélisation'));

//   DeleteStar(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.Sx,ImgInfos.Sy,PSF,Ximg-9-1+PSF.X,Yimg-9-1+PSF.Y);

   if NbEtalonsSupp=0 then
      begin
      Getmem(FirstEtalonSupp,Sizeof(TEtalon));
      EtalonCourantSupp:=FirstEtalonSupp;
      end;

   Inc(NbEtalonsSupp);
   EtalonCourantSupp.X:=Round(Ximg-Config.LargModelisePhotometrie-1+PSF.X);
   EtalonCourantSupp.Y:=Round(Yimg-Config.LargModelisePhotometrie-1+PSF.Y);
   EtalonCourantSupp.Flux:=FluxEtalon;
   EtalonCourantSupp.FluxErreur:=ErreurFluxEtalon;
   EtalonCourantSupp.Magnitude:=MagnitudeEtalon;
   Getmem(EtalonCourantSupp.Suivant,Sizeof(TEtalon));
   EtalonCourantSupp:=EtalonCourantSupp.Suivant;

   if MagnitudeMesuree then CalculPhotometrie;
   end
//else raise ErrorModelisation.Create(lang('Erreur de modélisation'));
else ShowMessage(lang('Erreur de modélisation'));

finally
case ImgInfos.Typedata of
   2:begin
     for i:=1 to Larg do Freemem(ImgInt^[1]^[i],Larg*2);
     Freemem(ImgInt^[1],Larg*4);
     Freemem(ImgInt,4);
     end;
   5:begin
     for i:=1 to Larg do Freemem(ImgDouble^[1]^[i],Larg*8);
     Freemem(ImgDouble^[1],Larg*4);
     Freemem(ImgDouble,4);
     end;
   end;
end;
end;

procedure Tpop_image.Mesure1Click(Sender: TObject);
begin
if TypePointage=PointeOff then
   begin
   TypePointage:=PointeMagnitude;
   FormePointage:=Reticule;
   ClipOn;
   end;
end;

procedure Tpop_image.ReinitialisePhotometrie;
var
   i:Integer;
begin
   if NbEtalons<>0 then
      begin
      EtalonCourant:=FirstEtalon;
      for i:=1 to NBEtalons do
         begin
         OldEtalon:=EtalonCourant;
         EtalonCourant:=EtalonCourant.Suivant;
         Freemem(OldEtalon,Sizeof(TEtalon));
         end;
      NbEtalons:=0;
      MagnitudeMesuree:=False;
      end;
   if NbEtalonsSupp<>0 then
      begin
      EtalonCourantSupp:=FirstEtalonSupp;
      for i:=1 to NBEtalonsSupp do
         begin
         OldEtalonSupp:=EtalonCourantSupp;
         EtalonCourantSupp:=EtalonCourantSupp.Suivant;
         Freemem(OldEtalonSupp,Sizeof(TEtalon));
         end;
      NbEtalonsSupp:=0;
      end;

//   VisuImg;
end;


procedure Tpop_image.CalculPhotometrie;
var
   i,N:Integer;

   x,y,sig:PLigDouble;
   a:DoubleArrayRow;
   covar:DoubleArray;
   Da,Db,Chisq,Somme,Moy,Ecart,Dx:Double;
begin
   Rapport.AddLine(lang('Image : ')+Caption);

   if Config.MesureParSuperStar then
      begin
      // Calcul par SuperStar
      FluxEtalonTheorique:=0;
      FluxSuperStar:=0;
      ErreurFluxSuperStar:=0;
      EtalonCourant:=FirstEtalon;
      for i:=1 to NbEtalons do
         begin
         FluxEtalonTheorique:=FluxEtalonTheorique+PuissanceDouble(10,0.4*(FirstEtalon.Magnitude-EtalonCourant.Magnitude));
         FluxSuperStar:=FluxSuperStar+EtalonCourant.Flux;
         ErreurFluxSuperStar:=ErreurFluxSuperStar+EtalonCourant.FluxErreur;
         EtalonCourant:=EtalonCourant.Suivant;
         end;
      MagnitudeSuperStar:=FirstEtalon.Magnitude-2.5*ln(FluxEtalonTheorique)/ln(10);
      MagnitudeEtoile:=MagnitudeSuperStar-2.5*ln(FluxEtoile/FluxSuperStar)/ln(10);
      // Calcul de l'erreur par propagation d'incertitudes à partir  de la formule :
      // MagnitudeEtoile:=MagnitudeEtalon-2.5*ln(FluxEtoile/FluxEtalon)/ln(10);
      // Propagation des incertitudes dans log(w/u) : 2.5*(deltaw/|w|+deltau/|u|)/ln(10)
      ErreurMagnitudeEtoile:=2.5*((ErreurFluxSuperStar/FluxSuperStar)+(ErreurFluxEtoile/FluxEtoile))/ln(10);

      // Ancien calcul d'incertitudes
      //   MagnitudeEtoile:=MagnitudeEtalon-2.5*ln(FluxEtoile/FluxEtalon)/ln(10);
      //   ErreurMagnitudeEtoileMax:=MagnitudeEtoile-(MagnitudeEtalon-2.5*ln((FluxEtoile+
      //      ErreurFluxEtoile)/(FluxEtalon-ErreurFluxEtalon))/ln(10));
      //   ErreurMagnitudeEtoileMin:=MagnitudeEtoile-(MagnitudeEtalon-2.5*ln((FluxEtoile-
      //      ErreurFluxEtoile)/(FluxEtalon+ErreurFluxEtalon))/ln(10));
      //   if ErreurMagnitudeEtoileMax>ErreurMagnitudeEtoileMin then
      //   ErreurMagnitudeEtoile:=ErreurMagnitudeEtoileMax
      //   else ErreurMagnitudeEtoile:=ErreurMagnitudeEtoileMin;

      Etoile.Flux:=FluxEtoile;
   //   Etoile.FluxErreur:=ErreurMagnitudeEtoile;
      Etoile.FluxErreur:=ErreurFluxEtoile;
      Etoile.Magnitude:=MagnitudeEtoile;
      Etoile.ErreurMagnitude:=ErreurMagnitudeEtoile;
      MagnitudeMesuree:=True;

      if NbEtalons<>1 then
         begin
         Rapport.AddLine(lang('Mesure par SuperEtoile (')
            +IntToStr(NbEtalons)+lang(' étalons)'));
         Rapport.AddLine(lang('Flux SuperEtoile = ')+MyFloatToStr(FluxSuperStar,3)
            +'+/-'+MyFloatToStr(ErreurFluxSuperStar,3)); //nolang
         Rapport.AddLine(lang('Magnitude SuperEtoile = ')
            +MyFloatToStr(MagnitudeSuperStar,3)); //nolang
         end
      else Rapport.AddLine(lang('Mesure par rapport à un étalon'));

      case Config.FormeModelePhotometrie of
         1:Rapport.AddLine(lang('Photométrie par modélisation gaussienne circulaire'));
         2:Rapport.AddLine(lang('Photométrie par modélisation gaussienne ellipsoïdale'));
         3:Rapport.AddLine(lang('Photométrie par modélisation moffat'));
         4:Rapport.AddLine('Photométrie d''ouverture');
         end;
      if Config.FormeModelePhotometrie<>4 then
         Rapport.AddLine(lang('Demi-largeur = ')+IntToStr(config.LargModelisePhotometrie));
      Rapport.AddLine(lang('Flux objet = ')+MyFloatToStr(FluxEtoile,3)
         +'+/-'+MyFloatToStr(ErreurFluxEtoile,3)); //nolang
      Rapport.AddLine(lang('Magnitude objet = ')+MyFloatToStr(MagnitudeEtoile,2)
         +'+/-'+MyFloatToStr(ErreurMagnitudeEtoile,3)); //nolang
      if Config.FormeModelePhotometrie=4 then
         Rapport.AddLine(lang('Rint = ')+IntToStr(Config.ApertureInt)+
            lang(' / Rmid = ')+IntToStr(Config.ApertureMid)+         
            lang(' / Rext = ')+IntToStr(Config.ApertureOut));
      Rapport.AddLine(' ');
      end;

   if Config.MesureParReference then
      begin
      // Calcul par moyenne
      // Fonction a fitter : y=b
      // Avec
      // y = Magnitude de l'etalon+2.5 x log du flux de l'étalon
      Getmem(x,8*NbEtalons);
      Getmem(y,8*NbEtalons);
      Getmem(Sig,8*NbEtalons);
      try

      EtalonCourant:=FirstEtalon;
      Moy:=0;
      Ecart:=0;
      N:=0;
      for i:=1 to NbEtalons do
         begin
         y^[i]:=EtalonCourant.Magnitude+2.5*Ln(EtalonCourant.Flux)/ln(10);
         inc(N);
         Dx:=y^[i]-Moy;
         Moy:=Moy+Dx/N;
         Ecart:=Ecart+Dx*(y^[i]-Moy);
         Sig^[i]:=1; // Pas d'incertitude sur la magnitude !
         EtalonCourant:=EtalonCourant.Suivant;
         end;
      Ecart:=Sqrt(Ecart/N);
      lfitCste(y,Sig,NbEtalons,a,Covar,Chisq);
      Da:=Sqrt(Abs(Covar[1,1])*Chisq);
//      Da:=Sqrt(Abs(Covar[1,1])); // Trop grand ! CHIT de chez CHIT
      Rapport.AddLine(lang('Mesure par calcul de réference'));
      case Config.FormeModelePhotometrie of
         1:Rapport.AddLine(lang('Photométrie par modélisation gaussienne circulaire'));
         2:Rapport.AddLine(lang('Photométrie par modélisation gaussienne ellipsoïdale'));
         3:Rapport.AddLine(lang('Photométrie par modélisation moffat'));
         4:Rapport.AddLine('Photométrie d''ouverture');
         end;
      if Config.FormeModelePhotometrie<>4 then
         Rapport.AddLine(lang('Demi-largeur = ')+IntToStr(config.LargModelisePhotometrie));
      Rapport.AddLine('Magnitude = '+MyFloatToStr(a[1],3)+'+/-'+MyFloatToStr(Da,3)+ //nolang
         ' -2.5*log(flux)'); //nolang
      Rapport.AddLine(lang('Flux objet = ')+MyFloatToStr(FluxEtoile,3)
         +'+/-'+MyFloatToStr(ErreurFluxEtoile,3)); //nolang
   //   Rapport.AddLine('Magnitude = '+MyFloatToStr(Moy,3)+' +/- '+MyFloatToStr(Ecart,3)+ //nolang
   //      '-2.5*log(flux)'); //nolang
      Rapport.AddLine(lang('Magnitude = ')+MyFloatToStr(a[1]-2.5*ln(FluxEtoile)/ln(10),2)+
         '+/-'+MyFloatToStr(Da+2.5*(ErreurFluxEtoile/FluxEtoile)/ln(10),3)); //nolang
      if Config.FormeModelePhotometrie=4 then
         Rapport.AddLine(lang('Rint = ')+IntToStr(Config.ApertureInt)+
            lang(' / Rmid = ')+IntToStr(Config.ApertureMid)+         
            lang(' / Rext = ')+IntToStr(Config.ApertureOut));
      Rapport.AddLine('   '); //nolang

      Etoile.Flux:=FluxEtoile;
   //   Etoile.FluxErreur:=ErreurMagnitudeEtoile;
      Etoile.FluxErreur:=ErreurFluxEtoile;
      Etoile.Magnitude:=a[1]-2.5*ln(FluxEtoile)/ln(10);
      Etoile.ErreurMagnitude:=Da+2.5*(ErreurFluxEtoile/FluxEtoile)/ln(10);
      MagnitudeMesuree:=True;

      finally
      Freemem(x,8*NbEtalons);
      Freemem(y,8*NbEtalons);
      Freemem(Sig,8*NbEtalons);
      end;
   end;

   if Config.MesureParRegressionLineaire then
      begin
      // Fonction a fitter : y=b+ax
      // Avec
      // y = Magnitude de l'etalon
      // x = log du flux de l'étalon
      if NbEtalons>=2 then
         begin
         Getmem(x,8*NbEtalons);
         Getmem(y,8*NbEtalons);
         Getmem(Sig,8*NbEtalons);
         try

         EtalonCourant:=FirstEtalon;
         for i:=1 to NbEtalons do
            begin
            x^[i]:=Ln(EtalonCourant.Flux)/ln(10);
            y^[i]:=EtalonCourant.Magnitude;
            Sig^[i]:=1; // Pas d'incertitude sur la magnitude !
            EtalonCourant:=EtalonCourant.Suivant;
            end;
         lfitLin(x,y,sig,NbEtalons,a,covar,chisq);
         Da:=Sqrt(Abs(Covar[1,1])*Chisq);  // Mais le Chisq depends de Sig non ???
         Db:=Sqrt(Abs(Covar[2,2])*Chisq);
//         Da:=Sqrt(Abs(Covar[1,1])); // Trop Grand
//         Db:=Sqrt(Abs(Covar[2,2]));
         Rapport.AddLine(lang('Mesure par Moindres Carrés linéaires'));
         case Config.FormeModelePhotometrie of
            1:Rapport.AddLine(lang('Photométrie par modélisation gaussienne circulaire'));
            2:Rapport.AddLine(lang('Photométrie par modélisation gaussienne ellipsoïdale'));
            3:Rapport.AddLine(lang('Photométrie par modélisation moffat'));
            4:Rapport.AddLine('Photométrie d''ouverture');
            end;
         if Config.FormeModelePhotometrie<>4 then
            Rapport.AddLine(lang('Demi-largeur = ')+IntToStr(config.LargModelisePhotometrie));
         Rapport.AddLine('Magnitude = '+MyFloatToStr(a[1],3)+'+/-'+MyFloatToStr(Da,3)+' - '+ //nolang
            MyFloatToStr(Abs(a[2]),3)+'+/-'+MyFloatToStr(Db,3)+' *log(flux)'); //nolang
         Rapport.AddLine(lang('Flux objet = ')+MyFloatToStr(FluxEtoile,3)
            +'+/-'+MyFloatToStr(ErreurFluxEtoile,3)); //nolang
         Rapport.AddLine(lang('Magnitude = ')+MyFloatToStr(a[1]+a[2]*ln(FluxEtoile)/ln(10),3)+
            '+/-'+MyFloatToStr(Da+Db/a[2]+2.5*(ErreurFluxEtoile/FluxEtoile)/ln(10),3)); //nolang
         if Config.FormeModelePhotometrie=4 then
            Rapport.AddLine(lang('Rint = ')+IntToStr(Config.ApertureInt)+
               lang(' / Rmid = ')+IntToStr(Config.ApertureMid)+            
               lang(' / Rext = ')+IntToStr(Config.ApertureOut));
         Rapport.AddLine('   '); //nolang

         Etoile.Flux:=FluxEtoile;
      //   Etoile.FluxErreur:=ErreurMagnitudeEtoile;
         Etoile.FluxErreur:=ErreurFluxEtoile;
         Etoile.Magnitude:=a[1]+a[2]*ln(FluxEtoile)/ln(10);
         Etoile.ErreurMagnitude:=Da+Db/a[2]+2.5*(ErreurFluxEtoile/FluxEtoile)/ln(10);
         MagnitudeMesuree:=True;

         finally
         Freemem(x,8*NbEtalons);
         Freemem(y,8*NbEtalons);
         Freemem(Sig,8*NbEtalons);
         end;
         end
      else
         begin
         Rapport.AddLine('Il faut au moins 2 étalons pour mesurer par régression'); //nolang
         Rapport.AddLine('   '); //nolang
         end;

      end;
end;

procedure Tpop_image.EtalonnePhotometrie(X,Y:Integer);
var
   PSF:TPSF;
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   Ximg,YImg,Larg,i:Integer;
   Img:Tpop_image;
   Valeur:string;
   OK:Boolean;
   FluxIn,FluxOut,FluxMid:Double;
   NbIn,NbOut,NbMid:Integer;
   Modelisation:Boolean;
   FormeModelePhotometrieLocal:Byte;
begin
OK:=True;
Modelisation:=True;
Larg:=2*Config.LargModelisePhotometrie+1;

Ximg:=X+1;
Yimg:=ImgInfos.Sy-Y;

if (X>Config.LargModelisePhotometrie) and (X<ImgInfos.Sx-Config.LargModelisePhotometrie+1) and
   (Y>Config.LargModelisePhotometrie) and (Y<ImgInfos.Sy-Config.LargModelisePhotometrie+1) then
   begin
   if VisuEtoile then
      begin
      Img:=Tpop_image.Create(Application);
      GetImgPart(DataInt,DataDouble,Img.DataInt,Img.DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,
         ImgInfos.Sx,ImgInfos.Sy,Ximg-Config.LargModelisePhotometrie,Yimg-Config.LargModelisePhotometrie,
         Ximg+Config.LargModelisePhotometrie,Yimg+Config.LargModelisePhotometrie);
      Img.ImgInfos.Typedata:=ImgInfos.Typedata;
      Img.ImgInfos.Sx:=Larg;
      Img.ImgInfos.Sy:=Larg;
      Img.AjusteFenetre;
      Img.VisuAutoEtoiles;
      end;

   GetImgPart(DataInt,DataDouble,ImgInt,ImgDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,
      Ximg-Config.LargModelisePhotometrie,Yimg-Config.LargModelisePhotometrie,
      Ximg+Config.LargModelisePhotometrie,Yimg+Config.LargModelisePhotometrie);
   if Config.FormeModelePhotometrie=4 then FormeModelePhotometrieLocal:=1
   else FormeModelePhotometrieLocal:=Config.FormeModelePhotometrie;
   ModeliseEtoile(ImgInt,ImgDouble,ImgInfos.Typedata,Larg,FormeModelePhotometrieLocal,HighPrecision,LowSelect,
      config.DegreCielPhotometrie,PSF);

   if PSF.Flux=-1 then
      begin
      Modelisation:=False;
      ShowMessage(lang('Erreur de modélisation'));
      OK:=False;
      end;
   end
else
   begin
   Modelisation:=False;
   if Config.FormeModelePhotometrie=4 then
      begin
      ShowMessage(lang('Etoile trop prés du bord'));
      OK:=False;
      Exit;
      end;
   end;

try
// Ouverture
if Config.FormeModelePhotometrie=4 then
   begin
   XImg:=Round(Ximg-Config.LargModelisePhotometrie-1+PSF.X);
   YImg:=Round(Yimg-Config.LargModelisePhotometrie-1+PSF.Y);

   if (X>Config.ApertureOut) and (X<ImgInfos.Sx-Config.ApertureOut+1) and
      (Y>Config.ApertureOut) and (Y<ImgInfos.Sy-Config.ApertureOut+1) then
      begin
      FluxOut:=GetApertureFlux(DataInt,DataDouble,ImgInfos.Typedata,XImg,YImg,Config.ApertureOut,NbOut);
      FluxMid:=GetApertureFlux(DataInt,DataDouble,ImgInfos.Typedata,XImg,YImg,Config.ApertureMid,NbMid);      
      FluxIn:=GetApertureFlux(DataInt,DataDouble,ImgInfos.Typedata,XImg,YImg,Config.ApertureInt,NbIn);
//      FluxEtalon:=FluxIn-NbIn*(FluxOut-FluxIn)/(NbOut-NbIn);
      FluxEtalon:=FluxIn-NbIn*(FluxOut-FluxMid)/(NbOut-NbMid);
      ErreurFluxEtalon:=0;
      end
   else
      begin
      ShowMessage(lang('Etoile trop prés du bord'));
      OK:=False;
      end;
   end
else
   begin
   FluxEtalon:=PSF.Flux;
   ErreurFluxEtalon:=PSF.DFlux;
   end;

if OK then
   begin
   Valeur:='14'; //nolang
   if MyInputQuery(lang('Entrée de la magnitude'),
      lang('Magnitude de cet étalon ?'),Valeur) then
      begin
      MagnitudeEtalon:=MyStrToFloat(Valeur);

      if Rapport=nil then Rapport:=Tpop_Rapport.Create(Self);
      Rapport.IsUsedByAnImage:=True;
      Rapport.Image:=Self;
      Rapport.Show;

      Rapport.AddLine(lang('Etalon '+IntToStr(NbEtalons+1)));
      case Config.FormeModelePhotometrie of
         1:Rapport.AddLine(lang('Photométrie par modélisation gaussienne circulaire'));
         2:Rapport.AddLine(lang('Photométrie par modélisation gaussienne ellipsoïdale'));
         3:Rapport.AddLine(lang('Photométrie par modélisation moffat'));
         4:Rapport.AddLine('Photométrie d''ouverture');
         end;
      if Config.FormeModelePhotometrie<>4 then
         Rapport.AddLine(lang('Demi-largeur = ')+IntToStr(config.LargModelisePhotometrie));
      if Config.FormeModelePhotometrie<>4 then
         Rapport.AddLine(lang('Flux = ')+MyFloatToStr(FluxEtalon,3)
            +' +/- '+MyFloatToStr(ErreurFluxEtalon,3)) //nolang
      else
         Rapport.AddLine(lang('Flux = ')+MyFloatToStr(FluxEtalon,3));
      Rapport.AddLine(lang('Magnitude = ')+MyFloatToStr(MagnitudeEtalon,3));
      if Config.FormeModelePhotometrie=4 then
         Rapport.AddLine(lang('Rint = ')+IntToStr(Config.ApertureInt)+
            lang(' / Rmid = ')+IntToStr(Config.ApertureMid)+          
            lang(' / Rext = ')+IntToStr(Config.ApertureOut));
      Rapport.AddLine('');

      if NbEtalons=0 then
         begin
         Getmem(FirstEtalon,Sizeof(TEtalon));
         EtalonCourant:=FirstEtalon;
         end;

      Inc(NbEtalons);
      if Config.FormeModelePhotometrie<>4 then
         begin
         EtalonCourant.X:=Round(Ximg-Config.LargModelisePhotometrie-1+PSF.X);
         EtalonCourant.Y:=Round(Yimg-Config.LargModelisePhotometrie-1+PSF.Y);
         end
      else
         begin
         EtalonCourant.X:=Round(Ximg);
         EtalonCourant.Y:=Round(Yimg);
         end;
      EtalonCourant.Flux:=FluxEtalon;
      EtalonCourant.FluxErreur:=ErreurFluxEtalon;
      EtalonCourant.Magnitude:=MagnitudeEtalon;
      Getmem(EtalonCourant.Suivant,Sizeof(TEtalon));
      EtalonCourant:=EtalonCourant.Suivant;

      if MagnitudeMesuree then CalculPhotometrie;

      Rapport.Quitter.Enabled:=True;
      Rapport.BitBtn1.Enabled:=True;
      Rapport.BitBtn2.Enabled:=True;
      Rapport.BitBtn3.Enabled:=True;
      Mesure1.Enabled:=True;
      end;

   // Pour rendre le focus
   pop_main.Show;
   end;

finally
if Config.FormeModelePhotometrie<>4 then
   case ImgInfos.Typedata of
      2:begin
        for i:=1 to Larg do Freemem(ImgInt^[1]^[i],Larg*2);
        Freemem(ImgInt^[1],Larg*4);
        Freemem(ImgInt,4);
        end;
      5:begin
        for i:=1 to Larg do Freemem(ImgDouble^[1]^[i],Larg*8);
        Freemem(ImgDouble^[1],Larg*4);
        Freemem(ImgDouble,4);
        end;
      end;
end;
end;

procedure Tpop_image.MesurePhotometrie(X,Y:Integer);
var
   PSF:TPSF;
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   Ximg,YImg,Larg,i:Integer;
   Img:Tpop_image;
   OK:Boolean;
   FluxIn,FluxOut,FluxMid:Double;
   NbIn,NbOut,NbMid:Integer;
   Modelisation:Boolean;
   FormeModelePhotometrieLocal:Byte;
begin
OK:=True;
Modelisation:=True;
Larg:=2*Config.LargModelisePhotometrie+1;

Ximg:=X+1;
Yimg:=ImgInfos.Sy-Y;

if (X>Config.LargModelisePhotometrie) and (X<ImgInfos.Sx-Config.LargModelisePhotometrie+1) and
   (Y>Config.LargModelisePhotometrie) and (Y<ImgInfos.Sy-Config.LargModelisePhotometrie+1) then
   begin
   if VisuEtoile then
      begin
      Img:=Tpop_image.Create(Application);
      GetImgPart(DataInt,DataDouble,Img.DataInt,Img.DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,
         ImgInfos.Sx,ImgInfos.Sy,Ximg-Config.LargModelisePhotometrie,Yimg-Config.LargModelisePhotometrie,
         Ximg+Config.LargModelisePhotometrie,Yimg+Config.LargModelisePhotometrie);
      Img.ImgInfos.Typedata:=ImgInfos.Typedata;
      Img.ImgInfos.Sx:=Larg;
      Img.ImgInfos.Sy:=Larg;
      Img.AjusteFenetre;
      Img.VisuAutoEtoiles;
      end;

   GetImgPart(DataInt,DataDouble,ImgInt,ImgDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,
      Ximg-Config.LargModelisePhotometrie,Yimg-Config.LargModelisePhotometrie,
      Ximg+Config.LargModelisePhotometrie,Yimg+Config.LargModelisePhotometrie);
   if Config.FormeModelePhotometrie=4 then FormeModelePhotometrieLocal:=1
   else FormeModelePhotometrieLocal:=Config.FormeModelePhotometrie;
   ModeliseEtoile(ImgInt,ImgDouble,ImgInfos.Typedata,Larg,FormeModelePhotometrieLocal,HighPrecision,LowSelect,
      config.DegreCielPhotometrie,PSF);

   if PSF.Flux=-1 then
      begin
      Modelisation:=False;
      ShowMessage(lang('Erreur de modélisation'));
      OK:=False;
      end;
   end
else
   begin
   Modelisation:=False;
   if Config.FormeModelePhotometrie=4 then
      begin
      ShowMessage(lang('Etoile trop prés du bord'));
      OK:=False;
      Exit;
      end;
   end;

try
// Ouverture
if Config.FormeModelePhotometrie=4 then
   begin
   XImg:=Round(Ximg-Config.LargModelisePhotometrie-1+PSF.X);
   YImg:=Round(Yimg-Config.LargModelisePhotometrie-1+PSF.Y);

   if (X>Config.ApertureOut) and (X<ImgInfos.Sx-Config.ApertureOut+1) and
      (Y>Config.ApertureOut) and (Y<ImgInfos.Sy-Config.ApertureOut+1) then
      begin
      FluxOut:=GetApertureFlux(DataInt,DataDouble,ImgInfos.Typedata,XImg,YImg,Config.ApertureOut,NbOut);
      FluxMid:=GetApertureFlux(DataInt,DataDouble,ImgInfos.Typedata,XImg,YImg,Config.ApertureMid,NbMid);      
      FluxIn:=GetApertureFlux(DataInt,DataDouble,ImgInfos.Typedata,XImg,YImg,Config.ApertureInt,NbIn);
//      FluxEtoile:=FluxIn-NbIn*(FluxOut-FluxIn)/(NbOut-NbIn);
      FluxEtoile:=FluxIn-NbIn*(FluxOut-FluxMid)/(NbOut-NbMid);
      ErreurFluxEtoile:=0;
      end
   else
      begin
      ShowMessage(lang('Etoile trop prés du bord'));
      OK:=False;
      end;
   end
else
   begin
   FluxEtoile:=PSF.Flux;
   ErreurFluxEtoile:=PSF.DFlux;
   end;

if OK then
   begin
   if Config.FormeModelePhotometrie<>4 then
      begin
      Etoile.X:=Round(Ximg-Config.LargModelisePhotometrie-1+PSF.X);
      Etoile.Y:=Round(Yimg-Config.LargModelisePhotometrie-1+PSF.Y);
      end
   else
      begin
      Etoile.X:=Round(Ximg);
      Etoile.Y:=Round(Yimg);
      end;

   if Rapport=nil then Rapport:=Tpop_Rapport.Create(Self);
   Rapport.IsUsedByAnImage:=True;
   Rapport.Image:=Self;
   Rapport.Show;
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;

   CalculPhotometrie;
   end;

finally
if Config.FormeModelePhotometrie<>4 then
   case ImgInfos.Typedata of
      2:begin
        for i:=1 to Larg do Freemem(ImgInt^[1]^[i],Larg*2);
        Freemem(ImgInt^[1],Larg*4);
        Freemem(ImgInt,4);
        end;
      5:begin
        for i:=1 to Larg do Freemem(ImgDouble^[1]^[i],Larg*2);
        Freemem(ImgDouble^[1],Larg*4);
        Freemem(ImgDouble,4);
        end;
      end;
end;
end;

procedure Tpop_image.Rinitialiser1Click(Sender: TObject);
begin
ReinitialisePhotometrie;
VisuImg;
end;

procedure Tpop_image.MesureEtoile(X,Y:Integer);
var
PSF:TPSF;
ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
Ximg,YImg,Larg,i:Integer;
Img:Tpop_image;
EchelleX,EchelleY,XArc,YArc,X1,Y1,Theta,Ovalisation:Double;
FluxOut,FluxIn,FluxMid:Double;
NbOut,NbIn,NbMid:Integer;
begin

if ImgInfos.Focale<>0 then
   begin
   EchelleX:=ArcTan(ImgInfos.PixX*ImgInfos.BinningX/1e6/ImgInfos.Focale*1000)*180/Pi*3600;
   EchelleY:=ArcTan(ImgInfos.PixY*ImgInfos.BinningY/1e6/ImgInfos.Focale*1000)*180/Pi*3600;
   end
else
   begin
   EchelleX:=MaxDouble;
   EchelleY:=MaxDouble;
   end;

Larg:=2*Config.LargModelisePhotometrie+1;

try

if (X>Config.LargModelisePhotometrie) and (X<ImgInfos.Sx-Config.LargModelisePhotometrie+1) and
   (Y>Config.LargModelisePhotometrie) and (Y<ImgInfos.Sy-Config.LargModelisePhotometrie+1) then
   begin
   Ximg:=X+1;
   Yimg:=ImgInfos.Sy-Y;

   if VisuEtoile then
      begin
      Img:=Tpop_image.Create(Application);
      GetImgPart(DataInt,DataDouble,Img.DataInt,Img.DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,
         ImgInfos.Sx,ImgInfos.Sy,Ximg-Config.LargModelisePhotometrie,Yimg-Config.LargModelisePhotometrie,
         Ximg+Config.LargModelisePhotometrie,Yimg+Config.LargModelisePhotometrie);
      Img.ImgInfos.Typedata:=Self.ImgInfos.Typedata;
      Img.ImgInfos.TypeComplexe:=Self.ImgInfos.TypeComplexe;
      Img.ImgInfos.Sx:=Larg;
      Img.ImgInfos.Sy:=Larg;
      Img.AjusteFenetre;
      Img.VisuAutoEtoiles;
      end;

   GetImgPart(DataInt,DataDouble,ImgInt,ImgDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,
      Ximg-Config.LargModelisePhotometrie,Yimg-Config.LargModelisePhotometrie,
      Ximg+Config.LargModelisePhotometrie,Yimg+Config.LargModelisePhotometrie);
//   ModeliseEtoile(ImgInt,ImgDouble,ImgInfos.Typedata,Larg,Config.LargModelise+1,Config.LargModelise+1,
//      TGaussEllipse,HighPrecision,2,PSF);
//   ModeliseEtoile(ImgInt,ImgDouble,ImgInfos.Typedata,Larg,Config.LargModelisePhotometrie+1,
//      Config.LargModelisePhotometrie+1,config.FormeModelePhotometrie,HighPrecision,LowSelect,
//      config.DegreCielPhotometrie,PSF);
//ModeliseSources(DataInt,nil,2,1,ImgInfos.Sx,ImgInfos.Sy,Config.LargModelise,ListePSF,TGauss,LowPrecision,LowSelect,NBSources,15,
//                False,'',True);

   if config.FormeModelePhotometrie<>4 then
      ModeliseEtoile(ImgInt,ImgDouble,ImgInfos.Typedata,Larg,config.FormeModelePhotometrie,HighPrecision,LowSelect,
         config.DegreCielPhotometrie,PSF)
   else
      begin
      ModeliseEtoile(ImgInt,ImgDouble,ImgInfos.Typedata,Larg,1,HighPrecision,LowSelect,
         config.DegreCielPhotometrie,PSF);

      XImg:=Round(Ximg-Config.LargModelisePhotometrie-1+PSF.X);
      YImg:=Round(Yimg-Config.LargModelisePhotometrie-1+PSF.Y);
      PSF.X:=XImg;
      PSF.Y:=YImg;
      PSF.DX:=0;
      PSF.DY:=0;         

      if (X>Config.ApertureOut) and (X<ImgInfos.Sx-Config.ApertureOut+1) and
         (Y>Config.ApertureOut) and (Y<ImgInfos.Sy-Config.ApertureOut+1) then
         begin
         FluxOut:=GetApertureFlux(DataInt,DataDouble,ImgInfos.Typedata,XImg,YImg,Config.ApertureOut,NbOut);
         FluxMid:=GetApertureFlux(DataInt,DataDouble,ImgInfos.Typedata,XImg,YImg,Config.ApertureMid,NbMid);         
         FluxIn:=GetApertureFlux(DataInt,DataDouble,ImgInfos.Typedata,XImg,YImg,Config.ApertureInt,NbIn);
//         PSF.Flux:=FluxIn-NbIn*(FluxOut-FluxIn)/(NbOut-NbIn);
         PSF.Flux:=FluxIn-NbIn*(FluxOut-FluxMid)/(NbOut-NbMid);
         PSF.DFlux:=0;
         end
      else
         begin
         ShowMessage(lang('Etoile trop prés du bord'));
         Exit;
         end;

      end;

// Test
//   HFD(ImgInt,ImgDouble,ImgInfos.Typedata,Larg,Larg,XHFD,YHFD,Diametre);
//   ShowMessage(MyFloatToStr(Diametre,2));

   if PSF.Flux=-1 then
      begin
      ShowMessage(lang('Erreur de modélisation'));
      Exit;
      end;

//   if PSF.Flux=-1 then
//      raise ErrorModelisation.Create(lang('Erreur de modélisation'));

   if Rapport=nil then Rapport:=Tpop_Rapport.Create(Self);
   Rapport.IsUsedByAnImage:=True;
   Rapport.Image:=Self;
   Rapport.Show;
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;
   case config.FormeModelePhotometrie of
      1:Rapport.AddLine(lang('Modélisation Gaussienne circulaire d''une étoile'));
      2:Rapport.AddLine(lang('Modélisation Gaussienne ellipsoidale d''une étoile'));
      3:Rapport.AddLine(lang('Modélisation Moffat d''une étoile'));
      4:Rapport.AddLine('Photométrie d''ouverture');
      end;
   if Config.FormeModelePhotometrie<>4 then
      Rapport.AddLine(lang('Demi-largeur = ')+IntToStr(config.LargModelisePhotometrie));
   Rapport.AddLine('  '); //nolang
   Rapport.AddLine(lang('Flux = ')+MyFloatToStr(PSF.Flux,3)
      +' +/- '+MyFloatToStr(PSF.DFlux,3)); //nolang
   Rapport.AddLine('X = '+MyFloatToStr(Ximg-Config.LargModelisePhotometrie-1+PSF.X, //nolang
      3)+' +/- '+MyFloatToStr(PSF.DX,3)); //nolang
   Rapport.AddLine('Y = '+MyFloatToStr(Yimg-Config.LargModelisePhotometrie-1+PSF.Y, //nolang
      3)+' +/- '+MyFloatToStr(PSF.DY,3)); //nolang
   case config.FormeModelePhotometrie of
      1:begin
        Rapport.AddLine('FWHM = '+MyFloatToStr(PSF.Sigma,3)+' Pixels'); //nolang
        if Config.FocaleTele<>0 then
           begin
           XArc:=PSF.Sigma*EchelleX;
           YArc:=PSF.Sigma*EchelleY;
//           if ImgInfos.PixX<>ImgInfos.PixY then
//              begin
//              Rapport.AddLine('FWHM axe X = '+MyFloatToStr(XArc,2)+lang(' ArcSec'));
//              Rapport.AddLine('FWHM axe Y = '+MyFloatToStr(YArc,2)+lang(' ArcSec'));
//           Rapport.AddLine(lang('FWHM = ')+MyFloatToStr(Sqrt(0.5*(Sqr(XArc)+Sqr(YArc))),2)+lang(' ArcSec'));
           Rapport.AddLine('FWHM = '+MyFloatToStr(0.5*(XArc+YArc),3)+' ArcSec'); //nolang
//              end
//           else
//              Rapport.AddLine('FWHM = '+MyFloatToStr(XArc,2)+' ArcSec'); //nolang
           end;
        Rapport.AddLine('  '); //nolang
        end;
      2:begin
        X1:=PSF.SigmaX;
        Y1:=PSF.SigmaY;
        Theta:=PSF.Angle*180/pi;
        Rapport.AddLine(lang('FWHM Grand Axe = ')+MyFloatToStr(X1,3)
           +' Pixels'); //nolang
        Rapport.AddLine(lang('FWHM Petit Axe = ')+MyFloatToStr(Y1,3)
           +' Pixels'); //nolang
        if ImgInfos.Focale<>0 then
           begin
           XArc:=Sqrt(Sqr(X1*Cos(Theta)*EchelleX)+Sqr(X1*Sin(Theta)*EchelleY));
           YArc:=Sqrt(Sqr(Y1*Cos(Theta)*EchelleY)+Sqr(Y1*Sin(Theta)*EchelleX));
           if XArc>YArc then Ovalisation:=XArc/YArc else Ovalisation:=YArc/XArc;
           Rapport.AddLine(lang('FWHM Grand Axe = ')+MyFloatToStr(XArc,3)
              +' ArcSec'); //nolang
           Rapport.AddLine(lang('FWHM Petit Axe = ')+MyFloatToStr(YArc,3)
              +' ArcSec'); //nolang
           Rapport.AddLine(lang('FWHM RMS = ')+MyFloatToStr(Sqrt(0.5*(Sqr(XArc)+Sqr(YArc))),3)
              +' ArcSec'); //nolang
           Rapport.AddLine(lang('Ovalisation = ')+MyFloatToStr(Ovalisation,3));
           end;
        Rapport.AddLine(lang('Angle du grand axe sur l''horizontale = ')+
           MyFloatToStr(Theta,3)+lang(' Degrés'));
        Rapport.AddLine('  '); //nolang
        end;
      3:begin
        Rapport.AddLine('a Moffat = '+MyFloatToStr(PSF.aMoffat,3)); //nolang
        Rapport.AddLine('b Moffat = '+MyFloatToStr(PSF.bMoffat,3)); //nolang
        Rapport.AddLine('  '); //nolang
        end;
      4:begin
        Rapport.AddLine(lang('Rint = ')+IntToStr(Config.ApertureInt)+
            lang(' / Rmid = ')+IntToStr(Config.ApertureMid)+        
            lang(' / Rext = ')+IntToStr(Config.ApertureOut));
        Rapport.AddLine('   '); //nolang
        end;
      end;
   end
//else raise ErrorModelisation.Create(lang('Erreur de modélisation'));
else ShowMessage(lang('Erreur de modélisation'));

finally
case ImgInfos.Typedata of
   2:begin
     for i:=1 to Larg do Freemem(ImgInt^[1]^[i],Larg*2);
     Freemem(ImgInt^[1],Larg*4);
     Freemem(ImgInt,4);
     end;
   5:begin
     for i:=1 to Larg do Freemem(ImgDouble^[1]^[i],Larg*8);
     Freemem(ImgDouble^[1],Larg*4);
     Freemem(ImgDouble,4);
     end;
   end;
end;
end;

procedure Tpop_image.Binninglogiciel1Click(Sender: TObject);
var
pop_2integer_dlg:Tpop_2integer_dlg;
BinningX,BinningY:Integer;
begin
pop_2integer_dlg:=Tpop_2integer_dlg.Create(Application);
pop_2integer_dlg.Caption:=lang('Binning logiciel');
pop_2integer_dlg.LabelInteger1.Caption:=lang('Binning X :');
pop_2integer_dlg.LabelInteger2.Caption:=lang('Binning Y :');
pop_2integer_dlg.SpinEditInteger1.Text:='2';
pop_2integer_dlg.SpinEditInteger2.Text:='2';
pop_2integer_dlg.SpinEditInteger1.MaxValue:=8;
pop_2integer_dlg.SpinEditInteger1.MinValue:=8;
pop_2integer_dlg.SpinEditInteger2.MaxValue:=8;
pop_2integer_dlg.SpinEditInteger2.MinValue:=8;
try
if pop_2integer_dlg.ShowModal=mrOK then
   begin
   BinningX:=pop_2integer_dlg.SpinEditInteger1.Value;
   BinningY:=pop_2integer_dlg.SpinEditInteger2.Value;
   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   Binning(DataInt,DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans,BinningX,BinningY);
   AjusteFenetre;
   VisuAutoEtoiles;
   finally
   Screen.Cursor:=crDefault;
   end;
   end;
finally
pop_2integer_dlg.free;
end;
end;

procedure Tpop_image.Modliseunetoile1Click(Sender: TObject);
begin
if TypePointage=PointeOff then
   begin
   TypePointage:=PointeEtoile;
   FormePointage:=Reticule;
   ClipOn;
   end;
end;

procedure Tpop_image.Modlisetouteslestoiles1Click(Sender: TObject);
var
ListePSF:PListePSF;
NBSources,i:Integer;
begin
if Rapport=nil then Rapport:=tpop_rapport.Create(Self);
Rapport.IsUsedByAnImage:=True;
Rapport.Image:=Self;
rapport.flag:=1; // contient infos de modelisation stellaire
tag:=1;
Rapport.Show;
try
Rapport.AddLine(lang('Modélisation gaussienne circulaire'));
Rapport.AddLine('');
Screen.Cursor:=crHourGlass;
try
NBSources:=0;
ModeliseSources(DataInt,DataDouble,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,
   Config.LargModelise,ListePSF,TGauss,LowPrecision,LowSelect,NBSources,6,False,'',True);
Rapport.AddLine(Format(lang('Nombre d''étoiles : %d'),[NBSources]));
Rapport.AddLine('X     DX    Y     DY      FWHM    Flux     DFlux'); //nolang
for i:=1 to NBSources do
   Rapport.AddLine(Format('%6.2f %4.2f %6.2f %4.2f %4.2f %9.0f %4.2f',[ListePSF^[i].X, //nolang
      ListePSF^[i].DX,ListePSF^[i].Y,ListePSF^[i].DY,ListePSF^[i].Sigma,
      ListePSF^[i].Flux,ListePSF^[i].DFlux]));
finally
Rapport.Quitter.Enabled:=True;
Rapport.BitBtn1.Enabled:=True;
Rapport.BitBtn2.Enabled:=True;
Rapport.BitBtn3.Enabled:=True;
Freemem(ListePSF,NBSources*Sizeof(TPSF));
end;
finally
Screen.Cursor:=crDefault;
end;
end;

procedure Tpop_image.outZoom1Click(Sender: TObject);
var
pop_zoom:Tpop_zoom;
begin
pop_zoom:=Tpop_zoom.Create(Application);
try
if pop_zoom.ShowModal=mrOK then
   begin
   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   if pop_zoom.CheckBox1.Checked
      and (MyStrToFloat(pop_zoom.NbreEdit1.Text)>1)
      and (MyStrToFloat(pop_zoom.NbreEdit2.Text)>1)
      and (ImgInfos.NbPlans=1) then
         ZoomSpline(DataInt,DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans,MyStrToFloat(pop_zoom.NbreEdit1.Text),
            MyStrToFloat(pop_zoom.NbreEdit2.Text))
   else
      ZoomBilineaire(DataInt,DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans,MyStrToFloat(pop_zoom.NbreEdit1.Text),
         MyStrToFloat(pop_zoom.NbreEdit2.Text));
   AjusteFenetre;      
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;
   end
finally
pop_zoom.Free;
end;

end;

procedure Tpop_image.Translation1Click(Sender: TObject);
var
TabItems:PTabItems;
DlgStandard:Tpop_dlg_standard;
Dx,Dy:Double;
UseSpline:Boolean;
begin
New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('Axe X : ');
   ValeurDefaut:=1;
   ValeurMin:=40000;
   ValeurMax:=40000;
   end;

with TabItems^[2] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('Axe Y : ');
   ValeurDefaut:=1;
   ValeurMin:=40000;
   ValeurMax:=40000;
   end;

with TabItems^[3] do
   begin
   TypeItem:=tiCheckBox;
   Msg:=lang('Spline');
   ValeurDefaut:=1;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,200);
DlgStandard.Caption:=lang('Translation');
if DlgStandard.ShowModal=mrOK then
   begin
   Dx:=TabItems^[1].ValeurSortie;
   Dy:=TabItems^[2].ValeurSortie;
   UseSpline:=TabItems^[3].ValeurSortie=1;

   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   if UseSpline then
      TranslationSpline(DataInt,DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans,Dx,Dy)
   else
      Translation(DataInt,DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans,Dx,Dy);   
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;

   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;
end;

procedure Tpop_image.Rotation1Click(Sender: TObject);
var
TabItems:PTabItems;
DlgStandard:Tpop_dlg_standard;
Xc,Yc,Angle:Double;
begin
New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('Centre X : ');
   ValeurDefaut:=ImgInfos.Sx div 2;
   ValeurMin:=1;
   ValeurMax:=ImgInfos.Sx;
   end;

with TabItems^[2] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('Centre Y : ');
   ValeurDefaut:=ImgInfos.Sy div 2;
   ValeurMin:=1;
   ValeurMax:=ImgInfos.Sy;
   end;

with TabItems^[3] do
   begin
   TypeItem:=tiLabel;
   Msg:=lang('Aiguilles de la montre = Angle>0 ');
   end;

with TabItems^[4] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('Angle (°) : ');
   ValeurDefaut:=45;
   ValeurMin:=0;
   ValeurMax:=360;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.Caption:=lang('Rotation');
if DlgStandard.ShowModal=mrOK then
   begin
   Xc:=TabItems^[1].ValeurSortie;
   Yc:=TabItems^[2].ValeurSortie;
   Angle:=TabItems^[4].ValeurSortie;

   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   Rotation(DataInt,DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans,Xc,Yc,Angle);
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;

   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;
end;

procedure Tpop_image.MiroirHorizontal1Click(Sender: TObject);
begin
Screen.Cursor:=crHourGlass;
try
SaveUndo;
MiroirHorizontal(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
ImgInfos.MiroirX:=not(ImgInfos.MiroirX);
VisuImg;
finally
Screen.Cursor:=crDefault;
end;
end;

procedure Tpop_image.MiroirVertical1Click(Sender: TObject);
begin
Screen.Cursor:=crHourGlass;
try
SaveUndo;
MiroirVertical(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
ImgInfos.MiroirY:=not(ImgInfos.MiroirY);
VisuImg;
finally
Screen.Cursor:=crDefault;
end;
end;

procedure Tpop_image.Rotation901Click(Sender: TObject);
begin
Screen.Cursor:=crHourGlass;
try
SaveUndo;
RotationP90(DataInt,DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans);
AjusteFenetre;
VisuImg;
finally
Screen.Cursor:=crDefault;
end;
end;

procedure Tpop_image.Rotation902Click(Sender: TObject);
begin
Screen.Cursor:=crHourGlass;
try
SaveUndo;
RotationM90(DataInt,DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans);
AjusteFenetre;
VisuImg;
finally
Screen.Cursor:=crDefault;
end;
end;

procedure Tpop_image.Rotation1801Click(Sender: TObject);
begin
Screen.Cursor:=crHourGlass;
try
SaveUndo;
Rotation180(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
VisuImg;
finally
Screen.Cursor:=crDefault;
end;
end;

procedure Tpop_image.Dtourage1Click(Sender: TObject);
var
TabItems:PTabItems;
DlgStandard:Tpop_dlg_standard;
Delta:Integer;
begin
New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiInteger;
   Msg:=lang('Largeur : ');
   ValeurIncrement:=1;
   ValeurDefaut:=4;
   ValeurMin:=1;
   ValeurMax:=ImgInfos.Sx div 4;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.Caption:=lang('Détourage');
if DlgStandard.ShowModal=mrOK then
   begin
   Delta:=Round(TabItems^[1].ValeurSortie);

   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   Detourage(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Delta);
   AjusteFenetre;
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;

   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;
end;

procedure Tpop_image.Entourage1Click(Sender: TObject);
var
TabItems:PTabItems;
DlgStandard:Tpop_dlg_standard;
Delta,Valeur:Integer;
begin
New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiInteger;
   Msg:=lang('Largeur : ');
   ValeurIncrement:=1;
   ValeurDefaut:=4;
   ValeurMin:=1;
   ValeurMax:=ImgInfos.Sx div 4;
   end;

with TabItems^[2] do
   begin
   TypeItem:=tiInteger;
   Msg:=lang('Remplissage : ');
   ValeurIncrement:=1;
   ValeurDefaut:=0;
   ValeurMin:=-32768;
   ValeurMax:=32767;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.Caption:=lang('Entourage');
if DlgStandard.ShowModal=mrOK then
   begin
   Delta:=Round(TabItems^[1].ValeurSortie);
   Valeur:=Round(TabItems^[2].ValeurSortie);

   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   Entourage(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Delta,Valeur);
   AjusteFenetre;
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;

   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;
end;

procedure Tpop_image.Fenttrage1Click(Sender: TObject);
begin
if TypePointage=PointeOff then
   begin
   TypePointage:=PointeFenetrage;
   FormePointage:=Reticule;
   ClipOn;
   end;
end;

procedure Tpop_image.Gaussienne1Click(Sender: TObject);
var
TabItems:PTabItems;
DlgStandard:Tpop_dlg_standard;
Sigma:Double;
begin
New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('Largeur gaussienne: ');
   ValeurDefaut:=1;
   ValeurMin:=0.1;
   ValeurMax:=100;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.Caption:=lang('Gaussienne');
if DlgStandard.ShowModal=mrOK then
   begin
   Sigma:=TabItems^[1].ValeurSortie;

   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   Gaussienne(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Sigma);
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;

   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;
end;

procedure Tpop_image.MasqueFlou1Click(Sender: TObject);
var
TabItems:PTabItems;
DlgStandard:Tpop_dlg_standard;
Sigma,Mult:Double;
Ciel:Boolean;
begin
New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('Largeur gaussienne : ');
   ValeurDefaut:=1;
   ValeurMin:=0.1;
   ValeurMax:=100;
   end;

with TabItems^[2] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('Détails multipliés par : ');
   ValeurDefaut:=10;
   ValeurMin:=1;
   ValeurMax:=1000;
   end;

with TabItems^[3] do
   begin
   TypeItem:=tiCheckBox;
   Msg:=lang('Image stellaire');
   ValeurDefaut:=1;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.Caption:=lang('Masque Flou');
if DlgStandard.ShowModal=mrOK then
   begin
   Sigma:=TabItems^[1].ValeurSortie;
   Mult:=TabItems^[2].ValeurSortie;
   Ciel:=TabItems^[3].ValeurSortie=1;

   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   MasqueFlou(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Sigma,Mult,Ciel);
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;

   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;
end;

procedure Tpop_image.Log1Click(Sender: TObject);
begin
SaveUndo;
ImgLn(DataInt,DataDouble,ImgInfos.NbPlans,ImgInfos.Typedata,ImgInfos.Sx,ImgInfos.Sy);
AjusteFenetre;
VisuAutoEtoiles;
end;

procedure Tpop_image.ClipMin1Click(Sender: TObject);
var
TabItems:PTabItems;
DlgStandard:Tpop_dlg_standard;
Seuil,Valeur:Integer;
begin
New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiInteger;
   Msg:=lang('Seuil : ');
   ValeurIncrement:=1000;
   ValeurDefaut:=1000;
   ValeurMin:=-32768;
   ValeurMax:=32767;
   end;

with TabItems^[2] do
   begin
   TypeItem:=tiInteger;
   Msg:=lang('Nouvelle Valeur : ');
   ValeurIncrement:=1000;
   ValeurDefaut:=0;
   ValeurMin:=-32768;
   ValeurMax:=32767;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.Caption:=lang('Seuillage Minimum');
if DlgStandard.ShowModal=mrOK then
   begin
   Seuil:=Round(TabItems^[1].ValeurSortie);
   Valeur:=Round(TabItems^[2].ValeurSortie);

   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   ClipMin(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Seuil,Valeur);
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;

   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;
end;

procedure Tpop_image.Seuillagemaximum1Click(Sender: TObject);
var
TabItems:PTabItems;
DlgStandard:Tpop_dlg_standard;
Seuil,Valeur:Integer;
begin
New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiInteger;
   Msg:=lang('Seuil : ');
   ValeurIncrement:=1000;
   ValeurDefaut:=1000;
   ValeurMin:=-32768;
   ValeurMax:=32767;
   end;

with TabItems^[2] do
   begin
   TypeItem:=tiInteger;
   Msg:=lang('Nouvelle Valeur : ');
   ValeurIncrement:=1000;
   ValeurDefaut:=0;
   ValeurMin:=-32768;
   ValeurMax:=32767;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.Caption:=lang('Seuillage Maximum');
if DlgStandard.ShowModal=mrOK then
   begin
   Seuil:=Round(TabItems^[1].ValeurSortie);
   Valeur:=Round(TabItems^[2].ValeurSortie);

   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   ClipMax(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Seuil,Valeur);
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;

   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;
end;

procedure Tpop_image.Binarisation1Click(Sender: TObject);
var
TabItems:PTabItems;
DlgStandard:Tpop_dlg_standard;
Seuil,ValeurBas,ValeurHaut:Integer;
begin
New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiInteger;
   Msg:=lang('Seuil : ');
   ValeurIncrement:=1000;
   ValeurDefaut:=1000;
   ValeurMin:=-32768;
   ValeurMax:=32767;
   end;

with TabItems^[2] do
   begin
   TypeItem:=tiInteger;
   Msg:=lang('Valeur Basse : ');
   ValeurIncrement:=1000;
   ValeurDefaut:=0;
   ValeurMin:=-32768;
   ValeurMax:=32767;
   end;

with TabItems^[3] do
   begin
   TypeItem:=tiInteger;
   Msg:=lang('Valeur Haute : ');
   ValeurIncrement:=1000;
   ValeurDefaut:=32767;
   ValeurMin:=-32768;
   ValeurMax:=32767;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.Caption:=lang('Binarisation');
if DlgStandard.ShowModal=mrOK then
   begin
   Seuil:=Round(TabItems^[1].ValeurSortie);
   ValeurBas:=Round(TabItems^[2].ValeurSortie);
   ValeurHaut:=Round(TabItems^[3].ValeurSortie);

   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   Binarise(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Seuil,ValeurBas,ValeurHaut);
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;

   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;
end;

procedure Tpop_image.CopieEtoile(X,Y:Integer);
var
ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
Ximg,YImg,Larg,i:Integer;
PSF:TPSF;
ax,bx,ay,by:Double;
ax1,bx1,ay1,by1:Double;
begin
Larg:=2*9+1;

try
ax1:=(ImgInfos.Sx-1)/(ZoomFactor*ImgInfos.Sx-ZoomFactor);
bx1:=1-ax1;
ay1:=(ImgInfos.Sy-1)/(ZoomFactor*ImgInfos.Sy-ZoomFactor);
by1:=1-ay1;

ax:=(Img_Box.Width-1)/ZoomFactor/(Img_Box.Width-1);
bx:=ax1*Round(HorizScrollBar.Position)+bx1;
ay:=(Img_Box.Height-1)/ZoomFactor/(Img_Box.Height-1);
// Merde faut pas inverser ici / Pourquoi ? / Mystere et boule de gomme !
by:=ay1*Round(VerticScrollBar.Position)+by1;

Ximg:=Trunc(ax*X+bx);
Yimg:=Trunc(ay*Y+by);

Ximg:=Ximg;
Yimg:=ImgInfos.Sy-Yimg+1;

XimgCopie:=Ximg;
YimgCopie:=Yimg;

GetImgPart(DataInt,DataDouble,ImgInt,ImgDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Ximg-9,Yimg-9,Ximg+9,Yimg+9);
//ModeliseEtoile(ImgInt,ImgDouble,ImgInfos.Typedata,Larg,10,10,TGaussEllipse,HighPrecision,LowSelect,2,PSF);
ModeliseEtoile(ImgInt,ImgDouble,ImgInfos.Typedata,Larg,TGaussEllipse,HighPrecision,LowSelect,2,PSF);
if PSF.Flux=-1 then
   begin
   ShowMessage(lang('Impossible de modéliser l''étoile'));
   Exit;
   end;

PSFCopie:=PSF;

finally
case ImgInfos.Typedata of
   2:begin
     for i:=1 to Larg do Freemem(ImgInt^[1]^[i],Larg*2);
     Freemem(ImgInt^[1],Larg*4);
     Freemem(ImgInt,4);
     end;
   5:begin
     for i:=1 to Larg do Freemem(ImgDouble^[1]^[i],Larg*8);
     Freemem(ImgDouble^[1],Larg*4);
     Freemem(ImgDouble,4);
     end;
   end;
end;
end;

procedure Tpop_image.CoupeEtoile(X,Y:Integer);
var
ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
Ximg,YImg,Larg,i:Integer;
PSF:TPSF;
ax,bx,ay,by:Double;
ax1,bx1,ay1,by1:Double;
begin
Larg:=2*9+1;

try
ax1:=(ImgInfos.Sx-1)/(ZoomFactor*ImgInfos.Sx-ZoomFactor);
bx1:=1-ax1;
ay1:=(ImgInfos.Sy-1)/(ZoomFactor*ImgInfos.Sy-ZoomFactor);
by1:=1-ay1;

ax:=(Img_Box.Width-1)/ZoomFactor/(Img_Box.Width-1);
bx:=ax1*Round(HorizScrollBar.Position)+bx1;
ay:=(Img_Box.Height-1)/ZoomFactor/(Img_Box.Height-1);
// Merde faut pas inverser ici / Pourquoi ? / Mystere et boule de gomme !
by:=ay1*Round(VerticScrollBar.Position)+by1;

Ximg:=Trunc(ax*X+bx);
Yimg:=Trunc(ay*Y+by);

Ximg:=Ximg;
Yimg:=ImgInfos.Sy-Yimg+1;

XimgCopie:=Ximg;
YimgCopie:=Yimg;

GetImgPart(DataInt,DataDouble,ImgInt,ImgDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Ximg-9,Yimg-9,Ximg+9,Yimg+9);
//ModeliseEtoile(ImgInt,ImgDouble,ImgInfos.Typedata,Larg,10,10,TGaussEllipse,HighPrecision,LowSelect,2,PSF);
ModeliseEtoile(ImgInt,ImgDouble,ImgInfos.Typedata,Larg,TGaussEllipse,HighPrecision,LowSelect,2,PSF);
if PSF.Flux=-1 then
   begin
   ShowMessage(lang('Impossible de modéliser l''étoile'));
   Exit;
   end;

PSFCopie:=PSF;

SaveUndo;
DeleteStar(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.Sx,ImgInfos.Sy,PSFCopie,Ximg-9-1+PSFCopie.X,Yimg-9-1+PSFCopie.Y);
VisuImg;

finally
case ImgInfos.Typedata of
   2:begin
     for i:=1 to Larg do Freemem(ImgInt^[1]^[i],Larg*2);
     Freemem(ImgInt^[1],Larg*4);
     Freemem(ImgInt,4);
     end;
   5:begin
     for i:=1 to Larg do Freemem(ImgDouble^[1]^[i],Larg*8);
     Freemem(ImgDouble^[1],Larg*4);
     Freemem(ImgDouble,4);
     end;
   end;
end;
end;

procedure Tpop_image.ColleEtoileIci(X,Y:Integer);
var
Ximg,YImg:Double;
TabItems:PTabItems;
DlgStandard:Tpop_dlg_standard;
ax,bx,ay,by:Double;
ax1,bx1,ay1,by1:Double;
begin
ax1:=(ImgInfos.Sx-1)/(ZoomFactor*ImgInfos.Sx-ZoomFactor);
bx1:=1-ax1;
ay1:=(ImgInfos.Sy-1)/(ZoomFactor*ImgInfos.Sy-ZoomFactor);
by1:=1-ay1;

ax:=(Img_Box.Width-1)/ZoomFactor/(Img_Box.Width-1);
bx:=ax1*Round(HorizScrollBar.Position)+bx1;
ay:=(Img_Box.Height-1)/ZoomFactor/(Img_Box.Height-1);
// Merde faut pas inverser ici / Pourquoi ? / Mystere et boule de gomme !
by:=ay1*Round(VerticScrollBar.Position)+by1;

Ximg:=Trunc(ax*X+bx);
Yimg:=Trunc(ay*Y+by);

Ximg:=Ximg;
Yimg:=ImgInfos.Sy-Yimg+1;

New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('Position X : ');
   ValeurDefaut:=Ximg;
   ValeurMin:=1;
   ValeurMax:=60000;
   end;

with TabItems^[2] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('Position Y : ');
   ValeurDefaut:=Yimg;
   ValeurMin:=1;
   ValeurMax:=60000;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.Caption:=lang('Coller Etoile');
if DlgStandard.ShowModal=mrOK then
   begin
   Ximg:=TabItems^[1].ValeurSortie;
   Yimg:=TabItems^[2].ValeurSortie;

   SaveUndo;
   AddStar(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.Sx,ImgInfos.Sy,PSFCopie,Ximg-9-1+PSFCopie.X,Yimg-9-1+PSFCopie.Y);
   VisuImg;
   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;

end;

procedure Tpop_image.ColleEtoile;
begin
AddStar(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.Sx,ImgInfos.Sy,PSFCopie,XimgCopie-9-1+PSFCopie.X,YimgCopie-9-1+PSFCopie.Y);
VisuImg;
end;

procedure Tpop_image.Couperltoile1Click(Sender: TObject);
begin
CoupeEtoile(OldX,OldY);
CollerEtoileIci.Enabled:=True;
CollerEtoile.Enabled:=True;
end;

procedure Tpop_image.CollerEtoileIciClick(Sender: TObject);
begin
ColleEtoileIci(OldX,OldY);
end;

procedure Tpop_image.Copierltoile1Click(Sender: TObject);
begin
CopieEtoile(OldX,OldY);
CollerEtoileIci.Enabled:=True;
CollerEtoile.Enabled:=True;
end;

procedure Tpop_image.CollerEtoileClick(Sender: TObject);
begin
ColleEtoile;
end;

procedure Tpop_image.EcranToImage(var X,Y:Integer);
var
   ax,bx,ay,by:Double;
   ax1,bx1,ay1,by1:Double;
begin
   ax1:=(ImgInfos.Sx-1)/(ZoomFactor*ImgInfos.Sx-ZoomFactor);
   bx1:=1-ax1;
   ay1:=(ImgInfos.Sy-1)/(ZoomFactor*ImgInfos.Sy-ZoomFactor);
   by1:=1-ay1;

   ax:=(Img_Box.Width-1)/ZoomFactor/(Img_Box.Width-1);
   bx:=ax1*Round(HorizScrollBar.Position)+bx1;
   ay:=(Img_Box.Height-1)/ZoomFactor/(Img_Box.Height-1);
   // Merde faut pas inverser ici / Pourquoi ? / Mystere et boule de gomme !
   by:=ay1*Round(VerticScrollBar.Position)+by1;

   X:=Trunc(ax*X+bx);
   Y:=Trunc(ay*Y+by);

   Y:=ImgInfos.Sy-Y+1;
end;

procedure Tpop_image.ImageToEcran(var X,Y:Integer);
var
   ax,bx,ay,by:Double;
   ax1,bx1,ay1,by1:Double;
begin
   ax1:=(ImgInfos.Sx-1)/(ZoomFactor*ImgInfos.Sx-ZoomFactor);
   bx1:=1-ax1;
   ay1:=(ImgInfos.Sy-1)/(ZoomFactor*ImgInfos.Sy-ZoomFactor);
   by1:=1-ay1;

   ax:=(Img_Box.Width-1)/ZoomFactor/(Img_Box.Width-1);
   bx:=ax1*Round(HorizScrollBar.Position)+bx1;
   ay:=(Img_Box.Height-1)/ZoomFactor/(Img_Box.Height-1);
   by:=ay1*Round(VerticScrollBar.Position)+by1;

   X:=Round((X-bx)/ax);
   Y:=Round(((ImgInfos.Sy-Y+1)-by)/ay);
end;


procedure Tpop_image.CicatriserPixel1Click(Sender: TObject);
var
   Ximg,YImg:Integer;
begin
   Ximg:=OldX;
   Yimg:=OldY;

   EcranToImage(XImg,YImg);

   if (XImg>1) and (XImg<ImgInfos.Sx) and (YImg>1) and (YImg<ImgInfos.Sy) then
      begin
      SaveUndo;
      CicatrisePixel(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Round(Ximg),Round(Yimg));
      if Config.BuidingCosmeticFile then pop_edit_text.Memo1.Lines.Add('HealPixel '+ //nolang
         IntToStr(Round(Ximg))+' '+IntToStr(Round(Yimg)));

      VisuImg;
      end;
end;

procedure Tpop_image.Cicatriserunecolonne1Click(Sender: TObject);
var
   Ximg,YImg:Integer;
begin
   Ximg:=OldX;
   Yimg:=OldY;

   EcranToImage(XImg,YImg);

   SaveUndo;
   CicatriseColonne(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Round(Ximg));
   if Config.BuidingCosmeticFile then pop_edit_text.Memo1.Lines.Add('HealColumn '+ //nolang
      IntToStr(Round(Ximg)));
   
   VisuImg;
end;

procedure Tpop_image.Cicatriseruneligne1Click(Sender: TObject);
var
   Ximg,YImg:Integer;
begin
   Ximg:=OldX;
   Yimg:=OldY;

   EcranToImage(XImg,YImg);

   SaveUndo;
   CicatriseLigne(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Round(Yimg));
   if Config.BuidingCosmeticFile then pop_edit_text.Memo1.Lines.Add('HealRow '+ //nolang
      IntToStr(Round(Yimg)));

   VisuImg;
end;

procedure Tpop_image.FFT1Click(Sender: TObject);
var
   ImgDoubleIn:PTabImgDouble;
   SxOld,SyOld,i,j:Integer;
begin
   Getmem(ImgDoubleIn,4);
   Getmem(ImgDoubleIn^[1],ImgInfos.Sy*4);
   for j:=1 to ImgInfos.Sy do
      begin
      Getmem(ImgDoubleIn^[1]^[j],ImgInfos.Sx*8);
      case ImgInfos.Typedata of
         2:for i:=1 to ImgInfos.Sx do ImgDoubleIn^[1]^[j]^[i]:=DataInt^[1]^[j]^[i];
         5:Move(DataDouble^[1]^[j],ImgDoubleIn^[1]^[j],8*ImgInfos.Sx)
         end;
      end;

   SxOld:=ImgInfos.Sx;
   SyOld:=ImgInfos.Sy;

   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   FFTDirect(DataInt,ImgDoubleIn,ImgInfos.Typedata,DataDouble,ImgInfos.Sx,ImgInfos.Sy);
   finally
   Screen.Cursor:=crDefault;
end;

case ImgInfos.Typedata of
   2:begin
     for j:=1 to SyOld do Freemem(DataInt^[1]^[j],SxOld*2);
     Freemem(DataInt^[1],SyOld*4);
     Freemem(DataInt,4);
     end;
   5:begin
     for j:=1 to SyOld do Freemem(ImgDoubleIn^[1]^[j],SxOld*8);
     Freemem(ImgDoubleIn^[1],SyOld*4);
     Freemem(ImgDoubleIn,4);
     end;
   end;

ImgInfos.Typedata:=6;
ImgInfos.NbPlans:=2;
ImgInfos.TypeComplexe:=1;
AjusteFenetre;
VisuAutoEtoiles;

ChangerMenu;
pop_main.MiseAJourMenu(Sender);
end;

procedure Tpop_image.FFTInverse1Click(Sender: TObject);
begin
Screen.Cursor:=crHourGlass;
try
SaveUndo;
FFTInverse(DataDouble,ImgInfos.Sx,ImgInfos.Sy);
ImgInfos.Typedata:=5;
ImgInfos.NbPlans:=1;
AjusteFenetre;
VisuAutoEtoiles;
ChangerMenu;
pop_main.MiseAJourMenu(Sender);
finally
Screen.Cursor:=crDefault;
end;
end;

procedure Tpop_image.CreerEtoile(X,Y:Integer);
var
Ximg,YImg:Double;
TabItems:PTabItems;
DlgStandard:Tpop_dlg_standard;
ax,bx,ay,by:Double;
ax1,bx1,ay1,by1:Double;
begin
ax1:=(ImgInfos.Sx-1)/(ZoomFactor*ImgInfos.Sx-ZoomFactor);
bx1:=1-ax1;
ay1:=(ImgInfos.Sy-1)/(ZoomFactor*ImgInfos.Sy-ZoomFactor);
by1:=1-ay1;

ax:=(Img_Box.Width-1)/ZoomFactor/(Img_Box.Width-1);
bx:=ax1*Round(HorizScrollBar.Position)+bx1;
ay:=(Img_Box.Height-1)/ZoomFactor/(Img_Box.Height-1);
// Merde faut pas inverser ici / Pourquoi ? / Mystere et boule de gomme !
by:=ay1*Round(VerticScrollBar.Position)+by1;

Ximg:=Trunc(ax*X+bx);
Yimg:=Trunc(ay*Y+by);

Ximg:=Ximg;
Yimg:=ImgInfos.Sy-Yimg+1;

New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('Position X : ');
   ValeurDefaut:=Ximg;
   ValeurMin:=1;
   ValeurMax:=60000;
   end;

with TabItems^[2] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('Position Y : ');
   ValeurDefaut:=Yimg;
   ValeurMin:=1;
   ValeurMax:=60000;
   end;

with TabItems^[3] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('Intensité maximum : ');
   ValeurDefaut:=16000;
   ValeurMin:=0;
   ValeurMax:=32767;
   end;

with TabItems^[4] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('FWHM X : ');
   ValeurDefaut:=1.5;
   ValeurMin:=0.1;
   ValeurMax:=30;
   end;

with TabItems^[5] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('FWHM Y : ');
   ValeurDefaut:=1.5;
   ValeurMin:=0.1;
   ValeurMax:=30;
   end;

with TabItems^[6] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('Angle : '); 
   ValeurDefaut:=0;
   ValeurMin:=-pi;
   ValeurMax:=pi;
   end;


DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.Caption:=lang('Coller Etoile');
if DlgStandard.ShowModal=mrOK then
   begin
   Ximg:=TabItems^[1].ValeurSortie;
   Yimg:=TabItems^[2].ValeurSortie;
   PSFCopie.IntensiteMax:=TabItems^[3].ValeurSortie;
   PSFCopie.SigmaX:=TabItems^[4].ValeurSortie;
   PSFCopie.SigmaY:=TabItems^[5].ValeurSortie;
   PSFCopie.Angle:=TabItems^[6].ValeurSortie;

   PSFCopie.X:=10;
   PSFCopie.Y:=10;

   SaveUndo;
   AddStar(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.Sx,ImgInfos.Sy,PSFCopie,Ximg-9-1+PSFCopie.X,Yimg-9-1+PSFCopie.Y);
   VisuImg;
   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;
end;

procedure Tpop_image.Creruneetoile1Click(Sender: TObject);
begin
CreerEtoile(OldX,OldY);
CollerEtoileIci.Enabled:=True;
CollerEtoile.Enabled:=True;
end;

procedure Tpop_image.EntiersversRels1Click(Sender: TObject);
begin
Screen.Cursor:=crHourGlass;
try
SaveUndo;
ConvertIntToReal(DataInt,DataDouble,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
if ImgInfos.Typedata=7 then ImgInfos.Typedata:=8 else ImgInfos.Typedata:=5;
finally
Screen.Cursor:=crDefault;
end;
ChangerMenu;
pop_main.MiseAJourMenu(Sender);
end;

procedure Tpop_image.Relsversentiers1Click(Sender: TObject);
begin
Screen.Cursor:=crHourGlass;
try
SaveUndo;
ConvertRealToInt(DataDouble,DataInt,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
if ImgInfos.Typedata=8 then ImgInfos.Typedata:=7 else ImgInfos.Typedata:=2;
finally
Screen.Cursor:=crDefault;
end;
ChangerMenu;
pop_main.MiseAJourMenu(Sender);
end;

procedure Tpop_image.Statistiques1Click(Sender: TObject);
var
i : integer;
Maxi,Mini,Mediane,Moy,Ecart:Double;
begin
if Rapport=nil then Rapport:=Tpop_Rapport.Create(Self);
Rapport.IsUsedByAnImage:=True;
Rapport.Image:=Self;
Rapport.Show;
Rapport.SaveDialog1.FileName:=caption+'.txt'; //nolang

Rapport.AddLine(lang('Statistiques de l''image ')+Caption);

Screen.Cursor:=crHourGlass;
try
Statistiques(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,Mini,Mediane,Maxi,Moy,Ecart);
finally
Screen.Cursor:=crDefault;
end;

case ImgInfos.Typedata of
   2:begin
     Rapport.AddLine('  '); //nolang
     Rapport.AddLine(lang('Minimum    : ') 
        +Format('%0.0f',[Mini])); //nolang
     Rapport.AddLine(lang('Maximum    : ')  
        +Format('%0.0f',[Maxi])); //nolang
     Rapport.AddLine(lang('Mediane    : ')
        +Format('%0.0f',[Mediane])); //nolang
     Rapport.AddLine(lang('Moyenne    : ')
        +Format('%0.3f',[Moy])); //nolang
     Rapport.AddLine(lang('Ecart type : ')
        +Format('%0.3f',[Ecart])); //nolang
     Rapport.AddLine('  '); //nolang
     end;
   5,6:begin
     Rapport.AddLine('  '); //nolang
     Rapport.AddLine(lang('Minimum    : ')
        +Format('%0.3f',[Mini])); //nolang
     Rapport.AddLine(lang('Maximum    : ')
        +Format('%0.3f',[Maxi])); //nolang
     Rapport.AddLine(lang('Mediane    : ')
        +Format('%0.3f',[Mediane])); //nolang
     Rapport.AddLine(lang('Moyenne    : ')
        +Format('%0.3f',[Moy])); //nolang
     Rapport.AddLine(lang('Ecart type : ')
        +Format('%0.3f',[Ecart])); //nolang
     Rapport.AddLine('  '); //nolang
     end;
   7,8:begin
     Rapport.AddLine('  '); //nolang
     for i:=1 to 3 do begin
       Statistiques(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,i,Mini,Mediane,Maxi,Moy,Ecart);
       Rapport.AddLine(colorname[i]);
       Rapport.AddLine(lang('Minimum    : ')
          +Format('%0.0f',[Mini])); //nolang
       Rapport.AddLine(lang('Maximum    : ')
          +Format('%0.0f',[Maxi])); //nolang
       Rapport.AddLine(lang('Mediane    : ')
          +Format('%0.0f',[Mediane])); //nolang
       Rapport.AddLine(lang('Moyenne    : ')
          +Format('%0.3f',[Moy])); //nolang
       Rapport.AddLine(lang('Ecart type : ')
          +Format('%0.3f',[Ecart])); //nolang
       Rapport.AddLine('  '); //nolang
     end;
     end;
   end;

//Rapport.AddLine(lang('Date       : ')+formatdatetime(datetimeFITS,imginfos.datetime));
//Rapport.AddLine('  '); //nolang

Rapport.Quitter.Enabled:=True;
Rapport.BitBtn1.Enabled:=True;
Rapport.BitBtn2.Enabled:=True;
Rapport.BitBtn3.Enabled:=True;
end;

procedure Tpop_image.StatFenetre(X1,Y1,X2,Y2:Integer);
var
SxNew,SyNew,i,j,k:Integer;
ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
Maxi,Mini,Mediane,Moy,Ecart:Double;
begin
ImgDouble:=nil;
SxNew:=X2-X1+1;
SyNew:=Y2-Y1+1;

GetmemImg(ImgInt,ImgDouble,SxNew,SyNew,ImgInfos.Typedata,ImgInfos.NbPlans);

try

for k:=1 to ImgInfos.NbPlans do
   case ImgInfos.Typedata of
      2,7:for j:=Y1 to Y2 do
            for i:=X1 to X2 do
               ImgInt^[k]^[j-Y1+1]^[i-X1+1]:=DataInt^[k]^[j]^[i];
      5,6,8:for j:=Y1 to Y2 do
               for i:=X1 to X2 do
                  ImgDouble^[k]^[j-Y1+1]^[i-X1+1]:=DataDouble^[k]^[j]^[i];
      end;

if Rapport=nil then Rapport:=Tpop_Rapport.Create(Self);
Rapport.IsUsedByAnImage:=True;
Rapport.Image:=Self;
Rapport.Show;

Rapport.AddLine(lang('Statistiques fenêtrées de l''image ')+Caption);
Rapport.AddLine(Format(lang('Entre %d,%d et %d,%d'),[X1,Y1,X2,Y2]));

Screen.Cursor:=crHourGlass;
try
Statistiques(ImgInt,ImgDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,SxNew,SyNew,1,Mini,Mediane,Maxi,Moy,Ecart);
finally
Screen.Cursor:=crDefault;
end;

case ImgInfos.Typedata of
   2:begin
     Rapport.AddLine('  '); //nolang
     Rapport.AddLine(lang('Minimum    : ')
        +Format('%0.0f',[Mini])); //nolang
     Rapport.AddLine(lang('Maximum    : ')
        +Format('%0.0f',[Maxi])); //nolang
     Rapport.AddLine(lang('Mediane    : ')
        +Format('%0.0f',[Mediane])); //nolang
     Rapport.AddLine(lang('Moyenne    : ')
        +Format('%0.3f',[Moy])); //nolang
     Rapport.AddLine(lang('Ecart type : ')
        +Format('%0.3f',[Ecart])); //nolang
     Rapport.AddLine('  '); //nolang
     end;
   5,6:begin
     Rapport.AddLine('  '); //nolang
     Rapport.AddLine(lang('Minimum    : ')
        +Format('%0.3f',[Mini])); //nolang
     Rapport.AddLine(lang('Maximum    : ')
        +Format('%0.3f',[Maxi])); //nolang
     Rapport.AddLine(lang('Mediane    : ')
        +Format('%0.3f',[Mediane])); //nolang
     Rapport.AddLine(lang('Moyenne    : ')
        +Format('%0.3f',[Moy])); //nolang
     Rapport.AddLine(lang('Ecart type : ')
        +Format('%0.3f',[Ecart])); //nolang
     Rapport.AddLine('  '); //nolang
     end;
   7,8:begin
     Rapport.AddLine('  '); //nolang
     for i:=1 to 3 do begin
       Statistiques(ImgInt,ImgDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,SxNew,SyNew,i,Mini,Mediane,Maxi,Moy,Ecart);
       Rapport.AddLine(colorname[i]);
       Rapport.AddLine(lang('Minimum    : ')
          +Format('%0.0f',[Mini])); //nolang
       Rapport.AddLine(lang('Maximum    : ')
          +Format('%0.0f',[Maxi])); //nolang
       Rapport.AddLine(lang('Mediane    : ')
          +Format('%0.0f',[Mediane])); //nolang
       Rapport.AddLine(lang('Moyenne    : ')
          +Format('%0.3f',[Moy])); //nolang
       Rapport.AddLine(lang('Ecart type : ')
          +Format('%0.3f',[Ecart])); //nolang
       Rapport.AddLine('  '); //nolang
     end;
     end;
   end;

Rapport.Quitter.Enabled:=True;
Rapport.BitBtn1.Enabled:=True;
Rapport.BitBtn2.Enabled:=True;
Rapport.BitBtn3.Enabled:=True;

finally
FreememImg(ImgInt,ImgDouble,SxNew,SyNew,ImgInfos.Typedata,ImgInfos.NbPlans);
end;
end;

procedure Tpop_image.Statistiquesfentres1Click(Sender: TObject);
begin
if TypePointage=PointeOff then
   begin
   TypePointage:=PointeStatFenetre;
   FormePointage:=Reticule;
   ClipOn;
   end;
end;

procedure Tpop_image.Produitdintercorrlation1Click(Sender: TObject);
var
pop_select_img:Tpop_select_img;
Image:tpop_image;
ImgDouble:PTabImgDouble;
begin
pop_select_img:=Tpop_select_img.Create(Application);
try
pop_select_img.LabelImgCourante.Caption:=lang('Image courante : ')+Caption;
pop_select_img.LabelQuestion.Caption:=lang('Sélectionnez l''image à inter-corréler');
if (pop_select_img.ShowModal=mrOK) and (pop_select_img.image_selectionnee<>nil) then
   begin
   Screen.Cursor:=crHourGlass;
   try
   Image:=pop_select_img.image_selectionnee;
   SaveUndo;
   InterCorrele(DataInt,Image.DataInt,DataDouble,Image.DataDouble,ImgDouble,ImgInfos.Typedata,ImgInfos.Sx,ImgInfos.Sy);
   DataDouble:=ImgDouble;
   ImgInfos.Typedata:=5;
   ImgInfos.NbPlans:=1;
   ChangerMenu;
   pop_main.MiseAJourMenu(Sender);
   AjusteFenetre;
   VisuAutoEtoiles;
   finally
   Screen.Cursor:=crDefault;
   end;
   end;
finally
pop_select_img.Free;
end;
end;

procedure Tpop_image.Produitdautocorrelation1Click(Sender: TObject);
var
ImgDouble:PTabImgDouble;
begin
SaveUndo;
AutoCorrele(DataInt,DataDouble,ImgDouble,ImgInfos.Typedata,ImgInfos.Sx,ImgInfos.Sy);
DataDouble:=ImgDouble;
ImgInfos.Typedata:=5;
ImgInfos.NbPlans:=1;
ChangerMenu;
pop_main.MiseAJourMenu(Sender);
AjusteFenetre;
VisuAutoEtoiles;
end;

procedure Tpop_image.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
Position,OldPosition:TPoint;
XTemp,YTemp:Integer;
ax,bx,ay,by:Double;
ax1,bx1,ay1,by1:Double;
XinitEcran,YinitEcran,XEcran,YEcran:Integer;
Ximg,YImg:Integer;
begin
{GetCursorPos(Point);
Point:=img_box.ScreenToClient(Point);
X:=Point.X;
Y:=Point.Y;

ax1:=(ImgInfos.Sx-1)/(ZoomFactor*ImgInfos.Sx-ZoomFactor);
bx1:=1-ax1;
ay1:=(ImgInfos.Sy-1)/(ZoomFactor*ImgInfos.Sy-ZoomFactor);
by1:=1-ay1;

ax:=(Img_Box.Width-1)/ZoomFactor/(Img_Box.Width-1);
bx:=ax1*Round(HorizScrollBar.Position)+bx1;
ay:=(Img_Box.Height-1)/ZoomFactor/(Img_Box.Height-1);
// Merde faut pas inverser ici / Pourquoi ? / Mystere et boule de gomme !
by:=ay1*Round(VerticScrollBar.Position)+by1;

XEcran:=Trunc(ax*X+bx);
YEcran:=Trunc(ay*Y+by);
XinitEcran:=Trunc(ax*Xinit+bx);
YinitEcran:=Trunc(ay*YInit+by);}

GetCursorPos(Position);
OldPosition:=Position;
case Key of
   VK_LEFT: Dec(Position.X);
   VK_UP:   Dec(Position.Y);
   VK_RIGHT:Inc(Position.X);
   VK_DOWN: Inc(Position.Y);
   end;
SetCursorPos(Position.X,Position.Y);
Position:=img_box.ScreenToClient(Position);

ax1:=(ImgInfos.Sx-1)/(ZoomFactor*ImgInfos.Sx-ZoomFactor);
bx1:=1-ax1;
ay1:=(ImgInfos.Sy-1)/(ZoomFactor*ImgInfos.Sy-ZoomFactor);
by1:=1-ay1;

ax:=(Img_Box.Width-1)/ZoomFactor/(Img_Box.Width-1);
bx:=ax1*Round(HorizScrollBar.Position)+bx1;
ay:=(Img_Box.Height-1)/ZoomFactor/(Img_Box.Height-1);
// Merde faut pas inverser ici / Pourquoi ? / Mystere et boule de gomme !
by:=ay1*Round(VerticScrollBar.Position)+by1;

XEcran:=Trunc(ax*Position.X+bx);
YEcran:=Trunc(ay*Position.Y+by);
XinitEcran:=Trunc(ax*Xinit+bx);
YinitEcran:=Trunc(ay*YInit+by);

//Position:=img_box.ScreenToClient(Position);

if Key=VK_RETURN then
   begin
   if FormePointage=Rectangle then
      begin
      // On efface le rectangle à l'ancienne position
      Img_Box.Canvas.Pen.Color:=ClWhite;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=PmXor;
      Img_Box.Canvas.Brush.Style:=bsClear;
      Img_Box.Canvas.Rectangle(Xinit,Yinit,OldX,OldY);

      case TypePointage of
         PointeFenetrage:begin
                         TypePointage:=PointeOff;
                         FormePointage:=Off;
                         if XinitEcran>XEcran then
                            begin
                            XTemp:=XinitEcran;
                            XinitEcran:=XEcran;
                            XEcran:=XTemp;
                            end;
                         if YinitEcran>YEcran then
                            begin
                            YTemp:=YinitEcran;
                            YinitEcran:=YEcran;
                            YEcran:=YTemp;
                            end;
                         Fenetrage(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,XinitEcran,YinitEcran,XEcran,YEcran);
                         AjusteFenetre;
                         VisuImg;
                         ClipOff;                         
                         end;
         PointeStatFenetre:begin
                         TypePointage:=PointeOff;
                         FormePointage:=Off;
                         if XinitEcran>XEcran then
                            begin
                            XTemp:=XinitEcran;
                            XinitEcran:=XEcran;
                            XEcran:=XTemp;
                            end;
                         if YinitEcran>YEcran then
                            begin
                            YTemp:=YinitEcran;
                            YinitEcran:=YEcran;
                            YEcran:=YTemp;
                            end;
                         StatFenetre(XinitEcran,YinitEcran,XEcran,YEcran);
                         VisuImg;
                         ClipOff;
                         end;
         end;
      end;

   if ((FormePointage=Reticule) or (FormePointage=Ligne)) and ReticulePresent then
      begin
      // On efface le réticule
      ReticulePresent:=False;
//      WriteSpy('Reticule Off formkeydown');
      Img_Box.Canvas.Pen.Color:=ClWhite;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=PmXor;
      Img_Box.Canvas.MoveTo(OldX,0);
      Img_Box.Canvas.LineTo(OldX,Img_Box.Height);
      Img_Box.Canvas.MoveTo(0,OldY);
      Img_Box.Canvas.LineTo(Img_Box.Width,OldY);
      Img_Box.Update;

      case TypePointage of
         PointeEtalon:begin
                      TypePointage:=PointeOff;
                      FormePointage:=Off;
                      ClipOff;
                      EtalonnePhotometrie(XEcran,YEcran);
                      end;
         EnleveEtalon:begin
                      TypePointage:=PointeOff;
                      FormePointage:=Off;
                      ClipOff;
                      DoEnleveEtalon(XEcran,YEcran);
                      end;
         SupprimeEtalon:begin
                        TypePointage:=PointeOff;
                        FormePointage:=Off;
                        ClipOff;
                        DoSupprimeEtalon(XEcran,YEcran);
                        end;
         PointeMagnitude:begin
                        TypePointage:=PointeOff;
                        FormePointage:=Off;
                        ClipOff;
                        MesurePhotometrie(XEcran,YEcran);
                        end;
         PointeEtoile:begin
                      TypePointage:=PointeOff;
                      FormePointage:=Off;
                      ClipOff;
                      MesureEtoile(XEcran,YEcran);
                      end;
         PointeFenetrage:begin
                         FormePointage:=Rectangle;
                         Xinit:=Position.X;
                         Yinit:=Position.Y;
//                         ClipOn;
                         end;
         PointeStatFenetre:begin
                         FormePointage:=Rectangle;
                         Xinit:=Position.X;
                         Yinit:=Position.Y;
//                         ClipOn;
                         end;
         PointeAstrometrie:begin
                           TypePointage:=PointeOff;
                           FormePointage:=Off;
                           ClipOff;
                           MesureAstrometrie(XEcran,YEcran);
                           end;
         PointeCicatLigne:begin
                          TypePointage:=PointeOff;
                          FormePointage:=Off;
                          ClipOff;

                          Ximg:=OldX;
                          Yimg:=OldY;
                          EcranToImage(XImg,YImg);

                          SaveUndo;
                          CicatriseLigne(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Round(Yimg));
                          if Config.BuidingCosmeticFile then pop_edit_text.Memo1.Lines.Add('HealRow '+ //nolang
                             IntToStr(Round(Yimg)));
                          VisuImg;
                          end;
         PointeCicatColonne:begin
                            TypePointage:=PointeOff;
                            FormePointage:=Off;
                            ClipOff;

                            Ximg:=OldX;
                            Yimg:=OldY;
                            EcranToImage(XImg,YImg);

                            SaveUndo;
                            CicatriseColonne(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Round(Ximg));
                            if Config.BuidingCosmeticFile then pop_edit_text.Memo1.Lines.Add('HealColumn '+ //nolang
                               IntToStr(Round(Yimg)));
                            VisuImg;
                            end;
         PointeCicatPixel:begin
                          TypePointage:=PointeOff;
                          FormePointage:=Off;
                          ClipOff;

                          Ximg:=OldX;
                          Yimg:=OldY;
                          EcranToImage(XImg,YImg);

                          SaveUndo;
                          CicatrisePixel(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Round(Ximg),Round(Yimg));
                          if Config.BuidingCosmeticFile then pop_edit_text.Memo1.Lines.Add('HealPixel '+ //nolang
                             IntToStr(Round(Ximg))+' '+IntToStr(Round(Yimg)));
                          VisuImg;
                          end;
         CoupePhoto:begin
                    FormePointage:=Ligne;
                    Xinit:=Position.X;
                    Yinit:=Position.Y;
                    end;
         AjouteMarque:begin
                      TypePointage:=PointeOff;
                      FormePointage:=Off;
                      ClipOff;
                      XMarque:=XEcran+1;
                      YMarque:=ImgInfos.Sy-YEcran;
                      AjouterMarque1.Checked:=False;
                      AjusteFenetre;
                      VisuImg;
                      end;
         end;
//      ClipOff;
      end;
   // Necessaire pour afficher les etalons et mesures
   VisuImg;
   end
// Necessaire pour afficher les etalons et mesures
//VisuImg;

else if Key=VK_ESCAPE then
   begin
   if ((FormePointage=Reticule) or (FormePointage=Ligne)) and ReticulePresent then
      begin
      // On efface le réticule
      ReticulePresent:=False;
//      WriteSpy('Reticule Off formkeydown');
      Img_Box.Canvas.Pen.Color:=ClWhite;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=PmXor;
      Img_Box.Canvas.MoveTo(OldX,0);
      Img_Box.Canvas.LineTo(OldX,Img_Box.Height);
      Img_Box.Canvas.MoveTo(0,OldY);
      Img_Box.Canvas.LineTo(Img_Box.Width,OldY);
      Img_Box.Update;
      ClipOff;
      end;
   if FormePointage=Rectangle then
      begin
      // On efface le rectangle à l'ancienne position
      Img_Box.Canvas.Pen.Color:=ClWhite;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=PmXor;
      Img_Box.Canvas.Brush.Style:=bsClear;
      Img_Box.Canvas.Rectangle(Xinit,Yinit,OldX,OldY);
      Img_Box.Update;
      ClipOff;
      end;
   TypePointage:=PointeOff;
   FormePointage:=Off;
   end

else if ClipIsOn then
   begin
   if ((FormePointage=Reticule) or (FormePointage=Ligne)) and ReticulePresent then
      begin
      // On efface le reticule à l'ancienne position
//      WriteSpy('Reticule Off mousemove');
      ReticulePresent:=False;
      Img_Box.Canvas.Pen.Color:=ClWhite;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=PmXor;
      Img_Box.Canvas.Brush.Style:=bsClear;
      Img_Box.Canvas.MoveTo(OldX,0);
      Img_Box.Canvas.LineTo(OldX,Img_Box.Height);
      Img_Box.Canvas.MoveTo(0,OldY);
      Img_Box.Canvas.LineTo(Img_Box.Width,OldY);
      end;
   if FormePointage=Rectangle then
      begin
      // On efface le rectangle à l'ancienne position
      Img_Box.Canvas.Pen.Color:=ClWhite;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=PmXor;
      Img_Box.Canvas.Brush.Style:=bsClear;
      Img_Box.Canvas.Rectangle(Xinit,Yinit,OldX,OldY);
      end;
   if FormePointage=Ligne then
      begin
      // On efface la ligne à l'ancienne position
      Img_Box.Canvas.pen.Mode:=pmXor;
      Img_Box.Canvas.MoveTo(Xinit,Yinit);
      Img_Box.Canvas.LineTo(OldX,OldY);
      end;

   // Marche pas pour le pointage des rectangles
   // Faudrait garder en memoire les coordonnes images
   // Trop complique
   if (FormePointage<>Rectangle) and (FormePointage<>Ligne) then
      begin
      if XEcran+Img_Box.Left<=1 then
         begin
         HorizScrollBar.Position:=HorizScrollBar.Position-HorizScrollBar.SmallChange;
         VisuImg;
         Update;
         end;
      if XEcran+Img_Box.Left>=Img_Box.Width-1 then
         begin
         HorizScrollBar.Position:=HorizScrollBar.Position+HorizScrollBar.SmallChange;
         VisuImg;
         Update;
         end;
      if YEcran+Img_Box.Top<=1 then
         begin
         VerticScrollBar.Position:=VerticScrollBar.Position-VerticScrollBar.SmallChange;
         VisuImg;
         Update;
         end;
      if YEcran+Img_Box.Top>=Img_Box.Height-1 then
         begin
         VerticScrollBar.Position:=VerticScrollBar.Position+VerticScrollBar.SmallChange;
         VisuImg;
         Update;
         end;
      end;

   if ((FormePointage=Reticule) or (FormePointage=Ligne)) and not ReticulePresent then
      begin
      // On affiche le reticule à la nouvelle position
      ReticulePresent:=True;
//      WriteSpy('Reticule On mousemove');
      Img_Box.Canvas.Pen.Color:=ClWhite;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=PmXor;
      Img_Box.Canvas.Brush.Style:=bsClear;
      Img_Box.Canvas.MoveTo(XEcran,0);
      Img_Box.Canvas.LineTo(XEcran,Img_Box.Height);
      Img_Box.Canvas.MoveTo(0,YEcran);
      Img_Box.Canvas.LineTo(Img_Box.Width,YEcran);
      end;
   if FormePointage=Rectangle then
      begin
      // On affiche le rectangle à la nouvelle position
      Img_Box.Canvas.Pen.Color:=ClWhite;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=PmXor;
      Img_Box.Canvas.Brush.Style:=bsClear;
      Img_Box.Canvas.Rectangle(Xinit,Yinit,XEcran,YEcran);
      end;
   if FormePointage=Ligne then
      begin
      // On affiche la ligne à l'ancienne position
      Img_Box.Canvas.pen.Mode:=pmXor;
      Img_Box.Canvas.MoveTo(Xinit,Yinit);
      Img_Box.Canvas.LineTo(XEcran,YEcran);
      end;

   end;

OldX:=XEcran;
OldY:=YEcran;
end;

procedure Tpop_image.ValeurAbsolue1Click(Sender: TObject);
begin
Screen.Cursor:=crHourGlass;
try
SaveUndo;
ValAbs(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
AjusteFenetre;
VisuAutoEtoiles;
finally
Screen.Cursor:=crDefault;
end;
end;

procedure Tpop_image.outBlink1Click(Sender: TObject);
var
pop_select_img:Tpop_select_img;
Blink:Tpop_blink;
begin
pop_select_img:=Tpop_select_img.Create(Application);
try
pop_select_img.LabelImgCourante.Caption:=lang('Image courante : ')+Caption;
pop_select_img.LabelQuestion.Caption:=lang('Sélectionnez l''image à comparer');
pop_select_img.NotSameSize:=True;
if (pop_select_img.ShowModal=mrOK) and (pop_select_img.image_selectionnee<>nil) then
   begin
   Blink:=Tpop_blink.Create(Application);
   try
   Blink.Img_box1.Picture.Bitmap.Handle:=VisuImgAPI(DataInt,DataDouble,ImgInfos,1,1,1,ImgInfos.Sx,
      ImgInfos.Sy,ImgInfos.Sx,ImgInfos.Sy);
   Blink.Img_box1.Width:=ImgInfos.Sx;
   Blink.Img_box1.Height:=ImgInfos.Sy;
   Blink.Name1:=Caption;

   Blink.Img_box2.Picture.Bitmap.Handle:=VisuImgAPI(pop_select_img.image_selectionnee.DataInt,
      pop_select_img.image_selectionnee.DataDouble,pop_select_img.image_selectionnee.ImgInfos,
      1,1,1,pop_select_img.image_selectionnee.ImgInfos.Sx,pop_select_img.image_selectionnee.ImgInfos.Sy,
      pop_select_img.image_selectionnee.ImgInfos.Sx,pop_select_img.image_selectionnee.ImgInfos.Sy);
   Blink.Img_box2.Width:=pop_select_img.image_selectionnee.ImgInfos.Sx;
   Blink.Img_box2.Height:=pop_select_img.image_selectionnee.ImgInfos.Sy;
   Blink.Name2:=pop_select_img.image_selectionnee.Caption;
   Blink.Show;
   except
   Blink.Free;
   end;
   end;
finally
pop_select_img.Free;
end;

end;

procedure Tpop_image.Compositage1Click(Sender: TObject);
var
pop_select_img:Tpop_select_img;
begin
pop_select_img:=Tpop_select_img.Create(Application);
try
pop_select_img.LabelImgCourante.Caption:=lang('Image courante : ')+Caption;
pop_select_img.LabelQuestion.Caption:=lang('Sélectionnez l''image à compositer');
pop_select_img.NotSameSize:=True;
pop_select_img.NotSameNbOfPlane:=True;
pop_select_img.NotSameType:=True;
if (pop_select_img.ShowModal=mrOK) and (pop_select_img.image_selectionnee<>nil) then
   begin
   Screen.Cursor:=crHourGlass;
   try
   if Rapport=nil then Rapport:=Tpop_Rapport.Create(Self);
   Rapport.IsUsedByAnImage:=True;
   Rapport.Image:=Self;
   try
   Rapport.Show;
   pop_select_img.image_selectionnee.SaveUndo;
   CompositeMorphing(DataInt,pop_select_img.image_selectionnee.DataInt,DataDouble,
      pop_select_img.image_selectionnee.DataDouble,ImgInfos.Typedata,pop_select_img.image_selectionnee.ImgInfos.TypeData,
      ImgInfos.NbPlans,pop_select_img.image_selectionnee.ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,
      pop_select_img.image_selectionnee.ImgInfos.Sx,pop_select_img.image_selectionnee.ImgInfos.Sy,Rapport);
   pop_select_img.image_selectionnee.VisuImg;
   finally
   Rapport.Quitter.Enabled:=True;
   Rapport.BitBtn1.Enabled:=True;
   Rapport.BitBtn2.Enabled:=True;
   Rapport.BitBtn3.Enabled:=True;   
   end;
   finally
   Screen.Cursor:=crDefault;
   end;
   end;
finally
pop_select_img.Free;
end;
end;

procedure Tpop_image.Statistiquesdunlot1Click(Sender: TObject);
begin
pop_main.Statistiquesdunlot1Click(Sender);
end;

procedure Tpop_image.Matriciel1Click(Sender: TObject);
var
pop_filtre:Tpop_filtre;
ImgDouble:PImgDouble;
i,Largeur:Integer;
begin
pop_filtre:=Tpop_filtre.Create(Application);
try
if pop_filtre.ShowModal=mrOK then
   begin
   Screen.Cursor:=crHourGlass;
   try
   pop_filtre.GetFiltre(ImgDouble,Largeur);
   pop_filtre.Cache;
   SaveUndo;
   Matrice(DataInt,DataDouble,ImgDouble,Largeur,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;
   end;
finally
pop_filtre.free;
if ImgDouble<>nil then
   begin
   for i:=1 to Largeur do Freemem(ImgDouble^[i],Largeur*8);
   Freemem(ImgDouble,Largeur*4);
   end;
end;
end;

procedure Tpop_image.TrsFort1Click(Sender: TObject);
var
ImgDouble:PImgDouble;
i:Integer;
begin
Getmem(ImgDouble,3*4);
for i:=1 to 3 do Getmem(ImgDouble^[i],3*8);

try

ImgDouble^[1]^[1]:=1; ImgDouble^[1]^[2]:=1; ImgDouble^[1]^[3]:=1;
ImgDouble^[2]^[1]:=1; ImgDouble^[2]^[2]:=1; ImgDouble^[2]^[3]:=1;
ImgDouble^[3]^[1]:=1; ImgDouble^[3]^[2]:=1; ImgDouble^[3]^[3]:=1;

Screen.Cursor:=crHourGlass;
try
SaveUndo;
Matrice(DataInt,DataDouble,ImgDouble,3,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
VisuImg;
finally
Screen.Cursor:=crDefault;
end;

finally
for i:=1 to 3 do Freemem(ImgDouble^[i],3*8);
Freemem(ImgDouble,3*4);
end
end;

procedure Tpop_image.Fort1Click(Sender: TObject);
var
ImgDouble:PImgDouble;
i:Integer;
begin
Getmem(ImgDouble,3*4);
for i:=1 to 3 do Getmem(ImgDouble^[i],3*8);

try

ImgDouble^[1]^[1]:=1; ImgDouble^[1]^[2]:=1; ImgDouble^[1]^[3]:=1;
ImgDouble^[2]^[1]:=1; ImgDouble^[2]^[2]:=4; ImgDouble^[2]^[3]:=1;
ImgDouble^[3]^[1]:=1; ImgDouble^[3]^[2]:=1; ImgDouble^[3]^[3]:=1;

Screen.Cursor:=crHourGlass;
try
SaveUndo;
Matrice(DataInt,DataDouble,ImgDouble,3,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
VisuImg;
finally
Screen.Cursor:=crDefault;
end;

finally
for i:=1 to 3 do Freemem(ImgDouble^[i],3*8);
Freemem(ImgDouble,3*4);
end
end;

procedure Tpop_image.Faible1Click(Sender: TObject);
var
ImgDouble:PImgDouble;
i:Integer;
begin
Getmem(ImgDouble,3*4);
for i:=1 to 3 do Getmem(ImgDouble^[i],3*8);

try

ImgDouble^[1]^[1]:=1; ImgDouble^[1]^[2]:=1; ImgDouble^[1]^[3]:=1;
ImgDouble^[2]^[1]:=1; ImgDouble^[2]^[2]:=8; ImgDouble^[2]^[3]:=1;
ImgDouble^[3]^[1]:=1; ImgDouble^[3]^[2]:=1; ImgDouble^[3]^[3]:=1;

Screen.Cursor:=crHourGlass;
try
SaveUndo;
Matrice(DataInt,DataDouble,ImgDouble,3,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
VisuImg;
finally
Screen.Cursor:=crDefault;
end;

finally
for i:=1 to 3 do Freemem(ImgDouble^[i],3*8);
Freemem(ImgDouble,3*4);
end
end;

procedure Tpop_image.TrsFaible1Click(Sender: TObject);
var
ImgDouble:PImgDouble;
i:Integer;
begin
Getmem(ImgDouble,3*4);
for i:=1 to 3 do Getmem(ImgDouble^[i],3*8);

try

ImgDouble^[1]^[1]:=1; ImgDouble^[1]^[2]:=1; ImgDouble^[1]^[3]:=1;
ImgDouble^[2]^[1]:=1; ImgDouble^[2]^[2]:=12; ImgDouble^[2]^[3]:=1;
ImgDouble^[3]^[1]:=1; ImgDouble^[3]^[2]:=1; ImgDouble^[3]^[3]:=1;

Screen.Cursor:=crHourGlass;
try
SaveUndo;
Matrice(DataInt,DataDouble,ImgDouble,3,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
VisuImg;
finally
Screen.Cursor:=crDefault;
end;

finally
for i:=1 to 3 do Freemem(ImgDouble^[i],3*8);
Freemem(ImgDouble,3*4);
end
end;

procedure Tpop_image.TrsFort2Click(Sender: TObject);
var
ImgDouble:PImgDouble;
i:Integer;
begin
Getmem(ImgDouble,3*4);
for i:=1 to 3 do Getmem(ImgDouble^[i],3*8);

try

ImgDouble^[1]^[1]:=-1; ImgDouble^[1]^[2]:=-1; ImgDouble^[1]^[3]:=-1;
ImgDouble^[2]^[1]:=-1; ImgDouble^[2]^[2]:=10; ImgDouble^[2]^[3]:=-1;
ImgDouble^[3]^[1]:=-1; ImgDouble^[3]^[2]:=-1; ImgDouble^[3]^[3]:=-1;

Screen.Cursor:=crHourGlass;
try
SaveUndo;
Matrice(DataInt,DataDouble,ImgDouble,3,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
VisuImg;
finally
Screen.Cursor:=crDefault;
end;

finally
for i:=1 to 3 do Freemem(ImgDouble^[i],3*8);
Freemem(ImgDouble,3*4);
end
end;

procedure Tpop_image.Fort2Click(Sender: TObject);
var
ImgDouble:PImgDouble;
i:Integer;
begin
Getmem(ImgDouble,3*4);
for i:=1 to 3 do Getmem(ImgDouble^[i],3*8);

try

ImgDouble^[1]^[1]:=-1; ImgDouble^[1]^[2]:=-1; ImgDouble^[1]^[3]:=-1;
ImgDouble^[2]^[1]:=-1; ImgDouble^[2]^[2]:=16; ImgDouble^[2]^[3]:=-1;
ImgDouble^[3]^[1]:=-1; ImgDouble^[3]^[2]:=-1; ImgDouble^[3]^[3]:=-1;

Screen.Cursor:=crHourGlass;
try
SaveUndo;
Matrice(DataInt,DataDouble,ImgDouble,3,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
VisuImg;
finally
Screen.Cursor:=crDefault;
end;

finally
for i:=1 to 3 do Freemem(ImgDouble^[i],3*8);
Freemem(ImgDouble,3*4);
end
end;

procedure Tpop_image.Faible2Click(Sender: TObject);
var
ImgDouble:PImgDouble;
i:Integer;
begin
Getmem(ImgDouble,3*4);
for i:=1 to 3 do Getmem(ImgDouble^[i],3*8);

try

ImgDouble^[1]^[1]:=0; ImgDouble^[1]^[2]:=-1; ImgDouble^[1]^[3]:=0;
ImgDouble^[2]^[1]:=-1; ImgDouble^[2]^[2]:=10; ImgDouble^[2]^[3]:=-1;
ImgDouble^[3]^[1]:=0; ImgDouble^[3]^[2]:=-1; ImgDouble^[3]^[3]:=0;

Screen.Cursor:=crHourGlass;
try
SaveUndo;
Matrice(DataInt,DataDouble,ImgDouble,3,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
VisuImg;
finally
Screen.Cursor:=crDefault;
end;

finally
for i:=1 to 3 do Freemem(ImgDouble^[i],3*8);
Freemem(ImgDouble,3*4);
end
end;

procedure Tpop_image.TrsFaible2Click(Sender: TObject);
var
ImgDouble:PImgDouble;
i:Integer;
begin
Getmem(ImgDouble,3*4);
for i:=1 to 3 do Getmem(ImgDouble^[i],3*8);

try

ImgDouble^[1]^[1]:=0; ImgDouble^[1]^[2]:=-1; ImgDouble^[1]^[3]:=0;
ImgDouble^[2]^[1]:=-1; ImgDouble^[2]^[2]:=20; ImgDouble^[2]^[3]:=-1;
ImgDouble^[3]^[1]:=0; ImgDouble^[3]^[2]:=-1; ImgDouble^[3]^[3]:=0;

Screen.Cursor:=crHourGlass;
try
SaveUndo;
Matrice(DataInt,DataDouble,ImgDouble,3,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
VisuImg;
finally
Screen.Cursor:=crDefault;
end;

finally
for i:=1 to 3 do Freemem(ImgDouble^[i],3*8);
Freemem(ImgDouble,3*4);
end
end;

procedure Tpop_image.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

procedure Tpop_image.ExtraitOndelettes1Click(Sender: TObject);
var
ImgOut:PTabTabImgDouble;
pop_image:tpop_image;
MaxDim,NbOnd,i,j,k:Integer;
MaxOnd:Double;

TabItems:PTabItems;
DlgStandard:Tpop_dlg_standard;
begin
if ImgInfos.Sx>ImgInfos.Sy then MaxDim:=ImgInfos.Sx else MaxDim:=ImgInfos.Sy;
MaxOnd:=int(ln(3*MaxDim/4)/ln(2));

New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiInteger;
   Msg:=lang('Nombre de plans à extraire : ');
   ValeurIncrement:=1;
   if MaxOnd>5 then ValeurDefaut:=5 else ValeurDefaut:=MaxOnd;
   ValeurMin:=1;
   ValeurMax:=MaxOnd;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.Caption:=lang('Extrait Ondelettes');
if DlgStandard.ShowModal=mrOK then
   begin
   NbOnd:=Round(TabItems^[1].ValeurSortie);

   Screen.Cursor:=crHourGlass;
   try
   ExtractOndelettes(DataInt,DataDouble,ImgOut,ImgInfos.NbPlans,ImgInfos.Typedata,ImgInfos.Sx,ImgInfos.Sy,NbOnd);
   for i:=1 to NbOnd+1 do
      begin
      pop_image:=tpop_image.create(application);
      pop_image.ImgInfos.Sx:=ImgInfos.Sx;
      pop_image.ImgInfos.Sy:=ImgInfos.Sy;
      if Self.ImgInfos.Typedata in [2,5] then pop_image.ImgInfos.Typedata:=5 else pop_image.ImgInfos.Typedata:=8;
      pop_image.ImgInfos.NbPlans:=Self.ImgInfos.NbPlans;
      if i<>NbOnd+1 then
         pop_image.Caption:=pop_main.GiveName(Caption+lang(' {plan')+IntToStr(i)+'}',pop_image)
      else
         pop_image.Caption:=pop_main.GiveName(Caption+lang(' {résidus}'),pop_image);

      Getmem(pop_image.DataDouble,ImgInfos.NbPlans*4);
      for j:=1 to ImgInfos.NbPlans do
         begin
         Getmem(pop_image.DataDouble^[j],4*ImgInfos.Sy);
         for k:=1 to ImgInfos.Sy do
            begin
            Getmem(pop_image.DataDouble^[j]^[k],ImgInfos.Sx*8);
            Move(ImgOut^[i]^[j]^[k]^,pop_image.DataDouble^[j]^[k]^,ImgInfos.Sx*8);
            end;
         end;
      pop_image.AjusteFenetre;
      pop_image.VisuAutoEtoiles;
      end;
   finally
   Screen.Cursor:=crDefault;
   end;

   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;
end;

procedure Tpop_image.Renforcementdondelettes1Click(Sender: TObject);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;

   NbOnd,MaxDim:Integer;
   MaxOnd:Double;

   pop_ondelettes: Tpop_ondelettes;
begin
   if ImgInfos.Sx>ImgInfos.Sy then MaxDim:=ImgInfos.Sx else MaxDim:=ImgInfos.Sy;
   MaxOnd:=int(ln(3*MaxDim/4)/ln(2));
   if MaxOnd>10 then MaxOnd:=10;

   New(TabItems);
   try
   IniTabItems(TabItems);

   with TabItems^[1] do
      begin
      TypeItem:=tiInteger;
      Msg:=lang('Nombre de plans à extraire : ');
      ValeurIncrement:=1;
      ValeurDefaut:=MaxOnd;
      ValeurMin:=1;
      ValeurMax:=MaxOnd;
      end;

   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
   DlgStandard.Caption:=lang('Renforcement d''ondelettes');
   if DlgStandard.ShowModal=mrOK then
      begin
      NbOnd:=Round(TabItems^[1].ValeurSortie);

      pop_ondelettes:=Tpop_ondelettes.Create(Application);

      pop_ondelettes.pop_image:=Self;
      pop_ondelettes.NbOnd:=NbOnd;
      pop_ondelettes.LargX:=ImgInfos.Sx;
      pop_ondelettes.LargY:=ImgInfos.Sy;
      if Self.ImgInfos.Typedata in [2,5] then pop_ondelettes.Typedata:=5 else pop_ondelettes.Typedata:=8;
      pop_ondelettes.NbPlans:=ImgInfos.NbPlans;
      pop_ondelettes.ShowModal;
      end
   else DlgStandard.Free;

   finally
   Dispose(TabItems);
   end;
end;

procedure Tpop_image.Mdian1Click(Sender: TObject);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   LargFiltre:Integer;
begin
   New(TabItems);
   try
   IniTabItems(TabItems);

   with TabItems^[1] do
      begin
      TypeItem:=tiInteger;
      Msg:=lang('Largeur du filtre : ');
      ValeurDefaut:=3;
      ValeurIncrement:=2;
      ValeurMin:=3;
      ValeurMax:=99
      end;

   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
   DlgStandard.Caption:=lang('Médian');
   if DlgStandard.ShowModal=mrOK then
      begin
      LargFiltre:=Round(TabItems^[1].ValeurSortie);

      Screen.Cursor:=crHourGlass;
      try
      SaveUndo;
      Median(DataInt,DataDouble,LargFiltre,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
      VisuImg;
      finally
      Screen.Cursor:=crDefault;
      end;

      end
   else DlgStandard.Free;

   finally
   Dispose(TabItems);
   end;
end;

procedure Tpop_image.Erosion1Click(Sender: TObject);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   LargFiltre:Integer;
begin
   New(TabItems);
   try
   IniTabItems(TabItems);

   with TabItems^[1] do
      begin
      TypeItem:=tiInteger;
      Msg:=lang('Largeur du filtre : ');
      ValeurDefaut:=3;
      ValeurIncrement:=2;
      ValeurMin:=3;
      ValeurMax:=99
      end;

   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
   DlgStandard.Caption:=lang('Erosion');
   if DlgStandard.ShowModal=mrOK then
      begin
      LargFiltre:=Round(TabItems^[1].ValeurSortie);

      Screen.Cursor:=crHourGlass;
      try
      SaveUndo;
      Erosion(DataInt,DataDouble,LargFiltre,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
      VisuImg;
      finally
      Screen.Cursor:=crDefault;
      end;
      end
   else DlgStandard.Free;

   finally
   Dispose(TabItems);
   end;
end;

procedure Tpop_image.Dilatation1Click(Sender: TObject);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   LargFiltre:Integer;
begin
   New(TabItems);
   try
   IniTabItems(TabItems);

   with TabItems^[1] do
      begin
      TypeItem:=tiInteger;
      Msg:=lang('Largeur du filtre : ');
      ValeurDefaut:=3;
      ValeurIncrement:=2;
      ValeurMin:=3;
      ValeurMax:=99
      end;

   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
   DlgStandard.Caption:=lang('Dilatation');
   if DlgStandard.ShowModal=mrOK then
      begin
      LargFiltre:=Round(TabItems^[1].ValeurSortie);

      Screen.Cursor:=crHourGlass;
      try
      SaveUndo;
      Dilatation(DataInt,DataDouble,LargFiltre,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
      VisuImg;
      finally
      Screen.Cursor:=crDefault;
      end;
      end
   else DlgStandard.Free;

   finally
   Dispose(TabItems);
   end;
end;

procedure Tpop_image.Fermeture1Click(Sender: TObject);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   LargFiltre:Integer;
begin
   New(TabItems);
   try
   IniTabItems(TabItems);

   with TabItems^[1] do
      begin
      TypeItem:=tiInteger;
      Msg:=lang('Largeur du filtre : ');
      ValeurDefaut:=3;
      ValeurIncrement:=2;
      ValeurMin:=3;
      ValeurMax:=99
      end;

   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
   DlgStandard.Caption:=lang('Fermeture');
   if DlgStandard.ShowModal=mrOK then
      begin
      LargFiltre:=Round(TabItems^[1].ValeurSortie);

      Screen.Cursor:=crHourGlass;
      try
      SaveUndo;
      Erosion(DataInt,DataDouble,LargFiltre,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
      Dilatation(DataInt,DataDouble,LargFiltre,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
      VisuImg;
      finally
      Screen.Cursor:=crDefault;
      end;
      end
   else DlgStandard.Free;

   finally
   Dispose(TabItems);
   end;
end;

procedure Tpop_image.Ouverture1Click(Sender: TObject);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   LargFiltre:Integer;
begin
   New(TabItems);
   try
   IniTabItems(TabItems);

   with TabItems^[1] do
      begin
      TypeItem:=tiInteger;
      Msg:=lang('Largeur du filtre : ');
      ValeurDefaut:=3;
      ValeurIncrement:=2;
      ValeurMin:=3;
      ValeurMax:=99
      end;

   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
   DlgStandard.Caption:=lang('Ouverture');
   if DlgStandard.ShowModal=mrOK then
      begin
      LargFiltre:=Round(TabItems^[1].ValeurSortie);

      Screen.Cursor:=crHourGlass;
      try
      SaveUndo;
      Dilatation(DataInt,DataDouble,LargFiltre,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
      Erosion(DataInt,DataDouble,LargFiltre,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
      VisuImg;
      finally
      Screen.Cursor:=crDefault;
      end;
      end
   else DlgStandard.Free;

   finally
   Dispose(TabItems);
   end;
end;

procedure Tpop_image.RankOrder1Click(Sender: TObject);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   LargFiltre:Integer;
begin
   New(TabItems);
   try
   IniTabItems(TabItems);

   with TabItems^[1] do
      begin
      TypeItem:=tiInteger;
      Msg:=lang('Largeur du filtre : ');
      ValeurDefaut:=25;
      ValeurIncrement:=2;
      ValeurMin:=3;
      ValeurMax:=99
      end;

   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
   DlgStandard.Caption:=lang('Rank Order');
   if DlgStandard.ShowModal=mrOK then
      begin
      LargFiltre:=Round(TabItems^[1].ValeurSortie);

      Screen.Cursor:=crHourGlass;
      try
      SaveUndo;
      RankOrder(DataInt,DataDouble,LargFiltre,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
      AjusteFenetre;
      VisuAutoEtoiles;
      finally
      Screen.Cursor:=crDefault;
      end;
      end
   else DlgStandard.Free;

   finally
   Dispose(TabItems);
   end;
end;

procedure Tpop_image.Valeursextrmes1Click(Sender: TObject);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   LargFiltre:Integer;
begin
   New(TabItems);
   try
   IniTabItems(TabItems);

   with TabItems^[1] do
      begin
      TypeItem:=tiInteger;
      Msg:=lang('Largeur du filtre : ');
      ValeurDefaut:=3;
      ValeurIncrement:=2;
      ValeurMin:=3;
      ValeurMax:=99
      end;

   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
   DlgStandard.Caption:=lang('Valeurs extrèmes');
   if DlgStandard.ShowModal=mrOK then
      begin
      LargFiltre:=Round(TabItems^[1].ValeurSortie);

      Screen.Cursor:=crHourGlass;
      try
      SaveUndo;
      Extremes(DataInt,DataDouble,LargFiltre,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
      AjusteFenetre;
      VisuAutoEtoiles;
      finally
      Screen.Cursor:=crDefault;
      end;
      end
   else DlgStandard.Free;

   finally
   Dispose(TabItems);
   end;
end;

procedure Tpop_image.PasseHautAdaptatif1Click(Sender: TObject);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   LargFiltre:Integer;
   Contraste:Double;
begin
   New(TabItems);
   try
   IniTabItems(TabItems);

   with TabItems^[1] do
      begin
      TypeItem:=tiInteger;
      Msg:=lang('Largeur du filtre : ');
      ValeurDefaut:=3;
      ValeurIncrement:=2;
      ValeurMin:=3;
      ValeurMax:=99
      end;

   with TabItems^[2] do
      begin
      TypeItem:=tiReal;
      Msg:=lang('Contraste : ');
      ValeurDefaut:=0.25;
      ValeurMin:=0.001;
      ValeurMax:=40;
      end;

   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
   DlgStandard.Caption:=lang('Passe haut adaptatif');
   if DlgStandard.ShowModal=mrOK then
      begin
      LargFiltre:=Round(TabItems^[1].ValeurSortie);
      Contraste:=TabItems^[2].ValeurSortie;

      Screen.Cursor:=crHourGlass;
      try
      SaveUndo;
      PasseHautAdaptatif(DataInt,DataDouble,LargFiltre,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Contraste);
      AjusteFenetre;
      VisuAutoEtoiles;
      finally
      Screen.Cursor:=crDefault;
      end;
      end
   else DlgStandard.Free;

   finally
   Dispose(TabItems);
   end;
end;

procedure Tpop_image.ProjectionTlescopique1Click(Sender: TObject);
var
   pop_cree_proj:Tpop_cree_proj;
   Image:Tpop_Image;
   i:Integer;
   FluxMag14:Double;
begin
   pop_cree_proj:=Tpop_cree_proj.Create(Application);
   pop_cree_proj.NbreEdit1.Text:=MyFloatToStr(ImgInfos.Focale,3);
   pop_cree_proj.NbreEdit2.Text:=MyFloatToStr(ImgInfos.PixX,2);
   pop_cree_proj.NbreEdit3.Text:=MyFloatToStr(ImgInfos.PixY,2);
   pop_cree_proj.mask_alpha.Text:=AlphaToStr(ImgInfos.Alpha);
   pop_cree_proj.mask_delta.Text:=DeltaToStr(ImgInfos.Delta);
   if pop_cree_proj.ShowModal=mrOK then
      begin
      AstrometrieInfos.Alpha0:=StrToAlpha(pop_cree_proj.Mask_Alpha.Text);
      AstrometrieInfos.Delta0:=StrToDelta(pop_cree_proj.Mask_Delta.Text);
      AstrometrieInfos.Sx:=StrToInt(pop_cree_proj.SpinEdit1.Text);
      AstrometrieInfos.Sy:=StrToInt(pop_cree_proj.SpinEdit2.Text);
      AstrometrieInfos.Focale:=MyStrToFloat(pop_cree_proj.NbreEdit1.Text);
      AstrometrieInfos.TaillePixelX:=MyStrToFloat(pop_cree_proj.NbreEdit2.Text);
      AstrometrieInfos.TaillePixelY:=MyStrToFloat(pop_cree_proj.NbreEdit3.Text);
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

//      Image:=ActiveMDIChild as Tpop_Image;
      pop_image:=tpop_image.create(application);

      try
      pop_image.ImgInfos.Sx:=StrToInt(pop_cree_proj.SpinEdit1.Text);
      pop_image.ImgInfos.Sy:=StrToInt(pop_cree_proj.SpinEdit2.Text);;
      pop_image.ImgInfos.Typedata:=2;
      pop_image.ImgInfos.NbPlans:=1;
      GetmemImg(pop_image.DataInt,pop_image.DataDouble,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy,
                pop_image.ImgInfos.Typedata,pop_image.ImgInfos.NbPlans);
      pop_image.ImgInfos.Min[1]:=0;
      pop_image.ImgInfos.Max[1]:=2000;
      pop_image.Caption:=pop_main.GiveName(lang('Projection'),pop_image);

      pop_image.SaveUndo;
      Screen.Cursor:=crHourGlass;
      try
      if Rapport=nil then Rapport:=tpop_rapport.Create(Self);
      Rapport.IsUsedByAnImage:=True;
      Rapport.Image:=Self;
      Rapport.Show;
      try
      CreeProjTelescope(pop_image.DataInt,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy,AstrometrieInfos,FluxMag14,Rapport);
      pop_image.AjusteFenetre;
      pop_image.VisuImg;
      pop_image.ChangerMenu;
      pop_main.MiseAJourMenu(Sender);
      pop_main.SeuilsEnable;
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
//pop_main.ProjectionTeleacopique1Click(Sender);
end;

procedure Tpop_image.Histogramme1Click(Sender: TObject);
var
   pop_histo:Tpop_histo;
begin
   pop_histo:=Tpop_histo.Create(Self);
   pop_histo.pop_image:=Self;
   pop_histo.Noplan:=1;
   pop_histo.MinDebut:=ImgInfos.Min[1];
   pop_histo.MaxDebut:=ImgInfos.Max[1];
   pop_histo.ShowModal;
end;

procedure Tpop_image.VerticScrollBarScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
Update;
// C'est bizarre ces scrollbars !
// Je limite artificiellement sa position :
if ScrollPos>Round(ImgInfos.Sy*ZoomFactor-img_box.Height+1) then
   ScrollPos:=Round(ImgInfos.Sy*ZoomFactor-img_box.Height+1);
img_box.Picture.Bitmap.Handle:=VisuImgAPI(DataInt,DataDouble,ImgInfos,
   ZoomFactor,
   HorizScrollBar.Position,
   Round(ImgInfos.Sy*ZoomFactor-img_box.Height+1-ScrollPos+1),
   HorizScrollBar.Position+Img_Box.Width,
   Round(ImgInfos.Sy*ZoomFactor-img_box.Height+1-(ScrollPos+Img_Box.Height)+1),
   img_box.Width,img_box.Height);

end;

procedure Tpop_image.HorizScrollBarScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
Update;
if ScrollPos>Round(ImgInfos.Sx*ZoomFactor-img_box.Width+1) then
   ScrollPos:=Round(ImgInfos.Sx*ZoomFactor-img_box.Width+1);
// C'est bizarre ces scrollbars !
// Je limite artificiellement sa position :
img_box.Picture.Bitmap.Handle:=VisuImgAPI(DataInt,DataDouble,ImgInfos,
   ZoomFactor,ScrollPos,
   Round(ImgInfos.Sy*ZoomFactor-img_box.Height+1-VerticScrollBar.Position+1),
   ScrollPos+Img_Box.Width,
   Round(ImgInfos.Sy*ZoomFactor-img_box.Height+1-VerticScrollBar.Position+Img_Box.Height+1),
   img_box.Width,img_box.Height);


//   Round(HorizScrollBar.Position),
//   Round(VerticScrollBar.Position),
//   Round(HorizScrollBar.Position+Img_Box.Width),
//   Round(VerticScrollBar.Position+Img_Box.Height),

end;

procedure Tpop_image.img_boxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if DeplaceAlaMain=true then DeplaceALaMain:=False;
end;

procedure Tpop_image.Confi1Click(Sender: TObject);
var
FormConfNew:Tpop_conf;
begin
FormConfNew:=Tpop_conf.Create(Application);

// Pas moyen de faire autrement !
FormConfNew.NameOfTabToDisplay:=lang('Photométrie');
formconfnew.Showmodal;
end;

procedure Tpop_image.Enleveruntalon1Click(Sender: TObject);
begin
if TypePointage=PointeOff then
   begin
   TypePointage:=EnleveEtalon;
   FormePointage:=Reticule;
   ClipOn;
   end;
end;

procedure Tpop_image.Ajouterunesuppression1Click(Sender: TObject);
begin
if TypePointage=PointeOff then
   begin
   TypePointage:=SupprimeEtalon;
   FormePointage:=Reticule;
   ClipOn;
   end;
end;

procedure Tpop_image.SetZoom(NewZoomFactor:Double);
begin
   HorizScrollBar.Position:=Round(((HorizScrollBar.Position+Img_Box.Width div 2)
      /ZoomFactor)*NewZoomFactor)-Img_Box.Width div 2;
   VerticScrollBar.Position:=Round(((VerticScrollBar.Position+Img_Box.Height div 2)
      /ZoomFactor)*NewZoomFactor)-Img_Box.Height div 2;
   ZoomFactor:=NewZoomFactor;

   AjusteFenetre;
   VisuImg;
   pop_main.StatusBar1.Panels[1].Text:=lang('Facteur de zoom = ')+MyFloatToStr(ZoomFactor,2);
end;

procedure Tpop_image.outN251Click(Sender: TObject);
begin
   SetZoom(0.25);
end;

procedure Tpop_image.outN501Click(Sender: TObject);
begin
   SetZoom(0.5);
end;

procedure Tpop_image.outN751Click(Sender: TObject);
begin
   SetZoom(0.75);
end;

procedure Tpop_image.outN1001Click(Sender: TObject);
begin
   SetZoom(1);
end;

procedure Tpop_image.outN2001Click(Sender: TObject);
begin
   SetZoom(2);
end;

procedure Tpop_image.outN3001Click(Sender: TObject);
begin
   SetZoom(3);
end;

procedure Tpop_image.outN4001Click(Sender: TObject);
begin
   SetZoom(4);
end;

procedure Tpop_image.outN5001Click(Sender: TObject);
begin
   SetZoom(5);
end;

procedure Tpop_image.outN6001Click(Sender: TObject);
begin
   SetZoom(6);
end;

procedure Tpop_image.outN7001Click(Sender: TObject);
begin
   SetZoom(7);
end;

procedure Tpop_image.outN8001Click(Sender: TObject);
begin
   SetZoom(8);
end;

procedure Tpop_image.outN9001Click(Sender: TObject);
begin
   SetZoom(9);
end;

procedure Tpop_image.outN10001Click(Sender: TObject);
begin
   SetZoom(10);
end;

procedure Tpop_image.Dupliquer1Click(Sender: TObject);
var
pop_image:tpop_image;
begin
   pop_image:=tpop_image.create(application);
   try
   DupliquerImage(Self,pop_image,Caption);
   pop_image.Caption:=pop_main.GiveName(Caption,pop_image);
   pop_main.MiseAJourMenu(Sender);   
   except
   pop_image.free;
   end;
end;

procedure Tpop_image.AjouterplansRougeetVert1Click(Sender: TObject);
var
pop_select_img:Tpop_select_img;
ImageBleue,ImageVerte:TPop_Image;
ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
j:Integer;
begin
SaveUndo;

pop_select_img:=Tpop_select_img.Create(Application);
try
pop_select_img.LabelImgCourante.Caption:=lang('Image courante : ')+Caption;
pop_select_img.LabelQuestion.Caption:=lang('Sélectionnez l''image verte');
if (pop_select_img.ShowModal=mrOK) and (pop_select_img.image_selectionnee<>nil) then
   begin
   ImageVerte:=pop_select_img.image_selectionnee;

   pop_select_img.LabelImgCourante.Caption:=lang('Image courante : ')+Caption;
   pop_select_img.LabelQuestion.Caption:=lang('Sélectionnez l''image bleue');
   if (pop_select_img.ShowModal=mrOK) and (pop_select_img.image_selectionnee<>nil) then
      begin
      ImageBleue:=pop_select_img.image_selectionnee;

      Screen.Cursor:=crHourGlass;
      try
      SaveUndo;

      GetMemImg(ImgInt,ImgDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,3);
      case ImgInfos.Typedata of
         2:for j:=1 to ImgInfos.Sy do
              begin
              Move(DataInt^[1]^[j]^,ImgInt^[1]^[j]^,ImgInfos.Sx*2);
              Move(ImageVerte.DataInt^[1]^[j]^,ImgInt^[2]^[j]^,ImgInfos.Sx*2);
              Move(ImageBleue.DataInt^[1]^[j]^,ImgInt^[3]^[j]^,ImgInfos.Sx*2);
              end;
         5:for j:=1 to ImgInfos.Sy do
              begin
              Move(DataDouble^[1]^[j]^,ImgDouble^[1]^[j]^,ImgInfos.Sx*8);
              Move(ImageVerte.DataDouble^[1]^[j]^,ImgDouble^[2]^[j]^,ImgInfos.Sx*8);
              Move(ImageBleue.DataDouble^[1]^[j]^,ImgDouble^[3]^[j]^,ImgInfos.Sx*8);
              end;
         end;

      FreeMemImg(DataInt,DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans);

      case ImgInfos.Typedata of
         2:begin
           ImgInfos.Typedata:=7;
           DataInt:=ImgInt;
           end;
         5:begin
           ImgInfos.Typedata:=8;
           DataDouble:=ImgDouble;
           end;
         end;
      ImgInfos.NbPlans:=3;

      ImgInfos.Min[2]:=ImageVerte.ImgInfos.Min[1];
      ImgInfos.Min[3]:=ImageBleue.ImgInfos.Min[1];
      ImgInfos.Max[2]:=ImageVerte.ImgInfos.Max[1];
      ImgInfos.Max[3]:=ImageBleue.ImgInfos.Max[1];

      VisuImg;
      finally
      Screen.Cursor:=crDefault;
      end;
      end;
   end;
finally
pop_select_img.Free;
end;
end;

procedure Tpop_image.Sparerlesplans1Click(Sender: TObject);
var
pop_image:tpop_image;
j,k:integer;
begin
   for k:=1 to ImgInfos.NbPlans do
      begin
      pop_image:=tpop_image.create(application);
      try
      pop_image.ImgInfos.Sx:=ImgInfos.Sx;
      pop_image.ImgInfos.Sy:=ImgInfos.Sy;
      case ImgInfos.Typedata of
         2,7:  pop_image.ImgInfos.Typedata:=2;
         5,6,8:pop_image.ImgInfos.Typedata:=5;
         end;
      pop_image.ImgInfos.NbPlans:=1;

      GetMemImg(pop_image.DataInt,pop_image.DataDouble,ImgInfos.Sx,ImgInfos.Sy,pop_image.ImgInfos.Typedata,pop_image.ImgInfos.NbPlans);

      case ImgInfos.Typedata of
         2,7:  for j:=1 to ImgInfos.Sy do Move(DataInt^[k]^[j]^,pop_image.DataInt^[1]^[j]^,ImgInfos.Sx*2);
         5,6,8:for j:=1 to ImgInfos.Sy do Move(DataDouble^[k]^[j]^,pop_image.DataDouble^[1]^[j]^,ImgInfos.Sx*8);
         end;

      pop_image.ImgInfos:=ImgInfos;
      pop_image.ImgInfos.Min[1]:=ImgInfos.Min[k];
      pop_image.ImgInfos.Max[1]:=ImgInfos.Max[k];
      if (ImgInfos.Typedata=7) or (ImgInfos.Typedata=8) then
         begin
         if k=1 then pop_image.Caption:=pop_main.GiveName(Caption+lang(' Rouge'),pop_image);
         if k=2 then pop_image.Caption:=pop_main.GiveName(Caption+lang(' Vert'),pop_image);
         if k=3 then pop_image.Caption:=pop_main.GiveName(Caption+lang(' Bleue'),pop_image);
         end
      else pop_image.Caption:=pop_main.GiveName(Caption+lang(' Plan ')+IntToStr(k),pop_image);

      pop_image.AjusteFenetre;
      pop_image.visuImg;
      pop_image.ChangerMenu;
      pop_main.MiseAJourMenu(Sender);
      except
      pop_image.Free;
      end;
   end;
end;

procedure Tpop_image.Ajouterunplan1Click(Sender: TObject);
var
pop_select_img:Tpop_select_img;
Image:TPop_Image;
ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
j,k:Integer;
begin
SaveUndo;

pop_select_img:=Tpop_select_img.Create(Application);
try
pop_select_img.NotSameNbOfPlane:=True;
pop_select_img.LabelImgCourante.Caption:=lang('Image courante : ')+Caption;
pop_select_img.LabelQuestion.Caption:=lang('Sélectionnez l''image à integrer');
if (pop_select_img.ShowModal=mrOK) and (pop_select_img.image_selectionnee<>nil) then
   begin
   Image:=pop_select_img.image_selectionnee;

   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;

   GetMemImg(ImgInt,ImgDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans+Image.ImgInfos.NbPlans);
   for k:=1 to ImgInfos.NbPlans do
      case ImgInfos.Typedata of
         2:for j:=1 to ImgInfos.Sy do Move(DataInt^[k]^[j]^,ImgInt^[k]^[j]^,ImgInfos.Sx*2);
         5:for j:=1 to ImgInfos.Sy do Move(DataDouble^[k]^[j]^,ImgDouble^[k]^[j]^,ImgInfos.Sx*8);
         end;

   for k:=1 to Image.ImgInfos.NbPlans do
      case ImgInfos.Typedata of
         2:for j:=1 to ImgInfos.Sy do Move(Image.DataInt^[k]^[j]^,ImgInt^[ImgInfos.NbPlans+k]^[j]^,ImgInfos.Sx*2);
         5:for j:=1 to ImgInfos.Sy do Move(Image.DataDouble^[k]^[j]^,ImgDouble^[ImgInfos.NbPlans+k]^[j]^,ImgInfos.Sx*8);
         end;

    FreeMemImg(DataInt,DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans);

    case ImgInfos.Typedata of
      2,7:begin
          ImgInfos.Typedata:=2;
          DataInt:=ImgInt;
          end;
      5,6,8:begin
            ImgInfos.Typedata:=5;
            DataDouble:=ImgDouble;
            end;
      end;
   ImgInfos.NbPlans:=ImgInfos.NbPlans+Image.ImgInfos.NbPlans;

   if ImgInfos.NbPlans=3 then
      if MessageDlg(lang('Voulez vous obtenir une image couleur ?'),mtConfirmation,[mbYes,mbNo],0)=mrYes then
         begin
         case ImgInfos.Typedata of
            2:ImgInfos.Typedata:=7;
            5:ImgInfos.Typedata:=8;
            end;

         if Image.ImgInfos.NbPlans=2 then
            begin
            ImgInfos.Min[2]:=Image.ImgInfos.Min[1];
            ImgInfos.Max[2]:=Image.ImgInfos.Max[1];
            ImgInfos.Min[3]:=Image.ImgInfos.Min[2];
            ImgInfos.Max[3]:=Image.ImgInfos.Max[2];
            end
         else
            begin
            ImgInfos.Min[2]:=ImgInfos.Min[1];
            ImgInfos.Max[2]:=ImgInfos.Max[1];
            ImgInfos.Min[3]:=Image.ImgInfos.Min[1];
            ImgInfos.Max[3]:=Image.ImgInfos.Max[1];
            end;
         end;

   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;
   end;

finally
pop_select_img.Free;
end;
end;

procedure Tpop_image.Supprimerunplan1Click(Sender: TObject);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   i,j,k,NbPlansSupp,NbPlansNew,PosEsp:Integer;
   Line,LineTemp:string;
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   TypedataNew:Byte;
begin
SaveUndo;

Line:='';
for i:=1 to ImgInfos.NbPlans do Line:=Line+lang('Plan ')+IntToStr(i)+'|';

New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiListBox;
   MultiSelect:=True;
   Msg:=lang('Plans à supprimer : ');
   ValeurStrDefaut:=Line;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.Caption:=lang('Supprimer des plans');
if DlgStandard.ShowModal=mrOK then
   begin
   Line:=TabItems^[1].ValeurStrSortie;

   // On trouve le nombre de plans a supprimer
   NbPlansSupp:=0;
   LineTemp:=Line;
   PosEsp:=Pos('|',LineTemp);
   while (PosEsp<>0) and (Length(LineTemp)<>0) do
      begin
      Inc(NbPlansSupp);
      Delete(LineTemp,1,PosEsp);
      PosEsp:=Pos('|',Line);
      end;

   NbPlansNew:=ImgInfos.NbPlans-NbPlansSupp;
   TypedataNew:=2;   
   case ImgInfos.Typedata of
      2,7:  TypedataNew:=2;
      5,6,8:TypedataNew:=5;
      end;
   if (NbPlansNew<>0) and (NbPlansNew<>ImgInfos.NbPlans)  then
      begin
      GetMemImg(ImgInt,ImgDouble,ImgInfos.Sx,ImgInfos.Sy,TypedataNew,NbPlansNew);

      k:=0;
      for i:=1 to ImgInfos.NbPlans do
         begin
         PosEsp:=Pos(lang('Plan ')+IntToStr(i)+'|',Line);
         if PosEsp=0 then
            begin
            Inc(k);
            // On ajoute le plan
            case TypedataNew of
               2:for j:=1 to ImgInfos.Sy do Move(DataInt^[i]^[j]^,ImgInt^[k]^[j]^,ImgInfos.Sx*2);
               5:for j:=1 to ImgInfos.Sy do Move(DataDouble^[i]^[j]^,ImgDouble^[k]^[j]^,ImgInfos.Sx*8);
               end;
            end;
         end;

      FreeMemImg(DataInt,DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,ImgInfos.NbPlans);

      case ImgInfos.Typedata of
         2,7:begin
             ImgInfos.Typedata:=2;
             DataInt:=ImgInt;
             end;
         5,6,8:begin
               ImgInfos.Typedata:=5;
               DataDouble:=ImgDouble;
               end;
         end;
      ImgInfos.NbPlans:=NbPlansNew;

      if ImgInfos.NbPlans=3 then
         if MessageDlg(lang('Voulez vous obtenir une image couleur ?'),mtConfirmation,[mbYes,mbNo],0)=mrYes then
            begin
            case ImgInfos.Typedata of
               2:ImgInfos.Typedata:=7;
               5:ImgInfos.Typedata:=8;
               end;
            end;

      VisuImg;
      end;
   pop_main.MiseAJourMenu(Sender);
   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;
end;

procedure Tpop_image.Extrairedesplans1Click(Sender: TObject);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   i,j,NbPlansExt,PosEsp:Integer;
   Line,LineTemp:string;
begin
Line:='';
for i:=1 to ImgInfos.NbPlans do Line:=Line+lang('Plan ')+IntToStr(i)+'|';

New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiListBox;
   MultiSelect:=True;
   Msg:=lang('Plans à extraire : ');
   ValeurStrDefaut:=Line;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
DlgStandard.Caption:=lang('Extraire des plans');
if DlgStandard.ShowModal=mrOK then
   begin
   Line:=TabItems^[1].ValeurStrSortie;

   // On trouve le nombre de plans a extraire
   NbPlansExt:=0;
   LineTemp:=Line;
   PosEsp:=Pos('|',LineTemp);
   while (PosEsp<>0) and (Length(LineTemp)<>0) do
      begin
      Inc(NbPlansExt);
      Delete(LineTemp,1,PosEsp);
      PosEsp:=Pos('|',Line);
      end;

   if NbPlansExt<>0 then
      begin
      for i:=1 to ImgInfos.NbPlans do
         begin
         PosEsp:=Pos(lang('Plan ')+IntToStr(i)+'|',Line);
         if PosEsp<>0 then
            begin

            pop_image:=tpop_image.create(application);
            try
            pop_image.ImgInfos.Sx:=ImgInfos.Sx;
            pop_image.ImgInfos.Sy:=ImgInfos.Sy;
            case ImgInfos.Typedata of
               2,7:  pop_image.ImgInfos.Typedata:=2;
               5,6,8:pop_image.ImgInfos.Typedata:=5;
               end;
            pop_image.ImgInfos.NbPlans:=1;

            GetMemImg(pop_image.DataInt,pop_image.DataDouble,ImgInfos.Sx,ImgInfos.Sy,pop_image.ImgInfos.Typedata,pop_image.ImgInfos.NbPlans);

            case ImgInfos.Typedata of
               2,7:  for j:=1 to ImgInfos.Sy do Move(DataInt^[i]^[j]^,pop_image.DataInt^[1]^[j]^,ImgInfos.Sx*2);
               5,6,8:for j:=1 to ImgInfos.Sy do Move(DataDouble^[i]^[j]^,pop_image.DataDouble^[1]^[j]^,ImgInfos.Sx*8);
               end;

            pop_image.ImgInfos:=ImgInfos;
            pop_image.ImgInfos.Min[1]:=ImgInfos.Min[i];
            pop_image.ImgInfos.Max[1]:=ImgInfos.Max[i];
            if (ImgInfos.Typedata=7) or (ImgInfos.Typedata=8) then
               begin
               if i=1 then pop_image.Caption:=pop_main.GiveName(Caption+lang(' Rouge'),pop_image);
               if i=2 then pop_image.Caption:=pop_main.GiveName(Caption+lang(' Vert'),pop_image);
               if i=3 then pop_image.Caption:=pop_main.GiveName(Caption+lang(' Bleue'),pop_image);
               end
            else pop_image.Caption:=pop_main.GiveName(Caption+lang(' Plan ')+IntToStr(i),pop_image);

            pop_image.AjusteFenetre;
            pop_image.visuImg;
            pop_image.ChangerMenu;
            pop_main.MiseAJourMenu(Sender);
            except
            pop_image.Free;
            end;

            end;
         end;
      end;
   pop_main.MiseAJourMenu(Sender);
   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;
end;

procedure Tpop_image.Permuter2plans1Click(Sender: TObject);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   i,PosEsp,Index1,Index2:Integer;
   Line,Line1,Line2,Line3,LineTemp:string;
begin
SaveUndo;

Line:='';
for i:=1 to ImgInfos.NbPlans do Line:=Line+lang('Plan ')+IntToStr(i)+'|';

New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiListBox;
   MultiSelect:=True;
   Msg:=lang('Plans à permuter : ');
   ValeurStrDefaut:=Line;
   end;

   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
   DlgStandard.Caption:=lang('Permuter des plans');
   if DlgStandard.ShowModal=mrOK then
      begin
   Line1:=TabItems^[1].ValeurStrSortie;

   if Line1<>'' then
      begin
      DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,0);
      DlgStandard.Caption:=lang('Permuter des plans');
      if DlgStandard.ShowModal<>mrOK then
         begin
         DlgStandard.Free;
         Dispose(TabItems);
         Exit;
         end;

      Line2:=TabItems^[1].ValeurStrSortie;
      if Line2<>'' then
         begin
         // On trouve les plans a permuter
         i:=1;
         LineTemp:=Line;
         PosEsp:=Pos('|',LineTemp);
         while (PosEsp<>0) and (Length(LineTemp)<>0) do
            begin
            Line3:=Copy(LineTemp,1,PosEsp);
            if Line3=Line1 then Index1:=i;
            Delete(LineTemp,1,PosEsp);
            PosEsp:=Pos('|',Line);
            Inc(i)
            end;

         i:=1;
         LineTemp:=Line;
         PosEsp:=Pos('|',LineTemp);
         while (PosEsp<>0) and (Length(LineTemp)<>0) do
            begin
            Line3:=Copy(LineTemp,1,PosEsp);
            if Line3=Line2 then Index2:=i;
            Delete(LineTemp,1,PosEsp);
            PosEsp:=Pos('|',Line);
            Inc(i)
            end;

         Index1:=0;
         Index2:=0;
         PermutePlan(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Index1,Index2);
         VisuImg;
         end;
      end;
   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;
end;

procedure Tpop_image.Etalonnage2Click(Sender: TObject);
var
   pop_calib_astrom:Tpop_calib_astrom;
   i,DegreMax,Test:Integer;
   Gagnants:TList;
   m:P_Matcher;
begin
   ReinitialiseAstrometrie;
   VisuImg;

   pop_calib_Astrom:=Tpop_calib_Astrom.Create(Application);
   pop_calib_Astrom.NbreEdit1.Text:=MyFloatToStr(ImgInfos.Focale,3);
   pop_calib_Astrom.NbreEdit2.Text:=MyFloatToStr(ImgInfos.PixX*ImgInfos.BinningX,3);
   pop_calib_Astrom.NbreEdit3.Text:=MyFloatToStr(ImgInfos.PixY*ImgInfos.BinningY,3);
   pop_calib_Astrom.mask_alpha.Text:=AlphaToStr(ImgInfos.Alpha);
   pop_calib_Astrom.mask_delta.Text:=DeltaToStr(ImgInfos.Delta);

   // Teste si un catalogue est disponible
   Test:=0;
   if Config.CatGSCCPresent then Inc(Test);
   if Config.CatUSNOPresent then Inc(Test);
   if Config.CatTY2Present  then Inc(Test);
   if Config.CatMCTPresent  then Inc(Test);
   if Config.CatBSCPresent  then Inc(Test);

   if Test<>0 then
      begin
      if pop_calib_Astrom.ShowModal=mrOK then
         begin
         try
         if Rapport=nil then Rapport:=tpop_rapport.Create(Self);
         Rapport.IsUsedByAnImage:=True;
         Rapport.Image:=Self;
         Rapport.Show;
         try

         AstrometrieInfos.Sx:=ImgInfos.Sx;
         AstrometrieInfos.Sy:=ImgInfos.Sy;
         AstrometrieInfos.Alpha0:=StrToAlpha(pop_calib_Astrom.Mask_Alpha.Text);
         AstrometrieInfos.Delta0:=StrToDelta(pop_calib_Astrom.Mask_Delta.Text);
         AstrometrieInfos.Focale:=MyStrToFloat(pop_calib_Astrom.NbreEdit1.Text);
         AstrometrieInfos.TaillePixelX:=MyStrToFloat(pop_calib_Astrom.NbreEdit2.Text);
         AstrometrieInfos.TaillePixelY:=MyStrToFloat(pop_calib_Astrom.NbreEdit3.Text);
         AstrometrieInfos.USNOSelected:=False;
         AstrometrieInfos.GSCCSelected:=False;
         AstrometrieInfos.TY2Selected:=False;
         AstrometrieInfos.MCT1Selected:=False;
         AstrometrieInfos.MCT2Selected:=False;
         AstrometrieInfos.MCT3Selected:=False;
         AstrometrieInfos.BSCSelected:=False;
         for i:=0 to pop_calib_Astrom.outListbox1.Items.Count-1 do
            begin
            if pop_calib_Astrom.outListbox1.Items[i]='USNO' then //nolang
               if pop_calib_Astrom.outListbox1.Selected[i] then
                  AstrometrieInfos.USNOSelected:=True;
            if pop_calib_Astrom.outListbox1.Items[i]='GSC' then //nolang
               if pop_calib_Astrom.outListbox1.Selected[i] then
                  AstrometrieInfos.GSCCSelected:=True;
            if pop_calib_Astrom.outListbox1.Items[i]='Tycho2' then //nolang
               if pop_calib_Astrom.outListbox1.Selected[i] then
                  AstrometrieInfos.TY2Selected:=True;
            if pop_calib_Astrom.outListbox1.Items[i]='MicroCat' then //nolang
               if pop_calib_Astrom.outListbox1.Selected[i] then
                  AstrometrieInfos.MCT3Selected:=True;
            if pop_calib_Astrom.outListbox1.Items[i]='BSC' then //nolang
               if pop_calib_Astrom.outListbox1.Selected[i] then
                  AstrometrieInfos.BSCSelected:=True;
            AstrometrieInfos.TypeGSC:=Config.TypeGSC;
            end;
         AstrometrieInfos.HighPrecision:=pop_calib_Astrom.CheckBox1.Checked;

         Screen.Cursor:=crHourGlass;
         CalibAstrom(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,AstrometrieInfos,Rapport,Gagnants);

         if Gagnants.Count<=3 then
            begin
            Rapport.AddLine(' ');
            Rapport.AddLine('Pas assez d''étoiles en correspondance');
            Exit;
//            raise ErrorMatching.Create('Pas assez d''étoiles en correspondance');
            end;

         pop_fit_astrom:=Tpop_fit_astrom.Create(Application);
         with pop_fit_astrom do
            begin
            NbStarGagnantIn:=Gagnants.Count;

            Getmem(xIn,8*NbStarGagnantIn);
            Getmem(yIn,8*NbStarGagnantIn);
            Getmem(x1In,8*NbStarGagnantIn);
            Getmem(x2In,8*NbStarGagnantIn);
            Getmem(SigxIn,8*NbStarGagnantIn);
            Getmem(SigyIn,8*NbStarGagnantIn);

            // Changement de forme des donnees
            for i:=0 to NbStarGagnantIn-1 do
               begin
               m:=gagnants[i];
               x1In^[i+1]:=m.ref_x;  // Ref est le premier dans la fonction match donc c'est l'image
               x2In^[i+1]:=m.ref_y;
               xIn^[i+1]:=m.det_x;   // Det est le deuxieme dans la fonction match donc c'est le catalogue projeté
               yIn^[i+1]:=m.det_y;
               SigXIn^[i+1]:=1;      // Connait pas l'incertitude du catalogue !
               SigYIn^[i+1]:=1;
               end;

            if NbStarGagnantIn>3  then DegreMax:=1;
            if NbStarGagnantIn>6  then DegreMax:=2;
            if NbStarGagnantIn>10 then DegreMax:=3;
            if NbStarGagnantIn>15 then DegreMax:=4;
            if NbStarGagnantIn>21 then DegreMax:=5;
            DegreMax:=1;
            SpinEdit1.MaxValue:=DegreMax;

            pop_fit_astrom.AstrometrieInfos:=Self.AstrometrieInfos;

            if pop_fit_astrom.ShowModal=mrOK then
               begin
               AstrometrieCalibree:=True; // a modifier
               Self.AstrometrieInfos:=pop_fit_astrom.AstrometrieInfos;
               Self.ImgInfos.OrientationCCD:=pop_fit_astrom.AstrometrieInfos.OrientationCCD;
               Self.ImgInfos.Focale:=pop_fit_astrom.AstrometrieInfos.Focale;
               Rapport.AddLine(' ');
               Rapport.AddLine(lang('Calibration astrométrique réussie'));
               Rapport.AddLine(' ');
               Rapport.AddLine(lang('Résidu Alpha = ')+pop_fit_astrom.Panel1.Caption+lang(' arcsec'));
               Rapport.AddLine(lang('Résidu Delta = ')+pop_fit_astrom.Panel2.Caption+lang(' arcsec'));
               Rapport.AddLine(lang('Focale = ')+pop_fit_astrom.Panel5.Caption+lang(' mm'));
               Rapport.AddLine(lang('Orientation = ')+pop_fit_astrom.Panel6.Caption+lang(' degrés'));
               Mesure2.Enabled:=True;
               ToutMesurer1.Enabled:=True;               
               end;

            end;

         finally
         Rapport.Quitter.Enabled:=True;
         Rapport.BitBtn1.Enabled:=True;
         Rapport.BitBtn2.Enabled:=True;
         Rapport.BitBtn3.Enabled:=True;         
         end;
         finally
         Screen.Cursor:=crDefault;
         end;

         end;
      end
   else MessageDlg(lang('Veuillez installer un catalogue (GSC, USNO, Tycho2)'),mtError,[mbOK],0);
end;

procedure Tpop_image.Cercle(XImg,YImg:Integer);
begin
EcranToImage(XImg,YImg);
Img_Box.Canvas.Pen.Color:=ClRed;
Img_Box.Canvas.Pen.Style:=PsSolid;
Img_Box.Canvas.Pen.Mode:=pmCopy;
Img_Box.Canvas.Pen.Width:=Round(ZoomFactor);
if Img_Box.Canvas.Pen.Width=0 then Img_Box.Canvas.Pen.Width:=1;
Img_Box.Canvas.Brush.Style:=bsClear;

Img_Box.Canvas.Ellipse(Round(Ximg-8*ZoomFactor),Round(Yimg-8*ZoomFactor),
   Round(Ximg+8*ZoomFactor),Round(Yimg+8*ZoomFactor));
end;

procedure Tpop_image.CercleStr(XImg,YImg:Integer;Line:string;Color:TColor);
begin
//EcranToImage(XImg,YImg);
Img_Box.Canvas.Pen.Color:=Color;
Img_Box.Canvas.Pen.Style:=PsSolid;
Img_Box.Canvas.Pen.Mode:=pmCopy;
Img_Box.Canvas.Pen.Width:=Round(ZoomFactor);
if Img_Box.Canvas.Pen.Width=0 then Img_Box.Canvas.Pen.Width:=1;
Img_Box.Canvas.Brush.Style:=bsClear;

Img_Box.Canvas.Ellipse(Round(Ximg-8*ZoomFactor),Round(Yimg-8*ZoomFactor),
   Round(Ximg+8*ZoomFactor),Round(Yimg+8*ZoomFactor));

Img_Box.Canvas.Font.Color:=Color;
Img_Box.Canvas.Font.Name:='Arial'; //nolang
//Img_Box.Canvas.Font.Size:=Round(9*ZoomFactor);
Img_Box.Canvas.Font.Size:=9;
if Img_Box.Canvas.Font.Size<5 then Img_Box.Canvas.Font.Size:=5;
Img_Box.Canvas.Font.Pitch:=fpFixed;
Img_Box.Canvas.Font.Style:=[fsBold];

Img_Box.Canvas.TextOut(Round(Ximg+8*ZoomFactor),Round(Yimg+8*ZoomFactor),Line);
end;

procedure Tpop_image.DisplayCoupePhotometrique(x,y,x1,y1:integer);
var
   pop_profil:Tpop_profil;
//   pop_coord:Tpop_coord;
   Line:Trect;
begin
//pop_coord:=Tpop_coord.Create(Application);
with Tpop_image(self) do
   begin
//   pop_coord.line.left:=x;
//   pop_coord.line.top:=y;
//   pop_coord.line.right:=x1;
//   pop_coord.line.bottom:=y1;
   Line.left:=x;
   Line.top:=y;
   Line.right:=x1;
   Line.bottom:=y1;
   pop_profil:=Tpop_profil.create(pop_image);
   pop_profil.NBPlans:=ImgInfos.NbPlans;
   case ImgInfos.Typedata of
//      2,7:pop_profil.DisplayProfil(DataInt,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.NbPlans,ImgInfos.Typedata,pop_coord.line,caption);
//      5,6,8:pop_profil.DisplayProfil(DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.NbPlans,ImgInfos.Typedata,pop_coord.line,caption);
      2,7:pop_profil.DisplayProfil(DataInt,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,Line,caption);
      5,6,8:pop_profil.DisplayProfil(DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Typedata,Line,caption);
      end;
   pop_profil.Show;
   end;
end;

{procedure Tpop_image.DisplayCoupePhotometrique(x,y,x1,y1:integer);
var
  pop_coupe: Tpop_coupe;
begin
pop_coupe:=Tpop_coupe.Create(Application);
pop_coupe.Image:=Self;
pop_coupe.Line.left:=x;
pop_coupe.Line.top:=y;
pop_coupe.Line.right:=x1;
pop_coupe.Line.bottom:=y1;
pop_coupe.Plan:=1; // Todo : choisir le plan
pop_coupe.Show;
end;}


procedure Tpop_image.Mesure2Click(Sender: TObject);
begin
if TypePointage=PointeOff then
   begin
   TypePointage:=PointeAstrometrie;
   FormePointage:=Reticule;
   ClipOn;
   end;
end;

procedure Tpop_image.MesureAstrometrie(X,Y:Integer);
var
PSF:TPSF;
ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
Ximg,YImg,Larg,i,j,XEcran,YEcran,ma:Integer;
XProj,YProj,XProjPU,YProjPU,Alpha,Delta,Erreur,Echelle,EchelleX,EchelleY,XDbl,YDbl:Double;
begin
if Rapport=nil then Rapport:=Tpop_Rapport.Create(Self);
Rapport.IsUsedByAnImage:=True;
Rapport.Image:=Self;
Rapport.Show;
try

Larg:=2*Config.LargModelisePhotometrie+1;

try

if (X>Config.LargModelisePhotometrie) and (X<ImgInfos.Sx-Config.LargModelisePhotometrie+1) and
   (Y>Config.LargModelisePhotometrie) and (Y<ImgInfos.Sy-Config.LargModelisePhotometrie+1) then
   begin
   Ximg:=X+1;
   Yimg:=ImgInfos.Sy-Y;

   GetImgPart(DataInt,DataDouble,ImgInt,ImgDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,
      Ximg-Config.LargModelisePhotometrie,Yimg-Config.LargModelisePhotometrie,
      Ximg+Config.LargModelisePhotometrie,Yimg+Config.LargModelisePhotometrie);
//   ModeliseEtoile(ImgInt,ImgDouble,ImgInfos.Typedata,Larg,Config.LargModelisePhotometrie+1,
//      Config.LargModelisePhotometrie+1,config.FormeModelePhotometrie,HighPrecision,LowSelect,
//      config.DegreCielPhotometrie,PSF);
//procedure ModeliseEtoile(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;TypeData:Byte;
//   Larg:Integer;TypeModele,Precision,Select:Byte;Degre:Byte;var PSF:TPSF);

// Modele gaussien
   ModeliseEtoile(ImgInt,ImgDouble,ImgInfos.Typedata,2*Config.LargModelisePhotometrie+1,1,HighPrecision,LowSelect,
      config.DegreCielPhotometrie,PSF);



   if PSF.Flux=-1 then
      begin
//      raise ErrorModelisation.Create(lang('Erreur de modélisation'));
      ShowMessage(lang('Erreur de modélisation'));
      Exit;
      end;

   // Mesure ici
   XDbl:=Ximg-Config.LargModelisePhotometrie+PSF.X-1;
   YDbl:=Yimg-Config.LargModelisePhotometrie+PSF.Y-1;

   Ximg:=Round(XDbl);
   Yimg:=Round(YDbl);
   XEcran:=Ximg;
   YEcran:=Yimg;

//   XProj:=CalcPolynomeXY(XEcran-ImgInfos.Sx div 2,(ImgInfos.Sy-YEcran+1)-ImgInfos.Sy div 2,AstrometrieInfos.PolyX,AstrometrieInfos.DegrePoly);
//   YProj:=CalcPolynomeXY(XEcran-ImgInfos.Sx div 2,(ImgInfos.Sy-YEcran+1)-ImgInfos.Sy div 2,AstrometrieInfos.PolyY,AstrometrieInfos.DegrePoly);
//   XProjPU:=XProj*AstrometrieInfos.TaillePixel/AstrometrieInfos.Focale*1000/1e6;
//   YProjPU:=YProj*AstrometrieInfos.TaillePixel/AstrometrieInfos.Focale*1000/1e6;
//   XYToAlphaDelta(XProjPU,YProjPU,AstrometrieInfos.Alpha0,AstrometrieInfos.Delta0,Alpha,Delta);

//   XProj:=CalcPolynomeXY(XDbl-(ImgInfos.Sx div 2),(ImgInfos.Sy-YDbl+1)-(ImgInfos.Sy div 2),AstrometrieInfos.PolyX,AstrometrieInfos.DegrePoly);
//   YProj:=CalcPolynomeXY(XDbl-(ImgInfos.Sx div 2),(ImgInfos.Sy-YDbl+1)-(ImgInfos.Sy div 2),AstrometrieInfos.PolyY,AstrometrieInfos.DegrePoly);
   XProj:=CalcPolynomeXY(XDbl-(ImgInfos.Sx div 2),YDbl-(ImgInfos.Sy div 2),AstrometrieInfos.PolyX,AstrometrieInfos.DegrePoly);
   YProj:=CalcPolynomeXY(XDbl-(ImgInfos.Sx div 2),YDbl-(ImgInfos.Sy div 2),AstrometrieInfos.PolyY,AstrometrieInfos.DegrePoly);

   XProjPU:=XProj*AstrometrieInfos.TaillePixelX/AstrometrieInfos.Focale*1000/1e6;
   YProjPU:=YProj*AstrometrieInfos.TaillePixelY/AstrometrieInfos.Focale*1000/1e6;
   XYToAlphaDelta(XProjPU,YProjPU,AstrometrieInfos.Alpha0,AstrometrieInfos.Delta0,Alpha,Delta);

   if NbAstrom=0 then
      begin
      Getmem(FirstAstrom,Sizeof(TAstrom));
      AstromCourant:=FirstAstrom;
      end;

   Inc(NbAstrom);
   AstromCourant.X:=Ximg;
   AstromCourant.Y:=Yimg;
   AstromCourant.Alpha:=Alpha;
   AstromCourant.Delta:=Delta;

//   Echelle:=ArcTan(AstrometrieInfos.TaillePixel/AstrometrieInfos.Focale/1000)*180/Pi*3600;
   EchelleX:=ArcTan(AstrometrieInfos.TaillePixelX/AstrometrieInfos.Focale/1000)*180/Pi*3600;
   EchelleY:=ArcTan(AstrometrieInfos.TaillePixelY/AstrometrieInfos.Focale/1000)*180/Pi*3600;
   Echelle:=Sqrt((Sqr(EchelleX)+Sqr(EchelleY))/2);

   ma:=0;
   Erreur:=0;
   for i:=0 to AstrometrieInfos.DegrePoly do
      begin
      for j:=0 to i do
         begin
         inc(ma);
         Erreur:=Erreur+AstrometrieInfos.DaX[ma];
         Erreur:=Erreur+AstrometrieInfos.PolyX[ma]*(i-j)*PuissanceDouble(XDbl,i-j-1)*PSF.DX;
         Erreur:=Erreur+AstrometrieInfos.PolyX[ma]*j*PuissanceDouble(YDbl,j-1)*PSF.DY;
         Erreur:=Erreur*Echelle;
         end;
      end;
   AstromCourant.DAlpha:=Erreur;

   ma:=0;
   Erreur:=0;
   for i:=0 to AstrometrieInfos.DegrePoly do
      begin
      for j:=0 to i do
         begin
         inc(ma);
         Erreur:=Erreur+AstrometrieInfos.DaY[ma];
         Erreur:=Erreur+AstrometrieInfos.PolyY[ma]*(i-j)*PuissanceDouble(XDbl,i-j-1)*PSF.DX;
         Erreur:=Erreur+AstrometrieInfos.PolyY[ma]*j*PuissanceDouble(YDbl,j-1)*PSF.DY;
         Erreur:=Erreur*Echelle;
         end;
      end;
   AstromCourant.DDelta:=Erreur;

   Rapport.AddLine('');
   Rapport.AddLine('Alpha = '+AlphaToStrAstrom(AstromCourant.Alpha)+' +/- '+ //nolang
      MyFloatToStr(AstromCourant.DAlpha/15,5)+' sec'); //nolang
   Rapport.AddLine('Delta = '+DeltaToStrAstrom(AstromCourant.Delta)+' +/- '+ //nolang
      MyFloatToStr(AstromCourant.DDelta,5)+' arcsec'); //nolang
   Rapport.AddLine(MpecFormat(ImgInfos.DateTime,Alpha,Delta)); //nolang
   Rapport.AddLine(' ');
   Getmem(AstromCourant.Suivant,Sizeof(TAstrom));
   AstromCourant:=AstromCourant.Suivant;
   end
//else raise ErrorModelisation.Create(lang('Erreur de modélisation'));
else ShowMessage(lang('Erreur de modélisation'));

finally
case ImgInfos.Typedata of
   2:begin
     for i:=1 to Larg do Freemem(ImgInt^[1]^[i],Larg*2);
     Freemem(ImgInt^[1],Larg*4);
     Freemem(ImgInt,4);
     end;
   5:begin
     for i:=1 to Larg do Freemem(ImgInt^[1]^[i],Larg*2);
     Freemem(ImgInt^[1],Larg*4);
     Freemem(ImgInt,4);
     end;
   end;
end;

finally
Rapport.Quitter.Enabled:=True;
Rapport.BitBtn1.Enabled:=True;
Rapport.BitBtn2.Enabled:=True;
Rapport.BitBtn3.Enabled:=True;
end;
end;

procedure Tpop_image.VisuAstrometrie;
var
   i,Ximg,Yimg:Integer;
begin
   AstromCourant:=FirstAstrom;
   for i:=1 to NbAstrom do
      begin
      Ximg:=AstromCourant.X;
      Yimg:=AstromCourant.Y;
      ImageToEcran(Ximg,Yimg);
//      Ximg:=AstromCourant.X;
//      Yimg:=ImgInfos.Sy-AstromCourant.Y+1;
      CercleStr(Ximg,Yimg,AlphaToStrAstrom(AstromCourant.Alpha)+'/'+DeltaToStrAstrom(AstromCourant.Delta),clGreen);
      AstromCourant:=AstromCourant.Suivant;
      end;
end;

procedure Tpop_image.ReinitialiseAstrometrie;
var
   i:Integer;
begin
   if NbAstrom<>0 then
      begin
      AstromCourant:=FirstAstrom;
      for i:=1 to NBAstrom do
         begin
         OldAstrom:=AstromCourant;
         AstromCourant:=AstromCourant.Suivant;
         Freemem(OldAstrom,Sizeof(TAstrom));
         end;
      NbAstrom:=0;
      end;
end;

procedure Tpop_image.Rinitialiser2Click(Sender: TObject);
begin
ReinitialiseAstrometrie;
VisuImg;
end;

procedure Tpop_image.Toutmesurer1Click(Sender: TObject);
var
ListePSF:PListePSF;
NBSources,i,j,k,ma:Integer;
XProj,YProj,XProjPU,YProjPU,Alpha,Delta,Echelle,EchelleX,EchelleY,Erreur:Double;
begin
if Rapport=nil then Rapport:=tpop_rapport.Create(Self);
Rapport.IsUsedByAnImage:=True;
Rapport.Image:=Self;
Rapport.Show;
try
Screen.Cursor:=crHourGlass;
try
NBSources:=0;
ModeliseSources(DataInt,DataDouble,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Config.LargModelise,
   ListePSF,TGauss,LowPrecision,LowSelect,NBSources,15,False,'',True);
Rapport.AddLine(Format(lang('Nombre d''étoiles : %d'),[NBSources]));
Rapport.AddLine('X       Y     Alpha         Delta          DAlpha  DDelta'); //nolang

ReinitialiseAstrometrie;
Getmem(FirstAstrom,Sizeof(TAstrom));
AstromCourant:=FirstAstrom;

for k:=1 to NBSources do
   begin
   XProj:=CalcPolynomeXY(ListePSF^[k].X-ImgInfos.Sx div 2,ListePSF^[k].Y-ImgInfos.Sy div 2,
      AstrometrieInfos.PolyX,AstrometrieInfos.DegrePoly);
   YProj:=CalcPolynomeXY(ListePSF^[k].X-ImgInfos.Sx div 2,ListePSF^[k].Y-ImgInfos.Sy div 2,
      AstrometrieInfos.PolyY,AstrometrieInfos.DegrePoly);
   XProjPU:=XProj*AstrometrieInfos.TaillePixelX/AstrometrieInfos.Focale*1000/1e6;
   YProjPU:=YProj*AstrometrieInfos.TaillePixelX/AstrometrieInfos.Focale*1000/1e6;
   XYToAlphaDelta(XProjPU,YProjPU,AstrometrieInfos.Alpha0,AstrometrieInfos.Delta0,Alpha,Delta);

   Inc(NbAstrom);
   ListePSF^[k].Alpha:=Alpha;
   ListePSF^[k].Delta:=Delta;
   AstromCourant.Alpha:=Alpha;
   AstromCourant.Delta:=Delta;
   AstromCourant.X:=Round(ListePSF^[k].X);
   AstromCourant.Y:=Round(ListePSF^[k].Y);   

//   Echelle:=ArcTan(AstrometrieInfos.TaillePixel/AstrometrieInfos.Focale/1000)*180/Pi*3600;
   EchelleX:=ArcTan(AstrometrieInfos.TaillePixelX/AstrometrieInfos.Focale/1000)*180/Pi*3600;
   EchelleY:=ArcTan(AstrometrieInfos.TaillePixelY/AstrometrieInfos.Focale/1000)*180/Pi*3600;
   Echelle:=Sqrt((Sqr(EchelleX)+Sqr(EchelleY))/2);   

   ma:=0;
   Erreur:=0;
   for i:=0 to AstrometrieInfos.DegrePoly do
      begin
      for j:=0 to i do
         begin
         inc(ma);
         Erreur:=Erreur+AstrometrieInfos.DaX[ma];
         Erreur:=Erreur+AstrometrieInfos.PolyX[ma]*(i-j)*PuissanceDouble(ListePSF^[k].X,i-j-1)*ListePSF^[k].DX;
         Erreur:=Erreur+AstrometrieInfos.PolyX[ma]*j*PuissanceDouble(ListePSF^[k].Y,j-1)*ListePSF^[k].DY;
         Erreur:=Erreur*Echelle;
         end;
      end;
   AstromCourant.DAlpha:=Erreur;
   ListePSF^[k].DAlpha:=Erreur;

   ma:=0;
   Erreur:=0;
   for i:=0 to AstrometrieInfos.DegrePoly do
      begin
      for j:=0 to i do
         begin
         inc(ma);
         Erreur:=Erreur+AstrometrieInfos.DaY[ma];
         Erreur:=Erreur+AstrometrieInfos.PolyY[ma]*(i-j)*PuissanceDouble(ListePSF^[k].X,i-j-1)*ListePSF^[k].DX;
         Erreur:=Erreur+AstrometrieInfos.PolyY[ma]*j*PuissanceDouble(ListePSF^[k].Y,j-1)*ListePSF^[k].DY;
         Erreur:=Erreur*Echelle;
         end;
      end;
   AstromCourant.DDelta:=Erreur;
   ListePSF^[k].DDelta:=Erreur;

   Getmem(AstromCourant.Suivant,Sizeof(TAstrom));   
   AstromCourant:=AstromCourant.Suivant;
   end;


for i:=1 to NBSources do
   Rapport.AddLine(Format('%6.2f %6.2f %s %s %6.5f %6.5f',[ListePSF^[i].X, //nolang
      ListePSF^[i].Y,AlphaToStrAstrom(ListePSF^[i].Alpha),DeltaToStrAstrom(ListePSF^[i].Delta),
      ListePSF^[i].DAlpha/15,ListePSF^[i].DDelta]));

Rapport.AddLine(' ');
Rapport.AddLine(lang('Format MPEC : '));
for i:=1 to NBSources do
    Rapport.AddLine(MpecFormat(ImgInfos.DateTime,ListePSF^[i].Alpha,ListePSF^[i].Delta)); //nolang
Rapport.AddLine(' ');

VisuImg;      
finally
Rapport.Quitter.Enabled:=True;
Rapport.BitBtn1.Enabled:=True;
Rapport.BitBtn2.Enabled:=True;
Rapport.BitBtn3.Enabled:=True;
Freemem(ListePSF,NBSources*Sizeof(TPSF));
end;
finally
Screen.Cursor:=crDefault;
end;
end;

procedure Tpop_image.Configuration1Click(Sender: TObject);
var
FormConf:Tpop_conf;
begin
FormConf:=Tpop_conf.Create(Application);

// Pas moyen de faire autrement !
FormConf.NameOfTabToDisplay:=lang('Répertoires Catalogues');
FormConf.Showmodal;
end;

procedure Tpop_image.Rglerlesseuils1Click(Sender: TObject);
begin
if ImgInfos.Typedata in [2,5,6] then pop_seuils.show;
if ImgInfos.Typedata in [7,8] then pop_seuils_color.show;
MiseAJourSeuils;
end;

procedure Tpop_image.ZoomAvant1Click(Sender: TObject);
begin
if (ZoomFactor<=1) and (ZoomFactor>0.25) then
   begin
   HorizScrollBar.Position:=Round(HorizScrollBar.Position/ZoomFactor*(ZoomFactor-0.25));
   VerticScrollBar.Position:=Round(VerticScrollBar.Position/ZoomFactor*(ZoomFactor-0.25));
   ZoomFactor:=ZoomFactor-0.25;

   AjusteFenetre;
   VisuImg;
   end;
if (ZoomFactor<=10) and (ZoomFactor>1) then
   begin
   HorizScrollBar.Position:=Round(((HorizScrollBar.Position+Img_Box.Width div 2)
      /ZoomFactor)*(ZoomFactor-1))-Img_Box.Width div 2;
   VerticScrollBar.Position:=Round(((VerticScrollBar.Position+Img_Box.Height div 2)
      /ZoomFactor)*(ZoomFactor-1))-Img_Box.Height div 2;
   ZoomFactor:=ZoomFactor-1;

   AjusteFenetre;
   VisuImg;
   end;

pop_Main.StatusBar1.Panels[1].Text:=lang('Facteur de zoom = ')+MyFloatToStr(ZoomFactor,2);
end;

procedure Tpop_image.ZoomArrire1Click(Sender: TObject);
begin
if (ZoomFactor<10) and (ZoomFactor>=1) then
   begin
   HorizScrollBar.Position:=Round(((HorizScrollBar.Position+Img_Box.Width div 2)
      /ZoomFactor)*(ZoomFactor+1))-Img_Box.Width div 2;
   VerticScrollBar.Position:=Round(((VerticScrollBar.Position+Img_Box.Height div 2)
      /ZoomFactor)*(ZoomFactor+1))-Img_Box.Height div 2;
   ZoomFactor:=ZoomFactor+1;

   AjusteFenetre;
   VisuImg;
   end;
if (ZoomFactor<1) and (ZoomFactor>=0.25) then
   begin
//   HorizScrollBar.Position:=Round(HorizScrollBar.Position/ZoomFactor*(ZoomFactor+0.25));
//   VerticScrollBar.Position:=Round(VerticScrollBar.Position/ZoomFactor*(ZoomFactor+0.25));
   HorizScrollBar.Position:=Trunc(HorizScrollBar.Position/ZoomFactor*(ZoomFactor+0.25));
   VerticScrollBar.Position:=Trunc(VerticScrollBar.Position/ZoomFactor*(ZoomFactor+0.25));
   ZoomFactor:=ZoomFactor+0.25;

   AjusteFenetre;
   VisuImg;
   end;

pop_Main.StatusBar1.Panels[1].Text:=lang('Facteur de zoom = ')+MyFloatToStr(ZoomFactor,2);
end;

procedure Tpop_image.outN252Click(Sender: TObject);
begin
   SetZoom(0.25);
end;

procedure Tpop_image.outN502Click(Sender: TObject);
begin
   SetZoom(0.5);
end;

procedure Tpop_image.outN752Click(Sender: TObject);
begin
   SetZoom(0.75);
end;

procedure Tpop_image.outN1002Click(Sender: TObject);
begin
   SetZoom(1);
end;

procedure Tpop_image.outN2002Click(Sender: TObject);
begin
   SetZoom(2);
end;

procedure Tpop_image.outN3002Click(Sender: TObject);
begin
   SetZoom(3);
end;

procedure Tpop_image.outN4002Click(Sender: TObject);
begin
   SetZoom(4);
end;

procedure Tpop_image.outN5002Click(Sender: TObject);
begin
   SetZoom(5);
end;

procedure Tpop_image.outN6002Click(Sender: TObject);
begin
   SetZoom(6);
end;

procedure Tpop_image.outN7002Click(Sender: TObject);
begin
   SetZoom(7);
end;

procedure Tpop_image.outN8002Click(Sender: TObject);
begin
   SetZoom(8);
end;

procedure Tpop_image.outN9002Click(Sender: TObject);
begin
   SetZoom(9);
end;

procedure Tpop_image.outN10002Click(Sender: TObject);
begin
   SetZoom(10);
end;

procedure Tpop_image.Informations1Click(Sender: TObject);
var
pop_infos_image:Tpop_infos_image;
begin
   pop_infos_image:=Tpop_infos_image.Create(Application);
   pop_infos_image.Panel6.Caption:=IntToStr(ImgInfos.Sx);
   pop_infos_image.Panel7.Caption:=IntToStr(ImgInfos.Sy);
   // Passage ImgInfos -> Fenetre
   with ImgInfos do
      begin
      case ImgInfos.Typedata of
         1,2,3,7:pop_infos_image.Panel8.Caption:=lang('Entier');
         4,5,6,8:pop_infos_image.Panel8.Caption:=lang('Réel');
         end;
      pop_infos_image.Panel9.Caption:=IntToStr(Self.ImgInfos.NbPlans);
//      pop_infos_image.Panel9.Caption:='test';
      pop_infos_image.DateTime:=DateTime;
      pop_infos_image.NbreEdit4.Text:=MyFloatToStr(ImgInfos.TempsPose/1000,3);
      pop_infos_image.SpinEdit1.Value:=BinningX;
      pop_infos_image.SpinEdit2.Value:=BinningY;
      pop_infos_image.CheckBox1.Checked:=MiroirX;
      pop_infos_image.CheckBox2.Checked:=MiroirY;
      pop_infos_image.Edit1.Text:=Telescope;
      pop_infos_image.Edit2.Text:=Observateur;
      pop_infos_image.Edit3.Text:=Camera;
      pop_infos_image.Edit4.Text:=Observatoire;
      pop_infos_image.Edit5.Text:=Filtre;
      pop_infos_image.Edit6.Text:=Commentaires[1];
      pop_infos_image.Edit7.Text:=Commentaires[2];
      pop_infos_image.Edit8.Text:=Commentaires[3];
      pop_infos_image.Edit9.Text:=Commentaires[4];
      pop_infos_image.NbreEdit1.Text:=Trim(MyFloatToStr(Focale,3));
      pop_infos_image.NbreEdit5.Text:=Trim(MyFloatToStr(Diametre,3));
      pop_infos_image.NbreEdit6.Text:=Trim(MyFloatToStr(TemperatureCCD,1));
      pop_infos_image.NbreEdit7.Text:=Trim(MyFloatToStr(OrientationCCD,1));
      pop_infos_image.NbreEdit8.Text:=Trim(MyFloatToStr(Seeing,1));
      pop_infos_image.NbreEdit11.Text:=Trim(MyFloatToStr(RMSGuideError,1));
//      pop_infos_image.NbreEdit11.Text:='5';
      pop_infos_image.Mask_Alpha.Text:=AlphaToStr(Alpha);
      pop_infos_image.Mask_Delta.Text:=DeltaToStr(Delta);
      pop_infos_image.NbreEdit2.Text:=Trim(MyFloatToStr(PixX,2));
      pop_infos_image.NbreEdit3.Text:=Trim(MyFloatToStr(PixY,2));
      pop_infos_image.Panel2.Caption:=IntToStr(X1);
      pop_infos_image.Panel3.Caption:=IntToStr(Y1);
      pop_infos_image.Panel4.Caption:=IntToStr(X2);
      pop_infos_image.Panel5.Caption:=IntToStr(Y2);
      pop_infos_image.NbreEdit9.Text:=MyFloatToStr(BZero,6);
      pop_infos_image.NbreEdit10.Text:=MyFloatToStr(BScale,6);
      end;
   if pop_infos_image.ShowModal=mrOK then
      begin
      // Passage Fenetre -> ImgInfos
      with ImgInfos do
         begin
         DateTime:=Int(pop_infos_image.DateTimePicker1.Date)+Frac(pop_infos_image.DateTimePicker2.Time);
         TempsPose:=Round(MyStrToFloat(pop_infos_image.NbreEdit4.Text)*1000);
         BinningX:=pop_infos_image.SpinEdit1.Value;
         BinningY:=pop_infos_image.SpinEdit2.Value;
         MiroirX:=pop_infos_image.CheckBox1.Checked;
         MiroirY:=pop_infos_image.CheckBox2.Checked;
         Telescope:=pop_infos_image.Edit1.Text;
         Observateur:=pop_infos_image.Edit2.Text;
         Camera:=pop_infos_image.Edit3.Text;
         Observatoire:=pop_infos_image.Edit4.Text;
         Filtre:=pop_infos_image.Edit5.Text;
         Commentaires[1]:=pop_infos_image.Edit6.Text;
         Commentaires[2]:=pop_infos_image.Edit7.Text;
         Commentaires[3]:=pop_infos_image.Edit8.Text;
         Commentaires[4]:=pop_infos_image.Edit9.Text;
         Focale:=MyStrToFloat(pop_infos_image.NbreEdit1.Text);
         Diametre:=MyStrToFloat(pop_infos_image.NbreEdit5.Text);
         TemperatureCCD:=MyStrToFloat(pop_infos_image.NbreEdit6.Text);
         OrientationCCD:=MyStrToFloat(pop_infos_image.NbreEdit7.Text);
         Seeing:=MyStrToFloat(pop_infos_image.NbreEdit8.Text);
         RMSGuideError:=MyStrToFloat(pop_infos_image.NbreEdit11.Text);
         Alpha:=StrToAlpha(pop_infos_image.Mask_Alpha.Text);
         Delta:=StrToDelta(pop_infos_image.Mask_Delta.Text);
         PixX:=MyStrToFloat(pop_infos_image.NbreEdit2.Text);
         PixY:=MyStrToFloat(pop_infos_image.NbreEdit3.Text);
         BZero:=MyStrToFloat(pop_infos_image.NbreEdit9.Text);
         BScale:=MyStrToFloat(pop_infos_image.NbreEdit10.Text);
         end;
      end;
end;

procedure Tpop_image.Coupephotomtrique2Click(Sender: TObject);
begin
if TypePointage=PointeOff then
   begin
   TypePointage:=CoupePhoto;
   FormePointage:=Reticule;
   ClipOn;
   end;
end;

procedure Tpop_image.img_boxClick(Sender: TObject);
var
XTemp,YTemp,X,Y:Integer;
ax,bx,ay,by:Double;
ax1,bx1,ay1,by1:Double;
XinitEcran,YinitEcran,XEcran,YEcran,Ximg,Yimg:Integer;
Point:TPoint;
begin
GetCursorPos(Point);
Point:=img_box.ScreenToClient(Point);
X:=Point.X;
Y:=Point.Y;

ax1:=(ImgInfos.Sx-1)/(ZoomFactor*ImgInfos.Sx-ZoomFactor);
bx1:=1-ax1;
ay1:=(ImgInfos.Sy-1)/(ZoomFactor*ImgInfos.Sy-ZoomFactor);
by1:=1-ay1;

ax:=(Img_Box.Width-1)/ZoomFactor/(Img_Box.Width-1);
bx:=ax1*Round(HorizScrollBar.Position)+bx1;
ay:=(Img_Box.Height-1)/ZoomFactor/(Img_Box.Height-1);
// Merde faut pas inverser ici / Pourquoi ? / Mystere et boule de gomme !
by:=ay1*Round(VerticScrollBar.Position)+by1;

XEcran:=Trunc(ax*X+bx);
YEcran:=Trunc(ay*Y+by);
XinitEcran:=Trunc(ax*Xinit+bx);
YinitEcran:=Trunc(ay*YInit+by);

//if Button=mbLeft then
   begin
   if FormePointage=Ligne then
      begin
      // On efface la ligne à l'ancienne position
      Img_Box.Canvas.pen.Mode:=pmXor;
      Img_Box.Canvas.MoveTo(Xinit,Yinit);
      Img_Box.Canvas.LineTo(OldX,OldY);

      case TypePointage of
         CoupePhoto:begin
                    TypePointage:=PointeOff;
                    FormePointage:=Off;
                    YinitEcran:=ImgInfos.Sy-YinitEcran+1;
                    YEcran:=ImgInfos.Sy-YEcran+1;
                    XEcran:=XEcran;
                    if XinitEcran>XEcran then
                       begin
                       XTemp:=XinitEcran;
                       XinitEcran:=XEcran;
                       XEcran:=XTemp;
                       end;
                    if YinitEcran>YEcran then
                       begin
                       YTemp:=YinitEcran;
                       YinitEcran:=YEcran;
                       YEcran:=YTemp;
                       end;
                    DisplayCoupePhotometrique(XinitEcran,YinitEcran,XEcran,YEcran);
                    ClipOff;
                    end;
         end;
      end;

   //Penser a mettre aussi a jour Tpop_image.FormKeyDown
   if FormePointage=Rectangle then
      begin
      // On efface le rectangle à l'ancienne position
      Img_Box.Canvas.Pen.Color:=ClWhite;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=PmXor;
      Img_Box.Canvas.Brush.Style:=bsClear;
      Img_Box.Canvas.Rectangle(Xinit,Yinit,OldX,OldY);

      //Penser a mettre aussi a jour Tpop_image.FormKeyDown
      case TypePointage of
         PointeFenetrage:begin
                         TypePointage:=PointeOff;
                         FormePointage:=Off;
                         YinitEcran:=ImgInfos.Sy-YinitEcran+1;
//                         YEcran:=ImgInfos.Sy-YEcran+1;
                         // Pourquoi cette adaptation ? Mystere et boule de gomme !
                         YEcran:=ImgInfos.Sy-YEcran+2;
                         XEcran:=XEcran-1;
                         if XinitEcran>XEcran then
                            begin
                            XTemp:=XinitEcran;
                            XinitEcran:=XEcran;
                            XEcran:=XTemp;
                            end;
                         if YinitEcran>YEcran then
                            begin
                            YTemp:=YinitEcran;
                            YinitEcran:=YEcran;
                            YEcran:=YTemp;
                            end;
                         SaveUndo;
//   if (YEcran>0) and (YEcran<=ImgInfos.Sy) and (XEcran>0) and (XEcran<=ImgInfos.Sx) then
//           pop_main.StatusBar1.Panels[0].Text :='X1='+IntToStr(XinitEcran)   //nolang
//              +' Y1='+IntToStr(ImgInfos.Sy-YInitEcran+1)+' X2='+IntToStr(XEcran)      //nolang
//              +' Y2='+IntToStr(ImgInfos.Sy-YEcran+1)+' DX='+IntToStr(Abs(X-Xinit))    //nolang
//              +' DY='+IntToStr(Abs(Y-Yinit));                                //nolang

                         FenetrageTempo(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,XinitEcran,YinitEcran,XEcran,YEcran);
                         AjusteFenetre;
                         VisuImg;
                         ClipOff;
                         end;
         PointeStatFenetre:begin
                         TypePointage:=PointeOff;
                         FormePointage:=Off;
                         YinitEcran:=ImgInfos.Sy-YinitEcran+1;
                         YEcran:=ImgInfos.Sy-YEcran+1;
                         if XinitEcran>XEcran then
                            begin
                            XTemp:=XinitEcran;
                            XinitEcran:=XEcran;
                            XEcran:=XTemp;
                            end;
                         if YinitEcran>YEcran then
                            begin
                            YTemp:=YinitEcran;
                            YinitEcran:=YEcran;
                            YEcran:=YTemp;
                            end;
                         StatFenetre(XinitEcran,YinitEcran,XEcran,YEcran);
                         VisuImg;
                         ClipOff;
                         end;
         end;
      end;

   // Penser a mettre aussi a jour Tpop_image.FormKeyDown
   if (FormePointage=Reticule) and ReticulePresent then
      begin
      // On efface le réticule
      ReticulePresent:=False;
//      WriteSpy('Reticule Off mousedown');
      Img_Box.Canvas.Pen.Color:=ClWhite;
      Img_Box.Canvas.Pen.Style:=PsSolid;
      Img_Box.Canvas.Pen.Mode:=PmXor;
      Img_Box.Canvas.MoveTo(OldX,0);
      Img_Box.Canvas.LineTo(OldX,Img_Box.Height);
      Img_Box.Canvas.MoveTo(0,OldY);
      Img_Box.Canvas.LineTo(Img_Box.Width,OldY);

      // Penser a mettre aussi a jour Tpop_image.FormKeyDown
      case TypePointage of
         PointeEtalon:begin
                      TypePointage:=PointeOff;
                      FormePointage:=Off;
                      ClipOff;
                      EtalonnePhotometrie(XEcran,YEcran);
                      end;
         EnleveEtalon:begin
                      TypePointage:=PointeOff;
                      FormePointage:=Off;
                      ClipOff;
                      DoEnleveEtalon(XEcran,YEcran);
                      end;
         SupprimeEtalon:begin
                        TypePointage:=PointeOff;
                        FormePointage:=Off;
                        ClipOff;
                        DoSupprimeEtalon(XEcran,YEcran);
                        end;
         PointeMagnitude:begin
                        TypePointage:=PointeOff;
                        FormePointage:=Off;
                        ClipOff;
                        MesurePhotometrie(XEcran,YEcran);
                        end;
         PointeEtoile:begin
                      TypePointage:=PointeOff;
                      FormePointage:=Off;
                      ClipOff;
                      MesureEtoile(XEcran,YEcran);
                      end;
         PointeFenetrage:begin
                         FormePointage:=Rectangle;
                         Xinit:=X;
                         Yinit:=Y;
//                         ClipOn;
                         end;
         PointeStatFenetre:begin
                         FormePointage:=Rectangle;
                         Xinit:=X;
                         Yinit:=Y;
//                         ClipOn;
                         end;
         PointeAstrometrie:begin
                           TypePointage:=PointeOff;
                           FormePointage:=Off;
                           ClipOff;
                           MesureAstrometrie(XEcran,YEcran);
                           end;
         PointeCicatLigne:begin
                          TypePointage:=PointeOff;
                          FormePointage:=Off;
                          ClipOff;

                          Ximg:=OldX;
                          Yimg:=OldY;
                          EcranToImage(XImg,YImg);

                          SaveUndo;
                          CicatriseLigne(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Round(Yimg));
                          if Config.BuidingCosmeticFile then pop_edit_text.Memo1.Lines.Add('HealRow '+ //nolang
                             IntToStr(Round(Yimg)));
                          VisuImg;
                          end;
         PointeCicatColonne:begin
                            TypePointage:=PointeOff;
                            FormePointage:=Off;
                            ClipOff;

                            Ximg:=OldX;
                            Yimg:=OldY;
                            EcranToImage(XImg,YImg);

                            SaveUndo;
                            CicatriseColonne(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Round(Ximg));
                            if Config.BuidingCosmeticFile then pop_edit_text.Memo1.Lines.Add('HealColumn '+ //nolang
                                IntToStr(Round(Yimg)));
                            VisuImg;
                            end;
         PointeCicatPixel:begin
                          TypePointage:=PointeOff;
                          FormePointage:=Off;
                          ClipOff;

                          Ximg:=OldX;
                          Yimg:=OldY;
                          EcranToImage(XImg,YImg);

                          SaveUndo;
                          CicatrisePixel(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Round(Ximg),Round(Yimg));
                          if Config.BuidingCosmeticFile then pop_edit_text.Memo1.Lines.Add('HealPixel '+ //nolang
                             IntToStr(Round(Ximg))+' '+IntToStr(Round(Yimg)));
                          VisuImg;
                          end;
         CoupePhoto:begin
                    FormePointage:=Ligne;
                    Xinit:=X;
                    Yinit:=Y;
                    end;
         AjouteMarque:begin
                      TypePointage:=PointeOff;
                      FormePointage:=Off;
                      ClipOff;
                      XMarque:=XEcran+1;
                      YMarque:=ImgInfos.Sy-YEcran;
                      AjouterMarque1.Checked:=True;
                      AjusteFenetre;
                      VisuImg;
                      end;
         end;
//      ClipOff;
      end;
   end;
VisuImg;
end;

procedure Tpop_image.Cicatriseruneligne2Click(Sender: TObject);
begin
if TypePointage=PointeOff then
   begin
   TypePointage:=PointeCicatLigne;
   FormePointage:=Reticule;
   ClipOn;
   end;
end;

procedure Tpop_image.Cicatriserunecolonne2Click(Sender: TObject);
begin
if TypePointage=PointeOff then
   begin
   TypePointage:=PointeCicatColonne;
   FormePointage:=Reticule;
   ClipOn;
   end;
end;

procedure Tpop_image.Cicatriserunpixel1Click(Sender: TObject);
begin
if TypePointage=PointeOff then
   begin
   TypePointage:=PointeCicatPixel;
   FormePointage:=Reticule;
   ClipOn;
   end;
end;

procedure Tpop_image.Enregisterfichiercosmetique1Click(Sender: TObject);
begin
Config.BuidingCosmeticFile:=True;
pop_edit_text:=Tpop_edit_text.Create(Application);
pop_edit_text.Caption:=lang('Fichier cosmétique');
pop_edit_text.Show;
pop_edit_text.SaveDialog1.Filter:=lang('Fichier cosmétique (*.cos)|*.cos');
pop_edit_text.Extension:=lang('.cos');
end;

procedure Tpop_image.Appliquerunscript1Click(Sender: TObject);
var
   Name:string;
begin
pop_main.OpenDialog.Filter:=lang('Fichier cosmétique (*.cos)|*.cos');
pop_main.opendialog.initialdir:=config.RepImages;
if pop_main.OpenDialog.Execute then
   begin
   Name:=pop_main.OpenDialog.FileName;
   CorrectionCosmetique(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Name);
   VisuImg;
   end;
end;

procedure Tpop_image.GenerePixelsChauds;
var
   i,j:Integer;
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   Niveau:Double;
   Maxi,Mini,Mediane,Moy,Ecart:Double;
   Script:TStrings;
   Nom:string;
begin
Statistiques(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,Mini,mediane,Maxi,Moy,Ecart);

New(TabItems);
try
IniTabItems(TabItems);

with TabItems^[1] do
   begin
   TypeItem:=tiReal;
   Msg:=lang('Niveau limite : ');
   ValeurDefaut:=Int(Moy+5*Ecart);
   ValeurMin:=MinDouble;
   ValeurMax:=MaxDouble;
   end;

DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,200);
DlgStandard.Caption:=lang('Liste de pixels chauds');
if DlgStandard.ShowModal=mrOK then
   begin
   Niveau:=TabItems^[1].ValeurSortie;

   Screen.Cursor:=crHourGlass;
   try

   Script:=TStringList.Create;
   for i:=1 to ImgInfos.Sx do
      case ImgInfos.TypeData of
         2,7:for j:=1 to ImgInfos.Sy do
                if (DataInt^[1]^[j]^[i]>Niveau) and (i>1) and (j>1) and (i<ImgInfos.Sx) and (j<ImgInfos.Sy) then
                   Script.Add('HealPixel '+IntToStr(i)+' '+IntToStr(j)); //nolang
         5,8:for j:=1 to ImgInfos.Sy do
                if (DataDouble^[1]^[j]^[i]>Niveau) and (i>1) and (j>1) and (i<ImgInfos.Sx) and (j<ImgInfos.Sy) then
                   Script.Add('HealPixel '+IntToStr(i)+' '+IntToStr(j)); //nolang
         end;
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;

   pop_main.SaveDialog.Filter:=lang('Fichier cosmétique (*.cos)|*.cos');
   if pop_main.SaveDialog.Execute then
      begin
      Nom:=pop_main.SaveDialog.Filename;
      if (Uppercase(ExtractFileExt(Nom))<>'.COS') then Nom:=Nom+'.cos'; //nolang
      Script.SaveToFile(Nom);
      end;
   end
else DlgStandard.Free;

finally
Dispose(TabItems);
end;
end;

procedure Tpop_image.Affichecible1Click(Sender: TObject);
begin
   if Affichecible1.Checked then Affichecible1.Checked:=False
   else Affichecible1.Checked:=True;
   AjusteFenetre;
   VisuImg;
end;

procedure Tpop_image.Driveversladroite1Click(Sender: TObject);
begin
   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   DeriveeXPlus(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;
end;

procedure Tpop_image.Driveversladroite2Click(Sender: TObject);
begin
   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   DeriveeXMoins(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;
end;

procedure Tpop_image.Driveverslebas1Click(Sender: TObject);
begin
   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   DeriveeYPlus(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;
end;

procedure Tpop_image.Driveverslehaut1Click(Sender: TObject);
begin
   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   DeriveeYMoins(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;
end;

procedure Tpop_image.Normedugradient1Click(Sender: TObject);
begin
   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   NormeGradient(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;
end;

procedure Tpop_image.Extractiondecontours1Click(Sender: TObject);
begin
   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   ExtractContourSimple(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;
end;

procedure Tpop_image.Simplifieavecfiltrage1Click(Sender: TObject);
begin
   Screen.Cursor:=crHourGlass;
   try
   SaveUndo;
   ExtractContourFiltreSimple(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
   VisuImg;
   finally
   Screen.Cursor:=crDefault;
   end;
end;

procedure Tpop_image.AjouterMarque1Click(Sender: TObject);
begin
if AjouterMarque1.Checked then
   begin
   AjouterMarque1.Checked:=False;
   AjusteFenetre;
   VisuImg;
   end
else
   begin
   AjouterMarque1.Checked:=True;
   if TypePointage=PointeOff then
      begin
      TypePointage:=AjouteMarque;
      FormePointage:=Reticule;
      ClipOn;
      end;
   end;

end;

procedure Tpop_image.Fermer1Click(Sender: TObject);
begin
Close;
end;

//****************************************************************************
//*******************************   scripts   ********************************
//****************************************************************************

procedure Tpop_image.VisuStar;
begin
AjusteFenetre;
VisuAutoEtoiles;
end;

procedure Tpop_image.VisuStarPlane(Nb:Integer);
begin
VisuAutoEtoilesPlan(Nb);
end;

procedure Tpop_image.VisuPlanet;
begin
VisuAutoPlanetes;
end;

procedure Tpop_image.VisuPlanetPlane(Nb:Integer);
begin
VisuAutoPlanetesPlan(Nb);
end;

procedure Tpop_image.VisuMinMax;
begin
VisuAutoMinMax;
end;

procedure Tpop_image.Visu(Mini,Maxi:Single);
begin
VisuMiniMaxi(Mini,Maxi);
end;

procedure Tpop_image.VisuPlane(Plane:Byte;Mini,Maxi:Single);
begin
VisuMinMaxPlane(Plane,Mini,Maxi);
end;

{procedure Tpop_image.SaveImgFITS(FileName:string);
var
   PosEsp,i:Integer;
   Nom:string;
begin
if ExtractFileExt(FileName)<>'' then
   begin
   PosEsp:=Pos('.',FileName);
   FileName:=Copy(FileName,1,PosEsp-1);
   end;

Nom:=FileName;
FileName:=FileName+'.fit';   //nolang

case ImgInfos.TypeData of
   2:SaveFITS(FileName,DataInt,DataDouble,1,1,ImgInfos);
   5,6:begin
       // TODO : creer un FormatSaveReel
       if Config.TypeSaveFits=0 then SaveFITS(FileName,DataInt,DataDouble,1,1,ImgInfos)
       else
          begin
          ConvertFITSRealToInt(DataDouble,DataInt,ImgInfos);
          SaveFITS(FileName,DataInt,DataDouble,1,ImgInfos.NbPlans,ImgInfos); // OK
          ConvertFITSIntToReal(DataInt,DataDouble,ImgInfos);
          end;
       end;
   7:if config.FormatCouleur=0 then
        begin
        Nom:=trim(Nom);
        i:=Length(Nom);
        while ((Nom[i]>='0')and(Nom[i]<='9'))or(i<=1) do Dec(i);
        // Faudrais integrer ca directement dans SaveFits pour que tout TeleAuto puisse le faire !
        SaveFITS(copy(nom,1,i)+'_R'+copy(nom,i+1,99)+'.fit',DataInt,DataDouble,1,1,ImgInfos); //nolang
        SaveFITS(copy(nom,1,i)+'_G'+copy(nom,i+1,99)+'.fit',DataInt,DataDouble,2,1,ImgInfos); //nolang
        SaveFITS(copy(nom,1,i)+'_B'+copy(nom,i+1,99)+'.fit',DataInt,DataDouble,3,1,ImgInfos); //nolang
        end
     else SaveFITS(FileName,DataInt,DataDouble,1,3,ImgInfos);
   8:begin
     if Config.FormatCouleur=0 then
        begin
        nom:=trim(nom);
        i:=length(nom);
        while ((nom[i]>='0')and(nom[i]<='9'))or(i<=1) do Dec(i);
        // Faudrais integrer ca directement dans SaveFits pour que tout TeleAuto puisse le faire !
        if Config.TypeSaveFits=0 then
           begin
           SaveFITS(copy(nom,1,i)+'_R'+copy(nom,i+1,99)+'.fit',DataInt,DataDouble,1,1,ImgInfos); //nolang
           SaveFITS(copy(nom,1,i)+'_G'+copy(nom,i+1,99)+'.fit',DataInt,DataDouble,2,1,ImgInfos); //nolang
           SaveFITS(copy(nom,1,i)+'_B'+copy(nom,i+1,99)+'.fit',DataInt,DataDouble,3,1,ImgInfos); //nolang
           end
        else
           begin
           ConvertFITSRealToInt(DataDouble,DataInt,ImgInfos);
           SaveFITS(copy(nom,1,i)+'_R'+copy(nom,i+1,99)+'.fit',DataInt,DataDouble,1,1,ImgInfos); //nolang
           SaveFITS(copy(nom,1,i)+'_G'+copy(nom,i+1,99)+'.fit',DataInt,DataDouble,2,1,ImgInfos); //nolang
           SaveFITS(copy(nom,1,i)+'_B'+copy(nom,i+1,99)+'.fit',DataInt,DataDouble,3,1,ImgInfos); //nolang
           ConvertFITSIntToReal(DataInt,DataDouble,ImgInfos);
           end;
        end
     else
        begin
        if Config.TypeSaveFits=0 then
           SaveFITS(FileName,DataInt,DataDouble,1,3,ImgInfos)
        else
           begin
           ConvertFITSRealToInt(DataDouble,DataInt,ImgInfos);
           SaveFITS(FileName,DataInt,DataDouble,1,3,ImgInfos);
           ConvertFITSIntToReal(DataInt,DataDouble,ImgInfos);
           end;
        end;
     end;
   end;
end;}

procedure Tpop_image.SaveFITSInt(FileName:string);
var
   N,Ext:string;
begin
if (Uppercase(ExtractFileExt(FileName))<>'.FTS') and                                                    //nolang
   (Uppercase(ExtractFileExt(FileName))<>'.FIT') and                                                    //nolang
   (Uppercase(ExtractFileExt(FileName))<>'.FITS') then FileName:=FileName+'.fit';                       //nolang
Config.RepImages:=ExtractFilePath(FileName);
Caption:=Pop_Main.GiveName(ExtractFileName(FileName),Self);

case ImgInfos.TypeData of
   2:SaveFITS(FileName,DataInt,DataDouble,1,ImgInfos.NbPlans,ImgInfos);
   5,6:begin
       ConvertFITSRealToInt(DataDouble,DataInt,ImgInfos);
       ChangerMenu;
       Pop_Main.MiseAJourMenu(Self);
       SaveFITS(FileName,DataInt,DataDouble,1,ImgInfos.NbPlans,ImgInfos);
       ConvertFITSIntToReal(DataInt,DataDouble,ImgInfos);
       end;
   7:begin
     if Config.FormatCouleur=0 then
        begin
        N:=ExtractFileName(FileName);
        Ext:=ExtractFileExt(FileName);
        SaveFITS(n+'_R'+Ext,DataInt,DataDouble,1,1,ImgInfos);  // un fichier par couleur //nolang
        SaveFITS(n+'_G'+Ext,DataInt,DataDouble,2,1,ImgInfos);                            //nolang
        SaveFITS(n+'_B'+Ext,DataInt,DataDouble,3,1,ImgInfos);                            //nolang
        end
     else
        begin
        SaveFITS(FileName,DataInt,DataDouble,1,3,ImgInfos);   // fichier RGB
        end;
     end;
   8:begin
     ConvertFITSRealToInt(DataDouble,DataInt,ImgInfos);
     ChangerMenu;
     Pop_Main.MiseAJourMenu(Self);
     if Config.FormatCouleur=0 then
        begin
        N:=ExtractFileName(FileName);
        Ext:=ExtractFileExt(FileName);
        SaveFITS(N+'_R'+Ext,DataInt,DataDouble,1,1,ImgInfos);  // un fichier par couleur //nolang
        SaveFITS(N+'_G'+Ext,DataInt,DataDouble,2,1,ImgInfos);                            //nolang
        SaveFITS(N+'_B'+Ext,DataInt,DataDouble,3,1,ImgInfos);                            //nolang
        end
     else
        begin
        SaveFITS(FileName,DataInt,DataDouble,1,3,ImgInfos);   // fichier RGB
        end;
     ConvertFITSIntToReal(DataInt,DataDouble,ImgInfos);
     end;
   end;
end;

procedure Tpop_image.SaveFITSFloat(FileName:string);
var
   N,Ext:String;
begin
if (Uppercase(ExtractFileExt(FileName))<>'.FTS') and                                                    //nolang
   (Uppercase(ExtractFileExt(FileName))<>'.FIT') and                                                    //nolang
   (Uppercase(ExtractFileExt(FileName))<>'.FITS') then FileName:=FileName+'.fit';                       //nolang
config.RepImages:=ExtractFilePath(FileName);
Caption:=Pop_Main.GiveName(ExtractFileName(FileName),Self);

case ImgInfos.TypeData of
   2:begin
     ConvertIntToReal(DataInt,DataDouble,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
     ImgInfos.Typedata:=5;
     ChangerMenu;
     Pop_Main.MiseAJourMenu(Self);
     SaveFITS(FileName,DataInt,DataDouble,1,ImgInfos.NbPlans,ImgInfos);
     end;
   5,6:SaveFITS(FileName,DataInt,DataDouble,1,ImgInfos.NbPlans,ImgInfos);
   7:begin
     ConvertIntToReal(DataInt,DataDouble,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
     ImgInfos.Typedata:=8;
     ChangerMenu;
     Pop_Main.MiseAJourMenu(Self);
     if config.FormatCouleur=0 then
        begin
        N:=ExtractFileName(FileName);
        Ext:=ExtractFileExt(FileName);
        SaveFITS(N+'_R'+Ext,DataInt,DataDouble,1,1,ImgInfos);  // un fichier par couleur //nolang
        SaveFITS(N+'_G'+Ext,DataInt,DataDouble,2,1,ImgInfos);                            //nolang
        SaveFITS(N+'_B'+Ext,DataInt,DataDouble,3,1,ImgInfos);                            //nolang
        end
     else
        begin
        SaveFITS(FileName,DataInt,DataDouble,1,3,ImgInfos);   // fichier RGB
        end
     end;
   8:begin
     if config.FormatCouleur=0 then
        begin
        N:=ExtractFileName(FileName);
        Ext:=ExtractFileExt(FileName);
        SaveFITS(N+'_R'+Ext,DataInt,DataDouble,1,1,ImgInfos);  // un fichier par couleur //nolang
        SaveFITS(N+'_G'+Ext,DataInt,DataDouble,2,1,ImgInfos);                            //nolang
        SaveFITS(N+'_B'+Ext,DataInt,DataDouble,3,1,ImgInfos);                            //nolang
        end
     else
        begin
        SaveFITS(FileName,DataInt,DataDouble,1,3,ImgInfos);   // fichier RGB
        end
     end;
   end;
end;

procedure Tpop_image.SaveImgCPAV3(FileName:string);
var
   N,Ext:String;
begin
if Uppercase(ExtractFileExt(FileName))<>'.CPA' then FileName:=FileName+'.cpa'; //nolang
Config.RepImages:=ExtractFilePath(FileName);
Caption:=Pop_Main.GiveName(ExtractFileName(FileName),Self);
if (ImgInfos.Sx=7) and (ImgInfos.NbPlans=3) then
   begin
   if config.FormatCouleur=0 then
      begin
      N:=ExtractFileName(FileName);
      Ext:=ExtractFileExt(FileName);
      SaveCPAV3(N+'_R'+Ext,DataInt,1,ImgInfos);  // un fichier par couleur //nolang
      SaveCPAV3(N+'_G'+Ext,DataInt,2,ImgInfos);                            //nolang
      SaveCPAV3(N+'_B'+Ext,DataInt,3,ImgInfos);                            //nolang
      end
   else
      begin
      SaveCPAV3(FileName,DataInt,1,ImgInfos);   // fichier RGB
      end
   end
   else SaveCPAV3(FileName,DataInt,1,ImgInfos);   // pas en couleur
end;

procedure Tpop_image.SaveImgCPAV4(FileName:string);
var
   N,Ext:String;
begin
if Uppercase(ExtractFileExt(Filename))<>'.CPA' then Filename:=Filename+'.cpa'; //nolang
Config.RepImages:=ExtractFilePath(Filename);
Caption:=Pop_Main.GiveName(ExtractFileName(Filename),Self);
if (ImgInfos.Sx=7) and (ImgInfos.NbPlans=3) then
   begin
   if config.FormatCouleur=0 then
      begin
      N:=extractfilename(Filename);
      Ext:=ExtractFileExt(Filename);
      SaveCPAV4d(N+'_R'+Ext,DataInt,1,ImgInfos);  // un fichier par couleur //nolang
      SaveCPAV4d(N+'_G'+Ext,DataInt,2,ImgInfos);                            //nolang
      SaveCPAV4d(N+'_B'+Ext,DataInt,3,ImgInfos);                            //nolang
      end
   else SaveCPAV4d(Filename,DataInt,1,ImgInfos);   // fichier RGB
   end
else SaveCPAV4d(Filename,DataInt,1,ImgInfos);   // pas en couleur
end;

procedure Tpop_image.SaveImgPIC(FileName:string);
begin
if Uppercase(ExtractFileExt(FileName))<>'.PIC' then Filename:=FileName+'.pic'; //nolang
Config.RepImages:=ExtractFilePath(FileName);
Caption:=Pop_Main.GiveName(ExtractFileName(FileName),Self);
SavePIC(FileName,DataInt,ImgInfos);
end;

procedure Tpop_image.SaveImgBMP(FileName:string);
begin
if Uppercase(ExtractFileExt(FileName))<>'.BMP' then FileName:=FileName+'.bmp'; //nolang
Config.RepImages:=ExtractFilePath(FileName);
Caption:=Pop_Main.GiveName(ExtractFileName(FileName),Self);
SaveBMP(FileName,DataInt,DataDouble,ImgInfos);
end;

procedure Tpop_image.SaveImgJPG(FileName:string);
begin
if (Uppercase(ExtractFileExt(FileName))<>'.JPG') and (Uppercase(ExtractFileExt(FileName))<>'.JEPG') then FileName:=FileName+'.jpg'; //nolang
Config.RepImages:=ExtractFilePath(FileName);
Caption:=Pop_Main.GiveName(ExtractFileName(FileName),Self);
SaveJPG(FileName,DataInt,DataDouble,ImgInfos);
end;

procedure Tpop_image.SaveImgTXT(FileName:string);
begin
if (Uppercase(ExtractFileExt(FileName))<>'.TXT') then FileName:=FileName+'.txt'; //nolang
Config.RepImages:=ExtractFilePath(FileName);
SaveText(FileName,DataInt,DataDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Min,ImgInfos.Max,
   ImgInfos.Sx,ImgInfos.NbPlans,ImgInfos.TypeComplexe);
end;


procedure Tpop_image.Isophotes1Click(Sender: TObject);
var
   isopt:TForm;
   lb1,lb2,lb3:TLabel;
   ed1,ed2,ed3:TEdit;
   cb,cok:TBitbtn;
   rdb:integer;b,h,p:integer;err:boolean;

   Maxi,Mini,max,min,Mediane,Moy,Ecart:Double;
begin
Screen.Cursor:=crHourGlass;
try
 Statistiques(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,Mini,mediane,Maxi,Moy,Ecart);
 isopt:=TForm.CreateParented(handle);
 with isopt do
 begin
  Left := 100;
  Top := 100;
  BorderStyle := bsDialog;
  Caption := lang('Isocontours');
  enabled:=true;
  width:=186;
  height:=164;
  Color := clBtnFace;
 end;
 lb1:=TLabel.create(isopt);
 with lb1 do
  begin
   Left := 48;
   Top := 8;
   Width := 18;
   Height := 13;
   Caption := lang('Bas');
   Parent:=isopt;
  end;
 lb2:=TLabel.create(isopt);
 with lb2 do
  begin
   Left := 48;
   Top := 40;
   Width := 23;
   Height := 13;
   Caption := lang('Haut');
   Parent:=isopt;
  end;
 lb3:=TLabel.create(isopt);
 with Lb3 do
  begin
   Left := 48;
   Top := 72;
   Width := 18;
   Height := 13;
   Caption := lang('Pas');
   Parent:=isopt;
  end;
 cb:=TBitbtn.create(isopt);
 with cb do
  begin
   Left := 8;
   Top := 112;
   Width := 75;
   Height := 25;
   Caption := lang('&Annuler');
   TabOrder := 3;
   Kind := bkCancel;
   Parent:=isopt;
   default:=false;
  end;
 cok:=TBitbtn.create(isopt);
 with cok do
  begin
   Left := 96;
   Top := 112;
   Width := 75;
   Height := 25;
   Caption := lang('&OK');
   TabOrder := 4;
   Kind := bkOK;
   Parent:=isopt;
  end;
 ed1:=TEdit.create(isopt);
 with ed1 do
  begin
   Left := 80;
   Top := 8;
   Width := 89;
   Height := 21;
   TabOrder := 0;
   Parent:=isopt;
   Text:=MyFloatToStr(Mini,0);
  end;
 ed2:=TEdit.create(isopt);
 with ed2 do
  begin
   Left := 80;
   Top := 40;
   Width := 89;
   Height := 21;
   TabOrder := 1;
   Parent:=isopt;
   Text:=MyFloatToStr(Maxi,0);
  end;
 ed3:=TEdit.create(isopt);
 with ed3 do
  begin
   Left := 80;
   Top := 72;
   Width := 89;
   Height := 21;
   TabOrder := 2;
   Parent:=isopt;
   Text:=MyFloatToStr((Maxi-Mini)/10,0);
  end;
 isopt.ActiveControl:=ed1;
 rdb:=isopt.ShowModal;
 if rdb <> mrOK then
  begin
  isopt.Close;
  isopt.Free;
  exit;
  end
 else
  begin
   try
    err:=false;
    b:=strtoint(ed1.Text);
    h:=strtoint(ed2.Text);
    p:=strtoint(ed3.Text);
   except
    messagebox(0,Pchar(lang('Entrer des valeurs entières')),
       Pchar(lang('Erreur de saisie')),$1010);
    err:=true;
   end;
   isopt.Close;
   isopt.Free;
   if err=true then exit;
  end;
SaveUndo;
isophotes(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,b,h,p);
AjusteFenetre;
//VisuAutoEtoiles;
VisuMinMax;
finally
Screen.Cursor:=crDefault;
end;
end;

procedure Tpop_image.RV1Click(Sender: TObject);
var
   pop_image:TPop_Image;
   Img:pointer;
   ErrCode:byte;
   numidx,numimg:integer;
begin
try
 Screen.Cursor:=crHourGlass;
 Img:=RGB2Gris(DataInt,DataDouble,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,ErrCode);
 Screen.Cursor:=crDefault;
 if ErrCode <> 0 then
  begin
   MessageBox(0,Pchar(lang('Impossible de convertir en niveaux de gris')),
      Pchar(lang('Information')),MB_OK or MB_ICONWARNING);
   exit;
  end;
 if Img = NIL then exit;
 pop_image:=NIL;
 pop_image:=TPop_Image.Create(application);
 if pop_image <> NIL then
  begin
   if DataInt <> NIL then
    begin
      pop_image.DataInt:=Img;
      pop_image.DataDouble:=NIL;
      pop_image.ImgInfos:=ImgInfos;
      pop_image.ImgInfos.TypeData:=2;
      pop_image.ImgInfos.NbPlans:=1;
    end;
   if DataDouble <> NIL then
    begin
      pop_image.DataDouble:=Img;
      pop_image.DataInt:=NIL;
      pop_image.ImgInfos:=ImgInfos;
      pop_image.ImgInfos.TypeData:=5;
      pop_image.ImgInfos.NbPlans:=1;
    end;
  end;
  pop_image.Caption:=pop_image.Caption + lang(' (NG)');
  pop_image.AjusteFenetre;
  pop_image.VisuImg;
  pop_image.ChangerMenu;
except
 Screen.Cursor:=crDefault;
end;

end;

procedure Tpop_image.CFABayerRGB1Click(Sender: TObject);
var pop_image:tpop_image;NPlans:byte;mini,mediane,moy,maxi,ecart:double;
begin
 if ImgInfos.TypeData <> 2 then exit;
 pop_cfadlg.ShowModal;
 if pop_cfadlg.ModalResult <> idOK then exit;
 pop_image:=tpop_image.create(application);
 pop_image.Width:=32;
 pop_image.Height:=16;
 application.ProcessMessages;
try
 CFA_RGB(DataInt,DataDouble,pop_image.DataInt,pop_image.DataDouble,pop_cfadlg.cfaformat,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,NPlans);
 pop_image.Caption:=tpop_image(Self).Caption +lang(' (couleur)');
 pop_image.ImgInfos:=ImgInfos;
 if pop_image.ImgInfos.TypeData = 2 then pop_image.ImgInfos.TypeData:=7;
 if pop_image.ImgInfos.TypeData = 5 then pop_image.ImgInfos.TypeData:=8;
 pop_image.ImgInfos.NbPlans:=3;
 //Calcule des statisqtiques sur le plan vert
 Statistiques(pop_image.DataInt,pop_image.DataDouble,pop_image.ImgInfos.Typedata,pop_image.ImgInfos.TypeComplexe,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy,2,Mini,Mediane,Maxi,Moy,Ecart);
 mini:=(moy - 2 * ecart);
 maxi:=(moy + 2 * ecart);
 pop_image.ImgInfos.NbAxes:=2;
 pop_image.ImgInfos.Min[1]:=mini;
 pop_image.ImgInfos.Min[2]:=mini;
 pop_image.ImgInfos.Min[3]:=mini;
 pop_image.ImgInfos.Max[1]:=maxi;
 pop_image.ImgInfos.Max[2]:=maxi;
 pop_image.ImgInfos.Max[3]:=maxi;
 pop_image.AjusteFenetre;
 pop_image.VisuImg;
 pop_image.ChangerMenu;
except
 pop_image.Free;
end;
end;

procedure Tpop_image.Balancedescouleurs1Click(Sender: TObject);
var i,j,k:integer;coeff:double;balance:array[1..4] of double;
pop_balance:TPop_balance;OldDS:char;ok:boolean;
begin
 if (TPop_image(Self).ImgInfos.TypeData <> 7) and (TPop_image(Self).ImgInfos.TypeData <> 8) then exit;
 pop_balance:=TPop_balance.create(application);
 if pop_balance.ShowModal <> mrOK then
  begin
   pop_balance.Free;
   exit;
  end;
ok:=false;
OldDS:=DecimalSeparator;
try
 DecimalSeparator:='.'; //indispensable pour les conversions
 balance[1]:=strtofloat(pop_balance.Edit1.Text);
 balance[2]:=strtofloat(pop_balance.Edit2.Text);
 balance[3]:=strtofloat(pop_balance.Edit3.Text);
 balance[4]:=1;
 ok:=true;
except
 Messagebox(0,Pchar(lang('Vérifier les coefficients')),
    Pchar(lang('Erreur')),$1010);
end;
 DecimalSeparator:=OldDS;
 pop_balance.Free;
 if ok=false then exit;
with TPop_image(Self) do
begin
 if (ImgInfos.TypeData = 7) then
  begin
   if DataInt = NIL then exit;
   for k:=1 to ImgInfos.NbPlans do
    begin
    coeff:=balance[k];
    for j:=1 to ImgInfos.Sy do
     for i:=1 to ImgInfos.Sx do
      begin
       DataInt^[k]^[j]^[i]:=round(DataInt^[k]^[j]^[i] * coeff);
      end;
    end;
  end;
 if (ImgInfos.TypeData = 8) then
  begin
   if DataDouble = NIL then exit;
   for k:=1 to ImgInfos.NbPlans do
    begin
    coeff:=balance[k];
    for j:=1 to ImgInfos.Sy do
     for i:=1 to ImgInfos.Sx do
      begin
       DataDouble^[k]^[j]^[i]:=DataDouble^[k]^[j]^[i] * coeff;
      end;
    end;
  end;
 VisuImg;
end;
end;

end.
