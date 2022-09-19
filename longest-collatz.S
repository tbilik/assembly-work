    .data
max_starting_number:    .quad 0
max_length: .quad 0
upto:   .quad 1000000
curr:   .quad 1
output: .string "%ld\n" // output string for printf
    .text
    .global main

main:
    stp x29, x30, [sp, #-16]!
loop1:
    // load upto into register 1, load curr into register 0
    adr x1, upto
    ldr x1, [x1]
    adr x0, curr
    ldr x0, [x0]
    // compare upto and curr
    cmp x1, x0
    beq done1
    bl calculateLength
    // load curr again, load max_length and max_starting_number
    adr x2, curr
    ldr x0, [x2]
    adr x3, max_length
    ldr x4, [x3]
    adr x5, max_starting_number
    cmp x4, x1 // compare max length and current length
    bge endif
    // store new number if it has a larger sequence
    str x1, [x3]
    str x0, [x5]
endif:  
    // add one to curr, store it, and branch to loop again
    add x0, x0, #1
    str x0, [x2]
    bl loop1
done1:
    // print results
    adr x0, max_starting_number
    ldr x1, [x0]
    adr x0, output
    bl printf
    mov w0, #0
    ldp x29, x30, [sp], #16
    ret
    .size main,(. - main)


calculateLength:
    stp x29, x30, [sp, #-16]!
    mov x1, #0 // w1 counts the number of steps
    mov x4, #3
loop:
    cmp x0, #1 // is w0 1?
    beq done
    mul x2, x0, x4 // w2 = w0 * 3
    lsr x3, x0, #1 // w3 = w0 >> 1
    tst x0, #1
    csinc x0, x3, x2, eq // is w0 even? put in w3, else put w2 + 1
    add x1, x1, #1
    b loop
done:   
    ldp x29, x30, [sp], #16
    ret
    .size calculateLength,(. - calculateLength)
