unit u_math;

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

{-------------------------------------------------------------------------------

                              fonctions math
                        code sponsorise par DOLIPRANE

--------------------------------------------------------------------------------}

interface

uses math, sysutils, windows,u_class, u_constants, classes, dialogs, u_filtrage, pu_rapport,
  u_meca, forms, Graphics;

function  GetSigmaSky(ImgDouble:PTabImgDouble;Sx,Sy:Integer):Double;
{matching}
// quicksorts, a remplacer quand l astrometrie fonctionne
function MatchMarty(ListePSF1,ListePSF2:PListePsf;
                    Nb1,Nb2,NbRequested:Integer;
                    var Gagnants:Tlist;
                    Rapport:tpop_rapport):Byte;
// FFT
procedure FFT(var Img:PTabImgDouble;Sx,Sy:Integer);
{Calcul matriciel - SVD}
procedure svbksb(var u:RealArrayMPbyNP;      // back substitution
                 var w:RealArrayNP;
                 var v:RealArrayNPbyNP;
                 m,n:integer;
                 var b:RealArrayMP;
                 var x:RealArrayNP);
procedure svdcmp (var a:realarrayMPbyNP;     // compare
                  m,n:integer;
                  var w:RealArrayNP;
                  var v:RealArrayNPbyNP);
procedure svdfit(var x,y,sig :RealArrayMP;   // LSQ
                 ndata:integer;
                 var a : realArrayNP;
                 ma : integer;
                 var u:RealArrayMPbyNP;
                 var v:RealArrayNPbyNP;
                 var w:RealArrayNP;
                 var chisq:double);
{gauss jordan}
function  Gaussj(var a:DoubleArray;n:Integer;var b:DoubleArray;m:Integer):Boolean;
{LU - LR}
procedure LudCmp(var a:DoubleArray;n:Integer;var Indx:IntegerArrayRow;var d:Double);
procedure Lubksb(var a:DoubleArray;n:Integer;var Indx:IntegerArrayRow;var b:DoubleArray);
{moindre carres}
procedure lfitCste(var y,sig:PLigDouble;
                   ndata:Integer;
                   var a:DoubleArrayRow;
                   var covar:DoubleArray;
                   var chisq:Double);
procedure lfitLin(var x,y,sig:PLigDouble;
                  ndata:Integer;
                  var a:DoubleArrayRow;
                  var covar:DoubleArray;
                  var chisq:Double);
procedure lfitAstro(var x1,x2,y,sig:PLigDouble;
                    ndata:Integer;
                    var a:DoubleArrayRow;
                    var covar:DoubleArray;
                    var chisq:Double;
                    degre:Integer);
function  CalcPolynomeXY(x1,x2:Double;
                        p:DoubleArrayRow;
                        degre:Integer):Double;
procedure QuickSortDouble(A:PLigDouble;iLo,iHi:Integer);
procedure QuickSortInt(A:PLigInt;iLo,iHi:Integer);

function PuissanceDouble(Base,Exposant:Double):Double;

function RandN(var Idum:Longint):Double;

procedure SvdFitAstro(var x1,X2,y,sig:PLigDouble;
                      ndata:Integer;
                      var a:DoubleArrayRow;
                      var u:DoubleArray;
                      var v:DoubleArray;
                      var w:DoubleArrayRow;
                      var Chisq:Double;
                      Degre:Integer);
procedure SvdVarAstro(var v:DoubleArray;
                      var w:DoubleArrayRow;
                      var cvm:DoubleArray;
                      Degre:Integer);

var
  Ran3Ma:Array[1..55] of Single;
  Ran3Inext,Ran3Inextp:Longint;
  GasdevIset:Integer;
  GasdevGset:Double;
  Seed:Longint;

implementation

uses
    catalogues,
    u_general,
    pu_camera,
    u_file_io,
    pu_main,
    u_modelisation,
    u_lang,
    pu_graph;


function Factorielle(n:Integer):Double;
var
   i:Integer;
   j:Double;
begin
if n=0 then Result:=1
else
   begin
   j:=1;
   for i:=1 to n do j:=j*i;
   Result:=j;
   end;
end;

function GetSigmaSky(ImgDouble:PTabImgDouble;Sx,Sy:Integer):Double;
var
i,j:Integer;
Nb:Longint;
Nb2:Double;
Hist:array[-32768..32767] of Longint;
Ecart:Double;
begin
Nb:=Sx*Sy;
for i:=-32768 to 32767 do Hist[i]:=0;
for j:=1 to Sy do
   for i:=1 to Sx do
      inc(Hist[Round(ImgDouble^[1]^[j]^[i])]);
for i:=-32767 to 32767 do Hist[i]:=Hist[i]+Hist[i-1];

// Recherche du sigma du ciel
Nb2:=Nb*0.8413;
for i:=-32768 to 32766 do
   if (Hist[i]<=Nb2) and (Hist[i+1]>=Nb2) then
      if (Hist[i]<>0) and (Hist[i+1]<>0) then
         Ecart:=(Hist[i]*i+Hist[i+1]*(i+1))/(Hist[i]+Hist[i+1])
      else Ecart:=0;

//Nb2:=Nb/2;
//for i:=-32768 to 32767 do
//   if (Hist[i]<=Nb2) and (Hist[i+1]>=Nb2)
//      then Mediane:=i+1;

Result:=Ecart;
end;

procedure LudCmp(var a:DoubleArray;n:Integer;var Indx:IntegerArrayRow;var d:Double);
const
Tiny=1.0e-20;
var
k,j,imax,i:Integer;
Sum,Dum,Big:Double;
vv:DoubleArrayRow;
begin
d:=1.0;
for i:=1 to n do
   begin
   Big:=0;
   for j:=1 to n do if Abs(a[i,j])>Big then Big:=Abs(a[i,j]);
   if Big=0 then raise ErrorMath.Create(lang('Matrice singulière'));
   vv[i]:=1.0/Big;
   end;
for j:=1 to n do
   begin
   for i:=1 to j-1 do
      begin
      Sum:=a[i,j];
      for k:=1 to i-1 do Sum:=Sum-a[i,k]*a[k,j];
      a[i,j]:=Sum;
      end;
   Big:=0.0;
   for i:=j to n do
      begin
      Sum:=a[i,j];
      for k:=1 to j-1 do Sum:=Sum-a[i,k]*a[k,j];
      a[i,j]:=Sum;
      Dum:=vv[i]*Abs(sum);
      if Dum>=Big then
         begin
         Big:=Dum;
         iMax:=i;
         end;
      end;
   if j<>iMax then
      begin
      for k:=1 to n do
         begin
         Dum:=a[iMax,k];
         a[iMax,k]:=a[j,k];
         a[j,k]:=Dum;
         end;
      d:=-d;
      vv[iMax]:=vv[j];
      end;
   indx[j]:=iMax;
   if a[i,j]=0.0 then a[j,j]:=Tiny;
   if j<>n then
      begin
      Dum:=1.0/a[j,j];
      for i:=j+1 to n do a[i,j]:=a[i,j]*Dum;
      end;
   end;
end;

procedure Lubksb(var a:DoubleArray;n:Integer;var Indx:IntegerArrayRow;var b:DoubleArray);
var
j,ip,ii,i:Integer;
Sum:Double;
begin
ii:=0;
for i:=1 to n do
   begin
   ip:=indx[i];
   Sum:=b[ip,1];
   b[ip]:=b[i];
   if ii<>0 then for j:=ii to i-1 do Sum:=Sum-a[i,j]*b[j,1]
   else if Sum<>0.0 then ii:=i;
   b[i,1]:=sum;
   end;
for i:=n downto 1 do
   begin
   Sum:=b[i,1];
   for j:=i+1 to n do Sum:=Sum-a[i,j]*b[j,1];
   b[i,1]:=Sum/a[i,i];
   end;
end;


function Gaussj(var a:DoubleArray; n:Integer; var b:DoubleArray; m:Integer):Boolean;
var
big,dum,pivinv:Double;
i,icol,irow,j,k,l,ll:Integer;
indxc,indxr,ipiv:IntegerArrayRow;
begin
Result:=True;
for j:=1 to n do ipiv[j]:=0;
for i:=1 to n do
   begin
   big:=0;
   for j:=1 to n do
      if ipiv[j]<>1 then
         for k:=1 to n do
            if ipiv[k]=0 then
               if abs(a[j,k])>=big then
                  begin
                  big:=abs(a[j,k]);
                  irow:=j;
                  icol:=k;
                  end
               else if ipiv[k]>1 then raise ErrorMath.Create(lang('Matrice singulière'));
   ipiv[icol]:=ipiv[icol]+1;
   if irow<>icol then
      begin
      for l:=1 to n do
         begin
         dum:=a[irow,l];
         a[irow,l]:=a[icol,l];
         a[icol,l]:=dum;
         end;
      for l:=1 to m do
         begin
         dum:=b[irow,l];
         b[irow,l]:=b[icol,l];
         b[icol,l]:=dum;
         end;
      end;
   indxr[i]:=irow;
   indxc[i]:=icol;
//   if abs(a[icol,icol]<1e-6) then raise ErrorMath.Create(lang('Matrice singulière'));
   if abs(a[icol,icol])<1e-18 then begin Result:=False; Exit; end;
//   if a[icol,icol]=0 then raise ErrorMath.Create(lang('Matrice singulière'));
   pivinv:=1/a[icol,icol];
   a[icol,icol]:=1;
   for l:=1 to n do a[icol,l]:=a[icol,l]*pivinv;
   for l:=1 to m do b[icol,l]:=b[icol,l]*pivinv;
   for ll:=1 to n do
      if ll<>icol then
         begin
         dum:=a[ll,icol];
         a[ll,icol]:=0;
         for l:=1 to n do a[ll,l]:=a[ll,l]-a[icol,l]*dum;
         for l:=1 to m do b[ll,l]:=b[ll,l]-b[icol,l]*dum;
         end;
   end;
for l:=n downto 1 do
   if indxr[l]<>indxc[l] then
      for k:=1 to n do
         begin
         dum:=a[k,indxr[l]];
         a[k,indxr[l]]:=a[k,indxc[l]];
         a[k,indxc[l]]:=dum;
         end;
Result:=True;
end;

// Sx st Sy Multiples de 2
procedure FFT(var Img:PTabImgDouble;Sx,Sy:Integer);
var
a,b:PLigFFT;
n,n1,n2,n3,j,i,jj,ii,l,k,n1m1,n1m3,m:integer;
vr,vi,wr,wi,teta,tr,ti,ur,ui:Single;
Val,Temp:Single;
begin
Getmem(a,8*Sx);
Getmem(b,8*Sx);

try

// Calcul de l'exposant
ii:=1;
m:=0;
repeat
ii:=ii*2;
inc(m);
until (ii>=sx) or (ii>=sy);

for jj:=1 to Sy do
   begin
   Move(Img^[1]^[jj]^,a^,8*Sx);
   Move(Img^[2]^[jj]^,b^,8*Sx);
   n:=round(exp(m*ln(2)));
   n1:=n-1;
   n2:=n div 2;
   j:=1;
   for i:=1 to n1 do
      begin
      if i<j then
         begin
         Temp:=a^[j-1]; a^[j-1]:=a^[i-1]; a^[i-1]:=Temp;
         Temp:=b^[j-1]; b^[j-1]:=b^[i-1]; b^[i-1]:=Temp;
         end;
      l:=n2;
      while l<j do
         begin
         j:=j-l;
         l:=l div 2;
         end;
      j:=j+l
      end;
   n1m1:=n1-1;
   i:=0;
   while i<=n1m1 do
      begin
      tr:=a^[i];
      ti:=b^[i];
      ur:=a^[i+1];
      ui:=b^[i+1];
      a^[i]:=tr+ur;
      b^[i]:=ti+ui;
      a^[i+1]:=tr-ur;
      b^[i+1]:=ti-ui;
      i:=i+2;
      end;
   n1m3:=n1-3;
   i:=0;
   while i<=n1m3 do
      begin
      tr:=a^[i];
      ti:=b^[i];
      ur:=a^[i+2];
      ui:=b^[i+2];
      a^[i]:=tr+ur;
      b^[i]:=ti+ui;
      a^[i+2]:=tr-ur;
      b^[i+2]:=ti-ui;
      tr:=a^[i+1];
      ti:=b^[i+1];
      ur:=a^[i+3];
      ui:=b^[i+3];
      a^[i+1]:=tr+ui;
      b^[i+1]:=ti-ur;
      a^[i+3]:=tr-ui;
      b^[i+3]:=ti+ur;
      i:=i+4;
      end;
   for i:=3 to m do
      begin
      n1:=round(exp((i-1)*ln(2)));
      n2:=round(exp((m-i)*ln(2)));
      for l:=1 to n2 do
         for k:=1 to n1 do
            begin
            n3:=(k-1)+(l-1)*2*n1;
            tr:=a^[n3];
            ti:=b^[n3];
            ur:=a^[n1+n3];
            ui:=b^[n1+n3];
            teta:=2*pi*((k-1)*n2)/n;
            wr:=cos(teta);
            wi:=sin(teta);
            vr:=ur*wr+ui*wi;
            vi:=-ur*wi+ui*wr;
            a^[n3]:=tr+vr;
            b^[n3]:=ti+vi;
            a^[n1+n3]:=tr-vr;
            b^[n1+n3]:=ti-vi;
            end;
         end;
   Move(a^,Img^[1]^[jj]^,8*Sx);
   Move(b^,Img^[2]^[jj]^,8*Sx);
   end;

finally
Freemem(a,8*Sx);
Freemem(b,8*Sx);
end;
end;

procedure func(x:double; var p: RealArrayNP; degre:integer);
{NR p570}
var j:integer;
begin
     p[1]:=1;
     for j:=2 to np do p[j]:=p[j-1]*x;
end;


procedure svdfit(var x,y,sig :RealArrayMP;
                 ndata:integer;
                 var a : realArrayNP;
                 ma : integer;
                 var u:RealArrayMPbyNP;
                 var v:RealArrayNPbyNP;
                 var w:RealArrayNP;
                 var chisq:double);

var
   j,i:integer;
   wmax,tmp,thresh,sum:double;
   b:^RealArrayMP;
   afunc:^RealArrayNP;
begin
     new(b);
     new(afunc);
     for i:=1 to ndata do begin
         func(x[i],afunc^,ma);
         tmp:=1/sig[i];
         for j:=1 to ma do
             u[i,j]:=afunc^[j]*tmp;
         b^[i]:=y[i]*tmp;
     end;
     svdcmp(u,ndata,ma,w,v);
     wmax:=0;
     for j:=1 to ma do
         if w[j] > wmax then wmax:=w[j];
     thresh:=tol*wmax;
     for j:=1 to ma do
         if w[j] < thresh then w[j]:=0;
     svbksb(u,w,v,ndata,ma,b^,a);
     chisq:=0;
     for i:=1 to ndata do begin
         func(x[i],afunc^,ma);
         sum:=0;
         for j:= 1 to ma do
             sum:=sum+a[j]*afunc^[j];
         chisq:=chisq+sqr((y[i]-sum)/sig[i])
     end;
     dispose(afunc);
     dispose(b);
end;

procedure svdcmp (var a:realarrayMPbyNP;
                  m,n:integer;
                  var w:RealArrayNP;
                  var v:RealArrayNPbyNP);
label 1,2,3;
var
nm,l,k,j,jj,its,i,mnmin:integer;
z,x,y,scale,s,h,g,f,c,anorm,toto:double;
rv1:^RealArrayNP;

function max(a,b:double):double;
begin
     if a<b then result:=b else result:=a;
end;

function sign(a,b:double):double;
begin
     if b>=0 then sign:=abs(a) else sign:=-abs(a);
end;

function pythag(a,b:double):double;
var
at,bt:double;
begin
     at:=abs(a);
     bt:=abs(b);
     if at > bt then result:=at*sqrt(1+sqr(bt/at))
        else
     if bt=0 then result:=0 else result:=bt*sqrt(1+sqr(at/bt))
end;

begin
    new(rv1);
    g:=0;
    scale:=0;
    anorm:=0;
    for i:=1 to n do begin
         l:=i+1;
         rv1^[i]:=scale*g;
         g:=0;
         s:=0;
         scale:=0;
         if i<=m then  begin
              for k:=i to m do
                  scale:=scale+abs(a[k,i]);
              if scale <>0 then begin
                   for k := i to m do begin
                        a[k,i]:=a[k,i]/scale;
                        s:=s+a[k,i]*a[k,i]
                   end;
                   f:=a[i,i];
                   g:=-sign(sqrt(s),f);
                   h:=f*g-s;
                   a[i,i]:=f-g;
                   for j:=l to n do begin
                        s:=0;
                        for k:=i to m do
                             s:=s+a[k,i]*a[k,j];
                        f:=s/h;
                        for k:=i to m do
                            a[k,j]:=a[k,j]+f*a[k,i]
                   end;
                   for k:=i to m do
                       a[k,i]:=scale*a[k,i];
                   end
              end;
              w[i]:=scale*g;
              g:=0;
              s:=0;
              scale:=0;
              if (i<=m) and (i<>n) then begin
                 for k:=l to n do
                     scale:=scale+abs(a[i,k]);
                 if scale <> 0 then begin
                    for k:=l to n do begin
                        a[i,k]:=a[i,k]/scale;
                        s:=s+a[i,k]*a[i,k]
                    end;
                    f:=a[i,l];
                    g:=-sign(sqrt(s),f);
                    h:=f*g-s;
                    a[i,l]:=f-g;
                    for k:=l to n do
                        rv1^[k]:=a[i,k]/h;
                    for j:=l to m do begin
                        s:=0;
                        for k:=l to n do
                            s:=s+a[j,k]*a[i,k];
                        for k:=l to n do
                            a[j,k]:=a[j,k]+s*rv1^[k];
                    end;
                    for k:=l to n do
                        a[i,k]:=scale*a[i,k];
                 end
              end;
              toto:=abs(w[i])+abs(rv1^[i]);
              anorm:=max(anorm, toto);
         end;

         for i:=n downto 1 do begin
             if i<n then begin
                if g<>0 then begin
                   for j:=l to n do
                       v[j,i]:=(a[i,j]/a[i,l])/g;
                   for j:=l to n do begin
                       s:=0;
                       for k:=l to n do
                           s:=s+a[i,k]*v[k,j];
                       for k:=l to n do
                           v[k,j]:=v[k,j]+s*v[k,i];
                       end
                   end;
                   for j:=l to n do begin
                       v[i,j]:=0;
                       v[j,i]:=0;
                   end
                end;
                v[i,i]:=1;
                g:=rv1^[i];
                l:=i;
             end;

             if m < n then
                mnmin:=m
             else
                 mnmin:=n;
             for i:=mnmin downto 1 do begin
                 l:=i+1;
                 g:=w[i];
                 for j:=l to n do a[i,j]:=0;
                 if g<>0 then begin
                    g:=1/g;
                    for j:=l to n do begin
                        s:=0;
                        for k:=l to m do
                            s:=s+a[k,i]*a[k,j];
                        f:=(s/a[i,i])*g;
                        for k:=i to m do
                            a[k,j]:=a[k,j]+f*a[k,i]
                    end;
                    for j:= i to m do
                        a[j,i]:=a[j,i]*g;
                 end
                 else
                     for j:=i to m do a[j,i]:=0;
                 a[i,i]:=a[i,i]+1;
             end;

             for k:=n downto 1 do begin
                 for its:=1 to 30 do begin
                     for l:=k downto 1 do begin
                         nm:=l-1;
                         if abs(rv1^[l])+anorm=anorm then goto 2;
                         if nm > 0 then
                            if abs(w[nm])+anorm=anorm then goto 1
                     end;

    1:               c:=0;
                     s:=1;
                     for i:=l to k do begin
                         f:=s*rv1^[i];
                         rv1^[i]:=c*rv1^[i];
                         if abs(f)+anorm=anorm then goto 2;
                         g:=w[i];
                         h:=pythag(f,g);
                         w[i]:=h;
                         h:=1/h;
                         c:=g*h;
                         s:=-(f*h);
                         for j:=1 to m do begin
                             y:=a[j,nm];
                             z:=a[j,i];
                             a[j,nm]:=(y*c)+(z*s);
                             a[j,i]:=-(y*s)+(z*c);
                         end
                     end;

    2:               z:=w[k];
                     if l=k then begin
                        if z < 0 then begin
                           w[k]:=-z;
                           for j:=1 to n do v[j,k]:=-v[j,k];
                        end;
                        goto 3;
                     end;
                     if its = 30 then begin
                        showmessage(lang('Pas de convergence en 30 itérations'));
                        exit;
                     end;
                     x:=w[l];
                     nm:=k-1;
                     y:=w[nm];
                     g:=rv1^[nm];
                     h:=rv1^[k];
                     f:=((y-z)*(y+z)+(g-h)*(g+h))/(2*H*Y);
                     g:=pythag(f,1);
                     f:=((x-z)*(x+z)+(h*((y/f+sign(g,f)))-h))/x;

                     c:=1;
                     s:=1;
                     for j:=l to nm do begin
                         i:=j+1;
                         g:=rv1^[i];
                         y:=w[i];
                         h:=s*g;
                         g:=c*g;
                         z:=pythag(f,h);
                         rv1^[j]:=z;
                         c:=f/z;
                         s:=h/z;
                         f:=(x*c)+(g*s);
                         g:=-(x*s)+(g*c);
                         h:=y*s;
                         y:=y*c;
                         for jj:=1 to n do begin
                             x:=v[jj,j];
                             z:=v[jj,i];
                             v[jj,j]:=(x*c)+(z*s);
                             v[jj,i]:=-(x*s)+(z*c);
                         end;
                         z:=pythag(f,h);
                         w[j]:=z;
                         if z<>0 then begin
                            z:=1/z;
                            c:=f*z;
                            s:=h*z;
                         end;
                         f:=(c*g)+(s*y);
                         x:=-(s*g)+(c*y);
                         for jj:=1 to m do begin
                             y:=a[jj,j];
                             z:=a[jj,i];
                             a[jj,j]:=(y*c)+(z*s);
                             a[jj,i]:=-(y*s)+(z*c);
                         end
                     end;
                     rv1^[l]:=0;
                     rv1^[k]:=f;
                     w[k]:=x;
                 end;
    3:      end;
            dispose(rv1);
end;



procedure svbksb(var u:RealArrayMPbyNP;
                 var w:RealArrayNP;
                 var v:RealArrayNPbyNP;
                 m,n:integer;
                 var b:RealArrayMP;
                 var x:RealArrayNP);
var
jj,j,i:integer;
s:double;
tmp:^RealArrayNP;
begin
     new(tmp);
     for j:=1 to n do begin
         s:=0;
         if w[j]<>0 then begin
            for i := 1 to m do
                s:=s+u[i,j]*b[i];
            s:=s/w[j];
         end;
         tmp^[j]:=s;
     end;
     for j:=1 to n do begin
         s:=0;
         for jj:=1 to n do
             s:=s+v[j,jj]*tmp^[jj];
         x[j]:=s
     end;
     dispose(tmp);
end;

function Puissance(a:Double;b:Integer):Double;
var
Val:Double;
i:Integer;
begin
if b>1 then
   begin
   Val:=a;
   for i:=1 to (b-1) do Val:=Val*a;
   end
else if b=1 then Val:=a
else Val:=1;
Result:=Val;
end;

// Calul des monomes du polynome de passage
procedure CalcMonomesXY(x1,x2:Double;
                        var p:DoubleArrayRow;
                        degre:Integer);
var
i,j,k:Integer;
begin
k:=0;
for i:=0 to degre do
   begin
   for j:=0 to i do
      begin
      inc(k);
      p[k]:=Puissance(x1,i-j)*Puissance(x2,j);
      end;
   end;
end;

// Calul d'un polynome de deux variables
// X1 et X2 : coordonnee
// p : coeeficients du polynome
// degre : degre du polynome
function CalcPolynomeXY(x1,x2:Double;
                        p:DoubleArrayRow;
                        degre:Integer):Double;
var
i,j,k:Integer;
Sum:Double;
begin
k:=0;
Sum:=0;
for i:=0 to degre do
   begin
   for j:=0 to i do
      begin
      inc(k);
      Sum:=Sum+p[k]*Puissance(x1,i-j)*Puissance(x2,j);;
      end;
   end;
Result:=Sum;
end;

// TODO : A reflechir comment integrer les incertitudes sur x1 et x2 !!!!
// x1    : coordonne x d'arrivee
// x2    : coordonne y d'arrivee
// y     : coordonne de depart
// sig   : incertitude sur y
// a     : coefficients du polynome recherche
// covar : matrice de covariance
// chisq : chi2
// degre : degre du polynome recherche
procedure lfitAstro(var x1,x2,y,sig:PLigDouble;
                    ndata:Integer;
                    var a:DoubleArrayRow;
                    var covar:DoubleArray;
                    var chisq:Double;
                    degre:Integer);
var
k,j,i:Integer;
ym,wt,sum,sig2i:Double;
beta:DoubleArray;
afunc:DoubleArrayRow;
ma:integer;
begin
// Recherche des dimensions de la matrice principale
//ma:=1;
//for i:=1 to degre do ma:=ma+i+1;
ma:=0;
for i:=0 to degre do ma:=ma+i+1;

// On initialise la matrice principale et le second terme avec des 0
for j:=1 to ma do
   begin
   for k:=1 to ma do covar[j,k]:=0;
   beta[j,1]:=0;
   end;

// Calcul des coefs
for i:=1 to ndata do
   begin
   CalcMonomesXY(x1^[i],x2^[i],afunc,degre);
   ym:=y^[i];
   sig2i:=1/sqr(sig^[i]);
   for j:=1 to ma do
      begin
      wt:=afunc[j]*sig2i;
      for k:=1 to j do
         covar[j,k]:=covar[j,k]+wt*afunc[k];
      beta[j,1]:=beta[j,1]+ym*wt;
      end;
   end;
if ma>1 then
   for j:=2 to ma do
      for k:=1 to j-1 do covar[k,j]:=covar[j,k];

// Resolution
//function Gaussj(var a:DoubleArray; n:Integer; var b:DoubleArray; m:Integer):Boolean;
gaussj(covar,ma,beta,1);
for j:=1 to ma do a[j]:=beta[j,1];

// Calcul du chi2
chisq:=0;
for i:=1 to ndata  do
   begin
   CalcMonomesXY(x1^[i],x2^[i],afunc,degre);
   sum:=0;
   for j:=1 to ma do
      sum:=sum+a[j]*afunc[j];
   chisq:=chisq+sqr((y^[i]-sum)/sig^[i]);
   end;
end;

//Moindres carrés sur une seule valeur constante
// = moyenne normalement
procedure lfitCste(var y,sig:PLigDouble;
                   ndata:Integer;
                   var a:DoubleArrayRow;
                   var covar:DoubleArray;
                   var chisq:Double);
var
k,j,i:Integer;
ym,wt,sum,sig2i:Double;
beta:DoubleArray;
afunc:DoubleArrayRow;
ma:integer;
begin
// On initialise la matrice principale et le second terme avec des 0
covar[1,1]:=0;
beta[1,1]:=0;

// Calcul des coefs
for i:=1 to ndata do
   begin
   afunc[1]:=1;
   ym:=y^[i];
   sig2i:=1/sqr(sig^[i]);
   wt:=afunc[1]*sig2i;
   covar[1,1]:=covar[1,1]+wt*afunc[1];
   beta[1,1]:=beta[1,1]+ym*wt;
   end;

// Resolution
gaussj(covar,1,beta,1);
a[1]:=beta[1,1];

// Calcul du chi2
chisq:=0;
for i:=1 to ndata  do
   begin
   afunc[1]:=1;
   sum:=0;
   sum:=sum+a[1]*afunc[1];
   chisq:=chisq+sqr((y^[i]-sum)/sig^[i]);
   end;
end;

//Moindres carrés linéaires
procedure lfitLin(var x,y,sig:PLigDouble;
                  ndata:Integer;
                  var a:DoubleArrayRow;
                  var covar:DoubleArray;
                  var chisq:Double);
var
k,j,i:Integer;
ym,wt,sum,sig2i:Double;
beta:DoubleArray;
afunc:DoubleArrayRow;
ma:integer;
begin
// On initialise la matrice principale et le second terme avec des 0
for j:=1 to 2 do
   begin
   for k:=1 to 2 do covar[j,k]:=0;
   beta[j,1]:=0;
   end;

// Calcul des coefs
for i:=1 to ndata do
   begin
   afunc[1]:=1;
   afunc[2]:=x^[i];
   ym:=y^[i];
   sig2i:=1/sqr(sig^[i]);
   for j:=1 to 2 do
      begin
      wt:=afunc[j]*sig2i ;
      for k:=1 to j do
         covar[j,k]:=covar[j,k]+wt*afunc[k];
      beta[j,1]:=beta[j,1]+ym*wt;
      end;
   end;
for j:=2 to 2 do
   for k:=1 to j-1 do covar[k,j]:=covar[j,k];

// Resolution
gaussj(covar,2,beta,1);
for j:=1 to 2 do
   a[j]:=beta[j,1];

// Calcul du chi2
chisq:=0;
for i:=1 to ndata  do
   begin
   afunc[1]:=1;
   afunc[2]:=x^[i];
   sum:=0;
   for j:=1 to 2 do
      sum:=sum+a[j]*afunc[j];
   chisq:=chisq+sqr((y^[i]-sum)/sig^[i]);
   end;
end;

// covsrt tel que dans les NR
procedure covsrt(var covar:DoubleArray;
                 ma:Integer;
                 lista:IntegerArrayRow;
                 mfit:Integer);
var
i,j:Integer;
swap:Double;
begin
for j:=1 to ma-1 do
   for i:=j+1 to ma do covar[i,j]:=0;
for i:=1 to mfit-1 do
   begin
   for j:=i+1 to mfit do
      if lista[j]>lista[i] then
         covar[lista[j],lista[i]]:=covar[i,j]
      else
         covar[lista[i],lista[j]]:=covar[i,j]
   end;
swap:=covar[1,1];
for j:=1 to ma do
   begin
   covar[1,j]:=covar[j,j];
   covar[j,j]:=0;
   end;
covar[lista[1],lista[1]]:=swap;
for j:=2 to mfit do
   covar[lista[j],lista[j]]:=covar[1,j];
for j:=2 to ma do
   for i:=1 to j-1 do
      covar[i,j]:=covar[j,i];
end;

// lfit tel que dans les NR
procedure lfit(var x,y,sig:DoubleArrayRow;
               ndata:Integer;
               var a:DoubleArrayRow;
               ma:integer;
               var lista:IntegerArrayRow;
               mfit:Integer;
               var covar:DoubleArray;
               var chisq:Double);
var
k,kk,j,ihit,i:Integer;
ym,wt,sum,sig2i:Double;
beta:DoubleArray;
afunc:DoubleArrayRow;
begin
kk:=mfit+1;
for j:=1 to ma do
   begin
   ihit:=0;
   for k:=1 to mfit do
      if lista[k]=j then ihit:=ihit+1;
   if ihit=0 then
      begin
      lista[kk]:=j;
      kk:=kk+1;
      end
   else if ihit>1 then exit;
   end;
if kk<>ma+1 then exit;
for j:=1 to mfit do
   begin
   for k:=1 to mfit do covar[j,k]:=0;
   beta[j,1]:=0;
   end;
for i:=1 to ndata do
   begin
//   funcs(x[i],afunc,ma);
   ym:=y[i];
   if mfit<ma then
      for j:=mfit+1 to ma do
         ym:=ym-a[lista[j]]*afunc[lista[j]];
   sig2i:=1/sqr(sig[i]);
   for j:=1 to mfit do
      begin
      wt:=afunc[lista[j]]*sig2i;
      for k:=1 to j do
         covar[j,k]:=covar[j,k]+wt*afunc[lista[k]];
      beta[j,1]:=beta[j,1]+ym*wt;
      end;
   end;
if mfit>1 then
   begin
   for j:=2 to mfit do
      for k:=1 to j-1 do covar[k,j]:=covar[j,k];
   end;
gaussj(covar,mfit,beta,1);
for j:=1 to mfit do
   a[lista[j]]:=beta[j,1];
chisq:=0;
for i:=1 to ndata  do
   begin
//   funcs(x[i],afunc,ma);
   sum:=0;
   for j:=1 to ma do
      sum:=sum+a[j]*afunc[j];
   chisq:=chisq+sqr((y[i]-sum)/sig[i]);
   end;
covsrt(covar,ma,lista,mfit);
end;

procedure QuickSortDouble(A:PLigDouble;iLo,iHi:Integer);
var
Lo,Hi:Integer;
Mid,T:Double;
begin
Lo:=iLo;
Hi:=iHi;
Mid:=A[(Lo+Hi) div 2];
repeat
   while A[Lo]<Mid do Inc(Lo);
   while A[Hi]>Mid do Dec(Hi);
   if Lo<=Hi then
      begin
      T := A[Lo];
      A[Lo] := A[Hi];
      A[Hi] := T;
      Inc(Lo);
      Dec(Hi);
      end;
until Lo > Hi;
if Hi > iLo then QuickSortDouble(A,iLo,Hi);
if Lo < iHi then QuickSortDouble(A,Lo,iHi);
end;

procedure QuickSortInt(A:PLigInt;iLo,iHi:Integer);
var
Lo,Hi:Integer;
Mid,T:SmallInt;
begin
Lo:=iLo;
Hi:=iHi;
Mid:=A[(Lo+Hi) div 2];
repeat
   while A[Lo]<Mid do Inc(Lo);
   while A[Hi]>Mid do Dec(Hi);
   if Lo<=Hi then
      begin
      T := A[Lo];
      A[Lo] := A[Hi];
      A[Hi] := T;
      Inc(Lo);
      Dec(Hi);
      end;
until Lo > Hi;
if Hi > iLo then QuickSortInt(A,iLo,Hi);
if Lo < iHi then QuickSortInt(A,Lo,iHi);
end;

function PuissanceDouble(Base,Exposant:Double):Double;
begin
   if Exposant=0 then Result:=1
   else
      begin
      if Base<0 then raise ErrorMath.Create(lang('Base négative'));
      Result:=Exp(Exposant*Ln(Base))
      end
end;

// Random avec distribution Uniforme ?
function Ran(var Idum:Longint):Double;
const
MBig=4.0e6;
MSeed=1618033.0;
mz=0.0;
Fac=2.5e-7;
var
i,ii,k:Smallint;
mj,mk:Double;
begin
if Idum<0 then
   begin
   mj:=MSeed+Idum;
   if mj>=0.0 then mj:=mj-MBig*Trunc(mj/MBig)
   else mj:=mbig-Abs(mj)+mbig*Trunc(Abs(mj)/MBig);
   Ran3Ma[55]:=mj;
   mk:=1;
   for i:=1 to 54 do
      begin
      ii:=21*i mod 55;
      Ran3Ma[ii]:=mk;
      mk:=mj-mk;
      if mk<mz then mk:=mk+MBig;
      mj:=Ran3Ma[ii];
      end;
   for k:=1 to 4 do
      for i:=1 to 55 do
         begin
         Ran3Ma[i]:=Ran3Ma[i]-Ran3Ma[1+((i+30) mod 55)];
         if Ran3Ma[i]<mz then Ran3Ma[i]:=Ran3Ma[i]+mbig;
         end;
   Ran3Inext:=0;
   Ran3Inextp:=31;
   idum:=1;
   end;
Ran3Inext:=Ran3Inext+1;
if Ran3Inext=56 then Ran3Inext:=1;
Ran3Inextp:=Ran3Inextp+1;
if Ran3Inextp=56 then Ran3Inextp:=1;
mj:=Ran3Ma[Ran3Inext]-Ran3Ma[Ran3Inextp];
if mj<mz then mj:=mj+MBig;
Ran3Ma[Ran3Inext]:=mj;
Ran:=mj*Fac;
end;

// Random avec distribution Gaussienne
function RandN(var Idum:Longint):Double;
var
fac,r,v1,v2:Double;
begin
if GasdevIset=0 then
   begin
   repeat
      v1:=2.0*ran(idum)-1.0;
      v2:=2.0*ran(idum)-1.0;
      r:=sqr(v1)+sqr(v2);
   until (r<1.0) and (r>0.0);
   fac:=sqrt(-2.0*ln(r)/r);
   GasdevGset:=v1*fac;
   RandN:=v2*fac;
   GasdevIset:=1;
   end
else
   begin
   GasdevIset:=0;
   RandN:=GasdevGset;
   end;
end;

procedure SvdCmpAstro(var a:DoubleArray;
                      m,n:Integer;
                      var w:DoubleArrayRow;
                      var v:DoubleArray);
label 1,2,3;
var
   nm,l,k,j,jj,its,i,mnmin:integer;
   z,x,y,scale,s,h,g,f,c,anorm,toto:double;
   rv1:DoubleArrayRow;

function Max(a,b:Double):Double;
begin
   if a<b then Result:=b else Result:=a;
end;

function Sign(a,b:Double):Double;
begin
   if b>=0 then Sign:=Abs(a) else Sign:=-Abs(a);
end;

function Pythag(a,b:Double):Double;
var
   at,bt:Double;
begin
   at:=Abs(a);
   bt:=Abs(b);
   if at > bt then Result:=at*Sqrt(1+Sqr(bt/at))
   else if bt=0 then Result:=0
   else Result:=bt*Sqrt(1+Sqr(at/bt))
end;

begin
   g:=0;
   scale:=0;
   anorm:=0;
   for i:=1 to n do
      begin
      l:=i+1;
      rv1[i]:=scale*g;
      g:=0;
      s:=0;
      scale:=0;
      if i<=m then
         begin
         for k:=i to m do scale:=scale+abs(a[k,i]);
         if scale <>0 then
            begin
            for k := i to m do
               begin
               a[k,i]:=a[k,i]/scale;
               s:=s+a[k,i]*a[k,i]
               end;
            f:=a[i,i];
            g:=-sign(sqrt(s),f);
            h:=f*g-s;
            a[i,i]:=f-g;
            for j:=l to n do
               begin
               s:=0;
               for k:=i to m do s:=s+a[k,i]*a[k,j];
               f:=s/h;
               for k:=i to m do a[k,j]:=a[k,j]+f*a[k,i]
               end;
            for k:=i to m do a[k,i]:=scale*a[k,i];
            end
         end;
      w[i]:=scale*g;
      g:=0;
      s:=0;
      scale:=0;
      if (i<=m) and (i<>n) then
         begin
         for k:=l to n do scale:=scale+abs(a[i,k]);
         if scale <> 0 then
            begin
            for k:=l to n do
               begin
               a[i,k]:=a[i,k]/scale;
               s:=s+a[i,k]*a[i,k]
               end;
            f:=a[i,l];
            g:=-sign(sqrt(s),f);
            h:=f*g-s;
            a[i,l]:=f-g;
            for k:=l to n do rv1[k]:=a[i,k]/h;
            for j:=l to m do
               begin
               s:=0;
               for k:=l to n do s:=s+a[j,k]*a[i,k];
               for k:=l to n do a[j,k]:=a[j,k]+s*rv1[k];
               end;
            for k:=l to n do a[i,k]:=scale*a[i,k];
            end
         end;
         toto:=abs(w[i])+abs(rv1[i]);
         anorm:=max(anorm, toto);
         end;

      for i:=n downto 1 do
         begin
         if i<n then
            begin
            if g<>0 then
               begin
               for j:=l to n do v[j,i]:=(a[i,j]/a[i,l])/g;
               for j:=l to n do
                  begin
                  s:=0;
                  for k:=l to n do s:=s+a[i,k]*v[k,j];
                  for k:=l to n do v[k,j]:=v[k,j]+s*v[k,i];
                  end
               end;
            for j:=l to n do
               begin
               v[i,j]:=0;
               v[j,i]:=0;
               end
            end;
         v[i,i]:=1;
         g:=rv1[i];
         l:=i;
         end;

      if m < n then mnmin:=m else mnmin:=n;
      for i:=mnmin downto 1 do
         begin
         l:=i+1;
         g:=w[i];
         for j:=l to n do a[i,j]:=0;
         if g<>0 then
            begin
            g:=1/g;
            for j:=l to n do
               begin
               s:=0;
               for k:=l to m do s:=s+a[k,i]*a[k,j];
               f:=(s/a[i,i])*g;
               for k:=i to m do a[k,j]:=a[k,j]+f*a[k,i]
               end;
            for j:= i to m do a[j,i]:=a[j,i]*g;
            end
         else
            for j:=i to m do a[j,i]:=0;
         a[i,i]:=a[i,i]+1;
         end;

      for k:=n downto 1 do
         begin
         for its:=1 to 30 do
            begin
            for l:=k downto 1 do
               begin
               nm:=l-1;
               if abs(rv1[l])+anorm=anorm then goto 2;
               if nm > 0 then
                  if abs(w[nm])+anorm=anorm then goto 1
               end;

1:    c:=0;
      s:=1;
      for i:=l to k do
         begin
         f:=s*rv1[i];
         rv1[i]:=c*rv1[i];
         if abs(f)+anorm=anorm then goto 2;
         g:=w[i];
         h:=pythag(f,g);
         w[i]:=h;
         h:=1/h;
         c:=g*h;
         s:=-(f*h);
         for j:=1 to m do
            begin
            y:=a[j,nm];
            z:=a[j,i];
            a[j,nm]:=(y*c)+(z*s);
            a[j,i]:=-(y*s)+(z*c);
            end
         end;
2:    z:=w[k];
      if l=k then
         begin
         if z < 0 then
            begin
            w[k]:=-z;
            for j:=1 to n do v[j,k]:=-v[j,k];
            end;
         goto 3;
         end;
      if its = 30 then
         begin
         ShowMessage(lang('Pas de convergence en 30 itérations'));
         Exit;
         end;
      x:=w[l];
      nm:=k-1;
      y:=w[nm];
      g:=rv1[nm];
      h:=rv1[k];
      f:=((y-z)*(y+z)+(g-h)*(g+h))/(2*h*y);
      g:=pythag(f,1);
      f:=((x-z)*(x+z)+h*((y/(f+sign(g,f)))-h))/x;

      c:=1;
      s:=1;
      for j:=l to nm do
         begin
         i:=j+1;
         g:=rv1[i];
         y:=w[i];
         h:=s*g;
         g:=c*g;
         z:=pythag(f,h);
         rv1[j]:=z;
         c:=f/z;
         s:=h/z;
         f:=(x*c)+(g*s);
         g:=-(x*s)+(g*c);
         h:=y*s;
         y:=y*c;
         for jj:=1 to n do
            begin
            x:=v[jj,j];
            z:=v[jj,i];
            v[jj,j]:=(x*c)+(z*s);
            v[jj,i]:=-(x*s)+(z*c);
            end;
         z:=pythag(f,h);
         w[j]:=z;
         if z<>0 then
            begin
            z:=1/z;
            c:=f*z;
            s:=h*z;
            end;
         f:=(c*g)+(s*y);
         x:=-(s*g)+(c*y);
         for jj:=1 to m do
            begin
            y:=a[jj,j];
            z:=a[jj,i];
            a[jj,j]:=(y*c)+(z*s);
            a[jj,i]:=-(y*s)+(z*c);
            end
         end;
      rv1[l]:=0;
      rv1[k]:=f;
      w[k]:=x;
      end;
3: end;
end;

procedure SvbksbAstro(var u:DoubleArray;
                      var w:DoubleArrayRow;
                      var v:DoubleArray;
                      m,n:Integer;
                      var b:PligDouble;
                      var x:DoubleArrayRow);
var
jj,j,i:integer;
s:double;
tmp:^RealArrayNP;
begin
     new(tmp);
     for j:=1 to n do begin
         s:=0;
         if w[j]<>0 then begin
            for i := 1 to m do
                s:=s+u[i,j]*b^[i];
            s:=s/w[j];
         end;
         tmp^[j]:=s;
     end;
     for j:=1 to n do begin
         s:=0;
         for jj:=1 to n do
             s:=s+v[j,jj]*tmp^[jj];
         x[j]:=s
     end;
     dispose(tmp);
end;

procedure SvdFitAstro(var x1,x2,y,sig:PLigDouble;
                      ndata:Integer;
                      var a:DoubleArrayRow;
                      var u:DoubleArray;
                      var v:DoubleArray;
                      var w:DoubleArrayRow;
                      var Chisq:Double;
                      Degre:Integer);
var
   j,i:integer;
   wmax,tmp,thresh,sum:double;
   b:PLigDouble;
   afunc:DoubleArrayRow;
   ma:Integer;
begin
Getmem(b,8*ndata);
try

// Recherche des dimensions de la matrice principale
ma:=1;
for i:=1 to degre do ma:=ma+i+1;

for i:=1 to ndata do
   begin
   CalcMonomesXY(x1^[i],x2^[i],afunc,Degre);
//   func(x[i],afunc^,ma);
   tmp:=1/sig^[i];
   for j:=1 to ma do
      u[i,j]:=afunc[j]*tmp;
   b^[i]:=y^[i]*tmp;
   end;
SvdCmpAstro(u,ndata,ma,w,v);
wmax:=0;
for j:=1 to ma do
   if w[j]>wmax then wmax:=w[j];
thresh:=tol*wmax;
for j:=1 to ma do
   if w[j] < thresh then w[j]:=0;
SvbksbAstro(u,w,v,ndata,ma,b,a);
chisq:=0;
for i:=1 to ndata do
   begin
   CalcMonomesXY(x1^[i],x2^[i],afunc,degre);
//   func(x[i],afunc^,ma);
   sum:=0;
   for j:= 1 to ma do
      sum:=sum+a[j]*afunc[j];
   chisq:=chisq+sqr((y^[i]-sum)/sig^[i])
   end;

finally
Freemem(b,8*ndata);
end
end;

procedure SvdVarAstro(var v:DoubleArray;
                      var w:DoubleArrayRow;
                      var cvm:DoubleArray;
                      Degre:Integer);
var
   ma,i,j,k:Integer;
   Sum:Double;
   wti:DoubleArrayRow;
begin
// Recherche des dimensions de la matrice principale
ma:=1;
for i:=1 to Degre do ma:=ma+i+1;

for i:=1 to ma do
   begin
   wti[i]:=0;
   if w[i]<>0 then wti[i]:=1/Sqr(w[i]);
   end;

for i:=1 to ma do
   begin
   for j:=1 to i do
      begin
      Sum:=0;
      for k:=1 to ma do
         Sum:=Sum+v[i,k]*v[j,k]*wti[k];
      cvm[i,j]:=Sum;
      cvm[j,i]:=Sum;
      end;
   end;
end;

//************************************************************************************
//************************************************************************************
//************************************************************************************

procedure ClasseParBSurACroissant(ListeTriangles:PListeTriangles;Low,High:Integer);
var
  LO,HI,dicho: Integer;
  Pivot,TempHi,TempLo,Temp:TTriangles;
  ValDicho:double;
begin
repeat
   LO:=Low;
   HI:=High;
   Dicho:=(Low+High) shr 1;
   Pivot:=ListeTriangles[dicho];
   ValDicho:=Pivot.BSurA;
   repeat
      {comparaison gauche}
      TempLo:=ListeTriangles[LO];
      while (TempLo.BSurA<ValDicho) do
         begin
         Inc(LO);
         TempLo:=ListeTriangles[LO];
         end;
      {comparaison droite}
      TempHi:=ListeTriangles[HI];
      while (TempHi.BSurA>ValDicho) do
         begin
         Dec(HI);
         TempHi:=ListeTriangles[HI];
         end;
      if LO<=HI then
      {echange les pointeurs}
         begin
         Temp:=ListeTriangles[LO];
         ListeTriangles[LO]:=ListeTriangles[HI];
         ListeTriangles[HI]:=Temp;
         Inc(LO);
         Dec(HI);
         end;
   until LO>HI;
   if Low<HI then ClasseParBSurACroissant(ListeTriangles,Low,HI);
   Low:=LO;
until LO>=High;
end;

procedure ClasseParFluxCroissant(ListePSF:PListePsf;Low,High:Integer);
var
   LO,HI,Dicho: Integer;
   Pivot,TempHi,TempLo,Temp:TPSF;
   ValDicho:double;
begin
   repeat
   LO:=Low;
   HI:=High;
   Dicho:=(Low+High) shr 1;
   Pivot:=ListePSF[Dicho];
   ValDicho:=Pivot.Flux;
      repeat
      {comparaison gauche}
      TempLo:=ListePSF[LO];
      while (TempLo.Flux>ValDicho) do
         begin
         Inc(LO);
         TempLo:=ListePSF[LO];
         end;
      {comparaison droite}
      TempHi:=ListePSF[HI];
      while (TempHi.Flux<ValDicho) do
         begin
         Dec(HI);
         TempHi:=ListePSF[HI];
         end;
      if LO<=HI then
         {echange les pointeurs}
         begin
         Temp:=ListePSF[LO];
         ListePSF[LO]:=ListePSF[HI];
         ListePSF[HI]:=Temp;
         Inc(LO);
         Dec(HI);
         end;
      until LO > HI;
   if Low<HI then ClasseParFluxCroissant(ListePSF,Low,HI);
   Low:=LO;
   until LO>=High;
end;

procedure CreeTriangle(ListePSF:PListePSF;i,j,k:Integer;ListeTriangles:PListeTriangles;iTriangle:Integer);
var
   ij,jk,ki,a,b,c:Double;
   Ordre1,Ordre2:Integer;
begin
// a>b>c

// On calcule les longueurs des cotes
ij:=Sqrt(Sqr(ListePSF^[i].x-ListePSF^[j].x)+Sqr(ListePSF^[i].y-ListePSF^[j].y));
jk:=Sqrt(Sqr(ListePSF^[j].x-ListePSF^[k].x)+Sqr(ListePSF^[j].y-ListePSF^[k].y));
ki:=Sqrt(Sqr(ListePSF^[k].x-ListePSF^[i].x)+Sqr(ListePSF^[k].y-ListePSF^[i].y));
// On remplie la structure ListeTriangles
if (ij>jk) and (jk>ki) then // ij>jk>ki
   begin
   ListeTriangles^[iTriangle].Etoile1:=j;   // Intersection du plus grand et du moyen
   ListeTriangles^[iTriangle].Etoile2:=k;   // Intersection du plus petit et du moyen
   ListeTriangles^[iTriangle].Etoile3:=i;   // Intersection du plus grand et du plus petit
   ListeTriangles^[iTriangle].BSurA:=jk/ij; // Le moyen / Le plus grand
   ListeTriangles^[iTriangle].CSurA:=ki/ij; // Le plus petit / Le plus grand

   Ordre1:=0;
   Ordre2:=0;
   if (ListePSF^[j].Flux>ListePSF^[k].Flux) then Ordre1:=1;
   if (ListePSF^[k].Flux>ListePSF^[i].Flux) then Ordre2:=1;
   ListeTriangles^[iTriangle].OrdreFlux:=Ordre1*10+Ordre2;
   end
else if (ij>ki) and (ki>jk) then // ij>ki>jk
   begin
   ListeTriangles^[iTriangle].Etoile1:=i;   // Intersection du plus grand et du moyen
   ListeTriangles^[iTriangle].Etoile2:=k;   // Intersection du plus petit et du moyen
   ListeTriangles^[iTriangle].Etoile3:=j;   // Intersection du plus grand et du plus petit
   ListeTriangles^[iTriangle].BSurA:=ki/ij; // Le moyen / Le plus grand
   ListeTriangles^[iTriangle].CSurA:=jk/ij; // Le plus petit / Le plus grand

   Ordre1:=0;
   Ordre2:=0;
   if (ListePSF^[i].Flux>ListePSF^[k].Flux) then Ordre1:=1;
   if (ListePSF^[k].Flux>ListePSF^[j].Flux) then Ordre2:=1;
   ListeTriangles^[iTriangle].OrdreFlux:=Ordre1*10+Ordre2;
   end
else if (jk>ij) and (ij>ki) then // jk>ij>ki
   begin
   ListeTriangles^[iTriangle].Etoile1:=j;   // Intersection du plus grand et du moyen
   ListeTriangles^[iTriangle].Etoile2:=i;   // Intersection du plus petit et du moyen
   ListeTriangles^[iTriangle].Etoile3:=k;   // Intersection du plus grand et du plus petit
   ListeTriangles^[iTriangle].BSurA:=ij/jk; // Le moyen / Le plus grand
   ListeTriangles^[iTriangle].CSurA:=ki/jk; // Le plus petit / Le plus grand

   Ordre1:=0;
   Ordre2:=0;
   if (ListePSF^[j].Flux>ListePSF^[i].Flux) then Ordre1:=1;
   if (ListePSF^[i].Flux>ListePSF^[k].Flux) then Ordre2:=1;
   ListeTriangles^[iTriangle].OrdreFlux:=Ordre1*10+Ordre2;
   end
else if (jk>ki) and (ki>ij) then // jk>ki>ij
   begin
   ListeTriangles^[iTriangle].Etoile1:=k;   // Intersection du plus grand et du moyen
   ListeTriangles^[iTriangle].Etoile2:=i;   // Intersection du plus petit et du moyen
   ListeTriangles^[iTriangle].Etoile3:=j;   // Intersection du plus grand et du plus petit
   ListeTriangles^[iTriangle].BSurA:=ki/jk; // Le moyen / Le plus grand
   ListeTriangles^[iTriangle].CSurA:=ij/jk; // Le plus petit / Le plus grand

   Ordre1:=0;
   Ordre2:=0;
   if (ListePSF^[k].Flux>ListePSF^[i].Flux) then Ordre1:=1;
   if (ListePSF^[i].Flux>ListePSF^[j].Flux) then Ordre2:=1;
   ListeTriangles^[iTriangle].OrdreFlux:=Ordre1*10+Ordre2;
   end
else if (ki>jk) and (jk>ij) then // ki>jk>ij
   begin
   ListeTriangles^[iTriangle].Etoile1:=k;   // Intersection du plus grand et du moyen
   ListeTriangles^[iTriangle].Etoile2:=j;   // Intersection du plus petit et du moyen
   ListeTriangles^[iTriangle].Etoile3:=i;   // Intersection du plus grand et du plus petit
   ListeTriangles^[iTriangle].BSurA:=jk/ki; // Le moyen / Le plus grand
   ListeTriangles^[iTriangle].CSurA:=ij/ki; // Le plus petit / Le plus grand

   Ordre1:=0;
   Ordre2:=0;
   if (ListePSF^[k].Flux>ListePSF^[j].Flux) then Ordre1:=1;
   if (ListePSF^[j].Flux>ListePSF^[i].Flux) then Ordre2:=1;
   ListeTriangles^[iTriangle].OrdreFlux:=Ordre1*10+Ordre2;
   end
else if (ki>jk) and (ij>jk) then // ki>ij>jk
   begin
   ListeTriangles^[iTriangle].Etoile1:=i;   // Intersection du plus grand et du moyen
   ListeTriangles^[iTriangle].Etoile2:=j;   // Intersection du plus petit et du moyen
   ListeTriangles^[iTriangle].Etoile3:=k;   // Intersection du plus grand et du plus petit
   ListeTriangles^[iTriangle].BSurA:=ij/ki; // Le moyen / Le plus grand
   ListeTriangles^[iTriangle].CSurA:=jk/ki; // Le plus petit / Le plus grand

   Ordre1:=0;
   Ordre2:=0;
   if (ListePSF^[i].Flux>ListePSF^[j].Flux) then Ordre1:=1;
   if (ListePSF^[j].Flux>ListePSF^[k].Flux) then Ordre2:=1;
   ListeTriangles^[iTriangle].OrdreFlux:=Ordre1*10+Ordre2;
   end;
end;

function MatchMarty(ListePSF1,ListePSF2:PListePsf;
                    Nb1,Nb2,NbRequested:Integer;
                    var Gagnants:Tlist;
                    Rapport:tpop_rapport):Byte;
var
   Nb1a,Nb2a,NbTriangles1,NbTriangles2:Integer;
   i,j,k:Integer;
   ListeTriangles1,ListeTriangles2:PListeTriangles;
   iTriangle:Integer;

   MatriceDeVote:PImgDouble;
   Line:string;

   Max,Moy,Ecart,Valeur,Dx:Double;
   Nb,PosMax:Integer;
   p:p_matcher;

   Delta,BSurAMin,BSurAMax,CSurAMin,CSurAMax,Mult:Double;
   JMin:Integer;
   m:p_matcher;                                 // pointeur sur un element de vote
begin
// Classer les listes par flux croissant
ClasseParFluxCroissant(ListePSF1,1,Nb1);
ClasseParFluxCroissant(ListePSF2,1,Nb2);

// Visu du tri
{Rapport.AddLine('Nb d''étoiles dans ListePSF1 : '+IntToStr(Nb1));
Rapport.AddLine('Nb d''étoiles dans ListePSF2 : '+IntToStr(Nb2));
Rapport.AddLine('Nb max d''étoiles à matcher : '+IntToStr(NbRequested));
Rapport.AddLine(' ');
Rapport.AddLine('Liste des étoiles dans ListePSF1');
Rapport.AddLine(lang('Numero X     DX    Y     DY      Sigma    Flux     DFlux'));
for i:=1 to Nb1 do
      Rapport.AddLine(Format('%6d %6.2f %4.2f %6.2f %4.2f %4.2f %9.0f %4.2f',[i,ListePSF1^[i].X, //nolang
         ListePSF1^[i].DX,ListePSF1^[i].Y,ListePSF1^[i].DY,ListePSF1^[i].Sigma,
         ListePSF1^[i].Flux,ListePSF1^[i].DFlux]));
Rapport.AddLine(' ');
Rapport.AddLine('Liste des étoiles dans ListePSF1');
Rapport.AddLine(lang('Numero X     DX    Y     DY      Sigma    Flux     DFlux'));
for i:=1 to Nb2 do
      Rapport.AddLine(Format('%6d %6.2f %4.2f %6.2f %4.2f %4.2f %9.0f %4.2f',[i,ListePSF2^[i].X, //nolang
         ListePSF2^[i].DX,ListePSF2^[i].Y,ListePSF2^[i].DY,ListePSF2^[i].Sigma,
         ListePSF2^[i].Flux,ListePSF2^[i].DFlux]));
Rapport.AddLine(' ');}

// On limite les listes
if Nb1>NbRequested then Nb1a:=NbRequested else Nb1a:=Nb1;
if Nb2>NbRequested then Nb2a:=NbRequested else Nb2a:=Nb2;

Rapport.AddLine('Nb d''étoiles à matcher dans ListePSF1 : '+IntToStr(Nb1a));
Rapport.AddLine('Nb d''étoiles à matcher dans ListePSF2 : '+IntToStr(Nb2a));
Rapport.AddLine(' ');

// Affichage des listes
Rapport.AddLine('Liste A d''étoiles');
Rapport.AddLine(' ');
Rapport.AddLine('Num.     X       Y'); //nolang
for i:=1 to Nb1a do
   Rapport.AddLine(Format('%3d   %8.3f   %8.3f',[i,ListePSF1^[i].X,ListePSF1^[i].Y])); //nolang
Rapport.AddLine(' ');

Rapport.AddLine('Liste B d''étoiles');
Rapport.AddLine(' ');
Rapport.AddLine('Num.     X       Y'); //nolang
for i:=1 to Nb2a do
   Rapport.AddLine(Format('%3d   %8.3f   %8.3f',[i,ListePSF2^[i].X,ListePSF2^[i].Y])); //nolang
Rapport.AddLine(' ');

// Generer les triangles
NbTriangles1:=Round(Factorielle(Nb1a)/Factorielle(Nb1a-3)/6);
GetMem(ListeTriangles1,NbTriangles1*SizeOf(TTriangles));
try
iTriangle:=0;
for i:=1 to Nb1a-2 do
   for j:=i+1 to Nb1a-1 do
      for k:=j+1 to Nb1a do
         begin
         Inc(iTriangle);
         CreeTriangle(ListePSF1,i,j,k,ListeTriangles1,iTriangle);
         end;

NbTriangles2:=Round(Factorielle(Nb2a)/Factorielle(Nb2a-3)/6);
GetMem(ListeTriangles2,NbTriangles2*SizeOf(TTriangles));
try
iTriangle:=0;
for i:=1 to Nb2a-2 do
   for j:=i+1 to Nb2a-1 do
      for k:=j+1 to Nb2a do
         begin
         Inc(iTriangle);
         CreeTriangle(ListePSF2,i,j,k,ListeTriangles2,iTriangle);
         end;

// Visualisation des triangles
{Rapport.AddLine('Liste A de triangles');
Rapport.AddLine(' ');
Rapport.AddLine('Num.   Etoile1   Etoile2   Etoile3    BSurA     CSurA    OrdreFlux'); //nolang
for i:=1 to NbTriangles1 do
   begin
   Rapport.AddLine(Format('%3d   %8d   %8d   %8d   %8.3f   %8.3f   %8d',[i,ListeTriangles1^[i].Etoile1,
      ListeTriangles1^[i].Etoile2,ListeTriangles1^[i].Etoile3,ListeTriangles1^[i].BSurA,
      ListeTriangles1^[i].CSurA,ListeTriangles1^[i].OrdreFlux])); //nolang
   end;
Rapport.AddLine(' ');

Rapport.AddLine('Liste B de triangles');
Rapport.AddLine(' ');
Rapport.AddLine('Num.   Etoile1   Etoile2   Etoile3    BSurA     CSurA    OrdreFlux'); //nolang
for i:=1 to NbTriangles2 do
   begin
   Rapport.AddLine(Format('%3d   %8d   %8d   %8d   %8.3f   %8.3f   %8d',[i,ListeTriangles2^[i].Etoile1,
      ListeTriangles2^[i].Etoile2,ListeTriangles2^[i].Etoile3,ListeTriangles2^[i].BSurA,
      ListeTriangles2^[i].CSurA,ListeTriangles2^[i].OrdreFlux])); //nolang
   end;
Rapport.AddLine(' ');}

Rapport.AddLine(lang('Nb de triangles dans Liste 1 : ')+IntToStr(NbTriangles1));
Rapport.AddLine(lang('Nb de triangles dans Liste 2 : ')+IntToStr(NbTriangles2));
Rapport.AddLine(' ');

// Classer les triangles pour aller plus vite sur les votes
ClasseParBSurACroissant(ListeTriangles1,1,NbTriangles1);
ClasseParBSurACroissant(ListeTriangles2,1,NbTriangles2);

// Allocation matrice de vote
Getmem(MatriceDeVote,Nb1a*4);
for i:=1 to Nb1a do
   begin
   Getmem(MatriceDeVote^[i],Nb2a*8);
   FillChar(MatriceDeVote^[i]^,Nb2a*8,0);
   end;

try

// Voter
Delta:=0.0005;
JMin:=1;
for i:=1 to NbTriangles1 do
   begin
   BSurAMin:=ListeTriangles1^[i].BSurA-Delta;
   BSurAMax:=ListeTriangles1^[i].BSurA+Delta;
   CSurAMin:=ListeTriangles1^[i].CSurA-Delta;
   CSurAMax:=ListeTriangles1^[i].CSurA+Delta;

   j:=JMin;
   while (ListeTriangles2^[j].BSurA<BSurAMin) and (j<NbTriangles2) do Inc(j);
   JMin:=j;

   while (ListeTriangles2^[j].BSurA<BSurAMax) and (j<=NbTriangles2) do
      begin
//      if (Abs(ListeTriangles1^[i].CSurA-ListeTriangles2^[j].CSurA)<Delta) then
      if (ListeTriangles2^[j].CSurA>=CSurAMin) and
         (ListeTriangles2^[j].CSurA<=CSurAMax) and
         (ListeTriangles2^[j].OrdreFlux=ListeTriangles1^[i].OrdreFlux) then
         begin
         MatriceDeVote^[ListeTriangles1^[i].Etoile1]^[ListeTriangles2^[j].Etoile1]:=
            MatriceDeVote^[ListeTriangles1^[i].Etoile1]^[ListeTriangles2^[j].Etoile1]+1;
         MatriceDeVote^[ListeTriangles1^[i].Etoile2]^[ListeTriangles2^[j].Etoile2]:=
            MatriceDeVote^[ListeTriangles1^[i].Etoile2]^[ListeTriangles2^[j].Etoile2]+1;
         MatriceDeVote^[ListeTriangles1^[i].Etoile3]^[ListeTriangles2^[j].Etoile3]:=
            MatriceDeVote^[ListeTriangles1^[i].Etoile3]^[ListeTriangles2^[j].Etoile3]+1;
         end;

      inc(j);
      end;

   end;

// Visu Matrice de vote
Line:='';
for i:=1 to Nb2a do Line:=Line+IntToStr(i)+'  '; //nolang
Rapport.AddLine(Line);
for i:=1 to Nb1a do
   begin
   Line:=IntToStr(i)+'  '; //nolang
   for j:=1 to Nb2a do Line:=Line+MyFloatToStr(MatriceDeVote^[i]^[j],0)+'  '; //nolang
   Rapport.AddLine(Line);
   end;

// On determine les gagnants
Gagnants:=TList.Create;
for i:=1 to Nb1a do
   begin
   // Determination de la moyenne, Max et l'ecart type sur une ligne
   Max:=MinDouble;
   Moy:=0;
   Ecart:=0;
   Nb:=0;
   for j:=1 to Nb2a do
      begin
      Valeur:=MatriceDeVote^[i]^[j];
      if Valeur>Max then
         begin
         Max:=Valeur;
         PosMax:=j;
         end;
      inc(Nb);
      Dx:=Valeur-Moy;
      Moy:=Moy+Dx/Nb;
      Ecart:=Ecart+Dx*(Valeur-Moy);
      end;
   Ecart:=Sqrt(Ecart/Nb);

   // Attention avec peu d'étoiles
   // Le maxi pour un vote est Nb1a donc il faut pas multiplier l'ecart type
   // par plus que :
   Mult:=5;
   if Ecart<>0 then
      if Mult>((Nb2a-1)-moy)/Ecart then Mult:=((Nb2a-1)-moy)/Ecart/2;

   // Les gagnants sont toujours tres au dessus des autres
   if MatriceDeVote^[i]^[PosMax]>(Moy+Mult*Ecart) then
      begin
      New(p);
      p.vote_count:=Round(Max);
      p.ref_index:=i;      // A
      p.ref_x:=ListePSF1^[i].X;
      p.ref_dx:=ListePSF1^[i].DX;
      p.ref_y:=ListePSF1^[i].Y;
      p.ref_dy:=ListePSF1^[i].DY;
      p.det_index:=PosMax;  // B
      p.det_x:=ListePSF2^[PosMax].X;
      p.det_dx:=ListePSF2^[PosMax].DX;
      p.det_y:=ListePSF2^[PosMax].Y;
      p.det_dy:=ListePSF2^[PosMax].DX;
      Gagnants.add(p);
//      Rapport.AddLine(IntToStr(i)+'/'+IntToStr(PosMax)+'/'+MyFloatToStr(MatriceDeVote^[i]^[PosMax],0));
      end;

   end;

Rapport.AddLine(IntToStr(Gagnants.Count)+lang(' étoiles en correspondance'));
Rapport.AddLine(' ');

Rapport.AddLine('            Image     /          Catalogue        '); //nolang
Rapport.AddLine('Num.     X       Y    / Num.     X        Y       '); //nolang
for i:=0 to Gagnants.Count-1 do
   begin
   m:=Gagnants[i];
   Rapport.AddLine(Format('%3d %8.3f %8.3f / %3d %8.3f %8.3f',[m.ref_index,m.ref_x,m.ref_y,m.det_index,m.det_x,m.det_y])); //nolang
   end;

finally
for i:=1 to Nb1a do Freemem(MatriceDeVote^[i],Nb2a*8);
Freemem(MatriceDeVote,Nb1a*4);
end;

finally
FreeMem(ListeTriangles2,NbTriangles2*SizeOf(TTriangles));
end;
finally
FreeMem(ListeTriangles1,NbTriangles1*SizeOf(TTriangles));
end;

end;

begin
{ On initialise le generateur aleatoire }
GasdevIset:=0;
Seed:=-1;
RandN(Seed);
end.


