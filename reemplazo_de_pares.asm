;el programa cuenta de numeros del 1 al 9, y reeemplaza a todos los numeros pares por el mensaje "Numero par"

%macro escribir 2
	mov eax, 4 
	mov ebx, 1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

section .data
	msj1 db 'Numeros:',10
	len_msj1 equ $-msj1
	
	msj_enter db 10, ' '
	;len_mj1 equ $-enter
	
	cadena db 'Numero par'
	len_cadena equ $-cadena
section .bss
		numero resb 3
	
section .text
		global _start
_start:		

	escribir msj1, len_msj1
	
	mov ecx,1 ;comienza en 1
	
presentar_numero:	
	add ecx,48  ;entero a ascii
	mov [numero], ecx
	sub ecx,48
	
	
	push ecx  
	and ecx,1  ; para saber si el numero es par 
	jz presentar_cadena ;si es par se va a presentar_cadena
	
	escribir numero, 2   ; si no es par presenta el numero
	escribir msj_enter,1
	jmp recuperar  ;envia a la opcion recuperar para recuperar el valor de ecx y para incrementar

presentar_cadena:
	escribir cadena, len_cadena
	escribir msj_enter,1
	jmp recuperar
	
recuperar:
	pop ecx
	inc ecx
	cmp ecx,10
	je salir  ; si ecx =10 se va a la opcion salir
	
	jmp presentar_numero
salir:	
	mov eax,1
	mov ebx,0
	int 80h
