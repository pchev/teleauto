unit pu_select_img;

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
  StdCtrls, Buttons, ExtCtrls, pu_image;

type
  Tpop_select_img = class(TForm)
    ListBox: TListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
    Image1: TImage;
    LabelImgCourante: TLabel;
    LabelQuestion: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    image_selectionnee:tpop_image;
    NotSameSize:Boolean;
    NotSameNbOfPlane:Boolean;
    NotSameType:Boolean;    
  end;

implementation

uses u_general,
     pu_main,
     u_visu,
     u_lang;

{$R *.DFM}

procedure Tpop_select_img.FormActivate(Sender: TObject);
var
   j:integer;
   ImageChoisie:Boolean;
begin
ListBox.Clear;

for j:=0 to pop_main.MDIChildCount-1 do
   begin
   ImageChoisie:=True;
   if (pop_main.MDIChilDren[j]=pop_main.LastChild) then ImageChoisie:=False;

   if not NotSameSize and
      ((pop_main.MDIChilDren[j] as tpop_image).ImgInfos.Sx<>(pop_main.LastChild as tpop_image).ImgInfos.Sx) and
      ((pop_main.MDIChilDren[j] as tpop_image).ImgInfos.Sy<>(pop_main.LastChild as tpop_image).ImgInfos.Sy) then
         ImageChoisie:=False;

   if not NotSameNbOfPlane and
      ((pop_main.MDIChilDren[j] as tpop_image).ImgInfos.NbPlans<>(pop_main.LastChild as tpop_image).ImgInfos.NbPlans) then
         ImageChoisie:=False;

   if ImageChoisie then ListBox.Items.Add(pop_main.MDIChilDren[j].Caption)

   end;

{if NotSameSize then
   begin
   for j:=0 to pop_main.MDIChildCount-1 do
      if (pop_main.MDIChilDren[j]<>pop_main.LastChild) and
         ((pop_main.MDIChilDren[j] as tpop_image).ImgInfos.TypeData=(pop_main.LastChild as tpop_image).ImgInfos.TypeData) and
         ((pop_main.MDIChilDren[j] as tpop_image).ImgInfos.TypeComplexe=(pop_main.LastChild as tpop_image).ImgInfos.TypeComplexe) and
         ((pop_main.MDIChilDren[j] as tpop_image).ImgInfos.NbPlans=(pop_main.LastChild as tpop_image).ImgInfos.NbPlans) then
            ListBox.Items.Add(pop_main.MDIChilDren[j].Caption);
   end
else if NotSameNbOfPlane then
   begin
   for j:=0 to pop_main.MDIChildCount-1 do
      if (pop_main.MDIChilDren[j]<>pop_main.LastChild) and
         ((pop_main.MDIChilDren[j] as tpop_image).ImgInfos.Sx=(pop_main.LastChild as tpop_image).ImgInfos.Sx) and
         ((pop_main.MDIChilDren[j] as tpop_image).ImgInfos.Sy=(pop_main.LastChild as tpop_image).ImgInfos.Sy) and
         ((pop_main.MDIChilDren[j] as tpop_image).ImgInfos.TypeData=(pop_main.LastChild as tpop_image).ImgInfos.TypeData) and
         ((pop_main.MDIChilDren[j] as tpop_image).ImgInfos.TypeComplexe=(pop_main.LastChild as tpop_image).ImgInfos.TypeComplexe) then
            ListBox.Items.Add(pop_main.MDIChilDren[j].Caption)
   end
else
   begin
   for j:=0 to pop_main.MDIChildCount-1 do
      if (pop_main.MDIChilDren[j]<>pop_main.LastChild) and
         ((pop_main.MDIChilDren[j] as tpop_image).ImgInfos.Sx=(pop_main.LastChild as tpop_image).ImgInfos.Sx) and
         ((pop_main.MDIChilDren[j] as tpop_image).ImgInfos.Sy=(pop_main.LastChild as tpop_image).ImgInfos.Sy) and
         ((pop_main.MDIChilDren[j] as tpop_image).ImgInfos.TypeData=(pop_main.LastChild as tpop_image).ImgInfos.TypeData) and
         ((pop_main.MDIChilDren[j] as tpop_image).ImgInfos.TypeComplexe=(pop_main.LastChild as tpop_image).ImgInfos.TypeComplexe) and
         ((pop_main.MDIChilDren[j] as tpop_image).ImgInfos.NbPlans=(pop_main.LastChild as tpop_image).ImgInfos.NbPlans) then
            ListBox.Items.Add(pop_main.MDIChilDren[j].Caption)
   end;}

if ListBox.Items.Count>0 then
   begin
   ListBox.ItemIndex:=0;
   ListBoxClick(Sender);
   end;

end;

procedure Tpop_select_img.ListBoxClick(Sender: TObject);
var
i,j,x,y,x1,y1:integer;
Contract:Extended;
Image:Tpop_image;
begin
for i:=0 to ListBox.Items.Count-1 do
   if (ListBox.Selected[i]) and (ListBox.Items[i]<>'') then
      begin
      for j:=0 to pop_main.MDIChildCount do
         if pop_main.MDIChildren[j].Caption=ListBox.Items[i] then
            begin
            Image:=(pop_main.MDIChildren[j] as tpop_image);
            x:=Image.img_box.Picture.Width;
            y:=Image.img_box.Picture.Height;
            Contract:=Contracte(x,y,Bevel1.Width-2,Bevel1.Height-2,x1,y1);
            Image1.Width:=x1;
            Image1.Height:=y1;
//            Image1.Picture.Assign((pop_main.MDIChildren[j] as tpop_image).img_box.Picture);
            Image1.Picture.Bitmap.Handle:=VisuImgAPI(Image.DataInt,Image.DataDouble,Image.ImgInfos,
               1,1,1,Image.ImgInfos.Sx,Image.ImgInfos.Sy,Image.ImgInfos.Sx,Image.ImgInfos.Sy);
            image_selectionnee:=Image;
            end;
      end;
end;

procedure Tpop_select_img.ListBoxDblClick(Sender: TObject);
var
j:Integer;
NomSelected:string;
begin
for j:=0 to ListBox.Items.Count-1 do
   if ListBox.Selected[j] then NomSelected:=ListBox.Items[j];

with pop_main do
   for j:=0 to MDIChildCount do
      if (MDIChilDren[j]<>LastChild) and (NomSelected=MDIChilDren[j].Caption)
         then image_selectionnee:=MDIChilDren[j] as tpop_image;

ModalResult:=mrOk;
end;

procedure Tpop_select_img.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

procedure Tpop_select_img.FormCreate(Sender: TObject);
begin
NotSameSize:=False;
NotSameNbOfPlane:=False;
end;

end.
