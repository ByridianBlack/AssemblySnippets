format ELF64 executable 3
entry start

segment readable executable writeable


start:


    mov rdi, encrypted
    call xor_procedure
    
    
    mov al, 0x3c
    xor rdi, rdi
    syscall

;--------------------------------------------------------
; All encrypted data should be in the following format:
; int  size
; byte key 
; byte pointer encrypted data
; encryption stub
;
;
; Encryption stub
;   * stub should re encrypt the data and ret back to
;   * stub should update the key - key := key + 1 mod 256
;   * stub should also encrypt itself with new key if
;     possible
; to get the address of the data I can utilize the size 
; and work backwords. so to get the total address it 
; should be (current addrerss) - size - 6
; 
; ( 6 is the header information )
;
;--------------------------------------------------------
; encrypted:
;     db 0x17,0x00,0x00,0x00,0x55,0x1d,0x64,0x95,0x1d,0x92,0x95,0x69,0x55,0x55,0x55,0x1d,0x64,0xaa,0x1d,0x92,0x92,0x11,0x55,0x55,0x55,0x5a,0x50,0x59

; encryption_stub:
;     mov rdi, encrypted

;     mov ecx, DWORD [rdi] ; DATA SIZE
;     add rdi, 4
    
;     mov al, BYTE [rdi]      ; KEY
;     inc rdi


;     xor_routine:
;         xor BYTE [rdi], al

;         inc rdi

;         loop xor_routine

;     call encrypted + 6
;     ret



; --------------------------------------------------------
; Before was the old version. I think I should 
; improve it. Encrypting and then decrypting itself
; makes no sesne and close to impossible.
; Rather it makes more sense to just have a function
; decrypt, call, then immediately encrypt
; the functions in question. This way, there is a method
; to keep track of all the data. such as changes in keys
; and such.
;
; same format should persist though for encrypted data
;
; Points to remember
; Most see the RWX permissions as odd so I should 
; configure some type of function which changes the 
; permissions accordingly to wwhat I need. I have read
; that first changing it to R-W then RX- and then finally
; R-W should be enough to avoid any suspicions.
; --------------------------------------------------------

encrypted:
    db 0x25, 0x0, 0x0, 0x0, 0x55, 0x02,0x05,0xbd,0x50,0x55,0x55,0x55,0x31,0x34,0x21,0x34,0x55,0x0b,0x1d,0x64,0x95,0x1d,0xaa,0x95,0x1d,0x64,0xaa,0x1d,0xaa,0x92,0x1d,0x92,0x97,0x51,0x55,0x55,0x55,0x5a,0x50,0x0d,0x0a,0x96


; ------------------------------------ 
; Arguments: 
; rdi - address of encrypted_data
; ------------------------------------
xor_procedure:
    push rcx      ; push 64-bit register rcx instead of 32-bit ecx
    push rax
    push rdi
    xor rcx, rcx
    mov ecx, DWORD [rdi]                    ; DATA SIZE
    add rdi, 4

    push rcx

    mov al, BYTE[rdi]                       ; KEY
    inc rdi

    xor_routine_e:
        xor BYTE [rdi], al
        inc rdi

        loop xor_routine_e

    pop rcx
    pop rdi

    push rdi
    add rdi, 6
    call rdi

    pop rdi
    add rdi, 4

    add al, 1                               ; Need to update KEY but this time I need to make the value is never 0;
    mov BYTE[rdi], al           
    inc rdi

    xor_routine_d:
        xor BYTE[rdi], al
        inc rdi

        loop xor_routine_d

    pop rax
    pop rcx      ; pop 64-bit register rcx instead of 32-bit ecx
    ret



test_code:


    push rdi
    

    message_code:
        call chunk 
        message db "data", 0
        ret

    ; push 0x68732f6e69622f2f

    chunk:
    pop rsi
    xor rax, rax
    inc rax

    xor rdi, rdi
    inc rdi

    mov rdx, 4

    syscall
    pop rdi
    mov rsi, message_code
    add rsi, 4
    push rsi
    ret
    

    



; 0x52,0x55,0xed,0x00,0x05,0x05,0x05,0x61,0x64,0x71,0x64,0x05,0x5b,0x4d,0x34,0xc5,0x4d,0xfa,0xc5,0x4d,0x34,0xfa,0x4d,0xfa,0xc2,0x4d,0xc2,0xc7,0x01,0x05,0x05,0x05,0x0a,0x00,0x5d,0x5a,0xc6