.model small
.stack 100h
.data
	array DB 5,10,15,20,25
	arlen DB 5
	
	msg1 DB'Sum using Indirect Addressing=$'
	msg2 DB 0Dh,0Ah,'Sum using Indexed Addressing=$'
	msg3 DB 0Dh,0Ah,'SUm using Based-Indexed Addressing=$'
	newline DB 0Dh,0Ah,'$'
	
	sumIndirect DW 0
	sumIndexed DW 0
	sumBaseIndex DW 0
	
.code
main proc
	mov AX,@DATA
	mov DS,AX
	
	xor AX,AX
	mov SI,OFFSET array
	mov CL,arlen
	xor CX,CX
	mov CL,arlen
sumIndirectloop:
	mov AL,[SI]
	cbw
	add sumIndirect,AX
	inc SI
	loop sumIndirectloop
	
	mov AH,09h
	lea DX,msg1
	int 21h
	
	mov AX,sumIndirect
	call print_word
	mov AH,09h
	lea DX,newline
	int 21h
	
	xor AX,AX
	mov SI,0
	mov CL,arlen
	
sumIndexedloop:
	mov AL,array[SI]
	cbw
	add sumIndexed,AX
	inc SI
	loop sumIndexedloop
	
	mov AH,09h
	lea DX,msg2
	int 21h
	
	mov AX,sumIndexed
	call print_word
	mov AH,09h
	
	lea DX,newline
	int 21h
	
	xor AX,AX
	mov BX,OFFSET array
	xor SI,SI
	mov CL,arlen
	
sumBaseIndexloop:
	mov AL,[BX+SI]
	cbw
	add sumBaseIndex,AX
	inc SI
	loop sumBaseIndexloop
	
	mov AH,09h
	lea DX,msg3
	int 21h
	
	mov AX,sumBaseIndex
	call print_word
	mov AH,09h
	
	lea DX,newline
	int 21h
	
	mov AH,4Ch
	int 21h
	
main endp
print_word proc
	push AX
	push BX
	push CX
	push DX
	
	mov BX,10
	xor CX,CX
	
	cmp AX,0
	jne convert
	mov DL,'0'
	mov AH,02h
	int 21h
	
	jmp doneprint
convert:
NextDigit:
	xor DX,Dx
	div BX
	push DX
	inc CX
	test AX,AX
	jnz NextDigit
	
print_loop:
	pop DX
	add DL,'0'
	mov AH,02h
	int 21h
	loop print_loop
doneprint:
	pop DX
	pop CX
	pop BX
	pop AX
	ret
	
print_word endp
end main
