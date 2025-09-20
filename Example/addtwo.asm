.model small
.stack 100h
.data
    prompt1 db 'Enter first digit (0-9): $'
    prompt2 db 'Enter second digit (0-9): $'
    result_msg db 'Sum is: $'
    input1 db ?
    input2 db ?
    sum db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Prompt for first input
    lea dx, prompt1
    mov ah, 09h
    int 21h

    ; Read first character
    mov ah, 01h
    int 21h
    mov input1, al

    ; Prompt for second input
    lea dx, prompt2
    mov ah, 09h
    int 21h

    ; Read second character
    mov ah, 01h
    int 21h
    mov input2, al

    ; Convert input1 from ASCII to number
    mov al, input1
    sub al, '0'    ; convert ASCII digit to number
    mov bl, al     ; store in bl

    ; Convert input2 from ASCII to number
    mov al, input2
    sub al, '0'    ; convert ASCII digit to number

    ; Add numbers
    add al, bl
    mov sum, al    ; store sum

    ; Convert sum back to ASCII
    add al, '0'

    ; Print result message
    lea dx, result_msg
    mov ah, 09h
    int 21h

    ; Print sum character
    mov dl, al
    mov ah, 02h
    int 21h

    ; Print newline
    mov dl, 0Dh
    mov ah, 02h
    int 21h
    mov dl, 0Ah
    mov ah, 02h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
main endp
end main

