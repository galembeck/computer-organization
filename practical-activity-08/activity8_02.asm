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

title binary number printing
.model small
.stack 100h

.code
main proc

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