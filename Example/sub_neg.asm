.model small
.stack 100h

.data
    msg1 db "Enter first number: $"
    msg2 db 13, 10, "Enter second number: $"
    msg3 db 13, 10, "Difference: $"

.code
main proc
    mov ax, @data
    mov ds, ax

    lea dx, msg1
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'
    mov bl, al

    lea dx, msg2
    mov ah, 09h
    int 21h


    mov ah, 01h
    int 21h
    sub al, '0'
    mov bh, al


    mov al, bl
    sub al, bh     


    lea dx, msg3
    mov ah, 09h
    int 21h

    js print_neg
    
    jmp print_digit
    
print_neg:

    neg al
    	
print_digit:
    add al, 30h      
    mov dl, al
    mov ah, 02h
    int 21h


    mov ah, 4Ch
    int 21h

main endp
end main

