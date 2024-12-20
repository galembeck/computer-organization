title manipulating vectors using "bx"
.model small
.stack 100h

.data
  vector db 1, 1, 1, 2, 2, 2

.code 
main proc

  ; Linhas 12 e 13 são responsáveis por permitirem o acesso de '.data'.
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).
  
  XOR DL,DL ; Redefinição de DL para 0.
  MOV CX,6 ; Definição do tamanho do vetor (6 elementos).
  XOR BX,BX ; Redefinição de BX.

  CALL MANIPULATION

  MOV AH,4Ch ; Função responsável por finalizar o programa.
  INT 21h ; Conjunto de funções de entrada/saída.

main endp

MANIPULATION PROC
  RETURN: ; Criação/definição do rótulo "RETURN".
    MOV DL,vector[BX] ; Movimentação do valor do vetor para DL.

    INC BX ; Incremento de BX.
    ADD DL,30h ; Adição de 30h ao valor de DL.

    MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
    INT 21H ; Conjunto de funções de entrada/saída.

    LOOP RETURN ; Repete o loop enquanto "CX" é diferente de 0.
MANIPULATION ENDP
end main