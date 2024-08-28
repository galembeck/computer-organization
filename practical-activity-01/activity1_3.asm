; Crie um programa em linguagem ASSEMBLY x86 chamado ATIV1_3.ASM, que exiba uma mensagem na tela solicitando ao
; usuário que digite um caractere, leia o caractere digitado do teclado, exiba uma mensagem na linha seguinte
; informando qual foi o caractere digitado e exiba-o em tela ao usuário.

; Exemplo:
; -> Digite um caractere: A
; -> O caractere digitado foi: A

title reading & displaying a character on screen ; Título do arquivo.
.model small ; Modelo necessário para leitura do programa.

.data 
  introduction_message db 'Type any character to be shown/displayed on screen: ', '$'
  character_message db 13, 10, 'The chracter inserted by the user was: ', '$'
  ; character_message db 0Dh, 0Ah, 'The chracter inserted by the user was: ', '$'

.code
main proc

; Linhas 21 e 22 são responsáveis por permitirem o acesso de '.data'.
mov ax,@data ; Endereço base do segmento de dados...
mov ds,ax ; Movimentação/cópia de "ax" para "ds" (registrador).

mov ah,9 ; Função responsável por imprimir uma string na tela do usuário.
lea dx,introduction_message ; Passagem do endereço do texto pelo uso do "offset".
; mov dx,offset introduction_message ; Funcionamento semelhante ao 'lea dx,introduction_message'.
int 21h ; Conjunto de funções de entrada/saída.

mov ah,1 ; Função responsável por ler um caractere qualquer do teclado e salvá-lo em "al".
int 21h ; Conjunto de funções de entrada/saída.

mov bl,al ; Responsável por copiar o caractere lido em "al" para "bl".

mov ah,2 ; Responsável por exibir a mensagem na tela do usuário.
; mov dl,10 ; Código ASCII do caractere "carriage return" é 13 (0Dh) - já inserido na exibição da mensagem em '.data'.
mov ah,9
lea dx,character_message
int 21h ; Conjunto de funções de entrada/saída.

; As linhas 37 a 39 são responsáveis por exibirem o caractere lido - inserido aneriormente pelo usuário - (salvo em "bl").
mov ah,2 
mov dl,bl
int 21h

mov ah,4ch ; Responsável por "devolver" o controle ao sistema operacional. 
int 21h ; Conjunto de funções de entrada/saída.
; As linhas 48 e 49 são responsáveis por encerrar a execução do programa.
main endp 
end main