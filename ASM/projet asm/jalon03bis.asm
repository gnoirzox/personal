name 'test2'
org 100h
  
  mov ax,0B800h
  mov es,ax

  mov bx,0 ; X=0
  mov al,0 ; Y=0
  mov cx,0 ; la couleur effacant le trace de la balle
  
  deplacement:
  cmp al, 24 ; si Y=24 on change de boucle
  je rebond1 
    
  cmp bx, 79 ; si X=79 on change de boucle
  je rebond2
    
  call position
  inc bx   ; incrementation X
  inc al   ; incrementation Y
  
  call position_active
  
  jmp deplacement
  
  rebond1:
  cmp al, 0
  je deplacement
  
  cmp bx, 79
  je rebond3
  
  call position
  inc bx
  dec al
  
  call position_active
  
  jmp rebond1
  
  rebond2:
  cmp al, 24
  je rebond3
  
  cmp bx, 0
  je deplacement
  
  call position
  dec bx
  inc al
  
  call position_active
  
  jmp rebond2
  
  rebond3:
  cmp al, 0
  je rebond2
  
  cmp bx, 0
  je rebond1
  
  call position
  dec bx
  dec al
  
  call position_active
  
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
  mov ch, 0DBh
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
  
 fin:
 mov ah, 9
 int 21h
 ret