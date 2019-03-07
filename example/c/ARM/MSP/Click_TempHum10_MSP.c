/*
Example for TempHum10 Click

    Date          : dec 2018.
    Author        : Katarina Perendic

Test configuration MSP :
    
    MCU              : MSP432
    Dev. Board       : Clicker 2 for MSP432
    ARM Compiler ver : v6.0.0.0

---

Description :

The application is composed of three sections :

- System Initialization - Initializes I2C module and sets CS pin as OUTPUT
- Application Initialization - Initialization driver init and sets device mode
- Application Task - (code snippet) - Reads Temperature and Humidity data and logs this data to USBUART every 1 sec.

*/

#include "Click_TempHum10_types.h"
#include "Click_TempHum10_config.h"

float Temperature = 0;
float Humidity = 0;
char demoText[ 20 ];

void systemInit()
{
    mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
    mikrobus_i2cInit( _MIKROBUS1, &_TEMPHUM10_I2C_CFG[0] );
    mikrobus_logInit( _MIKROBUS2, 9600 );
    mikrobus_logWrite(" --- System Init ---", _LOG_LINE);
    Delay_100ms();
}

void applicationInit()
{
    temphum10_i2cDriverInit( (T_TEMPHUM10_P)&_MIKROBUS1_GPIO, (T_TEMPHUM10_P)&_MIKROBUS1_I2C, 0x7F );
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