;el programa produce un delay de 5 segundos de espera
section .data

  timeval:
    segundo  dd 0
    nanosegundo dd 0

  msg1  db "Esperando", 10, 0
  len_msg1 equ $ - msg1

  msg2  db "Fin", 10, 0
  len_msg2 equ $ - msg2


section .text
	global  _start


_start:
  ;presenta 'Esperando'
  mov eax, 4
  mov ebx, 1
  mov ecx, msg1
  mov edx, len_msg1
  int 0x80

  ; duerme por 5 segundos y 0 nanosegundos
  mov dword [segundo], 5
  mov dword [nanosegundo], 0
  mov eax, 162  ; usa 	sys_nanosleep 
  mov ebx, timeval
  mov ecx, 0
  int 0x80

  ; presenta "Fin"
  mov eax, 4
  mov ebx, 1
  mov ecx, msg2
  mov edx, len_msg2
  int 0x80

  mov eax, 1
  mov ebx, 0
  int 0x80

