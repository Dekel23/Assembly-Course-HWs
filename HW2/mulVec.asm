; Erel Dekel 326064888 & Ziv Chaba 326681285
.model small
    N EQU 3
.stack 100h
.data
    MAT db 2, 3, 1, 0Ah, 8, 1, 0Fh, 5, 4
    VEC db 7, 0Dh, 6
    Result dw N dup(?)
.code
START:
;setting data segment
    mov ax, @data
    mov ds, ax

;setting extra segment to screen memory
    mov ax, 0b800h
    mov es, ax

    mov bx, offset MAT  ;set to the beggining of the matrix
    mov di, offset RESULT   ;set to the beggining of the result vector
    mov si, offset VEC  ;set to the beggining of the vector
;setting result to zero vector
    mov cx, N
    ZeroLoop:
        mov ds:[di], 0
        add di, 2
    Loop ZeroLoop

    mov bp, N   ;outer loop counter
    OUTERLOOP:
        mov cx, N   ;counter to the inner loop
        mov di, offset RESULT 
        InnerLoop:
            mov ax, 0
            mov al, ds:[bx]
            cbw
            mov dl, ds:[si]
            imul dl
            add ds:[di], ax
            add di, 2
            inc bx
        Loop InnerLoop
        inc si
        dec bp  ;dec the outerloop couter
    jnz OUTERLOOP

;return to OS
    mov ax, 4C00h
    int 21h
end START