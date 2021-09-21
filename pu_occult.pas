unit pu_occult;

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
  StdCtrls, ExtCtrls, Buttons, Menus, Spin, IniFiles;

type
  Tpop_occult = class(TForm)
    Memo1: TMemo;
    SaveDialog1: TSaveDialog;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitEdit: TBitBtn;
    BitAcq: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitAcqClick(Sender: TObject);
    procedure BitEditClick(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Quitter1Click(Sender: TObject);
    procedure EnregistrerClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    Edit,Changed:Boolean;
  end;

var
  pop_occult: Tpop_occult;

implementation

uses u_lang,
     pu_main,
     u_hour_servers;

{$R *.DFM}

procedure Tpop_occult.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
Year,Month,Day,Hour,Min,Sec,MSec:Word;
SYear,SMonth,SDay,SHour,SMin,SSec,SMSec,Line:string;
begin
if not(Edit) and not(Shift=[ssAlt]) then
   begin
   Changed:=True;
   GetHour(Year,Month,Day,Hour,Min,Sec,MSec);

   if Month<10 then SMonth:='0'+IntToStr(Month) else SMonth:=IntToStr(Month);
   if Day<10 then SDay:='0'+IntToStr(Day) else SDay:=IntToStr(Day);
   SYear:=IntToStr(Year);

   if Hour<10 then SHour:='0'+IntToStr(Hour) else SHour:=IntToStr(Hour);
   if Min<10 then SMin:='0'+IntToStr(Min) else SMin:=IntToStr(Min);
   if Sec<10 then SSec:='0'+IntToStr(Sec) else SSec:=IntToStr(Sec);
   if MSec<10 then SMSec:='00'+IntToStr(MSec) //nolang
   else if MSec<100 then SMSec:='0'+IntToStr(MSec) else SMSec:=IntToStr(MSec);
                                 
   Line:=SDay+'/'+SMonth+'/'+SYear+' '+SHour+':'+Smin+':'+SSec+'.'+SMSec+lang(' TU');

   Memo1.Lines.Add(Line); //nolang
   Key:=0;
   end;
end;

procedure Tpop_occult.BitBtn2Click(Sender: TObject);
var
NameFile:String;
begin
if SaveDialog1.Execute then
   begin
   NameFile:=SaveDialog1.Filename;
   if ExtractFileExt(NameFile)='' then NameFile:=NameFile+'.txt'; //nolang
   Memo1.Lines.SaveToFile(NameFile);
   Changed:=False;
   end;
end;

procedure Tpop_occult.FormCreate(Sender: TObject);
begin
BitAcq.Visible:=False;
BitEdit.Visible:=True;
Label1.Visible:=False;
Label2.Visible:=True;
Edit:=False;
Memo1.ReadOnly:=True;
Changed:=False;
end;

procedure Tpop_occult.BitAcqClick(Sender: TObject);
begin
BitAcq.Visible:=False;
BitEdit.Visible:=True;
Label1.Visible:=False;
Label2.Visible:=True;
Edit:=False;
Memo1.ReadOnly:=True;
end;

procedure Tpop_occult.BitEditClick(Sender: TObject);
begin
BitAcq.Visible:=True;
BitEdit.Visible:=False;
Label1.Visible:=True;
Label2.Visible:=False;
Edit:=True;
Memo1.ReadOnly:=False;
Memo1.SetFocus;
end;


procedure Tpop_occult.Memo1Change(Sender: TObject);
begin
Changed:=True;
end;

procedure Tpop_occult.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
Changed:=True;
end;

procedure Tpop_occult.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
NameFile:String;
begin
CanClose:=True;
if Changed then
   begin
   if MessageDlg(lang('Le fichier à changé')+#13+lang('Voulez vous l''enregistrer ?'),mtWarning,[mbYes,mbNo],0)=mrYes then
      begin
      if SaveDialog1.Execute then
         begin
         NameFile:=SaveDialog1.Filename;
         if ExtractFileExt(NameFile)='' then NameFile:=NameFile+'.txt'; //nolang
         Memo1.Lines.SaveToFile(NameFile);
         end
      else CanClose:=False;
      end;
   end;
end;

procedure Tpop_occult.Quitter1Click(Sender: TObject);
begin
Close;
end;

procedure Tpop_occult.EnregistrerClick(Sender: TObject);
begin
BitBtn2Click(Sender);
end;

procedure Tpop_occult.FormShow(Sender: TObject);
begin
updatelang(self);
end;

end.
