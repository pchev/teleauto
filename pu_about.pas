unit pu_about;

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
  StdCtrls, Buttons, ExtCtrls, jpeg;

type
  Tpop_about = class(TForm)
    outLabel6: TLabel;
    outLabel24: TLabel;
    outLabel7: TLabel;
    btn_close: TBitBtn;
    outlabel_version: TLabel;
    Image1: TImage;
    outLabel1: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure btn_closeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pop_about: Tpop_about;

implementation

uses u_constants,
     u_lang;

{$R *.DFM}

procedure Tpop_about.btn_closeClick(Sender: TObject);
begin
     close;
end;

procedure Tpop_about.FormCreate(Sender: TObject);
begin
     outlabel_version.caption:=VersionTeleAuto;
     outlabel_version.Width:=ClientWidth;
     outlabel_version.Alignment:=taCenter;
end;



procedure Tpop_about.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

end.
