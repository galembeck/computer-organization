; Faça um programa que imprima a matriz abaixo, como uma matriz (linhas e colunas). 

; Usar procedimentos e macros.

; MATRIZ DB 1,2,3,4
;        DB 4,3,2,1
;        DB 5,6,7,8
;        DB 8,7,6,5


title printing a defined matrix
.model small
.stack 100h

.data
  MATRIX DB 1,2,3,4
         DB 4,3,2,1
         DB 5,6,7,8
         DB 8,7,6,5
  MATRIX_OUTPUT DB 10, 13, 'The matrix is: ', '$'

jump_line MACRO ; Definição/criação do MACRO de pular linha ("jump_line").
  PUSH AX ; Empilhamento do registrador AX.
  PUSH DX ; Empilhamento do registrador DX.

  MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
  MOV DL,0DH ; Movendo o valor 0DH ("carriage return)" para o registrador DL.
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
  MOV DL,0AH ; Movendo o valor 0AH ("line feed") para o registrador DL.
  INT 21H ; Conjunto de funções de entrada/saída.

  POP DX ; Desempilhamento do registrador DX.
  POP AX ; Desempilhamento do registrador AX.
ENDM ; Fim da definição do MACRO.

.code 
main PROC ; Início do procedimento principal.

  ; Linhas 36 e 37 são responsáveis por permitirem o acesso ao segmento de dados ".data".
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).

  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,MATRIX_OUTPUT ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  jump_line ; Chamada do MACRO "jump_line".

  XOR BX,BX ; Zerando o registrador BX.
  XOR SI,SI ; Zerando o registrador SI.

  LEA BX,MATRIX ; Passagem do endereço da matriz pelo uso do "offset".

  MOV CH,4 ; Movendo o valor 4 para o registrador CH.
  MOV CL,4 ; Movendo o valor 4 para o registrador CL.

  CALL MATRIX_PRINT ; Chamada do procedimento "MATRIX_PRINT".

  MOV AH,4CH ; Função responsável por finalizar o programa.
  INT 21H ; Conjunto de funções de entrada/saída.

main ENDP

MATRIX_PRINT PROC
  PRINT_MATRIX: ; Rótulo de impressão da matriz.
    PRINT_LINE: ; Rótulo de impressão da linha.
      MOV DL,[BX][SI] ; Movendo o valor da matriz para o registrador DL.

      MOV AH,02H ; Função responsável por imprimir um caractere na tela do usuário.
      OR DL,30H ; Operação lógica "OR" entre DL e 30H (conversão de número para caractere).
      INT 21H ; Conjunto de funções de entrada/saída.

      MOV DL,20H ; Movendo o valor 20H para o registrador DL.
      INT 21H ; Conjunto de funções de entrada/saída.
    
      INC SI ; Incremento do registrador SI.
      DEC CH ; Decremento do registrador CH.
      JNZ PRINT_LINE ; Condição de impressão da linha (CH > 0 -> imprime a linha).

    jump_line ; Chamada do MACRO "jump_line".

    ADD BX,4 ; Adição de 4 ao registrador BX.
    XOR SI,SI ; Zerando o registrador SI.

    MOV CH,4 ; Movendo o valor 4 para o registrador CH.

    DEC CL ; Decremento do registrador CL.
    JNZ PRINT_MATRIX ; Condição de impressão da matriz (CL > 0 -> imprime a matriz).

  RET ; Fim do procedimento.
MATRIX_PRINT ENDP
end main 
