; Fazer um programa que (um procedimento para cada):

; 1 – leia um string e armazene na memória e imprima o string lido
; 2 – copie este sting em outro
; 3 – compara o string lido com um já armazenado na memória e diga se são iguais ou não.
; 4 - verifique quantas letras ‘a’ tem o string

TITLE STRING MANIPULATION
.MODEL SMALL
.STACK 100H



.DATA
  ORIGIN_STRING DB 10 DUP(?)
  STORED_STRING DB 'ABCD'
  DESTINATION_STRING DB 10 DUP(?)
  STRING_LENGTH DB 10
  CHAR DB 'A'
  
  INPUT_PROMPT DB 'Enter the string (max 10 characters): ', '$'
  OUTPUT_PROMPT DB 'The string inserted is: ', '$'
  COPIED_OUTPUT DB 'The copied string is: ', '$'
  SIMILAR_CHARS DB 'The amount of characters similar to A is: ', '$'


  
NEW_LINE MACRO PARAM
  LOCAL REPEAT

  PUSH AX
  PUSH DX

  MOV CX,PARAM

  REPEAT:
    MOV AH,02H
    MOV DL,0DH
    INT 21H

    MOV DL,0AH
    INT 21H

  LOOP REPEAT

  POP DX
  POP AX
ENDM



.CODE
MAIN PROC

  MOV AX,@DATA
  MOV DS,AX
  MOV ES,AX

  MOV CX,10

  MOV AH,09H
  LEA DX,INPUT_PROMPT
  INT 21H

  LEA DI,ORIGIN_STRING
  CALL READ_STRING

  XOR CX,CX
  MOV CL,STRING_LENGTH

  NEW_LINE 1

  MOV AH,09H
  LEA DX,OUTPUT_PROMPT
  INT 21H

  LEA SI,ORIGIN_STRING
  CALL PRINT_STRING

  LEA SI,ORIGIN_STRING
  LEA DI,DESTINATION_STRING

  XOR CX,CX
  MOV CL,STRING_LENGTH
  
  CALL COPY_STRING

  XOR CX,CX
  MOV CL,STRING_LENGTH

  NEW_LINE 2

  MOV AH,09H
  LEA DX,COPIED_OUTPUT
  INT 21H

  LEA SI,DESTINATION_STRING
  CALL PRINT_STRING

  XOR CX,CX
  MOV CL,STRING_LENGTH

  LEA DI,ORIGIN_STRING
  CALL CHAR_COMPARISON

  EXIT:
    MOV AH,4CH
    INT 21H

MAIN ENDP



; Procedimento de leitura de um string/vetor utilizando "STOSB".
; Entrada: CX contém o tamanho máximo do string/vetor.
;          DI aponta para o string/vetor.
; Saída: String/vetor lido é armazenado na memória.
READ_STRING PROC
  PUSH AX ; Salva o valor de AX na pilha.

  CLD ; Limpa o bit de direção do registrador de flags (o vetor é percorrido da esquerda para a direita).

  MOV AH,01H ; Função de leitura de um caractere do teclado.

  READ_LOOP:
    INT 21H ; COnjunto de funções de entrada/saída.

    CMP AL,0DH ; Compara o caractere lido com o caractere "ENTER".
    JE END_READ ; Se for "ENTER", encerra a leitura.

    STOSB ; Armazena o caractere lido na memória.

  LOOP READ_LOOP ; Repete o processo até que o contador CX seja igual a zero.

  END_READ:
    SUB STRING_LENGTH,CL ; Subtrai o valor de CL do valor armazenado em STRING_LENGTH.
    
    POP AX ; Restaura o valor de AX da pilha.

  RET
READ_STRING ENDP



; Procedimento de impressão de um string/vetor utilizando "LODSB".
; Entrada: Variável "STRING_LENGHT" contém o tamanho do string/vetor armazenado.
;          SI aponta para o string/vetor.
; Saída: String/vetor armazenado é impresso na tela.
PRINT_STRING PROC
  PUSH AX ; Salva o valor de AX na pilha.
  PUSH DX ; Salva o valor de DX na pilha.

  CLD ; Limpa o bit de direção do registrador de flags (o vetor é percorrido da esquerda para a direita).

  ; NEW_LINE ; Macro para imprimir uma nova linha.
  MOV AH,02H
  MOV DL,10
  INT 21H

  XOR CX,CX ; Limpa o registrador CX.
  MOV CL,STRING_LENGTH ; Move o valor armazenado em STRING_LENGTH para CL.

  PRINT_LOOP:
    LODSB ; Carrega o caractere apontado por SI em AL.

    MOV DL,AL ; Move o valor de AL para DL.
    INT 21H ; Conjunto de funções de entrada/saída.

  LOOP PRINT_LOOP ; Repete o processo até que o contador CX seja igual a zero.

  POP DX ; Restaura o valor de DX da pilha.
  POP AX ; Restaura o valor de AX da pilha.

  RET
PRINT_STRING ENDP



;Procedimento de cópia de um string/vetor utilizando "LODSB" e "STOSB".
; Entrada: Variável "STRING_LENGTH" contém o tamanho do string/vetor armazenado.
;          SI aponta para o string/vetor de origem e DI para o vetor de destino.
; Saída: String/vetor de origem é copiado para o vetor de destino e salvo namemória.
COPY_STRING PROC
  PUSH AX ; Salva o valor de AX na pilha.
  PUSH DX ; Salva o valor de DX na pilha.
  
  CLD ; Limpa o bit de direção do registrador de flags (o vetor é percorrido da esquerda para a direita).

  REP MOVSB ; Repete o processo de mover o caractere apontado por SI para o endereço apontado por DI até que o contador CX seja igual a zero.

  POP DX ; Restaura o valor de DX da pilha.
  POP AX ; Restaura o valor de AX da pilha.

  RET 
COPY_STRING ENDP



; Procedimento de comparação de um caractere específico em um string/vetor armazenado na memória.
; Entrada: Variável "STRING_LENGTH" contém o tamanho do string/vetor armazenado.
;          DI aponta para o vetor de origem.
;          Variável "CHAR" contém o caractere a ser comparado.
; Saída: Quantidade de vezes que o caractere foi encontrado no string/vetor armazenado na memória.
CHAR_COMPARISON PROC
  PUSH AX ; Salva o valor de AX na pilha.
  PUSH DX ; Salva o valor de DX na pilha.

  XOR DX,DX ; Limpa o registrador DX.

  CLD ; Limpa o bit de direção do registrador de flags (o vetor é percorrido da esquerda para a direita).

  MOV AL,CHAR ; Move o valor armazenado em CHAR para AL.

  COMPARISON_LOOP:
    SCASB ; Percorre o vetor (analisando-o) da esquerda para a direita (CLD) procurando o caractere armazenado em AL.

    JNZ CONTINUE_COMPARISON ; Se o caractere não for encontrado, continua a comparação.

    INC DL ; Caso o caractere seja encontrado, incrementa o valor de DL.

    CONTINUE_COMPARISON:
      LOOP COMPARISON_LOOP ; Repete o processo até que o contador CX seja igual a zero.

      MOV AH,02H ; Função de impressão de um caractere na tela.
      OR DL,30H ; Realiza a operação lógica OR entre DL e 30H (conversão de número para caractere).
      INT 21H ; Conjunto de funções de entrada/saída.
    
  POP DX ; Restaura o valor de DX da pilha.
  POP AX ; Restaura o valor de AX da pilha.
  
  RET
CHAR_COMPARISON ENDP



END MAIN