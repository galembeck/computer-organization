title messages (printing messages) ; Título do arquivo
.model small ; Modelo necessário para leitura do programa

.data
    first_message db 'Mensagem 1', 13, 10 ; Parâmetro '13' retorna ao início da linha e parâmetro '10' pula para a próxima linha.
    ; Parâmetros relacionados com a tabela ASCII (https://www.ime.usp.br/~kellyrb/mac2166_2015/tabela_ascii.html)
    second_message db 'Mensagem 2', '$'
    ; text db 'Hello, world!', '$' ; Texto que será escrito (deve acompanhar '$' para finalizar a varredura da memória).

.code
main proc

; Linhas 14 e 15 permitem o acesso de '.data'.
mov ax,@data ; Endereço base do segmento de dados...
mov ds,ax

mov ah,9 ; Função responsável por imprimir a string no painel.
lea dx,first_message
; mov dx,offset first_text ; Passagem do endereço do texto pelo uso do 'offset' - funcionamento semelhante ao "lea dx,first_message".
int 21h ; Conjunto de funções de entrada/saída.
; Linhas 22 e 23 são necessárias apenas quando cada variável de texto apresenta o limitador '$'.
; mov dx,offset second_texts
; int 21h

; As linhas 26 a 31 representam a exibição de mensagens de forma separada, possível apenas quando há a utilização do argumento "$" na definição da string em ".data".
; mov ah,9
; lea dx,first_message
; int 21h
; mov ah,9
; lea dx,second_message
; int 21h

mov ah,4ch ; Responsável por "devolver" o controle ao sistema operacional. 
int 21h ; Conjunto de funções de entrada/saída.
main endp
end main



; A parte do código abaixo foi disponilizada pelo professor Ricardo Pannain no arquivo da primeira atividade da disciplina de Organização de Sistemas Compuacionais. 

; title messages
; .model small
; .data
  ; first_message db 'Mensagem 1', '$'
  ; second_message db 10, 13, 'Mensagem 2', '$'
; .code
; main proc
; Permite acesso às variáveis definidas em .DATA.
; mov ax,@data
; mov ds,ax
; Exibe na tela a string "first_message".
; mov ah,9
; lea dx,first_message
; int 21h
;Exibe na tela a strin "second_message".
; mov ah,9
; lea dx,second_message
; int 21h
; Finaliza o programa.
; mov ah,4ch
; int 21h
; main endp
; end main