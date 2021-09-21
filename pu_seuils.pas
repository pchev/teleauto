unit pu_seuils;

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
  Buttons, StdCtrls, ExtCtrls, u_class ,pu_image, FileCtrl;

type
  Tpop_seuils = class(TForm)
    editsh: TEdit;
    Editsb: TEdit;
    ScrollBarsb: TScrollBar;
    ScrollBarsh: TScrollBar;
    ButtonLummm: TButton;
    ButtonLumm: TButton;
    ButtonConmm: TButton;
    ButtonConm: TButton;
    LabelCont: TLabel;
    Label4: TLabel;
    ButtonLump: TButton;
    ButtonLumpp: TButton;
    ButtonConpp: TButton;
    ButtonConp: TButton;
    Bevel5: TBevel;
    Bevel4: TBevel;
    FileListBox2: TFileListBox;
    Inverser: TButton;
    Stellaires: TButton;
    Planetes: TButton;
    GroupBox1: TGroupBox;
    Fast: TRadioButton;
    Slow: TRadioButton;
    Normal: TRadioButton;
    img_rampe: TImage;
    SpeedButton1: TSpeedButton;
    procedure ChangeImg;
    procedure ScrollBarshScroll(Sender: TObject;
              ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure ScrollBarsbScroll(Sender: TObject;
              ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure EditsbKeyPress(Sender: TObject; var Key: Char);
    procedure EditshKeyPress(Sender: TObject; var Key: Char);
    procedure InverserClick(Sender: TObject);
    procedure FastClick(Sender: TObject);
    procedure SlowClick(Sender: TObject);
    procedure ButtonLumpClick(Sender: TObject);
    procedure ButtonLummClick(Sender: TObject);
    procedure ButtonLummmClick(Sender: TObject);
    procedure ButtonLumppClick(Sender: TObject);
    procedure ButtonConpClick(Sender: TObject);
    procedure ButtonConmClick(Sender: TObject);
    procedure ButtonConppClick(Sender: TObject);
    procedure ButtonConmmClick(Sender: TObject);
    procedure FileListBox2Click(Sender: TObject);
    Procedure PalExpl;
    procedure PlanetesClick(Sender: TObject);
    procedure StellairesClick(Sender: TObject);
    procedure NormalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);


  private
    { Private declarations }
    Palh:TPalHeader;
    Image:tpop_image;

  public

  end;

var
  pop_seuils: Tpop_seuils;

implementation

uses u_math,
     u_general,
     pu_camera,
     pu_main,
     u_visu,
     u_lang;


{$R *.DFM}

procedure Tpop_seuils.ChangeImg;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   Image:=pop_main.LastChild as Tpop_Image;
//   Image.ImgInfos.Min[1]:=mystrtofloat(Editsb.Text);
//   Image.ImgInfos.Max[1]:=mystrtofloat(Editsh.Text);
   Image.VisuImg;
   end;
end;

procedure Tpop_seuils.ScrollBarshScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
Editsh.Text:=IntToStr(scrollpos);
if pop_main.LastChild is Tpop_Image then
   begin
   Image:=pop_main.LastChild as Tpop_Image;
   Image.ImgInfos.Max[1]:=ScrollPos;
   if Image.IsUsedForAcq then
      Config.SeuilHautFixe:=ScrollPos;
   ChangeImg;
   end;
end;

procedure Tpop_seuils.ScrollBarsbScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
Editsb.Text:=IntToStr(ScrollPos);
if pop_main.LastChild is Tpop_Image then
   begin
   Image:=pop_main.LastChild as Tpop_Image;
   Image.ImgInfos.Min[1]:=ScrollPos;
   if Image.IsUsedForAcq then
      Config.SeuilBasFixe:=ScrollPos;
   ChangeImg;
   end;
end;

procedure Tpop_seuils.EditsbKeyPress(Sender: TObject; var Key: Char);
begin
if Key=#13 then
   begin
   if mystrtofloat(Editsb.Text)<-32768 then Editsb.Text:='-32768'; //nolang
   ScrollBarsb.Position:=Round(MyStrToFloat(Editsb.Text));
   ScrollBarsb.Refresh;
   if pop_main.LastChild is Tpop_Image then
      begin
      Image:=pop_main.LastChild as Tpop_Image;
      Image.ImgInfos.Min[1]:=mystrtofloat(EditSB.text);
      if Image.IsUsedForAcq then
         Config.SeuilBasFixe:=MyStrToFloat(EditSB.text);
      ChangeImg;
      end;
   ChangeImg;
   end;
end;

procedure Tpop_seuils.EditshKeyPress(Sender: TObject; var Key: Char);
begin
if Key=#13 then
   begin
//   if MyStrToFloat(Editsh.Text)>32767 then Editsh.Text:='32767'; //nolang
   ScrollBarsh.Position:=Round(MyStrToFloat(Editsh.Text));
   ScrollBarsh.Refresh;
   if pop_main.LastChild is Tpop_Image then
      begin
      Image:=pop_main.LastChild as Tpop_Image;
      Image.ImgInfos.Max[1]:=MyStrToFloat(editsh.text);
      if Image.IsUsedForAcq then
         Config.SeuilHautFixe:=MyStrToFloat(editsh.text);
      ChangeImg;
      end;
   Key:=#0;
   ChangeImg;
   end;
end;

procedure Tpop_seuils.InverserClick(Sender: TObject);
var
l:Longint;
d:Double;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   Image:=pop_main.LastChild as Tpop_Image;
   d:=Image.ImgInfos.Max[1];
   Image.ImgInfos.Max[1]:=Image.ImgInfos.Min[1];
   Image.ImgInfos.Min[1]:=d;

   l:=ScrollBarsb.Position;
   ScrollBarsb.Position:=ScrollBarsh.Position;
   ScrollBarsh.Position:=l;
   ScrollBarsb.Refresh;
   ScrollBarsh.Refresh;
   
   Editsb.Text:=MyFloatToStr(Image.ImgInfos.Min[1],2);
   Editsh.Text:=MyFloatToStr(Image.ImgInfos.Max[1],2);
   ChangeImg;
   end;
end;

procedure Tpop_seuils.FastClick(Sender: TObject);
begin
if Fast.Checked then
   begin
   ScrollBarsh.SmallChange:=400;
   ScrollBarsh.LargeChange:=4000;
   ScrollBarsb.SmallChange:=400;
   ScrollBarsb.LargeChange:=4000;
   end;
end;

procedure Tpop_seuils.SlowClick(Sender: TObject);
begin
if Slow.Checked then
   begin
   ScrollBarsh.SmallChange:=1;
   ScrollBarsh.LargeChange:=10;
   ScrollBarsb.SmallChange:=1;
   ScrollBarsb.LargeChange:=10;
   end;
end;

procedure Tpop_seuils.ButtonLumpClick(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   Image:=pop_main.LastChild as Tpop_Image;
   if Image.ImgInfos.Min[1]<Image.ImgInfos.Max[1] then
      begin
      sh:=ScrollBarsh.Position-ScrollBarsh.SmallChange;
      sb:=ScrollBarsb.Position-ScrollBarsb.SmallChange;
      if (sh>=ScrollBarsh.min) and (sb>=ScrollBarsb.min) then
         begin
         ScrollBarsh.Position:=sh;
         ScrollBarsb.Position:=sb;
         end
      else if (sh<ScrollBarsh.min) and (sb>=ScrollBarsb.min) then
         begin
         ScrollBarsb.Position:=ScrollBarsb.Position-(ScrollBarsh.Position-ScrollBarsh.min);
         ScrollBarsh.Position:=ScrollBarsh.min;
         end
      else if (ScrollBarsh.Position-ScrollBarsh.SmallChange>=ScrollBarsh.min) and
         (ScrollBarsb.Position-ScrollBarsb.SmallChange<ScrollBarsb.min) then
         begin
         ScrollBarsh.Position:=ScrollBarsh.Position-(ScrollBarsb.Position-ScrollBarsb.min);
         ScrollBarsb.Position:=ScrollBarsb.min;
         end;
      end
   else
      begin
      sh:=ScrollBarsh.Position+ScrollBarsh.SmallChange;
      sb:=ScrollBarsb.Position+ScrollBarsb.SmallChange;
      if (sh<=ScrollBarsh.Max) and (sb<=ScrollBarsb.Max) then
         begin
         ScrollBarsh.Position:=sh;
         ScrollBarsb.Position:=sb;
         end
      else if (sh<=ScrollBarsh.Max) and (sb>ScrollBarsb.Max) then
         begin
         ScrollBarsh.Position:=ScrollBarsh.Position+(ScrollBarsb.Max-ScrollBarsb.Position);
         ScrollBarsb.Position:=ScrollBarsb.Max;
         end
      else if (sh>ScrollBarsh.Max) and (sb<=ScrollBarsb.Max) then
         begin
         ScrollBarsb.Position:=ScrollBarsb.Position+(ScrollBarsh.Max-ScrollBarsh.Position);
         ScrollBarsh.Position:=ScrollBarsh.Max;
         end;
      end;
   Editsh.text:=IntToStr(ScrollBarsh.Position);
   Editsb.text:=IntToStr(ScrollBarsb.Position);
   Image.ImgInfos.Min[1]:=ScrollBarsb.Position;
   Image.ImgInfos.Max[1]:=ScrollBarsh.Position;
   ChangeImg;
   end;
end;

procedure Tpop_seuils.ButtonLummClick(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   Image:=pop_main.LastChild as Tpop_Image;
   if Image.ImgInfos.Min[1]<Image.ImgInfos.Max[1] then
      begin
      sh:=ScrollBarsh.Position+ScrollBarsh.SmallChange;
      sb:=ScrollBarsb.Position+ScrollBarsb.SmallChange;
      if (sh<=ScrollBarsh.Max) and (sb<=ScrollBarsb.Max) then
         begin
         ScrollBarsh.Position:=sh;
         ScrollBarsb.Position:=sb;
         end
      else if (sh<=ScrollBarsh.Max) and (sb>ScrollBarsb.Max) then
         begin
         ScrollBarsh.Position:=ScrollBarsh.Position+(ScrollBarsb.Max-ScrollBarsb.Position);
         ScrollBarsb.Position:=ScrollBarsb.Max;
         end
      else if (sh>ScrollBarsh.Max) and (sb<=ScrollBarsb.Max) then
         begin
         ScrollBarsb.Position:=ScrollBarsb.Position+(ScrollBarsh.Max-ScrollBarsh.Position);
         ScrollBarsh.Position:=ScrollBarsh.Max;
         end;
      end
   else
      begin
      sh:=ScrollBarsh.Position-ScrollBarsh.SmallChange;
      sb:=ScrollBarsb.Position-ScrollBarsb.SmallChange;
      if (sh>=ScrollBarsh.min) and (sb>=ScrollBarsb.min) then
         begin
         ScrollBarsh.Position:=sh;
         ScrollBarsb.Position:=sb;
         end
      else if (sh<ScrollBarsh.min) and (sb>=ScrollBarsb.min) then
         begin
         ScrollBarsb.Position:=ScrollBarsb.Position-(ScrollBarsh.Position-ScrollBarsh.min);
         ScrollBarsh.Position:=ScrollBarsh.min;
         end
      else if (ScrollBarsh.Position-ScrollBarsh.SmallChange>=ScrollBarsh.min) and
         (ScrollBarsb.Position-ScrollBarsb.SmallChange<ScrollBarsb.min) then
         begin
         ScrollBarsh.Position:=ScrollBarsh.Position-(ScrollBarsb.Position-ScrollBarsb.min);
         ScrollBarsb.Position:=ScrollBarsb.min;
         end;
      end;
   Editsh.text:=IntToStr(ScrollBarsh.Position);
   Editsb.text:=IntToStr(ScrollBarsb.Position);
   Image.ImgInfos.Min[1]:=ScrollBarsb.Position;
   Image.ImgInfos.Max[1]:=ScrollBarsh.Position;
   ChangeImg;
   end;
end;

procedure Tpop_seuils.ButtonLummmClick(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   Image:=pop_main.LastChild as Tpop_Image;
   if Image.ImgInfos.Min[1]<Image.ImgInfos.Max[1] then
      begin
      sh:=ScrollBarsh.Position+ScrollBarsh.LargeChange;
      sb:=ScrollBarsb.Position+ScrollBarsb.LargeChange;
      if (sh<=ScrollBarsh.Max) and (sb<=ScrollBarsb.Max) then
         begin
         ScrollBarsh.Position:=sh;
         ScrollBarsb.Position:=sb;
         end
      else if (sh<=ScrollBarsh.Max) and (sb>ScrollBarsb.Max) then
         begin
         ScrollBarsh.Position:=ScrollBarsh.Position+(ScrollBarsb.Max-ScrollBarsb.Position);
         ScrollBarsb.Position:=ScrollBarsb.Max;
         end
      else if (sh>ScrollBarsh.Max) and (sb<=ScrollBarsb.Max) then
         begin
         ScrollBarsb.Position:=ScrollBarsb.Position+(ScrollBarsh.Max-ScrollBarsh.Position);
         ScrollBarsh.Position:=ScrollBarsh.Max;
         end;
      end
   else
      begin
      sh:=ScrollBarsh.Position-ScrollBarsh.LargeChange;
      sb:=ScrollBarsb.Position-ScrollBarsb.LargeChange;
      if (sh>=ScrollBarsh.min) and (sb>=ScrollBarsb.min) then
         begin
         ScrollBarsh.Position:=sh;
         ScrollBarsb.Position:=sb;
         end
      else if (sh<ScrollBarsh.min) and (sb>=ScrollBarsb.min) then
         begin
         ScrollBarsb.Position:=ScrollBarsb.Position-(ScrollBarsh.Position-ScrollBarsh.min);
         ScrollBarsh.Position:=ScrollBarsh.min;
         end
      else if (sh>=ScrollBarsh.min) and (sb<ScrollBarsb.min) then
         begin
         ScrollBarsh.Position:=ScrollBarsh.Position-(ScrollBarsb.Position-ScrollBarsb.min);
         ScrollBarsb.Position:=ScrollBarsb.min;
         end;
      end;
   Editsh.text:=IntToStr(ScrollBarsh.Position);
   Editsb.text:=IntToStr(ScrollBarsb.Position);
   Image.ImgInfos.Min[1]:=ScrollBarsb.Position;
   Image.ImgInfos.Max[1]:=ScrollBarsh.Position;
   ChangeImg;
   end;
end;

procedure Tpop_seuils.ButtonLumppClick(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   Image:=pop_main.LastChild as Tpop_Image;
   if Image.ImgInfos.Min[1]<Image.ImgInfos.Max[1] then
      begin
      sh:=ScrollBarsh.Position-ScrollBarsh.LargeChange;
      sb:=ScrollBarsb.Position-ScrollBarsb.LargeChange;
      if (sh>=ScrollBarsh.min) and (sb>=ScrollBarsb.min) then
         begin
         ScrollBarsh.Position:=sh;
         ScrollBarsb.Position:=sb;
         end
      else if (sh<ScrollBarsh.min) and (sb>=ScrollBarsb.min) then
         begin
         ScrollBarsb.Position:=ScrollBarsb.Position-(ScrollBarsh.Position-ScrollBarsh.min);
         ScrollBarsh.Position:=ScrollBarsh.min;
         end
      else if (sh>=ScrollBarsh.min) and (sb<ScrollBarsb.min) then
         begin
         ScrollBarsh.Position:=ScrollBarsh.Position-(ScrollBarsb.Position-ScrollBarsb.min);
         ScrollBarsb.Position:=ScrollBarsb.min;
         end;
      end
   else
      begin
      sh:=ScrollBarsh.Position+ScrollBarsh.LargeChange;
      sb:=ScrollBarsb.Position+ScrollBarsb.LargeChange;
      if (sh<=ScrollBarsh.Max) and (sb<=ScrollBarsb.Max) then
         begin
         ScrollBarsh.Position:=sh;
         ScrollBarsb.Position:=sb;
         end
      else if (sh<=ScrollBarsh.Max) and (sb>ScrollBarsb.Max) then
         begin
         ScrollBarsh.Position:=ScrollBarsh.Position+(ScrollBarsb.Max-ScrollBarsb.Position);
         ScrollBarsb.Position:=ScrollBarsb.Max;
         end
      else if (sh>ScrollBarsh.Max) and (sb<=ScrollBarsb.Max) then
         begin
         ScrollBarsb.Position:=ScrollBarsb.Position+(ScrollBarsh.Max-ScrollBarsh.Position);
         ScrollBarsh.Position:=ScrollBarsh.Max;
         end;
      end;
   Editsh.text:=IntToStr(ScrollBarsh.Position);
   Editsb.text:=IntToStr(ScrollBarsb.Position);
   Image.ImgInfos.Min[1]:=ScrollBarsb.Position;
   Image.ImgInfos.Max[1]:=ScrollBarsh.Position;
   ChangeImg;
   end;
end;

procedure Tpop_seuils.ButtonConpClick(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   Image:=pop_main.LastChild as Tpop_Image;
   if Image.ImgInfos.Min[1]<Image.ImgInfos.Max[1] then
      begin
      if ScrollBarsh.SmallChange<>1 then
         sh:=ScrollBarsh.Position-ScrollBarsh.SmallChange div 2
      else
         sh:=ScrollBarsh.Position-ScrollBarsh.SmallChange;
      if ScrollBarsb.SmallChange<>1 then
         sb:=ScrollBarsb.Position+ScrollBarsb.SmallChange div 2
      else
         sb:=ScrollBarsb.Position+ScrollBarsb.SmallChange;
      if sh>sb then
         begin
         ScrollBarsh.Position:=sh;
         ScrollBarsb.Position:=sb;
         end;
      end
   else
      begin
      if ScrollBarsh.SmallChange<>1 then
         sh:=ScrollBarsh.Position+ScrollBarsh.SmallChange div 2
      else
         sh:=ScrollBarsh.Position+ScrollBarsh.SmallChange;
      if ScrollBarsb.SmallChange<>1 then
         sb:=ScrollBarsb.Position-ScrollBarsb.SmallChange div 2
      else
         sb:=ScrollBarsb.Position-ScrollBarsb.SmallChange;
      if sb>sh then
         begin
         ScrollBarsh.Position:=sh;
         ScrollBarsb.Position:=sb;
         end;
      end;
   Editsh.text:=IntToStr(ScrollBarsh.Position);
   Editsb.text:=IntToStr(ScrollBarsb.Position);
   Image.ImgInfos.Min[1]:=ScrollBarsb.Position;
   Image.ImgInfos.Max[1]:=ScrollBarsh.Position;
   ChangeImg;
   end;
end;

procedure Tpop_seuils.ButtonConmClick(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   Image:=pop_main.LastChild as Tpop_Image;
   if Image.ImgInfos.Min[1]<Image.ImgInfos.Max[1] then
      begin
      if ScrollBarsb.SmallChange<>1 then
         sb:=ScrollBarsb.Position-ScrollBarsb.SmallChange div 2
      else
         sb:=ScrollBarsb.Position-ScrollBarsb.SmallChange;
      if ScrollBarsh.SmallChange<>1 then
         sh:=ScrollBarsh.Position+ScrollBarsh.SmallChange div 2
      else
         sh:=ScrollBarsh.Position+ScrollBarsh.SmallChange;
      if (sb>=ScrollBarsb.Min) and (sh<=ScrollBarsh.Max) then
         begin
         ScrollBarsh.Position:=sh;
         ScrollBarsb.Position:=sb;
         end
      else if (sb<ScrollBarsb.Min) and (sh<=ScrollBarsh.Max) then
         begin
         ScrollBarsh.Position:=ScrollBarsh.Position+(ScrollBarsb.Position-ScrollBarsb.Min);
         ScrollBarsb.Position:=ScrollBarsb.Min;
         end
      else if (sb>=ScrollBarsb.Min) and (sh>ScrollBarsh.Max) then
         begin
         ScrollBarsb.Position:=ScrollBarsb.Position-(ScrollBarsh.Max-ScrollBarsh.Position);
         ScrollBarsh.Position:=ScrollBarsh.Max;
         end;
      end
   else
      begin
      if ScrollBarsb.SmallChange<>1 then
         sb:=ScrollBarsb.Position+ScrollBarsb.SmallChange div 2
      else
         sb:=ScrollBarsb.Position+ScrollBarsb.SmallChange;
      if ScrollBarsh.SmallChange<>1 then
         sh:=ScrollBarsh.Position-ScrollBarsh.SmallChange div 2
      else
         sh:=ScrollBarsh.Position-ScrollBarsh.SmallChange;
      if (sh>=ScrollBarsb.Min) and (sb<=ScrollBarsh.Max) then
         begin
         ScrollBarsh.Position:=sh;
         ScrollBarsb.Position:=sb;
         end
      else if (sh<ScrollBarsh.Min) and (sb<=ScrollBarsb.Max) then
         begin
         ScrollBarsb.Position:=ScrollBarsb.Position+(ScrollBarsh.Position-ScrollBarsh.Min);
         ScrollBarsh.Position:=ScrollBarsh.Min;
         end
      else if (sh>=ScrollBarsh.Min) and (sb>ScrollBarsb.Max) then
         begin
         ScrollBarsh.Position:=ScrollBarsh.Position-(ScrollBarsb.Max-ScrollBarsb.Position);
         ScrollBarsb.Position:=ScrollBarsb.Max;
         end;
      end;
   Editsh.text:=IntToStr(ScrollBarsh.Position);
   Editsb.text:=IntToStr(ScrollBarsb.Position);
   Image.ImgInfos.Min[1]:=ScrollBarsb.Position;
   Image.ImgInfos.Max[1]:=ScrollBarsh.Position;
   ChangeImg;
   end;
end;

procedure Tpop_seuils.ButtonConppClick(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   Image:=pop_main.LastChild as Tpop_Image;
   if Image.ImgInfos.Min[1]<Image.ImgInfos.Max[1] then
      begin
      sh:=ScrollBarsh.Position-ScrollBarsh.LargeChange div 2;
      sb:=ScrollBarsb.Position+ScrollBarsb.LargeChange div 2;
      if sh>sb then
         begin
         ScrollBarsh.Position:=sh;
         ScrollBarsb.Position:=sb;
         end;
      end
   else
      begin
      sh:=ScrollBarsh.Position+ScrollBarsh.LargeChange div 2;
      sb:=ScrollBarsb.Position-ScrollBarsb.LargeChange div 2;
      if sb>sh then
         begin
         ScrollBarsh.Position:=sh;
         ScrollBarsb.Position:=sb;
         end;
      end;
   Editsh.text:=IntToStr(ScrollBarsh.Position);
   Editsb.text:=IntToStr(ScrollBarsb.Position);
   Image.ImgInfos.Min[1]:=ScrollBarsb.Position;
   Image.ImgInfos.Max[1]:=ScrollBarsh.Position;
   ChangeImg;
   end;
end;

procedure Tpop_seuils.ButtonConmmClick(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   Image:=pop_main.LastChild as Tpop_Image;
   if Image.ImgInfos.Min[1]<Image.ImgInfos.Max[1] then
      begin
      sb:=ScrollBarsb.Position-ScrollBarsb.LargeChange div 2;
      sh:=ScrollBarsh.Position+ScrollBarsh.LargeChange div 2;
      if (sb>=ScrollBarsb.Min) and (sh<=ScrollBarsh.Max) then
         begin
         ScrollBarsh.Position:=sh;
         ScrollBarsb.Position:=sb;
         end
      else if (sb<ScrollBarsb.Min) and (sh<=ScrollBarsh.Max) then
         begin
         ScrollBarsh.Position:=ScrollBarsh.Position+(ScrollBarsb.Position-ScrollBarsb.Min);
         ScrollBarsb.Position:=ScrollBarsb.Min;
         end
      else if (sb>=ScrollBarsb.Min) and (sh>ScrollBarsh.Max) then
         begin
         ScrollBarsb.Position:=ScrollBarsb.Position-(ScrollBarsh.Max-ScrollBarsh.Position);
         ScrollBarsh.Position:=ScrollBarsh.Max;
         end;
      end
   else
      begin
      sb:=ScrollBarsb.Position+ScrollBarsb.LargeChange div 2;
      sh:=ScrollBarsh.Position-ScrollBarsh.LargeChange div 2;
      if (sh>=ScrollBarsh.Min) and (sb<=ScrollBarsb.Max) then
         begin
         ScrollBarsh.Position:=sh;
         ScrollBarsb.Position:=sb;
         end
      else if (sh<ScrollBarsh.Min) and (sb<=ScrollBarsb.Max) then
         begin
         ScrollBarsb.Position:=ScrollBarsb.Position+(ScrollBarsh.Position-ScrollBarsh.Min);
         ScrollBarsh.Position:=ScrollBarsh.Min;
         end
      else if (sh>=ScrollBarsh.Min) and (sb>ScrollBarsb.Max) then
         begin
         ScrollBarsh.Position:=ScrollBarsh.Position-(ScrollBarsb.Max-ScrollBarsb.Position);
         ScrollBarsb.Position:=ScrollBarsb.Max;
         end;
      end;
   Editsh.text:=IntToStr(ScrollBarsh.Position);
   Editsb.text:=IntToStr(ScrollBarsb.Position);
   Image.ImgInfos.Min[1]:=ScrollBarsb.Position;
   Image.ImgInfos.Max[1]:=ScrollBarsh.Position;
   ChangeImg;
   end;
end;

procedure Tpop_seuils.FileListBox2Click(Sender: TObject);
Var
i,Liste:Byte;
MemFichier:TMemoryStream;
begin
MemFichier:=TMemoryStream.Create;
try
MemFichier.Seek(0,0);
MemFichier.LoadFromFile(FileListBox2.FileName);
MemFichier.Seek(0,0);
MemFichier.Read(Palh,SizeOf(Palh));
if (Palh.PaSignature[1]='P') and (Palh.PaSignature[2]='A')
   and(Palh.PaSignature[3]='L') then
   begin
   for i:=0 to 255 do
      begin
      MemFichier.Read(Pal[i].Rouge,1);
      MemFichier.Read(Pal[i].Vert,1);
      MemFichier.Read(Pal[i].Bleu,1);
      MemFichier.Read(Liste,1);
      end;
   PalExpl;
   end
else raise ErrorPalette.Create(lang('Le fichier ')+ExtractFileName(FileListBox2.FileName)+#13+
   lang('n''est pas une palette couleur compatible'));
if pop_main.LastChild is Tpop_Image then
   begin
   Image:=pop_main.LastChild as Tpop_Image;
   Image.visuImg;
   end;
finally
MemFichier.Free;
end;
end;

Procedure tpop_seuils.PalExpl;
var
MemExpl:TMemoryStream;
Palh:TBmpHeader;
Ires,Ipal,Val:Byte;
i,j:Longint;
begin
MemExpl:=TMemoryStream.Create;
with Palh do
   begin
   Bftype:=19778;
   Bfsize:=1078+img_rampe.Width*Img_rampe.Height;
   Bfreserved1:=0;
   Bfreserved2:=0;
   Bfoffbits:=1078;
   Bisize:=40;
   Biwidth:=Img_rampe.Width;
   Biheight:=Img_rampe.Height;
   Biplanes:=1;
   Bibitcount:=8;
   Bicompression:=0;
   Bisizeimage:=0;
   Bixpelspermeter:=0;
   Biypelspermeter:=0;
   Biclrused:=256;
   Biclrimportant:=0;
   end;
MemExpl.Seek(0,0);
MemExpl.Write(Palh,sizeof(Palh));
ires:=0;
for ipal:=0 to 255 do
   begin
   MemExpl.Write(Pal[ipal].Bleu,1);
   MemExpl.Write(Pal[ipal].Vert,1);
   MemExpl.Write(Pal[ipal].Rouge,1);
   MemExpl.Write(ires,1);
   end;
for j:=1 to Img_rampe.Height do
   for i:=1 to Img_rampe.Width do
      begin
      Val:=i*255 div Img_rampe.Width;
      MemExpl.Write(Val,1);
      end;
MemExpl.Seek(0,0);
Img_rampe.Picture.Bitmap.LoadFromStream(MemExpl);
MemExpl.Free;
end;

procedure tpop_seuils.PlanetesClick(Sender: TObject);
begin
if pop_main.LastChild is Tpop_Image then
   begin
   Image:=pop_main.LastChild as Tpop_Image;
   Image.VisuAutoPlanetes;
   end;
end;

procedure TPop_seuils.StellairesClick(Sender: TObject);
begin
if pop_main.LastChild is Tpop_Image then
   begin
   Image:=pop_main.LastChild as Tpop_Image;
   Image.AjusteFenetre;
   Image.VisuAutoEtoiles;
   end;
end;

procedure TPop_seuils.NormalClick(Sender: TObject);
begin
if Normal.Checked then
   begin
   ScrollBarsh.SmallChange:=100;
   ScrollBarsh.LargeChange:=1000;
   ScrollBarsb.SmallChange:=100;
   ScrollBarsb.LargeChange:=1000;
   end;
end;


procedure Tpop_seuils.FormCreate(Sender: TObject);
begin
editsh.Enabled:=False;
editsb.Enabled:=False;
scrollbarsh.Enabled:=False;
scrollbarsb.Enabled:=False;
GroupBox1.Enabled:=False;
Fast.Enabled:=False;
Normal.Enabled:=False;
Slow.Enabled:=False;
ButtonLummm.Enabled:=False;
ButtonLumm.Enabled:=False;
ButtonLumpp.Enabled:=False;
ButtonLump.Enabled:=False;
ButtonConmm.Enabled:=False;
ButtonConm.Enabled:=False;
ButtonConpp.Enabled:=False;
ButtonConp.Enabled:=False;
Inverser.Enabled:=False;
Stellaires.Enabled:=False;
Planetes.Enabled:=False;
FileListBox2.Enabled:=False;
FileListBox2.Directory:=ExtractFilePath(Application.Exename);
PalExpl;

if pop_main.LastChild is Tpop_Image then pop_main.SeuilsEnable;
end;

procedure Tpop_seuils.FormShow(Sender: TObject);
begin
Left:=Screen.Width-Width;
UpDateLang(Self);
end;

procedure Tpop_seuils.SpeedButton1Click(Sender: TObject);
begin
PalGrise(Pal);
ChangeImg;
end;

end.
