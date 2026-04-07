global _start

section .text
_start:
    cmp qword [rsp], 2
    jl fail

    mov rbx, [rsp+16]
    mov rsi, rbx
    xor rdx, rdx

strlen:
    cmp byte [rbx+rdx], 0
    je print
    inc rdx
    jmp strlen

print:
    mov byte [rbx+rdx], 10
    inc rdx
    mov rax, 1
    mov rdi, 1
    syscall
    mov rax, 60
    xor rdi, rdi
    syscall

fail:
    mov rax, 60
    mov rdi, 1
    syscall