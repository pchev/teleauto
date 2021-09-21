unit pu_calib_cmde_corr;

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

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Editnbre, Spin, NumberEdit, ExtCtrls, u_class, IniFiles;

type
  Tpop_cmde_corr = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    ListBox1: TListBox;
    Image1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label14: TLabel;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    SpinEdit1: TSpinEdit;
    Label6: TLabel;
    NumberEdit3: TNumberEdit;
    SpinButton3: TSpinButton;
    Label7: TLabel;
    NumberEdit4: TNumberEdit;
    SpinButton4: TSpinButton;
    Label11: TLabel;
    NumberEdit5: TNumberEdit;
    SpinButton5: TSpinButton;
    Label13: TLabel;
    NumberEdit1: TNumberEdit;
    SpinButton1: TSpinButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpinButton3DownClick(Sender: TObject);
    procedure SpinButton3UpClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpinButton4DownClick(Sender: TObject);
    procedure SpinButton4UpClick(Sender: TObject);
    procedure SpinButton5DownClick(Sender: TObject);
    procedure SpinButton5UpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure AcqNoir;
  public
    { Déclarations publiques }
    TimeMin,TimeMax:Double;
    DiametreMin,DiametreMax:Double;
    DiametreProche,DiametreExtreme:Double;
    Update:Boolean;

    // Graphe
    Mirror:Boolean;                             // Trace de droite à gauche si true sinon inversé
    XImageMin,YImageMin:Integer;                // Coordonnées Image des limites du graphe
    XImageMax,YImageMax:Integer;
    XGraphMin,YGraphMin:Double;                 // Coordonnées Graphe correspondantes aux points précedents
    XGraphMax,YGraphMax:Double;
    AutoUpdateXMin:Boolean;                     // Calcul automatique de la limite XMin du graphe ?
    AutoUpdateXMax:Boolean;                     // Calcul automatique de la limite XMax du graphe ?
    AutoUpdateYMin:Boolean;                     // Calcul automatique de la limite YMin du graphe ?
    AutoUpdateYMax:Boolean;                     // Calcul automatique de la limite YMax du graphe ?

    XImage,YImage:PLigLongWord;                 // Coordonnées Image des points
    XGraph,YGraph:PLigDouble;                   // Coordonnées Graphe correspondantes aux points précedents
    NbXLines:Integer;                           // Nombres de lignes verticales
    NbYLines:Integer;                           // Nombres de lignes horizontales
    XImageLine:PLigLongWord;                    // Coordonnées Image des lignes verticales
    XGraphLine:PLigDouble;                      // Coordonnées Graphe correspondantes aux ligne verticales
    YImageLine:PLigLongWord;                    // Coordonnées Image des lignes horizontales
    YGraphLine:PLigDouble;                      // Coordonnées Graphe correspondantes aux ligne hozizontales
    XColorR,XColorV,XColorB:PLigByte;           // Couleur des lignes verticales
    YColorR,YColorV,YColorB:PLigByte;           // Couleur des lignes horizontales

    ColorR,ColorV,ColorB:PLigByte;              // Couleur des point
    XPointGraphMax,XPointGraphMin:Double;       // Valeur Graphe max des points
    YPointGraphMax,YPointGraphMin:Double;
    XOfYPointGraphMin,XOfYPointGraphMax:Double; // Valeur X des max des points
    NbPoints:LongWord;                          // Nombre de points
    NbPointsMem:LongWord;                       // Nombre de points pré-réservés en mémoire
    BKColor:TColor;                             // Couleur d'arrière plan
    AxisColor:TColor;                           // Couleur des axes
    ax,bx,ay,by:Double;                         // Coeff des relation de passage Image<->Graphe
    AFit,BFit,Erreur:Double;                    // Regression linéaire
    DisplayFit:Boolean;
    ColorFit:TColor;

    procedure MAJGraphe;

    // Fini par Graph -> à enlever dans le futur composant
    procedure CreateGraph;
    procedure ClearGraph;
    procedure FreeGraph;
    procedure UpDateGraph;
    procedure EffaceGraph;
    procedure DrawAxisGraph;
    procedure SetMirrorOnGraph;
    procedure SetMirrorOffGraph;

    procedure SetAutoXMinGraph(Auto:Boolean);
    procedure SetXMinGraph(XMin:Double);
    procedure SetAutoXMaxGraph(Auto:Boolean);
    procedure SetXMaxGraph(XMax:Double);
    procedure SetAutoYMinGraph(Auto:Boolean);
    procedure SetYMinGraph(YMin:Double);
    procedure SetAutoYMaxGraph(Auto:Boolean);
    procedure SetYMaxGraph(YMax:Double);

    function  CountGraph:LongWord;
    procedure AddGraph(X,Y:Double;_Color:TColor);
    function  GetXGraph(Index:LongWord):Double;
    function  GetYGraph(Index:LongWord):Double;
    procedure GetMinGraph(var X,Y:Double);
    procedure GetMaxGraph(var X,Y:Double);
    function  GetXMinGraph:Double;
    function  GetXMaxGraph:Double;
    function  GetYMinGraph:Double;
    function  GetYMaxGraph:Double;
    procedure XGraphToImageGraph(Xin:Double;var XOut:LongWord);
    procedure YGraphToImageGraph(Yin:Double;var YOut:LongWord);
    procedure GraphToImageGraph(Xin,Yin:Double;var XOut,YOut:LongWord);
    procedure XImageToGraphGraph(XIn:LongWord;var XOut:Double);
    procedure YImageToGraphGraph(YIn:LongWord;var YOut:Double);
    procedure ImageToGraphGraph(XIn,YIn:LongWord;var XOut,YOut:Double);
    procedure SetColorGraph(Index:LongWord;_Color:TColor);
    procedure DisplayGraph;
    procedure AddXLineGraph(X:Double;Color:TColor);
    procedure AddYLineGraph(Y:Double;Color:TColor);
    procedure SetXLineGraph(Index:Integer;X:Double);
    procedure SetYLineGraph(Index:Integer;Y:Double);
    function  GetXLineGraph(Index:Integer):Double;
    function  GetYLineGraph(Index:Integer):Double;
    procedure DrawLinesGraph;
    procedure LineFitGraph(IndexMin,IndexMax:LongWord;Color:TColor;var ALine,BLine,Error:Double);

    procedure AddMessage(MyMessage:string);
    procedure WriteMessage(MyMessage:string);
    procedure LoadParam;
    procedure SaveParam;
    procedure UpdateGUI;
  end;

var
   pop_cmde_corr:Tpop_cmde_corr;

implementation

uses pu_map_monitor,
     pu_main,
     u_focusers,
     u_file_io,
     pu_map,
     u_lang,
     u_general,
     pu_camera,
     pu_image,
     u_cameras,
     u_geometrie,
     u_arithmetique,
     u_analyse,
     u_modelisation,
     u_constants,
     u_meca,
     u_hour_servers,
     u_math,
     pu_conf;

{$R *.dfm}

//********************************************************************************************
//*******************************************   Graphe   *************************************
//********************************************************************************************

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
Etendue:=Abs(Maxi-Mini);
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
Debut:=System.Int(Mini*Mult[Index[j]])/Mult[Index[j]];
while Debut>Mini do Debut:=Debut-Pas;
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

// A appeller au début
procedure Tpop_cmde_corr.CreateGraph;
begin
NbPoints:=0;
// Préservation de mémoire
NbPointsMem:=1000;
GetMem(XGraph,NbPointsMem*8);
GetMem(YGraph,NbPointsMem*8);
GetMem(XImage,NbPointsMem*4);
GetMem(YImage,NbPointsMem*4);
GetMem(ColorR,NbPointsMem);
GetMem(ColorV,NbPointsMem);
GetMem(ColorB,NbPointsMem);
FillChar(XGraph^,NbPointsMem*8,0);
FillChar(YGraph^,NbPointsMem*8,0);
FillChar(XImage^,NbPointsMem*4,0);
FillChar(YImage^,NbPointsMem*4,0);
FillChar(ColorR^,NbPointsMem,0);
FillChar(ColorV^,NbPointsMem,0);
FillChar(ColorB^,NbPointsMem,0);

AutoUpdateXMin:=True;
AutoUpdateXMax:=True;
AutoUpdateYMin:=True;
AutoUpdateYMax:=True;

NbXLines:=0;
NbYLines:=0;
// Max fixe à 1000
GetMem(XImageLine,1000*4);
GetMem(YImageLine,1000*4);
GetMem(XGraphLine,1000*8);
GetMem(YGraphLine,1000*8);
GetMem(XColorR,1000);
GetMem(XColorV,1000);
GetMem(XColorB,1000);
GetMem(YColorR,1000);
GetMem(YColorV,1000);
GetMem(YColorB,1000);
FillChar(XGraphLine^,1000*8,0);
FillChar(YGraphLine^,1000*8,0);
FillChar(XImageLine^,1000*4,0);
FillChar(YImageLine^,1000*4,0);
FillChar(XColorR^,1000,0);
FillChar(XColorV^,1000,0);
FillChar(XColorB^,1000,0);
FillChar(YColorR^,1000,0);
FillChar(YColorV^,1000,0);
FillChar(YColorB^,1000,0);

BKColor:=clBtnFace;
AxisColor:=clBlack;
EffaceGraph;
XImageMin:=35;
YImageMin:=Image1.Height-20;
XImageMax:=Image1.Width-10;
YImageMax:=10;
DrawAxisGraph;
XPointGraphMax:=-MaxDouble;
XPointGraphMin:=MaxDouble;
YPointGraphMax:=-MaxDouble;
YPointGraphMin:=MaxDouble;

DisplayFit:=False;
Mirror:=False;
end;

procedure Tpop_cmde_corr.ClearGraph;
begin
NbPoints:=0;
FreeMem(XGraph,NbPointsMem*8);
FreeMem(YGraph,NbPointsMem*8);
FreeMem(XImage,NbPointsMem*4);
FreeMem(YImage,NbPointsMem*4);
FreeMem(ColorR,NbPointsMem);
FreeMem(ColorV,NbPointsMem);
FreeMem(ColorB,NbPointsMem);

// Max fixe à 1000
FillChar(XGraphLine^,1000*8,0);
FillChar(YGraphLine^,1000*8,0);
FillChar(XImageLine^,1000*4,0);
FillChar(YImageLine^,1000*4,0);
FillChar(XColorR^,1000,0);
FillChar(XColorV^,1000,0);
FillChar(XColorB^,1000,0);
FillChar(YColorR^,1000,0);
FillChar(YColorV^,1000,0);
FillChar(YColorB^,1000,0);
NbXLines:=0;
NbYLines:=0;

// Preservation de mémoire
NbPointsMem:=1000;
GetMem(XGraph,NbPointsMem*8);
GetMem(YGraph,NbPointsMem*8);
GetMem(XImage,NbPointsMem*4);
GetMem(YImage,NbPointsMem*4);
GetMem(ColorR,NbPointsMem);
GetMem(ColorV,NbPointsMem);
GetMem(ColorB,NbPointsMem);
FillChar(XGraph^,NbPointsMem*8,0);
FillChar(YGraph^,NbPointsMem*8,0);
FillChar(XImage^,NbPointsMem*4,0);
FillChar(YImage^,NbPointsMem*4,0);
FillChar(ColorR^,NbPointsMem,0);
FillChar(ColorV^,NbPointsMem,0);
FillChar(ColorB^,NbPointsMem,0);

EffaceGraph;
DrawAxisGraph;
XPointGraphMax:=MinDouble;
XPointGraphMin:=MaxDouble;
YPointGraphMax:=MinDouble;
YPointGraphMin:=MaxDouble;

DisplayFit:=False;
Mirror:=False;
end;

procedure Tpop_cmde_corr.FreeGraph;
begin
FreeMem(XGraph,NbPointsMem*8);
FreeMem(YGraph,NbPointsMem*8);
FreeMem(XImage,NbPointsMem*4);
FreeMem(YImage,NbPointsMem*4);
FreeMem(ColorR,NbPointsMem);
FreeMem(ColorV,NbPointsMem);
FreeMem(ColorB,NbPointsMem);

FreeMem(XImageLine,1000*4);
FreeMem(YImageLine,1000*4);
FreeMem(XGraphLine,1000*8);
FreeMem(YGraphLine,1000*8);
FreeMem(XColorR,1000);
FreeMem(XColorV,1000);
FreeMem(XColorB,1000);
FreeMem(YColorR,1000);
FreeMem(YColorV,1000);
FreeMem(YColorB,1000);
end;

procedure Tpop_cmde_corr.EffaceGraph;
begin
Image1.Canvas.Pen.Mode:=pmCopy;
Image1.Canvas.Pen.Style:=psSolid;
Image1.Canvas.Pen.Color:=BKColor;
Image1.Canvas.Brush.Color:=BKColor;
Image1.Canvas.Brush.Style:=bsSolid;
Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
end;

procedure Tpop_cmde_corr.DrawAxisGraph;
var
  NBXGrad,NBYGrad,i,LargTexte,HautTexte:Integer;
  XTemp,YTemp:LongWord;
  MyText:string;
  Marque,Debut,Pas,Grad:Double;
begin
// Les axes
Image1.Canvas.Pen.Mode:=pmCopy;
Image1.Canvas.Pen.Color:=AxisColor;
Image1.Canvas.Pen.Style:=psSolid;
Image1.Canvas.Pen.Width:=2;
Image1.Canvas.MoveTo(XImageMin,YImageMin);
Image1.Canvas.LineTo(XImageMin,YImageMax);
Image1.Canvas.MoveTo(XImageMin,YImageMin);
Image1.Canvas.LineTo(XImageMax,YImageMin);
Image1.Canvas.Pen.Width:=1;
Image1.Canvas.MoveTo(XImageMin,YImageMax);
Image1.Canvas.LineTo(XImageMax,YImageMax);
Image1.Canvas.MoveTo(XImageMax,YImageMin);
Image1.Canvas.LineTo(XImageMax,YImageMax);

// Les graduations en X
CalculIntervales(XGraphMin,XGraphMax,Debut,Pas);
Marque:=Debut;
while Marque<=XGraphMax+Pas*10e-10 do
   begin
   if (Marque>=XGraphMin) then
      begin
      XGraphToImageGraph(Marque,XTemp);
      Image1.Canvas.Pen.Width:=1;
      Image1.Canvas.Pen.Color:=clGray;
      Image1.Canvas.Pen.Style:=psDot;
      if (XTemp<>XImageMax) and (XTemp<>XImageMin) then
         begin
         Image1.Canvas.MoveTo(XTemp,YImageMin);
         Image1.Canvas.LineTo(XTemp,YImageMax);
         end;
      Image1.Canvas.Pen.Color:=AxisColor;
      Image1.Canvas.Pen.Style:=psSolid;
      Image1.Canvas.Pen.Mode:=pmCopy;
      Image1.Canvas.MoveTo(XTemp,YImageMin-4);
      Image1.Canvas.LineTo(XTemp,YImageMin+4);
      Image1.Canvas.Font.Height:=10;
      MyText:=MyFloatToStr(Marque,2);
      LargTexte:=Image1.Canvas.TextWidth(MyText) div 2;
      Image1.Canvas.TextOut(XTemp-LargTexte,YImageMin+4,MyText);
      end;
   Marque:=Marque+Pas;
   end;

// Les graduations en Y
CalculIntervales(YGraphMin,YGraphMax,Debut,Pas);
Marque:=Debut;
while Marque<=YGraphMax+Pas*10e-10 do
   begin
   if (Marque>=YGraphMin) then
      begin
      YGraphToImageGraph(Marque,YTemp);
      Image1.Canvas.Pen.Width:=1;
      Image1.Canvas.Pen.Color:=clGray;
      Image1.Canvas.Pen.Style:=psDot;
      if (YTemp<>YImageMax) and (YTemp<>YImageMin) then
         begin
         Image1.Canvas.MoveTo(XImageMin,YTemp);
         Image1.Canvas.LineTo(XImageMax,YTemp);
         end;
      Image1.Canvas.Pen.Color:=AxisColor;
      Image1.Canvas.Pen.Style:=psSolid;
      Image1.Canvas.Pen.Mode:=pmCopy;
      Image1.Canvas.MoveTo(XImageMin-4,YTemp);
      Image1.Canvas.LineTo(XImageMin+4,YTemp);
      Image1.Canvas.Font.Height:=10;
      MyText:=MyFloatToStr(Marque,2);
      LargTexte:=Image1.Canvas.TextWidth(MyText);
      HautTexte:=Image1.Canvas.TextHeight(MyText) div 2;
      Image1.Canvas.TextOut(XImageMin-7-LargTexte,YTemp-HautTexte,MyText);
      end;
   Marque:=Marque+Pas;
   end;

end;

procedure Tpop_cmde_corr.SetMirrorOnGraph;
var
   XTemp:Integer;
begin
if not Mirror then
   begin
   XTemp:=XImageMin;
   XImageMin:=XImageMax;
   XImageMax:=XTemp;
   Mirror:=True;
   end;
end;

procedure Tpop_cmde_corr.SetMirrorOffGraph;
var
   XTemp:Integer;
begin
if Mirror then
   begin
   XTemp:=XImageMin;
   XImageMin:=XImageMax;
   XImageMax:=XTemp;
   Mirror:=False;
   end;
end;

procedure Tpop_cmde_corr.SetAutoXMinGraph(Auto:Boolean);
begin
AutoUpdateXMin:=Auto;
UpDateGraph;
end;

procedure Tpop_cmde_corr.SetXMinGraph(XMin:Double);
begin
XGraphMin:=XMin;
end;

procedure Tpop_cmde_corr.SetAutoXMaxGraph(Auto:Boolean);
begin
AutoUpdateXMax:=Auto;
UpDateGraph;
end;

procedure Tpop_cmde_corr.SetXMaxGraph(XMax:Double);
begin
XGraphMax:=XMax;
end;

procedure Tpop_cmde_corr.SetAutoYMinGraph(Auto:Boolean);
begin
AutoUpdateYMin:=Auto;
UpDateGraph;
end;

procedure Tpop_cmde_corr.SetYMinGraph(YMin:Double);
begin
YGraphMin:=YMin;
end;

procedure Tpop_cmde_corr.SetAutoYMaxGraph(Auto:Boolean);
begin
AutoUpdateYMax:=Auto;
UpDateGraph;
end;

procedure Tpop_cmde_corr.SetYMaxGraph(YMax:Double);
begin
YGraphMax:=YMax;
end;

function Tpop_cmde_corr.CountGraph:LongWord;
begin
Result:=NBPoints;
end;

procedure Tpop_cmde_corr.AddGraph(X,Y:Double;_Color:TColor);
var
   Tolerance,Valeur:Double;
   i:Integer;
begin
// TODO : Si le nb de points et supérieur à la mémoire -> augmenter la mémoire
if NBPoints+1>NBPointsMem then
   begin

   end;

// Mise a jour des max des Points
if X>XPointGraphMax then XPointGraphMax:=X;
if X<XPointGraphMin then XPointGraphMin:=X;
if Y>YPointGraphMax then
   begin
   YPointGraphMax:=Y;
   XOfYPointGraphMax:=X;
   end;
if Y<YPointGraphMin then
   begin
   YPointGraphMin:=Y;
   XOfYPointGraphMin:=X;
   end;

// Ajout des points
Inc(NBPoints);
XGraph^[NbPoints]:=X;
YGraph^[NbPoints]:=Y;
ColorR^[NbPoints]:=GetRValue(_Color);
ColorV^[NbPoints]:=GetGValue(_Color);
ColorB^[NbPoints]:=GetBValue(_Color);

// Calcul des coordonnées dans l'image
// Mise à jour des max du Graphe
// Si 1 seul points : +/-10% des coordonnées du point
Tolerance:=0.1;
if NBPoints=1 then
   begin
   if X<>0 then
      begin
      if X>0 then
         begin
         if AutoUpdateXMin then XGraphMin:=(1-Tolerance)*X;
         if AutoUpdateXMax then XGraphMax:=(1+Tolerance)*X;
         end
      else
         begin
         if AutoUpdateXMin then XGraphMin:=(1+Tolerance)*X;
         if AutoUpdateXMax then XGraphMax:=(1-Tolerance)*X;
         end;
      end
   else
      begin
      if AutoUpdateXMin then XGraphMin:=X-1;
      if AutoUpdateXMax then XGraphMax:=X+1;
      end;
   if Y<>0 then
      begin
      if Y>0 then
         begin
         if AutoUpdateYMin then YGraphMin:=(1-Tolerance)*Y;
         if AutoUpdateYMax then YGraphMax:=(1+Tolerance)*Y;
         end
      else
         begin
         if AutoUpdateYMin then YGraphMin:=(1+Tolerance)*Y;
         if AutoUpdateYMax then YGraphMax:=(1-Tolerance)*Y;
         end;
      end         
   else
      begin
      if AutoUpdateYMin then YGraphMin:=Y-1;
      if AutoUpdateYMax then YGraphMax:=Y+1;
      end;
   end
else
// Si plusieurs points : automatique +/-10% de l'intervalle
   begin
   Valeur:=Tolerance*(XPointGraphMax-XPointGraphMin);
   if AutoUpdateXMin then XGraphMin:=XPointGraphMin-Valeur;
   if AutoUpdateXMax then XGraphMax:=XPointGraphMax+Valeur;
   Valeur:=Tolerance*(YPointGraphMax-YPointGraphMin);
   if AutoUpdateYMin then YGraphMin:=YPointGraphMin-Valeur;
   if AutoUpdateYMax then YGraphMax:=YPointGraphMax+Valeur;
   end;
// Calcul des relations de passage
ax:=(XImageMax-XImageMin)/(XGraphMax-XGraphMin);
bx:=XImageMax-ax*XGraphMax;
ay:=(YImageMax-YImageMin)/(YGraphMax-YGraphMin);
by:=YImageMax-ay*YGraphMax;
// Calcul des positions
for i:=1 to NBPoints do
   GraphToImageGraph(XGraph^[i],YGraph^[i],XImage^[i],YImage^[i]);
// Recalcul des lignes
for i:=1 to NbXLines do
   XGraphToImageGraph(XGraphLine^[i],XImageLine^[i]);
for i:=1 to NbYLines do
   YGraphToImageGraph(YGraphLine^[i],YImageLine^[i]);
UpdateGraph;
end;

procedure Tpop_cmde_corr.UpDateGraph;
begin
EffaceGraph;
DrawAxisGraph;
DisplayGraph;
DrawLinesGraph;
end;

procedure Tpop_cmde_corr.LineFitGraph(IndexMin,IndexMax:LongWord;Color:TColor;var ALine,BLine,Error:Double);
var
   x,y,Sig:PLigDouble;
   i,j,NbData:Integer;
   var A:DoubleArrayRow;
   var Covar:DoubleArray;
   var ChiSQ:Double;
begin
NBData:=IndexMax-IndexMin+1;
Getmem(x,NBData*8);
Getmem(y,NBData*8);
Getmem(Sig,NBData*8);

try

j:=0;
for i:=IndexMin to IndexMax do
   begin
   Inc(j);
   x^[j]:=XGraph^[i];
   y^[j]:=YGraph^[i];
   Sig^[j]:=1;   
   end;

// Moindres carrés linéaires
LFitLin(x,y,Sig,NbData,A,Covar,ChiSQ);

// Les coefs
AFit:=A[2];
BFit:=A[1];
if NbData>2 then
   Erreur:=Sqrt(ChiSQ/(NbData-2))
else
   Erreur:=0;
DisplayFit:=True;
ColorFit:=Color;

ALine:=AFit;
BLine:=BFit;
Error:=Erreur;

UpDateGraph;

finally
Freemem(x,NBData*8);
Freemem(y,NBData*8);
Freemem(Sig,NBData*8);
end;
end;


procedure Tpop_cmde_corr.XGraphToImageGraph(Xin:Double;var XOut:LongWord);
begin
XOut:=Round(ax*XIn+bx);
end;

procedure Tpop_cmde_corr.YGraphToImageGraph(Yin:Double;var YOut:LongWord);
begin
YOut:=Round(ay*YIn+by);
end;

procedure Tpop_cmde_corr.GraphToImageGraph(Xin,Yin:Double;var XOut,YOut:LongWord);
begin
XGraphToImageGraph(Xin,XOut);
YGraphToImageGraph(Yin,YOut);
end;

procedure Tpop_cmde_corr.XImageToGraphGraph(XIn:LongWord;var XOut:Double);
begin
XOut:=(XIn-bx)/ax;
end;

procedure Tpop_cmde_corr.YImageToGraphGraph(YIn:LongWord;var YOut:Double);
begin
YOut:=(YIn-by)/ay;
end;

procedure Tpop_cmde_corr.ImageToGraphGraph(XIn,YIn:LongWord;var XOut,YOut:Double);
begin
XImageToGraphGraph(XIn,XOut);
YImageToGraphGraph(YIn,YOut);
end;

function Tpop_cmde_corr.GetXGraph(Index:LongWord):Double;
begin
Result:=XGraph^[Index];
end;

function Tpop_cmde_corr.GetYGraph(Index:LongWord):Double;
begin
Result:=YGraph^[Index];
end;

function Tpop_cmde_corr.GetXMinGraph:Double;
begin
Result:=XPointGraphMin;
end;

function Tpop_cmde_corr.GetXMaxGraph:Double;
begin
Result:=XPointGraphMax;
end;

function Tpop_cmde_corr.GetYMinGraph:Double;
begin
Result:=YPointGraphMin;
end;

function Tpop_cmde_corr.GetYMaxGraph:Double;
begin
Result:=YPointGraphMax;
end;

procedure Tpop_cmde_corr.GetMaxGraph(var X,Y:Double);
begin
X:=XOfYPointGraphMax;
Y:=YPointGraphMax;
end;

procedure Tpop_cmde_corr.GetMinGraph(var X,Y:Double);
begin
X:=XOfYPointGraphMin;
Y:=YPointGraphMin;
end;

procedure Tpop_cmde_corr.SetColorGraph(Index:LongWord;_Color:TColor);
begin
ColorR^[Index]:=GetRValue(_Color);
ColorV^[Index]:=GetGValue(_Color);
ColorB^[Index]:=GetBValue(_Color);
end;

procedure Tpop_cmde_corr.DisplayGraph;
var
   i,Larg:Integer;
begin
Larg:=5;
for i:=1 to NbPoints do
   begin
   Image1.Canvas.Pen.Mode:=pmCopy;
   Image1.Canvas.Pen.Color:=RGB(ColorR^[i],ColorV^[i],ColorB^[i]);
   Image1.Canvas.Pen.Style:=psSolid;
   Image1.Canvas.Pen.Width:=1;
   Image1.Canvas.MoveTo(XImage^[i]-Larg,YImage^[i]);
   Image1.Canvas.LineTo(XImage^[i]+Larg+1,YImage^[i]);
   Image1.Canvas.MoveTo(XImage^[i],YImage^[i]-Larg);
   Image1.Canvas.LineTo(XImage^[i],YImage^[i]+Larg+1);
   end;
end;

procedure Tpop_cmde_corr.DrawLinesGraph;
var
   i:Integer;
   YGauche,YDroite,XBas,XHaut:Double;
   XLineFit,YLineFit:array[1..2] of LongWord;
begin
Image1.Canvas.Pen.Mode:=pmCopy;
Image1.Canvas.Pen.Width:=1;
Image1.Canvas.Pen.Style:=psSolid;

for i:=1 to NBXLines do
   begin
   Image1.Canvas.Pen.Color:=RGB(XColorR^[i],XColorV^[i],XColorB^[i]);
   if (XImageLine^[i]>XImageMin) and (XImageLine^[i]<XImageMax) then
      begin
      Image1.Canvas.MoveTo(XImageLine^[i],YImageMin);
      Image1.Canvas.LineTo(XImageLine^[i],YImageMax);
      end;
   end;
for i:=1 to NBYLines do
   begin
   Image1.Canvas.Pen.Color:=RGB(YColorR^[i],YColorV^[i],YColorB^[i]);
   if (YImageLine^[i]>YImageMax) and (YImageLine^[i]<YImageMin) then
      begin
      Image1.Canvas.MoveTo(XImageMin,YImageLine^[i]);
      Image1.Canvas.LineTo(XImageMax,YImageLine^[i]);
      end;
   end;

if DisplayFit then
   begin
   Image1.Canvas.Pen.Color:=ColorFit;

   // Intersections
   // Y=AFit*X+BFit
   YGauche:=AFit*XGraphMin+BFit;
   YDroite:=AFit*XGraphMax+BFit;
   // X=(Y-BFit)/AFit
   XBas:=(YGraphMin-BFit)/AFit;
   XHaut:=(YGraphMax-BFit)/AFit;

   i:=0;
   if (YGauche<YGraphMax) and (YGauche>YGraphMin) then
      begin
      Inc(i);
      XLineFit[i]:=XImageMin;
      YGraphToImageGraph(YGauche,YLineFit[i]);
      end;
   if (YDroite<YGraphMax) and (YDroite>YGraphMin) then
      begin
      Inc(i);
      XLineFit[i]:=XImageMax;
      YGraphToImageGraph(YDroite,YLineFit[i]);
      end;
   if (XBas<XGraphMax) and (XBas>XGraphMin) then
      begin
      Inc(i);
      XGraphToImageGraph(XBas,XLineFit[i]);
      YLineFit[i]:=YImageMin;
      end;
   if (XHaut<XGraphMax) and (XHaut>XGraphMin) then
      begin
      Inc(i);
      XGraphToImageGraph(XHaut,XLineFit[i]);
      YLineFit[i]:=YImageMax;
      end;
   Image1.Canvas.MoveTo(XLineFit[1],YLineFit[1]);
   Image1.Canvas.LineTo(XLineFit[2],YLineFit[2]);

   end;
end;

procedure Tpop_cmde_corr.AddYLineGraph(Y:Double;Color:TColor);
var
   YOut:LongWord;
begin
YGraphToImageGraph(Y,YOut);
Inc(NbYLines);
YGraphLine^[NbYLines]:=Y;
YImageLine^[NbYLines]:=YOut;
YColorR^[NbYLines]:=GetRValue(Color);
YColorV^[NbYLines]:=GetGValue(Color);
YColorB^[NbYLines]:=GetBValue(Color);
UpdateGraph;
end;

procedure Tpop_cmde_corr.AddXLineGraph(X:Double;Color:TColor);
var
   XOut:LongWord;
begin
XGraphToImageGraph(X,XOut);
Inc(NbXLines);
XGraphLine^[NbXLines]:=X;
XImageLine^[NbXLines]:=XOut;
XColorR^[NbXLines]:=GetRValue(Color);
XColorV^[NbXLines]:=GetGValue(Color);
XColorB^[NbXLines]:=GetBValue(Color);
UpdateGraph;
end;

procedure Tpop_cmde_corr.SetXLineGraph(Index:Integer;X:Double);
var
   XOut:LongWord;
begin
XGraphToImageGraph(X,XOut);
XGraphLine^[Index]:=X;
XImageLine^[Index]:=XOut;
UpdateGraph;
end;

procedure Tpop_cmde_corr.SetYLineGraph(Index:Integer;Y:Double);
var
   YOut:LongWord;
begin
YGraphToImageGraph(Y,YOut);
YGraphLine^[Index]:=Y;
YImageLine^[Index]:=YOut;
UpdateGraph;
end;

function Tpop_cmde_corr.GetXLineGraph(Index:Integer):Double;
begin
if (Index>0) and (Index<NbXLines) then
   Result:=XGraphLine^[Index];
end;

function Tpop_cmde_corr.GetYLineGraph(Index:Integer):Double;
begin
if (Index>0) and (Index<=NbYLines) then
   Result:=YGraphLine^[Index];
end;

//******************************************************************************
//******************************************************************************
//******************************************************************************

procedure Tpop_cmde_corr.AddMessage(MyMessage:string);
const
   Max=1000;
var
   Nbre:integer;
begin
if ListBox1.Items.Count>Max then ListBox1.Items.Delete(0);
ListBox1.Items.Add(GetStrTimeBios+' '+MyMessage);

Nbre:=ListBox1.Height div ListBox1.ItemHeight;

if ListBox1.Items.Count<Nbre then ListBox1.TopIndex:=0
else ListBox1.TopIndex:=ListBox1.Items.Count-Nbre;
end;

procedure Tpop_cmde_corr.WriteMessage(MyMessage:string);
begin
WriteSpy(MyMessage);
AddMessage(MyMessage);
end;

procedure Tpop_cmde_corr.AcqNoir;
var
   i:Integer;
begin
// si l'image n'existe pas, on la cree
if pop_camera.pop_image_acq=nil then
   begin
   pop_camera.pop_image_acq:=tpop_image.Create(Application);
   pop_camera.pop_image_acq.IsUsedForTrack:=True;
   pop_camera.pop_image_acq.ImgInfos.TypeData:=CameraSuivi.GetTypeData;
   pop_camera.pop_image_acq.ImgInfos.NbPlans:=CameraSuivi.GetNbPlans;
   end;

VAcqNoir:=True;
pop_camera.Acquisition(1,1,Camera.GetXSize,Camera.GetYSize,1,1,True);
VAcqNoir:=False;

pop_camera.pop_image_acq.AjusteFenetre;
case config.SeuilCamera of
   0:pop_camera.pop_image_acq.VisuAutoEtoiles;
   1:pop_camera.pop_image_acq.VisuAutoPlanetes;
   2:pop_camera.pop_image_acq.VisuAutoMinMax;
   end;
pop_main.SeuilsEnable;

if MemPicNoir<>nil then
   begin
   if Camera.Is16Bits then
      begin
      for i:=1 to SyNoir do Freemem(MemPicNoirDouble^[1]^[i],SxNoir*8);
      Freemem(MemPicNoirDouble^[1],4*SyNoir);
      Freemem(MemPicNoirDouble,4);
      end
   else
      begin
      for i:=1 to SyNoir do Freemem(MemPicNoir^[1]^[i],SxNoir*2);
      Freemem(MemPicNoir^[1],4*SyNoir);
      Freemem(MemPicNoir,4);
      end;
   end;

SxNoir:=pop_camera.pop_image_acq.ImgInfos.Sx;
SyNoir:=pop_camera.pop_image_acq.ImgInfos.Sy;

if Camera.Is16Bits then
   begin
   Getmem(MemPicNoirDouble,4);
   Getmem(MemPicNoirDouble^[1],SyNoir*4);
   for i:=1 to SyNoir do
      begin
      Getmem(MemPicNoirDouble^[1]^[i],SxNoir*8);
      Move(pop_camera.pop_image_acq.DataDouble^[1]^[i]^,MemPicNoirDouble^[1]^[i]^,SxNoir*8);
      end;
   end
else
   begin
   Getmem(MemPicNoir,4);
   Getmem(MemPicNoir^[1],SyNoir*4);
   for i:=1 to SyNoir do
      begin
      Getmem(MemPicNoir^[1]^[i],SxNoir*2);
      Move(pop_camera.pop_image_acq.DataInt^[1]^[i]^,MemPicNoir^[1]^[i]^,SxNoir*2);
      end;
   end;
end;

procedure Tpop_cmde_corr.Button1Click(Sender: TObject);
var
   xx,yy,i:Integer;
   xxd,yyd:Double;
   ValMax:Double;
   LargFen:Integer;
   Fin:Boolean;
   Max:SmallInt;
   ImgNil:PTabImgDouble;
   Vitesse:Integer;
   XCentre,YCentre,Diametre:Double;
   ImgDoubleNil:PTabImgDouble;
   OK:Boolean;
   MyMessage:string;
//   Pose:Double;

   Fwhm:TVecteur;
   NbMesures:Integer;
   Add:Boolean;
   NbAdd:Integer;
   Mesure1,Mesure2:Double;
   TimeMove:Double;
   NbMesure:Integer;
   Descend,Monte:Boolean;
   XMaxGraph,YMaxGraph:Double;
   XMaxGraph2,YMaxGraph2:Double;
   XMinGraph,Min1,Min2,Min3:Double;
   MinPasse:Boolean;
   Impulsion,Survitesse:Double;
   SaveAvR,SaveAvL,SaveArR,SaveArL,SurL,SurR:Double;
   Temp:Double;
   Saturation:Boolean;
   ValDesature:Integer;
begin
ListBox1.Clear;

Focuser.SetCorrectionOn;

SaveAvR:=Config.ImpulsionAvantRapide;
SaveAvL:=Config.ImpulsionAvantLente;
SaveArR:=Config.ImpulsionArriereRapide;
SaveArL:=Config.ImpulsionArriereLente;
SurL:=Config.SurvitesseLente;
SurR:=Config.SurvitesseRapide;

Button2.Enabled:=True;
Button3.Enabled:=False;

// Pour les tests
FWHMTestCourant:=15;
//if ComboBox2.ItemIndex=0 then FWHMTestCourant:=15 else FWHMTestCourant:=15;

// Inversion de l'axe des X
//if ComboBox2.ItemIndex=0 then SetMirrorOffGraph else SetMirrorOnGraph;

ClearGraph;

TesteFocalisation:=True;
pop_map.btn_manuel.Enabled:=False;
pop_map.btn_auto.Enabled:=False;
pop_map.Button5.Enabled:=False;
pop_map.Button1.Enabled:=False;
pop_map.Edit5.Enabled:=False;
pop_map.SpinButton2.Enabled:=False;

if pop_camera.pop_image_acq=nil then
    pop_camera.pop_image_acq:=tpop_image.Create(Application);
pop_camera.pop_image_acq.Bloque:=True;
pop_camera.pop_image_acq.IsUsedForAcq:=True;

pop_map.StopMap:=False;

pop_map.Pose:=MyStrToFloat(pop_map.Edit5.text);
WriteSpy(lang('Temps de pose = ')+MyFloatToStr(pop_map.Pose,2)
   +' secondes');
AddMessage(lang('Temps de pose = ')+MyFloatToStr(pop_map.Pose,2)+lang(' secondes'));

if not NoirMAPAcquis and pop_map.CheckBox1.Checked then
   begin
   WriteSpy(lang('Acquisition du noir'));
   AddMessage(lang('Acquisition du noir'));
   AcqNoir;
   NoirMAPAcquis:=True;
   end;

try

LargFen:=config.LargFoc;

WriteSpy(lang('Recherche des coordonnées de l''étoile la plus brillante'));
AddMessage(lang('Recherche des coordonnées de l''étoile la plus brillante'));
// Trouver ses coordonnee en Binning 4x4
pop_camera.AcqMaximumBinning(pop_map.XMap,pop_map.YMap);
pop_main.SeuilsEnable;
if Camera.IsAValidBinning(4) then
   begin
   pop_map.XMap:=pop_map.XMap*4;
   pop_map.YMap:=pop_map.YMap*4;
   end
else
   begin
   pop_map.XMap:=pop_map.XMap*3;
   pop_map.YMap:=pop_map.YMap*3;
   end;

WriteSpy(lang('Coordonnées de l''étoile X = ')+IntToStr(pop_map.XMap)
   +' Y = '+IntToStr(pop_map.YMap)); //nolang
AddMessage(lang('Coordonnées de l''étoile X = ')+IntToStr(pop_map.XMap)
   +' Y = '+IntToStr(pop_map.YMap)); //nolang
// Premiere aquisition de l'etoile
WriteSpy(lang('Passage en vignette'));
AddMessage(lang('Passage en vignette'));

if (pop_map.XMap>LargFen+1) and (pop_map.YMap>LargFen+1) and (pop_map.XMap<Camera.GetXSize-LargFen) and (pop_map.YMap<Camera.GetYSize-LargFen) then
   begin
   pop_camera.Acquisition(pop_map.XMap-LargFen,pop_map.YMap-LargFen,pop_map.XMap+LargFen,pop_map.YMap+LargFen,pop_map.Pose,1,False);

   // Pour Valmax
   GetMax(pop_camera.pop_image_acq.dataInt,pop_camera.pop_image_acq.dataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData
      ,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,xx,yy,ValMax);

   //Soustraction du noir
   if NoirMAPAcquis  and pop_map.CheckBox1.Checked then
      begin
      GetImgPart(MemPicNoir,MemPicNoirDouble,VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
         1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,pop_map.XMap-LargFen,pop_map.YMap-LargFen,
         pop_map.XMap+LargFen,pop_map.YMap+LargFen);
      Soust(pop_camera.pop_image_acq.DataInt,VignetteNoir,pop_camera.pop_image_acq.DataDouble,VignetteNoirDouble,
         pop_camera.pop_image_acq.ImgInfos.TypeData,1,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
         pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy);
      FreememImg(VignetteNoir,VignetteNoirDouble,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,
         pop_camera.pop_image_acq.ImgInfos.TypeData,1);
      end;

   pop_camera.pop_image_acq.AjusteFenetre;
   pop_camera.pop_image_acq.VisuAutoEtoiles;
   end
// A FAIRE Plus tard -> trouver une autre etoile
else
   begin
   WriteSpy(lang('Etoile trop près du bord'));
   WriteSpy(lang('Arrêt de l''étalonnage'));
   AddMessage(lang('Etoile trop près du bord'));
   AddMessage(lang('Arrêt de l''étalonnage'));
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;

// Pour centrer
HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,2*LargFen+1,
   2*LargFen+1,xxd,yyd,Diametre);
pop_map.XMap:=pop_map.XMap-LargFen+Round(xxd);
pop_map.YMap:=pop_map.YMap-LargFen+Round(yyd);

if Config.Verbose then
   begin
   WriteSpy(lang('Intensité maximale dans l''image brute = ')+IntToStr(Round(ValMax)));
   //AddMessage(lang('Intensité maximale dans l''image = ')+IntToStr(Round(ValMax)));
   end;

if ValMax>=Camera.GetSaturationLevel then
   begin
   ValDesature:=pop_map.Desature(ValMax,True);
   if ValDesature<0 then
      begin
      if Assigned(pop_map_monitor) and (pop_map_monitor<>nil) then
         begin
         pop_map_monitor.Button3.Enabled:=True;
         pop_map_monitor.Button4.Enabled:=False;
         end;
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;
   end;

{if ValMax>Camera.GetSaturationLevel then
   begin
   WriteSpy(lang('Etoile saturée, on tente de la désaturer'));
   AddMessage(lang('Etoile saturée, on tente de la désaturer'));
   end;

while (ValMax>Camera.GetSaturationLevel) and (Pose>config.MinPose) do
   begin

   if pop_map.StopMap then
      begin
      WriteSpy(lang('Arrêt du tracé effectué'));
      AddMessage(lang('Arrêt du tracé effectué'));
      pop_map.StopMap:=False;
      pop_camera.pop_image_acq.Bloque:=False;
      Button2.Enabled:=False;
      Exit;
      end;

   if (Pose/2>config.MinPose) then
      begin
      WriteSpy(lang('On divise le temps de pose par 2'));
      AddMessage(lang('On divise le temps de pose par 2'));
      Pose:=Pose/2;
      end
   else
      begin
      Pose:=config.MinPose;
      WriteSpy(lang('Temps de pose minimum atteint'));
      AddMessage(lang('Temps de pose minimum atteint'));
      end;
   WriteSpy(lang('Temps de pose = ')+MyFloatToStr(Pose,2));
   AddMessage(lang('Temps de pose = ')+MyFloatToStr(Pose,2));

   if (pop_map.XMap>LargFen+1) and (pop_map.YMap>LargFen+1) and (pop_map.XMap<Camera.GetXSize-LargFen)
      and (pop_map.YMap<Camera.GetYSize-LargFen) then
      begin
      pop_camera.Acquisition(pop_map.XMap-LargFen,pop_map.YMap-LargFen,pop_map.XMap+LargFen,pop_map.YMap+LargFen,Pose,1,False);

      //Soustraction du noir
      if NoirMAPAcquis  and pop_map.CheckBox1.Checked then
         begin
         GetImgPart(MemPicNoir,ImgDoubleNil,VignetteNoir,ImgDoubleNil,2,1,pop_camera.pop_image_acq.ImgInfos.Sx,
            pop_camera.pop_image_acq.ImgInfos.Sy,pop_map.XMap-LargFen,pop_map.YMap-LargFen,pop_map.XMap+LargFen,pop_map.YMap+LargFen);
         Soust(pop_camera.pop_image_acq.DataInt,VignetteNoir,ImgDoubleNil,ImgDoubleNil,2,1,pop_camera.pop_image_acq.ImgInfos.Sx,
            pop_camera.pop_image_acq.ImgInfos.Sy,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy);
         FreememImg(VignetteNoir,ImgDoubleNil,pop_camera.pop_image_acq.ImgInfos.Sx,pop_camera.pop_image_acq.ImgInfos.Sy,2,1);
         end;

      pop_camera.pop_image_acq.AjusteFenetre;
      pop_camera.pop_image_acq.VisuAutoEtoiles;
      end
   else
      begin
      WriteSpy(lang('Etoile trop près du bord'));
      WriteSpy(lang('Arrêt de la mise au point automatique'));
      AddMessage(lang('Etoile trop près du bord'));
      AddMessage(lang('Arrêt de la mise au point automatique'));
      pop_camera.pop_image_acq.Bloque:=False;         
      Exit;
      end;

   end;

if ValMax>=Camera.GetSaturationLevel then
   begin
   WriteSpy(lang('L''étoile reste saturée, cherchez un autre champ avec une étoile moins brillante'));
   WriteSpy(lang('Arrêt de la mise au point automatique'));
   AddMessage(lang('L''étoile reste saturée, cherchez un autre champ avec une étoile moins brillante'));
   AddMessage(lang('Arrêt de la mise au point automatique'));
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;}

Max:=Round(ValMax/2);

Fin:=False;
StopGetPos:=True;

try

if ComboBox2.ItemIndex=0 then
   begin
   WriteSpy('Début de l''étalonnage de la correction avant');
   AddMessage('Début de l''étalonnage de la correction avant');
   end
else
   begin
   WriteSpy('Début de l''étalonnage de la survitesse arrière');
   AddMessage('Début de l''étalonnage de la survitesse arrière');
   end;

//********************************************************************************************
//************************************   Début de l'étalonnage   *****************************
//********************************************************************************************

// Quand on appuie sur le bouton <Demarrer> le logiciel demande au
// focuseur de faire une manoeuvre préalable constituée d'un recul de durée
// égale à celle de la correction arrière suivi d'une avance de même durée.
// On aura ainsi à rattrapper le jeu maximal dès la première manoeuvre.

// Manoeuvre préalable
WriteSpy(lang('Manoeuvre préalable'));
Survitesse:=MyStrToFloat(NumberEdit4.Text);
if ComboBox2.ItemIndex=0 then
   begin
   if ComboBox1.ItemIndex=1 then
      begin
      Vitesse:=mapRapide;
      Config.ImpulsionAvantRapide:=SaveArR;
      Config.ImpulsionArriereRapide:=SaveArR;
      Config.SurvitesseRapide:=Survitesse;
      end
   else
      begin
      Vitesse:=mapLent;
      Config.ImpulsionAvantLente:=SaveArL;
      Config.ImpulsionArriereLente:=SaveArL;
      Config.SurvitesseLente:=Survitesse;
      end;
   end
else
   begin
   if ComboBox1.ItemIndex=1 then
      begin
      Vitesse:=mapRapide;
      Config.ImpulsionAvantRapide:=SaveAvR;
      Config.ImpulsionArriereRapide:=SaveArR;
      Config.SurvitesseRapide:=Survitesse;
      end
   else
      begin
      Vitesse:=mapLent;
      Config.ImpulsionAvantLente:=SaveAvL;
      Config.ImpulsionArriereLente:=SaveArL;
      Config.SurvitesseLente:=Survitesse;
      end;
   end;

Ok:=Focuser.FocuserMoveTime(mapArriere,Vitesse,Impulsion);
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   AddMessage(MyMessage);
   FocuserDisconnect;
   end;

//-il commence les essais avec une impulsion nominale egale a la valeur minimale de la correction avant ;

// Mesure initiale
// HFD / Moyenne / serie réduite si on a choisi la vitesse rapide ou normale si on a choisi la vitesse lente
if ComboBox1.ItemIndex=0 then
   begin
   Mesure1:=pop_map.Serie(Fwhm,Config.NbEssaiFocSlow,False,0,1,True,Temp,True,True,clRed);
   end
else
   begin
   Mesure1:=pop_map.Serie(Fwhm,Config.NbEssaiFocFast,False,0,1,True,Temp,True,True,clRed);
   end;

if (Mesure1=-1) or pop_map.StopMap then
   begin
   WriteSpy(lang('Arrêt du tracé effectué'));
   AddMessage(lang('Arrêt du tracé effectué'));
   pop_map.StopMap:=False;
   MapManuelle:=False;
   pop_camera.pop_image_acq.Bloque:=False;
   Button2.Enabled:=False;
   Exit;
   end;
if Mesure1=-1 then
   begin
   AddMessage('On a atteint le nombre maxi d''échecs de modélisation');
   AddMessage(lang('On arrête'));
   AddMessage('Changez d''étoile ou agrandissez la fenêtre de modélisation');
   pop_map.StopMap:=False;
   MapManuelle:=False;
   pop_camera.pop_image_acq.Bloque:=False;
   Button2.Enabled:=False;
   Exit;
   end;
if Mesure1=-3 then //Saturation
   begin
//   WriteSpy(lang('Etoile saturée, on arrête'));
//   if Assigned(pop_map_monitor) then
//      pop_map_monitor.AddMessage(lang('Etoile saturée, on arrête'));
   pop_map.StopMap:=False;
   MapManuelle:=False;
   pop_camera.pop_image_acq.Bloque:=False;
   Button2.Enabled:=False;
   Exit;
   end;

AddMessage(lang('HFD moyen initial = ')+MyFloatToStr(Mesure1,2));
WriteSpy(lang('HFD moyen initial = ')+MyFloatToStr(Mesure1,2));

if (Mesure1>Config.DiametreExtreme) or (Mesure1<Config.DiametreProche) then
   begin
   AddMessage(lang('Le focuseur est en dehors de la zone linéaire'));
   AddMessage(lang('vérifiez la position initiale et les paramères du tracé'));
   WriteSpy(lang('Le focuseur est en dehors de la zone linéaire'));
   WriteSpy(lang('vérifiez la position initiale et les paramères du tracé'));
   Exit;
   end;

// Mouvement initial
if ComboBox2.ItemIndex=0 then
   begin
   Impulsion:=MyStrToFloat(NumberEdit4.Text);

   if ComboBox1.ItemIndex=1 then
      begin
      Vitesse:=mapRapide;
      Config.ImpulsionAvantRapide:=Impulsion;
      end
   else
      begin
      Vitesse:=mapLent;
      Config.ImpulsionAvantLente:=Impulsion;
      end;
   for i:=1 to SpinEdit1.Value do
      begin
      Application.ProcessMessages;
      if pop_map.StopMap then
         begin
         WriteSpy(lang('Arrêt du tracé effectué'));
         AddMessage(lang('Arrêt du tracé effectué'));
         pop_map.StopMap:=False;
         MapManuelle:=False;
         pop_camera.pop_image_acq.Bloque:=False;
         Button2.Enabled:=False;
         Exit;
         end;
      Ok:=Focuser.FocuserMoveTime(mapAvant,Vitesse,0);
      if not OK then
         begin
         MyMessage:=Focuser.GetError;
         WriteSpy(MyMessage);
         AddMessage(MyMessage);
         FocuserDisconnect;
         end;
      end;
   end
else
   begin
   Impulsion:=MyStrToFloat(NumberEdit1.Text);
   Survitesse:=MyStrToFloat(NumberEdit4.Text);

   if ComboBox1.ItemIndex=1 then
      begin
      Vitesse:=mapRapide;
      Config.ImpulsionAvantRapide:=Impulsion+SaveAvR;
      Config.ImpulsionArriereRapide:=SaveArR;
      Config.SurvitesseRapide:=Survitesse;
      end
   else
      begin
      Vitesse:=mapLent;
      Config.ImpulsionAvantLente:=Impulsion+SaveAvL;
      Config.ImpulsionArriereLente:=SaveArL;
      Config.SurvitesseLente:=Survitesse;
      end;

   Ok:=Focuser.FocuserMoveTime(mapArriere,Vitesse,Impulsion);
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      AddMessage(MyMessage);
      FocuserDisconnect;
      end;
   end;


// Mesure finale
// HFD / Moyenne / serie réduite si on a choisi la vitesse rapide ou normale si on a choisi la vitesse lente
if ComboBox1.ItemIndex=0 then
   begin
   Mesure2:=pop_map.Serie(Fwhm,Config.NbEssaiFocSlow,False,0,1,True,Temp,True,True,clRed);
   end
else
   begin
   Mesure2:=pop_map.Serie(Fwhm,Config.NbEssaiFocFast,False,0,1,True,Temp,True,True,clRed);
   end;

if (Mesure1=-1) or pop_map.StopMap then
   begin
   WriteSpy(lang('Arrêt du tracé effectué'));
   AddMessage(lang('Arrêt du tracé effectué'));
   pop_map.StopMap:=False;
   MapManuelle:=False;
   pop_camera.pop_image_acq.Bloque:=False;
   Button2.Enabled:=False;
   Exit;
   end;
if Mesure1=-1 then
   begin
   AddMessage('On a atteint le nombre maxi d''échecs de modélisation');
   AddMessage(lang('On arrête'));
   AddMessage('Changez d''étoile ou agrandissez la fenêtre de modélisation');
   pop_map.StopMap:=False;
   MapManuelle:=False;
   pop_camera.pop_image_acq.Bloque:=False;
   Button2.Enabled:=False;
   Exit;
   end;
if Mesure1=-3 then //Saturation
   begin
//   WriteSpy(lang('Etoile saturée, on arrête'));
//   if Assigned(pop_map_monitor) then
//      pop_map_monitor.AddMessage(lang('Etoile saturée, on arrête'));
   pop_map.StopMap:=False;
   MapManuelle:=False;
   pop_camera.pop_image_acq.Bloque:=False;
   Button2.Enabled:=False;
   Exit;
   end;

if Mesure1<>-1 then
   begin
   AddMessage(lang('HFD moyen final = ')+MyFloatToStr(Mesure2,2));
   WriteSpy(lang('HFD moyen final = ')+MyFloatToStr(Mesure2,2));
   end;

if (Mesure2>Config.DiametreExtreme) or (Mesure2<Config.DiametreProche) then
   begin
   AddMessage(lang('Le focuseur est en dehors de la zone linéaire'));
   AddMessage(lang('vérifiez la position initiale et les paramères du tracé'));
   WriteSpy(lang('Le focuseur est en dehors de la zone linéaire'));
   WriteSpy(lang('vérifiez la position initiale et les paramères du tracé'));
   Exit;
   end;

//il verifie que le resultat est positif ; si ce n’est pas le cas il s’arrète et envoie un message du genre :
//« le focuseur avance au lieu de reculer, diminuez la valeur minimale de la correction avant ».
if Mesure2>Mesure1 then
   begin
   // Affichage
   Inc(NBMesure);
   if ComboBox2.ItemIndex=0 then
      AddGraph(Impulsion,Mesure2-Mesure1,clBlue)
   else
      AddGraph(Survitesse,Mesure2-Mesure1,clBlue);
   end
else
   begin
   AddMessage(lang('le focuseur avance au lieu de reculer'));
   WriteSpy(lang('le focuseur avance au lieu de reculer'));
   if ComboBox2.ItemIndex=0 then
      begin
      AddMessage(lang('diminuez la valeur minimale de la correction avant'));
      WriteSpy(lang('diminuez la valeur minimale de la correction avant'));
      end
   else
      begin
      AddMessage(lang('diminuez la valeur minimale de la survitesse arrière'));
      WriteSpy(lang('diminuez la valeur minimale de la survitesse arrière'));
      end;
   Exit;
   end;

//-il continue avec une impulsion nominale egale a la valeur maximale de la correction avant ;

// Mesure initiale
// HFD / Moyenne / serie réduite si on a choisi la vitesse rapide ou normale si on a choisi la vitesse lente
Mesure1:=Mesure2;
{if ComboBox1.ItemIndex=0 then
   begin
   Mesure1:=pop_map.Serie(Fwhm,Config.NbEssaiFocSlow,False,0,1,True);
   end
else
   begin
   Mesure1:=pop_map.Serie(Fwhm,Config.NbEssaiFocFast,False,0,1,True);
   end;}

AddMessage(lang('HFD moyen initial = ')+MyFloatToStr(Mesure1,2));
WriteSpy(lang('HFD moyen initial = ')+MyFloatToStr(Mesure1,2));

// Mouvement
if ComboBox2.ItemIndex=0 then
   begin
   Impulsion:=MyStrToFloat(NumberEdit5.Text);

   if ComboBox1.ItemIndex=1 then
      begin
      Vitesse:=mapRapide;
      Config.ImpulsionAvantRapide:=Impulsion;
      end
   else
      begin
      Vitesse:=mapLent;
      Config.ImpulsionAvantLente:=Impulsion;
      end;
   for i:=1 to SpinEdit1.Value do
      begin
      Application.ProcessMessages;
      if pop_map.StopMap then
         begin
         WriteSpy(lang('Arrêt du tracé effectué'));
         AddMessage(lang('Arrêt du tracé effectué'));
         pop_map.StopMap:=False;
         MapManuelle:=False;
         pop_camera.pop_image_acq.Bloque:=False;
         Button2.Enabled:=False;
         Exit;
         end;
      Ok:=Focuser.FocuserMoveTime(mapAvant,Vitesse,0);
      if not OK then
         begin
         MyMessage:=Focuser.GetError;
         WriteSpy(MyMessage);
         AddMessage(MyMessage);
         FocuserDisconnect;
         end;
      end;
   end
else
   begin
   Impulsion:=MyStrToFloat(NumberEdit1.Text);
   Survitesse:=MyStrToFloat(NumberEdit5.Text);

   if ComboBox1.ItemIndex=1 then
      begin
      Vitesse:=mapRapide;
      Config.ImpulsionAvantRapide:=Impulsion+SaveAvR;
      Config.ImpulsionArriereRapide:=SaveArR;
      Config.SurvitesseRapide:=Survitesse;
      end
   else
      begin
      Vitesse:=mapLent;
      Config.ImpulsionAvantLente:=Impulsion+SaveAvL;
      Config.ImpulsionArriereLente:=SaveArL;
      Config.SurvitesseLente:=Survitesse;
      end;
   Ok:=Focuser.FocuserMoveTime(mapArriere,Vitesse,Impulsion);
   if not OK then
      begin
      MyMessage:=Focuser.GetError;
      WriteSpy(MyMessage);
      AddMessage(MyMessage);
      FocuserDisconnect;
      end;
   end;


// Mesure finale
// HFD / Moyenne / serie réduite si on a choisi la vitesse rapide ou normale si on a choisi la vitesse lente
if ComboBox1.ItemIndex=0 then
   begin
   Mesure2:=pop_map.Serie(Fwhm,Config.NbEssaiFocSlow,False,0,1,True,Temp,True,True,clRed);
   end
else
   begin
   Mesure2:=pop_map.Serie(Fwhm,Config.NbEssaiFocFast,False,0,1,True,Temp,True,True,clRed);
   end;

if (Mesure1=-1) or pop_map.StopMap then
   begin
   WriteSpy(lang('Arrêt du tracé effectué'));
   AddMessage(lang('Arrêt du tracé effectué'));
   pop_map.StopMap:=False;
   MapManuelle:=False;
   pop_camera.pop_image_acq.Bloque:=False;
   Button2.Enabled:=False;
   Exit;
   end;
if Mesure2=-1 then
   begin
   AddMessage('On a atteint le nombre maxi d''échecs de modélisation');
   AddMessage(lang('On arrête'));
   AddMessage('Changez d''étoile ou agrandissez la fenêtre de modélisation');
   pop_map.StopMap:=False;
   MapManuelle:=False;
   pop_camera.pop_image_acq.Bloque:=False;
   Button2.Enabled:=False;
   Exit;
   end;
if Mesure2=-3 then //Saturation
   begin
//   WriteSpy(lang('Etoile saturée, on arrête'));
//   if Assigned(pop_map_monitor) then
//      pop_map_monitor.AddMessage(lang('Etoile saturée, on arrête'));
   pop_map.StopMap:=False;
   MapManuelle:=False;
   pop_camera.pop_image_acq.Bloque:=False;
   Button2.Enabled:=False;
   Exit;
   end;

if (Mesure2>Config.DiametreExtreme) or (Mesure2<Config.DiametreProche) then
   begin
   AddMessage(lang('Le focuseur est en dehors de la zone linéaire'));
   AddMessage(lang('vérifiez la position initiale et les paramères du tracé'));
   WriteSpy(lang('Le focuseur est en dehors de la zone linéaire'));
   WriteSpy(lang('vérifiez la position initiale et les paramères du tracé'));
   Exit;
   end;

if Mesure1<>-1 then
   begin
   AddMessage(lang('HFD moyen final = ')+MyFloatToStr(Mesure2,2));
   WriteSpy(lang('HFD moyen final = ')+MyFloatToStr(Mesure2,2));
   end;

// il verifie que le resultat est negatif ; si ce n’est pas le cas il s’arrète et envoie un message du genre :
//« le focuseur recule  au lieu de d’avancer, augmentez la valeur maximale de la correction avant ».
if Mesure2<Mesure1 then
   begin
   // Affichage
   Inc(NBMesure);
   if ComboBox2.ItemIndex=0 then
      AddGraph(Impulsion,Mesure2-Mesure1,clBlue)
   else
      AddGraph(Survitesse,Mesure2-Mesure1,clBlue);
   end
else
   begin
   AddMessage(lang('le focuseur recule  au lieu de d’avancer'));
   WriteSpy(lang('le focuseur recule  au lieu de d’avancer'));
   if ComboBox2.ItemIndex=0 then
      begin
      WriteSpy(lang('augmentez la valeur maximale de la correction avant'));
      AddMessage(lang('augmentez la valeur maximale de la correction avant'));
      end
   else
      begin
      WriteSpy(lang('augmentez la valeur maximale de la survitesse arrière'));
      AddMessage(lang('augmentez la valeur maximale de la survitesse arrière'));
      end;
   Exit;
   end;

//-si les deux résultats précédents ont un signe correct, il continue en ajoutant un increment a la valeur minimale
//puis deux et ainsi de suite jusqu'à atteindre la valeur maximale de la correction avant diminuee d'un incrément.

//********************************************************************************************
//**************************************   Boucle principale   *******************************
//********************************************************************************************
TimeMove:=0;
NbMesure:=0;
YMaxGraph:=MaxDouble;
Descend:=False;
Monte:=False;
MinPasse:=False;
if ComboBox2.ItemIndex=0 then
   Impulsion:=MyStrToFloat(NumberEdit4.Text)+MyStrToFloat(NumberEdit3.Text)
else
   Survitesse:=MyStrToFloat(NumberEdit4.Text)+MyStrToFloat(NumberEdit3.Text);
while not(Fin) do
   begin
   if pop_map.StopMap then
      begin
      WriteSpy(lang('Arrêt du tracé effectué'));
      AddMessage(lang('Arrêt du tracé effectué'));
      pop_map.StopMap:=False;
      MapManuelle:=False;
      pop_camera.pop_image_acq.Bloque:=False;
      Button2.Enabled:=False;
      Exit;
      end;

   // Mesure initiale
   // HFD / Moyenne / serie réduite si on a choisi la vitesse rapide ou normale si on a choisi la vitesse lente
   Mesure1:=Mesure2;
{   if ComboBox1.ItemIndex=0 then
      begin
      Mesure1:=pop_map.Serie(Fwhm,Config.NbEssaiFocSlow,False,0,1,True);
      end
   else
      begin
      Mesure1:=pop_map.Serie(Fwhm,Config.NbEssaiFocFast,False,0,1,True);
      end;}

   if Mesure1<>-1 then
      begin
      AddMessage(lang('HFD moyen initial = ')+MyFloatToStr(Mesure1,2));
      WriteSpy(lang('HFD moyen initial = ')+MyFloatToStr(Mesure1,2));
      end;

   // Mouvement
   if ComboBox2.ItemIndex=0 then
      begin
      if ComboBox1.ItemIndex=1 then
         begin
         Vitesse:=mapRapide;
         Config.ImpulsionAvantRapide:=Impulsion;
         end
      else
         begin
         Vitesse:=mapLent;
         Config.ImpulsionAvantLente:=Impulsion;
         end;
      for i:=1 to SpinEdit1.Value do
         begin
         Application.ProcessMessages;
         if pop_map.StopMap then
            begin
            WriteSpy(lang('Arrêt du tracé effectué'));
            AddMessage(lang('Arrêt du tracé effectué'));
            pop_map.StopMap:=False;
            MapManuelle:=False;
            pop_camera.pop_image_acq.Bloque:=False;
            Button2.Enabled:=False;
            Exit;
            end;
         Ok:=Focuser.FocuserMoveTime(mapAvant,Vitesse,0);
         if not OK then
            begin
            MyMessage:=Focuser.GetError;
            WriteSpy(MyMessage);
            AddMessage(MyMessage);
            FocuserDisconnect;
            end;
         end;
      end
   else
      begin
      if ComboBox1.ItemIndex=1 then
         begin
         Vitesse:=mapRapide;
         Config.ImpulsionAvantRapide:=Impulsion+SaveAvR;
         Config.ImpulsionArriereRapide:=SaveArR;
         Config.SurvitesseRapide:=Survitesse;
         end
      else
         begin
         Vitesse:=mapLent;
         Config.ImpulsionAvantLente:=Impulsion+SaveAvL;
         Config.ImpulsionArriereLente:=SaveArL;
         Config.SurvitesseLente:=Survitesse;
         end;
      Ok:=Focuser.FocuserMoveTime(mapArriere,Vitesse,Impulsion);
      if not OK then
         begin
         MyMessage:=Focuser.GetError;
         WriteSpy(MyMessage);
         AddMessage(MyMessage);
         FocuserDisconnect;
         end;
      end;

   // Mesure finale
   // HFD / Moyenne / serie réduite si on a choisi la vitesse rapide ou normale si on a choisi la vitesse lente
   if ComboBox1.ItemIndex=0 then
      begin
      Mesure2:=pop_map.Serie(Fwhm,Config.NbEssaiFocSlow,False,0,1,True,Temp,True,True,clRed);
      end
   else
      begin
      Mesure2:=pop_map.Serie(Fwhm,Config.NbEssaiFocFast,False,0,1,True,Temp,True,True,clRed);
      end;

   if (Mesure1=-1) or pop_map.StopMap then
      begin
      WriteSpy(lang('Arrêt du tracé effectué'));
      AddMessage(lang('Arrêt du tracé effectué'));
      pop_map.StopMap:=False;
      MapManuelle:=False;
      pop_camera.pop_image_acq.Bloque:=False;
      Button2.Enabled:=False;
      Exit;
      end;
   if Mesure1=-1 then
      begin
      AddMessage('On a atteint le nombre maxi d''échecs de modélisation');
      AddMessage(lang('On arrête'));
      AddMessage('Changez d''étoile ou agrandissez la fenêtre de modélisation');
      pop_map.StopMap:=False;
      MapManuelle:=False;
      pop_camera.pop_image_acq.Bloque:=False;
      Button2.Enabled:=False;
      Exit;
      end;
   if Mesure1=-3 then //Saturation
      begin
//      WriteSpy(lang('Etoile saturée, on arrête'));
//      if Assigned(pop_map_monitor) then
//         pop_map_monitor.AddMessage(lang('Etoile saturée, on arrête'));
      pop_map.StopMap:=False;
      MapManuelle:=False;
      pop_camera.pop_image_acq.Bloque:=False;
      Button2.Enabled:=False;
      Exit;
      end;

   if Mesure1<>-1 then
      begin
      AddMessage(lang('HFD moyen final = ')+MyFloatToStr(Mesure2,2));
      WriteSpy(lang('HFD moyen final = ')+MyFloatToStr(Mesure2,2));
      end;

   if (Mesure2>Config.DiametreExtreme) or (Mesure2<Config.DiametreProche) then
      begin
      AddMessage(lang('Le focuseur est en dehors de la zone linéaire'));
      AddMessage(lang('vérifiez la position initiale et les paramères du tracé'));
      WriteSpy(lang('Le focuseur est en dehors de la zone linéaire'));
      WriteSpy(lang('vérifiez la position initiale et les paramères du tracé'));
      Exit;
      end;

   // Affichage
   Inc(NBMesure);
   if ComboBox2.ItemIndex=0 then
      AddGraph(Impulsion,Mesure2-Mesure1,clBlue)
   else
      AddGraph(Survitesse,Mesure2-Mesure1,clBlue);

   if ComboBox2.ItemIndex=0 then
      begin
      Impulsion:=Impulsion+MyStrToFloat(NumberEdit3.Text);
      if Impulsion>=MyStrToFloat(NumberEdit5.Text) then Fin:=True;
      end
   else
      begin
      Survitesse:=Survitesse+MyStrToFloat(NumberEdit3.Text);
      if Survitesse>=MyStrToFloat(NumberEdit5.Text) then Fin:=True;
      end;
   end;

if ComboBox2.ItemIndex=0 then
   begin
   AddMessage('Fin de l''étalonnage de la correction avant');
   WriteSpy('Fin de l''étalonnage de la correction avant');
   end
else
   begin
   AddMessage('Fin de l''étalonnage de la survitesse arrière');
   WriteSpy('Fin de l''étalonnage de la survitesse arrière');
   end;

pop_map.btn_manuel.Enabled:=True;
pop_map.btn_auto.Enabled:=True;
pop_map.Button5.Enabled:=True;
pop_map.Button1.Enabled:=True;
pop_map.BitBtn1.Enabled:=True;
pop_map.BitBtn2.Enabled:=True;
pop_map.BitBtn3.Enabled:=True;
pop_map.BitBtn4.Enabled:=True;
pop_map.delai_ms.Enabled:=True;
pop_map.SpinButton1.Enabled:=True;
pop_map.Button2.Enabled:=True;
pop_map.Button3.Enabled:=True;
pop_map.Button4.Enabled:=True;
pop_map.Edit1.Enabled:=True;
pop_map.Label1.Enabled:=True;
pop_map.Panel1.Enabled:=True;
pop_map.TrackBar1.Enabled:=True;

MAJGraphe;

finally
StopGetPos:=False;
end;

finally
TesteFocalisation:=False;
pop_camera.pop_image_acq.Bloque:=False;
pop_map.btn_manuel.Enabled:=True;
pop_map.btn_auto.Enabled:=True;
pop_map.Button5.Enabled:=True;
pop_map.Button1.Enabled:=True;
pop_map.Edit5.Enabled:=True;
pop_map.SpinButton2.Enabled:=True;

Button2.Enabled:=False;

Config.ImpulsionAvantRapide:=SaveAvR;
Config.ImpulsionAvantLente:=SaveAvL;
Config.ImpulsionArriereRapide:=SaveArR;
Config.ImpulsionArriereLente:=SaveArL;
Config.SurvitesseLente:=SurL;
Config.SurvitesseRapide:=SurR;
end;
end;

procedure Tpop_cmde_corr.MAJGraphe;
var
   IndexMin,IndexMax:LongWord;
   NbPointsUtiles:LongWord;
   i:Integer;
   ALine,BLine,Error:Double;
begin
if CountGraph>1 then
   begin
   Update:=True;
   try

   LineFitGraph(1,CountGraph,clBlack,ALine,BLine,Error);
   // 18:37:45 Pente de la droite de récession = 12 pix / sec
   // 18:37:45 Ordonnée à l'origine = 7.5 pix
   if ComboBox2.ItemIndex=0 then
      begin
      WriteSpy(lang('Pente de la droite de régression = ')+MyFloatToStr(ALine*1000,2)+lang(' pix/sec'));
      WriteSpy('Ordonnée à l''origine = '+MyFloatToStr(BLine,2)+lang(' pix'));
      end
   else
      begin
      WriteSpy(lang('Pente de la droite de régression = ')+MyFloatToStr(ALine*1000,2)+lang(' millipix/%'));
      WriteSpy('Ordonnée à l''origine = '+MyFloatToStr(BLine*1000,2)+lang(' millipix'));
      end;
   Edit1.Text:=MyFloatToStr(-Bline/ALine,3);
   Edit2.Text:=IntToStr(CountGraph);
   Edit3.Text:=MyFloatToStr(Error,3);

//   if (Edit1.Text<>lang('NAN')) and (ComboBox2.ItemIndex=0) then Button3.Enabled:=True;
   if (Edit1.Text<>lang('NAN')) then Button3.Enabled:=True;

   finally
   Update:=False;
   end;
   end;
end;

procedure Tpop_cmde_corr.Button2Click(Sender: TObject);
begin
WriteSpy(lang('Arrêt du tracé demandé'));
AddMessage(lang('Arrêt du tracé demandé'));
pop_map.StopMap:=True;
Button2.Enabled:=False;
end;

procedure Tpop_cmde_corr.FormCreate(Sender: TObject);
var
   OK:Boolean;
   MyMessage:string;
begin
if Assigned(pop_map_monitor) then pop_map_monitor.Close;
Button2.Enabled:=False;
pop_map.Hide;
CreateGraph;
//if ComboBox3.ItemIndex=0 then OK:=Focuser.SetCorrectionOn else OK:=Focuser.SetCorrectionOff;
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   ShowMessage(MyMessage);
   FocuserDisconnect;
   end;

//NumberEdit1.Text:=MyFloatToStr(Config.DiametreExtreme,1);
//NumberEdit2.Text:=MyFloatToStr(Config.DiametreProche,1);
//SetAutoYMinGraph(False);
//SetYMinGraph(0);
LoadParam;
end;


procedure Tpop_cmde_corr.SaveParam;
var
   Path,Name,Section:string;
   FText:TextFile;
   i:Integer;
begin
// Quand on ferme la fenetre, on sauvegarde :
// - Les parametres de la zone linéaire utilisable
// - Les parametres du trace de la droite

if (CountGraph<>0) and (Edit1.Text<>lang('NAN')) then
   begin
   Section:=IntToStr(ComboBox1.ItemIndex)+IntToStr(ComboBox2.ItemIndex);
   Path:=ExtractFilePath(Application.Exename);
   Name:=Path+'CGraph'+Section+'.sav'; //nolang
   AssignFile(FText,Name);
   Rewrite(FText);
//   Writeln(FText,NumberEdit1.Text);
//   Writeln(FText,NumberEdit2.Text);
   if ComboBox2.ItemIndex=0 then
      Writeln(FText,SpinEdit1.Text)
   else
      Writeln(FText,NumberEdit1.Text);
   Writeln(FText,NumberEdit3.Text);
   Writeln(FText,NumberEdit4.Text);
   Writeln(FText,NumberEdit5.Text);
   Writeln(FText,Edit1.Text);
   Writeln(FText,Edit2.Text);
   Writeln(FText,Edit3.Text);

//   Writeln(FText,FloatToStr(GetYLineGraph(1)));
//   Writeln(FText,FloatToStr(GetYLineGraph(2)));
   Writeln(FText,IntToStr(CountGraph));
   for i:=1 to CountGraph do
      begin
      Writeln(FText,GetXGraph(i));
      Writeln(FText,GetYGraph(i));
      end;

   CloseFile(FText);
   end;
end;

procedure Tpop_cmde_corr.LoadParam;
var
   Path,Name,Section,Line:string;
   FText:TextFile;
   i,NbPoints:LongWord;
   X,Y:Double;
begin
Update:=True;
try
ClearGraph;

Section:=IntToStr(ComboBox1.ItemIndex)+IntToStr(ComboBox2.ItemIndex);
Path:=ExtractFilePath(Application.Exename);
Name:=Path+'CGraph'+Section+'.sav'; //nolang
if FileExists(Name) then
   begin
   AssignFile(FText,Name);
   Reset(FText);
//   Readln(FText,Line);
//   NumberEdit1.Text:=Line;
//   Readln(FText,Line);
//   NumberEdit2.Text:=Line;
   Readln(FText,Line);
   if ComboBox2.ItemIndex=0 then
      SpinEdit1.Text:=Line
   else
      NumberEdit1.Text:=Line;   
   Readln(FText,Line);
   NumberEdit3.Text:=Line;
   Readln(FText,Line);
   NumberEdit4.Text:=Line;
   Readln(FText,Line);
   NumberEdit5.Text:=Line;
   Readln(FText,Line);
   Edit1.Text:=Line;
   Readln(FText,Line);
   Edit2.Text:=Line;
   Readln(FText,Line);
   Edit3.Text:=Line;
//   Readln(FText,Line);
//   AddYLineGraph(MyStrToFloat(Line),clBlue);
//   Readln(FText,Line);
//   AddYLineGraph(MyStrToFloat(Line),clBlue);
   Readln(FText,Line);
   NbPoints:=StrToInt(Line);
   for i:=1 to NbPoints do
      begin
      Readln(FText,Line);
      X:=MyStrToFloat(Line);
      Readln(FText,Line);
      Y:=MyStrToFloat(Line);
      AddGraph(X,Y,clBlue);
      end;

   CloseFile(FText);

   MAJGraphe;
   end
else
   begin
   if ComboBox2.ItemIndex=0 then
      begin
      //-nb d'impulsions............10............10
      //-incrément...................100...........10
      //-valeur mini.................100...........20
      //-valeur maxi................800...........80
      if ComboBox1.ItemIndex=0 then
         begin
         SpinEdit1.Text:='10'; //nolang
         NumberEdit3.Text:='100'; //nolang
         NumberEdit4.Text:='100'; //nolang
         NumberEdit5.Text:='800'; //nolang
         end
      else
         begin
         SpinEdit1.Text:='10'; //nolang
         NumberEdit3.Text:='10'; //nolang
         NumberEdit4.Text:='20'; //nolang
         NumberEdit5.Text:='80'; //nolang
         end;
      end
   else
      begin
      //-aller-retour...............3000.........400
      //-incrément.....................10...........10
      //-valeur mini................ -10..........-10
      //-valeur maxi..................50...........50
      if ComboBox1.ItemIndex=0 then
         begin
         NumberEdit1.Text:='3000'; //nolang
         NumberEdit3.Text:='10'; //nolang
         NumberEdit4.Text:='-10'; //nolang
         NumberEdit5.Text:='50'; //nolang
         end
      else
         begin
         NumberEdit1.Text:='400'; //nolang
         NumberEdit3.Text:='10'; //nolang
         NumberEdit4.Text:='-10'; //nolang
         NumberEdit5.Text:='50'; //nolang
         end;
      end;
   end;


finally
Update:=False;
end;
end;

procedure Tpop_cmde_corr.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//SaveParam;

FreeGraph;

if Assigned(pop_camera.pop_image_acq) then pop_camera.pop_image_acq.Close;
end;

procedure Tpop_cmde_corr.SpinButton3DownClick(Sender: TObject);
var
   Increment:Integer;
begin
if ComboBox2.ItemIndex=0 then Increment:=10 else Increment:=5;
if MyStrToFloat(NumberEdit3.Text)-Increment>=Increment then
   NumberEdit3.Text:=MyFloatToStr(MyStrToFloat(NumberEdit3.Text)-Increment,2);
end;

procedure Tpop_cmde_corr.SpinButton3UpClick(Sender: TObject);
var
   Increment:Integer;
begin
if ComboBox2.ItemIndex=0 then Increment:=10 else Increment:=5;
NumberEdit3.Text:=MyFloatToStr(MyStrToFloat(NumberEdit3.Text)+Increment,2);
end;

procedure Tpop_cmde_corr.Button3Click(Sender: TObject);
var
   Path:string;
begin
// La valeur de la correction avant est sauvegarde dans le volet "Commande corrigée"
// de la config dans la colonne de la vitesse correspondante :
//    Config.ImpulsionAvantRapide:=MyStrToFloat(NbreEditImpAvRap.Text);
//    Config.ImpulsionAvantLente:=MyStrToFloat(NbreEditImpAvLent.Text);

// Il en est de meme pour la survitesse arriere
//    Config.SurvitesseRapide:=MyStrToFloat(NbreEditSurRap.Text);
//    Config.SurvitesseLente:=MyStrToFloat(NbreEditSurLent.Text);

if (CountGraph<>0) then
   begin
   if ComboBox2.ItemIndex=0 then // Correction Avant
      begin
      if ComboBox1.ItemIndex=0 then // Lente
         begin
         Config.ImpulsionAvantLente:=MyStrToFloat(Edit1.Text);
         end
      else
         begin // Rapide
         Config.ImpulsionAvantRapide:=MyStrToFloat(Edit1.Text);
         end;
      end
   else
      begin // Survitesse arriere
      if ComboBox1.ItemIndex=0 then // Lente
         begin
         Config.SurvitesseLente:=MyStrToFloat(Edit1.Text);
         end
      else
         begin // Rapide
         Config.SurvitesseRapide:=MyStrToFloat(Edit1.Text);
         end;
      end;

   Path:=ExtractFilePath(Application.ExeName);
   SaveParametres(Path+'TeleAuto.ini');  //nolang
   end;

SaveParam;

Button3.Enabled:=False;
end;

procedure Tpop_cmde_corr.ComboBox1Change(Sender: TObject);
begin
LoadParam;
end;

procedure Tpop_cmde_corr.UpdateGUI;
begin
if ComboBox2.ItemIndex=0 then
   begin
   Label5.Caption:='Nombre d''impulsions de 0 ms :';
   Label6.Caption:=lang('Incrément (ms) :');
   Label7.Caption:=lang('Valeur minimale (ms) :');
   Label11.Caption:=lang('Valeur maximale (ms) :');
   Label8.Caption:=lang('Correction AV (ms) :');
   SpinEdit1.Visible:=True;
   NumberEdit1.Visible:=False;
   SpinButton1.Visible:=False;
   end
else
   begin
   Label5.Caption:=lang('Durée des aller-retour en ms :');
   Label6.Caption:=lang('Incrément (%) :');
   Label7.Caption:=lang('Valeur minimale (%) :');
   Label11.Caption:=lang('Valeur maximale (%) :');
   Label8.Caption:=lang('Survitesse AR (%) :');
   SpinEdit1.Visible:=False;
   NumberEdit1.Visible:=True;
   SpinButton1.Visible:=True;
   end;
end;

procedure Tpop_cmde_corr.ComboBox2Change(Sender: TObject);
begin
UpdateGUI;
LoadParam;
if ComboBox2.ItemIndex=0 then
   Label14.Caption:=lang('HFD (Pixels,Millisecondes)')
else
   Label14.Caption:=lang('HFD (Pixels,%)')
end;

procedure Tpop_cmde_corr.Image1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
   XOut,YOut:Double;
begin
XImageToGraphGraph(X,XOut);
YImageToGraphGraph(Y,YOut);
Label13.Caption:=MyFloatToStr(XOut,2)+' / '+MyFloatToStr(YOut,2);
end;

procedure Tpop_cmde_corr.SpinButton4DownClick(Sender: TObject);
var
   Increment:Integer;
begin
if ComboBox2.ItemIndex=0 then
   begin
   Increment:=10;
   if MyStrToFloat(NumberEdit4.Text)-Increment>=Increment then
      NumberEdit4.Text:=MyFloatToStr(MyStrToFloat(NumberEdit4.Text)-Increment,2);
   end
else
   begin
   Increment:=5;
   NumberEdit4.Text:=MyFloatToStr(MyStrToFloat(NumberEdit4.Text)-Increment,2);   
   end;
end;

procedure Tpop_cmde_corr.SpinButton4UpClick(Sender: TObject);
var
   Increment:Integer;
begin
if ComboBox2.ItemIndex=0 then Increment:=10 else Increment:=5;
NumberEdit4.Text:=MyFloatToStr(MyStrToFloat(NumberEdit4.Text)+Increment,2);
end;

procedure Tpop_cmde_corr.SpinButton5DownClick(Sender: TObject);
var
   Increment:Integer;
begin
if ComboBox2.ItemIndex=0 then Increment:=10 else Increment:=5;
if MyStrToFloat(NumberEdit5.Text)-Increment>=Increment then
   NumberEdit5.Text:=MyFloatToStr(MyStrToFloat(NumberEdit5.Text)-Increment,2);
end;

procedure Tpop_cmde_corr.SpinButton5UpClick(Sender: TObject);
var
   Increment:Integer;
begin
if ComboBox2.ItemIndex=0 then Increment:=10 else Increment:=5;
NumberEdit5.Text:=MyFloatToStr(MyStrToFloat(NumberEdit5.Text)+Increment,2);
end;

procedure Tpop_cmde_corr.FormShow(Sender: TObject);
begin
UpdateGUI;
end;

procedure Tpop_cmde_corr.SpinButton1DownClick(Sender: TObject);
begin
if MyStrToFloat(NumberEdit1.Text)-100>=100 then
   NumberEdit1.Text:=MyFloatToStr(MyStrToFloat(NumberEdit1.Text)-100,2);
end;

procedure Tpop_cmde_corr.SpinButton1UpClick(Sender: TObject);
begin
NumberEdit1.Text:=MyFloatToStr(MyStrToFloat(NumberEdit1.Text)+100,2);
end;

procedure Tpop_cmde_corr.Button4Click(Sender: TObject);
var
   T:TextFile;
   Name:String;
   i:Integer;
begin
pop_main.SaveDialog.Filter:=lang('Fichiers Textes *.txt|*.txt');
if pop_main.SaveDialog.Execute then
   begin
   Name:=pop_main.SaveDialog.FileName;
   if UpperCase(ExtractFileExt(Name))<>'.TXT' then Name:=Name+'.txt'; //nolang
   AssignFile(T,Name);
   Rewrite(T);
   try
   i:=1;
   while i<=CountGraph do
      begin
      Writeln(T,FloatToStrF(XGraph^[i],ffFixed,4,2)
         +' '+FloatToStrF(YGraph^[i],ffFixed,4,2));
      Inc(i);
      end;

   finally
   System.Close(T);
   end;
   end;
end;

procedure Tpop_cmde_corr.Button5Click(Sender: TObject);
var
   T:TextFile;
   Name:String;
   i:Integer;
begin
pop_main.SaveDialog.Filter:=lang('Fichiers Textes *.txt|*.txt');
if pop_main.SaveDialog.Execute then
   begin
   Name:=pop_main.SaveDialog.FileName;
   if UpperCase(ExtractFileExt(Name))<>'.TXT' then Name:=Name+'.txt'; //nolang
   AssignFile(T,Name);
   Rewrite(T);
   try
   i:=0;
   while i<=ListBox1.Items.Count-1 do
      begin
      Writeln(T,ListBox1.Items[i]);
      Inc(i);
      end;
   finally
   System.Close(T);
   end;
   end;
end;

end.
