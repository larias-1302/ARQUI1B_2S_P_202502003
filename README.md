# Práctica 1 - Calculadora ARM64

## Arquitectura de Computadores y Ensambladores 1

Calculadora de números enteros desarrollada en lenguaje ensamblador ARM64 (AArch64).

El programa utiliza un menú interactivo que permite seleccionar distintas operaciones aritméticas y mostrar el resultado correspondiente en consola.

## Operaciones implementadas

1. Suma
2. Resta
3. Multiplicación
4. División entera
5. Potencia
6. Factorial
7. Salir

## Validaciones

El programa contempla los siguientes casos especiales:

- División entre cero.
- Exponente negativo en la operación de potencia.
- Número negativo en la operación factorial.
- Opciones inválidas dentro del menú.
- Potencia con exponente cero.
- Factorial de cero.

## Archivos principales

- `src/11_practica.s`: programa principal de la calculadora.
- `src/05_atoi.s`: conversión de texto ASCII a número entero.
- `src/06_itoa.s`: conversión de número entero a texto ASCII.
- `Makefile.qemu`: compilación y ejecución utilizando QEMU.
- `Makefile.arm64`: compilación para ARM64 nativo.

## Compilación y ejecución

Para compilar y ejecutar utilizando QEMU:

```bash
make -f Makefile.qemu SRC=src/11_practica.s run
```

## Depuración

El programa puede analizarse utilizando GDB Multiarch.

Durante las pruebas se verificaron las rutinas de potencia y factorial mediante desensamblado, símbolos y breakpoints.

Para iniciar GDB:

```bash
gdb-multiarch build/src/11_practica
```

Dentro de GDB se pueden utilizar los siguientes comandos:

```text
set architecture aarch64
disassemble do_potencia
disassemble factorial
break do_potencia
info breakpoints
info address do_potencia
info address factorial
list do_potencia
```

## Tecnologías utilizadas

- ARM64 / AArch64 Assembly
- GNU Assembler
- GNU Linker
- QEMU
- GDB Multiarch
- WSL
- Ubuntu