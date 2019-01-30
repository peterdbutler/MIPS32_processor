# Peter_Butler_Lab_4.asm
# Peter Butler
# 23330068
        .data                               # data segment
nl:     .asciiz "\n"                        # ASCII for new line
        .align  2                           # aligned at word boundary
prompt: .asciiz "Please enter a Fibonacci index number (O will stop the program):"    # message prompt for input n
msg1:   .asciiz "F("                                  # part 1 of message
msg2:   .asciiz ")="                                    # part 2 of message
msg3:   .asciiz "The number is too large\n"             # msg if n is too big
bye:    .asciiz "bye."                                  # end of program message.
id:     .asciiz "CSC34300: Peter Butler 23330068\n"     # ID message

        .text               # code segment
        .globl  main        # declare main to be global
main:   # ----------------------   
        # Registers used in main:
        # $s0: n, input provided by user
        # $a0: argument reg for fib & syscall calls
        # $v0: ret val F(n) from fib   $v1: ret val F(n-1) from fib
        # $t0: F(n);    $t1: comparison flags
        la      $a0, id         # load address of ID into $a0
        li      $v0, 4          # $v0 = 4, arg for syscall ( type = print string )
        syscall                 # print the value of $a0 ( id )
getn:   # ----------------------
        la      $a0, prompt     # load address of prompt into $a0
        li      $v0, 4          # $v0 = 4, arg for syscall ( type = print string )
        syscall                 # print the value of $a0 ( prompt )
        # ----------------------
        li      $v0, 5          # $v0 = 5 arg for syscall ( type = read int )      
        syscall                 # read input from user
        move    $s0, $v0        # move value read ( n ) into $s0
        # ----------------------
        beq     $s0, $0, exit   # if ( n == 0 ), jump to exit ( $s0 == n )
        # ----------------------
        la      $a0, msg1       # load address of msg1 into $a0
        li      $v0, 4          # $v0 = 4, arg for syscall ( type = print string )
        syscall                 # print the value of $a0 ( msg1 )
        # ----------------------
        move    $a0, $s0        # $a0 = $s0 = n
        li      $v0, 1          # $v0 = 1, arg for syscall ( type = print int )
        syscall                 # print the value of $a0 ( $s0 = n )
        # ----------------------
        la      $a0, msg2       # load address of msg1 into $a0
        li      $v0, 4          # $v0 = 4, arg for syscall ( type = print string )
        syscall                 # print the value of $a0 ( msg1 )
        # ----------------------
        move    $a0, $s0        # $a0 = $s0 = n
        slti    $t1, $a0, 100   # $t1 = 1 if ($a0 < $t0) aka (n < 100) 
        beq     $0, $t1, big    # if $t1 == 0, jump to print1
        # ----------------------
        addiu   $sp, $sp, -4    # adjust stack for 1 item 
        sw      $s0, 0($sp)     # save $s0 before fib procedure call
        # ----------------------
        jal     fib             # jump to and execute fib program
        # ----------------------
        lw      $s0, 0($sp)     # restore $s0 after fib procedure call
        addiu   $sp, $sp, 4     # pop 1 item off stack
        # ----------------------
        move    $t0, $v0        # $t0 = $v0 F(n) 
        # ----------------------
        slt     $t1, $0, $v0    # $t1 = 1 if ($v0 < $0): checks if F(n) is negative
        beq     $0, $t1, big    # if $t1 == 0, jump to big
        # ----------------------
        move    $a0, $v0        # $a0 = $v0 = F(n), returned from fib
        li      $v0, 1          # $v0 = 1, arg for syscall ( type = print int )
        syscall                 # print the value of $a0 ( $s0 = n )
        # ----------------------
        la      $a0, nl         # $a0 = address for ASCII value for newline 
        li      $v0, 4          # $v0  4, arg for syscall ( type = string )
        syscall                 # system call to print the value of 'ln' ( \n )
        # ----------------------
        j       getn            # jump to input, get next n from user
big:    # ----------------------
        la      $a0, msg3       # load address of big into $a0
        li      $v0, 4          # $v0 = 4, arg for syscall ( type = print string )
        syscall                 # print the value of $a0 ( big )
        j       getn            # jump to input, get next n from user
exit:   # ----------------------
        la      $a0, bye        # load address bye of into $a0
        li      $v0, 4          # $v0 = 4, arg for syscall ( type = print string )
        syscall                 # print the value of $a0 ( bye )
        # ----------------------
        la      $a0, nl         # $a0 = address for ASCII value for newline 
        li      $v0, 4          # $v0  4, arg for syscall ( type = string )
        syscall                 # system call to print the value of 'ln' ( \n )
        # ----------------------
        li      $v0, 10         # system call, type 10: standard exit
        syscall                 # system call to exit program
        # ------- END OF PROGRAM ------ #

fib:    # ----------------------
        # Registers used by 'Fib' (recursive fibonacci formula):
        # $a0: n
        # $v0: return value F(n-1)    $v1: return value F(n-2)
        # $t0: used for imm. comparison     $t1: flag for immediate comparison
        # ----------------------    # first 'if' conditional check:
        addiu   $sp, $sp, -8    # adjust stack for 3 items
        sw      $ra, 4($sp)     # save return address
        sw      $a0, 0($sp)     # save callee argument ( n )
        # ----------------------    # second 'if' conditional check:
        move    $v0, $0         # $v0 = 0
        move    $v1, $0         # $v1 = 0
        beq     $a0, $0, fend   # if n == 0, jump to fend (return $v0 = 0, $v1 = 0)
        # ----------------------
        li      $v0, 1          # $v0 = 1 (Note: $v1 is still 0)
        beq     $a0, $v0, fend  # if n == 1, jump to fend (return $v0 = 0, $v1 = 1)
        # ----------------------
            # Recursion:
        # ----------------------
        addiu   $a0, $a0, -1    # decrement $a0 (n-1)
        jal     fib             # call fib on n-1
        # ----------------------
            # End Recursion:
        # ----------------------
        beq     $v0, -1, fend   # if $v0 == -1, jump to fend
        # ----------------------
        addu    $t0, $v0, $v1   # $t0 = $v0 + $v1 aka F(n) = F(n-1) + F(n-2)
        slt     $t1, $0, $t0    # if ( $v0 < $0 ) $t1 = 1 ($v0 is negative)
        beq     $t1, $0, oflow  # jump to oflow if $t1 == $t0 ( $v0 is > than $t0 )
        # ----------------------
        move    $v1, $v0        # $v1 = $v0 ( new F(n-2) = old F(n-1) )
        move    $v0, $t0        # $v0 = $t0 = ($v1 + $v0); new F(n)
        j       fend            # jump to fend, return $v0, $v1 ( F(n), F(n-1) )
oflow:  # ----------------------
        li      $v0, -1         # $v0 = -1 (indicates overflow AND num too large)
fend:   # ----------------------
        lw      $a0, 0($sp)     # restore caller argument
        lw      $ra, 4($sp)     # restore return address
        addiu   $sp, $sp, 8     # pop 2 (above) items from the stack
        jr      $ra             # return
        # ---- END OF fib FUNCTION ---- #
