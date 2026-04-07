global _start

section .data
msg db "1337", 10

section .text
_start:
    mov rax, [rsp]
    cmp rax, 2
    jne fail

    mov rsi, [rsp+16]
    mov al, [rsi]
    cmp al, '4'
    jne fail
    mov al, [rsi+1]
    cmp al, '2'
    jne fail
    mov al, [rsi+2]
    cmp al, 0
    jne fail

    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, 5
    syscall
    mov rax, 60
    xor rdi, rdi
    syscall

fail:
    mov rax, 60
    mov rdi, 1
    syscall