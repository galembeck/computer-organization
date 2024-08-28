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

title adding two numbers inserted by the user ; Título do arquivo.
.model small ; Modelo necessário para leitura/execução do programa.

.data 
  first_number db 'Insert the first number (between 0-9): ', '$'
  second_number db 13, 10, 'Insert the second number (between 0-9): ', '$'
  sum_result db 13, 10, 'The sum of the two numbers inserted is: ', '$'

.code 
main proc

  ; Linhas 27 e 28 são responsáveis por permitirem o acesso de '.data'.
  mov ax,@data ; Endereço base do segmento de dados.
  mov ds,ax ; Movimentação/cópia de "ax" para "ds" (registrador).

  mov ah,9 ; Função responsável por imprimir uma string na tela do usuário.
  lea dx,first_number ; Passagem do endereço do texto pelo uso do "offset".
  ; mov dx, offset first_number ; Funcionamento semelhante ao 'lea ds, first_number'.
  int 21h ; Conjunto de funções de entrada/saída.

  mov ah,1 ; Função responsável por ler um caractere do teclado.
  int 21h ; Conjunto de funções de entrada/saída.

  mov bl,al ; Responsável por mover o valor de "al" para "bl".
  sub bl,30h ; Subtração de 30h (48 em decimal) para transformar o caractere em número.

  mov ah,9 ; Função responsável por imprimir uma string na tela do usuário.
  lea dx,second_number ; Passagem do endereço do texto pelo uso do "offset".
  int 21h ; Conjunto de funções de entrada/saída.

  mov ah,1 ; Função responsável por ler um caractere do teclado.
  int 21h ; Conjunto de funções de entrada/saída.

  mov cl,al ; Responsável por mover o valor de "al" para "cl".
  sub cl,30h ; Subtração de 30h (48 em decimal) para transformar o caractere em número.

  mov ah,9 ; Função responsável por imprimir uma string na tela do usuário.
  lea dx,sum_result ; Passagem do endereço do texto pelo uso do "offset".
  int 21h ; Conjunto de funções de entrada/saída.

  add bl,cl ; Adição dos valores de "bl" e "cl".

  mov ah,2 ; Função responsável por imprimir um caractere na tela do usuário.
  mov dl,bl ; Movimentação/cópia de "bl" para "dl".
  add dl,30h ; Adição de 30h (48 em decimal) para transformar o número em caractere. 
  int 21h ; Conjunto de funções de entrada/saída.

  mov ah,4ch ; Função responsável por encerrar o programa.
  int 21h ; Conjunto de funções de entrada/saída.

main endp
end main