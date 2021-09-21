library PluginAscomDome;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  ComObj,
  Variants,
  IniFiles;

var
   oDome : OleVariant;       // the dome object
   Initialised : Boolean;
   DomeIsOpen : Boolean; // The state of the dome : True if open / False if closed
   SaveExit: Pointer;

{$R *.res}

function DomeIsConnected : Boolean;
begin
   result:=false;
   if not Initialised then exit;
   if VarIsClear(oDome) then exit;
   try
      Result:=oDome.Connected;
   except
      exit;
   end;
end;

function PluginIsConnectedAndOK:Boolean; cdecl;
// This function must test if the dome is connected and working correctly and return
// true is it is the case, false else
// It is called by TeleAuto at every connection of the dome
var
   oChooser : OleVariant;
   IniFile : TIniFile;
   ID : String;
begin
   try
      if DomeIsConnected then
         begin
         Initialised := oDome.Connected;
         Result := Initialised;
         end
      else
         begin
         // Read the current dome ID from the ini file.
         IniFile:= TIniFile.Create('.\PluginAscomDome.ini');
         ID := IniFile.ReadString('Dome', 'ID','');

         // choose the dome using the current one as the default
         oChooser := CreateOleObject('DriverHelper.Chooser');
         oChooser.DeviceType := 'Dome';
         ID := oChooser.Choose(ID);

         if ID <> '' then
            begin
            oDome := CreateOleObject(ID);
            // we should now have created a dome object
            // are we connected?
            oDome.Connected := True;
            // save the dome ID in case it has changed
            IniFile.WriteString('Dome','ID',ID);
            Initialised := oDome.Connected;
            Result := Initialised;
            end
         else
            begin
            Initialised := False;
            Result := False;
            end;
         IniFile.Free;
         end;
   except
      Initialised := False;
      Result := False;
      IniFile.Free;
   end;
end;

procedure PluginOpenDome; cdecl;
// This function must execute the commands to open the dome
// It is called by TeleAuto when the user clic on the button 'Open' of the dome pad
begin
// this seemsto assume that opening the dome will cause it to track the current
// scope position, this isn't true for an ASCOM dome unless it supports
// the slave property. There are dome/telescope hubs that will support this.

   // Put here the commands to open the dome
   try
      if DomeIsConnected then
         begin
         if oDome.CanSetShutter then
            oDome.OpenShutter;
         // slave to the scope position if possible
         if oDome.CanSlave then
            oDome.Slaved := True;
         DomeIsOpen:=True;
         end;
   except
      DomeIsOpen:=False;
   end;
end;

procedure PluginCloseDome; cdecl;
// This function must execute the commands to close the dome
// It is called by TeleAuto when the user clic on the button 'Close' of the dome pad
begin
   // Put here the commands to close the dome
   Try
      if DomeIsConnected then
         begin
         // undo slaving
         if oDome.CanSlave then
            oDome.Slaved := False;
         if oDome.CanSetShutter then
            oDome.CloseShutter;
         DomeIsOpen:=False;
         end;
   except
      DomeIsOpen:=False;
   end;
end;

function PluginIsOpen:Boolean; cdecl;
// This function is used to know the state  of the dome
// It must return True if the  dome is open and False if the dome is closed
// It is called once every second by TeleAuto to update the dome state in the dome pad
begin
{
   if DomeIsConnected then begin
      if oDome.CanSetShutter then begin
         // shutterState of 0 is open, all others are assumed to be closed
         // dangerous!!!
         Result := (oDome.ShutterStatus = 0);
         // alternative, everything other than closed is assumed to be open
         //Result := (oDome.ShutterStatus <> 1);
      end
      else
         Result:=DomeIsOpen;
   end else

}
      Result:=DomeIsOpen;
end;

// these three functions have been added to allow the position of the dome opening
// to be controlled from TeleAuto.

function PluginNeedCoordinates:Boolean; cdecl;
// True if the dome position can be controled
begin
Result:=True;
end;

function PluginSetAzimuth(Azimuth : Double):Boolean; cdecl;
// Sets the azimuth of the dome opening to the value specified in degrees
begin
   try
      if DomeIsConnected then
         begin
         if oDome.CanSetAzimuth then
            oDome.SlewToAzimuth( Azimuth);
         end;
   except
   end;
   Result:=True;
end;

function PluginSetAltitude(Altitude : Double):Boolean; cdecl;
// Sets the altitude of the dome opening
begin
   try
      if DomeIsConnected then
         begin
         if oDome.CanSetAltitude then
            oDome.SlewToAltitude(Altitude);
         end;
   except
   Result:=True;
   end;
end;

procedure PluginClose; cdecl;
begin
   if DomeIsConnected then
      begin
      // disconnect and close the dome object
      oDome.Connected := False;
      VarClear(oDome);
      end;
end;

exports

PluginIsConnectedAndOK,
PluginOpenDome,
PluginCloseDome,
PluginIsOpen,
PluginNeedCoordinates,
PluginSetAzimuth,
PluginSetAltitude,
PluginClose;


procedure LibExit;
// we never seem to get here, don't know why
begin
   ExitProc := SaveExit;  // restore exit procedure chain
   // library exit code
   if DomeIsConnected then
      begin
      // disconnect and close the dome object
      oDome.Connected := False;
      VarClear(oDome);
      end;
end;


begin
   // library initialization code, set exit procedure
   SaveExit := ExitProc;  // save exit procedure chain
   ExitProc := @LibExit;  // install LibExit exit procedure
end.

