;FILENAME EXA131.ASM
.486
DATA SEGMENT USE16
     SUM DB ?,?   ;ȥ��һ��','��������ֵ
     MESG DB '25+9=' 
     DB 0,0,'$' ;�Ӹ�$����Ϊ�����ַ������
     N1 DB 9    ;F0H������
     N2 DB 25   ;DW�ĳ�DB
DATA ENDS

CODE SEGMENT USE16
    ASSUME CS:CODE,DS:DATA
BEG:
    MOV AX,DATA
    MOV DS,AX
    MOV BX,OFFSET SUM  ;ȡSUM��ƫ�Ƶ�ַ
    MOV AH,N1
    MOV AL,N2
    ADD AH,AL
    MOV [BX],AH
    CALL CHANG
    MOV AH,9
    MOV DX,OFFSET MESG  ;�����
    INT 21H
    ;CALL CHANG   ;�ŵ��ַ����������
    MOV AH,4CH
    INT 21H

CHANG PROC  ;ûð��
LAST:
	CMP BYTE PTR [BX],10  ;���Ȳ�ƥ��
	JC NEXT   ;С��10����ת��NEXT
	SUB BYTE PTR [BX],10
	INC BYTE PTR [BX+7]  ;����ʮλ�ϵ�����
	JMP LAST
NEXT:
	MOV AH,SUM
	ADD [BX+8],AH
	;ADD [BX+8],SUM  ;�Ƿ��洢�����ã�Դ��������Ŀ�Ĳ���������ͬʱΪ�洢��
	ADD BYTE PTR [BX+7],30H  ;���Ȳ�ƥ��
	ADD BYTE PTR [BX+8],30H
	RET
CHANG ENDP  ;ûð��

CODE ENDS
    END BEG
