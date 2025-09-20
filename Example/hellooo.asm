.model small
.stack 100h
.data
msg db 'Hello, 8086!$'
.code
main proc
    mov ax,@data
    mov ds,ax

    mov ah,00h
    mov al,03h
    int 10h

    mov ah,02h
    mov bh,00
    mov dh,12
    mov dl,35
    int 10h

    mov dx,offset msg
    mov ah,09h
    int 21h

    mov ah,4Ch
    int 21h
main endp
end main

