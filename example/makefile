CXX=avr-gcc

#CHANGES THE TWO FOLLOWING LINES ACOORDINGLY!
#MAKE THEM POINT TO THE INCLUDE DIR AND TO THE DIR CONTAINING libarduino.a
INCLUDE=-I ../include
LIBS=-L ../ -lm -larduino

MCU=-mmcu=atmega328p
CPU_SPEED=-DF_CPU=16000000UL
CFLAGS=$(MCU) $(CPU_SPEED) -Os -w -Wl,--gc-sections -ffunction-sections -fdata-sections

PORT=/dev/cuaU0 # FreeBSD
ifeq ($(shell uname),Linux)
	PORT=/dev/ttyACM0
endif

C_SOURCES = $(wildcard *.c)
CXX_SOURCES = $(wildcard *.cpp)

C_OBJECTS = $(patsubst %.c,%.o,$(C_SOURCES))
CXX_OBJECTS = $(patsubst %.cpp,%.o,$(CXX_SOURCES) )

OBJS= $(CXX_OBJECTS) $(C_OBJECTS)

default: build upload

build: program.hex

program.hex: program.elf
	avr-objcopy -O ihex $< $@

program.elf: $(OBJS)
	$(CXX) $(CFLAGS) $(INCLUDE) $^ -o $@ $(LIBS)

upload:
	avrdude -V -F -p m328p -c arduino -b 115200 -Uflash:w:program.hex -P$(PORT)

clean:
	@echo -n Cleaning ...
	$(shell rm program.elf 2> /dev/null)
	$(shell rm program.hex 2> /dev/null)
	$(shell rm *.o 2> /dev/null)
	@echo " done"

%.o: %.cpp
	$(CXX) $< $(CFLAGS) $(INCLUDE) -c -o $@

%.o: %.c
	$(CXX) $< $(CFLAGS) $(INCLUDE) -c -o $@