unit u_hour_servers;

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

uses Windows;

type

//******************************************************************************
//**********************       Serveur d'heure Generique      ******************
//******************************************************************************

  THourServer=class(TObject)
    private
    InReadIntervalTimeout         : DWord;
    InReadTotalTimeoutMultiplier  : DWord;
    InReadTotalTimeoutConstant    : DWord;
    InWriteTotalTimeoutMultiplier : DWord;
    InWriteTotalTimeoutConstant   : DWord;

    NomCom                        : string;
    HCom                          : Integer;
    BaudRate                      : DWord;
    ByteSize                      : Byte ;
    Parity                        : Byte ;
    StopBits                      : Byte ;

    Busy:Boolean;

    public

    constructor Create;
    procedure Open; virtual; abstract;
    procedure Close; virtual; abstract;
    function UseComPort:Boolean; virtual; abstract;
    procedure OpenSerialPort; virtual; abstract;
    procedure CloseSerialPort; virtual; abstract;
    function IsConnectedAndOK:Boolean; virtual; abstract;
    function CanBeUsedToSetPCHour:Boolean; virtual; abstract;
    function HasEventInCaps:Boolean; virtual; abstract;
    function HasEventOutCaps:Boolean; virtual; abstract;
    function CanSetHour:Boolean; virtual; abstract;
    function CanGetCoordinates:Boolean; virtual; abstract;

    // Reglages
    procedure SetComPort(ComPort:PChar); virtual; abstract;
    procedure SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                   _ReadTotalTimeoutMultiplier:DWord;
                                   _ReadTotalTimeoutConstant:DWord;
                                   _WriteTotalTimeoutMultiplier:DWord;
                                   _WriteTotalTimeoutConstant:DWord); virtual; abstract;
    procedure SetSerialPortComm(_BaudRate:DWord;
                                _ByteSize:Byte;
                                _Parity:Byte;
                                _StopBits:Byte); virtual; abstract;

    function GetName:PChar; virtual; abstract;
    procedure SetPCMinusUT(PCMinusUT:Double); virtual; abstract;
    function GetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean; virtual; abstract;
    function SetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean; virtual; abstract;

    function SetEventInOn:Boolean; virtual; abstract;
    function SetEventInOff:Boolean; virtual; abstract;
    function GetEventIn(var Hour,Min,Sec,MSec:Word):Boolean; virtual; abstract;
    function SetEventOutOn:Boolean; virtual; abstract;
    function SetEventOutOff:Boolean; virtual; abstract;
    function SetEventOut(Hour,Min,Sec,Nb,Interval:Word):Boolean; virtual; abstract;
    function GetCoordinates(var Lat,Long:Double):Boolean; virtual; abstract;

    end;

//******************************************************************************
//**********************        Serveur d'heure CMOS          ******************
//******************************************************************************

  THourServerCMOS=class(THourServer)
    private
    public

    constructor Create;

    procedure Open; override;
    procedure Close; override;
    procedure OpenSerialPort; override;
    procedure CloseSerialPort; override;
    function UseComPOrt:Boolean; override;
    function IsConnectedAndOK:Boolean; override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    function CanBeUsedToSetPCHour:Boolean; override;
    function HasEventInCaps:Boolean; override;
    function HasEventOutCaps:Boolean; override;
    function CanSetHour:Boolean; override;
    function CanGetCoordinates:Boolean; override;

    // Reglages
    procedure SetComPort(ComPort:PChar); override;
    procedure SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                   _ReadTotalTimeoutMultiplier:DWord;
                                   _ReadTotalTimeoutConstant:DWord;
                                   _WriteTotalTimeoutMultiplier:DWord;
                                   _WriteTotalTimeoutConstant:DWord); override;
    procedure SetSerialPortComm(_BaudRate:DWord;
                                _ByteSize:Byte;
                                _Parity:Byte;
                                _StopBits:Byte); override;

    function GetName:PChar; override;
    function GetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean; override;
    function SetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean; override;

    function SetEventInOn:Boolean; override;
    function SetEventInOff:Boolean; override;
    function GetEventIn(var Hour,Min,Sec,MSec:Word):Boolean; override;
    function SetEventOutOn:Boolean; override;
    function SetEventOutOff:Boolean; override;
    function SetEventOut(Hour,Min,Sec,Nb,Interval:Word):Boolean; override;
    function GetCoordinates(var Lat,Long:Double):Boolean; override;

    end;

//******************************************************************************
//**********************        Serveur d'heure CMOS 2        ******************
//******************************************************************************

  THourServerCMOS2=class(THourServer)
    private
    public

    constructor Create;

    procedure Open; override;
    procedure Close; override;
    procedure OpenSerialPort; override;
    procedure CloseSerialPort; override;
    function UseComPOrt:Boolean; override;
    function IsConnectedAndOK:Boolean; override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    function CanBeUsedToSetPCHour:Boolean; override;
    function HasEventInCaps:Boolean; override;
    function HasEventOutCaps:Boolean; override;
    function CanSetHour:Boolean; override;
    function CanGetCoordinates:Boolean; override;    
    
    // Reglages
    procedure SetComPort(ComPort:PChar); override;
    procedure SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                   _ReadTotalTimeoutMultiplier:DWord;
                                   _ReadTotalTimeoutConstant:DWord;
                                   _WriteTotalTimeoutMultiplier:DWord;
                                   _WriteTotalTimeoutConstant:DWord); override;
    procedure SetSerialPortComm(_BaudRate:DWord;
                                _ByteSize:Byte;
                                _Parity:Byte;
                                _StopBits:Byte); override;

    function GetName:PChar; override;
    function GetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean; override;
    function SetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean; override;

    function SetEventInOn:Boolean; override;
    function SetEventInOff:Boolean; override;
    function GetEventIn(var Hour,Min,Sec,MSec:Word):Boolean; override;
    function SetEventOutOn:Boolean; override;
    function SetEventOutOff:Boolean; override;
    function SetEventOut(Hour,Min,Sec,Nb,Interval:Word):Boolean; override;
    function GetCoordinates(var Lat,Long:Double):Boolean; override;    

    end;

//******************************************************************************
//**********************        Serveur d'heure Windows       ******************
//******************************************************************************

  THourServerWindows=class(THourServer)
    private
    public

    constructor Create;

    procedure Open; override;
    procedure Close; override;
    procedure OpenSerialPort; override;
    procedure CloseSerialPort; override;
    function UseComPOrt:Boolean; override;
    function IsConnectedAndOK:Boolean; override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    function CanBeUsedToSetPCHour:Boolean; override;
    function HasEventInCaps:Boolean; override;
    function HasEventOutCaps:Boolean; override;
    function CanSetHour:Boolean; override;
    function CanGetCoordinates:Boolean; override;    
    
    // Reglages
    procedure SetComPort(ComPort:PChar); override;
    procedure SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                   _ReadTotalTimeoutMultiplier:DWord;
                                   _ReadTotalTimeoutConstant:DWord;
                                   _WriteTotalTimeoutMultiplier:DWord;
                                   _WriteTotalTimeoutConstant:DWord); override;
    procedure SetSerialPortComm(_BaudRate:DWord;
                                _ByteSize:Byte;
                                _Parity:Byte;
                                _StopBits:Byte); override;

    function GetName:PChar; override;
    function GetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean; override;
    function SetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean; override;

    function SetEventInOn:Boolean; override;
    function SetEventInOff:Boolean; override;
    function GetEventIn(var Hour,Min,Sec,MSec:Word):Boolean; override;
    function SetEventOutOn:Boolean; override;
    function SetEventOutOff:Boolean; override;
    function SetEventOut(Hour,Min,Sec,Nb,Interval:Word):Boolean; override;
    function GetCoordinates(var Lat,Long:Double):Boolean; override;    

    end;

//******************************************************************************
//**********************        Serveur d'heure Windows       ******************
//******************************************************************************

  THourServerEventMarker=class(THourServer)
    private
    public

    constructor Create;

    procedure Open; override;
    procedure Close; override;
    procedure OpenSerialPort; override;
    procedure CloseSerialPort; override;
    function UseComPOrt:Boolean; override;
    function IsConnectedAndOK:Boolean; override;
    procedure SetPCMinusUT(PCMinusUT:Double); override;
    function CanBeUsedToSetPCHour:Boolean; override;
    function HasEventInCaps:Boolean; override;
    function HasEventOutCaps:Boolean; override;
    function CanSetHour:Boolean; override;
    function CanGetCoordinates:Boolean; override;    
    
    // Reglages
    procedure SetComPort(ComPort:PChar); override;
    procedure SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                   _ReadTotalTimeoutMultiplier:DWord;
                                   _ReadTotalTimeoutConstant:DWord;
                                   _WriteTotalTimeoutMultiplier:DWord;
                                   _WriteTotalTimeoutConstant:DWord); override;
    procedure SetSerialPortComm(_BaudRate:DWord;
                                _ByteSize:Byte;
                                _Parity:Byte;
                                _StopBits:Byte); override;

    function GetName:PChar; override;
    function GetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean; override;
    function SetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean; override;

    function SetEventInOn:Boolean; override;
    function SetEventInOff:Boolean; override;
    function GetEventIn(var Hour,Min,Sec,MSec:Word):Boolean; override;
    function SetEventOutOn:Boolean; override;
    function SetEventOutOff:Boolean; override;
    function SetEventOut(Hour,Min,Sec,Nb,Interval:Word):Boolean; override;
    function GetCoordinates(var Lat,Long:Double):Boolean; override;    

    end;

  procedure GetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word);
  function GetHourDT:TDateTime;
  function GetRealDateTime2:TDateTime;

  procedure HourServerConnect;
  procedure HourServerDisconnect;

var
   HourServer:THourServer;

implementation

uses u_general,
     sysutils,
     u_class,
     u_file_io,
     u_lang,
     pu_main,
     pu_hour_server;

//******************************************************************************
//****************** Interface serveur d'heure de haut niveau ******************
//******************************************************************************
// Remplace pop_main.update_hourserver
// Choses à faire pour connecter le serveur d'heure
procedure HourServerConnect;
begin
   try
   try
   // Verification si un serveur d'heure est branche
   Config.HourServerBranche:=False;
   // Config du serveur d'heure
   case Config.TypeHourServer of
      0:HourServer:=THourServerCMOS.Create;
      1:HourServer:=THourServerCMOS2.Create;
      2:HourServer:=THourServerWindows.Create;
      3:HourServer:=THourServerEventMarker.Create;
      //Penser a mettre a jour procedure Tpop_conf.UdpateHourServer;
      end;

   if HourServer.UseComPort then
      begin
      HourServer.SetComPort(PChar(Config.HourServerComPort));
      HourServer.SetSerialPortTimeOut(config.HourServerReadIntervalTimeout,
                                      config.HourServerReadTotalTimeoutMultiplier,
                                      config.HourServerReadTotalTimeoutConstant,
                                      config.HourServerWriteTotalTimeoutMultiplier,
                                      config.HourServerWriteTotalTimeoutConstant);
      HourServer.SetSerialPortComm(9600,8,0,0);
      HourServer.OpenSerialPort;
      end;

   Config.HourServerBranche:=HourServer.IsConnectedAndOK;
   HourServer.Open;

   if HourServer.CanGetCoordinates then
      HourServer.GetCoordinates(Config.Lat,Config.Long);

   except
   Config.HourServerBranche:=False;
   end

   finally
   pop_main.UpdateGUIHourServer;
   end;
end;

// Choses à faire pour déconnecter le serveur d'heure
procedure HourServerDisconnect;
begin
   try

   if Config.HourServerBranche then
      begin
      HourServer.Close;
      if HourServer.UseComPort then HourServer.CloseSerialPort;
      HourServer.Free;
      Config.HourServerBranche:=False;

      if pop_hour_server.Visible then
         begin
         pop_hour_server.Hide;
         pop_main.ToolButton9.Down:=False;
         end;

      end;

   finally
   pop_main.UpdateGUIHourServer;
   end;
end;

procedure GetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word);
var
   DT:TDateTime;
begin
   try
   if Config.HourServerBranche then
      begin
      HourServer.GetHour(Year,Month,Day,Hour,Min,Sec,MSec);
      end
   else
      begin
      Config.HourServerBranche:=False;
      DT:=GetRealDateTime;
      DecodeDate(DT,Year,Month,Day);
      DecodeTime(DT,Hour,Min,Sec,MSec);
      end;

   except
   HourServerDisconnect;
   DT:=GetRealDateTime;
   DecodeDate(DT,Year,Month,Day);
   DecodeTime(DT,Hour,Min,Sec,MSec);
   end;

end;

function GetHourDT:TDateTime;
var
   Year,Month,Day,Hour,Min,Sec,MSec:Word;
begin
try
// Ne pas enlever ce test hyper capital
// Dans pop_conf, HourServer est libéré !
//if not(Config.inPopConf) then
//   begin
   if Config.HourServerBranche then
      begin
      HourServer.GetHour(Year,Month,Day,Hour,Min,Sec,MSec);
      if Year=0 then
         begin
         WriteSpy(lang('Erreur dans GetHourDT'));
         Result:=0;
         end
      else Result:=EncodeDate(Year,Month,Day)+EncodeTime(Hour,Min,Sec,MSec);
      end
   else Result:=GetRealDateTime2;
//   end;
except
HourServerDisconnect;
Result:=GetRealDateTime2;
end;
end;

function GetRealDateTime2:TDateTime;
var
   WHour,WMin,WSec,WMSec:Word;
   Heure1,Heure2:Word;
   Siecles,Annees,Mois,Jours:Byte;
   DSeconde:Double;
   WAnnees,WMois,WJours:Word;
begin
   Result:=0;
   case Config.TypeOS of
      0:begin
        asm
        // Heure
        mov ah,$00
        int $1a
        mov Heure1,cx
        mov Heure2,dx

        // Date
        mov ah,04
        int $1a
        mov Siecles,ch
        mov Annees,cl
        mov Mois,dh
        mov Jours,dl
        end;

        WAnnees:=(((Siecles and $f0) shr 4)*10+(Siecles and $0f))*100+((Annees and $f0) shr 4)*10+(Annees and $0f);
//        WYear:=Round(WAnnees);
        WMois:=((Mois and $f0) shr 4)*10+(Mois and $0f);
//        WMonth:=Round(WMois);
        WJours:=((Jours and $f0) shr 4)*10+(Jours and $0f);
//        WDay:=Round(WJours);

        DSeconde:=(Heure1*65536+Heure2)/18.2;
        WMSec:=Round(Frac(DSeconde)*1000);
        DSeconde:=Int(DSeconde)/60; // Passage en minutes
        WSec:=Round(Frac(DSeconde)*60);
        DSeconde:=Int(DSeconde)/60; // Passage en heures
        WMin:=Round(Frac(DSeconde)*60);
        WHour:=Trunc(DSeconde);
        Result:=EncodeTime(WHour,WMin,WSec,WMsec)+EncodeDate(WAnnees,WMois,WJours)-config.PCMoinsTU/24;
        end;
      1:Result:=Now-config.PCMoinsTU/24;
   end;
end;

//******************************************************************************
//**********************       Serveur d'heure Generique      ******************
//******************************************************************************

// FONCTIONS DE BAS NIVEAU PRESENTES DANS LE PLUGIN
constructor THourServer.Create;
begin
   inherited Create;
end;

//******************************************************************************
//**********************        Serveur d'heure CMOS          ******************
//******************************************************************************

// FONCTIONS DE BAS NIVEAU PRESENTES DANS LE PLUGIN
constructor THourServerCMOS.Create;
begin
   inherited Create;
end;

procedure THourServerCMOS.SetComPort(ComPort:PChar);
begin
//Rien a faire
end;

procedure THourServerCMOS.SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                    _ReadTotalTimeoutMultiplier:DWord;
                                    _ReadTotalTimeoutConstant:DWord;
                                    _WriteTotalTimeoutMultiplier:DWord;
                                    _WriteTotalTimeoutConstant:DWord);
begin
//Rien a faire
end;

procedure THourServerCMOS.SetSerialPortComm(_BaudRate:DWord;
                                 _ByteSize:Byte;
                                 _Parity:Byte;
                                 _StopBits:Byte);
begin
//Rien a faire
end;

procedure THourServerCMOS.Open;
begin
//Rien a faire
end;

procedure THourServerCMOS.Close;
begin
//Rien a faire
end;

function THourServerCMOS.UseComPOrt:Boolean;
begin
Result:=False;
end;

function THourServerCMOS.IsConnectedAndOK:Boolean;
begin
//Rien a faire
Result:=True;
end;

procedure THourServerCMOS.SetPCMinusUT(PCMinusUT:Double);
begin
// Rien en interne
end;

function THourServerCMOS.CanBeUsedToSetPCHour:Boolean;
begin
Result:=False;
end;

function THourServerCMOS.HasEventInCaps:Boolean;
begin
Result:=False;
end;

function THourServerCMOS.HasEventOutCaps:Boolean;
begin
Result:=False;
end;

procedure THourServerCMOS.OpenSerialPort;
begin
//Rien a faire
end;

procedure THourServerCMOS.CloseSerialPort;
begin
//Rien a faire
end;

function THourServerCMOS.GetName:PChar;
begin
Result:=PChar('CMOS $02 $04'); //nolang
end;

function THourServerCMOS.GetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean;
var
   Heures,Minutes,Secondes,Siecles,Annees,Mois,Jours:Byte;
   WHeures,WMinutes,WSecondes,WAnnees,WMois,WJours:Word;
   DT:TDateTime;
begin
   Result:=True;
   case Config.TypeOS of
      0:begin
        asm
        cli

        // Heure
        mov ah,02
        int $1a
        mov Heures,ch
        mov Minutes,cl
        mov Secondes,dh

        // Date
        mov ah,04
        int $1a
        mov Siecles,ch
        mov Annees,cl
        mov Mois,dh
        mov Jours,dl

        sti
        end;

        // Convertion de BCD
        WHeures:=((Heures and $f0) shr 4)*10+(Heures and $0f);
        WMinutes:=((Minutes and $f0) shr 4)*10+(Minutes and $0f);
        WSecondes:=((Secondes and $f0) shr 4)*10+(Secondes and $0f);
        WAnnees:=(((Siecles and $f0) shr 4)*10+(Siecles and $0f))*100+((Annees and $f0) shr 4)*10+(Annees and $0f);
        WMois:=((Mois and $f0) shr 4)*10+(Mois and $0f);
        WJours:=((Jours and $f0) shr 4)*10+(Jours and $0f);
        DT:=EncodeTime(WHeures,WMinutes,WSecondes,0)+EncodeDate(WAnnees,WMois,WJours)-config.PCMoinsTU/24;
        end;
      1:DT:=Now-config.PCMoinsTU/24;
   end;
   DecodeDate(DT,Year,Month,Day);
   DecodeTime(DT,Hour,Min,Sec,MSec);
end;

function THourServerCMOS.SetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean;
var
   DT:TDateTime;
begin
Result:=True;
try
DT:=EncodeDate(Year,Month,Day)+EncodeTime(Hour,Min,Sec,MSec);
MajSystemTime(DT);
except
Result:=False;
end;
end;

function THourServerCMOS.CanSetHour:Boolean;
begin
Result:=True;
end;

function THourServerCMOS.CanGetCoordinates:Boolean;
begin
Result:=False;
end;

function THourServerCMOS.SetEventInOn:Boolean;
begin
Result:=False;
end;

function THourServerCMOS.SetEventInOff:Boolean;
begin
Result:=False;
end;

function THourServerCMOS.SetEventOutOn:Boolean;
begin
Result:=False;
end;

function THourServerCMOS.SetEventOutOff:Boolean;
begin
Result:=False;
end;

function THourServerCMOS.GetEventIn(var Hour,Min,Sec,MSec:Word):Boolean;
begin
Result:=False;
end;

function THourServerCMOS.SetEventOut(Hour,Min,Sec,Nb,Interval:Word):Boolean;
begin
Result:=False;
end;

function THourServerCMOS.GetCoordinates(var Lat,Long:Double):Boolean;
begin
Lat:=0;
Long:=0;
Result:=True;
end;

//******************************************************************************
//**********************        Serveur d'heure CMOS 2        ******************
//******************************************************************************

// FONCTIONS DE BAS NIVEAU PRESENTES DANS LE PLUGIN
constructor THourServerCMOS2.Create;
begin
   inherited Create;
end;

procedure THourServerCMOS2.SetComPort(ComPort:PChar);
begin
//Rien a faire
end;

procedure THourServerCMOS2.SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                    _ReadTotalTimeoutMultiplier:DWord;
                                    _ReadTotalTimeoutConstant:DWord;
                                    _WriteTotalTimeoutMultiplier:DWord;
                                    _WriteTotalTimeoutConstant:DWord);
begin
//Rien a faire
end;

procedure THourServerCMOS2.SetSerialPortComm(_BaudRate:DWord;
                                 _ByteSize:Byte;
                                 _Parity:Byte;
                                 _StopBits:Byte);
begin
//Rien a faire
end;

procedure THourServerCMOS2.Open;
begin
//Rien a faire
end;

procedure THourServerCMOS2.Close;
begin
//Rien a faire
end;

function THourServerCMOS2.UseComPOrt:Boolean;
begin
Result:=False;
end;

function THourServerCMOS2.IsConnectedAndOK:Boolean;
begin
//Rien a faire
Result:=True;
end;

procedure THourServerCMOS2.SetPCMinusUT(PCMinusUT:Double);
begin
// Rien en interne
end;

function THourServerCMOS2.CanBeUsedToSetPCHour:Boolean;
begin
Result:=False;
end;

function THourServerCMOS2.HasEventInCaps:Boolean;
begin
Result:=True;
end;

function THourServerCMOS2.HasEventOutCaps:Boolean;
begin
Result:=True;
end;

procedure THourServerCMOS2.OpenSerialPort;
begin
//Rien a faire
end;

procedure THourServerCMOS2.CloseSerialPort;
begin
//Rien a faire
end;

function THourServerCMOS2.GetName:PChar;
begin
Result:=PChar('CMOS $00 $04'); //nolang
end;

function THourServerCMOS2.GetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean;
var
   DT:TDateTime;
   WHour,WMin,WSec,WMSec:Word;
   Heure1,Heure2:Word;
   Siecles,Annees,Mois,Jours:Byte;
   DSeconde:Double;
   WAnnees,WMois,WJours:Word;
begin
   Result:=True;
   case Config.TypeOS of
      0:begin
        asm
        // Heure
        mov ah,$00
        int $1a
        mov Heure1,cx
        mov Heure2,dx

        // Date
        mov ah,04
        int $1a
        mov Siecles,ch
        mov Annees,cl
        mov Mois,dh
        mov Jours,dl
        end;

        try
        WAnnees:=(((Siecles and $f0) shr 4)*10+(Siecles and $0f))*100+((Annees and $f0) shr 4)*10+(Annees and $0f);
//        WYear:=Round(WAnnees);
        WMois:=((Mois and $f0) shr 4)*10+(Mois and $0f);
//        WMonth:=Round(WMois);
        WJours:=((Jours and $f0) shr 4)*10+(Jours and $0f);
//        WDay:=Round(WJours);

        DSeconde:=(Heure1*65536+Heure2)/18.20648193;
        if Frac(DSeconde)>0.999 then DSeconde:=Int(DSeconde)+0.999;
        WMSec:=Round(Frac(DSeconde)*1000);
        DSeconde:=Int(DSeconde)/60; // Passage en minutes
        WSec:=Round(Frac(DSeconde)*60);
        DSeconde:=Int(DSeconde)/60; // Passage en heures
        WMin:=Round(Frac(DSeconde)*60);
        WHour:=Trunc(DSeconde);
        DT:=EncodeTime(WHour,WMin,WSec,WMsec)+EncodeDate(WAnnees,WMois,WJours)-config.PCMoinsTU/24;
        except
        WriteSpy(lang('Annee = ')+IntToSTr(WAnnees));
        WriteSpy(lang('Mois = ')+IntToSTr(WMois));
        WriteSpy(lang('Jours = ')+IntToSTr(WJours));
        WriteSpy(lang('Heure = ')+IntToSTr(WHour));
        WriteSpy(lang('Minutes = ')+IntToSTr(WMin));
        WriteSpy(lang('Secondes = ')+IntToSTr(WSec));
        WriteSpy(lang('MilliSecondes = ')+IntToSTr(WMSec));
        end;
        end;
      1:DT:=Now-config.PCMoinsTU/24;
   end;
   DecodeDate(DT,Year,Month,Day);
   DecodeTime(DT,Hour,Min,Sec,MSec);
end;

function THourServerCMOS2.SetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean;
var
   DT:TDateTime;
begin
DT:=EncodeDate(Year,Month,Day)+EncodeTime(Hour,Min,Sec,MSec);
MajSystemTime(DT);
end;

function THourServerCMOS2.CanSetHour:Boolean;
begin
Result:=True;
end;

function THourServerCMOS2.CanGetCoordinates:Boolean;
begin
Result:=False;
end;

function THourServerCMOS2.SetEventInOn:Boolean;
begin
Result:=False;
end;

function THourServerCMOS2.SetEventInOff:Boolean;
begin
Result:=False;
end;

function THourServerCMOS2.SetEventOutOn:Boolean;
begin
Result:=False;
end;

function THourServerCMOS2.SetEventOutOff:Boolean;
begin
Result:=False;
end;

function THourServerCMOS2.GetEventIn(var Hour,Min,Sec,MSec:Word):Boolean;
begin
Result:=False;
end;

function THourServerCMOS2.SetEventOut(Hour,Min,Sec,Nb,Interval:Word):Boolean;
begin
Result:=False;
end;

function THourServerCMOS2.GetCoordinates(var Lat,Long:Double):Boolean;
begin
Lat:=0;
Long:=0;
Result:=True;
end;

//******************************************************************************
//**********************        Serveur d'heure Windows       ******************
//******************************************************************************

// FONCTIONS DE BAS NIVEAU PRESENTES DANS LE PLUGIN
constructor THourServerWindows.Create;
begin
   inherited Create;
end;

procedure THourServerWindows.SetComPort(ComPort:PChar);
begin
//Rien a faire
end;

procedure THourServerWindows.SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
                                    _ReadTotalTimeoutMultiplier:DWord;
                                    _ReadTotalTimeoutConstant:DWord;
                                    _WriteTotalTimeoutMultiplier:DWord;
                                    _WriteTotalTimeoutConstant:DWord);
begin
//Rien a faire
end;

procedure THourServerWindows.SetSerialPortComm(_BaudRate:DWord;
                                 _ByteSize:Byte;
                                 _Parity:Byte;
                                 _StopBits:Byte);
begin
//Rien a faire
end;

procedure THourServerWindows.Open;
begin
//Rien a faire
end;

procedure THourServerWindows.Close;
begin
//Rien a faire
end;

function THourServerWindows.UseComPOrt:Boolean;
begin
Result:=False;
end;

function THourServerWindows.IsConnectedAndOK:Boolean;
begin
//Rien a faire
Result:=True;
end;

procedure THourServerWindows.SetPCMinusUT(PCMinusUT:Double);
begin
// Rien en interne
end;

function THourServerWindows.CanBeUsedToSetPCHour:Boolean;
begin
Result:=False;
end;

function THourServerWindows.HasEventInCaps:Boolean;
begin
Result:=False;
end;

function THourServerWindows.HasEventOutCaps:Boolean;
begin
Result:=False;
end;

procedure THourServerWindows.OpenSerialPort;
begin
//Rien a faire
end;

procedure THourServerWindows.CloseSerialPort;
begin
//Rien a faire
end;

function THourServerWindows.GetName:PChar;
begin
Result:=PChar('Windows'); //nolang
end;

function THourServerWindows.GetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean;
var
   DT:TDateTime;
begin
   Result:=True;
   DT:=Now-config.PCMoinsTU/24;
   DecodeDate(DT,Year,Month,Day);
   DecodeTime(DT,Hour,Min,Sec,MSec);
end;

function THourServerWindows.SetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean;
var
   DT:TDateTime;
begin
DT:=EncodeDate(Year,Month,Day)+EncodeTime(Hour,Min,Sec,MSec);
MajSystemTime(DT);
end;

function THourServerWindows.CanSetHour:Boolean;
begin
Result:=True;
end;

function THourServerWindows.CanGetCoordinates:Boolean;
begin
Result:=False;
end;

function THourServerWindows.SetEventInOn:Boolean;
begin
Result:=False;
end;

function THourServerWindows.SetEventInOff:Boolean;
begin
Result:=False;
end;

function THourServerWindows.SetEventOutOn:Boolean;
begin
Result:=False;
end;

function THourServerWindows.SetEventOutOff:Boolean;
begin
Result:=False;
end;

function THourServerWindows.GetEventIn(var Hour,Min,Sec,MSec:Word):Boolean;
begin
Result:=False;
end;

function THourServerWindows.SetEventOut(Hour,Min,Sec,Nb,Interval:Word):Boolean;
begin
Result:=False;
end;

function THourServerWindows.GetCoordinates(var Lat,Long:Double):Boolean;
begin
Lat:=0;
Long:=0;
Result:=True;
end;

//******************************************************************************
//**********************     Serveur d'heure Event Marker     ******************
//******************************************************************************

// FONCTIONS DE BAS NIVEAU PRESENTES DANS LE PLUGIN
constructor THourServerEventMarker.Create;
begin
   inherited Create;
end;

procedure THourServerEventMarker.SetComPort(ComPort:PChar);
begin
   NomCom:=ComPort;
end;

procedure THourServerEventMarker.SetSerialPortTimeOut(_ReadIntervalTimeout:DWord;
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

procedure THourServerEventMarker.SetSerialPortComm(_BaudRate:DWord;
                                 _ByteSize:Byte;
                                 _Parity:Byte;
                                 _StopBits:Byte);
begin
   BaudRate:=_BaudRate;
   ByteSize:=_ByteSize;
   Parity:=_Parity;
   StopBits:=_StopBits;
end;

procedure THourServerEventMarker.Open;
var
   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   MyMessage:string;
begin
while Busy do;
Busy:=True;

PurgeComm(hCom,PURGE_TXCLEAR);
PurgeComm(hCom,PURGE_RXCLEAR);
FlushFileBuffers(hCom);

// Ecriture : u 0+CR
BufWrite[0]:='u';
BufWrite[1]:=' ';
BufWrite[2]:='0';
BufWrite[3]:=#13;
WriteFile(hCom,BufWrite[0],4,NumberOfBytesWrite,nil);
   // On trace
   if NumberOfBytesWrite<>4 then
      begin
      CloseSerialPort;
      MyMessage:='HourServerEventMarkerIsConnectedAndOK : '+ //nolang
         'Le serveur d''heure n''accepte pas le réglage de l''offset';
      WriteSpy(MyMessage);
      raise MyError.Create(MyMessage);
      end;

ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);

Busy:=False;
end;

procedure THourServerEventMarker.Close;
begin
//Rien a faire
end;

function THourServerEventMarker.UseComPort:Boolean;
begin
Result:=True;
end;

function THourServerEventMarker.IsConnectedAndOK:Boolean;
var
   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   Line,MyMessage:string;
   i:Integer;
begin
Result:=True;

while Busy do;
Busy:=True;

PurgeComm(hCom,PURGE_TXCLEAR);
PurgeComm(hCom,PURGE_RXCLEAR);
FlushFileBuffers(hCom);

// Ecriture : r
BufWrite[0]:='r';
WriteFile(hCom,BufWrite[0],1,NumberOfBytesWrite,nil);
   // On trace
   if NumberOfBytesWrite<>1 then
      begin
      CloseSerialPort;
      Result:=False;
      MyMessage:='HourServerEventMarkerIsConnectedAndOK : '+ //nolang
         'Le serveur d''heure n''accepte pas la demande de date';
      WriteSpy(MyMessage);
      raise MyError.Create(MyMessage);
      end;

ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
// Lecture : C= si heure OK / Rien si heure pas OK ?
if NumberOfBytesRead=0 then Result:=False
else
   begin
   // On trace
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for i:=1 to NumberOfBytesRead do Line[i]:=BufRead[i-1];
   WriteSpy(lang('Réception de : /')+Line+'/');
   WriteSpy(lang('Connection avec le serveur d''heure réussie'));   
   end;

Busy:=False;
end;

procedure THourServerEventMarker.SetPCMinusUT(PCMinusUT:Double);
begin
// Rien en interne
end;

function THourServerEventMarker.CanBeUsedToSetPCHour:Boolean;
begin
Result:=True;
end;

function THourServerEventMarker.HasEventInCaps:Boolean;
begin
Result:=True;
end;

function THourServerEventMarker.HasEventOutCaps:Boolean;
begin
Result:=True;
end;

procedure THourServerEventMarker.OpenSerialPort;
var
   Errb:Boolean;
   DCB:TDCB;
   CommTimeouts:TCommTimeouts;
begin
   HCom:=CreateFile(PChar(NomCom),GENERIC_READ or GENERIC_WRITE,0,Nil,OPEN_EXISTING,0,0);
   Errb:=GetCommState(hCom,DCB);
   if not Errb then
        raise ErrorPortSerie.Create('HourServerEventMarkerOpenSerialPort :'+ //Nolang
           'Impossible d''ouvrir le port série '+NomCom);

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

procedure THourServerEventMarker.CloseSerialPort;
begin
    // On purge au cas ou il y a des restes
   PurgeComm(hCom,PURGE_TXCLEAR);
   PurgeComm(hCom,PURGE_RXCLEAR);
   CloseHandle(hCom);
end;

function THourServerEventMarker.GetName:PChar;
begin
Result:=PChar('Event Marker'); //nolang
end;

function THourServerEventMarker.GetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean;
var
   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   Line,MyMessage:string;
   i:Integer;
   DT:TDateTime;
   WYear,WMonth,WDay,WHour,WMin,WSec,WMSec:Word;
begin
   Result:=True;
// demande : d
// Reponse : JJ/MM/AA c=
// entre AA et c= on trouve CR+LF qui apperement de fait qu'un seul caractere a lire
// Avant JJ, on a un caractere a lire
   while Busy do;
   Busy:=True;
   Result:=True;

//   DT:=Now;
//   DecodeDate(DT,WYear,WMonth,WDay);

   PurgeComm(hCom,PURGE_TXCLEAR);
   PurgeComm(hCom,PURGE_RXCLEAR);
   FlushFileBuffers(hCom);

   BufWrite[0]:='d';
   WriteFile(hCom,BufWrite[0],1,NumberOfBytesWrite,nil);
   if NumberOfBytesWrite<>1 then
      begin
      CloseSerialPort;
      Result:=False;
      MyMessage:='Error HourServerEventMarkerGetHour : '+ //nolang
         'Le serveur d''heure n''accepte pas la demande de date';
      WriteSpy(MyMessage);
      raise MyError.Create(MyMessage);
      end;

   MySleep(100);
   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   if NumberOfBytesRead<>0 then
      begin
      // On trace
      Line:='';
      SetLength(Line,NumberOfBytesRead);
      for i:=1 to NumberOfBytesRead do Line[i]:=BufRead[i-1];
      WriteSpy(lang('Réception de : /')+Line+'/');

      WriteSpy('Date Day : /'+Copy(Line,1,2)+'/');  //nolang
      WriteSpy('Date Month : /'+Copy(Line,4,2)+'/');  //nolang
      WriteSpy('Date Year : /'+Copy(Line,7,2)+'/');  //nolang

      WDay:=StrToInt(Copy(Line,1,2));
      WMonth:=StrToInt(Copy(Line,4,2));
      WYear:=StrToInt(Copy(Line,7,2));
      end
   else
      begin
      CloseSerialPort;
      Result:=False;
      MyMessage:='HourServerEventMarkerGetHour : '+ //nolang
         lang('Le serveur ne reponds pas à la demande de date');
      WriteSpy(MyMessage);
      raise MyError.Create(MyMessage);
      end;

// demande : t
// Reponse : 00:00:00:000 c=

   BufWrite[0]:='t';
   WriteFile(hCom,BufWrite[0],1,NumberOfBytesWrite,nil);
   if NumberOfBytesWrite<>1 then
      begin
      CloseSerialPort;;
      Result:=False;
      MyMessage:='HourServerEventMarkerGetHour : '+ //nolang
         'Le serveur d''heure n''accepte pas la demande d''heure';
      WriteSpy(MyMessage);
      raise MyError.Create(MyMessage);
      end;


   MySleep(100);      
   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
   if NumberOfBytesRead<>0 then
      begin
      Line:='';
      SetLength(Line,NumberOfBytesRead);
      for i:=1 to NumberOfBytesRead do Line[i]:=BufRead[i-1];
      WriteSpy(lang('Réception de : /')+Line+'/');

      WriteSpy('Date Heure : /'+Copy(Line,1,2)+'/');  //nolang
      WriteSpy('Date Minutes : /'+Copy(Line,4,2)+'/');  //nolang
      WriteSpy('Date Secondes : /'+Copy(Line,7,2)+'/');  //nolang
      WriteSpy('Date MSecondes : /'+Copy(Line,10,3)+'/');  //nolang

      WHour:=StrToInt(Copy(Line,1,2));
      WMin:=StrToInt(Copy(Line,4,2));
      WSec:=StrToInt(Copy(Line,7,2));
      WMSec:=StrToInt(Copy(Line,10,3));
      end
   else
      begin
      CloseSerialPort;
      Result:=False;
      MyMessage:='HourServerEventMarkerGetHour : '+ //nolang
         'Le serveur ne reponds pas à la demande d''heure';
      WriteSpy(MyMessage);
      raise MyError.Create(MyMessage);
      end;

   DT:=EncodeTime(WHour,WMin,WSec,WMSec)+EncodeDate(2000+WYear,WMonth,WDay)-config.PCMoinsTU/24;
   DecodeDate(DT,Year,Month,Day);
   DecodeTime(DT,Hour,Min,Sec,MSec);

   WriteSpy('Verification');  //nolang
   WriteSpy(IntToStr(Day)+'/'+IntToStr(Month)+'/'+IntToStr(Year));
   WriteSpy(IntToStr(Hour)+':'+IntToStr(Min)+':'+IntToStr(Sec)+'.'+IntToStr(MSec));

   Busy:=False;
end;

function THourServerEventMarker.SetHour(var Year,Month,Day,Hour,Min,Sec,MSec:Word):Boolean;
{var
   MyMessage,Line,SYear,SMonth,SDay,SHour,SMin,SSec,SMSec:string;
   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   i,Longueur:Integer;}
begin
{while Busy do;
Busy:=True;
Result:=True;

PurgeComm(hCom,PURGE_TXCLEAR);
PurgeComm(hCom,PURGE_RXCLEAR);
FlushFileBuffers(hCom);

SMonth:=IntToStr(Month);
if Month<10 then SMonth:='0'+SMonth;
SDay:=IntToStr(Day);
if Day<10 then SDay:='0'+SDay;

Line:='D'+SDay+SMonth+'/';

Longueur:=Length(Line);
for i:=1 to Longueur do BufWrite[i-1]:=Line[i];
WriteFile(hCom,BufWrite[0],Longueur,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>Longueur then
   begin
   CloseSerialPort;
   Result:=False;
   MyMessage:='HourServerEventMarkerSetHour : '+ //nolang
      'Le serveur d''heure n''accepte pas le réglage de la date';
   WriteSpy(MyMessage);
   raise MyError.Create(MyMessage);
   end;

ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);

SHour:=IntToStr(Hour);
if Hour<10 then SHour:='0'+SHour;
SMin:=IntToStr(Min);
if Min<10 then SMin:='0'+SMin;
SSec:=IntToStr(Sec);
if Sec<10 then SSec:='0'+SSec;

Line:='T'+SHour+SMin+SSec+'/';

Longueur:=Length(Line);
for i:=1 to Longueur do BufWrite[i-1]:=Line[i];
WriteFile(hCom,BufWrite[0],Longueur,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>Longueur then
   begin
   CloseSerialPort;
   Result:=False;
   MyMessage:='HourServerEventMarkerSetHour : '+ //nolang
      'Le serveur d''heure n''accepte pas le réglage de l''heure';
   WriteSpy(MyMessage);
   raise MyError.Create(MyMessage);
   end;

ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
Busy:=False;}
end;

function THourServerEventMarker.CanSetHour:Boolean;
begin
Result:=False;
end;

function THourServerEventMarker.CanGetCoordinates:Boolean;
begin
Result:=True;
end;

function THourServerEventMarker.SetEventInOn:Boolean;
var
   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   MyMessage:string;
begin
while Busy do;
Busy:=True;

PurgeComm(hCom,PURGE_TXCLEAR);
PurgeComm(hCom,PURGE_RXCLEAR);

BufWrite[0]:='s';
WriteFile(hCom,BufWrite[0],1,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>1 then
   begin
   CloseSerialPort;
   Result:=False;
   MyMessage:='HourServerEventMarkerSetEventInOn : '+ //nolang
      'Le serveur d''heure n''accepte pas la commande';
   WriteSpy(MyMessage);
   raise MyError.Create(MyMessage);
   end;

ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
Busy:=False;
end;

function THourServerEventMarker.SetEventInOff:Boolean;
var
   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   MyMessage:string;
begin
while Busy do;
Busy:=True;
PurgeComm(hCom,PURGE_TXCLEAR);
PurgeComm(hCom,PURGE_RXCLEAR);

BufWrite[0]:='/';
WriteFile(hCom,BufWrite[0],1,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>1 then
   begin
   CloseSerialPort;
   Result:=False;
   MyMessage:='HourServerEventMarkerSetEventInOff : '+ //nolang
      'Le serveur d''heure n''accepte pas la commande';
   WriteSpy(MyMessage);
   raise MyError.Create(MyMessage);
   end;

ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
Busy:=False;
end;

function THourServerEventMarker.SetEventOutOn:Boolean;
var
   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   MyMessage:string;
begin
while Busy do;
Busy:=True;
PurgeComm(hCom,PURGE_TXCLEAR);
PurgeComm(hCom,PURGE_RXCLEAR);

BufWrite[0]:='m';
WriteFile(hCom,BufWrite[0],1,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>1 then
   begin
   CloseSerialPort;
   Result:=False;
   MyMessage:='HourServerEventMarkerSetEventOutOn : '+ //nolang
      'Le serveur d''heure n''accepte pas la commande';
   WriteSpy(MyMessage);
   raise MyError.Create(MyMessage);
   end;

ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
Busy:=False;
end;

function THourServerEventMarker.SetEventOutOff:Boolean;
var
   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   MyMessage:string;
begin
while Busy do;
Busy:=True;
PurgeComm(hCom,PURGE_TXCLEAR);
PurgeComm(hCom,PURGE_RXCLEAR);

BufWrite[0]:='/';
WriteFile(hCom,BufWrite[0],1,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>1 then
   begin
   CloseSerialPort;
   Result:=False;
   MyMessage:='HourServerEventMarkerSetEventOutOff : '+ //nolang
      'Le serveur d''heure n''accepte pas la commande';
   WriteSpy(MyMessage);
   raise MyError.Create(MyMessage);
   end;

ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
Busy:=False;
end;

function THourServerEventMarker.GetEventIn(var Hour,Min,Sec,MSec:Word):Boolean;
var
   Line:string;
   BufRead:array[0..99] of char;
   NumberOfBytesRead:Cardinal;
   i:Integer;
begin
   while Busy do;
   Busy:=True;
   PurgeComm(hCom,PURGE_TXCLEAR);
   PurgeComm(hCom,PURGE_RXCLEAR);

   Result:=True;

   ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);

   if NumberOfBytesRead>0 then
      begin
      Line:='';
      SetLength(Line,NumberOfBytesRead);
      for i:=1 to NumberOfBytesRead do Line[i]:=BufRead[i-1];
      WriteSpy(lang('Réception de : /')+Line+'/');
      
      // HHMMssmmm
      Hour:=StrToInt(Copy(Line,2,2));
      Min:=StrToInt(Copy(Line,5,2));
      Sec:=StrToInt(Copy(Line,8,2));
      MSec:=StrToInt(Copy(Line,11,3));
      end
   else Result:=False;
   Busy:=False;
end;

function THourServerEventMarker.SetEventOut(Hour,Min,Sec,Nb,Interval:Word):Boolean;
var
   MyMessage,Line,SHour,SMin,SSec,SMSec:string;
   i,Longueur:Integer;
   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
begin
while Busy do;
Busy:=True;
PurgeComm(hCom,PURGE_TXCLEAR);
PurgeComm(hCom,PURGE_RXCLEAR);

// f164022/
SHour:=IntToStr(Hour);
if Hour<10 then SHour:='0'+SHour;
SMin:=IntToStr(Min);
if Min<10 then SMin:='0'+SMin;
SSec:=IntToStr(Sec);
if Sec<10 then SSec:='0'+SSec;

Line:='f'+SHour+SMin+SSec+'/';

Longueur:=Length(Line);
for i:=1 to Longueur do BufWrite[i-1]:=Line[i];
WriteFile(hCom,BufWrite[0],Longueur,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>Longueur then
   begin
   CloseSerialPort;
   Result:=False;
   MyMessage:='HourServerEventMarkerSetEventOut : '+ //nolang
      'Le serveur d''heure n''accepte pas l''heure';
   WriteSpy(MyMessage);
   raise MyError.Create(MyMessage);
   end;

ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);

// n5/
Line:='n'+IntToStr(Nb)+'/';

Longueur:=Length(Line);
for i:=1 to Longueur do BufWrite[i-1]:=Line[i];
WriteFile(hCom,BufWrite[0],Longueur,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>Longueur then
   begin
   CloseSerialPort;
   Result:=False;
   MyMessage:='HourServerEventMarkerSetEventOut : '+ //nolang
      'Le serveur d''heure n''accepte pas l''heure';
   WriteSpy(MyMessage);
   raise MyError.Create(MyMessage);
   end;

ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);

// i12/
Line:='i'+IntToStr(Interval)+'/';

Longueur:=Length(Line);
for i:=1 to Longueur do BufWrite[i-1]:=Line[i];
WriteFile(hCom,BufWrite[0],Longueur,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>Longueur then
   begin
   CloseSerialPort;
   Result:=False;
   MyMessage:='HourServerEventMarkerSetEventOut : '+ //nolang
      'Le serveur d''heure n''accepte pas l''heure';
   WriteSpy(MyMessage);
   raise MyError.Create(MyMessage);
   end;

ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);
Busy:=False;
end;

function THourServerEventMarker.GetCoordinates(var Lat,Long:Double):Boolean;
var
   BufWrite:array[0..99] of char;
   BufRead:array[0..99] of char;
   NumberOfBytesWrite,NumberOfBytesRead:Cardinal;
   Line,MyMessage:string;
   i:Integer;
begin
Result:=True;
while Busy do;
Busy:=True;

PurgeComm(hCom,PURGE_TXCLEAR);
PurgeComm(hCom,PURGE_RXCLEAR);

// Ecriture : p
BufWrite[0]:='p';
WriteFile(hCom,BufWrite[0],1,NumberOfBytesWrite,nil);
if NumberOfBytesWrite<>1 then
   begin
   CloseSerialPort;
   Result:=False;
   MyMessage:='HourServerEventMarkerGetCoordinates : '+ //nolang
      'Le serveur d''heure n''accepte pas la commande';
   WriteSpy(MyMessage);
   raise MyError.Create(MyMessage);
   end;

ReadFile(hCom,BufRead[0],99,NumberOfBytesRead,nil);

//C= p
//Lat  : 5050.8634N       ??? si possible faire  (8634 * 6) / 1000  et afficher 50° 50' 51" N
//Long : 00425.1185E          idem  :  4° 25' 7" E
//
//C=
// Lecture :  Lat  : 5050.8634N Long : 00425.1185E C=

if NumberOfBytesRead>0 then
   begin
   Line:='';
   SetLength(Line,NumberOfBytesRead);
   for i:=1 to NumberOfBytesRead do Line[i]:=BufRead[i-1];
   WriteSpy(lang('Réception de : /')+Line+'/');

   WriteSpy('Lat Deg : /'+Copy(Line,8,2)+'/');  //nolang
   WriteSpy('Lat Min : /'+Copy(Line,10,2)+'/'); //nolang
   WriteSpy('Lat Frac : /'+Copy(Line,13,4)+'/'); //nolang
   WriteSpy('Long Deg : /'+Copy(Line,28,3)+'/'); //nolang
   WriteSpy('Long Min : /'+Copy(Line,31,2)+'/'); //nolang
   WriteSpy('Long Frac : /'+Copy(Line,34,4)+'/'); //nolang
   Lat:=MyStrToFloat(Copy(Line,8,2))+MyStrToFloat(Copy(Line,10,2))/60+MyStrToFloat(Copy(Line,13,4))*6/10000/3600;
   if Line[18]='S' then Lat:=-Lat;
   Long:=MyStrToFloat(Copy(Line,28,3))+MyStrToFloat(Copy(Line,31,2))/60+MyStrToFloat(Copy(Line,34,4))*6/10000/3600;
   if Line[37]='E' then Long:=-Long;

   WriteSpy('Lat lue : '+DeltaToStr(Lat)+'/'); //nolang
   WriteSpy('Long lue : '+DeltaToStr(Long)+'/'); //nolang
   end
else Result:=False;

Busy:=False;
end;

end.
