section .data
	handle: dd 0

section .bss
	buffer: resb 64

section .text
global _start


_start:
	pop ebx
	pop ebx
	pop ebx
	;open
	mov eax,5 
	mov ecx,0
	int 0x80
	mov [handle],eax

read:
	mov eax,3
	mov ebx,[handle]
	mov ecx,buffer
	mov edx,1
	int 0x80
	cmp eax,0
	je _exit

write:
	mov eax,4
	mov ebx,1
	mov ecx,buffer
	mov edx,1
	int 0x80
	jmp read

	
_exit:
	mov ebx,[handle]
	mov eax,6
	int 0x80
	mov eax,1
	mov ebx,0
	int 0x80	

