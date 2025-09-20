.MODEL SMALL
.STACK 100H

.DATA
    DIGIT1 DB 9               ; Predefined first digit
    DIGIT2 DB 5               ; Predefined second digit

    MSG1 DB 'First digit is: $'
    MSG2 DB 13, 10, 'Second digit is: $'
    MSG3 DB 13, 10, 'Sum is: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display first digit message
    LEA DX, MSG1
    MOV AH, 09h
    INT 21h

    ; Display first digit value
    MOV AL, DIGIT1
    ADD AL, '0'       ; Convert digit to ASCII
    MOV DL, AL
    MOV AH, 02h
    INT 21h

    ; Display second digit message
    LEA DX, MSG2
    MOV AH, 09h
    INT 21h

    ; Display second digit value
    MOV AL, DIGIT2
    ADD AL, '0'       ; Convert digit to ASCII
    MOV DL, AL
    MOV AH, 02h
    INT 21h

    ; Calculate sum
    MOV AL, DIGIT1
    MOV BL, DIGIT2
    ADD AL, BL        ; AL = sum of DIGIT1 and DIGIT2
    MOV CL, AL        ; Store sum in CL

    ; Display sum message
    LEA DX, MSG3
    MOV AH, 09h
    INT 21h

    CMP CL, 9         ; Check if sum is a single digit
    JLE PRINT_ONE_DIGIT

    ; sum > 9: print two digits
    MOV AL, CL        ; Move sum to AL for division
    MOV AH, 0         ; Clear AH for division (AX = sum)
    MOV BL, 10        ; Divisor is 10
    DIV BL            ; AL = quotient (tens digit), AH = remainder (ones digit)

    ; Print tens digit
    PUSH AX           ; Save AX (contains tens and ones digits)
    MOV DL, AL        ; AL has the tens digit
    ADD DL, '0'       ; Convert tens digit to ASCII
    MOV AH, 02h
    INT 21h           ; Print the tens digit
    POP AX            ; Restore AX (tens in AL, ones in AH)

    ; Print ones digit
    MOV DL, AH        ; AH has the ones digit (remainder)
    ADD DL, '0'       ; Convert ones digit to ASCII
    MOV AH, 02h
    INT 21h           ; Print the ones digit

    JMP DONE_PRINT

PRINT_ONE_DIGIT:
    ADD CL, '0'       ; Convert single digit sum to ASCII
    MOV DL, CL
    MOV AH, 02h
    INT 21h

DONE_PRINT:
    MOV AH, 4Ch       ; Terminate program
    INT 21h

MAIN ENDP
END MAIN

