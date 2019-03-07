_systemInit:
;Click_TempHum10_STM.c,34 :: 		void systemInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Click_TempHum10_STM.c,36 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
MOVS	R2, #0
MOVS	R1, #2
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_TempHum10_STM.c,37 :: 		mikrobus_i2cInit( _MIKROBUS1, &_TEMPHUM10_I2C_CFG[0] );
MOVW	R0, #lo_addr(__TEMPHUM10_I2C_CFG+0)
MOVT	R0, #hi_addr(__TEMPHUM10_I2C_CFG+0)
MOV	R1, R0
MOVS	R0, #0
BL	_mikrobus_i2cInit+0
;Click_TempHum10_STM.c,38 :: 		mikrobus_logInit( _LOG_USBUART_A, 9600 );
MOVW	R1, #9600
MOVS	R0, #32
BL	_mikrobus_logInit+0
;Click_TempHum10_STM.c,39 :: 		mikrobus_logWrite(" --- System Init ---", _LOG_LINE);
MOVW	R0, #lo_addr(?lstr1_Click_TempHum10_STM+0)
MOVT	R0, #hi_addr(?lstr1_Click_TempHum10_STM+0)
MOVS	R1, #2
BL	_mikrobus_logWrite+0
;Click_TempHum10_STM.c,40 :: 		Delay_100ms();
BL	_Delay_100ms+0
;Click_TempHum10_STM.c,41 :: 		}
L_end_systemInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _systemInit
_applicationInit:
;Click_TempHum10_STM.c,43 :: 		void applicationInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Click_TempHum10_STM.c,45 :: 		temphum10_i2cDriverInit( (T_TEMPHUM10_P)&_MIKROBUS1_GPIO, (T_TEMPHUM10_P)&_MIKROBUS1_I2C, 0x7F );
MOVS	R2, #127
MOVW	R1, #lo_addr(__MIKROBUS1_I2C+0)
MOVT	R1, #hi_addr(__MIKROBUS1_I2C+0)
MOVW	R0, #lo_addr(__MIKROBUS1_GPIO+0)
MOVT	R0, #hi_addr(__MIKROBUS1_GPIO+0)
BL	_temphum10_i2cDriverInit+0
;Click_TempHum10_STM.c,46 :: 		temphum10_setDeviceMode(_TEMPHUM10_MODE_STANDBY);
MOVS	R0, __TEMPHUM10_MODE_STANDBY
BL	_temphum10_setDeviceMode+0
;Click_TempHum10_STM.c,47 :: 		Delay_ms( 1000 );
MOVW	R7, #24915
MOVT	R7, #81
NOP
NOP
L_applicationInit0:
SUBS	R7, R7, #1
BNE	L_applicationInit0
NOP
NOP
NOP
NOP
;Click_TempHum10_STM.c,48 :: 		temphum10_writeByte(_TEMPHUM10_REG_DEVICE_RESET, _TEMPHUM10_RST_NORMAL_OPERATION);
MOVS	R1, __TEMPHUM10_RST_NORMAL_OPERATION
MOVS	R0, __TEMPHUM10_REG_DEVICE_RESET
BL	_temphum10_writeByte+0
;Click_TempHum10_STM.c,50 :: 		}
L_end_applicationInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _applicationInit
_applicationTask:
;Click_TempHum10_STM.c,52 :: 		void applicationTask()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Click_TempHum10_STM.c,54 :: 		temphum10_repeatMeasurement(_TEMPHUM10_AM_TIMES_AVERAGE_MODE_2 | _TEMPHUM10_AM_TEMP_AVERAGE_MODE_TIMES_16);
MOVS	R0, __TEMPHUM10_AM_TIMES_AVERAGE_MODE_2
ORR	R0, R0, __TEMPHUM10_AM_TEMP_AVERAGE_MODE_TIMES_16
BL	_temphum10_repeatMeasurement+0
;Click_TempHum10_STM.c,56 :: 		Temperature = temphum10_getTemperature();
BL	_temphum10_getTemperature+0
MOVW	R0, #lo_addr(_Temperature+0)
MOVT	R0, #hi_addr(_Temperature+0)
VSTR	#1, S0, [R0, #0]
;Click_TempHum10_STM.c,57 :: 		Humidity = temphum10_getHumidity();
BL	_temphum10_getHumidity+0
MOVW	R0, #lo_addr(_Humidity+0)
MOVT	R0, #hi_addr(_Humidity+0)
VSTR	#1, S0, [R0, #0]
;Click_TempHum10_STM.c,59 :: 		FloatToStr(Temperature, demoText);
MOVW	R0, #lo_addr(_Temperature+0)
MOVT	R0, #hi_addr(_Temperature+0)
VLDR	#1, S0, [R0, #0]
MOVW	R0, #lo_addr(_demoText+0)
MOVT	R0, #hi_addr(_demoText+0)
BL	_FloatToStr+0
;Click_TempHum10_STM.c,60 :: 		mikrobus_logWrite(" Temperature : ", _LOG_TEXT);
MOVW	R0, #lo_addr(?lstr2_Click_TempHum10_STM+0)
MOVT	R0, #hi_addr(?lstr2_Click_TempHum10_STM+0)
MOVS	R1, #1
BL	_mikrobus_logWrite+0
;Click_TempHum10_STM.c,61 :: 		mikrobus_logWrite(demoText, _LOG_LINE);
MOVS	R1, #2
MOVW	R0, #lo_addr(_demoText+0)
MOVT	R0, #hi_addr(_demoText+0)
BL	_mikrobus_logWrite+0
;Click_TempHum10_STM.c,63 :: 		FloatToStr(Humidity, demoText);
MOVW	R0, #lo_addr(_Humidity+0)
MOVT	R0, #hi_addr(_Humidity+0)
VLDR	#1, S0, [R0, #0]
MOVW	R0, #lo_addr(_demoText+0)
MOVT	R0, #hi_addr(_demoText+0)
BL	_FloatToStr+0
;Click_TempHum10_STM.c,64 :: 		mikrobus_logWrite(" Humidity : ", _LOG_TEXT);
MOVW	R0, #lo_addr(?lstr3_Click_TempHum10_STM+0)
MOVT	R0, #hi_addr(?lstr3_Click_TempHum10_STM+0)
MOVS	R1, #1
BL	_mikrobus_logWrite+0
;Click_TempHum10_STM.c,65 :: 		mikrobus_logWrite(demoText, _LOG_LINE);
MOVS	R1, #2
MOVW	R0, #lo_addr(_demoText+0)
MOVT	R0, #hi_addr(_demoText+0)
BL	_mikrobus_logWrite+0
;Click_TempHum10_STM.c,67 :: 		mikrobus_logWrite("---------------------", _LOG_LINE);
MOVW	R0, #lo_addr(?lstr4_Click_TempHum10_STM+0)
MOVT	R0, #hi_addr(?lstr4_Click_TempHum10_STM+0)
MOVS	R1, #2
BL	_mikrobus_logWrite+0
;Click_TempHum10_STM.c,69 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_TempHum10_STM.c,70 :: 		}
L_end_applicationTask:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _applicationTask
_main:
;Click_TempHum10_STM.c,72 :: 		void main()
;Click_TempHum10_STM.c,74 :: 		systemInit();
BL	_systemInit+0
;Click_TempHum10_STM.c,75 :: 		applicationInit();
BL	_applicationInit+0
;Click_TempHum10_STM.c,77 :: 		while (1)
L_main2:
;Click_TempHum10_STM.c,79 :: 		applicationTask();
BL	_applicationTask+0
;Click_TempHum10_STM.c,80 :: 		}
IT	AL
BAL	L_main2
;Click_TempHum10_STM.c,81 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
