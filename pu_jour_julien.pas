unit pu_jour_julien;

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
  Buttons, StdCtrls, ComCtrls;

type
  Tpop_jour_julien = class(TForm)
    GroupBox1: TGroupBox;
    Label4: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label3: TLabel;
    DateTimePicker2: TDateTimePicker;
    GroupBox2: TGroupBox;
    julian_day: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Button1: TButton;
    btn_close: TBitBtn;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btn_closeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses u_meca,
     u_general,
     u_lang,
     u_hour_servers;

{$R *.DFM}

procedure Tpop_jour_julien.SpeedButton1Click(Sender: TObject);
begin
     julian_day.Text:=FloatToStr(HeureToJourJulien(Trunc(DateTimePicker1.Date)+Frac(DateTimePicker2.Time)));
end;

procedure Tpop_jour_julien.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure Tpop_jour_julien.SpeedButton2Click(Sender:TObject);
var
DateTime:TDateTime;
begin
DateTime:=JourJulienToHeure(MyStrToFloat(julian_Day.Text));
DateTimePicker1.Date:=Trunc(DateTime);
DateTimePicker2.Time:=Frac(DateTime);
end;

procedure Tpop_jour_julien.Button1Click(Sender: TObject);
var
   DateTime:TDateTime;
begin
DateTime:=GetHourDT;

DateTimePicker1.Date:=Trunc(DateTime);
DateTimePicker2.Time:=Frac(DateTime);
end;

procedure Tpop_jour_julien.btn_closeClick(Sender: TObject);
begin
Close;
end;

procedure Tpop_jour_julien.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

end.
