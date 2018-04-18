DATA   SEGMENT                 
    DECNUM   DB   5 DUP(?)    
DATA    ENDS  
CODE    SEGMENT                   
   ASSUME CS:CODE,DS:DATA  
START:   
    MOV  AX,DATA  
    MOV  DS,AX   
    MOV  BX,65530 ; 要转换的值  
    LEA  SI,DECNUM  
    
    MOV  DX,0    
    MOV  AX,BX  
    MOV  CX,10000  
    DIV  CX  
    MOV  [SI],AL; 求得万位的值, 存入指定单元  
    
    INC  SI  
    MOV  AX,DX ; 上次计算的余数存在 DX 中  
    MOV  DX,0  
    MOV  CX,1000                  
    DIV  CX  
    MOV  [SI],AL; 求得千位的值, 存入指定单元  
    
    INC  SI  
    MOV  AX,DX  
    MOV  DX,0  
    MOV  CX,100  
    DIV  CX  
    MOV  [SI],AL; 求得百位的值, 存入指定单元  
    
    INC  SI  
    MOV  AX,DX  
    MOV  CL,10  
    DIV  CL  
    MOV  [SI],AL; 求得十位的值, 存入指定单元  
    
    INC  SI  
    MOV  [SI],AH ; 此时, 余数就是个位的值,  
    LEA  SI,DECNUM  ; 以下代码开始显示存储在存储单元中的十进制数  
    MOV  CX,5  
DISP:     
    MOV DL,[SI] ; 依次取出十进制数各位的值  
    OR  DL,30H  ; 将取出的值转换为 ASCII 值  
    MOV  AH,2  
    INT  21H    ; 利用 DOS 功能调用, 显示  
    INC  SI  
    LOOP  DISP  
    MOV  DL,'D'  
    MOV  AH,2  
    INT  21H  
    MOV  AH,4CH  
    INT  21H  
CODE    ENDS  
    END     START 
