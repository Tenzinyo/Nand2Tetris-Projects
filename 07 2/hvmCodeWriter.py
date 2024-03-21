"""
hvmCodeWriter.py -- Emits assembly language code for the Hack VM translator.
Skeletonized by Janet Davis March 2016
Refactored by John Stratton April 2017
Refactored by Janet Davis March 2019
Acknowledgement: Senior Ahmed helped me with the debugging
"""

import os
from hvmCommands import *

# If debug is True, 
# then the VM commands will be written as comments into the output ASM file.
debug = True

class CodeWriter(object):
    
    def __init__(self, outputName):
        """
        Opens 'outputName' and gets ready to write it.
        """
        self.file = open(outputName, 'w')
        self.fileName = self.setFileName(outputName)

        # used to generate unique labels
        self.labelNumber = 0
        self.functionName = ""


    def close(self):
        """
        Writes the terminal loop and closes the output file.
        """
        label = self._uniqueLabel()
        # self._writeComment("Infinite loop")
        self._writeCode('(%s), @%s, 0;JMP' % (label, label))
        self.file.close()


    def setFileName(self, fileName):
        """
        Sets the current file name to 'fileName'.
        Restarts the local label counter.

        Strips the path and extension.  The resulting name must be a
        legal Hack Assembler identifier.
        """
        self.fileName = os.path.basename(fileName)
        self.fileName = os.path.splitext(self.fileName)[0]

    def _uniqueLabel(self):
        self.labelNumber += 1
        return "label" + str(self.labelNumber)

    def write(self, text):
        """ 
        Write directly to the file.
        """
        self.file.write(text)

    def _writeCode(self, code):
        """
        Writes Hack assembly code to the output file.
        code should be a string containing ASM commands separated by commas,
        e.g., "@10, D=D+A, @0, M=D"
        """
        code = code.replace(',', '\n').replace(' ', '')
        self.file.write(code + '\n')

    def _writeComment(self, comment):
        """
        Writes a comment to the output ASM file.
        """
        if (debug):
            self.file.write('    // %s\n' % comment)

    def _pushD(self):
        """
        Writes Hack assembly code to push the value from the D register 
        onto the stack.
        TODO - Stage I - see Figure 7.2
        """
        self._writeCode('@SP, A=M, M=D')
        self._writeCode("@SP, M=M+1")

    def _popD(self):
        """"
        Writes Hack assembly code to pop a value from the stack 
        into the D register.
        TODO - Stage I - see Figure 7.2
        """
        self._writeCode('@SP, AM=M-1')
        self._writeCode("D=M")

    def writeArithmetic(self, command):
        """
        Writes Hack assembly code for the given command.
        TODO - Stage I - see Figure 7.5
        """
        self._writeComment(command)

        if command == T_ADD:
            self._popD()
            self._writeCode('@R13, M=D')
            self._popD()
            self._writeCode('@R13, D=D+M') 
            self._pushD()

        elif command == T_SUB:
            self._popD()  
            self._writeCode('@R13, M=D')
            self._popD()
            self._writeCode('@R13, D=D-M') 
            self._pushD()

        elif command == T_NEG:

            self._popD()
            self._writeCode('D=-D')
            self._pushD()

        elif command == T_EQ:
            firstLabel = self._uniqueLabel() 
            endLabel = self._uniqueLabel()
            self._popD()
            self._writeCode(f'@R13, M=D')
            self._popD()
            self._writeCode(f"@R13, D=M-D")

            self._writeCode(f"@{firstLabel}")
            self._writeCode("D; JNE")

            self._writeCode("@1, D=-A")
            self._pushD() 

            self._writeCode(f"@{endLabel}, 0; JMP")

            self._writeCode(f"({firstLabel}), @0, D=A")
            self._pushD()
           

            self._writeCode(f"({endLabel})")

        elif command == T_GT:
            firstLabel = self._uniqueLabel() 
            endLabel = self._uniqueLabel()
            self._popD()  
            self._writeCode(f'@R13, M=D') 
            self._popD()  
            self._writeCode(f"@R13, D=D-M") 

            self._writeCode(f"@{firstLabel}")
            self._writeCode("D; JLE")

            self._writeCode("@1, D=-A")
            self._pushD() 

            self._writeCode(f"@{endLabel}, 0; JMP")

            self._writeCode(f"({firstLabel}), @0, D=A")
            self._pushD()
        
            self._writeCode(f"({endLabel})")

            

        elif command == T_LT:
            firstLabel = self._uniqueLabel() 
            endLabel = self._uniqueLabel()
            self._popD()
            self._writeCode(f'@R13, M=D')
            self._popD()
            self._writeCode(f"@R13, D=D-M")

            self._writeCode(f"@{firstLabel}")
            self._writeCode("D; JGE")

            self._writeCode("@1, D=-A")
            self._pushD() 

            self._writeCode(f"@{endLabel}, 0; JMP")

            self._writeCode(f"({firstLabel}), @0, D=A")
            self._pushD()
           

            self._writeCode(f"({endLabel})")
            

        elif command == T_AND:

            self._popD()
            self._writeCode('@R13, M=D')
            self._popD()
            self._writeCode('@R13, D=D&M') 
            self._pushD()


        elif command == T_OR:

            self._popD()
            self._writeCode('@R13, M=D')
            self._popD()
            self._writeCode('@R13, D=D|M') 
            self._pushD()

        

        elif command == T_NOT:

            self._popD()
            self._writeCode("D=!D")
            self._pushD()

    

        else:
            raise(ValueError, 'Bad arithmetic command')
        
    def writePushPop(self, commandType, segment, index):
        """
        Write Hack code for 'commandType' (C_PUSH or C_POP).
        'segment' (string) is the segment name.
        'index' (int) is the offset in the segment.
        e.g., for the VM instruction "push constant 5",
        segment has the value "constant" and index has the value 5.
        TODO - Stage I - push constant only
        TODO - Stage II - See Figure 7.6 and pp. 142-3
        """
    
        if commandType == C_PUSH:
            self._writeComment("push %s %d" % (segment, index))

            if segment == T_CONSTANT: 
                self._writeCode('@' + str(index) + ', D=A') 
                self._pushD()

            elif segment == T_STATIC:

                self._writeCode(f"@{self.fileName}.{index}, D=M")
                self._pushD()

            elif segment == T_POINTER:
                self._writeCode(f'@R{3+index}, D=M')
                self._pushD()

            elif segment == T_TEMP:
                self._writeCode(f'@R{5+index}, D=M')
                self._pushD()


            else: # argument, local, this, that
                Rindex = 0
                if segment == T_LOCAL:
                    Rindex = 1
                elif segment == T_ARGUMENT:
                    Rindex = 2
                elif segment == T_THIS:
                    Rindex = 3
                elif segment == T_THAT:
                    Rindex = 4


                self._writeCode(f"@R{Rindex}, D=M") 
                self._writeCode(f"@{index}, A=D+A, D=M") 
                self._pushD()

        elif commandType == C_POP:
            self._writeComment("pop %s %d" % (segment, index))
            

            if segment == T_STATIC:
                self._writeCode(f"@{self.fileName}.{index}")
                self._writeCode("D=A, @R13, M=D")
                self._popD()
                self._writeCode("@R13, A=M, M=D") 


            elif segment == T_POINTER:
            
                self._popD()
                self._writeCode(f'@R{3+index}, M=D')  
            
                
            elif segment == T_TEMP:
                self._popD()
                self._writeCode(f'@R{5+index}, M=D')  
                
                
            else: # argument, local, this, that
                Rindex = 0
                if segment == T_LOCAL:
                    Rindex = 1
                elif segment == T_ARGUMENT:
                    Rindex = 2
                elif segment == T_THIS:
                    Rindex = 3
                elif segment == T_THAT:
                    Rindex = 4

                segment = f"R{Rindex}"
                self._popD()
                self._writeCode('@R13, M=D') 

                self._writeCode(f"@{Rindex}, D=M") 
                self._writeCode(f"@{index}, A=D+A, D=A")

                self._writeCode("@R14, M=D") 
                self._writeCode("@R13, D = M") 
                self._writeCode("@R14, A=M, M=D") 



        else:
            raise(ValueError, 'Bad push/pop command')


# Functions below this comment are for Project 08. Ignore for Project 07.
    def writeInit(self):
        """
        Writes assembly code that effects the VM initialization,
        also called bootstrap code. This code must be placed
        at the beginning of the output file.
        See p. 165, "Bootstrap Code"
        """
        # self._writeComment("Init")
        self._writeCode('@256, D=A, @SP, M=D')
        self.writeCall('Sys.init', 0)

    def writeLabel(self, label):
        """ 
        Writes assembly code that effects the label command.
        See section 8.2.1 and Figure 8.6.
        """

        

        # self._writeComment("label %s" % (label))
        new_label = f'{self.functionName}_{label}'
        # self._popD() # get condition
        self._writeCode(f"({new_label})")

    def writeGoto(self, label):
        """
        Writes assembly code that effects the goto command.
        See section 8.2.1 and Figure 8.6.
        """
        
        # self._writeComment("goto %s" % (label))
        new_label = f'{self.functionName}_{label}'
        self._writeCode(f"@{new_label}, 0; JMP")

    def writeIf(self,label):
        """
        Writes assembly code that effects the if-goto command.
        See section 8.2.1 and Figure 8.6.
        """
        

        # self._writeComment("if-goto %s" % (label))
        new_label = f'{self.functionName}_{label}'
        self._popD() # get condition
        self._writeCode(f"@{new_label}, D; JNE")

    def writeCall(self, functionName, numArgs):
        """
        Writes assembly code that effects the call command.
        See Figures 8.5 and 8.6.
        """

        # self._writeComment("call %s %d" % (functionName, numArgs))
        return_address = self._uniqueLabel()
        # push return address 
        self._writeCode(f"@{return_address}")
        self._writeCode('D=A')
        self._pushD()

        # push LCL 
        self._writeCode("@LCL, D=M")
        self._pushD()
        # push ARG 
        self._writeCode("@ARG, D=M")
        self._pushD()
        # push THIS 
        self._writeCode("@THIS, D=M")
        self._pushD()
        # push THAT 
        self._writeCode("@THAT, D=M")
        self._pushD()

        #ARG= SP-N-5
        self._writeCode("@SP, D=M") # SP
        self._writeCode(f'@{numArgs}, D=D-A, @5, D=D-A, @ARG, M=D')


        # LCL = SP 
        self._writeCode('@SP, D=M, @LCL, M=D')
        
        # goto f 
        self._writeCode(f"@{functionName}, 0; JMP")

        self._writeCode(f"({return_address})")

    def writeReturn(self):
        """
        Writes assembly code that effects the return command.
        See Figure 8.5.
        """
        # self._writeComment("return")
        # return_address = self._uniqueLabel()

        self._writeCode('@LCL, D=M, @FRAME, M=D')  # LCL = R15  
        self._writeCode('@FRAME, D=M, @5, A=D-A') # computed (R15 - 5)
        self._writeCode("D=M") # get what the (R15-5) points to
        self._writeCode(f"@RET, M=D") # RET = *(R15 - 5)

        # *ARG = pop()

        self._popD()

        self._writeCode('@ARG, A=M, M=D')
        self._writeCode('@ARG, D=M+1, @SP, M=D')

        #THAT

        self._writeCode('@FRAME, D=M, D=D-1')
        self._writeCode('A=D, D=M')
        self._writeCode('@THAT, M=D')

        #THIS
        self._writeCode('@FRAME, D=M, @2, D=D-A')
        self._writeCode('A=D, D=M')
        self._writeCode('@THIS, M=D')
        #ARG
        self._writeCode('@FRAME, D=M, @3, D=D-A')
        self._writeCode('A=D, D=M')
        self._writeCode('@ARG, M=D')
        #LCL
        self._writeCode('@FRAME, D=M, @4, D=D-A')
        self._writeCode('A=D, D=M')
        self._writeCode('@LCL, M=D')

        self._writeCode(f"@RET, A=M, 0; JMP")

    def writeFunction(self, functionName, numLocals):
        """
        Writes assembly code that effects the call command.
        See Figures 8.5 and 8.6.
        """
        # self._writeComment("function %s %d" % (functionName, numLocals))
        self.functionName = functionName # For local labels

        self._writeCode(f'({self.functionName})') 
        for _ in range(numLocals):
            self._writeCode("D=0")
            self._pushD()




