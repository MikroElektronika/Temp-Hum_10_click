
_systemInit:

;Click_TempHum10_DSPIC.c,34 :: 		void systemInit()
;Click_TempHum10_DSPIC.c,36 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CLR	W12
	MOV.B	#2, W11
	CLR	W10
	CALL	_mikrobus_gpioInit
;Click_TempHum10_DSPIC.c,37 :: 		mikrobus_i2cInit( _MIKROBUS1, &_TEMPHUM10_I2C_CFG[0] );
	MOV	#lo_addr(__TEMPHUM10_I2C_CFG), W0
	MOV	W0, W11
	CLR	W10
	CALL	_mikrobus_i2cInit
;Click_TempHum10_DSPIC.c,38 :: 		mikrobus_logInit( _LOG_USBUART_A, 9600 );
	MOV	#9600, W11
	MOV	#0, W12
	MOV.B	#32, W10
	CALL	_mikrobus_logInit
;Click_TempHum10_DSPIC.c,39 :: 		mikrobus_logWrite(" --- System Init ---", _LOG_LINE);
	MOV.B	#2, W11
	MOV	#lo_addr(?lstr1_Click_TempHum10_DSPIC), W10
	CALL	_mikrobus_logWrite
;Click_TempHum10_DSPIC.c,40 :: 		Delay_100ms();
	CALL	_Delay_100ms
;Click_TempHum10_DSPIC.c,41 :: 		}
L_end_systemInit:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _systemInit

_applicationInit:

;Click_TempHum10_DSPIC.c,43 :: 		void applicationInit()
;Click_TempHum10_DSPIC.c,45 :: 		temphum10_i2cDriverInit( (T_TEMPHUM10_P)&_MIKROBUS1_GPIO, (T_TEMPHUM10_P)&_MIKROBUS1_I2C, 0x7F );
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV.B	#127, W12
	MOV	#lo_addr(__MIKROBUS1_I2C), W11
	MOV	#lo_addr(__MIKROBUS1_GPIO), W10
	CALL	_temphum10_i2cDriverInit
;Click_TempHum10_DSPIC.c,46 :: 		temphum10_setDeviceMode(_TEMPHUM10_MODE_STANDBY);
	MOV.B	#__TEMPHUM10_MODE_STANDBY, W10
	CALL	_temphum10_setDeviceMode
;Click_TempHum10_DSPIC.c,47 :: 		Delay_ms( 1000 );
	MOV	#21, W8
	MOV	#22619, W7
L_applicationInit0:
	DEC	W7
	BRA NZ	L_applicationInit0
	DEC	W8
	BRA NZ	L_applicationInit0
;Click_TempHum10_DSPIC.c,49 :: 		temphum10_writeByte(_TEMPHUM10_REG_DEVICE_RESET, _TEMPHUM10_RST_NORMAL_OPERATION);
	MOV.B	#__TEMPHUM10_RST_NORMAL_OPERATION, W11
	MOV.B	#__TEMPHUM10_REG_DEVICE_RESET, W10
	CALL	_temphum10_writeByte
;Click_TempHum10_DSPIC.c,50 :: 		}
L_end_applicationInit:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _applicationInit

_applicationTask:

;Click_TempHum10_DSPIC.c,52 :: 		void applicationTask()
;Click_TempHum10_DSPIC.c,54 :: 		temphum10_repeatMeasurement(_TEMPHUM10_AM_NO_AVERAGING_PROCESS);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV.B	#__TEMPHUM10_AM_NO_AVERAGING_PROCESS, W10
	CALL	_temphum10_repeatMeasurement
;Click_TempHum10_DSPIC.c,56 :: 		Temperature = temphum10_getTemperature(1);
	MOV.B	#1, W10
	CALL	_temphum10_getTemperature
	MOV	W0, _Temperature
	MOV	W1, _Temperature+2
;Click_TempHum10_DSPIC.c,57 :: 		Humidity = temphum10_getHumidity();
	CALL	_temphum10_getHumidity
	MOV	W0, _Humidity
	MOV	W1, _Humidity+2
;Click_TempHum10_DSPIC.c,59 :: 		FloatToStr(Temperature, demoText);
	MOV	#lo_addr(_demoText), W12
	MOV	_Temperature, W10
	MOV	_Temperature+2, W11
	CALL	_FloatToStr
;Click_TempHum10_DSPIC.c,60 :: 		mikrobus_logWrite(" Temperature : ", _LOG_TEXT);
	MOV.B	#1, W11
	MOV	#lo_addr(?lstr2_Click_TempHum10_DSPIC), W10
	CALL	_mikrobus_logWrite
;Click_TempHum10_DSPIC.c,61 :: 		mikrobus_logWrite(demoText, _LOG_LINE);
	MOV.B	#2, W11
	MOV	#lo_addr(_demoText), W10
	CALL	_mikrobus_logWrite
;Click_TempHum10_DSPIC.c,63 :: 		FloatToStr(Humidity, demoText);
	MOV	#lo_addr(_demoText), W12
	MOV	_Humidity, W10
	MOV	_Humidity+2, W11
	CALL	_FloatToStr
;Click_TempHum10_DSPIC.c,64 :: 		mikrobus_logWrite(" Humidity : ", _LOG_TEXT);
	MOV.B	#1, W11
	MOV	#lo_addr(?lstr3_Click_TempHum10_DSPIC), W10
	CALL	_mikrobus_logWrite
;Click_TempHum10_DSPIC.c,65 :: 		mikrobus_logWrite(demoText, _LOG_LINE);
	MOV.B	#2, W11
	MOV	#lo_addr(_demoText), W10
	CALL	_mikrobus_logWrite
;Click_TempHum10_DSPIC.c,67 :: 		mikrobus_logWrite("---------------------", _LOG_LINE);
	MOV.B	#2, W11
	MOV	#lo_addr(?lstr4_Click_TempHum10_DSPIC), W10
	CALL	_mikrobus_logWrite
;Click_TempHum10_DSPIC.c,69 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_TempHum10_DSPIC.c,70 :: 		}
L_end_applicationTask:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _applicationTask

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;Click_TempHum10_DSPIC.c,72 :: 		void main()
;Click_TempHum10_DSPIC.c,74 :: 		systemInit();
	CALL	_systemInit
;Click_TempHum10_DSPIC.c,75 :: 		applicationInit();
	CALL	_applicationInit
;Click_TempHum10_DSPIC.c,77 :: 		while (1)
L_main2:
;Click_TempHum10_DSPIC.c,79 :: 		applicationTask();
	CALL	_applicationTask
;Click_TempHum10_DSPIC.c,80 :: 		}
	GOTO	L_main2
;Click_TempHum10_DSPIC.c,81 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
