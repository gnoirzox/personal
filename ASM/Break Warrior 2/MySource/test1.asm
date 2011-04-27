name "test video"
org 100h
    
    mov cx, 1
video_memory:
    mov ax, 0B800h
    mov es, ax 
    xor di, di
    mov ah, 1
    mov al, 178
    mov bx, 0
    mov es:[di], al
    mov es:[di], ah
    stosw
    
    
    
    inc bl
    inc bh
    
    cmp bl, 23
    jne video_memory 
    
    ret