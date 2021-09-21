unit pu_filtre;

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
  StdCtrls, Spin, Buttons, Editnbre, u_class, u_general, FileCtrl;

type
  TTabNbre=array[1..999] of NbreEdit;
  PTabNbre=^TTabNbre;

  Tpop_filtre = class(TForm)
    ScrollBox: TScrollBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    FileListBox1: TFileListBox;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpinEdit1Change(Sender: TObject);
    procedure FileListBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FileListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    TabNbre:PTabNbre;
  public
    { Public declarations }
    Larg:Integer;
    procedure Affiche;
    procedure Cache;
    procedure GetFiltre(var ImgDouble:PImgDouble;var Largeur:Integer);
  end;

implementation

{$R *.DFM}

uses pu_image,
     u_lang;

procedure Tpop_filtre.GetFiltre(var ImgDouble:PImgDouble;var Largeur:Integer);
var
i,j,Numero:Integer;
begin
Getmem(ImgDouble,Larg*4);
for j:=1 to Larg do Getmem(ImgDouble^[j],Larg*8);

Largeur:=Larg;
for j:=1 to Larg do
   for i:=1 to Larg do
      begin
      Numero:=(j-1)*Larg+i;
      ImgDouble^[j]^[i]:=MyStrToFloat(TabNbre^[Numero].Text);
      end;
end;

procedure Tpop_filtre.Affiche;
var
i,j,Numero:Integer;
begin
Getmem(TabNbre,SizeOf(NbreEdit)*Larg*Larg);
for j:=1 to Larg do
   for i:=1 to Larg do
      begin
      Numero:=(j-1)*Larg+i;
      TabNbre^[Numero]:=NbreEdit.Create(Self);
      TabNbre^[Numero].Text:='1';
      TabNbre^[Numero].Width:=50;
      TabNbre^[Numero].Height:=24;
      TabNbre^[Numero].ValMax:=999;
      TabNbre^[Numero].ValMin:=-999;
      TabNbre^[Numero].Left:=(i-1)*50;
      TabNbre^[Numero].Top:=(j-1)*23;
      if (i=Larg div 2+1) and (j=Larg div 2+1) then TabNbre^[Numero].Color:=clAqua;
      Scrollbox.InsertControl(TabNbre^[Numero]);
      end;
end;

procedure Tpop_filtre.Cache;
var
i,j,Numero:Integer;
begin
for i:=1 to Larg do
   for j:=1 to Larg do
      begin
      Numero:=(j-1)*Larg+i;
      Scrollbox.RemoveControl(TabNbre^[Numero]);
      TabNbre^[Numero].Free;
      end;
Freemem(TabNbre,SizeOf(NbreEdit)*Larg*Larg);
end;

procedure Tpop_filtre.FormCreate(Sender: TObject);
begin
Larg:=3;
Affiche;
FileListBox1.Directory:=ExtractFilePath(Application.Exename)+'\filters'; //nolang
end;

procedure Tpop_filtre.BitBtn2Click(Sender: TObject);
begin
Close;
end;

procedure Tpop_filtre.BitBtn1Click(Sender: TObject);
begin
Close;
ModalResult:=1;
end;

procedure Tpop_filtre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caHide;
end;

procedure Tpop_filtre.SpinEdit1Change(Sender: TObject);
begin
if Larg<>SpinEdit1.Value then
   begin
   Cache;
   Larg:=SpinEdit1.Value;
   Affiche;
   end;
end;

procedure Tpop_filtre.FileListBox1Click(Sender: TObject);
var
F:TextFile;
Liste:TStringList;
Line:String;
i,j,Numero,PosEsp:Integer;
begin
Liste:=TStringList.Create;

try
// Lecture du fichier
AssignFile(F,FileListBox1.FileName);

try

Reset(F);

while not(Eof(F)) do
   begin
   Readln(F,Line);
   Liste.Add(Line);
   end;

finally
CloseFile(F);
end;

Cache;
Larg:=Liste.Count-1;
//SpinEdit1.Value:=Larg;
Affiche;

for j:=1 to Larg do
   begin
   Line:=Trim(Liste[j]);
   for i:=1 to Larg do
      begin
      if i<>Larg then PosEsp:=Pos(' ',Line) else PosEsp:=Length(Line)+1;
      Numero:=(j-1)*Larg+i;
      TabNbre^[Numero].Text:=Trim(Copy(Line,1,PosEsp-1));
      Delete(Line,1,PosEsp);
      end;
   end;

finally
Liste.free;
end;
end;

procedure Tpop_filtre.Button1Click(Sender: TObject);
var
Name,Line:string;
PosEsp,i,j,Numero:Integer;
F:TextFile;
begin
Name:=Edit1.Text;
if ExtractFileExt(Name)<>'' then
   begin
   PosEsp:=Pos('.',Name);
   Name:=Copy(Name,1,PosEsp-1);
   end;
Name:=Name+'.conv'; //nolang
// Enregistrement du fichier
AssignFile(F,Name);

try

Rewrite(F);

Line:='Insert your comment here'; //nolang
Writeln(F,Line);
for j:=1 to Larg do
   begin
   for i:=1 to Larg do
      begin
      Numero:=(j-1)*Larg+i;
      Write(F,TabNbre^[Numero].Text+' ');
      end;
   if j<>Larg then Writeln(F);
   end;

finally
CloseFile(F);
FileListbox1.Update;
end;
end;

procedure Tpop_filtre.FileListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
i:Integer;
Resultat:Word;
begin
if Key=46 then
   begin
   with FileListBox1 do
      for i:=0 to Items.Count-1 do
         if Selected[i] then
            begin
            Resultat:=MessageDlg(lang('Supprimer ')+#13+Items[i]
               +' ?',mtConfirmation,[mbYes,mbNo],0); //nolang
            if Resultat=mrYes then DeleteFile(Directory+'\'+Items[i]);
            end;
   FileListBox1.Update;
   end;
end;

procedure Tpop_filtre.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

end.
