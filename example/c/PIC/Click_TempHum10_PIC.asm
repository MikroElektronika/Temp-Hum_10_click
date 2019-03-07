
_systemInit:

;Click_TempHum10_PIC.c,34 :: 		void systemInit()
;Click_TempHum10_PIC.c,36 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
	CLRF        FARG_mikrobus_gpioInit_bus+0 
	MOVLW       2
	MOVWF       FARG_mikrobus_gpioInit_pin+0 
	CLRF        FARG_mikrobus_gpioInit_direction+0 
	CALL        _mikrobus_gpioInit+0, 0
;Click_TempHum10_PIC.c,37 :: 		mikrobus_i2cInit( _MIKROBUS1, &_TEMPHUM10_I2C_CFG[0] );
	CLRF        FARG_mikrobus_i2cInit_bus+0 
	MOVLW       __TEMPHUM10_I2C_CFG+0
	MOVWF       FARG_mikrobus_i2cInit_cfg+0 
	MOVLW       hi_addr(__TEMPHUM10_I2C_CFG+0)
	MOVWF       FARG_mikrobus_i2cInit_cfg+1 
	MOVLW       higher_addr(__TEMPHUM10_I2C_CFG+0)
	MOVWF       FARG_mikrobus_i2cInit_cfg+2 
	CALL        _mikrobus_i2cInit+0, 0
;Click_TempHum10_PIC.c,38 :: 		mikrobus_logInit( _LOG_USBUART, 9600 );
	MOVLW       16
	MOVWF       FARG_mikrobus_logInit_port+0 
	MOVLW       128
	MOVWF       FARG_mikrobus_logInit_baud+0 
	MOVLW       37
	MOVWF       FARG_mikrobus_logInit_baud+1 
	MOVLW       0
	MOVWF       FARG_mikrobus_logInit_baud+2 
	MOVWF       FARG_mikrobus_logInit_baud+3 
	CALL        _mikrobus_logInit+0, 0
;Click_TempHum10_PIC.c,39 :: 		mikrobus_logWrite(" --- System Init ---", _LOG_LINE);
	MOVLW       ?lstr1_Click_TempHum10_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr1_Click_TempHum10_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_TempHum10_PIC.c,40 :: 		Delay_100ms();
	CALL        _Delay_100ms+0, 0
;Click_TempHum10_PIC.c,41 :: 		}
L_end_systemInit:
	RETURN      0
; end of _systemInit

_applicationInit:

;Click_TempHum10_PIC.c,43 :: 		void applicationInit()
;Click_TempHum10_PIC.c,45 :: 		temphum10_i2cDriverInit( (T_TEMPHUM10_P)&_MIKROBUS1_GPIO, (T_TEMPHUM10_P)&_MIKROBUS1_I2C, 0x7F );
	MOVLW       __MIKROBUS1_GPIO+0
	MOVWF       FARG_temphum10_i2cDriverInit_gpioObj+0 
	MOVLW       hi_addr(__MIKROBUS1_GPIO+0)
	MOVWF       FARG_temphum10_i2cDriverInit_gpioObj+1 
	MOVLW       higher_addr(__MIKROBUS1_GPIO+0)
	MOVWF       FARG_temphum10_i2cDriverInit_gpioObj+2 
	MOVLW       __MIKROBUS1_I2C+0
	MOVWF       FARG_temphum10_i2cDriverInit_i2cObj+0 
	MOVLW       hi_addr(__MIKROBUS1_I2C+0)
	MOVWF       FARG_temphum10_i2cDriverInit_i2cObj+1 
	MOVLW       higher_addr(__MIKROBUS1_I2C+0)
	MOVWF       FARG_temphum10_i2cDriverInit_i2cObj+2 
	MOVLW       127
	MOVWF       FARG_temphum10_i2cDriverInit_slave+0 
	CALL        _temphum10_i2cDriverInit+0, 0
;Click_TempHum10_PIC.c,46 :: 		temphum10_setDeviceMode(_TEMPHUM10_MODE_STANDBY);
	MOVLW       __TEMPHUM10_MODE_STANDBY
	MOVWF       FARG_temphum10_setDeviceMode_mode+0 
	CALL        _temphum10_setDeviceMode+0, 0
;Click_TempHum10_PIC.c,47 :: 		Delay_ms( 1000 );
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_applicationInit0:
	DECFSZ      R13, 1, 1
	BRA         L_applicationInit0
	DECFSZ      R12, 1, 1
	BRA         L_applicationInit0
	DECFSZ      R11, 1, 1
	BRA         L_applicationInit0
	NOP
;Click_TempHum10_PIC.c,48 :: 		temphum10_writeByte(_TEMPHUM10_REG_DEVICE_RESET, _TEMPHUM10_RST_NORMAL_OPERATION);
	MOVLW       __TEMPHUM10_REG_DEVICE_RESET
	MOVWF       FARG_temphum10_writeByte_reg+0 
	MOVLW       __TEMPHUM10_RST_NORMAL_OPERATION
	MOVWF       FARG_temphum10_writeByte__data+0 
	CALL        _temphum10_writeByte+0, 0
;Click_TempHum10_PIC.c,49 :: 		}
L_end_applicationInit:
	RETURN      0
; end of _applicationInit

_applicationTask:

;Click_TempHum10_PIC.c,51 :: 		void applicationTask()
;Click_TempHum10_PIC.c,53 :: 		temphum10_repeatMeasurement(_TEMPHUM10_AM_TIMES_AVERAGE_MODE_2 | _TEMPHUM10_AM_TEMP_AVERAGE_MODE_TIMES_16);
	MOVLW       __TEMPHUM10_AM_TIMES_AVERAGE_MODE_2
	MOVWF       R0 
	MOVLW       __TEMPHUM10_AM_TEMP_AVERAGE_MODE_TIMES_16
	IORWF       R0, 0 
	MOVWF       FARG_temphum10_repeatMeasurement_average+0 
	CALL        _temphum10_repeatMeasurement+0, 0
;Click_TempHum10_PIC.c,55 :: 		Temperature = temphum10_getTemperature();
	CALL        _temphum10_getTemperature+0, 0
	MOVF        R0, 0 
	MOVWF       _Temperature+0 
	MOVF        R1, 0 
	MOVWF       _Temperature+1 
	MOVF        R2, 0 
	MOVWF       _Temperature+2 
	MOVF        R3, 0 
	MOVWF       _Temperature+3 
;Click_TempHum10_PIC.c,56 :: 		Humidity = temphum10_getHumidity();
	CALL        _temphum10_getHumidity+0, 0
	MOVF        R0, 0 
	MOVWF       _Humidity+0 
	MOVF        R1, 0 
	MOVWF       _Humidity+1 
	MOVF        R2, 0 
	MOVWF       _Humidity+2 
	MOVF        R3, 0 
	MOVWF       _Humidity+3 
;Click_TempHum10_PIC.c,58 :: 		FloatToStr(Temperature, demoText);
	MOVF        _Temperature+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _Temperature+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _Temperature+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _Temperature+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _demoText+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_demoText+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Click_TempHum10_PIC.c,59 :: 		mikrobus_logWrite(" Temperature : ", _LOG_TEXT);
	MOVLW       ?lstr2_Click_TempHum10_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr2_Click_TempHum10_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_TempHum10_PIC.c,60 :: 		mikrobus_logWrite(demoText, _LOG_LINE);
	MOVLW       _demoText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_demoText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_TempHum10_PIC.c,62 :: 		FloatToStr(Humidity, demoText);
	MOVF        _Humidity+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _Humidity+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _Humidity+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _Humidity+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _demoText+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_demoText+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Click_TempHum10_PIC.c,63 :: 		mikrobus_logWrite(" Humidity : ", _LOG_TEXT);
	MOVLW       ?lstr3_Click_TempHum10_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr3_Click_TempHum10_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_TempHum10_PIC.c,64 :: 		mikrobus_logWrite(demoText, _LOG_LINE);
	MOVLW       _demoText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_demoText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_TempHum10_PIC.c,66 :: 		mikrobus_logWrite("---------------------", _LOG_LINE);
	MOVLW       ?lstr4_Click_TempHum10_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr4_Click_TempHum10_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_TempHum10_PIC.c,68 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_TempHum10_PIC.c,69 :: 		}
L_end_applicationTask:
	RETURN      0
; end of _applicationTask

_main:

;Click_TempHum10_PIC.c,71 :: 		void main()
;Click_TempHum10_PIC.c,73 :: 		systemInit();
	CALL        _systemInit+0, 0
;Click_TempHum10_PIC.c,74 :: 		applicationInit();
	CALL        _applicationInit+0, 0
;Click_TempHum10_PIC.c,76 :: 		while (1)
L_main1:
;Click_TempHum10_PIC.c,78 :: 		applicationTask();
	CALL        _applicationTask+0, 0
;Click_TempHum10_PIC.c,79 :: 		}
	GOTO        L_main1
;Click_TempHum10_PIC.c,80 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
