unit pu_script_builder;

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
  Windows, Messages, SysUtils, Classes, Graphics, math,Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, u_class, ImgList, Menus, ClipBrd,
  pu_rapport, inifiles, u_analyse, Variants, DateUtils,

  // ifps3
  {ifps3, ifps3utl, ifpscomp,
  ifpidll2, ifpidll2runtime, ifps3debug, ifpiir_std,
  ifpii_std, ifpiir_stdctrls, ifpii_stdctrls, ifpiir_forms, ifpii_forms,
  ifpii_graphics, ifpii_controls, ifpii_classes, ifpiir_graphics,
  ifpiir_controls, ifpiir_classes,
  ifps3lib_std ,ifps3lib_stdr ,ifps3common ,ifpidelphi ,ifpiclass, ifpiclassruntime, ifpidelphiruntime,}

  uPSCompiler, uPSRuntime, uPSPreprocessor, uPSUtils,
  uPSC_comobj, uPSR_comobj,


  uPSDisassembly, uPSC_dll, uPSR_dll, uPSDebugger,
  uPSR_std, uPSC_std, uPSR_stdctrls, uPSC_stdctrls,
  uPSR_forms, uPSC_forms,

  uPSC_graphics,
  uPSC_controls,
  uPSC_classes,
  uPSR_graphics,
  uPSR_controls,
  uPSR_classes,

  SynEditHighlighter, SynHighlighterPas, SynEdit;

{-------------------------------------------------------------------------------

                               Generation de scripts

-------------------------------------------------------------------------------}

type
  Tpop_builder = class(TForm)
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    timer_script: TTimer;
    heure_tsl: TEdit;
    pos_telescope: TEdit;
    temps_de_pose: TEdit;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Afficher1: TMenuItem;
    Details1: TMenuItem;
    Reticule1: TMenuItem;
    SyncTelescope1: TMenuItem;
    BitBtn10: TBitBtn;
    Button1: TButton;
    BitBtn9: TBitBtn;
    BitBtn8: TBitBtn;
    ListBox1: TListBox;
    SynEdit1: TSynEdit;
    SynPasSyn1: TSynPasSyn;
    Button2: TButton;
    procedure timer_scriptTimer(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    // graphique
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    function char2linepos(idx:integer):integer;
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SynEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    procedure SynEdit1SpecialLineColors(Sender: TObject; Line: Integer;
      var Special: Boolean; var FG, BG: TColor);


  private


  public
    modified:boolean;

    // TSL en global pour pas recalculer a chaque fois
    tsl:double;
  end;

//function GetQuery_int(Psql:string):integer;
function MyOnUses(Sender: TPSPascalCompiler; const Name: string): Boolean;
//function MyOnUses(Sender: TIFPSPascalCompiler; const Name: string): Boolean;

var
  pop_builder: Tpop_builder;

  // forme rapport           
  rapport:tpop_rapport;

//  myclass:TIFPSClasses;
  Imp:TIFPSRuntimeClassImporter;
  iStatus: TIStatus;
  LastLine: Longint;
  IgnoreRunline: Boolean = False;
  ii:Integer;
  LineError:Integer;

  implementation


{$R *.DFM}

uses u_file_io,
     pu_main,
     pu_catalogs,
     pu_image,
     pu_scope,
     u_general,
     u_meca,
     u_math,
     catalogues,
     pu_camera,
     pu_camera_suivi,     
     u_cameras,
     u_constants,
     u_lang,
     u_telescopes,
     u_hour_servers,
     pu_webcam;

procedure Tpop_builder.timer_scriptTimer(Sender: TObject);
// affiche heure locale et TSL
var
longitude:double;
savepcmoinstu:integer;
local,lst_num:tdatetime;
begin
     longitude:=config.long;
     SavePCMoinsTU:=config.PCMoinsTU;
     config.PCMoinsTU:=0;
//     local:=GetRealDateTime;
     local:=GetHourDT;
     config.PCMoinsTU:=SavePCMoinsTU;
     // TS local
      lst_num:=LocalSidTim(local,longitude)/15;
      if lst_num > 24 then lst_num := lst_num-24;
      heure_tsl.text:='TSL '+alphatostr(lst_num);  //nolang
      // aussi updater la var globale
      tsl:=lst_num;
end;


procedure Tpop_builder.SpeedButton8Click(Sender: TObject);
// ouvre la fenetre de rapport sur les stats script
begin
{     rapport:=tpop_rapport.create(application);
     rapport.show;
     rapport.AddLine(lang('Objets OK      : ')+inttostr(list_script.count));
     rapport.addline(lang('Objets Rejetés : ')+inttostr(list_rejected.count));
     rapport.addline(lang('Nb Photos      : ')+inttostr(nb_photo));
     rapport.addline(lang('Dernier calcul : ')+timetostr(last_refresh));
     rapport.addline(lang('Durée totale   : ')+timetostr(total_script_duration));
     rapport.Quitter.Enabled:=true;}
end;

procedure Tpop_builder.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     timer_script.enabled:=false;
end;

procedure Tpop_builder.FormShow(Sender: TObject);
begin
     UpDateLang(Self);
     timer_script.enabled:=true;
end;

procedure Tpop_builder.FormHide(Sender: TObject);
begin
    timer_script.enabled:=false;
end;

{function GetQuery_int(Psql:string):integer;
begin
  datamod.temp_sql.close;
  datamod.temp_sql.sql.clear;
  datamod.temp_sql.sql.add(psql);
  try
  datamod.temp_sql.open;
  result:=datamod.temp_sql.fields[0].asinteger;
  except
  result:=-12345;
  end;
  datamod.temp_sql.close;
end;}

procedure Tpop_builder.ListBox1DblClick(Sender: TObject);
// selectionne la ligne contenant une erreur dans l editeur
var
   z,i,l,PosEsp:integer;
   s:string;
begin
if listbox1.items.count=0 then exit;
LineError:=-1;

// On marque la ligne qui a merde
for i:=0 to Listbox1.Items.Count-1 do
   begin
   if Listbox1.Selected[i] then
      begin
      s:=Trim(Listbox1.Items[i]);
      PosEsp:=Pos(' ',s);
      while PosEsp<>0 do
         begin
         Delete(s,1,PosEsp);
         PosEsp:=Pos(' ',s);
         end;

      LineError:=StrToInt(s);
      SynEdit1.SetFocus;
      SynEdit1.CaretY:=l;
      SynEdit1.Refresh;
      Break;
      end;
   end;
end;

procedure Tpop_builder.BitBtn8Click(Sender: TObject);
var
   syntax:boolean;
   Nom:string;
begin
   SaveDialog1.InitialDir:=config.RepImages;
   SaveDialog1.Filter:=lang('Fichiers Script Tas|*.Tas');
   if SaveDialog1.Execute then
      begin
      Nom:=SaveDialog1.FileName;
      if Uppercase(ExtractFileExt(Nom))<>'.TAS' then Nom:=Nom+'.tas'; //nolang
      config.RepImages:=ExtractFilePath(Nom);
      SynEdit1.Lines.SaveToFile(Nom);
      end;
end;

procedure Tpop_builder.BitBtn9Click(Sender: TObject);
var
   i:integer;
begin
   LineError:=-1;
   OpenDialog1.Filter:=lang('Fichiers Script Tas|*.Tas');
   if OpenDialog1.Execute then
      begin
      SynEdit1.lines.LoadFromFile(OpenDialog1.filename);
      end;
end;

const
  sPropStr = '{\rtf{\colortbl\red0\green0\blue0;\red0\green128\blue128;} \cf1 Property \cf0 | %s | \b %s}'; //nolang
  sMethStr = '{\rtf{\colortbl\red0\green0\blue0;\red0\green128\blue128;} \cf1 Method \cf0 | %s | \b %s}'; //nolang

//function MyExportCheck(Sender: TIFPSPascalCompiler; Proc: TIFPSInternalProcedure; const ProcDecl: string): Boolean;
function MyExportCheck(Sender: TPSPascalCompiler; Proc: TPSInternalProcedure; const ProcDecl: string): Boolean;
//function MyExportCheck(Sender: TIFPSPascalCompiler; Proc: PIFPSProcedure; const ProcDecl: string): Boolean;
begin
  Result := TRue;
end;

procedure RunLine(Sender: TIFPSExec);
begin
  if IgnoreRunline then Exit;
  ii := (ii + 1) mod 15;
  Sender.GetVar('');
  if ii = 0 then Application.ProcessMessages;
end;

function MyWriteln(Caller: TPSExec; p: TIFExternalProcRec; Global, Stack: TPSStack): Boolean;
var
  PStart: Cardinal;
begin
  if Global = nil then begin result := false; exit; end;
  PStart := Stack.Count - 1;
  pop_Builder.ListBox1.Items.Add(Stack.GetString(PStart));
  Result := True;
end;

{function MyWriteln(Caller: TIFPSExec; p: PIFProcRec; Global, Stack: TIfList): Boolean;
var
  PStart: Cardinal;
begin
  if Global = nil then begin result := false; exit; end;
  PStart := Stack.Count - 1;
  pop_Builder.ListBox1.Items.Add(LGetStr(Stack, PStart));
  Result := True;
end;}

//function MyWrite(Caller: TIFPSExec; p: PIFProcRec; Global, Stack: TIfList): Boolean;
function MyWrite(Caller: TPSExec; p: TIFExternalProcRec; Global, Stack: TPSStack): Boolean;
var
  PStart: Cardinal;
begin
  if Global = nil then begin result := false; exit; end;
  PStart := Stack.Count - 1;
  pop_Builder.ListBox1.Items[pop_Builder.ListBox1.Count-1]:=
     pop_Builder.ListBox1.Items[pop_Builder.ListBox1.Count-1]+Stack.GetString(PStart);
  Result := True;
end;

function MyReadln(Caller: TPSExec; p: TIFExternalProcRec; Global, Stack: TPSStack): Boolean;
var
  PStart: Cardinal;
begin
  if Global = nil then begin result := false; exit; end;
  PStart := Stack.Count - 2;
  Stack.SetString(PStart + 1, InputBox(pop_Builder.Caption, Stack.GetString(PStart), ''));
  Result := True;
end;

{function MyReadln(Caller: TIFPSExec; p: PIFProcRec; Global, Stack: TIfList): Boolean;
var
  PStart: Cardinal;
begin
  if Global = nil then begin result := false; exit; end;
  PStart := Stack.Count - 2;
  LSetStr(Stack, PStart + 1, InputBox(pop_Builder.Caption, LGetStr(stack, PStart), ''));
  Result := True;
end;}

//function GetScreenWidth(Caller: TIFPSExec; p: PIFProcRec; Global, Stack: TIfList): Boolean;
function GetScreenWidth(Caller: TPSExec; p: TIFExternalProcRec; Global, Stack: TPSStack): Boolean;
var
  PStart: Cardinal;
begin
  if Global = nil then begin result := false; exit; end;
  PStart := Stack.Count - 2;
//  LSetInt(Stack, PStart + 1, Screen.Width);
  Stack.SetInt(PStart + 1, Screen.Width);
  Result := True;
end;

//function GetScreenHeight(Caller: TIFPSExec; p: PIFProcRec; Global, Stack: TIfList): Boolean;
function GetScreenHeight(Caller: TPSExec; p: TIFExternalProcRec; Global, Stack: TPSStack): Boolean;
var
  PStart: Cardinal;
begin
  if Global = nil then begin result := false; exit; end;
  PStart := Stack.Count - 2;
//  LSetInt(Stack, PStart + 1, Screen.Height);
  Stack.SetInt(PStart + 1, Screen.Height);
  Result := True;
end;

function ImportTest(S1: string; s2: Longint; s3: Byte; s4: word; var s5: string): string;
begin
  Result := s1 + ' ' + IntToStr(s2) + ' ' + IntToStr(s3) + ' ' + IntToStr(s4) + ' - OK!'; //nolang
  S5 := s5 + ' '+ result + ' -   OK2!'; //nolang
end;

procedure ScriptSleep(Delay:Integer);
begin
MySleep(Delay);
end;

function OpenImage(var pop_image:tpop_image):Boolean;
begin
Result:=pop_main.OpenImage(pop_image);
end;

function GetTADir:string;
begin
Result:=ExtractFilePath(Application.ExeName);
end;

procedure Tpop_builder.BitBtn10Click(Sender: TObject);
var
   x1: TIFPSPascalCompiler;
   x2: TIFPSDebugExec;
   xpre: TPSPreProcessor;
   s, d: string;
   
   MyLines:TStrings;
   i:Integer;
   MyPos:Integer;

   procedure Outputtxt(const s: string);
   begin
   ListBox1.Items.Add(s);
   end;

   procedure OutputMsgs;
   var
      l: Longint;
      b: Boolean;
      i: Integer;
   begin
   b := False;
   for l := 0 to x1.MsgCount - 1 do
      begin
      MyPos:=0;
      i:=0;
      while (MyPos<X1.Msg[l].Pos) and (i<SynEdit1.Lines.Count-1) do
         begin
         MyPos:=MyPos+Length(SynEdit1.Lines[i]);
         inc(i);
         end;

      Outputtxt(x1.Msg[l].MessageToString+lang(' : Ligne ')+IntToStr(i));
      if (not b) and (x1.Msg[l] is TPSPascalCompilerError) then
         begin
         b := True;
         LineError:=i;
         SynEdit1.CaretY:=i;
         SynEdit1.SetFocus;
         SynEdit1.Refresh;
         end;
      end;
   end;

begin
// Init
ListBox1.Items.Clear;
LineError:=-1;

if tag <> 0 then exit;
ListBox1.Clear;
//x1:=TIFPSPascalCompiler.Create;
x1 := TPSPascalCompiler.Create;
x1.OnExportCheck := MyExportCheck;
x1.OnUses := MyOnUses;
x1.OnExternalProc := DllExternalProc;

// On passe dans un TString pour compiler
MyLines:=TStringList.Create;
for i:=0 to SynEdit1.Lines.count-1 do
   MyLines.Add(SynEdit1.Lines[i]);

if x1.Compile(MyLines.Text) then
   begin
   Outputtxt(lang('Compilation réussie'));
   OutputMsgs;
   if not x1.GetOutput(s) then
      begin
      x1.Free;
      Outputtxt(lang('[Erreur] : Ne peut pas obtenir les données'));
      Exit;
      end;
   x1.GetDebugOutput(d);
   x1.Free;
//   x2 := TIFPSDebugExec.Create;
   x2 := TPSDebugExec.Create;
   try

   RegisterDLLRuntime(x2);
   RegisterClassLibraryRuntime(x2, Imp);
   RIRegister_ComObj(x2);
      
//   tag := longint(x2);
   if sender <> nil then x2.OnRunLine := RunLine;
   x2.RegisterFunctionName('WRITELN', MyWriteln, nil, nil); //nolang
   x2.RegisterFunctionName('WRITE', MyWrite, nil, nil); //nolang
   x2.RegisterFunctionName('READLN', MyReadln, nil, nil); //nolang
   x2.RegisterFunctionName('GETSCREENWIDTH', GetScreenWidth, nil, nil); //nolang
   x2.RegisterFunctionName('GETSCREENHEIGHT', GetScreenHeight, nil, nil); //nolang
   x2.RegisterFunctionName('SCREENWIDTH', GetScreenWidth, nil, nil); //nolang
   x2.RegisterFunctionName('SCREENHEIGHT', GetScreenHeight, nil, nil); //nolang

   //function ImportTest(S1: string; s2: Longint; s3: Byte; s4: word; var s5: string): string;
   x2.RegisterDelphiFunction(@ImportTest, 'IMPORTTEST', cdRegister);
   //RegisterDelphiFunctionR(x2, @ImportTest, 'IMPORTTEST', cdRegister); //nolang
   x2.RegisterDelphiFunction(@InputBox, 'INPUTBOX', cdRegister);
   //RegisterDelphiFunctionR(x2, @InputBox, 'INPUTBOX', cdRegister); //nolang
   x2.RegisterDelphiFunction(@ScriptSleep, 'SLEEP', cdRegister);
   //RegisterDelphiFunctionR(x2, @ScriptSleep, 'SLEEP', cdRegister); //nolang

   x2.RegisterDelphiFunction(@GetTADir, 'GETTADIR', cdRegister);
   //RegisterDelphiFunctionR(x2, @GetTADir, 'GETTADIR', cdRegister); //nolang
   x2.RegisterDelphiFunction(@OpenImage, 'OPENIMAGE', cdRegister);
   //RegisterDelphiFunctionR(x2, @OpenImage, 'OPENIMAGE', cdRegister); //nolang
   //x2.RegisterDelphiFunction(@WaitEndPose, 'WAITENDPOSE', cdRegister);
   //RegisterDelphiFunctionR(x2, @WaitEndPose, 'WAITENDPOSE', cdRegister); //nolang

   x2.RegisterDelphiFunction(@AlphaToStr, 'ALPHATOSTR', cdRegister);
   //RegisterDelphiFunctionR(x2, @AlphaToStr, 'ALPHATOSTR', cdRegister); //nolang
   x2.RegisterDelphiFunction(@DeltaToStr, 'DELTATOSTR', cdRegister);
   //RegisterDelphiFunctionR(x2, @DeltaToStr, 'DELTATOSTR', cdRegister); //nolang
   x2.RegisterDelphiFunction(@AlphaToStrAstrom, 'ALPHATOSTRASTROM', cdRegister);
   //RegisterDelphiFunctionR(x2, @AlphaToStrAstrom, 'ALPHATOSTRASTROM', cdRegister); //nolang
   x2.RegisterDelphiFunction(@DeltaToStrAstrom, 'DELTATOSTRASTROM', cdRegister);
   //RegisterDelphiFunctionR(x2, @DeltaToStrAstrom, 'DELTATOSTRASTROM', cdRegister); //nolang
   x2.RegisterDelphiFunction(@StrToAlpha, 'STRTOALPHA', cdRegister);
   //RegisterDelphiFunctionR(x2, @StrToAlpha, 'STRTOALPHA', cdRegister); //nolang
   x2.RegisterDelphiFunction(@StrToDelta, 'STRTODELTA', cdRegister);
   //RegisterDelphiFunctionR(x2, @StrToDelta, 'STRTODELTA', cdRegister); //nolang

   x2.RegisterDelphiFunction(@NameToAlphaDelta, 'NAMETOALPHADELTA', cdRegister);
   //RegisterDelphiFunctionR(x2, @NameToAlphaDelta, 'NAMETOALPHADELTA', cdRegister); //nolang

   // Date et Heure
   x2.RegisterDelphiFunction(@EncodeDate, 'ENCODEDATE', cdRegister);
   //RegisterDelphiFunctionR(x2, @EncodeDate, 'ENCODEDATE', cdRegister); //nolang
   x2.RegisterDelphiFunction(@EncodeTime, 'ENCODETIME', cdRegister);
   //RegisterDelphiFunctionR(x2, @EncodeTime, 'ENCODETIME', cdRegister); //nolang
   x2.RegisterDelphiFunction(@TryEncodeDate, 'TRYENCODEDATE', cdRegister);
   //RegisterDelphiFunctionR(x2, @TryEncodeDate, 'TRYENCODEDATE', cdRegister); //nolang
   x2.RegisterDelphiFunction(@TryEncodeTime, 'TRYENCODETIME', cdRegister);
   //RegisterDelphiFunctionR(x2, @TryEncodeTime, 'TRYENCODETIME', cdRegister); //nolang
   x2.RegisterDelphiFunction(@DecodeDate, 'DECODEDATE', cdRegister);
   //RegisterDelphiFunctionR(x2, @DecodeDate, 'DECODEDATE', cdRegister); //nolang
   x2.RegisterDelphiFunction(@DecodeTime, 'DECODETIME', cdRegister);
   //RegisterDelphiFunctionR(x2, @DecodeTime, 'DECODETIME', cdRegister); //nolang
   x2.RegisterDelphiFunction(@DayOfWeek, 'DAYOFWEEK', cdRegister);
   //RegisterDelphiFunctionR(x2, @DayOfWeek, 'DAYOFWEEK', cdRegister); //nolang
   x2.RegisterDelphiFunction(@Date, 'DATE', cdRegister);
   //RegisterDelphiFunctionR(x2, @Date, 'DATE', cdRegister); //nolang
   x2.RegisterDelphiFunction(@Time, 'TIME', cdRegister);
   //RegisterDelphiFunctionR(x2, @Time, 'TIME', cdRegister); //nolang
   x2.RegisterDelphiFunction(@Now, 'NOW', cdRegister);
   //RegisterDelphiFunctionR(x2, @Now, 'NOW', cdRegister); //nolang
   x2.RegisterDelphiFunction(@DateTimeToUnix, 'DATETIMETOUNIX', cdRegister);
   //RegisterDelphiFunctionR(x2, @DateTimeToUnix, 'DATETIMETOUNIX', cdRegister); //nolang
   x2.RegisterDelphiFunction(@UnixToDateTime, 'UNIXTODATETIME', cdRegister);
   //RegisterDelphiFunctionR(x2, @UnixToDateTime, 'UNIXTODATETIME', cdRegister); //nolang
   x2.RegisterDelphiFunction(@DateToStr, 'DATETOSTR', cdRegister);
   //RegisterDelphiFunctionR(x2, @DateToStr, 'DATETOSTR', cdRegister); //nolang
   x2.RegisterDelphiFunction(@FormatDateTime, 'FORMATDATETIME', cdRegister);
   //RegisterDelphiFunctionR(x2, @FormatDateTime, 'FORMATDATETIME', cdRegister); //nolang
   x2.RegisterDelphiFunction(@StrToDate, 'STRTODATE', cdRegister);
   //RegisterDelphiFunctionR(x2, @StrToDate, 'STRTODATE', cdRegister); //nolang

   x2.RegisterDelphiFunction(@HeureToJourJulien, 'HOURTOJULIANDAY', cdRegister);
   //RegisterDelphiFunctionR(x2, @HeureToJourJulien, 'HOURTOJULIANDAY', cdRegister); //nolang
   x2.RegisterDelphiFunction(@JourJulienToHeure, 'JULIANDAYTOHOUR', cdRegister);
   //RegisterDelphiFunctionR(x2, @JourJulienToHeure, 'JULIANDAYTOHOUR', cdRegister); //nolang
   x2.RegisterDelphiFunction(@LocalSidTim, 'LOCALSIDTIM', cdRegister);
   //RegisterDelphiFunctionR(x2, @LocalSidTim, 'LOCALSIDTIM', cdRegister); //nolang
   x2.RegisterDelphiFunction(@AngularDistance, 'ANGULARDISTANCE', cdRegister);
   //RegisterDelphiFunctionR(x2, @AngularDistance, 'ANGULARDISTANCE', cdRegister); //nolang
   x2.RegisterDelphiFunction(@GetAlphaDeltaFromHor, 'GETALPHADELTAFROMHOR', cdRegister);
   //RegisterDelphiFunctionR(x2, @GetAlphaDeltaFromHor, 'GETALPHADELTAFROMHOR', cdRegister); //nolang
   x2.RegisterDelphiFunction(@GetHorFromAlphaDelta, 'GETHORFROMALPHADELTA', cdRegister);
   //RegisterDelphiFunctionR(x2, @GetHorFromAlphaDelta, 'GETHORFROMALPHADELTA', cdRegister); //nolang
   x2.RegisterDelphiFunction(@GetElevation, 'GETELEVATION', cdRegister);
   //RegisterDelphiFunctionR(x2, @GetElevation, 'GETELEVATION', cdRegister); //nolang
   x2.RegisterDelphiFunction(@GetElevationNow, 'GETELEVATIONNOW', cdRegister);
   //RegisterDelphiFunctionR(x2, @GetElevationNow, 'GETELEVATIONNOW', cdRegister); //nolang
   x2.RegisterDelphiFunction(@GetAzimuth, 'GETAZIMUTH', cdRegister);
   //RegisterDelphiFunctionR(x2, @GetAzimuth, 'GETAZIMUTH', cdRegister); //nolang
   x2.RegisterDelphiFunction(@GetAzimuthNow, 'GETAZIMUTHNOW', cdRegister);
   //RegisterDelphiFunctionR(x2, @GetAzimuthNow, 'GETAZIMUTHNOW', cdRegister); //nolang
   x2.RegisterDelphiFunction(@GetHourAngle, 'GETHOURANGLE', cdRegister);
   //RegisterDelphiFunctionR(x2, @GetHourAngle, 'GETHOURANGLE', cdRegister); //nolang
   x2.RegisterDelphiFunction(@GetAlphaFromHourAngle, 'GETALPHAFROMHOURANGLE', cdRegister);
   //RegisterDelphiFunctionR(x2, @GetAlphaFromHourAngle, 'GETALPHAFROMHOURANGLE', cdRegister); //nolang
   x2.RegisterDelphiFunction(@DistanceToMoon, 'DISTANCETOMOON', cdRegister);
   //RegisterDelphiFunctionR(x2, @DistanceToMoon, 'DISTANCETOMOON', cdRegister); //nolang
   x2.RegisterDelphiFunction(@MoonCurrentPhase, 'MOONCURRENTPHASE', cdRegister);
   //RegisterDelphiFunctionR(x2, @MoonCurrentPhase, 'MOONCURRENTPHASE', cdRegister); //nolang
   x2.RegisterDelphiFunction(@DistanceToSun, 'DISTANCETOSUN', cdRegister);
   //RegisterDelphiFunctionR(x2, @DistanceToSun, 'DISTANCETOSUN', cdRegister); //nolang
   x2.RegisterDelphiFunction(@AirMass, 'AIRMASS', cdRegister);
   //RegisterDelphiFunctionR(x2, @AirMass, 'AIRMASS', cdRegister); //nolang

   //RegisterStandardLibrary_R(x2);
   //RegisterDateTimeLibrary_R(X2);

   if not x2.LoadData(s) then
     begin
     Outputtxt(lang('[Erreur] : Ne peut pas charger les données : ')+TIFErrorToString(x2.ExceptionCode, x2.ExceptionString));
     tag := 0;
     Exit;
     end;
   x2.LoadDebugData(d);

   // This will set the script's Application variable to the real Application variable.
   SetVariantToClass(x2.GetVarNo(x2.GetVar('APPLICATION')), Application); //nolang
   SetVariantToClass(x2.GetVarNo(x2.GetVar('SELF')), Self); //nolang

   // TeleAuto
   SetVariantToClass(x2.GetVarNo(x2.GetVar('WINCAMERA')), pop_camera); //nolang
   SetVariantToClass(x2.GetVarNo(x2.GetVar('WINCAMERAGUIDE')), pop_camera_suivi); //nolang
   SetVariantToClass(x2.GetVarNo(x2.GetVar('WINSCOPE')), pop_scope); //nolang
   //SetVariantToClass(x2.GetVarNo(x2.GetVar('SCREEN')), Forms.Screen);

   x2.RunScript;
   if x2.ExceptionCode <> erNoError then
      Outputtxt(lang('[Erreur d''exécution : ') + TIFErrorToString(x2.ExceptionCode, x2.ExceptionString) +
         lang(' dans ') + IntToStr(x2.ExceptionProcNo) +
         lang(' à ') + IntToSTr(x2.ExceptionPos))
   else
      OutputTxt(lang('Exécution réussie'));
   finally
   tag := 0;
   x2.Free;
   end;
   end
else
   begin
   Outputtxt(lang('Echec à la compilation'));
   OutputMsgs;
   x1.Free;
   end;
end;

function Tpop_builder.char2linepos(idx:integer):integer;
var i,j,k:integer;
begin
   k:=1;
   for i:=0 to SynEdit1.Lines.count-1 do
      begin
      for j:=1 to Length(Trim(SynEdit1.Lines[i]))+2  do
         begin
         if k=idx then
            begin
            Result:=i+1;
            Exit;
            end;
         inc(k);
         end;
      end;
end;

function MyOnUses(Sender: TIFPSPascalCompiler; const Name: string): Boolean;
//var
//  cl: TIFPSCompileTimeClassesImporter;
begin
  if Name = 'SYSTEM' then //nolang
  begin
    TIFPSPascalCompiler(Sender).AddFunction('procedure Writeln(s: string);'); //nolang
    TIFPSPascalCompiler(Sender).AddFunction('procedure Write(s: string);'); //nolang    
    TIFPSPascalCompiler(Sender).AddFunction('function Readln(question: string): string;'); //nolang
    TIFPSPascalCompiler(Sender).AddFunction('function GetScreenWidth:Integer;'); //nolang
    TIFPSPascalCompiler(Sender).AddFunction('function GetScreenHeight:Integer;'); //nolang
    TIFPSPascalCompiler(Sender).AddFunction('function ScreenWidth:Integer;'); //nolang
    TIFPSPascalCompiler(Sender).AddFunction('function ScreenHeight:Integer;'); //nolang

//function ImportTest(S1: string; s2: Longint; s3: Byte; s4: word; var s5: string): string;
{    Sender.AddDelphiFunction('function ImportTest(S1: string; s2: Longint; s3: Byte; s4: word; var s5: string): string;'); //nolang
    Sender.AddDelphiFunction('function InputBox(const ACaption, APrompt, ADefault: string): string;'); //nolang
    Sender.AddDelphiFunction('procedure Sleep(Delay:Integer);'); //nolang

    Sender.AddDelphiFunction('function GetTADir:string;'); //nolang

    Sender.AddDelphiFunction('function AlphaToStr(Alpha:Double):string;'); //nolang
    Sender.AddDelphiFunction('function DeltaToStr(Delta:Double):string;'); //nolang
    Sender.AddDelphiFunction('function AlphaToStrAstrom(Delta:Double):string;'); //nolang
    Sender.AddDelphiFunction('function DeltaToStrAstrom(Delta:Double):string;'); //nolang
    Sender.AddDelphiFunction('function StrToAlpha(Line:string):Double;'); //nolang
    Sender.AddDelphiFunction('function StrToDelta(Line:string):Double;'); //nolang
    Sender.AddDelphiFunction('function NameToAlphaDelta(Name:string;var Alpha,Delta:Double):Boolean;'); //nolang}

    Sender.AddDelphiFunction('function ImportTest(S1: string; s2: Longint; s3: Byte; s4: word; var s5: string): string;');
//    RegisterDelphiFunctionC(Sender, 'function ImportTest(S1: string; s2: Longint; s3: Byte; s4: word; var s5: string): string;'); //nolang
    Sender.AddDelphiFunction('function InputBox(const ACaption, APrompt, ADefault: string): string;');
//    RegisterDelphiFunctionC(Sender, 'function InputBox(const ACaption, APrompt, ADefault: string): string;'); //nolang
    Sender.AddDelphiFunction('procedure Sleep(Delay:Integer);');
//    RegisterDelphiFunctionC(Sender, 'procedure Sleep(Delay:Integer);'); //nolang

    Sender.AddDelphiFunction('function GetTADir:string;');
//    RegisterDelphiFunctionC(Sender, 'function GetTADir:string;'); //nolang

    Sender.AddDelphiFunction('function AlphaToStr(Alpha:Double):string;');
//    RegisterDelphiFunctionC(Sender, 'function AlphaToStr(Alpha:Double):string;'); //nolang
    Sender.AddDelphiFunction('function DeltaToStr(Delta:Double):string;');
//    RegisterDelphiFunctionC(Sender, 'function DeltaToStr(Delta:Double):string;'); //nolang
    Sender.AddDelphiFunction('function AlphaToStrAstrom(Delta:Double):string;');
//    RegisterDelphiFunctionC(Sender, 'function AlphaToStrAstrom(Delta:Double):string;'); //nolang
    Sender.AddDelphiFunction('function DeltaToStrAstrom(Delta:Double):string;');
//    RegisterDelphiFunctionC(Sender, 'function DeltaToStrAstrom(Delta:Double):string;'); //nolang
    Sender.AddDelphiFunction('function StrToAlpha(Line:string):Double;');
//    RegisterDelphiFunctionC(Sender, 'function StrToAlpha(Line:string):Double;'); //nolang
    Sender.AddDelphiFunction('function StrToDelta(Line:string):Double;');
//    RegisterDelphiFunctionC(Sender, 'function StrToDelta(Line:string):Double;'); //nolang
    Sender.AddDelphiFunction('function NameToAlphaDelta(Name:string;var Alpha,Delta:Double):Boolean;');
//    RegisterDelphiFunctionC(Sender, 'function NameToAlphaDelta(Name:string;var Alpha,Delta:Double):Boolean;'); //nolang

//    Sender.AddConstantN('NaNlang(', ')extended').Value.textended := 0.0 / 0.0;
//    Sender.AddConstantN('Infinitylang(', ')extended').Value.textended := 1.0 / 0.0;
//    Sender.AddConstantN('NegInfinitylang(', ')extended').Value.textended := - 1.0 / 0.0;

//    Sender.AddConstantN('NaN', 'extended')^.Value.textended := 0.0 / 0.0; //nolang
//    Sender.AddConstantN('Infinity', 'extended')^.Value.textended := 1.0 / 0.0; //nolang
//    Sender.AddConstantN('NegInfinity', 'extended')^.Value.textended := - 1.0 / 0.0; //nolang

    Sender.AddConstantN('NaN', 'extended').Value.textended := 0.0 / 0.0;
    Sender.AddConstantN('Infinity', 'extended').Value.textended := 1.0 / 0.0;
    Sender.AddConstantN('NegInfinity', 'extended').Value.textended := - 1.0 / 0.0;


{    cl := TIFPSCompileTimeClassesImporter.Create(Sender, True);
    SIRegister_Std(Cl);
    SIRegister_Classes(Cl);
    SIRegister_Graphics(Cl);
    SIRegister_Controls(Cl);
    SIRegister_stdctrls(Cl);
    SIRegister_Forms(Cl);}

    SIRegister_Std(Sender);
    SIRegister_Classes(Sender, True);
    SIRegister_Graphics(Sender, True);
    SIRegister_Controls(Sender);
    SIRegister_stdctrls(Sender);
    SIRegister_Forms(Sender);
    SIRegister_ComObj(Sender);

    // Date et heure
//        function AddTypeS(const Name, Decl: string): TPSType;
    Sender.AddTypeS('TDateTime', //nolang
       'double'); //nolang
//    Cl.se.addTypeS('TDateTime', 'double');  //nolang
    Sender.AddDelphiFunction('function EncodeDate(Year, Month, Day: Word): TDateTime;');
//    RegisterDelphiFunctionC(Sender,'function EncodeDate(Year, Month, Day: Word): TDateTime;'); //nolang
    Sender.AddDelphiFunction('function EncodeTime(Hour, Min, Sec, MSec: Word): TDateTime;');
//    RegisterDelphiFunctionC(Sender,'function EncodeTime(Hour, Min, Sec, MSec: Word): TDateTime;'); //nolang
    Sender.AddDelphiFunction('function TryEncodeDate(Year, Month, Day: Word; var Date: TDateTime): Boolean;');
//    RegisterDelphiFunctionC(Sender,'function TryEncodeDate(Year, Month, Day: Word; var Date: TDateTime): Boolean;'); //nolang
    Sender.AddDelphiFunction('function TryEncodeTime(Hour, Min, Sec, MSec: Word; var Time: TDateTime): Boolean;');
//    RegisterDelphiFunctionC(Sender,'function TryEncodeTime(Hour, Min, Sec, MSec: Word; var Time: TDateTime): Boolean;'); //nolang
    Sender.AddDelphiFunction('procedure DecodeDate(const DateTime: TDateTime; var Year, Month, Day: Word);');
//    RegisterDelphiFunctionC(Sender,'procedure DecodeDate(const DateTime: TDateTime; var Year, Month, Day: Word);'); //nolang
    Sender.AddDelphiFunction('procedure DecodeTime(const DateTime: TDateTime; var Hour, Min, Sec, MSec: Word);');
//    RegisterDelphiFunctionC(Sender,'procedure DecodeTime(const DateTime: TDateTime; var Hour, Min, Sec, MSec: Word);'); //nolang
    Sender.AddDelphiFunction('function DayOfWeek(const DateTime: TDateTime): Word;');
//    RegisterDelphiFunctionC(Sender,'function DayOfWeek(const DateTime: TDateTime): Word;'); //nolang
    Sender.AddDelphiFunction('function Date: TDateTime;');
//    RegisterDelphiFunctionC(Sender,'function Date: TDateTime;'); //nolang
    Sender.AddDelphiFunction('function Time: TDateTime;');
//    RegisterDelphiFunctionC(Sender,'function Time: TDateTime;'); //nolang
    Sender.AddDelphiFunction('function Now: TDateTime;');
//    RegisterDelphiFunctionC(Sender,'function Now: TDateTime;'); //nolang
    Sender.AddDelphiFunction('function DateTimeToUnix(D: TDateTime): Int64;');
//    RegisterDelphiFunctionC(Sender,'function DateTimeToUnix(D: TDateTime): Int64;'); //nolang
    Sender.AddDelphiFunction('function UnixToDateTime(U: Int64): TDateTime;');
//    RegisterDelphiFunctionC(Sender,'function UnixToDateTime(U: Int64): TDateTime;'); //nolang
    Sender.AddDelphiFunction('function DateToStr(D: TDateTime): string;');
//    RegisterDelphiFunctionC(Sender,'function DateToStr(D: TDateTime): string;'); //nolang
    Sender.AddDelphiFunction('function StrToDate(const s: string): TDateTime;');
//    RegisterDelphiFunctionC(Sender,'function StrToDate(const s: string): TDateTime;'); //nolang
    Sender.AddDelphiFunction('function FormatDateTime(const fmt: string; D: TDateTime): string;');
//    RegisterDelphiFunctionC(Sender,'function FormatDateTime(const fmt: string; D: TDateTime): string;'); //nolang

    Sender.AddDelphiFunction('function  HourToJulianDay(DateTime:TDateTime):Double;');
//    RegisterDelphiFunctionC(Sender, 'function  HourToJulianDay(DateTime:TDateTime):Double;'); //nolang
    Sender.AddDelphiFunction('function  JulianDayToHour(JD:Double):TDateTime;');
//    RegisterDelphiFunctionC(Sender, 'function  JulianDayToHour(JD:Double):TDateTime;'); //nolang
    Sender.AddDelphiFunction('function  LocalSidTim(DateTime:TDateTime;Longitude:Double):Double;');
//    RegisterDelphiFunctionC(Sender, 'function  LocalSidTim(DateTime:TDateTime;Longitude:Double):Double;'); //nolang
    Sender.AddDelphiFunction('function AngularDistance(Alpha1,Delta1,Alpha2,Delta2:Double):Double;');
//    RegisterDelphiFunctionC(Sender, 'AngularDistance(Alpha1,Delta1,Alpha2,Delta2:Double):Double;'); //nolang
    Sender.AddDelphiFunction('procedure GetAlphaDeltaFromHor(DateTime:TDateTime;Elevation,Azimuth,ObsLatitude,ObsLongitude:Double;var Alpha,Delta:Double);');
//    RegisterDelphiFunctionC(Sender, 'GetAlphaDeltaFromHor(DateTime:TDateTime;Elevation,Azimuth,ObsLatitude,ObsLongitude:Double;var Alpha,Delta:Double);'); //nolang
    Sender.AddDelphiFunction('procedure GetHorFromAlphaDelta(AngleHoraire,Delta,ObsLatitude:Double;var Azimuth,Hauteur:Double );');
//    RegisterDelphiFunctionC(Sender, 'GetHorFromAlphaDelta(AngleHoraire,Delta,ObsLatitude:Double;var Azimuth,Hauteur:Double );'); //nolang
    Sender.AddDelphiFunction('function GetElevation(DateTime:TDateTime;Alpha,Delta,ObsLatitude,ObsLongitude:Double):double;');
//    RegisterDelphiFunctionC(Sender, 'GetElevation(DateTime:TDateTime;Alpha,Delta,ObsLatitude,ObsLongitude:Double):double;'); //nolang
    Sender.AddDelphiFunction('function GetElevationNow(Alpha,Delta,ObsLatitude,ObsLongitude:double):Double;');
//    RegisterDelphiFunctionC(Sender, 'GetElevationNow(Alpha,Delta,ObsLatitude,ObsLongitude:double):Double;'); //nolang
    Sender.AddDelphiFunction('function GetAzimuth(DateTime:TDateTime;Alpha,Delta,ObsLatitude,ObsLongitude:Double):Double;');
//    RegisterDelphiFunctionC(Sender, 'GetAzimuth(DateTime:TDateTime;Alpha,Delta,ObsLatitude,ObsLongitude:Double):Double;'); //nolang
    Sender.AddDelphiFunction('function GetAzimuthNow(Alpha,Delta,ObsLatitude,ObsLongitude:Double):Double;');
//    RegisterDelphiFunctionC(Sender, 'GetAzimuthNow(Alpha,Delta,ObsLatitude,ObsLongitude:Double):Double;'); //nolang
    Sender.AddDelphiFunction('function GetHourAngle(DateTime:TDateTime;Alpha,ObsLongitude:double):Double;');
//    RegisterDelphiFunctionC(Sender, 'GetHourAngle(DateTime:TDateTime;Alpha,ObsLongitude:double):Double;'); //nolang
    Sender.AddDelphiFunction('function GetAlphaFromHourAngle(DateTime:TDateTime;AH,ObsLongitude:double):Double;');
//    RegisterDelphiFunctionC(Sender, 'GetAlphaFromHourAngle(DateTime:TDateTime;AH,ObsLongitude:double):Double;'); //nolang
    Sender.AddDelphiFunction('function DistanceToMoon(DateTime:TDateTime;Alpha,Delta:Double):Double;');
//    RegisterDelphiFunctionC(Sender, 'DistanceToMoon(DateTime:TDateTime;Alpha,Delta:Double):Double;'); //nolang
    Sender.AddDelphiFunction('function MoonCurrentPhase(DateTime:TDateTime):Double;');
//    RegisterDelphiFunctionC(Sender, 'MoonCurrentPhase(DateTime:TDateTime):Double;'); //nolang
    Sender.AddDelphiFunction('function DistanceToSun(DateTime:TDateTime;Alpha,Delta:Double):Double;');
//    RegisterDelphiFunctionC(Sender, 'DistanceToSun(DateTime:TDateTime;Alpha,Delta:Double):Double;'); //nolang
    Sender.AddDelphiFunction('function AirMass(Delta,HA:double):Double;');
//    RegisterDelphiFunctionC(Sender, 'AirMass(Delta,HA:double):Double;'); //nolang

//    RegisterDatetimeLibrary_C(Sender);

    // Registers the application variable to the script engine.
    AddImportedClassVariable(Sender, 'Memo1', //nolang
       'TMemo');  //nolang
    AddImportedClassVariable(Sender, 'Memo2', //nolang
       'TMemo');  //nolang
    AddImportedClassVariable(Sender, 'Self', //nolang
       'TForm'); //nolang
    AddImportedClassVariable(Sender, 'Application', //nolang
       'TApplication'); //nolang

//    RegisterStandardLibrary_C(Sender);

    // TeleAuto
// with Cl.Add(cl.FindClass('TSCROLLINGWINCONTROL'), TFORM) do
//    RegisterMethod(lang('procedure CLOSE'));

//   with Cl.Add(cl.FindClass('TPOP_IMAGE'),Tpop_image) do //nolang
   with Sender.AddClassN(Sender.FindClass('TPOP_IMAGE'),'Tpop_image') do //nolang
      begin
      RegisterMethod('constructor CREATE(AOWNER:TCOMPONENT)'); //nolang
      RegisterMethod('procedure SHOW'); //nolang
      RegisterMethod('procedure HIDE'); //nolang
      RegisterMethod('procedure CLOSE'); //nolang
      RegisterMethod('procedure VISUSTAR'); //nolang
      RegisterMethod('procedure VISUSTARPLANE(Nb:Integer)'); //nolang
      RegisterMethod('procedure VISUPLANET'); //nolang
      RegisterMethod('procedure VISUPLANETPLANE(Nb:Integer)'); //nolang
      RegisterMethod('procedure VISUMINMAX'); //nolang
      RegisterMethod('procedure VISU(Mini,Maxi:Single)'); //nolang
      RegisterMethod('procedure VISUPLANE(Plane:Byte;Mini,Maxi:Single)'); //nolang

      RegisterMethod('function READIMAGE(FileName:string):Boolean;'); //nolang
      RegisterMethod('procedure SAVEIMAGE(FileName:string);'); //nolang
      RegisterMethod('procedure SAVEFITSINT(FileName:string)'); //nolang
      RegisterMethod('procedure SAVEFITSFLOAT(FileName:string)'); //nolang
      RegisterMethod('procedure SAVECPAV3(FileName:string)'); //nolang
      RegisterMethod('procedure SAVECPAV4(FileName:string)'); //nolang
      RegisterMethod('procedure SAVEPIC(FileName:string)'); //nolang
      RegisterMethod('procedure SAVEBMP(FileName:string)'); //nolang
      RegisterMethod('procedure SAVEJPG(FileName:string)'); //nolang
      RegisterMethod('procedure SAVETXT(FileName:string)'); //nolang

      RegisterProperty('TOP'    ,'Integer',iptrw); //nolang
      RegisterProperty('LEFT'   ,'Integer',iptrw); //nolang
      RegisterProperty('HEIGHT' ,'Integer',iptrw); //nolang
      RegisterProperty('WIDTH'  ,'Integer',iptrw); //nolang
      end;

//   with Cl.Add(cl.FindClass('TPOP_CAMERA'),Tpop_camera) do //nolang
   with Sender.AddClassN(Sender.FindClass('TPOP_CAMERA'),'Tpop_camera') do //nolang
      begin
      RegisterMethod('procedure SHOW'); //nolang
      RegisterMethod('procedure HIDE'); //nolang
      RegisterMethod('procedure STARTB1'); //nolang
      RegisterMethod('procedure STARTB2'); //nolang
      RegisterMethod('procedure STARTB3'); //nolang
      RegisterMethod('procedure SETPOSEB1(Pose:Single)'); //nolang
      RegisterMethod('procedure SETPOSEB2(Pose:Single)'); //nolang
      RegisterMethod('procedure SETPOSEB3(Pose:Single)'); //nolang
      RegisterMethod('procedure SETLOOPNB(Nb:Integer)'); //nolang
      RegisterMethod('procedure SETSTARTINDEX(Nb:Integer)'); //nolang
      RegisterMethod('procedure SETIMGNAME(Name:string)'); //nolang
      RegisterMethod('procedure SETLOOPON'); //nolang
      RegisterMethod('procedure SETLOOPOFF'); //nolang
      RegisterMethod('procedure SETAUTOSAVEON'); //nolang
      RegisterMethod('procedure SETAUTOSAVEOFF'); //nolang
      RegisterMethod('procedure SETIMGTYPE(ImgType:Integer)'); //nolang
      RegisterMethod('procedure WAITENDACQ'); //nolang
      RegisterMethod('procedure WAITENDPOSE'); //nolang
      RegisterMethod('procedure SETWINDOW(x1,y1,x2,y2:Integer)'); //nolang
      RegisterMethod('procedure INITWINDOW'); //nolang
      RegisterMethod('procedure SETSTATON'); //nolang
      RegisterMethod('procedure SETSTATOFF'); //nolang
      RegisterMethod('function SETFILTER(FilterNb:Integer):Boolean'); //nolang
      RegisterMethod('procedure STARTWATCH'); //nolang
      RegisterMethod('procedure SETWATCHWAIT(Wait:Single)'); //nolang
      RegisterMethod('procedure SETWATCHIMGNB(Nb:Integer)'); //nolang
      RegisterMethod('procedure SETWATCHSTART(Percent:Integer)'); //nolang
      RegisterMethod('procedure GETIMG(var Img:Tpop_Image)'); //nolang

      RegisterMethod('procedure ACQIMG(x1,y1,x2,y2:Integer;Pose:Double;Bin:Integer;ShutterClosed:Boolean)'); //nolang

      RegisterProperty('TOP'  ,'Integer',iptrw); //nolang
      RegisterProperty('LEFT' ,'Integer',iptrw); //nolang
      end;

//   with Cl.Add(cl.FindClass('TPOP_CAMERA_GUIDE'),Tpop_camera_suivi) do //nolang
   with Sender.AddClassN(Sender.FindClass('TPOP_CAMERA_GUIDE'),'Tpop_camera_suivi') do //nolang
      begin
      RegisterMethod('procedure SHOW'); //nolang
      RegisterMethod('procedure HIDE'); //nolang
      RegisterMethod('procedure STARTB1'); //nolang
      RegisterMethod('procedure STARTB2'); //nolang
      RegisterMethod('procedure STARTB3'); //nolang
      RegisterMethod('procedure SETPOSE(Pose:Single)'); //nolang
      RegisterMethod('procedure STARTGUIDE;'); //nolang
      RegisterMethod('procedure STOPGUIDE;'); //nolang
      RegisterMethod('function GETERROR:string;'); //nolang
      RegisterMethod('procedure WAITGUIDE'); //nolang

      RegisterProperty('TOP'  ,'Integer',iptrw); //nolang
      RegisterProperty('LEFT' ,'Integer',iptrw); //nolang
      end;

//   with Cl.Add(cl.FindClass('TPOP_RAPPORT'),Tpop_Rapport) do //nolang
   with Sender.AddClassN(Sender.FindClass('TPOP_RAPPORT'),'Tpop_Rapport') do //nolang
      begin
      RegisterMethod('constructor CREATE(AOWNER:TCOMPONENT)'); //nolang
      RegisterMethod('procedure SHOW'); //nolang
      RegisterMethod('procedure HIDE'); //nolang
      RegisterMethod('procedure ENABLEBUTTONS'); //nolang
      RegisterMethod('procedure ADDLINE(Line:string)'); //nolang
      RegisterMethod('procedure CLOSE'); //nolang

      RegisterProperty('TOP'     ,'Integer',iptrw); //nolang
      RegisterProperty('LEFT'    ,'Integer',iptrw); //nolang
      RegisterProperty('HEIGHT'  ,'Integer',iptrw); //nolang
      RegisterProperty('WIDTH'   ,'Integer',iptrw); //nolang
      RegisterProperty('CAPTION' ,'Integer',iptrw); //nolang
      end;

//   with Cl.Add(cl.FindClass('TPOP_SCOPE'),Tpop_scope) do //nolang
   with Sender.AddClassN(Sender.FindClass('TPOP_SCOPE'),'Tpop_scope') do //nolang
      begin
      RegisterMethod('procedure SHOW'); //nolang
      RegisterMethod('procedure HIDE'); //nolang

      RegisterMethod('procedure SETOBJECTNAME(Name:string)'); //nolang
      RegisterMethod('procedure POINTOBJECT'); //nolang
      RegisterMethod('procedure REALIGNOBJECT'); //nolang
      RegisterMethod('procedure SETALPHACOORDINATES(Alpha:Double)'); //nolang
      RegisterMethod('procedure SETDELTACOORDINATES(Delta:Double)'); //nolang
      RegisterMethod('procedure POINTCOORDINATES'); //nolang
      RegisterMethod('procedure REALIGNCOORDINATES'); //nolang
      RegisterMethod('procedure MAINCCDCENTER'); //nolang
      RegisterMethod('procedure GUIDECCDCENTER'); //nolang
      RegisterMethod('procedure STOPSCOPE'); //nolang
      RegisterMethod('procedure SETMARKON'); //nolang
      RegisterMethod('procedure SETMARKOFF'); //nolang

      RegisterMethod('procedure SETPULSEON'); //nolang
      RegisterMethod('procedure SETPULSEOFF'); //nolang
      RegisterMethod('procedure SETPULSEDELAY(Delay:Double)'); //nolang
      RegisterMethod('procedure SPEED1'); //nolang
      RegisterMethod('procedure SPEED2'); //nolang
      RegisterMethod('procedure SPEED3'); //nolang
      RegisterMethod('procedure SPEED4'); //nolang
      RegisterMethod('procedure SETINVERTNSON'); //nolang
      RegisterMethod('procedure SETINVERTNSOFF'); //nolang
      RegisterMethod('procedure SETINVERTEWON'); //nolang
      RegisterMethod('procedure SETINVERTEWOFF'); //nolang
      RegisterMethod('procedure NORTHMOUSEDOWN'); //nolang
      RegisterMethod('procedure NORTHMOUSEUP'); //nolang
      RegisterMethod('procedure SOUTHMOUSEDOWN'); //nolang
      RegisterMethod('procedure SOUTHMOUSEUP'); //nolang
      RegisterMethod('procedure WESTMOUSEDOWN'); //nolang
      RegisterMethod('procedure WESTMOUSEUP'); //nolang
      RegisterMethod('procedure EASTMOUSEDOWN'); //nolang
      RegisterMethod('procedure EASTMOUSEUP'); //nolang

      RegisterMethod('procedure PARK'); //nolang
      RegisterMethod('procedure UNPARK'); //nolang
      RegisterMethod('procedure SETPHYSICALPARKON'); //nolang
      RegisterMethod('procedure SETPHYSICALPARKOFF'); //nolang
      RegisterMethod('procedure SETFASTSPEED(Speed:Byte)'); //nolang

      RegisterMethod('function GETPOSITION(var Alpha,Delta:Double):Boolean'); //nolang
      RegisterMethod('function POINT(Alpha,Delta:Double):Boolean'); //nolang
      RegisterMethod('function GETERROR:string'); //nolang
      RegisterMethod('function WAIT(Alpha,Delta:Double):Boolean'); //nolang
      RegisterMethod('function POINTOBJECTNAME(ObjectName:string):Boolean'); //nolang
      RegisterMethod('function WAITOBJECTNAME(ObjectName:string):Boolean'); //nolang
      RegisterMethod('function REALIGN(Alpha,Delta:Double):Boolean'); //nolang
      RegisterMethod('function REALIGNOBJECTNAME(ObjectName:string):Boolean'); //nolang
      RegisterMethod('function STARTMOTION(Direction:string):Boolean'); //nolang
      RegisterMethod('function STOPMOTION(Direction:string):Boolean'); //nolang
      RegisterMethod('function MOTIONRATE(MotionNumber:Integer):Boolean'); //nolang
      RegisterMethod('function QUIT:Boolean'); //nolang

      RegisterProperty('TOP'  ,'Integer',iptrw); //nolang
      RegisterProperty('LEFT' ,'Integer',iptrw); //nolang
      end;

    //toto
    // Registers the application variable to the script engine.
    AddImportedClassVariable(Sender, 'Self', 'TForm'); //nolang
// function AddImportedClassVariable(Sender: TIFPSPascalCompiler; const VarName, VarType: string): Boolean;
   AddImportedClassVariable(Sender, 'WinCamera', 'Tpop_Camera'); //nolang
   AddImportedClassVariable(Sender, 'WinCameraGuide', 'Tpop_Camera_Suivi'); //nolang
   AddImportedClassVariable(Sender, 'WinScope', 'Tpop_scope'); //nolang

//   RegisterDelphiFunctionC(Sender, 'function OpenImage(var pop_image:tpop_image):Boolean;'); //nolang
    Sender.AddDelphiFunction('function OpenImage(var pop_image:tpop_image):Boolean;'); //nolang

//   RegisterDelphiFunctionC(Sender, 'procedure WaitEndPose;'); //nolang

   Result := True;
  end
  else
  begin
    TIFPSPascalCompiler(Sender).MakeError('', ecUnknownIdentifier, '');
    Result := False;
  end;
end;



// laisser ca ici, ca fait pro :)


procedure Tpop_builder.Button1Click(Sender: TObject);
begin
  if iStatus <> iStopped then iStatus := iStopped;
end;

procedure Tpop_builder.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=VK_F9 then
   begin
   // execute script
   BitBtn10Click(Sender);
   end
end;

procedure Tpop_builder.SynEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=VK_F9 then
   begin
   // execute script
   end
else if (key=ord('F')) and (shift =[ssctrl]) then
   begin
   // Search

   end
else if (key=ord('R')) and (shift=[ssctrl]) then
   begin
   // replace

   end
else if (key=ord('G')) and (shift=[ssctrl]) then
   begin
   // gotoline

   end
else if (key=ord('L')) and (shift=[ssctrl]) then
   begin
   // numeros de ligne
   SynEdit1.Gutter.ShowLineNumbers:=not(SynEdit1.Gutter.ShowLineNumbers);
   end
else
   begin
   LineError:=-1;
   SynEdit1.Refresh;
   end;
end;

procedure Tpop_builder.Button2Click(Sender: TObject);
begin
Close;
end;

procedure Tpop_builder.SynEdit1SpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var FG, BG: TColor);
begin
if Line=LineError then
   begin
   Special:=True;
   BG:=clBlue;
   FG:=clWhite;
   end;
end;

initialization
  Imp := TPSRuntimeClassImporter.Create;
  RIRegister_Std(Imp);
  RIRegister_Classes(Imp, True);
  RIRegister_Graphics(Imp, True);
  RIRegister_Controls(Imp);
  RIRegister_stdctrls(imp);
  RIRegister_Forms(Imp);

{   Imp := TIFPSRuntimeClassImporter.Create;
   RIRegister_Std(Imp);
//   RIRegister_Classes(Imp,True);
   RIRegister_Classes(Imp);
   RIRegister_Graphics(Imp);
   RIRegister_Controls(Imp);
   RIRegister_stdctrls(imp);
   RIRegister_Forms(Imp);}

   // TeleAuto
   // Image à compléter
   with Imp.Add(Tpop_Image) do
      begin
      RegisterConstructor(@Tpop_Image.Create              ,'CREATE'); //nolang
      RegisterMethod(@Tpop_Image.Show                     ,'SHOW'); //nolang
      RegisterMethod(@Tpop_Image.Hide                     ,'HIDE'); //nolang
      RegisterMethod(@Tpop_Image.Close                    ,'CLOSE'); //nolang
      RegisterMethod(@Tpop_Image.VisuStar                 ,'VISUSTAR'); //nolang
      RegisterMethod(@Tpop_Image.VisuStarPlane            ,'VISUSTARPLANE'); //nolang
      RegisterMethod(@Tpop_Image.VisuPlanet               ,'VISUPLANET'); //nolang
      RegisterMethod(@Tpop_Image.VisuPlanetPlane          ,'VISUPLANETPLANE'); //nolang
      RegisterMethod(@Tpop_Image.VisuMinMax               ,'VISUMINMAX'); //nolang
      RegisterMethod(@Tpop_Image.Visu                     ,'VISU'); //nolang
      RegisterMethod(@Tpop_Image.VisuPlane                ,'VISUPLANE'); //nolang

      RegisterMethod(@Tpop_Image.ReadImage                ,'READIMAGE'); //nolang
      RegisterMethod(@Tpop_Image.SaveImage                ,'SAVEIMAGE'); //nolang      
      RegisterMethod(@Tpop_Image.SaveFITSInt              ,'SAVEFITSINT'); //nolang
      RegisterMethod(@Tpop_Image.SaveFITSFloat            ,'SAVEFITSFLOAT'); //nolang
      RegisterMethod(@Tpop_Image.SaveImgCPAV3             ,'SAVECPAV3'); //nolang
      RegisterMethod(@Tpop_Image.SaveImgCPAV4             ,'SAVECPAV4'); //nolang
      RegisterMethod(@Tpop_Image.SaveImgPIC               ,'SAVEPIC'); //nolang
      RegisterMethod(@Tpop_Image.SaveImgBMP               ,'SAVEBMP'); //nolang
      RegisterMethod(@Tpop_Image.SaveImgJPG               ,'SAVEJPG'); //nolang
      RegisterMethod(@Tpop_Image.SaveImgTXT               ,'SAVETXT'); //nolang

      end;

   // Camera
   with Imp.Add(Tpop_Camera) do
      begin
//     procedure TIFPSRuntimeClass.RegisterMethod(ProcPtr: Pointer; const Name: string);
      RegisterMethod(@Tpop_Camera.Show           ,'SHOW'); //nolang
      RegisterMethod(@Tpop_Camera.Hide           ,'HIDE'); //nolang
      RegisterMethod(@Tpop_Camera.StartB1        ,'STARTB1'); //nolang
      RegisterMethod(@Tpop_Camera.StartB2        ,'STARTB2'); //nolang
      RegisterMethod(@Tpop_Camera.StartB3        ,'STARTB3'); //nolang
      RegisterMethod(@Tpop_Camera.SetPoseB1      ,'SETPOSEB1'); //nolang
      RegisterMethod(@Tpop_Camera.SetPoseB2      ,'SETPOSEB2'); //nolang
      RegisterMethod(@Tpop_Camera.SetPoseB3      ,'SETPOSEB3'); //nolang
      RegisterMethod(@Tpop_Camera.SetLoopNb      ,'SETLOOPNB'); //nolang
      RegisterMethod(@Tpop_Camera.SetStartIndex  ,'SETSTARTINDEX'); //nolang
      RegisterMethod(@Tpop_Camera.SetImgName     ,'SETIMGNAME'); //nolang
      RegisterMethod(@Tpop_Camera.SetLoopOn      ,'SETLOOPON'); //nolang
      RegisterMethod(@Tpop_Camera.SetLoopOff     ,'SETLOOPOFF'); //nolang
      RegisterMethod(@Tpop_Camera.SetAutoSaveOn  ,'SETAUTOSAVEON'); //nolang
      RegisterMethod(@Tpop_Camera.SetAutoSaveOff ,'SETAUTOSAVEOFF'); //nolang
      RegisterMethod(@Tpop_Camera.SetImgType     ,'SETIMGTYPE'); //nolang
      RegisterMethod(@Tpop_Camera.WaitEndAcq     ,'WAITENDACQ'); //nolang      
      RegisterMethod(@Tpop_Camera.WaitEndPose    ,'WAITENDPOSE'); //nolang
      RegisterMethod(@Tpop_Camera.SetWindow      ,'SETWINDOW'); //nolang
      RegisterMethod(@Tpop_Camera.InitWindow     ,'INITWINDOW'); //nolang
      RegisterMethod(@Tpop_Camera.SetStatOn      ,'SETSTATON'); //nolang
      RegisterMethod(@Tpop_Camera.SetStatOff     ,'SETSTATOFF'); //nolang
      RegisterMethod(@Tpop_Camera.SetFilter      ,'SETFILTER'); //nolang
      RegisterMethod(@Tpop_Camera.StartWatch     ,'STARTWATCH'); //nolang
      RegisterMethod(@Tpop_Camera.SetWatchWait   ,'SETWATCHWAIT'); //nolang
      RegisterMethod(@Tpop_Camera.SetWatchImgNb  ,'SETWATCHIMGNB'); //nolang
      RegisterMethod(@Tpop_Camera.SetWatchStart  ,'SETWATCHSTART'); //nolang
      RegisterMethod(@Tpop_Camera.GetImg         ,'GETIMG'); //nolang

      RegisterMethod(@Tpop_Camera.AcquisitionAuto,'ACQIMG'); //nolang
      end;

   with Imp.Add(Tpop_Camera_suivi) do
      begin
      RegisterMethod(@Tpop_Camera_Suivi.Show           ,'SHOW'); //nolang
      RegisterMethod(@Tpop_Camera_Suivi.Hide           ,'HIDE'); //nolang

      RegisterMethod(@Tpop_Camera_Suivi.StartB1        ,'STARTB1'); //nolang
      RegisterMethod(@Tpop_Camera_Suivi.StartB2        ,'STARTB2'); //nolang
      RegisterMethod(@Tpop_Camera_Suivi.StartB3        ,'STARTB3'); //nolang
      RegisterMethod(@Tpop_Camera_Suivi.SetPose        ,'SETPOSE'); //nolang
      RegisterMethod(@Tpop_Camera_Suivi.StartGuide     ,'STARTGUIDE'); //nolang
      RegisterMethod(@Tpop_Camera_Suivi.StopGuide      ,'STOPGUIDE'); //nolang
      RegisterMethod(@Tpop_Camera_Suivi.GetError       ,'GETERROR'); //nolang
      RegisterMethod(@Tpop_Camera_Suivi.WaitGuide      ,'WAITGUIDE'); //nolang
      end;

   // Rapport
   with Imp.Add(Tpop_Rapport) do
      begin
      RegisterConstructor(@Tpop_Rapport.Create    ,'CREATE'); //nolang
      RegisterMethod(@Tpop_Rapport.Show           ,'SHOW'); //nolang
      RegisterMethod(@Tpop_Rapport.Hide           ,'HIDE'); //nolang
      RegisterMethod(@Tpop_Rapport.EnableButtons  ,'ENABLEBUTTONS'); //nolang
      RegisterMethod(@Tpop_Rapport.AddLine        ,'ADDLINE'); //nolang
      RegisterMethod(@Tpop_Rapport.Close          ,'CLOSE'); //nolang
      end;

   // Telescope
   with Imp.Add(Tpop_scope) do
      begin
//     procedure TIFPSRuntimeClass.RegisterMethod(ProcPtr: Pointer; const Name: string);
      RegisterMethod(@Tpop_scope.Show                ,'SHOW'); //nolang
      RegisterMethod(@Tpop_scope.Hide                ,'HIDE'); //nolang

      RegisterMethod(@Tpop_scope.SetObjectName       ,'SETOBJECTNAME'); //nolang
      RegisterMethod(@Tpop_scope.PointObject         ,'POINTOBJECT'); //nolang
      RegisterMethod(@Tpop_scope.RealignObject       ,'REALIGNOBJECT'); //nolang
      RegisterMethod(@Tpop_scope.SetAlphaCoordinates ,'SETALPHACOORDINATES'); //nolang
      RegisterMethod(@Tpop_scope.SetDeltaCoordinates ,'SETDELTACOORDINATES'); //nolang
      RegisterMethod(@Tpop_scope.PointCoordinates    ,'POINTCOORDINATES'); //nolang
      RegisterMethod(@Tpop_scope.RealignCoordinates  ,'REALIGNCOORDINATES'); //nolang
      RegisterMethod(@Tpop_scope.MainCCDCenter       ,'MAINCCDCENTER'); //nolang
      RegisterMethod(@Tpop_scope.GuideCCDCenter      ,'GUIDECCDCENTER'); //nolang
      RegisterMethod(@Tpop_scope.StopScope           ,'STOPSCOPE'); //nolang
      RegisterMethod(@Tpop_scope.SetMarkOn           ,'SETMARKON'); //nolang
      RegisterMethod(@Tpop_scope.SetMarkOff          ,'SETMARKOFF'); //nolang

      RegisterMethod(@Tpop_scope.SetPulseOn          ,'SETPULSEON'); //nolang
      RegisterMethod(@Tpop_scope.SetPulseOff         ,'SETPULSEOFF'); //nolang
      RegisterMethod(@Tpop_scope.SetPulseDelay       ,'SETPULSEDELAY'); //nolang
      RegisterMethod(@Tpop_scope.Speed1              ,'SPEED1'); //nolang
      RegisterMethod(@Tpop_scope.Speed2              ,'SPEED2'); //nolang
      RegisterMethod(@Tpop_scope.Speed3              ,'SPEED3'); //nolang
      RegisterMethod(@Tpop_scope.Speed4              ,'SPEED4'); //nolang
      RegisterMethod(@Tpop_scope.SetInvertNSOn       ,'SETINVERTNSON'); //nolang
      RegisterMethod(@Tpop_scope.SetInvertNSOff      ,'SETINVERTNSOFF'); //nolang
      RegisterMethod(@Tpop_scope.SetInvertEWOn       ,'SETINVERTEWON'); //nolang
      RegisterMethod(@Tpop_scope.SetInvertEWOff      ,'SETINVERTEWOFF'); //nolang
      RegisterMethod(@Tpop_scope.NorthMouseDown      ,'NORTHMOUSEDOWN'); //nolang
      RegisterMethod(@Tpop_scope.NorthMouseUp        ,'NORTHMOUSEUP'); //nolang
      RegisterMethod(@Tpop_scope.SouthMouseDown      ,'SOUTHMOUSEDOWN'); //nolang
      RegisterMethod(@Tpop_scope.SouthMouseUp        ,'SOUTHMOUSEUP'); //nolang
      RegisterMethod(@Tpop_scope.WestMouseDown       ,'WESTMOUSEDOWN'); //nolang
      RegisterMethod(@Tpop_scope.WestMouseUp         ,'WESTMOUSEUP'); //nolang
      RegisterMethod(@Tpop_scope.EastMouseDown       ,'EASTMOUSEDOWN'); //nolang
      RegisterMethod(@Tpop_scope.EastMouseUp         ,'EASTMOUSEUP'); //nolang

      RegisterMethod(@Tpop_scope.ScriptPark          ,'PARK'); //nolang
      RegisterMethod(@Tpop_scope.ScriptUnPark        ,'UNPARK'); //nolang
      RegisterMethod(@Tpop_scope.SetPhysicalParkOn   ,'SETPHYSICALPARKON'); //nolang
      RegisterMethod(@Tpop_scope.SetPhysicalParkOff  ,'SETPHYSICALPARKOFF'); //nolang
      RegisterMethod(@Tpop_scope.SetFastSpeed        ,'SETFASTSPEED'); //nolang

      RegisterMethod(@Tpop_scope.GetPosition         ,'GETPOSITION'); //nolang
      RegisterMethod(@Tpop_scope.Point               ,'POINT'); //nolang
      RegisterMethod(@Tpop_scope.GetError            ,'GETERROR'); //nolang
      RegisterMethod(@Tpop_scope.Wait                ,'WAIT'); //nolang
      RegisterMethod(@Tpop_scope.PointObjectName     ,'POINTOBJECTNAME'); //nolang
      RegisterMethod(@Tpop_scope.WaitObjectName      ,'WAITOBJECTNAME'); //nolang
      RegisterMethod(@Tpop_scope.Realign             ,'REALIGN'); //nolang
      RegisterMethod(@Tpop_scope.RealignObjectName   ,'REALIGNOBJECTNAME'); //nolang
      RegisterMethod(@Tpop_scope.StartMotion         ,'STARTMOTION'); //nolang
      RegisterMethod(@Tpop_scope.StopMotion          ,'STOPMOTION'); //nolang
      RegisterMethod(@Tpop_scope.MotionRate          ,'MOTIONRATE'); //nolang
      RegisterMethod(@Tpop_scope.Quit                ,'QUIT'); //nolang
      end;

finalization
   Imp.Free;
end.
