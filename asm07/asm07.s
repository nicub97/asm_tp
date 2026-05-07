global _start

section .bss
buf resb 16

section .text

atoi:
    xor rax, rax
.loop:
    movzx rcx, byte [rdi]
    cmp rcx, 10
    je .done
    cmp rcx, 0
    je .done
    imul rax, rax, 10
    sub rcx, '0'
    add rax, rcx
    inc rdi
    jmp .loop
.done:
    ret

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, buf
    mov rdx, 16
    syscall
    mov rdi, buf
    call atoi
    mov rax, 60
    xor rdi, rdi
    syscall