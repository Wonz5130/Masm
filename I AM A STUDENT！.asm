.486
DATA	SEGMENT USE16            ;�������ݶ�
MESG    DB	'I AM A STUDENT!','$'
DATA    ENDS
CODE    SEGMENT USE16            ;��������
		ASSUME  CS:CODE,DS:DATA

BEG:
	MOV	AX,DATA
	MOV	DS,AX

LAST:
	MOV	AH,9
	MOV	DX,OFFSET MESG           ;ȡMESG��ƫ�Ƶ�ַ
	INT	21H
	MOV	AH,4CH           
	INT	21H                      ;����DOS

CODE	ENDS
	END	BEG

