DATA SEGMENT USE16   

MESG DB 0DH,0AH
     DB 'Please enter your password:$' ;һ��28���ַ�
BUF1 DB 6 DUP(?)
BUF2 DB '666666'
BUF3 DB 'Wrong Answer!$'
BUF4 DB 'Accepted!$'
COUNT DB 3

DATA ENDS

CODE SEGMENT USE16
     ASSUME CS:CODE,DS:DATA,ES:DATA  ;ES���Ӷ�ҲҪ
     
BEG:
     MOV AX,DATA
     MOV DS,AX
     MOV ES,AX  ;AX����ES

AGAIN:
     MOV AH,09H
     MOV DX,OFFSET MESG ;ȡƫ�Ƶ�ַ
     INT 21H
     MOV BX,OFFSET BUF1
     MOV CX,6
     
LAST:
     MOV AH,07H
     INT 21H     ;�������һ��
     MOV [BX],AL ;��λ����BX
     MOV AH,02H  ;��ʾ�ַ�
     MOV DL,'*'
     INT 21H
     INC BX      ;BX����һλ,һ����6��
     LOOP LAST
     
     MOV DI,OFFSET BUF1
     MOV SI,OFFSET BUF2
     CLD
     MOV CX,6    ;�Ƚ�6��
     REPE CMPSB  ;�ַ����Ƚ�
     JZ RIGHT    ;ZF=1����ʾһ��������RIGHT
     MOV AH,09H
     MOV DX,OFFSET BUF3
     INT 21H
     DEC COUNT
     JZ EXIT
     JMP AGAIN

RIGHT:
     MOV AH,09H
     MOV DX,OFFSET BUF4
     INT 21H

EXIT:
     MOV AH,4CH
     INT 21H  ;���� DOS
     
CODE ENDS
     END BEG
