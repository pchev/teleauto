library PluginHX516;

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

{$UNDEF COLOR}

uses
  SysUtils,
  Classes;

type
  TLigInt=array[1..999999] of SmallInt;
  PLigInt=^TLigInt;
  TImgInt=array[1..999999] of PLigInt;
  PImgInt=^TImgInt;
  TTabImgInt=array[1..255] of PImgInt;
  PTabImgInt=^TTabImgInt;

  // Prototype of the TeleAuto function you can call to have precise hour // New in version 2.8
  TGetHour = procedure (var Year,Month,Day,Hour,Min,Sec,MSec:Word);

var
  // TeleAuto function giving precise hour // New in version 2.8
  GetHour:TGetHour;

var
// Variables provided by TeleAuto to setup ans use the CD camera
    Adress:Word;                   // The adress of the paralel port used by the camera
    x1,y1,x2,y2:Integer;           // The window to acquire in equivalent binning 1x1
    Binning:Integer;               // Binning used
    Pose:Double;                   // The pose in seconds
    EmptyingDelay:Double;          // Delay needed to empty the CCD (Hisis cameras)
    ReadingDelay:Double;           // Reading delay (Hisis cameras)
    ShutterCloseDelay:Double;      // Closing delay of the shutter
    PCMinusUT:Double;              // Difference hour PC minus hour UT
    OSiSNT:Boolean;                // Ta is used under NT ?
    BD1,BD2,BD10,y,z:Integer;

// Variables used in this driver
    YearBegin,MonthBegin,DayBegin,HourBegin,MinBegin,SecBegin,MSecBegin:Word;
    YearEnd,MonthEnd,DayEnd,HourEnd,MinEnd,SecEnd,MSecEnd:Word;

{$R *.RES}

//****************************************************/
//*                                                  */
//*          PILOTE HX516 VERSION STANDARD (pas MK2) */
//*                                                  */
//****************************************************/

//Visual Basic provides several time-related facilities.
//If timings accurate to plus or minus 1 second are satisfactory the Timer function can be used.
//This returns the number of seconds that have elapsed since 12 midnight.
//Before using this function, check, and if necessary set,
//the system time on your PC (this is done by typing time at the DOS prompt).
//If working late at night, remember that your results will be affected if midnight
//strikes during a timing experiment!
function TimeTest:Integer;
var
   t1,t2:TDateTime;
   x,a:Integer;
   t3:Cardinal;
begin
// t1!=timer
t1:=Now;
for x:=0 to 10000000 do a:=0;
// t2!=timer
t2:=Now;
t3:=Round((t2-t1)*1000000*24*3600); // Jours -> Secondes (*24*3600)
// \ Divide & return an integer value
// BD1%=10000000\t3!
Result:=10000000 div t3;
end;

//On passe un coup de serpillère
procedure Wiper(BD2:Integer);
var
   a,i:Integer;
   Adress3:Word;
   LocalAdress:Word;
begin
   LocalAdress:=Adress;
   Adress3:=Adress+2;

   asm
      mov dx,LocalAdress
      mov al,85
      out dx,al

      mov al,213  // Envoi de l'impulsion de nettoyage
      out dx,al
   end;

      // ça cela s'appel se glander la nouille pour
      // faire une pose de quelques micro secondes
      for i:=0 to BD2 do a:=0;

   asm
      mov al,85
      out dx,al

      mov dx,Adress3  // On change de registre de contrôle
      mov al,6        // arret de l'ampli pour la pose
      out dx,al
   end;

   // ça cela s'appel se glander la nouille pour
   // faire une pose de quelques micro secondes
   for i:=0 to BD2 do a:=0;
end;

procedure ClearVert(BD2,BD10:Integer);
var
   z,y,a,w,i:Integer;
   LocalAdress:Word;
begin
   LocalAdress:=Adress;
   for z:=0 to 9 do
      begin
      for y:=0 to 50 do
         begin
         asm
            mov dx,LocalAdress
            mov al,5
            out dx,al
            mov al,1
            out dx,al
         end;
         // On se glande la nouille
         for i:=0 to BD2 do a:=0;

         asm
            mov al,5
            out dx,al
            mov al,85
            out dx,al
         end;
         // On se glande la nouille
         for i:=0 to BD10 do a:=0;
         end;
      for w:=0 to 700 do
         begin
         asm
            mov al,85
            out dx,al
            mov al,5
            out dx,al
         end;
         // On se glande la nouille
         for i:=0 to BD2 do a:=0;
         asm
            mov al,7      //RAZ du registre vertical
            out dx,al
            mov al,39
            out dx,al
            mov al,69
            out dx,al
         end;
         // On se glande la nouille
         for i:=0 to BD2 do a:=0;
      end;
   end;
end;

procedure Reader(BD2,BD10:Integer);
var
   a,i:Integer;
   Adress3:Word;
   LocalAdress:Word;
begin
   LocalAdress:=Adress;
   Adress3:=Adress+2;

   // Appel de la fonction d'RAZ du registre vertical
   ClearVert(BD2,BD10);

   asm
      mov dx,LocalAdress      // Changement de registre de controle
      mov al,21
      out dx,al

      mov dx,Adress3     // Changement de registre de controle
      mov al,0           // amplificateur sur 0n, mode lecture
      out dx,al

      mov dx,LocalAdress        // Changement de registre de controle
      mov al,21
      out dx,al

      mov al,29
      out dx,al
   end;

   // On se glande la nouille
   for i:=0 to BD10 do a:=0;

   asm
      mov al,21
      out dx,al

      mov al,85
      out dx,al

      mov dx,Adress3      // Changement de registre de controle
      mov al,4          // amp. On, mode Horloge
      out dx,al
   end;
end;

procedure Vert(BD2,BD10:Integer);
var
   a,i:Integer;
   LocalAdress:Word;
begin
   LocalAdress:=Adress;
   asm
      mov dx,LocalAdress
      mov al,5
      out dx,al

      mov al,1
      out dx,al
   end;

   // On se glande la nouille
   for i:=0 to BD2 do a:=0;

   asm
      mov al,5
      out dx,al

      mov al,85
      out dx,al
   end;

   // On se glande la nouille
   for i:=0 to BD10 do a:=0;
end;

procedure LineRead(BD2,BD10:Integer;var ImgInt:PTabImgInt);
var
   LocalAdress:Word;
   nbBits,i,a,w:Integer;           //J'ai ajouté la possibilité de choisir le nombre de bits
                            //a lire.
   BD1,BD5:Integer;
 //  unsigned short   DoubleOctetDeDonnee; //On récupère les données d'un pixel
                                          //pour les stocker dans un octet(16bits)
   DoubleOctetDeDonnee:SmallInt;
   label misspix;
begin
   LocalAdress:=Adress;
//    unsigned short   Image[707][499]; //ça c'est la matrice dans laquelle
                                      //on va mettre les pixels lus

   BD1:=BD2 div 2;
   BD5:=BD1*5;

    //Et c'est partie...
   asm
      mov dx,LocalAdress
      mov al,85
      out dx,al
   end;

   for y:=0 to 9 do    //On efface les lignes factices
      begin
      asm
         mov dx,LocalAdress
         mov al,5
         out dx,al

         mov al,1
         out dx,al
      end;

      // On se glande la nouille
      for i:=0 to BD2 do a:=0;

      asm
         mov al,5
         out dx,al
      end;

      // On se glande la nouille
      for i:=0 to BD5 do a:=0;

      asm
         mov al,85
         out dx,al
      end;
      end;

   for w:=0 to 1414 do   //On efface le registre horiontal
      begin
      asm
         mov dx,LocalAdress
         mov al,5     //On envoi la charge du pixel vers la sortie
         out dx,al
      end;

      // On se glande la nouille
      for i:=0 to BD2 do a:=0;

      asm
         mov al,39    //Raz de la porte de sortie
         out dx,al

         mov al,69
         out dx,al

         mov al,85    //Pixel suivant près
         out dx,al
      end;

      // On se glande la nouille
      for i:=0 to BD2 do a:=0;
      end;

   if not OSiSNT then
      asm
         cli
      end; //On désactive les interruptions

// 660x494
//   for z:=0 to 499 do
   for z:=0 to 493 do
      begin
      for y:=0 to 707 do
         begin
         asm
            mov dx,LocalAdress // On transfert l'adresse du port dans le registre 16
                               // bits DX -> Registre de donnée (378h).
            mov al,85          // On met (0101 0101)base 2 dans le registre 8bit AL.
            out dx,al          // On charge le contenu AL sur le port
                               // -> front horl AD + Trigger horl vert à 1 + niveau
                               //    de seuil noir à 1 + Horl horiz à 1.

            mov al,5           // On met (0000 0101)base 2 dans le registre 8bit AL.
            out dx,al          // On charge le contenu AL sur le port
                               // -> front horl AD à 1 + Trigger horl vert à 1.
         end;

         // On se glande la nouille
         for i:=0 to BD2 do a:=0;

         asm
            mov al,7    // On met (0000 0111)base 2 dans le registre 8bit AL
            out dx,al   // On charge le contenu AL sur le port
                        // -> front horl AD à 1 + AD read à 1 +Trigger
                        //    horl vert à 1.

            mov al,39   // On met (0010 0111)base 2 dans le registre 8bit AL
            out dx,al   // On charge le contenu AL sur le port
                        // -> front horl AD à 1 + AD read à 1 +Trigger horl
                        //    vert à 1 + RAZ de la porte de sortie.

            mov al,69   // On met (0100 0101)base 2 dans le registre 8bit AL
            out dx,al   // On charge le contenu AL sur le port
                        // -> front horl AD à 1 + Trigger horl vert à 1 +
                        //    Horl Horiz à 1.
         end;

         // On se glande la nouille
         for i:=0 to BD2 do a:=0;

         asm
            mov al,85   // On met (0101 0101)base 2 dans le registre 8bit AL
            out dx,al   // On charge le contenu AL sur le port
                        // -> front horl AD + Trigger horl vert à 1 +
                        //    niveau de seuil noir à 1 + Horl horiz à 1.
         end;

//         if y<19 then goto misspix;
//         if y>678 then goto misspix;
         if y<19 then continue;
         if y>678 then continue;

         //***************************
         //* Routine de lecture A/N  *
         //***************************

         asm
            mov     cx,0            // Le registre 16bits CX va servir de tampon on le met à zero
            mov     dx,LocalAdress  // On transfert l'adresse du port dans le registre 16 bit DX
            mov     al,84           // On met (0101 0100)base 2 dans le registre 8bit AL
            out     dx,al           // On transfert le contenu du registre AL à l'adresse du port
                                    // -> front horl AD + Trigger horl vert à 1 + niveau de
                                    // seuil noir à 1.
            mov     bx,16           // On charge le registre 16 bit BX avec 16 pour compter
                                    // les bits.
         end;

//            _BX=nbBits;      //Le nombre de bits à lire devient paramètrable

// Etiquette loop1
         asm
         @loop1:
            inc     dx          // On incremente l'adresse du port -> Registre d'état (379h)
            in      al,dx       // On récupère le contenu du port dans AL
            test    al,32       // On test le bit D5 -> data output
            jz      @nochange   // si test retourne zero -> RETOUR A NO_CHANGE
            inc     cx          // Sinon on incrémente CX (on pointe le bit suivant)

// Etiquette no_change
         @nochange:

            add cx,cx          // On additionne CX à lui même.
            dec dx             // On décremente l'adresse du port -> Registre de donnée (378h)
            mov al,85          // On met (0101 0101)base 2 dans le registre 8bit AL
            out dx,al          // On charge le contenu AL sur le port
                               // -> front horl AD + Trigger horl vert à 1 +
                               //    niveau de seuil noir à 1 + Horl horiz à 1
            dec al             // On decremente AL
            out dx,al          // On charge le contenu d'AL sur le port soit 84
                               // -> (0010 0000)base 2
                               // -> seul Horl horiz passe à zéro
            dec bx             // On décrémente BX qui sert de compteur allant de 16 à zéro
            jnz @loop1         // Si BX n'est pas à zéro -> RETOUR A LOOP1

// !mov Databyte??,cx
// @imarray = @dataptr
// incr imarray
            mov DoubleOctetDeDonnee,cx  // On peut maintenant récupérer le pixel
                                        // contenu dans CX
         end;

// @imarray = @dataptr
// incr imarray
//            Image[y][z] = DoubleOctetDeDonnee<<(16-nbBits); //On met la valeur dans l'image
//         ImgInt^[1]^[z+1]^[y+1]:=DoubleOctetDeDonnee; //On met la valeur dans l'image
         ImgInt^[1]^[z+1]^[y-18]:=DoubleOctetDeDonnee; //On met la valeur dans l'image

// Etiquette misspix
         misspix:
         end;


      asm
         mov dx,LocalAdress
         mov al,5
         out dx,al

         mov al,1
         out dx,al
      end;

      // On se glande la nouille
      for i:=0 to BD2 do a:=0;

      asm
         mov al,5
         out dx,al

         mov al,85
         out dx,al
      end;

      // On se glande la nouille
      for i:=0 to BD5 do a:=0;

      end;

   if not OSiSNT then
      asm
         sti
      end;
end;

//660 x 494 pixel images from a (larger than average) 4.9 x 3.6mm chip
function PluginGetXSize:Integer; cdecl;
// Here you must provide x size of the CCD chip in pixels
begin
Result:=660; // To modify
end;

function PluginGetYSize:Integer; cdecl;
// Here you must provide y size of the CCD chip in pixels
begin
Result:=494; // To modify
end;

procedure PluginSetPort(_Adress:Word); cdecl;
// TeleAuto gives you here the adress of the // port given by the user
begin
Adress:=_Adress;
end;

function PluginSetWindow(_x1,_y1,_x2,_y2:Integer):Boolean; cdecl;
// TeleAuto gives you here the window to use for the exposure
begin
if (_x1>0) and (_x2>0) and (_x1<PluginGetXSize+1) and (_x2<PluginGetXSize+1) and
   (_y1>0) and (_y2>0) and (_y1<PluginGetYSize+1) and (_y2<PluginGetYSize+1) and
   (_x2>_x1) and (_y2>_y1) then
   begin
   x1:=_x1;
   y1:=_y1;
   x2:=_x2;
   y2:=_y2;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetBinning(_Binning:Integer):Boolean; cdecl;
// TeleAuto gives you here the binning to use for the exposure
begin
if (_Binning=1) or (_Binning=2) or (_Binning=3) or (_Binning=4) then
   begin
   Binning:=_Binning;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetPose(_Pose:Double):Boolean; cdecl;
// TeleAuto gives you here the pose to use for the exposure in seconds
begin
if (_Pose>0) and (_Pose<50331.645) then
   begin
   Pose:=_Pose;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetEmptyingDelay(_EmptyingDelay:Double):Boolean; cdecl;
// TeleAuto gives you here the time taken to empty the CCD chip if given by the user
begin
if (_EmptyingDelay>0) then
   begin
   EmptyingDelay:=_EmptyingDelay;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetReadingDelay(_ReadingDelay:Double):Boolean; cdecl;
// TeleAuto gives you here the reading delay to slow down the // port speed (Hisis 22)
begin
if (_ReadingDelay>0) then
   begin
   ReadingDelay:=_ReadingDelay;
   Result:=True;
   end
else Result:=False;
end;

function PluginSetShutterCloseDelay(Delay:Double):Boolean; cdecl;
// TeleAuto gives you here the closing delay of the shutter (Audine/Genesis with R. David shutter)
begin
if (Delay>0) then
   begin
   ShutterCloseDelay:=Delay;
   Result:=True;
   end
else Result:=False;
end;

function PluginIsConnectedAndOK:Boolean; cdecl;
// Here you must provide a function used by TeleAuto to know if the CCD camera is connected and operating
// Return true if everything is OK
begin
Result:=True;
end;

function PluginOpen:Boolean; cdecl;
// Here you must put the instruction needed to initialise the CCD camera before to use it
// This procedure is used only when connecting the CCD camera to TeleAuto
var
   Time:Integer;
begin
Result:=True;
Time:=TimeTest;   // Find delay value for computer
BD1:=Time;
BD2:=Time*2;
BD10:= Time*10;
end;

procedure PluginClose; cdecl;
// Here you must put the instruction needed to close the CCD camera after using it
// This procedure is used only when disconnecting the CCD camera to TeleAuto
begin

end;

function PluginStartPose:Boolean; cdecl;
// Here you must put the instruction needed to start the pose
// The variables to use here are
//    Adress:Word;
//    x1,y1,x2,y2:Integer;
//    Sx,Sy:Integer;
//    Pose:Double;
//    Binning:Integer;
// Return true if everything is OK
begin
Wiper(BD2);
ClearVert(BD2,BD10);

// You can now call to the TeleAuto function giving precise hour
// TeleAuto will correct this time to save the middle exposure time in the image file
// You save the begining of the exposure to give it to TeleAuto later
GetHour(YearBegin,MonthBegin,DayBegin,HourBegin,MinBegin,SecBegin,MSecBegin);

Result:=True;
end;

function PluginStopPose:Boolean; cdecl;
// Here you must put the code to stop the exposure before the normal end given
// in the PluginStartPose function
// Return true if everything is OK
begin
Result:=True;
end;

function PluginReadCCD(TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; cdecl;
// Here you meux provide the image in a PTabImgInt form
// You must not allocate memory for the TabImgInt because it is already done in TeleAuto
// Return true if everything is OK
var
   i,j,sx1,sy1:Integer;
begin
Result:=True;

Reader(BD2,BD10);
LineRead(BD2,BD10,TabImgInt);

// Y)ou can now call the TeleAuto function giving precise hour
// TeleAuto will correct this time to save the middle exposure time in the image file
// Save the end of the exposure to give it to TeleAuto later
GetHour(YearEnd,MonthEnd,DayEnd,HourEnd,MinEnd,SecEnd,MSecEnd);
end;

// Old PluginGetCCDDate / New in Version 2.8
procedure PluginGetCCDDateBegin(var Year,Month,Day:Word); cdecl;
// Here you must provide the date of the begin of the exposure
begin
Year:=YearBegin;
Month:=MonthBegin;
Day:=DayBegin;
end;

// Old PluginGetCCDTime / New in Version 2.8
procedure PluginGetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); cdecl;
// Here you must provide the time of the begin of the exposure
begin
Hour:=HourBegin;
Min:=MinBegin;
Sec:=SecBegin;
MSec:=MSecBegin;
end;

// New in Version 2.8
procedure PluginGetCCDDateEnd(var Year,Month,Day:Word); cdecl;
// Here you must provide the date of the end of the exposure
begin
Year:=YearEnd;
Month:=MonthEnd;
Day:=DayEnd;
end;

// New in Version 2.8
procedure PluginGetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); cdecl;
// Here you must provide the time of the end of the exposure
begin
Hour:=HourEnd;
Min:=MinEnd;
Sec:=SecEnd;
MSec:=MSecEnd;
end;

// New in Version 2.8
procedure PluginSetHourServer(ServerAdress:Pointer); cdecl;
begin
// This is the adress of the TeleAuto function giving precise hour
@GetHour:=ServerAdress;
end;

function PluginGetTemperature:Double; cdecl;
// Here you provide the CCD temperature of the CCD camera
begin
// Cool this virtual camera ! Should give great images !
Result:=-40;
end;

procedure PluginSetTemperature(TargetTemperature:Double); cdecl;
// Here you send the setpoint temperature TargetTemperature provided by TeleAuto
// to the CCD camera
begin

end;

procedure PluginSetPCMinusUT(_PCMinusUT:Double); cdecl;
// Here you get the difference between the hour of the PC and the UT hour
// You an use this value to correct the PC date and hour before to give it to TeleAuto
begin
PCMinusUT:=_PCMinusUT;
end;

procedure PluginAmpliOn; cdecl;
// Here you put the code to switch on the CCD output amplifier
begin

end;

procedure PluginAmpliOff; cdecl;
// Here you put the code to switch off the CCD output amplifier if needed
begin

end;

procedure PluginShutterOpen; cdecl;
// Here you put the code to open the CCD shutter if needed
begin

end;

procedure PluginShutterClosed; cdecl;
// Here you put the code to close the CCD shutter if needed
begin

end;

procedure PluginShutterSynchro; cdecl;
// Here you put the code to synchronise the CCD shutter with the exposure if needed
begin

end;

function PluginGetName:PChar; cdecl;
// Here you must provide then name of the camera
begin
Result:='HX516'; // To modify
end;

// 16 bit data output
function PluginGetSaturationLevel:Integer; cdecl;
// Here you must provide the saturation level of your camera
begin
Result:=32767; // To modify
end;

//7.4 x 7.4uM
function PluginGetXPixelSize:Double; cdecl;
// Here you must provide the x size of the CCD chip pixel
begin
Result:=7.4; // To modify
end;

//7.4 x 7.4uM
function PluginGetYPixelSize:Double; cdecl;
// Here you must provide the y size of the CCD chip pixel
begin
Result:=7.4; // To modify
end;

function PluginGetNbplans:Integer; cdecl;
// Here you must provide the number of color plane for the image
begin
Result:=1;
end;

function PluginGetTypeData:Integer; cdecl;
// Here you must provide the image data type :
// 2 for single plane 16 bits integer.
// 7 for three plane color image with 16 bits integer each plane.
begin
Result:=2;
end;

function PluginIsAValidBinning(Binning:Byte):Boolean; cdecl;
// Here you must return true if the value of Binning is a valid binning value
// Only 1,2,3 and 4 are valid. 3 replace 4 if it exists
begin
if (Binning=1) or (Binning=2) or (Binning=3) then Result:=True // To modify
else Result:=False;
end;

function PluginHasTemperature:Boolean; cdecl;
// Here you must return true if CCD camera has CCD chip temperature information
begin
Result:=False; // To modify
end;

function PluginCanCutAmpli:Boolean; cdecl;
// Here you can return true if the output amplifier of the CCD camera can be cut during
// exposure
begin
Result:=False; // To modify
end;

function PluginGetDelayToSwitchOffAmpli:Double; cdecl;
// Here you return the delay between the beginning of the exposure and the
// switch off of the output of the amplifier in seconds
begin
Result:=1; // To modify
end;

function PluginGetDelayToSwitchOnAmpli:Double; cdecl;
// Here you return the delay betwenn the switch on of the output of the amplifier
// and the end of the exposure in seconds
begin
Result:=4; // To modify
end;

function PluginNeedEmptyingDelay:Boolean; cdecl;
// Here you return true if you need to know the emptying delay of the CCD camera
// provided by the user
begin
Result:=False; // To modify
end;

function PluginNeedReadingDelay:Boolean; cdecl;
// Here you return true if you need to know the reading delay of the CCD camera
// provided by the user
begin
Result:=False; // To modify
end;

function PluginNeedCloseShutterDelay:Boolean; cdecl;
// Here you return true if you need to know the closing delay of the shutter
// provided by the user
begin
Result:=False; // To modify
end;

function PluginHasAShutter:Boolean; cdecl;
// Here you return true if the CCD has a shutter
begin
Result:=False; // To modify
end;

// New in version 2.96
function PluginIs16Bits:Boolean; cdecl;
// Here you return true if the CCD has a 16 bits ADC
begin
Result:=False; // To modify
end;

// New in Version 2.8
procedure PluginIsUsedUnderNT; cdecl;
// Now you know TA is used on NT/2000/XP OS with PortTalk
// You must not use cli/sti assembleur functions to stop interruptions
// Exemple :
// if not OSiSNT then asm cli end;
begin
OSiSNT:=True;
end;

// New in Version 2.8
procedure PluginIsNotUsedUnderNT; cdecl;
// Now you know TA is not used on NT/2000/XP OS with PortTalk
// You can use cli/sti assembleur functions to stop interruptions
begin
OSiSNT:=False;
end;

// New in Version 2.98
function PluginHasCfgWindow:Boolean; cdecl;
// Here you must return true if this plugin can display a configuration window
begin
Result:=False; // To modify
end;

// New in Version 2.98
function PluginShowCfgWindow:Boolean; cdecl;
// Here you can show the custom configuration window
begin
Result:=True;
end;

exports

PluginSetPort,
PluginSetWindow,
PluginSetBinning,
PluginSetPose,
PluginSetEmptyingDelay,
PluginSetReadingDelay,
PluginSetShutterCloseDelay,
PluginIsConnectedAndOK,
PluginOpen,
PluginClose,
PluginStartPose,
PluginSetHourServer,
PluginGetCCDDateBegin,
PluginGetCCDDateEnd,
PluginGetCCDTimeBegin,
PluginGetCCDTimeEnd,
PluginStopPose,
PluginReadCCD,
PluginGetTemperature,
PluginSetTemperature,
PluginSetPCMinusUT,
PluginAmpliOn,
PluginAmpliOff,
PluginShutterOpen,
PluginShutterClosed,
PluginShutterSynchro,
PluginGetName,
PluginGetSaturationLevel,
PluginGetXSize,
PluginGetYSize,
PluginGetXPixelSize,
PluginGetYPixelSize,
PluginGetNbplans,
PluginGetTypeData,
PluginIsAValidBinning,
PluginHasTemperature,
PluginCanCutAmpli,
PluginGetDelayToSwitchOffAmpli,
PluginGetDelayToSwitchOnAmpli,
PluginNeedEmptyingDelay,
PluginNeedReadingDelay,
PluginNeedCloseShutterDelay,
PluginHasAShutter,
PluginIsUsedUnderNT,
PluginIsNotUsedUnderNT,
PluginIs16Bits,
PluginHasCfgWindow,
PluginShowCfgWindow;

begin
end.
