// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

@R2
M=0

@i 
M=0 // i=0 
(LOOP)

@i
D=M 

@R1
D=M-D // (R1-i)
@END
D;JLE // less than 0 or if (i-R1) end
@R0
D=M //D=R0
@R2
M=M+D //R2=R2+D

@i
M=M+1

@loop
0;JMP

@END
0;JMP
