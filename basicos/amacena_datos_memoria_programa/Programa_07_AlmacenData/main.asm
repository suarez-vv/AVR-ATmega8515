; Programa que almacena datos en la Memoria del Programador, y los muestra en 4 displays

;Programa_07_AlmacenaDatos_MemProg

;Autor: Suárez, V.V.

	.INCLUDE <M8515DEF.INC>

;Configuración del Stack Pointer

	LDI R16, HIGH(RAMEND)
	OUT SPH, R16
	LDI R16, LOW(RAMEND)
	OUT SPL, R16

;Configuración del Puerto A
	
	LDI R16, 0xFF
	OUT DDRA, R16  

; Programa principal

PRINCIPAL:	LDI R16, 0   ;Offset

CICLO:		LDI R31, HIGH(TABLA << 1) ;Registro z = (R31:R30)  Z=(HIGH+LOW)
			LDI R30, LOW(TABLA << 1)

			ADD R30, R16    ;Verificamos que la suma no supere 255 (c=0)

			BRCC SIGUE		;Salta a "SIGUE" si c=0
			INC R31

SIGUE:		LPM R17, Z      ;Trae el dato al registro R17, donde apunta Z
							;LMP = LOAD PROGRAM MEMORY
			
			OUT PORTA, R17
			RCALL TIEMPO 
			INC R16			;Aumentamos el Offset

			CPI R16, 29		;Verifica si ya termine de mostrar los datos 
			BREQ PRINCIPAL
			RJMP CICLO      ;Salta a "PRINCIPAL" si z==1 (R16 == 0)

;Funciones

TIEMPO:
			LDI R24, 7			;Generar retraso de 1 segundo
				LDI R25, 150
				LDI R26, 128
			L1: DEC R26
				BRNE L1
				DEC R25
				BRNE L1
				DEC R24
				BRNE L1

				RET 


;Tabla de valores a tomar para mostrar en los displays
TABLA:
	
	.DB	0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x98, 0x88, 0x83, 0xC6, 0xA1, 0x86, 0x8E, 0x90, 0x89, 0xFB, 0xE1, 0xC7, 0xAB, 0xAA,  0xA3, 0x8C, 0x98, 0xAF, 0xE3, 0x91
	  ;	  0    1     2     3      4    5      6     7     8     9     A     B    C     D     E     F     G     h      i    J      L    n     ñ      o     P     q     r      u    Y            


