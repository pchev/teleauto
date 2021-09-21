unit pu_map_monitor;

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
  ExtCtrls, StdCtrls, pu_image, u_class, IniFiles, tagraph;

type
  Tpop_map_monitor = class(TForm)
    Panel5: TPanel;
    Label5: TLabel;
    Label8: TLabel;
    ListBox1: TListBox;
    Button2: TButton;
    Button5: TButton;
    Button1: TButton;
    Label9: TLabel;
    Panel6: TPanel;
    Label1: TLabel;
    Image1: TImage;
    Label4: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Button3: TButton;
    Button4: TButton;
    Panel1: TPanel;
    Image2: TImage;
    TAChart1: TTAChart;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TASerie1,TASerie2,TASerie3:TTASerie;
    TALine:TTALine;

    Init:Boolean;
    TimeInit,XInit,Yinit,Xrms,Yrms,XCumul,YCumul:Double;
    NbPoints,NbPointsSerie:Integer;

    Mesures:PLigDouble;
    NbMesures:Integer;
    MesuresOn:Boolean;
    FwhmMoy,Somme,Larg:Double;
    TypeStr,TypeStrMoy,TypeStrMin:string;
    FinMapV:Boolean;
    YPointe:LongWord;

    NbPointsGraph:Integer;
    XImageMin,YImageMin:Integer;                // Coordonnées Image des limites du graphe
    XImageMax,YImageMax:Integer;
    XGraphMin,YGraphMin:Double;                 // Coordonnées Graphe correspondantes aux points précedents
    XGraphMax,YGraphMax:Double;
    ax,bx,ay,by:Double;                         // Coeff des relation de passage Image<->Graphe
    NbPointsMem:LongWord;                       // Nombre de points pré-réservés en mémoire
    XGraph,YGraph:PLigDouble;                   // Coordonnées Graphe correspondantes aux points précedents
    XImage,YImage:PLigLongWord;                 // Coordonnées Image des points
    XImageLine:PLigLongWord;                    // Coordonnées Image des lignes verticales
    XGraphLine:PLigDouble;                      // Coordonnées Graphe correspondantes aux ligne verticales
    YImageLine:PLigLongWord;                    // Coordonnées Image des lignes horizontales
    YGraphLine:PLigDouble;                      // Coordonnées Graphe correspondantes aux ligne hozizontales
    XPointGraphMax,XPointGraphMin:Double;       // Valeur Graphe max des points
    YPointGraphMax,YPointGraphMin:Double;

    XLast,YLast:Double;

    procedure Add(Time,Sigma:Double;Marque:Boolean;Color:TColor);
    procedure AddV(Y:Double;Pos:Integer);
    procedure AddVLast(Y:Double;Pos:Integer);
    procedure AddMarque(Time,Sigma:Double);
    procedure AddMessage(MyMessage:String);
    procedure AddWithMessage(Time,Sigma:Double;Marque:Boolean);
    procedure AfficheImage(Image:Tpop_image);
    procedure AfficheCercle(X,Y,Diametre:Double);
    procedure ShowLine(MesureCible:Double);
//    procedure ChangeSpeed;
    procedure SetMesure(Nb:Integer);
    procedure SetMesureAdd(Nb:Integer);
    procedure RAZ;

    procedure CreateGraph;
    procedure EffaceGraph;
    procedure DrawAxisGraph;
    procedure XGraphToImageGraph(Xin:Double;var XOut:LongWord);
    procedure YGraphToImageGraph(Yin:Double;var YOut:LongWord);
    procedure GraphToImageGraph(Xin,Yin:Double;var XOut,YOut:LongWord);
    procedure AddGraph(X,Y:Double);
    procedure UpDateGraph;
    procedure DisplayGraph;
    procedure ClearGraph;

    procedure Update;    
  end;

 var
   pop_map_monitor:Tpop_map_monitor;

implementation

{$R *.DFM}

uses u_general,
     pu_main,
     u_lang,
     u_file_io,
     pu_map,
     u_cameras,
     u_visu,
     u_constants,
     pu_dlg_standard,
     pu_camera,
     u_bezier;

procedure Tpop_map_monitor.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
   Ini:TMemIniFile;
   Path:string;
begin
// Sauve la pos
Path:=ExtractFilePath(Application.Exename);
Ini:=TMemIniFile.Create(Path+'TeleAuto.ini'); //nolang
try
Ini.WriteString('WindowsPos','FocMonitorTop',IntToStr(Top)); //nolang
Ini.WriteString('WindowsPos','FocMonitorLeft',IntToStr(Left)); //nolang
Ini.WriteString('WindowsPos','FocMonitorWidth',IntToStr(Width)); //nolang
//Ini.WriteString('WindowsPos','FocMonitorHeight',IntToStr(Height));
finally
Ini.UpdateFile;
Ini.Free;
end;

WriteSpy(lang('Arrêt de la mise au point demandé'));
AddMessage(lang('Arrêt de la mise au point demandé'));
Pop_map.StopMap:=True;

TesteFocalisation:=False;
Action:=caFree;
pop_map_monitor:=nil;
//Series1.Clear;
TASerie3.Clear;
//Series2.Clear;
TASerie2.Clear;
//LineSeries2.Clear;
TASerie1.Clear;
if MesuresOn then
   begin
   Freemem(Mesures,8*NbMesures);
   MesuresOn:=False;
   end;

TALine.Free;

if Assigned(pop_camera.pop_image_acq) then pop_camera.pop_image_acq.Close;

pop_map.btn_auto.Enabled:=True;
pop_map.btn_manuel.Enabled:=True;
pop_map.Button1.Enabled:=True;
pop_map.Button5.Enabled:=True;
pop_map.Button6.Enabled:=True;
pop_map.Button7.Enabled:=True;
pop_map.Edit5.Enabled:=True;
pop_map.SpinButton2.Enabled:=True;
end;

procedure Tpop_map_monitor.AfficheImage(Image:Tpop_image);
var
   Bitmap:TBitmap;
begin
   Larg:=Image.ImgInfos.Sx;
   Bitmap:=TBitmap.Create;
   try
   Bitmap.Handle:=VisuImgAPI(Image.DataInt,Image.DataDouble,Image.ImgInfos,
      1,1,1,Image.ImgInfos.Sx,Image.ImgInfos.Sy,Image.ImgInfos.Sx,Image.ImgInfos.Sy);

   Image1.Canvas.CopyMode:=cmSrcCopy;
   Image1.Canvas.StretchDraw(Rect(0,0,Image1.Width-1,Image1.Height-1),Bitmap);
   finally
   Bitmap.Free;
   end;

end;

procedure Tpop_map_monitor.AfficheCercle(X,Y,Diametre:Double);
var
   Facteur:Double;
begin
Facteur:=Image1.Width/Larg;
Image1.Canvas.Pen.Color:=clRed;
Image1.Canvas.Pen.Mode:=pmCopy;
Image1.Canvas.Pen.Style:=psSolid;
Image1.Canvas.Brush.Style:=bsClear;
Image1.Canvas.Ellipse(Round((X-Diametre/2)*Facteur-1),Round(Image1.Height-(Y-Diametre/2)*Facteur+1),
   Round((X+Diametre/2)*Facteur-1),Round(Image1.Height-(Y+Diametre/2)*Facteur+1));
end;

procedure Tpop_map_monitor.Add(Time,Sigma:Double;Marque:Boolean;Color:TColor);
var
   SigmaArc,SigmaMini:Double;
   i:Integer;
begin
if Init then
   begin
   Init:=False;
   TimeInit:=Time;
{   if not MesuresOn then
      begin
      case pop_map.TrackBar1.Position of
         0:NbMesures:=Config.NbEssaiFocFast;
         1:NbMesures:=Config.NbEssaiFocSlow;
         end;
      Getmem(Mesures,8*NbMesures);
      MesuresOn:=True;
      end;}
   end;

for i:=NbMesures downto 2 do Mesures^[i]:=Mesures^[i-1];
Mesures^[1]:=Sigma;

SigmaMini:=MaxDouble;
for i:=1 to NbMesures do if Mesures^[i]<SigmaMini then  SigmaMini:=Mesures^[i];

// Calcul de la moyenne
Somme:=0;
for i:=1 to NbMesures do Somme:=Somme+Mesures^[i];
FwhmMoy:=Somme/NbMesures;

TASerie1.AddXY((Time-TimeInit)*24*3600,Sigma,clWhite);
if Marque then
   begin
//   TASerie2.AddXY((Time-TimeInit)*24*3600,Sigma,clGreen);
   if Config.UseMoyenne then
      begin
      TASerie3.AddXY((Time-TimeInit)*24*3600,FwhmMoy,Color);
      WriteSpy(TypeStrMoy+' = '+MyFloatToStr(FwhmMoy,2)); //nolang
      AddMessage(TypeStrMoy+' = '+MyFloatToStr(FwhmMoy,2)); //nolang
      Panel5.Caption:=FloatToStrF(FwhmMoy,ffFixed,4,2);
      SigmaArc:=ArcTan(FwhmMoy*Camera.GetXPixelSize/1e6/Config.FocaleTele*1000)*180/Pi*3600;
      Panel6.Caption:=FloatToStrF(SigmaArc,ffFixed,4,2);
      end
   else
      begin
      //Series1.AddXY((Time-TimeInit)*24*3600,SigmaMini,'',clTeeColor);
      TASerie3.AddXY((Time-TimeInit)*24*3600,SigmaMini,Color);
      WriteSpy(TypeStrMin+' = '+MyFloatToStr(SigmaMini,2)); //nolang
      AddMessage(TypeStrMin+' = '+MyFloatToStr(SigmaMini,2)); //nolang
      Panel5.Caption:=FloatToStrF(SigmaMini,ffFixed,4,2);
      SigmaArc:=ArcTan(SigmaMini*Camera.GetXPixelSize/1e6/Config.FocaleTele*1000)*180/Pi*3600;
      Panel6.Caption:=FloatToStrF(SigmaArc,ffFixed,4,2);
      end;
   end;

Inc(NbPoints);

Application.ProcessMessages;
end;

procedure Tpop_map_monitor.AddWithMessage(Time,Sigma:Double;Marque:Boolean);
var
   SigmaArc,SigmaMini:Double;
   i:Integer;
begin
if Init then
   begin
   Init:=False;
   TimeInit:=Time;
{   if not MesuresOn then
      begin
      case pop_map.TrackBar1.Position of
         0:NbMesures:=Config.NbEssaiFocFast;
         1:NbMesures:=Config.NbEssaiFocSlow;
         end;
      Getmem(Mesures,8*NbMesures);
      MesuresOn:=True;
      end;}
   end;

for i:=NbMesures downto 2 do Mesures^[i]:=Mesures^[i-1];
Mesures^[1]:=Sigma;

SigmaMini:=MaxDouble;
for i:=1 to NbMesures do if Mesures^[i]<SigmaMini then  SigmaMini:=Mesures^[i];

// Calcul de la moyenne
Somme:=0;
for i:=1 to NbMesures do Somme:=Somme+Mesures^[i];
FwhmMoy:=Somme/NbMesures;

//Panel5.Caption:=FloatToStrF(Sigma,ffFixed,4,2);

//SigmaArc:=ArcTan(Sigma*Camera.GetXPixelSize/1e6/Config.FocaleTele*1000)*180/Pi*3600;
//Panel6.Caption:=FloatToStrF(SigmaArc,ffFixed,4,2);

//LineSeries2.AddXY((Time-TimeInit)*24*3600,Sigma,'',clTeeColor);
TASerie1.AddXY((Time-TimeInit)*24*3600,Sigma,clWhite);
//if Marque then Series2.AddXY((Time-TimeInit)*24*3600,Sigma,'',clTeeColor);
if Marque then TASerie2.AddXY((Time-TimeInit)*24*3600,Sigma,clGreen);

//AddMessage(lang('FWHM = ')+MyFloatToStr(Sigma,2)+' / FWHM minimale : '+MyFloatToStr(SigmaMini,2));
//AddMessage('Essai '+IntToStr(NbPoints mod Config.NbEssaiFoc+1)
//   +lang(' FWHM = ')+MyFloatToStr(Sigma,2));
//if NbPoints mod Config.NbEssaiFoc+1=Config.NbEssaiFoc then
//   AddMessage('FWHM minimale : '+MyFloatToStr(SigmaMini,2));
if not pop_map.StopMap then
   begin
   WriteSpy(lang('Mesure ')+IntToStr(NbPointsSerie)
      +' '+TypeStr+' = '+MyFloatToStr(Sigma,2)); //nolang
   AddMessage(lang('Mesure ')+IntToStr(NbPointsSerie)
      +' '+TypeStr+' = '+MyFloatToStr(Sigma,2)); //nolang
   if NbPointsSerie=NbMesures then
      begin
      if Config.UseMoyenne then
         begin
         //Series1.AddXY((Time-TimeInit)*24*3600,FwhmMoy,'',clTeeColor);
         TASerie3.AddXY((Time-TimeInit)*24*3600,FwhmMoy,clRed);         
         WriteSpy(TypeStrMoy+' = '+MyFloatToStr(FwhmMoy,2)); //nolang
         AddMessage(TypeStrMoy+' = '+MyFloatToStr(FwhmMoy,2)); //nolang
         Panel5.Caption:=FloatToStrF(FwhmMoy,ffFixed,4,2);
         SigmaArc:=ArcTan(FwhmMoy*Camera.GetXPixelSize/1e6/Config.FocaleTele*1000)*180/Pi*3600;
         Panel6.Caption:=FloatToStrF(SigmaArc,ffFixed,4,2);
         end
      else
         begin
         //Series1.AddXY((Time-TimeInit)*24*3600,SigmaMini,'',clTeeColor);
         TASerie3.AddXY((Time-TimeInit)*24*3600,SigmaMini,clRed);         
         WriteSpy(TypeStrMin+' = '+MyFloatToStr(SigmaMini,2)); //nolang
         AddMessage(TypeStrMin+' = '+MyFloatToStr(SigmaMini,2)); //nolang
         Panel5.Caption:=FloatToStrF(SigmaMini,ffFixed,4,2);
         SigmaArc:=ArcTan(SigmaMini*Camera.GetXPixelSize/1e6/Config.FocaleTele*1000)*180/Pi*3600;
         Panel6.Caption:=FloatToStrF(SigmaArc,ffFixed,4,2);
         end;

      end;
   end;

Inc(NbPoints);
Inc(NbPointsSerie);
if NbPointsSerie=NbMesures+1 then NbPointsSerie:=1;

Application.ProcessMessages;
end;

procedure Tpop_map_monitor.AddMarque(Time,Sigma:Double);
begin
//Series2.AddXY((Time-TimeInit)*24*3600,Sigma,'',clTeeColor);
TASerie2.AddXY((Time-TimeInit)*24*3600,Sigma,clGreen);
NbPointsSerie:=1;
end;

procedure Tpop_map_monitor.AddMessage(MyMessage:String);
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

procedure Tpop_map_monitor.Update;
begin
case Config.TypeMesureFWHM of
   0:begin
     TypeStr:=lang('FWHM');
     TypeStrMoy:=lang('FWHM moyenne');
     TypeStrMin:=lang('FWHM minimale');
//     Button5.Caption:='Sauver FWHM(t)';
     end;
   1:begin
     TypeStr:=lang('HFD');
     TypeStrMoy:=lang('HFD moyen');
     TypeStrMin:=lang('HFD minimal');
//     Button5.Caption:='Sauver HFD(t)';
     end;
   end;

if TypeMapMonitor='Manuel' then //nolang
   begin
   Caption:=lang('Mise au point manuelle');
   Panel1.Visible:=False;
   Label2.Visible:=True;
   Label3.Visible:=True;
   Label4.Visible:=True;
   Label6.Visible:=True;
   Label8.Caption:=lang('HFD/FWHM (Pixels,Secondes) ( ');
   label2.Caption:='+';
   label3.Caption:=' Val.typique';
   label4.Caption:='o';
   label6.Caption:='Manoeuvre )';
   label2.Left:=376;
   label3.Left:=384;
   label4.Left:=442;
   label6.Left:=452;
   Label8.Left:=218;
   if Config.UseMoyenne then
      begin
      Label5.Caption:=TypeStr+lang(' moy (pixels)');
      Label9.Caption:=TypeStr+lang(' moy (arcsec)');
      end
   else
      begin
      Label5.Caption:=TypeStr+lang(' min (pixels)');
      Label9.Caption:=TypeStr+lang(' min (arcsec)');
      end;

   TASerie2.PointStyle:=psCircle;
   end;
if TypeMapMonitor='AutoA' then //nolang
   begin
   Caption:=lang('Autofocus par approximations successives');
   pop_map.Hide;
   Panel1.Visible:=False;
   Label2.Visible:=True;
   Label3.Visible:=True;
   Label4.Visible:=True;
   Label6.Visible:=True;
//   Label8.Caption:=lang('HFD/FWHM (Pixels,Secondes) ( ');
   Label8.Caption:=lang('HFD/FWHM (Pixels,Secondes) (');
   label2.Caption:='+';
   label3.Caption:=' Val.typique )';
   label4.Caption:='';
   label6.Caption:='';
   label2.Left:=406;
   label3.Left:=414;
   label4.Left:=999;
   label6.Left:=999;
   Label8.Left:=250;
   if Config.UseMoyenne then
      begin
      Label5.Caption:=TypeStr+lang(' moy (pixels)');
      Label9.Caption:=TypeStr+lang(' moy (arcsec)');
      end
   else
      begin
      Label5.Caption:=TypeStr+lang(' min (pixels)');
      Label9.Caption:=TypeStr+lang(' min (arcsec)');
      end;
   TASerie2.PointStyle:=psCross;
   end;
if TypeMapMonitor='AutoV' then //nolang
   begin
   Caption:=lang('Autofocus par courbe en V');
   pop_map.Hide;
   Panel1.Visible:=True;
   Label2.Visible:=False;
   Label3.Visible:=False;
   Label4.Visible:=False;
   Label6.Visible:=False;
   Label8.Caption:=lang('HFD (pixels, secondes)');
   Label8.Left:=298; //278
   Button5.Caption:='Sauver HFD';
   Label5.Caption:=lang('HFD moy (pixels)');
   Label9.Caption:=lang('HFD (arcsec)');
   TASerie2.PointStyle:=psCross;
   end;
if TypeMapMonitor='Optim' then //nolang
   begin
   Caption:=lang('Optimisation de la mise au point');
   pop_map.Hide;
   Panel1.Visible:=False;
   Label2.Visible:=True;
   Label3.Visible:=True;
   Label4.Visible:=True;
   Label6.Visible:=True;
   Label8.Left:=218;
   Label8.Caption:=lang('FWHM (Pixels, secondes) (Val.moy. après :');
   label2.Left:=424;
   label2.Caption:='+';
   label3.Left:=435;
   label3.Caption:='recul';
   label4.Left:=462;
   label4.Caption:='+';
   label6.Left:=472;
   label6.Caption:='avance)';

   Button5.Caption:='Sauver FWHM';
   Label5.Caption:=lang('FWHM moy (pixels)');
   Label9.Caption:=lang('FWHM (arcsec)');
   TASerie2.PointStyle:=psCross;
   end;
end;

procedure Tpop_map_monitor.FormCreate(Sender: TObject);
begin
//Panel1.Left:=Chart3.Left;
//Panel1.Top:=Chart3.Top;
//Panel1.Width:=Chart3.Width;
//Panel1.Height:=Chart3.Height;
//Image2.Width:=Chart3.Width;
//Image2.Height:=Chart3.Height;
Panel1.Left:=TAChart1.Left;
Panel1.Top:=TAChart1.Top;
Panel1.Width:=TAChart1.Width;
Panel1.Height:=TAChart1.Height;
Image2.Width:=TAChart1.Width;
Image2.Height:=TAChart1.Height;

TASerie1:=TTASerie.Create(TAChart1);
TAChart1.AddSerie(TASerie1);

TASerie2:=TTASerie.Create(TAChart1);
TAChart1.AddSerie(TASerie2);
TASerie2.ShowPoints:=True;
TASerie2.ShowLines:=False;

TASerie3:=TTASerie.Create(TAChart1);
TAChart1.AddSerie(TASerie3);
TASerie3.ShowPoints:=True;
TASerie3.ShowLines:=False;

TALine:=TTALine.Create(TAChart1);
TAChart1.AddSerie(TALine);
TALine.LineStyle:=lsHorizontal;

CreateGraph;

pop_map.btn_auto.Enabled:=False;
pop_map.btn_manuel.Enabled:=False;
pop_map.Button1.Enabled:=False;
pop_map.Button5.Enabled:=False;
pop_map.Button6.Enabled:=False;
pop_map.Button7.Enabled:=False;
pop_map.Edit5.Enabled:=False;
pop_map.SpinButton2.Enabled:=False;

Update;

MesuresOn:=False;
Init:=True;
ListBox1.Items.Capacity:=1000;
end;

procedure Tpop_map_monitor.RAZ;
begin
Init:=True;
if MesuresOn then
   begin
   Freemem(Mesures,8*NbMesures);
   MesuresOn:=False;
   end;

Xrms:=0;
Yrms:=0;
XCumul:=0;
YCumul:=0;
NbPoints:=0;
NbPointsSerie:=1;

ListBox1.Clear;
//LineSeries2.Clear;
TASerie1.Clear;
//Series1.Clear;
TASerie3.Clear;
//Series2.Clear;
TASerie2.Clear;
Panel5.Caption:='';
Panel6.Caption:='';
end;

procedure Tpop_map_monitor.Button2Click(Sender: TObject);
begin
Button1.Enabled:=False;
Button5.Enabled:=False;
RAZ;
end;

procedure Tpop_map_monitor.Button5Click(Sender: TObject);
var
   T:TextFile;
   Name:String;
   i:Integer;

   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   D1,D2:Boolean;

begin
// Series1
if TypeMapMonitor<>'AutoV' then //nolang
   begin
   New(TabItems);
   try
   for i:=1 to NbMaxItems do TabItems^[i].Msg:='';

   with TabItems^[1] do
      begin
      TypeItem:=tiRadioGroup;
      Msg:=lang('Valeurs à sauver');
      if TypeMapMonitor='Optim' then
         ValeurStrDefaut:=lang('Valeurs élémentaires (Courbe blanche)|Valeurs moyennes (Croix)|')
      else
         ValeurStrDefaut:=lang('Valeurs élémentaires (Courbe blanche)|Valeurs typiques (Croix rouges)|');
      ValeurDefaut:=0;
      end;

   DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,250);
   DlgStandard.Caption:=lang('Sauver valeurs');
   if DlgStandard.ShowModal=mrOK then
      begin
      D1:=TabItems^[1].ValeurSortie=0;
      D2:=TabItems^[1].ValeurSortie=1;

      pop_main.SaveDialog.Filter:=lang('Fichiers Textes *.txt|*.txt');
      if pop_main.SaveDialog.Execute then
         begin
         Name:=pop_main.SaveDialog.FileName;
         if UpperCase(ExtractFileExt(Name))<>'.TXT' then Name:=Name+'.txt'; //nolang
         AssignFile(T,Name);
         Rewrite(T);
         try
         i:=0;
         if D1 then
            while i<=TASerie1.Count-1 do
               begin
               Writeln(T,FloatToStrF(TASerie1.GetXValue(i),ffFixed,4,2)
                  +' '+FloatToStrF(TASerie1.GetYValue(i),ffFixed,4,2));
               Inc(i);
               end;

         if D2 then
            while i<=TASerie3.Count-1 do
               begin
               Writeln(T,FloatToStrF(TASerie3.GetXValue(i),ffFixed,4,2)
                  +' '+FloatToStrF(TASerie3.GetYValue(i),ffFixed,4,2));
               Inc(i);
               end;

         finally
         System.Close(T);
         end;
         end;
      end;

   finally
   Dispose(TabItems);
   end;
   end
else
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
      for i:=1 to NbPointsGraph do
         Writeln(T,FloatToStrF(XGraph^[i],ffFixed,4,2)+' '+FloatToStrF(YGraph^[i],ffFixed,4,2));
      Writeln(T,FloatToStrF(XLast,ffFixed,4,2)+' '+FloatToStrF(YLast,ffFixed,4,2));
      finally
      System.Close(T);
      end;
      end;
   end;
end;

procedure Tpop_map_monitor.FormShow(Sender: TObject);
var
   Ini:TMemIniFile;
   Path:string;
   Valeur:Integer;
begin
// Lit la pos
Path:=ExtractFilePath(Application.Exename);
Ini:=TMemIniFile.Create(Path+'TeleAuto.ini'); //nolang
try
Valeur:=StrToInt(Ini.ReadString('WindowsPos','FocMonitorTop',IntToStr(Self.Top))); //nolang
if Valeur<>0 then Top:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','FocMonitorLeft',IntToStr(Self.Left))); //nolang
if Valeur<>0 then Left:=Valeur;
Valeur:=StrToInt(Ini.ReadString('WindowsPos','FocMonitorWidth',IntToStr(Self.Width))); //nolang
if Valeur<>0 then Width:=Valeur;
//Valeur:=StrToInt(Ini.ReadString('WindowsPos','FocMonitorHeight',IntToStr(Self.Height)));
//if Valeur<>0 then Height:=Valeur;
finally
Ini.UpdateFile;
Ini.Free;
end;

UpDateLang(Self);
NbPointsSerie:=1;

case Config.TypeMesureFWHM of
   0:begin
     TypeStr:=lang('FWHM');
     TypeStrMoy:=lang('FWHM moyenne');
     TypeStrMin:=lang('FWHM minimale');
//     Button5.Caption:='Sauver FWHM(t)';
     end;
   1:begin
     TypeStr:=lang('HFD');
     TypeStrMoy:=lang('HFD moyen');
     TypeStrMin:=lang('HFD minimal');
//     Button5.Caption:='Sauver HFD(t)';
     end;
   end;

//Label8.Caption:=TypeStr+' (Pixels,Secondes)';

{if Config.UseMoyenne then
   begin
   Label5.Caption:=TypeStr+lang(' moy (pixels)');
   Label9.Caption:=TypeStr+lang(' moy (arcsec)');
   end
else
   begin
   Label5.Caption:=TypeStr+lang(' min (pixels)');
   Label9.Caption:=TypeStr+lang(' min (arcsec)');
   end;}
end;

procedure Tpop_map_monitor.Button1Click(Sender: TObject);
var
   T:TextFile;
   Name:String;
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

procedure Tpop_map_monitor.FormResize(Sender: TObject);
begin
{if Height<324 then Height:=324;
Width:=615;
Chart3.Height:=(ClientHeight-30) div 2;
Chart3.Top:=15;
Label1.Top:=(ClientHeight-30) div 2+15;
ListBox1.Height:=(ClientHeight-30) div 2-5;
ListBox1.Top:=(ClientHeight-30) div 2+30;
Button2.Top:=ClientHeight-Button1.Height-Button5.Height-Button2.Height-15;
Button5.Top:=ClientHeight-Button1.Height-Button5.Height-10;
Button1.Top:=ClientHeight-Button1.Height-5;}
end;

{procedure Tpop_map_monitor.ChangeSpeed;
begin
if MesuresOn then
   begin
   Freemem(Mesures,8*NbMesures);
   MesuresOn:=False;
   end;

if not MesuresOn then
   begin
   case pop_map.TrackBar1.Position of
      0:NbMesures:=Config.NbEssaiFocFast;
      1:NbMesures:=Config.NbEssaiFocSlow;
      end;
   Getmem(Mesures,8*NbMesures);
   MesuresOn:=True;
   end;

NbPointsSerie:=1;
end;}

procedure Tpop_map_monitor.SetMesure(Nb:Integer);
begin
if MesuresOn then
   begin
   Freemem(Mesures,8*NbMesures);
   MesuresOn:=False;
   end;

if not MesuresOn then
   begin
   NbMesures:=Nb;
   Getmem(Mesures,8*NbMesures);
   MesuresOn:=True;
   end;

NbPointsSerie:=1;
end;

procedure Tpop_map_monitor.SetMesureAdd(Nb:Integer);
var
   MesuresTmp:PLigDouble;
   i:Integer;
begin
   Getmem(MesuresTmp,8*Nb);
   for i:=1 to NbMesures do MesuresTmp^[i]:=Mesures^[i];
   Freemem(Mesures,8*NbMesures);
   Mesures:=MesuresTmp;
   NbPointsSerie:=Nb;
   NbMesures:=Nb;
end;

procedure Tpop_map_monitor.Button4Click(Sender: TObject);
begin
if DansSerie then
   begin
   WriteSpy(lang('Arrêt de la série demandé'));
   AddMessage(lang('Arrêt de la série demandé'));
   end
else
   begin
   WriteSpy(lang('Arrêt de la mise au point demandé'));
   AddMessage(lang('Arrêt de la mise au point demandé'));
   end;

pop_map.StopMap:=True;
pop_map_monitor.NbPointsSerie:=1;


Button1.Enabled:=True;
Button2.Enabled:=True;
Button3.Enabled:=True;
Button4.Enabled:=False;
Button5.Enabled:=True;
end;

procedure Tpop_map_monitor.Button3Click(Sender: TObject);
begin
Button1.Enabled:=False;
Button2.Enabled:=False;
Button3.Enabled:=False;
Button4.Enabled:=True;
Button5.Enabled:=False;

if pop_camera.pop_image_acq=nil then pop_camera.pop_image_acq:=tpop_image.Create(Application);
if TypeMapMonitor='Manuel' then pop_map.MAPManuel; //nolang
if TypeMapMonitor='AutoA' then //nolang
   begin
   pop_map.Hide;
   pop_map.MapAutoA;
   end;
if TypeMapMonitor='AutoV' then //nolang
   begin
   ClearGraph;
   pop_map.Hide;
   pop_map.MapAutoV;
   end;
if TypeMapMonitor='Optim' then //nolang
   begin
   pop_map.Hide;
   pop_map.MAPOptim;
   end;
end;

//********************************************************************************
//********************************************************************************
//********************************************************************************

procedure Tpop_map_monitor.XGraphToImageGraph(Xin:Double;var XOut:LongWord);
begin
XOut:=Round(ax*XIn+bx);
end;

procedure Tpop_map_monitor.YGraphToImageGraph(Yin:Double;var YOut:LongWord);
begin
YOut:=Round(ay*YIn+by);
end;

procedure Tpop_map_monitor.GraphToImageGraph(Xin,Yin:Double;var XOut,YOut:LongWord);
begin
XGraphToImageGraph(Xin,XOut);
YGraphToImageGraph(Yin,YOut);
end;

procedure Tpop_map_monitor.EffaceGraph;
begin
Image2.Canvas.Pen.Mode:=pmCopy;
Image2.Canvas.Pen.Style:=psSolid;
Image2.Canvas.Pen.Color:=clBtnFace;
Image2.Canvas.Brush.Color:=clBtnFace;
Image2.Canvas.Brush.Style:=bsSolid;
Image2.Canvas.Rectangle(0,0,Image2.Width,Image2.Height);
end;

procedure Tpop_map_monitor.DrawAxisGraph;
var
  NBXGrad,NBYGrad,i,LargTexte,HautTexte:Integer;
  X2,XBezier,YBezier,XTemp,YTemp,XProche1,XProche2,YProche,YExtreme:LongWord;
  MyText:string;
  Marque,Debut,Pas,Grad:Double;
  ZZ:array[0..3] of Tpoint;
  Blength:Integer;
  Brect:TRect;
  a,b:Double;
begin
// Les axes
Image2.Canvas.Pen.Mode:=pmCopy;
Image2.Canvas.Pen.Color:=clBlack;
Image2.Canvas.Pen.Style:=psSolid;
Image2.Canvas.Pen.Width:=2;
Image2.Canvas.MoveTo(XImageMin,YImageMin);
Image2.Canvas.LineTo(XImageMin,YImageMax);
Image2.Canvas.MoveTo(XImageMin,YImageMin);
Image2.Canvas.LineTo(XImageMax,YImageMin);
Image2.Canvas.Pen.Width:=1;
Image2.Canvas.MoveTo(XImageMin,YImageMax);
Image2.Canvas.LineTo(XImageMax,YImageMax);
Image2.Canvas.MoveTo(XImageMax,YImageMin);
Image2.Canvas.LineTo(XImageMax,YImageMax);

// Les graduations en X
CalculIntervales(XGraphMin,XGraphMax,Debut,Pas);
Marque:=Debut;
while Marque<=XGraphMax+Pas*10e-10 do
   begin
   if (Marque>=XGraphMin) then
      begin
      XGraphToImageGraph(Marque,XTemp);
      Image2.Canvas.Pen.Width:=1;
      Image2.Canvas.Pen.Color:=clGray;
      Image2.Canvas.Pen.Style:=psDot;
      if (XTemp<>XImageMax) and (XTemp<>XImageMin) then
         begin
         Image2.Canvas.MoveTo(XTemp,YImageMin);
         Image2.Canvas.LineTo(XTemp,YImageMax);
         end;
      Image2.Canvas.Pen.Color:=clBlack;
      Image2.Canvas.Pen.Style:=psSolid;
      Image2.Canvas.Pen.Mode:=pmCopy;
      Image2.Canvas.MoveTo(XTemp,YImageMin-4);
      Image2.Canvas.LineTo(XTemp,YImageMin+4);
      Image2.Canvas.Font.Height:=10;
      MyText:=MyFloatToStr(Marque,2);
      LargTexte:=Image2.Canvas.TextWidth(MyText) div 2;
      Image2.Canvas.Font.Color:=clBlack;
      Image2.Canvas.TextOut(XTemp-LargTexte,YImageMin+4,MyText);
      end;
   Marque:=Marque+Pas;
   end;

// Les graduations en Y
CalculIntervales(YGraphMin,YGraphMax,Debut,Pas);
Marque:=Debut;
while Marque<=YGraphMax+Pas*10e-10 do
   begin
   if (Marque>=YGraphMin) then
      begin
      YGraphToImageGraph(Marque,YTemp);
      Image2.Canvas.Pen.Width:=1;
      Image2.Canvas.Pen.Color:=clGray;
      Image2.Canvas.Pen.Style:=psDot;
      if (YTemp<>YImageMax) and (YTemp<>YImageMin) then
         begin
         Image2.Canvas.MoveTo(XImageMin,YTemp);
         Image2.Canvas.LineTo(XImageMax,YTemp);
         end;
      Image2.Canvas.Pen.Color:=clBlack;
      Image2.Canvas.Pen.Style:=psSolid;
      Image2.Canvas.Pen.Mode:=pmCopy;
      Image2.Canvas.MoveTo(XImageMin-4,YTemp);
      Image2.Canvas.LineTo(XImageMin+4,YTemp);
      Image2.Canvas.Font.Height:=10;
      MyText:=MyFloatToStr(Marque,2);
      LargTexte:=Image2.Canvas.TextWidth(MyText);
      HautTexte:=Image2.Canvas.TextHeight(MyText) div 2;
      Image2.Canvas.Font.Color:=clBlack;
      Image2.Canvas.TextOut(XImageMin-7-LargTexte,YTemp-HautTexte,MyText);
      end;
   Marque:=Marque+Pas;
   end;

YGraphToImageGraph(Config.DiametreExtreme,YExtreme);
YGraphToImageGraph(Config.DiametreProche,YProche);
XGraphToImageGraph(-Config.DiametreProche/Config.VitesseLente,XProche1);
XGraphToImageGraph(Config.DiametreProche/Config.VitesseLente,XProche2);

// La limite horizontale supérieure De
Image2.Canvas.MoveTo(XImageMin,YExtreme);
Image2.Canvas.LineTo(XImageMax,YExtreme);

// Les obliques
Image2.Canvas.MoveTo(XImageMin,YExtreme);
//Image2.Canvas.LineTo((XImageMax+XImageMin) div 2,YImageMin);
//Image2.Canvas.MoveTo((XImageMax+XImageMin) div 2,YImageMin);
Image2.Canvas.LineTo(XProche1,YProche);
Image2.Canvas.MoveTo(XProche2,YProche);
Image2.Canvas.LineTo(XImageMax,YExtreme);

// La limite horizontale supérieure De-Ms
YGraphToImageGraph(Config.DiametreExtreme-Config.MargeSecurite,YTemp);
Image2.Canvas.MoveTo(XImageMin,YTemp);
Image2.Canvas.LineTo(XImageMax,YTemp);

// La limite horizontale inférieure Dp
Image2.Canvas.MoveTo(XImageMin,YProche);
Image2.Canvas.LineTo(XImageMax,YProche);

// La limite horizontale inférieure Dp+Ms
YGraphToImageGraph(Config.DiametreProche+Config.MargeSecurite,YTemp);
Image2.Canvas.MoveTo(XImageMin,YTemp);
Image2.Canvas.LineTo(XImageMax,YTemp);

{Image2.Canvas.Pen.Color:=clRed;

YPoint:=165;
X2:=(XImageMax+XImageMin) div 2;
//XBezier:=(XProche1+X2) div 2;
//XGraphToImageGraph(-YPoint/Config.VitesseLente,XBezier); //non
//XBezier:=Round(X2-YPoint/Config.VitesseLente); //non
//XBezier:=Round(X2+YPoint/Config.VitesseLente); //non
a:=(YImageMin-YExtreme)/(X2-XImageMin);
b:=YExtreme-a*XImageMin;
XBezier:=Round((YPoint-b)/a);

ZZ[0].x:= XProche1;
ZZ[0].y:= YProche;
ZZ[1].x:= XBezier;
ZZ[1].y:= YPoint;

ZZ[3].x:= X2;
ZZ[3].y:= YPoint;
//ZZ[2].x:= XBezier;
ZZ[2].x:= Round((XBezier+X2)/2);
ZZ[2].y:= YPoint;

Image2.Canvas.MoveTo(ZZ[0].x,ZZ[0].y);
Image2.Canvas.LineTo(ZZ[1].x,ZZ[1].y);
Image2.Canvas.MoveTo(ZZ[2].x,ZZ[2].y);
Image2.Canvas.LineTo(ZZ[3].x,ZZ[3].y);

DrawBezier(ZZ,4,Image2.Canvas,1,clBlack,clBlack,Blength,Brect);

XBezier:=2*X2-XBezier;

ZZ[0].x:= X2;
ZZ[0].y:= YPoint;
ZZ[1].x:= Round((X2+XBezier)/2);
ZZ[1].y:= YPoint;

ZZ[3].x:= XProche2;
ZZ[3].y:= YProche;
ZZ[2].x:= XBezier;
ZZ[2].y:= YPoint;

Image2.Canvas.MoveTo(ZZ[0].x,ZZ[0].y);
Image2.Canvas.LineTo(ZZ[1].x,ZZ[1].y);
Image2.Canvas.MoveTo(ZZ[2].x,ZZ[2].y);
Image2.Canvas.LineTo(ZZ[3].x,ZZ[3].y);

DrawBezier(ZZ,4,Image2.Canvas,1,clBlack,clBlack,Blength,Brect);}

// Bézier à la fin
if FinMapV then
   begin
//   YPointe:=YImage^[NBPointsGraph];

   Image2.Canvas.Pen.Color:=clRed;

   X2:=(XImageMax+XImageMin) div 2;
   a:=(YImageMin-YExtreme)/(X2-XImageMin);
   b:=YExtreme-a*XImageMin;
   XBezier:=Round((YPointe-b)/a);

   ZZ[0].x:= XProche1;
   ZZ[0].y:= YProche;
   ZZ[1].x:= XBezier;
   ZZ[1].y:= YPointe;

   ZZ[3].x:= X2;
   ZZ[3].y:= YPointe;
   //ZZ[2].x:= XBezier;
   ZZ[2].x:= Round((XBezier+X2)/2);
   ZZ[2].y:= YPointe;

{   Image2.Canvas.MoveTo(ZZ[0].x,ZZ[0].y);
   Image2.Canvas.LineTo(ZZ[1].x,ZZ[1].y);
   Image2.Canvas.MoveTo(ZZ[2].x,ZZ[2].y);
   Image2.Canvas.LineTo(ZZ[3].x,ZZ[3].y);}

   DrawBezier(ZZ,4,Image2.Canvas,1,clBlack,clBlack,Blength,Brect);

   XBezier:=2*X2-XBezier;

   ZZ[0].x:= X2;
   ZZ[0].y:= YPointe;
   ZZ[1].x:= Round((X2+XBezier)/2);
   ZZ[1].y:= YPointe;

   ZZ[3].x:= XProche2;
   ZZ[3].y:= YProche;
   ZZ[2].x:= XBezier;
   ZZ[2].y:= YPointe;

{   Image2.Canvas.MoveTo(ZZ[0].x,ZZ[0].y);
   Image2.Canvas.LineTo(ZZ[1].x,ZZ[1].y);
   Image2.Canvas.MoveTo(ZZ[2].x,ZZ[2].y);
   Image2.Canvas.LineTo(ZZ[3].x,ZZ[3].y);}

   DrawBezier(ZZ,4,Image2.Canvas,1,clBlack,clBlack,Blength,Brect);
   end
else
   begin
   // Les obliques proches en pointillés
   Image2.Canvas.Pen.Style:=psDot;
   Image2.Canvas.MoveTo(XProche1,YProche);
   Image2.Canvas.LineTo((XImageMax+XImageMin) div 2,YImageMin);
   //Image2.Canvas.MoveTo((XImageMax+XImageMin) div 2,YImageMin);
   Image2.Canvas.LineTo(XProche2,YProche);
   end;
end;

// A appeller au début
procedure Tpop_map_monitor.CreateGraph;
begin
NbPointsGraph:=0;
// Préservation de mémoire
NbPointsMem:=1000;
GetMem(XGraph,NbPointsMem*8);
GetMem(YGraph,NbPointsMem*8);
GetMem(XImage,NbPointsMem*4);
GetMem(YImage,NbPointsMem*4);
FillChar(XGraph^,NbPointsMem*8,0);
FillChar(YGraph^,NbPointsMem*8,0);
FillChar(XImage^,NbPointsMem*4,0);
FillChar(YImage^,NbPointsMem*4,0);

// Max fixe à 1000
GetMem(XImageLine,1000*4);
GetMem(YImageLine,1000*4);
GetMem(XGraphLine,1000*8);
GetMem(YGraphLine,1000*8);
FillChar(XGraphLine^,1000*8,0);
FillChar(YGraphLine^,1000*8,0);
FillChar(XImageLine^,1000*4,0);
FillChar(YImageLine^,1000*4,0);

EffaceGraph;
XImageMin:=35;
YImageMin:=Image2.Height-20;
XImageMax:=Image2.Width-10;
YImageMax:=10;

// On connait déjà les limites
YGraphMin:=0;
YGraphMax:=Config.DiametreExtreme*1.1;
XGraphMin:=-Config.DiametreExtreme/Config.VitesseLente;
XGraphMax:=Config.DiametreExtreme/Config.VitesseLente;

// Calcul des relations de passage
ax:=(XImageMax-XImageMin)/(XGraphMax-XGraphMin);
bx:=XImageMax-ax*XGraphMax;
ay:=(YImageMax-YImageMin)/(YGraphMax-YGraphMin);
by:=YImageMax-ay*YGraphMax;

DrawAxisGraph;

XPointGraphMax:=-MaxDouble;
XPointGraphMin:=MaxDouble;
YPointGraphMax:=-MaxDouble;
YPointGraphMin:=MaxDouble;

end;

procedure Tpop_map_monitor.AddGraph(X,Y:Double);
var
   Tolerance,Valeur:Double;
   i:Integer;
begin
// TODO : Si le nb de points et supérieur à la mémoire -> augmenter la mémoire
if NBPointsGraph+1>NBPointsMem then
   begin

   end;

// Ajout des points
Inc(NBPointsGraph);
XGraph^[NbPointsGraph]:=X;
YGraph^[NbPointsGraph]:=Y;

GraphToImageGraph(X,Y,XImage^[NBPointsGraph],YImage^[NBPointsGraph]);
UpdateGraph;
end;

procedure Tpop_map_monitor.UpDateGraph;
begin
EffaceGraph;
DrawAxisGraph;
DisplayGraph;
//DrawLinesGraph;
end;

procedure Tpop_map_monitor.DisplayGraph;
var
   i,Larg,LargTexte:Integer;
begin
Larg:=3;
for i:=1 to NbPointsGraph do
   begin
   Image2.Canvas.Pen.Mode:=pmCopy;
   Image2.Canvas.Pen.Color:=clBlue;
   Image2.Canvas.Pen.Style:=psSolid;
   Image2.Canvas.Pen.Width:=2;
   Image2.Canvas.Brush.Style:=bsClear;
   Image2.Canvas.Ellipse(XImage^[i]-Larg,YImage^[i]-Larg,XImage^[i]+Larg+1,YImage^[i]+Larg+1);
   LargTexte:=Image2.Canvas.TextWidth(IntToStr(i)) div 2;
   Image2.Canvas.Font.Color:=clBlue;
   Image2.Canvas.TextOut(XImage^[i]-LargTexte,YImage^[i]-2*Larg-4-Image2.Canvas.Font.Height,IntToStr(i));
   end;
Image2.Update;
Application.ProcessMessages;
end;

procedure Tpop_map_monitor.AddV(Y:Double;Pos:Integer);
var
   X:Double;
   i:Integer;
   Trouve:Boolean;
begin
Trouve:=False;
for i:=1 to NbPointsGraph do
   if Y=XGraph^[i] then Trouve:=True;

if not Trouve then
   begin
   if (NbPointsGraph=1) and (YGraph^[1]>Config.DiametreProche) then
      begin
      XGraph^[1]:=Pos*YGraph^[1]/Config.DiametreExtreme*XGraphMax;
      GraphToImageGraph(XGraph^[1],YGraph^[1],XImage^[1],YImage^[1]);
      end;

   X:=Pos*Y/Config.DiametreExtreme*XGraphMax;

   AddGraph(X,Y);
   end;
end;

procedure Tpop_map_monitor.AddVLast(Y:Double;Pos:Integer);
var
   X:Double;
   XTemp,YTemp:LongWord;
begin
//XGraph^[1]:=Pos*YGraph^[1]/Config.DiametreExtreme*XGraphMax;
//GraphToImageGraph(XGraph^[1],YGraph^[1],XImage^[1],YImage^[1]);

//X:=Pos*Y/Config.DiametreExtreme*XGraphMax;
YLast:=Y;
XLast:=Pos*YLast/Config.DiametreExtreme*XGraphMax;

GraphToImageGraph(XLast,YLast,XTemp,YTemp);


GraphToImageGraph(X,Y,XTemp,YTemp);

YPointe:=YTemp;
pop_map_monitor.FinMapV:=True;
UpDateGraph;
pop_map_monitor.FinMapV:=False;

Image2.Canvas.Pen.Mode:=pmCopy;
Image2.Canvas.Pen.Color:=clRed;
Image2.Canvas.Pen.Style:=psSolid;
Image2.Canvas.Pen.Width:=2;
Image2.Canvas.Brush.Style:=bsClear;
Image2.Canvas.Ellipse(XTemp-3,YTemp-3,XTemp+3+1,YTemp+3+1);
end;

procedure Tpop_map_monitor.ClearGraph;
begin
NbPointsGraph:=0;
FreeMem(XGraph,NbPointsMem*8);
FreeMem(YGraph,NbPointsMem*8);
FreeMem(XImage,NbPointsMem*4);
FreeMem(YImage,NbPointsMem*4);

// Max fixe à 1000
FillChar(XGraphLine^,1000*8,0);
FillChar(YGraphLine^,1000*8,0);
FillChar(XImageLine^,1000*4,0);
FillChar(YImageLine^,1000*4,0);

// Preservation de mémoire
NbPointsMem:=1000;
GetMem(XGraph,NbPointsMem*8);
GetMem(YGraph,NbPointsMem*8);
GetMem(XImage,NbPointsMem*4);
GetMem(YImage,NbPointsMem*4);
FillChar(XGraph^,NbPointsMem*8,0);
FillChar(YGraph^,NbPointsMem*8,0);
FillChar(XImage^,NbPointsMem*4,0);
FillChar(YImage^,NbPointsMem*4,0);

EffaceGraph;
DrawAxisGraph;
XPointGraphMax:=MinDouble;
XPointGraphMin:=MaxDouble;
YPointGraphMax:=MinDouble;
YPointGraphMin:=MaxDouble;
end;

procedure Tpop_map_monitor.ShowLine(MesureCible:Double);
begin
TALine.Position:=MesureCible;
TALine.Pen.Color:=clBlack;
TALine.Visible:=True;
end;

end.
