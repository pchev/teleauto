unit u_focusers;

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

uses SysUtils, Windows, Forms, Controls;

const
  mapAvant=0;
  mapArriere=1;
  mapRapide=2;
  mapLent=3;

type

  ErrorRoboFocus    = class(exception);
  ErrorLX200Focuser = class(exception);

//******************************************************************************
//**************************       Focuseur Generique      **********************
//******************************************************************************

  TFocuser=class(TObject)
    private
    InReadIntervalTimeout         : DWord;
    InReadTotalTimeoutMultiplier  : DWord;
    InReadTotalTimeoutConstant    : DWord;
    InWriteTotalTimeoutMultiplier : DWord;
    InWriteTotalTimeoutConstant   : DWord;

    public
    // Port Serie
    NomCom                      : string;
    HCom                        : Integer;
    BaudRate                    : DWord;
    ByteSize                    : Byte ;
    Parity                      : Byte ;
    StopBits                    : Byte ;

    Position                    : Integer;
    MaxPosition                 : Integer;

    Correction                  : Boolean;
    Inversion                   : Boolean;    

    InternalError               : byte;

    // FONCTIONS DE HAUT NIVEAU ABSENTES DU PLUGIN
    // Deplacement pendant le temps DelaiFoc en ms
    function FocuserMoveTime(Direction:Integer;Vitesse:Integer;DelaiFoc:Double):Boolean;
    function SetCorrectionOn:Boolean;
    function SetCorrectionOff:Boolean;
    function GetCorrection(var _Correction:Boolean):Boolean;
    function SetInversionOn:Boolean;
    function SetInversionOff:Boolean;
    function GetInversion(var _Inversion:Boolean):Boolean;

    // FONCTIONS DE BAS NIVEAU PRESENTES DANS LE PLUGIN
    // Fonctionnement
    constructor Create;
    function Open:Boolean;
    function Close:Boolean;
    function IsConnectedAndOK:Boolean; virtual; abstract;
    function GetErrorNumber:Integer; virtual; abstract;
    function GetError:PChar;

    // Reglages
    function SetComPort(ComPort:PChar):Boolean;
    function SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                  _ReadTotalTimeoutMultiplier:DWord;
                                  _ReadTotalTimeoutConstant:DWord;
                                  _WriteTotalTimeoutMultiplier:DWord;
                                  _WriteTotalTimeoutConstant:DWord):Boolean;
    function SetSerialPortComm(_BaudRate:DWord;
                               _ByteSize:Byte;
                               _Parity:Byte;
                               _StopBits:Byte):Boolean;
    function SetHandleCom(_HCom:Integer):Boolean; virtual; abstract;

    // Caracteristiques // Pas besoin de retour d'erreur
    function PasAPas:Boolean; virtual; abstract;
    function Has2Vitesses:Boolean; virtual; abstract;
    function UseComPort:Boolean; virtual; abstract;
    function IsDependantOfTheScope:Boolean; virtual; abstract;
    function MustSetMaxPosition:Boolean; virtual; abstract;
    function GetMinPosition:Integer; virtual; abstract;
    function GetMaxPosition:Integer; virtual; abstract;

    // Deplacements
    function GetPosition(var _Position:Integer):Boolean; virtual; abstract;
    function SetPosition(_Position:Integer):Boolean; virtual; abstract;
    function GotoPosition(_Position:Integer):Boolean; virtual; abstract;
    function SetMaxPosition(_MaxPosition:Integer):Boolean; virtual; abstract;
    function DeplaceMapTime(DirectionFocuser:Integer;SpeedFocuser:Integer):Boolean; virtual; abstract;
    function ArreteMapTime:Boolean; virtual; abstract;
    function DeplaceMapSteps(DirectionFocuser:Integer;StepsFocuser:Integer):Boolean; virtual; abstract;
    function SetBacklash(_BackLash:Integer):Boolean; virtual; abstract;
    function GetFirmware(_FirmWare:string):Boolean; virtual; abstract;
    end;

//******************************************************************************
//**************************         Focuseur LX200        **********************
//******************************************************************************

TFocuserLX200=class(TFocuser)
  public

    // FONCTIONS DE BAS NIVEAU PRESENTES DANS LE PLUGIN
    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function SetHandleCom(_HCom:Integer):Boolean; override;
    function GetErrorNumber:Integer; override;

    // Caracteristiques
    function PasAPas:Boolean; override;
    function Has2Vitesses:Boolean; override;
    function UseComPort:Boolean; override;
    function IsDependantOfTheScope:Boolean; override;
    function MustSetMaxPosition:Boolean; override;

    // Deplacements
    function DeplaceMapTime(DirectionFocuser:Integer;SpeedFocuser:Integer):Boolean; override;
    function ArreteMapTime:Boolean; override;

  end;

//******************************************************************************
//**************************        Focuseur LX200 GPS     **********************
//******************************************************************************

TFocuserLX200GPS=class(TFocuser)
  public

    // FONCTIONS DE BAS NIVEAU PRESENTES DANS LE PLUGIN
    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function SetHandleCom(_HCom:Integer):Boolean; override;
    function GetErrorNumber:Integer; override;    

    // Caracteristiques
    function PasAPas:Boolean; override;
    function Has2Vitesses:Boolean; override;
    function UseComPort:Boolean; override;
    function IsDependantOfTheScope:Boolean; override;
    function MustSetMaxPosition:Boolean; override;

    // Deplacements
    function DeplaceMapTime(DirectionFocuser:Integer;SpeedFocuser:Integer):Boolean; override;
    function ArreteMapTime:Boolean; override;

  end;

//******************************************************************************
//******************************       RoboFocus      **************************
//******************************************************************************

TFocuserRoboFocus=class(TFocuser)
  private
  public

    // FONCTIONS DE BAS NIVEAU PRESENTES DANS LE PLUGIN
    // Fonctionnement
    constructor Create;
    function  IsConnectedAndOK:Boolean; override;
    function SetHandleCom(_HCom:Integer):Boolean; override;
    function GetErrorNumber:Integer; override;

  // Caracteristiques
    function PasAPas:Boolean; override;
    function Has2Vitesses:Boolean; override;
    function UseComPort:Boolean; override;
    function IsDependantOfTheScope:Boolean; override;
    function MustSetMaxPosition:Boolean; override;
    function GetMinPosition:Integer; override;
    function GetMaxPosition:Integer; override;

  // Deplacements
    function DeplaceMapTime(DirectionFocuser:Integer;SpeedFocuser:Integer):Boolean; override;
    function ArreteMapTime:Boolean; override;
    function DeplaceMapSteps(DirectionFocuser:Integer;StepsFocuser:Integer):Boolean; override;
    function GetPosition(var _Position:Integer):Boolean; override;
    function SetPosition(_Position:Integer):Boolean; override;
    function GotoPosition(_Position:Integer):Boolean; override;
    function SetMaxPosition(_MaxPosition:Integer):Boolean; override;
    function SetBacklash(_BackLash:Integer):Boolean; override;
    function GetFirmware(_FirmWare:string):Boolean; override;

  end;

//******************************************************************************
//****************************         Plugin        ***************************
//******************************************************************************

TOpen                     = function:Boolean;                                                     cdecl;
TClose                    = function:Boolean;                                                     cdecl;
TSetHandleCom             = function(_HCom:Integer):Boolean;                                      cdecl;
TGetErrorNumber           = function:Integer;                                                     cdecl;
TSetComPort               = function(ComPort:string):Boolean;                                     cdecl;
TSetSerialPortTimeOut     = function(_ReadIntervalTimeout:DWord;
                                     _ReadTotalTimeoutMultiplier:DWord;
                                     _ReadTotalTimeoutConstant:DWord;
                                     _WriteTotalTimeoutMultiplier:DWord;
                                     _WriteTotalTimeoutConstant:DWord):Boolean;                   cdecl;
TIsConnectedAndOK         = function:Boolean;                                                     cdecl;
TPasAPas                  = function:Boolean;                                                     cdecl;
THas2Vitesses             = function:Boolean;                                                     cdecl;
TUseComPort               = function:Boolean;                                                     cdecl;
TIsDependantOfTheScope    = function:Boolean;                                                     cdecl;
TMustSetMaxPosition       = function:Boolean;                                                     cdecl;
TGetMinPosition           = function:Integer;                                                     cdecl;
TGetMaxPosition           = function:Integer;                                                     cdecl;
TDeplaceMapTime           = function(DirectionFocuser:Integer;SpeedFocuser:Integer):Boolean;      cdecl;
TArreteMapTime            = function:Boolean;                                                     cdecl;
TDeplaceMapSteps          = function(DirectionFocuser:Integer;StepsFocuser:Integer):Boolean;      cdecl;
TGetPosition              = function(var _Position:Integer):Boolean;                              cdecl;
TSetPosition              = function(_Position:Integer):Boolean;                                  cdecl;
TGotoPosition             = function(_Position:Integer):Boolean;                                  cdecl;
TSetMaxPosition           = function(_MaxPosition:Integer):Boolean;                               cdecl;
TSetBacklash              = function(_BackLash:Integer):Boolean;                                  cdecl;
TGetFirmware              = function(_FirmWare:string):Boolean;                                   cdecl;

var
   PluginOpen:TOpen;
   PluginClose:TClose;
   PluginSetHandleCom:TSetHandleCom;
   PluginGetErrorNumber:TGetErrorNumber;
   PluginSetComPort:TSetComPort;
   PluginSetSerialPortTimeOut:TSetSerialPortTimeOut;
   PluginIsConnectedAndOK:TIsConnectedAndOK;
   PluginPasAPas:TPasAPas;
   PluginHas2Vitesses:THas2Vitesses;
   PluginUseComPort:TUseComPort;
   PluginIsDependantOfTheScope:TIsDependantOfTheScope;
   PluginMustSetMaxPosition:TMustSetMaxPosition;
   PluginGetMinPosition:TGetMinPosition;
   PluginGetMaxPosition:TGetMaxPosition;
   PluginDeplaceMapTime:TDeplaceMapTime;
   PluginArreteMapTime:TArreteMapTime;
   PluginDeplaceMapSteps:TDeplaceMapSteps;
   PluginGetPosition:TGetPosition;
   PluginSetPosition:TSetPosition;
   PluginGotoPosition:TGotoPosition;
   PluginSetMaxPosition:TSetMaxPosition;
   PluginSetBacklash:TSetBacklash;
   PluginGetFirmware:TGetFirmware;

type

TFocuserPlugin=class(TFocuser)
  private
  public
    HandlePlugin:Integer;

    // FONCTIONS DE BAS NIVEAU PRESENTES DANS LE PLUGIN
    // Fonctionnement
    constructor Create;
    function Open:Boolean; virtual;
    function Close:Boolean; virtual;
    function SetComPort(ComPort:PChar):Boolean; virtual;
    function SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                  _ReadTotalTimeoutMultiplier:DWord;
                                  _ReadTotalTimeoutConstant:DWord;
                                  _WriteTotalTimeoutMultiplier:DWord;
                                  _WriteTotalTimeoutConstant:DWord):Boolean; virtual;
    function SetSerialPortComm(_BaudRate:DWord;
                               _ByteSize:Byte;
                               _Parity:Byte;
                               _StopBits:Byte):Boolean; virtual;
    function  IsConnectedAndOK:Boolean; override;
    function  SetHandleCom(_HCom:Integer):Boolean; override;
    function GetErrorNumber:Integer; override;

  // Caracteristiques
    function PasAPas:Boolean; override;
    function Has2Vitesses:Boolean; override;
    function UseComPort:Boolean; override;
    function IsDependantOfTheScope:Boolean; override;
    function MustSetMaxPosition:Boolean; override;
    function GetMinPosition:Integer; override;
    function GetMaxPosition:Integer; override;

  // Deplacements
    function DeplaceMapTime(DirectionFocuser:Integer;SpeedFocuser:Integer):Boolean; override;
    function ArreteMapTime:Boolean; override;
    function DeplaceMapSteps(DirectionFocuser:Integer;StepsFocuser:Integer):Boolean; override;
    function GetPosition(var _Position:Integer):Boolean; override;
    function SetPosition(_Position:Integer):Boolean; override;
    function GotoPosition(_Position:Integer):Boolean; override;
    function SetMaxPosition(_MaxPosition:Integer):Boolean; override;
    function SetBacklash(_BackLash:Integer):Boolean; override;
    function GetFirmware(_FirmWare:string):Boolean; override;

  end;


//******************************************************************************
//******************************        Virtuel       **************************
//******************************************************************************

TFocuserVirtuel=class(TFocuser)
  public

    // FONCTIONS DE BAS NIVEAU PRESENTES DANS LE PLUGIN
    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function PasAPas:Boolean; override;
    function Has2Vitesses:Boolean; override;
    function UseComPort:Boolean; override;    
    function IsDependantOfTheScope:Boolean; override;
    function MustSetMaxPosition:Boolean; override;
    function SetHandleCom(_HCom:Integer):Boolean; override;
    function GetErrorNumber:Integer; override;

    // Deplacements
    function DeplaceMapTime(DirectionFocuser:Integer;SpeedFocuser:Integer):Boolean; override;
    function ArreteMapTime:Boolean; override;
  end;

//******************************************************************************
//******************************        Aucun         **************************
//******************************************************************************

TFocuserNone=class(TFocuser)
  public

    // FONCTIONS DE BAS NIVEAU PRESENTES DANS LE PLUGIN
    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function PasAPas:Boolean; override;
    function Has2Vitesses:Boolean; override;
    function UseComPort:Boolean; override;
    function IsDependantOfTheScope:Boolean; override;
    function MustSetMaxPosition:Boolean; override;
    function SetHandleCom(_HCom:Integer):Boolean; override;
    function GetErrorNumber:Integer; override;    

    // Deplacements
    function DeplaceMapTime(DirectionFocuser:Integer;SpeedFocuser:Integer):Boolean; override;
    function ArreteMapTime:Boolean; override;
  end;

var
  Focuser:TFocuser;

// Remplace pop_main.update_focuser
// Choses a faire pour connecter le focuseur
procedure FocuserConnect;
procedure FocuserDisconnect;

implementation

uses u_class,
     pu_main,
     u_file_io,
     u_lang,
     u_telescopes,
     pu_map_monitor,
     pu_map,
     Dialogs,
     u_general,
     pu_dlg_standard,
     pu_conf;

//******************************************************************************
//********************** Interface focuseur de haut niveau **********************
//******************************************************************************
// Choses a faire pour connecter le focuseur
procedure FocuserConnect;
var
   OK:Boolean;
   TabItems:PTabItems;
   DlgStandard:Tpop_dlg_standard;
   Path:string;
   i:Integer;
begin
// Verification si un focuseur est branche
Config.FocuserBranche:=False;

// Config du Focuser
case Config.TypeFocuser of
   0:Focuser:=TFocuserNone.Create;
   1:Focuser:=TFocuserLX200.Create;
   2:Focuser:=TFocuserRoboFocus.Create;
   3:Focuser:=TFocuserVirtuel.Create;
   4:Focuser:=TFocuserLX200GPS.Create;
   5:Focuser:=TFocuserPlugin.Create;
   //Penser a mettre a jour procedure Tpop_conf.UdpateMap;
   end;

// Focuser virtuel n'a pas besoin de la config port COM
if Config.TypeFocuser=3 then
   begin
   Config.FocuserBranche:=True;
   pop_main.UpdateGUIFocuser;
   if Config.FocInversion then Focuser.SetInversionOn else Focuser.SetInversionOff;
   Exit;
   end;

// Focuser LX n'ont pas besoin de la config port COM mais du scope
//if (Config.TypeFocuser=1) or (Config.TypeFocuser=4) then
if Focuser.IsDependantOfTheScope then
   begin
   if not Config.TelescopeBranche then
      begin
      if Config.MsgFocuser then
         begin
         try
         New(TabItems);

         for i:=1 to NbMaxItems do TabItems^[i].Msg:='';

         with TabItems^[1] do
            begin
            TypeItem:=tiLabel;
            UnderLine:=False;
            Msg:=lang('Le focuseur ne peut être connecté que si le télescope l''a été avant');
            end;

         with TabItems^[2] do
            begin
            TypeItem:=tiCheckBox;
            Msg:=lang('Ne plus afficher ce message');
            ValeurCheckDefaut:=False;
            end;

         DlgStandard:=Tpop_dlg_standard.Create(Application,TabItems,350);
         DlgStandard.Caption:=lang('Erreur');
         if DlgStandard.ShowModal=mrOK then
            begin
            Config.MsgFocuser:=TabItems^[2].ValeurSortie=0;

            Path:=LowerCase(ExtractFilePath(Application.ExeName));
            SaveParametres(Path+'TeleAuto.ini');  //nolang
            end

         finally
         Dispose(TabItems);
         end;
         end;

      Exit;
      end
   else
      begin
      Focuser.SetHandleCom(Telescope.hCom);
      Config.FocuserBranche:=True;
      pop_main.UpdateGUIFocuser;
      if Config.FocInversion then Focuser.SetInversionOn else Focuser.SetInversionOff;
      end;
   end
else
   begin
   if Focuser.UseComPort then
      begin
      OK:=Focuser.SetComPort(PChar(Config.MapComPort));
      OK:=Focuser.SetSerialPortTimeOut(config.MapReadIntervalTimeout,
                               config.MapReadTotalTimeoutMultiplier,
                               config.MapReadTotalTimeoutConstant,
                               config.MapWriteTotalTimeoutMultiplier,
                               config.MapWriteTotalTimeoutConstant);
      OK:=Focuser.SetSerialPortComm(9600,8,0,0);
      end;

   if not OK then
      begin
      WriteSpy(lang('Ouverture de la communication impossible avec le focuseur'));
      Config.FocuserBranche:=False;
      pop_main.UpdateGUIFocuser;
      Exit;
      end;

   if Focuser.Open then
      begin
      if Config.TypeFocuser<>0 then Config.FocuserBranche:=Focuser.IsConnectedAndOK;

      if Config.FocuserBranche then
         begin
         if Focuser.MustSetMaxPosition then OK:=Focuser.SetMaxPosition(Config.MaxPosFocuser);
         if Config.FocInversion then Focuser.SetInversionOn else Focuser.SetInversionOff;
         end;

      pop_main.UpdateGUIFocuser;
      Exit;
      end
   else
      begin
      WriteSpy(lang('Ouverture de la communication impossible avec le focuseur'));
      Config.FocuserBranche:=False;
      pop_main.UpdateGUIFocuser;
      Exit;
      end;
   end;
end;

// Choses a faire pour deconnecter le focuseur
procedure FocuserDisconnect;
var
   OK:Boolean;
begin
   try

   // Pas avec le focuseur du LX200 ou de l'AP-GTO car sera fait plus tard !
   // Non -> Et si on veut deconnecter le focuser amis laisser le scope connecte ?
   //   if not Focuser.IsDependantOfTheScope then
      if Config.FocuserBranche then
         begin

         OK:=Focuser.Close;
         Focuser.Free;
         Focuser:=TFocuserNone.Create;

         if pop_map_monitor<>nil then pop_map_monitor.Close;
         // Fait dans UpdateGUIFocuser
{         if pop_map.Visible then
            begin
            pop_map.Hide;
            pop_map.Timer1.Enabled:=True;
            pop_main.ToolButton5.Down:=False;
            end;}

         Config.FocuserBranche:=False;
         end;

//   Non !
//   if Config.TypeFocuser=0 then Focuser.Free;

   finally
   pop_main.UpdateGUIFocuser;
   end;
end;

//******************************************************************************
//**************************       Focuseur Generique      **********************
//******************************************************************************

procedure Simulation(Vitesse,Direction:Byte;DelaiFoc:Double);
begin
// Simulation
if Vitesse=MapLent then
   begin
   if Direction=mapAvant then FWHMTestCourant:=FWHMTestCourant-DelaiFoc/1000*Config.VitesseLente
   else FWHMTestCourant:=FWHMTestCourant+DelaiFoc/1000*Config.VitesseLente;
   end
else
   begin
   if Direction=mapAvant then FWHMTestCourant:=FWHMTestCourant-DelaiFoc/1000*Config.VitesseRapide
   else FWHMTestCourant:=FWHMTestCourant+DelaiFoc/1000*Config.VitesseRapide;
   end;
end;

// FONCTIONS DE HAUT NIVEAU ABSENTES DU PLUGIN
// Deplacement pendant le temps DelaiFoc en ms
function TFocuser.FocuserMoveTime(Direction:Integer;Vitesse:Integer;DelaiFoc:Double):Boolean;
var
   TimeInit:TDateTime;
   Delai:Double;
   MyMessage,StrVitesse:string;
   OK:Boolean;
begin
Result:=True;
if Vitesse=MapLent then StrVitesse:=lang('Vitesse lente');
if Vitesse=MapRapide then StrVitesse:=lang('Vitesse rapide');
if not Correction then
   begin
   if Direction=mapAvant then
      MyMessage:='Focuseur : '+ //nolang
         lang('Impulsion avant durée = ')+MyFloatToStr(DelaiFoc,1)+
         ' ms / '+StrVitesse //nolang
   else
      MyMessage:='Focuseur : '+ //nolang
         lang('Impulsion arrière durée = ')+MyFloatToStr(DelaiFoc,1)+
         ' ms / '+StrVitesse; //nolang
   WriteSpy(MyMessage);

   if Inversion then
      if Direction=mapAvant then Direction:=mapArriere else Direction:=mapAvant;
   
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   OK:=Focuser.DeplaceMapTime(Direction,Vitesse);
   Simulation(Vitesse,Direction,DelaiFoc);
   // On attends
   TimeInit:=Time;
   while Time<TimeInit+DelaiFoc/1000/60/60/24 do;
   // On arrete
   OK:=Focuser.ArreteMapTime;

   // On attends l'arret du moteur
   if Vitesse=MapLent then
      begin
      MyMessage:='Focuseur : '+ //nolang
         lang('Stabilisation durée = ')+MyFloatToStr(Config.StabilisationLente,1)+
         'ms'; //nolang
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      TimeInit:=Time;
      while Time<TimeInit+Config.StabilisationLente/1000/60/60/24 do;
      end
   else if Vitesse=MapRapide then
      begin
      MyMessage:='Focuseur : '+ //nolang
         lang('Stabilisation durée = ')+MyFloatToStr(Config.StabilisationRapide,1)+
         'ms'; //nolang
      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
      TimeInit:=Time;
      while Time<TimeInit+Config.StabilisationRapide/1000/60/60/24 do;
      end;
   end
else
   // Commande corrigée
   begin
   // Il ne faut pas se baser sur la direction mais sur l'inversion !!!!!

//   if DirectionEffective=mapArriere then ImpulsionBas:=DelaiFoc else ImpulsionHaut:=DelaiFoc;
   // envoi d'une impulsion dite "de correction arriere" au moteur
//   if DirectionEffective=mapAvant then
   if not Inversion then
      begin
      if Vitesse=MapLent then
         begin
         // k = 1/(1+S/100)
   //      Delai:=Config.ImpulsionArriereLente+ImpulsionBas*(1-Config.SurvitesseLente/100);
         if Direction=mapAvant then
//          Delai:=Config.ImpulsionArriereLente+DelaiFoc
          Delai:=Config.ImpulsionArriereLente
         else
            Delai:=Config.ImpulsionArriereLente+DelaiFoc/(1+Config.SurvitesseLente/100);
         MyMessage:='Focuseur : '+ //nolang
            lang('Impulsion arrière durée = ')+MyFloatToStr(Delai,1)+
            ' ms / '+StrVitesse; //nolang
         end
      else if Vitesse=MapRapide then
         begin
         // k = 1/(1+S/100)
   //      Delai:=Config.ImpulsionArriereRapide+ImpulsionBas*(1-Config.SurvitesseRapide/100);
         if Direction=mapAvant then
//            Delai:=Config.ImpulsionArriereRapide+DelaiFoc/(1+Config.SurvitesseRapide/100)
            Delai:=Config.ImpulsionArriereRapide
         else
            Delai:=Config.ImpulsionArriereRapide+DelaiFoc/(1+Config.SurvitesseRapide/100);
//            Delai:=Config.ImpulsionArriereRapide+DelaiFoc;
         MyMessage:='Focuseur : '+ //nolang
            lang('Impulsion arrière durée = ')+MyFloatToStr(Delai,1)+
            ' ms / '+StrVitesse; //nolang
         end;

      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);

      OK:=Focuser.DeplaceMapTime(mapArriere,Vitesse);
      Simulation(Vitesse,mapArriere,Delai);
      end
   else
      begin
      if Vitesse=MapLent then
         begin
         // k = 1/(1+S/100)
   //      Delai:=Config.ImpulsionArriereLente+ImpulsionBas*(1-Config.SurvitesseLente/100);
         if Direction=mapAvant then
//            Delai:=Config.ImpulsionArriereLente+DelaiFoc/(1+Config.SurvitesseLente/100)
            Delai:=Config.ImpulsionArriereLente
         else
//            Delai:=Config.ImpulsionArriereLente+DelaiFoc;
            Delai:=Config.ImpulsionArriereLente+DelaiFoc/(1+Config.SurvitesseLente/100);
         MyMessage:='Focuseur : '+ //nolang
            lang('Impulsion arrière durée = ')+MyFloatToStr(Delai,1)+
            ' ms / '+StrVitesse; //nolang
         end
      else if Vitesse=MapRapide then
         begin
         // k = 1/(1+S/100)
   //      Delai:=Config.ImpulsionArriereRapide+ImpulsionBas*(1-Config.SurvitesseRapide/100);
         if Direction=mapAvant then
//            Delai:=Config.ImpulsionArriereRapide+DelaiFoc/(1+Config.SurvitesseRapide/100)
            Delai:=Config.ImpulsionArriereRapide
         else
            Delai:=Config.ImpulsionArriereRapide+DelaiFoc/(1+Config.SurvitesseRapide/100);
//            Delai:=Config.ImpulsionArriereRapide+DelaiFoc;
         MyMessage:='Focuseur : '+ //nolang
            lang('Impulsion arrière durée = ')+MyFloatToStr(Delai,1)+
            ' ms / '+StrVitesse; //nolang
         end;

      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);

      OK:=Focuser.DeplaceMapTime(mapAvant,Vitesse);
      Simulation(Vitesse,mapAvant,Delai);      
      end;

   // On Attends
   TimeInit:=Time;
   while Time<TimeInit+Delai/1000/60/60/24 do;

   // On arrete
   OK:=Focuser.ArreteMapTime;

   // attente pendant un "temps de stabilisation"
   if Vitesse=MapLent then
      begin
      MyMessage:='Focuseur : '+ //nolang
         lang('Stabilisation durée = ')+MyFloatToStr(Config.StabilisationLente,1)+
         'ms'; //nolang
      end
   else if Vitesse=MapRapide then
      begin
      MyMessage:='Focuseur : '+ //nolang
         lang('Stabilisation durée = ')+MyFloatToStr(Config.StabilisationRapide,1)+
         'ms'; //nolang
      end;

   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   TimeInit:=Time;
   while Time<TimeInit+Config.StabilisationRapide/1000/60/60/24 do;

   // envoi d'une impulsion dite " de correction avant" au moteur
//   if DirectionEffective=mapAvant then
   if not Inversion then
      begin
      if Vitesse=MapLent then
         begin
         if Direction=mapAvant then
            Delai:=Config.ImpulsionAvantLente+DelaiFoc
         else
            Delai:=Config.ImpulsionAvantLente;
//            Delai:=Config.ImpulsionAvantLente+DelaiFoc/(1+Config.SurvitesseLente/100);

         MyMessage:='Focuseur : '+ //nolang
            lang('Impulsion avant durée = ')+MyFloatToStr(Delai,1)+
            ' ms / '+StrVitesse; //nolang
         end
      else if Vitesse=MapRapide then
         begin
         if Direction=mapAvant then
            Delai:=Config.ImpulsionAvantRapide+DelaiFoc
         else
//            Delai:=Config.ImpulsionAvantRapide+DelaiFoc/(1+Config.SurvitesseRapide/100);
            Delai:=Config.ImpulsionAvantRapide;


         MyMessage:='Focuseur : '+ //nolang
            lang('Impulsion avant durée = ')+MyFloatToStr(Delai,1)+
            ' ms / '+StrVitesse; //nolang
         end;

      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);

      OK:=Focuser.DeplaceMapTime(mapAvant,Vitesse);
      Simulation(Vitesse,mapAvant,Delai);      
      end
   else
      begin
      if Vitesse=MapLent then
         begin
         if Direction=mapAvant then
            Delai:=Config.ImpulsionAvantLente+DelaiFoc
         else
            Delai:=Config.ImpulsionAvantLente;
//            Delai:=Config.ImpulsionAvantLente+DelaiFoc/(1+Config.SurvitesseLente/100);

         MyMessage:='Focuseur : '+ //nolang
            lang('Impulsion avant durée = ')+MyFloatToStr(Delai,1)+
            ' ms / '+StrVitesse; //nolang
         end
      else if Vitesse=MapRapide then
         begin
         if Direction=mapAvant then
            Delai:=Config.ImpulsionAvantRapide+DelaiFoc
         else
//            Delai:=Config.ImpulsionAvantRapide+DelaiFoc/(1+Config.SurvitesseRapide/100);
            Delai:=Config.ImpulsionAvantRapide;


         MyMessage:='Focuseur : '+ //nolang
            lang('Impulsion avant durée = ')+MyFloatToStr(Delai,1)+
            ' ms / '+StrVitesse; //nolang
         end;

      WriteSpy(MyMessage);
      if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);

      OK:=Focuser.DeplaceMapTime(mapArriere,Vitesse);
      Simulation(Vitesse,mapArriere,Delai);
      end;

   TimeInit:=Time;
   while Time<TimeInit+Delai/1000/60/60/24 do;

   // On arrete
   OK:=Focuser.ArreteMapTime;

   // attente pendant un "temps de stabilisation".
   if Vitesse=MapLent then
      begin
      MyMessage:='Focuseur : '+ //nolang
         lang('Stabilisation durée = ')+MyFloatToStr(Config.StabilisationLente,1)+
         'ms'; //nolang
      end
   else if Vitesse=MapRapide then
      begin
      MyMessage:='Focuseur : '+ //nolang
         lang('Stabilisation durée = ')+MyFloatToStr(Config.StabilisationRapide,1)+
         'ms'; //nolang
      end;

   WriteSpy(MyMessage);
   if Assigned(pop_map_monitor) then pop_map_monitor.AddMessage(MyMessage);
   TimeInit:=Time;
   while Time<TimeInit+Config.StabilisationRapide/1000/60/60/24 do;

   end;
end;

function TFocuser.SetCorrectionOn:Boolean;
begin
Correction:=True;
Result:=True;
end;

function TFocuser.SetCorrectionOff:Boolean;
begin
Correction:=False;
//InternalError:=1; //Tests
//Result:=False;
Result:=True;
end;

function TFocuser.GetCorrection(var _Correction:Boolean):Boolean;
begin
_Correction:=Correction;
Result:=True;
end;

function TFocuser.SetInversionOn:Boolean;
begin
Inversion:=True;
Result:=True;
end;

function TFocuser.SetInversionOff:Boolean;
begin
Inversion:=False;
Result:=True;
end;

function TFocuser.GetInversion(var _Inversion:Boolean):Boolean;
begin
_Inversion:=Inversion;
Result:=True;
end;

// FONCTIONS DE BAS NIVEAU PRESENTES DANS LE PLUGIN
constructor TFocuser.Create;
begin
inherited Create;
end;

function TFocuser.SetComPort(ComPort:PChar):Boolean;
begin
Result:=True;
NomCom:=ComPort;
end;

function TFocuser.SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                   _ReadTotalTimeoutMultiplier:DWord;
                                   _ReadTotalTimeoutConstant:DWord;
                                   _WriteTotalTimeoutMultiplier:DWord;
                                   _WriteTotalTimeoutConstant:DWord):Boolean;
begin
Result:=True;
InReadIntervalTimeout         :=_ReadIntervalTimeout;
InReadTotalTimeoutMultiplier  :=_ReadTotalTimeoutMultiplier;
InReadTotalTimeoutConstant    :=_ReadTotalTimeoutConstant;
InWriteTotalTimeoutMultiplier :=_WriteTotalTimeoutMultiplier;
InWriteTotalTimeoutConstant   :=_WriteTotalTimeoutConstant;
end;

function TFocuser.SetSerialPortComm(_BaudRate:DWord;
                                _ByteSize:Byte;
                                _Parity:Byte;
                                _StopBits:Byte):Boolean;
begin
Result:=True;
BaudRate:=_BaudRate;
ByteSize:=_ByteSize;
Parity:=_Parity;
StopBits:=_StopBits;
end;

function TFocuser.Open:Boolean;
var
   Errb:Boolean;
   DCB:TDCB;
   CommTimeouts:TCommTimeouts;
begin
Result:=True;

HCom:=CreateFile(PChar(NomCom),GENERIC_READ or GENERIC_WRITE,0,Nil,OPEN_EXISTING,0,0);
Errb:=GetCommState(hCom,DCB);
if not Errb then
     begin
     Result:=False;
     InternalError:=1;
     WriteSpy('Impossible d''ouvrir le port série '+NomCom);
     Exit;
     end;

DCB.BaudRate:=BaudRate;
DCB.ByteSize:=ByteSize;
DCB.Parity  :=Parity;
DCB.StopBits:=StopBits;

SetCommState(hCom,DCB);
SetCommMask (hCom,0);

with CommTimeouts do
   begin
   ReadIntervalTimeout        :=InReadIntervalTimeout        ;
   ReadTotalTimeoutMultiplier :=InReadTotalTimeoutMultiplier ;
   ReadTotalTimeoutConstant   :=InReadTotalTimeoutConstant   ;
   WriteTotalTimeoutMultiplier:=InWriteTotalTimeoutMultiplier;
   WriteTotalTimeoutConstant  :=InWriteTotalTimeoutConstant  ;
   end;

SetCommTimeouts(hCom,CommTimeouts);
end;

function TFocuser.Close:Boolean;
begin
Result:=True;
// On purge au cas ou il y a des restes
if hCom<>0 then
   begin
   PurgeComm(hCom,PURGE_TXCLEAR);
   PurgeComm(hCom,PURGE_RXCLEAR);
   CloseHandle(hCom);
   end;
end;

// Gestion des erreurs
function TFocuser.GetError:PChar;
var
   ErrorNumber:Integer;
begin
ErrorNumber:=GetErrorNumber;
case ErrorNumber of
   1:Result :=PChar('Impossible d''ouvrir le port série');
   2:Result :=PChar('Le télescope n''accepte pas le réglage rapide du focuseur');
   3:Result :=PChar('Le télescope n''accepte pas le réglage lent du focuseur');
   4:Result :=PChar('Le télescope n''accepte pas le réglage haut du focuseur');
   5:Result :=PChar('Le télescope n''accepte pas le réglage bas du focuseur');
   6:Result :=PChar('Le télescope n''accepte pas l''arrêt du focuseur');
   7:Result :=PChar(lang('Nombre de pas invalide'));
   8:Result :=PChar('Le focuseur n''accepte pas d''aller vers l''avant');
   9:Result :=PChar('Le focuseur n''accepte pas d''aller vers l''arrière');
   10:Result:=PChar(lang('Direction invalide'));
   11:Result:=PChar('Le focuseur n''accepte pas la commande');
   12:Result:=PChar('Le focuseur n''accepte la demande de position');
   13:Result:=PChar(lang('Le focuseur ne réponds pas à la demande de position'));
   14:Result:=PChar('Le focuseur n''accepte pas la mise à jour de position');
   15:Result:=PChar(lang('Le focuseur ne réponds pas à la mise à jour de position'));
   16:Result:=PChar('Le focuseur n''accepte pas la mise à jour de la position maximum');
   17:Result:=PChar(lang('Le focuseur ne réponds pas à la mise à jour de la position maximum'));
   18:Result:=PChar('Le focuseur n''accepte pas la mise à jour de l''hystéresis');
   19:Result:=PChar('Le focuseur ne réponds pas à la mise à jour de l''hystéresis');
   20:Result:=PChar('Le focuseur n''accepte pas la demande de déplacement');
   21:Result:=PChar('Le focuseur n''accepte pas la demande du Firmware');
   22:Result:=PChar(lang('Le focuseur ne réponds pas à la demande du Firmware'));
   end;
end;

//******************************************************************************
//**************************        Focuser LX200         **********************
//******************************************************************************

constructor TFocuserLX200.Create;
begin
inherited Create;
end;

function TFocuserLX200.SetHandleCom(_HCom:Integer):Boolean;
begin
hCom:=_hCom;
Result:=True;
end;

function TFocuserLX200.GetErrorNumber:Integer;
begin
Result:=InternalError;
end;

function TFocuserLX200.PasAPas:Boolean;
begin
Result:=False;
end;

function TFocuserLX200.Has2Vitesses:Boolean;
begin
Result:=True;
end;

// On considere que non car c'est le scope qui ouvre ou ferme le port
function TFocuserLX200.UseComPort:Boolean;
begin
Result:=False;
end;

function TFocuserLX200.IsDependantOfTheScope:Boolean;
begin
Result:=True;
end;

function TFocuserLX200.MustSetMaxPosition:Boolean;
begin
Result:=False;
end;

function TFocuserLX200.IsConnectedAndOK:Boolean;
begin
if (Config.TypeTelescope=1) or (Config.TypeTelescope=4) then
   Result:=Config.TelescopeBranche
else Result:=False;
end;

function TFocuserLX200.DeplaceMapTime(DirectionFocuser:Integer;SpeedFocuser:Integer):Boolean;
var
   BufWrite:array[0..4] of char;
   NumberOfBytesWrite,NumberOfBytesRead:LongWord;
   MyMessage:string;
begin
Result:=True;

if Config.TelescopeBranche then
   begin
   case SpeedFocuser of
     mapRapide:begin
               BufWrite[0]:='#';
               BufWrite[1]:=':';
               BufWrite[2]:='F';
               BufWrite[3]:='F';
               BufWrite[4]:='#';
               // Pas beau ! mais comment faire ? Gerer ca dans le programme !!!!
               WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
//               WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
               if NumberOfBytesWrite<>5 then
                  begin
                  Result:=False;
                  WriteSpy('Le télescope n''accepte pas le réglage rapide du focuseur');
                  InternalError:=2;
                  Exit;
                  end;
               end;
     mapLent:begin
             BufWrite[0]:='#';
             BufWrite[1]:=':';
             BufWrite[2]:='F';
             BufWrite[3]:='S';
             BufWrite[4]:='#';
             WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
//             WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
             if NumberOfBytesWrite<>5 then
                begin
                Result:=False;
                WriteSpy(lang('Le télescope n''accepte pas le réglage lent du focuseur'));
                InternalError:=3;
                Exit;
                end;
             end;
     end;

    case DirectionFocuser of
     mapAvant:begin
             WriteSpy(lang('Moteur en marche avant'));
             BufWrite[0]:='#';
             BufWrite[1]:=':';
             BufWrite[2]:='F';
             BufWrite[3]:='+';
             BufWrite[4]:='#';
             WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
//             WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
             if NumberOfBytesWrite<>5 then
                begin
                Result:=False;
                WriteSpy(lang('Le télescope n''accepte pas le réglage haut du focuseur'));
                InternalError:=4;
                Exit;
                end;
             end;
     mapArriere:begin
            WriteSpy(lang('Moteur en marche arrière'));
            BufWrite[0]:='#';
            BufWrite[1]:=':';
            BufWrite[2]:='F';
            BufWrite[3]:='-';
            BufWrite[4]:='#';
            WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
//            WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
            if NumberOfBytesWrite<>5 then
               begin
               Result:=False;
               WriteSpy(lang('Le télescope n''accepte pas le réglage bas du focuseur'));
               InternalError:=5;
               Exit;
               end;
            end;
     end;

    end;
end;

function TFocuserLX200.ArreteMapTime:Boolean;
var
   BufWrite:array[0..4] of char;
   NumberOfBytesWrite,NumberOfBytesRead:LongWord;
   MyMessage:string;
begin
Result:=True;

FlushFileBuffers(hCom);

BufWrite[0]:='#';
BufWrite[1]:=':';
BufWrite[2]:='F';
BufWrite[3]:='Q';
BufWrite[4]:='#';
WriteFile(Telescope.hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>5 then
   begin
   Result:=False;
   WriteSpy('Le télescope n''accepte pas l''arrêt du focuseur');
   InternalError:=6;
   Exit
   end;
end;

//******************************************************************************
//**************************       Focuser LX200 GPS      **********************
//******************************************************************************

constructor TFocuserLX200GPS.Create;
begin
inherited Create;
end;

function TFocuserLX200GPS.SetHandleCom(_HCom:Integer):Boolean;
begin
hCom:=_hCom;
Result:=True;
end;

function TFocuserLX200GPS.GetErrorNumber:Integer;
begin
Result:=InternalError;
end;

function TFocuserLX200GPS.PasAPas:Boolean;
begin
Result:=False;
end;

function TFocuserLX200GPS.Has2Vitesses:Boolean;
begin
Result:=True;
end;

// On considere que non car c'est le scope qui ouvre ou ferme le port
function TFocuserLX200GPS.UseComPort:Boolean;
begin
Result:=False;
end;

function TFocuserLX200GPS.IsDependantOfTheScope:Boolean;
begin
Result:=True;
end;

function TFocuserLX200GPS.MustSetMaxPosition:Boolean;
begin
Result:=False;
end;

function TFocuserLX200GPS.IsConnectedAndOK:Boolean;
var
   Alpha,Delta:Double;
begin
if Config.TypeTelescope=1 then
   Result:=Config.TelescopeBranche
else Result:=False;
end;

function TFocuserLX200GPS.DeplaceMapTime(DirectionFocuser:Integer;SpeedFocuser:Integer):Boolean;
var
   BufWrite:array[0..4] of char;
   NumberOfBytesWrite,NumberOfBytesRead:LongWord;
   MyMessage:string;
begin
// #:F1# --> Fine
// #:F2# --> Slow
// #:F3# --> Medium
// #:F4# --> Fast

Result:=True;

if Config.TelescopeBranche then
   begin
   case SpeedFocuser of
     mapRapide:begin // Slow
               BufWrite[0]:='#';
               BufWrite[1]:=':';
               BufWrite[2]:='F';
               BufWrite[3]:='2';
               BufWrite[4]:='#';
               // Pas beau ! mais comment faire ? Gerer ca dans le programme !!!!
               WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
//               WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
               if NumberOfBytesWrite<>5 then
                  begin
                  Result:=False;
                  WriteSpy('Le télescope n''accepte pas le réglage rapide du focuseur');
                  InternalError:=2;
                  Exit;
                  end;
               end;
     mapLent:begin // Fine
             BufWrite[0]:='#';
             BufWrite[1]:=':';
             BufWrite[2]:='F';
             BufWrite[3]:='1';
             BufWrite[4]:='#';
             WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
//             WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
             if NumberOfBytesWrite<>5 then
                begin
                Result:=False;
                WriteSpy('Le télescope n''accepte pas le réglage lent du focuseur');
                InternalError:=3;
                Exit;
                end;
             end;
     end;

    case DirectionFocuser of
     mapAvant:begin
             WriteSpy(lang('Moteur en marche avant'));
             BufWrite[0]:='#';
             BufWrite[1]:=':';
             BufWrite[2]:='F';
             BufWrite[3]:='+';
             BufWrite[4]:='#';
             WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
//             WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
             if NumberOfBytesWrite<>5 then
                begin
                Result:=False;
                WriteSpy('Le télescope n''accepte pas le réglage haut du focuseru');
                InternalError:=4;
                Exit
                end;
             end;
     mapArriere:begin
            WriteSpy(lang('Moteur en marche arrière'));
            BufWrite[0]:='#';
            BufWrite[1]:=':';
            BufWrite[2]:='F';
            BufWrite[3]:='-';
            BufWrite[4]:='#';
            WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
//            WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
            if NumberOfBytesWrite<>5 then
               begin
               Result:=False;
               WriteSpy('Le télescope n''accepte pas le réglage bas du focuseur');
               InternalError:=5;
               Exit;
               end;
            end;
     end;

    end;
end;

function TFocuserLX200GPS.ArreteMapTime:Boolean;
var
   BufWrite:array[0..4] of char;
   NumberOfBytesWrite,NumberOfBytesRead:LongWord;
   MyMessage:string;
begin
Result:=True;

FlushFileBuffers(hCom);

BufWrite[0]:='#';
BufWrite[1]:=':';
BufWrite[2]:='F';
BufWrite[3]:='Q';
BufWrite[4]:='#';
WriteFile(Telescope.hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
//   WriteFile(hCom,BufWrite[0],5,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>5 then
   begin
   Result:=False;
   WriteSpy('Le télescope n''accepte pas l''arrêt du focuseur');
   InternalError:=6;
   Exit;
   end;

end;

//******************************************************************************
//******************************       RoboFocus      **************************
//******************************************************************************

constructor TFocuserRoboFocus.Create;
begin
inherited Create;
end;

function TFocuserRoboFocus.SetHandleCom(_HCom:Integer):Boolean;
begin
hCom:=_hCom;
Result:=True;
end;

function TFocuserRoboFocus.GetErrorNumber:Integer;
begin
Result:=InternalError;
end;

function TFocuserRoboFocus.PasAPas:Boolean;
begin
Result:=True;
end;

function TFocuserRoboFocus.Has2Vitesses:Boolean;
begin
Result:=False;
end;

function TFocuserRoboFocus.UseComPort:Boolean;
begin
Result:=True;
end;

function TFocuserRoboFocus.IsDependantOfTheScope:Boolean;
begin
Result:=False;
end;

function TFocuserRoboFocus.MustSetMaxPosition:Boolean;
begin
Result:=True;
end;

function TFocuserRoboFocus.GetMinPosition:Integer;
begin
Result:=0;
end;

function TFocuserRoboFocus.GetMaxPosition:Integer;
begin
Result:=MaxPosition;
end;

function TFocuserRoboFocus.DeplaceMapTime(DirectionFocuser:Integer;SpeedFocuser:Integer):Boolean;
var
   BufWrite:array[0..8] of char;
   BufRead :array[0..8] of char;
   NumberOfBytesWrite,NumberOfBytesRead:LongWord;
   MyMessage,StepsStr:String;
   Checksum:Word;
   i:Integer;
   DeltaPos,PosNow:Integer;
   OK:Boolean;
begin
Result:=True;

OK:=GetPosition(PosNow);
case DirectionFocuser of
   mapAvant:begin
           WriteSpy(lang('Moteur en marche avant'));
           DeltaPos:=GetMaxPosition-PosNow;
           try
           StepsStr:=IntToStr(DeltaPos);
           except
           Result:=False;
           WriteSpy(lang('Nombre de pas invalide'));
           InternalError:=7;
           Exit;
           end;

           while Length(StepsStr)<5 do StepsStr:='0'+StepsStr;

           BufWrite[0]:='F';
           BufWrite[1]:='O';
           BufWrite[2]:='0';
           BufWrite[3]:=StepsStr[1];
           BufWrite[4]:=StepsStr[2];
           BufWrite[5]:=StepsStr[3];
           BufWrite[6]:=StepsStr[4];
           BufWrite[7]:=StepsStr[5];

           Checksum:=0;
           for i:=0 to 7 do Checksum:=Checksum+Ord(BufWrite[i]);

           BufWrite[8]:=Chr(Lo(Checksum));

           WriteFile(hCom,BufWrite[0],9,NumberOfBytesWrite,nil);
           if NumberOfBytesWrite<>9 then
              begin
              Result:=False;
              WriteSpy('Le focuseur n''accepte pas d''aller vers le haut');
              InternalError:=8;
              Exit;
              end;

           end;
   mapArriere:begin
          WriteSpy(lang('Moteur en marche arrière'));
          DeltaPos:=PosNow-GetMinPosition;
          try
          StepsStr:=IntToStr(DeltaPos);
          except
          Result:=False;
          WriteSpy(lang('Nombre de pas invalide'));
          InternalError:=7;
          Exit;
          end;

          while Length(StepsStr)<5 do StepsStr:='0'+StepsStr;

          BufWrite[0]:='F';
          BufWrite[1]:='I';
          BufWrite[2]:='0';
          BufWrite[3]:=StepsStr[1];
          BufWrite[4]:=StepsStr[2];
          BufWrite[5]:=StepsStr[3];
          BufWrite[6]:=StepsStr[4];
          BufWrite[7]:=StepsStr[5];

          Checksum:=0;
          for i:=0 to 7 do Checksum:=Checksum+Ord(BufWrite[i]);

          BufWrite[8]:=Chr(Lo(Checksum));

          WriteFile(hCom,BufWrite[0],9,NumberOfBytesWrite,nil);
          if NumberOfBytesWrite<>9 then
             begin
             Result:=False;
             WriteSpy('Le focuseur n''accepte pas d''aller vers le bas');
             InternalError:=9;
             Exit;
             end;

          end;
   else
      begin
      Result:=False;
      WriteSpy(lang('Direction invalide'));
      InternalError:=10;
      Exit;
      end;
   end;

end;

// Toute communication arrete les deplacements !
function TFocuserRoboFocus.ArreteMapTime:Boolean;
var
   BufWrite:array[0..8] of char;
   BufRead :array[0..8] of char;
   NumberOfBytesWrite,NumberOfBytesRead:LongWord;
   MyMessage,StepsStr:String;
   Checksum:Word;
   i:Integer;
   Reponse:String;
begin
Result:=True;

try
StepsStr:=IntToStr(0);
except
Result:=False;
WriteSpy(lang('Nombre de pas invalide'));
InternalError:=7;
Exit;
end;

while Length(StepsStr)<5 do StepsStr:='0'+StepsStr;

BufWrite[0]:='F';
BufWrite[1]:='I';
BufWrite[2]:='0';
BufWrite[3]:=StepsStr[1];
BufWrite[4]:=StepsStr[2];
BufWrite[5]:=StepsStr[3];
BufWrite[6]:=StepsStr[4];
BufWrite[7]:=StepsStr[5];

Checksum:=0;
for i:=0 to 7 do Checksum:=Checksum+Ord(BufWrite[i]);

BufWrite[8]:=Chr(Lo(Checksum));

WriteFile(hCom,BufWrite[0],9,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>9 then
   begin
   Result:=False;
   WriteSpy('Le focuseur n''accepte pas la commande');
   InternalError:=11;
   Exit;
   end;

ReadFile(hCom,BufRead[0],1,NumberOfBytesRead,nil);
while (BufRead[0]='I') or (BufRead[0]='O') do ReadFile(hCom,BufRead[0],1,NumberOfBytesRead,nil);
ReadFile(hCom,BufRead[0],9,NumberOfBytesRead,nil);
SetLength(Reponse,9);
for i:=0 to 8 do Reponse[i+1]:=BufRead[i];
if Reponse[1]='F' then Position:=StrToInt(Copy(Reponse,4,5));
end;

function TFocuserRoboFocus.DeplaceMapSteps(DirectionFocuser:Integer;StepsFocuser:Integer):Boolean;
var
   BufWrite:array[0..8] of char;
   BufRead :array[0..8] of char;
   NumberOfBytesWrite,NumberOfBytesRead:LongWord;
   MyMessage,StepsStr:string;
   Checksum:Word;
   i:Integer;
   Reponse:string;
   DeltaPos,PosNow:Integer;
   OK:Boolean;
begin
Result:=True;

OK:=GetPosition(PosNow);
case DirectionFocuser of
   mapAvant:if PosNow+StepsFocuser>=GetMaxPosition then StepsFocuser:=GetMaxPosition-PosNow;
   mapArriere: if PosNow-StepsFocuser<=1 then StepsFocuser:=PosNow-1;
   end;

try
StepsStr:=IntToStr(StepsFocuser);
except
Result:=False;
WriteSpy(lang('Nombre de pas invalide'));
InternalError:=7;
Exit;
end;

while Length(StepsStr)<5 do StepsStr:='0'+StepsStr;

case DirectionFocuser of
   mapAvant:begin
           BufWrite[0]:='F';
           BufWrite[1]:='O';
           BufWrite[2]:='0';
           BufWrite[3]:=StepsStr[1];
           BufWrite[4]:=StepsStr[2];
           BufWrite[5]:=StepsStr[3];
           BufWrite[6]:=StepsStr[4];
           BufWrite[7]:=StepsStr[5];

           Checksum:=0;
           for i:=0 to 7 do Checksum:=Checksum+Ord(BufWrite[i]);

           BufWrite[8]:=Chr(Lo(Checksum));

           WriteFile(hCom,BufWrite[0],9,NumberOfBytesWrite,nil);
           if NumberOfBytesWrite<>9 then
              begin
              Result:=False;
              WriteSpy('Le focuseur n''accepte pas d''aller vers le haut');
              InternalError:=8;
              Exit;
              end;

           ReadFile(hCom,BufRead[0],1,NumberOfBytesRead,nil);
           while (BufRead[0]='I') or (BufRead[0]='O') do ReadFile(hCom,BufRead[0],1,NumberOfBytesRead,nil);
           ReadFile(hCom,BufRead[0],9,NumberOfBytesRead,nil);
           SetLength(Reponse,9);
           for i:=0 to 8 do Reponse[i+1]:=BufRead[i];
           if Reponse[1]='F' then Position:=StrToInt(Copy(Reponse,4,5));

           end;
   mapArriere:begin
          BufWrite[0]:='F';
          BufWrite[1]:='I';
          BufWrite[2]:='0';
          BufWrite[3]:=StepsStr[1];
          BufWrite[4]:=StepsStr[2];
          BufWrite[5]:=StepsStr[3];
          BufWrite[6]:=StepsStr[4];
          BufWrite[7]:=StepsStr[5];

          Checksum:=0;
          for i:=0 to 7 do Checksum:=Checksum+Ord(BufWrite[i]);

          BufWrite[8]:=Chr(Lo(Checksum));

          WriteFile(hCom,BufWrite[0],9,NumberOfBytesWrite,nil);
          if NumberOfBytesWrite<>9 then
             begin
             Result:=False;
             WriteSpy('Le focuseur n''accepte pas d''aller vers le bas');
             InternalError:=9;
             Exit;
             end;

           ReadFile(hCom,BufRead[0],1,NumberOfBytesRead,nil);
           while (BufRead[0]='I') or (BufRead[0]='O') do ReadFile(hCom,BufRead[0],1,NumberOfBytesRead,nil);
           ReadFile(hCom,BufRead[0],9,NumberOfBytesRead,nil);
           SetLength(Reponse,9);
           for i:=0 to 8 do Reponse[i+1]:=BufRead[i];
           if Reponse[1]='F' then Position:=StrToInt(Copy(Reponse,4,5));

          end;
   else
      begin
      Result:=False;
      WriteSpy(lang('Direction invalide'));
      InternalError:=10;
      Exit;
      end;
   end;
end;

function TFocuserRoboFocus.GetPosition(var _Position:Integer):Boolean;
var
   BufWrite:array[0..8] of char;
   BufRead :array[0..8] of char;
   NumberOfBytesWrite,NumberOfBytesRead:LongWord;
   MyMessage:String;
   Checksum:Word;
   i:Integer;
   Reponse:String;
begin
Result:=True;

BufWrite[0]:='F';
BufWrite[1]:='G';
BufWrite[2]:='0';
BufWrite[3]:='0';
BufWrite[4]:='0';
BufWrite[5]:='0';
BufWrite[6]:='0';
BufWrite[7]:='0';

Checksum:=0;
for i:=0 to 7 do Checksum:=Checksum+Ord(BufWrite[i]);

BufWrite[8]:=Chr(Lo(Checksum));

WriteFile(hCom,BufWrite[0],9,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>9 then
   begin
   Result:=False;
   WriteSpy('Le focuseur n''accepte la demande de position');
   InternalError:=12;
   Exit;
   end;

ReadFile(hCom,BufRead[0],9,NumberOfBytesRead,nil);
if NumberOfBytesRead<>9 then
   begin
   Result:=False;
   WriteSpy(lang('Le focuseur ne réponds pas à la demande de position'));
   InternalError:=13;
   Exit;
   end;

SetLength(Reponse,9);
for i:=0 to 8 do Reponse[i+1]:=BufRead[i];
Position:=StrToInt(Copy(Reponse,4,5));
_Position:=Position;
end;

function TFocuserRoboFocus.SetPosition(_Position:Integer):Boolean;
var
   BufWrite:array[0..8] of char;
   BufRead :array[0..8] of char;
   NumberOfBytesWrite,NumberOfBytesRead:LongWord;
   MyMessage,StepsStr:String;
   Checksum:Word;
   i:Integer;
   Reponse:String;
begin
Result:=True;

try
StepsStr:=IntToStr(_Position);
except
Result:=False;
WriteSpy(lang('Nombre de pas invalide'));
InternalError:=7;
Exit;
end;

while Length(StepsStr)<5 do StepsStr:='0'+StepsStr;

BufWrite[0]:='F';
BufWrite[1]:='S';
BufWrite[2]:='0';
BufWrite[3]:=StepsStr[1];
BufWrite[4]:=StepsStr[2];
BufWrite[5]:=StepsStr[3];
BufWrite[6]:=StepsStr[4];
BufWrite[7]:=StepsStr[5];

Checksum:=0;
for i:=0 to 7 do Checksum:=Checksum+Ord(BufWrite[i]);

BufWrite[8]:=Chr(Lo(Checksum));

WriteFile(hCom,BufWrite[0],9,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>9 then
   begin
   Result:=False;
   WriteSpy('Le focuseur n''accepte pas la mise à jour de position');
   InternalError:=14;
   Exit;
   end;

ReadFile(hCom,BufRead[0],9,NumberOfBytesRead,nil);
if NumberOfBytesRead<>9 then
   begin
   Result:=False;
   WriteSpy(lang('Le focuseur ne réponds pas à la mise à jour de position'));
   InternalError:=15;
   Exit;
   end;

SetLength(Reponse,9);
for i:=0 to 8 do Reponse[i+1]:=BufRead[i];
Position:=StrToInt(Copy(Reponse,4,5));
end;

function TFocuserRoboFocus.SetMaxPosition(_MaxPosition:Integer):Boolean;
var
   BufWrite:array[0..8] of char;
   BufRead :array[0..8] of char;
   NumberOfBytesWrite,NumberOfBytesRead:LongWord;
   MyMessage,StepsStr:String;
   Checksum:Word;
   i:Integer;
   Reponse:string;
begin
Result:=True;

try
StepsStr:=IntToStr(_MaxPosition);
except
Result:=True;
WriteSpy(lang('Nombre de pas invalide'));
InternalError:=7;
Exit;
end;

while Length(StepsStr)<5 do StepsStr:='0'+StepsStr;

BufWrite[0]:='F';
BufWrite[1]:='L';
BufWrite[2]:='0';
BufWrite[3]:=StepsStr[1];
BufWrite[4]:=StepsStr[2];
BufWrite[5]:=StepsStr[3];
BufWrite[6]:=StepsStr[4];
BufWrite[7]:=StepsStr[5];

Checksum:=0;
for i:=0 to 7 do Checksum:=Checksum+Ord(BufWrite[i]);

BufWrite[8]:=Chr(Lo(Checksum));

WriteFile(hCom,BufWrite[0],9,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>9 then
   begin
   Result:=True;
   WriteSpy('Le focuseur n''accepte pas la mise à jour de la position maximum');
   InternalError:=16;
   Exit;
   end;

ReadFile(hCom,BufRead[0],9,NumberOfBytesRead,nil);
if NumberOfBytesRead<>9 then
   begin
   Result:=True;
   WriteSpy(lang('Le focuseur ne réponds pas à la mise à jour de la position maximum'));
   InternalError:=17;
   Exit;
   end;

SetLength(Reponse,9);
for i:=0 to 8 do Reponse[i+1]:=BufRead[i];
MaxPosition:=StrToInt(Copy(Reponse,4,5));
end;

function TFocuserRoboFocus.SetBacklash(_BackLash:Integer):Boolean;
var
   BufWrite:array[0..8] of char;
   BufRead :array[0..8] of char;
   NumberOfBytesWrite,NumberOfBytesRead:LongWord;
   MyMessage,StepsStr:String;
   Checksum:Word;
   i:Integer;
begin
Result:=True;

try
StepsStr:=IntToStr(Abs(_BackLash));
except
Result:=False;
WriteSpy(lang('Nombre de pas invalide'));
InternalError:=7;
Exit;
end;

while Length(StepsStr)<5 do StepsStr:='0'+StepsStr;

BufWrite[0]:='F';
BufWrite[1]:='B';
if _BackLash<0 then BufWrite[2]:='2'
else if _BackLash>0 then BufWrite[2]:='3'
else BufWrite[2]:='0';
BufWrite[3]:=StepsStr[1];
BufWrite[4]:=StepsStr[2];
BufWrite[5]:=StepsStr[3];
BufWrite[6]:=StepsStr[4];
BufWrite[7]:=StepsStr[5];

Checksum:=0;
for i:=0 to 7 do Checksum:=Checksum+Ord(BufWrite[i]);

BufWrite[8]:=Chr(Lo(Checksum));

WriteFile(hCom,BufWrite[0],9,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>9 then
   begin
   Result:=False;
   WriteSpy('Le focuseur n''accepte pas la mise à jour de l''hystéresis');
   InternalError:=18;
   Exit;
   end;

ReadFile(hCom,BufRead[0],9,NumberOfBytesRead,nil);
if NumberOfBytesRead<>9 then
   begin
   Result:=False;
   WriteSpy('Le focuseur ne réponds pas à la mise à jour de l''hystéresis');
   InternalError:=19;
   Exit;
   end;
end;

function TFocuserRoboFocus.GotoPosition(_Position:Integer):Boolean;
var
   BufWrite:array[0..8] of char;
   BufRead :array[0..8] of char;
   NumberOfBytesWrite,NumberOfBytesRead:LongWord;
   MyMessage,StepsStr:String;
   Checksum:Word;
   i:Integer;
   Reponse:String;
begin
Result:=True;

try
StepsStr:=IntToStr(_Position);
except
Result:=True;
WriteSpy(lang('Nombre de pas invalide'));
InternalError:=7;
Exit;
end;

while Length(StepsStr)<5 do StepsStr:='0'+StepsStr;

BufWrite[0]:='F';
BufWrite[1]:='G';
BufWrite[2]:='0';
BufWrite[3]:=StepsStr[1];
BufWrite[4]:=StepsStr[2];
BufWrite[5]:=StepsStr[3];
BufWrite[6]:=StepsStr[4];
BufWrite[7]:=StepsStr[5];

Checksum:=0;
for i:=0 to 7 do Checksum:=Checksum+Ord(BufWrite[i]);

BufWrite[8]:=Chr(Lo(Checksum));

WriteFile(hCom,BufWrite[0],9,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>9 then
   begin
   Result:=True;
   WriteSpy('Le focuseur n''accepte pas la demande de déplacement');
   InternalError:=20;
   Exit;
   end;

ReadFile(hCom,BufRead[0],1,NumberOfBytesRead,nil);
while (BufRead[0]='I') or (BufRead[0]='O') do ReadFile(hCom,BufRead[0],1,NumberOfBytesRead,nil);
ReadFile(hCom,BufRead[0],9,NumberOfBytesRead,nil);

ReadFile(hCom,BufRead[0],9,NumberOfBytesRead,nil);
SetLength(Reponse,9);
for i:=0 to 8 do Reponse[i+1]:=BufRead[i];
if Reponse[1]='F' then Position:=StrToInt(Copy(Reponse,4,5));
end;

function TFocuserRoboFocus.GetFirmware(_FirmWare:string):Boolean;
var
   BufWrite:array[0..8] of char;
   BufRead :array[0..8] of char;
   NumberOfBytesWrite,NumberOfBytesRead:LongWord;
   MyMessage:String;
   Checksum:Word;
   i:Integer;
   Reponse:String;
begin
Result:=True;

BufWrite[0]:='F';
BufWrite[1]:='V';
BufWrite[2]:='0';
BufWrite[3]:='0';
BufWrite[4]:='0';
BufWrite[5]:='0';
BufWrite[6]:='0';
BufWrite[7]:='0';

Checksum:=0;
for i:=0 to 7 do Checksum:=Checksum+Ord(BufWrite[i]);

BufWrite[8]:=Chr(Lo(Checksum));

WriteFile(hCom,BufWrite[0],9,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>9 then
   begin
   Result:=False;
   WriteSpy('Le focuseur n''accepte pas la demande du Firmware');
   InternalError:=21;
   Exit;
   end;

ReadFile(hCom,BufRead[0],9,NumberOfBytesRead,nil);
if NumberOfBytesRead<>9 then
   begin
   Result:=False;
   WriteSpy(lang('Le focuseur ne réponds pas à la demande du Firmware'));
   InternalError:=22;
   Exit;
   end;

SetLength(Reponse,9);
for i:=0 to 8 do Reponse[i+1]:=BufRead[i];
_FirmWare:=Copy(Reponse,3,5);
end;

function TFocuserRoboFocus.IsConnectedAndOK:Boolean;
var
   Test:string;
begin
Result:=True;
try
Result:=GetFirmware(Test);
except
Result:=False;
end;
end;

//******************************************************************************
//******************************         Plugin       **************************
//******************************************************************************

constructor TFocuserPlugin.Create;
begin
inherited Create;

HandlePlugin:=LoadLibrary(PChar(Config.FocuserPlugin));
if HandlePlugin<>0 then
   begin
   PluginOpen                  := TOpen(GetProcAddress(HandlePlugin,'PluginOpen'));                                           //nolang
   PluginClose                 := TClose(GetProcAddress(HandlePlugin,'PluginClose'));                                         //nolang
   PluginSetHandleCom          := TSetHandleCom(GetProcAddress(HandlePlugin,'PluginSetHandleCom'));                           //nolang
   PluginGetErrorNumber        := TGetErrorNumber(GetProcAddress(HandlePlugin,'PluginGetErrorNumber'));                       //nolang
   PluginSetComPort            := TSetComPort(GetProcAddress(HandlePlugin,'PluginSetComPort'));                               //nolang
   PluginSetSerialPortTimeOut  := TSetSerialPortTimeOut(GetProcAddress(HandlePlugin,'PluginSetSerialPortTimeOut'));           //nolang
   PluginIsConnectedAndOK      := TIsConnectedAndOK(GetProcAddress(HandlePlugin,'PluginIsConnectedAndOK'));                   //nolang
   PluginPasAPas               := TPasAPas(GetProcAddress(HandlePlugin,'PluginPasAPas'));                                     //nolang
   PluginHas2Vitesses          := THas2Vitesses(GetProcAddress(HandlePlugin,'PluginHas2Vitesses'));                           //nolang
   PluginUseComPort            := TUseComPort(GetProcAddress(HandlePlugin,'PluginUseComPort'));                               //nolang
   PluginIsDependantOfTheScope := TIsDependantOfTheScope(GetProcAddress(HandlePlugin,'PluginIsDependantOfTheScope'));         //nolang
   PluginMustSetMaxPosition    := TMustSetMaxPosition(GetProcAddress(HandlePlugin,'PluginMustSetMaxPosition'));               //nolang
   PluginGetMinPosition        := TGetMinPosition(GetProcAddress(HandlePlugin,'PluginGetMinPosition'));                       //nolang
   PluginGetMaxPosition        := TGetMaxPosition(GetProcAddress(HandlePlugin,'PluginGetMaxPosition'));                       //nolang
   PluginDeplaceMapTime        := TDeplaceMapTime(GetProcAddress(HandlePlugin,'PluginDeplaceMapTime'));                       //nolang
   PluginArreteMapTime         := TArreteMapTime(GetProcAddress(HandlePlugin,'PluginArreteMapTime'));                         //nolang
   PluginDeplaceMapSteps       := TDeplaceMapSteps(GetProcAddress(HandlePlugin,'PluginDeplaceMapSteps'));                     //nolang
   PluginGetPosition           := TGetPosition(GetProcAddress(HandlePlugin,'PluginGetPosition'));                             //nolang
   PluginSetPosition           := TSetPosition(GetProcAddress(HandlePlugin,'PluginSetPosition'));                             //nolang
   PluginGotoPosition          := TGotoPosition(GetProcAddress(HandlePlugin,'PluginGotoPosition'));                           //nolang
   PluginSetMaxPosition        := TSetMaxPosition(GetProcAddress(HandlePlugin,'PluginSetMaxPosition'));                       //nolang
   PluginSetBacklash           := TSetBacklash(GetProcAddress(HandlePlugin,'PluginSetBacklash'));                             //nolang
   PluginGetFirmware           := TGetFirmware(GetProcAddress(HandlePlugin,'PluginGetFirmware'));                             //nolang
   end
else raise ErrorCamera.Create(lang('Librairie plugin introuvable'));
end;

function TFocuserPlugin.SetHandleCom(_HCom:Integer):Boolean;
begin
Result:=PluginSetHandleCom(_HCom);
end;

function TFocuserPlugin.GetErrorNumber:Integer;
begin
Result:=PluginGetErrorNumber;
end;

function TFocuserPlugin.SetComPort(ComPort:PChar):Boolean;
begin
Result:=PluginSetComPort(ComPort);
end;

function TFocuserPlugin.SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                             _ReadTotalTimeoutMultiplier:DWord;
                                             _ReadTotalTimeoutConstant:DWord;
                                             _WriteTotalTimeoutMultiplier:DWord;
                                             _WriteTotalTimeoutConstant:DWord):Boolean;
begin
Result:=SetSerialPortTimeOut(_ReadIntervalTimeout,_ReadTotalTimeoutMultiplier,
   _ReadTotalTimeoutConstant,_WriteTotalTimeoutMultiplier,_WriteTotalTimeoutConstant);
end;

function TFocuserPlugin.SetSerialPortComm(_BaudRate:DWord;
                                          _ByteSize:Byte;
                                          _Parity:Byte;
                                          _StopBits:Byte):Boolean;
begin
Result:=True;
end;

function TFocuserPlugin.Open:Boolean;
begin
Result:=PluginOpen;
end;

function TFocuserPlugin.Close:Boolean;
begin
Result:=PluginClose;
end;

function TFocuserPlugin.PasAPas:Boolean;
begin
Result:=PluginPasAPas;
end;

function TFocuserPlugin.Has2Vitesses:Boolean;
begin
Result:=PluginHas2Vitesses;
end;

function TFocuserPlugin.UseComPort:Boolean;
begin
Result:=PluginUseComPort;
end;

function TFocuserPlugin.IsDependantOfTheScope:Boolean;
begin
Result:=PluginIsDependantOfTheScope;
end;

function TFocuserPlugin.MustSetMaxPosition:Boolean;
begin
Result:=PluginMustSetMaxPosition;
end;

function TFocuserPlugin.GetMinPosition:Integer;
begin
Result:=PluginGetMinPosition;
end;

function TFocuserPlugin.GetMaxPosition:Integer;
begin
Result:=PluginGetMaxPosition;
end;

function TFocuserPlugin.DeplaceMapTime(DirectionFocuser:Integer;SpeedFocuser:Integer):Boolean;
begin
Result:=PluginDeplaceMapTime(DirectionFocuser,SpeedFocuser);
end;

function TFocuserPlugin.ArreteMapTime:Boolean;
begin
Result:=PluginArreteMapTime;
end;

function TFocuserPlugin.DeplaceMapSteps(DirectionFocuser:Integer;StepsFocuser:Integer):Boolean;
begin
Result:=PluginDeplaceMapSteps(DirectionFocuser,StepsFocuser);
end;

function TFocuserPlugin.GetPosition(var _Position:Integer):Boolean;
begin
Result:=PluginGetPosition(_Position);
end;

function TFocuserPlugin.SetPosition(_Position:Integer):Boolean;
begin
Result:=PluginSetPosition(_Position);
end;

function TFocuserPlugin.SetMaxPosition(_MaxPosition:Integer):Boolean;
begin
Result:=PluginSetMaxPosition(_MaxPosition);
end;

function TFocuserPlugin.SetBacklash(_BackLash:Integer):Boolean;
begin
Result:=PluginSetBacklash(_BackLash);
end;

function TFocuserPlugin.GotoPosition(_Position:Integer):Boolean;
begin
Result:=PluginGotoPosition(_Position);
end;

function TFocuserPlugin.GetFirmware(_FirmWare:string):Boolean;
begin
Result:=PluginGetFirmware(_FirmWare);
end;

function TFocuserPlugin.IsConnectedAndOK:Boolean;
begin
Result:=PluginIsConnectedAndOK;
end;

//******************************************************************************
//**************************        Focuseur Virtuel       **********************
//******************************************************************************

constructor TFocuserVirtuel.Create;
begin
inherited Create;
end;

function TFocuserVirtuel.SetHandleCom(_HCom:Integer):Boolean;
begin
hCom:=_hCom;
Result:=True;
end;

function TFocuserVirtuel.GetErrorNumber:Integer;
begin
Result:=InternalError;
end;

function TFocuserVirtuel.PasAPas:Boolean;
begin
Result:=False;
end;

function TFocuserVirtuel.Has2Vitesses:Boolean;
begin
Result:=True;
end;

function TFocuserVirtuel.UseComPort:Boolean;
begin
Result:=False;
end;

function TFocuserVirtuel.IsDependantOfTheScope:Boolean;
begin
Result:=False;
end;

function TFocuserVirtuel.MustSetMaxPosition:Boolean;
begin
Result:=False;
end;

function TFocuserVirtuel.IsConnectedAndOK:Boolean;
begin
Result:=True;
end;

function TFocuserVirtuel.DeplaceMapTime(DirectionFocuser:Integer;SpeedFocuser:Integer):Boolean;
begin
Result:=True;
case DirectionFocuser of
   mapAvant:WriteSpy(lang('Moteur en marche avant'));
   mapArriere:WriteSpy(lang('Moteur en marche arrière'));
   end;
end;

function TFocuserVirtuel.ArreteMapTime:Boolean;
begin
Result:=True;
end;

//******************************************************************************
//**************************        Aucun Focuseur        **********************
//******************************************************************************

constructor TFocuserNone.Create;
begin
inherited Create;
end;

function TFocuserNone.SetHandleCom(_HCom:Integer):Boolean;
begin
hCom:=_hCom;
Result:=True;
end;

function TFocuserNone.GetErrorNumber:Integer; 
begin
Result:=InternalError;
end;

function TFocuserNone.PasAPas:Boolean;
begin
Result:=False;
end;

function TFocuserNone.Has2Vitesses:Boolean;
begin
Result:=True;
end;

function TFocuserNone.UseComPort:Boolean;
begin
Result:=False;
end;

function TFocuserNone.IsDependantOfTheScope:Boolean;
begin
Result:=False;
end;

function TFocuserNone.MustSetMaxPosition:Boolean;
begin
Result:=False;
end;

function TFocuserNone.IsConnectedAndOK:Boolean;
begin
Result:=True;
end;

function TFocuserNone.DeplaceMapTime(DirectionFocuser:Integer;SpeedFocuser:Integer):Boolean;
begin
Result:=True;
end;

function TFocuserNone.ArreteMapTime:Boolean;
begin
Result:=True;
end;

end.
