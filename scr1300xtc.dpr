library scr1300xtc;

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

{
 DLL pour le pilotage de la cam�ra SCR1310XTC sur port parall�le
 NE GERE PAS LES CAMERAS SUR PORT USB
 Code initial en C de synonyme www.synocom.net

 IMPORTANT : Code exp�rimental et non garanti (pour toutes les unit�s)

 NE PAS TESTER SOUS LINUX

 POUR ACQUISITION , modifier si n�cessaire le d�lai d'attente dans HWDelay ou la
 proc�dure FindDelay
}

{$IFDEF MSWINDOWS}
 uses Windows;
{$ENDIF}
{$IFDEF LINUX}
 uses Libc;
{$ENDIF}

const EPPRead=1;
      NorRead=0;

var
{d�sactive ou non les interruptions}
 EnableCliSti:boolean;
{adresses du port parall�le}
 Port , Portc, Porte, eppdata, ecr:word;
{mode de lecture du port : EPP , normal}
 PortReadOpt:byte;
{d�lai hardware pour calcul int�gration,lecture,...}
 HWDelay   : integer;
{largeur et hauteur de l'image}
 nbx,nby:integer;
{binning 1,2,4,8}
 binning:integer;
{Option du gain}
 GainOpt:integer;
{Permet de stopper la lecture en cours de route
 mais apr�s lecture de toute une ligne}
 ReadAbort : boolean;


function mclk(nb:integer):integer;stdcall;assembler;
asm
 pushad
 mov ecx,nb
 mov dx,Portc
@Loop_mclk:
 in al,dx
 or al,2
 out dx,al
 nop
 nop
 nop
 xor al,2  {00000010b}
 out dx,al
 dec ecx
 jnz @Loop_mclk
 popad
 xor eax,eax
end;

function GetMilliSeconds(day,hour,min,sec,milli:word):integer;
begin
 result:=Day * 86400000 + hour * 3600000 + min * 60000 + sec * 1000 + milli;
end;

function FindDelay:integer;cdecl;      // s'assurer que les millisecondes sont prises en compte
var i,j:integer;first,second:TSystemTime;delai:integer; //long
begin
 result:=0;
 if Portc < $278 then exit;
 Getsystemtime(first);
 // horloge mclk pour 1 ere image
 for i:=1 to 250 do
  begin
   for j:=1 to 400 do
    begin
     mclk(100);
    end;
   end;
 Getsystemtime(second);
{Pr�venir un changement de jour}
 if second.wDay < first.wDay then second.wDay:=first.wDay + 1;
 delai:=GetMilliSeconds(second.wDay,second.wHour,second.wMinute,second.wSecond,second.wMilliseconds) -
        GetMilliSeconds(first.wDay,first.wHour,first.wMinute,first.wSecond,first.wMilliseconds);
 result:=round((delai * 4096) / 1500);
end;

procedure AbortReading;cdecl;
begin
 ReadAbort:=true;
end;

function InitPort:integer;cdecl;
{$IFDEF LINUX}
 var _from,turn_on:integer;
{$ENDIF}
begin
// result:=-1;
 Porte:=Port+1;
 Portc:=Port+2;
 eppdata:=Port+4; //add=$37C
 ecr:=Port+$402;
try
{$IFDEF LINUX}
if ioperm(_from,porte,turn_on) < 0 then
  begin
   exit;
  end;
{$ENDIF}
// port para en lecture
// mode ibm
 asm
  mov dx,ecr
  mov al,$20
  out dx,al	 //ecp = ps2
  mov dx,Portc
// reg commande
  in al,dx
  mov al,$24 //CAM ==> PC ps2
  out dx,al  //port en lecture n
 end;
 result:=0;
except
 result:=-1;
end;
end;


function  envoi(bytei2c:byte):integer;stdcall;assembler;
asm
// res:=0
 mov ecx,8
@Loop_Envoi:
 mov dx,Portc
 in  al,dx
 and	al,$fe		// scl 0
 out dx,al
 push 10
 call mclk
 mov dx,Portc
 in 	al,dx
 test bytei2c,$80
 jz @not1
 or 	al,$08		// envoi 1
 jmp @finev
@not1:
 and al,$f7		// envoi 0
@finev:
 out dx,al
 push 6
 call mclk
 mov dx,Portc
 in 	al,dx
 or	al,$01		// scl 1
 out dx,al
 push 10
 call mclk
 shl bytei2c,1
 dec ecx
 jnz @Loop_Envoi
 xor eax,eax
end;

procedure testack;stdcall;assembler;
asm
// scl 0
 mov dx,Portc
 in al,dx
 and al,$fe  // scl 0
 out dx,al
 push 4
 call mclk
 // sda 0
 mov dx,Portc
 in al,dx
 or al,$08   // sda 1
 out dx,al
 push 10
 call mclk
 mov dx,Portc
 in al,dx
 or al,$01	// scl 1
 out dx,al
 //mclk(16);
@inack:
 push 10
 call mclk
 mov dx,Porte
 in al,dx
 test al,$08	// sda avec 7405
 jz @inack		// bcl si sda a 1
end;

procedure start;stdcall;assembler;
asm
 mov dx,Portc
 in al,dx
 or al,$08		// sda 1
 out dx,al 
 push 6
 call mclk
 mov dx,Portc
 in al,dx
 or al,$01		// scl 1
 out dx,al
 push 10
 call mclk
 mov dx,Portc
 in al,dx
 and al,$f7		// sda 0
 out dx,al
 push 10
 call mclk
 mov dx,Portc
 in al,dx
 and al,$fe		// scl 0
 out dx,al
 push 10
 call mclk
end;

procedure stop;stdcall;assembler;
asm
 mov dx,Portc
 in al,dx
 and al,$fe		// scl 0
 out dx,al
 push 10
 call mclk
 mov dx,Portc
 in al,dx
 and al,$f7     // sda 0
 out dx,al
 push 10
 call mclk
 mov dx,Portc
 in al,dx
 or al,$01		// scl 1
 out dx,al
 push 10
 call mclk
 mov dx,Portc
 in al,dx
 or al,$08     // sda 1
 out dx,al
 push 6
 call mclk
end;

function sendParameters(adr,reg,data:byte):integer;stdcall;
begin
 start;
 envoi(adr);
 testack;
 envoi(reg);
 testack;
 envoi(data);
 testack;
 stop;
 result:=0;
end;

function reset:integer;
begin
 asm
  pushad
  mov dx,Portc
  in al,dx
  or al,$01		// scl 1
  out dx,al
  push 255
  call mclk
  mov dx,Portc
  in  al,dx
  or	al,$08		// sda 1
  out dx,al
  push 255
  call mclk
  mov dx,Portc
  in  al,dx
  and	al,$FB		// reset = 0 = reset
  out dx,al
  //InitTempo;
  push 100
  call mclk
  mov dx,Portc
  in al,dx
  or al,$04		// reset = 1 = marche
  out dx,al
  popad
 end;
 sendParameters($66, $0e, $02);
 mclk(100);
 sendParameters($66, $0e, $00);
 mclk(100);
 result:=0
end;

function Initialize(lpt1,mt_sec:integer):integer;cdecl;
begin
 result:=-1;
 port:=lpt1;
 HWDelay:=mt_sec;
 if HWDelay=0 then HWDelay:=FindDelay;
 if InitPort < 0 then exit;
 reset;
 sendParameters($66, $40, $6A);
 sendParameters($66, $42, $01);
 mclk(100);
 result:=0;
end;

{D�clenche l'exposition}
function Integrate(nbx,nby,bin,posX,posY:integer;pause_s:single;gain,offset:integer):integer;cdecl;
var
 paux:array[0..4] of Byte;  //passage des commandes
 nbxw,nbyw,dyw,dxw:integer;
 expo:cardinal;
begin
try
 GainOpt:=0;
{M�J du binning}
 if (bin <> 1) or (bin <> 2) or (bin <> 4) or (bin <> 8) then
  binning:=1
 else
  binning:=bin;
{Calcul de l'exposition : cf doc kodak p.12}
 nbxw:=nbx * binning;
 expo:=round(pause_s * HWDelay * (1280 / nbxw));
 if expo=0 then expo:=1;

{pr�pare l'envoi des donn�es}
 sendParameters($66, $0e, $02);
 mclk(100);
 sendParameters($66, $0e, $00);
 mclk(100);
 sendParameters($66, $40, $6a);

{Envoi des param�tres}
{met � jour le binning}
 if (binning = 1) then SendParameters($66, $41, $10);
 if (binning = 2) then SendParameters($66, $41, $15);
 if (binning = 4) then SendParameters($66, $41, $1A);
 if (binning = 8) then SendParameters($66, $41, $1F);

{met � jour les dimensions de l'image : virtual frame}
 nbxw:=(nbx * binning) + 20;
 move(nbxw,paux,4);
 sendParameters($66, $50, paux[1]);
 sendParameters($66, $51, paux[0]);

 nbyw:=(nby * binning) + 44;
 move(nbyw,paux,4);
 sendParameters($66, $52, paux[1]);
 sendParameters($66, $53, paux[0]);

{met � jour la partie de l'image � rapatrier : Windows Of Interest}
 dxw:=(posX * binning) + 8;
 move(dxw,paux,4);
 sendParameters($66, $49, paux[1]);
 sendParameters($66, $4a, paux[0]);

 nbxw:=nbx * binning;
 move(nbxw,paux,4);
 sendParameters($66, $4b, paux[1]);
 sendParameters($66, $4c, paux[0]);

 dyw:=(posY * binning) + 8; //revoir
 move(dyw,paux,4);
 sendParameters($66, $45, paux[1]);
 sendParameters($66, $46, paux[0]);

 nbyw:=nby * binning;
 move(nbyw,paux,4);
 sendParameters($66, $47, paux[1]);
 sendParameters($66, $48, paux[0]);

{M�J du DOVA DC register et PGA gain mode}
 if (GainOpt=0) then
  begin
   sendParameters($66, $22, $02);
   sendParameters($66, $20, $1f);
  end
 else
  begin
   sendParameters($66, $22, $00);
   sendParameters($66, $20, $00);
  end;

{met � jour le temps d'exposition}
 move(expo,paux,4);
 sendParameters($66, $4f, paux[0]);
 sendParameters($66, $4e, paux[1]);
 sendParameters($66, $4e, (paux[1]+$40)); //TOGGLED ?

{met � jour le gain et l'offset}
 sendParameters($66, $10, gain);
 sendParameters($66, $23, offset);
//Probleme??
// il manque peut �tre qq chose ici
 result:=0;
except
 result:=-1;
end;
end;


function ReadImage(pixels:PWord):integer;cdecl;
var
 x,y,count:integer;
 pixelLSB,pixelMSB:byte;
 pixel:integer;
begin
{pr�pare l'envoi des donn�es}
// sendParameters($66, $0e, $02);
// mclk(100);
// sendParameters($66, $0e, $00);
 //mclk(100);
// sendParameters($66, $40, $6a);
//Probleme??
// il manque peut �tre qq chose ici ou qq chose en trop
{D�marre la lecture}       // trigger et strobe register
 sendParameters($66, $42, $01);
 sendParameters($66, $42, $0);
{$IFDEF MSWINDOWS}
 if EnableCliSti=true then
  begin
   asm
    cli
   end;
  end;
{$ENDIF}
{Lecture de l'image}
ReadAbort:=false;
count:=0;
try
{Lecture port parall�le Normal}
 if PortReadOpt=NorRead then
  begin
   for y:=1 to nby do
    begin
     if ReadAbort=true then
      begin
       count:=-1;
       break;
      end;
     asm
      @loopshort:
       push 1
       call mclk;
       mov dx,Porte
       in  al,dx
       test al,32   { 00100000b  vclk (data) sur un mclk haut ? }
	// non bcl sans i
       jz @loopshort
     end;
     for x:=1 to nbx do
      begin
       asm
        mov dx,Portc
        mov al,$ef
        out dx,al
        mov al,$ed
        out dx,al
        nop
        nop
        nop
        mov dx,Port
        in  al,dx         // sauvegarde de data ??
        in  al,dx
        mov pixelLSB,al
       end;
       if (binning = 2) then
        begin
         asm
          mov dx,Portc
          mov al,$ef
          out dx,al
          mov al,$ed
          out dx,al
          nop
          nop
          nop
          mov dx,Port
          in al,dx         // idem ??
          in al,dx
          mov pixelMSB,al
         end;
        end;
	 pixel:=pixelLSB + pixelMSB;
//        if (pixel > 1024) then pixel:=1024;
        pixels^:=pixel shl 7;
        inc(integer(pixels),2);
        inc(count);
      end;
    end;
 end;
{Lecture port parall�le EPP}
 if PortReadOpt = EPPRead then
  begin
   for y:=1 to nby do
    begin
     if ReadAbort=true then
      begin
       count:=-1;
       break;
      end;
     asm
     @loopshort_epp:
      mov dx,eppdata
      in al,dx
      mov dx,Porte
      in al,dx
      test al,32
      jz @loopshort_epp
     end;
     for x:=1 to nbx do
      begin
       inc(integer(pixels));
       asm
        mov dx,eppdata
        in al,dx
        mov pixelLSB,al
       end;
       if (binning = 2) then
        begin
         asm
          mov dx,eppdata
          in al,dx
          mov pixelMSB,al
         end;
        end;
         pixel:= pixelLSB + pixelMSB;
 //      if (pixel > 1024) then pixel:=1024;
       pixels^:=pixel shl 7;
       inc(integer(pixels),2);
       inc(count);
      end;
    end;
  end;
{IMPORTANT : toujours d�sactiver m�me en cas de probl�me}
finally
{$IFDEF MSWINDOWS}
 if EnableCliSti=true then
  begin
   asm
    sti
   end;
  end;
{$ENDIF}
 result:=count;
end;
end;

procedure SetCLISTI(value:boolean);cdecl;
begin
 EnableCliSti:=value;
end;

exports
 Initialize,
 Integrate,
 ReadImage,
 AbortReading,
 FindDelay,
 SetCLISTI;

begin
 EnableCliSti:=false;
end.
