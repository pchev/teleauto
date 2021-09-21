unit u_modelisation;

{
Copyright (C) 2003 Philippe Martinole

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
{$IFDEF MSWINDOWS}
  Forms,
{$ENDIF}

{$IFDEF LINUX}
  QForms,
{$ENDIF}

  SysUtils,

  u_class, pu_rapport;

procedure FindSources(ImgIntIn:PTabimgInt;ImgDoubleIn:PTabImgDouble;TypeData,NbPlans:Byte;LargX,LargY:Integer;Var ListePSF:PListePSF;
                      var NBSources:Integer;NbSigmaDetect:Double;WriteInFile:Boolean;FileName:String);
procedure ModeliseSources(ImgInt:PTabimgInt;ImgDouble:PTabimgDouble;TypeData,NbPlans:Byte;
          LargX,LargY,DemiLarg:Integer;var ListePSF:PListePSF;
          TypeModele,Precision,Select:Byte;var NBSources:Integer; NbSigmaDetect:Double;WriteInFile:Boolean;FileName:String;
          WriteInRapport:Boolean);
//procedure ModeliseEtoile(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;TypeData:Byte;
//   Larg,x,y:Integer;TypeModele,Precision,Select:Byte;Degre:Byte;var PSF:TPSF);
procedure ModeliseEtoile(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;TypeData:Byte;
   Larg:Integer;TypeModele,Precision,Select:Byte;Degre:Byte;var PSF:TPSF);
function  mrqmin(var ImgInt:PTabImgInt;
                 var ImgDouble:PTabImgDouble;
                 TypeData:Byte;
                 Larg:Integer;
                 var a:DoubleArrayRow;
                 ma:Integer;
                 var covar,alpha:DoubleArray;
                 var chisq,alamda:Double;
                 TypeModele:Byte;
                 Degre:Byte;
                 Precision:Byte):Boolean;
procedure AddStar(var ImgInt:PTabImgInt;var ImgDouble:PTabImgDouble;TypeData:Byte;
                  Sx,Sy:Integer;PSF:TPSF;X,Y:Double);
procedure DeleteStar(var ImgInt:PTabImgInt;var ImgDouble:PTabImgDouble;TypeData:Byte;
                     Sx,Sy:Integer;PSF:TPSF;X,Y:Double);
procedure CreeProjTelescope(ImgInt:PTabImgInt;
                            Sx,Sy:Integer;
                            AstrometrieInfos:TAstrometrieInfos;
                            FluxMag14:Double;
                            pop_Rapport:tpop_rapport);
procedure Modelise1D(var LigDouble:PLigDouble;Max,x:Integer;var PSF:TPSF);

implementation

uses u_filtrage,
     u_math,
     u_constants,
     pu_graph,
     u_lang,
     Catalogues,
     u_meca,
     u_general;

procedure FindSources(ImgIntIn:PTabimgInt;ImgDoubleIn:PTabImgDouble;TypeData,NbPlans:Byte;LargX,LargY:Integer;Var ListePSF:PListePSF;
          var NBSources:Integer;NbSigmaDetect:Double;WriteInFile:Boolean;FileName:String);
var
ecart:double;
Limite:SmallInt;
ValeurDouble:Double;
i,j:Integer;
Sup:Boolean;
FirstSource,SourceCourante,OldSource:PSource;
PSF:TPSF;
T:TextFile;
ImgDouble:PTabImgDouble;
begin
Getmem(FirstSource,Sizeof(TSource));

try

// On extrait le plan d'ondelette 2
ExtractPlanOndelette(ImgIntIn,ImgDoubleIn,ImgDouble,TypeData,NbPlans,LargX,LargY,2);

try

// On cherche l'ecart type du fond de ciel
// Todo : A ameliorer
Ecart:=GetSigmaSky(ImgDouble,LargX,LargY);
if Ecart<0.1 then Ecart:=0.1;
// On detecte a NbSigmaDetect*l'ecart type du fond de ciel
Limite:=Round(NbSigmaDetect*Ecart);

// On supprimme tout ce qui est inferieur a la limite (bruit)
for j:=1 to LargY do
   for i:=1 to LargX do
      if ImgDouble^[1]^[j]^[i]<Limite then ImgDouble^[1]^[j]^[i]:=0;

// On detecte les maxima locaux et on stocke dans une liste chainee
NbSources:=0;
SourceCourante:=FirstSource;
for j:=2 to LargY-1 do
   for i:=2 to LargX-1 do
      begin
      ValeurDouble:=ImgDouble^[1]^[j]^[i];

      Sup:=False;
      if (ValeurDouble=ImgDouble^[1]^[j-1]^[i-1]) and
         (ValeurDouble=ImgDouble^[1]^[j]  ^[i-1]) and
         (ValeurDouble=ImgDouble^[1]^[j+1]^[i-1]) and
         (ValeurDouble=ImgDouble^[1]^[j-1]^[i]  ) and
         (ValeurDouble=ImgDouble^[1]^[j+1]^[i]  ) and
         (ValeurDouble=ImgDouble^[1]^[j-1]^[i+1]) and
         (ValeurDouble=ImgDouble^[1]^[j]  ^[i+1]) and
         (ValeurDouble=ImgDouble^[1]^[j+1]^[i+1]) then Sup:=True;

      if (ValeurDouble<ImgDouble^[1]^[j-1]^[i-1]) or
         (ValeurDouble<ImgDouble^[1]^[j]  ^[i-1]) or
         (ValeurDouble<ImgDouble^[1]^[j+1]^[i-1]) or
         (ValeurDouble<ImgDouble^[1]^[j-1]^[i]  ) or
         (ValeurDouble<ImgDouble^[1]^[j+1]^[i]  ) or
         (ValeurDouble<ImgDouble^[1]^[j-1]^[i+1]) or
         (ValeurDouble<ImgDouble^[1]^[j]  ^[i+1]) or
         (ValeurDouble<ImgDouble^[1]^[j+1]^[i+1]) then Sup:=True;

      if not Sup then
         begin
         Inc(NbSources);
         SourceCourante.X:=i;
         SourceCourante.Y:=j;
         Getmem(SourceCourante.Suivant,Sizeof(TSource));
         SourceCourante:=SourceCourante.Suivant;
         end;
      end;

// On transfere dans le tableau dynamique
SourceCourante:=FirstSource;
Getmem(ListePSF,NBSources*Sizeof(TPSF));
for i:=1 to NBSources do
   begin
   ListePSF^[i].X:=SourceCourante.X;
   ListePSF^[i].Y:=SourceCourante.Y;
   SourceCourante:=SourceCourante.Suivant;
   end;

// On ecrit dans un fichier si demande
if WriteInFile then
   begin
   AssignFile(T,FileName);
   Rewrite(T);
   Writeln(T,Format(lang('%d sources'),[NBSources]));
   for i:=1 to NBSources do
      begin
      Write(T,Format('%5d ',[Round(ListePSF^[i].X)])); //nolang
      Write(T,Format('%5d', [Round(ListePSF^[i].Y)])); //nolang
      Writeln(T);
      end;
   Close(T);
   end;

finally
for j:=1 to NbPlans do
   begin
   for i:=1 to LargY do Freemem(ImgDouble^[j]^[i],LargX*8);
   Freemem(ImgDouble^[j],4*LargY);
   end;
Freemem(ImgDouble,4);
end;

finally
SourceCourante:=FirstSource;
for i:=1 to NBSources do
   begin
   OldSource:=SourceCourante;
   SourceCourante:=SourceCourante.Suivant;
   Freemem(OldSource,Sizeof(TSource));
   end;

end;
end;

function mrqmin(var ImgInt:PTabImgInt;
                var ImgDouble:PTabImgDouble;
                TypeData:Byte;
                Larg:Integer;
                var a:DoubleArrayRow;
                ma:Integer;
                var covar,alpha:DoubleArray;
                var chisq,alamda:Double;
                TypeModele:Byte;
                Degre:Byte;
                Precision:Byte):Boolean;
var
k,j:Integer;
atry:DoubleArrayRow;
oneda:DoubleArray;
//oneda:DoubleArrayRow;
MrqminBeta:DoubleArrayRow;
Mrqmin0chisq:Double;
da:DoubleArrayRow;
CoefAlamda:Double;
//Indx:IntegerArrayRow;
//d:Double;
label fin;

function mrqcof(var ImgInt:PTabImgInt;
                var ImgDouble:PTabImgDouble;
                TypeData:Byte;
                var a:DoubleArrayRow;
                var alpha:DoubleArray;
                var beta:DoubleArrayRow;
                var chisq:Double;
                TypeModele:Byte;
                Degre:Byte):Boolean;
var
i,j,k,l:integer;
zmod,wt,dz:Double;
dyda:DoubleArrayRow;

Tmp,Val:Double;
CosAngle,SinAngle,SigmaX2,SigmaY2:Double;
begin
Result:=True;
for j:=1 to ma do
   begin
   for k:=1 to j do alpha[j,k]:=0;
   beta[j]:=0;
   end;
chisq:=0;
case TypeModele of
   TMoffat:case Degre of
             0:begin
               for i:=1 to Larg do
                  case TypeData of
                     2,7:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite
                          // A[3] x
                          // A[4] y
                          // A[5] Coeff a de Moffat
                          // A[6] Coeff b de Moffat
                          zmod:=0;
                          Tmp:=1+((Sqr(i-A[3])+Sqr(l-A[4]))/Sqr(A[5]));
                          Val:=1/PuissanceDouble(Tmp,A[6]);
                          zmod:=zmod+a[1]+a[2]*Val;
                          dyda[1]:=1;
                          dyda[2]:=Val;
                          dyda[3]:=A[2]*Val*2*A[6]*(i-A[3])/(Sqr(A[5])*Tmp);
                          dyda[4]:=A[2]*Val*2*A[6]*(l-A[4])/(Sqr(A[5])*Tmp);
                          dyda[5]:=A[2]*Val*A[6]*((Sqr(i-A[3])+Sqr(l-A[4]))/(A[5]*A[5]*A[5]*Val));
                          dyda[6]:=-A[2]*Val*ln(Tmp);
                          dz:=ImgInt^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     5,8:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite
                          // A[3] x
                          // A[4] y
                          // A[5] Coeff a de Moffat
                          // A[6] Coeff b de Moffat
                          zmod:=0;
                          Tmp:=(1+((Sqr(i-A[3])+Sqr(l-A[4]))/Sqr(A[5])));
                          Val:=1/PuissanceDouble(Tmp,A[6]);
                          zmod:=zmod+a[1]+a[2]*Val;

                          dyda[1]:=1;
                          dyda[2]:=Val;
                          dyda[3]:=A[2]*Val*2*A[6]*(i-A[3])/(A[5]*A[5]*Tmp);
                          dyda[4]:=A[2]*Val*2*A[6]*(l-A[4])/(A[5]*A[5]*Tmp);
                          dyda[5]:=A[2]*Val*A[6]*((Sqr(i-A[3])+Sqr(l-A[4]))/(A[5]*A[5]*A[5]*Val));
                          dyda[6]:=-A[2]*Val*ln(Tmp);

                          dz:=ImgDouble^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     end;
               end;
             1:begin
               for i:=1 to Larg do
                  case TypeData of
                     2,7:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite
                          // A[3] x
                          // A[4] y
                          // A[5] Coeff a de Moffat
                          // A[6] Coeff b de Moffat
                          // A[7] coef x du polynome
                          // A[8] coef y du polynome
                          zmod:=0;
                          Tmp:=1+((Sqr(i-A[3])+Sqr(l-A[4]))/Sqr(A[5]));
                          Val:=1/PuissanceDouble(Tmp,A[6]);
                          zmod:=zmod+a[1]+a[7]*i+a[8]*l+a[2]*Val;
                          dyda[1]:=1;
                          dyda[2]:=Val;
                          dyda[3]:=A[2]*Val*2*A[6]*(i-A[3])/(Sqr(A[5])*Tmp);
                          dyda[4]:=A[2]*Val*2*A[6]*(l-A[4])/(Sqr(A[5])*Tmp);
                          dyda[5]:=A[2]*Val*A[6]*((Sqr(i-A[3])+Sqr(l-A[4]))/(A[5]*A[5]*A[5]*Val));
                          dyda[6]:=-A[2]*Val*ln(Tmp);
                          dyda[7]:=i;
                          dyda[8]:=l;
                          dz:=ImgInt^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     5,8:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite
                          // A[3] x
                          // A[4] y
                          // A[5] Coeff a de Moffat
                          // A[6] Coeff b de Moffat
                          // A[7] coef x du polynome
                          // A[8] coef y du polynome
                          zmod:=0;
                          Tmp:=1+((Sqr(i-A[3])+Sqr(l-A[4]))/Sqr(A[5]));
                          Val:=1/PuissanceDouble(Tmp,A[6]);
                          zmod:=zmod+a[1]+a[7]*i+a[8]*l+a[2]*Val;
                          dyda[1]:=1;
                          dyda[2]:=Val;
                          dyda[3]:=A[2]*Val*2*A[6]*(i-A[3])/(Sqr(A[5])*Tmp);
                          dyda[4]:=A[2]*Val*2*A[6]*(l-A[4])/(Sqr(A[5])*Tmp);
                          dyda[5]:=A[2]*Val*A[6]*((Sqr(i-A[3])+Sqr(l-A[4]))/(A[5]*A[5]*A[5]*Val));
                          dyda[6]:=-A[2]*Val*ln(Tmp);
                          dyda[7]:=i;
                          dyda[8]:=l;
                          dz:=ImgDouble^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     end;
               end;
             2:begin
               for i:=1 to Larg do
                  case TypeData of
                     2,7:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite
                          // A[3] x
                          // A[4] y
                          // A[5] Coeff a de Moffat
                          // A[6] Coeff b de Moffat
                          // A[7] coef x du polynome
                          // A[8] coef y du polynome
                          // A[9] coef x2 du polynome
                          // A[10] coef xy du polynome
                          // A[11] coef y2 du polynome
                          zmod:=0;
                          Tmp:=1+((Sqr(i-A[3])+Sqr(l-A[4]))/Sqr(A[5]));
                          Val:=1/PuissanceDouble(Tmp,A[6]);
                          zmod:=zmod+a[1]+a[7]*i+a[8]*l+a[9]*i*i+a[10]*i*l+a[11]*l*l+a[2]*Val;
                          dyda[1]:=1;
                          dyda[2]:=Val;
                          dyda[3]:=A[2]*Val*2*A[6]*(i-A[3])/(Sqr(A[5])*Tmp);
                          dyda[4]:=A[2]*Val*2*A[6]*(l-A[4])/(Sqr(A[5])*Tmp);
                          dyda[5]:=A[2]*Val*A[6]*((Sqr(i-A[3])+Sqr(l-A[4]))/(A[5]*A[5]*A[5]*Val));
                          dyda[6]:=-A[2]*Val*ln(Tmp);
                          dyda[7]:=i;
                          dyda[8]:=l;
                          dyda[9]:=sqr(i);
                          dyda[10]:=i*l;
                          dyda[11]:=sqr(l);
                          dz:=ImgInt^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     5,8:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite
                          // A[3] x
                          // A[4] y
                          // A[5] Coeff a de Moffat
                          // A[6] Coeff b de Moffat
                          // A[7] coef x du polynome
                          // A[8] coef y du polynome
                          // A[9] coef x2 du polynome
                          // A[10] coef xy du polynome
                          // A[11] coef y2 du polynome
                          zmod:=0;
                          Tmp:=1+((Sqr(i-A[3])+Sqr(l-A[4]))/Sqr(A[5]));
                          Val:=1/PuissanceDouble(Tmp,A[6]);
                          zmod:=zmod+a[1]+a[7]*i+a[8]*l+a[9]*i*i+a[10]*i*l+a[11]*l*l+a[2]*Val;
                          dyda[1]:=1;
                          dyda[2]:=Val;
                          dyda[3]:=A[2]*Val*2*A[6]*(i-A[3])/(Sqr(A[5])*Tmp);
                          dyda[4]:=A[2]*Val*2*A[6]*(l-A[4])/(Sqr(A[5])*Tmp);
                          dyda[5]:=A[2]*Val*A[6]*((Sqr(i-A[3])+Sqr(l-A[4]))/(A[5]*A[5]*A[5]*Val));
                          dyda[6]:=-A[2]*Val*ln(Tmp);
                          dyda[7]:=i;
                          dyda[8]:=l;
                          dyda[9]:=sqr(i);
                          dyda[10]:=i*l;
                          dyda[11]:=sqr(l);
                          dz:=ImgDouble^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     end;
               end;
             end;
   TGauss:case Degre of
             0:begin
               for i:=1 to Larg do
                  case TypeData of
                     2,7:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite
                          // A[3] x
                          // A[4] y
                          // A[5] sigma
                          zmod:=0;
                          SigmaX2:=Sqr(a[5]);
                          Tmp:=exp(-sqr((i-a[3])/a[5])/2)*exp(-sqr((l-a[4])/a[5])/2);
                          zmod:=zmod+a[1]+a[2]*Tmp;
                          dyda[1]:=1;
                          dyda[2]:=Tmp;
                          dyda[3]:=Tmp/SigmaX2*(i-a[3])*a[2];
                          dyda[4]:=Tmp/SigmaX2*(l-a[4])*a[2];
                          dyda[5]:=Tmp/(SigmaX2*a[5])*(sqr(i-a[3])+sqr(l-a[4]))*a[2];
                          dz:=ImgInt^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     5,8:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite
                          // A[3] x
                          // A[4] y
                          // A[5] sigma
                          zmod:=0;
                          SigmaX2:=Sqr(a[5]);
                          Tmp:=exp(-sqr((i-a[3])/a[5])/2)*exp(-sqr((l-a[4])/a[5])/2);
                          zmod:=zmod+a[1]+a[2]*Tmp;
                          dyda[1]:=1;
                          dyda[2]:=Tmp;
                          dyda[3]:=Tmp/SigmaX2*(i-a[3])*a[2];
                          dyda[4]:=Tmp/SigmaX2*(l-a[4])*a[2];
                          dyda[5]:=Tmp/(SigmaX2*a[5])*(sqr(i-a[3])+sqr(l-a[4]))*a[2];
                          dz:=ImgDouble^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     end;
               end;
             1:begin
               for i:=1 to Larg do
                  case TypeData of
                     2,7:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite
                          // A[3] x
                          // A[4] y
                          // A[5] sigma
                          // A[6] coef x du polynome
                          // A[7] coef y du polynome
                          zmod:=0;
                          SigmaX2:=Sqr(a[5]);
                          Tmp:=exp(-sqr((i-a[3])/a[5])/2)*exp(-sqr((l-a[4])/a[5])/2);
                          zmod:=zmod+a[1]+a[6]*i+a[7]*l+a[2]*Tmp;
                          dyda[1]:=1;
                          dyda[2]:=Tmp;
                          dyda[3]:=Tmp/SigmaX2*(i-a[3])*a[2];
                          dyda[4]:=Tmp/SigmaX2*(l-a[4])*a[2];
                          dyda[5]:=Tmp/(SigmaX2*a[5])*(sqr(i-a[3])+sqr(l-a[4]))*a[2];
                          dyda[6]:=i;
                          dyda[7]:=l;
                          dz:=ImgInt^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     5,8:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite
                          // A[3] x
                          // A[4] y
                          // A[5] sigma
                          // A[6] coef x du polynome
                          // A[7] coef y du polynome
                          zmod:=0;
                          SigmaX2:=Sqr(a[5]);
                          Tmp:=exp(-sqr((i-a[3])/a[5])/2)*exp(-sqr((l-a[4])/a[5])/2);
                          zmod:=zmod+a[1]+a[6]*i+a[7]*l+a[2]*Tmp;
                          dyda[1]:=1;
                          dyda[2]:=Tmp;
                          dyda[3]:=Tmp/SigmaX2*(i-a[3])*a[2];
                          dyda[4]:=Tmp/SigmaX2*(l-a[4])*a[2];
                          dyda[5]:=Tmp/(SigmaX2*a[5])*(sqr(i-a[3])+sqr(l-a[4]))*a[2];
                          dyda[6]:=i;
                          dyda[7]:=l;
                          dz:=ImgDouble^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     end;
               end;
             2:begin
               for i:=1 to Larg do
                  case TypeData of
                     2,7:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite
                          // A[3] x
                          // A[4] y
                          // A[5] sigma
                          // A[6] coef x du polynome
                          // A[7] coef y du polynome
                          // A[8] coef x2 du polynome
                          // A[9] coef xy du polynome
                          // A[10] coef y2 du polynome
                          zmod:=0;
                          SigmaX2:=Sqr(a[5]);
                          Tmp:=exp(-sqr((l-a[4])/a[5])/2)*exp(-sqr((i-a[3])/a[5])/2);
                          zmod:=zmod+a[1]+a[6]*i+a[7]*l+a[8]*i*i+a[9]*i*l+a[10]*l*l+a[2]*Tmp;
                          dyda[1]:=1;
                          dyda[2]:=Tmp;
                          dyda[3]:=(i-a[3])*a[2]*Tmp/SigmaX2;
                          dyda[4]:=(l-a[4])*a[2]*Tmp/SigmaX2;
                          dyda[5]:=(sqr(i-a[3])+sqr(l-a[4]))*a[2]*Tmp/(SigmaX2*a[5]);
                          dyda[6]:=i;
                          dyda[7]:=l;
                          dyda[8]:=sqr(i);
                          dyda[9]:=i*l;
                          dyda[10]:=sqr(l);
                          dz:=ImgInt^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     5,8:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite
                          // A[3] x
                          // A[4] y
                          // A[5] sigma
                          // A[6] coef x du polynome
                          // A[7] coef y du polynome
                          // A[8] coef x2 du polynome
                          // A[9] coef xy du polynome
                          // A[10] coef y2 du polynome
                          zmod:=0;
                          SigmaX2:=Sqr(a[5]);
                          Tmp:=exp(-sqr((l-a[4])/a[5])/2)*exp(-sqr((i-a[3])/a[5])/2);
                          zmod:=zmod+a[1]+a[6]*i+a[7]*l+a[8]*i*i+a[9]*i*l+a[10]*l*l+a[2]*Tmp;
                          dyda[1]:=1;
                          dyda[2]:=Tmp;
                          dyda[3]:=(i-a[3])*a[2]*Tmp/SigmaX2;
                          dyda[4]:=(l-a[4])*a[2]*Tmp/SigmaX2;
                          dyda[5]:=(sqr(i-a[3])+sqr(l-a[4]))*a[2]*Tmp/(SigmaX2*a[5]);
                          dyda[6]:=i;
                          dyda[7]:=l;
                          dyda[8]:=sqr(i);
                          dyda[9]:=i*l;
                          dyda[10]:=sqr(l);
                          dz:=ImgDouble^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     end;
               end;
          end;
   TGaussEllipse:case Degre of
             0:begin
               for i:=1 to Larg do
                  case TypeData of
                     2,7:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite
                          // A[3] x
                          // A[4] y
                          // A[5] sigma x
                          // A[6] sigma y
                          // A[7] theta
                          zmod:=0;
                          CosAngle:=Cos(a[7]);
                          SinAngle:=Sin(a[7]);
                           SigmaX2:=Sqr(a[5]);
                          SigmaY2:=Sqr(a[6]);
                          Tmp:=exp(-sqr(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/(2*SigmaY2))*
                               exp(-sqr((i-a[3])*CosAngle+(l-a[4])*SinAngle)/(2*SigmaX2));
                          zmod:=zmod+a[1]+a[2]*Tmp;
                          dyda[1]:=1;
                          dyda[2]:=Tmp;
                          dyda[3]:=(-CosAngle*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaX2
                                   +SinAngle*((i-a[3])*SinAngle-(l-a[4])*CosAngle)/SigmaY2)*a[2]*Tmp;
                          dyda[4]:=(-SinAngle*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaX2
                                   -CosAngle*((i-a[3])*SinAngle-(l-a[4])*CosAngle)/SigmaY2)*a[2]*Tmp;
                          dyda[5]:=(sqr((i-a[3])*CosAngle+(l-a[4])*SinAngle)/(SigmaX2*a[5]))*a[2]*Tmp;
                          dyda[6]:=(sqr(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/(SigmaY2*a[6]))*a[2]*Tmp;
                          dyda[7]:=(-((i-a[3])*CosAngle+(l-a[4])*SinAngle)*(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/SigmaX2
                                    -(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaY2)*a[2]*Tmp;

                          dz:=ImgInt^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     5,8:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite
                          // A[3] x
                          // A[4] y
                          // A[5] sigma x
                          // A[6] sigma y
                          // A[7] theta
                          zmod:=0;
                          CosAngle:=Cos(a[7]);
                          SinAngle:=Sin(a[7]);
                          SigmaX2:=Sqr(a[5]);
                          SigmaY2:=Sqr(a[6]);
                          Tmp:=exp(-sqr(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/(2*SigmaY2))*
                               exp(-sqr((i-a[3])*CosAngle+(l-a[4])*SinAngle)/(2*SigmaX2));
                          zmod:=zmod+a[1]+a[2]*Tmp;

                          dyda[1]:=1;
                          dyda[2]:=Tmp;
                          dyda[3]:=(-CosAngle*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaX2
                                    +SinAngle*( (i-a[3])*SinAngle-(l-a[4])*CosAngle)/SigmaY2)*a[2]*Tmp;
                          dyda[4]:=(-SinAngle*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaX2
                                    -CosAngle*( (i-a[3])*SinAngle-(l-a[4])*CosAngle)/SigmaY2)*a[2]*Tmp;
                          dyda[5]:=(sqr((i-a[3])*CosAngle+(l-a[4])*SinAngle)/(SigmaX2*a[5]))*a[2]*Tmp;
                          dyda[6]:=(sqr(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/(SigmaY2*a[6]))*a[2]*Tmp;
                          dyda[7]:=(-((i-a[3])*CosAngle+(l-a[4])*SinAngle)*(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/SigmaX2
                                    -(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaY2)*a[2]*Tmp;

                          dz:=ImgDouble^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     end;
               end;
             1:begin
               for i:=1 to Larg do
                  case TypeData of
                     2,7:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite max
                          // A[3] x
                          // A[4] y
                          // A[5] sigma x
                          // A[6] sigma y
                          // A[7] theta
                          // A[8] coef x du polynome
                          // A[9] coef y du polynome
                          zmod:=0;
                          CosAngle:=Cos(a[7]);
                          SinAngle:=Sin(a[7]);
                          SigmaX2:=Sqr(a[5]);
                          SigmaY2:=Sqr(a[6]);
                          Tmp:=exp(-sqr(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/(2*SigmaY2))*
                               exp(-sqr((i-a[3])*CosAngle+(l-a[4])*SinAngle)/(2*SigmaX2));

                          zmod:=zmod+a[1]+a[8]*i+a[9]*l+a[2]*Tmp;
                          dyda[1]:=1;
                          dyda[2]:=Tmp;
                          dyda[3]:=(-CosAngle*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaX2
                                    +SinAngle*((i-a[3])*SinAngle-(l-a[4])*CosAngle)/SigmaY2)*a[2]*Tmp;
                          dyda[4]:=(-SinAngle*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaX2
                                    -CosAngle*((i-a[3])*SinAngle-(l-a[4])*CosAngle)/SigmaY2)*a[2]*Tmp;
                          dyda[5]:=(sqr((i-a[3])*CosAngle+(l-a[4])*SinAngle)/(SigmaX2*a[5]))*a[2]*Tmp;
                          dyda[6]:=(sqr(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/(SigmaY2*a[6]))*a[2]*Tmp;
                          dyda[7]:=(-( (i-a[3])*CosAngle+(l-a[4])*SinAngle)*(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/SigmaX2
                                    -(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaY2)*a[2]*Tmp;
                          dyda[8]:=i;
                          dyda[9]:=l;

                          dz:=ImgInt^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
//                          chisq:=chisq+dz*dz/ImgInt^[1]^[l]^[i]; // test de prise en compte de l'incertitude
//                          chisq:=chisq+dz*dz/0.0000001; // Change rien
                          chisq:=chisq+dz*dz;
                          end;
                     5,8:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[4] intensite max
                          // A[5] x
                          // A[6] y
                          // A[7] sigma x
                          // A[8] sigma y
                          // A[9] theta
                          // A[2] coef x du polynome
                          // A[3] coef y du polynome
                          zmod:=0;
                          CosAngle:=Cos(a[7]);
                          SinAngle:=Sin(a[7]);
                          SigmaX2:=Sqr(a[5]);
                          SigmaY2:=Sqr(a[6]);
                          Tmp:=exp(-sqr(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/(2*SigmaY2))*
                               exp(-sqr((i-a[3])*CosAngle+(l-a[4])*SinAngle)/(2*SigmaX2));

                          zmod:=zmod+a[1]+a[8]*i+a[9]*l+a[2]*Tmp;
                          dyda[1]:=1;
                          dyda[2]:=Tmp;
                          dyda[3]:=(-CosAngle*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaX2
                                    +SinAngle*((i-a[3])*SinAngle-(l-a[4])*CosAngle)/SigmaY2)*a[2]*Tmp;
                          dyda[4]:=(-SinAngle*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaX2
                                    -CosAngle*((i-a[3])*SinAngle-(l-a[4])*CosAngle)/SigmaY2)*a[2]*Tmp;
                          dyda[5]:=(sqr((i-a[3])*CosAngle+(l-a[4])*SinAngle)/(SigmaX2*a[5]))*a[2]*Tmp;
                          dyda[6]:=(sqr(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/(SigmaY2*a[6] ))*a[2]*Tmp;
                          dyda[7]:=(-((i-a[3])*CosAngle+(l-a[4])*SinAngle)*(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/SigmaX2
                                    -(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaY2)*a[2]*Tmp;
                          dyda[8]:=i;
                          dyda[9]:=l;

                          dz:=ImgDouble^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     end;
               end;
             2:begin
               for i:=1 to Larg do
                  case TypeData of
                     2,7:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite
                          // A[3] x
                          // A[4] y
                          // A[5] sigma x
                          // A[6] sigma y
                          // A[7] theta
                          // A[8] coef x du polynome
                          // A[9] coef y du polynome
                          // A[10] coef x2 du polynome
                          // A[11] coef xy du polynome
                          // A[12] coef y2 du polynome
                          zmod:=0;
                          CosAngle:=Cos(a[7]);
                          SinAngle:=Sin(a[7]);
                          SigmaX2:=Sqr(a[5]);
                          SigmaY2:=Sqr(a[6]);
                          Tmp:=exp(-sqr(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/(2*SigmaY2))*
                               exp(-sqr((i-a[3])*CosAngle+(l-a[4])*SinAngle)/(2*SigmaX2));

                          zmod:=zmod+a[1]+a[8]*i+a[9]*l+a[10]*i*i+a[11]*i*l+a[12]*l*l+a[2]*Tmp;
                          dyda[1]:=1;
                          dyda[2]:=Tmp;
                          dyda[3]:=(-CosAngle*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaX2
                                    +SinAngle*((i-a[3])*SinAngle-(l-a[4])*CosAngle)/SigmaY2)*a[2]*Tmp;
                          dyda[4]:=(-SinAngle*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaX2
                                    -CosAngle*((i-a[3])*SinAngle-(l-a[4])*CosAngle)/SigmaY2)*a[2]*Tmp;
                          dyda[5]:=(sqr((i-a[3])*CosAngle+(l-a[4])*SinAngle)/(SigmaX2*a[5]))*a[2]*Tmp;
                          dyda[6]:=(sqr(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/(SigmaY2*a[6]))*a[2]*Tmp;
                          dyda[7]:=(-((i-a[3])*CosAngle+(l-a[4])*SinAngle)*(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/SigmaX2
                                    -(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaY2)*a[2]*Tmp;
                          dyda[8]:=i;
                          dyda[9]:=l;
                          dyda[10]:=sqr(i);
                          dyda[11]:=i*l;
                          dyda[12]:=sqr(l);

                          dz:=ImgInt^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     5,8:for l:=1 to Larg do
                          begin
                          // A[1] fond du ciel
                          // A[2] intensite
                          // A[3] x
                          // A[4] y
                          // A[5] sigma x
                          // A[6] sigma y
                          // A[7] theta
                          // A[8] coef x du polynome
                          // A[9] coef y du polynome
                          // A[10] coef x2 du polynome
                          // A[11] coef xy du polynome
                          // A[12] coef y2 du polynome
                          zmod:=0;
                          CosAngle:=Cos(a[7]);
                          SinAngle:=Sin(a[7]);
                          SigmaX2:=Sqr(a[5]);
                          SigmaY2:=Sqr(a[6]);
                          Tmp:=exp(-sqr(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/(2*SigmaY2))*
                               exp(-sqr((i-a[3])*CosAngle+(l-a[4])*SinAngle)/(2*SigmaX2));

                          zmod:=zmod+a[1]+a[8]*i+a[9]*l+a[10]*i*i+a[11]*i*l+a[12]*l*l+a[2]*Tmp;
                          dyda[1]:=1;
                          dyda[2]:=Tmp;
                          dyda[3]:=(-CosAngle*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaX2
                                    +SinAngle*((i-a[3])*SinAngle-(l-a[4])*CosAngle)/SigmaY2)*a[2]*Tmp;
                          dyda[4]:=(-SinAngle*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaX2
                                    -CosAngle*((i-a[3])*SinAngle-(l-a[4])*CosAngle)/SigmaY2)*a[2]*Tmp;
                          dyda[5]:=(sqr((i-a[3])*CosAngle+(l-a[4])*SinAngle)/(SigmaX2*a[5]))*a[2]*Tmp;
                          dyda[6]:=(sqr(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/(SigmaY2*a[6]))*a[2]*Tmp;
                          dyda[7]:=(-((i-a[3])*CosAngle+(l-a[4])*SinAngle)*(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)/SigmaX2
                                    -(-(i-a[3])*SinAngle+(l-a[4])*CosAngle)*(-(i-a[3])*CosAngle-(l-a[4])*SinAngle)/SigmaY2)*a[2]*Tmp;
                          dyda[8]:=i;
                          dyda[9]:=l;
                          dyda[10]:=sqr(i);
                          dyda[11]:=i*l;
                          dyda[12]:=sqr(l);

                          dz:=ImgDouble^[1]^[l]^[i]-zmod;
                          for j:=1 to ma do
                             begin
                             wt:=dyda[j];
                             for k:=1 to j do
                                alpha[j,k]:=alpha[j,k]+wt*dyda[k];
                             beta[j]:=beta[j]+dz*wt;
                             end;
                          chisq:=chisq+dz*dz;
                          end;
                     end;
               end;
             end;
   end;
for j:=2 to ma do // Fill in the symmetric side
   for k:=1 to j-1 do alpha[k,j]:=alpha[j,k];
end;

begin
Result:=True;

Case Precision of
   LowPrecision: CoefAlamda:=5;
   MeanPrecision:CoefAlamda:=2;
   HighPrecision:CoefAlamda:=1;
   end;

if alamda<0 then
   begin
   alamda:=1;
   if not mrqcof(ImgInt,ImgDouble,TypeData,a,alpha,MrqminBeta,chisq,TypeModele,Degre) then
      begin
      Result:=False;
      Exit;
      end;
   Mrqmin0chisq:=chisq;
   for j:=1 to ma do atry[j]:=a[j];
   end;

for j:=1 to ma do
   begin
   for k:=1 to ma do covar[j,k]:=alpha[j,k];
   covar[j,j]:=alpha[j,j]*(1+alamda);
   oneda[j,1]:=MrqminBeta[j];
//   oneda[j]:=MrqminBeta[j];
   end;

if not gaussj(covar,ma,oneda,1) then
   begin
   Result:=False;
   Exit;
   end;

// Remplace gaussj en plus rapide ?
// Non car il faut inverser la matrice de toute facon !
//LudCmp(covar,ma,Indx,d);
//Lubksb(covar,ma,Indx,Oneda);


for j:=1 to ma do da[j]:=oneda[j,1];
//for j:=1 to ma do da[j]:=oneda[j];
if alamda=0 then goto fin;

for j:=1 to ma do atry[j]:=a[j]+da[j];

if not mrqcof(ImgInt,ImgDouble,TypeData,atry,covar,da,chisq,TypeModele,Degre) then
   begin
   Result:=False;
   Exit;
   end;

if chisq<Mrqmin0chisq then
   begin
   alamda:=1/CoefAlamda*alamda;
   Mrqmin0chisq:=chisq;
   for j:=1 to ma do
      begin
      for k:=1 to ma do alpha[j,k]:=covar[j,k];
      MrqminBeta[j]:=da[j];
      a[j]:=atry[j];
      end;
   end
else
   begin
   alamda:=CoefAlamda*alamda;
   chisq:=Mrqmin0chisq;
   end;

fin:
end;

//procedure ModeliseEtoile(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;TypeData:Byte;
//   Larg,x,y:Integer;TypeModele,Precision,Select:Byte;Degre:Byte;var PSF:TPSF);
procedure ModeliseEtoile(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;TypeData:Byte;
   Larg:Integer;TypeModele,Precision,Select:Byte;Degre:Byte;var PSF:TPSF);
var
x,y:Integer;
NoIteration,i,j,ma,MaxIter:Integer;
Covar,Alpha:DoubleArray;
Chisq,Alamda,MaxAlamda:Double;
a:DoubleArrayRow;
Fini:Boolean;
DFluxMax,FluxMax,DFluxMin,FluxMin,Temp:Double;
OK:Boolean;
ValMax,Valeur:Double;
NotInfini:Integer;
begin
PSF.X:=Larg div 2;
PSF.Y:=Larg div 2;

// On initialise x et y avec le maximum
ValMax:=-32768;
for j:=1 to Larg do
   case TypeData of
      2,7:for i:=1 to Larg do
           begin
           Valeur:=ImgInt^[1]^[j]^[i];
           if Valeur>ValMax then
              begin
              ValMax:=Valeur;
              x:=i;
              y:=j;
              end;
           end;
      5,8:for i:=1 to Larg do
           begin
           Valeur:=ImgDouble^[1]^[j]^[i];
           if Valeur>ValMax then
              begin
              ValMax:=Valeur;
              x:=i;
              y:=j;
              end;
           end;
      end;

for i:=1 to MaxArray do
   for j:=1 to MaxArray do covar[i,j]:=0;
for i:=1 to MaxArray do
   for j:=1 to MaxArray do alpha[i,j]:=0;

case TypeModele of
   TMoffat:begin
          case Degre of
             0:begin
               ma:=6;
               // A[1] fond du ciel
               // A[2] intensite
               // A[3] x
               // A[4] y
               // A[5] Coeff a de Moffat
               // A[6] Coeff b de Moffat
               case TypeData of
                  2,7:begin
                    a[1]:=(ImgInt^[1]^[1]^[1]+ImgInt^[1]^[Larg]^[1]+
                           ImgInt^[1]^[1]^[Larg]+ImgInt^[1]^[Larg]^[Larg])/4;
                    a[2]:=ImgInt^[1]^[y]^[x]-a[1];
                    a[3]:=x;
                    a[4]:=y;
                    a[5]:=2;
                    a[6]:=5;
                    end;
                  5,8:begin
                    a[1]:=(ImgDouble^[1]^[1]^[1]+ImgDouble^[1]^[Larg]^[1]+
                           ImgDouble^[1]^[1]^[Larg]+ImgDouble^[1]^[Larg]^[Larg])/4;
                    a[2]:=ImgDouble^[1]^[y]^[x]-a[1];
                    a[3]:=x;
                    a[4]:=y;
                    a[5]:=2;
                    a[6]:=5;
                    end;
                  end;
               end;
             1:begin
               ma:=8;
               // A[1] fond du ciel
               // A[2] intensite
               // A[3] x
               // A[4] y
               // A[5] Coeff a de Moffat
               // A[6] Coeff b de Moffat
               // A[7] coef x du polynome
               // A[8] coef y du polynome
               case TypeData of
                  2,7:begin
                    a[1]:=(ImgInt^[1]^[1]^[1]+ImgInt^[1]^[Larg]^[1]+
                           ImgInt^[1]^[1]^[Larg]+ImgInt^[1]^[Larg]^[Larg])/4;
                    a[2]:=ImgInt^[1]^[y]^[x]-a[1];
                    a[3]:=x;
                    a[4]:=y;
                    a[5]:=2;
                    a[6]:=5;
                    a[7]:=0;
                    a[8]:=0;
                    end;
                  5,8:begin
                    a[1]:=(ImgDouble^[1]^[1]^[1]+ImgDouble^[1]^[Larg]^[1]+
                           ImgDouble^[1]^[1]^[Larg]+ImgDouble^[1]^[Larg]^[Larg])/4;
                    a[2]:=ImgDouble^[1]^[y]^[x]-a[1];
                    a[3]:=x;
                    a[4]:=y;
                    a[5]:=2;
                    a[6]:=5;
                    a[7]:=0;
                    a[8]:=0;
                    end;
                  end;
               end;
             2:begin
               ma:=11;
               // A[1] fond du ciel
               // A[2] intensite
               // A[3] x
               // A[4] y
               // A[5] Coeff a de Moffat
               // A[6] Coeff b de Moffat
               // A[7] coef x du polynome
               // A[8] coef y du polynome
               // A[9] coef x2 du polynome
               // A[10] coef xy du polynome
               // A[11] coef y2 du polynome
               case TypeData of
                  2,7:begin
                    a[1]:=(ImgInt^[1]^[1]^[1]+ImgInt^[1]^[Larg]^[1]+
                           ImgInt^[1]^[1]^[Larg]+ImgInt^[1]^[Larg]^[Larg])/4;
                    a[2]:=ImgInt^[1]^[y]^[x]-a[1];
                    a[3]:=x;
                    a[4]:=y;
                    a[5]:=2;
                    a[6]:=5;
                    a[7]:=0;
                    a[8]:=0;
                    a[9]:=0;
                    a[10]:=0;
                    a[11]:=0;
                    end;
                  5,8:begin
                    a[1]:=(ImgDouble^[1]^[1]^[1]+ImgDouble^[1]^[Larg]^[1]+
                           ImgDouble^[1]^[1]^[Larg]+ImgDouble^[1]^[Larg]^[Larg])/4;
                    a[2]:=ImgDouble^[1]^[y]^[x]-a[1];
                    a[3]:=x;
                    a[4]:=y;
                    a[5]:=2;
                    a[6]:=5;
                    a[7]:=0;
                    a[8]:=0;
                    a[9]:=0;
                    a[10]:=0;
                    a[11]:=0;
                    end;
                  end;
               end;
             end;
          end;
   TGauss:begin
          case Degre of
             0:begin
               // A[1] fond du ciel
               // A[2] intensite
               // A[3] x
               // A[4] y
               // A[5] sigma
               ma:=5;
               case TypeData of
                  2,7:begin
                    a[1]:=(ImgInt^[1]^[1]^[1]+ImgInt^[1]^[Larg]^[1]+ImgInt^[1]^[1]^[Larg]+ImgInt^[1]^[Larg]^[Larg])/4;
                    a[2]:=ImgInt^[1]^[y]^[x]-a[1];
                    a[3]:=x;
                    a[4]:=y;
                    a[5]:=1;
                    end;
                  5,8:begin
                    a[1]:=(ImgDouble^[1]^[1]^[1]+ImgDouble^[1]^[Larg]^[1]+ImgDouble^[1]^[1]^[Larg]+ImgDouble^[1]^[Larg]^[Larg])/4;
                    a[2]:=ImgDouble^[1]^[y]^[x]-a[1];
                    a[3]:=x;
                    a[4]:=y;
                    a[5]:=1;
                    end;
                  end;
               end;
             1:begin
               // A[1] fond du ciel
               // A[2] intensite
               // A[3] x
               // A[4] y
               // A[5] sigma
               // A[6] coef x du polynome
               // A[7] coef y du polynome
               ma:=7;
               case TypeData of
                  2,7:begin
                    a[1]:=(ImgInt^[1]^[1]^[1]+ImgInt^[1]^[Larg]^[1]+ImgInt^[1]^[1]^[Larg]+ImgInt^[1]^[Larg]^[Larg])/4;
                    a[2]:=ImgInt^[1]^[y]^[x]-a[1];
                    a[3]:=x;
                    a[4]:=y;
                    a[5]:=1;
                    a[6]:=0;
                    a[7]:=0;
                    end;
                  5,8:begin
                    a[1]:=(ImgDouble^[1]^[1]^[1]+ImgDouble^[1]^[Larg]^[1]+ImgDouble^[1]^[1]^[Larg]+ImgDouble^[1]^[Larg]^[Larg])/4;
                    a[2]:=ImgDouble^[1]^[y]^[x]-a[1];
                    a[3]:=x;
                    a[4]:=y;
                    a[5]:=1;
                    a[6]:=0;
                    a[7]:=0;
                    end;
                  end;
               end;
             2:begin
               // A[1] fond du ciel
               // A[2] intensite
               // A[3] x
               // A[4] y
               // A[5] sigma
               // A[6] coef x du polynome
               // A[7] coef y du polynome
               // A[8] coef x2 du polynome
               // A[9] coef xy du polynome
               // A[10] coef y2 du polynome
               ma:=10;
               case TypeData of
                  2,7:begin
                    a[1]:=(ImgInt^[1]^[1]^[1]+ImgInt^[1]^[Larg]^[1]+ImgInt^[1]^[1]^[Larg]+ImgInt^[1]^[Larg]^[Larg])/4;
                    a[2]:=ImgInt^[1]^[y]^[x]-a[1];
                    a[3]:=x;
                    a[4]:=y;
                    a[5]:=1;
                    a[6]:=0;
                    a[7]:=0;
                    a[8]:=0;
                    a[9]:=0;
                    a[10]:=0;
                    end;
                  5,8:begin
                    a[1]:=(ImgDouble^[1]^[1]^[1]+ImgDouble^[1]^[Larg]^[1]+ImgDouble^[1]^[1]^[Larg]+ImgDouble^[1]^[Larg]^[Larg])/4;
                    a[2]:=ImgDouble^[1]^[y]^[x]-a[1];
                    a[3]:=x;
                    a[4]:=y;
                    a[5]:=1;
                    a[6]:=0;
                    a[7]:=0;
                    a[8]:=0;
                    a[9]:=0;
                    a[10]:=0;
                    end;
                  end;
               end;
             end;
          end;
   TGaussEllipse:begin
                 case Degre of
                    0:begin
                      // A[1] fond du ciel
                      // A[2] intensite
                      // A[3] x
                      // A[4] y
                      // A[5] sigma x
                      // A[6] sigma y
                      // A[7] theta
                      ma:=7;
                      case TypeData of
                         2,7:begin
                           a[1]:=(ImgInt^[1]^[1]^[1]+ImgInt^[1]^[Larg]^[1]+ImgInt^[1]^[1]^[Larg]+ImgInt^[1]^[Larg]^[Larg])/4;
                           a[2]:=ImgInt^[1]^[y]^[x]-a[1];
                           a[3]:=x; a[4]:=y;
                           a[5]:=1.5;
                           a[6]:=1.6;
                           a[7]:=0;
                           end;
                         5,8:begin
                           a[1]:=(ImgDouble^[1]^[1]^[1]+ImgDouble^[1]^[Larg]^[1]+ImgDouble^[1]^[1]^[Larg]+ImgDouble^[1]^[Larg]^[Larg])/4;
                           a[2]:=ImgDouble^[1]^[y]^[x]-a[1];
                           a[3]:=x; a[4]:=y;
                           a[5]:=1.5;
                           a[6]:=1.6;
                           a[7]:=0;
                           end;
                         end;
                      end;
                    1:begin
                      // A[1] fond du ciel
                      // A[2] intensite max
                      // A[3] x
                      // A[4] y
                      // A[5] sigma x
                      // A[6] sigma y
                      // A[7] theta
                      // A[8] coef x du polynome
                      // A[9] coef y du polynome
                      ma:=9;
                      case TypeData of
                         2,7:begin
                           a[1]:=(ImgInt^[1]^[1]^[1]+ImgInt^[1]^[Larg]^[1]+ImgInt^[1]^[1]^[Larg]+ImgInt^[1]^[Larg]^[Larg])/4;
                           a[2]:=ImgInt^[1]^[y]^[x]-a[1];
                           a[3]:=x;
                           a[4]:=y;
                           a[5]:=1.5;
                           a[6]:=1.6;
                           a[7]:=0;
                           a[8]:=0;
                           a[9]:=0;
                           end;
                         5,8:begin
                           a[1]:=(ImgDouble^[1]^[1]^[1]+ImgDouble^[1]^[Larg]^[1]+ImgDouble^[1]^[1]^[Larg]+ImgDouble^[1]^[Larg]^[Larg])/4;
                           a[2]:=ImgDouble^[1]^[y]^[x]-a[1];
                           a[3]:=x;
                           a[4]:=y;
                           a[5]:=1.5;
                           a[6]:=1.6;
                           a[7]:=0;
                           a[8]:=0;
                           a[9]:=0;
                           end;
                         end;
                      end;
                    2:begin
                      // A[1] fond du ciel
                      // A[2] intensite
                      // A[3] x
                      // A[4] y
                      // A[5] sigma x
                      // A[6] sigma y
                      // A[7] theta
                      // A[8] coef x du polynome
                      // A[9] coef y du polynome
                      // A[10] coef x2 du polynome
                      // A[11] coef xy du polynome
                      // A[12] coef y2 du polynome
                      ma:=12;
                      case TypeData of
                         2,7:begin
                           a[1]:=(ImgInt^[1]^[1]^[1]+ImgInt^[1]^[Larg]^[1]+ImgInt^[1]^[1]^[Larg]+ImgInt^[1]^[Larg]^[Larg])/4;
                           a[2]:=ImgInt^[1]^[y]^[x]-a[1];
                           a[3]:=x;
                           a[4]:=y;
                           a[5]:=1.5;
                           a[6]:=1.6;
                           a[7]:=0;
                           a[8]:=0;
                           a[9]:=0;
                           a[10]:=0;
                           a[11]:=0;
                           a[12]:=0;
                           end;
                         5,8:begin
                           a[1]:=(ImgDouble^[1]^[1]^[1]+ImgDouble^[1]^[Larg]^[1]+ImgDouble^[1]^[1]^[Larg]+ImgDouble^[1]^[Larg]^[Larg])/4;
                           a[2]:=ImgDouble^[1]^[y]^[x]-a[1];
                           a[3]:=x;
                           a[4]:=y;
                           a[5]:=1.5;
                           a[6]:=1.6;
                           a[7]:=0;
                           a[8]:=0;
                           a[9]:=0;
                           a[10]:=0;
                           a[11]:=0;
                           a[12]:=0;
                           end;
                         end;
                      end
                    else raise ErrorModelisation.Create(lang('Demande de modélisation impossible'));
                    end
                 end;
   end;


Chisq:=1;
Alamda:=-1;
if mrqmin(ImgInt,ImgDouble,TypeData,Larg,a,ma,Covar,Alpha,Chisq,Alamda,TypeModele,Degre,Precision) then
   begin
   case Precision of
//      LowPrecision: begin MaxIter:=10;  MaxAlamda:=0.01; end;
      LowPrecision: begin MaxIter:=5;  MaxAlamda:=1; end;
      MeanPrecision:begin MaxIter:=100; MaxAlamda:=1;    end;
      HighPrecision:begin MaxIter:=500; MaxAlamda:=100;  end;
      end;

   Fini:=False;
   NoIteration:=1;
   while not(Fini) and (NoIteration<=MaxIter) do
      begin
      if Alamda>MaxAlamda then Fini:=True;
      mrqmin(ImgInt,ImgDouble,TypeData,Larg,a,ma,Covar,Alpha,Chisq,Alamda,TypeModele,Degre,Precision);
      Inc(NoIteration);
      end;

//   if fini then ShowMessage('Fini'+IntTostr(NoIteration));
//   if NoIteration>100 then ShowMessage('Iter ');
   Alamda:=0;
   if mrqmin(ImgInt,ImgDouble,TypeData,Larg,a,ma,Covar,Alpha,Chisq,Alamda,TypeModele,Degre,Precision) then
      begin
      case TypeModele of
         TMoffat: begin
                  // A[1] fond du ciel
                  // A[2] intensite
                  // A[3] x
                  // A[4] y
                  // A[5] Coeff a de Moffat
                  // A[6] Coeff b de Moffat
                  PSF.X:=a[3];
                  PSF.DX:=Sqrt(Abs(Covar[3,3])*Chisq/Larg/Larg);
                  PSF.Y:=a[4];
                  PSF.DY:=Sqrt(Abs(Covar[4,4])*Chisq/Larg/Larg);
                  PSF.Sigma:=2*a[5]*sqrt(-1+(PuissanceDouble(2,1/(A[6]-1))));
                  PSF.Flux:=Pi*A[2]*Sqr(A[5])/(A[6]-1); //0.5*2*Pi*H*a^2/(b-1)
                  PSF.aMoffat:=A[5];
                  PSF.bMoffat:=A[6];

                  PSF.IntensiteMax:=a[2];
                  FluxMax:=Pi*(a[2]+Sqrt(Abs(Covar[2,2])*Chisq/Larg/Larg))
                     *sqr((a[5]+Sqrt(Abs(Covar[5,5])*Chisq/Larg/Larg)))/((a[6]-Sqrt(Abs(Covar[6,6])*Chisq/Larg/Larg))-1);
                  DFluxMax:=Abs(PSF.Flux-FluxMax);
                  FluxMin:=Pi*(a[2]-Sqrt(Abs(Covar[2,2])*Chisq/Larg/Larg))
                     *sqr((a[5]-Sqrt(Abs(Covar[5,5])*Chisq/Larg/Larg)))/((a[6]+Sqrt(Abs(Covar[6,6])*Chisq/Larg/Larg))-1);
                  DFluxMin:=Abs(PSF.Flux-FluxMin);
                  if DFluxMax>DFluxMin then PSF.DFlux:=DFluxMax else PSF.DFlux:=DFluxMin;
                  end;
         TGauss:begin
                // A[1] fond du ciel
                // A[2] intensite
                // A[3] x
                // A[4] y
                // A[5] sigma
                PSF.X:=a[3];
                PSF.DX:=Sqrt(Abs(Covar[3,3])*Chisq/Larg/Larg);
                PSF.Y:=a[4];
                PSF.DY:=Sqrt(Abs(Covar[4,4])*Chisq/Larg/Larg);
                PSF.Sigma:=a[5]*2*Sqrt(-2*ln(1/2));
                PSF.Flux:=a[2]*2*pi*sqr(a[5]);
                PSF.IntensiteMax:=a[2];
                DFluxMax:=Abs(PSF.Flux-(a[2]+Sqrt(Abs(Covar[2,2])*Chisq/Larg/Larg))
                   *2*pi*sqr((a[5]+Sqrt(Abs(Covar[5,5])*Chisq/Larg/Larg))));
                DFluxMin:=Abs(PSF.Flux-(a[2]-Sqrt(Abs(Covar[2,2])*Chisq/Larg/Larg))
                   *2*pi*sqr((a[5]-Sqrt(Abs(Covar[5,5])*Chisq/Larg/Larg))));
                if DFluxMax>DFluxMin then PSF.DFlux:=DFluxMax else PSF.DFlux:=DFluxMin;
                end;
         TGaussEllipse:
                  begin
                  // A[1] fond du ciel
                  // A[2] intensite
                  // A[3] x
                  // A[4] y
                  // A[5] sigma x
                  // A[6] sigma y
                  // A[7] theta
                  PSF.X:=a[3];
                  PSF.DX:=Sqrt(Abs(Covar[3,3])*Chisq/Larg/Larg);
//                  PSF.DX:=Sqrt(Abs(Covar[3,3]));
                  PSF.Y:=a[4];
                  PSF.DY:=Sqrt(Abs(Covar[4,4])*Chisq/Larg/Larg);
//                  PSF.DY:=Sqrt(Abs(Covar[4,4]));
                  PSF.SigmaX:=abs(a[5]*2*Sqrt(-2*ln(1/2)));
                  PSF.SigmaY:=abs(a[6]*2*Sqrt(-2*ln(1/2)));
                  PSF.Angle:=a[7];
                  if PSF.SigmaY>PSF.SigmaX then
                     begin
                     Temp:=PSF.SigmaY;
                     PSF.SigmaY:=PSF.SigmaX;
                     PSF.SigmaX:=Temp;
                     PSF.Angle:=PSF.Angle+pi/2;
                     end;
                  NotInfini:=1;
                  while (PSF.Angle<-pi/2) and (NotInfini<1000) do
                     begin
                     PSF.Angle:=PSF.Angle+pi;
                     Inc(NotInfini);
                     end;
                  NotInfini:=1;
                  while (PSF.Angle>pi/2) and (NotInfini<1000) do
                     begin
                     PSF.Angle:=PSF.Angle-pi;
                     Inc(NotInfini);
                     end;
                  PSF.IntensiteMax:=a[2];
                  PSF.Flux:=a[2]*2*pi*a[5]*a[6];
                  DFluxMax:=Abs(PSF.Flux-(a[2]+Sqrt(Abs(Covar[2,2])*Chisq/Larg/Larg))
                     *2*pi*(a[5]+Sqrt(Abs(Covar[5,5])*Chisq/Larg/Larg))*(a[6]+Sqrt(Abs(Covar[6,6])*Chisq/Larg/Larg)));
//                  DFluxMax:=Abs(PSF.Flux-(a[2]+Sqrt(Abs(Covar[2,2])))*2*pi*(a[5]+Sqrt(Abs(Covar[5,5])))
//                     *(a[6]+Sqrt(Abs(Covar[6,6]))));
//                  DFluxMax:=Abs(PSF.Flux-(a[2]+Sqrt(Abs(Covar[2,2])*Chisq))
//                     *2*pi*(a[5]+Sqrt(Abs(Covar[5,5])*Chisq))*(a[6]+Sqrt(Abs(Covar[6,6])*Chisq)));
                  DFluxMin:=Abs(PSF.Flux-(a[2]-Sqrt(Abs(Covar[2,2])*Chisq/Larg/Larg))
                     *2*pi*(a[5]-Sqrt(Abs(Covar[5,5])*Chisq/Larg/Larg))*(a[6]-Sqrt(Abs(Covar[6,6])*Chisq/Larg/Larg)));
//                  DFluxMin:=Abs(PSF.Flux-(a[2]-Sqrt(Abs(Covar[2,2])))*2*pi*(a[5]-Sqrt(Abs(Covar[5,5])))
//                     *(a[6]-Sqrt(Abs(Covar[6,6]))));
//                  DFluxMin:=Abs(PSF.Flux-(a[2]-Sqrt(Abs(Covar[2,2])*Chisq))
//                     *2*pi*(a[5]-Sqrt(Abs(Covar[5,5])*Chisq))*(a[6]-Sqrt(Abs(Covar[6,6])*Chisq)));
                  if DFluxMax>DFluxMin then PSF.DFlux:=DFluxMax else PSF.DFlux:=DFluxMin;
                  end;
            end;
      end
   else PSF.Flux:=-1;
   end
else PSF.Flux:=-1;

// Derniers tests
OK:=True;
if (PSF.X<1) or (PSF.X>Larg)  then OK:=False;
if (PSF.Y<1) or (PSF.Y>Larg)  then OK:=False;
//if PSF.DX>Larg then OK:=False;
//if PSF.DY>Larg then OK:=False;
if PSF.DX>1 then OK:=False;
if PSF.DY>1 then OK:=False;

// On veut parfois avoir les modelisations imprecises meme en demandant
// une grande precision (ex : photometrie) donc test a faire après cette fonction !
if Select=HighSelect then
   begin
   if  PSF.dFlux*100/PSF.Flux>5 then OK:=False;
   end
else if Select=MeanSelect then
   begin
   if  PSF.dFlux*100/PSF.Flux>35 then OK:=False;
   end
else if  PSF.dFlux*100/PSF.Flux>75 then OK:=False;

case TypeModele of
   TGauss:if (PSF.Sigma<0.1) or (PSF.Sigma>Larg/2) then OK:=False;
   TGaussEllipse:if (PSF.SigmaX<0.1) or (PSF.SigmaY<0.1) then OK:=False;
   end;
if not OK then PSF.Flux:=-1;
end;


// Fonction de modelisation d'etoiles
// - Utiliser Precision=LowPrecision et TypeModele=TGauss et Degre=0
//   Pour plus de rapidite ( recalage d'images )
// - Utiliser Precision=MeanPrecision et TypeModele=TGaussEllipse et Degre=1
//   Pour plus de precision ( photometrie et astrometrie auto )
// - Utiliser Precision=HighPrecision et TypeModele=TGaussEllipse et Degre=1
//   pour des mesures tres precises mais ponctuelles
// - Augmenter NbSigmaDetect pour plus de rapidite
// - Diminuer NbSigmaDetect pour plus d'étoiles
// - DemiLarg est la demilargeur de la fenetre d'analyse
//   pour des etoiles 3<DemiLarg<15 generalement
//   on pourra faire des essais avec des valeurs supperieures pour des etoiles defocalisees
procedure ModeliseSources(ImgInt:PTabimgInt;ImgDouble:PTabimgDouble;TypeData,NbPlans:Byte;
          LargX,LargY,DemiLarg:Integer;var ListePSF:PListePSF;
          TypeModele,Precision,Select:Byte;var NBSources:Integer; NbSigmaDetect:Double;WriteInFile:Boolean;FileName:String;
          WriteInRapport:Boolean);
var
i,j,k,Larg,PosX,PosY:Integer;
ImgInt2:PTabImgInt;
ImgDouble2:PTabImgDouble;
NBSourcesModelisees:integer;
T:TextFile;
ListePSF1:PListePSF;
Degre:Byte;
Trouve:Boolean;
begin
Larg:=2*DemiLarg+1;

Case Precision of
   LowPrecision :Degre:=0;
   MeanPrecision:Degre:=1;
   HighPrecision:Degre:=1;
   end;

{case TypeData of
   2,7:begin
       Getmem(ImgInt2,4);
       Getmem(ImgInt2^[1],4*LargY);
       for i:=1 to LargY do Getmem(ImgInt2^[1]^[i],LargX*2);
       end;
   5,6,8:begin
         Getmem(ImgDouble2,4);
         Getmem(ImgDouble2^[1],4*LargY);
         for i:=1 to LargY do Getmem(ImgDouble2^[1]^[i],LargX*8);
         end;
   end;}
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

{$IFDEF DEBUG}
FindSources(ImgInt,ImgDouble,TypeData,NbPlans,LargX,LargY,ListePSF,NbSources,NbSigmaDetect,true,'c:\TestFindSources.txt'); //nolang
{$ELSE}
FindSources(ImgInt,ImgDouble,TypeData,NbPlans,LargX,LargY,ListePSF,NbSources,NbSigmaDetect,false,'');
{$ENDIF}

{$IFDEF DEBUG}
// Y en a pas !
//AssignFile(T,'C:\EtoilesVoisines.txt');
//Rewrite(T);
//for i:=1 to NBSourcesModelisees do
//   for j:=1 to NBSourcesModelisees do
//      if (Sqrt(Sqr(ListePSF^[i].X-ListePSF^[j].X)+Sqr(ListePSF^[i].Y-ListePSF^[j].Y))<1) and (i<>j) then
//         begin
//         Writeln(T,MyFloatToStr(ListePSF^[i].X,3)+'/'+MyFloatToStr(ListePSF^[j].X,3)); //nolang
//         Writeln(T,MyFloatToStr(ListePSF^[i].Y,3)+'/'+MyFloatToStr(ListePSF^[j].Y,3)); //nolang
//         Writeln(T,' '); //nolang
//         end;
//Close(T);
{$ENDIF}

//AssignFile(T,'C:\Debug.txt');
//Rewrite(T);
//Writeln(T,Format(lang('%d sources'),[NBSources]));



NBSourcesModelisees:=0;
for i:=1 to NbSources do
   begin
   PosX:=Round(ListePSF^[i].x);
   PosY:=Round(ListePSF^[i].y);
   if (PosX>DemiLarg) and (PosX<LargX-DemiLarg) and (PosY>DemiLarg) and (PosY<LargY-DemiLarg) then
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

//      ModeliseEtoile(ImgInt2,ImgDouble2,TypeData,Larg,DemiLarg,DemiLarg,TypeModele,Precision,Select,Degre,ListePSF^[i]);
      ModeliseEtoile(ImgInt2,ImgDouble2,TypeData,Larg,TypeModele,Precision,Select,Degre,ListePSF^[i]);

      if (ListePSF^[i].Flux<>-1) then
         begin
         ListePSF^[i].X:=ListePSF^[i].X+PosX-DemiLarg-1;
         ListePSF^[i].Y:=ListePSF^[i].Y+PosY-DemiLarg-1;

         // Supprimer les doublons
         Trouve:=False;
         for j:=1 to i do
            if (Sqrt(Sqr(ListePSF^[i].X-ListePSF^[j].X)+Sqr(ListePSF^[i].Y-ListePSF^[j].Y))<1) and (i<>j)
               and (ListePSF^[j].Flux<>-1) then
               Trouve:=True;

         if not(Trouve) then Inc(NBSourcesModelisees) else ListePSF^[i].Flux:=-1;
         end;
      end
   else ListePSF^[i].Flux:=-1;
   end;

//Close(T);

// On transfere dans une nouvelle liste en supprimant les non modelisées
Getmem(ListePSF1,NBSourcesModelisees*Sizeof(TPSF));
j:=0;
for i:=1 to NBSources do
   begin
   if ListePSF^[i].Flux<>-1 then
      begin
      inc(j);
      ListePSF1^[j]:=ListePSF^[i];
      end;
   end;

{i:=0;
j:=1;
while i<NBSourcesModelisees do
   begin
   while ListePSF^[j].Flux=-1 do inc(j);
   ListePSF1^[i]:=ListePSF^[j];
   inc(i);
   inc(j)
   end;}

Freemem(ListePSF,NBSources*Sizeof(TPSF));
ListePSF:=ListePSF1;

// On ecrit dans un fichier si demande
if WriteInFile then
   begin
   AssignFile(T,FileName);
   Rewrite(T);
   Writeln(T,Format(lang('%d sources modélisées'),[NBSourcesModelisees]));
   Writeln(T);
   for i:=1 to NBSourcesModelisees do
      begin
         begin
         Case TypeModele of
            TGauss:begin
                   Writeln(T,'X= '+FloatToStr(ListePSF^[i].X)+'+/-'+FloatToStr(ListePSF^[i].DX)); //nolang
                   Writeln(T,'Y= '+FloatToStr(ListePSF^[i].Y)+'+/-'+FloatToStr(ListePSF^[i].DY)); //nolang
                   Writeln(T,'F= '+FloatToStr(ListePSF^[i].Flux)+'+/-'+FloatToStr(ListePSF^[i].DFlux)); //nolang
                   Writeln(T,'S= '+FloatToStr(ListePSF^[i].Sigma)); //nolang
                   Writeln(T);
                   end;
            TGaussEllipse:begin
                   Writeln(T,'X= '+FloatToStr(ListePSF^[i].X)+'+/-'+FloatToStr(ListePSF^[i].DX)); //nolang
                   Writeln(T,'Y= '+FloatToStr(ListePSF^[i].Y)+'+/-'+FloatToStr(ListePSF^[i].DY)); //nolang
                   Writeln(T,'F= '+FloatToStr(ListePSF^[i].Flux)+'+/-'+FloatToStr(ListePSF^[i].DFlux)); //nolang
                   Writeln(T,'SX= '+FloatToStr(ListePSF^[i].SigmaX)); //nolang
                   Writeln(T,'SY= '+FloatToStr(ListePSF^[i].SigmaY)); //nolang
                   Writeln(T,'A= '+FloatToStr(ListePSF^[i].Angle)); //nolang
                   Writeln(T);
                   end;
            end;
          end;
      end;
   Close(T);
   end;

NBSources:=NBSourcesModelisees;

{$IFDEF DEBUG}
AssignFile(T,'C:\EtoilesVoisines2.txt'); //nolang
Rewrite(T);
for i:=1 to NBSourcesModelisees do
   for j:=1 to NBSourcesModelisees do
      if (Sqrt(Sqr(ListePSF^[i].X-ListePSF^[j].X)+Sqr(ListePSF^[i].Y-ListePSF^[j].Y))<1) and (i<>j) then
         begin
         Writeln(T,MyFloatToStr(ListePSF^[i].X,3)+'/'+MyFloatToStr(ListePSF^[j].X,3)); //nolang
         Writeln(T,MyFloatToStr(ListePSF^[i].Y,3)+'/'+MyFloatToStr(ListePSF^[j].Y,3)); //nolang
         Writeln(T,' '); //nolang
         end;
Close(T);
{$ENDIF}

finally
{case TypeData of
   2,7:begin
       for i:=1 to LargY do Freemem(ImgInt2^[1]^[i],LargX*2);
       Freemem(ImgInt2^[1],4*LargY);
       Freemem(ImgInt2,4);
       end;
   5,6,8:begin
         for i:=1 to LargY do Freemem(ImgDouble2^[1]^[i],LargX*8);
         Freemem(ImgDouble2^[1],4*LargY);
         Freemem(ImgDouble2,4);
         end;
   end;}

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

procedure AddStar(var ImgInt:PTabImgInt;var ImgDouble:PTabImgDouble;TypeData:Byte;
   Sx,Sy:Integer;PSF:TPSF;X,Y:Double);
var
i,j:Integer;
IntensiteMax,Angle,SigX,SigY:Double;
Dx,Dy,Valeur:Double;
x1,y1,x2,y2:Integer;
begin
IntensiteMax:=PSF.IntensiteMax;
Angle:=PSF.Angle;
SigX:=PSF.SigmaX/(2*Sqrt(-2*Ln(0.5)));
Dx:=6*SigX;
SigY:=PSF.SigmaY/(2*Sqrt(-2*Ln(0.5)));
Dy:=6*SigY;
x1:=Round(X-Dx);
x2:=Round(X+Dx);
y1:=Round(Y-Dy);
y2:=Round(Y+Dy);
if x1<1 then x1:=1;
if x2>Sx then x2:=Sx;
if y1<1 then y1:=1;
if y2>Sy then y2:=Sy;
for j:=y1 to y2 do
   case TypeData of
      2:for i:=x1 to x2 do
           begin
           Valeur:=ImgInt^[1]^[j]^[i]+IntensiteMax*exp(-sqr((i-X)*cos(Angle)+(j-Y)*sin(Angle))/(2*SigX*SigX))
                   *exp(-sqr(-(i-X)*sin(Angle)+(j-Y)*cos(Angle))/(2*SigY*SigY));
           if Valeur>32767 then Valeur:=32767;
           if Valeur<-32768 then Valeur:=-32768;
           ImgInt^[1]^[j]^[i]:=Round(Valeur);
           end;
      5:for i:=1 to Sx do
           begin
           Valeur:=ImgDouble^[1]^[j]^[i]+IntensiteMax*exp(-sqr((i-X)*cos(Angle)+(j-Y)*sin(Angle))/(2*SigX*SigX))
                   *exp(-sqr(-(i-X)*sin(Angle)+(j-Y)*cos(Angle))/(2*SigY*SigY));
           ImgDouble^[1]^[j]^[i]:=Round(Valeur);
           end;
      end;
end;

procedure DeleteStar(var ImgInt:PTabImgInt;var ImgDouble:PTabImgDouble;TypeData:Byte;
   Sx,Sy:Integer;PSF:TPSF;X,Y:Double);
var
i,j:Integer;
IntensiteMax,Angle,SigX,SigY:Double;
Valeur:Double;
begin
IntensiteMax:=PSF.IntensiteMax;
Angle:=PSF.Angle;
SigX:=PSF.SigmaX/(2*Sqrt(-2*Ln(0.5)));
SigY:=PSF.SigmaY/(2*Sqrt(-2*Ln(0.5)));
for j:=1 to Sy do
   case TypeData of
      2:for i:=1 to Sx do
           begin
           Valeur:=1.0*ImgInt^[1]^[j]^[i]-IntensiteMax*exp(-sqr((i-X)*cos(Angle)+(j-Y)*sin(Angle))/(2*SigX*SigX))
                   *exp(-sqr(-(i-X)*sin(Angle)+(j-Y)*cos(Angle))/(2*SigY*SigY));
           if Valeur>32767 then Valeur:=32767;
           if Valeur<-32768 then Valeur:=-32768;
           ImgInt^[1]^[j]^[i]:=Round(Valeur);
           end;
      5:for i:=1 to Sx do
           begin
           Valeur:=1.0*ImgDouble^[1]^[j]^[i]-IntensiteMax*exp(-sqr((i-X)*cos(Angle)+(j-Y)*sin(Angle))/(2*SigX*SigX))
                   *exp(-sqr(-(i-X)*sin(Angle)+(j-Y)*cos(Angle))/(2*SigY*SigY));
           ImgDouble^[1]^[j]^[i]:=Round(Valeur);
           end;
      end;
end;

procedure CreeProjTelescope(ImgInt:PTabImgInt;
                            Sx,Sy:Integer;
                            AstrometrieInfos:TAstrometrieInfos;
                            FluxMag14:Double;
                            pop_Rapport:tpop_rapport);
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
   i,NbRequest,NBStar:Integer;
   ListePSF:PListePSF;
   ImgDouble:PTabImgDouble;
   Diagonale,Flux,Intensite,IntensiteMax,MaxPix:Double;
begin
// *********************************
//    Requetes sur les catalogues
// *********************************
//TAstrometrieInfos=record
//   Alpha0,Delta0:Double; // Coordonnées du centre de l'image en Heures/Degrés
//   Sx,Sy:Integer;        // Taille de l'image en pixels
//   Focale:Double;        // Focale du télescope en mm
//   TaillePixel:Double;   // Taille des pixels en microns
//   TypeGSC:Byte;         // Type GSC utilise
//   USNOSelected,         // Catalogues selectionnés
//   BSCSelected,
//   GSCCSelected,
//   TY2Selected,
//   MCT1Selected,
//   MCT2Selected,
//   MCT3Selected:Boolean;
//   end;

Getmem(FirstRequest,Sizeof(TRequestStar));

try

// Diagonale en mètres
//Diagonale:=Sqrt(Sqr(AstrometrieInfos.Sx)+Sqr(AstrometrieInfos.Sy))*AstrometrieInfos.TaillePixel*1.1/1000000;
if AstrometrieInfos.TaillePixelX>AstrometrieInfos.TaillePixelY then
   MaxPix:=AstrometrieInfos.TaillePixelX
else
   MaxPix:=AstrometrieInfos.TaillePixelY;
Diagonale:=Sqrt(Sqr(AstrometrieInfos.Sx)+Sqr(AstrometrieInfos.Sy))*MaxPix*1.1/1000000;
// Diagonale en dégres
Diagonale:=ArcTan(Diagonale/AstrometrieInfos.Focale/1000)/pi*180/2;
// Alpha en heures
AlphaMin:=AstrometrieInfos.Alpha0-Diagonale/15;
AlphaMax:=AstrometrieInfos.Alpha0+Diagonale/15;
// Delta en degrés
DeltaMin:=AstrometrieInfos.Delta0-Diagonale;
DeltaMax:=AstrometrieInfos.Delta0+Diagonale;

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
         Getmem(RequestCourant.Suivant,Sizeof(TRequestStar));
         RequestCourant:=RequestCourant.Suivant;
         end;
      until not OK;
   CloseMCT;
   end;


// **************************
//          Projection
// **************************
RequestCourant:=FirstRequest;
Getmem(ListePSF,NBRequest*Sizeof(TPSF));
try
pop_Rapport.AddLine('Nombre total d''étoiles analysées : '+IntToStr(NBRequest));
pop_Rapport.AddLine(' '); //nolang

pop_Rapport.AddLine(lang('Liste des étoiles'));
pop_Rapport.AddLine(     '-----------------'); //nolang
pop_Rapport.AddLine(' '); //nolang
pop_Rapport.AddLine('Alpha Delta Magnitude X Y'); //nolang
NBStar:=0;
for i:=1 to NBRequest do
   begin
//   Sphere2Plan(RequestCourant.Alpha,RequestCourant.Delta,
//               AstrometrieInfos.Alpha0,AstrometrieInfos.Delta0,
//               ListePSF^[i].X,ListePSF^[i].Y);
   AlphaDeltaToXY(AstrometrieInfos.Alpha0,AstrometrieInfos.Delta0,
                  RequestCourant.Alpha,RequestCourant.Delta,
                  ListePSF^[i].X,ListePSF^[i].Y);
   ListePSF^[i].X:=ListePSF^[i].X*AstrometrieInfos.Focale/1000/AstrometrieInfos.TaillePixelX*1e6+AstrometrieInfos.Sx div 2;
   ListePSF^[i].Y:=ListePSF^[i].Y*AstrometrieInfos.Focale/1000/AstrometrieInfos.TaillePixelY*1e6+AstrometrieInfos.Sy div 2;
   ListePSF^[i].Mag:=RequestCourant.Mag;
   if (ListePSF^[i].X>0) and (ListePSF^[i].X<Sx) and
      (ListePSF^[i].Y>0) and (ListePSF^[i].Y<Sy) then
      begin
      pop_Rapport.AddLine(AlphaToStr(RequestCourant.Alpha)+' '+DeltaToStr(RequestCourant.Delta)+' '+
         MyFloatToStr(ListePSF^[i].Mag,2)+' '+MyFloatToStr(ListePSF^[i].X,2)+' '+MyFloatToStr(ListePSF^[i].Y,2));
      Inc(NbStar);
      end;

   RequestCourant:=RequestCourant.Suivant;
   end;

pop_Rapport.AddLine(' ');
pop_Rapport.AddLine('Nombre d''étoiles crées : '+IntToStr(NBStar));

// ***************************************
//      Création de l'image virtuelle
// ***************************************

if FluxMag14=-1000 then
   begin
   IntensiteMax:=-MaxDouble;
   for i:=1 to NBRequest do
      begin
      if (ListePSF^[i].X>0) and (ListePSF^[i].X<Sx) and
         (ListePSF^[i].Y>0) and (ListePSF^[i].Y<Sy) then
         begin
         ListePSF^[i].SigmaX:=2.5;
         ListePSF^[i].SigmaY:=2.5;
         Flux:=Exp((14-ListePSF^[i].Mag)/2.5*ln(10));
         Intensite:=Flux/2/pi/ListePSF^[i].SigmaX*2*Sqrt(-2*ln(1/2))/ListePSF^[i].SigmaY*2*Sqrt(-2*ln(1/2));
         if Intensite>IntensiteMax then IntensiteMax:=Intensite;
         end;
      FluxMag14:=32767/IntensiteMax;
      end;
   end;

pop_Rapport.AddLine('');
pop_Rapport.AddLine('Flux d''une étoile de magnitude 14 : '+MyFloatToStr(FluxMag14,2));

for i:=1 to NBRequest do
   begin
   ListePSF^[i].SigmaX:=2;
   ListePSF^[i].SigmaY:=2;
   Flux:=Exp((14-ListePSF^[i].Mag)/2.5*ln(10))*FluxMag14;
   ListePSF^[i].IntensiteMax:=Flux/2/pi/ListePSF^[i].SigmaX*2*Sqrt(-2*ln(1/2))/ListePSF^[i].SigmaY*2*Sqrt(-2*ln(1/2));
   ListePSF^[i].Angle:=0;
   if (ListePSF^[i].X>0) and (ListePSF^[i].X<Sx) and
      (ListePSF^[i].Y>0) and (ListePSF^[i].Y<Sy) then
      AddStar(ImgInt,ImgDouble,2,Sx,Sy,ListePSF^[i],ListePSF^[i].X,ListePSF^[i].Y);
   end;

finally
Freemem(ListePSF,NBRequest*Sizeof(TPSF));
end;

finally
RequestCourant:=FirstRequest;
for i:=1 to NBRequest do
   begin
   OldRequest:=RequestCourant;
   RequestCourant:=RequestCourant.Suivant;
   Freemem(OldRequest,Sizeof(TRequestStar));
   end;
end;

end;


function mrqmin1D(var LigDouble:PLigDouble;
                  Max:Integer;
                  var a:DoubleArrayRow;
                  ma:Integer;
                  var covar,alpha:DoubleArray;
                  var chisq,alamda:Double):Boolean;
var
k,j:Integer;
atry:DoubleArrayRow;
oneda:DoubleArray;
//oneda:DoubleArrayRow;
MrqminBeta:DoubleArrayRow;
Mrqmin0chisq:Double;
da:DoubleArrayRow;
CoefAlamda:Double;
//Indx:IntegerArrayRow;
//d:Double;
label fin;

function mrqcof(var LigDouble:PLigDouble;
                var a:DoubleArrayRow;
                var alpha:DoubleArray;
                var beta:DoubleArrayRow;
                var chisq:Double):Boolean;
var
i,j,k,l:integer;
zmod,wt,dz:Double;
dyda:DoubleArrayRow;

Tmp:Double;
CosAngle,SinAngle,SigmaX2,SigmaY2,Val:Double;
begin
Result:=True;
for j:=1 to ma do
   begin
   for k:=1 to j do alpha[j,k]:=0;
   beta[j]:=0;
   end;
chisq:=0;

for l:=1 to Max do
   begin
   // A[1] fond du ciel
   // A[2] intensite
   // A[3] x
   // A[4] sigma
   zmod:=0;
   SigmaX2:=Sqr(a[4]);
   Tmp:=exp(-sqr((l-a[3])/a[4])/2);
   zmod:=zmod+a[1]+a[2]*Tmp;
   dyda[1]:=1;
   dyda[2]:=Tmp;
   dyda[3]:=(l-a[3])*a[2]*Tmp/SigmaX2;
   dyda[4]:=sqr(l-a[3])*a[2]*Tmp/(SigmaX2*a[4]);
   dz:=LigDouble^[l]-zmod;
   for j:=1 to ma do
      begin
      wt:=dyda[j];
      for k:=1 to j do
         alpha[j,k]:=alpha[j,k]+wt*dyda[k];
      beta[j]:=beta[j]+dz*wt;
      end;
   chisq:=chisq+dz*dz;
   end;

for j:=2 to ma do
   for k:=1 to j-1 do alpha[k,j]:=alpha[j,k];
end;

begin
Result:=True;

CoefAlamda:=10;

if alamda<0 then
   begin
   alamda:=1;
   if not mrqcof(LigDouble,a,alpha,MrqminBeta,chisq) then
      begin
      Result:=False;
      Exit;
      end;
   Mrqmin0chisq:=chisq;
   for j:=1 to ma do atry[j]:=a[j];
   end;

for j:=1 to ma do
   begin
   for k:=1 to ma do covar[j,k]:=alpha[j,k];
   covar[j,j]:=alpha[j,j]*(1+alamda);
   oneda[j,1]:=MrqminBeta[j];
   end;

if not gaussj(covar,ma,oneda,1) then
   begin
   Result:=False;
   Exit;
   end;

for j:=1 to ma do da[j]:=oneda[j,1];
if alamda=0 then goto fin;

for j:=1 to ma do atry[j]:=a[j]+da[j];

if not mrqcof(LigDouble,atry,covar,da,chisq) then
   begin
   Result:=False;
   Exit;
   end;

if chisq<Mrqmin0chisq then
   begin
   alamda:=1/CoefAlamda*alamda;
   Mrqmin0chisq:=chisq;
   for j:=1 to ma do
      begin
      for k:=1 to ma do alpha[j,k]:=covar[j,k];
      MrqminBeta[j]:=da[j];
      a[j]:=atry[j];
      end;
   end
else
   begin
   alamda:=CoefAlamda*alamda;
   chisq:=Mrqmin0chisq;
   end;

fin:
end;

procedure Modelise1D(var LigDouble:PLigDouble;Max,x:Integer;var PSF:TPSF);
var
NoIteration,i,j,ma,MaxIter:Integer;
Covar,Alpha:DoubleArray;
Chisq,Alamda,MaxAlamda:Double;
a:DoubleArrayRow;
Fini:Boolean;
DFluxMax,FluxMax,DFluxMin,FluxMin,Temp:Double;
OK:Boolean;
ValMax,Valeur:Double;
begin
//PSF.X:=Max div 2;
PSF.X:=x;

// On initialise x avec le maximum
ValMax:=-32768;
for i:=1 to Max do
   begin
   Valeur:=LigDouble^[i];
   if Valeur>ValMax then
      begin
      ValMax:=Valeur;
      x:=i;
      end;
   end;

for i:=1 to MaxArray do
   for j:=1 to MaxArray do covar[i,j]:=0;
for i:=1 to MaxArray do
   for j:=1 to MaxArray do alpha[i,j]:=0;

// A[1] fond du ciel
// A[2] intensite
// A[3] x
// A[4] sigma
ma:=4;
a[1]:=0;
a[2]:=LigDouble^[x];
a[3]:=x;
a[4]:=10;

Chisq:=1;
Alamda:=-1;
if mrqmin1D(LigDouble,Max,a,ma,Covar,Alpha,Chisq,Alamda) then
   begin
   MaxIter:=500;
   MaxAlamda:=100;

   Fini:=False;
   NoIteration:=1;
   while not(Fini) and (NoIteration<=MaxIter) do
      begin
//      if Alamda>MaxAlamda then Fini:=True;
      if Alamda<1e-20 then Fini:=True;
      mrqmin1D(LigDouble,Max,a,ma,Covar,Alpha,Chisq,Alamda);
      Inc(NoIteration);
      end;

//   if fini then ShowMessage('Fini'+IntTostr(NoIteration));
//   if NoIteration>100 then ShowMessage('Iter ');
   Alamda:=0;
   if mrqmin1D(LigDouble,Max,a,ma,Covar,Alpha,Chisq,Alamda) then
      begin
      // A[1] fond du ciel
      // A[2] intensite
      // A[3] x
      // A[4] sigma
      PSF.X:=a[3];
      PSF.DX:=Sqrt(Abs(Covar[3,3])*Chisq/Max);
      PSF.Sigma:=a[4]*2*Sqrt(-2*ln(1/2));
      PSF.Flux:=a[2]*2*pi*sqr(a[4]);
      PSF.IntensiteMax:=a[2];
      end
   else PSF.Flux:=-1;
   end
else PSF.Flux:=-1;

// Derniers tests
OK:=True;
if (PSF.X<1) or (PSF.X>Max)  then OK:=False;
if PSF.DX>Max then OK:=False;
if  PSF.dFlux*100/PSF.Flux>75 then OK:=False;
if (PSF.Sigma<1) or (PSF.Sigma>Max/2) then OK:=False;

if not OK then PSF.Flux:=-1;
end;


end.
