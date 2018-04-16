DATA SEGMENT USE16   
MESG DB 0DH,0AH
     DB 'What is your name ?$' ;一共9个字符
BUF  DB 30 ;程序员预置可容纳的字符个数(包括回车符)
     DB ?  ;随机值
     DB 30 DUP(?) ;开辟30个字节的内存区
DATA ENDS
CODE SEGMENT USE16
     ASSUME CS:CODE,DS:DATA
BEG:
     MOV AX,DATA
     MOV DS,AX
AGAIN:
     MOV AH,9
     MOV DX,OFFSET MESG ;取MESG的偏移地址
     ;LEA DX MESG ;等价于上一句
     INT 21H  ;询问姓名
     MOV AH,0AH ;等待从键盘输入字符串
     MOV DX,OFFSET BUF ;取BUF的偏移地址
     INT 21H  ;接收键入字符串
     MOV BL,BUF+1 ;把实际输入字符个数(不包括回车符)写入BUF+1单元
     MOV BH,0 
     ;实际键入的字符个数->BX
     MOV SI,OFFSET BUF+2 ;输入字符串从BUF+2单元开始依次存放,取偏移地址
     MOV BYTE PTR[BX+SI],'$'  ;用'$'作为串结束符
     MOV AH,2
     MOV DL,0AH ;等待从键盘输入字符串
     INT 21H  ;光标下移一行
     MOV AH,9
     MOV DX,OFFSET BUF+2
     INT 21H  ;复制键入的字符串
     MOV AH,4CH
     INT 21H  ;返回 DOS
CODE ENDS 
     END BEG
