unit u_meca;

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

// Dans TeleAuto :
// Ascension droite en heures
// Declinaison en degres

interface

uses math, sysutils,u_class,dialogs;

PROCEDURE Precession(ti,tf : double; VAR ari,dei : double);  // ICRS
procedure PrecessionFK4(ti,tf : double; var ari,dei : double);
function  SidTim2(jd0,ut,long : double): double;
procedure RiseSet(timebias,obslatitude,obslongitude:double; typobj:integer; jd0,ar,de:double; var hr,ht,hs,azr,azs:double;var irc:integer);
function  angulardistance_pix(x1,y1,x2,y2,pixsize_x, pixsize_y, focale:double):double;
function  get_star_distance(x1,y1,x2,y2:double):double;
function  within_circle(x0,y0,x1,y1,f:double):boolean;

function  LocalSidTim(DateTime:TDateTime;Longitude:Double):Double;
function  AngularDistance(Alpha1,Delta1,Alpha2,Delta2:Double):Double;
function  HeureToJourJulien(DateTime:TDateTime):Double;
function  JourJulienToHeure(JD:Double):TDateTime;
procedure GetAlphaDeltaFromHor(DateTime:TDateTime;Elevation,Azimuth,ObsLatitude,ObsLongitude:Double;var Alpha,Delta:Double);
procedure GetHorFromAlphaDelta(AngleHoraire,Delta,ObsLatitude:Double;var Azimuth,Hauteur:Double );
function  GetElevation(DateTime:TDateTime;Alpha,Delta,ObsLatitude,ObsLongitude:Double):double;
function  GetElevationNow(Alpha,Delta,ObsLatitude,ObsLongitude:double):Double;
function  GetAzimuth(DateTime:TDateTime;Alpha,Delta,ObsLatitude,ObsLongitude:Double):Double;
function  GetAzimuthNow(Alpha,Delta,ObsLatitude,ObsLongitude:Double):Double;
function  GetHourAngle(DateTime:TDateTime;Alpha,ObsLongitude:double):Double;
function  GetAlphaFromHourAngle(DateTime:TDateTime;AH,ObsLongitude:double):Double;
function  DistanceToMoon(DateTime:TDateTime;Alpha,Delta:Double):Double;
function  MoonCurrentPhase(DateTime:TDateTime):Double;
function  DistanceToSun(DateTime:TDateTime;Alpha,Delta:Double):Double;
function  AirMass(Delta,HA:double):Double;

procedure vaisala(JD1,RA1,DE1,JD2,RA2,DE2,JD3,rho:double; var ra,dec,a_moins_r2:double; var elem:Telements);
procedure get_moon_position(dttm:tdatetime; _longitude,_latitude:double; var az,ha:double);
{soleil et lune}
function  julian_date(date:TDateTime):double;   // laisser ca !
procedure calc_geocentric(var coord:t_coord; date:TDateTime);
function  sun_coordinate(date:TDateTime):t_coord;
function  sun_distance(date:TDateTime): double;
function  sun_diameter(date:TDateTime):double;
function  star_time(date:TDateTime):double;
function  StartSeason(year: integer; season:TSeason):TDateTime;
function  nextperigee(date:TDateTime):TDateTime;
function  nextapogee(date:TDateTime):TDateTime;
function  NextEclipse(var date:TDateTime; sun:boolean):TEclipse;
function  moon_distance(date:TDateTime): double;
function  age_of_moon(date:TDateTime): double;
function  last_phase(date:TDateTime; phase:TMoonPhase):TDateTime;
function  next_phase(date:TDateTime; phase:TMoonPhase):TDateTime;
function  lunation(date:TDateTime):integer;
function  moon_coordinate(date:TDateTime):t_coord;
function  moon_diameter(date:TDateTime):double;
procedure correct_position(var position:t_coord; date:TDateTime;
                           latitude,longitude,height:double);
procedure get_moonsun_riseset(date:TDateTime; latitude, longitude:double;
                       sun: boolean; kind: T_RiseSet; var r:tdatetime);
function put_in_360(x:double):double;
{asteroides, merci patrick}
function Jd(annee,mois,jour :INTEGER; Heure:double):double;
function get_asteroid_position_from_file(p:p_target):boolean;
procedure InitAsteroid(elem : T_ast_elem );
procedure Asteroid(var astcoord : T_ast_ephem);
Function  Plan404( pla : PPlanetData):integer; cdecl; external 'PLAN404.DLL'; //nolang
procedure correct_phi(altitude:double; longitude:double; var rho_sin_phi,rho_cos_phi:double); // Meeus
procedure Parallaxe(tsl:double; coord:T_ast_ephem);
procedure get_asteroid_position_from_db(p:t_ast_elem; jd,tsl:double; var ta:t_ast_ephem );
function elliptic_orbit_velocity_i(distance,sm_axis:double):double;
function elliptic_orbit_velocity_aphelion(ecc,sm_axis:double):double;
function elliptic_orbit_velocity_perihelion(ecc,sm_axis:double):double;
function aphelion(ecc,sm_axis:double):double;
function perihelion(ecc,sm_axis:double):double;
function get_asteroid_family(ecc,sm_axis,inclination,aphelion,perihelion:double):string;
{en cours}
function  mag_to_radial_velocity(m_limit,m_abs:double):double;
function refraction_meeus(h,p,t:double):double;
function refraction_moshier(alt,atpress,attemp:double):double;
function epsilon(jj:double):double;
function mod3600(x:double):double;
function sscc( k:integer; arg:double; n:integer):integer;

procedure AlphaDeltaToXY(Alpha0,Delta0,Alpha,Delta:Double;var X,Y:Double);
procedure XYToAlphaDelta(X,Y,Alpha0,Delta0:Double;var Alpha,Delta:Double);
function NameToAlphaDelta(Name:string;var Alpha,Delta:Double):Boolean;
function AlphaDeltaToName(Alpha,Delta:Double;var Name:string):byte;
function compute_sampling_x(f,pixsize:double;binning:byte):double;
function compute_sampling_y(f,pixsize:double;binning:byte):double;
function compute_fov_ccd(f,pixsize:double; pix_x:integer):double;
function what_const(alpha,delta:double):shortstring;

implementation

uses u_general,
     pu_main,
     catalogues,
     u_constants,
     u_file_io,
     u_lang,
     u_hour_servers;


var
   Oaa,Obb,Occ,Oa,Ob,Oc,Ot,Oq,Oe,Oomi,Oepoque,Omk1,Omk2 :Double;     // parametres de l'orbite
   At,Am,Aa,Ah,Ag : double;
   annee,OldCat : integer;
   AsterName : string;
   SolT0,XSol,YSol,ZSol : double;


procedure RiseSet(timebias,obslatitude,obslongitude:double; typobj:integer; jd0,ar,de:double; var hr,ht,hs,azr,azs:double;var irc:integer);
{lever et coucher des astres communs
            timebias = decalage avec heure TU. passer 0 pour avoir les heures TU
            typeobj = 1 etoile ; typeobj = 2 soleil
            irc = 0 lever et coucher
            irc = 1 circumpolaire
            irc = 2 invisible
           }
const ho : array[1..3] of Double = (-9.89E-3,-1.454E-2,2.18E-3) ;
var jde,hs0,chh0,hh0,m0,m1,m2,a0 : double;
begin
     // jd doit etre en jour julien entier
     jde:=jd0-int(jd0);
     if jde < 0.5 then jd0:=trunc(jd0)-0.5 else jd0:=trunc(jd0)+0.5;
     precession(2451545.0,jd0,ar,de); // J2000 coord. to date
     hs0 := sidtim2(jd0,0.0,0.0)*15 ;
     chh0:=(ho[typobj]-sin(degtorad(ObsLatitude))*sin(degtorad(de)))/(cos(degtorad(ObsLatitude))*cos(degtorad(de)));
     if abs(chh0)<=1 then
     begin
          hh0:=radtodeg(arccos(chh0));
          m0:=(ar*15+ObsLongitude-hs0)/360;
          m1:=m0-hh0/360;
          m2:=m0+hh0/360;
          ht:=rmod(rmod(m0+1,1)*24+TimeBias+24,24);
          hr:=rmod(rmod(m1+1,1)*24+TimeBias+24,24);
          hs:=rmod(rmod(m2+1,1)*24+TimeBias+24,24);
          a0:=radtodeg(arctan2(sin(degtorad(hh0)),cos(degtorad(hh0))*sin(degtorad(Obslatitude))-tan(degtorad(de))*cos(degtorad(Obslatitude))));
          azr:=360-a0;
          azs:=a0;
          irc:=0;
     end
     else
     begin
          hr:=0;hs:=0;azr:=0;azs:=0;
          if sgn(de)=sgn(ObsLatitude) then
          begin
               m0:=(ar*15+ObsLongitude-hs0)/360;     // circumpolaire 
               ht:=rmod(rmod(m0+1,1)*24+TimeBias+24,24);
               irc:=1 ;
          end
          else
          begin
               ht:=0;      // invisible 
               irc:=2;
          end;
     end;
end;

function within_circle(x0,y0,x1,y1,f:double):boolean;
// x0,y0:origin  x1,y1:star    f:radius of the circle	  (all in radians)
begin
	 result:=f < ArcCos(sin(y0)*sin(y1)+cos(y0)*cos(y1)*cos(x0-x1));
end;


{-------------------------------------------------------------------------------

                           Distance entre 2 points

-------------------------------------------------------------------------------}

function angulardistance_pix(x1,y1,x2,y2,pixsize_x, pixsize_y, focale:double):double;
{retourne la distance en arc sec entre 2 pixels, pour une focale -en mm- et une taille de
 pixels x et y (mm) connues}
var
dx,dy,a,b:double;
begin
        dx:=x2-x1;
        dy:=y2-y1;
        a:=(3600*180)/pi;
        b:=sqrt(sqr(dx*pixsize_x)+sqr(dy*pixsize_y))/focale;
        result:=a*b;
end;

function get_star_distance(x1,y1,x2,y2:double):double;
// pareil qu au dessus - a tester en cas de petites differences angulaires
var
xr1,xr2,yr1,yr2,w,diff,cosb:double;
pos1,pos2:array[0..2] of double;
i:integer;
begin
        {Convert two vectors to direction cosines}
        xr1 := degtorad (x1);
        yr1 := degtorad (y1);
        cosb := cos (yr1);
        pos1[0] := cos (xr1) * cosb;
        pos1[1] := sin (xr1) * cosb;
        pos1[2] := sin (yr1);

        xr2 := degtorad (x2);
        yr2 := degtorad (y2);
        cosb := cos (yr2);
        pos2[0] := cos (xr2) * cosb;
        pos2[1] := sin (xr2) * cosb;
        pos2[2] := sin (yr2);

        {Modulus squared of half the difference vector}
        w := 0;
        for i := 0 to 2 do w := w + (pos1[i] - pos2[i]) * (pos1[i] - pos2[i]);
        w := w / 4;
        if w > 1 then w:= 1;

        {Angle beween the vectors}
        diff := 2 * arctan2 (sqrt(w),sqrt(1-w));
        result:=diff*180/pi;
end;

{-------------------------------------------------------------------------------

                           TSL - Jour Julien

-------------------------------------------------------------------------------}


{$O-}

// Temps Sideral local
// Longitude en degres
// Resultat en degres
function LocalSidTim(DateTime:TDateTime;Longitude:Double):Double;
var
T,Theta,JJ:Double;
DateTime1,DateTime2:TDateTime;
begin
DateTime1:=Trunc(DateTime);
DateTime2:=Frac(DateTime);
JJ:=HeureToJourJulien(DateTime1);
T:=(JJ-2415020.0)/36525; // T en siecle julien
//Theta:=Frac((100.46061837+36000.770053608*t+0.000387933*t*t-t*t*t/38710000)/360)*360; // Theta en degres
Theta:=Frac(0.276919398+100.0021359*T+0.000001075*T*T)*24; // Theta en heures
Result:=Theta*15+1.002737908*DateTime2*24*15-Longitude;
end;

function SidTim2(jd0,ut,long : double): double;
// laisser ici
VAR t,te: double;
BEGIN
    t:=(jd0-2451545.0)/36525;
    te:=100.46061837 + 36000.770053608*t + 0.000387933*t*t - t*t*t/38710000;
    result :=  Rmod(te/15 - long/15 + 1.002737908*ut,24) ;
END ;


function star_time(date:TDateTime):double;
{laisser ici, utilise par les calculs relatifs a la lune, ou remplacer avec sidtim}
var
  jd, t: double;
begin
  jd:=julian_date(date);
  t:=(jd-2451545.0)/36525;
  result:=put_in_360(280.46061837+360.98564736629*(jd-2451545.0)+
                     t*t*(0.000387933-t/38710000));
end;


{$O+}

function HeureToJourJulien(DateTime:TDateTime):Double;
begin
 Result:=DateTime+2415018.5;
end;


// Jour julien -> TDatetime
function JourJulienToHeure(jd:Double):TDateTime;
begin
 Result:=jd-2415018.5;
end;


function Jd(annee,mois,jour :INTEGER; Heure:double):double;
// jour julien
VAR siecle,cor:INTEGER ;
begin
    if mois<=2 then begin
      annee:=annee-1;
      mois:=mois+12;
    end ;
    if annee*10000+mois*100+jour >= 15821015 then begin
       siecle:=annee div 100;
       cor:=2 - siecle + siecle div 4;
    end else cor:=0;
    jd:=int(365.25*(annee+4716))+int(30.6001*(mois+1))+jour+cor-1524.5 +heure/24;
END;


{-------------------------------------------------------------------------------

                           Conversion de coordonnees

-------------------------------------------------------------------------------}

// Le zero d'azimuth est ou ???
// Hauteur entre 0 et 90 ?
// Azimuth entre -180 et 180 ?
// Hauteur et Azimuth en degres ?
// Alpha en heures ?
// Delta en degres ?
procedure GetAlphaDeltaFromHor(DateTime:TDateTime;Elevation,Azimuth,ObsLatitude,ObsLongitude:Double;var Alpha,Delta:Double);
{Calculate alpha and dec from the given altitude and azimuth and location,
for given timebias}
var
hs0,AngleHoraire,SinDelta:double;
begin
    hs0:=LocalSidTim(DateTime,ObsLongitude);
    hs0:=rmod(hs0,360);
    if hs0<0 then hs0:=360+hs0;
    Elevation:=Elevation*DEGRAD;
    Azimuth:=Azimuth*DEGRAD;
    ObsLatitude:=ObsLatitude*DEGRAD;
//    Delta:= RADDEG*arcsin(sin(Latitude)*sin(Hauteur)-cos(Latitude)*cos(Hauteur)*cos(Azimuth));
    SinDelta:=Sin(Elevation)*Sin(ObsLatitude)+Cos(Elevation)*Cos(ObsLatitude)*Cos(Azimuth);
    Delta:=arcsin(SinDelta);
    AngleHoraire:=ArcCos((Sin(Elevation)-Sin(ObsLatitude)*Sin(Delta))/Cos(ObsLatitude)/Cos(Delta));
    if Sin(Azimuth)>0 then AngleHoraire:=2*pi-AngleHoraire;
    AngleHoraire:=RADDEG*AngleHoraire;
    Alpha:=hs0-AngleHoraire;
    Alpha:=rmod(Alpha,360);
    if Alpha<0 then Alpha:=Alpha+360;
    Alpha:=Alpha/15;
    Delta:=RADDEG*Delta;
end;

// conversion des coordonées équatoriales en coordonnées horizontales
//            AngleHoraire = angle horaire en degrés
//            Delta        = déclinaison en degrés
//            ObsLatitude  = latitude en degrés
//            Azimuth      = azimut en degrés
//            Hauteur      = hauteur en degrés
procedure GetHorFromAlphaDelta(AngleHoraire,Delta,ObsLatitude:Double;var Azimuth,Hauteur:Double );
//procedure Horizontal(AngleHoraire,Delta,ObsLatitude : double ; var Azimuth,Hauteur : double );
begin
    ObsLatitude:=degtorad(ObsLatitude);
    Delta:=degtorad(Delta);
    AngleHoraire:=degtorad(AngleHoraire);
    Hauteur:=radtodeg(arcsin(sin(ObsLatitude)*sin(Delta)+cos(ObsLatitude)*cos(Delta)*cos(AngleHoraire)));  // OK
    Azimuth:=radtodeg(arctan2(-sin(AngleHoraire),tan(Delta)*cos(ObsLatitude)-cos(AngleHoraire)*sin(ObsLatitude)));
    Azimuth:=Rmod(Azimuth+360,360);

    { refraction meeus91 15.4 }
    // Y faudrait le mettre a la demande expresse de l'utilisateur non ?
    // Faudrait pas utiliser les formules du BDL ou Telescope Control plutot ?
    // Lesquelles sont les plus precises ?
    // h:=h+(1.02/tan(degtorad(h+10.3/(h+5.11))))/60;
end;

// Hauteur d'une étoile à un instant donné
// Resultat en degres
function GetElevation(DateTime:TDateTime;Alpha,Delta,ObsLatitude,ObsLongitude:double):Double;
var
hs0,hour_angle,Azimuth,Hauteur:Double;
begin
    hs0:=LocalSidTim(DateTime,Obslongitude);
    hour_angle:=hs0-(Alpha*15);  // Alpha en heures
    while hour_angle>=360 do hour_angle:=hour_angle-360;
    while hour_angle<0 do hour_angle:=hour_angle+360;
    GetHorFromAlphaDelta(hour_angle,Delta,ObsLatitude,Azimuth,Hauteur);
    while Hauteur>90  do Hauteur:=Hauteur-360;
    while Hauteur<-90 do Hauteur:=Hauteur+360;
    Result:=Hauteur;
end;

// Hauteur d'une étoile à l'instant actuel
// Resultat en degres
function GetElevationNow(Alpha,Delta,ObsLatitude,Obslongitude:double):double;
begin
     Result:=GetElevation(GetHourDT,Alpha,Delta,ObsLatitude,Obslongitude);
end;

// Azimuth d'une étoile à un instant donné
// Resultat en degres
function GetAzimuth(DateTime:TDateTime;Alpha,Delta,ObsLatitude,ObsLongitude:Double):Double;
var
hour_angle,Hauteur,Azimuth:Double;
hs0:double;
begin
    hs0 := LocalSidTim(DateTime,Obslongitude);
    hour_angle:=hs0-(Alpha*15); // Alpha en heures
    while hour_angle>=360 do hour_angle:=hour_angle-360;
    while hour_angle<0 do hour_angle:=hour_angle+360;
    GetHorFromAlphaDelta(hour_angle,Delta,Obslatitude,Azimuth,Hauteur);
    while Azimuth>=360  do Azimuth:=Azimuth-360;
    while Azimuth<0 do Azimuth:=Azimuth+360;
    Result:=Azimuth;
end;

// Azimuth d'une étoile à l'instant actuel
// Resultat en degres
function GetAzimuthNow(Alpha,Delta,ObsLatitude,ObsLongitude:Double):Double;
begin
     Result:=GetAzimuth(GetHourDT,Alpha,Delta,ObsLatitude,ObsLongitude);
end;

// Donne l'angle horaire d'un objet
// Alpha en heures
// ObsLongitude en degres
// Résultat en degres
function GetHourAngle(DateTime:TDateTime;Alpha,ObsLongitude:double):Double;
var
hs0,Angle:Double;
begin
hs0:=LocalSidTim(DateTime,Obslongitude);
Angle:=hs0-(Alpha*15);
while Angle>=360 do Angle:=Angle-360;
while Angle<0 do Angle:=Angle+360;
Result:=Angle;
end;

// Donne l'ascension droite d'un objet à partir de l'angle horaire
// AH en degres
// ObsLongitusde en degres
// Résultat en heures
function GetAlphaFromHourAngle(DateTime:TDateTime;AH,ObsLongitude:double):Double;
var
hs0,Alpha:Double;
begin
hs0:=LocalSidTim(DateTime,Obslongitude);
Alpha:=hs0-AH;
while Alpha>=360 do Alpha:=Alpha-360;
while Alpha<0 do Alpha:=Alpha+360;
Result:=Alpha/15;
end;



{-------------------------------------------------------------------------------

                      Soleil et Lune, adapte de Meeus

-------------------------------------------------------------------------------}

{ Angular functions with degrees }
function sin_d(x:double):double;
begin
  sin_d:=sin(put_in_360(x)*pi/180);
end;

function cos_d(x:double):double;
begin
  cos_d:=cos(put_in_360(x)*pi/180);
  end;

function tan_d(x:double):double;
begin
  tan_d:=tan(put_in_360(x)*pi/180);
  end;

function arctan2_d(a,b:double):double;
begin
  result:=arctan2(a,b)*180/pi;
  end;

function arcsin_d(x:double):double;
begin
  result:=arcsin(x)*180/pi;
  end;

function arccos_d(x:double):double;
begin
  result:=arccos(x)*180/pi;
  end;


function arctan_d(x:double):double;
begin
  result:=arctan(x)*180/pi
  end;



function put_in_360(x:double):double;
begin
  result:=x-round(x/360)*360;
  while result<0 do result:=result+360;
end;



{ Julian date }
function julian_date(date:TDateTime):double;
begin
  if date>encodedate(1582,10,14) then
    julian_date:=2451544.5-encodedate(2000,1,1)+date
  else
    julian_date:=0;   { not yet implemented !!! }
  end;


function delphi_date(juldat:double):TDateTime;
begin
  if juldat>=julian_date(encodedate(1582,10,15)) then begin
    delphi_date:= juldat-2451544.5+encodedate(2000,1,1);
    end
  else
    delphi_date:=0;    { not yet implemented !!! }
  end;


procedure get_moon_position(dttm:tdatetime; _longitude,_latitude:double; var az,ha:double);
var
c:t_coord;
alpha,delta,angle_horaire:double;
tsl:tdatetime;
begin
	 c:=moon_coordinate(dttm);
	 calc_geocentric(c,dttm);
	 tsl:=LocalSidTim(dttm,_longitude)/15;
	 if tsl > 24 then tsl:=tsl-24;
         alpha:=abs(c.alpha)/15;
         delta:=c.delta;
	 angle_horaire:=tsl-alpha;
	 GetHorFromAlphaDelta(angle_horaire,delta,_Latitude, az,Ha);
end;


procedure get_moonsun_riseset(date:TDateTime; latitude, longitude:double;
                       sun: boolean; kind: T_RiseSet; var r:tdatetime);
var
  h: double;
  pos1, pos2, pos3: t_coord;
  h0, theta0, cos_h0, cap_h0: double;
  m0,m1,m2: double;

function do_the_interpolation(y1,y2,y3,n: double):double;
var
  a,b,c: double;
begin
  a:=y2-y1;
  b:=y3-y2;
  if a>100 then  a:=a-360;
  if a<-100 then  a:=a+360;
  if b>100 then  b:=b-360;
  if b<-100 then  b:=b+360;
  c:=b-a;
  result:=y2+0.5*n*(a+b+n*c);
  end;

function do_the_correction(m:double; kind:integer):double;
var
  alpha,delta,h, height: double;
begin
  alpha:=do_the_interpolation(pos1.alpha,
                       pos2.alpha,
                       pos3.alpha,
                       m);
  delta:=do_the_interpolation(pos1.delta,
                       pos2.delta,
                       pos3.delta,
                       m);
  h:=put_in_360((theta0+360.985647*m)-longitude-alpha);
  if h>180 then h:=h-360;

  height:=arcsin_d(sin_d(latitude)*sin_d(delta)
                   +cos_d(latitude)*cos_d(delta)*cos_d(h));

  case kind of
    0:   result:=-h/360;
    1,2: result:=(height-h0)/(360*cos_d(delta)*cos_d(latitude)*sin_d(h));
    else result:=0;   // this cannot happen 
    end;
  end;

begin
  if sun then
    h0:=-0.8333
  else begin
    pos1:=moon_coordinate(date);
    correct_position(pos1,date,latitude,longitude,0);
    h0:=0.7275*pos1.parallax-34/60;
    end;

  h:=int(date);
  theta0:=star_time(h);
  if sun then begin
    pos1:=sun_coordinate(h-1);
    pos2:=sun_coordinate(h);
    pos3:=sun_coordinate(h+1);
    end
  else begin
    pos1:=moon_coordinate(h-1);
    correct_position(pos1,h-1,latitude,longitude,0);
    pos2:=moon_coordinate(h);
    correct_position(pos2,h,latitude,longitude,0);
    pos3:=moon_coordinate(h+1);
    correct_position(pos3,h+1,latitude,longitude,0);
    end;

  cos_h0:=(sin_d(h0)-sin_d(latitude)*sin_d(pos2.delta))/
          (cos_d(latitude)*cos_d(pos2.delta));
  if (cos_h0<-1) or (cos_h0>1) then
    raise E_NoRiseSet.Create('No rises or sets calculable'); //nolang
  cap_h0:=arccos_d(cos_h0);

  m0:=(pos2.alpha+longitude-theta0)/360;
  m1:=m0-cap_h0/360;
  m2:=m0+cap_h0/360;

  m0:=frac(m0);
  if m0<0 then m0:=m0+1;
  m1:=frac(m1);
  if m1<0 then m1:=m1+1;
  m2:=frac(m2);
  if m2<0 then m2:=m2+1;

  m0:=m0+do_the_correction(m0,0);
  m1:=m1+do_the_correction(m1,1);
  m2:=m2+do_the_correction(m2,2);

  case kind of
    krise:    r:=h+m1;
    kset:     r:=h+m2;
    ktransit: r:=h+m0;
    else      r:=0;    // this can't happen 
    end;

end;





{ Coordinate functions }
procedure calc_geocentric(var coord:t_coord; date:TDateTime);
{$ifndef correction_low} 
const
arg_mul:array[0..30,0..4] of shortint = (
   ( 0, 0, 0, 0, 1),
   (-2, 0, 0, 2, 2),
   ( 0, 0, 0, 2, 2),
   ( 0, 0, 0, 0, 2),
   ( 0, 1, 0, 0, 0),
   ( 0, 0, 1, 0, 0),
   (-2, 1, 0, 2, 2),
   ( 0, 0, 0, 2, 1),
   ( 0, 0, 1, 2, 2),
   (-2,-1, 0, 2, 2),
   (-2, 0, 1, 0, 0),
   (-2, 0, 0, 2, 1),
   ( 0, 0,-1, 2, 2),
   ( 2, 0, 0, 0, 0),
   ( 0, 0, 1, 0, 1),
   ( 2, 0,-1, 2, 2),
   ( 0, 0,-1, 0, 1),
   ( 0, 0, 1, 2, 1),
   (-2, 0, 2, 0, 0),
   ( 0, 0,-2, 2, 1),
   ( 2, 0, 0, 2, 2),
   ( 0, 0, 2, 2, 2),
   ( 0, 0, 2, 0, 0),
   (-2, 0, 1, 2, 2),
   ( 0, 0, 0, 2, 0),
   (-2, 0, 0, 2, 0),
   ( 0, 0,-1, 2, 1),
   ( 0, 2, 0, 0, 0),
   ( 2, 0,-1, 0, 1),
   (-2, 2, 0, 2, 2),
   ( 0, 1, 0, 0, 1)
                 );
arg_phi:array[0..30,0..1] of longint = (
   (-171996,-1742),
   ( -13187,  -16),
   (  -2274,   -2),
   (   2062,    2),
   (   1426,  -34),
   (    712,    1),
   (   -517,   12),
   (   -386,   -4),
   (   -301,    0),
   (    217,   -5),
   (   -158,    0),
   (    129,    1),
   (    123,    0),
   (     63,    0),
   (     63,    1),
   (    -59,    0),
   (    -58,   -1),
   (    -51,    0),
   (     48,    0),
   (     46,    0),
   (    -38,    0),
   (    -31,    0),
   (     29,    0),
   (     29,    0),
   (     26,    0),
   (    -22,    0),
   (     21,    0),
   (     17,   -1),
   (     16,    0),
   (    -16,    1),
   (    -15,    0)
  );
arg_eps:array[0..30,0..1] of longint = (
   ( 92025,   89),
   (  5736,  -31),
   (   977,   -5),
   (  -895,    5),
   (    54,   -1),
   (    -7,    0),
   (   224,   -6),
   (   200,    0),
   (   129,   -1),
   (   -95,    3),
   (     0,    0),
   (   -70,    0),
   (   -53,    0),
   (     0,    0),
   (   -33,    0),
   (    26,    0),
   (    32,    0),
   (    27,    0),
   (     0,    0),
   (   -24,    0),
   (    16,    0),
   (    13,    0),
   (     0,    0),
   (   -12,    0),
   (     0,    0),
   (     0,    0),
   (   -10,    0),
   (     0,    0),
   (    -8,    0),
   (     7,    0),
   (     9,    0)
  );

{$endif}
var
  t,omega: double;
{$ifdef correction_low}
  l,ls: double;
{$else}
  d,m,ms,f,s: double;
  i: integer;
{$endif}
  epsilon,epsilon_0,delta_epsilon: double;
  delta_phi: double;
  alpha,delta: double;
begin
  t:=(julian_date(date)-2451545.0)/36525;

  // longitude of rising knot 
  omega:=put_in_360(125.04452+(-1934.136261+(0.0020708+1/450000*t)*t)*t);

{$ifdef correction_low}
// mean longitude of sun (l) and moon (ls)
l:=280.4665+36000.7698*t;
ls:=218.3165+481267.8813*t;

// correction due to nutation
delta_epsilon:=9.20*cos_d(omega)+0.57*cos_d(2*l)+0.10*cos_d(2*ls)-0.09*cos_d(2*omega);

// longitude correction due to nutation
delta_phi:=(-17.20*sin_d(omega)-1.32*sin_d(2*l)-0.23*sin_d(2*ls)+0.21*sin_d(2*omega))/3600;
{$else}

// mean elongation of moon to sun 
d:=put_in_360(297.85036+(445267.111480+(-0.0019142+t/189474)*t)*t);

// mean anomaly of the sun
m:=put_in_360(357.52772+(35999.050340+(-0.0001603-t/300000)*t)*t);

// mean anomly of the moon
ms:=put_in_360(134.96298+(477198.867398+(0.0086972+t/56250)*t)*t);

// argument of the latitude of the moon 
f:=put_in_360(93.27191+(483202.017538+(-0.0036825+t/327270)*t)*t);

delta_phi:=0;
delta_epsilon:=0;

for i:=0 to 30 do begin
  s:= arg_mul[i,0]*d
     +arg_mul[i,1]*m
     +arg_mul[i,2]*ms
     +arg_mul[i,3]*f
     +arg_mul[i,4]*omega;
  delta_phi:=delta_phi+(arg_phi[i,0]+arg_phi[i,1]*t*0.1)*sin_d(s);
  delta_epsilon:=delta_epsilon+(arg_eps[i,0]+arg_eps[i,1]*t*0.1)*cos_d(s);
  end;

delta_phi:=delta_phi*0.0001/3600;
delta_epsilon:=delta_epsilon*0.0001/3600;

{$endif}

  // angle of ecliptic
  epsilon_0:=84381.448+(-46.8150+(-0.00059+0.001813*t)*t)*t;

  epsilon:=(epsilon_0+delta_epsilon)/3600;

  coord.longitude:=put_in_360(coord.longitude+delta_phi);

  // geocentric coordinates 
  alpha:=arctan2_d( sin_d(coord.longitude)*cos_d(epsilon)
                   -tan_d(coord.latitude)*sin_d(epsilon)
                  ,cos_d(coord.longitude));
  delta:=arcsin_d( sin_d(coord.latitude)*cos_d(epsilon)
                  +cos_d(coord.latitude)*sin_d(epsilon)*sin_d(coord.longitude));

  coord.alpha:=alpha;
  coord.delta:=delta;
end;


{ Based upon Chapter 24 of Meeus }
function sun_coordinate(date:TDateTime):t_coord;
var
  t,e,m,c,nu: double;
  l0,o,omega,lambda: double;
begin
  t:=(julian_date(date)-2451545.0)/36525;

  // geometrical mean longitude of the sun
  l0:=280.46645+(36000.76983+0.0003032*t)*t;

  // excentricity of the erath orbit
  e:=0.016708617+(-0.000042037-0.0000001236*t)*t;

  // mean anomaly of the sun 
  m:=357.52910+(35999.05030-(0.0001559+0.00000048*t)*t)*t;

  // mean point of sun
  c:= (1.914600+(-0.004817-0.000014*t)*t)*sin_d(m)
     +(0.019993-0.000101*t)*sin_d(2*m)
     +0.000290*sin_d(3*m);

  // true longitude of the sun 
  o:=put_in_360(l0+c);

  // true anomaly of the sun
  nu:=m+c;

  // distance of the sun in km
  result.radius:=(1.000001018*(1-e*e))/(1+e*cos_d(nu))*AU;

  // apparent longitude of the sun 
  omega:=125.04452+(-1934.136261+(0.0020708+1/450000*t)*t)*t;
  lambda:=put_in_360(o-0.00569-0.00478*sin_d(omega)
                     -20.4898/3600/(result.radius/AU));

  result.longitude:=lambda;
  result.latitude:=0;

  calc_geocentric(result,date);
end;


{ Based upon Chapter 45 of Meeus }
function moon_coordinate(date:TDateTime):t_coord;
const
arg_lr:array[0..59,0..3] of shortint = (
   ( 0, 0, 1, 0),
   ( 2, 0,-1, 0),
   ( 2, 0, 0, 0),
   ( 0, 0, 2, 0),
   ( 0, 1, 0, 0),
   ( 0, 0, 0, 2),
   ( 2, 0,-2, 0),
   ( 2,-1,-1, 0),
   ( 2, 0, 1, 0),
   ( 2,-1, 0, 0),
   ( 0, 1,-1, 0),
   ( 1, 0, 0, 0),
   ( 0, 1, 1, 0),
   ( 2, 0, 0,-2),
   ( 0, 0, 1, 2),
   ( 0, 0, 1,-2),
   ( 4, 0,-1, 0),
   ( 0, 0, 3, 0),
   ( 4, 0,-2, 0),
   ( 2, 1,-1, 0),
   ( 2, 1, 0, 0),
   ( 1, 0,-1, 0),
   ( 1, 1, 0, 0),
   ( 2,-1, 1, 0),
   ( 2, 0, 2, 0),
   ( 4, 0, 0, 0),
   ( 2, 0,-3, 0),
   ( 0, 1,-2, 0),
   ( 2, 0,-1, 2),
   ( 2,-1,-2, 0),
   ( 1, 0, 1, 0),
   ( 2,-2, 0, 0),
   ( 0, 1, 2, 0),
   ( 0, 2, 0, 0),
   ( 2,-2,-1, 0),
   ( 2, 0, 1,-2),
   ( 2, 0, 0, 2),
   ( 4,-1,-1, 0),
   ( 0, 0, 2, 2),
   ( 3, 0,-1, 0),
   ( 2, 1, 1, 0),
   ( 4,-1,-2, 0),
   ( 0, 2,-1, 0),
   ( 2, 2,-1, 0),
   ( 2, 1,-2, 0),
   ( 2,-1, 0,-2),
   ( 4, 0, 1, 0),
   ( 0, 0, 4, 0),
   ( 4,-1, 0, 0),
   ( 1, 0,-2, 0),
   ( 2, 1, 0,-2),
   ( 0, 0, 2,-2),
   ( 1, 1, 1, 0),
   ( 3, 0,-2, 0),
   ( 4, 0,-3, 0),
   ( 2,-1, 2, 0),
   ( 0, 2, 1, 0),
   ( 1, 1,-1, 0),
   ( 2, 0, 3, 0),
   ( 2, 0,-1,-2)
                 );
arg_b:array[0..59,0..3] of shortint = (
   ( 0, 0, 0, 1),
   ( 0, 0, 1, 1),
   ( 0, 0, 1,-1),
   ( 2, 0, 0,-1),
   ( 2, 0,-1, 1),
   ( 2, 0,-1,-1),
   ( 2, 0, 0, 1),
   ( 0, 0, 2, 1),
   ( 2, 0, 1,-1),
   ( 0, 0, 2,-1),  // !!! Error in German Meeus 
   ( 2,-1, 0,-1),
   ( 2, 0,-2,-1),
   ( 2, 0, 1, 1),
   ( 2, 1, 0,-1),
   ( 2,-1,-1, 1),
   ( 2,-1, 0, 1),
   ( 2,-1,-1,-1),
   ( 0, 1,-1,-1),
   ( 4, 0,-1,-1),
   ( 0, 1, 0, 1),
   ( 0, 0, 0, 3),
   ( 0, 1,-1, 1),
   ( 1, 0, 0, 1),
   ( 0, 1, 1, 1),
   ( 0, 1, 1,-1),
   ( 0, 1, 0,-1),
   ( 1, 0, 0,-1),
   ( 0, 0, 3, 1),
   ( 4, 0, 0,-1),
   ( 4, 0,-1, 1),
   ( 0, 0, 1,-3),
   ( 4, 0,-2, 1),
   ( 2, 0, 0,-3),
   ( 2, 0, 2,-1),
   ( 2,-1, 1,-1),
   ( 2, 0,-2, 1),
   ( 0, 0, 3,-1),
   ( 2, 0, 2, 1),
   ( 2, 0,-3,-1),
   ( 2, 1,-1, 1),
   ( 2, 1, 0, 1),
   ( 4, 0, 0, 1),
   ( 2,-1, 1, 1),
   ( 2,-2, 0,-1),
   ( 0, 0, 1, 3),
   ( 2, 1, 1,-1),
   ( 1, 1, 0,-1),
   ( 1, 1, 0, 1),
   ( 0, 1,-2,-1),
   ( 2, 1,-1,-1),
   ( 1, 0, 1, 1),
   ( 2,-1,-2,-1),
   ( 0, 1, 2, 1),
   ( 4, 0,-2,-1),
   ( 4,-1,-1,-1),
   ( 1, 0, 1,-1),
   ( 4, 0, 1,-1),
   ( 1, 0,-1,-1),
   ( 4,-1, 0,-1),
   ( 2,-2, 0, 1)
  );
sigma_r: array[0..59] of longint = (
 -20905355,
  -3699111,
  -2955968,
   -569925,
     48888,
     -3149,
    246158,
   -152138,
   -170733,
   -204586,
   -129620,
    108743,
    104755,
     10321,
         0,
     79661,
    -34782,
    -23210,
    -21636,
     24208,
     30824,
     -8379,
    -16675,
    -12831,
    -10445,
    -11650,
     14403,
     -7003,
         0,
     10056,
      6322,
     -9884,
      5751,
         0,
     -4950,
      4130,
         0,
     -3958,
         0,
      3258,
      2616,
     -1897,
     -2117,
      2354,
         0,
         0,
     -1423,
     -1117,
     -1571,
     -1739,
         0,
     -4421,
         0,
         0,
         0,
         0,
      1165,
         0,
         0,
      8752
            );
sigma_l: array[0..59] of longint = (
  6288774,
  1274027,
   658314,
   213618,
  -185116,
  -114332,
    58793,
    57066,
    53322,
    45758,
   -40923,
   -34720,
   -30383,
    15327,
   -12528,
    10980,
    10675,
    10034,
     8548,
    -7888,
    -6766,
    -5163,
     4987,
     4036,
     3994,
     3861,
     3665,
    -2689,
    -2602,
     2390,
    -2348,
     2236,
    -2120,
    -2069,
     2048,
    -1773,
    -1595,
     1215,
    -1110,
     -892,
     -810,
      759,
     -713,
     -700,
      691,
      596,
      549,
      537,
      520,
     -487,
     -399,
     -381,
      351,
     -340,
      330,
      327,
     -323,
      299,
      294,
        0
  );
sigma_b: array[0..59] of longint = (
  5128122,
   280602,
   277693,
   173237,
    55413,
    46271,
    32573,
    17198,
     9266,
     8822,
     8216,
     4324,
     4200,
    -3359,
     2463,
     2211,
     2065,
    -1870,
     1828,
    -1794,
    -1749,
    -1565,
    -1491,
    -1475,
    -1410,
    -1344,
    -1335,
     1107,
     1021,
      833,
      777,
      671,
      607,
      596,
      491,
     -451,
      439,
      422,
      421,
     -366,
     -351,
      331,
      315,
      302,
     -283,
     -229,
      223,
      223,
     -220,
     -220,
     -185,
      181,
     -177,
      176,
      166,
     -164,
      132,
     -119,
      115,
      107
  );

var
  t,d,m,ms,f,e,ls : double;
  sr,sl,sb,temp: double;
  a1,a2,a3: double;
  lambda,beta,delta: double;
  i: integer;
begin
  t:=(julian_date(date)-2451545)/36525;

  // mean elongation of the moon
  d:=297.8502042+(445267.1115168+(-0.0016300+(1/545868-1/113065000*t)*t)*t)*t;

  // mean anomaly of the sun
  m:=357.5291092+(35999.0502909+(-0.0001536+1/24490000*t)*t)*t;

  // mean anomaly of the moon
  ms:=134.9634114+(477198.8676313+(0.0089970+(1/69699-1/1471200*t)*t)*t)*t;

  // argument of the longitude of the moon
  f:=93.2720993+(483202.0175273+(-0.0034029+(-1/3526000+1/863310000*t)*t)*t)*t;

  // correction term due to excentricity of the earth orbit 
  e:=1.0+(-0.002516-0.0000074*t)*t;

  // mean longitude of the moon
  ls:=218.3164591+(481267.88134236+(-0.0013268+(1/538841-1/65194000*t)*t)*t)*t;

  // arguments of correction terms 
  a1:=119.75+131.849*t;
  a2:=53.09+479264.290*t;
  a3:=313.45+481266.484*t;


sr:=0;
for i:=0 to 59 do begin
  temp:=sigma_r[i]*cos_d( arg_lr[i,0]*d
                         +arg_lr[i,1]*m
                         +arg_lr[i,2]*ms
                         +arg_lr[i,3]*f);
  if abs(arg_lr[i,1])=1 then temp:=temp*e;
  if abs(arg_lr[i,1])=2 then temp:=temp*e;
  sr:=sr+temp;
  end;

sl:=0;
for i:=0 to 59 do begin
  temp:=sigma_l[i]*sin_d( arg_lr[i,0]*d
                         +arg_lr[i,1]*m
                         +arg_lr[i,2]*ms
                         +arg_lr[i,3]*f);
  if abs(arg_lr[i,1])=1 then temp:=temp*e;
  if abs(arg_lr[i,1])=2 then temp:=temp*e;
  sl:=sl+temp;
  end;

// correction terms 
sl:=sl +3958*sin_d(a1)
       +1962*sin_d(ls-f)
        +318*sin_d(a2);

sb:=0;
for i:=0 to 59 do begin
  temp:=sigma_b[i]*sin_d( arg_b[i,0]*d
                         +arg_b[i,1]*m
                         +arg_b[i,2]*ms
                         +arg_b[i,3]*f);
  if abs(arg_b[i,1])=1 then temp:=temp*e;
  if abs(arg_b[i,1])=2 then temp:=temp*e;
  sb:=sb+temp;
  end;

// correction terms 
sb:=sb -2235*sin_d(ls)
        +382*sin_d(a3)
        +175*sin_d(a1-f)
        +175*sin_d(a1+f)
        +127*sin_d(ls-ms)
        -115*sin_d(ls+ms);

  lambda:=ls+sl/1000000;
  beta:=sb/1000000;
  delta:=385000.56+sr/1000;

  result.radius:=delta;
  result.longitude:=lambda;
  result.latitude:=beta;

  calc_geocentric(result,date);
end;


{ Based upon chapter 39 of Meeus }
procedure correct_position(var position:t_coord; date:TDateTime;
                           latitude,longitude,height:double);
var
  u,h,delta_alpha: double;
  rho_sin, rho_cos: double;
const
  b_a=0.99664719;
begin
  u:=arctan_d(b_a*b_a*tan_d(longitude));
  rho_sin:=b_a*sin_d(u)+height/6378140*sin_d(longitude);
  rho_cos:=cos_d(u)+height/6378140*cos_d(longitude);

  position.parallax:=arcsin_d(sin_d(8.794/3600)/(moon_distance(date)/AU));
  h:=star_time(date)-longitude-position.alpha;
  delta_alpha:=arctan_d(
                (-rho_cos*sin_d(position.parallax)*sin_d(h))/
                (cos_d(position.delta)-
                  rho_cos*sin_d(position.parallax)*cos_d(h)));
  position.alpha:=position.alpha+delta_alpha;
  position.delta:=arctan_d(
      (( sin_d(position.delta)
        -rho_sin*sin_d(position.parallax))*cos_d(delta_alpha))/
      ( cos_d(position.delta)
       -rho_cos*sin_d(position.parallax)*cos_d(h)));
end;


{ Moon phases and age of the moon }
{ Based upon Chapter 47 of Meeus }
{ Both used for moon phases and moon and sun eclipses }
procedure calc_phase_data(date:TDateTime; phase:TMoonPhase; var jde,kk,m,ms,f,o,e: double);
var
  t: double;
  k: longint;
  ts: double;
begin
  k:=round((date-encodedate(2000,1,1))/36525.0*1236.85);
  ts:=(date-encodedate(2000,1,1))/36525.0;
  kk:=int(k)+ord(phase)/4.0;
  t:=kk/1236.85;
  jde:=2451550.09765+29.530588853*kk
       +t*t*(0.0001337-t*(0.000000150-0.00000000073*t));
  m:=2.5534+29.10535669*kk-t*t*(0.0000218+0.00000011*t);
  ms:=201.5643+385.81693528*kk+t*t*(0.1017438+t*(0.00001239-t*0.000000058));
  f:= 160.7108+390.67050274*kk-t*t*(0.0016341+t*(0.00000227-t*0.000000011));
  o:=124.7746-1.56375580*kk+t*t*(0.0020691+t*0.00000215);
  e:=1-ts*(0.002516+ts*0.0000074);
end;


{ Based upon Chapter 47 of Meeus }
function nextphase(date:TDateTime; phase:TMoonPhase):TDateTime;
var
  t: double;
  kk: double;
  jde: double;
  m,ms,f,o,e: double;
  korr,w,akorr: double;
  a:array[1..14] of double;
begin
  calc_phase_data(date,phase,jde,kk,m,ms,f,o,e);
  t:=kk/1236.85;
  case phase of
// Newmoon: 
Newmoon:
begin
  korr:= -0.40720*sin_d(ms)
         +0.17241*e*sin_d(m)
         +0.01608*sin_d(2*ms)
         +0.01039*sin_d(2*f)
         +0.00739*e*sin_d(ms-m)
         -0.00514*e*sin_d(ms+m)
         +0.00208*e*e*sin_d(2*m)
         -0.00111*sin_d(ms-2*f)
         -0.00057*sin_d(ms+2*f)
         +0.00056*e*sin_d(2*ms+m)
         -0.00042*sin_d(3*ms)
         +0.00042*e*sin_d(m+2*f)
         +0.00038*e*sin_d(m-2*f)
         -0.00024*e*sin_d(2*ms-m)
         -0.00017*sin_d(o)
         -0.00007*sin_d(ms+2*m)
         +0.00004*sin_d(2*ms-2*f)
         +0.00004*sin_d(3*m)
         +0.00003*sin_d(ms+m-2*f)
         +0.00003*sin_d(2*ms+2*f)
         -0.00003*sin_d(ms+m+2*f)
         +0.00003*sin_d(ms-m+2*f)
         -0.00002*sin_d(ms-m-2*f)
         -0.00002*sin_d(3*ms+m)
         +0.00002*sin_d(4*ms);
  end;

// FirstQuarter,LastQuarter: 
FirstQuarter,LastQuarter:
begin
  korr:= -0.62801*sin_d(ms)
         +0.17172*e*sin_d(m)
         -0.01183*e*sin_d(ms+m)
         +0.00862*sin_d(2*ms)
         +0.00804*sin_d(2*f)
         +0.00454*e*sin_d(ms-m)
         +0.00204*e*e*sin_d(2*m)
         -0.00180*sin_d(ms-2*f)
         -0.00070*sin_d(ms+2*f)
         -0.00040*sin_d(3*ms)
         -0.00034*e*sin_d(2*ms-m)
         +0.00032*e*sin_d(m+2*f)
         +0.00032*e*sin_d(m-2*f)
         -0.00028*e*e*sin_d(ms+2*m)
         +0.00027*e*sin_d(2*ms+m)
         -0.00017*sin_d(o)
         -0.00005*sin_d(ms-m-2*f)
         +0.00004*sin_d(2*ms+2*f)
         -0.00004*sin_d(ms+m+2*f)
         +0.00004*sin_d(ms-2*m)
         +0.00003*sin_d(ms+m-2*f)
         +0.00003*sin_d(3*m)
         +0.00002*sin_d(2*ms-2*f)
         +0.00002*sin_d(ms-m+2*f)
         -0.00002*sin_d(3*ms+m);
  w:=0.00306-0.00038*e*cos_d(m)
            +0.00026*cos_d(ms)
            -0.00002*cos_d(ms-m)
            +0.00002*cos_d(ms+m)
            +0.00002*cos_d(2*f);
  if phase = FirstQuarter then begin
    korr:=korr+w;
    end
  else begin
    korr:=korr-w;
    end;
  end;

// Fullmoon: 
Fullmoon:
begin
  korr:= -0.40614*sin_d(ms)
         +0.17302*e*sin_d(m)
         +0.01614*sin_d(2*ms)
         +0.01043*sin_d(2*f)
         +0.00734*e*sin_d(ms-m)
         -0.00515*e*sin_d(ms+m)
         +0.00209*e*e*sin_d(2*m)
         -0.00111*sin_d(ms-2*f)
         -0.00057*sin_d(ms+2*f)
         +0.00056*e*sin_d(2*ms+m)
         -0.00042*sin_d(3*ms)
         +0.00042*e*sin_d(m+2*f)
         +0.00038*e*sin_d(m-2*f)
         -0.00024*e*sin_d(2*ms-m)
         -0.00017*sin_d(o)
         -0.00007*sin_d(ms+2*m)
         +0.00004*sin_d(2*ms-2*f)
         +0.00004*sin_d(3*m)
         +0.00003*sin_d(ms+m-2*f)
         +0.00003*sin_d(2*ms+2*f)
         -0.00003*sin_d(ms+m+2*f)
         +0.00003*sin_d(ms-m+2*f)
         -0.00002*sin_d(ms-m-2*f)
         -0.00002*sin_d(3*ms+m)
         +0.00002*sin_d(4*ms);
  end;
else
  korr:=0;   // Delphi 2 shut up!

    end;
// Additional Corrections due to planets 
a[1]:=299.77+0.107408*kk-0.009173*t*t;
a[2]:=251.88+0.016321*kk;
a[3]:=251.83+26.651886*kk;
a[4]:=349.42+36.412478*kk;
a[5]:= 84.66+18.206239*kk;
a[6]:=141.74+53.303771*kk;
a[7]:=207.14+2.453732*kk;
a[8]:=154.84+7.306860*kk;
a[9]:= 34.52+27.261239*kk;
a[10]:=207.19+0.121824*kk;
a[11]:=291.34+1.844379*kk;
a[12]:=161.72+24.198154*kk;
a[13]:=239.56+25.513099*kk;
a[14]:=331.55+3.592518*kk;
akorr:=   +0.000325*sin_d(a[1])
          +0.000165*sin_d(a[2])
          +0.000164*sin_d(a[3])
          +0.000126*sin_d(a[4])
          +0.000110*sin_d(a[5])
          +0.000062*sin_d(a[6])
          +0.000060*sin_d(a[7])
          +0.000056*sin_d(a[8])
          +0.000047*sin_d(a[9])
          +0.000042*sin_d(a[10])
          +0.000040*sin_d(a[11])
          +0.000037*sin_d(a[12])
          +0.000035*sin_d(a[13])
          +0.000023*sin_d(a[14]);
korr:=korr+akorr;

  nextphase:=delphi_date(jde+korr);
  end;


function last_phase(date:TDateTime; phase:TMoonPhase):TDateTime;
var
  temp_date: TDateTime;
begin
  temp_date:=date+28;
  result:=temp_date;
  while result>date do begin
    result:=nextphase(temp_date,phase);
    temp_date:=temp_date-28;
    end;
end;


function next_phase(date:TDateTime; phase:TMoonPhase):TDateTime;
var
  temp_date: TDateTime;
begin
  temp_date:=date-28;
  result:=temp_date;
  while result<date do begin
    result:=nextphase(temp_date,phase);
    temp_date:=temp_date+28;
    end;
end;


{ Based upon Chapter 46 of Meeus }
function moon_phase_angle(date: TDateTime):double;
var
  sun_coord,moon_coord: t_coord;
  phi,i: double;
begin
  sun_coord:=sun_coordinate(date);
  moon_coord:=moon_coordinate(date);
  phi:=arccos(cos_d(moon_coord.latitude)
             *cos_d(moon_coord.longitude-sun_coord.longitude));
  i:=arctan(sun_coord.radius*sin(phi)/
            (moon_coord.radius-sun_coord.radius*cos(phi)));
  if i<0 then  result:=i/pi*180+180
         else  result:=i/pi*180;

  if put_in_360(moon_coord.longitude-sun_coord.longitude)>180 then
    result:=-result;

end;


function age_of_moon(date: TDateTime):double;
var
  sun_coord,moon_coord: t_coord;
begin
  sun_coord:=sun_coordinate(date);
  moon_coord:=moon_coordinate(date);
  result:=put_in_360(moon_coord.longitude-sun_coord.longitude)/360*mean_lunation;
end;


function MoonCurrentPhase(DateTime:TDateTime):Double;
begin
Result:=(1+cos_d(moon_phase_angle(DateTime)))/2;
end;


function lunation(date:TDateTime):integer;
begin
  result:=round((last_phase(date,NewMoon)-delphi_date(2423436))/mean_lunation)+1;
end;


{ The distances }
function sun_distance(date: TDateTime): double;
begin
  result:=sun_coordinate(date).radius/au;
end;


function moon_distance(date: TDateTime): double;
begin
  result:=moon_coordinate(date).radius;
end;


{ The angular diameter (which is 0.5 of the subtent in moontool) }
function sun_diameter(date:TDateTime):double;
begin
  result:=959.63/(sun_coordinate(date).radius/au)*2;
end;


function moon_diameter(date:TDateTime):double;
begin
  result:=358473400/moon_coordinate(date).radius*2;
end;


{ Perigee and Apogee }
function nextXXXgee(date:TDateTime; apo: boolean):TDateTime;
const
arg_apo:array[0..31,0..2] of shortint = (
   { D  F  M }
   ( 2, 0, 0),
   ( 4, 0, 0),
   ( 0, 0, 1),
   ( 2, 0,-1),
   ( 0, 2, 0),
   ( 1, 0, 0),
   ( 6, 0, 0),
   ( 4, 0,-1),
   ( 2, 2, 0),
   ( 1, 0, 1),
   ( 8, 0, 0),
   ( 6, 0,-1),
   ( 2,-2, 0),
   ( 2, 0,-2),
   ( 3, 0, 0),
   ( 4, 2, 0),
   ( 8, 0,-1),
   ( 4, 0,-2),
   (10, 0, 0),
   ( 3, 0, 1),
   ( 0, 0, 2),
   ( 2, 0, 1),
   ( 2, 0, 2),
   ( 6, 2, 0),
   ( 6, 0,-2),
   (10, 0,-1),
   ( 5, 0, 0),
   ( 4,-2, 0),
   ( 0, 2, 1),
   (12, 0, 0),
   ( 2, 2,-1),
   ( 1, 0,-1)
             );
arg_per:array[0..59,0..2] of shortint = (
   { D  F  M }
   ( 2, 0, 0),
   ( 4, 0, 0),
   ( 6, 0, 0),
   ( 8, 0, 0),
   ( 2, 0,-1),
   ( 0, 0, 1),
   (10, 0, 0),
   ( 4, 0,-1),
   ( 6, 0,-1),
   (12, 0, 0),
   ( 1, 0, 0),
   ( 8, 0,-1),
   (14, 0, 0),
   ( 0, 2, 0),
   ( 3, 0, 0),
   (10, 0,-1),
   (16, 0, 0),
   (12, 0,-1),
   ( 5, 0, 0),
   ( 2, 2, 0),
   (18, 0, 0),
   (14, 0,-1),
   ( 7, 0, 0),
   ( 2, 1, 0),
   (20, 0, 0),
   ( 1, 0, 1),
   (16, 0,-1),
   ( 4, 0, 1),
   ( 2, 0,-2),
   ( 4, 0,-2),
   ( 6, 0,-2),
   (22, 0, 0),
   (18, 0,-1),
   ( 6, 0, 1),
   (11, 0, 0),
   ( 8, 0, 1),
   ( 4,-2, 0),
   ( 6, 2, 0),
   ( 3, 0, 1),
   ( 5, 0, 1),
   (13, 0, 0),
   (20, 0,-1),
   ( 3, 0, 2),
   ( 4, 2,-2),
   ( 1, 0, 2),
   (22, 0,-1),
   ( 0, 4, 0),
   ( 6,-2, 0),
   ( 2,-2, 1),
   ( 0, 0, 2),
   ( 0, 2,-1),
   ( 2, 4, 0),
   ( 0, 2,-2),
   ( 2,-2, 2),
   (24, 0, 0),
   ( 4,-4, 0),
   ( 9, 0, 0),
   ( 4, 2, 0),
   ( 2, 0, 2),
   ( 1, 0,-1)
             );
koe_apo:array[0..31,0..1] of longint = (
   {    1   T }
   ( 4392,  0),
   (  684,  0),
   (  456,-11),
   (  426,-11),
   (  212,  0),
   ( -189,  0),
   (  144,  0),
   (  113,  0),
   (   47,  0),
   (   36,  0),
   (   35,  0),
   (   34,  0),
   (  -34,  0),
   (   22,  0),
   (  -17,  0),
   (   13,  0),
   (   11,  0),
   (   10,  0),
   (    9,  0),
   (    7,  0),
   (    6,  0),
   (    5,  0),
   (    5,  0),
   (    4,  0),
   (    4,  0),
   (    4,  0),
   (   -4,  0),
   (   -4,  0),
   (    3,  0),
   (    3,  0),
   (    3,  0),
   (   -3,  0)
               );
koe_per:array[0..59,0..1] of longint = (
   {     1   T }
   (-16769,  0),
   (  4589,  0),
   ( -1856,  0),
   (   883,  0),
   (  -773, 19),
   (   502,-13),
   (  -460,  0),
   (   422,-11),
   (  -256,  0),
   (   253,  0),
   (   237,  0),
   (   162,  0),
   (  -145,  0),
   (   129,  0),
   (  -112,  0),
   (  -104,  0),
   (    86,  0),
   (    69,  0),
   (    66,  0),
   (   -53,  0),
   (   -52,  0),
   (   -46,  0),
   (   -41,  0),
   (    40,  0),
   (    32,  0),
   (   -32,  0),
   (    31,  0),
   (   -29,  0),
   (   -27,  0),
   (    24,  0),
   (   -21,  0),
   (   -21,  0),
   (   -21,  0),
   (    19,  0),
   (   -18,  0),
   (   -14,  0),
   (   -14,  0),
   (   -14,  0),
   (    14,  0),
   (   -14,  0),
   (    13,  0),
   (    13,  0),
   (    11,  0),
   (   -11,  0),
   (   -10,  0),
   (    -9,  0),
   (    -8,  0),
   (     8,  0),
   (     8,  0),
   (     7,  0),
   (     7,  0),
   (     7,  0),
   (    -6,  0),
   (    -6,  0),
   (     6,  0),
   (     5,  0),
   (    27,  0),
   (    27,  0),
   (     5,  0),
   (    -4,  0)
               );
var
  k, jde, t: double;
  d,m,f,v: double;
  i: integer;
begin
  k:=round(((date-encodedate(1999,1,1))/365.25-0.97)*13.2555);
  if apo then k:=k+0.5;
  t:=k/1325.55;
  jde:=2451534.6698+27.55454988*k+(-0.0006886+
       (-0.000001098+0.0000000052*t)*t)*t*t;
  d:=171.9179+335.9106046*k+(-0.0100250+(-0.00001156+0.000000055*t)*t)*t*t;
  m:=347.3477+27.1577721*k+(-0.0008323-0.0000010*t)*t*t;
  f:=316.6109+364.5287911*k+(-0.0125131-0.0000148*t)*t*t;
  v:=0;
  if apo then
    for i:=0 to 31 do
      v:=v+sin_d(arg_apo[i,0]*d+arg_apo[i,1]*f+arg_apo[i,2]*m)*
         (koe_apo[i,0]*0.0001+koe_apo[i,1]*0.00001*t)
  else
    for i:=0 to 59 do
      v:=v+sin_d(arg_per[i,0]*d+arg_per[i,1]*f+arg_per[i,2]*m)*
         (koe_per[i,0]*0.0001+koe_per[i,1]*0.00001*t);
  result:=delphi_date(jde+v);
end;


function nextperigee(date:TDateTime):TDateTime;
var
  temp_date: TDateTime;
begin
  temp_date:=date-28;
  result:=temp_date;
  while result<date do begin
    result:=nextXXXgee(temp_date,false);
    temp_date:=temp_date+28;
    end;
  end;


function nextapogee(date:TDateTime):TDateTime;
var
  temp_date: TDateTime;
begin
  temp_date:=date-28;
  result:=temp_date;
  while result<date do begin
    result:=nextXXXgee(temp_date,true);
    temp_date:=temp_date+28;
    end;
  end;


{ The seasons }
{ Based upon chapter 26 of Meeus }
function StartSeason(year: integer; season:TSeason):TDateTime;
var
  y: double;
  jde0: double;
  t, w, dl, s: double;
  i: integer;
const
a: array[0..23] of integer = (
  485, 203, 199, 182, 156, 136, 77, 74, 70, 58, 52, 50,
  45, 44, 29, 18, 17, 16, 14, 12, 12, 12, 9, 8 );
bc:array[0..23,1..2] of double = (
   ( 324.96,   1934.136 ),
   ( 337.23,  32964.467 ),
   ( 342.08,     20.186 ),
   (  27.85, 445267.112 ),
   (  73.14,  45036.886 ),
   ( 171.52,  22518.443 ),
   ( 222.54,  65928.934 ),
   ( 296.72,   3034.906 ),
   ( 243.58,   9037.513 ),
   ( 119.81,  33718.147 ),
   ( 297.17,    150.678 ),
   (  21.02,   2281.226 ),
   ( 247.54,  29929.562 ),
   ( 325.15,  31555.956 ),
   (  60.93,   4443.417 ),
   ( 155.12,  67555.328 ),
   ( 288.79,   4562.452 ),
   ( 198.04,  62894.029 ),
   ( 199.76,  31436.921 ),
   (  95.39,  14577.848 ),
   ( 287.11,  31931.756 ),
   ( 320.81,  34777.259 ),
   ( 227.73,   1222.114 ),
   (  15.45,  16859.074 )
                           );

begin
  case year of
-1000..+999: begin
  y:=year/1000;
  case season of
    spring: jde0:=1721139.29189+(365242.13740+( 0.06134+( 0.00111-0.00071*y)*y)*y)*y;
    summer: jde0:=1721223.25401+(365241.72562+(-0.05323+( 0.00907+0.00025*y)*y)*y)*y;
    autumn: jde0:=1721325.70455+(365242.49558+(-0.11677+(-0.00297+0.00074*y)*y)*y)*y;
    winter: jde0:=1721414.39987+(365242.88257+(-0.00769+(-0.00933-0.00006*y)*y)*y)*y;
    else    jde0:=0;   // this can't happen
    end;
  end;
+1000..+3000: begin
  y:=(year-2000)/1000;
  case season of
    spring: jde0:=2451623.80984+(365242.37404+( 0.05169+(-0.00411-0.00057*y)*y)*y)*y;
    summer: jde0:=2451716.56767+(365241.62603+( 0.00325+( 0.00888-0.00030*y)*y)*y)*y;
    autumn: jde0:=2451810.21715+(365242.01767+(-0.11575+( 0.00337+0.00078*y)*y)*y)*y;
    winter: jde0:=2451900.05952+(365242.74049+(-0.06223+(-0.00823+0.00032*y)*y)*y)*y;
    else    jde0:=0;   // this can't happen 
    end;
  end;
    else raise E_OutOfAlgorithRange.Create(lang('En dehors du domaine de validité de l''algorithme')); //'Out of range of the algorithm'
    end;
  t:=(jde0-2451545.0)/36525;
  w:=35999.373*t-2.47;
  dl:=1+0.0334*cos_d(w)+0.0007*cos_d(2*w);

s:=0;
for i:=0 to 23 do
  s:=s+a[i]*cos_d(bc[i,1]+bc[i,2]*t);

  result:=delphi_date(jde0+(0.00001*s)/dl);
end;


{ Rising and setting of moon and sun }
{ Based upon chapter 14 of Meeus }


{ Checking for eclipses }
function Eclipse(var date:TDateTime; sun:boolean):TEclipse;
var
  jde,kk,m,ms,f,o,e: double;
  t,f1,a1: double;
  p,q,w,gamma,u: double;
begin
  if sun then
    calc_phase_data(date,NewMoon,jde,kk,m,ms,f,o,e)
  else
    calc_phase_data(date,FullMoon,jde,kk,m,ms,f,o,e);
  t:=kk/1236.85;
  if abs(sin_d(f))>0.36 then
    result:=none

else begin
  f1:=f-0.02665*sin_d(o);
  a1:=299.77+0.107408*kk-0.009173*t*t;
  if sun then
    jde:=jde - 0.4075     * sin_d(ms)
             + 0.1721 * e * sin_d(m)
  else
    jde:=jde - 0.4065     * sin_d(ms)
             + 0.1727 * e * sin_d(m);
  jde:=jde   + 0.0161     * sin_d(2*ms)
             - 0.0097     * sin_d(2*f1)
             + 0.0073 * e * sin_d(ms-m)
             - 0.0050 * e * sin_d(ms+m)
             - 0.0023     * sin_d(ms-2*f1)
             + 0.0021 * e * sin_d(2*m)
             + 0.0012     * sin_d(ms+2*f1)
             + 0.0006 * e * sin_d(2*ms+m)
             - 0.0004     * sin_d(3*ms)
             - 0.0003 * e * sin_d(m+2*f1)
             + 0.0003     * sin_d(a1)
             - 0.0002 * e * sin_d(m-2*f1)
             - 0.0002 * e * sin_d(2*ms-m)
             - 0.0002     * sin_d(o);
  p:=        + 0.2070 * e * sin_d(m)
             + 0.0024 * e * sin_d(2*m)
             - 0.0392     * sin_d(ms)
             + 0.0116     * sin_d(2*ms)
             - 0.0073 * e * sin_d(ms+m)
             + 0.0067 * e * sin_d(ms-m)
             + 0.0118     * sin_d(2*f1);
  q:=        + 5.2207
             - 0.0048 * e * cos_d(m)
             + 0.0020 * e * cos_d(2*m)
             - 0.3299     * cos_d(ms)
             - 0.0060 * e * cos_d(ms+m)
             + 0.0041 * e * cos_d(ms-m);
  w:=abs(cos_d(f1));
  gamma:=(p*cos_d(f1)+q*sin_d(f1))*(1-0.0048*w);
  u:= + 0.0059
      + 0.0046 * e * cos_d(m)
      - 0.0182     * cos_d(ms)
      + 0.0004     * cos_d(2*ms)
      - 0.0005     * cos_d(m+ms);

if sun then begin
  if abs(gamma)<0.9972 then begin
    if u<0 then
      result:=total
    else if u>0.0047 then
      result:=circular
    else if u<0.00464*sqrt(1-gamma*gamma) then
      result:=circulartotal
    else
      result:=circular;
    end
  else if abs(gamma)>1.5433+u then
    result:=none
  else if abs(gamma)<0.9972+abs(u) then
    result:=noncentral
  else
    result:=partial;
  end
else begin
  if (1.0128 - u - abs(gamma)) / 0.5450 > 0 then
    result:=total
  else if (1.5573 + u - abs(gamma)) / 0.5450 > 0 then
    result:=halfshadow
  else
    result:=none;
  end;

  end;

  date:=delphi_date(jde);
end;

function NextEclipse(var date:TDateTime; sun:boolean):TEclipse;
var
  temp_date: TDateTime;
begin
  result:=none;    // just to make Delphi 2/3 shut up, not needed really 
  temp_date:=date-28*2;
  while temp_date<date do begin
    temp_date:=temp_date+28;
    result:=Eclipse(temp_date,sun);
    end;
  date:=temp_date;
end;


{-------------------------------------------------------------------------------

                                 ASTEROIDES

-------------------------------------------------------------------------------}



Procedure SolRect(t0 : double ; astrometric : boolean; var x,y,z : double;var ierr :integer);
// coordonnees rectangulaires ecliptiques du soleil
var p :TPlanetData;
    tjd : double;
    i : integer;
begin
    if t0=SolT0 then
    begin
       x:=XSol;
       y:=YSol;
       z:=ZSol;
    end
    else
    begin
        if astrometric then tjd:=t0-tlight
                       else tjd:=t0;
        p.ipla:=3;
        p.JD:=tjd;
        ierr:=Plan404(addr(p));
        if (ierr<>0) then exit;
        x:=-p.x; y:=-p.y; z:=-p.z;
        SolT0:=t0;
        XSol:=x;
        YSol:=y;
        ZSol:=z;
    end;
end;

Procedure RectToPol(x,y : double; var r,alpha : double);
begin
    r:=sqrt(x*x+y*y);
    alpha:=radtodeg(arctan2(y,x));
end;


Procedure PrecessElem(annee : integer; var i,oomi,oma : double);
// passe a une autre epoch
var t,tau0,tau,eta,theta,theta0,i0,oma0,x,y,r,alpha,cosi : double;
const final = 2000.0;
begin
    tau0:=(annee-1900)/1000;    { meeus 17. }
    tau:=(final-1900)/1000;
    t := tau-tau0;
    eta := ((471.07-6.75*tau0+0.57*tau0*tau0)*t+(-3.37+0.57*tau0)*t*t+0.05*t*t*t)/3600;
    theta0:=173.950833+(32869*tau0+56*tau0*tau0-(8694+55*tau0)*t+3*t*t)/3600;
    theta:=theta0+((50256.41+222.29*tau0+0.26*tau0*tau0)*t+(111.15+0.26*tau0)*t*t+0.1*t*t*t)/3600;
    i0:=degtorad(i); oma0:=degtorad(oma);
    eta:=degtorad(eta); theta:=degtorad(theta); theta0:=degtorad(theta0);
    cosi:=cos(i0)*cos(eta)+sin(i0)*sin(eta)*cos(oma0-theta0);
    y:=sin(i0)*sin(oma0-theta0);        { meeus 17.2 }
    x:=-sin(eta)*cos(i0)+cos(eta)*sin(i0)*cos(oma0-theta0);
    RectToPol(x,y,r,alpha);
    i:=radtodeg(arcsin(r));
    if cosi<0 then i:=180-i ;
    oma:=alpha+radtodeg(theta);
    y:=-sin(eta)*sin(oma0-theta0);      { meeus 17.3 }
    x:=sin(i0)*cos(eta)-cos(i0)*sin(eta)*cos(oma0-theta0);
    RectToPol(x,y,r,alpha);
    oomi:=oomi+alpha;
end;

PROCEDURE InitAsteroid(elem : t_ast_elem );
// initialise les elements osculateurs
// a appeler avant asteroid()
VAR
   i,Oma,ff,g,h,p,qq,r,ooe : Double;
BEGIN
    AsterName:=elem.name;
    Annee:=2000 ;

    At:=jd(strtoint(copy(elem.osc_epoch,1,4)),strtoint(copy(elem.osc_epoch,5,2)),
           strtoint(copy(elem.osc_epoch,7,2)),0) ;

    Am:=elem.mean_anomaly ;
    Oomi:=elem.arg_peri ;
    Oma:=elem.lon_asc_node ;
    i:=elem.inclination  ;
    Oe:=elem.eccentricity ;
    Aa:=elem.sm_axis ;
    Ah:=elem.mag_H ;
    Ag:=elem.slope_G ;

    if Annee<>2000 then PrecessElem(Annee,i,oomi,oma);
    Oepoque:=jd(Annee,1,1,0);
    ooe := 23.43929111; {j2000 meeus91 32.7}
    ff:= cos(degtorad(Oma));  { meus 25.13 }
    g := sin(degtorad(Oma)) * cos(degtorad(ooe));
    h := sin(degtorad(Oma)) * sin(degtorad(ooe));
    p := -sin(degtorad(Oma)) * cos(degtorad(i));
    qq:= cos(degtorad(Oma))*cos(degtorad(i))*cos(degtorad(ooe))-sin(degtorad(i))*sin(degtorad(ooe));
    r := cos(degtorad(Oma))*cos(degtorad(i))*sin(degtorad(ooe))+sin(degtorad(i))*cos(degtorad(ooe));
    Oaa := radtodeg(arctan2(ff,p)) ;
    Obb := radtodeg(arctan2(g,qq));
    Occ := radtodeg(arctan2(h,r)) ;
    Oa := sqrt(ff*ff+p*p);
    Ob := sqrt(g*g+qq*qq);
    Oc := sqrt(h*h+r*r) ;
END  ;

PROCEDURE Kepler(VAR E1:Double; e,m:Double);
 VAR e0,c:Double;
 BEGIN
{ meeus  22.3 }
    e0:=radtodeg(e);
    E1:=m;
    REPEAT
      c := (m+e0*sin(degtorad(E1)) - E1) / (1.0 - e*cos(degtorad(E1))) ;
      E1:= E1 + c ;
    UNTIL ABS(c) < 1.0E-9 ;
 END ;

PROCEDURE Asteroid(VAR astcoord : t_ast_ephem);
// position d un asteroide methode de kepler
VAR xc,yc,zc,xs,ys,zs,rr,phi1,phi2 :Double;
    nu,da,n0,m,ex,num1,den :Double ;
    ierr : integer;
    Procedure AstGeom ;
    begin
        with astcoord do begin
        m:=rmod(am+n0*(jday-At),360);
        Kepler(ex,Oe,m) ;
        num1:=sqrt(1.0+Oe)*tan(degtorad(ex)/2.0);  { meeus 25.1 }
        den:=sqrt(1.0-Oe);
        nu:=2.0*radtodeg(arctan2(num1,den));
        d_helio:=da*(1.0-Oe*cos(degtorad(ex)));   { meeus 25.2 }
        xc:=d_helio*Oa*sin(degtorad((Oaa+Oomi+nu))); { meeus 25.14 }
        yc:=d_helio*Ob*sin(degtorad((Obb+Oomi+nu)));
        zc:=d_helio*Oc*sin(degtorad((Occ+Oomi+nu)));
        d_geo:=sqrt((xc+xs)*(xc+xs)+(yc+ys)*(ys+yc)+(zc+zs)*(zc+zs));
        end;
    end;

    BEGIN
        with astcoord do begin
        da:=Aa ;                     { meeus 25.12 }
        n0:=0.9856076686/(da*sqrt(da));
        SolRect(jday,false,xs,ys,zs,ierr);
        AstGeom;
        jday:=jday-d_geo*tlight;
        AstGeom;
        alpha:=radtodeg(arctan2((ys+yc),(xs+xc))) ;   { meeus 25.15 }
        alpha:=Rmod(alpha+360.0,360.0)/15;
        delta:=radtodeg(arcsin((zc+zs)/d_geo));
        rr:=sqrt(xs*xs+ys*ys+zs*zs);
        elong:=radtodeg(arccos((rr*rr+d_geo*d_geo-d_helio*d_helio)/(2.0*rr*d_geo)));
        phase:=(arccos((d_helio*d_helio+d_geo*d_geo-rr*rr)/(2.0*d_helio*d_geo)));
        phi1:=exp(-3.33*power(tan(phase/2),0.63));  { meeus91 32.14 }
        phi2:=exp(-1.87*power(tan(phase/2),1.22));
        magn:=Ah+5.0*log10(d_geo*d_helio)-2.5*log10((1-Ag)*phi1+Ag*phi2);
        phase:=radtodeg(phase);
    end;
end;


procedure Parallaxe(tsl:double; coord:T_ast_ephem);
// corrige de la parallaxe
// la longitude de l observateur est celle par defaut
var
   sinpi,dar,H,rde,a,b,c,q,rho_sin_phi,rho_cos_phi : double;
const
     desinpi = 4.26345151e-5;
begin
    H:=degtorad(15*(tsl-coord.alpha));
    rde:=degtorad(coord.delta);
    sinpi:=desinpi/coord.d_geo;
    correct_phi(0,config.long,rho_sin_phi,rho_cos_phi);
    dar:=arctan2(-rho_cos_phi*sinpi*sin(H),(cos(rde)-rho_cos_phi*sinpi*cos(H)));
    coord.alpha :=coord.alpha+radtodeg(dar)/15;
    coord.delta :=arctan2((sin(rde)-rho_sin_phi*sinpi)*cos(dar),cos(rde)-rho_cos_phi*sinpi*cos(H));
    coord.delta :=radtodeg(coord.delta);
    a := cos(rde)*sin(H);
    b := cos(rde)*cos(H)-rho_sin_phi*sinpi;
    c := sin(rde)-rho_sin_phi*sinpi;
    q := sqrt(a*a+b*b+c*c);
end;


function get_asteroid_position_from_file(p:p_target):boolean;
// calcule la position d un asteroide depuis un fichier tea
var
ta:t_ast_ephem;
te:t_ast_elem;
pa:p_critlist;
dttm:tdatetime;z:integer;
tmp:string;
begin
     new(pa);
     tmp:=p.obj_name;
  {   z:=pos(lang('Asteroide '),tmp);
     if z=0 then
     begin
          result:=false;
          exit;
     end;
     delete(tmp,1,10);
     z:=pos(' ',tmp);

     if z=0 then pa.nom:=trim(tmp) else pa.nom:=trim(copy(tmp,1,z));}

     pa.nom:=tmp;

     if read_asteroid_file(pa) then
     begin
         result:=true;
         te.name:=pa.nom;
         te.osc_epoch:=copy(pa.date,1,4)+copy(pa.date,6,2)+copy(pa.date,9,2);
         te.mean_anomaly:=mystrtofloat(pa.m);
         te.arg_peri:=mystrtofloat(pa.peri);
         te.lon_asc_node:=mystrtofloat(pa.node);
         te.inclination:=mystrtofloat(pa.incl);
         te.eccentricity:=mystrtofloat(pa.e);
         te.sm_axis:=mystrtofloat(pa.a);
         te.mag_H:=mystrtofloat(pa.h);
         te.slope_G:=mystrtofloat(pa.G);
         dispose(pa);

        InitAsteroid(te);

        ta.jday:=heuretojourjulien(GetHourDT);
        Asteroid(ta);
        dttm:=jourjulientoheure(ta.jday);
        parallaxe(dttm,ta);

        p.obj_ra:=ta.alpha;
        p.obj_dec:=ta.delta;
        // on rescuscite : les elements orbitaux sont la
        if p.status=72 then p.status:=1;
     end
     else
     begin
          result:=false;
     end;
end;

procedure get_asteroid_position_from_db(p:t_ast_elem; jd,tsl:double; var ta:t_ast_ephem );
// calcule la position d un asteroide depuis un fichier tea
begin
        InitAsteroid(p);
        ta.jday:=jd;
        Asteroid(ta);
        parallaxe(tsl,ta);
end;

function elliptic_orbit_velocity_i(distance,sm_axis:double):double;
// distance au soleil, et demi grand axe en UA, sortie en km/s   Meeus p223
begin
     result:=42.1219*(sqrt((1/distance)-(1/(2*sm_axis))));
end;

function elliptic_orbit_velocity_aphelion(ecc,sm_axis:double):double;
// eccentricite  et demi grand axe, sortie en km/s            Meeus p223
begin
     result:=(29.7847/sqrt(sm_axis)) / sqrt((1-ecc)/(1+ecc));
end;

function elliptic_orbit_velocity_perihelion(ecc,sm_axis:double):double;
// eccentricite  et demi grand axe, sortie en km/s            Meeus p223
begin
     result:=(29.7847/sqrt(sm_axis)) / sqrt((1+ecc)/(1-ecc));
end;

function aphelion(ecc,sm_axis:double):double;
// Q  = a*(1+e) = aphelion distance
begin
     result:=sm_axis*(1+ecc);
end;

function perihelion(ecc,sm_axis:double):double;
// Q  = a*(1+e) = aphelion distance
begin
     result:=sm_axis*(1-ecc);
end;

function get_asteroid_family(ecc,sm_axis,inclination,aphelion,perihelion:double):string;
begin
     if (aphelion < 0.4) then result:='Vulcanoid'; //nolang
     if (aphelion > 0.4) and (aphelion < 1) then result:='Apohele'; //nolang
     if (sm_axis < 1) and (aphelion>0.983) then result:='Aten'; //nolang
     if (sm_axis > 1) and (perihelion > 1.017) and (perihelion < 1.3) then result:='Amor'; //nolang
     if (sm_axis > 1) and (perihelion < 1.017) then result:='Apollo'; //nolang
     if (perihelion<1.52) and (aphelion >1.52) then result:='Mars-crosser'; //nolang
     if (sm_axis >1.78) and (sm_axis < 2) and (ecc < 0.18) and (inclination > 16) and (inclination < 34) then result:='Hungaria'; //nolang
     if (sm_axis >2.25) and (sm_axis < 2.5) and (ecc > 0.1) and (inclination > 18) and (inclination < 32) then result:='Phocea'; //nolang
     if (sm_axis >2.1) and (sm_axis < 2.3) and (inclination < 11) then result:='Flora'; //nolang
     if (sm_axis >2.41) and (sm_axis < 2.5) and (ecc > 0.12) and (ecc < 0.21) and (inclination > 1.5) and (inclination < 4.3) then result:='Nysa'; //nolang
     IF (sm_axis > 2.3) and (sm_axis < 2.5) and (inclination < 18) then result:='Main Belt I'; //nolang
     if (sm_axis > 2.49) and (sm_axis < 2.51) and (ecc > 0.4) and (ecc < 0.65) then result:='Alinda'; //nolang
     if (sm_axis > 2.5) and (sm_axis < 2.82) and (inclination>33) and (inclination < 38) then result:='Pallas'; //nolang
     if (sm_axis > 2.5) and (sm_axis < 2.706) and (inclination >12) and (inclination < 17) then result:='Maria'; //nolang
     if (sm_axis > 2.5) and (sm_axis < 2.706) and (inclination < 33) then result:='Main Belt II'; //nolang
     if (sm_axis > 2.706) and (sm_axis < 2.82) and (inclination < 33) then result:='Main Belt IIb'; //nolang
     if (sm_axis > 2.83) and (sm_axis < 2.91) and (ecc<=0.11) and (inclination < 3.5) then result:='Koronis'; //nolang
     if (sm_axis > 2.99) and (sm_axis < 3.03) and (ecc > 0.01) and (ecc < 0.13) and (inclination >8) and (inclination < 12) then result:='Eos'; //nolang
     if (sm_axis > 2.82) and (sm_axis < 3.03) and (ecc < 0.35) and (inclination < 30) then result:='Main belt IIIa'; //nolang
     if (sm_axis > 3.08) and (sm_axis < 3.24) and (ecc > 0.09) and (ecc < 0.22) and (inclination < 3) then result:='Themis'; //nolang
     if (sm_axis > 3.1) and (sm_axis < 3.27) and (ecc > 0.35) then result:='Gricqua'; //nolang
     if (sm_axis > 3.03) and (sm_axis < 3.27) and (ecc<0.35) and (inclination < 30) then result:='Main belt IIIb'; //nolang
     if (sm_axis > 3.27) and (sm_axis < 3.7) and (ecc < 0.3) and (inclination <25) then result:='Cybele'; //nolang
     if (sm_axis > 3.7) and (sm_axis < 4.2) and (ecc < 0.03) and (inclination < 20) then result:='Hilda'; //nolang
     if (sm_axis > 5.05) and (sm_axis < 5.4) then result:='Jupiter Trojan'; //nolang
     if (sm_axis > 5.4) and (sm_axis < 30) and (ecc > 0.1) and (ecc < 0.67) and (inclination <25) then result:='Centaur'; //nolang
     if sm_axis > 30 then result:='Trans-Neptunian (KBO)'; //nolang
end;

function mag_to_radial_velocity(m_limit,m_abs:double):double;
// read function name
var
a,b,c:double;
begin
     // Mabs = MLimite+5+5(log(parallaxe))
     a:=(m_abs-m_limit-5)/5;
     b:=log10(a);
     c:=power(10,a);
     result:=(1/c);
end;

procedure vaisala(JD1,RA1,DE1,JD2,RA2,DE2,JD3,rho:double; var ra,dec,a_moins_r2:double; var elem:Telements);

{ ra et dec 1/2 sont passes en heures et degres
  jd1, jd2 : dates des 2 observations
  jd3 est la date pour laquelle on veut la position
  rho est la distance estimee lors de l observation
  retour :
  a_mois_r2 doit etre entre 0 et 0.5
  ra et dec de l asteroide pour JD3
  elem:elements osculateurs}

var
un,deux,trois:array[0..43] of double;
inter:array[0..19] of double;
toto,la_node,omega,mu,m,a,e,i,tmp1:double;
begin
	{RA en radians}
	un[0]:=degtorad(ra1)*180/12;
	deux[0]:=degtorad(ra2)*180/12;
	trois[0]:=0;
	{dec en degtorad}
	un[1]:=degtorad(de1);
	deux[1]:=degtorad(de2);
	trois[1]:=0;
	{JD}
	un[2]:=jd1;
	deux[2]:=jd2;
	trois[2]:=jd3;
	{m_earth}
	un[3]:=((360/365.242191)*((jd1-2447891.5)/1.00004))+99.403308-102.768413;
        deux[3]:=((360/365.242191)*((jd2-2447891.5)/1.00004))+99.403308-102.768413;
        trois[3]:=((360/365.242191)*((jd3-2447891.5)/1.00004))+99.403308-102.768413;
	{nu_earth}
	un[4]:=un[3]+((360/PI)*0.016713*SIN(degtorad(un[3])));
        deux[4]:=deux[3]+((360/PI)*0.016713*SIN(degtorad(deux[3])));
        trois[4]:=trois[3]+((360/PI)*0.016713*SIN(degtorad(trois[3])));
	{I_Earth}
	un[5]:=un[4]+102.768413;
	deux[5]:=deux[4]+102.768413;
	trois[5]:=trois[4]+102.768413;
	{r_earth}
	un[6]:=1*(1-0.016713*0.016713)/(1+0.016713*COS(degtorad(un[4])));
        deux[6]:=1*(1-0.016713*0.016713)/(1+0.016713*COS(degtorad(deux[4])));
        trois[6]:=1*(1-0.016713*0.016713)/(1+0.016713*COS(degtorad(trois[4])));
	{xe_earth}
	un[7]:=-1*un[6]*COS(degtorad(un[5]));
	deux[7]:=-1*deux[6]*COS(degtorad(deux[5]));
	trois[7]:=-1*trois[6]*COS(degtorad(trois[5]));
	{ye_earth}
	un[8]:=-1*un[6]*SIN(degtorad(un[5]));
	deux[8]:=-1*deux[6]*SIN(degtorad(deux[5]));
	trois[8]:=-1*trois[6]*SIN(degtorad(trois[5]));
	{ze_earth}
	un[9]:=0;
	deux[9]:=0;
	trois[9]:=0;
	{x_earth}
	un[10]:=un[7];
	deux[10]:=deux[7];
	trois[10]:=trois[7];
	{Y_earth}
	un[11]:=un[8]*COS(degtorad(23.441893))-un[9]*SIN(degtorad(23.441893));
        deux[11]:=deux[8]*COS(degtorad(23.441893))-deux[9]*SIN(degtorad(23.441893));
        trois[11]:=trois[8]*COS(degtorad(23.441893))-trois[9]*SIN(degtorad(23.441893));
	{Z earth}
	un[12]:=un[8]*SIN(degtorad(23.441893))+un[9]*COS(degtorad(23.441893));
        deux[12]:=deux[8]*SIN(degtorad(23.441893))+deux[9]*COS(degtorad(23.441893));
        trois[12]:=trois[8]*SIN(degtorad(23.441893))+trois[9]*COS(degtorad(23.441893));
	{tau}
	un[13]:=0.017202*(un[2]-deux[2]);
	deux[13]:=0;
	trois[13]:=0.017202*(trois[2]-deux[2]);
	{tau carre}
	un[14]:=sqr(un[13]);
	deux[14]:=0;
	trois[14]:=sqr(trois[13]);
	{tau cube}
	un[15]:=un[13]*un[13]*un[13];
	deux[15]:=deux[13]*deux[13]*deux[13];
	trois[15]:=trois[13]*trois[13]*trois[13];
        // ok

	{delta 2}
	deux[18]:=rho*cos(deux[1]);
	trois[18]:=0;
	{x}
	un[19]:=0;
	deux[19]:=(deux[18]*(COS(deux[0])))-deux[10];
	trois[19]:=0;
	{y}
	un[20]:=0;
	deux[20]:=(deux[18]*(SIN(deux[0])))-deux[11];
	trois[20]:=0;
	{z}
	un[21]:=0;
	deux[21]:=(deux[18]*(TAN(deux[1])))-deux[12];
	trois[21]:=0;
	{r carre}
	un[22]:=0;
	deux[22]:=sqr(deux[19])+sqr(deux[20])+sqr(deux[21]);
	trois[22]:=0;
	{r}
	un[23]:=0;
	deux[23]:=sqrt(deux[22]);
	trois[23]:=0;
	{A}
	inter[0]:=0.5/(deux[23]*deux[23]*deux[23]);
	{B}
	inter[1]:=inter[0]/3;
	{F_1}
	inter[2]:=1-inter[0]*un[14];
	{G_1}
	inter[3]:=un[13]-inter[1]*un[15];
	{delta 1}
        un[18]:=((inter[2]*deux[22])+(un[10]*deux[19])+(un[11]*deux[20])+(un[12]*deux[21]))/
        ((deux[19]*(COS(un[0])))+(deux[20]*(SIN(un[0])))+(deux[21]*(TAN(un[1]))));
	{x prime}
	un[24]:=0;
	deux[24]:=(un[18]*COS(un[0])-inter[2]*deux[19]-un[10])/inter[3];
	trois[24]:=0;

	{y prime}
	un[25]:=0;
	deux[25]:=(un[18]*SIN(un[0])-inter[2]*deux[20]-un[11])/inter[3];
	trois[25]:=0;

	{z prime}
	un[26]:=0;
	deux[26]:=(un[18]*TAN(un[1])-inter[2]*deux[21]-un[12])/inter[3];
	trois[26]:=0;
	{ F }
	un[16]:=1-inter[0]*un[14];
	deux[16]:=1-inter[0]*deux[14];
	trois[16]:=1-inter[0]*trois[14];
	{ G }
	un[17]:=un[13]-inter[1]*un[15];
	deux[17]:=deux[13]-inter[1]*deux[15];
	trois[17]:=trois[13]-inter[1]*trois[15];
	{cos d cos a}
	un[27]:=un[16]*deux[19]+un[17]*deux[24]+un[10];
	deux[27]:=deux[16]*deux[19]+deux[17]*deux[24]+deux[10];
	trois[27]:=trois[16]*deux[19]+trois[17]*deux[24]+trois[10];
	{cos d sin a}
	un[28]:=un[16]*deux[20]+un[17]*deux[25]+un[11];
	deux[28]:=deux[16]*deux[20]+deux[17]*deux[25]+deux[11];
	trois[28]:=trois[16]*deux[20]+trois[17]*deux[25]+trois[11];
	{sin d}
	un[29]:=un[16]*deux[21]+un[17]*deux[26]+un[12];
	deux[29]:=deux[16]*deux[21]+deux[17]*deux[26]+deux[12];
	trois[29]:=trois[16]*deux[21]+trois[17]*deux[26]+trois[12];

	{RA and DEC}
	{RA-hours}
	un[31]:=INT((12/PI)*Arctan(un[28]/un[27]));
	deux[31]:=INT((12/PI)*Arctan(deux[28]/deux[27]));
	trois[31]:=INT((12/PI)*Arctan(trois[28]/trois[27]));
	{RA-min}
	un[32]:=INT(60*((12/PI)*Arctan(un[28]/un[27])-INT(un[31])));
	deux[32]:=INT(60*((12/PI)*Arctan(deux[28]/deux[27])-deux[31]));
	trois[32]:=INT(60*((12/PI)*Arctan(trois[28]/trois[27])-INT(deux[31])));
	{RA-sec}
	un[33]:=(((3600*12/PI)*Arctan(un[28]/un[27]))-un[32]*60-un[31]*3600);
	deux[33]:=(((3600*12/PI)*Arctan(deux[28]/deux[27]))-deux[32]*60-deux[31]*3600);
	TROIS[33]:=(((3600*12/PI)*Arctan(trois[28]/trois[27]))-trois[32]*60-trois[31]*3600);

        {cos d}
	un[30]:=un[27]/COS(PI*(un[31]+un[32]/60+un[33]/3600)/12);
        deux[30]:=deux[27]/cos(pi*(deux[31]+deux[32]/60+deux[33]/3600)/12);
        trois[30]:=trois[27]/cos(pi*(trois[31]+trois[32]/60+trois[33]/3600)/12);

	{DEC-deg}
	un[34]:=INT((180/PI)*Arctan(un[29]/un[30]));
	deux[34]:=INT((180/PI)*Arctan(deux[29]/deux[30]));
	trois[34]:=INT((180/PI)*Arctan(trois[29]/trois[30]));
	{DEC - min}
	un[35]:=INT(60*((180/PI)*Arctan(un[29]/un[30])-un[34]));
	deux[35]:=INT(60*((180/PI)*Arctan(deux[29]/deux[30])-deux[34]));
	trois[35]:=INT(60*((180/PI)*Arctan(trois[29]/trois[30])-trois[34]));
	{DEC - sec}
	un[36]:=(((3600*180/PI)*Arctan(un[29]/un[30]))-un[35]*60-un[34]*3600);
	deux[36]:=(((3600*180/PI)*Arctan(deux[29]/deux[30]))-deux[35]*60-deux[34]*3600);
	trois[36]:=(((3600*180/PI)*Arctan(trois[29]/trois[30]))-trois[35]*60-trois[34]*3600);
        {v carre}
	inter[4]:=sqr(deux[24])+sqr(deux[25])+sqr(deux[26]);
	{V}
	inter[5]:=sqrt(inter[4]);
	{Qx}
	inter[16]:=deux[24]/inter[5];
	{Qy}
	inter[17]:=deux[25]/inter[5];
	{Qz}
	inter[18]:=deux[26]/inter[5];
	{Px}
	inter[13]:=deux[19]/deux[23];
	{Py}
	inter[14]:=deux[20]/deux[23];
	{Pz}
	inter[15]:=deux[21]/deux[23];
{sin i sin omega}
inter[6]:=(inter[15]*(COS(degtorad(23.441893))))-(inter[14]*(SIN(degtorad(23.441893))));
	{sin i cos omega}
	inter[7]:=(inter[18]*COS(degtorad(23.441893)))-(inter[17]*SIN(degtorad(23.441893)));
	{arg of perihelion}
	omega:=(180/PI)*Arctan(inter[6]/inter[7]);
{semimajor axis}
a:=1/((2/deux[23])-inter[4]);
	{cos omega}
	inter[9]:=cos(degtorad(omega));
	{sin omega}
	inter[8]:=sin(degtorad(omega));
	{sin pi}
	inter[10]:=((inter[14]*inter[9])-(inter[17]*inter[8]))/COS(degtorad(23.441893));
	{cos pi}
	inter[11]:=(inter[13]*inter[9])-(inter[16]*inter[8]);
	{cos i}
	inter[12]:=((inter[13]*inter[8])+(inter[16]*inter[9]))/inter[10];
	{eccentricity}
	e:=1-deux[23]/a;
	{inclination}
	i:=ABS((180/PI)*Arctan((inter[6]/inter[8])/inter[12]));
	{LONG ASCENDING NODE}
	la_node:=(180/PI)*Arctan(inter[10]/inter[11]);
{mean daily motion}
toto:=power(a,1.5);
mu:=0.9856076686/toto; // power 1.5
{mean anomaly}
m:=360+mu*(trois[2]-deux[2]);
	{----------------------------
	RETOURS
	----------------------------}
	{a-r carre}
	a_moins_r2:=a-deux[23];
	{RA}
	if trois[31]>=0 then tmp1:=trois[31] else tmp1:=trois[31]+20;
	ra:=radtodeg((tmp1+trois[32]/60+trois[33]/3600)*PI/12);
	{DEC}
	dec:=radtodeg((trois[34]+trois[35]/60+trois[36]/3600)*PI/180);
	{elements}
	elem.arg_peri:=omega;
	elem.eccentricity:=e;
	elem.semi_axis:=a;
	elem.inclination:=i;
	elem.lon_asc_node:=la_node;
	elem.mean_anom:=m;
	elem.mean_daily:=mu;
end;

{-------------------------------------------------------------------------------

                                 CORRECTIONS

-------------------------------------------------------------------------------}

{struct star

        char obname[32];        /* Object name (31 chars) */
        double epoch;           /* Epoch of coordinates */
        double ra;              /* Right Ascension, radians */
        double dec;             /* Declination, radians */
        double px;              /* Parallax, radians */
        double mura;            /* proper motion in R.A., rad/century */
        double mudec;           /* proper motion in Dec., rad/century */
        double v;               /* radial velocity, km/s */
        double equinox;         /* Epoch of equinox and ecliptic */
        double mag;             /* visual magnitude */


// verifier les types ci dessus avec la nouvelle structure


{extern double DTR;
extern double RTD;
extern double RTS;
extern double STR;
extern double PI;
extern double J2000;
extern double B1950;
extern double J1900;
extern double Caud;
extern double Rearthau;
extern double JD;
extern double TDT;
extern double UT;
extern double dradt, ddecdt;
extern int objnum, jdflag, prtflg;
extern double obpolar[];
extern double eapolar[];
extern double rearth[];
extern double dp[];
/* angles.c */
extern double SE, SO, EO, pq, ep, qe;
/* nutate.c */
extern double jdnut, nutl, nuto;
/* epsiln.c */
extern double jdeps, eps, coseps, sineps;



function reduce_star(el:p_astrom_corr;):byte;
var
p,q,e,m,temp,polar:array[0..2] of double;
T, vpi, epoch:double;
cosdec, sindec, cosra, sinra:double;
i:integer;
log:array of double;

begin
// d abord recuperer les coords rectangulaires heliocentriques de la
// terre

//* Convert from RA and Dec to equatorial rectangular direction */
cosdec := cos( el.dec );
sindec := sin( el.dec );
cosra := cos( el.ra );
sinra := sin( el.ra );
q[0] := cosra * cosdec;
q[1] := sinra * cosdec;
q[2] := sindec;

//{* space motion *
vpi := 21.094952663 * el.radvel * el.parallax;
m[0]:= -el.mura * cosdec * sinra - el.mudec * sindec * cosra + vpi *
q[0];
m[1]:=  el.mura * cosdec * cosra - el.mudec * sindec * sinra + vpi *
q[1];
m[2]:=  el.mudec * cosdec + vpi * q[2];
epoch := el.epoch;

for i:=0 to 2 do e[i] := rearth[i];

//* precess the earth to the star epoch */
precess( e, epoch, -1 );

//* Correct for proper motion and parallax */
T := (TDT - epoch)/36525.0;
for i:=0 to 2 do p[i] := q[i]+T*m[i]-el.px * e[i];

//* precess the star to J2000 */
precess( p, epoch, 1 );

// reset the earth to J2000
for i:=0 to 2 do e[i] := rearth[i];

// Find Euclidean vectors between earth, object, and the sun angles( p,q, e )
angles( p, p, e );

//* Find unit vector from earth in direction of object */
for i:=0 to 2 do
begin
        p[i] := p[i]/EO;
        temp[i] := p[i];
end;

//if( prtflg )
//      {
//      printf( "approx. visual magnitude %.1f\n", el->mag );
//* Report astrometric position */
//      showrd( "Astrometric J2000.0:", p, polar );

//* Also in 1950 coordinates */
//      precess( temp, B1950, -1 );
//      showrd( "Astrometric B1950.0:", temp, polar );

//* For equinox of date: */
//for( i=0; i<3; i++ )
//              temp[i] = p[i];
//      precess( temp, TDT, -1 );
//      showrd( "Astrometric of date:", temp, polar );
//

//* Correct position for light deflection * relativity( p, q, e ); */
relativity( p, p, e );


//* Correct for annual aberration */
annuab( p );

//* Precession of the equinox and ecliptic * from J2000.0 to ephemeris date */
precess( p, TDT, -1 );

//* Ajust for nutation at current ecliptic. */
epsiln( TDT );
nutate( TDT, p );

//* Display the final apparent R.A. and Dec for equinox of date */
showrd( "    Apparent:", p, polar );

//* Go do topocentric reductions. */
dradt := 0.0;
ddecdt := 0.0;
polar[2] = 1.0e38; //* make it ignore diurnal parallax */
altaz( polar, UT );
return(0);
end; }



{--------------------------------PRECESSION------------------------------------}

PROCEDURE PrecessionFK4(ti,tf : double; VAR ari,dei : double);
var i1,i2,i3,i4,i5,i6,i7 : double ;
BEGIN
    ari:=ari*15;
    I1:=(TI-2415020.3135)/36524.2199 ;
    I2:=(TF-TI)/36524.2199 ;
    I3:=((1.8E-2*I2+3.02E-1)*I2+(2304.25+1.396*I1))*I2/3600.0 ;
    I4:=I2*I2*(7.91E-1+I2/1000.0)/3600.0+I3 ;
    I5:=((2004.682-8.35E-1*I1)-(4.2E-2*I2+4.26E-1)*I2)*I2/3600.0 ;
    I6:=COS(degtorad(DEI))*SIN(degtorad(ARI+I3)) ;
    I7:=COS(degtorad(I5))*COS(degtorad(DEI))*COS(degtorad(ARI+I3))-SIN(degtorad(I5))*SIN(degtorad(DEI));
    DEI:=radtodeg(ArcSIN(SIN(degtorad(I5))*COS(degtorad(DEI))*COS(degtorad(ARI+I3))+COS(degtorad(I5))*SIN(degtorad(DEI))));
    ARI:=radtodeg(ARCTAN2(I6,I7)) ;
    ARI:=ARI+I4   ;
    ARI:=RMOD(ARI+360.0,360.0)/15;
END  ;


PROCEDURE Precession(ti,tf : double; VAR ari,dei : double);  // ICRS
var i1,i2,i3,i4,i5,i6,i7 : double ;
BEGIN
      ari:=ari*15;
      I1:=(TI-2451545.0)/36525 ;
      I2:=(TF-TI)/36525;
      I3:=((2306.2181+1.39656*i1-1.39e-4*i1*i1)*i2+(0.30188-3.44e-4*i1)*i2*i2+1.7998e-2*i2*i2*i2)/3600 ;
      I4:=((2306.2181+1.39656*i1-1.39e-4*i1*i1)*i2+(1.09468+6.6e-5*i1)*i2*i2+1.8203e-2*i2*i2*i2)/3600 ;
      I5:=((2004.3109-0.85330*i1-2.17e-4*i1*i1)*i2-(0.42665+2.17e-4*i1)*i2*i2-4.1833e-2*i2*i2*i2)/3600 ;
      I6:=COS(degtorad(DEI))*SIN(degtorad(ARI+I3)) ;
      I7:=COS(degtorad(I5))*COS(degtorad(DEI))*COS(degtorad(ARI+I3))-SIN(degtorad(I5))*SIN(degtorad(DEI)) ;
      DEI:=radtodeg(ArcSIN(SIN(degtorad(I5))*COS(degtorad(DEI))*COS(degtorad(ARI+I3))+COS(degtorad(I5))*SIN(degtorad(DEI)))) ;
      ARI:=radtodeg(ARCTAN2(I6,I7)) ;
      ARI:=ARI+I4   ;
      ARI:=RMOD(ARI+360.0,360.0)/15;
END;


{-------------------------------REFRACTION-------------------------------------}

function refraction_moshier(alt,atpress,attemp:double):double;
{/* alt : altitude in degrees */}
var
y, y0, D0, N, D, P, Q:double;
i:integer;
begin
	if (alt < -2.0) or (alt >= 90.0) then result:=0;

	{/* For high altitude angle, AA page B61
 	  * Accuracy "usually about 0.1' ". */}

	if alt > 15.0 then result:= 0.00452*atpress/((273.0+attemp)*tan(degtorad(alt)));

       {* Formula for low altitude is from the Almanac for Computers.
 	* It gives the correction for observed altitude, so has
 	* to be inverted numerically to get the observed from the true.
 	* Accuracy about 0.2' for -20C < T < +40C and 970mb < P < 1050mb.*/}

	{/* Start iteration assuming correction = 0 */}
	y := alt;
	D := 0.0;
	{/* Invert Almanac for Computers formula numerically}
	P := (atpress - 80.0)/930.0;
	Q := 4.8e-3 * (attemp - 10.0);
	y0 := y;
	D0 := D;
	for  i:=0 to 3 do
	begin
		N := y + (7.31/(y+4.4));
		N := 1.0/tan(degtorad(N));
		D := N*P/(60.0 + Q * (N + 39.0));
		N := y - y0;
		y0 := D - D0 - N; {/* denominator of derivative */}

		if (N <> 0.0) and (y0 <> 0.0) then
		{/* Newton iteration with numerically estimated derivative */}
		N := y - N*(alt + D - y)/y0 else
		{/* Can't do it on first pass */}
		N := alt + D;
		y0 := y;
		D0 := D;
		y := N;
	end;
	result:=D;
end;

function refraction_meeus(h,p,t:double):double;
{ MEEUS - Telescope Control
renvoie la refraction en arcmin a ajouter a la hauteur d un objet
entree : h:hauteur calculee (degres) p:pression (Mb), t:temperature (Celsius)
si on ne connait pas la pression et la temperature, passer p=1010 et t=10}
var a,b,c:double;
begin
     a:=(283*p)/(1010*(273+t));
     b:=tan(h+(10.3/(h+5.11))+0.0019279);
     result:=a*(1.02/b);
end;

function AirMass(Delta,HA:Double):Double;
var
sindec,alt,sinalt,zenithdistance,seczenithdistance:double;
BEGIN
        SinDec := sin(Delta*pi/180);
        SinAlt := SinDec * Sin(config.Lat*pi/180) + cos(Delta*pi/180) * Cos(config.Lat*pi/180) * cos(HA*pi/180);
        Alt:=arcsin(SinAlt);
        ZenithDistance := (2*pi)/4 - alt;
        SecZenithDistance := 1/cos( ZenithDistance);
        result:= SecZenithDistance - 0.0018161*(SecZenithDistance-1) -0.002875*power( SecZenithDistance-1, 2) - 0.0008083*power( SecZenithDistance-1, 3);
end;

procedure Init_Refract(R1, R2 : TRefraction_matrix);
{MEL BARTELS}
{/* if need to move to alt = 0, instead move to alt = 0.5,
if measured alt from object = 0.5, alt to use in calculations = 0;
refraction handled by routines that translate between scope's
position (AccumAMs) and sky altitude (Current.Alt) */

/* to correct for refraction, add interpolation of R1 table to altitude */
double R1[MaxRefractIx+1][2];

/* to remove refraction, subtract interpolation of R2 table from altitude */
double R2[MaxRefractIx+1][2];}
begin
        R1[0,0] := 0*_DegToRad;
        R1[0,1] := 0*_ArcminToRad;
        R1[1,0] := 60*_DegToRad;
        R1[1,1] := 1.7*_ArcminToRad;
        R1[2,0] := 80*_DegToRad;
        R1[2,1] := 5.5*_ArcminToRad;
        R1[3,0] := 84*_DegToRad;
        R1[3,1] := 8.6*_ArcminToRad;
        R1[4,0] := 88*_DegToRad;
        R1[4,1] := 18.1*_ArcminToRad;
        R1[5,0] := 90*_DegToRad;
        R1[5,1] := 34.5*_ArcminToRad;

        R2[0,0] := 0*_DegToRad;
        R2[0,1] := 0*_ArcminToRad;
        R2[1,0] := 60*_DegToRad - 1.7*_ArcminToRad;
        R2[1,1] := 1.7*_ArcminToRad;
        R2[2,0] := 80*_DegToRad - 5.5*_ArcminToRad;
        R2[2,1] := 5.5*_ArcminToRad;
        R2[3,0] := 84*_DegToRad - 8.6*_ArcminToRad;
        R2[3,1] := 8.6*_ArcminToRad;
        R2[4,0] := 88*_DegToRad - 18.1*_ArcminToRad;
        R2[4,1] := 18.1*_ArcminToRad;
        R2[5,0] := 90*_DegToRad - 34.5*_ArcminToRad;
        R2[5,1] := 34.5*_ArcminToRad;
end;

{ this function calcs refraction to add to altitude }
function CalcRefractScopeToSky (R1:TRefraction_Matrix; Alt:double):double;
var
Ix:integer;
ZAng:double;
begin
        ZAng := PI/2 - Alt;
        if( ZAng < 0) then ZAng := -ZAng;
        Ix:=0;
        while ((ZAng > r1[Ix,0]) and (Ix < 5)) do inc(Ix);
        result:= R1[Ix-1][1] + (ZAng - R1[Ix-1][0])*( R1[Ix][1] - R1[Ix-1][1])/( R1[Ix][0] - R1[Ix-1][0]);
end;

{ this function calcs refraction to remove from altitude }
function CalcRefractSkyToScope(R2:TRefraction_Matrix;  Alt:double):double;
var
Ix:integer;
ZAng:double;
begin
        ZAng := PI/2 - Alt;
        if( ZAng < 0) then ZAng := -ZAng;
        Ix:=0;
        while ((ZAng > r2[Ix,0]) and (Ix < 5)) do inc(Ix);
        RESULT:= R2[Ix-1][1] + (ZAng - R2[Ix-1][0])*( R2[Ix][1] - R2[Ix-1][1])/( R2[Ix][0] - R2[Ix-1][0]);
END;


{----------------------------------EPSILON-------------------------------------}

function epsilon(jj:double):double;
{formule de Laskar : obliquite de l ecliptique en degres}
var
t,u,e:double;

begin
   t:=(jj-2451545.0)/36525;
   u:=t/100;
   e:=u*(-4680.93-u*(1.55+u*(1999.25-u*(51.38-u*(249.67-u*(39.05+u*(7.12+u*(27.87+u*(5.79+u*(2.45))))))))));
   e:=(23.4392911111+e/3600)*PI/180;
   result:=e;
end;


{---------------------------------NUTATION-------------------------------------}

procedure Nutation(jd:double;var dpsi,deps:extended);
{entree : jour julien de l observation
 sortie delta epsilon : nutation en longitude en arcsec
        delta psi :     nutation en obliquite en arcsec

 Theorie du BdL}

var
 m0,m9,f,d,om,t:extended;
begin
 t:=(jd-2451545.0)/365250.0;
 m9:=485867.28096+t*(17179159234.728+t*(3238.93+t*(51.651-2.44*t)));
 m0:=1287104.79306+t*(1295965810.474+t*(0.147*t-55.29));
 f:=335779.55755+t*(17395272630.983-t*(1225.05+t*(1.021-t*0.0417)));
 d:=1072260.73512+t*(16029616014.603-t*(586.81-t*(6.595-0.3184*t)));
 om:=450160.39816-t*(69628902.656-t*(747.42+t*(7.702-t*0.5939)));
 m9:=pi*(m9-1296000.0*int(m9/1296000.0))/648000;
 m0:=pi*(m0-1296000.0*int(m0/1296000.0))/648000;
 f:=pi*(f-1296000.0*int(f/1296000.0))/648000;
 d:=pi*(d-1296000.0*int(d/1296000.0))/648000;
 om:=pi*(om-1296000.0*int(om/1296000.0))/648000;
 dpsi:=-(171996+1742*t)*sin(om)+(2062+2*t)*sin(2*om);
 dpsi:=dpsi+46*sin(2*(f-m9)+om)+11*sin(2*(m9-f));
 dpsi:=dpsi-(13187+16*t)*sin(2*(f-d+om))+(1426-34*t)*sin(m0);
 dpsi:=dpsi-(517-12*t)*sin(m0+2*(f-d+om));
 dpsi:=dpsi+(217-5*t)*sin(2*(f-d+om)-m0);
 dpsi:=dpsi+(129+t)*sin(2*(f-d)+om)+48*sin(2*(m9-d));
 dpsi:=dpsi-22*sin(2*(f-d))+(17-t)*sin(2*m0)-15*sin(m0+om);
 dpsi:=dpsi-(16-t)*sin(2*(m0+f-d+om))-12*sin(om-m0);
 dpsi:=dpsi-(2274+2*t)*sin(2*(f+om))+(712+t)*sin(m9);
 dpsi:=dpsi-(386+4*t)*sin(2*f+om)-301*sin(m9+2*(f+om));
 dpsi:=dpsi-158*sin(m9-2*d)+123*sin(2*(f+om)-m9)+63*sin(2*d);
 dpsi:=dpsi+(63+t)*sin(m9+om)-(58+t)*sin(om-m9);
 dpsi:=dpsi-59*sin(2*(f+d+om)-m9)-51*sin(m9+2*f+om);
 dpsi:=dpsi-38*sin(2*(f+d+om))+29*sin(2*m9)+29*sin(m9+2*(f-d+om));
 dpsi:=dpsi-31*sin(2*(m9+f+om))+26*sin(2*f)+21*sin(2*f+om-m9);
 dpsi:=dpsi+16*sin(2*d+om-m9)-13*sin(m9-2*d+om);
 dpsi:=dpsi-10*sin(2*(f+d)+om-m9)-8*sin(m9+2*(f+d+om));
 dpsi:=dpsi+7*(sin(m0+2*(f+om))+sin(-m0+2*(f+om))-sin(m9+m0-2*d)-sin(2*(f+d)+om));
 dpsi:=dpsi+6*(sin(m9+2*d)+sin(2*(m9+f-d-om))-sin(2*d+om)+sin(m9+2*(f-d)+om)-sin(+2*(d-m9)+om));
 dpsi:=dpsi+5*(sin(m9-m0)-sin(om-2*d)-sin(2*(m9+f)+om)-sin(2*(f-d)+om-m0));
 dpsi:=dpsi+4*(sin(2*(m9-d)+om)+sin(m0+om+2*(f-d))-sin(m9-d));
 dpsi:=dpsi+4*(sin(m9-2*f)-sin(m0-2*d)-sin(d)-sin(2*(f+om-m9))-sin(m9-m0-d));
 dpsi:=dpsi+3*(sin(m9+2*f)-sin(m9+m0)-sin(m9-m0+2*(f+om)));
 dpsi:=dpsi-3*(sin(2*(f+d+om)-m9-m0)+sin(3*m9+2*(f+om))+sin(2*(f+d+om)-m0));
 dpsi:=dpsi+2*(sin(m9+m0+2*(f+om))-sin(2*(f-d)+om-m9)-sin(om-2*m9));
 dpsi:=dpsi+2*(sin(2*m9+om)-sin(4*d+2*(om+f)-m9)-sin(m9+2*om));
 dpsi:=dpsi+2*(sin(3*m9)+sin(2*(f+om)+d)-sin(2*(f-m0-d)+om));
 dpsi:=dpsi+sin(2*(m9-d)+m0)+sin(2*(d-f)+om)-sin(m0+2*(d-f));
 dpsi:=dpsi+sin(m0+2*om)+sin(d-m9+om)-sin(m0+2*(f-d));
 dpsi:=dpsi+sin(2*om-m9)-sin(m9-4*d)+sin(2*(f+d+om-m9))-sin(2*m9-4*d);
 dpsi:=dpsi+sin(m9+m0+2*(f-d+om))-sin(m9+om+2*(f+d))-sin(2*(2*d+om+f-m9));
 dpsi:=dpsi+sin(4*f+2*om-m9)+sin(m9-m0-2*d)+sin(2*(m9+f-d)+om);
 dpsi:=dpsi-sin(2*(m9+f+d+om))-sin(m9+2*d+om)+sin(2*(2*f-d+om));
 dpsi:=dpsi+sin(3*m9+2*(f-d+om))-sin(m9+2*(f-d))+sin(m0+2*f+om);
 dpsi:=dpsi+sin(2*d+om-m9-m0)-sin(om-2*f)-sin(2*(f+om)-d);
 dpsi:=dpsi-sin(m0+2*d)-sin(m9-2*(f+d))-sin(2*f+om-m0)+sin(2*(m9-f)+om);
 dpsi:=dpsi+sin(2*(m9+d))-sin(m9+m0+om-2*d)-sin(m9+2*(d-f));
 dpsi:=dpsi+sin(m0+d)-sin(2*(2*d+f+om));
 dpsi:=10*dpsi-sin(3*m9+2*(f+d+om))-2*sin(m9+2*(f+om+2*d))-3*sin(4*m9+2*(f+om));
 dpsi:=dpsi-2*sin(2*(m9+f+d)+om)-sin(2*f+4*d+om)-5*sin(3*m9+2*f+om);
 dpsi:=dpsi+sin(m9+m0+2*(f+d+om))-6*sin(m9-m0+2*(f+d+om))-3*sin(2*f+4*d+om-m9);
 dpsi:=dpsi-2*sin(2*(f+om+2*d)-m9-m0)+4*sin(2*(m9+f+om)+m0)+2*sin(4*f-2*om);
 dpsi:=dpsi+3*sin(2*(m9+f))+5*sin(m0+2*(f+d+om))+3*sin(m9+d+2*(f+om));
 dpsi:=dpsi-5*sin(2*(m9+f+om)-m0)+4*sin(2*(f+d))-sin(2*(m9+d)-om);
 dpsi:=dpsi-4*sin(2*(f+d)+om-m0)-2*sin(4*d+2*(f-m9)+om)-sin(2*(om+d+f-m0));
 dpsi:=dpsi+5*sin(4*d)-2*sin(4*d+om)+2*sin(4*f+2*(om-d)+m9);
 dpsi:=dpsi+2*sin(3*m9+2*(f-d)+om)+4*sin(2*f+m0+m9+om)+2*sin(4*f+om-m9);
 dpsi:=dpsi-2*sin(2*(f+om)+m0+d)-sin(om-3*m9)+6*sin(2*(f+d+om)+m0-m9);
 dpsi:=dpsi+3*sin(2*f+d+om)-4*sin(m9-m0+2*f+om)-4*sin(om-m9-2*d);
 dpsi:=dpsi-5*sin(2*(f+d)+om-m9-m0)+5*sin(m9-m0+2*d)-sin(m9-4*d+om);
 dpsi:=dpsi-2*sin(4*d+om-m9)+sin(4*d-m9-m0)+3*sin(2*(m9+f-d+om)+m0);
 dpsi:=dpsi+2*sin(4*f-2*d+om)-3*sin(m9-d+2*(f+om))-3*sin(2*m9+m0)-sin(2*f+om);
 dpsi:=dpsi+2*sin(2*f+3*om)+2*sin(m0+om+2*d)-3*sin(m9+d)+4*sin(2*m9-m0);
 dpsi:=dpsi+2*sin(2*(f+d-m9)+om)+sin(2*(om-d))-5*sin(2*(d+om));
 dpsi:=dpsi-3*sin(m0+om-2*d)-2*sin(2*d+om-m0)-sin(2*m9-4*d+om);
 dpsi:=dpsi+sin(4*d-2*m9+om)+2*sin(2*(d-m0))-sin(2*f-4*d+om);
 dpsi:=dpsi+3*sin(m9+m0+om+2*(f-d))+4*sin(2*(f+om)+m0-m9)+2*sin(om-m9-m0);
 dpsi:=dpsi-3*sin(m9+m0+om)+3*sin(m9-2*f+om)-2*sin(f+om);
 dpsi:=dpsi-2*sin(2*(f+om)-m9-m0)-sin(2*d+om-m9+m0)+3*sin(om-d);
 dpsi:=dpsi-4*sin(d+om)-2*sin(m0+om-m9)+5*sin(m9-m0+om)+3*sin(m9+2*(om-d));
 dpsi:=dpsi-4*sin(2*(d+om)-m9)+3*sin(2*(om+f-d)-m9)-sin(2*(f-d)+om+m0-m9);
 dpsi:=dpsi+3*sin(2*(d-m0)-m9)-4*sin(m9+om+2*f-4*d)-5*sin(3*m0+2*(f+om-d));
 dpsi:=dpsi+3*sin(3*m0)-2*sin(2*(d-m9)+om-m0)-9*sin(2*(f-d)+om)-sin(om-2*m0);
 dpsi:=dpsi+12*sin(2*(f-d)+3*om)-3*sin(2*(m9+om-d))-sin(om+m0+2*(f-m9));
 dpsi:=dpsi-sin(m0+2*(f+om-m9))-4*sin(2*f-d-m9+om)+3*sin(2*om-m0);
 dpsi:=dpsi+2*sin(m9-d+om)+4*sin(2*(f+om-m9)-m0)+4*sin(2*(f-m9)+om-m0);
 dpsi:=dpsi+2*sin(2*(f+om)+d-3*m9)-2*sin(3*om)+13*sin(2*(f+om)-m9-m0-d);
 dpsi:=dpsi-15*sin(f+om-m9)+3*sin(f-m9+2*om)+7*sin(m0-m9+d+om);
 dpsi:=dpsi-sin(2*(m9+f+d+om)-m0)-sin(4*d+2*(om+f)-m0)-sin(3*m9+2*(f+om)-m0);
 dpsi:=dpsi-sin(2*(f+d-m0)+om+m9)+sin(m9+4*d)+sin(4*m9+2*(f+om-d));
 dpsi:=dpsi+sin(2*(m9+f)+m0+om)+sin(4*m9)+sin(m0+om+2*(f+d))+sin(m9+d+om+2*f);
 dpsi:=dpsi-sin(2*(m9+f)+om-m0)+sin(2*(f+om)+3*d-m9)-sin(4*d+2*(f+om-m9)-m0);
 dpsi:=dpsi+sin(4*d-m0)-sin(2*(m9+f+om)-d)+sin(m9-om+2*f)+sin(3*m9+om);
 dpsi:=dpsi+sin(2*(f+d)+om-m9+m0)-sin(m9+m0+2*d)-sin(m9-m0+om+2*d);
 dpsi:=dpsi-sin(2*(f+d+om-m0)-m9)+sin(2*(m9+f-d)+om+m0)+sin(2*(m0+f+om));
 dpsi:=dpsi-sin(2*(m9+f-d))-sin(4*f+2*(om-m9))+sin(m9+m0+d)-sin(2*(m9+om));
 dpsi:=dpsi+sin(2*(f+om)+d-m9)-sin(2*d+m0-om)-sin(2*(f+om-m0));
 dpsi:=dpsi+sin(2*(m9+d-f)-om)+sin(2*(f+d+om-m9)-m0)-sin(3*d-m9);
 dpsi:=dpsi+sin(4*d-2*m9-m0)-sin(4*f+2*(om-d)-m9)-sin(m9+2*m0);
 dpsi:=dpsi+sin(2*f+om-m9+m0)-sin(2*f-d+om)-sin(m9-m0+om+2*(f-d));
 dpsi:=dpsi-sin(m9-m0+2*(f+om-d))+sin(2*m9-d)-sin(2*(m0+d)-m9);
 dpsi:=dpsi+sin(2*(f+om)-m0-d)+sin(3*m9-2*f-om)-sin(2*f-m9-m0+om);
 dpsi:=dpsi-sin(2*d-m9+m0-om)+sin(2*(f+d)-3*m9+om)+sin(m9-2*m0)-sin(3*d-2*m9);
 dpsi:=dpsi+sin(4*d-3*m9)-sin(4*d-2*(f+om)-m9)-sin(4*d-2*f-m9);
 dpsi:=dpsi+sin(4*d-2*(f+om)-m9-m0)-sin(m9+m0+om+2*f-4*d)+sin(2*(m0+f-d)+om);
 dpsi:=dpsi-sin(2*(m9+f+om)-4*d)+sin(2*(m9-d)+m0+om)-sin(4*f+2*(om-m9-d));
 dpsi:=dpsi-sin(2*(m0+f+om-m9))-sin(2*m0+om)+sin(m9-m0+2*(f+om)-3*d);
 dpsi:=dpsi-sin(2*(f+d+om)-4*m9);
 deps:=(92025+89*t)*cos(om)-(895-5*t)*cos(2*om)-24*cos(2*(f-m9)+om);
 deps:=deps+(5736-31*t)*cos(2*(f-d+om))+(54-t)*cos(m0);
 deps:=deps+(224-6*t)*cos(m0+2*(f-d+om))-(95-3*t)*cos(2*(f-d+om)-m0);
 deps:=deps-70*cos(2*(f-d)+om)+(977-5*t)*cos(2*(f+om))-7*cos(m9);
 deps:=deps+(200-t)*cos(2*f+om)+129*cos(m9+2*(f+om))-cos(m9-2*d);
 deps:=deps-53*cos(2*(f+om)-m9)-33*cos(m9+om)+32*cos(om-m9);
 deps:=deps+26*cos(2*(f+d+om)-m9)+27*cos(m9+2*f+om)+16*cos(2*(f+d+om));
 deps:=deps-cos(2*m9)-12*cos(m9+2*(f-d+om))+13*cos(2*(m9+f+om))-cos(2*f);
 deps:=deps-10*cos(2*f+om-m9)+9*cos(m0+om)-8*cos(2*d+om-m9)+6*cos(om-m0);
 deps:=deps+7*(cos(m9-2*d+om)+cos(2*(m0+f-d+om)));
 deps:=deps+5*(cos(2*(f+d)+om-m9)+cos(m9+m0-2*d));
 deps:=deps+3*(cos(m9+2*(f+d+om))+cos(m9+2*d)+cos(2*(f+d)+om));
 deps:=deps+3*(cos(m9+2*(f-d)+om)+cos(m9-m0)+cos(m0-2*d));
 deps:=deps+3*(cos(2*(d-m9)+om)+cos(2*(f-d)+om-m0));
 deps:=deps-3*(cos(2*(f+om)-m0)+cos(2*d+om)+cos(om-2*d));
 deps:=deps-2*(cos(2*(m9-d)+om)+cos(m0+2*(f-d)+om)-cos(2*d));
 deps:=deps+cos(2*(f-d-m0)+om)+cos(2*(f+om-m9))+cos(2*(m9-d));
 deps:=deps+cos(m9-m0+2*(f+om))+cos(2*(f+d+om)-m9-m0);
 deps:=deps+cos(om-2*m9)+cos(3*m9+2*(f+om))+cos(2*(f+d+om)-m0);
 deps:=deps-cos(m9+m0+2*(f+om))+cos(2*(f-d)+om-m9)-cos(2*m9+om);
 deps:=deps+cos(m9+2*om)-cos(2*(f+om)+d)-cos(2*om-m9)-cos(2*(f+d+om-m9));
 deps:=deps+cos(2*(2*d+f+om)-m9)-cos(m9+m0+2*(f-d+om))+cos(2*(f+d)+m9+om);
 deps:=deps+cos(2*(2*d-m9+f+om))-cos(2*(m9+f-d)+om);
 deps:=10*deps+cos(3*m9+2*(f+d+om))+cos(m9+2*(f+om+2*d))+cos(4*m9+2*(f+om));
 deps:=deps+cos(2*(m9+f+d)+om)+cos(2*f+4*d+om)+2*cos(3*m9+2*f+om);
 deps:=deps-cos(m9+m0+2*(f+d+om))+2*cos(m9-m0+2*(f+d+om))+cos(2*f+4*d+om-m9);
 deps:=deps+cos(2*(f+om+2*d)-m9-m0)-2*cos(2*(m9+f+om)+m0)-cos(4*f-2*om);
 deps:=deps-2*cos(m0+2*(f+d+om))-cos(m9+d+2*(f+om))+2*cos(2*(m9+f+om)-m0);
 deps:=deps+cos(2*(m9+d)-om)+2*cos(2*(f+d)+om-m0)+cos(4*d+2*(f-m9)+om);
 deps:=deps+cos(2*(om+d+f-m0))+cos(4*d+om)-cos(4*f+2*(om-d)+m9);
 deps:=deps-cos(3*m9+2*(f-d)+om)-2*cos(2*f+m0+m9+om)-cos(4*f+om-m9);
 deps:=deps+cos(2*(f+om)+m0+d)+cos(om-3*m9)-2*cos(2*(f+d+om)+m0-m9);
 deps:=deps-cos(2*f+d+om)+2*cos(m9-m0+2*f+om)+3*cos(om-m9-2*d);
 deps:=deps+2*cos(2*(f+d)+om-m9-m0)+cos(m9-4*d+om)+cos(4*d+om-m9);
 deps:=deps-cos(2*(m9+f-d+om)+m0)-cos(4*f-2*d+om)+cos(m9-d+2*(f+om));
 deps:=deps-cos(m0+om+2*d)-cos(2*(f+d-m9)+om)-cos(2*(om-d))+2*cos(2*(d+om));
 deps:=deps+2*cos(m0+om-2*d)+cos(2*d+om-m0)+cos(2*m9-4*d+om);
 deps:=deps-cos(4*d-2*m9+om)+cos(2*f-4*d+om)-cos(m9+m0+om+2*(f-d));
 deps:=deps-2*cos(2*(f+om)+m0-m9)-cos(om-m9-m0)+2*cos(m9+m0+om)-cos(m9-2*f+om);
 deps:=deps+cos(2*(f+om)-m9-m0)+cos(2*d+om-m9+m0)-2*cos(om-d)+2*cos(d+om);
 deps:=deps+2*cos(m0+om-m9)-3*cos(m9-m0+om)-cos(m9+2*(om-d));
 deps:=deps+2*cos(2*(d+om)-m9)-cos(2*(om+f-d)-m9)+cos(2*(f-d)+om+m0-m9);
 deps:=deps+2*cos(m9+om+2*f-4*d)+2*cos(3*m0+2*(f+om-d))+cos(2*(d-m9)+om-m0);
 deps:=deps+7*cos(2*(f-d)+om)+cos(om-2*m0)-2*cos(2*(f-d)+3*om);
 deps:=deps+cos(2*(m9+om-d))+cos(2*f-d-m9+om)-cos(2*om-m0)-cos(m9-d+om);
 deps:=deps-2*cos(2*(f+om-m9)-m0)-cos(2*(f+om)+d-3*m9)-5*cos(2*(f+om)-m9-m0-d);
 deps:=deps+3*cos(f+om-m9)-cos(f-m9+2*om)-4*cos(m0-m9+d+om);
 dpsi:=dpsi/100000;
 deps:=deps/100000;
end;


{----------------------------Annual Aberration---------------------------------}




{--------------------------------PARALLAXE-------------------------------------}

procedure correct_phi(altitude:double; longitude:double; var rho_sin_phi,rho_cos_phi:double);
// calcule ro sin phi et rho cos phi a partir de lat et long.
// utile au calcule de parallaxe
var
b_a,u:double;
begin
    b_a:=0.99664719; // meeus page 78
    u:=arctan_d(b_a*b_a*tan_d(longitude));
    rho_sin_phi:=b_a*sin_d(u)+altitude/6378140*sin_d(longitude);
    rho_cos_phi:=cos_d(u)+altitude/6378140*cos_d(longitude);
end;

function mod3600(x:double):double;
begin
     result:=x - 1296000 * round (x/1296000);
end;



type TRectangular = array[0..2] of double;

const pAcof:array[0..9] of double =
 (-8.66e-10, -4.759e-8, 2.424e-7, 1.3095e-5, 1.7451e-4, -1.8055e-3,
 -0.235316, 0.07732, 111.1971, 50290.966);
 // Node and inclination of the earth's orbit computed from
 // Laskar's data as done in Bretagnon and Francou's paper.
 // Units are radians.
const nodecof:array[0..10] of double = (
6.6402e-16, -2.69151e-15, -1.547021e-12, 7.521313e-12, 6.3190131e-10,
-3.48388152e-9, -1.813065896e-7, 2.75036225e-8, 7.4394531426e-5,
-0.042078604317, 3.052112654975 );

const inclcof:array[0..10] of double = (
1.2147e-16, 7.3759e-17, -8.26287e-14, 2.503410e-13, 2.4650839e-11,
-5.4000441e-11, 1.32115526e-9, -5.998737027e-7, -1.6242797091e-5,
 0.002278495537, 0.0 );

const J2000 = 2451545.0; // 2000 January 1.5
const STR   = 4.8481368110953599359e-6; //radians per arc second


function precess(J:double; direction:integer; var R:TRectangular):byte;
{  R = rectangular equatorial coordinate vector to be precessed.
       result is written back into the input vector
   J = Julian date
   Direction =
       Precess from J to J2000: direction = 1
       Precess from J2000 to J: direction = -1

  The following table indicates the differences between the result
  of the IAU formula and Laskar's formula using four different test
  vectors, checking at J2000 plus and minus the indicated number
  of years.

    Years       Arc
  from J2000  Seconds
  ----------  -------
         0	  0
       100	.006
       200     .006
       500     .015
      1000     .28
      2000    6.4
      3000   38.
     10000 9400.
 }

var
A, B, T, pA, W, z, TH:double;
x:array[0..2] of double;
i:integer;
// mettre ca en global dans config
coseps,sineps:double;
begin
     if J = J2000  then
     begin
	result:=0;
        exit;
     end;
     //* Each precession angle is specified by a polynomial in
     // * T = Julian centuries from J2000.0.  See AA page B18.
     T := (J - J2000)/36525.0;

     //* Obliquity of the equator at initial date.  */
     if direction = 1 then
	epsilon( J )     // To J2000
     else
	epsilon( J2000 ); // From J2000

     // Precession in longitude
     T := T/10; // thousands of years */
     for i:=0 to 9 do
     begin
	pA:=pA * T + pacof[i];
        pA:=pa * STR * T;
     end;

     // Node of the moving ecliptic on the J2000 ecliptic.
     for i:=0 to 10 do	W := W * T + nodecof[i];

     // Inclination of the ecliptic of date to the J2000 ecliptic.  */
     for i:=0 to 10 do TH := TH * T + inclcof[i];

     // First rotate about the x axis from the initial equator
     // to the initial ecliptic. (The input is equatorial.)
     x[0] := R[0];
     z := coseps*R[1] + sineps*R[2];
     x[2] := -sineps*R[1] + coseps*R[2];
     x[1] := z;

     // Rotate about z axis to the node.
     if direction = 1 then z := W + pA else	z := W;
     B := COS(z);
     A := SIN(z);
     z := B * x[0] + A * x[1];
     x[1] := -A * x[0] + B * x[1];
     x[0] := z;

     // Rotate about new x axis by the inclination of the moving
     // ecliptic on the J2000 ecliptic.
     if direction = 1 then TH := -TH;
     B := COS(TH);
     A := SIN(TH);
     z := B * x[1] + A * x[2];
     x[2] := -A * x[1] + B * x[2];
     x[1] := z;

     // Rotate about new z axis back from the node.
     if direction = 1 then z := -W else	z := -W - pA;
     B := COS(z);
     A := SIN(z);
     z := B * x[0] + A * x[1];
     x[1] := -A * x[0] + B * x[1];
     x[0] := z;

     // Rotate about x axis to final equator.
     if direction = 1 then epsilon( J2000 ) else epsilon( J );
     z := coseps * x[1] - sineps * x[2];
     x[2] := sineps * x[1] + coseps * x[2];
     x[1] := z;

     // Result
     for i:=0 to 2 do R[i] := x[i];
     result:=1;
end;

{-------------------------------- NUTATION ------------------------------------}
type TRow_9 = array[0..9] of smallint;
        {
const nt:array[0..105] of TRow_9 = (
 (0, 0 0, 0, 2, 2062, 2,-895, 5),
-2, 0, 2, 0, 1, 46, 0,-24, 0,
 2, 0,-2, 0, 0, 11, 0, 0, 0,
-2, 0, 2, 0, 2,-3, 0, 1, 0,
 1,-1, 0,-1, 0,-3, 0, 0, 0,
 0,-2, 2,-2, 1,-2, 0, 1, 0,
 2, 0,-2, 0, 1, 1, 0, 0, 0,
 0, 0, 2,-2, 2,-13187,-16, 5736,-31,
 0, 1, 0, 0, 0, 1426,-34, 54,-1,
 0, 1, 2,-2, 2,-517, 12, 224,-6,
 0,-1, 2,-2, 2, 217,-5,-95, 3,
 0, 0, 2,-2, 1, 129, 1,-70, 0,
 2, 0, 0,-2, 0, 48, 0, 1, 0,
 0, 0, 2,-2, 0,-22, 0, 0, 0,
 0, 2, 0, 0, 0, 17,-1, 0, 0,
 0, 1, 0, 0, 1,-15, 0, 9, 0,
 0, 2, 2,-2, 2,-16, 1, 7, 0,
 0,-1, 0, 0, 1,-12, 0, 6, 0,
-2, 0, 0, 2, 1,-6, 0, 3, 0,
 0,-1, 2,-2, 1,-5, 0, 3, 0,
 2, 0, 0,-2, 1, 4, 0,-2, 0,
 0, 1, 2,-2, 1, 4, 0,-2, 0,
 1, 0, 0,-1, 0,-4, 0, 0, 0,
 2, 1, 0,-2, 0, 1, 0, 0, 0,
 0, 0,-2, 2, 1, 1, 0, 0, 0,
 0, 1,-2, 2, 0,-1, 0, 0, 0,
 0, 1, 0, 0, 2, 1, 0, 0, 0,
-1, 0, 0, 1, 1, 1, 0, 0, 0,
 0, 1, 2,-2, 0,-1, 0, 0, 0,
 0, 0, 2, 0, 2,-2274,-2, 977,-5,
 1, 0, 0, 0, 0, 712, 1,-7, 0,
 0, 0, 2, 0, 1,-386,-4, 200, 0,
 1, 0, 2, 0, 2,-301, 0, 129,-1,
 1, 0, 0,-2, 0,-158, 0,-1, 0,
-1, 0, 2, 0, 2, 123, 0,-53, 0,
 0, 0, 0, 2, 0, 63, 0,-2, 0,
 1, 0, 0, 0, 1, 63, 1,-33, 0,
-1, 0, 0, 0, 1,-58,-1, 32, 0,
-1, 0, 2, 2, 2,-59, 0, 26, 0,
 1, 0, 2, 0, 1,-51, 0, 27, 0,
 0, 0, 2, 2, 2,-38, 0, 16, 0,
 2, 0, 0, 0, 0, 29, 0,-1, 0,
 1, 0, 2,-2, 2, 29, 0,-12, 0,
 2, 0, 2, 0, 2,-31, 0, 13, 0,
 0, 0, 2, 0, 0, 26, 0,-1, 0,
-1, 0, 2, 0, 1, 21, 0,-10, 0,
-1, 0, 0, 2, 1, 16, 0,-8, 0,
 1, 0, 0,-2, 1,-13, 0, 7, 0,
-1, 0, 2, 2, 1,-10, 0, 5, 0,
 1, 1, 0,-2, 0,-7, 0, 0, 0,
 0, 1, 2, 0, 2, 7, 0,-3, 0,
 0,-1, 2, 0, 2,-7, 0, 3, 0,
 1, 0, 2, 2, 2,-8, 0, 3, 0,
 1, 0, 0, 2, 0, 6, 0, 0, 0,
 2, 0, 2,-2, 2, 6, 0,-3, 0,
 0, 0, 0, 2, 1,-6, 0, 3, 0,
 0, 0, 2, 2, 1,-7, 0, 3, 0,
 1, 0, 2,-2, 1, 6, 0,-3, 0,
 0, 0, 0,-2, 1,-5, 0, 3, 0,
 1,-1, 0, 0, 0, 5, 0, 0, 0,
 2, 0, 2, 0, 1,-5, 0, 3, 0,
 0, 1, 0,-2, 0,-4, 0, 0, 0,
 1, 0,-2, 0, 0, 4, 0, 0, 0,
 0, 0, 0, 1, 0,-4, 0, 0, 0,
 1, 1, 0, 0, 0,-3, 0, 0, 0,
 1, 0, 2, 0, 0, 3, 0, 0, 0,
 1,-1, 2, 0, 2,-3, 0, 1, 0,
-1,-1, 2, 2, 2,-3, 0, 1, 0,
-2, 0, 0, 0, 1,-2, 0, 1, 0,
 3, 0, 2, 0, 2,-3, 0, 1, 0,
 0,-1, 2, 2, 2,-3, 0, 1, 0,
 1, 1, 2, 0, 2, 2, 0,-1, 0,
-1, 0, 2,-2, 1,-2, 0, 1, 0,
 2, 0, 0, 0, 1, 2, 0,-1, 0,
 1, 0, 0, 0, 2,-2, 0, 1, 0,
 3, 0, 0, 0, 0, 2, 0, 0, 0,
 0, 0, 2, 1, 2, 2, 0,-1, 0,
-1, 0, 0, 0, 2, 1, 0,-1, 0,
 1, 0, 0,-4, 0,-1, 0, 0, 0,
-2, 0, 2, 2, 2, 1, 0,-1, 0,
-1, 0, 2, 4, 2,-2, 0, 1, 0,
 2, 0, 0,-4, 0,-1, 0, 0, 0,
 1, 1, 2,-2, 2, 1, 0,-1, 0,
 1, 0, 2, 2, 1,-1, 0, 1, 0,
-2, 0, 2, 4, 2,-1, 0, 1, 0,
-1, 0, 4, 0, 2, 1, 0, 0, 0,
 1,-1, 0,-2, 0, 1, 0, 0, 0,
 2, 0, 2,-2, 1, 1, 0,-1, 0,
 2, 0, 2, 2, 2,-1, 0, 0, 0,
 1, 0, 0, 2, 1,-1, 0, 0, 0,
 0, 0, 4,-2, 2, 1, 0, 0, 0,
 3, 0, 2,-2, 2, 1, 0, 0, 0,
 1, 0, 2,-2, 0,-1, 0, 0, 0,
 0, 1, 2, 0, 1, 1, 0, 0, 0,
-1,-1, 0, 2, 1, 1, 0, 0, 0,
 0, 0,-2, 0, 1,-1, 0, 0, 0,
 0, 0, 2,-1, 2,-1, 0, 0, 0,
 0, 1, 0, 2, 0,-1, 0, 0, 0,
 1, 0,-2,-2, 0,-1, 0, 0, 0,
 0,-1, 2, 0, 1,-1, 0, 0, 0,
 1, 1, 0,-2, 1,-1, 0, 0, 0,
 1, 0,-2, 2, 0,-1, 0, 0, 0,
 2, 0, 0, 2, 0, 1, 0, 0, 0,
 0, 0, 2, 4, 2,-1, 0, 0, 0,
 0, 1, 0, 1, 0, 1, 0, 0, 0,
);



{ Nutation in longitude and obliquity
  computed at Julian date J.

  References:
  "Summary of 1980 IAU Theory of Nutation (Final Report of the
  IAU Working Group on Nutation)", P. K. Seidelmann et al., in
  Transactions of the IAU Vol. XVIII A, Reports on Astronomy,
  P. A. Wayman, ed.; D. Reidel Pub. Co., 1982.

  "Nutation and the Earth's Rotation",
  I.A.U. Symposium No. 78, May, 1977, page 256.
  I.A.U., 1980.

  Woolard, E.W., "A redevelopment of the theory of nutation",
  The Astronomical Journal, 58, 1-3 (1953).

  This program implements all of the 1980 IAU nutation series.
  Results checked at 100 points against the 1986 AA; all agreed.


  - S. L. Moshier, November 1987
  October, 1992 - typo fixed in nutation matrix
  October, 1995 - fixed typo in node argument,
                  tested against JPL DE403 ephemeris file.

  Each term in the expansion has a trigonometric
  argument given by
    W = i*MM + j*MS + k*FF + l*DD + m*OM
  where the variables are defined below.
  The nutation in longitude is a sum of terms of the
  form (a + bT) * sin(W). The terms for nutation in obliquity
  are of the form (c + dT) * cos(W).  The coefficients
  are arranged in the tabulation as follows:

  Coefficient:
  i  j  k  l  m      a      b      c     d
  0, 0, 0, 0, 1, -171996, -1742, 92025, 89,

  The first line of the table, above, is done separately
  since two of the values do not fit into 16 bit integers.
  The values a and c are arc seconds times 10000.  b and d
  are arc seconds per Julian century times 100000.  i through m
  are integers.  See the program for interpretation of MM, MS,
  etc., which are mean orbital elements of the Sun and Moon.

  If terms with coefficient less than X are omitted, the peak
  errors will be:

    omit	error,		  omit	error,
    a <	longitude	  c <	obliquity
  .0005"	.0100"		.0008"	.0094"
  .0046	.0492		.0095	.0481
  .0123	.0880		.0224	.0905
  .0386	.1808		.0895	.1129
}

// arrays to hold sines and cosines of multiple angles
var
ss,cc:array[0..5,0..8] of double;

function nutlo(J:double;var jdnut,nuto,nutl:double):integer;
var
f, g, T, T2, T10, MM, MS, FF, DD, OM, cu, su, cv, sv, sw, C, D : double;
i, jj, k, k1, m:integer;
// short *p;

// verifier j en case sensitive   = jj
begin
{     if jdnut = J then
     begin
          result:=0;
	  exit;
     end;
     jdnut := J;

     // Julian centuries from 2000 January 1.5,
     // barycentric dynamical time
     T := (J-2451545.0)/36525.0;
     T2 := T * T;
     T10 := T / 10.0;

     //* Fundamental arguments in the FK5 reference system.  */

     //* longitude of the mean ascending node of the lunar orbit
     //* on the ecliptic, measured from the mean equinox of date

     OM := (mod3600 (-6962890.539 * T + 450160.280) + (0.008 * T + 7.455) * T2) * STR;

     //* mean longitude of the Sun minus the
     //* mean longitude of the Sun's perigee
     MS := (mod3600 (129596581.224 * T + 1287099.804) - (0.012 * T + 0.577) * T2) * STR;

     ///* mean longitude of the Moon minus the
     // * mean longitude of the Moon's perigee
     MM := (mod3600 (1717915922.633 * T + 485866.733) + (0.064 * T + 31.310) * T2) * STR;

     //* mean longitude of the Moon minus the
     // * mean longitude of the Moon's node
     FF := (mod3600 (1739527263.137 * T + 335778.877) + (0.011 * T - 13.257) * T2) * STR;

     //* mean elongation of the Moon from the Sun.
     DD := (mod3600 (1602961601.328 * T + 1072261.307) + (0.019 * T - 6.891) * T2) * STR;

     //* Calculate sin( i*MM ), etc. for needed multiple angles
     sscc( 0, MM, 3 );
     sscc( 1, MS, 2 );
     sscc( 2, FF, 4 );
     sscc( 3, DD, 4 );
     sscc( 4, OM, 2 );

     C := 0.0;
     D := 0.0;

     // pas sur a partir d ici

       for i:=0 to 105 do
       begin
            //* argument of sine and cosine
	    k1 := 0;
	    cv := 0.0;
	    sv := 0.0;
	    for m:=0 to 5 do
	    begin
 // a remettre		jj := nt[m];
		if ( j <> 0 ) then
                begin
		     k := jj;
                     if( jj < 0 ) then k := -k;
                     su := ss[m][k-1]; //* sin(k*angle)
		     if( jj < 0 ) then su := -su;
                     cu := cc[m][k-1];
                     if ( k1 = 0 ) then
                     begin //* set first angle
                           sv := su;
                           cv := cu;
                           k1 := 1;
		     end
			else
                     begin //* combine angles
                           sw := su*cv + cu*sv;
			   cv := cu*cv - su*sv;
			   sv := sw;
                     end;
                end;
            end;
        // longitude coefficient
//	if (nt[i] <> 0 ) then f := f+(T10 * k); a remettre
        // obliquity coefficient
//	g := *p++;
//	if ( (k = *p++) != 0 ) then g += T10 * k;

        //* accumulate the terms */
	C := C+(f * sv);
	D := D+(g * cv);

    end; // fin de la boucle ?

    //* first terms, not in table: */
    C := C+ ((-1742.*T10 - 171996)*ss[4][0]);	//* sin(OM) */
    D := D+ (   89.*T10 +  92025.)*cc[4][0]);	//* cos(OM) */
    //* Save answers, expressed in radians */
    nutl := 0.0001 * STR * C;
    nuto := 0.0001 * STR * D;}
end;



{/* Nutation -- AA page B20
 * using nutation in longitude and obliquity from nutlo()
 * and obliquity of the ecliptic from epsiln()
 * both calculated for Julian date J.
 *
 * p[] = equatorial rectangular position vector of object for
 * mean ecliptic and equinox of date.
 */}
function nutate( J:double; p:TRectangular):integer;

var
ce, se, cl, sl, sino, f:double;
dp,p1:array[0..2] of double;
i:integer;
begin
{     nutlo(J);  // be sure we calculated nutl and nuto
     epsiln(J); // and also the obliquity of date

     f := eps + nuto;
     ce := cos( f );
     se := sin( f );
     sino := sin(nuto);
     cl := cos( nutl );
     sl := sin( nutl );}

    { Apply adjustment to equatorial rectangular coordinates of object.
      This is a composite of three rotations: rotate about x axis
      to ecliptic of date; rotate about new z axis by the nutation
      in longitude; rotate about new x axis back to equator of date
      plus nutation in obliquity.
    }

{    p1[0] :=   cl*p[0]
            - sl*coseps*p[1]
            - sl*sineps*p[2];

    p1[1] :=   sl*ce*p[0]
            + ( cl*coseps*ce + sineps*se )*p[1]
            - ( sino + (1.0-cl)*sineps*ce )*p[2];

    p1[2] :=   sl*se*p[0]
            + ( sino + (cl-1.0)*se*coseps )*p[1]
            + ( cl*sineps*se + coseps*ce )*p[2];

    for i:=0 to 2 do dp[i] = p1[i] - p[i];
    //showcor( "nutation", p, dp );

    for i:=0 to 2 do p[i] = p1[i];
    result:=1;}
end;


{ Prepare lookup table of sin and cos ( i*Lj )
  for required multiple angles}
function sscc( k:integer; arg:double; n:integer):integer;
var
cu, su, cv, sv, s:double;
i:integer;
begin
    su := sin(arg);
    cu := cos(arg);
    ss[k,0] := su;    // sin(L)
    cc[k][0] := cu;    // cos(L)
    sv := 2.0*su*cu;
    cv := cu*cu - su*su;
    ss[k,1] := sv;    // sin(2L)
    cc[k,1] := cv;

    for i:=2 to n do
    begin
            s :=  su*cv + cu*sv;
            cv := cu*cv - su*sv;
            sv := s;
            ss[k,i] := sv;   // sin( i+1 L )
            cc[k,i] := cv;
    end;
    result:=1;
end;

// Alpha en heures
// Delta en degres
// X et Y en ?
// Ne pas modifier sinon l'astrometrie est fausse
procedure AlphaDeltaToXY(Alpha0,Delta0,Alpha,Delta:Double;var X,Y:Double);
var
   D:Double;
begin
Alpha:=Alpha*15/180*pi;
Alpha0:=Alpha0*15/180*pi;
Delta:=Delta/180*pi;
Delta0:=Delta0/180*pi;

D:=Cos(Delta0)*Cos(Delta)*Cos(Alpha-Alpha0)+Sin(Delta0)*Sin(Delta);
X:=-(Cos(Delta)*Sin(Alpha-Alpha0))/D;
Y:=-(Sin(Delta0)*Cos(Delta)*Cos(Alpha-Alpha0)-Cos(Delta0)*Sin(Delta))/D;
end;

// Ne pas modifier sinon l'astrometrie est fausse
procedure XYToAlphaDelta(X,Y,Alpha0,Delta0:Double;var Alpha,Delta:Double);
begin
Alpha0:=Alpha0*15/180*pi;
Delta0:=Delta0/180*pi;

Alpha:=Alpha0+ArcTan(-X/(Cos(Delta0)-Y*Sin(Delta0)));
Delta:=ArcSin(Sin(Delta0)+Y*Cos(Delta0)/Sqrt(1+Sqr(X)+Sqr(Y)));

Alpha:=Alpha/pi*180/15;
Delta:=Delta/pi*180;
end;

function AlphaDeltaToName(Alpha,Delta:Double;var Name:string):byte;
var
ok,is_a_star:boolean;
begin
    result:=0;
    is_a_star:=false;
    ok:=false;
    // a finir, faut d abord detecter les catalogues installes
end;

{function NameToAlphaDelta(Name:string;var Alpha,Delta:Double):Boolean;
// Convertion d'un nom NGC/IC/Messier/PGC/SAO/Etoile en coordonnees
// Alpha/Delta
// renvoie 0 si OK et -1 si pepin
var
   OK,IsAStar:Boolean;
   Numero:string;
   Star:TStarName;
begin
Result:=True;
IsAStar:=False;
OK:=False;
Name:=Trim(Name);
Numero:=Get_Numero(Name);
if Length(Name)>0 then
   begin
   if Length(Numero)>0 then
   //catalog + id
      begin
      //NGC
      if (UpperCase(Name[1])='N') then FindNumNGC(StrToInt(Numero),Alpha,Delta,OK)
      //NGC
      else if Copy(uppercase(Name),1,3)='NGC' then FindNumNGC(StrToInt(Numero),Alpha,Delta,OK) //nolang
      //M
      else if UpperCase(Name[1])='M' then FindNumMessier(StrToInt(numero),Alpha,Delta,OK)
      //IC
      else if UpperCase(Name[1])='I' then FindNumIC(StrToInt(Numero),Alpha,Delta,OK)
      //IC
      else if Copy(UpperCase(Name),1,2)='IC' then FindNumIC(StrToInt(Numero),Alpha,Delta,OK) //nolang
      //SAO
      else if UpperCase(Copy(Name,1,3))='SAO' then FindNumSAO(StrToInt(Numero),Alpha,Delta,OK) //nolang
      //SAO
      else if UpperCase(Name[1])='S' then FindNumSAO(StrToInt(Numero),Alpha,Delta,OK)
      //PGC
      else if UpperCase(Name[1])='P' then FindNumPGC(StrToInt(Numero),Alpha,Delta,OK)
      //PGC
      else if Copy(UpperCase(Name),1,3)='PGC' then FindNumPGC(StrToInt(Numero),Alpha,Delta,OK) //nolang
      else OK:=False;
      end
   else
      begin
      //star name ?
      Star:=Find_StarName(Name,IsAStar);
      if IsAStar then
         begin
              Alpha:=star.ra;
              Delta:=star.dec;
              OK:=True;
         end;
      end;
end;

if not OK and not IsAStar and (Length(Trim(Name))>0) then
   begin
   Result:=False;
   Exit;
   end;
end;}

function NameToAlphaDelta(Name:string;var Alpha,Delta:Double):Boolean;
// Convertion d'un nom NGC/IC/Messier/PGC/SAO/Etoile en coordonnees
// Alpha/Delta
// renvoie 0 si OK et -1 si pepin
var
   OK,is_a_star,is_a_const:boolean;
   Numero:string;
   Star:TStarName;
   Constellation:TConstellation;
begin
Result:=True;
is_a_star:=false;
ok:=false;
Name:=Trim(Name);
Numero:=get_numero(Name);
if Length(Name)>0 then
   begin
   if Length(Numero)>0 then
   //catalog + id
      begin
      //NGC
      if      (uppercase(Name[1])='N') then FindNumNGC(StrToInt(Numero),Alpha,Delta,OK)
      //NGC
      else if copy(uppercase(Name),1,3)='NGC' then FindNumNGC(StrToInt(Numero),Alpha,Delta,OK) //nolang
      //M
      else if uppercase(Name[1])='M' then FindNumMessier(StrToInt(Numero),Alpha,Delta,OK)//FindNumNGC(MessierToNgc[StrToInt(Numero)],Alpha,Delta,ok)
      //IC
      else if uppercase(Name[1])='I' then FindNumIC(StrToInt(Numero),Alpha,Delta,OK)
      //IC
      else if copy(uppercase(Name),1,2)='IC' then FindNumIC(StrToInt(Numero),Alpha,Delta,OK) //nolang
      //SAO
      else if uppercase(copy(name,1,3))='SAO' then FindNumSAO(StrToInt(Numero),Alpha,Delta,OK) //nolang
      //SAO
      else if uppercase(name[1])='S' then FindNumSAO(StrToInt(Numero),Alpha,Delta,OK)
      //PGC
      else if uppercase(name[1])='P' then FindNumPGC(StrToInt(Numero),Alpha,Delta,OK)
      //PGC
      else if copy(uppercase(name),1,3)='PGC' then FindNumPGC(StrToInt(Numero),Alpha,Delta,OK) //nolang
      else ok := false;
      end
   else
      begin
      //star name ?
      star:=find_starname(Name,is_a_star);
      if is_a_star then
         begin
         Alpha:=star.ra;
         Delta:=star.dec;
         OK:=true;
         end;
      end;
      //Constellation name ?
      constellation:=find_constellation_name(name,is_a_const);
      if is_a_const then
         begin
         Alpha:=Constellation.ra;
         Delta:=Constellation.dec;
         OK:=true;
         end;
   end;

//if not OK and not is_a_star and not is_a_const and (length(trim(name)) > 0) then
if not OK then
   begin
   Result:=False;
   Exit;
   end;
end;

function compute_sampling_x(f,pixsize:double;binning:byte):double;
begin
     if (f=0) or (pixsize=0) then
     begin
          result:=0;
          exit;
     end;
     result:=206*pixsize/f*binning; {f in mm, result in arcsec/pixel}
end;

function compute_sampling_y(f,pixsize:double;binning:byte):double;
begin
     if (f=0) or (pixsize=0) then
     begin
          result:=0;
          exit;
     end;
     result:=206*pixsize/f*binning; {f in mm, result in arcsec/pixel}
end;

function compute_fov_ccd(f,pixsize:double; pix_x:integer):double;
{focale en mm, pix size en microns, champ CCD en degres}
begin
     if (f=0) or (pix_x=0) or (pixsize=0) then begin result:=0; exit; end;
     result:=((3438*pix_x*pixsize/1000)/f)/60;
end;



function what_const(alpha,delta:double):shortstring;
var
  i:integer;
  A,D,RA,RAL,RAU,DECL:double;
  toto:Tconstbound;
begin
      precession(J2000,B1875,Alpha,Delta);
      result:='';
      for i:=1 to 357 do
      begin
           toto:=myrec[i];
           RAL :=toto.mat[1];
	   RAU := toto.mat[2];
	   DECL:= toto.mat[3];
           if (alpha > RAL) and (alpha < RAU) and (delta > DECL)  then
	   begin
	       result := toto.ind;
	       exit;
           end;
      end;
      if length(result)=0 then result :='N/A'; //nolang
end;

function  AngularDistance(Alpha1,Delta1,Alpha2,Delta2:Double):Double;
// Distance entre 2 etoiles en (coords equatoriales)
// Entrees et sorties en degres
begin
if (Alpha1=Alpha2) and (Delta1=Delta2) then Result:=0.0
   else
      Result:=RadToDeg(ArcCos((Sin(DegToRad(Delta1))*Sin(DegToRad(Delta2)))+
         (Cos(DegToRad(Delta1))*Cos(DegToRad(Delta2))*Cos(DegToRad((Alpha1-Alpha2))))));
end;

// Resultat en degres
function DistanceToMoon(DateTime:TDateTime;Alpha,Delta:Double):Double;
var
  CoordMoon:t_coord;
begin
CoordMoon:=moon_coordinate(DateTime);
Result:=AngularDistance(Alpha,Delta,CoordMoon.Alpha,CoordMoon.Delta);
end;

// Resultat en degres
function DistanceToSun(DateTime:TDateTime;Alpha,Delta:Double):Double;
var
  CoordMoon:t_coord;
begin
CoordMoon:=sun_coordinate(DateTime);
Result:=AngularDistance(Alpha,Delta,CoordMoon.Alpha,CoordMoon.Delta);
end;

end.
