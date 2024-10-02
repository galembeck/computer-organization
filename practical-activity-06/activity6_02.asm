; A implementação de comandos de repetição em linguagem assembly, como o comando REPEAT,
; é sempre feita combinando o uso de testes de condições e instruções de saltos condicionais.

; ATIVIDADE: Implementar um programa em assembly que leia n caracteres até que leia CR.
; Contar o número de caracteres e imprimir tantos “*” quanto for este número

title printing characters as asterisks (repeat) different from CR ; Título do arquivo/programa.
.model small ; Modelo necessário para leitura/execução do programa.
.stack 100h ; Define o tamanho da pilha.

.data 
  character_input db 13, 10, 'Type a character (press ENTER to print "*"): ', '$'

.code
main proc
  ; Linhas 17 e 18 são responsáveis por permitirem o acesso de '.data'.
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).

  MOV CX,0 ; Inicialização do contador "CX" em 0.

  MOV AH,09H ; Função responsável por imprimir uma string na tela do usuário.
  LEA DX,character_input ; Passagem do endereço do texto pelo uso do "offset".
  INT 21H ; Conjunto de funções de entrada/saída.

  INPUT:
    MOV AH,01 ; Função responsável por ler um caractere do teclado.
    INT 21H ; Conjunto de funções de entrada/saída.

    INC CX ; Incrementa CX.
    
    CMP AL,13 ; Compara o caractere digitado (Alocado em AL) com '13' (Carriage Return, ou Enter).

    JE PRINT_ASTERISKS ; Se a comparação for verdadeira, pula para a sessão 'PRINT_ASTERISKS'.

    JMP INPUT ; Se for falsa, pula para o início do Loop.

  PRINT_ASTERISKS: ; Inicia o LOOP que imprime '*' na quantidade de vezes que um caractere foi digitado.
    CMP CX,0  ; Verifica se CX = 0, impedindo que '*' seja impresso caso nada tenha sido digitado.
    JE EXIT ; Pula para a sessão 'EXIT'.

    MOV AH,02 ; Função responsável por imprimir um caractere na tela do usuário.
    MOV DL,'*' ; Movimentação/cópia de '*' para "DL".
    INT 21H ; Conjunto de funções de entrada/saída.

    LOOP PRINT_ASTERISKS ; Verifica se CX = 0, se não, volta ao início do LOOP.

  EXIT: ; Rótulo de saída do programa.
    MOV AH,4CH ; Função responsável por encerrar o programa.
    INT 21H ; Conjunto de funções de entrada/saída.

main endp
end main