unit u_general;

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

                               fonctions generales

--------------------------------------------------------------------------------}

interface

uses math, sysutils, dialogs, classes, u_class, extctrls, Windows, u_constants,
     Forms, winsock, ShellApi, skychart, pu_rapport, Graphics, StdCtrls, Controls;

function  StrToHeure(Line:string):TDateTime;
function  MyStrToDate(Line:string):TDateTime;
function  AlphaToStr(Alpha:Double):string;
function  DeltaToStr(Delta:Double):string;
function  DeltaToStrAstrom(Delta:Double):string;
function  AlphaToStrAstrom(Alpha:Double):string;
function  StrToAlpha(Line:string):Double;
function  StrToDelta(Line:string):Double;
function  StrToDegrees(Line:string):Double;
function  IncrementePose(Pose:Single):Single;
function  DecrementePose(Pose:Single):Single;
function  ComprimeTexte(Texte:string;LongueurMax:Integer):string;
function  MyStrToFloat(Line:string):Double;
function  FloatToStrHour(HourFloat:Double):string;
function  GetRealDateTime:TDateTime;
function  GetStrDateRep:string;
function  GetStrTimeBios:string;
function  GetStrTimeBiosHP:string;
function  GetStrDateTimeBios:string;
procedure get_coordinates(alp,del, fov_x,fov_y:double; var x_1,x_2,y_1,y_2:double);
function  GetFileList(const FileSpec:string;full:boolean;list:TStrings):LongInt;
function  HasAttr(const FileName:string;Attr:Word):Boolean;
function  ValidDIR(const DirName:string):string;
function  Rmod(x,y:Double):Double;
function  sgn(x:Double):Double ;
//function  load_image(p:pHeader; var data:PTabImgInt; read_data:boolean):byte;
function  find_starname(s:string; var is_a_star:boolean):Tstarname;
function  GetNomGenerique(Nom:string):string;
function  GetNomFichier(Nom:string):string;
function  make_my_day(day,hour,min:integer; sec:double):double;
function  TimeToStr(DateTime:TDatetime):string;
function  TimeToStrExtend(DateTime:TDatetime):string;
function  DateToStr(DateTime:TDateTime):string;
function  DateToStrSlash(DateTime:TDateTime):string;
procedure CalculeBarycentreTempsDePose(ListeTempsDePose:PLigInteger;
                                       ListeDate:PLigDate;
                                       Nb:Integer;
                                       TypePose:Byte;
                                       var TempsPoseFinal:Integer;
                                       var DateTimeFinal:TDateTime);
function  get_numero(s:string):string;
procedure ReservePortSerie(ComCh:String);
procedure LiberePortSerie(ComCh:String);
function  PortSerieIsReserve(ComCh:String):Boolean;
procedure do_sleep(sleeptime:double);
procedure SearchFile;
function  lat2string(lat:double):string;
function  long2string (lng:double):string;
function  StrToDateFITS(Line:string):TDateTime;
function  hour_angle2string(x:double):string;
function  correct_nom(s:string):string;
function  Filtername2index(s:string):integer;
procedure Kill_List(liste:Tlist; complete:boolean);
procedure PortWrite(Contenu:Byte;Adresse:Word);
function  PortRead(Adresse:Word):Byte;

procedure GetmemImg(var ImgInt:PTabImgInt;
                    var ImgDouble:PTabImgDouble;
                    Sx,Sy:Integer;
                    TypeData,NbPlans:Byte);
procedure FreememImg(var ImgInt:PTabImgInt;
                     var ImgDouble:PTabImgDouble;
                     Sx,Sy:Integer;
                     TypeData,NbPlans:Byte);
procedure MoveImg(var ImgIntIn:PTabImgInt;
                  var ImgDoubleIn:PTabImgDouble;
                  var ImgIntOut:PTabImgInt;
                  var ImgDoubleOut:PTabImgDouble;
                  Sx,Sy:Integer;
                  TypeData,NbPlans:Byte);
procedure check_system;
procedure load_profile;
function  ChangeExtToGenerique(Nom:string;TypeDonnees:Byte):string;
function  ChangeExt(Nom,NewExt:string):string;
procedure ClasseListe(Liste:TStringList);
function  MyFloatToStr(Valeur:Double;Nb:Integer):string;
function  CountNb(Line1,Line2:string):Integer;
function  pad(s:string; len:byte):string;
Procedure FindHighIndex(nom,ext : string; var i : integer);
procedure MajSystemTime(DateTime:TDateTime);
procedure getmemorystatus(var MemoryLoad:double;
                              TotalPhys,
                              AvailPhys,
                              TotalPageFile,
                              AvailPageFile,
                              TotalVirtual,
                              AvailVirtual:integer);
Function  ExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
function  GetOS:string;
function  StringToTString(Line:string):TStrings;
function  MpecFormat(DateTime:TDateTime;Alpha,Delta:Double):string;
procedure TrouveNomsGenereriques(ListeImages:TStringList;var ListeGenerique:TStringList);
function  objtype2string(i:integer):string;
function  correct_nom2(obj:pobjrec):string;
Function  Exec(cmd: string; hide: boolean): cardinal;
function  good_checksum(buf:array of byte):boolean;
function  switch(x:byte):byte;
function  find_constellation_name(s:string; var is_a_const:boolean):TConstellation;
function  not_numeric(s:string):boolean;
procedure ColoreImageBitmap(Image:TImage;Color:TColor);
procedure MySleep(Temps:Integer);
function Swap32(value:integer):integer;assembler;
procedure swapline(src,dst:pointer;width:integer);stdcall;
procedure AUSECOURS(page:string);
procedure CalculIntervales(Mini,Maxi:Double;var Debut,Pas:Double);
function MyInputQuery(const ACaption, APrompt: string;
  var Value: string): Boolean;
function StrToPreciseAlpha(Line:string):Double;
function StrToPreciseDelta(Line:string):Double;

implementation

uses pu_main,
     u_file_io,
     pu_script_builder,
     u_meca,
//     u_win2k_api,
     u_lang,
     u_hour_servers;

{function load_image(p:pHeader; var data:PTabImgInt; read_data:boolean):byte;
// PJ 10/7
// fonction tout terrain pour lire une image
var
x,y,t,mini,maxi:integer;
dttm:TDateTime;
pf:pFitsHeader;
i, offset:integer;
h3:TEnteteCPA_Ver3;
h4:TEnteteCPA_Ver4c;
NumCpa:Byte;
error, total_keys:byte;
sx,sy,moy,tempspose:integer;
min,max:tseuils;
nbplans,TypeDonnees:Byte;
ImgInfos:TImgInfos;
DateTime:TDateTime;
TabImgDouble:PTabImgDouble;
begin
       // CPA header
       result:=0;
       if uppercase(extractfileext(p.filename))='.CPA' then //nolang
       begin
           ReadcpaHeader(p.filename,h3,h4,NumCpa);
           if read_data then readcpa(p.filename,data,sx,sy,NbPlans,TypeDonnees,ImgInfos);
           case NumCpa of
              3:begin
                // on recupere les parametres du header
                p.binningX:=h3.BinningX;
                p.BinningY:=h3.BinningY;
                p.MiroirX:=h3.MiroirX;
                p.miroirY:=h3.MiroirY;
                p.focale:=h3.focale;
                p.Alpha:=h3.Alpha*180/pi;
                p.Delta:=h3.Delta*180/pi;
                p.sy:=h3.longueur;
                p.sx:=h3.largeur;
                p.pixX:=h3.PixX;
                p.pixY:=h3.PixY;
                p.Camera:=trim(h3.camera);
                p.sampling_x:=compute_sampling_x(trunc(p.focale),p.pixX,p.BinningX);
                p.sampling_y:=compute_sampling_y(trunc(p.focale),p.pixY,p.binningy);
                p.fov_x:=compute_fov_ccd(trunc(p.focale),p.pixX,p.sx);
                p.fov_Y:=compute_fov_ccd(trunc(p.focale),p.pixY,p.sy);
                end;
              4:begin
                // on recupere les parametres du header
                p.binningX:=h4.BinningX;
                p.BinningY:=h4.BinningY;
                p.MiroirX:=h4.MiroirX;
                p.miroirY:=h4.MiroirY;
                p.focale:=h4.focale;
                p.Alpha:=h4.Alpha*180/pi;
                p.Delta:=h4.Delta*180/pi;
                p.sy:=h4.longueur;
                p.sx:=h4.largeur;
                p.pixX:=h4.PixX;
                p.pixY:=h4.PixY;
                p.Camera:=trim(h4.camera);
                p.sampling_x:=compute_sampling_x(trunc(p.focale),p.pixX,p.BinningX);
                p.sampling_y:=compute_sampling_y(trunc(p.focale),p.pixY,p.binningy);
                p.fov_x:=compute_fov_ccd(trunc(p.focale),p.pixX,p.sx);
                p.fov_Y:=compute_fov_ccd(trunc(p.focale),p.pixY,p.sy);
                end;
              end;
       end // CPA header

       // FITS header
       else if (uppercase(extractfileext(p.filename))='.FIT') or //nolang
               (uppercase(extractfileext(p.filename))='.FTS') or //nolang
               (uppercase(extractfileext(p.filename))='.FITS') then //nolang
       begin
          if not read_data then readfitsheader(p.filename,pf,offset,total_keys,ImgInfos);
          if     read_data then readfitsimage(pf,p.filename,true,data,TabImgDouble,sx,sy,nbplans,typedonnees,ImgInfos);
          // binning
          p.binningX:=strtoint(pf.binx);
          p.BinningY:=strtoint(pf.biny);
          // y
          p.sy:=strtoint(pf.naxis2);
          // x
          p.sx:=strtoint(pf.naxis1);
          // focale
          if (mystrtofloat(pf.foclen)>0) and (mystrtofloat(pf.foclen)<10) then p.focale:=mystrtofloat(pf.foclen)*1000
          else p.focale:=mystrtofloat(pf.foclen);
          // alpha
          p.Alpha:=mystrtofloat(pf.CRVAL1);
          // delta
          p.Delta:=mystrtofloat(pf.CRVAL2);
          // pixel size attention formate en microns
          if mystrtofloat(pf.CDELTM1)<1 then p.PixX:=mystrtofloat(pf.CDELTM1)*1000 else p.PixX:=mystrtofloat(pf.CDELTM1);
          if mystrtofloat(pf.CDELTM2)<1 then p.pixY:=mystrtofloat(pf.CDELTM2)*1000 else p.pixY:=mystrtofloat(pf.CDELTM2);
          // sampling
          p.sampling_x:=compute_sampling_x(p.focale,p.pixX,p.binningx);
          p.sampling_y:=compute_sampling_y(p.focale,p.pixY,p.binningy);
          // fov
          p.fov_x:=compute_fov_ccd(p.focale,p.pixX,p.sx);
          p.fov_Y:=compute_fov_ccd(p.focale,p.pixy,p.sy);
          p.MiroirX:=pf.mirrorX='T';
          p.miroirY:=pf.mirrory='T';
          p.Camera:=trim(pf.instrume);
          dispose(pf);
       end
       else
       begin
           result:=2;
           exit;
       end;
end;}


procedure get_coordinates(alp,del, fov_x,fov_y:double; var x_1,x_2,y_1,y_2:double);
{PASSER RA EN HEURES DECIMALES ! fov en degres}
var
a,b:double;
begin
     a:=alp;              // coordonnees du centre
     b:=del;
     fov_x:=fov_x/15; // champ en heures dec
     fov_y:=fov_y;

     {alpha}
     {a cheval sur 24h. ex: ra centre=1h, champ +-2h}
     if (a - fov_x < 0) then
     begin
          x_2:=a-fov_x+24; // 23
          x_1:=a+fov_x;    // 3
     end;
     {a cheval sur 24h. ex: ra centre=23h, champ +-2h}
     if (a + fov_x > 24) then
     begin
          x_1:=a-fov_x;    // 21
          x_2:=a+fov_x-24; // 1
     end;
     {Cas standard}
     if (a - fov_x > 0) and (a + fov_x > 0) then
     begin
          x_1:=a-fov_x;
          x_2:=a+fov_x;
     end;

     {delta}
     {les 2 sont dans l hemisphere sud. dec -5, champ +-2}
     if (b < 0) and (b - fov_y < 0) and (b + fov_y < 0)  then
     begin
          y_2:=b+fov_y; // -3
          y_1:=b-fov_y; // -7
     end;
     {a cheval sur l equateur, decli centre negative dec -1, champ +-2}
     if (b < 0) and (b - fov_y < 0) and (b + fov_y > 0) then
     begin
          y_2:=b+fov_y; // +1
          y_1:=b-fov_y; // -3
     end;
     {a cheval sur l equateur, decli centre positive dec 1 champ +-2}
     if (b > 0) and (b - fov_y < 0) and (b + fov_y > 0) then
     begin
          y_2:=b+fov_y; // +3
          y_1:=b-fov_y; // -1
    end;
    {Hemisphere Nord}
    if (b > 0) and (b + fov_y > 0) and (b - fov_y > 0) then
    begin
          y_1:=b-fov_y;
          y_2:=b+fov_y;
    end;
end;



Function GetFileList(Const FileSpec : String; full:boolean; list : TStrings) : LongInt;
Var
  sRec  : TSearchRec;
  spec  : String;      { For holding search specification}
  sDir  : String;      { Holds full path}
  fName : String;      { For filename}
begin
  List.clear;
  spec := '';
  sDir := '';
  If (FileSpec <> '') then
   begin
     spec := ExtractFilename(FileSpec);
     sdir := ExtractFilePath(FileSpec);
   end
   else spec := '*.*'; { Default to ALL files             } //nolang
  If (sDir = '') then GetDir(0, sDir);
  If (Length(sdir) > 0) then sDir := LowerCase(ValidDIR(sDir));

  { Look for the first file matching the file specification, "FindFirst"
  { returns a non zero value if file not found.                          }

  Result := FindFirst(sDir + spec, faAnyFile - faDirectory, sRec);

  While (Result = 0) do
   begin
     If (sRec.Name[1] <> '.') then
      begin
        if full then fName := sDir + LowerCase(sRec.Name) else fname:=lowercase(srec.name);
        List.Add(fName);
     end;
     Result := FindNext(sRec);
  end;
  sysutils.FindClose(sRec);
  Result := List.Count;
end;

Function ValidDIR(Const DirName : String) : String;
 begin
   Result := Dirname;
   If (Result[Length(Result)] = '\') then Exit;
   If FileExists(Dirname) then Result := ExtractFilePath(Dirname);
   If HasAttr(Result, faDirectory) then AppendStr(Result, '\');
end;

Function HasAttr(Const FileName : String; Attr : Word) : Boolean;
begin
  Result := (FileGetAttr(FileName) and Attr) = Attr;
end;

////////////////////////////////////////////////////////////////////////////////
/////////////////////   Procedures et fonctions diverses   /////////////////////
////////////////////////////////////////////////////////////////////////////////

function IncrementePose(Pose:Single):Single;
begin
if      (Pose>=0.5) and (Pose<1)    then Result:=1
else if (Pose>=2.5) and (Pose<5)    then Result:=5
else if (Pose>=5)   and (Pose<10)   then Result:=10
else if (Pose>=15)  and (Pose<30)   then Result:=30
else if (Pose>=30)  and (Pose<60)   then Result:=60
else if (Pose>=150) and (Pose<300)  then Result:=300
else if (Pose>=300) and (Pose<600)  then Result:=600
else if (Pose>=450) and (Pose<900)  then Result:=900
else if (Pose>=600) and (Pose<1200) then Result:=1200
else Result:=Pose*2;
end;

function DecrementePose(Pose:Single):Single;
begin
if      (Pose>1)    and (Pose<=2)    then Result:=1
else if (Pose>5)    and (Pose<=10)   then Result:=5
else if (Pose>10)   and (Pose<=20)   then Result:=10
else if (Pose>30)   and (Pose<=60)   then Result:=30
else if (Pose>60)   and (Pose<=120)  then Result:=60
else if (Pose>300)  and (Pose<=600)  then Result:=300
else if (Pose>600)  and (Pose<=1200) then Result:=600
else if (Pose>1200) and (Pose<=2400) then Result:=1200
else Result:=Pose/2;
end;

function ComprimeTexte(Texte:String;LongueurMax:Integer):string;
begin
if Length(Texte)>LongueurMax then
   Result:=Copy(Texte,1,LongueurMax div 2)+'...'+Copy(Texte,Length(Texte)-LongueurMax div 2+1,LongueurMax div 2) //nolang
else Result:=Texte;
end;

function MyStrToFloat(Line:string):Double;
begin
    try
    // 0,00
    if (DecimalSeparator=',') and (Pos('.',Line)<>0) then Line[Pos('.',Line)]:=','
    // 0.00
    else if (DecimalSeparator='.') and (Pos(',',Line)<>0) then Line[Pos(',',Line)]:='.'
    // 0
    else if Pos(Decimalseparator,Line)=0 then Line:=Line+DecimalSeparator+'0';

    Result:=StrToFloat(Line);
    except
    WriteSpy(lang('MyStrToFloat : Erreur de conversion de ')+Line);
    end;
end;

// Transformation de l'ascension droite en heure
// HourFloat = ascension droite en Heures
// en chaine au format HHhMMmSSs
function FloatToStrHour(HourFloat:Double):String;
var
Hour,Min,Sec:Integer;
SHour,SMin,SSec:String;
begin
Hour:=Trunc(HourFloat);
if Hour<10 then SHour:='0'+IntToStr(Hour) else SHour:=IntToStr(Hour);
Min:=Trunc((HourFloat-Hour)*60);
if Min<10 then SMin:='0'+IntToStr(Min) else SMin:=IntToStr(Min);
Sec:=Trunc((HourFloat-Hour-Min/60)*3600);
if Sec<10 then SSec:='0'+IntToStr(Sec) else SSec:=IntToStr(Sec);

Result:=Shour+'h'+Smin+'m'+SSec+'s';
end;

// Transformation de la declinaison en degres
// en chaine au format sDDdMMmSSs
function DeltaToStr(Delta:Double):String;
var
Deg,Min,Sec:Integer;
SDeg,SMin,SSec:String;
begin
Deg:=Trunc(Abs(Delta));
Min:=Trunc((Abs(Delta)-Deg)*60);
Sec:=Round((Abs(Delta)-Deg-Min/60)*3600);
if Sec=60 then
   begin
   Sec:=0;
   Inc(Min);
   if Min=60 then
      begin
      Min:=0;
      Inc(Deg);
      end;
   end;
if Deg<10 then SDeg:='0'+IntToStr(Deg) else SDeg:=IntToStr(Deg);
if Min<10 then SMin:='0'+IntToStr(Min) else SMin:=IntToStr(Min);
if Sec<10 then SSec:='0'+IntToStr(Sec) else SSec:=IntToStr(Sec);

if Delta<0 then Result:='-'+SDeg+Config.SeparateurDegresMinutesDelta+Smin+Config.SeparateurMinutesSecondesDelta+SSec+Config.UnitesSecondesDelta
else Result:='+'+SDeg+Config.SeparateurDegresMinutesDelta+Smin+Config.SeparateurMinutesSecondesDelta+SSec+Config.UnitesSecondesDelta
end;

// Transformation de l'ascension droite en heure
// en chaine au format HHhMMmSSs
function AlphaToStr(Alpha:Double):String;
var
Hour,Min,Sec:Integer;
SHour,SMin,SSec:String;
begin
// On remet entre 0 et 24
while Alpha>24 do Alpha:=Alpha-24;
while Alpha<0 do Alpha:=Alpha+24;

Hour:=Trunc(Alpha);
Min:=Trunc((Alpha-Hour)*60);
Sec:=Round((Alpha-Hour-Min/60)*3600);
if Sec=60 then
   begin
   Sec:=0;
   Inc(Min);
   if Min=60 then
      begin
      Min:=0;
      Inc(Hour);
      if Hour=24 then Hour:=0;
      end;
   end;
if Hour<10 then SHour:='0'+IntToStr(Hour) else SHour:=IntToStr(Hour);
if Min<10 then SMin:='0'+IntToStr(Min) else SMin:=IntToStr(Min);
if Sec<10 then SSec:='0'+IntToStr(Sec) else SSec:=IntToStr(Sec);

Result:=Shour+Config.SeparateurHeuresMinutesAlpha+Smin+Config.SeparateurMinutesSecondesAlpha+SSec+Config.UnitesSecondesAlpha;
end;

// Transformation de la declinaison en degres
// en chaine au format sDDdMMmSS.SSSs
function DeltaToStrAstrom(Delta:Double):String;
var
Deg,Min,Sec,MSec:Integer;
SDeg,SMin,SSec,SMSec:String;
begin
Deg :=Trunc(Abs(Delta));
Min :=Trunc((Abs(Delta)-Deg)*60);
Sec :=Trunc((Abs(Delta)-Deg-Min/60)*3600);
MSec:=Round(((Abs(Delta)-Deg-Min/60)*3600-Sec)*1000);
if MSec=1000 then
   begin
   MSec:=0;
   Inc(Sec);
   end;
if Sec=60 then
   begin
   Sec:=0;
   Inc(Min);
   end;
if Min=60 then
   begin
   Min:=0;
   Inc(Deg);
   end;
if Deg<10 then SDeg:='0'+IntToStr(Deg) else SDeg:=IntToStr(Deg);
if Min<10 then SMin:='0'+IntToStr(Min) else SMin:=IntToStr(Min);
if Sec<10 then SSec:='0'+IntToStr(Sec) else SSec:=IntToStr(Sec);
if MSec<10 then SMSec:=lang('00')+IntToStr(MSec) //nolang
else if MSec<100 then SMSec:='0'+IntToStr(MSec)
else SMSec:=IntToStr(MSec);

if Delta<0 then Result:='-'+SDeg+Config.SeparateurDegresMinutesDelta+Smin+
   Config.SeparateurMinutesSecondesDelta+SSec+'.'+SMSec+Config.UnitesSecondesDelta
else Result:='+'+SDeg+Config.SeparateurDegresMinutesDelta+Smin+
   Config.SeparateurMinutesSecondesDelta+SSec+'.'+SMSec+Config.UnitesSecondesDelta
end;

// Transformation de l'ascension droite en heure
// en chaine au format HHhMMmSS.SSSs
function AlphaToStrAstrom(Alpha:Double):String;
var
Hour,Min,Sec,MSec:Integer;
SHour,SMin,SSec,SMSec:String;
begin
// On remet entre 0 et 24
while Alpha>24 do Alpha:=Alpha-24;
while Alpha<0 do Alpha:=Alpha+24;

Hour:=Trunc(Alpha);
Min :=Trunc((Alpha-Hour)*60);
Sec :=Trunc((Alpha-Hour-Min/60)*3600);
MSec:=Round(((Alpha-Hour-Min/60)*3600-Sec)*1000);
if MSec=1000 then
   begin
   MSec:=0;
   Inc(Sec);
   end;
if Sec=60 then
   begin
   Sec:=0;
   Inc(Min);
   end;
if Min=60 then
   begin
   Min:=0;
   Inc(Hour);
   end;
if Hour=24 then Hour:=0;
if Hour<10 then SHour:='0'+IntToStr(Hour) else SHour:=IntToStr(Hour);
if Min<10 then SMin:='0'+IntToStr(Min) else SMin:=IntToStr(Min);
if Sec<10 then SSec:='0'+IntToStr(Sec) else SSec:=IntToStr(Sec);
if MSec<10 then SMSec:=lang('00')+IntToStr(MSec) //nolang
else if MSec<100 then SMSec:='0'+IntToStr(MSec)
else SMSec:=IntToStr(MSec);

Result:=Shour+Config.SeparateurHeuresMinutesAlpha+Smin+Config.SeparateurMinutesSecondesAlpha+SSec+'.'+SMSec+Config.UnitesSecondesAlpha;
end;

// Donne l'heure BIOS TU a la seconde ( beurk, mieux a trouver )
// Ultiliser de preference GetHourDT
function GetRealDateTime:TDateTime;
var
Heures,Minutes,Secondes,Siecles,Annees,Mois,Jours:Byte;
WHeures,WMinutes,WSecondes,WAnnees,WMois,WJours:Word;
begin
   case Config.TypeOS of
      0:begin
        asm
        // Heure
        mov ah,02
        int $1a
        mov Heures,ch
        mov Minutes,cl
        mov Secondes,dh

        // Date
        mov ah,04
        int $1a
        mov Siecles,ch
        mov Annees,cl
        mov Mois,dh
        mov Jours,dl
        end;

        // Convertion de BCD
        WHeures:=((Heures and $f0) shr 4)*10+(Heures and $0f);
        WMinutes:=((Minutes and $f0) shr 4)*10+(Minutes and $0f);
        WSecondes:=((Secondes and $f0) shr 4)*10+(Secondes and $0f);
        WAnnees:=(((Siecles and $f0) shr 4)*10+(Siecles and $0f))*100+((Annees and $f0) shr 4)*10+(Annees and $0f);
        WMois:=((Mois and $f0) shr 4)*10+(Mois and $0f);
        WJours:=((Jours and $f0) shr 4)*10+(Jours and $0f);
        Result:=EncodeTime(WHeures,WMinutes,WSecondes,0)+EncodeDate(WAnnees,WMois,WJours)-config.PCMoinsTU/24;
        end;
      1:Result:=Now-config.PCMoinsTU/24;
   end;
end;

// Donne la date BIOS sous forme d'une chaine
// de la forme JJ-MM-AAAA
// Pour creer le repertoire courant
// jusqu'a 12 h on prends le jour precedent
function GetStrDateRep:string;
var
Year,Month,Day,Hour,Min,Sec,MSec:Word;
SYear,SMonth,SDay:String;
DT:TDateTime;
begin
GetHour(Year,Month,Day,Hour,Min,Sec,MSec);
DT:=EncodeDate(Year,Month,Day)+EncodeTime(Hour,Min,Sec,MSec);

if Frac(DT)<0.5 then Dt:=Dt-1;

DecodeDate(DT,Year,Month,Day);

if Month<10 then SMonth:='0'+IntToStr(Month) else SMonth:=IntToStr(Month);
if Day<10 then SDay:='0'+IntToStr(Day) else SDay:=IntToStr(Day);
SYear:=IntToStr(Year);

Result:=SDay+'-'+SMonth+'-'+SYear;
end;

// Transforme un TDateTime
// en string de la forme HH:MM:SS
function TimeToStr(DateTime:TDatetime):string;
var
Hour,Min,Sec,MSec:Word;
SHour,SMin,SSec:String;
begin
DecodeTime(DateTime,Hour,Min,Sec,MSec);

if Hour<10 then SHour:='0'+IntToStr(Hour) else SHour:=IntToStr(Hour);
if Min<10 then SMin:='0'+IntToStr(Min) else SMin:=IntToStr(Min);
if Sec<10 then SSec:='0'+IntToStr(Sec) else SSec:=IntToStr(Sec);

Result:=SHour+':'+Smin+':'+SSec;
end;

// Transforme un TDateTime
// en string de la forme HH:MM:SS.SSS
function TimeToStrExtend(DateTime:TDatetime):string;
var
Hour,Min,Sec,MSec:Word;
SHour,SMin,SSec,SMSec:String;
begin
DecodeTime(DateTime,Hour,Min,Sec,MSec);

if Hour<10 then SHour:='0'+IntToStr(Hour) else SHour:=IntToStr(Hour);
if Min<10 then SMin:='0'+IntToStr(Min) else SMin:=IntToStr(Min);
if Sec<10 then SSec:='0'+IntToStr(Sec) else SSec:=IntToStr(Sec);
if MSec<10 then SMSec:='00'+IntToStr(MSec) //nolang
else if MSec<100 then SMSec:='0'+IntToStr(MSec) else SMSec:=IntToStr(MSec);

Result:=SHour+':'+Smin+':'+SSec+'.'+SMSec;
end;

// Transforme un TDateTime
// en string de la forme JJ:MM:YYYY
function DateToStr(DateTime:TDateTime):string;
var
Year,Month,Day,Hour,Min,Sec,MSec:Word;
SYear,SMonth,SDay,SHour,SMin,SSec:String;
begin
DecodeDate(DateTime,Year,Month,Day);

if Month<10 then SMonth:='0'+IntToStr(Month) else SMonth:=IntToStr(Month);
if Day<10 then SDay:='0'+IntToStr(Day) else SDay:=IntToStr(Day);
SYear:=IntToStr(Year);

Result:=SDay+'/'+SMonth+'/'+SYear;
end;

// Transforme un TDateTime
// en string de la forme JJ/MM/YY
function DateToStrSlash(DateTime:TDateTime):string;
var
Year,Month,Day,Hour,Min,Sec,MSec:Word;
SYear,SMonth,SDay,SHour,SMin,SSec:String;
begin
DecodeDate(DateTime,Year,Month,Day);

if Month<10 then SMonth:='0'+IntToStr(Month) else SMonth:=IntToStr(Month);
if Day<10 then SDay:='0'+IntToStr(Day) else SDay:=IntToStr(Day);
SYear:=IntToStr(Round(Frac(Year/100)*100));

Result:=SDay+'/'+SMonth+'/'+SYear;
end;

// Donne l'heure BIOS sous forme d'une chaine
// de la forme HH:MM:SS
function GetStrTimeBios:string;
var
Year,Month,Day,Hour,Min,Sec,MSec:Word;
SHour,SMin,SSec:String;
begin
GetHour(Year,Month,Day,Hour,Min,Sec,MSec);

if Hour<10 then SHour:='0'+IntToStr(Hour) else SHour:=IntToStr(Hour);
if Min<10 then SMin:='0'+IntToStr(Min) else SMin:=IntToStr(Min);
if Sec<10 then SSec:='0'+IntToStr(Sec) else SSec:=IntToStr(Sec);

Result:=SHour+':'+Smin+':'+SSec;

end;

// Donne l'heure BIOS sous forme d'une chaine
// de la forme HH:MM:SS.MM
// Marche pas
function GetStrTimeBiosHP:string;
var
Year,Month,Day,Hour,Min,Sec,MSec:Word;
SHour,SMin,SSec,SMSec:String;
begin
GetHour(Year,Month,Day,Hour,Min,Sec,MSec);

if Hour<10 then SHour:='0'+IntToStr(Hour) else SHour:=IntToStr(Hour);
if Min<10 then SMin:='0'+IntToStr(Min) else SMin:=IntToStr(Min);
if Sec<10 then SSec:='0'+IntToStr(Sec) else SSec:=IntToStr(Sec);
if MSec<10 then SMSec:='0'+IntToStr(Sec) else SMSec:=IntToStr(Sec);

Result:=SHour+':'+Smin+':'+SSec+'.'+SMSec;

end;


// Donne la date et l'heure BIOS sous forme d'une chaine
// de la forme JJ/MM/AAAA HH:MM:SS
function GetStrDateTimeBios:string;
var
Year,Month,Day,Hour,Min,Sec,MSec:Word;
SYear,SMonth,SDay,SHour,SMin,SSec:String;
begin
GetHour(Year,Month,Day,Hour,Min,Sec,MSec);

if Hour<10 then SHour:='0'+IntToStr(Hour) else SHour:=IntToStr(Hour);
if Min<10 then SMin:='0'+IntToStr(Min) else SMin:=IntToStr(Min);
if Sec<10 then SSec:='0'+IntToStr(Sec) else SSec:=IntToStr(Sec);
if Month<10 then SMonth:='0'+IntToStr(Month) else SMonth:=IntToStr(Month);
if Day<10 then SDay:='0'+IntToStr(Day) else SDay:=IntToStr(Day);
SYear:=IntToStr(Year);

Result:=SDay+'/'+SMonth+'/'+SYear+' '+SHour+':'+Smin+':'+SSec;
end;

function find_starname(s:string; var is_a_star:boolean):Tstarname;
var
i:integer;
p:TStarname;
begin
     is_a_star:=false;
     for i:=1 to starname_count do
     begin
          p:=TStarName_matrix[i];
          if uppercase(p.nom)=uppercase(s) then
          begin
               result:=p;
               is_a_star:=true;
               exit;
          end;
     end;
end;

// ' HH:MM:SS.SSS ' = Heure ( Format .pic )
//      HH      = Heure
//      MM      = Minutes
//      SS.SSS  = Secondes}
// Resultat en format TDateTime
function StrToHeure(Line:String):TDateTime;
var
PosEsp:Integer;
Hour,Min,Sec,MSec:Word;
begin
Line:=Trim(Line);
PosEsp:=Pos(':',Line);
if PosEsp=0 then raise Errorcoordonnees.Create(lang('Séparateur des heures absent'));
Hour:=StrToInt(Copy(Line,1,PosEsp-1));
if Hour>23 then raise Errorcoordonnees.Create(lang('Heure > 23h'));
Delete(Line,1,PosEsp);

PosEsp:=Pos(':',Line);
if PosEsp=0 then raise Errorcoordonnees.Create(lang('Séparateur des minutes absent'));
Min:=StrToInt(Copy(Line,1,PosEsp-1));
if Min>59 then raise ErrorCoordonnees.Create(lang('Minutes > 59mn'));
Delete(Line,1,PosEsp);

PosEsp:=Pos('.',Line);
if PosEsp=0 then raise ErrorCoordonnees.Create(lang('Séparateur des secondes absent'));
Sec:=StrToInt(Copy(Line,1,PosEsp-1));
if Sec>59 then raise ErrorCoordonnees.Create(lang('Secondes > 59s'));
Delete(Line,1,PosEsp);

MSec:=StrToInt(Copy(Line,1,PosEsp-1));
if MSec>999 then raise ErrorCoordonnees.Create(lang('Millisecondes > 999'));

Result:=EncodeTime(Hour,Min,Sec,MSec);
end;

// ' JJ/MM/AA ' = Heure ( Format .pic )
//      HH      = Heure
//      MM      = Minutes
//      SS.SSS  = Secondes}
// Resultat en format TDateTime
function MyStrToDate(Line:String):TDateTime;
var
PosEsp:Integer;
Jour,Mois,Annee:Word;
begin
Line:=Trim(Line);
PosEsp:=Pos('/',Line);
if PosEsp=0 then raise Errorcoordonnees.Create(lang('Séparateur des jours absent'));
Jour:=StrToInt(Copy(Line,1,PosEsp-1));
if Jour>31 then raise Errorcoordonnees.Create(lang('Jour > 31'));
Delete(Line,1,PosEsp);

PosEsp:=Pos('/',Line);
if PosEsp=0 then raise Errorcoordonnees.Create(lang('Séparateur des mois absent'));
Mois:=StrToInt(Copy(Line,1,PosEsp-1));
if Mois>12 then raise ErrorCoordonnees.Create(lang('Mois > 12'));
Delete(Line,1,PosEsp);

Annee:=StrToInt(Copy(Line,1,PosEsp-1));
if Annee>50 then Annee:=Annee+1900 else Annee:=Annee+2000;

Result:=EncodeDate(Annee,Mois,Jour);
end;


// HHhMMmSSs = Ascension droite
//      HH = Heure
//      MM = Minutes
//      SS = Secondes}
// Resultat en heures
function StrToAlpha(Line:string):Double;
var
PosEsp:Integer;
Hour,Min,Sec:Word;
begin
   if Line='' then
      begin
      Result:=0;
      Exit;
      end;
   PosEsp:=Pos(Config.SeparateurHeuresMinutesAlpha,Line);
   if PosEsp=0 then PosEsp:=Pos(':',Line);
   if PosEsp=0 then PosEsp:=Pos('h',Line);
   if PosEsp=0 then raise Errorcoordonnees.Create(lang('Séparateur des heures absent'));
   Hour:=StrToInt(Copy(Line,1,PosEsp-1));
   Delete(Line,1,PosEsp);

   PosEsp:=Pos(Config.SeparateurMinutesSecondesAlpha,Line);
   if PosEsp=0 then PosEsp:=Pos(':',Line); //nolang
   if PosEsp=0 then PosEsp:=Pos('m',Line); //nolang
   if PosEsp=0 then raise Errorcoordonnees.Create(lang('Séparateur des minutes absent'));
   Min:=StrToInt(Copy(Line,1,PosEsp-1));
   if Min>59 then raise ErrorCoordonnees.Create(lang('Minutes Alpha > 59mn'));
   Delete(Line,1,PosEsp);

   if Trim(Config.UnitesSecondesAlpha)<>'' then Line:=Copy(Line,1,Length(Line)-1);
   Sec:=StrToInt(Trim(Line));
   if Sec>59 then raise ErrorCoordonnees.Create(lang('Secondes Alpha > 60s'));

   if (Hour>23) and (min>59) and (sec > 59) then raise Errorcoordonnees.Create(lang('Heure Alpha > 23h'));

   Result:=Hour+(Min/60)+(Sec/3600);
end;

// sDDdMMmSSs = declinaison
//       s = Signe + ou -
//      DD = Degres
//      MM = Minutes
//      SS = Secondes}
// Résultat en degrés
// Entre -90 et +90 degrés
function StrToDelta(Line:String):Double;
var
PosEsp:Integer;
Deg,Min,Sec:Integer;
Sign:Char;
begin
   if Line='' then
      begin
      Result:=0;
      Exit;
      end;

   while Pos('_',Line)<>0 do Delete(Line,Pos('_',Line),1);

   if (Line[1]<>'+') and (Line[1]<>'-') then Line:='+'+Line;
   Sign:=Line[1];

   PosEsp:=Pos(Config.SeparateurDegresMinutesDelta,Line);
   if PosEsp=0 then PosEsp:=Pos('d',Line);
   if PosEsp=0 then PosEsp:=Pos('°',Line);
   if PosEsp=0 then raise Errorcoordonnees.Create(lang('Séparateur des degrés absent'));
   Deg:=StrToInt(Copy(Line,1,PosEsp-1));
   Delete(Line,1,POsEsp);

   PosEsp:=Pos(Config.SeparateurMinutesSecondesDelta,Line);
   if PosEsp=0 then PosEsp:=Pos('m',Line); //nolang
   if PosEsp=0 then PosEsp:=Pos('''',Line); //nolang
   if PosEsp=0 then raise ErrorCoordonnees.Create(lang('Séparateur des minutes absent'));
   Min:=StrToInt(Copy(Line,1,PosEsp-1));
   if Min>59 then raise ErrorCoordonnees.Create(lang('Minutes Delta > 59mn'));
   Delete(Line,1,POsEsp);

   PosEsp:=Pos(Config.UnitesSecondesDelta,Line);
   if PosEsp=0 then PosEsp:=Pos('s',Line);
   if PosEsp=0 then PosEsp:=Pos('"',Line);
   if PosEsp=0 then raise ErrorCoordonnees.Create(lang('Séparateur des secondes absent'));
   Sec:=StrToInt(Copy(Line,1,PosEsp-1));
   if Sec>59 then raise ErrorCoordonnees.Create(lang('Secondes Delta > 59s'));
   Delete(Line,1,POsEsp);

   if ((Deg>89) and (min>59) and (sec>59)) or ((deg<-89) and (min>59) and (sec>59))
   then raise ErrorCoordonnees.Create(lang('Degrés Delta > 89°59''59"'));


   if Sign='-' then Result:=Deg-(Min/60)-(Sec/3600)
   else Result:=Deg+(Min/60)+(Sec/3600);
end;

// sDDdMMmSSs = declinaison
//       s = Signe + ou -
//      DD = Degres
//      MM = Minutes
//      SS = Secondes}
// Résultat en degrés
// Entre 0 et 360 degrés
function StrToDegrees(Line:String):Double;
var
PosEsp:Integer;
Deg,Min,Sec:Integer;
Sign:Char;
begin
while Pos('_',Line)<>0 do Delete(Line,Pos('_',Line),1);

if (Line[1]<>'+') and (Line[1]<>'-') then Line:='+'+Line;
Sign:=Line[1];
if Sign='-' then raise ErrorCoordonnees.Create(lang('Degrés < 0°'));

PosEsp:=Pos('d',Line);
if PosEsp=0 then PosEsp:=Pos('°',Line);
if PosEsp=0 then raise Errorcoordonnees.Create(lang('Séparateur des degrés absent'));
Deg:=StrToInt(Copy(Line,1,PosEsp-1));
if Deg>360 then raise ErrorCoordonnees.Create(lang('Degrés > 360°'));
Delete(Line,1,POsEsp);

PosEsp:=Pos('m',Line);
if PosEsp=0 then PosEsp:=Pos('''',Line); //nolang
if PosEsp=0 then raise ErrorCoordonnees.Create(lang('Séparateur des minutes absent'));
Min:=StrToInt(Copy(Line,1,PosEsp-1));
if Min>59 then raise ErrorCoordonnees.Create(lang('Minutes > 59mn'));
Delete(Line,1,POsEsp);

PosEsp:=Pos('s',Line);
if PosEsp=0 then PosEsp:=Pos('"',Line);
if PosEsp=0 then raise ErrorCoordonnees.Create(lang('Séparateur des secondes absent'));
Sec:=StrToInt(Copy(Line,1,PosEsp-1));
if Sec>59 then raise ErrorCoordonnees.Create(lang('Secondes > 59s'));
Delete(Line,1,POsEsp);

if Sign='-' then Result:=Deg-Min/60-Sec/3600
else Result:=Deg+Min/60+Sec/3600;

end;


// Renvoie le jour julien


function  Rmod(x,y:Double):Double;
{pareil que mod, mais sur des doubles}
begin
    Rmod := x - Int(x/y) * y ;
end;


function lat2string(lat:double):string;
var
ltd,lts,lat_dbl:double;
ltm:integer;
d,m,s,o:string;
begin
        if lat <0 then o:='S' else o:='N';
        lat_dbl:=lat;
        lat_dbl:=abs(lat_dbl);
        ltd:=trunc(lat_dbl);
        ltm:=trunc(60*lat_dbl);
        lts:=3600*lat_dbl-60*ltm;
        ltm:=ltm mod 60;
        d:=floattostr(ltd);
        if length(d)=1 then d:='0'+d;
        m:=floattostr(ltm);
        if length(m)=1 then m:='0'+m;
        s:=floattostrf(lts,fffixed,15,2);
        if length(s)=4 then s:='0'+s;
        result:=d+'d'+m+''''+s+'"'+o //nolang
end;


function sgn(x:Double):Double ;
begin
if x<0 then
   sgn:= -1
else
   sgn:=  1 ;
end ;


function long2string (lng:double):string;
var
lgd,lgs,lng_dbl:double;
lgm:integer;
d,m,s,o:string;
begin
        if lng<0 then o:='E' else o:='W';
        lng_dbl:=lng;
        lng_dbl:=abs(lng_dbl);
        lgd:=trunc(lng_dbl);
        lgm:=trunc(60*lng_dbl);
        lgs:=3600*lng_dbl-60*lgm;
        lgm:=lgm mod 60;
        d:=floattostr(lgd);
        if length(d)=1 then d:='00'+d; //nolang
        if length(d)=2 then d:='0'+d;
        m:=floattostr(lgm);
        if length(m)=1 then m:='0'+m;
        s:=floattostrf(lgs,fffixed,15,2);
        if length(s)=4 then s:='0'+s;
        result:=d+'d'+m+''''+s+'"'+o //nolang
end;

// extraire le nom du fichier sans l'extension
function GetNomFichier(Nom:string):string;
var
   PosPoint:Integer;
begin
Nom:=ExtractFileName(Nom);
PosPoint:=Pos('.',Nom);
if PosPoint<>0 then Nom:=Copy(Nom,1,PosPoint-1);
Result:=Nom;
end;

// extraire le nom générique
function GetNomGenerique(Nom:string):string;
var
PosPoint:Integer;
FinNum:Boolean;
begin
Nom:=ExtractFileName(Nom);
PosPoint:=Pos('.',Nom);
if PosPoint<>0 then Nom:=Copy(Nom,1,PosPoint-1);
FinNum:=False;
if (Length(Nom)>0) and (Nom[Length(Nom)] in ['0'..'9']) then FinNum:=True;
if FinNum then
   begin
   while (Length(Nom)>0) and (Nom[Length(Nom)] in ['0'..'9'])
      do Nom:=Copy(Nom,1,Length(Nom)-1);
   end;
Result:=Nom;
end;

// extraire le numero
function GetNumeroSerie(Nom:string):integer;
var
PosPoint:Integer;
FinNum:Boolean;
Num:Integer;
NomNum:string;
begin
Nom:=ExtractFileName(Nom);
PosPoint:=Pos('.',Nom);
if PosPoint<>0 then Nom:=Copy(Nom,1,PosPoint-1);
FinNum:=False;
if (Length(Nom)>0) and (Nom[Length(Nom)] in ['0'..'9']) then FinNum:=True
else Num:=-1;
if FinNum then
   begin
   NomNum:='';
   while (Length(Nom)>0) and (Nom[Length(Nom)] in ['0'..'9']) do
      begin
      NomNum:=Nom[Length(Nom)]+NomNum;
      Delete(Nom,Length(Nom),1);
      end;
   Num:=StrToInt(NomNum);
   end;
Result:=Num;
end;

function make_my_day(day,hour,min:integer; sec:double):double;
begin
        if (day < 1) or
        (day > 31) or
        (hour < 0) or
        (hour > 23) or
        (min < 0) or
        (min > 59) or
        (sec < 0) or
        (sec >= 60) then
                result:=-1
        else
                result:=day+(hour+(min + sec / 60) / 60) / 24;
end;

// A verifier !
// Calcul du barycentre des temps de pose
// La date/heure doit etre celle du debut de la pose
// Le temps de pose doit etre en millisecondes
// Typepose = 0 pour une bête somme des temps de pose
// Typepose = 1 pour une moyenne des temps de pose proportionnelle aux flux ( photometrie )
procedure CalculeBarycentreTempsDePose(ListeTempsDePose:PLigInteger;
                                       ListeDate:PLigDate;
                                       Nb:Integer;
                                       TypePose:Byte;
                                       var TempsPoseFinal:Integer;
                                       var DateTimeFinal:TDateTime);
var
SommeDate1,SommeDate2,SommePose,PoseMoyenne:Double;
i:Integer;
begin
SommeDate1:=0;
SommeDate2:=0;
SommePose:=0;
for i:=1 to Nb do
   begin
//   SommeDate1:=SommeDate1+(ListeDate^[i]+ListeTempsDePose^[i]/1000/2/24/3600)*ListeTempsDePose^[i];
//   SommeDate2:=SommeDate2+(ListeDate^[i]+ListeTempsDePose^[i]/1000/2/24/3600);
   SommeDate1:=SommeDate1+ListeDate^[i]*ListeTempsDePose^[i];
   SommeDate2:=SommeDate2+ListeDate^[i];
   SommePose:=SommePose+ListeTempsDePose^[i];
   end;
if TypePose=0 then
   begin
   if SommePose<>0 then
//      DateTimeFinal:=SommeDate1/SommePose-SommePose/1000/2/24/3600
      DateTimeFinal:=SommeDate1/SommePose
   else
      DateTimeFinal:=SommeDate2/Nb;
   TempsPoseFinal:=Round(SommePose);
   end
else
   begin
   if SommePose<>0 then
//      DateTimeFinal:=SommeDate1/SommePose-TempsPoseFinal/1000/2/24/3600
      DateTimeFinal:=SommeDate1/SommePose
   else
      DateTimeFinal:=SommeDate2/Nb;
   TempsPoseFinal:=Round(SommePose/Nb);
   end
end;


function get_numero(s:string):string;
var
i:integer;
toto:string;
begin
     toto:='';
     for i:=2 to length(s) do
     begin
          if (ord(s[i]) in [48..57]) or (ord(s[i])=46) then toto:=toto+s[i];
     end;
     if length(toto) = 0 then result:='' else result:=toto;
end;


procedure ReservePortSerie(ComCh:String);
begin
if ComCh='COM1' then config.UsePort1:=True; //nolang
if ComCh='COM2' then config.UsePort2:=True; //nolang
if ComCh='COM3' then config.UsePort3:=True; //nolang
if ComCh='COM4' then config.UsePort4:=True; //nolang
if ComCh='COM5' then config.UsePort5:=True; //nolang
if ComCh='COM6' then config.UsePort6:=True; //nolang
if ComCh='COM7' then config.UsePort7:=True; //nolang
if ComCh='COM8' then config.UsePort8:=True; //nolang
end;


procedure LiberePortSerie(ComCh:String);
begin
if ComCh='COM1' then config.UsePort1:=False; //nolang
if ComCh='COM2' then config.UsePort2:=False; //nolang
if ComCh='COM3' then config.UsePort3:=False; //nolang
if ComCh='COM4' then config.UsePort4:=False; //nolang
if ComCh='COM5' then config.UsePort5:=False; //nolang
if ComCh='COM6' then config.UsePort6:=False; //nolang
if ComCh='COM7' then config.UsePort7:=False; //nolang
if ComCh='COM8' then config.UsePort8:=False; //nolang
end;


function PortSerieIsReserve(ComCh:String):Boolean;
begin
Result:=False;
if ComCh='COM1' then if config.UsePort1 then Result:=True; //nolang
if ComCh='COM2' then if config.UsePort2 then Result:=True; //nolang
if ComCh='COM3' then if config.UsePort3 then Result:=True; //nolang
if ComCh='COM4' then if config.UsePort4 then Result:=True; //nolang
end;


procedure do_sleep(sleeptime:double);
var
time_start:Tdatetime;
begin
        time_start:=time;
//        while Time<(Time_start+sleeptime)/60/60/24 do;
        while Time<Time_start+sleeptime/60/60/24 do Application.ProcessMessages;
end;


procedure SearchFile;
const Name = 'Dummy.fnd'; //nolang
var SR     : TSearchRec;
    OK     : integer;
    F      : TextFile;
    FName  : PChar;
    Handle : THandle;
begin
  OK:=FindFirst(extractfilepath(application.exename)+Name,$3F,SR);
  if OK<>0 then begin
    AssignFile(F,extractfilepath(application.exename)+Name);
    {$I-}
    rewrite(F);
    {$I+}
    OK:=IOResult;
    if OK=0 then
      CloseFile(F);
  end;
  if OK=0 then begin
    FName:=PChar(extractfilepath(application.exename)+Name);
    Handle:=0;
    ShellExecute(Handle,'Open',FName,nil,'',SW_ShowNormal); //nolang
  end;
end;


function StrToDateFITS(Line:string):TDateTime;
var
Year,Month,Day,Hour,Min,Sec,MSec:Word;
SYear,SMonth,SDay,SHour,SMin,SSec:String;
PosEsp:Integer;
begin
try
line:=trim(line);
PosEsp:=Pos('T',Line);
if PosEsp<>0 then
   begin
   //DATE-OBS '2000-12-31T00:12:31.12.000'
   PosEsp:=Pos('-',Line);
   if PosEsp=0 then raise ErrorDate.Create(lang('Date incorrecte'));
   Year:=StrToInt(Copy(Line,1,PosEsp-1));
   Delete(Line,1,PosEsp);

   PosEsp:=Pos('-',Line);
   if PosEsp=0 then raise ErrorDate.Create(lang('Date incorrecte'));
   Month:=StrToInt(Copy(Line,1,PosEsp-1));
   Delete(Line,1,PosEsp);

   PosEsp:=Pos('T',Line);
   if PosEsp=0 then raise ErrorDate.Create(lang('Date incorrecte'));
   Day:=StrToInt(Copy(Line,1,PosEsp-1));
   Delete(Line,1,PosEsp);

   PosEsp:=Pos(':',Line);
   if PosEsp=0 then raise ErrorDate.Create(lang('Date incorrecte'));
   Hour:=StrToInt(Copy(Line,1,PosEsp-1));
   Delete(Line,1,PosEsp);

   PosEsp:=Pos(':',Line);
   if PosEsp=0 then raise ErrorDate.Create(lang('Date incorrecte'));
   Min:=StrToInt(Copy(Line,1,PosEsp-1));
   Delete(Line,1,PosEsp);

   PosEsp:=Pos('.',Line);
   if PosEsp<>0 then
      begin
      Sec:=StrToInt(Copy(Line,1,PosEsp-1));
      Delete(Line,1,PosEsp);
      end
   else begin
      Sec:=StrToInt(Line);
      Line:='0';
   end;
   PosEsp:=Pos('E',Line); // Pour eviter un bug Prism
   if PosEsp<>0 then MSec:=0 else MSec:=StrToInt(Line);

   Result:=EncodeDate(Year,Month,Day)+EncodeTime(Hour,Min,Sec,MSec);
   end
else
   begin
   // ancien format valide : '27/05/54' pour DSS
   PosEsp:=Pos('/',Line);
    if PosEsp=0 then raise ErrorDate.Create(lang('Date incorrecte'));
   Day:=StrToInt(Copy(Line,1,PosEsp-1));
   Delete(Line,1,PosEsp);

   PosEsp:=Pos('/',Line);
   if PosEsp=0 then raise ErrorDate.Create(lang('Date incorrecte'));
   Month:=StrToInt(Copy(Line,1,PosEsp-1));
   Delete(Line,1,PosEsp);

   Year:=1900+StrToInt(Copy(Line,1,PosEsp-1));

   Result:=EncodeDate(Year,Month,Day);
   end;
except
result:=0;
end;
end;


function hour_angle2string(x:double):string;
var
strhour,strmin,strsec:string;
sdh,sdm,sds:integer;
sdmd,sdms:double;
begin

      sdh:=trunc(x);
      sdmd:=(abs(x)-abs(sdh))*60;
      sdm:=trunc(sdmd);
      sdms:=(sdmd-trunc(sdm))*60;
      sds:=trunc(sdms);
      strhour:=inttostr(sdh);
      if (Length(Strhour)=1) and (sdh>0) then Strhour:='0'+Strhour
      else if (length(strhour)=2) and (sdh<0) then strhour:='-0'+inttostr(abs(sdh)); //nolang
      Strmin:=inttostr(sdm);
      if Length(Strmin)=1 then Strmin:='0'+Strmin;
      Strsec:=inttostr(sds);
      if Length(Strsec)=1 then Strsec:='0'+Strsec;
      result:=Strhour+':'+Strmin+':'+Strsec;

end;


function correct_nom(s:string):string;
var
i:integer;
begin
     for i:=1 to length(s) do
     begin
          if (s[i]=' ') or (s[i]='/') or (s[i]='-') then s[i]:='_';
     end;
     result:=s;
end;


function Filtername2index(s:string):integer;
var
i:integer;
begin
     if s='None' then //nolang
     begin
          result:=0;
          exit;
     end;
     for i:=1 to 5 do
     begin
          if config.namefilter[i]=s then
          begin
               result:=i;
               exit;
          end;
     end;
     result:=0;
end;


procedure Kill_List(liste:Tlist; complete:boolean);
// shoote le contenu des TList, et release la memoire
begin

    if liste = nil then exit;
    try
    while liste.count > 0 do
    begin
           dispose(liste.items[0]);
           Liste.delete(0);
    end;
    finally
    if complete then
    begin
         Liste.Free;
         liste:=nil;
    end;
    end;
end;


procedure PortWrite(Contenu:Byte;Adresse:Word);
asm
    mov AL,Contenu
    mov DX,Adresse
    out DX,AL
end;


function PortRead(Adresse:Word):Byte;
asm
    mov DX,Adresse
    in AL,DX
    mov @Result,Al
end;

procedure GetmemImg(var ImgInt:PTabImgInt;
                    var ImgDouble:PTabImgDouble;
                    Sx,Sy:Integer;
                    TypeData,NbPlans:Byte);
var
j,k:Integer;
begin
case TypeData of
   2,7:begin
       Getmem(ImgInt,4*NbPlans);
       for k:=1 to NbPlans do
          begin
          Getmem(ImgInt^[k],Sy*4);
          for j:=1 to Sy do
             begin
             Getmem(ImgInt^[k]^[j],Sx*2);
             FillChar(ImgInt^[k]^[j]^,Sx*2,0);
             end;
          end;
       end;
   5,6,8:begin
       Getmem(ImgDouble,4*NbPlans);
       for k:=1 to NbPlans do
          begin
          Getmem(ImgDouble^[k],Sy*4);
          for j:=1 to Sy do
             begin
             Getmem(ImgDouble^[k]^[j],Sx*8);
             FillChar(ImgDouble^[k]^[j]^,Sx*8,0);
             end;
          end;
       end;
   end;
end;

procedure FreememImg(var ImgInt:PTabImgInt;
                     var ImgDouble:PTabImgDouble;
                     Sx,Sy:Integer;
                     TypeData,NbPlans:Byte);
var
j,k:Integer;
begin
case TypeData of
   2,7:begin
       for k:=1 to NbPlans do
          begin
          for j:=1 to Sy do Freemem(ImgInt^[k]^[j],Sx*2);
          Freemem(ImgInt^[k],Sy*4);
          end;
       Freemem(ImgInt,4*NbPlans);
       ImgInt:=nil;
       end;
   5,6,8:begin
       for k:=1 to NbPlans do
          begin
          for j:=1 to Sy do Freemem(ImgDouble^[k]^[j],Sx*8);
          Freemem(ImgDouble^[k],Sy*4);
          end;
       Freemem(ImgDouble,4*NbPlans);
       ImgDouble:=nil;       
       end;
   end;
end;

procedure MoveImg(var ImgIntIn:PTabImgInt;
                  var ImgDoubleIn:PTabImgDouble;
                  var ImgIntOut:PTabImgInt;
                  var ImgDoubleOut:PTabImgDouble;
                  Sx,Sy:Integer;
                  TypeData,NbPlans:Byte);
var
   i,j,k:Integer;                  
begin
case TypeData of
   2,7:begin
       for k:=1 to NbPlans do
          for j:=1 to Sy do
             Move(ImgIntIn^[k]^[j]^,ImgIntOut^[k]^[j]^,Sx*2);
       end;
   5,6,8:begin
         for k:=1 to NbPlans do
            for j:=1 to Sy do
               Move(ImgDoubleIn^[k]^[j]^,ImgDoubleOut^[k]^[j]^,Sx*8);
         end;
   end;
end;

function Check_Network: boolean;
var
   WSAData: TWSAData;
   HostName : String;
   HostEnt: PHostEnt;
begin
   WSAStartup($101,WSAData);
   SetLength(HostName, 255);
   gethostname(PChar(HostName), 255);
   SetLength(HostName, StrLen(PChar(HostName)));
   HostEnt := gethostbyname(PChar(HostName));
   if hostent=nil then result:=false
                  else result:=true;
   WSACleanup;
end;


procedure check_system;
begin
     if check_network then
     begin
          config.tcpip:=true;
          writespy(lang('TCP/IP installé sur cette machine'));
     end
      else
     begin
          config.tcpip:=false;
          writespy(lang('TCP/IP non installé sur cette machine'));
     end;
end;



{parallel ports

/* Normally, a PC can have up to 3 parallel printer ports - LPT1, LPT2 & LPT3.
Their (16-bit) base addresses in the processor's I/O space are loaded into
memory when the machine is booted, starting at address 408 Hex.

A well-written program requiring direct access to any of these ports should
endeavour to find out which are present and where at run-time (rather than use
constant declarations)

Due to 80x86 processors being " little-endian", the addresses are stored as
follows:

408 409  40a 40b  40c 40d
LPT1     LPT2     LPT3
low/high low/high low/high
byte     byte     byte

For example, the following values -

408 409 40a 40b 40c 40d
78  03  78  02  00  00

mean that LPT1 is at 378 Hex, LPT2 is at 278 Hex, and LPT3 is not present.

8 bits out:
base address portid lpt1 = 0x378 (decimal 888), lpt2 = 0x278 (decimal 632),
monochrome video card = 0x3BC (decimal 956);
25 - pin connector pins 2 (least significant) through 9 (most significant),
logical low in produces logical low out;

5 bits in:
base address + 1, portid 0x379 (or try 0x279 or 0x3BD):

        8               16              32              64              128     bit
        H               H               H               H               H               in
        15              13              12              10              11              25 pin connector pin #
        L               H               H               H               L               result, eg, inverted for bit 128;

        module logic rectifies the inverted bit;

4 bits in or out:
base address + 2, portid 0x37A (or try 0x27A or 0x3BE):

        1       2       4       8               bit
        H       H       H       H        in or out
        1       14      16      17       25 pin connector pin #
        L       L       H       L        result, eg, inverted for all bits
                                                                                                except for bit 4;

        module logic rectifies the inverted bits;

remaining pin connections:
25 pin connector pins 18 through 25 are grounds; */

}

function GetCPUSpeed: Double;
const
 DelayTime = 300; // measure time in ms
var
 TimerHi, TimerLo: DWORD;
 PriorityClass, Priority: Integer;
begin
 PriorityClass := GetPriorityClass(GetCurrentProcess);
 Priority := GetThreadPriority(GetCurrentThread);

 SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS);
 SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);

 Sleep(10);
 asm
   dw 310Fh // rdtsc
   mov TimerLo, eax
   mov TimerHi, edx
 end;
 Sleep(DelayTime);
 asm
   dw 310Fh // rdtsc
   sub eax, TimerLo
   sbb edx, TimerHi
   mov TimerLo, eax
   mov TimerHi, edx
 end;

 SetThreadPriority(GetCurrentThread, Priority);
 SetPriorityClass(GetCurrentProcess, PriorityClass);

 Result := TimerLo / (1000.0 * DelayTime);
end;

procedure getmemorystatus(var MemoryLoad:double;
                              TotalPhys,
                              AvailPhys,
                              TotalPageFile,
                              AvailPageFile,
                              TotalVirtual,
                              AvailVirtual:integer);
{tous les resultats sont en octets}
var
  Status : TMemoryStatus;
begin
     Status.dwLength := sizeof( TMemoryStatus );
     GlobalMemoryStatus( Status );
     memoryLoad:=Status.dwMemoryLoad; // Total memory used in percentage (%).<br>
     totalphys:=Status.dwTotalPhys;   // Total physical memory in bytes.<br>
     availphys:=Status.dwAvailPhys;   // Physical memory left in bytes.<br>
     totalpagefile:=Status.dwTotalPageFile; // Total page file in bytes.<br>
     availpagefile:=Status.dwAvailPageFile; // Page file left in bytes.<br>
     totalvirtual:=Status.dwTotalVirtual;   // Total virtual memory in bytes.<br>
     availvirtual:=Status.dwAvailVirtual;  // Virtual memory left in bytes.<br>
end;


function Get_OS_version:string;
var Version : DWORD;
    Build : WORD;
    MajorVersion, MinorVersion : BYTE;
    tmp:string;
begin
  Version := GetVersion();
  { Get major and minor version numbers of Windows }
  MajorVersion := LOBYTE(LOWORD(Version));
  MinorVersion := HIBYTE(LOWORD(Version));

  { Get build numbers for Windows NT or Win32s }
  if (Version and $80000000) = 0 then begin { Windows NT }
    tmp:='Windows NT'; //nolang
    Build := HIWORD(Version);
  end
  else if (MajorVersion < 4) then begin { Win32s }
    tmp:='Win32s'; //nolang
    Build := HIWORD(Version) and $7FFF;
  end
  else begin
    tmp:='Windows 95/98'; { Windows 95 -- No build numbers provided } //nolang
    Build := 0;
  end;

  result:=tmp+' Version '+IntToStr(MajorVersion)+'.'+IntToStr(MinorVersion) //nolang
     +' Build '+IntToStr(Build); //nolang

end;


procedure find_ports(ser:tSerial_ports; par:TParallel_ports);
var
adr:longint;
val:word;
BEGIN
     // port //
     par[0]:=word(ptr($40*2+$0008)^)<>0;
     par[1]:=word(ptr($40a*2+$0010)^)<>0;
     par[2]:=word(ptr($40c*2+$0012)^)<>0;

     // port serie
end;

function ChangeExtToGenerique(Nom:string;TypeDonnees:Byte):string;
var
PosEsp:Integer;
begin
if ExtractFileExt(Nom)<>'' then
   begin
   PosEsp:=Pos('.',Nom);
   Nom:=Copy(Nom,1,PosEsp-1);
   end;
case TypeDonnees of
   2:case config.FormatSaveInt of
        0  :Nom:=Nom+'.fit'; //nolang
        1,5:Nom:=Nom+'.cpa'; //nolang
        2  :Nom:=Nom+'.pic'; //nolang
        3  :Nom:=Nom+'.bmp'; //nolang
        4  :Nom:=Nom+'.jpg'; //nolang
        end;
   5,6:case config.FormatSaveInt of
        0,2:Nom:=Nom+'.fit'; //nolang
        1,5:Nom:=Nom+'.cpa'; //nolang
        3  :Nom:=Nom+'.bmp'; //nolang
        4  :Nom:=Nom+'.jpg'; //nolang
        end;
//   5,6:case config.FormatSaveInt of
//        0,1,2,3,5:Nom:=Nom+'.bmp'; //nolang
//        4        :Nom:=Nom+'.jpg'; //nolang
//        end;
   7,8:case config.FormatSaveInt of
        0,2:Nom:=Nom+'.fit'; //nolang
        1,5:Nom:=Nom+'.cpa'; //nolang
        3  :Nom:=Nom+'.bmp'; //nolang
        4  :Nom:=Nom+'.jpg'; //nolang
        end;
   end;
Result:=Nom;
end;

function ChangeExt(Nom,NewExt:string):string;
var
PosEsp:Integer;
begin
if ExtractFileExt(Nom)<>'' then
   begin
   PosEsp:=Pos('.',Nom);
   Nom:=Copy(Nom,1,PosEsp-1);
   end;
Result:=Nom+NewExt;
end;

procedure load_profile;
var
i,posesp:integer;
line:string;
ftext:textfile;
ok:boolean;
max:double;
begin
      WriteSpy(lang('Create : Chargement du Profil'));
      // Charge le profil
      for i:=0 to 360 do
         begin
         pop_main.AzimuthPRF[i]:=i;
         pop_main.HauteurPRF[i]:=0;
         end;

      OK:=False;

      if FileExists(config.Profil) then
         begin
         AssignFile(FText,config.Profil);
         Reset(FText);
         max:=0;
         for i:=0 to 360 do
         begin
            Readln(FText,Line);
            if DecimalSeparator=',' then
               if Pos('.',Line)<>0 then Line[Pos('.',Line)]:=',';
            if DecimalSeparator='.' then
               if Pos(',',Line)<>0 then Line[Pos('.',Line)]:='.';

            PosEsp:=Pos(' ',Line);
            pop_main.AzimuthPRF[i]:=MyStrToFloat(Copy(Line,1,PosEsp-1));
            Delete(Line,1,PosEsp);

            pop_main.HauteurPRF[i]:=MyStrToFloat(Trim(Line));
            if pop_main.HauteurPRF[i]>max then max:=pop_main.HauteurPRF[i];
            if (i=360) and (max<>0) then OK:=True;
         end;
         CloseFile(FText);
         end;

      if not(OK) then
      begin
           WriteSpy(lang('Create : Erreur au chargement du fichier Profil => horizon plat !'));
           config.profile_ok:=true;
      end
      else
      begin
           WriteSpy(lang('Create : Fichier Profil chargé'));
           config.profile_ok:=true;
      end;
end;

procedure ClasseListe(Liste:TStringList);
var
Trouve:Boolean;
i:Integer;
begin
Trouve:=True;
while Trouve do
   begin
   Trouve:=False;
   for i:=0 to Liste.Count-2 do
      begin
      if GetNumeroSerie(Liste.Strings[i])>GetNumeroSerie(Liste.Strings[i+1]) then
         begin
         Trouve:=True;
         Liste.Exchange(i,i+1);
         end
      end;
   end

end;

function MyFloatToStr(Valeur:Double;Nb:Integer):string;
var
   Line,Line1,PartieEntiere,PartieVirgule,Separ:string;
   PosVirgule,PosE,NbZero,i,j:Integer;
   Val1,Val2,ValFrac:Double;
   Negatif:Boolean;
begin
//Result:=Format('%F'+IntToStr(Nb),[Valeur]);
Negatif:=False;
if Valeur<0 then
   begin
   Negatif:=True;
   Valeur:=-Valeur;
   end;
Line:=FloatToStrF(Valeur,fffixed,10,10);
// On repere le position de la virgule
PosVirgule:=Pos(DecimalSeparator,Line);
if PosVirgule=0 then Result:=Line
else
   begin
   Line1:=Line;
   // On  supprime la virgule
   Delete(Line,PosVirgule,1);
   // On compte le nombre de 0 de devant car ils vont disparaitre
   i:=1;
   while Line[i]='0' do Inc(i);
   // On mets la virgule a la fin
   Separ:=DecimalSeparator;
   Insert(Separ,Line,PosVirgule+Nb);
   // On convertit en double et on arrondis
   ValFrac:=Frac(MyStrToFloat(Line));
   if ValFrac<=0.5 then Val1:=Int(MyStrToFloat(Line)) else Val1:=Int(MyStrToFloat(Line))+1;
   Val2:=Int(MyStrToFloat(Line));
   // Si on change de colonne, on enleve un zero
   if (Length(IntToStr(Round(Val1)))<>Length(IntToStr(Round(Val2)))) then Dec(i);
   // Dans l'autre sens, il fait decaler la virgule ex : 9.999999 -> 10
   if (Length(IntToStr(Round(Val1)))<>Length(IntToStr(Round(Val2)))) and (Val1>Val2) then Inc(PosVirgule);
   // On revient en string
   Line:=FloatToStr(Val1);
   // On remet les 0 qui manquent
   for j:=1 to i-1 do Line:='0'+Line;
   // On remet la virgule au bon endroit si il faut
   if Length(Line)>=PosVirgule then
      Insert(Separ,Line,PosVirgule);
   // On suprime les 0 de la fin si il y une virgule
   if Line<>'' then
      if Pos(Separ,Line)<>0 then
         while (Line<>'') and (Line[Length(Line)]='0') do Delete(Line,Length(Line),1);
   if Line='' then Line:='0';
   if Line<>'' then if Line[Length(Line)]=DecimalSeparator then Delete(Line,Length(Line),1);
   if Negatif and (Line<>'0') then Line:='-'+Line;
   Result:=Line;
   end;
end;

function CountNb(Line1,Line2:string):Integer;
var
   Nb,PosEsp:Integer;
begin
Nb:=0;
PosEsp:=Pos(Line1,Line2);
while PosEsp>0 do
   begin
   Inc(Nb);
   Delete(Line2,PosEsp,Length(Line1));   
   PosEsp:=Pos(Line1,Line2);
   end;
Result:=Nb;
end;

function pad(s:string; len:byte):string;
var
i:integer;
tmp:string;
begin
     if len > length(s) then
     begin
          for i:=1 to len-length(s) do tmp:=tmp+' ';
     end;
     result:=s+tmp;
end;

Procedure FindHighIndex(nom,ext : string; var i : integer);
var  S: TSearchRec;
     l,n,p,w : integer;
     fn,buf: string;
begin
//  recherche de l'index max d'un nom de fichier
i:=0;
ext:=uppercase(ext);
fn:=uppercase(extractfilename(nom));
l:=length(fn);
Sysutils.FindFirst(extractfilepath(nom)+'*.*', faAnyFile, S);     //nolang
repeat
  if (uppercase(copy(S.Name,1,l))=fn)and(uppercase(extractfileext(s.name))=ext) then begin
    p:=pos('.',S.Name);
    buf:=copy(S.Name,l+1,p-1-l);
    val(buf,n,w);
    if w=0 then i:=maxintvalue([n,i]);
  end;
until Sysutils.findnext(S)<>0;
Sysutils.Findclose(S);
end;

procedure MajSystemTime(DateTime:TDateTime);
var
   SystemTime:TSystemTime;
   Year,Month,Day:Word;
   Hour,Min,Sec,MSec:Word;
begin
//if Config.TypeOS=1 then exit; // Root // Non, ca marche sous XP
DecodeDate(DateTime,Year,Month,Day);
DecodeTime(DateTime,Hour,Min,Sec,MSec);
with SystemTime do
   begin
   wYear  := Year;
   wMonth := Month;
   wDay   := Day;
   wHour  := Hour;
   wMinute:= Min;
   wSecond:= Sec;
   wMilliseconds:=MSec;
   end;
SetLocalTime(SystemTime);
end;

function ExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
var
  zFileName, zParams, zDir: array[0..79] of Char;
begin
  Result := ShellExecute(Application.MainForm.Handle, nil, StrPCopy(zFileName, FileName),
                         strpcopy(zParams, Params), StrPCopy(zDir, DefaultDir), ShowCmd);
end;

function GetOS:string;

var
  OS :TOSVersionInfo;

begin
  ZeroMemory(@OS,SizeOf(OS));
  OS.dwOSVersionInfoSize:=SizeOf(OS);
  GetVersionEx(OS);
  Result:='Unknown';    //nolang
  if OS.dwPlatformId=VER_PLATFORM_WIN32_NT then begin
    case OS.dwMajorVersion of
      3: Result:='Win32 NT3';   //nolang
      4: Result:='Win32 NT4';   //nolang
      5: Result:='Win32 2K';    //nolang
    end;
    if (OS.dwMajorVersion=5) and (OS.dwMinorVersion=1) then
      Result:='Win32 XP';       //nolang
  end else begin
    if (OS.dwMajorVersion=4) and (OS.dwMinorVersion=0) then begin
      Result:='Win32 95';        //nolang
      if (Trim(OS.szCSDVersion)='B') then //nolang
        Result:='Win32 95OSR2';     //nolang
    end else
      if (OS.dwMajorVersion=4) and (OS.dwMinorVersion=10) then begin
        Result:='Win32 98';       //nolang
        if (Trim(OS.szCSDVersion)='A') then  //nolang
          Result:='Win32 98SE';   //nolang
      end else
        if (OS.dwMajorVersion=4) and (OS.dwMinorVersion=90) then
          Result:='Win32 ME';      //nolang
  end;
end;


function StringToTString(Line:string):TStrings;
var
   Liste:TStrings;
   PosEsp:Integer;
begin
Liste:=TStringList.Create;
PosEsp:=Pos('|',Line);
while (PosEsp<>0) and (Length(Line)<>0) do
   begin
   Liste.Add(Copy(Line,1,PosEsp-1));
   Delete(Line,1,PosEsp);
   PosEsp:=Pos('|',Line);
   end;
Result:=Liste;
end;

function TStringToString(Liste:TStrings):string;
var
   i:Integer;
   Line:String;
begin
Line:='';
for i:=0 to Liste.Count-1 do Line:=Line+Liste.Strings[i]+'|';
Result:=Line;
end;

// Examples Of Observations
// The following examples show valid comet and minor-planet observations.
//                                     Column
//          1         2         3         4         5         6         7         8
// 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789
//
//     CJ93K010  C1995 01 12.44658 23 20 12.59 -73 00 31.9                      413
//     PJ93X010  C1995 01 13.71552 12 08 44.80 +01 55 10.6                      413
//     PJ94P01d  C1994 10 14.82517 09 57 25.32 +09 06 28.5          13.3 T      360
//     PJ95A010  C1995 01 27.42558 07 45 16.64 +21 40 44.4          20.6 N      691
// 0007P         C1995 01 07.49677 10 07 09.83 +31 58 36.9                      691
// 0047P         C1994 12 31.38076 07 40 47.47 +37 40 09.1                      693
// 0116P         C1995 01 03.21177 02 40 39.14 +18 09 23.5          20.8 T      691
//
//      J91R04W F 1994 04 03.00278 11 28 41.20 +04 14 24.8                      033
//      J93P00C cC1994 07 04.57639 17 28 54.97 -38 12 17.1          17.1 V      360
//      PLS2645   1994 03 04.63681 11 40 57.89 +06 07 08.6                      399
//      T1S3196   1994 05 04.56403 14 26 06.83 -15 41 20.8          16.6        474
//      T2S3187  A1973 09 19.21250 00 24 34.59 -01 08 26.0                      675
//      T3S2318  C1994 07 12.22157 19 47 43.23 -15 45 37.3                      801
// 02965         C1994 07 13.97693 17 35 15.33 -00 26 18.9          16.1 R      046
//
//      94ORX0 * C1994 06 08.98877 16 22 02.78 -17 49 13.7          18.5        104
function MpecFormat(DateTime:TDateTime;Alpha,Delta:Double):string;
var
   Year,Month,Day:Word;
   SMonth,SDay:string;
   Line:string;
   Deg,Hour,Min,Sec,MSec,i:Integer;
   SDeg,SHour,SMin,SSec,SMSec,SAlpha,SDelta:string;
begin
//1995 01 12.44658 23 20 12.59 -73 00 31.9
Line:='';
DecodeDate(DateTime,Year,Month,Day);
if Month<10 then SMonth:='0'+IntToStr(Month) else SMonth:=IntToStr(Month);
if Day<10 then SDay:='0'+IntToStr(Day) else SDay:=IntToStr(Day);
Line:=Line+IntToStr(Year)+' '+SMonth+' '+SDay;
Hour:=Round(Frac(DateTime)*100000);
SHour:=IntToStr(Hour);
for i:=1 to 5-Length(SHour) do SHour:='0'+SHour;
Line:=Line+'.'+SHour;

Hour:=Trunc(Alpha);
Min :=Trunc((Alpha-Hour)*60);
Sec :=Trunc((Alpha-Hour-Min/60)*3600);
MSec:=Round(((Alpha-Hour-Min/60)*3600-Sec)*100);
if MSec=100 then
   begin
   MSec:=0;
   Inc(Sec);
   if Sec=60 then
      begin
      Sec:=0;
      Inc(Min);
      if Min=60 then
         begin
         Min:=0;
         Inc(Hour);
         if Hour=24 then Hour:=0;
         end;
      end;
   end;
if Hour<10 then SHour:='0'+IntToStr(Hour) else SHour:=IntToStr(Hour);
if Min<10 then SMin:='0'+IntToStr(Min) else SMin:=IntToStr(Min);
if Sec<10 then SSec:='0'+IntToStr(Sec) else SSec:=IntToStr(Sec);
if MSec<10 then SMSec:='0'+IntToStr(MSec) else SMSec:=IntToStr(MSec);

SAlpha:=Shour+' '+Smin+' '+SSec+'.'+SMSec;

Line:=Line+' '+SAlpha;

Deg :=Trunc( Abs(Delta));
Min :=Trunc((Abs(Delta)-Deg)*60);
Sec :=Trunc((Abs(Delta)-Deg-Min/60)*3600);
MSec:=Round(((Abs(Delta)-Deg-Min/60)*3600-Sec)*10);
if MSec=10 then
   begin
   MSec:=0;
   Inc(Sec);
   if Sec=60 then
      begin
      Sec:=0;
      Inc(Min);
      if Min=60 then
         begin
         Min:=0;
         Inc(Deg);
         end;
      end;
   end;
if Deg<10 then SDeg:='0'+IntToStr(Deg) else SDeg:=IntToStr(Deg);
if Min<10 then SMin:='0'+IntToStr(Min) else SMin:=IntToStr(Min);
if Sec<10 then SSec:='0'+IntToStr(Sec) else SSec:=IntToStr(Sec);
SMSec:=IntToStr(MSec);

if Delta<0 then SDelta:='-'+SDeg+' '+Smin+' '+SSec+'.'+SMSec
else SDelta:='+'+SDeg+' '+Smin+' '+SSec+'.'+SMSec;

Line:=Line+' '+SDelta;

Result:=Line;
end;

procedure TrouveNomsGenereriques(ListeImages:TStringList;var ListeGenerique:TStringList);
var
   i,j:Integer;
   Nom:string;
   DejaDansLaListe:Boolean;
begin
ListeGenerique:=TStringList.Create;
for i:=0 to ListeImages.Count-1 do
   begin
   Nom:=GetNomGenerique(ListeImages.Strings[i]);

   DejaDansLaListe:=False;
   for j:=0 to ListeGenerique.Count-1 do
      if Nom=ListeGenerique.Strings[j] then DejaDansLaListe:=True;

   if not DejaDansLaListe then ListeGenerique.Add(Nom);

   end;

end;

function find_constellation_name(s:string; var is_a_const:boolean):TConstellation;
var
i:integer;
p:TConstellation;
begin
     is_a_const:=false;
     for i:=1 to 88 do
     begin
          p:=TConst_matrix[i];
          if (uppercase(p.abb)=uppercase(s)) or (uppercase(p.nom)=uppercase(s)) then
          begin
               result:=p;
               is_a_const:=true;
               exit;
          end;
     end;
end;

function not_numeric(s:string):boolean;
var i:integer;
begin
     result:=false;
     for i:=1 to length(s) do
     begin
          if (not(ord(s[i]) in [48..57])) and (s[i]<>decimalseparator) then
          begin
               result:=true;
               exit;
          end;
     end;
end;

function correct_nom2(obj:SkyChart.pobjrec):string;
var
i:integer;
s:string;
begin
     result:=obj.objectname;
     s:=trim(obj.objectname);
     for i:=1 to length(s) do
     begin
          if (s[i]=' ') or (s[i]='/') or (s[i]='-') or (s[i]='.') then s[i]:='_';
     end;
     if (obj.catalogname<>'NGC') and (obj.catalogname<>'IC') then result:=obj.catalogname+'_'+s; //nolang
end;

function objtype2string(i:integer):string;
begin
     result:='';
     case i of
         1: result:=lang('Galaxie');
         2: result:=lang('Amas ouvert');
         3: result:=lang('Amas globulaire');
         4: result:=lang('Nebuleuse planetaire');
         5: result:=lang('Nebuleuse');
         6: result:=lang('Nebuleuse + Amas');
         7: result:=lang('Star');
         8: result:=lang('double star');
         9: result:=lang('triple star');
         10: result:=lang('Asterism');
         11: result:=lang('Noeud');
         12: result:=lang('Amas de galaxies');
         13: result:=lang('Nebuleuse obscure');
         50: result:=lang('Etoile');
         51: result:=lang('Etoile variable');
         52: result:=lang('Etoile double');
        101: result:=lang('Mercure');
        102: result:=lang('Venus');
        103: result:=lang('Terre');
        104: result:=lang('Mars');
        105: result:=lang('Jupiter');
        106: result:=lang('Saturne');
        107: result:=lang('Uranus');
        108: result:=lang('Neptune');
        109: result:=lang('Pluton');
        110: result:=lang('Soleil');
        111: result:=lang('Lune');
        112: result:=lang('Asteroide');
        113: result:=lang('Comete');
     end;
     if result='' then result:=lang('Inconnu');
end;

Function Exec(cmd: string; hide: boolean): cardinal;
var
    bchExec: array[0..MAX_PATH] of char;
    pchEXEC: Pchar;
    si: TStartupInfo;
    pi: TProcessInformation;
begin
    pchExec := @bchExec;
    StrPCopy(pchExec,cmd);
    Result := 0;
    FillChar(si,sizeof(si),0);
    FillChar(pi,sizeof(pi),0);
    si.dwFlags:=STARTF_USESHOWWINDOW;
    if hide then si.wShowWindow:=SW_SHOWMINIMIZED
            else si.wShowWindow:=SW_SHOWNORMAL;
    si.cb := sizeof(si);
    try
       if CreateProcess(Nil,pchExec,Nil,Nil,false,CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, Nil,Nil,si,pi) = True then
          begin
            Result := 0;
            WaitForSingleObject(pi.hProcess,INFINITE);
            GetExitCodeProcess(pi.hProcess,Result);
          end
          else
            Result := GetLastError;
     except;
        Result := GetLastError;
     end;
end;

function good_checksum(buf:array of byte):boolean;
var i,cs,checksum,len:integer;
begin
     // data length
     len:=buf[2] + (buf[3] shl 8);
     for i:=0 to len+3 do cs:=cs+buf[i];
     while cs>65536 do cs:=cs-65536;
     checksum:=buf[len+4] + (buf[len+5] shl 8)-1;
     if cs=checksum then result:=true else result:=false;
     if result then showmessage(lang('ok'));
end;

function switch(x:byte):byte;
var
v,v1,v2:byte;
begin
v := x xor $04;
v1:= v AND $01;   // 0000 0001
v2:= v AND $02;   // 0000 0010
      v := v AND $FC;   // 1111 1100
      result := v+(v1 SHL 1)+(v2 SHR 1);
end;

procedure ColoreImageBitmap(Image:TImage;Color:TColor);
begin
   Image.Picture.Bitmap.Canvas.Pen.Color:=Color;
   Image.Picture.Bitmap.Canvas.Pen.Style:=psSolid;
   Image.Picture.Bitmap.Canvas.Brush.Color:=Color;
   Image.Picture.Bitmap.Canvas.Brush.Style:=bsSolid;
   Image.Picture.Bitmap.Canvas.Rectangle(0,0,Image.Width,Image.Height);
end;

procedure MySleep(Temps:Integer);
var
   TimeInit:TDateTime;
begin
// On attends
TimeInit:=Time;
while Time<TimeInit +Temps/1000/60/60/24 do Application.ProcessMessages;
end;

function Swap32(value:integer):integer;assembler;
asm
 mov eax,value
 mov ecx,eax
 shl eax,16
 shr ecx,16
 add eax,ecx
end;

procedure swapline(src,dst:pointer;width:integer);stdcall;
asm
 pushad
 mov esi,src
 mov edi,dst
 mov ecx,width
@bcHz:
 lodsw
 xchg al,ah
 stosw
 dec ecx
 jnz @bcHz
 popad
end;

procedure AUSECOURS(page:string);
var rcse:cardinal;fname,slg:string;
begin
 slg:=copy(config.Language,1,2) + '\';
 if lowercase(slg)='fr\' then slg:=''; //nolang
 fname:=ExtractFilePath(Application.ExeName)+ '\help\' + slg + page + #0; //nolang
 rcse:=ShellExecute(0, 'open',pchar(fname),0,0,SW_SHOWNORMAL); //nolang
 if rcse < 33 then
  begin
   fname:=lang('Erreur ') + inttostr(rcse);
   messagebox(0,'Impossible d''obtenir l''aide',pchar(fname),$1010);
  end;
end;

procedure CalculIntervales(Mini,Maxi:Double;var Debut,Pas:Double);
var
   Etendue,EtendueTmp:Double;
   NbPas,Mult:array[1..3] of Double;

   Index:array[1..3] of Byte;
   Marque:Double;
   Str:string;
   Trouve:Boolean;
   DTmp:Double;
   BTmp:Byte;
   i,j:Integer;
   Test:Boolean;

   NbPasMaxi,NbPasMini:Double;
   PasMaxi,PasMini:Double;
begin
Etendue:=Maxi-Mini;
if Etendue=0 then Exit;
//Label1.Caption:='Etendue = '+MyFloatToStr(Etendue,2);

Mult[1]:=1;
EtendueTmp:=Etendue;
NbPas[1]:=EtendueTmp;
if NbPas[1]>=10 then
   begin
   while NbPas[1]>10 do
      begin
      EtendueTmp:=EtendueTmp/10;
      Mult[1]:=Mult[1]/10;
      NbPas[1]:=EtendueTmp;
      end;
   end
else
   begin
//   while NbPas[1]<10 do
   while EtendueTmp*10<=10 do
      begin
      EtendueTmp:=EtendueTmp*10;
      Mult[1]:=Mult[1]*10;
      NbPas[1]:=EtendueTmp;
      end;
   end;
//Label2.Caption:='NB Pas 1 = '+MyFloatToStr(NbPas[1],2);

Mult[2]:=1;
EtendueTmp:=Etendue;
NbPas[2]:=EtendueTmp/0.5;
if NbPas[2]>=10 then
   begin
   while NbPas[2]>10 do
      begin
      EtendueTmp:=EtendueTmp/10;
      Mult[2]:=Mult[2]/10;
      NbPas[2]:=EtendueTmp/0.5;
      end;
   end
else
   begin
//   while NbPas[2]<10 do
   while EtendueTmp*10/0.5<=10 do
      begin
      EtendueTmp:=EtendueTmp*10;
      Mult[2]:=Mult[2]*10;
      NbPas[2]:=EtendueTmp/0.5;
      end;
   end;
//Label3.Caption:='NB Pas 2 = '+MyFloatToStr(NbPas[2],2);

Mult[3]:=1;
EtendueTmp:=Etendue;
NbPas[3]:=EtendueTmp/0.2;
if NbPas[3]>=10 then
   begin
   while NbPas[3]>10 do
      begin
      EtendueTmp:=EtendueTmp/10;
      Mult[3]:=Mult[3]/10;
      NbPas[3]:=EtendueTmp/0.2;
      end;
   end
else
   begin
//   while NbPas[3]<10 do
   while EtendueTmp*10/0.2<=10 do
      begin
      EtendueTmp:=EtendueTmp*10;
      Mult[3]:=Mult[3]*10;
      NbPas[3]:=EtendueTmp/0.2;
      end;
   end;
//Label4.Caption:='NB Pas 3 = '+MyFloatToStr(NbPas[3],2);

for i:=1 to 3 do Index[i]:=i;

Trouve:=True;
while Trouve do
   begin
   Trouve:=False;
   for i:=1 to 2 do
      if NbPas[i]>NbPas[i+1] then
         begin
         Trouve:=True;
         DTmp:=NbPas[i];
         NbPas[i]:=NbPas[i+1];
         NbPas[i+1]:=DTmp;
         BTmp:=Index[i];
         Index[i]:=Index[i+1];
         Index[i+1]:=BTmp;
         end;
   end;

if NbPas[3]<=10 then j:=3
else if NbPas[2]<=10 then j:=2
else if NbPas[1]<=10 then j:=1
else
   begin
   ShowMessage(lang('Erreur'));
   Exit;
   end;

if Index[j]=1 then Pas:=1;
if Index[j]=2 then Pas:=0.5;
if Index[j]=3 then Pas:=0.2;
Pas:=Pas/Mult[Index[j]];                                          
// Marche pas si le mini est négatif et > 1 ?!
if Abs(Mini)<1 then
   Debut:=System.Int(Mini*Mult[Index[j]])/Mult[Index[j]]
else
   Debut:=System.Int(Mini)-Pas;

// Pour tomber juste
{Marque:=System.Int(Mini*Mult[Index[j]])/Mult[Index[j]];
Str:='';
while Marque<=Maxi+Pas*10e-10 do
   begin
   if (Marque>=Mini) then Str:=Str+MyFloatToStr(Marque,4)+'/';
   Marque:=Marque+Pas;
   end;
Label5.Caption:=Str;}

end;

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

//InputQuery(lang('Ajouter un offset'),
//function InputQuery(const ACaption, APrompt: string;
//  var Value: string): Boolean;

// To translate buttons
function MyInputQuery(const ACaption, APrompt: string;
  var Value: string): Boolean;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        Caption := APrompt;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
        WordWrap := True;
      end;
      Edit := TEdit.Create(Form);
      with Edit do
      begin
        Parent := Form;
        Left := Prompt.Left;
        Top := Prompt.Top + Prompt.Height + 5;
        Width := MulDiv(164, DialogUnits.X, 4);
        MaxLength := 255;
        Text := Value;
        SelectAll;
      end;
      ButtonTop := Edit.Top + Edit.Height + 15;
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := lang('OK');
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := lang('Annuler');
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), Edit.Top + Edit.Height + 15,
          ButtonWidth, ButtonHeight);
        Form.ClientHeight := Top + Height + 13;          
      end;
      if ShowModal = mrOk then
      begin
        Value := Edit.Text;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;

// Ajouter

function StrToPreciseAlpha(Line:string):Double;
var
 PosEsp:Integer;
 Hour,Min:integer;Sec:double;ds:char;
begin
 if Line='' then
  begin
   result:=99;
   exit;
  end;
try
//heures
   PosEsp:=Pos(Config.SeparateurHeuresMinutesAlpha,Line);
   if PosEsp=0 then PosEsp:=Pos(':',Line);
   if PosEsp=0 then PosEsp:=Pos('h',Line);
   if PosEsp=0 then raise Errorcoordonnees.Create(lang('Séparateur des heures absent'));
   Hour:=StrToInt(Copy(Line,1,PosEsp-1));
   if (Hour>23) or (Hour < 0) then raise Errorcoordonnees.Create(lang('Heure Alpha > 23h'));
//minutes
   Delete(Line,1,PosEsp);
   PosEsp:=Pos(Config.SeparateurMinutesSecondesAlpha,Line);
   if PosEsp=0 then PosEsp:=Pos(':',Line); //nolang
   if PosEsp=0 then PosEsp:=Pos('m',Line); //nolang
   if PosEsp=0 then raise Errorcoordonnees.Create(lang('Séparateur des minutes absent'));
   Min:=StrToInt(Copy(Line,1,PosEsp-1));
   if Min>59 then raise ErrorCoordonnees.Create(lang('Minutes Alpha > 59mn'));
//secondes
   Delete(Line,1,PosEsp);
   if Trim(Config.UnitesSecondesAlpha)<>'' then Line:=Copy(Line,1,Length(Line)-1);
   ds:=DecimalSeparator;
   DecimalSeparator:='.';
   Sec:=StrToFloat(Trim(Line));
   DecimalSeparator:=ds;
   if Sec>59.99 then raise ErrorCoordonnees.Create(lang('Secondes Alpha > 60s'));
//conversion
   Result:=Hour+(Min/60)+(Sec/3600);
except
   result:=99;
end;
end;

// sDDdMMmSS.SSs = declinaison
//       s = Signe + ou -
//      DD = Degres
//      MM = Minutes
//      SS = Secondes}
// Résultat en degrés
// Entre -90 et +90 degrés
function StrToPreciseDelta(Line:String):Double;
var
 PosEsp:Integer;
 Deg,Min:integer;Sec:double;ds:char;
 Sign:Char;
begin
 if Line='' then
  begin
   result:=99;
   exit;
  end;
try
   while Pos('_',Line)<>0 do Delete(Line,Pos('_',Line),1);
//Degrés
   sign:='+';
   PosEsp:=Pos(Config.SeparateurDegresMinutesDelta,Line);
   if PosEsp=0 then PosEsp:=Pos('d',Line);
   if PosEsp=0 then PosEsp:=Pos('°',Line);
   if PosEsp=0 then raise Errorcoordonnees.Create(lang('Séparateur des degrés absent'));
   Deg:=StrToInt(Copy(Line,1,PosEsp-1));
   if deg < 0 then
    begin
     sign:='-';
     deg:=abs(deg);
    end;
   if deg > 89 then raise ErrorCoordonnees.Create(lang('Degrés Delta > 89°'));
//Minutes
   Delete(Line,1,POsEsp);
   PosEsp:=Pos(Config.SeparateurMinutesSecondesDelta,Line);
   if PosEsp=0 then PosEsp:=Pos('m',Line); //nolang
   if PosEsp=0 then PosEsp:=Pos('''',Line); //nolang
   if PosEsp=0 then raise ErrorCoordonnees.Create(lang('Séparateur des minutes absent'));
   Min:=StrToInt(Copy(Line,1,PosEsp-1));
   if Min>59 then raise ErrorCoordonnees.Create(lang('Minutes Delta > 59mn'));
//Secondes
   Delete(Line,1,POsEsp);
   PosEsp:=Pos(Config.UnitesSecondesDelta,Line);
   if PosEsp=0 then PosEsp:=Pos('s',Line); //nolang
   if PosEsp=0 then PosEsp:=Pos('"',Line); //nolang
   if PosEsp=0 then raise ErrorCoordonnees.Create(lang('Séparateur des secondes absent'));
   ds:=DecimalSeparator;
   DecimalSeparator:='.';
   Sec:=StrToFloat(Copy(Line,1,PosEsp-1));
   DecimalSeparator:=ds;
   if Sec>59.99 then raise ErrorCoordonnees.Create(lang('Secondes Delta > 59s'));
//Conversion
   result:=Deg + (Min/60) + (Sec/3600);
   if result > 90
     then raise ErrorCoordonnees.Create(lang('Degrés Delta > 89°59''59"'));
   if Sign='-' then Result:= - Result;
except
 result:=99;
end;
end;


end.
