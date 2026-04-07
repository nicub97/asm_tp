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
    imul rax, rax, 10
    sub rcx, '0'
    add rax, rcx
    inc rdi
    jmp .loop
.done:
    ret

itoa:
    mov rax, rdi
    mov rcx, buf+31
    mov byte [rcx], 10
    dec rcx
    mov r8, rcx
.loop:
    xor rdx, rdx
    mov r9, 10
    div r9
    add dl, '0'
    mov [rcx], dl
    dec rcx
    test rax, rax
    jnz .loop
    inc rcx
    mov rsi, rcx
    mov rdx, r8
    sub rdx, rcx
    add rdx, 2
    ret

_start:
    cmp qword [rsp], 3
    jl fail

    mov rdi, [rsp+16]
    call atoi
    mov r12, rax

    mov rdi, [rsp+24]
    call atoi
    add rax, r12

    mov rdi, rax
    call itoa

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