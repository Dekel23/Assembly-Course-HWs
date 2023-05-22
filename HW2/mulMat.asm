; Erel Dekel 326064888 & Ziv Chaba 326681285
.model small
    N EQU 3
.data
    MAT1 db 2, 3, 1, 0Ah, 8, 1, 0Fh, 5, 4
    MAT2 db 2, 3, 1, 0Ah, 8, 1, 7, 0Dh, 6
    Result dw N*N dup(?)
.stack 100h
.code
START:
;setting data segment
    mov ax, @data
    mov ds, ax

;setting extra segment to screen memory
    mov ax, 0b800h
    mov es, ax

    mov bx, offset MAT1  ;set to the beggining of the matrix
    mov di, offset RESULT   ;set to the beggining of the result vector
    mov si, offset MAT2  ;set to the beggining of the vector
;setting result to zero vector
    mov cx, N*N
    ZeroLoop:
        mov ds:[di], 0
        add di, 2
    Loop ZeroLoop
    mov di, offset RESULT 

    mov sp, N
    OUTERLOOP:
        mov bp, N   ;outer loop counter
        mov bx, offset MAT1
        InnerLoop:
            mov cx, N   ;counter to the inner loop
            InnerLoop2:
                mov ax, 0
                mov al, ds:[bx]
                cbw
                mov dl, ds:[si]
                imul dl
                add ds:[di], ax
                add di, 2
                inc bx
            Loop InnerLoop2
            sub di, 2*N
            inc si
            dec bp  ;dec the outerloop couter
        jnz InnerLoop
        add di, 2*N
        dec sp
    jnz OUTERLOOP

;return to OS
    mov ax, 4C00h
    int 21h
end START