unit pu_vaisala;

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
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,U_class,
  StdCtrls, Buttons,math, Mask;

type
  Tpop_vaisala = class(TForm)
    GroupBox1: TGroupBox;
    jd1: TEdit;
    GroupBox2: TGroupBox;
    jd2: TEdit;
    btn_go: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ra1: TMaskEdit;
    ra2: TMaskEdit;
    Label4: TLabel;
    Label5: TLabel;
    de1: TMaskEdit;
    de2: TMaskEdit;
    Label6: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GroupBox3: TGroupBox;
    jd3: TEdit;
    rho: TEdit;
    SpeedButton3: TSpeedButton;
    Label9: TLabel;
    Label10: TLabel;
    memo: TMemo;
    Label7: TLabel;
    BitBtn1: TBitBtn;
    SaveDialog1: TSaveDialog;
    procedure btn_goClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pop_vaisala: Tpop_vaisala;

implementation

{$R *.DFM}

uses u_meca,
     u_file_io,
     u_general,
     pu_jour_julien,
     u_lang,
     u_hour_servers;

var e:telements;

procedure Tpop_vaisala.btn_goClick(Sender: TObject);
var
ra,dec,a_moins_r2:double;
begin
     vaisala (mystrtofloat(jd1.text), // 2427716.3441667, // JD 1e observation
              strtoalpha(ra1.text), // 0.7828,          // RA
              strtodelta(de1.text), // 5.5357778,       // DEC
              mystrtofloat(jd2.text), // 2427720.4472917, // JD 2e observation
              strtoalpha(ra2.text), // 0.7253833,       // RA
              strtodelta(de2.text), // 5.3975278,       // DEC
              mystrtofloat(jd3.text), // JD prediction
              mystrtofloat(rho.text),          // rho  (estimation de la distance en UA)
              ra,
              dec,
              a_moins_r2,
              e);

     // retours
     memo.lines.add('Jour julien : '+jd3.text+' = '+datetimetostr(jourjulientoheure(mystrtofloat(jd3.text)))); //nolang
     memo.lines.add('Rho         : '+rho.text); //nolang
     memo.lines.add('Alpha       : '+alphatostr(ra)); //nolang
     memo.lines.add('Delta       : '+deltatostr(dec)); //nolang
     memo.lines.add('A-R2        : '+floattostrf(a_moins_r2,fffixed,10,5)); //nolang

     memo.lines.add(lang('Argument du périhélie        : ')+floattostr(e.arg_peri)); //'Arg. of perihelion    : '
     memo.lines.add(lang('Excentricité                 : ')+floattostr(e.eccentricity)); //'Eccentricity          : '
     memo.lines.add(lang('Axe semi-majeur              : ')+floattostr(e.semi_axis)); //'Semi Major axis       : '
     memo.lines.add(lang('Inclinaison                  : ')+floattostr(e.inclination)); //'Inclination           : '
     memo.lines.add(lang('Longitude du noeud ascendant : ')+floattostr(e.lon_asc_node)); //'Lon of ascending node : '
     memo.lines.add(lang('Anomalie moyenne             : ')+floattostr(e.mean_anom)); //'Mean anomaly          : '
     memo.lines.add(lang('Vitesse moyenne journalière  : ')+floattostr(e.mean_daily)); //'Mean daily motion     : '
     memo.lines.add('------------------------------------------'); //nolang
end;


procedure Tpop_vaisala.SpeedButton1Click(Sender: TObject);
var julien:tpop_jour_julien;
begin
     julien:=tpop_jour_julien.create(application);
     julien.showmodal;
     jd1.text:=julien.julian_day.text;
end;

procedure Tpop_vaisala.SpeedButton2Click(Sender: TObject);
var julien:tpop_jour_julien;
begin
     julien:=tpop_jour_julien.create(application);
     julien.showmodal;
     jd2.text:=julien.julian_day.text;
end;





procedure Tpop_vaisala.SpeedButton3Click(Sender: TObject);
var julien:tpop_jour_julien;
begin
     julien:=tpop_jour_julien.create(application);
     julien.showmodal;
     jd3.text:=julien.julian_day.text;
end;



procedure Tpop_vaisala.BitBtn1Click(Sender: TObject);
var
p:p_critlist;
begin
      savedialog1.initialdir:=extractfilepath(application.exename)+'Asteroid'; //nolang
      savedialog1.filter:=lang('Fichier astéroïde TeleAuto|*.tea'); 
      savedialog1.defaultext:='tea'; //nolang
      if savedialog1.execute then
      begin
            new(p);
            p.nom:=copy(extractfilename(savedialog1.filename),1,length(extractfilename(savedialog1.filename))-4);
            p.numero:='0';
            p.date:=datetimetostr(GetHourDT);
            p.e:=floattostr(e.eccentricity);
            p.a:=floattostr(e.semi_axis);
            p.incl:=floattostr(e.inclination);
            p.node:=floattostr(e.lon_asc_node);
            p.peri:=floattostr(e.arg_peri);
            p.M:=floattostr(e.mean_anom);
            p.H:='0';
            p.G:='0';
            p.motion:=floattostr(e.mean_daily/86400);
            do_the_asteroid_file(p);
            dispose(p);
      end;
end;


procedure Tpop_vaisala.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

end.
