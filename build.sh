#!/bin/bash

##
## Will build for the standard Arduino, for different Change files Accordingly
## the file Arduino/variants/boards.txt has all the stuff you need
##

ArduinoGIT="https://github.com/arduino/Arduino"
ArduinoSource="Arduino/hardware/arduino/avr/cores/arduino/"
Board="Arduino/hardware/arduino/avr/variants/standard/"


for i in "$@"
do
case $i in
    -c|-clean*)
    CLEAN=true
    shift # past argument=value
    ;;
    -h|-help*)
	echo ""
    echo "This script will pull the Arduino Library from Github"
    echo "And build a libarduino.a file and an header directory"
    echo "Options: "
    echo " -c,-clean: Cleans directory"
    echo " -h,-help:  Show this help text"
    echo ""
    shift # past argument=value
    exit
    ;;
    *)
            # unknown option
    ;;
esac
done

if [ $CLEAN ]
then
	echo "Cleaning ..."
	rm -rf "Arduino"
	rm -rf "source"
	rm -rf "libarduino.a"
	rm -rf "include"
	echo "Done!"
	exit
fi

#GET arduino  sources:
echo Getting Arduino library sources

if [ -d "Arduino" ]
then
    echo "Checking For Updates:"
    cd Arduino
    git pull
    cd ..
else
	git clone --depth=1 $ArduinoGIT
    
fi


echo Setting up build environemnt
#Get the Arduino library files:
if [ ! -d "source" ] 
then
	mkdir -p source
fi
echo Copying needed files to source dir
cp -R $ArduinoSource/* ./source/
cp -R $Board/* ./source/


if [ ! -d "include" ] 
then
	mkdir -p include
fi
cp source/*.h include/

echo Running Make
make -f makefile.lib

if [ ! -f libarduino.a ]
then
	echo Something went Wrong
	exit
fi


echo Done!


