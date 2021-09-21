unit pu_calib_autov;

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
  Tpop_calib_autov = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    Label11: TLabel;
    NumberEdit2: TNumberEdit;
    NumberEdit3: TNumberEdit;
    NumberEdit1: TNumberEdit;
    Label12: TLabel;
    ListBox1: TListBox;
    Image1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    ComboBox3: TComboBox;
    Label13: TLabel;
    SpinButton1: TSpinButton;
    SpinButton2: TSpinButton;
    SpinButton3: TSpinButton;
    Label14: TLabel;
    Label15: TLabel;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NumberEdit2Change(Sender: TObject);
    procedure NumberEdit3Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure SpinButton2DownClick(Sender: TObject);
    procedure SpinButton2UpClick(Sender: TObject);
    procedure SpinButton3DownClick(Sender: TObject);
    procedure SpinButton3UpClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
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
    ALine,BLine,Error:Double;
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
    procedure LineFitGraph(IndexMin,IndexMax:LongWord;Color:TColor);

    procedure AddMessage(MyMessage:string);
    procedure WriteMessage(MyMessage:string);
    procedure LoadParam;
    procedure SaveParam;
    procedure UpdateDiametre(AutoUpdate:Boolean);
  end;

var
   pop_calib_autov:Tpop_calib_autov;

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

// A appeller au début
procedure Tpop_calib_autov.CreateGraph;
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

procedure Tpop_calib_autov.ClearGraph;
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

procedure Tpop_calib_autov.FreeGraph;
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

procedure Tpop_calib_autov.EffaceGraph;
begin
Image1.Canvas.Pen.Mode:=pmCopy;
Image1.Canvas.Pen.Style:=psSolid;
Image1.Canvas.Pen.Color:=BKColor;
Image1.Canvas.Brush.Color:=BKColor;
Image1.Canvas.Brush.Style:=bsSolid;
Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
end;

procedure Tpop_calib_autov.DrawAxisGraph;
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

procedure Tpop_calib_autov.SetMirrorOnGraph;
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

procedure Tpop_calib_autov.SetMirrorOffGraph;
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

procedure Tpop_calib_autov.SetAutoXMinGraph(Auto:Boolean);
begin
AutoUpdateXMin:=Auto;
UpDateGraph;
end;

procedure Tpop_calib_autov.SetXMinGraph(XMin:Double);
begin
XGraphMin:=XMin;
end;

procedure Tpop_calib_autov.SetAutoXMaxGraph(Auto:Boolean);
begin
AutoUpdateXMax:=Auto;
UpDateGraph;
end;

procedure Tpop_calib_autov.SetXMaxGraph(XMax:Double);
begin
XGraphMax:=XMax;
end;

procedure Tpop_calib_autov.SetAutoYMinGraph(Auto:Boolean);
begin
AutoUpdateYMin:=Auto;
UpDateGraph;
end;

procedure Tpop_calib_autov.SetYMinGraph(YMin:Double);
begin
YGraphMin:=YMin;
end;

procedure Tpop_calib_autov.SetAutoYMaxGraph(Auto:Boolean);
begin
AutoUpdateYMax:=Auto;
UpDateGraph;
end;

procedure Tpop_calib_autov.SetYMaxGraph(YMax:Double);
begin
YGraphMax:=YMax;
end;

function Tpop_calib_autov.CountGraph:LongWord;
begin
Result:=NBPoints;
end;

procedure Tpop_calib_autov.AddGraph(X,Y:Double;_Color:TColor);
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
      if AutoUpdateXMin then XGraphMin:=Round((1-Tolerance)*X);
      if AutoUpdateXMax then XGraphMax:=Round((1+Tolerance)*X);
      end
   else
      begin
      if AutoUpdateXMin then XGraphMin:=Round(X-1);
      if AutoUpdateXMax then XGraphMax:=Round(X+1);
      end;
   if Y<>0 then
      begin
      if AutoUpdateYMin then YGraphMin:=Round((1-Tolerance)*Y);
      if AutoUpdateYMax then YGraphMax:=Round((1+Tolerance)*Y);
      end
   else
      begin
      if AutoUpdateYMin then YGraphMin:=Round(Y-1);
      if AutoUpdateYMax then YGraphMax:=Round(Y+1);
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

procedure Tpop_calib_autov.UpDateGraph;
begin
EffaceGraph;
DrawAxisGraph;
DisplayGraph;
DrawLinesGraph;
end;

procedure Tpop_calib_autov.LineFitGraph(IndexMin,IndexMax:LongWord;Color:TColor);
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


procedure Tpop_calib_autov.XGraphToImageGraph(Xin:Double;var XOut:LongWord);
begin
XOut:=Round(ax*XIn+bx);
end;

procedure Tpop_calib_autov.YGraphToImageGraph(Yin:Double;var YOut:LongWord);
begin
YOut:=Round(ay*YIn+by);
end;

procedure Tpop_calib_autov.GraphToImageGraph(Xin,Yin:Double;var XOut,YOut:LongWord);
begin
XGraphToImageGraph(Xin,XOut);
YGraphToImageGraph(Yin,YOut);
end;

procedure Tpop_calib_autov.XImageToGraphGraph(XIn:LongWord;var XOut:Double);
begin
XOut:=(XIn-bx)/ax;
end;

procedure Tpop_calib_autov.YImageToGraphGraph(YIn:LongWord;var YOut:Double);
begin
YOut:=(YIn-by)/ay;
end;

procedure Tpop_calib_autov.ImageToGraphGraph(XIn,YIn:LongWord;var XOut,YOut:Double);
begin
XImageToGraphGraph(XIn,XOut);
YImageToGraphGraph(YIn,YOut);
end;

function Tpop_calib_autov.GetXGraph(Index:LongWord):Double;
begin
Result:=XGraph^[Index];
end;

function Tpop_calib_autov.GetYGraph(Index:LongWord):Double;
begin
Result:=YGraph^[Index];
end;

function Tpop_calib_autov.GetXMinGraph:Double;
begin
Result:=XPointGraphMin;
end;

function Tpop_calib_autov.GetXMaxGraph:Double;
begin
Result:=XPointGraphMax;
end;

function Tpop_calib_autov.GetYMinGraph:Double;
begin
Result:=YPointGraphMin;
end;

function Tpop_calib_autov.GetYMaxGraph:Double;
begin
Result:=YPointGraphMax;
end;

procedure Tpop_calib_autov.GetMaxGraph(var X,Y:Double);
begin
X:=XOfYPointGraphMax;
Y:=YPointGraphMax;
end;

procedure Tpop_calib_autov.GetMinGraph(var X,Y:Double);
begin
X:=XOfYPointGraphMin;
Y:=YPointGraphMin;
end;

procedure Tpop_calib_autov.SetColorGraph(Index:LongWord;_Color:TColor);
begin
ColorR^[Index]:=GetRValue(_Color);
ColorV^[Index]:=GetGValue(_Color);
ColorB^[Index]:=GetBValue(_Color);
end;

procedure Tpop_calib_autov.DisplayGraph;
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

procedure Tpop_calib_autov.DrawLinesGraph;
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

procedure Tpop_calib_autov.AddYLineGraph(Y:Double;Color:TColor);
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

procedure Tpop_calib_autov.AddXLineGraph(X:Double;Color:TColor);
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

procedure Tpop_calib_autov.SetXLineGraph(Index:Integer;X:Double);
var
   XOut:LongWord;
begin
XGraphToImageGraph(X,XOut);
XGraphLine^[Index]:=X;
XImageLine^[Index]:=XOut;
UpdateGraph;
end;

procedure Tpop_calib_autov.SetYLineGraph(Index:Integer;Y:Double);
var
   YOut:LongWord;
begin
YGraphToImageGraph(Y,YOut);
YGraphLine^[Index]:=Y;
YImageLine^[Index]:=YOut;
UpdateGraph;
end;

function Tpop_calib_autov.GetXLineGraph(Index:Integer):Double;
begin
if (Index>0) and (Index<NbXLines) then
   Result:=XGraphLine^[Index];
end;

function Tpop_calib_autov.GetYLineGraph(Index:Integer):Double;
begin
if (Index>0) and (Index<=NbYLines) then
   Result:=YGraphLine^[Index];
end;

//******************************************************************************
//******************************************************************************
//******************************************************************************

procedure Tpop_calib_autov.AddMessage(MyMessage:string);
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

procedure Tpop_calib_autov.WriteMessage(MyMessage:string);
begin
WriteSpy(MyMessage);
AddMessage(MyMessage);
end;

procedure Tpop_calib_autov.AcqNoir;
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

procedure Tpop_calib_autov.Button1Click(Sender: TObject);
var
   xx,yy,i:Integer;
   xxd,yyd:Double;
   ValMax:Double;
   LargFen:Integer;
   Fin:Boolean;
   PSF:TPSF;
   Max,Min,Mediane:SmallInt;
   Moy,Ecart:Double;
   DateTime:TDateTime;
   ImgNil:PTabImgDouble;
   Vitesse:Integer;
   XCentre,YCentre,Diametre:Double;
   ImgDoubleNil:PTabImgDouble;
   OK:Boolean;
   MyMessage:string;
   NbEchec:Integer;
//   Pose:Double;

   Fwhm:TVecteur;
   NbMesures:Integer;
   Add:Boolean;
   NbAdd:Integer;
   Mesure:Double;
   TimeMove:Double;
   NbMesure:Integer;
   Descend,Monte:Boolean;
   XMaxGraph,YMaxGraph:Double;
   XMaxGraph2,YMaxGraph2:Double;
   XMinGraph,Min1,Min2,Min3:Double;
   MinPasse:Boolean;
   Temp:Double;
   ValDesature:Integer;   
begin
ListBox1.Clear;

Button1.Enabled:=False;
Button2.Enabled:=True;
Button3.Enabled:=False;

if ComboBox3.ItemIndex=0 then OK:=Focuser.SetCorrectionOn else OK:=Focuser.SetCorrectionOff;

// Pour les tests
if ComboBox2.ItemIndex=0 then FWHMTestCourant:=15 else FWHMTestCourant:=-15;

// Inversion de l'axe des X
if ComboBox2.ItemIndex=0 then SetMirrorOffGraph else SetMirrorOnGraph;

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
   WriteSpy(lang('Arrêt de la mise au point manuelle'));
   AddMessage(lang('Etoile trop près du bord'));
   AddMessage(lang('Arrêt de la mise au point manuelle'));
   pop_camera.pop_image_acq.Bloque:=False;
   Exit;
   end;

// Pour centrer
HFD(pop_camera.pop_image_acq.DataInt,pop_camera.pop_image_acq.DataDouble,pop_camera.pop_image_acq.ImgInfos.TypeData,
   2*LargFen+1,2*LargFen+1,xxd,yyd,Diametre);

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
      if Assigned(pop_map_monitor) then
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

WriteSpy(lang('Début du tracé de la courbe en V'));
AddMessage(lang('Début du tracé de la courbe en V'));

//********************************************************************************************
//**************************************   Boucle principale   *******************************
//********************************************************************************************
NbEchec:=0;
TimeMove:=0;
NbMesure:=0;
YMaxGraph:=MaxDouble;
Descend:=False;
Monte:=False;
MinPasse:=False;
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

   // Aquisition
{   if (XMap>LargFen+1) and (YMap>LargFen+1) and (XMap<Camera.GetXSize-LargFen) and (YMap<Camera.GetYSize-LargFen) then
      begin
      pop_camera.Acquisition(XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen,Pose,1,False);

      //Soustraction du noir
      if NoirMAPAcquis and pop_map.CheckBox1.Checked then
         begin
         GetImgPart(MemPicNoir,ImgDoubleNil,VignetteNoir,ImgDoubleNil,2,1,pop_camera.pop_image_acq.ImgInfos.Sx,
            pop_camera.pop_image_acq.ImgInfos.Sy,XMap-LargFen,YMap-LargFen,XMap+LargFen,YMap+LargFen);
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
      WriteSpy(lang('Arrêt de la mise au point manuelle'));
      AddMessage(lang('Etoile trop près du bord'));
      AddMessage(lang('Arrêt de la mise au point manuelle'));
      pop_camera.pop_image_acq.Bloque:=False;
      Exit;
      end;}

   // Mesure
   // HFD / Moyenne / serie réduite si on a choisi la vitesse rapide ou normale si on a choisi la vitesse lente
   if ComboBox1.ItemIndex=0 then
      begin
      Mesure:=pop_map.Serie(Fwhm,Config.NbEssaiFocSlow,False,0,1,True,Temp,True,True,clRed);
      end
   else
      begin
      Mesure:=pop_map.Serie(Fwhm,Config.NbEssaiFocFast,False,0,1,True,Temp,True,True,clRed);
      end;

   if Mesure>0 then
      begin
      AddMessage(lang('HFD moyen = ')+MyFloatToStr(Mesure,2));
      WriteSpy(lang('HFD moyen = ')+MyFloatToStr(Mesure,2));
      end;

   if Mesure<0 then
      begin
//      if (Mesure>YMaxGraph) and (SpinEdit3.Value>100) then
//            GetMaxGraph(XMaxGraph,YMaxGraph);
      GetMaxGraph(XMaxGraph2,YMaxGraph2);
//      if (YMaxGraph2>YMaxGraph) and (SpinEdit3.Value>100) then
      if MinPasse then
         begin
//         AddMessage(lang('Le tracé est terminé'));
         Fin:=True;
         end
      else
         begin
         if not pop_map.StopMAP then
            begin
//            WriteSpy(lang('Echec de la série'));
//            AddMessage(lang('Echec de la série'));
            end
         else
            begin
            WriteSpy(lang('Arrêt du tracé effectué'));
            AddMessage(lang('Arrêt du tracé effectué'));
            end;
         pop_map.StopMap:=False;
         MapManuelle:=False;
         pop_camera.pop_image_acq.Bloque:=False;
         Button2.Enabled:=False;
         Exit;
         end;
      end;

//   AddMessage(lang('HFD moyen')+
//      ' = '+MyFloatToStr(Mesure,2)); //nolang

   if not(Fin) then
      begin
      // Analyse et Affichage du graphe
      Inc(NBMesure);
      if NbMesure=1 then
         begin
         AddGraph(TimeMove/1000,Mesure,clBlue);
         end
      else if NbMesure=2 then
         begin
         if Mesure>GetYGraph(1) then
            begin
            SetColorGraph(1,clRed);
            AddGraph(TimeMove/1000,Mesure,clRed);
            AddMessage(lang('On est dans une zône indéterminée, on continue'));
            end
         else
            begin
            AddGraph(TimeMove/1000,Mesure,clBlue);
            AddMessage(lang('On est dans la zone descendante, on continue'));
   //         DiametreMax:=GetYGraph(1);
   //         TimeMax:=GetXGraph(1);
            Descend:=True;
            end;
         end
      else if NbMesure=3 then
         begin
         if Mesure>GetYGraph(1) then
            begin
            SetColorGraph(1,clRed);
            SetColorGraph(2,clRed);
            AddGraph(TimeMove/1000,Mesure,clRed);
            end
         else
            begin
            AddGraph(TimeMove/1000,Mesure,clBlue);
            if not Descend then
               begin
               Descend:=True;
               AddMessage(lang('On est dans la zone descendante, on continue'));
   //            DiametreMax:=GetYGraph(2);
   //            TimeMax:=GetXGraph(2);
               end;
            end;
         end
      // Ca y est, on est en zone descendente
      else if NbMesure=4 then
         begin
         if Mesure>GetYGraph(3) then
            begin
            SetColorGraph(1,clRed);
            SetColorGraph(2,clRed);
            SetColorGraph(3,clRed);
            AddGraph(TimeMove/1000,Mesure,clRed);
            AddMessage(lang('La position initiale est incorrecte, on arrête'));
            AddMessage(lang('Repositionnez le focuseur en commande manuelle'));
            Exit;
            end
         else
            begin
            AddGraph(TimeMove/1000,Mesure,clBlue);
            GetMaxGraph(XMaxGraph,YMaxGraph);
            if not Descend then
               begin
               Descend:=True;
               AddMessage(lang('On est dans la zone descendante, on continue'));
   //            DiametreMax:=GetYGraph(3);
   //            TimeMax:=GetXGraph(3);
               end;
            end;
         end
      else // NbMesure>4
         begin
         if not MinPasse then
            begin
            GetMaxGraph(XMinGraph,Min3);
            if (Min3=Min2) and (Min2=Min1) then MinPasse:=True;
            end;

         if Mesure>GetYGraph(NbMesure-1) then
            AddGraph(TimeMove/1000,Mesure,clRed)
         else
            AddGraph(TimeMove/1000,Mesure,clBlue);

         if (Mesure>YMaxGraph*SpinEdit3.Value/100) and (GetYGraph(NbMesure-1)>GetYGraph(NbMesure-2))
            and (Mesure>GetYGraph(NbMesure-1)) then
            begin
            AddMessage(lang('La limite ascendante est atteinte, le tracé est terminé'));
            Fin:=True;
            end;

         // Si on descends, on réinitialise Monte
         // Attendre 2 points
         if (Mesure<GetYGraph(NbMesure-1)) and (Mesure<GetYGraph(NbMesure-2)) then Monte:=False;

         if not Monte and (Mesure>GetYGraph(NbMesure-1)) and (GetYGraph(NbMesure-1)>GetYGraph(NbMesure-2))
             and not Fin then
            begin
            AddMessage(lang('On est dans la zône ascendante, on continue'));
            Monte:=True;
            end;

   {      GetMaxGraph(XMaxGraph,YMaxGraph);
         if Monte and (Mesure>SpinEdit3.Value/100*YMaxGraph) then
            begin
            AddMessage(lang('La limite ascendante est atteinte, le tracé est terminé'));
            Fin:=True;
            end;}

         end;

      Min2:=Min3;
      Min1:=Min2;   
      // Mouvement dans le sens demandé
      if ComboBox2.ItemIndex=0 then
         begin
         if ComboBox1.ItemIndex=1 then Vitesse:=mapRapide else Vitesse:=mapLent;
         for i:=1 to SpinEdit2.Value do
            begin
            // L'inversion se fait dans le driver
//            if Config.FocInversion then
//               OK:=Focuser.FocuserMoveTime(mapArriere,Vitesse,StrToFloat(NumberEdit1.Text))
//            else
            Ok:=Focuser.FocuserMoveTime(mapAvant,Vitesse,StrToFloat(NumberEdit1.Text));
            if not OK then
               begin
               MyMessage:=Focuser.GetError;
               WriteSpy(MyMessage);
               AddMessage(MyMessage);
               FocuserDisconnect;
   //            raise Error.Create(MyMessage);
               end;
            end;
         end;

       if ComboBox2.ItemIndex=1 then
         begin
         if ComboBox1.ItemIndex=1 then Vitesse:=mapRapide else Vitesse:=mapLent;
         for i:=1 to SpinEdit2.Value do
            begin
            // L'inversion se fait dans le driver
//            if Config.FocInversion then
//               OK:=Focuser.FocuserMoveTime(mapAvant,Vitesse,StrToFloat(NumberEdit1.Text))
//            else
            OK:=Focuser.FocuserMoveTime(mapArriere,Vitesse,StrToFloat(NumberEdit1.Text));
            if not OK then
               begin
               MyMessage:=Focuser.GetError;
               WriteSpy(MyMessage);
               AddMessage(MyMessage);
               FocuserDisconnect;
   //            raise Error.Create(MyMessage);
               end;
            end;
         end;

      TimeMove:=TimeMove+StrToFloat(NumberEdit1.Text)*SpinEdit2.Value;
      end;
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

UpdateDiametre(True);
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
end;
end;

procedure Tpop_calib_autov.MAJGraphe;
var
   IndexMin,IndexMax:LongWord;
   NbPointsUtiles:LongWord;
   i:Integer;
   InterX:LongWord;
begin
if CountGraph>0 then
   begin
   Update:=True;
   try

   // Lignes
   SetYLineGraph(1,MyStrToFloat(NumberEdit2.Text));
   SetYLineGraph(2,MyStrToFloat(NumberEdit3.Text));

   // Changement de couleur
   IndexMin:=4294967295;
   IndexMax:=0;
   NbPointsUtiles:=0;
   for i:=1 to CountGraph do
      begin
      if (GetXGraph(i)>=TimeMin) and (GetXGraph(i)<=TimeMax)
         and (GetYGraph(i)>=MyStrToFloat(NumberEdit3.Text)) and (GetYGraph(i)<=MyStrToFloat(NumberEdit2.Text)) then
         begin
         SetColorGraph(i,clBlue);
         Inc(NbPointsUtiles);
         if i>IndexMax then IndexMax:=i;
         if i<IndexMin then IndexMin:=i;
         end
      else
         SetColorGraph(i,clRed);
      end;

   Edit2.Text:=IntToStr(NbPointsUtiles);

   // Régression Linéaire
   if IndexMax-IndexMin+1>=2 then
      begin
      LineFitGraph(IndexMin,IndexMax,clBlack);
      Edit1.Text:=MyFloatToStr(-ALine,3);
      Edit3.Text:=MyFloatToStr(Error,3);
      // Intersection avec l'axe des X
      XGraphToImageGraph(-BLine/ALine,InterX);
      Image1.Canvas.Pen.Mode:=pmCopy;
      Image1.Canvas.Pen.Color:=AxisColor;
      Image1.Canvas.Pen.Style:=psSolid;
      Image1.Canvas.Pen.Width:=1;
      Image1.Canvas.MoveTo(InterX,YImageMin);
      Image1.Canvas.LineTo(InterX,YImageMax);
      end
   else
      begin
      Edit1.Text:=lang('NAN');
      Edit3.Text:=lang('NAN');
      end;

   if (Edit1.Text<>lang('NAN')) and (ComboBox2.ItemIndex=0) then Button3.Enabled:=True;

   finally
   Update:=False;
   end;
   end;
end;

procedure Tpop_calib_autov.Button2Click(Sender: TObject);
begin
WriteSpy(lang('Arrêt du tracé demandé'));
AddMessage(lang('Arrêt du tracé demandé'));
pop_map.StopMap:=True;
Button1.Enabled:=True;
Button2.Enabled:=False;
end;

procedure Tpop_calib_autov.FormCreate(Sender: TObject);
var
   OK:Boolean;
   MyMessage:string;
begin
if Assigned(pop_map_monitor) then pop_map_monitor.Close;
Button2.Enabled:=False;
pop_map.Hide;
CreateGraph;
if ComboBox3.ItemIndex=0 then OK:=Focuser.SetCorrectionOn else OK:=Focuser.SetCorrectionOff;
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   ShowMessage(MyMessage);
   FocuserDisconnect;
   end;

NumberEdit2.Text:=MyFloatToStr(Config.DiametreExtreme,1);
NumberEdit3.Text:=MyFloatToStr(Config.DiametreProche,1);
SetAutoYMinGraph(False);
SetYMinGraph(0);
LoadParam;
end;


procedure Tpop_calib_autov.SaveParam;
var
   Path,Name,Section:string;
   FText:TextFile;
   i:Integer;
begin
if (CountGraph<>0) and (Edit1.Text<>lang('NAN')) then
   begin
   Section:=IntToStr(ComboBox1.ItemIndex)+IntToStr(ComboBox2.ItemIndex)+IntToStr(ComboBox3.ItemIndex);
   Path:=ExtractFilePath(Application.Exename);
   Name:=Path+'VGraph'+Section+'.sav'; //nolang
   AssignFile(FText,Name);
   Rewrite(FText);
   Writeln(FText,NumberEdit1.Text);
   Writeln(FText,SpinEdit2.Text);
   Writeln(FText,SpinEdit3.Text);
   Writeln(FText,NumberEdit2.Text);
   Writeln(FText,NumberEdit3.Text);
   Writeln(FText,Edit1.Text);
   Writeln(FText,Edit2.Text);
   Writeln(FText,Edit3.Text);
   Writeln(FText,FloatToStr(GetYLineGraph(1)));
   Writeln(FText,FloatToStr(GetYLineGraph(2)));   
   Writeln(FText,IntToStr(CountGraph));
   for i:=1 to CountGraph do
      begin
      Writeln(FText,GetXGraph(i));
      Writeln(FText,GetYGraph(i));   
      end;

   CloseFile(FText);
   end;
end;

procedure Tpop_calib_autov.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//SaveParam;

FreeGraph;

if Assigned(pop_camera.pop_image_acq) then pop_camera.pop_image_acq.Close;
end;

procedure Tpop_calib_autov.NumberEdit2Change(Sender: TObject);
var
   Error:Integer;
   Line:string;
begin
if not Update then
   begin
   Line:=NumberEdit2.Text;
   if Pos(',',Line)<>0 then Line[Pos(',',Line)]:='.';
   Val(Line,DiametreExtreme,Error);
   if Error=0 then
      begin
      SetYLineGraph(1,DiametreExtreme);
      MAJGraphe;
      end;
   end;
end;

procedure Tpop_calib_autov.NumberEdit3Change(Sender: TObject);
var
   Error:Integer;
   Line:string;
begin
if not Update then
   begin
   Line:=NumberEdit3.Text;
   if Pos(',',Line)<>0 then Line[Pos(',',Line)]:='.';
   Val(Line,DiametreProche,Error);
   if Error=0 then
      begin
      SetYLineGraph(2,DiametreProche);
      MAJGraphe;
      end;
   end;
end;

procedure Tpop_calib_autov.ComboBox3Change(Sender: TObject);
var
   OK:Boolean;
   MyMessage:string;
begin
if ComboBox3.ItemIndex=0 then OK:=Focuser.SetCorrectionOn else OK:=Focuser.SetCorrectionOff;
if not OK then
   begin
   MyMessage:=Focuser.GetError;
   WriteSpy(MyMessage);
   ShowMessage(MyMessage);
   FocuserDisconnect;
   end;

LoadParam;   
end;

procedure Tpop_calib_autov.SpinButton1DownClick(Sender: TObject);
begin
NumberEdit1.Text:=MyFloatToStr(MyStrToFloat(NumberEdit1.Text)-50,2);
end;

procedure Tpop_calib_autov.SpinButton1UpClick(Sender: TObject);
begin
NumberEdit1.Text:=MyFloatToStr(MyStrToFloat(NumberEdit1.Text)+50,2);
end;

procedure Tpop_calib_autov.SpinButton2DownClick(Sender: TObject);
begin
Update:=True;
try
NumberEdit2.Text:=MyFloatToStr(MyStrToFloat(NumberEdit2.Text)-0.1,1);
finally
Update:=False;
end;
MAJGraphe;
end;

procedure Tpop_calib_autov.SpinButton2UpClick(Sender: TObject);
begin
Update:=True;
try
NumberEdit2.Text:=MyFloatToStr(MyStrToFloat(NumberEdit2.Text)+0.1,1);
finally
Update:=False;
end;
MAJGraphe;
end;

procedure Tpop_calib_autov.SpinButton3DownClick(Sender: TObject);
begin
Update:=True;
try
NumberEdit3.Text:=MyFloatToStr(MyStrToFloat(NumberEdit3.Text)-0.1,2);
finally
Update:=False;
end;
MAJGraphe;
end;

procedure Tpop_calib_autov.SpinButton3UpClick(Sender: TObject);
begin
Update:=True;
try
NumberEdit3.Text:=MyFloatToStr(MyStrToFloat(NumberEdit3.Text)+0.1,2);
finally
Update:=False;
end;
MAJGraphe;
end;

procedure Tpop_calib_autov.Button3Click(Sender: TObject);
var
   Path:string;
begin
// En vitesse lente quatre paramètres sont sauvegardés :
// - Diamètre extrême
// - Diamètre proche
// - Vitesse lente
// - Durée de l'impulsion incrémentale.
// En vitesse rapide un seul paramètre est sauvegardé :
// - Vitesse rapide

if (CountGraph<>0) and (ComboBox2.ItemIndex=0) then
   begin
   if ComboBox1.ItemIndex=0 then
      begin
      Config.DiametreExtreme:=MyStrToFloat(NumberEdit2.Text);
      Config.DiametreProche:=MyStrToFloat(NumberEdit3.Text);
      Config.VitesseLente:=MyStrToFloat(Edit1.Text);
      Config.DureeImpulsionIncrementale:=MyStrToFloat(NumberEdit1.Text);
      end
   else
      begin
      Config.VitesseRapide:=MyStrToFloat(Edit1.Text);
      end;

   Path:=ExtractFilePath(Application.ExeName);
   SaveParametres(Path+'TeleAuto.ini');  //nolang
   end;

SaveParam;

Button3.Enabled:=False;
end;

procedure Tpop_calib_autov.LoadParam;
var
   Path,Name,Section,Line:string;
   FText:TextFile;
   i,NbPoints:LongWord;
   X,Y:Double;
begin
Update:=True;
try
ClearGraph;

Section:=IntToStr(ComboBox1.ItemIndex)+IntToStr(ComboBox2.ItemIndex)+IntToStr(ComboBox3.ItemIndex);
Path:=ExtractFilePath(Application.Exename);
Name:=Path+'VGraph'+Section+'.sav'; //nolang
if FileExists(Name) then
   begin
   if ComboBox2.ItemIndex=0 then
      begin
      Button3.Enabled:=True;
      SetMirrorOffGraph;      
      end
   else
      begin
      Button3.Enabled:=False;
      SetMirrorOnGraph;
      end;
   
   AssignFile(FText,Name);
   Reset(FText);
   Readln(FText,Line);
   NumberEdit1.Text:=Line;
   Readln(FText,Line);
   SpinEdit2.Text:=Line;
   Readln(FText,Line);
   SpinEdit3.Text:=Line;
   Readln(FText,Line);
   NumberEdit2.Text:=Line;
   Readln(FText,Line);
   NumberEdit3.Text:=Line;
   Readln(FText,Line);
   Edit1.Text:=Line;
   Readln(FText,Line);
   Edit2.Text:=Line;
   Readln(FText,Line);
   Edit3.Text:=Line;
   Readln(FText,Line);
//   AddYLineGraph(MyStrToFloat(Line),clBlue);
   Readln(FText,Line);
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

   UpdateDiametre(False);
   MAJGraphe;
   end;

finally
Update:=False;
end;
end;


procedure Tpop_calib_autov.ComboBox1Change(Sender: TObject);
begin
LoadParam;
end;

procedure Tpop_calib_autov.ComboBox2Change(Sender: TObject);
begin
LoadParam;
end;

procedure Tpop_calib_autov.UpdateDiametre(AutoUpdate:Boolean);
var
   i:Integer;
begin
// Recherche des TimeMin et TimeMax
DiametreMax:=MinDouble;
for i:=1 to 4 do
   begin
   if GetYGraph(i)>=DiametreMax then
      begin
      TimeMin:=GetXGraph(i);
      DiametreMax:=GetYGraph(i);
      end;
   end;

DiametreMin:=MaxDouble;
for i:=1 to CountGraph do
   begin
   if GetYGraph(i)<=DiametreMin then
      begin
      TimeMax:=GetXGraph(i);
      DiametreMin:=GetYGraph(i);
      end;
   end;

// Analyse du graphe
// Dp = 1.5 Dm (ex. 5 p)
// De = 0.8 DM (ex. 22 p).
if AutoUpdate then
   begin
   DiametreProche:=1.5*DiametreMin;
   DiametreExtreme:=0.8*DiametreMax;
   NumberEdit2.Text:=MyFloatToStr(DiametreExtreme,1);
   NumberEdit3.Text:=MyFloatToStr(DiametreProche,1);
   end;

// Lignes
AddYLineGraph(MyStrToFloat(NumberEdit2.Text),ClBlue);
AddYLineGraph(MyStrToFloat(NumberEdit3.Text),ClBlue);

end;

procedure Tpop_calib_autov.Image1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
   XOut,YOut:Double;
begin
XImageToGraphGraph(X,XOut);
YImageToGraphGraph(Y,YOut);
Label15.Caption:=MyFloatToStr(XOut,2)+' / '+MyFloatToStr(YOut,2);
end;

procedure Tpop_calib_autov.Button4Click(Sender: TObject);
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

procedure Tpop_calib_autov.Button5Click(Sender: TObject);
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
