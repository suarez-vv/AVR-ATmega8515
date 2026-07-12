;Programa que hace la simulación de una chapa electrónica de seguridad, usando un teclado matricial para
;ingreso de los valores de PIN y mostrado en 4 displays ánodo común mediante multiplexación (usando
; Timer0 para multiplexar), haciendo uso de lógica inversa. Como indicador de abierto o cerrado de la chapa,
;se usa un LED, donde: encendido = cerrado, apagado = abierto

;Autor: Suárez, V.V.

;===================================================================
;------------------------ USO DE REGISTROS -------------------------

;		R8-R11   - PIN de respaldo o reestablecimiento
;		R12-R15  - PIN establecido por el usuario
;		R16		 - Registro usado como Auxiliar para diferentes acciones
;		R17		 - Offset de la tabla de Datos
;		R18		 - Control del LED
;		R19		 - Dato leído del KeyPad
;		R20-R23  - Guardar momentaneamente el PIN que se ingrese para intentrar desbloquear la chapa
;		R24		 - Manejo de los transistores
;		R28		 - Tiempo de la rutina de Rebote para el KeyPad
;		R29		 - Tiempo de retraso para multiplexación
;		R30-R31  - High-Low de la tabla

;====================================================================

		.INCLUDE	<M8515DEF.INC>
		.ORG		0000
					RJMP	PRINCIPAL
		.ORG		0x007
					RJMP	TIMER0_OVF
		.ORG		0x020


PRINCIPAL:
; ----------- CONFIGURACIÓN DEL STACK POINTER ----------------
			LDI		R16, HIGH(RAMEND)
			OUT		SPH, R16
			LDI		R16, LOW(RAMEND)
			OUT		SPL, R16

; ------------ CONFIGURACIÓN DE LOS PUERTOS -----------------
			LDI		R16, 0xFF
			OUT		DDRA, R16		;Puerto A para la salida directa a los Displays
			OUT		DDRB, R16		;Puerto B para activar los transistores para la multiplexación
	
			LDI		R16, 0xF0		;La mitad superior del Puerto C como salida (Filas del teclado matricial)
			OUT		DDRC, R16
			LDI		R16, 0xFF		;La otra mitad del Puerto C (inferior) para las resistencias Pull-Up (Columnas del teclado matricial)
			OUT		PORTC, R16

			LDI		R16, 0xFF
			OUT		DDRD, R16		;Puerto D como salida (LED de apertura - cierre de la chapa) - PD0
			CLR		R16
			OUT		PORTD, R16

; ----------- CONFIGURAR EL TIMER 0 PARA OPERAR CON SOBREFLUJO (OVF) ------------
			LDI		R16, 0b00000010
			OUT		TIMSK, R16

; -------------------- CONFIGURAR EL PRESCALADOR ----------------------
			LDI		R16, 0b00000001
			OUT		TCCR0, R16

; ----------- ACTIVAR LAS INTERRUPCIONES DE FORMA GENERAL ----------
			SEI

; ============== INICIALIZACIÓN DE LAS VARIABLES ====================

; --------- PIN DE REESTABLECIMIENTO - 1714 -----------------
			LDI		R16, 0xF9
			MOV		R8, R16
			LDI		R16, 0xF8
			MOV		R9, R16
			LDI		R16, 0xF9
			MOV		R10, R16
			LDI		R16, 0x99
			MOV		R11, R16

; -------- PIN POR DEFAULT PARA LA CHAPA CERRADA - 0000 -----------
			LDI		R16, 0xC0
			MOV		R12, R16
			MOV		R13, R16
			MOV		R14, R16
			MOV		R15, R16

; ------- REGISTROS PARA PROBAR EL PIN (EMPIEZAN LIMPIOS, LISTOS PARA USARSE) ------------  (Para pruebas les asignare 1, 2 3, 4) en lugar de tenerlos limpios, hay que limpiarlos antes de enviar
			LDI	R20, 0xF9;CLR		R20
			LDI	R21, 0xA4;CLR		R21
			LDI R22, 0xB0;CLR		R22
			LDI	R23, 0x99;CLR		R23

; ------- REGISTRO DEL ESTADO DE LA CHAPA (ABIERTO/CERRADO) ---------
			LDI		R18, 0
			OUT		PORTD, R18	;Al principio el LED esta encendido (chapa cerrada)

CICLO:		RJMP	CICLO		;Ciclo para estar repitiendo constantemente 


; ================ SUBRUTINAS =================

; ----------- SUBRTUINA DEL TIMER 0 OPERANDO COMO SOBREFLUJO ------------

TIMER0_OVF:
			;Display 0
			RCALL	MOSTRAR_0
			;Display 1
			RCALL	MOSTRAR_1
			;Display 2
			RCALL	MOSTRAR_2
			;Display 3
			RCALL	MOSTRAR_3

			RETI

		; --- Multiplexación de los Displays ------
		MOSTRAR_0:
			OUT		PORTA, R20  ;Display 1
			LDI		R24, 0xFF
			OUT		PORTB, R24
			LDI		R24, 0xFE
			OUT		PORTB, R24
			RCALL	TIEMPO_MU
			RET

		MOSTRAR_1:
			OUT		PORTA, R21		;Display 2
			LDI		R24, 0xFF
			OUT		PORTB, R24
			LDI		R24, 0xFD        
			OUT		PORTB, R24
			RCALL	TIEMPO_MU
			RET

		MOSTRAR_2:
			OUT		PORTA, R22		;Display 3
			LDI		R24, 0xFF
			OUT		PORTB, R24
			LDI		R24, 0xFB         
			OUT		PORTB, R24
			RCALL	TIEMPO_MU
			RET

		MOSTRAR_3:
			OUT		PORTA, R23		;Display 4
			LDI		R24, 0xFF
			OUT		PORTB, R24
			LDI		R24, 0xF7        
			OUT		PORTB, R24
			RCALL	TIEMPO_MU
			RET

; ------- SUBRTUINA DE TIEMPO PARA MULTIPLEXAR ----------

TIEMPO_MU:
			LDI		R29, 255
		L1:
			DEC		R29
			BRNE	L1
			RET