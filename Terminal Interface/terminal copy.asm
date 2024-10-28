# Introduction to RISC-V
# Terminal Interface, by Eduardo Corpeño 

###################################################
# Description
#
# This code asks the user's name in the console 
# and responds with a message using that name.
###################################################

# Data Section
.data
prompt:       .string   "Hey, what's your name?\n" 
response:     .string   "\nIt's good to meet you, " 
name:         .space   30
agePrompt:    .string "How old are you?"
age:          .space 5
ageResponse1: .string "You are "
ageResponse2: .string " years old"


# Code Section
.text 

###################################################
# Main entry point.
# The program starts here, at address 0x00000000
###################################################

main:
    # Initializations
    # la t0, name  # t0 points to the name string

    # print_string(prompt) - Environment call 4
    la a1, prompt
    li a0, 4
    ecall

    # Call read_str subroutine
    la a2, name
    jal read_str

    # print_string(response) - Environment call 4
    la a1, response
    li a0, 4
    ecall
    
    # print_string(name) - Environment call 4
    la a1, name
    li a0, 4
    ecall
    
    # print_char(a0) - Environment call 11
    li a1, '!'
    li a0, 11
    ecall
    
    li a1, '\n'
    ecall
    ecall


    la a1, agePrompt
    li a0, 4
    ecall

    li a1, '\n'
    li a0, 11
    ecall

    la a2, age
    jal read_str

    li a1, '\n'
    li a0, 11
    ecall

    la a1, ageResponse1
    li a0, 4
    ecall

    la a1, age
    li a0, 4
    ecall

    la a1, ageResponse2
    li a0, 4
    ecall

    # Exit - Environment call 10
    li a1, '\n'
    li a0, 11
    ecall
    ecall

    li a0, 10
    ecall
    

###################################################
# read_str subroutine
# Read input string from the console.
# This input is a line of text terminated with
# the enter keystroke.
###################################################

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
