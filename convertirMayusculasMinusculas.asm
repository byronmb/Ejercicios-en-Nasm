; el programa convierte una cadena de texto a mayusculas o a minusculas
section .data
	opcion db "1. Convertir de minùsculas en mayùsculas",10,0,
		   db "2. Convertir de mayùsculas en minùsculas",10,0,
		   db "Seleccione una opcion...",10,0
	len_opcion equ $-opcion
	
	cadena db "hola COMO estas",10,0
	len_cadena equ $-cadena
section .bss
	seleccion resb 2	
section .text
	global _start

_start: 
	
	mov eax, 4
	mov ebx, 1
	mov ecx, opcion
	mov edx, len_opcion
	int 80h
	
	mov eax, 3
	mov ebx, 2
	mov ecx, seleccion
	mov edx, 2
	int 80h
	
	mov al,[seleccion]
	
	mov ecx, cadena
	
	cmp al,"1"
	je mayuscula
	cmp al,"2"
	je minuscula 
	
	
mayuscula:

        mov al,[ecx]      ; [ecx] es el caracter actual
        cmp al,0 
        je imprimir   ;si son iguales
        cmp al,'a'
        jb siguienteMay  ;salta si al es menor que 'a'
        cmp al,'z'
        ja siguienteMay	;salta si el valor de al es mayor a 'z'
        sub al,32       ; convierto en mayuscula
        mov [ecx],al      ; se devuelve a la cadena el valor nuevo

siguienteMay:
        inc ecx           ;se incrementa para apuntar al siguiente caracter
        jmp mayuscula
        
minuscula:
        mov al,[ecx]      
        cmp al,0 
        je imprimir  
        cmp al,'A'
        jb siguienteMin  
        cmp al,'Z'
        ja siguienteMin	
        add al,32       ; convierto en minuscula
        mov [ecx],al      
  
  
siguienteMin:
        inc ecx           
        jmp minuscula        

imprimir:  
		mov eax, 4
		mov ebx, 1
		mov ecx, cadena    
        mov edx, len_cadena
        int 80h
        


	mov eax,1
    mov ebx,0
    int 80h
