unit pu_rapport;

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
  Buttons, StdCtrls, Printers, ClipBrd;

type
  Tpop_rapport = class(TForm)
    ListBox1: TListBox;
    Quitter: TButton;
    SaveDialog1: TSaveDialog;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure QuitterClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    flag:byte; // indique l utilisation de pop_rapport
               // 1 = modelisation de toutes les etoiles
    IsUsedByAnImage:Boolean;
    Image:TComponent;

    procedure AddLine(Line:string);
    procedure TraceMem(Line:string);
    procedure EnableButtons;

  end;

implementation

{$R *.DFM}

uses u_general,
     pu_main,
     u_lang,
     pu_image;

// Utiliser toujours cette procedure pour gerer l'autoscroll
procedure Tpop_rapport.AddLine(Line:String);
const
   Max=5000;
var
   Nbre:integer;
begin
if ListBox1.Items.Count>Max then ListBox1.Items.Delete(0);
ListBox1.Items.Add(Line);

Nbre:=ListBox1.Height div ListBox1.ItemHeight;

if ListBox1.Items.Count<Nbre then ListBox1.TopIndex:=0
else ListBox1.TopIndex:=ListBox1.Items.Count-Nbre;

//ListBox1.items.Add(Line);
//if ListBox1.Items.Count>14 then ListBox1.TopIndex:=ListBox1.Items.Count-14;
//ListBox1.Update;
Application.ProcessMessages;
end;

procedure Tpop_rapport.TraceMem(Line:string);
var
   HeapStatus:THeapStatus;
begin
HeapStatus:=GetHeapStatus;
AddLine(Line+' : '+Inttostr(HeapStatus.TotalAllocated div 1024)+'kb'); //nolang
end;


procedure Tpop_rapport.QuitterClick(Sender: TObject);
begin
//if IsUsedByAnImage then (Image as Tpop_image).Rapport:=nil;

Close;
end;

procedure Tpop_rapport.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var
  i:integer;
  pop_image:Tpop_image;
begin
// on enleve le flag indiquant qu une instance de pop_image a demande une modelisation
// stellaire
for i:=0 to pop_main.mdichildcount-1 do
   if pop_main.mdichildren[i] is tpop_image then
      if pop_main.mdichildren[i].tag=1 then pop_main.mdichildren[i].tag:=0;
// et on ferme
// Non, souvent Philippe a pas fait ca
//if Owner is TPop_Image then (Owner as Tpop_image).Rapport:=nil;
//if IsUsedByAnImage then (Image as Tpop_image).Rapport:=nil
//else if Owner is TPop_Image then (Owner as Tpop_image).Rapport:=nil;
if Owner is TPop_Image then
   begin
   pop_image:=(Owner as TPop_Image);
   if Assigned(pop_image) then pop_image.Rapport:=nil;
   end;
Action:=caFree;
end;

// Save
procedure Tpop_rapport.BitBtn1Click(Sender: TObject);
var
T:TextFile;
Name:String;
i:Integer;
begin
SaveDialog1.InitialDir:=config.RepImages;
if SaveDialog1.Execute then
   begin
   Name:=SaveDialog1.FileName;
   if UpperCase(ExtractFileExt(Name))<>'.TXT' then Name:=Name+'.txt'; //nolang
   AssignFile(T,Name);
   Rewrite(T);
   for i:=0 to ListBox1.Items.Count-1 do
      Writeln(T,ListBox1.Items[i]);
   CloseFile(T);
   end;
end;

procedure Tpop_rapport.FormCreate(Sender: TObject);
begin
SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
Quitter.Enabled:=False;
BitBtn1.Enabled:=False;
BitBtn2.Enabled:=False;
BitBtn3.Enabled:=False;
end;

procedure Tpop_rapport.FormResize(Sender: TObject);
begin
ListBox1.Width:=ClientWidth-7;
ListBox1.Height:=ClientHeight-40;
Quitter.Left:=(ClientWidth-Quitter.Width) div 2;
Quitter.Top:=ClientHeight-30;
BitBtn1.Top:=ClientHeight-30;
BitBtn2.Top:=ClientHeight-30;
BitBtn3.Top:=ClientHeight-30;
end;

// Print
// Print
procedure Tpop_rapport.BitBtn2Click(Sender: TObject);
var
Prn:TextFile;
i:word;
begin
Printer.Canvas.Font.Name:='Fixedsys'; //nolang
Printer.Canvas.Font.Size:=9;
Printer.Canvas.Font.Pitch:=fpFixed;
AssignPrn(Prn);
try
  Rewrite(Prn);
  try
    for i := 0 to ListBox1.Items.Count - 1 do
      writeln(Prn,ListBox1.Items[i]);
  finally
    CloseFile(Prn);
  end;
except
  on EInOutError do
    MessageDlg(lang('Erreur d''impression'), mtError, [mbOk], 0);
end;
end;

// Copy To Clipboard
procedure Tpop_rapport.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
i:Integer;
ClipBoardString:String;
begin
ClipBoard.Open;
try
ClipBoard.Clear;
if ((Shift=[ssCtrl]) and (Key=vk_Insert))
   or ((Shift=[ssCtrl]) and (Key=Ord('c'))) then
   begin
   ClipBoardString:='';
   for i:=0 to ListBox1.Items.Count-1 do
      if ListBox1.Selected[i] then ClipBoardString:=ClipBoardString+ListBox1.Items[i]+#13#10;
   ClipBoard.AsText:=ClipBoardString;
   end;
finally
ClipBoard.Close;
end;
end;

procedure Tpop_rapport.ListBox1Click(Sender: TObject);
var
i:integer;
x,y:double;
x1,x2,y1,y2,sx,sy:integer;
s:string;
found:boolean;
therect:trect;
begin
     // sort si pop rapport est utilisee pour faire autre chose que la modelisation stellaire
     if flag<>1 then exit;
     found:=false;
     for i:=0 to listbox1.items.count-1 do
     begin
          if listbox1.selected[i] then
          begin
               s:=listbox1.Items[i];
               x:=mystrtofloat(copy(s,1,6));
               y:=mystrtofloat(copy(s,13,6));
               found:=true;
          end;
          if found then break;
     end;
     // on cherche la taille de la fenetre
     for i:=0 to pop_main.mdichildcount-1 do
     begin
          if pop_main.mdichildren[i] is tpop_image then
          begin
               if pop_main.mdichildren[i].tag=1 then
               begin
                    sx:=tpop_image(pop_main.mdichildren[i]).img_box.width;
                    sy:=tpop_image(pop_main.mdichildren[i]).img_box.height;
               end;
          end;
     end;
     // dessine un marker a x,y
     x1:=round(x)-2;
     x2:=round(x)+2;
     y1:=sy-round(y)-2;
     y2:=sy-round(y)+2;
     therect:=rect(x1,y1,x2,y2);
     // faut retrouver quel children a demande une modelisation stellaire, si on
     // a plusieurs images ouvertes par exemple
     for i:=0 to pop_main.mdichildcount-1 do
     begin
          if pop_main.mdichildren[i] is tpop_image then
          begin
               if pop_main.mdichildren[i].tag=1 then
               begin
                    tpop_image(pop_main.mdichildren[i]).img_box.Canvas.Brush.Color := clRED;
                    tpop_image(pop_main.mdichildren[i]).img_box.Canvas.FrameRect(theRECT);
               end;
          end;
     end;
end;

procedure Tpop_rapport.FormShow(Sender: TObject);
begin
Left:=Screen.Width-Width;
UpDateLang(Self);
end;

procedure Tpop_rapport.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
// ne pas fermer avec la croix pendant le travail
CanClose:=Quitter.Enabled;
end;

procedure Tpop_rapport.SpeedButton1Click(Sender: TObject);
var
i:Integer;
ClipBoardString:String;
begin
ClipBoard.Open;
try

ClipBoard.Clear;
ClipBoardString:='';
for i:=0 to ListBox1.Items.Count-1 do
   if ListBox1.Selected[i] then ClipBoardString:=ClipBoardString+ListBox1.Items[i]+#13#10;
ClipBoard.AsText:=ClipBoardString;

finally
ClipBoard.Close;
end;
end;

procedure Tpop_rapport.EnableButtons;
begin
BitBtn1.Enabled:=True;
BitBtn2.Enabled:=True;
BitBtn3.Enabled:=True;
Quitter.Enabled:=True;
end;


procedure Tpop_rapport.BitBtn3Click(Sender: TObject);
var
i:Integer;
ClipBoardString:String;
begin
ClipBoard.Open;
try

ClipBoard.Clear;
ClipBoardString:='';
for i:=0 to ListBox1.Items.Count-1 do
   if ListBox1.Selected[i] then ClipBoardString:=ClipBoardString+ListBox1.Items[i]+#13#10;
ClipBoard.AsText:=ClipBoardString;

finally
ClipBoard.Close;
end;
end;

end.
