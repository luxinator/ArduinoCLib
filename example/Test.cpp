#include "Arduino.h"

void setup() {
   pinMode(13,OUTPUT);
}

void loop() {
   digitalWrite(13,HIGH);
   delay(100);
   digitalWrite(13,LOW);
   delay(300);
}

int main() {
   init();
   setup();
   while(1)
      loop();
}