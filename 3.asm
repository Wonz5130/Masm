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
    MOV CX,16  ;2进制，16位寄存器，共16个bit，需要循环16次
    MOV AH,0EH ;使用INT 10H的输出功能,0EH显示一个字符
p1:
    ROL BX,1   ;把BX最高1位，移到最低1位，供输出用
    MOV AL,BL  ;把BL拷贝到AL，供输出用
    AND AL,1   ;只保留最低1位的值，即刚才BX中最高位的值
    XOR AL,30h ;转换为ascII值'0',或'1'
    INT 10H    ;调用10H中断，输出到屏幕上
    LOOP p1    ;循环
   
    MOV AH,4CH ;程序执行完毕，退出到系统
    INT 21H
   
CODES  ENDS
    END  START

