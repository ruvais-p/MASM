.model small
.stack 100h
.data
    msg db 'Sum is: $'
    num1 db 4
    num2 db 3

.codeJK J .
.

main proc
    mov ax, @data
    mov ds, ax

    mov al, num1
    add al, num2
    
    lea dx, msg
    mov ah, 09h
    int 21h
    
    add al, '0'
    mov dl, al
    
    mov ah, 02h
    int 21h
    
    mov ah,4ch
    int 21h
main endp
end main

