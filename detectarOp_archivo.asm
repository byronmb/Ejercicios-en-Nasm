;el programa llee datos de un archivo y detecta si es suma, resta, multiplicacion o division y lo resuleve
; el archivo debe ser un txt y debe tener datos como:
;EJEMPLO: 2*3=?  o  5/6=?  o  8-3=?  o 7+4=? --> una de esas 4 opciones

section .data
	mensaje db "Leer un archivo en el disco duro",0xa
	len_mensaje equ $-mensaje

	archivo db "/home/byron/Escritorio/archivo.txt",0 ;la direccion del archivo // '0' para finlizar el archivo

section .bss
	texto resb 25 ;variable que almacenara el contenido del archivo
	idarchivo resd 1 ;el identificar que se obtienen el archivo, es el archivo fisico

	operador resb 1
	respuesta resb 2
section .text
		global _start
_start:
	
	mov eax, 5  	;servicio para abrir el archivo
	mov ebx, archivo ;la direccion del archivo
	mov ecx, 0 	;Modo de acceso 0 => read only
	mov edx, 0	;Permisos: permite leer si esta cerrado
	int 80h

	;TESTEAR PARA VER SI ESTA EL ARCHIVO si la direccion no es correcta
	test eax,eax	;modifica las banderas (como el and)
	jz salir
	
	mov dword [idarchivo], eax
	
	mov eax, 4
	mov ebx, 1
	mov ecx, mensaje 
	mov edx, len_mensaje
	int 80h
	
	mov eax, 3	;servicio 3: lectura
	mov ebx, [idarchivo] ;entrada por archivo, 
	mov ecx, texto 
	mov edx, 25
	int 80h
	
	mov cl,[texto+1] ;el signo
	mov [operador],cl
	mov al,[texto+0] ;1er numero
	mov bl,[texto+2] ;seg numero
	sub al,'0'
	sub bl,'0'
	
	cmp cl,'+'
	je suma
	cmp cl,'-'
	je resta
	cmp cl,'*'
	je multi
	cmp cl,'/'
	je division
	
	                                                                                                                   
	mov eax, 6  	;servicio para cerrar el archivo
	mov ebx, [idarchivo] 
	mov ecx, 0 
	mov edx, 0	
	int 80h
	jmp salir
	
suma:
	
	add al, bl
	add al,'0'
	mov  [texto+4], al
	
	mov eax, 4
	mov ebx, 1
	mov ecx, texto 
	mov edx, 25
	int 80h
	jmp salir
resta:
	sub al, bl
	add al,'0'
	mov  [texto+4], al
	
	mov eax, 4
	mov ebx, 1
	mov ecx, texto 
	mov edx, 25
	int 80h
	jmp salir
multi:
	mul bl
	add al,'0'
	mov  [texto+4], al
	
	mov eax, 4
	mov ebx, 1
	mov ecx, texto 
	mov edx, 25
	int 80h
	jmp salir
division:	
	div bl
	add al,'0'
	mov  [texto+4], al
	
	mov eax, 4
	mov ebx, 1
	mov ecx, texto 
	mov edx, 25
	int 80h
salir:	
	mov eax, 1
	mov ebx, 0
	int 80h
