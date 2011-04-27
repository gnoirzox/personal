org 100h
.code
mov AX, 09h				; code à executer par le processeur (afficher msg à l'ecran)
mov DX, offset message	; on met l'offset de message dans DX
int 21h
.data
message: dw "Mon premier programme ASM 8086 ! Youhou !!!", '$' ;donnée à écrire à l'écran
ret
end