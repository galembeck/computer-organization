; Faça um programa que leia 4 caracteres numéricos, um de cada vez, e imprima estes números lidos, 
; após cada leitura, trocando os caracteres "0" e "X" por "*", quando impressas.

title printing * instead of 0 or X ; Título do arquivo.
.model small ; Modelo necessário para leitura do programa.
.stack 100h ; Tamanho da pilha.
 
.data 
  character_input db 'Type a character: ', '$'
  character_print db 13, 10, 'Character inserted: ', '$'

.code 
main proc
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).

  MOV AH,09H ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,character_input ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,1 ; Função responsável por ler um caractere qualquer do teclado e salvá-lo em "AL".
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV BL,AL ; Responsável por copiar o caractere lido em "AL" para "BL".

  CMP BL,30H ; Comparação do caractere lido com o caractere "0".
  JZ CHANGE_X ; Se o caractere lido for "0", pule para a label "CHANGE_X".

  JMP PRINT ; Pule para a label "PRINT".

CHANGE_X: ; Label responsável por trocar o caractere "0" por "*".
  MOV BL,58H ; Movimentação/cópia do caractere "*" para "BL".

  JMP PRINT ; Pule para a label "PRINT".

  JMP EXIT ; Pule para a label "EXIT".

PRINT: ; Label responsável por imprimir o caractere lido.
  MOV AH,09H ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,character_print ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,02H ; Responsável por exibir a mensagem na tela do usuário.
  MOV DL,BL ; Movimentação/cópia do caractere lido para "DL".
  INT 21H ; Conjunto de funções de entrada/saída.

  JMP EXIT ; Pule para a label "EXIT".

EXIT: ; Label responsável por encerrar a execução do programa.
  MOV AH,4CH ; Responsável por "devolver" o controle ao sistema operacional.
  INT 21H ; Conjunto de funções de entrada/saída.

main endp
end main