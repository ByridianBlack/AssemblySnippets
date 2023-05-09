
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
    inc rax
    xor rdi, rdi
    syscall

segment readable

hello  db "Hey Philip", 10


4831C048C7C03C0000004831FF48C7C7440000000F05C