unit u_driver_pisco;

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

                  Gestion du Focuseur avec carte interface serie

-------------------------------------------------------------------------------}

interface

procedure WriteBit0(Port:Word;Valeur:Byte);
procedure WriteBit1(Port:Word;Valeur:Byte);
procedure WriteBit2(Port:Word;Valeur:Byte);
procedure InitCom(Port:Word);
procedure RazCom(Port:Word);
procedure RazComFast(Port:Word);
procedure AdPlus(Port:Word);
procedure AdMoins(Port:Word);
procedure DecPlus(Port:Word);
procedure DecMoins(Port:Word);
procedure AdPlusFast(Port:Word);
procedure AdMoinsFast(Port:Word);
procedure DecPlusFast(Port:Word);
procedure DecMoinsFast(Port:Word);
procedure FocusPlus(Port:Word);
procedure FocusMoins(Port:Word);
procedure FocusPlusFast(Port:Word);
procedure FocusMoinsFast(Port:Word);

implementation

uses
    u_general;


{' ====================================
' Ecriture port série
' DTR = broche 4 (bit 0 du registre 4)
' ====================================
Sub WriteBit0(valeur As Integer)
Dim r As Integer

If valeur = 0 Then
   r = outport(ComAdress + 4, inport(ComAdress + 4) And &HFE)
   r = outport(ComAdress + 4, inport(ComAdress + 4) And &HFE)
   r = outport(ComAdress + 4, inport(ComAdress + 4) And &HFE)
Else
   r = outport(ComAdress + 4, inport(ComAdress + 4) Or 1)
   r = outport(ComAdress + 4, inport(ComAdress + 4) Or 1)
   r = outport(ComAdress + 4, inport(ComAdress + 4) Or 1)
End If

End Sub}

{====================================
 Ecriture port série
 DTR = broche 4 (bit 0 du registre 4)
 ==================================== }
procedure WriteBit0(Port:Word;Valeur:Byte);
begin
   if Valeur=0 then
       begin
       PortWrite(PortRead(Port+4) and $FE,Port+4);
       PortWrite(PortRead(Port+4) and $FE,Port+4);
       PortWrite(PortRead(Port+4) and $FE,Port+4);
       end
   else
       begin
       PortWrite(PortRead(Port+4) or 1,Port+4);
       PortWrite(PortRead(Port+4) or 1,Port+4);
       PortWrite(PortRead(Port+4) or 1,Port+4);
       end;
end;

{' ====================================
' Ecriture port série
' RTS = broche 7 (bit 1 du registre 4)
' ====================================
Sub WriteBit1(valeur As Integer)
Dim r As Integer

If valeur = 0 Then
   r = outport(ComAdress + 4, inport(ComAdress + 4) And &HFD)
   r = outport(ComAdress + 4, inport(ComAdress + 4) And &HFD)
   r = outport(ComAdress + 4, inport(ComAdress + 4) And &HFD)
Else
   r = outport(ComAdress + 4, inport(ComAdress + 4) Or 2)
   r = outport(ComAdress + 4, inport(ComAdress + 4) Or 2)
   r = outport(ComAdress + 4, inport(ComAdress + 4) Or 2)
End If

End Sub}


{====================================
 Ecriture port série
 RTS = broche 7 (bit 1 du registre 4)
 ==================================== }
procedure WriteBit1(Port:Word;Valeur:Byte) ;
begin
   if Valeur=0 Then
      begin
      PortWrite(PortRead(Port+4) and $FD,Port+4);
      PortWrite(PortRead(Port+4) and $FD,Port+4);
      PortWrite(PortRead(Port+4) and $FD,Port+4);
      end
   else
      begin
      PortWrite(PortRead(Port+4) or 2,Port+4);
      PortWrite(PortRead(Port+4) or 2,Port+4);
      PortWrite(PortRead(Port+4) or 2,Port+4);
      end;
end;

{' ====================================
' Ecriture port série
' TxD = broche 3 (bit 6 du registre 3)
' ====================================
Sub WriteBit2(valeur As Integer)
Dim r As Integer

If valeur = 0 Then
   r = outport(ComAdress + 3, inport(ComAdress + 3) And 191)
   r = outport(ComAdress + 3, inport(ComAdress + 3) And 191)
   r = outport(ComAdress + 3, inport(ComAdress + 3) And 191)
Else
   r = outport(ComAdress + 3, inport(ComAdress + 3) Or 64)
   r = outport(ComAdress + 3, inport(ComAdress + 3) Or 64)
   r = outport(ComAdress + 3, inport(ComAdress + 3) Or 64)
End If

End Sub}

{====================================
 Ecriture port série
 TxD = broche 3 (bit 6 du registre 3)
 ==================================== }
procedure WriteBit2(Port:Word;Valeur:Byte) ;
begin
   if Valeur=0 Then
      begin
      PortWrite(PortRead(Port+3) and 191,Port+3);
      PortWrite(PortRead(Port+3) and 191,Port+3);
      PortWrite(PortRead(Port+3) and 191,Port+3);
      end
   else
      begin
      PortWrite(PortRead(Port+3) or 64,Port+3);
      PortWrite(PortRead(Port+3) or 64,Port+3);
      PortWrite(PortRead(Port+3) or 64,Port+3);
      end;
end;

{' ====================================
' Initialisation du port série
' Impulsion sur le bit 3 du registre 4
' ====================================
Sub InitCom()
Dim r As Integer
Dim i As Integer

r = outport(ComAdress + 4, 0) 
r = outport(ComAdress + 4, 0) 
r = outport(ComAdress + 4, 0) 

r = outport(ComAdress + 4, 8) 
r = outport(ComAdress + 4, 8) 
r = outport(ComAdress + 4, 8) 

r = outport(ComAdress + 4, 0) 
r = outport(ComAdress + 4, 0)
r = outport(ComAdress + 4, 0)

' Vide le registre à décalage 
WriteBit2 0 ' Latch à 0 

For i = 1 To 8 
   WriteBit0 0  ' On écrit 0 
   WriteBit1 0  ' 8 impulsions sur la Clock 
   WriteBit1 1 
Next 

WriteBit1 0

WriteBit2 1 ' Latch à 1

End Sub}

{====================================
 Initialisation du port série
 Impulsion sur le bit 3 du registre 4
 ==================================== }
procedure InitCom(Port:Word);
var
   i:Integer;
begin
   for i:=1 to 3 do PortWrite(0,Port+4);
   for i:=1 to 3 do PortWrite(8,Port+4);
   for i:=1 to 3 do PortWrite(0,Port+4);

   {On vide le registre à décalage }
   WriteBit2(Port,0); { Latch à 0 }
   for i:=1 to 8 do
      begin
      WriteBit0(Port,0);  { On écrit 0 }
      WriteBit1(Port,0);  { 8 impulsions sur la Clock }
      WriteBit1(Port,1);
      end;
   WriteBit1(Port,0);
   WriteBit2(Port,1); { Latch à 1 }
end;

{' ===============================================
' Met à zéro tous les bits du registre à décalage
' ===============================================
Sub RazCom()
Dim r As Integer
Dim i As Integer

' Vide le registre à décalage
WriteBit2 0 ' Latch à 0
For i = 1 To 8
   WriteBit0 0  ' On écrit 0
   WriteBit1 0  ' 8 impulsions sur la Clock
   WriteBit1 1
Next
WriteBit1 0

WriteBit2 1 ' Latch à 1

End Sub}

{ ===============================================
  Met à zéro tous les bits du registre à décalage
  =============================================== }
procedure RazCom(Port:Word);
var
   i:Integer;
begin
   { Vide le registre à décalage }
   WriteBit2(Port,0); { Latch à 0}
   for i:=1 to 8 do
      begin
      WriteBit0(port,0);  { On écrit 0}
      WriteBit1(port,0);   { 8 impulsions sur la Clock }
      WriteBit1(port,1);
      end;

   WriteBit1(port,0);
   WriteBit2(port,1); {Latch à 1}
end;

{' ===============================================
' Met à zéro tous les bits du registre à décalage
' Sauf le bit 4 (vitesse lente ou rapide)
' ===============================================
Sub RazComFast()
Dim i As Integer

WriteBit2 0 ' Latch à 0
For i = 1 To 8
   WriteBit0 0  ' On écrit 0
   WriteBit1 0  ' 8 impulsions sur la Clock
   WriteBit1 1
Next
WriteBit1 0

WriteBit0 1 ' Ligne d'entrée à 1 
WriteBit1 1 ' Front montant de la Clock
WriteBit1 0 ' Front descendant de la Clock 
'WriteBit0 1

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1 
WriteBit1 0 

WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1
WriteBit1 0 

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit2 1 ' Latch à 1

End Sub}

{' ===============================================
' Met à zéro tous les bits du registre à décalage
' Sauf le bit 4 (vitesse lente ou rapide)
' ===============================================}
procedure RazComFast(Port:Word);
var
   i:Integer;
begin
   WriteBit2(Port,0); // Latch à 0
   for i:=1 to 8 do
      begin
      WriteBit0(Port,0); // On écrit 0
      WriteBit1(Port,0); // 8 impulsions sur la Clock
      WriteBit1(Port,1);
      end;
   WriteBit1(Port,0);

   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock
   //WriteBit0(Port,1);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit2(Port,1); // Latch à 1
end;

{' =====================
' Ascension droite plus
' (Bit 0)
' =====================
Sub AdPlus()
Dim i As Integer

WriteBit2 0 ' Latch à 0
For i = 1 To 8
   WriteBit0 0  ' On écrit 0
   WriteBit1 0  ' 8 impulsions sur la Clock
   WriteBit1 1
Next
WriteBit1 0

WriteBit0 1 ' Ligne d'entrée à 1
WriteBit1 1 ' Front montant de la Clock
WriteBit1 0 ' Front descendant de la Clock

WriteBit2 1 ' Latch à 1

End Sub}

{' =====================
' Ascension droite plus
' (Bit 0)
' =====================}
procedure AdPlus(Port:Word);
var
   i:Integer;
begin
   WriteBit2(Port,0); // Latch à 0
   for i:=1 to 8 do
      begin
      WriteBit0(Port,0); // On écrit 0
      WriteBit1(Port,0); // 8 impulsions sur la Clock
      WriteBit1(Port,1);
      end;
   WriteBit1(Port,0);

   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock

   WriteBit2(Port,1); // Latch à 1
end;

{' ======================
' Ascension droite moins
' (Bit 1)
' ======================
Sub AdMoins()
Dim i As Integer

WriteBit2 0 ' Latch à 0
For i = 1 To 8
   WriteBit0 0  ' On écrit 0
   WriteBit1 0  ' 8 impulsions sur la Clock
   WriteBit1 1
Next
WriteBit1 0 

WriteBit0 1 ' Ligne d'entrée à 1 
WriteBit1 1 ' Front montant de la Clock 
WriteBit1 0 ' Front descendant de la Clock 
  
WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1 
WriteBit1 0 

WriteBit2 1 ' Latch à 1 

End Sub}

{' ======================
' Ascension droite moins
' (Bit 1)
' ======================}
procedure AdMoins(Port:Word);
var
   i:Integer;
begin
   WriteBit2(Port,0); // Latch à 0
   for i:=1 to 8 do
      begin
      WriteBit0(Port,0); // On écrit 0
      WriteBit1(Port,0); // 8 impulsions sur la Clock
      WriteBit1(Port,1);
      end;
   WriteBit1(Port,0);

   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit2(Port,1); // Latch à 1
end;

{' =================
' Déclinaison plus
' (Bit 2)
' =================
Sub DecPlus()
Dim i As Integer

WriteBit2 0 ' Latch à 0
For i = 1 To 8
   WriteBit0 0  ' On écrit 0
   WriteBit1 0  ' 8 impulsions sur la Clock 
   WriteBit1 1
Next 
WriteBit1 0 

WriteBit0 1 ' Ligne d'entrée à 1 
WriteBit1 1 ' Front montant de la Clock 
WriteBit1 0 ' Front descendant de la Clock 
  
WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1 
WriteBit1 0 

WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1 
WriteBit1 0 

WriteBit2 1 ' Latch à 1

End Sub}

{' =================
' Déclinaison plus
' (Bit 2)
' =================}
procedure DecPlus(Port:Word);
var
   i:Integer;
begin
   WriteBit2(Port,0); // Latch à 0
   for i:=1 to 8 do
      begin
      WriteBit0(Port,0);  // On écrit 0
      WriteBit1(Port,0);  // 8 impulsions sur la Clock
      WriteBit1(Port,1);
      end;
   WriteBit1(Port,0);

   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit2(Port,1); // Latch à 1
end;

{' ==================
' Déclinaison  moins
' (Bit 3)
' ==================
Sub DecMoins()
Dim i As Integer

WriteBit2 0 ' Latch à 0
For i = 1 To 8
   WriteBit0 0  ' On écrit 0
   WriteBit1 0  ' 8 impulsions sur la Clock
   WriteBit1 1
Next
WriteBit1 0

WriteBit0 1 ' Ligne d'entrée à 1
WriteBit1 1 ' Front montant de la Clock
WriteBit1 0 ' Front descendant de la Clock

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit2 1 ' Latch à 1

End Sub}

{' ==================
' Déclinaison  moins
' (Bit 3)
' ==================}
procedure DecMoins(Port:Word);
var
   i:Integer;
begin
WriteBit2(Port,0); // Latch à 0
for i:=1 to 8 do
   begin
   WriteBit0(Port,0); // On écrit 0
   WriteBit1(Port,0); // 8 impulsions sur la Clock
   WriteBit1(Port,1);
   end;
WriteBit1(Port,0);

WriteBit0(Port,1); // Ligne d'entrée à 1
WriteBit1(Port,1); // Front montant de la Clock
WriteBit1(Port,0); // Front descendant de la Clock

WriteBit0(Port,0); // Pousse d'un cran
WriteBit1(Port,1);
WriteBit1(Port,0);

WriteBit0(Port,0); // Pousse d'un cran
WriteBit1(Port,1);
WriteBit1(Port,0);

WriteBit0(Port,0); // Pousse d'un cran
WriteBit1(Port,1);
WriteBit1(Port,0);

WriteBit2(Port,1); // Latch à 1
end;

{' =======================================
' Ascension droite plus et vitesse rapide
' (Bit 0 + 4)
' =======================================
Sub AdPlusFast() 
Dim i As Integer 

WriteBit2 0 ' Latch à 0 
For i = 1 To 8 
   WriteBit0 0  ' On écrit 0
   WriteBit1 0  ' 8 impulsions sur la Clock 
   WriteBit1 1 
Next 
WriteBit1 0 

WriteBit0 1 ' Ligne d'entrée à 1 
WriteBit1 1 ' Front montant de la Clock
WriteBit1 0 ' Front descendant de la Clock 

WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1 
WriteBit1 0 

WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1 
WriteBit1 0 

WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1
WriteBit1 0

WriteBit0 1 ' Ligne d'entrée à 1
WriteBit1 1 ' Front montant de la Clock
WriteBit1 0 ' Front descendant de la Clock

WriteBit2 1 ' Latch à 1

End Sub}

{' =======================================
' Ascension droite plus et vitesse rapide
' (Bit 0 + 4)
' =======================================}
procedure AdPlusFast(Port:Word);
var
   i:Integer;
begin
   WriteBit2(Port,0); // Latch à 0
   for i:=1 to 8 do
      begin
      WriteBit0(Port,0); // On écrit 0
      WriteBit1(Port,0); // 8 impulsions sur la Clock
      WriteBit1(Port,1);
      end;
   WriteBit1(Port,0);

   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock

   WriteBit2(Port,1); // Latch à 1
end;

{' =======================================
' Ascension droite mois et vitesse rapide
' (Bit 1 + 4)
' =======================================
Sub AdMoinsFast()
Dim i As Integer

WriteBit2 0 ' Latch à 0
For i = 1 To 8
   WriteBit0 0  ' On écrit 0
   WriteBit1 0  ' 8 impulsions sur la Clock
   WriteBit1 1
Next
WriteBit1 0

WriteBit0 1 ' Ligne d'entrée à 1
WriteBit1 1 ' Front montant de la Clock
WriteBit1 0 ' Front descendant de la Clock

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit0 1 ' Ligne d'entrée à 1
WriteBit1 1 ' Front montant de la Clock
WriteBit1 0 ' Front descendant de la Clock

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit2 1 ' Latch à 1

End Sub}

{' =======================================
' Ascension droite mois et vitesse rapide
' (Bit 1 + 4)
' =======================================}
procedure AdMoinsFast(Port:Word);
var
   i:Integer;
begin
   WriteBit2(Port,0); // Latch à 0
   for i:=1 to 8 do
      begin
      WriteBit0(Port,0); // On écrit 0
      WriteBit1(Port,0); // 8 impulsions sur la Clock
      WriteBit1(Port,1);
      end;
   WriteBit1(Port,0);

   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit2(Port,1); // Latch à 1
end;

{' ==================================
' Déclinaison plus et vitesse rapide
' (Bit 2 + 4)
' ==================================
Sub DecPlusFast()
Dim i As Integer

WriteBit2 0 ' Latch à 0
For i = 1 To 8
   WriteBit0 0  ' On écrit 0
   WriteBit1 0  ' 8 impulsions sur la Clock 
   WriteBit1 1 
Next 
WriteBit1 0 

WriteBit0 1 ' Ligne d'entrée à 1 
WriteBit1 1 ' Front montant de la Clock 
WriteBit1 0 ' Front descendant de la Clock 

WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1 
WriteBit1 0 

WriteBit0 1 ' Ligne d'entrée à 1 
WriteBit1 1 ' Front montant de la Clock 
WriteBit1 0 ' Front descendant de la Clock 

WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1
WriteBit1 0

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit2 1 ' Latch à 1

End Sub}

{' ==================================
' Déclinaison plus et vitesse rapide
' (Bit 2 + 4)
' ==================================}
procedure DecPlusFast(Port:Word);
var
   i:Integer;
begin
   WriteBit2(Port,0); // Latch à 0
   for i:=1 to 8 do
      begin
      WriteBit0(Port,0); // On écrit 0
      WriteBit1(Port,0); // 8 impulsions sur la Clock
      WriteBit1(Port,1);
      end;
   WriteBit1(Port,0);

   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit2(Port,1); // Latch à 1
end;

{' ==================================
' Déclinaison mois et vitesse rapide
' (Bit 3 + 4)
' ==================================
Sub DecMoinsFast()
Dim i As Integer

WriteBit2 0 ' Latch à 0
For i = 1 To 8
   WriteBit0 0  ' On écrit 0
   WriteBit1 0  ' 8 impulsions sur la Clock
   WriteBit1 1
Next
WriteBit1 0

WriteBit0 1 ' Ligne d'entrée à 1
WriteBit1 1 ' Front montant de la Clock
WriteBit1 0 ' Front descendant de la Clock

WriteBit0 1 ' Ligne d'entrée à 1 
WriteBit1 1 ' Front montant de la Clock 
WriteBit1 0 ' Front descendant de la Clock  

WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1 
WriteBit1 0 

WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1
WriteBit1 0

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit2 1 ' Latch à 1

End Sub}

{' ==================================
' Déclinaison mois et vitesse rapide
' (Bit 3 + 4)
' ==================================}
procedure DecMoinsFast(Port:Word);
var
   i:Integer;
begin
   WriteBit2(Port,0); // Latch à 0
   for i:=1 to 8 do
      begin
      WriteBit0(Port,0); // On écrit 0
      WriteBit1(Port,0); // 8 impulsions sur la Clock
      WriteBit1(Port,1);
      end;
   WriteBit1(Port,0);

   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock

   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit2(Port,1); // Latch à 1
end;

{' =====================
' Focalisation positive
' (Bit 5)
' =====================
Sub FocusPlus()
Dim i As Integer

WriteBit2 0 ' Latch à 0
For i = 1 To 8
   WriteBit0 0  ' On écrit 0
   WriteBit1 0  ' 8 impulsions sur la Clock
   WriteBit1 1
Next
WriteBit1 0

WriteBit0 1 ' Ligne d'entrée à 1 
WriteBit1 1 ' Front montant de la Clock 
WriteBit1 0 ' Front descendant de la Clock 
  
WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1 
WriteBit1 0 

WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1 
WriteBit1 0 

WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1
WriteBit1 0

WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1 
WriteBit1 0 

WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1 
WriteBit1 0 

WriteBit2 1 ' Latch à 1

End Sub}

{ =====================
 Focalisation positive
 (Bit 5)
 ===================== }
procedure FocusPlus(Port:Word);
var
   i:Integer;
begin
    WriteBit2(Port,0); // Latch à 0}
    for i:=1 to 8 do
       begin
       WriteBit0(Port,0);  // On écrit 0}
       WriteBit1(Port,0);  // 8 impulsions sur la Clock}
       WriteBit1(Port,1);
       end;
    WriteBit1(Port,0);
    WriteBit0(Port,1); // Ligne d'entrée à 1
    WriteBit1(Port,1); // Front montant de la Clock
    WriteBit1(Port,0); // Front descendant de la Clock
    for i:=1 to 5 do
       begin
       WriteBit0(Port,0); // Pousse de 5 crans
       WriteBit1(Port,1);
       WriteBit1(Port,0);
       end;
    WriteBit2(Port,1); // Latch à 1
end;

{' =====================
' Focalisation négative
' (Bit 6)
' =====================
Sub FocusMoins()
Dim i As Integer

WriteBit2 0 ' Latch à 0
For i = 1 To 8
   WriteBit0 0  ' On écrit 0
   WriteBit1 0  ' 8 impulsions sur la Clock
   WriteBit1 1
Next
WriteBit1 0

WriteBit0 1 ' Ligne d'entrée à 1
WriteBit1 1 ' Front montant de la Clock
WriteBit1 0 ' Front descendant de la Clock

WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1 
WriteBit1 0 

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1 
WriteBit1 0 

WriteBit0 0 ' Pousse d'un cran 
WriteBit1 1
WriteBit1 0

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit2 1 ' Latch à 1

End Sub}

{ =====================
 Focalisation négative
 (Bit 6)
 ===================== }
procedure FocusMoins(Port:Word);
var
   i:Integer;
begin
   WriteBit2(Port,0); // Latch à 0
   for i:=1 To 8 do
      begin
      WriteBit0(Port,0); // On écrit 0
      WriteBit1(Port,0); // 8 impulsions sur la Clock
      WriteBit1(Port,1);
      end;
   WriteBit1(Port,0);
   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock
   for i:=1 to 6 do
       begin
       WriteBit0(Port,0); // Pousse de 6 crans
       WriteBit1(Port,1);
       WriteBit1(Port,0);
       end;
   WriteBit2(Port,1); // Latch à 1
end;

{' =======================================
' Focalisation positive et vitesse rapide
' (Bit 4 et 5)
' =======================================
Sub FocusPlusFast()
Dim i As Integer

WriteBit2 0 ' Latch à 0
For i = 1 To 8
   WriteBit0 0  ' On écrit 0
   WriteBit1 0  ' 8 impulsions sur la Clock
   WriteBit1 1
Next
WriteBit1 0

WriteBit0 1 ' Ligne d'entrée à 1
WriteBit1 1 ' Front montant de la Clock
WriteBit1 0 ' Front descendant de la Clock

WriteBit0 1 ' Ligne d'entrée à 1
WriteBit1 1 ' Front montant de la Clock
WriteBit1 0 ' Front descendant de la Clock

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit2 1 ' Latch à 1

End Sub}

{' =======================================
' Focalisation positive et vitesse rapide
' (Bit 4 et 5)
' =======================================}
procedure FocusPlusFast(Port:Word);
var
   i:Integer;
begin
   WriteBit2(Port,0); // Latch à 0
   for i:=1 to 8 do
      begin
      WriteBit0(Port,0); // On écrit 0
      WriteBit1(Port,0); // 8 impulsions sur la Clock
      WriteBit1(Port,1);
      end;
   WriteBit1(Port,0);

   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock

   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit2(Port,1); // Latch à 1
end;

{' ====================================
' Focalisation moins et vitesse rapide
' (Bit 4 et 6)
' ====================================
Sub FocusMoinsFast()
Dim i As Integer

WriteBit2 0 ' Latch à 0
For i = 1 To 8
   WriteBit0 0  ' On écrit 0
   WriteBit1 0  ' 8 impulsions sur la Clock
   WriteBit1 1
Next
WriteBit1 0

WriteBit0 1 ' Ligne d'entrée à 1
WriteBit1 1 ' Front montant de la Clock
WriteBit1 0 ' Front descendant de la Clock

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit0 1 ' Ligne d'entrée à 1
WriteBit1 1 ' Front montant de la Clock
WriteBit1 0 ' Front descendant de la Clock

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit0 0 ' Pousse d'un cran
WriteBit1 1
WriteBit1 0

WriteBit2 1 ' Latch à 1

End Sub}

{' ====================================
' Focalisation moins et vitesse rapide
' (Bit 4 et 6)
' ====================================}
procedure FocusMoinsFast(Port:Word);
var
   i:Integer;
begin
   WriteBit2(Port,0); // Latch à 0
   for i:=1 to 8 do
      begin
      WriteBit0(Port,0); // On écrit 0
      WriteBit1(Port,0); // 8 impulsions sur la Clock
      WriteBit1(Port,1);
      end;
   WriteBit1(Port,0);

   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,1); // Ligne d'entrée à 1
   WriteBit1(Port,1); // Front montant de la Clock
   WriteBit1(Port,0); // Front descendant de la Clock

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit0(Port,0); // Pousse d'un cran
   WriteBit1(Port,1);
   WriteBit1(Port,0);

   WriteBit2(Port,1); // Latch à 1
end;

{-------------------------------------------------------------------------------

                                   ROBO FOCUS

-------------------------------------------------------------------------------}

{
All RFCP commands are sent/received to the RoboFocus in standard RS232 at
9600 baud, 8 bit, no parity.
Commands must be sent as a block within approximately 400 ms
(ie., if sending manually, the typing must be fast).
All commands and data received are of form "FXNNNNNNZ" where
· "F" denotes focusser command
· "X" is a alpha character denoting which command
· "?" is an arbitrary character as a placeholder
· "NNNNNN" are six decimal digits with leading zeros as necessary
· "Z" is a checksum character of value 0-255.
Its value is the result of adding all the previous characters together and setting
 Z equal to the least significant byte.

All data sets are nine ASCI characters (e.g., the character of value 48 represents a "0").
There is no end of command character.
If subsequent characters are sent to the RoboFocus(such as a CR),
they may be interpreted by RoboFocus as a stop command (see below).

When a command is received, RoboFocus computes the checksum for the received characters.
If it does not match, or if there are illegal characters, the command is ignored.
After a valid command or pushbutton that causes motion, the RoboFocus responds
with movement ticks (about 10-50 per second) which is a string of the character "I" or "O".
When motion ceases, RoboFocus issues a final packet of form "FXNNNNNNZ".
X corresponds to the command that was sent.

The RoboFocus processor has limited built-in data checking.
Where a 65K limit exists, RoboFocus controller does not block the command but
will roll over its count for that parameter.  In general, external control
software should have all necessary limits and format requirements built in.

Note that the standard motor we provide is rated as a "0.1 deg/step"
unit (3600 "steps" per revolution of the geared down output shaft).
When the motor companies rate the number of steps, they are really
counting the "microsteps" of the rotor.  One complete cycle of the motor rotor
(a "whole step") itself takes four microsteps.  For simplicity in our design,
 we make output shaft movements in whole steps, ie., four microsteps.  Therefor,
  our standard motor will rotate one complete turn in 900 of the "steps" from the RoboFocus.

FVXXXXXXZ.  Commands RoboFocus to respond with RoboFocus firmware version number.
Response is FVXXXXXXZ.

FG?XXXXXZ.  Commands RoboFocus to goto position ?XXXXX.  If ?XXXXX are all zeros,
response from the RoboFocus is the current position in the form FD?XXXXXZ.
If ?XXXXX represents non-zero, the RoboFocus will take this as the target
position and begin moving.  As the stepper moves, RoboFocus responds to the
command with the character "I" or "O" for each step.
At the conclusion of the move, RoboFocus sends the current position FD?XXXXXZ.
Note actual limit is 65K (there is a spare digit for the future).

FI?XXXXXZ.  Commands RoboFocus to move inward by ?XXXXX steps then sends
current position.  Note actual limit is 65K (one digit is spare).

FO?XXXXXZ.  Commands RoboFocus to move outward by ?XXXXX steps then sends
current position.  Note actual limit is 65K (one digit is spare).

FS?XXXXXZ. Commands RoboFocus to set current position to ?XXXXX.
If ?XXXXX=0 then RoboFocus responds with the current position.
If ?XXXXX<>0, RoboFocus responds with new current position.
Note limit is 64000 (there is a spare digit for the future).

FL?XXXXXZ Commands RoboFocus to set maximum travel to ?XXXXX.
If ?XXXXX=0 then RoboFocus responds with the old setting.
If ?XXXXX<>0, RoboFocus responds with the new setting.
Form of response is FL?XXXXXZ.
Note there is a limit of 65K (there is a spare digit for the future).

FP??XXXXZ Commands RoboFocus to set the four outputs for the remote power module.
The channels are 1-4 L-R..  If ??XXXX=0 then RoboFocus responds with the current
power settings.  If X=1 the channel will be set to OFF; if an X=2, the channel
 will be set to ON.  Values other than 0-2 are interpreted as 0.
 RoboFocus responds with the new power settings in form FP??XXXXZ.

FBNXXXXXZ.  Commands RoboFocus to change form of backlash compensation.
If XXXX=0 then RoboFocus responds with the current settings.
N=1 is no compensation, N=2 is compensation added to IN motion, N=3 is
compensation added to OUT motion.  XXXXX is amount of compensation as 1-255.
Factory default is 200020 (IN with 20 steps).  RoboFocus response is FBNXXXXXZ.

Any command.  During movement, RoboFocus monitors its input serial channel.
Any serial activity is taken as an immediate stop command and movement will cease
(if the buttons on the RoboFocus are pushed during computer driven movement it
will also stop).  RoboFocus response will be the current position.
Note that if the same serial port is being used simultaneously for the telescope
control using an integrated program, the scope control software may interrogate
the scope during a focus movement, which will stop the focus movement.

}


end.
