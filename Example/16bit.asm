.model small
.stack 100h

.data
msg1 DB "Enter first digit : $"
msg2 DB 0DH ,0AH, "Enter second digit : $"
choices DB 0DH ,0AH, "Enter your choice: 1.ADD	2.SUB	3.MUL	4.DIV $"
minus DB "-$"
sum DB 0DH ,0AH, "The sum is $"
difference DB 0DH ,0AH, "The difference is $"
product DB 0DH ,0AH, "The product is $"
resultMessage db 0DH ,0AH, 'The result is: $'
errorDivZero  db 0DH ,0AH, 'Error: Division by zero.$'

choice DB ?
num1   DW ?
num2   DW ?
quot   DB ?       
rem    DB ?       


.code
main proc
	mov AX,@DATA
	mov DS,AX
		
	lea DX,msg1
	mov AH,09H
	int 21h
	
	mov AH,01H
	int 21H
	sub AL,30H
	mov num1,AX
	
	lea DX,msg2
	mov AH,09H
	int 21h
	
	mov AH,01H
	int 21H
	sub AL,30H
	mov num2,AX
	
	lea DX,choices
	mov AH,09H
	int 21h
	
	mov AH,01H
	int 21H
	sub AL,30H
	mov choice,AL
	
	cmp choice, 1
	je addition
	
	cmp choice, 2
	je subtraction
	
	cmp choice, 3
	je multiplication
	
	cmp choice, 4
	jmp division
		
addition:
	mov AX,num2
	mov BX,num1	
	add BX,AX
	
	lea DX,sum
	mov AH,09H
	int 21h
	
	add BX,'0'
	mov DX,BX
	mov AH,02H
	int 21h                 ; completed addition
	jmp done
	
subtraction:
	mov AX,num2
	mov BX,num1
	cmp BX, AX      ; Check if BL < AL 
	jge no_borrow

	
	sub AX, BX       ; AL = AL - BL
	
	lea DX, difference
	mov AH, 09H
	int 21h

	lea DX, minus    ; Show '-' sign
	mov AH, 09H
	int 21h

	add AX, '0'      ; Convert to ASCII
	mov DX, AX
	mov AH, 02H
	int 21h
	jmp done

no_borrow:
	sub BX, AX       ; BL = BL - AL
	lea DX, difference
	mov AH, 09H
	int 21h

	add BX, '0'      ; Convert to ASCII
	mov DX, BX
	mov AH, 02H
	int 21h               ; COMPLETED SUBTRACTION
	jmp done
	
	
multiplication:
	mov AX,num2
	mov BX,num1
	
	mul BX
	
	lea DX,product
	mov AH,09h
	int 21h
	
	
	add AX,'0'
	mov DX,AX
	mov AH,02H
	int 21h    
	
	jmp done        ; COMPLETED MULTIPLICATION
	
	
division:
	mov CX, num1    ; first no in BX
	mov BX, num2
	
   	cmp CX, 0
    	je  div_zero_error
    	
    	mov AL, CL
    	mov CX, 0
    	mov cl, bl
    	mov AH, 0
        div cl
    	
    	mov quot, AL
    	mov rem, AH
    	
        ; Display result message
        mov ah, 09h
        lea dx, resultMessage
        int 21h
	
	mov AL, quot
    	add al, 30h
    	mov dl, al
    	mov ah, 02h
    	int 21h
   
        mov ah, 4Ch
        int 21h

        div_zero_error:
        mov ah, 09h
        lea dx, errorDivZero
        int 21h
    
        mov ah, 4Ch
        mov al, 1
        int 21h
        jmp done
		
done:
	mov AH,4CH
	int 21h
main endp
end main

