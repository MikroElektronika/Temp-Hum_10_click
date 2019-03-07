_systemInit:
;Click_TempHum10_FT90x.c,35 :: 		void systemInit()
;Click_TempHum10_FT90x.c,37 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
LDK.L	R2, #0
LDK.L	R1, #2
LDK.L	R0, #0
CALL	_mikrobus_gpioInit+0
;Click_TempHum10_FT90x.c,38 :: 		mikrobus_i2cInit( _MIKROBUS1, &_TEMPHUM10_I2C_CFG[0] );
LDK.L	R1, #__TEMPHUM10_I2C_CFG+0
LDK.L	R0, #0
CALL	_mikrobus_i2cInit+0
;Click_TempHum10_FT90x.c,39 :: 		mikrobus_logInit( _LOG_USBUART, 9600 );
LDK.L	R1, #9600
LDK.L	R0, #16
CALL	_mikrobus_logInit+0
;Click_TempHum10_FT90x.c,40 :: 		mikrobus_logWrite(" --- System Init ---", _LOG_LINE);
LDK.L	R0, #?lstr1_Click_TempHum10_FT90x+0
LDK.L	R1, #2
CALL	_mikrobus_logWrite+0
;Click_TempHum10_FT90x.c,41 :: 		Delay_100ms();
CALL	_Delay_100ms+0
;Click_TempHum10_FT90x.c,42 :: 		}
L_end_systemInit:
RETURN	
; end of _systemInit
_applicationInit:
;Click_TempHum10_FT90x.c,44 :: 		void applicationInit()
;Click_TempHum10_FT90x.c,46 :: 		temphum10_i2cDriverInit( (T_TEMPHUM10_P)&_MIKROBUS1_GPIO, (T_TEMPHUM10_P)&_MIKROBUS1_I2C, 0x7F );
LDK.L	R2, #127
LDK.L	R1, #__MIKROBUS1_I2C+0
LDK.L	R0, #__MIKROBUS1_GPIO+0
CALL	_temphum10_i2cDriverInit+0
;Click_TempHum10_FT90x.c,47 :: 		temphum10_setDeviceMode(_TEMPHUM10_MODE_STANDBY);
LDK.L	R0, __TEMPHUM10_MODE_STANDBY
CALL	_temphum10_setDeviceMode+0
;Click_TempHum10_FT90x.c,48 :: 		Delay_ms( 1000 );
LPM.L	R28, #33333331
NOP	
L_applicationInit0:
SUB.L	R28, R28, #1
CMP.L	R28, #0
JMPC	R30, Z, #0, L_applicationInit0
JMP	$+8
	#33333331
NOP	
NOP	
;Click_TempHum10_FT90x.c,50 :: 		temphum10_writeByte(_TEMPHUM10_REG_DEVICE_RESET, _TEMPHUM10_RST_NORMAL_OPERATION);
LDK.L	R1, __TEMPHUM10_RST_NORMAL_OPERATION
LDK.L	R0, __TEMPHUM10_REG_DEVICE_RESET
CALL	_temphum10_writeByte+0
;Click_TempHum10_FT90x.c,51 :: 		}
L_end_applicationInit:
RETURN	
; end of _applicationInit
_applicationTask:
;Click_TempHum10_FT90x.c,53 :: 		void applicationTask()
;Click_TempHum10_FT90x.c,55 :: 		temphum10_repeatMeasurement(_TEMPHUM10_AM_NO_AVERAGING_PROCESS);
LDK.L	R0, __TEMPHUM10_AM_NO_AVERAGING_PROCESS
CALL	_temphum10_repeatMeasurement+0
;Click_TempHum10_FT90x.c,57 :: 		Temperature = temphum10_getTemperature(1);
LDK.L	R0, #1
CALL	_temphum10_getTemperature+0
STA.L	_Temperature+0, R0
;Click_TempHum10_FT90x.c,58 :: 		Humidity = temphum10_getHumidity();
CALL	_temphum10_getHumidity+0
STA.L	_Humidity+0, R0
;Click_TempHum10_FT90x.c,60 :: 		FloatToStr(Temperature, demoText);
LDA.L	R0, _Temperature+0
LDK.L	R1, #_demoText+0
CALL	_FloatToStr+0
;Click_TempHum10_FT90x.c,61 :: 		mikrobus_logWrite(" Temperature : ", _LOG_TEXT);
LDK.L	R0, #?lstr2_Click_TempHum10_FT90x+0
LDK.L	R1, #1
CALL	_mikrobus_logWrite+0
;Click_TempHum10_FT90x.c,62 :: 		mikrobus_logWrite(demoText, _LOG_LINE);
LDK.L	R1, #2
LDK.L	R0, #_demoText+0
CALL	_mikrobus_logWrite+0
;Click_TempHum10_FT90x.c,64 :: 		FloatToStr(Humidity, demoText);
LDA.L	R0, _Humidity+0
LDK.L	R1, #_demoText+0
CALL	_FloatToStr+0
;Click_TempHum10_FT90x.c,65 :: 		mikrobus_logWrite(" Humidity : ", _LOG_TEXT);
LDK.L	R0, #?lstr3_Click_TempHum10_FT90x+0
LDK.L	R1, #1
CALL	_mikrobus_logWrite+0
;Click_TempHum10_FT90x.c,66 :: 		mikrobus_logWrite(demoText, _LOG_LINE);
LDK.L	R1, #2
LDK.L	R0, #_demoText+0
CALL	_mikrobus_logWrite+0
;Click_TempHum10_FT90x.c,68 :: 		mikrobus_logWrite("---------------------", _LOG_LINE);
LDK.L	R0, #?lstr4_Click_TempHum10_FT90x+0
LDK.L	R1, #2
CALL	_mikrobus_logWrite+0
;Click_TempHum10_FT90x.c,70 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_TempHum10_FT90x.c,71 :: 		}
L_end_applicationTask:
RETURN	
; end of _applicationTask
_main:
;Click_TempHum10_FT90x.c,73 :: 		void main()
LDK.L	SP, #43605
;Click_TempHum10_FT90x.c,75 :: 		systemInit();
CALL	_systemInit+0
;Click_TempHum10_FT90x.c,76 :: 		applicationInit();
CALL	_applicationInit+0
;Click_TempHum10_FT90x.c,78 :: 		while (1)
L_main2:
;Click_TempHum10_FT90x.c,80 :: 		applicationTask();
CALL	_applicationTask+0
;Click_TempHum10_FT90x.c,81 :: 		}
JMP	L_main2
;Click_TempHum10_FT90x.c,82 :: 		}
L_end_main:
L__main_end_loop:
JMP	L__main_end_loop
; end of _main
