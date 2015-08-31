/*
	MicroView Arduino Flashing Heart Demo
	Copyright (C) 2014 GeekAmmo

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
#include <MicroView.h>



void setup() {
	uView.begin();
	uView.clear(PAGE);
uView.setFontType(1);

uView.drawChar(0,0,'5');
uView.display();
}

void loop() {

	uView.drawChar(0,0,'0');
uView.display();
delay(500);
	uView.drawChar(0,0,'1');
uView.display();
delay(500);
	uView.drawChar(0,0,'2');
uView.display();
delay(500);
	uView.drawChar(0,0,'3');
uView.display();
delay(500);
	uView.drawChar(0,0,'4');
uView.display();
delay(500);
	uView.drawChar(0,0,'5');
uView.display();
delay(500);

}
