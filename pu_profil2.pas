unit pu_profil2;

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
  ExtCtrls, ComCtrls,clipbrd, StdCtrls, Buttons, u_class, u_lang,
  u_file_io, tagraph;

type
  Tpop_profil = class(TForm)
    Panel1: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    TAChart1: TTAChart;
    Label2: TLabel;
    Label3: TLabel;
    SaveDialog1: TSaveDialog;
    BitBtn1: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TAChart1DrawVertReticule(Sender: TComponent; IndexSerie,
      Index, Xi, Yi: Integer; Xg, Yg: Double);
    procedure BitBtn1Click(Sender: TObject);
  private
   { Déclarations privées }
   CoordX,CoordY:PLigInteger;
   procedure TraceProfil(Image:pointer;width,height:integer;typedata:byte;Line:TRect;MyColor:TColor);
  public
   { Déclarations publiques }
   NBPlans:Byte;

   procedure DisplayProfil(Image:Pointer;Width,Height:Integer;TypeData:Byte;Line:TRect;Title:string);
  end;

implementation

uses
   pu_main,
   u_general;

{$R *.DFM}

procedure Tpop_profil.TraceProfil(Image:Pointer;Width,Height:Integer;TypeData:Byte;Line:TRect;MyColor:TColor);
var
   d,dx,dy,aincr,bincr,xincr,yincr,x,dummy,y:integer;       {algorithme}
   IntPixel:smallint;
   DblPixel:double;
   TAProfil:TTASerie;
   compteur:integer;
begin
with Tpop_profil(Self) do
   begin
   Compteur:=1;
   TAProfil:=TTASerie.Create(TAChart1);
   TAChart1.AddSerie(TAProfil);
   //Calcule les coordonnées des points de la ligne et les lit
   if (Abs(Line.Right-Line.Left)<Abs(Line.Bottom-Line.Top) ) then  // Parcours : par l'axe X ou Y ?
      begin                                                        // par l'axe des Y
      if (Line.Top>Line.Bottom) then
         begin
         Dummy:=Line.Left;
         Line.Left:=Line.Right;
         Line.Right:=Dummy;
         Dummy:=Line.Top;
         Line.Top:=Line.Bottom;
         Line.Bottom:=Dummy;
         end;
      if (Line.Right>Line.Left ) then XIncr:=1 else XIncr:=-1;
      Dy:=Line.Bottom-Line.Top;
      Getmem(CoordX,(Dy+1)*4);
      Getmem(CoordY,(Dy+1)*4);
      Dx:=Abs(Line.Right-Line.Left);
      d:=(Dx shl 1)-Dy;
      AIncr:=(Dx-Dy) shl 1;
      BIncr:=Dx shl 1;
      x:=Line.Left;
      y:=Line.Top;
      case TypeData of
         2,7:begin
             IntPixel:=pImgInt(image)^[y]^[x];
             CoordX^[Compteur]:=x;
             CoordY^[Compteur]:=y;
             TAProfil.AddXY(Compteur,IntPixel,MyColor);
             Inc(Compteur);
             for y:=Line.Top+1 to Line.Bottom do
                begin
                if (d>=0) then
                   begin
                   Inc(x,XIncr);
                   Inc(d,AIncr);
                   end
                else
                   Inc(d,BIncr);
                // place le point
                IntPixel:=pImgInt(Image)^[y]^[x];
                CoordX^[Compteur]:=x;
                CoordY^[Compteur]:=y;
                TAProfil.AddXY(Compteur,IntPixel,MyColor);
                Inc(Compteur);
                end;
             end;
       5,6,8:begin
             DblPixel:=pImgDouble(Image)^[y]^[x];
             CoordX^[Compteur]:=x;
             CoordY^[Compteur]:=y;
             TAProfil.AddXY(compteur,DblPixel,MyColor);
             Inc(Compteur);
             for y:=Line.Top+1 to Line.Bottom do
                begin
                if (d>=0) then
                   begin
                   inc(x,XIncr);
                   inc(d,AIncr);
                   end
                else
                   inc(d,BIncr);
                // place le point}
                DblPixel:=pImgDouble(Image)^[y]^[x];
                CoordX^[Compteur]:=x;
                CoordY^[Compteur]:=y;
                TAProfil.AddXY(Compteur,DblPixel,MyColor);
                inc(Compteur);
                end;
             end;
         end;
      end
   else                                               // par l'axe des X
      begin
      if (Line.Left>Line.Right) then
         begin
         Dummy:=Line.Left;
         Line.Left:=Line.Right;
         Line.Right:=Dummy;
         Dummy:=Line.Top;
         Line.Top:=Line.Bottom;
         Line.Bottom:=Dummy;
         end;
      if (Line.bottom>Line.Top) then YIncr:=1 else YIncr:=-1;
      Dx:=Line.Right-Line.Left;
      Getmem(CoordX,(Dx+1)*4);
      Getmem(CoordY,(Dx+1)*4);
      Dy:=Abs(Line.Bottom-Line.Top );
      d:=(Dy shl 1)-Dx;
      AIncr:=(Dy-Dx) shl 1;
      BIncr:=Dy shl 1;
      x:=Line.Left;
      y:=Line.Top;
      case TypeData of
         2,7:begin
             // place le point
             IntPixel:=pImgInt(Image)^[y]^[x];
             CoordX^[Compteur]:=x;
             CoordY^[Compteur]:=y;
             TAProfil.AddXY(compteur,IntPixel,MyColor);
             Inc(Compteur);
             for x:=Line.Left+1 to Line.Right do
                begin
                if (d>=0) then
                   begin
                   Inc(y,YIncr);
                   Inc(d,AIncr);
                   end
                else Inc(d,BIncr);
                {place le point}
                IntPixel:=pImgInt(Image)^[y]^[x];
                CoordX^[Compteur]:=x;
                CoordY^[Compteur]:=y;
                TAProfil.AddXY(Compteur,IntPixel,MyColor);
                Inc(Compteur);
                end;
             end;
       5,6,8:begin
             // place le point
             DblPixel:=pImgDouble(Image)^[y]^[x];
             CoordX^[Compteur]:=x;
             CoordY^[Compteur]:=y;
             TAProfil.AddXY(compteur,DblPixel,MyColor);
             Inc(Compteur);
             for x:=Line.Left+1 to Line.Right do
                begin
                if (d>=0) then
                   begin
                   inc(y,YIncr);
                   inc(d,AIncr);
                   end
                else Inc(d,BIncr);
                {place le point}
                DblPixel:=pImgDouble(Image)^[y]^[x];
                CoordX^[Compteur]:=x;
                CoordY^[Compteur]:=y;
                TAProfil.AddXY(compteur,DblPixel,MyColor);
                Inc(Compteur);
                end;
             end;
         end;
      end;//fin de ligne
   end;
end;

procedure Tpop_profil.DisplayProfil(Image:Pointer;Width,Height:Integer;TypeData:Byte;Line:TRect;Title:string);
var
   Index:Integer;
begin
with Tpop_profil(Self) do
   begin
   //rejette les profils < 3 valeurs
   if (Abs(Line.Top-Line.Bottom)<3) and (Abs(Line.Left-Line.Right)<3) then
      begin
      ShowMessage(lang('Profil trop petit'));
      Release;
      Exit;
      end;
   if Line.Left=0   then Line.Left  :=1;
   if Line.Top=0    then Line.Top   :=1;
   if Line.Right=0  then Line.Right :=1;
   if Line.Bottom=0 then Line.Bottom:=1;
   try
   TAChart1.Title:=(lang('Profil de (')+ IntToStr(line.left)+','+IntToStr(line.top)+
                    lang(') à (')+IntToStr(line.right)+','+IntToStr(line.bottom)+
                    lang(') de ')+ title);
   TAChart1.ShowTitle:=True;
   if Nbplans=1 then
      TraceProfil(pTabImgInt(image)^[1],width,height,typedata,line,TColor($0000FF))
   else if Nbplans=3 then
      begin
      TraceProfil(pTabImgInt(image)^[1],width,height,typedata,line,clRed);
      TraceProfil(pTabImgInt(image)^[2],width,height,typedata,line,clLime);
      TraceProfil(pTabImgInt(image)^[3],width,height,typedata,line,clBlue);
      end
   else
      begin
      for Index:=1 to NbPlans do
         TraceProfil(pTabImgInt(image)^[index],width,height,typedata,line,clBlack);
      end;

   except
   ShowMessage(lang('Impossible de lire le profil'));
   Release;
   end;
   end;
end;

procedure Tpop_profil.BitBtn2Click(Sender: TObject);
var
   T:TextFile;
   Name,Line:string;
   Serie:TTASerie;
   NbPoints,NbSeries:Integer;
   X,Y:Integer;
   I:Double;
begin
SaveDialog1.InitialDir:=config.RepImages;
SaveDialog1.Filter:=lang('Fichiers texte TXT|*.TXT');
if SaveDialog1.Execute then
   begin
   Name:=SaveDialog1.FileName;
   if Uppercase(ExtractFileExt(Name))<>'.TXT' then Name:=Name+'.txt'; //nolang
   AssignFile(T,Name);
   Rewrite(T);
   try

   Line:=TAChart1.Title;
   Writeln(T,Line);

   Serie:=TAChart1.GetSerie(0) as TTASerie;
   for NbPoints:=0 to Serie.Count-1 do
      begin
      X:=CoordX^[NbPoints+1];
      Y:=CoordY^[NbPoints+1];
      Line:=IntToStr(X)+' '+IntToStr(Y)+' ';
      for NbSeries:=0 to TAChart1.SeriesCount-1 do
         begin
         Serie:=TAChart1.GetSerie(NbSeries) as TTASerie;
         I:=Serie.GetYValue(NbPoints);
         Line:=Line+MyFloatToStr(I,6)+' ';
         end;
      Writeln(T,Line);
      end;

   finally
   CloseFile(T);
   end;
   end;
end;

procedure Tpop_profil.BitBtn3Click(Sender: TObject);
var
   Bitmap:TBitmap;
   Name:string;
begin
TAChart1.ShowVerticalReticule:=False;
SaveDialog1.InitialDir:=config.RepImages;
SaveDialog1.Filter:=lang('Fichiers BMP (*.bmp)|*.bmp');
if SaveDialog1.Execute then
   begin
   Name:=SaveDialog1.FileName;
   if Uppercase(ExtractFileExt(Name))<>'.BMP' then Name:=Name+'.bmp'; //nolang
   Bitmap:=TBitmap.Create;
   Bitmap.PixelFormat:=pf24bit;
   Bitmap.Width:=TAChart1.width;
   Bitmap.Height:=TAChart1.Height;
   TAChart1.Refresh;
   Bitmap.Canvas.CopyRect(Rect(0,0,Bitmap.Width,Bitmap.Height),TAChart1.Canvas,Rect(0,0,TAChart1.Width,TAChart1.Height));
   Bitmap.SaveToFile(Name);
   Bitmap.Free;
//   if df=2 then
//    begin
//     PPFormat:=CF_BITMAP;
//     PPData:=Bitmap.Handle;
//     PPPalette:=Bitmap.Palette;
//     Bitmap.SaveToClipboardFormat(PPFormat,PPData,PPPalette);
//     ClipBoard.SetAsHandle(PPFormat,PPData);
//    end
   end;
TAChart1.ShowVerticalReticule:=True;   
end;

procedure Tpop_profil.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

procedure Tpop_profil.TAChart1DrawVertReticule(Sender: TComponent;
  IndexSerie, Index, Xi, Yi: Integer; Xg, Yg: Double);
var
   i,j:Integer;
   Line:string;
   Serie:TTASerie;
   Valeur:Double;
begin
i:=Round(Xg);
Label1.Caption:='Index = '+MyFloatToStr(Xg,2);
Label2.Caption:='Coordonnées : X= '+IntToStr(CoordX^[i])+' / Y = '+IntToStr(CoordY^[i]);
if Nbplans=1 then
   Label3.Caption:='Intensité : I= '+MyFloatToStr(Yg,6)
else if Nbplans=3 then
   begin
   Line:='Intensités :';
   Serie:=TAChart1.GetSerie(0) as TTASerie;
   Valeur:=Serie.GetYValue(i);
   Line:=Line+' Ir = '+MyFloatToStr(Valeur,6)+' /';
   Serie:=TAChart1.GetSerie(1) as TTASerie;
   Valeur:=Serie.GetYValue(i);
   Line:=Line+' Iv = '+MyFloatToStr(Valeur,6)+' /';
   Serie:=TAChart1.GetSerie(2) as TTASerie;
   Valeur:=Serie.GetYValue(i);
   Line:=Line+' Ib = '+MyFloatToStr(Valeur,6);
   Label3.Caption:=Line;
   end
else
   begin
   Line:='Intensités :';
   for j:=0 to TAChart1.SeriesCount-1 do
      begin
      Serie:=TAChart1.GetSerie(j) as TTASerie;
      Valeur:=Serie.GetYValue(i);
      Line:=Line+' I'+IntToStr(j+1)+' = '+MyFloatToStr(Valeur,6);
      if j<>TAChart1.SeriesCount-1 then Line:=Line+' /';
      end;
   Label3.Caption:=Line;
   end;
end;

procedure Tpop_profil.BitBtn1Click(Sender: TObject);
var
   PPFormat:Word;
   PPData:THandle;
   PPPalette:HPalette;
   Bitmap:TBitmap;
   Name:string;
begin
TAChart1.ShowVerticalReticule:=False;
Bitmap:=TBitmap.Create;
try
Bitmap.PixelFormat:=pf24bit;
Bitmap.Width:=TAChart1.width;
Bitmap.Height:=TAChart1.Height;
TAChart1.Refresh;
Bitmap.Canvas.CopyRect(Rect(0,0,Bitmap.Width,Bitmap.Height),TAChart1.Canvas,Rect(0,0,TAChart1.Width,TAChart1.Height));
PPFormat:=CF_BITMAP;
PPData:=Bitmap.Handle;
PPPalette:=Bitmap.Palette;
Bitmap.SaveToClipboardFormat(PPFormat,PPData,PPPalette);
ClipBoard.SetAsHandle(PPFormat,PPData);
finally
Bitmap.Free;
TAChart1.ShowVerticalReticule:=True;
end;
end;

end.



