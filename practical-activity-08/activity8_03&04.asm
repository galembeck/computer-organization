; Fazer um programa que leia um número hexadecimal do teclado.

; • Entrada de números hexadecimais:
;   – BX é assumido como registrador de armazenamento;
;   – string de caracteres "0" a "9" ou de "A" a "F", digitado no teclado;
;   – máximo de 16 bits de entrada ou máximo de 4 dígitos hexa.

; • Algoritmo básico em linguagem de alto nível:
;   - Inicializa BX
;   - Entra um caractere hexa
;   - WHILE caractere diferente de CR DO
;     - Converte caractere para binário
;     - Desloca BX 4 casas para a esquerda
;     - Insere valor binário nos 4 bits inferiores de BX
;     - Entra novo caractere
;   - END_WHILE



; Fazer um programa que imprima um número hexadecimal.

; • Saída de números hexadecimais:
;   – BX é assumido como registrador de armazenamento;
;   – total de 16 bits de saída;
;   – string de caracteres HEXA é exibido no monitor de vídeo.

; • Algoritmo básico em linguagem de alto nível:
;   - FOR 4 vezes DO
;     - Mover BH para DL
;     - Deslocar DL 4 casas para a direita
;     - IF DL < 10
;       - THEN converte para caractere na faixa 0 a 9
;       - ELSE converte para caractere na faixa A a F
;     - END_IF
;   - Exibição do caractere no monitor de vídeo
;   - Rodar BX 4 casas à esquerda

title hexadecimal number reading & printing
.model small
.stack 100h

.data
  hexadecimal_input db 13, 10, 'Insert a hexadecimal number (up to 4 digits) and press enter: ', '$'
  hexadecimal_print db 13, 10, 'The hexadecimal number inserted is: ', '$'

.code 
main proc

  ; Linhas 28 e 29 são responsáveis por permitirem o acesso de '.data'.
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).|

  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,hexadecimal_input ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  XOR CX,CX

  INPUT_WHILE:
    CMP CX,4 ; Comparação do valor de "CX" com 4.
    JE CARRIAGE_RETURN ; Caso "CX" seja igual a 4, pula para o rótulo "END_WHILE".

    MOV AH,1 ; Função responsável por ler um caractere do teclado.
    INT 21H ; Conjunto de funções de entrada/saída.
    CMP AL,13 ; Comparação do valor digitado com "ENTER" (CR).
    JE CARRIAGE_RETURN ; Caso seja "ENTER", pula para a impressão.

    ; IF AL > 39h
      CMP AL,39h ; Comparação do valor digitado com "9".
      JG HEXADECIMAL_LETTER_NUMBER ; Caso seja maior que "9", pula para o rótulo "HEXADECIMAL_LETTER_NUMBER".

      ; THEN
        AND AL,0Fh ; Conversão de número para caractere.
        JMP SHIFT_OPERATION ; Pula para o rótulo de operação de deslocamento.

    ; ELSE
      HEXADECIMAL_LETTER_NUMBER: ; Criação/definição do rótulo "HEXADECIMAL_LETTER_NUMBER".
      SUB AL,37h ; Conversão de caractere (letra maiúscula - hexadecimal) para número.

      SHIFT_OPERATION: ; Criação/definição do rótulo "SHIFT_OPERATION".
        SHL BX,4 ; Deslocamento de "BX" 4 casas para a esquerda.
        OR BL,AL ; Inserção do valor binário nos 4 bits inferiores de "BX".
        INC CX ; Incremento de "CX" em 1.

    JMP INPUT_WHILE ; Repete o loop enquanto "CX" é diferente de 4.

  CARRIAGE_RETURN: ; Criação/definição do rótulo "CARRIAGE_RETURN" para pular e iniciar nova linha.
    MOV DL,0Ah ; Movimentação/cópia de "0Ah" para "DL".
    MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
    INT 21H ; Conjunto de funções de entrada/saída.

    MOV DL,0Dh ; Movimentação/cópia de "0Dh" para "DL".
    MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
    INT 21H ; Conjunto de funções de entrada/saída. Pular linha.

    MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
    LEA DX,hexadecimal_print ; Passagem do endereço do texto pelo uso do "offset".
    INT 21H ; Conjunto de funções de entrada/saída.

  XOR CX,CX ; Redefinição de "CX".

  PRINT_FOR: ; Criação/definição do rótulo "PRINT_FOR".
    CMP CX,4 ; Comparação do valor de "CX" com 4.
    JE EXIT ; Caso "CX" seja igual a 4, pula para o rótulo "EXIT".

    MOV DL,BH ; Movimentação/cópia de "BH" para "DL".
    SHR DL,4 ; Deslocamento de "DL" 4 casas para a direita.
    CMP DL,9 ; Comparação do valor de "DL" com 9.
    JG HEXADECIMAL_NUMBER_LETTER ; Caso seja maior que 9, pula para o rótulo "HEXADECIMAL_NUMBER_LETTER".

    AND DL,0Fh ; Conversão de número para caractere.
    OR DL,30h ; Conversão de caractere para número.
    JMP ROTATE_OPERATION ; Pula para o rótulo de operação de rotação.

    HEXADECIMAL_NUMBER_LETTER: ; Criação/definição do rótulo "HEXADECIMAL_NUMBER_LETTER".
      ADD DL,37h ; Conversão de número para caractere (letra maiúscula - hexadecimal).

    ROTATE_OPERATION: ; Criação/definição do rótulo "ROTATE_OPERATION".
      MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
      INT 21H ; Conjunto de funções de entrada/saída.

      ROL BX,4 ; Deslocamento de "BX" 4 casas para a esquerda.
     
    INC CX ; Incremento de "CX" em 1.

    JMP PRINT_FOR ; Repete o loop enquanto "CX" é diferente de 4.

  EXIT: ; Definição do rótulo "EXIT" para encerramento o programa.
    MOV AH,4Ch ; Função responsável por encerrar o programa.
    INT 21H ; Conjunto de funções de entrada/saída.

main endp
end main