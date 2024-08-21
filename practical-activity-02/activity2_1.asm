; Faça um programa em Assembly x86, que leia uma letra minúscula e a transforme em letra maiúscula.
; O programa deve ter as seguintes mensagens:
; Digite uma letra minúscula: a
; A letra maiúscula correspondente é: A

title reading a character & returning the uppercase form
.model small

.data
  character_input db 'Type any character to be returned on its uppercase form: ', '$'
  character_return db 13, 10, 'The uppercase form of the character inserted is: ', '$'

.code 
  main proc

  mov ax,@data
  mov ds,ax

  mov ah,9
  lea dx,character_input
  int 21h

  mov ah,1
  int 21h

  mov bl,al
  
  mov ah,9
  lea dx,character_return
  int 21h

  sub bl,20h

  mov ah,2
  mov dl,bl
  int 21h

  mov ah,4ch
  int 21h
main endp
end main