title main diagonal of a 4x4 matrix
.model small
.stack 100h

.data
  MATRIX DB 1, 0, 0, 0
         DB 0, 1, 0, 0
         DB 0, 0, 1, 0
         DB 0, 0, 0, 1
  SUM_RESULT DB 'The sum of the main diagonal is: ', '$'

.code
MAIN PROC

  ; Linhas 16 e 17 são responsáveis por permitirem o acesso de '.data'.
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).

  XOR BX,BX ; Redefinição de "BX" como 0.
  XOR SI,SI ; Redefinição de "SI" como 0.

  LEA BX,MATRIX ; Carregamento do endereço da matriz "MATRIX" em "BX".

  XOR AX,AX ; Redefinição de "AX" como 0.
  MOV CX,4 ; Inicialização do contador "CX" com 4.

  CALL DIAGONAL_SUM_PROCESS ; Chamada do procedimento de soma da diagonal principal.

  CALL SUM_PRINT_PROCESS ; Chamada do procedimento de impressão da soma.

  MOV AH,4CH ; Função responsável por encerrar o programa.
  INT 21H ; Conjunto de funções de entrada/saída.

MAIN ENDP

DIAGONAL_SUM_PROCESS PROC
  DIAGONAL_SUM: ; Rótulo de soma da diagonal.
    ADD AX,[BX][SI] ; Soma dos elementos da diagonal.

    ADD BX,4 ; Incremento do índice da matriz.
    INC SI ; Incremento do índice da matriz.

  LOOP DIAGONAL_SUM ; Laço de repetição para soma da diagonal.
DIAGONAL_SUM_PROCESS ENDP

SUM_PRINT_PROCESS PROC  
  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,SUM_RESULT ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV DX,AX ; Movimentação do valor de "AX" para "DX".
  MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
  OR DX,30H ; Conversão de número para caractere.
  INT 21H ; Conjunto de funções de entrada/saída.
SUM_PRINT_PROCESS ENDP

END MAIN