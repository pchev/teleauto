unit u_astrometrie;

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

uses u_class, pu_rapport, Classes, ShellApi, Forms;

procedure FitAstrometrie(x,y,x1,x2,SigX,SigY:PLigDouble;
                         NbStar:Integer;
                         var AstrometrieInfos:TAstrometrieInfos;
                         var ResidusFit,ResidusFitX,ResidusFitY:PLigDouble);

function CalibAstrom(ImgInt:PTabImgInt;
                     ImgDouble:PTabImgDouble;
                     TypeData,NbPlans:Byte;
                     Sx,Sy:Integer;
                     var AstrometrieInfos:TAstrometrieInfos;
                     Rapport:tpop_rapport;
                     var Gagnants:TList):Boolean;

implementation

uses Catalogues,
     SysUtils,
     u_lang,
     u_meca,
     u_general,
     u_modelisation,
     u_constants,
     u_math,
     pu_dessin;

// Régression adaptée à l'astrométrie
procedure FitAstrometrie(x,y,x1,x2,SigX,SigY:PLigDouble;
                         NbStar:Integer;
                         var AstrometrieInfos:TAstrometrieInfos;
                         var ResidusFit,ResidusFitX,ResidusFitY:PLigDouble);
var
   i:Integer;
   XProj,YProj:Double;
begin
// Recherche du polynôme de passage en X
lfitAstro(x1,x2,x,SigX,NbStar,AstrometrieInfos.PolyX,AstrometrieInfos.CovarX,AstrometrieInfos.ChisqX,
   AstrometrieInfos.DegrePoly);
//SvdFitAstro(x1,x2,x,SigX,NbStarGagnant,AstrometrieInfos.PolyX,u,v,w,ChisqX,Degre);
//SvdVarAstro(v,w,CovarX,Degre);

// Recherche du polynôme de passage en Y
lfitAstro(x1,x2,y,SigY,NbStar,AstrometrieInfos.PolyY,AstrometrieInfos.CovarY,AstrometrieInfos.ChisqY,
   AstrometrieInfos.DegrePoly);
//SvdFitAstro(x1,x2,y,SigY,NbStarGagnant,AstrometrieInfos.PolyY,u,v,w,ChisqY,Degre);
//SvdVarAstro(v,w,CovarY,Degre);

// Calcul des residus
AstrometrieInfos.ResiduX:=0;
AstrometrieInfos.ResiduY:=0;
for i:=1 to NbStar do
   begin
   XProj:=CalcPolynomeXY(x1^[i],x2^[i],AstrometrieInfos.PolyX,AstrometrieInfos.DegrePoly);
   YProj:=CalcPolynomeXY(x1^[i],x2^[i],AstrometrieInfos.PolyY,AstrometrieInfos.DegrePoly);
   AstrometrieInfos.ResiduX:=AstrometrieInfos.ResiduX+Sqr(x^[i]-XProj);
   AstrometrieInfos.ResiduY:=AstrometrieInfos.ResiduY+Sqr(y^[i]-YProj);
//   ResidusFit^[i]:=Sqrt(Sqr(x^[i]-XProj)+Sqr(y^[i]-YProj));
   ResidusFitX^[i]:=x^[i]-XProj;
   ResidusFitY^[i]:=y^[i]-YProj;
   ResidusFit^[i]:=Sqrt(Sqr(ResidusFitX^[i])+Sqr(ResidusFitY^[i]));
   end;

end;

function CalibAstrom(ImgInt:PTabImgInt;
                     ImgDouble:PTabImgDouble;
                     TypeData,NbPlans:Byte;
                     Sx,Sy:Integer;
                     var AstrometrieInfos:TAstrometrieInfos;
                     Rapport:tpop_rapport;
                     var Gagnants:TList):Boolean;
var
   USNOARecord:USNOARec;
   GSCCRecord:GSCCrec;
   GSCFRecord:GSCFrec;
   TY2Record:TY2rec;
   MCTRecord:MCTrec;
   BSCRecord:BSCrec;
   SMnum:shortstring;
   ncat :integer;

   AlphaMin,AlphaMax,DeltaMin,DeltaMax:Double;
   OK:Boolean;

   FirstRequest,RequestCourant,OldRequest:PRequestStar;
   FirstRequest2,RequestCourant2,OldRequest2:PRequestStar;
   i,j,k,NbRequest,NbStarCat,NBStarImg,NbStarGagnant:Integer;
   ListePSFCat,ListePSFImg:PListePSF;
   Diagonale,XPos,YPos,XProj,YProj:Double;
   Error:Byte;

   CovarX,CovarY:DoubleArray;
   Chisq:array[1..5] of Double;
   ChisqX,ChisqY,Min:Double;
   Degre,DegreMax,Ma:Integer;

   NbMatch:Integer;
//   FirstMatch,MatchCourant,OldMatch:PMatchStar;
   NbToSupprimer:Integer;

   NBStarCat2:Integer;
   ListePSFCat2:PListePSF;

   // svd
   u,v,cvm:DoubleArray;
   w:DoubleArrayRow;

   m:p_matcher;                                 // pointeur sur un element de vote

   x,y,x1,x2,SigX,SigY:PLigDouble;
   xp,yp,x1p,x2p,SigXp,SigYp:PLigDouble;   
   ResidusFit,ResidusFitX,ResidusFitY:PLigDouble;
   AstrometrieInfosInverse:TAstrometrieInfos;
   p:p_matcher;
   ResiduMax,MaxPix:Double;
   PosMax,NbStarFit:Integer;
   StrCata:string;

   PosX,PosY,DemiLarg,Larg,l:Integer;
   ImgInt2:PTabImgInt;
   ImgDouble2:PTabImgDouble;
   PSF:TPSF;
   NbMatchBest:Integer;
begin
// Par défaut c'est loupé ! Booouuuuh !
Result:=False;

Getmem(FirstRequest,Sizeof(TRequestStar));
Getmem(FirstRequest2,Sizeof(TRequestStar));
//Getmem(FirstMatch,Sizeof(TMatchStar));

try

// ****************************************************
//          Recherche dans les catalogues
// ****************************************************
Rapport.AddLine(lang('Recherche des étoiles dans les catalogues'));

// Diagonale en mètres * 10%
//Diagonale:=Sqrt(Sqr(AstrometrieInfos.Sx)+Sqr(AstrometrieInfos.Sy))*AstrometrieInfos.TaillePixel/1000000*1.1;
if AstrometrieInfos.TaillePixelX>AstrometrieInfos.TaillePixelY then
   MaxPix:=AstrometrieInfos.TaillePixelX
else
   MaxPix:=AstrometrieInfos.TaillePixelY;
Diagonale:=Sqrt(Sqr(AstrometrieInfos.Sx)+Sqr(AstrometrieInfos.Sy))*MaxPix*1.1/1000000;

// Diagonale en dégres
Diagonale:=ArcTan(Diagonale/AstrometrieInfos.Focale*1000)/pi*180;
// Alpha en heures
AlphaMin:=AstrometrieInfos.Alpha0-Diagonale/2/15;
AlphaMax:=AstrometrieInfos.Alpha0+Diagonale/2/15;
// Delta en degrés
DeltaMin:=AstrometrieInfos.Delta0-Diagonale/2;
DeltaMax:=AstrometrieInfos.Delta0+Diagonale/2;

NbRequest:=0;
RequestCourant:=FirstRequest;
if AstrometrieInfos.USNOSelected then
   begin
   OpenUSNOA(AlphaMin,AlphaMax,DeltaMin,DeltaMax,OK);
   if OK then
      repeat
      ReadUSNOA(USNOARecord,OK);
      if OK then
         begin
         Inc(NbRequest);
         RequestCourant.Alpha:=USNOARecord.ar;
         RequestCourant.Delta:=USNOARecord.de;
         RequestCourant.Mag:=USNOARecord.mr; // Rouge
         RequestCourant.Catalogue:=4;
         Getmem(RequestCourant.Suivant,Sizeof(TRequestStar));
         RequestCourant:=RequestCourant.Suivant;
         end;
      until not OK;
   CloseUSNOA;
   end;
if AstrometrieInfos.BSCSelected then
   begin
   OpenBSC(AlphaMin,AlphaMax,DeltaMin,DeltaMax,OK);
   if OK then
      repeat
      ReadBSC(BSCRecord,OK);
      if OK then
         begin
         Inc(NbRequest);
         RequestCourant.Alpha:=BSCRecord.ar/100000/15; //degre*100 -> heures
         RequestCourant.Delta:=BSCRecord.de/100000;
         RequestCourant.Mag:=BSCRecord.mv/100; // Mag visuelle*100
         RequestCourant.Catalogue:=5;
         Getmem(RequestCourant.Suivant,Sizeof(TRequestStar));
         RequestCourant:=RequestCourant.Suivant;
         end;
      until not OK;
   CloseBSC;
   end;
if AstrometrieInfos.GSCCSelected then
   begin
   case AstrometrieInfos.TypeGSC of
      0:begin
        OpenGSCC(AlphaMin,AlphaMax,DeltaMin,DeltaMax,OK);
        if OK then
           repeat
           ReadGSCC(GSCCRecord,SMnum,OK);
           if OK then
              begin
              Inc(NbRequest);
              RequestCourant.Alpha:=GSCCRecord.ar/15; // Degres -> heures
              RequestCourant.Delta:=GSCCRecord.de;
              RequestCourant.Mag:=GSCCRecord.m;
              RequestCourant.Catalogue:=3;
              Getmem(RequestCourant.Suivant,Sizeof(TRequestStar));
              RequestCourant:=RequestCourant.Suivant;
              end;
           until not OK;
        CloseGSCC;
        end;
      1:begin
        OpenGSCF(AlphaMin,AlphaMax,DeltaMin,DeltaMax,OK);
        if OK then
           repeat
           ReadGSCF(GSCFRecord,SMnum,OK);
           if OK then
              begin
              Inc(NbRequest);
              RequestCourant.Alpha:=GSCFRecord.ar/15; // Degres -> heures
              RequestCourant.Delta:=GSCFRecord.de;
              RequestCourant.Mag:=GSCFRecord.m;
              RequestCourant.Catalogue:=2;
              Getmem(RequestCourant.Suivant,Sizeof(TRequestStar));
              RequestCourant:=RequestCourant.Suivant;
              end;
           until not OK;
        CloseGSCF;
        end;
      end;
   end;
if AstrometrieInfos.TY2Selected then
   begin
   ncat:=2;
   OpenTY2(AlphaMin,AlphaMax,DeltaMin,DeltaMax,ncat,OK);
   if OK then
      repeat
      ReadTY2(TY2Record,SMnum,OK);
      if OK then
         begin
         Inc(NbRequest);
         RequestCourant.Alpha:=TY2Record.ar/15; // Degres -> heures
         RequestCourant.Delta:=TY2Record.de;
         RequestCourant.Mag:=TY2Record.VT;
         RequestCourant.Catalogue:=6;
         Getmem(RequestCourant.Suivant,Sizeof(TRequestStar));
         RequestCourant:=RequestCourant.Suivant;
         end;
      until not OK;
   CloseTY2;
   end;
if AstrometrieInfos.MCT3Selected then
   begin
   OpenMCT(AlphaMin,AlphaMax,DeltaMin,DeltaMax,3,OK);
   if OK then
      repeat
      ReadMCT(MCTRecord,OK);
      if OK then
         begin
         Inc(NbRequest);
         RequestCourant.Alpha:=MCTRecord.ar;
         RequestCourant.Delta:=MCTRecord.de;
         RequestCourant.Mag:=MCTRecord.mr;
         RequestCourant.Catalogue:=1;
         Getmem(RequestCourant.Suivant,Sizeof(TRequestStar));
         RequestCourant:=RequestCourant.Suivant;
         end;
      until not OK;
   CloseMCT;
   end;


// ****************************************************
//          Recherche des etoiles du cataloque
// ****************************************************
Diagonale:=Sqrt(Sqr(AstrometrieInfos.Sx)+Sqr(AstrometrieInfos.Sy));
NbStarCat:=0;
RequestCourant2:=FirstRequest2;
RequestCourant:=FirstRequest;
for i:=1 to NBRequest do
   begin
   AlphaDeltaToXY(AstrometrieInfos.Alpha0,AstrometrieInfos.Delta0,
                  RequestCourant.Alpha,RequestCourant.Delta,XPos,YPos);
   XPos:=XPos*AstrometrieInfos.Focale/1000/AstrometrieInfos.TaillePixelX*1e6;
   YPos:=YPos*AstrometrieInfos.Focale/1000/AstrometrieInfos.TaillePixelY*1e6;
   if Sqrt(XPos*XPos+YPos*YPos)<Diagonale*0.6 then
      begin
      Inc(NbStarCat);
      RequestCourant2.Alpha:=RequestCourant.Alpha;
      RequestCourant2.Delta:=RequestCourant.Delta;
      RequestCourant2.Mag:=RequestCourant.Mag;
      RequestCourant2.Catalogue:=RequestCourant.Catalogue;
      Getmem(RequestCourant2.Suivant,Sizeof(TRequestStar));
      RequestCourant2:=RequestCourant2.Suivant;
      end;
   RequestCourant:=RequestCourant.Suivant;
   end;

Rapport.AddLine('Nombre d''étoiles trouvées dans les catalogues : '+IntToStr(NBStarCat));
Rapport.AddLine(' ');

Getmem(ListePSFCat,NBStarCat*Sizeof(TPSF));
try

// ****************************************************
//          Projection des etoiles du cataloque
// ****************************************************
Rapport.AddLine(lang('Projection des étoiles des catalogues'));
Rapport.AddLine(' ');
RequestCourant2:=FirstRequest2;
for i:=1 to NBStarCat do
   begin
//   Sphere2Plan(RequestCourant2.Alpha,RequestCourant2.Delta,
//               AstrometrieInfos.Alpha0,AstrometrieInfos.Delta0,
//               ListePSFCat^[i].X,ListePSFCat^[i].Y);
   AlphaDeltaToXY(AstrometrieInfos.Alpha0,AstrometrieInfos.Delta0,
                  RequestCourant2.Alpha,RequestCourant2.Delta,
                  ListePSFCat^[i].X,ListePSFCat^[i].Y);
   ListePSFCat^[i].Mag:=RequestCourant2.Mag;
   ListePSFCat^[i].Catalogue:=RequestCourant2.Catalogue;
   // Perunitage
   ListePSFCat^[i].X:=ListePSFCat^[i].X*AstrometrieInfos.Focale/1000/AstrometrieInfos.TaillePixelX*1e6;
   ListePSFCat^[i].Y:=ListePSFCat^[i].Y*AstrometrieInfos.Focale/1000/AstrometrieInfos.TaillePixelY*1e6;
   ListePSFCat^[i].Flux:=Exp((14-ListePSFCat^[i].Mag)/2.5*ln(10))*1000;
   ListePSFCat^[i].Alpha:=RequestCourant2.Alpha;
   ListePSFCat^[i].Delta:=RequestCourant2.Delta;
   RequestCourant2:=RequestCourant2.Suivant;
   end;

// *********************************************
//          Supression des doublons
// *********************************************
Rapport.AddLine(lang('Suppression des doublons dans les catalogues'));
Rapport.AddLine(' ');
// Marquage
NbToSupprimer:=0;
for i:=1 to NBStarCat do
   for j:=1 to NBStarCat do
      if (Sqrt(Sqr(ListePSFCat^[i].X-ListePSFCat^[j].X)+Sqr(ListePSFCat^[i].Y-ListePSFCat^[j].Y))<1)
         and (i<>j) and (ListePSFCat^[i].Flux<>-1) and (ListePSFCat^[j].Flux<>-1) then
         begin
         if ListePSFCat^[j].Catalogue>ListePSFCat^[i].Catalogue then ListePSFCat^[i].Flux:=-1
         else if ListePSFCat^[j].Catalogue<ListePSFCat^[i].Catalogue then ListePSFCat^[j].Flux:=-1
         else
            begin
            if ListePSFCat^[j].Flux>ListePSFCat^[i].Flux then // Marquage a supprimer
               ListePSFCat^[i].Flux:=-1 else ListePSFCat^[j].Flux:=-1;
            end;
         Inc(NbToSupprimer);
         end;
// Suppression
NBStarCat2:=(NBStarCat-NbToSupprimer);
Getmem(ListePSFCat2,NBStarCat2*Sizeof(TPSF));

Rapport.AddLine('Nombre d''étoiles trouvées dans les catalogues : '+IntToStr(NBStarCat2));
Rapport.AddLine(' ');

if NBStarCat2<4 then
   begin
   Rapport.AddLine(lang('Pas assez d''étoiles dans les catalogues'));
   raise ErrorMatching.Create(lang('Pas assez d''étoiles dans les catalogues'));
   end;

try
Rapport.AddLine(lang('Liste des étoiles dans les catalogues'));
Rapport.AddLine(lang('    Alpha    Delta    Magnitude    X        Y      Catalogue'));
j:=0;
for i:=1 to NBStarCat do
   if ListePSFCat^[i].Flux<>-1 then
      begin
      Inc(j);
      ListePSFCat2^[j].X:=ListePSFCat^[i].X;
      ListePSFCat2^[j].Y:=ListePSFCat^[i].Y;
      ListePSFCat2^[j].Mag:=ListePSFCat^[i].Mag;
      ListePSFCat2^[j].Flux:=ListePSFCat^[i].Flux;
      ListePSFCat2^[j].Catalogue:=ListePSFCat^[i].Catalogue;      
      case ListePSFCat2^[j].Catalogue of
         1:StrCata:='Microcat'; //nolang
         2:StrCata:='GSC 1.1'; //nolang
         3:StrCata:='GSC ACT'; //nolang
         4:StrCata:='USNO'; //nolang
         5:StrCata:='BSC'; //nolang
         6:StrCata:='Tycho2'; //nolang
         end;
      Rapport.AddLine(Format('%10s %10s %8.3f %8.3f %8.3f %s',[AlphaToStrAstrom(ListePSFCat^[i].Alpha), //nolang
         DeltaToStrAstrom(ListePSFCat^[i].Delta),ListePSFCat^[i].Mag,ListePSFCat^[i].X,ListePSFCat^[i].Y,StrCata]));
      end;
Rapport.AddLine(' ');

// ****************************************************
//          Recherche des étoiles de l'image
// ****************************************************
Rapport.AddLine(lang('Modélisation des étoiles de l''image à calibrer'));

//if AstrometrieInfos.HighPrecision then
   ModeliseSources(ImgInt,ImgDouble,TypeData,NbPlans,Sx,Sy,15,ListePSFImg,TGauss,
      LowPrecision,MeanSelect,NbStarImg,15,false,'',False);
//else
//   ModeliseSources(ImgInt,ImgDouble,TypeData,NbPlans,Sx,Sy,15,ListePSFImg,TGauss,
//      LowPrecision,HighSelect,NbStarImg,15,false,'',False);

Rapport.AddLine(lang('Nombres d''étoiles de l''image : ')+IntToStr(NbStarImg));
Rapport.AddLine(' ');

Rapport.AddLine(' X         Y           Flux'); //nolang
for i:=1 to NBStarImg do
   if ListePSFImg^[i].Flux<>-1 then
      begin
      ListePSFImg^[i].X:=ListePSFImg^[i].X-AstrometrieInfos.Sx div 2;
      ListePSFImg^[i].Y:=ListePSFImg^[i].Y-AstrometrieInfos.Sy div 2;
      Rapport.AddLine(Format('%8.3f %8.3f %14f',[ListePSFImg^[i].X,ListePSFImg^[i].Y,ListePSFImg^[i].Flux])); //nolang
      end;
Rapport.AddLine(' ');

if NBStarImg<4 then
   begin
   Rapport.AddLine(lang('Pas assez d''étoiles dans l''image'));
   raise ErrorMatching.Create(lang('Pas assez d''étoiles dans l''image'));
   end;

try

// ****************************************************
//          Matching des deux listes d'etoiles
// ****************************************************
Rapport.AddLine(lang('Mise en correspondance des deux listes d''étoiles'));
Rapport.AddLine(' ');
//Error:=Match(ListePSFImg,ListePSFCat,NbStarImg,NBStarCat,40,Gagnants,Rapport);
Error:=MatchMarty(ListePSFImg,ListePSFCat,NbStarImg,NBStarCat,60,Gagnants,Rapport);

// C'est foutu, faudrais essayer d'augmenter le nombre d'étoiles à matcher
// => mise en parametre du nombre d'étoiles
if Gagnants.Count<4 then
   begin
   Rapport.AddLine(' ');
   Rapport.AddLine('Pas assez d''étoiles en correspondance');
   raise ErrorMatching.Create('Pas assez d''étoiles en correspondance');
   end;

// On pose le probleme
// Le probleme est que les faux matchs font que l'on a des polynomes faux.
// Question : Il faut donc detecter les faux matchs comment ?
// Reponse : En comptant le nombre de match de la secondes passe !!!!

// Deuxieme passe pour collecter un max d'etoiles matchées
// Pourquoi ca merde sur certaines images ?????? Ex : M108/M57
// Parce que le polynome est dans les choux a cause de trop de faux matchs
// =>  il faut reduire les faux matchs
Rapport.AddLine(' ');
Rapport.AddLine(lang('Deuxième passe de collecte de correspondances'));
Rapport.AddLine(' ');
NbStarGagnant:=Gagnants.Count;

// Allocation des tableaux pour le fit
NbStarFit:=NbStarGagnant;
Getmem(x,8*NbStarFit);
Getmem(y,8*NbStarFit);
Getmem(x1,8*NbStarFit);
Getmem(x2,8*NbStarFit);
Getmem(Sigx,8*NbStarFit);
Getmem(Sigy,8*NbStarFit);
Getmem(ResidusFit,8*NbStarFit);
Getmem(ResidusFitX,8*NbStarFit);
Getmem(ResidusFitY,8*NbStarFit);

try

// Detection et elimination des faux matchs
if NbStarGagnant>=4 then
   begin
   // Premier fit

   // Changement de forme des donnees
   for i:=0 to NbStarGagnant-1 do
      begin
      m:=gagnants[i];
      x1^[i+1]:=m.ref_x;  // Ref est le premier dans la fonction match donc c'est l'image
      x2^[i+1]:=m.ref_y;
      x^[i+1]:=m.det_x;   // Det est le deuxieme dans la fonction match donc c'est le catalogue projeté
      y^[i+1]:=m.det_y;
      SigX^[i+1]:=1;      // Connait pas l'incertitude du catalogue !
      SigY^[i+1]:=1;
      end;

   // On fite sur un degre 1
   AstrometrieInfos.DegrePoly:=1;
   FitAstrometrie(x,y,x1,x2,SigX,SigY,NbStarGagnant,AstrometrieInfos,ResidusFit,ResidusFitX,ResidusFitY);

   // On recherche du nombre de match dans la deuxieme passe
   NbMatch:=0;
   for i:=1 to NbStarImg do
      begin
      XProj:=CalcPolynomeXY(ListePSFImg[i].X,ListePSFImg[i].Y,AstrometrieInfos.PolyX,1);
      YProj:=CalcPolynomeXY(ListePSFImg[i].X,ListePSFImg[i].Y,AstrometrieInfos.PolyY,1);
      for j:=1 to NbStarCat2 do
         if (Abs(XProj-ListePSFCat2[j].X)<1) and (Abs(YProj-ListePSFCat2[j].Y)<1) then Inc(NbMatch);
      end;

   Rapport.AddLine(' ');
   Rapport.AddLine(lang('Nombre de matches deuxième passe : ')+IntToStr(NbMatch));
   Rapport.AddLine(' ');

   // Tant que le nombre de match de la deuxieme passe est insufisant on supprime le match
   // de le premiere passe avec le plus grand residu
   while (NbMatch<4) and (NbStarGagnant>=4) do
      begin
      Rapport.AddLine(' ');
      Rapport.AddLine(lang('Il y a des faux matches, on tente des les supprimmer'));
      Rapport.AddLine(' ');

      // On cherche le residu Max
      ResiduMax:=MinDouble;
      for k:=1 to NbStarGagnant do
         begin
         if ResidusFit^[k]>ResiduMax then
            begin
            ResiduMax:=ResidusFit^[k];
            PosMax:=k;
            end;
         end;
      // On le supprimme
      for k:=PosMax to NbStarGagnant-1 do
         begin
         x1^[k]:=x1^[k+1];
         x2^[k]:=x2^[k+1];
         x^[k]:=x^[k+1];
         y^[k]:=y^[k+1];
         ResidusFit^[k]:=ResidusFit^[k+1];
         ResidusFitX^[k]:=ResidusFitX^[k+1];
         ResidusFitY^[k]:=ResidusFitY^[k+1];
         end;
      Dec(NbStarGagnant);

      Rapport.AddLine(' ');
      Rapport.AddLine(lang('Nombre de matches aprés élimination : ')+IntToStr(NbStarGagnant));
      Rapport.AddLine(' ');

      // On refitte
      FitAstrometrie(x,y,x1,x2,SigX,SigY,NbStarGagnant,AstrometrieInfos,ResidusFit,ResidusFitX,ResidusFitY);

      // On recherche du nombre de match dans la deuxieme passe
      NbMatch:=0;
      for i:=1 to NbStarImg do
         begin
         XProj:=CalcPolynomeXY(ListePSFImg[i].X,ListePSFImg[i].Y,AstrometrieInfos.PolyX,1);
         YProj:=CalcPolynomeXY(ListePSFImg[i].X,ListePSFImg[i].Y,AstrometrieInfos.PolyY,1);
         for j:=1 to NbStarCat2 do
            if (Abs(XProj-ListePSFCat2[j].X)<1) and (Abs(YProj-ListePSFCat2[j].Y)<1) then Inc(NbMatch);
         end;

      Rapport.AddLine(' ');
      Rapport.AddLine(lang('Nombre de matches deuxième passe : ')+IntToStr(NbMatch));
      Rapport.AddLine(' ');
      end;
   end;

// C'est foutu, y a plus rien a faire
if NbMatch<4 then
   begin
   Rapport.AddLine(' ');
   Rapport.AddLine('Pas assez d''étoiles en correspondance');
   raise ErrorMatching.Create('Pas assez d''étoiles en correspondance');
   end;

// Les faux matchs sont éliminés
// On a le tableau de gagnants definitif
// On fait la deuxieme passe qui contient NbMatch match
Getmem(xp,8*NbMatch);
Getmem(yp,8*NbMatch);
Getmem(x1p,8*NbMatch);
Getmem(x2p,8*NbMatch);
Getmem(Sigxp,8*NbMatch);
Getmem(Sigyp,8*NbMatch);

try

// On fait la deuxieme passe
k:=0;
for i:=1 to NbStarImg do
   begin
   XProj:=CalcPolynomeXY(ListePSFImg[i].X,ListePSFImg[i].Y,AstrometrieInfos.PolyX,1);
   YProj:=CalcPolynomeXY(ListePSFImg[i].X,ListePSFImg[i].Y,AstrometrieInfos.PolyY,1);
   for j:=1 to NbStarCat2 do
      begin
      if (Abs(XProj-ListePSFCat2[j].X)<1) and (Abs(YProj-ListePSFCat2[j].Y)<1) then
         begin
         Inc(k);
         x1p^[k]:=ListePSFImg[i].X;  // Ref est le premier dans la fonction match donc c'est l'image
         x2p^[k]:=ListePSFImg[i].Y;
         xp^[k]:=ListePSFCat2[j].X;   // Det est le deuxieme dans la fonction match donc c'est le catalogue projeté
         yp^[k]:=ListePSFCat2[j].Y;
         SigXp^[k]:=1;      // Connait pas l'incertitude du catalogue !
         SigYp^[k]:=1;
         end;
      end;
   end;

// On remodélise les étoiles qui restent avec une grande précision
// Pour éliminer celle dont la position est minable
NbMatchBest:=NbMatch;
if AstrometrieInfos.HighPrecision then
   begin
   Rapport.AddLine(' ');
   Rapport.AddLine(lang('Troisième passe d''élimination des étoiles peu précises (Haute précision)'));
   Rapport.AddLine(' ');

   DemiLarg:=15;
   Larg:=2*DemiLarg+1;

   case TypeData of
      2,7:begin
          Getmem(ImgInt2,4);
          Getmem(ImgInt2^[1],4*(2*DemiLarg+1));
          for i:=1 to (2*DemiLarg+1) do Getmem(ImgInt2^[1]^[i],2*(2*DemiLarg+1));
          end;
      5,6,8:begin
            Getmem(ImgDouble2,4);
            Getmem(ImgDouble2^[1],4*(2*DemiLarg+1));
            for i:=1 to (2*DemiLarg+1) do Getmem(ImgDouble2^[1]^[i],8*(2*DemiLarg+1));
            end;
      end;

   try

//   i:=1;
//   while i<=NbMatchBest do
   for i:=1 to NbMatchBest do
      begin
      PosX:=Round(x1p^[i]+AstrometrieInfos.Sx div 2);
      PosY:=Round(x2p^[i]+AstrometrieInfos.Sy div 2);
      if (PosX>DemiLarg) and (PosX<Sx-DemiLarg) and (PosY>DemiLarg) and (PosY<Sy-DemiLarg) then
         begin
         case TypeData of
            2,7:begin
                for j:=-DemiLarg to DemiLarg do
                  for k:=-DemiLarg to DemiLarg do
                      ImgInt2^[1]^[DemiLarg+1+j]^[DemiLarg+1+k]:=ImgInt^[1]^[PosY+j]^[PosX+k];
                end;
            5,6,8:begin
                  for j:=-DemiLarg to DemiLarg do
                     for k:=-DemiLarg to DemiLarg do
                        ImgDouble2^[1]^[DemiLarg+1+j]^[DemiLarg+1+k]:=ImgDouble^[1]^[PosY+j]^[PosX+k];
                  end;
            end;

//         ModeliseEtoile(ImgInt2,ImgDouble2,TypeData,Larg,DemiLarg,DemiLarg,TGaussEllipse,HighPrecision,HighSelect,1,PSF);
         ModeliseEtoile(ImgInt2,ImgDouble2,TypeData,Larg,TGaussEllipse,HighPrecision,HighSelect,1,PSF);

         if (PSF.Flux<>-1) then
            begin
            x1p^[i]:=PSF.X+PosX-DemiLarg-1;
            x2p^[i]:=PSF.Y+PosY-DemiLarg-1;
            Rapport.AddLine(IntToStr(i)+'/'+MyFloatToStr(x1p^[i],3)+'/'+MyFloatToStr(x2p^[i],3)+'/'+
               MyFloatToStr(PSF.DX,6)+'/'+MyFloatToStr(PSF.DY,6));
            x1p^[i]:=x1p^[i]-AstrometrieInfos.Sx div 2;
            x2p^[i]:=x2p^[i]-AstrometrieInfos.Sy div 2;
            end
         else
            begin
            Rapport.AddLine(IntToStr(i)+'/'+MyFloatToStr(PSF.X+PosX-DemiLarg-1,3)
                 +'/'+MyFloatToStr(PSF.Y+PosY-DemiLarg-1,3)+lang(' Modélisation imprécise => Etoile ignorée'));
            // On le supprimme
            for l:=i to NbMatch-1 do
               begin
               x1p^[l]:=x1p^[l+1];
               x2p^[l]:=x2p^[l+1];
               xp^[l]:=xp^[l+1];
               yp^[l]:=yp^[l+1];
               end;
            Dec(NbMatchBest);
            end;
         end
      else
         begin
         Rapport.AddLine(IntToStr(i)+'/'+MyFloatToStr(PSF.X+PosX-DemiLarg-1,3)
            +'/'+MyFloatToStr(PSF.Y+PosY-DemiLarg-1,3)+lang(' Trop au bord => Etoile ignorée'));
         PSF.Flux:=-1;
         // On le supprimme
         for l:=i to NbMatch-1 do
            begin
            x1p^[l]:=x1p^[l+1];
            x2p^[l]:=x2p^[l+1];
            xp^[l]:=xp^[l+1];
            yp^[l]:=yp^[l+1];
            end;
         Dec(NbMatchBest);
         end;

//      inc(i);
      end;

   Rapport.AddLine('Nombre d''étoiles restantes = '+IntToStr(NbMatchBest));

   finally
   case TypeData of
      2,7:begin
          for i:=1 to (2*DemiLarg+1) do Freemem(ImgInt2^[1]^[i],2*(2*DemiLarg+1));
          Freemem(ImgInt2^[1],4*(2*DemiLarg+1));
          Freemem(ImgInt2,4);
          end;
      5,6,8:begin
            for i:=1 to (2*DemiLarg+1) do Freemem(ImgDouble2^[1]^[i],8*(2*DemiLarg+1));
            Freemem(ImgDouble2^[1],4*(2*DemiLarg+1));
            Freemem(ImgDouble2,4);
            end;
      end;

   end;

   end;

// On repasse dans les gagnants
Gagnants.Clear;
for i:=1 to NBMatchBest do
   begin
   New(p);
   p.ref_x :=x1p^[i];
//      p.ref_dx:=MatchCourant.DxImg;
   p.ref_y :=x2p^[i];
//      p.ref_dy:=MatchCourant.DxImg;
   p.det_x :=xp^[i];
   p.det_dx:=1;
   p.det_y :=yp^[i];
   p.det_dy:=1;
   Gagnants.Add(p);
   end;


finally
Freemem(xp,8*NbMatch);
Freemem(yp,8*NbMatch);
Freemem(x1p,8*NbMatch);
Freemem(x2p,8*NbMatch);
Freemem(Sigxp,8*NbMatch);
Freemem(Sigyp,8*NbMatch);
end;

finally
// Liberation des tableaux
Freemem(x,8*NbStarFit);
Freemem(y,8*NbStarFit);
Freemem(x1,8*NbStarFit);
Freemem(x2,8*NbStarFit);
Freemem(Sigx,8*NbStarFit);
Freemem(Sigy,8*NbStarFit);
Freemem(ResidusFit,8*NbStarFit);
Freemem(ResidusFitX,8*NbStarFit);
Freemem(ResidusFitY,8*NbStarFit);
end;

finally
Freemem(ListePSFImg,NBStarImg*Sizeof(TPSF));
end;

finally
Freemem(ListePSFCat2,NBStarCat2*Sizeof(TPSF));
end;

finally
Freemem(ListePSFCat,NBStarCat*Sizeof(TPSF));
end;

finally
{MatchCourant:=FirstMatch;
for i:=1 to NBMatch do
   begin
   OldMatch:=MatchCourant;
   MatchCourant:=MatchCourant.Suivant;
   Freemem(OldMatch,Sizeof(TMatchStar));
   end;}

RequestCourant:=FirstRequest;
for i:=1 to NBRequest do
   begin
   OldRequest:=RequestCourant;
   RequestCourant:=RequestCourant.Suivant;
   Freemem(OldRequest,Sizeof(TRequestStar));
   end;

RequestCourant2:=FirstRequest2;
for i:=1 to NBStarCat do
   begin
   OldRequest2:=RequestCourant2;
   RequestCourant2:=RequestCourant2.Suivant;
   Freemem(OldRequest2,Sizeof(TRequestStar));
   end;

end;

end;


end.
