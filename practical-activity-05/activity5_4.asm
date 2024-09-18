; Crie um programa em linguagem assembly chamado que exibe todas as letras minúsculas na tela, exibindo 4 letras por linha.

title showing lowercase letters, 4 per line ; Título do arquivo/programa.
.model small ; Modelo necessário para leitura/execução do programa.
.stack 100h ; Define o tamanho da pilha.

.code
main proc
  MOV AH,02H ; Função responsável por imprimir um caractere na tela.
  MOV DL,61H ; Código ASCII da primeira letra minúscula ("a") que será impressa.

  MOV CX,26 ; Quantidade total de caracteres a serem impressos.
  MOV BH,4 ; Quantidade de letras que deverão ser impressas por linha.

LINE_LETTERS:
  INT 21H ; Conjunto de funções de entrada/saída.
  INC DL ; Incrementa o valor do caractere a ser impresso.
  DEC BH ; Decrementa a quantidade de letras que faltam para serem impressas (na mesma linha).

  MOV BL,DL ; Salva o valor do último caractere a ser impresso.
  MOV DL,32 ; Código ASCII do caractere de espaço (" ").
  INT 21H ; Conjunto de funções de entrada/saída.
  MOV DL,BL ; Restaura o valor do último caractere a ser impresso.

  JNZ LOWERCASE_ALPHABET ; Verifica se ainda faltam letras para serem impressas na mesma linha.
  MOV BH,4 ; Restaura a quantidade de letras que deverão ser impressas por linha.

  MOV BL,DL ; Salva o valor do último caractere a ser impresso.
  MOV DL,10 ; Código ASCII do caractere de nova linha ("\n").
  INT 21H ; Conjunto de funções de entrada/saída.
  MOV DL,BL ; Restaura o valor do último caractere a ser impresso.

LOWERCASE_ALPHABET:
  LOOP LINE_LETTERS ; Repete o processo até que todas as letras sejam impressas.

  MOV AH,4CH ; Função responsável por encerrar a execução do programa.
  INT 21H ; Conjunto de funções de entrada/saída.

main endp
end main