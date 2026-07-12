# AVR-ATmega8515

Colección de prácticas y proyectos desarrollados para el microcontrolador AVR ATmega8515 utilizando lenguaje ensamblador, simulación electrónica y desarrollo de sistemas embebidos.

El repositorio reúne ejercicios y proyectos que muestran el aprendizaje progresivo de conceptos relacionados con puertos de entrada y salida, memoria de programa, interrupciones, displays de 7 segmentos, teclados matriciales y multiplexación, culminando con la implementación de una chapa electrónica de seguridad.

## Objetivo

Practicar el desarrollo de aplicaciones para microcontroladores AVR mediante la implementación de periféricos, manejo de interrupciones, acceso a memoria y diseño de sistemas embebidos utilizando lenguaje ensamblador.

## Tecnologías Utilizadas

- AVR ATmega8515
- AVR Assembly
- Microchip Studio
- Proteus
- Logarism
- Sistemas Embebidos
- Electrónica Digital

## Contenido del Repositorio

### Fundamentos

Prácticas relacionadas con:

- Lectura y escritura de puertos.
- Desplazamiento de bits.
- Displays de 7 segmentos.
- Contadores digitales.
- Memoria de programa.

### Periféricos

Prácticas relacionadas con:

- Interrupciones externas.
- Teclados matriciales.
- Multiplexación de displays.
- Manejo de tablas en memoria.

### Circuitos Digitales

Diseños realizados en Logarism para comprender conceptos fundamentales de electrónica digital, incluyendo:

- Sumadores.
- Restadores.
- Máquinas de estados.
- Circuitos combinacionales.
- Circuitos secuenciales.

### Proyecto Final

#### Chapa Electrónica

Implementación de una chapa electrónica de seguridad basada en AVR ATmega8515 que incorpora:

- Teclado matricial para ingreso de PIN.
- Displays de 7 segmentos.
- Multiplexación mediante Timer0.
- Lógica inversa.
- PIN de acceso configurable.
- PIN de recuperación.
- Indicador de apertura y cierre mediante LED.
- Simulación en Proteus.
- Implementación física en protoboard.

## Estructura del Proyecto

```text
AVR-ATmega8515/
│
├── basicos/
│       ├── almacena_datos_memoria_programa/
│       ├── contador_0-99/
│       ├── desplaza_bit/
│       ├── display_7_segmentos/
│       └── lectura_puertos/
│
├── perifericos/
│       ├── interrupciones/
│       ├── multiplexacion_4_displays/
│       └── teclado_matricial/
│
├── proyecto_final/
│       ├── Chapa_Electronica/
│       ├── Proteus/
│       └── Chapa_Electronica.atsln
│ 
├── digital_logic/
│
├── docs/
│       └── Logica_Inversa_Hexadecimal.xlsx
│
├── images/
│
├── README.md
└── .gitignore
```

## Prácticas Destacadas

### Multiplexación de Displays

Implementación de multiplexación para controlar múltiples displays de siete segmentos utilizando un mismo conjunto de líneas de datos.

### Teclado Matricial

Lectura y procesamiento de entradas mediante teclado matricial utilizando técnicas de sondeo y eliminación de rebote.

### Interrupciones

Uso de interrupciones externas para modificar el comportamiento del programa principal de manera asíncrona.

### Memoria de Programa

Almacenamiento y lectura de datos desde memoria FLASH mediante tablas de consulta.

### Chapa Electrónica

Proyecto integrador que combina periféricos, temporizadores, lógica inversa, multiplexación y control de acceso.

## Conceptos Aplicados

Durante el desarrollo de estas prácticas se aplicaron conocimientos en:

- Arquitectura AVR.
- Programación en lenguaje ensamblador.
- Sistemas embebidos.
- Electrónica digital.
- Manejo de puertos de entrada y salida.
- Memoria de programa.
- Temporizadores.
- Interrupciones.
- Teclados matriciales.
- Multiplexación.
- Displays de siete segmentos.
- Lógica digital.
- Diseño de circuitos.

## Autor

- Suárez Vega, Vladimir

## Nota

Proyecto desarrollado originalmente con fines académicos y educativos para practicar y fortalecer conocimientos relacionados con sistemas embebidos, arquitectura AVR, electrónica digital, programación en lenguaje ensamblador y desarrollo de aplicaciones para microcontroladores.

### Historial del Proyecto

- Desarrollo original: **septiembre-noviembre de 2025**.
- Publicación y documentación en GitHub: **julio de 2026**.