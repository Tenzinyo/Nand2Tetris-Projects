    // This file is part of www.nand2tetris.org
    // and the book "The Elements of Computing Systems"
    // by Nisan and Schocken, MIT Press.
    // File name: projects/08/FunctionCalls/FibonacciElement/Main.vm
    // Computes the n'th element of the Fibonacci series, recursively.
    // n is given in argument[0].  Called by the Sys.init function 
    // (part of the Sys.vm file), which also pushes the argument[0] 
    // parameter before this code starts running.
    // function Main.fibonacci 0
(Main.fibonacci)
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
    // push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
    // checks if n<2
    // lt
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
@label3
D;JLT
D=0
@SP
A=M
M=D
@SP
M=M+1
@label4
0;JMP
(label3)
D=-1
@SP
A=M
M=D
@SP
M=M+1
(label4)
    // if-goto IF_TRUE
@SP
M=M-1
A=M
D=M
@Main.fibonacci_IF_TRUE
D;JNE
    // goto IF_FALSE
@Main.fibonacci_IF_FALSE
0;JMP
    // if n<2, return n
    // label IF_TRUE
(Main.fibonacci_IF_TRUE)
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
    // return
@LCL
D=M
@R14
M=D
@R14
D=M
@5
A=D-A
D=M
@R15
M=D
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D
@ARG
D=M+1
@SP
M=D
@R14
D=M
D=D-1
A=D
D=M
@THAT
M=D
@R14
D=M
@2
D=D-A
A=D
D=M
@THIS
M=D
@R14
D=M
@3
D=D-A
A=D
D=M
@ARG
M=D
@R14
D=M
@4
D=D-A
A=D
D=M
@LCL
M=D
@R15
A=M
0;JMP
    // if n>=2, returns fib(n-2)+fib(n-1)
    // label IF_FALSE
(Main.fibonacci_IF_FALSE)
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
    // push constant 2
@2
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
    // computes fib(n-2)
    // call Main.fibonacci 1
@label8
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
@1
D=D-A
@5
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
@Main.fibonacci
0;JMP
(label8)
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
    // computes fib(n-1)
    // call Main.fibonacci 1
@label11
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
@1
D=D-A
@5
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
@Main.fibonacci
0;JMP
(label11)
    // returns fib(n-1) + fib(n-2)
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
    // return
@LCL
D=M
@R14
M=D
@R14
D=M
@5
A=D-A
D=M
@R15
M=D
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D
@ARG
D=M+1
@SP
M=D
@R14
D=M
D=D-1
A=D
D=M
@THAT
M=D
@R14
D=M
@2
D=D-A
A=D
D=M
@THIS
M=D
@R14
D=M
@3
D=D-A
A=D
D=M
@ARG
M=D
@R14
D=M
@4
D=D-A
A=D
D=M
@LCL
M=D
@R15
A=M
0;JMP
    // This file is part of www.nand2tetris.org
    // and the book "The Elements of Computing Systems"
    // by Nisan and Schocken, MIT Press.
    // File name: projects/08/FunctionCalls/FibonacciElement/Sys.vm
    // Pushes a constant, say n, onto the stack, and calls the Main.fibonacii
    // function, which computes the n'th element of the Fibonacci series.
    // Note that by convention, the Sys.init function is called "automatically" 
    // by the bootstrap code.
    // function Sys.init 0
(Sys.init)
    // push constant 4
@4
D=A
@SP
A=M
M=D
@SP
M=M+1
    // computes the 4'th fibonacci element
    // call Main.fibonacci 1
@label13
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
@1
D=D-A
@5
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
@Main.fibonacci
0;JMP
(label13)
    // label WHILE
(Sys.init_WHILE)
    // loops infinitely
    // goto WHILE
@Sys.init_WHILE
0;JMP
    // Infinite loop
(label14)
@label14
0;JMP
