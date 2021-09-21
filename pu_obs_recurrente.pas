unit pu_obs_recurrente;

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
  Mask, Spin, StdCtrls, Buttons, ComCtrls, Editnbre, ExtCtrls;

type
  Tpop_obs_recurrente = class(TForm)
    Button1: TButton;
    ListView1: TListView;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    SpinEdit1: TSpinEdit;
    MaskDelta: TMaskEdit;
    MaskAlpha: TMaskEdit;
    outLabel17: TLabel;
    outLabel22: TLabel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    NbreEdit1: NbreEdit;
    Label4: TLabel;
    Label5: TLabel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Button2: TButton;
    Label6: TLabel;
    NbreEdit2: NbreEdit;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    Fin:Boolean;
    Boucle:Integer;
  end;

implementation

{$R *.DFM}

uses pu_main,
     u_lang,
     u_general,
     u_telescopes,
     u_meca,
     u_cameras,
     pu_camera,
     u_hour_servers,
     pu_image,
     pu_scope,
     u_file_io;

procedure Tpop_obs_recurrente.FormCreate(Sender: TObject);
begin
   MaskAlpha.EditMask:='!90'+Config.SeparateurHeuresMinutesAlpha+'00'+Config.SeparateurMinutesSecondesAlpha+'00'+ //nolang
      Config.UnitesSecondesAlpha+';1;_'; //nolang
   MaskDelta.EditMask:='!#90'+Config.SeparateurDegresMinutesDelta+'00'+Config.SeparateurMinutesSecondesDelta+'00'+ //nolang
      Config.UnitesSecondesDelta+';1;_'; //nolang
   NbreEdit2.Text:=MyFloatToStr(Config.Pose1,2);
end;

procedure Tpop_obs_recurrente.FormShow(Sender: TObject);
begin
   UpDateLang(Self);
end;

procedure Tpop_obs_recurrente.BitBtn4Click(Sender: TObject);
begin
   ListView1.Items.Clear;
   BitBtn2.Enabled:=False;
   Button1.Enabled:=False;
end;

procedure Tpop_obs_recurrente.BitBtn1Click(Sender: TObject);
var
   ListItem:TListItem;
begin
   ListItem:=ListView1.Items.Add;
   Listitem.Caption:=Edit1.Text;
   Listitem.SubItems.Add(SpinEdit1.Text);
   Listitem.SubItems.Add(NbreEdit2.Text);
   Listitem.SubItems.Add(MaskAlpha.Text);
   Listitem.SubItems.Add(MaskDelta.Text);
   BitBtn2.Enabled:=True;
   Button1.Enabled:=True;
end;

procedure Tpop_obs_recurrente.BitBtn2Click(Sender: TObject);
var
   T:TextFile;
   Nom:String;
   i:Integer;
   ListItem:TListItem;
begin
pop_main.SaveDialog.Filter:=lang('Fichiers observation *.obs|*.obs');
pop_main.SaveDialog.InitialDir:=Config.RepImages;
if pop_main.SaveDialog.Execute then
   begin
   Nom:=pop_main.SaveDialog.FileName;
   if UpperCase(ExtractFileExt(Nom))<>'.OBS' then Nom:=Nom+'.OBS'; //nolang
   AssignFile(T,Nom);
   Rewrite(T);
   try
   Writeln(T,NbreEdit1.Text);
   i:=0;
   while i<=ListView1.Items.Count-1 do
      begin
      ListItem:=ListView1.Items[i];
      Writeln(T,ListItem.Caption+' '+ListItem.SubItems[0]+' '+ListItem.SubItems[1]+' '+ListItem.SubItems[2]+' '+ListItem.SubItems[3]);
      Inc(i);
      end;
   finally
   System.Close(T);
   end;
   end;
end;

procedure Tpop_obs_recurrente.Button2Click(Sender: TObject);
begin
Fin:=True;
Close;
end;

procedure Tpop_obs_recurrente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Timer1.Enabled:=False;
Action:=CaFree;
end;

procedure Tpop_obs_recurrente.BitBtn3Click(Sender: TObject);
var
   F:TextFile;
   Line,Nom:string;
   PosEsp:Integer;
   ListItem:TListItem;
begin
ListView1.Items.Clear;

pop_main.OpenDialog.Filter:=lang('Fichiers observation *.obs|*.obs');
pop_main.Opendialog.InitialDir:=Config.RepImages;
if pop_main.OpenDialog.Execute then
   begin
   Nom:=pop_main.OpenDialog.FileName;
   AssignFile(F,Nom);
   Reset(F);
   try
   Readln(F,Line);
   NbreEdit1.Text:=Trim(Line);

   while not(Eof(F)) do
      begin
      ListItem:=ListView1.Items.Add;
      Readln(F,Line);

      PosEsp:=Pos(' ',Line);
      Listitem.Caption:=Copy(Line,1,PosEsp-1);
      Delete(Line,1,PosEsp);

      PosEsp:=Pos(' ',Line);
      Listitem.SubItems.Add(Copy(Line,1,PosEsp-1));
      Delete(Line,1,PosEsp);

      PosEsp:=Pos(' ',Line);
      Listitem.SubItems.Add(Copy(Line,1,PosEsp-1));
      Delete(Line,1,PosEsp);

      PosEsp:=Pos(' ',Line);
      Listitem.SubItems.Add(Copy(Line,1,PosEsp-1));
      Delete(Line,1,PosEsp);

      Listitem.SubItems.Add(Trim(Line));
      end;

   finally
   CloseFile(F);
   end;

   end;

BitBtn2.Enabled:=True;
Button1.Enabled:=True;
end;

procedure Tpop_obs_recurrente.Button1Click(Sender: TObject);
var
   Alpha,Delta,Pose:Double;
   Nbre,i,j:Integer;
   Nom:string;
   ListItem:TListItem;
   RestePhoto,DoImage:Boolean;
//   HauteurFin,AzimuthFin:Double;
//   a,b,Azimuth1,Azimuth2,Hauteur1,Hauteur2,Hauteur3:Double;
   x1,y1,x2,y2:Integer;
   Index:Integer;
   Error:string;
begin
pop_camera.Show;
if pop_camera.pop_image_acq=nil then
    pop_camera.pop_image_acq:=tpop_image.Create(Application);

Index:=0;
RestePhoto:=True;
Fin:=False;
while RestePhoto and not(Fin) do
   begin
   Inc(Index);
   RestePhoto:=False;
   for i:=0 to ListView1.Items.Count-1 do
      begin
      ListItem:=ListView1.Items[i];
      Nom:=ListItem.Caption;
      Nbre:=StrToInt(ListItem.SubItems[0]);
      Pose:=MyStrToFloat(ListItem.SubItems[1]);
      Alpha:=StrToAlpha(ListItem.SubItems[2]);
      Delta:=StrToDelta(ListItem.SubItems[3]);

      DoImage:=True;

      if DoImage then
         begin
         RestePhoto:=True;

         if not Telescope.Pointe(Alpha,Delta) then
            begin
            ShowMessage(lang('Le télescope ne veut pas pointer les coordonnées'));
            TelescopeErreurFatale;
            Exit;
            end;

         Error:=Telescope.GetError;
         if Error<>'' then
             MessageDlg(Error,mtError,[mbOk],0)
         else
            begin
            if not Telescope.WaitPoint(Alpha,Delta) then
               begin
               WriteSpy('Le télescope n''est pas arrivé sur les coordonnées demandées');
               pop_Main.AfficheMessage(lang('Erreur'),
                  'Le télescope n''est pas arrivé sur les coordonnées demandées');
               TelescopeErreurFatale;
               Exit;
               end;

            if Config.GoodPos then
               begin
               Alpha:=Config.AlphaScope;
               Delta:=Config.DeltaScope;
               end
            else
               begin
               WriteSpy(lang('Le télescope ne veut pas donner sa position'));
               pop_Main.AfficheMessage(lang('Erreur'),
                  lang('Le télescope ne veut pas donner sa position'));
               end;

            // On prends la serie de photos
            x1:=1;
            y1:=1;
            x2:=Camera.GetXSize;
            y2:=Camera.GetYSize;
            for j:=1 to Nbre do
               begin
               pop_camera.Acquisition(x1,y1,x2,y2,Pose,1,False);
               pop_camera.pop_image_acq.VisuAutoEtoiles;
               pop_camera.pop_image_acq.SaveImage(Nom+IntToStr(Index)+'-'+IntToStr(j));
               if Fin then Break;
               end;
            end;
         end;
      if Fin then Break;
      end;
   end;

   // Pointe le meridien et l'equateur et reste y
   Timer1.Enabled:=True;
   Boucle:=0;

end;

procedure Tpop_obs_recurrente.Timer1Timer(Sender: TObject);
var
   Alpha,Delta:Double;
   Error:string;
begin
   inc(Boucle);
   if Boucle=1 then
      begin
      GetAlphaDeltaFromHor(GetHourDT,45,0,Config.Lat,Config.Long,Alpha,Delta);
      Delta:=0;

      // Aie ! Tout va mal la !
      if not Telescope.Pointe(Alpha,Delta) then
         begin
         ShowMessage(lang('Le télescope ne veut pas pointer les coordonnées'));
         TelescopeErreurFatale;
         Exit;
         end;

      Error:=Telescope.GetError;
      if Error<>'' then
         MessageDlg(Error,mtError,[mbOk],0)
      else
         if not Telescope.WaitPoint(Alpha,Delta) then
            begin
            WriteSpy('Le télescope n''est pas arrivé sur les coordonnées demandées');
            pop_Main.AfficheMessage(lang('Erreur'),
               'Le télescope n''est pas arrivé sur les coordonnées demandées');
            TelescopeErreurFatale;
            Exit;
            end
         else if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);

      end;
   if Boucle>600 then Boucle:=0;
end;

end.
