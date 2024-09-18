; Crie um programa que exibe todas as letras maiúsculas e depois todas as minúsculas na tela.

title showing lowercase & uppercase letters ; Título do arquivo/programa.
.model small ; Modelo necessário para leitura/execução do programa.
.stack 100h ; Define o tamanho da pilha.

.code
main proc
  MOV AH,02H ; Função responsável por imprimir um caractere na tela.
  MOV DL,41H ; Código ASCII da primeira letra maiúscula ("A") que será impressa.
  MOV CX,26 ; Quantidade de vezes que o caractere será impresso.

PRINT_UPPERCASE: 
  INT 21H ; Conjunto de funções de entrada/saída.
  INC DL ; Incrementa o valor de DL.
  LOOP PRINT_UPPERCASE ; Decrementa o contador e salta para o rótulo PRINT_UPPERCASE se o contador não for zero.

  MOV DL,10 ; Código ASCII do caractere de quebra de linha ("line feed").
  INT 21H ; Conjunto de funções de entrada/saída.

  MOV DL,61H ; Código ASCII da primeira letra minúscula ("a") que será impressa.
  MOV CX,26 ; Quantidade de vezes que o caractere será impresso. 

PRINT_LOWERCASE:
  INT 21H ; Conjunto de funções de entrada/saída.
  INC DL ; Incrementa o valor de DL.
  LOOP PRINT_LOWERCASE ; Decrementa o contador e salta para o rótulo PRINT_LOWERCASE se o contador não for zero.
  
  MOV AH,4CH ; Função responsável por encerrar a execução do programa.
  INT 21H ; Conjunto de funções de entrada/saída.

main endp
end main