
; el usuario ingresa un numero del 1 al 9 y se presenta su numero correspondiente en ROMANOS
%macro imprimir 2 
	mov eax, 4 
	mov ebx, 1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

%macro leer 2 
	mov eax, 3 
	mov ebx, 2
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

section .data
	msj db "INgrese 1 numero",10
	len_msj equ $-msj
	msj1 db "El numero es romanos es..",10
	len_msj1 equ $-msj1
	

		uno db 0,'I',0
		dos db 0,'II',0
		tres db 0,'III',0
		cuatro db 0,'IV',0
		cinco db 0,'V',0
		seis db 0,'VI',0
		siete db 0,'VII',0
		ocho db 0,'VIII',0
		nueve db 0,'IX',0
section .bss
	respuesta resb 2
	
section .text
		global _start

_start:
	imprimir msj, len_msj
	leer respuesta, 2
	mov al,[respuesta]
	
	push eax
	imprimir msj1,len_msj1 
	pop eax
	sub al,'0'
	
	cmp al,1
	je imprimir_1
	cmp al,2
	je imprimir_2
	cmp al,3
	je imprimir_3
	cmp al,4
	je imprimir_4
	cmp al,5
	je imprimir_5
	cmp al,6
	je imprimir_6
	cmp al,7
	je imprimir_7
	cmp al,8
	je imprimir_8
	cmp al,9
	je imprimir_9
	
	jmp salir
	
imprimir_1:
	imprimir uno,2
	jmp salir
imprimir_2:
	imprimir dos,3
	jmp salir
imprimir_3:
	imprimir tres,4
	jmp salir
imprimir_4:
	imprimir cuatro,3
	jmp salir
imprimir_5:
	imprimir cinco,2
	jmp salir
imprimir_6:
	imprimir seis,3
	jmp salir
imprimir_7:
	imprimir siete,4
	jmp salir
imprimir_8:
	imprimir ocho,5
	jmp salir
imprimir_9:	
	imprimir nueve,3
	jmp salir

salir:
	mov eax,1
	mov ebx,0
	int 80h
	
