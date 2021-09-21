unit pu_clock_monitor;

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
  ExtCtrls, ComCtrls, StdCtrls;

type
  Tpop_clock_monitor = class(TForm)
    Timer1: TTimer;
    Button1: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    Label3: TLabel;
    Button3: TButton;
    Button2: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure Affiche;    
  public
    { Déclarations publiques }
  end;

var
  pop_clock_monitor: Tpop_clock_monitor;
  pop_clock_monitor_affiche:Boolean=False;

implementation

{$R *.DFM}

uses pu_main,
     u_general,
     u_lang,
     u_hour_servers;

procedure Tpop_clock_monitor.Affiche;
var
   Hour,Min,Sec,MSec:Word;
   SHour,SMin,SSec:string;
begin
DecodeTime(Now-Config.PCMoinsTU/24,Hour,Min,Sec,MSec);
SHour:=IntToStr(Hour);
if Length(SHour)=1 then SHour:='0'+SHour;
SMin:=IntToStr(Min);
if Length(SMin)=1 then SMin:='0'+SMin;
SSec:=IntToStr(Sec);
if Length(SSec)=1 then SSec:='0'+SSec;
Panel1.Caption:=Shour+':'+SMin+':'+SSec;

DecodeTime(GetHourDT,Hour,Min,Sec,MSec);
SHour:=IntToStr(Hour);
if Length(SHour)=1 then SHour:='0'+SHour;
SMin:=IntToStr(Min);
if Length(SMin)=1 then SMin:='0'+SMin;
SSec:=IntToStr(Sec);
if Length(SSec)=1 then SSec:='0'+SSec;
Panel2.Caption:=Shour+':'+SMin+':'+SSec;
end;

procedure Tpop_clock_monitor.Timer1Timer(Sender: TObject);
begin
Affiche;
end;

procedure Tpop_clock_monitor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
pop_clock_monitor_affiche:=False;
Action:=caFree;
end;

procedure Tpop_clock_monitor.FormShow(Sender: TObject);
begin
UpDateLang(Self);
Left:=Screen.Width-Width;
Affiche
end;

procedure Tpop_clock_monitor.Button1Click(Sender: TObject);
begin
Close;
end;

procedure Tpop_clock_monitor.Button2Click(Sender: TObject);
begin
MajSystemTime(GetHourDT+Config.PCMoinsTU/24);
end;

procedure Tpop_clock_monitor.Button3Click(Sender: TObject);
begin
MajSystemTime(DateTimePicker1.DateTime+Config.PCMoinsTU/24);
end;

end.
