    // Init
@256
D=A
@SP
M=D
    // call Sys.init 0
@.return-address
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP
D=M
@0
D=D-A
@5
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
@Sys.init
0;JMP
(.return-address)
    // This file is part of www.nand2tetris.org
    // and the book "The Elements of Computing Systems"
    // by Nisan and Schocken, MIT Press.
    // File name: projects/07/MemoryAccess/PointerTest/PointerTest.vm
    // Executes pop and push commands using the 
    // pointer, this, and that segments.
    // push constant 3030
@3030
D=A
@SP
A=M
M=D
@SP
M=M+1
    // pop pointer 0
@SP
M=M-1
A=M
D=M
@R3
M=D
    // push constant 3040
@3040
D=A
@SP
A=M
M=D
@SP
M=M+1
    // pop pointer 1
@SP
M=M-1
A=M
D=M
@R4
M=D
    // push constant 32
@32
D=A
@SP
A=M
M=D
@SP
M=M+1
    // pop this 2
@SP
M=M-1
A=M
D=M
@R13
M=D
@3
D=M
@2
A=D+A
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
    // push constant 46
@46
D=A
@SP
A=M
M=D
@SP
M=M+1
    // pop that 6
@SP
M=M-1
A=M
D=M
@R13
M=D
@4
D=M
@6
A=D+A
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
    // push pointer 0
@R3
D=M
@SP
A=M
M=D
@SP
M=M+1
    // push pointer 1
@R4
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
@R13
M=D
@SP
M=M-1
A=M
D=M
@R13
D=D+M
@SP
A=M
M=D
@SP
M=M+1
    // push this 2
@R3
D=M
@2
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
@R13
M=D
@SP
M=M-1
A=M
D=M
@R13
D=D-M
@SP
A=M
M=D
@SP
M=M+1
    // push that 6
@R4
D=M
@6
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
@R13
M=D
@SP
M=M-1
A=M
D=M
@R13
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
