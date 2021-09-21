unit pu_edit_text;

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
  Tpop_edit_text = class(TForm)
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    Quitter: TButton;
    SaveDialog1: TSaveDialog;
    procedure FormResize(Sender: TObject);
    procedure QuitterClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    Extension:string; // Pour changer l'extension par defaut à l'enregistrement du fichier
  end;

var
  pop_edit_text: Tpop_edit_text;

implementation

{$R *.DFM}

uses pu_main,
     u_lang,
     u_class;

procedure Tpop_edit_text.FormResize(Sender: TObject);
begin
Memo1.Width:=ClientWidth-7;
Memo1.Height:=ClientHeight-40;
Quitter.Left:=(ClientWidth-Quitter.Width) div 2;
Quitter.Top:=ClientHeight-30;
BitBtn1.Top:=ClientHeight-30;
end;

procedure Tpop_edit_text.QuitterClick(Sender: TObject);
begin
Config.BuidingCosmeticFile:=False;
Close;
end;

procedure Tpop_edit_text.BitBtn1Click(Sender: TObject);
var
   Name:string;
begin
SaveDialog1.FileName:=lang('Cosmetics');
SaveDialog1.InitialDir:=config.RepImages;
if SaveDialog1.Execute then
   begin
   Name:=SaveDialog1.FileName;
   if UpperCase(ExtractFileExt(Name))<>UpperCase(Extension) then Name:=Name+Extension; //nolang
   Memo1.Lines.SaveToFile(Name);
   end;
end;

procedure Tpop_edit_text.FormCreate(Sender: TObject);
begin
SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
end;

procedure Tpop_edit_text.FormShow(Sender: TObject);
begin
UpDateLang(Self);
if TraductionEnCours then Caption:='';
end;

end.
