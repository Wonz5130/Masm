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
	INT	21H      ;询问姓名
	;MOV	AH,0AH
	MOV	DX,OFFSET BUF ;指的是30那个位置
	INT 21H      ;接收键入字符串
	MOV	BL,BUF+1 ;指的是？那个位置
	MOV	BH,0     ;实际键入的字符个数BX,高位置0
	MOV	SI,OFFSET BUF+2      ;指的是30 DUP(?)那个位置
	MOV	BYTE PTR[BX+SI],'$'  ;用'$'作为串结束符
	MOV	AH,2
	MOV	DL,0AH
	INT	21H      ;光标下移一行
	MOV	AH,9
	MOV	DX,OFFSET BUF+2
	INT	21H      ;复制键入的字符串
	MOV	AH,4CH
	INT	21H      ;返回 DOS

CODE ENDS 
	 END BEG

