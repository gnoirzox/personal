name "jalon4"
include "emu8086.inc"
org 100h

obstacle PROC
    
    position_centre:
    mov dl, 40  ;position X centre d ecran
    mov dh, 12  ;position Y centre d ecran
    mov bh, 0   ;la page active ou se trouve
                ;la position (X,Y) du curseur
    
    call video_mode
    push dx     ;position (X,Y) archivee dans la pile
    
    mov dl, '+' ;caractere a afficher
    mov ah, 6   ;affichage caractere sur
    int 21h     ;la position du curseur
    
    pop dx      ;position (X,Y) archivee dans la pile
                ;remise dans dl & dh
    
    position_horizontale:
    
    mov [02h], dl
    mov [04h], dl
    mov [06h], dh
    mov [08h], dh
   
    
 positions:
             
    position_horizontale1:
    mov dh, 12
    mov dl, [02h]
    dec dl
    
    call video_mode
    push dx
    
    mov dl, '-'
    mov ah, 6
    int 21h
    
    pop dx 
          
    mov [02h], dl       
    
    position_horizontale2:
    mov dh, 12
    mov dl, [04h]
    inc dl
    
    call video_mode
    push dx 
    
    mov dl, '-'
    mov ah, 6
    int 21h
    
    pop dx
    
    mov [04h], dl
    
    position_verticale1:
    mov dl, 40
    mov dh, [06h]
    dec dh 
    
    push dx
    
    call video_mode
    
    mov dl, 124
    mov ah, 6
    int 21h
    
    pop dx
    
    mov [06h], dh
    
    mov dh, 12
    
    position_verticale2:
    mov dl, 40
    mov dh, [08h]
    inc dh
    
    push dx
    
    call video_mode
    
    mov dl, 124
    mov ah, 6
    int 21h
    
    pop dx
    
    mov [08h], dh
    
    
    comparaison:
    
    cmp dh, 22
    loopne positions            
endp obstacle

video_mode PROC
    mov ah, 2
    int 10h 
endp video_mode
ret 