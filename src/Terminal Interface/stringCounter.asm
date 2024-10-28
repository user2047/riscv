# Data Section
.data
count: .word   0
str:   .string "RISC-V is the bomb!!!"
userInput:  .string     "                           "


# Code Section
.text

###################################################
# Main entry point.
# The program starts here, at address 0x00000000
###################################################

main:
    # Initializations
    la   t0, count   # t0 points to count
    lw   t1, 0(t0)   # t1 implements count
    la   t2, str     # t2 points to *str

while:
    lb   t3, 0(t2)   # Load *str into t3
    beqz t3, finish  # If *str==0, go to finish
    addi t1, t1, 1   # count++;
    addi t2, t2, 1   # str++;
    j    while

finish:
    sw t1, 0(t0)     # Store t1 into count

    # print_int(count) - Environment call 1
    mv a1, t1
    li a0, 1
    ecall

    # print_char('\n') - Environment call 11
    li a1, '\n'
    li a0, 11
    ecall
    ecall


    la a2, userInput
    jal read_str

    # Exit - Environment call 10
    li a0, 10
    ecall









    read_str:
    # Initializations
    li a5, 1  # a5 holds comparison value for branching

    # Enable console input - Environment call 0x130
    li a0, 0x130 
    ecall

read_char:
    # Read a character from console input - Environment call 0x131
    li  a0, 0x131 
    ecall

    # Read the result of the environment call in a0
    beq a0, a5, read_char   # If still waiting for input, keep polling
    beq a0, zero, finish    # If buffer is empty, go to finish
    
    # Handle incoming character
    sb   a1, 0(a2)        # Append input character to name string 
    addi a2, a2, 1        # Increment the name string pointer

     # Check for enter key (newline character)
    li t0, 10          # ASCII code for newline
    beq a0, t0, finish # If newline, end input

    # Iterate to get the next character
    j read_char

finish:
    # Subroutine epilogue
    sb zero, 0(a2)  # Append null-terminator to name string
    jr ra           # Return to caller


 