; Escreva um programa que pergunte ao usuário para teclar um dígito hexadecimal,
; exiba na próxima linha o seu valor decimal e pergunte ao usuário se deseja
; continuar a utilizar o programa.

; Caso o usuário digite "S" (sim), o programa se repete desde o começo; 
; Caso o usuário digite outro caractere, o programa termina. 

; Teste se o dígito hexa está na faixa de valores correta. 
; Se não estiver, exiba uma mensagem para o usuário tentar de novo.

title returning the decimal value of a hexadecimal digit
.model small
.stack 100h

.data
  hexadecimal_input db 'Insert a hexadecimal digit (it will be returned its decimal value): ', '$'
  decimal_output db 13, 10, 'The decimal value of the hexadecimal digit inserted is: ', '$'

  repeat_message db 13, 10, 'Do you want to repeat the process? [S/N]: ', '$'

  illegal_digit db 13, 10, 'The digit inserted is invalid/illegal (0-9 & A-F).', '$'

.code
main proc
  MOV AX,@DATA
  MOV DS,AX

DIGIT_INPUT:
  MOV AH,09H
  LEA DX,hexadecimal_input
  INT 21H

  MOV AH,1
  INT 21H

  MOV BL,AL

REPEAT:
  MOV AH,1
  INT 21H

  MOV BL,AL 

  CMP BL,53H
  JAE DIGIT_INPUT

  JMP EXIT

ILLEGAL:
  MOV AH,09H
  LEA DX,illegal_digit
  INT 21H

  JMP EXIT

EXIT: 
  MOV AH,4CH
  INT 21H

main endp
end main