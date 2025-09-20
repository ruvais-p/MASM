.model small
.stack 100h

.data
	num1 db 7
	num2 db 4
	msg db "Sum: $"

.code
main proc
	mov ax, @data
	mov ds, ax
	
	mov al, num1
	sub al, num2
	
	lea dx, msg
	mov ah, 09h
	int 21h
		
	add al, '0'      
	mov dl, al

	mov ah, 02h
	int 21h 
	
	mov ah, 4ch
	int 21h
	

main endp
end main
	
	

