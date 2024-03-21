    // Init
    // This file is part of www.nand2tetris.org
    // and the book "The Elements of Computing Systems"
    // by Nisan and Schocken, MIT Press.
    // File name: projects/07/StackArithmetic/SimpleAdd/SimpleAdd.vm
    // Pushes and adds two constants.
    // push constant 7
@7
D=A
@SP
AM=M+1
M=D
@SP
M=M+1
    // push constant 8
@8
D=A
@SP
AM=M+1
M=D
@SP
M=M+1
    // add
@SP
AM=M-1
D=M
@SP
M=M-1
@tempAdd
M=D
@SP
AM=M-1
D=M
@SP
M=M-1
@tempAdd
D=D+M
@SP
AM=M+1
M=D
@SP
M=M+1
    // Infinite loop
(label1)
@label1
0;JMP
