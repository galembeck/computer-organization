; Crie um programa em linguagem assembly que exiba uma mensagem na tela solicitando ao usuário
; que digite um caractere, leia o caractere digitado no teclado pelo usuário, exiba uma mensagem
; na linha seguinte dizendo se o caractere digitado é uma letra, um número ou um caractere desconhecido.

; Exemplo:
; Digite um caractere: 2
; O caractere digitado é um número.

; Digite um caractere: A
; O caractere digitado é uma letra.

; Digite um caratere: ?
; O caractere digitado é um caractere desconhecido.

title checking characters ; Título do arquivi/programa.
.model small ; Modelo necessário para leitura/execução do programa.
.stack 100h ; Define o tamanho da pilha.

.data
  introduction_message db 'Below, type a character to be analysed and classified as a letter, number or an unknown character.', '$'
  type_message db 13, 10, 'Type a character: ', '$'
  affirmative_letter db 13, 10, 'The character inserted is a letter.', '$'
  affirmative_number db 13, 10, 'The character inserted is a number.', '$'
  affirmative_unknown db 13, 10, 'The character inserted is an unknown character.', '$'

.code
main proc

  ; Linhas 30 e 31 são responsáveis por permitirem o acesso de '.data'.
  mov ax,@data ; Endereço base do segmento de dados.
  mov ds,ax ; Movimentação/cópia de "ax" para "ds" (registrador).

  mov ah,9 ; Função responsável por imprimir uma string na tela do usuário.
  lea dx,introduction_message ; Passagem do endereço do texto pelo uso do "offset".
  ; mov dx, offset introduction_message ; Funcionamento semelhante ao 'lea dx, introduction_message'.
  int 21h ; Conjunto de funções de entrada/saída.

  mov ah,9 ; Função responsável por imprimir uma string na tela do usuário.
  lea dx,type_message ; Passagem do endereço do texto pelo uso do "offset".
  ; mov dx, offset type_message ; Funcionamento semelhante ao 'lea dx, type_message'.
  int 21h ; Conjunto de funções de entrada/saída.

  mov ah,1 ; Função responsável por ler um caractere do teclado.
  int 21h ; Conjunto de funções de entrada e saída.

  mov bl,al ; Movimentação/cópia de "al" para "bl" (registrador).

  cmp bl,48 ; Comparação do valor de "bl" com o valor 48 (código ASCII do caractere "0").
  jb verifyUppercase ; Se "bl" for menor que 48, então o caractere é uma letra, portanto, salta para o rótulo "verifyUppercase".

  cmp bl,57 ; Comparação do valor de "bl" com o valor 57 (código ASCII do caractere "9").
  ja verifyUppercase ; Se "bl" for maior que 57, então o caractere é uma letra, portanto, salta para o rótulo "verifyUppercase".

  mov ah,9 ; Função responsável por imprimir uma string na tela do usuário.
  lea dx,affirmative_number ; Passagem do endereço do texto pelo uso do "offset".
  ; mov dx, offset affirmative_number ; Funcionamento semelhante ao 'lea dx, affirmative_number'.
  int 21h ; Conjunto de funções de entrada/saída.

  jmp exit ; Salta para o rótulo "exit", para que o programa possa ser encerrado.

; Definição do rótulo "verifyUppercase" para a verificação do caractere (caso maiúsculo) e exibição da string "affirmative_letter" caso o caractere seja de fato uma letra.
verifyUppercase:
  cmp bl,41h ; Comparação do valor de "bl" com o valor 41h (código ASCII do caractere "A").
  jb verifyLowercase ; Se "bl" for menor que 41h, então o caractere é uma letra, portanto, salta para o rótulo "verifyLowercase".

  cmp bl,5Ah ; Comparação do valor de "bl" com o valor 5Ah (código ASCII do caractere "Z").
  jbe letterMessageShowcase ; Se "bl" for menor ou igual a 5Ah, então o caractere é uma letra, portanto, salta para o rótulo "letterMessageShowcase".

; Definição do rótulo "verifyLowercase" para a verificação do caractere (caso minúsculo) e exibição da string "affirmative_letter" caso o caractere seja de fato uma letra.
verifyLowercase:
  cmp bl,61h ; Comparação do valor de "bl" com o valor 61h (código ASCII do caractere "a").
  jb unknownCharacter ; Se "bl" for menor que 61h, então o caractere é desconhecido, portanto, salta para o rótulo "unknownCharacter".

  cmp bl,7Ah ; Comparação do valor de "bl" com o valor 7Ah (código ASCII do caractere "z").
  jbe letterMessageShowcase ; Se "bl" for menor ou igual a 7Ah, então o caractere é uma letra, portanto, salta para o rótulo "letterMessageShowcase".

; Definição do rótulo "unknownCharacter" para a exibição da string "affirmative_unknown" caso o caractere inserido seja de fato um caractere desconhecido.
unknownCharacter:
  mov ah,9 ; Função responsável por imprimir uma string na tela do usuário.
  lea dx,affirmative_unknown ; Passagem do endereço do texto pelo uso do "offset".
  ; mov dx, offset affirmative_unknown ; Funcionamento semelhante ao 'lea dx, affirmative_unknown'.
  int 21h ; Conjunto de funções de entrada/saída.

  jmp exit ; Salta para o rótulo "exit", para que o programa possa ser encerrado.

; Definição do rótulo "letterMessageShowcase" para a exibição da string "affirmative_letter" caso o caractere inserido seja de fato um caractere.
letterMessageShowcase:
  mov ah,9 ; Função responsável por imprimir uma string na tela do usuário.
  lea dx,affirmative_letter ; Passagem do endereço do texto pelo uso do "offset".
  ; mov dx, offset affirmative_letter ; Funcionamento semelhante ao 'lea dx, affirmative_letter'.
  int 21h ; Conjunto de funções de entrada/saída.

; Definição do rótulo "exit" para encerramento do programa.
exit:
  mov ah,4ch ; Função responsável por encerrar a execução do programa.
  int 21h ; Conjunto de funções de entrada/saída.

main endp
end main