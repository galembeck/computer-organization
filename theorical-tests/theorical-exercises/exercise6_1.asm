; Escreva um programa que apresente uma '?', leia em seguida duas letras 
; maiúsculas e exiba-as na próxima linha, em ordem alfabética.

title organizing uppercase & lowercase letters in alphabetic order ; Título do arquivo/programa
.model small ; Define o modelo de memória do programa
.stack 100h ; Define o tamanho da pilha

.data
  uppercase_character_input db 13, 10, 'Type a uppercase character: ', '$'
  alphabetic_output db 13, 10, 'Alphabetic order: ', '$'

.code
main proc
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).

  MOV AH,09H ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,uppercase_character_input ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,1 ; Função responsável por ler um caractere qualquer do teclado e salvá-lo em "AL".
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV BL,AL ; Responsável por copiar o caractere lido em "AL" para "BL".

  MOV AH,09H ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,uppercase_character_input ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,1 ; Função responsável por ler um caractere qualquer do teclado e salvá-lo em "AL".
  INT 21H ; Conjunto de funções de entrada/saída.
  
  MOV BH,AL ; Responsável por copiar o caractere lido em "AL" para "BH".

  MOV AH,09H ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,alphabetic_output ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,2 ; Função responsável por exibir a mensagem na tela do usuário.
  CMP BL,BH ; Comparação entre os caracteres lidos.
  JAE ALPHABETIC_ORGANIZATION ; Se o caractere lido for maior ou igual ao segundo caractere lido, pule para a label "ALPHABETIC_ORGANIZATION".

  MOV DL,BL ; Movimentação/cópia do primeiro caractere lido para "DL".
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV DL,BH ; Movimentação/cópia do segundo caractere lido para "DL".
  INT 21H ; Conjunto de funções de entrada/saída.
  JMP EXIT ; Pule para a label "EXIT".

ALPHABETIC_ORGANIZATION: ; Label responsável por organizar os caracteres lidos em ordem alfabética.
  MOV DL,BH ; Movimentação/cópia do segundo caractere lido para "DL".
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV DL,BL ; Movimentação/cópia do primeiro caractere lido para "DL".
  INT 21H ; Conjunto de funções de entrada/saída.

EXIT: ; Label responsável por encerrar a execução do programa.
  MOV AH,4CH ; Responsável por "devolver" o controle ao sistema operacional.
  INT 21H ; Conjunto de funções de entrada/saída.

main endp
end main