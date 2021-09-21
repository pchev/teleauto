unit pu_decalage_obs;

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
  Tpop_decalage_obs = class(TForm)
    outListView1: TListView;
    BitBtn1: TBitBtn;
    BitBtn4: TBitBtn;
    NbreEdit1: NbreEdit;
    Label1: TLabel;
    NbreEdit2: NbreEdit;
    Label2: TLabel;
    BitBtn5: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn5Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }

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
     pu_image;

procedure Tpop_decalage_obs.FormShow(Sender: TObject);
var
   F:TextFile;
   Line,Nom:string;
   PosEsp:Integer;
   ListItem:TListItem;
   Path:string;
begin
   Path:=ExtractFileDir(Application.ExeName);
   UpDateLang(Self);

   outListView1.Items.Clear;

   if FileExists(Path+'Shift.dcl') then //nolang
      begin
      AssignFile(F,Path+'Shift.dcl'); //nolang
      Reset(F);
      try
      while not(Eof(F)) do
         begin
         ListItem:=outListView1.Items.Add;
         Readln(F,Line);

         PosEsp:=Pos(' ',Line);
         Listitem.Caption:=Copy(Line,1,PosEsp-1);
         Delete(Line,1,PosEsp);


         Listitem.SubItems.Add(Trim(Line));
         end;

      finally
      CloseFile(F);
      end;
   end;

end;

procedure Tpop_decalage_obs.BitBtn4Click(Sender: TObject);
begin
   outListView1.Items.Clear;
end;

procedure Tpop_decalage_obs.BitBtn1Click(Sender: TObject);
var
   ListItem:TListItem;
begin
   ListItem:=outListView1.Items.Add;
   Listitem.Caption:=NbreEdit1.Text;
   Listitem.SubItems.Add(NbreEdit2.Text);
end;

procedure Tpop_decalage_obs.Button2Click(Sender: TObject);
begin
Close;
end;

procedure Tpop_decalage_obs.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=CaFree;
end;

procedure Tpop_decalage_obs.BitBtn5Click(Sender: TObject);
var
   T:TextFile;
   i:Integer;
   ListItem:TListItem;
   Path:string;
begin
   Path:=ExtractFileDir(Application.ExeName);

   AssignFile(T,Path+'Shift.dcl'); //nolang
   Rewrite(T);
   try
   i:=0;
   while i<=outListView1.Items.Count-1 do
      begin
      ListItem:=outListView1.Items[i];
      Writeln(T,ListItem.Caption+' '+ListItem.SubItems[0]);
      Inc(i);
      end;
   finally
   System.Close(T);
   end;

Close;
end;

end.
