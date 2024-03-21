    // Init
@256
D=A
@SP
M=D
    // This file is part of www.nand2tetris.org
    // and the book "The Elements of Computing Systems"
    // by Nisan and Schocken, MIT Press.
    // File name: projects/07/MemoryAccess/StaticTest/StaticTest.vm
    // Executes pop and push commands using the static segment.
    // push constant 111
@111
D=A
@SP
A=M
M=D
@SP
M=M+1
    // push constant 333
@333
D=A
@SP
A=M
M=D
@SP
M=M+1
    // push constant 888
@888
D=A
@SP
A=M
M=D
@SP
M=M+1
    // pop static 8
@SP
M=M-1
A=M
D=M
@R13
M=D
@R16
D=M
@8
A=D+A
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
    // pop static 3
@SP
M=M-1
A=M
D=M
@R13
M=D
@R16
D=M
@3
A=D+A
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
    // pop static 1
@SP
M=M-1
A=M
D=M
@R13
M=D
@R16
D=M
@1
A=D+A
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
    // push static 3
@R16
D=M
@3
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
    // push static 1
@R16
D=M
@1
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
    // sub
@SP
M=M-1
A=M
D=M
@temp
M=D
@SP
M=M-1
A=M
D=M
@temp
D=D-M
@SP
A=M
M=D
@SP
M=M+1
    // push static 8
@R16
D=M
@8
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
    // add
@SP
M=M-1
A=M
D=M
@temp
M=D
@SP
M=M-1
A=M
D=M
@temp
D=D+M
@SP
A=M
M=D
@SP
M=M+1
    // Infinite loop
(label1)
@label1
0;JMP
