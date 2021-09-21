unit pu_pretraitements;

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
  FileCtrl, StdCtrls, Buttons, Spin, ComCtrls, ExtCtrls, u_class,
  Editnbre, PBFolderDialog, pu_dlg_standard;

type
  Tpop_pretraitements = class(TForm)
    FileListBox: TFileListBox;
    BitBtnAjout: TBitBtn;
    BitBtnSupp: TBitBtn;
    BitBtn1: TBitBtn;
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
    PageControl1: TPageControl;
    TabOffsets: TTabSheet;
    TabNoirsFlats: TTabSheet;
    TabFlats: TTabSheet;
    TabImages: TTabSheet;
    TabNoirs: TTabSheet;
    ListBoxOffsets: TListBox;
    ListBoxNoirsFlats: TListBox;
    ListBoxFlats: TListBox;
    ListBoxImages: TListBox;
    TabEtapes: TTabSheet;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    ListBoxNoirs: TListBox;
    TabConfiguration: TTabSheet;
    RadioGroup5: TRadioGroup;
    CheckBox13: TCheckBox;
    BitBtn2: TBitBtn;
    CheckBox14: TCheckBox;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit8: TEdit;
    Label11: TLabel;
    Edit1: TEdit;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    RadioGroup2: TRadioGroup;
    Label5: TLabel;
    Edit2: TEdit;
    RadioGroup3: TRadioGroup;
    Label6: TLabel;
    Edit3: TEdit;
    RadioGroup4: TRadioGroup;
    Label7: TLabel;
    Edit4: TEdit;
    RadioGroup6: TRadioGroup;
    Label12: TLabel;
    Edit9: TEdit;
    Label13: TLabel;
    Edit10: TEdit;
    CheckBox15: TCheckBox;
    Label14: TLabel;
    Edit11: TEdit;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    CheckBox16: TCheckBox;
    Label15: TLabel;
    outPanel1: TPanel;
    outButton2: TButton;
    CheckBox17: TCheckBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    CheckBoxOptimise: TCheckBox;
    PBFolderDialog1: TPBFolderDialog;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    procedure BitBtnAjoutClick(Sender: TObject);
    procedure BitBtnSuppClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FileListBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FileListBoxDblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure RadioGroup3Click(Sender: TObject);
    procedure RadioGroup4Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure outButton2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox18Click(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit11Change(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
//    procedure GetConfigPretraitements(var ConfigPretraitements:TConfigPretraitements);
//    procedure SetConfigPretraitements(ConfigPretraitements:TConfigPretraitements);
  procedure SaveConfig;
  end;

function GetCCDSoftNomGenerique(Nom:string):string;
function GetCCDSoftNumero(Nom:string):string;
  
implementation

uses pu_main,
     u_general,
     u_lang;

{$R *.DFM}

procedure Tpop_pretraitements.BitBtnAjoutClick(Sender: TObject);
var
i,j:integer;
Trouve:Boolean;
begin
for i:=0 to FileListBox.Items.Count-1 do
   if FileListBox.Selected[i] then
      begin
      Trouve:=False;
      if PageControl1.ActivePage=TabOffsets then
         begin
         for j:=0 to ListBoxOffsets.Items.Count-1 do
            if ListBoxOffsets.Items[j]=ExtractFileName(FileListBox.Items[i]) then Trouve:=True;
         if not(Trouve) then ListBoxOffsets.Items.Add(ExtractFileName(FileListBox.Items[i]));
         end;
      if PageControl1.ActivePage=TabNoirs then
         begin
         for j:=0 to ListBoxNoirs.Items.Count-1 do
            if ListBoxNoirs.Items[j]=ExtractFileName(FileListBox.Items[i]) then Trouve:=True;
         if not(Trouve) then ListBoxNoirs.Items.Add(ExtractFileName(FileListBox.Items[i]));
         end;
      if PageControl1.ActivePage=TabNoirsFlats then
         begin
         for j:=0 to ListBoxNoirsFlats.Items.Count-1 do
            if ListBoxNoirsFlats.Items[j]=ExtractFileName(FileListBox.Items[i]) then Trouve:=True;
         if not(Trouve) then ListBoxNoirsFlats.Items.Add(ExtractFileName(FileListBox.Items[i]));
         end;
      if PageControl1.ActivePage=TabFlats then
         begin
         for j:=0 to ListBoxFlats.Items.Count-1 do
            if ListBoxFlats.Items[j]=ExtractFileName(FileListBox.Items[i]) then Trouve:=True;
         if not(Trouve) then ListBoxFlats.Items.Add(ExtractFileName(FileListBox.Items[i]));
         end;
      if PageControl1.ActivePage=TabImages then
         begin
         for j:=0 to ListBoxImages.Items.Count-1 do
            if ListBoxImages.Items[j]=ExtractFileName(FileListBox.Items[i]) then Trouve:=True;
         if not(Trouve) then ListBoxImages.Items.Add(ExtractFileName(FileListBox.Items[i]));
         end;
      end;
end;

procedure Tpop_pretraitements.BitBtnSuppClick(Sender: TObject);
var
i:integer;
begin
if PageControl1.ActivePage=TabOffsets then
   begin
   i:=0;
   while i<=ListBoxOffsets.Items.Count-1 do
      begin
      if ListBoxOffsets.Selected[i] then ListBoxOffsets.Items.Delete(i)
      else inc(i);
      end;
   end;
if PageControl1.ActivePage=TabNoirs then
   begin
   i:=0;
   while i<=ListBoxNoirs.Items.Count-1 do
      begin
      if ListBoxNoirs.Selected[i] then ListBoxNoirs.Items.Delete(i)
      else inc(i);
      end;
   end;
if PageControl1.ActivePage=TabNoirsFlats then
   begin
   i:=0;
   while i<=ListBoxNoirsFlats.Items.Count-1 do
      begin
      if ListBoxNoirsFlats.Selected[i] then ListBoxNoirsFlats.Items.Delete(i)
      else inc(i);
      end;
   end;
if PageControl1.ActivePage=TabFlats then
   begin
   i:=0;
   while i<=ListBoxFlats.Items.Count-1 do
      begin
      if ListBoxFlats.Selected[i] then ListBoxFlats.Items.Delete(i)
      else inc(i);
      end;
   end;
if PageControl1.ActivePage=TabImages then
   begin
   i:=0;
   while i<=ListBoxImages.Items.Count-1 do
      begin
      if ListBoxImages.Selected[i] then ListBoxImages.Items.Delete(i)
      else inc(i);
      end;
   end;

end;

procedure Tpop_pretraitements.BitBtn3Click(Sender: TObject);
var
Filtre,NomFich,IndexStr:String;
i,j,PosPoint,Index,IndexMin,IndexMax,LongRef:Longint;
FinNum,Num:Boolean;
begin
Filtre:=ExtractFileName(FileListBox.Filename);
if CheckBox19.Checked then
   begin
   Filtre:=GetCCDSoftNomGenerique(Filtre);
   EditFiltre.Text:=Filtre;

   IndexMax:=-1;
   IndexMin:=999999999;
   i:=0;
   while i<=FileListBox.Items.Count-1 do
      begin
      NomFich:=GetCCDSoftNomGenerique(FileListBox.Items[i]);
      if NomFich=Filtre then
         begin
         IndexStr:=GetCCDSoftNumero(FileListBox.Items[i]);
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
   end
else
   begin
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
end;

procedure Tpop_pretraitements.BitBtn5Click(Sender: TObject);
var
i:Integer;
begin
if PageControl1.ActivePage=TabOffsets then
   begin
   for i:=0 to FileListBox.Items.Count-1 do
      ListBoxOffsets.Items.Add(ExtractFileName(FileListBox.Items[i]));
   end;
if PageControl1.ActivePage=TabNoirs then
   begin
   for i:=0 to FileListBox.Items.Count-1 do
      ListBoxNoirs.Items.Add(ExtractFileName(FileListBox.Items[i]));
   end;
if PageControl1.ActivePage=TabNoirsFlats then
   begin
   for i:=0 to FileListBox.Items.Count-1 do
      ListBoxNoirsFlats.Items.Add(ExtractFileName(FileListBox.Items[i]));
   end;
if PageControl1.ActivePage=TabFlats then
   begin
   for i:=0 to FileListBox.Items.Count-1 do
      ListBoxFlats.Items.Add(ExtractFileName(FileListBox.Items[i]));
   end;
if PageControl1.ActivePage=TabImages then
   begin
   for i:=0 to FileListBox.Items.Count-1 do
      ListBoxImages.Items.Add(ExtractFileName(FileListBox.Items[i]));
   end;
end;

procedure Tpop_pretraitements.BitBtn6Click(Sender: TObject);
begin
if PageControl1.ActivePage=TabOffsets then ListBoxOffsets.Clear;
if PageControl1.ActivePage=TabNoirs then ListBoxNoirs.Clear;
if PageControl1.ActivePage=TabNoirsFlats then ListBoxNoirsFlats.Clear;
if PageControl1.ActivePage=TabFlats then ListBoxFlats.Clear;
if PageControl1.ActivePage=TabImages then ListBoxImages.Clear;
end;

procedure Tpop_pretraitements.FormActivate(Sender: TObject);
begin
FileListBox.Update;
end;

procedure Tpop_pretraitements.BitBtn7Click(Sender: TObject);
var
Racine:String;
i,PosPoint:Longint;
FinNum:Boolean;
begin
if CheckBox19.Checked then
   begin
   i:=0;
   while i<=FileListBox.Items.Count-1 do
      begin
      Racine:=GetCCDSoftNomGenerique(FileListBox.Items[i]);
      if Racine=EditFiltre.Text then
         begin
         if PageControl1.ActivePage=TabOffsets then
            ListBoxOffsets.Items.Add(ExtractFileName(FileListBox.Items[i]));
         if PageControl1.ActivePage=TabNoirs then
            ListBoxNoirs.Items.Add(ExtractFileName(FileListBox.Items[i]));
         if PageControl1.ActivePage=TabNoirsFlats then
            ListBoxNoirsFlats.Items.Add(ExtractFileName(FileListBox.Items[i]));
         if PageControl1.ActivePage=TabFlats then
            ListBoxFlats.Items.Add(ExtractFileName(FileListBox.Items[i]));
         if PageControl1.ActivePage=TabImages then
            ListBoxImages.Items.Add(ExtractFileName(FileListBox.Items[i]));
         end;
      inc(i);
      end;
   end
else
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
         while (Length(Racine)>0) and (Racine[Length(Racine)] in ['0'..'9'])
            do Racine:=Copy(Racine,1,Length(Racine)-1);
         if Racine=EditFiltre.Text then
            begin
            if PageControl1.ActivePage=TabOffsets then
               ListBoxOffsets.Items.Add(ExtractFileName(FileListBox.Items[i]));
            if PageControl1.ActivePage=TabNoirs then
               ListBoxNoirs.Items.Add(ExtractFileName(FileListBox.Items[i]));
            if PageControl1.ActivePage=TabNoirsFlats then
               ListBoxNoirsFlats.Items.Add(ExtractFileName(FileListBox.Items[i]));
            if PageControl1.ActivePage=TabFlats then
               ListBoxFlats.Items.Add(ExtractFileName(FileListBox.Items[i]));
            if PageControl1.ActivePage=TabImages then
               ListBoxImages.Items.Add(ExtractFileName(FileListBox.Items[i]));
            end;
         end;
      inc(i);
      end;
   end;
end;

procedure Tpop_pretraitements.FileListBoxKeyDown(Sender: TObject; var Key: Word;
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

procedure Tpop_pretraitements.FileListBoxDblClick(Sender: TObject);
begin
BitBtn3Click(Sender);
BitBtn7Click(Sender);
//BitBtn1Click(Sender);
end;

procedure Tpop_pretraitements.BitBtn1Click(Sender: TObject);
begin
SaveConfig;
end;

procedure Tpop_pretraitements.RadioGroup1Click(Sender: TObject);
begin
if RadioGroup1.ItemIndex=2 then
  begin
  Label1.Enabled:=True;
  Edit1.Enabled:=True;
  end
else
  begin
  Label1.Enabled:=False;
  Edit1.Enabled:=False;
  end
end;

procedure Tpop_pretraitements.RadioGroup2Click(Sender: TObject);
begin
if RadioGroup2.ItemIndex=2 then
  begin
  Label5.Enabled:=True;
  Edit2.Enabled:=True;
  end
else
  begin
  Label5.Enabled:=False;
  Edit2.Enabled:=False;
  end
end;

procedure Tpop_pretraitements.RadioGroup3Click(Sender: TObject);
begin
if RadioGroup3.ItemIndex=2 then
  begin
  Label6.Enabled:=True;
  Edit3.Enabled:=True;
  end
else
  begin
  Label6.Enabled:=False;
  Edit3.Enabled:=False;
  end
end;

procedure Tpop_pretraitements.RadioGroup4Click(Sender: TObject);
begin
if RadioGroup4.ItemIndex=2 then
  begin
  Label7.Enabled:=True;
  Edit4.Enabled:=True;
  end
else
  begin
  Label7.Enabled:=False;
  Edit4.Enabled:=False;
  end
end;

procedure Tpop_pretraitements.Edit1KeyPress(Sender: TObject;
  var Key: Char);
begin
if Key=#13 then
   begin
   if mystrtofloat(Edit1.Text)<0.1 then Edit1.Text:='0.1'; //nolang
   if mystrtofloat(Edit1.Text)>10 then Edit1.Text:='10';   //nolang
   end;
end;

procedure Tpop_pretraitements.Edit2KeyPress(Sender: TObject;
  var Key: Char);
begin
if Key=#13 then
   begin
   if mystrtofloat(Edit2.Text)<0.1 then Edit2.Text:='0.1';  //nolang
   if mystrtofloat(Edit2.Text)>10 then Edit2.Text:='10';    //nolang
   end;
end;

procedure Tpop_pretraitements.Edit3KeyPress(Sender: TObject;
  var Key: Char);
begin
if Key=#13 then
   begin
   if mystrtofloat(Edit3.Text)<0.1 then Edit3.Text:='0.1';  //nolang
   if mystrtofloat(Edit3.Text)>10 then Edit3.Text:='10';    //nolang
   end;
end;

procedure Tpop_pretraitements.Edit4KeyPress(Sender: TObject;
  var Key: Char);
begin
if Key=#13 then
   begin
   if mystrtofloat(Edit4.Text)<0.1 then Edit4.Text:='0.1';  //nolang
   if mystrtofloat(Edit4.Text)>10 then Edit4.Text:='10';    //nolang
   end;
end;

//>>Le nom générique est "f0005r" que je donne au Flats posés 5 secondes avec le filtre "R",
//>>le reste est automatiquement ajouté par le logiciel CCDSoft.
//>>Noir: d0010c.00000010.DARK.FIT
//>>d=dark posé 10s
//>>Offset
//>>o0000c.00000010.BIAS.FIT
//>>o=offset
//>>noirflat
//>>d0005c.00000010.DARK.FIT
//>>d=dark posé 5s.
//>
//> Je vois pas ou est le numero de chaque image elementaire de
//> la serie dans ces
//> indications. Serais ce deja les resultats du compositage de series ?
//
//Non, je peux nommer la premiere partie, soit pour "d0005c.00000010.DARK.FIT",
//"dooo5c" et le logiciel met automatiquement le reste, soit ".00000010.DARK.FIT"
//où le numéro de l'image est 00000010.
//Si c'est un flat ou un bias, il ajoute flat ou bias et pour une image courante
//il n'ajoute que le numéro à 8 chiffres.

// Extraire le type d'image avec la convention CCDSoft
function GetCCDSoftType(Nom:string):string;
var
   PosEsp:Integer;
begin
Result:='';

PosEsp:=Pos('.',Nom);
if PosEsp=0 then Exit;
Delete(Nom,1,PosEsp);

PosEsp:=Pos('.',Nom);
if PosEsp=0 then Exit;
Delete(Nom,1,PosEsp);

PosEsp:=Pos('.',Nom);
if PosEsp=0 then Exit;
Result:=Copy(Nom,1,PosEsp-1);
end;

// Extraire le type d'image avec la convention CCDSoft
function GetCCDSoftNumero(Nom:string):string;
var
   PosEsp:Integer;
begin
Result:='';

PosEsp:=Pos('.',Nom);
if PosEsp=0 then Exit;
Delete(Nom,1,PosEsp);

PosEsp:=Pos('.',Nom);
if PosEsp=0 then Exit;
Result:=Copy(Nom,1,PosEsp-1);
end;

// Extraire le nom générique avec la convention CCDSoft
function GetCCDSoftNomGenerique(Nom:string):string;
var
   PosEsp:Integer;
begin
Result:='';

PosEsp:=Pos('.',Nom);
if PosEsp=0 then Exit;
Result:=Copy(Nom,1,PosEsp-1);
end;


procedure Tpop_pretraitements.BitBtn2Click(Sender: TObject);
var
i,PosPoint:Integer;
NomGen,Nom,NomSansExt,TypeImg,Numero:string;
begin
Config.ConfigPretrait.NomOffset:=Edit5.Text;
Config.ConfigPretrait.NomNoir:=Edit6.Text;
Config.ConfigPretrait.NomNoirFlat:=Edit7.Text;
Config.ConfigPretrait.NomFlat:=Edit8.Text;
Config.ConfigPretrait.NomCosmetiques:=Edit11.Text;

ListBoxOffsets.Clear;
ListBoxNoirs.Clear;
ListBoxNoirsFlats.Clear;
ListBoxFlats.Clear;
ListBoxImages.Clear;

if CheckBox19.Checked then
   begin
   for i:=0 to FileListBox.Items.Count-1 do
      begin
      Nom:=FileListBox.Items[i];
      PosPoint:=Pos('.',Nom);
      if PosPoint<>0 then NomSansExt:=Copy(Nom,1,PosPoint-1);
      NomGen:=UpperCase(GetNomGenerique(Nom));
      TypeImg:=UpperCase(GetCCDSoftType(Nom));
      Numero:=GetCCDSoftNumero(Nom);

      if TypeImg='BIAS' then //nolang
         begin
         if UpperCase(NomSansExt)<>UpperCase(Config.ConfigPretrait.NomOffset) then ListBoxOffsets.Items.Add(Nom)
         end
      else if TypeImg='DARK' then //nolang
         begin
         if UpperCase(NomSansExt)<>UpperCase(Config.ConfigPretrait.NomNoir) then ListBoxNoirs.Items.Add(Nom)
         end
      else if TypeImg='DARKFLAT' then //nolang
         begin
         if UpperCase(NomSansExt)<>UpperCase(Config.ConfigPretrait.NomNoirFlat) then ListBoxNoirsFlats.Items.Add(Nom)
         end
      else if TypeImg='FLAT' then //nolang
         begin
         if UpperCase(NomSansExt)<>UpperCase(Config.ConfigPretrait.NomFlat) then ListBoxFlats.Items.Add(Nom)
         end
      else if (Pos('sub_',Nom)=0) and (Pos('div_',Nom)=0) and (Pos('rec_',Nom)=0) and (Pos('mi_',Nom)=0) //nolang
         and (Pos('cal_',Nom)=0) //nolang
         and (Length(Numero)<>0) and (Numero[Length(Numero)] in ['0'..'9']) then ListBoxImages.Items.Add(Nom);

      end;

   end
else
   begin
   for i:=0 to FileListBox.Items.Count-1 do
      begin
      Nom:=FileListBox.Items[i];
      PosPoint:=Pos('.',Nom);
      if PosPoint<>0 then NomSansExt:=Copy(Nom,1,PosPoint-1);
      NomGen:=UpperCase(GetNomGenerique(Nom));

      if NomGen=UpperCase(Config.ConfigPretrait.NomOffset) then
         begin
         if UpperCase(NomSansExt)<>UpperCase(Config.ConfigPretrait.NomOffset) then ListBoxOffsets.Items.Add(Nom)
         end
      else if NomGen=UpperCase(Config.ConfigPretrait.NomNoir) then
         begin
         if UpperCase(NomSansExt)<>UpperCase(Config.ConfigPretrait.NomNoir) then ListBoxNoirs.Items.Add(Nom)
         end
      else if NomGen=UpperCase(Config.ConfigPretrait.NomNoirFlat) then
         begin
         if UpperCase(NomSansExt)<>UpperCase(Config.ConfigPretrait.NomNoirFlat) then ListBoxNoirsFlats.Items.Add(Nom)
         end
      else if NomGen=UpperCase(Config.ConfigPretrait.NomFlat) then
         begin
         if UpperCase(NomSansExt)<>UpperCase(Config.ConfigPretrait.NomFlat) then ListBoxFlats.Items.Add(Nom)
         end
      else if (Pos('sub_',Nom)=0) and (Pos('div_',Nom)=0) and (Pos('rec_',Nom)=0) and (Pos('mi_',Nom)=0) //nolang
         and (Pos('cal_',Nom)=0) //nolang
         and (NomSansExt[Length(NomSansExt)] in ['0'..'9']) then ListBoxImages.Items.Add(Nom);
      end;
   end;
end;

procedure Tpop_pretraitements.FormShow(Sender: TObject);
begin
outPanel1.Caption:=ComprimeTexte(Config.RepImagesAcq,30);

UpDateLang(Self);

with Config.ConfigPretrait do
   begin
   CheckBox17.Checked:=UsePreviousFiles;
   CheckBox1.Checked:=CreeOffset;
   CheckBox2.Checked:=EnleveOffsetAuxNoirs;
   CheckBox3.Checked:=CreeNoir;
   CheckBox6.Checked:=EnleveOffsetAuxNoirsFlats;
   CheckBox7.Checked:=CreeNoirFlats;
   CheckBox14.Checked:=MoyenneIdentiqueDesFlats;
   CheckBox13.Checked:=CreeFlat;
   CheckBox4.Checked:=EnleveOffsetAuxFlats;
   CheckBox5.Checked:=EnleveNoirsFlatsAuxFlats;
   CheckBox13.Checked:=CreeNoirFlats;
   CheckBox8.Checked:=EnleveOffsetAuxImages;
   CheckBox9.Checked:=EnleveNoirAuxImages;
   CheckBox10.Checked:=CorrigeImagesDuFlat;
   CheckBox11.Checked:=RecaleImages;
   CheckBox12.Checked:=CompositeImages;
   CheckBox15.Checked:=SupprimmerImages;
   CheckBox16.Checked:=CorrigeCosmetique;
   CheckBox18.Checked:=AppliqueMedian;
   CheckBoxOptimise.Checked:=OptimiseNoir;   
   RadioGroup1.ItemIndex:=TypeCreationOffset;
   RadioGroup2.ItemIndex:=TypeCreationNoir;
   RadioGroup3.ItemIndex:=TypeCreationFlat;
   RadioGroup6.ItemIndex:=TypeCreationNoirFlat;
   RadioGroup5.ItemIndex:=TypeRecalageImages;
   RadioGroup4.ItemIndex:=TypeCompositageImages;
   Edit1.Text:=MyFloatToStr(NbSigmaOffset,2);
   Edit2.Text:=MyFloatToStr(NbSigmaNoir,2);
   Edit3.Text:=MyFloatToStr(NbSigmaFlat,2);
   Edit9.Text:=MyFloatToStr(NbSigmaNoirFlat,2);
   Edit4.Text:=MyFloatToStr(NbSigmaImage,2);
   Edit5.Text:=NomOffset;
   Edit6.Text:=NomNoir;
   Edit7.Text:=NomNoirFlat;
   Edit8.Text:=NomFlat;
   Edit11.Text:=NomCosmetiques;   
   Edit10.Text:=MyFloatToStr(ErreurRecaleImages,2);
   CheckBox19.Checked:=TypeCCDSoft;
   end;
end;

procedure Tpop_pretraitements.Button1Click(Sender: TObject);
begin
OpenDialog1.InitialDir:=Config.RepImagesAcq;
OpenDialog1.Filter:=lang('Fichier cosmétique (*.cos)|*.cos');
if OpenDialog1.Execute then
   begin
   Edit11.Text:=ExtractFileName(OpenDialog1.FileName);
   end;
end;

procedure Tpop_pretraitements.outButton2Click(Sender: TObject);
begin
PBFolderDialog1.Folder:=Config.RepImagesAcq;
if PBFolderDialog1.Execute then
   if Length(PBFolderDialog1.Folder)<>0 then
      begin
      Config.RepImagesAcq:=PBFolderDialog1.Folder;
      FileListBox.Directory:=Config.RepImagesAcq;
      outPanel1.Caption:=ComprimeTexte(Config.RepImagesAcq,30);
      ListBoxOffsets.Clear;
      ListBoxNoirsFlats.Clear;
      ListBoxNoirs.Clear;
      ListBoxFlats.Clear;
      ListBoxImages.Clear;
      end;
end;

procedure Tpop_pretraitements.Button2Click(Sender: TObject);
begin
OpenDialog1.InitialDir:=Config.RepImagesAcq;
OpenDialog1.Filter:=lang('Fichiers Pic Cpa Fits|*.pic;*.cpa;*.fit*;*.fts');
OpenDialog1.Title:=lang('Choisir l''Offset');
if OpenDialog1.Execute then Edit5.Text:=GetNomGenerique(OpenDialog1.FileName);
end;

procedure Tpop_pretraitements.Button3Click(Sender: TObject);
begin
OpenDialog1.InitialDir:=Config.RepImagesAcq;
OpenDialog1.Filter:=lang('Fichiers Pic Cpa Fits|*.pic;*.cpa;*.fit*;*.fts');
OpenDialog1.Title:=lang('Choisir le noir');
if OpenDialog1.Execute then Edit6.Text:=GetNomGenerique(OpenDialog1.FileName);
end;

procedure Tpop_pretraitements.Button4Click(Sender: TObject);
begin
OpenDialog1.InitialDir:=Config.RepImagesAcq;
OpenDialog1.Filter:=lang('Fichiers Pic Cpa Fits|*.pic;*.cpa;*.fit*;*.fts');
OpenDialog1.Title:=lang('Choisir le noir des flats');
if OpenDialog1.Execute then Edit7.Text:=GetNomGenerique(OpenDialog1.FileName);
end;

procedure Tpop_pretraitements.Button5Click(Sender: TObject);
begin
OpenDialog1.InitialDir:=Config.RepImagesAcq;
OpenDialog1.Filter:=lang('Fichiers Pic Cpa Fits|*.pic;*.cpa;*.fit*;*.fts');
OpenDialog1.Title:=lang('Choisir le flat');
if OpenDialog1.Execute then Edit8.Text:=GetNomGenerique(OpenDialog1.FileName);
end;

procedure Tpop_pretraitements.CheckBox18Click(Sender: TObject);
var
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   i:Integer;
begin
if CheckBox18.Checked then
   begin
   New(TabItems);
   try
   for i:=1 to NbMaxItems do TabItems^[i].Msg:='';

   with TabItems^[1] do
      begin
      TypeItem:=tiLabel;
      Msg:=lang('Attention ! Ce filtrage rendra vos images impropres à la photométrie');
      end;

   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,350);
   DlgStandard.Caption:=lang('Avertissement');
   DlgStandard.HideUndo;
   DlgStandard.ShowModal;

   finally
   Dispose(TabItems);
   end;

   end;
end;

procedure Tpop_pretraitements.Edit5Change(Sender: TObject);
begin
Config.ConfigPretrait.NomOffset:=Edit5.Text;
end;

procedure Tpop_pretraitements.Edit6Change(Sender: TObject);
begin
Config.ConfigPretrait.NomNoir:=Edit6.Text;
end;

procedure Tpop_pretraitements.Edit7Change(Sender: TObject);
begin
Config.ConfigPretrait.NomNoirFlat:=Edit7.Text;
end;

procedure Tpop_pretraitements.Edit8Change(Sender: TObject);
begin
Config.ConfigPretrait.NomFlat:=Edit8.Text;
end;

procedure Tpop_pretraitements.Edit11Change(Sender: TObject);
begin
Config.ConfigPretrait.NomCosmetiques:=Edit11.Text;
end;

procedure Tpop_pretraitements.SaveConfig;
begin
with Config.ConfigPretrait do
   begin
   UsePreviousFiles:=CheckBox17.Checked;
   CreeOffset:=CheckBox1.Checked;
   EnleveOffsetAuxNoirs:=CheckBox2.Checked;
   CreeNoir:=CheckBox3.Checked;
   EnleveOffsetAuxNoirsFlats:=CheckBox6.Checked;
   CreeNoirFlats:=CheckBox7.Checked;
   MoyenneIdentiqueDesFlats:=CheckBox14.Checked;
   CreeFlat:=CheckBox13.Checked;
   EnleveOffsetAuxFlats:=CheckBox4.Checked;
   EnleveNoirsFlatsAuxFlats:=CheckBox5.Checked;
   CreeNoirFlats:=CheckBox13.Checked;
   EnleveOffsetAuxImages:=CheckBox8.Checked;
   EnleveNoirAuxImages:=CheckBox9.Checked;
   CorrigeImagesDuFlat:=CheckBox10.Checked;
   RecaleImages:=CheckBox11.Checked;
   CompositeImages:=CheckBox12.Checked;
   SupprimmerImages:=CheckBox15.Checked;
   CorrigeCosmetique:=CheckBox16.Checked;
   AppliqueMedian:=CheckBox18.Checked;
   OptimiseNoir:=CheckBoxOptimise.Checked;
   TypeCreationOffset:=RadioGroup1.ItemIndex;
   TypeCreationNoir:=RadioGroup2.ItemIndex;
   TypeCreationFlat:=RadioGroup3.ItemIndex;
   TypeCreationNoirFlat:=RadioGroup6.ItemIndex;
   TypeRecalageImages:=RadioGroup5.ItemIndex;
   TypeCompositageImages:=RadioGroup4.ItemIndex;
   NbSigmaOffset:=MyStrToFloat(Edit1.Text);
   NbSigmaNoir:=MyStrToFloat(Edit2.Text);
   NbSigmaFlat:=MyStrToFloat(Edit3.Text);
   NbSigmaNoirFlat:=MyStrToFloat(Edit9.Text);
   NbSigmaImage:=MyStrToFloat(Edit4.Text);
   NomOffset:=Edit5.Text;
   NomNoir:=Edit6.Text;
   NomNoirFlat:=Edit7.Text;
   NomFlat:=Edit8.Text;
   NomCosmetiques:=Edit11.Text;
   ErreurRecaleImages:=MyStrToFloat(Edit10.Text);
   TypeCCDSoft:=CheckBox19.Checked;
   end;
end;

procedure Tpop_pretraitements.BitBtn4Click(Sender: TObject);
begin
SaveConfig;
end;

end.
