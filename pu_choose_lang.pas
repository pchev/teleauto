unit pu_choose_lang;

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
  StdCtrls, Buttons;

type
  Tpop_choose_lang = class(TForm)
    Label1: TLabel;
    ListBox1: TListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CacheFrancais;
  end;

var
  pop_choose_lang: Tpop_choose_lang;

implementation

{$R *.DFM}

uses pu_main,
     pu_conf,
     u_lang,
     u_general;

procedure Tpop_choose_lang.FormCreate(Sender: TObject);
var
 	sr:TSearchRec;
   Path:string;
begin
Path:=ExtractFilePath(Application.ExeName);

ListBox1.Items.Add('Francais');                                    //nolang

if FindFirst(Path+'\*.lng',faAnyFile,sr)=0 then             //nolang
   repeat
 	if (sr.name<>'Model.lng') and (sr.name<>'Check.lng') then  //nolang
      ListBox1.Items.Add(GetNomGenerique(sr.name));                //nolang
   until FindNext(sr)<>0;

end;

procedure Tpop_choose_lang.CacheFrancais;
begin
ListBox1.Items.Delete(0);                                          //nolang
end;

procedure Tpop_choose_lang.BitBtn2Click(Sender: TObject);
begin
Exit;
end;

procedure Tpop_choose_lang.BitBtn1Click(Sender: TObject);
begin
Exit;
end;

procedure Tpop_choose_lang.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

end.
