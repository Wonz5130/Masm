.586
DATA	SEGMENT USE16
SUM	DB  ?	        ;������
DATA	ENDS
CODE	SEGMENT USE16
ASSUME  CS:CODE,DS:DATA

BEG:
	MOV	AX,DATA	    ;����DS��ֵ
	MOV	DS,AX                 
	MOV	AL,46H	    ;46H��AL
	ADD	AL,52H 	    ;46H+52H��AL
	MOV	SUM,AL   	;AL��SUM
  	MOV AH,4CH
	INT	21H       	;����DOS

CODE   ENDS
	END     BEG     	;���������
