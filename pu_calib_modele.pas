unit pu_calib_modele;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  Tpop_calib_modele = class(TForm)
    id: TEdit;
    Label1: TLabel;
    btn_pointer_objet: TButton;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    ListBox1: TListBox;
    Label4: TLabel;
    procedure btn_pointer_objetClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    AlphaReel,AHReel,DeltaReel,AlphaPointe,AHPointe,DeltaPointe:Double;
  end;

implementation

uses pu_main,
     pu_scope,
     u_file_io,
     u_general,
     u_meca,
     u_lang,
     u_telescopes,
     u_hour_servers;

{$R *.DFM}

procedure Tpop_calib_modele.btn_pointer_objetClick(Sender: TObject);
var
//Alpha,Delta:Double;
ha_str,Line:String;
ha:double;
savepcmoinstu:integer;
HauteurFin,AzimuthFin:Double;
local,lst_num:tdatetime;
Year,Month,Day,Hour,Min,Sec,MSec:Word;
Error:string;
begin
   line:=id.Text;
   WriteSpy(lang('Pointe : Demande Pointer = ')+line);
   if id.text='' then exit;

   NameToAlphaDelta(id.text,AlphaPointe,DeltaPointe);
   WriteSpy(lang('Pointe : Demande = ')+AlphaToStr(AlphaPointe)+'/'+DeltaToStr(DeltaPointe));

   if not Telescope.Pointe(AlphaPointe,DeltaPointe) then
      begin
      ShowMessage(lang('Le télescope ne veut pas pointer les coordonnées'));
      pop_Main.AfficheMessage(lang('Erreur'),
         lang('Le télescope ne veut pas pointer les coordonnées'));
      TelescopeErreurFatale;
      Exit;
      end;

   Error:=Telescope.GetError;
   if Error<>'' then
      WriteSpy(Error)
   else
      begin
      if not Telescope.WaitPoint(AlphaPointe,DeltaPointe) then
         begin
         WriteSpy('Le télescope n''est pas arrivé sur les coordonnées demandées');
         pop_Main.AfficheMessage(lang('Erreur'),
            'Le télescope n''est pas arrivé sur les coordonnées demandées');
         TelescopeErreurFatale;
         Exit;
         end
      else if not(Config.Periodic) then SetEvent(Pop_main.HTimerGetPosEvent);

      if Config.GoodPos then
         begin
         AlphaPointe:=Config.AlphaScope;
         DeltaPointe:=Config.DeltaScope;
         AHPointe:=GetHourAngle(GetHourDT,AlphaPointe,Config.Long)/15; //Degres -> heure
         end
      else
         begin
         WriteSpy(lang('Le télescope ne veut pas donner sa position'));
         pop_Main.AfficheMessage(lang('Erreur'),
            lang('Le télescope ne veut pas donner sa position'));
         end;
      end;
end;

procedure Tpop_calib_modele.Button1Click(Sender: TObject);
begin
if Config.GoodPos then
   begin
   AlphaReel:=Config.AlphaScope;
   DeltaReel:=Config.DeltaScope;
   AHReel:=GetHourAngle(GetHourDT,AlphaReel,Config.Long)/15; //Degres -> heure
   ListBox1.Items.Add(AlphaToStr(AHPointe)+' '+DeltaToStr(DeltaPointe)+' '+AlphaToStr(AHReel)+' '+DeltaToStr(DeltaReel));
   end
else
   begin
   WriteSpy(lang('Le télescope ne veut pas donner sa position'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope ne veut pas donner sa position'));
   end;
end;

procedure Tpop_calib_modele.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
   T:TextFile;
   Name:String;
   i:Integer;
begin
   Name:='TPoint.txt'; //nolang
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

procedure Tpop_calib_modele.FormShow(Sender: TObject);
begin
   Left:=Screen.Width-Width;
   UpDateLang(Self);
end;

end.
