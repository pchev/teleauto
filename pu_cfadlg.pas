unit pu_cfadlg;

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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  Tpop_cfadlg = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    StaticText1: TStaticText;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
   cfaformat:byte;
  end;

var
  pop_cfadlg: Tpop_cfadlg;

implementation

{$R *.dfm}

const
 BGGR = 1;RGGB = 2;GRBG = 3;GBRG = 4;


procedure Tpop_cfadlg.SpeedButton1Click(Sender: TObject);
begin
 cfaformat:=grbg;
end;

procedure Tpop_cfadlg.SpeedButton2Click(Sender: TObject);
begin
 cfaformat:=bggr;
end;

procedure Tpop_cfadlg.SpeedButton3Click(Sender: TObject);
begin
 cfaformat:=gbrg;
end;

procedure Tpop_cfadlg.SpeedButton4Click(Sender: TObject);
begin
  cfaformat:=rggb;
end;

procedure Tpop_cfadlg.FormCreate(Sender: TObject);
begin
 cfaformat:=gbrg;
end;

procedure Tpop_cfadlg.FormShow(Sender: TObject);
begin
 cfaformat:=gbrg;
end;

end.
