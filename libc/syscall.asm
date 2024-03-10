section .text
global writeu
global sleepu
global exitu
global waitu
global keyboard_readu
global get_total_memoryu
global memset
global memcpy
global memmove
global memcmp

; libc function
memset:
    cld
    mov ecx,edx
    mov al,sil
    rep stosb
    ret

memcmp:
    cld
    xor eax,eax
    mov ecx,edx
    repe cmpsb
    setnz al
    ret

memcpy:
memmove:
    cld
    cmp rsi,rdi
    jae .copy
    mov r8,rsi
    add r8,rdx
    cmp r8,rdi
    jbe .copy

.overlap:
    std
    add rdi,rdx
    add rsi,rdx
    sub rdi,1
    sub rsi,1

.copy:
    mov ecx,edx
    rep movsb
    cld
    ret


;syscall
writeu:
    sub rsp,16
    xor eax,eax

    mov [rsp],rdi
    mov [rsp+8],rsi

    mov rdi,2
    mov rsi,rsp
    int 0x80

    add rsp,16
    ret

sleepu:
    sub rsp,8
    mov eax,1

    mov [rsp],rdi
    mov rdi,1
    mov rsi,rsp
    int 0x80

    add rsp,8
    ret

exitu:
    mov eax,2
    mov rdi,0
    int 0x80
    ret

waitu:
    mov eax, 3
    mov rdi,0
    int 0x80
    ret

keyboard_readu:
    mov eax,4
    xor edi,edi
    int 0x80
    ret

get_total_memoryu:
    mov eax,5
    xor edi,edi
    int 0x80
    ret