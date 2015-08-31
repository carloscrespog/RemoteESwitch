#include <MicroView.h>

#define OK 0
#define LOW_BATTERY 1
#define BROKEN_CONN 2
#define TIME_OUT 3
#define PRESSED 4
#define ESA 5


int MSB=A2;
int ESB=A1;
int LSB=A0;
int MSBState=0;
int ESBState=0;
int LSBState=0;
void setup() {
	uView.begin();
	uView.clear(PAGE);
	pinMode(MSB,INPUT);
	digitalWrite(MSB,HIGH);
	pinMode(ESB,INPUT);
	digitalWrite(ESB,HIGH);
	pinMode(LSB,INPUT);
	digitalWrite(LSB,HIGH);
        uView.setFontType(1);
	printData(ESA);
}

void loop() {
  
	MSBState=digitalRead(MSB);
	ESBState=digitalRead(ESB);
	LSBState=digitalRead(LSB);
        if (MSBState==HIGH){
           //1xx
           if (ESBState==HIGH){
           //11x
               if (LSBState==HIGH){
                 //111
                 printData(ESA);
               }else{
                 //110
                 printData(ESA);
               }
           }else{
           //10x
               if (LSBState==HIGH){
                 //101
                 printData(PRESSED);
               }else{
                 //100
                 printData(TIME_OUT);
               }
           }
        }else{
           //0xx
           if (ESBState==HIGH){
           //01x
               if (LSBState==HIGH){
                 //011
                 printData(BROKEN_CONN);
               }else{
                 //010
                 printData(LOW_BATTERY);
               }
           }else{
           //00x
             if (LSBState==HIGH){
               //001
                 printData(OK);
               }else{
                 //000
                 printData(ESA);
               }
           }
        }
}

  
  void printData(int data){
    
    switch(data){	
	case 0:		
	  uView.drawChar(0,0,'0');
          uView.display();
	  break;
	case 1:		
	  uView.drawChar(0,0,'1');
          uView.display();
	  break;
        case 2:		
	  uView.drawChar(0,0,'2');
          uView.display();
	  break;
        case 3:		
	  uView.drawChar(0,0,'3');
          uView.display();
	  break;
        case 4:		
	  uView.drawChar(0,0,'4');
          uView.display();
	  break;
        case 5:		
	  uView.drawChar(0,0,'5');
          uView.display();
	  break;
    }
}
void printDatadebug(int data){
    uView.setCursor(0,0);
    uView.setFontType(0);
    MSBState=digitalRead(MSB);
    ESBState=digitalRead(ESB);
    LSBState=digitalRead(LSB);
    uView.print(MSBState);
    uView.print(ESBState);
    uView.print(LSBState);
    uView.display();
}
