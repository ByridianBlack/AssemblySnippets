format ELF64 executable 3
entry start

segment readable executable writeable


struc obj{
    .x dd ?
    .y dd ?
}


struc network{
    .client_fd dd ?
    .server_fd dd ?
    
}


obj1 obj
start:
    
    
    push 0xdeadbeef

    
    xor rdi, rdi
    mov rax, 0x3c
    
    syscall

