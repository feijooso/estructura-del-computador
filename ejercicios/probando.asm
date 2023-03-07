.begin
.org 2048
	ld [Y],%r10
	ld [X], %r9
	andcc %r10, %r9, %r2 
	st %r2, [Y]
	Y: 3253993472
	X: 2147483647
.end

