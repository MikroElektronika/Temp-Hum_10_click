#line 1 "D:/Clicks_git/T/Temp-Hum_10_click/SW/example/c/ARM/STM/Click_TempHum10_STM.c"
#line 1 "d:/clicks_git/t/temp-hum_10_click/sw/example/c/arm/stm/click_temphum10_types.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdint.h"





typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;
typedef signed long long int64_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;
typedef unsigned long long uint64_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;
typedef signed long long int_least64_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;
typedef unsigned long long uint_least64_t;



typedef signed long int int_fast8_t;
typedef signed long int int_fast16_t;
typedef signed long int int_fast32_t;
typedef signed long long int_fast64_t;


typedef unsigned long int uint_fast8_t;
typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long long uint_fast64_t;


typedef signed long int intptr_t;
typedef unsigned long int uintptr_t;


typedef signed long long intmax_t;
typedef unsigned long long uintmax_t;
#line 1 "d:/clicks_git/t/temp-hum_10_click/sw/example/c/arm/stm/click_temphum10_config.h"
#line 1 "d:/clicks_git/t/temp-hum_10_click/sw/example/c/arm/stm/click_temphum10_types.h"
#line 3 "d:/clicks_git/t/temp-hum_10_click/sw/example/c/arm/stm/click_temphum10_config.h"
const uint32_t _TEMPHUM10_I2C_CFG[ 1 ] =
{
 100000
};
#line 1 "d:/clicks_git/t/temp-hum_10_click/sw/library/__temphum10_driver.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdint.h"
#line 58 "d:/clicks_git/t/temp-hum_10_click/sw/library/__temphum10_driver.h"
extern const uint8_t _TEMPHUM10_REG_DEVICE_RESET ;
extern const uint8_t _TEMPHUM10_REG_AVERAGE_MODE ;
extern const uint8_t _TEMPHUM10_REG_ERROR_FLAG ;
extern const uint8_t _TEMPHUM10_REG_HUMIDITY_LSB ;
extern const uint8_t _TEMPHUM10_REG_HUMIDITY_MSB ;
extern const uint8_t _TEMPHUM10_REG_TEMPERATURE_LSB ;
extern const uint8_t _TEMPHUM10_REG_TEMPERATURE_MSB ;
extern const uint8_t _TEMPHUM10_REG_CAPACITY_LSB ;
extern const uint8_t _TEMPHUM10_REG_CAPACITY_MSB ;
extern const uint8_t _TEMPHUM10_REG_CAPACITY_CTRL ;


extern const uint8_t _TEMPHUM10_MODE_SLEEP ;
extern const uint8_t _TEMPHUM10_MODE_STANDBY ;


extern const uint8_t _TEMPHUM10_RST_NORMAL_OPERATION ;
extern const uint8_t _TEMPHUM10_RST_ACTIVE_RESET ;


extern const uint8_t _TEMPHUM10_AM_NO_AVERAGING_PROCESS ;
extern const uint8_t _TEMPHUM10_AM_TIMES_AVERAGE_MODE_2 ;
extern const uint8_t _TEMPHUM10_AM_TIMES_AVERAGE_MODE_4 ;
extern const uint8_t _TEMPHUM10_AM_TIMES_AVERAGE_MODE_8 ;
extern const uint8_t _TEMPHUM10_AM_TEMP_AVERAGE_MODE_TIMES_8 ;
extern const uint8_t _TEMPHUM10_AM_TEMP_AVERAGE_MODE_TIMES_16 ;
extern const uint8_t _TEMPHUM10_AM_MANUAL_MODE_DETECTION_OP_STOP ;
extern const uint8_t _TEMPHUM10_AM_MANUAL_MODE_DETECTION_OP_START ;


extern const uint8_t _TEMPHUM10_ERR_NO_ERROR ;
extern const uint8_t _TEMPHUM10_ERR_ERROR_FLAG_RESET ;


extern const uint8_t _TEMPHUM10_CAP_OUTSIDE_CAPACITY_CUTTING ;
extern const uint8_t _TEMPHUM10_CAP_OUTSIDE_CAPACITY_CONNECTION ;
#line 108 "d:/clicks_git/t/temp-hum_10_click/sw/library/__temphum10_driver.h"
void temphum10_i2cDriverInit( const uint8_t*  gpioObj,  const uint8_t*  i2cObj, uint8_t slave);
#line 115 "d:/clicks_git/t/temp-hum_10_click/sw/library/__temphum10_driver.h"
void temphum10_gpioDriverInit( const uint8_t*  gpioObj);
#line 125 "d:/clicks_git/t/temp-hum_10_click/sw/library/__temphum10_driver.h"
void temphum10_writeByte(uint8_t reg, uint8_t _data);
#line 133 "d:/clicks_git/t/temp-hum_10_click/sw/library/__temphum10_driver.h"
uint8_t temphum10_readByte(uint8_t reg);
#line 140 "d:/clicks_git/t/temp-hum_10_click/sw/library/__temphum10_driver.h"
float temphum10_getHumidity();
#line 147 "d:/clicks_git/t/temp-hum_10_click/sw/library/__temphum10_driver.h"
float temphum10_getTemperature();
#line 154 "d:/clicks_git/t/temp-hum_10_click/sw/library/__temphum10_driver.h"
void temphum10_setDeviceMode(uint8_t mode);
#line 161 "d:/clicks_git/t/temp-hum_10_click/sw/library/__temphum10_driver.h"
void temphum10_repeatMeasurement(uint8_t average);
#line 30 "D:/Clicks_git/T/Temp-Hum_10_click/SW/example/c/ARM/STM/Click_TempHum10_STM.c"
float Temperature = 0;
float Humidity = 0;
char demoText[ 20 ];

void systemInit()
{
 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
 mikrobus_i2cInit( _MIKROBUS1, &_TEMPHUM10_I2C_CFG[0] );
 mikrobus_logInit( _LOG_USBUART_A, 9600 );
 mikrobus_logWrite(" --- System Init ---", _LOG_LINE);
 Delay_100ms();
}

void applicationInit()
{
 temphum10_i2cDriverInit( ( const uint8_t* )&_MIKROBUS1_GPIO, ( const uint8_t* )&_MIKROBUS1_I2C, 0x7F );
 temphum10_setDeviceMode(_TEMPHUM10_MODE_STANDBY);
 Delay_ms( 1000 );
 temphum10_writeByte(_TEMPHUM10_REG_DEVICE_RESET, _TEMPHUM10_RST_NORMAL_OPERATION);

}

void applicationTask()
{
 temphum10_repeatMeasurement(_TEMPHUM10_AM_TIMES_AVERAGE_MODE_2 | _TEMPHUM10_AM_TEMP_AVERAGE_MODE_TIMES_16);

 Temperature = temphum10_getTemperature();
 Humidity = temphum10_getHumidity();

 FloatToStr(Temperature, demoText);
 mikrobus_logWrite(" Temperature : ", _LOG_TEXT);
 mikrobus_logWrite(demoText, _LOG_LINE);

 FloatToStr(Humidity, demoText);
 mikrobus_logWrite(" Humidity : ", _LOG_TEXT);
 mikrobus_logWrite(demoText, _LOG_LINE);

 mikrobus_logWrite("---------------------", _LOG_LINE);

 Delay_1sec();
}

void main()
{
 systemInit();
 applicationInit();

 while (1)
 {
 applicationTask();
 }
}
