.model small                            
.data   
	msg1 db "Hi Ruvais...$"                                
        msg2 db 10d, 13d,"Hello World$"   

.code 
main proc                                  
        mov ax,@data                   
        mov ds,ax                       
                                        
        lea dx,msg1                     
        mov ah,09h                      
        int 21h 
        
        lea dx,msg2                     
        mov ah,09h                      
        int 21h                         

        mov ah,4ch                      
        int 21h                         
main endp
end main     
