unit pu_track;

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
  ExtCtrls, StdCtrls, inifiles, tagraph;

type
  Tpop_track = class(TForm)
    Panel3: TPanel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ListBox1: TListBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Panel2: TPanel;
    Label4: TLabel;
    Panel4: TPanel;
    Panel5: TPanel;
    DX: TLabel;
    Panel6: TPanel;
    DY: TLabel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    N: TLabel;
    S: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label15: TLabel;
    Panel15: TPanel;
    Panel16: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Panel17: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    TAChart2: TTAChart;
    TAChart1: TTAChart;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Init:Boolean;
    TimeInit,XInit,Yinit,Xrms,Yrms,XCumul,YCumul:Double;
    NbPoints:Integer;

    TASerie1:TTASerie;
    TASerie2:TTASerie;
    TASerie3:TTASerie;
    TASerie4:TTASerie;

    procedure Add(Time,X,Y:Double);
    procedure AddErreurSuivi(Dx,Dy:Double);
    procedure AddLimiteNord(Limite:Double);
    procedure AddLimiteSud(Limite:Double);
    procedure AddLimiteEst(Limite:Double);
    procedure AddLimiteOuest(Limite:Double);
    procedure AddMoveNord(Move:Double);
    procedure AddMoveSud(Move:Double);
    procedure AddMoveEst(Move:Double);
    procedure AddMoveOuest(Move:Double);
    procedure AddMessage(MyMessage:string);
    procedure ShowTrack(X,Y:Double);
    procedure AddMarque(Time,X,Y:Double);
    procedure RAZImage;
    procedure RAZ;
    procedure RAZErreur; 
  end;

 var
   pop_track:Tpop_track;

implementation

{$R *.DFM}

uses u_general,
     pu_main,
     u_lang,
     u_file_io,
     pu_map,
     u_cameras;

procedure Tpop_track.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
   Ini:TMemIniFile;
   Path:string;
begin
TASerie1.Clear;
TASerie2.Clear;
TASerie3.Clear;
TASerie4.Clear;

Action:=caFree;
pop_track:=nil;

// Sauve la pos
Path:=ExtractFilePath(Application.Exename);
Ini:=TMemIniFile.Create(Path+lang('TeleAuto.ini')); //nolang
try
Ini.WriteString('WindowsPos','TrackTop',IntToStr(Top));
Ini.WriteString('WindowsPos','TrackLeft',IntToStr(Left));
finally
Ini.UpdateFile;
Ini.Free;
end;

end;

procedure Tpop_track.Add(Time,X,Y:Double);
var
   Dist1,Dist2:Double;
   NbSeries,i:Integer;
begin
if Init then
   begin
   Init:=False;
   TimeInit:=Time;
   NbPoints:=0;
   end;
Inc(NbPoints);

if NBPoints=1 then
   begin
   Panel15.Caption:=MyFloatToStr(X,2);
   Panel16.Caption:=MyFloatToStr(Y,2);
   XInit:=X;
   YInit:=Y;
   end;

Xrms:=Xrms+(X-XInit)*(X-XInit);
XCumul:=XCumul+(X-XInit)*CameraSuivi.GetXPixelSize;
Yrms:=Yrms+(Y-YInit)*(Y-YInit);
YCumul:=YCumul+(Y-YInit)*CameraSuivi.GetYPixelSize;

Panel1.Caption:=MyFloatToStr(X,2);
Panel3.Caption:=MyFloatToStr(Y,2);

Dist1:=Sqrt((Xrms+YRms)/(NbPoints));
Dist2:=ArcTan(Sqrt((Xrms*Sqr(CameraSuivi.GetXPixelSize/1e6)+YRms*Sqr(CameraSuivi.GetYPixelSize/1e6))/(NbPoints))
   /Config.FocaleTele*1000)*180/Pi*3600;
Panel2.Caption:=MyFloatToStr(Dist1,2)+' Pixels'; //nolang
Panel17.Caption:=MyFloatToStr(Dist2,2)+' ArcSec'; //nolang
if YCumul<>0 then Panel4.Caption:=MyFloatToStr(ArcTan(XCumul/YCumul)/pi*180,2)+lang(' Degrés');

TASerie1.AddXY((Time-TimeInit)*24*3600,X,clBlack);
TASerie3.AddXY((Time-TimeInit)*24*3600,Y,clBlack);

ShowTrack(X,Y);
end;

procedure Tpop_track.AddErreurSuivi(Dx,Dy:Double);
begin
Panel5.Caption:=MyFloatToStr(Dx,2);
Panel6.Caption:=MyFloatToStr(Dy,2);
end;

procedure Tpop_track.AddLimiteNord(Limite:Double);
begin
//Panel11.Caption:=MyFloatToStr(Limite,2);
end;

procedure Tpop_track.AddLimiteSud(Limite:Double);
begin
//Panel12.Caption:=MyFloatToStr(Limite,2);
end;

procedure Tpop_track.AddLimiteEst(Limite:Double);
begin
//Panel13.Caption:=MyFloatToStr(Limite,2);
end;

procedure Tpop_track.AddLimiteOuest(Limite:Double);
begin
//Panel14.Caption:=MyFloatToStr(Limite,2);
end;

procedure Tpop_track.AddMoveNord(Move:Double);
begin
Panel7.Caption:=MyFloatToStr(Move*1000,0);
Panel8.Caption:='';
end;

procedure Tpop_track.AddMoveSud(Move:Double);
begin
Panel8.Caption:=MyFloatToStr(Move*1000,0);
Panel7.Caption:='';
end;

procedure Tpop_track.AddMoveEst(Move:Double);
begin
Panel9.Caption:=MyFloatToStr(Move*1000,0);
Panel10.Caption:='';
end;

procedure Tpop_track.AddMoveOuest(Move:Double);
begin
Panel10.Caption:=MyFloatToStr(Move*1000,0);
Panel9.Caption:='';
end;

procedure Tpop_track.AddMessage(MyMessage:String);
const
   Max=1000;
var
   Nbre:integer;
begin
if ListBox1.Items.Count>Max then ListBox1.Items.Delete(0);
ListBox1.Items.Add(GetStrTimeBios+' '+MyMessage);

Nbre:=ListBox1.Height div ListBox1.ItemHeight;

if ListBox1.Items.Count<Nbre then ListBox1.TopIndex:=0
else ListBox1.TopIndex:=ListBox1.Items.Count-Nbre;

end;

procedure Tpop_track.FormCreate(Sender: TObject);
begin
Init:=True;
Image1.Canvas.Pen.Mode:=pmBlack;
Image1.Canvas.Brush.Color:=clBlack;
Image1.Canvas.Brush.Style:=bsSolid;
Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
Image1.Canvas.Pen.Color:=clRed;
Image1.Canvas.Pen.Mode:=pmCopy;
Image1.Canvas.Pen.Style:=psSolid;
Image1.Canvas.Rectangle(40,40,Image1.Width-40,Image1.Height-40);
Image1.Canvas.Brush.Style:=bsClear;
ListBox1.Items.Capacity:=1000;

TASerie1:=TTASerie.Create(TAChart1);
TAChart1.AddSerie(TASerie1);
TASerie1.ShowPoints:=False;
TASerie1.ShowLines:=True;

TASerie2:=TTASerie.Create(TAChart1);
TAChart1.AddSerie(TASerie2);
TASerie2.ShowPoints:=True;
TASerie2.ShowLines:=False;

TASerie3:=TTASerie.Create(TAChart2);
TAChart2.AddSerie(TASerie3);
TASerie3.ShowPoints:=False;
TASerie3.ShowLines:=True;

TASerie4:=TTASerie.Create(TAChart2);
TAChart2.AddSerie(TASerie4);
TASerie4.ShowPoints:=True;
TASerie4.ShowLines:=False;
end;

procedure Tpop_track.RAZImage;
begin
Image1.Canvas.Pen.Mode:=pmBlack;
Image1.Canvas.Brush.Color:=clBlack;
Image1.Canvas.Brush.Style:=bsSolid;
Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
Image1.Canvas.Pen.Color:=clRed;
Image1.Canvas.Pen.Mode:=pmCopy;
Image1.Canvas.Pen.Style:=psSolid;
Image1.Canvas.Rectangle(40,40,Image1.Width-40,Image1.Height-40);
Image1.Canvas.Brush.Style:=bsClear;
end;

procedure Tpop_track.Button2Click(Sender: TObject);
begin
RAZ;
{Series1.Clear;
LineSeries1.Clear;
Series2.Clear;
Series3.Clear;
ListBox1.Clear;
Init:=True;

Xrms:=0;
Yrms:=0;
XCumul:=0;
YCumul:=0;
NbPoints:=0;}
end;

procedure Tpop_track.Button3Click(Sender: TObject);
var
T:TextFile;
Name:string;
i:Integer;
begin
pop_main.SaveDialog.Filter:=lang('Fichiers Textes *.txt|*.txt');
if pop_main.SaveDialog.Execute then
   begin
   Name:=pop_main.SaveDialog.FileName;
   if UpperCase(ExtractFileExt(Name))<>'.TXT' then Name:=Name+'.txt'; //nolang
   AssignFile(T,Name);
   Rewrite(T);
   try
   i:=0;
   while i<=TASerie1.Count-1 do
      begin
      Writeln(T,MyFloatToStr(TASerie1.GetXValue(i),2)
         +' '+MyFloatToStr(TASerie1.GetYValue(i),2)
         +' '+MyFloatToStr(TASerie3.GetYValue(i),2)
         +' '+MyFloatToStr(TASerie1.GetYValue(i)-TASerie1.GetYValue(0),2)
         +' '+MyFloatToStr(TASerie3.GetYValue(i)-TASerie3.GetYValue(0),2));
      Inc(i);
      end;
   finally
   System.Close(T);
   end;
   end;
end;

procedure Tpop_track.ShowTrack(X,Y:Double);
var
XGraph,YGraph:LongInt;
begin
XGraph:=Round(50+(X-Xinit)*20);
YGraph:=Round(50+(Y-Yinit)*20);
Image1.Canvas.Pixels[XGraph,Image1.Height-YGraph]:=clRed;
end;

procedure Tpop_track.FormShow(Sender: TObject);
var
   Ini:TMemIniFile;
   Path:string;
   Valeur:Integer;
begin
// Lit la pos
Path:=ExtractFilePath(Application.Exename);
Ini:=TMemIniFile.Create(Path+'TeleAuto.ini'); //nolang
try
Valeur:=StrToInt(Ini.ReadString('WindowsPos','TrackTop',IntToStr(Self.Top)));
if Valeur<>0 then Top:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','TrackLeft',IntToStr(Self.Left)));
if Valeur<>0 then Left:=Valeur;
finally
Ini.UpdateFile;
Ini.Free;
end;

UpDateLang(Self);
end;

procedure Tpop_track.AddMarque(Time,X,Y:Double);
begin
TASerie2.AddXY((Time-TimeInit)*24*3600,X,clRed);
TASerie4.AddXY((Time-TimeInit)*24*3600,Y,clRed);
end;

procedure Tpop_track.RAZ;
begin
Init:=True;
Panel1.Caption:='';
Panel2.Caption:='';
Panel4.Caption:='';
Panel3.Caption:='';
Panel5.Caption:='';
Panel6.Caption:='';
Panel7.Caption:='';
Panel8.Caption:='';
Panel9.Caption:='';
Panel10.Caption:='';
Panel15.Caption:='';
Panel16.Caption:='';
Panel17.Caption:='';
RAZImage;

TASerie1.Clear;
TASerie2.Clear;
TASerie3.Clear;
TASerie4.Clear;

Xrms:=0;
Yrms:=0;
XCumul:=0;
YCumul:=0;
NbPoints:=0;
end;

// En debut de pose du CCD principal
procedure Tpop_track.RAZErreur;
begin
RAZImage;
Panel2.Caption:='';
Panel17.Caption:='';
Xrms:=0;
Yrms:=0;
XCumul:=0;
YCumul:=0;
NbPoints:=0;
end;


procedure Tpop_track.Button4Click(Sender: TObject);
var
   Bitmap:TBitmap;
   MyName:string;
begin
Bitmap:=TBitmap.Create;
try
Bitmap.PixelFormat:=pf24bit;
Bitmap.Width:=520;
Bitmap.Height:=226;
Bitmap.Canvas.CopyRect(Rect(0,0,Bitmap.Width,Bitmap.Height),Canvas,Rect(104,0,104+Bitmap.Width,Bitmap.Height));

pop_main.SaveDialog.Filter:=lang('Fichiers Bitmap *.bmp|*.bmp');
if pop_main.SaveDialog.Execute then
   begin
   MyName:=pop_main.SaveDialog.FileName;
   if UpperCase(ExtractFileExt(MyName))<>'.BMP' then MyName:=MyName+'.bmp'; //nolang
   Bitmap.SaveToFile(MyName);
   end;

finally
Bitmap.Free;
end;
end;

end.
