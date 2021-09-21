unit pu_catalogs;

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

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs;

type
  Tpop_select_cat = class(TForm)
    outOKBtn: TButton;
    CancelBtn: TButton;
    SrcList: TListBox;
    DstList: TListBox;
    SrcLabel: TLabel;
    DstLabel: TLabel;
    IncludeBtn: TSpeedButton;
    outIncAllBtn: TSpeedButton;
    ExcludeBtn: TSpeedButton;
    outExAllBtn: TSpeedButton;
    procedure IncludeBtnClick(Sender: TObject);
    procedure ExcludeBtnClick(Sender: TObject);
    procedure outIncAllBtnClick(Sender: TObject);
    procedure ExcAllBtnClick(Sender: TObject);
    procedure MoveSelected(List: TCustomListBox; Items: TStrings);
    procedure SetItem(List: TListBox; Index: Integer);
    function  GetFirstSelection(List: TCustomListBox): Integer;
    procedure SetButtons;
    procedure close_catalogs(Sender: TObject; var Action: TCloseAction);
    procedure SrcListDblClick(Sender: TObject);
    procedure DstListDblClick(Sender: TObject);
    procedure cbo_schemeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses u_lang,
     pu_main;

procedure Tpop_select_cat.IncludeBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(SrcList);
  MoveSelected(SrcList, DstList.Items);
  SetItem(SrcList, Index);
end;

procedure Tpop_select_cat.ExcludeBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(DstList);
  MoveSelected(DstList, SrcList.Items);
  SetItem(DstList, Index);
end;

procedure Tpop_select_cat.outIncAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to SrcList.Items.Count - 1 do
    DstList.Items.AddObject(SrcList.Items[I],
      SrcList.Items.Objects[I]);
  SrcList.Items.Clear;
  SetItem(SrcList, 0);
end;

procedure Tpop_select_cat.ExcAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to DstList.Items.Count - 1 do
    SrcList.Items.AddObject(DstList.Items[I], DstList.Items.Objects[I]);
  DstList.Items.Clear;
  SetItem(DstList, 0);
end;

procedure Tpop_select_cat.MoveSelected(List: TCustomListBox; Items: TStrings);
var
  I: Integer;
begin
  for I := List.Items.Count - 1 downto 0 do
    if List.Selected[I] then
    begin
      Items.AddObject(List.Items[I], List.Items.Objects[I]);
      List.Items.Delete(I);
    end;
end;

procedure Tpop_select_cat.SetButtons;
var
  SrcEmpty, DstEmpty: Boolean;
begin
  SrcEmpty := SrcList.Items.Count = 0;
  DstEmpty := DstList.Items.Count = 0;
  IncludeBtn.Enabled := not SrcEmpty;
  outIncAllBtn.Enabled := not SrcEmpty;
  ExcludeBtn.Enabled := not DstEmpty;
  outExAllBtn.Enabled := not DstEmpty;
end;

function Tpop_select_cat.GetFirstSelection(List: TCustomListBox): Integer;
begin
  for Result := 0 to List.Items.Count - 1 do
    if List.Selected[Result] then Exit;
  Result := LB_ERR;
end;

procedure Tpop_select_cat.SetItem(List: TListBox; Index: Integer);
var
  MaxIndex: Integer;
begin
  with List do
  begin
    SetFocus;
    MaxIndex := List.Items.Count - 1;
    if Index = LB_ERR then Index := 0
    else if Index > MaxIndex then Index := MaxIndex;
    Selected[Index] := True;
  end;
  SetButtons;
end;


procedure Tpop_select_cat.close_catalogs(Sender: TObject;
  var Action: TCloseAction);
begin
     action:=cafree;
end;

procedure Tpop_select_cat.SrcListDblClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(SrcList);
  MoveSelected(SrcList, DstList.Items);
  SetItem(SrcList, Index);
end;


procedure Tpop_select_cat.DstListDblClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(dstList);
  MoveSelected(dstList, srcList.Items);
  SetItem(dstList, Index);
end;




procedure Tpop_select_cat.cbo_schemeChange(Sender: TObject);
begin
     { todo : creer des groupes de catalogues et les charger dans dstlist}
end;

procedure Tpop_select_cat.FormCreate(Sender: TObject);
begin
     //ini:=tMeminifile.create(application.exename)+'teleauto.ini'; //nolang

   // loader dynamiquement la liste en fonction des catalogues installes
   if Config.CatGSCCPresent then SrcList.Items.Add('GSC');    //nolang
   if Config.CatMCTPresent then begin
                                SrcList.Items.Add('MicroCat (GSC)');       //nolang
                                SrcList.Items.Add('MicroCat (GSC+Tycho)'); //nolang
                                SrcList.Items.Add('MicroCat (GSC+Tycho+USNO)'); //nolang
                                end;
   if Config.CatNGCPresent then SrcList.Items.Add('NGC');     //nolang
   if Config.CatPGCPresent then SrcList.Items.Add('PGC');     //nolang
   if Config.CatRC3Present then SrcList.Items.Add('RC3');     //nolang
   if Config.CatTY2Present then SrcList.Items.Add('Tycho2');  //nolang
   if Config.CatUSNOPresent then SrcList.Items.Add('USNO');   //nolang
   //Ini.UpdateFile;
   //ini.free;
end;

procedure Tpop_select_cat.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

end.
