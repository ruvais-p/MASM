.model small
.stack 100h

.data
    prompt1 db "Enter the first single-digit number (0-9): $"
    prompt2 db "Enter the second single-digit number (0-9): $"
    resultMsg db "The product is: $"
    newLine db 0Dh, 0Ah, "$"
    invalidInputMsg db "Invalid input! Please enter a single digit (0-9).$"

    num1_char db ?   
    num2_char db ?   
    num1_val  db ?   
    num2_val  db ?   
    product   dw ?   

.code
main proc
    mov ax, @data  
    mov ds, ax


    mov ah, 09h
    lea dx, prompt1
    int 21h

    mov ah, 01h    
    int 21h
    mov num1_char, al 


    call validate_digit
    jc  invalid_first_input 
    mov num1_val, al 


    mov ah, 09h
    lea dx, newLine
    int 21h


    mov ah, 09h
    lea dx, prompt2
    int 21h

    mov ah, 01h     
    int 21h
    mov num2_char, al 


    call validate_digit
    jc  invalid_second_input 
    mov num2_val, al

    mov ah, 09h
    lea dx, newLine
    int 21h


    mov al, num1_val
    mov bl, num2_val
    mul bl          
    mov product, ax 


    mov ah, 09h
    lea dx, resultMsg
    int 21h


    mov ah, 09h
    lea dx, newLine
    int 21h


    mov ax, product
    call print_decimal 


    mov ah, 4Ch
    int 21h

invalid_first_input:
invalid_second_input:
    mov ah, 09h
    lea dx, newLine
    int 21h
    mov ah, 09h
    lea dx, invalidInputMsg
    int 21h
    ; Exit on error
    mov ah, 4Ch
    int 21h

main endp





validate_digit proc
    cmp al, '0'
    jb  invalid_digit_char 
    cmp al, '9'
    ja  invalid_digit_char  

    sub al, '0'            
    clc                     
    ret

invalid_digit_char:
    stc                   
    ret
validate_digit endp


print_decimal proc
    push ax
    push bx
    push cx
    push dx

    cmp ax, 0      
    je  print_zero_exit

    mov cx, 0      
    mov bx, 10     

divide_loop:
    xor dx, dx      
    div bx          
    push dx         
    inc cx          
    cmp ax, 0       
    jnz divide_loop

print_digits:
    pop dx          
    add dl, '0'    
    mov ah, 02h     
    int 21h
    loop print_digits 

    jmp print_decimal_exit

print_zero_exit:
    mov dl, '0'
    mov ah, 02h
    int 21h

print_decimal_exit:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_decimal endp

end main
