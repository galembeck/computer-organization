title initial leters
.model small
.stack 100h

.data
  NAME_VECTOR DB 10 DUP(?)
  INPUT_PROMPT DB 'Enter your name: ', '$'
  CAPITAL_LETTERS DB 'The capital letters of the name are: ', '$'

jump_line MACRO
  PUSH AX ; Empilhamento de "AX".
  PUSH DX ; Empilhamento de "DX".

  MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
  MOV DL,0DH ; Caractere de nova linha.
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
  MOV DL,0AH ; Caractere de nova linha.
  INT 21H ; Conjunto de funções de entrada/saída.

  POP DX ; Desempilhamento de "DX".
  POP AX ; Desempilhamento de "AX".
ENDM

.code
MAIN PROC
  
  ; Linhas 12 e 13 são responsáveis por permitirem o acesso de '.data'.
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).
  
  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,INPUT_PROMPT ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  XOR BX,BX ; Redefinição de "BX" como 0.
  MOV CX,10 ; Inicialização do contador "CX" com 10.

  LEA BX,NAME_VECTOR ; Carregamento do endereço do vetor "NAME_VECTOR" em "BX".

  CALL READ_PROCESS ; Chamada do procedimento de leitura de caracteres.

  CALL CAPITAL_LETTERS_PROCESS ; Chamada do procedimento de verificação de letras maiúsculas.

  MOV AH,4CH ; Função responsável por encerrar o programa.
  INT 21H ; Conjunto de funções de entrada/saída.

MAIN ENDP

READ_PROCESS PROC
  MOV AH,1 ; Função responsável por ler um caractere do teclado.

  READ_NAME: ; Rótulo de leitura do nome.
    INT 21H ; Conjunto de funções de entrada/saída.

    MOV [BX],AL ; Armazenamento do caractere lido no vetor "NAME_VECTOR".
    INC BX ; Incremento do índice do vetor.
 
  LOOP READ_NAME ; Laço de repetição para leitura do nome.

  RET ; Retorno do procedimento.
READ_PROCESS ENDP

CAPITAL_LETTERS_PROCESS PROC
  jump_line ; Macro para pular uma linha.

  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,CAPITAL_LETTERS ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  XOR BX,BX ; Redefinição de "BX" como 0.
  MOV CX,10 ; Inicialização do contador "CX" com 10.

  MOV DL,[BX] ; Carregamento do primeiro caractere do vetor "NAME_VECTOR" em "DL".
  MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
  INT 21H ; Conjunto de funções de entrada/saída.

  VERIFY_CAPITAL: ; Rótulo de verificação de letras maiúsculas.
    CMP BYTE PTR [BX],20H ; Comparação do caractere com o espaço.
    JE PRINT_INITIAL ; Salto para impressão do caractere.

    INC BX ; Incremento do índice do vetor.

    JMP NEXT ; Salto para a próxima verificação.

    PRINT_INITIAL: ; Rótulo de impressão do caractere.
      INC BX ; Incremento do índice do vetor.

      MOV DL,[BX] ; Carregamento do caractere em "DL".
      MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
      INT 21H ; Conjunto de funções de entrada/saída.

    NEXT: ; Rótulo de próxima verificação.
      LOOP VERIFY_CAPITAL ; Laço de repetição para verificação de letras maiúsculas.

  RET ; Retorno do procedimento.
CAPITAL_LETTERS_PROCESS ENDP

END MAIN