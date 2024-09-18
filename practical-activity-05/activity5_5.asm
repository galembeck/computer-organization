; Crie um programa que calcule a somatória de 5 números a serem lidos e imprima a somatória deles. 
; Para testar o programa entre com números cuja a somatória seja no máximo 9.

title showing lowercase & uppercase letters ; Título do arquivo/programa.
.model small ; Modelo necessário para leitura/execução do programa.
.stack 100h ; Define o tamanho da pilha.

.data 
  number_entry db 13, 10, 'Insert a number number (between 0-9): ', '$'
  sum_result db 13, 10, 'The sum of the two numbers inserted is: ', '$'

.code 
main proc
  ; Linhas 15 e 16 são responsáveis por permitirem o acesso de '.data'.
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).

  MOV CX,5 ; Inicialização do contador "CX" em 5 (quantidade de números a serem lidos).

  MOV BL,0 ; Inicialização do valor de "BL".

READ:
  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,number_entry ; Passagem do endereço do texto pelo uso do "offset".
  ; MOV DX, offset first_number ; Funcionamento semelhante ao 'LEA DS, number_entry'.
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,1 ; Função responsável por ler um caractere do teclado.
  INT 21H ; Conjunto de funções de entrada/saída.

  ; MOV bl,al ; Responsável por mover o valor de "AL" para "BL".
  SUB AL,30H ; Subtração de 30H (48 em decimal) para transformar o caractere em número.

  ADD BL,AL ; Adição dos valores de "BL" e "AL".

  LOOP READ ; Decrementa o contador e salta para o rótulo READ se o contador não for zero.
  
  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,sum_result ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
  MOV DL,BL ; Movimentação/cópia de "BL" para "DL".
  ADD DL,30h ; Adição de 30h (48 em decimal) para transformar o número em caractere. 
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,4CH ; Função responsável por encerrar o programa.
  INT 21H ; Conjunto de funções de entrada/saída.

main endp
end main