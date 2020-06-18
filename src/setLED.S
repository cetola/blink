.section .text
.align 2
.global setLED

.include "memory_map.inc"
.include "gpio.inc"

.equ NOERROR, 0x0
.equ ERROR, 0x1
.equ LEDON, 0x1

// The LED is identified by the parameter a0
// Desired on/off state is passed in parameter a1

setLED:
    addi sp, sp, -16                // Allocate the stack frame
    sw ra, 12(sp)                   // Save the return address onto the stack

    li t0, GPIO_CTRL_ADDR           // Load the GPIO Control address
    lw t1, GPIO_OUTPUT_VALUE(t0)      // Get the current value of the pins

    beqz a1, ledOff                 // Branch to turn off LED if a1 requests it
    li t2, LEDON                    // Load the value 1 (on) into temp reg t2
    beq a1, t2, ledOn               // Branch to turn on LED if a1 requests it
    li a0, ERROR                    // Bad request, return erro
    j exit

ledOn:
    xor t1, t2, a0                  // Do an XOR so we only change the value of the request LED
    sw t1, GPIO_OUTPUT_VALUE(t0)      // Write the new value to the GPIO output
    li a0, NOERROR
    j exit

ledOff:
    xor a0, a0, 0xffffffff          // Invert everythign so that all bits are 1 except those we are turning off
    and t1, t1, a0                  // AND t1 and a0 to determine which LED to turn off
    sw t1, GPIO_OUTPUT_VALUE(t0)      // Write the new output value to the correct GPIO register
    li a0, NOERROR

exit:
    lw ra, 12(sp)                   // Restore the return address
    addi sp, sp, 16                 // Deallocate the stack frame
    ret
