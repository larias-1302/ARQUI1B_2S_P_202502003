.data

msg_menu:
    .ascii "\nSeleccione una opción:\n1. Suma\n2. Resta\n3. Multiplicacion\n4. Division entera\n5. Potencia\n6. Factorial\n7. Salir\n"
    msg_menu_len = . - msg_menu

msg_opcion:
    .ascii "Ingrese una opción: "
    msg_opcion_len = . - msg_opcion

msg_error:
    .ascii "Opción inválida\n"
    msg_error_len = . - msg_error

msg_primer:
    .ascii "Ingrese el primer número: "
    msg_primer_len = . - msg_primer

msg_segundo:
    .ascii "Ingrese el segundo número: "
    msg_segundo_len = . - msg_segundo

msg_numero:
    .ascii "Ingrese un número: "
    msg_numero_len = . - msg_numero

msg_div_cero:
    .ascii "Error: no se puede dividir entre cero\n"
    msg_div_cero_len = . - msg_div_cero

msg_exp_negativo:
    .ascii "Error: el exponente no puede ser negativo\n"
    msg_exp_negativo_len = . - msg_exp_negativo

msg_fact_negativo:
    .ascii "Error: no se puede calcular factorial de un negativo\n"
    msg_fact_negativo_len = . - msg_fact_negativo

msg_resultado:
    .ascii "Resultado: "
    msg_resultado_len = . - msg_resultado

newline:
    .ascii "\n"


.bss

input_buffer:
    .skip 64

output_buffer:
    .skip 64


.text
.global _start

.include "05_atoi.s"
.include "06_itoa.s"


_start:
    ldr x1, =msg_menu
    mov x2, msg_menu_len
    bl print

    ldr x1, =msg_opcion
    mov x2, msg_opcion_len
    bl print

    bl read

    ldr x1, =input_buffer
    ldrb w0, [x1]

    cmp w0, '1'
    beq suma

    cmp w0, '2'
    beq resta

    cmp w0, '3'
    beq multiplicacion

    cmp w0, '4'
    beq division

    cmp w0, '5'
    beq potencia

    cmp w0, '6'
    beq factorial

    cmp w0, '7'
    beq exit

    b opcion_invalida


suma:
    mov x22, #1
    b read_numbers

resta:
    mov x22, #2
    b read_numbers

multiplicacion:
    mov x22, #3
    b read_numbers

division:
    mov x22, #4
    b read_numbers

potencia:
    mov x22, #5
    b read_numbers


read_numbers:
    ldr x1, =msg_primer
    mov x2, msg_primer_len
    bl print

    bl read

    ldr x21, =input_buffer
    bl atoi
    mov x20, x10

    ldr x1, =msg_segundo
    mov x2, msg_segundo_len
    bl print

    bl read

    ldr x21, =input_buffer
    bl atoi
    mov x21, x10

    cmp x22, #1
    beq do_suma

    cmp x22, #2
    beq do_resta

    cmp x22, #3
    beq do_multiplicacion

    cmp x22, #4
    beq do_division

    cmp x22, #5
    beq do_potencia

    b _start


do_suma:
    add x20, x20, x21
    b print_result


do_resta:
    sub x20, x20, x21
    b print_result


do_multiplicacion:
    mul x20, x20, x21
    b print_result


do_division:
    cmp x21, #0
    beq division_cero

    sdiv x20, x20, x21
    b print_result


division_cero:
    ldr x1, =msg_div_cero
    mov x2, msg_div_cero_len
    bl print

    b _start


do_potencia:
    cmp x21, #0
    blt exponente_negativo

    mov x23, #1

potencia_loop:
    cmp x21, #0
    beq potencia_fin

    mul x23, x23, x20
    sub x21, x21, #1

    b potencia_loop


potencia_fin:
    mov x20, x23
    b print_result


exponente_negativo:
    ldr x1, =msg_exp_negativo
    mov x2, msg_exp_negativo_len
    bl print

    b _start


factorial:
    ldr x1, =msg_numero
    mov x2, msg_numero_len
    bl print

    bl read

    ldr x21, =input_buffer
    bl atoi

    mov x20, x10

    cmp x20, #0
    blt factorial_negativo

    mov x23, #1

factorial_loop:
    cmp x20, #1
    ble factorial_fin

    mul x23, x23, x20
    sub x20, x20, #1

    b factorial_loop


factorial_fin:
    mov x20, x23
    b print_result


factorial_negativo:
    ldr x1, =msg_fact_negativo
    mov x2, msg_fact_negativo_len
    bl print

    b _start


print_result:
    ldr x1, =msg_resultado
    mov x2, msg_resultado_len
    bl print

    mov x0, x20

    ldr x1, =output_buffer
    add x1, x1, #64

    bl itoa
    bl print

    ldr x1, =newline
    mov x2, #1
    bl print

    b _start


opcion_invalida:
    ldr x1, =msg_error
    mov x2, msg_error_len
    bl print

    b _start


read:
    mov x0, #0
    ldr x1, =input_buffer
    mov x2, #64
    mov x8, #63
    svc #0

    cmp x0, #0
    blt read_error

    ret


read_error:
    ldr x1, =msg_error
    mov x2, msg_error_len
    bl print

    b _start


print:
    mov x0, #1
    mov x8, #64
    svc #0
    ret


exit:
    mov x0, #0
    mov x8, #93
    svc #0