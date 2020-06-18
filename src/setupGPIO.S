.section .text
.align 2
.global setupGPIO

.include "memory_map.inc"
.include "gpio.inc"

setupGPIO:
    addi sp, sp, -16                // Allocate the stack frame
    sw ra, 12(sp)                   // Save the return address onto the stack

    li t0, GPIO_CTRL_ADDR           // Load the base GPIO Address
    li t1, GPIO_RGB_PINS            // Load the RGB Pins offset
    sw t1, GPIO_OUTPUT_EN(t0)       // Enable output on the RGB pins so that they are writable
    sw t1, GPIO_OUTPUT_XOR(t0)      // Set the XOR so the RGB pins are active high
    sw x0, GPIO_OUTPUT_VALUE(t0)    // Set all the writable pins to 0 to clear the LEDs (off)

    lw ra, 12(sp)                   // Restore the return address
    addi sp, sp, 16                 // Deallocate the stack frame
    ret