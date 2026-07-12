;08 de octubre, 2025
;Programa_02_PB_PA
;Programa para  leer el puerto B y pasar los datos al puerto A

;Autor: Suárez, V.V.

.include <m8515def.inc>

;Configuramos los puertos

		LDI		R16,0				;Así se definen los DECIMALES
		OUT		DDRB, R16			;Configuramos el puerto B como ENTRADA
		LDI		R16, 0b11111111		;Ahí está en binario, es -> 0xFF hexadecimal, y -> 255 decimal
		OUT		DDRA, R16			;Configuramos el puerto A como SALIDA
		OUT		PORTB, R16			;Activamos las resistencias de Pull-Up

;Programa Principal

LAZO:
		IN		R16, PINB			;Leemos los datos del puerto B y los pasamos al registro R16
		OUT		PORTA, R16			;Mandamos al puerto A lo que está contenido en el registro R16
		RJMP	LAZO				;Con esta instrucción, hacemos un lazo infinito

