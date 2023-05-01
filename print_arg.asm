format ELF64 executable 3
entry start

segment readable executable

get_string_size:

    mov rbx, rsi
    push rsi

    xor rax, rax

    loop_start:
        
        mov cl, BYTE [rbx]
        test cl, cl
        jz exit_process
        inc rbx
        inc rax
        jmp loop_start
        
    exit_process:
    pop rsi
    ret

start:

    pop rsi ; This can be thrown away
    pop rsi ; Should be funcion name
    pop rsi ; first argument
    call get_string_size
    
    xor rdi, rdi
    inc rdi

    mov rdx, rax ; string size

    xor rax, rax
    inc rax

    syscall

    xor rdi, rdi
    mov rax, 0x3C
    syscall


