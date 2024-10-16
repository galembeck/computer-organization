title Battleship Game - Fixed Ship Positions
.model small
.stack 100h

.data
    board_size db 20 dup(20 dup(0))  ; Matriz 20x20 inicializada com 0
    msg_clean_board db 'Tabuleiro Limpo:', 0Dh, 0Ah, '$'  ; Mensagem de impressão
    msg_ship_placed db 'Embarcações posicionadas!', 0Dh, 0Ah, '$'
    msg_attack db 'Digite a posição para atacar (linha coluna): ', '$'

.code
main proc
    ; Inicializa o tabuleiro
    call inicializa_tabuleiro

    ; Posiciona embarcações fixas
    call posicionar_embarcacoes_fixas

    ; Imprime o tabuleiro
    call imprimir_matriz

    ; Saída do programa
    jmp EXIT

; =========================================
; Inicializa a matriz do tabuleiro
inicializa_tabuleiro proc
    xor si, si            ; Zera o índice
    mov cx, 400           ; 20 * 20 = 400 células
inicializa_loop:
    mov [board_size + si], 0 ; Inicializa cada célula com 0
    inc si                 ; Próxima célula
    loop inicializa_loop   ; Continua até inicializar todas as células
    ret
inicializa_tabuleiro endp
; =========================================

; =========================================
; Posiciona embarcações fixas na matriz
posicionar_embarcacoes_fixas proc
    ; Posiciona um encouraçado de 4 células
    mov bx, 0            ; Linha 0
    mov cx, 0            ; Coluna 0
    mov dx, 4            ; Tamanho do encouraçado
    call posicionar_encouracado

    ; Posiciona uma fragata de 3 células
    mov bx, 1            ; Linha 1
    mov cx, 0            ; Coluna 0
    mov dx, 3            ; Tamanho da fragata
    call posicionar_fragata

    ; Posiciona um submarino de 2 células
    mov bx, 2            ; Linha 2
    mov cx, 0            ; Coluna 0
    mov dx, 2            ; Tamanho do submarino
    call posicionar_submarino

    ; Posiciona um hidroavião de 3 células
    mov bx, 3            ; Linha 3
    mov cx, 0            ; Coluna 0
    mov dx, 3            ; Tamanho do hidroavião
    call posicionar_hidroaviao

    ret
posicionar_embarcacoes_fixas endp
; =========================================

; =========================================
; Posiciona o encouraçado (4 células)
posicionar_encouracado proc
    ; bx = linha, cx = coluna, dx = tamanho
    mov si, bx            ; Linha inicial
    mov di, cx            ; Coluna inicial
    mov ax, 20            ; Tamanho da linha

    ; Calcula o endereço inicial
    mov bx, ax            ; Salva tamanho da linha em BX
    mul si                ; BX = linha * 20
    add bx, di            ; BX = linha * 20 + coluna

    ; Posiciona o encouraçado horizontalmente
    mov [board_size + bx], 1
    add bx, 1
    mov [board_size + bx], 1
    add bx, 1
    mov [board_size + bx], 1
    ret
posicionar_encouracado endp
; =========================================

; =========================================
; Posiciona a fragata (3 células)
posicionar_fragata proc
    mov si, bx            ; Linha inicial
    mov di, cx            ; Coluna inicial
    mov ax, 20            ; Tamanho da linha

    ; Calcula o endereço inicial
    mov bx, ax            ; Salva tamanho da linha em BX
    mul si                ; BX = linha * 20
    add bx, di            ; BX = linha * 20 + coluna

    ; Posiciona a fragata horizontalmente
    mov [board_size + bx], 1
    add bx, 1
    mov [board_size + bx], 1
    ret
posicionar_fragata endp
; =========================================

; =========================================
; Posiciona o submarino (2 células)
posicionar_submarino proc
    mov si, bx            ; Linha inicial
    mov di, cx            ; Coluna inicial
    mov ax, 20            ; Tamanho da linha

    ; Calcula o endereço inicial
    mov bx, ax            ; Salva tamanho da linha em BX
    mul si                ; BX = linha * 20
    add bx, di            ; BX = linha * 20 + coluna

    ; Posiciona o submarino horizontalmente
    mov [board_size + bx], 1
    add bx, 1
    ret
posicionar_submarino endp
; =========================================

; =========================================
; Posiciona o hidroavião (3 células)
posicionar_hidroaviao proc
    mov si, bx            ; Linha inicial
    mov di, cx            ; Coluna inicial
    mov ax, 20            ; Tamanho da linha

    ; Calcula o endereço inicial
    mov bx, ax            ; Salva tamanho da linha em BX
    mul si                ; BX = linha * 20
    add bx, di            ; BX = linha * 20 + coluna

    ; Posiciona o hidroavião horizontalmente
    mov [board_size + bx], 1
    add bx, 1
    mov [board_size + bx], 1
    ret
posicionar_hidroaviao endp
; =========================================

; =========================================
; Imprime a matriz
imprimir_matriz proc
    mov ah, 09h              ; Função de impressão do DOS
    lea dx, msg_clean_board   ; Carrega a mensagem a ser impressa
    int 21h                  ; Imprime "Tabuleiro Limpo:"

    ; Imprime a matriz 20x20
    mov si, 0                ; Índice inicial
imprimir_linha:
    mov cx, 20               ; Número de colunas
imprimir_coluna:
    mov al, [board_size + si] ; Carrega o valor da célula
    cmp al, 1
    je imprimir_X            ; Se for 1, imprime 'X'
    cmp al, 2                ; Verifica se já foi atingido
    je imprimir_O            ; Se for 2, imprime 'O'
    mov al, '.'              ; Caso contrário, imprime '.'
    call imprimir_caractere
    jmp continuar_coluna

imprimir_X:
    mov al, 'X'              ; Imprime 'X' para as embarcações
    call imprimir_caractere
    jmp continuar_coluna

imprimir_O:
    mov al, 'O'              ; Imprime 'O' se a célula já foi atingida
    call imprimir_caractere

continuar_coluna:
    inc si                   ; Próxima célula
    loop imprimir_coluna      ; Continua até imprimir as 20 colunas

    ; Nova linha
    mov ah, 02h
    mov dl, 0Dh               ; Caractere de nova linha
    int 21h
    mov dl, 0Ah
    int 21h

    cmp si, 400               ; Se já imprimiu todas as 400 células
    jne imprimir_linha        ; Continua se ainda houver células
    ret
imprimir_matriz endp
; =========================================

; =========================================
; Função para imprimir um caractere
imprimir_caractere proc
    mov ah, 02h               ; Função de impressão de caractere do DOS
    mov dl, al                ; Carrega o caractere a ser impresso
    int 21h                   ; Chama a interrupção
    ret
imprimir_caractere endp
; =========================================

; =========================================
; Função para atirar em uma posição
atirar proc
    mov ah, 09h               ; Função de impressão do DOS
    lea dx, msg_attack        ; Mensagem de entrada
    int 21h                   ; Imprime a mensagem

    ; Aqui você pode adicionar a lógica para obter a entrada do usuário
    ; e marcar as células como atingidas.
    
    ret
atirar endp
; =========================================

EXIT: 
    MOV AH, 4Ch
    INT 21h

main endp
end main
