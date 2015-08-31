#include <WaspSX1272.h>

int MSB=DIGITAL8;
int ESB=DIGITAL6;
int LSB=DIGITAL4;
int eSwitch = DIGITAL2;

bool pressedFlag=false;
bool brokenConnFlag=false;
bool timeOutFlag=false;
uint8_t rx_address = 8;
uint8_t payload = 1;
int8_t e;

int timeDelay=200;
void setup() {
        // LoRa Stuff
        USB.ON();
        sx1272.ON();
        e = sx1272.setChannel(CH_14_868);
        e = sx1272.setHeaderON();
        e = sx1272.setMode(7); //
        e = sx1272.setCRC_OFF();
        e = sx1272.setPower('M');
        e = sx1272.setNodeAddress(7);
        pinMode(MSB,OUTPUT);
	digitalWrite(MSB,LOW);
	pinMode(ESB,OUTPUT);
	digitalWrite(ESB,LOW);
	pinMode(LSB,OUTPUT);
	digitalWrite(LSB,LOW);
        //pull-up resistance
        pinMode(eSwitch,INPUT);
	digitalWrite(eSwitch,HIGH);
        drawESA();
        delay(timeDelay);
        drawOK();
        delay(timeDelay);
        drawLowBatt();
        delay(timeDelay);
        drawBrokenConn();
        delay(timeDelay);
        drawTimeout();
        delay(timeDelay);
        drawPressed();
        delay(timeDelay);
        drawESA();
}

//eSwitchState==LOW => eSwitch Pressed
void loop() {
    int eSwitchState=digitalRead(eSwitch);
    if (eSwitchState==HIGH){
      drawPressed();
      pressedFlag=true;
      brokenConnFlag=false;
      timeOutFlag= false;
    }else if (!brokenConnFlag&&!timeOutFlag){
      drawOK();
      pressedFlag=false;  
    }
    if (!pressedFlag && !brokenConnFlag){
      
      //e = sx1272.sendPacketTimeoutACK(rx_address,&payload,1,500);
      e = sx1272.sendPacketTimeout(rx_address,"",500);
      
      if (e !=0){
            //USB.println(F("Error sending the packet"));  
           // USB.print(F("state: "));
            //USB.println(e, DEC);
        if (brokenConnFlag==true){
          timeOutFlag= true;
          drawTimeout();
        }else{
          brokenConnFlag=true;
          drawBrokenConn();
        }
        
      }else{
        // USB.println(F("Packet sent OK"));     
        timeOutFlag= false;
        brokenConnFlag=false;
      }
    }
   delay(100);   
}

void drawESA(){
     //000
    digitalWrite(MSB,LOW);
    digitalWrite(ESB,LOW);
    digitalWrite(LSB,LOW); 
}
void drawOK(){
      //001
    digitalWrite(MSB,LOW);
    digitalWrite(ESB,LOW);
    digitalWrite(LSB,HIGH);

}

void drawLowBatt(){
   //010
    digitalWrite(MSB,LOW);
    digitalWrite(ESB,HIGH);
    digitalWrite(LSB,LOW);

}

void drawBrokenConn(){
    //011
    digitalWrite(MSB,LOW);
    digitalWrite(ESB,HIGH);
    digitalWrite(LSB,HIGH);

}
void drawTimeout(){
    //100
    digitalWrite(MSB,HIGH);
    digitalWrite(ESB,LOW);
    digitalWrite(LSB,LOW);

}
void drawPressed(){
    //101
    digitalWrite(MSB,HIGH);
    digitalWrite(ESB,LOW);
    digitalWrite(LSB,HIGH);
}
