name "jalon02bis"
include "emu8086.inc"
org 100h

cursor_position:
mov dl, -1      ;position X du curseur
mov dh, -1      ;position Y du curseur
mov bh, 0       ;la page active ou se trouve
                
cursor_character:
mov al, ' '     ;caractere a afficher (' ')
mov bh, 0       ;la page active ou afficher
mov bl, 0001b   ;couleur du caractere (blanc)
mov cx, 1       ;nombre de fois a afficher le caractere 

deplacement:
    cmp dh, 23 ;comparaison dh et valeur immediate 23
    je rebond1
    
    cmp dl, 78 ;comparaison dl et valeur immediate 78
    je rebond2
    
    inc dl      ;incrementation position X
    inc dh      ;incrementation position Y
    call mode_video
    
    push dx     ;archivage position curseur dans pile
    mov dl, 178 ;caractere a afficher
    
    mov ah, 6   ;affichage du caractere sur 
    int 21h     ;la position du curseur
    
    pop dx      ;position curseur remise dans registre
    
    jmp deplacement
                
                ;rebonds

rebond1:        ;si Y==25 et inc dl & inc dh
    cmp dh, 0
    je deplacement
    
    cmp dl, 78
    je rebond3
    
    inc dl      ;incrementation position X
    dec dh      ;decrementation position Y 
    call mode_video
    
    push dx     ;position (X;Y) du curseur dans la pile
    mov dl, 178 ;caractere a afficher
    
    mov ah, 6   ;affichage du caractere sur 
    int 21h     ;la position du curseur
    
    pop dx      ;remise de la position du curseur dans registre
    
    jmp rebond1

rebond2:        ;si X==80 et inc dl & inc dh
    cmp dh, 23
    je rebond3
    
    cmp dl, 0
    je deplacement
    
    dec dl      ;decrementation position X
    inc dh      ;incrementation position Y
    call mode_video 
    
    push dx
    mov dl, 178
    
    mov ah, 6   ;affichage du caractere sur 
    int 21h     ;la position du curseur
           
    pop dx       
    
    jmp rebond2
    
rebond3:        ;si Y==25 et dec dl & inc dh    
    cmp dh, 0
    je rebond2
    
    cmp dl, 0
    je rebond1
    
    dec dl      ;decrementation position X
    dec dh      ;decrementation position Y
    call mode_video
    
    push dx
    mov dl, 178
    
    mov ah, 6
    int 21h
    
    pop dx
    
    jmp rebond3
    
ancienne_position PROC
    push dx     ;position ancienne de X et Y 
                ;conservee dans la pile
    add  sp, 2  ;vidage de la pile
endp ancienne_position

mode_video PROC ;mode d affichage des evenements
    mov ah, 2
    int 10h    
         
endp mode_video
ret