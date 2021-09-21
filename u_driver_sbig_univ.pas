unit u_driver_sbig_univ;

{

	SBIGUDRV.H

	Contains the function prototypes and enumerated constants
	for the Universal Parallel/USB/Ethernet driver.

	This supports the following devices:

		ST-7E/8E/9E/10E
		ST-5C/237/237A (PixCel255/237)
		ST-1K, ST-2K
		ST-L Large Format Camera
		ST-402 Camera
        AO-7

    Version 4.43 - January 8,2005

	(c)1995-2005 - Santa Barbara Instrument Group

}

interface

uses u_class, SysUtils;

var
 Nul:Pointer=Nil;

const
 ENV_WIN		 = 1;				// Target for Windows environment
 ENV_WINVXD	 =	2;				// SBIG Use Only, Win 9X VXD
 ENV_WINSYS	 =	3;				// SBIG Use Only, Win NT SYS
 ENV_ESRVJK	 =	4;				// SBIG Use Only, Ethernet Remote
 ENV_ESRVWIN =	5;				// SBIG Use Only, Ethernet Remote
 ENV_MACOSX  = 6;				// SBIG Use Only, Mac OSX
 ENV_LINUX	 =	7;				// SBIG Use Only, Linux
 TARGET		 = ENV_WIN;    // Set for your target

{

	Enumerated Constants

	Note that the various constants are declared here as enums
	for ease of declaration but in the structures that use the
	enums unsigned shorts are used to force the various
	16 and 32 bit compilers to use 16 bits.

}

{

	Supported Camera Commands

	These are the commands supported by the driver.
	They are prefixed by CC_ to designate them as
	camera commands and avoid conflicts with other
	enums.

	Some of the commands are marked as SBIG use only
	and have been included to enhance testability
	of the driver for SBIG.

}

//		General Use Commands

	CC_NULL                         :Word=0;
	// 1 - 10
	CC_START_EXPOSURE               :Word=1;
   CC_END_EXPOSURE                 :Word=2;
   CC_READOUT_LINE                 :Word=3;
	CC_DUMP_LINES                   :Word=4;
   CC_SET_TEMPERATURE_REGULATION   :Word=5;
	CC_QUERY_TEMPERATURE_STATUS     :Word=6;
   CC_ACTIVATE_RELAY               :Word=7;
   CC_PULSE_OUT                    :Word=8;
	CC_ESTABLISH_LINK               :Word=9;
   CC_GET_DRIVER_INFO              :Word=10;
	// 11 - 20
	CC_GET_CCD_INFO                 :Word=11;
   CC_QUERY_COMMAND_STATUS         :Word=12;
   CC_MISCELLANEOUS_CONTROL        :Word=13;
	CC_READ_SUBTRACT_LINE           :Word=14;
   CC_UPDATE_CLOCK                 :Word=15;
   CC_READ_OFFSET                  :Word=16;
	CC_OPEN_DRIVER                  :Word=17;
   CC_CLOSE_DRIVER                 :Word=18;
	CC_TX_SERIAL_BYTES              :Word=19;
   CC_GET_SERIAL_STATUS            :Word=20;
	// 21 - 30
	CC_AO_TIP_TILT                  :Word=21;
   CC_AO_SET_FOCUS                 :Word=22;
   CC_AO_DELAY                     :Word=23;
   CC_GET_TURBO_STATUS             :Word=24;
   CC_END_READOUT                  :Word=25;
   CC_GET_US_TIMER                 :Word=26;
	CC_OPEN_DEVICE                  :Word=27;
   CC_CLOSE_DEVICE                 :Word=28;
   CC_SET_IRQL                     :Word=29;
   CC_GET_IRQL                     :Word=30;
	// 31 - 40
	CC_GET_LINE                     :Word=31;
   CC_GET_LINK_STATUS              :Word=32;
   CC_GET_DRIVER_HANDLE            :Word=33;
	CC_SET_DRIVER_HANDLE            :Word=34;
   CC_START_READOUT                :Word=35;
   CC_GET_ERROR_STRING             :Word=36;
	CC_SET_DRIVER_CONTROL           :Word=37;
   CC_GET_DRIVER_CONTROL           :Word=38;
	CC_USB_AD_CONTROL               :Word=39;
   CC_QUERY_USB                    :Word=40;
	// 41 - 50
	CC_GET_PENTIUM_CYCLE_COUNT      :Word=41;
   CC_RW_USB_I2C                   :Word=42;
   CC_CFW                          :Word=43;
   CC_BIT_IO                       :Word=44;
// SBIG Use Only Commands
	CC_SEND_BLOCK                   :Word=90;
   CC_SEND_BYTE                    :Word=91;
   CC_GET_BYTE                     :Word=92;
   CC_SEND_AD                      :Word=93;
   CC_GET_AD                       :Word=94;
   CC_CLOCK_AD                     :Word=95;
   CC_SYSTEM_TEST                  :Word=96;
	CC_GET_DRIVER_OPTIONS           :Word=97;
   CC_SET_DRIVER_OPTIONS           :Word=98;
	CC_LAST_COMMAND                 :Word=99;

{

	Return Error Codes

	These are the error codes returned by the driver
	function.  They are prefixed with CE_ to designate
	them as camera errors.

}

   // 0 - 10
	CE_NO_ERROR                         :Word=0;
   CE_CAMERA_NOT_FOUND                 :Word=1;
   CE_ERROR_BASE                       :Word=1;
	CE_EXPOSURE_IN_PROGRESS             :Word=2;
   CE_NO_EXPOSURE_IN_PROGRESS          :Word=3;
	CE_UNKNOWN_COMMAND                  :Word=4;
   CE_BAD_CAMERA_COMMAND               :Word=5;
   CE_BAD_PARAMETER                    :Word=6;
	CE_TX_TIMEOUT                       :Word=7;
   CE_RX_TIMEOUT                       :Word=8;
   CE_NAK_RECEIVED                     :Word=9;
   CE_CAN_RECEIVED                     :Word=10;
	// 11 - 20
	CE_UNKNOWN_RESPONSE                 :Word=11;
   CE_BAD_LENGTH                       :Word=12;
	CE_AD_TIMEOUT                       :Word=13;
   CE_KBD_ESC                          :Word=14;
   CE_CHECKSUM_ERROR                   :Word=15;
   CE_EEPROM_ERROR                     :Word=16;
	CE_SHUTTER_ERROR                    :Word=17;
   CE_UNKNOWN_CAMERA                   :Word=18;
	CE_DRIVER_NOT_FOUND                 :Word=19;
   CE_DRIVER_NOT_OPEN                  :Word=20;
	// 21 - 30
	CE_DRIVER_NOT_CLOSED                :Word=21;
   CE_SHARE_ERROR                      :Word=22;
   CE_TCE_NOT_FOUND                    :Word=23;
   CE_AO_ERROR                         :Word=24;
	CE_ECP_ERROR                        :Word=25;
   CE_MEMORY_ERROR                     :Word=26;
   CE_DEVICE_NOT_FOUND                 :Word=27;
	CE_DEVICE_NOT_OPEN                  :Word=28;
   CE_DEVICE_NOT_CLOSED                :Word=29;
	CE_DEVICE_NOT_IMPLEMENTED           :Word=30;
	// 31 - 40
	CE_DEVICE_DISABLED                  :Word=31;
   CE_OS_ERROR                         :Word=32;
   CE_SOCK_ERROR                       :Word=33;
   CE_SERVER_NOT_FOUND                 :Word=34;
	CE_CFW_ERROR                        :Word=35;
   CE_NEXT_ERROR                       :Word=36;

{

	Camera Command State Codes

	These are the return status codes for the Query
	Command Status command.  Theyt are prefixed with
	CS_ to designate them as camera status.

}

  CS_IDLE                             = 0;
  CS_IN_PROGRESS                      = 1;
  CS_INTEGRATING                      = 2;
  CS_INTEGRATION_COMPLETE             = 3;

  CS_PULSE_IN_ACTIVE                  = $8000;
  CS_WAITING_FOR_TRIGGER              = $8000;


{
	Misc. Enumerated Constants

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
	AO_FOCUS_COMMAND - Used with the AO Set Focus Command
	SBIG_DEVICE_TYPE - Used with Open Device Command
	DRIVER_CONTROL_PARAMS - Used with Get/SetDriverControl Command
	USB_AD_CONTROL_COMMAND - Used with UsbADControl Command
	CFW_MODEL_SELECT, CFW_STATUS, CFW_ERROR - Used with CFW command
	CFW_POSITION, CFW_GET_INFO_SELECT - Used with CFW Command
	BIT_IO_OPERATION, BIT_IO_NMAE - Used with BitIO command


}

//typedef enum { ABG_LOW7, ABG_CLK_LOW7, ABG_CLK_MED7, ABG_CLK_HI7 } ABG_STATE7;
  ABG_LOW7                            = 0;
  ABG_CLK_LOW7                        = 1;
  ABG_CLK_MED7                        = 2;
  ABG_CLK_HI7                         = 3;

//typedef enum { DRIVER_STD, DRIVER_EXTENDED, DRIVER_USB_LOADER } DRIVER_REQUEST;
  DRIVER_STD                          = 0;
  DRIVER_EXTENDED                     = 1;
  DRIVER_USB_LOADER                   = 2;

// typedef enum { CCD_IMAGING, CCD_TRACKING, CCD_EXT_TRACKING } CCD_REQUEST;
  CCD_IMAGING                         = 0;
  CCD_TRACKING                        = 1;
  CCD_EXT_TRACKING                    = 2;

//typedef enum { CCD_INFO_IMAGING, CCD_INFO_TRACKING,
//	CCD_INFO_EXTENDED, CCD_INFO_EXTENDED_5C, CCD_INFO_EXTENDED2_IMAGING,
//	CCD_INFO_EXTENDED2_TRACKING } CCD_INFO_REQUEST;
  CCD_INFO_IMAGING                    = 0;
  CCD_INFO_TRACKING                   = 1;
  CCD_INFO_EXTENDED                   = 2;
  CCD_INFO_EXTENDED_5C                = 3;
  CCD_INFO_EXTENDED2_IMAGING          = 4;
  CCD_INFO_EXTENDED2_TRACKING         = 5;

//typedef enum { ABG_NOT_PRESENT, ABG_PRESENT } IMAGING_ABG;
  ABG_NOT_PRESENT                     = 0;
  ABG_PRESENT                         = 1;

//  BASE_ADDR                           = 0;
//  PORT0                               = 1;
//  PORT1                               = 2;
//  PORT2                               = 3;
//} PORT;

//typedef enum { BR_AUTO, BR_9600, BR_19K, BR_38K, BR_57K, BR_115K } PORT_RATE;
  BR_AUTO                             = 0;
  BR_9600                             = 1;
  BR_19K                              = 2;
  BR_38K                              = 3;
  BR_57K                              = 4;
  BR_115K                             = 5;

//typedef enum { ST7_CAMERA=4, ST8_CAMERA, ST5C_CAMERA, TCE_CONTROLLER,
//  ST237_CAMERA, STK_CAMERA, ST9_CAMERA, STV_CAMERA, ST10_CAMERA,
//  ST1K_CAMERA, ST2K_CAMERA, STL_CAMERA, ST402_CAMERA, NEXT_CAMERA, NO_CAMERA=0xFFFF } CAMERA_TYPE;
  ST7_CAMERA                          = 4;
  ST8_CAMERA                          = 5;
  ST5C_CAMERA                         = 6;
  TCE_CONTROLLER                      = 7;
  ST237_CAMERA                        = 8;
  STK_CAMERA                          = 9;
  ST9_CAMERA                          = 10;
  STV_CAMERA                          = 11;
  ST10_CAMERA                         = 12;
  ST1K_CAMERA                         = 13;
  ST2K_CAMERA                         = 14;
  STL_CAMERA                          = 15;
  ST402_CAMERA                        = 16;
  NEXT_CAMERA                         = 17;
  NO_CAMERA                           = $FFFF;

//typedef enum { SC_LEAVE_SHUTTER, SC_OPEN_SHUTTER, SC_CLOSE_SHUTTER,
//	 SC_INITIALIZE_SHUTTER, SC_OPEN_EXT_SHUTTER, SC_CLOSE_EXT_SHUTTER} SHUTTER_COMMAND;
  SC_LEAVE_SHUTTER                    = 0;
  SC_OPEN_SHUTTER                     = 1;
  SC_CLOSE_SHUTTER                    = 2;
  SC_INITIALIZE_SHUTTER               = 3;
  SC_OPEN_EXT_SHUTTER                 = 4;
  SC_CLOSE_EXT_SHUTTER                = 5;

//typedef enum { SS_OPEN, SS_CLOSED, SS_OPENING, SS_CLOSING } SHUTTER_STATE7;
  SS_OPEN                             = 0;
  SS_CLOSED                           = 1;
  SS_OPENING                          = 2;
  SS_CLOSING                          = 3;

//typedef enum { REGULATION_OFF, REGULATION_ON,
//	REGULATION_OVERRIDE, REGULATION_FREEZE, REGULATION_UNFREEZE,
//	REGULATION_ENABLE_AUTOFREEZE, REGULATION_DISABLE_AUTOFREEZE } TEMPERATURE_REGULATION;
  REGULATION_OFF                      = 0;
  REGULATION_ON                       = 1;
  REGULATION_OVERRIDE                 = 2;
  REGULATION_FREEZE                   = 3;
  REGULATION_UNFREEZE                 = 4;
  REGULATION_ENABLE_AUTOFREEZE        = 5;
  REGULATION_DISABLE_AUTOFREEZE       = 6;

//#define REGULATION_FROZEN_MASK 0x8000
  REGULATION_FROZEN_MASK              = $8000;

//typedef enum { LED_OFF, LED_ON, LED_BLINK_LOW, LED_BLINK_HIGH } LED_STATE;
  LED_OFF                             = 0;
  LED_ON                              = 1;
  LED_BLINK_LOW                       = 2;
  LED_BLINK_HIGH                      = 3;

//typedef enum { FILTER_LEAVE, FILTER_SET_1, FILTER_SET_2, FILTER_SET_3,
//	FILTER_SET_4, FILTER_SET_5, FILTER_STOP, FILTER_INIT } FILTER_COMMAND;
  FILTER_LEAVE                        = 0;
  FILTER_SET_1                        = 1;
  FILTER_SET_2                        = 2;
  FILTER_SET_3                        = 3;
  FILTER_SET_4                        = 4;
  FILTER_SET_5                        = 5;
  FILTER_STOP                         = 6;
  FILTER_INIT                         = 7;

//typedef enum { FS_MOVING, FS_AT_1, FS_AT_2, FS_AT_3,
//	FS_AT_4, FS_AT_5, FS_UNKNOWN } FILTER_STATE;
  FS_MOVING                           = 0;
  FS_AT_1                             = 1;
  FS_AT_2                             = 2;
  FS_AT_3                             = 3;
  FS_AT_4                             = 4;
  FS_AT_5                             = 5;
  FS_UNKNOWN                          = 6;

//typedef enum { AD_UNKNOWN, AD_12_BITS, AD_16_BITS } AD_SIZE;
  AD_UNKNOWN                          = 0;
  AD_12_BITS                          = 1;
  AD_16_BITS                          = 2;

//typedef enum { FW_UNKNOWN, FW_EXTERNAL, FW_VANE, FW_FILTER_WHEEL } FILTER_TYPE;
  FW_UNKNOWN                          = 0;
  FW_EXTERNAL                         = 1;
  FW_VANE                             = 2;
  FW_FILTER_WHEEL                     = 3;

//typedef enum { AOF_HARD_CENTER, AOF_SOFT_CENTER, AOF_STEP_IN,
//  AOF_STEP_OUT } AO_FOCUS_COMMAND;
  AOF_HARD_CENTER                     = 0;
  AOF_SOFT_CENTER                     = 1;
  AOF_STEP_IN                         = 2;
  AOF_STEP_OUT                        = 3;

//typedef enum { DEV_NONE, DEV_LPT1, DEV_LPT2, DEV_LPT3,
//  DEV_USB=0x7F00, DEV_ETH, DEV_USB1, DEV_USB2, DEV_USB3, DEV_USB4 } SBIG_DEVICE_TYPE;
  DEV_NONE                            = 0;
  DEV_LPT1                            = 1;
  DEV_LPT2                            = 2;
  DEV_LPT3                            = 3;
  DEV_USB                             = $7F00;
  DEV_ETH                             = $7F01;
  DEV_USB1                            = $7F02;
  DEV_USB2                            = $7F03;
  DEV_USB3                            = $7F04;
  DEV_USB4                            = $7F05;

//typedef enum { DCP_USB_FIFO_ENABLE, DCP_CALL_JOURNAL_ENABLE,
//	DCP_IVTOH_RATIO, DCP_USB_FIFO_SIZE, DCP_USB_DRIVER, DCP_KAI_RELGAIN,
//	DCP_USB_PIXEL_DL_ENABLE, DCP_HIGH_THROUGHPUT, DCP_VDD_OPTIMIZED,
//	DCP_AUTO_AD_GAIN, DCP_LAST } DRIVER_CONTROL_PARAM;
  DCP_USB_FIFO_ENABLE                 = 0;
  DCP_CALL_JOURNAL_ENABLE             = 1;
  DCP_IVTOH_RATIO                     = 2;
  DCP_USB_FIFO_SIZE                   = 3;
  DCP_USB_DRIVER                      = 4;
  DCP_KAI_RELGAIN                     = 5;
  DCP_USB_PIXEL_DL_ENABLE             = 6;
  DCP_HIGH_THROUGHPUT                 = 7;
  DCP_VDD_OPTIMIZED                   = 8;
  DCP_AUTO_AD_GAIN                    = 9;
  DCP_LAST                            = 10;

//typedef enum { USB_AD_IMAGING_GAIN, USB_AD_IMAGING_OFFSET, USB_AD_TRACKING_GAIN,
//	USB_AD_TRACKING_OFFSET } USB_AD_CONTROL_COMMAND;
  USB_AD_IMAGING_GAIN                 = 0;
  USB_AD_IMAGING_OFFSET               = 1;
  USB_AD_TRACKING_GAIN                = 2;
  USB_AD_TRACKING_OFFSET              = 3;

//typedef enum { USBD_SBIGE, USBD_SBIGI, USBD_SBIGM, USBD_NEXT } ENUM_USB_DRIVER;
  USBD_SBIGE                          = 0;
  USBD_SBIGI                          = 1;
  USBD_SBIGM                          = 2;
  USBD_NEXT                           = 3;

//typedef enum { CFWSEL_UNKNOWN, CFWSEL_CFW2, CFWSEL_CFW5, CFWSEL_CFW8, CFWSEL_CFWL,
//	CFWSEL_CFW402, CFWSEL_AUTO, CFWSEL_CFW6A, CFWSEL_CFW10,
//	CFWSEL_CFW10_SERIAL } CFW_MODEL_SELECT;
  CFWSEL_UNKNOWN                      = 0;
  CFWSEL_CFW2                         = 1;
  CFWSEL_CFW5                         = 2;
  CFWSEL_CFW8                         = 3;
  CFWSEL_CFWL                         = 4;
  CFWSEL_CFW402                       = 5;
  CFWSEL_AUTO                         = 6;
  CFWSEL_CFW6A                        = 7;
  CFWSEL_CFW10                        = 8;
  CFWSEL_CFW10_SERIAL                 = 9;

//typedef enum { CFWC_QUERY, CFWC_GOTO, CFWC_INIT, CFWC_GET_INFO,
//			   CFWC_OPEN_DEVICE, CFWC_CLOSE_DEVICE } CFW_COMMAND;
  CFWC_QUERY                          = 0;
  CFWC_GOTO                           = 1;
  CFWC_INIT                           = 2;
  CFWC_GET_INFO                       = 3;
  CFWC_OPEN_DEVICE                    = 4;
  CFWC_CLOSE_DEVICE                   = 5;

//typedef enum { CFWS_UNKNOWN, CFWS_IDLE, CFWS_BUSY } CFW_STATUS;
  CFWS_UNKNOWN                        = 0;
  CFWS_IDLE                           = 1;
  CFWS_BUSY                           = 2;

//typedef enum { CFWE_NONE, CFWE_BUSY, CFWE_BAD_COMMAND, CFWE_CAL_ERROR, CFWE_MOTOR_TIMEOUT,
//				CFWE_BAD_MODEL, CFWE_DEVICE_NOT_CLOSED, CFWE_DEVICE_NOT_OPEN,
//				CFWE_I2C_ERROR,} CFW_ERROR;
  CFWE_NONE                           = 0;
  CFWE_BUSY                           = 1;
  CFWE_BAD_COMMAND                    = 2;
  CFWE_CAL_ERROR                      = 3;
  CFWE_MOTOR_TIMEOUT                  = 4;
  CFWE_BAD_MODEL                      = 5;
  CFWE_DEVICE_NOT_CLOSED              = 6;
  CFWE_DEVICE_NOT_OPEN                = 7;
  CFWE_I2C_ERROR                      = 8;

//typedef enum { CFWP_UNKNOWN, CFWP_1, CFWP_2, CFWP_3, CFWP_4, CFWP_5, CFWP_6,
//				CFWP_7, CFWP_8, CFWP_9, CFWP_10} CFW_POSITION;
  CFWP_UNKNOWN                        = 0;
  CFWP_1                              = 1;
  CFWP_2                              = 2;
  CFWP_3                              = 3;
  CFWP_4                              = 4;
  CFWP_5                              = 5;
  CFWP_6                              = 6;
  CFWP_7                              = 7;
  CFWP_8                              = 8;
  CFWP_9                              = 9;
  CFWP_10                             = 10;

//typedef enum { CFWPORT_COM1=1, CFWPORT_COM2, CFWPORT_COM3, CFWPORT_COM4 } CFW_COM_PORT;
   CFWPORT_COM1                       = 1;
   CFWPORT_COM2                       = 2;
   CFWPORT_COM3                       = 3;
   CFWPORT_COM4                       = 4;

//typedef enum { CFWG_FIRMWARE_VERSION, CFWG_CAL_DATA, CFWG_DATA_REGISTERS } CFW_GETINFO_SELECT;
  CFWG_FIRMWARE_VERSION               = 0;
  CFWG_CAL_DATA                       = 1;
  CFWG_DATA_REGISTERS                 = 2;

//typedef enum { BITIO_WRITE, BITIO_READ } BITIO_OPERATION;
  BITIO_WRITE                         = 0;
  BITIO_READ                          = 1;

//typedef enum { BITI_PS_LOW, BITO_IO1, BITO_IO2, BITI_IO3, BITO_FPGA_WE } BITIO_NAME;
  BITI_PS_LOW                         = 0;
  BITO_IO1                            = 1;
  BITO_IO2                            = 2;
  BITI_IO3                            = 3;
  BITO_FPGA_WE                        = 4;

//	General Purpose Flags

END_SKIP_DELAY                        = $8000;     // set in ccd parameter of EndExposure
                                                   // command to skip synchronization
			                                          // delay - Use this to increase the
			                                          // rep rate when taking darks to later
			                                          // be subtracted from SC_LEAVE_SHUTTER
			                                          // exposures such as when tracking and imaging
START_SKIP_VDD			                 = $8000;		// set in ccd parameter of StartExposure
											                  //command to skip lowering Imaging CCD
											                  //Vdd during integration. - Use this to
											                  //increase the rep rate when you don't
											                  //care about glow in the upper-left
											                  //corner of the imaging CCD
START_MOTOR_ALWAYS_ON	              = $4000;		// set in ccd parameter of StartExposure
											                  //and EndExposure commands to force shutter
											                  //motor to stay on all the time which reduces
											                  //delays in Start and End Exposure timing and
											                  //yields higher image throughput.  Don't
											                  //do this too often or camera head will
											                  //heat up
EXP_WAIT_FOR_TRIGGER_IN               = $80000000; // set in exposureTime to wait for trigger in pulse
EXP_SEND_TRIGGER_OUT                  = $40000000; // set in exposureTime to send trigger out Y-
EXP_LIGHT_CLEAR	                    = $20000000; // set to do light clear of the CCD (Kaiser only)
EXP_MS_EXPOSURE			              = $10000000; // set to interpret exposure time as milliseconds
EXP_TIME_MASK                         = $00FFFFFF; // mask with exposure time to remove flags

//  Capabilities Bits - Bit Field Definitions for the
//  capabilitiesBits in the GetCCDInfoResults4 struct.

CB_CCD_TYPE_MASK			              = $0001;		// mask for CCD type
CB_CCD_TYPE_FULL_FRAME		           = $0000;		// b0=0 is full frame CCD
CB_CCD_TYPE_FRAME_TRANSFER	           = $0001;		// b0=1 is frame transfer CCD
CB_CCD_ESHUTTER_MASK		              = $0002;		// mask for electronic shutter type
CB_CCD_ESHUTTER_NO		              = $0000;		// b1=0 indicates no electronic shutter
CB_CCD_ESHUTTER_YES			           = $0002;		// b1=1 indicates electronic shutter

//	Defines

MIN_ST7_EXPOSURE                      = 12;        // Minimum exposure in 1/100ths second
MIN_ST402_EXPOSURE	                 = 4;      	// Minimum exposure in 1/100ths second
MIN_ST3200_EXPOSURE	                 = 9;	      // Minimum exposure in 1/100ths second

{

	Command Parameter and Results Structs

	Make sure you set your compiler for byte structure alignment
	as that is how the driver was built.

}

type

Char64=array[1..64] of char;

//typedef struct {
//	unsigned short /* CCD_REQUEST */ ccd;
//	unsigned long exposureTime;
//	unsigned short /* ABG_STATE7 */ abgState;
//	unsigned short /* SHUTTER_COMMAND */ openShutter;
//	} StartExposureParams;
TStartExposureParams = packed record
  ccd:Word;             // CCD_REQUEST
  exposureTime:Integer;
  abgState:Word;        // ABG_STATE7
  openShutter:Word;     // SHUTTER_COMMAND
  end;

//  typedef struct {
//	unsigned short /* CCD_REQUEST */ ccd;
//	} EndExposureParams;
TEndExposureParams = packed record
  ccd:Word; // CCD_REQUEST
  end;

//  typedef struct {
//	unsigned short /* CCD_REQUEST */ ccd;
//	unsigned short readoutMode;
//	unsigned short pixelStart;
//	unsigned short pixelLength;
//	} ReadoutLineParams;
TReadoutLineParams = packed record
  ccd:Word; // CCD_REQUEST */
  readoutMode:Word;
  pixelStart:Word;
  pixelLength:Word;
  end;

//  typedef struct {
//	unsigned short /* CCD_REQUEST */ ccd;
//	unsigned short readoutMode;
//	unsigned short lineLength;
//	} DumpLinesParams;
TDumpLinesParams = packed record
  ccd:Word; // CCD_REQUEST
  readoutMode:Word;
  lineLength:Word;
  end;

//  typedef struct {
//	unsigned short /* CCD_REQUEST */ ccd;
//	} EndReadoutParams;
TEndReadoutParams = packed record
  ccd:Word; // CCD_REQUEST
  end;

//typedef struct {
//	unsigned short /* CCD_REQUEST */ ccd;
//	unsigned short readoutMode;
//	unsigned short top;
//	unsigned short left;
//	unsigned short height;
//	unsigned short width;
//} StartReadoutParams;
TStartReadoutParams = packed record
	ccd:Word; // CCD_REQUEST
	readoutMode:Word;
	top:Word;
	left:Word;
	height:Word;
	width:Word;
   end;

//typedef struct {
//	unsigned short /* TEMPERATURE_REGULATION */ regulation;
//	unsigned short ccdSetpoint;
//	} SetTemperatureRegulationParams;
TSetTemperatureRegulationParams = packed record
  regulation:Word; // TEMPERATURE_REGULATION
  ccdSetpoint:Word;
  end;

//typedef struct {
//	MY_LOGICAL enabled;
//	unsigned short ccdSetpoint;
//	unsigned short power;
//	unsigned short ccdThermistor;
//	unsigned short ambientThermistor;
//	} QueryTemperatureStatusResults;
TQueryTemperatureStatusResults = packed record
  enabled:WordBool;
  ccdSetpoint:Word;
  power:Word;
  ccdThermistor:Word;
  ambientThermistor:Word;
  end;

//typedef struct {
//	unsigned short tXPlus;
//	unsigned short tXMinus;
//	unsigned short tYPlus;
//	unsigned short tYMinus;
//	} ActivateRelayParams;
TActivateRelayParams = packed record
  tXPlus:Word;
  tXMinus:Word;
  tYPlus:Word;
  tYMinus:Word;
  end;

//typedef struct {
//	unsigned short numberPulses;
//	unsigned short pulseWidth;
//	unsigned short pulsePeriod;
//	} PulseOutParams;
TPulseOutParams = packed record
  numberPulses:Word;
  pulseWidth:Word;
  pulsePeriod:Word;
  end;

//typedef struct {
//	unsigned short dataLength;
//	unsigned char data[256];
//	} TXSerialBytesParams;
TXSerialBytesParams = packed record
  dataLength:Word;
  data:array[1..256] of char;
  end;

//typedef struct {
//	unsigned short bytesSent;
//	} TXSerialBytesResults;
TXSerialBytesResults = packed record
  bytesSent:Word;
  end;

//typedef struct {
//	MY_LOGICAL clearToCOM;
//	} GetSerialStatusResults;
TGetSerialStatusResults = packed record
  clearToCOM:WordBool;
  end;

//typedef struct {
//	unsigned short sbigUseOnly;
//	} EstablishLinkParams;
TEstablishLinkParams = packed record
//  port:Word; // PORT
//  baseAddress:Word;
  sbigUseOnly:Word;
  end;

//typedef struct {
//	unsigned short /* CAMERA_TYPE */ cameraType;
//	} EstablishLinkResults;
TEstablishLinkResults = packed record
  cameraType:Word; //CAMERA_TYPE
  end;

//typedef struct {
//	unsigned short /* DRIVER_REQUEST */ request;
//	} GetDriverInfoParams;
TGetDriverInfoParams = packed record
  request:Word; // DRIVER_REQUEST
  end;

//typedef struct {
//	unsigned short version;
//	char name[64];
//	unsigned short maxRequest;
//	} GetDriverInfoResults0;
TGetDriverInfoResults0 = packed record
  version:Word;
  name:Char64;
  maxRequest:Word;
  end;

//typedef struct {
//	unsigned short /* CCD_INFO_REQUEST */ request;
//	} GetCCDInfoParams;
TGetCCDInfoParams = packed record
  request:Word; // CCD_INFO_REQUEST
  end;

//typedef struct {
//	unsigned short mode;
//	unsigned short width;
//	unsigned short height;
//	unsigned short gain;
//	unsigned long pixel_width;
//	unsigned long pixel_height;
//	} READOUT_INFO;
TReadoutInfo = packed record
  Mode:Word;
  Width:Word;
  Height:Word;
  Gain:Word;
  PixelWidth:Cardinal;
  PixelHeight:Cardinal;
  end;

//typedef struct {
//	unsigned short firmwareVersion;
//	unsigned short /* CAMERA_TYPE */ cameraType;
//	char name[64];
//	unsigned short readoutModes;
//	struct {
//		unsigned short mode;
//		unsigned short width;
//		unsigned short height;
//		unsigned short gain;
//		unsigned long pixelWidth;
//		unsigned long pixelHeight;
//		} readoutInfo[20];
//	} GetCCDInfoResults0;
TGetCCDInfoResults0 = packed record
  FirmwareVersion:Word;
  CameraType:Word; // CAMERA_TYPE
  Name:array[1..64] of Char;
  ReadoutModes:Word;
  ReadoutInfo:array[1..20] of TReadoutInfo;
  end;

//typedef struct {
//	unsigned short badColumns;
//	unsigned short columns[4];
//	unsigned short /* IMAGING_ABG */ imagingABG;
//	char serialNumber[10];
//	} GetCCDInfoResults2;
TGetCCDInfoResults2 = packed record
  BadColumns:Word;
  Columns:array[1..4] of Word;
  ImagingABG:Word; // IMAGING_ABG
  SerialNumber:array[1..10] of Char;
  end;

//typedef struct {
//	unsigned short /* AD_SIZE */ adSize;
//	unsigned short /* FILTER_TYPE */ filterType;
//	} GetCCDInfoResults3;
TGetCCDInfoResults3 = packed record
  adSize:Word; // AD_SIZE
  filterType:Word; // FILTER_TYPE
  end;

//typedef struct {
//	unsigned short capabilitiesBits;
//	unsigned short dumpExtra;
//} GetCCDInfoResults4;
TGetCCDInfoResults4 = packed record
   capabilitiesBits:Word;
	dumpExtra:Word;
   end;

//typedef struct {
//	unsigned short command;
//	} QueryCommandStatusParams;
TQueryCommandStatusParams = packed record
  command:Word;
  end;

//typedef struct {
//	unsigned short status;
//	} QueryCommandStatusResults;
TQueryCommandStatusResults = packed record
  status:Word;
  end;

//typedef struct {
//	MY_LOGICAL fanEnable;
//	unsigned short /* SHUTTER_COMMAND */ shutterCommand;
//	unsigned short /* LED_STATE */ ledState;
//	} MiscellaneousControlParams;
TMiscellaneousControlParams = packed record
  fanEnable:WordBool;
  shutterCommand:Word; // SHUTTER_COMMAND
  ledState:Word; // LED_STATE
  end;

//typedef struct {
//	unsigned short /* CCD_REQUEST */ ccd;
//	} ReadOffsetParams;
TReadOffsetParams = packed record
  ccd:Word; // CCD_REQUEST
  end;

//typedef struct {
//	unsigned short offset;
//	} ReadOffsetResults;
TReadOffsetResults = packed record
  offset:Word;
  end;

//typedef struct {
//	unsigned short xDeflection;
//	unsigned short yDeflection;
//	} AOTipTiltParams;
TAOTipTiltParams = packed record
  xDeflection:Word;
  yDeflection:Word;
  end;

//typedef struct {
//	unsigned short /* AO_FOCUS_COMMAND */ focusCommand;
//	} AOSetFocusParams;
TAOSetFocusParams = packed record
  focusCommand:Word; // AO_FOCUS_COMMAND
  end;

//typedef struct {
//	unsigned long delay;
//    } AODelayParams;
TAODelayParams = packed record
  delay:Cardinal;
  end;

//typedef struct {
//	MY_LOGICAL turboDetected;
//    } GetTurboStatusResults;
TGetTurboStatusResults = packed record
  TurboDetected:WordBool;
  end;

//typedef struct {
//	unsigned short	deviceType;		/* SBIG_DEVICE_TYPE, specifies LPT, Ethernet, etc */
//	unsigned short	lptBaseAddress;	/* DEV_LPTN: Windows 9x Only, Win NT uses deviceSelect */
//	unsigned long	ipAddress;		/* DEV_ETH:  Ethernet address */
//	} OpenDeviceParams;
TOpenDeviceParams = packed record
//  Port:Word;
  deviceType:Word;		// SBIG_DEVICE_TYPE, specifies LPT, Ethernet, etc
  lptBaseAddress:Word;	// DEV_LPTN: Windows 9x Only, Win NT uses deviceSelect *
  ipAddress:Cardinal;	// DEV_ETH:  Ethernet address 
  end;

//typedef struct {
//	unsigned short level;
//	} SetIRQLParams;
TSetIRQLParams = packed record
  Level:Word;
  end;

//typedef struct {
//	unsigned short level;
//	} GetIRQLResults;
TGetIRQLResults = packed record
  Level:Word;
  end;

//typedef struct {
//	MY_LOGICAL	linkEstablished;
//	unsigned short baseAddress;
//	unsigned short /* CAMERA_TYPE */ cameraType;
//    unsigned long comTotal;
//    unsigned long comFailed;
//    } GetLinkStatusResults;
TGetLinkStatusResults = packed record
  linkEstablished:WordBool;
  baseAddress:Word;
  cameraType:Word; // CAMERA_TYPE
  comTotal:Cardinal;
  comFailed:Cardinal;
  end;

//typedef struct {
//	unsigned long count;
//	} GetUSTimerResults;
TGetUSTimerResults = packed record
  Count:Cardinal;
  end;

//typedef struct {
//	unsigned short port;
//	unsigned short length;
//	unsigned char *source;
//	} SendBlockParams;
TSendBlockParams = packed record
  Port:Word;
  Length:Word;
  Source:PChar;
  end;

//typedef struct {
//	unsigned short port;
//	unsigned short data;
//	} SendByteParams;
TSendByteParams = packed record
  Port:Word;
  Data:Word;
  end;

//typedef struct {
//	unsigned short /* CCD_REQUEST */ ccd;
//	unsigned short readoutMode;
//	unsigned short pixelStart;
//	unsigned short pixelLength;
//    } ClockADParams;
TClockADParams = packed record
  Ccd:Word; // CCD_REQUEST
  ReadoutMode:Word;
  PixelStart:Word;
  PixelLength:Word;
  end;

//typedef struct {
//	unsigned short testClocks;
//	unsigned short testMotor;
//    unsigned short test5800;
//	unsigned short stlAlign;
//	unsigned short motorAlwaysOn;
//	} SystemTestParams;
TSystemTestParams = packed record
  testClocks:Word;
  testMotor:Word;
  test5800:Word;
  stlAlign:Word;
  motorAlwaysOn:Word;
  end;

//typedef struct {
//    unsigned short outLength;
//    unsigned char *outPtr;
//    unsigned short inLength;
//    unsigned char *inPtr;
//	} SendSTVBlockParams;
TSendSTVBlockParams = packed record
  outLength:Word;
  outPtr:PChar;
  inLength:Word;
  inPtr:PChar;
  end;

//typedef struct {
//	unsigned short errorNo;
//	} GetErrorStringParams;
TGetErrorStringParams = packed record
  errorNo:Word;
  end;

//typedef struct {
//	char errorString[64];
//	} GetErrorStringResults;
TGetErrorStringResults = packed record
  errorString:Char64;
  end;

//typedef struct {
//	short handle;
//	} SetDriverHandleParams;
TSetDriverHandleParams = packed record
  handle:Integer;
  end;

//typedef struct {
//	short handle;
//	} GetDriverHandleResults;
TGetDriverHandleResults = packed record
  handle:Integer;
  end;

//typedef struct {
//	unsigned short /* DRIVER_CONTROL_PARAM */ controlParameter;
//	unsigned long controlValue;
//} SetDriverControlParams;
TSetDriverControlParams = packed record
  controlParameter:Word; // DRIVER_CONTROL_PARAM
  controlValue:Cardinal;
  end;

//typedef struct {
//	unsigned short /* DRIVER_CONTROL_PARAM */ controlParameter;
//} GetDriverControlParams;
TGetDriverControlParams = packed record
  controlParameter:Word; // DRIVER_CONTROL_PARAM
  end;

//typedef struct {
//	unsigned long controlValue;
//} GetDriverControlResults;
TGetDriverControlResults = packed record
  controlValue:Cardinal;
  end;

//typedef struct {
//	unsigned short /* USB_AD_CONTROL_COMMAND */ command;
//	short data;
//} USBADControlParams;
TUSBADControlParams = packed record
  command:Word; // USB_AD_CONTROL_COMMAND
  data:Integer;
  end;

//typedef struct {
//	MY_LOGICAL cameraFound;
//	unsigned short /* CAMERA_TYPE */ cameraType;
//	char name[64];
//	char serialNumber[10];
//} QUERY_USB_INFO;
TQUERY_USB_INFO = packed record
  cameraFound:WordBool;
  cameraTypeWord:Word; // CAMERA_TYPE
  name:Char64;
  serialNumber:array[1..10] of char;
  end;

//typedef struct {
//	unsigned short camerasFound;
//	QUERY_USB_INFO usbInfo[4];
//} QueryUSBResults;
TQueryUSBResults = packed record
  camerasFound:Word;
  usbInfo:array[1..4] of TQUERY_USB_INFO;
  end;

//typedef struct {
//	unsigned short rightShift;
//} GetPentiumCycleCountParams;
TGetPentiumCycleCountParams = packed record
  rightShift:Word;
  end;

//typedef struct {
//	unsigned long countLow;
//	unsigned long countHigh;
//} GetPentiumCycleCountResults;
TGetPentiumCycleCountResults = packed record
  countLow:Cardinal;
  countHigh:Cardinal;
  end;

//typedef struct {
//	unsigned char address;
//	unsigned char data;
//	MY_LOGICAL write;
//	unsigned char deviceAddress;
//	} RWUSBI2CParams;
TRWUSBI2CParams = packed record
  address:Byte;
  data:Byte;
  write:WordBool;
  deviceAddress:Byte;
  end;

//typedef struct {
//	unsigned char data;
//	} RWUSBI2CResults;
TRWUSBI2CResults = packed record
  data:Byte;
  end;

//typedef struct {
//	unsigned short /* CFW_MODEL_SELECT */ cfwModel;
//	unsigned short /* CFW_COMMAND */ cfwCommand;
//	unsigned long cwfParam1;
//	unsigned long cfwParam2;
//    unsigned short outLength;
//
//    unsigned char *outPtr;
//    unsigned short inLength;
//    unsigned char *inPtr;
//} CFWParams;
TCFWParams = packed record
  cfwModel:Word; // CFW_MODEL_SELECT
  cfwCommand:Word; // CFW_COMMAND
  cwfParam1:Cardinal;
  cfwParam2:Cardinal;
  outLength:Word;
  outPtr:PChar;
  inLength:Word;
  inPtr:PChar;
  end;

//typedef struct {
//	unsigned short /* CFW_MODEL_SELECT */ cfwModel;
//	unsigned short /* CFW_POSITION */ cfwPosition;
//	unsigned short /* CFW_STATUS */ cfwStatus;
//	unsigned short /* CFW_ERROR */ cfwError;
//	unsigned long cfwResult1;
//	unsigned long cfwResult2;
//} CFWResults;
TCFWResults = packed record
  cfwModel:Word; // CFW_MODEL_SELECT
  cfwPosition:Word; // CFW_POSITION
  cfwStatus:Word; // CFW_STATUS
  cfwError:Word; // CFW_ERROR
  cfwResult1:Cardinal;
  cfwResult2:Cardinal;
  end;

//typedef struct {
//	unsigned short /* BITIO_OPERATION */ bitOperation;
//	unsigned short /* BITIO_NAME */ bitName;
//	MY_LOGICAL setBit;
//} BitIOParams;
TBitIOParams = packed record
  bitOperation:Word; // BITIO_OPERATION
  bitName:Word; // BITIO_NAME
  setBit:WordBool;
  end;

//typedef struct {
//	MY_LOGICAL bitIsSet;
//} BitIOResults;
TBitIOResults = packed record
  bitIsSet:WordBool;
  end;

{

	Function Prototypes

	This are the driver interface functions.

    SBIGUnivDrvCommand() - Supports Parallel, USB and Ethernet
				           based cameras.

	Each function takes a command parameter and pointers
	to parameters and results structs.

	The calling program needs to allocate the memory for
	the parameters and results structs and these routines
	read them and fill them in respectively.

}

function SBIGUnivDrvCommand(Command:Word;var Params,Results):Word;
         stdcall; external 'SBIGUDrv.dll' name 'SBIGUnivDrvCommand'; //nolang

function GetErrorSbig(NoError:Word):String;
function OpenDriverSbig:Word;
function CloseDriverSbig:Word;
//function OpenDeviceSbig(PortNumber:Byte;_BaseAddress:Word):Word;
function OpenDeviceSbigUSB:Word;
function OpenDeviceSbigParallel(PortNumber:Byte;_BaseAddress:Word):Word;
function CloseDeviceSbig:Word;
function GetDriverInfoSbig(_Version:Word;_Name:Char64;_MaxRequest:Word):Word;
function StartExposureSbig(_StateShutter,_ExposureTime:Integer):Word;
function StartExposureTrackSbig(_StateShutter,_ExposureTime:Integer):Word;
function EndExposureSbig:Word;
function EndExposureTrackSbig:Word;
function ReadoutLineSbig(_ReadoutMode:Word;_PixelStart:Word;_PixelLength:Word;var Line:TLigWord):Word;
function ReadoutLineTrackSbig(_ReadoutMode:Word;_PixelStart:Word;_PixelLength:Word):Word;
function DumpLineSbig(_ReadoutMode:Word;_LineLength:Word):Word;
function DumpLineTrackSbig(_ReadoutMode:Word;_LineLength:Word):Word;
function EndReadoutSbig:Word;
function EndReadoutTrackSbig:Word;
function SetTempRegulOnSbig(TempCible:Double):Word;
function SetTempRegulOffSbig:Word;
function SetTempRegulFreezeSbig:Word;
function SetTempRegulUnFreezeSbig(TempCible:Double):Word;
function QueryTempStatusSbig(var Temp:Double):Word;
function ActivateRelaySbig(DX,DY:Integer):Word;
function PutFilterSbig(NoFilter:Word):Word;
//function EstablishLinkSbig(_BaseAddress:Word;var NoCamera:Word):Word;
function EstablishLinkSbig(var NoCamera:Word):Word;
function GetCameraNameSbig(var NameOut:PChar):Word;
function GetCameraTrackNameSbig(var NameOut:PChar):Word;
function GetADSizeSbig(var Value:Word):Word;
function GetPixelWidthSbig(var Value:Double):Word;
function GetPixelHeightSbig(var Value:Double):Word;
function GetPixelTrackWidthSbig(var Value:Double):Word;
function GetPixelTrackHeightSbig(var Value:Double):Word;
function GetCameraWidthSbig(var Value:Word):Word;
function GetCameraHeightSbig(var Value:Word):Word;
function GetCameraTrackWidthSbig(var Value:Word):Word;
function GetCameraTrackHeightSbig(var Value:Word):Word;

implementation

uses Windows,
     u_general;

function GetErrorSbig(NoError:Word):string;
begin
if NoError=CE_CAMERA_NOT_FOUND        then Result:='Camera not found' else
if NoError=CE_EXPOSURE_IN_PROGRESS    then Result:='Exposure in progress' else
if NoError=CE_NO_EXPOSURE_IN_PROGRESS then Result:='No exposure un progress' else
if NoError=CE_UNKNOWN_COMMAND         then Result:='Unknown command' else
if NoError=CE_BAD_CAMERA_COMMAND      then Result:='Bad camera command' else
if NoError=CE_BAD_PARAMETER           then Result:='Bad parameter' else
if NoError=CE_TX_TIMEOUT              then Result:='TX time out' else
if NoError=CE_RX_TIMEOUT              then Result:='RX time out' else
if NoError=CE_NAK_RECEIVED            then Result:='NAK received' else
if NoError=CE_CAN_RECEIVED            then Result:='CAN received' else
if NoError=CE_UNKNOWN_RESPONSE        then Result:='Unknown response' else
if NoError=CE_BAD_LENGTH              then Result:='Bad length' else
if NoError=CE_AD_TIMEOUT              then Result:='AD time out' else
if NoError=CE_KBD_ESC                 then Result:='Keyboard escape ' else
if NoError=CE_CHECKSUM_ERROR          then Result:='Checksum error' else
if NoError=CE_EEPROM_ERROR            then Result:='EEPROM error' else
if NoError=CE_SHUTTER_ERROR           then Result:='Shutter error' else
if NoError=CE_UNKNOWN_CAMERA          then Result:='Unknown camera' else
if NoError=CE_DRIVER_NOT_FOUND        then Result:='Driver not found' else
if NoError=CE_DRIVER_NOT_OPEN         then Result:='Driver not open' else
if NoError=CE_DRIVER_NOT_CLOSED       then Result:='Driver not closed' else
if NoError=CE_SHARE_ERROR             then Result:='Share error' else
if NoError=CE_TCE_NOT_FOUND           then Result:='TCE not found' else
if NoError=CE_AO_ERROR                then Result:='AO error' else
if NoError=CE_ECP_ERROR               then Result:='ECP error' else
if NoError=CE_MEMORY_ERROR            then Result:='Memory error' else
if NoError=CE_DEVICE_NOT_FOUND        then Result:='Device not found' else
if NoError=CE_DEVICE_NOT_OPEN         then Result:='Device not open' else
if NoError=CE_DEVICE_NOT_CLOSED       then Result:='Device not closed' else
if NoError=CE_DEVICE_NOT_IMPLEMENTED  then Result:='Device not implemented' else
if NoError=CE_DEVICE_DISABLED         then Result:='Device desabled' else
if NoError=CE_OS_ERROR                then Result:='OS error' else
if NoError=CE_SOCK_ERROR              then Result:='Socket error' else
if NoError=CE_SERVER_NOT_FOUND        then Result:='Serveur not found' else
if NoError=CE_CFW_ERROR               then Result:='CFW error' else
if NoError=CE_NEXT_ERROR              then Result:='Next error'
else Result:='Erreur inconnue';
end;

function OpenDriverSbig:Word;
begin
Result:=SBIGUnivDrvCommand(CC_OPEN_DRIVER,nul,nul);
end;

function CloseDriverSbig:Word;
begin
Result:=SBIGUnivDrvCommand(CC_CLOSE_DRIVER,nul,nul);
end;

//function OpenDeviceSbig(PortNumber:Byte;_BaseAddress:Word):Word;
function OpenDeviceSbigUSB:Word;
var
   OpenDeviceParams:TOpenDeviceParams;
begin
//TOpenDeviceParams = packed record
//  deviceType:Word;		// SBIG_DEVICE_TYPE, specifies LPT, Ethernet, etc
//  lptBaseAddress:Word;	// DEV_LPTN: Windows 9x Only, Win NT uses deviceSelect *
//  ipAddress:Cardinal;	// DEV_ETH:  Ethernet address
//  end;
OpenDeviceParams.deviceType:=DEV_USB;
OpenDeviceParams.lptBaseAddress:=0;
Result:=SBIGUnivDrvCommand(CC_OPEN_DEVICE,OpenDeviceParams,nul);
end;

function OpenDeviceSbigParallel(PortNumber:Byte;_BaseAddress:Word):Word;
var
   OpenDeviceParams:TOpenDeviceParams;
begin
//TOpenDeviceParams = packed record
//  deviceType:Word;		// SBIG_DEVICE_TYPE, specifies LPT, Ethernet, etc
//  lptBaseAddress:Word;	// DEV_LPTN: Windows 9x Only, Win NT uses deviceSelect *
//  ipAddress:Cardinal;	// DEV_ETH:  Ethernet address
//  end;
OpenDeviceParams.deviceType:=PortNumber;
OpenDeviceParams.lptBaseAddress:=_BaseAddress;
Result:=SBIGUnivDrvCommand(CC_OPEN_DEVICE,OpenDeviceParams,nul);
end;

function CloseDeviceSbig:Word;
begin
Result:=SBIGUnivDrvCommand(CC_CLOSE_DEVICE,nul,nul);
end;

function GetDriverInfoSbig(_Version:Word;_Name:Char64;_MaxRequest:Word):Word;
var
   GetDriverInfoParams:TGetDriverInfoParams;
   GetDriverInfoResults0:TGetDriverInfoResults0;
begin
GetDriverInfoParams.Request:=0;
Result:=SBIGUnivDrvCommand(CC_GET_DRIVER_INFO,GetDriverInfoParams,GetDriverInfoResults0);
_Version:=GetDriverInfoResults0.Version;
_Name:=GetDriverInfoResults0.Name;
_MaxRequest:=GetDriverInfoResults0.MaxRequest;
end;

function StartExposureSbig(_StateShutter,_ExposureTime:Integer):Word;
var
   StartExposureParams:TStartExposureParams;
   Resultat:Word;
begin
StartExposureParams.Ccd:=0;
StartExposureParams.ExposureTime:=_ExposureTime;
StartExposureParams.AbgState:=0;
StartExposureParams.OpenShutter:=_StateShutter;
Resultat:=SBIGUnivDrvCommand(CC_START_EXPOSURE,StartExposureParams,nul);
// Deuxieme essai
if Resultat<>0 then Resultat:=SBIGUnivDrvCommand(CC_START_EXPOSURE,StartExposureParams,nul);
Result:=Resultat;
end;

function StartExposureTrackSbig(_StateShutter,_ExposureTime:Integer):Word;
var
   StartExposureParams:TStartExposureParams;
begin
StartExposureParams.Ccd:=1;
StartExposureParams.ExposureTime:=_ExposureTime;
StartExposureParams.AbgState:=0;
StartExposureParams.OpenShutter:=_StateShutter;
Result:=SBIGUnivDrvCommand(CC_START_EXPOSURE,StartExposureParams,nul);
end;

function EndExposureSbig:Word;
var
   EndExposureParams:TEndExposureParams;
begin
EndExposureParams.Ccd:=0;
Result:=SBIGUnivDrvCommand(CC_END_EXPOSURE,EndExposureParams,nul);
end;

function EndExposureTrackSbig:Word;
var
   EndExposureParams:TEndExposureParams;
begin
EndExposureParams.Ccd:=1;
Result:=SBIGUnivDrvCommand(CC_END_EXPOSURE,EndExposureParams,nul);
end;

function ReadoutLineSbig(_ReadoutMode:Word;_PixelStart:Word;_PixelLength:Word;var Line:TLigWord):Word;
var
   ReadoutLineParams:TReadoutLineParams;
begin
ReadoutLineParams.Ccd:=0;
ReadoutLineParams.ReadoutMode:=_ReadoutMode-1;
ReadoutLineParams.PixelStart:=_PixelStart;
ReadoutLineParams.PixelLength:=_PixelLength;
Result:=SBIGUnivDrvCommand(CC_READOUT_LINE,ReadoutLineParams,Line);
end;

function ReadoutLineTrackSbig(_ReadoutMode:Word;_PixelStart:Word;_PixelLength:Word):Word;
var
   ReadoutLineParams:TReadoutLineParams;
begin
ReadoutLineParams.Ccd:=1;
ReadoutLineParams.ReadoutMode:=_ReadoutMode;
ReadoutLineParams.PixelStart:=_PixelStart;
ReadoutLineParams.PixelLength:=_PixelLength;
Result:=SBIGUnivDrvCommand(CC_READOUT_LINE,ReadoutLineParams,nul);
end;

function DumpLineSbig(_ReadoutMode:Word;_LineLength:Word):Word;
var
   DumpLinesParams:TDumpLinesParams;
begin
DumpLinesParams.Ccd:=0;
DumpLinesParams.ReadoutMode:=_ReadoutMode;
DumpLinesParams.LineLength:=_LineLength;
Result:=SBIGUnivDrvCommand(CC_DUMP_LINES,DumpLinesParams,nul);
end;

function DumpLineTrackSbig(_ReadoutMode:Word;_LineLength:Word):Word;
var
   DumpLinesParams:TDumpLinesParams;
begin
DumpLinesParams.Ccd:=1;
DumpLinesParams.ReadoutMode:=_ReadoutMode;
DumpLinesParams.LineLength:=_LineLength;
Result:=SBIGUnivDrvCommand(CC_DUMP_LINES,DumpLinesParams,nul);
end;

function EndReadoutSbig:Word;
var
   EndReadoutParams:TEndReadoutParams;
begin
EndReadoutParams.Ccd:=0;
Result:=SBIGUnivDrvCommand(CC_END_READOUT,EndReadoutParams,nul);
end;

function EndReadoutTrackSbig:Word;
var
   EndReadoutParams:TEndReadoutParams;
begin
EndReadoutParams.Ccd:=1;
Result:=SBIGUnivDrvCommand(CC_END_READOUT,EndReadoutParams,nul);
end;

function SetTempRegulOnSbig(TempCible:Double):Word;
var
   SetTemperatureRegulationParams:TSetTemperatureRegulationParams;
   r:Double;
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
       ParDeviceCommandNHSbig(CC_SET_TEMPERATURE_REGULATION,SetTemperatureRegulationParams,null);}

SetTemperatureRegulationParams.Regulation:=1;
r:=3*exp((ln(2.57)*(25-TempCible))/25);
SetTemperatureRegulationParams.CcdSetpoint:=Round(4096/(10/r+1));
Result:=SBIGUnivDrvCommand(CC_SET_TEMPERATURE_REGULATION,SetTemperatureRegulationParams,nul);
end;

function SetTempRegulOffSbig:Word;
var
   SetTemperatureRegulationParams:TSetTemperatureRegulationParams;
begin
SetTemperatureRegulationParams.Regulation:=0;
SetTemperatureRegulationParams.CcdSetpoint:=0;
Result:=SBIGUnivDrvCommand(CC_SET_TEMPERATURE_REGULATION,SetTemperatureRegulationParams,nul);
end;

function SetTempRegulFreezeSbig:Word;
var
   SetTemperatureRegulationParams:TSetTemperatureRegulationParams;
begin
SetTemperatureRegulationParams.Regulation:=3;
SetTemperatureRegulationParams.CcdSetpoint:=0;
Result:=SBIGUnivDrvCommand(CC_SET_TEMPERATURE_REGULATION,SetTemperatureRegulationParams,nul);
end;

function SetTempRegulUnFreezeSbig(TempCible:Double):Word;
var
   SetTemperatureRegulationParams:TSetTemperatureRegulationParams;
   r:Double;
begin
SetTemperatureRegulationParams.Regulation:=4;
r:=3*exp((ln(2.57)*(25-TempCible))/25);
SetTemperatureRegulationParams.CcdSetpoint:=Round(4096/(10/r+1));
//SetTemperatureRegulationParams.CcdSetpoint:=0;
Result:=SBIGUnivDrvCommand(CC_SET_TEMPERATURE_REGULATION,SetTemperatureRegulationParams,nul);
end;

function QueryTempStatusSbig(var Temp:Double):Word;
var
   QueryTemperatureStatusResults:TQueryTemperatureStatusResults;
   r,s:Double;
begin
Temp:=-9999;
Result:=SBIGUnivDrvCommand(CC_QUERY_TEMPERATURE_STATUS,Nul,QueryTemperatureStatusResults);
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
function ActivateRelaySbig(DX,DY:Integer):Word;
var
   ActivateRelayParams:TActivateRelayParams;
begin
ActivateRelayParams.tXPlus:=0;
ActivateRelayParams.tYPlus:=0;
ActivateRelayParams.tXMinus:=0;
ActivateRelayParams.tYMinus:=0;
if DX>0 then ActivateRelayParams.tXPlus:=DX;
if DX<0 then ActivateRelayParams.tXMinus:=-DX;
if DY>0 then ActivateRelayParams.tYPlus:=DY;
if DY<0 then ActivateRelayParams.tYMinus:=-DY;
Result:=SBIGUnivDrvCommand(CC_ACTIVATE_RELAY,ActivateRelayParams,Nul);
end;

function PutFilterSbig(NoFilter:Word):Word;
var
   PulseOutParams:TPulseOutParams;
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
Result:=SBIGUnivDrvCommand(CC_PULSE_OUT,PulseOutParams,Nul);
MySleep(3000);
end;

//function EstablishLinkSbig(_BaseAddress:Word;var NoCamera:Word):Word;
function EstablishLinkSbig(var NoCamera:Word):Word;
var
   EstablishLinkParams:TEstablishLinkParams;
   EstablishLinkResults:TEstablishLinkResults;
begin
//EstablishLinkParams.Port:=2;
//TEstablishLinkParams = packed record
//  sbigUseOnly:Word;
//  end;

//EstablishLinkParams.Port:=0;
//EstablishLinkParams.baseAddress:=_BaseAddress;
EstablishLinkParams.sbigUseOnly:=0;
Result:=SBIGUnivDrvCommand(CC_ESTABLISH_LINK,EstablishLinkParams,EstablishLinkResults);
NoCamera:=EstablishLinkResults.CameraType;
end;

function GetCameraNameSbig(var NameOut:PChar):Word;
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
   NameString:string;
   i:Integer;
begin
GetCCDInfoParams.Request:=0;
Result:=SBIGUnivDrvCommand(CC_GET_CCD_INFO,GetCCDInfoParams,GetCCDInfoResults0);
i:=1;
while GetCCDInfoResults0.Name[i]<>#0 do
   begin
   SetLength(NameString,i);
   NameString[i]:=GetCCDInfoResults0.Name[i];
   Inc(i)
   end;
Dec(i);
SetLength(NameString,i);

Getmem(NameOut,i+1);
StrPCopy(NameOut,NameString);
end;

function GetCameraTrackNameSbig(var NameOut:PChar):Word;
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
   NameString:string;
   i:Integer;
begin
GetCCDInfoParams.Request:=1;
Result:=SBIGUnivDrvCommand(CC_GET_CCD_INFO,GetCCDInfoParams,GetCCDInfoResults0);
i:=1;
while GetCCDInfoResults0.Name[i]<>#0 do
   begin
   SetLength(NameString,i);
   NameString[i]:=GetCCDInfoResults0.Name[i];
   Inc(i)
   end;
Dec(i);
SetLength(NameString,i);

Getmem(NameOut,i+1);
StrPCopy(NameOut,NameString);
end;

function GetADSizeSbig(var Value:Word):Word;
var
   GetCCDInfoParams:TGetCCDInfoParams;
//TGetCCDInfoParams = packed record
//  request:Word; // CCD_INFO_REQUEST
//  end;
   GetCCDInfoResults3:TGetCCDInfoResults3;
//TGetCCDInfoResults3 = packed record
//  adSize:Word; // AD_SIZE
//  filterType:Word; // FILTER_TYPE
//  end;
begin
// Non !!!
//GetCCDInfoParams.Request:=3;
//Result:=SBIGUnivDrvCommand(CC_GET_CCD_INFO,GetCCDInfoParams,GetCCDInfoResults3);
//Value:=GetCCDInfoResults3.adSize;
// 0 = UnKnown
// 1 = 12 bits
// 2 = 16 bits
Result:=0;
Value:=16;
end;

function GetPixelWidthSbig(var Value:Double):Word;
var
   GetCCDInfoParams:TGetCCDInfoParams;
//TGetCCDInfoParams = packed record
//  request:Word; // CCD_INFO_REQUEST
//  end;
   GetCCDInfoResults0:TGetCCDInfoResults0;
//TGetCCDInfoResults0 = packed record
//  FirmwareVersion:Word;
//  CameraType:Word; // CAMERA_TYPE
//  Name:array[1..64] of Char;
//  ReadoutModes:Word;
//  ReadoutInfo:array[1..20] of TReadoutInfo;
//  end;
   ReadoutInfo:TReadoutInfo;
//TReadoutInfo = packed record
//  Mode:Word;
//  Width:Word;
//  Height:Word;
//  Gain:Word;
//  PixelWidth:Cardinal;
//  PixelHeight:Cardinal;
//  end;
   BCD:Cardinal;  // 32 bits non signé
begin
GetCCDInfoParams.Request:=0;
Result:=SBIGUnivDrvCommand(CC_GET_CCD_INFO,GetCCDInfoParams,GetCCDInfoResults0);
ReadoutInfo:=GetCCDInfoResults0.ReadoutInfo[1];
BCD:=GetCCDInfoResults0.ReadoutInfo[1].PixelWidth;
Value:=(((BCD and $f0000000) shr 28)*10e7
      + ((BCD and $0f000000) shr 24)*10e6
      + ((BCD and $00f00000) shr 20)*10e5
      + ((BCD and $000f0000) shr 16)*10e4
      + ((BCD and $0000f000) shr 12)*10e3
      + ((BCD and $00000f00) shr 8 )*10e2
      + ((BCD and $000000f0) shr 4 )*10
      +  (BCD and $0000000f))/100;
//  WHeures:=((Heures and $f0) shr 4)*10+(Heures and $0f);   Heure = Word
end;

function GetPixelHeightSbig(var Value:Double):Word;
var
   GetCCDInfoParams:TGetCCDInfoParams;
//TGetCCDInfoParams = packed record
//  request:Word; // CCD_INFO_REQUEST
//  end;
   GetCCDInfoResults0:TGetCCDInfoResults0;
//TGetCCDInfoResults0 = packed record
//  FirmwareVersion:Word;
//  CameraType:Word; // CAMERA_TYPE
//  Name:array[1..64] of Char;
//  ReadoutModes:Word;
//  ReadoutInfo:array[1..20] of TReadoutInfo;
//  end;
   ReadoutInfo:TReadoutInfo;
//TReadoutInfo = packed record
//  Mode:Word;
//  Width:Word;
//  Height:Word;
//  Gain:Word;
//  PixelWidth:Cardinal;
//  PixelHeight:Cardinal;
//  end;
   BCD:Cardinal;  // 32 bits non signé
begin
GetCCDInfoParams.Request:=0;
Result:=SBIGUnivDrvCommand(CC_GET_CCD_INFO,GetCCDInfoParams,GetCCDInfoResults0);
ReadoutInfo:=GetCCDInfoResults0.ReadoutInfo[1];
BCD:=ReadoutInfo.PixelHeight;
Value:=(((BCD and $f0000000) shr 28)*10e7
      + ((BCD and $0f000000) shr 24)*10e6
      + ((BCD and $00f00000) shr 20)*10e5
      + ((BCD and $000f0000) shr 16)*10e4
      + ((BCD and $0000f000) shr 12)*10e3
      + ((BCD and $00000f00) shr 8 )*10e2
      + ((BCD and $000000f0) shr 4 )*10
      +  (BCD and $0000000f))/100;
//  WHeures:=((Heures and $f0) shr 4)*10+(Heures and $0f);   Heure = Word
end;

function GetPixelTrackWidthSbig(var Value:Double):Word;
var
   GetCCDInfoParams:TGetCCDInfoParams;
//TGetCCDInfoParams = packed record
//  request:Word; // CCD_INFO_REQUEST
//  end;
   GetCCDInfoResults0:TGetCCDInfoResults0;
//TGetCCDInfoResults0 = packed record
//  FirmwareVersion:Word;
//  CameraType:Word; // CAMERA_TYPE
//  Name:array[1..64] of Char;
//  ReadoutModes:Word;
//  ReadoutInfo:array[1..20] of TReadoutInfo;
//  end;
   ReadoutInfo:TReadoutInfo;
//TReadoutInfo = packed record
//  Mode:Word;
//  Width:Word;
//  Height:Word;
//  Gain:Word;
//  PixelWidth:Cardinal;
//  PixelHeight:Cardinal;
//  end;
   BCD:Cardinal;  // 32 bits non signé
begin
GetCCDInfoParams.Request:=0;
Result:=SBIGUnivDrvCommand(CC_GET_CCD_INFO,GetCCDInfoParams,GetCCDInfoResults0);
ReadoutInfo:=GetCCDInfoResults0.ReadoutInfo[1];
BCD:=ReadoutInfo.PixelWidth;
Value:=(((BCD and $f0000000) shr 28)*10e7
      + ((BCD and $0f000000) shr 24)*10e6
      + ((BCD and $00f00000) shr 20)*10e5
      + ((BCD and $000f0000) shr 16)*10e4
      + ((BCD and $0000f000) shr 12)*10e3
      + ((BCD and $00000f00) shr 8 )*10e2
      + ((BCD and $000000f0) shr 4 )*10
      +  (BCD and $0000000f))/100;
//  WHeures:=((Heures and $f0) shr 4)*10+(Heures and $0f);   Heure = Word
end;

function GetPixelTrackHeightSbig(var Value:Double):Word;
var
   GetCCDInfoParams:TGetCCDInfoParams;
//TGetCCDInfoParams = packed record
//  request:Word; // CCD_INFO_REQUEST
//  end;
   GetCCDInfoResults0:TGetCCDInfoResults0;
//TGetCCDInfoResults0 = packed record
//  FirmwareVersion:Word;
//  CameraType:Word; // CAMERA_TYPE
//  Name:array[1..64] of Char;
//  ReadoutModes:Word;
//  ReadoutInfo:array[1..20] of TReadoutInfo;
//  end;
   ReadoutInfo:TReadoutInfo;
//TReadoutInfo = packed record
//  Mode:Word;
//  Width:Word;
//  Height:Word;
//  Gain:Word;
//  PixelWidth:Cardinal;
//  PixelHeight:Cardinal;
//  end;
   BCD:Cardinal;  // 32 bits non signé
begin
GetCCDInfoParams.Request:=1;
Result:=SBIGUnivDrvCommand(CC_GET_CCD_INFO,GetCCDInfoParams,GetCCDInfoResults0);
ReadoutInfo:=GetCCDInfoResults0.ReadoutInfo[1];
BCD:=ReadoutInfo.PixelHeight;
Value:=(((BCD and $f0000000) shr 28)*10e7
      + ((BCD and $0f000000) shr 24)*10e6
      + ((BCD and $00f00000) shr 20)*10e5
      + ((BCD and $000f0000) shr 16)*10e4
      + ((BCD and $0000f000) shr 12)*10e3
      + ((BCD and $00000f00) shr 8 )*10e2
      + ((BCD and $000000f0) shr 4 )*10
      +  (BCD and $0000000f))/100;
//  WHeures:=((Heures and $f0) shr 4)*10+(Heures and $0f);   Heure = Word
end;

function GetCameraWidthSbig(var Value:Word):Word;
var
   GetCCDInfoParams:TGetCCDInfoParams;
//TGetCCDInfoParams = packed record
//  request:Word; // CCD_INFO_REQUEST
//  end;
   GetCCDInfoResults0:TGetCCDInfoResults0;
//TGetCCDInfoResults0 = packed record
//  FirmwareVersion:Word;
//  CameraType:Word; // CAMERA_TYPE
//  Name:array[1..64] of Char;
//  ReadoutModes:Word;
//  ReadoutInfo:array[1..20] of TReadoutInfo;
//  end;
   ReadoutInfo:TReadoutInfo;
//TReadoutInfo = packed record
//  Mode:Word;
//  Width:Word;
//  Height:Word;
//  Gain:Word;
//  PixelWidth:Cardinal;
//  PixelHeight:Cardinal;
//  end;
begin
GetCCDInfoParams.Request:=0;
Result:=SBIGUnivDrvCommand(CC_GET_CCD_INFO,GetCCDInfoParams,GetCCDInfoResults0);
ReadoutInfo:=GetCCDInfoResults0.ReadoutInfo[1];
Value:=ReadoutInfo.Width;
end;

function GetCameraHeightSbig(var Value:Word):Word;
var
   GetCCDInfoParams:TGetCCDInfoParams;
//TGetCCDInfoParams = packed record
//  request:Word; // CCD_INFO_REQUEST
//  end;
   GetCCDInfoResults0:TGetCCDInfoResults0;
//TGetCCDInfoResults0 = packed record
//  FirmwareVersion:Word;
//  CameraType:Word; // CAMERA_TYPE
//  Name:array[1..64] of Char;
//  ReadoutModes:Word;
//  ReadoutInfo:array[1..20] of TReadoutInfo;
//  end;
   ReadoutInfo:TReadoutInfo;
//TReadoutInfo = packed record
//  Mode:Word;
//  Width:Word;
//  Height:Word;
//  Gain:Word;
//  PixelWidth:Cardinal;
//  PixelHeight:Cardinal;
//  end;
begin
GetCCDInfoParams.Request:=0;
Result:=SBIGUnivDrvCommand(CC_GET_CCD_INFO,GetCCDInfoParams,GetCCDInfoResults0);
ReadoutInfo:=GetCCDInfoResults0.ReadoutInfo[1];
Value:=ReadoutInfo.Height;
end;

function GetCameraTrackWidthSbig(var Value:Word):Word;
var
   GetCCDInfoParams:TGetCCDInfoParams;
//TGetCCDInfoParams = packed record
//  request:Word; // CCD_INFO_REQUEST
//  end;
   GetCCDInfoResults0:TGetCCDInfoResults0;
//TGetCCDInfoResults0 = packed record
//  FirmwareVersion:Word;
//  CameraType:Word; // CAMERA_TYPE
//  Name:array[1..64] of Char;
//  ReadoutModes:Word;
//  ReadoutInfo:array[1..20] of TReadoutInfo;
//  end;
   ReadoutInfo:TReadoutInfo;
//TReadoutInfo = packed record
//  Mode:Word;
//  Width:Word;
//  Height:Word;
//  Gain:Word;
//  PixelWidth:Cardinal;
//  PixelHeight:Cardinal;
//  end;
begin
GetCCDInfoParams.Request:=1;
Result:=SBIGUnivDrvCommand(CC_GET_CCD_INFO,GetCCDInfoParams,GetCCDInfoResults0);
ReadoutInfo:=GetCCDInfoResults0.ReadoutInfo[1];
Value:=ReadoutInfo.Width;
end;

function GetCameraTrackHeightSbig(var Value:Word):Word;
var
   GetCCDInfoParams:TGetCCDInfoParams;
//TGetCCDInfoParams = packed record
//  request:Word; // CCD_INFO_REQUEST
//  end;
   GetCCDInfoResults0:TGetCCDInfoResults0;
//TGetCCDInfoResults0 = packed record
//  FirmwareVersion:Word;
//  CameraType:Word; // CAMERA_TYPE
//  Name:array[1..64] of Char;
//  ReadoutModes:Word;
//  ReadoutInfo:array[1..20] of TReadoutInfo;
//  end;
   ReadoutInfo:TReadoutInfo;
//TReadoutInfo = packed record
//  Mode:Word;
//  Width:Word;
//  Height:Word;
//  Gain:Word;
//  PixelWidth:Cardinal;
//  PixelHeight:Cardinal;
//  end;
begin
GetCCDInfoParams.Request:=1;
Result:=SBIGUnivDrvCommand(CC_GET_CCD_INFO,GetCCDInfoParams,GetCCDInfoResults0);
ReadoutInfo:=GetCCDInfoResults0.ReadoutInfo[1];
Value:=ReadoutInfo.Height;
end;

begin
end.
