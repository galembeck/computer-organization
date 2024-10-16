; Escreva um programa que inverta a ordem de um vetor de 7 posições, isto é, o primeiro
; elemento se tornará o último, o último se tornará o primeiro e assim sucessivamente. 

; Ler o vetor e imprimir depois de inverter a ordem. 

; Utilizar BX, SI e DI nas diversas manipulação de vetor (ler, inverter e imprimir).
; NÃO UTILIZAR UM VETOR AUXILIAR. 

title vector conversion program
.model small
.stack 100h

.data
  vector db 1, 2, 3, 4, 5, 6, 7

.code
main proc

  ; Linhas 20 e 21 são responsáveis por permitirem o acesso de '.data'.
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).

  XOR SI,SI ; Redefinição de SI.
  MOV DI,6 ; Inicializa DI com o tamanho do vetor - 1 (0 até 6).

  CONVERSION: ; Criação/definição do rótulo "CONVERSION".
    CMP SI,DI ; Compara o valor de "SI" com o valor de "DI".
    JGE PRINT ; Se "SI" for maior ou igual a "DI", então imprime o vetor.

    MOV AL,vector[SI] ; Movimentação do valor da primeira posição do vetor para AL.
    MOV BL,vector[DI] ; Movimentação do valor da última posição do vetor para BL.

    MOV vector[SI],BL ; Movimentação do valor de BL para a primeira posição do vetor.
    MOV vector[DI],AL ; Movimentação do valor de AL para a última posição do vetor.

    INC SI ; Incremento de SI.
    DEC DI ; Decremento de DI.
    JMP CONVERSION ; Salto para o rótulo "CONVERSION".

  PRINT: ; Criação/definição do rótulo "PRINT".
    MOV CX,7 ; Definição do tamanho do vetor (7 elementos).
    XOR BX,BX ; Redefinição de BX.

    PRINT_LOOP: ; Criação/definição do rótulo "PRINT_LOOP".
      MOV DL,vector[BX] ; Movimentação do valor do vetor para DL.
      ADD DL,30h ; Adição de 30h ao valor de DL (conversão de número para caractere, permitindo a impressão).
      MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
      INT 21H ; Conjunto de funções de entrada/saída.

      INC BX ; Incremento de BX.
      LOOP PRINT_LOOP ; Repete o loop enquanto "CX" é diferente de 0.

  MOV AH,4Ch ; Função responsável por finalizar o programa.
  INT 21H ; Conjunto de funções de entrada/saída.

main endp
end main
