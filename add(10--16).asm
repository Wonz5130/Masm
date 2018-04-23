.586
DATA SEGMENT USE16
    ;BUF DW 987AH
DATA ENDS

CODE SEGMENT USE16
ASSUME  CS:CODE,DS:DATA

BEG:
	MOV AX,DATA
    MOV DS,AX
    MOV DX,10
    ADD DX,20
    MOV BX,DX
    MOV CX,4   ;因为BX是16位，每4位一组，共有4组，CX=4设定循环初始值
	
LAST:
	ROL BX,4
	MOV AL,BL
	AND AL,0FH ;截取四位二进制数
	CMP AL,10
	JC NEXT    ;<10则跳转
	ADD AL,7   ;>=10则加上7
    
NEXT:
	ADD AL,30H
	MOV AH,2
	MOV DL,AL
    INT 21H    ;显示字符
    LOOP LAST
    MOV AH,2
    MOV DL,'H'
    INT 21H
    MOV AH,4CH
    INT 21H
    
CODE ENDS
     END BEG
