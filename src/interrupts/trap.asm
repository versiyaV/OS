
section .text
extern handler
global vector0  ;divide by zero
global vector1  ;debug exception step by step
global vector2  ;hardware reserved interrupt by coprocessor
global vector3  ;debug exception - breakpoint 0xCC
global vector4  ;overflow
global vector5  ;print screen
global vector6  ;hardware reserved - not defined code operation
global vector7  ;hardware reserved - not coprocessor
global vector8  ;IRQ0 - timer interrupt
global vector10 ;IRQ2 - keyboard interrupt
global vector11 ;IRQ3 - hardware interrupt
global vector12 ;IRQ4 - COM2
global vector13 ;IRQ5 - COM3
global vector14 ;IRQ6 - hard disk drive
global vector16 ;keyboard
global vector17 ;printer
global vector18 ;start basic on 
global vector19 ;restart OS
global vector32 ;poweroff programm
global vector33
global vector39 ;create directory
global sysint
global eoi      ;end of interrupt signal
global read_isr ;interrupt service routine
global load_idt
global load_cr3
global pstart
global read_cr2
global read_cr3
global swap
global TrapReturn
global in_byte

Trap:
    push rax
    push rbx  
    push rcx
    push rdx  	  
    push rsi
    push rdi
    push rbp
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15

    mov rdi,rsp
    call handler

TrapReturn:
    pop	r15
    pop	r14
    pop	r13
    pop	r12
    pop	r11
    pop	r10
    pop	r9
    pop	r8
    pop	rbp
    pop	rdi
    pop	rsi  
    pop	rdx
    pop	rcx
    pop	rbx
    pop	rax       

    add rsp,16
    iretq



vector0:
    push 0
    push 0
    jmp Trap

vector1:
    push 0
    push 1
    jmp Trap

vector2:
    push 0
    push 2
    jmp Trap

vector3:
    push 0
    push 3	
    jmp Trap 

vector4:
    push 0
    push 4	
    jmp Trap   

vector5:
    push 0
    push 5
    jmp Trap    

vector6:
    push 0
    push 6	
    jmp Trap      

vector7:
    push 0
    push 7	
    jmp Trap  

vector8:
    push 8
    jmp Trap  

vector10:
    push 10	
    jmp Trap 
                   
vector11:
    push 11	
    jmp Trap
    
vector12:
    push 12	
    jmp Trap          
          
vector13:
    push 13	
    jmp Trap
    
vector14:
    push 14	
    jmp Trap 

vector16:
    push 0
    push 16	
    jmp Trap          
          
vector17:
    push 17	
    jmp Trap                         
                                                          
vector18:
    push 0
    push 18	
    jmp Trap 
                   
vector19:
    push 0
    push 19	
    jmp Trap

vector32:
    push 0
    push 32
    jmp Trap

vector33:
    push 0
    push 33
    jmp Trap

vector39:
    push 0
    push 39
    jmp Trap

sysint:
    push 0
    push 0x80
    jmp Trap

eoi:
    mov al,0x20
    out 0x20,al
    ret

read_isr:
    mov al,11
    out 0x20,al
    in al,0x20
    ret

load_idt:
    lidt [rdi]
    ret

load_cr3:
    mov rax,rdi
    mov cr3,rax
    ret

read_cr2:
    mov rax,cr2
    ret

read_cr3:
    mov rax,cr3
    ret

pstart:
    mov rsp,rdi
    jmp TrapReturn

swap:
    push rbx
    push rbp
    push r12
    push r13
    push r14
    push r15
    
    mov [rdi],rsp
    mov rsp,rsi
    
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    pop rbx
    
    ret

in_byte:
    mov rdx,rdi
    in al,dx
    ret

