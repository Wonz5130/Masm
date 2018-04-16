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
    MOV CX,8   ;2进制，8位寄存器，共8个bit，需要循环8次
AGAIN:
    ROL SUM,1  ;不含进位的循环左移，把SUM最高1位，移到最低1位，供输出用
    JC PRINT1  ;如果CF=1，跳转到PRINT1
    ;CF=0
    MOV DL,30H ;把'0'传到DL中
    MOV AH,02H ;用功能号02H，显示字符
    INT 21H
    JMP NEXT
PRINT1:
    MOV DL,31H ;把'1'传入DL中
    MOV AH,02H
    INT 21H
NEXT:
    LOOP AGAIN ;循环
    
    MOV AH,4CH ;程序执行完毕，退出到系统
    INT 21H
   
CODES  ENDS
    END  START
