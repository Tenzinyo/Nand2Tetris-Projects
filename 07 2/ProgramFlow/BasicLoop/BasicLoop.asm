    // This file is part of www.nand2tetris.org
    // and the book "The Elements of Computing Systems"
    // by Nisan and Schocken, MIT Press.
    // File name: projects/08/ProgramFlow/BasicLoop/BasicLoop.vm
    // Computes the sum 1 + 2 + ... + argument[0] and pushes the 
    // result onto the stack. Argument[0] is initialized by the test 
    // script before this code starts running.
    // push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
    // initializes sum = 0
    // pop local 0
@SP
M=M-1
A=M
D=M
@R13
M=D
@1
D=M
@0
A=D+A
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
    // label $LOOP_START
($LOOP_START)
    // push argument 0
@R2
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
    // push local 0
@R1
D=M
@0
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
    // sum = sum + counter
    // pop local 0
@SP
M=M-1
A=M
D=M
@R13
M=D
@1
D=M
@0
A=D+A
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
    // push argument 0
@R2
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
    // push constant 1
@1
D=A
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
    // counter--
    // pop argument 0
@SP
M=M-1
A=M
D=M
@R13
M=D
@2
D=M
@0
A=D+A
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
    // push argument 0
@R2
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
    // If counter != 0, goto LOOP_START
    // if-goto LOOP_START
@SP
M=M-1
A=M
D=M
@$LOOP_START
D;JNE
    // push local 0
@R1
D=M
@0
A=D+A
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
