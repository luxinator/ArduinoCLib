CXX=avr-gcc
INCLUDE=-I ../include/
LIBS=-L ../ -lm -larduino
MCU=-mmcu=atmega328p
CPU_SPEED=-DF_CPU=16000000UL
CFLAGS=$(MCU) $(CPU_SPEED) -Os -w -Wl,--gc-sections -ffunction-sections -fdata-sections
PORT=/dev/cuaU0 # FreeBSD
ifeq ($(shell uname),Linux)
	PORT=/dev/ttyACM0
endif

default: build upload

build: Test.hex

Test.hex: Test.elf
	avr-objcopy -O ihex $< $@

OBJS= # Put other objects here
Test.elf: Test.cpp $(OBJS)
	$(CXX) $(CFLAGS) $(INCLUDE) $^ -o $@ $(LIBS)

upload:
	avrdude -V -F -p m328p -c arduino -b 115200 -Uflash:w:Test.hex -P$(PORT)

clean:
	@echo -n Cleaning ...
	$(shell rm Test.elf 2> /dev/null)
	$(shell rm Test.hex 2> /dev/null)
	$(shell rm *.o 2> /dev/null)
	@echo " done"

%.o: %.cpp
	$(CXX) $< $(CFLAGS) $(INCLUDE) -c -o $@