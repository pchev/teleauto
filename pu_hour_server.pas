unit pu_hour_server;

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
  ExtCtrls, StdCtrls, ComCtrls, Mask, Spin, HiResTim, Buttons, IniFiles;

type
  Tpop_hour_server = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    MaskEdit2: TMaskEdit;
    MaskEdit1: TMaskEdit;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Button2: TButton;
    TabSheet2: TTabSheet;
    CheckBox1: TCheckBox;
    Memo1: TMemo;
    TabSheet3: TTabSheet;
    Label5: TLabel;
    MaskEdit3: TMaskEdit;
    SpinEdit1: TSpinEdit;
    Label6: TLabel;
    Label7: TLabel;
    SpinEdit2: TSpinEdit;
    Label8: TLabel;
    CheckBox2: TCheckBox;
    BitBtn1: TBitBtn;
    SaveDialog1: TSaveDialog;
    HiResTimer1: THiResTimer;
    HiResTimer2: THiResTimer;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox2Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure HiResTimer1Timer(Sender: TObject);
    procedure HiResTimer2Timer(Sender: TObject);
  private
    { Déclarations privées }
    procedure UpdateHour;
  public
    { Déclarations publiques }
    CanUpdateHour:Boolean;
  end;

var
  pop_hour_server: Tpop_hour_server;

implementation

{$R *.DFM}

uses u_hour_servers,
     u_lang,
     pu_main,
     u_class,
     u_general;

procedure Tpop_hour_server.UpdateHour;
var
   Year,Month,Day,Hour,Min,Sec,MSec:Word;
   SYear,SMonth,SDay,SHour,SMin,SSec,SMSec:string;
begin
if CanUpdateHour and Config.HourServerBranche then
   begin
   HourServer.GetHour(Year,Month,Day,Hour,Min,Sec,MSec);
   SYear:=IntToStr(Year);
   SMonth:=IntToStr(Month);
   if Month<10 then SMonth:='0'+SMonth;
   SDay:=IntToStr(Day);
   if Day<10 then SDay:='0'+SDay;
   SHour:=IntToStr(Hour);
   if Hour<10 then SHour:='0'+SHour;
   SMin:=IntToStr(Min);
   if Min<10 then SMin:='0'+SMin;
   SSec:=IntToStr(Sec);
   if Sec<10 then SSec:='0'+SSec;
   SMSec:=IntToStr(MSec);
   if MSec<10 then SMSec:='0'+SMSec;
   if MSec<100 then SMSec:='0'+SMSec;

   Panel1.Caption:=SDay+'/'+SMonth+'/'+SYear;
   Panel2.Caption:=SHour+':'+SMin+':'+SSec+'.'+SMSec;
   end;
end;

procedure Tpop_hour_server.FormShow(Sender: TObject);
var
   Ini:TMemIniFile;
   Path:string;
   Valeur:Integer;
begin
// Lit la pos
Path:=ExtractFilePath(Application.Exename);
Ini:=TMemIniFile.Create(Path+'TeleAuto.ini'); //nolang
try
Valeur:=StrToInt(Ini.ReadString('WindowsPos','HourServerTop',IntToStr(Self.Top)));
if Valeur<>0 then Top:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','HourServerLeft',IntToStr(Self.Left)));
if Valeur<>0 then Left:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','HourServerWidth',IntToStr(Self.Width)));
if Valeur<>0 then Width:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','HourServerHeight',IntToStr(Self.Height)));
if Valeur<>0 then Height:=Valeur;
finally
Ini.UpdateFile;
Ini.Free;
end;

Caption:='Serveur d''heure : '+HourServer.GetName;

PageControl1.ActivePage:=TabSheet1;

if HourServer.HasEventInCaps then
   PageControl1.Pages[1].TabVisible:=True
else
   PageControl1.Pages[1].TabVisible:=False;
{if HourServer.HasEventOutCaps then
   PageControl1.Pages[2].TabVisible:=True
else
   PageControl1.Pages[2].TabVisible:=False;}
PageControl1.Pages[2].TabVisible:=False;   

if HourServer.CanSetHour then
   begin
   Button1.Enabled:=True;
   Label3.Enabled:=True;
   Label4.Enabled:=True;
   MaskEdit1.Enabled:=True;
   MaskEdit2.Enabled:=True;
   GroupBox1.Enabled:=True;
   end
else
   begin
   Button1.Enabled:=False;
   Label3.Enabled:=False;
   Label4.Enabled:=False;
   MaskEdit1.Enabled:=False;
   MaskEdit2.Enabled:=False;
   GroupBox1.Enabled:=False;
   end;

UpdateHour;
Left:=Screen.Width-Width;
UpDateLang(Self);

if HourServer.CanBeUsedToSetPCHour then Button2.Enabled:=True
else Button2.Enabled:=False;

HiresTimer1.Enabled:=True;
HiresTimer2.Enabled:=False;
end;

procedure Tpop_hour_server.Button1Click(Sender: TObject);
var
   Year,Month,Day,Hour,Min,Sec,MSec:Word;
   Line:string;
begin
CanUpdateHour:=False;

try
try
Line:=MaskEdit1.Text;
Day:=StrToInt(Copy(Line,1,2));
Month:=StrToInt(Copy(Line,4,2));
Year:=StrToInt(Copy(Line,7,4));

Line:=MaskEdit2.Text;
Hour:=StrToInt(Copy(Line,1,2));
Min:=StrToInt(Copy(Line,4,2));
Sec:=StrToInt(Copy(Line,7,2));
MSec:=0;

HourServer.SetHour(Year,Month,Day,Hour,Min,Sec,MSec);

except
Config.HourServerBranche:=False;
pop_main.UpdateGUIHourServer;
HourServer.CloseSerialPort;
HourServer.Close;
HourServer.Free;
Close;
end;

finally
CanUpdateHour:=True;
end;

end;

procedure Tpop_hour_server.FormCreate(Sender: TObject);
var
   DT:TDateTime;
   Year,Month,Day,Hour,Min,Sec,MSec:Word;
   SYear,SMonth,SDay,SHour,SMin,SSec:string;
begin
CanUpdateHour:=True;

DT:=Now;
DecodeDate(DT,Year,Month,Day);
DecodeTime(DT,Hour,Min,Sec,MSec);

SYear:=IntToStr(Year);
SMonth:=IntToStr(Month);
if Month<10 then SMonth:='0'+SMonth;
SDay:=IntToStr(Day);
if Day<10 then SDay:='0'+SDay;
SHour:=IntToStr(Hour);
if Hour<10 then SHour:='0'+SHour;
SMin:=IntToStr(Min);
if Min<10 then SMin:='0'+SMin;
SSec:=IntToStr(Sec);
if Sec<10 then SSec:='0'+SSec;

MaskEdit1.Text:=SDay+'/'+SMonth+'/'+SYear;
MaskEdit2.Text:=SHour+':'+SMin+':'+SSec;
MaskEdit3.Text:=SHour+':'+SMin+':'+SSec;

end;

procedure Tpop_hour_server.Button2Click(Sender: TObject);
var
   DT:TDateTime;
   Year,Month,Day,Hour,Min,Sec,MSec:Word;
begin
HourServer.GetHour(Year,Month,Day,Hour,Min,Sec,MSec);
DT:=EncodeDate(Year,Month,Day)+EncodeTime(Hour,Min,Sec,MSec);
MajSystemTime(DT);
end;

procedure Tpop_hour_server.CheckBox1Click(Sender: TObject);
begin
if CheckBox1.Checked then
   begin
   CheckBox2.Enabled:=False;

   HourServer.SetEventInOn;
   HiresTimer2.Enabled:=True
   end
else
   begin
   CheckBox2.Enabled:=True;

   HourServer.SetEventInOff;
   HiresTimer2.Enabled:=False;
   end;
end;

procedure Tpop_hour_server.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
   Ini:TMemIniFile;
   Path:string;
begin
// Sauve la pos
Path:=ExtractFilePath(Application.Exename);
Ini:=TMemIniFile.Create(Path+'TeleAuto.ini'); //nolang
try
Ini.WriteString('WindowsPos','HourTop',IntToStr(Top));
Ini.WriteString('WindowsPos','HourLeft',IntToStr(Left));
Ini.WriteString('WindowsPos','HourWidth',IntToStr(Width));
Ini.WriteString('WindowsPos','HourHeight',IntToStr(Height));
finally
Ini.UpdateFile;
Ini.Free;
end;

if CheckBox1.Checked then
   begin
   CheckBox1.Checked:=False;
   HourServer.SetEventInOff;
   end;

if CheckBox2.Checked then
   begin
   CheckBox2.Checked:=False;
   HourServer.SetEventOutOff;
   end;

end;

procedure Tpop_hour_server.CheckBox2Click(Sender: TObject);
var
   Hour,Min,Sec,Nb,Interval:Word;
begin
CanUpdateHour:=False;
if CheckBox2.Checked then
   begin
   Hour:=StrToInt(Copy(MaskEdit3.Text,1,2));
   Min:=StrToInt(Copy(MaskEdit3.Text,4,2));
   Sec:=StrToInt(Copy(MaskEdit3.Text,7,2));
   Nb:=StrToInt(SpinEdit1.Text);
   Interval:=StrToInt(SpinEdit2.Text);
   HourServer.SetEventOut(Hour,Min,Sec,Nb,Interval);
   HourServer.SetEventOutOn;

   Label5.Enabled:=False;
   Label6.Enabled:=False;
   Label7.Enabled:=False;
   Label8.Enabled:=False;
   MaskEdit3.Enabled:=False;
   SpinEdit1.Enabled:=False;
   SpinEdit2.Enabled:=False;
   CheckBox1.Enabled:=False;
   end
else
   begin
   HourServer.SetEventOutOff;

   Label5.Enabled:=True;
   Label6.Enabled:=True;
   Label7.Enabled:=True;
   Label8.Enabled:=True;
   MaskEdit3.Enabled:=True;
   SpinEdit1.Enabled:=True;
   SpinEdit2.Enabled:=True;
   CheckBox1.Enabled:=True;
   end;

CanUpdateHour:=True;
end;

procedure Tpop_hour_server.FormHide(Sender: TObject);
begin
pop_main.ToolButton9.Down:=False;
HiresTimer1.Enabled:=False;
end;

procedure Tpop_hour_server.BitBtn1Click(Sender: TObject);
var
T:TextFile;
Name:string;
i:Integer;
begin
SaveDialog1.InitialDir:=config.RepImages;
if SaveDialog1.Execute then
   begin
   Name:=SaveDialog1.FileName;
   if UpperCase(ExtractFileExt(Name))<>'.TXT' then Name:=Name+'.txt'; //nolang
   AssignFile(T,Name);
   Rewrite(T);
   for i:=0 to Memo1.Lines.Count-1 do
      Writeln(T,Memo1.Lines[i]);
   CloseFile(T);
   end;
end;

procedure Tpop_hour_server.HiResTimer1Timer(Sender: TObject);
begin
try
UpdateHour;
except
Config.HourServerBranche:=False;
pop_main.UpdateGUIHourServer;
HourServer.CloseSerialPort;
HourServer.Close;
HourServer.Free;
Close;
end;
end;

procedure Tpop_hour_server.HiResTimer2Timer(Sender: TObject);
var
   Hour,Min,Sec,MSec:Word;
   SHour,SMin,SSec,SMSec:string;
begin
if HourServer.GetEventIn(Hour,Min,Sec,MSec) then
   begin
   if Hour<10 then SHour:='0'+IntToStr(Hour) else SHour:=IntToStr(Hour);
   if Min<10 then SMin:='0'+IntToStr(Min) else SMin:=IntToStr(Min);
   if Sec<10 then SSec:='0'+IntToStr(Sec) else SSec:=IntToStr(Sec);
   if MSec<100 then SMSec:='0'+IntToStr(MSec) else SMSec:=IntToStr(MSec);
   if MSec<10 then SMSec:='0'+IntToStr(MSec) else SMSec:=IntToStr(MSec);

   Memo1.Lines.Add(SHour+':'+Smin+':'+SSec+'.'+SMSec);
   end;
end;

end.
