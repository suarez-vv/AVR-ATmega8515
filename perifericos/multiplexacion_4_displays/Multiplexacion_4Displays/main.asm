;Programa para hacer Multiplexion en 4 displays (mostrar un valor diferente
;en cada display estando conectados al mismo puerto)

;Multiplexacion_4Displays

;Autor: Suárez, V.V.

;-------------------NOTAS---------------------------

;USO DE LOS REGISTROS:

	;R16-R19 usados para obetener los valores de cada tabla
	;R20-R23 para cargar de la memoria del programa el valor a mostrar en cada display
	;R24-R25 para hacer iteraciones dentro de un ciclo y aparentar 1 segundo entre cada cambio de los displays
	;R26 para mandar la salida al puerto B (transistores) y hacer la multiplexion
	;R27 manejar la rutina de tiempo de 2ms entre cada display (para aparentar que todos estuvieran encendidos al mismo tiempo)
	;R30-R31 control del stack pointer

;USO DEL STACK POINTER

	;El ATMEGA8515 solo usa Z como parte de puntero del stackpointer, para lograr simular tener otra variables (Z, Y, X, W) para usar las 4 tablas
	;se usaron funciones (OK_Z, OK_Y, OK_X, OK_W) para verificar que nada se ha desbordado y aunque solo se use Z, aparentar usar tambien Y, X y W
	;para el control de las tablas

;----------------------------------------------------

.INCLUDE <M8515DEF.INC>

;Configuracion del stack pointer
LDI R16, LOW(RAMEND)
OUT SPL, R16
LDI R16, HIGH(RAMEND)
OUT SPH, R16

;Configuracion de los puertos A y B como salida
LDI R16, 0xFF
OUT DDRA, R16           ;Puerto A para displays (segmentos)
LDI R16, 0x0F
OUT DDRB, R16           ;Puerto B pines del 0 al 3 para los transistores 

;Programa principal
PRINCIPAL: 
	LDI R16, 0 ;Al principio tomamos el valor de la posicion 0 de cada tabla
	LDI R17, 0
	LDI R18, 0
	LDI R19, 0

CICLO:
	
	LDI R24, 0 ;Iniciamos en 0 los contadores para aparentar 1 segundo (se hace con iteraciones y no rutina de tiempo)
	LDI R25, 0
	;-------------- TABLA1 (Obtencion del valor) ----------------------------
	LDI	R31, HIGH(TABLA1 << 1)
	LDI R30, LOW(TABLA1 << 1)
	ADD R30, R16 ;Verificamos que no haya desbordamiento
	BRCC OK_Z
	INC R31

OK_Z: ;Si no hubo desbordameinto seguimos
	LPM R20, Z ;Leer valor de Tabla1  ------------------- Uso de 'Z'
	PUSH R30 ;Guardamos los valores de R30 y R31
	PUSH R31
	;-------------- TABLA2 (Obtencion del valor) ----------------------------
	LDI R31, HIGH(TABLA2 << 1)
	LDI	R30, LOW(TABLA2 << 1)
	ADD R30, R17
	BRCC OK_Y
	INC R31

OK_Y:
	LPM R21, Z ;Leer valor de Tabla2 ---------------------- Seria como usar 'Y'
	POP R31 ;Volvemos a sacar los valores de R30 y R31, para no sobreescribir cuando volvamos a guardarlos
	POP R30

	;-------------- TABLA3 (Obtencion del valor) ----------------------------
	PUSH R30 ;Guardamos nuevamente los valores de R30 y R31
	PUSH R31
	
	LDI R31, HIGH(TABLA3 << 1)
	LDI R30, LOW(TABLA3 << 1)
	ADD R30, R18
	BRCC OK_X
	INC R31

OK_X:
	LPM R22, Z ;Leer valor de Tabla3  ---------------------- Seria como usar 'X'
	POP R31
	POP R30

	;-------------- TABLA4 (Obtencion del valor) ----------------------------
	PUSH R30
	PUSH R31

	LDI R31, HIGH(TABLA4 << 1)
	LDI R30, LOW(TABLA4 << 1)
	ADD R30, R19
	BRCC OK_W
	INC R31

OK_W:
	LPM R23, Z ;Leer valor de Tabla4 ---------------------- Seria como usar 'W'
	POP R31
	POP R30
	BRNE SIGUE
	
	
SIGUE:
	INC R25
	BRNE SEG_SIGUE
	INC R24

SEG_SIGUE:
	;Display 0
    OUT PORTA, R20
    LDI R26, 0xFF
    OUT PORTB, R26        ; Apaga todos los displays (pines del PortB)
    LDI R26, 0xFE         ; Activa solo el Pin 0 del PORTB
    OUT PORTB, R26
    RCALL TIEMPO
	

    ;Display 1
    OUT PORTA, R21
    LDI R26, 0xFF
    OUT PORTB, R26		  ; Apaga todos los displays (pines del PortB)
    LDI R26, 0xFD         ; Activa solo el Pin 1 del PORTB
    OUT PORTB, R26
    RCALL TIEMPO

    ;Display 2
    OUT PORTA, R22
    LDI R26, 0xFF
    OUT PORTB, R26		  ; Apaga todos los displays (pines del PortB)
    LDI R26, 0xFB         ; Activa solo el Pin 2 del PORTB
    OUT PORTB, R26
    RCALL TIEMPO

    ;Display 3
    OUT PORTA, R23
    LDI R26, 0xFF
    OUT PORTB, R26		  ; Apaga todos los displays (pines del PortB)
    LDI R26, 0xF7         ; Activa solo el Pin 3 del PORTB
    OUT PORTB, R26
    RCALL TIEMPO

	CPI R24, 3   ;Contador para simular 1 segundo entre cada cambio de valor de todos los displays
	BRNE SIGUE

	INC R16    ; Aumento de los contadores de los datos de la tabla
	INC R17
	INC R18
	INC R19

	CPI	R16, 4    ; Si ya se mostraron los 4 datos, se reinicia, eso con cada registro que cuenta los datos de la tabla
	BRNE SALTAR1
	CLR R16

SALTAR1:			;Comrpobar si ya se mostraron los valores correspondientes para cada display según su tabla (4 valores)
	CPI R17, 4
	BRNE SALTAR2
	CLR R17

SALTAR2:
	CPI R18, 4
	BRNE SALTAR3
	CLR R18

SALTAR3:
	CPI R19, 4
	BRNE SALTAR_CICLO
	CLR R19

SALTAR_CICLO:
    RJMP CICLO

;Rutinas


;Para generar el tiempo de retraso de 2ms entre encendido y apagado de los 4 displays (simular que todos estan encendidos al mismo tiempo)
TIEMPO:
    LDI R27, 255
L1:
    DEC R27
    BRNE L1
    RET

;Tablas
TABLA1:
		.DB 0xC0, 0xF9, 0xA4, 0xB0  ; Valores 0-3

TABLA2:
		.DB 0x99, 0x92, 0x82, 0xF8   ; Valores 4-7

TABLA3:
		.DB 0x80, 0x98, 0x88, 0x83   ; Valores 8-b

TABLA4: 
		.DB 0xC6, 0xA1, 0x86, 0x8E   ; Valores C-F
