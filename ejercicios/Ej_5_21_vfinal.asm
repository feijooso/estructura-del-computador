	.begin
	
	.macro push Reg		! Macro para pushear al Stack
	addcc %r14, -4, %r14
	st Reg, %r14
	.endmacro
	
	.macro pop Reg		! Macro para hacer pop del stack
	ld %r14, Reg
	addcc %r14, 4, %r14
	.endmacro
	
length	.equ 120

main:
	.org 2048		! El programa empieza en la direcc. 2048
	push %r15		! Pusheo %r15 al stack ya que vengo de un proceso invocante y al hacer call en main pierdo la referencia
	add %r0, length, %r1	! %r1= lenght
	push %r1		! Pusheo al stack %r1 para pasarlo como referencia a la subrutina
	add %r0, array, %r2	! %r2= array
	push %r2		! Pusheo al stack %r2 para pasarlo como referencia a la subrutina
	call sumaPar
	pop %r3			! Pop de %r3 que tiene el valor de si es par o no
	subcc %r3, %r0, %r3	! Actualizo el %r3 para chequear los bits N,Z,V,C 
	bl ngtv			! Salta si se negativo (-1) para llenar el array con 0
	bg pstv			! Salta si es positivo (1) para llenar el array con FFFFh
	ba fin
	
pstv:	sethi FFFFh, %r4	! Setea %r4 en FFFFh y va a llenar el array
	srl %r4, 10, %r4	
	ba llenar	
	
ngtv:	orcc %r0, %r0, %r4	! Setea %r4 es 0 y va a llenar el array
	ba llenar
	
llenar:				! Recorre el array y llena con lo que hay en %r4
	add %r0, length, %r1	
	add %r0, array, %r2
loop:	andcc %r1, %r1, %r0	! Chequea elementos restantes
	be fin			! Si no hay mas elementos termina
	addcc %r1, -4, %r1	! Actualiza índice al array
	st %r4, %r1, %r2
	ba loop			! Vuelve al loop
	
fin:	pop %r15		! Pop de %r15 para luego devolver al proceso invocante
	jmpl %r15, 4, %r0

array:	0			! Cambiar los valores del array para obtener distintos resultados
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
sumaPar:			
	andcc %r6, %r0, %r6	! Pone a 0 el %r6
	andcc %r3, %r0, %r3	! Pone a 0 el %r3
	pop %r2			! %r2 = array
	pop %r1			! %r1 = length
for:	andcc %r1, %r1, %r0	! Chequea elementos restantes
	be esPar		! Si no hay mas elementos salgo
	addcc %r1, -4, %r1	! Actualiza índice al array
	ld %r1, %r2, %r5
	addcc %r3, %r5, %r3	! Suma un nuevo elemento a %r3
	bcs carry		! Si el carry es 1, (suma fuera de rango) salgo en carry
	ba for			! Vuelve al for

esPar:	orncc %r0, %r3, %r3	
	andcc %r3, 1, %r6	! %r6=1 si es par o %r6=0 si no lo es
	ba done

carry:	add %r0, -1, %r6	! %r6=-1
	ba done
	
done:	push %r6		! Pusheo %r6 que tiene si es par (1), si no lo es (0), o si hay error en carry (-1)
	jmpl %r15 + 4, %r0	! Vuelve al proceso invocante

	.end
