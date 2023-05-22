.model small
.stack 100h
.data
.code

    numPrefix proc near
        push bp
        push di
        push bx
        mov bx, 10
        mov dx, 0
        mov bp, sp
        mov ax, [bp+8]
        cmp ax, 0
        je returnNumPrefix
        call printNum
        add di, 0a0h
        sub di, 2
        div bx
        push ax
        call numPrefix
        pop ax
        returnNumPrefix:
            pop bx
            pop di
            pop bp
        ret
    numPrefix endp

    printNum proc near
        push di
        push dx
        push bx
        push ax
        cmp ax, 0
        je returnPrintNum
        mov dx, 0
        mov bx, 10
        div bx
        mov dh, 2Eh
        add dl, '0'
        mov es:[di], dx
        sub di, 2
        call printNum
        returnPrintNum:
            pop ax
            pop bx
            pop dx
            pop di
        ret
    printNum endp

START:
;setting data segment
    mov ax, @data
    mov ds, ax

;setting extra segment to screen memory
    mov ax, 0b800h
    mov es, ax

    mov di, 6
    mov ax, 3260
    push ax
    call numPrefix

;return to OS
    mov ax, 4C00h
    int 21h

end START