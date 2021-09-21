unit u_visu;

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

uses u_class, classes, extctrls, Windows, Dialogs, SysUtils;

procedure PalGrise(var Pal:TPal);
function  Contracte(Sxc,Syc,XImage,YImage:Integer;var Sxrc,Syrc:Integer):Double;
procedure Lut(Min,Max:Integer;var LutImg:TLut);
procedure VisuReduit(TabImgInt:PTabImgInt;Largx,Largy:Integer;Mini,Maxi:TSeuils;Image:TImage);
//function  VisuImg(TabImgInt:PTabImgInt;TabImgDouble:PTabImgDouble;TypeData,TypeComplexe:Byte;
//                  LargX,LargY:Integer;Mini,Maxi:TSeuils):HBitMap;
function VisuImgAPI(TabImgInt:PTabImgInt;TabImgDouble:PTabImgDouble;ImgInfos:TImgInfos;
   ZoomFactor:Double;X1,Y1,X2,Y2,SizeX,SizeY:Integer):HBitMap;
//function VisuImgHighLight(TabImgInt:PTabImgInt;TabImgDouble:PTabImgDouble;TypeData,TypeComplexe:Byte;
//   LargX,LargY:Integer;Mini,Maxi:TSeuils;HighLightMin,HighLightMax:Double):HBitMap;
function VisuImgHighLight(TabImgInt:PTabImgInt;TabImgDouble:PTabImgDouble;TypeData,TypeComplexe:Byte;
   Sx,Sy:Integer;Mini,Maxi:TSeuils;HighLightMin,HighLightMax:Double;ZoomFactor:Double;
   X1,Y1,X2,Y2,SizeX,SizeY:Integer):HBitMap;

function  VisuImgSave(TabImgInt:PTabImgInt;
                     TabImgDouble:PTabImgDouble;
                     TypeData,TypeComplexe:Byte;
                     LargX,LargY:Integer;
                     Mini,Maxi:TSeuils):HBitMap;

//procedure VisuInt(TabImgInt:PTabImgInt;Largx,Largy,Mini,Maxi:Integer;Image:TImage);
//function VisuInt(TabImgInt:PTabImgInt;Largx,Largy,Mini,Maxi:Integer):HBitMap;
//procedure VisuReal(TabImgDouble:PTabImgDouble;Largx,Largy,Mini,Maxi:Integer;Image:TImage);
//procedure VisuComplexe(TabImgDouble:PTabImgDouble;TypeComplexe:Byte;Largx,Largy,Mini,Maxi:Integer;Image:TImage);

var
    Pal:TPal;

implementation

uses pu_main;

procedure PalGrise(var Pal:TPal);
Var
i:Byte;
begin
for i:=0 to 255 do
   begin
   Pal[i].Rouge:=i;
   Pal[i].Vert:=i;
   Pal[i].Bleu:=i;
   end;
end;

// Recherche du facteur de contraction de l'image
// Dimensions finales X et Y
function Contracte(Sxc,Syc,XImage,YImage:Integer;var Sxrc,Syrc:Integer):Double;
var
c:Double;
begin
c:=1;
if (Sxc>XImage) or (Syc>YImage) then
   begin
   if (Sxc>XImage) and (Syc<=YImage) then
      c:=XImage/Sxc
   else if (Sxc<=XImage) and (Syc>YImage) then
      c:=YImage/Syc
   else if (Sxc>XImage) and (Syc>YImage) then
      if (XImage/Sxc)>(YImage/Syc) then c:=YImage/Syc
      else c:=XImage/Sxc;
   end;

// Dimensions de l'image réduite
Sxrc:=round(Sxc*c);
Syrc:=round(Syc*c);

Result:=c;
end;

// Creation de la lut pour l'affichage
procedure Lut(Min,Max:Integer;var LutImg:TLut);
var
i:Smallint;
begin
if Max>Min then
   begin
   for i:=-32768 to Min do LutImg[i]:=0;
   for i:=Min+1 to Max do
      LutImg[i]:=Round(255.0*(i-Min)/(Max-Min));
   for i:=Max+1 to 32767 do LutImg[i]:=255;
   end
else if Max<Min then
   begin
   for i:=-32768 to Max do LutImg[i]:=255;
   for i:=Max+1 to Min do
      LutImg[i]:=Round(255.0*(i-Min)/(Max-Min));
   for i:=Min+1 to 32767 do LutImg[i]:=0;
   end
else if Min=Max then
   for i:=-32768 to 32767 do
      LutImg[i]:=0;
end;

// Visualisation reduite de l'image contractee
procedure VisuReduit(TabImgInt:PTabImgInt;Largx,Largy:Integer;Mini,Maxi:TSeuils;Image:TImage);
var
Valeur,i:byte;
IntByte:byte;
j,k,Intensite:smallint;
LargBmp:longint;
MemPicr:PImgInt;
c:Double;
Sxr,Syr:Integer;
Bmph:TbmpHeader;
MemBmp:TMemoryStream;
LutImg:TLut;
Inverse:Boolean;
begin
Inverse:=False;
if Maxi[1]<Mini[1] then Inverse:=True;

MemBmp:=TMemoryStream.Create;

Sxr:=300;
Syr:=200;

c:=Contracte(Largx,Largy,Image.Width,Image.Height,Sxr,Syr);

Getmem(MemPicr,4*Syr);
for i:=1 to Syr do Getmem(MemPicr^[i],Sxr*2);

// Contraction de l'image
for i:=1 to Syr do
   for j:=1 to Sxr do
      MemPicr^[i]^[j]:=TabImgInt^[1]^[Trunc(i/c)]^[Trunc(j/c)];

if Sxr mod 4<>0 then Largbmp:=((Sxr div 4)+1)*4
else Largbmp:=Sxr;
with Bmph do
   begin
   Bftype:=19778;
   Bfsize:=1078+LargBmp*Syr;
   Bfreserved1:=0;
   Bfreserved2:=0;
   Bfoffbits:=1078;
   Bisize:=40;
//   Biwidth:=LargBmp;
   Biwidth:=Sxr;
   Biheight:=Syr;
   Biplanes:=1;
   Bibitcount:=8;
   Bicompression:=0;
   Bisizeimage:=0;
   Bixpelspermeter:=0;
   Biypelspermeter:=0;
   Biclrused:=256;
   Biclrimportant:=0;
   end;
Membmp.Seek(0,0);
Membmp.Write(Bmph,SizeOf(Bmph));
Valeur:=0;
for i:=0 to 255 do
   begin
   MemBmp.Write(Pal[i].Rouge,1);
   MemBmp.Write(Pal[i].Vert,1);
   MemBmp.Write(Pal[i].Bleu,1);
   MemBmp.Write(Valeur,1);
   end;
Lut(Round(Mini[1]),Round(Maxi[1]),LutImg);
for j:=1 to Syr do
   for k:=1 to LargBmp do
      begin
      if k<=Sxr then
         begin
         Intensite:=MemPicr^[j]^[k];
         if Inverse then
            begin
            if (Intensite>Maxi[1]) and (Intensite<Mini[1]) then
                  Intbyte:=LutImg[Intensite]
            else if Intensite<=Maxi[1] then IntByte:=255
            else if Intensite>=Mini[1] then IntByte:=0;
            end
         else
            begin
            if (Intensite>Mini[1]) and (Intensite<Maxi[1]) then
                  Intbyte:=LutImg[Intensite]
            else if Intensite<=Mini[1] then IntByte:=0
            else if Intensite>=Maxi[1] then IntByte:=255;
            end;
         MemBmp.Write(IntByte,1);
         end
      else
         MemBmp.Write(Valeur,1);
      end;
MemBmp.Seek(0,0);
Image.Picture.Bitmap.LoadFromStream(MemBmp);
Image.UpDate;
Image.Stretch:=False;
for i:=1 to Syr do Freemem(MemPicr^[i],Sxr*2);
Freemem(MemPicr,4*Syr);
end;


{function VisuImgAPI(TabImgInt:PTabImgInt;TabImgDouble:PTabImgDouble;TypeData,TypeComplexe:Byte;LargX,LargY:Integer;Mini,Maxi:TSeuils):HBitMap;
type TLigne=array[1..999999] of Byte;
var
BitMapInfo:PBitMapInfo;
HBMPDib:HBitMap;
HandleDC:HDC;

Valeur,IntByte:byte;
j,k,Intensite:smallint;
LargBmp:longint;
LutImg,LutImg1,LutImg2,LutImg3:TLut;

LigByt:^TLigne;
Val,Val1,Val2,Val3:Byte;
Valr,Valr1,Valr2,Valr3:Double;
begin
HandleDC:=0;

// La largeur du Bitmap
LargBmp:=((LargX div 4)+1)*4;

Getmem(LigByt,LargBmp*3);
Getmem(BitMapInfo,Sizeof(BitMapInfo^));

try
with BitMapInfo^.BmiHeader do
 begin
  biSize:=40;
  biWidth:=LargX;
  biHeight:=LargY;
  biPlanes:=1;
  biBitCount:=24;
  biCompression:=Bi_RGB;
  biSizeImage:=0;
  biXPelsPerMeter:=0;
  biYPelsPerMeter:=0;
  biClrUsed:=0;
  biClrImportant:=0;
 end;

HandleDc:=CreateDC('DISPLAY',Nil,Nil,Nil); //nolang
HBMPDib:=CreateDIBitMap(HandleDC,BitMapInfo^.BmiHeader,0,Nil,BitMapInfo^,DIB_RGB_COLORS);

case TypeData of
   2,5,6:Lut(Round(Mini[1]),Round(Maxi[1]),LutImg);
   7,8:begin
     Lut(Round(Mini[1]),Round(Maxi[1]),LutImg1);
     Lut(Round(Mini[2]),Round(Maxi[2]),LutImg2);
     Lut(Round(Mini[3]),Round(Maxi[3]),LutImg3);
     end;
   end;

Valeur:=0;
for j:=1 to Largy do
   begin
   case TypeData of
      2:begin
        for k:=1 to LargX do
           begin
           Val:=LutImg[TabImgInt^[1]^[j]^[k]];
           LigByt^[(k-1)*3+3]:=Pal[Val].Rouge;
           LigByt^[(k-1)*3+2]:=Pal[Val].Vert;
           LigByt^[(k-1)*3+1]:=Pal[Val].Bleu;
           end;
        end;
      5:begin
        for k:=1 to LargX do
           begin
           Valr:=TabImgDouble^[1]^[j]^[k];
           if Valr>32767 then Valr:=32767;
           if Valr<-32768 then Valr:=-32768;
           Val:=LutImg[Round(Valr)];
           LigByt^[(k-1)*3+3]:=Pal[Val].Rouge;
           LigByt^[(k-1)*3+2]:=Pal[Val].Vert;
           LigByt^[(k-1)*3+1]:=Pal[Val].Bleu;
           end;
        end;
      6:begin
        case TypeComplexe of
           1:begin
             for k:=1 to LargX do
                begin
                Valr:=Sqrt(Sqr(TabImgDouble^[1]^[j]^[k])+Sqr(TabImgDouble^[2]^[j]^[k]));
                if Valr>32767 then Valr:=32767;
                if Valr<-32768 then Valr:=-32768;
                Val:=LutImg[Round(Valr)];
                LigByt^[(k-1)*3+3]:=Pal[Val].Rouge;
                LigByt^[(k-1)*3+2]:=Pal[Val].Vert;
                LigByt^[(k-1)*3+1]:=Pal[Val].Bleu;
                end;
             end;
           2:begin
             for k:=1 to LargX do
                begin
                if TabImgDouble^[1]^[j]^[k]<>0 then
                   Valr:=ArcTan(abs((TabImgDouble^[2]^[j]^[k])/(TabImgDouble^[1]^[j]^[k])))
                else
                   Valr:=Pi/2;
                if Valr>32767 then Valr:=32767;
                if Valr<-32768 then Valr:=-32768;
                Val:=LutImg[Round(Valr)];
                LigByt^[(k-1)*3+3]:=Pal[Val].Rouge;
                LigByt^[(k-1)*3+2]:=Pal[Val].Vert;
                LigByt^[(k-1)*3+1]:=Pal[Val].Bleu;
                end;
             end;
           3:begin
             for k:=1 to LargX do
                begin
                Valr:=TabImgDouble^[1]^[j]^[k];
                if Valr>32767 then Valr:=32767;
                if Valr<-32768 then Valr:=-32768;
                Val:=LutImg[Round(Valr)];
                LigByt^[(k-1)*3+3]:=Pal[Val].Rouge;
                LigByt^[(k-1)*3+2]:=Pal[Val].Vert;
                LigByt^[(k-1)*3+1]:=Pal[Val].Bleu;
                end;
             end;
           4:begin
             for k:=1 to LargX do
                begin
                Valr:=TabImgDouble^[2]^[j]^[k];
                if Valr>32767 then Valr:=32767;
                if Valr<-32768 then Valr:=-32768;
                Val:=LutImg[Round(Valr)];
                LigByt^[(k-1)*3+3]:=Pal[Val].Rouge;
                LigByt^[(k-1)*3+2]:=Pal[Val].Vert;
                LigByt^[(k-1)*3+1]:=Pal[Val].Bleu;
                end;
             end;
           end;
        end;
      7:begin
        for k:=1 to LargX do
           begin
           Val1:=LutImg1[TabImgInt^[1]^[j]^[k]];
           Val2:=LutImg2[TabImgInt^[2]^[j]^[k]];
           Val3:=LutImg3[TabImgInt^[3]^[j]^[k]];
           LigByt^[(k-1)*3+3]:=Pal[Val1].Rouge;
           LigByt^[(k-1)*3+2]:=Pal[Val2].Vert;
           LigByt^[(k-1)*3+1]:=Pal[Val3].Bleu;
           end;
        end;
      8:begin
        for k:=1 to LargX do
           begin
           Valr1:=TabImgDouble^[1]^[j]^[k];
           Valr2:=TabImgDouble^[2]^[j]^[k];
           Valr3:=TabImgDouble^[3]^[j]^[k];
           if Valr1>32767 then Valr1:=32767;
           if Valr1<-32768 then Valr1:=-32768;
           if Valr2>32767 then Valr2:=32767;
           if Valr2<-32768 then Valr2:=-32768;
           if Valr3>32767 then Valr3:=32767;
           if Valr3<-32768 then Valr3:=-32768;
           Val1:=LutImg1[Round(Valr1)];
           Val2:=LutImg2[Round(Valr2)];
           Val3:=LutImg3[Round(Valr3)];
           LigByt^[(k-1)*3+3]:=Pal[Val1].Rouge;
           LigByt^[(k-1)*3+2]:=Pal[Val2].Vert;
           LigByt^[(k-1)*3+1]:=Pal[Val3].Bleu;
           end;
        end;
      end;
   SetDIBits(HandleDC,HBMPDib,j-1,1,Pointer(LigByt),BitMapInfo^,DIB_RGB_COLORS);
   end;


finally
DeleteDC(HandleDC);
Freemem(LigByt,LargBmp*3);
Freemem(BitMapInfo,Sizeof(BitMapInfo^));
end;
VisuImgAPI:=HBMPDib;
end;}

{$O-}

// X1,Y1,X2,Y2 Coordonnées déjà zoomées à afficher a l'écran dans
// SizeX,SizeY Taille de de la zone où on doit dessiner l'image dans pop_image
// ZoomFactor : Facteur de zoom
function VisuImgAPI(TabImgInt:PTabImgInt;TabImgDouble:PTabImgDouble;ImgInfos:TImgInfos;
   ZoomFactor:Double;X1,Y1,X2,Y2,SizeX,SizeY:Integer):HBitMap;
type TLigne=array[0..999999] of Byte; // Ligne de premier index 0
var
BitMapInfo:PBitMapInfo;
HBMPDib:HBitMap;
HandleDC:HDC;

Valeur,IntByte:byte;
j,k,Intensite:smallint;
LargBmp:longint;
LutImg,LutImg1,LutImg2,LutImg3:TLut;

LigByt:^TLigne;
Val,Val1,Val2,Val3:Byte;
Valr,Valr1,Valr2,Valr3:Double;
//Newj,Newk:Integer;
Newj,Newk:Int64;
ax,bx,ay,by:Double;
ax1,bx1,ay1,by1:Double;
begin
HandleDC:=0;

// Calcul des coefficients l'image visualisée vers l'image zoomée

// Calcul des coefficients de convertion de l'image zoomée vers
// L'image réelle non zoomée

// C'est ici qu'il faut tenir compte du facteur de zoom !

// Premier exemple dans le coin avec ZoomFactor=2
// 0 -> 1
// SizeX-1 -> SizeX/2
// ax:=(SizeX/ZoomFactor-1)/(SizeX-1);
// bx:=1;
// ay:=(SizeY/ZoomFactor-1)/(SizeY-1);
// by:=1;
// Ca Marche

// Deuxieme exemple avec le coin en X1,Y1 avec ZoomFactor=2
// 0 -> X1/2
// SizeX-1 -> (X1+SizeX)/2
// ax:=(SizeX-1)/ZoomFactor/(SizeX-1);
// bx:=X1/ZoomFactor;
// ay:=(SizeY-1)/ZoomFactor/(SizeY-1);
// by:=Y1/ZoomFactor;
// Marche pas car X1/2 est faux quand X1=1 !
// Le zoom est en fait :
// 1 -> 1
// 2*Sx -> Sx
// Donc si on applique ca a X1/Y1 :
ax1:=(ImgInfos.Sx-1)/(ZoomFactor*ImgInfos.Sx-ZoomFactor);
bx1:=1-ax1;
ay1:=(ImgInfos.Sy-1)/(ZoomFactor*ImgInfos.Sy-ZoomFactor);
by1:=1-ay1;

ax:=(SizeX-1)/ZoomFactor/(SizeX-1);
bx:=ax1*X1+bx1;
ay:=(SizeY-1)/ZoomFactor/(SizeY-1);
by:=ay1*Y1+by1;

// La largeur du Bitmap
//LargBmp:=((LargX div 4)+1)*4;
LargBmp:=((SizeX div 4)+1)*4;

Getmem(LigByt,LargBmp*3);
Getmem(BitMapInfo,Sizeof(BitMapInfo^));

try
with BitMapInfo^.BmiHeader do
 begin
  biSize:=40;
  biWidth:=SizeX;
  biHeight:=SizeY;
  biPlanes:=1;
  biBitCount:=24;
  biCompression:=Bi_RGB;
  biSizeImage:=0;
  biXPelsPerMeter:=0;
  biYPelsPerMeter:=0;
  biClrUsed:=0;
  biClrImportant:=0;
 end;

HandleDc:=CreateDC('DISPLAY',Nil,Nil,Nil); //nolang
HBMPDib:=CreateDIBitMap(HandleDC,BitMapInfo^.BmiHeader,0,Nil,BitMapInfo^,DIB_RGB_COLORS);

case ImgInfos.TypeData of
   2,5,6:Lut(Round(ImgInfos.Min[1]),Round(ImgInfos.Max[1]),LutImg);
   7,8:begin
     Lut(Round(ImgInfos.Min[1]),Round(ImgInfos.Max[1]),LutImg1);
     Lut(Round(ImgInfos.Min[2]),Round(ImgInfos.Max[2]),LutImg2);
     Lut(Round(ImgInfos.Min[3]),Round(ImgInfos.Max[3]),LutImg3);
     end;
   end;

// Affichage pour verification
//pop_main.outLabel2.Caption:=IntToStr(Round(bx))+'/'+IntToStr(Round(by))+'/'+
//   IntToStr(Round(ax*(SizeX-1)+bx))+'/'+IntToStr(Round(ay*(SizeY-1)+by));

Valeur:=0;
for j:=0 to SizeY-1 do
   begin
   Newj:=Trunc(ay*j+by);
   case ImgInfos.TypeData of
      2:begin
        for k:=0 to SizeX-1 do
           begin
           Newk:=Trunc(ax*k+bx);
           Val:=LutImg[TabImgInt^[1]^[Newj]^[Newk]];
           // Ne pas changer l'ordre sinon les palettes de couleurs merdent
           LigByt^[k*3+2]:=Pal[Val].Rouge;
           LigByt^[k*3+1]:=Pal[Val].Vert;
           LigByt^[k*3+3]:=Pal[Val].Bleu;
           end;
        end;
      5:begin
        for k:=0 to SizeX-1 do
           begin
           Newk:=Trunc(ax*k+bx);
           Valr:=TabImgDouble^[1]^[Newj]^[Newk];
//           if Valr>32767 then Valr:=32767;
//           if Valr<-32768 then Valr:=-32768;
//           Val:=LutImg[Round(Valr)];
           if ImgInfos.Max[1]>ImgInfos.Min[1] then
              begin
              if (Valr>=ImgInfos.Min[1]) and (Valr<=ImgInfos.Max[1]) then
                 Val:=Round(255.0*(TabImgDouble^[1]^[Newj]^[Newk]-ImgInfos.Min[1])/(ImgInfos.Max[1]-ImgInfos.Min[1]))
              else if (Valr<ImgInfos.Min[1]) then Val:=0
              else if (Valr>ImgInfos.Max[1]) then Val:=255;
              end
           else if ImgInfos.Max[1]<ImgInfos.Min[1] then
              begin
              if (Valr>ImgInfos.Max[1]) and (Valr<ImgInfos.Min[1]) then
                 Val:=Round(255.0*(TabImgDouble^[1]^[Newj]^[Newk]-ImgInfos.Min[1])/(ImgInfos.Max[1]-ImgInfos.Min[1]))
              else if (Valr<ImgInfos.Max[1]) then Val:=255
              else if (Valr>ImgInfos.Min[1]) then Val:=0;
              end
           else Val:=0;
           // Ne pas changer l'ordre sinon les palettes de couleurs merdent
           LigByt^[k*3+2]:=Pal[Val].Rouge;
           LigByt^[k*3+1]:=Pal[Val].Vert;
           LigByt^[k*3+3]:=Pal[Val].Bleu;
           end;
        end;
      6:begin
        case ImgInfos.TypeComplexe of
           1:begin
             for k:=0 to SizeX-1 do
                begin
                Newk:=Trunc(ax*k+bx);
                Valr:=Sqrt(Sqr(TabImgDouble^[1]^[Newj]^[Newk])+Sqr(TabImgDouble^[2]^[Newj]^[Newk]));
//                if Valr>32767 then Valr:=32767;
//                if Valr<-32768 then Valr:=-32768;
//                Val:=LutImg[Round(Valr)];
                if ImgInfos.Max[1]>ImgInfos.Min[1] then
                   begin
                   if (Valr>=ImgInfos.Min[1]) and (Valr<=ImgInfos.Max[1]) then
                      Val:=Round(255.0*(TabImgDouble^[1]^[Newj]^[Newk]-ImgInfos.Min[1])/(ImgInfos.Max[1]-ImgInfos.Min[1]))
                   else if (Valr<ImgInfos.Min[1]) then Val:=0
                   else if (Valr>ImgInfos.Max[1]) then Val:=255;
                   end
                else if ImgInfos.Max[1]<ImgInfos.Min[1] then
                   begin
                   if (Valr>ImgInfos.Max[1]) and (Valr<ImgInfos.Min[1]) then
                      Val:=Round(255.0*(TabImgDouble^[1]^[Newj]^[Newk]-ImgInfos.Min[1])/(ImgInfos.Max[1]-ImgInfos.Min[1]))
                   else if (Valr<ImgInfos.Max[1]) then Val:=255
                   else if (Valr>ImgInfos.Min[1]) then Val:=0;
                   end
                else Val:=0;
                // Ne pas changer l'ordre sinon les palettes de couleurs merdent
                LigByt^[k*3+2]:=Pal[Val].Rouge;
                LigByt^[k*3+1]:=Pal[Val].Vert;
                LigByt^[k*3+3]:=Pal[Val].Bleu;
                end;
             end;
           2:begin
             for k:=0 to SizeX-1 do
                begin
                Newk:=Trunc(ax*k+bx);
                if TabImgDouble^[1]^[j]^[k]<>0 then
                   Valr:=ArcTan(abs((TabImgDouble^[2]^[Newj]^[Newk])/(TabImgDouble^[1]^[Newj]^[Newk])))
                else
                   Valr:=Pi/2;
//                if Valr>32767 then Valr:=32767;
//                if Valr<-32768 then Valr:=-32768;
//                Val:=LutImg[Round(Valr)];
                if ImgInfos.Max[1]>ImgInfos.Min[1] then
                   begin
                   if (Valr>=ImgInfos.Min[1]) and (Valr<=ImgInfos.Max[1]) then
                      Val:=Round(255.0*(TabImgDouble^[1]^[Newj]^[Newk]-ImgInfos.Min[1])/(ImgInfos.Max[1]-ImgInfos.Min[1]))
                   else if (Valr<ImgInfos.Min[1]) then Val:=0
                   else if (Valr>ImgInfos.Max[1]) then Val:=255;
                   end
                else if ImgInfos.Max[1]<ImgInfos.Min[1] then
                   begin
                   if (Valr>ImgInfos.Max[1]) and (Valr<ImgInfos.Min[1]) then
                      Val:=Round(255.0*(TabImgDouble^[1]^[Newj]^[Newk]-ImgInfos.Min[1])/(ImgInfos.Max[1]-ImgInfos.Min[1]))
                   else if (Valr<ImgInfos.Max[1]) then Val:=255
                   else if (Valr>ImgInfos.Min[1]) then Val:=0;
                   end
                else Val:=0;
                LigByt^[k*3+2]:=Pal[Val].Rouge;
                LigByt^[k*3+1]:=Pal[Val].Vert;
                LigByt^[k*3+3]:=Pal[Val].Bleu;
                end;
             end;
           3:begin
             for k:=0 to SizeX-1 do
                begin
                Newk:=Trunc(ax*k+bx);
                Valr:=TabImgDouble^[1]^[Newj]^[Newk];
//                if Valr>32767 then Valr:=32767;
//                if Valr<-32768 then Valr:=-32768;
//                Val:=LutImg[Round(Valr)];
                if ImgInfos.Max[1]>ImgInfos.Min[1] then
                   begin
                   if (Valr>=ImgInfos.Min[1]) and (Valr<=ImgInfos.Max[1]) then
                      Val:=Round(255.0*(TabImgDouble^[1]^[Newj]^[Newk]-ImgInfos.Min[1])/(ImgInfos.Max[1]-ImgInfos.Min[1]))
                   else if (Valr<ImgInfos.Min[1]) then Val:=0
                   else if (Valr>ImgInfos.Max[1]) then Val:=255;
                   end
                else if ImgInfos.Max[1]<ImgInfos.Min[1] then
                   begin
                   if (Valr>ImgInfos.Max[1]) and (Valr<ImgInfos.Min[1]) then
                      Val:=Round(255.0*(TabImgDouble^[1]^[Newj]^[Newk]-ImgInfos.Min[1])/(ImgInfos.Max[1]-ImgInfos.Min[1]))
                   else if (Valr<ImgInfos.Max[1]) then Val:=255
                   else if (Valr>ImgInfos.Min[1]) then Val:=0;
                   end
                else Val:=0;
                // Ne pas changer l'ordre sinon les palettes de couleurs merdent
                LigByt^[k*3+2]:=Pal[Val].Rouge;
                LigByt^[k*3+1]:=Pal[Val].Vert;
                LigByt^[k*3+3]:=Pal[Val].Bleu;
                end;
             end;
           4:begin
             for k:=0 to SizeX-1 do
                begin
                Newk:=Trunc(ax*k+bx);
                Valr:=TabImgDouble^[2]^[Newj]^[Newk];
//                if Valr>32767 then Valr:=32767;
//                if Valr<-32768 then Valr:=-32768;
//                Val:=LutImg[Round(Valr)];
                if ImgInfos.Max[1]>ImgInfos.Min[1] then
                   begin
                   if (Valr>=ImgInfos.Min[1]) and (Valr<=ImgInfos.Max[1]) then
                      Val:=Round(255.0*(TabImgDouble^[1]^[Newj]^[Newk]-ImgInfos.Min[1])/(ImgInfos.Max[1]-ImgInfos.Min[1]))
                   else if (Valr<ImgInfos.Min[1]) then Val:=0
                   else if (Valr>ImgInfos.Max[1]) then Val:=255;
                   end
                else if ImgInfos.Max[1]<ImgInfos.Min[1] then
                   begin
                   if (Valr>ImgInfos.Max[1]) and (Valr<ImgInfos.Min[1]) then
                      Val:=Round(255.0*(TabImgDouble^[1]^[Newj]^[Newk]-ImgInfos.Min[1])/(ImgInfos.Max[1]-ImgInfos.Min[1]))
                   else if (Valr<ImgInfos.Max[1]) then Val:=255
                   else if (Valr>ImgInfos.Min[1]) then Val:=0;
                   end
                else Val:=0;
                // Ne pas changer l'ordre sinon les palettes de couleurs merdent
                LigByt^[k*3+2]:=Pal[Val].Rouge;
                LigByt^[k*3+1]:=Pal[Val].Vert;
                LigByt^[k*3+3]:=Pal[Val].Bleu;
                end;
             end;
           end;
        end;
      7:begin
        for k:=0 to SizeX-1 do
           begin
           Newk:=Trunc(ax*k+bx);
           Val1:=LutImg1[TabImgInt^[1]^[Newj]^[Newk]];
           Val2:=LutImg2[TabImgInt^[2]^[Newj]^[Newk]];
           Val3:=LutImg3[TabImgInt^[3]^[Newj]^[Newk]];
           // Ne pas changer l'ordre sinon les palettes de couleurs merdent
           LigByt^[k*3+2]:=Pal[Val1].Rouge;
           LigByt^[k*3+1]:=Pal[Val2].Vert;
           LigByt^[k*3+3]:=Pal[Val3].Bleu;
           end;
        end;
      8:begin
        for k:=0 to SizeX-1 do
           begin
           Newk:=Trunc(ax*k+bx);
           Valr1:=TabImgDouble^[1]^[Newj]^[Newk];
           Valr2:=TabImgDouble^[2]^[Newj]^[Newk];
           Valr3:=TabImgDouble^[3]^[Newj]^[Newk];
//           if Valr1>32767 then Valr1:=32767;
//           if Valr1<-32768 then Valr1:=-32768;
//           if Valr2>32767 then Valr2:=32767;
//           if Valr2<-32768 then Valr2:=-32768;
//           if Valr3>32767 then Valr3:=32767;
//           if Valr3<-32768 then Valr3:=-32768;
//           Val1:=LutImg1[Round(Valr1)];
//           Val2:=LutImg2[Round(Valr2)];
//           Val3:=LutImg3[Round(Valr3)];
           if ImgInfos.Max[1]>ImgInfos.Min[1] then
              begin
              if (Valr1>=ImgInfos.Min[1]) and (Valr1<=ImgInfos.Max[1]) then
                 Val1:=Round(255.0*(TabImgDouble^[1]^[Newj]^[Newk]-ImgInfos.Min[1])/(ImgInfos.Max[1]-ImgInfos.Min[1]))
              else if (Valr1<ImgInfos.Min[1]) then Val1:=0
              else if (Valr1>ImgInfos.Max[1]) then Val1:=255;
              end
           else if ImgInfos.Max[1]<ImgInfos.Min[1] then
              begin
              if (Valr1>ImgInfos.Max[1]) and (Valr1<ImgInfos.Min[1]) then
                 Val1:=Round(255.0*(TabImgDouble^[1]^[Newj]^[Newk]-ImgInfos.Min[1])/(ImgInfos.Max[1]-ImgInfos.Min[1]))
              else if (Valr1<ImgInfos.Max[1]) then Val1:=255
              else if (Valr1>ImgInfos.Min[1]) then Val1:=0;
              end
           else Val1:=0;

           if ImgInfos.Max[2]>ImgInfos.Min[2] then
              begin
              if (Valr2>=ImgInfos.Min[2]) and (Valr2<=ImgInfos.Max[2]) then
                 Val2:=Round(255.0*(TabImgDouble^[2]^[Newj]^[Newk]-ImgInfos.Min[2])/(ImgInfos.Max[2]-ImgInfos.Min[2]))
              else if (Valr1<ImgInfos.Min[2]) then Val2:=0
              else if (Valr1>ImgInfos.Max[2]) then Val2:=255;
              end
           else if ImgInfos.Max[2]<ImgInfos.Min[2] then
              begin
              if (Valr2>ImgInfos.Max[2]) and (Valr2<ImgInfos.Min[2]) then
                 Val2:=Round(255.0*(TabImgDouble^[2]^[Newj]^[Newk]-ImgInfos.Min[2])/(ImgInfos.Max[2]-ImgInfos.Min[2]))
              else if (Valr2<ImgInfos.Max[2]) then Val2:=255
              else if (Valr2>ImgInfos.Min[2]) then Val2:=0;
              end
           else Val2:=0;

           if ImgInfos.Max[3]>ImgInfos.Min[3] then
              begin
              if (Valr3>=ImgInfos.Min[3]) and (Valr3<=ImgInfos.Max[3]) then
                 Val3:=Round(255.0*(TabImgDouble^[3]^[Newj]^[Newk]-ImgInfos.Min[3])/(ImgInfos.Max[3]-ImgInfos.Min[3]))
              else if (Valr1<ImgInfos.Min[3]) then Val3:=0
              else if (Valr1>ImgInfos.Max[3]) then Val3:=255;
              end
           else if ImgInfos.Max[3]<ImgInfos.Min[3] then
              begin
              if (Valr3>ImgInfos.Max[3]) and (Valr3<ImgInfos.Min[3]) then
                 Val3:=Round(255.0*(TabImgDouble^[3]^[Newj]^[Newk]-ImgInfos.Min[3])/(ImgInfos.Max[3]-ImgInfos.Min[3]))
              else if (Valr3<ImgInfos.Max[3]) then Val3:=255
              else if (Valr3>ImgInfos.Min[3]) then Val3:=0;
              end
           else Val3:=0;

           // Ne pas changer l'ordre sinon les palettes de couleurs merdent
           LigByt^[k*3+2]:=Pal[Val1].Rouge;
           LigByt^[k*3+1]:=Pal[Val2].Vert;
           LigByt^[k*3+3]:=Pal[Val3].Bleu;
           end;
        end;
      end;
   SetDIBits(HandleDC,HBMPDib,j,1,Pointer(LigByt),BitMapInfo^,DIB_RGB_COLORS);
   end;

finally
DeleteDC(HandleDC);
Freemem(LigByt,LargBmp*3);
Freemem(BitMapInfo,Sizeof(BitMapInfo^));
end;
VisuImgAPI:=HBMPDib;
end;

{$O+}

function VisuImgHighLight(TabImgInt:PTabImgInt;TabImgDouble:PTabImgDouble;TypeData,TypeComplexe:Byte;
   Sx,Sy:Integer;Mini,Maxi:TSeuils;HighLightMin,HighLightMax:Double;ZoomFactor:Double;
   X1,Y1,X2,Y2,SizeX,SizeY:Integer):HBitMap;
//function VisuImgHighLight(TabImgInt:PTabImgInt;TabImgDouble:PTabImgDouble;TypeData,TypeComplexe:Byte;
//   LargX,LargY:Integer;Mini,Maxi:TSeuils;HighLightMin,HighLightMax:Double):HBitMap;
type TLigne=array[1..999999] of Byte;
var
BitMapInfo:PBitMapInfo;
HBMPDib:HBitMap;
HandleDC:HDC;

Valeur,IntByte:byte;
j,k,Intensite:smallint;
LargBmp:longint;
LutImg,LutImg1,LutImg2,LutImg3:TLut;

LigByt:^TLigne;
Vali:SmallInt;
Val,Val1,Val2,Val3:Byte;
Valr,Valr1,Valr2,Valr3:Double;
Newj,Newk:Integer;
ax,bx,ay,by:Double;
ax1,bx1,ay1,by1:Double;
begin
HandleDC:=0;

// Calcul des coefficients l'image visualisée vers l'image zoomée

// Calcul des coefficients de convertion de l'image zoomée vers
// L'image réelle non zoomée

// C'est ici qu'il faut tenir compte du facteur de zoom !

// Premier exemple dans le coin avec ZoomFactor=2
// 0 -> 1
// SizeX-1 -> SizeX/2
// ax:=(SizeX/ZoomFactor-1)/(SizeX-1);
// bx:=1;
// ay:=(SizeY/ZoomFactor-1)/(SizeY-1);
// by:=1;
// Ca Marche

// Deuxieme exemple avec le coin en X1,Y1 avec ZoomFactor=2
// 0 -> X1/2
// SizeX-1 -> (X1+SizeX)/2
// ax:=(SizeX-1)/ZoomFactor/(SizeX-1);
// bx:=X1/ZoomFactor;
// ay:=(SizeY-1)/ZoomFactor/(SizeY-1);
// by:=Y1/ZoomFactor;
// Marche pas car X1/2 est faux quand X1=1 !
// Le zoom est en fait :
// 1 -> 1
// 2*Sx -> Sx
// Donc si on applique ca a X1/Y1 :
ax1:=(Sx-1)/(ZoomFactor*Sx-ZoomFactor);
bx1:=1-ax1;
ay1:=(Sy-1)/(ZoomFactor*Sy-ZoomFactor);
by1:=1-ay1;

ax:=(SizeX-1)/ZoomFactor/(SizeX-1);
bx:=ax1*X1+bx1;
ay:=(SizeY-1)/ZoomFactor/(SizeY-1);
by:=ay1*Y1+by1;

// La largeur du Bitmap
LargBmp:=((SizeX div 4)+1)*4;

Getmem(LigByt,LargBmp*3);
Getmem(BitMapInfo,Sizeof(BitMapInfo^));

try
with BitMapInfo^.BmiHeader do
 begin
  biSize:=40;
  biWidth:=SizeX;
  biHeight:=SizeY;
  biPlanes:=1;
  biBitCount:=24;
  biCompression:=Bi_RGB;
  biSizeImage:=0;
  biXPelsPerMeter:=0;
  biYPelsPerMeter:=0;
  biClrUsed:=0;
  biClrImportant:=0;
 end;

HandleDc:=CreateDC('DISPLAY',Nil,Nil,Nil); //nolang
HBMPDib:=CreateDIBitMap(HandleDC,BitMapInfo^.BmiHeader,0,Nil,BitMapInfo^,DIB_RGB_COLORS);

case TypeData of
   2,5,6:Lut(Round(Mini[1]),Round(Maxi[1]),LutImg);
   7,8:begin
     Lut(Round(Mini[1]),Round(Maxi[1]),LutImg1);
     Lut(Round(Mini[2]),Round(Maxi[2]),LutImg2);
     Lut(Round(Mini[3]),Round(Maxi[3]),LutImg3);
     end;
   end;

Valeur:=0;
for j:=0 to SizeY-1 do
   begin
   Newj:=Trunc(ay*j+by);
   case TypeData of
      2:begin
        for k:=0 to SizeX-1 do
           begin
           Newk:=Trunc(ax*k+bx);
           Vali:=TabImgInt^[1]^[Newj]^[Newk];
           Val:=LutImg[Vali];
           if (Vali<HighLightMin) or (Vali>HighLightMax) then
              begin
              LigByt^[k*3+3]:=Pal[Val].Rouge;
              LigByt^[k*3+2]:=Pal[Val].Vert;
              LigByt^[k*3+1]:=Pal[Val].Bleu;
              end
           else
              begin
              LigByt^[k*3+3]:=255;
              LigByt^[k*3+2]:=0;
              LigByt^[k*3+1]:=0;
              end;
           end;
        end;
      5:begin
        for k:=0 to SizeX-1 do
           begin
           Newk:=Trunc(ax*k+bx);
           Valr:=TabImgDouble^[1]^[Newj]^[Newk];
           if Valr>32767 then Valr:=32767;
           if Valr<-32768 then Valr:=-32768;
           Val:=LutImg[Round(Valr)];
           if (Valr<HighLightMin) or (Valr>HighLightMax) then
              begin
              LigByt^[k*3+2]:=Pal[Val].Rouge;
              LigByt^[k*3+1]:=Pal[Val].Vert;
              LigByt^[k*3+3]:=Pal[Val].Bleu;
              end
           else
              begin
              LigByt^[k*3+2]:=255;
              LigByt^[k*3+1]:=0;
              LigByt^[k*3+3]:=0;
              end;
           end;
        end;
      6:begin
        case TypeComplexe of
           1:begin
             for k:=0 to SizeX-1 do
                begin
                Newk:=Trunc(ax*k+bx);
                Valr:=Sqrt(Sqr(TabImgDouble^[1]^[Newj]^[Newk])+Sqr(TabImgDouble^[2]^[Newj]^[Newk]));
                if Valr>32767 then Valr:=32767;
                if Valr<-32768 then Valr:=-32768;
                Val:=LutImg[Round(Valr)];
                if (Valr<HighLightMin) or (Valr>HighLightMax) then
                   begin
                   LigByt^[k*3+2]:=Pal[Val].Rouge;
                   LigByt^[k*3+1]:=Pal[Val].Vert;
                   LigByt^[k*3+3]:=Pal[Val].Bleu;
                   end
                else
                   begin
                   LigByt^[k*3+2]:=255;
                   LigByt^[k*3+1]:=0;
                   LigByt^[k*3+3]:=0;
                   end;
                end;
             end;
           2:begin
             for k:=0 to SizeX-1 do
                begin
                Newk:=Trunc(ax*k+bx);
                if TabImgDouble^[1]^[j]^[k]<>0 then
                   Valr:=ArcTan(abs((TabImgDouble^[2]^[Newj]^[Newk])/(TabImgDouble^[1]^[Newj]^[Newk])))
                else
                   Valr:=Pi/2;
                if Valr>32767 then Valr:=32767;
                if Valr<-32768 then Valr:=-32768;
                Val:=LutImg[Round(Valr)];
                if (Valr<HighLightMin) or (Valr>HighLightMax) then
                   begin
                   LigByt^[k*3+2]:=Pal[Val].Rouge;
                   LigByt^[k*3+1]:=Pal[Val].Vert;
                   LigByt^[k*3+3]:=Pal[Val].Bleu;
                   end
                else
                   begin
                   LigByt^[k*3+2]:=255;
                   LigByt^[k*3+1]:=0;
                   LigByt^[k*3+3]:=0;
                   end;
                end;
             end;
           3:begin
             for k:=0 to SizeX-1 do
                begin
                Newk:=Trunc(ax*k+bx);
                Valr:=TabImgDouble^[1]^[Newj]^[Newk];
                if Valr>32767 then Valr:=32767;
                if Valr<-32768 then Valr:=-32768;
                Val:=LutImg[Round(Valr)];
                if (Valr<HighLightMin) or (Valr>HighLightMax) then
                   begin
                   LigByt^[k*3+2]:=Pal[Val].Rouge;
                   LigByt^[k*3+1]:=Pal[Val].Vert;
                   LigByt^[k*3+3]:=Pal[Val].Bleu;
                   end
                else
                   begin
                   LigByt^[k*3+2]:=255;
                   LigByt^[k*3+1]:=0;
                   LigByt^[k*3+3]:=0;
                   end;
                end;
             end;
           4:begin
             for k:=0 to SizeX-1 do
                begin
                Newk:=Trunc(ax*k+bx);
                Valr:=TabImgDouble^[2]^[Newj]^[Newk];
                if Valr>32767 then Valr:=32767;
                if Valr<-32768 then Valr:=-32768;
                Val:=LutImg[Round(Valr)];
                if (Valr<HighLightMin) or (Valr>HighLightMax) then
                   begin
                   LigByt^[k*3+2]:=Pal[Val].Rouge;
                   LigByt^[k*3+1]:=Pal[Val].Vert;
                   LigByt^[k*3+3]:=Pal[Val].Bleu;
                   end
                else
                   begin
                   LigByt^[k*3+2]:=255;
                   LigByt^[k*3+1]:=0;
                   LigByt^[k*3+3]:=0;
                   end;
                end;
             end;
           end;
        end;
      7:begin
        for k:=0 to SizeX-1 do
           begin
           Newk:=Trunc(ax*k+bx);
           Val1:=LutImg1[TabImgInt^[1]^[Newj]^[Newk]];
           Val2:=LutImg2[TabImgInt^[2]^[Newj]^[Newk]];
           Val3:=LutImg3[TabImgInt^[3]^[Newj]^[Newk]];
           LigByt^[k*3+2]:=Pal[Val1].Rouge;
           LigByt^[k*3+1]:=Pal[Val2].Vert;
           LigByt^[k*3+3]:=Pal[Val3].Bleu;
           end;
        end;
      8:begin
        for k:=0 to SizeX-1 do
           begin
           Newk:=Trunc(ax*k+bx);
           Valr1:=TabImgDouble^[1]^[Newj]^[Newk];
           Valr2:=TabImgDouble^[2]^[Newj]^[Newk];
           Valr3:=TabImgDouble^[3]^[Newj]^[Newk];
           if Valr1>32767 then Valr1:=32767;
           if Valr1<-32768 then Valr1:=-32768;
           if Valr2>32767 then Valr2:=32767;
           if Valr2<-32768 then Valr2:=-32768;
           if Valr3>32767 then Valr3:=32767;
           if Valr3<-32768 then Valr3:=-32768;
           Val1:=LutImg1[Round(Valr1)];
           Val2:=LutImg2[Round(Valr2)];
           Val3:=LutImg3[Round(Valr3)];
           LigByt^[k*3+2]:=Pal[Val1].Rouge;
           LigByt^[k*3+1]:=Pal[Val2].Vert;
           LigByt^[k*3+3]:=Pal[Val3].Bleu;
           end;
        end;
      end;
   SetDIBits(HandleDC,HBMPDib,j-1,1,Pointer(LigByt),BitMapInfo^,DIB_RGB_COLORS);
   end;


finally
DeleteDC(HandleDC);
Freemem(LigByt,LargBmp*3);
Freemem(BitMapInfo,Sizeof(BitMapInfo^));
end;
VisuImgHighLight:=HBMPDib;
end;


function VisuImgSave(TabImgInt:PTabImgInt;
                     TabImgDouble:PTabImgDouble;
                     TypeData,TypeComplexe:Byte;
                     LargX,LargY:Integer;
                     Mini,Maxi:TSeuils):HBitMap;
type TLigne=array[1..999999] of Byte;
var
BitMapInfo:PBitMapInfo;
HBMPDib:HBitMap;
HandleDC:HDC;

Valeur,IntByte:byte;
j,k,Intensite:smallint;
LargBmp:longint;
LutImg,LutImg1,LutImg2,LutImg3:TLut;

LigByt:^TLigne;
Val,Val1,Val2,Val3:Byte;
Valr:Double;
i:Integer;
begin
HandleDC:=0;

// La largeur du Bitmap
LargBmp:=((LargX div 4)+1)*4;

try
case TypeData of
   2,5,6:begin
     Getmem(LigByt,LargBmp);
     Getmem(BitMapInfo,Sizeof(BitMapInfo^)+4*256);
     with BitMapInfo^.BmiHeader do
        begin
        biSize:=40;
        biWidth:=LargX;
        biHeight:=LargY;
        biPlanes:=1;
        biBitCount:=8;
        biCompression:=Bi_RGB;
        biSizeImage:=0;
        biXPelsPerMeter:=0;
        biYPelsPerMeter:=0;
        biClrUsed:=0;
        biClrImportant:=0;
        end;
     for i:=0 to 255 do
        begin
        BitMapInfo.bmiColors[i].rgbBlue:=Pal[i].Bleu;
        BitMapInfo.bmiColors[i].rgbGreen:=Pal[i].Vert;
        BitMapInfo.bmiColors[i].rgbRed:=Pal[i].Rouge;
        end;
     end;
   7:begin
     Getmem(LigByt,LargBmp*3);
     Getmem(BitMapInfo,Sizeof(BitMapInfo^));
     with BitMapInfo^.BmiHeader do
        begin
        biSize:=40;
        biWidth:=LargX;
        biHeight:=LargY;
        biPlanes:=1;
        biBitCount:=24;
        biCompression:=Bi_RGB;
        biSizeImage:=0;
        biXPelsPerMeter:=0;
        biYPelsPerMeter:=0;
        biClrUsed:=0;
        biClrImportant:=0;
        end;
     end;
   end;

HandleDc:=CreateDC('DISPLAY',Nil,Nil,Nil); //nolang
HBMPDib:=CreateDIBitMap(HandleDC,BitMapInfo^.BmiHeader,0,Nil,BitMapInfo^,DIB_RGB_COLORS);

case TypeData of
   2,5,6:Lut(Round(Mini[1]),Round(Maxi[1]),LutImg);
   7:begin
     Lut(Round(Mini[1]),Round(Maxi[1]),LutImg1);
     Lut(Round(Mini[2]),Round(Maxi[2]),LutImg2);
     Lut(Round(Mini[3]),Round(Maxi[3]),LutImg3);
     end;
   end;

Valeur:=0;
for j:=1 to Largy do
   begin
   case TypeData of
      2:for k:=1 to LargX do LigByt^[k]:=LutImg[TabImgInt^[1]^[j]^[k]];
      5:begin
        for k:=1 to LargX do
           begin
           Valr:=TabImgDouble^[1]^[j]^[k];
           if Valr>32767 then Valr:=32767;
           if Valr<-32768 then Valr:=-32768;
           LigByt^[k]:=LutImg[Round(Valr)];
           end;
        end;
      6:begin
        case TypeComplexe of
           1:begin
             for k:=1 to LargX do
                begin
                Valr:=Sqrt(Sqr(TabImgDouble^[1]^[j]^[k])+Sqr(TabImgDouble^[2]^[j]^[k]));
                if Valr>32767 then Valr:=32767;
                if Valr<-32768 then Valr:=-32768;
                LigByt^[k]:=LutImg[Round(Valr)];
                end;
             end;
           2:begin
             for k:=1 to LargX do
                begin
                if TabImgDouble^[1]^[j]^[k]<>0 then
                   Valr:=ArcTan(abs((TabImgDouble^[2]^[j]^[k])/(TabImgDouble^[1]^[j]^[k])))
                else
                   Valr:=Pi/2;
                if Valr>32767 then Valr:=32767;
                if Valr<-32768 then Valr:=-32768;
                LigByt^[k]:=LutImg[Round(Valr)];
                end;
             end;
           3:begin
             for k:=1 to LargX do
                begin
                Valr:=TabImgDouble^[1]^[j]^[k];
                if Valr>32767 then Valr:=32767;
                if Valr<-32768 then Valr:=-32768;
                LigByt^[k]:=LutImg[Round(Valr)];
                end;
             end;
           4:begin
             for k:=1 to LargX do
                begin
                Valr:=TabImgDouble^[2]^[j]^[k];
                if Valr>32767 then Valr:=32767;
                if Valr<-32768 then Valr:=-32768;
                LigByt^[k]:=LutImg[Round(Valr)];
                end;
             end;
           end;
        end;
      7:begin
        for k:=1 to LargX do
           begin
           Val1:=LutImg1[TabImgInt^[1]^[j]^[k]];
           Val2:=LutImg2[TabImgInt^[2]^[j]^[k]];
           Val3:=LutImg3[TabImgInt^[3]^[j]^[k]];
           LigByt^[(k-1)*3+3]:=Pal[Val1].Rouge;
           LigByt^[(k-1)*3+2]:=Pal[Val2].Vert;
           LigByt^[(k-1)*3+1]:=Pal[Val3].Bleu;
           end;
        end;
      end;
   SetDIBits(HandleDC,HBMPDib,j-1,1,Pointer(LigByt),BitMapInfo^,DIB_RGB_COLORS);
   end;

finally
DeleteDC(HandleDC);
case TypeData of
   2,5,6:begin
         Freemem(LigByt,LargBmp);
         Freemem(BitMapInfo,Sizeof(BitMapInfo^)+4*256);
         end;
   7:begin
     Freemem(LigByt,LargBmp*3);
     Freemem(BitMapInfo,Sizeof(BitMapInfo^));
     end;
   end;
end;
VisuImgSave:=HBMPDib;
end;

end.
