unit u_filtrage;

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

uses sysutils, u_class;

type
  ErrorOndelette=class(exception);

procedure ExtractPlanOndelette(ImgIntIn:PTabImgInt;
                               ImgDoubleIn:PTabImgDouble;
                               var ImgOut:PTabImgDouble;
                               TypeData,NbPlans:Byte;
                               LargX,LargY,NoPlan:Integer);
procedure ExtractOndelettes(ImgIntIn:PTabImgInt;
                            ImgDoubleIn:PTabImgDouble;
                            var ImgOut:PTabTabImgDouble;
                            NbrePlans,TypeData:Byte;
                            LargX,LargY,NbPlanOndelette:Integer);
procedure Gaussienne(var ImgIntIn:PTabImgInt;
                     var ImgDoubleIn:PTabImgDouble;
                     TypeData,NbPlans:Byte;
                     Sx,Sy:Integer;Sigma:Double);
procedure MasqueFlou(var ImgIntIn:PTabImgInt;
                     var ImgDoubleIn:PTabImgDouble;
                     TypeData,NbPlans:Byte;
                     Sx,Sy:Integer;
                     Sigma,Mult:Double;
                     Ciel:Boolean);
procedure Matrice(var ImgIntIn:PTabImgInt;
                  var ImgDoubleIn:PTabImgDouble;
                  Filtre:PImgDouble;
                  Larg:Integer;
                  TypeData,NbPlans:Byte;
                  Sx,Sy:Integer);
procedure Median(var ImgIntIn:PTabImgInt;
                 var ImgDoubleIn:PTabImgDouble;
                 Larg:Integer;
                 TypeData,NbPlans:Byte;
                 Sx,Sy:Integer);
procedure Erosion(var ImgIntIn:PTabImgInt;
                  var ImgDoubleIn:PTabImgDouble;
                  Larg:Integer;
                  TypeData,NbPlans:Byte;
                  Sx,Sy:Integer);
procedure Dilatation(var ImgIntIn:PTabImgInt;
                     var ImgDoubleIn:PTabImgDouble;
                     Larg:Integer;
                     TypeData,NbPlans:Byte;
                     Sx,Sy:Integer);
procedure RankOrder(var ImgIntIn:PTabImgInt;
                    var ImgDoubleIn:PTabImgDouble;
                    Larg:Integer;
                    TypeData,NbPlans:Byte;
                    Sx,Sy:Integer);
procedure Extremes(var ImgIntIn:PTabImgInt;
                   var ImgDoubleIn:PTabImgDouble;
                   Larg:Integer;
                   TypeData,NbPlans:Byte;
                   Sx,Sy:Integer);
procedure PasseHautAdaptatif(var ImgIntIn:PTabImgInt;
                             var ImgDoubleIn:PTabImgDouble;
                             Larg:Integer;
                             TypeData,NbPlans:Byte;
                             Sx,Sy:Integer;
                             Contraste:Double);
procedure DeriveeXPlus(var ImgIntIn:PTabImgInt;
                       var ImgDoubleIn:PTabImgDouble;
                       TypeData,NbPlans:Byte;
                       Sx,Sy:Integer);
procedure DeriveeXMoins(var ImgIntIn:PTabImgInt;
                        var ImgDoubleIn:PTabImgDouble;
                        TypeData,NbPlans:Byte;
                        Sx,Sy:Integer);
procedure DeriveeYPlus(var ImgIntIn:PTabImgInt;
                       var ImgDoubleIn:PTabImgDouble;
                       TypeData,NbPlans:Byte;
                       Sx,Sy:Integer);
procedure DeriveeYMoins(var ImgIntIn:PTabImgInt;
                        var ImgDoubleIn:PTabImgDouble;
                        TypeData,NbPlans:Byte;
                        Sx,Sy:Integer);
procedure NormeGradient(var ImgIntIn:PTabImgInt;
                        var ImgDoubleIn:PTabImgDouble;
                        TypeData,NbPlans:Byte;
                        Sx,Sy:Integer);
procedure ExtractContourSimple(var ImgIntIn:PTabImgInt;
                               var ImgDoubleIn:PTabImgDouble;
                               TypeData,NbPlans:Byte;
                               Sx,Sy:Integer);
procedure FiltrageLignes(var ImgIntIn:PTabImgInt;
                         var ImgDoubleIn:PTabImgDouble;
                         TypeData,NbPlans:Byte;
                         Sx,Sy:Integer;
                         var Filtre:PLigDouble;
                         TailleFiltre:Integer);
procedure FiltrageColonnes(var ImgIntIn:PTabImgInt;
                           var ImgDoubleIn:PTabImgDouble;
                           TypeData,NbPlans:Byte;
                           Sx,Sy:Integer;
                           var Filtre:PLigDouble;
                           TailleFiltre:Integer);
procedure ExtractContourFiltreSimple(var ImgIntIn:PTabImgInt;
                                     var ImgDoubleIn:PTabImgDouble;
                                     TypeData,NbPlans:Byte;
                                     Sx,Sy:Integer);

implementation

uses u_arithmetique,
     u_lang,
     u_general,
     u_math,
     math;

// Extraction d'un seul plan d'ondelette spline de degre 1
// Réécriture de cette fonction a partir des source de l'obs mp
procedure ExtractPlanOndelette(ImgIntIn:PTabImgInt;
                               ImgDoubleIn:PTabImgDouble;
                               var ImgOut:PTabImgDouble;
                               TypeData,NbPlans:Byte;
                               LargX,LargY,NoPlan:Integer);
var
   MaxDim,i,j,k,l,m,j1,j2:Integer;
   ImgDouble1,ImgDouble2,ImgDouble3:PImgDouble;
   Valeur:Double;
   ImgIntNil:PTabImgInt;
begin
   if LargX>LargY then MaxDim:=LargX else MaxDim:=LargY;
   if NoPlan>ln(3*MaxDim/4)/ln(2) then
      raise ErrorOndelette.Create(lang('Nombre de plans trop grand'));

   GetmemImg(ImgIntNil,ImgOut,LargX,LargY,5,NbPlans);

   Getmem(ImgDouble1,LargY*4);
   for i:=1 to LargY do Getmem(ImgDouble1^[i],LargX*8);
   Getmem(ImgDouble2,LargY*4);
   for i:=1 to LargY do Getmem(ImgDouble2^[i],LargX*8);
   Getmem(ImgDouble3,LargY*4);
   for i:=1 to LargY do Getmem(ImgDouble3^[i],LargX*8);
   try

   for m:=1 to NbPlans do
      begin
      // Tranfert en double
      case TypeData of
         2,7:for i:=1 to Largx do
                for j:=1 to Largy do
                   ImgDouble1^[j]^[i]:=ImgIntIn^[m]^[j]^[i];
         5,6,8:for j:=1 to Largy do
                  Move(ImgDoubleIn^[m]^[j]^,ImgDouble1^[j]^,Largx*8);
         end;

      k:=1;
      for l:=1 to NoPlan do
         begin
         // Passage du filtre sur les lignes
         for i:=1 to LargY do
            for j:=1 to LargX do
               begin
               j1:=j-k;
               j2:=j+k;
               if j1<1 then j1:=2-j1;
               if j1>LargX then j1:=LargX+LargX-j1;
               if j2<1 then j2:=2-j2;
               if j2>LargX then j2:=LargX+LargX-j2;
               ImgDouble2^[i]^[j]:=0.5*ImgDouble1^[i]^[j]+0.25*(ImgDouble1^[i]^[j1]+
                  ImgDouble1^[i]^[j2]);
               end;
         // Passage du filtre sur les colonnes
         for i:=1 to LargX do
            for j:=1 to LargY do
               begin
               j1:=j-k;
               j2:=j+k;
               if j1<1 then j1:=2-j1;
               if j1>LargY then j1:=LargY+LargY-j1;
               if j2<1 then j2:=2-j2;
               if j2>LargY then j2:=LargY+LargY-j2;
               ImgDouble3^[j]^[i]:=0.5*ImgDouble2^[j]^[i]+0.25*(ImgDouble2^[j1]^[i]+
                  ImgDouble2^[j2]^[i]);
               end;
         k:=k*2;
         // Si c'est pas fini on met a jour ImgSingle1 avec ImgSingle3
         if l<>NoPlan then
            for j:=1 to LargY do
               Move(ImgDouble3^[j]^,ImgDouble1^[j]^,Largx*8);
         end;

      // On soustrait et On retourne en int
      for i:=1 to Largx do
         case TypeData of
            2,7:for j:=1 to Largy do
                   begin
                   Valeur:=ImgDouble1^[j]^[i]-ImgDouble3^[j]^[i];
                   if Valeur>32767 then Valeur:=32767;
                   if Valeur<-32768 then Valeur:=-32768;
                   ImgOut^[m]^[j]^[i]:=Valeur;
                   end;
            5,6,8:for j:=1 to Largy do
                   begin
                   Valeur:=ImgDouble1^[j]^[i]-ImgDouble3^[j]^[i];
                   ImgOut^[m]^[j]^[i]:=Valeur;
                   end;
            end;
      end;

   finally
   for i:=1 to LargY do Freemem(ImgDouble1^[i],LargX*8);
   Freemem(ImgDouble1,LargY*4);
   for i:=1 to LargY do Freemem(ImgDouble2^[i],LargX*8);
   Freemem(ImgDouble2,LargY*4);
   for i:=1 to LargY do Freemem(ImgDouble3^[i],LargX*8);
   Freemem(ImgDouble3,LargY*4);
   end
end;

procedure MasqueFlou(var ImgIntIn:PTabImgInt;
                     var ImgDoubleIn:PTabImgDouble;
                     TypeData,NbPlans:Byte;
                     Sx,Sy:Integer;
                     Sigma,Mult:Double;
                     Ciel:Boolean);
var
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   i,j,k:Integer;
begin
   case TypeData of
      2,7:begin
        Getmem(ImgInt,4*NbPlans);
        for k:=1 to NbPlans do
           begin
           Getmem(ImgInt^[k],Sy*4);
           for j:=1 to Sy do Getmem(ImgInt^[k]^[j],Sx*2);
           end;
        end;
      5,6,8:begin
        Getmem(ImgDouble,4*NbPlans);
        for k:=1 to NbPlans do
           begin
           Getmem(ImgDouble^[k],Sy*4);
           for j:=1 to Sy do Getmem(ImgDouble^[k]^[j],Sx*8);
           end;
        end;
      end;

   try

   // On met l'image dans Img
   for k:=1 to NbPlans do
      begin
      case TypeData of
         2,7:begin
           for j:=1 to Sy do
              Move(ImgIntIn^[k]^[j]^,ImgInt^[k]^[j]^,2*Sx);
           end;
         5,6,8:begin
           for j:=1 to Sy do
              Move(ImgDoubleIn^[k]^[j]^,ImgDouble^[k]^[j]^,8*Sx);
           end;
         end;
      end;

   Gaussienne(ImgInt,ImgDouble,TypeData,NbPlans,Sx,Sy,Sigma);
   Soust(ImgIntIn,ImgInt,ImgDoubleIn,ImgDouble,TypeData,NbPlans,Sx,Sy,Sx,Sy);
   if Ciel then ClipMin(ImgIntIn,ImgDoubleIn,TypeData,NbPlans,Sx,Sy,0,0);
   Gain(ImgIntIn,ImgDoubleIn,TypeData,NbPlans,Sx,Sy,Mult);
   Add(ImgIntIn,ImgInt,ImgDoubleIn,ImgDouble,TypeData,NbPlans,Sx,Sy,Sx,Sy);

   finally
   case TypeData of
      2,7:begin
        for k:=1 to NbPlans do
           begin
           for j:=1 to Sy do Freemem(ImgInt^[k]^[j],Sx*2);
           Freemem(ImgInt^[k],Sy*4);
           end;
        Freemem(ImgInt,4*NbPlans);
        end;
      5,6,8:begin
        for k:=1 to NbPlans do
           begin
           for j:=1 to Sy do Freemem(ImgDouble^[k]^[j],Sx*8);
           Freemem(ImgDouble^[k],Sy*4);
           end;
        Freemem(ImgDouble,4*NbPlans);
        end;
      end;
   end;
end;

// Filtrage avec attenuation de l'effet de bord
procedure Matrice(var ImgIntIn:PTabImgInt;
                  var ImgDoubleIn:PTabImgDouble;
                  Filtre:PImgDouble;
                  Larg:Integer;
                  TypeData,NbPlans:Byte;
                  Sx,Sy:Integer);
var
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   Somme,SommeFiltre:Double;
   i,j,k,l,m,n,o,Larg2:Integer;
begin
   SommeFiltre:=0;
   for j:=1 to Larg do
      for i:=1 to Larg do SommeFiltre:=SommeFiltre+Filtre^[j]^[i];
   if SommeFiltre=0 then SommeFiltre:=1;

   Larg2:=Larg div 2;

   case TypeData of
      2,7:begin
        Getmem(ImgInt,4*NbPlans);
        for k:=1 to NbPlans do
           begin
           Getmem(ImgInt^[k],Sy*4);
           for j:=1 to Sy do Getmem(ImgInt^[k]^[j],Sx*2);
           end;
        end;
      5,6,8:begin
        Getmem(ImgDouble,4*NbPlans);
        for k:=1 to NbPlans do
           begin
           Getmem(ImgDouble^[k],Sy*4);
           for j:=1 to Sy do Getmem(ImgDouble^[k]^[j],Sx*8);
           end;
        end;
      end;

   for k:=1 to NbPlans do
      for j:=1 to Sy do
         begin
         case TypeData of
            2,7:for i:=1 to Sx do
                   begin
                   Somme:=0;
                   for l:=-Larg2 to Larg2 do
                      begin
                      n:=j+l;
                      if n<1 then n:=2-n;
                      if n>Sy then n:=Sy+Sy-n;
                      for m:=-Larg2 to Larg2 do
                         begin
                         o:=i+m;
                         if o<1 then o:=2-o;
                         if o>Sx then o:=Sx+Sx-o;
                         Somme:=Somme+Filtre^[l+Larg2+1]^[m+Larg2+1]*ImgIntIn^[k]^[n]^[o];
                         end;
                      end;
                   Somme:=Somme/SommeFiltre;
                   if Somme>32767 then Somme:=32767;
                   if Somme<-32768 then Somme:=-32768;
                   ImgInt^[k]^[j]^[i]:=Round(Somme);
                   end;
            5,6,8:for i:=1 to Sx do
                   begin
                   Somme:=0;
                   for l:=-Larg2 to Larg2 do
                      begin
                      n:=j+l;
                      if n<1 then n:=2-n;
                      if n>Sy then n:=Sy+Sy-n;
                      for m:=-Larg2 to Larg2 do
                         begin
                         o:=i+m;
                         if o<1 then o:=2-o;
                         if o>Sx then o:=Sx+Sx-o;
                         Somme:=Somme+Filtre^[l+Larg2+1]^[m+Larg2+1]*ImgDoubleIn^[k]^[n]^[o];
                         end;
                      end;
                   ImgDouble^[k]^[j]^[i]:=Somme/SommeFiltre;
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
end;

// Extraction de tous les plans d'ondelette spline de degre 1
procedure ExtractOndelettes(ImgIntIn:PTabImgInt;
                            ImgDoubleIn:PTabImgDouble;
                            var ImgOut:PTabTabImgDouble;
                            NbrePlans,TypeData:Byte;
                            LargX,LargY,NbPlanOndelette:Integer);
var
   MaxDim,i,j,k,l,m,j1,j2:Integer;
   ImgDouble1,ImgDouble2,ImgDouble3:PImgDouble;
   Valeur:Single;
   ImgIntNil:PTabImgInt;
begin
   if LargX>LargY then MaxDim:=LargX else MaxDim:=LargY;
   if NbPlanOndelette>ln(3*MaxDim/4)/ln(2) then
      raise ErrorOndelette.Create(lang('Nombre de plans trop grand'));

   Getmem(ImgOut,4*NbPlanOndelette+1);
   for l:=1 to NbPlanOndelette+1 do
      begin
      Getmem(ImgOut^[l],4*NbrePlans);
      for k:=1 to NbrePlans do
         begin
         Getmem(ImgOut^[l]^[k],4*LargY);
         for j:=1 to LargY do Getmem(ImgOut^[l]^[k]^[j],LargX*8);
         end;
      end;

   Getmem(ImgDouble1,LargY*4);
   for i:=1 to LargY do Getmem(ImgDouble1^[i],LargX*8);
   Getmem(ImgDouble2,LargY*4);
   for i:=1 to LargY do Getmem(ImgDouble2^[i],LargX*8);
   Getmem(ImgDouble3,LargY*4);
   for i:=1 to LargY do Getmem(ImgDouble3^[i],LargX*8);
   try

   for k:=1 to NbrePlans do
      begin
      // Tranfert en double
      case TypeData of
         2,7:for i:=1 to Largx do
              for j:=1 to Largy do
                 ImgDouble1^[j]^[i]:=ImgIntIn^[k]^[j]^[i];
         5,8:for j:=1 to Largy do
              Move(ImgDoubleIn^[k]^[j]^,ImgDouble1^[j]^,Largx*8);
         end;

      m:=1;
      for l:=1 to NbPlanOndelette do
         begin
         // Passage du filtre sur les lignes
         for i:=1 to LargY do
            for j:=1 to LargX do
               begin
               j1:=j-m;
               j2:=j+m;
               if j1<1 then j1:=2-j1;
               if j1>LargX then j1:=LargX+LargX-j1;
               if j2<1 then j2:=2-j2;
               if j2>LargX then j2:=LargX+LargX-j2;
               ImgDouble2^[i]^[j]:=0.5*ImgDouble1^[i]^[j]+0.25*(ImgDouble1^[i]^[j1]+ImgDouble1^[i]^[j2]);
               end;
         // Passage du filtre sur les colonnes
         for i:=1 to LargX do
            for j:=1 to LargY do
               begin
               j1:=j-m;
               j2:=j+m;
               if j1<1 then j1:=2-j1;
               if j1>LargY then j1:=LargY+LargY-j1;
               if j2<1 then j2:=2-j2;
               if j2>LargY then j2:=LargY+LargY-j2;
               ImgDouble3^[j]^[i]:=0.5*ImgDouble2^[j]^[i]+0.25*(ImgDouble2^[j1]^[i]+ImgDouble2^[j2]^[i]);
               end;
         m:=m*2;

         // On soustrait et on stocke dans l'image de sortie
         for i:=1 to Largx do
            for j:=1 to Largy do
               ImgOut^[l]^[k]^[j]^[i]:=ImgDouble1^[j]^[i]-ImgDouble3^[j]^[i];

         // Si c'est pas fini on met a jour ImgDouble1 avec ImgDouble3
         if l<>NbPlanOndelette then
            for j:=1 to LargY do
               Move(ImgDouble3^[j]^,ImgDouble1^[j]^,Largx*8);

         end;

      // On stocke les résidus
      for i:=1 to Largx do
         for j:=1 to Largy do
            ImgOut^[NbPlanOndelette+1]^[k]^[j]^[i]:=ImgDouble3^[j]^[i];
      end;


   finally
   for i:=1 to LargY do Freemem(ImgDouble1^[i],LargX*8);
   Freemem(ImgDouble1,LargY*4);
   for i:=1 to LargY do Freemem(ImgDouble2^[i],LargX*8);
   Freemem(ImgDouble2,LargY*4);
   for i:=1 to LargY do Freemem(ImgDouble3^[i],LargX*8);
   Freemem(ImgDouble3,LargY*4);
   end
end;

// Median avec atténuation de l'effet de bord
procedure Median(var ImgIntIn:PTabImgInt;
                 var ImgDoubleIn:PTabImgDouble;
                 Larg:Integer;
                 TypeData,NbPlans:Byte;
                 Sx,Sy:Integer);
var
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   i,j,k,l,m,n,o,p:Integer;
   Larg2:Integer;
   MedianInt:PLigInt;
   MedianDouble:PLigDouble;
   ValInt:SmallInt;
   ValDouble:Double;
begin
   Larg2:=Larg div 2;

   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);
   case TypeData of
      2,7  :Getmem(MedianInt,Larg*Larg*2);
      5,6,8:Getmem(MedianDouble,Larg*Larg*8);
      end;

   try

   for k:=1 to NbPlans do
      for j:=1 to Sy do
         begin
         case TypeData of
            2,7:for i:=1 to Sx do
                   begin
                   p:=1;
                   for l:=-Larg2 to Larg2 do
                      begin
                      n:=j+l;
                      if n<1 then n:=2-n;
                      if n>Sy then n:=Sy+Sy-n;
                      for m:=-Larg2 to Larg2 do
                         begin
                         o:=i+m;
                         if o<1 then o:=2-o;
                         if o>Sx then o:=Sx+Sx-o;
                         MedianInt^[p]:=ImgIntIn^[k]^[n]^[o];
                         Inc(p);
                         end;
                      end;
                   Dec(p);                      
                   QuickSortInt(MedianInt,1,p);
                   ImgInt^[k]^[j]^[i]:=MedianInt^[p div 2];
                   end;
            5,6,8:for i:=1 to Sx do
                   begin
                   p:=1;
                   for l:=-Larg2 to Larg2 do
                      begin
                      n:=j+l;
                      if n<1 then n:=2-n;
                      if n>Sy then n:=Sy+Sy-n;
                      for m:=-Larg2 to Larg2 do
                         begin
                         o:=i+m;
                         if o<1 then o:=2-o;
                         if o>Sx then o:=Sx+Sx-o;
                         MedianDouble^[p]:=ImgDoubleIn^[k]^[n]^[o];
                         Inc(p);
                         end;
                      end;
                   Dec(p);
                   QuickSortDouble(MedianDouble,1,p);
                   ImgDouble^[k]^[j]^[i]:=MedianDouble^[p div 2];
                   end;
            end;
         end;

   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);         
   case TypeData of
      2,7  :ImgIntIn:=ImgInt;
      5,6,8:ImgDoubleIn:=ImgDouble;
      end;

   finally
   case TypeData of
      2,7  :Freemem(MedianInt,Larg*Larg*2);
      5,6,8:Freemem(MedianDouble,Larg*Larg*8);
      end;
   end;
end;

procedure Erosion(var ImgIntIn:PTabImgInt;
                  var ImgDoubleIn:PTabImgDouble;
                  Larg:Integer;
                  TypeData,NbPlans:Byte;
                  Sx,Sy:Integer);
var
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   i,j,k,l,m,n,o:Integer;
   Larg2:Integer;
   ValInt,MinInt:SmallInt;
   ValDouble,MinDouble:Double;
begin
   Larg2:=Larg div 2;

   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);

   try

   for k:=1 to NbPlans do
      for j:=1 to Sy do
         begin
         case TypeData of
            2,7:for i:=1 to Sx do
                   begin
                   MinInt:=32767;
                   for l:=-Larg2 to Larg2 do
                      begin
                      n:=j+l;
                      if n<1 then n:=2-n;
                      if n>Sy then n:=Sy+Sy-n;
                      for m:=-Larg2 to Larg2 do
                         begin
                         o:=i+m;
                         if o<1 then o:=2-o;
                         if o>Sx then o:=Sx+Sx-o;
                         if ImgIntIn^[k]^[n]^[o]<MinInt then MinInt:=ImgIntIn^[k]^[n]^[o];
                         end;
                      end;
                   ImgInt^[k]^[j]^[i]:=MinInt;
                   end;
            5,6,8:for i:=1 to Sx do
                   begin
                   MinDouble:=1.7e308;
                   for l:=-Larg2 to Larg2 do
                      begin
                      n:=j+l;
                      if n<1 then n:=2-n;
                      if n>Sy then n:=Sy+Sy-n;
                      for m:=-Larg2 to Larg2 do
                         begin
                         o:=i+m;
                         if o<1 then o:=2-o;
                         if o>Sx then o:=Sx+Sx-o;
                         if ImgDoubleIn^[k]^[n]^[o]<MinDouble then
                            MinDouble:=ImgDoubleIn^[k]^[n]^[o];
                         end;
                      end;
                   ImgDouble^[k]^[j]^[i]:=MinDouble;
                   end;
            end;
         end;

   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   case TypeData of
      2,7  :ImgIntIn:=ImgInt;
      5,6,8:ImgDoubleIn:=ImgDouble;
      end;

   finally
   end;
end;

procedure Dilatation(var ImgIntIn:PTabImgInt;
                     var ImgDoubleIn:PTabImgDouble;
                     Larg:Integer;
                     TypeData,NbPlans:Byte;
                     Sx,Sy:Integer);
var
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   i,j,k,l,m,n,o:Integer;
   Larg2:Integer;
   ValInt,MaxInt:SmallInt;
   ValDouble,MaxDouble:Double;
begin
   Larg2:=Larg div 2;

   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);

   try

   for k:=1 to NbPlans do
      for j:=1 to Sy do
         begin
         case TypeData of
            2,7:for i:=1 to Sx do
                   begin
                   MaxInt:=-32768;
                   for l:=-Larg2 to Larg2 do
                      begin
                      n:=j+l;
                      if n<1 then n:=2-n;
                      if n>Sy then n:=Sy+Sy-n;
                      for m:=-Larg2 to Larg2 do
                         begin
                         o:=i+m;
                         if o<1 then o:=2-o;
                         if o>Sx then o:=Sx+Sx-o;
                         if ImgIntIn^[k]^[n]^[o]>MaxInt then MaxInt:=ImgIntIn^[k]^[n]^[o];
                         end;
                      end;
                   ImgInt^[k]^[j]^[i]:=MaxInt;
                   end;
            5,6,8:for i:=1 to Sx do
                   begin
                   MaxDouble:=-1.7e308;
                   for l:=-Larg2 to Larg2 do
                      begin
                      n:=j+l;
                      if n<1 then n:=2-n;
                      if n>Sy then n:=Sy+Sy-n;
                      for m:=-Larg2 to Larg2 do
                         begin
                         o:=i+m;
                         if o<1 then o:=2-o;
                         if o>Sx then o:=Sx+Sx-o;
                         if ImgDoubleIn^[k]^[n]^[o]>MaxDouble then
                            MaxDouble:=ImgDoubleIn^[k]^[n]^[o];
                         end;
                      end;
                   ImgDouble^[k]^[j]^[i]:=MaxDouble;
                   end;
            end;
         end;

   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   case TypeData of
      2,7  :ImgIntIn:=ImgInt;
      5,6,8:ImgDoubleIn:=ImgDouble;
      end;

   finally
   end;
end;

procedure RankOrder(var ImgIntIn:PTabImgInt;
                    var ImgDoubleIn:PTabImgDouble;
                    Larg:Integer;
                    TypeData,NbPlans:Byte;
                    Sx,Sy:Integer);
var
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   i,j,k,l,m,n,o:Integer;
   Larg2:Integer;
   ValInt:SmallInt;
   ValDouble:Double;
   Total,Under,Equal:Integer;
   Rank:Double;
begin
   Larg2:=Larg div 2;
   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);

   for k:=1 to NbPlans do
      for j:=1 to Sy do
         begin
         case TypeData of
            2,7:for i:=1 to Sx do
                   begin
                   Total:=0;
                   Under:=0;
                   Equal:=0;
                   for l:=-Larg2 to Larg2 do
                      begin
                      n:=j+l;
                      if n<1 then n:=2-n;
                      if n>Sy then n:=Sy+Sy-n;
                      for m:=-Larg2 to Larg2 do
                         begin
                         o:=i+m;
                         if o<1 then o:=2-o;
                         if o>Sx then o:=Sx+Sx-o;
                         Inc(Total);
                         if ImgIntIn^[k]^[n]^[o]<ImgIntIn^[k]^[j]^[i] then Inc(Under);
                         if ImgIntIn^[k]^[n]^[o]=ImgIntIn^[k]^[j]^[i] then Inc(Equal);
                         end;
                      end;
                   Rank:=(Under+Equal/2)/Total;
                   ImgInt^[k]^[j]^[i]:=Round(Rank*32767);
                   end;
            5,6,8:for i:=1 to Sx do
                   begin
                   Total:=0;
                   Under:=0;
                   Equal:=0;
                   for l:=-Larg2 to Larg2 do
                      begin
                      n:=j+l;
                      if n<1 then n:=2-n;
                      if n>Sy then n:=Sy+Sy-n;
                      for m:=-Larg2 to Larg2 do
                         begin
                         o:=i+m;
                         if o<1 then o:=2-o;
                         if o>Sx then o:=Sx+Sx-o;
                         Inc(Total);
                         if ImgDoubleIn^[k]^[n]^[o]<ImgDoubleIn^[k]^[j]^[i] then Inc(Under);
                         if ImgDoubleIn^[k]^[n]^[o]=ImgDoubleIn^[k]^[j]^[i] then Inc(Equal);
                         end;
                      end;
                   Rank:=(Under+Equal/2)/Total;
                   ImgDouble^[k]^[j]^[i]:=Rank*32767;
                   end;
            end;
         end;

   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   case TypeData of
      2,7  :ImgIntIn:=ImgInt;
      5,6,8:ImgDoubleIn:=ImgDouble;
      end;
end;

procedure Extremes(var ImgIntIn:PTabImgInt;
                   var ImgDoubleIn:PTabImgDouble;
                   Larg:Integer;
                   TypeData,NbPlans:Byte;
                   Sx,Sy:Integer);
var
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   i,j,k,l,m,n,o:Integer;
   Larg2:Integer;
   ValInt:SmallInt;
   ValDouble:Double;
   MiniInt,MaxiInt:Integer;
   MiniDouble,MaxiDouble:Double;
begin
   Larg2:=Larg div 2;
   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);

   for k:=1 to NbPlans do
      for j:=1 to Sy do
         begin
         case TypeData of
            2,7:for i:=1 to Sx do
                   begin
                   MiniInt:=32677;
                   MaxiInt:=0;
                   for l:=-Larg2 to Larg2 do
                      begin
                      n:=j+l;
                      if n<1 then n:=2-n;
                      if n>Sy then n:=Sy+Sy-n;
                      for m:=-Larg2 to Larg2 do
                         begin
                         o:=i+m;
                         if o<1 then o:=2-o;
                         if o>Sx then o:=Sx+Sx-o;
                         if MiniInt>ImgIntIn^[k]^[n]^[o] then MiniInt:=ImgIntIn^[k]^[n]^[o];
                         if MaxiInt<ImgIntIn^[k]^[n]^[o] then MaxiInt:=ImgIntIn^[k]^[n]^[o];
                         end;
                      end;
                   if ImgIntIn^[k]^[j]^[i]-MiniInt<=MaxiInt-ImgIntIn^[k]^[j]^[i] then
                      ImgInt^[k]^[j]^[i]:=MiniInt
                   else
                      ImgInt^[k]^[j]^[i]:=MaxiInt;
                   end;
            5,6,8:for i:=1 to Sx do
                   begin
                   MiniDouble:=32677;
                   MaxiDouble:=0;
                   for l:=-Larg2 to Larg2 do
                      begin
                      n:=j+l;
                      if n<1 then n:=2-n;
                      if n>Sy then n:=Sy+Sy-n;
                      for m:=-Larg2 to Larg2 do
                         begin
                         o:=i+m;
                         if o<1 then o:=2-o;
                         if o>Sx then o:=Sx+Sx-o;
                         if MiniDouble>ImgDoubleIn^[k]^[n]^[o] then
                            MiniDouble:=ImgDoubleIn^[k]^[n]^[o];
                         if MaxiDouble<ImgDoubleIn^[k]^[n]^[o] then
                            MaxiDouble:=ImgDoubleIn^[k]^[n]^[o];
                         end;
                      end;
                   if ImgDoubleIn^[k]^[j]^[i]-MiniDouble<=MaxiDouble-ImgDoubleIn^[k]^[j]^[i] then
                      ImgDouble^[k]^[j]^[i]:=MiniDouble
                   else
                      ImgDouble^[k]^[j]^[i]:=MaxiDouble;
                   end;
            end;
         end;

   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   case TypeData of
      2,7  :ImgIntIn:=ImgInt;
      5,6,8:ImgDoubleIn:=ImgDouble;
      end;
end;

// C'est plutot un masque flou adaptatif !
procedure PasseHautAdaptatif(var ImgIntIn:PTabImgInt;
                             var ImgDoubleIn:PTabImgDouble;
                             Larg:Integer;
                             TypeData,NbPlans:Byte;
                             Sx,Sy:Integer;
                             Contraste:Double);
var
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   i,j,k,l,m,n,o:Integer;
   Larg2,NBPixels:Integer;
   ValInt:SmallInt;
   Valeur,ValDouble:Double;
   Moy,Dx,Ecart:Double;
begin
   Larg2:=Larg div 2;
   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);

   for k:=1 to NbPlans do
      for j:=1 to Sy do
         begin
         case TypeData of
            2,7:for i:=1 to Sx do
                   begin
                   NbPixels:=0;
                   Moy:=0;
                   Ecart:=0;
                   for l:=-Larg2 to Larg2 do
                      begin
                      n:=j+l;
                      if n<1 then n:=2-n;
                      if n>Sy then n:=Sy+Sy-n;
                      for m:=-Larg2 to Larg2 do
                         begin
                         o:=i+m;
                         if o<1 then o:=2-o;
                         if o>Sx then o:=Sx+Sx-o;

                         ValInt:=ImgIntIn^[k]^[n]^[o];
                         inc(NbPixels);
                         Dx:=ValInt-Moy;
                         Moy:=Moy+Dx/NbPixels;
                         Ecart:=Ecart+Dx*(ValInt-Moy);
                         end;
                      end;
                   Ecart:=Sqrt(Ecart/NbPixels);
                   if Ecart<>0 then
                      begin
                      Valeur:=ImgIntIn^[k]^[j]^[i]+(ImgIntIn^[k]^[j]^[i]-Moy)*Moy/Ecart*Contraste;
                      if Valeur>32767 then Valeur:=32767;
                      if Valeur<-32768 then Valeur:=-32768;
                      ImgInt^[k]^[j]^[i]:=Round(Valeur)
                      end
                   else
                      ImgInt^[k]^[j]^[i]:=ImgIntIn^[k]^[j]^[i];
                   end;
            5,6,8:for i:=1 to Sx do
                   begin
                   NbPixels:=0;
                   Moy:=0;
                   Ecart:=0;
                   for l:=-Larg2 to Larg2 do
                      begin
                      n:=j+l;
                      if n<1 then n:=2-n;
                      if n>Sy then n:=Sy+Sy-n;
                      for m:=-Larg2 to Larg2 do
                         begin
                         o:=i+m;
                         if o<1 then o:=2-o;
                         if o>Sx then o:=Sx+Sx-o;

                         ValDouble:=ImgDoubleIn^[k]^[n]^[o];
                         inc(NbPixels);
                         Dx:=ValDouble-Moy;
                         Moy:=Moy+Dx/NbPixels;
                         Ecart:=Ecart+Dx*(ValDouble-Moy);
                         end;
                      end;
                   Ecart:=Sqrt(Ecart/NbPixels);
                   if Ecart<>0 then
                      ImgDouble^[k]^[j]^[i]:=ImgDoubleIn^[k]^[j]^[i]+(ImgDoubleIn^[k]^[j]^[i]-Moy)*Moy/Ecart*Contraste
                   else
                      ImgDouble^[k]^[j]^[i]:=ImgDoubleIn^[k]^[j]^[i];
                   end;
            end;
         end;

   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   case TypeData of
      2,7  :ImgIntIn:=ImgInt;
      5,6,8:ImgDoubleIn:=ImgDouble;
      end;
end;

procedure DeriveeXPlus(var ImgIntIn:PTabImgInt;
                       var ImgDoubleIn:PTabImgDouble;
                       TypeData,NbPlans:Byte;
                       Sx,Sy:Integer);
var
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   i,j,k:Integer;
   Somme:Double;
begin
   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);
   for k:=1 to NbPlans do
      for j:=1 to Sy do
         begin
         case TypeData of
            2,7:for i:=2 to Sx do
                   begin
                   Somme:=ImgIntIn^[k]^[j]^[i]-ImgIntIn^[k]^[j]^[i-1];
                   if Somme>32767 then Somme:=32767;
                   if Somme<-32768 then Somme:=-32768;
                   ImgInt^[k]^[j]^[i]:=Round(Somme);
                   end;
            5,6,8:for i:=2 to Sx do
                   begin
                   Somme:=ImgDoubleIn^[k]^[j]^[i]-ImgDoubleIn^[k]^[j]^[i-1];
                   ImgDouble^[k]^[j]^[i]:=Somme;
                   end;
            end;
         end;

   // Mets le bord indeterminé à zero
   for k:=1 to NbPlans do
      case TypeData of
         2,7:for j:=1 to Sy do ImgInt^[k]^[j]^[1]:=0;
         5,6,8:for j:=1 to Sy do ImgDouble^[k]^[j]^[1]:=0;
         end;

   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   case TypeData of
      2,7  :ImgIntIn:=ImgInt;
      5,6,8:ImgDoubleIn:=ImgDouble;
      end;
end;

procedure DeriveeXMoins(var ImgIntIn:PTabImgInt;
                        var ImgDoubleIn:PTabImgDouble;
                        TypeData,NbPlans:Byte;
                        Sx,Sy:Integer);
var
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   i,j,k:Integer;
   Somme:Double;
begin
   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);
   for k:=1 to NbPlans do
      for j:=1 to Sy do
         begin
         case TypeData of
            2,7:for i:=1 to Sx-1 do
                   begin
                   Somme:=ImgIntIn^[k]^[j]^[i]-ImgIntIn^[k]^[j]^[i+1];
                   if Somme>32767 then Somme:=32767;
                   if Somme<-32768 then Somme:=-32768;
                   ImgInt^[k]^[j]^[i]:=Round(Somme);
                   end;
            5,6,8:for i:=1 to Sx-1 do
                   begin
                   Somme:=ImgDoubleIn^[k]^[j]^[i]-ImgDoubleIn^[k]^[j]^[i+1];
                   ImgDouble^[k]^[j]^[i]:=Somme;
                   end;
            end;
         end;

   // Mets le bord indeterminé à zero
   for k:=1 to NbPlans do
      case TypeData of
         2,7:for j:=1 to Sy do ImgInt^[k]^[j]^[Sx]:=0;
         5,6,8:for j:=1 to Sy do ImgDouble^[k]^[j]^[Sx]:=0;
         end;

   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   case TypeData of
      2,7  :ImgIntIn:=ImgInt;
      5,6,8:ImgDoubleIn:=ImgDouble;
      end;
end;

procedure DeriveeYPlus(var ImgIntIn:PTabImgInt;
                       var ImgDoubleIn:PTabImgDouble;
                       TypeData,NbPlans:Byte;
                       Sx,Sy:Integer);
var
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   i,j,k:Integer;
   Somme:Double;
begin
   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);
   for k:=1 to NbPlans do
      for i:=1 to Sx do
         begin
         case TypeData of
            2,7:for j:=2 to Sy do
                   begin
                   Somme:=ImgIntIn^[k]^[j]^[i]-ImgIntIn^[k]^[j-1]^[i];
                   if Somme>32767 then Somme:=32767;
                   if Somme<-32768 then Somme:=-32768;
                   ImgInt^[k]^[j]^[i]:=Round(Somme);
                   end;
            5,6,8:for j:=2 to Sy do
                   begin
                   Somme:=ImgDoubleIn^[k]^[j]^[i]-ImgDoubleIn^[k]^[j-1]^[i];
                   ImgDouble^[k]^[j]^[i]:=Somme;
                   end;
            end;
         end;

   // Mets le bord indeterminé à zero
   for k:=1 to NbPlans do
      case TypeData of
         2,7:for i:=1 to Sx do ImgInt^[k]^[1]^[i]:=0;
         5,6,8:for i:=1 to Sx do ImgDouble^[k]^[1]^[i]:=0;
         end;

   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   case TypeData of
      2,7  :ImgIntIn:=ImgInt;
      5,6,8:ImgDoubleIn:=ImgDouble;
      end;
end;

procedure DeriveeYMoins(var ImgIntIn:PTabImgInt;
                        var ImgDoubleIn:PTabImgDouble;
                        TypeData,NbPlans:Byte;
                        Sx,Sy:Integer);
var
   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   i,j,k:Integer;
   Somme:Double;
begin
   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);
   for k:=1 to NbPlans do
      for i:=1 to Sx do
         begin
         case TypeData of
            2,7:for j:=1 to Sy-1 do
                   begin
                   Somme:=ImgIntIn^[k]^[j]^[i]-ImgIntIn^[k]^[j+1]^[i];
                   if Somme>32767 then Somme:=32767;
                   if Somme<-32768 then Somme:=-32768;
                   ImgInt^[k]^[j]^[i]:=Round(Somme);
                   end;
            5,6,8:for j:=1 to Sy-1 do
                   begin
                   Somme:=ImgDoubleIn^[k]^[j]^[i]-ImgDoubleIn^[k]^[j+1]^[i];
                   ImgDouble^[k]^[j]^[i]:=Somme;
                   end;
            end;
         end;

   // Mets le bord indeterminé à zero
   for k:=1 to NbPlans do
      case TypeData of
         2,7:for i:=1 to Sx do ImgInt^[k]^[Sy]^[i]:=0;
         5,6,8:for i:=1 to Sx do ImgDouble^[k]^[Sy]^[i]:=0;
         end;

   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   case TypeData of
      2,7  :ImgIntIn:=ImgInt;
      5,6,8:ImgDoubleIn:=ImgDouble;
      end;
end;

procedure NormeGradient(var ImgIntIn:PTabImgInt;
                        var ImgDoubleIn:PTabImgDouble;
                        TypeData,NbPlans:Byte;
                        Sx,Sy:Integer);
var
   ImgInt,ImgContourXInt,ImgContourYInt:PTabImgInt;
   ImgDouble,ImgContourXDouble,ImgContourYDouble:PTabImgDouble;
   i,j,k:Integer;
   Somme:Double;
begin
   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);
   GetmemImg(ImgContourXInt,ImgContourXDouble,Sx,Sy,TypeData,NbPlans);
   MoveImg(ImgIntIn,ImgDoubleIn,ImgContourXInt,ImgContourXDouble,Sx,Sy,TypeData,NbPlans);
   if TypeData=2 then ConvertIntToReal(ImgContourXInt,ImgContourXDouble,NbPlans,Sx,Sy);
   GetmemImg(ImgContourYInt,ImgContourYDouble,Sx,Sy,TypeData,NbPlans);
   MoveImg(ImgIntIn,ImgDoubleIn,ImgContourYInt,ImgContourYDouble,Sx,Sy,TypeData,NbPlans);
   if TypeData=2 then ConvertIntToReal(ImgContourYInt,ImgContourYDouble,NbPlans,Sx,Sy);

   DeriveeXPlus(ImgContourXInt,ImgContourXDouble,5,NbPlans,Sx,Sy);
   DeriveeYPlus(ImgContourYInt,ImgContourYDouble,5,NbPlans,Sx,Sy);

   for k:=1 to NbPlans do
      for j:=1 to Sy do
         begin
         case TypeData of
            2,7:for i:=1 to Sx do
                   begin
                   Somme:=Sqrt(Sqr(ImgContourXDouble^[k]^[j]^[i])+Sqr(ImgContourYDouble^[k]^[j]^[i]));
                   if Somme>32767 then Somme:=32767;
                   if Somme<-32768 then Somme:=-32768;
                   ImgInt^[k]^[j]^[i]:=Round(Somme);
                   end;
            5,6,8:for i:=1 to Sx do
                   begin
                   Somme:=Sqrt(Sqr(ImgContourXDouble^[k]^[j]^[i])+Sqr(ImgContourYDouble^[k]^[j]^[i]));
                   ImgDouble^[k]^[j]^[i]:=Somme;
                   end;
            end;
         end;

   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   FreememImg(ImgContourXInt,ImgContourXDouble,Sx,Sy,5,NbPlans);
   FreememImg(ImgContourYInt,ImgContourYDouble,Sx,Sy,5,NbPlans);
   case TypeData of
      2,7  :ImgIntIn:=ImgInt;
      5,6,8:ImgDoubleIn:=ImgDouble;
      end;
end;


// Detection des maxima locaux
// On travaille que sur des doubles
procedure MaximaLocaux(var ImgContourXDouble:PTabImgDouble;
                       var ImgContourYDouble:PTabImgDouble;
                       var ImgNormeDouble:PTabImgDouble;
                       NbPlans:Byte;
                       Sx,Sy:Integer);
var
   ImgInt,ImgNormeInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
   i,j,k:Integer;
   Somme,dl,dh,Tg,a,b:Double;
   Dirl,Dirh:Integer;
begin
   a:=Tan(Pi/8);
   b:=Tan(3*Pi/8);

   GetmemImg(ImgInt,ImgDouble,Sx,Sy,5,NbPlans);

   for k:=1 to NbPlans do
      for j:=2 to Sy-1 do
         for i:=2 to Sx-1 do
            begin
            dl:=ImgContourXDouble^[k]^[j]^[i];
            dh:=ImgContourYDouble^[k]^[j]^[i];
            if dl<>0 then
               begin
               Tg:=dh/dl;
               if (Tg>=-a) and (Tg<=a) then
                  begin
                  Dirl:=1;
                  Dirh:=0;
                  end
               else if (Tg>a) and (Tg<=b) then
                  begin
                  Dirl:=1;
                  Dirh:=-1;
                  end
               else if (Tg<-a) and (Tg>=-b) then
                  begin
                  Dirl:=1;
                  Dirh:=1;
                  end
               else if (Tg>b) or (Tg<-b) then
                  begin
                  Dirl:=0;
                  Dirh:=1;
                  end;
               if (ImgNormeDouble^[k]^[j]^[i]>=ImgNormeDouble^[k]^[j+dirh]^[i+dirl]) and
                  (ImgNormeDouble^[k]^[j]^[i]>=ImgNormeDouble^[k]^[j-dirh]^[i-dirl]) then
                  ImgDouble^[k]^[j]^[i]:=ImgNormeDouble^[k]^[j]^[i]
               else
                  ImgDouble^[k]^[j]^[i]:=0;
               end
            else if (dl=0) and (dh<>0) then
               begin
               dirl:=0;
               dirh:=1;
               if (ImgNormeDouble^[k]^[j]^[i]>=ImgNormeDouble^[k]^[j+dirh]^[i+dirl]) and
                  (ImgNormeDouble^[k]^[j]^[i]>=ImgNormeDouble^[k]^[j-dirh]^[i-dirl]) then
                  ImgDouble^[k]^[j]^[i]:=ImgNormeDouble^[k]^[j]^[i]
               else
                  ImgDouble^[k]^[j]^[i]:=0;
               end
            else if (dl=0) and (dh=0) then ImgDouble^[k]^[j]^[i]:=0;
            end;

   FreememImg(ImgNormeInt,ImgNormeDouble,Sx,Sy,5,NbPlans);
   ImgNormeDouble:=ImgDouble;
end;

procedure ExtractContourSimple(var ImgIntIn:PTabImgInt;
                               var ImgDoubleIn:PTabImgDouble;
                               TypeData,NbPlans:Byte;
                               Sx,Sy:Integer);
var
   ImgInt,ImgContourXInt,ImgContourYInt,ImgNormeInt:PTabImgInt;
   ImgDouble,ImgContourXDouble,ImgContourYDouble,ImgNormeDouble:PTabImgDouble;
   i,j,k:Integer;
   Somme:Double;
   Filtre:PLigDouble;
   TypeDataTmp:Byte;
begin
   if Typedata=7 then TypedataTmp:=8 else TypedataTmp:=5;

   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeDataTmp,NbPlans);
   GetmemImg(ImgNormeInt,ImgNormeDouble,Sx,Sy,5,NbPlans);
   GetmemImg(ImgContourXInt,ImgContourXDouble,Sx,Sy,TypeData,NbPlans);
   MoveImg(ImgIntIn,ImgDoubleIn,ImgContourXInt,ImgContourXDouble,Sx,Sy,TypeData,NbPlans);
   if TypeData=2 then ConvertIntToReal(ImgContourXInt,ImgContourXDouble,NbPlans,Sx,Sy);
   GetmemImg(ImgContourYInt,ImgContourYDouble,Sx,Sy,TypeData,NbPlans);
   MoveImg(ImgIntIn,ImgDoubleIn,ImgContourYInt,ImgContourYDouble,Sx,Sy,TypeData,NbPlans);
   if TypeData=2 then ConvertIntToReal(ImgContourYInt,ImgContourYDouble,NbPlans,Sx,Sy);

   Getmem(Filtre,24);
   Filtre^[1]:=1;
   Filtre^[2]:=1;
   Filtre^[3]:=1;

   // Calcul des Gradients
   DeriveeXPlus(ImgContourXInt,ImgContourXDouble,TypeDataTmp,NbPlans,Sx,Sy);
   FiltrageColonnes(ImgContourXInt,ImgContourXDouble,TypeDataTmp,NbPlans,Sx,Sy,Filtre,3);
   DeriveeYPlus(ImgContourYInt,ImgContourYDouble,TypeDataTmp,NbPlans,Sx,Sy);
   FiltrageLignes(ImgContourYInt,ImgContourYDouble,TypeDataTmp,NbPlans,Sx,Sy,Filtre,3);

   // Calcul de la norme des Gradients
   for k:=1 to NbPlans do
      for j:=1 to Sy do
         begin
         case TypeData of
            2,7:for i:=1 to Sx do
                   begin
                   Somme:=Sqrt(Sqr(ImgContourXDouble^[k]^[j]^[i])+Sqr(ImgContourYDouble^[k]^[j]^[i]));
                   if Somme>32767 then Somme:=32767;
                   if Somme<-32768 then Somme:=-32768;
                   ImgNormeDouble^[k]^[j]^[i]:=Round(Somme);
                   end;
            5,6,8:for i:=1 to Sx do
                   begin
                   Somme:=Sqrt(Sqr(ImgContourXDouble^[k]^[j]^[i])+Sqr(ImgContourYDouble^[k]^[j]^[i]));
                   ImgNormeDouble^[k]^[j]^[i]:=Somme;
                   end;
            end;
         end;

   // Detection des maxima locaux
   MaximaLocaux(ImgContourXDouble,ImgContourYDouble,ImgNormeDouble,NbPlans,Sx,Sy);

   MoveImg(ImgNormeInt,ImgNormeDouble,ImgInt,ImgDouble,Sx,Sy,TypeDataTmp,NbPlans);
   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   FreememImg(ImgNormeInt,ImgNormeDouble,Sx,Sy,5,NbPlans);
   FreememImg(ImgContourXInt,ImgContourXDouble,Sx,Sy,5,NbPlans);
   FreememImg(ImgContourYInt,ImgContourYDouble,Sx,Sy,5,NbPlans);
   case TypeData of
      2,7  :begin
            ConvertRealToInt(ImgContourXDouble,ImgContourXInt,NbPlans,Sx,Sy);
            ImgIntIn:=ImgInt;
            end;
      5,6,8:ImgDoubleIn:=ImgDouble;
      end;

   Freemem(Filtre,24);
end;

procedure ExtractContourFiltreSimple(var ImgIntIn:PTabImgInt;
                                     var ImgDoubleIn:PTabImgDouble;
                                     TypeData,NbPlans:Byte;
                                     Sx,Sy:Integer);
var
   ImgInt,ImgContourXInt,ImgContourYInt,ImgNormeInt:PTabImgInt;
   ImgDouble,ImgContourXDouble,ImgContourYDouble,ImgNormeDouble:PTabImgDouble;
   i,j,k:Integer;
   Somme,dl,dh,Tg,a,b:Double;
   Dirl,Dirh:Integer;
   TypeDataTmp:Byte;
begin
   if Typedata=7 then TypedataTmp:=8 else TypedataTmp:=5;

   a:=Tan(Pi/8);
   b:=Tan(3*Pi/8);

   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);
   GetmemImg(ImgNormeInt,ImgNormeDouble,Sx,Sy,5,NbPlans);
   GetmemImg(ImgContourXInt,ImgContourXDouble,Sx,Sy,TypeData,NbPlans);
   MoveImg(ImgIntIn,ImgDoubleIn,ImgContourXInt,ImgContourXDouble,Sx,Sy,TypeData,NbPlans);
   if TypeData=2 then ConvertIntToReal(ImgContourXInt,ImgContourXDouble,NbPlans,Sx,Sy);
   GetmemImg(ImgContourYInt,ImgContourYDouble,Sx,Sy,TypeData,NbPlans);
   MoveImg(ImgIntIn,ImgDoubleIn,ImgContourYInt,ImgContourYDouble,Sx,Sy,TypeData,NbPlans);
   if TypeData=2 then ConvertIntToReal(ImgContourYInt,ImgContourYDouble,NbPlans,Sx,Sy);

   // Calcul des Gradients
   DeriveeXPlus(ImgContourXInt,ImgContourXDouble,TypeDataTmp,NbPlans,Sx,Sy);
   DeriveeYPlus(ImgContourYInt,ImgContourYDouble,TypeDataTmp,NbPlans,Sx,Sy);

   // Calcul de la norme des Gradients
   for k:=1 to NbPlans do
      for j:=1 to Sy do
         begin
         case TypeData of
            2,7:for i:=1 to Sx do
                   begin
                   Somme:=Sqrt(Sqr(ImgContourXDouble^[k]^[j]^[i])+Sqr(ImgContourYDouble^[k]^[j]^[i]));
                   if Somme>32767 then Somme:=32767;
                   if Somme<-32768 then Somme:=-32768;
                   ImgNormeDouble^[k]^[j]^[i]:=Round(Somme);
                   end;
            5,6,8:for i:=1 to Sx do
                   begin
                   Somme:=Sqrt(Sqr(ImgContourXDouble^[k]^[j]^[i])+Sqr(ImgContourYDouble^[k]^[j]^[i]));
                   ImgNormeDouble^[k]^[j]^[i]:=Somme;
                   end;
            end;
         end;

   // Detection des maxima locaux
   MaximaLocaux(ImgContourXDouble,ImgContourYDouble,ImgNormeDouble,NbPlans,Sx,Sy);

   MoveImg(ImgNormeInt,ImgNormeDouble,ImgInt,ImgDouble,Sx,Sy,TypeDataTmp,NbPlans);
   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   FreememImg(ImgNormeInt,ImgNormeDouble,Sx,Sy,5,NbPlans);
   FreememImg(ImgContourXInt,ImgContourXDouble,Sx,Sy,5,NbPlans);
   FreememImg(ImgContourYInt,ImgContourYDouble,Sx,Sy,5,NbPlans);
   case TypeData of
      2,7  :begin
            ConvertRealToInt(ImgContourXDouble,ImgContourXInt,NbPlans,Sx,Sy);
            ImgIntIn:=ImgInt;
            end;
      5,6,8:ImgDoubleIn:=ImgDouble;
      end;
end;

procedure FiltrageLignes(var ImgIntIn:PTabImgInt;
                         var ImgDoubleIn:PTabImgDouble;
                         TypeData,NbPlans:Byte;
                         Sx,Sy:Integer;
                         var Filtre:PLigDouble;
                         TailleFiltre:Integer);
var
   i,j,k,l,m:integer;
   TailleFiltre2:Integer;
   Somme,SommeFiltre:Double;

   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
begin
   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);

   SommeFiltre:=0;
   for i:=1 to TailleFiltre do SommeFiltre:=SommeFiltre+Filtre^[i];

   TailleFiltre2:=TailleFiltre div 2;

   // On passe le filtre sur les lignes
   for m:=1 to NbPlans do
      begin
      for j:=1 to Sy do
         begin
         case TypeData of
            2,7:begin
              for i:=1 to Sx do
                 begin
                 Somme:=0;
                 for k:=-TailleFiltre2 to TailleFiltre2 do
                    begin
                    l:=i-k;
                    if l<1 then l:=2-l;
                    if l>Sx then l:=Sx+Sx-l;
                    Somme:=Somme+Filtre^[k+TailleFiltre2+1]*ImgIntIn^[m]^[j]^[l];
                    end;
                 Somme:=Somme/SommeFiltre;
                 if Somme>32767 then Somme:=32767;
                 if Somme<-32768 then Somme:=-32768;
                 ImgInt^[m]^[j]^[i]:=Round(Somme);
                 end;
              end;
            5,6,8:begin
              for i:=1 to Sx do
                 begin
                 Somme:=0;
                 for k:=-TailleFiltre2 to TailleFiltre2 do
                    begin
                    l:=i-k;
                    if l<1 then l:=2-l;
                    if l>Sx then l:=Sx+Sx-l;
                    Somme:=Somme+Filtre^[k+TailleFiltre2+1]*ImgDoubleIn^[m]^[j]^[l];
                    end;
                 Somme:=Somme/SommeFiltre;
                 ImgDouble^[m]^[j]^[i]:=Somme;
                 end;
              end;
            end;
         end;
      end;

   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   case TypeData of
      2,7  :ImgIntIn:=ImgInt;
      5,6,8:ImgDoubleIn:=ImgDouble;
      end;
end;

procedure FiltrageColonnes(var ImgIntIn:PTabImgInt;
                           var ImgDoubleIn:PTabImgDouble;
                           TypeData,NbPlans:Byte;
                           Sx,Sy:Integer;
                           var Filtre:PLigDouble;
                           TailleFiltre:Integer);
var
   i,j,k,l,m:integer;
   TailleFiltre2:Integer;
   Somme,SommeFiltre:Double;

   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
begin
   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);

   SommeFiltre:=0;
   for i:=1 to TailleFiltre do SommeFiltre:=SommeFiltre+Filtre^[i];

   TailleFiltre2:=TailleFiltre div 2;
      
   // On passe le filtre sur les colonnes
   for m:=1 to NbPlans do
      begin
      for i:=1 to Sx do
         begin
         case TypeData of
            2,7:begin
              for j:=1 to Sy do
                 begin
                 Somme:=0;
                 for k:=-TailleFiltre2 to TailleFiltre2 do
                    begin
                    l:=j-k;
                    if l<1 then l:=2-l;
                    if l>Sy then l:=Sy+Sy-l;
                    Somme:=Somme+Filtre^[k+TailleFiltre2+1]*ImgIntIn^[m]^[l]^[i];
                    end;
                 Somme:=Somme/SommeFiltre;
                 if Somme>32767 then Somme:=32767;
                 if Somme<-32768 then Somme:=-32768;
                 ImgInt^[m]^[j]^[i]:=Round(Somme);
                 end;
              end;
            5,6,8:begin
              for j:=1 to Sy do
                 begin
                 Somme:=0;
                 for k:=-TailleFiltre2 to TailleFiltre2 do
                    begin
                    l:=j-k;
                    if l<1 then l:=2-l;
                    if l>Sy then l:=Sy+Sy-l;
                    Somme:=Somme+Filtre^[k+TailleFiltre2+1]*ImgDoubleIn^[m]^[l]^[i];
                    end;
                 Somme:=Somme/SommeFiltre;
                 ImgDouble^[m]^[j]^[i]:=Somme;
                 end;
              end;
            end;
         end;
      end;

   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   case TypeData of
      2,7  :ImgIntIn:=ImgInt;
      5,6,8:ImgDoubleIn:=ImgDouble;
      end;
end;


// Nouvelle version avec les filtres generiques lignes / colonnes
procedure Gaussienne(var ImgIntIn:PTabImgInt;
                     var ImgDoubleIn:PTabImgDouble;
                     TypeData,NbPlans:Byte;
                     Sx,Sy:Integer;Sigma:Double);
var
   i,j,k,l,m:integer;
   TailleFiltre,TailleFiltre2:Integer;
   Filtre:PLigDouble;
   Somme:Double;

   ImgInt:PTabImgInt;
   ImgDouble:PTabImgDouble;
begin
   TailleFiltre:=Round(8*Sigma);
   if not(Odd(TailleFiltre)) then Inc(TailleFiltre);
   Getmem(Filtre,8*TailleFiltre);
   GetmemImg(ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);
   MoveImg(ImgIntIn,ImgDoubleIn,ImgInt,ImgDouble,Sx,Sy,TypeData,NbPlans);

   try

   // Creation du filtre
   TailleFiltre2:=TailleFiltre div 2;
   for i:=1 to TailleFiltre do Filtre^[i]:=Exp(-Sqr((i-TailleFiltre2-1)/Sigma)/2);

   FiltrageLignes(ImgInt,ImgDouble,TypeData,NbPlans,Sx,Sy,Filtre,TailleFiltre);
   FiltrageColonnes(ImgInt,ImgDouble,TypeData,NbPlans,Sx,Sy,Filtre,TailleFiltre);

   FreememImg(ImgIntIn,ImgDoubleIn,Sx,Sy,TypeData,NbPlans);
   case TypeData of
      2,7  :ImgIntIn:=ImgInt;
      5,6,8:ImgDoubleIn:=ImgDouble;
      end;

   finally
   Freemem(Filtre,8*TailleFiltre);
   end;
end;

end.
