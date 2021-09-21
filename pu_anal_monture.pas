unit pu_anal_monture;

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
  ExtCtrls, StdCtrls, tagraph;

type
  Tpop_anal_monture = class(TForm)
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
    Button1: TButton;
    TAChart1: TTAChart;
    TAChart2: TTAChart;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Init:Boolean;
    TimeInit,XInit,Yinit,Xrms,Yrms,XCumul,YCumul:Double;
    NbPoints:Integer;

    TASerie1: TTASerie;
    TASerie2: TTASerie;
    TASerie3: TTASerie;

    procedure Add(Time,X,Y,Sigma:Double);
    procedure AddMessage(MyMessage:String);
    procedure ShowTrack(X,Y:Double);
  end;

 var
   pop_anal_monture:Tpop_anal_monture;

implementation

{$R *.DFM}

uses u_general,
     pu_main,
     u_lang,
     u_file_io,
     pu_map,
     u_cameras;

procedure Tpop_anal_monture.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
WriteSpy('Arrêt de l''analyse demandé');
AddMessage('Arrêt de l''analyse demandé');
Pop_main.StopAnalMonture:=True;

TesteFocalisation:=False;
Action:=caFree;
pop_anal_monture:=nil;

TASerie1.Free;
TASerie2.Free;
TASerie3.Free;
end;

procedure Tpop_anal_monture.Add(Time,X,Y,Sigma:Double);
begin
if Init then
   begin
   Init:=False;
   TimeInit:=Time;
   XInit:=X;
   YInit:=Y;
//   Series2.AddXY(0,Y,'',clTeeColor);
   TASerie3.AddXY(0,Y,clRed);
   end;
Inc(NbPoints);
Xrms:=Xrms+(X-XInit)*(X-XInit);
XCumul:=XCumul+(X-XInit);
Yrms:=Yrms+(Y-YInit)*(Y-YInit);
YCumul:=YCumul+(Y-YInit);

Panel1.Caption:=FloatToStrF(X,ffFixed,4,2);
Panel3.Caption:=FloatToStrF(Y,ffFixed,4,2);

Panel2.Caption:=FloatToStrF(Sqrt((Xrms+YRms)/NbPoints),ffFixed,4,2);
if YCumul<>0 then Panel4.Caption:=FloatToStrF(ArcTan(XCumul/YCumul)/pi*180,ffFixed,4,2);
//if Yrms<>0 then Panel4.Caption:=FloatToStrF(ArcTan(Yrms/Xrms)/pi*180,ffFixed,4,2);

//Series1.AddXY((Time-TimeInit)*24*3600,X,'',clTeeColor);
TASerie1.AddXY((Time-TimeInit)*24*3600,X,clBlack);
//LineSeries1.AddXY((Time-TimeInit)*24*3600,Y,'',clTeeColor);
TASerie2.AddXY((Time-TimeInit)*24*3600,Y,clBlack);

{lfitLin(x,y,sig:PLigDouble;
        ndata:Integer;
        var a:DoubleArrayRow;
        var covar:DoubleArray;
        var chisq:Double);}

//if Series2.Count>1 then Series2.Delete(1);
if TASerie3.Count>1 then TASerie3.Delete(1);
//Series2.AddXY((Time-TimeInit)*24*3600,Y,'',clTeeColor);
TASerie3.AddXY((Time-TimeInit)*24*3600,Y,clRed);

ShowTrack(X,Y);
AddMessage(lang('DeltaY = ')+MyFloatToStr(Y-Yinit,2));
end;

procedure Tpop_anal_monture.AddMessage(MyMessage:String);
const
   Max=1000;
var
   Nbre:integer;
begin
WriteSpy(MyMessage);

if ListBox1.Items.Count>Max then ListBox1.Items.Delete(0);
ListBox1.Items.Add(GetStrTimeBios+' '+MyMessage);

Nbre:=ListBox1.Height div ListBox1.ItemHeight;

if ListBox1.Items.Count<Nbre then ListBox1.TopIndex:=0
else ListBox1.TopIndex:=ListBox1.Items.Count-Nbre;

end;

procedure Tpop_anal_monture.FormCreate(Sender: TObject);
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
end;

procedure Tpop_anal_monture.Button2Click(Sender: TObject);
begin
//Series1.Clear;
TASerie1.Clear;
//Series2.Clear;
TASerie3.Clear;
//LineSeries1.Clear;
TASerie2.Clear;
ListBox1.Clear;
Init:=True;

Xrms:=0;
Yrms:=0;
XCumul:=0;
YCumul:=0;
NbPoints:=0;
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

procedure Tpop_anal_monture.Button3Click(Sender: TObject);
var
T:TextFile;
Name:String;
i:Integer;
begin
pop_main.SaveDialog.Filter:=lang('Fichiers Textes *.txt|*.txt');
if pop_main.SaveDialog.Execute then
   begin
   Name:=pop_main.SaveDialog.FileName;
   if UpperCase(ExtractFileExt(Name))<>'.txt' then Name:=Name+'.txt'; //nolang
   AssignFile(T,Name);
   Rewrite(T);
   try
   i:=0;
//   while i<=Series1.XValues.Count-1 do
   while i<=TASerie1.Count-1 do
      begin
//      Writeln(T,FloatToStrF(Series1.XValues.Value[i],ffFixed,4,2)
//         +' '+FloatToStrF(Series1.YValues.Value[i],ffFixed,4,2));
      Writeln(T,MyFloatToStr(TASerie1.GetXValue(i),2)
         +' '+MyFloatToStr(TASerie1.GetYValue(i),2));
      Inc(i);
      end;
   finally
   System.Close(T);
   end;
   end;
end;

procedure Tpop_anal_monture.Button4Click(Sender: TObject);
var
T:TextFile;
Name:String;
i:Integer;
begin
pop_main.SaveDialog.Filter:=lang('Fichiers Textes *.txt|*.txt');
if pop_main.SaveDialog.Execute then
   begin
   Name:=pop_main.SaveDialog.FileName;
   if UpperCase(ExtractFileExt(Name))<>'.txt' then Name:=Name+'.txt'; //nolang
   AssignFile(T,Name);
   Rewrite(T);
   try
   i:=0;
//   while i<=LineSeries1.XValues.Count-1 do
   while i<=TASerie2.Count-1 do
      begin
//      Writeln(T,FloatToStrF(LineSeries1.XValues.Value[i],ffFixed,4,2)
//         +' '+FloatToStrF(LineSeries1.YValues.Value[i],ffFixed,4,2));
      Writeln(T,MyFloatToStr(TASerie2.GetXValue(i),2)
         +' '+MyFloatToStr(TASerie2.GetYValue(i),2));
      Inc(i);
      end;
   finally
   System.Close(T);
   end;
   end;
end;

procedure Tpop_anal_monture.ShowTrack(X,Y:Double);
var
XGraph,YGraph:LongInt;
begin
XGraph:=Round(50+(X-Xinit)*20);
YGraph:=Round(50+(Y-Yinit)*20);
Image1.Canvas.Pixels[XGraph,Image1.Height-YGraph]:=clRed;
end;

procedure Tpop_anal_monture.FormShow(Sender: TObject);
begin
UpDateLang(Self);
TASerie1:=TTASerie.Create(TAChart1);
TAChart1.AddSerie(TASerie1);
TASerie2:=TTASerie.Create(TAChart2);
TAChart2.AddSerie(TASerie2);
TASerie3:=TTASerie.Create(TAChart2);
TAChart2.AddSerie(TASerie3);
end;

procedure Tpop_anal_monture.Button1Click(Sender: TObject);
var
   T:TextFile;
   Name:String;
   i:Integer;
begin
pop_main.SaveDialog.Filter:=lang('Fichiers Textes *.txt|*.txt');
if pop_main.SaveDialog.Execute then
   begin
   Name:=pop_main.SaveDialog.FileName;
   if UpperCase(ExtractFileExt(Name))<>'.txt' then Name:=Name+'.txt'; //nolang
   AssignFile(T,Name);
   Rewrite(T);
   try
   i:=0;
   while i<=ListBox1.Items.Count-1 do
      begin
      Writeln(T,ListBox1.Items[i]);
      Inc(i);
      end;
   finally
   System.Close(T);
   end;
   end;
end;

end.
