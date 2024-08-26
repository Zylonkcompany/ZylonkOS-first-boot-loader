; Bootloader em Assembly x86
[org 0x7C00]   ; A localização onde o bootloader é carregado na memória

; Configuração inicial
    mov ah, 0x0E  ; Função de impressão de caractere em modo texto
    mov si, msg    ; Ponteiro para a mensagem

print_char:
    lodsb           ; Carrega o próximo caractere da string para AL
    cmp al, 0       ; Verifica se é o final da string (caractere nulo)
    je done         ; Se for, salta para a etiqueta done
    int 0x10        ; Interrupção de vídeo para imprimir o caractere
    jmp print_char  ; Repete para o próximo caractere

done:
    cli             ; Desativa interrupções
    hlt             ; Para o processador até reiniciar

msg db 'Hello ZylonkOS', 0   ; Mensagem a ser exibida

times 510 - ($ - $$) db 0  ; Preenche o resto do setor com zeros
dw 0xAA55                 ; Assinatura de boot
