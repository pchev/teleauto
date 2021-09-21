library PluginTestReal;

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
  SysUtils,
  Classes;

type
  TLigInt=array[1..999999] of SmallInt;
  PLigInt=^TLigInt;
  TImgInt=array[1..999999] of PLigInt;
  PImgInt=^TImgInt;
  TTabImgInt=array[1..255] of PImgInt;
  PTabImgInt=^TTabImgInt;

{$R *.RES}

function PluginProcess(TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; cdecl;
// Here you meux provide the image in a PTabImgInt form
// You must not allocate memory for the TabImgInt because it is already done in TeleAuto
// Return true if everything is OK
begin
end;

exports

PluginProcess;

begin
end.
