
.model small
.stack 100h
.data
msg1 db 'Disk Ready$'
msg2 db 'Disk Error$'
.code
main proc
    mov ax,@data
    mov ds,ax

    mov ah,00h
    int 13h
    jc error

    mov dx,offset msg1
    mov ah,09h
    int 21h
    jmp exit

error:
    mov dx,offset msg2
    mov ah,09h
    int 21h

exit:
    mov ah,4Ch
    int 21h
main endp
end main


