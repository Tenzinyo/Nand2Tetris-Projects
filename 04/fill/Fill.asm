// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

(START)
@SCREEN 
D=A
@S
M=D

(KEYCHECK)
@KBD 
D=M 

@FILL
D; JGT 

@EMPTY
D;JEQ 

@KEYCHECK
0;JMP

(FILL)
@COLOR
M=-1
@FILLSCREEN
0;JMP

(EMPTY)
@COLOR
M=0
@FILLSCREEN
0;JMP

(FILLSCREEN)
@COLOR 
D=M 

@S
A=M  // get the address of the current pixel
M=D // color the current pixel

@S
D=M+1  // get location of next pixel

// checks if it is the last pixel
@KBD  
D=A-D // KBD - Pixel Location 

// handles next pixel
@S
M=M+1   // move to next pixel in case we have more pixels
A=M     // make the current address equal to the address of next pixel 

@FILLSCREEN   // are there more pixels? 
D; JGT 

@START 
0; JMP 



