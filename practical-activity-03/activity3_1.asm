title number ; Título do arquivi/programa.
.model small ; Modelo necessário para leitura/execução do programa.
.stack 100h ; Define o tamanho da pilha.

.data
  first_message db 'Type a character: ', '$'
  affirmative_number db 13, 10, 'The character inserted is a number.', '$'
  negative_number db 13, 10, 'The character inserted is not a number.', '$'

.code
main proc
  ; Linhas 13 e 14 são responsáveis por permitirem o acesso de '.data'.
  mov ax,@data ; Endereço base do segmento de dados.
  mov ds,ax ; Movimentação/cópia de "ax" para "ds" (registrador).

  ; Exibição da string "first_message" solicitando ao usuário que digite um caractere.
  mov ah,9 ; Função responsável por imprimir uma string na tela do usuário.
  lea dx,first_message ; Passagem do endereço do texto pelo uso do "offset".
  ; mov dx, offset first_message ; Funcionamento semelhante ao 'lea dx, first_message'.
  int 21h ; Conjunto de funções de entrada/saída.

  mov ah,1 ; Função responsável por ler um caractere do teclado.
  int 21h ; Conjunto de funções de entrada e saída.

  mov bl,al ; Movimentação/cópia de "al" para "bl" (registrador).

  cmp bl,48 ; Comparação do valor de "bl" com o valor 48 (código ASCII do caractere "0").
  jb isNotANumber ; Se "bl" for menor que 48, então o caractere é uma letra, portanto, salta para o rótulo "isNotANumber".

  cmp bl,57 ; Comparação do valor de "bl" com o valor 57 (código ASCII do caractere "9").
  ja isNotANumber ; Se "bl" for maior que 57, então o caractere é uma letra, portanto, salta para o rótulo "isNotANumber".

  ; Caso o caractere inserido não seja um número, a string "affirmative_number" é exibida informando que o caractere é um número.
  mov ah,9 ; Função responsável por imprimir uma string na tela do usuário.
  lea dx,affirmative_number ; Passagem do endereço do texto pelo uso do "offset".
  ; mov dx, offset affirmative_number ; Funcionamento semelhante ao 'lea dx, affirmative_number'.
  int 21h ; Conjunto de funções de entrada/saída.

  jmp exit ; Salta para o rótulo "exit", para que o programa possa ser encerrado.

; Define o rótulo "isNotANumber":
isNotANumber:
  mov ah,9 ; Função responsável por imprimir uma string na tela do usuário.
  lea dx,negative_number ; Passagem do endereço do texto pelo uso do "offset".
  ; mov dx, offset negative_number ; Funcionamento semelhante ao 'lea dx, negative_number'.
  int 21h ; Conjunto de funções de entrada/saída.

; Define o rótulo "exit":
exit:
  mov ah,4ch ; Função responsável por encerrar a execução do programa.
  int 21h ; Conjunto de funções de entrada/saída.

main endp
end main

; O programa em questão atua como um verificador de caracteres inseridos pelo usuário,
; analisando-o e classificando-o em casos possíveis, sendo eles: letra, número e 
; caractere desconhecido, na medida que compara o que foi inserido com os valores hexadecimais
; correspondentes do que de fato deseja ser verificado. Além disso, o programa em questão trabalha
; pela criação e execução de rótulo (funções) que permitem a organização definitiva do código.