/*  
 *  ------ [SX_02b] - RX LoRa -------- 
 *  
 *  Explanation: This example shows how to configure the semtech 
 *  module in LoRa mode and then receive packets with plain-text payloads
 *  
 *  Copyright (C) 2014 Libelium Comunicaciones Distribuidas S.L. 
 *  http://www.libelium.com 
 *  
 *  This program is free software: you can redistribute it and/or modify  
 *  it under the terms of the GNU General Public License as published by  
 *  the Free Software Foundation, either version 3 of the License, or  
 *  (at your option) any later version.  
 *   
 *  This program is distributed in the hope that it will be useful,  
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of  
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the  
 *  GNU General Public License for more details.  
 *   
 *  You should have received a copy of the GNU General Public License  
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.  
 *  
 *  Version:           0.1
 *  Design:            David Gascón 
 *  Implementation:    Covadonga Albiñana, Yuri Carmona
 */

// Include this library for transmit with sx1272
#include <WaspSX1272.h>

// status variable
int8_t e;

int relayPin=DIGITAL7;
int ledPin=DIGITAL3;
bool firstLoss=false;

void setup() 
{
  // Init USB port
  USB.ON();
  USB.println(F("SX_02b example"));
  USB.println(F("Semtech SX1272 module RX in LoRa"));

  USB.println(F("----------------------------------------"));
  USB.println(F("Setting configuration:")); 
  USB.println(F("----------------------------------------"));

  // Init sx1272 module
  sx1272.ON();

  // Select frequency channel
  e = sx1272.setChannel(CH_14_868);  
  USB.print(F("Setting Channel CH_14_868.\t state ")); 
  USB.println(e);

  // Select implicit (off) or explicit (on) header mode
  e = sx1272.setHeaderON();
  USB.print(F("Setting Header ON.\t\t state ")); 
  USB.println(e);

  // Select mode: from 1 to 10
  e = sx1272.setMode(7);
  USB.print(F("Setting Mode '1'.\t\t state "));
  USB.println(e);  

  // Select CRC on or off
  e = sx1272.setCRC_OFF();
  USB.print(F("Setting CRC OFF.\t\t\t state ")); 
  USB.println(e);  

  // Select output power (Max, High or Low)
  e = sx1272.setPower('M');
  USB.print(F("Setting Power to 'M'.\t\t state ")); 
  USB.println(e);  

  // Select the node address value: from 2 to 255
  e = sx1272.setNodeAddress(8);
  USB.print(F("Setting Node Address to '8'.\t state "));
  USB.println(e); 

  delay(1000);  

  USB.println(F("----------------------------------------"));
  USB.println(F("Receiving:")); 
  USB.println(F("----------------------------------------"));
  pinMode(relayPin,OUTPUT);
  pinMode(ledPin,OUTPUT);
  digitalWrite(relayPin,LOW);
  digitalWrite(ledPin,LOW);

}


void loop()
{
  // receive packet
  e = sx1272.receivePacketTimeout(600);

  
  
  // check rx status
  if( e==0 )
  {
   // USB.println(F("\nShow packet received: "));

    // show packet received
   // sx1272.showReceivedPacket();
    digitalWrite(relayPin,LOW);
    digitalWrite(ledPin,LOW);
    firstLoss=false;

  }
  else
  {
    //timeout
   // USB.print(F("\nReceiving packet TIMEOUT, state "));
    //USB.println(e, DEC);  
    if (firstLoss==true)
    {
      digitalWrite(relayPin,HIGH);
      digitalWrite(ledPin,HIGH);
    }else
    {
     firstLoss=true; 
    }
  }

}





