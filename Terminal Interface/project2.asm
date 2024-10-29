# Example: if (x == y) then z = 1 else z = 2

    li t0, 1          # Load 1 into t0 (then part)
    li t1, 2          # Load 2 into t1 (else part)
    li t2, 3          # Dummy value for x
    li t3, 3          # Dummy value for y
    li t4, 0          # Initialize z

    beq t2, t3, THEN  # If x == y, jump to THEN label
    j ELSE            # If not, jump to ELSE label

THEN:
    mv t4, t0         # z = 1
    j END             # Jump to END

ELSE:
    mv t4, t1         # z = 2

END:

beqz t4, THEN2
j ELSE2

THEN2:
    mv t5, t0
    j END2
ELSE2:
    mv t5, t1

END2:




#Begin While Statement

li t0, 0           # Initialize count to 0
li t1, 10           # Set loop exit to 10

loop:
    bge t0, t1, end  # If count >= 10 jump to end 
    addi t0, t0, 1   # increment t0 by 1
    j loop           # Jump back to the loop flag

end: