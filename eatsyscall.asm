; Executable name : EATSYSCALL
; Version         : 1.0
; Created date    : 22/11/2020
; Last update     : 22/11/2020
; Author          : Jungheon Lee
; Original Author : Jeff Duntemann
; Description     : A simple assembly app for Linux x86-64, using NASM 2.14, demonstraing the use of Linux 64bit syscall instead of INT 80h in 32bit Linux to display text.
; Build using these commands:
; nasm -f elf64 -g -F stabs eatsyscall.asm
; ld -o eatsyscall eatsyscall.o
;
; Syscall calling convention for x86_64
; Syscall NR        : rax
; return            : rax
; arg0, ar1, arg2   : rdi, rsi, rdx, r10
; Make sure syscall number for x84_64 is different from x86.
; This is because cpu architectures vary, which means that lots of different instructions are out there.

SECTION .data                   ; Section containing initialized data

EatMsg: db "Eat at Joe's!", 10
EatLen: equ $-EatMsg

SECTION .bss                    ; Section containing uninitialzied data

SECTION .text                   ; Section containing code

global _start                   ; Linker needs this to find the entry point!

_start:
    nop                         ; This no-op keeps gdb haddy (see text)
    mov rax, 1                  ; Specify sys_write syscall
    mov rdi, 1                  ; Specify File Descriptor 1: Standard Output
    mov rsi, EatMsg             ; Pass offset of the message
    mov rdx, EatLen             ; Pass the length of the message
    syscall                     ; Make syscall to output the text to stdout
; Syscall is done by putting variables to specific registers following the definitions from Linux kernel.
; To print text on a screen, we use the function, write(), in which we need four variables.
; rax for specifying the fucntion, rdi for referring to the file descriptor, rsi for the address of the message, rdx for the length of the message.

    mov rax, 60                 ; Specify Exit syscall
    mov rdi, 0                  ; Return a code of zero
    syscall                     ; Make syscall to terminate the program