.586
CODE	SEGMENT USE16
ASSUME  CS:CODE
		ORG 100H

BEG:
	JMP START
	SUM DB ?

START:             
	MOV	AL,46H	    ;46H��AL
	ADD	AL,52H 	    ;46H+52H��AL
	MOV	SUM,AL   	;AL��SUM
  	MOV AH,4CH
	INT	21H       	;����DOS

CODE   ENDS
	END	BEG         ;���������
