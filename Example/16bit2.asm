.MODEL SMALL
.STACK 100H

.DATA
    ; Menu messages
    menu_msg    DB 13,10,'===== 16-BIT ARITHMETIC CALCULATOR =====',13,10
                DB '1. Addition',13,10
                DB '2. Subtraction',13,10
                DB '3. Multiplication',13,10
                DB '4. Division',13,10
                DB '5. Exit',13,10
                DB 'Enter your choice (1-5): $'
    
    ; Input/Output messages
    num1_msg    DB 13,10,'Enter first number: $'
    num2_msg    DB 13,10,'Enter second number: $'
    result_msg  DB 13,10,'Result: $'
    quotient_msg DB 13,10,'Quotient: $'
    remainder_msg DB 13,10,'Remainder: $'
    error_msg   DB 13,10,'Error: Division by zero!$'
    invalid_msg DB 13,10,'Invalid choice! Please try again.$'
    continue_msg DB 13,10,'Press any key to continue...$'
    goodbye_msg DB 13,10,'Thank you for using the calculator!$'
    
    ; Variables
    num1        DW ?
    num2        DW ?
    result      DW ?
    choice      DB ?
    remainder   DW ?
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
MAIN_LOOP:
    ; Display menu
    CALL DISPLAY_MENU
    
    ; Get user choice
    CALL GET_CHOICE
    
    ; Process choice
    CMP choice, '1'
    JE DO_ADDITION
    CMP choice, '2'
    JE DO_SUBTRACTION
    CMP choice, '3'
    JE DO_MULTIPLICATION
    CMP choice, '4'
    JE DO_DIVISION
    CMP choice, '5'
    JE EXIT_PROGRAM
    
    ; Invalid choice
    LEA DX, invalid_msg
    MOV AH, 09H
    INT 21H
    JMP CONTINUE_PROMPT

DO_ADDITION:
    CALL GET_NUMBERS
    MOV AX, num1
    ADD AX, num2
    MOV result, AX
    CALL DISPLAY_RESULT
    JMP CONTINUE_PROMPT

DO_SUBTRACTION:
    CALL GET_NUMBERS
    MOV AX, num1
    SUB AX, num2
    MOV result, AX
    CALL DISPLAY_RESULT
    JMP CONTINUE_PROMPT

DO_MULTIPLICATION:
    CALL GET_NUMBERS
    MOV AX, num1
    MUL num2
    MOV result, AX
    CALL DISPLAY_RESULT
    JMP CONTINUE_PROMPT

DO_DIVISION:
    CALL GET_NUMBERS
    ; Check for division by zero
    CMP num2, 0
    JE DIVISION_ERROR
    
    MOV AX, num1
    XOR DX, DX       ; Clear DX for division
    DIV num2
    MOV result, AX   ; Quotient
    MOV remainder, DX ; Remainder
    
    ; Display quotient
    LEA DX, quotient_msg
    MOV AH, 09H
    INT 21H
    MOV AX, result
    CALL PRINT_NUMBER
    
    ; Display remainder
    LEA DX, remainder_msg
    MOV AH, 09H
    INT 21H
    MOV AX, remainder
    CALL PRINT_NUMBER
    JMP CONTINUE_PROMPT

DIVISION_ERROR:
    LEA DX, error_msg
    MOV AH, 09H
    INT 21H
    JMP CONTINUE_PROMPT

CONTINUE_PROMPT:
    LEA DX, continue_msg
    MOV AH, 09H
    INT 21H
    MOV AH, 01H     ; Wait for key press
    INT 21H
    JMP MAIN_LOOP

EXIT_PROGRAM:
    LEA DX, goodbye_msg
    MOV AH, 09H
    INT 21H
    MOV AH, 4CH
    INT 21H.MODEL SMALL
.STACK 100H

.DATA
    ; Menu messages
    menu_msg    DB 13,10,'===== 16-BIT ARITHMETIC CALCULATOR =====',13,10
                DB '1. Addition',13,10
                DB '2. Subtraction',13,10
                DB '3. Multiplication',13,10
                DB '4. Division',13,10
                DB '5. Exit',13,10
                DB 'Enter your choice (1-5): $'
    
    ; Input/Output messages
    num1_msg    DB 13,10,'Enter first number: $'
    num2_msg    DB 13,10,'Enter second number: $'
    result_msg  DB 13,10,'Result: $'
    quotient_msg DB 13,10,'Quotient: $'
    remainder_msg DB 13,10,'Remainder: $'
    error_msg   DB 13,10,'Error: Division by zero!$'
    invalid_msg DB 13,10,'Invalid choice! Please try again.$'
    continue_msg DB 13,10,'Press any key to continue...$'
    goodbye_msg DB 13,10,'Thank you for using the calculator!$'
    
    ; Variables
    num1        DW ?
    num2        DW ?
    result      DW ?
    choice      DB ?
    remainder   DW ?
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
MAIN_LOOP:
    ; Display menu
    CALL DISPLAY_MENU
    
    ; Get user choice
    CALL GET_CHOICE
    
    ; Process choice
    CMP choice, '1'
    JE DO_ADDITION
    CMP choice, '2'
    JE DO_SUBTRACTION
    CMP choice, '3'
    JE DO_MULTIPLICATION
    CMP choice, '4'
    JE DO_DIVISION
    CMP choice, '5'
    JE EXIT_PROGRAM
    
    ; Invalid choice
    LEA DX, invalid_msg
    MOV AH, 09H
    INT 21H
    JMP CONTINUE_PROMPT

DO_ADDITION:
    CALL GET_NUMBERS
    MOV AX, num1
    ADD AX, num2
    MOV result, AX
    CALL DISPLAY_RESULT
    JMP CONTINUE_PROMPT

DO_SUBTRACTION:
    CALL GET_NUMBERS
    MOV AX, num1
    SUB AX, num2
    MOV result, AX
    CALL DISPLAY_RESULT
    JMP CONTINUE_PROMPT

DO_MULTIPLICATION:
    CALL GET_NUMBERS
    MOV AX, num1
    MUL num2
    MOV result, AX
    CALL DISPLAY_RESULT
    JMP CONTINUE_PROMPT

DO_DIVISION:
    CALL GET_NUMBERS
    ; Check for division by zero
    CMP num2, 0
    JE DIVISION_ERROR
    
    MOV AX, num1
    XOR DX, DX       ; Clear DX for division
    DIV num2
    MOV result, AX   ; Quotient
    MOV remainder, DX ; Remainder
    
    ; Display quotient
    LEA DX, quotient_msg
    MOV AH, 09H
    INT 21H
    MOV AX, result
    CALL PRINT_NUMBER
    
    ; Display remainder
    LEA DX, remainder_msg
    MOV AH, 09H
    INT 21H
    MOV AX, remainder
    CALL PRINT_NUMBER
    JMP CONTINUE_PROMPT

DIVISION_ERROR:
    LEA DX, error_msg
    MOV AH, 09H
    INT 21H
    JMP CONTINUE_PROMPT

CONTINUE_PROMPT:
    LEA DX, continue_msg
    MOV AH, 09H
    INT 21H
    MOV AH, 01H     ; Wait for key press
    INT 21H
    JMP MAIN_LOOP

EXIT_PROGRAM:
    LEA DX, goodbye_msg
    MOV AH, 09H
    INT 21H
    MOV AH, 4CH
    INT 21H

MAIN ENDP

; Procedure to display menu
DISPLAY_MENU PROC
    ; Clear screen (optional)
    MOV AH, 06H
    MOV AL, 0
    MOV BH, 07H
    MOV CX, 0
    MOV DX, 184FH
    INT 10H
    
    ; Move cursor to top
    MOV AH, 02H
    MOV BH, 0
    MOV DX, 0
    INT 10H
    
    ; Display menu
    LEA DX, menu_msg
    MOV AH, 09H
    INT 21H
    RET
DISPLAY_MENU ENDP

; Procedure to get user choice
GET_CHOICE PROC
    MOV AH, 01H
    INT 21H
    MOV choice, AL
    RET
GET_CHOICE ENDP

; Procedure to get two numbers from user
GET_NUMBERS PROC
    ; Get first number
    LEA DX, num1_msg
    MOV AH, 09H
    INT 21H
    CALL INPUT_NUMBER
    MOV num1, AX
    
    ; Get second number
    LEA DX, num2_msg
    MOV AH, 09H
    INT 21H
    CALL INPUT_NUMBER
    MOV num2, AX
    RET
GET_NUMBERS ENDP

; Procedure to input a number (simplified - handles positive numbers only)
INPUT_NUMBER PROC
    MOV BX, 0       ; Initialize result
    MOV CX, 10      ; Base 10
    
INPUT_LOOP:
    MOV AH, 01H
    INT 21H
    
    CMP AL, 13      ; Check for Enter key
    JE INPUT_DONE
    
    CMP AL, '0'
    JL INPUT_LOOP
    CMP AL, '9'
    JG INPUT_LOOP
    
    SUB AL, '0'     ; Convert ASCII to digit
    MOV AH, 0
    
    ; BX = BX * 10 + digit
    PUSH AX
    MOV AX, BX
    MUL CX
    MOV BX, AX
    POP AX
    ADD BX, AX
    
    JMP INPUT_LOOP

INPUT_DONE:
    MOV AX, BX
    RET
INPUT_NUMBER ENDP

; Procedure to display result
DISPLAY_RESULT PROC
    LEA DX, result_msg
    MOV AH, 09H
    INT 21H
    MOV AX, result
    CALL PRINT_NUMBER
    RET
DISPLAY_RESULT ENDP

; Procedure to print a number
PRINT_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV BX, 10      ; Base 10
    MOV CX, 0       ; Digit counter
    MOV DX, 0

    ; Handle zero case
    POP AX
    PUSH AX
    CMP AX, 0
    JNE CONVERT_LOOP
    PUSH 30H        ; ASCII '0'
    INC CX
    JMP PRINT_DIGITS

CONVERT_LOOP:
    CMP AX, 0
    JE PRINT_DIGITS
    
    XOR DX, DX
    DIV BX
    ADD DL, 30H     ; Convert to ASCII
    PUSH DX
    INC CX
    JMP CONVERT_LOOP

PRINT_DIGITS:
    CMP CX, 0
    JE PRINT_DONE
    
    POP DX
    MOV AH, 02H
    INT 21H
    DEC CX
    JMP PRINT_DIGITS

PRINT_DONE:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUMBER ENDP

END MAIN

MAIN ENDP

; Procedure to display menu
DISPLAY_MENU PROC
    ; Clear screen (optional)
    MOV AH, 06H
    MOV AL, 0
    MOV BH, 07H
    MOV CX, 0
    MOV DX, 184FH
    INT 10H
    
    ; Move cursor to top
    MOV AH, 02H
    MOV BH, 0
    MOV DX, 0
    INT 10H
    
    ; Display menu
    LEA DX, menu_msg
    MOV AH, 09H
    INT 21H
    RET
DISPLAY_MENU ENDP

; Procedure to get user choice
GET_CHOICE PROC
    MOV AH, 01H
    INT 21H
    MOV choice, AL
    RET
GET_CHOICE ENDP

; Procedure to get two numbers from user
GET_NUMBERS PROC
    ; Get first number
    LEA DX, num1_msg
    MOV AH, 09H
    INT 21H
    CALL INPUT_NUMBER
    MOV num1, AX
    
    ; Get second number
    LEA DX, num2_msg
    MOV AH, 09H
    INT 21H
    CALL INPUT_NUMBER
    MOV num2, AX
    RET
GET_NUMBERS ENDP

; Procedure to input a number (simplified - handles positive numbers only)
INPUT_NUMBER PROC
    MOV BX, 0       ; Initialize result
    MOV CX, 10      ; Base 10
    
INPUT_LOOP:
    MOV AH, 01H
    INT 21H
    
    CMP AL, 13      ; Check for Enter key
    JE INPUT_DONE
    
    CMP AL, '0'
    JL INPUT_LOOP
    CMP AL, '9'
    JG INPUT_LOOP
    
    SUB AL, '0'     ; Convert ASCII to digit
    MOV AH, 0
    
    ; BX = BX * 10 + digit
    PUSH AX
    MOV AX, BX
    MUL CX
    MOV BX, AX
    POP AX
    ADD BX, AX
    
    JMP INPUT_LOOP

INPUT_DONE:
    MOV AX, BX
    RET
INPUT_NUMBER ENDP

; Procedure to display result
DISPLAY_RESULT PROC
    LEA DX, result_msg
    MOV AH, 09H
    INT 21H
    MOV AX, result
    CALL PRINT_NUMBER
    RET
DISPLAY_RESULT ENDP

; Procedure to print a number
PRINT_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV BX, 10      ; Base 10
    MOV CX, 0       ; Digit counter
    MOV DX, 0

    ; Handle zero case
    POP AX
    PUSH AX
    CMP AX, 0
    JNE CONVERT_LOOP
    PUSH 30H        ; ASCII '0'
    INC CX
    JMP PRINT_DIGITS

CONVERT_LOOP:
    CMP AX, 0
    JE PRINT_DIGITS
    
    XOR DX, DX
    DIV BX
    ADD DL, 30H     ; Convert to ASCII
    PUSH DX
    INC CX
    JMP CONVERT_LOOP

PRINT_DIGITS:
    CMP CX, 0
    JE PRINT_DONE
    
    POP DX
    MOV AH, 02H
    INT 21H
    DEC CX
    JMP PRINT_DIGITS

PRINT_DONE:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUMBER ENDP

END MAIN
