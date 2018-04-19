DATA SEGMENT USE16
    BUF DW 987AH
DATA ENDS
CODE SEGMENT USE16

ASSUME  CS:CODE,DS:DATA

BEG:
	MOV AX,DATA
    MOV DS,AX
    MOV DX,10
    ADD DX,20
    MOV CX,4
    SAL EDX,16  ;左移16位，一共有32位
    
AGA: 
	ROL EDX,4   ;不含进位循环左移四位，即取出前两个元素
    AND DL,0FH  ;让第一位清0，截取四位二进制数
    CMP DL,10   ;判断范围，转换为ASCII码
    JC NEXT     ;<10跳转
    ADD DL,7    ;>=10，就加上7，表示A-F
    
NEXT:
	ADD DL,30H
    MOV AH,2
    INT 21H  ;显示字符
    LOOP AGA
    MOV AH,4CH
    INT 21H
    
CODE ENDS
     END BEG
