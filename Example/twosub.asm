.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter first number (00-99): $'
    MSG2 DB 13,10, 'Enter second number (00-99): $'
    MSG3 DB 13,10, 'Difference is: $'
    ERR  DB 13,10, 'Error: invalid input.$'
    MINUS_SIGN DB '-' , '$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Prompt for first number
    LEA DX, MSG1
    MOV AH, 09h
    INT 21h

    CALL ReadTwoDigit
    JC InvalidInput
    MOV BL, AL  ; Save first number in BL

    ; Prompt for second number
    LEA DX, MSG2
    MOV AH, 09h
    INT 21h

    CALL ReadTwoDigit
    JC InvalidInput
    MOV BH, AL  ; Save second number in BH

    ; Calculate Difference
    MOV AL, BL
    CMP AL, BH
    JAE PositiveResult

    ; Negative result
    MOV AL, BH
    SUB AL, BL

    LEA DX, MSG3
    MOV AH, 09h
    INT 21h

    LEA DX, MINUS_SIGN
    MOV AH, 09h
    INT 21h

    CALL PrintNumber
    JMP ExitProgram

PositiveResult:
    SUB AL, BH

    LEA DX, MSG3
    MOV AH, 09h
    INT 21h

    CALL PrintNumber
    JMP ExitProgram

InvalidInput:
    LEA DX, ERR
    MOV AH, 09h
    INT 21h

ExitProgram:
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
ReadTwoDigit PROC
    PUSH BX

    ; Read first digit
    MOV AH, 01h
    INT 21h
    SUB AL, '0'
    CMP AL, 9
    JA InvalidDigit
    MOV BH, AL

    ; Read second digit
    MOV AH, 01h
    INT 21h
    SUB AL, '0'
    CMP AL, 9
    JA InvalidDigit
    MOV BL, AL

    ; Convert to number: AL = BH*10 + BL
    MOV AL, BH
    MOV AH, 0
    MOV CX, 10
    MUL CL         ; AX = BH * 10
    ADD AL, BL     ; AL = BH*10 + BL
    CLC
    POP BX
    RET

InvalidDigit:
    STC
    POP BX
    RET
ReadTwoDigit ENDP

;--------------------------
; PrintNumber:
; Prints 8-bit unsigned number in AL
;--------------------------
PrintNumber PROC
    PUSH AX
    PUSH BX
    PUSH DX

    XOR AH, AH
    MOV BL, 10
    DIV BL        ; AL = quotient (tens), AH = remainder

    CMP AL, 0
    JE PrintUnits

    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02h
    INT 21h

PrintUnits:
    MOV AL, AH
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02h
    INT 21h

    POP DX
    POP BX
    POP AX
    RET
PrintNumber ENDP

END MAIN
