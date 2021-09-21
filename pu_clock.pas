unit pu_clock;

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
  ExtCtrls, StdCtrls, Buttons, moon;

type
  Tpop_clock = class(TForm)
    Timer1: TTimer;
    outmemo: TMemo;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cb_current: TCheckBox;
    cb_gmt: TCheckBox;
    cb_lst: TCheckBox;
    cb_gst: TCheckBox;
    cb_julian: TCheckBox;
    lon: TEdit;
    Label1: TLabel;
    cb_julian_tu: TCheckBox;
    Moon: TMoon;
    Label2: TLabel;
    moon_info: TEdit;
    procedure refresh(Sender: TObject);
    procedure formclose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure formcreate(Sender: TObject);
    procedure refresh_moon(dttm:tdatetime);
    procedure FormShow(Sender: TObject);

    
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  pop_clock: Tpop_clock;

implementation

uses u_general,
     u_meca,
     u_class,
     pu_main,
     u_lang,
     u_hour_servers;

{$R *.DFM}




procedure Tpop_clock.refresh(Sender: TObject);

// Calcul de la date, heure et temps sideral local, rafraichi chaque seconde
var
hour,min,sec,msec,year,month,day:word;
longitude,jday,sdh,sdm,sds, gst_num,lst_num:double;
current,julian,julian_tu,gmt,gst,lst,Strsdh,Strsdm,Strsds,Strhour,Strmin,Strsec:string;
local, GMTtime :tdatetime;
SavePCMoinsTU:Integer;
begin
     if (lon.text='') then longitude:=0 else longitude:=mystrtofloat(lon.text);
     outmemo.lines.clear;
     SavePCMoinsTU:=config.PCMoinsTU;
     config.PCMoinsTU:=0;
     local:=GetHourDT;
     config.PCMoinsTU:=SavePCMoinsTU;
     gmttime:=GetHourDT;
     refresh_moon(now);
     // heure locale
     if cb_current.checked then
     begin
          decodedate(local,year,month,day);
          decodetime(local,hour,min,sec,msec);
          Strhour:=inttostr(hour);
          if Length(Strhour)=1 then Strhour:='0'+Strhour;
          Strmin:=inttostr(min);
          if Length(Strmin)=1 then Strmin:='0'+Strmin;
          Strsec:=inttostr(sec);
          if Length(Strsec)=1 then Strsec:='0'+Strsec;
          current:=Strhour+':'+Strmin+':'+Strsec;
     end;
     // heure TU
     if cb_gmt.checked then
     begin
          decodedate(gmttime,year,month,day);
          decodetime(gmttime,hour,min,sec,msec);
          Strhour:=inttostr(hour);
          if Length(Strhour)=1 then Strhour:='0'+Strhour;
          Strmin:=inttostr(min);
          if Length(Strmin)=1 then Strmin:='0'+Strmin;
          Strsec:=inttostr(sec);
          if Length(Strsec)=1 then Strsec:='0'+Strsec;
          GMT:=Strhour+':'+Strmin+':'+Strsec;
     end;
     // JJ Local
     if cb_julian.checked then
     begin
          jday:=HeureToJourJulien(local);
          julian:=floattostrf(jday,fffixed,15,5);
     end;
     // JJ TU
     if cb_julian_tu.Checked then
     begin
          jday:=HeureToJourJulien(gmttime);
          julian_tu:=floattostrf(jday,fffixed,15,5);
     end;
     // TS greenwich
     if (cb_gst.checked) then
     begin
//          jday:=HeureToJourJulien(local);
//          gst_num:=sidtim(jday,0);
          gst_num:=LocalSidTim(gmttime,0)/15;
          if gst_num > 24 then gst_num:=gst_num-24;
          sdh:=trunc(gst_num);
          sdm:=(gst_num-sdh)*60;
          sds:=(sdm-trunc(sdm))*60;
          sdm:=trunc(sdm);
          sds:=trunc(sds);
          Strsdh:=floattostr(sdh);
          if Length(Strsdh)=1 then Strsdh:='0'+Strsdh;
          Strsdm:=floattostr(sdm);
          if Length(Strsdm)=1 then Strsdm:='0'+Strsdm;
          Strsds:=floattostr(sds);
          if Length(Strsds)=1 then Strsds:='0'+Strsds;
          gst:=Strsdh+':'+Strsdm+':'+Strsds;
     end;
     // TS local
     if (cb_lst.Checked) then
     begin
//          jday:=HeureToJourJulien(gmttime);
          lst_num:=LocalSidTim(local,longitude)/15;
          if lst_num > 24 then lst_num := lst_num-24;
          sdh:=trunc(lst_num);
          sdm:=(lst_num-sdh)*60;
          sds:=(sdm-trunc(sdm))*60;
          sdm:=trunc(sdm);
          sds:=trunc(sds);
          Strsdh:=floattostr(sdh);
          if Length(Strsdh)=1 then Strsdh:='0'+Strsdh;
          Strsdm:=floattostr(sdm);
          if Length(Strsdm)=1 then Strsdm:='0'+Strsdm;
          Strsds:=floattostr(sds);
          if Length(Strsds)=1 then Strsds:='0'+Strsds;
          lst:=Strsdh+':'+Strsdm+':'+Strsds;
     end;

     if cb_current.checked then outmemo.lines.add(lang('Heure Locale        : ')+current);
     if cb_lst.checked     then outmemo.lines.add(lang('Temps Sideral Local : ')+lst);
     if cb_julian.checked  then outmemo.lines.add(lang('Jour Julien Local   : ')+julian);
     if cb_gmt.checked     then outmemo.lines.add(lang('Temps Universel     : ')+gmt);
     if cb_gst.checked     then outmemo.lines.add(lang('Temps Sideral (TU)  : ')+gst);
     if cb_julian_tu.checked then outmemo.lines.add(lang('Jour Julien (TU)    : ')+julian_tu);

end;


procedure Tpop_clock.formclose(Sender: TObject;
  var Action: TCloseAction);
begin
	action:=cafree;
end;

procedure Tpop_clock.BitBtn2Click(Sender: TObject);
begin
     close;
     Timer1.Enabled:=False;
end;

procedure Tpop_clock.BitBtn1Click(Sender: TObject);
begin
     if height>200 then height := 120 else height:=264;
end;

procedure Tpop_clock.formcreate(Sender: TObject);
var
   SavePCMoinsTU:Integer;
   Year,Month,Day,Hour,Min,Sec,MSec:Word;
begin
     height:=120;
     lon.text:=floattostrf(config.long,fffixed,10,5);
     moon.date:=GetHourDT;
end;


procedure tpop_clock.refresh_moon(dttm:tdatetime);
var
az,ha,phs:double;
begin
   get_moon_position(dttm,config.long,config.lat,az,ha);
   phs:=current_phase(dttm);
   moon_info.text:='Az:'+floattostrf(az,fffixed,10,1) //nolang
      +' Alt:'+floattostrf(ha,fffixed,10,1)+ //nolang
      ' Phs:'+floattostrf(phs*100,fffixed,10,1)+'%';  //nolang
end;




procedure Tpop_clock.FormShow(Sender: TObject);
begin
UpDateLang(Self);
Timer1.Enabled:=True;
end;

end.
