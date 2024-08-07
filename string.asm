title print a string (characters structure) ; Título do arquivo
.model small ; Modelo necessário para leitura do programa

.data
    first_text db 'Hello', 13, 10 ; Parâmetro '13' retorna ao início da linha e parâmetro '10' pula para a próxima linha.
    ; Parâmetros relacionados com a tabela ASCII (https://www.ime.usp.br/~kellyrb/mac2166_2015/tabela_ascii.html)
    second_text db 'Hey, brother!', '$'
    ; text db 'Hello, world!', '$' ; Texto que será escrito (deve acompanhar '$' para finalizar a varredura da memória).

.code
main proc

mov ax,@data
mov ds,ax
; Linhas 7 e 8 permitem o acesso de '.data'.

mov dx,offset first_text ; Passagem do endereço do texto pelo uso do 'offset'.
mov ah,9 ; Função responsável por imprimir a string no painel.
int 21h ; Conjunto de funções de entrada/saída.
; mov dx,offset second_text
; int 21h
; Linhas 20 e 21 são necessárias apenas quando cada variável de texto apresenta o limitador '$'.

mov ah,4ch ; Responsável por "devolver" o controle ao sistema operacional. 
int 21h ; Conjunto de funções de entrada/saída.
main endp
end main
; Linhas 17 e 18 são responsáveis por encerrarem a execução do programa.


; INT 21h - The general function despatcher
; http://bbc.nvg.org/doc/Master%20512%20Technical%20Guide/m512techb_int21.htm