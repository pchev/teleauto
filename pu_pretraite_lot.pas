unit pu_pretraite_lot;

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
  StdCtrls, Buttons, ExtCtrls;

type
  Tpop_pretraite_lot = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit4: TEdit;
    Edit3: TEdit;
    Edit2: TEdit;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    procedure BitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.DFM}

uses pu_main,
     u_lang,
     u_general;

procedure Tpop_pretraite_lot.BitBtn2Click(Sender: TObject);
begin
Close;
end;

procedure Tpop_pretraite_lot.Button1Click(Sender: TObject);
begin
OpenDialog1.InitialDir:=Config.RepImagesAcq;
OpenDialog1.Filter:=lang('Fichiers Pic Cpa Fits|*.pic;*.cpa;*.fit*;*.fts');
OpenDialog1.Title:=lang('Choisir l''Offset');
if OpenDialog1.Execute then
   begin
//   Edit1.Text:=GetNomFichier(OpenDialog1.FileName);
   Edit1.Text:=ExtractFileName(OpenDialog1.FileName);
   Config.RepImagesAcq:=ExtractFilePath(OpenDialog1.Filename);
   end;
end;

procedure Tpop_pretraite_lot.FormShow(Sender: TObject);
begin
UpdateLang(Self);
end;

procedure Tpop_pretraite_lot.Button2Click(Sender: TObject);
begin
OpenDialog1.InitialDir:=Config.RepImagesAcq;
OpenDialog1.Filter:=lang('Fichiers Pic Cpa Fits|*.pic;*.cpa;*.fit*;*.fts');
OpenDialog1.Title:=lang('Choisir le noir');
if OpenDialog1.Execute then
   begin
//   Edit2.Text:=GetNomFichier(OpenDialog1.FileName);
   Edit2.Text:=ExtractFileName(OpenDialog1.FileName);
   Config.RepImagesAcq:=ExtractFilePath(OpenDialog1.Filename);   
   end;
end;

procedure Tpop_pretraite_lot.Button3Click(Sender: TObject);
begin
OpenDialog1.InitialDir:=Config.RepImagesAcq;
OpenDialog1.Filter:=lang('Fichiers Pic Cpa Fits|*.pic;*.cpa;*.fit*;*.fts');
OpenDialog1.Title:=lang('Choisir le flat');
if OpenDialog1.Execute then
   begin
//   Edit3.Text:=GetNomFichier(OpenDialog1.FileName);
   Edit3.Text:=ExtractFileName(OpenDialog1.FileName);
   Config.RepImagesAcq:=ExtractFilePath(OpenDialog1.Filename);
   end;
end;

procedure Tpop_pretraite_lot.Button4Click(Sender: TObject);
begin
OpenDialog1.InitialDir:=Config.RepImagesAcq;
OpenDialog1.Filter:=lang('Fichier cosmétique (*.cos)|*.cos');
OpenDialog1.Title:=lang('Choisir le cosmétique');
if OpenDialog1.Execute then
   begin
//   Edit4.Text:=GetNomFichier(OpenDialog1.FileName);
   Edit4.Text:=ExtractFileName(OpenDialog1.FileName);
   Config.RepImagesAcq:=ExtractFilePath(OpenDialog1.Filename);   
   end;
end;

end.



