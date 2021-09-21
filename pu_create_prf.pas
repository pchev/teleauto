unit pu_create_prf;

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

{$O-}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls, FileCtrl, Grids, Outline, DirOutln, ComCtrls,
  Buttons, Printers, Spin, Mask, Math;

type
  Tpop_create_prf = class(TForm)
    OpenDialog1: TOpenDialog;
    Memo1: TMemo;
    Memo2: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    SaveDialog1: TSaveDialog;
    OpenDialog2: TOpenDialog;
    BitBtn6: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    BitBtn7: TBitBtn;
    Label9: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }

  public
    { Déclarations publiques }
    HCom:Integer;

    AzimuthPRF,HauteurPRF:array[0..360] of Double;

    ComCh:String;

  end;

var
  pop_create_prf: Tpop_create_prf;


implementation

uses pu_main,
     u_general,
     u_telescopes,
     pu_scope,
     u_class,
     u_meca,
     u_lang,
     u_file_io;

{$R *.DFM}

procedure Tpop_create_prf.BitBtn1Click(Sender: TObject);
var
i,j,NbPts,PosEsp:Integer;
Azimuth,Hauteur:PLigDouble;
Azimuth1,Hauteur1,Azimuth2,Hauteur2,Hauteur3,InterD:Double;
Mini1,Mini2:Double;
AzimuthMaxi,HauteurMaxi:Double;
AzimuthMini,HauteurMini:Double;
a,b:Double;
Line:String;
Trouve:Boolean;
begin
Memo2.Clear;

for i:=1 to Memo1.Lines.Count do
   if Memo1.Lines[i]='' then
      Memo1.Lines.Delete(i);

NbPts:=Memo1.Lines.Count;

Getmem(Azimuth,8*NbPts);
Getmem(Hauteur,8*NbPts);

for i:=1 to NbPts do
   begin

   Line:=Memo1.Lines[i-1];

   PosEsp:=Pos(' ',Line);
   Azimuth^[i]:=MyStrToFloat(Copy(Line,1,PosEsp-1))+180;
   if Azimuth^[i]>360 then Azimuth^[i]:=Azimuth^[i]-360;
   Delete(Line,1,PosEsp);

   Hauteur^[i]:=MyStrToFloat(Trim(Line));

   end;

Trouve:=True;
while Trouve do
   begin
   Trouve:=False;
   for i:=1 to NbPts-1 do
      if Azimuth^[i]>Azimuth^[i+1] then
         begin
         Trouve:=True;
         InterD:=Azimuth^[i];
         Azimuth^[i]:=Azimuth^[i+1];
         Azimuth^[i+1]:=InterD;
         InterD:=Hauteur^[i];
         Hauteur^[i]:=Hauteur^[i+1];
         Hauteur^[i+1]:=InterD;
         end;
   end;

for i:=0 to 360 do
   begin

   Mini1:=100000;
   Mini2:=100000;
   Azimuth1:=-10000;
   Hauteur1:=-10000;
   Azimuth2:=-10000;
   Hauteur2:=-10000;
   AzimuthMaxi:=-10000;
   HauteurMaxi:=0;
   AzimuthMini:=10000;
   HauteurMini:=0;

   for j:=1 to NbPts do
      begin
      if Azimuth^[j]>AzimuthMaxi then
         begin
         AzimuthMaxi:=Azimuth^[j];
         HauteurMaxi:=Hauteur^[j];;
         end;

      if Azimuth^[j]<AzimuthMini then
         begin
         AzimuthMini:=Azimuth^[j];
         HauteurMini:=Hauteur^[j];
         end;

      if (Azimuth^[j]<=i) and (Abs(i-Azimuth^[j])<=Mini1) then
         begin
         Mini1:=Abs(i-Azimuth^[j]);
         Azimuth1:=Azimuth^[j];
         Hauteur1:=Hauteur^[j];
         end;

      if (Azimuth^[j]>=i) and (Abs(i-Azimuth^[j])<=Mini2) then
         begin
         Mini2:=Abs(i-Azimuth^[j]);
         Azimuth2:=Azimuth^[j];
         Hauteur2:=Hauteur^[j];
         end;
      end;

   if Hauteur1=-10000 then
      begin
      Azimuth1:=AzimuthMaxi-360;
      Hauteur1:=HauteurMaxi;
      end;

   if Hauteur2=-10000 then
      begin
      Azimuth2:=AzimuthMini+360;
      Hauteur2:=HauteurMini;
      end;

   if Azimuth2<>Azimuth1 then
      begin
      a:=(Hauteur2-Hauteur1)/(Azimuth2-Azimuth1);
      b:=Hauteur1-a*Azimuth1;
      //Hauteur1:=a*Azimuth1+b;

      Hauteur3:=a*i+b;
      end
   else
      begin
      Hauteur3:=Hauteur1;
      end;

   Memo2.Lines.Add(IntToStr(i)+' '+FloatToStr(Hauteur3));

   end;

Freemem(Azimuth,8*NbPts);
Freemem(Hauteur,8*NbPts);
end;

procedure Tpop_create_prf.BitBtn2Click(Sender: TObject);
var
Alpha,Delta:Double;
Azimuth,Hauteur:Double;
begin
if Config.GoodPos then
   begin
   Alpha:=Config.AlphaScope;
   Delta:=Config.DeltaScope;
   Hauteur:=GetElevationNow(Alpha,Delta,Config.Lat,Config.Long);
   Azimuth:=GetAzimuthNow(Alpha,Delta,Config.Lat,Config.Long);

   Memo1.Lines.Add(FloatToStr(Azimuth)+' '+FloatToStr(Hauteur));
   end
else
   begin
   WriteSpy(lang('Le télescope ne veut pas donner sa position'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope ne veut pas donner sa position'));
   end;
end;

procedure Tpop_create_prf.BitBtn3Click(Sender: TObject);
var
Nom:String;
begin
SaveDialog1.Filter:=lang('Fichiers texte (*.txt)|*.txt');
if SaveDialog1.Execute then
   begin
   Nom:=SaveDialog1.FileName;
   if UpperCase(ExtractFileExt(Nom))<>'.TXT' then Nom:=Nom+'.txt'; //nolang
   Memo1.Lines.SaveToFile(Nom);
   end;
end;

procedure Tpop_create_prf.BitBtn6Click(Sender: TObject);
begin
Memo1.Clear;
OpenDialog1.Filter:=lang('Fichiers texte (*.txt)|*.txt');
if OpenDialog1.Execute then
   Memo1.Lines.LoadFromFile(OpenDialog1.Filename);
end;

procedure Tpop_create_prf.BitBtn4Click(Sender: TObject);
var
Nom:String;
begin
SaveDialog1.Filter:=lang('Fichiers profil (*.prf)|*.prf');
if SaveDialog1.Execute then
   begin
   Nom:=SaveDialog1.FileName;
   if UpperCAse(ExtractFileExt(Nom))<>'.PRF' then Nom:=Nom+'.prf'; //nolang
   Memo2.Lines.SaveToFile(Nom);
   end;
end;

procedure Tpop_create_prf.BitBtn5Click(Sender: TObject);
begin
Close;
end;

procedure Tpop_create_prf.BitBtn7Click(Sender: TObject);
begin
Memo1.Clear;
Memo1.Lines.add(lang('2 17')); //nolang
Memo1.Lines.add(lang('30 3')); //nolang
Memo1.Lines.add(lang('79 3')); //nolang
Memo1.Lines.add(lang('92 11')); //nolang
Memo1.Lines.add(lang('120 11')); //nolang
Memo1.Lines.add(lang('121 14')); //nolang
Memo1.Lines.add(lang('153 33')); //nolang
Memo1.Lines.add(lang('177 42')); //nolang
Memo1.Lines.add(lang('181 32')); //nolang
Memo1.Lines.add(lang('185 22')); //nolang
Memo1.Lines.add(lang('189 12')); //nolang
Memo1.Lines.add(lang('201 22')); //nolang
Memo1.Lines.add(lang('220 21')); //nolang
Memo1.Lines.add(lang('255 32')); //nolang
Memo1.Lines.add(lang('273 30')); //nolang
Memo1.Lines.add(lang('280 25')); //nolang
Memo1.Lines.add(lang('281 10')); //nolang
Memo1.Lines.add(lang('300 10')); //nolang
Memo1.Lines.add(lang('305 18')); //nolang
end;

procedure Tpop_create_prf.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

end.
