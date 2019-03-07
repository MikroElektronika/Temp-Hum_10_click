![MikroE](http://www.mikroe.com/img/designs/beta/logo_small.png)

---

# TempHum10 Click

- **CIC Prefix**  : TEMPHUM10
- **Author**      : Katarina Perendic
- **Verison**     : 1.0.0
- **Date**        : dec 2018.

---


### Software Support

We provide a library for the TempHum10 Click on our [LibStock](https://libstock.mikroe.com/projects/view/2693/temp-hum-10-click) 
page, as well as a demo application (example), developed using MikroElektronika 
[compilers](http://shop.mikroe.com/compilers). The demo can run on all the main 
MikroElektronika [development boards](http://shop.mikroe.com/development-boards).

**Library Description**

The library initializes and defines the I2C bus driver and drivers that offer a choice for writing data in register and reads data form register.
The library includes function for read Temperature and Relative Huminidy data and function for set device mode.
The user also has the function for repeat measurement.

Key functions :

- ``` float temphum10_getHumidity() ``` - Functions for read Relative Huminidy data 
- ``` float temphum10_getTemperature() ``` - Functions for read Temperature data
- ``` void temphum10_repeatMeasurement(uint8_t average) ``` - Functions for repeat measurement

**Examples Description**

The application is composed of three sections :

- System Initialization - Initializes I2C module and sets CS pin as OUTPUT
- Application Initialization - Initialization driver init and sets device mode
- Application Task - (code snippet) - Reads Temperature and Humidity data and logs this data to USBUART every 1 sec.


```.c
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
```

The full application code, and ready to use projects can be found on our 
[LibStock](https://libstock.mikroe.com/projects/view/2693/temp-hum-10-click) page.

Other mikroE Libraries used in the example:

- I2C
- UART
- Conversions

**Additional notes and informations**

Depending on the development board you are using, you may need 
[USB UART click](http://shop.mikroe.com/usb-uart-click), 
[USB UART 2 Click](http://shop.mikroe.com/usb-uart-2-click) or 
[RS232 Click](http://shop.mikroe.com/rs232-click) to connect to your PC, for 
development systems with no UART to USB interface available on the board. The 
terminal available in all Mikroelektronika 
[compilers](http://shop.mikroe.com/compilers), or any other terminal application 
of your choice, can be used to read the message.

---
---
