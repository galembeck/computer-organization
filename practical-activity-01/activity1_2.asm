title eco ; Título do arquivo
.model small ; Modelo necessário para leitura do programa

.code
main proc

; Linhas 8 a 10 são responsáveis por exibirem o caractere "?" na tela.
mov ah,2
mov dl,"?" 
int 21h

; Linhas 13 e 14 são responsáveis por lerem um caractere do teclado e salvá-lo em "al".
mov ah,1
int 21h

; Linha 17 copia o caractere lido para "bl".
mov bl,al

; Linhas 20 a 22 exibem o caractere "line feed", responsável por movimentar o cursor para a linha seguinte.
mov ah,2
mov dl,10 ; O Código ASCII do caractere "carriage return" é 13 (0dh).
int 21h

; Linhas 25 a 27 são responsáveis por exibirem o caractere lido (salvo anteriormente em "bl").
mov ah,2
mov dl,bl
int 21h

main endp
end main