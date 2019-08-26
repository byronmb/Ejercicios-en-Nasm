; muestra todos los caracteres ASCII imprimibles válidos (32-126) y una nueva línea después.  
section .bss
	caracter resb 1  
section  .text
    global _start   

_start:                

    mov byte [caracter], ' '   ; primer ASCII imprimible válido (espacio)
siguiente:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, caracter
    mov     edx, 1
    int     0x80
    
    inc     byte [caracter]
    cmp     byte [caracter], 126
    jbe     siguiente        ; repita hasta que se impriman todos los caracteres

    ; mostrar un carácter más, nueva línea (reutilización de registros)
    mov     byte [caracter], `\n`  
    mov     eax, 4      
    int     0x80
    
    mov     eax,1       
    int     0x80       


