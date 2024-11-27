; Faça um programa que conte quantas vogais tem em um vetor nome de tamanho 20.

title vowel counter
.model small
.stack 100h

.data
  NAME_VECTOR DB 20 DUP(0)
  VOWEL_MESSAGE DB 13, 10, 'The amount of vowels in the name is: ', '$'

jumpLine MACRO ; Criação de uma macro para pular uma linha.
  MOV DL, 0AH ; Movimentação de 0AH ("line feed" - ASCII) para DL.
  MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV DL, 0DH ; Movimentação de 0DH ("carriage return" - ASCII) para DL.
  MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
  INT 21H ; Conjunto de funções de entrada/saída.
ENDM

.code
main proc 

  MOV AX,@DATA
  MOV DS,AX

  MOV CX,20
  XOR DX,DX
  LEA BX,NAME_VECTOR

  READ_NAME:
    MOV AH,1
    INT 21H

    CMP AL,13
    JE COUNT_VOWELS

    MOV [BX],AL
    INC BX

    INC DX

    LOOP READ_NAME

  MOV CX,DX
  XOR DX,DX

  COUNT_VOWELS:
    CMP BYTE PTR [BX],'a'
    JE IS_VOWEL
    CMP BYTE PTR [BX],'e'
    JE IS_VOWEL
    CMP BYTE PTR [BX],'i'
    JE IS_VOWEL
    CMP BYTE PTR [BX],'o'
    JE IS_VOWEL
    CMP BYTE PTR [BX],'u'
    JE IS_VOWEL

    INC BX

    JMP NEXT

    IS_VOWEL:
      INC DX

    INC BX

    NEXT:
      LOOP COUNT_VOWELS

  PUSH DX

  jumpLine

  MOV AH,9
  LEA DX,VOWEL_MESSAGE
  INT 21H

  POP DX

  MOV AH,2
  OR DL,30H
  INT 21H

  MOV AH,4Ch
  INT 21H

main endp
end main