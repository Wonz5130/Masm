DATA SEGMENT USE16

MESG1 DB 0DH,0AH
      DB 'Please enter your username:$'
LL EQU $-MESG1
BUF DB 30
    DB ?
    DB 30 DUP(?)
BUF1 DB 6 DUP(?)
MIMA DB '666666'
WA DB 'Wrong Answer!$'
AC DB 'Welcome!$'
USER DB 'wonz'
WU DB 'Wrong Username$'
PASSWORD DB 'Please enter your password:$'
BUF2 DB 4 DUP(?)
COUNT DB 3

DATA ENDS

CODE SEGMENT USE16
     ASSUME CS:CODE,DS:DATA,ES:DATA  ;ES附加段也要,待显示字符放进ES
     
BEG:
     MOV AX,DATA
     MOV DS,AX
     MOV ES,AX  ;AX传给ES
     MOV AX,0003H
     INT 10H
     
  
    
AGAIN1:
	 ;MOV AX,0003H
	 ;INT 10H
	 ;MOV DH,12
	 ;MOV DL,(80-LL)/2
	 MOV AH,09H
     MOV DX,OFFSET MESG1 ;取偏移地址
     INT 21H
     MOV AX,1301H
     MOV BL,01001111B
     MOV CX,LL
     MOV DH,12
	 MOV DL,(80-LL)/2
     MOV BX,OFFSET BUF2
     MOV CX,4

;判断用户名是否正确 
LAST1:
     MOV AH,01H  ;输入4位用户名
     INT 21H     
     MOV [BX],AL ;低位传给BX
     INC BX      ;BX后移一位,一共移4次
     LOOP LAST1
     
     MOV DI,OFFSET BUF2
     MOV SI,OFFSET USER
     CLD
     MOV CX,4    ;比较4次
     REPE CMPSB  ;字符串比较,包括CX-1
     JZ AGAIN2   ;ZF=1，表示一样，跳到AGAIN2
     
     MOV AH,2
     MOV DL,0AH  ;换行
     INT 21H
     
     MOV AH,09H
     MOV DX,OFFSET WU
     INT 21H
     DEC COUNT
     JZ EXIT
     JMP AGAIN1  ;再输入一次用户名


AGAIN2:
	 MOV AH,2	
     MOV DL,0AH
     INT 21H
	 MOV AH,09H
	 MOV DX,OFFSET PASSWORD
	 INT 21H
     MOV BX,OFFSET BUF1
     MOV CX,6
     MOV COUNT,3


;判断密码是否错误   
LAST2:
     MOV AH,07H  ;不回显字符
     INT 21H     ;光标下移一行
     MOV [BX],AL ;低位传给BX
     MOV AH,02H  ;显示字符
     MOV DL,'*'
     INT 21H
     INC BX      ;BX后移一位,一共移6次
     LOOP LAST2
     
     MOV DI,OFFSET BUF1
     MOV SI,OFFSET MIMA
     CLD
     MOV CX,6    ;比较6次
     REPE CMPSB  ;字符串比较
     JZ RIGHT    ;ZF=1，表示一样，跳到RIGHT
     MOV AH,2
     MOV DL,0AH
     INT 21H
     
     MOV AH,09H
     MOV DX,OFFSET WA
     INT 21H
     DEC COUNT  ;计数,输错三次密码就退出
     JZ EXIT
     JMP AGAIN2

RIGHT:
	 MOV AH,2
     MOV DL,0AH
     INT 21H
     MOV AH,09H
     MOV DX,OFFSET AC
     INT 21H

EXIT:
     MOV AH,4CH
     INT 21H  ;返回 DOS
     
CODE ENDS
     END BEG
