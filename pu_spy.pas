unit pu_spy;

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
  StdCtrls, Buttons, ComCtrls;

type
  Tpop_spy = class(TForm)
    list_spy: TListBox;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
   pop_spy:Tpop_spy;

implementation

{$R *.DFM}

uses u_lang, pu_main;

procedure Tpop_spy.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

procedure Tpop_spy.Button1Click(Sender: TObject);
var
   F:TextFile;
begin
List_Spy.Clear;
//Photo_en_cours.Clear;
AssignFile(F,ExtractFilePath(Application.ExeName)+'Spy.log'); //nolang
try
Rewrite(F);
finally
CloseFile(F);
end;
end;

procedure Tpop_spy.Button2Click(Sender: TObject);
var
T:TextFile;
Name:String;
i:Integer;
begin
pop_main.SaveDialog.Filter:=lang('Fichiers log *.log|*.log');
if pop_main.SaveDialog.Execute then
   begin
   Name:=pop_main.SaveDialog.FileName;
   if UpperCase(ExtractFileExt(Name))<>'.LOG' then Name:=Name+'.log'; //nolang
   AssignFile(T,Name);
   Rewrite(T);
   try
   for i:=0 to List_Spy.Count-1 do
      Writeln(T,List_Spy.Items[i]);
   finally
   System.Close(T);
   end;
   end;
end;

end.
