DATAS  SEGMENT USE16
    SUM DW ?
    COUNT1 DB 0
    COUNT2 DB 0
    COUNT3 DB 0
DATAS  ENDS

STACKS  SEGMENT USE16
STACKS  ENDS

CODES  SEGMENT
     ASSUME    CS:CODES,DS:DATAS,SS:STACKS
     
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV AL,11
    ADD AL,20
    MOV CX,100  ;����һ���ƶ�������ʵ�ʴ����Ǹ���CMP������
;LAST3:
    ;CMP AL,100
    ;JC LAST2    ;���<100������ת��LAST2���бȽ�ʮλ
    ;SUB AL,100  ;��100
    ;INC COUNT3  ;��λ����
    ;LOOP LAST3
   
LAST2:
    CMP AL,10
    JC LAST1    ;���<10������ת��LAST1���бȽϸ�λ
    SUB AL,10   ;��10
    INC COUNT2  ;ʮλ����
    LOOP LAST2
LAST1:
    CMP AL,0
    JNA NEXT2
    ;JNA NEXT3    ;���<=0������ת��NEXT�������
    SUB AL,1    ;��1
    INC COUNT1  ;��λ����
    LOOP LAST1
   
;NEXT3:
    ;ADD COUNT3,30H
    ;MOV DL,COUNT3   ;�����λ
    ;MOV AH,02H
    ;INT 21H
   
NEXT2:
    ADD COUNT2,30H
    MOV DL,COUNT2   ;���ʮλ
    MOV AH,02H
    INT 21H
   
NEXT1:
    ADD COUNT1,30H
    MOV DL,COUNT1
    MOV AH,02H
    INT 21H
   
    MOV AH,4CH
    INT 21H
  
CODES  ENDS
    END  START

