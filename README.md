PROCESSOR
    VHDL implementation of a 32-bit MIPS Processor. The processor supports the
    following instructions:

        addu, addir, addiu, bne, beq, sw, lw, j

    and will run the MIPS binary file, fibonacci.bin. The file Processor_TB.vhdl
    will test the top module and demonstrate the processor's operation.
    

DIVISION CIRCUIT
    VHDL implementation of a simple division circuit. Also includes testbenching
    scripts in the folder 'testBenches'

    ALU.vhd             - ALU unit used to compute subtractions used in division
                          algorithm
    control.vhd         - state machine used to control operation of the ALU and
                          register
    divRegister.vhd     - dividend/quotient register for storing subtraction results
                          of ALU
    divControl.vhd      - top module used to call above three modules


MIPS FIBONACCI
    Two implementations of MIPS Assembly Code to generate the first 10 Fibonacci
    Numbers.

    fib10.asm           - Simply Generates fib numbers 1-10.
    fib10Arr.asm        - Generates and stores fib numbers 1-10 in an array.
    recursiveFib.asm    - given an input 'n', recursively generates the n-th
                          fibonacci number
