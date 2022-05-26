section .data
    handle: dd 0
    msg: db "  appearances of the word in the file ", 10
section .bss
    buffer: resb 64
    buffer_word: resb 16

section .text
global _printflagws
extern utoa_s


_printflagws:
    pop edx; keeping word to find
    mov [buffer_word],edx
    mov esi,buffer_word
    push ebp
    push ebx
    mov ebp, esp
    mov ebx, [ebp + 12]
    push 0
    push ebx
    call	openw
    pop edx
    pop edx
    mov [handle], eax
    xor ecx, ecx ; reseting our counter

.L3:
    push 1
    push buffer
    call readw
    pop edx
    pop edx
    cmp eax, 0 ; EOF? 
    je _exitw
    xor edx, edx
    movzx edx , byte [buffer]
    movzx esi,byte[esi]
    cmp edx, esi 
    je .increase
    jne .backward
    test esi,esi
    jnz .L3
    inc ecx
    jmp .L3

.increase:
     inc esi
    jmp .L3

.backward:
	dec esi
	jmp .L3

readw:
    push ebp ; stack maintenance
    push ebx
    push ecx
    mov ebp, esp

    mov eax, 3
    mov ebx, [handle]
    mov ecx, [ebp+16]
    mov edx, [ebp+20]
    jmp finishw


openw:
    push ebp ; stack maintenance
    push ebx
    push ecx
    mov ebp, esp
    mov eax, 5
    mov ebx, [ebp+16] ; filename
    mov ecx, [ebp+20] ; readonly(0)
    mov edx, 0777 ; file permissions
    jmp finishw

finishw:
    int 0x80
    mov esp, ebp
    pop ecx
    pop ebx
    pop ebp
    ret

close:
    push ebp ; stack maintenance
    push ebx
    push ecx
    mov ebp, esp
    mov eax, 6 ; opcode for close
    mov ebx, [handle] ; fs we want to close
    jmp finishw

_exitw:
    call close ;closing file
    push buffer ;for utoa_S
    push ecx ;counter
    call utoa_s ;translating counter to string and storing it in buffer
    pop edx ;pop counter
    pop edx ; pop buffer
    push eax ;utoa STR
    call strlen ;putting strlen in eax
    pop edx ; we have utoa STR in edx
    push eax ;pushing strlen
    push edx ;pushing utoa STR
    call writew ;printing UTOA STR
    pop eax
    pop edx
    push 37
    push msg
    call writew
    mov esp, ebp
    pop ebx
    pop ebp
    ret

writew:
    push ebp ; stack maintenance
    push ebx
    push ecx
    mov ebp, esp
    mov eax, 4 ; opcode for write
    mov ebx, 1 ; write to stdout
    mov ecx, [ebp+16] ; buffer
    mov edx, [ebp+20] ; how many chars
    jmp finishw



strlen:
    push	ebp
    push	ebx
    mov	ebp, esp
    mov	eax,-1

.L:
    add eax, 1
    mov ebx, eax
    add ebx, [ebp+12]
    movzx	ebx, BYTE [ebx]
    test bl,bl
    jne .L
    mov esp, ebp
    pop ebx
    pop ebp
    ret
