name 'jalon7'
org 100h
  initialisation:
  mov ax,0B800h ;mise en memoire dans le seg-reg
  mov es,ax     ;'es' de la memoire video

  mov bx,0 ; X=0
  mov al,0 ; Y=0
  mov cx,0 ; la couleur effacant le trace de la balle
  
  
  cadre PROC
  mov bx, -1; X= -1
  mov al, 1 ; Y= 1
  mov cx, 11;couleur du cadre
            
  ;initilisation des memoires conservants les prochaines postions X et Y
  mov [08h], al
  mov [0Ah], al
  mov [0Ch], bx
  
  gauche:
  mov bx, 0 ; X=0
  mov al, [08h] ;appelle de l'ancienne position
  inc al
  
  push cx
  push bx
  push ax
  
  mov ah, 160 
  mul ah
  shl bx, 1
  add bx, ax
  mov ch, 49h ;caractere a afficher (ascii)
  xchg ch, cl
  mov es: [bx], cx
  
  pop ax
  pop bx
  pop cx 
  
  mov [08h], al ;sauvegarde de la postion actuelle
  
  droite:
  mov bx, 79 ; X=79
  mov al, [0Ah]
  inc al
  
  push cx
  push bx
  push ax
  
  mov ah, 160
  mul ah
  shl bx, 1
  add bx, ax
  mov ch, 49h
  xchg ch, cl
  mov es: [bx], cx
  
  pop ax
  pop bx
  pop cx
  
  mov [0Ah], al
  
  cmp al, 24       
  jne gauche
  je top
  
  top:  
  mov al, 1 ;Y= 1
  mov bx, [0Ch]
  inc bx
  
  push cx
  push bx
  push ax
  
  mov ah, 160
  mul ah
  shl bx, 1
  add bx, ax
  mov ch, 05Fh ;caractere a afficher (ascci) equivaut a "mov ch, '_'"
  xchg ch, cl
  mov es: [bx], cx
  
  pop ax
  pop bx
  pop cx
  
  mov [0Ch], bx
  
  cmp bx, 79
  jne top
  
  cadre endp
  
  raquette PROC
  
  mov al, 24 ;Y= 24
  mov cx, 3  ;couleur de la raquette
   
  centre:
  mov bx, 40 ;X= 40
  mov [0Eh], bx
  call affiche_raquette
  
  rgauche:
  mov bx, [0Eh]
  sub bx, 2
  call affiche_raquette
  
  mov bx, [0Eh]
  dec bx
  call affiche_raquette
  
  rdroite:
  mov bx, [0Eh]
  inc bx
  call affiche_raquette
  
  mov bx, [0Eh]
  add bx, 2
  call affiche_raquette
   
  raquette endp 
   
  obstacle PROC
  mov bx, 40
  mov al, 12
  mov cx, 2
  
  mov [00h], al
  mov [02h], bx
  mov [04h], al
  mov [06h], bx
  
  call position_centre
  
  position_verti1:
  mov bx, 40
  mov al, [00h]
  inc al
  
  call position_verticale
  
  mov [00h], al
  
  position_hori1:
  mov al, 12
  mov bx, [02h]
  dec bx
  
  call position_horizontale
  
  mov [02h], bx
  
  position_verti2:
  mov bx, 40
  mov al, [04h]
  dec al
  
  call position_verticale
  
  mov [04h], al
  
  position_honri2:
  mov al, 12
  mov bx, [06h]
  inc bx
  
  call position_horizontale
  
  mov [06h], bx
  
  cmp bx, 50
  je init
  jmp position_verti1
  
  position_centre PROC
  push cx
  push bx
  push ax
  
  mov ah, 160
  mul ah
  shl bx, 1
  add bx, ax
  mov ch, 02Bh ;equivaut a mov ch, '+'
  xchg ch, cl
  mov es: [bx], cx

  pop ax
  pop bx
  pop cx
  
  ret
  position_centre endp
  
  position_horizontale PROC 
  push cx
  push bx
  push ax
  
  mov ah, 160
  mul ah
  shl bx, 1
  add bx, ax
  mov ch, 02Dh ;equivaut a "mov ch, '-'"
  xchg ch, cl
  mov es: [bx], cx
  
  pop ax
  pop bx
  pop cx
  
  ret
  position_horizontale endp
  
  position_verticale PROC
  push cx
  push bx
  push ax
  
  mov ah, 160
  mul ah
  shl bx, 1
  add bx, ax
  mov ch, 07Ch ;equivaut a "mov ch, '|'"
  xchg ch, cl
  mov es: [bx], cx

  
  pop ax
  pop bx
  pop cx
  
  ret
  position_verticale endp
  
  init:
  mov bx,1 ; X=0
  mov al,2 ; Y=0
  mov cx,0 ; la couleur effacant le trace de la balle
  

  
  score PROC
  
  score endp  

  
 deplacement:
  
  cmp al, 24 ; si Y=24 on change de boucle
  je perdu 
    
  cmp bx, 78 ; si X=79 on change de boucle
  je rebond2
  
  inc bx   ; incrementation X
  inc al   ; incrementation Y 
  
  call position_active 
  call position
  jmp deplacement
  
  rebond1:
  cmp al, 2
  je deplacement
  
  cmp bx, 78
  je rebond3
   
  inc bx
  dec al
  
  call position_active
  call position
  jmp rebond1
  
  rebond2:
  cmp al, 24
  je rebond3
  
  cmp bx, 1
  je deplacement 
  
  dec bx
  inc al
  
  call position_active
  call position
  jmp rebond2
  
  rebond3:
  cmp al, 2
  je rebond2
  
  cmp bx, 1
  je rebond1
    
  dec bx
  dec al
  
  call position_active
  call position
  jmp rebond3
    
  position PROC
  push dx
  push cx
  push bx
  push ax
  
  mov ah, 160
  mul ah
  shl bx, 1
  add bx, ax
  mov ch, 0DBh ;permettant d'afficher un espace
  xchg ch, cl
  mov es: [bx], cx

  pop ax
  pop bx
  pop cx
  pop dx
  ret
  position endp
  
  position_active PROC
  push cx
  
  mov cx, 1 ; couleur bleu permettant d'afficher la balle
  call position
  
  pop cx
  ret
  position_active endp
  
  affiche_raquette PROC
  push cx
  push bx
  push ax
  
  mov ah, 160
  mul ah
  shl bx, 1
  add bx, ax
  mov ch, 58h ;equivaut a "mov ch, 'X'"
  xchg ch, cl
  mov es: [bx], cx
  
  pop ax
  pop bx
  pop cx
  ret
  affiche_raquette endp
  
  perdu PROC
  push ax
  push bx  
  push cx
  push es
  
  mov dh, 12 ;position Y du message
  mov dl, 7  ;position X du message
  mov bh, 0  ;page active du message
  mov ah, 2  
             ;position du curseur actif
  int 10h
  
  mov dx, offset message
  mov ah, 9
             ;affichage message
  int 21h 
  
  
  mov dh, 13
  mov dl, 7
  mov bh, 0
  mov ah, 2
  
  int 10h
  
  mov dx, offset message2
  mov ah, 9
  
  int 21h
  
  message db 'Game Over!', '$'
  message2 db 'You Lost NOOB!', '$'
  
  pop es
  pop cx
  pop bx
  pop ax
  
  mov al, 00h ;lit l'entree clavier
  mov ah, 1
  int 16h
  
  cmp al, 00h ;verifie si une touch est entree
  jne fin
  
  ret
  perdu endp
  
  gagne PROC
  push ax
  push bx  
  push cx
  push dx
  push es
  
  mov dh, 12
  mov dl, 7
  mov bh, 0
  mov ah, 2
  
  int 10h
  
  mov dx, offset message3
  mov ah, 9
  
  int 21h 
  
  
  mov dh, 13
  mov dl, 7
  mov bh, 0
  mov ah, 2
  
  int 10h
  
  mov dx, offset message4
  mov ah, 9
  
  int 21h
  
  message3 db 'You  Win!', '$'
  message4 db 'NoLife! :P', '$'
  
  pop es
  pop dx
  pop cx
  pop bx
  pop ax
  
  
  mov ah, 01h
  int 16h
  
  cmp al, 00 ;verifie si une touche est entree
  jnz initialisation  
  
 fin:
 mov ah, 04Ch;fin du programme, redonne la main au DOS 
 int 21h
 ret