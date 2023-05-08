format ELF64 executable 3
entry start

segment readable executable


calling:


    xor rax, rax

    ret

start:

    xor edi, edi
    jnz CTAG+1
    jz CTAG+1

    finish:
        mov rax, 0x3c
        xor rdi, rdi
        syscall

CTAG:
    db 0x89
    call calling
    jmp finish
