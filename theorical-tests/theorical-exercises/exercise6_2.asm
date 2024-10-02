; Modifique o programa de exibição de caracteres ASCII, de forma a exibir 16
; caracteres por linha separados por espaços em branco.

title showing ASCII characters 16 per line ; Título do arquivo/programa
.model small ; Define o modelo de memória do programa
.stack 100h ; Define o tamanho da pilha

.code
main proc
  MOV AH,02H ; Função responsável por imprimir um caractere na tela.
  MOV DL,21H ; Código ASCII do primeiro caractere ("!") que deverá ser impresso.

  MOV CX,7EH ; Quantidade inicial do contador "CX".
  MOV BH,16 ; Quantidade de caracteres que deverão ser impressos por linha.

LINE_CHARACTERS:
  INT 21H ; Conjunto de funções de entrada/saída.
  INC DL ; Incrementa o valor do caractere a ser impresso.
  DEC BH ; Decrementa a quantidade de letras que faltam para serem impressas (na mesma linha).

  MOV BL,DL ; Salva o valor do último caractere a ser impresso.
  MOV DL,32 ; Código ASCII do caractere de espaço (" ").
  INT 21H ; Conjunto de funções de entrada/saída.
  MOV DL,BL ; Restaura o valor do último caractere a ser impresso.

  JNZ LOWERCASE_ALPHABET ; Verifica se ainda faltam letras para serem impressas na mesma linha.
  MOV BH,16 ; Restaura a quantidade de letras que deverão ser impressas por linha.

  MOV BL,DL ; Salva o valor do último caractere a ser impresso.
  MOV DL,10 ; Código ASCII do caractere de nova linha ("\n").
  INT 21H ; Conjunto de funções de entrada/saída.
  MOV DL,BL ; Restaura o valor do último caractere a ser impresso.

LOWERCASE_ALPHABET:
  CMP CX,21H ; Comparação do valor atual do contador "CX" com o código ASCII do último caractere que deve ser impresso.
  JE EXIT ; Caso a comparação acima seja verdadeira, a execução pula para o rótulo "EXIT" para que o programa possa ser encerrado.
  LOOP LINE_CHARACTERS ; Repete o processo até que todas as letras sejam impressas.

EXIT: ; Label responsável por encerrar a execução do programa.
  MOV AH,4CH ; Responsável por "devolver" o controle ao sistema operacional.
  INT 21H ; Conjunto de funções de entrada/saída.

main endp
end main