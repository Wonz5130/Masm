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
    MOV BX,OFFSET NUM  ;加上 USE16 就不报错
    ;LEA BX,NUM  ;取 NUM 的偏移地址
    MOV CX,9
    MOV DL,0
    MOV AL,BYTE PTR [BX]  ;放MIN
    MOV MIN,AL
    
LAST:
    CMP [BX],AL  ;比较MIN
    JGE NEXT1  ;有符号数大于等于跳 NEXT1
    MOV AL,[BX]
NEXT1:
    CMP BYTE PTR [BX],0   ;比较负数
    JGE NEXT2
    INC DL
NEXT2:
    INC BX
    LOOP LAST
    MOV MIN,AL
    ADD DL,30H  ;输出负数的十进制个数
    MOV AH,2
    INT 21H
    MOV AH,2
    MOV DL,0AH  ;换行
    INT 21H
    ;负数取整
    CMP MIN,0
    JGE AGAIN
    MOV AH,02H  ;输出负号
    MOV DL,2DH
    INT 21H
    NEG MIN
    
AGAIN:
    MOV AX,WORD PTR MIN
    MOV BX,10  ;除数10→BX
    MOV CX,0   ;计数初值0→CX
AGAIN1:
    MOV DX,0   ;0→DX
    DIV BX     ;商→AX，余数→DX
    PUSH DX    ;余数压栈
    INC CX     ;统计除法的次数
    CMP AX,0
    JNZ AGAIN1  ;商不为0转

AGA:
    POP DX      ;余数→DX
    ADD DL,30H
    MOV AH,2
    INT 21H
    LOOP AGA
    MOV AH,4CH
    INT 21H
CODE ENDS
    END START



