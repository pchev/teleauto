unit pu_splash;

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
  Windows, Messages, jpeg, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  Tpop_splash = class(TForm)
    Image1: TImage;
    outmesg: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  outpop_splash:Tpop_splash;

implementation

{$R *.DFM}

uses u_constants,
     u_lang;

procedure Tpop_splash.FormCreate(Sender: TObject);
begin
outmesg.Caption:=VersionTeleAuto;
outmesg.Width:=ClientWidth;
outmesg.Alignment:=taCenter;
end;

procedure Tpop_splash.FormShow(Sender: TObject);
begin
//UpDateLang(Self); ne marche pas 
end;

end.
