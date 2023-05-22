.model small
.stack 100h
.data
.code
START:
    mov bx, 3645h
    mov bx, 0FFh
    xor ax,ax
    dec ax
    sub ax, bx
    test ax, bx
    mul bx
    not bx
end START