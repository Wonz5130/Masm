.586
CODE	SEGMENT USE16
ASSUME  CS:CODE
		ORG 100H

BEG:
	JMP START
	SUM DB ?

START:             
	MOV	AL,46H	    ;46H¡úAL
	ADD	AL,52H 	    ;46H+52H¡úAL
	MOV	SUM,AL   	;AL¡úSUM
  	MOV AH,4CH
	INT	21H       	;·µ»ØDOS

CODE   ENDS
	END	BEG         ;»ã±à½áÊøÓï¾ä
