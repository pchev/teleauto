unit u_arithmetique;

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

                        Fonctions de calcul arithmetique

-------------------------------------------------------------------------------}

interface

uses sysutils, u_class, classes;

type
  ErrorArithmetique=class(exception);

procedure Add(var ImgInt1,ImgInt2:PTabImgInt;
              var ImgDouble1,ImgDouble2:PTabImgDouble;
              TypeData,NbPlans:Byte;
              Sx1,Sy1,Sx2,Sy2:Integer);
procedure Soust(var ImgInt1,ImgInt2:PTabImgInt;
              var ImgDouble1,ImgDouble2:PTabImgDouble;
              TypeData,NbPlans:Byte;
              Sx1,Sy1,Sx2,Sy2:Integer);
procedure Mult(var ImgInt1,ImgInt2:PTabImgInt;
               var ImgDouble1,ImgDouble2:PTabImgDouble;
               TypeData,NbPlans:Byte;
               Sx1,Sy1,Sx2,Sy2:Integer;
               Diviseur:Double);
procedure Divi(var ImgInt1,ImgInt2:PTabImgInt;
               var ImgDouble1,ImgDouble2:PTabImgDouble;
               TypeData,NbPlans:Byte;
               Sx1,Sy1,Sx2,Sy2:Integer;
               Mult:Double);
procedure Offset(var ImgInt:PTabImgInt;
                 var ImgDouble:PTabImgDouble;
                 TypeData,NbPlans:Byte;
                 Sx,Sy:Integer;
                 Offset:Double);
procedure Gain(var ImgInt:PTabImgInt;
               var ImgDouble:PTabImgDouble;
               TypeData,NbPlans:Byte;
               Sx,Sy:Integer;
               Gain:Double);
procedure ImgLn(var ImgInt:PTabImgInt;
                var ImgDouble:PTabImgDouble;
                NbPlans,TypeData,Sx,Sy:Integer);
procedure ImgExp(var ImgInt:PTabImgInt;
                 var ImgDouble:PTabImgDouble;
                 NbPlans,TypeData,Sx,Sy:Integer;
                 LMax:Double);
procedure ClipMin(var ImgInt:PTabImgInt;
                  var ImgDouble:PTabImgDouble;
                  TypeData,NbPlans:Byte;
                  Sx,Sy:Integer;Seuil,Val:Double);
procedure ClipMax(var ImgInt:PTabImgInt;
                  var ImgDouble:PTabImgDouble;
                  TypeData,NbPlans:Byte;
                  Sx,Sy:Integer;Seuil,Val:Double);
procedure Binarise(var ImgInt:PTabImgInt;
                   var ImgDouble:PTabImgDouble;
                   TypeData,NbPlans:Byte;
                   Sx,Sy:Integer;
                   Seuil,ValBas,ValHaut:Double);
procedure Transfert(var ImgInt1,ImgInt2:PTabImgInt;
                    var ImgDouble1,ImgDouble2:PTabImgDouble;
                    TypeData,NbPlans:Byte;
                    Sx,Sy:Integer);
// FFT
procedure FFTDirect(ImgIntIn:PTabImgInt;
                    ImgDoubleIn:PTabImgDouble;
                    TypeData:Byte;
                    var ImgFFT:PTabImgDouble;
                    var Sx,Sy:Integer);
procedure FFTInverse(var ImgFFTIn:PTabImgDouble;
                     Sx,Sy:Integer);
// Conversion de types
procedure ConvertIntToReal(ImgIntIn:PTabImgInt;
                           var ImgDoubleOut:PTabImgDouble;
                           NbPlans:Byte;
                           Sx,Sy:Integer);
procedure ConvertRealToInt(ImgDoubleIn:PTabImgDouble;
                           var ImgIntOut:PTabImgInt;
                           NbPlans:Byte;
                           Sx,Sy:Integer);
procedure ConvertFITSRealToInt(ImgDoubleIn:PTabImgDouble;
                               var ImgIntOut:PTabImgInt;
                               var ImgInfos:TImgInfos);
procedure ConvertFITSIntToReal(var ImgIntIn:PTabImgInt;
                               var ImgDoubleOut:PTabImgDouble;
                               var ImgInfos:TImgInfos);

procedure InterCorrele(var ImgIntIn1:PTabImgInt;
              ImgIntIn2:PTabImgInt;
              var ImgDoubleIn1:PTabImgDouble;
              ImgDoubleIn2:PTabImgDouble;
              var ImgDoubleOut:PTabImgDouble;
              TypeData:Byte;
              var Sx,Sy:Integer);
procedure AutoCorrele(var ImgIntIn:PTabImgInt;
              var ImgDoubleIn:PTabImgDouble;
              var ImgDoubleOut:PTabImgDouble;
              TypeData:Byte;
              var Sx,Sy:Integer);
procedure ValAbs(var ImgInt:PTabImgInt;
                 var ImgDouble:PTabImgDouble;
                 TypeData,NbPlans:Byte;
                 Sx,Sy:Integer);
procedure PermutePlan(var ImgInt:PTabImgInt;
                      var ImgDouble:PTabImgDouble;
                      TypeData,NbPlans:Byte;
                      Sx,Sy,Index1,Index2:Integer);
procedure CorrectionCosmetique(var ImgInt:PTabImgInt;
                               var ImgDouble:PTabImgDouble;
                               TypeData,NbPlans:Byte;
                               Sx,Sy:Integer;
                               FileName:string);
procedure SetValue(var ImgInt:PTabImgInt;
                   var ImgDouble:PTabImgDouble;
                   TypeData,NbPlans:Byte;
                   Sx,Sy:Integer;
                   Value:Double);

function RGB2Gris(var ImgIntIn:PTabImgInt;
                  var ImgDoubleIn:PTabImgDouble;
                  TypeData,nbPlans,Sx,Sy:Integer;var ErrCode:byte):pointer;
procedure CFA_RGB(ImgInt:PTabImgInt;
                  ImgDouble:PTabImgDouble;
                  var ImgColorInt:PTabImgInt;
                  var ImgColorDbl:PTabImgDouble;
                  cfaformat:byte;
                  TypeData,NbPlans:Byte;
                  var Sx,Sy:Integer;
                  var resultat:byte);
                   
implementation

uses pu_image,
     u_math,
     u_geometrie,
     u_analyse,
     u_lang,
     u_general,
     u_constants;

procedure Add(var ImgInt1,ImgInt2:PTabImgInt;
              var ImgDouble1,ImgDouble2:PTabImgDouble;
              TypeData,NbPlans:Byte;
              Sx1,Sy1,Sx2,Sy2:Integer);
var
i,j,k:Integer;
Valeur:Double;
begin
if (Sx1<>Sx2) or (Sy1<>Sy2) then
   raise ErrorArithmetique.create(lang('Les dimensions des deux images sont différentes'));

for k:=1 to NbPLans do
   begin
   for i:=1 to Sx1 do
      begin
      case TypeData of
         2,7:begin
           for j:=1 to Sy1 do
              begin
              Valeur:=ImgInt1^[k]^[j]^[i]+ImgInt2^[k]^[j]^[i];
              if Valeur>32767 then Valeur:=32767;
              if Valeur<-32768 then Valeur:=-32768;
              ImgInt1^[k]^[j]^[i]:=Round(Valeur);
              end;
           end;
         5,6,8:begin
           for j:=1 to Sy1 do
              ImgDouble1^[k]^[j]^[i]:=ImgDouble1^[k]^[j]^[i]+ImgDouble2^[k]^[j]^[i]
           end;
         end;
      end;
   end;
end;

procedure Soust(var ImgInt1,ImgInt2:PTabImgInt;
                var ImgDouble1,ImgDouble2:PTabImgDouble;
                TypeData,NbPlans:Byte;
                Sx1,Sy1,Sx2,Sy2:Integer);
var
i,j,k:Integer;
Valeur:Double;
begin
if (Sx1<>Sx2) or (Sy1<>Sy2) then
   raise ErrorArithmetique.create(lang('Les dimensions des deux images sont différentes'));

for k:=1 to NbPlans do
   begin
   case TypeData of
      2,7:begin
        for i:=1 to Sx1 do
           for j:=1 to Sy1 do
              begin
              Valeur:=ImgInt1^[k]^[j]^[i]-ImgInt2^[k]^[j]^[i];
              if Valeur>32767 then Valeur:=32767;
              if Valeur<-32768 then Valeur:=-32768;
              ImgInt1^[k]^[j]^[i]:=Round(Valeur);
              end;
        end;
      5,6,8:begin
        for i:=1 to Sx1 do
           for j:=1 to Sy1 do
              ImgDouble1^[k]^[j]^[i]:=ImgDouble1^[k]^[j]^[i]-ImgDouble2^[k]^[j]^[i]
        end;
      end;
   end;
end;

procedure Mult(var ImgInt1,ImgInt2:PTabImgInt;
               var ImgDouble1,ImgDouble2:PTabImgDouble;
               TypeData,NbPlans:Byte;
               Sx1,Sy1,Sx2,Sy2:Integer;
               Diviseur:Double);
var
i,j,k:Integer;
Valeur:Double;
begin
if (Sx1<>Sx2) or (Sy1<>Sy2) then
   raise ErrorArithmetique.create(lang('Les dimensions des deux images sont différentes'));

for k:=1 to NbPlans do
   begin
   case TypeData of
      2,7:begin
          for i:=1 to Sx1 do
             for j:=1 to Sy1 do
                begin
                Valeur:=Round(1.0*ImgInt1^[k]^[j]^[i]*ImgInt2^[k]^[j]^[i]/Diviseur);
                if Valeur>32767 then Valeur:=32767;
                if Valeur<-32768 then Valeur:=-32768;
                ImgInt1^[k]^[j]^[i]:=Round(Valeur);
                end;
          end;
      5,6,8:begin
          for i:=1 to Sx1 do
             for j:=1 to Sy1 do
                ImgDouble1^[k]^[j]^[i]:=1.0*ImgDouble1^[k]^[j]^[i]*ImgDouble2^[k]^[j]^[i]/Diviseur;
          end;
      end;
   end;
end;

procedure Divi(var ImgInt1,ImgInt2:PTabImgInt;
               var ImgDouble1,ImgDouble2:PTabImgDouble;
               TypeData,NbPlans:Byte;
               Sx1,Sy1,Sx2,Sy2:Integer;
               Mult:Double);
var
i,j,k:Integer;
Valeur:Double;
begin
if (Sx1<>Sx2) or (Sy1<>Sy2) then
   raise ErrorArithmetique.create(lang('Les dimensions des deux images sont différentes'));

for k:=1 to NbPlans do
   begin
   case TypeData of
      2,7:begin
          for i:=1 to Sx1 do
             for j:=1 to Sy1 do
                begin
                if ImgInt2^[k]^[j]^[i]<>0 then
                   Valeur:=Round(1.0*ImgInt1^[k]^[j]^[i]/ImgInt2^[k]^[j]^[i]*Mult)
                else if ImgInt1^[1]^[j]^[i]=0 then
                   Valeur:=0
                else
                   Valeur:=32767;
                if Valeur>32767 then Valeur:=32767;
                if Valeur<-32768 then Valeur:=-32768;
                ImgInt1^[k]^[j]^[i]:=Round(Valeur);
                end;
          end;
      5,6,8:begin
          for i:=1 to Sx1 do
             for j:=1 to Sy1 do
                if ImgDouble2^[k]^[j]^[i]<>0 then
                   ImgDouble1^[k]^[j]^[i]:=Round(1.0*ImgDouble1^[k]^[j]^[i]/ImgDouble2^[k]^[j]^[i]*Mult)
                else if ImgDouble1^[1]^[j]^[i]=0 then
                   ImgDouble1^[k]^[j]^[i]:=0
                else
                   ImgDouble1^[k]^[j]^[i]:=1.7e+308;
          end;
      end;
   end;

end;

procedure Offset(var ImgInt:PTabImgInt;
                 var ImgDouble:PTabImgDouble;
                 TypeData,NbPlans:Byte;
                 Sx,Sy:Integer;
                 Offset:Double);
var
i,j,k:Integer;
Valeur:Double;
begin
for k:=1 to NbPlans do
   for j:=1 to Sy do
      begin
      case typeData of
         2,7:for i:=1 to Sx do
              begin
              Valeur:=ImgInt^[k]^[j]^[i]+Offset;
              if Valeur>32767 then Valeur:=32767;
              if Valeur<-32768 then Valeur:=-32768;
              ImgInt^[k]^[j]^[i]:=Round(Valeur);
              end;
         5,6,8:for i:=1 to Sx do
              ImgDouble^[k]^[j]^[i]:=ImgDouble^[k]^[j]^[i]+Offset;
         end;
      end;
end;

procedure Gain(var ImgInt:PTabImgInt;
               var ImgDouble:PTabImgDouble;
               TypeData,NbPlans:Byte;
               Sx,Sy:Integer;
               Gain:Double);
var
i,j,k:Integer;
Valeur:Double;
begin
for k:=1 to NbPlans do
   begin
   for i:=1 to Sx do
      begin
      case TypeData of
         2,7:begin
           for j:=1 to Sy do
              begin
              Valeur:=Round(ImgInt^[k]^[j]^[i]*Gain);
              if Valeur>32767 then Valeur:=32767;
              if Valeur<-32768 then Valeur:=-32768;
              ImgInt^[k]^[j]^[i]:=Round(Valeur);
              end;
           end;
         5,6,8:begin
           for j:=1 to Sy do
              ImgDouble^[k]^[j]^[i]:=ImgDouble^[k]^[j]^[i]*Gain;
           end;
         end;
      end;
   end;
end;

procedure ImgLn(var ImgInt:PTabImgInt;
                var ImgDouble:PTabImgDouble;
                NbPlans,TypeData,Sx,Sy:Integer);
var
i,j,k:Integer;
LMin,LMax,LnMax:Double;
Mediane,Moy,Ecart:Double;
Valeur:Double;
begin
for k:=1 to NbPlans do
   case TypeData of
      2,7:begin
          Statistiques(ImgInt,ImgDouble,2,0,Sx,Sy,k,LMin,Mediane,LMax,Moy,Ecart);
          LnMax:=Ln(LMax-LMin+1);
          for j:=1 to Sy do
             for i:=1 to Sx do
                begin
                Valeur:=LMax*Ln(ImgInt^[k]^[j]^[i]-LMin+1)/LnMax;
                if Valeur>32767 then Valeur:=32767;
                if Valeur<-32768 then Valeur:=-32768;
                ImgInt^[k]^[j]^[i]:=Round(Valeur);
                end;
          end;
      5,6,8:begin
          Statistiques(ImgInt,ImgDouble,5,0,Sx,Sy,k,LMin,Mediane,LMax,Moy,Ecart);
          LnMax:=Ln(LMax-LMin+1);
          for j:=1 to Sy do
             for i:=1 to Sx do
                ImgDouble^[k]^[j]^[i]:=LMax*Ln(ImgDouble^[k]^[j]^[i]-LMin+1)/LnMax;
          end;
      end;
end;

procedure ImgExp(var ImgInt:PTabImgInt;
                 var ImgDouble:PTabImgDouble;
                 NbPlans,TypeData,Sx,Sy:Integer;
                 LMax:Double);
var
i,j,k:Integer;
Valeur:Double;
begin
for k:=1 to NbPlans do
   case TypeData of
      2,7:begin
          for i:=1 to Sx do
             for j:=1 to Sy do
                begin
                Valeur:=LMax*Exp(1.0*ImgInt^[k]^[j]^[i]/LMax)/Exp(1);
                if Valeur>32767 then Valeur:=32767;
                if Valeur<-32768 then Valeur:=-32768;
                ImgInt^[k]^[j]^[i]:=Round(Valeur);
                end;
          end;
      5,6,8:begin
          for i:=1 to Sx do
             for j:=1 to Sy do
                ImgDouble^[k]^[j]^[i]:=LMax*Exp(1.0*ImgDouble^[k]^[j]^[i]/LMax)/Exp(1);
          end;
      end;
end;

procedure ClipMin(var ImgInt:PTabImgInt;
                  var ImgDouble:PTabImgDouble;
                  TypeData,NbPlans:Byte;
                  Sx,Sy:Integer;Seuil,Val:Double);
var
i,j,k:Integer;
begin
for k:=1 to NbPlans do
   begin
   for i:=1 to Sx do
      begin
      case TypeData of
         2,7:begin
           for j:=1 to Sy do
              if ImgInt^[k]^[j]^[i]<Seuil then ImgInt^[k]^[j]^[i]:=Round(Val);
           end;
         5,6,8:begin
           for j:=1 to Sy do
              if ImgDouble^[k]^[j]^[i]<Seuil then ImgDouble^[k]^[j]^[i]:=Val;
           end;
         end;
      end;
   end;
end;

procedure ClipMax(var ImgInt:PTabImgInt;
                  var ImgDouble:PTabImgDouble;
                  TypeData,NbPlans:Byte;
                  Sx,Sy:Integer;Seuil,Val:Double);
var
i,j,k:Integer;
begin
for k:=1 to NbPlans do
   begin
   for i:=1 to Sx do
      begin
      case TypeData of
         2,7:begin
           for j:=1 to Sy do
              if ImgInt^[k]^[j]^[i]>Seuil then ImgInt^[k]^[j]^[i]:=Round(Val);
           end;
         5,6,8:begin
           for j:=1 to Sy do
              if ImgDouble^[k]^[j]^[i]>Seuil then ImgDouble^[k]^[j]^[i]:=Val;
           end;
         end;
      end;
   end;
end;

procedure Binarise(var ImgInt:PTabImgInt;
                   var ImgDouble:PTabImgDouble;
                   TypeData,NbPlans:Byte;
                   Sx,Sy:Integer;
                   Seuil,ValBas,ValHaut:Double);
var
i,j,k:Integer;
begin
for k:=1 to NbPlans do
      case TypeData of
         2,7:begin
             for i:=1 to Sx do
                for j:=1 to Sy do
                   if ImgInt^[k]^[j]^[i]>=Seuil then ImgInt^[k]^[j]^[i]:=Round(ValHaut) else ImgInt^[k]^[j]^[i]:=Round(ValBas);
             end;
         5,6,8:begin
             for i:=1 to Sx do
                for j:=1 to Sy do
                   if ImgDouble^[k]^[j]^[i]>=Seuil then ImgDouble^[k]^[j]^[i]:=ValHaut else ImgDouble^[k]^[j]^[i]:=ValBas;
             end;
         end;
end;

procedure Transfert(var ImgInt1,ImgInt2:PTabImgInt;
                    var ImgDouble1,ImgDouble2:PTabImgDouble;
                    TypeData,NbPlans:Byte;
                    Sx,Sy:Integer);
var
j,k:Integer;
begin
for k:=1 to NbPlans do
   for j:=1 to Sy do
      case TypeData of
         2,7:Move(ImgInt1^[k]^[j]^,ImgInt2^[k]^[j]^,Sx*2);
         5,6,8:Move(ImgDouble1^[k]^[j]^,ImgDouble2^[k]^[j]^,Sx*8);
         end;
end;

procedure FFTDirect(ImgIntIn:PTabImgInt;
                    ImgDoubleIn:PTabImgDouble;
                    TypeData:Byte;
                    var ImgFFT:PTabImgDouble;
                    var Sx,Sy:Integer);
var
i,j,k:Integer;
Diviseur:Single;
SNew:Integer;
ImgIntNil:PTabImgInt;
begin
// On cherche les nouvelles dimensions
i:=1;
repeat i:=i*2; until (i>=Sx) and (i>=Sy);

SNew:=i;

Getmem(ImgFFT,4*2);
for k:=1 to 2 do
   begin
   Getmem(ImgFFT^[k],SNew*4);
   for j:=1 to SNew do
      begin
      Getmem(ImgFFT^[k]^[j],SNew*8);
      FillChar(ImgFFT[k]^[j]^,SNew*8,0);
      end
   end;

// On transfere l'image dans la partie reelle
for j:=1 to Sy do
   case TypeData of
      2,7:for i:=1 to Sx do
           ImgFFT^[1]^[j]^[i]:=ImgIntIn^[1]^[j]^[i];
      5,6,8:for i:=1 to Sx do
           ImgFFT^[1]^[j]^[i]:=ImgDoubleIn^[1]^[j]^[i];
      end;

// On passe la FFT suivant les lignes
FFT(ImgFFT,SNew,SNew);
// On tourne
RotationP90(ImgIntNil,ImgFFT,SNew,SNew,5,2);
// On repasse la FFT suivant les lignes ( Les colonnes de l'image initiale )
FFT(ImgFFT,SNew,SNew);

// On divise tous les points 2 fois par Sx
Diviseur:=SNew*SNew;
for i:=1 to SNew do
   for j:=1 to SNew do
      begin
      ImgFFT^[1]^[j]^[i]:=ImgFFT^[1]^[j]^[i]/Diviseur;
      ImgFFT^[2]^[j]^[i]:=ImgFFT^[2]^[j]^[i]/Diviseur;
      end;

// On toune en sens inverse
RotationM90(ImgIntNil,ImgFFT,SNew,SNew,5,2);

// On inverse les quadrants
PermuteQuadrants(ImgIntNil,ImgFFT,6,2,SNew,SNew);

Sx:=SNew;
Sy:=SNew;
end;

procedure FFTInverse(var ImgFFTIn:PTabImgDouble;
                     Sx,Sy:Integer);
var
i,j,k:Integer;
Diviseur:Single;
ImgIntNil:PTabImgInt;
Val:Double;
ImgDouble:PTabImgDouble;
begin
Getmem(ImgDouble,4);
Getmem(ImgDouble^[1],Sy*4);
for j:=1 to Sy do Getmem(ImgDouble^[1]^[j],Sx*8);

// On inverse les quadrants
PermuteQuadrants(ImgIntNil,ImgFFTIn,6,2,Sx,Sy);

// On inverse partie reelle et imaginaire
for j:=1 to Sy do
   for i:=1 to Sx do
      begin
      Val:=ImgFFTIn^[1]^[j]^[i];
      ImgFFTIn^[1]^[j]^[i]:=ImgFFTIn^[2]^[j]^[i];
      ImgFFTIn^[2]^[j]^[i]:=Val;
      end;

// On passe la FFT suivant les lignes
FFT(ImgFFTIn,Sx,Sy);
{ On tourne }
RotationP90(ImgIntNil,ImgFFTIn,Sx,Sy,5,2);
// On repasse la FFT suivant les lignes ( Les colonnes de l'image initiale )
FFT(ImgFFTIn,Sx,Sy);

// Le resultat est dans la partie imaginaire
for j:=1 to Sy do
   for i:=1 to Sx do
      ImgDouble^[1]^[j]^[i]:=ImgFFTIn^[2]^[j]^[i];

// On toune la partie reelle en sens inverse
RotationM90(ImgIntNil,ImgDouble,Sx,Sy,5,1);

for k:=1 to 2 do
   begin
   for j:=1 to Sy do Freemem(ImgFFTIn^[k]^[j],Sx*8);
   Freemem(ImgFFTIn^[k],Sy*4);
   end;
Freemem(ImgFFTIn,4*2);

ImgFFTIn:=ImgDouble;
end;

procedure ConvertIntToReal(ImgIntIn:PTabImgInt;
                           var ImgDoubleOut:PTabImgDouble;
                           NbPlans:Byte;
                           Sx,Sy:Integer);
var
i,j,k:Integer;
begin
Getmem(ImgDoubleOut,4*NbPlans);
for k:=1 to NbPlans do
   begin
   Getmem(ImgDoubleOut^[k],Sy*4);
   for j:=1 to Sy do Getmem(ImgDoubleOut^[k]^[j],Sx*8);
   end;

for k:=1 to NbPlans do
   for j:=1 to Sy do
      for i:=1 to Sx do
         ImgDoubleOut^[k]^[j]^[i]:=ImgIntIn^[k]^[j]^[i];

for k:=1 to NbPlans do
   begin
   for j:=1 to Sy do Freemem(ImgIntIn^[k]^[j],Sx*2);
   Freemem(ImgIntIn^[k],Sy*4);
   end;
Freemem(ImgIntIn,NbPlans);
end;

procedure ConvertRealToInt(ImgDoubleIn:PTabImgDouble;
                           var ImgIntOut:PTabImgInt;
                           NbPlans:Byte;
                           Sx,Sy:Integer);
var
i,j,k:Integer;
Val:Double;
begin
Getmem(ImgIntOut,4*NbPlans);
for k:=1 to NbPlans do
   begin
   Getmem(ImgIntOut^[k],Sy*4);
   for j:=1 to Sy do Getmem(ImgIntOut^[k]^[j],Sx*2);
   end;

for k:=1 to NbPlans do
   for j:=1 to Sy do
      for i:=1 to Sx do
         begin
         Val:=ImgDoubleIn^[k]^[j]^[i];
         if Val>32767 then Val:=32767;
         if Val<=-32768 then Val:=-32768;
         ImgIntOut^[k]^[j]^[i]:=Round(Val);
         end;

for k:=1 to NbPlans do
   begin
   for j:=1 to Sy do Freemem(ImgDoubleIn^[k]^[j],Sx*8);
   Freemem(ImgDoubleIn^[k],Sy*4);
   end;
Freemem(ImgDoubleIn,4*NbPlans);
end;

procedure ConvertFITSRealToInt(ImgDoubleIn:PTabImgDouble;
                               var ImgIntOut:PTabImgInt;
                               var ImgInfos:TImgInfos);
var
i,j,k:Integer;
Val:Double;
ImgDouble:PTabImgDouble;
ImgInt:PTabImgInt;
Min,Max,a,b:Double;
ImgInfosSave:TImgInfos;
begin
ImgInfosSave:=ImgInfos;
if (ImgInfos.TypeData=5) or (ImgInfos.TypeData=6) then ImgInfos.TypeData:=2;
if ImgInfos.TypeData=8 then ImgInfos.TypeData:=7;

GetmemImg(ImgIntOut,ImgDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);

// Recuperer le min et le max
Min:=MaxDouble;
Max:=MinDouble;
for k:=1 to ImgInfos.NbPlans do
   for j:=1 to ImgInfos.Sy do
      for i:=1 to ImgInfos.Sx do
         begin
         Val:=ImgDoubleIn^[k]^[j]^[i];
         if Val>Max then Max:=Val;
         if Val<Min then Min:=Val;
         end;

// Calculer la transformation
if Max<>Min then
   begin
   a:=(32767+32768)/(Max-Min);
   b:=32767-a*Max;

   // Conversion de l'image
   for k:=1 to ImgInfos.NbPlans do
      for j:=1 to ImgInfos.Sy do
         for i:=1 to ImgInfos.Sx do
            begin
            Val:=ImgDoubleIn^[k]^[j]^[i];
            Val:=a*Val+b;
            ImgIntOut^[k]^[j]^[i]:=Round(Val);
            end;

   // Calcul des nouveaux BZero et BScale
   ImgInfos.BZero:=-b/a;
   ImgInfos.BScale:=1/a;
   end
else
   begin
   // Conversion de l'image
   for k:=1 to ImgInfos.NbPlans do
      for j:=1 to ImgInfos.Sy do
         for i:=1 to ImgInfos.Sx do
            begin
            ImgIntOut^[k]^[j]^[i]:=0;
            end;

   // Calcul des nouveaux BZero et BScale
   ImgInfos.BZero:=Min;
   ImgInfos.BScale:=0;
   end;

FreememImg(ImgInt,ImgDoubleIn,ImgInfosSave.Sx,ImgInfosSave.Sy,ImgInfosSave.TypeData,ImgInfosSave.NbPlans);
end;

procedure ConvertFITSIntToReal(var ImgIntIn:PTabImgInt;
                               var ImgDoubleOut:PTabImgDouble;
                               var ImgInfos:TImgInfos);
var
i,j,k:Integer;
Val:Double;
ImgDouble:PTabImgDouble;
ImgInt:PTabImgInt;
ImgInfosSave:TImgInfos;
begin
ImgInfosSave:=ImgInfos;
if ImgInfos.TypeData=2 then ImgInfos.TypeData:=5;
if ImgInfos.TypeData=7 then ImgInfos.TypeData:=8;

GetmemImg(ImgInt,ImgDoubleOut,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);

// Conversion de l'image
for k:=1 to ImgInfos.NbPlans do
   for j:=1 to ImgInfos.Sy do
      for i:=1 to ImgInfos.Sx do
         begin
         Val:=ImgIntIn^[k]^[j]^[i];
         Val:=ImgInfos.BScale*Val+ImgInfos.BZero;
         ImgDoubleOut^[k]^[j]^[i]:=Val;
         end;

// Calcul des nouveaux BZero et BScale
ImgInfos.BZero:=0;
ImgInfos.BScale:=1;

FreememImg(ImgIntIn,ImgDouble,ImgInfosSave.Sx,ImgInfosSave.Sy,ImgInfosSave.TypeData,ImgInfosSave.NbPlans);
end;


procedure InterCorrele(var ImgIntIn1:PTabImgInt;
                       ImgIntIn2:PTabImgInt;
                       var ImgDoubleIn1:PTabImgDouble;
                       ImgDoubleIn2:PTabImgDouble;
                       var ImgDoubleOut:PTabImgDouble;
                       TypeData:Byte;
                       var Sx,Sy:Integer);
var
Maxi,Mini,Mediane1,Mediane2,Moy1,Moy2,Ecart:Double;
ImgFFT1,ImgFFT2:PTabImgDouble;
i,j,k:Integer;
a1,b1,a2,b2,Module:Double;
SxOld,SyOld,SFFT:Integer;
ImgIntNil:PTabImgInt;
begin
SxOld:=Sx;
SyOld:=Sy;

// On enleve le fond du ciel
Statistiques(ImgIntIn1,ImgDoubleIn1,TypeData,1,Sx,Sy,1,Mini,Mediane1,Maxi,Moy1,Ecart);
Statistiques(ImgIntIn2,ImgDoubleIn2,TypeData,1,Sx,Sy,1,Mini,Mediane2,Maxi,Moy2,Ecart);
Offset(ImgIntIn1,ImgDoubleIn1,TypeData,1,Sx,Sy,-Mediane1);
Offset(ImgIntIn2,ImgDoubleIn2,TypeData,1,Sx,Sy,-Mediane2);

// On fait la FFT
FFTDirect(ImgIntIn1,ImgDoubleIn1,TypeData,ImgFFT1,Sx,Sy);
Sx:=SxOld;
Sy:=SyOld;
FFTDirect(ImgIntIn2,ImgDoubleIn2,TypeData,ImgFFT2,Sx,Sy);

// Produit d'inter-corrélation
for j:=1 to Sy do
   for i:=1 to Sx do
      begin
      a1:=ImgFFT1^[1]^[j]^[i];
      b1:=ImgFFT1^[2]^[j]^[i];
      a2:=ImgFFT2^[1]^[j]^[i];
      b2:=ImgFFT2^[2]^[j]^[i];
      Module:=Sqrt((Sqr(a1)+Sqr(b1))*(Sqr(a2)+Sqr(b2)));
      if Module=0 then Module:=1e-20;
      ImgFFT1^[1]^[j]^[i]:=(a1*a2+b1*b2)/Module;
      ImgFFT1^[2]^[j]^[i]:=(a2*b1-a1*b2)/Module;
      end;

FFTInverse(ImgFFT1,Sx,Sy);
PermuteQuadrants(ImgIntNil,ImgFFT1,5,1,Sx,Sy);

Getmem(ImgDoubleOut,4);
Getmem(ImgDoubleOut^[1],Sy*4);
for j:=1 to Sy do
   begin
   Getmem(ImgDoubleOut^[1]^[j],Sx*8);
   Move(ImgFFT1^[1]^[j]^,ImgDoubleOut^[1]^[j]^,Sx*8);
   end;

for j:=1 to Sy do Freemem(ImgFFT1^[1]^[j],Sx*8);
Freemem(ImgFFT1^[1],Sy*4);
Freemem(ImgFFT1,4);

for k:=1 to 2 do
   begin
   for j:=1 to Sy do Freemem(ImgFFT2^[k]^[j],Sx*8);
   Freemem(ImgFFT2^[k],Sy*4);
   end;
Freemem(ImgFFT2,8);

case TypeData of
   2:begin
     for j:=1 to SyOld do Freemem(ImgIntIn1^[1]^[j],SxOld*2);
     Freemem(ImgIntIn1^[1],SyOld*4);
     Freemem(ImgIntIn1,4);
     end;
   5:begin
     for j:=1 to SyOld do Freemem(ImgDoubleIn1^[1]^[j],SxOld*8);
     Freemem(ImgDoubleIn1^[1],SyOld*4);
     Freemem(ImgDoubleIn1,4);
     end;
   end;
end;

procedure AutoCorrele(var ImgIntIn:PTabImgInt;
                      var ImgDoubleIn:PTabImgDouble;
                      var ImgDoubleOut:PTabImgDouble;
                      TypeData:Byte;
                      var Sx,Sy:Integer);
var
Maxi,Mini,Mediane,Moy,Ecart:Double;
ImgFFT:PTabImgDouble;
i,j,k:Integer;
SxOld,SyOld:Integer;
a,b,Module:Double;
ImgIntNil:PTabImgInt;
begin
SxOld:=Sx;
SyOld:=Sy;

// On enleve le fond du ciel
Statistiques(ImgIntIn,ImgDoubleIn,TypeData,1,Sx,Sy,1,Mini,Mediane,Maxi,Moy,Ecart);
Offset(ImgIntIn,ImgDoubleIn,TypeData,1,Sx,Sy,-Moy);

// On fait la FFT
FFTDirect(ImgIntIn,ImgDoubleIn,TypeData,ImgFFT,Sx,Sy);

// Produit d'auto-corrélation
for j:=1 to Sy do
   for i:=1 to Sx do
      begin
      a:=ImgFFT^[1]^[j]^[i];
      b:=ImgFFT^[2]^[j]^[i];
      Module:=Sqr(a)+Sqr(b);
      if Module=0 then Module:=1e-20;
//      ImgFFT^[1]^[j]^[i]:=(a*a+b*b)/Module/Sx/Sy;
      ImgFFT^[1]^[j]^[i]:=(a*a+b*b);
      ImgFFT^[2]^[j]^[i]:=0;
      end;

FFTInverse(ImgFFT,Sx,Sy);
PermuteQuadrants(ImgIntNil,ImgFFT,5,1,Sx,Sy);

Getmem(ImgDoubleOut,4);
Getmem(ImgDoubleOut^[1],Sy*4);
for j:=1 to Sy do
   begin
   Getmem(ImgDoubleOut^[1]^[j],Sx*8);
   Move(ImgFFT^[1]^[j]^,ImgDoubleOut^[1]^[j]^,Sx*8);
   end;

for j:=1 to Sy do Freemem(ImgFFT^[1]^[j],Sx*8);
Freemem(ImgFFT^[1],Sy*4);
Freemem(ImgFFT,4);

case TypeData of
   2:begin
     for j:=1 to SyOld do Freemem(ImgIntIn^[1]^[j],SxOld*2);
     Freemem(ImgIntIn^[1],SyOld*4);
     Freemem(ImgIntIn,4);
     end;
   5:begin
     for j:=1 to SyOld do Freemem(ImgDoubleIn^[1]^[j],SxOld*8);
     Freemem(ImgDoubleIn^[1],SyOld*4);
     Freemem(ImgDoubleIn,4);
     end;
   end;
end;

procedure ValAbs(var ImgInt:PTabImgInt;
                 var ImgDouble:PTabImgDouble;
                 TypeData,NbPlans:Byte;
                 Sx,Sy:Integer);
var
i,j,k:Integer;
begin
for k:=1 to NbPlans do
   begin
   for i:=1 to Sx do
      begin
      case TypeData of
         2,7:begin
             for j:=1 to Sy do
                ImgInt^[k]^[j]^[i]:=Abs(ImgInt^[k]^[j]^[i]);
             end;
         5,6,8:begin
               for j:=1 to Sy do
                  ImgDouble^[k]^[j]^[i]:=Abs(ImgDouble^[k]^[j]^[i]);
               end;
         end;
      end;
   end;
end;

procedure PermutePlan(var ImgInt:PTabImgInt;
                      var ImgDouble:PTabImgDouble;
                      TypeData,NbPlans:Byte;
                      Sx,Sy,Index1,Index2:Integer);
var
   j:Integer;
   LigInt:PLigInt;
   LigDouble:PLigDouble;
begin

case TypeData of
   2,7:begin
       Getmem(LigInt,Sx*2);
       try

       for j:=1 to Sy do
          begin
          Move(ImgInt^[Index1]^[j]^,LigInt^,Sx*2);
          Move(ImgInt^[Index2]^[j]^,ImgInt^[Index1]^[j]^,Sx*2);
          Move(LigInt^,ImgInt^[Index2]^[j]^,Sx*2);
          end;

       finally
       Freemem(LigInt,Sx*2);
       end;
       end;
   5,6,8:begin
         Getmem(LigDouble,Sx*8);
         try

         for j:=1 to Sy do
            begin
            Move(ImgDouble^[Index1]^[j]^,LigDouble^,Sx*8);
            Move(ImgDouble^[Index2]^[j]^,ImgDouble^[Index1]^[j]^,Sx*8);
            Move(LigDouble^,ImgDouble^[Index2]^[j]^,Sx*8);
            end;

         finally
         Freemem(LigDouble,Sx*8);
         end;
         end;
   end;

end;

procedure CorrectionCosmetique(var ImgInt:PTabImgInt;
                               var ImgDouble:PTabImgDouble;
                               TypeData,NbPlans:Byte;
                               Sx,Sy:Integer;
                               FileName:string);
var
   Script:TStrings;
   i,PosEsp,Arg1,Arg2:Integer;
   Line,Commande:string;
begin
   Script:=TStringList.Create;
   Script.LoadFromFile(FileName);
   for i:=0 to Script.Count-1 do
      begin
      Line:=Script.Strings[i];

      Line:=Trim(Line);
      PosEsp:=Pos(' ',Line);
      Commande:=Copy(Line,1,PosEsp-1);
      Delete(Line,1,PosEsp);

      if Commande='HealRow' then //nolang
         begin
         Line:=Trim(Line);
         Arg1:=StrToInt(Line);
         CicatriseLigne(ImgInt,ImgDouble,TypeData,NbPlans,Sx,Sy,Arg1);
         end;

      if Commande='HealColumn' then //nolang
         begin
         Line:=Trim(Line);
         Arg1:=StrToInt(Line);
         CicatriseColonne(ImgInt,ImgDouble,TypeData,NbPlans,Sx,Sy,Arg1);
         end;

      if Commande='HealPixel' then //nolang
         begin
         Line:=Trim(Line);
         PosEsp:=Pos(' ',Line);
         Arg1:=StrToInt(Copy(Line,1,PosEsp-1));
         Delete(Line,1,PosEsp);

         Line:=Trim(Line);
         Arg2:=StrToInt(Line);
         CicatrisePixel(ImgInt,ImgDouble,TypeData,NbPlans,Sx,Sy,Arg1,Arg2);
         end;
      end;
end;

procedure SetValue(var ImgInt:PTabImgInt;
                   var ImgDouble:PTabImgDouble;
                   TypeData,NbPlans:Byte;
                   Sx,Sy:Integer;
                   Value:Double);
var
i,j,k:Integer;
begin
for k:=1 to NbPlans do
   begin
   for i:=1 to Sx do
      begin
      case TypeData of
         2,7:begin
             for j:=1 to Sy do
                ImgInt^[k]^[j]^[i]:=Round(Value);
             end;
         5,6,8:begin
               for j:=1 to Sy do
                  ImgDouble^[k]^[j]^[i]:=Value;
               end;
         end;
      end;
   end;
end;

function RGB2Gris(var ImgIntIn:PTabImgInt;
                  var ImgDoubleIn:PTabImgDouble;
                  TypeData,nbPlans,Sx,Sy:Integer;var ErrCode:byte):pointer;
var
   i,j:integer;
   pixint:Integer;pixdbl:double;img:pointer;
begin
 ErrCode:=0;
 result:=NIL;
 if (typeData <> 7) and (TypeData <> 8) then
  begin
   ErrCode:=1;
   exit;
  end;
 {pour confirmation}
 if nbPlans <> 3 then
  begin
   ErrCode:=2;
   exit;
  end;
{Image couleur codée en entier}
 if TypeData = 7 then
  begin
   GetMemImg(PTabImgInt(Img),PTabImgDouble(Img),Sx,Sy,2,1);
   if Img = NIL then
    begin
     ErrCode:=3;
     exit;
    end;
   for j:=1 to Sy do
    for i:=1 to Sx do
     begin
      PTabImgInt(Img)^[1]^[j]^[i]:=round(ImgIntIn^[1]^[j]^[i] * 0.3 + ImgIntIn^[2]^[j]^[i] * 0.59 + ImgIntIn^[3]^[j]^[i] * 0.11);
     end;
  end;
{Image couleur codée en flottant}
 if TypeData = 8 then
  begin
   GetMemImg(PTabImgInt(Img),PTabImgDouble(Img),Sx,Sy,5,1);
   if Img = NIL then exit;
    begin
     ErrCode:=4;
     exit;
    end;
   for j:=1 to Sy do
    for i:=1 to Sx do
     begin
      PTabImgDouble(Img)^[1]^[j]^[i]:= ImgDoubleIn^[1]^[j]^[i] * 0.3 + ImgDoubleIn^[2]^[j]^[i] * 0.59 + ImgDoubleIn^[3]^[j]^[i] * 0.11;
     end;
  end;
 result:=Img;
end;

{

	  0 1 2 3 4 5	  0 1 2 3 4 5	  0 1 2 3 4 5	  0 1 2 3 4 5
	0 B G B G B G	0 G R G R G R	0 G B G B G B	0 R G R G R G
	1 G R G R G R	1 B G B G B G	1 R G R G R G	1 G B G B G B
	2 B G B G B G	2 G R G R G R	2 G B G B G B	2 R G R G R G
	3 G R G R G R	3 B G B G B G	3 R G R G R G	3 G B G B G B

}

const Rouge=1;Vert=2;Bleu=3;
      BGGR = 1;RGGB = 2;GRBG = 3;GBRG = 4;

procedure GetRGGB(cfa:PImgInt;var ImgColorInt:PTabImgInt;sx,sy:integer);
var i,j,r,b,v1,v2,v3,v4:word;v:integer;
begin
//*--- separation des plans de couleur CFA --- */
    j:=1;
    while j < Sy - 1 do
     begin
       i:=1;
       while i < Sx - 1 do
       begin
        r:=cfa^[j]^[i];
        ImgColorInt^[Rouge]^[j]^[i]:=r;
        ImgColorInt^[Rouge]^[j]^[i+1]:=r;
        ImgColorInt^[Rouge]^[j+1]^[i]:=r;
        ImgColorInt^[Rouge]^[j+1]^[i+1]:=r;
        inc(i,2);
       end;
       inc(j,2);
       end;
    j:=3;
    while j < Sy - 1 do
     begin
       i:=3;
       while i < Sx - 1 do
       begin
        v1:=cfa^[j]^[i-1];
        v2:=cfa^[j-1]^[i];
        v3:=cfa^[j]^[i+1];
        v4:=cfa^[j+1]^[i];
        v:=(v1+v2+v3+v4) shr 2;
        ImgColorInt^[Vert]^[j]^[i]:=v;
        ImgColorInt^[Vert]^[j]^[i+1]:=v3;
        ImgColorInt^[Vert]^[j+1]^[i]:=v4;
        v1:=cfa^[j+1]^[i+2];
        v2:=cfa^[j+2]^[i+1];
        v:=(v1 + v4 + v3 + v2) shr 2;
        ImgColorInt^[Vert]^[j+1]^[i+1]:=v;
        inc(i,2);
       end;
       inc(j,2);
       end;
    j:=1;
    while j < Sy - 1 do
     begin
       i:=1;
       while i < Sx - 1 do
       begin
        b:=cfa^[j+1]^[i+1];
        ImgColorInt^[Bleu]^[j]^[i]:=b;
        ImgColorInt^[Bleu]^[j]^[i+1]:=b;
        ImgColorInt^[Bleu]^[j+1]^[i]:=b;
        ImgColorInt^[Bleu]^[j+1]^[i+1]:=b;
        inc(i,2);
       end;
       inc(j,2);
       end;
end;


procedure GetBGGR(cfa:PImgInt;var ImgColorInt:PTabImgInt;sx,sy:integer);
var i,j,r,b,v1,v2,v3,v4:word;v:integer;
begin
//*--- separation des plans de couleur CFA --- */
    j:=1;
    while j < Sy - 1 do
     begin
       i:=1;
       while i < Sx - 1 do
       begin
        r:=cfa^[j]^[i];
        ImgColorInt^[Bleu]^[j]^[i]:=r;
        ImgColorInt^[Bleu]^[j]^[i+1]:=r;
        ImgColorInt^[Bleu]^[j+1]^[i]:=r;
        ImgColorInt^[Bleu]^[j+1]^[i+1]:=r;
        inc(i,2);
       end;
       inc(j,2);
       end;
    j:=3;
    while j < Sy - 1 do
     begin
       i:=3;
       while i < Sx - 1 do
       begin
        v1:=cfa^[j]^[i-1];
        v2:=cfa^[j-1]^[i];
        v3:=cfa^[j]^[i+1];
        v4:=cfa^[j+1]^[i];
        v:=(v1+v2+v3+v4) shr 2;
        ImgColorInt^[Vert]^[j]^[i]:=v;
        ImgColorInt^[Vert]^[j]^[i+1]:=v3;
        ImgColorInt^[Vert]^[j+1]^[i]:=v4;
        v1:=cfa^[j+1]^[i+2];
        v2:=cfa^[j+2]^[i+1];
        v:=(v1 + v4 + v3 + v2) shr 2;
        ImgColorInt^[Vert]^[j+1]^[i+1]:=v;
        inc(i,2);
       end;
       inc(j,2);
       end;
    j:=1;
    while j < Sy - 1 do
     begin
       i:=1;
       while i < Sx - 1 do
       begin
        b:=cfa^[j+1]^[i+1];
        ImgColorInt^[Rouge]^[j]^[i]:=b;
        ImgColorInt^[Rouge]^[j]^[i+1]:=b;
        ImgColorInt^[Rouge]^[j+1]^[i]:=b;
        ImgColorInt^[Rouge]^[j+1]^[i+1]:=b;
        inc(i,2);
       end;
       inc(j,2);
       end;
end;

procedure GetGBRG(cfa:PImgInt;var ImgColorInt:PTabImgInt;sx,sy:integer);
var i,j,r,b,v1,v2,v3,v4:word;v:integer;
begin
//*--- separation des plans de couleur CFA --- */
    j:=1;
    while j < Sy - 1 do
     begin
       i:=1;
       while i < Sx - 1 do
       begin
        b:=cfa^[j]^[i+1];
        ImgColorInt^[Bleu]^[j]^[i]:=b;
        ImgColorInt^[Bleu]^[j]^[i+1]:=b;
        ImgColorInt^[Bleu]^[j+1]^[i]:=b;
        ImgColorInt^[Bleu]^[j+1]^[i+1]:=b;
        inc(i,2);
       end;
       inc(j,2);
       end;
    j:=3;
    while j < Sy - 1 do
     begin
       i:=3;
       while i < Sx - 1 do
       begin
        v1:=cfa^[j]^[i];
        v2:=cfa^[j-1]^[i+1];
        v3:=cfa^[j]^[i+2];
        v4:=cfa^[j+1]^[i+1];
        v:=(v1+v2+v3+v4) shr 2;
        ImgColorInt^[Vert]^[j]^[i]:=v1;
        ImgColorInt^[Vert]^[j+1]^[i+1]:=v4;
        ImgColorInt^[Vert]^[j]^[i+1]:=v;
        v2:=cfa^[j+1]^[i-1];
        v3:=cfa^[j+2]^[i];
        v:=(v1 + v4 + v3 + v2) shr 2;
        ImgColorInt^[Vert]^[j+1]^[i]:=v;
        inc(i,2);
       end;
       inc(j,2);
       end;
    j:=1;
    while j < Sy - 1 do
     begin
       i:=1;
       while i < Sx - 1 do
       begin
        r:=cfa^[j+1]^[i];
        ImgColorInt^[Rouge]^[j]^[i]:=r;
        ImgColorInt^[Rouge]^[j]^[i+1]:=r;
        ImgColorInt^[Rouge]^[j+1]^[i]:=r;
        ImgColorInt^[Rouge]^[j+1]^[i+1]:=r;
        inc(i,2);
       end;
       inc(j,2);
       end;
end;

procedure GetGRBG(cfa:PImgInt;var ImgColorInt:PTabImgInt;sx,sy:integer);
var i,j,r,b,v1,v2,v3,v4:word;v:integer;
begin
//*--- separation des plans de couleur CFA --- */
    j:=1;
    while j < Sy - 1 do
     begin
       i:=1;
       while i < Sx - 1 do
       begin
        r:=cfa^[j]^[i+1];
        ImgColorInt^[Rouge]^[j]^[i]:=r;
        ImgColorInt^[Rouge]^[j]^[i+1]:=r;
        ImgColorInt^[Rouge]^[j+1]^[i]:=r;
        ImgColorInt^[Rouge]^[j+1]^[i+1]:=r;
        inc(i,2);
       end;
       inc(j,2);
       end;
    j:=3;
    while j < Sy - 1 do
     begin
       i:=3;
       while i < Sx - 1 do
       begin
        v1:=cfa^[j]^[i];
        v2:=cfa^[j-1]^[i+1];
        v3:=cfa^[j]^[i+2];
        v4:=cfa^[j+1]^[i+1];
        v:=(v1+v2+v3+v4) shr 2;
        ImgColorInt^[Vert]^[j]^[i]:=v1;
        ImgColorInt^[Vert]^[j+1]^[i+1]:=v4;
        ImgColorInt^[Vert]^[j]^[i+1]:=v;
        v2:=cfa^[j+1]^[i-1];
        v3:=cfa^[j+2]^[i];
        v:=(v1 + v4 + v3 + v2) shr 2;
        ImgColorInt^[Vert]^[j+1]^[i]:=v;
        inc(i,2);
       end;
       inc(j,2);
       end;
    j:=1;
    while j < Sy - 1 do
     begin
       i:=1;
       while i < Sx - 1 do
       begin
        b:=cfa^[j+1]^[i];
        ImgColorInt^[Bleu]^[j]^[i]:=b;
        ImgColorInt^[Bleu]^[j]^[i+1]:=b;
        ImgColorInt^[Bleu]^[j+1]^[i]:=b;
        ImgColorInt^[Bleu]^[j+1]^[i+1]:=b;
        inc(i,2);
       end;
       inc(j,2);
       end;
end;

procedure CFA_RGB(ImgInt:PTabImgInt;
                  ImgDouble:PTabImgDouble;
                  var ImgColorInt:PTabImgInt;
                  var ImgColorDbl:PTabImgDouble;
                  cfaformat:byte;
                  TypeData,NbPlans:Byte;
                  var Sx,Sy:Integer;
                  var resultat:byte);
var
i,j,k,ki,kj:integer;cfa:PImgInt;cfaDbl:PImgDouble;
ri,vi,bi:word;vi1,vi2:integer;
rd,vd,bd,vd1,vd2:double;
begin
try
 if NbPlans <> 1 then exit;
 GetmemImg(ImgColorInt,ImgColorDbl,Sx,Sy,TypeData,3);
 case TypeData of
  2:
   begin
    cfa:=ImgInt^[1];
//*--- separation des plans de couleur CFA --- */
    case cfaformat of
     BGGR:GetBGGR(cfa,ImgColorInt,sx,sy);
     RGGB:GetRGGB(cfa,ImgColorInt,sx,sy);
     GBRG:GetGBRG(cfa,ImgColorInt,sx,sy);
     GRBG:GetGRBG(cfa,ImgColorInt,sx,sy);
    end;
//exit;
//* --- interpolation pour l'image rouge ---*/
   j:=1;
   while j<=Sy do
   begin
      i:=2;
      while i<=Sx-1 do
      begin
         ri:=ImgColorInt^[Rouge]^[j]^[i-1];
         vi:=ImgColorInt^[Rouge]^[j]^[i+1];
         ImgColorInt^[Rouge]^[j]^[i]:=(ri+vi) shr 1; //round((ri+vi)/2);
         i:=i+2;
      end;
      j:=j+2;
   end;
   j:=2;
   while j<=Sy-1 do
   begin
      for i:=1 to Sx do
      begin
         ri:=ImgColorInt^[Rouge]^[j-1]^[i];
         vi:=ImgColorInt^[Rouge]^[j+1]^[i];
         ImgColorInt^[Rouge]^[j]^[i]:=(ri+vi) shr 1; //round((ri+vi)/2);
      end;
      j:=j+2;
   end;
//* --- interpolation pour l'image bleue ---*/
   j:=2;
   while j<=Sy do
   begin
      i:=3;
      while i<=Sx-1 do
      begin
         ri:=ImgColorInt^[Bleu]^[j]^[i-1];
         vi:=ImgColorInt^[Bleu]^[j]^[i+1];
         ImgColorInt^[bleu]^[j]^[i]:=(ri+vi) shr 1;  //round((ri+vi)/2);
         i:=i+2;
      end;
      j:=j+2;
   end;
   j:=3;
   while j<=Sy-1 do
   begin
      for i:=1 to Sx do
      begin
         ri:=ImgColorInt^[Bleu]^[j-1]^[i];
         vi:=ImgColorInt^[Bleu]^[j+1]^[i];
         ImgColorInt^[Bleu]^[j]^[i]:=(ri+vi) shr 1; //round((ri+vi)/2);
      end;
      j:=j+2;
   end;
//* --- Pas d'interpolation pour l'image verte car déjà faite ---*/
{
//* --- conversion CMY en RGB ---*/
   for j:=1 to Sy do
   begin
      for i:=1 to Sx do
      begin
         ri:=ImgColorInt^[Rouge]^[j]^[i];
         vi:=ImgColorInt^[Vert]^[j]^[i];
         bi:=ImgColorInt^[Bleu]^[j]^[i];
         ImgColorInt^[Rouge]^[j]^[i]:=(vi+bi);
         ImgColorInt^[Vert]^[j]^[i]:=(bi+ri);
         ImgColorInt^[Bleu]^[j]^[i]:=(ri+vi);
      end;
   end;
}
   end;
  5,6,8:
   begin
    //cfaDbl:=ImgDouble^[1];  //faire la même chose que pour les dataint
   end;
 end;
except
end;
end;


end.
