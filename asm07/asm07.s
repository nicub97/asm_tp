global _start

section .bss
buf resb 16

section .text
_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, buf
    mov rdx, 16
    syscall
    mov rax, 60
    xor rdi, rdi
    syscall