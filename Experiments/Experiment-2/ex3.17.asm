DATA SEGMENT USE16

BUF DB 4 DUP(?)
Notation DB 'Please enter your tongxinzi:$'
tongxinzi DB 'wonz'
WA DB 'Wrong tongxinzi!$'
AC DB 'Welcome!'
LL EQU $-AC
COUNT DB 3  ;只允许输 3 次

DATA ENDS

CODE SEGMENT USE16
     ASSUME CS:CODE,DS:DATA,ES:DATA  ;ES附加段也要,待显示字符放进ES
     
BEG:
     MOV AX,DATA
     MOV DS,AX
     MOV ES,AX  ;AX传给ES
    
AGAIN:
	 MOV AH,09H
	 MOV DX,OFFSET Notation  ;输出提示语句
	 INT 21H
     MOV BX,OFFSET BUF
     MOV CX,4  ;输入四个符号

;判断通信字是否正确 
LAST:
     MOV AH,07H  ;不回显字符，不响应Ctrl_C
     INT 21H     
     MOV [BX],AL ;低位传给BX
     MOV AH,02H  ;显示字符
     MOV DL,'*'
     INT 21H
     INC BX      ;BX后移一位,一共移4次
     LOOP LAST
     
     MOV DI,OFFSET BUF
     MOV SI,OFFSET tongxinzi
     MOV CX,4    ;比较4次
     REPE CMPSB  ;字符串比较
     JZ RIGHT    ;ZF=1，表示一样，跳到RIGHT
     MOV AH,2
     MOV DL,0AH  ;换行
     INT 21H
     
     MOV AH,09H
     MOV DX,OFFSET WA  ;输出错误通信字
     INT 21H
     MOV AH,2
     MOV DL,0AH  ;换行
     INT 21H
     DEC COUNT  ;计数,输错三次通信字就退出
     JZ EXIT
     JMP AGAIN

RIGHT:
	 MOV AH,2
     MOV DL,0AH  ;换行
     INT 21H
     MOV AH,09H
     MOV DX,OFFSET AC  ;输出欢迎
     INT 21H

COLOR:
    MOV AX,0003H   ;80*25彩色文本方式
    INT 10H
    MOV AX,1301H  ;显示彩色字符串
    MOV BX,0047H  ;红色背景，灰白色字体
    MOV CX,LL
    MOV DH,12   ;一共 25 行，中央显示
    MOV DL,(80-LL)/2    ;80列，中央显示
    LEA BP,AC
    INT 10H         ;调用 BIOS 中断INT 10H的13H号功能，居中彩显

EXIT:
     MOV AH,4CH
     INT 21H  ;返回 DOS
     
CODE ENDS
     END BEG

