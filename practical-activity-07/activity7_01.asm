; Crie um programa em linguagem assembly que realize a divisão inteira entre dois números (de 0 a 9) 
; por meio de subtrações sucessivas e exiba como resultado o quociente e o resto da divisão.

title division by successive subtractions ; Título do arquivo/programa.
.model small ; Modelo necessário para leitura/execução do programa.
.stack 100h ; Define o tamanho da pilha.

.data
  DIVIDEND_INPUT DB 'Insert/type a dividend: ', '$'
  DIVIDER_INPUT DB 13, 10, 'Insert/type a divider: ', '$'
  QUOTIENT_RESULT DB 13, 10, 'The quotient of the division is: ', '$'
  REST_RESULT DB 13, 10, 'The rest of the division is: ', '$'

.code
main proc
  ; Linhas 17 e 18 são responsáveis por permitirem o acesso de '.data'.
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).

  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,DIVIDEND_INPUT ; Passagem do endereço do texto pelo uso do "offset".
  ; MOV DX, offset dividend_input ; Funcionamento semelhante ao 'LEA DS, dividend_input'.
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,1 ; Função responsável por ler um caractere do teclado.
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV BL,AL ; Movimentação/cópia de "AL" para "BL".

  MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,DIVIDER_INPUT ; Passagem do endereço do texto pelo uso do "offset".
  ; MOV DX, offset divider_input ; Funcionamento semelhante ao 'LEA DS, divider_input'.
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,1 ; Função responsável por ler um caractere do teclado.
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV BH,AL ; Movimentação/cópia de "AL" para "BH".

  AND BL,0Fh ; Subtração de "30h" de "BL" para conversão de caractere para número.
  AND BH,0Fh ; Subtração de "30h" de "BH" para conversão de caractere para número.

  XOR CL,CL ; Inicialização do contador "CL" incialmente como 0.
  
  CMP BH,BL ; Comparação dos valores do "divisor" e do "dividendo".
  JG PRINT_RESULTS ; Caso o valor do "divisor" seja maior que o valor do "dividendo", pula diretamente para o rótulo "PRINT_RESULTS".

  DIVISION: ; Criação/definição do rótulo "DIVISION".
    SUB BL,BH ; Subtração do valor do "dividendo" do valor do "divisor" (divisão).
    INC CL ; Incremento do contado "CL" em 1.
    CMP BH,BL ; Comparação do valor do "divisor" com o "dividendo".
    JLE DIVISION ; Caso o valor do "divisor" seja menor ou igual o valor do "dividendo", pula de volta para o rótulo "DIVISION" para continuar a divisão.

  PRINT_RESULTS: ; Criação/definição do rótulo "PRINT_RESULTS".
    MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
    LEA DX,QUOTIENT_RESULT ; Passagem do endereço do texto pelo uso do "offset".
    ; MOV DX, offset quotient_result ; Funcionamento semelhante ao 'LEA DS, quotient_result'.
    INT 21H ; Conjunto de funções de entrada/saída.

    OR CL,30h ; Adição de "30h" de "CL" para conversão de número para caractere.

    MOV DL,CL ; Movimentação/cópia do conteúdo de "CL" para "DL".
    MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
    INT 21H ; Conjunto de funções de entrada/saída.

    MOV AH,9 ; Função responsável por imprimir uma string na tela do usuário.
    LEA DX,REST_RESULT ; Passagem do endereço do texto pelo uso do "offset".
    ; MOV DX, offset rest_result ; Funcionamento semelhante ao 'LEA DS, rest_result'.
    INT 21H ; Conjunto de funções de entrada/saída.

    OR BL,30h ; Adição de "30h" de "BL" para conversão de número para caractere.

    MOV DL,BL ; Movimentação/cópia do conteúdo de "BL" para "DL".
    MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
    INT 21H ; Conjunto de funções de entrada/saída.

  MOV AH,4CH ; Função responsável por encerrar o programa.
  INT 21H ; Conjunto de funções de entrada/saída.

main endp
end main