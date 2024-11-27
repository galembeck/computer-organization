; Faça um programa que conte quantas letras “A” tem em um nome guardado num vetor de tamanho 20.

title count letter A in a name
.model small
.stack 100h

.data 
  name_vector db 20 dup(0)
  counter_total db 'Total of letter "A": ', '$'
  
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

  ; Linhas 25 e 26 são responsáveis por permitirem o acesso de '.data'.
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).

  MOV CX,20 ; Definição do tamanho do vetor (20 elementos).
  LEA BX,name_vector ; Passagem do endereço do vetor pelo uso do "offset".

  READ: ; Criação/definição do rótulo "READ".
    MOV AH,1 ; Função responsável por ler um caractere da tela do usuário.
    INT 21h ; Conjunto de funções de entrada/saída.

    CMP AL,13 ; Comparação entre AL e 13.
    JE COUNT_A ; Se AL for igual a 13, pula para "COUNT_A".

    MOV [BX],AL ; Movimentação do valor de AL para o vetor.
    INC BX ; Incremento de BX.

    LOOP READ ; Repete o loop enquanto "CX" é diferente de 0.

  MOV CX,20 ; Definição do tamanho do vetor (20 elementos).
  XOR DX,DX ; Redefinição de DX para 0.
  LEA BX,name_vector ; Passagem do endereço do vetor pelo uso do "offset".

  COUNT_A: ; Criação/definição do rótulo "COUNT_A".
    CMP BYTE PTR [BX],'a' ; Comparação entre o valor do vetor e 'a'.
    JNE NOT_A ; Se o valor do vetor for diferente de 'a', pula para "NOT_A".

    INC BX ; Incremento de BX.
    INC DL ; Incremento de DL.

    JMP NEXT ; Pula para "NEXT".

    NOT_A: ; Criação/definição do rótulo "NOT_A".
      INC BX ; Incremento de BX.

    NEXT: ; Criação/definição do rótulo "NEXT".
      LOOP COUNT_A ; Repete o loop enquanto "CX" é diferente de 0.

  PUSH DX ; Empilhamento de DX.

  jumpLine ; Chamada da macro "jumpLine".

  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,counter_total ; Passagem do endereço da string pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  POP DX ; Desempilhamento de DX.

  ADD DL,30h ; Adição de 30h ao valor de DL (conversão de número para caractere).
  MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,4CH ; Função responsável por finalizar o programa.
  INT 21H ; Conjunto de funções de entrada/saída.
  
main endp
end main