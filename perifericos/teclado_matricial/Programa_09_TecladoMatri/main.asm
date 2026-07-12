;Programa para el funcionamiento del teclado matricial, y mostrar el valor presionado en 4 displays

;Programa_09_TecladoMatricial

;Autor: Suárez, V.V.

.INCLUDE		<M8515DEF.INC>

;Configuramos el stack pointer
		LDI		R16, HIGH(RAMEND)
		OUT		SPH, R16
		LDI		R16, LOW(RAMEND)
		OUT		SPL, R16

;Configuramos los puertos como entradas y salida
		LDI		R16, 0xFF
		OUT		DDRA, R16

		LDI		R16, 0xF0 ;Configuración de filas (Mitad superior del puerto C)
		OUT		DDRC, R16

		LDI		R16, 0xFF
		OUT		PORTC, R16 ;Configuración de resistencias Pull-up para columnas PORTC

;Inicializamos el Display con UNOS para que no aparezca nada antes de qUe comience a sondear

		LDI		R19, 0xFF
		OUT		PORTA, R19

CICLO:  ;Inicio del sondeo de todas las teclas
		LDI		R17, 0xFF	;Usamos R17 como contador de posiciones para el KeyPad (Offset)

;Ubicamos la direccion de la TABLA Z=HIGH:LOW (R31:R30) donde estan almacenados
		
		LDI		R31, HIGH(TABLA << 1)
		LDI		R30, LOW(TABLA << 1)

;Comenzamos el recorrido de las Filas del keyPad

F1:		CBI		PORTC, 7	;Comenzamos haciendo F1=0, es decir, PC.7 = 0
		
		;Ahora revisamos cada una de las columnas
F1_C1:
		INC		R17
		RCALL	Rebote		;Retardo de aprox. 20ms para evitar rebote
		IN		R18, PINC	;Leemos todo el dato del PUERTO C y lo colocamos en R18
		BST		R18, 3		;Enviamos el bit 3(C1) al bit T del Registro de Estado (BST=)
		SBI		PORTC, 7	;Regresamos a 1 el bit de la fila
		BRTS	F1_C2		;Salta a la siguiente columna "F1_Cx" si T=1

		RCALL	DatoTabla	;Si si fue presionada la columna, entonces T=0

		RJMP	CICLO

F1_C2:
		CBI		PORTC, 7
		INC		R17
		RCALL	Rebote		;Retardo de aprox. 20ms para evitar rebote
		IN		R18, PINC	;Leemos todo el dato del PUERTO C y lo colocamos en R18
		BST		R18, 1		;Enviamos el bit 3(C1) al bit T del Registro de Estado (BST=)
		SBI		PORTC, 7	;Regresamos a 1 el bit de la fila
		BRTS	F1_C3		;Salta a la siguiente columna "F1_Cx" si T=1

		RCALL	DatoTabla	;Si si fue presionada la columna, entonces T=0

		RJMP	CICLO

F1_C3:
		CBI		PORTC, 7
		INC		R17
		RCALL	Rebote		;Retardo de aprox. 20ms para evitar rebote
		IN		R18, PINC	;Leemos todo el dato del PUERTO C y lo colocamos en R18
		BST		R18, 2		;Enviamos el bit 3(C1) al bit T del Registro de Estado (BST=)
		SBI		PORTC, 7	;Regresamos a 1 el bit de la fila
		BRTS	F1_C4		;Salta a la siguiente columna "F1_Cx" si T=1

		RCALL	DatoTabla	;Si si fue presionada la columna, entonces T=0

		RJMP	CICLO


F1_C4:
		CBI		PORTC, 7
		INC		R17
		RCALL	Rebote
		IN		R18, PINC
		BST		R18, 0
		SBI		PORTC, 7
		BRTS	F2
		RCALL	DatoTabla

		RJMP	CICLO


F2:		CBI		PORTC, 6	;Comenzamos haciendo F1=0, es decir, PC.7 = 0
		
		;Ahora revisamos cada una de las columnas
F2_C1:	
		INC		R17
		RCALL	Rebote		;Retardo de aprox. 20ms para evitar rebote
		IN		R18, PINC	;Leemos todo el dato del PUERTO C y lo colocamos en R18
		BST		R18, 3		;Enviamos el bit 3(C1) al bit T del Registro de Estado (BST=)
		SBI		PORTC, 6	;Regresamos a 1 el bit de la fila
		BRTS	F2_C2		;Salta a la siguiente columna "F1_Cx" si T=1

		RCALL	DatoTabla	;Si si fue presionada la columna, entonces T=0

		RJMP	CICLO

F2_C2:
		CBI		PORTC, 6
		INC		R17
		RCALL	Rebote		;Retardo de aprox. 20ms para evitar rebote
		IN		R18, PINC	;Leemos todo el dato del PUERTO C y lo colocamos en R18
		BST		R18, 1		;Enviamos el bit 3(C1) al bit T del Registro de Estado (BST=)
		SBI		PORTC, 6	;Regresamos a 1 el bit de la fila
		BRTS	F2_C3		;Salta a la siguiente columna "F1_Cx" si T=1

		RCALL	DatoTabla	;Si si fue presionada la columna, entonces T=0

		RJMP	CICLO

F2_C3:
		CBI		PORTC, 6
		INC		R17
		RCALL	Rebote		;Retardo de aprox. 20ms para evitar rebote
		IN		R18, PINC	;Leemos todo el dato del PUERTO C y lo colocamos en R18
		BST		R18, 2		;Enviamos el bit 3(C1) al bit T del Registro de Estado (BST=)
		SBI		PORTC, 6	;Regresamos a 1 el bit de la fila
		BRTS	F2_C4		;Salta a la siguiente columna "F1_Cx" si T=1

		RCALL	DatoTabla	;Si si fue presionada la columna, entonces T=0

		RJMP	CICLO


F2_C4:
		CBI		PORTC, 6
		INC		R17
		RCALL	Rebote
		IN		R18, PINC
		BST		R18, 0
		SBI		PORTC, 6
		BRTS	F3

		RCALL	DatoTabla

		RJMP	CICLO

F3:		CBI		PORTC, 5	;Comenzamos haciendo F1=0, es decir, PC.7 = 0
		
		;Ahora revisamos cada una de las columnas
F3_C1:
		INC		R17
		RCALL	Rebote		;Retardo de aprox. 20ms para evitar rebote
		IN		R18, PINC	;Leemos todo el dato del PUERTO C y lo colocamos en R18
		BST		R18, 3		;Enviamos el bit 3(C1) al bit T del Registro de Estado (BST=)
		SBI		PORTC, 5	;Regresamos a 1 el bit de la fila
		BRTS	F3_C2		;Salta a la siguiente columna "F1_Cx" si T=1

		RCALL	DatoTabla	;Si si fue presionada la columna, entonces T=0

		RJMP	CICLO

F3_C2:
		CBI		PORTC, 5
		INC		R17
		RCALL	Rebote		;Retardo de aprox. 20ms para evitar rebote
		IN		R18, PINC	;Leemos todo el dato del PUERTO C y lo colocamos en R18
		BST		R18, 1		;Enviamos el bit 3(C1) al bit T del Registro de Estado (BST=)
		SBI		PORTC, 5	;Regresamos a 1 el bit de la fila
		BRTS	F3_C3		;Salta a la siguiente columna "F1_Cx" si T=1

		RCALL	DatoTabla	;Si si fue presionada la columna, entonces T=0

		RJMP	CICLO

F3_C3:
		CBI		PORTC, 5
		INC		R17
		RCALL	Rebote		;Retardo de aprox. 20ms para evitar rebote
		IN		R18, PINC	;Leemos todo el dato del PUERTO C y lo colocamos en R18
		BST		R18, 2		;Enviamos el bit 3(C1) al bit T del Registro de Estado (BST=)
		SBI		PORTC, 5	;Regresamos a 1 el bit de la fila
		BRTS	F3_C4		;Salta a la siguiente columna "F1_Cx" si T=1

		RCALL	DatoTabla	;Si si fue presionada la columna, entonces T=0

		RJMP	CICLO


F3_C4:
		CBI		PORTC, 5
		INC		R17
		RCALL	Rebote
		IN		R18, PINC
		BST		R18, 0
		SBI		PORTC, 5
		BRTS	F4

		RCALL	DatoTabla

		RJMP	CICLO

F4:		CBI		PORTC, 4	;Comenzamos haciendo F1=0, es decir, PC.7 = 0
		
		;Ahora revisamos cada una de las columnas
F4_C1:
		INC		R17
		RCALL	Rebote		;Retardo de aprox. 20ms para evitar rebote
		IN		R18, PINC	;Leemos todo el dato del PUERTO C y lo colocamos en R18
		BST		R18, 3		;Enviamos el bit 3(C1) al bit T del Registro de Estado (BST=)
		SBI		PORTC, 4	;Regresamos a 1 el bit de la fila
		BRTS	F4_C2		;Salta a la siguiente columna "F1_Cx" si T=1

		RCALL	DatoTabla	;Si si fue presionada la columna, entonces T=0

		RJMP	CICLO

F4_C2:
		CBI		PORTC, 4
		INC		R17
		RCALL	Rebote		;Retardo de aprox. 20ms para evitar rebote
		IN		R18, PINC	;Leemos todo el dato del PUERTO C y lo colocamos en R18
		BST		R18, 1		;Enviamos el bit 3(C1) al bit T del Registro de Estado (BST=)
		SBI		PORTC, 4	;Regresamos a 1 el bit de la fila
		BRTS	F4_C3		;Salta a la siguiente columna "F1_Cx" si T=1

		RCALL	DatoTabla	;Si si fue presionada la columna, entonces T=0

		RJMP	CICLO

F4_C3:
		CBI		PORTC, 4
		INC		R17
		RCALL	Rebote		;Retardo de aprox. 20ms para evitar rebote
		IN		R18, PINC	;Leemos todo el dato del PUERTO C y lo colocamos en R18
		BST		R18, 2		;Enviamos el bit 3(C1) al bit T del Registro de Estado (BST=)
		SBI		PORTC, 4	;Regresamos a 1 el bit de la fila
		BRTS	F4_C4		;Salta a la siguiente columna "F1_Cx" si T=1

		RCALL	DatoTabla	;Si si fue presionada la columna, entonces T=0

		RJMP	CICLO


F4_C4:
		CBI		PORTC, 4
		INC		R17
		RCALL	Rebote
		IN		R18, PINC
		BST		R18, 0
		SBI		PORTC, 4
		SBRC	R18, 0
		RJMP	F1

		RCALL	DatoTabla

		BRTS	NEXT_CICLO


;Rutinas

NEXT_CICLO:
		RJMP	CICLO

Rebote:  ;Deben ser 20ms
			LDI		R20, 2

		L1: DEC		R20
			BRNE	L1
			
		
		RET


DatoTabla:
		PUSH R16		;Guardar los valores actuales de los registros
		PUSH R17
		PUSH R30
		PUSH R31

		LDI  R16, 0			;Obtener el valor dela tabla y mostrarlo en el Puerto A (displays)
		ADD  R30, R17
		ADC  R31, R16
		LPM  R19, Z
		OUT  PORTA, R19
			
		POP  R31			;Regresar los valores originales de los registros
		POP  R30
		POP  R17
		POP  R16
		RET

TABLA:
	.DB		0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x98 
	;         0     1     2     3     4     5     6     7     8     9
	.DB		0x88, 0x83, 0xC6, 0xA1, 0x86, 0x8E
	;        A      B     C    D     E      F