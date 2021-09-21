unit pu_seuils_color;

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
  Buttons, StdCtrls, FileCtrl, ExtCtrls, u_class ,pu_image;

type
  Tpop_seuils_color = class(TForm)
    GroupBox1: TGroupBox;
    Fast: TRadioButton;
    Slow: TRadioButton;
    Normal: TRadioButton;
    GroupBox2: TGroupBox;
    editsh: TEdit;
    Editsb: TEdit;
    ScrollBarsb: TScrollBar;
    ScrollBarsh: TScrollBar;
    outButtonLummm: TButton;
    ButtonLumm: TButton;
    outButtonConmm: TButton;
    ButtonConm: TButton;
    ButtonLump: TButton;
    outButtonLumpp: TButton;
    outButtonConpp: TButton;
    ButtonConp: TButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox3: TGroupBox;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Edit1: TEdit;
    Edit2: TEdit;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    outButton1: TButton;
    Button2: TButton;
    outButton3: TButton;
    Button4: TButton;
    Button5: TButton;
    outButton6: TButton;
    outButton7: TButton;
    Button8: TButton;
    Panel3: TPanel;
    Panel4: TPanel;
    GroupBox4: TGroupBox;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Edit3: TEdit;
    Edit4: TEdit;
    ScrollBar3: TScrollBar;
    ScrollBar4: TScrollBar;
    outButton9: TButton;
    Button10: TButton;
    outButton11: TButton;
    Button12: TButton;
    Button13: TButton;
    outButton14: TButton;
    outButton15: TButton;
    Button16: TButton;
    Panel5: TPanel;
    Panel6: TPanel;
    Button17: TButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    procedure ChangeImg;
    procedure ScrollBarshScroll(Sender: TObject;
              ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure ScrollBarsbScroll(Sender: TObject;
              ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure EditsbKeyPress(Sender: TObject; var Key: Char);
    procedure EditshKeyPress(Sender: TObject; var Key: Char);
    procedure FastClick(Sender: TObject);
    procedure SlowClick(Sender: TObject);
    procedure ButtonLumpClick(Sender: TObject);
    procedure ButtonLummClick(Sender: TObject);
    procedure outButtonLummmClick(Sender: TObject);
    procedure outButtonLumppClick(Sender: TObject);
    procedure ButtonConpClick(Sender: TObject);
    procedure ButtonConmClick(Sender: TObject);
    procedure outButtonConppClick(Sender: TObject);
    procedure outButtonConmmClick(Sender: TObject);
    procedure NormalClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure ScrollBar2Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure ScrollBar4Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure ScrollBar3Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure outButton1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure outButton6Click(Sender: TObject);
    procedure outButton3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure outButton7Click(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure outButton9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure outButton14Click(Sender: TObject);
    procedure outButton11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure outButton15Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure FormShow(Sender: TObject);


  private
    { Private declarations }
    memfichier:tmemorystream;
    Palh:TPalHeader;
    the_form:tpop_image;
//    min, max:smallint;


  public

  end;

var
  pop_seuils_color: Tpop_seuils_color;

implementation

uses u_math,
     u_general,
     pu_camera,
     pu_main,
     u_visu,
     u_lang;


{$R *.DFM}

procedure Tpop_seuils_color.ChangeImg;
var
i:integer;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   the_form.ImgInfos.Min[1]:=mystrtofloat(Editsb.Text);
   the_form.ImgInfos.Max[1]:=mystrtofloat(Editsh.Text);
   the_form.ImgInfos.Min[2]:=mystrtofloat(Edit2.Text);
   the_form.ImgInfos.Max[2]:=mystrtofloat(Edit1.Text);
   the_form.ImgInfos.Min[3]:=mystrtofloat(Edit4.Text);
   the_form.ImgInfos.Max[3]:=mystrtofloat(Edit3.Text);
   the_form.visuImg;
   end;
end;



procedure Tpop_seuils_color.ScrollBarshScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
Editsh.Text:=IntToStr(scrollpos);
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   the_form.ImgInfos.Max[1]:=scrollpos;
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.ScrollBarsbScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
Editsb.Text:=IntToStr(ScrollPos);
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   the_form.ImgInfos.Max[1]:=scrollpos;
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.EditsbKeyPress(Sender: TObject; var Key: Char);
begin
if Key=#13 then
   begin
   if mystrtofloat(Editsb.Text)<-32768 then Editsb.Text:='-32768'; //nolang
   ScrollBarsb.Position:=StrToInt(Editsb.Text);
   ScrollBarsb.Refresh;
   if pop_main.LastChild is Tpop_Image then
      begin
      the_form:=pop_main.LastChild as Tpop_Image;
      the_form.ImgInfos.Min[1]:=mystrtofloat(editsb.text);
      ChangeImg;
      end;
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.EditshKeyPress(Sender: TObject; var Key: Char);
begin
if Key=#13 then
   begin
   if mystrtofloat(Editsh.Text)>32767 then Editsh.Text:='32767'; //nolang
   ScrollBarsh.Position:=StrToInt(Editsh.Text);
   ScrollBarsh.Refresh;
   if pop_main.LastChild is Tpop_Image then
      begin
      the_form:=pop_main.LastChild as Tpop_Image;
      the_form.ImgInfos.Max[1]:=mystrtofloat(editsh.text);
      ChangeImg;
      end;
   Key:=#0;
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.FastClick(Sender: TObject);
begin
if Fast.Checked then
   begin
   ScrollBarsh.SmallChange:=400;
   ScrollBarsh.LargeChange:=4000;
   ScrollBarsb.SmallChange:=400;
   ScrollBarsb.LargeChange:=4000;
   ScrollBar1.SmallChange:=400;
   ScrollBar1.LargeChange:=4000;
   ScrollBar2.SmallChange:=400;
   ScrollBar2.LargeChange:=4000;
   ScrollBar3.SmallChange:=400;
   ScrollBar3.LargeChange:=4000;
   ScrollBar4.SmallChange:=400;
   ScrollBar4.LargeChange:=4000;
   end;
end;

procedure Tpop_seuils_color.SlowClick(Sender: TObject);
begin
if Slow.Checked then
   begin
   ScrollBarsh.SmallChange:=1;
   ScrollBarsh.LargeChange:=10;
   ScrollBarsb.SmallChange:=1;
   ScrollBarsb.LargeChange:=10;
   ScrollBar1.SmallChange:=1;
   ScrollBar1.LargeChange:=10;
   ScrollBar2.SmallChange:=1;
   ScrollBar2.LargeChange:=10;
   ScrollBar3.SmallChange:=1;
   ScrollBar3.LargeChange:=10;
   ScrollBar4.SmallChange:=1;
   ScrollBar4.LargeChange:=10;
   end;
end;

procedure Tpop_seuils_color.ButtonLumpClick(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
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
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.ButtonLummClick(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
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
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.outButtonLummmClick(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
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
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.outButtonLumppClick(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
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
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.ButtonConpClick(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
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
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.ButtonConmClick(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
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
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.outButtonConppClick(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
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
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.outButtonConmmClick(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
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
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.NormalClick(Sender: TObject);
begin
if Normal.Checked then
   begin
   ScrollBarsh.SmallChange:=100;
   ScrollBarsh.LargeChange:=1000;
   ScrollBarsb.SmallChange:=100;
   ScrollBarsb.LargeChange:=1000;
   ScrollBar1.SmallChange:=100;
   ScrollBar1.LargeChange:=1000;
   ScrollBar2.SmallChange:=100;
   ScrollBar2.LargeChange:=1000;
   ScrollBar3.SmallChange:=100;
   ScrollBar3.LargeChange:=1000;
   ScrollBar4.SmallChange:=100;
   ScrollBar4.LargeChange:=1000;
   end;
end;


procedure Tpop_seuils_color.SpeedButton1Click(Sender: TObject);
var
d:Double;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   d:=the_form.ImgInfos.Max[1];
   the_form.ImgInfos.Max[1]:=the_form.ImgInfos.Min[1];
   the_form.ImgInfos.Min[1]:=d;
   ScrollBarsb.Position:=Round(the_form.ImgInfos.Min[1]);
   ScrollBarsb.Refresh;
   Editsb.Text:=IntToStr(Round(the_form.ImgInfos.Min[1]));
   ScrollBarsh.Position:=Round(the_form.ImgInfos.Max[1]);
   ScrollBarsh.Refresh;
   Editsh.Text:=IntToStr(Round(the_form.ImgInfos.Max[1]));
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.SpeedButton2Click(Sender: TObject);
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   the_form.VisuAutoEtoilesPlan(1);
   end;
end;

procedure Tpop_seuils_color.SpeedButton3Click(Sender: TObject);
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   the_form.VisuAutoPlanetesPlan(1);
   end;
end;

procedure Tpop_seuils_color.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if Key=#13 then
   begin
   if mystrtofloat(Editsh.Text)>32767 then Editsh.Text:='32767'; //nolang
   ScrollBarsh.Position:=StrToInt(Editsh.Text);
   ScrollBarsh.Refresh;
   if pop_main.LastChild is Tpop_Image then
      begin
      the_form:=pop_main.LastChild as Tpop_Image;
      the_form.ImgInfos.Max[2]:=mystrtofloat(editsh.text);
      ChangeImg;
      end;
   Key:=#0;
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
if Key=#13 then
   begin
   if mystrtofloat(Editsb.Text)<-32768 then Editsb.Text:='-32768'; //nolang
   ScrollBarsb.Position:=StrToInt(Editsb.Text);
   ScrollBarsb.Refresh;
   if pop_main.LastChild is Tpop_Image then
      begin
      the_form:=pop_main.LastChild as Tpop_Image;
      the_form.ImgInfos.Min[2]:=mystrtofloat(editsb.text);
      ChangeImg;
      end;
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
if Key=#13 then
   begin
   if mystrtofloat(Editsh.Text)>32767 then Editsh.Text:='32767'; //nolang
   ScrollBarsh.Position:=StrToInt(Editsh.Text);
   ScrollBarsh.Refresh;
   if pop_main.LastChild is Tpop_Image then
      begin
      the_form:=pop_main.LastChild as Tpop_Image;
      the_form.ImgInfos.Max[3]:=mystrtofloat(editsh.text);
      ChangeImg;
      end;
   Key:=#0;
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
if Key=#13 then
   begin
   if mystrtofloat(Editsb.Text)<-32768 then Editsb.Text:='-32768'; //nolang
   ScrollBarsb.Position:=StrToInt(Editsb.Text);
   ScrollBarsb.Refresh;
   if pop_main.LastChild is Tpop_Image then
      begin
      the_form:=pop_main.LastChild as Tpop_Image;
      the_form.ImgInfos.Min[3]:=mystrtofloat(editsb.text);
      ChangeImg;
      end;
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.ScrollBar2Scroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
Edit1.Text:=IntToStr(scrollpos);
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   the_form.ImgInfos.Max[2]:=scrollpos;
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.ScrollBar4Scroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
Edit3.Text:=IntToStr(scrollpos);
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   the_form.ImgInfos.Max[3]:=scrollpos;
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.ScrollBar1Scroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
Edit2.Text:=IntToStr(ScrollPos);
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   the_form.ImgInfos.Max[2]:=scrollpos;
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.ScrollBar3Scroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
Edit4.Text:=IntToStr(ScrollPos);
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   the_form.ImgInfos.Max[3]:=scrollpos;
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.outButton1Click(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
      begin
      sh:=ScrollBar2.Position+ScrollBar2.LargeChange;
      sb:=ScrollBar1.Position+ScrollBar1.LargeChange;
      if (sh<=ScrollBar2.Max) and (sb<=ScrollBar1.Max) then
         begin
         ScrollBar2.Position:=sh;
         ScrollBar1.Position:=sb;
         end
      else if (sh<=ScrollBar2.Max) and (sb>ScrollBar1.Max) then
         begin
         ScrollBar2.Position:=ScrollBar2.Position+(ScrollBar1.Max-ScrollBar1.Position);
         ScrollBar1.Position:=ScrollBar1.Max;
         end
      else if (sh>ScrollBar2.Max) and (sb<=ScrollBar1.Max) then
         begin
         ScrollBar1.Position:=ScrollBar1.Position+(ScrollBar2.Max-ScrollBar2.Position);
         ScrollBar2.Position:=ScrollBar2.Max;
         end;
      end
   else
      begin
      sh:=ScrollBar2.Position-ScrollBar2.LargeChange;
      sb:=ScrollBar1.Position-ScrollBar1.LargeChange;
      if (sh>=ScrollBar2.min) and (sb>=ScrollBar1.min) then
         begin
         ScrollBar2.Position:=sh;
         ScrollBar1.Position:=sb;
         end
      else if (sh<ScrollBar2.min) and (sb>=ScrollBar1.min) then
         begin
         ScrollBar1.Position:=ScrollBar1.Position-(ScrollBar2.Position-ScrollBar2.min);
         ScrollBar2.Position:=ScrollBar2.min;
         end
      else if (sh>=ScrollBar2.min) and (sb<ScrollBar1.min) then
         begin
         ScrollBar2.Position:=ScrollBar2.Position-(ScrollBar1.Position-ScrollBar1.min);
         ScrollBar1.Position:=ScrollBar1.min;
         end;
      end;
   Edit1.text:=IntToStr(ScrollBar2.Position);
   Edit2.text:=IntToStr(ScrollBar1.Position);
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.Button2Click(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
      begin
      sh:=ScrollBar2.Position+ScrollBar2.SmallChange;
      sb:=ScrollBar1.Position+ScrollBar1.SmallChange;
      if (sh<=ScrollBar2.Max) and (sb<=ScrollBar1.Max) then
         begin
         ScrollBar2.Position:=sh;
         ScrollBar1.Position:=sb;
         end
      else if (sh<=ScrollBar2.Max) and (sb>ScrollBar1.Max) then
         begin
         ScrollBar2.Position:=ScrollBar2.Position+(ScrollBar1.Max-ScrollBar1.Position);
         ScrollBar1.Position:=ScrollBar1.Max;
         end
      else if (sh>ScrollBar2.Max) and (sb<=ScrollBar1.Max) then
         begin
         ScrollBar1.Position:=ScrollBar1.Position+(ScrollBar2.Max-ScrollBar2.Position);
         ScrollBar2.Position:=ScrollBar2.Max;
         end;
      end
   else
      begin
      sh:=ScrollBar2.Position-ScrollBar2.SmallChange;
      sb:=ScrollBar1.Position-ScrollBar1.SmallChange;
      if (sh>=ScrollBar2.min) and (sb>=ScrollBar1.min) then
         begin
         ScrollBar2.Position:=sh;
         ScrollBar1.Position:=sb;
         end
      else if (sh<ScrollBar2.min) and (sb>=ScrollBar1.min) then
         begin
         ScrollBar1.Position:=ScrollBar1.Position-(ScrollBar2.Position-ScrollBar2.min);
         ScrollBar2.Position:=ScrollBar2.min;
         end
      else if (ScrollBar2.Position-ScrollBar2.SmallChange>=ScrollBar2.min) and
         (ScrollBar1.Position-ScrollBar1.SmallChange<ScrollBar1.min) then
         begin
         ScrollBar2.Position:=ScrollBar2.Position-(ScrollBar1.Position-ScrollBar1.min);
         ScrollBar1.Position:=ScrollBar1.min;
         end;
      end;
   Edit1.text:=IntToStr(ScrollBar2.Position);
   Edit2.text:=IntToStr(ScrollBar1.Position);
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.Button5Click(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
      begin
      sh:=ScrollBar2.Position-ScrollBar2.SmallChange;
      sb:=ScrollBar1.Position-ScrollBar1.SmallChange;
      if (sh>=ScrollBar2.min) and (sb>=ScrollBar1.min) then
         begin
         ScrollBar2.Position:=sh;
         ScrollBar1.Position:=sb;
         end
      else if (sh<ScrollBar2.min) and (sb>=ScrollBar1.min) then
         begin
         ScrollBar1.Position:=ScrollBar1.Position-(ScrollBar2.Position-ScrollBar2.min);
         ScrollBar2.Position:=ScrollBar2.min;
         end
      else if (ScrollBar2.Position-ScrollBar2.SmallChange>=ScrollBar2.min) and
         (ScrollBar1.Position-ScrollBar1.SmallChange<ScrollBar1.min) then
         begin
         ScrollBar2.Position:=ScrollBar2.Position-(ScrollBar1.Position-ScrollBar1.min);
         ScrollBar1.Position:=ScrollBar1.min;
         end;
      end
   else
      begin
      sh:=ScrollBar2.Position+ScrollBar2.SmallChange;
      sb:=ScrollBar1.Position+ScrollBar1.SmallChange;
      if (sh<=ScrollBar2.Max) and (sb<=ScrollBar1.Max) then
         begin
         ScrollBar2.Position:=sh;
         ScrollBar1.Position:=sb;
         end
      else if (sh<=ScrollBar2.Max) and (sb>ScrollBar1.Max) then
         begin
         ScrollBar2.Position:=ScrollBar2.Position+(ScrollBar1.Max-ScrollBar1.Position);
         ScrollBar1.Position:=ScrollBar1.Max;
         end
      else if (sh>ScrollBar2.Max) and (sb<=ScrollBar1.Max) then
         begin
         ScrollBar1.Position:=ScrollBar1.Position+(ScrollBar2.Max-ScrollBar2.Position);
         ScrollBar2.Position:=ScrollBar2.Max;
         end;
      end;
   Edit1.text:=IntToStr(ScrollBar2.Position);
   Edit2.text:=IntToStr(ScrollBar1.Position);
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.outButton6Click(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
      begin
      sh:=ScrollBar2.Position-ScrollBar2.LargeChange;
      sb:=ScrollBar1.Position-ScrollBar1.LargeChange;
      if (sh>=ScrollBar2.min) and (sb>=ScrollBar1.min) then
         begin
         ScrollBar2.Position:=sh;
         ScrollBar1.Position:=sb;
         end
      else if (sh<ScrollBar2.min) and (sb>=ScrollBar1.min) then
         begin
         ScrollBar1.Position:=ScrollBar1.Position-(ScrollBar2.Position-ScrollBar2.min);
         ScrollBar2.Position:=ScrollBar2.min;
         end
      else if (sh>=ScrollBar2.min) and (sb<ScrollBar1.min) then
         begin
         ScrollBar2.Position:=ScrollBar2.Position-(ScrollBar1.Position-ScrollBar1.min);
         ScrollBar1.Position:=ScrollBar1.min;
         end;
      end
   else
      begin
      sh:=ScrollBar2.Position+ScrollBar2.LargeChange;
      sb:=ScrollBar1.Position+ScrollBar1.LargeChange;
      if (sh<=ScrollBar2.Max) and (sb<=ScrollBar1.Max) then
         begin
         ScrollBar2.Position:=sh;
         ScrollBar1.Position:=sb;
         end
      else if (sh<=ScrollBar2.Max) and (sb>ScrollBar1.Max) then
         begin
         ScrollBar2.Position:=ScrollBar2.Position+(ScrollBar1.Max-ScrollBar1.Position);
         ScrollBar1.Position:=ScrollBar1.Max;
         end
      else if (sh>ScrollBar2.Max) and (sb<=ScrollBar1.Max) then
         begin
         ScrollBar1.Position:=ScrollBar1.Position+(ScrollBar2.Max-ScrollBar2.Position);
         ScrollBar2.Position:=ScrollBar2.Max;
         end;
      end;
   Edit1.text:=IntToStr(ScrollBar2.Position);
   Edit2.text:=IntToStr(ScrollBar1.Position);
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.outButton3Click(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
      begin
      sb:=ScrollBar1.Position-ScrollBar1.LargeChange div 2;
      sh:=ScrollBar2.Position+ScrollBar2.LargeChange div 2;
      if (sb>=ScrollBar1.Min) and (sh<=ScrollBar2.Max) then
         begin
         ScrollBar2.Position:=sh;
         ScrollBar1.Position:=sb;
         end
      else if (sb<ScrollBar1.Min) and (sh<=ScrollBar2.Max) then
         begin
         ScrollBar2.Position:=ScrollBar2.Position+(ScrollBar1.Position-ScrollBar1.Min);
         ScrollBar1.Position:=ScrollBar1.Min;
         end
      else if (sb>=ScrollBar1.Min) and (sh>ScrollBar2.Max) then
         begin
         ScrollBar1.Position:=ScrollBar1.Position-(ScrollBar2.Max-ScrollBar2.Position);
         ScrollBar2.Position:=ScrollBar2.Max;
         end;
      end
   else
      begin
      sb:=ScrollBar1.Position+ScrollBar1.LargeChange div 2;
      sh:=ScrollBar2.Position-ScrollBar2.LargeChange div 2;
      if (sh>=ScrollBar2.Min) and (sb<=ScrollBar1.Max) then
         begin
         ScrollBar2.Position:=sh;
         ScrollBar1.Position:=sb;
         end
      else if (sh<ScrollBar2.Min) and (sb<=ScrollBar1.Max) then
         begin
         ScrollBar1.Position:=ScrollBar1.Position+(ScrollBar2.Position-ScrollBar2.Min);
         ScrollBar2.Position:=ScrollBar2.Min;
         end
      else if (sh>=ScrollBar2.Min) and (sb>ScrollBar1.Max) then
         begin
         ScrollBar2.Position:=ScrollBar2.Position-(ScrollBar1.Max-ScrollBar1.Position);
         ScrollBar1.Position:=ScrollBar1.Max;
         end;
      end;
   Edit1.text:=IntToStr(ScrollBar2.Position);
   Edit2.text:=IntToStr(ScrollBar1.Position);
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.Button4Click(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
      begin
      if ScrollBar1.SmallChange<>1 then
         sb:=ScrollBar1.Position-ScrollBar1.SmallChange div 2
      else
         sb:=ScrollBar1.Position-ScrollBar1.SmallChange;
      if ScrollBar2.SmallChange<>1 then
         sh:=ScrollBar2.Position+ScrollBar2.SmallChange div 2
      else
         sh:=ScrollBar2.Position+ScrollBar2.SmallChange;
      if (sb>=ScrollBar1.Min) and (sh<=ScrollBar2.Max) then
         begin
         ScrollBar2.Position:=sh;
         ScrollBar1.Position:=sb;
         end
      else if (sb<ScrollBar1.Min) and (sh<=ScrollBar2.Max) then
         begin
         ScrollBar2.Position:=ScrollBar2.Position+(ScrollBar1.Position-ScrollBar1.Min);
         ScrollBar1.Position:=ScrollBar1.Min;
         end
      else if (sb>=ScrollBar1.Min) and (sh>ScrollBar2.Max) then
         begin
         ScrollBar1.Position:=ScrollBar1.Position-(ScrollBar2.Max-ScrollBar2.Position);
         ScrollBar2.Position:=ScrollBar2.Max;
         end;
      end
   else
      begin
      if ScrollBar1.SmallChange<>1 then
         sb:=ScrollBar1.Position+ScrollBar1.SmallChange div 2
      else
         sb:=ScrollBar1.Position+ScrollBar1.SmallChange;
      if ScrollBar2.SmallChange<>1 then
         sh:=ScrollBar2.Position-ScrollBar2.SmallChange div 2
      else
         sh:=ScrollBar2.Position-ScrollBar2.SmallChange;
      if (sh>=ScrollBar1.Min) and (sb<=ScrollBar2.Max) then
         begin
         ScrollBar2.Position:=sh;
         ScrollBar1.Position:=sb;
         end
      else if (sh<ScrollBar2.Min) and (sb<=ScrollBar1.Max) then
         begin
         ScrollBar1.Position:=ScrollBar1.Position+(ScrollBar2.Position-ScrollBar2.Min);
         ScrollBar2.Position:=ScrollBar2.Min;
         end
      else if (sh>=ScrollBar2.Min) and (sb>ScrollBar1.Max) then
         begin
         ScrollBar2.Position:=ScrollBar2.Position-(ScrollBar1.Max-ScrollBar1.Position);
         ScrollBar1.Position:=ScrollBar1.Max;
         end;
      end;
   Edit1.text:=IntToStr(ScrollBar2.Position);
   Edit2.text:=IntToStr(ScrollBar1.Position);
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.Button8Click(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
      begin
      if ScrollBar2.SmallChange<>1 then
         sh:=ScrollBar2.Position-ScrollBar2.SmallChange div 2
      else
         sh:=ScrollBar2.Position-ScrollBar2.SmallChange;
      if ScrollBar1.SmallChange<>1 then
         sb:=ScrollBar1.Position+ScrollBar1.SmallChange div 2
      else
         sb:=ScrollBar1.Position+ScrollBar1.SmallChange;
      if sh>sb then
         begin
         ScrollBar2.Position:=sh;
         ScrollBar1.Position:=sb;
         end;
      end
   else
      begin
      if ScrollBar2.SmallChange<>1 then
         sh:=ScrollBar2.Position+ScrollBar2.SmallChange div 2
      else
         sh:=ScrollBar2.Position+ScrollBar2.SmallChange;
      if ScrollBar1.SmallChange<>1 then
         sb:=ScrollBar1.Position-ScrollBar1.SmallChange div 2
      else
         sb:=ScrollBar1.Position-ScrollBar1.SmallChange;
      if sb>sh then
         begin
         ScrollBar2.Position:=sh;
         ScrollBar1.Position:=sb;
         end;
      end;
   Edit1.text:=IntToStr(ScrollBar2.Position);
   Edit2.text:=IntToStr(ScrollBar1.Position);
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.outButton7Click(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
      begin
      sh:=ScrollBar2.Position-ScrollBar2.LargeChange div 2;
      sb:=ScrollBar1.Position+ScrollBar1.LargeChange div 2;
      if sh>sb then
         begin
         ScrollBar2.Position:=sh;
         ScrollBar1.Position:=sb;
         end;
      end
   else
      begin
      sh:=ScrollBar2.Position+ScrollBar2.LargeChange div 2;
      sb:=ScrollBar1.Position-ScrollBar1.LargeChange div 2;
      if sb>sh then
         begin
         ScrollBar2.Position:=sh;
         ScrollBar1.Position:=sb;
         end;
      end;
   Edit1.text:=IntToStr(ScrollBar2.Position);
   Edit2.text:=IntToStr(ScrollBar1.Position);
   ChangeImg;
   end;
end;


procedure Tpop_seuils_color.outButton9Click(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
      begin
      sh:=ScrollBar4.Position+ScrollBar4.LargeChange;
      sb:=ScrollBar3.Position+ScrollBar3.LargeChange;
      if (sh<=ScrollBar4.Max) and (sb<=ScrollBar3.Max) then
         begin
         ScrollBar4.Position:=sh;
         ScrollBar3.Position:=sb;
         end
      else if (sh<=ScrollBar4.Max) and (sb>ScrollBar3.Max) then
         begin
         ScrollBar4.Position:=ScrollBar4.Position+(ScrollBar3.Max-ScrollBar3.Position);
         ScrollBar3.Position:=ScrollBar3.Max;
         end
      else if (sh>ScrollBar4.Max) and (sb<=ScrollBar3.Max) then
         begin
         ScrollBar3.Position:=ScrollBar3.Position+(ScrollBar4.Max-ScrollBar4.Position);
         ScrollBar4.Position:=ScrollBar4.Max;
         end;
      end
   else
      begin
      sh:=ScrollBar4.Position-ScrollBar4.LargeChange;
      sb:=ScrollBar3.Position-ScrollBar3.LargeChange;
      if (sh>=ScrollBar4.min) and (sb>=ScrollBar3.min) then
         begin
         ScrollBar4.Position:=sh;
         ScrollBar3.Position:=sb;
         end
      else if (sh<ScrollBar4.min) and (sb>=ScrollBar3.min) then
         begin
         ScrollBar3.Position:=ScrollBar3.Position-(ScrollBar4.Position-ScrollBar4.min);
         ScrollBar4.Position:=ScrollBar4.min;
         end
      else if (sh>=ScrollBar4.min) and (sb<ScrollBar3.min) then
         begin
         ScrollBar4.Position:=ScrollBar4.Position-(ScrollBar3.Position-ScrollBar3.min);
         ScrollBar3.Position:=ScrollBar3.min;
         end;
      end;
   Edit3.text:=IntToStr(ScrollBar4.Position);
   Edit4.text:=IntToStr(ScrollBar3.Position);
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.Button10Click(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
      begin
      sh:=ScrollBar4.Position+ScrollBar4.SmallChange;
      sb:=ScrollBar3.Position+ScrollBar3.SmallChange;
      if (sh<=ScrollBar4.Max) and (sb<=ScrollBar3.Max) then
         begin
         ScrollBar4.Position:=sh;
         ScrollBar3.Position:=sb;
         end
      else if (sh<=ScrollBar4.Max) and (sb>ScrollBar3.Max) then
         begin
         ScrollBar4.Position:=ScrollBar4.Position+(ScrollBar3.Max-ScrollBar3.Position);
         ScrollBar3.Position:=ScrollBar3.Max;
         end
      else if (sh>ScrollBar4.Max) and (sb<=ScrollBar3.Max) then
         begin
         ScrollBar3.Position:=ScrollBar3.Position+(ScrollBar4.Max-ScrollBar4.Position);
         ScrollBar4.Position:=ScrollBar4.Max;
         end;
      end
   else
      begin
      sh:=ScrollBar4.Position-ScrollBar4.SmallChange;
      sb:=ScrollBar3.Position-ScrollBar3.SmallChange;
      if (sh>=ScrollBar4.min) and (sb>=ScrollBar3.min) then
         begin
         ScrollBar4.Position:=sh;
         ScrollBar3.Position:=sb;
         end
      else if (sh<ScrollBar4.min) and (sb>=ScrollBar3.min) then
         begin
         ScrollBar3.Position:=ScrollBar3.Position-(ScrollBar4.Position-ScrollBar4.min);
         ScrollBar4.Position:=ScrollBar4.min;
         end
      else if (ScrollBar4.Position-ScrollBar4.SmallChange>=ScrollBar4.min) and
         (ScrollBar3.Position-ScrollBar3.SmallChange<ScrollBar3.min) then
         begin
         ScrollBar4.Position:=ScrollBar4.Position-(ScrollBar3.Position-ScrollBar3.min);
         ScrollBar3.Position:=ScrollBar3.min;
         end;
      end;
   Edit3.text:=IntToStr(ScrollBar4.Position);
   Edit4.text:=IntToStr(ScrollBar3.Position);
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.Button13Click(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
      begin
      sh:=ScrollBar4.Position-ScrollBar4.SmallChange;
      sb:=ScrollBar3.Position-ScrollBar3.SmallChange;
      if (sh>=ScrollBar4.min) and (sb>=ScrollBar3.min) then
         begin
         ScrollBar4.Position:=sh;
         ScrollBar3.Position:=sb;
         end
      else if (sh<ScrollBar4.min) and (sb>=ScrollBar3.min) then
         begin
         ScrollBar3.Position:=ScrollBar3.Position-(ScrollBar4.Position-ScrollBar4.min);
         ScrollBar4.Position:=ScrollBar4.min;
         end
      else if (ScrollBar4.Position-ScrollBar4.SmallChange>=ScrollBar4.min) and
         (ScrollBar3.Position-ScrollBar3.SmallChange<ScrollBar3.min) then
         begin
         ScrollBar4.Position:=ScrollBar4.Position-(ScrollBar3.Position-ScrollBar3.min);
         ScrollBar3.Position:=ScrollBar3.min;
         end;
      end
   else
      begin
      sh:=ScrollBar4.Position+ScrollBar4.SmallChange;
      sb:=ScrollBar3.Position+ScrollBar3.SmallChange;
      if (sh<=ScrollBar4.Max) and (sb<=ScrollBar3.Max) then
         begin
         ScrollBar4.Position:=sh;
         ScrollBar3.Position:=sb;
         end
      else if (sh<=ScrollBar4.Max) and (sb>ScrollBar3.Max) then
         begin
         ScrollBar4.Position:=ScrollBar4.Position+(ScrollBar3.Max-ScrollBar3.Position);
         ScrollBar3.Position:=ScrollBar3.Max;
         end
      else if (sh>ScrollBar4.Max) and (sb<=ScrollBar3.Max) then
         begin
         ScrollBar3.Position:=ScrollBar3.Position+(ScrollBar4.Max-ScrollBar4.Position);
         ScrollBar4.Position:=ScrollBar4.Max;
         end;
      end;
   Edit3.text:=IntToStr(ScrollBar4.Position);
   Edit4.text:=IntToStr(ScrollBar3.Position);
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.outButton14Click(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
      begin
      sh:=ScrollBar4.Position-ScrollBar4.LargeChange;
      sb:=ScrollBar3.Position-ScrollBar3.LargeChange;
      if (sh>=ScrollBar4.min) and (sb>=ScrollBar3.min) then
         begin
         ScrollBar4.Position:=sh;
         ScrollBar3.Position:=sb;
         end
      else if (sh<ScrollBar4.min) and (sb>=ScrollBar3.min) then
         begin
         ScrollBar3.Position:=ScrollBar3.Position-(ScrollBar4.Position-ScrollBar4.min);
         ScrollBar4.Position:=ScrollBar4.min;
         end
      else if (sh>=ScrollBar4.min) and (sb<ScrollBar3.min) then
         begin
         ScrollBar4.Position:=ScrollBar4.Position-(ScrollBar3.Position-ScrollBar3.min);
         ScrollBar3.Position:=ScrollBar3.min;
         end;
      end
   else
      begin
      sh:=ScrollBar4.Position+ScrollBar4.LargeChange;
      sb:=ScrollBar3.Position+ScrollBar3.LargeChange;
      if (sh<=ScrollBar4.Max) and (sb<=ScrollBar3.Max) then
         begin
         ScrollBar4.Position:=sh;
         ScrollBar3.Position:=sb;
         end
      else if (sh<=ScrollBar4.Max) and (sb>ScrollBar3.Max) then
         begin
         ScrollBar4.Position:=ScrollBar4.Position+(ScrollBar3.Max-ScrollBar3.Position);
         ScrollBar3.Position:=ScrollBar3.Max;
         end
      else if (sh>ScrollBar4.Max) and (sb<=ScrollBar3.Max) then
         begin
         ScrollBar3.Position:=ScrollBar3.Position+(ScrollBar4.Max-ScrollBar4.Position);
         ScrollBar4.Position:=ScrollBar4.Max;
         end;
      end;
   Edit3.text:=IntToStr(ScrollBar4.Position);
   Edit4.text:=IntToStr(ScrollBar3.Position);
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.outButton11Click(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
      begin
      sb:=ScrollBar3.Position-ScrollBar3.LargeChange div 2;
      sh:=ScrollBar4.Position+ScrollBar4.LargeChange div 2;
      if (sb>=ScrollBar3.Min) and (sh<=ScrollBar4.Max) then
         begin
         ScrollBar4.Position:=sh;
         ScrollBar3.Position:=sb;
         end
      else if (sb<ScrollBar3.Min) and (sh<=ScrollBar4.Max) then
         begin
         ScrollBar4.Position:=ScrollBar4.Position+(ScrollBar3.Position-ScrollBar3.Min);
         ScrollBar3.Position:=ScrollBar3.Min;
         end
      else if (sb>=ScrollBar3.Min) and (sh>ScrollBar4.Max) then
         begin
         ScrollBar3.Position:=ScrollBar3.Position-(ScrollBar4.Max-ScrollBar4.Position);
         ScrollBar4.Position:=ScrollBar4.Max;
         end;
      end
   else
      begin
      sb:=ScrollBar3.Position+ScrollBar3.LargeChange div 2;
      sh:=ScrollBar4.Position-ScrollBar4.LargeChange div 2;
      if (sh>=ScrollBar4.Min) and (sb<=ScrollBar3.Max) then
         begin
         ScrollBar4.Position:=sh;
         ScrollBar3.Position:=sb;
         end
      else if (sh<ScrollBar4.Min) and (sb<=ScrollBar3.Max) then
         begin
         ScrollBar3.Position:=ScrollBar3.Position+(ScrollBar4.Position-ScrollBar4.Min);
         ScrollBar4.Position:=ScrollBar4.Min;
         end
      else if (sh>=ScrollBar4.Min) and (sb>ScrollBar3.Max) then
         begin
         ScrollBar4.Position:=ScrollBar4.Position-(ScrollBar3.Max-ScrollBar3.Position);
         ScrollBar3.Position:=ScrollBar3.Max;
         end;
      end;
   Edit3.text:=IntToStr(ScrollBar4.Position);
   Edit4.text:=IntToStr(ScrollBar3.Position);
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.Button12Click(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
      begin
      if ScrollBar3.SmallChange<>1 then
         sb:=ScrollBar3.Position-ScrollBar3.SmallChange div 2
      else
         sb:=ScrollBar3.Position-ScrollBar3.SmallChange;
      if ScrollBar4.SmallChange<>1 then
         sh:=ScrollBar4.Position+ScrollBar4.SmallChange div 2
      else
         sh:=ScrollBar4.Position+ScrollBar4.SmallChange;
      if (sb>=ScrollBar3.Min) and (sh<=ScrollBar4.Max) then
         begin
         ScrollBar4.Position:=sh;
         ScrollBar3.Position:=sb;
         end
      else if (sb<ScrollBar3.Min) and (sh<=ScrollBar4.Max) then
         begin
         ScrollBar4.Position:=ScrollBar4.Position+(ScrollBar3.Position-ScrollBar3.Min);
         ScrollBar3.Position:=ScrollBar3.Min;
         end
      else if (sb>=ScrollBar3.Min) and (sh>ScrollBar4.Max) then
         begin
         ScrollBar3.Position:=ScrollBar3.Position-(ScrollBar4.Max-ScrollBar4.Position);
         ScrollBar4.Position:=ScrollBar4.Max;
         end;
      end
   else
      begin
      if ScrollBar3.SmallChange<>1 then
         sb:=ScrollBar3.Position+ScrollBar3.SmallChange div 2
      else
         sb:=ScrollBar3.Position+ScrollBar3.SmallChange;
      if ScrollBar4.SmallChange<>1 then
         sh:=ScrollBar4.Position-ScrollBar4.SmallChange div 2
      else
         sh:=ScrollBar4.Position-ScrollBar4.SmallChange;
      if (sh>=ScrollBar3.Min) and (sb<=ScrollBar4.Max) then
         begin
         ScrollBar4.Position:=sh;
         ScrollBar3.Position:=sb;
         end
      else if (sh<ScrollBar4.Min) and (sb<=ScrollBar3.Max) then
         begin
         ScrollBar3.Position:=ScrollBar3.Position+(ScrollBar4.Position-ScrollBar4.Min);
         ScrollBar4.Position:=ScrollBar4.Min;
         end
      else if (sh>=ScrollBar4.Min) and (sb>ScrollBar3.Max) then
         begin
         ScrollBar4.Position:=ScrollBar4.Position-(ScrollBar3.Max-ScrollBar3.Position);
         ScrollBar3.Position:=ScrollBar3.Max;
         end;
      end;
   Edit3.text:=IntToStr(ScrollBar4.Position);
   Edit4.text:=IntToStr(ScrollBar3.Position);
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.Button16Click(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
      begin
      if ScrollBar4.SmallChange<>1 then
         sh:=ScrollBar4.Position-ScrollBar4.SmallChange div 2
      else
         sh:=ScrollBar4.Position-ScrollBar4.SmallChange;
      if ScrollBar3.SmallChange<>1 then
         sb:=ScrollBar3.Position+ScrollBar3.SmallChange div 2
      else
         sb:=ScrollBar3.Position+ScrollBar3.SmallChange;
      if sh>sb then
         begin
         ScrollBar4.Position:=sh;
         ScrollBar3.Position:=sb;
         end;
      end
   else
      begin
      if ScrollBar4.SmallChange<>1 then
         sh:=ScrollBar4.Position+ScrollBar4.SmallChange div 2
      else
         sh:=ScrollBar4.Position+ScrollBar4.SmallChange;
      if ScrollBar3.SmallChange<>1 then
         sb:=ScrollBar3.Position-ScrollBar3.SmallChange div 2
      else
         sb:=ScrollBar3.Position-ScrollBar3.SmallChange;
      if sb>sh then
         begin
         ScrollBar4.Position:=sh;
         ScrollBar3.Position:=sb;
         end;
      end;
   Edit3.text:=IntToStr(ScrollBar4.Position);
   Edit4.text:=IntToStr(ScrollBar3.Position);
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.outButton15Click(Sender: TObject);
var
sh,sb:longint;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   if the_form.ImgInfos.Min[1]<the_form.ImgInfos.Max[1] then
      begin
      sh:=ScrollBar4.Position-ScrollBar4.LargeChange div 2;
      sb:=ScrollBar3.Position+ScrollBar3.LargeChange div 2;
      if sh>sb then
         begin
         ScrollBar4.Position:=sh;
         ScrollBar3.Position:=sb;
         end;
      end
   else
      begin
      sh:=ScrollBar4.Position+ScrollBar4.LargeChange div 2;
      sb:=ScrollBar3.Position-ScrollBar3.LargeChange div 2;
      if sb>sh then
         begin
         ScrollBar4.Position:=sh;
         ScrollBar3.Position:=sb;
         end;
      end;
   Edit3.text:=IntToStr(ScrollBar4.Position);
   Edit4.text:=IntToStr(ScrollBar3.Position);
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.SpeedButton4Click(Sender: TObject);
var
d:Double;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   d:=the_form.ImgInfos.Max[2];
   the_form.ImgInfos.Max[2]:=the_form.ImgInfos.Min[2];
   the_form.ImgInfos.Min[2]:=d;
   ScrollBar1.Position:=Round(the_form.ImgInfos.Min[2]);
   ScrollBar1.Refresh;
   Edit2.Text:=IntToStr(Round(the_form.ImgInfos.Min[2]));
   ScrollBar2.Position:=Round(the_form.ImgInfos.Max[2]);
   ScrollBar2.Refresh;
   Edit1.Text:=IntToStr(Round(the_form.ImgInfos.Max[2]));
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.SpeedButton7Click(Sender: TObject);
var
d:Double;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   d:=the_form.ImgInfos.Max[3];
   the_form.ImgInfos.Max[3]:=the_form.ImgInfos.Min[3];
   the_form.ImgInfos.Min[3]:=d;
   ScrollBar3.Position:=Round(the_form.ImgInfos.Min[3]);
   ScrollBar3.Refresh;
   Edit4.Text:=IntToStr(Round(the_form.ImgInfos.Min[3]));
   ScrollBar4.Position:=Round(the_form.ImgInfos.Max[3]);
   ScrollBar4.Refresh;
   Edit3.Text:=IntToStr(Round(the_form.ImgInfos.Max[3]));
   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.SpeedButton5Click(Sender: TObject);
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   the_form.VisuAutoEtoilesPlan(2);
   end;
end;

procedure Tpop_seuils_color.SpeedButton8Click(Sender: TObject);
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   the_form.VisuAutoEtoilesPlan(3);
   end;
end;

procedure Tpop_seuils_color.SpeedButton6Click(Sender: TObject);
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   the_form.VisuAutoPlanetesPlan(2);
   end;
end;

procedure Tpop_seuils_color.SpeedButton9Click(Sender: TObject);
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   the_form.VisuAutoPlanetesPlan(3);
   end;
end;

procedure Tpop_seuils_color.Button17Click(Sender: TObject);
begin
Close;
end;

procedure Tpop_seuils_color.SpeedButton10Click(Sender: TObject);
var
d:Double;
i:Integer;
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   for i:=1 to 3 do
      begin
      d:=the_form.ImgInfos.Max[i];
      the_form.ImgInfos.Max[i]:=the_form.ImgInfos.Min[i];
      the_form.ImgInfos.Min[i]:=d;
      end;

   ScrollBarsb.Position:=Round(the_form.ImgInfos.Min[1]);
   ScrollBarsb.Refresh;
   Editsb.Text:=IntToStr(Round(the_form.ImgInfos.Min[1]));
   ScrollBarsh.Position:=Round(the_form.ImgInfos.Max[1]);
   ScrollBarsh.Refresh;
   Editsh.Text:=IntToStr(Round(the_form.ImgInfos.Max[1]));

   ScrollBar1.Position:=Round(the_form.ImgInfos.Min[2]);
   ScrollBar1.Refresh;
   Edit2.Text:=IntToStr(Round(the_form.ImgInfos.Min[2]));
   ScrollBar2.Position:=Round(the_form.ImgInfos.Max[2]);
   ScrollBar2.Refresh;
   Edit1.Text:=IntToStr(Round(the_form.ImgInfos.Max[2]));

   ScrollBar3.Position:=Round(the_form.ImgInfos.Min[3]);
   ScrollBar3.Refresh;
   Edit4.Text:=IntToStr(Round(the_form.ImgInfos.Min[3]));
   ScrollBar4.Position:=Round(the_form.ImgInfos.Max[3]);
   ScrollBar4.Refresh;
   Edit3.Text:=IntToStr(Round(the_form.ImgInfos.Max[3]));

   ChangeImg;
   end;
end;

procedure Tpop_seuils_color.SpeedButton11Click(Sender: TObject);
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   the_form.AjusteFenetre;
   the_form.VisuAutoEtoiles;
   end;
end;

procedure Tpop_seuils_color.SpeedButton12Click(Sender: TObject);
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   the_form.VisuAutoPlanetes;
   end;
end;

procedure Tpop_seuils_color.SpeedButton13Click(Sender: TObject);
begin
if pop_main.LastChild is Tpop_Image then
   begin
   the_form:=pop_main.LastChild as Tpop_Image;
   the_form.VisuAutoMinMax;
   end;
end;

procedure Tpop_seuils_color.FormShow(Sender: TObject);
begin
Left:=Screen.Width-Width;
UpDateLang(Self);
end;

end.
