DATA SEGMENT USE16

BUF DB 4 DUP(?)
Notation DB 'Please enter your tongxinzi:$'
tongxinzi DB 'wonz'
WA DB 'Wrong tongxinzi!$'
AC DB 'Welcome!'
LL EQU $-AC
COUNT DB 3  ;ֻ������ 3 ��

DATA ENDS

CODE SEGMENT USE16
     ASSUME CS:CODE,DS:DATA,ES:DATA  ;ES���Ӷ�ҲҪ,����ʾ�ַ��Ž�ES
     
BEG:
     MOV AX,DATA
     MOV DS,AX
     MOV ES,AX  ;AX����ES
    
AGAIN:
	 MOV AH,09H
	 MOV DX,OFFSET Notation  ;�����ʾ���
	 INT 21H
     MOV BX,OFFSET BUF
     MOV CX,4  ;�����ĸ�����

;�ж�ͨ�����Ƿ���ȷ 
LAST:
     MOV AH,07H  ;�������ַ�������ӦCtrl_C
     INT 21H     
     MOV [BX],AL ;��λ����BX
     MOV AH,02H  ;��ʾ�ַ�
     MOV DL,'*'
     INT 21H
     INC BX      ;BX����һλ,һ����4��
     LOOP LAST
     
     MOV DI,OFFSET BUF
     MOV SI,OFFSET tongxinzi
     MOV CX,4    ;�Ƚ�4��
     REPE CMPSB  ;�ַ����Ƚ�
     JZ RIGHT    ;ZF=1����ʾһ��������RIGHT
     MOV AH,2
     MOV DL,0AH  ;����
     INT 21H
     
     MOV AH,09H
     MOV DX,OFFSET WA  ;�������ͨ����
     INT 21H
     MOV AH,2
     MOV DL,0AH  ;����
     INT 21H
     DEC COUNT  ;����,�������ͨ���־��˳�
     JZ EXIT
     JMP AGAIN

RIGHT:
	 MOV AH,2
     MOV DL,0AH  ;����
     INT 21H
     MOV AH,09H
     MOV DX,OFFSET AC  ;�����ӭ
     INT 21H

COLOR:
    MOV AX,0003H   ;80*25��ɫ�ı���ʽ
    INT 10H
    MOV AX,1301H  ;��ʾ��ɫ�ַ���
    MOV BX,0047H  ;��ɫ�������Ұ�ɫ����
    MOV CX,LL
    MOV DH,12   ;һ�� 25 �У�������ʾ
    MOV DL,(80-LL)/2    ;80�У�������ʾ
    LEA BP,AC
    INT 10H         ;���� BIOS �ж�INT 10H��13H�Ź��ܣ����в���

EXIT:
     MOV AH,4CH
     INT 21H  ;���� DOS
     
CODE ENDS
     END BEG

