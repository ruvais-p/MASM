.model small
.stack 100h

.data
	msg1 db "Enter first number: $"
	msg2 db 10d, 13d, "Enter second number: $"
	msg3 db 10d, 13d, "Difference: $"

.code
main proc
	mov ax, @data
	mov ds, ax
	
	lea dx, msg1
	mov ah, 09h
	int 21h
	
	mov ah, 01h
	int 21h
	sub al, 30h
	mov bl, al
	
	lea dx, msg2
	mov ah, 09h
	int 21h
	
	mov ah, 01h
	int 21h
	sub al, 30h
	sub bl, al
	
	lea dx, msg3
	mov ah, 09h
	int 21h
		
	add bl, '0'      
	mov dl, bl

	mov ah, 02h
	int 21h 
	
	mov ah, 4ch
	int 21h
	

main endp
end main
	
	

