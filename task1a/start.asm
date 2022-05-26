section .text
	
global _start
global read
global write
global open
global close
global strlen

extern main
_start:
	;TODO: handles command line input parameters
	mov eax,[esp]; argc
	mov ebx, esp;argv
	add ebx,4;argv[0]
	push ebx; back up first argument
	push eax ; back up argc and preparing for main
	call	main
        mov     ebx,eax
	mov	eax,1
	int 0x80

read:
	push ebp
	mov ebp,esp
	sub esp,4
	pushad
	mov eax,3 ; mark read for kernel
	mov ebx,[ebp+8]
	mov ecx,[ebp+12]
	mov edx,[ebp+16]
	int 0x80
	mov [ebp-4],eax
	popad
        mov eax, [ebp-4]
	add esp,4
	pop ebp
	ret

write:
	push ebp
	mov ebp,esp
	sub esp,4
	pushad
	mov eax,4; mark write for kernel
	mov ebx,[ebp+8]
	mov ecx,[ebp+12]
	mov edx,[ebp+16]
	int 0x80
	mov [ebp-4],eax
	popad
        mov eax, [ebp-4]
	add esp,4
	pop ebp
	ret

open: ; task0
	push ebp
	mov ebp,esp
	sub esp,4
	pushad
	mov eax,5 ; mark open for kernel
	mov ebx,[ebp+8]
	mov ecx, [ebp+12]
	mov edx, 077
	int 0x80
        mov [ebp-4],eax
	popad
        mov eax, [ebp-4]
	add esp,4
	pop ebp
	ret
	
	
close:
	push ebp
	mov ebp,esp
	sub esp,4
	pushad
	mov eax,6 ; mark close for kernel
	mov ebx,[ebp+8]
	int 0x80
	mov [ebp-4],eax
	popad
        mov eax, [ebp-4]
	add esp,4
	pop ebp
	ret
	
	
	
strlen: ; like lab3
	push ebp
	push ebx
	mov ebp,esp
	mov eax,-1
	jmp L2

L2:
	add eax, 1
	mov ecx, eax
	add ecx, [ebp+12]
	movzx	ecx, BYTE [ecx]
	test cl,cl
	jne L2
	mov esp, ebp
	pop ebx
	pop ebp
	ret
	
	
	
