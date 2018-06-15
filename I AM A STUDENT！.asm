.486
DATA	SEGMENT USE16            ;定义数据段
MESG    DB	'I AM A STUDENT!','$'
DATA    ENDS
CODE    SEGMENT USE16            ;定义代码段
		ASSUME  CS:CODE,DS:DATA

BEG:
	MOV	AX,DATA
	MOV	DS,AX

LAST:
	MOV	AH,9
	MOV	DX,OFFSET MESG           ;取MESG的偏移地址
	INT	21H
	MOV	AH,4CH           
	INT	21H                      ;返回DOS

CODE	ENDS
	END	BEG

