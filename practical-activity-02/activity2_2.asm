; Crie um programa em linguagem assembly chamado ATIV2_2.asm que exibe uma mensagem na tela 
; solicitando ao usuário que digite um primeiro número (de 0 a 9), lê o caractere digitado do teclado, 
; exibe uma mensagem na linha seguinte solicitando ao usuário que digite um segundo número (de 0 a 9), 
; lê o caractere digitado do teclado, exibe uma mensagem na linha seguinte informando qual o valor da soma 
; do primeiro com o segundo número e exibe o caractere contendo o resultado da soma.

; OBS: A soma dos dois números nunca deve ultrapassar o valor 9, ou seja, o usuário sempre deve digitar dois 
; números cuja soma seja menor ou igual a 9.

; Exemplo:
; Digite um primeiro número: 2
; Digite um segundo número: 5
; A soma dos dois números é: 7

title adding two numbers inserted by the user
.model small

.data 
  first_number db 'Insert the first number (between 0-9): ', '$'
  second_number db 13, 10, 'Insert the second number (between 0-9): ', '$'
  sum_result db 13, 10, 'The sum of the two numbers inserted is: ', '$'

.code 
main proc

  mov ax,@data
  mov ds,ax

  mov ah,9
  lea dx,first_number
  int 21h

  mov ah,1
  int 21h

  mov bl,al
  sub bl,30h

  mov ah,9
  lea dx,second_number
  int 21h

  mov ah,1
  int 21h

  mov cl,al
  sub cl,30h

  mov ah,9
  lea dx,sum_result
  int 21h

  add bl,cl

  mov ah,2
  mov dl,bl
  add dl,30h
  int 21h

  mov ah,4ch
  int 21h

main endp
end main