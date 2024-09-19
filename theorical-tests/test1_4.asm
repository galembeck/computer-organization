; Faça um programa que leia 4 caracteres, um de cada vez, e imprima estes caracteres lidos, 
; após cada leitura, trocando as letras "a" e "A" por "*", quando impressas.

title printing * instead of a or A ; Título do arquivo.
.model small ; Modelo necessário para leitura do programa.
.stack 100h ; Tamanho da pilha.

.data
  character_input db 'Type a character: ', '$'
  character_print db 13, 10, 'Character inserted: ', '$'

.code
main proc
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).

  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,character_input ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,1 ; Função responsável por ler um caractere qualquer do teclado e salvá-lo em "AL".
  INT 21H ; Conjunto de funções de entrada/saída. 

  MOV BL,AL ; Responsável por copiar o caractere lido em "AL" para "BL".

  CMP BL,41H ; Comparação do caractere lido com o caractere "A".
  JZ CHANGE_ASTERISK ; Se o caractere lido for "A", pule para a label "CHANGE_ASTERISK".

  CMP BL,61H ; Comparação do caractere lido com o caractere "a".
  JZ CHANGE_ASTERISK ; Se o caractere lido for "a", pule para a label "CHANGE_ASTERISK".

  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,character_print ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,2 ; Responsável por exibir a mensagem na tela do usuário.
  MOV DL,BL ; Movimentação/cópia do caractere lido para "DL".
  INT 21H ; Conjunto de funções de entrada/saída.

  JMP EXIT ; Pule para a label "EXIT".

CHANGE_ASTERISK: ; Label responsável por trocar o caractere "a" ou "A" por "*".
  MOV BL,'*' ; Movimentação/cópia do caractere "*" para "BL".
  
  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,character_print ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,2 ; Responsável por exibir a mensagem na tela do usuário.
  MOV DL,BL ; Movimentação/cópia do caractere lido para "DL".
  INT 21H ; Conjunto de funções de entrada/saída.

  JMP EXIT ; Pule para a label "EXIT".

EXIT: ; Label responsável por encerrar a execução do programa.
  MOV AH,4CH ; Responsável por "devolver" o controle ao sistema operacional.
  INT 21H ; Conjunto de funções de entrada/saída.

main endp 
end main