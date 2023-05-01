format ELF64 executable 3
entry start

segment readable executable writeable


struc obj{
    .x dd 123
    .y dd 123
}


obj1 obj
start:

    
    sub rsp, 8
    

    lea rdi, [obj1.x]
    mov DWORD [edi], 0xdeadbeef

    lea rdi, [obj1.y]
    mov DWORD [edi], 0xbeefdead

    
    xor rdi, rdi
    ; mov [rdi]
    add rsp, 8
    mov rax, 0x3c
    
    syscall

