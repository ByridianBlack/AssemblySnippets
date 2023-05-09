format ELF64 executable 3
entry start

segment readable executable


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
    db 0x17,0x00,0x00,0x00,0x55,0x48,0x31,0xC0,0x48,0xC7,0xC0,0x3C,0x00,0x00,0x00,0x48,0x31,0xFF,0x48,0xC7,0xC7,0x44,0x00,0x00,0x00,0x0F,0x05,0xC3

encryption_stub:
    mov rdi, encrypted

    mov edx, DWORD [rdi] ; DATA SIZE
    add rdi, 4
    
    mov al, BYTE [rdi]      ; KEY
    inc rdi

