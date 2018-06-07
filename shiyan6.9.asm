;FILENAME:861-1.ASM
.486
DATA	SEGMENT USE16
MESG	DB	'WWW',0DH,0AH,'$'
OLD1C	DD	?
ICOUNT	DB	18   ;�жϼ�����ֵ
COUNT	DB	10   ;��ʾ��������
DATA	ENDS
CODE	SEGMENT	USE16
		ASSUME	CS:CODE,DS:DATA
BEG:	MOV		AX,DATA
		MOV		DS,AX
		CLI               ;���ж�
		CALL	READ1C
		CALL	WRITE1C
		STI               ;���ж�
SCAN:	CMP		COUNT,0
		JNZ		SCAN      ;�Ƿ��Ѿ���ʾ10��,��ת
		CALL	RESET
		MOV		AH,4CH
		INT		21H
;-------------------------------
SERVICE	PROC
		PUSHA              ;�����ֳ�
		PUSH	DS         ;DS=40H
		MOV		AX,DATA
		MOV		DS,AX      ;���¸�DS��ֵ
		DEC		ICOUNT     ;�жϼ���
		JNZ		EXIT       ;����18��ת
		MOV		ICOUNT,18
		DEC		COUNT      ;��ʾ������1
		MOV		AH,9       ;��ʾ�ַ���
		LEA		DX,MESG
		INT		21H
EXIT:	POP		DS         ;�ָ��ֳ�
		POPA
		IRET               ;����ϵͳ8���жϷ������
SERVICE ENDP
;------------------------------
READ1C	PROC               ;ת��ϵͳ1CH���ж�����
		MOV AX,351CH
		INT	21H
		MOV WORD PTR OLD1C,BX
		MOV WORD PTR OLD1C+2,ES
		RET
READ1C	ENDP
;-----------------------------
WRITE1C	PROC               ;д���û�1CH���ж�����
		PUSH	DS
		MOV		AX,CODE
		MOV		DS,AX
		MOV		DX,OFFSET SERVICE
		MOV		AX,251CH
		INT		21H
		POP		DS
		RET
WRITE1C ENDP
;-----------------------------
RESET PROC                 ;�ָ�ϵͳ1CH���ж�����
		MOV		DX,WORD PTR OLD1C
		MOV		DX,WORD PTR OLD1C+2
		MOV		AX,251CH
		INT		21H
		RET
RESET	ENDP
CODE 	ENDS
		END BEG
