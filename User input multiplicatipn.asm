SYS_EXIT 	equ 1
SYS_READ 	equ 3
SYS_WRITE 	equ 4
STDOUT 		equ 1
STDIN 		equ 0

segment .data

msg1 db "Please enter the first number:", 0x0A, 0x0D
len1 equ $- msg1

msg2 db "Please provide second number:", 0x0A, 0x0D
len2 equ $- msg2

msg3 db "The result is:"
len3 equ $- msg3

section .bss

multiplicand resb 2;	reserving the 2 bytes
multiplier resb 2;		reserving the 2 bytes
result resb 4;			reserving the 4 bytes

section .text
global main
main:

mov eax, SYS_WRITE;		SYS_WRITE
mov ebx, STDOUT;		STDOUT
mov ecx, msg1;			Actual message
mov edx, len1;			Length of the message
int 0x80;				System call

mov eax, SYS_READ; 		SYS_READ
mov ebx, STDIN;			STDIN
mov ecx, multiplicand;	storing the value inside multiplicand	
mov edx, 2
int 0x80;				System call

mov eax, SYS_WRITE;		SYS_WRITE
mov ebx, STDOUT;		STDOUT
mov ecx, msg2;			Actual message
mov edx, len2;			Length of the message
int 0x80;				System call

mov eax, 3; 			SYS_READ
mov ebx, 0;				STDIN
mov ecx, multiplier;	storing the value inside multiplier
mov edx, 2
int 0x80;				System call

mov eax, 4;				SYS_WRITE
mov ebx, 1;				STDOUT
mov ecx, msg3;			Actual message
mov edx, len3;			Length of the message
int 0x80;				System call

mov eax, [multiplicand]
sub eax, '0'
mov ebx, [multiplier]
sub ebx, '0'
mul ebx
add eax, '0'
mov [result], eax

						;print the result
mov eax, 4;				SYS_WRITE
mov ebx, 1;				STDOUT
mov ecx, result
mov edx, 4
int 0x80


mov eax,1;				SYS_EXIT
int 0x80;				System call