        .data                               # data segment
nl:     .asciiz "\n"                        # ASCII for new line
        .align  2                           # aligned at word boundary
FBN:    .space 400                          # declare array FBN, 400 bytes
        .align 2                            # aligned at word boundary
NUM_FBN:    .space 4                        # largest fib # before overflow
            .align 2                        # aligned at word boundary
msg1:   .asciiz "\nThe Fibonacci Number F("             # part 1 of message
msg2:   .asciiz ") is: "                                # part 2 of message

        .text                   # code segment
        .globl  main            # declare main to be global
main:   # ----------------------   
        # Registers used in main:
        # $s0: Address of FBN;     $s1: Address of NUM_FBN    $s2: n
        # $t0: F(n);    $t1: F(n-1);    $t2: F(n-2);
        la      $s0, FBN        # load address of FBN into $s0
        li      $t2, 0          # $t2 = 0; initial val of F(n-2)
        li      $t1, 1          # load imm. 1 into $t1; initial value of F(n-1) 
        # ----------------------
        sw      $t1, 0($s0)     # store 1 at FBN[0]; pre-load first 2 FBNS
        sw      $t1, 4($s0)     # store 1 at FBN[1]; pre-load first 2 FBNs
        addiu   $s0, $s0, 4     # offset FBN ptr to most recent FBN
        # ----------------------
        li      $s2, 2          # $s2 = 1 = n, 2nd iteration
        la      $s1, NUM_FBN    # load address of NUM_FBM into $s1
        sw      $s2, 0($s1)     # set NUM_FBN = n
        # ---------------------- 
        move 	$t2, $t1        # move $t1 to $t2; move old F(n-1) => new F(n-2)
        lw	    $t1, 0($s0)     # move FBN to $t1; move old F(n) => new F(n-1)
        addiu	$s0, $s0, 4     # inc FBN index for next iteration
floop:  # ----------------------
        move    $a2, $t2        # move $t2 into $a2 ( F(n-2) )
        move    $a1, $t1        # move $t1 into $a1 ( F(n-1) )
        jal     step1           # procedure call 'step1': find & store fib nos.
        # ----------------------
        beq     $0, $v0, lp_brk #if ( $v0 == $0 ), jump to lp_brk
        # ----------------------
        move	$t2, $t1        # move $t1 to $t2; old F(n-1) => new F(n-2)
        lw      $t1, 0($s0)     # load $t1 w/ val at $s0; old F(n) => new F(n-1)
        addiu   $s0, $s0, 4     # $s0 += 4. Inc FBN to point to new largst Fib no.
        # ----------------------
        addiu   $s2, $s2, 1     # $s2++, n++ iteration
        sw      $s2, ($s1)      # store $t2 into $s1[0] (NUM_FBN++)
        # ----------------------
        j       floop           # jumps to loop, contining Fib iteration
lp_brk: # ----------------------
        jal     step2           # procedure call 'step2': print Fib values in FBN
exit:   # ----------------------
        la      $a0, nl         # $a0 = address for ASCII value for newline 
        li      $v0, 4          # $v0  4, arg for syscall ( type = string )
        syscall                 # system call to print the value of 'ln' ( \n )
        # ----------------------
        li      $v0, 10         # system call, type 10: standard exit
        syscall                 # system call to exit program
        # ------- END OF PROGRAM ------ #

step1:  # ----------------------
        # Registers used by 'step1' (fibonacci formula):
        # $a1: F(n-1);   $a2: F(n-2);
        # $t0: F(n);    $t1: F(n-1);    $t2: F(n-2);
        # $v0: return value (boolean): 0:Overflow  1:No overflow && F(n) is stored
        # ----------------------
        addiu   $sp, $sp, -12   # adjust stack for 3 items
        sw      $s2, 8($sp)     # save n
        sw      $s1, 4($sp)     # save addr. of NUM_FBN
        sw      $s0, 0($sp)     # save addr. of FBN
        # ----------------------
        li      $v0, 0          # rtrn val, 0 (bool) == ovrflo & F(n) out of bounds
                                # this will change if condition loop below does not
                                # branch, otherwise it remains 0
        # ----------------------
        move    $t1, $a1        # move $a1 into $t1 (F(n-1))
        move    $t2, $a2        # move $a2 into $t2 (F(n-2))
        addu    $t0, $t1, $t2   # $t0 = $t1 + $t2; F(n) = F(n-1) + F(n-2)
        # ----------------------
        slt     $t3, $t1, $t0   # if ($t0 < $t1), $t3 = 1; if (F(n) < F(n-1), $t3=1 
                                  # when ($t0 > $t1) then overflow && $t3 = 0
        beq     $t3, $0, break1 # jump to st1_ext if $t3 = $0 = 0 (== overflow)
        # ----------------------
        sw      $t0, 0($s0)     # insert F(n) into next position in FBR
        li      $v0, 1          # rtrn val, 1 (bool) == no ovrflo & a new F(n)
break1: # ---------------------
        lw      $s0, 0($sp)     # restore addr. of FBN
        lw      $s1, 4($sp)     # restore addr. of NUN_FBN
        lw      $s2, 8($sp)     # restore n
        addiu   $sp, $sp, 12    # pop 3 (above) items from the stack
        jr      $ra             # return
        # --- END OF step1 FUNCTION --- #

step2:  # ----------------------
        # Registers used by 'step2' (printing proceedure):
        # $t0: Addrs of FBN;    $t1: Addrs of NUM_FBN;
        # $t2: Val of NUM_FBN;  $t3: n;   
        # ----------------------
        addiu   $sp, $sp, -20   # adjust stack for 3 items
        sw      $s2, 8($sp)     # save n
        sw      $s1, 4($sp)     # save addr. of NUM_FBN
        sw      $s0, 0($sp)     # save addr. of FBN
        # ----------------------
        la      $t0, FBN        # load addr. of FBN[0] into $t0
        la      $t1, NUM_FBN    # load addr. of NUM_FBN into $t1 (max fib. no.)
        lw      $t2, 0($t1)     # load value pointed to by NUM_FBN into $t2
        addiu   $t3, $t3, 1     # move 1 into $t3 ( n = 1 )
ploop:  # ----------------------
        la      $a0, msg1       # $a0 = address of msg1
        li      $v0, 4          # $v0  4, arg for syscall ( type = print string )
        syscall                 # print the value of $a0 ( msg1 )
        # ----------------------
        move    $a0, $t3        # $a0 = $t3 = n
        li      $v0, 1          # $v0 = 1, arg for syscall ( type = print int )
        syscall                 # system call to print the value of F(1)
        # ----------------------
        la      $a0, msg2       # $a0 = address of msg2
        li      $v0, 4          # $v0 = 4, arg for syscall ( type = print string )
        syscall                 # print the value of $a0 ( msg2 )
        # ----------------------
        lw      $a0, 0($t0)     # $a0 = value stored at addrs in $t0[0] = F(n) 
        li      $v0, 1          # $v0 = 1, arg for syscall ( type = int )
        syscall                 # print value of F(n)
        # ----------------------
        beq     $t3, $t2, break2     # branch to break2 if equal ( n == NUM_FIB )
        # ----------------------
        addiu   $t3, $t3, 1     # $t3++ == n++
        addiu   $t0, $t0, 4     # increment offset address of $t0; F[n] => F[n+1]
        j       ploop           # jump to top of loop
break2: # ----------------------
        lw      $s0, 0($sp)     # restore addr. of FBN
        lw      $s1, 4($sp)     # restore addr. of NUN_FBN
        lw      $s2, 8($sp)     # restore n
        addiu   $sp, $sp, 12    # pop 3 (above) items from the stack
        jr      $ra             # return
        # --- END OF step2 FUNCTION --- #
