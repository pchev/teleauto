unit pu_zoom;

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
  StdCtrls, Editnbre, ExtCtrls;

type
  Tpop_zoom = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    NbreEdit1: NbreEdit;
    NbreEdit2: NbreEdit;
    Label1: TLabel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure CheckBox2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses u_lang;

procedure Tpop_zoom.CheckBox2Click(Sender: TObject);
begin
if CheckBox2.Checked then NbreEdit2.Enabled:=False
else NbreEdit2.Enabled:=True;
end;

procedure Tpop_zoom.FormCreate(Sender: TObject);
begin
if CheckBox2.Checked then NbreEdit2.Enabled:=False
else NbreEdit2.Enabled:=True;
end;

procedure Tpop_zoom.Button1Click(Sender: TObject);
begin
if CheckBox2.Checked then NbreEdit2.Text:=NbreEdit1.Text;
end;

procedure Tpop_zoom.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

end.
