.text
 li t0, 2         # Assume value is 2
    la t1, jump_table # Load address of jump table

    slli t0, t0, 2   # Multiply value by 4 (size of each address)
    add t0, t0, t1   # Add base address of jump table
    lw t0, 0(t0)     # Load address from jump table
    jr t0            # Jump to the address

case_0:
    # Code for case 0
    j end

case_1:
    # Code for case 1
    j end

case_2:
    # Code for case 2
    j end

default_case:
    # Code for default case

end:
    # End of switch statement

    .data
jump_table:
    .word case_0
    .word case_1
    .word case_2
    .word default_case