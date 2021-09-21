unit u_class;

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

{-------------------------------------------------------------------------------

                            Classes, types et objets

-------------------------------------------------------------------------------}

interface

uses sysutils, classes, windows, u_constants, skychart, graphics;

var
  TraductionEnCours:Boolean;

const
  NbMaxPlateCoef=20;
  TailleBufferv4c=512-sizeof(Boolean)-sizeof(double)-SizeOf(Double)-SizeOf(Boolean)-SizeOf(Double);

type

  Header_PSD=packed record
     signature:array[0..3] of char;  {'8BPS'}
     version:word;
     reserved:array[0..5] of byte;
     channels:word; {1-24}
     height:integer; {1-30000}
     width:integer; {1-30000}
     depth:word; {bits par canal couleur : 1,8,16}
     mode:word;  {valeur Teleauto : bitmap=0,gris=1,rgb=3}
     colormode:integer; {longueur du bloc au format big-endian : toujours à 0 dans TA}
     imgress:integer;
     layer:integer;
     compression:word;
  end;

  TSeuils=array[1..100] of Double;

  MyError           = class(exception);
  ErrorCoordonnees  = class(exception);
  ErrorLX200        = class(exception);
  ErrorCatalog      = class(exception);
  ErrorFileIO       = class(exception);
  ErrorPalette      = class(exception);
  ErrorRecalage     = class(exception);
  ErrorMath         = class(exception);
  ErrorModelisation = class(exception);
  ErrorDate         = class(exception);
  ErrorCompositage  = class(exception);
  ErrorBitmap       = class(exception);
  ErrorSaveFile     = class(exception);
  ErrorReadFile     = class(exception);
  ErrorPortSerie    = class(exception);
  ErrorCamera       = class(exception);
  ErrorMorphing     = class(exception);
  ErrorDome         = class(exception);
  ErrorMatching     = class(exception);  

  TLut=array[-32768..32767] of Byte;

  Trvb=packed record
    Rouge,Vert,Bleu:byte;
    end;

  TPal=array[0..255] of Trvb;

   //New CPA file
  PCpa3 = ^TEnTeteCpa_ver3; {voila}
  TEnteteCPA_Ver3 = packed Record
      Signature      : Longint     ;
      Largeur        : Word        ;
      Longueur       : Word        ;
      BinningX       : Word        ;
      BinningY       : Word        ;
      TabSeuilHaut   : Array[1..3] of Double;
      TabSeuilBas    : Array[1..3] of Double;
      TypeData       : Byte        ;
      NbrePlan       : Byte        ;
      TimeDate       : TdateTime   ;
      TempsDePose    : Double      ;
      MiroirX        : Boolean     ;
      MiroirY        : Boolean     ;
      Telescope      : string[80]  ;
      Observateur    : string[80]  ;
      Camera         : string[80]  ;
      Filtre         : string[80]  ;
      Observatoire   : string[80]  ;
      Focale         : Double      ;
      Alpha          : Double      ;
      Delta          : Double      ;
      PixX           : Double      ;
      PixY           : Double      ;
      DebX,DebY,
      FinX,FinY      : Integer     ;
      TypeCompression: Byte        ;    {  1 }
      NombreBitsComp : Byte        ;    {  1 }
      Commentaires   : Array [1..4] of String[ 80] ;    { 4 *  81 }
   end;

   TPlateVecteur=array[1..NbMaxPlateCoef] of double;

   TAstrometriePar=record
     XC,YC,LargX,LargY  : Integer;
     Alpha_Ref,Delta_Ref:Double;
     RayonX,RayonY:Double;
    end;

   TEnteteCPA_Ver4c = packed Record  // lZW supporte Magouille qui permet d'ajouter des variables...
      Signature      : Longint     ;
      Largeur        : Word        ;
      Longueur       : Word        ;
      BinningX       : Word        ;
      BinningY       : Word        ;
      TabSeuilHaut   : Array[1..3] of Double;
      TabSeuilBas    : Array[1..3] of Double;
      TypeData       : Byte        ;
      NbrePlan       : Byte        ;
      TimeDate       : TdateTime   ;
      TempsDePose    : Double      ;
      MiroirX        : Boolean     ;
      MiroirY        : Boolean     ;
      Telescope      : string[80]  ;
      Observateur    : string[80]  ;
      Camera         : string[80]  ;
      Filtre         : string[80]  ;
      Observatoire   : string[80]  ;
      Focale         : Double      ;
      Alpha          : Double      ;
      Delta          : Double      ;
      PixX           : Double      ;
      PixY           : Double      ;
      DebX,DebY,
      FinX,FinY      : Integer     ;
      TypeCompression: Byte        ;
      NombreBitsComp : Byte        ;

      Wavelength     : Double      ; // Longueur centrale du filtre
      Bandwidth      : Double      ; // Bande passante
      Flux           : Double      ; // Peut etre utilise pour decrire quel serait le flux une etoile de mg 0
      Diametre       : Double      ; // mm²
      Offset         : Double      ; // Offest de l'inage en ADU
      FacteurCVF     : Double      ; // Facteur de convertion en e-/ADU
      Seeing         : Double      ; // en arcsec

      TemperatureCCD: Double ;
      TemperatureExt: Double ;
      Latitude,
      Longitude     : Double ;


     AstrometrieEtalon:Boolean;
     UseAstrometriePar:Boolean;
     AstrometriePar   :TAstrometriePar;
     DimPoly          :Integer ;
     SolAlpha,SolDelta:TPlateVecteur;
     SolX,SolY        :TPlateVecteur;

     TempsLectureCCD: Double ;
     Magnitude_Ref  : Double ;
     ErrFlux_Ref    : Double ;
     TDImode        : Boolean;
     TempLectureLigne: Double ;
     Commentaires   : Array [1..4] of String[ 80] ;

     // Ajouter ici et diminuer la talle de TailleBufferv4c en fonction
     // du nombre de nouvelle variables !
     // Une fois ajoutee ici
     // 1. repercuter la variable dans : TInfos_Image=record
     // 2. qu'elle est mise a jour dans la fiche de DISPLAY des infos entetes  DLGENTET.PAS
     // 3. qu'il existe une initialization dans procedure InitEntete(var Infos_Image:TInfos_Image);

     /////// NEW

     IsPhotometricCal: Boolean;
     AngleCCD        : Double ;
     Flux_Ref        : Double ;
     PhotometrieEtalonnage: Boolean;
     TransformRescaleDynamic:Double;

     Buffer:Array[1..TailleBufferv4c] of Byte; // Diminuer ici

   end;
   PEnteteCPA_ver4c=^TEnteteCPA_ver4c;

  Str7=String[7];

  TLigByte=array[1..999999] of Byte;
  PLigByte=^TLigByte;
  TImgByte=array[1..999999] of PLigByte;
  PImgByte=^TImgByte;
  TTabImgByte=array[1..255] of PImgByte;
  PTabImgByte=^TTabImgByte;

  TLigInt=array[1..999999] of SmallInt;
  PLigInt=^TLigInt;
  TImgInt=array[1..999999] of PLigInt;
  PImgInt=^TImgInt;
  TTabImgInt=array[1..255] of PImgInt;
  PTabImgInt=^TTabImgInt;

  TLigWord=array[1..999999] of Word;
  PLigWord=^TLigWord;
  TImgWord=array[1..999999] of PLigWord;
  PImgWord=^TImgWord;
  TTabImgWord=array[1..255] of PImgWord;
  PTabImgWord=^TTabImgWord;

  TLigLongWord=array[1..999999] of LongWord;
  PLigLongWord=^TLigLongWord;
  TImgLongWord=array[1..999999] of PLigLongWord;
  PImgLongWord=^TImgLongWord;
  TTabPImgLongWord=array[1..255] of PImgLongWord;
  PTabPImgLongWord=^TTabPImgLongWord;

  TLigInteger=array[1..999999] of Integer;
  PLigInteger=^TLigInteger;
  TImgInteger=array[1..999999] of PLigInteger;
  PImgInteger=^TImgInteger;
  TTabImgInteger=array[1..255] of PImgInteger;
  PTabImgInteger=^TTabImgInteger;

  TLigSingle=array[1..999999] of Single;
  PLigSingle=^TLigSingle;
  TImgSingle=array[1..999999] of PLigSingle;
  PImgSingle=^TImgSingle;
  TTabImgSingle=array[1..255] of PImgSingle;
  PTabImgSingle=^TTabImgSingle;

  TLigDouble=array[1..999999] of Double;
  PLigDouble=^TLigDouble;
  TImgDouble=array[1..999999] of PLigDouble;
  PImgDouble=^TImgDouble;
  TTabImgDouble=array[1..255] of PImgDouble;
  PTabImgDouble=^TTabImgDouble;
  TTabTabImgDouble=array[1..255] of PTabImgDouble;
  PTabTabImgDouble=^TTabTabImgDouble;

  TLigDate=array[1..999999] of TDateTime;
  PLigDate=^TLigDate;
  TImgDate=array[1..999999] of PLigDate;
  PImgDate=^TImgDate;
  TTabImgDate=array[1..255] of PImgDate;
  PTabDate=^TTabImgDate;

  TLigFFT=array[0..0] of Double;
  PLigFFT=^TLigFFT;

  TVecteur= array [1..55] of Double;
  TMatrice= array [1..55,1..55] of Double;
  PMatrice= ^TMatrice;
  PVecteur= ^TVecteur;

  { Type de donnee pour l'entete des fichiers .PIC }
  TPICHeader=packed record
    Signature:byte;                  {FC dans cette version}
    Version:byte;                    {31 dans cette version}
    Headersize:word;                 {290 octets de long}
    Nom:array[1..32] of char;        {36}
    Nomsuivant:array[1..32] of char; {68}
    sx:word;
    sy:word;
    Dimdonnees:word;
    Typedonnees:word;
    Reserve:word;
    Camera:word;                      {80}
    X1:word;
    Y1:word;
    X2:word;
    Y2:word;
    BinX:word;                        {90}
    BinY:word;
    NBPlans:word;
    Date:array[1..10] of char;        {104}
    Heure:array[1..14] of char;       {118}
    Max:Smallint;
    Min:Smallint;
    fracMax:word;
    fracmin:word;
    TpsInt:dword;                     {130} // En ms
    Comm1:array[1..80] of char;
    Comm2:array[1..80] of char;       {290}
    end;

  {Bitmaps}
  TBMPHeader=packed record
    Bftype:word;
    Bfsize:longint;
    Bfreserved1:word;
    Bfreserved2:word;
    Bfoffbits:longint;
    Bisize:longint;
    Biwidth:longint;
    Biheight:longint;
    Biplanes:word;
    Bibitcount:word;
    Bicompression:longint;
    Bisizeimage:longint;
    Bixpelspermeter:longint;
    Biypelspermeter:longint;
    Biclrused:longint;
    Biclrimportant:longint;
    end;

  {Palette}
  TPalHeader=packed record
    PaSignature:array[1..3] of char;
    PaVersion:Byte;
    PaType:array[1..10] of char;
    PaNbColor:Longint;
    end;

  // modelisation
  PSource=^TSource;
  TSource=record
    X,Y:Integer;
    Suivant:PSource;
    end;

  TPSF=record
    X,Y,DX,DY,Sigma,SigmaX,SigmaY,Angle,Alpha,Delta,DAlpha,DDelta:Double;
    IntensiteMax,Flux,DFlux,Mag,aMoffat,bMoffat:Double;
    Catalogue:Integer;
    end;

  PListePSF=^TListePSF;
  TListePSF=array[1..9999999] of TPSF;

  // requetes sur les catalogues pour l'astrometrie
  PRequestStar=^TRequestStar;
  TRequestStar=record
    Alpha,Delta,Mag:Double;
    Suivant:PRequestStar;
    Catalogue:Integer;
    end;
  // Deuxieme passe des match
  PMatchStar=^TMatchStar;
  TMatchStar=record
    Alpha,Delta,Mag,Flux,xImg,yImg,DxImg,DyImg,xCat,yCat:Double;
    Suivant:PMatchStar;
    end;
  // matchs gagnants
  PGagnants=^TGagnants;
  TGagnants=record
    x1,y1,x2,y2:Double;
    end;
  PListeGagnants=^TListeGagnants;
  TListeGagnants=array[1..9999999] of TGagnants;

  // Triangles
  PTriangles=^TTriangles;
  TTriangles=record
    Etoile1,Etoile2,Etoile3:Integer;
    BSurA,CSurA:Double;
    OrdreFlux:Integer;
    end;
  PListeTriangles=^TListeTriangles;
  TListeTriangles=array[1..9999999] of TTriangles;

  DoubleArray=array [1..MaxArray,1..MaxArray] of Double;
  DoubleArrayRow=array [1..MaxArray] of Double;
  IntegerArrayRow=array [1..MaxArray] of Integer;


{VAISALA}
type TElements = record
        arg_peri:double;
        eccentricity:double;
        semi_axis:double;
        inclination:double;
        lon_asc_node:double;
        mean_anom:double;
        mean_daily:double;
end;



{PGC - avec ra/dec en heures dec}
type p_pgcrecd = ^ pgcrecd;
     pgcrecd = record
     pgc:longint;
     ar,de:double;
     hrv   : Longint;
     nom   : string[16];//array [1..16] of char;
     typ   : string[4];//array [1..4] of char;
     pa    : byte;
     maj,min,mb : smallint;
     end;
{
- pgc   : numéro du catalogue PGC
- ar    : ascension droite 2000 en degrés * 100'000
- de    : declinaison 2000 * 100'000
- hrv   : vitesse radiale héliocentrique
- nom   : autres noms
- typ   : type morphologique
- pa    : angle de position du grand axe
- maj   : grand axe à l'isophote 25/'2 * 100
- min   : petit axe à l'isophote 25/'2 * 100
- mb    : magnitude B * 100
}

{RC3 - avec ra/dec en heures dec}
type
p_rc3recd = ^RC3Recd;
RC3recd = record
       ar,de:double;
       vgsr :longint ;
       pgc   : shortstring;//array[1..8] of char;
       nom   : shortstring;//array [1..14] of char;
       typ   : shortstring;//array [1..7] of char;
       pa    : byte;
       stage,lumcl,d25,r25,Ae,mb,b_vt,b_ve,m25,me : smallint;
       end;
{
- ar    : ascension droite 2000 en degrés * 100'000
- de    : declinaison 2000 * 100'000
- vgsr  : vitesse radiale moyenne
- pgc   : numéro du catalogue PGC
- nom   : autres noms
- typ   : type morphologique
- pa    : angle de position du grand axe
- stage : Hubble stage * 10
- lumcl : classe de luminosité * 10
- d25   : log du grand axes à l'isophote 25/'2 * 100
- r25   : log du rapport grand axe / petit axe  * 100
- Ae    : log de l'ouverture effective * 100
- mb    : magnitude B ou photographique totale * 100
- b_vt  : indice de couleur b-v total * 100
- b_ve  : indice de couleur b-v dans l'ouverture effective * 100
- m25   : magnitude / minute carrée moyenne * 100
- me    : magnitude / minute carrée dans l'ouverture effective * 100
}

{NGC - version RA-DEC EN HEURES}
type
p_ngcrecd = ^NGCRecd;
NGCrecD = record
       ar,de : DOUBLE ;
       id    : word;
       ic    : char;
       typ   : SHORTSTRING;//array [1..3] of char;
       l_dim : char;
       n_ma  : char;
       ma,dim:smallint;
       cons  : shortstring;//array [1..3] of char;
       desc  : shortstring;//array[1..50] of char;
       end;
{
- ar    : ascension droite 2000 en degrés * 100'000
- de    : declinaison 2000 * 100'000
- id    : numéro NGC ou IC
- ic    : I pour IC , blanc pour NGC
- typ   : type d'objet
- l_dim : limite de la taille
- n_mag : p si magnitude photographique
- ma    : magnitude * 100
- dim   : plus grande dimension en minutes * 10
- cons  : constellation
- desc  : description
}



{ephemerides}
type double6 = array[0..5] of double;
     Pdouble6 = ^double6;


type double8 = array[1..8] of double;
     Pdouble8 = ^double8;


type
    PPlanetData = ^TPlanetData;
    TPlanetData = record
       JD : double;
       l : double ;
       b : double ;
       r : double ;
       x : double ;
       y : double ;
       z : double ;
       ipla : integer;
end;


{detection/analyse/matching}
type p_detection=^TDetection;  {copie des detections dans l image}
     TDetection=record
        id:smallint;
        x:double;
        y:double;
        dx:double;
        dy:double;
        flux:double;
        dflux:double;
        sigma:double;
        array_index:integer;
        new_x:double; // pour stocker la translation des detections
        new_y:double;
        flag:integer;
end;

type p_reference=^Treference; {etoile catalogue}
     TReference = record
        source:shortstring;
        ref:string;
        id:smallint;
        alpha:double;    {valeur en deg dec}
        alpha_p:double;  {valeur projection}
        delta:double;
        delta_p:double;
        pmra:double;
        pmde:double;
        mag:double;
end;

{matrice de vote}
type Tmatrix=array [1..max_vote_array,1..max_vote_array] of integer; {matrice de votes}
        P_matrix=^Tmatrix;

type p_matcher = ^ Tmatcher;  {resultat des votes}
     TMatcher = record
        vote_count:integer;
        ref_index:integer;
        ref_x:double;
        ref_dx:double;
        ref_y:double;
        ref_dy:double;
        pmra:double;
        pmde:double;
        det_index:integer;
        det_x:double;
        det_dx:double;
        det_y:double;
        det_dy:double;
end;


type p_triangle = ^TTriangle;  {triangle}
     TTriangle = record
        xt:double;         {cote b / cote a}
        yt:double;         {cote c / cote a}
        a:double;          {longueur du cote AB}
        b:double;          {longueur du cote BC}
        c:double;          {longueur du cote AC}
        name_a:smallint;   {index du sommet A}
        name_b:smallint;   {index du sommet B}
        name_c:smallint;   {index du sommet C}
        OrdreFlux:Integer; {ordre des flux}
end;


type p_triangle_sides=^TTriangle_sides;
     TTriangle_sides = array [0..max_vote_array] of double;

{SVD - numerical recipes}
type
    RealArrayNP     = array [1..np] of double;
    RealArrayMP     = array [1..mp] of double;
    RealArrayMPbyNP = array [1..mp,1..np] of double;
    RealArrayNPbyNP = array [1..np,1..np] of double;

// Informations d'une image
type PHeader = ^TImgInfos;         // pointeur sur les renseignements d une image
     TImgInfos = record
      Sx,Sy          : Integer     ;
      NbPlans        : Byte        ;
      TypeData       : Byte        ;
      TypeComplexe   : Byte        ;
      NbAxes         : Byte        ;
      BitPix         : Integer     ;  
      FileName       : string      ;
      project        : string      ;
      catalogs       : string      ;
      DateTime       : TDateTime   ; // Instant de milieu de l'acquisition
      Min,Max        : TSeuils     ; // Tableau de seuils
      TempsPose      : Integer     ; // Temps de pose en millisecondes
      BinningX       : Word        ; // Binning X lors de l'acqusition
      BinningY       : Word        ; // Binning Y lors de l'acqusition
      MiroirX        : Boolean     ; // Miroir X lors de l'acqusition
      MiroirY        : Boolean     ; // Miroir Y lors de l'acqusition
      Telescope      : string[80]  ; // Type de telescope
      Observateur    : string[80]  ; // Nom de l'observateur
      Camera         : string[80]  ; // Type de camera
      Filtre         : string[80]  ; // Nom du filtre utilise
      Observatoire   : string[80]  ; // Nom de l'observatoire
      Lat            : Double      ; // Latitude de l'observatoire
      Long           : Double      ; // Longitude de l'observatoire      
      Focale         : Double      ; // Focale du telescope en m
      Alpha          : Double      ; // Ascension droite du centre de l'image en heures
      Delta          : Double      ; // Declinaison du centre de l'image en degres
      PixX           : Double      ; // Taille X des pixels du CCD en um
      PixY           : Double      ; // Taille Y des pixels du CCD en um
      X1             : Integer     ; // Coordonnée du fenêtrage
      Y1             : Integer     ;
      X2             : Integer     ;
      Y2             : Integer     ;
      Commentaires   : Array [1..4] of String[ 80] ;    { 4 *  81 }  // 4 lignes de commentaires (=cpa)

      Diametre       : Double      ; // Diamètre de l'instrument
      TemperatureCCD : Double      ; // Temperature du CCD lors de l'acqusition en degres
      OrientationCCD : Double      ; // Orientation du CCD lors de l'acquisition en degres par rapport a quoi ? (Prism)
      Seeing         : Double      ; // Seeing lors de l'acqusition en secondes d'arc
      RMSGuideError  : Double      ; // Erreur de guidage RMS uniquement pour le format FITS

      BZero,BScale   : Double      ; // Mise a l'echelle FITS

      bsc            : integer     ; // count of entries found for catalogs
      usno           : integer     ;
      pgc            : integer     ;
      rc3            : integer     ;
      ngc            : integer     ;
      gsc            : integer     ;
      mct            : integer     ;
      ty2            : integer     ;
      tyc            : integer     ;
      RawCfa         : Boolean     ;
end;


type p_blockindex = ^TBlock_Index;
     TBlock_index = array [1..1296] of byte;


type p_window_constraint = ^TTWindow_constraint;
     TTWindow_constraint = array[0..360,0..90] of boolean;

TYPE TCityPtr = ^TCity;
     TPointPtr = ^TPoint;
      TCity = RECORD
      pos       : TPointPtr;
      next      : TCityPtr ;
      distArrIdx: Integer  ;
END;

{MoonSun}
type
t_coord = record
  longitude, latitude, radius: extended;
  alpha, delta: extended;
  parallax: extended;
  end;

T_RiseSet=(krise,kset,ktransit);

type
  TMoonPhase=(Newmoon,FirstQuarter,Fullmoon,LastQuarter);
  TSeason=(Winter,Spring,Summer,Autumn);
  TEclipse=(none, partial, noncentral, circular, circulartotal, total, halfshadow);
  E_NoRiseSet=class(Exception);
  E_OutOfAlgorithRange=class(Exception);

{FITS}
type pFITSHeader = ^TFITSHeader;
     TFITSHeader = record
       simple   : string;
       naxis    : string;
       naxis1   : string;
       naxis2   : string;
       naxis3   : string;
       telescop : string;
       bitpix   : string;
       DATAMAX  : string;
       DATAMIN  : string;
       CDELTM1  : string;
       CDELTM2  : string;
       CRVAL1   : string;
       CRVAL2   : string;
       FOCLEN   : string;
       DATE_OBS : string;
       EXPOSURE : string;
       JDAY     : string;
       INSTRUME : string;
       OBSERVER : string;
       SITELAT  : string;
       SITELONG : string;
       BINX     : string;
       BINY     : string;
       FILTERS  : string;
       MIRRORX  : string;
       MIRRORY  : string;
       WINDOW   : string;
       TEMP     : string;
       PLATE    : string;
       COMMENT  : string;
       X1       : string;
       Y1       : string;
       X2       : string;
       Y2       : string;
end;


FITSheader = array [1..72,1..80] of char;  // utilise par les fonctions d ecriture image FITS (doit etre un multiple de 2880) 

FITSrec16 = array [1..1440] of smallint ;  // ...

FITSrec8 = array [1..2880] of byte ;       // ...

type                                          // utilise par les fonctions de lecture FITS
  TPimai8 = ^Timai8;
  Timai8 = array of array of byte;

  TPimai16 = ^Timai16;                        // ...
  Timai16 = array of array of smallint;

  TPimai32 = ^Timai32;
  Timai32 = array of array of longint;        // ...

  TPimar32 = ^Timar32;
  Timar32 = array of array of single;         // ...

  TPimar64 = ^Timar64;
  Timar64 = array of array of double;         // ...


type                                   // pointeur sur un element de string list
    p_string_item=^tstring_item;
    tstring_item=record
        str:string;
end;

type                                   // pointeur sur un element de string list
    p_trash_item=^ttrash_item;
    ttrash_item=record
        str:string;
end;


{cache}
type P_cache =^Tcache;
     Tcache = record
       catalog:string;
       mag_hi,mag_lo:double;
       object_type:string;
       ra,dec:double;
       radius:double;
       list_id:integer;
       alpha,delta:double;
end;

{dss}
type p_dss_task = ^TDSS_task;
     TDSS_task=record
        filename:string;
        objet:string;
        ra:string;
        dec:string;
        fov_x:string;
        fov_y:string;
        dss_type:string;
        compression:string;
        done:boolean;
end;

{zlib.dll}
type
  Tgzopen =Function(path,mode :pchar): integer ; Stdcall;
  Tgzread =Function(gzFile: integer; buf : pchar; len:cardinal): integer; Stdcall;
  Tgzeof =Function(gzFile: integer): integer; Stdcall;
  Tgzclose =Function(gzFile: integer): integer; Stdcall;
var gzopen : Tgzopen;
     gzread : Tgzread;
     gzeof : Tgzeof;
     gzclose : Tgzclose;
     myzlib : integer;


{MPC}
type p_SN = ^TSuperNova;
     TSuperNova = record
        nom:string;
        Hote:string;
        alpha:string;
        Delta:string;
        Lon:string;
        lat:string;
        typ:string;
        mag:string;
end;

type  p_critlist = ^ Tcritlist;
      Tcritlist = record
        numero:string;
        nom:string;
        date:string;
        e:string;
        a:string;
        incl:string;
        node:string;
        peri:string;
        M:string;
        H:string;
        G:string;
        creation:tdatetime;
        motion:string;
end;


type  p_comet = ^ Tcomet;
      Tcomet = record
      nom:string;
      date:string;
      e:string;
      a:string;
      incl:string;
      node:string;
      peri:string;
      M:string;
      H:string;
      MPC:string;
end;


Type Tast_elem = record                      // elements provenant d'astorb.dat
       name          : string[23]; // parametre 1 et 2
       epoch_coord   : integer;    // 2000 pour astorb
       epoch_elem    : string[8];  // parametre 12
       mean_anomaly  : double;     // parametre 13
       arg_perihelion: double;     // parametre 14
       long_asc_node : double;     // parametre 15
       inclination   : double;     // parametre 16
       eccentricity  : double;     // parametre 17
       semimajor_axis: double;     // parametre 18
       absolute_mag_H: double;     // parametre 4
       slope_param_G : double;     // parametre 5
end;

type Tast_coord = record
       jd     : double;      // date julienne
       ar     : double;      // ascension droite
       de     : double;      // declinaison
       dist   : double;      // distance geocentrique
       r      : double;      // distance heliocentrique
       elong  : double;      // elongation au Soleil
       phase  : double;      // angle de phase
       magn   : double;      // magnitude
end;

{-------------------------------------------------------------------------------

                                    CONFIG

--------------------------------------------------------------------------------}

type
TConfigInternet = record
   port:integer;
   proxy:string;
   proxyport:integer;

   ftp1_host:string;
   ftp1_uid:string;
   ftp1_pwd:string;

   ftp2_host:string;
   ftp2_uid:string;
   ftp2_pwd:string;

   mpc_critlist:string;
   mpc_comets:string;
   mpc_distant:string;
   mpc_unusual:string;
   mpc_bright1:string;
   mpc_bright2:string;
end;


type
TConfigPretraitements = record
   UsePreviousFiles:Boolean;
   CreeOffset:Boolean;
   EnleveOffsetAuxNoirs:Boolean;
   CreeNoir:Boolean;
   EnleveOffsetAuxNoirsFlats:Boolean;
   CreeNoirFlats:Boolean;
   EnleveOffsetAuxFlats:Boolean;
   EnleveNoirsFlatsAuxFlats:Boolean;
   MoyenneIdentiqueDesFlats:Boolean;
   CreeFlat:Boolean;
   EnleveOffsetAuxImages:Boolean;
   EnleveNoirAuxImages:Boolean;
   CorrigeImagesDuFlat:Boolean;
   RecaleImages:Boolean;
   ErreurRecaleImages:Double;
   CompositeImages:Boolean;
   SupprimmerImages:Boolean;
   CorrigeCosmetique:Boolean;
   AppliqueMedian:Boolean;
   OptimiseNoir:Boolean;       
   TypeCreationOffset:Byte;
   TypeCreationNoir:Byte;
   TypeCreationFlat:Byte;
   TypeCreationNoirFlat:Byte;
   TypeRecalageImages:Byte;
   TypeCompositageImages:Byte;
   NbSigmaOffset,NbSigmaNoir,NbSigmaNoirFlat,NbSigmaFlat,NbSigmaImage:Double;
   NomOffset,NomNoir,NomNoirFlat,NomFlat,NomCosmetiques:string;
   TypeCCDSoft:Boolean;
   end;

{CONFIG}
type  p_config = ^TConfig;
      Tconfig = class
        // MySql
        mysql_bin:string;                    // chemin vers le moteur mysql
        mysql_engine:string;                 // type moteur mysql
        mysql_installed:boolean;             // mysql installe ?
        MySqlHost:string;
        MySqlPort:Cardinal;
        MySqlUserName:string;
        MySqlUserPassWord:string;
        MySqlAskPassword:Boolean;

        JpegQuality:Byte;                    // Qualite de la compression Jpeg 1..100
        FormatSaveInt:Byte;                  // Format de sauvergarde des images entieres
                                             // 0 = Fits
                                             // 1 = Cpa
                                             // 2 = Pic
                                             // 3 = Bmp
                                             // 4 = Jpeg
                                             // 5 = Cpa V4
                                             // 6 = AVI pour webcam, BMP autrement.
        FormatCouleur:Byte;                  // 0 = separation dans trois fichier
                                             // 1 = toutes les couleurs dans le même fichier
        // repertoires
        RepImages:string;                    // Repertoire par defaut pour l'ouverture et la sauvegarde des images
        RepOffsets:string;                   // Repertoire contenant les offsets
        RepNoirs:string;                     // Repertoire contenant les noirs
        RepPlus:string;                      // Repertoire contenant les flats
        RepImagesAcq:string;                 // Repertoire ou on met les images acquises
        // Repertoires catalogues
        RepGSC:string;                       // Repertoire contenant le GSC
        RepUSNO:string;                      // Repertoire contenant l'USNO
        RepTycho2:string;                    // Repertoire contenant Tycho 2
        RepMicrocat:string;                  // Repertoire contenant Microcat
        RepCatalogsBase:string;              // Repertoire contenant les catalogues de base
        TypeGSC : Byte;                      // Version du catalogue GSC :
                                             // 0 = standard FITS
                                             // 1 = compact CDS
        // Repertoires scripts
        RepScript:string;                    // Repertoire contenant les scripts

        // Pointage
        VecteurNordXPointe:double;           // A supprimer
        VecteurNordYPointe:double;           // A supprimer
        VecteurSudXPointe:double;            // A supprimer
        VecteurSudYPointe:Double;            // A supprimer
        VecteurEstXPointe:double;            // A supprimer
        VecteurEstYPointe:double;            // A supprimer
        VecteurOuestXPointe:double;          // A supprimer
        VecteurOuestYPointe:Double;          // A supprimer
        CalibratePointage:Boolean;           // A supprimer
        DelaiCalibrationPointage:Double;     // A supprimer

        // Telescope
        FocaleTele:Double;                   // Focale du telescope en mm // FocaleTele est en mm depuis la V2.66b
        Vitesse:Single;                      // Vitesse du telescope en °/s
        DeltaMax:Single;                     // Declinaison maximum
        TelescopeComPort:string;             // Port serie utilise ex : 'COM1'
        Profil:string;                       // Nom du fichier profil
        Lat:Double;                          // Latitude du telescope en °
        Long:Double;                         // Longitude du telescope en °
        HauteurMini:single;                  // Hauteur minimum
        Attente:Single;                      // Delai d'attente entre pointage et photo
        ModelePointageCalibre:Boolean;
        UseModelePointage:Boolean;
        Periodic:Boolean;                    // Lecture périodique des coordonnées ?
        UseProfil:Boolean;                   // On utilise le profil ?                   

        // Recentrage CCD Principal
        CalibrateRecentrage:Boolean;
        DeltaRecentrage:Double;
        VecteurSudXRecentrage:Double;
        VecteurSudYRecentrage:Double;
        VecteurNordXRecentrage:Double;
        VecteurNordYRecentrage:Double;
        VecteurEstXRecentrage:Double;
        VecteurEstYRecentrage:Double;
        VecteurOuestXRecentrage:Double;
        VecteurOuestYRecentrage:Double;
        DelaiCalibrationRecentrage:Double;
        LimiteNordRecentrage:Double;
        LimiteSudRecentrage:Double;
        LimiteEstRecentrage:Double;
        LimiteOuestRecentrage:Double;
        IterRecentrage:Integer;

        // Recentrage CCD Guidage
        CalibrateRecentrageSuivi:Boolean;
        DeltaRecentrageSuivi:Double;
        VecteurSudXRecentrageSuivi:Double;
        VecteurSudYRecentrageSuivi:Double;
        VecteurNordXRecentrageSuivi:Double;
        VecteurNordYRecentrageSuivi:Double;
        VecteurEstXRecentrageSuivi:Double;
        VecteurEstYRecentrageSuivi:Double;
        VecteurOuestXRecentrageSuivi:Double;
        VecteurOuestYRecentrageSuivi:Double;
        LimiteNordRecentrageSuivi:Double;
        LimiteSudRecentrageSuivi:Double;
        LimiteEstRecentrageSuivi:Double;
        LimiteOuestRecentrageSuivi:Double;
        IterRecentrageSuivi:Integer;

        PCMoinsTU:Integer;                   // Decalage heure PC heur TU
        TypeCamera:Integer;                  // Type de camera
        TypeCameraSuivi:Integer;             // Type de camera de guidage
        TypeHourServer:Integer;              // Type de serveur d'heure
        CCDAlphaTrack:integer;               // Nombre de pixel du CCD de guidage en Alpha
        CCDDeltaTrack:Integer;               // Nombre de pixel du CCD de guidage en Delta

        CutAmpli:boolean;                    // coupure de l ampli pendant la pose
        CutAmpliSuivi:boolean;               // coupure de l ampli du CCD de guidage pendant la pose
        MirrorX:boolean;                     // Mirroir X a l'acquisition
        MirrorY:Boolean;                     // Mirroir Y a l'acquisition
        MirrorXSuivi:boolean;                // Mirroir X a l'acquisition guidage
        MirrorYSuivi:Boolean;                // Mirroir Y a l'acquisition guidage
        MinPose:Double;                      // Temps de pose minimum a la reactualisation sur une etoile
//        MaxPose:Single;                      // Temps de pose maximum a la reactualisation sur une etoile
        NbBouclage:Integer;                  // Nombre d'images pour le bouclage
        Pose2:double;                        // Temps de pose en binning 2x2
        Pose1:double;                        // Temps de pose en binning 1x1
        Pose4:Double;                        // Temps de pose en binning 4x4
        Temperature:Single;                  // Temperature CCD de consigne

        // Mise au point
        UseMoyenne:Boolean;                  // Utilisation de la moyenne au lieu du minimum pour la mesure
        TypeMesureFWHM:Byte;                 // Methode de mesure de la FWHM
        CorrectionAutoFast:Boolean;          // Utiliser la correction en map auto rapide
        CorrectionAutoSlow:Boolean;          // Utiliser la correction en map auto lente
        ImpulsionArriereRapide:Double;       // Correction des défauts
        ImpulsionArriereLente:Double;        // Correction des défauts
        StabilisationRapide:Double;          // Correction des défauts
        StabilisationLente:Double;           // Correction des défauts
        ImpulsionAvantRapide:Double;         // Correction des défauts
        ImpulsionAvantLente:Double;          // Correction des défauts
        SurvitesseRapide:Double;             // Survitesse arrière rapide
        SurvitesseLente:Double;              // Survitesse arrière lente
        FocInversion:Boolean;                // Inversion des sens de manoeuvre de la focalisation
        DelaiFocFastInit:Double;             // Délai initial de manoeuvre rapide du moteur de map
        DelaiFocSlowInit:Double;             // Délai initial de manoeuvre lente du moteur de map
        FwhmStopFast:Double;                 // FWHM d'arret de la manoeuvre rapide du moteur de map
        FwhmStopSlow:Double;                 // FWHM d'arret de la manoeuvre lente du moteur de map
        DelaiFocFastMin:Double;              // Delai minimum de la manoeuvre rapide du moteur de map
        DelaiFocSlowMin:Double;              // Delai minimum de la manoeuvre lente du moteur de map
        NbEssaiCentroMaxi:Integer;           // Nombre maximum de modelisation lors de la map
        NbEssaiFocFast:Integer;              // Nombre de modelisation lors de la map vitesse rapide
        NbEssaiFocSlow:Integer;              // Nombre de modelisation lors de la map vitesse lente
        LargFoc:Integer;                     // Largeur de la fenetre de focalisation
        // Optimisation
        DelaiFocOptim:Double;                // Délai de manoeuvre du moteur de map
        Tolerance:Double;                    // Tolerance de fin
        FacteurInflation:Double;
        CorrectionOptim:Boolean;             // Utiliser la commande corrigée pour l'optimisation

        // AutoFocus V
        DiametreExtreme:Double;
        DiametreProche:Double;
        MargeSecurite:Double;
        DureeExtraction:Double;
        UseVitesseRapide:Boolean;
        VitesseRapide:Double;
        UseCmdCorrRapideAutoV:Boolean;
        UseCmdCorrLenteAutoV:Boolean;
        VitesseLente:Double;
        DureeImpulsionIncrementale:Double;
        DureeMaxManoeuvre:Double;
        MaxPosFocuser:Integer;               // Position maxi du robofocus
        FocuserPlugin:string;  

        NameFilter:array[1..5] of String;    // Nom des filtres CFW8
        DecalAlpha:double;                   // Decalage en Alpha pour l'utilisation client/serveur
        DecalDelta:Double;                   // Decalage en Delta pour l'utilisation client/serveur
        Telescope:string;                    // Nom du telescope
        Observatoire:string;                 // Nom de l'observatoire
        Observateur:string;                  // Nom de l'observateur
        Filtre:String;                       // A supprimer
        ObtuCloseDelay:Double;               // Delai de declenchement de l obtu des cameras
        ObtuCloseDelaySuivi:Double;          // Delai de declenchement de l obtu des cameras de guidage

        // Guidage
        ErreurGoodTrack:Double;              // Erreur maxi avant de commencer une nouvelle pose
        ErreurAngleGuidage:Double;           // Erreur de perpendicularité des vecteurs de guidage à la calibration
        ErreurPositionGuidage:Double;        // Erreur de position de l'étoile aprés un aller/retour N/S ou E/O à la calibration
        XMesure,YMesure,XSuivi,YSuivi:Double;
        xCentreSuivi,yCentreSuivi:Integer;
        XDeplaceSuivi,yDeplaceSuivi:Double;
        DecalageSuiviX,DecalageSuiviY:PLigDouble;
        NbDecalageSuivi:Integer;
        NoirTrackPris:Boolean;               // Le noir du CCD de guidage a t'il ete pris ?
        NoirTrackVignettePris:Boolean;       // Le noir de la vignette du CCD des guidage a t'il ete pris ?
        LargFenSuivi:Integer;                // Largeur de la fenetre de modelisation de l'etoile de guidage
        SuiviEnCours:Boolean;                // Y a t'il un guidage en cours ?
        CalibrationEnCours:Boolean;          // Y a t'il une calibration en cours ?        
        TempsDePoseTrack:Double;             // Temps de pose du guidage
        OldDeplacementNord:double;           // Ancien deplacement du guidage vers le Nord
        OldDeplacementSud:double;            // Ancien deplacement du guidage vers le Sud
        OldDeplacementEst:double;            // Ancien deplacement du guidage vers l'Est
        OldDeplacementOuest:Double;          // Ancien deplacement du guidage vers l'Ouest
        CoefLimitationNS:Double;             // Coefficient de limitation des deplacement Nord/Sud du guidage
        CoefLimitationEO:Double;             // Coefficient de limitation des deplacement Est/Ouest du guidage
        Limite:Boolean;                      // Mise en service la correction auto de limitation du guidage
        LimiteNord:double;                   // Coefficient de limitation des deplacement du guidage vers le Nord
        LimiteSud:double;                    // Coefficient de limitation des deplacement du guidage vers le Sud
        LimiteEst:double;                    // Coefficient de limitation des deplacement du guidage vers l'Est
        LimiteOuest:Double;                  // Coefficient de limitation des deplacement du guidage vers l'Ouest
        NbMesure:Integer;                    // Comptage du nombre de mesure pour corriger la limitation seulement apres la premiere mesure
        CalibrateSuivi:Boolean;              // Le guidage est il deja calibré ?
        DelaiRattrapageSuiviNS:Double;       // Delai de rattrapage du jeu Nord/Sud du guidage en secondes
        DelaiCalibrationSuiviNS:Double;      // Delai de calibration Nord/Sud du guidage en secondes
        DelaiCalibrationSuiviEO:Double;      // Delai de calibration Est/Ouest du guidage en secondes
        DeltaSuivi:Double;                   // Declinaison du scope pendant la calibration
        AHSuivi:Double;                      // Angle Horaire du scope pendant la calibration        
//        DeltaSuiviAuto:Boolean;              // Mise a jour auto de la declinaison lors du guidage
        UseTrackSt7:Boolean;                 // Utilise t'on la liaision ST7-LX200
        UseDecalages:Boolean;                // Utilise t'on le decalage des prises de vue ?
        VecteurNordX:double;                 // Coordonnee X du vecteur de deplacement vers le Nord
        VecteurNordY:double;                 // Coordonnee Y du vecteur de deplacement vers le Nord
        VecteurSudX:double;                  // Coordonnee X du vecteur de deplacement vers le Sud
        VecteurSudY:double;                  // Coordonnee Y du vecteur de deplacement vers le Sud
        VecteurEstX:double;                  // Coordonnee X du vecteur de deplacement vers l'Est
        VecteurEstY:double;                  // Coordonnee Y du verteur de deplacement vers l'Est
        VecteurOuestX:double;                // Coordonnee X du verteur de deplacement vers l'Ouest
        VecteurOuestY:Double;                // Coordonnee Y du verteur de deplacement vers l'Ouest
        VitesseGuidageReelleDelta:Double;
        KeepImage:Boolean;                   // Pour garder les images pendant la calibration du guidage

        InversionNS:boolean;                 // Inversion des deplacements Nord/Sud du telescope
        InversionEO:Boolean;                 // Inversion des deplacements Est/Oeust du telescope
        Initialisation:Boolean;              // Savoir si on est en phase d'initialisation du programme (Ne pas pas toucher sinon TeleAuto plante salement)
        UsePort1:boolean;                    // Tracer l'utilisation du port com1 pour eviter les conflits
        UsePort2:boolean;                    // Tracer l'utilisation du port com2 pour eviter les conflits
        UsePort3:boolean;                    // Tracer l'utilisation du port com3 pour eviter les conflits
        UsePort4:Boolean;                    // Tracer l'utilisation du port com4 pour eviter les conflits
        UsePort5:boolean;                    // Tracer l'utilisation du port com5 pour eviter les conflits
        UsePort6:boolean;                    // Tracer l'utilisation du port com6 pour eviter les conflits
        UsePort7:boolean;                    // Tracer l'utilisation du port com7 pour eviter les conflits
        UsePort8:Boolean;                    // Tracer l'utilisation du port com8 pour eviter les conflits
        park_physique:boolean;               // Bouger le telescope a un endroit precis avant de faire "park"
        park_meridien:string;                // Meridien + / - pour le park physique
        park_decli:string;                   // Declinaison pour le park physique
        TypeTelescope:byte;                  // 0:LX200; 1:Coordinate III
        InTimerTrack:Boolean;                // Savoir si l'appel au timer de guidage est en cours pour ne pas declencher deux fois le timer
        ReadingDelai:integer;                // Delai de ralentissement de la lecture des cameras Hisis
        ReadingDelaiSuivi:integer;           // Delai de ralentissement de la lecture Hisis en guidage
        mag_hi:double;                       // mag superieure pour les recherches dans les catalogues
        mag_lo:double;                       // mag infereieure pour les recherches dans les catalogues
        size_hi:double;                      // taille maximum des gals (arcmin) pour les recherches catalogues
        size_lo:double;                      // taille minimum des gals (arcmin) pour les recherches catalogues
        type_objet:byte;                     // type d objet - recherche catalogues
        distance_objet:integer;              // vitesse radiale maximum
        azimut_active:boolean;               // contraintes optimiseur de script - limite active en azimut
        azimut_max, azimut_min : double;     // limites min max en azimut pour les deplacements telescope
        hauteur_active:boolean;              // limite active en hauteur
        hauteur_min, hauteur_max: double;    // hauteur de pointage min max pour les deplacements du telescope
        moon_active:boolean;                 // limite Lune active
        moon_min_distance:double;            // distance minimale en degres
        moon_brightness:double;              // phase maximum
        obsauto:boolean;                     // obsauto est il en cours d execution
        tcpip:boolean;                       // TCP/IP installe ou pas
        TelescopeBranche:Boolean;            // Securiser l'utilisation du télescope / Pour ne pas interroger le telescope s'il n'y en a en pas (bug bodart)
        FocuserBranche:Boolean;              // Securiser l'utilisation du focuseur
        CameraBranchee:Boolean;              // Securiser l'utilisation de la caméra
        CameraSuiviBranchee:Boolean;         // Securiser l'utilisation de la caméra de guidage
        DomeBranche:Boolean;                 // Securiser l'utilisation du dome
        HourServerBranche:Boolean;
        Diametre:Double;                     // Diamètre de l'instrument
        OrientationCCD:Double;               // Angle de la direction du nord par rapport au demi axe de y>0 dans le sens trigo
        OrientationCCDGuidage:Double;        // Angle de la direction du nord par rapport au demi axe de y>0 dans le sens trigo        
        Seeing:Double;                       // Seeing habituel du site en arcsec
        Language:string;                     // Language utilisé par TeleAato
        ConfigPretrait:TConfigPretraitements;// Tout ce qui concerne les prétraitements

        // Seuillage
        TypeSeuil:Integer;                   // Choix du type de réglage auto
        MultBas:Double;                      // Reglage auto du seuil bas par stat
        MultHaut:Double;                     // Reglage auto du seuil haut par stat
        SeuilBasPourCent:Double;             // Seuil bas en % de l'histogramme cumulé
        SeuilHautPourCent:Double;            // Seuil haut en % de l'histogramme cumulé
        SeuilCamera:Byte;                    // Seuil par défaut a la prise de vue (etoile, planete, maxi, fixe)
        SeuilBasFixe:Double;                 // Seuil bas fixe pour seuilcamera=3
        SeuilHautFixe:Double;                // Seuil haut fixe pour seuilcamera=3

        profile_ok:boolean;                  // Le profil est il correctement charge
        keep_in_profile:boolean;             // autoriser les pointages sous le profil
        CatNGCPresent:Boolean;               // Le catalogue BSC est il present ?
        CatBSCPresent:Boolean;               // Le catalogue BSC est il present ?
        CatPGCPresent:Boolean;               // Le catalogue PGC est il present ?
        CatRC3Present:Boolean;               // Le catalogue RC3 est il present ?
        CatWDSPresent:Boolean;               // Le catalogue WDS est il present ?
        CatGCVPresent:Boolean;               // Le catalogue GCV est il present ?
        CatMCTPresent:Boolean;               // Le catalogue MCT est il present ?
        CatUSNOPresent:Boolean;              // Le catalogue USNO est il present ?
        CatGSCCPresent:Boolean;              // Le catalogue GSCC est il present ?
        CatTY2Present:Boolean;               // Le catalogue TYCHO2 est il present ?
        ReadIntervalTimeout:Integer;         // Timeouts port série téléscope
        ReadTotalTimeoutMultiplier:Integer;  // Timeouts port série téléscope
        ReadTotalTimeoutConstant:Integer;    // Timeouts port série téléscope
        WriteTotalTimeoutMultiplier:Integer; // Timeouts port série téléscope
        WriteTotalTimeoutConstant:Integer;   // Timeouts port série téléscope
        MapReadIntervalTimeout:Integer;         // Timeouts port série map
        MapReadTotalTimeoutMultiplier:Integer;  // Timeouts port série map
        MapReadTotalTimeoutConstant:Integer;    // Timeouts port série map
        MapWriteTotalTimeoutMultiplier:Integer; // Timeouts port série map
        MapWriteTotalTimeoutConstant:Integer;   // Timeouts port série map
        HourServerReadIntervalTimeout:Integer;         // Timeouts port série téléscope
        HourServerReadTotalTimeoutMultiplier:Integer;  // Timeouts port série téléscope
        HourServerReadTotalTimeoutConstant:Integer;    // Timeouts port série téléscope
        HourServerWriteTotalTimeoutMultiplier:Integer; // Timeouts port série téléscope
        HourServerWriteTotalTimeoutConstant:Integer;   // Timeouts port série téléscope
        ErreurPointingAlpha:Double;          // Erreur sur les coordonnees alpha 1/600 6 pour le LX en secondes
        ErreurPointingDelta:Double;          // Erreur sur les coordonnees delta 1/60 60 pour le LX en secondes d'arc
        internet:TConfigInternet;            // configuration internet
        TypeFocuser:Integer;                 // Type de focuseur
        MapComPort:string;                   // Nom du port com de la map
        TypeSaveFits:Byte;                    // Type pour la sauvegarde des fits 
        TypeOS:Byte;                         // OS detecte 0:W95 1:NT 3:Linux?
        NomOS:string;                        // Nom de l'OS
        DelaiVidage:Double;                  // Delai de vidage surtout pour la Hisis
        DelaiVidageSuivi:Double;             // Delai de vidage surtout pour la Hisis

        // Photométrie
        FormeModelePhotometrie:Byte;         // Forme de la modelisation pour la photometrie
        DegreCielPhotometrie:Byte;           // Degre du polynome de modelisation du ciel pour la photometrie
        LargModelisePhotometrie:Integer;     // Largeur de la fenetre de modelisation
        LargModelise:Integer;                // Largeur de la fenetre de modelisation
        MesureParSuperStar:Boolean;          // Fait on la mesure par superstar ?
        MesureParReference:Boolean;          // Fait on la mesure par calcul de reference ?
        MesureParRegressionLineaire:Boolean; // Fait on la mesure par regression lineaire ?
        ApertureInt:Integer;                 // Photométrie d'ouverture rayon interieur
        ApertureMid:Integer;                 // Photométrie d'ouverture rayon intermédiaire
        ApertureOut:Integer;                 // Photométrie d'ouverture rayon exterieur

        AdresseCamera:Word;                  // Adresse du port // ou est branché la caméra CCD
        AdresseCameraSuivi:Word;             // Adresse du port // ou est branché la caméra CCD de guidage

        // Webcam
        Webcam_autoconnect:boolean;          // connexion automatique au demarage
        Webcam_preview:boolean;              // previsualisation video
        Webcam_viewpose:boolean;             // visualisation de l'image pendant la pose + rapport
        Webcam_drivername:string;            // nom du driver a utiliser
        Webcam_imgs:Double;                  // nombre d'images par secondes
        Webcam_nbdark:Byte;                  // nombre d'images dark
//        Webcam_typeimage:Byte;               // 0 : image unique ; 1 : AVI
        Webcam_color:Byte;                   // 0 : noir/blanc ; 1 : couleur
        Webcam_recadrage:Byte;               // 0 : Aucun; 1 : une etoile; 2 : plusieurs etoiles
        Webcam_pixelsizeX, Webcam_pixelsizeY : double;  // Pixel size

        CameraPlugin:string;                 // Nom du plugin camera exemple : hisis22.dll
        CameraPluginSuivi:string;            // Nom du plugin camera cde guidage exemple : hisis22.dll
        TypeDome:Integer;                    // Type de dome
        DomePlugin:string;                   // Nom du plugin dome/toit
        DomeUpdate:Boolean;                  // Envoi des ccordonnés du scope en secondes
        DomeCoordUpdate:Double;              // Fréquence d'envoi des ccordonnés du scope en secondes
        TimeAcqTrack:Double;                 // Temps de lecture du capteur de guidage pour pas empiéter sur la pose du CCD principal (ST7)
        CCDOriente:Boolean;                  // Le CCD est il correctement oriente et autorise le recentrage ?
        CCDTrackOriente:Boolean;             // Le CCD de guidage est il correctement oriente et autorise le recentrage ?
        EtapeCalibration:Byte;               // Pour demo/test de la calibration
        SuiviRef:Boolean;                    // Position de reference pour la demo de guidage
        UseLongFormat:Boolean;               // Choix du format de communication du LX200
        Allemande:Boolean;                   // Monture allemande ?
        VitesseGuidage:Double;               // Vitesse de guidage en microns/s
        VitesseGuidageApparenteDelta:Double; // Vitesse de guidage apparente en delta en microns/s
        VitesseGuidageApparenteAlpha:Double; // Vitesse de guidage apparente en alpha en microns/s

        TypeSeparateurAlpha:Integer;         // Separateurs des coordonnees alpha/delta
        TypeSeparateurDelta:Integer;
        SeparateurHeuresMinutesAlpha:Char;
        SeparateurMinutesSecondesAlpha:Char;
        UnitesSecondesAlpha:Char;
        SeparateurDegresMinutesDelta:Char;
        SeparateurMinutesSecondesDelta:Char;
        UnitesSecondesDelta:Char;

        AdresseComPort:string;               // Adresse du port Com
        // vision nocturne
        savwincol  : array[0..28] of Tcolor;
        nightvision : boolean;

        CloseQuery:Boolean;                  // On demande si on veut vraiment quitter
        AskToCalibrate:Boolean;              // On demande si on veut vraiment calibrer le guidage
        BuidingCosmeticFile:Boolean;         // True pendant la construction du fichier cosmetique
        InPopConf:Boolean;                   // Pour inquer qu'on est dans pop_conf
        HourServerComPort:string;            // Port com du serveur d'heure

        OldVersion:Double;                   // Pour tracer les versions et faire des updates

        // Sauvegardes valeurs dans les interfaces
        BestOfDFWHM:Double;                  // DELTAFWHM de la fonction best of stellaire
        BestOfFWHMMAx:Double;                // FWHM Max de la fonction best of stellaire

        MsgFocuser:Boolean;                  // Affichage de l'erreur de focuseur LX200 avec scope déconnecté
        BloqueGuidage:Boolean;
        UseCFW8:Boolean;
        CreeErreur:Boolean;
        InPopScopeFormShow:Boolean;

        AlphaScope,DeltaScope:Double;        // Position du scope
        AzimuthScope,ScopeHauteur:Double;    // Position du scope

        GoodPos:Boolean;

        PortTalkOpen:Boolean;

        Verbose:Boolean;                     // affichage des messages de bas niveau ? 

//        property TATelescope:string read Telescope write Telescope;
end;

{PC ports}
type TSerial_ports=array[0..3] of boolean;
type TParallel_ports=array[0..2] of boolean;

{Refraction}
type TRefraction_Matrix = array[0..5,0..1] of double;

{Corrections astrometriques precises pour le pointage}
type p_astrometric_corr = ^TAstrometric_corr;
     TAstrometric_corr = record
     //------------- INPUT ----------
         {OBJECT}
         i_epoch:double;
         i_alpha:double;  // degres
         i_delta:double;  // degres
         // proper motion mas/year
         i_pmra:double;
         i_pmde:double;
         // parallax (mas/year)
         i_parallax:double;
         // radial velocity (km/s)
         i_radvel:double;

         {OBSERVING SITE}
         // longitude latitude (degres) altitude (metres)
         i_longitude:double;
         i_latitude:double;
         i_altitude:double;
         // polar axis motion   arcsec
         i_pol_x:double;
         i_pol_y:double;

         // DATE
         i_day:integer;
         i_month:integer;
         i_year:integer;
         // TIME UTC
         i_hour:double;
         i_min:double;
         i_sec:double;
         // UT1-UTC (s)
         i_ut1_utc:double;

         // REFRACTION
         // temperature K
         i_temperature:integer;
         // pression millibars
         i_pressure:integer;
         // hygrometrie (%)
         i_hygrometry:integer;
         // longueur d onde refractee
         i_wavelength:double;
         // troposheric lapse rate (degres K/m)
         i_lapserate:double;

         {-------- OUTPUT ---------}
         o_epsilon:double;  // obliquite de l ecliptique  (degres)
         o_deps:double;     // nutation en longitude      (arcsec)
         o_dpsi:double;     // nutation en obliquite
         o_jday_obs:double; // jj de l observation
         o_alpha:double;    // alpha corrige (degres)
         o_delta:double;    // delta_corrige (degres)
end;

TAstrometrieInfos=record
   PolyX,PolyY:DoubleArrayRow;
   CovarX,CovarY:DoubleArray;
   DaX,DaY:DoubleArrayRow;   
   ChisqX,ChisqY:Double;
   ResiduX,ResiduY:Double;
   DegrePoly:Integer;
   HighPrecision:Boolean; // Utilisation de la modelisation haute precision
   Alpha0,Delta0:Double;   // Coordonnées du centre de l'image en Heures/Degrés
   Sx,Sy:Integer;          // Taille de l'image en pixels
   Focale:Double;          // Focale du télescope en mètres
   OrientationCCD:Double;  // Orientation de l'image
   TaillePixelX:Double;    // Taille X des pixels en microns
   TaillePixelY:Double;    // Taille Y des pixels en microns
   TypeGSC:Byte;           // Type GSC utilise
   USNOSelected,           // Catalogues selectionnés
   BSCSelected,
   GSCCSelected,
   TY2Selected,
   MCT1Selected,
   MCT2Selected,
   MCT3Selected:Boolean;
   end;

type p_field = ^TBoxwindow;
     TBoxWindow = record
      min_xx:DOUBLE;
      max_xx:double;
      min_xy:double;
      max_xy:double;
      score:integer;
      targets:tlist;
end;

type p_imagedb_idx_row = ^ Timagedb_idx_row;
     Timagedb_idx_row = record
       id:integer;
       object_name:string;
       tag:string;
       object_type:string;
       kind:char;
end;

type p_imagedb_hdr_row = ^TImagedb_hdr_row;
     TImagedb_hdr_row = record
       id:integer;
       file_name:string;
       ref:char;
       sx:integer;
       sy:integer;
       alpha: DOUBLE;
       delta: DOUBLE;
       alpha_str:string;
       delta_str:string;
       dttm:tdatetime;
       thres_min:integer;
       thres_max:integer;
       exposure:double;
       binning_x:integer;
       binning_y:integer;
       mirror_x :char;
       mirror_y:char;
       telescope:string;
       observer:string;
       camera:string;
       filtre:string;
       observatory:string;
       focal_length: DOUBLE;
       pix_x:double;
       pix_y:double;
       comments1:string;
       comments2:string;
       comments3:string;
       comments4:string;
       diameter: DOUBLE;
       temp_ccd: DOUBLE;
       orientation_ccd: DOUBLE;
       seeing: DOUBLE;
       sampling:double;
       fov_x:double;
       fov_y:double;
end;

  {Etalons photométrie}
  PEtalon=^TEtalon;
  TEtalon=record
    X,Y:Integer;
    Flux,FluxTheorique,FluxErreur,Magnitude,ErreurMagnitude:Double;
    Suivant:PEtalon;
    end;

  {Mesures astrometrie}
  PAstrom=^TAstrom;
  TAstrom=record
    X,Y:Integer;
    Alpha,Delta,DAlpha,DDelta:Double;
    Suivant:PAstrom;
    end;


type t_array_dttm=array [0..999] of double;

type t_array_int=array [0..999] of integer;

type p_imagemulti = ^T_ImageMulti;
     T_ImageMulti = record
       filename:string;
       new_filename:string;
       dttm:Tdatetime;
       common:integer;
       diff:integer;
       aster:integer;
end;

type p_candidate = ^T_Candidate;
     T_Candidate = record
       x1,y1,f1,x2,y2,f2,x3,y3,f3:double;
       pente:double;
       delta_t1:double;
       delta_t2:double;
end;

type t_array_list = array [0..999] of tlist;

type
p_ast_elem = ^t_ast_elem;
t_ast_elem = record
   num:integer;
   name:string;
   mag_h: double;
   slope_g: double;
   osc_epoch :string;
   mean_anomaly: double;
   arg_peri :double;
   lon_asc_node :double;
   inclination :double;
   eccentricity: double;
   sm_axis :double;
end;


type
p_ast_details = ^t_ast_details;
t_ast_details = record
   num:integer;
   name:string;
   comp_name:string;
   color_index: double;
   diameter: double;
   taxonomy: string;
   code_1 :integer;
   code_2 :integer;
   code_3 :integer;
   code_4 :integer;
   code_5 :integer;
   code_6 :integer;
   orbital_arc: double;
   nbr_obs: integer;
   orbit_comp :string;
   abs_ceu: double;
   rate_chg_ceu :double;
   ceu_date :string;
   next_peu :double;
   next_peu_date :string;
   great_peu_10_ceu :double;
   great_peu_10_ceu_date :string;
   great_peu_10_peu :double;
   great_peu_10_peu_date :string;
end;


type
p_ast_ephem = ^t_ast_ephem;
t_ast_ephem = record
   num:integer;
   name:string;
   jday:double;
   alpha:double;
   delta:double;
   d_geo   : double;      // distance geocentrique
   d_helio : double;      // distance heliocentrique
   elong  : double;      // elongation au Soleil
   phase  : double;      // angle de phase
   magn   : double;      // magnitude
   daily_move:double;
  end;

 TNebulaCatalog = (NoNeb, NGC, SAC, PGC);
 TProjPole = (pPolar, pZenithal);
 TProjection = (prTAN, prARC, prSIN, prCAR);
 TSelectColor = (coColor, coBW, coWB, coNight, coUser); 
{  type
 TStarCatalog = (NoStar, GSC, Tycho2, Sky2000, BSC);
 TNebulaCatalog = (NoNeb, NGC, SAC, PGC);
 Starcolarray =  Array [0..11] of Tcolor;
 TObjRec = record
           objtype : integer;
           name : string;
           ra,dec,mag,mag2,b_v,sep,sbr,size1,size2,pa : double;
           end;
 PObjRec = ^TObjRec;}


type t_skychart_config = record
     FOV:double;
     RA:double;
     dec:double;
     starcatalog:TStarCatalog;
     starlimit:boolean;
     StarMagMax:double;
     NebulaCalalog:TNebulaCatalog;
     neblimit:boolean;
     NebMagMax:double;
     NebDimMin:double;
     projpole:TProjPole;
     projection:TProjection;
     rotation:double;
     SelColor:TSelectColor;
end;

{script}
type p_target = ^TTarget;
     TTarget = record
        line:string;
        files,action:string;
       // time_offset:double;
        linenum:integer;
        catalog:string;
        obj:string;
        com:string;
        // target params
        obj_RA:double;
        obj_DEC:double;
        obj_name:string;
        obj_type:string;
        obj_mag:double;
        obj_rise:double;
        obj_set:double;
        obj_transit:double;
        obj_hour_angle:double;
        obj_azimut:double;
        obj_hauteur:double;
        obj_visible:string;  // Y/N
        obj_status:byte;
        obj_azimut_prev:double;
        obj_hauteur_prev:double;
        obj_hour_angle_prev:double;
        obj_comment:string;
        obj_airmass:double;
        // ccd actions
        CCD_nbr:integer;       // nbr de poses
        CCD_exp:double;        // tps de pose
        CCD_bin:integer;       // binning
        ccd_filter:integer;    // index du filtre
        ccd_x1,ccd_y1,ccd_x2,ccd_y2:integer;
        ccd_outputdir:string;
        ccd_imagename:string;
        // status
        group:integer;
        block_id:integer;
        distance_to_moon:double;
        wait_time:double;    // temps d attente en seconde
        exec:string;         // fichier a executer
        comflag:string;  // Y/N
        status:byte;
        // 0 : init
        // 1 : en attente, pret a etre execute
        // 2 : en cours
        //
        // 69 : succes !
        // 100 : discarded - objet se leve apres le soleil
        // 101 : discarded - objet se couche trop tot
        // 102 : discarded - pointage sous l horizon
        // 103 : discarded - pointage hors limite azimut
        // 104 : discarded - pointage hors limite hauteur
        // 105 : discarded - pointage trop pres de la lune
        // 106 : discarded - lumiere de la lune trop importante
        // 107 : discarded - telescope repond pas
        // 108 : discarded - script finit apres lever du soleil
        // 109 : discarded - pointage sous le profil
end;



type
  TIStatus = (iStopped, iRunning, iStepOver, iStepOverWaiting);

type tapnstr=array [0..63] of char;
type papnstr=^tapnstr;


implementation

end.
