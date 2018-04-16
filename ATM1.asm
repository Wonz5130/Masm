DATA SEGMENT USE16   

MESG DB 0DH,0AH
     DB 'Please enter your password:$' ;一共28个字符
BUF1 DB 6 DUP(?)
BUF2 DB '666666'
BUF3 DB 'Wrong Answer!$'
BUF4 DB 'Accepted!$'
COUNT DB 3

DATA ENDS

CODE SEGMENT USE16
     ASSUME CS:CODE,DS:DATA,ES:DATA  ;ES附加段也要
     
BEG:
     MOV AX,DATA
     MOV DS,AX
     MOV ES,AX  ;AX传给ES

AGAIN:
     MOV AH,09H
     MOV DX,OFFSET MESG ;取偏移地址
     INT 21H
     MOV BX,OFFSET BUF1
     MOV CX,6
     
LAST:
     MOV AH,07H
     INT 21H     ;光标下移一行
     MOV [BX],AL ;低位传给BX
     MOV AH,02H  ;显示字符
     MOV DL,'*'
     INT 21H
     INC BX      ;BX后移一位,一共移6次
     LOOP LAST
     
     MOV DI,OFFSET BUF1
     MOV SI,OFFSET BUF2
     CLD
     MOV CX,6    ;比较6次
     REPE CMPSB  ;字符串比较
     JZ RIGHT    ;ZF=1，表示一样，跳到RIGHT
     MOV AH,09H
     MOV DX,OFFSET BUF3
     INT 21H
     DEC COUNT
     JZ EXIT
     JMP AGAIN

RIGHT:
     MOV AH,09H
     MOV DX,OFFSET BUF4
     INT 21H

EXIT:
     MOV AH,4CH
     INT 21H  ;返回 DOS
     
CODE ENDS
     END BEG
