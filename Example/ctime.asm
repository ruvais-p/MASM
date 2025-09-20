.MODEL SMALL
.STACK 100H

.DATA
        MSG DB 'CURRENT TIME: $'
        HR DB '00:00:00 $'
.CODE
MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        MOV AH,2CH
        INT 21H
        MOV AL,CH
        CALL BCDTOASCII
        MOV HR[0],BL
        MOV HR[1],BH
        MOV AL,CL
        CALL BCDTOASCII
        MOV HR[3],BL
        MOV HR[4],BH
        MOV AL,DH
        CALL BCDTOASCII
        MOV HR[6],BL
        MOV HR[7],BH
        MOV DX,OFFSET HR
        MOV AH,09H
        INT 21H
        
        MOV AH,4CH
    	INT 21H
BCDTOASCII PROC
        MOV AH,0
        MOV BL,10
        DIV BL
        ADD AL,'0'
        MOV BL,AL
        ADD AH,'0'
        MOV BH,AH
        RET 
BCDTOASCII ENDP
MAIN ENDP
END MAIN
