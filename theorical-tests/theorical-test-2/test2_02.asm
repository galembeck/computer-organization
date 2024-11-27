; Faça um programa que leia a diagonal principal de uma matriz 4X4 tamanho DB.

title exercise 02
.model small
.stack 100h

.data 
  matrix db 1, 0, 0, 0 ; 0;0 | 0;1 | 0;2 | 0;3
         db 0, 2, 0, 0 ; 4;0 | 4;1 | 4;2 | 4;3
         db 0, 0, 3, 0 ; 8:0 | 8;1 | 8;2 | 8;3
         db 0, 0, 0, 4 ; 12;0 | 12;1 | 12;2 | 12;3
  main_diagonal db 'The main diagonal of the matrix is: ', '$'

.code 
main proc

  MOV AX,@DATA 
  MOV DS,AX

  XOR BX,BX
  XOR SI,SI

  LEA BX,matrix

  MOV CX,4

  MOV AH,9
  LEA DX,main_diagonal
  INT 21H

  READ:
    MOV DL,[BX][SI]
    ADD DL,30h

    MOV AH,2
    INT 21H

    ADD BX,4
    INC SI ; ADD SI,1

    LOOP READ

  MOV AH,4CH
  INT 21H

main endp
end main