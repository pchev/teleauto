unit pu_blink;

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
  ExtCtrls, pu_image, StdCtrls, Spin;

type
  Tpop_blink = class(TForm)
    Img_Box1: TImage;
    Timer1: TTimer;
    img_box2: TImage;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button3: TButton;
    Label4: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpinEdit2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Img:Boolean;
    Name1,Name2:string;
  end;

implementation

uses pu_main,
     u_lang;

{$R *.DFM}

procedure Tpop_blink.Timer1Timer(Sender: TObject);
begin
if Img then
   begin
//   Img_Box1.Visible:=True;
//   Img_Box2.Visible:=False;
   Img_Box1.BringToFront;
   Img:=False;
   Label3.Caption:=lang('Image 1 : ')+Name1;
   end
else
   begin
   Img_Box2.BringToFront;   
//   Img_Box2.Visible:=True;
//   Img_Box1.Visible:=False;
   Img:=True;
   Label3.Caption:=lang('Image 2 : ')+Name2;
   end
end;

procedure Tpop_blink.FormShow(Sender: TObject);
var
   XBorder,YBorder,YCaption:Integer;
   WidthMax,HeightMax:Integer;
begin
//img_box.Width:=Img1.Width;
//img_box.Height:=Img1.Height;

if img_box1.Width>img_box2.Width then WidthMax:=img_box1.Width else WidthMax:=img_box2.Width;
if img_box1.Height>img_box2.Height then
   begin
   HeightMax:=img_box1.Height+Panel1.Height;
   img_box1.Top:=HeightMax-img_box1.Height;
   img_box2.Top:=HeightMax-img_box2.Height;
   end
else
   begin
   HeightMax:=img_box2.Height+Panel1.Height;
   img_box1.Top:=HeightMax-img_box1.Height;
   img_box2.Top:=HeightMax-img_box2.Height;
   end;

img_box1.Stretch:=False;
img_box2.Stretch:=False;

XBorder:=GetSystemMetrics(SM_CXBORDER);
YBorder:=GetSystemMetrics(SM_CYBORDER);
YCaption:=GetSystemMetrics(SM_CYCAPTION);
WindowState:=wsNormal;
if (WidthMax>=Screen.Width) and
   (HeightMax>=Screen.Height) then
   begin
   Height:=Screen.Height;
   Width:=Screen.Width;
   Top:=0;
   Left:=0;
   end;
if (WidthMax<pop_main.ClientWidth) and
   (HeightMax<pop_main.ClientHeight) then
   begin
//   ClientHeight:=img_box.Picture.Height;
//   ClientWidth:=img_box.Picture.Width;
   Height:=HeightMax+2*YBorder+YCaption+7;
   Width:=WidthMax+2*XBorder+7;
   end;
if (WidthMax>=Screen.Width) and
   (HeightMax<Screen.Height) then
   begin
//   ClientHeight:=img_box.Picture.Height+16;
   Left:=0;
   Height:=HeightMax+2*YBorder+YCaption;
   Width:=Screen.Width
   end;
if (WidthMax<Screen.Width) and
   (HeightMax>=Screen.Height) then
   begin
//   ClientWidth:=img_box.Picture.Width+16;
   Top:=0;
   Height:=Screen.Height;
   Width:=img_box1.Width+2*XBorder;
   end;
Img_Box1.Show;
Img_Box2.Show;
Img_Box1.BringToFront;
UpDateLang(Self);
end;

procedure Tpop_blink.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//Img1.Free;
//Img2.Free;
Action:=caFree;
end;

procedure Tpop_blink.Button1Click(Sender: TObject);
begin
   Timer1.Enabled:=False;
   Img:=False;
   Img_Box1.Visible:=True;
   Img_Box2.Visible:=False;
   Label3.Caption:=lang('Image 1 : ')+Name1;
end;

procedure Tpop_blink.Button2Click(Sender: TObject);
begin
   Timer1.Enabled:=False;
   Img:=True;
   Img_Box1.Visible:=False;
   Img_Box2.Visible:=True;
   Label3.Caption:=lang('Image 2 : ')+Name2;
end;

procedure Tpop_blink.Button3Click(Sender: TObject);
begin
Timer1.Enabled:=True;
end;

procedure Tpop_blink.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   ImageNb:Integer;
begin
   ImageNb:=SpinEdit1.Value;

   if Key=VK_UP then
      begin
      case ImageNb of
         1:Img_Box1.Top:=Img_Box1.Top-1;
         2:Img_Box2.Top:=Img_Box2.Top-1;
         end;

      Key:=0;
      end;

   if Key=VK_DOWN then
      begin
      case ImageNb of
         1:Img_Box1.Top:=Img_Box1.Top+1;
         2:Img_Box2.Top:=Img_Box2.Top+1;
         end;

      Key:=0;
      end;

   if Key=VK_LEFT then
      begin
      case ImageNb of
         1:Img_Box1.Left:=Img_Box1.Left-1;
         2:Img_Box2.Left:=Img_Box2.Left-1;
         end;

      Key:=0;
      end;

   if Key=VK_RIGHT then
      begin
      case ImageNb of
         1:Img_Box1.Left:=Img_Box1.Left+1;
         2:Img_Box2.Left:=Img_Box2.Left+1;
         end;

      Key:=0;
      end;

end;

procedure Tpop_blink.SpinEdit2Change(Sender: TObject);
begin
   Timer1.Interval:=SpinEdit2.Value;
end;

end.
