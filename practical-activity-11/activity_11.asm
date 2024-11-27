TITLE BASES CONVERSION
.MODEL SMALL
.STACK 100h
.DATA
    ;Definição das strings que serão usadas no programa, exceto pelo vetor
    ;"NEGATIVO", que ira armazenar se o numero decimal é ou nao negativo.
    NEGATIVO DB 0
    MSG1 DB 10,13,"Escolha a base do numero que sera inserido: $"
    MSG2 DB 10,13,"1. Binario.$"
    MSG3 DB 10,13,"2. Decimal.$"
    MSG4 DB 10,13,"3. Hexadecimal.$"
    MSG5 DB 10,13,"Escolha a forma de saida do numero: $"
    MSG6 DB 10,13,"Insira o numero: $"
    MSG7 DB 10,13,"O numero convertido: $"

.CODE
MAIN PROC

    ; Configura o segmento de dados
    MOV AX,@DATA
    MOV DS,AX
    
    ; Exibição das escolhas de entrada.
    LEA DX,MSG2
    MOV AH,9
    INT 21h

    LEA DX,MSG3
    MOV AH,9
    INT 21h

    LEA DX,MSG4
    MOV AH,9
    INT 21h

    LEA DX,MSG1
    MOV AH,9
    INT 21h

    ; Lê a escolha de base do usuário
    MOV AH,1
    INT 21h

    ; Push e pop para preservar o valor de AX enquanto o comando de impressao de string roda.
    PUSH AX
    MOV AH,9
    LEA DX,MSG6
    INT 21h
    POP AX

    ; Conversão de ASCII para valor real.
    SUB AL,48

    ; Switch case para as opções de entrada.
    CMP AL,1
    JE INCASE1
    CMP AL,2
    JE INCASE2
    CMP AL,3
    JE INCASE3

OUTLABEL:

    ; Exibe mensagem de escolha de saída
    LEA DX,MSG5
    MOV AH,9
    INT 21h

    ; Lê a escolha de formato de saída do usuário
    MOV AH,1
    INT 21h

    ; Push e pop para preservar o valor de AX
    PUSH AX
    MOV AH,9
    LEA DX,MSG7
    INT 21h
    POP AX

    ; Conversão de ASCII para valor real
    SUB AL,48

    ; Switch case para a escolha de saida do usuario
    CMP AL,1
    JE OUTCASE1
    CMP AL,2
    JE OUTCASE2
    CMP AL,3
    JE OUTCASE3

OUTFINAL:

    ; Finalização do programa
    MOV AH,4Ch
    INT 21h

; Definição dos LABELS para o case
INCASE1:
    CALL INBINARIO
    JMP OUTLABEL
INCASE2:
    CALL INDECIMAL
    JMP OUTLABEL
INCASE3:
    CALL INHEXADECIMAL
    JMP OUTLABEL
OUTCASE1:
    CALL OUTBINARIO
    JMP OUTFINAL
OUTCASE2:
    CALL OUTDECIMAL
    JMP OUTFINAL
OUTCASE3:
    CALL OUTHEXADECIMAL
    JMP OUTFINAL

MAIN ENDP

INBINARIO PROC

    ; Inicializa BX e configura para ler um caractere
    XOR BX,BX
    MOV AH,1
    ; Configurando o loop para 16 vezes, pelos 16 bits
    MOV CX,16

INBINLOOP:
    ; Lê um caractere da entrada
    INT 21h
    ; Verifica se é CR (fim da entrada)
    CMP AL,13
    JE INBINFIM
    ; Compara com o caractere '0'
    CMP AL,48
    JE INBIN0
    ; Compara com o caractere '1'
    CMP AL,49
    JE INBIN1

INBINLOOPOUT:
    ; Continua o loop para os próximos bits
    LOOP INBINLOOP
    JMP INBINFIM
    
INBIN0:
    ; Movendo os bits de BX uma casa para a esquerda
    SHL BX,1
    JMP INBINLOOPOUT

INBIN1:
    ; Movendo os bits uma casa para a esquerda e colocando o valor 1
    SHL BX,1
    INC BX
    JMP INBINLOOPOUT

INBINFIM:
    RET

INBINARIO ENDP

INHEXADECIMAL PROC

    ; Inicializa BX e configura para ler um caractere
    XOR BX,BX
    MOV AH,1
    ; Configurando o loop em 4 vezes, pois são 4 bytes
    MOV CX,4

INHEXLOOP:
    ; Lê um caractere da entrada
    INT 21h
    ; Compara com CR (fim da entrada)
    CMP AL,13
    JE INHEXFIM
    ; Desloca BX 4 bits para esquerda (para hexadecimal)
    SHL BX,4
    ; Compara se é uma letra (A-F)
    CMP AL,65
    JAE INHEXLETRA
    ; Compara se é um número (0-9)
    CMP AL,48
    JAE INHEXNUM

INHEXLOOPOUT:
    LOOP INHEXLOOP
    JMP INHEXFIM

INHEXLETRA:
    ; Converte letra A-F para valor numérico
    SUB AL,55
    ADD BL,AL
    JMP INHEXLOOPOUT

INHEXNUM:
    ; Converte número 0-9 para valor numérico
    SUB AL,48
    ADD BL,AL
    JMP INHEXLOOPOUT

INHEXFIM:
    RET

INHEXADECIMAL ENDP

INDECIMAL PROC

    ; Inicializa BX e DX para processar entrada decimal
    XOR BX,BX
    XOR DX,DX
    MOV AH,1
    MOV DL,10
    INT 21h

    ; Verifica se é um número negativo
    CMP AL,45
    JE INDECNEG

INDECLOOP2:

    ; Lê o próximo caractere e converte de ASCII
    INT 21h
    SUB AL,48d
    ADD BL,AL

INDECLOOP:

    ; Multiplicação para acumular os dígitos
    XOR AX,AX
    MOV AH,1
    INT 21h

    ; Verifica fim da entrada (CR)
    CMP AL,13
    JE INDECFIM

    SUB AL,48

    PUSH AX

    MOV AX,BX
    MUL DL

    MOV BX,AX

    POP AX

    ADD BL,AL

    LOOP INDECLOOP

INDECFIM:

    ; Verifica se é um número negativo
    CMP NEGATIVO,1
    JE INDECNEG2
    RET

INDECNEG:
    ; Define o indicador de número negativo
    MOV NEGATIVO,1
    JMP INDECLOOP2

INDECNEG2:
    ; Converte para o complemento de dois se negativo
    MOV CX,65535d
    XOR BX,CX
    INC BX
    RET

INDECIMAL ENDP

OUTBINARIO PROC
    ; Inicia o registro DX com zero
    XOR DX,DX
    MOV CX,16
    MOV AH,2

OUTBININICIO:
    ; Desloca o valor de BX uma posição à esquerda
    ROL BX,1
    ; Checa se é zero e insere o caractere correspondente
    JNC OUTBINZERO
    MOV DL,'1'
    INT 21h
    LOOP OUTBININICIO
    RET

OUTBINZERO:

    MOV DL,'0'
    INT 21h
    LOOP OUTBININICIO
    RET

OUTBINARIO ENDP

OUTHEXADECIMAL PROC
    MOV AH,2
    MOV CX,4

OUTHEXLOOP:
    ; Pega BH e o converte para caractere
    MOV DL,BH
    ROR DL,4
    AND DL,0Fh
    SAL BX,4
    CMP DL,9
    JBE OUTHEXNUM
    JA OUTHEXLET

OUTHEXNUM:
    ; Converte o valor numérico em ASCII
    ADD DL,48
    INT 21h
    LOOP OUTHEXLOOP
    RET

OUTHEXLET:
    ; Converte o valor de letra em ASCII
    ADD DL,55
    INT 21h
    LOOP OUTHEXLOOP
    RET

OUTHEXADECIMAL ENDP

OUTDECIMAL PROC

    ; Checa se o número é negativo
    RCL BX,1
    JC OUTDECNEG
    RCR BX,1

OUTDECLOOP2:
    ; Inicializa o contador de dígitos e a pilha de saída
    XOR CX, CX
    MOV AX, BX
    XOR BX, BX

OUTDECLOOP:
    ; Divide o valor por 10 para extrair dígitos
    XOR DX,DX
    MOV CX, 10
    DIV CX
    PUSH DX
    INC BX
    CMP AX, 0
    JNE OUTDECLOOP             ; Caso contrário, continua a divisão

    MOV CX, BX                 ; Número de dígitos para imprimir
    MOV AH, 2                  ; Função de impressão de caractere

OUTDECPRINT:
    POP DX                     ; Recupera um dígito da pilha
    ADD DL, 48                 ; Converte o dígito em número para caractere (ASCII)
    INT 21h                    ; Chama a interrupção para imprimir
    LOOP OUTDECPRINT           ; Decremente CX e repete se CX > 0

    RET

OUTDECNEG: 
    ;Desfaz o complemento de 2.
    RCR BX,1
    DEC BX
    XOR BX,65535d
    ;Printa o caractere "-"
    MOV AH,2
    MOV DL,'-'
    INT 21h 
    JMP OUTDECLOOP2
OUTDECIMAL ENDP

END MAIN