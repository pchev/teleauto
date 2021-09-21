unit pu_dlg_standard;

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
  StdCtrls, Buttons, ExtCtrls, Spin, Editnbre, u_constants;

const
  NbMaxItems=30;
  tiLabel      = 0;
  tiInteger    = 1;
  tiReal       = 3;
  tiCheckBox   = 4;
  tiEdit       = 5;
  tiListBox    = 6;
  tiRadioGroup = 7;

type
  TDlgItem=record
     TypeItem:Byte;
     Msg:String;
     ValeurDefaut:Double;
     ValeurIncrement:Double;
     ValeurCheckDefaut:Boolean;
     ValeurStrDefaut:string;
     ValeurSortie:Double;
     ValeurStrSortie:string;
     ValeurMin:Double;
     ValeurMax:Double;
     MultiSelect:Boolean;
     IsPassWord:Boolean;
     UnderLine:Boolean;
     EditWidth:Integer;
     ReadOnly:Boolean;
     end;

  TabItems=array[1..NbMaxItems] of TDlgItem;
  PTabItems=^TabItems;

  TTabLabel=array[1..999] of TLabel;
  PTabLabel=^TTabLabel;

  TTabSpin=array[1..999] of TSpinEdit;
  PTabSpin=^TTabSpin;

  TTabNbre=array[1..999] of NbreEdit;
  PTabNbre=^TTabNbre;

  TTabCheck=array[1..999] of TCheckBox;
  PTabCheck=^TTabCheck;

  TTabEdit=array[1..999] of TEdit;
  PTabEdit=^TTabEdit;

  TTabListBox=array[1..999] of TListBox;
  PTabListBox=^TTabListBox;

  TTabRadioGroup=array[1..999] of TRadioGroup;
  PTabRadioGroup=^TTabRadioGroup;

  Tpop_dlg_standard = class(TForm)
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    NbItems:Integer;
    TabItems:PTabItems;

    TabLabel:PTabLabel;
    TabSpin:PTabSpin;
    TabNbre:PTabNbre;
    TabCheck:PTabCheck;
    TabEdit:PTabEdit;
    TabListBox:PTabListBox;
    TabRadioGroup:PTabRadioGroup;

    NbLabel,NbInteger,NbReal,NbCheckBox,NbEdit,NbListBox,NbRadioGroup:Integer;
    LargeurDemandee:Integer;
    FreeOnClose:Boolean;
    CloseOnOK:Boolean;

  public
    { Public declarations }
    constructor Create(AOwner:TComponent;TabItemsIn:PTabItems;LargeurDemandeeIn:Integer);
    procedure SetOKButton(Text:string);
    procedure HideUndo;
    procedure SetFreeOnCLose;
    procedure SetCloseOnOK;
  end;

procedure IniTabItems(TabItems:PTabItems);

implementation

{$R *.DFM}

uses u_lang,
     u_general;

constructor Tpop_dlg_standard.Create(AOwner:TComponent;TabItemsIn:PTabItems;LargeurDemandeeIn:Integer);
begin
LargeurDemandee:=LargeurDemandeeIn;
TabItems:=TabItemsIn;
FreeOnClose:=False;
inherited Create(AOwner);
end;

procedure Tpop_dlg_standard.FormCreate(Sender: TObject);
var
i:Integer;
NumeroLabel,NumeroInteger,NumeroReal,NumeroCheckBox,NumeroEdit,NumeroListBox,NumeroRadioGroup:Integer;
MargeHaute,MargeBasse,MargeGauche,MargeDroite,Separation,Hauteur:Integer;
Largeur,LargeurItem,SeparButton:Integer;
PosEsp,NbLigne:Integer;
Line:String;
begin
if TabItems<>nil then
   begin
   MargeHaute:=10;
   MargeBasse:=10;
   MargeGauche:=10;
   MargeDroite:=10;
   Separation:=5;

   // Recherche du nb d'items
   i:=1;
   while TabItems[i].Msg<>'' do inc(i);
   NbItems:=i-1;

   NbLabel:=0;
   NbInteger:=0;
   NbReal:=0;
   NbCheckBox:=0;
   NbEdit:=0;
   NbListBox:=0;
   NbRadioGroup:=0;
   // On compte les items
   for i:=1 to NbItems do
      begin
      case TabItems[i].TypeItem of
         tiLabel       :Inc(NbLabel);
         tiInteger     :begin Inc(NbLabel); Inc(NbInteger); end;
         tiReal        :begin Inc(NbLabel); Inc(NbReal); end;
         tiCheckBox    :Inc(NbCheckBox);
         tiEdit        :begin Inc(NbLabel); Inc(NbEdit); end;
         tiListBox     :begin Inc(NbLabel); Inc(NbListBox); end;
         tiRadioGroup  :begin Inc(NbRadioGroup); end;
         end;
      end;

   // Alloc des Items
   Getmem(TabLabel,SizeOf(TLabel)*NbLabel);
   Getmem(TabSpin,SizeOf(TSpinEdit)*NbInteger);
   Getmem(TabNbre,SizeOf(NbreEdit)*NbReal);
   Getmem(TabCheck,SizeOf(TCheckBox)*NbCheckBox);
   Getmem(TabEdit,SizeOf(TEdit)*NbEdit);
   Getmem(TabListBox,SizeOf(TListBox)*NbListBox);
   Getmem(TabRadioGroup,SizeOf(TRadioGroup)*NbRadioGroup);

   // Creation et Affichage des Items
   NumeroLabel:=1;
   NumeroInteger:=1;
   NumeroReal:=1;
   NumeroCheckBox:=1;
   NumeroEdit:=1;
   NumeroListBox:=1;
   NumeroRadioGroup:=1;   
   Hauteur:=Bevel1.Top+MargeHaute;
//   Largeur:=180;
   Largeur:=LargeurDemandee;
   for i:=1 to NbItems do
      begin
      case TabItems[i].TypeItem of
         tiLabel:begin
                 TabLabel^[NumeroLabel]:=TLabel.Create(Self);
                 TabLabel^[NumeroLabel].Caption:=TabItems[i].Msg;
                 TabLabel^[NumeroLabel].Left:=Bevel1.Left+MargeGauche;
                 LargeurItem:=TabLabel^[NumeroLabel].Left+TabLabel^[NumeroLabel].Width+MargeDroite+Bevel1.Left;
                 if LargeurItem>Largeur then Largeur:=LargeurItem;
                 TabLabel^[NumeroLabel].Top:=Hauteur;
                 Hauteur:=Hauteur+TabLabel^[NumeroLabel].Height;
                 if i<>NbItems then Hauteur:=Hauteur+Separation;
                 if TabItems[i].UnderLine then TabLabel^[NumeroLabel].Font.Style:=[fsUnderline];
                 InsertControl(TabLabel^[NumeroLabel]);
                 Inc(NumeroLabel);
                 end;
         tiInteger:begin
                   TabLabel^[NumeroLabel]:=TLabel.Create(Self);
                   TabLabel^[NumeroLabel].Caption:=TabItems[i].Msg;
                   TabLabel^[NumeroLabel].Left:=Bevel1.Left+MargeGauche;
                   TabSpin^[NumeroInteger]:=TSpinEdit.Create(Self);
                   TabSpin^[NumeroInteger].Value:=Round(TabItems[i].ValeurDefaut);
                   TabSpin^[NumeroInteger].Increment:=Round(TabItems[i].ValeurIncrement);
                   TabSpin^[NumeroInteger].Width:=50;
                   TabSpin^[NumeroInteger].MaxValue:=Round(TabItems[i].ValeurMax);
                   TabSpin^[NumeroInteger].MinValue:=Round(TabItems[i].ValeurMin);
                   TabSpin^[NumeroInteger].Left:=Bevel1.Left+MargeGauche+TabLabel^[NumeroLabel].Width+5;
                   LargeurItem:=TabSpin^[NumeroInteger].Left+TabSpin^[NumeroInteger].Width+MargeDroite+Bevel1.Left;
                   if LargeurItem>Largeur then Largeur:=LargeurItem;
                   TabSpin^[NumeroInteger].Top:=Hauteur;
                   TabLabel^[NumeroLabel].Top:=Hauteur+(TabSpin^[NumeroInteger].Height-TabLabel^[NumeroLabel].Height) div 2;
                   Hauteur:=Hauteur+TabSpin^[NumeroInteger].Height;
                   if i<>NbItems then Hauteur:=Hauteur+Separation;
                   InsertControl(TabLabel^[NumeroLabel]);
                   InsertControl(TabSpin^[NumeroInteger]);
                   Inc(NumeroLabel);
                   Inc(NumeroInteger);
                   end;
         tiReal:begin
                TabLabel^[NumeroLabel]:=TLabel.Create(Self);
                TabLabel^[NumeroLabel].Caption:=TabItems[i].Msg;
                TabLabel^[NumeroLabel].Left:=Bevel1.Left+MargeGauche;
                TabLabel^[NumeroLabel].Top:=Hauteur;
                TabNbre^[NumeroReal]:=NbreEdit.Create(Self);
                TabNbre^[NumeroReal].Text:=FloatToStr(TabItems[i].ValeurDefaut);
                TabNbre^[NumeroReal].Width:=50;
                TabNbre^[NumeroReal].ValMax:=TabItems[i].ValeurMax;
                TabNbre^[NumeroReal].ValMin:=TabItems[i].ValeurMin;
                TabNbre^[NumeroReal].Left:=Bevel1.Left+MargeGauche+TabLabel^[NumeroLabel].Width+5;
                LargeurItem:=TabNbre^[NumeroReal].Left+TabNbre^[NumeroReal].Width+MargeDroite+Bevel1.Left;
                if LargeurItem>Largeur then Largeur:=LargeurItem;
                TabNbre^[NumeroReal].Top:=Hauteur;
                TabLabel^[NumeroLabel].Top:=Hauteur+(TabNbre^[NumeroReal].Height-TabLabel^[NumeroLabel].Height) div 2;
                Hauteur:=Hauteur+TabNbre^[NumeroReal].Height;
                if i<>NbItems then Hauteur:=Hauteur+Separation;
                InsertControl(TabLabel^[NumeroLabel]);
                InsertControl(TabNbre^[NumeroReal]);
                Inc(NumeroReal);
                Inc(NumeroLabel);
                end;
         tiEdit:begin
                TabLabel^[NumeroLabel]:=TLabel.Create(Self);
                TabLabel^[NumeroLabel].Caption:=TabItems[i].Msg;
                TabLabel^[NumeroLabel].Left:=Bevel1.Left+MargeGauche;
                TabLabel^[NumeroLabel].Top:=Hauteur;
                TabEdit^[NumeroEdit]:=TEdit.Create(Self);
                if TabItems[i].IsPassWord then TabEdit^[NumeroEdit].PassWordChar:='*';
                TabEdit^[NumeroEdit].Text:=TabItems[i].ValeurStrDefaut;
                if TabItems[i].EditWidth=0 then TabEdit^[NumeroEdit].Width:=50
                else TabEdit^[NumeroEdit].Width:=TabItems[i].EditWidth;
                TabEdit^[NumeroEdit].Left:=Bevel1.Left+MargeGauche+TabLabel^[NumeroLabel].Width+5;
                LargeurItem:=TabEdit^[NumeroEdit].Left+TabEdit^[NumeroEdit].Width+MargeDroite+Bevel1.Left;
                if LargeurItem>Largeur then Largeur:=LargeurItem;
                TabEdit^[NumeroEdit].Top:=Hauteur;
                TabLabel^[NumeroLabel].Top:=Hauteur+(TabEdit^[NumeroEdit].Height-TabLabel^[NumeroLabel].Height) div 2;
                Hauteur:=Hauteur+TabEdit^[NumeroEdit].Height;
                if i<>NbItems then Hauteur:=Hauteur+Separation;
                if TabItems[i].ReadOnly then
                   begin
                   TabEdit^[NumeroEdit].ReadOnly:=True;
                   TabEdit^[NumeroEdit].Color:=clInfoBk;
                   end;
                InsertControl(TabLabel^[NumeroLabel]);
                InsertControl(TabEdit^[NumeroEdit]);
                Inc(NumeroEdit);
                Inc(NumeroLabel);
                end;
         tiCheckBox:begin
                    TabCheck^[NumeroCheckBox]:=TCheckBox.Create(Self);
                    TabCheck^[NumeroCheckBox].Caption:=TabItems[i].Msg;
                    TabCheck^[NumeroCheckBox].Width:=150;                    
                    TabCheck^[NumeroCheckBox].Checked:=TabItems[i].ValeurCheckDefaut;
                    if TabItems[i].ValeurDefaut=1 then
                       TabCheck^[NumeroCheckBox].Checked:=True;
                    TabCheck^[NumeroCheckBox].Left:=Bevel1.Left+MargeGauche;
                    LargeurItem:=TabCheck^[NumeroCheckBox].Left+TabCheck^[NumeroCheckBox].Width+MargeDroite+Bevel1.Left;
                    if LargeurItem>Largeur then Largeur:=LargeurItem;
                    TabCheck^[NumeroCheckBox].Top:=Hauteur;
                    Hauteur:=Hauteur+TabCheck^[NumeroCheckBox].Height;
                    if i<>NbItems then Hauteur:=Hauteur+Separation;
                    InsertControl(TabCheck^[NumeroCheckBox]);
                    Inc(NumeroCheckBox);
                    end;
         tiListBox:begin
                TabLabel^[NumeroLabel]:=TLabel.Create(Self);
                TabLabel^[NumeroLabel].Caption:=TabItems[i].Msg;
                TabLabel^[NumeroLabel].Left:=Bevel1.Left+MargeGauche;
                TabLabel^[NumeroLabel].Top:=Hauteur;
                LargeurItem:=TabLabel^[NumeroLabel].Left+TabLabel^[NumeroLabel].Width+MargeDroite+Bevel1.Left;
                if LargeurItem>Largeur then Largeur:=LargeurItem;
                Hauteur:=Hauteur+TabLabel^[NumeroLabel].Height+5;
                TabListBox^[NumeroListBox]:=TListBox.Create(Self);
                TabListBox^[NumeroListBox].MultiSelect:=TabItems[i].MultiSelect;
                TabListBox^[NumeroListBox].Width:=150;
//                TabListBox^[NumeroListBox].Left:=Bevel1.Left+MargeGauche+TabLabel^[NumeroLabel].Width+5;
                TabListBox^[NumeroListBox].Left:=Bevel1.Left+MargeGauche;
                LargeurItem:=TabListBox^[NumeroListBox].Left+TabListBox^[NumeroListBox].Width+MargeDroite+Bevel1.Left;
                if LargeurItem>Largeur then Largeur:=LargeurItem;
                TabListBox^[NumeroListBox].Top:=Hauteur;
                TabListBox^[NumeroListBox].Height:=100;
//                TabLabel^[NumeroLabel].Top:=Hauteur+(TabListBox^[NumeroListBox].Height-TabLabel^[NumeroLabel].Height) div 2;
                Hauteur:=Hauteur+TabListBox^[NumeroListBox].Height;
                if i<>NbItems then Hauteur:=Hauteur+Separation;
                InsertControl(TabLabel^[NumeroLabel]);
                InsertControl(TabListBox^[NumeroListBox]);
//                TabListBox^[NumeroListBox].Items:=StringToTString(TabItems[i].ValeurStrDefaut);
                Line:=TabItems[i].ValeurStrDefaut;
                PosEsp:=Pos('|',Line);
                while (PosEsp<>0) and (Length(Line)<>0) do
                   begin
                   TabListBox^[NumeroListBox].Items.Add(Copy(Line,1,PosEsp-1));
                   Delete(Line,1,PosEsp);
                   PosEsp:=Pos('|',Line);
                   end;

                Inc(NumeroListBox);
                Inc(NumeroLabel);
                end;
         tiRadioGroup:begin
                TabRadioGroup^[NumeroRadioGroup]:=TRadioGroup.Create(Self);
                TabRadioGroup^[NumeroRadioGroup].Caption:=TabItems[i].Msg;
                TabRadioGroup^[NumeroRadioGroup].Width:=150;
                TabRadioGroup^[NumeroRadioGroup].Left:=Bevel1.Left+MargeGauche;
                LargeurItem:=TabRadioGroup^[NumeroListBox].Left+TabRadioGroup^[NumeroListBox].Width+MargeDroite+Bevel1.Left;
                if LargeurItem>Largeur then Largeur:=LargeurItem;
                TabRadioGroup^[NumeroRadioGroup].Top:=Hauteur;
                // Comptage du nombre de ligne pour le calcul de la hauteur
                Line:=TabItems[i].ValeurStrDefaut;
                PosEsp:=Pos('|',Line);
                NbLigne:=0;
                while (PosEsp<>0) and (Length(Line)<>0) do
                   begin
                   Inc(NbLigne);
                   Delete(Line,1,PosEsp);
                   PosEsp:=Pos('|',Line);
                   end;
                TabRadioGroup^[NumeroRadioGroup].Height:=NbLigne*25;
                Hauteur:=Hauteur+TabRadioGroup^[NumeroRadioGroup].Height;
                if i<>NbItems then Hauteur:=Hauteur+Separation;
                InsertControl(TabRadioGroup^[NumeroRadioGroup]);
                Line:=TabItems[i].ValeurStrDefaut;
                PosEsp:=Pos('|',Line);
                while (PosEsp<>0) and (Length(Line)<>0) do
                   begin
                   TabRadioGroup^[NumeroRadioGroup].Items.Add(Copy(Line,1,PosEsp-1));
                   Delete(Line,1,PosEsp);
                   PosEsp:=Pos('|',Line);
                   end;
                TabRadioGroup^[NumeroRadioGroup].ItemIndex:=Round(TabItems[i].ValeurDefaut);
                Inc(NumeroRadioGroup);
                end;
         end;

      end;

   // Mise a jour des hauteurs
   ClientHeight:=Hauteur+MargeBasse+40;
   Bevel1.Height:=Hauteur+MargeBasse;
   BitBtn1.Top:=Hauteur+MargeBasse+10;
   BitBtn2.Top:=Hauteur+MargeBasse+10;

   // Mise a jour des largeurs
   if LargeurDemandee=0 then Width:=Largeur+8
   else Width:=LargeurDemandee+8;
   if NbCheckBox<>0 then
      for i:=1 to NbCheckBox do
         TabCheck^[i].Width:=Width-Bevel1.Left-MargeDroite-20;
   if NbRadioGroup<>0 then
      for i:=1 to NbRadioGroup do
         TabRadioGroup^[i].Width:=Width-Bevel1.Left-MargeDroite-20;
   Bevel1.Width:=Largeur-2*Bevel1.Left;
   SeparButton:=(Largeur-BitBtn1.Width-BitBtn2.Width) div 3;
   BitBtn1.Left:=SeparButton;
   BitBtn2.Left:=2*SeparButton+BitBtn1.Width;

   // Realignement à droite des champs d'entrée
   if NbInteger<>0 then
      for i:=1 to NbInteger do
         TabSpin^[i].Left:=Largeur-Bevel1.Left-MargeDroite-TabSpin^[i].Width;
   if NbReal<>0 then
      for i:=1 to NbReal do
         TabNbre^[i].Left:=Largeur-Bevel1.Left-MargeDroite-TabNbre^[i].Width;
   if NbEdit<>0 then
      for i:=1 to NbEdit do
         TabEdit^[i].Left:=Largeur-Bevel1.Left-MargeDroite-TabEdit^[i].Width;
   end;

end;

procedure Tpop_dlg_standard.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
i:Integer;
begin
if NbLabel<>0 then
   begin
   for i:=1 to NbLabel do
      begin
      RemoveControl(TabLabel^[i]);
      TabLabel[i].Free;
      end;
   Freemem(TabLabel,SizeOf(TLabel)*NbLabel);
   end;

if NbInteger<>0 then
   begin
   for i:=1 to NbInteger do
      begin
      RemoveControl(TabSpin^[i]);
      TabSpin[i].Free;
      end;
   Freemem(TabSpin,SizeOf(TSpinEdit)*NbInteger);
   end;

if NbReal<>0 then
   begin
   for i:=1 to NbReal do
      begin
      RemoveControl(TabNbre^[i]);
      TabNbre[i].Free;
      end;
   Freemem(TabNbre,SizeOf(NbreEdit)*NbReal);
   end;

if NbEdit<>0 then
   begin
   for i:=1 to NbEdit do
      begin
      RemoveControl(TabEdit^[i]);
      TabEdit[i].Free;
      end;
   Freemem(TabEdit,SizeOf(TEdit)*NbEdit);
   end;

if NbCheckBox<>0 then
   begin
   for i:=1 to NbCheckBox do
      begin
      RemoveControl(TabCheck^[i]);
      TabCheck[i].Free;
      end;
   Freemem(TabCheck,SizeOf(TCheckBox)*NbCheckBox);
   end;

if NbListBox<>0 then
   begin
   for i:=1 to NbListBox do
      begin
      RemoveControl(TabListBox^[i]);
      TabListBox[i].Free;
      end;
   Freemem(TabListBox,SizeOf(TListBox)*NbListBox);
   end;

if NbRadioGroup<>0 then
   begin
   for i:=1 to NbRadioGroup do
      begin
      RemoveControl(TabRadioGroup^[i]);
      TabRadioGroup[i].Free;
      end;
   Freemem(TabRadioGroup,SizeOf(TRadioGroup)*NbRadioGroup);
   end;

if FreeOnClose then Action:=caFree else Action:=caHide; 
end;

procedure Tpop_dlg_standard.BitBtn1Click(Sender: TObject);
var
NumeroLabel,NumeroInteger,NumeroReal,NumeroCheckBox,NumeroEdit,NumeroListBox,NumeroRadioGroup:Integer;
i,j:Integer;
begin
// On recupere les valeurs des Items
NumeroLabel:=1;
NumeroInteger:=1;
NumeroReal:=1;
NumeroCheckBox:=1;
NumeroEdit:=1;
NumeroListBox:=1;
NumeroRadioGroup:=1;
for i:=1 to NbItems do
   begin
   case TabItems[i].TypeItem of
      tiInteger:begin
                TabItems[i].ValeurSortie:=MyStrToFloat(TabSpin^[NumeroInteger].Text);
                Inc(NumeroInteger);
                end;
      tiReal:begin
             TabItems[i].ValeurSortie:=MyStrToFloat(TabNbre^[NumeroReal].Text);
             Inc(NumeroReal);
             Inc(NumeroLabel);
             end;
      tiEdit:begin
             TabItems[i].ValeurStrSortie:=TabEdit^[NumeroEdit].Text;
             Inc(NumeroEdit);
             Inc(NumeroLabel);
             end;
      tiCheckBox:begin
                 if TabCheck^[NumeroCheckBox].Checked then TabItems[i].ValeurSortie:=1
                 else TabItems[i].ValeurSortie:=0;
                 Inc(NumeroCheckBox);
                 Inc(NumeroLabel);
                 end;
      tiListBox:begin
                TabItems[i].ValeurStrSortie:='';
                for j:=0 to TabListBox[i].Items.Count-1 do
                   if TabListBox[NumeroListBox].Selected[j] then
                      TabItems[i].ValeurStrSortie:=TabItems[i].ValeurStrSortie+TabListBox[NumeroListBox].Items[j]+'|';
                Inc(NumeroListBox);
                Inc(NumeroLabel);
                end;
      tiRadioGroup:begin
                   TabItems[i].ValeurSortie:=TabRadioGroup[NumeroRadioGroup].ItemIndex;
                   Inc(NumeroRadioGroup);
                   end;
      end;
   end;
if CloseOnOK then Close;
ModalResult:=mrOK;
end;

procedure Tpop_dlg_standard.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

procedure Tpop_dlg_standard.SetOKButton(Text:string);
begin
BitBtn1.Caption:=Text;
end;

procedure Tpop_dlg_standard.HideUndo;
begin
BitBtn2.Visible:=False;
BitBtn1.Left:=(ClientWidth-BitBtn1.Width) div 2;
end;

procedure Tpop_dlg_standard.SetFreeOnCLose;
begin
FreeOnClose:=True;
FormStyle:=fsStayOnTop;
end;

procedure Tpop_dlg_standard.SetCloseOnOK;
begin
CloseOnOK:=True;
end;

procedure IniTabItems(TabItems:PTabItems);
var
   i:Integer;
begin
for i:=1 to NbMaxItems do
   with TabItems^[i] do
      begin
      Msg:='';
      ValeurDefaut:=0;
      ValeurIncrement:=1;
      ValeurCheckDefaut:=False;
      ValeurStrDefaut:='';
      ValeurSortie:=0;
      ValeurStrSortie:='';
      ValeurMin:=MinDouble;
      ValeurMax:=MaxDouble;
      MultiSelect:=False;
      IsPassWord:=False;
      UnderLine:=False;
      EditWidth:=50;
      ReadOnly:=False;
      end;
end;

procedure Tpop_dlg_standard.BitBtn2Click(Sender: TObject);
begin
Close;
end;

end.
