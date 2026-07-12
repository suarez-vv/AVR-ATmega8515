;Programa que desplaza un bit de Izquierda a Derecha o al revés
;Programa_03_DesplazaBit
;Autor: Suárez, V.V.

.include <m8515def.inc>

;Configuramos al Puerto A como salida
	
	LDI		R16, 0xFF
	OUT		DDRA, R16		;Config PA como salida
;------------------------------------------
		LDI		R16, 0b10000000
		LDI		R17, 0b01000000
		LDI		R18, 0x20		;Código para encender uno de los 8 LEDS (cada linea enciende uno diferente)
		LDI		R19, 0x10
		LDI		R20, 0x08
		LDI		R21, 0x04
		LDI		R22, 0x02
		LDI		R23, 1

;Escribimos en el puerto A
CICLO:	OUT		PORTA, R16
		
		LDI		R26,10		;Ciclo usado para aparentar que hay 1 segundo de retraso entre cada cambio de LED
CICLO3: LDI		R25, 0xFF	;Se establecen los valores "contadores"
CICLO2: LDI		R24, 0xFF	
CICLO1: DEC		R24
		BRNE	CICLO1
		DEC		R25			;Se decrementan los contadores quedar en 0 
		BRNE	CICLO2
		DEC		R26
		BRNE	CICLO3

		OUT		PORTA, R17  ;Se hace la salida al puerto A mandando la señal para el LED que se quiera tener encendido
		
		;Cada ciclo repite lo mismo lo único que cambia es el LED encendido
		LDI		R26,10
CICLO31:LDI		R25, 0xFF	
CICLO21:LDI		R24, 0xFF
CICLO11:DEC		R24
		BRNE	CICLO11
		DEC		R25
		BRNE	CICLO21
		DEC		R26
		BRNE	CICLO31

		OUT		PORTA, R18

		LDI		R26,10
CICLO32:LDI		R25, 0xFF	
CICLO22:LDI		R24, 0xFF
CICLO12:DEC		R24
		BRNE	CICLO12
		DEC		R25
		BRNE	CICLO22
		DEC		R26
		BRNE	CICLO32

		OUT PORTA, R19

		LDI		R26,10
CICLO33:LDI		R25, 0xFF	
CICLO23:LDI		R24, 0xFF
CICLO13:DEC		R24
		BRNE	CICLO13
		DEC		R25
		BRNE	CICLO23
		DEC		R26
		BRNE	CICLO33

		OUT		PORTA, R20

		LDI		R26,10
CICLO34:LDI		R25, 0xFF	
CICLO24:LDI		R24, 0xFF
CICLO14:DEC		R24
		BRNE	CICLO14
		DEC		R25
		BRNE	CICLO24
		DEC		R26
		BRNE	CICLO34

		OUT		PORTA, R21

		LDI		R26,10
CICLO35:LDI		R25, 0xFF	
CICLO25:LDI		R24, 0xFF
CICLO15:DEC		R24
		BRNE	CICLO15
		DEC		R25
		BRNE	CICLO25
		DEC		R26
		BRNE	CICLO35

		OUT		PORTA, R22

		LDI		R26,10
CICLO36:LDI		R25, 0xFF	
CICLO26:LDI		R24, 0xFF
CICLO16:DEC		R24
		BRNE	CICLO16
		DEC		R25
		BRNE	CICLO26
		DEC		R26
		BRNE	CICLO36

		OUT		PORTA, R23

		LDI		R26,10
CICLO37:LDI		R25, 0xFF	
CICLO27:LDI		R24, 0xFF
CICLO17:DEC		R24
		BRNE	CICLO17
		DEC		R25
		BRNE	CICLO27
		DEC		R26
		BRNE	CICLO37

		RjMP	CICLO	;Regresa al CICLO principal para repetir todo indefinidamente
