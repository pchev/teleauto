unit u_analyse;

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

uses u_class, sysutils, Forms, pu_image;

procedure Statistiques(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;
                       TypeData,TypeComplexe:Byte;Sx,Sy:Integer;NoPlan:Byte;
                       var Min,Mediane,Max,Moy,Ecart:Double);
procedure StatistiquesVisu(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;
                           TypeData,TypeComplexe:Byte;Sx,Sy:Integer;NoPlan:Byte;
                           var Min,Mediane,Max,Moy,Ecart:Double);
procedure Minimum(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;
                  TypeData,TypeComplexe:Byte;Sx,Sy:Integer;NoPlan:Byte;
                  var Min:Double);
procedure RechercheSeuils(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;
                          TypeData,TypeComplexe:Byte;Sx,Sy:Integer;NoPlan:Byte;
                          PourcentLow,PourcentHigh:Double;
                          var SeuilBas,SeuilHaut:Double);
procedure RechercheSeuils1(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;
                           TypeData,TypeComplexe:Byte;Sx,Sy:Integer;NoPlan:Byte;
                           PourcentLow,PourcentHigh:Double;
                           var SeuilBas,SeuilHaut:Double);
procedure GetMax(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;TypeData:Byte;
                 Sx,Sy:Integer;var x,y:Integer;var ValMax:Double);
function IntegraleAbs(TabImgInt:PTabImgInt;
                      TabImgDouble:PTabImgDouble;
                      TypeDonnees,NbPlans:Byte;
                      Sx,Sy:Integer):Double;
procedure MesureCentreEtDiametre(ImgIntIn:PTabImgInt;
                                 ImgDoubleIn:PTabImgDouble;
                                 TypeData:Byte;
                                 Sx,Sy:Integer;
                                 var X,Y,Diametre:Double);
procedure HFD(var ImgIntIn:PTabImgInt;
              var ImgDoubleIn:PTabImgDouble;
              TypeDataH:Byte;
              SxH,SyH:Integer;
              var X,Y,Diametre:Double);
procedure RechercheSeuilsVisu(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;
                              TypeData,TypeComplexe:Byte;Sx,Sy:Integer;NoPlan:Byte;
                              PourcentLow,PourcentHigh:Double;
                              var SeuilBas,SeuilHaut:Double);
function GetApertureFlux(ImgInt:PTabImgInt;
                         ImgDouble:PTabImgDouble;
                         Typedata:Byte;
                         XImg,YImg,R:Integer;
                         var Nb:Integer):Double;
procedure Isophotes(var ImgIntIn:PTabImgInt;
                    var ImgDoubleIn:PTabImgDouble;
                    TypeData,NbPlans:Byte;
                    Sx,Sy:Integer;bas,haut,num:integer);

implementation

uses u_constants,
     u_file_io,
     u_arithmetique,
     u_general,
     pu_graph,
     u_modelisation;

// Recherche des statistiques de l'image
procedure Statistiques(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;
                       TypeData,TypeComplexe:Byte;Sx,Sy:Integer;NoPlan:Byte;
                       var Min,Mediane,Max,Moy,Ecart:Double);
var
i,j:Integer;
Valeur,ValHisto:Double;
N,Nb:Longint;
Nb2,Dx:double;
Hist:array[-32768..32767] of Longint;
begin
Max:=-32768;
Min:=32767;
Moy:=0;
Ecart:=0;
Mediane:=0;
N:=0;
Nb:=0;
for i:=-32768 to 32767 do Hist[i]:=0;
for j:=1 to Sy do
   case TypeData of
   2,7:for i:=1 to Sx do
        begin
        Valeur:=ImgInt^[NoPlan]^[j]^[i];
        inc(N);
        if Valeur>Max then Max:=Valeur;
        if Valeur<Min then Min:=Valeur;
        inc(Hist[Round(Valeur)]);
        inc(Nb);
        Dx:=Valeur-Moy;
        Moy:=Moy+Dx/Nb;
        Ecart:=Ecart+Dx*(Valeur-Moy);
        end;
   5,8:for i:=1 to Sx do
        begin
        Valeur:=ImgDouble^[NoPlan]^[j]^[i];
        inc(N);
        if Valeur>Max then Max:=Valeur;
        if Valeur<Min then Min:=Valeur;
        ValHisto:=Valeur;
        if ValHisto>=32767 then ValHisto:=32767;
        if ValHisto<=-32768 then ValHisto:=-32768;
        inc(Hist[Round(ValHisto)]);
        inc(Nb);
        Dx:=Valeur-Moy;
        Moy:=Moy+Dx/Nb;
        Ecart:=Ecart+Dx*(Valeur-Moy);
        end;
   6:begin
     case TypeComplexe of
        1:for i:=1 to Sx do
             begin
             Valeur:=Sqrt(Sqr(ImgDouble^[1]^[j]^[i])+Sqr(ImgDouble^[2]^[j]^[i]));
             inc(N);
             if Valeur>Max then Max:=Valeur;
             if Valeur<Min then Min:=Valeur;
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             Dx:=Valeur-Moy;
             Moy:=Moy+Dx/Nb;
             Ecart:=Ecart+Dx*(Valeur-Moy);
             end;
        2:for i:=1 to Sx do
             begin
             if ImgDouble^[1]^[j]^[i]<>0 then
                Valeur:=ArcTan(abs((ImgDouble^[2]^[j]^[i])/(ImgDouble^[1]^[j]^[i])))
             else
                Valeur:=Pi/2;
             inc(N);
             if Valeur>Max then Max:=Valeur;
             if Valeur<Min then Min:=Valeur;
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             Dx:=Valeur-Moy;
             Moy:=Moy+Dx/Nb;
             Ecart:=Ecart+Dx*(Valeur-Moy);
             end;
        3:for i:=1 to Sx do
             begin
             Valeur:=ImgDouble^[1]^[j]^[i];
             inc(N);
             if Valeur>Max then Max:=Valeur;
             if Valeur<Min then Min:=Valeur;
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             Dx:=Valeur-Moy;
             Moy:=Moy+Dx/Nb;
             Ecart:=Ecart+Dx*(Valeur-Moy);
             end;
        4:for i:=1 to Sx do
             begin
             Valeur:=ImgDouble^[2]^[j]^[i];
             inc(N);
             if Valeur>Max then Max:=Valeur;
             if Valeur<Min then Min:=Valeur;
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             Dx:=Valeur-Moy;
             Moy:=Moy+Dx/Nb;
             Ecart:=Ecart+Dx*(Valeur-Moy);
             end;
        end;
     end;
   end;
for i:=-32767 to 32767 do Hist[i]:=Hist[i]+Hist[i-1];
Nb2:=Nb/2;
for i:=-32768 to 32767 do
   if (Hist[i]<=Nb2) and (Hist[i+1]>=Nb2)
      then Mediane:=i+1;
Ecart:=Sqrt(Ecart/N);
end;

// Recherche des statistiques de l'image
procedure StatistiquesVisu(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;
                           TypeData,TypeComplexe:Byte;Sx,Sy:Integer;NoPlan:Byte;
                           var Min,Mediane,Max,Moy,Ecart:Double);
var
i,j:Integer;
Valeur,ValHisto:Double;
N,Nb:Longint;
Nb2,Dx:double;
Hist:array[-32768..32767] of Longint;
Min1,Mediane1,Max1,Moy1,Ecart1:Double;
begin
Max1:=-32768;
Min1:=32767;
Moy1:=0;
Ecart1:=0;
Mediane1:=0;
N:=0;
Nb:=0;
for i:=-32768 to 32767 do Hist[i]:=0;
for j:=1 to Sy do
   case TypeData of
   2,7:for i:=1 to Sx do
        begin
        Valeur:=ImgInt^[NoPlan]^[j]^[i];
        inc(N);
        if Valeur>Max1 then Max1:=Valeur;
        if Valeur<Min1 then Min1:=Valeur;
        inc(Hist[Round(Valeur)]);
        inc(Nb);
        Dx:=Valeur-Moy1;
        Moy1:=Moy1+Dx/Nb;
        Ecart1:=Ecart1+Dx*(Valeur-Moy1);
        end;
   5,8:for i:=1 to Sx do
        begin
        Valeur:=ImgDouble^[NoPlan]^[j]^[i];
        inc(N);
        if Valeur>Max1 then Max1:=Valeur;
        if Valeur<Min1 then Min1:=Valeur;
        ValHisto:=Valeur;
        if ValHisto>=32767 then ValHisto:=32767;
        if ValHisto<=-32768 then ValHisto:=-32768;
        inc(Hist[Round(ValHisto)]);
        inc(Nb);
        Dx:=Valeur-Moy1;
        Moy1:=Moy1+Dx/Nb;
        Ecart1:=Ecart1+Dx*(Valeur-Moy1);
        end;
   6:begin
     case TypeComplexe of
        1:for i:=1 to Sx do
             begin
             Valeur:=Sqrt(Sqr(ImgDouble^[1]^[j]^[i])+Sqr(ImgDouble^[2]^[j]^[i]));
             inc(N);
             if Valeur>Max1 then Max1:=Valeur;
             if Valeur<Min1 then Min1:=Valeur;
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             Dx:=Valeur-Moy1;
             Moy1:=Moy1+Dx/Nb;
             Ecart1:=Ecart1+Dx*(Valeur-Moy1);
             end;
        2:for i:=1 to Sx do
             begin
             if ImgDouble^[1]^[j]^[i]<>0 then
                Valeur:=ArcTan(abs((ImgDouble^[2]^[j]^[i])/(ImgDouble^[1]^[j]^[i])))
             else
                Valeur:=Pi/2;
             inc(N);
             if Valeur>Max1 then Max1:=Valeur;
             if Valeur<Min1 then Min1:=Valeur;
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             Dx:=Valeur-Moy1;
             Moy1:=Moy1+Dx/Nb;
             Ecart1:=Ecart1+Dx*(Valeur-Moy1);
             end;
        3:for i:=1 to Sx do
             begin
             Valeur:=ImgDouble^[1]^[j]^[i];
             inc(N);
             if Valeur>Max1 then Max1:=Valeur;
             if Valeur<Min1 then Min1:=Valeur;
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             Dx:=Valeur-Moy1;
             Moy1:=Moy1+Dx/Nb;
             Ecart1:=Ecart1+Dx*(Valeur-Moy1);
             end;
        4:for i:=1 to Sx do
             begin
             Valeur:=ImgDouble^[2]^[j]^[i];
             inc(N);
             if Valeur>Max1 then Max1:=Valeur;
             if Valeur<Min1 then Min1:=Valeur;
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             Dx:=Valeur-Moy1;
             Moy1:=Moy1+Dx/Nb;
             Ecart1:=Ecart1+Dx*(Valeur-Moy1);
             end;
        end;
     end;
   end;
for i:=-32767 to 32767 do Hist[i]:=Hist[i]+Hist[i-1];
Nb2:=Nb/2;
for i:=-32768 to 32767 do
   if (Hist[i]<=Nb2) and (Hist[i+1]>=Nb2)
      then Mediane1:=i+1;
Ecart1:=Sqrt(Ecart1/N);

Max:=-32768;
Min:=32767;
Moy:=0;
Ecart:=0;
Mediane:=0;
N:=0;
Nb:=0;
for i:=-32768 to 32767 do Hist[i]:=0;
for j:=1 to Sy do
   case TypeData of
   2,7:for i:=1 to Sx do
        begin
        Valeur:=ImgInt^[NoPlan]^[j]^[i];
        if Valeur<Max1-Ecart1 then
           begin
           inc(N);
           if Valeur>Max then Max:=Valeur;
           if Valeur<Min then Min:=Valeur;
           inc(Hist[Round(Valeur)]);
           inc(Nb);
           Dx:=Valeur-Moy;
           Moy:=Moy+Dx/Nb;
           Ecart:=Ecart+Dx*(Valeur-Moy);
           end;
        end;
   5,8:for i:=1 to Sx do
        begin
        Valeur:=ImgDouble^[NoPlan]^[j]^[i];
        if Valeur<Max1-Ecart1 then
           begin
           inc(N);
           if Valeur>Max then Max:=Valeur;
           if Valeur<Min then Min:=Valeur;
           ValHisto:=Valeur;
           if ValHisto>=32767 then ValHisto:=32767;
           if ValHisto<=-32768 then ValHisto:=-32768;
           inc(Hist[Round(ValHisto)]);
           inc(Nb);
           Dx:=Valeur-Moy;
           Moy:=Moy+Dx/Nb;
           Ecart:=Ecart+Dx*(Valeur-Moy);
           end;
        end;
   6:begin
     case TypeComplexe of
        1:for i:=1 to Sx do
             begin
             Valeur:=Sqrt(Sqr(ImgDouble^[1]^[j]^[i])+Sqr(ImgDouble^[2]^[j]^[i]));
             if Valeur<Max1-Ecart1 then
                begin
                inc(N);
                if Valeur>Max then Max:=Valeur;
                if Valeur<Min then Min:=Valeur;
                ValHisto:=Valeur;
                if ValHisto>=32767 then ValHisto:=32767;
                if ValHisto<=-32768 then ValHisto:=-32768;
                inc(Hist[Round(ValHisto)]);
                inc(Nb);
                Dx:=Valeur-Moy;
                Moy:=Moy+Dx/Nb;
                Ecart:=Ecart+Dx*(Valeur-Moy);
                end;
             end;
        2:for i:=1 to Sx do
             begin
             if ImgDouble^[1]^[j]^[i]<>0 then
                Valeur:=ArcTan(abs((ImgDouble^[2]^[j]^[i])/(ImgDouble^[1]^[j]^[i])))
             else
                Valeur:=Pi/2;
             if Valeur<Max1-Ecart1 then
                begin
                inc(N);
                if Valeur>Max then Max:=Valeur;
                if Valeur<Min then Min:=Valeur;
                ValHisto:=Valeur;
                if ValHisto>=32767 then ValHisto:=32767;
                if ValHisto<=-32768 then ValHisto:=-32768;
                inc(Hist[Round(ValHisto)]);
                inc(Nb);
                Dx:=Valeur-Moy;
                Moy:=Moy+Dx/Nb;
                Ecart:=Ecart+Dx*(Valeur-Moy);
                end;
             end;
        3:for i:=1 to Sx do
             begin
             Valeur:=ImgDouble^[1]^[j]^[i];
             if Valeur<Max1-Ecart1 then
                begin
                inc(N);
                if Valeur>Max then Max:=Valeur;
                if Valeur<Min then Min:=Valeur;
                ValHisto:=Valeur;
                if ValHisto>=32767 then ValHisto:=32767;
                if ValHisto<=-32768 then ValHisto:=-32768;
                inc(Hist[Round(ValHisto)]);
                inc(Nb);
                Dx:=Valeur-Moy;
                Moy:=Moy+Dx/Nb;
                Ecart:=Ecart+Dx*(Valeur-Moy);
                end;
             end;
        4:for i:=1 to Sx do
             begin
             Valeur:=ImgDouble^[2]^[j]^[i];
             if Valeur<Max1-Ecart1 then
                begin
                inc(N);
                if Valeur>Max then Max:=Valeur;
                if Valeur<Min then Min:=Valeur;
                ValHisto:=Valeur;
                if ValHisto>=32767 then ValHisto:=32767;
                if ValHisto<=-32768 then ValHisto:=-32768;
                inc(Hist[Round(ValHisto)]);
                inc(Nb);
                Dx:=Valeur-Moy;
                Moy:=Moy+Dx/Nb;
                Ecart:=Ecart+Dx*(Valeur-Moy);
                end;
             end;
        end;
     end;
   end;
for i:=-32767 to 32767 do Hist[i]:=Hist[i]+Hist[i-1];
Nb2:=Nb/2;

if Nb2<>0 then
   begin
   for i:=-32768 to 32767 do
      if (Hist[i]<=Nb2) and (Hist[i+1]>=Nb2)
         then Mediane:=i+1;
   end
else Mediane:=Mediane1;

if N<>0 then Ecart:=Sqrt(Ecart/N) else Ecart:=0;
end;

procedure Minimum(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;
                  TypeData,TypeComplexe:Byte;Sx,Sy:Integer;NoPlan:Byte;
                  var Min:Double);
var
i,j:Integer;
Valeur:Double;
begin
Min:=32767;
for j:=1 to Sy do
   case TypeData of
   2,7:for i:=1 to Sx do
        begin
        Valeur:=ImgInt^[NoPlan]^[j]^[i];
        if Valeur<Min then Min:=Valeur;
        end;
   5,8:for i:=1 to Sx do
        begin
        Valeur:=ImgDouble^[NoPlan]^[j]^[i];
        if Valeur<Min then Min:=Valeur;
        end;
   6:begin
     case TypeComplexe of
        1:for i:=1 to Sx do
             begin
             Valeur:=Sqrt(Sqr(ImgDouble^[1]^[j]^[i])+Sqr(ImgDouble^[2]^[j]^[i]));
             if Valeur<Min then Min:=Valeur;
             end;
        2:for i:=1 to Sx do
             begin
             if ImgDouble^[1]^[j]^[i]<>0 then
                Valeur:=ArcTan(abs((ImgDouble^[2]^[j]^[i])/(ImgDouble^[1]^[j]^[i])))
             else
                Valeur:=Pi/2;
             if Valeur<Min then Min:=Valeur;
             end;
        3:for i:=1 to Sx do
             begin
             Valeur:=ImgDouble^[1]^[j]^[i];
             if Valeur<Min then Min:=Valeur;
             end;
        4:for i:=1 to Sx do
             begin
             Valeur:=ImgDouble^[2]^[j]^[i];
             if Valeur<Min then Min:=Valeur;
             end;
        end;
     end;
   end;
end;


// Recherche auto des seuils de l'image
procedure RechercheSeuils(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;
                          TypeData,TypeComplexe:Byte;Sx,Sy:Integer;NoPlan:Byte;
                          PourcentLow,PourcentHigh:Double;
                          var SeuilBas,SeuilHaut:Double);
var
i,j:Integer;
Valeur,ValHisto,Nb2:Double;
Nb:Longint;
Hist:array[-32768..32767] of Longint;
begin
Nb:=0;
for i:=-32768 to 32767 do Hist[i]:=0;
for j:=1 to Sy do
   case TypeData of
   2,7:for i:=1 to Sx do
        begin
        Valeur:=ImgInt^[NoPlan]^[j]^[i];
        inc(Hist[Round(Valeur)]);
        inc(Nb);
        end;
   5,8:for i:=1 to Sx do
        begin
        Valeur:=ImgDouble^[NoPlan]^[j]^[i];
        ValHisto:=Valeur;
        if ValHisto>=32767 then ValHisto:=32767;
        if ValHisto<=-32768 then ValHisto:=-32768;
        inc(Hist[Round(ValHisto)]);
        inc(Nb);
        end;
   6:begin
     case TypeComplexe of
        1:for i:=1 to Sx do
             begin
             Valeur:=Sqrt(Sqr(ImgDouble^[1]^[j]^[i])+Sqr(ImgDouble^[2]^[j]^[i]));
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             end;
        2:for i:=1 to Sx do
             begin
             if ImgDouble^[1]^[j]^[i]<>0 then
                Valeur:=ArcTan(abs((ImgDouble^[2]^[j]^[i])/(ImgDouble^[1]^[j]^[i])))
             else
                Valeur:=Pi/2;
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             end;
        3:for i:=1 to Sx do
             begin
             Valeur:=ImgDouble^[1]^[j]^[i];
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             end;
        4:for i:=1 to Sx do
             begin
             Valeur:=ImgDouble^[2]^[j]^[i];
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             end;
        end;
     end;
   end;
for i:=-32767 to 32767 do Hist[i]:=Hist[i]+Hist[i-1];

SeuilBas:=-32768;
Nb2:=PourcentLow*Nb/100;
for i:=-32768 to 32766 do
   if (Hist[i]<=Nb2) and (Hist[i+1]>=Nb2)
      then SeuilBas:=i+1;
//if SeuilBas=0 then SeuilBas:=-32768;

SeuilHaut:=32767;
Nb2:=PourcentHigh*Nb/100;
for i:=-32768 to 32766 do
   if (Hist[i]<=Nb2) and (Hist[i+1]>=Nb2)
      then SeuilHaut:=i+1;

end;

// Recherche auto des seuils de l'image
procedure RechercheSeuils1(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;
                           TypeData,TypeComplexe:Byte;Sx,Sy:Integer;NoPlan:Byte;
                           PourcentLow,PourcentHigh:Double;
                           var SeuilBas,SeuilHaut:Double);
var
i,j:Integer;
Valeur,ValHisto:Double;
Min,Max:Double;
begin
Max:=-32768;
Min:=32767;
for j:=1 to Sy do
   case TypeData of
   2,7:for i:=1 to Sx do
        begin
        Valeur:=ImgInt^[NoPlan]^[j]^[i];
        if Valeur>Max then Max:=Valeur;
        if Valeur<Min then Min:=Valeur;
        end;
   5,8:for i:=1 to Sx do
        begin
        Valeur:=ImgDouble^[NoPlan]^[j]^[i];
        if Valeur>Max then Max:=Valeur;
        if Valeur<Min then Min:=Valeur;
        end;
   6:begin
     case TypeComplexe of
        1:for i:=1 to Sx do
             begin
             Valeur:=Sqrt(Sqr(ImgDouble^[1]^[j]^[i])+Sqr(ImgDouble^[2]^[j]^[i]));
             if Valeur>Max then Max:=Valeur;
             if Valeur<Min then Min:=Valeur;
             end;
        2:for i:=1 to Sx do
             begin
             if ImgDouble^[1]^[j]^[i]<>0 then
                Valeur:=ArcTan(abs((ImgDouble^[2]^[j]^[i])/(ImgDouble^[1]^[j]^[i])))
             else
                Valeur:=Pi/2;
             if Valeur>Max then Max:=Valeur;
             if Valeur<Min then Min:=Valeur;
             end;
        3:for i:=1 to Sx do
             begin
             Valeur:=ImgDouble^[1]^[j]^[i];
             if Valeur>Max then Max:=Valeur;
             if Valeur<Min then Min:=Valeur;
             end;
        4:for i:=1 to Sx do
             begin
             Valeur:=ImgDouble^[2]^[j]^[i];
             if Valeur>Max then Max:=Valeur;
             if Valeur<Min then Min:=Valeur;
             end;
        end;
     end;
   end;
SeuilBas:=Min+PourcentLow*(Max-Min)/100;
SeuilHaut:=Min+PourcentHigh*(Max-Min)/100;
end;


// Trouve la position du maximum dans l'image
// et sa valeur
procedure GetMax(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;TypeData:Byte;
                 Sx,Sy:Integer;var x,y:Integer;var ValMax:Double);
var
i,j:Integer;
ValInt:SmallInt;
ValDouble:Double;
begin
ValMax:=MinDouble;
for j:=1 to Sy do
   begin
   case TypeData of
      2:begin
        for i:=1 to Sx do
           begin
           ValInt:=ImgInt^[1]^[j]^[i];
           if ValInt>ValMax then
              begin
              ValMax:=ValInt;
              x:=i;
              y:=j;
              end;
           end;
        end;
      5:begin
        for i:=1 to Sx do
           begin
           ValDouble:=ImgDouble^[1]^[j]^[i];
           if ValDouble>ValMax then
              begin
              ValMax:=ValDouble;
              x:=i;
              y:=j;
              end;
           end;
        end;
      end;
   end;
end;

function IntegraleAbs(TabImgInt:PTabImgInt;
                      TabImgDouble:PTabImgDouble;
                      TypeDonnees,NbPlans:Byte;
                      Sx,Sy:Integer):Double;
var
   i,j:Integer;
   Somme:Double;
begin
   Somme:=0;
   case TypeDonnees of
     2,7:begin
        for j:=1 to Sy do
           for i:=1 to Sx do
              Somme:=Somme+Abs(TabImgInt^[1]^[j]^[i]);
        end;
      5,6,8:begin
        for j:=1 to Sy do
           for i:=1 to Sx do
              Somme:=Somme+Abs(TabImgDouble^[1]^[j]^[i]);
        end;
      end;
Result:=Somme/Sx/Sy;
end;

// Recherche du centre par gravité
// Recherche du diamètre par calcul de surface
// Sert a la map
procedure MesureCentreEtDiametre(ImgIntIn:PTabImgInt;
                                 ImgDoubleIn:PTabImgDouble;
                                 TypeData:Byte;
                                 Sx,Sy:Integer;
                                 var X,Y,Diametre:Double);
var
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   Min,Mediane,Max,Moy,Ecart,Seuil:Double;
   i,j,k,l:Integer;
   Somme,SommeX,SommeY:Double;
   Nb:Cardinal;
begin
   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,1);
   MoveImg(ImgIntIn,ImgDoubleIn,ImgInt,ImgDouble,Sx,Sy,TypeData,1);
   try
   // Recherche du seuil
   Statistiques(ImgInt,ImgDouble,TypeData,1,Sx,Sy,1,Min,Mediane,Max,Moy,Ecart);
   Seuil:=(Mediane+Max)/2;

   // Binarisation
   Binarise(ImgInt,ImgDouble,TypeData,1,Sx,Sy,Seuil,0,1);

   // Recherche du centre de gravite sur le cercle exterieur
   SommeX:=0;
   SommeY:=0;
   Nb:=0;
   for j:=1 to Sy do
      begin
      case TypeData of
         2:begin
           i:=1;
           while (ImgInt^[1]^[j]^[i]=0) and (i<=Sx) do inc(i);
           if i<>Sx+1 then
              begin
              k:=Sx;
              while (ImgInt^[1]^[j]^[k]=0) and (k>=1) do dec(k);
              for l:=i to k do
                 begin
                 Inc(Nb);
                 SommeX:=SommeX+l;
                 SommeY:=SommeY+j;
                 end;
              end;
           end;
         5:begin
           i:=1;
           while (ImgDouble^[1]^[j]^[i]=0) and (i<=Sx) do inc(i);
           if i<>Sx+1 then
              begin
              k:=Sx;
              while (ImgDouble^[1]^[j]^[k]=0) and (k>=1) do dec(k);
              for l:=i to k do
                 begin
                 Inc(Nb);
                 SommeX:=SommeX+l;
                 SommeY:=SommeY+j;
                 end;
              end;
           end;
         end;
      end;
   X:=SommeX/Nb;
   Y:=SommeY/Nb;

   // Recherche du diamètre du cercle exterieur
   Somme:=0;
   for j:=1 to Sy do
      begin
      case TypeData of
         2:begin
           i:=1;
           while (ImgInt^[1]^[j]^[i]=0) and (i<=Sx) do inc(i);
           if i<>Sx+1 then
              begin
              k:=Sx;
              while (ImgInt^[1]^[j]^[k]=0) and (k>=1) do dec(k);
              Somme:=Somme+k-i+1;
              end;
           end;
         5:begin
           i:=1;
           while (ImgDouble^[1]^[j]^[i]=0) and (i<=Sx) do inc(i);
           if i<>Sx+1 then
              begin
              k:=Sx;
              while (ImgDouble^[1]^[j]^[k]=0) and (k>=1) do dec(k);
              Somme:=Somme+k-i+1;
              end;
           end;
         end;
      end;

   Diametre:=Sqrt(4*Somme/Pi);

   finally
   FreememImg(ImgInt,ImgDouble,Sx,Sy,TypeData,1);
   end;
end;

procedure QuickSortHFD(Dist,Valeur:PLigDouble;iLo,iHi:Integer);
var
Lo,Hi:Integer;
Mid,T:Double;
begin
Lo:=iLo;
Hi:=iHi;
Mid:=Dist[(Lo+Hi) div 2];
repeat
   while Dist[Lo]<Mid do Inc(Lo);
   while Dist[Hi]>Mid do Dec(Hi);
   if Lo<=Hi then
      begin
      T := Dist[Lo];
      Dist[Lo] := Dist[Hi];
      Dist[Hi] := T;
      T := Valeur[Lo];
      Valeur[Lo] := Valeur[Hi];
      Valeur[Hi] := T;
      Inc(Lo);
      Dec(Hi);
      end;
until Lo > Hi;
if Hi > iLo then QuickSortHFD(Dist,Valeur,iLo,Hi);
if Lo < iHi then QuickSortHFD(Dist,Valeur,Lo,iHi);
end;

procedure SelectionSortHFD(Dist,Valeur:PLigDouble;iLo,iHi:Integer);
var
  i,j:Integer;
  T:Double;
begin
   for i:=iLo to iHi-1 do
      for j:=iHi downto i+1 do
         if Dist^[i]>Dist^[j] then
            begin
            T:=Dist^[i];
            Dist^[i]:=Dist^[j];
            Dist^[j]:=T;
            T:=Valeur^[i];
            Valeur^[i]:=Valeur^[j];
            Valeur^[j]:=T;
            end;
end;

// Recherche du centre par gravité
// Recherche du diametre par integrale
// Sert a la map
procedure HFD(var ImgIntIn:PTabImgInt;
              var ImgDoubleIn:PTabImgDouble;
              TypeDataH:Byte;
              SxH,SyH:Integer;
              var X,Y,Diametre:Double);
var
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   Dist,Valeur:PLigDouble;
   Min,Mediane,Max,Moy,Ecart,Seuil:Double;
   i,j,k,l,Index:Integer;
   Somme,SommeX,SommeY,Somme2:Double;
   Nb:Cardinal;
   T:Double;
   Trouve:Boolean;
   pop_image:tpop_image;
   PSF:TPSF;
begin

   Getmem(Dist,8*SxH*SyH);
   Getmem(Valeur,8*SxH*SyH);
   GetmemImg(ImgInt,ImgDouble,SxH,SyH,TypeDataH,1);
   MoveImg(ImgIntIn,ImgDoubleIn,ImgInt,ImgDouble,SxH,SyH,TypeDataH,1);
   try
   // Recherche du seuil
   Statistiques(ImgInt,ImgDouble,TypeDataH,1,SxH,SyH,1,Min,Mediane,Max,Moy,Ecart);
//   Seuil:=(Mediane+Max)/10;
//   Seuil:=Mediane; // Non, marche pas
//   Seuil:=(Min+Max)/2; // Non, marche pas 10/08/05
   Seuil:=(Min+Max)/10;

//   ModeliseEtoile(ImgInt,ImgDouble,TypeDataH,SxH,TGauss,LowPrecision,LowSelect,0,PSF);

   // Binarisation
   Binarise(ImgInt,ImgDouble,TypeDataH,1,SxH,SyH,Seuil,0,1);

   // Recherche du centre de gravite sur le cercle exterieur
   SommeX:=0;
   SommeY:=0;
   Nb:=0;
   for j:=1 to SyH do
      begin
      case TypeDataH of
         2:begin
           i:=1;
           while (ImgInt^[1]^[j]^[i]=0) and (i<=SxH) do inc(i);
           if i<>SxH+1 then
              begin
              k:=SxH;
              while (ImgInt^[1]^[j]^[k]=0) and (k>=1) do dec(k);
              for l:=i to k do
                 begin
                 Inc(Nb);
                 SommeX:=SommeX+l;
                 SommeY:=SommeY+j;
                 end;
              end;
           end;
         5:begin
           i:=1;
           while (ImgDouble^[1]^[j]^[i]=0) and (i<=SxH) do inc(i);
           if i<>SxH+1 then
              begin
              k:=SxH;
              while (ImgDouble^[1]^[j]^[k]=0) and (k>=1) do dec(k);
              for l:=i to k do
                 begin
                 Inc(Nb);
                 SommeX:=SommeX+l;
                 SommeY:=SommeY+j;
                 end;
              end;
           end;
         end;
      end;
   X:=SommeX/Nb;
   Y:=SommeY/Nb;

   // Recherche du diamètre du cercle exterieur
   Somme:=0;
   for j:=1 to SyH do
      begin
      case TypeDataH of
         2:begin
           for i:=1 to SxH do
              begin
              Index:=(j-1)*SyH+i;
              Dist^[Index]:=Sqrt(Sqr(i-0.5-X)+Sqr(j-0.5-Y));
              Valeur^[Index]:=ImgIntIn^[1]^[j]^[i]-Mediane;
              Somme:=Somme+Valeur^[Index]
              end;
           end;
         5:begin
           for i:=1 to SxH do
              begin
              Index:=(j-1)*SyH+i;
              Dist^[Index]:=Sqrt(Sqr(i-0.5-X)+Sqr(j-0.5-Y));
              Valeur^[Index]:=ImgDoubleIn^[1]^[j]^[i]-Mediane;
              Somme:=Somme+Valeur^[Index]
              end;
           end;
         end;
      end;

   Trouve:=True;
   while Trouve do
      begin
      Trouve:=False;
      for i:=1 to SxH*SyH-1 do
         if Dist^[i]>Dist^[i+1] then
            begin
            Trouve:=True;
            T:=Dist^[i];
            Dist^[i]:=Dist^[i+1];
            Dist^[i+1]:=T;
            T:=Valeur^[i];
            Valeur^[i]:=Valeur^[i+1];
            Valeur^[i+1]:=T;
            end;
      end;

   for i:=2 to SxH*SyH do
      Valeur^[i]:=Valeur^[i]+Valeur^[i-1];

   Somme2:=Valeur^[SxH*SyH]/2;
   for i:=2 to SxH*SyH do
      if (Valeur^[i-1]<=Somme2) and (Valeur^[i]>=Somme2) then
         Diametre:=(Dist^[i-1]+(Somme2-Valeur^[i-1])*(Dist^[i]-Dist^[i-1])/(Valeur^[i]-Valeur^[i-1]))*2;

   if (Diametre>SxH) or (Diametre>SyH) or (Diametre<1) then Diametre:=-1;
   if (X>SxH) or (Y>SyH) or (X<1) or (Y<1) then Diametre:=-1;

   finally
   FreememImg(ImgInt,ImgDouble,SxH,SyH,TypeDataH,1);
   Freemem(Dist,8*SxH*SyH);
   Freemem(Valeur,8*SxH*SyH);
   end;
end;

// Recherche des seuils de l'image avec correction pour la saturation
procedure RechercheSeuilsVisu(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;
                              TypeData,TypeComplexe:Byte;Sx,Sy:Integer;NoPlan:Byte;
                              PourcentLow,PourcentHigh:Double;
                              var SeuilBas,SeuilHaut:Double);
//procedure RechercheSeulsVisu(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;
//                           TypeData,TypeComplexe:Byte;Sx,Sy:Integer;NoPlan:Byte;
//                           var Min,Mediane,Max,Moy,Ecart:Double);
var
i,j:Integer;
Valeur,ValHisto:Double;
N,Nb:Longint;
Nb2,Dx:double;
Hist:array[-32768..32767] of Longint;
Mediane,Ecart,Moy,Max,Min,Min1,Mediane1,Max1,Moy1,Ecart1:Double;
begin
Max1:=-32768;
Min1:=32767;
Moy1:=0;
Ecart1:=0;
Mediane1:=0;
N:=0;
Nb:=0;
for i:=-32768 to 32767 do Hist[i]:=0;
for j:=1 to Sy do
   case TypeData of
   2,7:for i:=1 to Sx do
        begin
        Valeur:=ImgInt^[NoPlan]^[j]^[i];
        inc(N);
        if Valeur>Max1 then Max1:=Valeur;
        if Valeur<Min1 then Min1:=Valeur;
        inc(Hist[Round(Valeur)]);
        inc(Nb);
        Dx:=Valeur-Moy1;
        Moy1:=Moy1+Dx/Nb;
        Ecart1:=Ecart1+Dx*(Valeur-Moy1);
        end;
   5,8:for i:=1 to Sx do
        begin
        Valeur:=ImgDouble^[NoPlan]^[j]^[i];
        inc(N);
        if Valeur>Max1 then Max1:=Valeur;
        if Valeur<Min1 then Min1:=Valeur;
        ValHisto:=Valeur;
        if ValHisto>=32767 then ValHisto:=32767;
        if ValHisto<=-32768 then ValHisto:=-32768;
        inc(Hist[Round(ValHisto)]);
        inc(Nb);
        Dx:=Valeur-Moy1;
        Moy1:=Moy1+Dx/Nb;
        Ecart1:=Ecart1+Dx*(Valeur-Moy1);
        end;
   6:begin
     case TypeComplexe of
        1:for i:=1 to Sx do
             begin
             Valeur:=Sqrt(Sqr(ImgDouble^[1]^[j]^[i])+Sqr(ImgDouble^[2]^[j]^[i]));
             inc(N);
             if Valeur>Max1 then Max1:=Valeur;
             if Valeur<Min1 then Min1:=Valeur;
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             Dx:=Valeur-Moy1;
             Moy1:=Moy1+Dx/Nb;
             Ecart1:=Ecart1+Dx*(Valeur-Moy1);
             end;
        2:for i:=1 to Sx do
             begin
             if ImgDouble^[1]^[j]^[i]<>0 then
                Valeur:=ArcTan(abs((ImgDouble^[2]^[j]^[i])/(ImgDouble^[1]^[j]^[i])))
             else
                Valeur:=Pi/2;
             inc(N);
             if Valeur>Max1 then Max1:=Valeur;
             if Valeur<Min1 then Min1:=Valeur;
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             Dx:=Valeur-Moy1;
             Moy1:=Moy1+Dx/Nb;
             Ecart1:=Ecart1+Dx*(Valeur-Moy1);
             end;
        3:for i:=1 to Sx do
             begin
             Valeur:=ImgDouble^[1]^[j]^[i];
             inc(N);
             if Valeur>Max1 then Max1:=Valeur;
             if Valeur<Min1 then Min1:=Valeur;
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             Dx:=Valeur-Moy1;
             Moy1:=Moy1+Dx/Nb;
             Ecart1:=Ecart1+Dx*(Valeur-Moy1);
             end;
        4:for i:=1 to Sx do
             begin
             Valeur:=ImgDouble^[2]^[j]^[i];
             inc(N);
             if Valeur>Max1 then Max1:=Valeur;
             if Valeur<Min1 then Min1:=Valeur;
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             Dx:=Valeur-Moy1;
             Moy1:=Moy1+Dx/Nb;
             Ecart1:=Ecart1+Dx*(Valeur-Moy1);
             end;
        end;
     end;
   end;
for i:=-32767 to 32767 do Hist[i]:=Hist[i]+Hist[i-1];
Nb2:=Nb/2;
for i:=-32768 to 32767 do
   if (Hist[i]<=Nb2) and (Hist[i+1]>=Nb2)
      then Mediane1:=i+1;
Ecart1:=Sqrt(Ecart1/N);

Max:=-32768;
Min:=32767;
Moy:=0;
Ecart:=0;
Mediane:=0;
Nb:=0;
for i:=-32768 to 32767 do Hist[i]:=0;
for j:=1 to Sy do
   case TypeData of
   2,7:for i:=1 to Sx do
        begin
        Valeur:=ImgInt^[NoPlan]^[j]^[i];
        if Valeur<Max1-Ecart1 then
           begin
           if Valeur>Max then Max:=Valeur;
           if Valeur<Min then Min:=Valeur;
           inc(Hist[Round(Valeur)]);
           inc(Nb);
           Dx:=Valeur-Moy;
           Moy:=Moy+Dx/Nb;
           Ecart:=Ecart+Dx*(Valeur-Moy);
           end;
        end;
   5,8:for i:=1 to Sx do
        begin
        Valeur:=ImgDouble^[NoPlan]^[j]^[i];
        if Valeur<Max1-Ecart1 then
           begin
           if Valeur>Max then Max:=Valeur;
           if Valeur<Min then Min:=Valeur;
           ValHisto:=Valeur;
           if ValHisto>=32767 then ValHisto:=32767;
           if ValHisto<=-32768 then ValHisto:=-32768;
           inc(Hist[Round(ValHisto)]);
           inc(Nb);
           Dx:=Valeur-Moy;
           Moy:=Moy+Dx/Nb;
           Ecart:=Ecart+Dx*(Valeur-Moy);
           end;
        end;
   6:begin
     case TypeComplexe of
        1:for i:=1 to Sx do
             begin
             Valeur:=Sqrt(Sqr(ImgDouble^[1]^[j]^[i])+Sqr(ImgDouble^[2]^[j]^[i]));
             if Valeur<Max1-Ecart1 then
                begin
                if Valeur>Max then Max:=Valeur;
                if Valeur<Min then Min:=Valeur;
                ValHisto:=Valeur;
                if ValHisto>=32767 then ValHisto:=32767;
                if ValHisto<=-32768 then ValHisto:=-32768;
                inc(Hist[Round(ValHisto)]);
                inc(Nb);
                Dx:=Valeur-Moy;
                Moy:=Moy+Dx/Nb;
                Ecart:=Ecart+Dx*(Valeur-Moy);
                end;
             end;
        2:for i:=1 to Sx do
             begin
             if ImgDouble^[1]^[j]^[i]<>0 then
                Valeur:=ArcTan(abs((ImgDouble^[2]^[j]^[i])/(ImgDouble^[1]^[j]^[i])))
             else
                Valeur:=Pi/2;
             if Valeur<Max1-Ecart1 then
                begin
                if Valeur>Max then Max:=Valeur;
                if Valeur<Min then Min:=Valeur;
                ValHisto:=Valeur;
                if ValHisto>=32767 then ValHisto:=32767;
                if ValHisto<=-32768 then ValHisto:=-32768;
                inc(Hist[Round(ValHisto)]);
                inc(Nb);
                Dx:=Valeur-Moy;
                Moy:=Moy+Dx/Nb;
                Ecart:=Ecart+Dx*(Valeur-Moy);
                end;
             end;
        3:for i:=1 to Sx do
             begin
             Valeur:=ImgDouble^[1]^[j]^[i];
             if Valeur<Max1-Ecart1 then
                begin
                if Valeur>Max then Max:=Valeur;
                if Valeur<Min then Min:=Valeur;
                ValHisto:=Valeur;
                if ValHisto>=32767 then ValHisto:=32767;
                if ValHisto<=-32768 then ValHisto:=-32768;
                inc(Hist[Round(ValHisto)]);
                inc(Nb);
                Dx:=Valeur-Moy;
                Moy:=Moy+Dx/Nb;
                Ecart:=Ecart+Dx*(Valeur-Moy);
                end;
             end;
        4:for i:=1 to Sx do
             begin
             Valeur:=ImgDouble^[2]^[j]^[i];
             if Valeur<Max1-Ecart1 then
                begin
                if Valeur>Max then Max:=Valeur;
                if Valeur<Min then Min:=Valeur;
                ValHisto:=Valeur;
                if ValHisto>=32767 then ValHisto:=32767;
                if ValHisto<=-32768 then ValHisto:=-32768;
                inc(Hist[Round(ValHisto)]);
                inc(Nb);
                Dx:=Valeur-Moy;
                Moy:=Moy+Dx/Nb;
                Ecart:=Ecart+Dx*(Valeur-Moy);
                end;
             end;
        end;
     end;
   end;
for i:=-32767 to 32767 do Hist[i]:=Hist[i]+Hist[i-1];

SeuilBas:=-32768;
Nb2:=PourcentLow*Nb/100;
for i:=-32768 to 32766 do
   if (Hist[i]<=Nb2) and (Hist[i+1]>=Nb2)
      then SeuilBas:=i+1;
//if SeuilBas=0 then SeuilBas:=-32768;

SeuilHaut:=32767;
Nb2:=PourcentHigh*Nb/100;
for i:=-32768 to 32766 do
   if (Hist[i]<=Nb2) and (Hist[i+1]>=Nb2)
      then SeuilHaut:=i+1;

end;

{ Calcul du flux dans une zone circulaire }
function GetApertureFlux(ImgInt:PTabImgInt;ImgDouble:PTabImgDouble;Typedata:Byte;XImg,YImg,R:Integer;
   var Nb:Integer):Double;
var
  M1,M2,M3,X1,Y1,X,Y,GDelta,PDelta:Integer;
  NbMaxPoints,i,j,k,l,m,InterI:Integer;

  Xl,Yl,Zl:PLigInt;

  Somme:Double;

  Fini:Boolean;

begin

if R=0 then
   begin
   case TypeData of
      2:Result:=ImgInt^[1]^[YImg]^[XImg];
      5:Result:=ImgDouble^[1]^[YImg]^[XImg];
   end;
   Exit;
   end;

NbMaxPoints:=8*R;

Somme:=0;
Nb:=0;

Getmem(Zl,4*NbMaxPoints);
Getmem(Xl,4*NbMaxPoints);
Getmem(Yl,4*NbMaxPoints);

try

M3:=1;
X1:=-R+XImg;
Y1:=YImg;

j:=0;
{ Priorité donnée à la rapidité => répétition de l'algo ! }
case TypeData of
   2:begin
     { On remplis les tableau des coord des pts du contour }
     Inc(j);
     Xl^[j]:=X1; Yl^[j]:=Y1;
     repeat
        X:=1; Y:=R+R-1;
        GDelta:=Y-1;
        M1:=M3; M2:=M1+1; M3:=M2+1;
        if M3=9 then M3:=1;
        while Y>=0 do
           begin
           PDelta:=GDelta+GDelta;
           if PDelta<0 then
              begin
              PDelta:=PDelta+X;
              if PDelta<0 then
                 begin
                 Y:=Y-2; GDelta:=GDelta+Y;
                 Case M3 of
                    1:Y1:=Y1+1;
                    2:begin Y1:=Y1+1; X1:=X1+1; end;
                    3:X1:=X1+1;
                    4:begin Y1:=Y1-1; X1:=X1+1; end;
                    5:Y1:=Y1-1;
                    6:begin Y1:=Y1-1; X1:=X1-1; end;
                    7:X1:=X1-1;
                    8:begin Y1:=Y1+1; X1:=X1-1; end;
                    end;
                 Inc(j);
                 Xl^[j]:=X1; Yl^[j]:=Y1;
                 end
              else
                 begin
                 X:=X+2; Y:=Y-2;
                 GDelta:=GDelta+Y-X;
                 Case M2 of
                    1:Y1:=Y1+1;
                    2:begin Y1:=Y1+1; X1:=X1+1; end;
                    3:X1:=X1+1;
                    4:begin Y1:=Y1-1; X1:=X1+1; end;
                    5:Y1:=Y1-1;
                    6:begin Y1:=Y1-1; X1:=X1-1; end;
                    7:X1:=X1-1;
                    8:begin Y1:=Y1+1; X1:=X1-1; end;
                    end;
                 Inc(j);
                 Xl^[j]:=X1; Yl^[j]:=Y1;
                 end;
              end
           else
              begin
              PDelta:=PDelta-Y;
              if PDelta>=0 then
                 begin
                 X:=X+2; GDelta:=GDelta-X;
                 Case M1 of
                    1:Y1:=Y1+1;
                    2:begin Y1:=Y1+1; X1:=X1+1; end;
                    3:X1:=X1+1;
                    4:begin Y1:=Y1-1; X1:=X1+1; end;
                    5:Y1:=Y1-1;
                    6:begin Y1:=Y1-1; X1:=X1-1; end;
                    7:X1:=X1-1;
                    8:begin Y1:=Y1+1; X1:=X1-1; end;
                    end;
                 Inc(j);
                 Xl^[j]:=X1; Yl^[j]:=Y1;
                 end
              else
                 begin
                 X:=X+2; Y:=Y-2;
                 GDelta:=GDelta+Y-X;
                 Case M2 of
                    1:Y1:=Y1+1;
                    2:begin Y1:=Y1+1; X1:=X1+1; end;
                    3:X1:=X1+1;
                    4:begin Y1:=Y1-1; X1:=X1+1; end;
                    5:Y1:=Y1-1;
                    6:begin Y1:=Y1-1; X1:=X1-1; end;
                    7:X1:=X1-1;
                    8:begin Y1:=Y1+1; X1:=X1-1; end;
                    end;
                 Inc(j);
                 Xl^[j]:=X1; Yl^[j]:=Y1;
                 end;
              end;
           end;
     until M3=1;

     { On analyse l'intérieur }
     { On balaye toutes les ordonees }
     for i:=YImg-R to YImg+R do
        begin
        { On transfere les abscisse dans Z }
        l:=0;
        for k:=1 to j do
           begin
           if Yl^[k]=i then
              begin
              inc(l);
              Zl^[l]:=Xl^[k];
              end;
           end;

        { On trie Z : Trie bulle a remplacer par Quick ? }
        if l>0 then
           begin
     //      QuickSort(Z,l);

           Fini:=False;
           While not(Fini) do
              begin
              Fini:=True;
              for k:=1 to l-1 do
                 if Zl^[k]>Zl^[k+1] then
                    begin
                    Fini:=False;
                    InterI:=Zl^[k];
                    Zl^[k]:=Zl^[k+1];
                    Zl^[k+1]:=InterI;
                    end;
              end;

           { On trouve le trou et on ajoute }
//           for k:=1 to l-1 do
//              if Zl^[k+1]<>Zl^[k]+1 then
                 for m:=Zl^[1] to Zl^[l] do
                    if (i>0) and (m>0) then
                        begin
                        Somme:=Somme+ImgInt^[1]^[i]^[m];
                        Inc(Nb);
                        end;
           end;
        end;

     end;
   5:begin
     { On remplis les tableau des coord des pts du contour }
     Inc(j);
     Xl^[j]:=X1; Yl^[j]:=Y1;
     repeat
        X:=1; Y:=R+R-1;
        GDelta:=Y-1;
        M1:=M3; M2:=M1+1; M3:=M2+1;
        if M3=9 then M3:=1;
        while Y>=0 do
           begin
           PDelta:=GDelta+GDelta;
           if PDelta<0 then
              begin
              PDelta:=PDelta+X;
              if PDelta<0 then
                 begin
                 Y:=Y-2; GDelta:=GDelta+Y;
                 Case M3 of
                    1:Y1:=Y1+1;
                    2:begin Y1:=Y1+1; X1:=X1+1; end;
                    3:X1:=X1+1;
                    4:begin Y1:=Y1-1; X1:=X1+1; end;
                    5:Y1:=Y1-1;
                    6:begin Y1:=Y1-1; X1:=X1-1; end;
                    7:X1:=X1-1;
                    8:begin Y1:=Y1+1; X1:=X1-1; end;
                    end;
                 Inc(j);
                 Xl^[j]:=X1; Yl^[j]:=Y1;
                 end
              else
                 begin
                 X:=X+2; Y:=Y-2;
                 GDelta:=GDelta+Y-X;
                 Case M2 of
                    1:Y1:=Y1+1;
                    2:begin Y1:=Y1+1; X1:=X1+1; end;
                    3:X1:=X1+1;
                    4:begin Y1:=Y1-1; X1:=X1+1; end;
                    5:Y1:=Y1-1;
                    6:begin Y1:=Y1-1; X1:=X1-1; end;
                    7:X1:=X1-1;
                    8:begin Y1:=Y1+1; X1:=X1-1; end;
                    end;
                 Inc(j);
                 Xl^[j]:=X1; Yl^[j]:=Y1;
                 end;
              end
           else
              begin
              PDelta:=PDelta-Y;
              if PDelta>=0 then
                 begin
                 X:=X+2; GDelta:=GDelta-X;
                 Case M1 of
                    1:Y1:=Y1+1;
                    2:begin Y1:=Y1+1; X1:=X1+1; end;
                    3:X1:=X1+1;
                    4:begin Y1:=Y1-1; X1:=X1+1; end;
                    5:Y1:=Y1-1;
                    6:begin Y1:=Y1-1; X1:=X1-1; end;
                    7:X1:=X1-1;
                    8:begin Y1:=Y1+1; X1:=X1-1; end;
                    end;
                 Inc(j);
                 Xl^[j]:=X1; Yl^[j]:=Y1;
                 end
              else
                 begin
                 X:=X+2; Y:=Y-2;
                 GDelta:=GDelta+Y-X;
                 Case M2 of
                    1:Y1:=Y1+1;
                    2:begin Y1:=Y1+1; X1:=X1+1; end;
                    3:X1:=X1+1;
                    4:begin Y1:=Y1-1; X1:=X1+1; end;
                    5:Y1:=Y1-1;
                    6:begin Y1:=Y1-1; X1:=X1-1; end;
                    7:X1:=X1-1;
                    8:begin Y1:=Y1+1; X1:=X1-1; end;
                    end;
                 Inc(j);
                 Xl^[j]:=X1; Yl^[j]:=Y1;
                 end;
              end;
           end;
     until M3=1;

     { On analyse l'intérieur }
     { On balaye toutes les ordonees }
     for i:=YImg-R to YImg+R do
        begin
        { On transfere les abscisse dans Z }
        l:=0;
        for k:=1 to j do
           begin
           if Yl^[k]=i then
              begin
              inc(l);
              Zl^[l]:=Xl^[k];
              end;
           end;

        { On trie Z : Trie bulle a remplacer par Quick ? }
        if l>0 then
           begin
     //      QuickSort(Z,l);

           Fini:=False;
           While not(Fini) do
              begin
              Fini:=True;
              for k:=1 to l-1 do
                 if Zl^[k]>Zl^[k+1] then
                    begin
                    Fini:=False;
                    InterI:=Zl^[k];
                    Zl^[k]:=Zl^[k+1];
                    Zl^[k+1]:=InterI;
                    end;
              end;

           { On trouve le trou et on ajoute }
//           for k:=1 to l-1 do
//              if Zl^[k+1]<>Zl^[k]+1 then
                 for m:=Zl^[1] to Zl^[l] do
                    if (i>0) and (m>0) then
                        begin
                        Somme:=Somme+ImgDouble^[1]^[i]^[m];
                        Inc(Nb);
                        end;
           end;
        end;

     end;
   end;

Result:=Somme;

finally
Freemem(Zl,4*NbMaxPoints);
Freemem(Xl,4*NbMaxPoints);
Freemem(Yl,4*NbMaxPoints);
end;
end;

// Simple mais efficace :-) bruno
procedure Isophotes(var ImgIntIn:PTabImgInt;
                    var ImgDoubleIn:PTabImgDouble;
                    TypeData,NbPlans:Byte;
                    Sx,Sy:Integer;bas,haut,num:integer);
var
   i,j,k,pixint:Integer;pixdbl:double;
begin
//Aplanit l'image
 if (typeData = 2) or (typeData = 7) then
  begin
   for k:=1 to NbPlans do
    for j:=1 to Sy do
     for i:=1 to Sx do
      begin
       pixint:=ImgIntIn^[k]^[j]^[i];
       if (pixint > bas) and (pixint < haut) then
        ImgIntIn^[k]^[j]^[i]:=pixint div num
       else
        ImgIntIn^[k]^[j]^[i]:=0;
       end;
  end
 else
  begin
   for k:=1 to NbPlans do
    for j:=1 to Sy do
     for i:=1 to Sx do
      begin
       pixdbl:=ImgDoubleIn^[k]^[j]^[i];
       if (pixdbl > bas) and (pixdbl < haut) then
        ImgDoubleIn^[k]^[j]^[i]:=int(pixdbl / num)
       else
        ImgDoubleIn^[k]^[j]^[i]:=0;
      end;
  end;
//cherche les contours
 if (typeData = 2) or (typeData = 7) then
 begin
  for k:=1 to NbPlans do
   for j:=1 to Sy - 1 do
    for i:=1 to Sx - 1 do
     begin
      if ImgIntIn^[k]^[j]^[i] <> ImgIntIn^[k]^[j]^[i+1] then ImgIntIn^[k]^[j]^[i]:=32766;
      if ImgIntIn^[k]^[j]^[i] <> ImgIntIn^[k]^[j+1]^[i] then ImgIntIn^[k]^[j]^[i]:=32766;
      if ImgIntIn^[k]^[j]^[i] = ImgIntIn^[k]^[j]^[i+1]  then ImgIntIn^[k]^[j]^[i]:=0;
     end;
 end
 else
 begin
  for k:=1 to NbPlans do
   for j:=1 to Sy - 1 do
    for i:=1 to Sx - 1 do
     begin
      if ImgDoubleIn^[k]^[j]^[i] <> ImgDoubleIn^[k]^[j]^[i+1] then ImgDoubleIn^[k]^[j]^[i]:=32766.00;
      if ImgDoubleIn^[k]^[j]^[i] <> ImgDoubleIn^[k]^[j+1]^[i] then ImgDoubleIn^[k]^[j]^[i]:=32766.00;
      if ImgDoubleIn^[k]^[j]^[i] = ImgDoubleIn^[k]^[j]^[i+1] then ImgDoubleIn^[k]^[j]^[i]:=0;
     end;
 end;
end;


end.




