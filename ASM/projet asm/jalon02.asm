name "jalon2"
include "emu8086.inc"
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

deplacement:
    inc dl      ;incrementation position X
    inc dh      ;incrementation position Y
    
    mov ah, 6   ;affichage du caractere sur 
    int 21h     ;la position du curseur
    
    cmp dh, 25  ;comparaison dh et valeur immediate 25
    loopne deplacement
    je rebond1
    
    cmp dl, 80  ;comparaison dl et valeur immediate 80 
    loopne deplacement
    je rebond2


                ;rebonds

rebond1:        ;si Y==25 et inc dl & inc dh
    inc dl      ;incrementation position X
    dec dh      ;decrementation position Y 
    
    mov ah, 6   ;affichage du caractere sur 
    int 21h     ;la position du curseur
    
    cmp dh, 0   ;comparaison dh et valeur immediate 0
    loopne rebond1
    je deplacement

    cmp dl, 80
    loopne rebond1
    je rebond3


rebond2:        ;si X==80 et inc dl & inc dh
    dec dl      ;decrementation position X
    inc dh      ;incrementation position Y
    
    mov ah, 6   ;affichage du caractere sur 
    int 21h     ;la position du curseur
    
    cmp dl, 0
    loopne rebond2
    je deplacement
    
    cmp dh, 25
    loopne rebond2
    je rebond3
    

rebond3         ;si Y==25 et dec dl & inc dh
    
    dec dl      ;decrementation position X
    dec dh      ;decrementation position Y
    
    mov ah, 6
    int 21h
    
    cmp dh, 0
    loopne rebond3
    je rebond2
    
    cmp dl, 0
    loopne rebond3
    je rebond1

ret