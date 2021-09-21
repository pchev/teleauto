unit pu_info_hdr;

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
  StdCtrls, Buttons;

type
  Tpop_info_hdr = class(TForm)
    btn_cancel: TBitBtn;
    SpeedButton1: TSpeedButton;
    OpenDialog1: TOpenDialog;
    Memo: TMemo;
    procedure load_the_header(s:string);
    procedure memoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pop_info_hdr: Tpop_info_hdr;
  modified:boolean;

implementation

{$R *.DFM}

uses u_file_io,
     pu_main,
     u_general,
     u_class,
     u_constants,
     u_lang;


procedure tpop_info_hdr.load_the_header(s:string);
var
i,j:integer;
hcpa3: TEnteteCPA_Ver3;
hcpa4: TEnteteCPA_Ver4c;
NumCpa:Byte;
hdr: TPicHeader;
toto:p_string_item;
liste:tlist;
tmp:string;
begin
     if uppercase(extractfileext(s))='.PIC' then //nolang
     begin
          ReadPicHeader(s,hdr);
          memo.Lines.clear;
          memo.Lines.add(lang('Signature        : ')+inttostr(hdr.Signature));
          memo.Lines.add(lang('Version          : ')+inttostr(hdr.Version));
          memo.Lines.add(lang('Taille Header    : ')+inttostr(hdr.Headersize));
          memo.Lines.add(lang('Nom              : ')+hdr.nom);
          memo.Lines.add(lang('NomSuivant       : ')+hdr.NomSuivant);
          memo.Lines.add(lang('Largeur (X)      : ')+inttostr(hdr.Sx));
          memo.Lines.add(lang('Hauteur (Y)      : ')+inttostr(hdr.Sy));
          memo.Lines.add(lang('Dim. données     : ')+inttostr(hdr.Dimdonnees));
          memo.Lines.add(lang('Type données     : ')+inttostr(hdr.Typedonnees));
          memo.Lines.add(lang('Réservé          : ')+inttostr(hdr.Reserve));
          memo.Lines.add(lang('Camera           : ')+inttostr(hdr.Camera));
          memo.Lines.add('X1               : '+inttostr(hdr.X1)); //nolang
          memo.Lines.add('Y1               : '+inttostr(hdr.Y1)); //nolang
          memo.Lines.add('X2               : '+inttostr(hdr.X2)); //nolang
          memo.Lines.add('Y2               : '+inttostr(hdr.Y2)); //nolang
          memo.Lines.add(lang('Binning X        : ')+inttostr(hdr.BinX));
          memo.Lines.add(lang('Binning Y        : ')+inttostr(hdr.BinY));
          memo.Lines.add(lang('Nombre de plans  : ')+inttostr(hdr.NBPlans));
          SetLength(Tmp,10);
          Tmp:='          '; //nolang
          for i:=1 to 10 do Tmp[i]:=hdr.Date[i];
          memo.Lines.add(lang('Date             : ')+Tmp);
          SetLength(Tmp,14);
          Tmp:='              '; //nolang
          for i:=1 to 14 do Tmp[i]:=hdr.Heure[i];
          memo.Lines.add(lang('Heure            : ')+Tmp);
          memo.Lines.add(lang('Seuil maximum    : ')+inttostr(hdr.Max));
          memo.Lines.add(lang('Seuil minimum    : ')+inttostr(hdr.Min));
          memo.Lines.add(lang('Frac maximum     : ')+inttostr(hdr.FracMax));
          memo.Lines.add(lang('Frac minimum     : ')+inttostr(hdr.FracMin));
          memo.Lines.add(lang('Temps de pose    : ')+inttostr(hdr.TpsInt));
          SetLength(Tmp,80);
          for i:=1 to 80 do Tmp:=Tmp+' ';
          for i:=1 to 80 do Tmp[i]:=hdr.Comm1[i];
          memo.Lines.add(lang('Commentaire 1    : ')+Tmp);
          SetLength(Tmp,80);
          for i:=1 to 80 do Tmp:=Tmp+' ';
          for i:=1 to 80 do Tmp[i]:=hdr.Comm2[i];
          memo.Lines.add(lang('Commentaire 2    : ')+Tmp);
     end;

     if uppercase(extractfileext(s))='.CPA' then //nolang
     begin
          readcpaheader(s,hcpa3,hcpa4,NumCpa);
          memo.Lines.clear;
          case NumCpa of
             3:begin
               memo.Lines.add(lang('Signature        : ')+inttostr(hcpa3.Signature));
               memo.Lines.add(lang('Largeur (X)      : ')+inttostr(hcpa3.Largeur));
               memo.Lines.add(lang('Longueur (Y)     : ')+inttostr(hcpa3.Longueur));
               memo.Lines.add(lang('Binning X        : ')+inttostr(hcpa3.BinningX));
               memo.Lines.add(lang('Binning Y        : ')+inttostr(hcpa3.BinningY));
               memo.Lines.add(lang('Seuils Haut      : ')+floattostrf(hcpa3.TabSeuilHaut[1],fffixed,10,1)+' '+
                                                    floattostrf(hcpa3.TabSeuilHaut[2],fffixed,10,1)+' '+
                                                    floattostrf(hcpa3.TabSeuilHaut[3],fffixed,10,1));
               memo.Lines.add(lang('Seuils Bas       : ')+floattostrf(hcpa3.TabSeuilBas[1],fffixed,10,1)+' '+
                                                    floattostrf(hcpa3.TabSeuilBas[2],fffixed,10,1)+' '+
                                                    floattostrf(hcpa3.TabSeuilBas[3],fffixed,10,1));
               memo.Lines.add(lang('Type Données     : ')+inttostr(hcpa3.typedata));
               memo.Lines.add(lang('Nombre de Plans  : ')+inttostr(hcpa3.nbreplan));
               memo.Lines.add('TimeDate         : '+formatdatetime(datetimeFITS,hcpa3.TimeDate)); //nolang
               memo.Lines.add(lang('Temps De Pose    : ')+floattostrf(hcpa3.tempsdepose,fffixed,10,2));
               if hcpa3.MiroirX=true then tmp:='True' else tmp:='False'; //nolang
               memo.Lines.add(lang('Miroir X         : ')+tmp);
               if hcpa3.MiroirY=true then tmp:='True' else tmp:='False'; //nolang
               memo.Lines.add(lang('Miroir Y         : ')+tmp);
               memo.Lines.add(lang('Télescope        : ')+hcpa3.Telescope);
               memo.Lines.add(lang('Observateur      : ')+hcpa3.Observateur);
               memo.Lines.add(lang('Camera           : ')+hcpa3.camera);
               memo.Lines.add(lang('Filtre           : ')+hcpa3.Filtre);
               memo.Lines.add(lang('Observatoire     : ')+hcpa3.observatoire);
               memo.Lines.add(lang('Focale           : ')+floattostrf(hcpa3.focale,fffixed,10,2));
               memo.Lines.add('Alpha            : '+alphatostr(hcpa3.alpha/pi*180/15)); // Radian -> Heures //nolang
               memo.Lines.add('Delta            : '+deltatostr(hcpa3.delta/pi*180)); // Radian -> Degres    //nolang
               memo.Lines.add(lang('Taille Pixel X   : ')+floattostrf(hcpa3.pixx,fffixed,10,2));
               memo.Lines.add(lang('Taille Pixel Y   : ')+floattostrf(hcpa3.pixy,fffixed,10,2));
               memo.Lines.add(lang('Debut X          : ')+inttostr(hcpa3.debx));
               memo.Lines.add(lang('Debut Y          : ')+inttostr(hcpa3.deby));
               memo.Lines.add(lang('Fin X            : ')+inttostr(hcpa3.finx));
               memo.Lines.add(lang('Fin Y            : ')+inttostr(hcpa3.finy));
               memo.Lines.add(lang('Type Compression : ')+inttostr(hcpa3.typecompression));
               memo.Lines.add(lang('NombreBitsComp   : ')+inttostr(hcpa3.nombrebitscomp));
               memo.Lines.add(lang('Commentaires     : ')+hcpa3.commentaires[1]);
               memo.Lines.add('                   '+hcpa3.commentaires[2]); //nolang
               memo.Lines.add('                   '+hcpa3.commentaires[3]); //nolang
               memo.Lines.add('                   '+hcpa3.commentaires[4]); //nolang
               end;
             4:begin
               memo.Lines.add(lang('Signature        : ')+inttostr(hcpa4.Signature));
               memo.Lines.add(lang('Largeur (X)      : ')+inttostr(hcpa4.Largeur));
               memo.Lines.add(lang('Longueur (Y)     : ')+inttostr(hcpa4.Longueur));
               memo.Lines.add(lang('Binning X        : ')+inttostr(hcpa4.BinningX));
               memo.Lines.add(lang('Binning Y        : ')+inttostr(hcpa4.BinningY));
               memo.Lines.add(lang('Seuils Haut      : ')+floattostrf(hcpa4.TabSeuilHaut[1],fffixed,10,1)+' '+
                                                    floattostrf(hcpa4.TabSeuilHaut[2],fffixed,10,1)+' '+
                                                    floattostrf(hcpa4.TabSeuilHaut[3],fffixed,10,1));
               memo.Lines.add(lang('Seuils Bas       : ')+floattostrf(hcpa4.TabSeuilBas[1],fffixed,10,1)+' '+
                                                    floattostrf(hcpa4.TabSeuilBas[2],fffixed,10,1)+' '+
                                                    floattostrf(hcpa4.TabSeuilBas[3],fffixed,10,1));
               memo.Lines.add(lang('Type Données     : ')+inttostr(hcpa4.typedata));
               memo.Lines.add(lang('Nombre de Plans  : ')+inttostr(hcpa4.nbreplan));
               memo.Lines.add('TimeDate         : '+formatdatetime(datetimeFITS,hcpa4.TimeDate)); //nolang
               memo.Lines.add(lang('Temps De Pose    : ')+floattostrf(hcpa4.tempsdepose,fffixed,10,2));
               if hcpa4.MiroirX=true then tmp:='True' else tmp:='False'; //nolang
               memo.Lines.add(lang('Miroir X         : ')+tmp);
               if hcpa4.MiroirY=true then tmp:='True' else tmp:='False'; //nolang
               memo.Lines.add(lang('Miroir Y         : ')+tmp);
               memo.Lines.add(lang('Télescope        : ')+hcpa4.Telescope);
               memo.Lines.add(lang('Observateur      : ')+hcpa4.Observateur);
               memo.Lines.add(lang('Camera           : ')+hcpa4.camera);
               memo.Lines.add(lang('Filtre           : ')+hcpa4.Filtre);
               memo.Lines.add(lang('Observatoire     : ')+hcpa4.observatoire);
               memo.Lines.add(lang('Focale           : ')+floattostrf(hcpa4.focale,fffixed,10,2));
               memo.Lines.add('Alpha            : '+alphatostr(hcpa4.alpha/pi*180/15)); // Radian -> Heures //nolang
               memo.Lines.add('Delta            : '+deltatostr(hcpa4.delta/pi*180)); // Radian -> Degres    //nolang
               memo.Lines.add(lang('Taille Pixel X   : ')+floattostrf(hcpa4.pixx,fffixed,10,2));
               memo.Lines.add(lang('Taille Pixel Y   : ')+floattostrf(hcpa4.pixy,fffixed,10,2));
               memo.Lines.add(lang('Debut X          : ')+inttostr(hcpa4.debx));
               memo.Lines.add(lang('Debut Y          : ')+inttostr(hcpa4.deby));
               memo.Lines.add(lang('Fin X            : ')+inttostr(hcpa4.finx));
               memo.Lines.add(lang('Fin Y            : ')+inttostr(hcpa4.finy));
               memo.Lines.add(lang('Type Compression : ')+inttostr(hcpa4.typecompression));
               memo.Lines.add(lang('NombreBitsComp   : ')+inttostr(hcpa4.nombrebitscomp));
               memo.Lines.add(lang('Commentaires     : ')+hcpa4.commentaires[1]);
               memo.Lines.add('                   '+hcpa4.commentaires[2]); //nolang
               memo.Lines.add('                   '+hcpa4.commentaires[3]); //nolang
               memo.Lines.add('                   '+hcpa4.commentaires[4]); //nolang
               end;
             end;
     end;

     if (uppercase(extractfileext(s))='.FIT') or                      //nolang
        (uppercase(extractfileext(s))='.FTS') or                      //nolang
        (uppercase(extractfileext(s))='.FITS') then                   //nolang
     begin
          liste:=tlist.create;
          readfitsheaderraw(s,liste);
          if liste.count=0 then exit;
          for i:=0 to liste.count-1 do
          begin
               toto:=liste[i];
               for j:=1 to length(toto.str) do if toto.str[j]=#20 then toto.str[j]:=' ';
               memo.lines.add(toto.str);
          end;
          kill_list(liste,true);
     end;
end;

procedure Tpop_info_hdr.memoChange(Sender: TObject);
begin
     modified:=true;
end;

procedure Tpop_info_hdr.FormCreate(Sender: TObject);
begin
     modified:=false;
end;

procedure Tpop_info_hdr.btn_cancelClick(Sender: TObject);
begin
     close;
end;

procedure Tpop_info_hdr.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     action:=cafree;
end;

procedure Tpop_info_hdr.SpeedButton1Click(Sender: TObject);
begin
     opendialog1.filter:=lang('Fichiers Pic Cpa Fits|*.pic;*.cpa;*.fit;*.fits');
     opendialog1.initialdir:=config.RepImages;
     if opendialog1.execute then
     begin
          memo.Lines.clear;
          config.RepImages:=ExtractFilePath(opendialog1.Filename);
          load_the_header(opendialog1.filename);
     end;
end;

procedure Tpop_info_hdr.FormShow(Sender: TObject);
begin
UpDateLang(Self);
end;

end.
