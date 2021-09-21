unit pu_dome;

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
  StdCtrls, HiResTim, IniFiles, ExtCtrls;

type
  Tpop_dome = class(TForm)
    StaticText1: TStaticText;
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  pop_dome: Tpop_dome;

implementation

uses u_lang,
     u_dome,
     pu_main,
     u_telescopes;

{$R *.DFM}

procedure Tpop_dome.FormShow(Sender: TObject);
var
   Ini:TMemIniFile;
   Path:string;
   Valeur:Integer;
begin
// Lit la pos
Path:=ExtractFilePath(Application.Exename);
Ini:=TMemIniFile.Create(Path+'TeleAuto.ini'); //nolang
try
Valeur:=StrToInt(Ini.ReadString('WindowsPos','DomeTop',IntToStr(Self.Top)));
if Valeur<>0 then Top:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','DomeLeft',IntToStr(Self.Left)));
if Valeur<>0 then Left:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','DomeWidth',IntToStr(Self.Width)));
if Valeur<>0 then Width:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','DomeHeight',IntToStr(Self.Height)));
if Valeur<>0 then Height:=Valeur;
finally
Ini.UpdateFile;
Ini.Free;
end;
Left:=Screen.Width-Width;
UpDateLang(Self);

if (Config.TypeDome<>0) and (Config.DomeBranche) then
   if Dome.IsOpen then StaticText1.Caption:=lang('Dome ouvert') else
      StaticText1.Caption:=lang('Dome fermé');

if (Config.TypeDome<>0) and (Config.DomeBranche) then
   begin
   pop_dome.Timer2.Enabled:=True;
   pop_dome.Timer1.Interval:=Round(Config.DomeCoordUpdate*1000);
   pop_dome.Timer1.Enabled:=True;
   end;

end;

procedure Tpop_dome.Button1Click(Sender: TObject);
begin
try
Dome.OpenDome;
except
on E:Exception do
   begin
   ShowMessage(E.Message);
   Config.DomeBranche:=False;
   pop_main.UpdateGUIDome;
   end;
end;
end;

procedure Tpop_dome.Button2Click(Sender: TObject);
begin
try
Dome.CloseDome;
except
on E:Exception do
   begin
   ShowMessage(E.Message);
   Config.DomeBranche:=False;
   pop_main.UpdateGUIDome;
   end;
end;
end;

procedure Tpop_dome.FormCreate(Sender: TObject);
begin
{if (Config.TypeDome<>0) and (Config.DomeBranche) then
   begin
   pop_dome.Timer2.Enabled:=True;
   pop_dome.Timer1.Interval:=Round(Config.DomeCoordUpdate*1000);
   pop_dome.Timer1.Enabled:=True;
   end;}
end;

procedure Tpop_dome.FormHide(Sender: TObject);
begin
pop_main.ToolButton8.Down:=False;
end;

procedure Tpop_dome.FormClose(Sender: TObject; var Action: TCloseAction);
var
   Ini:TMemIniFile;
   Path:string;
   Valeur:Integer;
begin
// Lit la pos
Path:=ExtractFilePath(Application.Exename);
Ini:=TMemIniFile.Create(Path+'TeleAuto.ini'); //nolang
try
Valeur:=StrToInt(Ini.ReadString('WindowsPos','DomeTop',IntToStr(Self.Top)));
if Valeur<>0 then Top:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','DomeLeft',IntToStr(Self.Left)));
if Valeur<>0 then Left:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','DomeWidth',IntToStr(Self.Width)));
if Valeur<>0 then Width:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','DomeHeight',IntToStr(Self.Height)));
if Valeur<>0 then Height:=Valeur;
finally
Ini.UpdateFile;
Ini.Free;
end;
end;

procedure Tpop_dome.Timer1Timer(Sender: TObject);
begin
if not Config.InPopConf then
   if Telescope.StoreCoordinates then
      if Config.GoodPos then
         begin
         Dome.SetAzimuth(Config.AzimuthScope);
         Dome.SetAltitude(Config.ScopeHauteur);
         end
end;

procedure Tpop_dome.Timer2Timer(Sender: TObject);
begin
try
if (Config.TypeDome<>0) and (Config.DomeBranche) then
   if Dome.IsOpen then StaticText1.Caption:=lang('Dome ouvert') else
      StaticText1.Caption:=lang('Dome fermé');

except
on E:Exception do
   begin
   ShowMessage(E.Message);
   Config.DomeBranche:=False;
   pop_main.UpdateGUIDome;
   end;
end;
end;

end.
