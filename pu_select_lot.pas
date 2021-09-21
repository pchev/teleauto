unit pu_select_lot;

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
  FileCtrl, StdCtrls, Buttons, Spin;

type
  Tpop_select_lot = class(TForm)
    ListBox: TListBox;
    FileListBox: TFileListBox;
    BitBtnAjout: TBitBtn;
    BitBtnSupp: TBitBtn;
    BitBtn1: TBitBtn;
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    FilterComboBox1: TFilterComboBox;
    EditRef: TEdit;
    LabelRef: TLabel;
    BitBtnRef: TBitBtn;
    EditFiltre: TEdit;
    BitBtn3: TBitBtn;
    SpinHaut: TSpinEdit;
    SpinBas: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Label4: TLabel;
    procedure BitBtnAjoutClick(Sender: TObject);
    procedure BitBtnSuppClick(Sender: TObject);
    procedure BitBtnRefClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FileListBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FileListBoxDblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    RefVisible,GenVisible:Boolean;
    procedure CacheRef;
    procedure MontreRef;
  end;

implementation

uses pu_main,
     u_lang;

{$R *.DFM}

procedure Tpop_select_lot.CacheRef;
begin
EditRef.Visible:=False;
LabelRef.Visible:=False;
BitBtnRef.Visible:=False;
ListBox.Top:=2;
ListBox.Height:=351;
RefVisible:=False;
EditRef.Text:='';
end;

procedure Tpop_select_lot.MontreRef;
begin
EditRef.Visible:=True;
LabelRef.Visible:=True;
BitBtnRef.Visible:=True;
ListBox.Top:=76;
ListBox.Height:=277;
RefVisible:=True;
end;

procedure Tpop_select_lot.BitBtnAjoutClick(Sender: TObject);
var
i,j:integer;
Trouve:Boolean;
begin
for i:=0 to FileListBox.Items.Count-1 do
   if FileListBox.Selected[i] then
      begin
      Trouve:=False;
      for j:=0 to ListBox.Items.Count-1 do
        if ListBox.Items[j]=ExtractFileName(FileListBox.Items[i]) then
           Trouve:=True;
      if not(Trouve) then
         ListBox.Items.Add(ExtractFileName(FileListBox.Items[i]));
      end;
end;

procedure Tpop_select_lot.BitBtnSuppClick(Sender: TObject);
var
i:integer;
begin
i:=0;
while i<=ListBox.Items.Count-1 do
   begin
   if ListBox.Selected[i] then ListBox.Items.Delete(i)
   else inc(i);
   end;
end;

procedure Tpop_select_lot.BitBtnRefClick(Sender: TObject);
var
i:integer;
Trouve:Boolean;
begin
i:=0;
Trouve:=False;
while not(Trouve) and (i<=ListBox.Items.Count-1) do
   begin
   if ListBox.Selected[i] then
      begin
      EditRef.Text:=ListBox.Items[i];
      ListBox.Items.Delete(i);
      Trouve:=True;
      end;
   inc(i);
   end;
end;

procedure Tpop_select_lot.BitBtn3Click(Sender: TObject);
var
Filtre,NomFich,IndexStr:String;
i,j,PosPoint,Index,IndexMin,IndexMax,LongRef:Longint;
FinNum,Num:Boolean;
begin
Filtre:=ExtractFileName(FileListBox.Filename);
PosPoint:=Pos('.',Filtre);
if PosPoint<>0 then Filtre:=Copy(Filtre,1,PosPoint-1);
FinNum:=False;
if (Length(Filtre)>0) and (Filtre[Length(Filtre)] in ['0'..'9']) then FinNum:=True;
if FinNum then
   begin
   while (Length(Filtre)>0) and (Filtre[Length(Filtre)] in ['0'..'9'])
      do Filtre:=Copy(Filtre,1,Length(Filtre)-1);
   EditFiltre.Text:=Filtre;
   LongRef:=Length(Filtre);
   IndexMax:=-1;
   IndexMin:=999999999;
   i:=0;
   while i<=FileListBox.Items.Count-1 do
      begin
      NomFich:=ExtractFileName(FileListBox.Items[i]);
      if Copy(NomFich,1,LongRef)=Filtre then
         begin
         PosPoint:=Pos('.',NomFich);
         if PosPoint<>0 then NomFich:=Copy(NomFich,1,PosPoint-1);
         IndexStr:=Copy(NomFich,LongRef+1,Length(NomFich)-LongRef+1);
         if IndexStr<>'' then
            begin
            Num:=True;
            for j:=1 to Length(IndexStr) do
               if Not(IndexStr[j] in ['0'..'9']) then Num:=False;
            if Num then
               begin
               Index:=StrToInt(IndexStr);
               if Index>IndexMax then IndexMax:=Index;
               if Index<IndexMin then IndexMin:=Index;
               end;
            end;
         end;
      inc(i);
      end;
   SpinHaut.Value:=IndexMax;
   SpinBas.Value:=IndexMin;
   end;
end;

procedure Tpop_select_lot.BitBtn5Click(Sender: TObject);
var
i:Integer;
begin
for i:=0 to FileListBox.Items.Count-1 do
   ListBox.Items.Add(ExtractFileName(FileListBox.Items[i]));
end;

procedure Tpop_select_lot.BitBtn6Click(Sender: TObject);
begin
ListBox.Clear;
end;

procedure Tpop_select_lot.FormActivate(Sender: TObject);
begin
FileListBox.Update;
end;

procedure Tpop_select_lot.BitBtn7Click(Sender: TObject);
var
Racine:String;
i,PosPoint:Longint;
FinNum:Boolean;
begin
i:=0;
while i<=FileListBox.Items.Count-1 do
   begin
   Racine:=ExtractFileName(FileListBox.Items[i]);
   PosPoint:=Pos('.',Racine);
   if PosPoint<>0 then Racine:=Copy(Racine,1,PosPoint-1);
   FinNum:=False;
   if (Length(Racine)>0) and (Racine[Length(Racine)] in ['0'..'9']) then FinNum:=True;
   if FinNum then
      begin
      While (Length(Racine)>0) and (Racine[Length(Racine)] in ['0'..'9'])
         do Racine:=Copy(Racine,1,Length(Racine)-1);
      if Racine=EditFiltre.Text then
         ListBox.Items.Add(ExtractFileName(FileListBox.Items[i]));
      end;
   inc(i);
   end;
end;

procedure Tpop_select_lot.FileListBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
i:Longint;
Resultat:Word;
Tout,Del:Boolean;
begin
if Key=46 then
   begin
   Resultat:=0;
   Tout:=false;
   Del:=False;
   with FileListBox do
      for i:=0 to Items.Count-1 do
         if Selected[i] then
            begin
            if not(Tout) then
               Resultat:=MessageDlg(lang('Supprimer ')+#13+Items[i]
                  +' ?',mtConfirmation,[mbYes,mbNo,mbAll],0) //nolang
            else
               begin
               DeleteFile(Directory+'\'+Items[i]);
               Del:=True;
               end;
            if Resultat=mrYes then
               begin
               DeleteFile(Directory+'\'+Items[i]);
               Del:=true;
               end;
            if Resultat=mrAll then
               begin
               Tout:=true;
               DeleteFile(Directory+'\'+Items[i]);
               Del:=true;
               end;
            end;
   if Del then FileListBox.Update;
   end;
end;

procedure Tpop_select_lot.FormCreate(Sender: TObject);
begin
DirectoryListBox1.Directory:=config.RepImages;
FileListBox.Update;
end;

procedure Tpop_select_lot.FileListBoxDblClick(Sender: TObject);
begin
BitBtn3Click(Sender);
BitBtn7Click(Sender);
BitBtn1Click(Sender);
end;

procedure Tpop_select_lot.BitBtn1Click(Sender: TObject);
begin
config.RepImages:=DirectoryListBox1.Directory;
end;

procedure Tpop_select_lot.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

end.
