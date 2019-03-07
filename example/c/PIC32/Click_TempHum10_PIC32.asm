_systemInit:
;Click_TempHum10_PIC32.c,34 :: 		void systemInit()
ADDIU	SP, SP, -16
SW	RA, 0(SP)
;Click_TempHum10_PIC32.c,36 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
MOVZ	R27, R0, R0
ORI	R26, R0, 2
MOVZ	R25, R0, R0
JAL	_mikrobus_gpioInit+0
NOP	
;Click_TempHum10_PIC32.c,37 :: 		mikrobus_i2cInit( _MIKROBUS1, &_TEMPHUM10_I2C_CFG[0] );
LUI	R2, hi_addr(__TEMPHUM10_I2C_CFG+0)
ORI	R2, R2, lo_addr(__TEMPHUM10_I2C_CFG+0)
MOVZ	R26, R2, R0
MOVZ	R25, R0, R0
JAL	_mikrobus_i2cInit+0
NOP	
;Click_TempHum10_PIC32.c,38 :: 		mikrobus_logInit( _LOG_USBUART_A, 9600 );
ORI	R26, R0, 9600
ORI	R25, R0, 32
JAL	_mikrobus_logInit+0
NOP	
;Click_TempHum10_PIC32.c,39 :: 		mikrobus_logWrite(" --- System Init ---", _LOG_LINE);
ORI	R26, R0, 2
LUI	R25, hi_addr(?lstr1_Click_TempHum10_PIC32+0)
ORI	R25, R25, lo_addr(?lstr1_Click_TempHum10_PIC32+0)
JAL	_mikrobus_logWrite+0
NOP	
;Click_TempHum10_PIC32.c,40 :: 		Delay_100ms();
JAL	_Delay_100ms+0
NOP	
;Click_TempHum10_PIC32.c,41 :: 		}
L_end_systemInit:
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 16
JR	RA
NOP	
; end of _systemInit
_applicationInit:
;Click_TempHum10_PIC32.c,43 :: 		void applicationInit()
ADDIU	SP, SP, -16
SW	RA, 0(SP)
;Click_TempHum10_PIC32.c,45 :: 		temphum10_i2cDriverInit( (T_TEMPHUM10_P)&_MIKROBUS1_GPIO, (T_TEMPHUM10_P)&_MIKROBUS1_I2C, 0x7F );
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
ORI	R27, R0, 127
LUI	R26, hi_addr(__MIKROBUS1_I2C+0)
ORI	R26, R26, lo_addr(__MIKROBUS1_I2C+0)
LUI	R25, hi_addr(__MIKROBUS1_GPIO+0)
ORI	R25, R25, lo_addr(__MIKROBUS1_GPIO+0)
JAL	_temphum10_i2cDriverInit+0
NOP	
;Click_TempHum10_PIC32.c,46 :: 		temphum10_setDeviceMode(_TEMPHUM10_MODE_STANDBY);
ORI	R25, R0, __TEMPHUM10_MODE_STANDBY
JAL	_temphum10_setDeviceMode+0
NOP	
;Click_TempHum10_PIC32.c,47 :: 		temphum10_writeByte(_TEMPHUM10_REG_DEVICE_RESET, _TEMPHUM10_RST_NORMAL_OPERATION);
ORI	R26, R0, __TEMPHUM10_RST_NORMAL_OPERATION
ORI	R25, R0, __TEMPHUM10_REG_DEVICE_RESET
JAL	_temphum10_writeByte+0
NOP	
;Click_TempHum10_PIC32.c,48 :: 		Delay_50us();
JAL	_Delay_50us+0
NOP	
;Click_TempHum10_PIC32.c,49 :: 		temphum10_readByte(0x04);
ORI	R25, R0, 4
JAL	_temphum10_readByte+0
NOP	
;Click_TempHum10_PIC32.c,52 :: 		}
L_end_applicationInit:
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 16
JR	RA
NOP	
; end of _applicationInit
_applicationTask:
;Click_TempHum10_PIC32.c,54 :: 		void applicationTask()
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;Click_TempHum10_PIC32.c,56 :: 		temphum10_repeatMeasurement(_TEMPHUM10_AM_TIMES_AVERAGE_MODE_2 | _TEMPHUM10_AM_TEMP_AVERAGE_MODE_TIMES_16);
SW	R25, 4(SP)
SW	R26, 8(SP)
ORI	R2, R0, __TEMPHUM10_AM_TIMES_AVERAGE_MODE_2
ORI	R2, R2, __TEMPHUM10_AM_TEMP_AVERAGE_MODE_TIMES_16
ANDI	R25, R2, 255
JAL	_temphum10_repeatMeasurement+0
NOP	
;Click_TempHum10_PIC32.c,58 :: 		Temperature = temphum10_getTemperature();
JAL	_temphum10_getTemperature+0
NOP	
SW	R2, Offset(_Temperature+0)(GP)
;Click_TempHum10_PIC32.c,59 :: 		Humidity = temphum10_getHumidity();
JAL	_temphum10_getHumidity+0
NOP	
SW	R2, Offset(_Humidity+0)(GP)
;Click_TempHum10_PIC32.c,61 :: 		FloatToStr(Temperature, demoText);
LUI	R26, hi_addr(_demoText+0)
ORI	R26, R26, lo_addr(_demoText+0)
LW	R25, Offset(_Temperature+0)(GP)
JAL	_FloatToStr+0
NOP	
;Click_TempHum10_PIC32.c,62 :: 		mikrobus_logWrite(" Temperature : ", _LOG_TEXT);
ORI	R26, R0, 1
LUI	R25, hi_addr(?lstr2_Click_TempHum10_PIC32+0)
ORI	R25, R25, lo_addr(?lstr2_Click_TempHum10_PIC32+0)
JAL	_mikrobus_logWrite+0
NOP	
;Click_TempHum10_PIC32.c,63 :: 		mikrobus_logWrite(demoText, _LOG_LINE);
ORI	R26, R0, 2
LUI	R25, hi_addr(_demoText+0)
ORI	R25, R25, lo_addr(_demoText+0)
JAL	_mikrobus_logWrite+0
NOP	
;Click_TempHum10_PIC32.c,65 :: 		FloatToStr(Humidity, demoText);
LUI	R26, hi_addr(_demoText+0)
ORI	R26, R26, lo_addr(_demoText+0)
LW	R25, Offset(_Humidity+0)(GP)
JAL	_FloatToStr+0
NOP	
;Click_TempHum10_PIC32.c,66 :: 		mikrobus_logWrite(" Humidity : ", _LOG_TEXT);
ORI	R26, R0, 1
LUI	R25, hi_addr(?lstr3_Click_TempHum10_PIC32+0)
ORI	R25, R25, lo_addr(?lstr3_Click_TempHum10_PIC32+0)
JAL	_mikrobus_logWrite+0
NOP	
;Click_TempHum10_PIC32.c,67 :: 		mikrobus_logWrite(demoText, _LOG_LINE);
ORI	R26, R0, 2
LUI	R25, hi_addr(_demoText+0)
ORI	R25, R25, lo_addr(_demoText+0)
JAL	_mikrobus_logWrite+0
NOP	
;Click_TempHum10_PIC32.c,69 :: 		mikrobus_logWrite("---------------------", _LOG_LINE);
ORI	R26, R0, 2
LUI	R25, hi_addr(?lstr4_Click_TempHum10_PIC32+0)
ORI	R25, R25, lo_addr(?lstr4_Click_TempHum10_PIC32+0)
JAL	_mikrobus_logWrite+0
NOP	
;Click_TempHum10_PIC32.c,71 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_TempHum10_PIC32.c,72 :: 		}
L_end_applicationTask:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _applicationTask
_main:
;Click_TempHum10_PIC32.c,74 :: 		void main()
;Click_TempHum10_PIC32.c,76 :: 		systemInit();
JAL	_systemInit+0
NOP	
;Click_TempHum10_PIC32.c,77 :: 		applicationInit();
JAL	_applicationInit+0
NOP	
;Click_TempHum10_PIC32.c,79 :: 		while (1)
L_main0:
;Click_TempHum10_PIC32.c,81 :: 		applicationTask();
JAL	_applicationTask+0
NOP	
;Click_TempHum10_PIC32.c,82 :: 		}
J	L_main0
NOP	
;Click_TempHum10_PIC32.c,83 :: 		}
L_end_main:
L__main_end_loop:
J	L__main_end_loop
NOP	
; end of _main
