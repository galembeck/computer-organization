.MODEL SMALL
.STACK 100h

.DATA
    matriz4x4 DB 16 DUP(0)   ; Matriz 4x4 inicializada com zeros
    soma DW 0                ; Variável para armazenar a soma
    msgLinha DB 0Dh, 0Ah, '$' ; Nova linha (CR + LF)
    msgEntrada DB 'Digite um numero entre 0 e 6: $'
    espaco DB ' ', '$'         ; Espaço entre números
    msgSoma DB 'Soma dos elementos: $'

.CODE
MAIN:
    MOV AX, @DATA
    MOV DS, AX

    ; Ler a matriz
    CALL LerMatriz

    ; Imprimir a matriz
    CALL ImprimirMatriz

    ; Somar os elementos da matriz
    CALL SomarMatriz

    ; Imprimir a soma
    CALL ImprimirSoma

    ; Finaliza o programa
    MOV AH, 4Ch
    INT 21h

; Procedimento para ler a matriz
LerMatriz PROC
    LEA SI, matriz4x4    ; SI aponta para o início da matriz
    MOV CX, 16           ; 16 elementos na matriz

LerLoop:
    MOV AH, 9            ; Exibir mensagem de entrada
    LEA DX, msgEntrada
    INT 21h

    MOV AH, 1            ; Ler caractere do teclado
    INT 21h
    SUB AL, '0'          ; Converte de ASCII para número
    MOV [SI], AL         ; Armazena o valor na matriz

    ; Imprimir nova linha após cada entrada
    LEA DX, msgLinha
    MOV AH, 9
    INT 21h

    INC SI               ; Próximo elemento
    LOOP LerLoop         ; Repete até todos os elementos serem lidos
    RET
LerMatriz ENDP

; Procedimento para imprimir a matriz
ImprimirMatriz PROC
    LEA SI, matriz4x4    ; SI aponta para o início da matriz
    MOV CX, 4            ; 4 linhas na matriz

LinhaLoop:
    CALL ImprimirLinha   ; Imprime uma linha
    CALL NovaLinha       ; Avança para a próxima linha
    LOOP LinhaLoop       ; Repete para cada linha
    RET
ImprimirMatriz ENDP

; Procedimento para imprimir uma linha
ImprimirLinha PROC
    MOV BX, 4            ; 4 colunas por linha

ColunaLoop:
    MOV AL, [SI]         ; Carrega o valor atual
    ADD AL, '0'          ; Converte para ASCII
    MOV DL, AL           ; Prepara para impressão
    MOV AH, 2            ; Função para imprimir caractere
    INT 21h

    LEA DX, espaco       ; Imprime espaço entre números
    MOV AH, 9
    INT 21h

    INC SI               ; Próxima coluna
    DEC BX               ; Decrementa contador de colunas
    JNZ ColunaLoop       ; Continua até terminar a linha
    RET
ImprimirLinha ENDP

; Procedimento para somar os elementos da matriz
SomarMatriz PROC
    LEA SI, matriz4x4    ; SI aponta para o início da matriz
    MOV CX, 16           ; 16 elementos na matriz
    XOR AX, AX           ; Zera AX (acumulador)

SomarLoop:
    ADD AL, [SI]         ; Soma o elemento atual
    INC SI               ; Próximo elemento
    LOOP SomarLoop       ; Repete para todos os elementos

    MOV soma, AX         ; Armazena a soma em 'soma'
    RET
SomarMatriz ENDP

; Procedimento para imprimir a soma dos elementos
ImprimirSoma PROC
    MOV AH, 9            ; Exibir mensagem de soma
    LEA DX, msgSoma
    INT 21h

    MOV AX, soma         ; Carrega a soma
    ADD AL, '0'          ; Converte para ASCII
    MOV DL, AL           ; Prepara para impressão
    MOV AH, 2            ; Função para imprimir caractere
    INT 21h

    CALL NovaLinha       ; Avança para a próxima linha
    RET
ImprimirSoma ENDP

; Procedimento para imprimir nova linha
NovaLinha PROC
    LEA DX, msgLinha     ; Prepara para imprimir nova linha
    MOV AH, 9            ; Função para imprimir string
    INT 21h
    RET
NovaLinha ENDP

END MAIN