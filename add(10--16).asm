DATA SEGMENT USE16
    BUF DW 987AH
DATA ENDS
CODE SEGMENT USE16

ASSUME  CS:CODE,DS:DATA

BEG:
	MOV AX,DATA
    MOV DS,AX
    MOV DX,10
    ADD DX,20
    MOV CX,4
    SAL EDX,16  ;����16λ��һ����32λ
    
AGA: 
	ROL EDX,4   ;������λѭ��������λ����ȡ��ǰ����Ԫ��
    AND DL,0FH  ;�õ�һλ��0����ȡ��λ��������
    CMP DL,10   ;�жϷ�Χ��ת��ΪASCII��
    JC NEXT     ;<10��ת
    ADD DL,7    ;>=10���ͼ���7����ʾA-F
    
NEXT:
	ADD DL,30H
    MOV AH,2
    INT 21H  ;��ʾ�ַ�
    LOOP AGA
    MOV AH,4CH
    INT 21H
    
CODE ENDS
     END BEG
