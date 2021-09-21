unit pu_dessin;

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
  ExtCtrls;

type
  Tpop_dessin = class(TForm)
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  procedure SetSize(Sx,Sy:Integer);
  procedure AddPosition(Info:string;X,Y:Double;Dx,Dy,Rayon:Integer);
  procedure Efface;  
  end;

var
  pop_dessin: Tpop_dessin;

implementation

{$R *.DFM}

uses u_general,
     u_lang,
     pu_camera_suivi,
     pu_main;

procedure Tpop_dessin.SetSize(Sx,Sy:Integer);
var
   XBorder,YBorder,YCaption:Integer;
begin
   XBorder:=GetSystemMetrics(SM_CXBORDER);
   YBorder:=GetSystemMetrics(SM_CYBORDER);
   YCaption:=GetSystemMetrics(SM_CYCAPTION);
   WindowState:=wsNormal;
   Height:=Sy+2*YBorder+YCaption+6;
   Width:=Sx+2*XBorder+6;
end;

procedure Tpop_dessin.AddPosition(Info:string;X,Y:Double;Dx,Dy,Rayon:Integer);
begin
   Y:=Image1.Height-Y;
   Image1.Canvas.Pen.Color:=ClBlack;
   Image1.Canvas.Pen.Style:=PsSolid;
   Image1.Canvas.Pen.Mode:=pmCopy;
   Image1.Canvas.Brush.Style:=bsClear;

   Image1.Canvas.Ellipse(Round(X-Rayon),Round(Y-Rayon),Round(X+Rayon),Round(Y+Rayon));

   Image1.Canvas.Font.Name:='Arial'; //nolang
   Image1.Canvas.Font.Size:=9;
   Image1.Canvas.Font.Pitch:=fpFixed;
   Image1.Canvas.Font.Color:=clBlack;
   Image1.Canvas.Font.Style:=[fsBold];
   Image1.Canvas.TextOut(Round(X+DX),Round(Y+DY),Info);
   Image1.Update;
end;

procedure Tpop_dessin.Efface;
begin
Image1.Canvas.Pen.Mode:=pmWhite;
Image1.Canvas.Brush.Color:=clWhite;
Image1.Canvas.Brush.Style:=bsSolid;
Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
end;

procedure Tpop_dessin.FormShow(Sender: TObject);
begin
UpDateLang(Self);
Efface;
end;

procedure Tpop_dessin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if Config.KeepImage then
   begin
   if pop_camera_suivi.pop_image1<>nil then pop_camera_suivi.pop_image1.Close;
   if pop_camera_suivi.pop_image2<>nil then pop_camera_suivi.pop_image2.Close;
   if pop_camera_suivi.pop_image3<>nil then pop_camera_suivi.pop_image3.Close;
   if pop_camera_suivi.pop_image4<>nil then pop_camera_suivi.pop_image4.Close;
   if pop_camera_suivi.pop_image5<>nil then pop_camera_suivi.pop_image5.Close;
   if pop_camera_suivi.pop_image6<>nil then pop_camera_suivi.pop_image6.Close;
   if pop_camera_suivi.pop_image7<>nil then pop_camera_suivi.pop_image7.Close;
   end;
end;

end.
