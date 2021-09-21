library PluginTestFocuser;

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

uses
  SysUtils, Classes, Types;



var
   NomCom:PChar;                         // Name of the com port (COM1, COM2, COM3 ....)
   hCom:Integer;                         // Handle of the telescope port com
   InternalError:Integer;                // Error number
   ReadIntervalTimeout:Dword;            // Time-outs of the com port
   ReadTotalTimeoutMultiplier:Dword;
   ReadTotalTimeoutConstant:Dword;
   WriteTotalTimeoutMultiplier:Dword;
   WriteTotalTimeoutConstant:Dword;


{$R *.RES}

function PluginSetComPort(ComPort:PChar):Boolean; cdecl;
// This function is called by Teleauto to give the com port to the plugin
begin
// Save the comport value
NomCom:=ComPort;
Result:=True;
end;

function PluginSetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                    _ReadTotalTimeoutMultiplier:DWord;
                                    _ReadTotalTimeoutConstant:DWord;
                                    _WriteTotalTimeoutMultiplier:DWord;
                                    _WriteTotalTimeoutConstant:DWord):Boolean; cdecl;
// This function is called by Teleauto to give the com port time-outs to the plugin
begin
// Save the time-outs values
ReadIntervalTimeout         :=_ReadIntervalTimeout;
ReadTotalTimeoutConstant    :=_ReadTotalTimeoutMultiplier;
ReadTotalTimeoutConstant    :=_ReadTotalTimeoutConstant;
WriteTotalTimeoutMultiplier :=_WriteTotalTimeoutMultiplier;
WriteTotalTimeoutConstant   :=_WriteTotalTimeoutConstant;
Result:=True;
end;

function PluginOpen:Boolean; cdecl;
// This function is called when the user connect the focuser or start TeleAuto
// Here you can put code to switch the focuser on and open it
begin
Result:=True;
end;

function PluginClose:Boolean; cdecl;
// This function is called when the user disconnect the focuser or quit TeleAuto
// Here you can put code to close the focuser and switch it off
begin
Result:=True;
end;

function PluginSetHandleCom(_hCom:Integer):Boolean; cdecl;
// This function is called when the focuser is dependent of the scope
// It is used by TeleAuto to give the telescope com port handle to the plugin
begin
hCom:=_hCom;
Result:=True;
end;

function PluginGetErrorNumber:Integer; cdecl;
//This function is called by TeleAuto when an error occured to get the error number
begin
Result:=InternalError;
end;

function PluginIsConnectedAndOK:Boolean; cdecl;
// This function must test if the focuser is connected and works correctly and return
// true is it is the case, false else.
// It is called by TeleAuto at every connection of the focuser
begin
// Allways true for this virtual focuser
Result:=True;
end;

function PluginPasAPas:Boolean; cdecl;
// TeleAuto use this function to know if the focuser has a stepper motor (Robofocus like)
begin
Result:=False;
end;

function PluginHas2Vitesses:Boolean; cdecl;
// TeleAuto use this function to know if the focuser has 2 speed
begin
Result:=True;
end;

function PluginUseComPort:Boolean; cdecl;
// TeleAuto use this function to know if the focuser use the Com Port
begin
Result:=True;
end;

function PluginIsDependantOfTheScope:Boolean; cdecl;
// TeleAuto use this function to know if the focuser is dependant of the scope (LX200 like)
begin
Result:=False;
end;

function PluginMustSetMaxPosition:Boolean; cdecl;
// TeleAuto use this function to know if the plugin need to know the maximum position value
// set by the user in hte configuration window of TeleAuto
// This fonction is valid only if PluginPasAPas return true
begin
Result:=False;
end;

function PluginGetMinPosition:Integer; cdecl;
// TeleAuto use this function to get the minimum position value of the focuser
// This fonction is valid only if PluginPasAPas return true
begin
Result:=0;
end;

function PluginGetMaxPosition:Integer; cdecl;
// TeleAuto use this function to get the maximum position value of the focuser
// This fonction is valid only if PluginPasAPas return true
var
   MaxPosition:Integer;
begin
// Get max position from the focuser here
Result:=MaxPosition;
end;

function PluginDeplaceMapTime(DirectionFocuser:Integer;SpeedFocuser:Integer):Boolean; cdecl;
// TeleAuto use this function to ask to the plugin to start the move in the direction
// DirectionFocuser and with the speed SpeedFocuser
// The values for the directions are :
// Forward : DirectionFocuser = 0
// Backward : DirectionFocuser = 1
// The values for the speeds are :
// Fast : SpeedFocuser = 2
// Slow : SpeedFocuser = 3
begin
Result:=True;
end;

function PluginArreteMapTime:Boolean; cdecl;
// TeleAuto use this function to ask to the plugin to stop the move
begin
Result:=True;
end;

function PluginDeplaceMapSteps(DirectionFocuser:Integer;StepsFocuser:Integer):Boolean; cdecl;
// TeleAuto use this function to ask to the plugin to move the focuser in the direction
// DirectionFocuser and with the StepsFocuser number of steps
// This fonction is valid only if PluginPasAPas return true
begin
Result:=True;
end;

function PluginGetPosition(var _Position:Integer):Boolean; cdecl;
// This fonction is valid only if PluginPasAPas return true
// Read here the position of the focuser and send it to TeleAuto by seting the
// value of _Position
begin
Result:=True;
end;

function PluginSetPosition(_Position:Integer):Boolean; cdecl;
// TeleAuto use this function to set the position of the focuser to the value of _Position
// This fonction is valid only if PluginPasAPas return true
// Use the value of _Position to set the focuser position
begin
Result:=True;
end;

function PluginGotoPosition(_Position:Integer):Boolean; cdecl;
// TeleAuto use this function to ask the plugin to move the focuser to the position _Position
// This fonction is valid only if PluginPasAPas return true
// Use the value of _Position to ask the move to the focuser
begin
Result:=True;
end;

function PluginSetMaxPosition(_MaxPosition:Integer):Boolean; cdecl;
// TeleAuto use this function to set the maximum position of the focuser to the value
// of _MaxPosition
// This fonction is valid only if PluginPasAPas return true
begin
//Send _MaxPosition to focuser here
Result:=True;
end;

function PluginSetBacklash(_BackLash:Integer):Boolean; cdecl;
// This function is not used now in TeleAuto
begin
Result:=True;
end;

function PluginGetFirmware(_FirmWare:string):Boolean; cdecl;
// This function is not used now in TeleAuto
begin
Result:=True;
end;

exports

PluginOpen,
PluginClose,
PluginSetHandleCom,
PluginGetErrorNumber,
PluginSetComPort,
PluginSetSerialPortTimeOut,
PluginIsConnectedAndOK,
PluginPasAPas,
PluginHas2Vitesses,
PluginUseComPort,
PluginIsDependantOfTheScope,
PluginMustSetMaxPosition,
PluginGetMinPosition,
PluginGetMaxPosition,
PluginDeplaceMapTime,
PluginArreteMapTime,
PluginDeplaceMapSteps,
PluginGetPosition,
PluginSetPosition,
PluginGotoPosition,
PluginSetMaxPosition,
PluginSetBacklash,
PluginGetFirmware;

begin
end.
