/*
    __temphum10_driver.c

-----------------------------------------------------------------------------

  This file is part of mikroSDK.

  Copyright (c) 2017, MikroElektonika - http://www.mikroe.com

  All rights reserved.

----------------------------------------------------------------------------- */

#include "__temphum10_driver.h"
#include "__temphum10_hal.c"

/* ------------------------------------------------------------------- MACROS */

/* Registers */
const uint8_t _TEMPHUM10_REG_DEVICE_RESET      = 0x00;
const uint8_t _TEMPHUM10_REG_AVERAGE_MODE      = 0x01;
const uint8_t _TEMPHUM10_REG_ERROR_FLAG        = 0x03;
const uint8_t _TEMPHUM10_REG_HUMIDITY_LSB      = 0x04;
const uint8_t _TEMPHUM10_REG_HUMIDITY_MSB      = 0x05;
const uint8_t _TEMPHUM10_REG_TEMPERATURE_LSB   = 0x06;
const uint8_t _TEMPHUM10_REG_TEMPERATURE_MSB   = 0x07;
const uint8_t _TEMPHUM10_REG_CAPACITY_LSB      = 0x0A;
const uint8_t _TEMPHUM10_REG_CAPACITY_MSB      = 0x0B;
const uint8_t _TEMPHUM10_REG_CAPACITY_CTRL     = 0x2C;

/* Mode */
const uint8_t _TEMPHUM10_MODE_SLEEP   = 0x00;
const uint8_t _TEMPHUM10_MODE_STANDBY = 0x01;

/* Reset */
const uint8_t _TEMPHUM10_RST_NORMAL_OPERATION = 0x00;
const uint8_t _TEMPHUM10_RST_ACTIVE_RESET     = 0x01;

/* Average Mode */
const uint8_t _TEMPHUM10_AM_NO_AVERAGING_PROCESS            = 0x00;
const uint8_t _TEMPHUM10_AM_TIMES_AVERAGE_MODE_2            = 0x08;
const uint8_t _TEMPHUM10_AM_TIMES_AVERAGE_MODE_4            = 0x10;
const uint8_t _TEMPHUM10_AM_TIMES_AVERAGE_MODE_8            = 0x20;
const uint8_t _TEMPHUM10_AM_TEMP_AVERAGE_MODE_TIMES_8       = 0x00;
const uint8_t _TEMPHUM10_AM_TEMP_AVERAGE_MODE_TIMES_16      = 0x04;
const uint8_t _TEMPHUM10_AM_MANUAL_MODE_DETECTION_OP_STOP   = 0x00;
const uint8_t _TEMPHUM10_AM_MANUAL_MODE_DETECTION_OP_START  = 0x01;

/* ERROR */
const uint8_t _TEMPHUM10_ERR_NO_ERROR           = 0x00;
const uint8_t _TEMPHUM10_ERR_ERROR_FLAG_RESET   = 0x01;

/* Capacity contorl */
const uint8_t _TEMPHUM10_CAP_OUTSIDE_CAPACITY_CUTTING    = 0x00;
const uint8_t _TEMPHUM10_CAP_OUTSIDE_CAPACITY_CONNECTION = 0x10;



/* ---------------------------------------------------------------- VARIABLES */

#ifdef   __TEMPHUM10_DRV_I2C__
static uint8_t _slaveAddress;
#endif

/* -------------------------------------------- PRIVATE FUNCTION DECLARATIONS */



/* --------------------------------------------- PRIVATE FUNCTION DEFINITIONS */



/* --------------------------------------------------------- PUBLIC FUNCTIONS */

#ifdef   __TEMPHUM10_DRV_SPI__

void temphum10_spiDriverInit(T_TEMPHUM10_P gpioObj, T_TEMPHUM10_P spiObj)
{
    hal_spiMap( (T_HAL_P)spiObj );
    hal_gpioMap( (T_HAL_P)gpioObj );
}

#endif
#ifdef   __TEMPHUM10_DRV_I2C__

void temphum10_i2cDriverInit(T_TEMPHUM10_P gpioObj, T_TEMPHUM10_P i2cObj, uint8_t slave)
{
    _slaveAddress = slave;
    hal_i2cMap( (T_HAL_P)i2cObj );
    hal_gpioMap( (T_HAL_P)gpioObj );
}

#endif
#ifdef   __TEMPHUM10_DRV_UART__

void temphum10_uartDriverInit(T_TEMPHUM10_P gpioObj, T_TEMPHUM10_P uartObj)
{
    hal_uartMap( (T_HAL_P)uartObj );
    hal_gpioMap( (T_HAL_P)gpioObj );
}
#endif

/* ----------------------------------------------------------- IMPLEMENTATION */

void temphum10_writeByte(uint8_t reg, uint8_t _data)
{
    uint8_t writeReg[ 3 ];
    
    writeReg[ 0 ] = reg;
    writeReg[ 1 ] = _data;
    writeReg[ 2 ] = _data;
    
    hal_i2cStart();
    hal_i2cWrite(_slaveAddress, writeReg, 3, END_MODE_STOP);
}

uint8_t temphum10_readByte(uint8_t reg)
{
    uint8_t writeReg[ 1 ];
    uint8_t readReg[ 2 ];
    
    writeReg[ 0 ] = reg;

    hal_i2cStart();
    hal_i2cWrite(_slaveAddress, writeReg, 1, END_MODE_STOP);
    hal_i2cStart();
    hal_i2cRead(_slaveAddress, readReg, 1, END_MODE_STOP);

    return readReg[ 0 ];
}

float temphum10_getHumidity()
{
    uint8_t humMsb;
    uint8_t humLsb;
    uint16_t readData;
    float Humidity;
    
    humLsb = temphum10_readByte(_TEMPHUM10_REG_HUMIDITY_LSB);
    humMsb = temphum10_readByte(_TEMPHUM10_REG_HUMIDITY_MSB);
    
    readData = (humMsb & 0x03);
    readData = readData << 8;
    readData = readData | humLsb;
    
    Humidity = (float)((100.0/1024.0) * readData);
    return Humidity;
}

float temphum10_getTemperature()
{
    uint8_t tempMsb;
    uint8_t tempLsb;
    uint16_t readData;
    float Temperature;

    tempMsb = temphum10_readByte(_TEMPHUM10_REG_TEMPERATURE_MSB);
    tempLsb = temphum10_readByte(_TEMPHUM10_REG_TEMPERATURE_LSB);

    readData = (tempMsb & 0x07);
    readData = readData << 8;
    readData = readData | tempLsb;
    
    Temperature = (float)(readData - 774.0) * 0.1;
    return Temperature;
}

void temphum10_setDeviceMode(uint8_t mode)
{
    hal_gpio_csSet(mode);
}

void temphum10_repeatMeasurement(uint8_t average)
{
    temphum10_writeByte(_TEMPHUM10_REG_AVERAGE_MODE, average | _TEMPHUM10_AM_MANUAL_MODE_DETECTION_OP_START );
}

/* -------------------------------------------------------------------------- */
/*
  __temphum10_driver.c

  Copyright (c) 2017, MikroElektonika - http://www.mikroe.com

  All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

3. All advertising materials mentioning features or use of this software
   must display the following acknowledgement:
   This product includes software developed by the MikroElektonika.

4. Neither the name of the MikroElektonika nor the
   names of its contributors may be used to endorse or promote products
   derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY MIKROELEKTRONIKA ''AS IS'' AND ANY
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL MIKROELEKTRONIKA BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

----------------------------------------------------------------------------- */