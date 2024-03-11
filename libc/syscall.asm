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
global open_file
global read_file
global get_file_size
global close_file
global fork

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
    sub rsp,8
    mov eax, 3
    mov [rsp],rdi
    mov rdi,1
    mov rsi,rsp

    int 0x80
    add rsp,8

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

open_file:
    sub rsp,8
    mov eax,6

    mov [rsp],rdi
    mov rdi,1
    mov rsi,rsp

    int 0x80

    add rsp,8

    ret

read_file:
    sub rsp,24
    mov eax,7

    mov [rsp],rdi
    mov [rsp+8],rsi
    mov [rsp+16],rdx

    mov rdi,3
    mov rsi,rsp
    
    int 0x80

    add rsp,24
    ret

get_file_size:
    sub rsp,8
    mov eax,8

    mov [rsp],rdi
    mov rdi,1
    mov rsi,rsp

    int 0x80

    add rsp,8

    ret

close_file:
    sub rsp,8
    mov eax,9

    mov [rsp],rdi
    mov rdi,1
    mov rsi,rsp

    int 0x80

    add rsp,8

    ret

fork:
    mov eax,10
    xor edi,edi
    int 0x80
    ret
