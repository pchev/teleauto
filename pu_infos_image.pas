unit pu_infos_image;

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
  StdCtrls, ComCtrls, ExtCtrls, Spin, Editnbre, Mask, Buttons;

type
  Tpop_infos_image = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label7: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label8: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Edit1: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    Edit5: TEdit;
    Label14: TLabel;
    NbreEdit1: NbreEdit;
    Label15: TLabel;
    Label16: TLabel;
    mask_alpha: TMaskEdit;
    Mask_delta: TMaskEdit;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    NbreEdit2: NbreEdit;
    NbreEdit3: NbreEdit;
    Bevel1: TBevel;
    Label20: TLabel;
    Label21: TLabel;
    GroupBox1: TGroupBox;
    outLabel22: TLabel;
    outLabel23: TLabel;
    outLabel24: TLabel;
    outLabel25: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label30: TLabel;
    NbreEdit4: NbreEdit;
    Label31: TLabel;
    Bevel2: TBevel;
    Label22: TLabel;
    NbreEdit5: NbreEdit;
    Label23: TLabel;
    Label24: TLabel;
    NbreEdit6: NbreEdit;
    Label25: TLabel;
    Label32: TLabel;
    NbreEdit7: NbreEdit;
    Label33: TLabel;
    Label34: TLabel;
    NbreEdit8: NbreEdit;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Panel10: TPanel;
    Panel11: TPanel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    outPanel12: TPanel;
    outPanel13: TPanel;
    Label6: TLabel;
    Label41: TLabel;
    Panel9: TPanel;
    Label42: TLabel;
    Label43: TLabel;
    NbreEdit9: NbreEdit;
    NbreEdit10: NbreEdit;
    Label44: TLabel;
    Label45: TLabel;
    NbreEdit11: NbreEdit;
    Label46: TLabel;
    procedure NbreEdit1Change(Sender: TObject);
    procedure NbreEdit2Change(Sender: TObject);
    procedure NbreEdit3Change(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure DateTimePicker2Change(Sender: TObject);
    procedure outPanel12DblClick(Sender: TObject);
    procedure outPanel13DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DateTime:TDateTime;
    procedure UpdateEchelle;
  end;

implementation

{$R *.DFM}

uses u_meca,
     u_general,
     u_math,
     u_lang,
     u_class,
     pu_main;

procedure Tpop_infos_image.UpdateEchelle;
var
Focale,PixelX,PixelY:Double;
begin
if (NbreEdit1.Text<>'') and (NbreEdit1.Text<>'0') and  // Focale
   (NbreEdit2.Text<>'') and (NbreEdit2.Text<>'0') and  // Pixel X
   (NbreEdit3.Text<>'') and (NbreEdit3.Text<>'0') then // Pixel Y
      begin
      Focale:=MyStrToFloat(NbreEdit1.Text);
      PixelX:=MyStrToFloat(NbreEdit2.Text)*SpinEdit1.Value;
      PixelY:=MyStrToFloat(NbreEdit3.Text)*SpinEdit2.Value;
      if Focale<>0 then
         begin
         Panel10.Caption:=MyFloatToStr(1296000*ArcTan(PixelX/2000000/Focale*1000)/pi,3);
         Panel11.Caption:=MyFloatToStr(1296000*ArcTan(PixelY/2000000/Focale*1000)/pi,3);
         end
      else
         begin
         Panel10.Caption:='?';
         Panel11.Caption:='?';
         end
      end;
end;

procedure Tpop_infos_image.NbreEdit1Change(Sender: TObject);
begin
UpdateEchelle;
end;

procedure Tpop_infos_image.NbreEdit2Change(Sender: TObject);
begin
UpdateEchelle;
end;

procedure Tpop_infos_image.NbreEdit3Change(Sender: TObject);
begin
UpdateEchelle;
end;

procedure Tpop_infos_image.DateTimePicker1Change(Sender: TObject);
begin
outPanel12.Caption:=FloatToStr(HeureToJourJulien(Trunc(DateTimePicker1.Date)+Frac(DateTimePicker2.Time)));
outPanel13.Caption:=FloatToStr(Round(Frac(DateTimePicker2.Time)*24*100)/100);
end;

procedure Tpop_infos_image.DateTimePicker2Change(Sender: TObject);
begin
outPanel12.Caption:=FloatToStr(HeureToJourJulien(Trunc(DateTimePicker1.Date)+Frac(DateTimePicker2.Time)));
outPanel13.Caption:=FloatToStr(Round(Frac(DateTimePicker2.Time)*24*100)/100);
end;

procedure Tpop_infos_image.outPanel12DblClick(Sender: TObject);
begin
DateTimePicker1.Date:=DateTime;
DateTimePicker2.Time:=DateTime;
end;

procedure Tpop_infos_image.outPanel13DblClick(Sender: TObject);
begin
DateTimePicker1.DateTime:=DateTime;
DateTimePicker2.DateTime:=DateTime;
end;

procedure Tpop_infos_image.FormShow(Sender: TObject);
begin
UpdateEchelle;
DateTimePicker1.Date:=DateTime;
DateTimePicker2.Time:=DateTime;
DateTimePicker1.DateTime:=DateTime;
DateTimePicker2.DateTime:=DateTime;
outPanel12.Caption:=FloatToStr(HeureToJourJulien(Trunc(DateTimePicker1.Date)+Frac(DateTimePicker2.Time)));
outPanel13.Caption:=FloatToStr(Round(Frac(DateTimePicker2.Time)*24*100)/100);
{if NbreEdit11.Text='0' then
   begin
   NbreEdit11.Visible:=False;
   Label44.Visible:=False;
   Label45.Visible:=False;
   Label46.Visible:=False;
   end;} 

UpDateLang(Self);
end;

procedure Tpop_infos_image.SpinEdit1Change(Sender: TObject);
begin
UpdateEchelle;
end;

procedure Tpop_infos_image.SpinEdit2Change(Sender: TObject);
begin
UpdateEchelle;
end;

procedure Tpop_infos_image.FormCreate(Sender: TObject);
begin
Mask_Alpha.EditMask:='!90'+Config.SeparateurHeuresMinutesAlpha+'00'+Config.SeparateurMinutesSecondesAlpha+'00'+ //nolang
   Config.UnitesSecondesAlpha+';1;_'; //nolang
Mask_Delta.EditMask:='!#90'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
   Config.UnitesSecondesDelta+';1;_'; //nolang
end;

end.
