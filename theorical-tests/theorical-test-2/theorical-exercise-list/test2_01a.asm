title count bits 1 on a charachter
.model small
.stack 100h

.data
  INPUT_PROMPT DB 'Enter a character: ', '$'
  BITS_COUNTER DB 10, 13, 'The amount of bits 1 is in the character is: ', '$'

.code
MAIN PROC

  ; Linhas 12 e 13 são responsáveis por permitirem o acesso de '.data'.
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).

  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,INPUT_PROMPT ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  XOR BX,BX ; Redefinição de "BX" como 0.
  MOV CX,8 ; Inicialização do contador "CX" com 8.

  MOV AH,1 ; Função responsável por ler um caractere do teclado.

  CALL VERIFY_BITS ; Chamada do procedimento de verificação de bits.

  XOR AX,AX ; Redefinição de "AX" como 0.

  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,BITS_COUNTER ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
  MOV DL,BL ; Movimentação do valor de "BL" para "DL".
  OR DL,30H ; Conversão de número para caractere.
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,4CH ; Função responsável por encerrar o programa.
  INT 21H ; Conjunto de funções de entrada/saída.

MAIN ENDP

VERIFY_BITS PROC 
  INT 21H ; Conjunto de funções de entrada/saída.

  VERIFY: ; Rótulo de verificação de bits.
    SHR AL,1 ; Deslocamento de bits para a direita.
    JNC CONTINUE ; Verificação de bit 1.
    INC BL ; Incremento do contador de bits 1.

    CONTINUE: ; Rótulo de continuação.
      LOOP VERIFY ; Laço de repetição para verificação de bits.
  RET ; Retorno do procedimento.
VERIFY_BITS ENDP

END MAIN