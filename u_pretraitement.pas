unit u_pretraitement;

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

                                   Pretraitement

-------------------------------------------------------------------------------}

interface

uses SysUtils, Classes, u_class, pu_rapport, Dialogs, TAGraph, Graphics;

type
  ErrorLot=class(exception);

procedure VerifieLot(Directory:string;
                     ListeImg:TStringList;
                     pop_Rapport:tpop_rapport;
                     VerifName:Boolean);
procedure AddLot(Directory:string;
                 ListeImg:TStringList;
                 var TabImgInt:PTabImgInt;
                 var TabImgDouble:PTabImgDouble;
                 var ImgInfos:TImgInfos;
                 pop_Rapport:tpop_rapport;
                 Moyenne:Boolean);
procedure MedianLot(Directory:string;
                    ListeImg:TStringList;
                    var TabImgInt:PTabImgInt;
                    var TabImgDouble:PTabImgDouble;
                    var ImgInfos:TImgInfos;
                    pop_Rapport:tpop_rapport);
procedure MoyenneIdentique(Directory:string;
                 ListeImg:TStringList;
                 pop_Rapport:tpop_rapport);
procedure ArithmetiqueLot(Directory:string;
                          ImgInt:PTabImgInt;
                          ImgDouble:PTabImgDouble;
                          ListeImgIn:TStringList;
                          ImgInfos:TImgInfos;                          
                          pop_Rapport:tpop_rapport;
                          TypeOperation:Byte);
procedure StatistiqueLot(Directory:string;
                 ListeImg:TStringList;
                 pop_Rapport:tpop_rapport);
procedure SigmaKappaLot(Directory:string;
                        ListeImg:TStringList;
                        var TabImgInt:PTabImgInt;
                        var TabImgDouble:PTabImgDouble;
                        var ImgInfos:TImgInfos;
                        NbSigma:Double;
                        pop_Rapport:tpop_rapport);
procedure RecalePlanetLot(Directory:string;
                          ListeImg:TStringList;
                          pop_Rapport:tpop_rapport;
                          IsASerie:Boolean);
function RecaleEtoileLot(Directory:string;
                         ListeImg:TStringList;
                         ErrorMax:Double;
                         pop_Rapport:tpop_rapport;
                         IsASerie:Boolean):Boolean;
procedure Pretraitements(Directory:string;
                         ListeOffsets:TStringList;
                         ListeNoirs:TStringList;
                         ListeNoirsFlats:TStringList;
                         ListeFlats:TStringList;
                         ListeImages:TStringList;
                         var ImagesFinales:TStringList;
                         ConfigPretraitements:TConfigPretraitements;
                         pop_Rapport:tpop_rapport);
procedure BestOfStellaire(Directory:string;
                          ListeImg:TStringList;
                          DSigma:Double;
                          SigmaMax:Double;
                          NbImagesMax:Integer;
                          ShowGraph:Boolean;
                          pop_Rapport:tpop_rapport);
procedure BestOfPlanetaire(Directory:string;
                           ListeImg:TStringList;
                           NbImagesMax:Integer;
                           pop_Rapport:tpop_rapport);
procedure CosmetiqueLot(Directory:string;
                        ListeImg:TStringList;
                        NomCosmetiques:string;
                        pop_Rapport:tpop_rapport);
procedure PretraiteLot(Directory:string;
                       ListeImg:TStringList;
                       ConfigPretraitements:TConfigPretraitements;
                       pop_Rapport:tpop_rapport);
procedure SoustOptimiseLot(Directory:string;
                           ImgNoir:PTabImgInt;
                           ImgNoirDouble:PTabImgDouble;
                           SxIn,SyIn:Integer;
                           TypeDataIn,NbPlansIn:Byte;
                           ListeImgIn:TStringList;
                           pop_Rapport:tpop_rapport);
function RegistrationEtoileLot(Directory:string;
                               ListeImg:TStringList;
                               ErrorMax:Double;
                               pop_Rapport:tpop_rapport;
                               IsASerie:Boolean):Boolean;

implementation

uses u_file_io,
     u_general,
     u_math,
     u_arithmetique,
     u_constants,
     u_modelisation,
     u_geometrie,
     u_analyse,
     pu_image,
     u_lang,
     pu_graph,
     Forms,
     u_filtrage,
     pu_main;

{ On verifie le lot }
procedure VerifieLot(Directory:string;
                     ListeImg:TStringList;
                     pop_Rapport:tpop_rapport;
                     VerifName:Boolean);
var
Ext:string;
OK:Boolean;
i:Integer;
MessageError,Name,NameRef:string;
ImgInfos,ImgInfosRef:TImgInfos;
DateTime:TDateTime;
TempsPose:Integer;
DimDif,TypeDif,PlanDif,NameDif:Boolean;
begin
NameRef:=GetNomGenerique(ListeImg.Strings[0]);
if ListeImg.Count<>0 then pop_Rapport.AddLine(lang('Vérification du lot : ')+GetNomGenerique(ListeImg.Strings[0]))
else pop_Rapport.AddLine(lang('Vérification du lot'));
try
if Directory='' then
   begin
   MessageError:=lang('Répertoire vide');
   raise ErrorLot.Create(MessageError);
   end;
if ListeImg.Count=0 then
   begin
   MessageError:=lang('Liste d''images vide');
   raise ErrorLot.Create(MessageError);
   end;
if ListeImg.Count=1 then
   begin
   MessageError:=lang('Une seule image dans la liste');
   raise ErrorLot.Create(MessageError);
   end;
Ext:=UpperCase(ExtractFileExt(ListeImg.Strings[0]));

try
ReadHeader(Directory+'\'+ListeImg.Strings[0],ImgInfosRef);
except
pop_Rapport.AddLine(lang('Erreur à la lecture de l''image ')+ListeImg.Strings[0]);
raise ErrorLot.Create(lang('Erreur à la lecture de l''image ')+ListeImg.Strings[0]);
end;

OK:=True;
for i:=1 to ListeImg.Count-1 do
   begin
   try
   ReadHeader(Directory+'\'+ListeImg.Strings[i],ImgInfos);
   Name:=GetNomGenerique(ListeImg.Strings[i]);
   DimDif:=False;
   TypeDif:=False;
   PlanDif:=False;
   NameDif:=False;
   if (ImgInfos.Sx<>ImgInfosRef.Sx) or (ImgInfos.Sy<>ImgInfosRef.Sy) then
      begin
      DimDif:=True;
      OK:=False;
      end;
   if (ImgInfos.TypeData<>ImgInfosRef.TypeData) then
      begin
      TypeDif:=True;
      OK:=False;
      end;
   if (ImgInfos.NbPlans<>ImgInfosRef.NbPlans) then
      begin
      PlanDif:=True;
      OK:=False;
      end;
   if VerifName then
      if (Name<>NameRef) then
         begin
         NameDif:=True;
         OK:=False;
         end;
   except
   pop_Rapport.AddLine(lang('Erreur à la lecture de l''image ')+ListeImg.Strings[i]);
   raise ErrorLot.Create(lang('Erreur à la lecture de l''image ')+ListeImg.Strings[i]);
   end
   end;
if not OK then
   begin
   if DimDif then pop_Rapport.AddLine(lang('Dimensions différentes'));
   if TypeDif then pop_Rapport.AddLine(lang('Types différents'));
   if PlanDif then pop_Rapport.AddLine(lang('Nombre de plan différents'));
   if NameDif then pop_Rapport.AddLine(lang('Noms génériques différents'));
   MessageError:=lang('Erreur : Le lot n''est pas homogène');
   pop_Rapport.AddLine('Erreur : Le lot n''est pas homogène');
   raise ErrorLot.Create(MessageError);
   end;

pop_Rapport.AddLine(lang('Lot vérifié'));

finally
pop_Rapport.AddLine(MessageError);
end;
end;

procedure AddLot(Directory:string;
                 ListeImg:TStringList;
                 var TabImgInt:PTabImgInt;
                 var TabImgDouble:PTabImgDouble;
                 var ImgInfos:TImgInfos;
                 pop_Rapport:tpop_rapport;
                 Moyenne:Boolean);
var
TabImgInt1,TabImgInt2:PTabImgInt;
TabImgDouble1,TabImgDouble2:PTabImgDouble;
TempsPose:Integer;
i,j,k,l:Integer;
ValDouble:Double;
ListeTempsDePose:PLigInteger;
ListeDate:PLigDate;
NbImage:Integer;
ImgInfosTmp:TImgInfos;
TempsPoseFinal:Integer;
DateTimeFinal:TDateTime;
begin
// Juste pour avoir Sx et Sy
ReadHeader(Directory+'\'+ListeImg.Strings[0],ImgInfos);

NbImage:=ListeImg.Count;

if Moyenne then pop_Rapport.AddLine(lang('Moyenne du lot'))
else pop_Rapport.AddLine(lang('Addition du lot'));

Getmem(ListeTempsDePose,4*NbImage);
Getmem(ListeDate,Sizeof(TDateTime)*NbImage);

try

pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[0]);
ReadImageGenerique(Directory+'\'+ListeImg.Strings[0],TabImgInt1,TabImgDouble1,ImgInfosTmp);
ListeTempsDePose^[1]:=ImgInfosTmp.TempsPose;
ListeDate^[1]:=ImgInfosTmp.DateTime;
ImgInfos:=ImgInfosTmp;

GetmemImg(TabImgInt,TabImgDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);

//procedure GetmemImg(var ImgInt:PTabImgInt;
//                    var ImgDouble:PTabImgDouble;
//                    Sx,Sy:Integer;
//                    TypeData,NbPlans:Byte);
GetmemImg(TabImgInt2,TabImgDouble2,ImgInfos.Sx,ImgInfos.Sy,5,ImgInfos.NbPlans);
for k:=1 to ImgInfos.NbPlans do
   for j:=1 to ImgInfos.Sy do
      case ImgInfos.TypeData of
         2,7:for i:=1 to ImgInfos.Sx do TabImgDouble2^[k]^[j]^[i]:=TabImgInt1^[k]^[j]^[i];
         5,8:for i:=1 to ImgInfos.Sx do TabImgDouble2^[k]^[j]^[i]:=TabImgDouble1^[k]^[j]^[i];
      end;

FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);

try

for k:=1 to NbImage-1 do
   begin
   pop_Rapport.AddLine(lang('Lecture et addition de l''image ')+ListeImg.Strings[k]);
   ReadImageGenerique(Directory+'\'+ListeImg.Strings[k],TabImgInt1,TabImgDouble1,ImgInfosTmp);
   ListeTempsDePose^[k+1]:=ImgInfosTmp.TempsPose;
   ListeDate^[k+1]:=ImgInfosTmp.DateTime;

   for l:=1 to ImgInfos.NbPlans do
      for j:=1 to ImgInfos.Sy do
         case ImgInfos.TypeData of
            2,7:for i:=1 to ImgInfos.Sx do
                   TabImgDouble2^[l]^[j]^[i]:=TabImgDouble2^[l]^[j]^[i]+TabImgInt1^[1]^[j]^[i];
            5,8:for i:=1 to ImgInfos.Sx do
                   TabImgDouble2^[l]^[j]^[i]:=TabImgDouble2^[l]^[j]^[i]+TabImgDouble1^[1]^[j]^[i];
            end;

   FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
   end;


if Moyenne then
   begin
   pop_Rapport.AddLine(lang('Normalisation'));
   for k:=1 to ImgInfos.NbPlans do
      for j:=1 to ImgInfos.Sy do
         for i:=1 to ImgInfos.Sx do
            TabImgDouble2^[k]^[j]^[i]:=TabImgDouble2^[k]^[j]^[i]/NbImage;

   CalculeBarycentreTempsDePose(ListeTempsDePose,ListeDate,NbImage,1,TempsPoseFinal,DateTimeFinal);
   end
else CalculeBarycentreTempsDePose(ListeTempsDePose,ListeDate,NbImage,0,TempsPoseFinal,DateTimeFinal);

ImgInfos.TempsPose:=TempsPoseFinal;
ImgInfos.DateTime:=DateTimeFinal;

for k:=1 to ImgInfos.NbPlans do
   for j:=1 to ImgInfos.Sy do
      begin
      case ImgInfos.TypeData of
         2,7:for i:=1 to ImgInfos.Sx do
                begin
                ValDouble:=TabImgDouble2^[k]^[j]^[i];
                if ValDouble>32767 then ValDouble:=32767;
                if ValDouble<-32768 then ValDouble:=-32768;
                TabImgInt^[k]^[j]^[i]:=Round(ValDouble);
                end;
         5,8:for i:=1 to ImgInfos.Sx do
                begin
                ValDouble:=TabImgDouble2^[k]^[j]^[i];
                TabImgDouble^[k]^[j]^[i]:=ValDouble;
                end;
         end;
      end;


if Moyenne then pop_Rapport.AddLine(lang('Moyenne effectuée'))
else pop_Rapport.AddLine(lang('Addition effectuée'));

finally
FreememImg(TabImgInt2,TabImgDouble2,ImgInfos.Sx,ImgInfos.Sy,5,ImgInfos.NbPlans);
end;

finally
Freemem(ListeTempsDePose,4*NbImage);
Freemem(ListeDate,Sizeof(TDateTime)*NbImage);
end;
end;

procedure MedianLot(Directory:string;
                    ListeImg:TStringList;
                    var TabImgInt:PTabImgInt;
                    var TabImgDouble:PTabImgDouble;
                    var ImgInfos:TImgInfos;
                    pop_Rapport:tpop_rapport);
var
TabImgInt1,TabImgInt2:PTabImgInt;
TabImgDouble1,TabImgDouble2:PTabImgDouble;
Numero:PLigInt;
Nombre:PLigDouble;
TempsPose:Integer;
i,j,k,l,m,n:Integer;
ListeTempsDePose:PLigInteger;
ListeDate:PLigDate;
NbImage:Integer;
IntTmp:Smallint;
DoubleTmp:Double;
TempsPoseFinal:Integer;
DateTimeFinal:TDateTime;
ImgInfosTmp:TImgInfos;
NbImage2:Integer;
begin
pop_Rapport.AddLine(lang('Médiane du lot'));

NbImage:=ListeImg.Count;
NbImage2:=NbImage div 2;
if NbImage2=0 then NbImage2:=1;

Getmem(Numero,2*NbImage);
Getmem(Nombre,8*NbImage);
for i:=1 to NbImage do Nombre^[i]:=0;

Getmem(ListeTempsDePose,4*NbImage);
Getmem(ListeDate,Sizeof(TDateTime)*NbImage);

try

// Juste pour avoir les donnees
ReadImageGenerique(Directory+'\'+ListeImg.Strings[0],TabImgInt1,TabImgDouble1,ImgInfosTmp);
ImgInfos:=ImgInfosTmp;
ListeTempsDePose^[1]:=ImgInfosTmp.TempsPose;
ListeDate^[1]:=ImgInfosTmp.DateTime;
FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);

GetmemImg(TabImgInt,TabImgDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
GetmemImg(TabImgInt2,TabImgDouble2,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,NbImage);

try

for n:=1 to ImgInfos.NbPlans do
   begin
   pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[0]);
   ReadImageGenerique(Directory+'\'+ListeImg.Strings[0],TabImgInt1,TabImgDouble1,ImgInfosTmp);
   case ImgInfos.TypeData of
      2,7:for j:=1 to ImgInfos.Sy do Move(TabImgInt1^[n]^[j]^,TabImgInt2^[1]^[j]^,ImgInfos.Sx*2);
      5,8:for j:=1 to ImgInfos.Sy do Move(TabImgDouble1^[n]^[j]^,TabImgDouble2^[1]^[j]^,ImgInfos.Sx*8);
      end;
   FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);

   // Lecture de toutes les images
   for k:=1 to NbImage-1 do
      begin
      pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[k]);
      ReadImageGenerique(Directory+'\'+ListeImg.Strings[k],TabImgInt1,TabImgDouble1,ImgInfosTmp);
      case ImgInfos.TypeData of
         2,7:for j:=1 to ImgInfos.Sy do Move(TabImgInt1^[n]^[j]^,TabImgInt2^[k+1]^[j]^,ImgInfos.Sx*2);
         5,8:for j:=1 to ImgInfos.Sy do Move(TabImgDouble1^[n]^[j]^,TabImgDouble2^[k+1]^[j]^,ImgInfos.Sx*8);
         end;
      ListeTempsDePose^[k+1]:=ImgInfosTmp.TempsPose;
      ListeDate^[k+1]:=ImgInfosTmp.DateTime;
      FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
      end;

   // Calcul de la médiane par tri à bulle
   pop_Rapport.AddLine(lang('Calcul de l''image médiane'));
   for j:=1 to ImgInfos.Sy do
      begin
      case ImgInfos.TypeData of
         2,7:for i:=1 to ImgInfos.Sx do
                begin
                for l:=1 to NbImage do Numero^[l]:=l;
                for l:=1 to NbImage-1 do
                   for m:=NbImage downto l+1 do
                      if TabImgInt2^[l]^[j]^[i]>TabImgInt2^[m]^[j]^[i] then
                         begin
                         IntTmp:=TabImgInt2^[l]^[j]^[i];
                         TabImgInt2^[l]^[j]^[i]:=TabImgInt2^[m]^[j]^[i];
                         TabImgInt2^[m]^[j]^[i]:=IntTmp;
                         IntTmp:=Numero^[l];
                         Numero^[l]:=Numero^[m];
                         Numero^[m]:=IntTmp;
                         end;
                Nombre^[Numero^[NbImage2]]:=Nombre^[Numero^[NbImage2]]+1;
                end;
         5,8:for i:=1 to ImgInfos.Sx do
                begin
                for l:=1 to NbImage do Numero^[l]:=l;
                for l:=1 to NbImage-1 do
                   for m:=NbImage downto l+1 do
                      if TabImgDouble2^[l]^[j]^[i]>TabImgDouble2^[m]^[j]^[i] then
                         begin
                         DoubleTmp:=TabImgDouble2^[l]^[j]^[i];
                         TabImgDouble2^[l]^[j]^[i]:=TabImgDouble2^[m]^[j]^[i];
                         TabImgDouble2^[m]^[j]^[i]:=DoubleTmp;
                         IntTmp:=Numero^[l];
                         Numero^[l]:=Numero^[m];
                         Numero^[m]:=IntTmp;
                         end;
                Nombre^[Numero^[NbImage2]]:=Nombre^[Numero^[NbImage2]]+1;
                end;
         end;
      end;

   // On place le résultat dans l'image de sortie
   for j:=1 to ImgInfos.Sy do
      case ImgInfos.TypeData of
         2,6:for i:=1 to ImgInfos.Sx do
                TabImgInt^[n]^[j]^[i]:=TabImgInt2^[NbImage2]^[j]^[i];
         5,8:for i:=1 to ImgInfos.Sx do
                TabImgDouble^[n]^[j]^[i]:=TabImgDouble2^[NbImage2]^[j]^[i];
         end;

   CalculeBarycentreTempsDePose(ListeTempsDePose,ListeDate,NbImage,1,TempsPoseFinal,DateTimeFinal);
   ImgInfosTmp.TempsPose:=TempsPoseFinal;
   ImgInfosTmp.DateTime:=DateTimeFinal;

   pop_Rapport.AddLine(lang('Médiane éffectuée'));
   pop_Rapport.AddLine(lang('Pourcentages utilisés :'));
   for i:=1 to NbImage do pop_Rapport.AddLine('Image '+ListeImg.Strings[i-1]+' ' //nolang
      +FloatToStrF(Nombre^[i]/ImgInfos.Sx/ImgInfos.Sy*100,ffFixed,4,2)+' %'); //nolang

   end;

finally
FreememImg(TabImgInt2,TabImgDouble2,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,NbImage);
end;

finally
Freemem(ListeTempsDePose,4*NbImage);
Freemem(ListeDate,Sizeof(TDateTime)*NbImage);

Freemem(Numero,2*NbImage);
Freemem(Nombre,8*NbImage);
end;
end;

{procedure MedianLot(Directory:string;
                    ListeImg:TStringList;
                    var TabImgInt:PTabImgInt;
                    var TabImgDouble:PTabImgDouble;
                    var Sx,Sy:Integer;
                    var TypeData:Byte;
                    var NbPlans:Byte;
                    var ImgInfos:TImgInfos;
                    pop_Rapport:tpop_rapport);
var
TabImgInt1,TabImgInt2:PTabImgInt;
TabImgDouble1:PTabImgDouble;
Numero:PLigInt;
Nombre:PLigDouble;
TempsPose:Integer;
i,j,k,l,m:Integer;
ListeTempsDePose:PLigInteger;
ListeDate:PLigDate;
NbImage:Integer;
IntTmp:Smallint;
TempsPoseFinal:Integer;
DateTimeFinal:TDateTime;
ImgInfosTmp:TImgInfos;
NbImage2:Integer;
begin
pop_Rapport.AddLine(lang('Médiane du lot'));

NbImage:=ListeImg.Count;
NbImage2:=NbImage div 2;
if NbImage2=0 then NbImage2:=1;

Getmem(Numero,2*NbImage);
Getmem(Nombre,8*NbImage);
for i:=1 to NbImage do Nombre^[i]:=0;

Getmem(ListeTempsDePose,4*NbImage);
Getmem(ListeDate,Sizeof(TDateTime)*NbImage);

pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[0]);
ReadImageGenerique(Directory+'\'+ListeImg.Strings[0],TabImgInt1,TabImgDouble1,ImgInfosTmp);

ImgInfos:=ImgInfosTmp;
ListeTempsDePose^[1]:=ImgInfosTmp.TempsPose;
ListeDate^[1]:=ImgInfosTmp.DateTime;

GetmemImg(TabImgInt,TabImgDouble,Sx,Sy,TypeData,NbPlans);
GetmemImg(TabImgInt2,TabImgDouble2,Sx,Sy,TypeData,NbImage);

for j:=1 to Sy do Move(TabImgInt1^[1]^[j]^,TabImgInt2^[1]^[j]^,Sx*2);

for j:=1 to Sy do Freemem(TabImgInt1^[1]^[j],2*Sx);
Freemem(TabImgInt1^[1],4*Sy);
Freemem(TabImgInt1,4);

try

// Lecture de toutes les images
for k:=1 to NbImage-1 do
   begin
   pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[k]);
   ReadImageGenerique(Directory+'\'+ListeImg.Strings[k],TabImgInt1,TabImgDouble1,ImgInfosTmp);
   for j:=1 to Sy do Move(TabImgInt1^[1]^[j]^,TabImgInt2^[k+1]^[j]^,Sx*2);
   ListeTempsDePose^[k+1]:=ImgInfosTmp.TempsPose;
   ListeDate^[k+1]:=ImgInfosTmp.DateTime;

   for j:=1 to Sy do Freemem(TabImgInt1^[1]^[j],2*Sx);
   Freemem(TabImgInt1^[1],4*Sy);
   Freemem(TabImgInt1,4);
   end;

// Calcul de la médiane par tri à bulle
pop_Rapport.AddLine(lang('Calcul de l''image médiane'));
for j:=1 to Sy do
   for i:=1 to Sx do
      begin
      for l:=1 to NbImage do Numero^[l]:=l;
      for l:=1 to NbImage-1 do
         for m:=NbImage downto l+1 do
            if TabImgInt2^[l]^[j]^[i]>TabImgInt2^[m]^[j]^[i] then
               begin
               IntTmp:=TabImgInt2^[l]^[j]^[i];
               TabImgInt2^[l]^[j]^[i]:=TabImgInt2^[m]^[j]^[i];
               TabImgInt2^[m]^[j]^[i]:=IntTmp;
               IntTmp:=Numero^[l];
               Numero^[l]:=Numero^[m];
               Numero^[m]:=IntTmp;
               end;
      Nombre^[Numero^[NbImage2]]:=Nombre^[Numero^[NbImage2]]+1;
      end;

// On place le résultat dans l'image de sortie
for j:=1 to Sy do
   for i:=1 to Sx do
      TabImgInt^[1]^[j]^[i]:=TabImgInt2^[NbImage2]^[j]^[i];

CalculeBarycentreTempsDePose(ListeTempsDePose,ListeDate,NbImage,1,TempsPoseFinal,DateTimeFinal);
ImgInfosTmp.TempsPose:=TempsPoseFinal;
ImgInfosTmp.DateTime:=DateTimeFinal;

pop_Rapport.AddLine(lang('Médiane éffectuée'));
pop_Rapport.AddLine(lang('Pourcentages utilisés :'));
for i:=1 to NbImage do pop_Rapport.AddLine('Image '+ListeImg.Strings[i-1]+' ' //nolang
   +FloatToStrF(Nombre^[i]/Sx/Sy*100,ffFixed,4,2)+' %'); //nolang

finally
for k:=1 to NbImage do
   begin
   for j:=1 to Sy do Freemem(TabImgInt2^[k]^[j],4*Sx);
   Freemem(TabImgInt2^[k],4*Sy);
   end;
Freemem(TabImgInt2,4*NbImage);

Freemem(ListeTempsDePose,4*NbImage);
Freemem(ListeDate,Sizeof(TDateTime)*NbImage);

Freemem(Numero,2*NbImage);
Freemem(Nombre,8*NbImage);
end;
end;}

procedure MoyenneIdentique(Directory:string;
                 ListeImg:TStringList;
                 pop_Rapport:tpop_rapport);
var
TabImgInt1:PTabImgInt;
TabImgDouble1:PTabImgDouble;
i,j,k,l:Integer;
NbImage:Integer;
StatMin,Mediane,StatMax,Ecart:Double;
Moy:PLigDouble;
MoyMax:Double;
ImageMoyMax:Integer;
Valeur:Double;
ImgInfos:TImgInfos;
begin
pop_Rapport.AddLine(lang('Moyenne identique du lot'));

NbImage:=ListeImg.Count;

Getmem(Moy,8*NbImage);

try

// Lecture et statististique de toutes les images
for k:=0 to NbImage-1 do
   begin
   pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[k]);
   ReadImageGenerique(Directory+'\'+ListeImg.Strings[k],TabImgInt1,TabImgDouble1,ImgInfos);

   // Toujours sur le plans 1
   Statistiques(TabImgInt1,TabImgDouble1,ImgInfos.TypeData,1,ImgInfos.Sx,ImgInfos.Sy,1,StatMin,Mediane,StatMax,Moy^[k+1],Ecart);
   if Moy^[k+1]=0 then
      begin
      pop_Rapport.AddLine(lang('Erreur : Moyenne = 0 pour l''image ')+ListeImg.Strings[k]);
      Exit;
      end;
   pop_Rapport.AddLine('Image '+ListeImg.Strings[k] //nolang
      +lang(' moyenne : ')+FloatToStrF(Moy^[k+1],ffFixed,5,2));

   FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
   end;

// Recherche de la plus grande moyenne
MoyMax:=-999999;
for i:=1 to NbImage do
   if Moy^[i]>MoyMax then
      begin
      MoyMax:=Moy^[i];
      ImageMoyMax:=i;
      end;

pop_Rapport.AddLine(lang('Plus grande moyenne image ')+ListeImg.Strings[ImageMoyMax-1]+
   lang(' moyenne : ')+FloatToStrF(MoyMax,ffFixed,5,2));
pop_Rapport.AddLine(lang('Mise à la moyenne : ')+FloatToStrF(MoyMax,ffFixed,5,2)+
   lang(' et enregistrement des images'));
// Mise à niveau et enregistrement de toutes les images
for k:=1 to NbImage do
   begin
   pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[k-1]);
   ReadImageGenerique(Directory+'\'+ListeImg.Strings[k-1],TabImgInt1,TabImgDouble1,ImgInfos);
   for l:=1 to ImgInfos.NbPlans do
      for j:=1 to ImgInfos.Sy do
         case ImgInfos.TypeData of
            2,7:for i:=1 to ImgInfos.Sx do
                   begin
                   Valeur:=(TabImgInt1^[l]^[j]^[i]*MoyMax)/Moy^[k];
                   if Valeur>32767 then Valeur:=32767;
                   if Valeur<-32768 then Valeur:=-32768;
                   TabImgInt1^[l]^[j]^[i]:=Round(Valeur);
                   end;
            5,8:for i:=1 to ImgInfos.Sx do
                   begin
                   Valeur:=TabImgDouble1^[l]^[j]^[i]*MoyMax/Moy^[k];
                   TabImgDouble1^[l]^[j]^[i]:=Valeur;
                   end;
            end;

   pop_Rapport.AddLine(lang('Sauvegarde de l''image ')
       +'mi_'+ListeImg.Strings[k-1]); //nolang
//   SaveImageGenerique(Directory+'\mi_'+ListeImg.Strings[k-1],TabImgInt1,TabImgDouble1,ImgInfos); //nolang
   SaveImage(Directory+'\mi_'+ListeImg.Strings[k-1],TabImgInt1,TabImgDouble1,ImgInfos); //nolang

   FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
   end;

finally
Freemem(Moy,8*NbImage);
end;
end;

procedure ArithmetiqueLot(Directory:string;
                          ImgInt:PTabImgInt;
                          ImgDouble:PTabImgDouble;
                          ListeImgIn:TStringList;
                          ImgInfos:TImgInfos;
                          pop_Rapport:tpop_rapport;
                          TypeOperation:Byte);
var
TabImgInt1:PTabImgInt;
TabImgDouble1:PTabImgDouble;
j,k:Integer;
NbImage:Integer;
StatMin,Mediane,StatMax,Moy,Ecart:Double;
Ext:string;
begin
Ext:=ExtractFileExt(ListeImgIn.Strings[0]);

case TypeOperation of
   0:pop_Rapport.AddLine(lang('Soustraction d''un image à un lot'));
   1:pop_Rapport.AddLine(lang('Division d''un lot par une image'));
   end;

NbImage:=ListeImgIn.Count;

if TypeOperation=1 then
   begin
   Statistiques(ImgInt,ImgDouble,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,
      1,StatMin,Mediane,StatMax,Moy,Ecart);
   pop_Rapport.AddLine(lang('Moyenne de l''image ')+FloatToStrF(Moy,ffFixed,5,2));
   end;

// Lecture et soustraction de toutes les images
for j:=0 to NbImage-1 do
   begin
   pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImgIn.Strings[j]);
   ReadImageGenerique(Directory+'\'+ListeImgIn.Strings[j],TabImgInt1,TabImgDouble1,ImgInfos);
   case TypeOperation of
      0:begin
        pop_Rapport.AddLine(lang('Soustraction de l''image à ')+ListeImgIN.Strings[j]);
        Soust(TabImgInt1,ImgInt,TabImgDouble1,ImgDouble,ImgInfos.TypeData,ImgInfos.NbPlans,
           ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Sx,ImgInfos.Sy);
        pop_Rapport.AddLine('Sauvegarde de l''image '+'\sub_'+ListeImgIn.Strings[j]); //nolang
//        SaveImageGenerique(Directory+'\sub_'+ListeImgIn.Strings[j],TabImgInt1,TabImgDouble1,ImgInfos); //nolang
        SaveImage(Directory+'\sub_'+ListeImgIn.Strings[j],TabImgInt1,TabImgDouble1,ImgInfos); //nolang
        end;
      1:begin
        pop_Rapport.AddLine(lang('Division de l''image à ')+ListeImgIn.Strings[j]);
        pop_Rapport.AddLine(lang('Et remise au niveau moyen initial '));
        Divi(TabImgInt1,ImgInt,TabImgDouble1,ImgDouble,ImgInfos.TypeData,ImgInfos.NbPlans,
           ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Sx,ImgInfos.Sy,Moy);
        pop_Rapport.AddLine(lang('Sauvegarde de l''image ')+
           '\div_'+ListeImgIn.Strings[j]); //nolang
//        SaveImageGenerique(Directory+'\div_'+ListeImgIn.Strings[j],TabImgInt1,TabImgDouble1,ImgInfos); //nolang
        SaveImage(Directory+'\div_'+ListeImgIn.Strings[j],TabImgInt1,TabImgDouble1,ImgInfos); //nolang
        end;
      end;

   FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
   end;

end;

procedure StatistiqueLot(Directory:string;
                 ListeImg:TStringList;
                 pop_Rapport:tpop_rapport);
var
TabImgInt1:PTabImgInt;
TabImgDouble1:PTabImgDouble;
i,j,k:Integer;
NbImage:Integer;
StatMin,Mediane,StatMax,Ecart,Moy:Double;
ImgInfos:TImgInfos;
begin
pop_Rapport.AddLine(lang('Statistique du lot'));
NbImage:=ListeImg.Count;

pop_Rapport.AddLine(lang('Minimum Maximum Médiane Moyenne Ecart'));
// Lecture et statististique de toutes les images
for k:=0 to NbImage-1 do
   begin
   ReadImageGenerique(Directory+'\'+ListeImg.Strings[k],TabImgInt1,TabImgDouble1,ImgInfos);

   Statistiques(TabImgInt1,nil,ImgInfos.TypeData,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,
      1,StatMin,Mediane,StatMax,Moy,Ecart);
   pop_Rapport.AddLine(Format('%0.0f',[StatMin])+' '+Format('%0.0f',[StatMax])+' '+Format('%0.0f',[Mediane])+ //nolang
      ' '+Format('%0.3f',[Moy])+' '+Format('%0.3f',[Ecart])); //nolang

   FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
   end;
end;

procedure SigmaKappaLot(Directory:string;
                        ListeImg:TStringList;
                        var TabImgInt:PTabImgInt;
                        var TabImgDouble:PTabImgDouble;
                        var ImgInfos:TImgInfos;
                        NbSigma:Double;
                        pop_Rapport:tpop_rapport);
var
TabImgInt1,TabImgInt2:PTabImgInt;
TabImgDouble1,TabImgDouble2:PTabImgDouble;
TempsPose:Integer;
i,j,k,l,m,n:Integer;
ListeTempsDePose:PLigInteger;
ListeDate:PLigDate;
NbImage:Integer;
IntTmp:Smallint;
TempsPoseFinal:Integer;
DateTimeFinal:TDateTime;
//ImgInfosTmp:TImgInfos;
Valeur,Ecart,Moyenne,Dx:Double;
Nb:Integer;
Elimine:PLigByte;
Trouve:Boolean;
NbElimine:Integer;
Nombre:PLigInteger;
NbUnPoint,NbTousPoint:Integer;
begin
pop_Rapport.AddLine(lang('Moyenne sigma-kappa du lot'));

NbImage:=ListeImg.Count;

Getmem(Elimine,NbImage);
Getmem(Nombre,NbImage*4);
Getmem(ListeTempsDePose,4*NbImage);
Getmem(ListeDate,Sizeof(TDateTime)*NbImage);

// Juste pour avoir NbPlans
ReadImageGenerique(Directory+'\'+ListeImg.Strings[0],TabImgInt1,TabImgDouble1,ImgInfos);
FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);

try

for n:=1 to ImgInfos.NbPlans do
   begin
   pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[0]);
   ReadImageGenerique(Directory+'\'+ListeImg.Strings[0],TabImgInt1,TabImgDouble1,ImgInfos);

   ImgInfos:=ImgInfos;
   ListeTempsDePose^[1]:=ImgInfos.TempsPose;
   ListeDate^[1]:=ImgInfos.DateTime;

   GetmemImg(TabImgInt,TabImgDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
   GetmemImg(TabImgInt2,TabImgDouble2,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,NbImage);

   case ImgInfos.TypeData of
      2,7:for j:=1 to ImgInfos.Sy do Move(TabImgInt1^[n]^[j]^,TabImgInt2^[n]^[j]^,ImgInfos.Sx*2);
      5,8:for j:=1 to ImgInfos.Sy do Move(TabImgDouble1^[n]^[j]^,TabImgDouble2^[n]^[j]^,ImgInfos.Sx*8);
      end;

   FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);

   // Lecture de toutes les images
   for k:=1 to NbImage-1 do
      begin
      pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[k]);
      ReadImageGenerique(Directory+'\'+ListeImg.Strings[k],TabImgInt1,TabImgDouble1,ImgInfos);
      case ImgInfos.TypeData of
         2,7:for j:=1 to ImgInfos.Sy do Move(TabImgInt1^[n]^[j]^,TabImgInt2^[k+1]^[j]^,ImgInfos.Sx*2);
         5,8:for j:=1 to ImgInfos.Sy do Move(TabImgDouble1^[n]^[j]^,TabImgDouble2^[k+1]^[j]^,ImgInfos.Sx*8);
         end;
      ListeTempsDePose^[k+1]:=ImgInfos.TempsPose;
      ListeDate^[k+1]:=ImgInfos.DateTime;

      FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
      end;

   NbUnPoint:=0;
   NbTousPoint:=0;
   for i:=1 to NbImage do Nombre^[i]:=0;
   // Calcul de la moyenne sigma-kappa
   pop_Rapport.AddLine(lang('Calcul de l''image moyenne sigma-kappa'));
   for j:=1 to ImgInfos.Sy do
      case ImgInfos.TypeData of
         2,7:for i:=1 to ImgInfos.Sx do
                begin
                for l:=1 to NbImage do Elimine^[l]:=1;
                NbElimine:=0;
                Trouve:=True;
                while trouve do
                   begin
                   // Calcul Moyenne et Ecart-type
                   Moyenne:=0;
                   Ecart:=0;
                   Nb:=0;
                   for l:=1 to NbImage do
                      begin
                      if Elimine[l]=1 then
                         begin
                         Valeur:=TabImgInt2^[l]^[j]^[i];
                         inc(Nb);
                         Dx:=Valeur-Moyenne;
                         Moyenne:=Moyenne+Dx/Nb;
                         Ecart:=Ecart+Dx*(Valeur-Moyenne);
                         end;
                      end;
                   Ecart:=Sqrt(Ecart/Nb);
                   // Suppression des valeurs aberantes
                   Trouve:=False;
                   for l:=1 to NbImage do
                      begin
                      if (Elimine^[l]=1) and (Abs(TabImgInt2^[l]^[j]^[i]-Moyenne)>NbSigma*Ecart)
                      and (NbElimine<NbImage-1) then
                         begin
                         Trouve:=True;
                         Elimine^[l]:=0;
                         inc(NbElimine);
                         end;
                      end;
                   end;
                if NbElimine=NbImage-1 then Inc(NbUnPoint);
                if NbElimine=0 then Inc(NbTousPoint);
                for m:=1 to NbImage do if Elimine^[m]=0 then inc(Nombre^[m]);
                // Calcul de la moyenne
                Moyenne:=0;
                Nb:=0;
                for l:=1 to NbImage do
                   begin
                   if Elimine[l]=1 then
                      begin
                      Valeur:=TabImgInt2^[l]^[j]^[i];
                      inc(Nb);
                      Dx:=Valeur-Moyenne;
                      Moyenne:=Moyenne+Dx/Nb;
                      end;
                   end;
                if Moyenne>32767 then Moyenne:=32767;
                if Moyenne<-32768 then Moyenne:=-32768;
                TabImgInt^[n]^[j]^[i]:=Round(Moyenne);
                end;
         5,8:for i:=1 to ImgInfos.Sx do
                begin
                for l:=1 to NbImage do Elimine^[l]:=1;
                NbElimine:=0;
                Trouve:=True;
                while trouve do
                   begin
                   // Calcul Moyenne et Ecart-type
                   Moyenne:=0;
                   Ecart:=0;
                   Nb:=0;
                   for l:=1 to NbImage do
                      begin
                      if Elimine[l]=1 then
                         begin
                         Valeur:=TabImgDouble2^[l]^[j]^[i];
                         inc(Nb);
                         Dx:=Valeur-Moyenne;
                         Moyenne:=Moyenne+Dx/Nb;
                         Ecart:=Ecart+Dx*(Valeur-Moyenne);
                         end;
                      end;
                   Ecart:=Sqrt(Ecart/Nb);
                   // Suppression des valeurs aberantes
                   Trouve:=False;
                   for l:=1 to NbImage do
                      begin
                      if (Elimine^[l]=1) and (Abs(TabImgDouble2^[l]^[j]^[i]-Moyenne)>NbSigma*Ecart)
                      and (NbElimine<NbImage-1) then
                         begin
                         Trouve:=True;
                         Elimine^[l]:=0;
                         inc(NbElimine);
                         end;
                      end;
                   end;
                if NbElimine=NbImage-1 then Inc(NbUnPoint);
                if NbElimine=0 then Inc(NbTousPoint);
                for m:=1 to NbImage do if Elimine^[m]=0 then inc(Nombre^[m]);
                // Calcul de la moyenne
                Moyenne:=0;
                Nb:=0;
                for l:=1 to NbImage do
                   begin
                   if Elimine[l]=1 then
                      begin
                      Valeur:=TabImgDouble2^[l]^[j]^[i];
                      inc(Nb);
                      Dx:=Valeur-Moyenne;
                      Moyenne:=Moyenne+Dx/Nb;
                      end;
                   end;
                if Moyenne>32767 then Moyenne:=32767;
                if Moyenne<-32768 then Moyenne:=-32768;
                TabImgDouble^[n]^[j]^[i]:=Moyenne;
                end;
         end;

   CalculeBarycentreTempsDePose(ListeTempsDePose,ListeDate,NbImage,1,TempsPoseFinal,DateTimeFinal);
   ImgInfos.TempsPose:=TempsPoseFinal;
   ImgInfos.DateTime:=DateTimeFinal;

   pop_Rapport.AddLine('');
   if ImgInfos.NbPlans<>1 then
      begin
      pop_Rapport.AddLine(lang('Plan n° ')+IntToStr(n));
      pop_Rapport.AddLine('');
      end;
   pop_Rapport.AddLine(Format(lang('Nombres de points douteux : %d'),[NbUnPoint]));
   pop_Rapport.AddLine(Format(lang('Pourcentages de points douteux : %4.1f %'),[NbUnPoint/ImgInfos.Sx/ImgInfos.Sy*100]));
   pop_Rapport.AddLine(Format(lang('Nombre de points hors sigma kappa : %d'),[NbTousPoint]));
   pop_Rapport.AddLine(Format(lang('Pourcentages de points hors sigma kappa : %4.1f %'),[NbTousPoint/ImgInfos.Sx/ImgInfos.Sy*100]));
   if NbTousPoint/ImgInfos.Sx/ImgInfos.Sy=1 then
      begin
      pop_Rapport.AddLine(lang('Aucun point n''est éliminé'));
      pop_Rapport.AddLine(lang('Traitement équivalent à une simple moyenne'));
      end;
   pop_Rapport.AddLine('');
   pop_Rapport.AddLine(lang('Pourcentages de points éliminés dans les image'));
   for i:=1 to NbImage do
      pop_Rapport.AddLine(Format('Image %d : %4.1f',[i,Nombre^[i]/ImgInfos.Sx/ImgInfos.Sy*100])); //nolang
   end;

finally
FreememImg(TabImgInt2,TabImgDouble2,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,NbImage);

Freemem(Elimine,NbImage);
Freemem(Nombre,NbImage*4);
Freemem(ListeTempsDePose,4*NbImage);
Freemem(ListeDate,Sizeof(TDateTime)*NbImage);
end;

end;

procedure Pretraitements(Directory:string;
                         ListeOffsets:TStringList;
                         ListeNoirs:TStringList;
                         ListeNoirsFlats:TStringList;
                         ListeFlats:TStringList;
                         ListeImages:TStringList;
                         var ImagesFinales:TStringList;
                         ConfigPretraitements:TConfigPretraitements;
                         pop_Rapport:tpop_rapport);
var
ImgDoubleNil:PTabImgDouble;
ImgOffset,ImgNoir,ImgNoirFlats,ImgFlat,Image:PTabImgInt;
ImgOffsetDouble,ImgNoirDouble,ImgNoirFlatsDouble,ImgFlatDouble,ImageDouble:PTabImgDouble;
ImgInfos:TImgInfos;
OffsetCree,NoirCree,NoirFlatsCree,FlatCree,ImageCree:Boolean;
OffsetEnleveAuxNoirs,OffsetEnleveAuxNoirsFlats,OffsetEnleveAuxFlats:Boolean;
NoirsFlatsEnleveAuxFlats,OffsetEnleveAuxImages,FlatEnleveAuxImages:Boolean;
FlatMemeMoyenne:Boolean;
ListeNoirsTraites:TStringList;
ListeNoirsFlatsSansOffset:TStringList;
ListeFlatsTraites:TStringList;
ListeImagesTraites:TStringList;
ListeImagesSupp:TStringList;
ListeGenerique:TStringList;
NbImages,ListeCompo:TStringList;
i,j,k,PosEsp,NbImage:Integer;
Nom,NomFinal,Ext:string;
pop_image:tpop_image;
SB1,SH1:Double;
OffsetExisteDeja,NoirExisteDeja,FlatExisteDeja:Boolean;
LocalNomOffset,LocalNomNoir,LocalNomFlat:string;
BonCalcul:Boolean;
Test:Boolean;
begin
ClasseListe(ListeOffsets);
ClasseListe(ListeNoirs);
ClasseListe(ListeNoirsFlats);
ClasseListe(ListeFlats);
ClasseListe(ListeImages);

// Juste pour avoir Sx et Sy
ReadHeader(Directory+'\'+ListeImages.Strings[0],ImgInfos);
Ext:=ExtractFileExt(ListeImages.Strings[0]);

//GetmemImg(ImgOffset,ImgDoubleNil,ImgInfos.Sx,ImgInfos.Sy,2,1);
//GetmemImg(ImgNoir,ImgDoubleNil,ImgInfos.Sx,ImgInfos.Sy,2,1);
//GetmemImg(ImgNoirFlats,ImgDoubleNil,ImgInfos.Sx,ImgInfos.Sy,2,1);
//GetmemImg(ImgFlat,ImgDoubleNil,ImgInfos.Sx,ImgInfos.Sy,2,1);
//GetmemImg(Image,ImgDoubleNil,ImgInfos.Sx,ImgInfos.Sy,2,1);

ListeNoirsTraites:=TStringList.Create;
ListeNoirsFlatsSansOffset:=TStringList.Create;
ListeFlatsTraites:=TStringList.Create;
ListeImagesTraites:=TStringList.Create;
ListeImagesSupp:=TStringList.Create;
NbImages:=TStringList.Create;

// Les images de flat/noir/Offset existent elle deja
//LocalNomOffset:=ChangeExtToGenerique(ConfigPretraitements.NomOffset,2);
LocalNomOffset:=ConfigPretraitements.NomOffset+Ext;
OffsetExisteDeja:=FileExists(LocalNomOffset);
//LocalNomNoir:=ChangeExtToGenerique(ConfigPretraitements.NomNoir,2);
LocalNomNoir:=ConfigPretraitements.NomNoir+Ext;
NoirExisteDeja:=FileExists(LocalNomNoir);
//LocalNomFlat:=ChangeExtToGenerique(ConfigPretraitements.NomFlat,2);
LocalNomFlat:=ConfigPretraitements.NomFlat+Ext;
FlatExisteDeja:=FileExists(LocalNomFlat);

try

// ****** Partie Offset ******
OffsetCree:=False;
if ConfigPretraitements.UsePreviousFiles and OffsetExisteDeja then
   begin
   pop_Rapport.AddLine('');
   pop_Rapport.AddLine('Lecture de l''offset : '+LocalNomOffset);
   pop_Rapport.AddLine('');

   ReadImageGenerique(LocalNomOffset,ImgOffset,ImgOffsetDouble,ImgInfos);
   OffsetCree:=True;
   end
else
   begin
   // On cree l'offset
   if ConfigPretraitements.CreeOffset and (ListeOffsets.Count<>0) then
      begin
      pop_Rapport.AddLine('');
      pop_Rapport.AddLine(lang('Création de l''offset'));
      pop_Rapport.AddLine('');
      case ConfigPretraitements.TypeCreationOffset of
         0:AddLot(Directory,ListeOffsets,ImgOffset,ImgOffsetDouble,ImgInfos,pop_Rapport,True);
         1:MedianLot(Directory,ListeOffsets,ImgOffset,ImgOffsetDouble,ImgInfos,pop_Rapport);
         2:SigmaKappaLot(Directory,ListeOffsets,ImgOffset,ImgOffsetDouble,ImgInfos,
              ConfigPretraitements.NbSigmaOffset,pop_Rapport);
         end;
      pop_Rapport.AddLine(lang('Sauvegarde de l''image d''offset'));
//      SaveImageGenerique(Directory+'\'+ConfigPretraitements.NomOffset,ImgOffset,ImgOffsetDouble,ImgInfos);
      SaveImage(Directory+'\'+ConfigPretraitements.NomOffset+Ext,ImgOffset,ImgOffsetDouble,ImgInfos);
      OffsetCree:=True;
      end
   else OffsetCree:=False;
   end;

// ****** Partie Noir ******
NoirCree:=False;
if ConfigPretraitements.UsePreviousFiles and NoirExisteDeja then
   begin
   pop_Rapport.AddLine('');
   pop_Rapport.AddLine(lang('Lecture du noir : ')+LocalNomNoir);
   pop_Rapport.AddLine('');

   ReadImageGenerique(LocalNomNoir,ImgNoir,ImgNoirDouble,ImgInfos);
   NoirCree:=True;
   end
else
   begin
   // On enleve l'offset aux noirs
   if ConfigPretraitements.EnleveOffsetAuxNoirs and OffsetCree and (ListeNoirs.Count<>0) then
      begin
      pop_Rapport.AddLine('');
      pop_Rapport.AddLine(lang('Soustraction de l''offset aux noirs'));
      pop_Rapport.AddLine('');
      ArithmetiqueLot(Directory,ImgOffset,ImgOffsetDouble,ListeNoirs,ImgInfos,pop_Rapport,0);
      for i:=0 to ListeNoirs.Count-1 do
         begin
//         Nom:=ChangeExtToGenerique('sub_'+ListeNoirs.Strings[i],2); //nolang
         Nom:='sub_'+ListeNoirs.Strings[i]; //nolang
         ListeImagesSupp.Add(Nom);
         ListeNoirsTraites.Add(Nom);
         end;
      OffsetEnleveAuxNoirs:=True;
      end
   else
      begin
      if ListeNoirs.Count<>0 then
         for i:=0 to ListeNoirs.Count-1 do
            begin
            Nom:=ListeNoirs.Strings[i];
            ListeNoirsTraites.Add(Nom);
            end;
      OffsetEnleveAuxNoirs:=False;
      end;

   // On cree le noir des images
   if ConfigPretraitements.CreeNoir and (ListeNoirsTraites.Count<>0) then
      begin
      pop_Rapport.AddLine('');
      pop_Rapport.AddLine(lang('Création du noir'));
      pop_Rapport.AddLine('');
      case ConfigPretraitements.TypeCreationNoir of
         0:AddLot(Directory,ListeNoirsTraites,ImgNoir,ImgNoirDouble,ImgInfos,pop_Rapport,True);
         1:MedianLot(Directory,ListeNoirsTraites,ImgNoir,ImgNoirDouble,ImgInfos,pop_Rapport);
         2:SigmaKappaLot(Directory,ListeNoirsTraites,ImgNoir,ImgNoirDouble,ImgInfos,
              ConfigPretraitements.NbSigmaNoir,pop_Rapport);
         end;
      pop_Rapport.AddLine(lang('Sauvegarde de l''image de noir'));
//      SaveImageGenerique(Directory+'\'+ConfigPretraitements.NomNoir,ImgNoir,ImgNoirDouble,ImgInfos);
      SaveImageGenerique(Directory+'\'+ConfigPretraitements.NomNoir+Ext,ImgNoir,ImgNoirDouble,ImgInfos);
      NoirCree:=True;
      end
   else NoirCree:=False;
   end;

// ****** Partie Flat ******
FlatCree:=False;
if ConfigPretraitements.UsePreviousFiles and FlatExisteDeja then
   begin
   pop_Rapport.AddLine('');
   pop_Rapport.AddLine(lang('Lecture du flat : ')+LocalNomFlat);
   pop_Rapport.AddLine('');

   ReadImageGenerique(LocalNomFlat,ImgFlat,ImgFlatDouble,ImgInfos);
   FlatCree:=True;
   end
else
   begin
   // On enleve l'offset aux noirs des flats
   if ConfigPretraitements.EnleveOffsetAuxNoirsFlats and OffsetCree and (ListeNoirsFlats.Count<>0) then
      begin
      pop_Rapport.AddLine('');
      pop_Rapport.AddLine(lang('Soustraction de l''offset aux noir des flats'));
      pop_Rapport.AddLine('');
      ArithmetiqueLot(Directory,ImgOffset,ImgOffsetDouble,ListeNoirsFlats,ImgInfos,pop_Rapport,0);
      for i:=0 to ListeNoirsFlats.Count-1 do
         begin
//         Nom:=ChangeExtToGenerique('sub_'+ListeNoirsFlats.Strings[i],2); //nolang
         Nom:='sub_'+ListeNoirsFlats.Strings[i]; //nolang
         ListeImagesSupp.Add(Nom);
         ListeNoirsFlatsSansOffset.Add(Nom);
         end;
      OffsetEnleveAuxNoirsFlats:=True;
      end
   else OffsetEnleveAuxNoirsFlats:=False;

   // On cree le noir des flats
   if OffsetEnleveAuxNoirsFlats then
      begin
      pop_Rapport.AddLine('');
      pop_Rapport.AddLine(lang('Création du noir des flats'));
      pop_Rapport.AddLine('');
      if ConfigPretraitements.CreeNoirFlats and (ListeNoirsFlatsSansOffset.Count<>0) then
         begin
         case ConfigPretraitements.TypeCreationNoirFlat of
            0:AddLot(Directory,ListeNoirsFlatsSansOffset,ImgNoirFlats,ImgNoirFlatsDouble,
                 ImgInfos,pop_Rapport,True);
            1:MedianLot(Directory,ListeNoirsFlatsSansOffset,ImgNoirFlats,ImgNoirFlatsDouble,
                 ImgInfos,pop_Rapport);
            2:SigmaKappaLot(Directory,ListeNoirsFlatsSansOffset,ImgNoirFlats,ImgNoirFlatsDouble,
                 ImgInfos,ConfigPretraitements.NbSigmaNoirFlat,pop_Rapport);
            end;
         pop_Rapport.AddLine(lang('Sauvegarde de l''image de noir des flats'));
//         SaveImageGenerique(Directory+'\'+ConfigPretraitements.NomNoirFlat,ImgNoirFlats,ImgNoirFlatsDouble,ImgInfos);
         SaveImage(Directory+'\'+ConfigPretraitements.NomNoirFlat+Ext,ImgNoirFlats,ImgNoirFlatsDouble,ImgInfos);
         NoirFlatsCree:=True;
         end
      else NoirFlatsCree:=False;
      end
   else
      begin
      if ConfigPretraitements.CreeNoirFlats and (ListeNoirsFlats.Count<>0) then
         begin
         case ConfigPretraitements.TypeCreationNoirFlat of
            0:AddLot(Directory,ListeNoirsFlats,ImgNoirFlats,ImgNoirFlatsDouble,
                 ImgInfos,pop_Rapport,True);
            1:MedianLot(Directory,ListeNoirsFlats,ImgNoirFlats,ImgNoirFlatsDouble,
                 ImgInfos,pop_Rapport);
            2:SigmaKappaLot(Directory,ListeNoirsFlats,ImgNoirFlats,ImgNoirFlatsDouble,
                 ImgInfos,ConfigPretraitements.NbSigmaNoirFlat,pop_Rapport);
            end;
         NoirFlatsCree:=True;
         end
      else NoirFlatsCree:=False;
      end;

   // Traitement des flats
   // ListeFlatsTraites est la liste des flats traites avant addition
   // On enleve l'offset aux flats
   if ConfigPretraitements.EnleveOffsetAuxFlats and OffsetCree and (ListeFlats.Count<>0) then
      begin
      pop_Rapport.AddLine('');
      pop_Rapport.AddLine(lang('Soustraction de l''offset aux flats'));
      pop_Rapport.AddLine('');
      ArithmetiqueLot(Directory,ImgOffset,ImgOffsetDouble,ListeFlats,ImgInfos,pop_Rapport,0);
      for i:=0 to ListeFlats.Count-1 do
         begin
//         Nom:=ChangeExtToGenerique('sub_'+ListeFlats.Strings[i],2); //nolang
         Nom:='sub_'+ListeFlats.Strings[i]; //nolang
         ListeImagesSupp.Add(Nom);
         ListeFlatsTraites.Add(Nom);
         end;
      OffsetEnleveAuxFlats:=True;
      end
   else
      begin
      for i:=0 to ListeFlats.Count-1 do
         begin
         Nom:=ListeFlats.Strings[i];
         ListeFlatsTraites.Add(Nom);
         end;
      OffsetEnleveAuxFlats:=False;
      end;

   // On enleve le noir des flats aux flats
   if ConfigPretraitements.EnleveNoirsFlatsAuxFlats and NoirFlatsCree and (ListeFlatsTraites.Count<>0) then
      begin
      pop_Rapport.AddLine('');
      pop_Rapport.AddLine(lang('Soustraction du noir des flats aux flats'));
      pop_Rapport.AddLine('');
      ArithmetiqueLot(Directory,ImgNoirFlats,ImgNoirFlatsDouble,ListeFlatsTraites,ImgInfos,pop_Rapport,0);
      for i:=0 to ListeFlatsTraites.Count-1 do
         begin
//         Nom:=ChangeExtToGenerique('sub_'+ListeFlatsTraites.Strings[i],2); //nolang
         Nom:='sub_'+ListeFlatsTraites.Strings[i]; //nolang
         ListeImagesSupp.Add(Nom);
         ListeFlatsTraites.Strings[i]:=Nom;
         end;
      NoirsFlatsEnleveAuxFlats:=True;
      end
   else NoirsFlatsEnleveAuxFlats:=False;

   // On mets les flats a la meme moyenne
   if ConfigPretraitements.MoyenneIdentiqueDesFlats and (ListeFlatsTraites.Count<>0) then
      begin
      pop_Rapport.AddLine('');
      pop_Rapport.AddLine(lang('Moyenne identique des flats'));
      pop_Rapport.AddLine('');
      MoyenneIdentique(Directory,ListeFlatsTraites,pop_Rapport);
      for i:=0 to ListeFlatsTraites.Count-1 do
         begin
//         Nom:=ChangeExtToGenerique('mi_'+ListeFlatsTraites.Strings[i],2); //nolang
         Nom:='mi_'+ListeFlatsTraites.Strings[i]; //nolang
         ListeImagesSupp.Add(Nom);
         ListeFlatsTraites.Strings[i]:=Nom;
         end;
      FlatMemeMoyenne:=True;
      end
   else FlatMemeMoyenne:=False;

   // On cree le flat
   if ConfigPretraitements.CreeFlat and (ListeFlatsTraites.Count<>0) then
      begin
      pop_Rapport.AddLine('');
      pop_Rapport.AddLine(lang('Création du flat'));
      pop_Rapport.AddLine('');
      case ConfigPretraitements.TypeCreationFlat of
         0:AddLot(Directory,ListeFlatsTraites,ImgFlat,ImgFlatDouble,ImgInfos,pop_Rapport,True);
         1:MedianLot(Directory,ListeFlatsTraites,ImgFlat,ImgFlatDouble,ImgInfos,pop_Rapport);
         2:SigmaKappaLot(Directory,ListeFlatsTraites,ImgFlat,ImgFlatDouble,ImgInfos,
              ConfigPretraitements.NbSigmaFlat,pop_Rapport);
         end;
      pop_Rapport.AddLine(lang('Sauvegarde de l''image flat-field'));
//      SaveImageGenerique(Directory+'\'+ConfigPretraitements.NomFlat,ImgFlat,ImgFlatDouble,ImgInfos);
      SaveImage(Directory+'\'+ConfigPretraitements.NomFlat+Ext,ImgFlat,ImgFlatDouble,ImgInfos);
      FlatCree:=True;
      end
   else FlatCree:=False;
   end;

// On enleve l'offset aux images
if ConfigPretraitements.EnleveOffsetAuxImages and OffsetCree and (ListeImages.Count<>0) then
   begin
   pop_Rapport.AddLine('');
   pop_Rapport.AddLine(lang('Soustraction de l''offset aux images'));
   pop_Rapport.AddLine('');
   ArithmetiqueLot(Directory,ImgOffset,ImgOffsetDouble,ListeImages,ImgInfos,pop_Rapport,0);
   for i:=0 to ListeImages.Count-1 do
      begin
//      Nom:=ChangeExtToGenerique('sub_'+ListeImages.Strings[i],2); //nolang
      Nom:='sub_'+ListeImages.Strings[i]; //nolang
      if ConfigPretraitements.EnleveNoirAuxImages or
         ConfigPretraitements.CorrigeImagesDuFlat or
         ConfigPretraitements.RecaleImages or
         ConfigPretraitements.CompositeImages then // on ne supprime que si ce n'est pas la derniere etape.
      ListeImagesSupp.Add(Nom);
      ListeImagesTraites.Add(Nom);
      end;
   OffsetEnleveAuxImages:=True;
   end
else
   begin
   for i:=0 to ListeImages.Count-1 do
      begin
//      Nom:=ChangeExtToGenerique(ListeImages.Strings[i],2);
      Nom:=ListeImages.Strings[i];
      ListeImagesTraites.Add(Nom);
      end;
   OffsetEnleveAuxImages:=False;
   end;

// On enleve le noir aux images
if ConfigPretraitements.EnleveNoirAuxImages and NoirCree and (ListeImagesTraites.Count<>0) then
   begin
   pop_Rapport.AddLine('');
   pop_Rapport.AddLine(lang('Soustraction du noir aux images'));
   pop_Rapport.AddLine('');
   if ConfigPretraitements.OptimiseNoir then SoustOptimiseLot(Directory,ImgNoir,ImgNoirDouble,ImgInfos.Sx,ImgInfos.Sy,
      ImgInfos.TypeData,ImgInfos.NbPlans,ListeImagesTraites,pop_Rapport)
   else ArithmetiqueLot(Directory,ImgNoir,ImgNoirDouble,ListeImagesTraites,ImgInfos,pop_Rapport,0);
   for i:=0 to ListeImagesTraites.Count-1 do
      begin
//      Nom:=ChangeExtToGenerique('sub_'+ListeImagesTraites.Strings[i],2); //nolang
      Nom:='sub_'+ListeImagesTraites.Strings[i]; //nolang
      if ConfigPretraitements.CorrigeImagesDuFlat or
         ConfigPretraitements.RecaleImages or
         ConfigPretraitements.CompositeImages then // on ne supprime que si ce n'est pas la derniere etape.
             ListeImagesSupp.Add(Nom);
      ListeImagesTraites.Strings[i]:=Nom;
      end;
   OffsetEnleveAuxImages:=True;
   end
else OffsetEnleveAuxImages:=False;

// On corrige les images du flat
if ConfigPretraitements.CorrigeImagesDuFlat and FlatCree and (ListeImagesTraites.Count<>0) then
   begin
   pop_Rapport.AddLine('');
   pop_Rapport.AddLine(lang('Correction flat-field des images'));
   pop_Rapport.AddLine('');
   ArithmetiqueLot(Directory,ImgFlat,ImgFlatDouble,ListeImagesTraites,ImgInfos,pop_Rapport,1);
   for i:=0 to ListeImagesTraites.Count-1 do
      begin
//      Nom:=ChangeExtToGenerique('div_'+ListeImagesTraites.Strings[i],2); //nolang
      Nom:='div_'+ListeImagesTraites.Strings[i]; //nolang
//      if ConfigPretraitements.RecaleImages or
//         ConfigPretraitements.CompositeImages then // on ne supprime que si ce n'est pas la derniere etape.
      // Si on composite pas les images, laisser les images intermediaires
      if ConfigPretraitements.RecaleImages then ListeImagesSupp.Add(Nom);
      ListeImagesTraites.Strings[i]:=Nom;
      end;
   FlatEnleveAuxImages:=True;
   end
else FlatEnleveAuxImages:=False;

// On applique le script cosmetique sans en changer le nom
if ConfigPretraitements.CorrigeCosmetique and FileExists(ConfigPretraitements.NomCosmetiques)
   and (ListeImagesTraites.Count<>0)then
   begin
   pop_Rapport.AddLine('');
   pop_Rapport.AddLine(lang('Correction cosmétique des images'));
   pop_Rapport.AddLine('');
   CosmetiqueLot(Directory,ListeImagesTraites,ConfigPretraitements.NomCosmetiques,pop_Rapport);
   end;

// Filtrage Median
if ConfigPretraitements.AppliqueMedian and (ListeImagesTraites.Count<>0)then
   begin
   pop_Rapport.AddLine(lang('Filtrage Median 3x3 des images'));
   NbImage:=ListeImagesTraites.Count;

   for k:=0 to NbImage-1 do
      begin
      ReadImageGenerique(Directory+'\'+ListeImagesTraites.Strings[k],Image,ImageDouble,ImgInfos);
      Median(Image,ImageDouble,3,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
      SaveImage(Directory+'\'+ListeImagesTraites.Strings[k],Image,ImageDouble,ImgInfos);
      FreememImg(Image,ImageDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
      end;
   end;

// Ici il faut separer les differents lots d'image
// On cherche la liste des noms generiques
TrouveNomsGenereriques(ListeImagesTraites,ListeGenerique);

// Boucle sur toutes les images
for j:=0 to ListeGenerique.Count-1 do
   begin
   // On cree la liste d'images
   ListeCompo:=TStringList.Create;
   ListeCompo.Clear;
   for k:=0 to ListeImagesTraites.Count-1 do
      if GetNomGenerique(ListeImagesTraites.Strings[k])=ListeGenerique.Strings[j] then
         ListeCompo.Add(ListeImagesTraites.Strings[k]);

   // On recale les images
   if ConfigPretraitements.RecaleImages and (ListeCompo.Count<>0) then
      begin
      pop_Rapport.AddLine('');
      pop_Rapport.AddLine(lang('Recalage des images'));
      pop_Rapport.AddLine('');
      case ConfigPretraitements.TypeRecalageImages of
         0:BonCalcul:=RecaleEtoileLot(Directory,ListeCompo,ConfigPretraitements.ErreurRecaleImages,pop_Rapport,True);
         1:RecalePlanetLot(Directory,ListeCompo,pop_Rapport,True);
         2:BonCalcul:=RegistrationEtoileLot(Directory,ListeCompo,ConfigPretraitements.ErreurRecaleImages,pop_Rapport,True);         
         end;
      if not BonCalcul then raise MyError.Create('Pas assez d''étoiles dans l''image de référence');
      // Si on composite pas les images, laisser les images intermediaires
      if ConfigPretraitements.CompositeImages and (ListeCompo.Count<>0) then
         for i:=0 to ListeCompo.Count-1 do
            ListeImagesSupp.Add(ListeCompo.Strings[i]);
      end;

   // On composite les images
   if ConfigPretraitements.CompositeImages and (ListeCompo.Count<>0) then
      begin
      pop_Rapport.AddLine('');
      pop_Rapport.AddLine(lang('Compositage des images'));
      pop_Rapport.AddLine('');
      case ConfigPretraitements.TypeCompositageImages of
         0:AddLot(Directory,ListeCompo,Image,ImageDouble,ImgInfos,pop_Rapport,True);
         1:MedianLot(Directory,ListeCompo,Image,ImageDouble,ImgInfos,pop_Rapport);
         2:SigmaKappaLot(Directory,ListeCompo,Image,ImageDouble,ImgInfos,
              ConfigPretraitements.NbSigmaImage,pop_Rapport);
         3:AddLot(Directory,ListeCompo,Image,ImageDouble,ImgInfos,pop_Rapport,False);
         end;

      ImageCree:=True;
      end
   else ImageCree:=False;

   if ImageCree then
      begin
      NomFinal:=ListeGenerique.Strings[j];

      PosEsp:=Pos('sub_',NomFinal); //nolang
      while PosEsp<>0 do
         begin
         Delete(NomFinal,PosEsp,4);
         PosEsp:=Pos('sub_',NomFinal); //nolang
         end;
      PosEsp:=Pos('div_',NomFinal); //nolang
      while PosEsp<>0 do
         begin
         Delete(NomFinal,PosEsp,4);
         PosEsp:=Pos('sub_',NomFinal); //nolang
         end;
      PosEsp:=Pos('rec_',NomFinal); //nolang
      while PosEsp<>0 do
         begin
         Delete(NomFinal,PosEsp,4);
         PosEsp:=Pos('sub_',NomFinal); //nolang
         end;

      // Mise a jour auto des seuils
      RechercheSeuils(Image,ImageDouble,ImgInfos.Typedata,ImgInfos.TypeComplexe,ImgInfos.Sx,ImgInfos.Sy,1,config.SeuilBasPourCent,
         config.SeuilHautPourCent,SB1,SH1);

      if SB1=SH1 then
         begin
         SB1:=SB1-1;
         SH1:=SH1+1;
         end;

      ImgInfos.min[1]:=SB1;
      ImgInfos.max[1]:=SH1;

      pop_Rapport.AddLine(lang('Sauvegarde de l''image ')+NomFinal);
//      SaveImageGenerique(Directory+'\'+NomFinal,Image,ImageDouble,ImgInfos);
      SaveImage(Directory+'\'+NomFinal+Ext,Image,ImageDouble,ImgInfos);
      NbImages.Add(IntToStr(ListeCompo.Count));
      ImagesFinales.Add(Directory+'\'+NomFinal+Ext);
      end;
   end;

pop_Rapport.AddLine('');
pop_Rapport.AddLine(lang('Fin des prétraitements'));
pop_Rapport.AddLine('');

for i:=0 to NbImages.Count-1 do
   pop_Rapport.Addline(ExtractFileName(ImagesFinales[i])+lang(' créée avec ')+NbImages[i]+
      lang(' images compositées'));

finally
NbImages.Free;
if ConfigPretraitements.SupprimmerImages then
   for i:=0 to ListeImagesSupp.Count-1 do
      DeleteFile(Directory+'\'+ListeImagesSupp.Strings[i]);

ListeNoirsTraites.Free;
ListeNoirsFlatsSansOffset.Free;
ListeFlatsTraites.Free;
ListeImagesTraites.Free;
ListeImagesSupp.Free;

if OffsetCree then
   FreememImg(ImgOffset,ImgOffsetDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
if NoirCree then
   FreememImg(ImgNoir,ImgNoirDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
if NoirFlatsCree then
   FreememImg(ImgNoirFlats,ImgNoirFlatsDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
if FlatCree then
   FreememImg(ImgFlat,ImgFlatDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
//FreememImg(Image,ImgDoubleNil,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
end;
end;

procedure BestOfStellaire(Directory:string;
                          ListeImg:TStringList;
                          DSigma:Double;
                          SigmaMax:Double;
                          NbImagesMax:Integer;
                          ShowGraph:Boolean;
                          pop_Rapport:tpop_rapport);
var
   TabImgInt:PTabImgInt;
   TabImgDouble:PTabImgDouble;
   i,j,k,l:Integer;
   NbImage:Integer;
   arrdetections:plistepsf;
   NDetect:Integer;
   ImgInfos:TImgInfos;
   DateTimeFinal:TDateTime;
   LigDouble,Note,Max,Moyenne:PLigDouble;
   Series:TTASerie;
   GrapheX:Tpop_graphe;
   PosImage:PLigWord;
   DTemp:Double;
   WTemp:Word;
   Trouve:Boolean;
   Nom:string;
   Color:TColor;
begin
pop_Rapport.AddLine(lang('Sélection des meilleures images d''un lot'));

NbImage:=ListeImg.Count;

if ShowGraph then
   begin
   GrapheX:=Tpop_graphe.Create(Application);
   GrapheX.Show;
   GrapheX.TAChart1.ShowLegend:=True;
   GrapheX.TAChart1.ShowAxisLabel:=True;   
   GrapheX.TAChart1.XAxisLabel:=lang('Numéro d''étoile');
   GrapheX.TAChart1.YAxisLabel:=lang('FWHMX-FWHMY');
   end;

Getmem(Note,NbImage*8);
Getmem(Max,NbImage*8);
Getmem(Moyenne,NbImage*8);
Getmem(PosImage,NbImage*2);
try

// Lecture et analyse de toutes les images
for j:=0 to NbImage-1 do
   begin
   pop_Rapport.AddLine('***************************************************************'); //nolang
   // Lecture de l'image
   pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[j]);
   ReadImageGenerique(Directory+'\'+ListeImg.Strings[j],TabImgInt,TabImgDouble,ImgInfos);

   pop_Rapport.AddLine(lang('Mesure de la qualité de l''image ')+ListeImg.Strings[j]);
   pop_Rapport.AddLine(lang('Modélisation des étoiles de l''image '));
   {$IFDEF DEBUG}
   ModeliseSources(TabImgInt,TabImgDouble,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,9,arrdetections,TGaussEllipse,LowPrecision,LowSelect,
      ndetect,15,true,'c:\testfind_B.dat',False); //nolang
   {$ELSE}
//   ModeliseSources(TabImgInt,TabImgDouble,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,9,arrdetections,TGaussEllipse,LowPrecision,HighSelect,
//      ndetect,5,false,'',False);
//ModeliseSources(DataInt,DataDouble,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,
//   Config.LargModelise,ListePSF,TGauss,LowPrecision,LowSelect,NBSources,15,False,'',True);

   ModeliseSources(TabImgInt,TabImgDouble,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,
      9,arrdetections,TGaussEllipse,LowPrecision,LowSelect,NDetect,15,False,'',False);
   {$ENDIF}
   pop_Rapport.AddLine(lang('Nombres des étoiles de l''image : ')+IntToStr(ndetect));

   Getmem(LigDouble,NDetect*8);
   try

   Moyenne^[j+1]:=0;
   Max^[j+1]:=MinDouble;
   for i:=1 to NDetect do
      begin
      if ArrDetections[i].SigmaX>Max^[j+1] then Max^[j+1]:=ArrDetections[i].SigmaX;
      if ArrDetections[i].SigmaY>Max^[j+1] then Max^[j+1]:=ArrDetections[i].SigmaY;
      LigDouble^[i]:=Abs(ArrDetections[i].SigmaX-ArrDetections[i].SigmaY);
      Moyenne^[j+1]:=Moyenne^[j+1]+LigDouble^[i];
      end;

   Note^[j+1]:=Moyenne^[j+1]/NDetect;
   QuickSortDouble(LigDouble,1,NDetect);
//   Note^[j+1]:=LigDouble^[NDetect div 2];
   PosImage^[j+1]:=j;
   pop_Rapport.AddLine(lang('Moyenne FWHMX-FWHMY = ')+FloatToStr(Round(Note^[j+1]*100)/100));
   pop_Rapport.AddLine(lang('FWHM Max = ')+FloatToStr(Round(Max^[j+1]*100)/100));   

   Randomize;
   if ShowGraph then
      begin
      Series:=TTASerie.Create(Application);
      Series.Title:=ListeImg.Strings[j];
      GrapheX.TAChart1.AddSerie(Series);
      Color:=(Random(255) or (Random(255) shl 8) or (Random(255) shl 16));
//      Color:=RGB(Random(255),Random(255),Random(255));
      for i:=1 to NDetect do
         begin
//         Series.Addy(LigDouble^[i],'',clTeeColor);
         Series.AddXY(i,LigDouble^[i],Color);
         Application.ProcessMessages;
         end;
      end;

   finally
   Freemem(LigDouble,NDetect*8);
   end;

   FreememImg(TabImgInt,TabImgDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
   end;

// Classer les images par note
Trouve:=True;
while Trouve do
   begin
   Trouve:=False;
   for i:=1 to NbImage-1 do
      if Note^[i]>Note^[i+1] then
         begin
         Trouve:=True;
         DTemp:=Note^[i];
         Note^[i]:=Note^[i+1];
         Note^[i+1]:=DTemp;
         WTemp:=PosImage^[i];
         PosImage^[i]:=PosImage^[i+1];
         PosImage^[i+1]:=WTemp;
         end;
   end;

pop_Rapport.AddLine('');

// Renommer
l:=1;
for i:=1 to NbImagesMax do
   begin
   pop_Rapport.AddLine('***************************************************************'); //nolang
   pop_Rapport.AddLine(lang('Image ')+ListeImg.Strings[PosImage^[i]]);
   pop_Rapport.AddLine(lang('Note = ')+FloatToStr(Round(Note^[i]*100)/100));
   pop_Rapport.AddLine(lang('Max = ')+FloatToStr(Round(Max^[i]*100)/100));
   if (Note^[i]<DSigma) and (Max^[i]<SigmaMax) then
      begin
      pop_Rapport.AddLine(lang('Note < ')+FloatToStr(Round(DSigma*100)/100)+
         lang(' et Max < ')+FloatToStr(Round(SigmaMax*100)/100)+
         lang(' on la garde'));

      pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[PosImage^[i]]);
      ReadImageGenerique(Directory+'\'+ListeImg.Strings[PosImage^[i]],TabImgInt,TabImgDouble,ImgInfos);

      Nom:=GetNomGenerique(ListeImg.Strings[PosImage^[i]])+IntToStr(l);
      pop_Rapport.AddLine(lang('Sauvegarde de l''image best_')+Nom);
      SaveImageGenerique(Directory+'\best_'+Nom,TabImgInt,TabImgDouble,ImgInfos); //nolang
      Inc(l);

      FreememImg(TabImgInt,TabImgDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
//      for k:=1 to ImgInfos.Sy do Freemem(TabImgInt^[1]^[k],2*ImgInfos.Sx);
//      Freemem(TabImgInt^[1],4*ImgInfos.Sy);
//      Freemem(TabImgInt,4);
      end;
   if (Note^[i]>=DSigma) then
      begin
      pop_Rapport.AddLine(lang('Note >= ')+FloatToStr(Round(DSigma*100)/100)
         +lang(' on la rejete'));
      end;
   if (Max^[i]>=SigmaMax) then
      begin
      pop_Rapport.AddLine(lang('Max >= ')+FloatToStr(Round(SigmaMax*100)/100)
         +lang(' on la rejete'));
      end;
   end;

finally
Freemem(PosImage,NbImage*2);
Freemem(Max,NbImage*8);
Freemem(Note,NbImage*8);
Freemem(Moyenne,NbImage*8);
end;
end;

procedure BestOfPlanetaire(Directory:string;
                           ListeImg:TStringList;
                           NbImagesMax:Integer;
                           pop_Rapport:tpop_rapport);
var
TabImgInt:PTabImgInt;
TabImgDouble:PTabImgDouble;
ImgDouble:PImgDouble;
i,j,k,l:Integer;
NbImage:Integer;
ImgInfos:TImgInfos;
DateTimeFinal:TDateTime;
Note,Moyenne:PLigDouble;
PosImage:PLigWord;
DTemp:Double;
WTemp:Word;
Trouve:Boolean;
Nom:string;
begin
pop_Rapport.AddLine(lang('Sélection des meilleures images d''un lot'));

NbImage:=ListeImg.Count;

Getmem(Note,NbImage*8);
Getmem(Moyenne,NbImage*8);
Getmem(PosImage,NbImage*2);

Getmem(ImgDouble,3*4);
for i:=1 to 3 do Getmem(ImgDouble^[i],3*8);

ImgDouble^[1]^[1]:=-1; ImgDouble^[1]^[2]:=-1; ImgDouble^[1]^[3]:=-1;
ImgDouble^[2]^[1]:=-1; ImgDouble^[2]^[2]:=5; ImgDouble^[2]^[3]:=-1;
ImgDouble^[3]^[1]:=-1; ImgDouble^[3]^[2]:=-1; ImgDouble^[3]^[3]:=-1;

try

// Lecture et analyse de toutes les images
for j:=0 to NbImage-1 do
   begin
   pop_Rapport.AddLine('***************************************************************'); //nolang
   // Lecture de l'image
   pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[j]);
   ReadImageGenerique(Directory+'\'+ListeImg.Strings[j],TabImgInt,TabImgDouble,ImgInfos);

   pop_Rapport.AddLine(lang('Mesure de la qualité de l''image ')+ListeImg.Strings[j]);
   // Calcul de la note
   // Passage du filtre
   Matrice(TabImgInt,TabImgDouble,ImgDouble,3,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
   Note^[j+1]:=IntegraleAbs(TabImgInt,TabImgDouble,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
   PosImage^[j+1]:=j;

   for k:=1 to ImgInfos.Sy do Freemem(TabImgInt^[1]^[k],2*ImgInfos.Sx);
   Freemem(TabImgInt^[1],4*ImgInfos.Sy);
   Freemem(TabImgInt,4);
   end;

// Classer les images par note
Trouve:=True;
while Trouve do
   begin
   Trouve:=False;
   for i:=1 to NbImage-1 do
      if Note^[i]>Note^[i+1] then
         begin
         Trouve:=True;
         DTemp:=Note^[i];
         Note^[i]:=Note^[i+1];
         Note^[i+1]:=DTemp;
         WTemp:=PosImage^[i];
         PosImage^[i]:=PosImage^[i+1];
         PosImage^[i+1]:=WTemp;
         end;
   end;

pop_Rapport.AddLine('');

// Renommer
l:=1;
for i:=1 to NbImagesMax do
   begin
   pop_Rapport.AddLine('***************************************************************'); //nolang
   pop_Rapport.AddLine(lang('Image ')+ListeImg.Strings[PosImage^[i]]);
   pop_Rapport.AddLine(lang('Note = ')+FloatToStr(Round(Note^[i]*100)/100));

   pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[PosImage^[i]]);
   ReadImageGenerique(Directory+'\'+ListeImg.Strings[PosImage^[i]],TabImgInt,TabImgDouble,ImgInfos);

   Nom:=GetNomGenerique(ListeImg.Strings[PosImage^[i]])+IntToStr(l);
   pop_Rapport.AddLine(lang('Sauvegarde de l''image best_')+Nom);
   SaveImageGenerique(Directory+'\best_'+Nom,TabImgInt,TabImgDouble,ImgInfos); //nolang
   Inc(l);

   for k:=1 to ImgInfos.Sy do Freemem(TabImgInt^[1]^[k],2*ImgInfos.Sx);
   Freemem(TabImgInt^[1],4*ImgInfos.Sy);
   Freemem(TabImgInt,4);
   end

finally
Freemem(PosImage,NbImage*2);
Freemem(Note,NbImage*8);
Freemem(Moyenne,NbImage*8);

for i:=1 to 3 do Freemem(ImgDouble^[i],3*8);
Freemem(ImgDouble,3*4);
end;
end;

procedure CosmetiqueLot(Directory:string;
                        ListeImg:TStringList;
                        NomCosmetiques:string;
                        pop_Rapport:tpop_rapport);
var
TabImgInt1:PTabImgInt;
TabImgDouble1:PTabImgDouble;
i,j,k:Integer;
NbImage:Integer;
StatMin,Mediane,StatMax,Ecart,Moy:Double;
ImgInfos:TImgInfos;
begin
pop_Rapport.AddLine(lang('Correction cosmétique du lot'));
NbImage:=ListeImg.Count;

for k:=0 to NbImage-1 do
   begin
   ReadImageGenerique(Directory+'\'+ListeImg.Strings[k],TabImgInt1,TabImgDouble1,ImgInfos);

   CorrectionCosmetique(TabImgInt1,TabImgDouble1,ImgInfos.TypeData,ImgInfos.NbPlans,
      ImgInfos.Sx,ImgInfos.Sy,Directory+'\'+NomCosmetiques);

   // On ecrase, tant pis
//   SaveImageGenerique(Directory+'\'+ListeImg.Strings[k],TabImgInt1,TabImgDouble1,ImgInfos);
   SaveImage(Directory+'\'+ListeImg.Strings[k],TabImgInt1,TabImgDouble1,ImgInfos);

   FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
//   for j:=1 to ImgInfos.Sy do Freemem(TabImgInt1^[1]^[j],2*ImgInfos.Sx);
//   Freemem(TabImgInt1^[1],4*ImgInfos.Sy);
//   Freemem(TabImgInt1,4);
   end;
end;

function GetVariance(ImgInt,ImgIntNoir,Carte:PTabImgInt;
                     ImgDouble,ImgDoubleNoir:PTabImgDouble;
                     Sx,Sy:Integer;
                     TypeData:Byte;
                     Gain:Double):Double;
var
i,j:Integer;
Valeur:Double;
ImgIntNil:PTabImgInt;
ImgDouble1:PTabImgDouble;
Moy,Variance,Dx:Double;
Inter,InterQ:Double;
Nb:Longint;
begin
GetmemImg(ImgIntNil,ImgDouble1,Sx,Sy,5,1);

try

// Calcul de l'image
for j:=1 to Sy do
   case TypeData of
      2,7:for i:=1 to Sx do
             if Carte^[1]^[j]^[i]=1 then
                ImgDouble1^[1]^[j]^[i]:=-Gain*ImgIntNoir^[1]^[j]^[i]+ImgInt^[1]^[j]^[i];
      5,8:for i:=1 to Sx do
             if Carte^[1]^[j]^[i]=1 then
                ImgDouble1^[1]^[j]^[i]:=ImgDouble^[1]^[j]^[i]-ImgDoubleNoir^[1]^[j]^[i]*Gain;
      end;

// Calcul de la variance
Inter:=0;
InterQ:=0;
Nb:=0;
for j:=1 to Sy do
   for i:=1 to Sx do
      if Carte^[1]^[j]^[i]=1 then
         begin
         Valeur:=ImgDouble1^[1]^[j]^[i];
         inc(Nb);
         Inter:=Inter+Valeur;
         InterQ:=InterQ+Sqr(Valeur);
         end;

Inter:=Inter/Nb;
InterQ:=InterQ/Nb;
Result:=InterQ-Sqr(Inter);

finally
FreememImg(ImgIntNil,ImgDouble1,Sx,Sy,5,1);
end;
end;

function GetFacteurOptimisationNoir(Image,Noir:PTabImgInt;
                                    ImageDouble,NoirDouble:PTabImgDouble;
                                    ImgInfos:TImgInfos):Double;
var
   Carte:PTabImgInt;
   ImgDoubleNil:PTabImgDouble;
   Sigma,Ref,Min,Max,Somme,Pas,Moy,ValHisto:Double;
   Somme1,Somme2,DVariance,Variance0,Variance1:Double;
   i,j,k,NbMax,x,NbIteration:Integer;
   Hist:array[-32768..32768] of Longint;
   LigDouble:PLigDouble;
   PSF:TPSF;
begin
GetmemImg(Carte,ImgDoubleNil,ImgInfos.Sx,ImgInfos.Sy,2,1);

NbMax:=65537;
Getmem(LigDouble,8*NbMax);
for i:=-32768 to 32768 do Hist[i]:=0;

try

for j:=1 to ImgInfos.Sy do
   case ImgInfos.TypeData of
      2,7:for i:=1 to ImgInfos.Sx do Inc(Hist[Image^[1]^[j]^[i]]);
      5,8:for i:=1 to ImgInfos.Sx do
             begin
             ValHisto:=ImageDouble^[1]^[j]^[i];
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             Inc(Hist[Round(ValHisto)]);
             end;
      end;

for i:=1 to 65537 do LigDouble^[i]:=0;
for i:=-32768 to 32768 do LigDouble^[i+32769]:=Hist[i];
Modelise1D(LigDouble,NbMax,x+32768+1,PSF);

PSF.X:=PSF.X-32769;

Sigma:=PSF.Sigma/2;
Ref:=PSF.X;
Max:=Ref+2*Sigma;
Min:=Ref-2*Sigma;

// Il faut trouver le minimum de la dispersion
// sur le resultat de la difference !
// Creation de la carte de points du ciel
// Rejection en dehors du niveau du ciel
k:=0;
for j:=2 to ImgInfos.Sy-1 do
   case ImgInfos.TypeData of
      2,7:for i:=2 to ImgInfos.Sx-1 do
             if (Image^[1]^[j-1]^[i-1]<Max) and
                (Image^[1]^[j-1]^[i  ]<Max) and
                (Image^[1]^[j-1]^[i+1]<Max) and
                (Image^[1]^[j  ]^[i-1]<Max) and
                (Image^[1]^[j  ]^[i+1]<Max) and
                (Image^[1]^[j+1]^[i-1]<Max) and
                (Image^[1]^[j+1]^[i  ]<Max) and
                (Image^[1]^[j+1]^[i+1]<Max) then
                Carte^[1]^[j]^[i]:=1
             else Carte^[1]^[j]^[i]:=0;
      5,8:for i:=2 to ImgInfos.Sx-1 do
             if (ImageDouble^[1]^[j-1]^[i-1]<Max) and
                (ImageDouble^[1]^[j-1]^[i  ]<Max) and
                (ImageDouble^[1]^[j-1]^[i+1]<Max) and
                (ImageDouble^[1]^[j  ]^[i-1]<Max) and
                (ImageDouble^[1]^[j  ]^[i+1]<Max) and
                (ImageDouble^[1]^[j+1]^[i-1]<Max) and
                (ImageDouble^[1]^[j+1]^[i  ]<Max) and
                (ImageDouble^[1]^[j+1]^[i+1]<Max) then
                Carte^[1]^[j]^[i]:=1
             else Carte^[1]^[j]^[i]:=0;
      end;

{for i:=1 to 200 do
   begin
   Variance0:=GetVariance(Image,Noir,Carte,Sx,Sy,i/500);
   ShowMessage(MyFloatToStr(i/500,3)+'/'+MyFloatToStr(Variance0,3));
   end;}

Min:=0;
Max:=30;
Pas:=0.01;
// Si le minimum est entre 0 et 30
if (GetVariance(Image,Noir,Carte,ImageDouble,NoirDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,Min+Pas)
   <GetVariance(Image,Noir,Carte,ImageDouble,NoirDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,Min))
   and (GetVariance(Image,Noir,Carte,ImageDouble,NoirDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,Max-Pas)
   <GetVariance(Image,Noir,Carte,ImageDouble,NoirDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,Max)) then
   begin
   NbIteration:=1;
   DVariance:=1;
   Moy:=(Min+Max)/2;
   Variance0:=GetVariance(Image,Noir,Carte,ImageDouble,NoirDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,Moy);
   if GetVariance(Image,Noir,Carte,ImageDouble,NoirDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,Moy-Pas)-Variance0<0 then
      Max:=Moy
   else
      Min:=Moy;

   // On itere tant que le pas est grand ou que le maxi est atteint
   while (DVariance>0.01) and (NbIteration<500) do
      begin
      Inc(NbIteration);
      Moy:=(Min+Max)/2;
      Variance1:=GetVariance(Image,Noir,Carte,ImageDouble,NoirDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,Moy);
      if GetVariance(Image,Noir,Carte,ImageDouble,NoirDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,Moy-Pas)-Variance1<0 then
         Max:=Moy
      else
         Min:=Moy;
      DVariance:=Abs(Variance1-Variance0);
      Variance0:=Variance1;
      end;

   if NbIteration<>500 then Result:=Moy else Result:=1;
   end
else Result:=1;

finally
Freemem(LigDouble,8*NbMax);
FreememImg(Carte,ImgDoubleNil,ImgInfos.Sx,ImgInfos.Sy,2,1);
end;

end;

procedure PretraiteLot(Directory:string;
                       ListeImg:TStringList;
                       ConfigPretraitements:TConfigPretraitements;
                       pop_Rapport:tpop_rapport);
var
StatMin,Mediane,StatMax,Moy,Ecart:Double;
i:Integer;
ImgInfos:TImgInfos;
ImgOffset,ImgNoir,ImgNoirOptimisee,ImgFlat,Image:PTabImgInt;
ImgOffsetDouble,ImgNoirDouble,ImgNoirOptimiseeDouble,ImgFlatDouble,ImageDouble:PTabImgDouble;
ListeImagesTraites:TStringList;
ListeImagesSupp:TStringList;
LocalNomOffset,LocalNomNoir,LocalNomFlat,Ext:string;
SB1,SH1,FacteurOptimise:Double;
TraiteOffset,TraiteNoir,TraiteFlat:Boolean;
NbPlan:Byte;
begin
pop_Rapport.AddLine(lang('Prétraitement du lot'));
pop_Rapport.AddLine(' ');

Ext:=ExtractFileExt(ListeImg[0]);

ClasseListe(ListeImg);

// Juste pour avoir Sx et Sy
ReadImageGenerique(ListeImg.Strings[0],Image,ImageDouble,ImgInfos);
//ReadHeader(Directory+'\'+ListeImg.Strings[0],ImgInfos);

//GetmemImg(ImgOffset,ImgOffsetDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
//GetmemImg(ImgNoir,ImgNoirDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
//GetmemImg(ImgFlat,ImgFlatDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NBPlans);
//GetmemImg(Image,ImageDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NBPlans);

ListeImagesTraites:=TStringList.Create;
ListeImagesSupp:=TStringList.Create;

// Les images de flat/noir/Offset existent elle deja
//LocalNomOffset:=ChangeExtToGenerique(ConfigPretraitements.NomOffset,2);
//LocalNomNoir:=ChangeExtToGenerique(ConfigPretraitements.NomNoir,2);
//LocalNomFlat:=ChangeExtToGenerique(ConfigPretraitements.NomFlat,2);
LocalNomOffset:=ConfigPretraitements.NomOffset+Ext;
LocalNomNoir:=ConfigPretraitements.NomNoir+Ext;
LocalNomFlat:=ConfigPretraitements.NomFlat+Ext;

if FileExists(LocalNomOffset) then TraiteOffset:=True
else
   begin
   pop_Rapport.AddLine('L''image d''offset '+LocalNomOffset+' n''existe pas');
   pop_Rapport.AddLine('Pas de correction d''offset');
   end;
if FileExists(LocalNomNoir) then TraiteNoir:=True
else
   begin
   pop_Rapport.AddLine('L''image de noir '+LocalNomNoir+' n''existe pas');
   pop_Rapport.AddLine(lang('Pas de correction du noir'));
   end;
if FileExists(LocalNomFlat) then TraiteFlat:=True
else
   begin
   pop_Rapport.AddLine('L''image de flat '+LocalNomFlat+' n''existe pas');
   pop_Rapport.AddLine(lang('Pas de correction du flat'));
   end;

if not TraiteOffset and not TraiteNoir and not TraiteFlat then
   begin
   pop_Rapport.AddLine('');
   pop_Rapport.AddLine(lang('Erreur'));
   pop_Rapport.AddLine(lang('Aucune image de correction trouvée'));
   pop_Rapport.AddLine(lang('Arrêt du traitement'));
   Exit;
   end;

if TraiteNoir then
   if Config.ConfigPretrait.OptimiseNoir then
      GetmemImg(ImgNoirOptimisee,ImgNoirOptimiseeDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NBPlans);

try
if TraiteOffset then
   ReadImageGenerique(LocalNomOffset,ImgOffset,ImgOffsetDouble,ImgInfos);
if TraiteNoir then
   ReadImageGenerique(LocalNomNoir,ImgNoir,ImgNoirDouble,ImgInfos);
if TraiteFlat then
   ReadImageGenerique(LocalNomFlat,ImgFlat,ImgFlatDouble,ImgInfos);

// On enleve l'offset aux images
for i:=0 to ListeImg.Count-1 do
   begin
   pop_Rapport.AddLine('');
   pop_Rapport.AddLine('Prétraitement de l''image : '+ListeImg.Strings[i]);
   ReadImageGenerique(ListeImg.Strings[i],Image,ImageDouble,ImgInfos);
   // ****** Partie Offset ******
   if TraiteOffset then
      begin
      pop_Rapport.AddLine('Soustraction de l''offset : '+LocalNomOffset);
      Soust(Image,ImgOffset,ImageDouble,ImgOffsetDouble,ImgInfos.TypeData,ImgInfos.NbPlans,
         ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Sx,ImgInfos.Sy);
      end;
   // ****** Partie Noir ******
   if TraiteNoir then
      begin
      // On optimise si demande
      if Config.ConfigPretrait.OptimiseNoir then
         begin
         pop_Rapport.AddLine(lang('Optimisation du noir'));
         FacteurOptimise:=GetFacteurOptimisationNoir(Image,ImgNoir,ImageDouble,ImgNoirDouble,ImgInfos);
         pop_Rapport.AddLine('Facteur d''Optimisation = '+MyFloatToSTr(FacteurOptimise,3));
         Transfert(ImgNoir,ImgNoirOptimisee,ImgNoirDouble,ImgNoirOptimiseeDouble,
            ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy);
         Gain(ImgNoirOptimisee,ImgNoirOptimiseeDouble,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,
            ImgInfos.Sy,FacteurOptimise);
         pop_Rapport.AddLine(lang('Soustraction du noir : ')+LocalNomNoir);
         Soust(Image,ImgNoirOptimisee,ImageDouble,ImgNoirOptimiseeDouble,ImgInfos.TypeData,ImgInfos.NbPlans,
            ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Sx,ImgInfos.Sy);
         end
      else
         begin
         pop_Rapport.AddLine(lang('Soustraction du noir : ')+LocalNomNoir);
         Soust(Image,ImgNoir,ImageDouble,ImgNoirDouble,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,
            ImgInfos.Sy,ImgInfos.Sx,ImgInfos.Sy);
         end;
      end;
   // ****** Partie Flat ******
   if TraiteFlat then
      begin
      pop_Rapport.AddLine(lang('Correction du flat : ')+LocalNomFlat);
      Statistiques(ImgFlat,ImgFlatDouble,ImgInfos.TypeData,ImgInfos.NBPlans,ImgInfos.Sx,ImgInfos.Sy,
         1,StatMin,Mediane,StatMax,Moy,Ecart);
      Divi(Image,ImgFlat,ImageDouble,ImgFlatDouble,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,
         ImgInfos.Sy,ImgInfos.Sx,ImgInfos.Sy,Moy);
      end;
   // ****** Cosmetiques ******
   if ConfigPretraitements.CorrigeCosmetique then
      if FileExists(ConfigPretraitements.NomCosmetiques) then
         begin
         pop_Rapport.AddLine(lang('Correction cosmétique : ')+ConfigPretraitements.NomCosmetiques);
         CorrectionCosmetique(Image,ImageDouble,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,
            Directory+'\'+ConfigPretraitements.NomCosmetiques);
         end;

   // Mise a jour auto des seuils
   RechercheSeuils(Image,ImageDouble,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,
      1,config.SeuilBasPourCent,config.SeuilHautPourCent,SB1,SH1);

   if SB1=SH1 then
      begin
      SB1:=SB1-1;
      SH1:=SH1+1;
      end;

   ImgInfos.min[1]:=SB1;
   ImgInfos.max[1]:=SH1;

   pop_Rapport.AddLine(lang('Sauvegarde de l''image ')
      +'cal_'+ListeImg.Strings[i]); //nolang
//   SaveImageGenerique(Directory+'\cal_'+ListeImg.Strings[i],Image,ImageDouble,ImgInfos); //nolang
   SaveImage(Directory+'\cal_'+ListeImg.Strings[i],Image,ImageDouble,ImgInfos); //nolang
   FreememImg(Image,ImageDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
   end;

pop_Rapport.AddLine('');
pop_Rapport.AddLine(lang('Fin des prétraitements'));

finally
if TraiteOffset then
   FreememImg(ImgOffset,ImgOffsetDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
if TraiteNoir then
   begin
   FreememImg(ImgNoir,ImgNoirDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
   if Config.ConfigPretrait.OptimiseNoir then
      FreememImg(ImgNoirOptimisee,ImgNoirOptimiseeDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
   end;
if TraiteFlat then
   FreememImg(ImgFlat,ImgFlatDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
end;

end;

procedure SoustOptimiseLot(Directory:string;
                           ImgNoir:PTabImgInt;
                           ImgNoirDouble:PTabImgDouble;
                           SxIn,SyIn:Integer;
                           TypeDataIn,NbPlansIn:Byte;
                           ListeImgIn:TStringList;
                           pop_Rapport:tpop_rapport);
var
TabImgInt1,ImgNoirOptimisee:PTabImgInt;
TabImgDouble1,ImgNoirOptimiseeDouble:PTabImgDouble;
j,k:Integer;
NbImage:Integer;
StatMin,Mediane,StatMax,Moy,Ecart:Double;
ImgInfos:TImgInfos;
FacteurOptimise:Double;
Ext:string;
begin
Ext:=ExtractFileExt(ListeImgIn.Strings[0]);

try
pop_Rapport.AddLine(lang('Optimisation du noir'));

NbImage:=ListeImgIn.Count;

// Lecture et soustraction de toutes les images
//if Config.TypeSaveFits=1 then
//   begin
//   ImgInfosNoir.TypeData:=TypeDataInNoir;
//   ImgInfosNoir.NbPlans:=NbPlansInNoir;
//   ImgInfosNoir.Sx:=SxIn;
//   ImgInfosNoir.Sy:=SyIn;
//   ConvertFITSRealToInt(ImgNoirDouble,ImgNoir,ImgInfosNoir);
//   end;

GetmemImg(ImgNoirOptimisee,ImgNoirOptimiseeDouble,SxIn,SyIn,TypeDataIn,NbPlansIn);

for j:=0 to NbImage-1 do
   begin
   pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImgIn.Strings[j]);
   ReadImageGenerique(Directory+'\'+ListeImgIn.Strings[j],TabImgInt1,TabImgDouble1,ImgInfos);
   if (ImgInfos.Sx<>SxIn) or (ImgInfos.Sy<>SyIn) then
      begin
      pop_Rapport.AddLine(lang('Erreur : Dimensions des images différentes '));
      Exit;
      end;
   FacteurOptimise:=GetFacteurOptimisationNoir(TabImgInt1,ImgNoir,TabImgDouble1,ImgNoirDouble,ImgInfos);
   pop_Rapport.AddLine('Facteur d''Optimisation = '+MyFloatToSTr(FacteurOptimise,3));
   pop_Rapport.AddLine(lang('Soustraction de l''image à ')+ListeImgIn.Strings[j]);
   Transfert(ImgNoir,ImgNoirOptimisee,ImgNoirDouble,ImgNoirOptimiseeDouble,ImgInfos.TypeData,ImgInfos.NbPlans,
      ImgInfos.Sx,ImgInfos.Sy);
   Gain(ImgNoirOptimisee,ImgNoirOptimiseeDouble,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,FacteurOptimise);
   pop_Rapport.AddLine(lang('Soustraction du noir'));
   Soust(TabImgInt1,ImgNoirOptimisee,TabImgDouble1,ImgNoirOptimiseeDouble,ImgInfos.TypeData,ImgInfos.NbPlans,
      ImgInfos.Sx,ImgInfos.Sy,ImgInfos.Sx,ImgInfos.Sy);

//        Soust(TabImgInt1,Image,TabImgDouble1,TabImgDouble2,2,1,Sx,Sy,SxIn,SyIn);
   pop_Rapport.AddLine('Sauvegarde de l''image '+'\sub_'+ListeImgIn.Strings[j]); //nolang
//   SaveImageGenerique(Directory+'\sub_'+ListeImgIn.Strings[j],TabImgInt1,TabImgDouble1,ImgInfos); //nolang
   SaveImage(Directory+'\sub_'+ListeImgIn.Strings[j],TabImgInt1,TabImgDouble1,ImgInfos); //nolang
   end;

FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);

finally
GetmemImg(ImgNoirOptimisee,ImgNoirOptimiseeDouble,SxIn,SyIn,TypeDataIn,NbPlansIn);
end;

end;

function RecaleEtoileLot(Directory:string;
                         ListeImg:TStringList;
                         ErrorMax:Double;
                         pop_Rapport:tpop_rapport;
                         IsASerie:Boolean):Boolean;
var
TabImgInt1,TabImgInt2:PTabImgInt;
TabImgDouble1,TabImgDouble2:PTabImgDouble;
ImgDoubleNil:PTabImgDouble;

i,j,k,l,n:Integer;
NbImage:Integer;
arrdetections_A,arrdetections_B:plistepsf;
ndetect_a,ndetect_B:integer;
Error:Byte;
gagnants:tlist;
m:P_Matcher;
NbStar:Integer;
ValDouble,Dx,Dy,DDx,DDy:Double;
ValInt:SmallInt;

x,y,x1,x2,sigx,sigy:PLigDouble;
a,b:DoubleArrayRow;
covara,covarb:DoubleArray;
chisqa,chisqb:Double;
degre:Integer;
ImgInfos:TImgInfos;
DateTimeFinal:TDateTime;
ListeImgFinal:TStringList;
NomGenerique,Ext:string;
ErrorRecal:Double;
begin
Result:=True;
pop_Rapport.AddLine(lang('Recalage d''un lot'));

Ext:=ExtractFileExt(ListeImg.Strings[0]);
NomGenerique:=GetNomGenerique(ListeImg.Strings[0]);
NbImage:=ListeImg.Count;
n:=1;

ListeImgFinal:=TStringList.Create;
try

// Lecture de la premiere image
pop_Rapport.AddLine(lang('Lecture de l''image de référence : ')+ListeImg.Strings[0]);
ReadImageGenerique(Directory+'\'+ListeImg.Strings[0],TabImgInt1,TabImgDouble1,ImgInfos);
// On sauvegarde la premiere image
//SaveImageGenerique(Directory+'\rec_'+NomGenerique+IntToStr(n),TabImgInt1,TabImgDouble1,ImgInfos); //nolang
if IsASerie then
   begin
   pop_Rapport.AddLine(lang('Sauvegarde de l''image ')+
      '\rec_'+NomGenerique+IntToStr(n)+Ext); //nolang
//   SaveImageGenerique(Directory+'\rec_'+NomGenerique+IntToStr(n),TabImgInt1,TabImgDouble1, //nolang
//      ImgInfos);
   SaveImage(Directory+'\rec_'+NomGenerique+IntToStr(n)+Ext,TabImgInt1,TabImgDouble1, //nolang
      ImgInfos);
//   ListeImgFinal.Add(ChangeExtToGenerique('rec_'+NomGenerique+IntToStr(n),ImgInfos.TypeData)); //nolang
   ListeImgFinal.Add('rec_'+NomGenerique+IntToStr(n)+Ext); //nolang
   end
else
   begin
   pop_Rapport.AddLine(lang('Sauvegarde de l''image ')+
      '\rec_'+ListeImg.Strings[0]+Ext); //nolang
//   SaveImageGenerique(Directory+'\rec_'+ListeImg.Strings[0],TabImgInt1,TabImgDouble1, //nolang
//      ImgInfos);
   SaveImage(Directory+'\rec_'+ListeImg.Strings[0]+Ext,TabImgInt1,TabImgDouble1, //nolang
      ImgInfos);
//   ListeImgFinal.Add(ChangeExtToGenerique('rec_'+ListeImg.Strings[0],ImgInfos.TypeData)); //nolang
   ListeImgFinal.Add('rec_'+ListeImg.Strings[0]+Ext); //nolang
   end;

pop_Rapport.AddLine(lang('Modélisation des étoiles de l''image '));
ModeliseSources(TabImgInt1,TabImgDouble1,ImgInfos.TypeData,ImgInfos.NBPlans,ImgInfos.Sx,ImgInfos.Sy,9,arrdetections_A,TGauss,
//   LowPrecision,HighSelect,ndetect_A,15,False,'',False);
   LowPrecision,LowSelect,ndetect_A,15,False,'',False);
pop_Rapport.AddLine(lang('Nombres des étoiles de l''image : ')+IntToStr(ndetect_A));

if NDetect_A<3 then
   begin
   pop_Rapport.AddLine(lang('Pas assez d''étoiles dans l''image')+ListeImg.Strings[0]);
   FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
   Result:=False;
   Exit;
   end;

FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);

// Lecture et recalage de toutes les images
for j:=1 to NbImage-1 do
   begin
   // Lecture de l'image
   pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[j]);
   ReadImageGenerique(Directory+'\'+ListeImg.Strings[j],TabImgInt2,TabImgDouble2,ImgInfos);

   pop_Rapport.AddLine(lang('Modélisation des étoiles de l''image '));
   modelisesources(TabImgInt2,TabImgDouble2,ImgInfos.TypeData,ImgInfos.NBPlans,ImgInfos.Sx,ImgInfos.Sy,9,arrdetections_B,
      TGauss,LowPrecision,LowSelect,ndetect_B,15,false,'',False);
//      TGauss,LowPrecision,HighSelect,ndetect_B,15,false,'',False);
   pop_Rapport.AddLine(lang('Nombres des étoiles de l''image : ')+IntToStr(ndetect_B));

   if NDetect_B<3 then
      begin
      pop_Rapport.AddLine(lang('Pas assez d''étoiles dans l''image')+ListeImg.Strings[j]);
      FreememImg(TabImgInt2,TabImgDouble2,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
      Error:=4;
      end
   else
      begin
      try

      // Matching
      pop_Rapport.AddLine(lang('Mise en correspondance des étoiles'));
      Error:=MatchMarty(arrdetections_A,arrdetections_B,ndetect_A,ndetect_B,40,Gagnants,pop_Rapport);

      finally
      Freemem(arrdetections_B,ndetect_B*Sizeof(TPSF));
      end;
      end;

   if Error=5 then pop_Rapport.AddLine(lang('Correspondance entre étoiles non trouvée'));
   if Gagnants.Count<3 then
      begin
      pop_Rapport.AddLine(lang('Pas assez d''étoiles en correspondance'));
      Error:=6;
      end;
   if Error<>0 then pop_Rapport.AddLine(lang('Image ')+ListeImg.Strings[j]+
      lang(' Ignorée'));

   if Error=0 then
      begin
      NbStar:=Gagnants.Count;
      pop_Rapport.AddLine(IntToStr(NbStar)+lang(' étoiles en correspondance'));

      Getmem(x,8*NbStar);
      Getmem(y,8*NbStar);
      Getmem(x1,8*NbStar);
      Getmem(x2,8*NbStar);
      Getmem(Sigx,8*NbStar);
      Getmem(Sigy,8*NbStar);

      try

      // Changement de forme des donnees
      for i:=0 to NbStar-1 do
         begin
         m:=Gagnants[i];
         x1^[i+1]:=m.ref_x;
         x2^[i+1]:=m.ref_y;
         x^[i+1]:=m.det_x;
         y^[i+1]:=m.det_y;
         sigx^[i+1]:=m.det_dx;
         sigy^[i+1]:=m.det_dy;
         end;

      for i:=0 to Gagnants.Count-1 do
         begin
         m:=Gagnants.Items[i];
         Dispose(m);
         end;

//      Degre:=0;

      // Calcul du polynome de passage en X
      pop_Rapport.AddLine(lang('Calcul du pôlynome de passage en X'));
//      lfitAstro(x1,x2,x,sigx,NbStar,a,covara,chisqa,degre);
      lfitLin(x1,x,sigx,NbStar,a,covara,chisqa);
      // Calcul du polynome de passage en Y
      pop_Rapport.AddLine(lang('Calcul du pôlynome de passage en Y'));
//      lfitAstro(x1,x2,y,sigy,NbStar,b,covarb,chisqb,degre);
      lfitLin(x2,y,sigx,NbStar,b,covarb,chisqb);

      Dx:=-a[1];
      DDx:=Sqrt(Abs(Covara[1,1])*Chisqa/NbStar);
      Dy:=-b[1];
      DDy:=Sqrt(Abs(Covarb[1,1])*Chisqb/NbStar);

      pop_Rapport.AddLine(Format(lang('Déplacement en X : Dx = %4.2f +/- %5.3f'),[Dx,DDx]));
      pop_Rapport.AddLine(Format(lang('Déplacement en Y : Dy = %4.2f +/- %5.3f'),[Dy,DDy]));

      finally
      Freemem(x,8*NbStar);
      Freemem(y,8*NbStar);
      Freemem(x1,8*NbStar);
      Freemem(x2,8*NbStar);
      Freemem(Sigx,8*NbStar);
      Freemem(Sigy,8*NbStar);
      end;

      ErrorRecal:=Sqrt(Sqr(DDx)+Sqr(DDy));
      if ErrorRecal<ErrorMax then
         begin
         pop_Rapport.AddLine(lang('Erreur = ')+FloatToStr(Round(ErrorRecal*1000)/1000)+
            ' < '+ //nolang
            lang('Erreur max = ')+FloatToStr(Round(ErrorMax*1000)/1000));
         // Translation de l'image
         pop_Rapport.AddLine(lang('Translation de l''image ')+ListeImg.Strings[j]);
         Translation(TabImgInt2,TabImgDouble2,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NBPlans,Dx,Dy);

         // On sauvegarde
         Inc(n);
//         SaveImageGenerique(Directory+'\rec_'+NomGenerique+IntToStr(n),TabImgInt2,TabImgDouble2, //nolang
//            ImgInfos);
         if IsASerie then
            begin
            pop_Rapport.AddLine(lang('Sauvegarde de l''image ')+
               '\rec_'+NomGenerique+IntToStr(n)+Ext); //nolang
//            SaveImageGenerique(Directory+'\rec_'+NomGenerique+IntToStr(n)+Ext,TabImgInt2,TabImgDouble2, //nolang
//               ImgInfos);
            SaveImage(Directory+'\rec_'+NomGenerique+IntToStr(n)+Ext,TabImgInt2,TabImgDouble2, //nolang
               ImgInfos);
//            ListeImgFinal.Add(ChangeExtToGenerique('rec_'+NomGenerique+IntToStr(n)+Ext,ImgInfos.TypeData)); //nolang
            ListeImgFinal.Add('rec_'+NomGenerique+IntToStr(n)+Ext); //nolang
            end
         else
            begin
            pop_Rapport.AddLine(lang('Sauvegarde de l''image ')+
               '\rec_'+ListeImg.Strings[j]+Ext); //nolang
//            SaveImageGenerique(Directory+'\rec_'+ListeImg.Strings[j]+Ext,TabImgInt2,TabImgDouble2, //nolang
//               ImgInfos);
            SaveImage(Directory+'\rec_'+ListeImg.Strings[j]+Ext,TabImgInt2,TabImgDouble2, //nolang
               ImgInfos);
            ListeImgFinal.Add(ChangeExtToGenerique('rec_'+ListeImg.Strings[j]+Ext,ImgInfos.TypeData)); //nolang
            ListeImgFinal.Add('rec_'+ListeImg.Strings[j]+Ext); //nolang
            end;
         end
      else
         begin
         pop_Rapport.AddLine(lang('Erreur = ')+FloatToStr(Round(ErrorRecal*1000)/1000)+
            ' > '+ //nolang
            lang('Erreur max = ')+FloatToStr(Round(ErrorMax*1000)/1000));
         pop_Rapport.AddLine(lang('Image ')+ListeImg.Strings[j]
            +lang(' ignorée'));
         Error:=7;
         end;

      FreememImg(TabImgInt2,TabImgDouble2,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
      end;
   end;

// Copie de la nouvelle liste dans la liste d'entree
ListeImg.Clear;
for i:=0 to ListeImgFinal.Count-1 do ListeImg.Add(ListeImgFinal.Strings[i]);

pop_Rapport.AddLine(lang('Recalage effectué'))

finally
ListeImgFinal.Free;
Freemem(arrdetections_A,ndetect_A*Sizeof(TPSF));
end;
end;


procedure RecalePlanetLot(Directory:string;
                          ListeImg:TStringList;
                          pop_Rapport:tpop_rapport;
                          IsASerie:Boolean);
var
TabImgInt,TabImgInt1:PTabImgInt;
TabImgDouble,TabImgDouble1:PTabImgDouble;
ImgFFT,ImgFFT1,ImgFFT2:PTabImgDouble;
i,j,k,l,m,n:Integer;
ValDouble:Double;
NbImage:Integer;
Maxi,Mini,Mediane1,Mediane2,Moy,Ecart:Double;
SFFT,SFFT2:Integer;
a1,b1,a2,b2,Module:Double;
x,y:Integer;
ValMax:Double;
ImgIntNil:PTabImgInt;
ImgDouble:PTabImgDouble;
PSF:TPSF;
TmpSx,TmpSy:Integer;
ImgInfos:TImgInfos;
Dx,DDx,Dy,DDy:Double;
ImgDoubleNil:PTabImgDouble;

ListeImgFinal:TStringList;
NomGenerique,Ext:string;
begin
NbImage:=ListeImg.Count;
Ext:=ExtractFileExt(ListeImg.Strings[0]);
NomGenerique:=GetNomGenerique(ListeImg.Strings[0]);
ListeImgFinal:=TStringList.Create;

pop_Rapport.AddLine(lang('Recalage planétaire du lot'));

try

// On lit la premiere image
pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[0]);
ReadImageGenerique(Directory+'\'+ListeImg.Strings[0],TabImgInt1,TabImgDouble1,ImgInfos);
// On sauvegarde la premiere image
n:=1;
//pop_Rapport.AddLine(lang('Sauvegarde de l''image ')+
//   '\rec_'+ListeImg.Strings[0]); //nolang
if IsASerie then
   begin
   pop_Rapport.AddLine(lang('Sauvegarde de l''image ')+
      '\rec_'+NomGenerique+IntToStr(n)+Ext); //nolang
//   SaveImageGenerique(Directory+'\rec_'+NomGenerique+IntToStr(n)+Ext,TabImgInt1,TabImgDouble1,//nolang
//      ImgInfos);
   SaveImage(Directory+'\rec_'+NomGenerique+IntToStr(n)+Ext,TabImgInt1,TabImgDouble1,//nolang
      ImgInfos);
   ListeImgFinal.Add(ChangeExtToGenerique('rec_'+NomGenerique+IntToStr(n)+Ext,ImgInfos.TypeData)); //nolang
   end
else
   begin
   pop_Rapport.AddLine(lang('Sauvegarde de l''image ')+
      '\rec_'+ListeImg.Strings[0]+Ext); //nolang
//   SaveImageGenerique(Directory+'\rec_'+ListeImg.Strings[0]+Ext,TabImgInt1,TabImgDouble1, //nolang
//     ImgInfos);
   SaveImage(Directory+'\rec_'+ListeImg.Strings[0]+Ext,TabImgInt1,TabImgDouble1, //nolang
      ImgInfos);
   ListeImgFinal.Add(ChangeExtToGenerique('rec_'+ListeImg.Strings[0]+Ext,ImgInfos.TypeData)); //nolang
   end;

// On enleve le fond du ciel de l'image 1
pop_Rapport.AddLine(lang('Soustraction du ciel de l''image ')+ListeImg.Strings[0]);
Statistiques(TabImgInt1,TabImgDouble1,ImgInfos.TypeData,1,ImgInfos.Sx,ImgInfos.Sy,1,Mini,Mediane1,Maxi,Moy,Ecart);
Offset(TabImgInt1,TabImgDouble1,ImgInfos.TypeData,1,ImgInfos.Sx,ImgInfos.Sy,-Mediane1);

// On fait la FFT de l'image 1
pop_Rapport.AddLine(lang('FFT de l''image ')+ListeImg.Strings[0]);
TmpSx:=ImgInfos.Sx;
TmpSy:=ImgInfos.Sy;
FFTDirect(TabImgInt1,TabImgDouble1,ImgInfos.TypeData,ImgFFT,TmpSx,TmpSy);
SFFT:=TmpSx;

GetmemImg(TabImgInt,TabImgDouble,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);

FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);

for k:=1 to NbImage-1 do
   begin
   // On lit l'image suivante
   pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[k]);
   ReadImageGenerique(Directory+'\'+ListeImg.Strings[k],TabImgInt1,TabImgDouble1,ImgInfos);

   // On enleve le fond du ciel de l'image
   pop_Rapport.AddLine(lang('Soustraction du ciel de l''image ')+ListeImg.Strings[k]);
   Statistiques(TabImgInt1,TabImgDouble1,ImgInfos.TypeData,1,ImgInfos.Sx,ImgInfos.Sy,1,Mini,Mediane1,Maxi,Moy,Ecart);
   Offset(TabImgInt1,TabImgDouble1,ImgInfos.TypeData,1,ImgInfos.Sx,ImgInfos.Sy,-Mediane1);

   // On fait la FFT de l'image
   pop_Rapport.AddLine(lang('FFT de l''image ')+ListeImg.Strings[k]);
   TmpSx:=ImgInfos.Sx;
   TmpSy:=ImgInfos.Sy;
   FFTDirect(TabImgInt1,TabImgDouble1,ImgInfos.TypeData,ImgFFT2,TmpSx,TmpSy);

   Offset(TabImgInt1,TabImgDouble1,ImgInfos.TypeData,1,ImgInfos.Sx,ImgInfos.Sy,Mediane1);

   Getmem(ImgFFT1,4*2);
   for l:=1 to 2 do
      begin
      Getmem(ImgFFT1^[l],SFFT*4);
      for m:=1 to SFFT do Getmem(ImgFFT1^[l]^[m],SFFT*8);
      end;

   // On intercorrele
   pop_Rapport.AddLine(lang('Calcul du produit d''intercorrélation'));
   for j:=1 to SFFT do
      for i:=1 to SFFT do
         begin
         a1:=ImgFFT^[1]^[j]^[i];
         b1:=ImgFFT^[2]^[j]^[i];
         a2:=ImgFFT2^[1]^[j]^[i];
         b2:=ImgFFT2^[2]^[j]^[i];
         Module:=Sqrt((Sqr(a1)+Sqr(b1))*(Sqr(a2)+Sqr(b2)));
         if Module=0 then Module:=1e-20;
         ImgFFT1^[1]^[j]^[i]:=(a1*a2+b1*b2)/Module;
         ImgFFT1^[2]^[j]^[i]:=(a2*b1-a1*b2)/Module;
         end;
   FFTInverse(ImgFFT1,SFFT,SFFT);
   PermuteQuadrants(ImgIntNil,ImgFFT1,5,1,SFFT,SFFT);

   // On supprimme le pixel central qui correspond en general aux poussieres
//   ImgFFT1^[1]^[SFFT div 2+1]^[SFFT div 2+1]:=0;
   SFFT2:=SFFT div 2;
   ImgFFT1^[1]^[SFFT2+1]^[SFFT2+1]:=(ImgFFT1^[1]^[SFFT2  ]^[SFFT2+2]+
                                     ImgFFT1^[1]^[SFFT2  ]^[SFFT2+1]+
                                     ImgFFT1^[1]^[SFFT2  ]^[SFFT2  ]+
                                     ImgFFT1^[1]^[SFFT2+2]^[SFFT2+2]+
                                     ImgFFT1^[1]^[SFFT2+2]^[SFFT2+1]+
                                     ImgFFT1^[1]^[SFFT2+2]^[SFFT2  ]+
                                     ImgFFT1^[1]^[SFFT2+1]^[SFFT2  ]+
                                     ImgFFT1^[1]^[SFFT2+1]^[SFFT2+2])/8;

   // On lisse car le pic peut etre trop pointu pour une modélisation gaussienne
   Gaussienne(ImgIntNil,ImgFFT1,5,1,SFFT,SFFT,1);

   // On cherche le pic max
   GetMax(nil,ImgFFT1,5,SFFT,SFFT,x,y,ValMax);

   // On modelise le pic
   if (x<10) or (y<10) or (x>SFFT-9) or (y>SFFT-9) then
      begin
      pop_Rapport.AddLine('Pic d''intercorrelation introuvable');
      raise ErrorRecalage.Create('Pic d''intercorrelation introuvable');
      end;
   GetImgPart(nil,ImgFFT1,ImgIntNil,ImgDouble,5,1,SFFT,SFFT,x-9,y-9,x+9,y+9);
//   ModeliseEtoile(nil,ImgDouble,5,2*9+1,10,10,TGaussEllipse,HighPrecision,LowSelect,2,PSF);
   ModeliseEtoile(nil,ImgDouble,5,2*9+1,TGaussEllipse,HighPrecision,LowSelect,2,PSF);
   FreeMemImg(ImgIntNil,ImgDouble,19,19,5,1);
   if PSF.Flux=-1 then
      begin
      pop_Rapport.AddLine(lang('Impossible de modéliser le pic d''intercorrélation'));
      raise ErrorRecalage.Create(lang('Impossible de modéliser le pic d''intercorrélation'));
      end;

   for j:=1 to SFFT do Freemem(ImgFFT1^[1]^[j],8*SFFT);
   Freemem(ImgFFT1^[1],4*SFFT);
   Freemem(ImgFFT1,8);

   Dx:=x-10+PSF.X-(SFFT div 2+1);
   DDx:=PSF.DX;
   Dy:=y-10+PSF.Y-(SFFT div 2+1);
   DDy:=PSF.DY;
   pop_Rapport.AddLine(Format(lang('Déplacement en X : Dx = %4.2f +/- %5.3f'),[Dx,DDx]));
   pop_Rapport.AddLine(Format(lang('Déplacement en Y : Dy = %4.2f +/- %5.3f'),[Dy,DDy]));


   // On translate pour recadrer
   pop_Rapport.AddLine(lang('Translation de l''image ')+ListeImg.Strings[k]);
   Translation(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans,Dx,Dy);

   // On sauvegarde
   Inc(n);
//   pop_Rapport.AddLine(lang('Sauvegarde de l''image ')+
//      '\rec_'+ListeImg.Strings[k]); //nolang
   if IsASerie then
      begin
      pop_Rapport.AddLine(lang('Sauvegarde de l''image ')+
         '\rec_'+NomGenerique+IntToStr(n)+Ext); //nolang
//      SaveImageGenerique(Directory+'\rec_'+NomGenerique+IntToStr(n)+Ext,TabImgInt1,TabImgDouble1, //nolang
//         ImgInfos);
      SaveImage(Directory+'\rec_'+NomGenerique+IntToStr(n)+Ext,TabImgInt1,TabImgDouble1, //nolang
         ImgInfos);
      ListeImgFinal.Add(ChangeExtToGenerique('rec_'+NomGenerique+IntToStr(n)+Ext,ImgInfos.TypeData)); //nolang
      end
   else
      begin
      pop_Rapport.AddLine(lang('Sauvegarde de l''image ')+
         '\rec_'+ListeImg.Strings[k]+Ext); //nolang
//      SaveImageGenerique(Directory+'\rec_'+ListeImg.Strings[k]+Ext,TabImgInt1,TabImgDouble1, //nolang
//         ImgInfos);
      SaveImage(Directory+'\rec_'+ListeImg.Strings[k]+Ext,TabImgInt1,TabImgDouble1, //nolang
         ImgInfos);
      ListeImgFinal.Add(ChangeExtToGenerique('rec_'+ListeImg.Strings[k]+Ext,ImgInfos.TypeData)); //nolang
      end;


   FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
   end;

// Copie de la nouvelle liste dans la liste d'entree
ListeImg.Clear;
for i:=0 to ListeImgFinal.Count-1 do ListeImg.Add(ListeImgFinal.Strings[i]);

pop_Rapport.AddLine(lang('Recalage effectué'))

finally
ListeImgFinal.Free;

for k:=1 to 2 do
   begin
   for j:=1 to SFFT do Freemem(ImgFFT^[k]^[j],8*SFFT);
   Freemem(ImgFFT^[k],4*SFFT);
   end;
Freemem(ImgFFT,8);

for k:=1 to 2 do
   begin
   for j:=1 to SFFT do Freemem(ImgFFT2^[k]^[j],8*SFFT);
   Freemem(ImgFFT2^[k],4*SFFT);
   end;
Freemem(ImgFFT2,8);
end;
end;

function RegistrationEtoileLot(Directory:string;
                               ListeImg:TStringList;
                               ErrorMax:Double;
                               pop_Rapport:tpop_rapport;
                               IsASerie:Boolean):Boolean;
var
TabImgInt1,TabImgInt2:PTabImgInt;
TabImgDouble1,TabImgDouble2:PTabImgDouble;
ImgDoubleNil:PTabImgDouble;

i,j,k,l,n:Integer;
NbImage:Integer;
arrdetections_A,arrdetections_B:plistepsf;
ndetect_a,ndetect_B:integer;
Error:Byte;
gagnants:tlist;
m:P_Matcher;
NbStar:Integer;
ValDouble,Dx,Dy,DDx,DDy:Double;
ValInt:SmallInt;

x,y,x1,x2,sigx,sigy:PLigDouble;
a,b:DoubleArrayRow;
covara,covarb:DoubleArray;
chisqa,chisqb:Double;
degre:Integer;
ImgInfos:TImgInfos;
DateTimeFinal:TDateTime;
ListeImgFinal:TStringList;
NomGenerique,Ext:string;
ErrorRecal:Double;
ma:Integer;
begin
Result:=True;
pop_Rapport.AddLine(lang('Registration d''un lot stellaire'));

Ext:=ExtractFileExt(ListeImg.Strings[0]);
NomGenerique:=GetNomGenerique(ListeImg.Strings[0]);
NbImage:=ListeImg.Count;
n:=1;

ListeImgFinal:=TStringList.Create;
try

// Lecture de la premiere image
pop_Rapport.AddLine(lang('Lecture de l''image de référence : ')+ListeImg.Strings[0]);
ReadImageGenerique(Directory+'\'+ListeImg.Strings[0],TabImgInt1,TabImgDouble1,ImgInfos);
// On sauvegarde la premiere image
if IsASerie then
   begin
   pop_Rapport.AddLine(lang('Sauvegarde de l''image ')+
      '\rec_'+NomGenerique+IntToStr(n)+Ext); //nolang
   SaveImage(Directory+'\rec_'+NomGenerique+IntToStr(n)+Ext,TabImgInt1,TabImgDouble1, //nolang
      ImgInfos);
   ListeImgFinal.Add('rec_'+NomGenerique+IntToStr(n)+Ext); //nolang
   end
else
   begin
   pop_Rapport.AddLine(lang('Sauvegarde de l''image ')+
      '\rec_'+ListeImg.Strings[0]+Ext); //nolang
   SaveImage(Directory+'\rec_'+ListeImg.Strings[0]+Ext,TabImgInt1,TabImgDouble1, //nolang
      ImgInfos);
   ListeImgFinal.Add('rec_'+ListeImg.Strings[0]+Ext); //nolang
   end;

pop_Rapport.AddLine(lang('Modélisation des étoiles de l''image '));
ModeliseSources(TabImgInt1,TabImgDouble1,ImgInfos.TypeData,ImgInfos.NBPlans,ImgInfos.Sx,ImgInfos.Sy,9,arrdetections_A,TGauss,
//   LowPrecision,HighSelect,ndetect_A,15,False,'',False);
   LowPrecision,LowSelect,ndetect_A,15,False,'',False);
pop_Rapport.AddLine(lang('Nombres des étoiles de l''image : ')+IntToStr(ndetect_A));

if NDetect_A<3 then
   begin
   pop_Rapport.AddLine(lang('Pas assez d''étoiles dans l''image')+ListeImg.Strings[0]);
   FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
   Result:=False;
   Exit;
   end;

FreememImg(TabImgInt1,TabImgDouble1,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);

// Lecture et recalage de toutes les images
for j:=1 to NbImage-1 do
   begin
   // Lecture de l'image
   pop_Rapport.AddLine(lang('Lecture de l''image ')+ListeImg.Strings[j]);
   ReadImageGenerique(Directory+'\'+ListeImg.Strings[j],TabImgInt2,TabImgDouble2,ImgInfos);

   pop_Rapport.AddLine(lang('Modélisation des étoiles de l''image '));
   modelisesources(TabImgInt2,TabImgDouble2,ImgInfos.TypeData,ImgInfos.NBPlans,ImgInfos.Sx,ImgInfos.Sy,9,arrdetections_B,
      TGauss,LowPrecision,LowSelect,ndetect_B,15,false,'',False);
//      TGauss,LowPrecision,HighSelect,ndetect_B,15,false,'',False);
   pop_Rapport.AddLine(lang('Nombres des étoiles de l''image : ')+IntToStr(ndetect_B));

   if NDetect_B<3 then
      begin
      pop_Rapport.AddLine(lang('Pas assez d''étoiles dans l''image')+ListeImg.Strings[j]);
      FreememImg(TabImgInt2,TabImgDouble2,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
      Error:=4;
      end
   else
      begin
      try

      // Matching
      pop_Rapport.AddLine(lang('Mise en correspondance des étoiles'));
      Error:=MatchMarty(arrdetections_A,arrdetections_B,ndetect_A,ndetect_B,40,Gagnants,pop_Rapport);

      finally
      Freemem(arrdetections_B,ndetect_B*Sizeof(TPSF));
      end;
      end;

   if Error=5 then pop_Rapport.AddLine(lang('Correspondance entre étoiles non trouvée'));
   if Gagnants.Count<3 then
      begin
      pop_Rapport.AddLine(lang('Pas assez d''étoiles en correspondance'));
      Error:=6;
      end;
   if Error<>0 then pop_Rapport.AddLine(lang('Image ')+ListeImg.Strings[j]+
      lang(' Ignorée'));

   if Error=0 then
      begin
      NbStar:=Gagnants.Count;
      pop_Rapport.AddLine(IntToStr(NbStar)+lang(' étoiles en correspondance'));

      Getmem(x,8*NbStar);
      Getmem(y,8*NbStar);
      Getmem(x1,8*NbStar);
      Getmem(x2,8*NbStar);
      Getmem(Sigx,8*NbStar);
      Getmem(Sigy,8*NbStar);

      try

      // Changement de forme des donnees
      for i:=0 to NbStar-1 do
         begin
         m:=Gagnants[i];
         x1^[i+1]:=m.ref_x;
         x2^[i+1]:=m.ref_y;
         x^[i+1]:=m.det_x;
         y^[i+1]:=m.det_y;
         sigx^[i+1]:=m.det_dx;
         sigy^[i+1]:=m.det_dy;
         end;

      for i:=0 to Gagnants.Count-1 do
         begin
         m:=Gagnants.Items[i];
         Dispose(m);
         end;

      Degre:=1;

      // Calcul du polynome de passage en X
      pop_Rapport.AddLine(lang('Calcul du pôlynome de passage en X'));
      lfitAstro(x1,x2,x,sigx,NbStar,a,covara,chisqa,degre);
      // Calcul du polynome de passage en Y
      pop_Rapport.AddLine(lang('Calcul du pôlynome de passage en Y'));
      lfitAstro(x1,x2,y,sigy,NbStar,b,covarb,chisqb,degre);

      ma:=1;
      for i:=1 to Degre do ma:=ma+i+1;

      pop_Rapport.AddLine('  '); //nolang
      pop_Rapport.AddLine(lang('Polynôme de passage en X'));
      for i:=1 to ma do pop_Rapport.AddLine(Format('a[%d] = %6.3f',[i,a[i]])); //nolang
      pop_Rapport.AddLine('  '); //nolang
      pop_Rapport.AddLine(lang('Polynôme de passage en Y'));
      for i:=1 to ma do pop_Rapport.AddLine(Format('b[%d] = %6.3f',[i,b[i]])); //nolang

      Dx:=-a[1];
      DDx:=Sqrt(Abs(Covara[1,1])*Chisqa/NbStar);
      Dy:=-b[1];
      DDy:=Sqrt(Abs(Covarb[1,1])*Chisqb/NbStar);

//      pop_Rapport.AddLine(Format(lang('Déplacement en X : Dx = %4.2f +/- %5.3f'),[Dx,DDx]));
//      pop_Rapport.AddLine(Format(lang('Déplacement en Y : Dy = %4.2f +/- %5.3f'),[Dy,DDy]));

      finally
      Freemem(x,8*NbStar);
      Freemem(y,8*NbStar);
      Freemem(x1,8*NbStar);
      Freemem(x2,8*NbStar);
      Freemem(Sigx,8*NbStar);
      Freemem(Sigy,8*NbStar);
      end;

      ErrorRecal:=Sqrt(Sqr(DDx)+Sqr(DDy));
      if ErrorRecal<ErrorMax then
         begin
         pop_Rapport.AddLine(lang('Erreur = ')+FloatToStr(Round(ErrorRecal*1000)/1000)+
            ' < '+ //nolang
            lang('Erreur max = ')+FloatToStr(Round(ErrorMax*1000)/1000));
         // Translation de l'image
         pop_Rapport.AddLine(lang('Translation de l''image ')+ListeImg.Strings[j]);
//         Translation(TabImgInt2,TabImgDouble2,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NBPlans,Dx,Dy);
         // Transformation de l'image a compositer
         pop_Rapport.AddLine('  '); //nolang
         pop_Rapport.AddLine(lang('Transformation'));
         MorphingPoly(TabImgInt2,TabImgDouble2,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans,a,b,Degre);

         // On sauvegarde
         Inc(n);
//         SaveImageGenerique(Directory+'\rec_'+NomGenerique+IntToStr(n),TabImgInt2,TabImgDouble2, //nolang
//            ImgInfos);
         if IsASerie then
            begin
            pop_Rapport.AddLine(lang('Sauvegarde de l''image ')+
               '\rec_'+NomGenerique+IntToStr(n)+Ext); //nolang
//            SaveImageGenerique(Directory+'\rec_'+NomGenerique+IntToStr(n)+Ext,TabImgInt2,TabImgDouble2, //nolang
//               ImgInfos);
            SaveImage(Directory+'\rec_'+NomGenerique+IntToStr(n)+Ext,TabImgInt2,TabImgDouble2, //nolang
               ImgInfos);
//            ListeImgFinal.Add(ChangeExtToGenerique('rec_'+NomGenerique+IntToStr(n)+Ext,ImgInfos.TypeData)); //nolang
            ListeImgFinal.Add('rec_'+NomGenerique+IntToStr(n)+Ext); //nolang
            end
         else
            begin
            pop_Rapport.AddLine(lang('Sauvegarde de l''image ')+
               '\rec_'+ListeImg.Strings[j]+Ext); //nolang
//            SaveImageGenerique(Directory+'\rec_'+ListeImg.Strings[j]+Ext,TabImgInt2,TabImgDouble2, //nolang
//               ImgInfos);
            SaveImage(Directory+'\rec_'+ListeImg.Strings[j]+Ext,TabImgInt2,TabImgDouble2, //nolang
               ImgInfos);
            ListeImgFinal.Add(ChangeExtToGenerique('rec_'+ListeImg.Strings[j]+Ext,ImgInfos.TypeData)); //nolang
            ListeImgFinal.Add('rec_'+ListeImg.Strings[j]+Ext); //nolang
            end;
         end
      else
         begin
         pop_Rapport.AddLine(lang('Erreur = ')+FloatToStr(Round(ErrorRecal*1000)/1000)+
            ' > '+ //nolang
            lang('Erreur max = ')+FloatToStr(Round(ErrorMax*1000)/1000));
         pop_Rapport.AddLine(lang('Image ')+ListeImg.Strings[j]
            +lang(' ignorée'));
         Error:=7;
         end;

      FreememImg(TabImgInt2,TabImgDouble2,ImgInfos.Sx,ImgInfos.Sy,ImgInfos.TypeData,ImgInfos.NbPlans);
      end;
   end;

// Copie de la nouvelle liste dans la liste d'entree
ListeImg.Clear;
for i:=0 to ListeImgFinal.Count-1 do ListeImg.Add(ListeImgFinal.Strings[i]);

pop_Rapport.AddLine(lang('Recalage effectué'))

finally
ListeImgFinal.Free;
Freemem(arrdetections_A,ndetect_A*Sizeof(TPSF));
end;
end;


end.
