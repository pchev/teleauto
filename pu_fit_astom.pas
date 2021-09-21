unit pu_fit_astom;

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
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, u_class, Spin, ExtCtrls, Buttons, Editnbre;

type
  Tpop_fit_astrom = class(TForm)
    CheckListBox1: TCheckListBox;
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    BitBtn2: TBitBtn;
    Label10: TLabel;
    Panel3: TPanel;
    Label11: TLabel;
    Panel4: TPanel;
    Label12: TLabel;
    Panel5: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Panel6: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Button1: TButton;
    NbreEdit1: NbreEdit;
    Button2: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure CheckListBox1Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    xIn,yIn,x1In,x2In,SigXIn,SigYIn:PLigDouble;
    NbStarGagnantIn,NbStarSelected:Integer;
    AstrometrieInfos:TAstrometrieInfos;
//    CovarX,CovarY:DoubleArray;
//    ChisqX,ChisqY:Double;
//    ResiduX,ResiduY:Double;
    Residus,ResidusX,ResidusY:PLigDouble;
    XCentre,YCentre,XCentrePU,YCentrePU:Double;
    x,y,x1,x2,SigX,SigY:PLigDouble;
    FirstPassage:Boolean;

    procedure Calcule;
  end;

var
  pop_fit_astrom: Tpop_fit_astrom;

implementation

{$R *.DFM}

uses u_math,
     u_lang,
     u_general,
     u_meca,
     u_astrometrie,
     math;

procedure Tpop_fit_astrom.Calcule;
var
   i,j,ma,mb:Integer;
   AlphaCentre,DeltaCentre,EchelleX,EchelleY,Echelle,Focale,Angle:Double;
   Stx,Sty:string;
begin
EchelleX:=ArcTan(AstrometrieInfos.TaillePixelX/AstrometrieInfos.Focale/1000)*180/Pi*3600;
EchelleY:=ArcTan(AstrometrieInfos.TaillePixelY/AstrometrieInfos.Focale/1000)*180/Pi*3600;
Echelle:=Sqrt((Sqr(EchelleX)+Sqr(EchelleY))/2);

AstrometrieInfos.DegrePoly:=SpinEdit1.Value;

//Recherche du nombre d'étoiles sélectionnées
NbStarSelected:=0;
for i:=0 to CheckListBox1.Items.Count-1 do
   if CheckListBox1.Checked[i] then Inc(NbStarSelected);

Getmem(x,8*NbStarSelected);
Getmem(y,8*NbStarSelected);
Getmem(x1,8*NbStarSelected);
Getmem(x2,8*NbStarSelected);
Getmem(SigX,8*NbStarSelected);
Getmem(SigY,8*NbStarSelected);
Getmem(Residus,8*NbStarSelected);
Getmem(ResidusX,8*NbStarSelected);
Getmem(ResidusY,8*NbStarSelected);
try

//Passage dans les tableaux des selectionnées
j:=0;
for i:=0 to CheckListBox1.Items.Count-1 do
   begin
   if CheckListBox1.Checked[i] then
      begin
      Inc(j);
      x^[j]:=xIn^[i+1];
      y^[j]:=yIn^[i+1];
      x1^[j]:=x1In^[i+1];
      x2^[j]:=x2In^[i+1];
      SigX^[j]:=SigXIn^[i+1];
      SigY^[j]:=SigYIn^[i+1];
      end;
   end;

// On fitte
FitAstrometrie(x,y,x1,x2,SigX,SigY,NbStarSelected,AstrometrieInfos,Residus,ResidusX,ResidusY);

// On affiche les resultats

// Affichage des polynomes
ListBox1.Clear;
ListBox2.Clear;

mb:=0;
for i:=0 to AstrometrieInfos.DegrePoly do
   begin
   for j:=0 to i do inc(mb);
   end;

ma:=0;
for i:=0 to AstrometrieInfos.DegrePoly do
   begin
   for j:=0 to i do
      begin
      inc(ma);
      if (i-j)=0 then Stx:=''
      else if (i-j)=1 then Stx:=' x X' //nolang
      else Stx:=' x X^'+IntToStr(i-j); //nolang
      if j=0 then Sty:=''
      else if j=1 then Sty:=' x Y' //nolang
      else Sty:=' x Y^'+IntToStr(j); //nolang
      AstrometrieInfos.DaX[ma]:=Sqrt(Abs(AstrometrieInfos.CovarX[ma,ma]*AstrometrieInfos.ChisqX/(NbStarSelected-mb)));
      ListBox1.Items.Add(Format('a[%d] = %6.4f +/- %6.8f',[ma,AstrometrieInfos.PolyX[ma], //nolang
         AstrometrieInfos.DaX[ma]])+Stx+Sty);
      end;
   end;
//   [i,AstrometrieInfos.PolyX[i],Sqrt(Abs(cvm[i,i]))])); //nolang

ma:=0;
for i:=0 to AstrometrieInfos.DegrePoly do
   begin
   for j:=0 to i do
      begin
      inc(ma);
      if (i-j)=0 then Stx:=''
      else if (i-j)=1 then Stx:=' x X' //nolang
      else Stx:=' x X^'+IntToStr(i-j); //nolang
      if j=0 then Sty:=''
      else if j=1 then Sty:=' x Y' //nolang
      else Sty:=' x Y^'+IntToStr(j); //nolang

      AstrometrieInfos.DaY[ma]:=Sqrt(Abs(AstrometrieInfos.CovarY[ma,ma]*AstrometrieInfos.ChisqY/(NbStarSelected-mb)));
      ListBox2.Items.Add(Format('b[%d] = %6.4f +/- %6.8f',[ma,AstrometrieInfos.PolyY[ma], //nolang
         AstrometrieInfos.DaY[ma]])+Stx+Sty); //nolang
      end;
   end;
//  [i,AstrometrieInfos.PolyY[i],Sqrt(Abs(cvm[i,i]))])); //nolang

j:=0;
// mise à jour des residus des points
for i:=1 to NbStarGagnantIn do
   begin
   if CheckListBox1.Checked[i-1] then
      begin
      Inc(j);
//      CheckListBox1.Items[i-1]:=Format(lang('%6.3f / %6.3f / %6.3f'),[AstrometrieInfos.Sx div 2+x1^[j], //nolang
//         AstrometrieInfos.Sy div 2+x2^[j],Sqrt((Sqr(ResidusX^[j]*EchelleX)+Sqr(ResidusY^[j]*EchelleY))/2)]);
      CheckListBox1.Items[i-1]:=Format(lang('%6.3f / %6.3f / %6.3f'),[AstrometrieInfos.Sx div 2+x1^[j], //nolang
         AstrometrieInfos.Sy div 2+x2^[j],Residus^[j]]);
      end
   else
      begin
      CheckListBox1.Items[i-1]:=Format(lang('%6.3f / %6.3f'),[AstrometrieInfos.Sx div 2+x1^[j], //nolang
         AstrometrieInfos.Sy div 2+x2^[j]]);
//      CheckListBox1.Items[i-1]:=MyFloatToStr(AstrometrieInfos.Sx+x1In^[i],3)+' / '+ //nolang
//         MyFloatToStr(AstrometrieInfos.Sy+x2In^[i],3); 
      end;
   end;

// Affichage des residus globaux
AstrometrieInfos.ResiduX:=Sqrt(AstrometrieInfos.ResiduX/(NbStarSelected-ma));
Panel1.Caption:=MyFloatToStr(AstrometrieInfos.ResiduX*Echelle,3);
AstrometrieInfos.ResiduY:=Sqrt(AstrometrieInfos.ResiduY/(NbStarSelected-ma));
Panel2.Caption:=MyFloatToStr(AstrometrieInfos.ResiduY*Echelle,3);

//XCentre:=CalcPolynomeXY(AstrometrieInfos.Sx div 2,AstrometrieInfos.Sy div 2,AstrometrieInfos.PolyX,AstrometrieInfos.DegrePoly);
//YCentre:=CalcPolynomeXY(AstrometrieInfos.Sx div 2,AstrometrieInfos.Sy div 2,AstrometrieInfos.PolyY,AstrometrieInfos.DegrePoly);
//XCentrePU:=(XCentre-AstrometrieInfos.Sx div 2)*AstrometrieInfos.TaillePixel/AstrometrieInfos.Focale/1000/1e6;
//YCentrePU:=(YCentre-AstrometrieInfos.Sy div 2)*AstrometrieInfos.TaillePixel/AstrometrieInfos.Focale/1000/1e6;
//XYToAlphaDelta(XCentrePU,YCentrePU,AstrometrieInfos.Alpha0,AstrometrieInfos.Delta0,AlphaCentre,DeltaCentre);
//Memo3.Lines.Add('Centre du champs :'); // non c'est pas ça !
//Memo3.Lines.Add(AlphaToStr(AlphaCentre)+' / '+DeltaToStr(DeltaCentre)); //nolang

Panel3.Caption:=IntToStr(NbStarGagnantIn);
Panel4.Caption:=IntToStr(NbStarSelected);

if FirstPassage then
   begin
   Focale:=(AstrometrieInfos.Focale/(Sqrt(Sqr(AstrometrieInfos.PolyX[2])+Sqr(AstrometrieInfos.PolyX[3])))
      +AstrometrieInfos.Focale/(Sqrt(Sqr(AstrometrieInfos.PolyY[2])+sqr(AstrometrieInfos.PolyY[3]))))/2;
   AstrometrieInfos.Focale:=Focale;
   Panel5.Caption:=MyFloatToStr(Focale,2);

   Angle:=ArcTan2(AstrometrieInfos.PolyX[3],AstrometrieInfos.PolyX[2])*180/Pi;
   AstrometrieInfos.OrientationCCD:=Angle;
   Panel6.Caption:=MyFloatToStr(Angle,2);

   FirstPassage:=False;
   end;

finally
Freemem(x,8*NbStarSelected);
Freemem(y,8*NbStarSelected);
Freemem(x1,8*NbStarSelected);
Freemem(x2,8*NbStarSelected);
Freemem(SigX,8*NbStarSelected);
Freemem(SigY,8*NbStarSelected);
Freemem(Residus,8*NbStarSelected);
Freemem(ResidusX,8*NbStarSelected);
Freemem(ResidusY,8*NbStarSelected);
end
end;

procedure Tpop_fit_astrom.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Freemem(xIn,8*NbStarGagnantIn);
   Freemem(yIn,8*NbStarGagnantIn);
   Freemem(x1In,8*NbStarGagnantIn);
   Freemem(x2In,8*NbStarGagnantIn);
   Freemem(SigxIn,8*NbStarGagnantIn);
   Freemem(SigyIn,8*NbStarGagnantIn);
end;

procedure Tpop_fit_astrom.FormShow(Sender: TObject);
var
   i:Integer;
begin
FirstPassage:=True;

UpDateLang(Self);

// Initialisation de l'algo

// On ajoute toutes les étoiles sans les résidus que l'on ne connait pas encore
for i:=1 to NbStarGagnantIn do
   begin
   CheckListBox1.Items.Add(MyFloatToStr(AstrometrieInfos.Sx div 2+x1In^[i],3)+'/'+
      MyFloatToStr(AstrometrieInfos.Sx div 2+x2In^[i],3));
   CheckListBox1.Checked[i-1]:=True;
   end;

// On selectionne toutes les étoiles
for i:=0 to CheckListBox1.Items.Count-1 do CheckListBox1.Checked[i]:=True;

Calcule;
end;

procedure Tpop_fit_astrom.CheckListBox1Click(Sender: TObject);
var
   i,DegreMax:Integer;
begin
//Recherche du nombre d'étoiles sélectionnées
NbStarSelected:=0;
for i:=0 to CheckListBox1.Items.Count-1 do
   if CheckListBox1.Checked[i] then Inc(NbStarSelected);

// On peut pas fitter si pas assez d'étoiles sont sélectionnées
if NbStarSelected<=3 then ShowMessage(lang('4 étoiles minimum'))
else
   begin
   SpinEdit1.Enabled:=True;
   // Mise a jour du degré max
   if NbStarSelected>3  then DegreMax:=1;
   if NbStarSelected>6  then DegreMax:=2;
   if NbStarSelected>10 then DegreMax:=3;
   if NbStarSelected>15 then DegreMax:=4;
   if NbStarSelected>21 then DegreMax:=5;
   SpinEdit1.MinValue:=1;
   if StrToInt(SpinEdit1.Text)>DegreMax then SpinEdit1.Text:=IntToStr(DegreMax);
   SpinEdit1.MaxValue:=DegreMax;
   if DegreMax=1 then SpinEdit1.Enabled:=False;


   Calcule;
   end;
end;

procedure Tpop_fit_astrom.SpinEdit1Change(Sender: TObject);
begin
Calcule;
end;

procedure Tpop_fit_astrom.Button1Click(Sender: TObject);
var
   MaxResidu,Residu:Double;
   PosEsp,i:Integer;
   ResiduStr:string;
begin
MaxResidu:=MyStrToFloat(NbreEdit1.Text);
for i:=0 to CheckListBox1.Items.Count-1 do
   begin
   ResiduStr:=CheckListBox1.Items[i];

   PosEsp:=Pos('/',ResiduStr);
   Residu:=MyStrToFloat(Copy(ResiduStr,1,PosEsp-1));
   Delete(ResiduStr,1,PosEsp);
   PosEsp:=Pos('/',ResiduStr);
   Residu:=MyStrToFloat(Copy(ResiduStr,1,PosEsp-1));
   Delete(ResiduStr,1,PosEsp);

   Residu:=MyStrToFloat(ResiduStr);

   if Residu>MaxResidu then CheckListBox1.Checked[i]:=False;
   end;

Calcule;
end;

procedure Tpop_fit_astrom.Button2Click(Sender: TObject);
var
   i:Integer;
begin
for i:=0 to CheckListBox1.Items.Count-1 do CheckListBox1.Checked[i]:=True;

Calcule;
end;

end.
