.model small
.stack 100h
.data
    promptDivdnd db 'Enter two-digit dividend (10-99): $'
    promptDivsr  db 'Enter two-digit divisor (10-99): $'
    resQuot db 'Quotient = $'
    resRem  db 'Remainder = $'
    inputBuffer db 3 dup(0)
    dividend dw 0
    divisor  dw 0
    quotient dw 0
    remainder dw 0
    divZeroMsg db 'Error: Division by zero!$'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Prompt for dividend
    lea dx, promptDivdnd
    mov ah, 09h
    int 21h

    ; Read two digits for dividend
    mov cx, 2
    lea si, inputBuffer
read_dividend_digits:
    mov ah, 01h
    int 21h
    mov [si], al
    inc si
    loop read_dividend_digits

    ; Convert dividend ASCII to number
    mov al, inputBuffer
    sub al, '0'
    mov ah, 0
    mov bl, 10
    mul bl          ; AX = AL * 10
    mov bl, inputBuffer+1
    sub bl, '0'
    mov bh, 0
    add ax, bx      ; AX = (digit1 * 10) + digit2
    mov dividend, ax

    ; Prompt for divisor
    lea dx, promptDivsr
    mov ah, 09h
    int 21h

    ; Read two digits for divisor
    mov cx, 2
    lea si, inputBuffer
read_divisor_digits:
    mov ah, 01h
    int 21h
    mov [si], al
    inc si
    loop read_divisor_digits

    ; Convert divisor ASCII to number
    mov al, inputBuffer
    sub al, '0'
    mov ah, 0
    mov bl, 10
    mul bl
    mov bl, inputBuffer+1
    sub bl, '0'
    mov bh, 0
    add ax, bx
    mov divisor, ax

    ; Check for division by zero
    cmp divisor, 0
    jne perform_division

    ; If divisor == 0, print error and exit
    lea dx, divZeroMsg
    mov ah, 09h
    int 21h
    jmp exit_program

perform_division:
    mov ax, dividend
    xor dx, dx          ; Clear DX for division
    mov cx, divisor
    div cx              ; Divide DX:AX by CX; quotient in AX, remainder in DX

    mov quotient, ax
    mov remainder, dx

    ; Display quotient
    lea dx, resQuot
    mov ah, 09h
    int 21h

    mov ax, quotient
    call PrintNumber16

    ; New line
    mov dl, 0Dh
    mov ah, 02h
    int 21h
    mov dl, 0Ah
    mov ah, 02h
    int 21h

    ; Display remainder
    lea dx, resRem
    mov ah, 09h
    int 21h

    mov ax, remainder
    call PrintNumber16

    ; New line
    mov dl, 0Dh
    mov ah, 02h
    int 21h
    mov dl, 0Ah
    mov ah, 02h
    int 21h

exit_program:
    mov ah, 4Ch
    int 21h

;--------------------------------------------
; Subroutine: PrintNumber16
; Prints unsigned 16-bit number in AX as decimal digits
;--------------------------------------------
PrintNumber16 proc
    push ax
    push bx
    push cx
    push dx

    mov bx, 10
    mov cx, 0          ; digit count
    mov dx, 0

    cmp ax, 0
    jne PrintNumLoop
    ; if zero, print '0'
    mov dl, '0'
    mov ah, 02h
    int 21h
    jmp PrintNumDone

PrintNumLoop:
    mov dx, 0
    div bx             ; AX / 10; quotient in AX, remainder in DX
    push dx            ; remainder pushed to stack as digit
    inc cx
    cmp ax, 0
    jne PrintNumLoop

PrintNumPrint:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop PrintNumPrint

PrintNumDone:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
PrintNumber16 endp

main endp
end main

