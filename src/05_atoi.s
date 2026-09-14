// x21 = direccion de donde empezamos a leer
// salida: x10 = numero convertido

atoi:
    mov x10, #0             // resultado = 0
    mov x5, #10             // base 10
    mov x7, #0              // bandera de numero activo
    mov x6, #0              // bandera de numero negativo

    // verificar si comienza con signo negativo
    ldrb w23, [x21]
    cmp w23, '-'
    bne atoi_read

    // marcar como negativo y avanzar un caracter
    mov x6, #1
    add x21, x21, #1

atoi_read:
    ldrb w23, [x21], #1

    // verificar si es digito
    cmp w23, '0'
    blt atoi_end

    cmp w23, '9'
    bgt atoi_end

    // convertir ASCII a numero
    sub w23, w23, '0'

    // resultado = resultado * 10
    mov x4, x10
    mul x10, x4, x5

    // resultado = resultado + digito
    add x10, x10, x23

    // marcar numero activo
    mov x7, #1

    b atoi_read

atoi_end:
    // aplicar signo negativo si corresponde
    cbz x6, atoi_finish
    neg x10, x10

atoi_finish:
    ret