DATAS  SEGMENT
DATAS  ENDS

STACKS  SEGMENT
STACKS  ENDS

CODES  SEGMENT
     ASSUME    CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,10
    ADD AX,20
    MOV BX,AX
    MOV CX,16  ;2���ƣ�16λ�Ĵ�������16��bit����Ҫѭ��16��
    MOV AH,0EH ;ʹ��INT 10H���������,0EH��ʾһ���ַ�
p1:
    ROL BX,1   ;��BX���1λ���Ƶ����1λ���������
    MOV AL,BL  ;��BL������AL���������
    AND AL,1   ;ֻ�������1λ��ֵ�����ղ�BX�����λ��ֵ
    XOR AL,30h ;ת��ΪascIIֵ'0',��'1'
    INT 10H    ;����10H�жϣ��������Ļ��
    LOOP p1    ;ѭ��
   
    MOV AH,4CH ;����ִ����ϣ��˳���ϵͳ
    INT 21H
   
CODES  ENDS
    END  START

