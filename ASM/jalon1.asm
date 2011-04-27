name 'jalon1'
include 'emu8086.inc'
org 100h

cursor_position:
mov dl, 1       ;position X du curseur
mov dh, 1       ;position Y du curseur
mov bh, 0       ;la page active ou se trouve
                ;la position (X;Y) du curseur
                
cursor_character:
mov al, ' '     ;caractere a afficher (' ')
mov bh, 0       ;la page active ou afficher
mov bl, 0001b   ;couleur du caractere (blanc)
mov cx, 25      ;nombre de fois a afficher le caractere 

deplacement PROC
    inc dl      ;incrementation position X
    inc dh      ;incrementation position Y
    
    mov ah, 6   ;affichage du caractere sur 
    int 21h     ;la position du curseur
    
    cmp dh, 25  ;comparaison dh et valeur immediate 25
    jne deplacement   
endp
ret