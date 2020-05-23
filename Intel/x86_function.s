section .text

global x86_function
x86_function:
        push    rbp
        mov     rbp, rsp

        mov     QWORD[rbp-40], rdi
        mov     DWORD[rbp-48], esi
        mov     QWORD[rbp-56], rdx
        mov     QWORD[rbp-64], rcx
        mov     QWORD[rbp-72], r8
        mov     rax, QWORD[rbp-56]
        mov     eax, DWORD[rax]
        mov     DWORD[rbp-24], eax
        mov     rax, QWORD[rbp-64]
        mov     eax, DWORD[rax]
        mov     DWORD[rbp-28], eax
        mov     DWORD[rbp-8], 0
        mov     DWORD[rbp-12], 0
        mov     eax, DWORD[rbp-24]
        add     eax, 2
        mov     DWORD[rbp-16], eax
        cmp     DWORD[rbp-16], 400
        jne     skipHeadReset
        mov     DWORD[rbp-16], 0
skipHeadReset:
        mov     eax, DWORD[rbp-28]
        add     eax, 2
        mov     DWORD[rbp-20], eax
        cmp     DWORD[rbp-20], 400
        jne     skipTailReset
        mov     DWORD[rbp-20], 0
skipTailReset:
        cmp     DWORD[rbp-48], 1
        jne     notGoingUp
        mov     eax, DWORD[rbp-24]
        cdqe
        lea     rdx, [0+rax*4]
        mov     rax, QWORD[rbp-40]
        add     rax, rdx
        mov     eax, DWORD[rax]
        mov     DWORD[rbp-8], eax
        mov     eax, DWORD[rbp-24]
        cdqe
        add     rax, 1
        lea     rdx, [0+rax*4]
        mov     rax, QWORD[rbp-40]
        add     rax, rdx
        mov     eax, DWORD[rax]
        mov     DWORD[rbp-12], eax
        sub     DWORD[rbp-12], 1
        jmp     checkBorders
notGoingUp:
        cmp     DWORD[rbp-48], 2
        jne     notGoingDown
        mov     eax, DWORD[rbp-24]
        cdqe
        lea     rdx, [0+rax*4]
        mov     rax, QWORD[rbp-40]
        add     rax, rdx
        mov     eax, DWORD[rax]
        mov     DWORD  [rbp-8], eax
        mov     eax, DWORD[rbp-24]
        cdqe
        add     rax, 1
        lea     rdx, [0+rax*4]
        mov     rax, QWORD[rbp-40]
        add     rax, rdx
        mov     eax, DWORD  [rax]
        mov     DWORD[rbp-12], eax
        add     DWORD[rbp-12], 1
        jmp     checkBorders
notGoingDown:
        cmp     DWORD[rbp-48], 3
        jne     notGoingLeft
        mov     eax, DWORD[rbp-24]
        cdqe
        lea     rdx, [0+rax*4]
        mov     rax, QWORD[rbp-40]
        add     rax, rdx
        mov     eax, DWORD[rax]
        mov     DWORD[rbp-8], eax
        mov     eax, DWORD[rbp-24]
        cdqe
        add     rax, 1
        lea     rdx, [0+rax*4]
        mov     rax, QWORD[rbp-40]
        add     rax, rdx
        mov     eax, DWORD[rax]
        mov     DWORD[rbp-12], eax
        sub     DWORD[rbp-8], 1
        jmp     checkBorders
notGoingLeft:
        mov     eax, DWORD[rbp-24]
        cdqe
        lea     rdx, [0+rax*4]
        mov     rax, QWORD[rbp-40]
        add     rax, rdx
        mov     eax, DWORD[rax]
        mov     DWORD[rbp-8], eax
        mov     eax, DWORD[rbp-24]
        cdqe
        add     rax, 1
        lea     rdx, [0+rax*4]
        mov     rax, QWORD[rbp-40]
        add     rax, rdx
        mov     eax, DWORD[rax]
        mov     DWORD[rbp-12], eax
        add     DWORD[rbp-8], 1
checkBorders:
        cmp     DWORD[rbp-12], 0
        js      outOfBorder
        cmp     DWORD[rbp-12], 19
        jg      outOfBorder
        cmp     DWORD[rbp-8], 0
        js      outOfBorder
        cmp     DWORD[rbp-8], 19
        jle     checkIfBite
outOfBorder:
        mov     eax, DWORD[rbp-16]
        cdqe
        lea     rdx, [0+rax*4]
        mov     rax, QWORD[rbp-40]
        add     rax, rdx
        mov     DWORD  [rax], 30
        mov     rax, QWORD[rbp-56]
        mov     edx, DWORD[rbp-16]
        mov     DWORD[rax], edx
        mov     rax, QWORD[rbp-64]
        mov     edx, DWORD[rbp-20]
        mov     DWORD  [rax], edx
        jmp     exitFun
checkIfBite:
        mov     eax, DWORD[rbp-24]
        add     eax, 2
        cmp     DWORD[rbp-28], eax
        je      checkIfFruit
        mov     eax, DWORD[rbp-28]
        cdqe
        lea     rdx, [0+rax*4]
        mov     rax, QWORD[rbp-40]
        add     rax, rdx
        mov     eax, DWORD[rax]
        cmp     DWORD[rbp-8], eax
        jne     incTailInd
        mov     eax, DWORD[rbp-28]
        cdqe
        add     rax, 1
        lea     rdx, [0+rax*4]
        mov     rax, QWORD[rbp-40]
        add     rax, rdx
        mov     eax, DWORD[rax]
        cmp     DWORD[rbp-12], eax
        jne     incTailInd
        mov     eax, DWORD[rbp-16]
        cdqe
        lea     rdx, [0+rax*4]
        mov     rax, QWORD[rbp-40]
        add     rax, rdx
        mov     DWORD[rax], 30
        mov     rax, QWORD[rbp-56]
        mov     edx, DWORD[rbp-16]
        mov     DWORD[rax], edx
        mov     rax, QWORD[rbp-64]
        mov     edx, DWORD[rbp-20]
        mov     DWORD[rax], edx
        jmp     exitFun
incTailInd:
        add     DWORD[rbp-28], 2
        cmp     DWORD[rbp-28], 400
        jne     checkIfBite
        mov     DWORD[rbp-28], 0
        jmp     checkIfBite
checkIfFruit:
        mov     rax, QWORD[rbp-72]
        add     rax, 4
        mov     eax, DWORD[rax]
        cmp     DWORD[rbp-8], eax
        jne     writeNewInd
        mov     rax, QWORD[rbp-72]
        add     rax, 8
        mov     eax, DWORD[rax]
        cmp     DWORD[rbp-12], eax
        jne     writeNewInd
        cmp     DWORD[rbp-20], 0
        jne     decTail
        mov     DWORD[rbp-20], 398
        jmp     setFruitFlag
decTail:
        sub     DWORD[rbp-20], 2
setFruitFlag:
        mov     rax, QWORD[rbp-72]
        mov     DWORD[rax], 1
writeNewInd:
        mov     eax, DWORD[rbp-16]
        cdqe
        lea     rdx, [0+rax*4]
        mov     rax, QWORD[rbp-40]
        add     rdx, rax
        mov     eax, DWORD[rbp-8]
        mov     DWORD[rdx], eax
        mov     eax, DWORD[rbp-16]
        cdqe
        add     rax, 1
        lea     rdx, [0+rax*4]
        mov     rax, QWORD[rbp-40]
        add     rdx, rax
        mov     eax, DWORD[rbp-12]
        mov     DWORD[rdx], eax
        mov     rax, QWORD[rbp-56]
        mov     edx, DWORD[rbp-16]
        mov     DWORD[rax], edx
        mov     rax, QWORD[rbp-64]
        mov     edx, DWORD[rbp-20]
        mov     DWORD[rax], edx
        nop
exitFun:
        mov     rsp, rbp
        pop     rbp
        ret