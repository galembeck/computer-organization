; Fazer um programa que imprima um número hexadecimal.

; • Saída de números hexadecimais:
;   – BX é assumido como registrador de armazenamento;
;   – total de 16 bits de saída;
;   – string de caracteres HEXA é exibido no monitor de vídeo.

; • Algoritmo básico em linguagem de alto nível:
;   - FOR 4 vezes DO
;     - Mover BH para DL
;     - Deslocar DL 4 casas para a direita
;     - IF DL < 10
;       - THEN converte para caractere na faixa 0 a 9
;       - ELSE converte para caractere na faixa A a F
;     - END_IF
;   - Exibição do caractere no monitor de vídeo
;   - Rodar BX 4 casas à esquerda

title hexadecimal number printing
.model small
.stack 100h

.code 
main proc

PRINT_FOR: ; Criação/definição do rótulo "PRINT_FOR".
    CMP CX,4 ; Comparação do valor de "CX" com 4.
    JE EXIT ; Caso "CX" seja igual a 4, pula para o rótulo "EXIT".

    MOV DL,BH ; Movimentação/cópia de "BH" para "DL".
    SHR DL,4 ; Deslocamento de "DL" 4 casas para a direita.
    CMP DL,9 ; Comparação do valor de "DL" com 9.
    JG HEXADECIMAL_NUMBER_LETTER ; Caso seja maior que 9, pula para o rótulo "HEXADECIMAL_NUMBER_LETTER".

    AND DL,0Fh ; Conversão de número para caractere.
    OR DL,30h ; Conversão de caractere para número.
    JMP ROTATE_OPERATION ; Pula para o rótulo de operação de rotação.

    HEXADECIMAL_NUMBER_LETTER: ; Criação/definição do rótulo "HEXADECIMAL_NUMBER_LETTER".
      ADD DL,37h ; Conversão de número para caractere (letra maiúscula - hexadecimal).

    ROTATE_OPERATION: ; Criação/definição do rótulo "ROTATE_OPERATION".
      MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
      INT 21H ; Conjunto de funções de entrada/saída.

      ROL BX,4 ; Deslocamento de "BX" 4 casas para a esquerda.
     
    INC CX ; Incremento de "CX" em 1.

    JMP PRINT_FOR ; Repete o loop enquanto "CX" é diferente de 4.

  EXIT: ; Definição do rótulo "EXIT" para encerramento o programa.
    MOV AH,4Ch ; Função responsável por encerrar o programa.
    INT 21H ; Conjunto de funções de entrada/saída.

main endp
end main