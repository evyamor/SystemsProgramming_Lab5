section .text
	
global _start
global read
global write
global open
global close
global strlen
global utoa_s


extern main
_start:
	;TODO: handles command line input parameters
	mov eax,[esp]
	mov ebx, esp
	add ebx,4
	push ebx
	push eax
	call	main
        mov     ebx,eax
	mov	eax,1
	int 0x80

read:
	push ebp
	mov ebp,esp
	sub esp,4
	pushad
	mov eax,3
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
	mov eax,4
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

open:
	push ebp
	mov ebp,esp
	sub esp,4
	pushad
	mov eax,5
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
	mov eax,6
	mov ebx,[ebp+8]
	int 0x80
	mov [ebp-4],eax
	popad
        mov eax, [ebp-4]
	add esp,4
	pop ebp
	ret
	
	
	
strlen:
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
	
utoa_s:
    push ebp ; stack maintenance
    push ebx
    mov ebp, esp
    mov eax, [ebp+12] ;getting the int
    mov esi, [ebp+16] ; getting the buffer to the string

	transform: 
   	add esi,9
  	 mov byte [esi],0
   	mov ebx,10

    	continue:
    	xor edx,edx         ; Clear edx prior to dividing edx:eax by ebx
    	div ebx             ; eax /= 10
    	add dl,'0'          ; Convert the remainder to ASCII
    	dec esi             ; store characters in reverse order
    	mov [esi],dl
    	test eax,eax
    	jnz continue     ; Repeat until eax==0

    mov eax,esi
    mov esp, ebp
    pop ebx
    pop ebp
    ret

		
	
