unit pu_edit_dico;

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
  StdCtrls, Buttons, ComCtrls, Grids, ExtCtrls;

type
  Tpop_edit_dico = class(TForm)
    BitBtn1: TBitBtn;
    Panel19: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    ScrollBar1: TScrollBar;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    BitBtn2: TBitBtn;
    PanelNum0: TPanel;
    PanelNum1: TPanel;
    PanelNum2: TPanel;
    PanelNum3: TPanel;
    PanelNum4: TPanel;
    PanelNum5: TPanel;
    PanelNum6: TPanel;
    PanelNum7: TPanel;
    PanelNum8: TPanel;
    PanelNum9: TPanel;
    PanelNum10: TPanel;
    PanelNum11: TPanel;
    PanelNum12: TPanel;
    PanelNum13: TPanel;
    PanelNum14: TPanel;
    PanelNum15: TPanel;
    PanelNam0: TPanel;
    PanelNam1: TPanel;
    PanelNam2: TPanel;
    PanelNam3: TPanel;
    PanelNam4: TPanel;
    PanelNam5: TPanel;
    PanelNam6: TPanel;
    PanelNam7: TPanel;
    PanelNam8: TPanel;
    PanelNam9: TPanel;
    PanelNam10: TPanel;
    PanelNam11: TPanel;
    PanelNam12: TPanel;
    PanelNam13: TPanel;
    PanelNam14: TPanel;
    PanelNam15: TPanel;
    procedure FormShow(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure Edit10Change(Sender: TObject);
    procedure Edit11Change(Sender: TObject);
    procedure Edit12Change(Sender: TObject);
    procedure Edit13Change(Sender: TObject);
    procedure Edit14Change(Sender: TObject);
    procedure Edit15Change(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit7KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit8KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit9KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit10KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit11KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit12KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit13KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit14KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit15KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    ShortList:Boolean;
    NbItem:Integer;
    procedure UpdateListe;
    procedure PageChange(Key:Word;Shift:TShiftState);
  public
    { Public declarations }
    LangueRef:TStringList;
    NewLangue:TStringList;
  end;

var
  pop_edit_dico: Tpop_edit_dico;

implementation

{$R *.DFM}

uses u_lang,
     u_class;

procedure Tpop_edit_dico.UpdateListe;
var
i:Integer;
Compo:TComponent;
Texte:string;
begin
for i:=3 to 17 do
   begin
   Compo:=FindComponent('Panel'+IntToStr(i)); //nolang
   Texte:=LangueRef.Strings[ScrollBar1.Position+i-3];
   if Pos('&',Texte)<>0 then Insert('&',Texte,Pos('&',Texte));
   (Compo as TPanel).Caption:=Texte;
   (Compo as TPanel).Hint:=Texte;

   Compo:=FindComponent('Edit'+IntToStr(i-2)); //nolang
   (Compo as TEdit).Text:=NewLangue.Strings[ScrollBar1.Position+i-3];

   Compo:=FindComponent('PanelNum'+IntToStr(i-2)); //nolang
   (Compo as TPanel).Caption:=IntToStr(Length(LangueRef.Strings[ScrollBar1.Position+i-3]));
   end;
end;

procedure Tpop_edit_dico.FormShow(Sender: TObject);
var
i:Integer;
Compo:TComponent;
Texte:String;
begin
if TraductionEnCours then LangueRef:=TStringList.Create;

ShortList:=False;
NbItem:=LangueRef.Count;
if LangueRef.Count>=15 then
   begin
   for i:=3 to 17 do
      begin
      Compo:=FindComponent('Panel'+IntToStr(i)); //nolang
      Texte:=LangueRef.Strings[i-3];
      if Pos('&',Texte)<>0 then Insert('&',Texte,Pos('&',Texte));
      (Compo as TPanel).Caption:=Texte;
      (Compo as TPanel).Hint:=Texte;

      Compo:=FindComponent('Edit'+IntToStr(i-2)); //nolang
      (Compo as TEdit).Text:=NewLangue.Strings[ScrollBar1.Position+i-3];

      Compo:=FindComponent('PanelNum'+IntToStr(i-2)); //nolang
      (Compo as TPanel).Caption:=IntToStr(Length(LangueRef.Strings[i-3]));

      Compo:=FindComponent('PanelNam'+IntToStr(i-2)); //nolang
      (Compo as TPanel).Caption:='0';
      end;
   Scrollbar1.Max:=LangueRef.Count-15;
   end
else
   begin
   ShortList:=True;
   for i:=0 to LangueRef.Count-1 do
      begin
      Compo:=FindComponent('Panel'+IntToStr(i+3)); //nolang
      Texte:=LangueRef.Strings[i];
      if Pos('&',Texte)<>0 then Insert('&',Texte,Pos('&',Texte));
      (Compo as TPanel).Caption:=Texte;
      (Compo as TPanel).Hint:=Texte;

      Compo:=FindComponent('PanelNum'+IntToStr(i+1)); //nolang
      (Compo as TPanel).Caption:=IntToStr(Length(LangueRef.Strings[i]));

      Compo:=FindComponent('PanelNam'+IntToStr(i+1)); //nolang
      (Compo as TPanel).Caption:='0';
      end;
   for i:=LangueRef.Count to 14 do
      begin
      Compo:=FindComponent('Panel'+IntToStr(i+3)); //nolang
      (Compo as TPanel).Visible:=False;

      Compo:=FindComponent('Edit'+IntToStr(i+1)); //nolang
      (Compo as TEdit).Visible:=False;

      Compo:=FindComponent('PanelNum'+IntToStr(i+1)); //nolang
      (Compo as TPanel).Visible:=False;

      Compo:=FindComponent('PanelNam'+IntToStr(i+1)); //nolang
      (Compo as TPanel).Visible:=False;
      end;

   ScrollBar1.Max:=NbItem;
   end;
if LangueRef.Count<=15 then Scrollbar1.Enabled:=False;
UpDateLang(Self);
end;

procedure Tpop_edit_dico.ScrollBar1Change(Sender: TObject);
begin
UpdateListe;
end;

procedure Tpop_edit_dico.Edit1Change(Sender: TObject);
begin
NewLangue.Strings[ScrollBar1.Position]:=Edit1.Text;
PanelNam1.Caption:=IntToStr(Length(Edit1.Text));
end;

procedure Tpop_edit_dico.Edit2Change(Sender: TObject);
begin
NewLangue.Strings[ScrollBar1.Position+1]:=Edit2.Text;
PanelNam2.Caption:=IntToStr(Length(Edit2.Text));
end;

procedure Tpop_edit_dico.Edit3Change(Sender: TObject);
begin
NewLangue.Strings[ScrollBar1.Position+2]:=Edit3.Text;
PanelNam3.Caption:=IntToStr(Length(Edit3.Text));
end;

procedure Tpop_edit_dico.Edit4Change(Sender: TObject);
begin
NewLangue.Strings[ScrollBar1.Position+3]:=Edit4.Text;
PanelNam4.Caption:=IntToStr(Length(Edit4.Text));
end;

procedure Tpop_edit_dico.Edit5Change(Sender: TObject);
begin
NewLangue.Strings[ScrollBar1.Position+4]:=Edit5.Text;
PanelNam5.Caption:=IntToStr(Length(Edit5.Text));
end;

procedure Tpop_edit_dico.Edit6Change(Sender: TObject);
begin
NewLangue.Strings[ScrollBar1.Position+5]:=Edit6.Text;
PanelNam6.Caption:=IntToStr(Length(Edit6.Text));
end;

procedure Tpop_edit_dico.Edit7Change(Sender: TObject);
begin
NewLangue.Strings[ScrollBar1.Position+6]:=Edit7.Text;
PanelNam7.Caption:=IntToStr(Length(Edit7.Text));
end;

procedure Tpop_edit_dico.Edit8Change(Sender: TObject);
begin
NewLangue.Strings[ScrollBar1.Position+7]:=Edit8.Text;
PanelNam8.Caption:=IntToStr(Length(Edit8.Text));
end;

procedure Tpop_edit_dico.Edit9Change(Sender: TObject);
begin
NewLangue.Strings[ScrollBar1.Position+8]:=Edit9.Text;
PanelNam9.Caption:=IntToStr(Length(Edit9.Text));
end;

procedure Tpop_edit_dico.Edit10Change(Sender: TObject);
begin
NewLangue.Strings[ScrollBar1.Position+9]:=Edit10.Text;
PanelNam10.Caption:=IntToStr(Length(Edit10.Text));
end;

procedure Tpop_edit_dico.Edit11Change(Sender: TObject);
begin
NewLangue.Strings[ScrollBar1.Position+10]:=Edit11.Text;
PanelNam11.Caption:=IntToStr(Length(Edit11.Text));
end;

procedure Tpop_edit_dico.Edit12Change(Sender: TObject);
begin
NewLangue.Strings[ScrollBar1.Position+11]:=Edit12.Text;
PanelNam12.Caption:=IntToStr(Length(Edit12.Text));
end;

procedure Tpop_edit_dico.Edit13Change(Sender: TObject);
begin
NewLangue.Strings[ScrollBar1.Position+12]:=Edit13.Text;
PanelNam13.Caption:=IntToStr(Length(Edit13.Text));
end;

procedure Tpop_edit_dico.Edit14Change(Sender: TObject);
begin
NewLangue.Strings[ScrollBar1.Position+13]:=Edit14.Text;
PanelNam14.Caption:=IntToStr(Length(Edit14.Text));
end;

procedure Tpop_edit_dico.Edit15Change(Sender: TObject);
begin
NewLangue.Strings[ScrollBar1.Position+14]:=Edit15.Text;
PanelNam15.Caption:=IntToStr(Length(Edit15.Text));
end;

procedure Tpop_edit_dico.PageChange(Key:Word;Shift:TShiftState);
begin
if Key=vk_Return then Key:=0;
if not ShortList then
   begin
   if Key=33 then if ScrollBar1.Position>ScrollBar1.Min+ScrollBar1.LargeChange then
      begin
      ScrollBar1.Position:=ScrollBar1.Position-ScrollBar1.LargeChange;
      UpdateListe;
      end
   else
      begin
      ScrollBar1.Position:=ScrollBar1.Min;
      UpdateListe;
      end;
   if Key=34 then if ScrollBar1.Position<ScrollBar1.Max-ScrollBar1.LargeChange then
      begin
      ScrollBar1.Position:=ScrollBar1.Position+ScrollBar1.LargeChange;
      UpdateListe;
      end
   else
      begin
      ScrollBar1.Position:=ScrollBar1.Max;
      UpdateListe;
      end;
   if (Key=35) and (Shift=[ssCtrl]) then
      begin
      ScrollBar1.Position:=ScrollBar1.Max;
      UpdateListe;
      end;
   if (Key=36) and (Shift=[ssCtrl]) then
      begin
      ScrollBar1.Position:=ScrollBar1.Min;
      UpdateListe;
      end;
   end;
end;

procedure Tpop_edit_dico.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_up then if ScrollBar1.Position>ScrollBar1.Min then
   begin
   ScrollBar1.Position:=ScrollBar1.Position-1;
   UpdateListe;
   end;
if (Key=vk_down) and Edit2.Visible then Edit2.SetFocus;
PageChange(Key,Shift);
end;

procedure Tpop_edit_dico.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_up then Edit1.SetFocus;
if (Key=vk_down) and Edit3.Visible then Edit3.SetFocus;
PageChange(Key,Shift);
end;

procedure Tpop_edit_dico.Edit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_up then Edit2.SetFocus;
if (Key=vk_down) and Edit4.Visible then Edit4.SetFocus;
PageChange(Key,Shift);
end;

procedure Tpop_edit_dico.Edit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_up then Edit3.SetFocus;
if (Key=vk_down)  and Edit5.Visible then Edit5.SetFocus;
PageChange(Key,Shift);
end;

procedure Tpop_edit_dico.Edit5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_up then Edit4.SetFocus;
if (Key=vk_down) and Edit6.Visible then Edit6.SetFocus;
PageChange(Key,Shift);
end;

procedure Tpop_edit_dico.Edit6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_up then Edit5.SetFocus;
if (Key=vk_down) and Edit7.Visible then Edit7.SetFocus;
PageChange(Key,Shift);
end;

procedure Tpop_edit_dico.Edit7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_up then Edit6.SetFocus;
if (Key=vk_down) and Edit8.Visible then Edit8.SetFocus;
PageChange(Key,Shift);
end;

procedure Tpop_edit_dico.Edit8KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_up then Edit7.SetFocus;
if (Key=vk_down) and Edit9.Visible then Edit9.SetFocus;
PageChange(Key,Shift);
end;

procedure Tpop_edit_dico.Edit9KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_up then Edit8.SetFocus;
if (Key=vk_down) and Edit10.Visible then Edit10.SetFocus;
PageChange(Key,Shift);
end;

procedure Tpop_edit_dico.Edit10KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_up then Edit9.SetFocus;
if (Key=vk_down) and Edit11.Visible then Edit11.SetFocus;
PageChange(Key,Shift);
end;

procedure Tpop_edit_dico.Edit11KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_up then Edit10.SetFocus;
if (Key=vk_down) and Edit12.Visible then Edit12.SetFocus;
PageChange(Key,Shift);
end;

procedure Tpop_edit_dico.Edit12KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_up then Edit11.SetFocus;
if (Key=vk_down) and Edit13.Visible then Edit13.SetFocus;
PageChange(Key,Shift);
end;

procedure Tpop_edit_dico.Edit13KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_up then Edit12.SetFocus;
if (Key=vk_down) and Edit14.Visible then Edit14.SetFocus;
PageChange(Key,Shift);
end;

procedure Tpop_edit_dico.Edit14KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_up then Edit13.SetFocus;
if (Key=vk_down) and Edit15.Visible then Edit15.SetFocus;
PageChange(Key,Shift);
end;

procedure Tpop_edit_dico.Edit15KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_up then Edit14.SetFocus;
if Key=vk_down then if ScrollBar1.Position<ScrollBar1.Max then
   begin
   ScrollBar1.Position:=ScrollBar1.Position+1;
   UpdateListe;
   end;
PageChange(Key,Shift);
end;

end.



