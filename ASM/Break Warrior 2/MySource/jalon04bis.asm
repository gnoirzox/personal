name 'jalon4'
org 100h
  
  mov ax,0B800h
  mov es,ax

  mov bx,0 ; X=0
  mov al,0 ; Y=0
  mov cx,0 ; la couleur effacant le trace de la balle

 
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
  mov ch, 02Bh
  xchg ch, cl
  mov es: [bx], cx
  mov dx, cx
  
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
  mov ch, 02Dh
  xchg ch, cl
  mov es: [bx], cx
  mov dx, cx
  
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
  mov ch, 07Ch
  xchg ch, cl
  mov es: [bx], cx
  mov dx, cx
  
  pop ax
  pop bx
  pop cx
  
  ret
  position_verticale endp
  
  init:
  mov bx,1 ; X=0
  mov al,2 ; Y=0
  mov cx,0 ; la couleur effacant le trace de la balle
  
ret
obstacle endp
 
 fin:
 mov ah, 04Ch 
 int 21h
 ret