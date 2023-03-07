.begin
.org 2048
	ld [X], %r1
	ld [Y], %r2
	subcc %r1, %r2, %r3
	bg label
	jmpl %r15+4, %r0
label:	add %r0, %r0, %r3
	X: -30,4
	Y: 40
.end
