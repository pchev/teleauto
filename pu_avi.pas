unit pu_avi;

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
  StdCtrls, ExtCtrls, ComCtrls, Buttons, Spin,jpeg,shellapi,Math;

type
  Tpop_avi = class(TForm)
    PanelButton: TPanel;
    OpenDialog: TOpenDialog;
    ButtonOpen: TBitBtn;
    ButtonConvert: TBitBtn;
    ButtonPlay: TBitBtn;
    outEdit1: TEdit;
    Label2: TLabel;
    index: TSpinEdit;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    ProgressBar1: TProgressBar;
    OutLabel1: TLabel;
    SpeedButton1: TSpeedButton;
    SpinEdit1: TSpinEdit;
    Label4: TLabel;
    Bevel1: TBevel;
    procedure ButtonConvertClick(Sender: TObject);
    procedure ButtonOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonPlayClick(Sender: TObject);
    procedure OpenAVI(Sender: TObject);
    Procedure GetAVIFrame(Frame:integer;Sender: TObject);
    Procedure CloseAVI(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
   coeff:single;  {coefficient d'ajustement de l'image}
   BmpWidth,BmpHeight:integer;
   ImgWndProc:TWndMethod;
   procedure UpdateImage;
   procedure BevelPaint(var Msg:TMessage);
  public
    { Public declarations }
  end;

type PCLSID = PGUID;

type

 { TAVIFileInfoW record }

  LONG = Longint;
  PVOID = Pointer;

// TAVIFileInfo dwFlag values
const
  AVIF_HASINDEX		= $00000010;
  AVIF_MUSTUSEINDEX	= $00000020;
  AVIF_ISINTERLEAVED	= $00000100;
  AVIF_WASCAPTUREFILE	= $00010000;
  AVIF_COPYRIGHTED	= $00020000;
  AVIF_KNOWN_FLAGS	= $00030130;

type
  TAVIFileInfoW = record
    dwMaxBytesPerSec,	// taux max.
    dwFlags,
    dwCaps,
    dwStreams,
    dwSuggestedBufferSize,

    dwWidth,
    dwHeight,

    dwScale,
    dwRate,	// dwRate / dwScale = images/secondes
    dwLength,

    dwEditCount: DWORD;

    szFileType: array[0..63] of WideChar;
  end;
  PAVIFileInfoW = ^TAVIFileInfoW;

// TAVIStreamInfo dwFlag values
const
  AVISF_DISABLED	= $00000001;
  AVISF_VIDEO_PALCHANGES= $00010000;
  AVISF_KNOWN_FLAGS	= $00010001;

type
  TAVIStreamInfoA = record
    fccType,
    fccHandler,
    dwFlags,        // Contains AVITF_* flags
    dwCaps: DWORD;
    wPriority,
    wLanguage: WORD;
    dwScale,
    dwRate, // dwRate / dwScale = images/secondes
    dwStart,
    dwLength,
    dwInitialFrames,
    dwSuggestedBufferSize,
    dwQuality,
    dwSampleSize: DWORD;
    rcFrame: TRect;
    dwEditCount,
    dwFormatChangeCount: DWORD;
    szName:  array[0..63] of AnsiChar;
  end;
  TAVIStreamInfo = TAVIStreamInfoA;
  PAVIStreamInfo = ^TAVIStreamInfo;

  { TAVIStreamInfoW record }

  TAVIStreamInfoW = record
    fccType,
    fccHandler,
    dwFlags,        // Contains AVITF_* flags
    dwCaps: DWORD;
    wPriority,
    wLanguage: WORD;
    dwScale,
    dwRate,
    dwStart,
    dwLength,
    dwInitialFrames,
    dwSuggestedBufferSize,
    dwQuality,
    dwSampleSize: DWORD;
    rcFrame: TRect;
    dwEditCount,
    dwFormatChangeCount: DWORD;
    szName:  array[0..63] of WideChar;
  end;

  PAVIStream = pointer;
  PAVIFile = pointer;
  TAVIStreamList = array[0..0] of PAVIStream;
  PAVIStreamList = ^TAVIStreamList;
  TAVISaveCallback = function (nPercent: integer): LONG; stdcall;

  TAVICompressOptions = packed record
    fccType		: DWORD;
    fccHandler		: DWORD;
    dwKeyFrameEvery	: DWORD;
    dwQuality		: DWORD;
    dwBytesPerSecond	: DWORD;
    dwFlags		: DWORD;
    lpFormat		: pointer;
    cbFormat		: DWORD;
    lpParms		: pointer;
    cbParms		: DWORD;
    dwInterleaveEvery	: DWORD;
  end;
  PAVICompressOptions = ^TAVICompressOptions;

// Palette
const
  RIFF_PaletteChange: DWORD = 1668293411;
type
  TAVIPalChange = packed record
    bFirstEntry		: byte;
    bNumEntries		: byte;
    wFlags		: WORD;
    peNew		: array[byte] of TPaletteEntry;
  end;
  PAVIPalChange = ^TAVIPalChange;

procedure AVIFileInit; stdcall;
procedure AVIFileExit; stdcall;
function AVIFileOpen(var ppfile: PAVIFile; szFile: PChar; uMode: UINT; lpHandler: pointer): HResult; stdcall;
function AVIFileCreateStream(pfile: PAVIFile; var ppavi: PAVISTREAM; var psi: TAVIStreamInfo): HResult; stdcall;
function AVIStreamSetFormat(pavi: PAVIStream; lPos: LONG; lpFormat: pointer; cbFormat: LONG): HResult; stdcall;
function AVIStreamReadFormat(pavi: PAVIStream; lPos: LONG; lpFormat: pointer; var cbFormat: LONG): HResult; stdcall;
function AVIStreamWrite(pavi: PAVIStream; lStart, lSamples: LONG; lpBuffer: pointer; cbBuffer: LONG; dwFlags: DWORD; var plSampWritten: LONG; var plBytesWritten: LONG): HResult; stdcall;
function AVIStreamWriteData(pavi: PAVIStream; ckid: DWORD; lpData: pointer; cbData: LONG): HResult; stdcall;
function AVIStreamRelease(pavi: PAVISTREAM): ULONG; stdcall;
function AVIFileRelease(pfile: PAVIFile): ULONG; stdcall;
function AVIFileGetStream(pfile: PAVIFile; var ppavi: PAVISTREAM; fccType: DWORD; lParam: LONG): HResult; stdcall;
function AVIStreamBeginStreaming(pavi: PAVISTREAM; lStart, lEnd: LONG; lRate: LONG): HResult; stdcall;
function AVIStreamEndStreaming(pavi: PAVISTREAM): HResult; stdcall;
function AVIStreamGetFrameOpen(pavi: PAVISTREAM; var lpbiWanted: TBitmapInfoHeader): pointer; stdcall;
function AVIStreamGetFrame(pgf: pointer; lPos: LONG): pointer; stdcall;
function AVIStreamGetFrameClose(pget: pointer): HResult; stdcall;
function AVIStreamInfo(pavi: PAVISTREAM; var psi: TAVIStreamInfo; lSize: LONG): HResult; stdcall;
function AVIStreamLength(pavi: PAVISTREAM): LONG; stdcall;
function CreateEditableStream(var ppsEditable: PAVISTREAM; psSource: PAVISTREAM): HResult; stdcall;
function EditStreamSetInfo(pavi: PAVISTREAM; var lpInfo: TAVIStreamInfo; cbInfo: LONG): HResult; stdcall;
function AVIMakeFileFromStreams(var ppfile: PAVIFILE; nStreams: integer; papStreams: PAVIStreamList): HResult; stdcall;
function AVISave(szFile: PChar; pclsidHandler: PCLSID; lpfnCallback: TAVISaveCallback;
  nStreams: integer; pavi: PAVISTREAM; lpOptions: PAVICompressOptions): HResult; stdcall;

const
  AVIERR_OK       = 0;

  AVIIF_LIST      = $01;
  AVIIF_TWOCC	  = $02;
  AVIIF_KEYFRAME  = $10;

  streamtypeVIDEO = $73646976; // <=> FOURCC( 'v','i', 'd', 's' )  //nolang

implementation

{$R *.DFM}

uses
  u_file_io,
  u_class,
  pu_main,
  u_lang,
  u_general;

  procedure AVIFileInit; stdcall; external 'avifil32.dll' name 'AVIFileInit'; //nolang
  procedure AVIFileExit; stdcall; external 'avifil32.dll' name 'AVIFileExit'; //nolang
  function AVIFileOpen; external 'avifil32.dll' name 'AVIFileOpenA'; //nolang
  function AVIFileCreateStream; external 'avifil32.dll' name 'AVIFileCreateStreamA'; //nolang
  function AVIStreamSetFormat; external 'avifil32.dll' name 'AVIStreamSetFormat'; //nolang
  function AVIStreamReadFormat; external 'avifil32.dll' name 'AVIStreamReadFormat'; //nolang
  function AVIStreamWrite; external 'avifil32.dll' name 'AVIStreamWrite'; //nolang
  function AVIStreamWriteData; external 'avifil32.dll' name 'AVIStreamWriteData'; //nolang
  function AVIStreamRelease; external 'avifil32.dll' name 'AVIStreamRelease'; //nolang
  function AVIFileRelease; external 'avifil32.dll' name 'AVIFileRelease'; //nolang
  function AVIFileGetStream; external 'avifil32.dll' name 'AVIFileGetStream'; //nolang
  function AVIStreamBeginStreaming; external 'avifil32.dll' name 'AVIStreamBeginStreaming'; //nolang
  function AVIStreamEndStreaming; external 'avifil32.dll' name 'AVIStreamEndStreaming'; //nolang
  function AVIStreamGetFrameOpen; external 'avifil32.dll' name 'AVIStreamGetFrameOpen'; //nolang
  function AVIStreamGetFrame; external 'avifil32.dll' name 'AVIStreamGetFrame'; //nolang
  function AVIStreamGetFrameClose; external 'avifil32.dll' name 'AVIStreamGetFrameClose'; //nolang
  function AVIStreamInfo; external 'avifil32.dll' name 'AVIStreamInfo'; //nolang
  function AVIStreamLength; external 'avifil32.dll' name 'AVIStreamLength'; //nolang
  function CreateEditableStream; external 'avifil32.dll' name 'CreateEditableStream'; //nolang
  function EditStreamSetInfo; external 'avifil32.dll' name 'EditStreamSetInfo'; //nolang
  function AVIMakeFileFromStreams; external 'avifil32.dll' name 'AVIMakeFileFromStreams'; //nolang
  function AVISave; external 'avifil32.dll' name 'AVISave'; //nolang

var
  Filename: string;
  DoAbort: boolean;
  DoStop: boolean;
  Processing : boolean;
  ImgInt : PTabImgInt;
  TypeData, Nbplans : integer;
  ImgInfos : TImgInfos;
  pFile			: PAVIFile;
  pStream		: PAVISTREAM;
  StreamInfo		: TAVIStreamInfo;
  pGetFrame		: pointer;
  Bits			,
  BitmapInfo		: PBitmapInfo;
  BitmapFileHeader	: TBitmapFileHeader;
  Stream		: TMemoryStream;
  Bitmap		: TBitmap;
  Size			: integer;
  InfoSize		: longInt;
  Delay			: double;
  FrameWidth,FrameHeight, Format: integer;
  fccHandler:array [0..4] of char;
  ErreurAVI:byte;
  OutFormat:shortint;

procedure Tpop_avi.UpdateImage;
begin
 SetStretchBltMode(Tpop_avi(Self).Canvas.Handle,COLORONCOLOR);
// Bitblt(Canvas.Handle,2,99,BmpWidth,BmpHeight,Bitmap.Canvas.Handle,0,0,srcCopy);
 Stretchblt(Canvas.Handle,2,99,BmpWidth,BmpHeight,Bitmap.Canvas.Handle,0,0,Bitmap.width,Bitmap.height,srcCopy);
end;

procedure Tpop_avi.BevelPaint(var Msg:TMessage);
begin
 if Msg.Msg = WM_PAINT then UpdateImage;
 ImgWndProc(Msg);
end;

procedure Tpop_avi.FormCreate(Sender: TObject);
begin
with TPop_Avi(Self) do
begin
  OpenDialog.InitialDir:=config.RepImages;
  left:=application.MainForm.Left + (application.MainForm.Width-width) div 2;
  top:=application.MainForm.top + (application.MainForm.Height-Height) div 2;
  outlabel1.caption:='0 / 0'; //nolang
  Bitmap := TBitmap.Create;
  ImgWndProc:=bevel1.WindowProc;
  bevel1.WindowProc:=BevelPaint;
  UpDateLang(Self);
end;
end;

procedure Tpop_avi.ButtonOpenClick(Sender: TObject);
begin
  ButtonPlay.Enabled := false;
  ButtonConvert.Enabled := false;
  if TPop_Avi(Self).OpenDialog.Execute = true then
  begin
    try
      Filename := OpenDialog.FileName;
      OpenAVI(Sender);
      if ErreurAVI <> 0 then
       begin
        if (ErreurAVI <> 255) then CloseAVI(Sender);
        exit;
       end;
      GetAVIFrame(StreamInfo.dwStart,Sender);
      if ErreurAVI <> 0 then
       begin
        if (ErreurAVI <> 255) then CloseAVI(Sender);
        exit;
       end;
      if bitmap.height < bitmap.width then
       coeff:=(bevel1.ClientHeight - 4 ) / bitmap.height
      else
       coeff:=(bevel1.ClientWidth - 3) / bitmap.width;
      BmpWidth:=round(coeff * bitmap.width);
      BmpHeight:=round(coeff * bitmap.height);
      UpdateImage;
      outLabel1.Caption:= inttostr(StreamInfo.dwStart + 1) +' / '+inttostr(StreamInfo.dwLength);
      format:=0;
      if bitmap.PixelFormat=pf24bit then format:=24;
      if bitmap.PixelFormat=pf8bit then format:=8;
      CloseAVI(Sender);
      ButtonPlay.Enabled := True;
      ButtonConvert.Enabled := True;
      ButtonPlay.SetFocus;
    except
      CloseAVI(Sender);
    end;
  end;
end;

procedure Tpop_avi.ButtonPlayClick(Sender: TObject);
var Frame : integer;
begin
with TPop_Avi(Self) do
begin
DoStop:=false;
buttonplay.enabled:=false;
ButtonConvert.Enabled := false;
ButtonOpen.Enabled := false;
BitBtn1.Caption:='&Annuler'; //lang
progressbar1.Min:=StreamInfo.dwStart;
progressbar1.Max:=StreamInfo.dwLength-1;
progressbar1.Position:=progressbar1.Min;
Processing := true;
try
  OpenAVI(Sender);
  if ErreurAVI <> 0 then
   begin
    if (ErreurAVI <> 255) then CloseAVI(Sender);
    exit;
   end;
  for Frame := StreamInfo.dwStart to StreamInfo.dwLength-1 do
  begin
     if (DoStop) then Break;
     GetAVIFrame(Frame,Sender);
     if ErreurAVI <> 0 then break;
     UpdateImage;
     outLabel1.Caption:= inttostr(Frame+1)+' / '+inttostr(StreamInfo.dwLength);
     progressbar1.position:=frame;
     application.ProcessMessages;
  end;
finally
  CloseAVI(Sender);
  BitBtn1.Caption:='&Quitter';  //lang
  progressbar1.position:=0;
  outLabel1.Caption:= inttostr(StreamInfo.dwStart + 1) +' / '+inttostr(StreamInfo.dwLength);
  buttonplay.enabled:=true;
  ButtonConvert.Enabled := true;
  buttonOpen.enabled:=true;
  Processing := false;
end;
end;
end;

Procedure CreateWorkImage;
var i,k : integer;
begin
if format=24 then begin
    TypeData:=7;
    NbPlans:=3;
    Getmem(ImgInt,12);
    for k:=1 to 3 do begin
      Getmem(ImgInt^[k],4*FrameHeight);
      for i:=1 to FrameHeight do Getmem(ImgInt^[k]^[i],FrameWidth*2);
    end;
end else begin
    TypeData:=2;
    NbPlans:=1;
    Getmem(ImgInt,4);
    Getmem(ImgInt^[1],4*FrameHeight);
    for i:=1 to FrameHeight do Getmem(ImgInt^[1]^[i],FrameWidth*2);
end;
end;

Procedure FreeWorkImage;
var i,k : integer;
begin
if format=24 then begin
  for k:=1 to 3 do begin
    for i:=1 to FrameHeight do Freemem(ImgInt^[k]^[i],FrameWidth*2);
    Freemem(ImgInt^[k],4*FrameHeight);
  end;
  Freemem(ImgInt,12);
end else begin
  for i:=1 to FrameHeight do Freemem(ImgInt^[1]^[i],FrameWidth*2);
  Freemem(ImgInt^[1],4*FrameHeight);
  Freemem(ImgInt,4);
end;
end;


procedure SwapInt(var x,y:integer);
var tmp:integer;
begin
 tmp:=x;
 x:=y;
 y:=tmp;
end;

procedure CopyImage;
var i,j : integer;
    p : PByteArray;
    r,g,b : integer;
begin
 if format=24 then
  begin
  for i:=1 to FrameHeight do
   begin
    p:=Bitmap.scanline[FrameHeight - i];
    for j:=1 to FrameWidth do
     begin
      b:=P[3*(j-1)];
      g:=P[3*(j-1)+1];
      r:=P[3*(j-1)+2];
      ImgInt^[1]^[i]^[j]:= r;
      ImgInt^[2]^[i]^[j]:= g;
      ImgInt^[3]^[i]^[j]:= b;
     end;
   end;
  end
 else
  begin
   for i:=1 to FrameHeight do
    begin
     p:=Bitmap.scanline[FrameHeight - i];
     for j:=1 to FrameWidth do
      begin
       ImgInt^[1]^[i]^[j]:=P[j-1];
      end;
    end;
  end;
end;

procedure CopyNBImage;
var i,j : integer;
    p : PByteArray;
    value,r,g,b : integer;
    ofs:cardinal;
begin
 if format=24 then
  begin
  for i:=1 to FrameHeight do
   begin
    p:=Bitmap.scanline[FrameHeight - i];
    ofs:=0;
    for j:=1 to FrameWidth do
     begin
      b:=P[ofs];
      g:=P[ofs+1];
      r:=P[ofs+2];
      inc(ofs,3);
      value:=(r * 77 + g * 151 + b * 28) shr 8;
      ImgInt^[1]^[i]^[j]:= value;  //à tester
     end;
   end;
  end
 else
  begin
   for i:=1 to FrameHeight do
    begin
     p:=Bitmap.scanline[FrameHeight - i];
     for j:=1 to FrameWidth do
      begin
       ImgInt^[1]^[i]^[j]:=P[j-1];
      end;
    end;
  end;
end;

procedure Tpop_avi.ButtonConvertClick(Sender: TObject);
var Frame,num : integer;
    nom : string;
    AVIdate : Tdatetime;
    TabImgDouble:PTabImgDouble;
    PlanImg:TTabImgInt;
    PPlanImg:PTabImgInt;
    ImageJPEG:TJPEGImage;
    ext:string[6];
begin
if format=0 then begin
   ShowMessage('Le format de l''AVI n''est pas compatible'); //lang
   exit;
end;
OutFormat:=TPop_Avi(Self).ComboBox1.Itemindex;
if (OutFormat < 0) or (OutFormat > 11) then exit;
PPlanImg:=@PlanImg;
DoAbort := False;
ButtonConvert.Enabled:= False;
ButtonOpen.Enabled := False;
ButtonPlay.Enabled := False;
BitBtn1.Caption:='&Annuler'; //lang
Screen.Cursor := crAppStart;
CreateWorkImage;
AVIdate:=FileDateToDateTime(FileAge(filename));  // date de la derniere frame
try
 progressbar1.Min:=Strtoint(spinedit1.Text);
 num:=Strtoint(index.Text);
 if progressbar1.Min < 1 then progressbar1.Min:=1;
 if num < 1 then num:=1;
except
 progressbar1.Min:=1;
 num:=1;
end;
progressbar1.Max:=StreamInfo.dwLength-1;
progressbar1.Position:=progressbar1.Min;
Processing := true;
try
  OpenAVI(Sender);
  if ErreurAVI <> 0 then
   begin
    if (ErreurAVI <> 255) then CloseAVI(Sender);
    exit;
   end;
  if OutFormat = 11 then
   begin
    ImageJPEG:=TJPEGImage.Create;
    ImageJPEG.CompressionQuality:=Config.JpegQuality;
   end;
  InitImgInfos(ImgInfos);
  imginfos.Min[1]:=0;
  imginfos.Min[2]:=0;
  imginfos.Min[3]:=0;
  imginfos.Max[1]:=255;
  imginfos.Max[2]:=255;
  imginfos.Max[3]:=255;
  imginfos.BinningX:=1;
  imginfos.BinningY:=1;
  imginfos.NbPlans:=NbPlans;
  imginfos.Telescope:=config.Telescope;
  imginfos.Observateur:=config.Observateur;
  imginfos.Observatoire:=config.Observatoire;
  imginfos.Commentaires[1]:='Conversion AVI'; //lang
  imginfos.Commentaires[2]:=filename;
  ImgInfos.Camera:='Webcam'; //nolang
  imginfos.TypeData:=TypeData;
  StreamInfo.dwStart:=progressbar1.Min-1;

  Canvas.Pen.Color:=clWhite;
  Canvas.Pen.Width:=1;
  Canvas.Brush.Style:=bsClear;

  for Frame := StreamInfo.dwStart to StreamInfo.dwLength-1 do
   begin
     if (DoAbort) then Break;
     GetAVIFrame(Frame,Sender);
     imginfos.Sx:=FrameWidth;
     imginfos.Sy:=FrameHeight;
     imginfos.DateTime:=AVIdate - (Delay*(int(StreamInfo.dwLength)-1-Frame)/3600/24)-config.PCMoinsTU/24;
     if ErreurAVI <> 0 then break;
     nom:=config.RepImages+'\'+outEdit1.text;
     ext:=inttostr(num);
     case OutFormat of
      0:
       begin
       //Defaut cf. configuration
        CopyImage;
        SaveImageGenerique(nom + ext,ImgInt,TabImgDouble,imginfos);
       end;
      1:
       begin
        //FITS plan
        if format <> 24 then
         begin
          MessageBox(0,'Choisisser le mode N&B,BMP ou JPEG','Erreur de conversion',MB_ICONEXCLAMATION); //lang
          break;
         end;
        CopyImage;
        ImgInfos.NbPlans:=1;
        ImgInfos.TypeData:=2;
        SaveFits(nom + '_R' + ext + '.fts',ImgInt,TabImgDouble,1,1,imginfos); //nolang
        SaveFits(nom + '_G' + ext + '.fts',ImgInt,TabImgDouble,2,1,imginfos); //nolang
        SaveFits(nom + '_B' + ext + '.fts',ImgInt,TabImgDouble,3,1,imginfos); //nolang
       end;
      2:
       begin
        //FITS couleur
        if format <> 24 then
         begin
          MessageBox(0,'Choisisser le mode N&B,BMP ou JPEG','Erreur de conversion',MB_ICONEXCLAMATION); //lang
          break;
         end;
        CopyImage;
        SaveFits(nom + ext + '.fts',ImgInt,TabImgDouble,1,3,imginfos); //nolang
       end;
      3:
       begin
        //FITS N&B
        CopyNBImage;
        ImgInfos.NbPlans:=1;
        ImgInfos.TypeData:=2;
        SaveFits(nom + ext + '.fts',ImgInt,TabImgDouble,1,1,imginfos); //nolang
       end;
      4:
       begin
        //pic plan;
        if format <> 24 then
         begin
          MessageBox(0,'Choisisser le mode N&B,BMP ou JPEG','Erreur de conversion',MB_ICONEXCLAMATION); //lang
          break;
         end;
        CopyImage;
        ImgInfos.NbPlans:=1;
        ImgInfos.TypeData:=2;
        SavePic(nom + '_R' + ext + '.pic',ImgInt,imginfos); //nolang
        PPlanImg^[1]:=ImgInt^[2];
        SavePic(nom + '_G' + ext + '.pic',PPlanImg,imginfos); //nolang
        PPlanImg^[1]:=ImgInt^[3];
        SavePic(nom + '_B' + ext + '.pic',PPlanImg,imginfos); //nolang
       end;
      5:
       begin
        //pic N&B;
        CopyNBImage;
        PPlanImg^[1]:=ImgInt^[1];
        ImgInfos.NbPlans:=1;
        ImgInfos.TypeData:=2;
        SavePic(nom + ext + '.pic',PPlanImg,imginfos); //nolang
       end;
      6:
       begin
        //CPA v3 plan
        if format <> 24 then
         begin
          MessageBox(0,'Choisisser le mode N&B,BMP ou JPEG','Erreur de conversion',MB_ICONEXCLAMATION); //lang
          break;
         end;
        CopyImage;
        ImgInfos.NbPlans:=1;
        ImgInfos.TypeData:=2;
        SaveCpaV3(nom + '_R' + ext + '.cpa',ImgInt,1,ImgInfos); //nolang
        PPlanImg^[1]:=ImgInt^[2];
        SaveCpaV3(nom + '_G' + ext + '.cpa',PPlanImg,1,ImgInfos); //nolang
        PPlanImg^[1]:=ImgInt^[3];
        SaveCpaV3(nom + '_B' + ext + '.cpa',PPlanImg,1,ImgInfos); //nolang
       end;
      7:
       begin
        //CPA v3 N&B
        CopyNBImage;
        ImgInfos.NbPlans:=1;
        ImgInfos.TypeData:=2;
        SaveCpaV3(nom + ext + '.cpa',ImgInt,1,ImgInfos); //nolang
       end;
      8:
       begin
        //CPA v4 plan
        if format <> 24 then
         begin
          MessageBox(0,'Choisisser le mode N&B,BMP ou JPEG','Erreur de conversion',MB_ICONEXCLAMATION);  //lang
          break;
         end;
        CopyImage;
        ImgInfos.NbPlans:=1;
        ImgInfos.TypeData:=2;
        SaveCpaV4d(Nom + '_R' + ext + '.cpa',ImgInt,1,ImgInfos); //nolang
        PPlanImg^[1]:=ImgInt^[2];
        SaveCpaV4d(Nom + '_G' + ext + '.cpa',PPlanImg,1,ImgInfos); //nolang
        PPlanImg^[1]:=ImgInt^[3];
        SaveCpaV4d(Nom + '_B' + ext + '.cpa',PPlanImg,1,ImgInfos); //nolang
       end;
      9:
       begin
        //CPA v4 N&B
        CopyNBImage;
        ImgInfos.NbPlans:=1;
        ImgInfos.TypeData:=2;
        SaveCpaV4d(Nom + ext + '.cpa',ImgInt,1,ImgInfos); //nolang
       end;
      10:
       begin
        //BMP
        Bitmap.savetofile(nom + ext + '.bmp'); //nolang
       end;
       11:
       begin
        //JPEG
        ImageJPEG.Assign(Bitmap);
        ImageJPEG.SaveToFile(Nom + ext + '.jpg'); //nolang
       end;
     end;
     progressbar1.position:=frame;
     outlabel1.Caption:=inttostr(Frame+1)+' / '+inttostr(StreamInfo.dwLength);  //nolang
     UpdateImage;
     Application.ProcessMessages;
     inc(num);
   end;
finally
  if OutFormat = 11 then ImageJPEG.Free;
  Tpop_avi(Self).Caption:='Conversion AVI';  //lang
  outLabel1.Caption:= inttostr(StreamInfo.dwStart + 1) +' / '+inttostr(StreamInfo.dwLength); //nolang
  progressbar1.position:=0;
  Screen.Cursor := crDefault;
  ButtonConvert.Enabled:= True;
  ButtonOpen.Enabled := True;
  ButtonPlay.Enabled := True;
  BitBtn1.Caption:='&Quitter';  //lang
  FreeWorkImage;
  CloseAVI(Sender);
  Processing := false;
end;
end;

procedure Tpop_avi.OpenAVI(Sender: TObject);
var EFavi:shortstring;
begin
Stream := TMemoryStream.Create;
ErreurAVI:=1;
// Initialize the AVI file library
AVIFileInit;
// Open AVI file for read
if (AVIFileOpen(pFile, PChar(FileName), OF_READ OR OF_SHARE_DENY_WRITE, nil) <> AVIERR_OK) then
  begin
   messagebox(0,'Erreur d''ouverture du fichier AVI','Erreur',$1010);    //lang
   ErreurAVI:=255;
   exit;
  end;
// Open AVI data stream
if (AVIFileGetStream(pFile, pStream, streamtypeVIDEO, 0) <> AVIERR_OK) then
  begin
   messagebox(0,'Erreur d''ouverture du flux AVI','Erreur',$1010);   //lang
   exit;
  end;
// Get stream info
if (AVIStreamInfo(pStream, StreamInfo, sizeof(StreamInfo)) <> AVIERR_OK) then
  begin
   messagebox(0,'Ne peut pas lire les informations du flux AVI','Erreur',$1010);  //lang
   exit;
  end;
move(StreamInfo.fccHandler,fccHandler,4);
fccHandler[4]:=#0;
// Calculate delay/frame
if (StreamInfo.dwRate > 0) then
   Delay := StreamInfo.dwScale / StreamInfo.dwRate
else
   Delay := (integer(StreamInfo.dwScale) / 100)/100;
// Get stream format size
if (AVIStreamReadFormat(pStream, 0, nil, InfoSize) <> AVIERR_OK) then
  begin
   messagebox(0,'Ne peut pas lire la taille du format du flux AVI','Erreur',$1010);  //lang
   exit;
  end;
// Get Bitmap Info
BitmapInfo := nil;
if (InfoSize > 0) then
   GetMem(BitmapInfo, InfoSize);
if BitmapInfo = NIL then exit;
// Get stream format
if (AVIStreamReadFormat(pStream, 0, BitmapInfo, InfoSize) <> AVIERR_OK) then
  begin
   messagebox(0,'Erreur de lecture du format AVI','Erreur',$1010);  //lang
   exit;
  end;
// Begin reading from stream
if (AVIStreamBeginStreaming(pStream, 0, 0, 1000) <> AVIERR_OK) then
  begin
   messagebox(0,'Erreur de lecture du flux AVI','Erreur',$1010);  //lang
   exit;
  end;
// Begin reading frames (in any format)
pGetFrame := AVIStreamGetFrameOpen(pStream, PBitmapInfoHeader(nil)^);
if (pGetFrame = nil) then
  begin
   EFavi:='Décompression AVI ' + fccHandler+ ' impossible' + #0;    //lang
   MessageBox(0,@EFavi[1],'Erreur',$1010);   //lang
   exit;
  end;
 FrameWidth:=BitmapInfo^.bmiHeader.biWidth;
 FrameHeight:=BitmapInfo^.bmiHeader.biHeight;
 ErreurAVI:=0;
end;

Procedure Tpop_avi.GetAVIFrame(Frame:integer;Sender: TObject);
begin
// Lit une image
ErreurAVI:=1;
Bits := AVIStreamGetFrame(pGetFrame, Frame);
if (Bits = nil) then
 begin
  messagebox(0,'Erreur de décompression AVI','Erreur',$1010);  //lang
  exit;
 end;
// Copie la palette
Move(BitmapInfo^.bmiColors, Bits^.bmiColors, (BitmapInfo^.bmiHeader.biClrUsed * sizeof(TRGBQuad)));
FillChar(BitmapFileHeader, sizeof(TBitmapFileHeader), 0);
with BitmapFileHeader do
begin
     bfType := $4D42;
     bfSize := 0;
     bfOffBits := sizeof(TBitmapFileHeader);
     if (Bits^.bmiHeader.biBitCount > 8) then
     begin
          // En-tête sans palette
          if ((Bits^.bmiHeader.biCompression and BI_BITFIELDS) = BI_BITFIELDS) then
             Inc(bfOffBits, 12);
             end else
             // En-tête + palette
             Inc(bfOffBits, sizeof(TRGBQuad) * (1 shl Bits^.bmiHeader.biBitCount));
     end;
     Size := BitmapFileHeader.bfOffBits + Bits.bmiHeader.biSizeImage;
     // DIB -> BMP
     Stream.Clear;
     Stream.Write(BitmapFileheader, sizeof(BitmapFileheader));
     Stream.Write(Bits^, Size+26); // Laisser le 26
     Stream.Position := 0;
     // Charge le bitmap
     Bitmap.LoadFromStream(Stream);
ErreurAVI:=0;
end;

Procedure Tpop_avi.CloseAVI(Sender: TObject);
begin
Stream.Free;
AVIStreamGetFrameClose(pGetFrame);
AVIStreamEndStreaming(pStream);
if (BitmapInfo <> nil) then
   FreeMem(BitmapInfo);
AVIStreamRelease(pStream);
AVIFileRelease(pFile);
AVIFileExit;
end;

procedure Tpop_avi.BitBtn1Click(Sender: TObject);
begin
 if Processing = false then
  begin
   Tpop_avi(Self).close;
  end;  //aucun traitement en cours
 if DoAbort = false then DoAbort:=true;
 if DoStop = false then DoStop:=true;
end;


procedure Tpop_avi.FormShow(Sender: TObject);
begin
 TPop_Avi(Self).ComboBox1.ItemIndex:=0;
 ErreurAVI:=0;
end;

procedure Tpop_avi.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if processing = true then canclose:=false else canclose:=true;
end;

procedure Tpop_avi.SpeedButton1Click(Sender: TObject);
begin
 AuSecours('avihelp.htm');
end;

procedure Tpop_avi.FormResize(Sender: TObject);
begin
 if Tpop_avi(Self).Width < 538 then TPop_Avi(Self).Width:=538;
 if Tpop_avi(Self).Height < 419 then TPop_Avi(Self).Height:=419;
 if bitmap=NIL then exit;
 if bitmap.height < bitmap.width then
  coeff:=(bevel1.ClientHeight - 4 ) / bitmap.height
 else
  coeff:=(bevel1.ClientWidth - 3) / bitmap.width;
 BmpWidth:=round(coeff * bitmap.width);
 BmpHeight:=round(coeff * bitmap.height);
 if processing = false then UpdateImage;
end;

procedure Tpop_avi.FormDestroy(Sender: TObject);
begin
 Bitmap.Free;
end;

begin
 Processing := false;
 OutFormat:=0;
end.
