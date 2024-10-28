  .data
array:  .word 10, 13, 96, 35, 26, 38, 32, 6, 85, 22, 7, 52, 42, 95, 19, 72

.text
main:
    la t0, array    #loads array into t1
    li t1, 16       #loads size of array into t1
    li s3, 0        #inits s3 to zero
    li s5, 16       #loads size of array into s5

OuterLoop:
    li t2, 15    # loads size of array -1 into t2
    li t3, 0           # inits swapped flag to 0

InnerLoop:
    beq t2, zero, EndOuterLoop  # If t2 == 0, end outer loop

    slli t4, t2, 2 
    add t4, t0, t4     # Calculate address of array[t2]
    lw t5, 0(t4)       # load array[t4] into t5
    lw t6, -4(t4)      # load array[t4-1] into t6

    ble t6, t5, noswap  # If array[t4] > array[t4], no swap needed


    # Swap array[t4] and array[t4-1]
    sw t5, -4(t4)      # Store array[t4] into array[t4-1]
    sw t6, 0(t4)       # Store array[t4-1] into array[t4]
    li t3, 1           # Set swapped flag to 1

noswap:
    addi t2, t2, -1    # decrement t2
    j InnerLoop       # Repeat inner loop

EndOuterLoop:
    beq t3, zero, end  # If no elements were swapped, array is sorted
    addi t1, t1, -1    # decrement size
    bnez t1, OuterLoop

end:


#                      # End of program
li s3, 0               #init s3 to zero
print_loop:
    beq s3, s5, exit   # If index == size, exit loop
    slli t4, s3, 2     # t4 = s3 * 4 (word size)
    add t5, t0, t4     # calculate address of array[t5]


    lw a1, 0(t5)        # Load array[t5] into a1
    li a0, 1            #change output type to integer
    ecall               # Make syscall

    li a0, 11           #change output to asciiz character

    li a1, ' '          #output space ' '
    ecall
    addi s3, s3, 1      # Increment index
    j print_loop        # jump tp loop



exit:
    li a0, 11           #change output to asciiz character
    li a1, '\n'         #output newline
    ecall
    li a0, 10           # syscall for exit
    ecall

  
   
 
# Index:
#     slli t2, a2, 2
#     add t2, t0, t2
#     lw t3, 0(t2)
#     jr ra