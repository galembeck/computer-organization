; Crie um programa em linguagem assembly que realize a multiplicação entre dois
; números (de 0 a 9) por meio de somas sucessivas e exiba o resultado da multiplicação.

; OBS: O programa deve ser comentado. Suponha que as entradas não gerarão um produto com 2 dígitos.

title multiplication by successive sums ; Título do arquivo/programa.
.model small ; Modelo necessário para leitura/execução do programa.
.stack 100h ; Define o tamanho da pilha.

.data
  MULTIPLYING_INPUT DB 'Insert/type a multiplying: ', '$'
  MULTIPLIER_INPUT DB 13, 10, 'Insert/type a multiplier: ', '$'
  MULTIPLICATION_RESULT DB 13, 10, 'The result of the multiplication is: ', '$'

.code
main proc
  ; Linhas 18 e 19 são responsáveis por permitirem o acesso de '.data'.
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).

  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,MULTIPLYING_INPUT ; Passagem do endereço do texto pelo uso do "offset".
  ; MOV DX, offset multiplying_input ; Funcionamento semelhante ao 'LEA DS, multiplying_input'.
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,1 ; Função responsável por ler um caractere do teclado.
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV BL,AL ; Movimentação/cópia de "AL" para "BL".

  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,MULTIPLIER_INPUT ; Passagem do endereço do texto pelo uso do "offset".
  ; MOV DX, offset multiplier_input ; Funcionamento semelhante ao 'LEA DS, multiplier_input'.
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,1 ; Função responsável por ler um caractere do teclado.
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV BH,AL ; Movimentação/cópia de "AL" para "BL".

  AND BL,0Fh ; Subtração de "30h" de "BL" para conversão de caractere para número.
  AND BH,0Fh ; Subtração de "30h" de "BH" para conversão de caractere para número.

  XOR CL,CL ; Inicialização do valor do contador "CL" inicialmente como 0.

  MULTIPLICATION: ; Criação/definição do rótulo "MULTIPLICATION".
    ADD CL,BL ; Adição do valor do "multiplicando" em "CL".
    DEC BH ; Decréscimo do valor do "multiplicador" ("BH").
    OR BH,BH ; Comparação do valor do "multiplicador" ("BH") com "0".
    JNZ MULTIPLICATION ; Caso o valor do "Multiplicador" ("BH") seja diferente de 0, pula para o rótulo "MULTIPLICATION" para continuar com a multiplicação (somas sucessivas).

  PRINT_RESULTS: ; Criação/definição do rótulo "PRINT_RESULTS".
    MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
    LEA DX,MULTIPLICATION_RESULT ; Passagem do endereço do texto pelo uso do "offset".
    ; MOV DX, offset multiplication_result ; Funcionamento semelhante ao 'LEA DS, multiplication_result'.
    INT 21H ; Conjunto de funções de entrada/saída.

    OR CL,30h ; Adição de "30h" de "CL" para conversão de número para caractere.

    MOV DL,CL ; Movimentação/cópia do conteúdo de "CL" para "DL".
    MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
    INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,4CH ; Função responsável por encerrar o programa.
  INT 21H ; Conjunto de funções de entrada/saída.

main endp
end main
