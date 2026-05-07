global _start

section .bss
buf resb 64

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

_start:
    cmp qword [rsp], 2
    jl fail
    xor r12, r12
    mov rdi, [rsp+16]
    mov al, [rdi]
    cmp al, '-'
    jne .parse
    mov al, [rdi+1]
    cmp al, 'b'
    jne fail
    mov r12, 1
    cmp qword [rsp], 3
    jl fail
    mov rdi, [rsp+24]
.parse:
    call atoi
    mov r13, rax
    mov rax, 60
    xor rdi, rdi
    syscall
fail:
    mov rax, 60
    mov rdi, 1
    syscall