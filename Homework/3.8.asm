.586
DATAS SEGMENT
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV AX,1234H
    SHL AH,4
    AND AL,0FH
    OR AH,AL
    ;ADD AH,AL
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
