unit u_geometrie;

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

// Fonctions de manipulation géometriques des images

interface

uses u_class, classes, sysutils, pu_rapport, pu_image;

procedure GetImgPart(ImgIntIn:PTabImgInt;
                     ImgDoubleIn:PTabImgDouble;
                     var ImgIntOut:PTabImgInt;
                     var ImgDoubleOut:PTabImgDouble;
                     TypeData,NbPlans:Byte;
                     Sx,Sy,X1,Y1,X2,Y2:Integer);
procedure Binning(var ImgIntIn:PTabImgInt;
                  var ImgDoubleIn:PTabImgDouble;
                  var Sx,Sy:Integer;
                  TypeData,NbPlans:Byte;
                  BinningX,BinningY:Integer);
procedure ZoomBilineaire(var ImgIntIn:PTabImgInt;
                         var ImgDoubleIn:PTabImgDouble;
                         var Sx,Sy:Integer;
                         TypeData,NbPlans:Byte;
                         FacteurX,FacteurY:Double);
procedure ZoomSpline(var ImgIntIn:PTabImgInt;
                     var ImgDoubleIn:PTabImgDouble;
                     var Sx,Sy:Integer;
                     TypeData,NbPlans:Byte;
                     FacteurX,FacteurY:Double);
procedure Translation(var ImgIntIn:PTabImgInt;
                      var ImgDoubleIn:PTabImgDouble;
                      var Sx,Sy:Integer;
                      TypeData,NbPlans:Byte;
                      Dx,Dy:Double);
procedure TranslationSpline(var ImgIntIn:PTabImgInt;
                            var ImgDoubleIn:PTabImgDouble;
                            var Sx,Sy:Integer;
                            TypeData,NbPlans:Byte;
                            Dx,Dy:Double);
procedure Rotation(var ImgIntIn:PTabImgInt;
                   var ImgDoubleIn:PTabImgDouble;
                   var Sx,Sy:Integer;
                   TypeData,NbPlans:Byte;
                   Xc,Yc,Angle:Double);
procedure MorphingPoly(var ImgIntIn:PTabImgInt;
                       var ImgDoubleIn:PTabImgDouble;
                       var Sx,Sy:Integer;
                       TypeData,NbPlans:Byte;
                       Pol1,Pol2:DoubleArrayRow;Degre:Integer);
procedure MiroirHorizontal(var ImgIntIn:PTabImgInt;
                           var ImgDoubleIn:PTabImgDouble;
                           TypeData,NPlans:Byte;
                           Sx,Sy:Integer);
procedure MiroirVertical(var ImgIntIn:PTabImgInt;
                         var ImgDoubleIn:PTabImgDouble;
                         TypeData,NPlans:Byte;
                         Sx,Sy:Integer);
procedure RotationP90(var ImgIntIn:PTabImgInt;
                      var ImgDoubleIn:PTabImgDouble;
                      var Sx,Sy:Integer;
                      TypeData,NbPlans:Byte);
procedure RotationM90(var ImgIntIn:PTabImgInt;
                      var ImgDoubleIn:PTabImgDouble;
                      var Sx,Sy:Integer;
                      TypeData,NbPlans:Byte);
procedure Rotation180(var ImgIntIn:PTabImgInt;
                      var ImgDoubleIn:PTabImgDouble;
                      TypeData,NbPlans:Byte;
                      var Sx,Sy:Integer);
procedure Detourage(var ImgIntIn:PTabImgInt;
                    var ImgDoubleIn:PTabImgDouble;
                    TypeData,NbPlans:Byte;
                    var Sx,Sy,Delta:Integer);
procedure Entourage(var ImgIntIn:PTabImgInt;
                    var ImgDoubleIn:PTabImgDouble;
                    TypeData,NbPlans:Byte;
                    var Sx,Sy,Delta:Integer;
                    Valeur:Double);
procedure Fenetrage(var ImgIntIn:PTabImgInt;
                    var ImgDoubleIn:PTabImgDouble;
                    TypeData,NbPlans:Byte;
                    var Sx,Sy:Integer;
                    X1,Y1,X2,Y2:Integer);
procedure FenetrageTempo(var ImgIntIn:PTabImgInt;
                    var ImgDoubleIn:PTabImgDouble;
                    TypeData,NbPlans:Byte;
                    var Sx,Sy:Integer;
                    X1,Y1,X2,Y2:Integer);
procedure PermuteQuadrants(var ImgIntIn:PTabImgInt;
                           var ImgDoubleIn:PTabImgDouble;
                           TypeData,NbPlans:Byte;
                           var Sx,Sy:Integer);
procedure CompositeMorphing(TabImgInt1:PTabImgInt;
                            var TabImgInt2:PTabImgInt;
                            TabImgDouble1:PTabImgDouble;
                            var TabImgDouble2:PTabImgDouble;
                            TypeData1,TypeData2,NbPlans1,NbPlans2:Byte;
                            Sx1,Sy1,Sx2,Sy2:Integer;
                            Rapport:tpop_rapport);
procedure CicatrisePixel(var ImgIntIn:PTabImgInt;
                         var ImgDoubleIn:PTabImgDouble;
                         TypeData,NbPlans:Byte;
                         var Sx,Sy:Integer;
                         X,Y:Integer);
procedure CicatriseColonne(var ImgIntIn:PTabImgInt;
                           var ImgDoubleIn:PTabImgDouble;
                           TypeData,NbPlans:Byte;
                           var Sx,Sy:Integer;
                           X:Integer);
procedure CicatriseLigne(var ImgIntIn:PTabImgInt;
                         var ImgDoubleIn:PTabImgDouble;
                         TypeData,NbPlans:Byte;
                         var Sx,Sy:Integer;
                         Y:Integer);
procedure DupliquerImage(ImageSource,ImageCible:TPop_Image;
                         CaptionSource:string);

implementation

uses u_modelisation,
     u_constants,
     u_math,
     u_lang,
     u_general,
     u_file_io;

procedure GetImgPart(ImgIntIn:PTabImgInt;
                     ImgDoubleIn:PTabImgDouble;
                     var ImgIntOut:PTabImgInt;
                     var ImgDoubleOut:PTabImgDouble;
                     TypeData,NbPlans:Byte;
                     Sx,Sy,X1,Y1,X2,Y2:Integer);
var
SxNew,SyNew,i,j,k:Integer;
begin
{WriteSpy('GetImgPart');
WriteSpy('TypeData = '+IntToStr(TypeData));
WriteSpy('NbPlans = '+IntToStr(NbPlans));
WriteSpy('Sx = '+IntToStr(Sx));
WriteSpy('Sy = '+IntToStr(Sy));
WriteSpy('X1 = '+IntToStr(X1));
WriteSpy('Y1 = '+IntToStr(Y1));
WriteSpy('X2 = '+IntToStr(X2));
WriteSpy('Y2 = '+IntToStr(Y2));
if ImgIntIn=nil then WriteSpy('ImgIntIn = nil');
if ImgDoubleIn=nil then WriteSpy('ImgDoubleIn = nil');
if ImgIntOut=nil then WriteSpy('ImgIntOut = nil');
if ImgDoubleOut=nil then WriteSpy('ImgDoubleOut = nil');}

SxNew:=X2-X1+1;
SyNew:=Y2-Y1+1;

case TypeData of
   2,7:begin
       Getmem(ImgIntOut,4*NbPlans);
       for k:=1 to NbPlans do
          begin
          Getmem(ImgIntOut^[k],SyNew*4);
          for j:=1 to SyNew do Getmem(ImgIntOut^[k]^[j],SxNew*2);
          end;
       end;
   5,6,8:begin
       Getmem(ImgDoubleOut,4*NbPlans);
       for k:=1 to NbPlans do
          begin
          Getmem(ImgDoubleOut^[k],SyNew*4);
          for j:=1 to SyNew do Getmem(ImgDoubleOut^[k]^[j],SxNew*8);
          end;
       end;
   end;

for k:=1 to NbPlans do
   for j:=Y1 to Y2 do
      begin
      case TypeData of
         2,7:begin
             for i:=X1 to X2 do
                ImgIntOut^[k]^[j-Y1+1]^[i-X1+1]:=ImgIntIn^[k]^[j]^[i];
             end;
         5,6,8:begin
             for i:=X1 to X2 do
                ImgDoubleOut^[k]^[j-Y1+1]^[i-X1+1]:=ImgDoubleIn^[k]^[j]^[i];
             end;
         end;
      end;

end;

procedure Binning(var ImgIntIn:PTabImgInt;
                  var ImgDoubleIn:PTabImgDouble;
                  var Sx,Sy:Integer;
                  TypeData,NbPlans:Byte;
                  BinningX,BinningY:Integer);
var
ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
SxNew,SyNew,i,j,k,l,m:Integer;
Somme:Double;
begin
SxNew:=Sx div BinningX;
SyNew:=Sy div BinningY;

case TypeData of
   2,7:begin
       Getmem(ImgInt,4*NbPlans);
       for k:=1 to NbPlans do
          begin
          Getmem(ImgInt^[k],SyNew*4);
          for j:=1 to SyNew do Getmem(ImgInt^[k]^[j],SxNew*2);
          end;
       end;
   5,6,8:begin
       Getmem(ImgDouble,4*NbPlans);
       for k:=1 to NbPlans do
          begin
          Getmem(ImgDouble^[k],SyNew*4);
          for j:=1 to SyNew do Getmem(ImgDouble^[k]^[j],SxNew*8);
          end;
       end;
   end;

for m:=1 to NbPlans do
   for j:=1 to SyNew do
      begin
      case TypeData of
         2,7:begin
             for i:=1 to SxNew do
                begin
                Somme:=0;
                for k:=1 to BinningY do
                   for l:=1 to BinningX do
                      Somme:=Somme+ImgIntIn^[m]^[(j-1)*BinningY+k]^[(i-1)*BinningX+l];
                Somme:=Somme/BinningY/BinningX;
                if Somme>32767 then Somme:=32767;
                if Somme<-32768 then Somme:=-32768;
                ImgInt^[m]^[j]^[i]:=Round(Somme);
                end;
             end;
         5,6,8:begin
             for i:=1 to SxNew do
                begin
                Somme:=0;
                for k:=1 to BinningY do
                   for l:=1 to BinningX do
                      Somme:=Somme+ImgDoubleIn^[m]^[(j-1)*BinningY+k]^[(i-1)*BinningX+l];
                Somme:=Somme/BinningY/BinningX;
                ImgDouble^[m]^[j]^[i]:=Somme;
                end;
             end;
         end;
      end;

case TypeData of
   2,7:begin
       for k:=1 to NbPlans do
          begin
          for j:=1 to Sy do Freemem(ImgIntIn^[k]^[j],Sx*2);
          Freemem(ImgIntIn^[k],Sy*4);
          end;
       Freemem(ImgIntIn,4*NbPlans);

       ImgIntIn:=ImgInt;
       end;
   5,6,8:begin
       for k:=1 to NbPlans do
          begin
          for j:=1 to Sy do Freemem(ImgDoubleIn^[k]^[j],Sx*8);
          Freemem(ImgDoubleIn^[k],Sy*4);
          end;
       Freemem(ImgDoubleIn,4*NbPlans);

       ImgDoubleIn:=ImgDouble;
       end;
   end;


Sx:=SxNew;
Sy:=SyNew;
end;

procedure Spline1D(var y:PLigDouble;
                       n:Integer;
                  var y2:PLigDouble);
var
i,k:Integer;
p,qn,un:Double;
u:PLigDouble;
begin
Getmem(u,8*n);
//y2[1]:=-0.5;
y2^[1]:=0;
u^[1]:=0;

for i:=2 to n-1 do
   begin
   p:=0.5*y2^[i-1]+2.0;
   y2^[i]:=-0.5/p;
   u^[i]:=(y^[i+1]-y^[i])-(y^[i]-y^[i-1]);
   u^[i]:=(6.0*u^[i]/2-0.5*u^[i-1])/p;
   end;

//qn:=0.5;
qn:=0;
un:=0;

y2^[n]:=(un-qn*u^[n-1])/(qn*y2^[n-1]+1.0);
for k:=n-1 downto 1 do y2^[k]:=y2^[k]*y2^[k+1]+u^[k];

Freemem(u,8*n);
end;

procedure ZoomSpline(var ImgIntIn:PTabImgInt;
                     var ImgDoubleIn:PTabImgDouble;
                     var Sx,Sy:Integer;
                     TypeData,NbPlans:Byte;
                     FacteurX,FacteurY:Double);
var
   i,j,k,l:Integer;
   TypeData2:Integer;
   x,y:Double;

   ImgIntNil,ImgIntNew:PTabImgInt;
   ImgDoubleNew:PTabImgDouble;
   SxNew,SyNew:Integer;

   ImgTmp,ImgDerivee,ImgDerivee2:PTabImgDouble;
   ytmp,y2tmp,xtmp,x2tmp:PLigDouble;

   xMin,xMax,yMin,yMax:Integer;
   a,b:Double;

   TombeJuste:Boolean;
   Last:Integer;
   Valeur:Double;
begin
   if Frac((Sx-1)*FacteurX)<>0 then TombeJuste:=False else TombeJuste:=True;

   if TombeJuste then
      begin
      SxNew:=Round(1+(Sx-1)*FacteurX);
      SyNew:=Round(1+(Sy-1)*FacteurY);
      end
   else
      begin
      SxNew:=1+Trunc((Sx-1)*FacteurX);
      SyNew:=1+Trunc((Sy-1)*FacteurY);
      end;

   GetmemImg(ImgIntNew,ImgDoubleNew,SxNew,SyNew,TypeData,NbPlans);

   Case TypeData of
      2,5,6:TypeData2:=5;
      7,8:TypeData2:=8;
      end;

   GetmemImg(ImgIntNil,ImgDerivee,Sx,Sy,TypeData2,NbPlans);
   GetmemImg(ImgIntNil,ImgDerivee2,SxNew,Sy,TypeData2,NbPlans);
   GetmemImg(ImgIntNil,ImgTmp,SxNew,Sy,TypeData2,NbPlans);

   Getmem(ytmp,8*Sx);
   Getmem(y2tmp,8*Sx);

   Getmem(xtmp,8*Sy);
   Getmem(x2tmp,8*Sy);

   for l:=1 to NbPlans do
      begin
      // Zoom suivant les lignes
      // Calcul des derivees secondes suivant les lignes
      for j:=1 to Sy do
         begin
         case TypeData of
            2,7:for k:=1 to Sx do ytmp[k]:=ImgIntIn^[l]^[j]^[k];
            5,6,8:for k:=1 to Sx do ytmp[k]:=ImgDoubleIn^[l]^[j]^[k];
            end;
         Spline1D(ytmp,Sx,y2tmp);
         for k:=1 to Sx do ImgDerivee^[l]^[j]^[k]:=y2tmp^[k];
         end;

      if TombeJuste then Last:=SxNew-1 else Last:=SxNew;

      for j:=1 to Sy do
         case TypeData of
            2,7:for i:=1 to Last do
                   begin
                   x:=(i-1)/FacteurX+1;
                   xMin:=Trunc(x);
                   xMax:=Trunc(x)+1;

                   a:=xMax-x;
                   b:=x-xMin;
                   ImgTmp^[l]^[j]^[i]:=a*ImgIntIn^[l]^[j]^[xMin]+b*ImgIntIn^[l]^[j]^[xMax]+
                      ((a*a*a-a)*ImgDerivee^[l]^[j]^[xMin]+(b*b*b-b)*ImgDerivee^[l]^[j]^[xMax])/6.0;
                   end;
            5,6,8:for i:=1 to Last do
                   begin
                   x:=(i-1)/FacteurX+1;
                   xMin:=Trunc(x);
                   xMax:=Trunc(x)+1;

                   a:=xMax-x;
                   b:=x-xMin;
                   ImgTmp^[l]^[j]^[i]:=a*ImgDoubleIn^[l]^[j]^[xMin]+b*ImgDoubleIn^[l]^[j]^[xMax]+
                      ((a*a*a-a)*ImgDerivee^[l]^[j]^[xMin]+(b*b*b-b)*ImgDerivee^[l]^[j]^[xMax])/6.0;
                   end;
            end;

      if TombeJuste then
         case TypeData of
            2,7:for j:=1 to Sy do
                   ImgTmp^[l]^[j]^[SxNew]:=ImgIntIn^[l]^[j]^[Sx];
            5,6,8:for j:=1 to Sy do
                   ImgTmp^[l]^[j]^[SxNew]:=ImgDoubleIn^[l]^[j]^[Sx];
            end;

      // Zoom suivant les colonnes
      // Calcul des derivees secondes suivant les colonnes
      for i:=1 to SxNew do
         begin
         for k:=1 to Sy do xtmp[k]:=ImgTmp^[l]^[k]^[i];
         Spline1D(xtmp,Sy,x2tmp);
         for k:=1 to Sy do ImgDerivee2^[l]^[k]^[i]:=x2tmp^[k];
         end;

      if TombeJuste then Last:=SyNew-1 else Last:=SyNew;

      for j:=1 to Last do
         case TypeData of
            2,7:for i:=1 to SxNew do
                 begin
                 y:=(j-1)/FacteurY+1;

                 yMin:=Trunc(y);
                 yMax:=Trunc(y)+1;

                 a:=yMax-y;
                 b:=y-yMin;

//                 ImgIntNew^[l]^[j]^[i]:=Round(a*ImgTmp^[l]^[yMin]^[i]+b*ImgTmp^[l]^[yMax]^[i]+
//                    ((a*a*a-a)*ImgDerivee2^[l]^[yMin]^[i]+(b*b*b-b)*ImgDerivee2^[l]^[yMax]^[i])/6.0);

                 Valeur:=a*ImgTmp^[l]^[yMin]^[i]+b*ImgTmp^[l]^[yMax]^[i]+
                    ((a*a*a-a)*ImgDerivee2^[l]^[yMin]^[i]+(b*b*b-b)*ImgDerivee2^[l]^[yMax]^[i])/6.0;
                 if Valeur>32767 then Valeur:=32767;
                 if Valeur<-32768 then Valeur:=-32768;
                 ImgIntNew^[l]^[j]^[i]:=Round(Valeur);
                 end;
            5,6,8:for i:=1 to SxNew do
                 begin
                 y:=(j-1)/FacteurY+1;

                 yMin:=Trunc(y);
                 yMax:=Trunc(y)+1;

                 a:=yMax-y;
                 b:=y-yMin;
                 ImgDoubleNew^[l]^[j]^[i]:=a*ImgTmp^[l]^[yMin]^[i]+b*ImgTmp^[l]^[yMax]^[i]+
                    ((a*a*a-a)*ImgDerivee2^[l]^[yMin]^[i]+(b*b*b-b)*ImgDerivee2^[l]^[yMax]^[i])/6.0;
                 end;
            end;


      if TombeJuste then
         case TypeData of
            2,7:for i:=1 to SxNew do
                   ImgIntNew^[l]^[SyNew]^[i]:=Round(ImgTmp^[l]^[Sy]^[i]);
            5,6,8:for i:=1 to SxNew do
                   ImgDoubleNew^[l]^[SyNew]^[i]:=Round(ImgTmp^[l]^[Sy]^[i]);
            end;
      end;

   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   FreememImg(ImgIntNil,ImgTmp,SxNew,Sy,TypeData2,NbPlans);
   FreememImg(ImgIntNil,ImgDerivee,SxNew,Sy,TypeData2,NbPlans);
   FreememImg(ImgIntNil,ImgDerivee2,Sx,Sy,TypeData2,NbPlans);

   case TypeData of
      2,7:ImgIntIn:=ImgIntNew;
      5,6,8:ImgDoubleIn:=ImgDoubleNew;
      end;


   Sx:=SxNew;
   Sy:=SyNew;

   Freemem(ytmp,8*Sx);
   Freemem(y2tmp,8*Sx);
   Freemem(xtmp,8*Sy);
   Freemem(x2tmp,8*Sy);
end;

procedure ZoomBilineaire(var ImgIntIn:PTabImgInt;
                         var ImgDoubleIn:PTabImgDouble;
                         var Sx,Sy:Integer;
                         TypeData,NbPlans:Byte;
                         FacteurX,FacteurY:Double);
var
xz,yz,k,j,i,ix,iy:Integer;
ValInt,a,b,c,d:Smallint;
ValDouble,ad,bd,cd,dd:Double;
coef1,coef2,coef3,coef4,frax,fray,m1,m2:Double;
LineInt,LineInt1,LineInt2:PLigInt;
LineDouble,LineDouble1,LineDouble2:PLigDouble;

ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
SxNew,SyNew:Integer;
begin
SxNew:=Round(1+(Sx-1)*FacteurX);
SyNew:=Round(1+(Sy-1)*FacteurY);

case TypeData of
   2,7:begin
       Getmem(ImgInt,4*NbPlans);
       for k:=1 to NbPlans do
          begin
          Getmem(ImgInt^[k],SyNew*4);
          for j:=1 to SyNew do Getmem(ImgInt^[k]^[j],SxNew*2);
          end;
       Getmem(LineInt,2*SxNew);
       Getmem(LineInt1,2*Sx);
       Getmem(LineInt2,2*Sx);
       end;
   5,6,8:begin
       Getmem(ImgDouble,4*NbPlans);
       for k:=1 to NbPlans do
          begin
          Getmem(ImgDouble^[k],SyNew*4);
          for j:=1 to SyNew do Getmem(ImgDouble^[k]^[j],SxNew*8);
          end;
       Getmem(LineDouble,8*SxNew);
       Getmem(LineDouble1,8*Sx);
       Getmem(LineDouble2,8*Sx);
       end;
   end;


try

for k:=1 to NbPlans do
   for j:=1 to SyNew do
      begin
      m2:=(j-1)/FacteurY+1;
      iy:=trunc(m2);
      fray:=frac(m2);

      case TypeData of
         2,7:begin
             if (iy>=1) and (iy<=Sy) then
                Move(ImgIntIn^[k]^[iy]^,LineInt1^,2*Sx)
             else FillChar(LineInt1^,Sx*2,0);

             if (iy+1>=1) and (iy+1<=Sy) then
                Move(ImgIntIn^[k]^[iy+1]^,LineInt2^,2*Sx)
             else FillChar(LineInt2^,Sx*2,0);
             for i:=1 to SxNew do
                begin
                m1:=(i-1)/FacteurX+1;
                ix:=trunc(m1);
                frax:=frac(m1);
                coef1:=(1-frax)*(1-fray);
                coef2:=(1-frax)*fray;
                coef3:=frax*(1-fray);
                coef4:=frax*fray;
                if (ix>=1) and (ix<=sx) then begin a:=LineInt1^[ix]; b:=LineInt2^[ix]; end
                else begin a:=0; b:=0; end;
                if (ix+1>=1) and (ix+1<=sx) then begin c:=LineInt1^[ix+1]; d:=LineInt2^[ix+1]; end
                else begin c:=0; d:=0; end;
                ValInt:=Round((Coef1*a)+(Coef2*b)+(Coef3*c)+(Coef4*d));
                LineInt^[i]:=ValInt;
                end;
             Move(LineInt^,ImgInt^[k]^[j]^,2*SxNew)
             end;
         5,6,8:begin
             if (iy>=1) and (iy<=Sy) then
                Move(ImgDoubleIn^[k]^[iy]^,LineDouble1^,8*Sx)
             else FillChar(LineDouble1^,Sx*8,0);

             if (iy+1>=1) and (iy+1<=Sy) then
                Move(ImgDoubleIn^[k]^[iy+1]^,LineDouble2^,8*Sx)
             else FillChar(LineDouble2^,Sx*8,0);
             for i:=1 to SxNew do
                begin
                m1:=(i-1)/FacteurX+1;
                ix:=trunc(m1);
                frax:=frac(m1);
                coef1:=(1-frax)*(1-fray);
                coef2:=(1-frax)*fray;
                coef3:=frax*(1-fray);
                coef4:=frax*fray;
                if (ix>=1) and (ix<=sx) then begin ad:=LineDouble1^[ix]; bd:=LineDouble2^[ix]; end
                else begin ad:=0; bd:=0; end;
                if (ix+1>=1) and (ix+1<=sx) then begin cd:=LineDouble1^[ix+1]; dd:=LineDouble2^[ix+1]; end
                else begin cd:=0; dd:=0; end;
                ValDouble:=Coef1*ad+Coef2*bd+Coef3*cd+Coef4*dd;
                LineDouble^[i]:=ValDouble;
                end;
             Move(LineDouble^,ImgDouble^[k]^[j]^,8*SxNew)
             end;
         end;
      end;

case TypeData of
   2,7:begin
       for k:=1 to NbPlans do
          begin
          for j:=1 to Sy do Freemem(ImgIntIn^[k]^[j],Sx*2);
          Freemem(ImgIntIn^[k],Sy*4);
          end;
       Freemem(ImgIntIn,4*NbPlans);
       ImgIntIn:=ImgInt;
       end;
   5,6,8:begin
       for k:=1 to NbPlans do
          begin
          for j:=1 to Sy do Freemem(ImgDoubleIn^[k]^[j],Sx*8);
          Freemem(ImgDoubleIn^[k],Sy*4);
          end;
       Freemem(ImgDoubleIn,4*NbPlans);
       ImgDoubleIn:=ImgDouble;
       end;
   end;


Sx:=SxNew;
Sy:=SyNew;

finally
case TypeData of
   2,7:begin
       Freemem(LineInt1,2*Sx);
       Freemem(LineInt2,2*Sx);
       Freemem(LineInt,SxNew*2);
       end;
   5,6,8:begin
       Freemem(LineDouble1,2*Sx);
       Freemem(LineDouble2,2*Sx);
       Freemem(LineDouble,SxNew*2);
       end;
   end;
end;
end;

procedure Translation(var ImgIntIn:PTabImgInt;
                      var ImgDoubleIn:PTabImgDouble;
                      var Sx,Sy:Integer;
                      TypeData,NbPlans:Byte;
                      Dx,Dy:Double);
var
i,j,k,ix,iy:longint;
Coef1,Coef2,Coef3,Coef4,Frax,Fray,m1,m2:Double;
LineInt1,LineInt2,LineInt:PLigInt;
LineDouble1,LineDouble2,LineDouble:PLigDouble;
Val,a,b,c,d:Smallint;
ValDouble,ad,bd,cd,dd:Double;

ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
begin
GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);

case TypeData of
   2,7:begin
       Getmem(LineInt1,Sx*2);
       Getmem(LineInt2,Sx*2);
       Getmem(LineInt,Sx*2);
       end;
   5,6,8:begin
       Getmem(LineDouble1,Sx*8);
       Getmem(LineDouble2,Sx*8);
       Getmem(LineDouble,Sx*8);
       end
   end;

try

for k:=1 to NbPlans do
   for j:=1 to Sy do
      begin
      m2:=j-Dy;
      iy:=Trunc(m2);
      Fray:=Frac(m2);

      case TypeData of
         2,7:begin
             if (iy>=1) and (iy<=Sy) then
                Move(ImgIntIn^[k]^[iy]^,LineInt1^,2*Sx)
             else
                FillChar(LineInt1^,Sx*2,0);

             if (iy+1>=1) and (iy+1<=Sy) then
                Move(ImgIntIn^[k]^[iy+1]^,LineInt2^,2*Sx)
             else
                FillChar(LineInt2^,Sx*2,0);

             for i:=1 to Sx do
                begin
                m1:=i-Dx;
                ix:=Trunc(m1);
                Frax:=Frac(m1);
                Coef1:=(1-Frax)*(1-Fray);
                Coef2:=(1-Frax)*Fray;
                Coef3:=Frax*(1-Fray);
                Coef4:=Frax*Fray;
                if (ix>=1) and (ix<=Sx) then
                   begin
                   a:=LineInt1^[ix];
                   b:=LineInt2^[ix];
                   end
                else
                   begin
                   a:=0;
                   b:=0;
                   end;
                if (ix+1>=1) and (ix+1<=Sx) then
                   begin
                   c:=LineInt1^[ix+1];
                   d:=LineInt2^[ix+1];
                   end
                else
                   begin
                   c:=0;
                   d:=0;
                   end;
                Val:=Round(Coef1*a+Coef2*b+Coef3*c+Coef4*d);
                LineInt^[i]:=Val;
                end;
             Move(LineInt^,ImgInt^[k]^[j]^,2*Sx)
             end;
         5,6,8:begin
             if (iy>=1) and (iy<=Sy) then
                Move(ImgDoubleIn^[k]^[iy]^,LineDouble1^,8*Sx)
             else
                FillChar(LineDouble1^,Sx*8,0);

             if (iy+1>=1) and (iy+1<=Sy) then
                Move(ImgDoubleIn^[k]^[iy+1]^,LineDouble2^,8*Sx)
             else
                FillChar(LineDouble2^,Sx*8,0);

             for i:=1 to Sx do
                begin
                m1:=i-Dx;
                ix:=Trunc(m1);
                Frax:=Frac(m1);
                Coef1:=(1-Frax)*(1-Fray);
                Coef2:=(1-Frax)*Fray;
                Coef3:=Frax*(1-Fray);
                Coef4:=Frax*Fray;
                if (ix>=1) and (ix<=sx) then
                   begin
                   ad:=LineDouble1^[ix];
                   bd:=LineDouble2^[ix];
                   end
                else
                   begin
                   ad:=0;
                   bd:=0;
                   end;
                 if (ix+1>=1) and (ix+1<=Sx) then
                   begin
                   cd:=LineDouble1^[ix+1];
                   dd:=LineDouble2^[ix+1];
                   end
                else
                   begin
                   cd:=0;
                   dd:=0;
                   end;

                ValDouble:=Round(Coef1*ad+Coef2*bd+Coef3*cd+Coef4*dd);
                LineDouble^[i]:=ValDouble;
                end;
             Move(LineDouble^,ImgDouble^[k]^[j]^,8*Sx)
             end;
         end;
      end;

FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);

case TypeData of
   2,7:ImgIntIn:=ImgInt;
   5,6,8:ImgDoubleIn:=ImgDouble;
   end;

finally
case TypeData of
   2,7:begin
       Freemem(LineInt,Sx*2);
       Freemem(LineInt1,Sx*2);
       Freemem(LineInt2,Sx*2);
       end;
   5,6,8:begin
       Freemem(LineDouble,Sx*8);
       Freemem(LineDouble1,Sx*8);
       Freemem(LineDouble2,Sx*8);
       end;
   end;
end;
end;

procedure TranslationSpline(var ImgIntIn:PTabImgInt;
                            var ImgDoubleIn:PTabImgDouble;
                            var Sx,Sy:Integer;
                            TypeData,NbPlans:Byte;
                            DX,DY:Double);
var
   i,j,k,l:Integer;
   TypeData2:Integer;
   x,y:Double;

   ImgIntNil,ImgIntNew:PTabImgInt;
   ImgDoubleNew:PTabImgDouble;
   SxNew,SyNew:Integer;

   ImgTmp,ImgDerivee,ImgDerivee2:PTabImgDouble;
   ytmp,y2tmp,xtmp,x2tmp:PLigDouble;

   xMin,xMax,yMin,yMax:Integer;
   a,b:Double;

   IMin,IMax,IMinp,IMaxp:Double;
   Valeur:Double;
begin
   SxNew:=Sx;
   SyNew:=Sy;

   GetmemImg(ImgIntNew,ImgDoubleNew,SxNew,SyNew,TypeData,NbPlans);

   Case TypeData of
      2,5,6:TypeData2:=5;
      7,8:TypeData2:=8;
      end;

   GetmemImg(ImgIntNil,ImgDerivee,Sx,Sy,TypeData2,NbPlans);
   GetmemImg(ImgIntNil,ImgDerivee2,SxNew,Sy,TypeData2,NbPlans);
   GetmemImg(ImgIntNil,ImgTmp,SxNew,Sy,TypeData2,NbPlans);

   Getmem(ytmp,8*Sx);
   Getmem(y2tmp,8*Sx);

   Getmem(xtmp,8*Sy);
   Getmem(x2tmp,8*Sy);

   for l:=1 to NbPlans do
      begin
      // Zoom suivant les lignes
      // Calcul des derivees secondes suivant les lignes
      for j:=1 to Sy do
         begin
         case TypeData of
            2,7:for k:=1 to Sx do ytmp[k]:=ImgIntIn^[l]^[j]^[k];
            5,6,8:for k:=1 to Sx do ytmp[k]:=ImgDoubleIn^[l]^[j]^[k];
            end;
         Spline1D(ytmp,Sx,y2tmp);
         for k:=1 to Sx do ImgDerivee^[l]^[j]^[k]:=y2tmp^[k];
         end;

      for j:=1 to SyNew do
         case TypeData of
            2,7:for i:=1 to SxNew do
                   begin
                   x:=i-DX;
                   xMin:=Trunc(x);
                   xMax:=Trunc(x)+1;

                   a:=xMax-x;
                   b:=x-xMin;

                   if (xMin>0) and (xMin<=Sx) then
                      begin
                      IMin:=ImgIntIn^[l]^[j]^[xMin];
                      IMinp:=ImgDerivee^[l]^[j]^[xMin];
                      end
                   else
                      begin
                      IMin:=0;
                      IMinp:=0;
                      end;

                   if (xMax>0) and (xMax<=Sx) then
                      begin
                      IMax:=ImgIntIn^[l]^[j]^[xMax];
                      IMaxp:=ImgDerivee^[l]^[j]^[xMax];
                      end
                   else
                      begin
                      IMax:=0;
                      IMaxp:=0;
                      end;

                   ImgTmp^[l]^[j]^[i]:=a*IMin+b*IMax+((a*a*a-a)*IMinp+(b*b*b-b)*IMaxp)/6.0;
                   end;
            5,6,8:for i:=1 to SxNew do
                   begin
                   x:=i-DX;
                   xMin:=Trunc(x);
                   xMax:=Trunc(x)+1;

                   a:=xMax-x;
                   b:=x-xMin;

                   if (xMin>0) and (xMin<=Sx) then
                      begin
                      IMin:=ImgDoubleIn^[l]^[j]^[xMin];
                      IMinp:=ImgDerivee^[l]^[j]^[xMin];
                      end
                   else
                      begin
                      IMin:=0;
                      IMinp:=0;
                      end;

                   if (xMax>0) and (xMax<=Sx) then
                      begin
                      IMax:=ImgDoubleIn^[l]^[j]^[xMax];
                      IMaxp:=ImgDerivee^[l]^[j]^[xMax];
                      end
                   else
                      begin
                      IMax:=0;
                      IMaxp:=0;
                      end;

                   ImgTmp^[l]^[j]^[i]:=a*IMin+b*IMax+((a*a*a-a)*IMinp+(b*b*b-b)*IMaxp)/6.0;
                   end;
            end;

      // Zoom suivant les colonnes
      // Calcul des derivees secondes suivant les colonnes
      for i:=1 to SxNew do
         begin
         for k:=1 to Sy do xtmp[k]:=ImgTmp^[l]^[k]^[i];
         Spline1D(xtmp,Sy,x2tmp);
         for k:=1 to Sy do ImgDerivee2^[l]^[k]^[i]:=x2tmp^[k];
         end;

      for j:=1 to SyNew do
         case TypeData of
            2,7:for i:=1 to SxNew do
                 begin
                 y:=j-DY;

                 yMin:=Trunc(y);
                 yMax:=Trunc(y)+1;

                 a:=yMax-y;
                 b:=y-yMin;

                 if (yMin>0) and (yMin<=Sy) then
                    begin
                    IMin:=ImgTmp^[l]^[yMin]^[i];
                    IMinp:=ImgDerivee2^[l]^[yMin]^[i];
                    end
                 else
                    begin
                    IMin:=0;
                    IMinp:=0;
                    end;

                 if (yMax>0) and (yMax<=Sy) then
                    begin
                    IMax:=ImgTmp^[l]^[yMax]^[i];
                    IMaxp:=ImgDerivee2^[l]^[yMax]^[i];
                    end
                 else
                    begin
                    IMax:=0;
                    IMaxp:=0;
                    end;

                 Valeur:=a*IMin+b*IMax+((a*a*a-a)*IMinp+(b*b*b-b)*IMaxp)/6.0;
                 if Valeur>32767 then Valeur:=32767;
                 if Valeur<-32768 then Valeur:=-32768;
                 ImgIntNew^[l]^[j]^[i]:=Round(Valeur);
                 end;
            5,6,8:for i:=1 to SxNew do
                 begin
                 y:=j-DY;

                 yMin:=Trunc(y);
                 yMax:=Trunc(y)+1;

                 a:=yMax-y;
                 b:=y-yMin;

                 if (yMin>0) and (yMin<=Sy) then
                    begin
                    IMin:=ImgTmp^[l]^[yMin]^[i];
                    IMinp:=ImgDerivee2^[l]^[yMin]^[i];
                    end
                 else
                    begin
                    IMin:=0;
                    IMinp:=0;
                    end;

                 if (yMax>0) and (yMax<=Sy) then
                    begin
                    IMax:=ImgTmp^[l]^[yMax]^[i];
                    IMaxp:=ImgDerivee2^[l]^[yMax]^[i];
                    end
                 else
                    begin
                    IMax:=0;
                    IMaxp:=0;
                    end;

                 ImgDoubleNew^[l]^[j]^[i]:=a*IMin+b*IMax+((a*a*a-a)*IMinp+(b*b*b-b)*IMaxp)/6.0;
//                 ImgDoubleNew^[l]^[j]^[i]:=a*ImgTmp^[l]^[yMin]^[i]+b*ImgTmp^[l]^[yMax]^[i]+
//                    ((a*a*a-a)*ImgDerivee2^[l]^[yMin]^[i]+(b*b*b-b)*ImgDerivee2^[l]^[yMax]^[i])/6.0;
                 end;
            end;
      end;

   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   FreememImg(ImgIntNil,ImgTmp,SxNew,Sy,TypeData2,NbPlans);
   FreememImg(ImgIntNil,ImgDerivee,SxNew,Sy,TypeData2,NbPlans);
   FreememImg(ImgIntNil,ImgDerivee2,Sx,Sy,TypeData2,NbPlans);

   case TypeData of
      2,7:ImgIntIn:=ImgIntNew;
      5,6,8:ImgDoubleIn:=ImgDoubleNew;
      end;


   Sx:=SxNew;
   Sy:=SyNew;

   Freemem(ytmp,8*Sx);
   Freemem(y2tmp,8*Sx);
   Freemem(xtmp,8*Sy);
   Freemem(x2tmp,8*Sy);
end;

procedure Rotation(var ImgIntIn:PTabImgInt;
                   var ImgDoubleIn:PTabImgDouble;
                   var Sx,Sy:Integer;
                   TypeData,NbPlans:Byte;
                   Xc,Yc,Angle:Double);
var
i,j,k,ix,iy,a,b,c,d:Longint;
ad,bd,cd,dd:Double;
si,co,coef1,coef2,coef3,coef4,frax,fray,m1,m2:Double;
LineInt:PLigInt;
LineDouble:PLigDouble;

ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
begin
GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);

case TypeData of
   2,7:Getmem(LineInt,Sx*2);
   5,6,8:Getmem(LineDouble,Sx*8);
   end;

try

Angle:=-Angle*pi/180;

Si:=Sin(Angle); Co:=Cos(Angle);

for k:=1 to NbPlans do
   for j:=1 to Sy do
      begin
      case TypeData of
         2,7:begin
             for i:=1 to Sx do
               begin
               m2:=Yc-(i-Xc)*si+(j-Yc)*co;
               m1:=Xc+(i-Xc)*co+(j-Yc)*si;
               ix:=Trunc(m1); Frax:=Frac(m1);
               iy:=Trunc(m2); Fray:=Frac(m2);

               Coef1:=(1-Frax)*(1-Fray);
               Coef2:=(1-Frax)*Fray;
               Coef3:=Frax*(1-Fray);
               Coef4:=Frax*Fray;
               if (ix>=1) and (ix<=Sx) and (iy>=1) and (iy+1<=Sy) then
                  begin
                  a:=ImgIntIn^[k]^[iy]^[ix];
                  b:=ImgIntIn^[k]^[iy+1]^[ix];
                  end
               else begin a:=0; b:=0; end;
               if (ix+1>=1) and (ix+1<=Sx) and (iy>=1) and (iy+1<=Sy) then
                  begin
                  c:=ImgIntIn^[k]^[iy]^[ix+1];
                  d:=ImgIntIn^[k]^[iy+1]^[ix+1];
                  end
               else begin c:=0; d:=0; end;

               LineInt^[i]:=Round(Coef1*a+Coef2*b+Coef3*c+Coef4*d);
               end;
            Move(LineInt^,ImgInt^[k]^[j]^,2*Sx)
            end;
         5,6,8:begin
             for i:=1 to Sx do
               begin
               m2:=Yc-(i-Xc)*si+(j-Yc)*co;
               m1:=Xc+(i-Xc)*co+(j-Yc)*si;
               ix:=Trunc(m1); Frax:=Frac(m1);
               iy:=Trunc(m2); Fray:=Frac(m2);

               Coef1:=(1-Frax)*(1-Fray);
               Coef2:=(1-Frax)*Fray;
               Coef3:=Frax*(1-Fray);
               Coef4:=Frax*Fray;
               if (ix>=1) and (ix<=Sx) and (iy>=1) and (iy+1<=Sy) then
                  begin
                  ad:=ImgDoubleIn^[k]^[iy]^[ix];
                  bd:=ImgDoubleIn^[k]^[iy+1]^[ix];
                  end
               else begin ad:=0; bd:=0; end;
               if (ix+1>=1) and (ix+1<=Sx) and (iy>=1) and (iy+1<=Sy) then
                  begin
                  cd:=ImgDoubleIn^[k]^[iy]^[ix+1];
                  dd:=ImgDoubleIn^[k]^[iy+1]^[ix+1];
                  end
               else begin cd:=0; dd:=0; end;

               LineDouble^[i]:=Coef1*ad+Coef2*bd+Coef3*cd+Coef4*dd;
               end;
            Move(LineDouble^,ImgDouble^[k]^[j]^,8*Sx)
            end;
         end;
      end;


FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
//for j:=1 to Sy do Freemem(ImgIntIn^[1]^[j],Sx*2);
//Freemem(ImgIntIn^[1],Sy*4);
//Freemem(ImgIntIn,4);

case TypeData of
   2,7:ImgIntIn:=ImgInt;
   5,6,8:ImgDoubleIn:=ImgDouble;
   end;

finally
case TypeData of
   2,7:Freemem(LineInt,Sx*2);
   5,6,8:Freemem(LineDouble,Sx*8);
   end;
end;

end;

// Morphing polyniomal
procedure MorphingPoly(var ImgIntIn:PTabImgInt;
                       var ImgDoubleIn:PTabImgDouble;
                       var Sx,Sy:Integer;
                       TypeData,NbPlans:Byte;
                       Pol1,Pol2:DoubleArrayRow;
                       Degre:Integer);
var
i,j,k,ix,iy:longint;
Coef1,Coef2,Coef3,Coef4,Frax,Fray,m1,m2:Double;
LineInt:PLigInt;
LineDouble:PLigDouble;
Val,a,b,c,d:Smallint;
ValDouble,ad,bd,cd,dd:Double;

ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
begin
GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);

case TypeData of
   2,7:Getmem(LineInt,Sx*2);
   5,6,8:Getmem(LineDouble,Sx*8);
   end;

try

for k:=1 to NbPlans do
   for j:=1 to Sy do
      begin
      case TypeData of
         2,7:begin
             for i:=1 to Sx do
                begin
                // Attention a bien avoir calcule le polynôme inverse !
                m2:=CalcPolynomeXY(i,j,Pol2,degre);
                iy:=Trunc(m2);
                Fray:=Frac(m2);

                m1:=CalcPolynomeXY(i,j,Pol1,degre);
                ix:=Trunc(m1);
                Frax:=Frac(m1);

                Coef1:=(1-Frax)*(1-Fray);
                Coef2:=(1-Frax)*Fray;
                Coef3:=Frax*(1-Fray);
                Coef4:=Frax*Fray;
                if (ix>=1) and (ix<=sx) and (iy>=1) and (iy+1<=sy) then
                   begin
                   a:=ImgIntIn^[k]^[iy]^[ix];
                   b:=ImgIntIn^[k]^[iy+1]^[ix];
                   end
                else begin a:=0; b:=0; end;
                if (ix+1>=1) and (ix+1<=sx) and (iy>=1) and (iy+1<=sy) then
                   begin
                   c:=ImgIntIn^[k]^[iy]^[ix+1];
                   d:=ImgIntIn^[k]^[iy+1]^[ix+1];
                   end
                else begin c:=0; d:=0; end;
                Val:=Round(Coef1*a+Coef2*b+Coef3*c+Coef4*d);
                LineInt^[i]:=Val;
                end;
             Move(LineInt^,ImgInt^[k]^[j]^,2*Sx)
             end;
         5,6,8:begin
             for i:=1 to Sx do
                begin
                // Attention a bien avoir calcule le polynôme inverse !
                m2:=CalcPolynomeXY(i,j,Pol2,degre);
                iy:=Trunc(m2);
                Fray:=Frac(m2);

                m1:=CalcPolynomeXY(i,j,Pol1,degre);
                ix:=Trunc(m1);
                Frax:=Frac(m1);

                Coef1:=(1-Frax)*(1-Fray);
                Coef2:=(1-Frax)*Fray;
                Coef3:=Frax*(1-Fray);
                Coef4:=Frax*Fray;
                if (ix>=1) and (ix<=sx) and (iy>=1) and (iy+1<=sy) then
                   begin
                   ad:=ImgDoubleIn^[k]^[iy]^[ix];
                   bd:=ImgDoubleIn^[k]^[iy+1]^[ix];
                   end
                else begin ad:=0; bd:=0; end;
                if (ix+1>=1) and (ix+1<=sx) and (iy>=1) and (iy+1<=sy) then
                   begin
                   cd:=ImgDoubleIn^[k]^[iy]^[ix+1];
                   dd:=ImgDoubleIn^[k]^[iy+1]^[ix+1];
                   end
                else begin cd:=0; dd:=0; end;
                ValDouble:=Coef1*ad+Coef2*bd+Coef3*cd+Coef4*dd;
                LineDouble^[i]:=ValDouble;
                end;
             Move(LineDouble^,ImgDouble^[k]^[j]^,8*Sx)
             end;
         end;
      end;

FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);

case TypeData of
   2,7:ImgIntIn:=ImgInt;
   5,6,8:ImgDoubleIn:=ImgDouble;
   end;

finally
case TypeData of
   2,7:Freemem(LineInt,Sx*2);
   5,6,8:Freemem(LineDouble,Sx*8);
   end;
end;

end;

procedure MiroirHorizontal(var ImgIntIn:PTabImgInt;
                           var ImgDoubleIn:PTabImgDouble;
                           TypeData,NPlans:Byte;
                           Sx,Sy:Integer);
var
i,j,k:Integer;
LineInt,LineInt1:PLigInt;
LineDouble,LineDouble1:PLigDouble;
begin
case TypeData of
   2,7:begin
       GetMem(LineInt,Sx*2);
       GetMem(LineInt1,Sx*2);
       end;
   5,6,8:begin
         GetMem(LineDouble,Sx*8);
         GetMem(LineDouble1,Sx*8);
         end;
   end;

try

for k:=1 to NPlans do
   for j:=1 to Sy do
      begin
      case TypeData of
         2,7:begin
             Move(ImgIntIn^[k]^[j]^,LineInt^,2*Sx);
             for i:=1 to Sx do
                LineInt1^[i]:=LineInt^[Sx-i+1];
             Move(LineInt1^,ImgIntIn^[k]^[j]^,2*Sx)
             end;
         5,6,8:begin
               Move(ImgDoubleIn^[k]^[j]^,LineDouble^,8*Sx);
               for i:=1 to Sx do
                  LineDouble1^[i]:=LineDouble^[Sx-i+1];
               Move(LineDouble1^,ImgDoubleIn^[k]^[j]^,8*Sx)
               end;
         end;
      end;

finally
case TypeData of
   2,7:begin
       FreeMem(LineInt,Sx*2);
       FreeMem(LineInt1,Sx*2);
       end;
   5,6,8:begin
         FreeMem(LineDouble,Sx*8);
         FreeMem(LineDouble1,Sx*8);
         end;
   end;
end;
end;

procedure MiroirVertical(var ImgIntIn:PTabImgInt;
                         var ImgDoubleIn:PTabImgDouble;
                         TypeData,NPlans:Byte;
                         Sx,Sy:Integer);
var
i,j,k:integer;
LineInt,LineInt1:PLigInt;
LineDouble,LineDouble1:PLigDouble;
begin
case TypeData of
   2,7:begin
       GetMem(LineInt,Sx*2);
       GetMem(LineInt1,Sx*2);
       end;
   5,6,8:begin
         GetMem(LineDouble,Sx*8);
         GetMem(LineDouble1,Sx*8);
         end;
   end;

try

for k:=1 to NPlans do
   case TypeData of
      2,7:for i:=1 to Sy div 2 do
             begin
             Move(ImgIntIn^[k]^[i]^,LineInt^,2*Sx);
             Move(ImgIntIn^[k]^[Sy-i+1]^,LineInt1^,2*Sx);
             Move(LineInt1^,ImgIntIn^[k]^[i]^,2*Sx);
             Move(LineInt^,ImgIntIn^[k]^[Sy-i+1]^,2*Sx);
             end;
      5,6,8:for i:=1 to Sy div 2 do
               begin
               Move(ImgDoubleIn^[k]^[i]^,LineDouble^,8*Sx);
               Move(ImgDoubleIn^[k]^[Sy-i+1]^,LineDouble1^,8*Sx);
               Move(LineDouble1^,ImgDoubleIn^[k]^[i]^,8*Sx);
               Move(LineDouble^,ImgDoubleIn^[k]^[Sy-i+1]^,8*Sx);
               end;
      end;

finally
case TypeData of
   2,7:begin
       FreeMem(LineInt,Sx*2);
       FreeMem(LineInt1,Sx*2);
       end;
   5,6,8:begin
         FreeMem(LineDouble,Sx*8);
         FreeMem(LineDouble1,Sx*8);
         end;
   end;
end;
end;

procedure RotationP90(var ImgIntIn:PTabImgInt;
                      var ImgDoubleIn:PTabImgDouble;
                      var Sx,Sy:Integer;
                      TypeData,NbPlans:Byte);
var
i,j,k:integer;
SxNew,SyNew:Integer;
ValInt:SmallInt;
ValDouble:Double;

ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
begin
SxNew:=Sy;
SyNew:=Sx;

case TypeData of
   2,7:begin
     Getmem(ImgInt,4*NBPlans);
     for k:=1 to NBPlans do
        begin
        Getmem(ImgInt^[k],SyNew*4);
        for j:=1 to SyNew do Getmem(ImgInt^[k]^[j],SxNew*2);
        end;
     end;
   5,6,8:begin
     Getmem(ImgDouble,4*NBPlans);
     for k:=1 to NBPlans do
        begin
        Getmem(ImgDouble^[k],SyNew*4);
        for j:=1 to SyNew do Getmem(ImgDouble^[k]^[j],SxNew*8);
        end;
     end;
   end;

for k:=1 to NBPlans do
   for i:=SxNew downto 1 do
      begin
      case TypeData of
         2,7:begin
           for j:=1 to SyNew do
              begin
              ValInt:=ImgIntIn^[k]^[i]^[j];
              ImgInt^[k]^[SyNew-j+1]^[i]:=ValInt;
              end;
           end;
         5,6,8:begin
           for j:=1 to SyNew do
              begin
              ValDouble:=ImgDoubleIn^[k]^[i]^[j];
              ImgDouble^[k]^[SyNew-j+1]^[i]:=ValDouble;
              end;
           end;
      end;
   end;

case TypeData of
   2,7:begin
     for k:=1 to NBPlans do
        begin
        for j:=1 to Sy do Freemem(ImgIntIn^[k]^[j],Sx*2);
        Freemem(ImgIntIn^[k],Sy*4);
        end;
     Freemem(ImgIntIn,4*NBPlans);

     ImgIntIn:=ImgInt;
     end;
   5,6,8:begin
     for k:=1 to NBPlans do
        begin
        for j:=1 to Sy do Freemem(ImgDoubleIn^[k]^[j],Sx*8);
        Freemem(ImgDoubleIn^[k],Sy*4);
        end;
     Freemem(ImgDoubleIn,4*NBPlans);

     ImgDoubleIn:=ImgDouble;
     end;
   end;


Sx:=SxNew;
Sy:=SyNew;
end;

procedure RotationM90(var ImgIntIn:PTabImgInt;
                      var ImgDoubleIn:PTabImgDouble;
                      var Sx,Sy:Integer;
                      TypeData,NbPlans:Byte);
var
i,j,k:integer;
SxNew,SyNew:Integer;
ValInt:SmallInt;
ValDouble:Double;

ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
begin
SxNew:=Sy;
SyNew:=Sx;

case TypeData of
   2,7:begin
     Getmem(ImgInt,4*NBPlans);
     for k:=1 to NBPlans do
        begin
        Getmem(ImgInt^[k],SyNew*4);
        for j:=1 to SyNew do Getmem(ImgInt^[k]^[j],SxNew*2);
        end;
     end;
   5,6,8:begin
     Getmem(ImgDouble,4*NBPlans);
     for k:=1 to NBPlans do
        begin
        Getmem(ImgDouble^[k],SyNew*4);
        for j:=1 to SyNew do Getmem(ImgDouble^[k]^[j],SxNew*8);
        end;
     end;
   end;

for k:=1 to NBPlans do
   for i:=1 to Sx do
      begin
      case TypeData of
         2,7:begin
           for j:=Sy downto 1 do
              begin
              ValInt:=ImgIntIn^[k]^[j]^[i];
              ImgInt^[k]^[i]^[Sy-j+1]:=ValInt;
              end;
           end;
         5,6,8:begin
           for j:=Sy downto 1 do
              begin
              ValDouble:=ImgDoubleIn^[k]^[j]^[i];
              ImgDouble^[k]^[i]^[Sy-j+1]:=ValDouble;
              end;
           end;
      end;
   end;

case TypeData of
   2,7:begin
       for k:=1 to NBPlans do
          begin
          for j:=1 to Sy do Freemem(ImgIntIn^[k]^[j],Sx*2);
          Freemem(ImgIntIn^[k],Sy*4*NBPlans);
          end;
       Freemem(ImgIntIn,4);
       ImgIntIn:=ImgInt;
       end;
   5,6,8:begin
         for k:=1 to NBPlans do
            begin
            for j:=1 to Sy do Freemem(ImgDoubleIn^[k]^[j],Sx*2);
            Freemem(ImgDoubleIn^[k],Sy*4);
            end;
         Freemem(ImgDoubleIn,4*NBPlans);
         ImgDoubleIn:=ImgDouble;
         end;
   end;


Sx:=SxNew;
Sy:=SyNew;
end;

procedure Rotation180(var ImgIntIn:PTabImgInt;
                      var ImgDoubleIn:PTabImgDouble;
                      TypeData,NbPlans:Byte;
                      var Sx,Sy:Integer);
var
i,j,k:integer;
LineInt,LineInt1:PLigInt;
LineDouble,LineDouble1:PLigDouble;
begin
case TypeData of
   2,7:begin
       GetMem(LineInt,Sx*2);
       GetMem(LineInt1,Sx*2);
       end;
   5,6,8:begin
         GetMem(LineDouble,Sx*8);
         GetMem(LineDouble1,Sx*8);
         end;
   end;

try

for k:=1 to NbPlans do
   case TypeData of
      2,7:for j:=1 to Sy do
             begin
             Move(ImgIntIn^[k]^[j]^,LineInt^,2*Sx);
             for i:=1 to Sx do
                LineInt1^[i]:=LineInt^[Sx-i+1];
             Move(LineInt1^,ImgIntIn^[k]^[j]^,2*Sx)
             end;
      5,6,8:for j:=1 to Sy do
               begin
               Move(ImgDoubleIn^[k]^[j]^,LineDouble^,8*Sx);
               for i:=1 to Sx do
                  LineDouble1^[i]:=LineDouble^[Sx-i+1];
               Move(LineDouble1^,ImgDoubleIn^[k]^[j]^,8*Sx)
               end;
      end;

for k:=1 to NbPlans do
   for i:=1 to Sy div 2 do
      case TypeData of
         2,7:begin
             Move(ImgIntIn^[k]^[i]^,LineInt^,2*Sx);
             Move(ImgIntIn^[k]^[Sy-i+1]^,LineInt1^,2*Sx);
             Move(LineInt1^,ImgIntIn^[k]^[i]^,2*Sx);
             Move(LineInt^,ImgIntIn^[k]^[Sy-i+1]^,2*Sx);
             end;
         5,6,8:begin
               Move(ImgDoubleIn^[k]^[i]^,LineDouble^,8*Sx);
               Move(ImgDoubleIn^[k]^[Sy-i+1]^,LineDouble1^,8*Sx);
               Move(LineDouble1^,ImgDoubleIn^[k]^[i]^,8*Sx);
               Move(LineDouble^,ImgDoubleIn^[k]^[Sy-i+1]^,8*Sx);
               end;
         end;

finally
case TypeData of
   2,7:begin
       FreeMem(LineInt,Sx*2);
       FreeMem(LineInt1,Sx*2);
       end;
   5,6,8:begin
         FreeMem(LineDouble,Sx*8);
         FreeMem(LineDouble1,Sx*8);
         end;
   end;
end;
end;

procedure Detourage(var ImgIntIn:PTabImgInt;
                    var ImgDoubleIn:PTabImgDouble;
                    TypeData,NbPlans:Byte;
                    var Sx,Sy,Delta:Integer);
var
SxNew,SyNew,i,j,k:Integer;
ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
begin
SxNew:=Sx-2*Delta;
SyNew:=Sy-2*Delta;

GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);

for k:=1 to NbPlans do
   case TypeData of
      2,7:for j:=Delta+1 to Sy-Delta do
             for i:=Delta+1 to Sx-Delta do
                ImgInt^[k]^[j-Delta]^[i-Delta]:=ImgIntIn^[k]^[j]^[i];
      5,6,8:for j:=Delta+1 to Sy-Delta do
               for i:=Delta+1 to Sx-Delta do
                  ImgDouble^[k]^[j-Delta]^[i-Delta]:=ImgDoubleIn^[k]^[j]^[i];
      end;

FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);

case TypeData of
   2,7:ImgIntIn:=ImgInt;
   5,6,8:ImgDoubleIn:=ImgDouble;
   end;

Sx:=SxNew;
Sy:=SyNew;
end;

procedure Entourage(var ImgIntIn:PTabImgInt;
                    var ImgDoubleIn:PTabImgDouble;
                    TypeData,NbPlans:Byte;
                    var Sx,Sy,Delta:Integer;
                    Valeur:Double);
var
SxNew,SyNew,i,j,k:Integer;
ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
begin
SxNew:=Sx+2*Delta;
SyNew:=Sy+2*Delta;

GetmemImg(ImgInt,ImgDouble,SxNew,SyNew,TypeData,NbPlans);

for k:=1 to NbPlans do
   case TypeData of
      2,7:begin
          for j:=1 to SyNew do
             for i:=1 to SxNew do
                ImgInt^[k]^[j]^[i]:=Round(Valeur);

          for j:=1 to Sy do
             for i:=1 to Sx do
                ImgInt^[k]^[Delta+j]^[Delta+i]:=ImgIntIn^[k]^[j]^[i];
          end;
      5,6,8:begin
            for j:=1 to SyNew do
               for i:=1 to SxNew do
                  ImgDouble^[k]^[j]^[i]:=Valeur;

            for j:=1 to Sy do
               for i:=1 to Sx do
                  ImgDouble^[k]^[Delta+j]^[Delta+i]:=ImgDoubleIn^[k]^[j]^[i];
            end;
      end;


FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);

case TypeData of
   2,7:ImgIntIn:=ImgInt;
   5,6,8:ImgDoubleIn:=ImgDouble;
   end;

Sx:=SxNew;
Sy:=SyNew;
end;

procedure Fenetrage(var ImgIntIn:PTabImgInt;
                    var ImgDoubleIn:PTabImgDouble;
                    TypeData,NbPlans:Byte;
                    var Sx,Sy:Integer;
                    X1,Y1,X2,Y2:Integer);
var
SxNew,SyNew,i,j,k:Integer;
ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
begin
SxNew:=X2-X1+1;
SyNew:=Y2-Y1+1;

GetmemImg(ImgInt,ImgDouble,SxNew,SyNew,TypeData,NbPlans);

for k:=1 to NbPlans do
   case TypeData of
      2,7:for j:=Y1 to Y2 do
             for i:=X1 to X2 do
                ImgInt^[k]^[j-Y1+1]^[i-X1+1]:=ImgIntIn^[k]^[j]^[i];
      5,6,8:for j:=Y1 to Y2 do
               for i:=X1 to X2 do
                  ImgDouble^[k]^[j-Y1+1]^[i-X1+1]:=ImgDoubleIn^[k]^[j]^[i];
      end;



FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);

case TypeData of
   2,7:ImgIntIn:=ImgInt;
   5,6,8:ImgDoubleIn:=ImgDouble;
   end;

Sx:=SxNew;
Sy:=SyNew;
end;

// Temporaire pour le zoom ecran
// Rendre definitif si OK
// Finalement, la fonction etait juste !!!!
procedure FenetrageTempo(var ImgIntIn:PTabImgInt;
                    var ImgDoubleIn:PTabImgDouble;
                    TypeData,NbPlans:Byte;
                    var Sx,Sy:Integer;
                    X1,Y1,X2,Y2:Integer);
var
SxNew,SyNew,i,j,k:Integer;
ImgInt:PTabImgInt;
ImgDouble:PTabImgDouble;
begin
SxNew:=X2-X1+1;
SyNew:=Y2-Y1+1;

GetmemImg(ImgInt,ImgDouble,SxNew,SyNew,TypeData,NbPlans);

for k:=1 to NbPlans do
   case TypeData of
//      2,7:for j:=Y1+1 to Y2 do
      2,7:for j:=Y1 to Y2 do
             for i:=X1 to X2 do
//                ImgInt^[k]^[j-Y1]^[i-X1+1]:=ImgIntIn^[k]^[j]^[i];
                ImgInt^[k]^[j-Y1+1]^[i-X1+1]:=ImgIntIn^[k]^[j]^[i];
//      5,6,8:for j:=Y1+1 to Y2 do
      5,6,8:for j:=Y1 to Y2 do
               for i:=X1 to X2 do
//                  ImgDouble^[k]^[j-Y1]^[i-X1+1]:=ImgDoubleIn^[k]^[j]^[i];
                  ImgDouble^[k]^[j-Y1+1]^[i-X1+1]:=ImgDoubleIn^[k]^[j]^[i];
      end;

FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);

case TypeData of
   2,7:ImgIntIn:=ImgInt;
   5,6,8:ImgDoubleIn:=ImgDouble;
   end;

Sx:=SxNew;
Sy:=SyNew;
end;

procedure PermuteQuadrants(var ImgIntIn:PTabImgInt;
                           var ImgDoubleIn:PTabImgDouble;
                           TypeData,NbPlans:Byte;
                           var Sx,Sy:Integer);
var
LineDouble1,LineDouble2:PLigDouble;
LineInt1,LineInt2:PLigInt;
i,j,k:integer;
begin
case TypeData of
   2,7:begin
       Getmem(LineInt1,2*Sx);
       Getmem(LineInt2,2*Sx);
       end;
   5,6,8:begin
         Getmem(LineDouble1,8*Sx);
         Getmem(LineDouble2,8*Sx);
         end;
   end;

try

for k:=1 to NbPlans do
   for j:=1 to Sy div 2 do
      case TypeData of
         2,7:begin
             Move(ImgIntIn^[k]^[j]^,LineInt1^,2*Sx);
             Move(ImgIntIn^[k]^[(Sy div 2)+j]^,LineInt2^,2*Sx);
             for i:=1 to Sx div 2 do
                begin
                ImgIntIn^[k]^[(Sy div 2)+j]^[i]:=LineInt1^[(Sx div 2)+i];
                ImgIntIn^[k]^[(Sy div 2)+j]^[(Sx div 2)+i]:=LineInt1^[i];
                end;
             for i:=1 to Sx div 2 do
                begin
                ImgIntIn^[k]^[j]^[i]:=LineInt2^[(Sx div 2)+i];
                ImgIntIn^[k]^[j]^[(Sx div 2)+i]:=LineInt2^[i];
                end;
             end;
         5,6,8:begin
               Move(ImgDoubleIn^[k]^[j]^,LineDouble1^,8*Sx);
               Move(ImgDoubleIn^[k]^[(Sy div 2)+j]^,LineDouble2^,8*Sx);
               for i:=1 to Sx div 2 do
                  begin
                  ImgDoubleIn^[k]^[(Sy div 2)+j]^[i]:=LineDouble1^[(Sx div 2)+i];
                  ImgDoubleIn^[k]^[(Sy div 2)+j]^[(Sx div 2)+i]:=LineDouble1^[i];
                  end;
               for i:=1 to Sx div 2 do
                  begin
                  ImgDoubleIn^[k]^[j]^[i]:=LineDouble2^[(Sx div 2)+i];
                  ImgDoubleIn^[k]^[j]^[(Sx div 2)+i]:=LineDouble2^[i];
                  end;
               end;
         end;

finally
case TypeData of
   2,7:begin
       Freemem(LineInt1,2*Sx);
       Freemem(LineInt2,2*Sx);
       end;
   5,6,8:begin
         Freemem(LineDouble1,8*Sx);
         Freemem(LineDouble2,8*Sx);
         end;
   end;
end;
end;

procedure CompositeMorphing(TabImgInt1:PTabImgInt;
                            var TabImgInt2:PTabImgInt;
                            TabImgDouble1:PTabImgDouble;
                            var TabImgDouble2:PTabImgDouble;
                            TypeData1,TypeData2,NbPlans1,NbPlans2:Byte;
                            Sx1,Sy1,Sx2,Sy2:Integer;
                            Rapport:tpop_rapport);
var
i:Integer;

arrdetections_A,arrdetections_B:plistepsf;
ndetect_a,ndetect_B:integer;
Error:Byte;
gagnants:tlist;
m:P_Matcher;
NbStar:Integer;

x,y,x1,x2,sigx,sigy:PLigDouble;
a,b:DoubleArrayRow;
covar:DoubleArray;
chisq:array[1..5] of Double;
chisqa,chisqb,Min:Double;
degre,degremax,ma:Integer;

TabImgDoubleNil:PTabImgDouble;
begin
Rapport.AddLine(lang('Registration stellaire'));

Rapport.AddLine(lang('Modélisation des étoiles de l''image de référence'));
modelisesources(TabImgInt1,TabImgDouble1,TypeData1,NbPlans1,Sx1,Sy1,9,arrdetections_A,TGauss,
//   LowPrecision,HighSelect,ndetect_A,15,False,'',False);
   LowPrecision,LowSelect,ndetect_A,15,False,'',False);
Rapport.AddLine(lang('Nombres d''étoiles dans l''image : ')+IntToStr(ndetect_A));
if NDetect_A<3 then
   begin
   Rapport.AddLine(lang('Pas assez d''étoiles dans l''image de référence'));
   raise ErrorRecalage.Create(lang('Pas assez d''étoiles dans l''image de référence'));
   Exit;
   end;

Rapport.AddLine(lang('Modélisation des étoiles de l''image à compositer'));
modelisesources(TabImgInt2,TabImgDouble2,TypeData2,NbPlans2,Sx2,Sy2,9,arrdetections_B,TGauss,
   LowPrecision,LowSelect,ndetect_B,15,false,'',False);
//   LowPrecision,HighSelect,ndetect_B,15,false,'',False);
Rapport.AddLine(lang('Nombres d''étoiles de l''image : ')+IntToStr(ndetect_B));
if NDetect_B<3 then
   begin
   Rapport.AddLine(lang('Pas assez d''étoiles dans l''image à compositer'));
   raise ErrorRecalage.Create(lang('Pas assez d''étoiles dans l''image à compositer'));
   Exit;
   end;

// Matching
Rapport.AddLine(lang('Mise en correspondance des étoiles'));
//Error:=Match(arrdetections_A,arrdetections_B,ndetect_A,ndetect_B,40,gagnants,Rapport);
Error:=MatchMarty(arrdetections_A,arrdetections_B,ndetect_A,ndetect_B,40,gagnants,Rapport);

NbStar:=gagnants.count;
if NbStar=0 then
   begin
   Rapport.AddLine(lang('Correspondance entre étoiles non trouvée'));
   raise ErrorRecalage.Create(lang('Correspondance entre étoiles non trouvée'));
   end;
if NbStar<3 then
   begin
   Rapport.AddLine('Pas assez d''étoiles en correspondance');
    raise ErrorMorphing.Create('Pas assez d''étoiles en correspondance');
   end;
if NbStar>=3 then degremax:=1;

Rapport.AddLine(IntToStr(NbStar)+lang(' étoiles en correspondance'));

Getmem(x,8*NbStar);
Getmem(y,8*NbStar);
Getmem(x1,8*NbStar);
Getmem(x2,8*NbStar);
Getmem(Sigx,8*NbStar);
Getmem(Sigy,8*NbStar);

try

{if NbStar>=6 then degremax:=2;
if NbStar>=10 then degremax:=3;
if NbStar>=15 then degremax:=4;
if NbStar>=21 then degremax:=5;

for Degre:=1 to DegreMax do
   begin
   // Recherche du polynôme de passage en X
   lfitAstro(x1,x2,x,SigX,NbStar,a,Covar,Chisqa,Degre);
   // Recherche du polynôme de passage en Y
   lfitAstro(x1,x2,y,SigY,NbStar,b,Covar,Chisqb,Degre);
   chisq[degre]:=sqrt(sqr(chisqa)+sqr(chisqb));
   Rapport.AddLine('Residu degré '+IntToStr(Degre)+' : '+MyFloatToStr(Chisq[Degre],2));
   end;

Min:=MaxDouble;
for i:=1 to DegreMax do
  if (Chisq[i]<Min) and (Chisq[i]>1) then
     begin
     Min:=chisq[i];
     Degre:=i;
     end;

Rapport.AddLine('  '); //nolang
Rapport.AddLine(Format(lang('Degré optimal du polynôme : %d'),[degre]));}

// Changement de forme des donnees
for i:=0 to NbStar-1 do
   begin
   m:=gagnants[i];
   x1^[i+1]:=m.ref_x;
   x2^[i+1]:=m.ref_y;
   x^[i+1]:=m.det_x;
   y^[i+1]:=m.det_y;
   sigx^[i+1]:=m.det_dx;
   sigy^[i+1]:=m.det_dy;
   Rapport.AddLine(Format('%4.3f %4.3f %4.3f %4.3f',[x1^[i+1],x2^[i+1],x^[i+1],y^[i+1]])); //nolang
   end;

Degre:=1;
// Recherche du polynôme de passage en X
lfitAstro(x1,x2,x,sigx,NbStar,a,covar,chisqa,degre);
// Recherche du polynôme de passage en Y
lfitAstro(x1,x2,y,sigy,NbStar,b,covar,chisqb,degre);

ma:=1;
for i:=1 to degre do ma:=ma+i+1;

Rapport.AddLine('  '); //nolang
Rapport.AddLine(lang('Polynôme de passage en X'));
for i:=1 to ma do Rapport.AddLine(Format('a[%d] = %6.3f',[i,a[i]])); //nolang
Rapport.AddLine('  '); //nolang
Rapport.AddLine(lang('Polynôme de passage en Y'));
for i:=1 to ma do Rapport.AddLine(Format('b[%d] = %6.3f',[i,b[i]])); //nolang

// Transformation de l'image a compositer
Rapport.AddLine('  '); //nolang
Rapport.AddLine(lang('Transformation'));
MorphingPoly(TabImgInt2,TabImgDouble2,Sx2,Sy2,TypeData2,NbPlans2,a,b,degre);

finally
Freemem(x,8*NbStar);
Freemem(y,8*NbStar);
Freemem(x1,8*NbStar);
Freemem(x2,8*NbStar);
Freemem(Sigx,8*NbStar);
Freemem(Sigy,8*NbStar);
end
end;

procedure CicatrisePixel(var ImgIntIn:PTabImgInt;
                         var ImgDoubleIn:PTabImgDouble;
                         TypeData,NbPlans:Byte;
                         var Sx,Sy:Integer;
                         X,Y:Integer);
var
   k:Integer;
begin
   for k:=1 to NbPlans do
      case TypeData of
         2,7:begin
             ImgIntIn^[k]^[Y]^[X]:=Round((ImgIntIn^[k]^[Y-1]^[x-1]+
                                          ImgIntIn^[k]^[Y]  ^[X-1]+
                                          ImgIntIn^[k]^[Y+1]^[X-1]+
                                          ImgIntIn^[k]^[Y-1]^[X+1]+
                                          ImgIntIn^[k]^[Y]  ^[X+1]+
                                          ImgIntIn^[k]^[Y+1]^[X+1]+
                                          ImgIntIn^[k]^[Y-1]^[X]  +
                                          ImgIntIn^[k]^[Y+1]^[X])/8);
             end;
         5,6,8:begin
             ImgDoubleIn^[k]^[Y]^[X]:=(ImgDoubleIn^[k]^[Y-1]^[X-1]+
                                       ImgDoubleIn^[k]^[Y]  ^[X-1]+
                                       ImgDoubleIn^[k]^[Y+1]^[X-1]+
                                       ImgDoubleIn^[k]^[y-1]^[X+1]+
                                       ImgDoubleIn^[k]^[Y]  ^[X+1]+
                                       ImgDoubleIn^[k]^[Y+1]^[X+1]+
                                       ImgDoubleIn^[k]^[Y-1]^[X]  +
                                       ImgDoubleIn^[k]^[Y+1]^[X])/8;
               end;
         end;
end;

procedure CicatriseColonne(var ImgIntIn:PTabImgInt;
                           var ImgDoubleIn:PTabImgDouble;
                           TypeData,NbPlans:Byte;
                           var Sx,Sy:Integer;
                           X:Integer);
var
   j,k:Integer;
begin
   for k:=1 to NbPlans do
      begin
      case TypeData of
         2,7:begin
             ImgIntIn^[k]^[1]^[X]:=Round((ImgIntIn^[k]^[1]^[X-1]+
                                          ImgIntIn^[k]^[2]^[X-1]+
                                          ImgIntIn^[k]^[1]^[X+1]+
                                          ImgIntIn^[k]^[2]^[X+1])/4);
             ImgIntIn^[k]^[Sy]^[X]:=Round((ImgIntIn^[k]^[Sy]  ^[X-1]+
                                           ImgIntIn^[k]^[Sy-1]^[X-1]+
                                           ImgIntIn^[k]^[Sy]  ^[X+1]+
                                           ImgIntIn^[k]^[Sy-1]^[X+1])/4);
             end;
         5,6,8:begin
               ImgDoubleIn^[k]^[1]^[X]:=(ImgDoubleIn^[k]^[1]^[X-1]+
                                         ImgDoubleIn^[k]^[2]^[X-1]+
                                         ImgDoubleIn^[k]^[1]^[X+1]+
                                         ImgDoubleIn^[k]^[2]^[X+1])/4;
               ImgDoubleIn^[k]^[Sy]^[X]:=(ImgDoubleIn^[k]^[Sy]  ^[X-1]+
                                          ImgDoubleIn^[k]^[Sy-1]^[X-1]+
                                          ImgDoubleIn^[k]^[Sy]  ^[X+1]+
                                          ImgDoubleIn^[k]^[Sy-1]^[X+1])/4;
               end;
         end;


      for j:=2 to Sy-1 do
         case TypeData of
            2,7:begin
                ImgIntIn^[k]^[j]^[X]:=Round((ImgIntIn^[k]^[j-1]^[X-1]+
                                             ImgIntIn^[k]^[j]  ^[X-1]+
                                             ImgIntIn^[k]^[j+1]^[X-1]+
                                             ImgIntIn^[k]^[j-1]^[X+1]+
                                             ImgIntIn^[k]^[j]  ^[X+1]+
                                             ImgIntIn^[k]^[j+1]^[X+1])/6);
                end;
            5,6,8:begin
                ImgDoubleIn^[k]^[j]^[X]:=(ImgDoubleIn^[k]^[j-1]^[X-1]+
                                          ImgDoubleIn^[k]^[j]  ^[X-1]+
                                          ImgDoubleIn^[k]^[j+1]^[X-1]+
                                          ImgDoubleIn^[k]^[j-1]^[X+1]+
                                          ImgDoubleIn^[k]^[j]  ^[X+1]+
                                          ImgDoubleIn^[k]^[j+1]^[X+1])/6;
                  end;
            end;
      end;
end;

procedure CicatriseLigne(var ImgIntIn:PTabImgInt;
                         var ImgDoubleIn:PTabImgDouble;
                         TypeData,NbPlans:Byte;
                         var Sx,Sy:Integer;
                         Y:Integer);
var
   i,k:Integer;
begin
   for k:=1 to NbPlans do
      begin
      case TypeData of
         2,7:begin
             ImgIntIn^[k]^[Y]^[1]:=Round((ImgIntIn^[k]^[Y-1]^[1]+
                                          ImgIntIn^[k]^[Y-1]^[2]+
                                          ImgIntIn^[k]^[Y+1]^[1]+
                                          ImgIntIn^[k]^[Y+1]^[2])/4);
             ImgIntIn^[k]^[Y]^[Sx]:=Round((ImgIntIn^[k]^[Y-1]^[Sx]+
                                           ImgIntIn^[k]^[Y-1]^[Sx-1]+
                                           ImgIntIn^[k]^[Y+1]^[Sx]+
                                           ImgIntIn^[k]^[Y+1]^[Sx-1])/4);
             end;
         5,6,8:begin
               ImgDoubleIn^[k]^[Y]^[1]:=(ImgDoubleIn^[k]^[Y-1]^[1]+
                                         ImgDoubleIn^[k]^[Y-1]^[2]+
                                         ImgDoubleIn^[k]^[Y+1]^[1]+
                                         ImgDoubleIn^[k]^[Y+1]^[2])/4;
               ImgDoubleIn^[k]^[Y]^[Sx]:=(ImgDoubleIn^[k]^[Y-1]^[Sx]+
                                          ImgDoubleIn^[k]^[Y-1]^[Sx-1]+
                                          ImgDoubleIn^[k]^[Y+1]^[Sx]+
                                          ImgDoubleIn^[k]^[Y+1]^[Sx-1])/4;
               end;
         end;


      for i:=2 to Sx-1 do
         case TypeData of
            2,7:begin
                ImgIntIn^[k]^[Y]^[i]:=Round((ImgIntIn^[k]^[Y-1]^[i-1]+
                                             ImgIntIn^[k]^[Y-1]^[i]+
                                             ImgIntIn^[k]^[Y-1]^[i+1]+
                                             ImgIntIn^[k]^[Y+1]^[i-1]+
                                             ImgIntIn^[k]^[Y+1]^[i]+
                                             ImgIntIn^[k]^[Y+1]^[i+1])/6);
                end;
            5,6,8:begin
                ImgDoubleIn^[k]^[Y]^[i]:=(ImgDoubleIn^[k]^[Y-1]^[i-1]+
                                          ImgDoubleIn^[k]^[Y-1]^[i]+
                                          ImgDoubleIn^[k]^[Y-1]^[i+1]+
                                          ImgDoubleIn^[k]^[Y+1]^[i-1]+
                                          ImgDoubleIn^[k]^[Y+1]^[i]+
                                          ImgDoubleIn^[k]^[Y+1]^[i+1])/6;
                  end;
            end;
      end;
end;


procedure DupliquerImage(ImageSource,ImageCible:TPop_Image;CaptionSource:string);
var
j,k:integer;
begin
ImageCible.ImgInfos:=ImageSource.ImgInfos;
GetmemImg(ImageCible.DataInt,ImageCible.DataDouble,ImageCible.ImgInfos.Sx,ImageCible.ImgInfos.Sy,
   ImageCible.ImgInfos.TypeData,ImageCible.ImgInfos.NbPlans);

case ImageCible.ImgInfos.TypeData of
   2,7:begin
       for k:=1 to ImageCible.ImgInfos.NbPlans do
          for j:=1 to ImageCible.ImgInfos.Sy do
             Move(ImageSource.DataInt^[k]^[j]^,ImageCible.DataInt^[k]^[j]^,ImageCible.ImgInfos.Sx*2);
       end;
   5,6,8:begin
         for k:=1 to ImageCible.ImgInfos.NbPlans do
            for j:=1 to ImageCible.ImgInfos.Sy do
               Move(ImageSource.DataDouble^[k]^[j]^,ImageCible.DataDouble^[k]^[j]^,ImageCible.ImgInfos.Sx*8);
         end;
   end;

ImageCible.AjusteFenetre;
ImageCible.VisuImg;
ImageCible.ChangerMenu;
end;

end.
