.486
DATA SEGMENT USE16
MESG1 DB 'HELLO $'
MESG2 DB 'I AM A STUDENT'
LL=$��MESG2
DATA ENDS
CODE SEGMENT USE16
	 ASSUME  CS:CODE 
	 ASSUME  DS:DATA
	 ASSUME  ES:DATA  ;����ʾ�ַ��Ž�ES

BEG:
	 MOV AX,DATA
     MOV DS,AX
     MOV ES,AX      ;DS��DATA
     MOV AX,0003H   ;80*25��ɫ�ı���ʽ
     INT 10H                 
     MOV AH,9
     MOV DX,OFFSET MESG1
     INT 21H
     MOV AX,1301H   ;��ʾ��ɫ�ַ���
     MOV BH,0
     MOV BL,01001111B
     MOV CX,LL
     MOV DH,12      ;һ��25��,12��������ʾ
     MOV DL,(80-LL)/2  ;һ��80��,������ʾ
     MOV BP,OFFSET MESG2  ;BP�Ž����Ӷ�,���Լ�ES:DATA
     INT 10H
     MOV AH,4CH
     INT 21H

CODE ENDS 
	 END    BEG  
