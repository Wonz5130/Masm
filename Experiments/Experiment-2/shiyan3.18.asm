DATA SEGMENT USE16

MESG1 DB 0DH,0AH
      DB 'Please enter your username:$'
LL EQU $-MESG1
BUF DB 30
    DB ?
    DB 30 DUP(?)
BUF1 DB 6 DUP(?)
MIMA DB '666666'
WA DB 'Wrong Answer!$'
AC DB 'Welcome!$'
USER DB 'wonz'
WU DB 'Wrong Username$'
PASSWORD DB 'Please enter your password:$'
BUF2 DB 4 DUP(?)
COUNT DB 3

DATA ENDS

CODE SEGMENT USE16
     ASSUME CS:CODE,DS:DATA,ES:DATA  ;ES���Ӷ�ҲҪ,����ʾ�ַ��Ž�ES
     
BEG:
     MOV AX,DATA
     MOV DS,AX
     MOV ES,AX  ;AX����ES
     MOV AX,0003H
     INT 10H
     
  
    
AGAIN1:
	 ;MOV AX,0003H
	 ;INT 10H
	 ;MOV DH,12
	 ;MOV DL,(80-LL)/2
	 MOV AH,09H
     MOV DX,OFFSET MESG1 ;ȡƫ�Ƶ�ַ
     INT 21H
     MOV AX,1301H
     MOV BL,01001111B
     MOV CX,LL
     MOV DH,12
	 MOV DL,(80-LL)/2
     MOV BX,OFFSET BUF2
     MOV CX,4

;�ж��û����Ƿ���ȷ 
LAST1:
     MOV AH,01H  ;����4λ�û���
     INT 21H     
     MOV [BX],AL ;��λ����BX
     INC BX      ;BX����һλ,һ����4��
     LOOP LAST1
     
     MOV DI,OFFSET BUF2
     MOV SI,OFFSET USER
     CLD
     MOV CX,4    ;�Ƚ�4��
     REPE CMPSB  ;�ַ����Ƚ�,����CX-1
     JZ AGAIN2   ;ZF=1����ʾһ��������AGAIN2
     
     MOV AH,2
     MOV DL,0AH  ;����
     INT 21H
     
     MOV AH,09H
     MOV DX,OFFSET WU
     INT 21H
     DEC COUNT
     JZ EXIT
     JMP AGAIN1  ;������һ���û���


AGAIN2:
	 MOV AH,2	
     MOV DL,0AH
     INT 21H
	 MOV AH,09H
	 MOV DX,OFFSET PASSWORD
	 INT 21H
     MOV BX,OFFSET BUF1
     MOV CX,6
     MOV COUNT,3


;�ж������Ƿ����   
LAST2:
     MOV AH,07H  ;�������ַ�
     INT 21H     ;�������һ��
     MOV [BX],AL ;��λ����BX
     MOV AH,02H  ;��ʾ�ַ�
     MOV DL,'*'
     INT 21H
     INC BX      ;BX����һλ,һ����6��
     LOOP LAST2
     
     MOV DI,OFFSET BUF1
     MOV SI,OFFSET MIMA
     CLD
     MOV CX,6    ;�Ƚ�6��
     REPE CMPSB  ;�ַ����Ƚ�
     JZ RIGHT    ;ZF=1����ʾһ��������RIGHT
     MOV AH,2
     MOV DL,0AH
     INT 21H
     
     MOV AH,09H
     MOV DX,OFFSET WA
     INT 21H
     DEC COUNT  ;����,�������������˳�
     JZ EXIT
     JMP AGAIN2

RIGHT:
	 MOV AH,2
     MOV DL,0AH
     INT 21H
     MOV AH,09H
     MOV DX,OFFSET AC
     INT 21H

EXIT:
     MOV AH,4CH
     INT 21H  ;���� DOS
     
CODE ENDS
     END BEG
