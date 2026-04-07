global _start

section .data
msg db "1337", 10
expected db "42", 10

section .bss
buf resb 16

section .text
_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, buf
    mov rdx, 16
    syscall

    mov al, [buf]
    cmp al, '4'
    jne fail
    mov al, [buf+1]
    cmp al, '2'
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