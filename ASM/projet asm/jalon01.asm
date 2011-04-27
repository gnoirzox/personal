name 'jalon1'
include 'emu8086.inc'
org 100h

cursor_position:
mov dl, -1       ;position X du curseur
mov dh, -1       ;position Y du curseur
mov bh, 0       ;la page active ou se trouve
                ;la position (X;Y) du curseur
                
cursor_character:
mov al, ' '     ;caractere a afficher (' ')
mov bh, 0       ;la page active ou afficher
mov bl, 0001b   ;couleur du caractere (blanc)
mov cx, 25      ;nombre de fois a afficher le caractere 

deplacement:
    inc dl      ;incrementation position X
    inc dh      ;incrementation position Y
    
    call video_mode
    
    push dx     ;archivage position curseur dans pile
    mov dl, 178 ;caractere a afficher
    mov ah, 6   ;affichage du caractere sur 
    int 21h     ;la position du curseur
    
    pop dx
    
    cmp dh, 23  ;comparaison dh et valeur immediate 23
    jne deplacement   

video_mode PROC
    mov ah, 2
    int 10h 
endp video_mode
ret