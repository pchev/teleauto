unit u_dome;

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

uses Windows, Dialogs;

type

//******************************************************************************
//**************************        Dome Generique        **********************
//******************************************************************************

  TDome=class(TObject)
    private
    public
    // Fonctionnement
    constructor Create;
    procedure Open; virtual; abstract;
    procedure Close; virtual; abstract;
    function  IsConnectedAndOK:Boolean; virtual; abstract;
    procedure OpenDome; virtual; abstract;
    procedure CloseDome; virtual; abstract;
    function  IsOpen:Boolean; virtual; abstract;
    function  NeedCoordinates:Boolean; virtual; abstract;
    function  SetAzimuth(Azimuth:Double):Boolean; virtual; abstract;
    function  SetAltitude(Altitude:Double):Boolean; virtual; abstract;
    end;

//******************************************************************************
//**************************          Aucun Dome          **********************
//******************************************************************************

  TDomeNone=class(TDome)
    private
    DomeState:Boolean;
    public
    // Fonctionnement
    constructor Create;
    procedure Open; override;
    procedure Close; override;
    function  IsConnectedAndOK:Boolean; override;
    procedure OpenDome; override;
    procedure CloseDome; override;
    function  IsOpen:Boolean; override;
    function  NeedCoordinates:Boolean; override;
    function  SetAzimuth(Azimuth:Double):Boolean; override;
    function  SetAltitude(Altitude:Double):Boolean; override;
    end;

//******************************************************************************
//**************************         Dome Plugin          **********************
//******************************************************************************

  TIsConnectedAndOK = function:Boolean;                               cdecl;
  TOpenDome         = procedure;                                      cdecl;
  TCloseDome        = procedure;                                      cdecl;
  TIsOpen           = function:Boolean;                               cdecl;
  TNeedCoordinates  = function:Boolean;                               cdecl;
  TSetAzimuth       = function(Azimuth:Double):Boolean;               cdecl;
  TSetAltitude      = function(Altitude:Double):Boolean;              cdecl;
  TCloseI           = procedure;                                      cdecl;

var

  PluginIsConnectedAndOK:TIsConnectedAndOK;
  PluginOpenDome:TOpenDome;
  PluginCloseDome:TCloseDome;
  PluginIsOpen:TIsOpen;
  PluginNeedCoordinates:TNeedCoordinates;
  PluginSetAzimuth:TSetAzimuth;
  PluginSetAltitude:TSetAltitude;
  PluginClose:TCloseI;

type

  TDomePlugin=class(TDome)
    private
    PluginExiste:Boolean;
    public
    HandlePlugin:Integer;

    // Fonctionnement
    constructor Create;
    procedure Open; override;
    procedure Close; override;
    function  IsConnectedAndOK:Boolean; override;
    procedure OpenDome; override;
    procedure CloseDome; override;
    function  IsOpen:Boolean; override;
    function  NeedCoordinates:Boolean; override;
    function  SetAzimuth(Azimuth : Double):Boolean; override;
    function  SetAltitude(Altitude : Double):Boolean; override;
    end;

procedure DomeConnect;
procedure DomeDisconnect;

var
  Dome:TDome;

implementation

uses pu_main,
     u_class,
     u_lang,
     pu_dome;

//******************************************************************************
//**************** Interface camera de guidage de haut niveau ******************
//******************************************************************************
// Remplace pop_main.update_dome
// Choses à faire pour connecter le dome
procedure DomeConnect;
begin
   try
   try
   // Verification si un dome est branche
   Config.DomeBranche:=False;
   // Config du dome
   case Config.TypeDome of
      0:Dome:=TDomeNone.Create;
      1:begin
        Dome:=TDomePlugin.Create;
        Dome.Open;
        Config.DomeBranche:=Dome.IsConnectedAndOK
        end;
      end;
   except
   Config.DomeBranche:=False;
   end;

   finally
   pop_main.UpdateGUIDome;
   end;
end;

// Choses à faire pour déconnecter le dome
procedure DomeDisconnect;
begin
   try

//   if (Config.TypeDome<>0) and Config.DomeBranche then
      begin
      Dome.Close;
      Dome.Free;
      Config.DomeBranche:=False;
      pop_dome.Timer2.Enabled:=False;
      pop_dome.Timer1.Enabled:=False;

      if pop_dome.Visible then
         begin
         pop_dome.Hide;
         pop_main.ToolButton8.Down:=False;
         end;

      end;

   finally
   pop_main.UpdateGUIDome;
   end;
end;

//******************************************************************************
//**************************       Dome Generique       **********************
//******************************************************************************

constructor TDome.Create;
begin
   inherited Create;
end;

//******************************************************************************
//**************************          Aucun Dome          **********************
//******************************************************************************

constructor TDomeNone.Create;
begin
inherited Create;
end;

function TDomeNone.IsConnectedAndOK:Boolean;
begin
Result:=True;
end;

procedure TDomeNone.Open;
begin

end;

procedure TDomeNone.Close;
begin

end;

procedure TDomeNone.OpenDome;
begin
DomeState:=True;
end;

procedure TDomeNone.CloseDome;
begin
DomeState:=False;
end;

function TDomeNone.IsOpen:Boolean;
begin
Result:=DomeState;
end;

function TDomeNone.NeedCoordinates:Boolean;
begin
Result:=False;
end;

function TDomeNone.SetAzimuth(Azimuth:Double):Boolean;
begin
Result:=True;
end;

function TDomeNone.SetAltitude(Altitude:Double):Boolean;
begin
Result:=True;
end;

//******************************************************************************
//**************************         Dome Plugin          **********************
//******************************************************************************

constructor TDomePlugin.Create;
begin
PluginExiste:=True;
inherited Create;
HandlePlugin:=LoadLibrary(PChar(Config.DomePlugin));
if HandlePlugin<>0 then
   begin
   PluginIsConnectedAndOK         := TIsConnectedAndOK(GetProcAddress(HandlePlugin,'PluginIsConnectedAndOK'));                   //nolang
   PluginOpenDome                 := TOpenDome(GetProcAddress(HandlePlugin,'PluginOpenDome'));                                   //nolang
   PluginCloseDome                := TCloseDome(GetProcAddress(HandlePlugin,'PluginCloseDome'));                                 //nolang
   PluginIsOpen                   := TIsOpen(GetProcAddress(HandlePlugin,'PluginIsOpen'));                                       //nolang
   PluginNeedCoordinates          := TNeedCoordinates(GetProcAddress(HandlePlugin,'PluginNeedCoordinates'));                     //nolang

   PluginClose                    := TCloseI(GetProcAddress(HandlePlugin,'PluginClose'));                                        //nolang
   PluginSetAzimuth               := TSetAzimuth(GetProcAddress(HandlePlugin,'PluginSetAzimuth'));                               //nolang
   PluginSetAltitude              := TSetAltitude(GetProcAddress(HandlePlugin,'PluginSetAltitude'));                             //nolang

   end
else
   begin
   ShowMessage(lang('Librairie plugin introuvable'));
   PluginExiste:=False;
   end;
end;

function TDomePlugin.IsConnectedAndOK:Boolean;
begin
if PluginExiste then
   begin
   if HandlePlugin<>0 then Result:=PluginIsConnectedAndOK
   else Result:=False;
   end
else Result:=False;
end;

procedure TDomePlugin.Open;
begin

end;

procedure TDomePlugin.Close;
begin
PluginClose;
end;

procedure TDomePlugin.OpenDome;
begin
PluginOpenDome;
end;

procedure TDomePlugin.CloseDome;
begin
PluginCloseDome;
end;

function TDomePlugin.IsOpen:Boolean;
begin
Result:=PluginIsOpen;
end;

function TDomePlugin.NeedCoordinates:Boolean;
begin
Result:=PluginNeedCoordinates;
end;

function TDomePlugin.SetAzimuth(Azimuth:Double):Boolean;
begin
Result:=PluginSetAzimuth(Azimuth);
end;

function TDomePlugin.SetAltitude(Altitude:Double):Boolean;
begin
Result:=PluginSetAltitude(Altitude);
end;

end.
