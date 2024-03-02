# Elementos para el Juego "Snake"

.data

# Pantalla
AnchuraPantalla: .word 32
AlturaPantalla: .word 32

# Colores
colorSerpiente: .word 0x002EFF
colorFondo: .word 0x00EA27	
colorBorde: .word 0x00AC0A 	
colorFruta: .word 0xFF0000	

# Puntuación
puntuacion: .word 0
puntuacionGanancia: .word 1

# Velocidad de movimiento de la serpiente
Velocidad: .word 50

# Mensajes
PerdioMensaje: .asciiz "Has muerto.... Tu puntuacion fue: "

# Componentes Serpiente
cabezaSerpienteX: .word 15
cabezaSerpienteY: .word 15
colaSerpienteX: .word 15
colaSerpienteY: .word 21
direccion: .word 119 # La serpiente comienza viendo para arriba
direccionCola: .word 119

# Direcciones
# 119 - mover arriba - W
# 115 - mover abajo - S
# 97 - mover izquierda - A
# 100 - mover derecha - D

# Almacena las coordenadas del cambio de dirección cuando la cola
# choca con la posición en este arreglo. Se usa para que la cola siga la cabeza
cambioDireccionArray: .word 0:100

# Almacena la nueva dirección de la cola a moverse cuando choca con la dirección en el arreglo superior
cambioNuevaDireccionArray: .word 0:100

# Almacena la posición del fin del arreglo
arrayPosicion: .word 0
locacionEnArray: .word 0

# Fruta
posicionFrutaX: .word
posicionFrutaY: .word

.text

main:
# Llenar fondo de Pantalla:
	lw $a0, AnchuraPantalla
	lw $a1, colorFondo
	mul $a2, $a0, $a0
	mul $a2, $a2, 4
	add $a2, $a2, $gp
	add $a0, $gp, $zero
LlenarPantallaLoop:
	beq $a0, $a2, Init
	sw $a1, 0($a0) #store color
	addiu $a0, $a0, 4 #increment counter
	j LlenarPantallaLoop

# Inicializar variables
Init:
	li $t0, 15
	sw $t0, cabezaSerpienteX
	sw $t0, cabezaSerpienteY
	sw $t0, colaSerpienteX
	li $t0, 21
	sw $t0, colaSerpienteY
	li $t0, 119
	sw $t0, direccion
	sw $t0, direccionCola
	li $t0, 1
	sw $t0, puntuacionGanancia
	li $t0, 50
	sw $t0, Velocidad
	sw $zero, arrayPosicion
	sw $zero, locacionEnArray
	sw $zero, puntuacion
	
ClearRegisters:
	li $v0, 0
	li $a0, 0
	li $a1, 0
	li $a2, 0
	li $a3, 0
	li $t0, 0
	li $t1, 0
	li $t2, 0
	li $t3, 0
	li $t4, 0
	li $t5, 0
	li $t6, 0
	li $t7, 0
	li $t8, 0
	li $t9, 0
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0		

# Dibujar Borde

DibujarBorde:
	li $t1, 0
	LoopIzquierdo:
	move $a1, $t1
	li $a0, 0
	jal CordenadaAddress
	move $a0, $v0
	lw $a1, colorBorde
	jal DibujarPixel
	add $t1, $t1, 1
	
	bne $t1, 32, LoopIzquierdo
	
	li $t1, 0
	LoopDerecho:
	move $a1, $t1
	li $a0, 31
	jal CordenadaAddress
	move $a0, $v0
	lw $a1, colorBorde
	jal DibujarPixel
	add $t1, $t1, 1
	
	bne $t1, 32, LoopDerecho
	
	li $t1, 0
	LoopArriba:
	move $a0, $t1
	li $a1, 0
	jal CordenadaAddress
	move $a0, $v0
	lw $a1, colorBorde
	jal DibujarPixel
	add $t1, $t1, 1
	
	bne $t1, 32, LoopArriba
	
	li $t1, 0
	LoopAbajo:
	move $a0, $t1
	li $a1, 31
	jal CordenadaAddress
	move $a0, $v0
	lw $a1, colorBorde
	jal DibujarPixel
	add $t1, $t1, 1
	
	bne $t1, 32, LoopAbajo
	
# Posición inicial serpiente
	lw $a0, cabezaSerpienteX
	lw $a1, cabezaSerpienteY
	jal CordenadaAddress
	move $a0, $v0
	lw $a1, colorSerpiente
	jal DibujarPixel
	
	lw $a0, cabezaSerpienteX
	lw $a1, cabezaSerpienteY
	add $a1, $a1, 1
	jal CordenadaAddress
	move $a0, $v0
	lw $a1, colorSerpiente
	jal DibujarPixel
	
	lw $a0, cabezaSerpienteX
	lw $a1, cabezaSerpienteY
	add $a1, $a1, 2
	jal CordenadaAddress
	move $a0, $v0
	lw $a1, colorSerpiente
	jal DibujarPixel
	
	lw $a0, cabezaSerpienteX
	lw $a1, cabezaSerpienteY
	add $a1, $a1, 3
	jal CordenadaAddress
	move $a0, $v0
	lw $a1, colorSerpiente
	jal DibujarPixel
	
	lw $a0, cabezaSerpienteX
	lw $a1, cabezaSerpienteY
	add $a1, $a1, 4
	jal CordenadaAddress
	move $a0, $v0
	lw $a1, colorSerpiente
	jal DibujarPixel
	
	lw $a0, cabezaSerpienteX
	lw $a1, cabezaSerpienteY
	add $a1, $a1, 5
	jal CordenadaAddress
	move $a0, $v0
	lw $a1, colorSerpiente
	jal DibujarPixel
	
	lw $a0, cabezaSerpienteX
	lw $a1, cabezaSerpienteY
	add $a1, $a1, 6
	jal CordenadaAddress
	move $a0, $v0
	lw $a1, colorSerpiente
	jal DibujarPixel
	
	
	lw $a0, colaSerpienteX
	lw $a1, colaSerpienteY
	jal CordenadaAddress
	move $a0, $v0 
	lw $a1, colorSerpiente
	jal DibujarPixel
	
# Cargar Fruta
CrearFruta:
	li $v0, 42
	li $a1, 29
	syscall
	addiu $a0, $a0, 1
	sw $a0, posicionFrutaX
	syscall
	addiu $a0, $a0, 1
	sw $a0, posicionFrutaY
	
# Revisión Cambio de Dirección
RevisarInput:
	lw $a0, Velocidad
	jal Pause

	lw $a0, cabezaSerpienteX
	lw $a1, cabezaSerpienteY
	jal CordenadaAddress
	add $a2, $v0, $zero

	li $t0, 0xffff0000
	lw $t1, ($t0)
	andi $t1, $t1, 0x0001
	beqz $t1, SeleccionarDireccion
	lw $a1, 4($t0)
	
RevisarDireccionActual:	
	lw $a0, direccion
	jal RevisarDireccion
	beqz $v0, RevisarInput
	sw $a1, direccion
	lw $t7, direccion


# Actualizar Posición Cabeza			
SeleccionarDireccion:
	beq $t7, 119, MoverArribaLoop
	beq  $t7, 115, MoverAbajoLoop
	beq  $t7, 97, MoverIzquierdaLoop
	beq  $t7, 100, MoverDerechaLoop
	j RevisarInput
	
MoverArribaLoop:
	lw $a0, cabezaSerpienteX
	lw $a1, cabezaSerpienteY
	lw $a2, direccion
	jal RevisarChoqueFinalJuego
	lw $t0, cabezaSerpienteX
	lw $t1, cabezaSerpienteY
	addiu $t1, $t1, -1
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal CordenadaAddress
	add $a0, $v0, $zero
	lw $a1, colorSerpiente
	jal DibujarPixel

	sw  $t1, cabezaSerpienteY
	j ActualizarPosicionCola
	
MoverAbajoLoop:
	lw $a0, cabezaSerpienteX
	lw $a1, cabezaSerpienteY
	lw $a2, direccion	
	jal RevisarChoqueFinalJuego
	lw $t0, cabezaSerpienteX
	lw $t1, cabezaSerpienteY
	addiu $t1, $t1, 1
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal CordenadaAddress
	add $a0, $v0, $zero
	lw $a1, colorSerpiente
	jal DibujarPixel
	
	sw  $t1, cabezaSerpienteY	
	j ActualizarPosicionCola

MoverIzquierdaLoop:
	lw $a0, cabezaSerpienteX
	lw $a1, cabezaSerpienteY
	lw $a2, direccion	
	jal RevisarChoqueFinalJuego
	lw $t0, cabezaSerpienteX
	lw $t1, cabezaSerpienteY
	addiu $t0, $t0, -1
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal CordenadaAddress
	add $a0, $v0, $zero
	lw $a1, colorSerpiente
	jal DibujarPixel
	
	sw  $t0, cabezaSerpienteX	
	j ActualizarPosicionCola

MoverDerechaLoop:
	lw $a0, cabezaSerpienteX
	lw $a1, cabezaSerpienteY
	lw $a2, direccion	
	jal RevisarChoqueFinalJuego
	lw $t0, cabezaSerpienteX
	lw $t1, cabezaSerpienteY
	addiu $t0, $t0, 1
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal CordenadaAddress
	add $a0, $v0, $zero
	lw $a1, colorSerpiente
	jal DibujarPixel
	
	sw  $t0, cabezaSerpienteX
	j ActualizarPosicionCola

# Actualizar Posición Cola			
ActualizarPosicionCola:	
	lw $t2, direccionCola
	beq  $t2, 119, MoverColaArriba
	beq  $t2, 115, MoverColaAbajo
	beq  $t2, 97, MoverColaIzquierda
	beq  $t2, 100, MoverColaDerecha

MoverColaArriba:
	lw $t8, locacionEnArray
	la $t0, cambioDireccionArray
	add $t0, $t0, $t8
	lw $t9, 0($t0)
	lw $a0, colaSerpienteX
	lw $a1, colaSerpienteY
	beq $s1, 1, AumentarLargoArriba
	addiu $a1, $a1, -1
	sw $a1, colaSerpienteY
	
AumentarLargoArriba:
	li $s1, 0
	jal CordenadaAddress
	add $a0, $v0, $zero
	bne $t9, $a0, TrazarColaArriba
	la $t3, cambioNuevaDireccionArray
	add $t3, $t3, $t8
	lw $t9, 0($t3)
	sw $t9, direccionCola
	addiu $t8,$t8,4
	bne $t8, 396, GuardarLocacionArriba
	li $t8, 0
	
GuardarLocacionArriba:
	sw $t8, locacionEnArray
	
TrazarColaArriba:
	lw $a1, colorSerpiente
	jal DibujarPixel
	lw $t0, colaSerpienteX
	lw $t1, colaSerpienteY
	addiu $t1, $t1, 1
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal CordenadaAddress
	add $a0, $v0, $zero
	lw $a1, colorFondo
	jal DibujarPixel	
	j TrazarFruta

MoverColaAbajo:
	lw $t8, locacionEnArray
	la $t0, cambioDireccionArray
	add $t0, $t0, $t8
	lw $t9, 0($t0)
	lw $a0, colaSerpienteX
	lw $a1, colaSerpienteY
	beq $s1, 1, AumentarLargoAbajo
	addiu $a1, $a1, 1
	sw $a1, colaSerpienteY
	
AumentarLargoAbajo:
	li $s1, 0
	jal CordenadaAddress
	add $a0, $v0, $zero
	bne $t9, $a0, TrazarColaAbajo
	la $t3, cambioNuevaDireccionArray
	add $t3, $t3, $t8
	lw $t9, 0($t3)
	sw $t9, direccionCola
	addiu $t8,$t8,4
	bne $t8, 396, GuardarLocacionAbajo
	li $t8, 0
	
GuardarLocacionAbajo:
	sw $t8, locacionEnArray  
TrazarColaAbajo:

	lw $a1, colorSerpiente
	jal DibujarPixel	
	lw $t0, colaSerpienteX
	lw $t1, colaSerpienteY
	addiu $t1, $t1, -1
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal CordenadaAddress
	add $a0, $v0, $zero
	lw $a1, colorFondo
	jal DibujarPixel	
	j TrazarFruta

MoverColaIzquierda:
	lw $t8, locacionEnArray
	la $t0, cambioDireccionArray
	add $t0, $t0, $t8
	lw $t9, 0($t0)
	lw $a0, colaSerpienteX
	lw $a1, colaSerpienteY
	beq $s1, 1, AumentarLargoIzquierda
	addiu $a0, $a0, -1
	sw $a0, colaSerpienteX
	
AumentarLargoIzquierda:
	li $s1, 0
	jal CordenadaAddress
	add $a0, $v0, $zero
	bne $t9, $a0, TrazarColaIzquierda
	la $t3, cambioNuevaDireccionArray
	add $t3, $t3, $t8
	lw $t9, 0($t3)
	sw $t9, direccionCola
	addiu $t8,$t8,4
	bne $t8, 396, GuardarLocacionIzquierda
	li $t8, 0

GuardarLocacionIzquierda:
	sw $t8, locacionEnArray  

TrazarColaIzquierda:	
	lw $a1, colorSerpiente
	jal DibujarPixel	
	lw $t0, colaSerpienteX
	lw $t1, colaSerpienteY
	addiu $t0, $t0, 1
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal CordenadaAddress
	add $a0, $v0, $zero
	lw $a1, colorFondo
	jal DibujarPixel	
	j TrazarFruta

MoverColaDerecha:
	lw $t8, locacionEnArray
	la $t0, cambioDireccionArray
	add $t0, $t0, $t8
	lw $t9, 0($t0)
	lw $a0, colaSerpienteX
	lw $a1, colaSerpienteY
	beq $s1, 1, AumentarLargoDerecha
	addiu $a0, $a0, 1
	sw $a0, colaSerpienteX
	
AumentarLargoDerecha:
	li $s1, 0
	jal CordenadaAddress
	add $a0, $v0, $zero
	bne $t9, $a0, TrazarColaDerecha
	la $t3, cambioNuevaDireccionArray
	add $t3, $t3, $t8
	lw $t9, 0($t3)
	sw $t9, direccionCola
	addiu $t8,$t8,4
	bne $t8, 396, GuardarLocacionDerecha
	li $t8, 0
	
GuardarLocacionDerecha:
	sw $t8, locacionEnArray  
	
TrazarColaDerecha:
	lw $a1, colorSerpiente
	jal DibujarPixel	
	lw $t0, colaSerpienteX
	lw $t1, colaSerpienteY
	addiu $t0, $t0, -1
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal CordenadaAddress
	add $a0, $v0, $zero
	lw $a1, colorFondo
	jal DibujarPixel
	j TrazarFruta
	
# Dibujar Fruta
TrazarFruta:
	lw $a0, cabezaSerpienteX
	lw $a1, cabezaSerpienteY
	jal RevisarChoqueFruta
	beq $v0, 1, AnadirLargo

	lw $a0, posicionFrutaX
	lw $a1, posicionFrutaY
	jal CordenadaAddress
	add $a0, $v0, $zero
	lw $a1, colorFruta
	jal DibujarPixel
	j RevisarInput
	
AnadirLargo:
	li $s1, 1
	j CrearFruta
	j RevisarInput

CordenadaAddress:
	lw $v0, AnchuraPantalla
	mul $v0, $v0, $a1
	add $v0, $v0, $a0
	mul $v0, $v0, 4
	add $v0, $v0, $gp
	jr $ra

DibujarPixel:
	sw $a1, ($a0)
	jr $ra

RevisarDireccion:
	beq $a0, $a1, Igual
	beq $a0, 119, revisarAbajoPresionado
	beq $a0, 115, revisarArribaPresionado
	beq $a0, 97, revisarDerechaPresionado
	beq $a0, 100, revisarIzquierdaPresionado
	j EndRevisarDireccion
	
revisarAbajoPresionado:
	beq $a1, 115, invalido
	j aceptable

revisarArribaPresionado:
	beq $a1, 119, invalido
	j aceptable

revisarDerechaPresionado:
	beq $a1, 100, invalido
	j aceptable
	
revisarIzquierdaPresionado:
	beq $a1, 97, invalido
	j aceptable
	
aceptable:
	li $v0, 1
	
	beq $a1, 119, DireccionArriba
	beq $a1, 115, DireccionAbajo	
	beq $a1, 97, DireccionIzquierda
	beq $a1, 100, DireccionDerecha
	j EndRevisarDireccion
	
DireccionArriba:
	lw $t4, arrayPosicion
	la $t2, cambioDireccionArray
	la $t3, cambioNuevaDireccionArray
	add $t2, $t2, $t4
	add $t3, $t3, $t4
		
	sw $a2, 0($t2)
	li $t5, 119
	sw $t5, 0($t3)
	
	addiu $t4, $t4, 4
	bne $t4, 396, StopArriba
	li $t4, 0
StopArriba:
	sw $t4, arrayPosicion	
	j EndRevisarDireccion
	
DireccionAbajo:
	lw $t4, arrayPosicion
	la $t2, cambioDireccionArray
	la $t3, cambioNuevaDireccionArray
	add $t2, $t2, $t4
	add $t3, $t3, $t4
	
	sw $a2, 0($t2)
	li $t5, 115
	sw $t5, 0($t3)

	addiu $t4, $t4, 4

	bne $t4, 396, StopAbajo
	li $t4, 0

StopAbajo:	
	sw $t4, arrayPosicion
	j EndRevisarDireccion

DireccionIzquierda:
	lw $t4, arrayPosicion
	la $t2, cambioDireccionArray
	la $t3, cambioNuevaDireccionArray
	add $t2, $t2, $t4
	add $t3, $t3, $t4

	sw $a2, 0($t2)
	li $t5, 97
	sw $t5, 0($t3)

	addiu $t4, $t4, 4
	bne $t4, 396, StopIzquierda
	li $t4, 0

StopIzquierda:
	sw $t4, arrayPosicion
	j EndRevisarDireccion

DireccionDerecha:
	lw $t4, arrayPosicion
	la $t2, cambioDireccionArray
	la $t3, cambioNuevaDireccionArray
	add $t2, $t2, $t4
	add $t3, $t3, $t4
	
	sw $a2, 0($t2)
	li $t5, 100
	sw $t5, 0($t3)

	addiu $t4, $t4, 4
	bne $t4, 396, StopDerecha
	li $t4, 0

StopDerecha:
	sw $t4, arrayPosicion		
	j EndRevisarDireccion
	
invalido:
	li $v0, 0
	j EndRevisarDireccion
	
Igual:
	li $v0, 1
	
EndRevisarDireccion:
	jr $ra

Pause:
	li $v0, 32
	syscall
	jr $ra

RevisarChoqueFruta:
	lw $t0, posicionFrutaX
	lw $t1, posicionFrutaY
	add $v0, $zero, $zero	
	beq $a0, $t0, XIgualFruta
	j EndRevisarChoqueFruta
	
XIgualFruta:
	beq $a1, $t1, YIgualFruta
	j EndRevisarChoqueFruta
YIgualFruta:
	lw $t5, puntuacion
	lw $t6, puntuacionGanancia
	add $t5, $t5, $t6
	sw $t5, puntuacion
	
	li $v0, 1
	
EndRevisarChoqueFruta:
	jr $ra
	
RevisarChoqueFinalJuego:
	add $s3, $a0, $zero
	add $s4, $a1, $zero
	sw $ra, 0($sp)

	beq  $a2, 119, RevArriba
	beq  $a2, 115, RevAbajo
	beq  $a2, 97,  RevIzquierda
	beq  $a2, 100, RevDerecha
	j TerminarRevChoque
	
RevArriba:
	addiu $a1, $a1, -1
	jal CordenadaAddress
	lw $t1, 0($v0)
	lw $t2, colorSerpiente
	lw $t3, colorBorde
	beq $t1, $t2, Salir
	beq $t1, $t3, Salir
	j TerminarRevChoque

RevAbajo:

	addiu $a1, $a1, 1
	jal CordenadaAddress
	lw $t1, 0($v0)
	lw $t2, colorSerpiente
	lw $t3, colorBorde
	beq $t1, $t2, Salir
	beq $t1, $t3, Salir
	j TerminarRevChoque

RevIzquierda:
	addiu $a0, $a0, -1
	jal CordenadaAddress
	lw $t1, 0($v0)
	lw $t2, colorSerpiente
	lw $t3, colorBorde
	beq $t1, $t2, Salir
	beq $t1, $t3, Salir
	j TerminarRevChoque

RevDerecha:
	addiu $a0, $a0, 1
	jal CordenadaAddress
	lw $t1, 0($v0)
	lw $t2, colorSerpiente
	lw $t3, colorBorde
	beq $t1, $t2, Salir
	beq $t1, $t3, Salir
	j TerminarRevChoque

TerminarRevChoque:
	lw $ra, 0($sp)
	jr $ra		

Salir:   
	li $v0, 56
	la $a0, PerdioMensaje
	lw $a1, puntuacion
	syscall
	
	li $v0, 10
	syscall