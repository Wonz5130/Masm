DATA   SEGMENT                 
    DECNUM   DB   5 DUP(?)    
DATA    ENDS  
CODE    SEGMENT                   
   ASSUME CS:CODE,DS:DATA  
START:   
    MOV  AX,DATA  
    MOV  DS,AX   
    MOV  BX,65530 ; Ҫת����ֵ  
    LEA  SI,DECNUM  
    
    MOV  DX,0    
    MOV  AX,BX  
    MOV  CX,10000  
    DIV  CX  
    MOV  [SI],AL; �����λ��ֵ, ����ָ����Ԫ  
    
    INC  SI  
    MOV  AX,DX ; �ϴμ������������ DX ��  
    MOV  DX,0  
    MOV  CX,1000                  
    DIV  CX  
    MOV  [SI],AL; ���ǧλ��ֵ, ����ָ����Ԫ  
    
    INC  SI  
    MOV  AX,DX  
    MOV  DX,0  
    MOV  CX,100  
    DIV  CX  
    MOV  [SI],AL; ��ð�λ��ֵ, ����ָ����Ԫ  
    
    INC  SI  
    MOV  AX,DX  
    MOV  CL,10  
    DIV  CL  
    MOV  [SI],AL; ���ʮλ��ֵ, ����ָ����Ԫ  
    
    INC  SI  
    MOV  [SI],AH ; ��ʱ, �������Ǹ�λ��ֵ,  
    LEA  SI,DECNUM  ; ���´��뿪ʼ��ʾ�洢�ڴ洢��Ԫ�е�ʮ������  
    MOV  CX,5  
DISP:     
    MOV DL,[SI] ; ����ȡ��ʮ��������λ��ֵ  
    OR  DL,30H  ; ��ȡ����ֵת��Ϊ ASCII ֵ  
    MOV  AH,2  
    INT  21H    ; ���� DOS ���ܵ���, ��ʾ  
    INC  SI  
    LOOP  DISP  
    MOV  DL,'D'  
    MOV  AH,2  
    INT  21H  
    MOV  AH,4CH  
    INT  21H  
CODE    ENDS  
    END     START 
