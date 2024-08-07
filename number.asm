title print number
.model small

.code
main proc
    mov cx,10 ; Funciona como uma espécie de contador (neste caso, com valor igual a 10).

    mov dl,30h ; Função que retorna um número.
    mov ah,2 ; Função que retorna o número '0'.

printNumber:
    int 21h ; Conjunto de funções de entrada/saída.
    inc dl ; Função que incrementa um valor em 'dl'.
    loop printNumber 

    mov ah,4ch ; Responsável por "devolver" o controle ao sistema operacional. 
    int 21h ; Conjunto de funções de entrada/saída.

main endp
end main