PROGRAM PLC_PRG
VAR
	Sensor01: BOOL; //Photoelectric sensor at the begining of the passage
	Sensor02: BOOL; //Photoelectric sensor at the end of the passage
	GreenLight1: BOOL; //Green Trafic light at the exit and entrance
	RedLight1: BOOL; //Red Trafic Light at the exit and entrance
	GreenLight2: BOOL; //Green Trafic light at the exit and entrance
	RedLight2: BOOL; //Red Trafic Light at the exit and entrance
	R01: BOOL; //Intermediate variable
	R02:BOOL; //Intermediate variable
	
	
	Reset : BOOL; // reset switch to turn the green lights on
	carpos: INT:=0; // position of the car on the passage
	S01R_Trig: R_Trig; //Rising edge trigger for sensor 1
	S02R_Trig: R_Trig; //Rising edge trigger for sensor 2
	S01F_Trig: F_Trig; //Falling edge trigger for sensor 1
	S02F_Trig: F_Trig; //Falling edge trigger for sensor 2
END_VAR


Sensor01:=carpos>3 AND carpos<23;
Sensor02:=carpos>74 AND carpos<97;
S01R_Trig(clk:=Sensor01); // Specify the input to the rising edge trigger FB
S02R_Trig(clk:=Sensor02); // Specify the input to the rising edge trigger FB
S01F_Trig(clk:=Sensor01); // Specify the input to the falling edge trigger FB
S02F_Trig(clk:=Sensor02); // Specify the input to the falling edge trigger FB

//R01 R= R02 R=Reset; //Initialization, turnig the red lights off  using "Reset" and R
R01 R= Reset;
R02 R= Reset;

Redlight1:= R02; //R01 OR turn the red light on if R01 or R02 is True
Redlight2:= R01 ; //OR R02turn the red light on if R01 or R02 is True
Greenlight1:= NOT RedLight1;
Greenlight2:= NOT RedLight2;

R01 S= (S01R_Trig.Q AND Greenlight1);

R02 S= (S02R_Trig.Q AND Greenlight2);
