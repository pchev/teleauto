unit u_driver_st7_nt;

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
	PARDRV.H
	Contains the function prototypes and enumerated constants
	for the Parallel Port driver.  This supports the ST-7,ST-8, ST-5C (PixCel255), ST-237 (PixCel237) and the
	Industrial ST-K	cameras.
	It also supports the TCE-1 Telescope Control Electronics and
	the AO-7.
    Version 2.75 - Oct 6, 1999
	(c)1995-99 - Santa Barbara Instrument Group }

//#ifndef _PARDRV_
//#define _PARDRV_

//SBIG Specific Code

interface

uses u_class;

Const
  ENV_DOS    = 0;
  ENV_WIN    = 1;
  ENV_WIN32  = 2;
  ENV_WIN32S = 3;
  ENV_WINNT  = 4;
  TARGET     = ENV_DOS;

{	Enumerated Constants

	Note that the various constants are declared here as enums
	for ease of declaration but in the structures that use the
	enums unsigned shorts are used to force the various
	16 and 32 bit compilers to use 16 bits.

	Supported Camera Commands

	These are the commands supported by the driver.
	They are prefixed by CC_ to designate them as
	camera commands and avoid conflicts with other
	enums.

	Some of the commands are marked as SBIG use only
	and have been included to enhance testability
	of the driver for SBIG. }

//		General Use Commands

//* 1 - 10 */
  CC_START_EXPOSURE                   :Word= 1;
  CC_END_EXPOSURE                     :Word= 2;
  CC_READOUT_LINE                     :Word= 3;
  CC_DUMP_LINES                       :Word= 4;
  CC_SET_TEMPERATURE_REGULATION       :Word= 5;
  CC_QUERY_TEMPERATURE_STATUS         :Word= 6;
  CC_ACTIVATE_RELAY                   :Word= 7;
  CC_PULSE_OUT                        :Word= 8;
  CC_ESTABLISH_LINK                   :Word= 9;
  CC_GET_DRIVER_INFO                  :Word= 10;
//* 11 - 20 */
  CC_GET_CCD_INFO                     :Word= 11;
  CC_QUERY_COMMAND_STATUS             :Word= 12;
  CC_MISCELLANEOUS_CONTROL            :Word= 13;
  CC_READ_SUBTRACT_LINE               :Word= 14;
  CC_UPDATE_CLOCK                     :Word= 15;
  CC_READ_OFFSET                      :Word= 16;
  CC_OPEN_DRIVER                      :Word= 17;
  CC_CLOSE_DRIVER                     :Word= 18;
  CC_TX_SERIAL_BYTES                  :Word= 19;
  CC_GET_SERIAL_STATUS                :Word= 20;
//* 21 - 30 */
  CC_AO_TIP_TILT                      :Word= 21;
  CC_AO_SET_FOCUS                     :Word= 22;
  CC_AO_DELAY                         :Word= 23;
  CC_GET_TURBO_STATUS                 :Word= 24;
  CC_END_READOUT                      :Word= 25;
  CC_GET_US_TIMER                     :Word= 26;
  CC_OPEN_DEVICE                      :Word= 27;
  CC_CLOSE_DEVICE                     :Word= 28;
  CC_SET_IRQL                         :Word= 29;
  CC_GET_IRQL                         :Word= 30;
//		SBIG Use Only Commands
  CC_SEND_BLOCK                       :Word= 31;
  CC_SEND_BYTE                        :Word= 32;
  CC_GET_BYTE                         :Word= 33;
  CC_SEND_AD                          :Word= 34;
  CC_GET_AD                           :Word= 35;
  CC_CLOCK_AD                         :Word= 36;
  CC_LAST_COMMAND                     :Word= 37;
  //} PAR_COMMAND;

{	Return Error Codes

	These are the error codes returned by the driver
	function.  They are prefixed with CE_ to designate
	them as camera errors. }

//* 1 - 10 */
  CE_NO_ERROR                         :Word= 0;
  CE_CAMERA_NOT_FOUND                 :Word= 1;
  CE_EXPOSURE_IN_PROGRESS             :Word= 2;
  CE_NO_EXPOSURE_IN_PROGRESS          :Word= 3;
  CE_UNKNOWN_COMMAND                  :Word= 4;
  CE_BAD_CAMERA_COMMAND               :Word= 5;
  CE_BAD_PARAMETER                    :Word= 6;
  CE_TX_TIMEOUT                       :Word= 7;
  CE_RX_TIMEOUT                       :Word= 8;
  CE_NAK_RECEIVED                     :Word= 9;
//* 11 - 20 */
  CE_CAN_RECEIVED                     :Word= 10;
  CE_UNKNOWN_RESPONSE                 :Word= 11;
  CE_BAD_LENGTH                       :Word= 12;
  CE_AD_TIMEOUT                       :Word= 13;
  CE_KBD_ESC                          :Word= 14;
  CE_CHECKSUM_ERROR                   :Word= 15;
  CE_EEPROM_ERROR                     :Word= 16;
  CE_SHUTTER_ERROR                    :Word= 17;
  CE_UNKNOWN_CAMERA                   :Word= 18;
  CE_DRIVER_NOT_FOUND                 :Word= 19;
//* 21 - 30 */
  CE_DRIVER_NOT_OPEN                  :Word= 20;
  CE_DRIVER_NOT_CLOSED                :Word= 21;
  CE_SHARE_ERROR                      :Word= 22;
  CE_TCE_NOT_FOUND                    :Word= 23;
  CE_AO_ERROR                         :Word= 24;
  CE_NEXT_ERROR                       :Word= 25;
//  } PAR_ERROR;

{	Camera Command State Codes

	These are the return status codes for the Query
	Command Status command.  Theyt are prefixed with
	CS_ to designate them as camera status. }

  CS_IDLE                             = 0;
  CS_IN_PROGRESS                      = 1;
  CS_INTEGRATING                      = 2;
  CS_INTEGRATION_COMPLETE             = 3;
//} PAR_COMMAND_STATUS;

  CS_PULSE_IN_ACTIVE                  = $8000;
  CS_WAITING_FOR_TRIGGER              = $8000;

{	Misc. Enumerated Constants

	ABG_STATE7 - Passed to Start Exposure Command
	MY_LOGICAL - General purpose type
	DRIVER_REQUEST - Used with Get Driver Info command
	CCD_REQUEST - Used with Imaging commands to specify CCD
	CCD_INFO_REQUEST - Used with Get CCD Info Command
	PORT - Used with Establish Link Command
	CAMERA_TYPE - Returned by Establish Link and Get CCD Info commands
	SHUTTER_COMMAND, SHUTTER_STATE7 - Used with Start Exposure
		and Miscellaneous Control Commands
	TEMPERATURE_REGULATION - Used with Enable Temperature Regulation
	LED_STATE - Used with the Miscellaneous Control Command
	FILTER_COMMAND, FILTER_STATE - Used with the Miscellaneous
		Control Command
	AD_SIZE, FILTER_TYPE - Used with the GetCCDInfo3 Command
	AO_FOCUS_COMMAND - Used with the AO Set Focus Command }


  ABG_LOW7                            = 0;
  ABG_CLK_LOW7                        = 1;
  ABG_CLK_MED7                        = 2;
  ABG_CLK_HI7                         = 3;
//} ABG_STATE7;

  DRIVER_STD                          = 0;
  DRIVER_EXTENDED                     = 1;
//} DRIVER_REQUEST;

  CCD_IMAGING                         = 0;
  CCD_TRACKING                        = 1;
//} CCD_REQUEST;

  CCD_INFO_IMAGING                    = 0;
  CCD_INFO_TRACKING                   = 1;
  CCD_INFO_EXTENDED                   = 2;
  CCD_INFO_EXTENDED_5C                = 3;
//} CCD_INFO_REQUEST;

  ABG_NOT_PRESENT                     = 0;
  ABG_PRESENT                         = 1;
//} IMAGING_ABG;

  BASE_ADDR                           = 0;
  PORT0                               = 1;
  PORT1                               = 2;
  PORT2                               = 3;
//} PORT;

  BR_AUTO                             = 0;
  BR_9600                             = 1;
  BR_19K                              = 2;
  BR_38K                              = 3;
  BR_57K                              = 4;
  BR_115K                             = 5;
//} PORT_RATE;

  ST7_CAMERA=4                        = 0;
  ST8_CAMERA                          = 1;
  ST5C_CAMERA                         = 2;
  TCE_CONTROLLER                      = 3;
  ST237_CAMERA                        = 4;
  STK_CAMERA                          = 5;
  ST9_CAMERA                          = 6;
//} CAMERA_TYPE;

  SC_LEAVE_SHUTTER                    = 0;
  SC_OPEN_SHUTTER                     = 1;
  SC_CLOSE_SHUTTER                    = 2;
  SC_INITIALIZE_SHUTTER               = 3;
//} SHUTTER_COMMAND;

  SS_OPEN                             = 0;
  SS_CLOSED                           = 1;
  SS_OPENING                          = 2;
  SS_CLOSING                          = 3;
//} SHUTTER_STATE7;

  REGULATION_OFF                      = 0;
  REGULATION_ON                       = 1;
  REGULATION_OVERRIDE                 = 2;
  REGULATION_FREEZE                   = 3;
  REGULATION_UNFREEZE                 = 4;
  REGULATION_ENABLE_AUTOFREEZE        = 5;
  REGULATION_DISABLE_AUTOFREEZE       = 6;
//} TEMPERATURE_REGULATION;

  REGULATION_FROZEN_MASK              = $8000;

  LED_OFF                             = 0;
  LED_ON                              = 1;
  LED_BLINK_LOW                       = 2;
  LED_BLINK_HIGH                      = 3;
//} LED_STATE;

  FILTER_LEAVE                        = 0;
  FILTER_SET_1                        = 1;
  FILTER_SET_2                        = 2;
  FILTER_SET_3                        = 3;
  FILTER_SET_4                        = 4;
  FILTER_SET_5                        = 5;
  FILTER_STOP                         = 6;
  FILTER_INIT                         = 7;
//} FILTER_COMMAND;

  FS_MOVING                           = 0;
  FS_AT_1                             = 1;
  FS_AT_2                             = 2;
  FS_AT_3                             = 3;
  FS_AT_4                             = 4;
  FS_AT_5                             = 5;
  FS_UNKNOWN                          = 6;
//} FILTER_STATE;

  AD_UNKNOWN                          = 0;
  AD_12_BITS                          = 1;
  AD_16_BITS                          = 2;
//} AD_SIZE;

  FW_UNKNOWN                          = 0;
  FW_EXTERNAL                         = 1;
  FW_VANE                             = 2;
  FW_FILTER_WHEEL                     = 3;
//} FILTER_TYPE;

  AOF_HARD_CENTER                     = 0;
  AOF_SOFT_CENTER                     = 1;
  AOF_STEP_IN                         = 2;
  AOF_STEP_OUT                        = 3;
//} AO_FOCUS_COMMAND;

//	General Purpose Flags

END_SKIP_DELAY                        = $8000;     // set in ccd parameter of EndExposure
                                                   // command to skip synchronization
			                            // delay - Use this to increase the
			                            // rep rate when taking darks to later
			                            // be subtracted from SC_LEAVE_SHUTTER
			                            // exposures such as when tracking and
			                            // imaging
EXP_WAIT_FOR_TRIGGER_IN               = $80000000;  // set in exposureTime to wait for trigger in pulse
EXP_SEND_TRIGGER_OUT                  = $40000000;  // set in exposureTime to send trigger out Y-
EXP_LIGHT_CLEAR	                    = $20000000;  // set to do light clear of the CCD (Kaiser only)
EXP_TIME_MASK                         = $00FFFFFF;  // mask with exposure time to remove flags

//	Defines

MIN_ST7_EXPOSURE                      = 11;         // Minimum exposure is 11/100ths second */

{	Command Parameter and Results Structs

	Make sure you set your compiler for byte structure alignment
	as that is how the driver was built. }

type

Char64=array[1..64] of char;

TStartExposureParams = packed record
  ccd:Word;             // CCD_REQUEST
  exposureTime:Integer;
  abgState:Word;        // ABG_STATE7
  openShutter:Word;     // SHUTTER_COMMAND
  end;

TEndExposureParams = packed record
  ccd:Word; // CCD_REQUEST
  end;

TReadoutLineParams = packed record
  ccd:Word; // CCD_REQUEST */
  readoutMode:Word;
  pixelStart:Word;
  pixelLength:Word;
  end;

TDumpLinesParams = packed record
  ccd:Word; // CCD_REQUEST
  readoutMode:Word;
  lineLength:Word;
  end;

TEndReadoutParams = packed record
  ccd:Word; // CCD_REQUEST
  end;

TSetTemperatureRegulationParams = packed record
  regulation:Word; // TEMPERATURE_REGULATION
  ccdSetpoint:Word;
  end;

TQueryTemperatureStatusResults = packed record
  enabled:WordBool;
  ccdSetpoint:Word;
  power:Word;
  ccdThermistor:Word;
  ambientThermistor:Word;
  end;

TActivateRelayParams = packed record
  tXPlus:Word;
  tXMinus:Word;
  tYPlus:Word;
  tYMinus:Word;
  end;

TPulseOutParams = packed record
  numberPulses:Word;
  pulseWidth:Word;
  pulsePeriod:Word;
  end;

TXSerialBytesParams = packed record
  dataLength:Word;
  data:array[1..256] of char;
  end;

TXSerialBytesResults = packed record
  bytesSent:Word;
  end;

TGetSerialStatusResults = packed record
  clearToCOM:WordBool;
  end;

TEstablishLinkParams = packed record
  port:Word; // PORT
  baseAddress:Word;
  end;

TEstablishLinkResults = packed record
  cameraType:Word; //CAMERA_TYPE
  end;

TGetDriverInfoParams = packed record
  request:Word; // DRIVER_REQUEST
  end;

TGetDriverInfoResults0 = packed record
  version:Word;
  name:Char64;
  maxRequest:Word;
  end;

TGetCCDInfoParams = packed record
  request:Word; // CCD_INFO_REQUEST
  end;

//typedef  READOUT_INFO;

TReadoutInfo = packed record
  Mode:Word;
  Width:Word;
  Height:Word;
  Gain:Word;
  PixelWidth:Cardinal;
  PixelHeight:Cardinal;
  end;

TGetCCDInfoResults0 = packed record
  FirmwareVersion:Word;
  CameraType:Word; // CAMERA_TYPE
  Name:array[1..64] of Char;
  ReadoutModes:Word;
  ReadoutInfo:array[1..20] of TReadoutInfo;
  end;

TGetCCDInfoResults2 = packed record
  BadColumns:Word;
  Columns:array[1..4] of Word;
  ImagingABG:Word; // IMAGING_ABG
  SerialNumber:array[1..10] of Char;
  end;

TGetCCDInfoResults3 = packed record
  adSize:Word; // AD_SIZE
  filterType:Word; // FILTER_TYPE
  end;

TQueryCommandStatusParams = packed record
  command:Word;
  end;

TQueryCommandStatusResults = packed record
  status:Word;
  end;

TMiscellaneousControlParams = packed record
  fanEnable:WordBool;
  shutterCommand:Word; // SHUTTER_COMMAND
  ledState:Word; // LED_STATE
  end;

TReadOffsetParams = packed record
  ccd:Word; // CCD_REQUEST
  end;

TReadOffsetResults = packed record
  offset:Word;
  end;

TAOTipTiltParams = packed record
  xDeflection:Word;
  yDeflection:Word;
  end;

TAOSetFocusParams = packed record
  DocusCommand:Word; // AO_FOCUS_COMMAND
  end;

TAODelayParams = packed record
  Delay:Cardinal;
  end;

TGetTurboStatusResults = packed record
  TurboDetected:WordBool;
  end;

TOpenDeviceParams = packed record
  Port:Word;
  end;

TSetIRQLParams = packed record
  Level:Word;
  end;

TGetIRQLResults = packed record
  Level:Word;
  end;

TGetUSTimerResults = packed record
  Count:Cardinal;
  end;

TSendBlockParams = packed record
  Port:Word;
  Length:Word;
  Source:PChar;
  end;

TSendByteParams = packed record
  Port:Word;
  Data:Word;
  end;

TClockADParams = packed record
  Ccd:Word; // CCD_REQUEST
  ReadoutMode:Word;
  PixelStart:Word;
  PixelLength:Word;
  end;

//	TCE Defines

{	Commands - These are the various commands the TCE supports.
			   They are all prefaced with TCEC_ so commands with
			   the same name will not conflict with the Universal
			   CPU or ST-7/8 commands. }

const

  TCEC_NO_COMMAND                     = 0;
  TCEC_GET_ENCODERS                   = 1;
  TCEC_SYNC_ENCODERS                  = 2;
  TCEC_RESET_ENCODERS                 = 3;
  TCEC_GET_EXTENDED_ERROR             = 4;
  TCEC_GET_ACTIVITY_STATUS            = 5;
  TCEC_MOVE                           = 6;
  TCEC_ABORT                          = 7;
  TCEC_GOTO                           = 8;
  TCEC_COMMUTATE                      = 9;
  TCEC_INITIALIZE                     = 10;
  TCEC_PARK                           = 11;
  TCEC_ENABLE_COMMUTATION             = 12;
  TCEC_ACTIVATE_FOCUS                 = 13;
  TCEC_ENABLE_PEC                     = 14;
  TCEC_TRAIN_PEC                      = 15;
  TCEC_OUTPUT_DEW                     = 16;
  TCEC_TX_TO_EXP                      = 17;
  TCEC_ENABLE_LIMIT                   = 18;
  TCEC_SET_EXP_CONTROL                = 19;
  TCEC_GET_EXP_STATUS                 = 20;
  TCEC_GET_RESULT_BUF                 = 21;
  TCEC_LIMIT_STATUS                   = 22;
  TCEC_WRITE_BLOCK                    = 23;
  TCEC_READ_BLOCK                     = 24;
  TCEC_GET_ROM_VERSION                = 25;
  TCEC_SET_COM_BAUD                   = 26;
  TCEC_SET_MOTION_CONTROL             = 27;
  TCEC_GET_MOTION_CONTROL             = 28;
  TCEC_READ_THERMISTOR                = 29;
  TCEC_GET_MOTION_STATE               = 30;
  TCEC_SET_SIDEREAL_CLOCK             = 31;
  TCEC_GET_SIDEREAL_CLOCK             = 32;
  TCEC_LOOPBACK_EXP_TEST              = 33;
  TCEC_GET_KEY                        = 34;
  TCEC_GET_KEYS                       = 35;
  TCEC_GET_EEPROM_DATA                = 36;
  TCEC_GET_TCE_INFO                   = 37;
  TCEC_SET_EEPROM_DATA                = 38;
  TCEC_OPEN_DRIVER                    = $50;
  TCEC_CLOSE_DRIVER                   = 40;
  TCEC_GET_DRIVER_INFO                = 41;
  TCEC_ESTABLISH_LINK                 = 42;
  TCEC_HARDWARE_RESET                 = 43;
//		SBIG Use Only commands - These commands are for use by
//			SBIG for production testing of the TCE.
  TCEC_READ_EE_BLOCK                  = $30;
  TCEC_WRITE_EE_BLOCK                 = 45;
  TCEC_MICRO_OUT                      = 46;
  TCEC_READ_R0                        = 47;
  TCEC_WRITE_R0                       = 48;
  TCEC_READ_GA                        = 49;
  TCEC_WRITE_GA                       = 50;
  TCEC_GET_EBS                        = 51;
  TCEC_SEND_BLOCK                     = $40;
//} TCE_COMMAND;

//	These enumerated constants are used with the various
//	TCE commands.

//	Move and Goto speeds - Use with the TCEC_MOVE and TCEC_GOTO commands

  MOVE_STOP                           = 0;
  MOVE_BASE                           = 1;
  MOVE_LEAVE                          = 2;
  MOVE_0R5X                           = 3;
  MOVE_1X                             = 4;
  MOVE_2X                             = 5;
  MOVE_4X                             = 6;
  MOVE_8X                             = 7;
  MOVE_16X                            = 8;
  MOVE_32X                            = 9;
  MOVE_64X                            = 10;
  MOVE_128X                           = 11;
  MOVE_256X                           = 12;
  MOVE_SLEW                           = 13;
//} MOVE_SPEED;

//	Move Directions
  MOVE_FORWARD                        = 0;
  MOVE_REVERSE                        = 1;
//} MOVE_DIRECTION;

//	Command Status Values - Returned by the TCEC_GET_ACTIVITY_STATUS cmd

  TCES_IDLE_STATUS                    = 0;	// command is idle */
  TCES_IN_PROGRESS                    = 1;	// command is in progress */
  TCES_DISABLED	                      = 0;	// feature is disabled */
  TCES_ENABLED	                      = 1;	// feature is enabled */
  TCES_EXTENDED_ERROR                 = 99;	// this indicates an extended error occured
				                // and the TCEC_GET_EXTENDED_ERROR command
				                // should be called for further info */

  PS_UNPARKED                         = 0;
  PS_PARKED                           = 1;
  PS_UNPARKING                        = 2;
  PS_PARKING                          = 3;
  PS_PARK_LOST                        = 4;
  PS_INITIALIZING                     = 5;
//} TCES_PARK_STATUS;

  MS_BASE_RATE                        = 0;
  MS_OTHER_RATE                       = 1;
//} TCES_MOVE_STATUS;

//	Extended Error Codes - Returned by the TCEC_GET_EXTENDED_ERROR cmd

  TCEEE_NO_ERROR                      = 0;
  TCEEE_LIMIT_HIT                     = 1;
  TCEEE_USER_ABORT                    = 2;
  TCEEE_RA_TIMEOUT                    = 3;
  TCEEE_DEC_TIMEOUT                   = 4;
  TCEEE_COM_MOTION_TIMEOUT            = 5;
  TCEEE_RA_COM_ERROR                  = 6;
  TCEE_DEC_COM_ERROR                  = 7;
//} TCE_EXTENDED_ERRORS;

{	Structs

	These struct type defines are used with the various commands.
	There are two types of structs, those ending with _DATA and
	those ending with _RESPONSE.

	The XX_DATA structs are used to feed data to the TCE for those
	commands that require data.

	The XX_RESPONSE structs are used to receive data back from the
	TCE in response to some command.

	Finally, the struct definitions start with TCE_ to avoid
	conflicts with any similarly names structs used with the
	Universal CPU and the center of the struct name echos
	the command the struct is associated with. }

Type

TTCEGetEncodersResults = packed record
  RawRA:Integer;
  RawDEC:Integer;
  SiderealRA:Integer;
  SiderealDEC:Integer;
  IsSynced:Word;
  end;

TTCESyncEncodersParams = packed record
  SiderealRA:Integer;
  SiderealDEC:Integer;
  end;

TTCEGetExtendedErrorResults = packed record
  Error:Word;
  end;

TTCEGetActivityStatusParams = packed record
  Command:Word;
  end;

TTCEGetActivityStatusResults = packed record
  Command:Word;
  Status:Word;
  end;

TTCEMoveParams = packed record
  RaRate:Word;
  DecRate:Word;
  RaDirection:Word;
  DecDirection:Word;
  end;

TTCEGotoParams = packed record
  DeltaRA:Integer;
  DeltaDEC:Integer;
  Rate:Word;
  end;

TTCEInitializeParams = packed record
  RaRatio:Word;
  DecRatio:Word;
  RaDirection:Word;
  DecDirection:Word;
  end;

TTCEEnableCommutationParams = packed record
  Enable:Word;
  end;

TTCEActivateFocusParams = packed record
  tPlus:Word;
  tMinus:Word;
  end;

TTCEEnablePECParams = packed record
  Enable:Word;
  end;

TTCEOutputDewParams = packed record
  Power:Word;
  end;

TTCETxToEXPParams = packed record
  DataPtr:PChar;
  DataLen:Word;
  end;

TTCEEnableLimitParams = packed record
  Enable:Word;
  end;

TTCESetEXPControlParams = packed record
  Baud:Cardinal;
  Control:Word;
  end;

TCEGetEXPStatusResults = packed record
  Errs:Word;
  end;

TCEGetResultBufParams = packed record
  Command:Word;
  end;

TCELimitStatusResults = packed record
  Detected:Word;
  InLimit:Word;
  RawLimitRA:Integer;
  RawLimitDEC:Integer;
  SiderealLimitRA:Integer;
  SiderealLimitDEC:Integer;
  LimitTime:Integer;
  end;

TCEWriteBlockParams = packed record
  Offset:Word;
  Segment:Word;
  DataPtr:Pchar;
  DataLen:Word;
  end;

TTCEReadBlockParams = packed record
  Offset:Word;
  Segment:Word;
  Length:Word;
  end;

TTCEGetROMVersionResults = packed record
  Version:Word;
  end;

TTCESetCOMBaudParams = packed record
  Baud:Cardinal;
  end;

TTCESetMotionControlParams = packed record
  Permanent:Word;
  EnableCOMTimeout:Word;
  RaBase:Integer;
  DecBase:Integer;
  Acceleration:Integer;
  MaxRate:Integer;
  end;

TTCEGetMotionControlResults = packed record
  ComTimeoutEnabled:Word;
  RaBase:Integer;
  DecBase:Integer;
  Acceleration:Integer;
  MaxRate:Integer;
  RaRatio:Word;
  DecRatio:Word;
  RaDirection:Word;
  DecDirection:Word;
  end;

TTCEReadThermistorResults = packed record
  Thermistor:Word;
  end;

TTCEParkParams = packed record
  Park:Word;
  end;

TTCEGetMotionStateResults = packed record
  RaRate:Integer;
  DecRate:Integer;
  DeltaRA:SmallInt;
  DeltaDEC:SmallInt;
  end;

TTCEGetSiderealClockResults = packed record
  Time:Integer;
  end;

TTCESetSiderealClockParams = packed record
  Time:Integer;
  end;

TTCELoopbackEXPTestParams = packed record
  Baud:Integer;
  end;

TTCELoopbackEXPTestResults = packed record
  Command:SmallInt;
  Sent:SmallInt;
  Errors:SmallInt;
  end;

TTCEGetKeyResults = packed record
  KeyStatus:Word;
  KeyHit:Word;
  end;

TTCEGetKeysResults = packed record
  Number:Word;
  KeyStatus:Word;
  KeysHit:array[1..16] of Word;
  end;

TTCEGetEEPROMDataResults = packed record
  SerialNumber:array[1..10] of Char;
  Data:array[1..24] of Char;
  end;

TTCEGetTCEInfoResults = packed record
  Version:Word;
  Cpu:Word;
  FirmwareVersion:Word;
  RaROM:Word;
  DecROM:Word;
  HandPaddleROM:Word;
  Name:array[1..32] of Char;
  end;

TTCESetEEPROMDataParams = packed record
  Data:array[1..24] of char;
  end;

//	SBIG Use Only Structs
//	These are for use by SBIG in production testing of the TCE.

TTCEWriteEEBlockParams = packed record
  Address:Word;
  DataPtr:PChar;
  DataLen:Word;
  end;

TTCEReadEEBlockParams = packed record
  Address:Word;
  Length:Word;
  end;

TTCEWriteR0Params = packed record
  Value:Word;
  end;

TTCEReadR0Results = packed record
  Value:Word;
  end;

TTCEGetEBSResults = packed record
  Command:SmallInt;
  RaEB:Word;
  DecEB:Word;
  end;

TTCEMicroOutParams = packed record
  Motor:Char;
  Data:array[1..5] of Char;
  end;

TTCEMicroOutResults = packed record
  Command:Word;
  Result:Char;
  Data:array[1..5] of Char;
  end;

TTCEWriteGAParams = packed record
  Value:Word;
  end;

TTCEReadGAResults = packed record
  Value:Word;
  end;

{	Function Prototypes

	This is the driver interface function.  All camera
	commands are handled by the ParDeviceCommandNH() routine
	and all TCE commands are handled by the TCEDrvCommand().

	Both functions take	a command parameter and pointers
	to parameters and results structs.

	The calling program needs to allocate the memory for
	the parameters and results structs and these routines
	read them and fill them in respectively. }

function ParDeviceCommandNH(Command:Word;var Params,Results):Word;
         cdecl; external 'sbignt.dll' name 'ParDeviceCommandNH'; //nolang

function GetErrorSbigNT(NoError:Word):String;
function OpenDriverSbigNT:Word;
function CloseDriverSbigNT:Word;
function OpenDeviceSbigNT(PortNumber:Byte):Word;
function CloseDeviceSbigNT:Word;
function GetDriverInfoSbigNT(_Version:Word;_Name:Char64;_MaxRequest:Word):Word;
function StartExposureSbigNT(_StateShutter,_ExposureTime:Integer):Word;
function StartExposureTrackSbigNT(_StateShutter,_ExposureTime:Integer):Word;
function EndExposureSbigNT:Word;
function EndExposureTrackSbigNT:Word;
function ReadoutLineSbigNT(_ReadoutMode:Word;_PixelStart:Word;_PixelLength:Word;var Line:TLigWord):Word;
function ReadoutLineTrackSbigNT(_ReadoutMode:Word;_PixelStart:Word;_PixelLength:Word):Word;
function DumpLineSbigNT(_ReadoutMode:Word;_LineLength:Word):Word;
function DumpLineTrackSbigNT(_ReadoutMode:Word;_LineLength:Word):Word;
function EndReadoutSbigNT:Word;
function EndReadoutTrackSbigNT:Word;
function SetTempRegulOnSbigNT(TempCible:Double):Word;
function SetTempRegulOffSbigNT:Word;
function SetTempRegulFreezeSbigNT:Word;
function SetTempRegulUnFreezeSbigNT(TempCible:Double):Word;
function QueryTempStatusSbigNT(var Temp:Double):Word;
function ActivateRelaySbigNT(DX,DY:Integer):Word;
function PutFilterSbigNT(NoFilter:Word):Word;
function EstablishLinkSbigNT(_BaseAddress:Word;var NoCamera:Word):Word;
function GetCameraNameSbigNT(var NameOut:String):Word;

implementation

uses Windows,
     u_lang,
     u_general;

function GetErrorSbigNT(NoError:Word):String;
begin
if NoError=CE_CAMERA_NOT_FOUND        then Result:=lang('Pas de caméra SBIG trouvée') else
if NoError=CE_EXPOSURE_IN_PROGRESS    then Result:=lang('Exposition en cours') else
if NoError=CE_NO_EXPOSURE_IN_PROGRESS then Result:=lang('Pas d''exposition en cours') else
if NoError=CE_UNKNOWN_COMMAND         then Result:=lang('Commande inconnue') else
if NoError=CE_BAD_CAMERA_COMMAND      then Result:=lang('Commande de caméra incorrecte') else
if NoError=CE_BAD_PARAMETER           then Result:=lang('Paramètre incorrect') else
if NoError=CE_TX_TIMEOUT              then Result:=lang('TX time out') else
if NoError=CE_RX_TIMEOUT              then Result:=lang('RX time out') else
if NoError=CE_NAK_RECEIVED            then Result:=lang('NAK reçu') else
if NoError=CE_CAN_RECEIVED            then Result:=lang('CAN recu') else
if NoError=CE_UNKNOWN_RESPONSE        then Result:=lang('Réponse inconnue') else
if NoError=CE_BAD_LENGTH              then Result:=lang('Longueur incorrecte') else
if NoError=CE_AD_TIMEOUT              then Result:=lang('AD time out') else
if NoError=CE_KBD_ESC                 then Result:=lang('Touche ESC préssée') else
if NoError=CE_CHECKSUM_ERROR          then Result:=lang('Erreur checksum') else
if NoError=CE_EEPROM_ERROR            then Result:=lang('Erreur EEPROM') else
if NoError=CE_SHUTTER_ERROR           then Result:=lang('Erreur obturateur') else
if NoError=CE_UNKNOWN_CAMERA          then Result:=lang('Camera inconnue') else
if NoError=CE_DRIVER_NOT_FOUND        then Result:=lang('Driver absent') else
if NoError=CE_DRIVER_NOT_OPEN         then Result:=lang('Driver inactif') else
if NoError=CE_DRIVER_NOT_CLOSED       then Result:=lang('Driver actif') else
if NoError=CE_SHARE_ERROR             then Result:=lang('Erreur de partage') else
if NoError=CE_TCE_NOT_FOUND           then Result:=lang('TCE absent') else
if NoError=CE_AO_ERROR                then Result:=lang('Erreur AO') else
if NoError=CE_NEXT_ERROR              then Result:=lang('Erreur suivante')
else Result:=lang('Erreur inconnue');
end;

function OpenDriverSbigNT:Word;
var
   p:Pointer;
begin
Result:=ParDeviceCommandNH(CC_OPEN_DRIVER,p,p);
end;

function CloseDriverSbigNT:Word;
var
   p:Pointer;
begin
Result:=ParDeviceCommandNH(CC_CLOSE_DRIVER,p,p);
end;

function OpenDeviceSbigNT(PortNumber:Byte):Word;
var
   OpenDeviceParams:TOpenDeviceParams;
   p:Pointer;
begin
OpenDeviceParams.Port:=PortNumber;
Result:=ParDeviceCommandNH(CC_OPEN_DEVICE,OpenDeviceParams,p);
end;

function CloseDeviceSbigNT:Word;
var
   p:Pointer;
begin
Result:=ParDeviceCommandNH(CC_CLOSE_DEVICE,p,p);
end;

function GetDriverInfoSbigNT(_Version:Word;_Name:Char64;_MaxRequest:Word):Word;
var
GetDriverInfoParams:TGetDriverInfoParams;
GetDriverInfoResults0:TGetDriverInfoResults0;
begin
GetDriverInfoParams.Request:=0;
Result:=ParDeviceCommandNH(CC_GET_DRIVER_INFO,GetDriverInfoParams,GetDriverInfoResults0);
_Version:=GetDriverInfoResults0.Version;
_Name:=GetDriverInfoResults0.Name;
_MaxRequest:=GetDriverInfoResults0.MaxRequest;
end;

function StartExposureSbigNT(_StateShutter,_ExposureTime:Integer):Word;
var
   StartExposureParams:TStartExposureParams;
   Resultat:Word;
   p:Pointer;
begin
StartExposureParams.Ccd:=0;
StartExposureParams.ExposureTime:=_ExposureTime;
StartExposureParams.AbgState:=0;
StartExposureParams.OpenShutter:=_StateShutter;
Resultat:=ParDeviceCommandNH(CC_START_EXPOSURE,StartExposureParams,p);
// Deuxieme essai
if Resultat<>0 then Resultat:=ParDeviceCommandNH(CC_START_EXPOSURE,StartExposureParams,p);
Result:=Resultat;
end;

function StartExposureTrackSbigNT(_StateShutter,_ExposureTime:Integer):Word;
var
   StartExposureParams:TStartExposureParams;
   p:Pointer;
begin
StartExposureParams.Ccd:=1;
StartExposureParams.ExposureTime:=_ExposureTime;
StartExposureParams.AbgState:=0;
StartExposureParams.OpenShutter:=_StateShutter;
Result:=ParDeviceCommandNH(CC_START_EXPOSURE,StartExposureParams,p);
end;

function EndExposureSbigNT:Word;
var
   EndExposureParams:TEndExposureParams;
   p:Pointer;
begin
EndExposureParams.Ccd:=0;
Result:=ParDeviceCommandNH(CC_END_EXPOSURE,EndExposureParams,p);
end;

function EndExposureTrackSbigNT:Word;
var
   EndExposureParams:TEndExposureParams;
   p:Pointer;
begin
EndExposureParams.Ccd:=1;
Result:=ParDeviceCommandNH(CC_END_EXPOSURE,EndExposureParams,p);
end;

function ReadoutLineSbigNT(_ReadoutMode:Word;_PixelStart:Word;_PixelLength:Word;var Line:TLigWord):Word;
var
   ReadoutLineParams:TReadoutLineParams;
   p:Pointer;
begin
ReadoutLineParams.Ccd:=0;
ReadoutLineParams.ReadoutMode:=_ReadoutMode-1;
ReadoutLineParams.PixelStart:=_PixelStart;
ReadoutLineParams.PixelLength:=_PixelLength;
Result:=ParDeviceCommandNH(CC_READOUT_LINE,ReadoutLineParams,Line);
end;

function ReadoutLineTrackSbigNT(_ReadoutMode:Word;_PixelStart:Word;_PixelLength:Word):Word;
var
   ReadoutLineParams:TReadoutLineParams;
   p:Pointer;
begin
ReadoutLineParams.Ccd:=1;
ReadoutLineParams.ReadoutMode:=_ReadoutMode;
ReadoutLineParams.PixelStart:=_PixelStart;
ReadoutLineParams.PixelLength:=_PixelLength;
Result:=ParDeviceCommandNH(CC_READOUT_LINE,ReadoutLineParams,p);
end;

function DumpLineSbigNT(_ReadoutMode:Word;_LineLength:Word):Word;
var
   DumpLinesParams:TDumpLinesParams;
   p:Pointer;
begin
DumpLinesParams.Ccd:=0;
DumpLinesParams.ReadoutMode:=_ReadoutMode;
DumpLinesParams.LineLength:=_LineLength;
Result:=ParDeviceCommandNH(CC_DUMP_LINES,DumpLinesParams,p);
end;

function DumpLineTrackSbigNT(_ReadoutMode:Word;_LineLength:Word):Word;
var
   DumpLinesParams:TDumpLinesParams;
   p:Pointer;
begin
DumpLinesParams.Ccd:=1;
DumpLinesParams.ReadoutMode:=_ReadoutMode;
DumpLinesParams.LineLength:=_LineLength;
Result:=ParDeviceCommandNH(CC_DUMP_LINES,DumpLinesParams,p);
end;

function EndReadoutSbigNT:Word;
var
   EndReadoutParams:TEndReadoutParams;
   p:Pointer;
begin
EndReadoutParams.Ccd:=0;
Result:=ParDeviceCommandNH(CC_END_READOUT,EndReadoutParams,p);
end;

function EndReadoutTrackSbigNT:Word;
var
   EndReadoutParams:TEndReadoutParams;
   p:Pointer;
begin
EndReadoutParams.Ccd:=1;
Result:=ParDeviceCommandNH(CC_END_READOUT,EndReadoutParams,p);
end;

function SetTempRegulOnSbigNT(TempCible:Double):Word;
var
   SetTemperatureRegulationParams:TSetTemperatureRegulationParams;
   r:Double;
   p:Pointer;
begin
{T0        :Double=25.0;
MAX_AD     :Double= 4096.0;
RO         :Double= 3.0 ;
R_RATIOCCD :Double= 2.57;
R_BRIDGECCD:Double= 10.0;
DTCCD      :Double= 25.0;
R_RATIOAmb :Double= 7.791;
R_BRIDGEAmb:Double= 3.0 ;
DTAmb      :Double= 45.0;

       SetTemperatureRegulationParams.regulation:=REGULATION_ON;
       r:=RO*Exp( ( ln(R_RATIOCCD)*(T0-Temp) )/DTCCD );

       SetTemperatureRegulationParams.ccdSetpoint:=Round(MAX_AD/(R_BRIDGECCD/r+1.0));
       ParDeviceCommandNHSbig(CC_SET_TEMPERATURE_REGULATION,SetTemperatureRegulationParams,pl);}

SetTemperatureRegulationParams.Regulation:=1;
r:=3*exp((ln(2.57)*(25-TempCible))/25);
SetTemperatureRegulationParams.CcdSetpoint:=Round(4096/(10/r+1));
Result:=ParDeviceCommandNH(CC_SET_TEMPERATURE_REGULATION,SetTemperatureRegulationParams,p);
end;

function SetTempRegulOffSbigNT:Word;
var
   SetTemperatureRegulationParams:TSetTemperatureRegulationParams;
   p:Pointer;   
begin
SetTemperatureRegulationParams.Regulation:=0;
SetTemperatureRegulationParams.CcdSetpoint:=0;
Result:=ParDeviceCommandNH(CC_SET_TEMPERATURE_REGULATION,SetTemperatureRegulationParams,p);
end;

function SetTempRegulFreezeSbigNT:Word;
var
   SetTemperatureRegulationParams:TSetTemperatureRegulationParams;
   p:Pointer;   
begin
SetTemperatureRegulationParams.Regulation:=3;
SetTemperatureRegulationParams.CcdSetpoint:=0;
Result:=ParDeviceCommandNH(CC_SET_TEMPERATURE_REGULATION,SetTemperatureRegulationParams,p);
end;

function SetTempRegulUnFreezeSbigNT(TempCible:Double):Word;
var
   SetTemperatureRegulationParams:TSetTemperatureRegulationParams;
   r:Double;
   p:Pointer;   
begin
SetTemperatureRegulationParams.Regulation:=4;
r:=3*exp((ln(2.57)*(25-TempCible))/25);
SetTemperatureRegulationParams.CcdSetpoint:=Round(4096/(10/r+1));
//SetTemperatureRegulationParams.CcdSetpoint:=0;
Result:=ParDeviceCommandNH(CC_SET_TEMPERATURE_REGULATION,SetTemperatureRegulationParams,p);
end;

function QueryTempStatusSbigNT(var Temp:Double):Word;
var
   QueryTemperatureStatusResults:TQueryTemperatureStatusResults;
   r,s:Double;
   p:Pointer;   
begin
Temp:=-9999;
Result:=ParDeviceCommandNH(CC_QUERY_TEMPERATURE_STATUS,p,QueryTemperatureStatusResults);
if Result=0 then
   begin
   s:=QueryTemperatureStatusResults.CcdThermistor;
   if s<>0 then
      begin
      r:=10/((4096/s)-1);
      Temp:=25-25*(ln(r/3)/ln(2.57));
      end;
   end;
end;

// DX et DY en centiemes de secondes 
function ActivateRelaySbigNT(DX,DY:Integer):Word;
var
   ActivateRelayParams:TActivateRelayParams;
   p:Pointer;
begin
ActivateRelayParams.tXPlus:=0;
ActivateRelayParams.tYPlus:=0;
ActivateRelayParams.tXMinus:=0;
ActivateRelayParams.tYMinus:=0;
if DX>0 then ActivateRelayParams.tXPlus:=DX;
if DX<0 then ActivateRelayParams.tXMinus:=-DX;
if DY>0 then ActivateRelayParams.tYPlus:=DY;
if DY<0 then ActivateRelayParams.tYMinus:=-DY;
Result:=ParDeviceCommandNH(CC_ACTIVATE_RELAY,ActivateRelayParams,p);
end;

function PutFilterSbigNT(NoFilter:Word):Word;
var
   PulseOutParams:TPulseOutParams;
   p:Pointer;   
begin
if NoFilter>5 then NoFilter:=5;
if NoFilter<1 then NoFilter:=1;
PulseOutParams.NumberPulses:=60;
PulseOutParams.PulsePeriod:=Round(42000*0.435);   //18270
case NoFilter of
   1:PulseOutParams.PulseWidth:=Round(1200*0.435);
   2:PulseOutParams.PulseWidth:=Round(1800*0.435);
   3:PulseOutParams.PulseWidth:=Round(2400*0.435);  //1044
   4:PulseOutParams.PulseWidth:=Round(3000*0.435);
   5:PulseOutParams.PulseWidth:=Round(3800*0.435);
   end;
Result:=ParDeviceCommandNH(CC_PULSE_OUT,PulseOutParams,p);
MySleep(3000);
end;

function EstablishLinkSbigNT(_BaseAddress:Word;var NoCamera:Word):Word;
var
EstablishLinkParams:TEstablishLinkParams;
EstablishLinkResults:TEstablishLinkResults;
begin
//EstablishLinkParams.Port:=2;
EstablishLinkParams.Port:=0;
EstablishLinkParams.baseAddress:=_BaseAddress;
Result:=ParDeviceCommandNH(CC_ESTABLISH_LINK,EstablishLinkParams,EstablishLinkResults);
NoCamera:=EstablishLinkResults.CameraType;
end;

function GetCameraNameSbigNT(var NameOut:String):Word;
var
GetCCDInfoParams:TGetCCDInfoParams;
//TGetCCDInfoParams = packed record
//  request:Word; // CCD_INFO_REQUEST
//  end;
GetCCDInfoResults0:TGetCCDInfoResults0;
//TGetCCDInfoResults0  = packed record
//  FirmwareVersion:Word;
//  CameraType:Word; // CAMERA_TYPE
//  Name:array[1..64] of Char;
//  ReadoutModes:Word;
//  ReadoutInfo:array[1..20] of TReadoutInfo;
//  end;
i:Integer;
begin
GetCCDInfoParams.Request:=0;
Result:=ParDeviceCommandNH(CC_GET_CCD_INFO,GetCCDInfoParams,GetCCDInfoResults0);
i:=1;
while GetCCDInfoResults0.Name[i]<>#0 do
   begin
   SetLength(NameOut,i);
   NameOut[i]:=GetCCDInfoResults0.Name[i];
   Inc(i)
   end;
Dec(i);
SetLength(NameOut,i);
end;

begin
end.
