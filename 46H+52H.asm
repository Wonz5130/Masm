.586
DATA	SEGMENT USE16
SUM	DB  ?	        ;数据区
DATA	ENDS
CODE	SEGMENT USE16
ASSUME  CS:CODE,DS:DATA

BEG:
	MOV	AX,DATA	    ;设置DS初值
	MOV	DS,AX                 
	MOV	AL,46H	    ;46H→AL
	ADD	AL,52H 	    ;46H+52H→AL
	MOV	SUM,AL   	;AL→SUM
  	MOV AH,4CH
	INT	21H       	;返回DOS

CODE   ENDS
	END     BEG     	;汇编结束语句
