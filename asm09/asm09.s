global _start

section .bss
buf resb 64

section .data
hexchars db "0123456789ABCDEF"

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

to_hex:
    mov rax, rdi
    mov rcx, buf+63
    mov byte [rcx], 10
    dec rcx
    mov r8, rcx
.loop:
    xor rdx, rdx
    mov r9, 16
    div r9
    lea r10, [rel hexchars]
    mov dl, [r10+rdx]
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

to_bin:
    mov rax, rdi
    mov rcx, buf+63
    mov byte [rcx], 10
    dec rcx
    mov r8, rcx
.loop:
    mov rdx, rax
    and rdx, 1
    add dl, '0'
    mov [rcx], dl
    dec rcx
    shr rax, 1
    test rax, rax
    jnz .loop
    inc rcx
    mov rsi, rcx
    mov rdx, r8
    sub rdx, rcx
    add rdx, 2
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
    mov rdi, rax
    cmp r12, 1
    je .binary
    call to_hex
    jmp .print
.binary:
    call to_bin
.print:
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