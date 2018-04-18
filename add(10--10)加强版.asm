DATAS  SEGMENT USE16
      SUM DW ?
      COUNT1 DB 0
      COUNT2 DB 0
      COUNT3 DB 0
DATAS  ENDS
STACKS  SEGMENT USE16
STACKS  ENDS
CODES  SEGMENT
     ASSUME    CS:CODES,DS:DATAS,ES:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV ES,AX
    ;MOV AX,0003H ;80*25彩色文本方式
    ;INT 10H
    ;MOV DH,12       ;在中央显示
    ;MOV DL,39
    ;INT 10H
    MOV AL,11
    ADD AL,20
    MOV CX,100   ;假设一个移动次数，实际次数是根据CMP决定的
    
LAST3:
    CMP AL,100
    JC LAST2    ;如果<100，就跳转到LAST2进行比较十位
    SUB AL,100  ;减100
    INC COUNT3  ;百位计数
    LOOP LAST3
   
LAST2:
    CMP AL,10
    JC LAST1    ;如果<10，就跳转到LAST1进行比较个位
    SUB AL,10   ;减10
    INC COUNT2  ;十位计数
    LOOP LAST2
LAST1:
    CMP AL,0
    JNA NEXT3    ;如果<=0，就跳转到NEXT进行输出
    SUB AL,1    ;减1
    INC COUNT1  ;个位计数
    LOOP LAST1
   
NEXT3:
      ADD COUNT3,30H
    ;MOV DL,0  ;不用清0
    CMP COUNT3,30H  ;如果百位没有数，就跳转到NEXT2，不输出0，是和0的ASCII:30H比较
    JNA NEXT2
    
    MOV DL,COUNT3   ;如果百位有数，就输出
    MOV AH,02H
    INT 21H
   
NEXT2:
    ADD COUNT2,30H
    ;MOV DL,0  ;不用清0
    CMP COUNT2,30H  ;如果十位没有数，就跳转到NEXT21，是和0的ASCII:30H比较
    JNA NEXT21
NEXT22:
    MOV DL,COUNT2   ;如果十位有数，就输出
    MOV AH,02H
    INT 21H
    JMP NEXT1       ;输出十位直接跳到NEXT1输出个位，没有JMP会循环输出十位
NEXT21:
    CMP COUNT3,30H
    JNA NEXT1     ;百位、十位都没数，跳到NEXT1输出个位
    JMP NEXT22    ;百位有数，十位没数，要输出十位0
   
NEXT1:
    ADD COUNT1,30H
    MOV DL,COUNT1
    MOV AH,02H
    INT 21H
    MOV AH,4CH
    INT 21H
  
CODES  ENDS
    END  START
