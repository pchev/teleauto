unit u_cameras;

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

uses u_class, pu_main, SysUtils, Windows, Forms, Classes, u_telescopes, Dialogs;

// Shutter state
const
  ShutterIsSynchro       = 0;
  ShutterIsAllwaysOpen   = 1;
  ShutterIsAllwaysClosed = 2;

type

  ErrorCameraHisis14 = class(Exception);

//******************************************************************************
//**************************       Camera Generique       **********************
//******************************************************************************

  TCamera=class(TObject)
    private
    public
    Adress:Word;
    x1,y1,x2,y2:Integer;
    Sx,Sy:Integer;
    Pose:Double;
    ShutterState:Byte;
    ShutterCloseDelay:Double;       // Delay de fermeture de l'obturateur
    EmptyingDelay:Double;           // Delai de vidage
    ReadingDelay:Double;            // Delai de lecture (Hisis)
    Binning:Integer;                // Binning courant
    UseAmpli:Boolean;               // on coupe l ampli pendant la pose ou non ?
    AmpliState:boolean;             // etat de  l'ampli ?
    DateTimeBegin:TDateTime;        // Date et heure de debut de pose
    DateTimeEnd:TDateTime;          // Date et heure de fin de pose    
    AcqTrack:Boolean;               // C'est utilisé comme un capteur de guidage ?
    PCMoinsTU:Double;               // Difference PC-TU pour le plugin
    GenericImageName:string;        // Nom d image Generique
    HourServerAdress:Pointer;       // Adresse de la fonction serveur d'heure
    OSIsNT:Boolean;                   // Utilisation sous NT pour enlever les cli/sti

    // Fonctionnement
    constructor Create;

    procedure SetPort(_Adress:Word); virtual;                             // Utilise par TA pour indiquer le port au driver
    function  SetWindow(_x1,_y1,_x2,_y2:Integer):Boolean; virtual;        // Utilise par TA pour indiquer la fenetre au driver
    function  SetBinning(_Binning:Integer):Boolean; virtual;              // Utilise par TA pour indiquer le binning au driver
    function  SetPose(_Pose:Double):Boolean; virtual;                     // Utilise par TA pour indiquer le temps de pose au driver
    function  SetEmptyingDelay(_EmptyingDelay:Double):Boolean; virtual;   // Utilise par TA pour indiquer le delai de vidage au driver
    function  SetReadingDelay(_ReadingDelay:Double):Boolean; virtual;     // Utilise par TA pour indiquer le delai de laecture au driver
    function  SetShutterCloseDelay(Delay:Double):Boolean; virtual;        // Utilise par TA pour indiquer le delai de fermeture de l'obturateur au driver
    function  CanStopNow:Boolean; virtual;                                // Utilise pour les webcam Patrick ca sert a quoi ?
    procedure AdjustIntervalePose(var NbInterValCourant,NbSubImage :      // Utilise pour les webcam Patrick ca sert a quoi ?
       integer; Interval : integer); virtual;
    function  SetAcqTrack(_AcqTrack:Boolean):Boolean; virtual;            // Utilise par TA pour indiquer au driver que c'est la camera de guidage
    function  IsConnectedAndOK:Boolean; virtual; abstract;                // Utilise par TA pour savoir si la camera est branchee et marche bien
    function  Open:Boolean; virtual; abstract;                            // Utilise par TA pour initialiser le driver
    procedure Close; virtual; abstract;                                   // Utilise par TA pour fermer le driver
    function  StartPose:Boolean; virtual; abstract;                           // Utilise par TA pour lancer la pose
    function  StopPose:Boolean; virtual; abstract;                            // Utilise par TA pour arreter la pose prematurement
    function  ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; // Utilise par TA pour lire l'image
       virtual; abstract;
    function  ShowCfgWindow:Boolean; virtual; abstract;

    // fonction d acquisition en une passe
    procedure SetImageName(s:string); virtual;
    procedure Makeimage(nbr_exp,shutterstate:integer);
    procedure Image(nbr_exp:integer); virtual;
    procedure Flat(nbr_exp:integer); virtual;
    procedure Offset(nbr_exp:integer); virtual;
    procedure Dark(nbr_exp:integer); virtual;

    procedure GetCCDDateBegin(var Year,Month,Day:Word); virtual; abstract;     // Utilise par TA pour lire la date de debut de prise de vue
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); virtual; abstract;  // Utilise par TA pour lire l'heure de debut de prise de vue
    procedure GetCCDDateEnd(var Year,Month,Day:Word); virtual; abstract;     // Utilise par TA pour lire la date de debut de prise de vue
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); virtual; abstract;  // Utilise par TA pour lire l'heure de debut de prise de vue
    procedure SetHourServer(ServerAdress:Pointer); virtual; abstract;     // Utilise par TA pour indiquer l'adresse de la procedure de recup de l'heure/date
    function  GetTemperature:Double; virtual; abstract;                   // Utilise par TA pour lire la temperature du CCD
    procedure SetTemperature(TargetTemperature:Double); virtual; abstract;// Utilise par TA pour indiquer la temperature de consigne du CCD
    procedure SetPCMinusUT(PCMinusUT:Double); virtual; abstract;          // Utilise par TA pour indiquer la difference PC-TU
    procedure AmpliOn; virtual; abstract;                                 // Utilise par TA pour allumer l'ampli maintenant
    procedure AmpliOff; virtual; abstract;                                // Utilise par TA pour couper l'ampli maintenant
    procedure ShutterOpen; virtual; abstract;                             // Utilise par le driver pour ouvrir l'obturateur
    procedure ShutterClosed; virtual; abstract;                           // Utilise par le driver pour fermer l'obturateur
    procedure ShutterSynchro; virtual; abstract;                          // Utilise par le driver pour synchroniser l'obturateur sur les poses
    procedure SetAmpliUnused;                                             // Utilise par TA pour dire au driver de ne jamais couper l'ampli
    procedure SetAmpliUsed;                                               // Utilise par TA pour dire au driver de couper l'ampli pendant les poses
    procedure SetAmpliStateTrue;                                          // Utilise par TA pour indiquer que l'ampli est allume
    procedure SetAmpliStateFalse;                                         // Utilise par TA pour indiquer que l'ampli est coupe
    function  AmpliIsUsed:Boolean;                                        // Utilise par TA pour savoir si l'ampli est regle pour pouvoir etre coupe pendant les poses
    function  GetAmpliState:boolean;                                      // Utilise par TA pour savoir si l'ampli est coupe ou allume maintenant
    procedure SetShutterOpen;                                             // Utilise par TA pour ouvrir l'obturateur
    procedure SetShutterClosed;                                           // Utilise par TA pour Fermer l'obturateur
    procedure SetShutterSynchro;                                          // Utilise par TA pour synchroniser l'obturateur sur les poses

    // Caracteristiques
    function  GetName:PChar; virtual; abstract;
    function  GetSaturationLevel:Integer; virtual; abstract;
    function  GetXSize:Integer; virtual; abstract;
    function  GetYSize:Integer; virtual; abstract;
    function  GetXPixelSize:Double; virtual; abstract;
    function  GetYPixelSize:Double; virtual; abstract;
    function  IsAValidBinning(Binning:Byte):Boolean; virtual; abstract;
    function  HasTemperature:Boolean; virtual; abstract;
    function  CanCutAmpli:Boolean; virtual; abstract;
    function  GetDelayToSwitchOffAmpli:Double; virtual; abstract;
    function  GetDelayToSwitchOnAmpli:Double; virtual; abstract;
    function  NeedEmptyingDelay:Boolean; virtual; abstract;
    function  NeedReadingDelay:Boolean; virtual; abstract;
    function  NeedCloseShutterDelay:Boolean; virtual; abstract;
    function  HasAShutter:Boolean; virtual; abstract;
    function  IsTrackCCD:Boolean; virtual; abstract;
    function  ShowConfigPanel(IsModal:boolean):Boolean; virtual;
    function  GetTypeData:Integer; virtual;
    function  GetNbPlans:Integer; virtual;
    function  GetMinimalPose:double; virtual;
    procedure IsUsedUnderNT; virtual;
    procedure IsNotUsedUnderNT; virtual;
    function  NeedPixelSize:Boolean; virtual; abstract;
    function  Is16Bits:Boolean; virtual; abstract;
    function  HasCfgWindow:Boolean; virtual; abstract;
    end;

//******************************************************************************
//**************************        Camera Hisis14        **********************
//******************************************************************************

  TCameraHisis14=class(TCamera)
    private
    public
    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;
    function WritePar(Adress:Word;Par:Byte):Boolean;
    function StartPose:Boolean; override;
    function StopPose:Boolean; override;
    function ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; override;
    procedure ShutterOpen; override;
    procedure ShutterClosed; override;
    procedure ShutterSynchro; override;
    procedure GetCCDDateBegin(var Year,Month,Day:Word); override;
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); override;
    procedure GetCCDDateEnd(var Year,Month,Day:Word); override;
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); override;
    procedure SetHourServer(ServerAdress:Pointer); override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    function ShowCfgWindow:Boolean; override;

    // Caracteristiques
    function GetName:PChar; override;
    function GetSaturationLevel:Integer; override;
    function GetXSize:Integer; override;
    function GetYSize:Integer; override;
    function GetXPixelSize:Double; override;
    function GetYPixelSize:Double; override;
    function IsAValidBinning(Binning:Byte):Boolean; override;
    function HasTemperature:Boolean; override;
    function CanCutAmpli:Boolean; override;
    function NeedEmptyingDelay:Boolean; override;
    function NeedReadingDelay:Boolean; override;
    function NeedCloseShutterDelay:Boolean; override;
    function HasAShutter:Boolean; override;
    function IsTrackCCD:Boolean; override;
    function NeedPixelSize:Boolean; override;
    function Is16Bits:Boolean; override;
    function HasCfgWindow:Boolean; override;
    end;

//******************************************************************************
//**************************        Camera Hisis12        **********************
//******************************************************************************

  TCameraHisis12=class(TCamera)
    private
    public
    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;
    function WritePar(Adress:Word;Par:Byte):Boolean;
    function StartPose:Boolean; override;
    function StopPose:Boolean; override;
    function ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; override;
    procedure GetCCDDateBegin(var Year,Month,Day:Word); override;
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); override;
    procedure GetCCDDateEnd(var Year,Month,Day:Word); override;
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); override;
    procedure SetHourServer(ServerAdress:Pointer); override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    function ShowCfgWindow:Boolean; override;

    // Caracteristiques
    function GetName:PChar; override;
    function GetSaturationLevel:Integer; override;
    function GetXSize:Integer; override;
    function GetYSize:Integer; override;
    function GetXPixelSize:Double; override;
    function GetYPixelSize:Double; override;
    function IsAValidBinning(Binning:Byte):Boolean; override;
    function HasTemperature:Boolean; override;
    function CanCutAmpli:Boolean; override;
    function NeedEmptyingDelay:Boolean; override;
    function NeedReadingDelay:Boolean; override;
    function NeedCloseShutterDelay:Boolean; override;
    function HasAShutter:Boolean; override;
    function IsTrackCCD:Boolean; override;
    function NeedPixelSize:Boolean; override;
    function Is16Bits:Boolean; override;
    function HasCfgWindow:Boolean; override;        
    end;

//******************************************************************************
//**************************          Camera ST7          **********************
//******************************************************************************

  TCameraST7=class(TCamera)
    private
    public
    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;
    function StartPose:Boolean; override;
    function StopPose:Boolean; override;
    function ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; override;
    function GetTemperature:Double; override;
    procedure SetTemperature(TargetTemperature:Double); override;
    procedure ShutterOpen; override;
    procedure ShutterClosed; override;
    procedure ShutterSynchro; override;
    procedure GetCCDDateBegin(var Year,Month,Day:Word); override;
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); override;
    procedure GetCCDDateEnd(var Year,Month,Day:Word); override;
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); override;
    procedure SetHourServer(ServerAdress:Pointer); override;    
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    function ShowCfgWindow:Boolean; override;        

    // Caracteristiques
    function GetName:PChar; override;
    function GetSaturationLevel:Integer; override;
    function GetXSize:Integer; override;
    function GetYSize:Integer; override;
    function GetXPixelSize:Double; override;
    function GetYPixelSize:Double; override;
    function IsAValidBinning(Binning:Byte):Boolean; override;
    function HasTemperature:Boolean; override;
    function CanCutAmpli:Boolean; override;
    function NeedEmptyingDelay:Boolean; override;
    function NeedReadingDelay:Boolean; override;
    function NeedCloseShutterDelay:Boolean; override;
    function HasAShutter:Boolean; override;
    function IsTrackCCD:Boolean; override;
    function NeedPixelSize:Boolean; override;
    function Is16Bits:Boolean; override;
    function HasCfgWindow:Boolean; override;        
    end;

//******************************************************************************
//**************************          Camera ST8          **********************
//******************************************************************************

  TCameraST8=class(TCamera)
    private
    public
    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;
    function StartPose:Boolean; override;
    function StopPose:Boolean; override;
    function ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; override;
    function GetTemperature:Double; override;
    procedure SetTemperature(TargetTemperature:Double); override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    procedure ShutterOpen; override;
    procedure ShutterClosed; override;
    procedure ShutterSynchro; override;
    procedure GetCCDDateBegin(var Year,Month,Day:Word); override;
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); override;
    procedure GetCCDDateEnd(var Year,Month,Day:Word); override;
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); override;
    procedure SetHourServer(ServerAdress:Pointer); override;
    function ShowCfgWindow:Boolean; override;        

    // Caracteristiques
    function GetName:PChar; override;
    function GetSaturationLevel:Integer; override;
    function GetXSize:Integer; override;
    function GetYSize:Integer; override;
    function GetXPixelSize:Double; override;
    function GetYPixelSize:Double; override;
    function IsAValidBinning(Binning:Byte):Boolean; override;
    function HasTemperature:Boolean; override;
    function CanCutAmpli:Boolean; override;
    function NeedEmptyingDelay:Boolean; override;
    function NeedReadingDelay:Boolean; override;
    function NeedCloseShutterDelay:Boolean; override;
    function HasAShutter:Boolean; override;
    function IsTrackCCD:Boolean; override;
    function NeedPixelSize:Boolean; override;
    function Is16Bits:Boolean; override;
    function HasCfgWindow:Boolean; override;        
    end;

//******************************************************************************
//**************************        Camera ST7 guidage      **********************
//******************************************************************************

  TCameraSTTrack=class(TCamera)
    private
    public
    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;
    function StartPose:Boolean; override;
    function StopPose:Boolean; override;
    function ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; override;
    procedure ShutterOpen; override;
    procedure ShutterClosed; override;
    procedure ShutterSynchro; override;
    procedure GetCCDDateBegin(var Year,Month,Day:Word); override;
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); override;
    procedure GetCCDDateEnd(var Year,Month,Day:Word); override;
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); override;
    procedure SetHourServer(ServerAdress:Pointer); override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    function ShowCfgWindow:Boolean; override;        

    // Caracteristiques
    function GetName:PChar; override;
    function GetSaturationLevel:Integer; override;
    function GetXSize:Integer; override;
    function GetYSize:Integer; override;
    function GetXPixelSize:Double; override;
    function GetYPixelSize:Double; override;
    function IsAValidBinning(Binning:Byte):Boolean; override;
    function HasTemperature:Boolean; override;
    function CanCutAmpli:Boolean; override;
    function NeedEmptyingDelay:Boolean; override;
    function NeedReadingDelay:Boolean; override;
    function NeedCloseShutterDelay:Boolean; override;
    function HasAShutter:Boolean; override;
    function IsTrackCCD:Boolean; override;
    function NeedPixelSize:Boolean; override;
    function Is16Bits:Boolean; override;
    function HasCfgWindow:Boolean; override;        
    end;

//******************************************************************************
//**************************    Camera Audine400 sans obtu   **********************
//******************************************************************************

  TCameraAudine400=class(TCamera)
    private
    public

    procedure Audine_read_pel_fast;
    procedure Audine_zi_zh;
    procedure Audine_fast_line;
    procedure Audine_fast_vidage;

    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;
    function StartPose:Boolean; override;
    function StopPose:Boolean; override;
    function ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; override;
    procedure AmpliOn; override;
    procedure AmpliOff; override;
    procedure GetCCDDateBegin(var Year,Month,Day:Word); override;
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); override;
    procedure GetCCDDateEnd(var Year,Month,Day:Word); override;
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); override;
    procedure SetHourServer(ServerAdress:Pointer); override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    function ShowCfgWindow:Boolean; override;    

    // Caracteristiques
    function GetName:PChar; override;
    function GetSaturationLevel:Integer; override;
    function GetXSize:Integer; override;
    function GetYSize:Integer; override;
    function GetXPixelSize:Double; override;
    function GetYPixelSize:Double; override;
    function IsAValidBinning(Binning:Byte):Boolean; override;
    function HasTemperature:Boolean; override;
    function CanCutAmpli:Boolean; override;
    function GetDelayToSwitchOffAmpli:Double; override;
    function GetDelayToSwitchOnAmpli:Double; override;
    function NeedEmptyingDelay:Boolean; override;
    function NeedReadingDelay:Boolean; override;
    function NeedCloseShutterDelay:Boolean; override;
    function HasAShutter:Boolean; override;
    function IsTrackCCD:Boolean; override;
    function NeedPixelSize:Boolean; override;
    function Is16Bits:Boolean; override;
    function HasCfgWindow:Boolean; override;        
    end;

//******************************************************************************
//**************************    Camera Audine400 avec obtu   **********************
//******************************************************************************

  TCameraAudineObtu400=class(TCamera)
    private
    public

    procedure Audine_read_pel_fast;
    procedure Audine_zi_zh;
    procedure Audine_fast_line;
    procedure Audine_fast_vidage;

    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;
    function StartPose:Boolean; override;
    function StopPose:Boolean; override;
    function ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; override;
    procedure AmpliOn; override;
    procedure AmpliOff; override;
    procedure ShutterOpen; override;
    procedure ShutterClosed; override;
    procedure ShutterSynchro; override;
    procedure GetCCDDateBegin(var Year,Month,Day:Word); override;
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); override;
    procedure GetCCDDateEnd(var Year,Month,Day:Word); override;
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); override;
    procedure SetHourServer(ServerAdress:Pointer); override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    function ShowCfgWindow:Boolean; override;    

    // Caracteristiques
    function GetName:PChar; override;
    function GetSaturationLevel:Integer; override;
    function GetXSize:Integer; override;
    function GetYSize:Integer; override;
    function GetXPixelSize:Double; override;
    function GetYPixelSize:Double; override;
    function IsAValidBinning(Binning:Byte):Boolean; override;
    function HasTemperature:Boolean; override;
    function CanCutAmpli:Boolean; override;
    function GetDelayToSwitchOffAmpli:Double; override;
    function GetDelayToSwitchOnAmpli:Double; override;
    function NeedEmptyingDelay:Boolean; override;
    function NeedReadingDelay:Boolean; override;
    function NeedCloseShutterDelay:Boolean; override;
    function HasAShutter:Boolean; override;
    function IsTrackCCD:Boolean; override;
    function NeedPixelSize:Boolean; override;
    function Is16Bits:Boolean; override;
    function HasCfgWindow:Boolean; override;        
    end;

//******************************************************************************
//**************************    Camera Audine1600 sans obtu   ******************
//******************************************************************************

  TCameraAudine1600=class(TCamera)
    private
    public

    procedure Audine_read_pel_fast;
    procedure Audine_zi_zh;
    procedure Audine_fast_line;
    procedure Audine_fast_vidage;

    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;
    function StartPose:Boolean; override;
    function StopPose:Boolean; override;
    function ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; override;
    procedure AmpliOn; override;
    procedure AmpliOff; override;
    procedure GetCCDDateBegin(var Year,Month,Day:Word); override;
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); override;
    procedure GetCCDDateEnd(var Year,Month,Day:Word); override;
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    procedure SetHourServer(ServerAdress:Pointer); override;
    function ShowCfgWindow:Boolean; override;    

    // Caracteristiques
    function GetName:PChar; override;
    function GetSaturationLevel:Integer; override;
    function GetXSize:Integer; override;
    function GetYSize:Integer; override;
    function GetXPixelSize:Double; override;
    function GetYPixelSize:Double; override;
    function IsAValidBinning(Binning:Byte):Boolean; override;
    function HasTemperature:Boolean; override;
    function CanCutAmpli:Boolean; override;
    function GetDelayToSwitchOffAmpli:Double; override;
    function GetDelayToSwitchOnAmpli:Double; override;
    function NeedEmptyingDelay:Boolean; override;
    function NeedReadingDelay:Boolean; override;
    function NeedCloseShutterDelay:Boolean; override;
    function HasAShutter:Boolean; override;
    function IsTrackCCD:Boolean; override;
    function NeedPixelSize:Boolean; override;
    function Is16Bits:Boolean; override;
    function HasCfgWindow:Boolean; override;        
    end;

//******************************************************************************
//**************************    Camera Audine1600 avec obtu   ******************
//******************************************************************************

  TCameraAudineObtu1600=class(TCamera)
    private
    public

    procedure Audine_read_pel_fast;
    procedure Audine_zi_zh;
    procedure Audine_fast_line;
    procedure Audine_fast_vidage;

    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;
    function StartPose:Boolean; override;
    function StopPose:Boolean; override;
    function ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; override;
    procedure AmpliOn; override;
    procedure AmpliOff; override;
    procedure ShutterOpen; override;
    procedure ShutterClosed; override;
    procedure ShutterSynchro; override;
    procedure GetCCDDateBegin(var Year,Month,Day:Word); override;
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); override;
    procedure GetCCDDateEnd(var Year,Month,Day:Word); override;
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    procedure SetHourServer(ServerAdress:Pointer); override;
    function ShowCfgWindow:Boolean; override;    

    // Caracteristiques
    function GetName:PChar; override;
    function GetSaturationLevel:Integer; override;
    function GetXSize:Integer; override;
    function GetYSize:Integer; override;
    function GetXPixelSize:Double; override;
    function GetYPixelSize:Double; override;
    function IsAValidBinning(Binning:Byte):Boolean; override;
    function HasTemperature:Boolean; override;
    function CanCutAmpli:Boolean; override;
    function GetDelayToSwitchOffAmpli:Double; override;
    function GetDelayToSwitchOnAmpli:Double; override;
    function NeedEmptyingDelay:Boolean; override;
    function NeedReadingDelay:Boolean; override;
    function NeedCloseShutterDelay:Boolean; override;
    function HasAShutter:Boolean; override;
    function IsTrackCCD:Boolean; override;
    function NeedPixelSize:Boolean; override;
    function Is16Bits:Boolean; override;
    function HasCfgWindow:Boolean; override;        
    end;

//******************************************************************************
//**************************    Camera Audine3200 sans obtu   ******************
//******************************************************************************

  TCameraAudine3200=class(TCamera)
    private
    public

    procedure Audine_read_pel_fast;
    procedure Audine_zi_zh;
    procedure Audine_fast_line;
    procedure Audine_fast_vidage;

    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;
    function StartPose:Boolean; override;
    function StopPose:Boolean; override;
    function ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; override;
    procedure AmpliOn; override;
    procedure AmpliOff; override;
    procedure GetCCDDateBegin(var Year,Month,Day:Word); override;
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); override;
    procedure GetCCDDateEnd(var Year,Month,Day:Word); override;
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    procedure SetHourServer(ServerAdress:Pointer); override;
    function ShowCfgWindow:Boolean; override;    

    // Caracteristiques
    function GetName:PChar; override;
    function GetSaturationLevel:Integer; override;
    function GetXSize:Integer; override;
    function GetYSize:Integer; override;
    function GetXPixelSize:Double; override;
    function GetYPixelSize:Double; override;
    function IsAValidBinning(Binning:Byte):Boolean; override;
    function HasTemperature:Boolean; override;
    function CanCutAmpli:Boolean; override;
    function GetDelayToSwitchOffAmpli:Double; override;
    function GetDelayToSwitchOnAmpli:Double; override;
    function NeedEmptyingDelay:Boolean; override;
    function NeedReadingDelay:Boolean; override;
    function NeedCloseShutterDelay:Boolean; override;
    function HasAShutter:Boolean; override;
    function IsTrackCCD:Boolean; override;
    function NeedPixelSize:Boolean; override;
    function Is16Bits:Boolean; override;
    function HasCfgWindow:Boolean; override;        
    end;

//******************************************************************************
//**************************    Camera Audine3200 avec obtu   ******************
//******************************************************************************

  TCameraAudineObtu3200=class(TCamera)
    private
    public

    procedure Audine_read_pel_fast;
    procedure Audine_zi_zh;
    procedure Audine_fast_line;
    procedure Audine_fast_vidage;

    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;
    function StartPose:Boolean; override;
    function StopPose:Boolean; override;
    function ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; override;
    procedure AmpliOn; override;
    procedure AmpliOff; override;
    procedure ShutterOpen; override;
    procedure ShutterClosed; override;
    procedure ShutterSynchro; override;
    procedure GetCCDDateBegin(var Year,Month,Day:Word); override;
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); override;
    procedure GetCCDDateEnd(var Year,Month,Day:Word); override;
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    procedure SetHourServer(ServerAdress:Pointer); override;
    function ShowCfgWindow:Boolean; override;        

    // Caracteristiques
    function GetName:PChar; override;
    function GetSaturationLevel:Integer; override;
    function GetXSize:Integer; override;
    function GetYSize:Integer; override;
    function GetXPixelSize:Double; override;
    function GetYPixelSize:Double; override;
    function IsAValidBinning(Binning:Byte):Boolean; override;
    function HasTemperature:Boolean; override;
    function CanCutAmpli:Boolean; override;
    function GetDelayToSwitchOffAmpli:Double; override;
    function GetDelayToSwitchOnAmpli:Double; override;
    function NeedEmptyingDelay:Boolean; override;
    function NeedReadingDelay:Boolean; override;
    function NeedCloseShutterDelay:Boolean; override;
    function HasAShutter:Boolean; override;
    function IsTrackCCD:Boolean; override;
    function NeedPixelSize:Boolean; override;
    function Is16Bits:Boolean; override;
    function HasCfgWindow:Boolean; override;        
    end;

//******************************************************************************
//**************************         Camera Webcam        **********************
//******************************************************************************
// Dans pu_webcam

//******************************************************************************
//**************************        Camera Virtuelle      **********************
//******************************************************************************

  TCameraVirtual=class(TCamera)
    private
    public

    // Fonctionnement
    function  IsConnectedAndOK:Boolean; override;
    function  Open:Boolean; override;
    procedure Close; override;
    function  StartPose:Boolean; override;
    function  StopPose:Boolean; override;
    function  ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; override;
    procedure GetCCDDateBegin(var Year,Month,Day:Word); override;
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); override;
    procedure GetCCDDateEnd(var Year,Month,Day:Word); override;
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); override;
    procedure SetHourServer(ServerAdress:Pointer); override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    function ShowCfgWindow:Boolean; override;    

    // Caracteristiques
    function GetName:PChar; override;
    function GetSaturationLevel:Integer; override;
    function GetXSize:Integer; override;
    function GetYSize:Integer; override;
    function GetXPixelSize:Double; override;
    function GetYPixelSize:Double; override;
    function IsAValidBinning(Binning:Byte):Boolean; override;
    function HasTemperature:Boolean; override;
    function CanCutAmpli:Boolean; override;
    function NeedEmptyingDelay:Boolean; override;
    function NeedReadingDelay:Boolean; override;
    function NeedCloseShutterDelay:Boolean; override;
    function HasAShutter:Boolean; override;
    function IsTrackCCD:Boolean; override;
    function NeedPixelSize:Boolean; override;
    function Is16Bits:Boolean; override;
    function HasCfgWindow:Boolean; override;        
    end;

//******************************************************************************
//**************************    Camera PlugIn TeleAuto    **********************
//******************************************************************************

    TSetPort                  = procedure(_Adress:Word);                        cdecl;
    TSetWindow                = function(_x1,_y1,_x2,_y2:Integer):Boolean;      cdecl;              
    TSetBinning               = function(_Binning:Integer):Boolean;             cdecl;
    TSetPose                  = function(_Pose:Double):Boolean;                 cdecl;
    TSetEmptyingDelay         = function(_EmptyingDelay:Double):Boolean;        cdecl;
    TSetReadingDelay          = function(_ReadingDelay:Double):Boolean;         cdecl;
    TSetShutterCloseDelay     = function(Delay:Double):boolean;                 cdecl;
    TIsConnectedAndOK         = function:Boolean;                               cdecl;
    TOpen                     = function:Boolean;                               cdecl;
    TClose                    = procedure;                                      cdecl;
    TStartPose                = function:Boolean;                               cdecl;
    TStopPose                 = function:Boolean;                               cdecl;
    TReadCCD                  = function(TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; cdecl;
    TGetTemperature           = function:Double;                                cdecl;
    TSetPCMinusUT             = procedure(PCMinusUT:Double);                    cdecl;
    TSetTemperature           = procedure(TargetTemperature:Double);            cdecl;

    TAmpliOn                  = procedure;                                      cdecl;
    TAmpliOff                 = procedure;                                      cdecl;
    TShutterOpen              = procedure;                                      cdecl;
    TShutterClosed            = procedure;                                      cdecl;
    TShutterSynchro           = procedure;                                      cdecl;
    TGetCCDDateBegin          = procedure(var Year,Month,Day:Word);             cdecl;
    TGetCCDTimeBegin          = procedure(var Hour,Min,Sec,MSec:Word);          cdecl;
    TGetCCDDateEnd            = procedure(var Year,Month,Day:Word);             cdecl;
    TGetCCDTimeEnd            = procedure(var Hour,Min,Sec,MSec:Word);          cdecl;
    TSetHourServer            = procedure(ServerAdress:Pointer);                cdecl;
    TGetShutterCloseDelay     = procedure(_Delay:Double);                       cdecl;

    // Caracteristiques
    TGetName                  = function:PChar;                                 cdecl;
    TGetSaturationLevel       = function:Integer;                               cdecl;
    TGetXSize                 = function:Integer;                               cdecl;
    TGetYSize                 = function:Integer;                               cdecl;
    TGetXPixelSize            = function:Double;                                cdecl;
    TGetYPixelSize            = function:Double;                                cdecl;
    TGetNbPlans               = function:Integer;                               cdecl;
    TGetTypeData              = function:Integer;                               cdecl;
    TIsAValidBinning          = function(Binning:Byte):Boolean;                 cdecl;
    THasTemperature           = function:Boolean;                               cdecl;
    TCanCutAmpli              = function:Boolean;                               cdecl;
    TGetDelayToSwitchOffAmpli = function:Double;                                cdecl;
    TGetDelayToSwitchOnAmpli  = function:Double;                                cdecl;
    TNeedEmptyingDelay        = function:Boolean;                               cdecl;
    TNeedReadingDelay         = function:Boolean;                               cdecl;
    TNeedCloseShutterDelay    = function:Boolean;                               cdecl;
    THasAShutter              = function:Boolean;                               cdecl;
    TIsUsedUnderNT            = procedure;                                      cdecl;
    TIsNotUsedUnderNT         = procedure;                                      cdecl;
    TIs16Bits                 = function:Boolean;                               cdecl;
    TShowCfgWindow            = function:Boolean;                               cdecl;
    THasCfgWindow             = function:Boolean;                               cdecl;        

var

    PluginSetPort                  : TSetPort;
    PluginSetWindow                : TSetWindow;
    PluginSetBinning               : TSetBinning;
    PluginSetPose                  : TSetPose;
    PluginSetEmptyingDelay         : TSetEmptyingDelay;
    PluginSetReadingDelay          : TSetReadingDelay;
    PluginSetShutterCloseDelay     : TSetShutterCloseDelay;

    PluginIsConnectedAndOK         : TIsConnectedAndOK;
    PluginOpen                     : TOpen;
    PluginClose                    : TClose;
    PluginStartPose                : TStartPose;
    PluginStopPose                 : TStopPose;
    PluginReadCCD                  : TReadCCD;
    PluginGetTemperature           : TGetTemperature;
    PluginSetTemperature           : TSetTemperature;
    PluginSetPCMinusUT             : TSetPCMinusUT;
    PluginAmpliOn                  : TAmpliOn;
    PluginAmpliOff                 : TAmpliOff;
    PluginShutterOpen              : TShutterOpen;
    PluginShutterClosed            : TShutterClosed;
    PluginShutterSynchro           : TShutterSynchro;
    PluginGetCCDDateBegin          : TGetCCDDateBegin;
    PluginGetCCDTimeBegin          : TGetCCDTimeBegin;
    PluginGetCCDDateEnd            : TGetCCDDateEnd;
    PluginGetCCDTimeEnd            : TGetCCDTimeEnd;
    PluginSetHourServer            : TSetHourServer;
    PluginGetShutterCloseDelay     : TGetShutterCloseDelay;

    // Caracteristiques
    PluginGetName                  : TGetName;
    PluginGetSaturationLevel       : TGetSaturationLevel;
    PluginGetXSize                 : TGetXSize;
    PluginGetYSize                 : TGetYSize;
    PluginGetXPixelSize            : TGetXPixelSize;
    PluginGetYPixelSize            : TGetYPixelSize;
    PluginGetNbPlans               : TGetNbPlans;
    PluginGetTypeData              : TGetTypeData;
    PluginIsAValidBinning          : TIsAValidBinning;
    PluginHasTemperature           : THasTemperature;
    PluginCanCutAmpli              : TCanCutAmpli;
    PluginGetDelayToSwitchOffAmpli : TGetDelayToSwitchOffAmpli;
    PluginGetDelayToSwitchOnAmpli  : TGetDelayToSwitchOnAmpli;
    PluginNeedEmptyingDelay        : TNeedEmptyingDelay;
    PluginNeedReadingDelay         : TNeedReadingDelay;
    PluginNeedCloseShutterDelay    : TNeedCloseShutterDelay;
    PluginHasAShutter              : THasAShutter;
    PluginIsUsedUnderNT            : TIsUsedUnderNT;
    PluginIsNotUsedUnderNT         : TIsNotUsedUnderNT;
    PluginIs16Bits                 : TIs16Bits;
    PluginShowCfgWindow            : TShowCfgWindow;
    PluginHasCfgWindow             : THasCfgWindow;        

    PluginCameraSuivi : Boolean = False;
    
type

  TCameraPlugin=class(TCamera)
    private
    public
    HandlePlugin:Integer;

    // Fonctionnement
    constructor Create;

    procedure SetPort(_Adress:Word); override;
    function  SetWindow(_x1,_y1,_x2,_y2:Integer):Boolean; override;
    function  SetBinning(_Binning:Integer):Boolean; override;
    function  SetPose(_Pose:Double):Boolean; override;
    function  SetEmptyingDelay(_EmptyingDelay:Double):Boolean; override;
    function  SetReadingDelay(_ReadingDelay:Double):Boolean; override;
    function  SetShutterCloseDelay(Delay:Double):Boolean; override;

    function  IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;
    function  StartPose:Boolean; override;
    function  StopPose:Boolean; override;
    function  ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; override;
    function  GetTemperature:Double; override;
    procedure SetTemperature(TargetTemperature:Double); override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    procedure AmpliOn; override;
    procedure AmpliOff; override;
    procedure ShutterOpen; override;
    procedure ShutterClosed; override;
    procedure ShutterSynchro; override;
    procedure GetCCDDateBegin(var Year,Month,Day:Word); override;
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); override;
    procedure GetCCDDateEnd(var Year,Month,Day:Word); override;
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); override;
    procedure SetHourServer(ServerAdress:Pointer); override;
    function ShowCfgWindow:Boolean; override;    

    // Caracteristiques
    function GetName:PChar; override;
    function GetSaturationLevel:Integer; override;
    function GetXSize:Integer; override;
    function GetYSize:Integer; override;
    function GetXPixelSize:Double; override;
    function GetYPixelSize:Double; override;
    function GetNbPlans:Integer; override;
    function GetTypeData:Integer; override;
    function IsAValidBinning(Binning:Byte):Boolean; override;
    function HasTemperature:Boolean; override;
    function CanCutAmpli:Boolean; override;
    function GetDelayToSwitchOffAmpli:Double; override;
    function GetDelayToSwitchOnAmpli:Double; override;
    function NeedEmptyingDelay:Boolean; override;
    function NeedReadingDelay:Boolean; override;
    function NeedCloseShutterDelay:Boolean; override;
    function HasAShutter:Boolean; override;
    procedure IsUsedUnderNT; override;
    procedure IsNotUsedUnderNT; override;
    function IsTrackCCD:Boolean; override;
    function NeedPixelSize:Boolean; override;
    function Is16Bits:Boolean; override;
    function HasCfgWindow:Boolean; override;        
    end;

//******************************************************************************
//**************************          Camera ST7          **********************
//******************************************************************************

  TCameraST9=class(TCamera)
    private
    public
    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;
    function StartPose:Boolean; override;
    function StopPose:Boolean; override;
    function ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; override;
    function GetTemperature:Double; override;
    procedure SetTemperature(TargetTemperature:Double); override;
    procedure ShutterOpen; override;
    procedure ShutterClosed; override;
    procedure ShutterSynchro; override;
    procedure GetCCDDateBegin(var Year,Month,Day:Word); override;
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); override;
    procedure GetCCDDateEnd(var Year,Month,Day:Word); override;
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); override;
    procedure SetHourServer(ServerAdress:Pointer); override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    function ShowCfgWindow:Boolean; override;    

    // Caracteristiques
    function GetName:PChar; override;
    function GetSaturationLevel:Integer; override;
    function GetXSize:Integer; override;
    function GetYSize:Integer; override;
    function GetXPixelSize:Double; override;
    function GetYPixelSize:Double; override;
    function IsAValidBinning(Binning:Byte):Boolean; override;
    function HasTemperature:Boolean; override;
    function CanCutAmpli:Boolean; override;
    function NeedEmptyingDelay:Boolean; override;
    function NeedReadingDelay:Boolean; override;
    function NeedCloseShutterDelay:Boolean; override;
    function HasAShutter:Boolean; override;
    function IsTrackCCD:Boolean; override;
    function NeedPixelSize:Boolean; override;
    function Is16Bits:Boolean; override;
    function HasCfgWindow:Boolean; override;        
    end;

//******************************************************************************
//**************************          Camera ST10         **********************
//******************************************************************************

  TCameraST10=class(TCamera)
    private
    public
    // Fonctionnement
    constructor Create;
    function IsConnectedAndOK:Boolean; override;
    function Open:Boolean; override;
    procedure Close; override;
    function StartPose:Boolean; override;
    function StopPose:Boolean; override;
    function ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean; override;
    function GetTemperature:Double; override;
    procedure SetTemperature(TargetTemperature:Double); override;
    procedure ShutterOpen; override;
    procedure ShutterClosed; override;
    procedure ShutterSynchro; override;
    procedure GetCCDDateBegin(var Year,Month,Day:Word); override;
    procedure GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word); override;
    procedure GetCCDDateEnd(var Year,Month,Day:Word); override;
    procedure GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word); override;
    procedure SetHourServer(ServerAdress:Pointer); override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    function ShowCfgWindow:Boolean; override;        

    // Caracteristiques
    function GetName:PChar; override;
    function GetSaturationLevel:Integer; override;
    function GetXSize:Integer; override;
    function GetYSize:Integer; override;
    function GetXPixelSize:Double; override;
    function GetYPixelSize:Double; override;
    function IsAValidBinning(Binning:Byte):Boolean; override;
    function HasTemperature:Boolean; override;
    function CanCutAmpli:Boolean; override;
    function NeedEmptyingDelay:Boolean; override;
    function NeedReadingDelay:Boolean; override;
    function NeedCloseShutterDelay:Boolean; override;
    function HasAShutter:Boolean; override;
    function IsTrackCCD:Boolean; override;
    function NeedPixelSize:Boolean; override;
    function Is16Bits:Boolean; override;
    function HasCfgWindow:Boolean; override;        
    end;

  procedure CameraConnect;
  procedure CameraDisconnect;
  procedure CameraSuiviConnect;
  procedure CameraSuiviDisconnect;

var
  Camera,CameraSuivi:TCamera;
  TesteFocalisation,VAcqNoir:Boolean;

  // on laisse ca la en attendant
  PoseLo : Word;
  PoseHi : Byte;
  PoseI  : LongInt absolute PoseLo;

implementation

uses u_file_io,
     u_lang,
     u_driver_st7,
     u_driver_st7_nt,     
     u_general,
     pu_webcam,
     u_math,
     u_modelisation,
     u_porttalk,
     u_hour_servers,
     u_constants,
     pu_map,
     pu_camera,
     pu_camera_suivi,
     u_filtrage;

//******************************************************************************
//********************** Interface camera de haut niveau **********************
//******************************************************************************
// Remplace pop_main.update_camera;
// Choses à faire pour connecter la caméra
procedure CameraConnect;
begin
   try
   try
   // Verification si la camera est branchee
   Config.CameraBranchee:=False;
   // Config de la camera
   PluginCameraSuivi:=false;  // c'est la camera principale
   case Config.TypeCamera of
             Aucune:Camera:=TCameraVirtual.Create;
      Hisis2214Bits:Camera:=TCameraHisis14.Create;
      Hisis2212Bits:Camera:=TCameraHisis12.Create;
                ST7:Camera:=TCameraST7.Create;
                ST8:Camera:=TCameraST8.Create;
          Audine400:Camera:=TCameraAudine400.Create;
      AudineObtu400:Camera:=TCameraAudineObtu400.Create;
         Audine1600:Camera:=TCameraAudine1600.Create;
     AudineObtu1600:Camera:=TCameraAudineObtu1600.Create;
             Plugin:Camera:=TCameraPlugin.Create;
             Webcam:Camera:=TCameraWebcam.Create;
            STTrack:Camera:=TCameraSTTrack.Create;
          Virtuelle:Camera:=TCameraVirtual.Create;
         Audine3200:Camera:=TCameraAudine3200.Create;
     AudineObtu3200:Camera:=TCameraAudineObtu3200.Create;
                ST9:Camera:=TCameraST9.Create;
               ST10:Camera:=TCameraST10.Create;
      //Penser a mettre a jour procedure Tpop_conf.UdpateCamera;
      end;

   if Config.TypeCamera<>0 then
      begin
      Camera.SetPort(Config.AdresseCamera);
      if Camera.NeedEmptyingDelay then Camera.SetEmptyingDelay(Config.DelaiVidage);
      if Camera.NeedReadingDelay then Camera.SetReadingDelay(Config.ReadingDelai);
      if Camera.NeedCloseShutterDelay then Camera.SetShutterCloseDelay(Config.ObtuCloseDelay);
      // On regle le driver de la camera si on peut couper l'ampli et que l'user le demande
      if Camera.CanCutAmpli then
         begin
         if Config.CutAmpli then Camera.SetAmpliUsed else Camera.SetAmpliUnused;
         // de toute facon on initialise * l etat * de l ampli a true
         Camera.SetAmpliStateTrue;
         end;
      Camera.SetPCMinusUT(Config.PCMoinsTU);

      case Config.TypeOS of
         0:Camera.IsNotUsedUnderNT;
         1:Camera.IsUsedUnderNT;
         end;

      Camera.SetHourServer(@GetHour);
      if Camera.Open then
         begin
         Config.CameraBranchee:=Camera.IsConnectedAndOK;

         if Config.CameraBranchee then
            begin
            if not Config.InPopConf then
               if Camera.HasTemperature then
                  Camera.SetTemperature(config.Temperature);
            end;
         end
      else Config.CameraBranchee:=False;

      end
   else Config.CameraBranchee:=False;

   except
   on E: Exception do
      begin
      ShowMessage(E.Message);
      Config.CameraBranchee:=False;
      end;
   end

   finally
   pop_main.UpdateGUICamera;
   end;
end;

// Choses à faire pour déconnecter la caméra
procedure CameraDisconnect;
begin
   try

//   if (Config.TypeCamera<>0) and Config.CameraBranchee then
   if Config.CameraBranchee then
      begin
      Camera.Close;
      Camera.Free;
      Config.CameraBranchee:=False;

      if pop_camera.Visible then
         begin
         pop_camera.Hide;
         pop_main.ToolButton6.Down:=False;
         end;

      end;

   if Config.TypeCamera=Aucune then Camera.Free;

   finally
   pop_main.UpdateGUICamera;
   end;
end;

//******************************************************************************
//**************** Interface camera de guidage de haut niveau ******************
//******************************************************************************
// Remplace pop_main.update_camera_suivi
// Choses à faire pour connecter la caméra de guidage
procedure CameraSuiviConnect;
begin
   try
   try
   // Verification si la camera de guidage est branchee
   Config.CameraSuiviBranchee:=False;
   // Config de la camera
   PluginCameraSuivi:=true;  // c'est la camera de guidage
   case Config.TypeCameraSuivi of
             Aucune:CameraSuivi:=TCameraVirtual.Create;
      Hisis2214Bits:CameraSuivi:=TCameraHisis14.Create;
      Hisis2212Bits:CameraSuivi:=TCameraHisis12.Create;
                ST7:CameraSuivi:=TCameraST7.Create;
                ST8:CameraSuivi:=TCameraST8.Create;
          Audine400:CameraSuivi:=TCameraAudine400.Create;
      AudineObtu400:CameraSuivi:=TCameraAudineObtu400.Create;
         Audine1600:CameraSuivi:=TCameraAudine1600.Create;
     AudineObtu1600:CameraSuivi:=TCameraAudineObtu1600.Create;
             Plugin:CameraSuivi:=TCameraPlugin.Create;
             Webcam:CameraSuivi:=TCameraWebcam.Create;
            STTrack:CameraSuivi:=TCameraSTTrack.Create;
          Virtuelle:CameraSuivi:=TCameraVirtual.Create;
         Audine3200:CameraSuivi:=TCameraAudine3200.Create;
     AudineObtu3200:CameraSuivi:=TCameraAudineObtu3200.Create;
                ST9:CameraSuivi:=TCameraST9.Create;
               ST10:CameraSuivi:=TCameraST10.Create;
      //Penser a mettre a jour procedure Tpop_conf.UdpateCameraSuivi;               
      end;

   if Config.TypeCameraSuivi<>0 then
      begin
      CameraSuivi.SetPort(Config.AdresseCameraSuivi);
      CameraSuivi.SetAcqTrack(True);
      if CameraSuivi.NeedEmptyingDelay then CameraSuivi.SetEmptyingDelay(Config.DelaiVidageSuivi);
      if CameraSuivi.NeedReadingDelay then CameraSuivi.SetReadingDelay(Config.ReadingDelaiSuivi);
      if CameraSuivi.NeedCloseShutterDelay then CameraSuivi.SetShutterCloseDelay(Config.ObtuCloseDelaySuivi);
      // On regle le driver de la camera si on peut couper l'ampli et que l'user le demande
      if CameraSuivi.CanCutAmpli then
         begin
         if Config.CutAmpliSuivi then CameraSuivi.SetAmpliUsed else CameraSuivi.SetAmpliUnused;
         // de toute facon on initialise * l etat * de l ampli a true
         CameraSuivi.SetAmpliStateTrue;
         end;
      CameraSuivi.SetPCMinusUT(Config.PCMoinsTU);

      case Config.TypeOS of
         0:CameraSuivi.IsNotUsedUnderNT;
         1:CameraSuivi.IsUsedUnderNT;
         end;

      // Oula, il faut pas appeler open sous NT avec les ST !
      if (Config.TypeCameraSuivi<>STTrack) then CameraSuivi.Open;
      if (Config.TypeCameraSuivi=STTrack) then
         if (Config.TypeCamera<>ST7) and (Config.TypeCamera<>ST8) and (Config.TypeCamera<>ST9) then
            CameraSuivi.Open;
      Config.CameraSuiviBranchee:=CameraSuivi.IsConnectedAndOK;
      end
   else Config.CameraSuiviBranchee:=False;

   except
   Config.CameraSuiviBranchee:=False;
   end

   finally
   pop_main.UpdateGUICameraSuivi;
   end;
end;

// Choses à faire pour déconnecter la caméra de guidage
procedure CameraSuiviDisConnect;
begin
   try

   if Config.CameraSuiviBranchee then
      begin
      CameraSuivi.Close;
      CameraSuivi.Free;
      Config.CameraSuiviBranchee:=False;

      if pop_camera_suivi.Visible then
         begin
         pop_camera_suivi.Hide;
         pop_main.ToolButton7.Down:=False;
         end;

      end;

   if Config.TypeCameraSuivi=Aucune then CameraSuivi.Free;

   finally
   pop_main.UpdateGUICameraSuivi;
   end;
end;

//******************************************************************************
//**************************       Camera Generique       **********************
//******************************************************************************

constructor TCamera.Create;
begin
   inherited Create;
   ShutterState:=ShutterIsSynchro;
end;

procedure TCamera.SetImageName(s:string);
begin
   GenericImageName:=s;
end;

procedure TCamera.Image(nbr_exp:integer);
begin
     MakeImage(nbr_exp,1);
end;

procedure TCamera.Dark(nbr_exp:integer);
begin
     MakeImage(nbr_exp,0);
end;

procedure TCamera.Flat(nbr_exp:integer);
begin
     MakeImage(nbr_exp,1);
end;

procedure TCamera.Offset(nbr_exp:integer);
begin
     MakeImage(nbr_exp,0);
end;

procedure TCamera.makeimage(nbr_exp,shutterstate:integer);
var
   TimeCourant,TimeInit:TDateTime;
   loop,i,j,k,sx,sy,typedata,nbplans:Integer;
   InterI:SmallInt;
   resultat:boolean;
   Year,Month,Day:Word;
   Hour,Min,Sec,MSec:Word;
   ax,bx,ay,by:double;
   DataInt:PTabImgInt;         // TypeData=2
   DataDouble:PTabImgDouble;
   ImgInfos:TImgInfos;         // Autres infos
begin
         if x1>GetXSize div binning then x1:=GetXSize div binning;
         if x2>GetXSize div binning then x2:=GetXSize div binning;
         if y1>GetYSize div binning then y1:=GetYSize div binning;
         if y2>GetYSize div binning then y2:=GetYSize div binning;
         if x1<1 then x1:=1;
         if x2<1 then x2:=1;
         if y1<1 then y1:=1;
         if y2<1 then y2:=1;
         // y=ax+b
         ax:=(GetXSize-1)/((GetXSize div binning)-1);
         bx:=1-ax;
         ay:=(GetYSize-1)/((GetYSize div binning)-1);
         by:=1-ay;
         // init
         TypeData:=GetTypeData;
         NbPlans:=GetNbPlans;
         if pose<GetMinimalPose then pose:=GetMinimalPose;
         // taille image
         Sx:=(x2-x1+1);
         Sy:=(y2-y1+1);
         // miroir
         if Config.MirrorX then
         begin
              x1:=GetXSize div binning-x1+1;
              x2:=GetXSize div binning-x2+1;
         end;
         if Config.MirrorY then
         begin
              y1:=GetYSize div binning-y1+1;
              y2:=GetYSize div binning-y2+1;
         end;
         // set camera
         SetWindow(Round(ax*x1+bx),Round(ay*y1+by),Round(ax*x2+bx),Round(ay*y2+by));
         if (ShutterState=1) and HasAShutter then SetShutterClosed;
         // go
         for loop:=1 to nbr_exp do
         begin
             // memoire
             Getmem(DataInt,4*NbPlans);
             for k:=1 to Nbplans do
             begin
                  Getmem(DataInt^[k],4*Sy);
                  for i:=1 to Sy do Getmem(DataInt^[k]^[i],Sx*2);
             end;
             Resultat:=StartPose;
             if Resultat then
             begin
                  GetCCDDateBegin(Year,Month,Day);
                  GetCCDTimeBegin(Hour,Min,Sec,MSec);
                  if ((CanCutAmpli) and (AmpliIsUsed) and (not getamplistate)) and
                     (pose > GetDelayToSwitchOffAmpli) then
                     begin
                          MySleep(round((pose*1000)-GetDelayToSwitchOnAmpli));
                          AmpliOn;
                          setamplistatetrue;
                          MySleep(round(GetDelayToSwitchOnAmpli*1000));
                     end
                     else
                     begin
                          MySleep(round(pose*1000));
                     end;
             end;
             TimeInit:=EncodeDate(Year,Month,Day)+EncodeTime(Hour,Min,Sec,MSec);
             ImgInfos.TempsPose:=round(pose*1000);
             // On met a jour le temps de milieu de pose avec le temps de pose reel mesuré !
             ImgInfos.DateTime:=TimeInit+(pose/24/3600/2);
             try
             ReadCCD(DataInt,sx,sy);
             except
             Config.CameraBranchee:=False;
             end;
             // miroirs
             if config.MirrorX then
             for k:=1 to Nbplans do
                for j:=1 to Sy do
                   for i:=1 to Sx div binning do
                      begin
                      InterI:=DataInt^[k]^[j]^[i];
                      DataInt^[k]^[j]^[i]:=DataInt^[k]^[j]^[Sx-i+1];
                      DataInt^[k]^[j]^[Sx-i+1]:=InterI;
                      end;
             if config.MirrorY then
             for k:=1 to Nbplans do
                for j:=1 to Sx do
                   for i:=1 to Sy div binning do
                      begin
                      InterI:=DataInt^[k]^[i]^[j];
                      DataInt^[k]^[i]^[j]:=DataInt^[k]^[Sy-i+1]^[j];
                      DataInt^[k]^[Sy-i+1]^[j]:=InterI;
                      end;
             // Imginfos
             InitImgInfos(ImgInfos);
             ImgInfos.TempsPose:=Round(pose); // Conversion s -> ms
             ImgInfos.DateTime:=TimeInit+(pose/24/3600/2);
             ImgInfos.BinningX:=binning;
             ImgInfos.BinningY:=binning;
             ImgInfos.MiroirX:=config.MirrorX;
             ImgInfos.MiroirY:=config.MirrorY;
             ImgInfos.Telescope:=config.Telescope;
             ImgInfos.Observateur:=config.Observateur;
             ImgInfos.Camera:=GetName;
             ImgInfos.Filtre:=config.Filtre;
             ImgInfos.Observatoire:=config.Observatoire;
             ImgInfos.Focale:=config.FocaleTele;
             ImgInfos.Diametre:=config.Diametre;
             ImgInfos.OrientationCCD:=config.OrientationCCD;
             ImgInfos.Seeing:=config.Seeing;
             if hastemperature then ImgInfos.TemperatureCCD:=gettemperature else ImgInfos.TemperatureCCD:=999;
             ImgInfos.PixX:=Camera.GetXPixelSize;
             ImgInfos.PixY:=Camera.GetYPixelSize;
             ImgInfos.X1:=x1;
             ImgInfos.Y1:=y1;
             ImgInfos.X2:=x2;
             ImgInfos.Y2:=y2;
             ImgInfos.BScale:=1;
             ImgInfos.BZero:=0;
             if Config.GoodPos then
                begin
                ImgInfos.Alpha:=Config.AlphaScope;
                ImgInfos.Delta:=Config.DeltaScope;
                end
             else
                begin
                WriteSpy(lang('Le télescope ne veut pas donner sa position'));
                pop_Main.AfficheMessage(lang('Erreur'),
                   lang('Le télescope ne veut pas donner sa position'));
                end;
             // save, a modifier
             saveimagegenerique(GenericImageName,dataint,DataDouble,imginfos);
             // kill
             for k:=1 to Nbplans do
             begin
                  for i:=1 to Sy do Freemem(DataInt^[k]^[i],Sx*2);
                  Freemem(DataInt^[k],4*Sy);
             end;
             Freemem(DataInt,4*Nbplans);
         end;
end;

procedure TCamera.SetPort(_Adress:Word);
begin
   Adress:=_Adress;
end;

function TCamera.SetWindow(_x1,_y1,_x2,_y2:Integer):Boolean;
begin
if (_x1>0) and (_x2>0) and (_x1<GetXSize+1) and (_x2<GetXSize+1) and
   (_y1>0) and (_y2>0) and (_y1<GetYSize+1) and (_y2<GetYSize+1) then
   begin
   if (_x2>_x1) then
      begin
      x1:=_x1;
      x2:=_x2;
      end
   else
      begin
      x2:=_x1;
      x1:=_x2;
      end;

   if (_y2>_y1) then
      begin
      y1:=_y1;
      y2:=_y2;
      end
   else
      begin
      y2:=_y1;
      y1:=_y2;
      end;

//   WriteSpy(GetName+lang(' Fenêtre : (')+IntToStr(x1)+','+IntToStr(y1)+lang(')/(')+IntToStr(x2)+','+IntToStr(y2)+')');
   Result:=True;
   end
else Result:=False;
end;

function TCamera.SetBinning(_Binning:Integer):Boolean;
begin
if (_Binning=1) or (_Binning=2) or (_Binning=3) or (_Binning=4) then
   begin
   Binning:=_Binning;
//   WriteSpy(GetName+lang(' Binning : ')+IntToStr(Binning));
   Result:=True;
   end
else Result:=False;
end;

function TCamera.SetPose(_Pose:Double):Boolean;
begin
if (_Pose>0) and (_Pose<50331.645) then
   begin
   Pose:=_Pose;
   Result:=True;
   end
else Result:=False;
end;

function TCamera.SetEmptyingDelay(_EmptyingDelay:Double):Boolean;
begin
if (_EmptyingDelay>0) then
   begin
   EmptyingDelay:=_EmptyingDelay;
   Result:=True;
   end
else Result:=False;
end;

function TCamera.SetReadingDelay(_ReadingDelay:Double):Boolean;
begin
if (_ReadingDelay>0) then
   begin
   ReadingDelay:=_ReadingDelay;
   Result:=True;
   end
else Result:=False;
end;

function TCamera.SetShutterCloseDelay(Delay:Double):Boolean;
begin
if (Delay>0) then
   begin
   ShutterCloseDelay:=Delay;
   Result:=True;
   end
else Result:=False;
end;

function TCamera.SetAcqTrack(_AcqTrack:Boolean):Boolean;
begin
AcqTrack:=_AcqTrack;
Result:=True;
end;

procedure TCamera.SetAmpliStateTrue;
begin
AmpliState:=True;
end;

procedure TCamera.SetAmpliStateFalse;
begin
AmpliState:=False;
end;

procedure TCamera.SetAmpliUsed;
begin
UseAmpli:=True;
end;

procedure TCamera.SetAmpliUnused;
begin
UseAmpli:=False;
end;

function  TCamera.AmpliIsUsed:Boolean;
begin
Result:=UseAmpli;
end;

function TCamera.GetAmpliState:boolean;
begin
result:=AmpliState;
end;

procedure TCamera.SetShutterOpen;
begin
ShutterState:=ShutterIsAllwaysOpen;
ShutterOpen;
end;

procedure TCamera.SetShutterClosed;
begin
ShutterState:=ShutterIsAllwaysClosed;
ShutterClosed;
end;

procedure TCamera.SetShutterSynchro;
begin
ShutterState:=ShutterIsSynchro;
ShutterSynchro;
end;

function TCamera.ShowConfigPanel(IsModal:boolean):Boolean;
begin
result:=false;  // pas de menu de config pas defaut
end;

function  TCamera.CanStopNow:Boolean;
begin
result:=true;
end;

procedure TCamera.AdjustIntervalePose(var NbInterValCourant,NbSubImage : integer; Interval : integer);
begin
NbSubImage:=0;
end;

function TCamera.GetTypeData:Integer;
begin
result:=2;
end;

function TCamera.GetNbPlans:Integer;
begin
result:=1;
end;

function TCamera.GetMinimalPose:double;
begin
Result:=0;
end;

procedure TCamera.IsUsedUnderNT;
begin
OSIsNT:=True;
end;

procedure TCamera.IsNotUsedUnderNT;
begin
OSIsNT:=False;
end;

//******************************************************************************
//**************************        Camera Hisis14        **********************
//******************************************************************************

constructor TCameraHisis14.Create;
begin
   inherited Create;
end;

function TCameraHisis14.WritePar(Adress:Word;Par:Byte):Boolean;
var
i:integer;
begin
Result:=True;
i:=0;
repeat inc(i) until ((PortRead(Adress+1) and $40)=$40) or (i>10000);
if i>10000 then begin Result:=False; Exit; end;
PortWrite(Par,Adress);
for i:=1 to 10000 do;
PortWrite($0D,Adress+2);
i:=0;
repeat inc(i) until ((PortRead(Adress+1) and $40)=0) or (i>10000);
if i>10000 then begin Result:=False; Exit; end;
PortWrite($0C,Adress+2);
end;

function TCameraHisis14.IsConnectedAndOK:Boolean;
var
   i:Integer;
begin
   Result:=True;
   PortWrite($81,Adress);                    // pr‚sentation de la commande
   // $81 est le code de la commande d'initialisation de la cam‚ra
   PortWrite($0C,Adress+2);                  // g‚n‚ration du front descendant
   PortWrite($0C,Adress+2);                  // sur la ligne ComValid
   PortWrite($0D,Adress+2);                  // ComValid = 0
   PortWrite($0D,Adress+2);                  // ComValid = 0
   i:=0;
   repeat
   Inc(i);
   until ((PortRead(Adress+1) and $40)=0) or (i>10000);     // attendre lecture commande
   if i>10000 then begin Result:=False; Exit; end;
   PortWrite($0C,Adress+2);                  // ComValid = 1
   WritePar(Adress,Ord('s'));
   // 's' est le code de la commande de synchronisation de l'obturateur
end;

function TCameraHisis14.Open:Boolean;
begin
// Rien a faire
Result:=True;
end;

procedure TCameraHisis14.Close;
begin
// Rien a faire
end;

function TCameraHisis14.StartPose:Boolean;
var
   i:Integer;
   TimeInit:TDateTime;
   DateTime2:TDateTime;
   Good:Boolean;
   LocalAdress:Word;
begin
   LocalAdress:=Adress;
   Result:=True;

   WriteSpy(lang('Acquisition14 : Acquisition en Binning ')+IntToStr(Binning)+'x'+IntToStr(Binning)
      +lang(' Tps de pose ')+FloatToStr(Pose));

   Sx:=(x2-x1+1) div Binning;
   Sy:=(y2-y1+1) div Binning;

   //InitPortParallele;
   PortWrite($ff,Adress);

   //WriteCapture
   PoseI:=Round(Pose*1000/3);
   PoseHi:=PoseI shr 16;
   PortWrite($81,Adress);    // présentation de la commande
                             // $81 est le code de la commande d'initialisation de la caméra
   PortWrite($0C,Adress+2);  // génération du front descendant
   PortWrite($0C,Adress+2);  // sur la ligne ComValid
   PortWrite($0D,Adress+2);  // ComValid = 0
   PortWrite($0D,Adress+2);  // ComValid = 0
   i:=0;
   Good:=True;
   repeat Inc(i) until ((PortRead(Adress+1) and $40)=0) or (i>10000);
   if i>10000 then begin Result:=False; Exit; end;
   // La camera se referme ici mais on peut pas l'enlever sinon ca merde
   PortWrite($0C,Adress+2);      // ComValid = 1
   //if Good and pop_camera.ObturateurOuvert then WritePar(Ord('o')); // pas utilise
//   if Good and IsDark then Good:=WritePar(Adress,Ord('c'));
   if Good and (ShutterState=ShutterIsAllwaysClosed) then Good:=WritePar(Adress,Ord('c'));
   if Good and (ShutterState=ShutterIsAllwaysOpen) then Good:=WritePar(Adress,Ord('o'));
   if Good and (ShutterState=ShutterISSynchro) then Good:=WritePar(Adress,Ord('s'));

   if Good then Good:=WritePar(Adress,$96); // $96 est le code de la commande de prise d'images
                                            // $4C est utilis‚ pour interrompre une pose *)
   if Good then Good:=WritePar(Adress,PoseHi);
   if Good then Good:=WritePar(Adress,Hi(PoseLo));
   if Good then Good:=WritePar(Adress,Lo(PoseLo));
   if Good then Good:=WritePar(Adress,Hi(x1));
   if Good then Good:=WritePar(Adress,Lo(x1));
   if Good then Good:=WritePar(Adress,Hi(y1));
   if Good then Good:=WritePar(Adress,Lo(y1));
   if Good then Good:=WritePar(Adress,Hi(x2));
   if Good then Good:=WritePar(Adress,Lo(x2));
   if Good then Good:=WritePar(Adress,Hi(y2));
   if Good then Good:=WritePar(Adress,Lo(y2));
   if Good then Good:=WritePar(Adress,(Binning shl 4)+Binning);
   if Good then Good:=WritePar(Adress,1); {sequence}
   // L'ordre de photographier est lance ici apres la sequence
   //WritePar(Ord('o'));

   if not(Good) then
      begin
      Result:=False;
      WriteSpy(lang('Acquisition14 : Communication avec la camera impossible'));
      Exit;
      end;

   asm
    push edx
    push eax

    mov  dx,LocalAdress
    inc  dx
    inc  dx
    mov  al,00000100b
    out  dx,al
    out  dx,al

    pop eax
    pop edx
   end;

   TimeInit:=Time;
   while Time<TimeInit+EmptyingDelay/60/60/24 do;

   DateTimeBegin:=GetHourDT;
end;

function TCameraHisis14.ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean;
var
   i,j,k:Integer;
   Pixel:Word;
   Line:array[1..768] of Word;
   LocalDelai:Integer;
   LocalAdress:Word;
begin
LocalDelai:=Round(ReadingDelay);
LocalAdress:=Adress;
Result:=True;
//FillChar(Line,SizeOf(Line),0);

{asm
 push edx
 push ecx
 push ebx
 push eax

 mov  dx,LocalAdress
 inc  dx

@loop1:
 in   al,dx
 mov  bl,al
 and  al,10h
 jnz  @loop1

 pop eax
 pop ebx
 pop ecx
 pop edx
end;}

DateTimeEnd:=GetHourDT;

if not OSIsNT then asm cli end;

for j:=1 to Sy do
 begin
 for i:=1 to Sx do
  begin

  asm
   push edx
   push ecx
   push ebx
   push eax

   mov  dx,LocalAdress
   inc  dx

@loop1:

    mov ecx,LocalDelai
@bl1:
   in   al,dx
   dec ecx
   jne @bl1

   mov  bl,al
   and  al,10h
   jnz  @loop1

   mov  cl,4
   shr  bl,cl

   inc  dx
   mov  al,00001100b
   out  dx,al

   dec  dx

    mov ecx,LocalDelai
@bl2:
   in   al,dx
   dec ecx
   jne @bl2

   and  al,0F0h
   add  bl,al

   inc  dx
   mov  al,00001000b
   out  dx,al
   dec  dx

   mov ecx,LocalDelai
@bl3:
   in   al,dx
   dec ecx
   jne @bl3

   and  al,0F0h
   mov  bh,al

   inc  dx
   mov  al,00000010b
   out  dx,al
   dec  dx

   mov ecx,LocalDelai
@bl4:
   in   al,dx
   dec ecx
   jne @bl4

   mov  cl,4
   shr  al,cl
   add  bh,al

   inc  dx
   mov  al,00000110b
   out  dx,al

   mov  cl,2
   shr  bx,cl
   xor  bx,2222h
   mov  Pixel,bx

   dec  dx

@loop2:

   mov ecx,LocalDelai
@bl5:
   in   al,dx
   dec ecx
   jne @bl5

   and  al,10h
   jz   @loop2

   inc  dx
   mov  al,00000100b
   out  dx,al

   pop eax
   pop ebx
   pop ecx
   pop edx
  end;

 Line[i]:=Pixel;
 end;
 for k:=1 to Sx do TabImgInt^[1]^[j]^[k]:=Line[k];
end;

if not OSIsNT then asm sti end;
end;

function TCameraHisis14.StopPose:Boolean;
begin
   WritePar(Adress,$4C);
   Result:=True;
end;

procedure TCameraHisis14.ShutterOpen;
var
   i:Integer;
begin
   PortWrite($81,Adress);                    // pr‚sentation de la commande
   // $81 est le code de la commande d'initialisation de la cam‚ra
   PortWrite($0C,Adress+2);                  // g‚n‚ration du front descendant
   PortWrite($0C,Adress+2);                  // sur la ligne ComValid
   PortWrite($0D,Adress+2);                  // ComValid = 0
   PortWrite($0D,Adress+2);                  // ComValid = 0
   i:=0;
   repeat
   Inc(i);
   until ((PortRead(Adress+1) and $40)=0) or (i>10000);     // attendre lecture commande
   if i>10000 then raise ErrorCameraHisis14.Create(lang('La caméra ne réponds pas'));
   PortWrite($0C,Adress+2);                  // ComValid = 1
   WritePar(Adress,Ord('o'));
   // 'o' est le code de la commande d'ouverture de l'obturateur
end;

procedure TCameraHisis14.ShutterClosed;
var
   i:Integer;
begin
   PortWrite($81,Adress);                    // pr‚sentation de la commande
   // $81 est le code de la commande d'initialisation de la cam‚ra
   PortWrite($0C,Adress+2);                  // g‚n‚ration du front descendant
   PortWrite($0C,Adress+2);                  // sur la ligne ComValid
   PortWrite($0D,Adress+2);                  // ComValid = 0
   PortWrite($0D,Adress+2);                  // ComValid = 0
   i:=0;
   repeat
   Inc(i);
   until ((PortRead(Adress+1) and $40)=0) or (i>10000);     // attendre lecture commande
   if i>10000 then raise ErrorCameraHisis14.Create(lang('La caméra ne réponds pas'));
   PortWrite($0C,Adress+2);                  // ComValid = 1
   WritePar(Adress,Ord('c'));
   // 'c' est le code de la commande de fermeture de l'obturateur
end;

procedure TCameraHisis14.ShutterSynchro;
var
   i:Integer;
begin
   PortWrite($81,Adress);                    // pr‚sentation de la commande
   // $81 est le code de la commande d'initialisation de la cam‚ra
   PortWrite($0C,Adress+2);                  // g‚n‚ration du front descendant
   PortWrite($0C,Adress+2);                  // sur la ligne ComValid
   PortWrite($0D,Adress+2);                  // ComValid = 0
   PortWrite($0D,Adress+2);                  // ComValid = 0
   i:=0;
   repeat
   Inc(i);
   until ((PortRead(Adress+1) and $40)=0) or (i>10000);     // attendre lecture commande
   if i>10000 then raise ErrorCameraHisis14.Create(lang('La caméra ne réponds pas'));
   PortWrite($0C,Adress+2);                  // ComValid = 1
   WritePar(Adress,Ord('s'));
   // 's' est le code de la commande de synchronisation de l'obturateur
end;

// Caracteristiques
function TCameraHisis14.GetName:PChar;
begin
Result:=PChar('Hisis22 14 bits'); //nolang
end;

function TCameraHisis14.GetSaturationLevel:Integer;
begin
Result:=16383;
end;

function TCameraHisis14.GetXSize:Integer;
begin
Result:=768;
end;

function TCameraHisis14.GetYSize:Integer;
begin
Result:=512;
end;

function TCameraHisis14.GetXPixelSize:Double;
begin
Result:=9;
end;

function TCameraHisis14.GetYPixelSize:Double;
begin
Result:=9;
end;

function TCameraHisis14.IsAValidBinning(Binning:Byte):Boolean;
begin
if (Binning=1) or (Binning=2) or (Binning=4) or (Binning=8) then Result:=True
else Result:=False
end;

function TCameraHisis14.HasTemperature:Boolean;
begin
Result:=False;
end;

function TCameraHisis14.CanCutAmpli:Boolean;
begin
Result:=False;
end;

function TCameraHisis14.NeedEmptyingDelay:Boolean;
begin
Result:=True;
end;

function TCameraHisis14.NeedReadingDelay:Boolean;
begin
Result:=True;
end;

function TCameraHisis14.NeedCloseShutterDelay:Boolean;
begin
Result:=False;
end;

function TCameraHisis14.HasAShutter:Boolean;
begin
Result:=True;
end;

procedure TCameraHisis14.GetCCDDateBegin(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure TCameraHisis14.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure TCameraHisis14.GetCCDDateEnd(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure TCameraHisis14.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

procedure TCameraHisis14.SetHourServer(ServerAdress:Pointer);
begin
HourServerAdress:=ServerAdress;
end;

procedure TCameraHisis14.SetPCMinusUT(PCMinusUT:Double);
begin
// Pas besoin en interne pour l'instant
end;

function TCameraHisis14.ShowCfgWindow:Boolean;
begin
Result:=True;
end;

function TCameraHisis14.IsTrackCCD:Boolean;
begin
Result:=False;
end;

function TCameraHisis14.NeedPixelSize:Boolean;
begin
Result:=False;
end;

function TCameraHisis14.Is16Bits:Boolean;
begin
Result:=False;
end;

function TCameraHisis14.HasCfgWindow:Boolean;
begin
Result:=False;
end;

//******************************************************************************
//**************************        Camera Hisis12        **********************
//******************************************************************************

constructor TCameraHisis12.Create;
begin
   inherited Create;
end;

function TCameraHisis12.WritePar(Adress:Word;Par:Byte):Boolean;
var
i:integer;
begin
Result:=True;
i:=0;
repeat inc(i) until ((PortRead(Adress+1) and $40)=$40) or (i>10000);
if i>10000 then begin Result:=False; Exit; end;
PortWrite(Par,Adress);
for i:=1 to 10000 do;
PortWrite($0D,Adress+2);
i:=0;
repeat inc(i) until ((PortRead(Adress+1) and $40)=0) or (i>10000);
if i>10000 then begin Result:=False; Exit; end;
PortWrite($0C,Adress+2);
end;

function TCameraHisis12.IsConnectedAndOK:Boolean;
begin
   // Comment faire ?
   Result:=True;
end;

function TCameraHisis12.Open:Boolean;
begin
// Rien a faire
Result:=True;
end;

procedure TCameraHisis12.Close;
begin
// Rien a faire
end;

function TCameraHisis12.StartPose:Boolean;
var
   i:Integer;
   TimeInit:TDateTime;
   DateTime2:TDateTime;
   Good:Boolean;
   LocalAdress:Word;
begin
   LocalAdress:=Adress;
   Result:=True;

   WriteSpy(lang('Acquisition12 : Acquisition en Binning ')+IntToStr(Binning)+'x'+IntToStr(Binning)
      +lang(' Tps de pose ')+FloatToStr(Pose));

   Sx:=(x2-x1+1) div Binning;
   Sy:=(y2-y1+1) div Binning;

   //InitPortParallele;
   PortWrite($ff,Adress);

   //WriteCapture
   PoseI:=Round(Pose*1000/3);
   PoseHi:=PoseI shr 16;
   PortWrite($81,Adress);    // présentation de la commande
                             // $81 est le code de la commande d'initialisation de la caméra
   PortWrite($0C,Adress+2);  // génération du front descendant
   PortWrite($0C,Adress+2);  // sur la ligne ComValid
   PortWrite($0D,Adress+2);  // ComValid = 0
   PortWrite($0D,Adress+2);  // ComValid = 0
   i:=0;
   Good:=True;
   repeat Inc(i) until ((PortRead(Adress+1) and $40)=0) or (i>10000);
   if i>10000 then begin Result:=False; Exit; end;
   // La camera se referme ici mais on peut pas l'enlever sinon ca merde
   PortWrite($0C,Adress+2);      // ComValid = 1
   //if Good and pop_camera.ObturateurOuvert then WritePar(Ord('o')); // pas utilise
//   if Good and IsDark then Good:=WritePar(Adress,Ord('c'));
   if Good then Good:=WritePar(Adress,$96); // $96 est le code de la commande de prise d'images
                                            // $4C est utilis‚ pour interrompre une pose *)
   if Good then Good:=WritePar(Adress,PoseHi);
   if Good then Good:=WritePar(Adress,Hi(PoseLo));
   if Good then Good:=WritePar(Adress,Lo(PoseLo));
   if Good then Good:=WritePar(Adress,Hi(x1));
   if Good then Good:=WritePar(Adress,Lo(x1));
   if Good then Good:=WritePar(Adress,Hi(y1));
   if Good then Good:=WritePar(Adress,Lo(y1));
   if Good then Good:=WritePar(Adress,Hi(x2));
   if Good then Good:=WritePar(Adress,Lo(x2));
   if Good then Good:=WritePar(Adress,Hi(y2));
   if Good then Good:=WritePar(Adress,Lo(y2));
   if Good then Good:=WritePar(Adress,(Binning shl 4)+Binning);
   if Good then Good:=WritePar(Adress,1); {sequence}
   // L'ordre de photographier est lance ici apres la sequence
   //WritePar(Ord('o'));

   if not(Good) then
      begin
      Result:=False;
      WriteSpy(lang('Acquisition14 : Communication avec la camera impossible'));
      Exit;
      end;

   asm
    push edx
    push eax

    mov  dx,LocalAdress
    inc  dx
    inc  dx
    mov  al,00001100b
    out  dx,al
    out  dx,al

    pop eax
    pop edx
   end;

   TimeInit:=Time;
   while Time<TimeInit+EmptyingDelay/60/60/24 do;

   DateTimeBegin:=GetHourDT;
end;

function TCameraHisis12.ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean;
var
   i,j,k:Integer;
   Pixel,CountPixel,CountLine:Word;
   Fin:Boolean;
   Synchro:Byte;
   Line:array[1..768] of Word;
   LocalDelai:Integer;
   LocalAdress:Word;
begin
LocalDelai:=Round(ReadingDelay);
LocalAdress:=Adress;
Result:=True;

CountLine:=0;
CountPixel:=0;
FillChar(Line,SizeOf(Line),0);

DateTimeEnd:=GetHourDT;

Fin:=False;
repeat
   asm
   push dx
   push bx
   push ax

   mov  dx,$378
   inc  dx
@loop1:

   mov ecx,LocalDelai
@bl1:
   in   al,dx
   dec ecx
   jne @bl1

   mov  bh,al
   and  al,80h
   jz   @loop1

   mov  al,bh
   and  al,40h
   mov  Synchro,al
   and  bh,30h

   inc  dx
   mov  al,00000100b
   out  dx,al

   dec  dx

   mov ecx,LocalDelai
@bl2:
   in   al,dx
   dec ecx
   jne @bl2

   mov  cl,4
   shr  al,cl
   add  bh,al

   inc  dx
   mov  al,00000000b
   out  dx,al
   dec  dx

   mov ecx,LocalDelai
@bl3:
   in   al,dx
   dec ecx
   jne @bl3

   mov  cl,4
   shr  al,cl
   mov  bl,al

   inc  dx
   mov  al,00001010b
   out  dx,al
   dec  dx

   mov ecx,LocalDelai
@bl4:
   in   al,dx
   dec ecx
   jne @bl4

   and  al,0F0h
   add  bl,al

   inc  dx
   mov  al,00001110b
   out  dx,al

   xor  bx,888h
   mov  Pixel,bx
   inc  CountPixel

   dec  dx

   mov ecx,LocalDelai
@bl5:
   in   al,dx
   dec ecx
   jne @bl5

@loop2:
   in   al,dx
   and  al,80h
   jnz  @loop2

   inc  dx
   mov  al,00001100b
   out  dx,al

   pop ax
   pop bx
   pop dx
   end;

 Line[CountPixel]:=Pixel;
 if CountPixel>=Sx then
    begin
    Inc(CountLine);
    for i:=1 to Sx do TabImgInt^[1]^[CountLine]^[i]:=Line[i];
    if CountLine>=Sy then
       begin
       Fin:=True;
       WriteSpy(lang('Acquisition12 : Acquisition réussie'));
       end;
    CountPixel:=0;
    end;
until Fin;

end;

function TCameraHisis12.StopPose:Boolean;
begin
   WritePar(Adress,$4C);
   Result:=True;
end;

// Caracteristiques
function TCameraHisis12.GetName:PChar;
begin
Result:=PChar('Hisis22 12 bits'); //nolang
end;

function TCameraHisis12.GetSaturationLevel:Integer;
begin
Result:=4096;
end;

function TCameraHisis12.GetXSize:Integer;
begin
Result:=768;
end;

function TCameraHisis12.GetYSize:Integer;
begin
Result:=512;
end;

function TCameraHisis12.GetXPixelSize:Double;
begin
Result:=9;
end;

function TCameraHisis12.GetYPixelSize:Double;
begin
Result:=9;
end;

function TCameraHisis12.IsAValidBinning(Binning:Byte):Boolean;
begin
if (Binning=1) or (Binning=2) or (Binning=4) or (Binning=8) then Result:=True
else Result:=False
end;

function TCameraHisis12.HasTemperature:Boolean;
begin
Result:=False;
end;

function TCameraHisis12.CanCutAmpli:Boolean;
begin
Result:=False;
end;

function TCameraHisis12.NeedEmptyingDelay:Boolean;
begin
Result:=True;
end;

function TCameraHisis12.NeedReadingDelay:Boolean;
begin
Result:=True;
end;

function TCameraHisis12.NeedCloseShutterDelay:Boolean;
begin
Result:=False;
end;

function TCameraHisis12.HasAShutter:Boolean;
begin
Result:=False;
end;

procedure TCameraHisis12.GetCCDDateBegin(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure TCameraHisis12.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure TCameraHisis12.GetCCDDateEnd(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure TCameraHisis12.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

procedure TCameraHisis12.SetHourServer(ServerAdress:Pointer);
begin
HourServerAdress:=ServerAdress;
end;

procedure TCameraHisis12.SetPCMinusUT(PCMinusUT:Double);
begin
// Pas besoin en interne pour l'instant
end;

function TCameraHisis12.ShowCfgWindow:Boolean;
begin
Result:=True;
end;

function TCameraHisis12.IsTrackCCD:Boolean;
begin
Result:=False;
end;

function TCameraHisis12.NeedPixelSize:Boolean;
begin
Result:=False;
end;

function TCameraHisis12.Is16Bits:Boolean;
begin
Result:=False;
end;

function TCameraHisis12.HasCfgWindow:Boolean;
begin
Result:=False;
end;

//******************************************************************************
//**************************          Camera ST7          **********************
//******************************************************************************

constructor TCameraST7.Create;
begin
   inherited Create;
   ShutterState:=ShutterIsSynchro;
end;

function TCameraST7.IsConnectedAndOK:Boolean;
var
   Name:string;
begin
Result:=True;
if OSIsNT then GetCameraNameSbigNT(Name) else GetCameraNameSbig(Name);
WriteSpy('ST7IsConnectedAndOK : '+Name); //Nolang
Result:=False;
if Copy(Name,1,4)='SBIG' then Result:=True; //nolang
end;

function TCameraST7.Open:Boolean;
var
   Error:Word;
   NoCamera:Word;
   NoPort:Byte;
begin
   Result:=True;
   if OSIsNT then
      begin
      Error:=OpenDriverSbigNT;
      if Error<>0 then
         begin
         WriteSpy('ST7OpenDriverSbigNT : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      if Config.AdresseCamera=$378 then NoPort:=1;
      if Config.AdresseCamera=$278 then NoPort:=2;
      if Config.AdresseCamera=$3BC then NoPort:=3;
      Error:=OpenDeviceSbigNT(NoPort);
      if Error<>0 then
         begin
         WriteSpy('ST7OpenDeviceSbigNT : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      Error:=EstablishLinkSbigNT(Adress,NoCamera);
      if Error<>0 then
        begin
        WriteSpy('ST7EstablishLinkSbigNT : '+GetErrorSbigNT(Error)); //nolang
        Result:=False;
        Exit;
        end;
      end
   else
      begin
      Error:=OpenDriverSbig;
      if Error<>0 then
         begin
         WriteSpy('ST7OpenDriverSbig : '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      Error:=EstablishLinkSbig(Adress,NoCamera);
      if Error<>0 then
         begin
         WriteSpy('ST7EstablishLinkSbig '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end;
end;

procedure TCameraST7.Close;
var
   Error:Word;
begin
   if OSIsNT then
      begin
      Error:=CloseDeviceSbigNT;
      if Error<>0 then WriteSpy('ST7CloseDevice : '+GetErrorSbigNT(Error)); //nolang
      Error:=CloseDriverSbigNT;
      if Error<>0 then WriteSpy('ST7CloseDriver : '+GetErrorSbigNT(Error)); //nolang
      end
   else
      begin
      Error:=CloseDriverSbig;
      if Error<>0 then WriteSpy('ST7CloseDriver : '+GetErrorSbig(Error)); //nolang
      end;
end;

function TCameraST7.StartPose:Boolean;
var
   PoseCamera:Integer;
   Error:Word;
begin
   Result:=True;

   Sx:=(x2-x1+1) div Binning;
   Sy:=(y2-y1+1) div Binning;

   PoseCamera:=Round(Pose*100);

   if OSIsNT then
      begin
      if ShutterState=ShutterIsAllwaysClosed then Error:=StartExposureSbigNT(2,PoseCamera);
      if ShutterState=ShutterIsSynchro then Error:=StartExposureSbigNT(1,PoseCamera);
      if Error<>0 then
         begin
         WriteSpy('StartST7Acquisition : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end
   else
      begin
      if ShutterState=ShutterIsAllwaysClosed then Error:=StartExposureSbig(2,PoseCamera);
      if ShutterState=ShutterIsSynchro then Error:=StartExposureSbig(1,PoseCamera);
      if Error<>0 then
         begin
         WriteSpy('StartST7Acquisition : '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end;

   DateTimeBegin:=GetHourDT;
end;

function TCameraST7.ReadCCD(var TabImgInt:PTabImgInt;ImgSx,ImgSy:Integer):Boolean;
var
   Lig:PLigWord;
   Error,Valeur:Word;
   i,j:Integer;
   ReadoutLineParams:TReadoutLineParams;
begin
   Getmem(Lig,768*2);

   try


   if OSIsNT then
      begin
      DateTimeEnd:=GetHourDT;
      EndExposureSbigNT;

      // Virer les premieres lignes
      DumpLineSbigNT(Binning-1,(Y1-1) div Binning);

      for j:=1 to ((Y2-Y1+1) div Binning) do
         begin
         ReadoutLineParams.Ccd:=0;
         ReadoutLineParams.ReadoutMode:=Binning-1;
         ReadoutLineParams.PixelStart:=X1 div Binning;
         ReadoutLineParams.PixelLength:=(X2-X1+1) div Binning;
         ParDeviceCommandNH(CC_READOUT_LINE,ReadoutLineParams,Lig^);

         for i:=1 to ((X2-X1+1) div Binning) do
            begin
            Valeur:=Lig^[i];
            if Valeur>32767 then TabImgInt^[1]^[j]^[i]:=32767 else TabImgInt^[1]^[j]^[i]:=Lig^[i];
            end;

         Application.ProcessMessages;
         end;

      EndReadoutSbigNT;
      end
   else
      begin
      DateTimeEnd:=GetHourDT;      
      EndExposureSbig;

      // Virer les premieres lignes
      DumpLineSbig(Binning-1,(Y1-1) div Binning);

      for j:=1 to ((Y2-Y1+1) div Binning) do
         begin
         ReadoutLineParams.Ccd:=0;
         ReadoutLineParams.ReadoutMode:=Binning-1;
         ReadoutLineParams.PixelStart:=X1 div Binning;
         ReadoutLineParams.PixelLength:=(X2-X1+1) div Binning;
         ParDrvCommand(CC_READOUT_LINE,ReadoutLineParams,Lig^);

         for i:=1 to ((X2-X1+1) div Binning) do
            begin
            Valeur:=Lig^[i];
            if Valeur>32767 then TabImgInt^[1]^[j]^[i]:=32767 else TabImgInt^[1]^[j]^[i]:=Lig^[i];
            end;

         Application.ProcessMessages;            
         end;

      EndReadoutSbig;
      end;

   finally
   Freemem(Lig,768*2);
   end;
end;

function TCameraST7.StopPose:Boolean;
var
   Error:Word;
begin
{   if OSIsNT then
      begin
      Error:=EndExposureSbigNT;
      if Error<>0 then
         begin
         WriteSpy('StopPoseST7 : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end
   else
      begin
      Error:=EndExposureSbig;
      if Error<>0 then
         begin
         WriteSpy('StopPoseST7 : '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end;}
end;

function TCameraST7.GetTemperature:Double;
var
   Error:Word;
   Temp:Double;
begin
   Result:=999;

   if OSIsNT then Error:=QueryTempStatusSbigNT(Temp) else Error:=QueryTempStatusSbig(Temp);
// Oula ! Ca rempli le spy.log avec ca ! J'enleve !
// if Error<>0 then WriteSpy('GetTemperatureST7 : '+GetErrorSbig(Error)) //nolang
// else WriteSpy(lang('GetTemperatureST7 : Température = ')+FloatToStr(Temp));

   if Error<>0 then raise ErrorCamera.Create(lang('Je ne peux pas lire la température de la caméra'))
   else Result:=Temp;
end;

procedure TCameraST7.SetTemperature(TargetTemperature:Double);
var
   Error:Word;
begin
   if OSIsNT then
      begin
      Error:=SetTempRegulOnSbigNT(TargetTemperature);
      if Error<>0 then WriteSpy('SetTemp : '+GetErrorSbigNT(Error)); //nolang
      end
   else
      begin
      Error:=SetTempRegulOnSbig(TargetTemperature);
      if Error<>0 then WriteSpy('SetTemp : '+GetErrorSbig(Error)); //nolang      
      end;
   if Error<>0 then raise ErrorCamera.Create(lang('Je ne peux pas envoyer la température de consigne à la caméra'));
end;

procedure TCameraST7.ShutterOpen;
begin
// Rien a faire ici
end;

procedure TCameraST7.ShutterClosed;
begin
// Rien a faire ici
end;

procedure TCameraST7.ShutterSynchro;
begin
// Rien a faire ici
end;

// Caracteristiques
function TCameraST7.GetName:PChar;
begin
Result:=PChar('ST7'); //nolang
end;

function TCameraST7.GetSaturationLevel:Integer;
begin
Result:=32767;
end;

function TCameraST7.GetXSize:Integer;
begin
Result:=768;
end;

function TCameraST7.GetYSize:Integer;
begin
Result:=512;
end;

function TCameraST7.GetXPixelSize:Double;
begin
Result:=9;
end;

function TCameraST7.GetYPixelSize:Double;
begin
Result:=9;
end;

function TCameraST7.IsAValidBinning(Binning:Byte):Boolean;
begin
if (Binning=1) or (Binning=2) or (Binning=3) then Result:=True
else Result:=False
end;

function TCameraST7.HasTemperature:Boolean;
begin
Result:=True;
end;

function TCameraST7.CanCutAmpli:Boolean;
begin
Result:=False;
end;

function TCameraST7.NeedEmptyingDelay:Boolean;
begin
Result:=False;
end;

function TCameraST7.NeedReadingDelay:Boolean;
begin
Result:=False;
end;

function TCameraST7.NeedCloseShutterDelay:Boolean;
begin
Result:=False;
end;

function TCameraST7.HasAShutter:Boolean;
begin
Result:=True;
end;

procedure TCameraST7.GetCCDDateBegin(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure TCameraST7.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure TCameraST7.GetCCDDateEnd(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure TCameraST7.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

procedure TCameraST7.SetHourServer(ServerAdress:Pointer);
begin
HourServerAdress:=ServerAdress;
end;

procedure TCameraST7.SetPCMinusUT(PCMinusUT:Double);
begin
// Pas besoin en interne pour l'instant
end;

function TCameraST7.ShowCfgWindow:Boolean;
begin
Result:=True;
end;

function TCameraST7.IsTrackCCD:Boolean;
begin
Result:=False;
end;

function TCameraST7.NeedPixelSize:Boolean;
begin
Result:=False;
end;

function TCameraST7.Is16Bits:Boolean;
begin
Result:=False;
end;

function TCameraST7.HasCfgWindow:Boolean;
begin
Result:=False;
end;


{constructor TCameraST7.Create;
begin
   inherited Create;
   ShutterState:=ShutterIsSynchro;
end;

function TCameraST7.IsConnectedAndOK:Boolean;
var
   Name:string;
begin
Result:=True;
GetCameraNameSbig(Name);
WriteSpy('ST7IsConnectedAndOK : '+Name); //Nolang
Result:=False;
if Copy(Name,1,4)='SBIG' then Result:=True; //nolang
end;

procedure TCameraST7.Open;
var
   Error,NoCamera:Word;
begin
   Error:=OpenDriverSbig;
   if Error<>0 then WriteSpy('ST7OpenDriver : '+GetErrorSbig(Error)); //nolang
   Error:=OpenDeviceSbig;
   if Error<>0 then WriteSpy('ST7OpenDevice : '+GetErrorSbig(Error)); //nolang
   Error:=EstablishLinkSbig(Adress,NoCamera);
   if Error<>0 then WriteSpy('ST7EstablishLink : '+GetErrorSbig(Error)); //nolang
end;

procedure TCameraST7.Close;
var
   Error:Word;
begin
   Error:=CloseDeviceSbig;
   if Error<>0 then WriteSpy('ST7CloseDevice : '+GetErrorSbig(Error)); //nolang
   Error:=CloseDriverSbig;
   if Error<>0 then WriteSpy('ST7CloseDriver : '+GetErrorSbig(Error)); //nolang
end;

function TCameraST7.StartPose:Boolean;
var
   PoseCamera:Integer;
   Error:Word;
begin
   Result:=True;

   Sx:=(x2-x1+1) div Binning;
   Sy:=(y2-y1+1) div Binning;

   PoseCamera:=Round(Pose*100);

   if ShutterState=ShutterIsAllwaysClosed then Error:=StartExposureSbig(2,PoseCamera);
   if ShutterState=ShutterIsSynchro then Error:=StartExposureSbig(1,PoseCamera);

   if Error<>0 then
      begin
      WriteSpy('StartST7Acquisition : '+GetErrorSbig(Error)); //nolang
      Result:=False;
      Exit;
      end;

   DateTimeBegin:=GetHourDT;
end;

function TCameraST7.ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean;
var
   Lig:PLigWord;
   Error,Valeur:Word;
   i,j:Integer;
   ReadoutLineParams:TReadoutLineParams;
begin
   Getmem(Lig,768*2);

   try


   EndExposureSbig;

   // Virer les premieres lignes
   DumpLineSbig(Binning-1,(Y1-1) div Binning);

   for j:=1 to ((Y2-Y1+1) div Binning) do
      begin
      ReadoutLineParams.Ccd:=0;
      ReadoutLineParams.ReadoutMode:=Binning-1;
      ReadoutLineParams.PixelStart:=X1 div Binning;
      ReadoutLineParams.PixelLength:=(X2-X1+1) div Binning;
      ParDrvCommand(CC_READOUT_LINE,ReadoutLineParams,Lig^);

      for i:=1 to ((X2-X1+1) div Binning) do
         begin
         Valeur:=Lig^[i];
         if Valeur>32767 then TabImgInt^[1]^[j]^[i]:=32767 else TabImgInt^[1]^[j]^[i]:=Lig^[i];
         end;
      end;

   EndReadoutSbig;

   DateTimeEnd:=GetHourDT;

   finally
   Freemem(Lig,768*2);
   end;
end;

function TCameraST7.StopPose:Boolean;
var
   Error:Word;
begin
   Error:=EndExposureSbig;
   if Error<>0 then
      begin
      WriteSpy('StopPoseST7 : '+GetErrorSbig(Error)); //nolang
      Result:=False;
      Exit;
      end;
end;

function TCameraST7.GetTemperature:Double;
var
   Error:Word;
   Temp:Double;
begin
   Result:=999;

   Error:=QueryTempStatusSbig(Temp);
// Oula ! Ca rempli le spy.log avec ca ! J'enleve !
// if Error<>0 then WriteSpy('GetTemperatureST7 : '+GetErrorSbig(Error)) //nolang
// else WriteSpy(lang('GetTemperatureST7 : Température = ')+FloatToStr(Temp));

   if Error<>0 then raise ErrorCamera.Create(lang('Je ne peux pas lire la température de la caméra'))
   else Result:=Temp;
end;

procedure TCameraST7.SetTemperature(TargetTemperature:Double);
var
   Error:Word;
begin
   Error:=SetTempRegulOnSbig(TargetTemperature);
   if Error<>0 then WriteSpy('SetTemp : '+GetErrorSbig(Error)); //nolang
   if Error<>0 then raise ErrorCamera.Create(lang('Je ne peux pas envoyer la température de consigne à la caméra'));
end;

procedure TCameraST7.ShutterOpen;
begin
// Rien a faire ici
end;

procedure TCameraST7.ShutterClosed;
begin
// Rien a faire ici
end;

procedure TCameraST7.ShutterSynchro;
begin
// Rien a faire ici
end;

// Caracteristiques
function TCameraST7.GetName:PChar;
begin
Result:=PChar('ST7'); //nolang
end;

function TCameraST7.GetSaturationLevel:Integer;
begin
Result:=32767;
end;

function TCameraST7.GetXSize:Integer;
begin
Result:=768;
end;

function TCameraST7.GetYSize:Integer;
begin
Result:=512;
end;

function TCameraST7.GetXPixelSize:Double;
begin
Result:=9;
end;

function TCameraST7.GetYPixelSize:Double;
begin
Result:=9;
end;

function TCameraST7.IsAValidBinning(Binning:Byte):Boolean;
begin
if (Binning=1) or (Binning=2) or (Binning=3) then Result:=True
else Result:=False
end;

function TCameraST7.HasTemperature:Boolean;
begin
Result:=True;
end;

function TCameraST7.CanCutAmpli:Boolean;
begin
Result:=False;
end;

function TCameraST7.NeedEmptyingDelay:Boolean;
begin
Result:=False;
end;

function TCameraST7.NeedReadingDelay:Boolean;
begin
Result:=False;
end;

function TCameraST7.NeedCloseShutterDelay:Boolean;
begin
Result:=False;
end;

function TCameraST7.HasAShutter:Boolean;
begin
Result:=True;
end;

procedure TCameraST7.GetCCDDateBegin(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure TCameraST7.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure TCameraST7.GetCCDDateEnd(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure TCameraST7.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

procedure TCameraST7.SetHourServer(ServerAdress:Pointer);
begin
HourServerAdress:=ServerAdress;
end;

procedure TCameraST7.SetPCMinusUT(PCMinusUT:Double);
begin
// Pas besoin en interne pour l'instant
end;

function TCameraST7.IsTrackCCD:Boolean;
begin
Result:=False;
end;}

//******************************************************************************
//**************************       Camera ST7 guidage       **********************
//******************************************************************************

constructor TCameraSTTrack.Create;
begin
   inherited Create;
   ShutterState:=ShutterIsSynchro;
end;

function TCameraSTTrack.IsConnectedAndOK:Boolean;
var
   Name:String;
begin
   Result:=True;
   if OSIsNT then GetCameraNameSbigNT(Name) else GetCameraNameSbig(Name);
   WriteSpy('STTrackIsConnectedAndOK : '+Name); //Nolang
   Result:=False;
   if Copy(Name,1,4)='SBIG' then Result:=True; //nolang
end;

function TCameraSTTrack.Open:Boolean;
var
   Error,NoCamera:Word;
   NoPort:Byte;
begin
   Result:=True;
// Rien ici car c'est déjà fait pour la camera principale
// Et si on n'utilise que le capteur de guidage ?
   if OSIsNT then
      begin
      Error:=OpenDriverSbigNT;
      if Error<>0 then
         begin
         WriteSpy('STTrackOpenDriverSbigNT : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      if Config.AdresseCamera=$378 then NoPort:=1;
      if Config.AdresseCamera=$278 then NoPort:=2;
      if Config.AdresseCamera=$3BC then NoPort:=3;
      Error:=OpenDeviceSbigNT(NoPort);
      if Error<>0 then
         begin
         WriteSpy('STTrackOpenDeviceSbigNT '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      Error:=EstablishLinkSbigNT(Adress,NoCamera);
      if Error<>0 then
         begin
         WriteSpy('STTrackEstablishLinkSbigNT '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end
   else
      begin
      Error:=OpenDriverSbig;
      if Error<>0 then
         begin
         WriteSpy('STTrackOpenDriverSbig : '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      Error:=EstablishLinkSbig(Adress,NoCamera);
      if Error<>0 then
         begin
         WriteSpy('STTrackEstablishLinkSbig '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end
end;

procedure TCameraSTTrack.Close;
var
   Error:Word;
begin
// Rien ici car c'est déjà fait pour la camera principale
// Et si on n'utilise que le capteur de guidage ?
   if OSIsNT then
      begin
      Error:=CloseDriverSbigNT;
      if Error<>0 then WriteSpy('STTrackCloseDriverSbigNT : '+GetErrorSbigNT(Error)); //nolang
      end
   else
      begin
      Error:=CloseDriverSbig;
      if Error<>0 then WriteSpy('STTrackCloseDriverSbig : '+GetErrorSbig(Error)); //nolang
      end
end;

function TCameraSTTrack.StartPose:Boolean;
var
   PoseCamera:Integer;
   Error:Word;
begin
   Result:=True;

   Sx:=(x2-x1+1) div Binning;
   Sy:=(y2-y1+1) div Binning;

   PoseCamera:=Round(Pose*100);

   if OSIsNT then
      begin
      if ShutterState=ShutterIsAllwaysClosed then Error:=StartExposureTrackSbigNT(2,PoseCamera);
      if ShutterState=ShutterIsSynchro then Error:=StartExposureTrackSbigNT(1,PoseCamera);
      if Error<>0 then
         begin
         WriteSpy('StartST7Acquisition : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end
   else
      begin
      if ShutterState=ShutterIsAllwaysClosed then Error:=StartExposureTrackSbig(2,PoseCamera);
      if ShutterState=ShutterIsSynchro then Error:=StartExposureTrackSbig(1,PoseCamera);
      if Error<>0 then
         begin
         WriteSpy('StartST7Acquisition : '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end;

   DateTimeBegin:=GetHourDT;
end;

function TCameraSTTrack.ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean;
var
   Lig:PLigWord;
   Error:Word;
   i,j:Integer;
   ReadoutLineParams:TReadoutLineParams;
begin
   New(Lig);
   //Getmem(Lig,192*2);

   try

   if OSIsNT then
      begin
      EndExposureTrackSbigNT;

      DateTimeEnd:=GetHourDT;

      // Virer les premieres lignes
      DumpLineTrackSbigNT(Binning-1,(Y1-1) div Binning);

      for j:=1 to ((Y2-Y1+1) div Binning) do
         begin
         ReadoutLineParams.Ccd:=1;
         ReadoutLineParams.ReadoutMode:=Binning-1;
         ReadoutLineParams.PixelStart:=X1 div Binning;
         ReadoutLineParams.PixelLength:=(X2-X1+1) div Binning;
         ParDeviceCommandNH(CC_READOUT_LINE,ReadoutLineParams,Lig^);

         for i:=1 to ((X2-X1+1) div Binning) do
            begin
            Application.ProcessMessages;
            if Lig^[i]>32767 then Lig^[i]:=32767;
            TabImgInt^[1]^[j]^[i]:=Lig^[i];
            end;
         end;
      EndReadoutTrackSbigNT;         
      end
   else
      begin
      EndExposureTrackSbig;

      DateTimeEnd:=GetHourDT;

      // Virer les premieres lignes
      DumpLineTrackSbig(Binning-1,(Y1-1) div Binning);

      for j:=1 to ((Y2-Y1+1) div Binning) do
         begin
         ReadoutLineParams.Ccd:=1;
         ReadoutLineParams.ReadoutMode:=Binning-1;
         ReadoutLineParams.PixelStart:=X1 div Binning;
         ReadoutLineParams.PixelLength:=(X2-X1+1) div Binning;
         ParDrvCommand(CC_READOUT_LINE,ReadoutLineParams,Lig^);

         for i:=1 to ((X2-X1+1) div Binning) do
            begin
            Application.ProcessMessages;
            if Lig^[i]>32767 then Lig^[i]:=32767;
            TabImgInt^[1]^[j]^[i]:=Lig^[i];
            end;
         end;

      EndReadoutTrackSbig;
      end;

   finally
   Dispose(Lig);
   //Freemem(Lig,192*2);
   end;
end;

function TCameraSTTrack.StopPose:Boolean;
var
   Error:Word;
begin
   if OSIsNT then
      begin
      Error:=EndExposureTrackSbigNT;
      if Error<>0 then
         begin
         WriteSpy('StopPoseST7Track : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end
   else
      begin
      Error:=EndExposureTrackSbig;
      if Error<>0 then
         begin
         WriteSpy('StopPoseST7Track : '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end;
end;

procedure TCameraSTTrack.ShutterOpen;
begin
// Rien a faire ici
end;

procedure TCameraSTTrack.ShutterClosed;
begin
// Rien a faire ici
end;

procedure TCameraSTTrack.ShutterSynchro;
begin
// Rien a faire ici
end;

// Caracteristiques
function TCameraSTTrack.GetName:PChar;
begin
Result:=PChar('ST7Track'); //nolang
end;

function TCameraSTTrack.GetSaturationLevel:Integer;
begin
Result:=32767; // TODO : a vérifier
end;

function TCameraSTTrack.GetXSize:Integer;
begin
Result:=192;
end;

function TCameraSTTrack.GetYSize:Integer;
begin
Result:=164;
end;

function TCameraSTTrack.GetXPixelSize:Double;
begin
//13.75x16
Result:=13.75;
end;

function TCameraSTTrack.GetYPixelSize:Double;
begin
//13.75x16
Result:=16;
end;

function TCameraSTTrack.IsAValidBinning(Binning:Byte):Boolean;
begin
if (Binning=1) or (Binning=2) then Result:=True
else Result:=False
end;

function TCameraSTTrack.HasTemperature:Boolean;
begin
Result:=False;
end;

function TCameraSTTrack.CanCutAmpli:Boolean;
begin
Result:=False;
end;

function TCameraSTTrack.NeedEmptyingDelay:Boolean;
begin
Result:=False;
end;

function TCameraSTTrack.NeedReadingDelay:Boolean;
begin
Result:=False;
end;

function TCameraSTTrack.NeedCloseShutterDelay:Boolean;
begin
Result:=False;
end;

function TCameraSTTrack.HasAShutter:Boolean;
begin
// Pour la prise du noir !
Result:=True;
end;

procedure TCameraSTTrack.GetCCDDateBegin(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure TCameraSTTrack.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure TCameraSTTrack.GetCCDDateEnd(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure TCameraSTTrack.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

procedure TCameraSTTrack.SetHourServer(ServerAdress:Pointer);
begin
HourServerAdress:=ServerAdress;
end;

procedure TCameraSTTrack.SetPCMinusUT(PCMinusUT:Double);
begin
// Pas besoin en interne pour l'instant
end;

function TCameraSTTrack.ShowCfgWindow:Boolean;
begin
Result:=True;
end;

function TCameraSTTrack.IsTrackCCD:Boolean;
begin
Result:=True;
end;

function TCameraSTTrack.NeedPixelSize:Boolean;
begin
Result:=False;
end;

function TCameraSTTrack.Is16Bits:Boolean;
begin
Result:=False;
end;

function TCameraSTTrack.HasCfgWindow:Boolean;
begin
Result:=False;
end;


//******************************************************************************
//**************************          Camera ST8          **********************
//******************************************************************************

constructor TCameraST8.Create;
begin
   inherited Create;
   ShutterState:=ShutterIsSynchro;
end;

function TCameraST8.IsConnectedAndOK:Boolean;
var
   Name:string;
begin
   Result:=True;
   if OSIsNT then GetCameraNameSbigNT(Name) else GetCameraNameSbig(Name);
   WriteSpy('ST8IsConnectedAndOK : '+Name); //Nolang
   Result:=False;
   if Copy(Name,1,4)='SBIG' then Result:=True; //nolang
end;

function TCameraST8.Open:Boolean;
var
   Error,NoCamera:Word;
   NoPort:Byte;
begin
   if OSIsNT then
      begin
      Error:=OpenDriverSbigNT;
      if Error<>0 then
         begin
         WriteSpy('ST8OpenDriverSbigNT '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      if Config.AdresseCamera=$378 then NoPort:=1;
      if Config.AdresseCamera=$278 then NoPort:=2;
      if Config.AdresseCamera=$3BC then NoPort:=3;
      Error:=OpenDeviceSbigNT(NoPort);
      if Error<>0 then
         begin
         WriteSpy('ST7OpenDeviceSbigNT : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      Error:=EstablishLinkSbigNT(Adress,NoCamera);
      if Error<>0 then
         begin
         WriteSpy('ST8EstablishLinkSbigNT '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end
   else
      begin
      Error:=OpenDriverSbig;
      if Error<>0 then
         begin
         WriteSpy('ST8OpenDriverSbig '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      Error:=EstablishLinkSbig(Adress,NoCamera);
      if Error<>0 then
         begin
         WriteSpy('ST8OpenEstablishLinkSbig '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end;
end;

procedure TCameraST8.Close;
var
   Error:Word;
begin
   if OSIsNT then
      begin
      Error:=CloseDriverSbigNT;
      if Error<>0 then WriteSpy('MainFormClose : '+GetErrorSbigNT(Error)); //nolang
      end
   else
      begin
      Error:=CloseDriverSbig;
      if Error<>0 then WriteSpy('MainFormClose : '+GetErrorSbig(Error)); //nolang
      end;
end;

function TCameraST8.StartPose:Boolean;
var
   PoseCamera:Integer;
   Error:Word;
begin
   Result:=True;

   Sx:=(x2-x1+1) div Binning;
   Sy:=(y2-y1+1) div Binning;

   PoseCamera:=Round(Pose*100);

   if OSIsNT then
      begin
      if ShutterState=ShutterIsAllwaysClosed then Error:=StartExposureSbigNT(2,PoseCamera);
      if ShutterState=ShutterIsSynchro then Error:=StartExposureSbigNT(1,PoseCamera);
      if Error<>0 then
         begin
         WriteSpy('StartST8Acquisition : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end
   else
      begin
      if ShutterState=ShutterIsAllwaysClosed then Error:=StartExposureSbig(2,PoseCamera);
      if ShutterState=ShutterIsSynchro then Error:=StartExposureSbig(1,PoseCamera);
      if Error<>0 then
         begin
         WriteSpy('StartST8Acquisition : '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end;

   DateTimeBegin:=GetHourDT;
end;

function TCameraST8.ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean;
var
   Lig:PLigWord;
   Error,Valeur:Word;
   i,j:Integer;
   ReadoutLineParams:TReadoutLineParams;
begin
   Getmem(Lig,1536*2);

   try

   if OSIsNT then
      begin
      DateTimeEnd:=GetHourDT;      
      EndExposureSbigNT;

      // Virer les premieres lignes
      DumpLineSbigNT(Binning-1,(Y1-1) div Binning);

      for j:=1 to ((Y2-Y1+1) div Binning) do
         begin
         ReadoutLineParams.Ccd:=0;
         ReadoutLineParams.ReadoutMode:=Binning-1;
         ReadoutLineParams.PixelStart:=X1 div Binning;
         ReadoutLineParams.PixelLength:=(X2-X1+1) div Binning;
         ParDeviceCommandNH(CC_READOUT_LINE,ReadoutLineParams,Lig^);

         for i:=1 to ((X2-X1+1) div Binning) do
            begin
            Valeur:=Lig^[i];
            if Valeur>32767 then TabImgInt^[1]^[j]^[i]:=32767 else TabImgInt^[1]^[j]^[i]:=Lig^[i];
            end;
         end;

      EndReadoutSbigNT;
      end
   else
      begin
      DateTimeEnd:=GetHourDT;      
      EndExposureSbig;

      // Virer les premieres lignes
      DumpLineSbig(Binning-1,(Y1-1) div Binning);

      for j:=1 to ((Y2-Y1+1) div Binning) do
         begin
         ReadoutLineParams.Ccd:=0;
         ReadoutLineParams.ReadoutMode:=Binning-1;
         ReadoutLineParams.PixelStart:=X1 div Binning;
         ReadoutLineParams.PixelLength:=(X2-X1+1) div Binning;
         ParDrvCommand(CC_READOUT_LINE,ReadoutLineParams,Lig^);

         for i:=1 to ((X2-X1+1) div Binning) do
            begin
            Valeur:=Lig^[i];
            if Valeur>32767 then TabImgInt^[1]^[j]^[i]:=32767 else TabImgInt^[1]^[j]^[i]:=Lig^[i];
            end;
         end;

      EndReadoutSbig;
      end;

   finally
   Freemem(Lig,1536*2);
   end;
end;

function TCameraST8.StopPose:Boolean;
var
   Error:Word;
begin
{   if OSIsNT then
      begin
      Error:=EndExposureSbigNT;
      if Error<>0 then
         begin
         WriteSpy('StopPoseST8 : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end
   else
      begin
      Error:=EndExposureSbig;
      if Error<>0 then
         begin
         WriteSpy('StopPoseST8 : '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end}
end;

function TCameraST8.GetTemperature:Double;
var
   Error:Word;
   Temp:Double;
begin
   Result:=999;

   if OSIsNT then Error:=QueryTempStatusSbigNT(Temp) else Error:=QueryTempStatusSbig(Temp);
//   if Error<>0 then WriteSpy('GetTemperatureST8 : '+GetErrorSbig(Error)) //nolang
//   else WriteSpy(lang('GetTemperatureST8 : Température = ')+FloatToStr(Temp));

   if Error<>0 then raise ErrorCamera.Create(lang('Je ne peux pas lire la température de la caméra'))
   else Result:=Temp;
end;

procedure TCameraST8.SetTemperature(TargetTemperature:Double);
var
   Error:Word;
begin
   if OSIsNT then Error:=SetTempRegulOnSbigNT(TargetTemperature) else Error:=SetTempRegulOnSbig(TargetTemperature);
   if Error<>0 then WriteSpy('SetTemp : '+GetErrorSbig(Error)); //nolang

   if Error<>0 then raise ErrorCamera.Create(lang('Je ne peux pas envoyer la température de consigne à la caméra'));
end;

procedure TCameraST8.ShutterOpen;
begin
// Rien a faire ici
end;

procedure TCameraST8.ShutterClosed;
begin
// Rien a faire ici
end;

procedure TCameraST8.ShutterSynchro;
begin
// Rien a faire ici
end;

// Caracteristiques
function TCameraST8.GetName:PChar;
begin
Result:=PChar('ST8'); //nolang
end;

function TCameraST8.GetSaturationLevel:Integer;
begin
Result:=32767;
end;

function TCameraST8.GetXSize:Integer;
begin
Result:=1536;
end;

function TCameraST8.GetYSize:Integer;
begin
Result:=1024;
end;

function TCameraST8.GetXPixelSize:Double;
begin
Result:=9;
end;

function TCameraST8.GetYPixelSize:Double;
begin
Result:=9;
end;

function TCameraST8.IsAValidBinning(Binning:Byte):Boolean;
begin
if (Binning=1) or (Binning=2) or (Binning=3) then Result:=True
else Result:=False
end;

function TCameraST8.HasTemperature:Boolean;
begin
Result:=True;
end;

function TCameraST8.CanCutAmpli:Boolean;
begin
Result:=False;
end;

function TCameraST8.NeedEmptyingDelay:Boolean;
begin
Result:=False;
end;

function TCameraST8.NeedReadingDelay:Boolean;
begin
Result:=False;
end;

function TCameraST8.NeedCloseShutterDelay:Boolean;
begin
Result:=False;
end;

function TCameraST8.HasAShutter:Boolean;
begin
Result:=True;
end;

procedure TCameraST8.GetCCDDateBegin(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure TCameraST8.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure TCameraST8.GetCCDDateEnd(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure TCameraST8.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

procedure TCameraST8.SetHourServer(ServerAdress:Pointer);
begin
HourServerAdress:=ServerAdress;
end;

procedure TCameraST8.SetPCMinusUT(PCMinusUT:Double);
begin
// Pas besoin en interne pour l'instant
end;

function TCameraST8.ShowCfgWindow:Boolean;
begin
Result:=True;
end;

function TCameraST8.IsTrackCCD:Boolean;
begin
Result:=False;
end;

function TCameraST8.NeedPixelSize:Boolean;
begin
Result:=False;
end;

function TCameraST8.Is16Bits:Boolean;
begin
Result:=False;
end;

function TCameraST8.HasCfgWindow:Boolean;
begin
Result:=False;
end;

//******************************************************************************
//**************************    Camera Audine400 sans obtu   *******************
//******************************************************************************

function TCameraAudine400.StartPose:Boolean;
var
   i:Integer;
   temp:tdatetime;
   PoseCamera:Integer;
begin
   Result:=True;

   Sx:=(x2-x1+1) div Binning;
   Sy:=(y2-y1+1) div Binning;

   PoseCamera:=Round(Pose*1000);

   // coupe ampli pose > 4s
   if (getamplistate and ampliisused and (Pose > GetDelayToSwitchOffAmpli)) then
      begin
      setamplistatefalse;
      AmpliOff;
      end;

   // vidage matrice
   for i:=1 to 5 do Audine_fast_vidage;

   DateTimeBegin:=GetHourDT;
end;

procedure TCameraAudine400.Audine_read_pel_fast;
var
   LocalAdress:Word;
begin
LocalAdress:=Adress;
asm
   mov  dx,LocalAdress
   mov  al,$F7
   out  dx,al
   mov  al,$FF
   out  dx,al
   mov  al,$FB
   out  dx,al
end;
end;


procedure TCameraAudine400.Audine_zi_zh;
var
   LocalAdress:Word;
begin
     LocalAdress:=Adress;
     asm
      mov dx,LocalAdress
      mov al,$FB
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FA
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$F9
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FA
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FB
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      end;
end;

procedure TCameraAudine400.Audine_fast_line;
var
i:integer;
begin
     for i:=0 to 793 do
     begin
          audine_read_pel_fast;
     end;
end;

procedure TCameraAudine400.Audine_fast_vidage;
var
i,j,k:integer;
{/*---- LECTURE DU REGISTRE HORIZONTAL ----*/}
begin
    for i:=1 to 129 do
    begin
       for j:=0 to 3 do audine_zi_zh;
       for k:=1 to 793 do audine_read_pel_fast;
    end;
end;

constructor TCameraAudine400.Create;
begin
   inherited Create;
end;

function TCameraAudine400.IsConnectedAndOK:Boolean;
begin
// Quoi mettre ici ?
Result:=True;
end;

function TCameraAudine400.Open:Boolean;
begin
AmpliOn;
Result:=True;
end;

procedure TCameraAudine400.Close;
begin
// Rien a faire ici
end;


function TCameraAudine400.ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean;
var
   x,a1,a2,a3,a4:integer ;
   i,j,k,toto,z:integer;
   ligne:array [1..2000] of word;
begin
   DateTimeEnd:=GetHourDT;
   
   result:=true; // Par defaut, pas d'erreur
   // On rallume l'ampli
{   if UseAmpli then
        AmpliOn;}
   {/**** on retire les 4 premières lignes ****/ }
   for i:=0 to 3 do audine_zi_zh;
   audine_fast_line;
   for i:=1 to ((y1-1) div 4) do
   begin
        for j:=0 to 3 do audine_zi_zh;
        audine_fast_line;
   end;
   for j:=1 to((y1-1) mod 4) do audine_zi_zh;
   audine_fast_line;

   for i:=1 to (y2-y1+1) div binning do
   begin
      if not OSIsNT then asm cli end;
      audine_fast_line;
      {2 fois en b2, 3 en b3...}
      for k:=1 to binning do audine_zi_zh;
      {/**** on retire les 14 premiers pixels ****/ }
      for k:=1 to (14+x1-1) do audine_read_pel_fast; //0 to 13 do audine_read_pel_fast(Port);
      for j:=1 to (x2-x1+1) div binning do
      begin
         // reset
         portwrite(247,Adress);
         // palier de reference
         for toto:=1 to 5 do portwrite(255,Adress);
         // clamp
         portwrite(239,Adress);
         {on ne lit que les n pixels}
         for toto:=1 to binning do begin portwrite(255,Adress); portwrite(251,Adress); end;
         for toto:=1 to 4 do portwrite(251,Adress);
         for toto:=1 to 6 do portwrite(219,Adress);
         {numerisation}
         a1:=integer(portread(Adress+1)) shr 4;
         portwrite(91,Adress);
         a2:=integer(portread(Adress+1)) shr 4;
         portwrite(155,Adress);
         a3:=integer(portread(Adress+1)) shr 4;
         portwrite(27,Adress);
         a4:=integer(portread(Adress+1)) shr 4;

         x:=(a1+(a2 shl 4)+(a3 shl 8)+(a4 shl 12)) Xor $8888;  // pourquoi 34952 au fait ?
         if (x>32767) then x:=32767;
         // cast
         ligne[j]:=word(x);
      end;
      // on met dans DataInt
      for j:=1 to ((x2-x1+1) div binning) do
      begin
          if Ligne[j] >32767 then TabImgInt^[1]^[i]^[j]:=32767 else TabImgInt^[1]^[i]^[j]:=ligne[j];
      end;
      {/**** on retire 10 pixels à la fin ****/ }
      //for z:=1 to 20+x1-x0 do audine_read_pel_fast(Port);
      for z:=1 to 10 do audine_read_pel_fast;
   end;

//   result:=true; //et si il y a eu une erreur ?
   if not OSIsNT then asm sti end;
end;

function TCameraAudine400.GetDelayToSwitchOffAmpli:Double;
begin
Result:=4;
end;

function TCameraAudine400.GetDelayToSwitchOnAmpli:Double;
begin
Result:=1;
end;

function TCameraAudine400.StopPose:Boolean;
begin

end;

// Met à zéro du bit 0 du port de controle
// eteint l ampli
procedure TCameraAudine400.AmpliOff;
begin
   portwrite((portread(Adress+2) or $01) xor $04, Adress+2);
end;

// Met à un du bit 0 du port de controle
procedure TCameraAudine400.AmpliOn;
begin
    portwrite((portread(Adress+2) and $FE) xor $04, Adress+2);
end;

//function TCameraAudine400.AmpliIsUsed:Boolean;
//begin
//Result:=UseAmpli;
//end;

// Caracteristiques
function TCameraAudine400.GetName:PChar;
begin
Result:=PChar('Audine 400'); //nolang
end;

function TCameraAudine400.GetSaturationLevel:Integer;
begin
Result:=16383; // TODO : a verifier
end;

function TCameraAudine400.GetXSize:Integer;
begin
Result:=768;
end;

function TCameraAudine400.GetYSize:Integer;
begin
Result:=512;
end;

function TCameraAudine400.GetXPixelSize:Double;
begin
Result:=9;
end;

function TCameraAudine400.GetYPixelSize:Double;
begin
Result:=9;
end;

function TCameraAudine400.IsAValidBinning(Binning:Byte):Boolean;
begin
if (Binning=1) or (Binning=2) or (Binning=3) or (Binning=4) then Result:=True
else Result:=False
end;

function TCameraAudine400.HasTemperature:Boolean;
begin
Result:=False;
end;

function TCameraAudine400.CanCutAmpli:Boolean;
begin
Result:=True;
end;

function TCameraAudine400.NeedEmptyingDelay:Boolean;
begin
Result:=False;
end;

function TCameraAudine400.NeedReadingDelay:Boolean;
begin
Result:=False;
end;

function TCameraAudine400.NeedCloseShutterDelay:Boolean;
begin
Result:=False;
end;

function TCameraAudine400.HasAShutter:Boolean;
begin
Result:=False; // TODO : a verifier que c'est possible
end;

procedure TCameraAudine400.GetCCDDateBegin(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure TCameraAudine400.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure TCameraAudine400.GetCCDDateEnd(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure TCameraAudine400.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

procedure TCameraAudine400.SetHourServer(ServerAdress:Pointer);
begin
HourServerAdress:=ServerAdress;
end;

procedure TCameraAudine400.SetPCMinusUT(PCMinusUT:Double);
begin
// Pas besoin en interne pour l'instant
end;

function TCameraAudine400.ShowCfgWindow:Boolean;
begin
Result:=True;
end;

function TCameraAudine400.IsTrackCCD:Boolean;
begin
Result:=False;
end;

function TCameraAudine400.NeedPixelSize:Boolean;
begin
Result:=False;
end;

function TCameraAudine400.Is16Bits:Boolean;
begin
Result:=False;
end;

function TCameraAudine400.HasCfgWindow:Boolean;
begin
Result:=False;
end;

//******************************************************************************
//**************************    Camera Audine400 avec obtu   **********************
//******************************************************************************

procedure TCameraAudineObtu400.Audine_read_pel_fast;
var
   LocalAdress:Word;
begin
LocalAdress:=Adress;
asm
   mov  dx,LocalAdress
   mov  al,$F7
   out  dx,al
   mov  al,$FF
   out  dx,al
   mov  al,$FB
   out  dx,al
end;
end;


{audineshiftlignetoserial}
{/******************** zi_zh ********************/
 /* Audine                                      */
 /*=============================================*/
 /* Transfert zone image -> registre horizontal */
 /***********************************************/}
procedure TCameraAudineObtu400.Audine_zi_zh;
var
   LocalAdress:Word;
begin
     LocalAdress:=Adress;
     asm
      mov dx,LocalAdress
      mov al,$FB
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FA
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$F9
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FA
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FB
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      end;
end;


procedure TCameraAudineObtu400.Audine_fast_line;
var
i:integer;
begin
     for i:=0 to 793 do
     begin
          audine_read_pel_fast;
     end;
end;

procedure TCameraAudineObtu400.Audine_fast_vidage;
var
i,j,k:integer;
{/*---- LECTURE DU REGISTRE HORIZONTAL ----*/}
begin
    for i:=1 to 129 do
    begin
       for j:=0 to 3 do audine_zi_zh;
       for k:=1 to 793 do audine_read_pel_fast;
    end;
end;

constructor TCameraAudineObtu400.Create;
begin
   inherited Create;
   ShutterState:=ShutterIsSynchro;
end;

function TCameraAudineObtu400.IsConnectedAndOK:Boolean;
begin
// Quoi mettre ici ?
Result:=True;
end;

function TCameraAudineObtu400.Open:Boolean;
begin
AmpliOn;
Result:=True;
end;

procedure TCameraAudineObtu400.Close;
begin
// Rien a faire ici
end;

function TCameraAudineObtu400.StartPose:Boolean;
var
   i:Integer;
   temp:tdatetime;
   PoseCamera:Integer;
begin
   Result:=True;

   Sx:=(x2-x1+1) div Binning;
   Sy:=(y2-y1+1) div Binning;

   PoseCamera:=Round(Pose*1000);

   if (getamplistate and ampliisused and (Pose > GetDelayToSwitchOffAmpli)) then
   begin
        setamplistatefalse;
        AmpliOff;
   end;

   // vidage matrice
   for i:=1 to 5 do Audine_fast_vidage;

   // ouvrir l obtu si il est synchro
   if (ShutterState=ShutterIsSynchro) and (camera.pose > camera.ShutterCloseDelay) then
   begin
        ShutterOpen;
   end;

   DateTimeBegin:=GetHourDT;
end;

function TCameraAudineObtu400.ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean;
var
   x,a1,a2,a3,a4:integer ;
   i,j,k,toto,z:integer;
   ligne:array [1..2000] of word;
begin
   result:=true; // Par defaut, pas d'erreur
   // On rallume l'ampli
{   if UseAmpli then
        AmpliOn;}
   // On ferme l'obturateur si il est synchro
   if (ShutterState=ShutterIsSynchro) and (camera.Pose>shutterclosedelay) then
   begin
      ShutterClosed;
      do_sleep(ShutterCloseDelay);
   end;

   DateTimeEnd:=GetHourDT;
      
   {/**** on retire les 4 premières lignes ****/ }
   for i:=0 to 3 do audine_zi_zh;
        audine_fast_line;

   for i:=1 to ((y1-1) div 4) do
   begin
        for j:=0 to 3 do audine_zi_zh;
        audine_fast_line;
   end;
   for j:=1 to((y1-1) mod 4) do audine_zi_zh;
   audine_fast_line;

   for i:=1 to (y2-y1+1) div binning do
   begin
      if not OSIsNT then asm cli end;
      audine_fast_line;
      {2 fois en b2, 3 en b3...}
      for k:=1 to binning do audine_zi_zh;
      {/**** on retire les 14 premiers pixels ****/ }
      for k:=1 to (14+x1-1) do audine_read_pel_fast; //0 to 13 do audine_read_pel_fast(Port);
      for j:=1 to (x2-x1+1) div binning do
      begin
         // reset
         portwrite(247,Adress);
         // palier de reference
         for toto:=1 to 5 do portwrite(255,Adress);
         // clamp
         portwrite(239,Adress);
         {on ne lit que les n pixels}
         for toto:=1 to binning do begin portwrite(255,Adress); portwrite(251,Adress); end;
         for toto:=1 to 4 do portwrite(251,Adress);
         for toto:=1 to 6 do portwrite(219,Adress);
         {numerisation}
         a1:=integer(portread(Adress+1)) shr 4;
         portwrite(91,Adress);
         a2:=integer(portread(Adress+1)) shr 4;
         portwrite(155,Adress);
         a3:=integer(portread(Adress+1)) shr 4;
         portwrite(27,Adress);
         a4:=integer(portread(Adress+1)) shr 4;

         x:=(a1+(a2 shl 4)+(a3 shl 8)+(a4 shl 12)) Xor $8888;  // pourquoi 34952 au fait ?
         if (x>32767) then x:=32767;
         // cast
         ligne[j]:=word(x);
      end;
      // on met dans DataInt
      for j:=1 to ((x2-x1+1) div binning) do
      begin
          if Ligne[j] >32767 then TabImgInt^[1]^[i]^[j]:=32767 else TabImgInt^[1]^[i]^[j]:=ligne[j];
      end;
      {/**** on retire 10 pixels à la fin ****/ }
      //for z:=1 to 20+x1-x0 do audine_read_pel_fast(Port);
      for z:=1 to 10 do audine_read_pel_fast;
   end;

//   result:=true; //et si il y a eu une erreur ?
   if not OSIsNT then asm sti end;
end;

function TCameraAudineObtu400.GetDelayToSwitchOffAmpli:Double;
begin
Result:=4;
end;

function TCameraAudineObtu400.GetDelayToSwitchOnAmpli:Double;
begin
Result:=1;
end;

function TCameraAudineObtu400.StopPose:Boolean;
begin

end;

// Met à zéro du bit 0 du port de controle
// eteint l ampli
procedure TCameraAudineObtu400.AmpliOff;
begin
   portwrite((portread(Adress+2) or $01) xor $04, Adress+2);
end;

// Met à un du bit 0 du port de controle
procedure TCameraAudineObtu400.AmpliOn;
begin
   portwrite((portread(Adress+2) and $FE) xor $04, Adress+2);
end;

procedure TCameraAudineObtu400.ShutterSynchro;
begin
// Rien à faire ici
end;

procedure TCameraAudineObtu400.ShutterOpen;
begin
   portwrite((portread(Adress+2) or $02) xor $04, Adress+2);
end;

procedure TCameraAudineObtu400.ShutterClosed;
begin
   portwrite((portread(Adress+2) and $FD) xor $04, Adress+2);
end;

// Caracteristiques
function TCameraAudineObtu400.GetName:PChar;
begin
Result:=PChar('Audine 400 avec Obturateur'); //nolang
end;

function TCameraAudineObtu400.GetSaturationLevel:Integer;
begin
Result:=16383; // TODO : a verifier
end;

function TCameraAudineObtu400.GetXSize:Integer;
begin
Result:=768;
end;

function TCameraAudineObtu400.GetYSize:Integer;
begin
Result:=512;
end;

function TCameraAudineObtu400.GetXPixelSize:Double;
begin
Result:=9;
end;

function TCameraAudineObtu400.GetYPixelSize:Double;
begin
Result:=9;
end;

function TCameraAudineObtu400.IsAValidBinning(Binning:Byte):Boolean;
begin
if (Binning=1) or (Binning=2) or (Binning=3) or (Binning=4) then Result:=True
else Result:=False
end;

function TCameraAudineObtu400.HasTemperature:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu400.CanCutAmpli:Boolean;
begin
Result:=True;
end;

function TCameraAudineObtu400.NeedEmptyingDelay:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu400.NeedReadingDelay:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu400.NeedCloseShutterDelay:Boolean;
begin
Result:=True;
end;

function TCameraAudineObtu400.HasAShutter:Boolean;
begin
Result:=True;
end;

procedure TCameraAudineObtu400.GetCCDDateBegin(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure TCameraAudineObtu400.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure TCameraAudineObtu400.GetCCDDateEnd(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure TCameraAudineObtu400.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

procedure TCameraAudineObtu400.SetHourServer(ServerAdress:Pointer);
begin
HourServerAdress:=ServerAdress;
end;

procedure TCameraAudineObtu400.SetPCMinusUT(PCMinusUT:Double);
begin
// Pas besoin en interne pour l'instant
end;

function TCameraAudineObtu400.ShowCfgWindow:Boolean;
begin
Result:=True;
end;

function TCameraAudineObtu400.IsTrackCCD:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu400.NeedPixelSize:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu400.Is16Bits:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu400.HasCfgWindow:Boolean;
begin
Result:=False;
end;

//******************************************************************************
//**************************    Camera Audine1600 sans obtu   ******************
//******************************************************************************

function TCameraAudine1600.StartPose:Boolean;
var
   i:Integer;
   temp:tdatetime;
   PoseCamera:Integer;
begin
   Result:=True;

   Sx:=(x2-x1+1) div Binning;
   Sy:=(y2-y1+1) div Binning;

   PoseCamera:=Round(Pose*1000);

   // coupe ampli pose > 4s
   if (getamplistate and ampliisused and (Pose > GetDelayToSwitchOffAmpli)) then
   begin
        setamplistatefalse;
        AmpliOff;
   end;

   // vidage matrice
   for i:=1 to 5 do Audine_fast_vidage;

   DateTimeBegin:=GetHourDT;
end;

procedure TCameraAudine1600.Audine_read_pel_fast;
var
   LocalAdress:Word;
begin
LocalAdress:=Adress;
asm
   mov  dx,LocalAdress
   mov  al,$F7
   out  dx,al
   mov  al,$FF
   out  dx,al
   mov  al,$FB
   out  dx,al
end;
end;


procedure TCameraAudine1600.Audine_zi_zh;
var
   LocalAdress:Word;
begin
     LocalAdress:=Adress;
     asm
      mov dx,LocalAdress
      mov al,$FB
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FA
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$F9
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FA
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FB
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      end;
end;

procedure TCameraAudine1600.Audine_fast_line;
var
i:integer;
begin
     for i:=1 to 1564 do
     begin
          audine_read_pel_fast;
     end;
end;

procedure TCameraAudine1600.Audine_fast_vidage;
var
i,j,k:integer;
{/*---- LECTURE DU REGISTRE HORIZONTAL ----*/}
begin
    for i:=1 to 1032 div 4 do
    begin
       for j:=1 to 4 do audine_zi_zh;
       for k:=1 to 1564 do audine_read_pel_fast;
    end;
end;

constructor TCameraAudine1600.Create;
begin
   inherited Create;
end;

function TCameraAudine1600.IsConnectedAndOK:Boolean;
begin
// Quoi mettre ici ?
Result:=True;
end;

function TCameraAudine1600.Open:Boolean;
begin
AmpliOn;
Result:=True;
end;

procedure TCameraAudine1600.Close;
begin
// Rien a faire ici
end;


function TCameraAudine1600.ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean;
var
   x,a1,a2,a3,a4:integer ;
   i,j,k,toto,z:integer;
   ligne:array [1..2000] of word;
begin
   result:=true; // Par defaut, pas d'erreur

   DateTimeEnd:=GetHourDT;
      
   // On rallume l'ampli
{   if UseAmpli then
        AmpliOn;}
   {/**** on retire les 4 premières lignes ****/ }
   for i:=0 to 3 do audine_zi_zh;
   audine_fast_line;
   for i:=1 to ((y1-1) div 4) do
   begin
        for j:=0 to 3 do audine_zi_zh;
        audine_fast_line;
   end;
   for j:=1 to((y1-1) mod 4) do audine_zi_zh;
   audine_fast_line;

   for i:=1 to (y2-y1+1) div binning do
   begin
      if not OSIsNT then asm cli end;
      audine_fast_line;
      {2 fois en b2, 3 en b3...}
      for k:=1 to binning do audine_zi_zh;
      {/**** on retire les 14 premiers pixels ****/ }
      for k:=1 to (14+x1-1) do audine_read_pel_fast; //0 to 13 do audine_read_pel_fast(Port);
      for j:=1 to (x2-x1+1) div binning do
      begin
         // reset
         portwrite(247,Adress);
         // palier de reference
         for toto:=1 to 5 do portwrite(255,Adress);
         // clamp
         portwrite(239,Adress);
         {on ne lit que les n pixels}
         for toto:=1 to binning do begin portwrite(255,Adress); portwrite(251,Adress); end;
         for toto:=1 to 4 do portwrite(251,Adress);
         for toto:=1 to 6 do portwrite(219,Adress);
         {numerisation}
         a1:=integer(portread(Adress+1)) shr 4;
         portwrite(91,Adress);
         a2:=integer(portread(Adress+1)) shr 4;
         portwrite(155,Adress);
         a3:=integer(portread(Adress+1)) shr 4;
         portwrite(27,Adress);
         a4:=integer(portread(Adress+1)) shr 4;

         x:=(a1+(a2 shl 4)+(a3 shl 8)+(a4 shl 12)) Xor $8888;  // pourquoi 34952 au fait ?
         if (x>32767) then x:=32767;
         // cast
         ligne[j]:=word(x);
      end;
      // on met dans DataInt
      for j:=1 to ((x2-x1+1) div binning) do
      begin
          if Ligne[j] >32767 then TabImgInt^[1]^[i]^[j]:=32767 else TabImgInt^[1]^[i]^[j]:=ligne[j];
      end;
      {/**** on retire 10 pixels à la fin ****/ }
      //for z:=1 to 20+x1-x0 do audine_read_pel_fast(Port);
      for z:=1 to 14 do audine_read_pel_fast;
   end;

//   result:=true; //et si il y a eu une erreur ?
   if not OSIsNT then asm sti end;
end;

function TCameraAudine1600.GetDelayToSwitchOffAmpli:Double;
begin
Result:=4;
end;

function TCameraAudine1600.GetDelayToSwitchOnAmpli:Double;
begin
Result:=1;
end;

function TCameraAudine1600.StopPose:Boolean;
begin

end;

// Met à zéro du bit 0 du port de controle
// eteint l ampli
procedure TCameraAudine1600.AmpliOff;
begin
   portwrite((portread(Adress+2) or $01) xor $04, Adress+2);
end;

// Met à un du bit 0 du port de controle
procedure TCameraAudine1600.AmpliOn;
begin
    portwrite((portread(Adress+2) and $FE) xor $04, Adress+2);
end;

//function TCameraAudine1600.AmpliIsUsed:Boolean;
//begin
//Result:=UseAmpli;
//end;

// Caracteristiques
function TCameraAudine1600.GetName:PChar;
begin
Result:=PChar('Audine 1600'); //nolang
end;

function TCameraAudine1600.GetSaturationLevel:Integer;
begin
Result:=16383; // TODO : a verifier
end;

function TCameraAudine1600.GetXSize:Integer;
begin
Result:=1536;
end;

function TCameraAudine1600.GetYSize:Integer;
begin
Result:=1024;
end;

function TCameraAudine1600.GetXPixelSize:Double;
begin
Result:=9;
end;

function TCameraAudine1600.GetYPixelSize:Double;
begin
Result:=9;
end;

function TCameraAudine1600.IsAValidBinning(Binning:Byte):Boolean;
begin
if (Binning=1) or (Binning=2) or (Binning=3) or (Binning=4) then Result:=True
else Result:=False
end;

function TCameraAudine1600.HasTemperature:Boolean;
begin
Result:=False;
end;

function TCameraAudine1600.CanCutAmpli:Boolean;
begin
Result:=True;
end;

function TCameraAudine1600.NeedEmptyingDelay:Boolean;
begin
Result:=False;
end;

function TCameraAudine1600.NeedReadingDelay:Boolean;
begin
Result:=False;
end;

function TCameraAudine1600.NeedCloseShutterDelay:Boolean;
begin
Result:=False;
end;

function TCameraAudine1600.HasAShutter:Boolean;
begin
Result:=False; // TODO : a verifier que c'est possible
end;

procedure TCameraAudine1600.GetCCDDateBegin(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure TCameraAudine1600.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure TCameraAudine1600.GetCCDDateEnd(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure TCameraAudine1600.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

procedure TCameraAudine1600.SetHourServer(ServerAdress:Pointer);
begin
HourServerAdress:=ServerAdress;
end;

procedure TCameraAudine1600.SetPCMinusUT(PCMinusUT:Double);
begin
// Pas besoin en interne pour l'instant
end;

function TCameraAudine1600.ShowCfgWindow:Boolean;
begin
Result:=True;
end;

function TCameraAudine1600.IsTrackCCD:Boolean;
begin
Result:=False;
end;

function TCameraAudine1600.NeedPixelSize:Boolean;
begin
Result:=False;
end;

function TCameraAudine1600.Is16Bits:Boolean;
begin
Result:=False;
end;

function TCameraAudine1600.HasCfgWindow:Boolean;
begin
Result:=False;
end;

//******************************************************************************
//**************************    Camera Audine1600 avec obtu   ******************
//******************************************************************************

procedure TCameraAudineObtu1600.Audine_read_pel_fast;
var
   LocalAdress:Word;
begin
LocalAdress:=Adress;
asm
   mov  dx,LocalAdress
   mov  al,$F7
   out  dx,al
   mov  al,$FF
   out  dx,al
   mov  al,$FB
   out  dx,al
end;
end;


procedure TCameraAudineObtu1600.Audine_zi_zh;
var
   LocalAdress:Word;
begin
     LocalAdress:=Adress;
     asm
      mov dx,LocalAdress
      mov al,$FB
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FA
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$F9
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FA
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FB
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      end;
end;


procedure TCameraAudineObtu1600.Audine_fast_line;
var
i:integer;
begin
     for i:=1 to 1564 do
     begin
          audine_read_pel_fast;
     end;
end;

procedure TCameraAudineObtu1600.Audine_fast_vidage;
var
i,j,k:integer;
begin
    for i:=1 to 1032 div 4 do
    begin
       for j:=1 to 4 do audine_zi_zh;
       audine_fast_line;
    end;
end;

constructor TCameraAudineObtu1600.Create;
begin
   inherited Create;
   ShutterState:=ShutterIsSynchro;
end;

function TCameraAudineObtu1600.IsConnectedAndOK:Boolean;
begin
// Quoi mettre ici ?
Result:=True;
end;

function TCameraAudineObtu1600.Open:Boolean;
begin
AmpliOn
end;

procedure TCameraAudineObtu1600.Close;
begin
// Rien a faire ici
end;

function TCameraAudineObtu1600.StartPose:Boolean;
var
   i:Integer;
   temp:tdatetime;
   PoseCamera:Integer;
begin
   Result:=True;

   Sx:=(x2-x1+1) div Binning;
   Sy:=(y2-y1+1) div Binning;

   PoseCamera:=Round(Pose*1000);

   if (getamplistate and ampliisused and (Pose > GetDelayToSwitchOffAmpli)) then
   begin
        setamplistatefalse;
        AmpliOff;
   end;

   // vidage matrice
   for i:=1 to 5 do Audine_fast_vidage;

   // ouvrir l obtu si il est synchro
   if (ShutterState=ShutterIsSynchro) and (camera.pose > camera.ShutterCloseDelay) then
   begin
        ShutterOpen;
   end;

   DateTimeBegin:=GetHourDT;
end;

function TCameraAudineObtu1600.ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean;
var
   x,a1,a2,a3,a4:integer ;
   i,j,k,toto,z:integer;
   ligne:array [1..2000] of word;
begin
   result:=true; // Par defaut, pas d'erreur
   // On rallume l'ampli
{   if UseAmpli then
        AmpliOn;}
   // On ferme l'obturateur si il est synchro
   if (ShutterState=ShutterIsSynchro) and (camera.Pose>shutterclosedelay) then
   begin
      ShutterClosed;
      do_sleep(ShutterCloseDelay);
   end;

   DateTimeEnd:=GetHourDT;   

   {/**** on retire les 4 premières lignes ****/ }
   for i:=0 to 3 do audine_zi_zh;
        audine_fast_line;

   for i:=1 to ((y1-1) div 4) do
   begin
        for j:=0 to 3 do audine_zi_zh;
        audine_fast_line;
   end;
   for j:=1 to((y1-1) mod 4) do audine_zi_zh;
   audine_fast_line;

   for i:=1 to (y2-y1+1) div binning do
   begin
      if not OSIsNT then asm cli end;
      audine_fast_line;
      {2 fois en b2, 3 en b3...}
      for k:=1 to binning do audine_zi_zh;
      {/**** on retire les 14 premiers pixels ****/ }
      for k:=1 to (14+x1-1) do audine_read_pel_fast; //0 to 13 do audine_read_pel_fast(Port);
      for j:=1 to (x2-x1+1) div binning do
      begin
         // reset
         portwrite(247,Adress);
         // palier de reference
         for toto:=1 to 5 do portwrite(255,Adress);
         // clamp
         portwrite(239,Adress);
         {on ne lit que les n pixels}
         for toto:=1 to binning do begin portwrite(255,Adress); portwrite(251,Adress); end;
         for toto:=1 to 4 do portwrite(251,Adress);
         for toto:=1 to 6 do portwrite(219,Adress);
         {numerisation}
         a1:=integer(portread(Adress+1)) shr 4;
         portwrite(91,Adress);
         a2:=integer(portread(Adress+1)) shr 4;
         portwrite(155,Adress);
         a3:=integer(portread(Adress+1)) shr 4;
         portwrite(27,Adress);
         a4:=integer(portread(Adress+1)) shr 4;

         x:=(a1+(a2 shl 4)+(a3 shl 8)+(a4 shl 12)) Xor $8888;  // pourquoi 34952 au fait ?
         if (x>32767) then x:=32767;
         // cast
         ligne[j]:=word(x);
      end;
      // on met dans DataInt
      for j:=1 to ((x2-x1+1) div binning) do
      begin
          if Ligne[j] >32767 then TabImgInt^[1]^[i]^[j]:=32767 else TabImgInt^[1]^[i]^[j]:=ligne[j];
      end;
      {/**** on retire 10 pixels à la fin ****/ }
      //for z:=1 to 20+x1-x0 do audine_read_pel_fast(Port);
      for z:=1 to 14 do audine_read_pel_fast;
   end;

//   result:=true; //et si il y a eu une erreur ?
   if not OSIsNT then asm sti end;
end;

function TCameraAudineObtu1600.GetDelayToSwitchOffAmpli:Double;
begin
Result:=4;
end;

function TCameraAudineObtu1600.GetDelayToSwitchOnAmpli:Double;
begin
Result:=1;
end;

function TCameraAudineObtu1600.StopPose:Boolean;
begin

end;

// Met à zéro du bit 0 du port de controle
// eteint l ampli
procedure TCameraAudineObtu1600.AmpliOff;
begin
   portwrite((portread(Adress+2) or $01) xor $04, Adress+2);
end;

// Met à un du bit 0 du port de controle
procedure TCameraAudineObtu1600.AmpliOn;
begin
   portwrite((portread(Adress+2) and $FE) xor $04, Adress+2);
end;

procedure TCameraAudineObtu1600.ShutterSynchro;
begin
// Rien à faire ici
end;

procedure TCameraAudineObtu1600.ShutterOpen;
begin
   portwrite((portread(Adress+2) or $02) xor $04, Adress+2);
end;

procedure TCameraAudineObtu1600.ShutterClosed;
begin
   portwrite((portread(Adress+2) and $FD) xor $04, Adress+2);
end;

// Caracteristiques
function TCameraAudineObtu1600.GetName:PChar;
begin
Result:=PChar('Audine 1600 avec Obturateur'); //nolang
end;

function TCameraAudineObtu1600.GetSaturationLevel:Integer;
begin
Result:=16383; // TODO : a verifier
end;

function TCameraAudineObtu1600.GetXSize:Integer;
begin
Result:=1536;
end;

function TCameraAudineObtu1600.GetYSize:Integer;
begin
Result:=1024;
end;

function TCameraAudineObtu1600.GetXPixelSize:Double;
begin
Result:=9;
end;

function TCameraAudineObtu1600.GetYPixelSize:Double;
begin
Result:=9;
end;

function TCameraAudineObtu1600.IsAValidBinning(Binning:Byte):Boolean;
begin
if (Binning=1) or (Binning=2) or (Binning=3) or (Binning=4) then Result:=True
else Result:=False
end;

function TCameraAudineObtu1600.HasTemperature:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu1600.CanCutAmpli:Boolean;
begin
Result:=True;
end;

function TCameraAudineObtu1600.NeedEmptyingDelay:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu1600.NeedReadingDelay:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu1600.NeedCloseShutterDelay:Boolean;
begin
Result:=True;
end;

function TCameraAudineObtu1600.HasAShutter:Boolean;
begin
Result:=True;
end;

procedure TCameraAudineObtu1600.GetCCDDateBegin(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure TCameraAudineObtu1600.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure TCameraAudineObtu1600.GetCCDDateEnd(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure TCameraAudineObtu1600.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

procedure TCameraAudineObtu1600.SetHourServer(ServerAdress:Pointer);
begin
HourServerAdress:=ServerAdress;
end;

procedure TCameraAudineObtu1600.SetPCMinusUT(PCMinusUT:Double);
begin
// Pas besoin en interne pour l'instant
end;

function TCameraAudineObtu1600.ShowCfgWindow:Boolean;
begin
Result:=True;
end;

function TCameraAudineObtu1600.IsTrackCCD:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu1600.NeedPixelSize:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu1600.Is16Bits:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu1600.HasCfgWindow:Boolean;
begin
Result:=False;
end;

//******************************************************************************
//**************************    Camera Audine3200 sans obtu   ******************
//******************************************************************************

function TCameraAudine3200.StartPose:Boolean;
var
   i:Integer;
   temp:tdatetime;
   PoseCamera:Integer;
begin
   Result:=True;

   Sx:=(x2-x1+1) div Binning;
   Sy:=(y2-y1+1) div Binning;

   PoseCamera:=Round(Pose*1000);

   // coupe ampli pose > 4s
   if (getamplistate and ampliisused and (Pose > GetDelayToSwitchOffAmpli)) then
   begin
        setamplistatefalse;
        AmpliOff;
   end;

   // vidage matrice
   for i:=1 to 5 do Audine_fast_vidage;

   DateTimeBegin:=GetHourDT;
end;

procedure TCameraAudine3200.SetPCMinusUT(PCMinusUT:Double);
begin
// Pas besoin en interne pour l'instant
end;

function TCameraAudine3200.ShowCfgWindow:Boolean;
begin
Result:=True;
end;

procedure TCameraaudine3200.Audine_read_pel_fast;  //inv
var
   LocalAdress:Word;
begin
     LocalAdress:=Adress;
     portwrite(switch($F7),LocalAdress);    // anuler ca pour enlever le reset
     portwrite(switch($FF),LocalAdress);
     portwrite(switch($FB),LocalAdress);
end;


procedure TCameraaudine3200.Audine_zi_zh;
var
   LocalAdress:Word;
   i:integer;
begin
     LocalAdress:=Adress;
     for i:=1 to 8 do portwrite(switch($FB),LocalAdress);
     for i:=1 to 8 do portwrite(switch($FA),LocalAdress);
     for i:=1 to 8 do portwrite(switch($F9),LocalAdress);
     for i:=1 to 8 do portwrite(switch($FA),LocalAdress);
     for i:=1 to 8 do portwrite(switch($FB),LocalAdress);
end;

procedure TCameraaudine3200.Audine_fast_line;

var
i:integer;
begin
     for i:=1 to 2267 do
     begin
          audine_read_pel_fast;
     end;
end;

procedure TCameraaudine3200.Audine_fast_vidage;
var
i,j,k:integer;

begin
    // lecture bin 8
    for i:=1 to 189 do
    begin
       for j:=1 to 8 do audine_zi_zh;
       //audine_fast_line;
    end;
    // on vide le registre horizontal
    for i:=1 to 8 do audine_fast_line;
end;

constructor TCameraaudine3200.Create;
begin
   inherited Create;

end;

function TCameraaudine3200.IsConnectedAndOK:Boolean;
begin
// Quoi mettre ici ?
Result:=True;
end;

function TCameraaudine3200.Open:Boolean;
begin
AmpliOn;
Result:=True;
end;

procedure TCameraaudine3200.Close;
begin
// Rien a faire ici
end;

function TCameraaudine3200.ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean;
var
   x,a1,a2,a3,a4:integer ;
   i,j,k,toto,z:integer;
   ligne:array [1..2300] of word;
begin
   result:=true; // Par defaut, pas d'erreur

   DateTimeEnd:=GetHourDT;
      
   if not OSIsNT then asm cli end;
   {on retire les 34 premières lignes}
   for i:=1 to 34 do
   begin
        audine_zi_zh;
        audine_fast_line;
   end;
   for i:=1 to ((y1-1) div 4) do
   begin
        for j:=0 to 3 do audine_zi_zh;
        audine_fast_line;
   end;
   for j:=1 to((y1-1) mod 4) do audine_zi_zh;
   audine_fast_line;
   for i:=1 to (y2-y1+1) div binning do
   begin
      audine_fast_line;
      {2 fois en b2, 3 en b3...}
      for k:=1 to binning do audine_zi_zh;
      {/**** on retire les 46 premiers pixels ****/ }
      for k:=1 to (46+x1-1) do audine_read_pel_fast;
      for j:=1 to (x2-x1+1) div binning do
      begin
         // reset
         portwrite(switch(247),Adress);
         // palier de reference
         for toto:=1 to 5 do portwrite(switch(255),Adress); // marche avec 3 ?
         // clamp
         portwrite(switch(239),Adress);
         {on ne lit que les n pixels}
         for toto:=1 to binning do
         begin
              portwrite(switch(255),Adress);
              portwrite(switch(251),Adress);
         end;
         for toto:=1 to 4 do portwrite(switch(251),Adress);   // marche avec 3 ?
         for toto:=1 to 6 do portwrite(switch(219),Adress);   // marche avec 3 ?
         {numerisation}
         a1:=integer(portread(Adress+1)) shr 4;
         portwrite(switch(91),Adress);
         a2:=integer(portread(Adress+1)) shr 4;
         portwrite(switch(155),Adress);
         a3:=integer(portread(Adress+1)) shr 4;
         portwrite(switch(27),Adress);
         a4:=integer(portread(Adress+1)) shr 4;
         x:=(a1+(a2 shl 4)+(a3 shl 8)+(a4 shl 12)) Xor $8888;
           if (x>32767) then x:=32767;

         // cast
         ligne[j]:=word(x);
      end;
      // on met dans DataInt
      for j:=1 to ((x2-x1+1) div binning) do
      begin
          if Ligne[j] > 32767 then TabImgInt^[1]^[i]^[j]:=32767 else TabImgInt^[1]^[i]^[j]:=ligne[j];
      end;
      {/**** on retire 37 pixels à la fin ****/ }
      for z:=1 to 37 do audine_read_pel_fast;

   end;

//   result:=true; //et si il y a eu une erreur ?
   if not OSIsNT then asm sti end;
end;

function TCameraaudine3200.GetDelayToSwitchOffAmpli:Double;
begin
Result:=4;
end;

function TCameraaudine3200.GetDelayToSwitchOnAmpli:Double;
begin
Result:=1;
end;

function TCameraaudine3200.StopPose:Boolean;
begin

end;

// Met à zéro du bit 0 du port de controle
// eteint l ampli
procedure TCameraaudine3200.AmpliOff;
begin
   portwrite((portread(Adress+2) or $01) xor $04, Adress+2);
end;

// Met à un du bit 0 du port de controle
procedure TCameraaudine3200.AmpliOn;
begin
    portwrite((portread(Adress+2) and $FE) xor $04, Adress+2);
end;

//function TCameraAudine.AmpliIsUsed:Boolean;
//begin
//Result:=UseAmpli;
//end;

// Caracteristiques
function TCameraaudine3200.GetName:PChar;
begin
Result:=PChar('Audine 3200'); //nolang
end;

function TCameraaudine3200.GetSaturationLevel:Integer;
begin
Result:=32767; // TODO : a verifier
end;

function TCameraaudine3200.GetXSize:Integer;
begin
Result:=2184;
end;

function TCameraaudine3200.GetYSize:Integer;
begin
Result:=1472;
end;

function TCameraaudine3200.GetXPixelSize:Double;
begin
Result:=6.8;
end;

function TCameraaudine3200.GetYPixelSize:Double;
begin
Result:=6.8;
end;

function TCameraaudine3200.IsAValidBinning(Binning:Byte):Boolean;
begin
if (Binning=1) or (Binning=2) or (Binning=3) or (Binning=4) then Result:=True
else Result:=False
end;

function TCameraaudine3200.HasTemperature:Boolean;
begin
Result:=False;
end;

function TCameraaudine3200.CanCutAmpli:Boolean;
begin
Result:=True;
end;

function TCameraaudine3200.NeedEmptyingDelay:Boolean;
begin
Result:=False;
end;

function TCameraaudine3200.NeedReadingDelay:Boolean;
begin
Result:=False;
end;

function TCameraaudine3200.NeedCloseShutterDelay:Boolean;
begin
Result:=False;
end;

function TCameraaudine3200.HasAShutter:Boolean;
begin
Result:=False; // TODO : a verifier que c'est possible
end;

procedure TCameraaudine3200.GetCCDDateBegin(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure TCameraaudine3200.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure TCameraAudine3200.GetCCDDateEnd(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure TCameraAudine3200.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

procedure TCameraAudine3200.SetHourServer(ServerAdress:Pointer);
begin
HourServerAdress:=ServerAdress;
end;

function TCameraAudine3200.IsTrackCCD:Boolean;
begin
Result:=False;
end;

function TCameraAudine3200.NeedPixelSize:Boolean;
begin
Result:=False;
end;

function TCameraAudine3200.Is16Bits:Boolean;
begin
Result:=False;
end;

function TCameraAudine3200.HasCfgWindow:Boolean;
begin
Result:=False;
end;

//******************************************************************************
//**************************    Camera Audine3200 avec obtu   *******************
//******************************************************************************

procedure TCameraAudineObtu3200.Audine_read_pel_fast;
var
   LocalAdress:Word;
begin
LocalAdress:=Adress;
asm
   mov  dx,LocalAdress
   mov  al,$F7
   out  dx,al
   mov  al,$FF
   out  dx,al
   mov  al,$FB
   out  dx,al
end;
end;


{audineshiftlignetoserial}
{/******************** zi_zh ********************/
 /* Audine                                      */
 /*=============================================*/
 /* Transfert zone image -> registre horizontal */
 /***********************************************/}
procedure TCameraAudineObtu3200.Audine_zi_zh;
var
   LocalAdress:Word;
begin
     LocalAdress:=Adress;
     asm
      mov dx,LocalAdress
      mov al,$FB
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FA
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$F9
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FA
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      mov al,$FB
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      out dx,al
      end;
end;


procedure TCameraAudineObtu3200.Audine_fast_line;
var
i:integer;
begin
     for i:=0 to 793 do
     begin
          audine_read_pel_fast;
     end;
end;

procedure TCameraAudineObtu3200.Audine_fast_vidage;
var
i,j,k:integer;
{/*---- LECTURE DU REGISTRE HORIZONTAL ----*/}
begin
    for i:=1 to 129 do
    begin
       for j:=0 to 3 do audine_zi_zh;
       for k:=1 to 793 do audine_read_pel_fast;
    end;
end;

constructor TCameraAudineObtu3200.Create;
begin
   inherited Create;
   ShutterState:=ShutterIsSynchro;
end;

function TCameraAudineObtu3200.IsConnectedAndOK:Boolean;
begin
// Quoi mettre ici ?
Result:=True;
end;

function TCameraAudineObtu3200.Open:Boolean;
begin
AmpliOn;
Result:=True;
end;

procedure TCameraAudineObtu3200.Close;
begin
// Rien a faire ici
end;

function TCameraAudineObtu3200.StartPose:Boolean;
var
   i:Integer;
   temp:tdatetime;
   PoseCamera:Integer;
begin
   Result:=True;

   Sx:=(x2-x1+1) div Binning;
   Sy:=(y2-y1+1) div Binning;

   PoseCamera:=Round(Pose*1000);

   if (getamplistate and ampliisused and (Pose > GetDelayToSwitchOffAmpli)) then
   begin
        setamplistatefalse;
        AmpliOff;
   end;

   // vidage matrice
   for i:=1 to 5 do Audine_fast_vidage;

   // ouvrir l obtu si il est synchro
   if (ShutterState=ShutterIsSynchro) and (camera.pose > camera.ShutterCloseDelay) then
   begin
        ShutterOpen;
   end;

   DateTimeBegin:=GetHourDT;
end;

function TCameraAudineObtu3200.ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean;
var
   x,a1,a2,a3,a4:integer ;
   i,j,k,toto,z:integer;
   ligne:array [1..2000] of word;
begin
   result:=true; // Par defaut, pas d'erreur
   // On rallume l'ampli
{   if UseAmpli then
        AmpliOn;}
   // On ferme l'obturateur si il est synchro
   if (ShutterState=ShutterIsSynchro) and (camera.Pose>shutterclosedelay) then
   begin
      ShutterClosed;
      do_sleep(ShutterCloseDelay);
   end;

   DateTimeEnd:=GetHourDT;

   {/**** on retire les 4 premières lignes ****/ }
   for i:=0 to 3 do audine_zi_zh;
        audine_fast_line;

   for i:=1 to ((y1-1) div 4) do
   begin
        for j:=0 to 3 do audine_zi_zh;
        audine_fast_line;
   end;
   for j:=1 to((y1-1) mod 4) do audine_zi_zh;
   audine_fast_line;

   for i:=1 to (y2-y1+1) div binning do
   begin
      if not OSIsNT then asm cli end;
      audine_fast_line;
      {2 fois en b2, 3 en b3...}
      for k:=1 to binning do audine_zi_zh;
      {/**** on retire les 14 premiers pixels ****/ }
      for k:=1 to (14+x1-1) do audine_read_pel_fast; //0 to 13 do audine_read_pel_fast(Port);
      for j:=1 to (x2-x1+1) div binning do
      begin
         // reset
         portwrite(247,Adress);
         // palier de reference
         for toto:=1 to 5 do portwrite(255,Adress);
         // clamp
         portwrite(239,Adress);
         {on ne lit que les n pixels}
         for toto:=1 to binning do begin portwrite(255,Adress); portwrite(251,Adress); end;
         for toto:=1 to 4 do portwrite(251,Adress);
         for toto:=1 to 6 do portwrite(219,Adress);
         {numerisation}
         a1:=integer(portread(Adress+1)) shr 4;
         portwrite(91,Adress);
         a2:=integer(portread(Adress+1)) shr 4;
         portwrite(155,Adress);
         a3:=integer(portread(Adress+1)) shr 4;
         portwrite(27,Adress);
         a4:=integer(portread(Adress+1)) shr 4;

         x:=(a1+(a2 shl 4)+(a3 shl 8)+(a4 shl 12)) Xor $8888;  // pourquoi 34952 au fait ?
         if (x>32767) then x:=32767;
         // cast
         ligne[j]:=word(x);
      end;
      // on met dans DataInt
      for j:=1 to ((x2-x1+1) div binning) do
      begin
          if Ligne[j] >32767 then TabImgInt^[1]^[i]^[j]:=32767 else TabImgInt^[1]^[i]^[j]:=ligne[j];
      end;
      {/**** on retire 10 pixels à la fin ****/ }
      //for z:=1 to 20+x1-x0 do audine_read_pel_fast(Port);
      for z:=1 to 10 do audine_read_pel_fast;
   end;

//   result:=true; //et si il y a eu une erreur ?
   if not OSIsNT then asm sti end;
end;

function TCameraAudineObtu3200.GetDelayToSwitchOffAmpli:Double;
begin
Result:=4;
end;

function TCameraAudineObtu3200.GetDelayToSwitchOnAmpli:Double;
begin
Result:=1;
end;

function TCameraAudineObtu3200.StopPose:Boolean;
begin

end;

procedure TCameraAudineObtu3200.SetPCMinusUT(PCMinusUT:Double);
begin
// Pas besoin en interne pour l'instant
end;

function TCameraAudineObtu3200.ShowCfgWindow:Boolean;
begin
Result:=True;
end;

// Met à zéro du bit 0 du port de controle
// eteint l ampli
procedure TCameraAudineObtu3200.AmpliOff;
begin
   portwrite((portread(Adress+2) or $01) xor $04, Adress+2);
end;

// Met à un du bit 0 du port de controle
procedure TCameraAudineObtu3200.AmpliOn;
begin
   portwrite((portread(Adress+2) and $FE) xor $04, Adress+2);
end;

procedure TCameraAudineObtu3200.ShutterSynchro;
begin
// Rien à faire ici
end;

procedure TCameraAudineObtu3200.ShutterOpen;
begin
   portwrite((portread(Adress+2) or $02) xor $04, Adress+2);
end;

procedure TCameraAudineObtu3200.ShutterClosed;
begin
   portwrite((portread(Adress+2) and $FD) xor $04, Adress+2);
end;

// Caracteristiques
function TCameraAudineObtu3200.GetName:PChar;
begin
Result:=PChar('Audine 3200 avec Obturateur'); //nolang
end;

function TCameraAudineObtu3200.GetSaturationLevel:Integer;
begin
Result:=16383; // TODO : a verifier
end;

function TCameraAudineObtu3200.GetXSize:Integer;
begin
Result:=768;
end;

function TCameraAudineObtu3200.GetYSize:Integer;
begin
Result:=512;
end;

function TCameraAudineObtu3200.GetXPixelSize:Double;
begin
Result:=9;
end;

function TCameraAudineObtu3200.GetYPixelSize:Double;
begin
Result:=9;
end;

function TCameraAudineObtu3200.IsAValidBinning(Binning:Byte):Boolean;
begin
if (Binning=1) or (Binning=2) or (Binning=3) or (Binning=4) then Result:=True
else Result:=False
end;

function TCameraAudineObtu3200.HasTemperature:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu3200.CanCutAmpli:Boolean;
begin
Result:=True;
end;

function TCameraAudineObtu3200.NeedEmptyingDelay:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu3200.NeedReadingDelay:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu3200.NeedCloseShutterDelay:Boolean;
begin
Result:=True;
end;

function TCameraAudineObtu3200.HasAShutter:Boolean;
begin
Result:=True;
end;

procedure TCameraAudineObtu3200.GetCCDDateBegin(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure TCameraAudineObtu3200.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure TCameraAudineObtu3200.GetCCDDateEnd(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure TCameraAudineObtu3200.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

procedure TCameraAudineObtu3200.SetHourServer(ServerAdress:Pointer);
begin
HourServerAdress:=ServerAdress;
end;

function TCameraAudineObtu3200.IsTrackCCD:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu3200.NeedPixelSize:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu3200.Is16Bits:Boolean;
begin
Result:=False;
end;

function TCameraAudineObtu3200.HasCfgWindow:Boolean;
begin
Result:=False;
end;

//******************************************************************************
//**************************    Camera PlugIn TeleAuto    **********************
//******************************************************************************

// Fonctionnement
constructor TCameraPlugin.Create;
begin
   inherited Create;
   if PluginCameraSuivi then
      begin
//      WriteSpy(lang('PluginCameraSuivi = True'));
      HandlePlugin:=LoadLibrary(PChar(Config.CameraPluginSuivi))
      end
   else
      begin
//      WriteSpy(lang('PluginCameraSuivi = False'));      
      HandlePlugin:=LoadLibrary(PChar(Config.CameraPlugin));
      end;
   if HandlePlugin<>0 then
      begin
      PluginSetPort                  := TSetPort(GetProcAddress(HandlePlugin,'PluginSetPort'));                                             //nolang
      PluginSetWindow                := TSetWindow(GetProcAddress(HandlePlugin,'PluginSetWindow'));                                         //nolang
      PluginSetBinning               := TSetBinning(GetProcAddress(HandlePlugin,'PluginSetBinning'));                                       //nolang
      PluginSetPose                  := TSetPose(GetProcAddress(HandlePlugin,'PluginSetPose'));                                             //nolang
      PluginSetEmptyingDelay         := TSetEmptyingDelay(GetProcAddress(HandlePlugin,'PluginSetEmptyingDelay'));                           //nolang
      PluginSetReadingDelay          := TSetReadingDelay(GetProcAddress(HandlePlugin,'PluginSetReadingDelay'));                             //nolang
      PluginSetShutterCloseDelay     := TSetShutterCloseDelay(GetProcAddress(HandlePlugin,'PluginSetShutterCloseDelay'));                   //nolang

      PluginIsConnectedAndOK         := TIsConnectedAndOK(GetProcAddress(HandlePlugin,'PluginIsConnectedAndOK'));                  //nolang
      PluginOpen                     := TOpen(GetProcAddress(HandlePlugin,'PluginOpen'));                                          //nolang
      PluginClose                    := TClose(GetProcAddress(HandlePlugin,'PluginClose'));                                        //nolang
      PluginStartPose                := TStartPose(GetProcAddress(HandlePlugin,'PluginStartPose'));                                //nolang
      PluginStopPose                 := TStopPose(GetProcAddress(HandlePlugin,'PluginStopPose'));                                  //nolang
      PluginReadCCD                  := TReadCCD(GetProcAddress(HandlePlugin,'PluginReadCCD'));                                    //nolang
      PluginGetTemperature           := TGetTemperature(GetProcAddress(HandlePlugin,'PluginGetTemperature'));                      //nolang
      PluginSetTemperature           := TSetTemperature(GetProcAddress(HandlePlugin,'PluginSetTemperature'));                      //nolang
      PluginSetPCMinusUT             := TSetPCMinusUT(GetProcAddress(HandlePlugin,'PluginSetPCMinusUT'));                          //nolang
      PluginAmpliOn                  := TAmpliOn(GetProcAddress(HandlePlugin,'PluginAmpliOn'));                                    //nolang
      PluginAmpliOff                 := TAmpliOff(GetProcAddress(HandlePlugin,'PluginAmpliOff'));                                  //nolang
      PluginShutterOpen              := TShutterOpen(GetProcAddress(HandlePlugin,'PluginShutterOpen'));                            //nolang
      PluginShutterClosed            := TShutterClosed(GetProcAddress(HandlePlugin,'PluginShutterClosed'));                        //nolang
      PluginShutterSynchro           := TShutterSynchro(GetProcAddress(HandlePlugin,'PluginShutterSynchro'));                      //nolang
      PluginGetCCDDateBegin          := TGetCCDDateBegin(GetProcAddress(HandlePlugin,'PluginGetCCDDateBegin'));                    //nolang
      PluginGetCCDTimeBegin          := TGetCCDTimeBegin(GetProcAddress(HandlePlugin,'PluginGetCCDTimeBegin'));                    //nolang
      PluginGetCCDDateEnd            := TGetCCDDateEnd(GetProcAddress(HandlePlugin,'PluginGetCCDDateEnd'));                        //nolang
      PluginGetCCDTimeEnd            := TGetCCDTimeEnd(GetProcAddress(HandlePlugin,'PluginGetCCDTimeEnd'));                        //nolang
      PluginSetHourServer            := TSetHourServer(GetProcAddress(HandlePlugin,'PluginSetHourServer'));                        //nolang
      PluginGetShutterCloseDelay     := TGetShutterCloseDelay(GetProcAddress(HandlePlugin,'PluginGetShutterCloseDelay'));          //nolang

      PluginGetName                  := TGetName(GetProcAddress(HandlePlugin,'PluginGetName'));                                    //nolang
      PluginGetSaturationLevel       := TGetSaturationLevel(GetProcAddress(HandlePlugin,'PluginGetSaturationLevel'));              //nolang
      PluginGetXSize                 := TGetXSize(GetProcAddress(HandlePlugin,'PluginGetXSize'));                                  //nolang
      PluginGetYSize                 := TGetYSize(GetProcAddress(HandlePlugin,'PluginGetYSize'));                                  //nolang
      PluginGetNbPlans               := TGetNbplans(GetProcAddress(HandlePlugin,'PluginGetNbplans'));                              //nolang
      PluginGetTypeData              := TGetTypeData(GetProcAddress(HandlePlugin,'PluginGetTypeData'));                            //nolang
      PluginGetXPixelSize            := TGetXPixelSize(GetProcAddress(HandlePlugin,'PluginGetXPixelSize'));                        //nolang
      PluginGetYPixelSize            := TGetYPixelSize(GetProcAddress(HandlePlugin,'PluginGetYPixelSize'));                        //nolang
      PluginIsAValidBinning          := TIsAValidBinning(GetProcAddress(HandlePlugin,'PluginIsAValidBinning'));                    //nolang
      PluginHasTemperature           := THasTemperature(GetProcAddress(HandlePlugin,'PluginHasTemperature'));                      //nolang
      PluginCanCutAmpli              := TCanCutAmpli(GetProcAddress(HandlePlugin,'PluginCanCutAmpli'));                            //nolang
      PluginGetDelayToSwitchOffAmpli := TGetDelayToSwitchOffAmpli(GetProcAddress(HandlePlugin,'PluginGetDelayToSwitchOffAmpli'));  //nolang
      PluginGetDelayToSwitchOnAmpli  := TGetDelayToSwitchOnAmpli(GetProcAddress(HandlePlugin,'PluginGetDelayToSwitchOnAmpli'));    //nolang
      PluginNeedEmptyingDelay        := TNeedEmptyingDelay(GetProcAddress(HandlePlugin,'PluginNeedEmptyingDelay'));                //nolang
      PluginNeedReadingDelay         := TNeedReadingDelay(GetProcAddress(HandlePlugin,'PluginNeedReadingDelay'));                  //nolang
      PluginNeedCloseShutterDelay    := TNeedCloseShutterDelay(GetProcAddress(HandlePlugin,'PluginNeedCloseShutterDelay'));        //nolang
      PluginHasAShutter              := THasAShutter(GetProcAddress(HandlePlugin,'PluginHasAShutter'));                            //nolang
      PluginIsUsedUnderNT            := TIsUsedUnderNT(GetProcAddress(HandlePlugin,'PluginIsUsedUnderNT'));                        //nolang
      PluginIsNotUsedUnderNT         := TIsNotUsedUnderNT(GetProcAddress(HandlePlugin,'PluginIsNotUsedUnderNT'));                  //nolang
      PluginIs16Bits                 := TIs16Bits(GetProcAddress(HandlePlugin,'PluginIs16Bits'));                                  //nolang
      PluginHasCfgWindow             := THasCfgWindow(GetProcAddress(HandlePlugin,'PluginHasCfgWindow'));                          //nolang
      PluginShowCfgWindow            := TShowCfgWindow(GetProcAddress(HandlePlugin,'PluginShowCfgWindow'));                          //nolang      

      end
   else raise ErrorCamera.Create(lang('Librairie plugin introuvable'));
end;

procedure TCameraPlugin.SetPort(_Adress:Word);
begin
if Config.Verbose then WriteSpy('SetPort'); //nolang
if Config.Verbose then WriteSpy('Adress = '+IntToStr(_Adress)); //nolang
PluginSetPort(_Adress);
end;

function TCameraPlugin.SetWindow(_x1,_y1,_x2,_y2:Integer):Boolean;
begin
if Config.Verbose then WriteSpy('SetWindow'); //nolang
if Config.Verbose then WriteSpy('x1 = '+IntToStr(_x1)); //nolang
if Config.Verbose then WriteSpy('y1 = '+IntToStr(_y1)); //nolang
if Config.Verbose then WriteSpy('x2 = '+IntToStr(_x2)); //nolang
if Config.Verbose then WriteSpy('y2 = '+IntToStr(_y2)); //nolang
Result:=PluginSetWindow(_x1,_y1,_x2,_y2);
end;

function TCameraPlugin.SetBinning(_Binning:Integer):Boolean;
begin
if Config.Verbose then WriteSpy('SetBinning'); //nolang
if Config.Verbose then WriteSpy('Binning = '+IntToStr(_Binning)); //nolang
Result:=PluginSetBinning(_Binning);
end;

function TCameraPlugin.SetPose(_Pose:Double):Boolean;
begin
if Config.Verbose then WriteSpy('SetPose'); //nolang
if Config.Verbose then WriteSpy('Pose = '+FloatToStr(_Pose)); //nolang
Result:=PluginSetPose(_Pose);
Pose:=_Pose;
end;

function TCameraPlugin.SetEmptyingDelay(_EmptyingDelay:Double):Boolean;
begin
if Config.Verbose then WriteSpy('SetEmptyingDelay'); //nolang
if Config.Verbose then WriteSpy('EmptyingDelay = '+FloatToStr(_EmptyingDelay)); //nolang
Result:=PluginSetEmptyingDelay(_EmptyingDelay);
end;

function TCameraPlugin.SetReadingDelay(_ReadingDelay:Double):Boolean;
begin
if Config.Verbose then WriteSpy('SetReadingDelay'); //nolang
if Config.Verbose then WriteSpy('ReadingDelay = '+FloatToStr(_ReadingDelay)); //nolang
Result:=PluginSetReadingDelay(_ReadingDelay);
end;

function TCameraPlugin.SetShutterCloseDelay(Delay:Double):Boolean;
begin
if Config.Verbose then WriteSpy('SetShutterCloseDelay'); //nolang
if Config.Verbose then WriteSpy('Delay = '+FloatToStr(Delay)); //nolang
Result:=PluginSetShutterCloseDelay(Delay);
end;

function TCameraPlugin.IsConnectedAndOK:Boolean;
begin
if Config.Verbose then WriteSpy('IsConnectedAndOK'); //nolang
if HandlePlugin<>0 then Result:=PluginIsConnectedAndOK
else Result:=False;
if Config.Verbose then if Result then WriteSpy('IsConnectedAndOK = True') else WriteSpy('IsConnectedAndOK = False'); //nolang
end;

function TCameraPlugin.Open:Boolean;
begin
if Config.Verbose then WriteSpy('Open'); //nolang
Result:=PluginOpen;
end;

procedure TCameraPlugin.Close;
begin
if Config.Verbose then WriteSpy('Close'); //nolang
PluginClose;
end;

function TCameraPlugin.StartPose:Boolean;
begin
if Config.Verbose then WriteSpy('StartPose'); //nolang
Result:=PluginStartPose;
if (getamplistate and ampliisused and (Pose > GetDelayToSwitchOffAmpli)) then
   begin
        setamplistatefalse;
        AmpliOff;
   end;
end;

function TCameraPlugin.StopPose:Boolean;
begin
if Config.Verbose then WriteSpy('StopPose'); //nolang
Result:=PluginStopPose;
end;

function TCameraPlugin.ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean;
begin
if Config.Verbose then WriteSpy('ReadCCD'); //nolang
if Config.Verbose then WriteSpy('ImgSx = '+IntToStr(ImgSx)); //nolang
if Config.Verbose then WriteSpy('ImgSy = '+IntToStr(ImgSy)); //nolang
Result:=PluginReadCCD(TabImgInt,ImgSx,ImgSy);
end;

function TCameraPlugin.GetTemperature:Double;
begin
if Config.Verbose then WriteSpy('GetTemperature'); //nolang
Result:=PluginGetTemperature;
if Config.Verbose then WriteSpy('Temperature = '+FloatToStr(Result)); //nolang
end;

procedure TCameraPlugin.SetTemperature(TargetTemperature:Double);
begin
if Config.Verbose then WriteSpy('SetTemperature'); //nolang
if Config.Verbose then WriteSpy('Temperature = '+FloatToStr(TargetTemperature)); //nolang
PluginSetTemperature(TargetTemperature)
end;

procedure TCameraPlugin.SetPCMinusUT(PCMinusUT:Double);
begin
if Config.Verbose then WriteSpy('SetPCMinusUT'); //nolang
if Config.Verbose then WriteSpy('PCMinusUT = '+FloatToStr(PCMinusUT)); //nolang
PluginSetPCMinusUT(PCMinusUT);
end;

procedure TCameraPlugin.AmpliOn;
begin
if Config.Verbose then WriteSpy('AmpliOn'); //nolang
PluginAmpliOn;
end;

procedure TCameraPlugin.AmpliOff;
begin
if Config.Verbose then WriteSpy('AmpliOff'); //nolang
PluginAmpliOff;
end;

procedure TCameraPlugin.ShutterOpen;
begin
if Config.Verbose then WriteSpy('ShutterOpen'); //nolang
PluginShutterOpen;
end;

procedure TCameraPlugin.ShutterClosed;
begin
if Config.Verbose then WriteSpy('ShutterClosed'); //nolang
PluginShutterClosed;
end;

procedure TCameraPlugin.ShutterSynchro;
begin
if Config.Verbose then WriteSpy('ShutterSynchro'); //nolang
PluginShutterSynchro;
end;

// Caracteristiques
function TCameraPlugin.GetName:PChar;
begin
if Config.Verbose then WriteSpy('GetName'); //nolang
Result:=PluginGetName;
WriteSpy('Name = '+Result); //nolang
end;

function TCameraPlugin.GetSaturationLevel:Integer;
begin
if Config.Verbose then WriteSpy('GetSaturationLevel'); //nolang
Result:=PluginGetSaturationLevel;
if Config.Verbose then WriteSpy('SaturationLevel = '+IntToStr(Result)); //nolang
end;

function TCameraPlugin.GetXSize:Integer;
begin
if Config.Verbose then WriteSpy('GetXSize'); //nolang
Result:=PluginGetXSize;
if Config.Verbose then WriteSpy('XSize = '+IntToStr(Result)); //nolang
end;

function TCameraPlugin.GetYSize:Integer;
begin
if Config.Verbose then WriteSpy('GetYSize'); //nolang
Result:=PluginGetYSize;
if Config.Verbose then WriteSpy('YSize = '+IntToStr(Result)); //nolang
end;

function TCameraPlugin.GetXPixelSize:Double;
begin
if Config.Verbose then WriteSpy('GetXPixelSize'); //nolang
Result:=PluginGetXPixelSize;
if Config.Verbose then WriteSpy('XPixelSize = '+FloatToStr(Result)); //nolang
end;

function TCameraPlugin.GetYPixelSize:Double;
begin
if Config.Verbose then WriteSpy('GetYPixelSize'); //nolang
Result:=PluginGetYPixelSize;
if Config.Verbose then WriteSpy('YPixelSize = '+FLoatToStr(Result)); //nolang
end;

function TCameraPlugin.GetNbPlans:Integer;
begin
if Config.Verbose then WriteSpy('GetNbPlans'); //nolang
Result:=PluginGetNbplans;
if Config.Verbose then WriteSpy('NbPlans = '+IntToStr(Result)); //nolang
end;

function TCameraPlugin.GetTypeData:Integer;
begin
if Config.Verbose then WriteSpy('GetTypeData'); //nolang
Result:=PluginGetTypedata;
if Config.Verbose then WriteSpy('TypeData = '+IntToStr(Result)); //nolang
end;

function TCameraPlugin.IsAValidBinning(Binning:Byte):Boolean;
begin
if Config.Verbose then WriteSpy('IsAValidBinning'); //nolang
if Config.Verbose then WriteSpy('Binning = '+IntToStr(Binning)); //nolang
Result:=PluginIsAValidBinning(Binning);
end;

function TCameraPlugin.HasTemperature:Boolean;
begin
if Config.Verbose then WriteSpy('HasTemperature'); //nolang
Result:=PluginHasTemperature;

end;

function TCameraPlugin.CanCutAmpli:Boolean;
begin
if Config.Verbose then WriteSpy('CanCutAmpli'); //nolang
Result:=PluginCanCutAmpli;
if Config.Verbose then if Result then WriteSpy('CanCutAmpli = True') else WriteSpy('CanCutAmpli = False'); //nolang
end;

function TCameraPlugin.GetDelayToSwitchOffAmpli:Double;
begin
if Config.Verbose then WriteSpy('GetDelayToSwitchOffAmpli'); //nolang
Result:=PluginGetDelayToSwitchOffAmpli;
if Config.Verbose then WriteSpy('DelayToSwitchOffAmpli = '+FloatToStr(Result)); //nolang
end;

function TCameraPlugin.GetDelayToSwitchOnAmpli:Double;
begin
if Config.Verbose then WriteSpy('GetDelayToSwitchOnAmpli'); //nolang
Result:=PluginGetDelayToSwitchOnAmpli;
if Config.Verbose then WriteSpy('DelayToSwitchOnAmpli = '+FloatToStr(Result)); //nolang
end;

function TCameraPlugin.NeedEmptyingDelay:Boolean;
begin
if Config.Verbose then WriteSpy('NeedEmptyingDelay'); //nolang
Result:=PluginNeedEmptyingDelay;
if Config.Verbose then if Result then WriteSpy('NeedEmptyingDelay = True') else WriteSpy('NeedEmptyingDelay = False'); //nolang
end;

function TCameraPlugin.NeedReadingDelay:Boolean;
begin
if Config.Verbose then WriteSpy('NeedReadingDelay'); //nolang
Result:=PluginNeedReadingDelay;
if Config.Verbose then if Result then WriteSpy('NeedReadingDelay = True') else WriteSpy('NeedReadingDelay = False'); //nolang
end;

function TCameraPlugin.NeedCloseShutterDelay:Boolean;
begin
if Config.Verbose then WriteSpy('NeedCloseShutterDelay'); //nolang
Result:=PluginNeedCloseShutterDelay;
if Config.Verbose then if Result then WriteSpy('NeedCloseShutterDelay = True') else WriteSpy('NeedCloseShutterDelay = False'); //nolang
end;

function TCameraPlugin.HasAShutter:Boolean;
begin
if Config.Verbose then WriteSpy('HasAShutter'); //nolang
Result:=PluginHasAShutter;
if Config.Verbose then if Result then WriteSpy('HasAShutter = True') else WriteSpy('HasAShutter = False'); //nolang
end;

procedure TCameraPlugin.GetCCDDateBegin(var Year,Month,Day:Word);
begin
if Config.Verbose then WriteSpy('GetCCDDateBegin'); //nolang
PluginGetCCDDateBegin(Year,Month,Day);
if Config.Verbose then WriteSpy('Year = '+IntToStr(Year)); //nolang
if Config.Verbose then WriteSpy('Month = '+IntToStr(Month)); //nolang
if Config.Verbose then WriteSpy('Day = '+IntToStr(Day)); //nolang
end;

procedure TCameraPlugin.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
if Config.Verbose then WriteSpy('GetCCDTimeBegin'); //nolang
PluginGetCCDTimeBegin(Hour,Min,Sec,MSec);
if Config.Verbose then WriteSpy('Hour = '+IntToStr(Hour)); //nolang
if Config.Verbose then WriteSpy('Min = '+IntToStr(Min)); //nolang
if Config.Verbose then WriteSpy('Sec = '+IntToStr(Sec)); //nolang
if Config.Verbose then WriteSpy('MSec = '+IntToStr(MSec)); //nolang
end;

procedure TCameraPlugin.GetCCDDateEnd(var Year,Month,Day:Word);
begin
if Config.Verbose then WriteSpy('GetCCDDateEnd'); //nolang
PluginGetCCDDateEnd(Year,Month,Day);
if Config.Verbose then WriteSpy('Year = '+IntToStr(Year)); //nolang
if Config.Verbose then WriteSpy('Month = '+IntToStr(Month)); //nolang
if Config.Verbose then WriteSpy('Day = '+IntToStr(Day)); //nolang
end;

procedure TCameraPlugin.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
if Config.Verbose then WriteSpy('GetCCDTimeEnd'); //nolang
PluginGetCCDTimeEnd(Hour,Min,Sec,MSec);
if Config.Verbose then WriteSpy('Hour = '+IntToStr(Hour)); //nolang
if Config.Verbose then WriteSpy('Min = '+IntToStr(Min)); //nolang
if Config.Verbose then WriteSpy('Sec = '+IntToStr(Sec)); //nolang
if Config.Verbose then WriteSpy('MSec = '+IntToStr(MSec)); //nolang
end;

procedure TCameraPlugin.SetHourServer(ServerAdress:Pointer);
begin
if Config.Verbose then WriteSpy('SetHourServer'); //nolang
PluginSetHourServer(ServerAdress);
end;

procedure TCameraPlugin.IsUsedUnderNT;
begin
if Config.Verbose then WriteSpy('IsUsedUnderNT'); //nolang
PluginIsUsedUnderNT;
end;

procedure TCameraPlugin.IsNotUsedUnderNT;
begin
if Config.Verbose then WriteSpy('IsNotUsedUnderNT'); //nolang
PluginIsNotUsedUnderNT;
end;

// Pour l'instant les plugins ne supportent pas les camera avec capteur de guidage integre (Brevet SBIG)
function TCameraPlugin.IsTrackCCD:Boolean;
begin
if Config.Verbose then WriteSpy('IsTrackCCD'); //nolang
Result:=False;
if Config.Verbose then if Result then WriteSpy('IsTrackCCD = True') else WriteSpy('IsTrackCCD = False'); //nolang
end;

// Pour l'instant, on considere que les plugins connaissent obligatoirement la taille des pixels
function TCameraPlugin.NeedPixelSize:Boolean;
begin
if Config.Verbose then WriteSpy('NeedPixelSize'); //nolang
Result:=False;
if Config.Verbose then if Result then WriteSpy('NeedPixelSize = True') else WriteSpy('NeedPixelSize = False'); //nolang
end;

function TCameraPlugin.Is16Bits:Boolean;
begin
if Config.Verbose then WriteSpy('Is16Bits'); //nolang
Result:=PluginIs16Bits;
if Config.Verbose then if Result then WriteSpy('Is16Bits = True') else WriteSpy('Is16Bits = False'); //nolang
end;

function TCameraPlugin.HasCfgWindow:Boolean;
begin
if Config.Verbose then WriteSpy('HasCfgWindow'); //nolang
Result:=PluginHasCfgWindow;
if Config.Verbose then if Result then WriteSpy('HasCfgWindow = True') else WriteSpy('HasCfgWindow = False'); //nolang
end;

function TCameraPlugin.ShowCfgWindow:Boolean;
begin
if Config.Verbose then WriteSpy('ShowCfgWindow'); //nolang
Result:=PluginShowCfgWindow;
end;

//******************************************************************************
//**************************          Camera ST9          **********************
//******************************************************************************

constructor TCameraST9.Create;
begin
   inherited Create;
   ShutterState:=ShutterIsSynchro;
end;

function TCameraST9.IsConnectedAndOK:Boolean;
var
   Name:string;
begin
Result:=True;
if OSIsNT then GetCameraNameSbigNT(Name) else GetCameraNameSbig(Name);
WriteSpy('ST7IsConnectedAndOK : '+Name); //Nolang
Result:=False;
if Copy(Name,1,4)='SBIG' then Result:=True; //nolang
end;

function TCameraST9.Open:Boolean;
var
   Error,NoCamera:Word;
   NoPort:Byte;
begin
   Result:=True;
   if OSIsNT then
      begin
      Error:=OpenDriverSbigNT;
      if Error<>0 then
         begin
         WriteSpy('ST7OpenDriverSbigNT : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      if Config.AdresseCamera=$378 then NoPort:=1;
      if Config.AdresseCamera=$278 then NoPort:=2;
      if Config.AdresseCamera=$3BC then NoPort:=3;
      Error:=OpenDeviceSbigNT(NoPort);
      if Error<>0 then
         begin
         WriteSpy('ST7OpenDeviceSbigNT : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      Error:=EstablishLinkSbigNT(Adress,NoCamera);
      if Error<>0 then
         begin
         WriteSpy('ST7EstablishLinkSbigNT : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;         
      end
   else
      begin
      Error:=OpenDriverSbig;
      if Error<>0 then
         begin
         WriteSpy('ST7OpenDriverSbig : '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      Error:=EstablishLinkSbig(Adress,NoCamera);
      if Error<>0 then
         begin
         WriteSpy('ST7EstablishLinkSbig '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end;
end;

procedure TCameraST9.Close;
var
   Error:Word;
begin
   if OSIsNT then
      begin
      Error:=CloseDeviceSbigNT;
      if Error<>0 then WriteSpy('ST7CloseDevice : '+GetErrorSbigNT(Error)); //nolang
      Error:=CloseDriverSbigNT;
      if Error<>0 then WriteSpy('ST7CloseDriver : '+GetErrorSbigNT(Error)); //nolang
      end
   else
      begin
      Error:=CloseDriverSbig;
      if Error<>0 then WriteSpy('ST7CloseDriver : '+GetErrorSbig(Error)); //nolang
      end;
end;

function TCameraST9.StartPose:Boolean;
var
   PoseCamera:Integer;
   Error:Word;
begin
   Result:=True;

   Sx:=(x2-x1+1) div Binning;
   Sy:=(y2-y1+1) div Binning;

   PoseCamera:=Round(Pose*100);

   if OSIsNT then
      begin
      if ShutterState=ShutterIsAllwaysClosed then Error:=StartExposureSbigNT(2,PoseCamera);
      if ShutterState=ShutterIsSynchro then Error:=StartExposureSbigNT(1,PoseCamera);
      if Error<>0 then
         begin
         WriteSpy('StartST7Acquisition : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end
   else
      begin
      if ShutterState=ShutterIsAllwaysClosed then Error:=StartExposureSbig(2,PoseCamera);
      if ShutterState=ShutterIsSynchro then Error:=StartExposureSbig(1,PoseCamera);
      if Error<>0 then
         begin
         WriteSpy('StartST7Acquisition : '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end;

   DateTimeBegin:=GetHourDT;
end;

function TCameraST9.ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean;
var
   Lig:PLigWord;
   Error,Valeur:Word;
   i,j:Integer;
   ReadoutLineParams:TReadoutLineParams;
begin
   Getmem(Lig,512*2);

   try


   if OSIsNT then
      begin
      DateTimeEnd:=GetHourDT;
      EndExposureSbigNT;

      // Virer les premieres lignes
      DumpLineSbigNT(Binning-1,(Y1-1) div Binning);

      for j:=1 to ((Y2-Y1+1) div Binning) do
         begin
         ReadoutLineParams.Ccd:=0;
         ReadoutLineParams.ReadoutMode:=Binning-1;
         ReadoutLineParams.PixelStart:=X1 div Binning;
         ReadoutLineParams.PixelLength:=(X2-X1+1) div Binning;
         ParDeviceCommandNH(CC_READOUT_LINE,ReadoutLineParams,Lig^);

         for i:=1 to ((X2-X1+1) div Binning) do
            begin
            Valeur:=Lig^[i];
            if Valeur>32767 then TabImgInt^[1]^[j]^[i]:=32767 else TabImgInt^[1]^[j]^[i]:=Lig^[i];
            end;
            end;

      EndReadoutSbigNT;
      end
   else
      begin
      DateTimeEnd:=GetHourDT;      
      EndExposureSbig;

      // Virer les premieres lignes
      DumpLineSbig(Binning-1,(Y1-1) div Binning);

      for j:=1 to ((Y2-Y1+1) div Binning) do
         begin
         ReadoutLineParams.Ccd:=0;
         ReadoutLineParams.ReadoutMode:=Binning-1;
         ReadoutLineParams.PixelStart:=X1 div Binning;
         ReadoutLineParams.PixelLength:=(X2-X1+1) div Binning;
         ParDrvCommand(CC_READOUT_LINE,ReadoutLineParams,Lig^);

         for i:=1 to ((X2-X1+1) div Binning) do
            begin
            Valeur:=Lig^[i];
            if Valeur>32767 then TabImgInt^[1]^[j]^[i]:=32767 else TabImgInt^[1]^[j]^[i]:=Lig^[i];
            end;
            end;

      EndReadoutSbig;
      end;

   finally
   Freemem(Lig,512*2);
   end;
end;

function TCameraST9.StopPose:Boolean;
var
   Error:Word;
begin
{   if OSIsNT then
      begin
      Error:=EndExposureSbigNT;
      if Error<>0 then
         begin
         WriteSpy('StopPoseST7 : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end
   else
      begin
      Error:=EndExposureSbig;
      if Error<>0 then
         begin
         WriteSpy('StopPoseST7 : '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end;}
end;

function TCameraST9.GetTemperature:Double;
var
   Error:Word;
   Temp:Double;
begin
   Result:=999;

   if OSIsNT then Error:=QueryTempStatusSbigNT(Temp) else Error:=QueryTempStatusSbig(Temp);
// Oula ! Ca rempli le spy.log avec ca ! J'enleve !
// if Error<>0 then WriteSpy('GetTemperatureST7 : '+GetErrorSbig(Error)) //nolang
// else WriteSpy(lang('GetTemperatureST7 : Température = ')+FloatToStr(Temp));

   if Error<>0 then raise ErrorCamera.Create(lang('Je ne peux pas lire la température de la caméra'))
   else Result:=Temp;
end;

procedure TCameraST9.SetTemperature(TargetTemperature:Double);
var
   Error:Word;
begin
   if OSIsNT then
      begin
      Error:=SetTempRegulOnSbigNT(TargetTemperature);
      if Error<>0 then WriteSpy('SetTemp : '+GetErrorSbigNT(Error)); //nolang
      end
   else
      begin
      Error:=SetTempRegulOnSbig(TargetTemperature);
      if Error<>0 then WriteSpy('SetTemp : '+GetErrorSbig(Error)); //nolang      
      end;
   if Error<>0 then raise ErrorCamera.Create(lang('Je ne peux pas envoyer la température de consigne à la caméra'));
end;

procedure TCameraST9.ShutterOpen;
begin
// Rien a faire ici
end;

procedure TCameraST9.ShutterClosed;
begin
// Rien a faire ici
end;

procedure TCameraST9.ShutterSynchro;
begin
// Rien a faire ici
end;

// Caracteristiques
function TCameraST9.GetName:PChar;
begin
Result:=PChar('ST9'); //nolang
end;

function TCameraST9.GetSaturationLevel:Integer;
begin
Result:=32767;
end;

function TCameraST9.GetXSize:Integer;
begin
Result:=512;
end;

function TCameraST9.GetYSize:Integer;
begin
Result:=512;
end;

function TCameraST9.GetXPixelSize:Double;
begin
Result:=20;
end;

function TCameraST9.GetYPixelSize:Double;
begin
Result:=20;
end;

function TCameraST9.IsAValidBinning(Binning:Byte):Boolean;
begin
if (Binning=1) or (Binning=2) or (Binning=3) then Result:=True
else Result:=False
end;

function TCameraST9.HasTemperature:Boolean;
begin
Result:=True;
end;

function TCameraST9.CanCutAmpli:Boolean;
begin
Result:=False;
end;

function TCameraST9.NeedEmptyingDelay:Boolean;
begin
Result:=False;
end;

function TCameraST9.NeedReadingDelay:Boolean;
begin
Result:=False;
end;

function TCameraST9.NeedCloseShutterDelay:Boolean;
begin
Result:=False;
end;

function TCameraST9.HasAShutter:Boolean;
begin
Result:=True;
end;

procedure TCameraST9.GetCCDDateBegin(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure TCameraST9.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure TCameraST9.GetCCDDateEnd(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure TCameraST9.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

procedure TCameraST9.SetHourServer(ServerAdress:Pointer);
begin
HourServerAdress:=ServerAdress;
end;

procedure TCameraST9.SetPCMinusUT(PCMinusUT:Double);
begin
// Pas besoin en interne pour l'instant
end;

function TCameraST9.ShowCfgWindow:Boolean;
begin
Result:=True;
end;

function TCameraST9.IsTrackCCD:Boolean;
begin
Result:=False;
end;

function TCameraST9.NeedPixelSize:Boolean;
begin
Result:=False;
end;

function TCameraST9.Is16Bits:Boolean;
begin
Result:=False;
end;

function TCameraST9.HasCfgWindow:Boolean;
begin
Result:=False;
end;

//******************************************************************************
//**************************          Camera ST10          **********************
//******************************************************************************

constructor TCameraST10.Create;
begin
   inherited Create;
   ShutterState:=ShutterIsSynchro;
end;

function TCameraST10.IsConnectedAndOK:Boolean;
var
   Name:string;
begin
Result:=True;
if OSIsNT then GetCameraNameSbigNT(Name) else GetCameraNameSbig(Name);
WriteSpy('ST7IsConnectedAndOK : '+Name); //Nolang
Result:=False;
if Copy(Name,1,4)='SBIG' then Result:=True; //nolang
end;

function TCameraST10.Open:Boolean;
var
   Error,NoCamera:Word;
   NoPort:Byte;
begin
   Result:=True;
   if OSIsNT then
      begin
      Error:=OpenDriverSbigNT;
      if Error<>0 then
         begin
         WriteSpy('ST7OpenDriverSbigNT : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      if Config.AdresseCamera=$378 then NoPort:=1;
      if Config.AdresseCamera=$278 then NoPort:=2;
      if Config.AdresseCamera=$3BC then NoPort:=3;
      Error:=OpenDeviceSbigNT(NoPort);
      if Error<>0 then
         begin
         WriteSpy('ST7OpenDeviceSbigNT : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      Error:=EstablishLinkSbigNT(Adress,NoCamera);
      if Error<>0 then
         begin
         WriteSpy('ST7EstablishLinkSbigNT : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end
   else
      begin
      Error:=OpenDriverSbig;
      if Error<>0 then
         begin
         WriteSpy('ST7OpenDriverSbig : '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      Error:=EstablishLinkSbig(Adress,NoCamera);
      if Error<>0 then
         begin
         WriteSpy('ST7EstablishLinkSbig '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end;
end;

procedure TCameraST10.Close;
var
   Error:Word;
begin
   if OSIsNT then
      begin
      Error:=CloseDeviceSbigNT;
      if Error<>0 then WriteSpy('ST7CloseDevice : '+GetErrorSbigNT(Error)); //nolang
      Error:=CloseDriverSbigNT;
      if Error<>0 then WriteSpy('ST7CloseDriver : '+GetErrorSbigNT(Error)); //nolang
      end
   else
      begin
      Error:=CloseDriverSbig;
      if Error<>0 then WriteSpy('ST7CloseDriver : '+GetErrorSbig(Error)); //nolang
      end;
end;

function TCameraST10.StartPose:Boolean;
var
   PoseCamera:Integer;
   Error:Word;
begin
   Result:=True;

   Sx:=(x2-x1+1) div Binning;
   Sy:=(y2-y1+1) div Binning;

   PoseCamera:=Round(Pose*100);

   if OSIsNT then
      begin
      if ShutterState=ShutterIsAllwaysClosed then Error:=StartExposureSbigNT(2,PoseCamera);
      if ShutterState=ShutterIsSynchro then Error:=StartExposureSbigNT(1,PoseCamera);
      if Error<>0 then
         begin
         WriteSpy('StartST7Acquisition : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end
   else
      begin
      if ShutterState=ShutterIsAllwaysClosed then Error:=StartExposureSbig(2,PoseCamera);
      if ShutterState=ShutterIsSynchro then Error:=StartExposureSbig(1,PoseCamera);
      if Error<>0 then
         begin
         WriteSpy('StartST7Acquisition : '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end;

   DateTimeBegin:=GetHourDT;
end;

function TCameraST10.ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean;
var
   Lig:PLigWord;
   Error,Valeur:Word;
   i,j:Integer;
   ReadoutLineParams:TReadoutLineParams;
begin
   Getmem(Lig,2184*2);

   try


   if OSIsNT then
      begin
      DateTimeEnd:=GetHourDT;      
      EndExposureSbigNT;

      // Virer les premieres lignes
      DumpLineSbigNT(Binning-1,(Y1-1) div Binning);

      for j:=1 to ((Y2-Y1+1) div Binning) do
         begin
         ReadoutLineParams.Ccd:=0;
         ReadoutLineParams.ReadoutMode:=Binning-1;
         ReadoutLineParams.PixelStart:=X1 div Binning;
         ReadoutLineParams.PixelLength:=(X2-X1+1) div Binning;
         ParDeviceCommandNH(CC_READOUT_LINE,ReadoutLineParams,Lig^);

         for i:=1 to ((X2-X1+1) div Binning) do
            begin
            Valeur:=Lig^[i];
            if Valeur>32767 then TabImgInt^[1]^[j]^[i]:=32767 else TabImgInt^[1]^[j]^[i]:=Lig^[i];
            end;
            end;

      EndReadoutSbigNT;
      end
   else
      begin
      DateTimeEnd:=GetHourDT;      
      EndExposureSbig;

      // Virer les premieres lignes
      DumpLineSbig(Binning-1,(Y1-1) div Binning);

      for j:=1 to ((Y2-Y1+1) div Binning) do
         begin
         ReadoutLineParams.Ccd:=0;
         ReadoutLineParams.ReadoutMode:=Binning-1;
         ReadoutLineParams.PixelStart:=X1 div Binning;
         ReadoutLineParams.PixelLength:=(X2-X1+1) div Binning;
         ParDrvCommand(CC_READOUT_LINE,ReadoutLineParams,Lig^);

         for i:=1 to ((X2-X1+1) div Binning) do
            begin
            Valeur:=Lig^[i];
            if Valeur>32767 then TabImgInt^[1]^[j]^[i]:=32767 else TabImgInt^[1]^[j]^[i]:=Lig^[i];
            end;
            end;

      EndReadoutSbig;
      end;

   finally
   Freemem(Lig,2184*2);
   end;
end;

function TCameraST10.StopPose:Boolean;
var
   Error:Word;
begin
{   if OSIsNT then
      begin
      Error:=EndExposureSbigNT;
      if Error<>0 then
         begin
         WriteSpy('StopPoseST7 : '+GetErrorSbigNT(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end
   else
      begin
      Error:=EndExposureSbig;
      if Error<>0 then
         begin
         WriteSpy('StopPoseST7 : '+GetErrorSbig(Error)); //nolang
         Result:=False;
         Exit;
         end;
      end;}
end;

function TCameraST10.GetTemperature:Double;
var
   Error:Word;
   Temp:Double;
begin
   Result:=999;

   if OSIsNT then Error:=QueryTempStatusSbigNT(Temp) else Error:=QueryTempStatusSbig(Temp);
// Oula ! Ca rempli le spy.log avec ca ! J'enleve !
// if Error<>0 then WriteSpy('GetTemperatureST7 : '+GetErrorSbig(Error)) //nolang
// else WriteSpy(lang('GetTemperatureST7 : Température = ')+FloatToStr(Temp));

   if Error<>0 then raise ErrorCamera.Create(lang('Je ne peux pas lire la température de la caméra'))
   else Result:=Temp;
end;

procedure TCameraST10.SetTemperature(TargetTemperature:Double);
var
   Error:Word;
begin
   if OSIsNT then
      begin
      Error:=SetTempRegulOnSbigNT(TargetTemperature);
      if Error<>0 then WriteSpy('SetTemp : '+GetErrorSbigNT(Error)); //nolang
      end
   else
      begin
      Error:=SetTempRegulOnSbig(TargetTemperature);
      if Error<>0 then WriteSpy('SetTemp : '+GetErrorSbig(Error)); //nolang
      end;
   if Error<>0 then raise ErrorCamera.Create(lang('Je ne peux pas envoyer la température de consigne à la caméra'));
end;

procedure TCameraST10.ShutterOpen;
begin
// Rien a faire ici
end;

procedure TCameraST10.ShutterClosed;
begin
// Rien a faire ici
end;

procedure TCameraST10.ShutterSynchro;
begin
// Rien a faire ici
end;

// Caracteristiques
function TCameraST10.GetName:PChar;
begin
Result:=PChar('ST10'); //nolang
end;

function TCameraST10.GetSaturationLevel:Integer;
begin
Result:=32767;
end;

function TCameraST10.GetXSize:Integer;
begin
Result:=2184;
end;

function TCameraST10.GetYSize:Integer;
begin
Result:=1472;
end;

function TCameraST10.GetXPixelSize:Double;
begin
Result:=6.8;
end;

function TCameraST10.GetYPixelSize:Double;
begin
Result:=6.8;
end;

function TCameraST10.IsAValidBinning(Binning:Byte):Boolean;
begin
if (Binning=1) or (Binning=2) or (Binning=3) then Result:=True
else Result:=False
end;

function TCameraST10.HasTemperature:Boolean;
begin
Result:=True;
end;

function TCameraST10.CanCutAmpli:Boolean;
begin
Result:=False;
end;

function TCameraST10.NeedEmptyingDelay:Boolean;
begin
Result:=False;
end;

function TCameraST10.NeedReadingDelay:Boolean;
begin
Result:=False;
end;

function TCameraST10.NeedCloseShutterDelay:Boolean;
begin
Result:=False;
end;

function TCameraST10.HasAShutter:Boolean;
begin
Result:=True;
end;

procedure TCameraST10.GetCCDDateBegin(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure TCameraST10.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure TCameraST10.GetCCDDateEnd(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure TCameraST10.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

procedure TCameraST10.SetHourServer(ServerAdress:Pointer);
begin
HourServerAdress:=ServerAdress;
end;

procedure TCameraST10.SetPCMinusUT(PCMinusUT:Double);
begin
// Pas besoin en interne pour l'instant
end;

function TCameraST10.ShowCfgWindow:Boolean;
begin
Result:=True;
end;

function TCameraST10.IsTrackCCD:Boolean;
begin
Result:=False;
end;

function TCameraST10.NeedPixelSize:Boolean;
begin
Result:=False;
end;

function TCameraST10.Is16Bits:Boolean;
begin
Result:=False;
end;

function TCameraST10.HasCfgWindow:Boolean;
begin
Result:=False;
end;

//******************************************************************************
//**************************        Camera Virtuelle      **********************
//******************************************************************************

// Fonctionnement
function TCameraVirtual.IsConnectedAndOK:Boolean;
begin
Result:=True;
end;

function TCameraVirtual.Open:Boolean;
begin
Result:=True;
end;

procedure TCameraVirtual.Close;
begin

end;

function TCameraVirtual.StartPose:Boolean;
begin
   DateTimeBegin:=GetHourDT;
   Result:=True;
end;

function TCameraVirtual.StopPose:Boolean;
begin
Result:=True;
end;

function TCameraVirtual.ReadCCD(var TabImgInt:PTabImgInt; ImgSx,ImgSy:Integer):Boolean;
var
   i,j,k:Integer;
   ImgDouble:PTabImgDouble;
   PSF:TPSF;
   Diametre:Double;
begin
DateTimeEnd:=GetHourDT;

//Sleep(Round(Pose*1000));
PSF.IntensiteMax:=8000;
PSF.Angle:=0;
PSF.SigmaX:=1.9;
PSF.SigmaY:=1.9;

k:=100;

Sx:=((X2-X1+1) div Binning);
Sy:=((Y2-Y1+1) div Binning);

for j:=1 to Sy do
   for i:=1 to Sx do
      TabImgInt^[1]^[j]^[i]:=0;

// Test de la focalisation
if TesteFocalisation and not VAcqNoir then
   begin
   Diametre:=Config.DiametreProche+Abs(FWHMTestCourant); // +40% car le HFD sousestime
   if Diametre<5 then
      begin
      PSF.SigmaX:=Diametre;
      PSF.SigmaY:=Diametre;
      AddStar(TabImgInt,ImgDouble,2,Sx,Sy,PSF,Sx/2,Sy/2);
      end
   else
      begin
      for j:=1 to Sy do
         for i:=1 to Sx do
            if Sqrt(Sqr(i-Sx/2)+Sqr(j-Sy/2))<=Diametre/2 then TabImgInt^[1]^[j]^[i]:=4000;
      Gaussienne(TabImgInt,ImgDouble,2,1,Sx,Sy,1);
      end;
   end;

if not(VAcqNoir) then
   begin
   for j:=1 to Sy do
      for i:=1 to Sx do
         TabImgInt^[1]^[j]^[i]:=TabImgInt^[1]^[j]^[i]+Round(1000+RandN(k)*200);
   end;

if AcqTrack then
   begin
   if Config.SuiviRef then AddStar(TabImgInt,ImgDouble,2,Sx,Sy,PSF,Sx/2,Sy/2);
   if Config.SuiviEnCours then AddStar(TabImgInt,ImgDouble,2,Sx,Sy,PSF,Sx/2+RandN(k)/4,Sy/2+RandN(k)/4);
   case Config.EtapeCalibration of
      0:;
      1:AddStar(TabImgInt,ImgDouble,2,Sx,Sy,PSF,Sx/2,Sy/2);
      2:AddStar(TabImgInt,ImgDouble,2,Sx,Sy,PSF,Sx/2,Sy/2+30);
      3:AddStar(TabImgInt,ImgDouble,2,Sx,Sy,PSF,Sx/2+30,Sy/2);
      4:AddStar(TabImgInt,ImgDouble,2,Sx,Sy,PSF,Sx/2,Sy/2+4);
      5:AddStar(TabImgInt,ImgDouble,2,Sx,Sy,PSF,Sx/2,Sy/2+26);
//      1:AddStar(TabImgInt,ImgDouble,2,Sx,Sy,PSF,Sx/2+RandN(k),Sy/2+RandN(k));
//      2:AddStar(TabImgInt,ImgDouble,2,Sx,Sy,PSF,Sx/2+RandN(k),Sy/2+RandN(k)+30);
//      3:AddStar(TabImgInt,ImgDouble,2,Sx,Sy,PSF,Sx/2+RandN(k)+30,Sy/2+RandN(k));
      end;
   end;

// test de la derive avec des cli/sti -> aucune derive constatee !!! Pourquoi ???
// Sleep doit etre cool avec les interuptions horloge !
//asm cli end;
//Sleep(1000);
//asm sti end;

Result:=True;
end;

// Caracteristiques
function TCameraVirtual.GetName:PChar;
begin
Result:=PChar('Caméra Virtuelle'); //nolang
end;

function TCameraVirtual.GetSaturationLevel:Integer;
begin
Result:=32767;
end;

function TCameraVirtual.GetXSize:Integer;
begin
Result:=768;
end;

function TCameraVirtual.GetYSize:Integer;
begin
Result:=512;
end;

function TCameraVirtual.GetXPixelSize:Double;
begin
Result:=9;
end;

function TCameraVirtual.GetYPixelSize:Double;
begin
Result:=9;
end;

function TCameraVirtual.IsAValidBinning(Binning:Byte):Boolean;
begin
Result:=False;
if (Binning=1) or (Binning=2) or (Binning=3) then Result:=True;
end;

function TCameraVirtual.HasTemperature:Boolean;
begin
Result:=False;
end;

function TCameraVirtual.CanCutAmpli:Boolean;
begin
Result:=False;
end;

function TCameraVirtual.NeedEmptyingDelay:Boolean;
begin
Result:=False;
end;

function TCameraVirtual.NeedReadingDelay:Boolean;
begin
Result:=False;
end;

function TCameraVirtual.NeedCloseShutterDelay:Boolean;
begin
Result:=False;
end;

function TCameraVirtual.HasAShutter:Boolean;
begin
Result:=False;
end;

procedure TCameraVirtual.GetCCDDateBegin(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeBegin,Year,Month,Day);
end;

procedure TCameraVirtual.GetCCDTimeBegin(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeBegin,Hour,Min,Sec,MSec);
end;

procedure TCameraVirtual.GetCCDDateEnd(var Year,Month,Day:Word);
begin
DecodeDate(DateTimeEnd,Year,Month,Day);
end;

procedure TCameraVirtual.GetCCDTimeEnd(var Hour,Min,Sec,MSec:Word);
begin
DecodeTime(DateTimeEnd,Hour,Min,Sec,MSec);
end;

procedure TCameraVirtual.SetHourServer(ServerAdress:Pointer);
begin
HourServerAdress:=ServerAdress;
end;

procedure TCameraVirtual.SetPCMinusUT(PCMinusUT:Double);
begin
// Pas besoin en interne pour l'instant
end;

function TCameraVirtual.ShowCfgWindow:Boolean;
begin
Result:=True;
end;

function TCameraVirtual.IsTrackCCD:Boolean;
begin
Result:=False;
end;

function TCameraVirtual.NeedPixelSize:Boolean;
begin
Result:=False;
end;

function TCameraVirtual.Is16Bits:Boolean;
begin
Result:=False;
end;

function TCameraVirtual.HasCfgWindow:Boolean;
begin
Result:=False;
end;

begin
TesteFocalisation:=False;
end.



