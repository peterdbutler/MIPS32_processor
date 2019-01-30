        .data                                       # data segment
nl:     .asciiz "\n"                                # ASCII for new line
        .align  2                                   # aligned at word boundary
msg1:   .asciiz "\nThe Fibonacci Number F("         # part 1 of message
msg2:   .asciiz ") is: "                            # part 2 of message

        .text                   # code segment
        .globl  main            # declare main to be global
main:   # ----------------------   
        # $s0: F(n);    $s1: F(n-1);    $s2: F(n-2)
        # $s3: n        $s4: max iterations
        li      $s2, 0          # $s2 = 0; initial val of F(n-2)
        li      $s1, 1          # $s1 = 1; initial value of F(n-1)
        # ----------------------
        li      $s3, 0          # $s3 = 0 = n, nth iteration
        li      $s4, 10         # $s4 = 11, max iterations
                                # 11th iteration will not compute
loop:   # ----------------------     
        move    $s2, $s1        # $s2 = $s1; F(n-2) = previous F(n-1)  
        move    $s1, $s0        # $s1 = $s0; F(n-1) = previous F(n)  
        addu    $s0, $s1, $s2   # $s0 = $s1 + $s2; F(n) = F(n-1) + F(n-2)
        addiu   $s3, $s3, 1     # $s3 = $s3+1; increment $s3 ( $s3 = n )
        # ----------------------
        move    $a0, $s3        # $a0 = $s3 = n = 1
        move    $a1, $s0        # $a0 = $s0 = f(1)
        jal     print           # call 'print' procedure
        # ----------------------
        bne     $s3, $s4, loop  # if ( $s3 != $s4 ): branch to loop.
exit:   # ----------------------
        la      $a0, nl         # $a0 = address for ASCII value for newline 
        li      $v0, 4          # $v0  4, arg for syscall ( type = string )
        syscall                 # system call to print the value of 'ln' ( \n )
        # ----------------------
        li      $v0, 10         # system call, type 10: standard exit
        syscall                 # system call to exit program
        # ------- END OF PROGRAM ------ #
print:  # ----------------------
        addiu   $sp, $sp, -20   # adjust stack for 5 items
        sw      $s4, 16($sp)    # save max iterations
        sw      $s3, 12($sp)    # save n
        sw      $s2, 8($sp)     # save F(n-2)
        sw      $s1, 4($sp)     # save F(n-1)
        sw      $s0, 0($sp)     # save F(n)
        # ----------------------
        move    $t0, $a0        # $t0 = $a0 = n
        move    $t1, $a1        # $t1 = $a1 = F(n)
        # ----------------------
        la      $a0, msg1       # $a0 = address of msg1
                                # LA = Load Addrs.
        li      $v0, 4          # $v0  4, arg for syscall ( type = print string )
        syscall                 # print the value of $a0 ( msg1 )
        # ----------------------
        move    $a0, $t0        # $a0 = $t0 = n
        li      $v0, 1          # $v0 = 1, arg for syscall ( type = print int )
        syscall                 # system call to print the value of F(1)
        # ----------------------
        la      $a0, msg2       # $a0 = address of msg2
                                # LA = Load Addrs.
        li      $v0, 4          # $v0 = 4, arg for syscall ( type = print string )
        syscall                 # print the value of $a0 ( msg2 )
        # ----------------------
        move    $a0, $t1        # $a0 = $t0 = F(n) 
        li      $v0, 1          # $v0 = 1, arg for syscall ( type = int )
        syscall                 # print value of F(n)
        # ----------------------
        lw      $s0, 0($sp)     # restore F(n)
        lw      $s1, 4($sp)     # restore F(n-1)
        lw      $s2, 8($sp)     # restore F(n-2)
        lw      $s3, 12($sp)    # restore n
        lw      $s4, 16($sp)    # restore max iterations
        addiu   $sp, $sp, 20    # pop 5 (above) items from the stack
        jr      $ra             # return
