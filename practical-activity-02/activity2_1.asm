; Faça um programa em Assembly x86, que leia uma letra minúscula e a transforme em letra maiúscula.
; O programa deve ter as seguintes mensagens:
; Digite uma letra minúscula: a
; A letra maiúscula correspondente é: A

title reading a character & returning the uppercase form ; Título do arquivo.
.model small ; Modelo necessário para leitura/execução do programa.

.data
  character_input db 'Type any character to be returned on its uppercase form: ', '$'
  character_return db 13, 10, 'The uppercase form of the character inserted is: ', '$'

.code 
  main proc

  ; Linhas 17 e 18 são responsáveis por permitirem o acesso de '.data'.
  mov ax,@data ; Endereço base do segmento de dados.
  mov ds,ax ; Movimentação/cópia de "ax" para "ds" (registrador).

  mov ah,9 ; Função responsável por imprimir uma string na tela do usuário.
  lea dx,character_input ; Passagem do endereço do texto pelo uso do "offset".
  ; mov dx, offset character_input ; Funcionamento semelhante ao 'lea ds, character_input'.
  int 21h ;  Conjunto de funções de entrada/saída.

  mov ah,1 ; Função responsável por ler um caractere do teclado.
  int 21h ; Conjunto de funções de entrada/saída.

  mov bl,al ; Responsável por mover o valor de "al" para "bl".
  
  mov ah,9 ; Função responsável por imprimir uma string na tela do usuário.
  lea dx,character_return ; Passagem do endereço do texto pelo uso do "offset".
  ; mov dx, offset character_return ; Funcionamento semelhante ao 'lea ds, character_return'.
  int 21h ; Conjunto de funções de entrada/saída.

  sub bl,20h ; Subtração de 20h (32 em decimal) para transformar a letra minúscula em maiúscula.

  mov ah,2 ; Função responsável por imprimir um caractere na tela do usuário.
  mov dl,bl ; Movimentação/cópia de "bl" para "dl".
  int 21h ; Conjunto de funções de entrada/saída.

  mov ah,4ch ; Função responsável por encerrar o programa.
  int 21h ; Conjunto de funções de entrada/saída.
main endp
end main