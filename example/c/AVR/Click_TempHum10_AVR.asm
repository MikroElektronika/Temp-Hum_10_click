
_systemInit:

;Click_TempHum10_AVR.c,35 :: 		void systemInit()
;Click_TempHum10_AVR.c,37 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 2
	MOV        R3, R27
	CLR        R2
	CALL       _mikrobus_gpioInit+0
;Click_TempHum10_AVR.c,38 :: 		mikrobus_i2cInit( _MIKROBUS1, &_TEMPHUM10_I2C_CFG[0] );
	LDI        R16, #lo_addr(__TEMPHUM10_I2C_CFG+0)
	LDI        R17, hi_addr(__TEMPHUM10_I2C_CFG+0)
	MOV        R3, R16
	MOV        R4, R17
	CLR        R2
	CALL       _mikrobus_i2cInit+0
;Click_TempHum10_AVR.c,39 :: 		mikrobus_logInit( _LOG_USBUART, 9600 );
	LDI        R27, 128
	MOV        R3, R27
	LDI        R27, 37
	MOV        R4, R27
	LDI        R27, 0
	MOV        R5, R27
	MOV        R6, R27
	LDI        R27, 16
	MOV        R2, R27
	CALL       _mikrobus_logInit+0
;Click_TempHum10_AVR.c,40 :: 		mikrobus_logWrite(" --- System Init ---", _LOG_LINE);
	LDI        R27, 2
	MOV        R4, R27
	LDI        R27, #lo_addr(?lstr1_Click_TempHum10_AVR+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr1_Click_TempHum10_AVR+0)
	MOV        R3, R27
	CALL       _mikrobus_logWrite+0
;Click_TempHum10_AVR.c,41 :: 		Delay_100ms();
	CALL       _Delay_100ms+0
;Click_TempHum10_AVR.c,42 :: 		}
L_end_systemInit:
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _systemInit

_applicationInit:

;Click_TempHum10_AVR.c,44 :: 		void applicationInit()
;Click_TempHum10_AVR.c,46 :: 		temphum10_i2cDriverInit( (T_TEMPHUM10_P)&_MIKROBUS1_GPIO, (T_TEMPHUM10_P)&_MIKROBUS1_I2C, 0x7F );
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	LDI        R27, 127
	MOV        R6, R27
	LDI        R27, #lo_addr(__MIKROBUS1_I2C+0)
	MOV        R4, R27
	LDI        R27, hi_addr(__MIKROBUS1_I2C+0)
	MOV        R5, R27
	LDI        R27, #lo_addr(__MIKROBUS1_GPIO+0)
	MOV        R2, R27
	LDI        R27, hi_addr(__MIKROBUS1_GPIO+0)
	MOV        R3, R27
	CALL       _temphum10_i2cDriverInit+0
;Click_TempHum10_AVR.c,47 :: 		temphum10_setDeviceMode(_TEMPHUM10_MODE_STANDBY);
	LDI        R27, __TEMPHUM10_MODE_STANDBY
	MOV        R2, R27
	CALL       _temphum10_setDeviceMode+0
;Click_TempHum10_AVR.c,48 :: 		Delay_ms( 1000 );
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_applicationInit0:
	DEC        R16
	BRNE       L_applicationInit0
	DEC        R17
	BRNE       L_applicationInit0
	DEC        R18
	BRNE       L_applicationInit0
;Click_TempHum10_AVR.c,50 :: 		temphum10_writeByte(_TEMPHUM10_REG_DEVICE_RESET, _TEMPHUM10_RST_NORMAL_OPERATION);
	LDI        R27, __TEMPHUM10_RST_NORMAL_OPERATION
	MOV        R3, R27
	LDI        R27, __TEMPHUM10_REG_DEVICE_RESET
	MOV        R2, R27
	CALL       _temphum10_writeByte+0
;Click_TempHum10_AVR.c,51 :: 		}
L_end_applicationInit:
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _applicationInit

_applicationTask:

;Click_TempHum10_AVR.c,53 :: 		void applicationTask()
;Click_TempHum10_AVR.c,55 :: 		temphum10_repeatMeasurement(_TEMPHUM10_AM_TIMES_AVERAGE_MODE_8);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, __TEMPHUM10_AM_TIMES_AVERAGE_MODE_8
	MOV        R2, R27
	CALL       _temphum10_repeatMeasurement+0
;Click_TempHum10_AVR.c,57 :: 		Temperature = temphum10_getTemperature(1);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _temphum10_getTemperature+0
	STS        _Temperature+0, R16
	STS        _Temperature+1, R17
	STS        _Temperature+2, R18
	STS        _Temperature+3, R19
;Click_TempHum10_AVR.c,58 :: 		Humidity = temphum10_getHumidity();
	CALL       _temphum10_getHumidity+0
	STS        _Humidity+0, R16
	STS        _Humidity+1, R17
	STS        _Humidity+2, R18
	STS        _Humidity+3, R19
;Click_TempHum10_AVR.c,60 :: 		FloatToStr(Temperature, demoText);
	LDI        R27, #lo_addr(_demoText+0)
	MOV        R6, R27
	LDI        R27, hi_addr(_demoText+0)
	MOV        R7, R27
	LDS        R2, _Temperature+0
	LDS        R3, _Temperature+1
	LDS        R4, _Temperature+2
	LDS        R5, _Temperature+3
	CALL       _FloatToStr+0
;Click_TempHum10_AVR.c,61 :: 		mikrobus_logWrite(" Temperature : ", _LOG_TEXT);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, #lo_addr(?lstr2_Click_TempHum10_AVR+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr2_Click_TempHum10_AVR+0)
	MOV        R3, R27
	CALL       _mikrobus_logWrite+0
;Click_TempHum10_AVR.c,62 :: 		mikrobus_logWrite(demoText, _LOG_LINE);
	LDI        R27, 2
	MOV        R4, R27
	LDI        R27, #lo_addr(_demoText+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_demoText+0)
	MOV        R3, R27
	CALL       _mikrobus_logWrite+0
;Click_TempHum10_AVR.c,64 :: 		FloatToStr(Humidity, demoText);
	LDI        R27, #lo_addr(_demoText+0)
	MOV        R6, R27
	LDI        R27, hi_addr(_demoText+0)
	MOV        R7, R27
	LDS        R2, _Humidity+0
	LDS        R3, _Humidity+1
	LDS        R4, _Humidity+2
	LDS        R5, _Humidity+3
	CALL       _FloatToStr+0
;Click_TempHum10_AVR.c,65 :: 		mikrobus_logWrite(" Humidity : ", _LOG_TEXT);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, #lo_addr(?lstr3_Click_TempHum10_AVR+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr3_Click_TempHum10_AVR+0)
	MOV        R3, R27
	CALL       _mikrobus_logWrite+0
;Click_TempHum10_AVR.c,66 :: 		mikrobus_logWrite(demoText, _LOG_LINE);
	LDI        R27, 2
	MOV        R4, R27
	LDI        R27, #lo_addr(_demoText+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_demoText+0)
	MOV        R3, R27
	CALL       _mikrobus_logWrite+0
;Click_TempHum10_AVR.c,68 :: 		mikrobus_logWrite("---------------------", _LOG_LINE);
	LDI        R27, 2
	MOV        R4, R27
	LDI        R27, #lo_addr(?lstr4_Click_TempHum10_AVR+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr4_Click_TempHum10_AVR+0)
	MOV        R3, R27
	CALL       _mikrobus_logWrite+0
;Click_TempHum10_AVR.c,70 :: 		Delay_1sec();
	CALL       _Delay_1sec+0
;Click_TempHum10_AVR.c,71 :: 		}
L_end_applicationTask:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _applicationTask

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;Click_TempHum10_AVR.c,73 :: 		void main()
;Click_TempHum10_AVR.c,75 :: 		systemInit();
	CALL       _systemInit+0
;Click_TempHum10_AVR.c,76 :: 		applicationInit();
	CALL       _applicationInit+0
;Click_TempHum10_AVR.c,78 :: 		while (1)
L_main2:
;Click_TempHum10_AVR.c,80 :: 		applicationTask();
	CALL       _applicationTask+0
;Click_TempHum10_AVR.c,81 :: 		}
	JMP        L_main2
;Click_TempHum10_AVR.c,82 :: 		}
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
