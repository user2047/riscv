  .data
array:  .word 10, 13, 96, 35, 26, 38, 32, 6, 85, 22, 7, 52, 42, 95, 19, 72

.text
main:
    la t0, array
    li t1, 16
    li s3, 0
    li s5, 16

OuterLoop:
    li t2, 15    # t2 = size - 1
    li t3, 0           # Initialize swapped flag to 0

InnerLoop:
    beq t2, zero, EndOuterLoop  # If t2 == 0, end outer loop

    slli t4, t2, 2 
    add t4, t0, t4     # Calculate address of array[t2]
    lw t5, 0(t4)       # Load array[t2] into t5
    lw t6, -4(t4)      # Load array[t2-1] into t6

    ble t6, t5, noswap  # If array[t2-1] <= array[t2], no swap needed


    # Swap array[t2] and array[t2-1]
    sw t5, -4(t4)      # Store array[t2] into array[t2-1]
    sw t6, 0(t4)       # Store array[t2-1] into array[t2]
    li t3, 1           # Set swapped flag to 1

noswap:
    addi t2, t2, -1    # Decrement t2
    j InnerLoop       # Repeat inner loop

EndOuterLoop:
    beq t3, zero, end  # If no elements were swapped, array is sorted
    addi t1, t1, -1    # Decrement size
    bnez t1, OuterLoop

end:


#     # End of program
li s3, 0
print_loop:
    beq s3, s5, exit   # If index == size, exit loop
    slli t4, s3, 2     # t4 = t3 * 4 (word size)
    add t5, t0, t4     # Calculate address of array[t3]


    lw a1, 0(t5)       # Load array[t3] into a0
    li a0, 1
    ecall            # Make syscall

    li a0, 11

    li a1, ' '
    ecall
    addi s3, s3, 1     # Increment index
    j print_loop       # Repeat loop


exit:
    li a0, 11
    li a1, '\n'
    ecall
    li a0, 10          # Syscall for exit
    ecall              # Make syscall


  
   
 
# Index:
#     slli t2, a2, 2
#     add t2, t0, t2
#     lw t3, 0(t2)
#     jr ra