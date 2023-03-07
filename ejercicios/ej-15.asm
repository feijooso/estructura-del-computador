.begin !calcular el modulo de un float
.org 2048
	ld [Y],%r10 ! cargo y en r10
	ld [X], %r9 !cargo x en r9
	andcc %r10, %r9, %r2 !and logico bit a bit entre r10 y r10 que se guarda en r2
	st %r2, [Y] ! guardo el float positivo en r2
	Y: 3253993472 !el decimal que en binario interpretado como float es el -30,5 
	X: 2147483647 !la mascara 0111111....
.end

