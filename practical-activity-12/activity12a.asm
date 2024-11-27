TITLE Experimentação Com Vetores;-Título do Arquivo-;

.MODEL SMALL ;-Modelo do Arquivo (Small)-;
.STACK 100h ;-Define o tamanho da pilha-;

;-MACROS-;

    ;-Macro Para Pular Linha-;
    JLINEM MACRO PARAM ; Criação de MACRO para quebra/inicialização de nova linha.
        LOCAL REPEAT

        PUSH AX ;-Salva o valor de AX na pilha-;
        PUSH CX ;-Salva o valor de CX na pilha-;
        PUSH DX ;-Salva o valor de DX na pilha-;

        MOV CX, PARAM ;-Aloca o valor atribuído a PARAM para CX-;
        MOV AH, 2 ;-Aloca a função de Exibição-De-Caractere no registrador AH, definindo qual função será usada com INT 21h-;

        REPEAT:
            ;-Função Para Pular Linha-;
            MOV DL, 0Dh ;-Aloca o valor '13' (Carriage Return) para o registrador DL, definindo o que será impresso-;
            INT 21h ;-Chama a função do DOS que usa o valor de AH para determinar qual função será realizada-;

            MOV DL, 0Ah ;-Aloca o valor '13' (Carriage Return) para o registrador DL, definindo o que será impresso-;
            INT 21h ;-Chama a função do DOS que usa o valor de AH para determinar qual função será realizada-;

        LOOP REPEAT ;-Finaliza o Loop REPEAT-;

        POP DX ;-Puxa o último valor de da pilha em DX-;
        POP CX ;-Puxa o último valor de da pilha em CX-;
        POP AX ;-Puxa o último valor de da pilha em AX-;

    ENDM ;-Finaliza a MACRO-;

.DATA ;-Inicia a Sessão Data-;
    
    ;-Mensagens-;
        READ_MESSAGE DB 'Digite uma string (maximo de 9 caracteres + Enter): $'
        PRT_MSG DB 'Impressao da string digitada: $'
        CPY_MSG DB 'Impressao da string copiada: $'
        CMP_MSGS DB 'Impressao da string de comparacao: $'
        CMP_MSGD DB 'A string comparada e diferente da digitada.$'
        CMP_MSGE DB 'A string comparada e igual a digitada.$'
        A_MSG DB 'Quantidade de "a"s na string digitada: $'
        WARNING DB 'STRING DE TAMANHO INVALIDO$'

    ;-Strings-;
        STRING_READ DB 10 dup('$')
        STRING_COPY DB 10 DUP('$')
        STRING_COMP DB '6', '9', '2', '4', '5', '5', '7', '7', '2', '$'

.CODE ;-Inicia a Sessão Code-;

MAIN PROC ;-Inicia a Sessão Main-;
    
    ;-Sessão Básica do Código-;
        MOV AX, @DATA ;-Conteúdo de DATA é direcionado para o registrador AX, gerando acesso ao conteúdo de DATA pelo programa-;
        MOV DS, AX ;-Endereço de AX é direcionado para o registrador DS-;
        MOV ES, AX ;-Endereço de AX é direcionado para o registrador ES-;

    ;-Atribuições Gerais-;
        MOV AH, 9
        LEA DX, READ_MESSAGE
        INT 21h
    
    ;-Leitura/Armazenamento/Impressão De String-;
        CALL READ_AND_PRINT

    ;-Copiar String Em Outro-;
        CALL COPY

    ;-Compara E Analisa Com String Já Existente-;
        CALL COMPARE

    ;-Verifica Quantas Letras 'a' Tem O String-;
        CALL VERIFY

    ;-Fim de Código-;
        END_CODE_P:
            MOV AH, 4Ch ;-Aloca o valor '4ch' (função de terminação de programa) para AH, que é parte de AX-;
            INT 21h ;-Chama a função do DOS que usa o valor de AH para determinar qual operação realizar-;

MAIN ENDP ;-Finaliza a sessão MAIN-;

;-PROCEDIMENTOS-;

    ;-Leitura/Armazenamento/Impressão De String-;
    READ_AND_PRINT PROC NEAR ;-Inicializa o Procedimento, definindo seu tipo (FAR: Procedimento em outro segmento do código; NEAR: Procedimento no mesmo segmento do código)-;

        ;-Atribuições Gerais-;
            MOV AH, 1
            MOV CX, 10
            CLD
            LEA DI, STRING_READ

        ;-Leitura-;
            LOOP_READSTR:
                INT 21h
                CMP AL, 0Dh
                JE READ_END
                STOSB
                LOOP LOOP_READSTR
                
                JLINEM 2

                MOV AH, 9
                LEA DX, WARNING
                INT 21h

                JMP END_CODE_P

                READ_END:
                    MOV AL, '$'
                    STOSB

                    JLINEM 1

                    MOV AH, 9
                    LEA DX, PRT_MSG
                    INT 21h
                    
                    MOV AH, 2
                    LEA SI, STRING_READ

        ;-Impressão-;
            LOOP_PRINTSTR:
                LODSB
                CMP AL, '$'
                JE PRINT_END
                XCHG DL, AL
                INT 21h
                JMP LOOP_PRINTSTR

                PRINT_END:
                    RET ;-Carrega o offset da próxima instrução (que foi guardada na pilha) em IP-;
    
    READ_AND_PRINT ENDP ;-Finaliza o Procedimento-;

    ;-Copiar String Em Outro-;
    COPY PROC NEAR ;-Inicializa o Procedimento, definindo seu tipo (FAR: Procedimento em outro segmento do código; NEAR: Procedimento no mesmo segmento do código)-;

        ;-Atribuições Gerais-;
            JLINEM 2
            
            CLD
            LEA SI, STRING_READ
            LEA DI, STRING_COPY
            
        ;-Copia-;
            LOOP_COPY:
                LODSB
                CMP AL, '$'
                JE PRINT_COPY
                STOSB
                JMP LOOP_COPY

        ;-Imprime-;
            PRINT_COPY:
                MOV AH, 9
                LEA DX, CPY_MSG
                INT 21h
                
                MOV AH, 2
                LEA SI, STRING_COPY
            
            PRINT_COPY_LOOP:
                LODSB
                CMP AL, '$'
                JE PRINT_COPY_END
                XCHG DL, AL
                INT 21h
                JMP PRINT_COPY_LOOP

                PRINT_COPY_END:
                    RET ;-Carrega o offset da próxima instrução (que foi guardada na pilha) em IP-;
    
    COPY ENDP ;-Finaliza o Procedimento-;

    ;-Compara E Analisa Com String Já Existente-;
    COMPARE PROC NEAR ;-Inicializa o Procedimento, definindo seu tipo (FAR: Procedimento em outro segmento do código; NEAR: Procedimento no mesmo segmento do código)-;

        ;-Atribuições Gerais-;
            JLINEM 2

        ;-Imprime-;
            PRINT_COMP:
                MOV AH, 9
                LEA DX, CMP_MSGS
                INT 21h
                
                MOV AH, 2
                LEA SI, STRING_COMP
            
            PRINT_COMP_LOOP:
                LODSB
                CMP AL, '$'
                JE STRING_CMP
                XCHG DL, AL
                INT 21h
                JMP PRINT_COMP_LOOP

        ;-Compara-;
            STRING_CMP:
                CLD
                LEA SI, STRING_READ
                LEA DI, STRING_COMP
                MOV CX, 10
                REPE CMPSB
                JNE NEQUAL
                JLINEM 2
                LEA DX, CMP_MSGE
                JMP END_P

                NEQUAL:
                    JLINEM 2
                    LEA DX, CMP_MSGD
                    JMP END_P

        END_P:
            MOV AH, 9
            INT 21h

            RET ;-Carrega o offset da próxima instrução (que foi guardada na pilha) em IP-;
    
    COMPARE ENDP ;-Finaliza o Procedimento-;

    ;-Verifica Quantas Letras 'a' Tem O String-;
    VERIFY PROC NEAR ;-Inicializa o Procedimento, definindo seu tipo (FAR: Procedimento em outro segmento do código; NEAR: Procedimento no mesmo segmento do código)-;

        ;-Atribuições Gerais-;
            JLINEM 2

            CLD
            LEA DI, STRING_READ
            MOV AL, 'a'
            MOV CX, 10
            XOR BX, BX
            
            SEARCH_LOOP:
                SCASB
                JNZ VERIFY_REPEAT
                INC BX

                VERIFY_REPEAT:
                    LOOP SEARCH_LOOP

            MOV AH, 9
            LEA DX, A_MSG
            INT 21h

            MOV AH, 2
            XCHG DL, BL
            OR DL, 30h ;-Converte o valor (numérico) do registrador DL para um caractere-;
            INT 21h

        RET ;-Carrega o offset da próxima instrução (que foi guardada na pilha) em IP-;
    
    VERIFY ENDP ;-Finaliza o Procedimento-;

END MAIN ;-Finaliza o Código-;