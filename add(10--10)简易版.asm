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
    MOV CX,100  ;假设一个移动次数，实际次数是根据CMP决定的
;LAST3:
    ;CMP AL,100
    ;JC LAST2    ;如果<100，就跳转到LAST2进行比较十位
    ;SUB AL,100  ;减100
    ;INC COUNT3  ;百位计数
    ;LOOP LAST3
   
LAST2:
    CMP AL,10
    JC LAST1    ;如果<10，就跳转到LAST1进行比较个位
    SUB AL,10   ;减10
    INC COUNT2  ;十位计数
    LOOP LAST2
LAST1:
    CMP AL,0
    JNA NEXT2
    ;JNA NEXT3    ;如果<=0，就跳转到NEXT进行输出
    SUB AL,1    ;减1
    INC COUNT1  ;个位计数
    LOOP LAST1
   
;NEXT3:
    ;ADD COUNT3,30H
    ;MOV DL,COUNT3   ;输出百位
    ;MOV AH,02H
    ;INT 21H
   
NEXT2:
    ADD COUNT2,30H
    MOV DL,COUNT2   ;输出十位
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

