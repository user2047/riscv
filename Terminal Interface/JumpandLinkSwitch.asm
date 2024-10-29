.data
# .data section for the jump table
jump_table:
    .word case1
    .word case2
    .word case3
    .word default_case

# .text section for the code
.text
.globl main

main:
    # Load the switch expression into a register
    li x10, 2               #selecting the 2nd switch case
    addi x10, x10, -1       #fixing the offset
    slli x10, x10, 2        #multiply by 4 to get address of Jump table
    la x11 jump_table       #load jump table pointer in x11
    add x11, x11, x10       #offset x11 pointer by correct amount
    lw x11, 0(x11)          #load switch case into x11
    jr x11                  #jump to x11
  
case1:
    # Code for case 1

    li a1, 1     
    li a0, 1
    ecall
    jalr x0, 0(ra)


case2:
    # Code for case 2

    li a1, 2     
    li a0, 1           
    ecall

    jalr x0, 0(ra)

case3:
    # Code for case 3
    li a1, 3     
    li a0, 1           
    ecall     

    jalr x0, 0(ra)
default_case:
    # Default case
    li a1, -1     
    li a0, 1           
    ecall
    jalr x0, 0(ra)
 

    # Exit the program
    li a7, 10
    ecall