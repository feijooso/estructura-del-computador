
        .begin
        .org 2048
begin:  addcc %r14, -4, %r14
        st %r15, %r14
        ld [X], %r1
        ld [Y], %r2
        addcc %r14, -4, %r14
        st %r1, %r14
        addcc %r14, -4, %r14
        st %r2, %r14
        call mult
        ld %r14, %r3
        addcc %r14, 4, %r14
        st %r3, [Z]
        ld %r14, %r4
        addcc %r14, 4, %r14
        jmpl %r4+4, %r0
!Se leen 2 argumentos del stack
!Se usa:%r4 para el primer numero 
!       %r5 para el segundo (No lo mantiene)
!       %r6 para el resultado
mult:   ld %r14, %r4
        addcc %r14, 4, %r14
        ld %r14, %r5
        addcc %r14, 4, %r14
        andcc %r6, %r0, %r6
for:    andcc %r5,%r5, %r0
        be done
        addcc %r6,%r4, %r6
        bvs fallo
        addcc %r5, -1, %r5
        ba for
done:   addcc %r14, -4, %r14
        st %r6, %r14
        jmpl %r15+4, %r0
fallo:  ld [Fl], %r6                    
        addcc %r14, -4, %r14
        st %r6, %r14
        jmpl %r15+4, %r0
X: 5
Y: 4
Z: 0
Fl: -1
.end
