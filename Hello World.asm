;完整段的Hello World程序
DATA  SEGMENT
     STRING  DB  'Hello World!',13,10,'$'
DATA  ENDS

CODE  SEGMENT
     ASSUME    CS:CODE,DS:DATA
START:
     MOV  AX,DATA
     MOV  DS,AX
     LEA  DX,STRING
     MOV  AH,9
     INT  21H
   
     MOV  AH,4CH
     INT  21H
CODE  ENDS
    END   START
