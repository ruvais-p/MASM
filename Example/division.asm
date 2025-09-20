.model small
.stack 100h

.data
    prompt1       db 'Enter first number: $'
    prompt2       db 'Enter second number: $'
    resultMessage db 'The result is: $'
    errorDivZero  db 'Error: Division by zero.$'

.code
main:
    mov ax, @data
    mov ds, ax


    mov ah, 09h
    lea dx, prompt1
    int 21h
    call print_newline


    mov ah, 01h
    int 21h
    sub al, 30h
    mov bl, al


    mov ah, 09h
    lea dx, prompt2
    int 21h
    call print_newline


    mov ah, 01h
    int 21h
    sub al, 30h
    mov bh, al

    cmp bh, 0
    je  div_zero_error


    mov al, bl
    xor ah, ah
    div bh


    mov ah, 09h
    lea dx, resultMessage
    int 21h


    add al, 30h
    mov dl, al
    mov ah, 02h
    int 21h

    call print_newline


    mov ah, 4Ch
    int 21h

div_zero_error:
    mov ah, 09h
    lea dx, errorDivZero
    int 21h
    call print_newline

    mov ah, 4Ch
    mov al, 1
    int 21h


print_newline proc
    mov dl, 0Dh
    mov ah, 02h
    int 21h
    mov dl, 0Ah
    mov ah, 02h
    int 21h
    ret
print_newline endp

end main
 
