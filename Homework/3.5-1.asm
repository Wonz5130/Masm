DATAS SEGMENT
FIRST DB 12H,34H
SECOND DB 56H,78H
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV AL,FIRST
    MOV BL,SECOND
    MOV FIRST,BL
    MOV SECOND,AL
    MOV AL,FIRST+1
    MOV BL,SECOND+1
    MOV FIRST+1,BL
    MOV SECOND+1,AL
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
