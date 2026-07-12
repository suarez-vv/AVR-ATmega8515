;Programa que utiliza las intrerrupciones en el programador, el programa principal muestra los números del 0-9
;y con un botón al llamar la interrupción, muestra A-F y al finalizar regresa al punto en dónde estaba del programa
;principal

;Programa_08_Interrupciones

;Autor: Suárez, V.V.

	.INCLUDE <M8515DEF.INC>
	.ORG 0x000

			RJMP PRINCIPAL

	.ORG 0x001
			RJMP	INT_EXT_0  

	.ORG 0x020

PRINCIPAL:

;Configuración de puerto A y B como salida, además C para interrupcion
			LDI		R16, 0x0FF
			OUT		DDRA, R16
			OUT		DDRB, R16

			LDI		R17, 0x00
			OUT		DDRD, R17

			OUT		PORTD, R16  ;Activamos la resistencia de Pull-Up de PD

;Configuarcion del stack pointer
			LDI		R16, HIGH(RAMEND)
			OUT		SPH, R16
			LDI		R16, LOW(RAMEND)
			OUT		SPL, R16

;Configuracion de las interrupciones externas
			LDI		R16, 0B00000010
			OUT		MCUCR, R16

			LDI		R16, 0B01000000
			OUT		GICR, R16

			SEI

 ;-------------------------------------------------------------------------------------------------------

INICIO:		LDI		R16, 0x00	;Se usa R16 como offset con el apuntador

CICLO:		

			;Obtención de los valores de la tabla de números
			LDI		R31, HIGH(TABLA_NUMEROS << 1)

			LDI		R30, LOW(TABLA_NUMEROS << 1)

			ADD		R30, R16    ;Comprobar que no se pase de 25
			BRCC	SIGUE
			INC		R31

SIGUE:
			LPM		R17, Z		;Traer el valor de la tabla

			OUT		PORTA, R17 ;Mostrar en el puerto A
			OUT		PORTB, R17 ;Mostrar en el puerto B para seleccionar que transistores se encienden

			RCALL	UN_SEG
			INC		R16

			CPI		R16, 0x0A

			BREQ	INICIO
			RJMP	CICLO
;Subrutinas

UN_SEG:						;Retraso de aprox. 1 segundo
			LDI		R20, 7
			LDI		R21, 150
			LDI		R22, 128

		L1: DEC		R22
			BRNE	L1
			DEC		R21
			BRNE	L1
			DEC		R20
			BRNE	L1
			RET

					RET



;Codigo para las interrupciones

INT_EXT_0:
			;Se almacenan los valores que tenia el programa principal antes de la interrupción
			PUSH	R30
			PUSH	R31
			PUSH	R20		;Cuanto tiempo llevaba antes de la interrupcion

			LDI		R18, 0x00

CICLO2:

			;Obtención de los valores de la tabla de letras
			LDI		R31, HIGH(TABLA_LETRAS << 1)
			LDI		R30, LOW(TABLA_LETRAS << 1)

			ADD		R30, R18		;Comprobar que no se pase de 255

			BRCC	SIGUE2
			INC		R31

SIGUE2:
			LPM		R19, Z		;Obtener el valor de Z (traido de la tabla)

			OUT		PORTA, R19  ;Mostrar el valor de la tabla en los displays
			OUT		PORTB, R19

			RCALL	UN_SEG

			INC		R18

			CPI		R18, 0x06
			
			BREQ	FIN_IE0

			RJMP	CICLO2

			;Al finalizar la interrupción se devuelven los valores de la tabla de números donde estaba el programa principal
FIN_IE0:
			POP		R20
			POP		R31
			POP		R30

			RETI

;Definicion de las TABLAS a las que se van a acceder

TABLA_NUMEROS:
			.DB		0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x98
			;         0     1     2     3     4     5     6     7    8      9

TABLA_LETRAS:
			.DB		0x88, 0x83, 0xC6, 0xA1, 0x86, 0x8E
			;         A     B    C     D      E     F