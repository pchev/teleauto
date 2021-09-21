unit pu_calibrate_track;

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
  ExtCtrls, StdCtrls, Buttons;

type
  Tpop_calibrate_track = class(TForm)
    ListBox1: TListBox;
    BitBtn1: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Init:Boolean;
    TimeInit,XInit,Yinit,Xrms,Yrms,XCumul,YCumul:Double;
    NbPoints:Integer;
    procedure AddMessage(MyMessage:string);
  end;

 var
   pop_calibrate_track:Tpop_calibrate_track;

implementation

{$R *.DFM}

uses u_general,
     pu_main,
     u_lang,
     u_file_io, pu_map;

procedure Tpop_calibrate_track.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
pop_calibrate_track:=nil;
end;

procedure Tpop_calibrate_track.AddMessage(MyMessage:String);
const
   Max=1000;
var
   Nbre:integer;
begin
if ListBox1.Items.Count>Max then ListBox1.Items.Delete(0);
ListBox1.Items.Add(GetStrTimeBios+' '+MyMessage);

Nbre:=ListBox1.Height div ListBox1.ItemHeight;

if ListBox1.Items.Count<Nbre then ListBox1.TopIndex:=0
else ListBox1.TopIndex:=ListBox1.Items.Count-Nbre;

Update;
end;

procedure Tpop_calibrate_track.FormShow(Sender: TObject);
begin
Left:=Screen.Width-Width;
Top:=Screen.Height-Height;
UpDateLang(Self);
end;

procedure Tpop_calibrate_track.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure Tpop_calibrate_track.FormResize(Sender: TObject);
begin
ListBox1.Height:=ClientHeight-30;
ListBox1.Width:=ClientWidth-2;
BitBtn1.Top:=ClientHeight-26;
BitBtn1.Left:=(ClientWidth-BitBtn1.Width) div 2;
end;

end.
