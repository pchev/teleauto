library VestaSC;

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
  pu_VestaSC in 'pu_VestaSC.pas' {pop_VestaSC},
  pu_webcamselect in 'pu_webcamselect.pas' {pop_webcamselect};

exports

PluginSetPort,
PluginSetWindow,
PluginSetBinning,
PluginSetPose,
PluginSetEmptyingDelay,
PluginSetReadingDelay,
PluginSetShutterCloseDelay,
PluginIsConnectedAndOK,
PluginOpen,
PluginClose,
PluginStartPose,
PluginSetHourServer,
PluginGetCCDDateBegin,
PluginGetCCDDateEnd,
PluginGetCCDTimeBegin,
PluginGetCCDTimeEnd,
PluginStopPose,
PluginReadCCD,
PluginGetTemperature,
PluginSetTemperature,
PluginSetPCMinusUT,
PluginAmpliOn,
PluginAmpliOff,
PluginShutterOpen,
PluginShutterClosed,
PluginShutterSynchro,
PluginGetName,
PluginGetSaturationLevel,
PluginGetXSize,
PluginGetYSize,
PluginGetXPixelSize,
PluginGetYPixelSize,
PluginGetNbplans,
PluginGetTypeData,
PluginIsAValidBinning,
PluginHasTemperature,
PluginCanCutAmpli,
PluginGetDelayToSwitchOffAmpli,
PluginGetDelayToSwitchOnAmpli,
PluginNeedEmptyingDelay,
PluginNeedReadingDelay,
PluginNeedCloseShutterDelay,
PluginHasAShutter,
PluginIsUsedUnderNT,
PluginIsNotUsedUnderNT,
PluginIs16Bits,
PluginHasCfgWindow,
PluginShowCfgWindow;

begin
 LoadConfig;
end.
