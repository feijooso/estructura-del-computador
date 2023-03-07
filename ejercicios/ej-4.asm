.begin
.org 2048
	ld [X], %r1
	ld [Y], %r2
	st %r2, [X]
	st %r1, [Y]
	X: 30
	Y: 20
.end