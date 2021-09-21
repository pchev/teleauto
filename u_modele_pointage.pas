unit u_modele_pointage;

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

{Message de Alain Klotz sur la liste Aude

Suite aux discussions sur la déterminiation des
defauts de perpendicularité des axes, on m'a posé
des questions en privé.
j'ai rassemblé toutes les réponses dans ce mail
pour tous.

Comme je le précisais, tout est écrit en clair
dans le script audace/panneau/modpoi/modpoi.tcl.

En résumé :

1) pointage d'une étoile
------------------------
Pour une étoile de coordonnées RA,DEC,Equinoxe,
on commence à lui appliquer les corrections
d'aberration annuelle, de precession, de nutation,
d'aberration de l'aberration diurne et on convertit
en coordoonées locales H,DEC (H=angle horaire).
Dans le cas où le télescope corrige tout seul la
réfraction atmosphérique (LX200, Sky Sensor 2000)
on envoit ces coordonnées au télescope. Sinon, on
corrige H,DEC de la réfraction avant de les envoyer.

2) on recentre l'étoile avec la raquette
----------------------------------------
On note alors les écarts dH et dDEC entre la
position pointée et la position recentrée avec
la raquette (utiliser un occulaire réticulé ou
un repere sur l'image CCD).

On dispose, pour cette étoile, des quatre
valeurs (H,DEC,dH,dDEC). On leur ajoute
l'indice 1 pour dire que c'est l'étoile numéro 1
(H1,DEC1,dH1,dDEC1).

3) on pointe n étoiles
----------------------
Après avoir pointé n étoiles par la procédure 1)
et 2), on dispose de n valeurs (Hi,DECi,dHi,dDECi).

4) calcul du modèle
-------------------
On remplit la matrice X

      | 1 0 tan(DEC1) 1/cos(DEC1) sin(H1)*tan(DEC1) -cos(H1)*tan(DEC1) |
      | 0 1         0           0 cos(H1)            sin(H1)           |
      | ...                                                            |
X = | 1 0 tan(DECi) 1/cos(DECi) sin(Hi)*tan(DECi) -cos(Hi)*tan(DECi) |
      | 0 1         0           0 cos(Hi)            sin(Hi)           |
      | ...                                                            |
      | 1 0 tan(DECn) 1/cos(DECn) sin(Hn)*tan(DECn) -cos(Hn)*tan(DECn) |
      | 0 1         0           0 cos(Hn)            sin(Hn)           |

et le vecteur Y

      | dH1   |
      | dDEC1 |
      | ...   |
Y = | dHi   |
      | dDECi |
      | ...   |
      | dHn   |
      | dDECn |

On cherche les valeurs des coefficients de la matrice

      | IH |
      | ID |
A = | NP |
      | CH |
      | ME |
      | MA |

telle que Y = X*A

Dans le logiciel AudeLA, on dispose de la librairie
mathématique GSL (GNU Scientific Library) qui permet
de résoudre le système par un algo de moindre carrés
avec la fonction gsl_mfitmultilin. Je renvoie à la
doc de cette fonction dans le manuel de la GSL pour
le développement methématique associé.

IH est le decalage du codeur sur l'axe horaire
ID est le décalage du codeur sur la declinaison
NP est la non perpendicularité de l'axe de déclinaison
CH est l'erreur de collimation
ME est le désalignement N/S de l'axe polaire
MA est le désalignement E/O de l'axe polaire

(ME,MA) peuvent servir à affiner la mise en station
de la monture.

On peut ajouter facilement n'importe quel défaut
au modèle. Dans Aud'ACE/AudeLA on a ajouté les
flexion de fourche et de tube (cf. le script pour
y trouver les formules correspondantes).

5) pointer un astre avec le modele
----------------------------------
Procéder comme pour l'étape 1) pour calculer H,DEC
à partir de RA,DEC,Equinoxe. Puis calculer les coefs
de la matrice x :

x = | 1 0 tan(DEC) 1/cos(DEC) sin(H)*tan(DEC) -cos(H)*tan(DEC) |
      | 0 1        0          0 cos(H)           sin(H)          |

Ensuite, on fait une simple multiplication de matrice :

y = x*A

les valeurs de correction de pointage à apporter
à H,DEC sont dans le vecteur y :

y = | dH   |
      | dDEC |

6) note personnelle
-------------------

Cette méthode est appellée TPOINT et a été décrite
par Patrick Wallace dans différents livres et sur
des sites web. Patrick Wallace vend le code originel
(écrit en fortran) et je crois me rappeler que le
logiciel The Sky en a eu l'exclusivité. Je trouve que
ce comportement est déplorable car il a freiné
indirectement son implémentation dans nos logiciels
préférés. C'est la raison pour laquelle j'expose l'algo le
plus clairement possible afin qu'il soit implanté dans le
maximum de logiciels. "A bas" les passes droits, les algos
privés et les exclusivités ! "la connaissance partagée
par tous", tel est mon crédo... et celui qui nous
uni sur cette liste, j'en suis sur.}

interface

uses u_class;

type
  TCorrection=record
     Latitude:Double;
     DoCH,DoNP,DoMA,DoME,DoTF,DoFO,DoDAF:Boolean; // DoIH,DoID obligatoire
     DoPHH1D0,DoPDH1D0,DoPHH0D1,DoPDH0D1:Boolean;
     DoPHH2D0,DoPDH2D0,DoPHH1D1,DoPDH1D1,DoPHH0D2,DoPDH0D2:Boolean;
     Modele:DoubleArrayRow;
     end;

procedure FitModelePointage(AlphaPoint,DeltaPoint,ErreurAlpha,ErreurDelta:PLigDouble;
                            ndata:Integer;
                            var Correction:TCorrection;
                            var covar:DoubleArray;
                            var chisq:Double);
procedure AppliqueModele(AlphaIn,DeltaIn:Double;var AlphaCorrige,DeltaCorrige:Double;
                         Correction:TCorrection);

implementation

uses math,
     u_math,
     u_constants;
{
Non perpendicualarite des axes Alpha et Delta            :   NP
Polar axis elevation error                               :   ME
Polar axis error east-west                               :   MA

         deltaDelta                                            deltaAlpha
IH       0                                                     1
ID       1                                                     0
CH       0                                                     Sec(Delta)
NP       0                                                     Tan(Delta)
MA       Sin(Alpha)                                            -Cos(Alpha)*Tan(Delta)
ME       Cos(Alpha)                                            Sin(Alpha)*Tan(Delta)
TF       Cos(Lat)*Cos(Alpha)*Sin(Delta)-Sin(Lat)*Cos(Delta)    Cos(Lat)*Sin(Alpha)*Sec(Delta)
FO       Cos(Alpha)                                            0
DAF      0                                                     Cos(Lat)*Cos(Alpha)+Sin(Lat)*Tan(Delta)
}

// Calul des termes de correction
procedure CalcCorrectionAlpha(Alpha,Delta:Double;
                              var PAlpha:DoubleArrayRow;
                              Correction:TCorrection);
var
   k:Integer;
begin
for k:=1 to MaxArray do PAlpha[k]:=0;

Alpha:=Alpha*15*Pi/180;
Delta:=Delta*Pi/180;
with Correction do
   begin
   PAlpha[1]:=1;
   PAlpha[2]:=0;
   k:=2;
   if DoCH then
      begin
      inc(k);
      PAlpha[k]:=1/Cos(Delta); //Sec(Delta)
      end;
   if DoNP then
      begin
      inc(k);
      PAlpha[k]:=Tan(Delta);
      end;
   if DoMA then
      begin
      inc(k);
      PAlpha[k]:=-Cos(Alpha)*Tan(Delta);
      end;
   if DoME then
      begin
      inc(k);
      PAlpha[k]:=Sin(Alpha)*Tan(Delta);
      end;
   if DoTF then
      begin
      inc(k);
      PAlpha[k]:=Cos(Latitude)*Sin(Alpha)/Cos(Delta);
      end;
   if DoFO then
      begin
      inc(k);
      PAlpha[k]:=0;
      end;
   if DoDAF then
      begin
      inc(k);
      PAlpha[k]:=Cos(Latitude)*Cos(Alpha)+Sin(Latitude)*Tan(Delta);
      end;

   // Termes polynomiaux degré 1
   if DoPHH1D0 then
      begin
      inc(k);
      PAlpha[k]:=Alpha;
      end;
   if DoPDH1D0 then
      begin
      inc(k);
      PAlpha[k]:=0;
      end;
   if DoPHH0D1 then
      begin
      inc(k);
      PAlpha[k]:=Delta;
      end;
   if DoPDH0D1 then
      begin
      inc(k);
      PAlpha[k]:=0;
      end;

   // Termes polynomiaux degré 2
   if DoPHH2D0 then
      begin
      inc(k);
      PAlpha[k]:=Sqr(Alpha);
      end;
   if DoPDH2D0 then
      begin
      inc(k);
      PAlpha[k]:=0;
      end;
   if DoPHH1D1 then
      begin
      inc(k);
      PAlpha[k]:=Alpha*Delta;
      end;
   if DoPDH1D1 then
      begin
      inc(k);
      PAlpha[k]:=0;
      end;
   if DoPHH0D2 then
      begin
      inc(k);
      PAlpha[k]:=Sqr(Delta);
      end;
   if DoPDH0D2 then
      begin
      inc(k);
      PAlpha[k]:=0;
      end;

   end;
end;

// Calul des termes de correction
procedure CalcCorrectionDelta(Alpha,Delta:Double;
                              var PDelta:DoubleArrayRow;
                              Correction:TCorrection);
var
   k:Integer;
begin
for k:=1 to MaxArray do PDelta[k]:=0;

Alpha:=Alpha*15*Pi/180;
Delta:=Delta*Pi/180;
with Correction do
   begin
   PDelta[1]:=0;
   PDelta[2]:=1;
   k:=2;
   if DoCH then
      begin
      inc(k);
      PDelta[k]:=0;
      end;
   if DoNP then
      begin
      inc(k);
      PDelta[k]:=0;
      end;
   if DoMA then
      begin
      inc(k);
      PDelta[k]:=Sin(Alpha);
      end;
   if DoME then
      begin
      inc(k);
      PDelta[k]:=Cos(Alpha);
      end;
   if DoTF then
      begin
      inc(k);
      PDelta[k]:=Cos(Latitude)*Cos(Alpha)*Sin(Delta)-Sin(Latitude)*Cos(Delta);
      end;
   if DoFO then
      begin
      inc(k);
      PDelta[k]:=Cos(Alpha);
      end;
   if DoDAF then
      begin
      inc(k);
      PDelta[k]:=0;
      end;

   // Termes polynomiaux degré 1
   if DoPHH1D0 then
      begin
      inc(k);
      PDelta[k]:=0;
      end;
   if DoPDH1D0 then
      begin
      inc(k);
      PDelta[k]:=Alpha;
      end;
   if DoPHH0D1 then
      begin
      inc(k);
      PDelta[k]:=0;
      end;
   if DoPDH0D1 then
      begin
      inc(k);
      PDelta[k]:=Delta;
      end;

   // Termes polynomiaux degré 2
   if DoPHH2D0 then
      begin
      inc(k);
      PDelta[k]:=0;
      end;
   if DoPDH2D0 then
      begin
      inc(k);
      PDelta[k]:=Sqr(Alpha);
      end;
   if DoPHH1D1 then
      begin
      inc(k);
      PDelta[k]:=0;
      end;
   if DoPDH1D1 then
      begin
      inc(k);
      PDelta[k]:=Alpha*Delta;
      end;
   if DoPHH0D2 then
      begin
      inc(k);
      PDelta[k]:=0;
      end;
   if DoPDH0D2 then
      begin
      inc(k);
      PDelta[k]:=Sqr(Delta);
      end;

   end;
end;


// AlphaPoint   : Angle horaire pointé par le scope
// DeltaPoint   : Delta pointé par le scope
// ErreurAlpha  : Erreur de pointage en Angle horaire
// ErreurDelta  : Erreur de pointage en Delta
// a            : coefficients du modele recherche
// covar        : matrice de covariance
// chisq        : chi2
procedure FitModelePointage(AlphaPoint,DeltaPoint,ErreurAlpha,ErreurDelta:PLigDouble;
                            ndata:Integer;
                            var Correction:TCorrection;
                            var covar:DoubleArray;
                            var chisq:Double);
var
k,j,i:Integer;
ym,wt,sum:Double;
beta:DoubleArray;
afunc:DoubleArrayRow;
ma:integer;
begin
// Recherche des dimensions de la matrice principale
ma:=2;
if Correction.DoCH  then inc(ma);
if Correction.DoNP  then inc(ma);
if Correction.DoMA  then inc(ma);
if Correction.DoME  then inc(ma);
if Correction.DoTF  then inc(ma);
if Correction.DoFO  then inc(ma);
if Correction.DoDAF then inc(ma);

if Correction.DoPHH1D0 then inc(ma);
if Correction.DoPDH1D0 then inc(ma);
if Correction.DoPHH0D1 then inc(ma);
if Correction.DoPDH0D1 then inc(ma);

if Correction.DoPHH2D0 then inc(ma);
if Correction.DoPDH2D0 then inc(ma);
if Correction.DoPHH1D1 then inc(ma);
if Correction.DoPDH1D1 then inc(ma);
if Correction.DoPHH0D2 then inc(ma);
if Correction.DoPDH0D2 then inc(ma);

// On initialise la matrice principale et le second terme avec des 0
for j:=1 to ma do
   begin
   for k:=1 to ma do covar[j,k]:=0;
   beta[j,1]:=0;
   end;

// Calcul des coefs
for i:=1 to ndata do
   begin
   CalcCorrectionAlpha(AlphaPoint^[i],DeltaPoint^[i],afunc,Correction);
   ym:=ErreurAlpha^[i];
   for j:=1 to ma do
      begin
      wt:=afunc[j];
      for k:=1 to j do
         covar[j,k]:=covar[j,k]+wt*afunc[k];
      beta[j,1]:=beta[j,1]+ym*wt;
      end;

   CalcCorrectionDelta(AlphaPoint^[i],DeltaPoint^[i],afunc,Correction);
   ym:=ErreurDelta^[i];
   for j:=1 to ma do
      begin
      wt:=afunc[j];
      for k:=1 to j do
         covar[j,k]:=covar[j,k]+wt*afunc[k];
      beta[j,1]:=beta[j,1]+ym*wt;
      end;
   end;
for j:=2 to ma do
   for k:=1 to j-1 do covar[k,j]:=covar[j,k];

// Resolution
gaussj(covar,ma,beta,1);
for j:=1 to ma do
   Correction.Modele[j]:=beta[j,1];

// Calcul du chi2
chisq:=0;
for i:=1 to ndata  do
   begin
   CalcCorrectionAlpha(AlphaPoint^[i],DeltaPoint^[i],afunc,Correction);
   sum:=0;
   for j:=1 to ma do
      sum:=sum+Correction.Modele[j]*afunc[j];
   chisq:=chisq+sqr((ErreurAlpha^[i]-sum));

   CalcCorrectionDelta(AlphaPoint^[i],DeltaPoint^[i],afunc,Correction);
   sum:=0;
   for j:=1 to ma do
      sum:=sum+Correction.Modele[j]*afunc[j];
   chisq:=chisq+sqr((ErreurDelta^[i]-sum));
   end;

end;

// Correction des coordonnees selon le modele de pointage
procedure AppliqueModele(AlphaIn,DeltaIn:Double;var AlphaCorrige,DeltaCorrige:Double;
                         Correction:TCorrection);
var
   ErreurAlpha,ErreurDelta:Double;
   covar:DoubleArray;
   chisq:Double;
   i:Integer;
begin
   AlphaIn:=AlphaIn*15*Pi/180;
   DeltaIn:=DeltaIn*Pi/180;

   ErreurAlpha:=0;
   ErreurDelta:=0;

   ErreurAlpha:=ErreurAlpha+Correction.Modele[1];
   ErreurDelta:=ErreurDelta+Correction.Modele[2];
   i:=2;
   if Correction.DoCH then
      begin
      Inc(i);
      ErreurAlpha:=ErreurAlpha+Correction.Modele[i]/Cos(DeltaIn);
      end;
   if Correction.DoNP then
      begin
      Inc(i);
      ErreurAlpha:=ErreurAlpha+Correction.Modele[i]*Tan(DeltaIn);
      end;
   if Correction.DoMA then
      begin
      Inc(i);
      ErreurAlpha:=ErreurAlpha+Correction.Modele[i]*Cos(AlphaIn)*Tan(DeltaIn);
      ErreurDelta:=ErreurDelta+Correction.Modele[i]*Sin(AlphaIn);
      end;
   if Correction.DoME then
      begin
      Inc(i);
      ErreurAlpha:=ErreurAlpha+Correction.Modele[i]*Sin(AlphaIn)*Tan(DeltaIn);
      ErreurDelta:=ErreurDelta+Correction.Modele[i]*Cos(AlphaIn);
      end;
   if Correction.DoTF then
      begin
      Inc(i);
      ErreurAlpha:=ErreurAlpha+Correction.Modele[i]*Cos(Correction.Latitude)*Sin(AlphaIn)/Cos(DeltaIn);
      ErreurDelta:=ErreurDelta+Correction.Modele[i]*(Cos(Correction.Latitude)*Cos(AlphaIn)*Sin(DeltaIn)
         -Sin(Correction.Latitude)*Cos(DeltaIn));
      end;
   if Correction.DoFO then
      begin
      ErreurDelta:=ErreurDelta+Correction.Modele[i]*Cos(AlphaIn);
      Inc(i);
      end;
   if Correction.DoDAF then
      begin
      Inc(i);
      ErreurAlpha:=ErreurAlpha+Correction.Modele[i]*(Cos(Correction.Latitude)*Cos(AlphaIn)
         +Sin(Correction.Latitude)*Tan(DeltaIn));
      end;

   if Correction.DoPHH1D0 then
      begin
      Inc(i);
      ErreurAlpha:=ErreurAlpha+Correction.Modele[i]*AlphaIn;
      end;
   if Correction.DoPDH1D0 then
      begin
      Inc(i);
      ErreurDelta:=ErreurDelta+Correction.Modele[i]*AlphaIn;
      end;
   if Correction.DoPHH0D1 then
      begin
      inc(i);
      ErreurAlpha:=ErreurAlpha+Correction.Modele[i]*DeltaIn;
      end;
   if Correction.DoPDH0D1 then
      begin
      inc(i);
      ErreurDelta:=ErreurDelta+Correction.Modele[i]*DeltaIn;
      end;

   if Correction.DoPHH2D0 then
      begin
      inc(i);
      ErreurAlpha:=ErreurAlpha+Correction.Modele[i]*Sqr(AlphaIn);
      end;
   if Correction.DoPDH2D0 then
      begin
      inc(i);
      ErreurDelta:=ErreurDelta+Correction.Modele[i]*Sqr(AlphaIn);
      end;
   if Correction.DoPHH1D1 then
      begin
      inc(i);
      ErreurAlpha:=ErreurAlpha-Correction.Modele[i]*AlphaIn*DeltaIn;
      end;
   if Correction.DoPDH1D1 then
      begin
      inc(i);
      ErreurDelta:=ErreurDelta+Correction.Modele[i]*AlphaIn*DeltaIn;
      end;
   if Correction.DoPHH0D2 then
      begin
      inc(i);
      ErreurAlpha:=ErreurAlpha+Correction.Modele[i]*Sqr(DeltaIn);
      end;
   if Correction.DoPDH0D2 then
      begin
      inc(i);
      ErreurDelta:=ErreurDelta+Correction.Modele[i]*Sqr(DeltaIn);
      end;

//   AlphaCorrige:=AlphaIn*180/Pi/15+ErreurAlpha/3600/15;
//   DeltaCorrige:=DeltaIn*180/Pi+ErreurDelta/3600;
   AlphaCorrige:=AlphaIn*180/Pi/15+ErreurAlpha/15;
   DeltaCorrige:=DeltaIn*180/Pi+ErreurDelta;
end;

end.



