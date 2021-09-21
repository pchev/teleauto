unit u_porttalk;

interface

uses Windows;

const
  IOCTL_IOPM_RESTRICT_ALL_ACCESS   :DWord = 2621449216;
  IOCTL_IOPM_ALLOW_EXCUSIVE_ACCESS :DWord = 2621449220;
  IOCTL_ENABLE_IOPM_ON_PROCESSID   :DWord = 2621449228;
  IOCTL_READ_PORT_UCHAR            :DWord = 2621449232;
  IOCTL_WRITE_PORT_UCHAR           :DWord = 2621449236;

procedure StartPortTalk;
function StartPortTalkDriver:Boolean;
procedure InstallPortTalkDriver;
function OpenPortTalk:Byte;
procedure ClosePortTalk;
procedure PortTalkWrite(Contenu:Byte;Adresse:Word);
function PortTalkRead(Adresse:Word):Byte;

implementation

uses WinSvc, u_file_io, SysUtils, Dialogs;

var
  PortTalk_Handle:THandle;        // Handle for PortTalk Driver

// Demarrage de PortTalk a appeller au debut du programme
// PortTalk.sys doit deja etre dans /Windows/System32/Drivers
procedure StartPortTalk;
var
   PortTalk_Handle:THandle;
   Error:Boolean;
   BytesReturned:DWORD;
   PortTalkInstalled:Boolean;
   ProcessID:DWord;
begin
PortTalkInstalled:=False;
PortTalk_Handle:=CreateFile('\\.\PortTalk',GENERIC_READ,0,nil,OPEN_EXISTING, //nolang
   FILE_ATTRIBUTE_NORMAL,0);
if (PortTalk_Handle=INVALID_HANDLE_VALUE) then
   begin
   StartPortTalkDriver;
   PortTalk_Handle:=CreateFile('\\.\PortTalk',GENERIC_READ,0,nil,OPEN_EXISTING, //nolang
      FILE_ATTRIBUTE_NORMAL,0);

   if PortTalk_Handle=INVALID_HANDLE_VALUE then
      WriteSpy('PortTalk: Couldn''t access PortTalk Driver, Please ensure driver is loaded') //nolang
   else PortTalkInstalled:=True;
   end
else PortTalkInstalled:=True;

if PortTalkInstalled then
   begin
   Error:=DeviceIoControl(PortTalk_Handle,IOCTL_IOPM_RESTRICT_ALL_ACCESS,nil,0,nil,0,BytesReturned,nil);
   if not error then WriteSpy(Format('PortTalk: error %d occured in IOCTL_IOPM_RESTRICT_ALL_ACCESS', //nolang
      [GetLastError])); //nolang

   WriteSpy('Granting exclusive access to all I/O Ports');  //nolang
   Error:=DeviceIoControl(PortTalk_Handle,IOCTL_IOPM_ALLOW_EXCUSIVE_ACCESS,nil,0,nil,0,BytesReturned,nil);

   ProcessID:=GetCurrentProcessId;
   WriteSpy(Format('ProcessID of %d',[ProcessID])); //nolang

   Error:=DeviceIoControl(PortTalk_Handle,IOCTL_ENABLE_IOPM_ON_PROCESSID,
      @ProcessId,4,nil,0,BytesReturned,nil);

   if not Error then
      WriteSpy(Format('Error Occured talking to Device Driver %d',[GetLastError])) //nolang
   else
      WriteSpy(Format('PortTalk Device Driver has set IOPM for ProcessID %d',[ProcessId])); //nolang

   CloseHandle(PortTalk_Handle);

   OpenPortTalk;
   end;
end;

function StartPortTalkDriver:Boolean;
var
   SchSCManager:SC_HANDLE;
   schService:SC_HANDLE;
   lpServiceArgVectors:PChar;
   ret:Boolean;
   err:DWORD;
begin
   SchSCManager:=OpenSCManager(nil,                        // machine (NULL == local)
                               nil,                        // database (NULL == default)
                               SC_MANAGER_ALL_ACCESS);     // access required

    if SchSCManager=SC_Handle(nil) then
      if GetLastError=ERROR_ACCESS_DENIED then
         begin
         WriteSpy('PortTalk: You do not have rights to access the Service Control Manager and'); //nolang
         WriteSpy('PortTalk: the PortTalk driver is not installed or started. Please ask');//nolang
         WriteSpy('PortTalk: your administrator to install the driver on your behalf');//nolang
         Result:=False;
         end;

    schService:=SC_HANDLE(nil);
    while schService=SC_HANDLE(nil) do
       begin
       schService:=OpenService(SchSCManager,         // handle to service control manager database
                               'PortTalk',           // pointer to name of service to start //nolang
                               SERVICE_ALL_ACCESS);  // type of access to service

         if schService=SC_Handle(nil) then
            case GetLastError of
                ERROR_ACCESS_DENIED:begin
                                    WriteSpy('PortTalk: You do not have rights to the PortTalk service database'); //nolang
                                    Result:=False;
                                    end;
                ERROR_INVALID_NAME:begin
                                   WriteSpy('PortTalk: The specified service name is invalid'); //nolang
                                   result:=False;
                                   end;
                ERROR_SERVICE_DOES_NOT_EXIST:begin
                                             WriteSpy('PortTalk: The PortTalk driver does not exist. Installing driver'); //nolang
                                             WriteSpy('PortTalk: This can take up to 30 seconds on some machines'); //nolang
                                             InstallPortTalkDriver;

                                             schService:=OpenService(SchSCManager,         // handle to service control manager database
                                                'PortTalk',           // pointer to name of service to start //nolang
                                                SERVICE_ALL_ACCESS);  // type of access to service

                                             if schService=SC_Handle(nil) then
                                                begin
                                                WriteSpy('PortTalk: Can''t install driver'); //nolang
                                                Exit;
                                                end;
                                             end;
               end;
       end;

    lpServiceArgVectors:=nil;
    ret:=StartService(schService,             // service identifier
                      0,                      // number of arguments
                      lpServiceArgVectors);   // pointer to arguments

    if ret then WriteSpy('PortTalk: The PortTalk driver has been successfully started') //nolang
    else
       begin
        err:=GetLastError;
        if err=ERROR_SERVICE_ALREADY_RUNNING then
           WriteSpy('PortTalk: The PortTalk driver is already running') //nolang
        else
           begin
           WriteSpy('PortTalk: Unknown error while starting PortTalk driver service'); //nolang
           WriteSpy('PortTalk: Does PortTalk.SYS exist in your \System32\Drivers Directory ?'); //nolang
           Result:=False;
           end;
       end;

    CloseServiceHandle(schService);
    Result:=True;
end;

procedure InstallPortTalkDriver;
var
   schSCManager:SC_HANDLE;
   schService:SC_HANDLE;
   err:DWORD;
   DriverFileName:PChar;
begin
    SchSCManager:=OpenSCManager(nil,
                                nil,
                                SC_MANAGER_ALL_ACCESS);

    schService:=CreateService(SchSCManager,
                              'PortTalk',
                              'PortTalk',
                              SERVICE_ALL_ACCESS,
                              SERVICE_KERNEL_DRIVER,
                              SERVICE_DEMAND_START,
                              SERVICE_ERROR_NORMAL,
                              'System32\Drivers\PortTalk.sys',
                              nil,
                              nil,
                              nil,
                              nil,
                              nil
                              );

    if schService=SC_Handle(nil) then
       begin
       err:=GetLastError;
       if err=ERROR_SERVICE_EXISTS then
          WriteSpy('PortTalk: Driver already exists. No action taken') //nolang
       else WriteSpy('PortTalk: Unknown error while creating Service'); //nolang
       end
    else WriteSpy('PortTalk: Driver successfully installed'); //nolang

    CloseServiceHandle (schService);
end;

function OpenPortTalk:Byte;
var
   Name,msg:PChar;
   Err:DWord;
begin
   Result:=0;

   PortTalk_Handle:=CreateFile('\\.\PortTalk',GENERIC_READ,0,0,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0); //nolang
   if PortTalk_Handle=INVALID_HANDLE_VALUE then
      begin
      StartPortTalkDriver;
      PortTalk_Handle:=CreateFile('\\.\PortTalk',GENERIC_READ,0,0,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0); //nolang
      if PortTalk_Handle=INVALID_HANDLE_VALUE then
         begin
         WriteSpy('PortTalk: Couldn''t access PortTalk Driver, Please ensure driver is loaded'); //nolang
         Result:=1;
         end;
      end;
end;

procedure ClosePortTalk;
begin
   try
   CloseHandle(PortTalk_Handle);
   except
   end;
end;

procedure PortTalkWrite(Contenu:Byte;Adresse:Word);
var
   Error:LongBool;
   BytesReturned:DWORD;
   Buffer:array[0..2] of Byte;
begin
   Buffer[0]:=Lo(Adresse);
   Buffer[1]:=Hi(Adresse);
   Buffer[2]:=Contenu;

   Error:=DeviceIoControl(PortTalk_Handle,IOCTL_WRITE_PORT_UCHAR,@Buffer,3,nil,0,BytesReturned,nil);

   if not Error then WriteSpy(Format('Error occured during write while talking to PortTalk driver %d',[GetLastError])); //nolang
end;

function PortTalkRead(Adresse:Word):Byte;
var
   Error:LongBool;
   BytesReturned:DWORD;
   Buffer:array[0..1] of Byte;
begin
   Buffer[0]:=Lo(Adresse);
   Buffer[1]:=Hi(Adresse);

   Error:=DeviceIoControl(PortTalk_Handle,IOCTL_READ_PORT_UCHAR,@Buffer,2,@Buffer,1,BytesReturned,nil);
   if not Error then WriteSpy(Format('Error occured during read while talking to PortTalk driver %d',[GetLastError])); //nolang
   Result:=Buffer[0];
end;

end.
