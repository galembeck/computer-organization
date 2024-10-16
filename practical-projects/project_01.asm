title practical project (computer systems organization)
.model small
.stack 100h

.data
    board_size db 20 dup(20 dup(0))

.code
main proc
    MOV AX,@DATA
    MOV DS,AX

    EXIT: 
        MOV AH, 4Ch
        INT 21h

main endp
end main
