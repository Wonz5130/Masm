DATAS  SEGMENT USE16
	SUM DB ?
DATAS  ENDS

STACKS  SEGMENT USE16
STACKS  ENDS

CODES  SEGMENT
     ASSUME    CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV AL,10
    ADD AL,20
    MOV SUM,AL
    MOV CX,8   ;2���ƣ�8λ�Ĵ�������8��bit����Ҫѭ��8��
AGAIN:
    ROL SUM,1  ;������λ��ѭ�����ƣ���SUM���1λ���Ƶ����1λ���������
    JC PRINT1  ;���CF=1����ת��PRINT1
    ;CF=0
    MOV DL,30H ;��'0'����DL��
    MOV AH,02H ;�ù��ܺ�02H����ʾ�ַ�
    INT 21H
    JMP NEXT
PRINT1:
    MOV DL,31H ;��'1'����DL��
    MOV AH,02H
    INT 21H
NEXT:
    LOOP AGAIN ;ѭ��
    
    MOV AH,4CH ;����ִ����ϣ��˳���ϵͳ
    INT 21H
   
CODES  ENDS
    END  START
