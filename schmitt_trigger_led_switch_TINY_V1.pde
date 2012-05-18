/*
This is Version One of schmitt_trigger_led_switch_TINY
The pin assignments on the ATTINY45 target MCU are slightly different from
the Atmega328, so changes have been made from the Arduino version:
Arduino Pins        ATTINY45 Pins
LED = 3               LED = 1
SW1 = 2               SW1 = 2
PST = 4               PST = 3

bob murphy 2012-04-30

Note: You cannot use Pin 1, Tx, to control the PST, Tx will 
be HIGH value all of the time apparently

*/

int sw_on = 1;   // sets the on or off state of the switch
int SW1 = 2;     // pin number for button 
int PST = 3;     // pin number for on and off Power Switch Tail
int state = 1;   // returns 0 if button pressed
int prev_state = 1;// to correct for holding the button down too long
int count = 0;   // value to increment fade up or down
int fadedir = 1;   // direction of fade up or down; 1 = up, 0 = down
int LED = 1;     // LED inside SW1 PWM, needs pin 3 in arduino, pin 0 or 1 in ATTINY45

void setup ()
{
  
  pinMode(LED, OUTPUT);
  pinMode(SW1, INPUT);
}

void loop ()
{
  state = digitalRead(SW1);
  
  if (state == 0 && prev_state != state)    // button was pressed
    { sw_on = ! sw_on ; // toggle flag for switch condition sw_on 1 = TRUE 
    } 
  prev_state = state;   // if button held down, get series of 0's

  
  if (sw_on == 0)
  {
    digitalWrite(SW1, LOW);
  }
  
  if (sw_on == 0 && fadedir)      // switch (power) is off, fade up in brightness
      {  
        fadeup();
    }
 if (sw_on == 0 && fadedir == 0)
      {
        fadedown();
    }

  
  if (sw_on)    // switch (power) is on 
    {
    count = 255;
    digitalWrite(SW1, HIGH);
    }
  
  
 
  
  analogWrite(LED, count);
 
 delay(5);      // adjust this for fade time but not too much - flaky button response!  
 
}     

void fadeup ()
{if (count >= 255)
  {fadedir = 0;}
  else 
 {count = count + 1;}
 }
 
void fadedown ()
{if (count <= 0)
    {fadedir = 1;}
 else
    {count = count - 1;}
}
  










