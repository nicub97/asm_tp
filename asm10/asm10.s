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

find_max:
    mov rax, r12
    cmp r13, rax
    jle .check2
    mov rax, r13
.check2:
    cmp r14, rax
    jle .done
    mov rax, r14
.done:
    ret

_start:
    cmp qword [rsp], 4
    jl fail
    mov rdi, [rsp+16]
    call atoi
    mov r12, rax
    mov rdi, [rsp+24]
    call atoi
    mov r13, rax
    mov rdi, [rsp+32]
    call atoi
    mov r14, rax
    call find_max
    mov r15, rax
    mov rax, 60
    xor rdi, rdi
    syscall
fail:
    mov rax, 60
    mov rdi, 1
    syscall