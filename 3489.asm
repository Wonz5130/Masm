DATA SEGMENT USE16
     BUF DB '3','4','8','9'
     COUNT EQU $-BUF
DATA ENDS

CODES SEGMENT USE16
    ASSUME CS:CODES,DS:DATA

START:
    MOV AX,DATA
    MOV DS,AX
    MOV CX,COUNT ;ѭ��4��
    MOV SI,OFFSET BUF
    MOV AX,0  ;AX����ۼӵĺ�
    MOV DH,0  ;DH����
    MOV BX,10

AGA:
    MUL BX
    MOV DL,[SI]
    SUB DL,30H  ;�ü���
    ;MOV AX WORD PTR [DL]
    ADD AX,DX
    INC SI
    LOOP AGA
    MOV BX,AX
    CALL COMPUTE
EXIT:
    MOV AH,4CH
    INT 21H

;-------------------------
   
COMPUTE PROC
	MOV CX,16
LAST:
    MOV DL,30H
    ROL AX,1
    JNC NEXT
    MOV DL,31H
    
NEXT:  
    MOV AH,02H
    INT 21H
    LOOP LAST
    RET
COMPUTE ENDP
    
CODES ENDS
    END START
