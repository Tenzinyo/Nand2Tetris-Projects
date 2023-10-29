// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/FillStatic.asm

// Blackens the screen, i.e. writes "black" in every pixel. 
// Key presses are ignored.
// This is an intermediate step added by Prof. Davis.

(START)
@SCREEN 
D=A
@S
M=D

@COLOR
M=-1
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

