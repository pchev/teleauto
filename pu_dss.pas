unit pu_dss;

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
  Buttons, StdCtrls, Mask, HTTPSend, ComCtrls, Spin, u_class,
  ImgList, PBFolderDialog, ExtCtrls, HiResTim;

type
  Tpop_dss = class(TForm)
    GroupBox1: TGroupBox;
    dec: TMaskEdit;
    ra: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    btn_lookup: TSpeedButton;
    fov_y: TSpinEdit;
    btn_go: TBitBtn;
    fov_x: TSpinEdit;
    SpeedButton1: TSpeedButton;
    memo: TMemo;
    SpeedButton3: TSpeedButton;
    cb_type: TCheckBox;
    cb_compression: TCheckBox;
    lv_task: TListView;
    SpeedButton4: TSpeedButton;
    OpenDialog1: TOpenDialog;
    ImageList1: TImageList;
    PBFolderDialog1: TPBFolderDialog;
    procedure btn_lookupClick(Sender: TObject);
    procedure btn_goClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ListDblClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure cb_typeClick(Sender: TObject);
    procedure lv_taskKeyDown(Sender: TObject; var Key: Word;
              Shift: TShiftState);
   procedure zlib_decompress(f:string);
    procedure lv_taskChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure SpeedButton4Click(Sender: TObject);

  private
    { Private declarations }
    HTTP:THTTPSend;
  public
    { Public declarations }
  end;


var
  pop_dss: Tpop_dss;
  currentDir:string;
  filename:string;
  pt:p_dss_task;
  objet:string;
  savealpha,savedelta:string;

implementation

{$R *.DFM}

uses u_meca,
     pu_image,
     u_lang,
     catalogues,
     u_constants,
     u_general,
     u_file_io,
     pu_main ;


procedure Tpop_dss.btn_lookupClick(Sender: TObject);
var
txt:string;
alpha,delta:double;
begin
     savealpha:='';
     savedelta:='';
     if MyInputQuery(lang('Chercher les coordonnées'),
        lang('Nom de l''objet :'),txt) then
     begin
          if not nametoalphadelta(txt,alpha,delta) then
          begin
              ra.text:='';
              dec.text:='';
              objet:='';
              exit;
          end
          else
          begin
              ra.text:=alphatostr(alpha);
              dec.text:=deltatostr(delta);
              savealpha:=ra.text;
              savedelta:=dec.text;
              objet:=txt;
          end;
     end;
end;

procedure Tpop_dss.btn_goClick(Sender: TObject);
var
   rah,ram,ras,deg,dem,des,x,y,s:string;
   compression,savefile:string;
   i:integer;
   status:byte;
   p:p_dss_task;
   SaveDir:string;
begin
// Teste si le répertoire existe
SaveDir:=GetCurrentDir;
if not(SetCurrentDir(CurrentDir)) then CreateDir(CurrentDir);
SetCurrentDir(SaveDir);

if copy(currentdir,length(currentdir),1)='\' then delete(currentdir,length(currentdir),1);
if lv_task.items.count=1 then memo.Clear;
for i:=0 to lv_task.items.count-1 do
   begin
   status:=0;
   try
   p:=lv_task.items[i].data;
   if p.objet<>'' then memo.lines.add(lang('Rapatriement de l''image : ')+
      p.objet+' '+inttostr(i+1)+'/'+inttostr(lv_task.items.count)) //Getting image : //nolang
   else memo.lines.add(lang('Rapatriement de l''image n°')+
      inttostr(i+1)+' '+p.ra+' '+p.dec+' '+inttostr(i)+'/'+inttostr(lv_task.items.count)); //Getting image # //nolang

   pop_main.StatusBar1.Panels[0].text:=lang('Rapatriement de l''image DSS n° ')+
      inttostr(i+1)+'/'+inttostr(lv_task.items.count); //Getting DSS image #

   if p.compression='Yes' then //nolang
      begin
      compression:='display/gz-fits'; //nolang
      if length(p.objet)=0 then filename:=currentdir+'\DSS_'+p.ra+' '+p.dec+'.gzip' else //nolang
      filename:=currentdir+'\DSS_'+p.objet+'.gzip'; //nolang
      p.filename:=filename;
      end
   else
      begin
      compression:='application/x-fits'; //nolang
      if p.objet='' then filename:=currentdir+'\DSS_'+p.ra+' '+p.dec+'.fits' //nolang
      else filename:=currentdir+'\DSS_'+p.objet+'.fits'; //nolang
      p.filename:=filename;
      end;
   memo.Lines.add(lang('vers ')+filename); //to
   rah:=copy(p.ra,1,2);
   ram:=copy(p.ra,4,2);
   ras:=copy(p.ra,7,2);
   deg:=copy(p.dec,1,3);
   dem:=copy(p.dec,5,2);
   des:=copy(p.dec,8,2);
   x:=p.fov_x;
   y:=p.fov_y;
   pt:=p;

   HTTP:=THTTPSend.Create;
   try
   HTTP.HTTPMethod('GET','http://archive.eso.org/dss/dss?ra='+rah+'+'+ram+'+'+ras+ //nolang
      '&dec='+deg+'+'+dem+'+'+des+ //nolang
      '&equinox=J2000&x='+x+'&y='+y+'&Sky-Survey=DSS'+p.DSS_type+'&mime-type='+compression); //Nolang

   HTTP.Document.SaveToFile(filename);
   finally
   HTTP.Free;
   end;

   if p.compression='Yes' then //nolang
      begin
      if fileexists(p.filename) then
         begin
         zlib_decompress(p.filename);
         memo.lines.add(lang('Décompression de l''image')); //Decompressing image
         savefile:=p.filename;
         filename:=copy(p.filename,1,length(p.filename)-4)+'fits'; //nolang
         p.filename:=filename;
         deletefile(savefile);
         end;
      end;

   memo.lines.add(lang('----- Fini ------')); //'----- Done ------'
   lv_task.items[i].imageindex:=1;
   if fileexists(p.filename) then p.done:=true;
   pop_main.StatusBar1.Panels[0].text:='';
   except
   memo.lines.add(lang('* Problème lors du rapatriement *')); //* Problem getting Image *
   writespy(lang('* Problème lors du rapatriement *')); //* Problem getting Image *
   lv_task.items[i].imageindex:=0;
   end;
   end;
end;


procedure tpop_dss.zlib_decompress(f:string);
var
fitsfile:file;
gzfile:integer;
buf : array[0..4095] of char;
s:string;
i,n:integer;
zlibok:boolean;
begin
     myzlib := LoadLibrary('zlib.dll'); //nolang
     if myzlib<>0 then
     begin
           gzopen:= Tgzopen(GetProcAddress(myzlib, 'gzopen')); //nolang
           gzread:= Tgzread(GetProcAddress(myzlib, 'gzread')); //nolang
           gzeof:= Tgzeof(GetProcAddress(myzlib, 'gzeof')); //nolang
           gzclose:= Tgzclose(GetProcAddress(myzlib, 'gzclose')); //nolang
           zlibok:=true;
     end
     else
     begin
           zlibok:=false;
     end;
     if zlibok then
     begin
       gzfile:=gzopen(pchar(f),pchar('rb')); //nolang
       s:=copy(filename,1,length(f)-4)+'fits'; //nolang
       assignfile(fitsfile,s);
       rewrite(fitsfile,1);
       repeat
            i:=gzread(gzfile,buf,length(buf));
            blockwrite(fitsfile,buf,i,n);
       until gzeof(gzfile)=1;
       gzclose(gzfile);
   end ;
end;


procedure Tpop_dss.SpeedButton1Click(Sender: TObject);
var
listitem:tlistitem;
p:p_dss_task;
i:integer;
begin
     new(p);
     p.ra:=ra.text;
     p.dec:=dec.text;
     if (p.ra=savealpha) and (p.dec=savedelta) then p.objet:=objet else p.objet:='DSS_'+p.ra+' '+p.dec; //nolang
     savealpha:='';
     savedelta:='';
     p.fov_x:=fov_x.text;
     p.fov_y:=fov_y.text;
     if cb_compression.checked then p.compression:='Yes' else p.compression:='No'; //nolang
     if cb_type.checked then p.dss_type:='1' else p.dss_type:='2';
     p.done:=false;

     listitem:=lv_task.items.add;
     listitem.Caption:=p.objet;
     listitem.subitems.add(p.ra);
     listitem.subitems.add(p.dec);
     listitem.subitems.add(p.fov_x);
     listitem.subitems.add(p.fov_y);
     listitem.subitems.add(p.dss_type);
     listitem.Data:=p;
end;

procedure Tpop_dss.ListDblClick(Sender: TObject);
// affiche une image downloadee
var
s:string;
i:integer;
pop_image:tpop_image;
p:p_dss_task;
begin
     for i:=0 to lv_task.items.count-1 do
     begin
          if lv_task.items[i].Selected then
          begin
               p:=lv_task.items[i].data;
               if p=nil then exit;
          end;
     end;
     if fileexists(p.filename) then
     begin
         pop_image:=tpop_image.create(application);
         try
         pop_image.ReadImage(p.filename);
         except
         if pop_image<>nil then pop_image.free;
         end;
     end;
end;

procedure Tpop_dss.SpeedButton2Click(Sender: TObject);
begin
//     if height>350 then height := 315 else height:=528;
end;

procedure Tpop_dss.FormClose(Sender: TObject; var Action: TCloseAction);
var
   p:p_dss_task;
begin
while lv_task.items.count>0 do
   begin
   p:=lv_task.items[0].data;
   if p<>nil then dispose(p);
   lv_task.items.Delete(0);
   end;
Action:=CaFree;
end;

procedure Tpop_dss.FormCreate(Sender: TObject);
begin
currentdir:='c:\temp\'; //nolang
new(pt);
end;

procedure Tpop_dss.SpeedButton3Click(Sender: TObject);
begin
if PBFolderDialog1.Execute then
    CurrentDir:=PBFolderDialog1.Folder;
end;

procedure Tpop_dss.cb_typeClick(Sender: TObject);
begin
if cb_type.caption='DSS 1' then cb_type.caption:='DSS 2' else cb_type.caption:='DSS 1';  //nolang
end;

procedure Tpop_dss.lv_taskKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
{delete}
var
   p:p_dss_task;
   i:integer;
begin
if Key=vk_delete then
   for i:=lv_task.items.count-1 downto 0 do
      begin
      if lv_task.items[i].selected then
         begin
         p:=lv_task.items[i].data;
         dispose(p);
         lv_task.items.delete(i);
         end;
      end;
end;

procedure Tpop_dss.lv_taskChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
   p:p_target;
begin
if item=nil then exit;
p:=item.Data;
if p=nil then exit;
if p.obj_name<>item.caption then p.obj_name:=item.caption;
end;

procedure Tpop_dss.SpeedButton4Click(Sender: TObject);
// downloade une liste d images contenues dans un fichier texte
// #RESOLVE
// m104
// #COORDINATES
// 18h26m21s -35d45m41s
var
   f:textfile;
   i:integer;
   p:p_dss_task;
   alpha,delta:double;
   resolve:boolean;
   coord:boolean;
   str,resolve_this:string;
   z:integer;
   size_x,size_y:string;
   dss:string;
   line:integer;
   listitem:tlistitem;
begin
OpenDialog1.filter:=lang('Fichiers Texte|*.txt;*.dat;*.cat');
OpenDialog1.InitialDir:='c:\temp'; // nolang
if opendialog1.execute then
   begin
   assignfile(f,opendialog1.filename);
   reset(f);
   line:=0;
   while not eof(f) do
      begin
      readln(f,str);
      inc(line);
      if length(trim(str)) = 0 then break;
      // Command line stuff
      if copy(str,1,1)='#' then
         begin
         // init command line
         resolve:=false;
         coord:=false;
         size_x:='';
         SIZE_Y:='';
         DSS:='';
         // on vire le #
         str:=trim(copy(str,2,length(str)));
         // resolve
         if uppercase(copy(str,1,7))='RESOLVE' then //nolang
            resolve:=true
         else if uppercase(copy(str,1,5))='COORD' then //nolang
            coord:=true
         else
            begin
            WriteSpy(lang('Mot clef invalide, ligne ')+inttostr(line)); //Invalid Keyword, line
            Exit;
            end;
         // vire le keyword
         z:=pos(' ',str);
         delete (str,1,z);
         // size_x
         z:=pos(' ',str);
         size_x:=copy(str,1,z-1);
         delete(str,1,z);
         // size_y
         z:=pos(' ',str);
         size_y:=copy(str,1,z-1);
         delete(str,1,z);
         // dss type
         dss:=trim(copy(str,1,length(str)));
         delete(str,1,z);
         // check command line
         if (size_x='') or (size_y='') then
            begin
            writespy(lang('Taille du champs invalide, ligne ')+inttostr(line)); //Invalid field size, line
            exit;
            end;
         if (dss<>'1') and (dss<>'2') then
            begin
            writespy(lang('Type DSS invalide, ligne ')+inttostr(line)); //Invalid DSS type, line
            exit;
            end;
         // EOL
         end
      else
         begin
         // object
         if resolve then
            begin
            resolve_this:=trim(str);
            if not nametoalphadelta(resolve_this,alpha,delta) then
               begin
               // NAN
               writespy(lang('Résolution impossible de : ')+resolve_this
                  +lang(', ligne')+inttostr(line)); //Impossible to resolve : //, line
               break;
               end
            else
               begin
               // OK
               new(p);
               p.objet:=resolve_this;
               p.ra:=alphatostr(alpha);
               p.dec:=deltatostr(delta);
               p.fov_x:=size_x;
               p.fov_y:=size_y;
               p.dss_type:=dss;
               p.compression:='Yes'; //nolang
               p.done:=false;
               listitem:=lv_task.items.add;
               listitem.Caption:=p.objet;
               listitem.subitems.add(p.ra);
               listitem.subitems.add(p.dec);
               listitem.subitems.add(p.fov_x);
               listitem.subitems.add(p.fov_y);
               listitem.subitems.add(p.dss_type);
               listitem.Data:=p;
               end;
            end;
         // coordinates
         if coord then
            begin
            new(p);
            // alpha
            z:=pos(' ',str);
            p.ra:=trim(copy(str,1,z-1));
            delete(str,1,z);
            // delta
            z:=pos(' ',str);
            p.dec:=trim(copy(str,1,z-1));
            delete(str,1,z);
            p.objet:='';
            p.fov_x:=size_x;
            p.fov_y:=size_y;
            p.dss_type:=dss;
            p.compression:='Yes'; //nolang
            p.done:=false;
            listitem:=lv_task.items.add;
            listitem.Caption:=p.objet;
            listitem.subitems.add(p.ra);
            listitem.subitems.add(p.dec);
            listitem.subitems.add(p.fov_x);
            listitem.subitems.add(p.fov_y);
            listitem.subitems.add(p.dss_type);
            listitem.Data:=p;
            end;
         end;
      end;
   CloseFile(f);
   end;
end;

end.
