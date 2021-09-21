unit u_file_io;

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

                        fonctions de gestion fichiers

--------------------------------------------------------------------------------}


interface
uses math, sysutils, dialogs, forms, windows, u_constants, u_class, classes, inifiles,
     jpeg, graphics;

procedure InitImgInfos(var ImgInfos:TImgInfos);
procedure WriteSpy(Line:String);
//procedure WriteTrack(Line:String);
{lecture des catalogues}
procedure CheckCat;
function  get_bsc(x_1,x_2,y_1,y_2,mag_lo,mag_hi:double;var lst:tlist):boolean;
function  get_usno(x_1,x_2,y_1,y_2,mag_lo,mag_hi:double;var lst:tlist):boolean;
function  get_pgc(x_1,x_2,y_1,y_2,mag_lo,mag_hi,size_lo,size_hi:double;var lst:tlist):boolean;
function  get_rc3(x_1,x_2,y_1,y_2,mag_lo,mag_hi,size_lo,size_hi:double;var lst:tlist):boolean;
function  get_ngc(x_1,x_2,y_1,y_2,mag_lo,mag_hi,size_lo,size_hi:double;var lst:tlist):boolean;
function  get_ty2(x_1,x_2,y_1,y_2,mag_lo,mag_hi:double;var lst:tlist):boolean;
function  get_mct(x_1,x_2,y_1,y_2,mag_lo,mag_hi:double;cat:integer;var lst:tlist):boolean;
function  get_gsc(x_1,x_2,y_1,y_2,mag_lo,mag_hi:double;var lst:tlist):boolean;
procedure query_the_catalogs(s:string; x_1,x_2,y_1,y_2,         // coords des 2 coins opposes
                                       mag_lo,mag_hi,           // limites magnitude
                                       size_lo, size_hi:double; // limites taille
                                       p:pHeader;
                                       var lst:tlist;           // liste de sortie
                                       output:boolean);         // cree un fichier texte si true

procedure create_query_output(p:pHeader;s:string;lst:tlist);

{lecture fichiers image}
//function check_this_header(p:pHeader):byte;
{CPA}
procedure RazCpahV3(var CpahV3:TEnteteCPA_Ver3);
procedure RazCpahV4(var CpahV4:TEnteteCPA_Ver4c);
procedure ReadCpaHeader(nom:string; var h3:TEnteteCPA_Ver3; var h4:TEnteteCPA_Ver4c; var NumCPA:Byte);
procedure ReadCpa(Nom:TFileName;
                  var TabImgInt:PTabImgInt;
                  var ImgInfos:TImgInfos);
procedure SaveCpaV3(Nom:TFileName;
                    TabImgInt:PTabImgInt;
                    Plan:Integer;
                    ImgInfos:TImgInfos);
procedure SaveCpaV4d(Nom:TFileName;
                    TabImgInt:PTabImgInt;
                    Plan:Integer;
                    ImgInfos:TImgInfos);
{PIC}
procedure RazPic(var Pich:TPicHeader);
procedure ReadPicHeader(Nom:TFilename; var hdr: TPicHeader);
procedure ReadPic(Nom:TFileName;
                  var TabImgInt:PTabImgInt;
                  var ImgInfos:TImgInfos);
procedure SavePic(Nom:TFileName;
                  TabImgInt:PTabImgInt;
                  ImgInfos:TImgInfos);
{FITS}
function is_keyword_ok(keyword:string):boolean;
function DateToStrFITS(DateTime:TDateTime):string;
procedure ReadFitsHeaderRaw(f:string; var liste:tlist);
procedure SaveFITS(Nom:TFileName;
                   var DataInt:PTabImgInt;
                   var DataDouble:PTabImgDouble;
                   Plan,NPlan:Integer;  // Plan = premier plan d'image a sauver, Nplan = nombre de plan a sauver.
                   ImgInfos:TImgInfos);
function ReadFITSHeader(Nom:TFileName;
                        var offset:integer;
                        var ImgInfos:TImgInfos):boolean;
function ReadFitsImage(filename:string;
                       bypass:boolean;
                       var TabImgInt:PTabImgInt;
                       var TabImgDouble:PTabImgDouble;
                       var ImgInfos:TImgInfos):byte;
function AddKeyword(keyword, argument :string;
                     var ImgInfos:TImgInfos):boolean;
function InvertI16(X : word) : smallInt;
function RevertI16(x:word) : smallint;
function InvertI32(X : LongWord) : LongInt;
function revertI32(x:LongInt) : Longword;
function InvertI64(X : Int64) : Int64;
function InvertF32(X : LongWord) : Single;
function InvertF64(X : Int64) : Double;
// Fonction generales images
procedure ReadHeader(Name:String;
                     var ImgInfos:TImgInfos);
procedure ReadImageGenerique(FileName:String;
                             var TabImgInt:PTabImgInt;
                             var TabImgDouble:PTabImgDouble;
                             var ImgInfos:TImgInfos);
procedure SaveImageGenerique(FileName:String;
                             var TabImgInt:PTabImgInt;
                             var TabImgDouble:PTabImgDouble;
                             var ImgInfos:TImgInfos);
procedure SaveImage(FileName:string;
                    var TabImgInt:PTabImgInt;
                    var TabImgDouble:PTabImgDouble;
                    var ImgInfos:TImgInfos);
procedure ReadInit;
procedure file2string(f:string; var s:string);
function  is_a_galaxy(s:string; var typo:string):boolean;
function  do_the_asteroid_file(p:p_critlist):boolean;
function  read_asteroid_file(p:p_critlist):boolean;
procedure ReadBMP(Nom:TFileName;
                  var ImgInt:PTabImgInt;
                  var ImgInfos:TImgInfos);
procedure SaveBMP(Nom:TFileName;
                  ImgInt:PTabImgInt;
                  ImgDouble:PTabImgDouble;
                  ImgInfos:TImgInfos);
procedure SaveBMPHandle(Nom:TFileName;
                  ImgInt:PTabImgInt;
                  ImgDouble:PTabImgDouble;
                  ImgInfos:TImgInfos;
                  Handle:Integer);
procedure ReadJPG(Nom:TFileName;
                  var ImgInt:PTabImgInt;
                  var ImgInfos:TImgInfos);
procedure SaveJPG(Nom:TFileName;
                  ImgInt:PTabImgInt;
                  ImgDouble:PTabImgDouble;
                  ImgInfos:TImgInfos);
procedure SaveJPGHandle(Nom:TFileName;
                        ImgInt:PTabImgInt;
                        ImgDouble:PTabImgDouble;
                        ImgInfos:TImgInfos;
                        Handle:Integer);
procedure SaveText(Nom:TFileName;
                  ImgInt:PTabImgInt;
                  ImgDouble:PTabImgDouble;
                  Sx,Sy:Integer;
                  Min,Max:TSeuils;
                  TypeData,NbPlans:Byte;
                  TypeComplexe:Byte);
procedure read_internet_conf;
procedure WriteDebug(Line:String);
procedure Tic;
procedure Toc;
procedure ConvertFromBMPStream(MyBitmap:TMemoryStream;
                               var ImgInt:PTabImgInt;
                               var ImgInfos:TImgInfos);
function SavePSD(nom:string;image:PTabImgInt;infos:TImgInfos;order:boolean):boolean;
procedure ReadApn(Nom:string;
                  var TabImgInt:PTabImgInt;
                  var ImgInfos:TImgInfos);
function ReadPhotoNumerique(FileName:string;
                            var TabImgInt:PTabImgInt;
                            var ImgInfos:TImgInfos;
                            Raw:Boolean):Boolean;


//fonctions DLL
function get_file_infos(Filename:Pchar;var fabricant,modele:tapnstr;var Sx,Sy:Integer):Integer; stdcall;external 'apn.dll'; //nolang
function load_cfa(Filename:Pchar;ImageP:Pointer;Var Sx,Sy:Integer):Integer; stdcall;external 'apn.dll'; //nolang

var
  InSpy:Boolean;
  fitspriority : Tfitspriority;

implementation

uses
    pu_main,
    catalogues,
    u_general,
    u_meca,
    pu_image,
    pu_camera,
    pu_spy,
    pu_seuils,
    pu_script_builder,
    u_visu,
    u_analyse,
    u_stream_prism,
    u_lang,
    u_arithmetique;


{-------------------------------------------------------------------------------

                                  general

-------------------------------------------------------------------------------}


{function check_this_header(p:pHeader):byte;
//on verifie qu on a des valeurs utilisables pour pouvoir continuer
begin
     if (p.binningX <> 1) and (p.binningX<>2) and (p.binningX<>3) and (p.binningX<>4)  then begin result:=1; exit; end;
     if (p.binningY <> 1) and (p.binningY<>2) and (p.binningY<>3) and (p.binningY<>4)  then begin result:=1; exit; end;
     if (p.Focale <= 0) or (p.focale > 10000) then begin result:=2; exit; end;
     if p.Alpha=0 then begin result:=3; exit; end;
     if p.delta=0 then begin result:=4; exit; end;
     if p.sampling_x=0 then begin result:=7; exit; end;
     if p.sampling_y=0 then begin result:=8; exit; end;
     if p.fov_x=0 then begin result:=9; exit; end;
     if p.fov_Y=0 then begin result:=10; exit; end;
     result:=0;
end;}


procedure InitImgInfos(var ImgInfos:TImgInfos);
begin
with ImgInfos do
   begin
   Min[1]:=0;
   Max[1]:=0;
   Min[2]:=0;
   Max[2]:=0;
   Min[3]:=0;
   Max[3]:=0;
   DateTime:=0;
   filename:='';
   project:='';
   catalogs:='';
   BinningX:=1;
   BinningY:=1;
   MiroirX:=False;
   MiroirY:=False;
   Telescope:='';
   Observateur:='';
   Camera:='';
   Filtre:='';
   Observatoire:='';
   Focale:=0;
   Alpha:=0;
   Delta:=0;
   PixX:=0;
   PixY:=0;
   Commentaires[1]:='';
   Commentaires[2]:='';
   Commentaires[3]:='';
   Commentaires[4]:='';
{   fov_x:=0;
   fov_y:=0;
   sampling_x:=0;
   sampling_y:=0;
   bsc:=0;
   usno:=0;
   pgc:=0;
   rc3:=0;
   ngc:=0;
   gsc:=0;
   mct:=0;
   ty2:=0;
   tyc:=0;
   processed:=False;
   status:=0;
   max_allowed_residual:=0;
   cat_calib:=0;
   mag_inf:=0;
   mag_sup:=0;
   TypeModele:=0;
   precision:=0;
   sigma:=0;
   write_plate_constants:=False;
   max_delta_fwhm:=0;
   max_delta_flux:=0;}
   end;
end;

{-------------------------------------------------------------------------------

                                  fichiers CPA

-------------------------------------------------------------------------------}

procedure RazCpahV3(var CpahV3:TEnteteCPA_Ver3);
var
i:Integer;
SVide:String;
begin
SVide:='';
for i:=1 to 80 do SVide:=SVide+' ';
with CpahV3 do
   begin
   Signature:=Sign_V3Cpa;
   Largeur:=0;
   Longueur:=0;
   BinningX:=1;
   BinningY:=1;
   TabSeuilHaut[1]:=0; TabSeuilHaut[2]:=0; TabSeuilHaut[3]:=0;
   TabSeuilBas[1]:=0;  TabSeuilBas[2]:=0;  TabSeuilBas[3]:=0;
   TypeData:=3;
   NbrePlan:=1;
   TimeDate:=0;
   TempsDePose:=0;
   MiroirX:=False;
   MiroirY:=False;
   Telescope:=SVide;
   Observateur:=SVide;
   Camera:=SVide;
   Filtre:=SVide;
   Observatoire:=SVide;
   Focale:=0;
   Alpha:=0;
   Delta:=0;
   PixX:=0;
   PixY:=0;
   DebX:=0;
   DebY:=0;
   FinX:=0;
   FinY:=0;
   TypeCompression:=0;
   NombreBitsComp:=0;
   Commentaires[1]:=SVide;
   Commentaires[2]:=SVide;
   Commentaires[3]:=SVide;
   Commentaires[4]:=SVide;
   end;
end;

procedure RazCpahV4(var CpahV4:TEnteteCPA_Ver4c);
var
i:Integer;
SVide:String;
begin
SVide:='';
for i:=1 to 80 do SVide:=SVide+' ';
with CpahV4 do
   begin
   Signature:=Sign_V4dCpa;
   Largeur:=0;
   Longueur:=0;
   BinningX:=1;
   BinningY:=1;
   TabSeuilHaut[1]:=0; TabSeuilHaut[2]:=0; TabSeuilHaut[3]:=0;
   TabSeuilBas[1]:=0;  TabSeuilBas[2]:=0;  TabSeuilBas[3]:=0;
   TypeData:=3;
   NbrePlan:=1;
   TimeDate:=0;
   TempsDePose:=0;
   MiroirX:=False;
   MiroirY:=False;
   Telescope:=SVide;
   Observateur:=SVide;
   Camera:=SVide;
   Filtre:=SVide;
   Observatoire:=SVide;
   Focale:=0;
   Alpha:=0;
   Delta:=0;
   PixX:=0;
   PixY:=0;
   DebX:=0;
   DebY:=0;
   FinX:=0;
   FinY:=0;
   TypeCompression:=0;
   NombreBitsComp:=0;
   Commentaires[1]:=SVide;
   Commentaires[2]:=SVide;
   Commentaires[3]:=SVide;
   Commentaires[4]:=SVide;

   Wavelength:=0; // Longueur centrale du filtre
   Bandwidth:=0;  // Bande passante
   Flux:=0;       // Peut etre utilise pour decrire quel serait le flux une etoile de mg 0
   Diametre:=0;   // mm²
   Offset:=0;     // Offest de l'inage en ADU
   FacteurCVF:=0; // Facteur de convertion en e-/ADU
   Seeing:=0;     // en arcsec

   TemperatureCCD:=0;
   TemperatureExt:=0;
   Latitude:=0;
   Longitude:=0;

   AstrometrieEtalon:=False;
   UseAstrometriePar:=False;
   AstrometriePar.XC:=0;
   AstrometriePar.YC:=0;
   AstrometriePar.LargX:=0;
   AstrometriePar.LargY:=0;
   AstrometriePar.Alpha_Ref:=0;
   AstrometriePar.Delta_Ref:=0;
   AstrometriePar.RayonX:=0;
   AstrometriePar.RayonY:=0;

   DimPoly:=0;
   for i:=1 to NbMaxPlateCoef do
      begin
      SolAlpha[i]:=0;
      SolDelta[i]:=0;
      SolX[i]:=0;
      SolY[i]:=0;
      end;

   TempsLectureCCD:=0;
   Magnitude_Ref:=0;
   ErrFlux_Ref:=0;
   TDImode:=False;
   TempLectureLigne:=0;

   IsPhotometricCal:=False;
   AngleCCD:=0;
   Flux_Ref:=0;
   PhotometrieEtalonnage:=False;
   TransformRescaleDynamic:=0;
   end;
end;

{ version light de readcpa. lit v3 pour l instant}
procedure ReadCpaHeader(nom:string; var h3:TEnteteCPA_Ver3; var h4:TEnteteCPA_Ver4c; var NumCPA:Byte);
var
F:file;
Signature:Integer;
begin

// On lit le fichier en memoire
AssignFile(F,Nom);
FileMode:=0;
Reset(F,1);
FileMode:=2;
BlockRead(F,Signature,4);
CloseFile(F);

   case Signature of

   Sign_V3Cpa ://is version 3 ,7533548
      begin
      AssignFile(F,Nom);
      FileMode:=0;
      Reset(F,1);
      FileMode:=2;
      BlockRead(F,h3,SizeOf(h3));
      NumCPA:=3;
      end;
   Sign_V4dCpa:
      begin
      AssignFile(F,Nom);
      FileMode:=0;
      Reset(F,1);
      FileMode:=2;
      BlockRead(F,h4,SizeOf(h4));
      NumCPA:=4;
      end;

   else
      begin
      raise ErrorFileIO.Create(lang('Ce fichier n''est certainement pas une image CPA !')+#13+
            lang('Ouverture annulée'));
      end;
   end;

CloseFile(F);
end;


procedure ReadCpa(Nom:TFileName;
                  var TabImgInt:PTabImgInt;
                  var ImgInfos:TImgInfos);
var
Charge:Boolean;
i,j,k,l:Integer;
NonComp,PosEsp:Integer;
Last:integer;
ValInt16:SmallInt;
ValInt8:Byte;
F:file;
CpahV3:TEnteteCPA_Ver3;
EnteteVer4c:PEnteteCPA_ver4c;
Buffer:PLigByte;
Signature:Integer;
StreamReadFile:TStreamReadFile;
TabImgDouble:PTabImgDouble;
begin
WriteSpy(lang('ReadCpa : Lecture de ')+Nom);

ImgInfos.BZero:=0;
ImgInfos.BScale:=1;

// On lit la signature en memoire
AssignFile(F,Nom);
FileMode:=0;
Reset(F,1);
FileMode:=2;
BlockRead(F,Signature,4);
CloseFile(F);

case Signature of
   Sign_V3Cpa://is version 3 ,7533548
      begin
      AssignFile(F,Nom);
      FileMode:=0;
      Reset(F,1);
      FileMode:=2;
      BlockRead(F,CpahV3,SizeOf(CpahV3));
      Charge:=True;
      ImgInfos.Sx:=CpahV3.Largeur;
      ImgInfos.Sy:=CpahV3.Longueur;
      ImgInfos.NbPlans:=CpahV3.NbrePlan;
      if ImgInfos.NbPlans=3 then ImgInfos.TypeData:=7 else ImgInfos.TypeData:=2;

      // Stockage des autres infos
      InitImgInfos(ImgInfos);
      with ImgInfos do
         begin
         TempsPose:=Round(CpahV3.TempsDePose);
         for i:=1 to 3 do begin
           Min[i]:=CpahV3.TabSeuilBas[i];
           Max[i]:=CpahV3.TabSeuilHaut[i];
         end;
         DateTime:=CpahV3.TimeDate;

         filename:=Nom;
         BinningX:=CpahV3.BinningX;
         BinningY:=CpahV3.BinningY;
         MiroirX:=CpahV3.MiroirX;
         MiroirY:=CpahV3.MiroirY;
         Telescope:=CpahV3.Telescope;
         Observateur:=CpahV3.Observateur;
         Camera:=CpahV3.Camera;

         PosEsp:=Pos('/GUIDRMS=',CpahV3.Filtre); //nolang
         if PosEsp<>0 then
            begin
            Filtre:=Copy(CpahV3.Filtre,1,PosEsp-1);
            ImgInfos.RMSGuideError:=MyStrToFloat(Copy(CpahV3.Filtre,PosEsp+9,Length(CpahV3.Filtre)-PosEsp));
            end
         else Filtre:=CpahV3.Filtre;

         Observatoire:=CpahV3.Observatoire;
         Focale:=CpahV3.Focale; // mm -> mm
         Alpha:=CpahV3.Alpha/pi*180/15; // Radian -> Heures
         Delta:=CpahV3.Delta/pi*180; // Radian -> Degres
         PixX:=CpahV3.PixX;
         PixY:=CpahV3.PixY;
         X1:=CpahV3.DebX;
         Y1:=CpahV3.DebY;
         X2:=CpahV3.FinX;
         Y2:=CpahV3.FinY;
         Commentaires[1]:=CpahV3.Commentaires[1];
         Commentaires[2]:=CpahV3.Commentaires[2];
         Commentaires[3]:=CpahV3.Commentaires[3];
         Commentaires[4]:=CpahV3.Commentaires[4];
         end;

      if CpahV3.TypeData<>3 then
         begin
         MessageDlg(lang('Ce fichier n''est certainement pas au format entier !')+#13+
           lang('Ouverture annulée'),mtError,[mbOK],0);
         Charge:=False;
         end;

      // Si l'image est bonne on la charge
      if Charge then
         begin
         // On transfere l'image en memoire interne
         Getmem(TabImgInt,4*ImgInfos.NbPlans);
         for k:=1 to ImgInfos.NbPlans do begin
            Getmem(TabImgInt^[k],ImgInfos.Sy*4);
            for i:=1 to ImgInfos.Sy do Getmem(TabImgInt^[k]^[i],ImgInfos.Sx*2);
         end;

         GetMem(Buffer,2*ImgInfos.Sx);

         NonComp:=2*ImgInfos.Sx;
         for k:=1 to ImgInfos.NbPlans do
         for j:=1 to ImgInfos.Sy do
            begin
            BlockRead(F,ValInt16,2) ;
            if ValInt16=NonComp then BlockRead(F,TabImgInt^[k]^[j]^,ImgInfos.Sx*2)
            else
               begin
               BlockRead(F,Buffer^,ValInt16);
               l:=1;
               Move(Buffer^[l],ValInt16,2);
               Inc(l,2);
               Last:=ValInt16;
               TabImgInt^[k]^[j]^[1]:=ValInt16;
               for i:=2 to ImgInfos.Sx do
                  begin
                  ValInt8:=Buffer^[l];
                  Inc(l);
                  if ValInt8=255 then       // double octet non-compresse
                     begin
                     Move(Buffer^[l],ValInt16,2);
                     Inc(l,2);
                     TabImgInt^[k]^[j]^[i]:=ValInt16;
                     Last:=ValInt16;
                     end
                  else
                     begin
                     ValInt16:=ValInt8;
                     Last:=Last+ValInt16-127;
                     TabImgInt^[k]^[j]^[i]:=Last;
                     end;
                  end;
               end;
            end;
         CloseFile(F);
         FreeMem(Buffer,2*ImgInfos.Sx);
         pop_main.SeuilsEnable;
         end;

      end;
   Sign_V4dCpa:
      begin
      StreamReadFile:=TStreamReadFile.Create(Nom,32*1024);
      try

      new(EnteteVer4c);
      try
      StreamReadFile.Init;
      StreamReadFile.ReadBuffer(EnteteVer4c^,SizeOf(TEnteteCPA_ver4c));

      ImgInfos.Sx:=EnteteVer4c.Largeur;
      ImgInfos.Sy:=EnteteVer4c.Longueur;
      ImgInfos.NbPlans:=EnteteVer4c.NbrePlan;
      if ImgInfos.NbPlans=3 then ImgInfos.TypeData:=7 else ImgInfos.TypeData:=2;

      // Stockage des autres infos
      InitImgInfos(ImgInfos);
      with ImgInfos do
         begin
         TempsPose:=Round(EnteteVer4c.TempsDePose);
         for i:=1 to 3 do begin
           Min[i]:=EnteteVer4c.TabSeuilBas[i];
           Max[i]:=EnteteVer4c.TabSeuilHaut[i];
         end;
         DateTime:=EnteteVer4c.TimeDate;

         FileName       :=Nom;
         BinningX       :=EnteteVer4c.BinningX;
         BinningY       :=EnteteVer4c.BinningY;
         MiroirX        :=EnteteVer4c.MiroirX;
         MiroirY        :=EnteteVer4c.MiroirY;
         Telescope      :=EnteteVer4c.Telescope;
         Observateur    :=EnteteVer4c.Observateur;
         Camera         :=EnteteVer4c.Camera;
         
         PosEsp:=Pos('/GUIDRMS=',EnteteVer4c.Filtre); //nolang
         if PosEsp<>0 then
            begin
            Filtre:=Copy(EnteteVer4c.Filtre,1,PosEsp-1);
            ImgInfos.RMSGuideError:=MyStrToFloat(Copy(EnteteVer4c.Filtre,PosEsp+9,Length(EnteteVer4c.Filtre)-PosEsp));
            end
         else Filtre:=EnteteVer4c.Filtre;

         Observatoire   :=EnteteVer4c.Observatoire;
         Focale         :=EnteteVer4c.Focale;     // mm -> mm
         Alpha          :=EnteteVer4c.Alpha/pi*180/15; // Radian -> Heures
         Delta          :=EnteteVer4c.Delta/pi*180;    // Radian -> Degres
         PixX           :=EnteteVer4c.PixX;
         PixY           :=EnteteVer4c.PixY;
         X1             :=EnteteVer4c.DebX;
         Y1             :=EnteteVer4c.DebY;
         X2             :=EnteteVer4c.FinX;
         Y2             :=EnteteVer4c.FinY;
         Diametre       :=EnteteVer4c.Diametre;
         TemperatureCCD :=EnteteVer4c.TemperatureCCD;
         OrientationCCD :=EnteteVer4c.AngleCCD;
         Seeing         :=EnteteVer4c.Seeing;
         Commentaires[1]:=EnteteVer4c.Commentaires[1];
         Commentaires[2]:=EnteteVer4c.Commentaires[2];
         Commentaires[3]:=EnteteVer4c.Commentaires[3];
         Commentaires[4]:=EnteteVer4c.Commentaires[4];
         end;

      finally
      dispose(EnteteVer4c);
      end;

      Charge:=True;
      if EnteteVer4c.TypeData<>3 then
         begin
         MessageDlg(lang('Ce fichier n''est certainement pas au format entier !')+#13+
           lang('Ouverture annulée'),mtError,[mbOK],0);
         Charge:=False;
         end;

      // Si l'image est bonne on la charge
      if Charge then
         begin
         pop_main.SeuilsEnable;         
         //Allocate memory for image
         GetmemImg(TabImgInt,TabImgDouble,ImgInfos.Sx,ImgInfos.Sy,2,ImgInfos.NbPlans);

         try
         for i:=1 to ImgInfos.NbPlans do
            HuffmanDiffUnCompression(StreamReadFile,ImgInfos.Sx,ImgInfos.Sy,2,TabImgInt^[i],1,1,ImgInfos.Sx,ImgInfos.Sy,nil);
         except
         FreememImg(TabImgInt,TabImgDouble,ImgInfos.Sx,ImgInfos.Sy,2,ImgInfos.NbPlans);
         raise;

         end;

         end;

      finally
      StreamReadFile.Close;      
      StreamReadFile.Free;
      end;

      end
   else
      begin
      raise ErrorReadFile.Create(lang('Ce fichier n''est certainement pas une image CPA !')+#13+
        lang('Ouverture annulée'));
      end;
   end;

end;

{ Sauvegarde en Cpa Version 3}
procedure SaveCpaV3(Nom:TFileName;
                    TabImgInt:PTabImgInt;
                    Plan:Integer;
                    ImgInfos:TImgInfos);
var
   i,j,k,nb:integer;
   Last:SmallInt;           // Contient l'intensite precedente pour la decompression
   ValInt16:SmallInt;
   ValInt8:Byte;
   Val:SmallInt;
   NonComp:SmallInt;
   Cpah:TEnteteCPA_Ver3;
   F:file;
   Buffer:PLigByte;
   RMSGuideErrorStr:string;
begin
    WriteSpy(lang('SaveCpaV3 : Sauvegarde de ')+Nom);

    RazCpahV3(Cpah);

    Cpah.Largeur:=ImgInfos.Sx;
    Cpah.Longueur:=ImgInfos.Sy;
    Cpah.TypeCompression:=1;
    Cpah.NbrePlan:=ImgInfos.NbPlans;
    for i:=1 to 3 do begin
      Cpah.TabSeuilBas[i]:=ImgInfos.Min[i];
      Cpah.TabSeuilHaut[i]:=ImgInfos.Max[i];
    end;
    Cpah.TimeDate:=ImgInfos.DateTime;
    Cpah.TempsDePose:=ImgInfos.TempsPose;
    Cpah.Alpha:=ImgInfos.Alpha*15/180*pi;  // Heure -> Radian
    Cpah.Delta:=ImgInfos.Delta/180*pi;     // Degre -> Radian
    Cpah.Focale:=ImgInfos.Focale;     // Metre -> mm
    Cpah.PixX:=ImgInfos.PixX;              // en um
    Cpah.PixY:=ImgInfos.PixY;              // en um
    Cpah.DebX:=ImgInfos.X1;
    Cpah.DebY:=ImgInfos.Y1;
    Cpah.FinX:=ImgInfos.X2;
    Cpah.FinY:=ImgInfos.Y2;
    Cpah.BinningX:=ImgInfos.BinningX;
    Cpah.BinningY:=ImgInfos.BinningY;
    Cpah.MiroirX:=ImgInfos.MiroirX;
    Cpah.MiroirY:=ImgInfos.MiroirY;
    Cpah.Camera:=ImgInfos.Camera;    
    Cpah.Telescope:=ImgInfos.Telescope;
    Cpah.Observatoire:=ImgInfos.Observatoire;
    Cpah.Observateur:=ImgInfos.Observateur;
    Cpah.Filtre:=ImgInfos.Filtre;
//     /GUIDRMS=
    if ImgInfos.RMSGuideError<>0 then
       begin
       RMSGuideErrorStr:='/GUIDRMS='+MyFloatToStr(ImgInfos.RMSGuideError,2); // nolang
       if Length(Cpah.Filtre)+Length(RMSGuideErrorStr)<80 then
          Cpah.Filtre:=Cpah.Filtre+RMSGuideErrorStr;
       end;
    Cpah.Commentaires[1]:=ImgInfos.Commentaires[1];
    Cpah.Commentaires[2]:=ImgInfos.Commentaires[2];
    Cpah.Commentaires[3]:=ImgInfos.Commentaires[3];
    Cpah.Commentaires[4]:=ImgInfos.Commentaires[4];

    AssignFile(F,Nom);
    Rewrite(F,1);
    BlockWrite(F,Cpah,SizeOf(Cpah));

    GetMem(Buffer,10*ImgInfos.Sx);

    for k:=Plan to ImgInfos.NbPlans do
    for j:=1 to ImgInfos.Sy do
       begin
       // On comprime la ligne
       Last:=TabImgInt^[k]^[j]^[1];
       Move(Last,Buffer^[1],2);
       Nb:=3;
       for i:=2 to ImgInfos.Sx do
          begin
          Val:=TabImgInt^[k]^[j]^[i];
          if (Val-Last<-127) or (Val-Last>127) then
             begin
             ValInt8:=255;
             Move(ValInt8,Buffer^[Nb],1);
             Inc(Nb);
             Move(Val,Buffer^[Nb],2);
             Inc(Nb,2);
             end
          else
             begin
             ValInt16:=Val-Last+127;
             if (ValInt16>=0) and (ValInt16<=255) then ValInt8:=ValInt16
             else
                begin
                ShowMessage(lang('Dépassement'));
                exit;
                end;
             Move(ValInt8,Buffer^[Nb],1);
             Inc(Nb);
             end;
          Last:=Val;
          end;
       { Si la ligne compresse est plus petite on l'ecrit }
       if Nb<2*ImgInfos.Sx then
          begin
          BlockWrite(F,Nb,2);
          BlockWrite(F,Buffer^,Nb);
          end
       else
       { Sinon on ecrit la ligne non compressee }
          begin
          NonComp:=2*ImgInfos.Sx;
          BlockWrite(F,NonComp,2);
          BlockWrite(F,TabImgInt[k]^[j]^,2*ImgInfos.Sx);
          end;
       end;

    CloseFile(F);
    FreeMem(Buffer,10*ImgInfos.Sx);

end;

{ Sauvegarde en Cpa Version4d}
// Uniquement TypeData=2 et NbPlan=1
procedure SaveCpaV4d(Nom:TFileName;
                    TabImgInt:PTabImgInt;
                    Plan:Integer;
                    ImgInfos:TImgInfos);
var
i:integer;
Cpah:TEnteteCPA_Ver4c;
StreamWriteFile:TStreamWriteFile;
RMSGuideErrorStr:string;
begin
StreamWriteFile:=TStreamWriteFile.Create(Nom,32*1024);
try
try

StreamWriteFile.Init;
try

WriteSpy(lang('SaveCpaV4d : Sauvegarde de ')+Nom);

RazCpahV4(Cpah);

Cpah.Largeur:=ImgInfos.Sx;
Cpah.Longueur:=ImgInfos.Sy;
Cpah.TypeCompression:=1;
Cpah.NbrePlan:=ImgInfos.Nbplans;
for i:=1 to 3 do begin
  Cpah.TabSeuilBas[i]:=ImgInfos.Min[i];
  Cpah.TabSeuilHaut[i]:=ImgInfos.Max[i];
end;
Cpah.TimeDate:=ImgInfos.DateTime;
Cpah.TempsDePose:=ImgInfos.TempsPose;
Cpah.Alpha:=ImgInfos.Alpha*15/180*pi;  // Heure -> Radian
Cpah.Delta:=ImgInfos.Delta/180*pi;     // Degre -> Radian
Cpah.Focale:=ImgInfos.Focale;          // Metre -> mm
Cpah.PixX:=ImgInfos.PixX;              // en um
Cpah.PixY:=ImgInfos.PixY;              // en um
Cpah.DebX:=ImgInfos.X1;
Cpah.DebY:=ImgInfos.Y1;
Cpah.FinX:=ImgInfos.X2;
Cpah.FinY:=ImgInfos.Y2;
Cpah.BinningX:=ImgInfos.BinningX;
Cpah.BinningY:=ImgInfos.BinningY;
Cpah.MiroirX:=ImgInfos.MiroirX;
Cpah.MiroirY:=ImgInfos.MiroirY;
Cpah.Camera:=ImgInfos.Camera;
Cpah.Telescope:=ImgInfos.Telescope;
Cpah.Observatoire:=ImgInfos.Observatoire;
Cpah.Observateur:=ImgInfos.Observateur;
Cpah.Filtre:=ImgInfos.Filtre;
if ImgInfos.RMSGuideError<>0 then
   begin
   RMSGuideErrorStr:='/GUIDRMS='+MyFloatToStr(ImgInfos.RMSGuideError,2); //nolang
   if Length(Cpah.Filtre)+Length(RMSGuideErrorStr)<80 then
      Cpah.Filtre:=Cpah.Filtre+RMSGuideErrorStr;
   end;

Cpah.Commentaires[1]:=ImgInfos.Commentaires[1];
Cpah.Commentaires[2]:=ImgInfos.Commentaires[2];
Cpah.Commentaires[3]:=ImgInfos.Commentaires[3];
Cpah.Commentaires[4]:=ImgInfos.Commentaires[4];

Cpah.Diametre:=ImgInfos.Diametre;
Cpah.TemperatureCCD:=ImgInfos.TemperatureCCD;
Cpah.AngleCCD:=ImgInfos.OrientationCCD;
Cpah.Seeing:=ImgInfos.Seeing;

Cpah.Latitude:=Config.Lat*pi/180; // Degres -> Radians
Cpah.Longitude:=Config.Long*pi/180; // Degres -> Radians

StreamWriteFile.AddBuffer(Cpah,SizeOf(Cpah));

for i:=1 to ImgInfos.NbPlans do
   HuffmanDiffCompression(ImgInfos.Sx,ImgInfos.Sy,2,TabImgInt^[i],StreamWriteFile,nil);

finally
StreamWriteFile.Close;
end;

except
on E:EFileStreamError do raise ErrorSaveFile.Create('-1'); // nolang
end;

finally
StreamWriteFile.Free;
end;
end;

{procedure SaveCpa_finale(data:PTabImgInt; Nom:TFileName; sx,sy,min,max:integer);
 Sauvegarde en Cpa - image finale
var
i,j,nb:integer;
//Last:integer;           // Contient l'intensite precedente pour la decompression
Last:SmallInt;
ValInt16:SmallInt;
ValInt8:Byte;
Val:SmallInt;
NonComp:SmallInt;

Cpah:TEnteteCPA_Ver3;
F:file;
Buffer:PLigByte;
p:pHeader;
begin
    WriteSpy('SaveCpa : Sauvegarde finale de '+Nom);

    RazCpahV3(Cpah);

    Cpah.Largeur:=Sx;
    Cpah.Longueur:=Sy;
    Cpah.TabSeuilBas[1]:=Min;
    Cpah.TabSeuilHaut[1]:=Max;
    Cpah.TypeCompression:=1;

    Cpah.TempsDePose:=pop_camera.TpsInt;
    Cpah.TimeDate:=pop_main.CurrentTimeDate;

    Cpah.Alpha:=pop_main.IAlpha*15/180*pi;  // Heure -> Radian
    Cpah.Delta:=pop_main.IDelta/180*pi;     // Degre -> Radian

    Cpah.Focale:=config.FocaleTele; // FocaleTele est mm depuis la V2.66b

    Cpah.PixX:=config.SizePixel;
    Cpah.PixY:=config.SizePixel;

    Cpah.BinningX:=pop_camera.Binning;
    Cpah.BinningY:=pop_camera.Binning;
    Cpah.MiroirX:=config.MirrorX;
    Cpah.MiroirY:=config.MirrorY;
    case config.TypeCamera of
       Hisis2214Bits:Cpah.Camera:=lang('Hisis22 14 bits');
       Hisis2212Bits:Cpah.Camera:=lang('Hisis22 12 bits');
       Audine       :Cpah.Camera:=lang('Audine');
       ST7          :Cpah.Camera:=lang('ST7');
       ST8          :Cpah.camera:=lang('ST8');
    end;

    Cpah.Telescope:=config.Telescope;
    Cpah.Observatoire:=config.Observatoire;
    Cpah.Observateur:=config.Observateur;
    Cpah.Filtre:=config.Filtre;

    AssignFile(F,Nom);
    Rewrite(F,1);
    BlockWrite(F,Cpah,SizeOf(Cpah));

    GetMem(Buffer,10*Sx);

    for j:=1 to Sy do
       begin
       // On comprime la ligne
       Last:=data^[1]^[j]^[1];
       Move(Last,Buffer^[1],2);
       Nb:=3;
       for i:=2 to Sx do
          begin
          Val:=data^[1]^[j]^[i];
          if (Val-Last<-127) or (Val-Last>127) then
             begin
             ValInt8:=255;
             Move(ValInt8,Buffer^[Nb],1);
             Inc(Nb);
             Move(Val,Buffer^[Nb],2);
             Inc(Nb,2);
             end
          else
             begin
             ValInt16:=Val-Last+127;
             if (ValInt16>=0) and (ValInt16<=255) then ValInt8:=ValInt16
             else
                begin
                ShowMessage(lang('Depassement'));
                exit;
                end;
             Move(ValInt8,Buffer^[Nb],1);
             Inc(Nb);
             end;
          Last:=Val;
          end;
       { Si la ligne compresse est plus petite on l'ecrit
       if Nb<2*Sx then
          begin
          BlockWrite(F,Nb,2);
          BlockWrite(F,Buffer^,Nb);
          end
       else
       { Sinon on ecrit la ligne non compressee
          begin
          NonComp:=2*Sx;
          BlockWrite(F,NonComp,2);
          BlockWrite(F,data^[j]^,2*Sx);
          end;
       end;

    {PJ 14/3 rajoute un pointeur a une liste si on sauve l image finale. ca mange pas de pain
    et ca peut etre pratique pour controler en remote que le process se passe bien
    new(p);
    p.filename:=nom;
    p.sx:=cpah.Largeur;
    p.sy :=cpah.longueur;
    p.BinningX:=cpah.BinningX;
    p.BinningY :=cpah.binningy;
    p.TimeDate:=cpah.TempsDePose;
    p.MiroirX:=cpah.MiroirX;
    p.MiroirY:=cpah.miroiry;
    p.Telescope:=cpah.Telescope;
    p.Observateur:=cpah.Observateur;
    p.Camera:=cpah.Camera;
    p.filtre:=cpah.Filtre;
    p.Observatoire:=cpah.Observatoire;
    p.Focale:=cpah.Focale;
    p.Alpha:=cpah.alpha;
    p.delta:=cpah.delta;
    p.PixX:=cpah.PixX;
    p.PixY:=cpah.PixY;
    p.DebX:=cpah.DebX;
    p.DebY:=cpah.DebY;
    p.FinX:=cpah.finX;
    p.finy:=cpah.finY;
    p.TypeCompression:=cpah.TypeCompression;
    p.NombreBitsComp:=cpah.NombreBitsComp;
    p.Commentaires[1]:=cpah.commentaires[1];
    p.Commentaires[2]:=cpah.commentaires[2];
    p.Commentaires[3]:=cpah.commentaires[3];
    p.Commentaires[4]:=cpah.commentaires[4];
    list_finales.add(p);
    {voila
    CloseFile(F);
    FreeMem(Buffer,10*Sx);

end;      }



{-------------------------------------------------------------------------------

                               fichiers PIC

-------------------------------------------------------------------------------}


procedure ReadPicHeader(Nom:TFilename; var hdr: TPicHeader);
Var
f:File;
begin
   RazPic(hdr);
   AssignFile(F,Nom);
   Reset(F,1);
   BlockRead(F,hdr,290);
   Close(F);
end;



{ Initialisation des parametres du Header PIC }
procedure RazPic(var Pich:TPicHeader);
begin
With Pich do
   begin
   Signature:=$FC;
   Version:=$31;
   Headersize:=290;
   Nom:='                                '; //nolang
   Nomsuivant:='                                '; //nolang
   sx:=0;
   sy:=0;
   Dimdonnees:=2;
   Typedonnees:=1;
   Reserve:=0;
   Camera:=0;
   X1:=0;
   Y1:=0;
   X2:=0;
   Y2:=0;
   BinX:=1;
   BinY:=1;
   NBPlans:=0;
   Date:='          '; //nolang
   Heure:='              '; //nolang
   Max:=0;
   min:=0;
   fracMax:=0;
   fracmin:=0;
   TpsInt:=0;
   Comm1:='                                                                                '; //nolang
   Comm2:='                                                                                '; //nolang
   end;
end;


procedure ReadPic(Nom:TFileName;
                  var TabImgInt:PTabImgInt;
                  var ImgInfos:TImgInfos);
var
Charge:Boolean;
F:file;
i,nb:integer;
Pich:TPicHeader;
begin
Charge:=True;

ImgInfos.BZero:=0;
ImgInfos.BScale:=1;

WriteSpy(lang('ReadPic : Lecture de ')+Nom);

AssignFile(F,Nom);
Reset(F,1);
BlockRead(F,Pich,SizeOf(Pich));
CloseFile(F);

if Pich.Signature<>$FC then
begin
     MessageDlg(lang('Ce fichier n''est certainement pas une image PIC !'),mtError,[mbOK],0);
     exit;
end;

if Charge then
   begin
   AssignFile(F,Nom);
   Reset(F,1);
   BlockRead(F,Pich,SizeOf(Pich));
   ImgInfos.Sx:=Pich.Sx;
   ImgInfos.Sy:=Pich.Sy;
   ImgInfos.NbPlans:=1;
   ImgInfos.TypeData:=2;

   // Stockages des autres infos
   InitImgInfos(ImgInfos);
   with ImgInfos do
      begin

      Max[1]:=Pich.Max;
      Min[1]:=Pich.Min;
      try
      DateTime:=MyStrToDate(Pich.Date)+StrToHeure(Pich.Heure);
      except
      DateTime:=0;
      end;
      FileName:=Nom;
      BinningX:=Pich.BinX;
      BinningY:=Pich.BinY;
      X1:=Pich.X1;
      Y1:=Pich.Y1;
      X2:=Pich.X2;
      Y2:=Pich.Y2;
      Commentaires[1]:=Pich.Comm1;
      Commentaires[2]:=Pich.Comm2;
      TempsPose:=Pich.TpsInt; // Pas de conversion ms -> ms
      end;

   Getmem(TabImgInt,4);
   Getmem(TabImgInt^[1],ImgInfos.Sy*4);
   for i:=1 to ImgInfos.Sy do
      begin
      Getmem(TabImgInt^[1]^[i],ImgInfos.Sx*2);
      BlockRead(F,TabImgInt^[1]^[i]^,ImgInfos.Sx*2,nb);
      end;

   CloseFile(F);
   pop_main.SeuilsEnable;
   end;
end;

procedure SavePic(Nom:TFileName;
                  TabImgInt:PTabImgInt;
                  ImgInfos:TImgInfos);
var
Pich:TPICHeader;
F:file;
i:Integer;
Tmp:String;
begin
WriteSpy(lang('SavePic : Sauvegarde de ')+Nom);
RazPic(Pich);

Pich.Sx:=ImgInfos.Sx;
Pich.Sy:=ImgInfos.Sy;
Pich.Max:=Round(ImgInfos.Max[1]);
Pich.Min:=Round(ImgInfos.Min[1]);
Tmp:=' '+DateToStrSlash(ImgInfos.DateTime)+' ';
for i:=1 to 10 do Pich.Date[i]:=Tmp[i];
Tmp:=' '+TimeToStrExtend(ImgInfos.DateTime)+' ';
for i:=1 to 14 do Pich.Heure[i]:=Tmp[i];
Pich.TpsInt:=ImgInfos.TempsPose; // Pas de conversion ms -> ms
Pich.BinX:=ImgInfos.BinningX;
Pich.BinY:=ImgInfos.BinningY;
Pich.X1:=ImgInfos.X1;
Pich.Y1:=ImgInfos.Y1;
Pich.X2:=ImgInfos.X2;
Pich.Y2:=ImgInfos.Y2;
for i:=1 to 80 do Pich.Comm1[i]:=ImgInfos.Commentaires[1][i];
for i:=1 to 80 do Pich.Comm2[i]:=ImgInfos.Commentaires[2][i];

Pich.Signature:=$FC;
Pich.Version:=$31;
Pich.HeaderSize:=290;
Pich.NBPlans:=1;
{ On met a jour les champs type de donnee }
Pich.DimDonnees:=16;
Pich.TypeDonnees:=3;

AssignFile(F,Nom);
Rewrite(F,1);
BlockWrite(F,Pich,SizeOf(Pich));

for i:=1 to ImgInfos.Sy do BlockWrite(F,TabImgInt^[1]^[i]^,ImgInfos.Sx*2);

CloseFile(F);
end;

{-------------------------------------------------------------------------------

                             Routines FITS

--------------------------------------------------------------------------------}

{INVERT : trasnformation BIG-> SMALL endian
 REVERT : inverse}

{16 bit entiers}
function InvertI16(X : word) : smallInt;
var  P : PbyteArray;
     temp : word;
begin
    P:=@X;
    temp:=(P[0] shl 8) or (P[1]);
    move(temp,result,2);
end;

function RevertI16(x:word) : smallint;
begin
    result:=swap(x);
end;

{32 bit entiers}
function InvertI32(X : LongWord) : LongInt;
var  P : PbyteArray;
begin
    P:=@X;
    result:=(P[0] shl 24) or (P[1] shl 16) or (P[2] shl 8) or (P[3]);
end;

function revertI32(x:LongInt) : Longword;
var p:pbytearray;
begin
    P:=@X;
    result:=(P[0] shl 24) or (P[1] shl 16) or (P[2] shl 8) or (P[3]);
end;

{32 bit flottant}
function InvertF32(X : LongWord) : Single;
var  P : PbyteArray;
     temp : LongWord;
begin
    P:=@X;
    if (P[0]=$7F)or(P[0]=$FF) then result:=0   // IEEE-754 NaN
    else begin
    temp:=(P[0] shl 24) or (P[1] shl 16) or (P[2] shl 8) or (P[3]);
    move(temp,result,4);
    end;
end;

function revertF32(x:single):longword;
var p:PByteArray;
    temp:longword;
begin
    P:=@X;
    temp:=(P[0] shl 24) or (P[1] shl 16) or (P[2] shl 8) or (P[3]);
    move(temp,result,4);
end;

{64 bit entiers}
function InvertI64(X : Int64) : Int64;
var  P : PbyteArray;
begin
    P:=@X;
    result:=4294967296 * ((P[0] shl 24) or (P[1] shl 16) or (P[2] shl 8) or (P[3])) + ((P[4] shl 24) or (P[5] shl 16) or (P[6] shl 8) or (P[7]));
end;

function RevertI64(X : Int64) : Int64;
var  P : PbyteArray;

begin
    P:=@X;
    result:=4294967296 * ((P[0] shl 24) or (P[1] shl 16) or (P[2] shl 8) or (P[3])) + ((P[4] shl 24) or (P[5] shl 16) or (P[6] shl 8) or (P[7]));
end;

{64 bit flottant}
function InvertF64(X : Int64) : Double;
var  P : PbyteArray;
     temp : Int64;
begin
    P:=@X;
    if (P[0]=$7F)or(P[0]=$FF) then result:=0   // IEEE-754 NaN
    else begin
    temp:=4294967296 * ((P[0] shl 24) or (P[1] shl 16) or (P[2] shl 8) or (P[3])) + ((P[4] shl 24) or (P[5] shl 16) or (P[6] shl 8) or (P[7]));
    move(temp,result,8);
    end;
end;

function Revert64F(X : Double) : Int64;
var  P : PbyteArray;
      temp : Int64;
begin
     P:=@X;
     temp:=4294967296 * ((P[0] shl 24) or (P[1] shl 16) or (P[2] shl 8) or
     (P[3])) + ((P[4] shl 24) or (P[5] shl 16) or (P[6] shl 8) or (P[7]));
     move(temp,result,8);
end;

{function ReadFITSHeader(Nom:TFileName;
//                        var p:PFITSHEADER;
                        var offset:integer;
                        var total:byte;
                        var ImgInfos:TImgInfos):boolean;
var
f:file;
Keywordc:array[1..8] of Char; }       { Pour la lecture des mots clefs }
//KeyWord:string;                      { Pour le traitement des mots clef }
//Argc:array[1..72] of Char;           { Pour la lecture des champs des mots clefs }
//Arg,ArgTemp:string;                          { Pour le traitement des champs des mots clefs }
//PosComment:Longint;                  { Position du commentaire des mots clef }
{NbLignes,Nb:Integer;
numkeywords:integer;
added:boolean;
oblig,tmp:byte;
begin
   result:=true;
   total:=0;
   numkeywords:=0;
//   new(p); // on cree le pointeur d entree si numkeywords est zero on dispose
   AssignFile(F,Nom);
   Reset(F,1);
   NBLignes:=0;
   While trim(Keyword)<>'END' do //nolang
   begin
      BlockRead(F,KeyWordc,8);
      KeyWord:=KeyWordc;
      BlockRead(F,Argc,72);
      Arg:=Argc;
      Inc(NbLignes);

      Nb:=CountNb('/',Arg);

      if Nb<2 then
         begin
         PosComment:=Pos('/',Arg);
         if PosComment>0 then Arg:=Trim(Copy(Arg,1,PosComment-1));
         end
      else
      if Nb=3 then
         begin
         ArgTemp:='';
         PosComment:=Pos('/',Arg);
         while PosComment>0 do
            begin
            ArgTemp:=ArgTemp+Trim(Copy(Arg,1,PosComment));
            Delete(Arg,1,PosComment);
            PosComment:=Pos('/',Arg);
            end;
         Arg:=ArgTemp;
         end
      else
      if Nb=2 then
         begin
         ArgTemp:='';
         PosComment:=Pos('/',Arg);
         while PosComment>0 do
            begin
            ArgTemp:=ArgTemp+Trim(Copy(Arg,1,PosComment));
            Delete(Arg,1,PosComment);
            PosComment:=Pos('/',Arg);
            end;
         ArgTemp:=ArgTemp+Trim(Arg);
         Arg:=ArgTemp;
         end;
      if Arg='' then Arg:='           '; //nolang
      if Arg[1]='=' then Arg:=Trim(Copy(Arg,2,Length(Arg)-1));
      if Arg='' then Arg:='           '; //nolang
      tmp:=length(arg)-1;
      if (Arg[1]='''') and (tmp>0) then Arg:=Trim(Copy(Arg,2,Length(Arg)-1)); //nolang
      if Arg[Length(Arg)]='''' then Arg:=Trim(Copy(Arg,1,Length(Arg)-1)); //nolang

//      on verifie le keyword
      if is_keyword_ok(trim(keyword)) then
      begin
//           added:=AddKeyword(p,trim(keyword),trim(arg),oblig,ImgInfos);
           added:=AddKeyword(trim(keyword),trim(arg),oblig,ImgInfos);
           total:=total+oblig;
           if added then inc(numkeywords)
      end;
   end;
   if numkeywords=0 then
   begin
        result:=false;
        exit;
   end;
//    On calcule la longueur de l'entete Fits
   Offset:=(((NbLignes*80) div 2880)+1)*2880;   // l'entete est toujours multiple de 2880
   Close(F);
end;}

function ReadFITSHeader(Nom:TFileName;
                        var Offset:integer;
                        var ImgInfos:TImgInfos):boolean;
var f : file;
    fhb : Tfitsheaderblock;
    endh,first,stringopen,stringval : boolean;
    i,j,n,NbBlock : integer;
    added:boolean;
    key, val : string;
begin
try
result:=false;
assignfile(f,Nom);
reset(f,1);
endh := false;
first := true;
NbBlock:=0;
for i:=0 to fitsnuminf do fitspriority[i]:=255;
repeat
  BlockRead(f,fhb,sizeof(Tfitsheaderblock),n);
  inc(NbBlock);
  if n=sizeof(Tfitsheaderblock) then for i:=1 to 36 do begin
    key:=trim(fhb[i].key);
    stringopen:=false;
    stringval:=false;
    if first then begin
       first:=false;
       if (key<>'SIMPLE') then begin        // SIMPLE //nolang
         endh:=true;
         result:=false;
         break;
       end;
    end;
    if key='END' then begin                 // END //nolang
       endh:=true;
       result:=true;
       break;
    end;
    if copy(fhb[i].val,1,2)='= ' then begin // keyword = value //nolang
      val:='';
      j:=3;
      repeat
        if fhb[i].val[j]='''' then begin                // traitement quote //nolang
           if stringopen then begin                      // si dans un string
              if (j<72)and(fhb[i].val[j+1]='''') then begin  // double quote = quote //nolang
                 val:=val+''''; //nolang
                 inc(j,2);
                 continue;
              end else begin                                 // fin du string
                  stringopen:=false;
                  stringval:=true;
                  break;                                     // on va pas voir plus loin
              end;
           end else begin
                  stringopen:=true;                    // sinon debut du string
                  val:='';                             // on ignore les caracteres precedants
           end;
        end else if fhb[i].val[j]='/' then begin       // traitement commentaire
           if stringopen then val:=val+fhb[i].val[j]     // si dans string -> normal
                         else break;                     // sinon debut comment on arrete
        end else val:=val+fhb[i].val[j];               // traitement caractere normal
        inc(j);
      until j>72;
      if stringval then added:=AddKeyword(key,val,ImgInfos) // preserve les espaces dans les strings
         else begin
           val:=trim(val);                                     // mais pas pour les nombres ou logic
           if val>'' then added:=AddKeyword(key,val,ImgInfos) // n'insert pas les valeurs nul
       end;
    end else begin                         // commentaire
      if key='' then key:='COMMENT'; //nolang
      val:=TrimRight(fhb[i].val);            // preserve l'allignement
      added:=AddKeyword(key,val,ImgInfos);
    end;
  end;
until endh or eof(f);
Offset:=NbBlock*sizeof(Tfitsheaderblock);   // l'entete est toujours multiple de 2880
closefile(f);
except
 result:=false;
end;
end;

procedure ReadFitsHeaderRaw(f:string; var liste:tlist);
var
p:p_string_item;
Keywordc:Array[1..8] of Char;        { Pour la lecture des mots clefs }
KeyWord:String;                      { Pour le traitement des mots clef }
Argc:Array[1..72] of Char;           { Pour la lecture des champs des mots clefs }
Arg:String;                          { Pour le traitement des champs des mots clefs }
NbLignes:Integer;
fi:file;
begin
   AssignFile(Fi,f);
   Reset(Fi,1);
   NBLignes:=0;
   While Keyword<>'END     ' do //nolang
      begin
      BlockRead(Fi,KeyWordc,8);
      KeyWord:=KeyWordc;
      BlockRead(Fi,Argc,72);
      Arg:=Argc;
      Inc(NbLignes);
      new(p);
      p.str:=keyword+arg;
      liste.add(p);
   end;
   Close(Fi);
end;


function DateToStrFITS(DateTime:TDateTime):string;
var
Year,Month,Day:word;
SYear,SMonth,SDay:String;
begin
DecodeDate(DateTime,Year,Month,Day);

if Month<10 then SMonth:='0'+IntToStr(Month) else SMonth:=IntToStr(Month);
if Day<10 then SDay:='0'+IntToStr(Day) else SDay:=IntToStr(Day);
SYear:=IntToStr(Year);
if length(syear)=2 then syear:='19'+syear; //nolang
Result:=syear+'-'+SMonth+'-'+SDay;
end;


{TeleAuto FITS Format :
SIMPLE  T
BITPIX  16
NAXIS   2
NAXIS1  768
NAXIS2  512
DATE-OBS '2000-12-31T00:12:31.12'
JDAY
OBSERVER
SITELAT
SITELONG string
EXPOSURE en secondes
TELESCOP
INSTRUME
CDELTM1 pixel size
CDELTM2
BINX    binning
BINY
CRVAL1  AD  radians
CRVAL2  DEC radians
FILTERS
MIRRORX T or F
MIRRORY T or F
FOCLEN  en metres
WINDOW  windowing 1,768,1,512
DATAMAX
DATAMIN
TEMP    temperature
PLATE   constantes de plaque
COMMENT
END
}

function AjouteEspacesDevant(Nom:string;NbCaracteres:Byte):string;
begin
while Length(Nom)<>NbCaracteres do Nom:=' '+Nom;
Result:=Nom;
end;

procedure SaveFITS(Nom:TFileName;
                   var DataInt:PTabImgInt;
                   var DataDouble:PTabImgDouble;
                   Plan,NPlan:Integer;  // Plan = premier plan d'image a sauver, Nplan = nombre de plan a sauver.
                   ImgInfos:TImgInfos);
var
   fitsfile : file;
   i,j,k,n  : integer;
   NbLines  : Integer;
   s        : shortstring;
   Tmp,dttm : string;
   LigWord  : PLigWord;
   LigDouble  : PLigDouble;
   LineTmp  : array[1..80] of Char;
   SaveDecimalSeparator:Char;
   Val64:array[1..8] of Byte;           { Variable de transtypage pour les 64 bits }
   TmpVal:Byte;

procedure WriteLine(Line:string);
var
LineTmp:array[1..80] of Char;
i:Integer;
begin
for i:=1 to 80 do LineTmp[i]:=#20;
for i:=1 to 80 do if i<=Length(Line) then LineTmp[i]:=Line[i];
BlockWrite(FitsFile,LineTmp,80);
end;

begin
WriteSpy(lang('SaveFits : Sauvegarde de ')+Nom);

// Dans le FITS il faut des points uniquement
SaveDecimalSeparator:=DecimalSeparator;
DecimalSeparator:='.';

Getmem(LigWord,2*ImgInfos.Sx);
Getmem(LigDouble,8*ImgInfos.Sx);
try
AssignFile(FitsFile,Nom);
try
Rewrite(FitsFile,1);

NbLines:=1;
s:='SIMPLE  =                    T / File conforms with FITS standards'; //nolang
WriteLine(s); Inc(NbLines);

case ImgInfos.TypeData of
   2,7:begin
     s:='BITPIX  =                   16 / Bits'; //nolang
     WriteLine(s); Inc(NbLines);
     end;
   5,6,8:begin
     s:='BITPIX  =                  -64 / Bits'; //nolang
     WriteLine(s); Inc(NbLines);
     end;
   end;

if NPlan=1 then s:='NAXIS   =                    2 / Number of axes'  //nolang
           else s:='NAXIS   =                    3 / Number of axes'; //nolang
WriteLine(s); Inc(NbLines);

s:='NAXIS1  ='+AjouteEspacesDevant(inttostr(ImgInfos.Sx),21)+' / Axis X'; //nolang
WriteLine(s); Inc(NbLines);

s:='NAXIS2  ='+AjouteEspacesDevant(inttostr(ImgInfos.Sy),21)+' / Axis Y'; //nolang
WriteLine(s); Inc(NbLines);

if NPlan>1 then begin

   s:='NAXIS3  ='+AjouteEspacesDevant(inttostr(NPlan),21)+' / Number of image plane'; //nolang
   WriteLine(s); Inc(NbLines);

   if NPlan=3 then
      begin
      s:='CTYPE3  = ''RGB     ''           / RGB color image R=1 G=2 B=3 '; //nolang
      WriteLine(s); Inc(NbLines);
      end;
end;

//     tmp:=timetostr(ImgInfos.DateTime);
//     dttm:=datetostrfits(ImgInfos.DateTime);
//     dttm:=dttm+'T'+tmp;
// date a la milliseconde
dttm:=formatdatetime(datetimeFITS,ImgInfos.DateTime);
s:='DATE-OBS= '''+dttm+''' / UT Date of Observation' ; //nolang
WriteLine(s); Inc(NbLines);

s:='JDAY    = '+floattostrf(heuretojourjulien(ImgInfos.datetime),fffixed,15,6)+ //nolang
              ' / Julian Day (UTC)'; //nolang
WriteLine(s); Inc(NbLines);

s:='OBSERVER= '''+ImgInfos.Observateur+'''' ; //nolang
WriteLine(s); Inc(NbLines);

s:='SITELAT = '+lat2string(ImgInfos.Lat); //nolang
WriteLine(s); Inc(NbLines);
s:='SITELONG= '+long2string(ImgInfos.Long); //nolang
WriteLine(s); Inc(NbLines);
     
s:='EXPOSURE= '+floattostrf(ImgInfos.TempsPose/1000,fffixed,15,6); // Conversion de millisecondes en secondes ! //nolang
WriteLine(s); Inc(NbLines);

if ImgInfos.TypeData=5 then ImgInfos.BZero:=0;     
s:='BZERO   = '+floattostrf(ImgInfos.BZero,fffixed,15,7); //nolang
WriteLine(s); Inc(NbLines);

if ImgInfos.BScale=0 then ImgInfos.BScale:=1;
s:='BSCALE  = '+floattostrf(ImgInfos.BScale,fffixed,15,7); //nolang
WriteLine(s); Inc(NbLines);

s:='TELESCOP= '''+ImgInfos.Telescope+'''' ; //nolang
WriteLine(s); Inc(NbLines);

s:='INSTRUME= '''+ImgInfos.Camera+'''' ; //nolang
WriteLine(s); Inc(NbLines);

s:='OBSERVAT= '''+ImgInfos.Observatoire+'''' ; //nolang
WriteLine(s); Inc(NbLines);

s:='CDELTM1 = '+MyFloatToStr(ImgInfos.PixX/1000,5); //nolang
WriteLine(s); Inc(NbLines);

s:='CDELTM2 = '+MyFloatToStr(ImgInfos.PixY/1000,5); //nolang
WriteLine(s); Inc(NbLines);

s:='BINX    = '+inttostr(ImgInfos.BinningX); //nolang
WriteLine(s); Inc(NbLines);

s:='BINY    = '+inttostr(ImgInfos.BinningY); //nolang
WriteLine(s); Inc(NbLines);

s:='CRVAL1  = '+floattostrf(ImgInfos.Alpha*15,fffixed,15,7); //nolang // Heure -> Degres
WriteLine(s); Inc(NbLines);

S:='CRVAL2  = '+floattostrf(ImgInfos.Delta,fffixed,15,7); //nolang
WriteLine(s); Inc(NbLines);

s:='FILTERS = '''+ImgInfos.Filtre+''''; //nolang
WriteLine(s); Inc(NbLines);

if ImgInfos.MiroirX = true then tmp:='T' else tmp:='F';
s:='MIRRORX = '+tmp; //nolang
WriteLine(s); Inc(NbLines);

if ImgInfos.MiroirY = true then tmp:='T' else tmp:='F';
s:='MIRRORY = '+tmp; //nolang
WriteLine(s); Inc(NbLines);

s:='FOCLEN  = '+floattostrf(ImgInfos.Focale/1000,fffixed,15,2); // mm -> m //nolang
WriteLine(s); Inc(NbLines);

//     s:='WINDOW  = '+inttostr(pop_camera.x1)+' '+inttostr(pop_camera.y1)+
//                   ' '+inttostr(pop_camera.x2)+' '+inttostr(pop_camera.y2);
//                 move(s[1],header[i,1],length(s));inc(i);
s:='DATAMAX = '+inttostr(Round(ImgInfos.max[1])); //nolang
WriteLine(s); Inc(NbLines);

s:='MIPS-HI = '+inttostr(Round(ImgInfos.max[1])); //nolang
WriteLine(s); Inc(i);

s:='THRESH  = '+inttostr(Round(ImgInfos.max[1])); //nolang
WriteLine(s); Inc(NbLines);

s:='DATAMIN = '+inttostr(Round(ImgInfos.min[1])); //nolang
WriteLine(s); Inc(NbLines);

s:='MIPS-LO = '+inttostr(Round(ImgInfos.min[1])); //nolang
WriteLine(s); Inc(NbLines);

s:='THRESL  = '+inttostr(Round(ImgInfos.min[1])); //nolang
WriteLine(s); Inc(NbLines);

s:='X1      = '+inttostr(ImgInfos.X1); //nolang
WriteLine(s); Inc(NbLines);

s:='Y1      = '+inttostr(ImgInfos.Y1); //nolang
WriteLine(s); Inc(NbLines);

s:='X2      = '+inttostr(ImgInfos.X2); //nolang
WriteLine(s); Inc(NbLines);

s:='Y2      = '+inttostr(ImgInfos.Y2); //nolang
WriteLine(s); Inc(NbLines);

s:='DIAMETER= '+floattostrf(ImgInfos.Diametre,fffixed,15,2)+' / Telescope diameter in mm'; //nolang
WriteLine(s); Inc(NbLines);

s:='TEMP    = '+floattostrf(ImgInfos.TemperatureCCD,fffixed,15,2)+' / CCD temperature in degrees'; //nolang
WriteLine(s); Inc(NbLines);

s:='ORIENT  = '+floattostrf(ImgInfos.OrientationCCD,fffixed,15,2)+' / CCD orientation in degrees'; //nolang
WriteLine(s); Inc(NbLines);

s:='SEEING  = '+floattostrf(ImgInfos.Seeing,fffixed,15,2)+' / Seeing in arcsec'; //nolang
WriteLine(s); Inc(NbLines);

s:='GUIDERMS= '+floattostrf(ImgInfos.RMSGuideError,fffixed,15,2)+' / Guiding RMS error in arcsec'; //nolang
WriteLine(s); Inc(NbLines);

// A ajouter dans ImfInfos
//     if (config.temperature>-50) and (config.temperature<30) then
//     tmp:=floattostrf(config.temperature,fffixed,10,0) else tmp:='?';
//     s:='TEMP    =                  '+tmp;
//                 move(s[1],header[i,1],length(s));inc(i);
//     s:='PLATE   = / Plate Constants';
//                 move(s[1],header[i,1],length(s));inc(i);

if ImgInfos.Commentaires[1]<>'' then
   begin
   s:='COMMENT   '+ImgInfos.Commentaires[1]; //nolang
   WriteLine(s); Inc(NbLines);
   end;
if ImgInfos.Commentaires[2]<>'' then
   begin
   s:='COMMENT   '+ImgInfos.Commentaires[2]; //nolang
   WriteLine(s); Inc(NbLines);
   end;
if ImgInfos.Commentaires[3]<>'' then
   begin
   s:='COMMENT   '+ImgInfos.Commentaires[3]; //nolang
   WriteLine(s); Inc(NbLines);
   end;
if ImgInfos.Commentaires[4]<>'' then
   begin
   s:='COMMENT   '+ImgInfos.Commentaires[4]; //nolang
   WriteLine(s); Inc(NbLines);
   end;

s:='END      ' ; //nolang
WriteLine(s); Inc(NbLines);

// Finir le bloc de 2880 = 36 lignes
j:=36-(NbLines mod 36);
//     j:=((i div 36)+1)*36;
s:='      ' ; //nolang
//     SetLength(LineTmp,80);
for k:=1 to 80 do LineTmp[k]:=' ';
for k:=1 to j do BlockWrite(FitsFile,LineTmp,80);
//        WriteLine(s);

case ImgInfos.TypeData of
   2,7:for k:=Plan to Plan+NPlan-1 do //bruno
//   2,7:for k:=1 to ImgInfos.NbPlans do
        for j:=1 to ImgInfos.Sy do
           begin
           for i:=1 to ImgInfos.Sx do
              begin
//              LigWord^[i]:=DataInt^[Plan+k-1]^[j]^[i];
//              LigWord^[i]:=DataInt^[Plan]^[j]^[i];
              LigWord^[i]:=DataInt^[k]^[j]^[i];
              LigWord^[i]:=Swap(LigWord^[i]);
              end;
           BlockWrite(FitsFile,LigWord^,ImgInfos.Sx*2);
           end;
   5,6,8:for k:=Plan to Plan+NPlan-1 do      //bruno
//   5,6,8:for k:=1 to ImgInfos.NbPlans do
        for j:=1 to ImgInfos.Sy do
           begin
           for i:=1 to ImgInfos.Sx do
              begin
//              LigDouble^[i]:=DataDouble^[Plan+k-1]^[j]^[i];
//              LigDouble^[i]:=DataDouble^[Plan]^[j]^[i];
              LigDouble^[i]:=DataDouble^[k]^[j]^[i];
              Move(LigDouble^[i],Val64,8);
              TmpVal:=Val64[1]; Val64[1]:=Val64[8]; Val64[8]:=TmpVal;
              TmpVal:=Val64[2]; Val64[2]:=Val64[7]; Val64[7]:=TmpVal;
              TmpVal:=Val64[3]; Val64[3]:=Val64[6]; Val64[6]:=TmpVal;
              TmpVal:=Val64[4]; Val64[4]:=Val64[5]; Val64[5]:=TmpVal;
              Move(Val64,LigDouble^[i],8);
              end;
           BlockWrite(FitsFile,LigDouble^,ImgInfos.Sx*8);
           end;
   end;

case ImgInfos.TypeData of
   2,7:begin
     n:=1440-(2*ImgInfos.NbPlans*ImgInfos.Sx*ImgInfos.Sy) mod 1440;     // il faut terminer un bloc de 2880
     LigWord^[1]:=0;
     for i:=1 to n do BlockWrite(FitsFile,LigWord^[1],2);
     end;
   5,6,8:begin
     n:=1440-(8*ImgInfos.NbPlans*ImgInfos.Sx*ImgInfos.Sy) mod 1440;     // il faut terminer un bloc de 2880
     LigDouble^[1]:=0;
     for i:=1 to n do BlockWrite(FitsFile,LigDouble^[1],8);
     end;
   end;

finally
CloseFile(FitsFile);
end;
finally
Freemem(LigWord,2*ImgInfos.Sx);
Freemem(LigDouble,8*ImgInfos.Sx);
DecimalSeparator:=SaveDecimalSeparator;
end;
end;

function ConvDMS(dms : string):double;
var p,s : integer;
const b=' '; //nolang
begin
// OBJCTRA = '19 44 48.150      '
dms:=trim(dms);
result:=0;
p:=pos(b,dms);
if p>0 then result:=MyStrToFloat(copy(dms,1,p-1));
if result >= 0 then s:=1 else s:=-1;
delete(dms,1,p);
p:=pos(b,dms);
if p>0 then result:=result+s*MyStrToFloat(copy(dms,1,p-1))/60;
delete(dms,1,p);
result:=result+s*MyStrToFloat(copy(dms,1,p-1))/3600;
end;

function AddKeyword(Keyword, argument :string;
                     var ImgInfos:TImgInfos):boolean;
var
   i,n :Integer;
begin
result:=true;
n:=0;
for i:=1 to fitsnumkeyword do
    if keyword=fitskeyword[i].nom then begin
       n:=i;
       break;
    end;
if n=0 then Exit;
case fitskeyword[n].seq of
  1  :    begin  //BITPIX
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.BitPix:=STrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  2  :    begin  //NAXIS
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.NbAxes:=StrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  3  :    begin  //NAXIS1
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Sx:=StrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  4  :    begin  //NAXIS2
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Sy:=StrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  5  :    begin  //NAXIS3
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.NbPlans:=StrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  6  :    begin  //DATE-OBS
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.DateTime:=StrToDateFITS(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
              if frac(ImgInfos.DateTime)>0 then fitspriority[fitskeyword[52].inf]:=fitskeyword[n].pri;
            end;
          end;
  7  :    begin  //BZERO
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
//              ImgInfos.BZero:=Round(MyStrToFloat(argument));  // Ca va pas la tete ?
              ImgInfos.BZero:=MyStrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  8  :    begin  //BSCALE
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
//              ImgInfos.BScale:=Round(MyStrToFloat(argument)); // Ca va pas la tete ?
              ImgInfos.BScale:=MyStrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  9  :    begin  //OBSERVER
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Observateur:=argument;
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  10 :    begin  //EXPOSURE
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.TempsPose:=Round(MyStrToFloat(argument)*1000); // secondes -> millisecondes
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  11 :    begin  //TELESCOP
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Telescope:=argument;
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  12 :    begin  //INSTRUME
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Camera:=argument;
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  13 :    begin  //CDELTM1
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.PixX:=MyStrToFloat(argument)*1000; // mm -> um
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  14 :    begin  //CDELTM2
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.PixY:=MyStrToFloat(argument)*1000; // mm -> um
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  15 :    begin  //BINX
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.BinningX:=StrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  16 :    begin  //BINY
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.BinningY:=StrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  17 :    begin  //CRVAL1
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Alpha:=MyStrToFloat(argument)/15; // Degres -> Heures
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  18 :    begin  //CRVAL2
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Delta:=MyStrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  19 :    begin  //FILTER
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Filtre:=argument;
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  20,21:  begin //MIRRORX MIRORX
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.MiroirX:=argument='T';
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  22,23:  begin //MIRRORY MIRORY
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.MiroirY:=argument='T';
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  24 :    begin  //FOCLEN
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Focale:=MyStrToFloat(argument)*1000; // m -> mm
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  25 :    begin  //WINDOW
       // x1:=copy(argument,1,pos(argument,'s')); delete();
          end;
  26 :    begin  //DATAMAX
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Max[1]:=MySTrToFloat(argument);
              ImgInfos.Max[2]:=ImgInfos.Max[1];
              ImgInfos.Max[3]:=ImgInfos.Max[1];
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  27 :    begin  //DATAMIN
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Min[1]:=MySTrToFloat(argument);
              ImgInfos.Min[2]:=ImgInfos.Min[1];
              ImgInfos.Min[3]:=ImgInfos.Min[1];
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  28 :    begin
                // les constantes de plaque
          end;
  29 :    begin //COMMENT
          i:=1;
          while ImgInfos.Commentaires[i]<>'' do inc(i);
          if i<=4 then ImgInfos.Commentaires[i]:=argument;
          end;
// compatibilite avec d autres progs
  30 :    begin  //RA
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Alpha:=MyStrToFloat(argument)/15; // Degrés -> Heures
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  31 :    begin  //DEC
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Delta:=MyStrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  32 :    begin //MIPS-HI
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Max[1]:=MySTrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  33 :    begin  //MIPS-LO
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Min[1]:=MySTrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  34 :    begin  //THRESH
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Max[1]:=MySTrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  35 :    begin  //TRESL
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Min[1]:=MySTrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  36 :    begin  //MIPS-X1
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.X1:=StrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  37 :    begin  //MIPS-Y1
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Y1:=StrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  38 :    begin  //MIPS-X2
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.X2:=StrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  39 :    begin  //MIPS-Y2
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Y2:=StrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  40 :    begin  //X1
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.X1:=StrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  41 :    begin  //Y1
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Y1:=StrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  42 :    begin  //X2
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.X2:=StrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  43 :    begin  //Y2
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Y2:=StrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  44 :    begin  //MIPS-BIX
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.BinningX:=StrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  45 :    begin  //MIPS-BIY
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.BinningY:=StrToInt(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  46 :    begin  //FOCAL
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Focale:=MyStrToFloat(argument)/1000; // m -> mm
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  47 :    begin  //TIME-OBS
          {p.date_obs:=p.date_obs+'T'+argument;
          try
          ImgInfos.DateTime:=StrToDateFITS(p.date_obs);
          except
          end}
          end;
  48 :    begin  //DIAMETER
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Diametre:=MyStrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  49 :    begin  //TEMP
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.TemperatureCCD:=MyStrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  50 :    begin  //ORIENT
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.OrientationCCD:=MyStrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  51 :    begin  //SEEING
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Seeing:=MyStrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  52  :    begin  //UT
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.DateTime:=ImgInfos.DateTime+StrToDateFITS('1899-12-30T'+argument); //nolang
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  53 :    begin  //CROTA2
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.OrientationCCD:=MyStrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  54 :    begin  //XPIXELSZ
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.PixX:=MyStrToFloat(argument); // deja en um
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  55 :    begin  //YPIXELSZ
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.PixY:=MyStrToFloat(argument); // deja en um
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  56 :    begin  //AMDX1
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Focale:=206.27/MyStrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  57 :    begin  //SUBSAMP
          //  if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.PixX:=ImgInfos.PixX*StrToInt(argument);
              ImgInfos.PixY:=ImgInfos.PixX;
          //    fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
          //  end;
          end;
  58 :    begin  //CDELT1  temporaire  -> focale +pixsize
            if fitskeyword[n].pri<=fitspriority[fitskeyword[56].inf] then begin
              ImgInfos.Focale:=1; //arbitrairement 1m de focale
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.PixX:=tan(degtorad(abs(MyStrToFloat(argument))))*1000*1000; //  -> um
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  59 :    begin  //CDELT2  temporaire -> focale +pixsize
            if fitskeyword[n].pri<=fitspriority[fitskeyword[56].inf] then begin
              ImgInfos.Focale:=1; //arbitrairement 1m de focale
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.PixY:=tan(degtorad(abs(MyStrToFloat(argument))))*1000*1000; //  -> um
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  60 :    begin  //OBJCTRA
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
//              ImgInfos.Alpha:=ConvDMS(argument)/15; // Degrés -> Heures
              ImgInfos.Alpha:=ConvDMS(argument); // Deja en heure dans CCDSoft
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  61 :    begin  //OBJCTDEC
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Delta:=ConvDMS(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  62 :    begin  //GUIDERMS
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.RMSGuideError:=MyStrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  63 :    begin  //OBSERVAT
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Observatoire:=argument;
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  64 :    begin  //FOCALLEN
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Focale:=MyStrToFloat(argument); // mm
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  65 :    begin  //APTDIA
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.Diametre:=MyStrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  66 :    begin  //XPIXSZ
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.PixX:=MyStrToFloat(argument); // um
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  67 :    begin  //YPIXSZ
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.PixY:=MyStrToFloat(argument); // um
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  68 :    begin  //CCD-TEMP
            if fitskeyword[n].pri<=fitspriority[fitskeyword[n].inf] then begin
              ImgInfos.TemperatureCCD:=MyStrToFloat(argument);
              fitspriority[fitskeyword[n].inf]:=fitskeyword[n].pri;
            end;
          end;
  else result:=false;
end;
end;

//function AddKeyword(p:PfitsHeader;
//                     keyword, argument :string;
{function AddKeyword(Keyword, argument :string;
                     var oblig:byte;
                     var ImgInfos:TImgInfos):boolean;
var
i:Integer;
begin
     result:=true;
     oblig:=0;
       // TeleAuto
//       if keyword='SIMPLE' then p.simple:=argument //nolang
       if (keyword='BITPIX'  ) then //nolang
          begin
//          p.bitpix:=argument;
          ImgInfos.BitPix:=STrToInt(argument)
          end
       else if (keyword='NAXIS'   ) and (length(argument)>0) then //nolang
          begin
//          p.naxis:=argument;
          ImgInfos.NbAxes:=StrToInt(argument);
          end
       else if (keyword='NAXIS1'  ) and (length(argument)>0) then //nolang
          begin
//          p.naxis1:=argument;
          ImgInfos.Sx:=StrToInt(argument);
          end
       else if (keyword='NAXIS2'  ) and (length(argument)>0) then //nolang
          begin
//          p.naxis2:=argument;
          ImgInfos.Sy:=StrToInt(argument);
          end
       else if (keyword='NAXIS3'  ) and (length(argument)>0) then //nolang
          begin
//          p.naxis3:=argument;
          ImgInfos.NbPlans:=StrToInt(argument);
          end
//       else if (keyword='DATE-OBS') and (length(argument)>0) then //nolang
       else if (keyword='DATE-OBS') and (length(argument)>0) then //nolang
          begin
//          p.date_obs:=argument;
          try
          ImgInfos.DateTime:=StrToDateFITS(argument);
          except
          end
          end
//       else if (keyword='JDAY'    ) and (length(argument)>0) then p.jday:=argument //nolang
       else if (keyword='OBSERVER') then //nolang
          begin
//          p.observer:=argument;
          ImgInfos.Observateur:=argument;
          end
//       else if (keyword='SITELAT' ) then p.sitelat:=argument //nolang
//       else if (keyword='SITELONG') then p.sitelong:=argument //nolang
       else if (keyword='EXPOSURE') and (length(argument)>0) then //nolang
          begin
//          p.exposure:=argument;
          ImgInfos.TempsPose:=Round(MyStrToFloat(argument)*1000); // s -> ms
          end
       else if (keyword='BZERO') and (length(argument)>0) then //nolang
          begin
          ImgInfos.BZero:=Round(MyStrToFloat(argument));
          end
       else if (keyword='BSCALE') and (length(argument)>0) then //nolang
          begin
          ImgInfos.BScale:=Round(MyStrToFloat(argument));
          end
       else if (keyword='TELESCOP') then //nolang
          begin
//          p.telescop:=argument;
          ImgInfos.Telescope:=argument;
          end
       else if (keyword='INSTRUME')  then //nolang
          begin
//          p.instrume:=argument;
          ImgInfos.Camera:=argument;
          end
       else if (keyword='CDELTM1' ) and (length(argument)>0) then //nolang
          begin
//          p.CDELTM1:=argument;
          ImgInfos.PixX:=MyStrToFloat(argument)*1000; // mm -> um
          end
       else if (keyword='CDELTM2' ) and (length(argument)>0) then //nolang
          begin
//          p.CDELTM2:=argument;
          ImgInfos.PixY:=MyStrToFloat(argument)*1000; // mm -> um
          end
       else if (keyword='BINX'    ) and (length(argument)>0) then //nolang
          begin
//          p.binx:=argument;
          ImgInfos.BinningX:=StrToInt(argument);
          end
       else if (keyword='BINY'    ) and (length(argument)>0) then //nolang
          begin
//          p.biny:=argument;
          ImgInfos.BinningY:=StrToInt(argument);
          end
       else if (keyword='CRVAL1'  ) and (length(argument)>0) then //nolang
          begin
//          p.CRVAL1:=argument;
          ImgInfos.Alpha:=MyStrToFloat(argument)/15; // Degres -> Heures
          end
       else if (keyword='CRVAL2'  ) and (length(argument)>0) then //nolang
          begin
//          p.CRVAL2:=argument;
          ImgInfos.Delta:=MyStrToFloat(argument);
          end
       else if (keyword='FILTERS' ) then //nolang
          begin
//          p.filters:=argument;
          ImgInfos.Filtre:=argument;
          end
       else if (keyword='MIRRORX' ) or //nolang
               (keyword='MIRORX' ) //nolang
       then
          begin
//          p.mirrorX:=argument;
          ImgInfos.MiroirX:=argument='T';
          end
       else if (keyword='MIRRORY' ) or //nolang
               (keyword='MIRORY' )then //nolang
          begin
//          p.mirrorY:=argument;
          ImgInfos.MiroirY:=argument='T';
          end
       else if (keyword='FOCLEN') and (length(argument)>0) then //nolang
          begin
//          p.foclen:=argument;
          ImgInfos.Focale:=MyStrToFloat(argument)/1000;
          end
       else if (keyword='WINDOW') and (length(argument)>0) then //nolang
       begin
//              x1:=copy(argument,1,pos(argument,'s')); delete();
       end

       else if (keyword='DATAMAX'   ) and (length(argument)>0) then //nolang
       begin
//           p.datamax:=argument;
           ImgInfos.Max[1]:=MySTrToFloat(argument);
       end
       else if (keyword='DATAMIN'   ) and (length(argument)>0) then //nolang
       begin
//           p.datamin:=argument;
           ImgInfos.Min[1]:=MySTrToFloat(argument);
       end
//       else if (keyword='TEMP'      ) and (length(argument)>0) then p.temp:=argument //nolang
       else if (keyword='PLATE'     ) and (length(argument)>0) then //nolang
       begin
                // les constantes de plaque
       end
       else if (keyword='COMMENT'   ) then //nolang
          begin
//          p.comment:=argument;
          i:=1;
          while ImgInfos.Commentaires[i]<>'' do inc(i);
          if i<=4 then ImgInfos.Commentaires[i]:=argument;
          end
     // compatibilite avec d autres progs
     else if (keyword='RA') and (length(argument)>0) then //nolang
        begin
//        p.crval1:=argument;
        ImgInfos.Alpha:=MyStrToFloat(argument)/15; // Degrés -> Heures
        end
     else if (keyword='DEC') and (length(argument)>0)  then //nolang
        begin
//        p.crval1:=argument;
        ImgInfos.Delta:=MyStrToFloat(argument);
        end
     else if (keyword='MIPS-HI') and (length(argument)>0)  then //nolang
     begin
//           p.datamax:=argument;
           ImgInfos.Max[1]:=MySTrToFloat(argument);
     end
     else if (keyword='MIPS-LO') and (length(argument)>0)  then //nolang
     begin
//           p.datamin:=argument;
           ImgInfos.Min[1]:=MySTrToFloat(argument);
     end
     else if (keyword='THRESH') and (length(argument)>0)  then //nolang
     begin
//           p.datamax:=argument;
           ImgInfos.Max[1]:=MySTrToFloat(argument);
     end
     else if (keyword='THRESL') and (length(argument)>0)  then //nolang
     begin
//           p.datamin:=argument;
           ImgInfos.Min[1]:=MySTrToFloat(argument);
     end
     else if (keyword='MIPS-X1')  then //nolang
        begin
//        p.x1:=argument;
        ImgInfos.X1:=StrToInt(argument);
        end
     else if (keyword='MIPS-Y1')  then //nolang
        begin
//        p.y1:=argument;
        ImgInfos.Y1:=StrToInt(argument);
        end
     else if (keyword='MIPS-X2')  then //nolang
        begin
//        p.X2:=argument;
        ImgInfos.X2:=StrToInt(argument);
        end
     else if (keyword='MIPS-Y2')  then //nolang
        begin
//        p.Y2:=argument;
        ImgInfos.Y2:=StrToInt(argument);
        end
     else if (keyword='X1') then //nolang
        begin
//        p.x1:=argument;
        ImgInfos.X1:=StrToInt(argument);
        end
     else if (keyword='Y1') then //nolang
        begin
//        p.y1:=argument;
        ImgInfos.Y1:=StrToInt(argument);
        end
     else if (keyword='X2') then //nolang
        begin
//        p.x2:=argument;
        ImgInfos.X2:=StrToInt(argument);
        end
     else if (keyword='Y2') then //nolang
        begin
//        p.y2:=argument;
        ImgInfos.Y2:=StrToInt(argument);
        end
     else if (keyword='MIPS-BIX') and (length(argument)>0) then //nolang
        begin
//        p.binx:=argument;
        ImgInfos.BinningX:=StrToInt(argument);
        end
     else if (keyword='MIPS-BIY') and (length(argument)>0) then //nolang
        begin
//        p.BINY:=argument;
        ImgInfos.BinningY:=StrToInt(argument);
        end
//     else if (keyword='MIPS-CCD') then p.instrume:=argument //nolang
     else if (keyword='FOCAL') and (length(argument)>0) then //nolang
        begin
//        p.foclen:=argument;
        ImgInfos.Focale:=MyStrToFloat(argument)/1000;
        end
     else if (keyword='TIME-OBS') and (length(argument)>0) then //nolang
        begin
//        p.date_obs:=p.date_obs+'T'+argument;
        try
//        ImgInfos.DateTime:=StrToDateFITS(p.date_obs);
        except
        end
        end
     else if (keyword='DIAMETER') and (length(argument)>0) then //nolang
        begin
        ImgInfos.Diametre:=MyStrToFloat(argument);
        end
     else if (keyword='TEMP') and (length(argument)>0) then //nolang
        begin
        ImgInfos.TemperatureCCD:=MyStrToFloat(argument);
        end
     else if (keyword='ORIENT') and (length(argument)>0) then //nolang
        begin
        ImgInfos.OrientationCCD:=MyStrToFloat(argument);
        end
     else if (keyword='SEEING') and (length(argument)>0) then //nolang
        begin
        ImgInfos.Seeing:=MyStrToFloat(argument);
        end
     else result:=false;
end;}

function is_keyword_ok(keyword:string):boolean;
begin
{Les keywords suivants sont compris par teleauto}
 result:=(keyword='SIMPLE') or      //nolang
         (keyword='BITPIX') or       //nolang
         (keyword='NAXIS') or       //nolang
         (keyword='NAXIS1') or      //nolang
         (keyword='NAXIS2') or      //nolang
         (keyword='NAXIS3') or      //nolang
         (keyword='DATE-OBS') or    //nolang
         (keyword='JDAY') or        //nolang
         (keyword='OBSERVER') or    //nolang
         (keyword='SITELAT') or     //nolang
         (keyword='SITELONG') or    //nolang
         (keyword='EXPOSURE') or    //nolang
         (keyword='BZERO') or       //nolang
         (keyword='BSCALE') or      //nolang
         (keyword='TELESCOP') or    //nolang
         (keyword='INSTRUME') or    //nolang
         (keyword='CDELTM1') or     //nolang
         (keyword='CDELTM2') or     //nolang
         (keyword='BINX') or        //nolang
         (keyword='BINY') or        //nolang
         (keyword='CRVAL1') or      //nolang
         (keyword='CRVAL2') or      //nolang
         (keyword='FILTERS') or     //nolang
         (keyword='MIRRORX') or     //nolang
         (keyword='MIRRORY') or     //nolang
         (keyword='FOCLEN') or      //nolang
         (KEYWORD='WINDOW') or      //nolang
         (keyword='DATAMAX') or     //nolang
         (keyword='DATAMIN') or     //nolang
         (keyword='TEMP') or        //nolang
         (keyword='PLATE') or       //nolang
         (keyword='COMMENT') or     //nolang
         (keyword='END') or         //nolang
// FIN DES KEYWORDS TELEAUTO
         (keyword='TIME-OBS') or    //nolang
         (keyword='MIRORX') or      //nolang
         (keyword='MIRORY') or      //nolang
         (keyword='EXTEND') or      //nolang
         (keyword='FOCAL') or       //nolang
         (keyword='RA') or          //nolang
         (keyword='ALPHA') or       //nolang
         (keyword='DELTA') or       //nolang
         (keyword='DEC') or         //nolang
         (keyword='PIXSIZE1') or    //nolang
         (keyword='PIXSIZE2') or    //nolang
         (keyword='EXPTIME') or     //nolang
         (keyword='MIPS-HI') or     //nolang
         (keyword='MIPS-LO') or     //nolang
         (keyword='THRESH') or      //nolang
         (keyword='THRESL') or      //nolang
         (keyword='MIPS-X1') or     //nolang
         (keyword='MIPS-Y1') or     //nolang
         (keyword='MIPS-X2') or     //nolang
         (keyword='MIPS-Y2') or     //nolang
         (keyword='MIPS-BIX') or    //nolang
         (keyword='MIPS-BIY') or    //nolang
         (keyword='DATE') or        //nolang
         (keyword='MIPS-CCD') or    //nolang
         (keyword='ORIGIN') or      //nolang
         (keyword='MIRORY') or      //nolang
         (keyword='MIRORX') or      //nolang
         (keyword='X1') or          //nolang
         (keyword='X2') or          //nolang
         (keyword='Y1') or          //nolang
         (keyword='Y2') or          //nolang
         (keyword='HISTORY') or     //nolang
         (keyword='DIAMETER') or    //nolang
         (keyword='TEMP') or        //nolang
         (keyword='ORIENT') or      //nolang
         (keyword='SEEING');        //nolang

end;

function ReadFitsImage(filename:string;
                       bypass:boolean;
                       var TabImgInt:PTabImgInt;
                       var TabImgDouble:PTabImgDouble;
                       var ImgInfos:TImgInfos):byte;
// return code : 0 : OK
//               1 : headers sont vides
//               2 : autre plantage
// bypass permet d eviter une boite de dialogue disant que le header est pourri

var
   i,ii,j,k,n,h,w : integer;
   x            : double;
   xint         : smallint;
   f : file;
   d8  : array[1..2880] of byte;
   d16 : array[1..1440] of word;
   d32 : array[1..720] of Longword;
   d64 : array[1..360] of Int64;
   off:integer;
//   total_keys:byte; // on verifie la validite du header 87
   npix, seuilh, seuilb : integer;

   LigInt:PLigInt;
   LigByte:PLigByte;
   LigSingle:PLigSingle;
   LigDouble:PLigDouble;

   Vali16:SmallInt;                     { Stockage des intensites entieres 16 bits }
   Valr32:Single;                       { Stockage des intensites reelles 32 bits }
   Valr64:Double;                       { Stockage des intensites reelles 64 bits }
   Val16:array[1..2] of Byte;           { Variable de transtypage pour les 16 bits }
   Val32:array[1..4] of Byte;           { Variable de transtypage pour les 32 bits }
   Val64:array[1..8] of Byte;           { Variable de transtypage pour les 64 bits }

   Tmp:Byte;                            { Variable temporaire pour l'inversion des octets }
   Valeur:Double;

   Depassement:Boolean;
   Mini,Maxi,a,b:Double;
begin
  ImgInfos.BScale:=1;
  ImgInfos.BZero:=0;

  Result:=0;
  Filemode:=0;
  Assignfile(f,FileName);
  Reset(f,1);

  InitImgInfos(ImgInfos);
  ReadFitsHeader(filename,off,ImgInfos);

//  ImgInfos.BScale:=1;
//  ImgInfos.BZero:=32767;

  h:=ImgInfos.Sy;
  w:=ImgInfos.Sx;

  if ImgInfos.NbAxes=2 then
     begin
     ImgInfos.NBplans:=1;
     if ImgInfos.bitpix=-64 then ImgInfos.TypeData:=5;
     if ImgInfos.bitpix=-32 then ImgInfos.TypeData:=5;
     if (ImgInfos.bitpix=16) and (ImgInfos.BScale=1) and (ImgInfos.BZero=0)  then ImgInfos.TypeData:=2;
     if (ImgInfos.bitpix=16) and ((ImgInfos.BScale<>1) or (ImgInfos.BZero<>0))  then ImgInfos.TypeData:=5;
     if ImgInfos.bitpix=8   then ImgInfos.TypeData:=2;
     end
  else
     begin
     if ImgInfos.NBPlans=3 then
        begin
        if ImgInfos.bitpix=-64 then ImgInfos.TypeData:=8;
        if ImgInfos.bitpix=-32 then ImgInfos.TypeData:=8;
        if (ImgInfos.bitpix=16) and (ImgInfos.BScale=1) and (ImgInfos.BZero=0)  then ImgInfos.TypeData:=7;
        if (ImgInfos.bitpix=16) and ((ImgInfos.BScale<>1) or (ImgInfos.BZero<>0))  then ImgInfos.TypeData:=8;
        if ImgInfos.bitpix=8   then ImgInfos.TypeData:=7;
        end
     else
        begin
        if ImgInfos.bitpix=-64 then ImgInfos.TypeData:=5;
        if ImgInfos.bitpix=-32 then ImgInfos.TypeData:=5;
        if ImgInfos.bitpix=16  then ImgInfos.TypeData:=2;
        if (ImgInfos.bitpix=16) and (ImgInfos.BScale=1) and (ImgInfos.BZero=0)  then ImgInfos.TypeData:=2;
        if (ImgInfos.bitpix=16) and ((ImgInfos.BScale<>1) or (ImgInfos.BZero<>0))  then ImgInfos.TypeData:=5;
        if ImgInfos.bitpix=8   then ImgInfos.TypeData:=2;
        end;
     end;

  if (ImgInfos.TypeData=7) or (ImgInfos.TypeData=8) then
     begin
     ImgInfos.Max[2]:=ImgInfos.Max[1];  // pas d'info sur les niveaux de couleurs dans l'entete fits
     ImgInfos.Max[3]:=ImgInfos.Max[1];
     ImgInfos.Min[2]:=ImgInfos.Min[1];
     ImgInfos.Min[3]:=ImgInfos.Min[1];
     end;

  case ImgInfos.bitpix of
    -64:begin
        Seek(f,off);
        Getmem(LigDouble,8*w);
        try
        Getmem(TabImgDouble,4*ImgInfos.NBplans);
        for k:=1 to ImgInfos.NBplans do
           begin
           Getmem(TabImgDouble^[k],h*4);
           for i:=1 to h do Getmem(TabImgDouble^[k]^[i],w*8);
           end;

        for k:=1 to ImgInfos.NBplans do
           for i:=1 to h do
              begin
              BlockRead(f,LigDouble^,8*w);
              for j:=1 to w do
                 begin
                 Valr64:=LigDouble^[j];
                 Move(Valr64,Val64,8);
                 Tmp:=Val64[1]; Val64[1]:=Val64[8]; Val64[8]:=Tmp;
                 Tmp:=Val64[2]; Val64[2]:=Val64[7]; Val64[7]:=Tmp;
                 Tmp:=Val64[3]; Val64[3]:=Val64[6]; Val64[6]:=Tmp;
                 Tmp:=Val64[4]; Val64[4]:=Val64[5]; Val64[5]:=Tmp;
                 Move(Val64,Valr64,8);
//                 TabImgDouble^[k]^[i]^[j]:=ImgInfos.BZero+ImgInfos.BScale*Valr64;
                 TabImgDouble^[k]^[i]^[j]:=Valr64;
                 end;
              end;
        finally
        Freemem(LigDouble,8*w);
        end;
        end;
    -32:begin
        Seek(f,off);
        Getmem(LigSingle,4*w);
        try
        Getmem(TabImgDouble,4*ImgInfos.NBplans);
        for k:=1 to ImgInfos.NBplans do
           begin
           Getmem(TabImgDouble^[k],h*4);
           for i:=1 to h do Getmem(TabImgDouble^[k]^[i],w*8);
           end;

        for k:=1 to ImgInfos.NBplans do
           for i:=1 to h do
              begin
              BlockRead(f,LigSingle^,4*w);
              for j:=1 to w do
                 begin
                 Valr32:=LigSingle^[j];
                 Move(Valr32,Val32,4);
                 Tmp:=Val32[1]; Val32[1]:=Val32[4]; Val32[4]:=Tmp;
                 Tmp:=Val32[2]; Val32[2]:=Val32[3]; Val32[3]:=Tmp;
                 Move(Val32,Valr32,4);
//                 TabImgDouble^[k]^[i]^[j]:=ImgInfos.BZero+ImgInfos.BScale*Valr32;
                 TabImgDouble^[k]^[i]^[j]:=Valr32;
                 end;
              end;
        finally
        Freemem(LigSingle,4*w);
        end;
        end;
     8 :begin
        Seek(f,off);
        Getmem(LigByte,w);
        try
        Getmem(TabImgInt,4*ImgInfos.NBplans);
        for k:=1 to ImgInfos.NBplans do
           begin
           Getmem(TabImgInt^[k],h*4);
           for i:=1 to h do Getmem(TabImgInt^[k]^[i],w*2);
           end;

        for k:=1 to ImgInfos.NBplans do
         for i:=1 to h do
           begin
           BlockRead(f,LigByte^,w);
           for j :=1 to w do
              begin
              TabImgInt^[k]^[i]^[j]:=LigByte^[j];
//              Valeur:=ImgInfos.BZero+ImgInfos.BScale*Valeur;
//              if Valeur>32767 then Valeur:=32767;
//              if Valeur<-32768 then Valeur:=32768;
//              TabImgInt^[k]^[i]^[j]:=Round(Valeur);
              end;
           end;
         finally
         Freemem(LigByte,w);
         end;
         end;
     16:begin
        if (ImgInfos.BScale=1) and (ImgInfos.BZero=0) then
           begin
           Seek(f,off);
           Getmem(LigInt,2*w);
           try
           Getmem(TabImgInt,4*ImgInfos.NBplans);
           for k:=1 to ImgInfos.NBplans do
              begin
              Getmem(TabImgInt^[k],h*4);
              for i:=1 to h do Getmem(TabImgInt^[k]^[i],w*2);
              end;

           for k:=1 to ImgInfos.NBplans do
              for i:=1 to h do
                 begin
                 BlockRead(f,LigInt^,2*w);
                 for j :=1 to w do
                    begin
                    Vali16:=LigInt^[j];
                    Vali16:=Swap(Vali16);
                    TabImgInt^[k]^[i]^[j]:=Vali16;
                    end;
                 end;
            finally
            Freemem(LigInt,2*w);
            end;
            end
        else
           begin
           Seek(f,off);
           Getmem(LigInt,2*w);
           try
           Getmem(TabImgDouble,4*ImgInfos.NBplans);
           for k:=1 to ImgInfos.NBplans do
              begin
              Getmem(TabImgDouble^[k],h*4);
              for i:=1 to h do Getmem(TabImgDouble^[k]^[i],w*8);
              end;

           for k:=1 to ImgInfos.NBplans do
              for i:=1 to h do
                 begin
                 BlockRead(f,LigInt^,2*w);
                 for j :=1 to w do
                    begin
                    Vali16:=LigInt^[j];
                    Vali16:=Swap(Vali16);
                    TabImgDouble^[k]^[i]^[j]:=ImgInfos.BScale*Vali16+ImgInfos.BZero;
                    end;
                 end;
           finally
           Freemem(LigInt,2*w);
           end;
           end;

        ImgInfos.BScale:=1;
        ImgInfos.BScale:=0;
        end;

{     16 :begin
         Seek(f,off);
         Getmem(LigInt,2*w);
         try
         Getmem(TabImgInt,4*ImgInfos.NBplans);
         for k:=1 to ImgInfos.NBplans do
            begin
            Getmem(TabImgInt^[k],h*4);
            for i:=1 to h do Getmem(TabImgInt^[k]^[i],w*2);
            end;

         // Lecture en entier et verif que ca depasse pas la dynamique
         Depassement:=False;   
         for k:=1 to ImgInfos.NBplans do
           for i:=1 to h do
              begin
              BlockRead(f,LigInt^,2*w);
              for j :=1 to w do
                 begin
                 Vali16:=LigInt[j];
                 Valeur:=Swap(Vali16);
                 Valeur:=1.0*ImgInfos.BZero+ImgInfos.BScale*Valeur;
                 if Valeur>32767 then
                    begin
                    Valeur:=32767;
                    Depassement:=True;
                    end;
                 if Valeur<-32768 then
                    begin
                    Valeur:=32768;
                    Depassement:=True;
                    end;
                 TabImgInt^[k]^[i]^[j]:=Round(Valeur);
                 end;
              end;

         // Si il y a dépassement, on charge obligatoirement dans un image réelle
         if Depassement then
            begin
            if config.TypeFitsHorsDynamique=0 then
               begin
               // Pas besoin de l'image entiere
               for k:=1 to ImgInfos.NBplans do
                  begin
                  for i:=1 to h do Freemem(TabImgInt^[k]^[i],w*2);
                  Freemem(TabImgInt^[k],h*4);
                  end;
               Freemem(TabImgInt,4*ImgInfos.NBplans);
               end;

            Getmem(TabImgDouble,4*ImgInfos.NBplans);
            for k:=1 to ImgInfos.NBplans do
               begin
               Getmem(TabImgDouble^[k],h*4);
               for i:=1 to h do Getmem(TabImgDouble^[k]^[i],w*8);
               end;

            Seek(f,off);

            Maxi:=-1.7e308;
            Mini:=1.7e308;
            for k:=1 to ImgInfos.NBplans do
               for i:=1 to h do
                  begin
                  BlockRead(f,LigInt^,2*w);
                  for j:=1 to w do
                     begin
                     Vali16:=LigInt[j];
                     Valeur:=Swap(Vali16);
                     Valeur:=1.0*ImgInfos.BZero+ImgInfos.BScale*Valeur;
                     if Valeur>Maxi then Maxi:=Valeur;
                     if Valeur<Mini then Mini:=Valeur;
                     TabImgDouble^[k]^[i]^[j]:=Valeur;
                     end;
                  end;

            // On change vers les typedonnees réelles
            if config.TypeFitsHorsDynamique=0 then
               begin
               if ImgInfos.NbAxes=2 then ImgInfos.TypeData:=5
               else if ImgInfos.NBplans=3 then ImgInfos.TypeData:=8 else ImgInfos.TypeData:=5;
               end;

            // On repasse en entier en recalant
            if config.TypeFitsHorsDynamique=1 then
               begin
               // Calul des coefs de recalage de la dynamique
               a:=65535.0/(Maxi-Mini);
               b:=32767.0-a*Maxi;

               for k:=1 to ImgInfos.NBplans do
                  for i:=1 to h do
                     for j:=1 to w do
                        begin
                        Valeur:=TabImgDouble^[k]^[i]^[j];
                        Valeur:=a*Valeur+b;
                        TabImgInt^[k]^[i]^[j]:=Round(Valeur);
                        end;

               // On libere l'image réelle
               for k:=1 to ImgInfos.NBplans do
                  begin
                  for i:=1 to h do Freemem(TabImgDouble^[k]^[i],w*8);
                  Freemem(TabImgDouble^[k],h*4);
                  end;
               Freemem(TabImgDouble,4*ImgInfos.NBplans);
               end;
            end;

         finally
         Freemem(LigInt,2*w);
         end;
         end;}
     32 :begin
         Seek(f,off);

         for i:=0 to h-1 do
            begin
            ii:=h-1-i;
            for j := 0 to w-1 do
               begin
               if (npix mod 720 = 0) then
                  begin
                  BlockRead(f,d32,sizeof(d32),n);
                  npix:=0;
                  end;
               inc(npix);
//               x:=ImgInfos.BZero+ImgInfos.BScale*InvertI32(d32[npix]);
               x:=InvertI32(d32[npix]);
               end;
            end;
         end;
     end;
    ImgInfos.Sx:=w;
    ImgInfos.Sy:=h;
    CloseFile(f);
    pop_main.SeuilsEnable;

end;


{------------------------------------------------------------------------------}


// Ecrit dans le fichier des erreurs de pointage
{procedure WriteTrack(Line:String);
var
F:TextFile;
begin
AssignFile(F,ExtractFilePath(Application.ExeName)+'AimError.txt'); //nolang
Append(F);

Writeln(F,Line);

CloseFile(F);

Application.ProcessMessages;
end;}

{-------------------------------------------------------------------------------

                            gestion des catalogues

                        creation des fichiers de sortie

-------------------------------------------------------------------------------}

procedure CheckCat;
begin
// controle quels catalogues sont installes
Config.CatBSCPresent:=IsBSCpath(config.RepCatalogsBase+'\BSC'); //nolang
Config.CatNGCPresent:=IsNGCpath(config.RepCatalogsBase+'\NGC'); //nolang
Config.CatPGCPresent:=IsPGCpath(config.RepCatalogsBase+'\PGC'); //nolang
Config.CatRC3Present:=IsRC3path(config.RepCatalogsBase+'\RC3'); //nolang
Config.CatWDSPresent:=IsWDSpath(config.RepCatalogsBase+'\WDS'); //nolang
Config.CatGCVPresent:=IsGCVpath(config.RepCatalogsBase+'\GCVS'); //nolang
Config.CatMCTPresent:=IsMCTpath(config.RepMicrocat);
Config.CatUSNOPresent:=IsUSNOApath(config.RepUSNO);
Config.CatTY2Present:=IsTY2path(config.RepTycho2);
case Config.TypeGSC of
   0 : Config.CatGSCCPresent:=IsGSCCpath(config.RepGSC);
   1 : Config.CatGSCCPresent:=IsGSCFpath(config.RepGSC);
   end;
end;

procedure query_the_catalogs(s:string; x_1,x_2,y_1,y_2,         // coords des 2 coins opposes
                                       mag_lo,mag_hi,           // limites magnitude
                                       size_lo, size_hi:double; // limites taille
                                       p:pHeader;
                                       var lst:tlist;           // liste de sortie
                                       output:boolean);         // cree un fichier texte si true

begin

      if s='BSC'  then //nolang
      begin
          application.hint:=lang('Traitement du catalogue Bright Star'); //'Processing Bright Star Catalog'
          get_BSC(x_1,x_2,y_1,y_2,mag_lo,mag_hi,lst);
          p.bsc:=lst.count;
          if output and (p.bsc > 0) then create_query_output(p,s,lst);
      end;

      if s='NGC'  then //nolang
      begin
          application.hint:=lang('Traitement du catalogue NGC'); //'Processing NGC Catalog'
          get_ngc(x_1,x_2,y_1,y_2,mag_lo,mag_hi,size_lo,size_hi,lst);
          p.ngc:=lst.count;
          if output and (p.ngc > 0) then create_query_output(p,s,lst);
      end;
      if s='USNO' then //nolang
      begin
          application.hint:=lang('Traitement du catalogue USNO'); //'Processing USNO Catalog'
          get_usno(x_1,x_2,y_1,y_2,mag_lo,mag_hi,lst);
          p.usno:=lst.count;
          if output and (p.usno > 0) then create_query_output(p,s,lst);
      end;
      if s='PGC' then //nolang
      begin
          application.hint:=lang('Traitement du catalogue PGC'); //'Processing PGC Catalog'
          get_pgc(x_1,x_2,y_1,y_2,mag_lo,mag_hi,size_lo,size_hi,lst);
          p.pgc:=lst.count;
          if output and (p.pgc > 0) then create_query_output(p,s,lst);
      end;
      if s='RC3' then //nolang
      begin
          application.hint:=lang('Traitement du catalogue RC3'); //'Processing RC3 Catalog'
          get_rc3(x_1,x_2,y_1,y_2,mag_lo,mag_hi,size_lo,size_hi,lst);
          p.rc3:=lst.count;
          if output and (p.rc3 > 0) then create_query_output(p,s,lst);
      end;
      if s='MicroCat (GSC)' then //nolang
      begin
          application.hint:=lang('Traitement du catalogue MicroCat (GSC)'); //'Processing MicroCat Catalog (GSC)'
          get_mct(x_1,x_2,y_1,y_2,mag_lo,mag_hi,1,lst);
          p.mct:=lst.count;
          if output and (p.mct > 0) then create_query_output(p,s,lst);
      end;
      if s='MicroCat (GSC+Tycho)' then //nolang
      begin
          application.hint:=lang('Traitement du catalogue MicroCat (GSC-TYC)'); //'Processing MicroCat Catalog (GSC-TYC)'
          get_mct(x_1,x_2,y_1,y_2,mag_lo,mag_hi,2,lst);
          p.mct:=lst.count;
          if output and (p.mct > 0) then create_query_output(p,s,lst);
      end;
      if s='MicroCat (GSC+Tycho+USNO)' then //nolang
      begin
          application.hint:=lang('Traitement du catalogue MicroCat (GSC-TYC-USNO)'); //'Processing MicroCat Catalog (GSC-TYC-USNO)'
          get_mct(x_1,x_2,y_1,y_2,mag_lo,mag_hi,3,lst);
          p.mct:=lst.count;
          if output and (p.mct > 0) then create_query_output(p,s,lst);
      end;
      if s='Tycho2' then //nolang
      begin
          application.hint:=lang('Traitement du catalogue Tycho'); //'Processing Tycho Input Catalog'
          get_ty2(x_1,x_2,y_1,y_2,mag_lo,mag_hi,lst);
          p.ty2:=lst.count;
          if output and (p.ty2 > 0) then create_query_output(p,s,lst);
      end;
      if s='GSC' then //nolang
      begin
           application.hint:=lang('Processing catalogue Guide Star (GSC)'); //'Processing Guide Star Catalog'
           get_gsc(x_1,x_2,y_1,y_2,mag_lo,mag_hi,lst);
           p.gsc:=lst.count;
          // if output and (p.gsc > 0) then create_query_output(p,s,lst);
      end;
end;


procedure create_query_output(p:pHeader;s:string; lst:tlist);
{will create a text file per query. 1 image queries on 7 catalogs will generate
7 files named \...\imagefilename+_catalog shortname+ .dat
Temp files will be stored along with source images, and can be cleaned up by
clearing the trash Tlist }
{PJ 12/7}
var
tokill:P_Trash_item;
pbsc: ^BSCREC;
pngc: ^NGCRECd;  // non standard
pusno:^USNOAREC;
Ppgc: ^PGCRECd;  // non standard
pgsc: ^GSCCREC;
PRc3: ^RC3recd;  // non standard
pmct: ^MCTREC;
pty2: ^Ty2REC;
f:textfile;
tmp,line:string;
i:integer;
begin
     tmp:='c:\dev\projects\teleauto\dat\'+copy(extractfilename(p.filename),1, //nolang
     length(extractfilename(p.filename))-4)+'_'+s+'.dat'; //nolang
     assignfile(f,tmp);
     rewrite(f);
     line:='';
     if s='BSC' then //nolang
     begin
          write(f,'#BSC'+#13+#10); //nolang
          for i:=0 to lst.count-1 do
          begin
               pbsc:=lst[i];
               line:=line+inttostr(i+1)+#9;
               line:=line+'Star'+#9; //nolang
               line:=line+'HD'+inttostr(pbsc.hd)+#9; //nolang
               line:=line+floattostrf(pbsc.ar/100000/15,fffixed,15,5)+#9;
               line:=line+floattostrf(pbsc.de/100000,fffixed,15,4)+#9;
               line:=line+floattostrf(pbsc.mv/100,fffixed,15,2)+#9;
               line:=line+floattostrf(pbsc.b_v,fffixed,15,2)+#13+#10;
               write(f,line);
               line:='';
          end;
     end;
     if s='NGC' then //nolang
     begin
          write(f,'#NGC'+#13+#10); //nolang
          for i:=0 to lst.count-1 do
          begin
               pngc:=lst[i];
               line:=line+inttostr(i+1)+#9;
               if pngc.ic='I' then line:=line+'IC'+inttostr(pngc.id)+#9 //nolang
               else
               line:=line+'NGC'+inttostr(pngc.id)+#9; //nolang
               line:=line+pngc.typ+#9;
               line:=line+floattostrf(pngc.ar,fffixed,15,5)+#9;
               line:=line+floattostrf(pngc.de,fffixed,15,4)+#9;
               line:=line+floattostrf(pngc.ma/100,fffixed,15,2)+#9;
               line:=line+floattostrf(pngc.dim/10,fffixed,15,2)+#13+#10;
               write(f,line);
               line:='';
          end;
     end;
     if s='USNO' then //nolang
     begin
          write(f,'#USNO'+#13+#10); //nolang
          for i:=0 to lst.count-1 do
          begin
               pusno:=lst[i];
               line:=line+inttostr(i+1)+#9;
               line:=line+'Star'+#9; //nolang
               line:=line+pusno.id+#9;
               line:=line+floattostrf(pusno.ar,fffixed,15,5)+#9;
               line:=line+floattostrf(pusno.de,fffixed,15,4)+#9;
               line:=line+floattostrf(pusno.mb,fffixed,15,2)+#9;
               line:=line+floattostrf(pusno.mr,fffixed,15,2)+#13+#10;
               write(f,line);
               line:='';
          end;
     end;
     if s='PGC' then //nolang
     begin
          write(f,'#PGC'+#13+#10); //nolang
          for i:=0 to lst.count-1 do
          begin
               ppgc:=lst[i];
               line:=line+inttostr(i+1)+#9;
               line:=line+'Galaxy'+#9; //nolang
               line:=line+inttostr(ppgc.pgc)+#9;
               line:=line+floattostrf(ppgc.ar,fffixed,15,5)+#9;
               line:=line+floattostrf(ppgc.de,fffixed,15,4)+#9;
               line:=line+floattostrf(ppgc.mb/100,fffixed,15,2)+#9;
               line:=line+inttostr(ppgc.pa)+#9;
               line:=line+inttostr(ppgc.maj)+#9;
               line:=line+inttostr(ppgc.min)+#9;
               line:=line+ppgc.typ+#9;
               line:=line+ppgc.nom+#13+#10;
               write(f,line);
               line:=''; 
          end;
     end;
     if s='RC3' then //nolang
     begin
          write(f,'#RC3'+#13+#10); //nolang
          for i:=0 to lst.count-1 do
          begin
               prc3:=lst[i];
               line:=line+inttostr(i+1)+#9;
               line:=line+'Galaxy'+#9; //nolang
               line:=line+'PGC'+prc3.pgc+#9; //nolang
               line:=line+floattostrf(prc3.ar,fffixed,15,5)+#9;
               line:=line+floattostrf(prc3.de,fffixed,15,4)+#9;
               line:=line+floattostrf(prc3.mb/100,fffixed,15,2)+#9;
               line:=line+prc3.typ+#9;
               line:=line+prc3.nom+#13+#10;
               write(f,line);
               line:=''; 
          end;
     end;
     if s='Tycho2' then //nolang
     begin
          write(f,'#Tycho2'+#13+#10); //nolang
          for i:=0 to lst.count-1 do
          begin
               pty2:=lst[i];
               line:=line+inttostr(i+1)+#9;
               line:=line+'Star'+#9; //nolang
               line:=line+'GSC'+inttostr(pty2.gscz)+'.'+inttostr(pty2.gscn)+#9; //nolang
               //line:=line+lang('ID')+inttostr(pty2.tycn)+#9;
               line:=line+floattostrf(pty2.ar,fffixed,15,5)+#9;
               line:=line+floattostrf(pty2.de,fffixed,15,4)+#9;
               line:=line+floattostrf(pty2.bt,fffixed,15,2)+#9;
               line:=line+floattostrf(pty2.vt,fffixed,15,2)+#13+#10;
               write(f,line);
               line:='';
          end;
     end;
     { TODO : GSC}
     if copy(s,1,8)='MicroCat' then //nolang
     begin
          write(f,'#'+s+#13+#10);
          for i:=0 to lst.count-1 do
          begin
               pmct:=lst[i];
               line:=line+inttostr(i+1)+#9;
               line:=line+'Star'+#9; //nolang
               line:=line+floattostrf(pmct.ar,fffixed,15,5)+#9;
               line:=line+floattostrf(pmct.de,fffixed,15,4)+#9;
               line:=line+floattostrf(pmct.mb,fffixed,15,2)+#9;
               line:=line+floattostrf(pmct.mr,fffixed,15,2)+#13+#10;
               write(f,line);
               line:='';
          end;
     end;
     closefile(f);
end;





function get_bsc(x_1,x_2,y_1,y_2,mag_lo,mag_hi:double;var lst:tlist):boolean;
var
bscrecord:bscrec; Pbsc:^bscrec;
alpha,delta,mag:double;
ok:boolean;
begin
     result:=true;
     openbsc(x_1,x_2,y_1,y_2,ok);
     if not ok then
     begin
          result:=false;
          exit;
     end;
     repeat
          readbsc(bscrecord,ok);
          alpha:=bscrecord.ar/100000/15;
          delta:=bscrecord.de/100000;
          mag:=bscrecord.mv/100;
          if (alpha<x_1) or (alpha>x_2) or (delta<y_1) or (delta>y_2) then continue;
          if (alpha>x_1) and (alpha<x_2) and (delta>y_1) and (delta<y_2) then
          begin
               new(pbsc);
               PBsc.cons:=bscrecord.cons;
               pbsc.hd:=bscrecord.hd;
               pbsc.bs:=bscrecord.bs;
               pbsc.ar:=bscrecord.ar;
               pbsc.de:=bscrecord.de;
               pbsc.mv:=bscrecord.mv;
               pbsc.b_v:=bscrecord.b_v;
               pbsc.flam:=bscrecord.flam;
               pbsc.bayer:=bscrecord.bayer;
               if (mag < mag_hi) and (mag > mag_lo) then lst.Add(pbsc) else dispose(pbsc);
          end;
     until not ok;
     closebsc;
end;


function get_usno(x_1,x_2,y_1,y_2,mag_lo,mag_hi:double;var lst:tlist):boolean;
{PJ 12/7}
var
usnorecord:usnoarec;
PUsno:^usnoarec;
alpha,delta,mag:double;
ok:boolean;
begin
     result:=true;
     openusnoa(x_1,x_2,y_1,y_2,ok);
     if not ok then
     begin
          result:=false;
          exit;
     end;
     repeat
          readusnoa(usnorecord,ok);
          alpha:=usnorecord.ar;
          delta:=usnorecord.de;
          mag:=usnorecord.mr;  //attention !!!!
          if (alpha>x_1) and (alpha<x_2) and (delta>y_1) and (delta<y_2) then
          begin
               new(pusno);
               pusno.id:=usnorecord.id;
               pusno.ar:=usnorecord.ar;   // decimal hours
               pusno.de:=usnorecord.de;
               pusno.mb:=usnorecord.mb;
               pusno.mr:=usnorecord.mr;
               pusno.field:=usnorecord.field;
               pusno.q:=usnorecord.q;
               pusno.s:=usnorecord.s;
               if (mag < mag_hi) and (mag > mag_lo) then lst.Add(pusno) else dispose(pusno);
          end;
     until not ok;
     closeusnoa;
end;


function is_a_galaxy(s:string; var typo:string):boolean;
begin
     if (copy(trim(S),1,1)='S') or (pos('S',s)<>0) then      //nolang
     begin
          result:=true;
          typo:='S';   //nolang
          exit;
     end
     else if (copy(trim(S),1,1)='E') or (pos('S',s)<>0) then  //nolang
     begin
          result:=true;
          typo:='E';   //nolang
          exit;
     end
     else if (copy(trim(S),1,1)='I') or (pos('S',s)<>0) then //nolang
     begin
          result:=true;
          typo:='I';   //nolang
          exit;
     end
     else if pos('Gx',S)<>0 then //nolang
     begin
          result:=true;
          typo:='?'; //nolang
          exit;
     end
     else
     begin
          result:=false;
          typo:='?'; //nolang
          exit;
     end;
end;


function get_pgc(x_1,x_2,y_1,y_2,mag_lo,mag_hi,size_lo,size_hi:double;var lst:tlist):boolean;
{PJ 12/7}
var
pgcrecord:pgcrec; PPgc:p_pgcrecd;
alpha,delta,mag,size:double;
ok,gal:boolean;
type_galaxie:string;
begin
     result:=true;
     openpgc(x_1,x_2,y_1,y_2,ok);
     if not ok then
     begin
          result:=false;
          exit;
     end;

     repeat
          readpgc(pgcrecord,ok);
          alpha:=pgcrecord.ar/100000/15;
          delta:=pgcrecord.de/100000;
          mag:=pgcrecord.mb/100;
          if pgcrecord.maj>=0 then size:=pgcrecord.maj/100
          else size:=0;
          if (alpha>x_1) and (alpha<x_2) and (delta>y_1) and (delta<y_2) then
          begin
               new(ppgc);
               ppgc.pgc:=pgcrecord.pgc;
               ppgc.ar:=pgcrecord.ar/100000/15;
               ppgc.de:=pgcrecord.de/100000;
               ppgc.hrv:=pgcrecord.hrv;
               ppgc.nom:=pgcrecord.nom;
               ppgc.typ:=pgcrecord.typ;
               ppgc.pa:=pgcrecord.pa;
               ppgc.maj:=pgcrecord.maj;
               ppgc.min:=pgcrecord.min;
               ppgc.mb:=pgcrecord.mb;
               gal:=is_a_galaxy(ppgc.typ,type_galaxie);
               // verification des criteres
               if (mag < mag_hi) and (mag > mag_lo) and  // mag
                  (size < size_hi) and (size > size_lo) and  // size
                  (config.distance_objet >= ppgc.hrv) and // distance
                  (
                  //ALL
                  (config.type_objet=0) or
                  // All Galaxies
                  (config.type_objet=5) or
                  // S
                  ((config.type_objet=1) and (type_galaxie='S')) or //nolang
                  // E
                  ((config.type_objet=2) and (type_galaxie='E')) or //nolang
                  // I
                  ((config.type_objet=3) and (type_galaxie='I')) or //nolang
                  // Others
                  ((config.type_objet=4) and (type_galaxie<>'S') and //nolang
                                             (type_galaxie<>'E') and //nolang
                                             (type_galaxie<>'I')) //nolang
                   ) then lst.Add(ppgc) else dispose(ppgc);
                  type_galaxie:='';
          end;
     until not ok;
     closepgc;
end;


function get_rc3(x_1,x_2,y_1,y_2,mag_lo,mag_hi,size_lo,size_hi:double;var lst:tlist):boolean;
{PJ 12/7}
var
rc3record:rc3rec; Prc3:^rc3recd;
alpha,delta,mag,size:double;
ok:boolean;
type_galaxie:string;
begin
     result:=true;
     openrc3(x_1,x_2,y_1,y_2,ok);
     if not ok then
     begin
          result:=false;
          exit;
     end;

     repeat
          readrc3(rc3record,ok);
          alpha:=rc3record.ar/100000/15;
          delta:=rc3record.de/100000;
          mag:=rc3record.mb/100;
          if rc3record.d25>=0 then size:=power(10,rc3record.d25/100)/10
          else size:=0;
          if (alpha>x_1) and (alpha<x_2) and (delta>y_1) and (delta<y_2) then
          begin
               new(prc3);
               prc3.ar:=rc3record.ar/100000/15;
               prc3.de:=rc3record.de/100000;
               prc3.vgsr:=rc3record.vgsr;
               prc3.pgc:=rc3record.pgc;
               prc3.nom:=rc3record.nom;
               prc3.typ:=rc3record.typ;
               prc3.pa:=rc3record.pa;
               prc3.stage:=rc3record.stage;
               prc3.lumcl:=rc3record.lumcl;
               prc3.d25:=rc3record.d25;
               prc3.r25:=rc3record.r25;
               prc3.Ae:=rc3record.Ae;
               prc3.mb:=rc3record.mb;
               prc3.b_vt:=rc3record.b_vt;
               prc3.b_ve:=rc3record.b_ve;
               prc3.m25:=rc3record.m25;
               prc3.me:=rc3record.me;
               is_a_galaxy(prc3.typ,type_galaxie);
               if (mag < mag_hi) and (mag > mag_lo)        // mag
               and (size < size_hi) and (size > size_lo)   // size
               and (config.distance_objet>=prc3.vgsr)
               and (

               //ALL
              (config.type_objet=0) or
              // All Galaxies
              (config.type_objet=5) or
              // S
              ((config.type_objet=1) and (type_galaxie='S')) or //nolang
              // E
              ((config.type_objet=2) and (type_galaxie='E')) or //nolang
              // I
              ((config.type_objet=3) and (type_galaxie='I')) or //nolang
              // Others
              ((config.type_objet=4) and (type_galaxie<>'S') and //nolang
                                         (type_galaxie<>'E') and //nolang
                                         (type_galaxie<>'I')) //nolang
               ) then lst.Add(prc3) else dispose(prc3);
               type_galaxie:='';
          end;
     until not ok;
     closerc3;
end;


function get_ngc(x_1,x_2,y_1,y_2,mag_lo,mag_hi,size_lo,size_hi:double;var lst:tlist):boolean;
{PJ 12/7}
var
ngcrecord:ngcrec; Pngc:p_NGCrecd;
alpha,delta,mag:double;
size:double;
gal,ok,gal_ok:boolean;
type_galaxie:string;
begin
     openngc(x_1,x_2,y_1,y_2,ok);
     result:=true;
     if not ok then
     begin
          result:=false;
          exit;
     end;

     repeat
          readngc(ngcrecord,ok);
          alpha:=ngcrecord.ar/100000/15;
          delta:=ngcrecord.de/100000;
          mag:=ngcrecord.ma/100;
          size:=ngcrecord.dim/10;
          if (alpha>x_1) and (alpha<x_2) and (delta>y_1) and (delta<y_2) then
          begin
               new(pngc);
               pngc.ar:=alpha;
               pngc.de:=delta;
               pngc.id:=ngcrecord.id;
               pngc.ic:=ngcrecord.ic;
               pngc.typ:=ngcrecord.typ;
               pngc.l_dim:=ngcrecord.l_dim;
               pngc.n_ma:=ngcrecord.n_ma;
               pngc.ma:=ngcrecord.ma;
               pngc.dim:=ngcrecord.dim;
               pngc.cons:=ngcrecord.cons;
               pngc.desc:=ngcrecord.desc;
               gal:=is_a_galaxy(pngc.typ,type_galaxie);

               if (mag < mag_hi) and (mag > mag_lo)
               and (size < size_hi) and (size > size_lo)
               and (
                   //ALL
                   (config.type_objet=0) or
                   // All Galaxies
                   (config.type_objet=5) or
                   // S
                   ((config.type_objet=1) and gal) or //nolang
                   // E
                   ((config.type_objet=2) and gal) or //nolang
                   // I
                   ((config.type_objet=3) and gal) or //nolang
                   // Others
                   ((config.type_objet=4) and gal) or //nolang
                   // globular clusters
                   ((config.type_objet=6) and (pngc.typ='Gb')) or //nolang
                   // open clusters
                   ((config.type_objet=7) and (pngc.typ='OC')) or //nolang
                   // All Clusters
                   ((config.type_objet=8) and (pngc.typ='OC')) or //nolang
                   ((config.type_objet=8) and (pngc.typ='Gb')) or //nolang
                   // nebulae
                   ((config.type_objet=9) and (pngc.typ='Pl')) or //nolang
                   ((config.type_objet=9) and (pngc.typ='Nb')) //nolang
                   )
                   then lst.Add(pngc) else dispose(pngc);

          end;
     until not ok;
     closengc;
end;


function get_ty2(x_1,x_2,y_1,y_2,mag_lo,mag_hi:double;var lst:tlist):boolean;
{PJ 12/7}
var
Ty2record:Ty2rec; Pty2:^Ty2rec;
alpha,delta,mag:double;
ok:boolean;
sm:shortstring;
begin
     result:=true;
     openTy2(x_1,x_2,y_1,y_2,2,ok);
     if not ok then
     begin
          result:=false;
          exit;
     end;

     repeat
          readty2(ty2record,sm,ok);
          alpha:=ty2record.ar/15;
          delta:=ty2record.de;
          mag:=ty2record.bt;
          if (alpha>x_1) and (alpha<x_2) and (delta>y_1) and (delta<y_2) then
          begin
               new(pty2);
               pty2.ar:=ty2record.ar/15;
               pty2.de:=ty2record.de;
               pty2.gscz:=ty2record.gscz;
               pty2.gscn:=ty2record.gscn;
               pty2.bt:=ty2record.bt;
               pty2.vt:=ty2record.vt;
               if (mag < mag_hi) and (mag > mag_lo) then lst.Add(pty2) else dispose(pty2);
          end;
     until not ok;
     closety2;
end;


function get_mct(x_1,x_2,y_1,y_2,mag_lo,mag_hi:double;cat:integer;var lst:tlist):boolean;

var
MCtrecord:mctrec; Pmct:^mctrec;
alpha,delta,mag:double;
ok:boolean;
 { Parametre supplementaire pour OPEN de MicroCat :
  ncat=1 : catalog Tycho
  ncat=2 : catalog Tycho + GSC
  ncat=3 : catalog Tycho + GSC + USNO }
begin
     result:=true;
     openmct(x_1,x_2,y_1,y_2,cat,ok);
     if not ok then
     begin
          result:=false;
          exit;
     end;

     repeat
          readmct(mctrecord,ok);
          alpha:=mctrecord.ar;
          delta:=mctrecord.de;
          mag:=mctrecord.mr;
          if (alpha>x_1) and (alpha<x_2) and (delta>y_1) and (delta<y_2) then
          begin
               new(pmct);
               pmct.ar:=mctrecord.ar;
               pmct.de:=mctrecord.de;
               pmct.mb:=mctrecord.mb;
               pmct.mr:=mctrecord.mr;
               if (mag < mag_hi) and (mag > mag_lo) then lst.Add(pmct) else dispose(pmct);
          end;
     until not ok;
     closemct;
end;


function get_gsc(x_1,x_2,y_1,y_2,mag_lo,mag_hi:double;var lst:tlist):boolean;
var
gscrecord:gsccrec; Pgsc:^gsccrec;
alpha,delta,mag:double;
ok:boolean;
smnum:shortstring;
{version 1.1 compact et GSC-ACT ou v1.3}
{ajout de la version FITS}
begin
     result:=true;
     case Config.TypeGSC of
     0 : opengscc(x_1,x_2,y_1,y_2,ok);
     1 : opengscf(x_1,x_2,y_1,y_2,ok);
     end;
     if not ok then
     begin
          result:=false;
          exit;
     end;

     repeat
          case Config.TypeGSC of
          0 : readgscc(gscrecord,smnum,ok);
          1 : readgscf(gscrecord,smnum,ok);
          end;
          alpha:=gscrecord.ar/15;
          delta:=gscrecord.de;
	       mag:=gscrecord.m;
          if (alpha>x_1) and (alpha<x_2) and (delta>y_1) and (delta<y_2) then
          begin
               new(pgsc);
               pgsc.ar:=alpha;
               pgsc.de:=delta;
               pgsc.gscn:=gscrecord.gscn;
               pgsc.pe:=gscrecord.pe;
               pgsc.m:=gscrecord.m;
               pgsc.me:=gscrecord.me;
               pgsc.mb:=gscrecord.mb;
               pgsc.cl:=gscrecord.cl;
               pgsc.mult:=gscrecord.mult;
               if (mag < mag_hi) and (mag > mag_lo) then lst.Add(pgsc) else dispose(pgsc);
          end;
     until not ok;
     case Config.TypeGSC of
     0 : closegscc;
     1 : closegscf;
     end;
end;

procedure ReadHeader(Name:String;
                     var ImgInfos:TImgInfos);
var
hdr: TPicHeader;
//p:PFITSHEADER;
offset:integer;
//total:byte;
h3:TEnteteCPA_Ver3;
h4:TEnteteCPA_Ver4c;
NumCpa:Byte;
begin
try
if Uppercase(ExtractFileExt(Name))='.PIC' then //nolang
   begin
   ReadPicHeader(Name,hdr);
   ImgInfos.Sx:=hdr.sx;
   ImgInfos.Sy:=hdr.sy;
   ImgInfos.TypeData:=2;
   ImgInfos.NbPlans:=1;
   end;
if (uppercase(extractfileext(Name))='.FIT') or //nolang
   (uppercase(extractfileext(Name))='.FTS') or //nolang
   (uppercase(extractfileext(name))='.FITS') then //nolang
   begin
   ReadFITSHeader(Name,offset,ImgInfos);
   ImgInfos.Sx:=ImgInfos.Sx;
   ImgInfos.Sy:=ImgInfos.Sy;

   if ImgInfos.NbAxes=2 then
       begin
       ImgInfos.NBplans:=1;
       if ImgInfos.bitpix=-64 then ImgInfos.TypeData:=5;
       if ImgInfos.bitpix=-32 then ImgInfos.TypeData:=5;
       if ImgInfos.bitpix=16  then ImgInfos.TypeData:=2;
       if ImgInfos.bitpix=8   then ImgInfos.TypeData:=2;
       end
    else
       begin
       if ImgInfos.NBPlans=3 then
          begin
          if ImgInfos.bitpix=-64 then ImgInfos.TypeData:=8;
          if ImgInfos.bitpix=-32 then ImgInfos.TypeData:=8;
          if ImgInfos.bitpix=16  then ImgInfos.TypeData:=7;
          if ImgInfos.bitpix=8   then ImgInfos.TypeData:=7;
          end
       else
          begin
          if ImgInfos.bitpix=-64 then ImgInfos.TypeData:=5;
          if ImgInfos.bitpix=-32 then ImgInfos.TypeData:=5;
          if ImgInfos.bitpix=16  then ImgInfos.TypeData:=2;
          if ImgInfos.bitpix=8   then ImgInfos.TypeData:=2;
          end;
       end;
   end;
if Uppercase(ExtractFileExt(Name))='.CPA' then //nolang
   begin
   ReadcpaHeader(Name,h3,h4,NumCpa);
   ImgInfos.TypeData:=2;
   ImgInfos.NbPlans:=1;   
   Case NumCpa of
      3:begin
        ImgInfos.Sx:=h3.Largeur;
        ImgInfos.Sy:=h3.Longueur;
        end;
      4:begin
        ImgInfos.Sx:=h4.Largeur;
        ImgInfos.Sy:=h4.Longueur;
        end;
      end;
   end;
finally
end;
end;

procedure ReadImageGenerique(FileName:String;
                             var TabImgInt:PTabImgInt;
                             var TabImgDouble:PTabImgDouble;
                             var ImgInfos:TImgInfos);
var
pf:PfitsHeader;
Maxi,Mini,Mediane,Moy,Ecart:Double;
begin
if ExtractFileExt(FileName)='' then
   case ImgInfos.TypeData of
      2:case config.FormatSaveInt of
           0:FileName:=FileName+'.fit';   //nolang
           1,5:FileName:=FileName+'.cpa'; //nolang
           2:FileName:=FileName+'.pic';   //nolang
           3:FileName:=FileName+'.bmp';   //nolang
           4:FileName:=FileName+'.jpg';   //nolang
           end;
      5,6:case config.FormatSaveInt of
           0,1,2,3,5:FileName:=FileName+'.bmp'; //nolang
           4:FileName:=FileName+'.jpg';         //nolang
           end;
      7:case config.FormatSaveInt of
           0:FileName:=FileName+'.fit';   //nolang
           1,5:FileName:=FileName+'.cpa'; //nolang
           2,3:FileName:=FileName+'.bmp'; //nolang
           4:FileName:=FileName+'.jpg';   //nolang
           end;
      end;

if Uppercase(ExtractFileExt(FileName))='.PIC' then //nolang
   ReadPic(FileName,TabImgInt,ImgInfos)
else if (uppercase(extractfileext(filename))='.FIT') or //nolang
   (uppercase(extractfileext(filename))='.FTS') or //nolang
   (uppercase(extractfileext(filename))='.FITS') then //nolang
   begin
   ReadFitsImage(FileName,False,TabImgInt,TabImgDouble,ImgInfos);
   end
else if Uppercase(ExtractFileExt(FileName))='.CPA' then //nolang
   begin
   ReadCpa(FileName,TabImgInt,ImgInfos);
   end
else if Uppercase(ExtractFileExt(FileName))='.BMP' then //nolang
   ReadBMP(FileName,TabImgInt,ImgInfos)
else if (Uppercase(ExtractFileExt(FileName))='.JPG') or //nolang
   (Uppercase(ExtractFileExt(FileName))='.JPEG') then //nolang
   ReadJPG(FileName,TabImgInt,ImgInfos)
else if (Uppercase(ExtractFileExt(FileName))='.CRW') or //nolang
   (Uppercase(ExtractFileExt(FileName))='.NEF') then //nolang
   ReadPhotoNumerique(FileName,TabImgInt,ImgInfos,ImgInfos.RawCfa) //mode raw ou rgb en fonction de rawcfa (mode raw par défaut)
else if (Uppercase(ExtractFileExt(FileName))='.PEF') or //nolang
   (Uppercase(ExtractFileExt(FileName))='.CR2') or (Uppercase(ExtractFileExt(FileName))='.MRW') or //nolang
   (Uppercase(ExtractFileExt(FileName))='.ORF') or (Uppercase(ExtractFileExt(FileName))='.THM') or //nolang
   (Uppercase(ExtractFileExt(FileName))='.X3F') then //nolang
    begin
     ImgInfos.RawCfa:=true;
     ReadPhotoNumerique(FileName,TabImgInt,ImgInfos,ImgInfos.RawCfa);
    end
else raise ErrorFileIO.Create(lang('Format de fichier non reconnu')+#13+
   lang('Ouverture annulée'));

{if Uppercase(ExtractFileExt(FileName))='.PIC' then //nolang
   ReadPic(FileName,TabImgInt,ImgInfos)
else if (uppercase(extractfileext(filename))='.FIT') or //nolang
   (uppercase(extractfileext(filename))='.FTS') or //nolang
   (uppercase(extractfileext(filename))='.FITS') then //nolang
   begin
   ReadFitsImage(FileName,False,TabImgInt,TabImgDouble,ImgInfos);
   end
else if Uppercase(ExtractFileExt(FileName))='.CPA' then //nolang
   begin
   ReadCpa(FileName,TabImgInt,ImgInfos);
   end
else if Uppercase(ExtractFileExt(FileName))='.BMP' then //nolang
   ReadBMP(FileName,TabImgInt,ImgInfos)
else if (Uppercase(ExtractFileExt(FileName))='.JPG') or //nolang
   (Uppercase(ExtractFileExt(FileName))='.JPEG') then //nolang
   ReadJPG(FileName,TabImgInt,ImgInfos)
else if (Uppercase(ExtractFileExt(FileName))='.CRW') or //nolang
   (Uppercase(ExtractFileExt(FileName))='.NEF') then //nolang
   ReadPhotoNumerique(FileName,TabImgInt,ImgInfos,False)
else ReadPhotoNumerique(FileName,TabImgInt,ImgInfos,True);}

if (ImgInfos.Min[1]=0) and (ImgInfos.Max[1]=0) then
    begin
    case ImgInfos.TypeData of
    2: begin
       Statistiques(TabImgInt,nil,2,1,ImgInfos.Sx,ImgInfos.Sy,1,Mini,mediane,Maxi,Moy,Ecart);
       ImgInfos.Min[1]:=Mini;
       ImgInfos.Max[1]:=Maxi;
       end;
    7: begin
       Statistiques(TabImgInt,nil,2,1,ImgInfos.Sx,ImgInfos.Sy,1,Mini,mediane,Maxi,Moy,Ecart);
       ImgInfos.Min[1]:=Mini;
       ImgInfos.Max[1]:=Maxi;
       Statistiques(TabImgInt,nil,2,1,ImgInfos.Sx,ImgInfos.Sy,2,Mini,mediane,Maxi,Moy,Ecart);
       ImgInfos.Min[2]:=Mini;
       ImgInfos.Max[2]:=Maxi;
       Statistiques(TabImgInt,nil,2,1,ImgInfos.Sx,ImgInfos.Sy,3,Mini,mediane,Maxi,Moy,Ecart);
       ImgInfos.Min[3]:=Mini;
       ImgInfos.Max[3]:=Maxi;
       end;
    end;
    end;
end;

procedure SaveImageGenerique(FileName:String;
                             var TabImgInt:PTabImgInt;
                             var TabImgDouble:PTabImgDouble;
                             var ImgInfos:TImgInfos);
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
case ImgInfos.TypeData of
   2:case Config.FormatSaveInt of
        0:FileName:=FileName+'.fit';   //nolang
        1,5:FileName:=FileName+'.cpa'; //nolang
        2:FileName:=FileName+'.pic';   //nolang
        3:FileName:=FileName+'.bmp';   //nolang
        4:FileName:=FileName+'.jpg';   //nolang
        end;
   5,6:case config.FormatSaveInt of
        0,1,2,3,4,5:FileName:=FileName+'.fit';       //nolang
//        1,2,3,5:FileName:=FileName+'.bmp'; //nolang
//        4:FileName:=FileName+'.jpg';       //nolang
        end;
   7:case config.FormatSaveInt of
        0:FileName:=FileName+'.fit';   //nolang
        1,5:FileName:=FileName+'.cpa'; //nolang
        2,3:FileName:=FileName+'.bmp'; //nolang
        4:FileName:=FileName+'.jpg';   //nolang
        end;
   8:FileName:=FileName+'.fit';   //nolang
   end;

case ImgInfos.TypeData of
   2:case config.FormatSaveInt of
        0:SaveFITS (FileName,TabImgInt,TabImgDouble,1,1,ImgInfos);
        1:SaveCpaV3(FileName,TabImgInt,1,ImgInfos);
        2:SavePic  (FileName,TabImgInt,ImgInfos);
        3:SaveBmp  (FileName,TabImgInt,TabImgDouble,ImgInfos);
        4:SaveJpg  (FileName,TabImgInt,TabImgDouble,ImgInfos);
        5:SaveCpaV4d(FileName,TabImgInt,1,ImgInfos);
        end;
   5,6:begin
       // TODO : creer un FormatSaveReel
       if Config.TypeSaveFits=0 then SaveFITS(FileName,TabImgInt,TabImgDouble,1,1,ImgInfos)
       else
          begin
          ConvertFITSRealToInt(TabImgDouble,TabImgInt,ImgInfos);
          SaveFITS(FileName,TabImgInt,TabImgDouble,1,ImgInfos.NbPlans,ImgInfos); // OK
          ConvertFITSIntToReal(TabImgInt,TabImgDouble,ImgInfos);
          end;
       end;
   7:case config.FormatSaveInt of
        0:if config.FormatCouleur=0 then
             begin
             nom:=trim(nom);
             i:=length(nom);
             while ((nom[i]>='0')and(nom[i]<='9'))or(i<=1) do dec(i);
             // Faudrais integrer ca directement dans SaveFits pour que tout TeleAuto puisse le faire !
             SaveFITS(copy(nom,1,i)+'_R'+copy(nom,i+1,99)+'.fit',TabImgInt,TabImgDouble,1,1,ImgInfos); //nolang
             SaveFITS(copy(nom,1,i)+'_G'+copy(nom,i+1,99)+'.fit',TabImgInt,TabImgDouble,2,1,ImgInfos); //nolang
             SaveFITS(copy(nom,1,i)+'_B'+copy(nom,i+1,99)+'.fit',TabImgInt,TabImgDouble,3,1,ImgInfos); //nolang
             end
          else
             begin
             SaveFITS(FileName,TabImgInt,TabImgDouble,1,3,ImgInfos);
             end;
        1:if config.FormatCouleur=0 then
             begin
             nom:=trim(nom);
             i:=length(nom);
             while ((nom[i]>='0')and(nom[i]<='9'))or(i<=1) do dec(i);
             SaveCPAV3(copy(nom,1,i)+'_R'+copy(nom,i+1,99)+'.cpa',TabImgInt,1,ImgInfos); //nolang
             SaveCPAV3(copy(nom,1,i)+'_G'+copy(nom,i+1,99)+'.cpa',TabImgInt,2,ImgInfos); //nolang
             SaveCPAV3(copy(nom,1,i)+'_B'+copy(nom,i+1,99)+'.cpa',TabImgInt,3,ImgInfos); //nolang
             end
         else
            begin
            SaveCPAV3(FileName,TabImgInt,1,ImgInfos);
            end;
        5:if config.FormatCouleur=0 then begin
             nom:=trim(nom);
             i:=length(nom);
             while ((nom[i]>='0')and(nom[i]<='9'))or(i<=1) do dec(i);
             SaveCPAV4d(copy(nom,1,i)+'_R'+copy(nom,i+1,99)+'.cpa',TabImgInt,1,ImgInfos); //nolang
             SaveCPAV4d(copy(nom,1,i)+'_G'+copy(nom,i+1,99)+'.cpa',TabImgInt,2,ImgInfos); //nolang
             SaveCPAV4d(copy(nom,1,i)+'_B'+copy(nom,i+1,99)+'.cpa',TabImgInt,3,ImgInfos); //nolang
             end
          else
             begin
             SaveCPAV4d(FileName,TabImgInt,1,ImgInfos);
             end;
        2,3:SaveBmp (FileName,TabImgInt,TabImgDouble,ImgInfos);
        4:SaveJpg (FileName,TabImgInt,TabImgDouble,ImgInfos);
        end;
   8:begin
     if config.FormatCouleur=0 then
        begin
        nom:=trim(nom);
        i:=length(nom);
        while ((nom[i]>='0')and(nom[i]<='9'))or(i<=1) do dec(i);
        // Faudrais integrer ca directement dans SaveFits pour que tout TeleAuto puisse le faire !
        if Config.TypeSaveFits=0 then
           begin
           SaveFITS(copy(nom,1,i)+'_R'+copy(nom,i+1,99)+'.fit',TabImgInt,TabImgDouble,1,1,ImgInfos); //nolang
           SaveFITS(copy(nom,1,i)+'_G'+copy(nom,i+1,99)+'.fit',TabImgInt,TabImgDouble,2,1,ImgInfos); //nolang
           SaveFITS(copy(nom,1,i)+'_B'+copy(nom,i+1,99)+'.fit',TabImgInt,TabImgDouble,3,1,ImgInfos); //nolang
           end
        else
           begin
           ConvertFITSRealToInt(TabImgDouble,TabImgInt,ImgInfos);
           SaveFITS(copy(nom,1,i)+'_R'+copy(nom,i+1,99)+'.fit',TabImgInt,TabImgDouble,1,1,ImgInfos); //nolang
           SaveFITS(copy(nom,1,i)+'_G'+copy(nom,i+1,99)+'.fit',TabImgInt,TabImgDouble,2,1,ImgInfos); //nolang
           SaveFITS(copy(nom,1,i)+'_B'+copy(nom,i+1,99)+'.fit',TabImgInt,TabImgDouble,3,1,ImgInfos); //nolang
           ConvertFITSIntToReal(TabImgInt,TabImgDouble,ImgInfos);
           end;
        end
     else
        begin
        if Config.TypeSaveFits=0 then
           SaveFITS(FileName,TabImgInt,TabImgDouble,1,3,ImgInfos)
        else
           begin
           ConvertFITSRealToInt(TabImgDouble,TabImgInt,ImgInfos);
           SaveFITS(FileName,TabImgInt,TabImgDouble,1,3,ImgInfos);
           ConvertFITSIntToReal(TabImgInt,TabImgDouble,ImgInfos);
           end;
        end;
   end;
   end;
end;

procedure SaveImage(FileName:string;
                    var TabImgInt:PTabImgInt;
                    var TabImgDouble:PTabImgDouble;
                    var ImgInfos:TImgInfos);
var
   PosEsp,i:Integer;
   Nom,Ext:string;
begin
Ext:=UpperCase(ExtractFileExt(FileName));
if (Ext='.FIT') or (Ext='.FTS') or (Ext='.FITS') then  //nolang
   begin
   case ImgInfos.TypeData of
      2,5,6:SaveFITS(FileName,TabImgInt,TabImgDouble,1,1,ImgInfos);
        7,8:SaveFITS(FileName,TabImgInt,TabImgDouble,1,3,ImgInfos);
      end;
   end
else if Ext='.CPA' then  //nolang
   begin
   case ImgInfos.TypeData of
        2:SaveCpaV4d(FileName,TabImgInt,1,ImgInfos);
  5,6,7,8:WriteSpy(lang('Format incompatible'));
      end;
   end
else if Ext='.PIC' then  //nolang
   begin
   case ImgInfos.TypeData of
        2:SavePic(FileName,TabImgInt,ImgInfos);
  5,6,7,8:WriteSpy(lang('Format incompatible'));
      end;
   end
else if Ext='.BMP' then  //nolang
   begin
   case ImgInfos.TypeData of
        2:SaveBmp(FileName,TabImgInt,TabImgDouble,ImgInfos);
  5,6,7,8:WriteSpy(lang('Format incompatible'));
      end;
   end
else if (Ext='.JPG') or (Ext='.JPEG') then //nolang
   begin
   case ImgInfos.TypeData of
        2:SaveJpg(FileName,TabImgInt,TabImgDouble,ImgInfos);
  5,6,7,8:WriteSpy(lang('Format incompatible'));
      end;
   end;
end;

// Ecrit dans le fichier Espion
procedure WriteSpy(Line:string);
var
   DT:TDateTime;
   Year,Month,Day,Hour,Min,Sec,MSec:Word;
   Tps,SHour,SMin,SSec:string;
begin
InSpy:=True;
try
DT:=GetRealDateTime;
DecodeDate(DT,Year,Month,Day);
DecodeTime(DT,Hour,Min,Sec,MSec);

if Hour<10 then SHour:='0'+IntToStr(Hour) else SHour:=IntToStr(Hour);
if Min<10 then SMin:='0'+IntToStr(Min) else SMin:=IntToStr(Min);
if Sec<10 then SSec:='0'+IntToStr(Sec) else SSec:=IntToStr(Sec);

Tps:=SHour+':'+Smin+':'+SSec;

//   Writeln(F,Tps+' '+Line);
SpyLines.Add(Tps+' '+Line);
//if not(config.Initialisation) and Assigned(pop_spy) then
//   begin
//   pop_spy.list_spy.items.Add(Tps+' '+Line);
//   if pop_spy.list_spy.Items.Count>7 then pop_spy.list_spy.TopIndex:=pop_spy.list_spy.Items.Count-7;
//   end;

finally
InSpy:=False;
end;
end;

// Ecrit le fichier spy dans pop_spy
procedure ReadInit;
var
F:TextFile;
Line:string;
begin
AssignFile(F,ExtractFilePath(Application.ExeName)+'Spy.log'); //nolang
try
Append(F);

while SpyLines.Count<>0 do
   begin
   Writeln(F,SpyLines[0]);
   SpyLines.Delete(0);
   end;

finally
CloseFile(F);
end;

AssignFile(F,ExtractFilePath(Application.ExeName)+'Spy.log'); //nolang
try
Reset(F);
while not(eof(F)) do
   begin
   Readln(F,Line);
   pop_spy.list_spy.items.Add(Line);
   if pop_spy.list_spy.Items.Count>7 then pop_spy.list_spy.TopIndex:=pop_spy.list_spy.Items.Count-7;
   end;
finally
CloseFile(F);
Application.ProcessMessages;
end;

pop_main.Timer1.Enabled:=True;
end;


procedure file2string(f:string; var s:string);
var
fi:textfile;
str:string;
begin
     assignfile(fi,f);
     reset(fi);
     while not eof(fi) do
     begin
          readln(fi,str);
          s:=str+#10#13;
     end;
end;


function do_the_asteroid_file(p:p_critlist):boolean;
var
ini:tMeminifile;
begin
     ini:=tMeminifile.create(extractfilepath(application.exename)+'asteroid\'+p.nom+'.tea'); //nolang
     ini.writestring('Various',lang('Nom'),p.nom);
     ini.writestring('Various','Number',p.numero);
     ini.writestring('Various','Creation',datetimetostr(now));
     ini.writestring('Elements','Date',p.date);
     ini.writestring('Elements','e',p.e);
     ini.writestring('Elements','a',p.a);
     ini.writestring('Elements','incl',p.incl);
     ini.writestring('Elements','node',p.node);
     ini.writestring('Elements','peri',p.peri);
     ini.writestring('Elements','M',p.M);
     ini.writestring('Elements','H',p.H);
     ini.writestring('Elements','G',p.G);
     ini.writestring('Elements','Motion',p.motion);
     Ini.UpdateFile;
     ini.free;
     if fileexists((extractfilepath(application.exename)+'asteroid\'+p.nom+'.tea')) then result:=true else result:=false; //nolang
end;


function read_asteroid_file(p:p_critlist):boolean;
var
ini:tMeminifile;
begin
     result:=true;

     if p.nom='' then
     begin
         result:=false;
         exit;
     end;

     if fileexists((extractfilepath(application.exename)+'asteroid\'+p.nom+'.tea')) then //nolang
     begin
           ini:=tMeminifile.create(extractfilepath(application.exename)+'asteroid\'+p.nom+'.tea'); //nolang
           p.nom:=ini.readstring('Various',lang('Nom'),'?');
           p.numero:=ini.readstring('Various','Number','?');
           p.creation:=strtodatetime(ini.readstring('Various','Creation','1899.01.01'));
           p.date:=ini.readstring('Elements','Date','?');
           p.e:=ini.readstring('Elements','e','?');
           p.a:=ini.readstring('Elements','a','?');
           p.incl:=ini.readstring('Elements','incl','?');
           p.node:=ini.readstring('Elements','node','?');
           p.peri:=ini.readstring('Elements','peri','?');
           p.m:=ini.readstring('Elements','M','?');
           p.h:=ini.readstring('Elements','H','?');
           p.g:=ini.readstring('Elements','G','?');
           p.motion:=ini.readstring('Elements','Motion','?');
           Ini.UpdateFile;
           ini.free;
     end
     else
     begin
          result:=false;
          exit;
     end;
end;

procedure ConvertFromBMPStream(MyBitmap:TMemoryStream;
                               var ImgInt:PTabImgInt;
                               var ImgInfos:TImgInfos);
var
F:file;
BitmapFileHeader:TBitmapFileHeader;
BitmapInfo:TBitmapInfo;
Line:PLigByte;
RGBQuad:TRGBQuad;
RGBTriple:TRGBTriple;
i,j,k:Integer;
AddPix:Byte;
begin
MyBitmap.Seek(0,soFromBeginning);
MyBitmap.Read(BitmapFileHeader,Sizeof(TBitmapFileHeader));
MyBitmap.Read(BitmapInfo,Sizeof(TBitmapInfo)-4);

if (BitmapFileHeader.Bftype<>19778) then
   raise ErrorBitmap.Create(lang('Le fichier n''est pas au format bmp'));
if (BitmapInfo.bmiHeader.biPlanes<>1) then
   raise ErrorBitmap.Create(lang('Le fichier n''est pas au format bmp'));
if (BitmapInfo.bmiHeader.biCompression<>BI_RGB) then
   raise ErrorFileIO.Create(lang('Je ne peux pas convertir les formats bmp compressées'));
if (BitmapInfo.bmiHeader.biBitCount=1) then
   raise ErrorFileIO.Create(lang('Je ne peux pas convertir le format bmp 1 bit'));
if (BitmapInfo.bmiHeader.biBitCount=4) then
   raise ErrorFileIO.Create(lang('Je ne peux pas convertir le format bmp 4 bits'));
if (BitmapInfo.bmiHeader.biBitCount=32) then
   raise ErrorFileIO.Create(lang('Je ne peux pas convertir le format bmp 16 bits'));


ImgInfos.Sx:=BitmapInfo.bmiHeader.biWidth;
ImgInfos.Sy:=BitmapInfo.bmiHeader.biHeight;

case BitmapInfo.bmiHeader.biBitCount of
   8:begin
//     AddPix:=Sx mod 4;
     AddPix:=4-(ImgInfos.Sx mod 4);
     if AddPix=4 then AddPix:=0;

     Getmem(ImgInt,4);
     Getmem(ImgInt^[1],ImgInfos.Sy*4);
     for i:=1 to ImgInfos.Sy do Getmem(ImgInt^[1]^[i],ImgInfos.Sx*2);

     ImgInfos.Min[1]:=0;
     ImgInfos.Max[1]:=255;
     ImgInfos.TypeData:=2;
     ImgInfos.NbPlans:=1;

     Getmem(Line,ImgInfos.Sx);

     try

     for i:=0 to 255 do
        begin
        MyBitmap.Read(RGBQuad,Sizeof(TRGBQuad));
        Pal[i].Rouge:=RGBQuad.rgbRed;
        Pal[i].Vert :=RGBQuad.rgbGreen;
        Pal[i].Bleu :=RGBQuad.rgbBlue;
        end;

     for j:=1 to ImgInfos.Sy do
        begin
        MyBitmap.Read(Line^,ImgInfos.Sx);
        for i:=1 to ImgInfos.Sx do ImgInt^[1]^[j]^[i]:=Line^[i];
        MyBitmap.Read(Line^,AddPix);
        end;

     finally
     Freemem(Line,ImgInfos.Sx);
     end;
     end;
   16:begin
      AddPix:=4-(((ImgInfos.Sx)*3) mod 4);
      if AddPix=4 then AddPix:=0;

      ImgInfos.NbPlans:=3;
      Getmem(ImgInt,4*ImgInfos.NbPlans);
      for k:=1 to ImgInfos.NbPlans do
         begin
         Getmem(ImgInt^[k],ImgInfos.Sy*4);
         for i:=1 to ImgInfos.Sy do Getmem(ImgInt^[k]^[i],ImgInfos.Sx*2);
         end;

      ImgInfos.Min[1]:=0;
      ImgInfos.Max[1]:=31;
      ImgInfos.Min[2]:=0;
      ImgInfos.Max[2]:=31;
      ImgInfos.Min[3]:=0;
      ImgInfos.Max[3]:=31;
      ImgInfos.TypeData:=7;

      Getmem(Line,ImgInfos.Sx*2);

      try

      for j:=1 to ImgInfos.Sy do
         begin
         MyBitmap.Read(Line^,ImgInfos.Sx*2);
         for i:=1 to ImgInfos.Sx do
            begin
//            ImgInt^[1]^[j]^[i]:=Line^[(i-1)*2+2] and $1F;
//            ImgInt^[2]^[j]^[i]:=((Line^[(i-1)*2+2] shr 4) and $07)+(Line^[(i-1)*2+1] and $03) shl 3;
//            ImgInt^[3]^[j]^[i]:=(Line^[(i-1)*2+1] and $7C) shr 2;

// Mieux
            ImgInt^[1]^[j]^[i]:=(Line^[(i-1)*2+2] and $7C) shr 2;
            ImgInt^[2]^[j]^[i]:=((Line^[(i-1)*2+1] shr 5) and $07)+(Line^[(i-1)*2+2] and $03) shl 3;
            ImgInt^[3]^[j]^[i]:=Line^[(i-1)*2+1] and $1F;

//            ImgInt^[1]^[j]^[i]:=Line^[(i-1)*2+2] and $3E;
//            ImgInt^[2]^[j]^[i]:=(Line^[(i-1)*2+2] shr 6)+(Line^[(i-1)*2+1] and $07) shl 2;
//            ImgInt^[3]^[j]^[i]:=(Line^[(i-1)*2+1] and $F8) shr 3;

            end;
         MyBitmap.Read(Line^,AddPix);
         end;

      finally
      Freemem(Line,ImgInfos.Sx*2);
      end;
      end;
   24:begin
      AddPix:=4-(((ImgInfos.Sx)*3) mod 4);
      if AddPix=4 then AddPix:=0;
// LargBmp:=
      ImgInfos.NbPlans:=3;
      Getmem(ImgInt,4*ImgInfos.NbPlans);
      for k:=1 to ImgInfos.NbPlans do
         begin
         Getmem(ImgInt^[k],ImgInfos.Sy*4);
         for i:=1 to ImgInfos.Sy do Getmem(ImgInt^[k]^[i],ImgInfos.Sx*2);
         end;

      ImgInfos.Min[1]:=0;
      ImgInfos.Max[1]:=255;
      ImgInfos.Min[2]:=0;
      ImgInfos.Max[2]:=255;
      ImgInfos.Min[3]:=0;
      ImgInfos.Max[3]:=255;
      ImgInfos.TypeData:=7;

      Getmem(Line,ImgInfos.Sx*3);

      try

      for j:=1 to ImgInfos.Sy do
         begin
         MyBitmap.Read(Line^,ImgInfos.Sx*3);
         for i:=1 to ImgInfos.Sx do
            begin
            ImgInt^[1]^[j]^[i]:=Line^[(i-1)*3+3];
            ImgInt^[2]^[j]^[i]:=Line^[(i-1)*3+2];
            ImgInt^[3]^[j]^[i]:=Line^[(i-1)*3+1];
//            ImgInt^[1]^[j]^[i]:=Round((Line^[(i-1)*3+1]+Line^[(i-1)*3+2]+Line^[(i-1)*3+3])/3);
            end;
         MyBitmap.Read(Line^,AddPix);
         end;

      finally
      Freemem(Line,ImgInfos.Sx*3);
      end;
      end;
   end;

pop_main.SeuilsEnable;
//pop_seuils.PalExpl;
end;

procedure ReadBMP(Nom:TFileName;
                  var ImgInt:PTabImgInt;
                  var ImgInfos:TImgInfos);
var
MyBitmap:TMemoryStream;
begin
MyBitmap:=TMemoryStream.Create;
try
try
ImgInfos.DateTime:=FileDateToDateTime(FileAge(Nom));
ImgInfos.BZero:=0;
ImgInfos.BScale:=1;
except
// Pas besoin de tout arreter !
end;
MyBitmap.LoadFromFile(Nom);
ConvertFromBMPStream(MyBitmap,ImgInt,ImgInfos);
finally
MyBitmap.Free;
end;
end;

     { pch 11/1
procedure SaveBMP(Nom:TFileName;
                  ImgInt:PTabImgInt;
                  ImgDouble:PTabImgDouble;
                  Sx,Sy:Integer;
                  Min,Max:TSeuils;
                  TypeData:Byte;
                  TypeComplexe:Byte);
var
BitMap:TBitMap;
begin
Bitmap:=TBitmap.Create;
try
Bitmap.Handle:=VisuImgSave(ImgInt,ImgDouble,TypeData,TypeComplexe,Sx,Sy,Min,Max);
case TypeData of
   2,5,6:Bitmap.PixelFormat:=pf8bit;
   7:Bitmap.PixelFormat:=pf24bit;
   end;
Bitmap.SaveToFile(Nom);
finally
Bitmap.Free;
end;
end;}

procedure SaveBMP(Nom:TFileName;
                  ImgInt:PTabImgInt;
                  ImgDouble:PTabImgDouble;
                  ImgInfos:TImgInfos);
var
BitMap:TBitMap;
begin
WriteSpy(lang('SaveBmp : Sauvegarde de ')+Nom);

Bitmap:=TBitmap.Create;
try
//Bitmap.Handle:=VisuImgSave(ImgInt,ImgDouble,TypeData,TypeComplexe,Sx,Sy,min,max);
Bitmap.Handle:=VisuImgAPI(ImgInt,ImgDouble,ImgInfos,1,1,1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Sx,ImgInfos.Sy);
//case TypeData of
//   2,5,6:Bitmap.PixelFormat:=pf8bit;
//   7:Bitmap.PixelFormat:=pf24bit;
//   end;
Bitmap.pixelformat:=pf24bit;
Bitmap.SaveToFile(Nom);
finally
Bitmap.Free;
end;
end;

procedure SaveBMPHandle(Nom:TFileName;
                  ImgInt:PTabImgInt;
                  ImgDouble:PTabImgDouble;
                  ImgInfos:TImgInfos;
                  Handle:Integer);
var
BitMap:TBitMap;
begin
WriteSpy(lang('SaveBmp : Sauvegarde de ')+Nom);

Bitmap:=TBitmap.Create;
try
//Bitmap.Handle:=VisuImgSave(ImgInt,ImgDouble,TypeData,TypeComplexe,Sx,Sy,min,max);
//Bitmap.Handle:=VisuImgAPI(ImgInt,ImgDouble,ImgInfos,1,1,1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Sx,ImgInfos.Sy);
Bitmap.Handle:=Handle;
//case TypeData of
//   2,5,6:Bitmap.PixelFormat:=pf8bit;
//   7:Bitmap.PixelFormat:=pf24bit;
//   end;
Bitmap.pixelformat:=pf24bit;
Bitmap.SaveToFile(Nom);
finally
Bitmap.Free;
end;
end;

procedure ReadJPG(Nom:TFileName;
                  var ImgInt:PTabImgInt;
                  var ImgInfos:TImgInfos);
var
ImageJPEG:TJPEGImage;
MyBitmap:TMemoryStream;
ImageBMP:TBitmap;
begin
   ImageJPEG:=TJPEGImage.Create;
   try
   try
   ImgInfos.DateTime:=FileDateToDateTime(FileAge(Nom));
   ImgInfos.BZero:=0;
   ImgInfos.BScale:=1;
   except
   // Pas besoin de tout arreter !
   end;
   ImageJPEG.LoadFromFile(Nom);
   ImageBMP:=TBitmap.Create;
      try
      ImageBMP.PixelFormat:=pf24bit;
      ImageBMP.Width:=ImageJPEG.Width;
      ImageBMP.Height:=ImageJPEG.Height;
      ImageBMP.Canvas.Draw(0,0,ImageJPEG);
      MyBitmap:=TMemoryStream.Create;
         try
         ImageBMP.SaveToStream(MyBitmap);
         ConvertFromBMPStream(MyBitmap,ImgInt,ImgInfos);
         finally
         MyBitmap.Free;
         end;
      finally
      ImageBMP.Free;
      end;
   finally
   ImageJPEG.Free;
   end;

end;

procedure SaveJPG(Nom:TFileName;
                  ImgInt:PTabImgInt;
                  ImgDouble:PTabImgDouble;
                  ImgInfos:TImgInfos);
var
BitMap:TBitMap;
ImageJPEG:TJPEGImage;
begin
WriteSpy(lang('SaveJpg : Sauvegarde de ')+Nom);

Bitmap:=TBitmap.Create;
try
ImageJPEG:=TJPEGImage.Create;
try
Bitmap.Handle:=VisuImgAPI(ImgInt,ImgDouble,ImgInfos,1,1,1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Sx,ImgInfos.Sy);
Bitmap.pixelformat:=pf24bit;
ImageJPEG.CompressionQuality:=Config.JpegQuality;
ImageJPEG.Assign(Bitmap);
ImageJPEG.SaveToFile(Nom);
finally
ImageJPEG.Free;
end;
finally
Bitmap.Free;
end;
end;

procedure SaveJPGHandle(Nom:TFileName;
                        ImgInt:PTabImgInt;
                        ImgDouble:PTabImgDouble;
                        ImgInfos:TImgInfos;
                        Handle:Integer);
var
BitMap:TBitMap;
ImageJPEG:TJPEGImage;
begin
WriteSpy(lang('SaveJpg : Sauvegarde de ')+Nom);

Bitmap:=TBitmap.Create;
try
ImageJPEG:=TJPEGImage.Create;
try
//Bitmap.Handle:=VisuImgAPI(ImgInt,ImgDouble,ImgInfos,1,1,1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Sx,ImgInfos.Sy);
Bitmap.Handle:=Handle;
Bitmap.pixelformat:=pf24bit;
ImageJPEG.CompressionQuality:=Config.JpegQuality;
ImageJPEG.Assign(Bitmap);
ImageJPEG.SaveToFile(Nom);
finally
ImageJPEG.Free;
end;
finally
Bitmap.Free;
end;
end;

procedure SaveText(Nom:TFileName;
                  ImgInt:PTabImgInt;
                  ImgDouble:PTabImgDouble;
                  Sx,Sy:Integer;
                  Min,Max:TSeuils;
                  TypeData,NbPlans:Byte;
                  TypeComplexe:Byte);
var
i,j,k:Integer;
ValInt:Smallint;
ValDouble1,ValDouble2:Double;
F:TextFile;
begin
AssignFile(F,Nom);
Rewrite(F);
try

for k:=1 to NbPlans do
   begin
   for j:=1 to Sy do
      begin
      case TypeData of
         2,7:for i:=1 to Sx do
              begin
              ValInt:=ImgInt^[k]^[j]^[i];
              Write(F,IntToStr(ValInt)+' ');
              end;
         5:for i:=1 to Sx do
              begin
              ValDouble1:=ImgDouble^[k]^[j]^[i];
              Write(F,FloatToStr(Int(ValDouble1*1000)/1000)+' ');
              end;
         6:for i:=1 to Sx do
              begin
              ValDouble1:=ImgDouble^[1]^[j]^[i];
              ValDouble2:=ImgDouble^[2]^[j]^[i];
              Write(F,FloatToStr(Int(ValDouble1*1000)/1000)+'+i'+ //nolang
                 FloatToStr(Int(ValDouble2*1000)/1000));
              end;
         end;
      Writeln(F,'');
      end;
   Writeln(F,'');
   end;

finally
CloseFile(F);
end;
end;


procedure read_internet_conf;
var
ini:tMeminifile;
begin
     ini:=tMeminifile.create(extractfilepath(application.exename)+'\inet.ini');  //nolang
     config.internet.port:=strtoint(ini.readstring('connection','port','21')); //nolang
     config.internet.proxyport:=strtoint(ini.readstring('connection','proxyport','8080')); //nolang
     config.internet.proxy:=ini.readstring('connection','proxy','');  //nolang
     // ftp 1
     config.internet.ftp1_host:=ini.readstring('ftp1','host','ftp.astrosurf.com');  //nolang
     config.internet.ftp1_uid:=ini.readstring('ftp1','uid','teleauto');    //nolang
     config.internet.ftp1_pwd:=ini.readstring('ftp1','pwd','tel3914');    //nolang
     // ftp 2
     config.internet.ftp2_host:=ini.readstring('ftp2','host','ftp.astrosurf.com');  //nolang
     config.internet.ftp2_uid:=ini.readstring('ftp2','uid','teleauto');    //nolang
     config.internet.ftp2_pwd:=ini.readstring('ftp2','pwd','tel3914');    //nolang
     // mpc
     config.internet.mpc_critlist:=ini.readstring('mpc','critlist','http://cfa-www.harvard.edu/iau/Ephemerides/CritList/Soft06CritList.txt'); //nolang
     config.internet.mpc_bright1:=ini.readstring('mpc','bright1','http://cfa-www.harvard.edu/iau/Ephemerides/Bright/');                        //nolang
     config.internet.mpc_bright2:=ini.readstring('mpc','bright2','/Soft06Bright.txt');                                                         //nolang
     config.internet.mpc_comets:=ini.readstring('mpc','comets','http://cfa-www.harvard.edu/iau/Ephemerides/Comets/Soft06Cmt.txt');             //nolang
     config.internet.mpc_distant:=ini.readstring('mpc','distant','http://cfa-www.harvard.edu/iau/Ephemerides/Distant/Soft06Distant.txt');      //nolang
     config.internet.mpc_unusual:=ini.readstring('mpc','unusual','http://cfa-www.harvard.edu/iau/Ephemerides/Unusual/Soft06Unusual.txt');     //nolang

     Ini.UpdateFile;
     ini.free;
end;

procedure WriteDebug(Line:String);
var
F:TextFile;
begin
AssignFile(F,ExtractFilePath(Application.ExeName)+'Debug.txt'); //nolang
try
Append(F);
Writeln(F,TimeToStr(Now)+' '+Line);
finally
CloseFile(F);
end;
end;

var
Time1,Time2:TDateTime;

procedure Tic;
begin
Time1:=Now;
end;

procedure Toc;
var
F:TextFile;
begin
Time2:=Now;
AssignFile(F,ExtractFilePath(Application.ExeName)+'Debug.txt'); //nolang
try
Append(F);
Writeln(F,lang('Temps : ')+MyFloatToStr((Time2-Time1)*24*3600*1000,3));
finally
CloseFile(F);
end;
end;

function SavePSD(nom:string;image:PTabImgInt;infos:TImgInfos;order:boolean):boolean;
var fich:file;hPSD:Header_PSD;plan,y,x:integer;llen:integer;pixel:word;line:pointer;
begin
 result:=false;
 if (infos.NbPlans <> 1) and (infos.NbPlans <> 3) then
  begin
   messagebox(0,Pchar(lang('L''image doit être sur 1 ou 3 plans')),
      Pchar(lang('Information')),$1010);
   exit;
  end;
 fillchar(hPSD,sizeof(hPSD),0);
 hPSD.signature:='8BPS'; //nolang
 hPSD.version:=$0100;
 hPSD.width:=Swap32(Swap(infos.Sx));
 hPSD.height:=Swap32(Swap(infos.Sy));
 hPSD.depth:=$1000;
 if infos.nbPlans = 1 then
  begin
   hPSD.channels:=$0100;
   hPSD.mode:=$0100;
  end;
 if infos.nbPlans = 3 then
  begin
   hPSD.channels:=$0300;
   hPSD.mode:=$0300;
  end;
 assign(fich,nom);
 {$I-}
 rewrite(fich,1);
 {$I+}
 if ioresult <> 0 then
  begin
   messagebox(0,Pchar(lang('Impossible de sauvegarder le fichier PSD')),
      Pchar(lang('Erreur')),$1010);
   exit;
  end;
 llen:=infos.Sx shl 1;
 if order=true then
  begin
   getmem(line,llen);
   if line = NIL then
    begin
     closefile(fich);
     exit;
    end;
   blockwrite(fich,hPSD,sizeof(hPSD));
   for plan:=1 to infos.nbPlans do
    begin
     for y:=infos.Sy downto 1 do
      begin
        swapline(Image^[plan]^[y],line,llen shr 1);
        blockwrite(fich,line^,llen);
       end;
    end;
   freemem(line);
  end
 else
  begin
   blockwrite(fich,hPSD,sizeof(hPSD));
   for plan:=1 to infos.nbPlans do
    begin
     for y:=infos.Sy downto 1 do
      begin
        blockwrite(fich,Image^[plan]^[y]^,llen);
       end;
    end;
  end;
 closefile(fich);
 result:=true;
end;

procedure ReadApn(Nom:string;
                  var TabImgInt:PTabImgInt;
                  var ImgInfos:TImgInfos);
var
   sx,sy,width,y,row,code:integer;image:PWordArray;
   fab,modele:tapnstr;
   nomcam:string[80];
begin
 WriteSpy(lang('ReadApn : Lecture de ')+Nom);
 nom:=nom + #0;
 get_file_infos(pchar(nom),fab,modele,sx,sy);
 nomcam:=fab + ' ' + modele;
// messagebox(0,@fab,@modele,$1010);
 getmem(image,sx * sy * sizeof(word));
try
 code:=load_cfa(pchar(nom),image,sx,sy);
except
 freemem(image);
 nom:=lang('Echec de la lecture de ') + nom;
 Messagebox(0,@nom[1],Pchar(lang('Erreur')),$1010);
 exit;
end;
 if code <> 0 then
  begin
   freemem(image);
   nom:=lang('Echec de la lecture de ') + nom;
   Messagebox(0,@nom[1],Pchar(lang('Erreur')),$1010);
   exit;
  end;
//Transfert vers une image Teleauto (avec inversion haut - bas)
 getmem(TabImgInt,4);
 getmem(TabImgInt^[1],Sy * sizeof(pointer));
 width:=Sx * sizeof(word);
 row:=0;
 for y:=Sy downto 1 do
  begin
   Getmem(TabImgInt^[1]^[y],width);
   move(image^[row],TabImgInt^[1]^[y]^,width);
   row:=row + Sx;
  end;
 freemem(image);
 ImgInfos.Commentaires[1]:=lang('Photo ') +  extractfilename(nom);
 ImgInfos.Commentaires[2]:=lang('prise avec un ') + nomcam;
 ImgInfos.DateTime:=Date;
 ImgInfos.Camera:=nomcam;
 ImgInfos.BZero:=0;
 ImgInfos.BScale:=1;
 ImgInfos.BitPix:=16;
 ImgInfos.Sx:=Sx;
 ImgInfos.Sy:=Sy;
 ImgInfos.NbPlans:=1;
 ImgInfos.TypeData:=2;
 ImgInfos.Min[1]:=0;
 ImgInfos.Max[1]:=4096;   //valeur max. pour numérisation sur 12 bits
end;

function ReadPhotoNumerique(FileName:string;
                            var TabImgInt:PTabImgInt;
                            var ImgInfos:TImgInfos;
                            Raw:Boolean):Boolean;
var
   Image:Ptabimgint;
   TabImgDouble:PTabImgDouble;
   Resultat:Byte;
   y:Integer;
begin
Result:=True;
if not FileExists(FileName) then
   begin
   Result:=False;
   Exit;
   end;

ImgInfos.Typedata:=2; // Par defaut c'est des entiers
ImgInfos.NbPlans:=1;  // Par defaut un seul plan

Application.ProcessMessages;
ReadApn(FileName,Image,ImgInfos);
if Raw = False then
   begin
   CFA_RGB(image,nil,TabImgInt,TabImgDouble,4,ImgInfos.Typedata,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,Resultat);
   ImgInfos.TypeData:=7;
   ImgInfos.NbPlans:=3;
   ImgInfos.Min[1]:=0;
   ImgInfos.Min[2]:=0;
   ImgInfos.Min[3]:=0;
   ImgInfos.Max[1]:=2048;
   ImgInfos.Max[2]:=2048;
   ImgInfos.Max[3]:=2048;
   for y:=1 to ImgInfos.Sy do Freemem(Image^[1]^[y],ImgInfos.Sy * 2);
   Freemem(Image^[1],ImgInfos.Sy * sizeof(pointer));
   Freemem(Image,4);
   end
else
   begin
   TabImgInt:=Image;
   end;

ImgInfos.FileName:=FileName;
end;


begin
InSpy:=False;
end.
