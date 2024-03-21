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
    // File name: projects/07/MemoryAccess/TempTest/TempTest.vm
    // Executes pop & push commands using the temp segment.
    // push constant 42
@42
D=A
@SP
A=M
M=D
@SP
M=M+1
    // push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1
    // pop temp 0
@SP
M=M-1
A=M
D=M
@R5
M=D
    // pop temp 6
@SP
M=M-1
A=M
D=M
@R11
M=D
    // push temp 0
@R5
D=M
@SP
A=M
M=D
@SP
M=M+1
    // push temp 6
@R11
D=M
@SP
A=M
M=D
@SP
M=M+1
    // Infinite loop
(label1)
@label1
0;JMP
