;.586
DATA SEGMENT USE16
NUM DB 2,45,-33,4,-2,5,-8,0,9
MIN DB ?
DATA ENDS

CODE SEGMENT USE16
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    MOV BX,OFFSET NUM  ;���� USE16 �Ͳ�����
    ;LEA BX,NUM  ;ȡ NUM ��ƫ�Ƶ�ַ
    MOV CX,9
    MOV DL,0
    MOV AL,BYTE PTR [BX]  ;��MIN
    MOV MIN,AL
    
LAST:
    CMP [BX],AL  ;�Ƚ�MIN
    JGE NEXT1  ;�з��������ڵ����� NEXT1
    MOV AL,[BX]
NEXT1:
    CMP BYTE PTR [BX],0   ;�Ƚϸ���
    JGE NEXT2
    INC DL
NEXT2:
    INC BX
    LOOP LAST
    MOV MIN,AL
    ADD DL,30H  ;���������ʮ���Ƹ���
    MOV AH,2
    INT 21H
    MOV AH,2
    MOV DL,0AH  ;����
    INT 21H
    ;����ȡ��
    CMP MIN,0
    JGE AGAIN
    MOV AH,02H  ;�������
    MOV DL,2DH
    INT 21H
    NEG MIN
    
AGAIN:
    MOV AX,WORD PTR MIN
    MOV BX,10  ;����10��BX
    MOV CX,0   ;������ֵ0��CX
AGAIN1:
    MOV DX,0   ;0��DX
    DIV BX     ;�̡�AX��������DX
    PUSH DX    ;����ѹջ
    INC CX     ;ͳ�Ƴ����Ĵ���
    CMP AX,0
    JNZ AGAIN1  ;�̲�Ϊ0ת

AGA:
    POP DX      ;������DX
    ADD DL,30H
    MOV AH,2
    INT 21H
    LOOP AGA
    MOV AH,4CH
    INT 21H
CODE ENDS
    END START



