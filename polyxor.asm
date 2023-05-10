format ELF64 executable 3
entry start

segment readable executable writeable


start:


    call test_code

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

; encrypted:
;     db 0x17,0x00,0x00,0x00,0x55,0x1d,0x64,0x95,0x1d,0x92,0x95,0x69,0x55,0x55,0x55,0x1d,0x64,0xaa,0x1d,0x92,0x92,0x11,0x55,0x55,0x55,0x5a,0x50,0x59

; ; xor_procedure:
; ;     mov rdi, encrypted

; ;     mov ecx, DWORD [rdi] ; DATA SIZE
; ;     add rdi, 4
    
; ;     mov al, BYTE [rdi]      ; KEY
; ;     inc rdi


; ;     xor_routine:
; ;         xor BYTE [rdi], al

; ;         inc rdi

; ;         loop xor_routine

; ;     call encrypted + 6

; ;     ret

; ; ------------------------------------ 
; ; Arguments: 
; ; rdi - address of encrypted_data
; ; ------------------------------------
; xor_procedure:

;     push rcx
;     push rax
;     push rdi

;     mov ecx, DWORD [rdi]                    ; DATA SIZE
;     add rdi, 4

;     push ecx

;     mov al, BYTE[rdi]                       ; KEY
;     inc rdi

;     xor_routine_e:
;         xor BYTE [rdi], al
;         inc rdi

;         loop xor_routine_e
    
;     pop ecx
;     pop rdi

;     call rdi+6

;     add rdi, 4

;     add al, 1                               ; Need to update KEY but this time I need to make the value is never 0;
;     mov BYTE[rdi], al           
;     inc rdi

;     xor_routine_d:
;         xor BYTE[rdi], al
;         inc rdi

;         loop xor_routine_d

;     pop rax
;     pop rcx


test_code:


    push rdi
    push rax


    xor rax, rax
    inc rax

    xor rdi, rdi
    inc rdi

    mov rsi, 0x68732f6e69622f2f
    mov rdx, 3

    syscall

    pop rax
    pop rdi