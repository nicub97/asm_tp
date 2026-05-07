global _start

section .bss
buf resb 32

section .text

atoi:
    xor rax, rax
.loop:
    movzx rcx, byte [rdi]
    cmp rcx, 0
    je .done
    cmp rcx, 10
    je .done
    imul rax, rax, 10
    sub rcx, '0'
    add rax, rcx
    inc rdi
    jmp .loop
.done:
    ret

sum_below:
    xor rax, rax
    xor rcx, rcx
.loop:
    inc rcx
    cmp rcx, rdi
    jge .done
    add rax, rcx
    jmp .loop
.done:
    ret

_start:
    cmp qword [rsp], 2
    jl fail
    mov rdi, [rsp+16]
    call atoi
    mov rdi, rax
    call sum_below
    mov r12, rax
    mov rax, 60
    xor rdi, rdi
    syscall
fail:
    mov rax, 60
    mov rdi, 1
    syscall