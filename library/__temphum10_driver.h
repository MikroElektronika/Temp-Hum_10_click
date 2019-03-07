/*
    __temphum10_driver.h

-----------------------------------------------------------------------------

  This file is part of mikroSDK.
  
  Copyright (c) 2017, MikroElektonika - http://www.mikroe.com

  All rights reserved.

----------------------------------------------------------------------------- */

/**
@file   __temphum10_driver.h
@brief    TempHum10 Driver
@mainpage TempHum10 Click
@{

@image html libstock_fb_view.jpg

@}

@defgroup   TEMPHUM10
@brief      TempHum10 Click Driver
@{

| Global Library Prefix | **TEMPHUM10** |
|:---------------------:|:-----------------:|
| Version               | **1.0.0**    |
| Date                  | **dec 2018.**      |
| Developer             | **Katarina Perendic**     |

*/
/* -------------------------------------------------------------------------- */

#include "stdint.h"

#ifndef _TEMPHUM10_H_
#define _TEMPHUM10_H_

/** 
 * @macro T_TEMPHUM10_P
 * @brief Driver Abstract type 
 */
#define T_TEMPHUM10_P    const uint8_t*

/** @defgroup TEMPHUM10_COMPILE Compilation Config */              /** @{ */

//  #define   __TEMPHUM10_DRV_SPI__                            /**<     @macro __TEMPHUM10_DRV_SPI__  @brief SPI driver selector */
   #define   __TEMPHUM10_DRV_I2C__                            /**<     @macro __TEMPHUM10_DRV_I2C__  @brief I2C driver selector */                                          
// #define   __TEMPHUM10_DRV_UART__                           /**<     @macro __TEMPHUM10_DRV_UART__ @brief UART driver selector */ 

                                                                       /** @} */
/** @defgroup TEMPHUM10_VAR Variables */                           /** @{ */

/* Registers */
extern const uint8_t _TEMPHUM10_REG_DEVICE_RESET     ;
extern const uint8_t _TEMPHUM10_REG_AVERAGE_MODE     ;
extern const uint8_t _TEMPHUM10_REG_ERROR_FLAG       ;
extern const uint8_t _TEMPHUM10_REG_HUMIDITY_LSB     ;
extern const uint8_t _TEMPHUM10_REG_HUMIDITY_MSB     ;
extern const uint8_t _TEMPHUM10_REG_TEMPERATURE_LSB  ;
extern const uint8_t _TEMPHUM10_REG_TEMPERATURE_MSB  ;
extern const uint8_t _TEMPHUM10_REG_CAPACITY_LSB     ;
extern const uint8_t _TEMPHUM10_REG_CAPACITY_MSB     ;
extern const uint8_t _TEMPHUM10_REG_CAPACITY_CTRL    ;

/* Mode */
extern const uint8_t _TEMPHUM10_MODE_SLEEP   ;
extern const uint8_t _TEMPHUM10_MODE_STANDBY ;

/* Reset */
extern const uint8_t _TEMPHUM10_RST_NORMAL_OPERATION ;
extern const uint8_t _TEMPHUM10_RST_ACTIVE_RESET     ;

/* Average Mode */
extern const uint8_t _TEMPHUM10_AM_NO_AVERAGING_PROCESS            ;
extern const uint8_t _TEMPHUM10_AM_TIMES_AVERAGE_MODE_2            ;
extern const uint8_t _TEMPHUM10_AM_TIMES_AVERAGE_MODE_4            ;
extern const uint8_t _TEMPHUM10_AM_TIMES_AVERAGE_MODE_8            ;
extern const uint8_t _TEMPHUM10_AM_TEMP_AVERAGE_MODE_TIMES_8       ;
extern const uint8_t _TEMPHUM10_AM_TEMP_AVERAGE_MODE_TIMES_16      ;
extern const uint8_t _TEMPHUM10_AM_MANUAL_MODE_DETECTION_OP_STOP   ;
extern const uint8_t _TEMPHUM10_AM_MANUAL_MODE_DETECTION_OP_START  ;

/* ERROR */
extern const uint8_t _TEMPHUM10_ERR_NO_ERROR          ;
extern const uint8_t _TEMPHUM10_ERR_ERROR_FLAG_RESET  ;

/* Capacity contorl */
extern const uint8_t _TEMPHUM10_CAP_OUTSIDE_CAPACITY_CUTTING    ;
extern const uint8_t _TEMPHUM10_CAP_OUTSIDE_CAPACITY_CONNECTION ;


                                                                       /** @} */

#ifdef __cplusplus
extern "C"{
#endif

/** @defgroup TEMPHUM10_INIT Driver Initialization */              /** @{ */

#ifdef   __TEMPHUM10_DRV_SPI__
void temphum10_spiDriverInit(T_TEMPHUM10_P gpioObj, T_TEMPHUM10_P spiObj);
#endif
#ifdef   __TEMPHUM10_DRV_I2C__
void temphum10_i2cDriverInit(T_TEMPHUM10_P gpioObj, T_TEMPHUM10_P i2cObj, uint8_t slave);
#endif
#ifdef   __TEMPHUM10_DRV_UART__
void temphum10_uartDriverInit(T_TEMPHUM10_P gpioObj, T_TEMPHUM10_P uartObj);
#endif

// GPIO Only Drivers - remove in other cases
void temphum10_gpioDriverInit(T_TEMPHUM10_P gpioObj);
                                                                       /** @} */
/** @defgroup TEMPHUM10_FUNC Driver Functions */                   /** @{ */

/**
 * @brief Functions for write one byte in register
 *
 * @param[in] reg    Register in which the data will be written
 * @param[in] _data  Data which be written in the register
 */
void temphum10_writeByte(uint8_t reg, uint8_t _data);

/**
 * @brief Functions for read one byte from register
 *
 * @param[in] reg    Register
 * @return one byte data
 */
uint8_t temphum10_readByte(uint8_t reg);

/**
 * @brief Functions for read Relative Huminidy data
 *
 * @return Relative Huminidy data in [%RH]
 */
float temphum10_getHumidity();

/**
 * @brief Functions for read Temperature data
 *
 * @return Temperature data in [C]
 */
float temphum10_getTemperature();

/**
 * @brief Functions for sets Device mode
 *
 * @param[in] mode   Device mode (_TEMPHUM10_MODE_SLEEP or _TEMPHUM10_MODE_STANDBY)
 */
void temphum10_setDeviceMode(uint8_t mode);

/**
 * @brief Functions for repeat measurement
 *
 * @param[in] average   Sets average times(2, 4, 8 times or no average) and temperature (_TEMPHUM10_AM_TEMP_AVERAGE_MODE_TIMES_8 or _TEMPHUM10_AM_TEMP_AVERAGE_MODE_TIMES_16)
 */
void temphum10_repeatMeasurement(uint8_t average);





                                                                       /** @} */
#ifdef __cplusplus
} // extern "C"
#endif
#endif

/**
    @example Click_TempHum10_STM.c
    @example Click_TempHum10_TIVA.c
    @example Click_TempHum10_CEC.c
    @example Click_TempHum10_KINETIS.c
    @example Click_TempHum10_MSP.c
    @example Click_TempHum10_PIC.c
    @example Click_TempHum10_PIC32.c
    @example Click_TempHum10_DSPIC.c
    @example Click_TempHum10_AVR.c
    @example Click_TempHum10_FT90x.c
    @example Click_TempHum10_STM.mbas
    @example Click_TempHum10_TIVA.mbas
    @example Click_TempHum10_CEC.mbas
    @example Click_TempHum10_KINETIS.mbas
    @example Click_TempHum10_MSP.mbas
    @example Click_TempHum10_PIC.mbas
    @example Click_TempHum10_PIC32.mbas
    @example Click_TempHum10_DSPIC.mbas
    @example Click_TempHum10_AVR.mbas
    @example Click_TempHum10_FT90x.mbas
    @example Click_TempHum10_STM.mpas
    @example Click_TempHum10_TIVA.mpas
    @example Click_TempHum10_CEC.mpas
    @example Click_TempHum10_KINETIS.mpas
    @example Click_TempHum10_MSP.mpas
    @example Click_TempHum10_PIC.mpas
    @example Click_TempHum10_PIC32.mpas
    @example Click_TempHum10_DSPIC.mpas
    @example Click_TempHum10_AVR.mpas
    @example Click_TempHum10_FT90x.mpas
*/                                                                     /** @} */
/* -------------------------------------------------------------------------- */
/*
  __temphum10_driver.h

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