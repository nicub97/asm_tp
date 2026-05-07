global _start

section .bss
buf resb 32

section .text
_start:
    cmp qword [rsp], 4
    jl fail
    mov rax, 60
    xor rdi, rdi
    syscall
fail:
    mov rax, 60
    mov rdi, 1
    syscall