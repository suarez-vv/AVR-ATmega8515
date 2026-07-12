;Programa que cuenta desde 0 a 99  usando dos displays para mostrar los valores, usando puertos A y B, A para unidades
;y B para decenas

;Contador_0-99

;Autor: Suárez, V.V.

	.INCLUDE <M8515DEF.INC>


;Configuración del Stack Pointer
	LDI	R16, HIGH(RAMEND)
	OUT SPH, R16
	LDI R16, LOW(RAMEND)
	OUT SPL, R16


;Configuramos los puertos A y B como salidas

	LDI	R16, 0xFF
	OUT DDRA, R16	;Puerto A para manejar unidades
	OUT DDRB, R16	;Puerto B para manejar decenas


;Programa Principal

PRINCIPAL:	
			LDI		R17, 0  ;Usada para manejar las unidades
			LDI		R18, 0  ;Usada para manejar las decenas

DECENAS:	
			;Obtención del valor de la tabla para representar decenas
			LDI		R31, HIGH(TABLA << 1)
			LDI		R30, LOW(TABLA << 1)
			ADD		R30, R18   ;Comprobar que no se pase de 255

			BRCC	SIGUE1
			INC		R31

SIGUE1:		LPM		R16, Z
			OUT		PORTB, R16  ;Mostrar las decenas en el display conectado al puerto B

UNIDADES:	
			;Obtención del valor de la tabla para representar unidades
			LDI		R31, HIGH(TABLA << 1)
			LDI		R30, LOW(TABLA << 1)
			ADD		R30, R17    ;Comprobar que no se pase de 255
			BRCC	SIGUE2
			INC		R31

SIGUE2:		LPM		R16, Z
			OUT		PORTA, R16	;Mostrar las unidades en el display conectado al puerto A

			RCALL	TIEMPO

			INC		R17
			CPI		R17, 10
			BRNE	UNIDADES

			LDI		R17, 0
			INC		R18
			CPI		R18, 10
			BRNE	DECENAS

			RJMP	PRINCIPAL ;Regresar al ciclo principal para repetir indefinidamente

;Subrutinas

TIEMPO:
		;Para practicidad se configuró para que los valores de muestren de manera rápida, si se quiere configurar con 1 seg. de retraso basta con cambiar
		;los valores de esta misma parte abajo, por lo que se encuentran respectivamente a su derecha precedidos por un ';'
		LDI		R24, 2  ;7
		LDI		R25, 2  ;150
		LDI		R26, 2  ;128
	L1:	DEC		R26
		BRNE	L1
		DEC		R25
		BRNE	L1
		DEC		R24
		BRNE	L1
		RET

		;Tabla de valores del 0-9
TABLA:
		.DB 0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xB8, 0x80, 0x98
		;     0     1    2      3     4     5     6     7     8    9