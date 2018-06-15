.486
DATA SEGMENT USE16
MESG1 DB 'HELLO $'
MESG2 DB 'I AM A STUDENT'
LL=$－MESG2
DATA ENDS
CODE SEGMENT USE16
	 ASSUME  CS:CODE 
	 ASSUME  DS:DATA
	 ASSUME  ES:DATA  ;待显示字符放进ES

BEG:
	 MOV AX,DATA
     MOV DS,AX
     MOV ES,AX      ;DS←DATA
     MOV AX,0003H   ;80*25彩色文本方式
     INT 10H                 
     MOV AH,9
     MOV DX,OFFSET MESG1
     INT 21H
     MOV AX,1301H   ;显示彩色字符串
     MOV BH,0
     MOV BL,01001111B
     MOV CX,LL
     MOV DH,12      ;一共25行,12行中央显示
     MOV DL,(80-LL)/2  ;一共80列,中央显示
     MOV BP,OFFSET MESG2  ;BP放进附加段,所以加ES:DATA
     INT 10H
     MOV AH,4CH
     INT 21H

CODE ENDS 
	 END    BEG  
