unit u_telescopes;

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

uses SysUtils, Windows, u_meca, Dialogs, Forms;

type

//******************************************************************************
//**************************      Telescope Generique     **********************
//******************************************************************************

  TTelescope=class(TObject)
    private
    InReadIntervalTimeout         : DWord;
    InReadTotalTimeoutMultiplier  : DWord;
    InReadTotalTimeoutConstant    : DWord;
    InWriteTotalTimeoutMultiplier : DWord;
    InWriteTotalTimeoutConstant   : DWord;

    public
    // Port Serie
    NomCom                      : string;
    AdressComStr                : string;
    AdressCom                   : word;
    HCom                        : Integer;
    BaudRate                    : DWord;
    ByteSize                    : Byte ;
    Parity                      : Byte ;
    StopBits                    : Byte ;
    IsInLongFormat              : Boolean;
    Speed                       : Integer;
    InternalError               : Byte;
    Busy                        : Boolean; // Le scope est il occupe ??? 

    // Fonctionnement
    constructor Create;
    function  IsConnectedAndOK:Boolean; virtual; abstract;
    function Open:Boolean; virtual; abstract;
    procedure Close; virtual; abstract;
    function GetError:string;

    // Reglages
    procedure SetComPort(ComPort:string); virtual; abstract;
    procedure SetComAdress(ComAdress:string); virtual; abstract;
    procedure SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                   _ReadTotalTimeoutMultiplier:DWord;
                                   _ReadTotalTimeoutConstant:DWord;
                                   _WriteTotalTimeoutMultiplier:DWord;
                                   _WriteTotalTimeoutConstant:DWord); virtual; abstract;
    procedure SetSerialPortComm(_BaudRate:DWord;
                                _ByteSize:Byte;
                                _Parity:Byte;
                                _StopBits:Byte); virtual; abstract;

    function Getpos(var Alpha,Delta:Double):Boolean; virtual;
    function GotoAlphaDelta(Alpha,Delta:Double):Boolean; virtual;
    function Pointe(AlphaFin,DeltaFin:double):Boolean;
    function WaitPoint(Alpha,Delta:Double):Boolean;
    function GotoRaDec(Alpha,Delta:string):Boolean;
    function Sync(Alpha,Delta:Double):Boolean; virtual;
    function ToggleLongFormat:Boolean; virtual; abstract;
    function IsLongFormat:Boolean; virtual; abstract;
    function StartMotion(Direction:string):Boolean; virtual; abstract;
    function StopMotion(Direction:string):Boolean; virtual; abstract;
    function SetSpeed(Speed:Integer):Boolean; virtual; abstract;
    function Quit:Boolean; virtual; abstract;
//    function MotionRate(Rate:string):Boolean; virtual; abstract;
    function MotionRate(ButtonNumber:Integer):Boolean; virtual; abstract;
    function IsBusy:Boolean; virtual; abstract;

    // Caracteristiques
    function CanGoToShortFormat:Boolean; virtual; abstract;
    function CanSetSpeed:Boolean; virtual; abstract;
    function GetGuideSpeed:Double; virtual; abstract;
    function NeedComName:Boolean; virtual; abstract;
    function NeedComTimeOuts:Boolean; virtual; abstract;
    function NeedComComm:Boolean; virtual; abstract;
    function NeedComAdress:Boolean; virtual; abstract;
    function StoreCoordinates:Boolean; virtual; abstract;
    function IsGoto:Boolean; virtual; abstract;
    function NumberOfSpeedButtons:Integer; virtual; abstract;
    function CaptionOfSpeedButtonNumber(Number:Integer):PChar; virtual; abstract;
    function GetTrackSpeedNumber:Integer; virtual; abstract;
    function GetCenterSpeedNumber:Integer; virtual; abstract;
    function GetName:PChar; virtual; abstract;
    end;

//******************************************************************************
//**************************        Telescope LX200       **********************
//******************************************************************************

  TTelescopeLX200=class(TTelescope)
    public
    // Fonctionnement
    constructor Create;
    function  IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;

    // Reglages
    procedure SetComPort(ComPort:string); override;
    procedure SetComAdress(ComAdress:string); override;
    procedure SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                   _ReadTotalTimeoutMultiplier:DWord;
                                   _ReadTotalTimeoutConstant:DWord;
                                   _WriteTotalTimeoutMultiplier:DWord;
                                   _WriteTotalTimeoutConstant:DWord); override;
    procedure SetSerialPortComm(_BaudRate:DWord;
                                _ByteSize:Byte;
                                _Parity:Byte;
                                _StopBits:Byte); override;

    function Getpos(var Alpha,Delta:Double):Boolean; override;
    function GotoAlphaDelta(Alpha,Delta:Double):Boolean; override;
    function Sync(Alpha,Delta:Double):Boolean; override;
    function ToggleLongFormat:Boolean; override;
    function IsLongFormat:Boolean; override;
    function StartMotion(Direction:string):Boolean; override;
    function StopMotion(Direction:string):Boolean; override;
    function SetSpeed(Speed:Integer):Boolean; override;
    function Quit:Boolean; override;
//    function MotionRate(Rate:string):Boolean; override;
    function MotionRate(ButtonNumber:Integer):Boolean; override;
    function IsBusy:Boolean; override;

    // Caracteristiques
    function CanGoToShortFormat:Boolean; override;
    function CanSetSpeed:Boolean; override;
    function GetGuideSpeed:Double; override;
    function NeedComName:Boolean; override;
    function NeedComTimeOuts:Boolean; override;
    function NeedComComm:Boolean; override;
    function NeedComAdress:Boolean; override;
    function StoreCoordinates:Boolean; override;
    function IsGoto:Boolean; override;
    function NumberOfSpeedButtons:Integer; override;
    function CaptionOfSpeedButtonNumber(Number:Integer):PChar; override;
    function GetTrackSpeedNumber:Integer; override;
    function GetCenterSpeedNumber:Integer; override;
    function GetName:PChar; override;        
    end;

//******************************************************************************
//**************************   Telescope Coordinate III   **********************
//******************************************************************************

  TTelescopeC3=class(TTelescope)
    public
    // Fonctionnement
    constructor Create;
    function  IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;

    // Reglages
    procedure SetComPort(ComPort:string); override;
    procedure SetComAdress(ComAdress:string); override;    
    procedure SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                   _ReadTotalTimeoutMultiplier:DWord;
                                   _ReadTotalTimeoutConstant:DWord;
                                   _WriteTotalTimeoutMultiplier:DWord;
                                   _WriteTotalTimeoutConstant:DWord); override;
    procedure SetSerialPortComm(_BaudRate:DWord;
                                _ByteSize:Byte;
                                _Parity:Byte;
                                _StopBits:Byte); override;

    function Getpos(var Alpha,Delta:Double):Boolean; override;
    function GotoAlphaDelta(Alpha,Delta:Double):Boolean; override;
    function Sync(Alpha,Delta:Double):Boolean; override;
    function ToggleLongFormat:Boolean; override;
    function IsLongFormat:Boolean; override;
    function StartMotion(Direction:string):Boolean; override;
    function StopMotion(Direction:string):Boolean; override;
    function SetSpeed(Speed:Integer):Boolean; override;
    function Quit:Boolean; override;
//    function MotionRate(Rate:string):Boolean; override;
    function MotionRate(ButtonNumber:Integer):Boolean; override;
    function IsBusy:Boolean; override;

    // Caracteristiques
    function CanGoToShortFormat:Boolean; override;
    function CanSetSpeed:Boolean; override;
    function GetGuideSpeed:Double; override;
    function NeedComName:Boolean; override;
    function NeedComTimeOuts:Boolean; override;
    function NeedComComm:Boolean; override;
    function NeedComAdress:Boolean; override;
    function StoreCoordinates:Boolean; override;
    function IsGoto:Boolean; override;
    function NumberOfSpeedButtons:Integer; override;
    function CaptionOfSpeedButtonNumber(Number:Integer):PChar; override;
    function GetTrackSpeedNumber:Integer; override;
    function GetCenterSpeedNumber:Integer; override;
    function GetName:PChar; override;    
    end;

//******************************************************************************
//**************************       Telescope Virtuel      **********************
//******************************************************************************

  TTelescopeVirtuel=class(TTelescope)
    public
    // Fonctionnement
    constructor Create;
    function  IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;

    // Reglages
    procedure SetComPort(ComPort:string); override;
    procedure SetComAdress(ComAdress:string); override;    
    procedure SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                   _ReadTotalTimeoutMultiplier:DWord;
                                   _ReadTotalTimeoutConstant:DWord;
                                   _WriteTotalTimeoutMultiplier:DWord;
                                   _WriteTotalTimeoutConstant:DWord); override;
    procedure SetSerialPortComm(_BaudRate:DWord;
                                _ByteSize:Byte;
                                _Parity:Byte;
                                _StopBits:Byte); override;

    function Getpos(var Alpha,Delta:Double):Boolean; override;
    function GotoAlphaDelta(Alpha,Delta:Double):Boolean; override;
    function Sync(Alpha,Delta:Double):Boolean; override;
    function ToggleLongFormat:Boolean; override;
    function IsLongFormat:Boolean; override;
    function StartMotion(Direction:string):Boolean; override;
    function StopMotion(Direction:string):Boolean; override;
    function SetSpeed(Speed:Integer):Boolean; override;
    function Quit:Boolean; override;
//    function MotionRate(Rate:string):Boolean; override;
    function MotionRate(ButtonNumber:Integer):Boolean; override;
    function IsBusy:Boolean; override;

    // Caracteristiques
    function CanGoToShortFormat:Boolean; override;
    function CanSetSpeed:Boolean; override;
    function GetGuideSpeed:Double; override;
    function NeedComName:Boolean; override;
    function NeedComTimeOuts:Boolean; override;
    function NeedComComm:Boolean; override;
    function NeedComAdress:Boolean; override;
    function StoreCoordinates:Boolean; override;
    function IsGoto:Boolean; override;
    function NumberOfSpeedButtons:Integer; override;
    function CaptionOfSpeedButtonNumber(Number:Integer):PChar; override;
    function GetTrackSpeedNumber:Integer; override;
    function GetCenterSpeedNumber:Integer; override;
    function GetName:PChar; override;
    end;

//******************************************************************************
//**************************      Aucun Telescope         **********************
//******************************************************************************

  TTelescopeNone=class(TTelescope)
    public
    // Fonctionnement
    constructor Create;
    function  IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;

    // Reglages
    procedure SetComPort(ComPort:string); override;
    procedure SetComAdress(ComAdress:string); override;
    procedure SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                   _ReadTotalTimeoutMultiplier:DWord;
                                   _ReadTotalTimeoutConstant:DWord;
                                   _WriteTotalTimeoutMultiplier:DWord;
                                   _WriteTotalTimeoutConstant:DWord); override;
    procedure SetSerialPortComm(_BaudRate:DWord;
                                _ByteSize:Byte;
                                _Parity:Byte;
                                _StopBits:Byte); override;

    function Getpos(var Alpha,Delta:Double):Boolean; override;
    function GotoAlphaDelta(Alpha,Delta:Double):Boolean; override;
    function Sync(Alpha,Delta:Double):Boolean; override;
    function ToggleLongFormat:Boolean; override;
    function IsLongFormat:Boolean; override;
    function StartMotion(Direction:string):Boolean; override;
    function StopMotion(Direction:string):Boolean; override;
    function SetSpeed(Speed:Integer):Boolean; override;
    function Quit:Boolean; override;
//    function MotionRate(Rate:string):Boolean; override;
    function MotionRate(ButtonNumber:Integer):Boolean; override;
    function IsBusy:Boolean; override;

    // Caracteristiques
    function CanGoToShortFormat:Boolean; override;
    function CanSetSpeed:Boolean; override;
    function GetGuideSpeed:Double; override;
    function NeedComName:Boolean; override;
    function NeedComTimeOuts:Boolean; override;
    function NeedComComm:Boolean; override;
    function NeedComAdress:Boolean; override;
    function StoreCoordinates:Boolean; override;
    function IsGoto:Boolean; override;
    function NumberOfSpeedButtons:Integer; override;
    function CaptionOfSpeedButtonNumber(Number:Integer):PChar; override;
    function GetTrackSpeedNumber:Integer; override;
    function GetCenterSpeedNumber:Integer; override;
    function GetName:PChar; override;                    
    end;

//******************************************************************************
//**************************        Telescope APGTO       **********************
//******************************************************************************

  TTelescopeAPGTO=class(TTelescopeLX200)
    public
    // Fonctionnement
    constructor Create;

    function GotoAlphaDelta(Alpha,Delta:Double):Boolean; override;
    function Sync(Alpha,Delta:Double):Boolean; override;
//    function MotionRate(Rate:string):Boolean; override;
    function MotionRate(ButtonNumber:Integer):Boolean; override;
    function IsBusy:Boolean; override;

    // Caracteristiques
    function CanGoToShortFormat:Boolean; override;
    function CanSetSpeed:Boolean; override;
    function GetGuideSpeed:Double; override;
    function NeedComName:Boolean; override;
    function NeedComTimeOuts:Boolean; override;
    function NeedComComm:Boolean; override;
    function NeedComAdress:Boolean; override;
    function StoreCoordinates:Boolean; override;
    function IsGoto:Boolean; override;
    function NumberOfSpeedButtons:Integer; override;
    function CaptionOfSpeedButtonNumber(Number:Integer):PChar; override;
    function GetTrackSpeedNumber:Integer; override;
    function GetCenterSpeedNumber:Integer; override;
    function GetName:PChar; override;                    
    end;

//******************************************************************************
//**************************        Interface PISCO       **********************
//******************************************************************************

  TTelescopePISCO=class(TTelescope)
    public
    // Fonctionnement
    constructor Create;
    function  IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;

    // Reglages
    procedure SetComPort(ComPort:string); override;
    procedure SetComAdress(ComAdress:string); override;
    procedure SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                   _ReadTotalTimeoutMultiplier:DWord;
                                   _ReadTotalTimeoutConstant:DWord;
                                   _WriteTotalTimeoutMultiplier:DWord;
                                   _WriteTotalTimeoutConstant:DWord); override;
    procedure SetSerialPortComm(_BaudRate:DWord;
                                _ByteSize:Byte;
                                _Parity:Byte;
                                _StopBits:Byte); override;

    function Getpos(var Alpha,Delta:Double):Boolean; override;
    function GotoAlphaDelta(Alpha,Delta:Double):Boolean; override;
    function Sync(Alpha,Delta:Double):Boolean; override;
    function ToggleLongFormat:Boolean; override;
    function IsLongFormat:Boolean; override;
    function StartMotion(Direction:string):Boolean; override;
    function StopMotion(Direction:string):Boolean; override;
    function SetSpeed(Speed:Integer):Boolean; override;
    function Quit:Boolean; override;
//    function MotionRate(Rate:string):Boolean; override;
    function MotionRate(ButtonNumber:Integer):Boolean; override;
    function IsBusy:Boolean; override;

    // Caracteristiques
    function CanGoToShortFormat:Boolean; override;
    function CanSetSpeed:Boolean; override;
    function GetGuideSpeed:Double; override;
    function NeedComName:Boolean; override;
    function NeedComTimeOuts:Boolean; override;
    function NeedComComm:Boolean; override;
    function NeedComAdress:Boolean; override;
    function StoreCoordinates:Boolean; override;
    function IsGoto:Boolean; override;
    function NumberOfSpeedButtons:Integer; override;
    function CaptionOfSpeedButtonNumber(Number:Integer):PChar; override;
    function GetTrackSpeedNumber:Integer; override;
    function GetCenterSpeedNumber:Integer; override;
    function GetName:PChar; override;
    end;

//******************************************************************************
//**************************      Telescope Autostar    ************************
//******************************************************************************

  TTelescopeAutoStar=class(TTelescope)
    public
    // Fonctionnement
    constructor Create;
    function  IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;

    // Reglages
    procedure SetComPort(ComPort:string); override;
    procedure SetComAdress(ComAdress:string); override;
    procedure SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                   _ReadTotalTimeoutMultiplier:DWord;
                                   _ReadTotalTimeoutConstant:DWord;
                                   _WriteTotalTimeoutMultiplier:DWord;
                                   _WriteTotalTimeoutConstant:DWord); override;
    procedure SetSerialPortComm(_BaudRate:DWord;
                                _ByteSize:Byte;
                                _Parity:Byte;
                                _StopBits:Byte); override;

    function Getpos(var Alpha,Delta:Double):Boolean; override;
    function GotoAlphaDelta(Alpha,Delta:Double):Boolean; override;
    function Sync(Alpha,Delta:Double):Boolean; override;
    function ToggleLongFormat:Boolean; override;
    function IsLongFormat:Boolean; override;
    function StartMotion(Direction:string):Boolean; override;
    function StopMotion(Direction:string):Boolean; override;
    function SetSpeed(Speed:Integer):Boolean; override;
    function Quit:Boolean; override;
//    function MotionRate(Rate:string):Boolean; override;
    function MotionRate(ButtonNumber:Integer):Boolean; override;
    function IsBusy:Boolean; override;

    // Caracteristiques
    function CanGoToShortFormat:Boolean; override;
    function CanSetSpeed:Boolean; override;
    function GetGuideSpeed:Double; override;
    function NeedComName:Boolean; override;
    function NeedComTimeOuts:Boolean; override;
    function NeedComComm:Boolean; override;
    function NeedComAdress:Boolean; override;
    function StoreCoordinates:Boolean; override;
    function IsGoto:Boolean; override;
    function NumberOfSpeedButtons:Integer; override;
    function CaptionOfSpeedButtonNumber(Number:Integer):PChar; override;
    function GetTrackSpeedNumber:Integer; override;
    function GetCenterSpeedNumber:Integer; override;
    function GetName:PChar; override;
    end;

procedure TelescopeConnect;
procedure TelescopeDisconnect;
procedure TelescopeErreurFatale;

var
    Telescope:TTelescope;
    InGetPos:Boolean;

implementation

uses u_general,
     u_file_io,
     u_lang,
     u_class,
     pu_script_builder,
     pu_main,
     math,
     u_constants,
     u_driver_pisco,
     pu_scope,
     u_hour_servers,
     u_modele_pointage,
     pu_anal_modele,
     u_focusers;

//******************************************************************************
//********************** Interface Telescope de haut niveau **********************
//******************************************************************************
// Remplace pop_main.update_telescope
// Choses a faire pour connecter le telescope
procedure TelescopeConnect;
var
DCB:TDCB;
MyMessage:String;
begin
   try
   // Verification si un télescope est branche
   Config.TelescopeBranche:=False;

   // Ou cas ou
   if Config.TypeTelescope>7 then Config.TypeTelescope:=0;

   // Config du télescope
   case Config.TypeTelescope of
      0:Telescope:=TTelescopeNone.Create;
      1:Telescope:=TTelescopeLX200.Create;
      2:Telescope:=TTelescopeC3.Create;
      3:Telescope:=TTelescopeVirtuel.Create;
      4:Telescope:=TTelescopeAPGTO.Create;
      5:Telescope:=TTelescopePISCO.Create;
      6:Telescope:=TTelescopeNone.create;
      7:Telescope:=TTelescopeAutoStar.Create;
      //Penser a mettre a jour procedure Tpop_conf.UdpateScope;            
      end;

   if Telescope.NeedComName then Telescope.SetComPort(Config.TelescopeComPort);
   if Telescope.NeedComAdress then Telescope.SetComAdress(Config.AdresseComPort);
   if Telescope.NeedComTimeOuts then
      Telescope.SetSerialPortTimeOut(config.ReadIntervalTimeout,
                                     config.ReadTotalTimeoutMultiplier,
                                     config.ReadTotalTimeoutConstant,
                                     config.WriteTotalTimeoutMultiplier,
                                     config.WriteTotalTimeoutConstant);
   if Telescope.NeedComComm then Telescope.SetSerialPortComm(9600,8,0,0);

   if Telescope.Open then
      begin
      Config.Telescope:=Telescope.GetName;
      Config.TelescopeBranche:=Telescope.IsConnectedAndOK;
      // Si le scope merde, on ferme le port serie pour un essai de connexion ulterieur
      if Config.TelescopeBranche then
         begin
         if Telescope.StoreCoordinates then
            begin
            if not(Telescope.IsLongFormat) then
               begin // Format long / court -> long
               if Config.UseLongFormat then
                  begin
                  WriteSpy(lang('Le télescope est au format court, passage en format long'));
                  Telescope.ToggleLongFormat;
                  end;
               end
            else
               begin // Format court / long -> court
               if not(Config.UseLongFormat) then
                  begin
                  if Telescope.CanGoToShortFormat then
                     begin
                     WriteSpy(lang('Le télescope est au format long, passage en format court'));
                     Telescope.ToggleLongFormat;
                     end
                  else
                     begin
                     MyMessage:=lang('Ce télescope ne peut pas passer en format court');
                     WriteSpy(MyMessage);
                     MessageDlg(MyMessage,mtError,[mbOK],0);
                     end;
                  end;
               end;
            pop_main.TimerGetPos.Enabled:=True;
            pop_main.Timer2.Enabled:=True;
            ThreadGetPos:=TThreadGetPos.Create;

            Config.GoodPos:=True;
            end;
         end
      else
         begin
         Telescope.Close;
         Telescope.Free;
         Telescope:=TTelescopeNone.Create;
         pop_main.UpdateGUITelescope;
         pop_main.UpDateGUIFocuser;
         Exit;
         end;
      end
   else
      begin
      WriteSpy(lang('Ouverture de la communication impossible avec le télescope'));
      Config.TelescopeBranche:=False;
      end;

   finally
   pop_main.UpdateGUITelescope;
   end;
end;

// Choses à faire pour déconnecter le télescope
procedure TelescopeDisconnect;
begin
   try

   if Config.TelescopeBranche then
      begin
      if Telescope.StoreCoordinates then ThreadGetPos.Terminate;
            
      if Telescope<>nil then
         begin
         Telescope.Close;
         Telescope.Free;
         Telescope:=nil;
         end;
      Config.TelescopeBranche:=False;

      if pop_scope.Visible then
         begin
         pop_scope.Hide;
         pop_main.ToolButton4.Down:=False;
         end;

      // Si le focuseur depends du scope on le ferme aussi sinon, c'est la panique
      if Config.FocuserBranche then
         if Focuser.IsDependantOfTheScope then FocuserDisconnect;
      end;

   pop_main.TimerGetPos.Enabled:=False;
   pop_main.Timer2.Enabled:=False;

   finally
   pop_main.UpdateGUITelescope;
   pop_main.UpDateGUIFocuser;
   end;
end;

// Choses à faire pour arrêter un scope aprés une erreur fatale
procedure TelescopeErreurFatale;
begin
Telescope.Close;
Telescope.Free;
// On peut pas ?
//Telescope:=nil;
Telescope:=TTelescopeNone.Create;
Config.TelescopeBranche:=False;
pop_main.TimerGetPos.Enabled:=False;
pop_main.Timer2.Enabled:=False;
pop_main.UpdateGUITelescope;
pop_main.UpDateGUIFocuser;
end;

//******************************************************************************
//**************************      Telescope Generique     **********************
//******************************************************************************

constructor TTelescope.Create;
begin
inherited Create;
Busy:=False;
end;

// remplacement des classes abstraites par des fonctions vides.
// Sinon le script engine plante
function TTelescope.GotoAlphaDelta(Alpha,Delta:Double):Boolean;
begin
Result:=false;
end;

function TTelescope.GotoRaDec(Alpha,Delta:string):Boolean;
begin
Result:=GotoAlphaDelta(StrToAlpha(Alpha),StrToDelta(Delta));
end;

function TTelescope.Pointe(AlphaFin,DeltaFin:double):Boolean;
var
AlphaDebut,DeltaDebut,Dist,DAlpha,DDelta:Double;
a,b,Azimuth1,Azimuth2,Hauteur1,Hauteur2,Hauteur3:Double;
HauteurFin,AzimuthFin,HauteurDebut,AzimuthDebut:Double;
HauteurTest,AzimuthTest,DHauteur,DAzimuth:Double;
i:Integer;
AH,AHCorrige,AlphaCorrige,DeltaCorrige:Double;
begin
Result:=True;
InternalError:=0;

WriteSpy(lang('Pointe : ')+
   'Pointage du télescope sur '+AlphaToStr(AlphaFin)+'/'+DeltaToStr(DeltaFin));

if Config.GoodPos then
   begin
   AlphaDebut:=Config.AlphaScope;
   DeltaDebut:=Config.DeltaScope;
   WriteSpy(lang('Pointe : ')+
      lang('Debut : Alpha=')+AlphaToStr(AlphaDebut)
      +' Delta='+DeltaToStr(DeltaDebut)); //nolang
   end
else
   begin
   WriteSpy(lang('Le télescope ne veut pas donner sa position'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Le télescope ne veut pas donner sa position'));
   WriteSpy(lang('Pointe : ')+
      lang('Echec de Getpos : Pointage annulé'));
   pop_Main.AfficheMessage(lang('Erreur'),
      lang('Pointe : ')+
         lang('Echec de Getpos : Pointage annulé'));
   Result:=False;
   Exit;
   end;


HauteurFin:=GetElevationNow(AlphaFin,DeltaFin,config.Lat,config.Long);
AzimuthFin:=GetAzimuthNow(AlphaFin,DeltaFin,config.Lat,config.Long);
HauteurDebut:=GetElevationNow(AlphaDebut,DeltaDebut,config.Lat,config.Long);
AzimuthDebut:=GetAzimuthNow(AlphaDebut,DeltaDebut,config.Lat,config.Long);
WriteSpy(lang('Pointe : ')+
   'Hauteur Finale = '+DeltaToStr(HauteurFin));
WriteSpy(lang('Pointe : ')+
   'Azimuth Finale = '+DeltaToStr(AzimuthFin));

//DHauteur:=HauteurFin-HauteurDebut;
//DAzimuth:=AzimuthFin-AzimuthDebut;

// Point final en dessous dz la hauteur mini ?
WriteSpy(lang('Pointe : ')+
   'Hauteur Minimum = '+DeltaToStr(config.HauteurMini));
if HauteurFin<config.HauteurMini then
   begin
   WriteSpy(lang('Pointe : ')+
      lang('Hauteur : ')+FloatToStr(HauteurFin));
   WriteSpy(lang('Pointe : ')+
      lang('Hauteur Mini : ')+FloatToStr(config.HauteurMini));
   WriteSpy(lang('Pointe : ')+
      lang('Objet en dessous de la hauteur mini : Pointage annulé'));
   InternalError:=2;
   Exit;
   end;

// calcul de la hauteur du profil a l'azimuth du point final
Azimuth1:=System.Int(AzimuthFin);
Hauteur1:=pop_main.HauteurPrf[Trunc(Azimuth1)];
Azimuth2:=System.Int(AzimuthFin)+1;
Hauteur2:=pop_main.HauteurPrf[Trunc(Azimuth2)];

a:=(Hauteur2-Hauteur1)/(Azimuth2-Azimuth1);
b:=Hauteur1-a*Azimuth1;

// Hauteur3 = hauteur du profil a l'azimuth du point final
Hauteur3:=a*AzimuthFin+b;

// Point final en dessous du profil ?
if HauteurFin<Hauteur3 then
   begin
   WriteSpy(lang('Pointe : ')+
      lang('Alpha final : ')+AlphaToStr(AlphaFin));
   WriteSpy(lang('Pointe : ')+
      lang('Delta final : ')+DeltaToStr(DeltaFin));
   WriteSpy(lang('Pointe : ')+
      lang('Azimuth finale : ')+FloatToStr(AzimuthFin));
   WriteSpy(lang('Pointe : ')+
      lang('Hauteur finale : ')+FloatToStr(HauteurFin));
   WriteSpy(lang('Pointe : ')+
      lang('Hauteur Profil : ')+FloatToStr(Hauteur3));
   WriteSpy(lang('Pointe : ')+
      lang('Objet en dessous du profil  : Pointage annulé'));
   InternalError:=3;
   Exit;
   end;

// Point final au dessu de delta maxi ?
if DeltaFin>config.DeltaMax then
   begin
   WriteSpy(lang('Pointe : ')+
      lang('Coordonnée Delta = ')+DeltaToStr(DeltaFin)+
      lang(' > Delta Maximum = ')+FloatToStr(config.DeltaMax));
   InternalError:=4;
   Exit;
   end;

if Config.UseModelePointage then
   begin
   AH:=GetHourAngle(GetHourDT,AlphaFin,Config.Long)/15; //Degres -> heure
   AppliqueModele(AH,DeltaFin,AHCorrige,DeltaCorrige,Correction);
   AlphaCorrige:=GetAlphaFromHourAngle(GetHourDT,AHCorrige*15,Config.Long);
   Result:=Telescope.GotoAlphaDelta(AlphaCorrige,DeltaCorrige);
   end
else
   Result:=Telescope.GotoAlphaDelta(AlphaFin,DeltaFin);

WriteSpy(lang('Pointe : ')+
   'Pointage fini : Alpha='+AlphaToStr(AlphaFin)
   +' Delta='+DeltaToStr(DeltaFin)); //nolang
end;

function TTelescope.WaitPoint(Alpha,Delta:Double):Boolean;
var
   Alpha2,Delta2,Alpha1,Delta1:Double;
   i,j:Integer;
   MyMessage:string;
begin
j:=0;
if Config.GoodPos then
   begin
   Alpha1:=Config.AlphaScope;
   Delta1:=Config.DeltaScope;
   WriteSpy(lang('WaitPoint : ')+ //nolang
      lang('Position en cours : Alpha=')+AlphaToStr(Alpha1)
      +' Delta='+DeltaToStr(Delta1)); //nolang
   end
else
   begin
   WriteSpy(lang('Le télescope ne veut pas donner sa position'));
   Result:=False;
   Exit;
   end;

while ((Abs(Alpha-Alpha2)>Config.ErreurPointingAlpha/3600) or
   (Abs(Delta-Delta2)>Config.ErreurPointingDelta/3600)) do
   begin
   Alpha1:=Alpha2;
   Delta1:=Delta2;
   if Config.GoodPos then
      begin
      Alpha2:=Config.AlphaScope;
      Delta2:=Config.DeltaScope;
      WriteSpy(lang('WaitPoint : ')+ //nolang
         lang('Position en cours : Alpha=')+AlphaToStr(Alpha2)
         +' Delta='+DeltaToStr(Delta2)); //nolang
      end
   else
      begin
      WriteSpy(lang('Le télescope ne veut pas donner sa position'));
      Result:=False;
      Exit;
      end;
   // On attends 1 s
   MySleep(1000);

   // Le telescope est il en mouvement
   if (Alpha1-Alpha2=0) and
      (Delta1-Delta2=0) then
      begin
      Inc(j);
      WriteSpy('LX200Goto : '+ //nolang
         lang('Télescope arrêté = ')+IntToStr(j));
      end;

   // Si le telescope n'a pas bouge pendant plus de 5 coups, il est bloque
   if j>5 then
      begin
      Result:=False;
      MyMessage:='LX200Goto : '+ //nolang
         lang('Télescope considéré comme bloqué. Augmentez la tolérance de pointage. Reconnectez le télescope');
      WriteSpy(MyMessage);
      Exit;
      end;
   end;
end;

function TTelescope.Getpos(var Alpha,Delta:Double):Boolean;
begin
Result:=False;
end;

function TTelescope.Sync(Alpha,Delta:Double):Boolean;
begin
Result:=False;
end;

// Gestion des erreurs
function TTelescope.GetError:string;
begin
case InternalError of
   0:Result:='';
   1:Result:=lang('Le télescope refuse les coordonnées car elles sont sous l''horizon');
   2:Result:=lang('Pointage en dessous de la hauteur minimum');
   3:Result:=lang('Pointage en dessous du profil');
   4:Result:=lang('Pointage au dessus de delta maximum');
   end;
end;

//******************************************************************************
//**************************        Telescope LX200       **********************
//******************************************************************************

constructor TTelescopeLX200.Create;
begin
inherited Create;
end;

procedure TTelescopeLX200.SetComPort(ComPort:string);
begin
NomCom:=ComPort;
end;

procedure TTelescopeLX200.SetComAdress(ComAdress:string);
begin
AdressComStr:=ComAdress;
end;

procedure TTelescopeLX200.SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                    _ReadTotalTimeoutMultiplier:DWord;
                                    _ReadTotalTimeoutConstant:DWord;
                                    _WriteTotalTimeoutMultiplier:DWord;
                                    _WriteTotalTimeoutConstant:DWord);
begin
   InReadIntervalTimeout         :=_ReadIntervalTimeout;
   InReadTotalTimeoutConstant    :=_ReadTotalTimeoutMultiplier;
   InReadTotalTimeoutConstant    :=_ReadTotalTimeoutConstant;
   InWriteTotalTimeoutMultiplier :=_WriteTotalTimeoutMultiplier;
   InWriteTotalTimeoutConstant   :=_WriteTotalTimeoutConstant;
end;

procedure TTelescopeLX200.SetSerialPortComm(_BaudRate:DWord;
                                 _ByteSize:Byte;
                                 _Parity:Byte;
                                 _StopBits:Byte);
begin
   BaudRate:=_BaudRate;
   ByteSize:=_ByteSize;
   Parity:=_Parity;
   StopBits:=_StopBits;
end;

function TTelescopeLX200.Open:Boolean;
var
   Errb:Boolean;
   DCB:TDCB;
   CommTimeouts:TCommTimeouts;
   MyTimeOut:TDateTime;
   i:DWord;
   c:Char;
begin
   MyTimeOut:=Time;
   while (PortSerieIsReserve(NomCom)) and (Time<MyTimeOut+0.5/24/3600) do;
   if (Time>=MyTimeOut+0.5/24/3600) then
      begin
      CloseHandle(hCom);
      LiberePortSerie(NomCom);
      WriteSpy(lang('Impossible de libérer le port série ')+NomCom);
      WriteSpy(lang('Je tente de l''ouvrir quand même'));
      end;
   HCom:=CreateFile(PChar(NomCom),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,0,0);
   ReservePortSerie(NomCom);
   Errb:=GetCommState(hCom,DCB);
   if not Errb then
      begin
      WriteSpy(lang('Impossible d''ouvrir le port série ')+NomCom);
      Result:=False;
      Exit;
      end;

   i:=DCB.DCBlength;
   DCB.BaudRate:=BaudRate;
   i:=DCB.Flags;
   i:=DCB.XonLim;
   i:=DCB.XoffLim;
   DCB.ByteSize:=ByteSize;
   DCB.Parity  :=Parity;
   DCB.StopBits:=StopBits;
   c:=DCB.XonChar;
   c:=DCB.XoffChar;
   c:=DCB.EofChar;
   c:=DCB.EvtChar;

   SetCommState(hCom,DCB);
   SetCommMask (hCom,0);

   with CommTimeouts do
      begin
      ReadIntervalTimeout        :=InReadIntervalTimeout        ;  // 0
      ReadTotalTimeoutMultiplier :=InReadTotalTimeoutMultiplier ;  // 0
      ReadTotalTimeoutConstant   :=InReadTotalTimeoutConstant   ;  // 250
      WriteTotalTimeoutMultiplier:=InWriteTotalTimeoutMultiplier;  // 0
      WriteTotalTimeoutConstant  :=InWriteTotalTimeoutConstant  ;  // 500
      end;

   SetCommTimeouts(hCom,CommTimeouts);
end;

procedure TTelescopeLX200.Close;
begin
   FlushFileBuffers(hCom);
   CloseHandle(hCom);
   LiberePortSerie(NomCom);
end;

function TTelescopeLX200.IsConnectedAndOK:Boolean;
var
   Alpha,Delta:Double;
begin
   if GetPos(Alpha,Delta) then Result:=True else Result:=False;
end;

function TTelescopeLX200.Getpos(var Alpha,Delta:Double):Boolean;
var
   S,Line:string;
   AlphaH,AlphaM,AlphaS:Double;
   DeltaD,DeltaM,DeltaS:Double;
   Err,i,j:Integer;

   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;

   LLine,MyMessage:string;
begin
   Busy:=True;
   try

   Result:=True;

   FlushFileBuffers(hCom);

   //Alpha
   BufWrite[0]:='#';BufWrite[1]:=':';BufWrite[2]:='G';BufWrite[3]:='R';BufWrite[4]:='#';

   WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
//   WriteSpy('LX200Getpos : '+ //nolang
//      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<5 then
      begin
      Result:=False;
      MyMessage:='LX200GetPos : '+ //nolang
         'Le télescope n''accepte pas la demande de la coordonnée Alpha';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   if IsInLongFormat then
      begin
      // HH:MM:SS# 9 caracteres
      // BufRead de 0 a 8
      ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesRead);
      for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
//      WriteSpy('LX200Getpos : '+ //nolang
//         lang('Réception de : /')+Line+'/');

// Bon, je vire ces verifs car ca merde avec certaines montures
{      if NumberOfBytesRead=9 then
         begin
         WriteSpy('LX200Getpos : '+ //nolang
            lang('Le télescope répond bien à la demande de la coordonnée Alpha'));
         end;
//      if NumberOfBytesRead<>9 then
      if NumberOfBytesRead<9 then
         begin
         Result:=False;
         MyMessage:='LX200Getpos : '+ //nolang
            lang('Le télescope répond mal à la demande de la coordonnée Alpha');
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;}
      end
   else
      begin
      // HH:MM.S# 8 caracteres
      // BufRead de 0 a 7
      ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesRead);
      for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
//      WriteSpy('LX200Getpos : '+ //nolang
//         lang('Réception de : /')+Line+'/');

// Bon, je vire ces verifs car ca merde avec certaines montures
{      if NumberOfBytesRead=8 then
         begin
         WriteSpy('LX200Getpos : '+ //nolang
            lang('Le télescope répond bien à la demande de la coordonnée Alpha'));
         end;
//      if NumberOfBytesRead<>8 then
      if NumberOfBytesRead<8 then
         begin
         Result:=False;
         Busy:=False;
         MyMessage:='LX200Getpos : '+ //nolang
            lang('Le télescope répond mal à la demande de la coordonnée Alpha');
         WriteSpy(MyMessage);
         Exit;
         end;}
      end;

   if IsInLongFormat then
      begin
      // Alpha : HH:MM:SS#
      SetLength(S,9);
      Move(BufRead[0],S[1],9);

      Val(Copy(S,1,2),AlphaH,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='LX200GetPos : '+ //nolang
            lang('Conversion des heures Alpha impossible : /')+Copy(S,1,2)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;
      Val(Copy(S,4,2),AlphaM,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='LX200GetPos : '+ //nolang
            lang('Conversion des minutes Alpha impossible : /')+Copy(S,4,2)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;
      Val(Copy(S,7,2),AlphaS,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='LX200GetPos : '+ //nolang
            lang('Conversion des dixièmes de minute Alpha impossible : /')+Copy(S,7,2)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;

      Alpha:=(AlphaH+(AlphaM/60)+(AlphaS/3600)); // Heure
      end
   else
      begin
      // Alpha : HH:MM:S#
      SetLength(S,8);
      Move(BufRead[0],S[1],8);

      Val(Copy(S,1,2),AlphaH,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='LX200GetPos : '+ //nolang
            lang('Conversion des heures Alpha impossible : /')+Copy(S,1,2)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;
      Val(Copy(S,4,2),AlphaM,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='LX200GetPos : '+ //nolang
            lang('Conversion des minutes Alpha impossible : /')+Copy(S,4,2)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;
      Val(Copy(S,7,1),AlphaS,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='LX200GetPos : '+ //nolang
            lang('Conversion des dixièmes de minute Alpha impossible : /')+Copy(S,7,1)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;

      Alpha:=(AlphaH+(AlphaM/60)+(AlphaS/600)); // Heure
      end;


   //Delta
   BufWrite[0]:='#';BufWrite[1]:=':';BufWrite[2]:='G';BufWrite[3]:='D';BufWrite[4]:='#';

   WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
//   WriteSpy('LX200Getpos : '+ //nolang
//      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<5 then
      begin
      Result:=False;
      MyMessage:='LX200GetPos : Le télescope n''accepte pas la demande de la coordonnee Delta';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   if IsInLongFormat then
      begin
      // sDD*MM:SS# 10 caracteres
      // BufRead de 9 a 19
      ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesRead);
      for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
//      WriteSpy('LX200Getpos : '+ //nolang
//         lang('Réception de : /')+Line+'/');

// Scope rajoute un d a la fin !
// Bon, je vire ces verifs car ca merde avec certaines montures
{      if NumberOfBytesRead=11 then
         begin
         WriteSpy('LX200Getpos : '+ //nolang
            lang('Le télescope répond bien à la demande de la coordonnée Delta'));
         end;

      if NumberOfBytesRead<11 then
         begin
         Result:=False;
         MyMessage:='LX200GetPos : '+ //nolang
            lang('Le télescope répond mal à la demande de la coordonnée Delta');
         WriteSpy(MyMessage);
         end;}
      end
   else
      begin
      // sDD*MM# 7 caracteres
      // BufRead de 8 a 15
      ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesRead);
      for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
//      WriteSpy('LX200Getpos : '+ //nolang
//         lang('Réception de : /')+Line+'/');

// Bon, je vire ces verifs car ca merde avec certaines montures
{      if NumberOfBytesRead=7 then
         begin
         WriteSpy('LX200Getpos : '+ //nolang
            lang('Le télescope répond bien à la demande de la coordonnée Delta'));
         end;
//      if NumberOfBytesRead<>7 then
      if NumberOfBytesRead<7 then
         begin
         Result:=False;
         MyMessage:=lang('LX200GetPos : Le télescope répond mal à la demande de la coordonnée Delta');
         WriteSpy(MyMessage);
         end;}
      end;

   if IsInLongFormat then
      begin
      // Delta : sDD*MM:SS#
      SetLength(S,10);
      Move(BufRead[0],S[1],10);

      Val(Copy(S,1,3),DeltaD,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='LX200GetPos : '+ //nolang
            lang('Conversion des degrés Delta impossible : /')+Copy(S,10,3)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;
      Val(Copy(S,5,2),DeltaM,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='LX200GetPos : '+ //nolang
            lang('Conversion des minutes Delta impossible : /')+Copy(S,14,2)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;
      Val(Copy(S,8,2),DeltaS,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='LX200GetPos : '+ //nolang
            lang('Conversion des minutes Delta impossible : /')+Copy(S,17,2)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;

      if s[1]='+' then Delta:=DeltaD+(deltaM/60)+(DeltaS/3600) else Delta:=DeltaD-(DeltaM/60)-(DeltaS/3600); // Degre
      end
   else
      begin
      // Delta : sDD*MM#
      SetLength(S,7);
      Move(BufRead[0],S[1],7);

      Val(Copy(S,1,3),DeltaD,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='LX200GetPos : '+ //nolang
            lang('Conversion des degrés Delta impossible : /')+Copy(S,9,3)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;
      Val(Copy(S,5,2),DeltaM,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='LX200GetPos : '+ //nolang
            lang('Conversion des minutes Delta impossible : /')+Copy(S,13,2)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;

      if s[1]='+' then Delta:=DeltaD+(deltaM/60) else Delta:=DeltaD-(DeltaM/60); // Degre
      end;

   finally
   Busy:=False;
   end;
end;

function TTelescopeLX200.GotoAlphaDelta(Alpha,Delta:Double):Boolean;
var
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;

   AlphaH,AlphaM,AlphaS:Integer;
   DeltaD,DeltaM,DeltaS:Integer;
   Sign:Char;
   InterStr:string;

   i,j:Integer;
   Line,MyMessage:string;

   Alpha1,Delta1,Alpha2,Delta2,Dist,Dist1:Double;

   TimeInit:TDateTime;
begin
  Busy:=True;
  Result:=True;
  InternalError:=0;

  try

//  Alpha1:=Config.AlphaScope;
//  Delta1:=Config.DeltaScope;
  // Deja sur les coordonnees
//  if ((Abs(Alpha-Alpha1)<Config.ErreurPointingAlpha/3600) and  // Secondes -> heures
//     (Abs(Delta-Delta1)<Config.ErreurPointingDelta/3600)) then Exit; // Secondes -> degres

//  Dist:=Arccos(Sin(Delta/180*pi)*Sin(Delta1/180*pi)+(Cos(Delta/180*pi)*Cos(Delta1/180*pi)
//           *Cos(Alpha*15/180*pi-Alpha1*15/180*pi)))/pi*180;

   FlushFileBuffers(hCom);

   AlphaH:=Trunc(Alpha);
   AlphaM:=Trunc((Alpha-AlphaH)*60);
   if IsInLongFormat then
      begin
      AlphaS:=Trunc(((Alpha-AlphaH)*60-AlphaM)*60);
      if Delta>=0 then
         begin
         DeltaD:=Trunc(Delta);
         DeltaM:=Trunc((Delta-DeltaD)*60);
         DeltaS:=Trunc(((Delta-DeltaD)*60-DeltaM)*60);
         Sign:='+';
         end
      else
         begin
         DeltaD:=Trunc(-Delta);
         DeltaM:=Trunc((-Delta-DeltaD)*60);
         Sign:='-';
         end;
      end
   else
      begin
      AlphaS:=Trunc(((Alpha-AlphaH)*60-AlphaM)*10);
      if Delta>=0 then
         begin
         DeltaD:=Trunc(Delta);
         DeltaM:=Trunc((Delta-DeltaD)*60);
         Sign:='+';
         end
      else
         begin
         DeltaD:=Trunc(-Delta);
         DeltaM:=Trunc((-Delta-DeltaD)*60);
         Sign:='-';
         end;
      end;

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='S';
   BufWrite[3]:='r';
   BufWrite[4]:=' ';

   // Alpha : /:Sr HH:MM.S#/ ou /:Sr HH:MM:SS#/
//   Str(AlphaH:1,InterStr);         // Marty
   InterStr:=IntToStr(AlphaH);         // Marty
   if AlphaH<10 then
      begin
      BufWrite[5]:='0';
      Inc(i);
      BufWrite[6]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[5]:=InterStr[1];
      Inc(i);
      BufWrite[6]:=InterStr[2];
      Inc(i);
      end;                         // Marty

   BufWrite[7]:=':';
   InterStr:=IntToStr(AlphaM);
//   Str(AlphaM:1,InterStr);
   if AlphaM<10 then
      begin
      BufWrite[8]:='0';
      Inc(i);
      BufWrite[9]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[8]:=InterStr[1];
      Inc(i);
      BufWrite[9]:=InterStr[2];
      Inc(i);
      end;                         // Marty
   BufWrite[10]:=':';
   Inc(i);

   if IsInLongFormat then
      begin
//      Str(AlphaS:2,InterStr);
      InterStr:=IntToStr(AlphaS);
      if AlphaS<10 then
         begin
         BufWrite[11]:='0';
         Inc(i);
         BufWrite[12]:=InterStr[1];
         Inc(I);
         end
      else
         begin
         BufWrite[11]:=InterStr[1];
         Inc(i);
         BufWrite[12]:=InterStr[2];
         Inc(i);
         end;                         // Marty
      BufWrite[13]:='#';
      WriteFile(hCom,BufWrite[0],14,NumberOfBytesWrite,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesWrite);
      for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
      WriteSpy('LX200Goto : '+ //nolang
         lang('Envoi de : /')+Line+'/');

      if NumberOfBytesWrite<14 then
         begin
         Busy:=False;
         Result:=False;
         MyMessage:=lang('LX200Goto : Le télescope refuse les coordonnées Alpha');
         WriteSpy(MyMessage);
         Exit;
         end;
      end
   else
      begin
      InterStr:=IntToStr(AlphaS);
      BufWrite[11]:=InterStr[1];
      BufWrite[12]:='#';

      WriteFile(hCom,BufWrite[0],13,NumberOfBytesWrite,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesWrite);
      for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
      WriteSpy('LX200Goto : '+ //nolang
         lang('Envoi de : /')+Line+'/');

      if NumberOfBytesWrite<13 then
         begin
         Result:=False;
         Busy:=False;
         MyMessage:='LX200Goto : '+ //nolang
            lang('Le télescope refuse les coordonnées Alpha');
         WriteSpy(MyMessage);
         Exit;
         end;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('LX200Goto : '+ //nolang
      lang('Réception de : /')+Line+'/');

// Bon, je vire ces verifs car ca merde avec certaines montures
{   if NumberOfBytesRead=0 then
      begin
      MyMessage:='LX200Goto : '+ //nolang
         lang('Le télescope ne répond pas aux coordonnées Alpha');
      WriteSpy(MyMessage);
      end;
   if BufRead[0]<>'1' then
      begin
      Result:=False;
      MyMessage:='LX200Goto : '+ //nolang
         lang('Le télescope répond mal aux coordonnées Alpha');
      WriteSpy(MyMessage);
      end;}

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='S';
   BufWrite[3]:='d';
   BufWrite[4]:=' ';
   BufWrite[5]:=Sign;
//   Str(DeltaD:1,InterStr);
   InterStr:=IntToStr(DeltaD);

   i:=6;
   if (DeltaD<10) then
      begin
      BufWrite[i]:='0';
      Inc(i);
      BufWrite[i]:=InterStr[1];
      Inc(i);
      end
   else
      begin
      BufWrite[i]:=InterStr[1];
      Inc(i);
      BufWrite[i]:=InterStr[2];
      Inc(i);
      end;
   BufWrite[i]:=#223;
//    BufWrite[i]:='*';
   Inc(i);
//   Str(DeltaM:1,InterStr);
   InterStr:=IntToStr(DeltaM);
   if DeltaM<10 then
      begin
      BufWrite[i]:='0';
      Inc(i);
      BufWrite[i]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[i]:=InterStr[1];
      Inc(i);
      BufWrite[i]:=InterStr[2];
      Inc(i);
      end;

   if IsInLongFormat then
      begin
      BufWrite[i]:=':';
      Inc(i);
//      Str(DeltaS:1,InterStr);
      InterStr:=IntToStr(DeltaS);
      if DeltaS<10 then
         begin
         BufWrite[i]:='0';
         Inc(i);
         BufWrite[i]:=InterStr[1];
         Inc(I);
         end
      else
         begin
         BufWrite[i]:=InterStr[1];
         Inc(i);
         BufWrite[i]:=InterStr[2];
         Inc(i);
         end;
      end;
   BufWrite[i]:='#';
   Inc(i);

   WriteFile(hCom,BufWrite[0],i,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('LX200Goto : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<i then
      begin
      Result:=False;
      Busy:=False;
      MyMessage:='LX200Goto : '+ //nolang
         lang('Le télescope refuse les coordonnées Delta');
      WriteSpy(MyMessage);
      Exit;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('LX200Goto : '+ //nolang
      lang('Réception de : /')+Line+'/');

// Bon, je vire ces verifs car ca merde avec certaines montures
{   if NumberOfBytesRead=0 then
      begin
      Result:=False;
      MyMessage:='LX200Goto : '+ //nolang
         lang('Le télescope ne répond pas aux coordonnées Delta');
      WriteSpy(MyMessage);
      end;
   if BufRead[0]<>'1' then
      begin
      Result:=False;
      MyMessage:='LX200Goto : '+ //nolang
         lang('Le télescope répond mal aux coordonnées');
      WriteSpy(MyMessage);
      end;}

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='M';
   BufWrite[3]:='S';
   BufWrite[4]:='#';
   WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('LX200Goto : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<5 then
      begin
      Result:=False;
      Busy:=False;
      MyMessage:='LX200Goto : '+ //nolang
         lang('Le télescope refuse la demande de déplacement');
      WriteSpy(MyMessage);
      Exit;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On vide
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('LX200Goto : '+ //nolang
      lang('Réception de : /')+Line+'/');

// Bon, je vire ces verifs car ca merde avec certaines montures
{   if NumberOfBytesRead=0 then
      begin
      Result:=False;
      MyMessage:='LX200Goto : '+ //nolang
         lang('Le télescope ne répond pas aux coordonnées');
      WriteSpy(MyMessage);
      end;

   case BufRead[0] of
      '0':WriteSpy('LX200Goto : '+ //nolang
             lang('Le télescope accepte les coordonnées : ')+AlphaToStr(Alpha)+'/'+DeltaToStr(Delta));
      '1':begin
          Result:=False;
          MyMessage:='LX200Goto : '+ //nolang
             'Le télescope refuse les coordonnées car elles sont sous l''horizon';
          WriteSpy(MyMessage);
          end;
      '2':begin
          Result:=False;
          MyMessage:='LX200Goto : '+ //nolang
             lang('Le télescope refuse les coordonnées car elles sont sous la zone critique');
          WriteSpy(MyMessage);
          end;
      else
          begin
          Result:=False;
          MyMessage:='LX200Goto : '+ //nolang
             lang('Le télescope refuse les coordonnées pour raison inconnue : ')+BufRead[0];
          WriteSpy(MyMessage);
          end;
      end;}

   if BufRead[0]='0' then
      begin
// Je vire ca pour l'instant
// A rajouter eventuellement a un niveau superieur
{      GetPos(Alpha2,Delta2);
      i:=0;
      j:=0;
      while ((Abs(Alpha-Alpha2)>Config.ErreurPointingAlpha/3600) or // 6
         (Abs(Delta-Delta2)>Config.ErreurPointingDelta/3600)) //and not(Bloque) // 60
         do
         begin
         Alpha1:=Alpha2;
         Delta1:=Delta2;
         GetPos(Alpha2,Delta2);
         pop_scope.pnl_alpha.Caption:=AlphaToStr(Alpha);
         pop_scope.pnl_delta.Caption:=DeltaToStr(Delta);
         pop_scope.pnl_alpha.Update;
         pop_scope.pnl_delta.Update;
         Application.ProcessMessages;
         // Ca a merdé
         if not(Config.TelescopeBranche) then
            begin
            Inc(i);
            WriteSpy('LX200Goto : '+ //nolang
               lang('Télescope débranché = ')+IntToStr(i));
            end;
         // Si ca a merde plus de 10 fois on arrete
         if i>10 then
            begin
            Result:=False;
            Busy:=False;
            MyMessage:='LX200Goto : '+ //nolang
               lang('Le téléscope ne reponds plus');
            WriteSpy(MyMessage);
            Exit;
            end;
         // On accepte que ca merde
         Config.TelescopeBranche:=True;
         // On attends 1 s
         TimeInit:=Time;
         while Time<TimeInit+1500/1000/60/60/24 do;

         // Le telescope est il en mouvement
         if (Alpha1-Alpha2=0) and
            (Delta1-Delta2=0) then
            begin
            Inc(j);
            WriteSpy('LX200Goto : '+ //nolang
               lang('Télescope arrêté = ')+IntToStr(j));
            end;

         // Si le telescope n'a pas bouge pendant plus de 5 coups, il est bloque
         if j>5 then
            begin
            Result:=False;
            Busy:=False;
            MyMessage:='LX200Goto : '+ //nolang
               lang('Télescope considéré comme bloqué. Augmentez la tolérance de pointage. Reconnectez le télescope');
            WriteSpy(MyMessage);
            Exit;
            end;
         end;}
      end;
   if BufRead[0]='1' then
      begin
      InternalError:=1;
      end;

   finally
   Busy:=False;
   end;
end;

function TTelescopeLX200.Sync(Alpha,Delta:Double):Boolean;
var
   i,j:Integer;
   AlphaH,AlphaM,AlphaS:Integer;
   DeltaD,DeltaM,DeltaS:Integer;
   Sign:Char;
   InterStr:String;

   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   Line,MyMessage:string;
begin
   Busy:=True;
   try
   Result:=True;

   WriteSpy('LX200Sync : '+ //nolang
      lang('Début du réalignement sur ')+AlphaToSTr(Alpha)+'/'+DeltaToStr(Delta));

   FlushFileBuffers(hCom);

   AlphaH:=Trunc(Alpha);
   AlphaM:=Trunc((Alpha-AlphaH)*60);
   if IsInLongFormat then
      begin
      AlphaS:=Trunc(((Alpha-AlphaH)*60-AlphaM)*60);
      if Delta>=0 then
         begin
         DeltaD:=Trunc(Delta);
         DeltaM:=Trunc((Delta-DeltaD)*60);
         DeltaS:=Trunc(((Delta-DeltaD)*60-DeltaM)*60);
         Sign:='+';
         end
      else
         begin
         DeltaD:=Trunc(-Delta);
         DeltaM:=Trunc((-Delta-DeltaD)*60);
         DeltaS:=Trunc(((-Delta-DeltaD)*60-DeltaM)*60);
         Sign:='-';
         end;
      end
   else
      begin
      AlphaS:=Trunc(((Alpha-AlphaH)*60-AlphaM)*10);
      if Delta>=0 then
         begin
         DeltaD:=Trunc(Delta);
         DeltaM:=Trunc((Delta-DeltaD)*60);
         Sign:='+';
         end
      else
         begin
         DeltaD:=Trunc(-Delta);
         DeltaM:=Trunc((-Delta-DeltaD)*60);
         Sign:='-';
         end;
      end;

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='S';
   BufWrite[3]:='r';
   BufWrite[4]:=' ';

   // Alpha : /:Sr HH:MM.S#/ ou /:Sr HH:MM:SS#/
   InterStr:=IntToStr(AlphaH);         // Marty
   if AlphaH<10 then
      begin
      BufWrite[5]:='0';
      Inc(i);
      BufWrite[6]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[5]:=InterStr[1];
      Inc(i);
      BufWrite[6]:=InterStr[2];
      Inc(i);
      end;                         // Marty

   BufWrite[7]:=':';
   InterStr:=IntToStr(AlphaM);
   if AlphaM<10 then
      begin
      BufWrite[8]:='0';
      Inc(i);
      BufWrite[9]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[8]:=InterStr[1];
      Inc(i);
      BufWrite[9]:=InterStr[2];
      Inc(i);
      end;                         // Marty

   BufWrite[10]:=':';
   Inc(i);

   if IsInLongFormat then
      begin
      InterStr:=IntToStr(AlphaS);
      if AlphaS<10 then
         begin
         BufWrite[11]:='0';
         Inc(i);
         BufWrite[12]:=InterStr[1];
         Inc(i);
         end
      else
         begin
         BufWrite[11]:=InterStr[1];
         Inc(i);
         BufWrite[12]:=InterStr[2];
         Inc(i);
         end;
      BufWrite[13]:='#';

      WriteFile(hCom,BufWrite[0],14,NumberOfBytesWrite,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesWrite);
      for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
      WriteSpy('LX200Sync : '+ //nolang
         lang('Envoi de : /')+Line+'/');

      if NumberOfBytesWrite<14 then
         begin
         Result:=False;
         Busy:=False;
         MyMessage:='LX200Sync : '+ //nolang
            lang('Le télescope refuse les coordonnées Alpha');
         WriteSpy(MyMessage);
         Exit;
         end;
      end
   else
      begin
      InterStr:=IntToStr(AlphaS);
      BufWrite[11]:=InterStr[1];
      BufWrite[12]:='#';

      WriteFile(hCom,BufWrite[0],14,NumberOfBytesWrite,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesWrite);
      for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
      WriteSpy('LX200Sync  : '+ //nolang
         lang('Envoi de : /')+Line+'/');

      if NumberOfBytesWrite<14 then
         begin
         Result:=False;
         Busy:=False;
         MyMessage:='LX200Sync : '+ //nolang
            lang('Le télescope refuse les coordonnées Alpha');
         WriteSpy(MyMessage);
         Exit;
         end;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('LX200Sync : '+ //nolang
      lang('Réception de : /')+Line+'/');

// Bon, je vire ces verifs car ca merde avec certaines montures
{   if NumberOfBytesRead=0 then
      begin
      Result:=False;
      MyMessage:='LX200UpDate : '+ //nolang
         lang('Le télescope ne répond pas à la demande de mise à jour Alpha');
      WriteSpy(MyMessage);
      end;
   if BufRead[0]<>'1' then
      begin
      Result:=False;
      MyMessage:='LX200Update : '+ //nolang
         lang('Le télescope répond mal aux coordonnées Alpha');
      WriteSpy(MyMessage);
      end;}

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='S';
   BufWrite[3]:='d';
   BufWrite[4]:=' ';
   BufWrite[5]:=Sign;
   InterStr:=IntToStr(DeltaD);
//   Str(DeltaD:1,InterStr);

   i:=6;
   if (DeltaD<10) then
      begin
      BufWrite[i]:='0';
      Inc(i);
      BufWrite[i]:=InterStr[1];
      Inc(i);
      end
   else
      begin
      BufWrite[i]:=InterStr[1];
      Inc(i);
      BufWrite[i]:=InterStr[2];
      Inc(i);
      end;
   BufWrite[i]:=#223;
//    BufWrite[i]:='*';
   Inc(i);
   InterStr:=IntToStr(DeltaM);
   if DeltaM<10 then
      begin
      BufWrite[i]:='0';
      Inc(i);
      BufWrite[i]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[i]:=InterStr[1];
      Inc(i);
      BufWrite[i]:=InterStr[2];
      Inc(i);
      end;

   if IsInLongFormat then
      begin
      BufWrite[i]:=':';
      Inc(i);

      InterStr:=IntToStr(DeltaS);
      if DeltaS<10 then
         begin
         BufWrite[i]:='0';
         Inc(i);
         BufWrite[i]:=InterStr[1];
         Inc(i);
         end
      else
         begin
         BufWrite[i]:=InterStr[1];
         Inc(i);
         BufWrite[i]:=InterStr[2];
         Inc(i);
         end;
      end;
   BufWrite[i]:='#';
   Inc(i);

   WriteFile(hCom,BufWrite[0],i,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('LX200Sync : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<i then
      begin
      Result:=False;
      Busy:=False;
      MyMessage:='LX200Sync : '+ //nolang
         lang('Le télescope refuse la mise à jour des coordonnées Delta');
      WriteSpy(MyMessage);
      Exit;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('LX200Sync : '+ //nolang
      lang('Réception de : /')+Line+'/');

// Bon, je vire ces verifs car ca merde avec certaines montures
{   if NumberOfBytesRead=0 then
      begin
      Result:=False;
      MyMessage:='LX200Update : '+ //nolang
         lang('Le télescope ne répond pas à la mise à jour des coordonnées Delta');
      WriteSpy(MyMessage);
      end;
   if BufRead[0]<>'1' then
      begin
      Result:=False;
      MyMessage:='LX200Update : '+ //nolang
         lang('Le télescope répond mal à la mise à jour des coordonnées');
      WriteSpy(MyMessage);
      end;}

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='C';
   BufWrite[3]:='M';
   BufWrite[4]:='#';
   WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('LX200Sync : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<5 then
      begin
      Result:=False;
      Busy:=False;
      MyMessage:='LX200Sync : '+ //nolang
         lang('Le télescope refuse la commande de mise à jour');
      WriteSpy(MyMessage);
      Exit;
      end;
   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('LX200Sync : '+ //nolang
      lang('Réception de : /')+Line+'/');

   WriteSpy('LX200Sync : '+ //nolang
      lang('Mise à jour des coordonnées du télescope réussie à ')+
      AlphaToStr(Alpha)+'/'+DeltaToStr(Delta));

   FlushFileBuffers(hCom);

   finally
   Busy:=False;
   end;
end;

function TTelescopeLX200.ToggleLongFormat:Boolean;
var
   BufWrite:array[0..4] of char;
   NumberOfBytesWrite:Cardinal;
   Line,MyMessage:string;
   j:Integer;
begin
   Busy:=True;
   Try
   Result:=True;

   FlushFileBuffers(hCom);

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='U';
   BufWrite[3]:='#';

   WriteFile(hCom,BufWrite[0],4,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('LX200ToggleLongFormat : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<4 then
      begin
      Result:=False;
      MyMessage:='LX200ToggleLongFormat : '+ //nolang
         lang('Le télescope refuse la commande');
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   IsInLongFormat:=not(IsInLongFormat);

   finally
   Busy:=False;
   end;
end;

function TTelescopeLX200.IsLongFormat:Boolean;
var
   S:String;
   Alpha,Delta:Double;
   AlphaH,AlphaM,AlphaS:Double;
   DeltaD,DeltaM:Double;
   Err:Integer;

   BufWrite:array[0..5] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;

   i,j:Integer;
   Line,MyMessage:string;
begin
   Busy:=True;
   try

   Result:=True;

   FlushFileBuffers(hCom);

   //Alpha
   BufWrite[0]:='#';BufWrite[1]:=':';BufWrite[2]:='G';BufWrite[3]:='R';BufWrite[4]:='#';

   WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('LX200IsLongFormat : '+ //nolang
      lang('Envoi de : /')+Line+'/');


   if NumberOfBytesWrite<5 then
      begin
      Result:=False;
      MyMessage:='LX200IsLongFormat : '+ //nolang
         'Le télescope n''accepte pas la demande de la coordonnée Alpha';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('LX200IsLongFormat : '+ //nolang
      lang('Réception de : /')+Line+'/');

// Bon, je vire ces verifs car ca merde avec certaines montures
{   if NumberOfBytesRead=0 then
      begin
      Result:=False;
      MyMessage:='LX200IsLongFormat : '+ //nolang
         lang('Le télescope ne répond pas à la demande de la coordonnée Alpha');
      WriteSpy(MyMessage);
      end;}

   SetLength(S,8);
   Move(BufRead[0],S[1],8);

   if S[6]='.' then
      begin
      Result:=False;
      WriteSpy('LX200IsLongFormat : '+ //nolang
         lang('Le télescope est au format court'));
      IsInLongFormat:=False;
      end
   else
      begin
      WriteSpy('LX200IsLongFormat : '+ //nolang
         lang('Le télescope est au format long'));
      IsInLongFormat:=True;
      end;

   finally
   Busy:=False;
   end;
end;

function TTelescopeLX200.StartMotion(Direction:string):Boolean;
var
   BufWrite:array[0..12] of char;
   NumberOfBytesWrite:Cardinal;
   Line,MyMessage:string;
   j:Integer;
begin
   Busy:=True;
   try

   Result:=True;
      
   FlushFileBuffers(HCom);

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='M';
   if Uppercase(Direction)='E' then BufWrite[3]:='e' else
   if Uppercase(Direction)='W' then BufWrite[3]:='w' else
   if Uppercase(Direction)='N' then BufWrite[3]:='n' else
   if Uppercase(Direction)='S' then BufWrite[3]:='s' else
      begin
      Result:=False;
      WriteSpy('LX200StartMotion : '+ //nolang
         lang('Direction inconnue'));
      Busy:=False;
      Exit;
      end;
   BufWrite[4]:='#';
   WriteFile(HCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('LX200StartMotion : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<>5 then
      begin
      Result:=False;
      MyMessage:='LX200StartMotion : '+ //nolang
         'Le télescope n''accepte pas la demande de déplacement';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   finally
   Busy:=False;
   end;
end;

function TTelescopeLX200.StopMotion(Direction:string):Boolean;
var
   BufWrite:array[0..12] of char;
   NumberOfBytesWrite:Cardinal;
   Line,MyMessage:string;
   j:Integer;
begin
   Busy:=True;

   try

   Result:=True;   

   FlushFileBuffers(HCom);
   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='Q';
   if Uppercase(Direction)='E' then BufWrite[3]:='e' else
   if Uppercase(Direction)='W' then BufWrite[3]:='w' else
   if Uppercase(Direction)='N' then BufWrite[3]:='n' else
   if Uppercase(Direction)='S' then BufWrite[3]:='s' else
      begin
      Result:=False;
      WriteSpy('LX200StopMotion : '+ //nolang
         lang('Direction inconnue'));
      Busy:=False;
      Exit;
      end;
   BufWrite[4]:='#';
   WriteFile(HCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('LX200StopMotion : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<>5 then
      begin
      Result:=False;
      MyMessage:='LX200StopMotion : '+ //nolang
         'Le télescope n''accepte pas la demande d''arrêt';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   finally
   Busy:=False;
   end;
end;

function TTelescopeLX200.SetSpeed(Speed:Integer):Boolean;
var
   BufWrite:array[0..12] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   LLine,StrSpeed,MyMessage:string;
   Line:string;
   j:Integer;
begin
   Busy:=True;
   try

   Result:=True;

   FlushFileBuffers(HCom);

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='S';
   BufWrite[3]:='w';
   StrSpeed:=IntToStr(Speed);
   BufWrite[4]:=StrSpeed[1];
   BufWrite[5]:='#';
   WriteFile(HCom,BufWrite[0],6,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('LX200SetSpeed : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<6 then
      begin
      Result:=False;
      MyMessage:='LX200SetSpeed : '+ //nolang
         'Le télescope n''accepte pas le réglage de vitesse';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('LX200SetSpeed : '+ //nolang
      lang('Réception de : /')+Line+'/');

   finally
   Busy:=False;
   end;

// Bon, je vire ces verifs car ca merde avec certaines montures
{   if NumberOfBytesRead=0 then
      begin
      Result:=False;
      MyMessage:='LX200SetSpeed : '+ //nolang
         lang('Le télescope ne répond pas au réglage de vitesse');
      WriteSpy(MyMessage);
      end;}
end;

function TTelescopeLX200.Quit:Boolean;
var
   BufWrite:array[0..3] of char;
   NumberOfBytesWrite:Cardinal;
   Line,MyMessage:string;
   j:Integer;
begin
   Busy:=True;
   try

   Result:=True;

   FlushFileBuffers(HCom);

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='Q';
   BufWrite[3]:='#';
   WriteFile(HCom,BufWrite[0],4,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('LX200Quit : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<4 then
      begin
      Result:=False;
      MyMessage:='LX200Quit : '+ //nolang
         'Le télescope n''accepte pas la demande d''arrêt';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   finally
   Busy:=False;
   end;
end;

//function TTelescopeLX200.MotionRate(Rate:string):Boolean;
function TTelescopeLX200.MotionRate(ButtonNumber:Integer):Boolean;
var
   BufWrite:array[0..12] of char;
   NumberOfBytesWrite:Cardinal;
   Line,MyMessage:string;
   j:Integer;
begin
   Busy:=False;
   try

   Result:=True;

   FlushFileBuffers(HCom);
   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='R';
   case ButtonNumber of
      1:BufWrite[3]:='S';
      2:BufWrite[3]:='M';
      3:BufWrite[3]:='C';
      4:BufWrite[3]:='G';
   else
      begin
      Result:=False;
      MyMessage:='LX200MotionRate : '+ //nolang
         lang('Vitesse invalide');
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;
      end;

{   if Uppercase(Rate)='S' then BufWrite[3]:='S' else
   if Uppercase(Rate)='F' then BufWrite[3]:='M' else
   if Uppercase(Rate)='M' then BufWrite[3]:='M' else // Syntaxe LX200
   if Uppercase(Rate)='C' then BufWrite[3]:='C' else
   if Uppercase(Rate)='G' then BufWrite[3]:='G' else
      begin
      Result:=False;
      WriteSpy(lang('LX200MotionRate : Vitesse invalide'));
      Busy:=False;
      Exit;
      end;}

   BufWrite[4]:='#';
   WriteFile(HCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('LX200MotionRate : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<>5 then
      begin
      Result:=False;
      MyMessage:='LX200MotionRate : '+ //nolang
         lang('Le télescope refuse le réglage de vitesse');
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   WriteSpy('LX200MotionRate : '+ //nolang
      lang('Vitesse = ')+IntToStr(ButtonNumber));
//      lang('Vitesse = ')+Uppercase(Rate));

   finally
   Busy:=False;
   end;
end;

function TTelescopeLX200.IsBusy:Boolean;
begin
Result:=Busy;
end;

function TTelescopeLX200.CanGoToShortFormat:Boolean;
begin
Result:=True;
end;

function TTelescopeLX200.CanSetSpeed:Boolean;
begin
Result:=True;
end;

function TTelescopeLX200.GetGuideSpeed:Double;
begin
Result:=2;
end;

function TTelescopeLX200.NeedComName:Boolean;
begin
Result:=True;
end;

function TTelescopeLX200.NeedComTimeOuts:Boolean;
begin
Result:=True;
end;

function TTelescopeLX200.NeedComComm:Boolean;
begin
Result:=True;
end;

function TTelescopeLX200.NeedComAdress:Boolean;
begin
Result:=False;
end;

function TTelescopeLX200.StoreCoordinates:Boolean;
begin
Result:=True;
end;

function TTelescopeLX200.IsGoto:Boolean;
begin
Result:=True;
end;

function TTelescopeLX200.NumberOfSpeedButtons:Integer;
begin
Result:=4;
end;

function TTelescopeLX200.CaptionOfSpeedButtonNumber(Number:Integer):PChar;
begin
case Number of
   1:Result:=PChar(lang('Pointer'));
   2:Result:=PChar(lang('Chercher'));
   3:Result:=PChar(lang('Centrer'));
   4:Result:=PChar(lang('Guider'));
   end;
end;

function TTelescopeLX200.GetTrackSpeedNumber:Integer;
begin
Result:=4;
end;

function TTelescopeLX200.GetCenterSpeedNumber:Integer;
begin
Result:=3;
end;

function TTelescopeLX200.GetName:PChar;
begin
Result:=PChar('LX200'); //nolang
end;


//******************************************************************************
//**************************   Telescope Coordinate III   **********************
//******************************************************************************

constructor TTelescopeC3.Create;
begin
   inherited Create;
end;

procedure TTelescopeC3.SetComPort(ComPort:string);
begin
   NomCom:=ComPort;
end;

procedure TTelescopeC3.SetComAdress(ComAdress:string);
begin
   AdressComStr:=ComAdress;
end;

procedure TTelescopeC3.SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                    _ReadTotalTimeoutMultiplier:DWord;
                                    _ReadTotalTimeoutConstant:DWord;
                                    _WriteTotalTimeoutMultiplier:DWord;
                                    _WriteTotalTimeoutConstant:DWord);
begin
   InReadIntervalTimeout         :=_ReadIntervalTimeout;
   InReadTotalTimeoutMultiplier  :=_ReadTotalTimeoutMultiplier;
   InReadTotalTimeoutConstant    :=_ReadTotalTimeoutConstant;
   InWriteTotalTimeoutMultiplier :=_WriteTotalTimeoutMultiplier;
   InWriteTotalTimeoutConstant   :=_WriteTotalTimeoutConstant;
end;

procedure TTelescopeC3.SetSerialPortComm(_BaudRate:DWord;
                                 _ByteSize:Byte;
                                 _Parity:Byte;
                                 _StopBits:Byte);
begin
   BaudRate:=_BaudRate;
   ByteSize:=_ByteSize;
//   Parity:=_Parity;
   Parity:=NOPARITY;
//   StopBits:=_StopBits;
//   StopBits:=1; // Glutte pour tester
   StopBits:=ONESTOPBIT; // Glutte pour tester
end;

function TTelescopeC3.Open:Boolean;
var
   Errb:Boolean;
   DCB:TDCB;
   CommTimeouts:TCommTimeouts;
   MyTimeOut:TDateTime;
//   i:DWord;
//   c:Char;
begin
   MyTimeOut:=Time;
   while (PortSerieIsReserve(NomCom)) and (Time<MyTimeOut+0.5/24/3600) do;
   if (Time>=MyTimeOut+0.5/24/3600) then
      begin
      CloseHandle(hCom);
      LiberePortSerie(NomCom);
      WriteSpy(lang('Impossible de libérer le port série ')+NomCom);
      WriteSpy(lang('Je tente de l''ouvrir quand même'));
      end;
   HCom:=CreateFile(PChar(NomCom),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,0,0);
   ReservePortSerie(NomCom);
   Errb:=GetCommState(hCom,DCB);
   if not Errb then
      begin
      WriteSpy(lang('Impossible d''ouvrir le port série ')+NomCom);
      Result:=False;
      Exit;
      end;

//   i:=DCB.DCBlength;
   DCB.BaudRate:=BaudRate;
//   i:=DCB.Flags;
//   i:=DCB.XonLim;
//   i:=DCB.XoffLim;
   DCB.ByteSize:=ByteSize;
   DCB.Parity  :=Parity;
   DCB.StopBits:=StopBits;

//   c:=DCB.XonChar;
//   c:=DCB.XoffChar;
//   c:=DCB.EofChar;
//   c:=DCB.EvtChar;

   SetCommState(hCom,DCB);
   SetCommMask (hCom,0);

   with CommTimeouts do
      begin
      ReadIntervalTimeout        :=InReadIntervalTimeout        ;  // 0
      ReadTotalTimeoutMultiplier :=InReadTotalTimeoutMultiplier ;  // 0
      ReadTotalTimeoutConstant   :=InReadTotalTimeoutConstant   ;  // 250
      WriteTotalTimeoutMultiplier:=InWriteTotalTimeoutMultiplier;  // 0
      WriteTotalTimeoutConstant  :=InWriteTotalTimeoutConstant  ;  // 500
      end;

   SetCommTimeouts(hCom,CommTimeouts);
end;

procedure TTelescopeC3.Close;
begin
   FlushFileBuffers(hCom);
   CloseHandle(hCom);
   LiberePortSerie(NomCom);
end;

function TTelescopeC3.IsConnectedAndOK:Boolean;
var
   Alpha,Delta:Double;
begin
   if GetPos(Alpha,Delta) then Result:=True else Result:=False;
end;

function TTelescopeC3.Getpos(var Alpha,Delta:Double):Boolean;
var
   S:String;
   AlphaH,AlphaM,AlphaS:Double;
   alpha_h, alpha_m, alpha_s, delta_d, delta_m, delta_s:string;
   DeltaD,DeltaM,deltas:Double;
   Err:Integer;

   BufWrite:array of char;
   BufRead:array[0..len_R] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;

   LLine,MyMessage:String;
begin
   Busy:=True;
   try
{renvoie une string de len_R caracteres : ** RA:10:00:00 DEC:+70:00:00 AB<#13>00 Command accepted}

   Result:=True;

   FlushFileBuffers(hCom);

   //Read Position
   BufWrite[0]:='R';
   bufwrite[1]:=#13;
   setlength(bufwrite,2);
   WriteFile(hCom,BufWrite[0],2,NumberOfBytesWrite,nil);

   // peut pas ecrire
   if NumberOfBytesWrite<>1 then
      begin
      Result:=False;
      MyMessage:='C3GetPos : '+ //nolang
         'Le télescope n''accepte pas la demande de coordonnées';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   // lit z caracteres
   ReadFile(hCom,BufRead[0],len_R,NumberOfBytesRead,nil);

   // peut pas lire
   if NumberOfBytesRead=0 then
   begin
      Result:=False;
      MyMessage:='C3GetPos : '+ //nolang
         lang('Le télescope ne répond pas à la demande de coordonnées');
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
   end;

   // il manque un bout (read <> len_R)
   if NumberOfBytesRead<>len_R then
   begin
      Result:=False;
      MyMessage:='C3GetPos : '+ //nolang
         lang('Le télescope répond mal à la demande des coordonnées');
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
   end;

   SetLength(S,len_R);
   Move(BufRead[0],S[1],len_R);

   {renvoie une string de len_R caracteres : ** RA:10:00:00 DEC:+70:00:00 AB<#13>00 Command accepted
                                             1234567890123456789012345678901234567890123456789012345 }

   // on commence a 6, voire 7 ou 8 selon les espaces
   // faire le formatage en fonction de la longueur de len_R
   // ALPHA
   Val(Copy(S,7,2),AlphaH,Err);
   if Err<>0 then
   begin
      Result:=False;
      MyMessage:='C3GetPos : '+ //nolang
         lang('Conversion des heures Alpha impossible : /')+Copy(S,7,2)+'/';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
   end;

   Val(Copy(S,10,2),AlphaM,Err);
   if Err<>0 then
   begin
      Result:=False;
      MyMessage:='C3GetPos : '+ //nolang
         lang('Conversion des minutes Alpha impossible : /')+Copy(S,10,2)+'/';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
   end;
   Val(Copy(S,13,2),AlphaS,Err);
   if Err<>0 then
   begin
      Result:=False;
      MyMessage:='C3GetPos : '+ //nolang
         lang('Conversion des secondes Alpha impossible : /')+Copy(S,13,2)+'/';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
   end;

   if alphah>9 then alpha_h:=copy(s,7,2) else alpha_h:='0'+copy(s,7,2);
   if alpham>9 then alpha_m:=copy(s,10,2) else alpha_m:='0'+copy(s,10,2);
   if alphas>9 then alpha_s:=copy(s,13,2) else alpha_s:='0'+copy(s,13,2);

   alpha:=strtoalpha(alpha_h+'h'+alpha_m+'m'+alpha_s+'s');
  // Alpha:=(AlphaH+(AlphaM/60)+(AlphaS/3600)); // en Heures

  {renvoie une string de len_R caracteres : ** RA:10:00:00 DEC:+70:00:00 AB<#13>00 Command accepted
                                            1234567890123456789012345678901234567890123456789012345 }
   // DELTA
   Val(Copy(S,21,2),DeltaD,Err);
   if Err<>0 then
   begin
      Result:=False;
      MyMessage:='C3GetPos : '+ //nolang
         lang('Conversion des degrés Delta impossible : /')+Copy(S,21,2)+'/'; // sans le signe !
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
   end;

   Val(Copy(S,24,2),DeltaM,Err);
   if Err<>0 then
   begin
      Result:=False;
      MyMessage:='C3GetPos : '+ //nolang
         lang('Conversion des minutes Delta impossible : /')+Copy(S,24,2)+'/';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
   end;

   Val(Copy(S,27,2),DeltaM,Err);
   if Err<>0 then
   begin
      Result:=False;
      MyMessage:='C3GetPos : '+ //nolang
         lang('Conversion des secondes Delta impossible : /')+Copy(S,27,2)+'/';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
   end;

   // on rajoute le signe ici
   if deltad>9 then delta_d:=s[20]+copy(s,21,2) else delta_d:=s[20]+'0'+copy(s,21,2);
   if deltam>9 then delta_m:=copy(s,24,2) else delta_m:='0'+copy(s,24,2);
   if deltas>9 then delta_s:=copy(s,27,2) else delta_s:='0'+copy(s,27,2);

   //if s[9]='+' then Delta:=DeltaD+(deltaM/60)+(deltas/3600) else Delta:=DeltaD-(DeltaM/60); // Degre
   delta:=strtodelta(delta_d+'d'+delta_m+'m'+delta_s+'s');

   WriteSpy('C3GetPos : '+ //nolang
      lang('Le télescope est à ')+AlphaToStr(Alpha)+'/'+DeltaToStr(Delta));

   finally
   Busy:=False;
   end;
end;

function TTelescopeC3.GotoAlphaDelta(Alpha,Delta:Double):Boolean;
var
NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
BufWrite:array of char;
BufRead:array[0..Len_X] of char;

alpha_str,delta_str,final:string;
Sign:Char;
InterStr:string;

i,j:Integer;
s,MyMessage:string;
there,bloque,tracking:boolean;


Alpha1,Delta1,Alpha2,Delta2:Double;

TimeInit:TDateTime;
begin
   Busy:=True;
   try

   Result:=True;

//   Alpha1:=Config.AlphaScope;
//   Delta1:=Config.DeltaScope;

   // Deja sur les coordonnees
//   if ((Abs(Alpha-Alpha1)<Config.ErreurPointingAlpha/3600) and
//      (Abs(Delta-Delta1)<Config.ErreurPointingDelta/3600)) then Exit;

   FlushFileBuffers(hCom);

   // on construit la string
   // ALPHA
   alpha_str:=alphatostr(alpha);
   alpha_str[3]:=':';
   alpha_str[6]:=':';
   alpha_str:=copy(alpha_str,1,8);
   // DELTA
   delta_str:=deltatostr(delta);
   delta_str[4]:=':';
   delta_str[7]:=':';
   delta_str:=copy(delta_str,1,9);
   // final
   final:='XRA:'+alpha_str+' DEC:'+delta_str+#13; //nolang
   for i:=0 to length(final)-1 do bufwrite[i]:=final[i+1];
   setlength(bufwrite,length(final));

   // on ecrit la commande
   WriteFile(hCom,BufWrite[0],length(final),NumberOfBytesWrite,nil);

   // pas pu ecrire
   if (NumberOfBytesWrite<>length(final)) or (numberofbyteswrite=0) then
      begin
      Result:=False;
      MyMessage:='C3Goto : '+ //nolang
         lang('Le télescope refuse les coordonnées');
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   // on lit si la commande est acceptee
   ReadFile(hCom,BufRead[0],2,NumberOfBytesRead,nil);

   // peut pas lire
   if NumberOfBytesRead=0 then
   begin
      Result:=False;
      MyMessage:='C3Goto : '+ //nolang
         lang('Le télescope ne répond pas aux coordonnées');
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
   end;

   case BufRead[1] of
      '0':WriteSpy('C3Goto : '+ //nolang
             lang('Le télescope accepte les coordonnées : ')+AlphaToStr(Alpha)+'/'+DeltaToStr(Delta));

      '4':Begin    // below horizon
          Result:=False;
          Busy:=False;
          WriteSpy('C3Goto : '+c3_ret_04); //nolang
          Exit;
          end;

      '1':Begin  // invalid params
          Result:=False;
          Busy:=False;
          WriteSpy('C3Goto : '+c3_ret_01); //nolang
          Exit;
          end;

      '2':Begin  // unknown command
          Result:=False;
          Busy:=False;
          WriteSpy('C3Goto : '+c3_ret_02); //nolang
          Exit;
          end;

      '5':Begin  // dangerous slew
          Result:=False;
          Busy:=False;
          WriteSpy('C3Goto : '+c3_ret_05); //nolang
          Exit;
          end;
      else
          begin
          Result:=False;
          Busy:=False;
          MyMessage:='C3Goto : '+ //nolang
             lang('Le télescope refuse les coordonnées pour raison inconnue : ')+BufRead[0]+bufread[1];
          WriteSpy(MyMessage);
          Exit;
          end;
      end;

// Je vire ca pour l'instant
// A rajouter eventuellement a un niveau superieur
    // verifier si le telescope est bloque
    bloque:=false;
{    if not getpos(alpha2,delta2) then
       begin
       WriteSpy('C3Goto : '+
          lang('Le télescope ne veut pas donner sa position : Pointage annulé'));
       Result:=false;
       Busy:=False;
       Exit;
       end;

    while ((Abs(Alpha-Alpha2)>MinDistPointage/60/60) or
     (Abs(Delta-Delta2)>MinDistPointage/60/60)) and not(Bloque) do
    begin
          Alpha1:=Alpha2;
          Delta1:=Delta2;
          if GetPos(Alpha2,Delta2) then
             begin
             WriteSpy('C3Goto : '+
                Lang('Le télescope ne veut pas donner sa position : Pointage annulé'));
             Result:=false;
             Busy:=False;
             Exit;
             end;

          if ((Abs(Alpha1-Alpha2)<1/600) and
              (Abs(Delta1-Delta2)<1/60)) then Inc(i);
          if i=20 then
          begin
             Bloque:=True;
             WriteSpy(lang('Bloqué !!!!!!!!'));
          end;
    end;}

    // verification de fin de slew
    if not bloque and ((Abs(Alpha-Alpha2)>MinDistPointage/60/60) or
                        (Abs(Delta-Delta2)>MinDistPointage/60/60)) then
    begin
          there:=false;
          while not there do
          begin
                setlength(bufwrite,2);
                bufwrite[0]:='D';
                bufwrite[1]:=#13;
                flushfilebuffers(hcom);
                WriteFile(hCom,BufWrite[0],2,NumberOfBytesWrite,nil);
                ReadFile(hCom,BufRead[0],50,NumberOfBytesRead,nil);

                s:='';
                for i:=0 to 50 do s:=s+bufread[i];
                tracking:=pos('Tracking',s)<>0; //nolang
                if tracking then
                begin
                     // ca y est, c est en mode guidage
                     there := true;
                end
                else
                begin
                     // non, pas encore fini..
                     there:=false;
                     do_sleep(0.5);
                end;
          end;
    end;

   WriteSpy('C3Goto : '+ //nolang
      lang('Pointage des coordonnées ')+AlphaToStr(Alpha)+'/'+
      DeltaToStr(Delta)+lang(' réussi'));

   finally
   Busy:=False;
   end;
end;

function TTelescopeC3.Sync(Alpha,Delta:Double):Boolean;
var
   alpha_str,delta_str,final:string;
   i:integer;
   BufWrite:array of char;
   BufRead:array [0..len_S] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   MyMessage:string;
begin
   Busy:=True;
   try

   Result:=True;

   WriteSpy('C3Update : '+ //nolang
      lang('Début du réalignement sur ')+AlphaToSTr(Alpha)+'/'+DeltaToStr(Delta));

   FlushFileBuffers(hCom);

   // on construit la string
   // ALPHA
   alpha_str:=alphatostr(alpha);
   alpha_str[3]:=':';
   alpha_str[6]:=':';
   alpha_str:=copy(alpha_str,1,8);
   // DELTA
   delta_str:=deltatostr(delta);
   delta_str[4]:=':';
   delta_str[7]:=':';
   delta_str:=copy(delta_str,1,9);
   // final
   final:='SRA:'+alpha_str+' DEC:'+delta_str+#13; //nolang
   for i:=0 to length(final)-1 do bufwrite[i]:=final[i+1];
   setlength(bufwrite,length(final));

   // on ecrit la commande
   WriteFile(hCom,BufWrite[0],length(final),NumberOfBytesWrite,nil);

   // pas pu ecrire
   if (NumberOfBytesWrite<>length(final)) or (numberofbyteswrite=0) then
      begin
      Result:=False;
      Busy:=False;
      MyMessage:='C3Update : '+ //nolang
         lang('Le télescope refuse les coordonnées');
      WriteSpy(MyMessage);
      Exit;
      end;

   // on lit si la commande est acceptee
   ReadFile(hCom,BufRead[0],2,NumberOfBytesRead,nil);

   // peut pas lire
   if NumberOfBytesRead <> 2 then
      begin
      Result:=False;
      Busy:=False;
      MyMessage:='C3Update : '+ //nolang
         'Le télescope n''accepte pas la mise à jour';
      WriteSpy(MyMessage);
      Exit;
      end;

   case BufRead[1] of
     '0':WriteSpy('C3Update : '+ //nolang
            lang('Le télescope accepte la mise à jour à : ')+AlphaToStr(Alpha)+'/'+DeltaToStr(Delta));

     '4':begin    // below horizon
         Result:=False;
         Busy:=False;
         WriteSpy('C3Goto : '+c3_ret_04); //nolang
         Exit;
         end;

     '1':begin  // invalid params
         Result:=False;
         Busy:=False;
         WriteSpy('C3Update : '+c3_ret_01); //nolang
         Exit;
         end;

     '2':begin  // unknown command
         Result:=False;
         Busy:=False;
         WriteSpy('C3Update : '+c3_ret_02); //nolang
         Exit;
         end;

     '5':Begin  // dangerous slew
         Result:=False;
         Busy:=False;
         WriteSpy('C3Update : '+c3_ret_05); //nolang
         exit
         end;
        else
         begin
         Result:=False;
         Busy:=False;
         MyMessage:='C3Update : '+ //nolang
            lang('Le télescope refuse la MAJ pour raison inconnue : ')+BufRead[0]+bufread[1];
         WriteSpy(MyMessage);
         Exit;
         end;
     end; // case


   WriteSpy('C3Update : '+ //nolang
      lang('Mise à jour des coordonnées du télescope réussie à ')+AlphaToStr(Alpha)+'/'+DeltaToStr(Delta));

   FlushFileBuffers(hCom);

   finally
   Busy:=False;
   end;
end;

function TTelescopeC3.ToggleLongFormat:Boolean;
begin

end;

function TTelescopeC3.IsLongFormat:Boolean;
begin
Result:=False;  // ???
end;

function TTelescopeC3.StartMotion(Direction:string):Boolean;
var
   BufWrite:array of char;
   NumberOfBytesWrite:Cardinal;
   tmp,MyMessage:string;
   i:integer;
begin
   Busy:=True;
   try

   Result:=True;
      
   FlushFileBuffers(HCom);

   if uppercase(direction) = 'E' then tmp:='JR+' //nolang
   else if uppercase(direction) = 'W' then tmp:='JR-' //nolang
   else if uppercase(direction) = 'N' then tmp:='JD+' //nolang
   else if uppercase(direction) = 'S' then tmp:='JD-' //nolang
   else
   begin
      Result:=False;
      WriteSpy(lang('Direction inexistante'));
      Busy:=False;
      Exit;
   end;

//   tmp:=tmp+inttostr(arg)+#13; c'est quoi arg ???????????????
   tmp:=tmp+'0'+#13;

   setlength(bufwrite,length(tmp));
   for i:=0 to length(tmp)-1 do bufwrite[i]:=tmp[i+1];


   WriteFile(HCom,BufWrite[0],length(tmp),NumberOfBytesWrite,nil);

   if (NumberOfBytesWrite<>length(tmp)) or (numberofbyteswrite=0) then
   begin
      Result:=False;
      MyMessage:=lang('C3StartMotion : Le télescope refuse la commande');
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
   end;

   WriteSpy('StartMotion '+uppercase(direction)); //nolang

   finally
   Busy:=False;
   end;
end;

function TTelescopeC3.StopMotion(Direction:string):Boolean;
var
   BufWrite:array[0..1] of char;
   NumberOfBytesWrite:Cardinal;
   MyMessage:string;
begin
   Busy:=True;
   try

   Result:=True;

   FlushFileBuffers(HCom);

   BufWrite[0]:='E';
   BufWrite[1]:=#13;
   WriteFile(HCom,BufWrite[0],2,NumberOfBytesWrite,nil);

   if (NumberOfBytesWrite<>2) or (numberofbyteswrite=0) then
   begin
      Result:=False;
      MyMessage:=lang('C3StopMotion : Le télescope refuse la commande');
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
   end;

   finally
   Busy:=False;
   end;
end;

function TTelescopeC3.SetSpeed(Speed:Integer):Boolean;
begin
Result:=True;
end;

function TTelescopeC3.Quit:Boolean;
begin
Result:=True;
end;

//function TTelescopeC3.MotionRate(Rate:string):Boolean;
function TTelescopeC3.MotionRate(ButtonNumber:Integer):Boolean;
begin
// On met quoi ici ?
end;

function TTelescopeC3.IsBusy:Boolean;
begin
Result:=Busy;
end;

function TTelescopeC3.CanGoToShortFormat:Boolean;
begin
Result:=True; // Oui ???
end;

function TTelescopeC3.CanSetSpeed:Boolean;
begin
Result:=False;  // ???
end;

function TTelescopeC3.GetGuideSpeed:Double;
begin
Result:=2;  // Idem au LX ?
end;

function TTelescopeC3.NeedComName:Boolean;
begin
Result:=True;
end;

function TTelescopeC3.NeedComTimeOuts:Boolean;
begin
Result:=True;
end;

function TTelescopeC3.NeedComComm:Boolean;
begin
Result:=True;
end;

function TTelescopeC3.NeedComAdress:Boolean;
begin
Result:=False;
end;

function TTelescopeC3.StoreCoordinates:Boolean;
begin
Result:=True;
end;

function TTelescopeC3.IsGoto:Boolean;
begin
Result:=True;
end;

function TTelescopeC3.NumberOfSpeedButtons:Integer;
begin
Result:=4;
end;

function TTelescopeC3.CaptionOfSpeedButtonNumber(Number:Integer):PChar;
begin
case Number of
   1:Result:=PChar(lang('Pointer'));
   2:Result:=PChar(lang('Chercher'));
   3:Result:=PChar(lang('Centrer'));
   4:Result:=PChar(lang('Guider'));
   end;
end;

function TTelescopeC3.GetTrackSpeedNumber:Integer;
begin
Result:=4;
end;

function TTelescopeC3.GetCenterSpeedNumber:Integer;
begin
Result:=3;
end;

function TTelescopeC3.GetName:PChar;
begin
Result:=PChar('Coordinate III'); //nolang
end;

//******************************************************************************
//**************************       Telescope Virtuel      **********************
//******************************************************************************

constructor TTelescopeVirtuel.Create;
begin
   inherited Create;
end;

procedure TTelescopeVirtuel.SetComPort(ComPort:string);
begin
end;

procedure TTelescopeVirtuel.SetComAdress(ComAdress:string);
begin
end;

procedure TTelescopeVirtuel.SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                    _ReadTotalTimeoutMultiplier:DWord;
                                    _ReadTotalTimeoutConstant:DWord;
                                    _WriteTotalTimeoutMultiplier:DWord;
                                    _WriteTotalTimeoutConstant:DWord);
begin
end;

procedure TTelescopeVirtuel.SetSerialPortComm(_BaudRate:DWord;
                                 _ByteSize:Byte;
                                 _Parity:Byte;
                                 _StopBits:Byte);
begin
end;

function TTelescopeVirtuel.Open:Boolean;
begin
Result:=True;
end;

procedure TTelescopeVirtuel.Close;
begin
end;

function TTelescopeVirtuel.IsConnectedAndOK:Boolean;
begin
Result:=True;
end;

function TTelescopeVirtuel.Getpos(var Alpha,Delta:Double):Boolean;
begin
Busy:=True;
try
Alpha:=StrToAlpha('23:04:48'); //nolang
Delta:=StrToDelta('+15°12''36"'); //nolang
//Alpha:=0;
//Delta:=0;
{if Config.CreeErreur then
   begin
   Result:=False;
   Config.CreeErreur:=False;
   end
else}
Result:=True;
finally
Busy:=False;
end;
end;

function TTelescopeVirtuel.GotoAlphaDelta(Alpha,Delta:Double):Boolean;
begin
Result:=True;
end;

function TTelescopeVirtuel.Sync(Alpha,Delta:Double):Boolean;
begin
Result:=True;
end;

function TTelescopeVirtuel.ToggleLongFormat:Boolean;
begin
Result:=True;
end;

function TTelescopeVirtuel.IsLongFormat:Boolean;
begin
Result:=True;
end;

function TTelescopeVirtuel.StartMotion(Direction:string):Boolean;
var
   TimeInit:TDAteTime;
begin
//MySleep(100);
TimeInit:=Time;
while Time<TimeInit +100/1000/60/60/24 do ;

Result:=True;
end;

function TTelescopeVirtuel.StopMotion(Direction:string):Boolean;
begin
Result:=True;
end;

function TTelescopeVirtuel.SetSpeed(Speed:Integer):Boolean;
begin
Result:=True;
end;

function TTelescopeVirtuel.Quit:Boolean;
begin
Result:=True;
end;

//function TTelescopeVirtuel.MotionRate(Rate:string):Boolean;
function TTelescopeVirtuel.MotionRate(ButtonNumber:Integer):Boolean;
begin
// Pour tester le probleme de Bodart, attention c'est toujours pas resolu !
//raise Error.Create(lang('LX200MotionRate : Le télescope refuse le réglage de vitesse'));
//Result:=False;
Result:=True;
end;

function TTelescopeVirtuel.IsBusy:Boolean;
begin
Result:=Busy;
end;

function TTelescopeVirtuel.CanGoToShortFormat:Boolean;
begin
Result:=True;
end;

function TTelescopeVirtuel.CanSetSpeed:Boolean;
begin
Result:=True;
end;

function TTelescopeVirtuel.GetGuideSpeed:Double;
begin
Result:=2;
end;

function TTelescopeVirtuel.NeedComName:Boolean;
begin
Result:=False;
end;

function TTelescopeVirtuel.NeedComTimeOuts:Boolean;
begin
Result:=False;
end;

function TTelescopeVirtuel.NeedComComm:Boolean;
begin
Result:=False;
end;

function TTelescopeVirtuel.NeedComAdress:Boolean;
begin
Result:=False;
end;

function TTelescopeVirtuel.StoreCoordinates:Boolean;
begin
Result:=True;
end;

function TTelescopeVirtuel.IsGoto:Boolean;
begin
Result:=True;
end;

function TTelescopeVirtuel.NumberOfSpeedButtons:Integer;
begin
Result:=4;
end;

function TTelescopeVirtuel.CaptionOfSpeedButtonNumber(Number:Integer):PChar;
begin
case Number of
   1:Result:=PChar(lang('Pointer'));
   2:Result:=PChar(lang('Chercher'));
   3:Result:=PChar(lang('Centrer'));
   4:Result:=PChar(lang('Guider'));
   end;
end;

function TTelescopeVirtuel.GetTrackSpeedNumber:Integer;
begin
Result:=4;
end;

function TTelescopeVirtuel.GetCenterSpeedNumber:Integer;
begin
Result:=3;
end;

function TTelescopeVirtuel.GetName:PChar;
begin
Result:=PChar('Virtual'); //nolang
end;

//******************************************************************************
//**************************       Aucun Telescope        **********************
//******************************************************************************

constructor TTelescopeNone.Create;
begin
   inherited Create;
end;

procedure TTelescopeNone.SetComPort(ComPort:string);
begin
end;

procedure TTelescopeNone.SetComAdress(ComAdress:string);
begin
end;

procedure TTelescopeNone.SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                    _ReadTotalTimeoutMultiplier:DWord;
                                    _ReadTotalTimeoutConstant:DWord;
                                    _WriteTotalTimeoutMultiplier:DWord;
                                    _WriteTotalTimeoutConstant:DWord);
begin
end;

procedure TTelescopeNone.SetSerialPortComm(_BaudRate:DWord;
                                 _ByteSize:Byte;
                                 _Parity:Byte;
                                 _StopBits:Byte);
begin
end;

function TTelescopeNone.Open:Boolean;
begin
Result:=True;
end;

procedure TTelescopeNone.Close;
begin
end;

function TTelescopeNone.IsConnectedAndOK:Boolean;
begin
Result:=False;
end;

function TTelescopeNone.Getpos(var Alpha,Delta:Double):Boolean;
begin
Result:=True;
end;

function TTelescopeNone.GotoAlphaDelta(Alpha,Delta:Double):Boolean;
begin
Result:=True;
end;

function TTelescopeNone.Sync(Alpha,Delta:Double):Boolean;
begin
Result:=True;
end;

function TTelescopeNone.ToggleLongFormat:Boolean;
begin
Result:=True;
end;

function TTelescopeNone.IsLongFormat:Boolean;
begin
Result:=True;
end;

function TTelescopeNone.StartMotion(Direction:string):Boolean;
begin
Result:=True;
end;

function TTelescopeNone.StopMotion(Direction:string):Boolean;
begin
Result:=True;
end;

function TTelescopeNone.SetSpeed(Speed:Integer):Boolean;
begin
Result:=True;
end;

function TTelescopeNone.Quit:Boolean;
begin
Result:=True;
end;

//function TTelescopeNone.MotionRate(Rate:string):Boolean;
function TTelescopeNone.MotionRate(ButtonNumber:Integer):Boolean;
begin
Result:=True;
end;

function TTelescopeNone.IsBusy:Boolean;
begin
Result:=Busy;
end;

function TTelescopeNone.CanGoToShortFormat:Boolean;
begin
Result:=True;
end;

function TTelescopeNone.CanSetSpeed:Boolean;
begin
Result:=False;
end;

function TTelescopeNone.GetGuideSpeed:Double;
begin
Result:=1;
end;

function TTelescopeNone.NeedComName:Boolean;
begin
Result:=False;
end;

function TTelescopeNone.NeedComTimeOuts:Boolean;
begin
Result:=False;
end;

function TTelescopeNone.NeedComComm:Boolean;
begin
Result:=False;
end;

function TTelescopeNone.NeedComAdress:Boolean;
begin
Result:=False;
end;

function TTelescopeNone.StoreCoordinates:Boolean;
begin
// Surtout laisser ca !!!
Result:=False;
end;

function TTelescopeNone.IsGoto:Boolean;
begin
Result:=False;
end;

function TTelescopeNone.NumberOfSpeedButtons:Integer;
begin
Result:=0;
end;

function TTelescopeNone.CaptionOfSpeedButtonNumber(Number:Integer):PChar;
begin
Result:='';
end;

function TTelescopeNone.GetTrackSpeedNumber:Integer;
begin
Result:=0;
end;

function TTelescopeNone.GetCenterSpeedNumber:Integer;
begin
Result:=0;
end;

function TTelescopeNone.GetName:PChar;
begin
Result:=PChar('None'); //nolang
end;

//******************************************************************************
//**************************             AP GTO           **********************
//******************************************************************************

constructor TTelescopeAPGTO.Create;
begin
inherited Create;
end;

function TTelescopeAPGTO.GotoAlphaDelta(Alpha,Delta:Double):Boolean;
var
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;

   AlphaH,AlphaM,AlphaS:Integer;
   DeltaD,DeltaM,DeltaS:Integer;
   Sign:Char;
   InterStr:String;

   i,j:Integer;
   Line,MyMessage:string;

   Alpha1,Delta1,Alpha2,Delta2,Dist,Dist1:Double;

   TimeInit:TDateTime;
begin
   Busy:=True;
   try

   Result:=True;

   WriteSpy('APGTOGoto : '+ //nolang
      lang('Debut du pointage ')+AlphaToStr(Alpha)+'/'+DeltaToStr(Delta));

//  WriteSpy('APGTOGoto : '+ //nolang
//     lang('Demande des coordonnées actuelles'));
//   Alpha1:=Config.AlphaScope;
//   Delta1:=Config.DeltaScope;

  // Deja sur les coordonnees
{  if ((Abs(Alpha-Alpha1)<Config.ErreurPointingAlpha/3600) and  // Secondes -> heures
     (Abs(Delta-Delta1)<Config.ErreurPointingDelta/3600)) then // Secondes -> degres
     begin
     WriteSpy('APGTOGoto : '+ //nolang
        Lang('Déjà sur les coordonnées'));
     Busy:=False;
     Exit;
     end;}

//  Dist:=Arccos(Sin(Delta/180*pi)*Sin(Delta1/180*pi)+(Cos(Delta/180*pi)*Cos(Delta1/180*pi)
//           *Cos(Alpha*15/180*pi-Alpha1*15/180*pi)))/pi*180;

   FlushFileBuffers(hCom);

   AlphaH:=Trunc(Alpha);
   AlphaM:=Trunc((Alpha-AlphaH)*60);
   if IsInLongFormat then
      begin
      AlphaS:=Trunc(((Alpha-AlphaH)*60-AlphaM)*60);
      if Delta>=0 then
         begin
         DeltaD:=Trunc(Delta);
         DeltaM:=Trunc((Delta-DeltaD)*60);
         DeltaS:=Trunc(((Delta-DeltaD)*60-DeltaM)*60);
         Sign:='+';
         end
      else
         begin
         DeltaD:=Trunc(-Delta);
         DeltaM:=Trunc((-Delta-DeltaD)*60);
         Sign:='-';
         end;
      end
   else
      begin
      AlphaS:=Trunc(((Alpha-AlphaH)*60-AlphaM)*10);
      if Delta>=0 then
         begin
         DeltaD:=Trunc(Delta);
         DeltaM:=Trunc((Delta-DeltaD)*60);
         Sign:='+';
         end
      else
         begin
         DeltaD:=Trunc(-Delta);
         DeltaM:=Trunc((-Delta-DeltaD)*60);
         Sign:='-';
         end;
      end;

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='S';
   BufWrite[3]:='r';
   BufWrite[4]:=' ';

   // Alpha : /:Sr HH:MM.S#/ ou /:Sr HH:MM:SS#/
//   Str(AlphaH:1,InterStr);         // Marty
   InterStr:=IntToStr(AlphaH);         // Marty
   if AlphaH<10 then
      begin
      BufWrite[5]:='0';
      Inc(i);
      BufWrite[6]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[5]:=InterStr[1];
      Inc(i);
      BufWrite[6]:=InterStr[2];
      Inc(i);
      end;                         // Marty

   BufWrite[7]:=':';
   InterStr:=IntToStr(AlphaM);
//   Str(AlphaM:1,InterStr);
   if AlphaM<10 then
      begin
      BufWrite[8]:='0';
      Inc(i);
      BufWrite[9]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[8]:=InterStr[1];
      Inc(i);
      BufWrite[9]:=InterStr[2];
      Inc(i);
      end;                         // Marty
   BufWrite[10]:=':';
   Inc(i);

   if IsInLongFormat then
      begin
//      Str(AlphaS:2,InterStr);
      InterStr:=IntToStr(AlphaS);
      if AlphaS<10 then
         begin
         BufWrite[11]:='0';
         Inc(i);
         BufWrite[12]:=InterStr[1];
         Inc(I);
         end
      else
         begin
         BufWrite[11]:=InterStr[1];
         Inc(i);
         BufWrite[12]:=InterStr[2];
         Inc(i);
         end;                         // Marty
      BufWrite[13]:='#';
      WriteFile(hCom,BufWrite[0],14,NumberOfBytesWrite,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesWrite);
      for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
      WriteSpy('APGTOGoto : '+ //nolang
         lang('Envoi de : /')+Line+'/');

      if NumberOfBytesWrite<14 then
         begin
         Result:=False;
         Busy:=False;
         MyMessage:='APGTOGoto : '+ //nolang
            lang('Le télescope refuse les coordonnées Alpha');
         WriteSpy(MyMessage);
         Exit;
         end;
      end
   else
      begin
      InterStr:=IntToStr(AlphaS);
      BufWrite[11]:=InterStr[1];
      BufWrite[12]:='#';

      WriteFile(hCom,BufWrite[0],13,NumberOfBytesWrite,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesWrite);
      for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
      WriteSpy('APGTOGoto : '+ //nolang
         lang('Envoi de : /')+Line+'/');

      if NumberOfBytesWrite<13 then
         begin
         Result:=False;
         Busy:=False;
         MyMessage:='APGTOGoto : '+ //nolang
            lang('Le télescope refuse les coordonnées Alpha');
         WriteSpy(MyMessage);
         Exit;
         end;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('APGTOGoto : '+ //nolang
      lang('Réception de : /')+Line+'/');

// Bon, je vire ces verifs car ca merde avec certaines montures
{   if NumberOfBytesRead=0 then
      begin
      Result:=False;
      MyMessage:='APGTOGoto : '+ //nolang
         lang('Le télescope ne répond pas aux coordonnées Alpha');
      WriteSpy(MyMessage);
      end;
   if BufRead[0]<>'1' then
      begin
      Result:=False;
      MyMessage:='APGTOGoto : '+ //nolang
         lang('Le télescope répond mal aux coordonnées Alpha');
      WriteSpy(MyMessage);
      end;}

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='S';
   BufWrite[3]:='d';
   BufWrite[4]:=' ';
   BufWrite[5]:=Sign;
//   Str(DeltaD:1,InterStr);
   InterStr:=IntToStr(DeltaD);

   i:=6;
   if (DeltaD<10) then
      begin
      BufWrite[i]:='0';
      Inc(i);
      BufWrite[i]:=InterStr[1];
      Inc(i);
      end
   else
      begin
      BufWrite[i]:=InterStr[1];
      Inc(i);
      BufWrite[i]:=InterStr[2];
      Inc(i);
      end;
//   BufWrite[i]:=#223;
    BufWrite[i]:='*';
   Inc(i);
//   Str(DeltaM:1,InterStr);
   InterStr:=IntToStr(DeltaM);
   if DeltaM<10 then
      begin
      BufWrite[i]:='0';
      Inc(i);
      BufWrite[i]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[i]:=InterStr[1];
      Inc(i);
      BufWrite[i]:=InterStr[2];
      Inc(i);
      end;
   BufWrite[i]:=':';
   Inc(i);
   if IsInLongFormat then
      begin
//      Str(DeltaS:1,InterStr);
      InterStr:=IntToStr(DeltaS);
      if DeltaS<10 then
         begin
         BufWrite[i]:='0';
         Inc(i);
         BufWrite[i]:=InterStr[1];
         Inc(I);
         end
      else
         begin
         BufWrite[i]:=InterStr[1];
         Inc(i);
         BufWrite[i]:=InterStr[2];
         Inc(i);
         end;
      end;
   BufWrite[i]:='#';
   Inc(i);

   WriteFile(hCom,BufWrite[0],i,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('APGTOGoto : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<i then
      begin
      Result:=False;
      Busy:=False;
      MyMessage:='APGTOGoto : '+ //nolang
         lang('Le télescope refuse les coordonnées Delta');
      WriteSpy(MyMessage);
      Exit;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('APGTOGoto : '+ //nolang
      lang('Réception de : /')+Line+'/');

// Bon, je vire ces verifs car ca merde avec certaines montures
{   if NumberOfBytesRead=0 then
      begin
      Result:=False;
      MyMessage:='APGTOGoto : '+ //nolang
         lang('Le télescope ne répond pas aux coordonnées Delta');
      WriteSpy(MyMessage);
      end;
   if BufRead[0]<>'1' then
      begin
      Result:=False;
      MyMessage:='APGTOGoto : '+ //nolang
         lang('Le télescope répond mal aux coordonnées');
      WriteSpy(MyMessage);
      end;}

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='M';
   BufWrite[3]:='S';
   BufWrite[4]:='#';
   WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('APGTOGoto : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<5 then
      begin
      Result:=False;
      Busy:=False;
      MyMessage:='APGTOGoto : '+ //nolang
         lang('Le télescope refuse la demande de déplacement');
      WriteSpy(MyMessage);
      Exit;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On vide
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('APGTOGoto : '+ //nolang
      lang('Réception de : /')+Line+'/');

// Bon, je vire ces verifs car ca merde avec certaines montures
{   if NumberOfBytesRead=0 then
      begin
      Result:=False;
      MyMessage:='APGTOGoto : '+ //nolang
         lang('Le télescope ne répond pas aux coordonnées');
      WriteSpy(MyMessage);
      end;

   case BufRead[0] of
      '0':WriteSpy('APGTOGoto : '+ //nolang
             lang('Le télescope accepte les coordonnées : ')+AlphaToStr(Alpha)+'/'+DeltaToStr(Delta));
      '1':begin
          Result:=False;
          MyMessage:='APGTOGoto : '+ //nolang
             'Le télescope refuse les coordonnées car elles sont sous l''horizon';
          WriteSpy(MyMessage);
          end;
      '2':begin
          Result:=False;
          MyMessage:='APGTOGoto : '+ //nolang
             lang('Le télescope refuse les coordonnées car elles sont sous la zone critique');
          WriteSpy(MyMessage);
          end;
      else
          begin
          Result:=False;
          MyMessage:='APGTOGoto : '+ //nolang
             lang('Le télescope refuse les coordonnées pour raison inconnue : ')+BufRead[0];
          WriteSpy(MyMessage);
          end;
      end;}

// Je vire ca pour l'instant
// A rajouter eventuellement a un niveau superieur

{   if not GetPos(Alpha2,Delta2) then
      begin
      WriteSpy('APGTOGoto : '+ //nolang
         Lang('Le télescope ne veut pas donner sa position : Pointage annulé'));
      Result:=false;
      Busy:=False;
      Exit;
      end;


   i:=0;
   j:=0;
   while ((Abs(Alpha-Alpha2)>Config.ErreurPointingAlpha/3600) or // 6
         (Abs(Delta-Delta2)>Config.ErreurPointingDelta/3600)) //and not(Bloque) // 60
         do
      begin
      Alpha1:=Alpha2;
      Delta1:=Delta2;
      if not GetPos(Alpha2,Delta2) then
         begin
         WriteSpy('APGTOGoto : '+ //nolang
            Lang('Le télescope ne veut pas donner sa position : Pointage annulé'));
         Result:=false;
         Busy:=False;
         Exit;
         end;

      // Ca a merdé
      if not(Config.TelescopeBranche) then
         begin
         Inc(i);
         WriteSpy('APGTOGoto : '+ //nolang
            lang('Télescope débranché = ')+IntToStr(i));
         end;
      // Si ca a merde plus de 10 fois on arrete
      if i>10 then
         begin
         Result:=False;
         Busy:=False;
         MyMessage:='APGTOGoto : '+ //nolang
            lang('Le téléscope ne réponds plus');
         WriteSpy(MyMessage);
         Exit;
         end;
      // On accepte que ca merde
      Config.TelescopeBranche:=True;
      // On attends 1 s
      TimeInit:=Time;
      while Time<TimeInit+1500/1000/60/60/24 do;

      // Le telescope est il en mouvement
      if (Alpha1-Alpha2=0) and
         (Delta1-Delta2=0) then
         begin
         Inc(j);
         WriteSpy('APGTOGoto : '+ //nolang
            lang('Télescope arrêté = ')+IntToStr(j));
         end;

      // Si le telescope n'a pas bouge pendant plus de 5 coups, il est bloque
      if j>5 then
         begin
         Result:=False;
         Busy:=False;
         MyMessage:='APGTOGoto : '+ //nolang
            lang('Télescope considéré comme bloqué. Augmentez la tolérance de pointage. Reconnectez le télescope');
         WriteSpy(MyMessage);
         Exit;
         end;
      end;}

   finally
   Busy:=False;
   end;
end;

function TTelescopeAPGTO.Sync(Alpha,Delta:Double):Boolean;
var
   i,j:Integer;
   AlphaH,AlphaM,AlphaS:Integer;
   DeltaD,DeltaM,DeltaS:Integer;
   Sign:Char;
   InterStr:String;

   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   LLine,Line,MyMessage:string;
begin
   Busy:=True;
   try
   
   Result:=True;

   WriteSpy('APGTOUpdate : '+ //nolang
      lang('Début du réalignement sur ')+AlphaToSTr(Alpha)+'/'+DeltaToStr(Delta));

   FlushFileBuffers(hCom);

   AlphaH:=Trunc(Alpha);
   AlphaM:=Trunc((Alpha-AlphaH)*60);
   if IsInLongFormat then
      begin
      AlphaS:=Trunc(((Alpha-AlphaH)*60-AlphaM)*60);
      if Delta>=0 then
         begin
         DeltaD:=Trunc(Delta);
         DeltaM:=Trunc((Delta-DeltaD)*60);
         DeltaS:=Trunc(((Delta-DeltaD)*60-DeltaM)*60);
         Sign:='+';
         end
      else
         begin
         DeltaD:=Trunc(-Delta);
         DeltaM:=Trunc((-Delta-DeltaD)*60);
         DeltaS:=Trunc(((-Delta-DeltaD)*60-DeltaM)*60);
         Sign:='-';
         end;
      end
   else
      begin
      AlphaS:=Trunc(((Alpha-AlphaH)*60-AlphaM)*10);
      if Delta>=0 then
         begin
         DeltaD:=Trunc(Delta);
         DeltaM:=Trunc((Delta-DeltaD)*60);
         Sign:='+';
         end
      else
         begin
         DeltaD:=Trunc(-Delta);
         DeltaM:=Trunc((-Delta-DeltaD)*60);
         Sign:='-';
         end;
      end;

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='S';
   BufWrite[3]:='r';
   BufWrite[4]:=' ';

   // Alpha : /:Sr HH:MM.S#/ ou /:Sr HH:MM:SS#/
   InterStr:=IntToStr(AlphaH);         // Marty
   if AlphaH<10 then
      begin
      BufWrite[5]:='0';
      Inc(i);
      BufWrite[6]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[5]:=InterStr[1];
      Inc(i);
      BufWrite[6]:=InterStr[2];
      Inc(i);
      end;                         // Marty

   BufWrite[7]:=':';
   InterStr:=IntToStr(AlphaM);
   if AlphaM<10 then
      begin
      BufWrite[8]:='0';
      Inc(i);
      BufWrite[9]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[8]:=InterStr[1];
      Inc(i);
      BufWrite[9]:=InterStr[2];
      Inc(i);
      end;                         // Marty

   BufWrite[10]:=':';
   Inc(i);

   if IsInLongFormat then
      begin
      InterStr:=IntToStr(AlphaS);
      if AlphaS<10 then
         begin
         BufWrite[11]:='0';
         Inc(i);
         BufWrite[12]:=InterStr[1];
         Inc(i);
         end
      else
         begin
         BufWrite[11]:=InterStr[1];
         Inc(i);
         BufWrite[12]:=InterStr[2];
         Inc(i);
         end;                         // Marty
      BufWrite[13]:='#';

      WriteFile(hCom,BufWrite[0],14,NumberOfBytesWrite,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesWrite);
      for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
      WriteSpy('APGTOUpdate : '+ //nolang
         lang('Envoi de : /')+Line+'/');

      if NumberOfBytesWrite<14 then
         begin
         Result:=False;
         Busy:=False;
         MyMessage:='APGTOUpdate : '+ //nolang
            lang('Le télescope refuse les coordonnées Alpha');
         WriteSpy(MyMessage);
         Exit;
         end;
      end
   else
      begin
      InterStr:=IntToStr(AlphaS);      
//      Str(AlphaS:1,InterStr);
      BufWrite[11]:=InterStr[1];
      BufWrite[12]:='#';

      WriteFile(hCom,BufWrite[0],14,NumberOfBytesWrite,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesWrite);
      for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
      WriteSpy('APGTOUpdate : '+ //nolang
         lang('Envoi de : /')+Line+'/');
      
      if NumberOfBytesWrite<14 then
         begin
         Result:=False;
         Busy:=False;
         MyMessage:='APGTOGoto : '+ //nolang
            lang('Le télescope refuse les coordonnées Alpha');
         WriteSpy(MyMessage);
         Exit;
         end;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('APGTOUpdate : '+  //nolang
      lang('Réception de : /')+Line+'/');

// Bon, je vire ces verifs car ca merde avec certaines montures
{   if NumberOfBytesRead=0 then
      begin
      Result:=False;
      MyMessage:='APGTOUpdate : '+ //nolang
         lang('Le télescope ne répond pas à la demande de mise à jour Alpha');
      WriteSpy(MyMessage);
      end;
   if BufRead[0]<>'1' then
      begin
      Result:=False;
      MyMessage:='APGTOUpdate : '+ //nolang
         lang('Le télescope répond mal aux coordonnées Alpha');
      WriteSpy(MyMessage);
      end;}

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='S';
   BufWrite[3]:='d';
   BufWrite[4]:=' ';
   BufWrite[5]:=Sign;
   InterStr:=IntToStr(DeltaD);
//   Str(DeltaD:1,InterStr);

   i:=6;
   if (DeltaD<10) then
      begin
      BufWrite[i]:='0';
      Inc(i);
      BufWrite[i]:=InterStr[1];
      Inc(i);
      end
   else
      begin
      BufWrite[i]:=InterStr[1];
      Inc(i);
      BufWrite[i]:=InterStr[2];
      Inc(i);
      end;
//   BufWrite[i]:=#223;
    BufWrite[i]:='*';
   Inc(i);
   InterStr:=IntToStr(DeltaM);   
   if DeltaM<10 then
      begin
      BufWrite[i]:='0';
      Inc(i);
      BufWrite[i]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[i]:=InterStr[1];
      Inc(i);
      BufWrite[i]:=InterStr[2];
      Inc(i);
      end;

   if IsInLongFormat then
      begin
      BufWrite[i]:=':';
      Inc(i);

      InterStr:=IntToStr(DeltaS);      
      if DeltaS<10 then
         begin
         BufWrite[i]:='0';
         Inc(i);
         BufWrite[i]:=InterStr[1];
         Inc(i);
         end
      else
         begin
         BufWrite[i]:=InterStr[1];
         Inc(i);
         BufWrite[i]:=InterStr[2];
         Inc(i);
         end;
      end;
   BufWrite[i]:='#';
   Inc(i);

   WriteFile(hCom,BufWrite[0],i,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('APGTOUpdate : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<i then
      begin
      Result:=False;
      Busy:=False;
      MyMessage:='APGTOUpdate : '+ //nolang
         lang('Le télescope refuse la mise à jour des coordonnées Delta');
      WriteSpy(MyMessage);
      Exit;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('APGTOUpdate : '+ //nolang
      lang('Réception de : /')+Line+'/');

// Bon, je vire ces verifs car ca merde avec certaines montures
{   if NumberOfBytesRead=0 then
      begin
      Result:=False;
      MyMessage:='APGTOUpdate : '+ //nolang
         lang('Le télescope ne répond pas à la mise à jour des coordonnées Delta');
      WriteSpy(MyMessage);
      end;
   if BufRead[0]<>'1' then
      begin
      Result:=False;
      MyMessage:='APGTOUpdate : '+ //nolang
         lang('Le télescope répond mal à la mise à jour des coordonnées');
      WriteSpy(MyMessage);
      end;}

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='C';
   BufWrite[3]:='M';
   BufWrite[4]:='#';
   WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('APGTOUpdate : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<5 then
      begin
      Result:=False;
      Busy:=False;
      MyMessage:='APGTOUpdate : '+ //nolang
         lang('Le télescope refuse la commande de mise à jour');
      WriteSpy(MyMessage);
      Exit;
      end;
   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('APGTOUpdate : '+ //nolang
      lang('Réception de : /')+Line+'/');

   WriteSpy('APGTOUpdate : '+ //nolang
      lang('Mise à jour des coordonnées du télescope réussie à ')+
      AlphaToStr(Alpha)+'/'+DeltaToStr(Delta));

   FlushFileBuffers(hCom);

   finally
   Busy:=False;
   end;
end;


//function TTelescopeAPGTO.MotionRate(Rate:string):Boolean;
function TTelescopeAPGTO.MotionRate(ButtonNumber:Integer):Boolean;
var
   BufWrite:array[0..12] of char;
   NumberOfBytesWrite:Cardinal;
   TimeInit:TDateTime;
   MyMessage:string;
begin
   Busy:=True;
   try

   Result:=True;
      
   WriteSpy('APGTOMotionRate : '+ //nolang
      lang('Vitesse = ')+IntToStr(ButtonNumber));
//      lang('Vitesse = ')+Uppercase(Rate));

   FlushFileBuffers(HCom);

   // On attends 100 ms
   TimeInit:=Time;
   while Time<TimeInit+100/1000/60/60/24 do;

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='R';

   case ButtonNumber of
      1:begin
        WriteSpy('APGTOMotionRate : Send : #:RC2#'); //nolang
        BufWrite[3]:='C';
        BufWrite[4]:='2';
        end;
      2:begin
        WriteSpy('APGTOMotionRate : Send : #:RC1#'); //nolang
        BufWrite[3]:='C';
        BufWrite[4]:='1';
        end;
      3:begin
        WriteSpy('APGTOMotionRate : Send : #:RC0#'); //nolang
        BufWrite[3]:='C';
        BufWrite[4]:='0';
        end;
      4:begin
        WriteSpy('APGTOMotionRate : Send : #:RG2#'); //nolang
        BufWrite[3]:='G';
        BufWrite[4]:='2';
        end
      else
        begin
        Result:=False;
        MyMessage:='APGTOMotionRate : '+ //nolang
           lang('Vitesse invalide');
        WriteSpy(MyMessage);
        Busy:=False;
        Exit;
        end;
      end;

{   if Uppercase(Rate)='S' then
      begin
      WriteSpy('APGTOMotionRate : Send : #:RC2#'); //nolang
      BufWrite[3]:='C';
      BufWrite[4]:='2';
      end
   else
   if Uppercase(Rate)='F' then
      begin
      WriteSpy('APGTOMotionRate : Send : #:RC1#'); //nolang
      BufWrite[3]:='C';
      BufWrite[4]:='1';
      end
   else
   if Uppercase(Rate)='M' then
      begin
      WriteSpy('APGTOMotionRate : Send : #:RC1#'); //nolang
      BufWrite[3]:='C';
      BufWrite[4]:='1';
      end
   else
   if Uppercase(Rate)='C' then
      begin
      WriteSpy('APGTOMotionRate : Send : #:RC0#'); //nolang
      BufWrite[3]:='C';
      BufWrite[4]:='0';
      end
   else
   if Uppercase(Rate)='G' then
      begin
      WriteSpy('APGTOMotionRate : Send : #:RG2#'); //nolang
      BufWrite[3]:='G';
      BufWrite[4]:='2';
      end
   else
      begin
      Result:=False;
      WriteSpy(lang('APGTOMotionRate : Vitesse invalide'));
      end;}

   BufWrite[5]:='#';

   WriteFile(HCom,BufWrite[0],6,NumberOfBytesWrite,nil);
   if NumberOfBytesWrite<6 then
      begin
      Result:=False;
      MyMessage:='APGTOMotionRate : '+ //nolang
         lang('Le télescope refuse le réglage de vitesse');
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   finally
   Busy:=False;
   end;
end;

function TTelescopeAPGTO.IsBusy:Boolean;
begin
Result:=Busy;
end;

function TTelescopeAPGTO.CanGoToShortFormat:Boolean;
begin
Result:=False;
end;

function TTelescopeAPGTO.CanSetSpeed:Boolean;
begin
Result:=False;
end;

function TTelescopeAPGTO.GetGuideSpeed:Double;
begin
Result:=1; // RG2
end;

function TTelescopeAPGTO.NeedComName:Boolean;
begin
Result:=True;
end;

function TTelescopeAPGTO.NeedComTimeOuts:Boolean;
begin
Result:=True;
end;

function TTelescopeAPGTO.NeedComComm:Boolean;
begin
Result:=True;
end;

function TTelescopeAPGTO.NeedComAdress:Boolean;
begin
Result:=False;
end;

function TTelescopeAPGTO.StoreCoordinates:Boolean;
begin
Result:=True;
end;

function TTelescopeAPGTO.IsGoto:Boolean;
begin
Result:=True;
end;

function TTelescopeAPGTO.NumberOfSpeedButtons:Integer;
begin
Result:=4;
end;

function TTelescopeAPGTO.CaptionOfSpeedButtonNumber(Number:Integer):PChar;
begin
case Number of
   1:Result:=PChar(lang('Pointer'));
   2:Result:=PChar(lang('Chercher'));
   3:Result:=PChar(lang('Centrer'));
   4:Result:=PChar(lang('Guider'));
   end;
end;

function TTelescopeAPGTO.GetTrackSpeedNumber:Integer;
begin
Result:=4;
end;

function TTelescopeAPGTO.GetCenterSpeedNumber:Integer;
begin
Result:=3;
end;

function TTelescopeAPGTO.GetName:PChar;
begin
Result:=PChar('APGTO'); //nolang
end;

//******************************************************************************
//**************************        Interface PISCO       **********************
//******************************************************************************

constructor TTelescopePISCO.Create;
begin
   inherited Create;
end;

procedure TTelescopePISCO.SetComPort(ComPort:string);
begin
end;

procedure TTelescopePISCO.SetComAdress(ComAdress:string);
begin
   AdressComStr:=ComAdress;
   AdressCom:=StrToInt('$'+AdressComStr);
end;

procedure TTelescopePISCO.SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                    _ReadTotalTimeoutMultiplier:DWord;
                                    _ReadTotalTimeoutConstant:DWord;
                                    _WriteTotalTimeoutMultiplier:DWord;
                                    _WriteTotalTimeoutConstant:DWord);
begin
end;

procedure TTelescopePISCO.SetSerialPortComm(_BaudRate:DWord;
                                 _ByteSize:Byte;
                                 _Parity:Byte;
                                 _StopBits:Byte);
begin
end;

function TTelescopePISCO.Open:Boolean;
begin
InitCom(AdressCom);
Result:=True;
end;

procedure TTelescopePISCO.Close;
begin
end;

function TTelescopePISCO.IsConnectedAndOK:Boolean;
begin
   Result:=True;
end;

function TTelescopePISCO.Getpos(var Alpha,Delta:Double):Boolean;
begin
   Alpha:=0;
   Delta:=0;
   Result:=True;
end;

function TTelescopePISCO.GotoAlphaDelta(Alpha,Delta:Double):Boolean;
begin
   Result:=True;
end;

function TTelescopePISCO.Sync(Alpha,Delta:Double):Boolean;
begin
   Result:=True;
end;

function TTelescopePISCO.ToggleLongFormat:Boolean;
begin
   Result:=False;
end;

function TTelescopePISCO.IsLongFormat:Boolean;
begin
   Result:=True;
end;

function TTelescopePISCO.StartMotion(Direction:string):Boolean;
begin
   case Speed of
      1:begin
        if Uppercase(Direction)='E' then AdPlusFast(AdressCom);
        if Uppercase(Direction)='W' then AdMoinsFast(AdressCom);
        if Uppercase(Direction)='N' then DecPlusFast(AdressCom);
        if Uppercase(Direction)='S' then DecMoinsFast(AdressCom);
        end;
      2:begin
        if Uppercase(Direction)='E' then AdPlus(AdressCom);
        if Uppercase(Direction)='W' then AdMoins(AdressCom);
        if Uppercase(Direction)='N' then DecPlus(AdressCom);
        if Uppercase(Direction)='S' then DecMoins(AdressCom);
        end;
      end;
   Result:=True;
end;

function TTelescopePISCO.StopMotion(Direction:string):Boolean;
begin
   RazCom(AdressCom);
   Result:=True;
end;

function TTelescopePISCO.SetSpeed(Speed:Integer):Boolean;
begin
   Result:=False;
end;

function TTelescopePISCO.Quit:Boolean;
begin
   RazCom(AdressCom);
   Result:=True;
end;

//function TTelescopePISCO.MotionRate(Rate:string):Boolean;
function TTelescopePISCO.MotionRate(ButtonNumber:Integer):Boolean;
begin
   Result:=True;
   case ButtonNumber of
      1:Speed:=1;
      2:Speed:=2;
      else
        begin
        Result:=False;
        WriteSpy('PiscoMotionRate : '+ //nolang
           lang('Vitesse invalide'));
        Busy:=False;
        Exit;
        end;
      end;
end;

function TTelescopePISCO.IsBusy:Boolean;
begin
Result:=Busy;
end;

function TTelescopePISCO.CanGoToShortFormat:Boolean;
begin
Result:=False;
end;

function TTelescopePISCO.CanSetSpeed:Boolean;
begin
Result:=False;
end;

function TTelescopePISCO.GetGuideSpeed:Double;
begin
Result:=2;
end;

function TTelescopePISCO.NeedComName:Boolean;
begin
Result:=False;
end;

function TTelescopePISCO.NeedComTimeOuts:Boolean;
begin
Result:=False;
end;

function TTelescopePISCO.NeedComComm:Boolean;
begin
Result:=False;
end;

function TTelescopePISCO.NeedComAdress:Boolean;
begin
Result:=True;
end;

function TTelescopePISCO.StoreCoordinates:Boolean;
begin
Result:=False;
end;

function TTelescopePISCO.IsGoto:Boolean;
begin
Result:=False;
end;

function TTelescopePISCO.NumberOfSpeedButtons:Integer;
begin
Result:=2;
end;

function TTelescopePISCO.CaptionOfSpeedButtonNumber(Number:Integer):PChar;
begin
case Number of
   1:Result:=PChar(lang('Chercher'));
   2:Result:=PChar(lang('Centrer'));
   end;
end;

function TTelescopePISCO.GetTrackSpeedNumber:Integer;
begin
Result:=2;
end;

function TTelescopePisco.GetCenterSpeedNumber:Integer;
begin
Result:=1;
end;

function TTelescopePisco.GetName:PChar;
begin
Result:=PChar('Pisco'); //nolang
end;

//******************************************************************************
//**************************      Telescope AutoStar      **********************
//******************************************************************************

constructor TTelescopeAutoStar.Create;
begin
   inherited Create;
end;

procedure TTelescopeAutoStar.SetComPort(ComPort:string);
begin
   NomCom:=ComPort;
end;

procedure TTelescopeAutoStar.SetComAdress(ComAdress:string);
begin
   AdressComStr:=ComAdress;
end;

procedure TTelescopeAutoStar.SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                    _ReadTotalTimeoutMultiplier:DWord;
                                    _ReadTotalTimeoutConstant:DWord;
                                    _WriteTotalTimeoutMultiplier:DWord;
                                    _WriteTotalTimeoutConstant:DWord);
begin
   InReadIntervalTimeout         :=_ReadIntervalTimeout;
   InReadTotalTimeoutMultiplier  :=_ReadTotalTimeoutMultiplier;
   InReadTotalTimeoutConstant    :=_ReadTotalTimeoutConstant;
   InWriteTotalTimeoutMultiplier :=_WriteTotalTimeoutMultiplier;
   InWriteTotalTimeoutConstant   :=_WriteTotalTimeoutConstant;
end;

procedure TTelescopeAutoStar.SetSerialPortComm(_BaudRate:DWord;
                                 _ByteSize:Byte;
                                 _Parity:Byte;
                                 _StopBits:Byte);
begin
   BaudRate:=_BaudRate;
   ByteSize:=_ByteSize;
   Parity:=_Parity;
   StopBits:=_StopBits;
end;

function TTelescopeAutoStar.Open:Boolean;
var
   Errb:Boolean;
   DCB:TDCB;
   CommTimeouts:TCommTimeouts;
   MyTimeOut:TDateTime;
   i:DWord;
   c:Char;
   BufRead:array[0..99] of char;
   NumberOfBytesRead:Cardinal;
begin
   MyTimeOut:=Time;
   while (PortSerieIsReserve(NomCom)) and (Time<MyTimeOut+0.5/24/3600) do;
   if (Time>=MyTimeOut+0.5/24/3600) then
      begin
      CloseHandle(hCom);
      LiberePortSerie(NomCom);
      WriteSpy(lang('Impossible de libérer le port série ')+NomCom);
      WriteSpy(lang('Je tente de l''ouvrir quand même'));
      end;
   HCom:=CreateFile(PChar(NomCom),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,0,0);
   ReservePortSerie(NomCom);
   Errb:=GetCommState(hCom,DCB);
   if not Errb then
      begin
      WriteSpy(lang('Impossible d''ouvrir le port série ')+NomCom);
      Result:=False;
      Exit;
      end;

   i:=DCB.DCBlength;
   DCB.BaudRate:=BaudRate;
   i:=DCB.Flags;
   i:=DCB.XonLim;
   i:=DCB.XoffLim;
   DCB.ByteSize:=ByteSize;
   DCB.Parity  :=Parity;
   DCB.StopBits:=StopBits;
   c:=DCB.XonChar;
   c:=DCB.XoffChar;
   c:=DCB.EofChar;
   c:=DCB.EvtChar;

   SetCommState(hCom,DCB);
   SetCommMask (hCom,0);

   with CommTimeouts do
      begin
      ReadIntervalTimeout        :=InReadIntervalTimeout        ;  // 0
      ReadTotalTimeoutMultiplier :=InReadTotalTimeoutMultiplier ;  // 0
      ReadTotalTimeoutConstant   :=InReadTotalTimeoutConstant   ;  // 250
      WriteTotalTimeoutMultiplier:=InWriteTotalTimeoutMultiplier;  // 0
      WriteTotalTimeoutConstant  :=InWriteTotalTimeoutConstant  ;  // 500
      end;

   SetCommTimeouts(hCom,CommTimeouts);
   FlushFileBuffers(hCom);
   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
end;

procedure TTelescopeAutoStar.Close;
begin
   FlushFileBuffers(hCom);
   CloseHandle(hCom);
   LiberePortSerie(NomCom);
end;

function TTelescopeAutoStar.IsConnectedAndOK:Boolean;
var
   Alpha,Delta:Double;
begin
   if GetPos(Alpha,Delta) then Result:=True else Result:=False;
end;

function TTelescopeAutoStar.Getpos(var Alpha,Delta:Double):Boolean;
var
   S,Line:string;
   AlphaH,AlphaM,AlphaS:Double;
   DeltaD,DeltaM,DeltaS:Double;
   Err,i,j:Integer;

   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;

   LLine,MyMessage:string;
begin
   Busy:=True;
   try

//   if InGetPos then Exit;
//   InGetPos:=True;

   Result:=True;

   FlushFileBuffers(hCom);
   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);

   //Alpha
   BufWrite[0]:='#';BufWrite[1]:=':';BufWrite[2]:='G';BufWrite[3]:='R';BufWrite[4]:='#';

   WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];

   if NumberOfBytesWrite<5 then
      begin
      Result:=False;
      MyMessage:='AutostarGetPos : '+ //nolang
         'Le télescope n''accepte pas la demande de la coordonnée Alpha';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   if IsInLongFormat then
      begin
      // HH:MM:SS# 9 caracteres
      // BufRead de 0 a 8
      ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesRead);
      for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
      end
   else
      begin
      // HH:MM.S# 8 caracteres
      // BufRead de 0 a 7
      ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesRead);
      for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
      end;

   if IsInLongFormat then
      begin
      // Alpha : HH:MM:SS#
      SetLength(S,9);
      Move(BufRead[0],S[1],9);

      Val(Copy(S,1,2),AlphaH,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='AutostarGetPos : '+ //nolang
            lang('Conversion des heures Alpha impossible : /')+Copy(S,1,2)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;
      Val(Copy(S,4,2),AlphaM,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='AutostarGetPos : '+ //nolang
            lang('Conversion des minutes Alpha impossible : /')+Copy(S,4,2)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;
      Val(Copy(S,7,2),AlphaS,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='AutostarGetPos : '+ //nolang
            lang('Conversion des dixièmes de minute Alpha impossible : /')+Copy(S,7,2)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;

      Alpha:=(AlphaH+(AlphaM/60)+(AlphaS/3600)); // Heure
      end
   else
      begin
      // Alpha : HH:MM:S#
      SetLength(S,8);
      Move(BufRead[0],S[1],8);

      Val(Copy(S,1,2),AlphaH,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='AutostarGetPos : '+ //nolang
            lang('Conversion des heures Alpha impossible : /')+Copy(S,1,2)+'/';
         WriteSpy(MyMessage);
         Exit;
         Busy:=False;
         Exit;
         end;
      Val(Copy(S,4,2),AlphaM,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='AutostarGetPos : '+ //nolang
            lang('Conversion des minutes Alpha impossible : /')+Copy(S,4,2)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;
      Val(Copy(S,7,1),AlphaS,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='AutostarGetPos : '+ //nolang
            lang('Conversion des dixièmes de minute Alpha impossible : /')+Copy(S,7,1)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;

      Alpha:=(AlphaH+(AlphaM/60)+(AlphaS/600)); // Heure
      end;


   //Delta
   BufWrite[0]:='#';BufWrite[1]:=':';BufWrite[2]:='G';BufWrite[3]:='D';BufWrite[4]:='#';

   WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];

   if NumberOfBytesWrite<5 then
      begin
      Result:=False;
      MyMessage:='AutostarGetPos : Le télescope n''accepte pas la demande de la coordonnee Delta';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   if IsInLongFormat then
      begin
      // sDD*MM:SS# 10 caracteres
      // BufRead de 9 a 19
      ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesRead);
      for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
      end
   else
      begin
      // sDD*MM# 7 caracteres
      // BufRead de 8 a 15
      ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesRead);
      for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
      end;

   if IsInLongFormat then
      begin
      // Delta : sDD*MM:SS#
      SetLength(S,10);
      Move(BufRead[0],S[1],10);

      Val(Copy(S,1,3),DeltaD,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='AutostarGetPos : '+ //nolang
            lang('Conversion des degrés Delta impossible : /')+Copy(S,10,3)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;
      Val(Copy(S,5,2),DeltaM,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='AutostarGetPos : '+ //nolang
            lang('Conversion des minutes Delta impossible : /')+Copy(S,14,2)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;
      Val(Copy(S,8,2),DeltaS,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='AutostarGetPos : '+ //nolang
            lang('Conversion des minutes Delta impossible : /')+Copy(S,17,2)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;

      if s[1]='+' then Delta:=DeltaD+(deltaM/60)+(DeltaS/3600) else Delta:=DeltaD-(DeltaM/60)-(DeltaS/3600); // Degre
      end
   else
      begin
      // Delta : sDD*MM#
      SetLength(S,7);
      Move(BufRead[0],S[1],7);

      Val(Copy(S,1,3),DeltaD,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='AutostarGetPos : '+ //nolang
            lang('Conversion des degrés Delta impossible : /')+Copy(S,9,3)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;
      Val(Copy(S,5,2),DeltaM,Err);
      if Err<>0 then
         begin
         Result:=False;
         MyMessage:='AutostarGetPos : '+ //nolang
            lang('Conversion des minutes Delta impossible : /')+Copy(S,13,2)+'/';
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;

      if s[1]='+' then Delta:=DeltaD+(deltaM/60) else Delta:=DeltaD-(DeltaM/60); // Degre
      end;

   finally
   Busy:=False;
   end;
//   InGetPos:=False;
end;

function TTelescopeAutoStar.GotoAlphaDelta(Alpha,Delta:Double):Boolean;
var
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;

   AlphaH,AlphaM,AlphaS:Integer;
   DeltaD,DeltaM,DeltaS:Integer;
   Sign:Char;
   InterStr:string;

   i,j:Integer;
   Line,MyMessage:string;

   Alpha1,Delta1,Alpha2,Delta2,Dist,Dist1:Double;

   TimeInit:TDateTime;
begin
  Busy:=True;
  Result:=True;
  InternalError:=0;
  try

//  Alpha1:=Config.AlphaScope;
//  Delta1:=Config.DeltaScope;

  // Deja sur les coordonnees
//  if ((Abs(Alpha-Alpha1)<Config.ErreurPointingAlpha/3600) and  // Secondes -> heures
//     (Abs(Delta-Delta1)<Config.ErreurPointingDelta/3600)) then Exit; // Secondes -> degres

//  Dist:=Arccos(Sin(Delta/180*pi)*Sin(Delta1/180*pi)+(Cos(Delta/180*pi)*Cos(Delta1/180*pi)
//           *Cos(Alpha*15/180*pi-Alpha1*15/180*pi)))/pi*180;

   FlushFileBuffers(hCom);

   AlphaH:=Trunc(Alpha);
   AlphaM:=Trunc((Alpha-AlphaH)*60);
   if IsInLongFormat then
      begin
      AlphaS:=Trunc(((Alpha-AlphaH)*60-AlphaM)*60);
      if Delta>=0 then
         begin
         DeltaD:=Trunc(Delta);
         DeltaM:=Trunc((Delta-DeltaD)*60);
         DeltaS:=Trunc(((Delta-DeltaD)*60-DeltaM)*60);
         Sign:='+';
         end
      else
         begin
         DeltaD:=Trunc(-Delta);
         DeltaM:=Trunc((-Delta-DeltaD)*60);
         Sign:='-';
         end;
      end
   else
      begin
      AlphaS:=Trunc(((Alpha-AlphaH)*60-AlphaM)*10);
      if Delta>=0 then
         begin
         DeltaD:=Trunc(Delta);
         DeltaM:=Trunc((Delta-DeltaD)*60);
         Sign:='+';
         end
      else
         begin
         DeltaD:=Trunc(-Delta);
         DeltaM:=Trunc((-Delta-DeltaD)*60);
         Sign:='-';
         end;
      end;

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='S';
   BufWrite[3]:='r';
   BufWrite[4]:=' ';

   // Alpha : /:Sr HH:MM.S#/ ou /:Sr HH:MM:SS#/
//   Str(AlphaH:1,InterStr);         // Marty
   InterStr:=IntToStr(AlphaH);         // Marty
   if AlphaH<10 then
      begin
      BufWrite[5]:='0';
      Inc(i);
      BufWrite[6]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[5]:=InterStr[1];
      Inc(i);
      BufWrite[6]:=InterStr[2];
      Inc(i);
      end;                         // Marty

   BufWrite[7]:=':';
   InterStr:=IntToStr(AlphaM);
//   Str(AlphaM:1,InterStr);
   if AlphaM<10 then
      begin
      BufWrite[8]:='0';
      Inc(i);
      BufWrite[9]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[8]:=InterStr[1];
      Inc(i);
      BufWrite[9]:=InterStr[2];
      Inc(i);
      end;                         // Marty
   BufWrite[10]:=':';
   Inc(i);

   if IsInLongFormat then
      begin
//      Str(AlphaS:2,InterStr);
      InterStr:=IntToStr(AlphaS);
      if AlphaS<10 then
         begin
         BufWrite[11]:='0';
         Inc(i);
         BufWrite[12]:=InterStr[1];
         Inc(I);
         end
      else
         begin
         BufWrite[11]:=InterStr[1];
         Inc(i);
         BufWrite[12]:=InterStr[2];
         Inc(i);
         end;                         // Marty
      BufWrite[13]:='#';
      WriteFile(hCom,BufWrite[0],14,NumberOfBytesWrite,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesWrite);
      for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
      WriteSpy('AutostarGoto : '+ //nolang
         lang('Envoi de : /')+Line+'/');

      if NumberOfBytesWrite<14 then
         begin
         Result:=False;
         MyMessage:=lang('AutostarGoto : Le télescope refuse les coordonnées Alpha');
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;
      end
   else
      begin
//      Str(AlphaS:1,InterStr);
      InterStr:=IntToStr(AlphaS);
      BufWrite[11]:=InterStr[1];
      BufWrite[12]:='#';

      WriteFile(hCom,BufWrite[0],13,NumberOfBytesWrite,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesWrite);
      for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
      WriteSpy('AutostarGoto : '+ //nolang
         lang('Envoi de : /')+Line+'/');

      if NumberOfBytesWrite<13 then
         begin
         Result:=False;
         MyMessage:='AutostarGoto : '+ //nolang
            lang('Le télescope refuse les coordonnées Alpha');
         WriteSpy(MyMessage);
         Busy:=False;
         Exit;
         end;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('AutostarGoto : '+ //nolang
      lang('Réception de : /')+Line+'/');

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='S';
   BufWrite[3]:='d';
   BufWrite[4]:=' ';
   BufWrite[5]:=Sign;
//   Str(DeltaD:1,InterStr);
   InterStr:=IntToStr(DeltaD);

   i:=6;
   if (DeltaD<10) then
      begin
      BufWrite[i]:='0';
      Inc(i);
      BufWrite[i]:=InterStr[1];
      Inc(i);
      end
   else
      begin
      BufWrite[i]:=InterStr[1];
      Inc(i);
      BufWrite[i]:=InterStr[2];
      Inc(i);
      end;
   BufWrite[i]:=#223;
//    BufWrite[i]:='*';
   Inc(i);
//   Str(DeltaM:1,InterStr);
   InterStr:=IntToStr(DeltaM);
   if DeltaM<10 then
      begin
      BufWrite[i]:='0';
      Inc(i);
      BufWrite[i]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[i]:=InterStr[1];
      Inc(i);
      BufWrite[i]:=InterStr[2];
      Inc(i);
      end;
   BufWrite[i]:=':';
   Inc(i);
   if IsInLongFormat then
      begin
//      Str(DeltaS:1,InterStr);
      InterStr:=IntToStr(DeltaS);
      if DeltaS<10 then
         begin
         BufWrite[i]:='0';
         Inc(i);
         BufWrite[i]:=InterStr[1];
         Inc(I);
         end
      else
         begin
         BufWrite[i]:=InterStr[1];
         Inc(i);
         BufWrite[i]:=InterStr[2];
         Inc(i);
         end;
      end;
   BufWrite[i]:='#';
   Inc(i);

   WriteFile(hCom,BufWrite[0],i,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('AutostarGoto : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<i then
      begin
      Result:=False;
      MyMessage:='AutostarGoto : '+ //nolang
         lang('Le télescope refuse les coordonnées Delta');
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('AutostarGoto : '+ //nolang
      lang('Réception de : /')+Line+'/');

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='M';
   BufWrite[3]:='S';
   BufWrite[4]:='#';
   WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('AutostarGoto : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<5 then
      begin
      Result:=False;
      MyMessage:='AutostarGoto : '+ //nolang
         lang('Le télescope refuse la demande de déplacement');
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On vide
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('AutostarGoto : '+ //nolang
      lang('Réception de : /')+Line+'/');

   if BufRead[0]='0' then
      begin
// Je vire ca pour l'instant
// A rajouter eventuellement a un niveau superieur
{      if not GetPos(Alpha2,Delta2) then
         begin
         WriteSpy('AutoStarGoto : '+ //nolang
            Lang('Le télescope ne veut pas donner sa position : Pointage annulé'));
         Result:=False;
         Busy:=False;
         Exit;
         end;

      i:=0;
      j:=0;
      while ((Abs(Alpha-Alpha2)>Config.ErreurPointingAlpha/3600) or // 6
         (Abs(Delta-Delta2)>Config.ErreurPointingDelta/3600)) //and not(Bloque) // 60
         do
         begin
         Alpha1:=Alpha2;
         Delta1:=Delta2;
         if not GetPos(Alpha2,Delta2) then
            begin
            WriteSpy(lang('Pointe : Le télescope ne veut pas donner sa position : Pointage annulé'));
            Result:=false;
            Busy:=False;
            Exit;
            end;
         // Ca a merdé
         if not(Config.TelescopeBranche) then
            begin
            Inc(i);
            WriteSpy('AutostarGoto : '+ //nolang
               lang('Télescope débranché = ')+IntToStr(i));
            end;
         // Si ca a merde plus de 10 fois on arrete
         if i>10 then
            begin
            Result:=False;
            Busy:=False;
            MyMessage:='AutostarGoto : '+ //nolang
               lang('Le téléscope ne reponds plus');
            WriteSpy(MyMessage);
            Exit;
            end;
         // On accepte que ca merde
         Config.TelescopeBranche:=True;
         // On attends 1 s
         TimeInit:=Time;
         while Time<TimeInit+1500/1000/60/60/24 do;

         // Le telescope est il en mouvement
         if (Alpha1-Alpha2=0) and
            (Delta1-Delta2=0) then
            begin
            Inc(j);
            WriteSpy('AutostarGoto : '+ //nolang
               lang('Télescope arrêté = ')+IntToStr(j));
            end;

         // Si le telescope n'a pas bouge pendant plus de 5 coups, il est bloque
         if j>5 then
            begin
            Result:=False;
            Busy:=False;
            MyMessage:='AutostarGoto : '+ //nolang
               lang('Télescope considéré comme bloqué. Augmentez la tolérance de pointage. Reconnectez le télescope');
            WriteSpy(MyMessage);
            Exit;
            end;
         end;}
      end;
   if BufRead[0]='1' then
      begin
      InternalError:=1;
      end;

   finally
   Busy:=False;
   end;
end;

function TTelescopeAutoStar.Sync(Alpha,Delta:Double):Boolean;
var
   i,j:Integer;
   AlphaH,AlphaM,AlphaS:Integer;
   DeltaD,DeltaM,DeltaS:Integer;
   Sign:Char;
   InterStr:String;

   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   Line,MyMessage:string;
begin
   Busy:=True;
   try

   Result:=True;

   WriteSpy('AutostarUpdate : '+ //nolang
      lang('Début du réalignement sur ')+AlphaToSTr(Alpha)+'/'+DeltaToStr(Delta));

   FlushFileBuffers(hCom);

   AlphaH:=Trunc(Alpha);
   AlphaM:=Trunc((Alpha-AlphaH)*60);
   if IsInLongFormat then
      begin
      AlphaS:=Trunc(((Alpha-AlphaH)*60-AlphaM)*60);
      if Delta>=0 then
         begin
         DeltaD:=Trunc(Delta);
         DeltaM:=Trunc((Delta-DeltaD)*60);
         DeltaS:=Trunc(((Delta-DeltaD)*60-DeltaM)*60);
         Sign:='+';
         end
      else
         begin
         DeltaD:=Trunc(-Delta);
         DeltaM:=Trunc((-Delta-DeltaD)*60);
         DeltaS:=Trunc(((-Delta-DeltaD)*60-DeltaM)*60);
         Sign:='-';
         end;
      end
   else
      begin
      AlphaS:=Trunc(((Alpha-AlphaH)*60-AlphaM)*10);
      if Delta>=0 then
         begin
         DeltaD:=Trunc(Delta);
         DeltaM:=Trunc((Delta-DeltaD)*60);
         Sign:='+';
         end
      else
         begin
         DeltaD:=Trunc(-Delta);
         DeltaM:=Trunc((-Delta-DeltaD)*60);
         Sign:='-';
         end;
      end;

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='S';
   BufWrite[3]:='r';
   BufWrite[4]:=' ';

   // Alpha : /:Sr HH:MM.S#/ ou /:Sr HH:MM:SS#/
   InterStr:=IntToStr(AlphaH);         // Marty
   if AlphaH<10 then
      begin
      BufWrite[5]:='0';
      Inc(i);
      BufWrite[6]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[5]:=InterStr[1];
      Inc(i);
      BufWrite[6]:=InterStr[2];
      Inc(i);
      end;                         // Marty

   BufWrite[7]:=':';
   InterStr:=IntToStr(AlphaM);
   if AlphaM<10 then
      begin
      BufWrite[8]:='0';
      Inc(i);
      BufWrite[9]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[8]:=InterStr[1];
      Inc(i);
      BufWrite[9]:=InterStr[2];
      Inc(i);
      end;                         // Marty

   BufWrite[10]:=':';
   Inc(i);

   if IsInLongFormat then
      begin
      InterStr:=IntToStr(AlphaS);
      if AlphaS<10 then
         begin
         BufWrite[11]:='0';
         Inc(i);
         BufWrite[12]:=InterStr[1];
         Inc(i);
         end
      else
         begin
         BufWrite[11]:=InterStr[1];
         Inc(i);
         BufWrite[12]:=InterStr[2];
         Inc(i);
         end;
      BufWrite[13]:='#';

      WriteFile(hCom,BufWrite[0],14,NumberOfBytesWrite,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesWrite);
      for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
      WriteSpy('AutostarUpdate : '+ //nolang
         lang('Envoi de : /')+Line+'/');

      if NumberOfBytesWrite<14 then
         begin
         Result:=False;
         Busy:=False;
         MyMessage:='AutostarUpdate : '+ //nolang
            lang('Le télescope refuse les coordonnées Alpha');
         WriteSpy(MyMessage);
         Exit;
         end;
      end
   else
      begin
      InterStr:=IntToStr(AlphaS);      
      BufWrite[11]:=InterStr[1];
      BufWrite[12]:='#';

      WriteFile(hCom,BufWrite[0],14,NumberOfBytesWrite,nil);
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesWrite);
      for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
      WriteSpy('AutostarUpdate : '+ //nolang
         lang('Envoi de : /')+Line+'/');
      
      if NumberOfBytesWrite<14 then
         begin
         Result:=False;
         Busy:=False;
         MyMessage:='AutostarUpdate : '+ //nolang
            lang('Le télescope refuse les coordonnées Alpha');
         WriteSpy(MyMessage);
         Exit;
         end;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('AutostarUpdate : '+ //nolang
      lang('Réception de : /')+Line+'/');

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='S';
   BufWrite[3]:='d';
   BufWrite[4]:=' ';
   BufWrite[5]:=Sign;
   InterStr:=IntToStr(DeltaD);

   i:=6;
   if (DeltaD<10) then
      begin
      BufWrite[i]:='0';
      Inc(i);
      BufWrite[i]:=InterStr[1];
      Inc(i);
      end
   else
      begin
      BufWrite[i]:=InterStr[1];
      Inc(i);
      BufWrite[i]:=InterStr[2];
      Inc(i);
      end;
   BufWrite[i]:=#223;
//    BufWrite[i]:='*';
   Inc(i);
   InterStr:=IntToStr(DeltaM);   
   if DeltaM<10 then
      begin
      BufWrite[i]:='0';
      Inc(i);
      BufWrite[i]:=InterStr[1];
      Inc(I);
      end
   else
      begin
      BufWrite[i]:=InterStr[1];
      Inc(i);
      BufWrite[i]:=InterStr[2];
      Inc(i);
      end;

   if IsInLongFormat then
      begin
      BufWrite[i]:=':';
      Inc(i);

      InterStr:=IntToStr(DeltaS);
      if DeltaS<10 then
         begin
         BufWrite[i]:='0';
         Inc(i);
         BufWrite[i]:=InterStr[1];
         Inc(i);
         end
      else
         begin
         BufWrite[i]:=InterStr[1];
         Inc(i);
         BufWrite[i]:=InterStr[2];
         Inc(i);
         end;
      end;
   BufWrite[i]:='#';
   Inc(i);

   WriteFile(hCom,BufWrite[0],i,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('AutostarUpdate : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<i then
      begin
      Result:=False;
      Busy:=False;
      MyMessage:='AutostarUpdate : '+ //nolang
         lang('Le télescope refuse la mise à jour des coordonnées Delta');
      WriteSpy(MyMessage);
      Exit;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('AutostarUpdate : '+ //nolang
      lang('Réception de : /')+Line+'/');

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='C';
   BufWrite[3]:='M';
   BufWrite[4]:='#';
   WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('AutostarUpdate : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<5 then
      begin
      Result:=False;
      Busy:=False;
      MyMessage:='AutostarUpDate : '+ //nolang
         lang('Le télescope refuse la commande de mise à jour');
      WriteSpy(MyMessage);
      Exit;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('AutostarUpdate : '+ //nolang
      lang('Réception de : /')+Line+'/');

   WriteSpy('AutostarUpDate : '+ //nolang
      lang('Mise à jour des coordonnées du télescope réussie à ')+
      AlphaToStr(Alpha)+'/'+DeltaToStr(Delta));

   FlushFileBuffers(hCom);
   
   finally
   Busy:=False;
   end;
end;

function TTelescopeAutoStar.ToggleLongFormat:Boolean;
var
   BufWrite:array[0..4] of char;
   NumberOfBytesWrite:Cardinal;
   Line,MyMessage:string;
   j:Integer;
begin
   Busy:=True;
   try

   Result:=True;

   FlushFileBuffers(hCom);

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='U';
   BufWrite[3]:='#';

   WriteFile(hCom,BufWrite[0],4,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('AutostarToggleLongFormat : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<4 then
      begin
      Result:=False;
      MyMessage:='AutostarToggleLongFormat : '+ //nolang
         lang('Le télescope refuse la commande');
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   IsInLongFormat:=not(IsInLongFormat);

   finally
   Busy:=False;
   end;
end;

function TTelescopeAutoStar.IsLongFormat:Boolean;
var
   S:String;

   BufWrite:array[0..5] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;

   j:Integer;
   Line,MyMessage:string;
begin
   Busy:=True;
   try

   Result:=True;

   FlushFileBuffers(hCom);
   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   
   //Alpha
   BufWrite[0]:='#';BufWrite[1]:=':';BufWrite[2]:='G';BufWrite[3]:='R';BufWrite[4]:='#';

   WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('AutostarIsLongFormat : '+ //nolang
      lang('Envoi de : /')+Line+'/');


   if NumberOfBytesWrite<5 then
      begin
      Result:=False;
      MyMessage:='AutostarIsLongFormat : '+ //nolang
         'Le télescope n''accepte pas la demande de la coordonnée Alpha';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('AutostarIsLongFormat : '+ //nolang
      lang('Réception de : /')+Line+'/');

   SetLength(S,8);
   Move(BufRead[0],S[1],8);

   if S[6]='.' then
      begin
      Result:=False;
      WriteSpy('AutostarIsLongFormat : '+ //nolang
         lang('Le télescope est au format court'));
      IsInLongFormat:=False;
      end
   else
      begin
      WriteSpy('AutostarIsLongFormat : '+ //nolang
         lang('Le télescope est au format long'));
      IsInLongFormat:=True;
      end;

   finally
   Busy:=False;
   end;
end;

function TTelescopeAutoStar.StartMotion(Direction:string):Boolean;
var
   BufWrite:array[0..12] of char;
   NumberOfBytesWrite:Cardinal;
   Line,MyMessage:string;
   j:Integer;
begin
   Busy:=True;
   try

   Result:=True;

   FlushFileBuffers(HCom);

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='M';
   if Uppercase(Direction)='E' then BufWrite[3]:='e' else
   if Uppercase(Direction)='W' then BufWrite[3]:='w' else
   if Uppercase(Direction)='N' then BufWrite[3]:='n' else
   if Uppercase(Direction)='S' then BufWrite[3]:='s' else
      begin
      WriteSpy('AutoStarStartMotion : '+ //nolang
         lang('Direction inconnue'));
      Result:=False;
      Busy:=False;
      Exit;
      end;
   BufWrite[4]:='#';
   WriteFile(HCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('AutostarStartMotion : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<>5 then
      begin
      Result:=False;
      MyMessage:='AutostarStartMotion : '+ //nolang
         'Le télescope n''accepte pas la demande de déplacement';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   finally
   Busy:=False;
   end;
end;

function TTelescopeAutoStar.StopMotion(Direction:string):Boolean;
var
   BufWrite:array[0..12] of char;
   NumberOfBytesWrite:Cardinal;
   Line,MyMessage:string;
   j:Integer;
begin
   Busy:=True;
   try

   Result:=True;   
   
   FlushFileBuffers(HCom);
   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='Q';
   if Uppercase(Direction)='E' then BufWrite[3]:='e' else
   if Uppercase(Direction)='W' then BufWrite[3]:='w' else
   if Uppercase(Direction)='N' then BufWrite[3]:='n' else
   if Uppercase(Direction)='S' then BufWrite[3]:='s' else
      begin
      WriteSpy('LX200StopMotion : '+ //nolang
         lang('Direction inconnue'));
      Result:=False;
      Busy:=False;
      Exit;
      end;
   BufWrite[4]:='#';
   WriteFile(HCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('AutostarStopMotion : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<>5 then
      begin
      Result:=False;
      MyMessage:='AutostarStopMotion : '+ //nolang
         'Le télescope n''accepte pas la demande d''arrêt';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   finally
   Busy:=False;
   end;
end;

function TTelescopeAutoStar.SetSpeed(Speed:Integer):Boolean;
var
   BufWrite:array[0..12] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   LLine,StrSpeed,MyMessage:string;
   Line:string;
   j:Integer;
begin
   Busy:=True;
   try

   Result:=True;   

   FlushFileBuffers(HCom);

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='S';
   BufWrite[3]:='w';
   StrSpeed:=IntToStr(Speed);
   BufWrite[4]:=StrSpeed[1];
   BufWrite[5]:='#';
   WriteFile(HCom,BufWrite[0],6,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('AutostarSetSpeed : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<6 then
      begin
      Result:=False;
      MyMessage:='AutostarSetSpeed : '+ //nolang
         'Le télescope n''accepte pas le réglage de vitesse';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for j:=1 to NumberOfBytesRead do Line[j]:=BufRead[j-1];
   WriteSpy('AutostarSetSpeed : '+ //nolang
      lang('Réception de : /')+Line+'/');

   finally
   Busy:=False;
   end;
end;

function TTelescopeAutoStar.Quit:Boolean;
var
   BufWrite:array[0..3] of char;
   NumberOfBytesWrite:Cardinal;
   Line,MyMessage:string;
   j:Integer;
begin
   Busy:=True;
   try

   Result:=True;

   FlushFileBuffers(HCom);

   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='Q';
   BufWrite[3]:='#';
   WriteFile(HCom,BufWrite[0],4,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('AutostarQuit : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<4 then
      begin
      Result:=False;
      MyMessage:='AutostarQuit : '+ //nolang
         'Le télescope n''accepte pas la demande d''arrêt';
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   finally
   Busy:=False;
   end;
end;

function TTelescopeAutoStar.MotionRate(ButtonNumber:Integer):Boolean;
var
   BufWrite:array[0..12] of char;
   NumberOfBytesWrite:Cardinal;
   Line,MyMessage:string;
   j:Integer;
begin
   Busy:=True;
   try

   Result:=True;

   FlushFileBuffers(HCom);
   BufWrite[0]:='#';
   BufWrite[1]:=':';
   BufWrite[2]:='R';
   case ButtonNumber of
      1:BufWrite[3]:='g'; //S
      2:BufWrite[3]:='h'; //M
      3:BufWrite[3]:='i'; //C
      4:BufWrite[3]:='j'; //G
   else
      begin
      Result:=False;
      MyMessage:='AutostarMotionRate : '+ //nolang
         lang('Vitesse invalide');
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;
      end;

   BufWrite[4]:='#';
   WriteFile(HCom,BufWrite[0],5,NumberOfBytesWrite,nil);
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesWrite);
   for j:=1 to NumberOfBytesWrite do Line[j]:=BufWrite[j-1];
   WriteSpy('AutostarMotionRate : '+ //nolang
      lang('Envoi de : /')+Line+'/');

   if NumberOfBytesWrite<>5 then
      begin
      Result:=False;
      MyMessage:='AutostarMotionRate : '+ //nolang
         lang('Le télescope refuse le réglage de vitesse');
      WriteSpy(MyMessage);
      Busy:=False;
      Exit;
      end;

   WriteSpy('AutostarMotionRate : '+ //nolang
      lang('Vitesse = ')+IntToStr(ButtonNumber));

   finally
   Busy:=False;
   end;
end;

function TTelescopeAutoStar.IsBusy:Boolean;
begin
Result:=Busy;
end;

function TTelescopeAutoStar.CanGoToShortFormat:Boolean;
begin
Result:=True;
end;

function TTelescopeAutoStar.CanSetSpeed:Boolean;
begin
Result:=True;
end;

function TTelescopeAutoStar.GetGuideSpeed:Double;
begin
Result:=2;
end;

function TTelescopeAutoStar.NeedComName:Boolean;
begin
Result:=True;
end;

function TTelescopeAutoStar.NeedComTimeOuts:Boolean;
begin
Result:=True;
end;

function TTelescopeAutoStar.NeedComComm:Boolean;
begin
Result:=True;
end;

function TTelescopeAutoStar.NeedComAdress:Boolean;
begin
Result:=False;
end;

function TTelescopeAutoStar.StoreCoordinates:Boolean;
begin
Result:=True;
end;

function TTelescopeAutoStar.IsGoto:Boolean;
begin
Result:=True;
end;

function TTelescopeAutoStar.NumberOfSpeedButtons:Integer;
begin
Result:=4;
end;

function TTelescopeAutoStar.CaptionOfSpeedButtonNumber(Number:Integer):PChar;
begin
case Number of
   1:Result:=PChar(lang('Pointer'));
   2:Result:=PChar(lang('Chercher'));
   3:Result:=PChar(lang('Centrer'));
   4:Result:=PChar(lang('Guider'));
   end;
end;

function TTelescopeAutoStar.GetTrackSpeedNumber:Integer;
begin
Result:=4;
end;

function TTelescopeAutoStar.GetCenterSpeedNumber:Integer;
begin
Result:=3;
end;

function TTelescopeAutoStar.GetName:PChar;
begin
Result:=PChar('Autostar'); //nolang
end;


end.
