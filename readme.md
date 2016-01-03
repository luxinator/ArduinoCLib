
This script will pull the [Arduino Library](https://github.com/arduino/Arduino) from [Github](https://github.com/)
And build a `libarduino.a` file and an header directory

The script includes a example directory containing the *blink* program. 
The Makefile of the example can be used to build further projects. Remeber to point the Makefile to the `include` directory and to the location of the `libarduino.a` file.

The Makefiles are inspired and based on: https://www.ashleymills.com/node/327
