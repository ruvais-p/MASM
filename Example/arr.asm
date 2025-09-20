.model small
.stack 100h

.data
    arr db 9,20,30,40,50,60,70,80,90,100
    msgEven db 'Even numbers in array:', 13,10, '$'
    msgFinal db 'Final updated array:', 13,10, '$'
    newline db 13,10, '$' ; Newline string for easier printing

.code
start:
    mov ax, @data
    mov ds, ax

    ; --- a) Indirect addressing mode ---
    ; Increment each array element by 1 using SI
    lea si, arr     ; SI points to the start of the array
    mov cx, 10      ; Loop 10 times for 10 elements
IncLoop:
    mov al, [si]    ; Get array element at [SI]
    inc al          ; Increment it
    mov [si], al    ; Store it back
    inc si          ; Move to the next element
    loop IncLoop

    ; --- b) Indexed addressing mode ---
    ; Display even numbers from the incremented array
    lea dx, msgEven ; Load offset of message for even numbers
    mov ah, 09h     ; DOS function to display string
    int 21h         ; Call DOS

    mov si, 0       ; SI as index, starting from 0
    mov cx, 10      ; Loop 10 times
EvenLoop:
    mov al, arr[si] ; Get array element using indexed addressing (base address + index)
    test al, 1      ; Test if the least significant bit is set (odd number)
    jnz SkipEven    ; If odd, skip printing

    ; If even, print the number
    ; AL already holds the number, PrintNumber expects input in AL
    call PrintNumber
    
SkipEven:
    inc si          ; Move to the next index
    loop EvenLoop

    ; Print a newline after even numbers
    lea dx, newline
    mov ah, 09h
    int 21h

    ; --- c) Base + Indexed addressing mode ---
    ; Reverse array using BX + SI and BX + DI
    ; Array after increment: 11,21,31,41,51,61,71,81,91,101
    lea bx, arr     ; BX as base register for the array
    mov cx, 5       ; Only need to swap half the array (10/2 = 5 pairs)
    mov si, 0       ; SI as index for the front of the array

ReverseLoop:
    ; Calculate DI for the element at the end
    ; For 10 elements (0-9), if SI is 0, DI is 9. If SI is 1, DI is 8, etc.
    mov di, 9       
    sub di, si      

    ; Swap elements using base + index addressing
    mov al, [bx + si] ; Get element from front (e.g., arr[0], arr[1], ...)
    mov dl, [bx + di] ; Get element from back (e.g., arr[9], arr[8], ...)

    mov [bx + si], dl ; Put back element to front position
    mov [bx + di], al ; Put front element to back position

    inc si          ; Move SI to the next element from the front
    loop ReverseLoop

    ; --- Display final updated array ---
    lea dx, msgFinal ; Load offset of final array message
    mov ah, 09h      ; DOS function to display string
    int 21h          ; Call DOS

    mov cx, 10       ; Loop 10 times for all elements
    lea si, arr      ; SI points to the start of the array again
PrintFinalLoop:
    mov al, [si]     ; Get array element
    ; AL already holds the number, PrintNumber expects input in AL
    call PrintNumber 
    inc si           ; Move to the next element
    loop PrintFinalLoop

    ; Print a newline after the final array
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Exit program
    mov ah, 4Ch      ; DOS function to terminate program
    int 21h          ; Call DOS

; ----------------------------------------
; PrintNumber procedure:
; Input: AL = number (0-255)
; Prints decimal number followed by a space
PrintNumber proc
    push ax          ; Save AX
    push bx          ; Save BX
    push cx          ; Save CX
    push dx          ; Save DX

    mov ah, 0        ; Clear AH to prepare AX for division
    ; AL already contains the number to be printed

    cmp al, 0        ; Check if the number is zero
    jne store_digits_loop ; If not zero, proceed to convert

    ; If zero, print '0' directly
    mov dl, '0'
    mov ah, 02h      ; DOS function to display character
    int 21h
    jmp print_space  ; Jump to print space and exit

store_digits_loop:
    mov bx, 10       ; Divisor for decimal conversion
    mov cx, 0        ; Initialize digit count to 0

continue_store:
    xor dx, dx       ; Clear DX for DIV (AX / BX, quotient in AL, remainder in DL)
    div bx           ; AX / 10 -> Quotient in AL, Remainder in DL
    push dx          ; Push remainder (digit) onto stack
    inc cx           ; Increment digit count
    cmp al, 0        ; Check if quotient is zero
    jne continue_store ; If not zero, continue extracting digits

print_digits_loop:
    pop dx           ; Pop digit from stack
    add dl, '0'      ; Convert digit to its ASCII character
    mov ah, 02h      ; DOS function to display character
    int 21h
    loop print_digits_loop ; Decrement CX and loop if CX is not zero

print_space:
    mov dl, ' '      ; Load ASCII for space
    mov ah, 02h      ; DOS function to display character
    int 21h

    pop dx           ; Restore DX
    pop cx           ; Restore CX
    pop bx           ; Restore BX
    pop ax           ; Restore AX
    ret              ; Return from procedure
PrintNumber endp

end start  
