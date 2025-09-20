.model small
.stack 100h
.data 
msg db 'Enter string : $'
buffer db 50
db ?
db 50 dup(?)
msg2 db 0Dh, 0Ah, 'Length = $'
.code 
main proc
	mov ax, @data
	mov ds, ax
	
	mov ah, 9
	mov dx, offset msg
	int 21h
	
	mov ah, 0Ah
	mov dx, offset buffer
	int 21h
	
	mov ah, 9
	mov dx, offset msg2
	int 21h
	
	mov al, [buffer+1]
	add al, '0'
	mov dl, al
	mov ah, 2
	int 21h
	
	mov ah, 4ch
	int 21h
main endp
end main
