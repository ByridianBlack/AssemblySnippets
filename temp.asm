
format ELF64 executable 3
entry start

segment readable executable writeable

start:
    xor rax, rax
    inc rax
    xor rdi, rdi
    inc rdi
    mov rsi, hello
    mov rdx, 12
    syscall
exit_routine:
    xor rax, rax
    mov rax, 0x3c
    xor rdi, rdi
    mov rdi, 0x44
    syscall

segment readable

hello  db "Hey Philip", 10