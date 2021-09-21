unit pu_image_index;

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
  StdCtrls, Buttons;

type
  Tpop_image_index = class(TForm)
    lb_images: TListBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure lb_imagesDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure addline(filename:string; flag:byte);
  end;

var
  pop_image_index: Tpop_image_index;

implementation

uses pu_image,
     u_file_io,
     u_lang;

{$R *.DFM}

procedure TPop_Image_index.addline(filename:string; flag:byte);
begin
if fileexists(filename) then
   begin
   lb_images.items.add(filename);
   if lb_images.Items.Count>10 then lb_images.TopIndex:=lb_images.Items.Count-10;
   end;
end;


procedure Tpop_image_index.SpeedButton1Click(Sender: TObject);
begin
lb_images.Items.Clear;
end;

procedure Tpop_image_index.SpeedButton2Click(Sender: TObject);
var
   j:integer;
begin
for j:=lb_images.items.count -1 downto 0 do
   begin
   if not fileexists(lb_images.items[j]) then
      begin
      lb_images.items.Delete(j);
      end;
   end;
end;



procedure Tpop_image_index.lb_imagesDblClick(Sender: TObject);
var i:integer;
pop_image:Tpop_image;
begin
    for i:=lb_images.items.count-1 downto 0 do
    begin
         if lb_images.selected[i] then
         begin
              begin
                   pop_image:=tpop_image.create(application);
                     try
                     pop_image.ReadImage(lb_images.items[i]);
                     except
                     on E: Exception do
                     begin
                          ShowMessage(E.Message);
                          pop_image.free;
                     end;
                     end;
                   end;
              end;
      end;
end;

procedure Tpop_image_index.FormShow(Sender: TObject);
begin
UpdateLang(Self);
end;

end.
