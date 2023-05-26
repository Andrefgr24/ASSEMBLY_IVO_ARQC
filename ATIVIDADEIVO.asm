.data
option1: .asciiz "\nOp��o 1: Calcular a sequ�ncia de Fibonacci\n"
option2: .asciiz "Op��o 2: Converter Fahrenheit para Celsius\n"
option3: .asciiz "Op��o 3: Calcular o en�simo n�mero par\n"
option4: .asciiz "Op��o 4: Encerrar o programa\n"
input_prompt: .asciiz "\nDigite sua escolha (1, 2, 3 ou 4): "
invalid_choice: .asciiz "Escolha inv�lida. Tente novamente.\n"
space: .asciiz " "  # String representando espa�o em branco
func2: .asciiz "Op��o 2 escolhida\n"
func3: .asciiz "Op��o 3 escolhida\n"
prompt_fibonacci: .asciiz "Digite o valor de N para calcular o en�simo n�mero da sequ�ncia de Fibonacci: "
sequence_label: .asciiz "O en�simo n�mero da sequ�ncia de Fibonacci �: "

.text
.globl main

main:
    # Mostrar as op��es para o usu�rio
    # Imprimi op��o 1
    li $v0, 4             
    la $a0, option1       
    syscall

    # Imprimi op��o 2
    li $v0, 4             
    la $a0, option2       
    syscall

    # Imprimi op��o 3
    li $v0, 4             
    la $a0, option3       
    syscall

    # Ler a escolha do usu�rio
    li $v0, 4             
    la $a0, input_prompt  
    syscall

    # Ler a escolha do usu�rio
    li $v0, 5             
    syscall
    move $t0, $v0         

    # Verificar a escolha do usu�rio
    
    # Verificar se o n�mero � menor que 1
    li $t1, 1          # $t1 = 1
    slt $t2, $t0, $t1  # $t2 = 1 se $t0 < $t1, caso contr�rio $t2 = 0
    
    # Se o valor de $t2 � 0:
    beqz $t2, number_in_range

   # Se o valor de $t2 for 1:
   beq $t2, 1, invalid

number_valid:
    # C�digo para cada escolha
    beq $t0, 1, fibonacci_option    # Se a escolha for 1, ir para fibonacci_option
    beq $t0, 2, fahrenheit_option   # Se a escolha for 2, ir para fahrenheit_option
    beq $t0, 3, par_option          # Se a escolha for 3, ir para par_option
    beq $t0, 4, exit_program         # Se a escolha for 4, fechar o programa

invalid:
    # Escolha inv�lida
    li $v0, 4
    la $a0, invalid_choice
    syscall

    # Voltar para o in�cio para receber uma nova escolha
    j main    
      
number_in_range:
    # Verificar se o n�mero � maior que 4
    li $t1, 4          
    sgt $t2, $t0, $t1  # $t2 = 1 se $t0 > $t1

    # Se o valor de $t2 = 0:
    beqz $t2, number_valid

    # Se o valor de $t2 = 1:
    beq $t2, 1, invalid

fibonacci:
    addiu $sp, $sp, -12      # Alocar espa�o para os registradores $s0, $s1 e $s2
    sw $ra, 0($sp)           # Salvar o endere�o de retorno
    sw $s0, 4($sp)           # Salvar $s0
    sw $s1, 8($sp)           # Salvar $s1

    move $s0, $a0            # $s0 = valor de N

    li $s1, 0                # $s1 = primeiro termo
    li $s2, 1                # $s2 = segundo termo

    bltz $s0, fibonacci_exit # Se N < 0, terminar
    beqz $s0, fibonacci_exit # Se N = 0, terminar

fibonacci_loop:
    add $s3, $s1, $s2        # $s3 = primeiro termo + segundo termo

    move $s1, $s2            # Atualizar primeiro termo
    move $s2, $s3            # Atualizar segundo termo

    addi $s0, $s0, -1        # Decrementar N
    bgtz $s0, fibonacci_loop # Se N > 0, repetir o loop

fibonacci_exit:
    move $v1, $s1            # Colocar o valor do en�simo n�mero em $v1

    lw $ra, 0($sp)           # Restaurar o endere�o de retorno
    lw $s0, 4($sp)           # Restaurar $s0
    lw $s1, 8($sp)           # Restaurar $s1
    addiu $sp, $sp, 12       # Liberar o espa�o alocado

    jr $ra                   # Retornar

fibonacci_option:
    # Solicitar o valor de N para calcular o en�simo n�mero
    li $v0, 4
    la $a0, prompt_fibonacci
    syscall

    # Ler o valor de N digitado pelo usu�rio
    li $v0, 5
    syscall
    move $a0, $v0

    jal fibonacci            # Chamar a fun��o fibonacci para calcular o en�simo n�mero

    # Imprimir a mensagem "O en�simo n�mero da sequ�ncia de Fibonacci �:"
    li $v0, 4
    la $a0, sequence_label
    syscall

    # Imprimir o valor do en�simo n�mero
    move $a0, $v1 # move valor de 
    li $v0, 1
    syscall

    j main               # Voltar para o in�cio para receber uma nova escolha

par_option:
    li $v0, 4             # C�digo do servi�o 4: imprimir string
    la $a0, func3       # Carregar o endere�o da string option1
    syscall
    # C�digo para a op��o 3: calcular o en�simo n�mero par
    # Implemente o c�digo para calcular o en�simo n�mero par aqui

    j main               # Voltar para o in�cio para receber uma nova escolha
    
fahrenheit_option:
    li $v0, 4             # C�digo do servi�o 4: imprimir string
    la $a0, func2       # Carregar o endere�o da string option1
    syscall
    # C�digo para a op��o 3: calcular o en�simo n�mero par
    # Implemente o c�digo para calcular o en�simo n�mero par aqui

    j main               # Voltar para o in�cio para receber uma nova escolha
 
exit_program:
    li $v0, 10    # C�digo do servi�o 10: encerrar o programa
    syscall
       
