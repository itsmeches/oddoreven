.model small
.stack 100h

.data
    msg1 db 10, 13, "Enter a 4-digit number: $"
    msg2 db 10, 13, "The number is even.$"
    msg3 db 10, 13, "The number is odd.$"

.code
main:
    mov ax, @data
    mov ds, ax

    ; Print message asking for input
    mov ah, 09h
    lea dx, msg1
    int 21h

    ; Read a 4-digit number
    mov cx, 4 ; counter for the loop
    xor bx, bx ; bx will hold the value of the number
input_loop:
    ; Read a single character
    mov ah, 01h
    int 21h

    ; Convert ASCII character to digit
    sub al, 30h

    ; Add the new digit to the number
    mov ah, 0
    mov dx, bx
    shl dx, 1 ; multiply by 2
    shl dx, 2 ; multiply by 4
    add bx, dx ; bx = bx * 10
    add bx, ax

    loop input_loop

    ; Calculate the sum of the digits
    mov ax, bx ; Move the number to ax
    xor cx, cx ; Clear cx for summing

sum_loop:
    mov dx, 0      ; Clear dx for division
    mov bx, 10     ; Set divisor to 10
    div bx         ; Divide ax by 10
    add cx, dx     ; Add the remainder to the sum

    test ax, ax   ; Check if there are more digits to sum
    jnz sum_loop

    ; Check if the sum is even or odd
    test cx, 1     ; Test the least significant bit
    jnz odd         ; Jump if it's odd

    ; If the LSB is 0, it's even
    mov ah, 09h
    lea dx, msg2
    int 21h
    jmp done

odd:
    ; If the LSB is 1, it's odd
    mov ah, 09h
    lea dx, msg3
    int 21h

done:
    mov ah, 4Ch    ; Exit program
    int 21h
end main
