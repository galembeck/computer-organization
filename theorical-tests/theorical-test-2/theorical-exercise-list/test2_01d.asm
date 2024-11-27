title octal number entry, without signal, returning it in AX
.model small
.stack 100h

.data
  INPUT_PROMPT DB 'Insert a number, without signal: ', '$'

.code
MAIN PROC

  ; Linhas 12 e 13 são responsáveis por permitirem o acesso de '.data'.
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).

  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,INPUT_PROMPT ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  XOR BX,BX ; Redefinição de "BX" como 0.
  MOV CX,5 ; Inicialização do contador "CX" com 5.

  MOV AH,1 ; Função responsável por ler um caractere do teclado.

  NUMBER_ENTRY: ; Rótulo de entrada de número.
    INT 21H ; Conjunto de funções de entrada/saída.

    CMP AL,0DH ; Verificação de nova linha.
    JE CONTINUE ; Desvio condicional para continuação.
    AND AL,0FH ; Máscara para obtenção do número.
    ADD BL,AL ; Soma dos números.
    SHL BX,3 ; Deslocamento de bits para a esquerda.

    LOOP NUMBER_ENTRY ; Laço de repetição para entrada de número.

    CONTINUE: ; Rótulo de continuação.
      SHR BX,3 ; Deslocamento de bits para a direita.
      MOV AX,BX ; Movimentação do valor de "BX" para "AX".

  MOV AH,4CH ; Função responsável por encerrar o programa.
  INT 21H ; Conjunto de funções de entrada/saída.

MAIN ENDP

END MAIN