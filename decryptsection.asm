format ELF64 executable 3
entry start

segment readable executable writeable

; rdi is address of data to decrypt
; rdx is decryption key
; rbx is the length of data
; key 0x55
; decryption:

decryption_routine:

    
    xor rcx, rcx

    loop_start:

        xor BYTE [rdi], dl
        inc rdi
        inc rcx
    cmp rcx, rbx
    jg exit_routine_d
    jmp loop_start


    exit_routine_d:
        ret

start:



    mov rdi, encrypted_data
    mov rdx, 0x55
    mov rbx, 24

    call decryption_routine
    
    call encrypted_data
    call exit_routine

exit_routine:
    xor rax, rax
    mov rax, 0x3c
    xor rdi, rdi
    mov rdi, 0x44
    syscall
    ret

encrypted_data:
    db 0x1d,0x64,0x95,0x1d,0x92,0x95,0x69,0x55,0x55,0x55,0x1d,0x64,0xaa,0x1d,0x92,0x92,0x11,0x55,0x55,0x55,0x5a,0x50,0x59


segment readable executable

hello    db "Hey Philip", 10


