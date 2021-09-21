unit pu_skychart;

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
  ExtCtrls, SkyChart, ComCtrls, Menus;

type
  Tpop_skychart = class(TForm)
    SkyChart1: TSkyChart;
    StatusBar1: TStatusBar;
    PopupMenu1: TPopupMenu;
    Dplacerletlescopeici1: TMenuItem;
    Ralignerletlscopeici1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SkyChart1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Dplacerletlescopeici1Click(Sender: TObject);
    procedure SkyChart1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Ralignerletlscopeici1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
    OldX,OldY:Integer;

  public
    { Déclarations publiques }
    Signe:Integer;
    
    procedure DrawScope(Alpha,Delta:Double);
  end;

implementation

{$R *.DFM}

uses pu_main,
     u_general,
     u_telescopes,
     pu_scope,
     u_file_io,
     u_lang;

procedure Tpop_skychart.FormCreate(Sender: TObject);
begin
   Signe:=1;
   
   Width:=pop_main.ClientWidth-50;
   Height:=pop_main.ClientHeight-75;

   SkyChart1.Observatory.Latitude:=Config.Lat;
   SkyChart1.Observatory.Longitude:=Config.Long;
   SkyChart1.Observatory.TimeZone:=0; // Usage ?

   SkyChart1.GridEnabled:=True;

   SkyChart1.ChartCatalog.GSCpath:=Config.RepGSC;
   SkyChart1.ChartCatalog.Tycho2path:=Config.RepTycho2;
   SkyChart1.ChartCatalog.BSCpath:=Config.RepCatalogsBase+'\bsc'; //nolang
   SkyChart1.ChartCatalog.NGCpath:=Config.RepCatalogsBase+'\ngc'; //nolang
   Skychart1.ChartCatalog.SACpath:=config.RepCatalogsBase+'\sac'; //nolang
   SkyChart1.ChartCatalog.PGCpath:=Config.RepCatalogsBase+'\pgc'; //nolang
   Skychart1.ChartCatalog.StarCalalog:=BSC;
   Skychart1.ChartCatalog.StarLimit:=true;
   Skychart1.ChartCatalog.StarMagMax:=15;
   Skychart1.ChartCatalog.NebulaCalalog:=NGC;
   Skychart1.ChartCatalog.NebLimit:=true;
   Skychart1.ChartCatalog.NebMagMax:=15;
   Skychart1.ChartCatalog.NebDimMin:=0;

   Skychart1.ChartPosition.ProjPole:=pPolar;
   Skychart1.ChartPosition.Projection:=prTan;
   Skychart1.ChartPosition.Rotation:=0;

   Skychart1.SelColor:=coColor;
   Skychart1.ChartPosition.ra:=0;
   Skychart1.ChartPosition.dec:=0;
   Statusbar1.Panels[0].Text:=AlphaToStr(Skychart1.ChartPosition.ra)+' '+DeltaToStr(Skychart1.ChartPosition.dec);
   Skychart1.ChartPosition.FOV:=90;
   Skychart1.StarSize:=18;
   Skychart1.Draw;
end;

procedure Tpop_skychart.FormResize(Sender: TObject);
begin
   Skychart1.Draw;
end;

procedure Tpop_skychart.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure Tpop_skychart.SkyChart1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
   Alpha,Delta:Double;
begin
   SkyChart1.Projection1(X,Y,Alpha,Delta);
   Statusbar1.Panels[1].Text:=AlphaToStr(Alpha)+' '+DeltaToStr(Delta);
   OldX:=X;
   OldY:=Y;
end;

procedure Tpop_skychart.DrawScope(Alpha,Delta:Double);
var
   x,y:Integer;
begin
SkyChart1.Projection2(Alpha,Delta,x,y);

SkyChart1.Draw;
SkyChart1.Canvas.Brush.Style:=bsClear;
SkyChart1.Canvas.Pen.Color:=clWhite;
SkyChart1.Canvas.Pen.Mode:=pmCopy;
SkyChart1.Canvas.Pen.Style:=psSolid;
SkyChart1.Canvas.Pen.Width:=2;
SkyChart1.Canvas.Ellipse(x-10,y-10,x+10,y+10);
SkyChart1.Canvas.Ellipse(x-5,y-5,x+5,y+5);
SkyChart1.Canvas.MoveTo(x-15,y);
SkyChart1.Canvas.LineTo(x+15,y);
SkyChart1.Canvas.MoveTo(x,y-15);
SkyChart1.Canvas.LineTo(x,y+15);
end;

procedure Tpop_skychart.Dplacerletlescopeici1Click(Sender: TObject);
var
   Alpha,Delta:Double;
   Error:string;
begin
SkyChart1.Projection1(OldX,OldY,Alpha,Delta);
if Alpha>24 then Alpha:=Alpha-24;
if Alpha<0 then Alpha:=Alpha+24;

if not Telescope.Pointe(Alpha,Delta) then
   begin
   ShowMessage(lang('Le télescope ne veut pas pointer les coordonnées'));
   TelescopeErreurFatale;
   Exit;
   end;

Error:=Telescope.GetError;
if Error<>'' then
   MessageDlg(Error,mtError,[mbOk],0)
else
   begin
   if not Telescope.WaitPoint(Alpha,Delta) then
      begin
      WriteSpy('Le télescope n''est pas arrivé sur les coordonnées demandées');
      pop_Main.AfficheMessage(lang('Erreur'),
         'Le télescope n''est pas arrivé sur les coordonnées demandées');
      end
   else if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
   end;
end;

procedure Tpop_skychart.SkyChart1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   Alpha,Delta:Double;
begin
if Button=mbLeft then
   begin
   SkyChart1.Projection1(X,Y,Alpha,Delta);
   if Alpha>24 then Alpha:=Alpha-24;
   if Alpha<0 then Alpha:=Alpha+24;
   Skychart1.ChartPosition.ra:=Alpha;
   Skychart1.ChartPosition.dec:=Delta;
   Statusbar1.Panels[0].Text:=AlphaToStr(Alpha)+' '+DeltaToStr(Delta);
   Statusbar1.Panels[1].Text:=AlphaToStr(Alpha)+' '+DeltaToStr(Delta);
   Skychart1.Draw;
   end;
end;

procedure Tpop_skychart.Ralignerletlscopeici1Click(Sender: TObject);
var
   Alpha,Delta:Double;
begin
SkyChart1.Projection1(OldX,OldY,Alpha,Delta);
if Alpha>24 then Alpha:=Alpha-24;
if Alpha<0 then Alpha:=Alpha+24;

if not Telescope.Sync(Alpha,Delta) then
   begin
   WriteSpy(lang('Le télescope refuse de se synchroniser'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope refuse de se synchroniser'));
   end
else if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);
end;

procedure Tpop_skychart.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

end.
