; Erel Dekel 326064888 & Ziv Chaba 326681285
.model small
.stack 100h
.data
  table db '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'
.code
START:
;setting data segment
    mov ax, @data
    mov ds, ax

;setting extra segment to screen memory
    mov ax, 0b800h
    mov es, ax

    mov dx, 2E00h             ; init dh to  green yellow color
    mov ch, 10h            ; init ch to 16 to separate betwwen the digits

    ; ax = 0
    mov ax, 0               ; init ax value
    mov cl, ah              ; to save the 2 bigger ax digits we move them to cl
    and ax, 00FFh           ; remove the 2 bigger digits in ax
    div ch                  ; dividing by 16 so 1st digit to al, 2nd digit to ah
    mov bl, al              ; moving al to bx so it will considered a base register
    mov dl, table[bx]       ; moving the char of bx to dl
    mov es:[4d], dx         ; printing the char to the screen
    mov bl, ah              ; moving ah to bx so it will considered a base register
    mov dl, table[bx]       ; moving the char of bx to dl
    mov es:[6d], dx         ; moving ah to bx so it will considered a base register
    mov al, cl              ; getting the two bigger digits to al
    and ax, 00FFh           ; repiting the prossess
    div ch
    mov bl, al              
    mov dl, table[bx]
    mov es:[0d], dx
    mov bl, ah              
    mov dl, table[bx]
    mov es:[2d], dx

    ; ax = -357
    mov ax, -357            ; init ax value
    mov cl, ah              ; to save the 2 bigger ax digits we move them to cl
    and ax, 00FFh           ; remove the 2 bigger digits in ax
    div ch                  ; dividing by 16 so 1st digit to al, 2nd digit to ah
    mov bl, al              ; moving al to bx so it will considered a base register
    mov dl, table[bx]       ; moving the char of bx to dl
    mov es:[160d + 4d], dx  ; printing the char to the screen
    mov bl, ah              ; moving ah to bx so it will considered a base register
    mov dl, table[bx]       ; moving the char of bx to dl
    mov es:[160d + 6d], dx  ; moving ah to bx so it will considered a base register
    mov al, cl              ; getting the two bigger digits to al
    and ax, 00FFh           ; repiting the prossess
    div ch
    mov bl, al              
    mov dl, table[bx]
    mov es:[160d], dx
    mov bl, ah              
    mov dl, table[bx]
    mov es:[160d + 2d], dx

    ; ax = 12B4h 
    mov ax, 12B4h           ; init ax value
    mov cl, ah              ; to save the 2 bigger ax digits we move them to cl
    and ax, 00FFh           ; remove the 2 bigger digits in ax
    div ch                  ; dividing by 16 so 1st digit to al, 2nd digit to ah
    mov bl, al              ; moving al to bx so it will considered a base register
    mov dl, table[bx]       ; moving the char of bx to dl
    mov es:[320d + 4d], dx  ; printing the char to the screen
    mov bl, ah              ; moving ah to bx so it will considered a base register
    mov dl, table[bx]       ; moving the char of bx to dl
    mov es:[320d + 6d], dx  ; moving ah to bx so it will considered a base register
    mov al, cl              ; getting the two bigger digits to al
    and ax, 00FFh           ; repiting the prossess
    div ch
    mov bl, al              
    mov dl, table[bx]
    mov es:[320d], dx
    mov bl, ah              
    mov dl, table[bx]
    mov es:[320d + 2d], dx

;return to OS
    mov ax, 4C00h
    int 21h
end START