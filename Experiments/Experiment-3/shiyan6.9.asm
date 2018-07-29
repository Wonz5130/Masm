;FILENAME:861-1.ASM
.486
DATA	SEGMENT USE16
MESG	DB	'WWW',0DH,0AH,'$'
OLD1C	DD	?
ICOUNT	DB	18   ;中断计数初值
COUNT	DB	10   ;显示行数控制
DATA	ENDS
CODE	SEGMENT	USE16
		ASSUME	CS:CODE,DS:DATA
BEG:	MOV		AX,DATA
		MOV		DS,AX
		CLI               ;关中断
		CALL	READ1C
		CALL	WRITE1C
		STI               ;开中断
SCAN:	CMP		COUNT,0
		JNZ		SCAN      ;是否已经显示10行,否转
		CALL	RESET
		MOV		AH,4CH
		INT		21H
;-------------------------------
SERVICE	PROC
		PUSHA              ;保护现场
		PUSH	DS         ;DS=40H
		MOV		AX,DATA
		MOV		DS,AX      ;重新给DS赋值
		DEC		ICOUNT     ;中断计数
		JNZ		EXIT       ;不满18次转
		MOV		ICOUNT,18
		DEC		COUNT      ;显示行数减1
		MOV		AH,9       ;显示字符串
		LEA		DX,MESG
		INT		21H
EXIT:	POP		DS         ;恢复现场
		POPA
		IRET               ;返回系统8型中断服务程序
SERVICE ENDP
;------------------------------
READ1C	PROC               ;转移系统1CH型中断向量
		MOV AX,351CH
		INT	21H
		MOV WORD PTR OLD1C,BX
		MOV WORD PTR OLD1C+2,ES
		RET
READ1C	ENDP
;-----------------------------
WRITE1C	PROC               ;写入用户1CH型中断向量
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
RESET PROC                 ;恢复系统1CH型中断向量
		MOV		DX,WORD PTR OLD1C
		MOV		DX,WORD PTR OLD1C+2
		MOV		AX,251CH
		INT		21H
		RET
RESET	ENDP
CODE 	ENDS
		END BEG
