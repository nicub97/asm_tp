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

is_prime:
    cmp rdi, 2
    jl not_prime
    je is_p
    test rdi, 1
    jz not_prime
    mov rcx, 3
.loop:
    mov rax, rdi
    xor rdx, rdx
    div rcx
    test rdx, rdx
    jz not_prime
    add rcx, 2
    mov rax, rcx
    imul rax, rax
    cmp rax, rdi
    jle .loop
is_p:
    mov rax, 1
    ret
not_prime:
    xor rax, rax
    ret

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, buf
    mov rdx, 16
    syscall
    mov rdi, buf
    call atoi
    mov rdi, rax
    call is_prime
    test rax, rax
    jz fail
    mov rax, 60
    xor rdi, rdi
    syscall
fail:
    mov rax, 60
    mov rdi, 1
    syscall