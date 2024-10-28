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
    li x10, 5  # Assuming the switch expression is 5

    # Calculate the index into the jump table
    li x11, 4  # Number of cases (adjust as needed)
    li s6, 1
    sub x10, x10, s6  # Adjust index to 0-based
    li s6, 4
    mul x10, x10, s6  # Multiply by 4 to get byte offset

    # Load the address from the jump table
    la x12, jump_table
    add x12, x12, x10

    # Jump to the address
    jr x12

# Case labels
case1:
    # Code for case 1
    li x10, 10
    j exit

case2:
    # Code for case 2
    li x10, 20
    j exit

case3:
    # Code for case 3
    li x10, 30
    j exit

default_case:
    # Default case
    li x10, -1
    j exit

exit:
    # Exit the program
    li a7, 10
    ecall