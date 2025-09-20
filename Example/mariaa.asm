.model small
.stack 100h

.data
msg1 DB "Enter first digit : $"
msg2 DB 0DH ,0AH, "Enter second digit : $"
msg3 DB 0DH ,0AH, "The difference is $"
minus DB "-$"

.code
main proc
	mov AX,@DATA
	mov DS,AX
		
	lea DX,msg1
	mov AH,09H
	int 21h
	
	mov AH,01H   ; FIRST DIGIT OF FIRST NUMBER
	int 21H
	sub AL,'0'
	mov BL,AL
	
	mov AH,01H   ; SECOND DIGIT OF FIRST NUMBER
	int 21H
	sub AL,'0'
	mov BH,AL
	
	mov AL,BL
	mov AH,0
	mov CL,10
	
	mul CL
	
	add AL,BH
	
	mov CH,AL    ; SAVE FIRST NUMBER IN CH
	
	
	lea DX,msg2
	mov AH,09H
	int 21h
	
	mov AH,01H   ; FIRST DIGIT OF SECOND NUMBER
	int 21H
	sub AL,'0'
	mov BL,AL
	
	mov AH,01H   ; SECOND DIGIT OF SECOND NUMBER
	int 21H
	sub AL,'0'
	mov BH,AL
	
	mov AL,BL
	mov AH,0
	mov CL,10
	
	mul CL
	
	add AL,BH
	
	cmp CH,AL       ; Check if CH < AL 
	jge no_borrow
	
	sub AL,CH
	
	mov BL,AL
	
	lea DX,msg3
	mov AH,09H
	int 21h
	
	lea DX, minus    ; Show '-' sign
	mov AH, 09H
	int 21h
	
	mov AX,0
	mov AL,BL
	mov CX,0
	mov BL,10
	jmp display_loop
	
no_borrow:	
	sub CH,AL
	mov AL,CH
	
	mov BL,AL
	
	lea DX,msg3
	mov AH,09H
	int 21h
	
	mov AX,0
	mov AL,BL
	mov CX,0
	mov BL,10
	
display_loop:

	mov AH,0
	div BL
	push AX
	inc CX
	cmp AL,0
	jne display_loop
	
print_digits:

	pop DX
	mov DL,DH
	add DL,'0'
	
	mov AH,02H
	int 21h
	loop print_digits
	
	mov AH,4CH
	int 21h
main endp
end main
