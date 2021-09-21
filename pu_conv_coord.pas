unit pu_conv_coord;

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
  StdCtrls, Mask, ExtCtrls, ComCtrls;

type
  Tpop_conv_coord = class(TForm)
    GroupBox1: TGroupBox;
    mask_alpha: TMaskEdit;
    Label17: TLabel;
    Label22: TLabel;
    Mask_delta: TMaskEdit;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit2: TMaskEdit;
    MaskEdit1: TMaskEdit;
    GroupBox3: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses pu_rapport,
     u_general,
     u_meca,
     pu_main,
     u_lang,
     u_hour_servers;

{$R *.DFM}

procedure Tpop_conv_coord.Button1Click(Sender: TObject);
var
Alpha,Delta,Azimuth,Hauteur,Latitude,Longitude,AngleHoraire,TempsSideralLocal:Double;
Rapport:tpop_rapport;
DateTime:TDateTime;
begin
Latitude:= StrToDelta(MaskEdit1.Text);
Longitude:=StrToDelta(MaskEdit2.Text);

Rapport:=tpop_rapport.Create(Application);
Rapport.Show;
try

if RadioGroup1.ItemIndex=0 then
   begin
   Alpha:=StrToAlpha(mask_alpha.text);
   Delta:=StrToDelta(mask_delta.text);
   end;
if RadioGroup1.ItemIndex=1 then
   begin
   Azimuth:=StrToDegrees(mask_alpha.text);
   Hauteur:=StrToDelta(mask_delta.text);
   end;

if RadioGroup2.ItemIndex=0 then
   begin
   DateTime:=Trunc(DateTimePicker1.Date)+Frac(DateTimePicker2.Time);
   GetAlphaDeltaFromHor(DateTime,Hauteur,Azimuth,Latitude,Longitude,Alpha,Delta);
   AngleHoraire:=GetHourAngle(DateTime,Alpha,Longitude);
   TempsSideralLocal:=LocalSidTim(DateTime,Longitude);
   Rapport.AddLine(lang('Longitude = ')+DeltaToStr(Longitude));
   Rapport.AddLine(lang('Latitude = ')+DeltaToStr(Latitude));
   Rapport.AddLine(lang('Date = ')+DateToStr(DateTime));
   Rapport.AddLine(lang('Heure = ')+TimeToStr(DateTime));
   Rapport.AddLine(lang('Temps sidéral local = ')+TimeToStr(TempsSideralLocal/15/24));
   Rapport.AddLine('');
   Rapport.AddLine(lang('Coordonnées horizontales de départ'));
   Rapport.AddLine(lang('Azimuth = ')+DeltaToStr(Azimuth));
   Rapport.AddLine(lang('Hauteur = ')+DeltaToStr(Hauteur));
   Rapport.AddLine('');
   Rapport.AddLine(lang('Coordonnées équatoriales d''arrivée'));
   Rapport.AddLine('Alpha = '+AlphaToStr(Alpha)); //nolang
   Rapport.AddLine('Delta = '+DeltaToStr(Delta)); //nolang
   Rapport.AddLine('');
   Rapport.AddLine(lang('Angle horaire = ')+TimeToStr(AngleHoraire/15/24));
   end;
if RadioGroup2.ItemIndex=1 then
   begin
   DateTime:=Trunc(DateTimePicker1.Date)+Frac(DateTimePicker2.Time);
   Hauteur:=GetElevation(DateTime,Alpha,Delta,Latitude,Longitude);
   Azimuth:=GetAzimuth(DateTime,Alpha,Delta,Latitude,Longitude);
   AngleHoraire:=GetHourAngle(DateTime,Alpha,Longitude);
   TempsSideralLocal:=LocalSidTim(DateTime,Longitude);
   Rapport.AddLine(lang('Longitude = ')+DeltaToStr(Longitude));
   Rapport.AddLine(lang('Latitude = ')+DeltaToStr(Latitude));
   Rapport.AddLine(lang('Date = ')+DateToStr(DateTime));
   Rapport.AddLine(lang('Heure = ')+TimeToStr(DateTime));
   Rapport.AddLine(lang('Temps sidéral local = ')+TimeToStr(TempsSideralLocal/15/24));
   Rapport.AddLine('');
   Rapport.AddLine(lang('Coordonnées équatoriales de départ'));
   Rapport.AddLine('Alpha = '+mask_alpha.text); //nolang
   Rapport.AddLine('Delta = '+mask_delta.text); //nolang
   Rapport.AddLine('');
   Rapport.AddLine(lang('Coordonnées horizontales d''arrivée'));
   Rapport.AddLine(lang('Azimuth = ')+DeltaToStr(Azimuth));
   Rapport.AddLine(lang('Hauteur = ')+DeltaToStr(Hauteur));
   Rapport.AddLine('');
   Rapport.AddLine(lang('Angle horaire = ')+TimeToStr(AngleHoraire/15/24));
   end;

finally
Rapport.Quitter.Enabled:=True;
Rapport.BitBtn1.Enabled:=True;
Rapport.BitBtn2.Enabled:=True;
end;
end;

procedure Tpop_conv_coord.RadioGroup1Click(Sender: TObject);
begin
if RadioGroup1.ItemIndex=0 then
   begin
//   mask_alpha.EditMask:='!90h00m00s;1;_';          //nolang
   Mask_Alpha.EditMask:='!90'+Config.SeparateurHeuresMinutesAlpha+'00'+Config.SeparateurMinutesSecondesAlpha+'00'+ //nolang
      Config.UnitesSecondesAlpha+';1;_'; //nolang
   Mask_Delta.EditMask:='!#90'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
      Config.UnitesSecondesDelta+';1;_'; //nolang
   Mask_Alpha.Text:='__'+Config.SeparateurHeuresMinutesAlpha+'__'+Config.SeparateurMinutesSecondesAlpha+'__'+ //nolang
      Config.UnitesSecondesAlpha; //nolang
   Mask_Delta.Text:='___'+Config.SeparateurDegresMinutesDelta+'__'+Config.SeparateurMinutesSecondesDelta+'__'+ //nolang
      Config.UnitesSecondesDelta; //nolang
//   mask_alpha.Text:='__:__:__';                   //nolang
//   mask_delta.Text:='___°__''__"';                  //nolang
   RadioGroup2.ItemIndex:=1;
   Label17.Caption:='Alpha'; //nolang
   Label22.Caption:='Delta'; //nolang
   end;
if RadioGroup1.ItemIndex=1 then
   begin
//   mask_alpha.EditMask:='!#90d00m00s;1;_';         //nolang
   Mask_Alpha.EditMask:='!#90'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
      Config.UnitesSecondesDelta+';1;_'; //nolang
   Mask_Delta.EditMask:='!#90'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
      Config.UnitesSecondesDelta+';1;_'; //nolang
   Mask_Alpha.Text:='___'+Config.SeparateurDegresMinutesDelta+'__'+Config.SeparateurMinutesSecondesDelta+'__'+ //nolang
      Config.UnitesSecondesDelta; //nolang
   Mask_Delta.Text:='___'+Config.SeparateurDegresMinutesDelta+'__'+Config.SeparateurMinutesSecondesDelta+'__'+ //nolang
      Config.UnitesSecondesDelta; //nolang
//   mask_alpha.Text:='___:__:__';                  //nolang
//   mask_delta.Text:='___°__''__"';                  //nolang
   RadioGroup2.ItemIndex:=0;
   Label17.Caption:=lang('Azimuth');
   Label22.Caption:=lang('Hauteur');
   end;
end;

procedure Tpop_conv_coord.Button2Click(Sender: TObject);
begin
Close;
end;

procedure Tpop_conv_coord.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure Tpop_conv_coord.FormCreate(Sender: TObject);
var
   DateTime:TDateTime;
   Year,Month,Day,Hour,Min,Sec,MSec:Word;
begin
MaskEdit1.EditMask:='!#90'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
   Config.UnitesSecondesDelta+';1;_'; //nolang
MaskEdit2.EditMask:='!#90'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
   Config.UnitesSecondesDelta+';1;_'; //nolang

Mask_Alpha.EditMask:='!90'+Config.SeparateurHeuresMinutesAlpha+'00'+Config.SeparateurMinutesSecondesAlpha+'00'+ //nolang
   Config.UnitesSecondesAlpha+';1;_'; //nolang
Mask_Delta.EditMask:='!#90'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
   Config.UnitesSecondesDelta+';1;_'; //nolang

MaskEdit2.Text:=DeltaToStr(config.Long);
MaskEdit1.Text:=DeltaToStr(config.Lat);
DateTime:=GetHourDT;
DateTimePicker1.Date:=DateTime;
DateTimePicker2.Time:=DateTime;
end;

procedure Tpop_conv_coord.RadioGroup2Click(Sender: TObject);
begin
if RadioGroup2.ItemIndex=0 then RadioGroup1.ItemIndex:=1;
if RadioGroup2.ItemIndex=1 then RadioGroup1.ItemIndex:=0;
end;

procedure Tpop_conv_coord.Button3Click(Sender: TObject);
var
   DateTime:TDateTime;
begin
DateTime:=GetHourDT;
DateTimePicker1.DateTime:=Trunc(DateTime);
DateTimePicker2.DateTime:=Frac(DateTime);
end;

procedure Tpop_conv_coord.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

end.
