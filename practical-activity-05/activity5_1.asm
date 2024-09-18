; A instrução LOOP pode ser utilizada para a implementação de comandos de repetição, como o
; comando For, da atividade anterior.
; A instrução LOOP sempre utiliza como contador o registrador CX e:
; - Salta para o ROTULO especificado na instrução caso o registrador CX seja diferente de zero;
; - Continua a execução sequencialmente caso o registrador CX seja igual a zero.

; Podemos dizer dessa forma que a instrução:
; LOOP ROTULO
; É equivalente às instruções:
; DEC CX
; JNZ ROTULO

; Reescrever o programa anterior, utilizando:
; 1. O registrador CX como contador; e
; 2. A instrução LOOP label no lugar das instruções DEC CX e JNZ label.

title printing * character ; Título do arquivo/programa.
.model small ; Modelo necessário para leitura/execução do programa.
.stack 100h ; Define o tamanho da pilha.

.code
main proc
  MOV AH,02H ; Função responsável por imprimir um caractere na tela.
  MOV DL,'*' ; Caractere a ser impresso ("*").
  MOV CX,50 ; Quantidade de vezes que o caractere será impresso.

PRINT_LINE:
  INT 21H ; Conjunto de funções de entrada/saída.
  ; LOOP PRINT_LINE ; Decrementa o contador e salta para o rótulo PRINT se o contador não for zero.
  DEC CX ; Decrementa o contador. 
  JNZ PRINT_LINE ; Salta para o rótulo PRINT_LINE se o contador não for zero.

  MOV CX,50 ; Reinicialização do valor do contador.
  MOV BL,10 ; Código ASCII do caractere de quebra de linha ("line feed").

PRINT_LINE_FEED:
  INT 21H ; Conjunto de funções de entrada/saída.
  XCHG BL,DL ; Troca de valores entre BL e DL.
  INT 21H ; Conjunto de funções de entrada/saída.
  XCHG DL,BL ; Troca de valores entre DL e BL.
  ; LOOP PRINT_LINE_FEED ; Decrementa o contador e salta para o rótulo PRINTT se o contador não for zero.
  DEC CX ; Decrementa o contador.
  JNZ PRINT_LINE_FEED ; Salta para o rótulo PRINT_LINE_FEED se o contador não for zero.

  MOV AH,4CH ; Função responsável por encerrar a execução do programa.
  INT 21H ; Conjunto de funções de entrada/saída.

main endp
end main