section .data
    input_op_msg db 'Please input a valid operation (+, -, /, *)', 0
    input_op_msg_len equ $ - input_op_msg

section .bss
    operator resb 1 ; reserve 1 byte for an operator inputted through read_numbers

section.text
    global WinMain
    extern WriteConsoleW     ; **imports**
    extern ReadConsole      ;
    extern ExitProcess   ;  
    extern GetStdHandle
    

WinMain:
    call read_operation

    xor rdi, rdi
    call ExitProcess

read_operation:
    ;first we print out a message saying please input an operator
    mov rcx, -11 ; for STD_OUTPUT_HANDLE
    call GetStdHandle ; stores pointer in rax

    mov rdi, rax ; moves pointer into rdi as per calling conv
    mov rsi, input_op_msg ; message to print when inputting
    mov rdx, input_op_msg_len ; rdx contai
    xor r8, r8; optional/dont need
    xor r9, r9; optional/dont need

    call WriteConsoleW ; print out input operator message

    ;Now we read from the keyboard
    mov rcx, -10 ; STD_INPUT_HANDLE 
    call GetStdHandle ; rax now contains pointer

    mov rdi, rax ; keyboard handle in rdi
    mov rsi, operator ; store the value read to operator
    mov rdx, 1 ; need 1 byte for operator
    xor r8, r8 ; optional/dont need
    xor r9, r9 ; optional/dont need
    call ReadConsole ; read the operator

    ret
