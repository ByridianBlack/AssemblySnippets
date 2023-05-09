format ELF64 executable 3
entry start

segment readable executable writeable


start:


    call encryption_stub

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
;--------------------------------------------------------
encrypted:
    db 0x17,0x00,0x00,0x00,0x55,0x1d,0x64,0x95,0x1d,0x92,0x95,0x69,0x55,0x55,0x55,0x1d,0x64,0xaa,0x1d,0x92,0x92,0x11,0x55,0x55,0x55,0x5a,0x50,0x59

encryption_stub:
    mov rdi, encrypted

    mov ecx, DWORD [rdi] ; DATA SIZE
    add rdi, 4
    
    mov al, BYTE [rdi]      ; KEY
    inc rdi


    xor_routine:
        xor BYTE [rdi], al

        inc rdi

        loop xor_routine

    jmp encrypted + 6
    ret
