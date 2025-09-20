.model small
.stack 100h

.data
	msgDigit DB 0DH, 0AH, "Digit$"
	msgNot DB 0DH, 0AH, "Not a Digit$"
	msg DB "You typed : $"
.code
main proc
	mov AX,@DATA
	mov DS,AX
		
	mov ah, 00h
	int 16h
	
	mov bl, al
	mov ah, 09h
	lea dx, msg
	int 21h
	
	mov dl, bl
	mov ah, 02h
	int 21h
	
	cmp al,'0'
	jl NotDigit
	cmp al, '9'
	jg NotDigit
	
	mov dx, OFFSET msgDigit
	jmp Display
	
NotDigit:
	mov dx, OFFSET msgNot
	
Display:
	mov ah, 09h
	int 21h
	
	mov AH,4CH
	int 21h
main endp
end main
