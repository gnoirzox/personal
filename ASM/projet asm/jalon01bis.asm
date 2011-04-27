name 'test2'
org 100h
  
  mov ax,0B800h
  mov es,ax

  mov bx,0 ; X=0
  mov al,0 ; Y=0
  mov cx,1 ; compteur = 10 et sert aussi pour la couleur du coup
  
  boucle:
    call pixel
    inc bx
    inc al
    
    cmp al, 25
   jne boucle
   je fin
   
   pixel PROC
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
 pixel endp
 
 fin:
 mov ah, 9
 int 21h
 ret