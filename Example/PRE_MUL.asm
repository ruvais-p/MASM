.model small
.stack 100h
.data
    val1 dw 5
    val2 dw 4
    result dw ?

    msg1 db 'First number: $'
    msg2 db 'Second number: $'
    message db 'The result is $'

    buffer db 7 dup(0) ; buffer for number string + '$'

.code

; Subroutine to print a number in AX (unsigned)
PrintNumber proc
    push ax
    push bx
    push cx
    push dx
    push si

    mov cx, 0
    mov bx, 10
    mov dx, 0

    lea si, buffer + 5
    mov byte ptr [si], '$'
    dec si

    cmp ax, 0
    jne conv_loop
    mov byte ptr [si], '0'
    dec si
    inc cx
    jmp print_str

conv_loop:
    xor dx, dx
    div bx
    add dl, '0'
    mov [si], dl
    dec si
    inc cx
    cmp ax, 0
    jne conv_loop

print_str:
    inc si
    mov ah, 09h
    mov dx, si
    int 21h

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
PrintNumber endp

; Print newline subroutine
PrintNewLine proc
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
    ret
PrintNewLine endp

main proc
    mov ax, @data
    mov ds, ax

    ; Print first number label and number
    mov ah, 09h
    lea dx, msg1
    int 21h

    mov ax, val1
    call PrintNumber
    call PrintNewLine

    ; Print second number label and number
    mov ah, 09h
    lea dx, msg2
    int 21h

    mov ax, val2
    call PrintNumber
    call PrintNewLine

    ; Multiply val1 * val2
    mov ax, val1
    mov bx, val2
    mul bx           ; unsigned multiplication, result in DX:AX

    mov result, ax   ; store lower 16 bits of result

    ; Print message "The result is "
    mov ah, 09h
    lea dx, message
    int 21h

    ; Print result
    mov ax, result
    call PrintNumber
    call PrintNewLine

    ; terminate
    mov ah, 4Ch
    int 21h
main endp
end main

