name "jalon5"
include "emu8086.inc"
org  100h

obstacle PROC
    
    position_centre:
    mov dl, 40  ;position X centre d ecran
    mov dh, 12  ;position Y centre d ecran
    mov bh, 0   ;la page active ou se trouve
                ;la position (X,Y) du curseur
    
    call mode_video
    push dx     ;position (X,Y) archivee dans la pile
    
    mov dl, '+' ;caractere a afficher
    mov ah, 6   ;affichage caractere sur
    int 21h     ;la position du curseur
    
    pop dx      ;position (X,Y) archivee dans la pile
                ;remise dans dl & dh
    
    position_horizontale:
    
    mov [02h], dl ;position X conservee dans memoire 02h
    mov [04h], dl ;position X conservee dans memoire 04h
    mov [06h], dh ;position Y conservee dans memoire 06h
    mov [08h], dh ;position Y conservee dans memoire 08h
   
    
 positions:
             
    position_horizontale1:
    mov dh, 12    ;position Y constante
    mov dl, [02h] ;position X ancienne de position_horizontale1 
    dec dl        ;decrementation position Y de position_horizontale1
    
    call mode_video
    push dx
    
    mov dl, '-'
    mov ah, 6
    int 21h
    
    pop dx 
          
    mov [02h], dl ;position X actuelle de position_horizontale1 conservee dans memoire 02h     
    
    position_horizontale2:
    mov dh, 12
    mov dl, [04h]
    inc dl
    
    call mode_video
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
    
    call mode_video
    
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
    
    call mode_video
    
    mov dl, 124
    mov ah, 6
    int 21h
    
    pop dx
    
    mov [08h], dh
    
    
    comparaison:
    
    cmp dh, 22
    loopne positions            
endp obstacle

cursor_position:
    mov dl, -1  ;position X du curseur
    mov dh, -1  ;position Y du curseur
    mov bh, 0   ;la page active ou se trouve le curseur
                
cursor_character:
mov al, ' '     ;caractere a afficher (' ')
mov bh, 0       ;la page active ou afficher
mov bl, 0001b   ;couleur du caractere (blanc)
mov cx, 1       ;nombre de fois a afficher le caractere 

deplacement:
    cmp dh, 23  ;comparaison dh et valeur immediate 23
    je rebond1
    
    cmp dl, 78  ;comparaison dl et valeur immediate 78
    je rebond2 
    
    inc dl      ;incrementation position X
    inc dh      ;incrementation position Y
    call mode_video
    
    push dx     ;archivage position curseur dans pile
    

    
    mov dl, 178 ;caractere a afficher
    
    mov ah, 6   ;affichage du caractere sur 
    int 21h     ;la position du curseur
    
    pop dx
    call ancienne_position
          
    
    jmp deplacement
                
rebonds:        ;rebonds

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
    
    pop dx
    call ancienne_position
          ;remise de la position du curseur dans registre
    
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
    call ancienne_position 
           
    
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
    call ancienne_position
    
    
    jmp rebond3
    
ancienne_position PROC
    mov	ah, 6	;fonction 6, effacer ecran
    mov	al, 1	
    mov	bh, 7	;utilistaion espace pour effacer
    mov ch, dh
    mov cl, dl
    int	10h
    
    mov	ah, 2	;fonction 2, coordonnees (X,Y)
    mov	bh, 0	;affiche page 0
    int	10h
endp ancienne_position

mode_video PROC ;mode d affichage des evenements
    mov ah, 2
    int 10h    
         
endp mode_video
ret