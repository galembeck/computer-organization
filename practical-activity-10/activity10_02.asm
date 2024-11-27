; Escreva um programa que leia todos os elementos de uma matriz 4 X 4 de números inteiros entre 0 e 6, inclusive. 

; O programa deverá ler a matriz, imprimir a matriz lida, fazer a soma dos elementos, armazenar e imprimir esta soma. 

; Usar um procedimento para ler, outro para somar e outro para imprimir.

title reading and summing a defined matrix
.model small
.stack 100h

.data
  MATRIX DB 16 DUP(?)
  INPUT_PROMPT DB 'Insert a element of the matrix (0-6): ', '$'
  SUM DW 0

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
main PROC

  MOV AX,@DATA 
  MOV DS,AX

  CALL READ_MATRIX

  jump_line

  CALL PRINT_MATRIX

  jump_line

  CALL SUM_MATRIX

  CALL PRINT_SUM

  MOV AH,4CH
  INT 21H

main ENDP

READ_MATRIX PROC
  LEA SI,MATRIX

  MOV CX,16

  READ_LOOP:
    MOV AH,9
    LEA DX,INPUT_PROMPT
    INT 21H

    MOV AH,1
    INT 21H

    AND AL,0FH
    MOV [SI],AL

    jump_line

    INC SI

  LOOP READ_LOOP

  RET
READ_MATRIX ENDP

PRINT_MATRIX PROC
  LEA SI,MATRIX

  MOV CX,4

  LINE_LOOP:
    CALL PRINT_MATRIX_LINE

    jump_line

  LOOP LINE_LOOP

  RET
PRINT_MATRIX ENDP

PRINT_MATRIX_LINE PROC
  LEA SI,MATRIX

  MOV BX,4

  COLUMN_LOOP:
    MOV DL,[SI]
    OR DL,30H 
    MOV AH,2
    INT 21H

    MOV AH,2
    MOV DL,20H
    INT 21H

    INC SI
    DEC BX
    JNZ COLUMN_LOOP

  RET
PRINT_MATRIX_LINE ENDP

SUM_MATRIX PROC
  LEA SI,MATRIX

  XOR AX,AX
  MOV CX,16

  SUM_LOOP:
    ADD AL,[SI]
    INC SI

  LOOP SUM_LOOP

  DIVIDE_DECIMAL:
    XOR CX,CX
    MOV BX,10

    DIVIDE_LOOP:
      XOR DX,DX
      DIV BX
      PUSH DX 
      INC CX

      OR AX,AX
      JNE DIVIDE_LOOP

      MOV AH,2

  RET
SUM_MATRIX ENDP

PRINT_SUM PROC
  PRINT_LOOP:
    POP DX
    OR DL,30H
    INT 21H

    LOOP PRINT_LOOP

  RET
PRINT_SUM ENDP
end main