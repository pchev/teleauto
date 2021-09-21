unit pu_calib_Astrom;

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
  StdCtrls, Buttons, Editnbre, Mask, ExtCtrls, Spin;

type
  Tpop_calib_astrom = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    NbreEdit1: NbreEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    mask_alpha: TMaskEdit;
    Label5: TLabel;
    Mask_delta: TMaskEdit;
    outListBox1: TListBox;
    NbreEdit2: NbreEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    NbreEdit3: NbreEdit;
    Label8: TLabel;
    CheckBox1: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  pop_calib_astrom: Tpop_calib_astrom;

implementation

{$R *.DFM}

uses
   pu_main,
   u_lang;

procedure Tpop_calib_astrom.FormShow(Sender: TObject);
begin
   if Config.CatGSCCPresent then outListBox1.Items.Add('GSC');    //nolang
   if Config.CatUSNOPresent then outListBox1.Items.Add('USNO');   //nolang
   if Config.CatTY2Present then outListBox1.Items.Add('Tycho2');  //nolang
   if Config.CatMCTPresent then outListBox1.Items.Add('MicroCat'); //nolang
   if Config.CatBSCPresent then outListBox1.Items.Add('BSC');      //nolang
   if outListBox1.Items.Count<>0 then
      outListBox1.Selected[0]:=True;
   UpdateLang(Self);
end;

procedure Tpop_calib_astrom.FormCreate(Sender: TObject);
begin
   Mask_Alpha.EditMask:='!90'+Config.SeparateurHeuresMinutesAlpha+'00'+Config.SeparateurMinutesSecondesAlpha+'00'+ //nolang
      Config.UnitesSecondesAlpha+';1;_'; //nolang
   Mask_Delta.EditMask:='!#90'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
      Config.UnitesSecondesDelta+';1;_'; //nolang
end;

end.
