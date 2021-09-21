unit pu_histo;

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
  ExtCtrls, StdCtrls, pu_image, Spin, Buttons, u_class;

type
  Tpop_histo = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    SpinButton1: TSpinButton;
    Label1: TLabel;
    Edit2: TEdit;
    SpinButton2: TSpinButton;
    Label2: TLabel;
    Label3: TLabel;
    SpinEdit1: TSpinEdit;
    GroupBox2: TGroupBox;
    SpeedButton6: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton1: TSpeedButton;
    BitBtn1: TBitBtn;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    SpeedButton8: TSpeedButton;
    SpeedButton10: TSpeedButton;
    Label10: TLabel;
    Label11: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label12: TLabel;
    SpeedButton9: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label13: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpinButton2UpClick(Sender: TObject);
    procedure SpinButton2DownClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure Affiche;
    procedure Efface;
    procedure CalculHistogramme;
    procedure AfficheHighLight;
  public
    { Déclarations publiques }
    pop_image:Tpop_image;
    NoPlan:Byte;
    Hist:array[-32768..32768] of Longint;
    HistInf:array[-32768..32768] of Longint;
    HistSup:array[-32768..32768] of Longint;
    HistMed:array[-32768..32768] of Longint;
    MaxHisto,MaxHistoVisu:Double;
    HistAff:array[0..32768] of Double;
    Nb:Longint;
    Nb2,Mediane:Double;
    MinCourant,MaxCourant,Max,Min,MaxDebut,MinDebut:Double;
    LargMin,PosBarre:Integer;
    PSF:TPSF;
  end;

var
  pop_histo: Tpop_histo;

implementation

{$R *.DFM}

uses u_visu,
     u_general,
     u_arithmetique,
     u_lang,
     pu_main,
     u_modelisation;

procedure Tpop_histo.Efface;
begin
with Image1 do
   begin
   Canvas.Pen.Style:=psSolid;
   Canvas.Pen.Color:=clWhite;
   Canvas.Brush.Color:=clWhite;
   Canvas.Brush.Style:=bsSolid;
   Canvas.Rectangle(0,0,Width,Height);
   end;
end;

procedure Tpop_histo.FormCreate(Sender: TObject);
begin
LargMin:=50;
Efface;
end;

procedure Tpop_histo.Affiche;
var
   i,Valint:Integer;
   Pos:Longint;
   Valeur,MedianeAff:Double;
begin
   Efface;
   MinCourant:=StrToInt(Edit1.Text);
   MaxCourant:=StrToInt(Edit2.Text);

   MaxHisto:=-10000;
   for i:=0 to Image1.Width-1 do
      begin
      Pos:=Trunc(MinCourant+i*(MaxCourant-MinCourant)/(Image1.Width-1));
      Valeur:=Hist[Pos];
      if CheckBox1.Checked then
         begin
         if Valeur<>0 then HistAff[i]:=Ln(Valeur)
         else HistAff[i]:=0;
         end
      else HistAff[i]:=Round(Valeur);
      if HistAff[i]>MaxHisto then
         begin
         MaxHisto:=HistAff[i];
         MaxHistoVisu:=Hist[Pos];
         end;

{      if CheckBox3.Checked then
         begin
//           Valeur:=ImgInt^[1]^[j]^[i]+IntensiteMax*exp( -sqr((i-X)*cos(Angle)+(j-Y)*sin(Angle)) / (2*SigX*SigX) )
//                   *exp( -sqr(-(i-X)*sin(Angle)+(j-Y)*cos(Angle)) / (2*SigY*SigY) );

         Valint:=Round( Image1.Height-1-PSF.IntensiteMax*exp( -sqr(Pos-PSF.X)/(2*PSF.Sigma*PSF.Sigma) ) );
         if i=0 then Image1.Canvas.MoveTo(i,Valint)
         else Image1.Canvas.LineTo(i,Valint)
         end;}
      end;


   Image1.Canvas.Pen.Color:=clBlack;
   Image1.Canvas.Pen.Style:=psSolid;
   if MaxHisto<>0 then
      begin
      for i:=0 to Image1.Width-1 do
         begin
         HistAff[i]:=HistAff[i]*Image1.Height/MaxHisto;

         Image1.Canvas.MoveTo(i,Image1.Height-1);
         Image1.Canvas.LineTo(i,Image1.Height-1-Round(HistAff[i]));
         end
      end
   else
      begin
      Canvas.Pen.Color:=clBlack;
      Canvas.Pen.Style:=psSolid;
      Canvas.MoveTo(0,Image1.Height-1);
      Canvas.LineTo(Image1.Width-1,Image1.Height-1);
      end;

   if CheckBox3.Checked then
      begin
      Image1.Canvas.Pen.Color:=clGreen;
      Image1.Canvas.Pen.Style:=psSolid;
      if MaxHisto<>0 then
         begin
         for i:=0 to Image1.Width-1 do
            begin
//           Valeur:=ImgInt^[1]^[j]^[i]+IntensiteMax*exp( -sqr((i-X)*cos(Angle)+(j-Y)*sin(Angle)) / (2*SigX*SigX) )
//                   *exp( -sqr(-(i-X)*sin(Angle)+(j-Y)*cos(Angle)) / (2*SigY*SigY) );

            Pos:=Trunc(MinCourant+i*(MaxCourant-MinCourant)/(Image1.Width-1));
            Valint:=Round(Image1.Height-1-PSF.IntensiteMax*exp(-sqr(Pos-PSF.X)/(PSF.Sigma*PSF.Sigma/2))*Image1.Height/MaxHisto);
            if i=0 then Image1.Canvas.MoveTo(i,Valint)
            else Image1.Canvas.LineTo(i,Valint);

//            HistAff[i]:=HistAff[i]*Image1.Height/MaxHisto;
//            Image1.Canvas.MoveTo(i,Image1.Height-1);
//            Image1.Canvas.LineTo(i,Image1.Height-1-Round(HistAff[i]));
            end;
         end;
      end;

Label4.Caption:=IntToStr(Round(MinCourant));
Label5.Caption:=IntToStr(Round(MaxCourant));
Label7.Caption:=IntToStr(Round(MaxHistoVisu));

with Image1 do
   begin
   Canvas.Pen.Color:=clRed;
   Canvas.Pen.Style:=psSolid;
   Canvas.MoveTo(PosBarre,0);
   Canvas.LineTo(PosBarre,Image1.Height-1);
   end;

if CheckBox2.Checked then
   begin
//   MedianeAff:=Hist[Trunc(MinCourant+Mediane*(MaxCourant-MinCourant)/(Image1.Width-1))];
   MedianeAff:=(Mediane-MinCourant)*(Image1.Width-1)/(MaxCourant-MinCourant)+1;
   with Image1 do
      begin
      Canvas.Pen.Color:=clBlue;
      Canvas.Pen.Style:=psSolid;
      Canvas.MoveTo(Round(MedianeAff),0);
      Canvas.LineTo(Round(MedianeAff),Image1.Height-1);
      end;
   end;


Pos:=Trunc(MinCourant+PosBarre*(MaxCourant-MinCourant)/(Image1.Width-1));
Panel2.Caption:=IntToStr(Pos);
Panel3.Caption:=IntToStr(Hist[Pos]);

Label10.Caption:=IntToStr(HistInf[Pos])+'/'+MyFloatToStr(HistInf[Pos]/pop_image.ImgInfos.Sx/pop_image.ImgInfos.Sy*100,4)+'%';
Label11.Caption:=IntToStr(HistSup[Pos])+'/'+MyFloatToStr(HistSup[Pos]/pop_image.ImgInfos.Sx/pop_image.ImgInfos.Sy*100,4)+'%';

end;

procedure Tpop_histo.CalculHistogramme;
var
   i,j:Integer;
   Valeur,ValHisto:Double;
   ValMid,Entropie:Double;
begin
Nb:=0;
Max:=-32768;
Min:=32767;
for i:=-32768 to 32767 do Hist[i]:=0;
if TraductionEnCours then Exit;
for j:=1 to pop_image.ImgInfos.Sy do
   case pop_image.ImgInfos.TypeData of
   2,7:for i:=1 to pop_image.ImgInfos.Sx do
        begin
        Valeur:=pop_image.DataInt^[NoPlan]^[j]^[i];
        if Valeur>Max then Max:=Valeur;
        if Valeur<Min then Min:=Valeur;
        inc(Hist[Round(Valeur)]);
        inc(Nb);
        end;
   5,8:for i:=1 to pop_image.ImgInfos.Sx do
        begin
        Valeur:=pop_image.DataDouble^[NoPlan]^[j]^[i];
        ValHisto:=Valeur;
        if ValHisto>=32767 then ValHisto:=32767;
        if ValHisto<=-32768 then ValHisto:=-32768;
        if ValHisto>Max then Max:=ValHisto;
        if ValHisto<Min then Min:=ValHisto;
        inc(Hist[Round(ValHisto)]);
        inc(Nb);
        end;
   6:begin
     case pop_image.ImgInfos.TypeComplexe of
        1:for i:=1 to pop_image.ImgInfos.Sx do
             begin
             Valeur:=Sqrt(Sqr(pop_image.DataDouble^[1]^[j]^[i])+Sqr(pop_image.DataDouble^[2]^[j]^[i]));
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             if ValHisto>Max then Max:=ValHisto;
             if ValHisto<Min then Min:=ValHisto;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             end;
        2:for i:=1 to pop_image.ImgInfos.Sx do
             begin
             if pop_image.DataDouble^[1]^[j]^[i]<>0 then
                Valeur:=ArcTan(abs((pop_image.DataDouble^[2]^[j]^[i])/(pop_image.DataDouble^[1]^[j]^[i])))
             else
                Valeur:=Pi/2;
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             if ValHisto>Max then Max:=ValHisto;
             if ValHisto<Min then Min:=ValHisto;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             end;
        3:for i:=1 to pop_image.ImgInfos.Sx do
             begin
             Valeur:=pop_image.DataDouble^[1]^[j]^[i];
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             if ValHisto>Max then Max:=ValHisto;
             if ValHisto<Min then Min:=ValHisto;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             end;
        4:for i:=1 to pop_image.ImgInfos.Sx do
             begin
             Valeur:=pop_image.DataDouble^[2]^[j]^[i];
             ValHisto:=Valeur;
             if ValHisto>=32767 then ValHisto:=32767;
             if ValHisto<=-32768 then ValHisto:=-32768;
             if ValHisto>Max then Max:=ValHisto;
             if ValHisto<Min then Min:=ValHisto;
             inc(Hist[Round(ValHisto)]);
             inc(Nb);
             end;
        end;
     end;
   end;

if MaxDebut-MinDebut>LargMin then
   begin
   Edit1.Text:=IntToStr(Round(MinDebut));
   Edit2.Text:=IntToStr(Round(MaxDebut));
   end
else
   begin
   ValMid:=(MaxDebut+MinDebut)/2;
   if (ValMid-LargMin/2)>=Min then Edit1.Text:=IntToStr(Round(ValMid-LargMin/2))
   else Edit1.Text:=IntToStr(Round(Min));
   if (ValMid+LargMin/2)<=Min then Edit2.Text:=IntToStr(Round(ValMid+LargMin/2))
   else Edit2.Text:=IntToStr(Round(Max));
   end;

Max:=Max+1;

Entropie:=0;
for i:=-32768 to 32767 do
   begin
   HistInf[i]:=Hist[i];
   HistSup[i]:=Hist[i];
   HistMed[i]:=Hist[i];
   if Hist[i]<>0 then Entropie:=Entropie-Hist[i]/pop_image.ImgInfos.Sx/pop_image.ImgInfos.Sy*ln(Hist[i]/pop_image.ImgInfos.Sx/pop_image.ImgInfos.Sy)/ln(2);
   end;

Label12.Caption:=lang('Entropie : ')+MyFloatToStr(Entropie,6);

for i:=-32767 to 32767 do HistSup[i]:=HistSup[i-1]+HistSup[i];
for i:=32766 downto -32768 do HistInf[i]:=HistInf[i+1]+HistInf[i];

for i:=-32767 to 32767 do HistMed[i]:=HistMed[i]+HistMed[i-1];
Nb2:=Nb/2;
for i:=-32768 to 32767 do
   if (HistMed[i]<=Nb2) and (HistMed[i+1]>=Nb2)
      then Mediane:=i+1;

PosBarre:=Image1.Width div 2;

Affiche;
end;

procedure Tpop_histo.FormShow(Sender: TObject);
begin
CalculHistogramme;
UpdateLang(Self);
end;

procedure Tpop_histo.SpinButton1DownClick(Sender: TObject);
var
   Val:Integer;
begin
   Val:=StrToInt(Edit1.Text);
   if (Val-SpinEdit1.Value)>=Min then
      Edit1.Text:=IntToStr(Val-SpinEdit1.Value)
   else Edit1.Text:=IntToStr(Round(Min));
Affiche;
end;

procedure Tpop_histo.SpinButton1UpClick(Sender: TObject);
var
   Val:Integer;
begin
Val:=StrToInt(Edit1.Text);
if (Val+SpinEdit1.Value)<=MaxCourant-LargMin then
   Edit1.Text:=IntToStr(Val+SpinEdit1.Value)
else Edit1.Text:=IntToStr(Round(MaxCourant)-LargMin);
Affiche;
end;

procedure Tpop_histo.SpeedButton3Click(Sender: TObject);
var
   Val1,Val2,Dx:Integer;
begin
Val1:=StrToInt(Edit1.Text);
Val2:=StrToInt(Edit2.Text);
Dx:=Val2-Val1;
if (Val2+Dx div 4)<=Max then
   begin
   Edit1.Text:=IntToStr(Val1+Dx div 4);
   Edit2.Text:=IntToStr(Val2+Dx div 4);
   end
else
   begin
   Edit1.Text:=IntToStr(Round(Max)-Dx);
   Edit2.Text:=IntToStr(Round(Max));
   end;
Affiche;
end;

procedure Tpop_histo.SpeedButton4Click(Sender: TObject);
var
   Val1,Val2,Dx:Integer;
begin
Val1:=StrToInt(Edit1.Text);
Val2:=StrToInt(Edit2.Text);
Dx:=Val2-Val1;
if (Val1-Dx div 4)>=Min then
   begin
   Edit1.Text:=IntToStr(Val1-Dx div 4);
   Edit2.Text:=IntToStr(Val2-Dx div 4);
   end
else
   begin
   Edit1.Text:=IntToStr(Round(Min));
   Edit2.Text:=IntToStr(Round(Min)+Dx);
   end;
Affiche;
end;

procedure Tpop_histo.SpinButton2UpClick(Sender: TObject);
var
   Val:Integer;
begin
Val:=StrToInt(Edit2.Text);
if (Val+SpinEdit1.Value)<=Max then
   Edit2.Text:=IntToStr(Val+SpinEdit1.Value)
else Edit2.Text:=IntToStr(Round(Max));
Affiche;
end;

procedure Tpop_histo.SpinButton2DownClick(Sender: TObject);
var
   Val:Integer;
begin
Val:=StrToInt(Edit2.Text);
if (Val-SpinEdit1.Value)>=MinCourant+LargMin then
   Edit2.Text:=IntToStr(Val-SpinEdit1.Value)
else Edit2.Text:=IntToStr(Round(MinCourant+LargMin));
Affiche;
end;

procedure Tpop_histo.SpeedButton1Click(Sender: TObject);
var
   Val1,Val2,Dx,ValMid:Integer;
begin
Val1:=StrToInt(Edit1.Text);
Val2:=StrToInt(Edit2.Text);
Dx:=Val2-Val1;
if (Val2-Dx div 4)-(Val1+Dx div 4)>=LargMin then
   begin
   Edit1.Text:=IntToStr(Val1+Dx div 4);
   Edit2.Text:=IntToStr(Val2-Dx div 4);
   end
else
   begin
   ValMid:=(Val1+Val2) div 2;
   Edit1.Text:=IntToStr(ValMid-LargMin div 2);
   Edit2.Text:=IntToStr(ValMid+LargMin div 2);
   end;
Affiche;
end;

procedure Tpop_histo.SpeedButton2Click(Sender: TObject);
var
   Val1,Val2,Dx:Integer;
begin
Val1:=StrToInt(Edit1.Text);
Val2:=StrToInt(Edit2.Text);
Dx:=Val2-Val1;
if (Val1-Dx div 4)>=Min then Edit1.Text:=IntToStr(Val1-Dx div 4)
else Edit1.Text:=IntToStr(Round(Min));
if (Val2+Dx div 4)<=Max then Edit2.Text:=IntToStr(Val2+Dx div 4)
else Edit2.Text:=IntToStr(Round(Max));
Affiche;
end;

procedure Tpop_histo.SpeedButton5Click(Sender: TObject);
var
   Val1,Val2,Dx:Integer;
begin
Val1:=StrToInt(Edit1.Text);
Val2:=StrToInt(Edit2.Text);
Dx:=Val2-Val1;
Edit1.Text:=IntToStr(Round(Max)-Dx);
Edit2.Text:=IntToStr(Round(Max));
Affiche;
end;

procedure Tpop_histo.SpeedButton6Click(Sender: TObject);
var
   Val1,Val2,Dx:Integer;
begin
Val1:=StrToInt(Edit1.Text);
Val2:=StrToInt(Edit2.Text);
Dx:=Val2-Val1;
Edit1.Text:=IntToStr(Round(Min));
Edit2.Text:=IntToStr(Round(Min)+Dx);
Affiche;
end;

procedure Tpop_histo.SpeedButton7Click(Sender: TObject);
begin
Edit1.Text:=IntToStr(Round(MinDebut));
Edit2.Text:=IntToStr(Round(MaxDebut));
Affiche;
end;

procedure Tpop_histo.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Edit2.Text<>'' then Affiche;
end;

procedure Tpop_histo.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Edit1.Text<>'' then Affiche;
end;

procedure Tpop_histo.SpeedButton10Click(Sender: TObject);
begin
if PosBarre<Image1.Width-1 then Inc(PosBarre);
Affiche;
AfficheHighLight;
end;

procedure Tpop_histo.SpeedButton8Click(Sender: TObject);
begin
if PosBarre>0 then Dec(PosBarre);
Affiche;
AfficheHighLight;
end;

procedure Tpop_histo.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
PosBarre:=X;
Affiche;
AfficheHighLight;
end;

procedure Tpop_histo.Button1Click(Sender: TObject);
begin
with pop_image do
   begin
   ClipMin(DataInt,DataDouble,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,
      Trunc(MinCourant+PosBarre*(MaxCourant-MinCourant)/(Image1.Width-1)),0);
   VisuImg;
   end;

CalculHistogramme;
end;

procedure Tpop_histo.Button2Click(Sender: TObject);
begin
with pop_image do
   begin
   ClipMax(DataInt,DataDouble,ImgInfos.TypeData,ImgInfos.NbPlans,ImgInfos.Sx,ImgInfos.Sy,
      Trunc(MinCourant+PosBarre*(MaxCourant-MinCourant)/(Image1.Width-1)),0);
   VisuImg;
   end;
CalculHistogramme;

end;

procedure Tpop_histo.AfficheHighLight;
begin
if SpeedButton9.Down then
   pop_image.VisuHighLight(Trunc(MinCourant+PosBarre*(MaxCourant-MinCourant)/(Image1.Width-1)),
      Trunc(MinCourant+PosBarre*(MaxCourant-MinCourant)/(Image1.Width-1)))
else if SpeedButton11.Down then
   pop_image.VisuHighLight(Min,Trunc(MinCourant+PosBarre*(MaxCourant-MinCourant)/(Image1.Width-1)))
else if SpeedButton12.Down then
   pop_image.VisuHighLight(Trunc(MinCourant+PosBarre*(MaxCourant-MinCourant)/(Image1.Width-1)),Max)
else pop_image.VisuImg;
end;

procedure Tpop_histo.SpeedButton9Click(Sender: TObject);
begin
AfficheHighLight;
end;

procedure Tpop_histo.SpeedButton11Click(Sender: TObject);
begin
AfficheHighLight;
end;

procedure Tpop_histo.SpeedButton12Click(Sender: TObject);
begin
AfficheHighLight;
end;

procedure Tpop_histo.CheckBox1Click(Sender: TObject);
begin
Affiche;
end;

procedure Tpop_histo.Button3Click(Sender: TObject);
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
   for i:=Round(Min) to Round(Max) do
      Writeln(T,IntToStr(i)+' '+IntToStr(Hist[i]));
   finally
   System.Close(T);
   end;
   end;
end;

procedure Tpop_histo.CheckBox2Click(Sender: TObject);
begin
Affiche;
end;

procedure Tpop_histo.CheckBox3Click(Sender: TObject);
var
   LigDouble:PLigDouble;
   Max,x,i:Integer;
begin
if CheckBox3.Checked then
   begin
   Max:=32768+32768+1;
   Getmem(LigDouble,8*Max);
   try

   for i:=-32768 to 32768 do LigDouble^[i+32768+1]:=Hist[i];
   Modelise1D(LigDouble,Max,x+32768+1,PSF);

   PSF.X:=PSF.X-32768-1;
   Label13.Caption:=lang('Pos. = ')+MyFloatToStr(PSF.X,1)+
      lang(' FWHM = ')+MyFloatToStr(PSF.Sigma,0)+
      lang(' Int. = ')+MyFloatToStr(PSF.IntensiteMax,0)
   finally
   Freemem(LigDouble,8*Max);
   end;

   end;

Affiche;
end;

end.
