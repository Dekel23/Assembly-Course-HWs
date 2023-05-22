.model small
.stack 100h
.data
    Result dw ?
    input_arr dw 100 dup(124), 150 dup(52), 250 dup(288), 200 dup(12)
    inputLen EQU 700
.code

    recGCD proc near
        push ax
        push bx
        push dx
        mov Result, ax ;move ax to the result
        cmp bx, 0 ;jump if bx=0
        je returnRecGCD
        mov dx, 0 ;reset dx to zero
        div bx ;divide ax by bx, reminder left in dx
        mov ax, bx ;move bx to ax
        mov bx, dx ;move the reminder to bx
        call recGCD ;call again the GCD algo
        returnRecGCD:
            pop dx
            pop bx
            pop ax
        ret ;return to last address in the stack
    recGCD endp

    arrGCD proc near
        push bx
        mov bx, input_arr[si]
        call recGCD
        mov ax, Result
        cmp si, 2*(inputLen - 1)
        je returnArrGCD  
        add si, 2      
        call arrGCD
        returnArrGCD:
            pop bx
            ret
    arrGCD endp

    ExarrGCD proc near
        push si
        mov ax, input_arr
        mov si, 0
        call arrGCD
        pop si
        ret
    ExarrGCD endp

START:
;setting data segment
    mov ax, @data
    mov ds, ax

;setting extra segment to screen memory
    mov ax, 0b800h
    mov es, ax

    mov ax, 54
    mov bx, 24
    ;call recGCD
    mov AH, 0x00    ; BIOS function to read system timer
    int 0x1A        ; Call BIOS interrupt
    call ExarrGCD
    mov AH, 0x00    ; BIOS function to read system timer
    int 0x1A        ; Call BIOS interrupt
    sub DX, initial_timer_value    ; DX holds the high word of the timer value
    sbb CX, initial_timer_value    ; CX holds the low word of the timer value
    mov bx, offset Result

;return to OS
    mov ax, 4C00h
    int 21h

end START