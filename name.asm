DATA SEGMENT USE16   
MESG DB 0DH,0AH
     DB 'What is your name ?$' ;һ��9���ַ�
BUF  DB 30 ;����ԱԤ�ÿ����ɵ��ַ�����(�����س���)
     DB ?  ;���ֵ
     DB 30 DUP(?) ;����30���ֽڵ��ڴ���
DATA ENDS
CODE SEGMENT USE16
     ASSUME CS:CODE,DS:DATA
BEG:
     MOV AX,DATA
     MOV DS,AX
AGAIN:
     MOV AH,9
     MOV DX,OFFSET MESG ;ȡMESG��ƫ�Ƶ�ַ
     ;LEA DX MESG ;�ȼ�����һ��
     INT 21H  ;ѯ������
     MOV AH,0AH ;�ȴ��Ӽ��������ַ���
     MOV DX,OFFSET BUF ;ȡBUF��ƫ�Ƶ�ַ
     INT 21H  ;���ռ����ַ���
     MOV BL,BUF+1 ;��ʵ�������ַ�����(�������س���)д��BUF+1��Ԫ
     MOV BH,0 
     ;ʵ�ʼ�����ַ�����->BX
     MOV SI,OFFSET BUF+2 ;�����ַ�����BUF+2��Ԫ��ʼ���δ��,ȡƫ�Ƶ�ַ
     MOV BYTE PTR[BX+SI],'$'  ;��'$'��Ϊ��������
     MOV AH,2
     MOV DL,0AH ;�ȴ��Ӽ��������ַ���
     INT 21H  ;�������һ��
     MOV AH,9
     MOV DX,OFFSET BUF+2
     INT 21H  ;���Ƽ�����ַ���
     MOV AH,4CH
     INT 21H  ;���� DOS
CODE ENDS 
     END BEG
