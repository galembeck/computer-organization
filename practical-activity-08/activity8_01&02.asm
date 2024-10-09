; Fazer um programa que leia um número binário do teclado.

; • Entrada de números binários:
; – string de caracteres "0's" e "1's" fornecidos pelo teclado;
; – CR é o marcador de fim de string;
; – BX é assumido como registrador de armazenamento;
; – máximo de 16 bits de entrada.

; • Algoritmo básico em linguagem de alto nível:
; – Limpar BX
; – Entrar com um caractere "0" ou "1“
; – WHILE caractere diferente de CR DO
;   - Converte caractere para valor binário
;   - Deslocar BX 1 casa para a esquerda
;   - Inserir o valor binário lido no LSB de BX
;   - Entra novo caractere
; – END_WHILE



; Fazer um programa que imprima um número binário.

; • Saída de números binários:
; – BX é assumido como registrador de armazenamento;
; – total de 16 bits de saída;
; – string de caracteres "0's" e "1's" é exibido no monitor de vídeo.

; • Algoritmo básico em linguagem de alto nível:
; - FOR 16 vezes DO;
;  - rotação de BX à esquerda 1 casa binária (MSB vai para o CF)
;  - IF CF = 1
;     - THEN exibir no monitor caracter "1"
;     - ELSE exibir no monitor caracter "0"
;   - END_IF
; END_FOR

title binary number reading & printing
.model small
.stack 100h

.data
  binary_input db 13, 10, 'Insert a binary number (up to 16 bits) and press enter: ', '$'

.code
main proc

; Linhas 48 e 49 são responsáveis por permitirem o acesso de '.data'.
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).|

  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,binary_input ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  NUMBER_INPUT: ; Criação/definição do rótulo "BINARY_INPUT".
    MOV CX,16 ; Definição do tamanho da informação (16 bits).
    XOR BX,BX ; Redefinição de BX.

    MOV AH,1 ; Função responsável por ler um caractere do teclado.
    INT 21H ; Conjunto de funções de entrada/saída.

    INPUT_WHILE: ; Criação/definição do rótulo "INPUT_WHILE".
      CMP AL,0Dh ; Comparação do valor digitado com "ENTER" (CR).
      JE CARRIAGE_RETURN ; Caso seja "ENTER", pula para a impressão.

      AND AL,0Fh ; Execução da leitura. Mudança de caractere para número (0 ou 1).

      SHL BX,1  ; Abrir espaço para o novo dígito.
      OR BL,AL ; Digitar novo dígito no LSB.
      INT 21H ; Conjunto de funções de entrada/saída.

      LOOP INPUT_WHILE ; Repete o loop enquanto "CX" é diferente de 0.

    CARRIAGE_RETURN: ; Criação/definição do rótulo "CARRIAGE_RETURN" para pular e iniciar nova linha.
      MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
      MOV DL,10 ; Movimentação/cópia de "10h" para "DL".
      INT 21H ; Conjunto de funções de entrada/saída.

      MOV DL,13 ; Movimentação/cópia de "13h" para "DL".
      INT 21H ; Conjunto de funções de entrada/saída. Pular linha.

    PRINT: ; Criação/definição do rótulo "PRINT".
      MOV CX,16 ; Inicialização do valor do contador ("CX") inicialmente com 16

      PRINT_FOR: ; Criação/definição do rótulo "PRINT_FOR".
        ROL BX,1 ; Giro para a esquerda para que o primeiro número digitado possa ser impresso na sequência correta.
        JC BINARY_PRINT_1 ; Se o CF for 1, pula para "PRINT_1".

        MOV DL,'0' ; Caso contrário, imprime 0.
        INT 21H ; Conjunto de funções de entrada/saída.

        LOOP PRINT_FOR ; Repete o loop enquanto "CX" é diferente de 0.
        JMP EXIT ; Pula para o final para não imprimir um '1' desnecessário.

      BINARY_PRINT_1: ; Criação/definição do rótulo "BINARY_PRINT_1".
        MOV DL,'1' ; Movimentação/cópia de "1" para impressão.
        INT 21H ; Conjunto de funções de entrada/saída.
        LOOP PRINT_FOR ; Repete o loop enquanto "CX" é diferente de 0.

  EXIT: ; Definição do rótulo "EXIT" para encerramento o programa.
    MOV AH,4Ch ; Função responsável por encerrar o programa.
    INT 21H ; Conjunto de funções de entrada/saída.

main endp
end main