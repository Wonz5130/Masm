.586
DATA SEGMENT USE16   
MESG DB	0DH,0AH
	 DB	'What is your name ?$'
BUF	 DB	30
	 DB ?
	 DB 30 DUP(?)
DATA ENDS
CODE SEGMENT USE16
	 ASSUME	CS:CODE,DS:DATA

BEG:
	MOV	AX,DATA
	MOV	DS,AX
	
AGAIN: 
	MOV	AH,9
	MOV	DX,OFFSET MESG
	INT	21H      ;ѯ������
	;MOV	AH,0AH
	MOV	DX,OFFSET BUF ;ָ����30�Ǹ�λ��
	INT 21H      ;���ռ����ַ���
	MOV	BL,BUF+1 ;ָ���ǣ��Ǹ�λ��
	MOV	BH,0     ;ʵ�ʼ�����ַ�����BX,��λ��0
	MOV	SI,OFFSET BUF+2      ;ָ����30 DUP(?)�Ǹ�λ��
	MOV	BYTE PTR[BX+SI],'$'  ;��'$'��Ϊ��������
	MOV	AH,2
	MOV	DL,0AH
	INT	21H      ;�������һ��
	MOV	AH,9
	MOV	DX,OFFSET BUF+2
	INT	21H      ;���Ƽ�����ַ���
	MOV	AH,4CH
	INT	21H      ;���� DOS

CODE ENDS 
	 END BEG

