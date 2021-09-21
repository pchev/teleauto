library PluginTestDome;

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

{ Remarque importante concernant la gestion de m�moire des DLL : ShareMem doit �tre
  la premi�re unit� de la clause USES de votre biblioth�que ET de votre projet
  (s�lectionnez Projet-Voir source) si votre DLL exporte des proc�dures ou des
  fonctions qui passent des cha�nes comme param�tres ou r�sultats de fonctions.
  Ceci s'applique � toutes les cha�nes pass�es de et vers votre DLL - m�me celles
  qui sont imbriqu�es dans des enregistrements et classes. ShareMem est l'unit� d'interface pour
  le gestionnaire de m�moire partag�e BORLNDMM.DLL, qui doit �tre d�ploy� avec
  vos DLLs. Pour �viter d'utiliser BORLNDMM.DLL, passez les informations de cha�nes
  avec des param�tres PChar ou ShortString.}

uses
  SysUtils,
  Classes;


var
   DomeIsOpen:Boolean; // The state of the dome : True if open / False if closed

{$R *.RES}

function PluginIsConnectedAndOK:Boolean; cdecl;
// This function must test if the dome is connected and working correctly and return
// true is it is the case, false else
// It is called by TeleAuto at every connection of the dome
begin
// Allways true for the virtual dome
Result:=True;
end;

procedure PluginOpenDome; cdecl;
// This function must execute the commands to open the dome
// It is called by TeleAuto when the user clic on the button 'Open' of the dome pad
begin
// Put here the commands to open the dome
DomeIsOpen:=True;
end;

procedure PluginCloseDome; cdecl;
// This function must execute the commands to close the dome
// It is called by TeleAuto when the user clic on the button 'Close' of the dome pad
begin
// Put here the commands to close the dome
DomeIsOpen:=False;
end;

function PluginIsOpen:Boolean; cdecl;
// This function is used to know the state  of the dome
// It must return True if the  dome is open and False if the dome is closed
// It is called once every second by TeleAuto to update the dome state in the dome pad
begin
Result:=DomeIsOpen;
end;

// these three procedures have been added to allow the position of the dome opening
// to be controlled from TeleAuto.

function PluginNeedCoordinates:Boolean; cdecl;
// True if the dome position can be controled
begin
Result:=True;
end;

function PluginSetAzimuth(Azimuth:Double):Boolean; cdecl;
// Sets the azimuth of the dome opening to the value specified in degrees
// It must return True if the dome accepted it
begin
Result:=True;
end;

function PluginSetAltitude(Altitude:Double):Boolean; cdecl;
// Sets the altitude of the dome opening
// It must return True if the dome accepted it
begin
Result:=True;
end;

procedure PluginClose; cdecl;
// This function is called when the user disconnect the dome or quit TeleAuto
// Here you can put code to close the dome and switch it off
begin
end;

exports

PluginIsConnectedAndOK,
PluginOpenDome,
PluginCloseDome,
PluginIsOpen,
PluginNeedCoordinates,
PluginSetAzimuth,
PluginSetAltitude,
PluginClose;

begin
end.
