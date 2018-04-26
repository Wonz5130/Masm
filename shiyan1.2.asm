;FILENAME EXA131.ASM
.486
DATA SEGMENT USE16
     SUM DB ?,?   ;去掉一个','，两个空值
     MESG DB '25+9=' 
     DB 0,0,'$' ;加个$，作为整个字符串输出
     N1 DB 9    ;F0H有问题
     N2 DB 25   ;DW改成DB
DATA ENDS

CODE SEGMENT USE16
    ASSUME CS:CODE,DS:DATA
BEG:
    MOV AX,DATA
    MOV DS,AX
    MOV BX,OFFSET SUM  ;取SUM的偏移地址
    MOV AH,N1
    MOV AL,N2
    ADD AH,AL
    MOV [BX],AH
    CALL CHANG
    MOV AH,9
    MOV DX,OFFSET MESG  ;打错了
    INT 21H
    ;CALL CHANG   ;放到字符串输出下面
    MOV AH,4CH
    INT 21H

CHANG PROC  ;没冒号
LAST:
	CMP BYTE PTR [BX],10  ;长度不匹配
	JC NEXT   ;小于10就跳转到NEXT
	SUB BYTE PTR [BX],10
	INC BYTE PTR [BX+7]  ;计算十位上的数字
	JMP LAST
NEXT:
	MOV AH,SUM
	ADD [BX+8],AH
	ADD BYTE PTR [BX+7],30H  ;长度不匹配
	ADD BYTE PTR [BX+8],30H
	RET
CHANG ENDP  ;没冒号

CODE ENDS
    END BEG

