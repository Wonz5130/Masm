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
    MOV CX,4   ;��ΪBX��16λ��ÿ4λһ�飬����4�飬CX=4�趨ѭ����ʼֵ
	
LAST:
	ROL BX,4
	MOV AL,BL
	AND AL,0FH ;��ȡ��λ��������
	CMP AL,10
	JC NEXT    ;<10����ת
	ADD AL,7   ;>=10�����7
    
NEXT:
	ADD AL,30H
	MOV AH,2
	MOV DL,AL
    INT 21H    ;��ʾ�ַ�
    LOOP LAST
    MOV AH,2
    MOV DL,'H'
    INT 21H
    MOV AH,4CH
    INT 21H
    
CODE ENDS
     END BEG
