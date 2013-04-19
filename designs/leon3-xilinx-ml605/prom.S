
/* Template boot-code for LEON3 test benches */

#include "prom.h"

#ifndef STACKSIZE
#define STACKSIZE 0x00020000
#endif


	.seg	"text"
	.proc	0
	.align	4
	.global start
start:

	flush
	set 0x10e0, %g1		! init IU
	mov %g1, %psr
	mov %g0, %wim
	mov %g0, %tbr
	mov %g0, %y
	mov %g0, %asr16
	nop
	set  0x81000f, %g1
	sta %g1, [%g0] 2
	mov %g0, %g2
	nop
	nop
	nop
	nop
	nop
	or %g2, %g2, %g0
	nop
	nop
	nop
	nop
	nop
#ifdef DSUADDR
	set	DSUADDR, %g2
	st	%g0, [%g2]
	st	%g0, [%g2+0x08]
	st	%g0, [%g2+0x20]
	st	%g0, [%g2+0x24]
	st	%g0, [%g2+0x40]
	st	%g0, [%g2+0x44]
	st	%g0, [%g2+0x50]
	st	%g0, [%g2+0x54]
	st	%g0, [%g2+0x58]
	st	%g0, [%g2+0x5C]
	st	%g0, [%g2+0x54]
#endif

2:
	mov %asr17, %g3
	and %g3, 0x1f, %g3
	mov %g0, %g4
	mov %g0, %g5
	mov %g0, %g6
	mov %g0, %g7
1:
	mov %g0, %l0
	mov %g0, %l1
	mov %g0, %l2
	mov %g0, %l3
	mov %g0, %l4
	mov %g0, %l5
	mov %g0, %l6
	mov %g0, %l7
	mov %g0, %o0
	mov %g0, %o1
	mov %g0, %o2
	mov %g0, %o3
	mov %g0, %o4
	mov %g0, %o5
	mov %g0, %o6
	mov %g0, %o7
	subcc %g3, 1, %g3
	bge 1b
	save

	mov	2, %g1
	mov	%g1, %wim
	set 0x10e0, %g1		! enable traps
	mov %g1, %psr
	nop; nop; nop;

	mov %psr, %g1
	srl %g1, 12, %g1
	andcc %g1, 1, %g0
	be 1f
	nop

	set _fsrxx, %g3
	ld [%g3], %fsr
	ldd [%g3], %f0
	ldd [%g3], %f2
	ldd [%g3], %f4
	ldd [%g3], %f6
	ldd [%g3], %f8
	ldd [%g3], %f10
	ldd [%g3], %f12
	ldd [%g3], %f14
	ldd [%g3], %f16
	ldd [%g3], %f18
	ldd [%g3], %f20
	ldd [%g3], %f22
	ldd [%g3], %f24
	ldd [%g3], %f26
	ldd [%g3], %f28
	ldd [%g3], %f30
	nop
	nop
	nop
	nop
	nop
	faddd %f0, %f2, %f4
	nop
	nop
	nop
	nop
	ba  1f	
	nop
	
	
.align	8
_fsrxx:
	.word 0
	.word 0

1:
	mov %asr17, %g3
	srl %g3, 28, %g3
	andcc %g3, 0x0f, %g3
	bne 1f

	set L2MCTRLIO, %g1
	set MCFG1, %g2
	st  %g2, [%g1]
	set MCFG2, %g2
	st  %g2, [%g1+4]
	set MCFG3, %g2
	st  %g2, [%g1+8]
!	set IRQCTRL, %g1
!	set 0x0ffff, %g2
!	st  %g2, [%g1+0x10]

	! %g3 = cpu index
1:	set STACKSIZE, %g2
        mov %g0, %g1
2:	subcc %g3, 0, %g0
	be 3f
	nop
	add %g1, %g2, %g1
	ba 2b
	sub %g3, 1, %g3


3:	set RAMSTART+ RAMSIZE-32, %fp
	sub %fp, %g1, %fp
	sub %fp, 96, %sp

	set RAMSTART, %g1
!	st %g1, [%g1]

! SVGA
	set 0x80000600, %g3
	st  %g1, [%g3 + 0x14]
	set (1023 << 16) | 767, %g2
	st  %g2, [%g3 + 0x04]
	set 0x000A000A, %g2
	st  %g2, [%g3 + 0x08]
	st  %g2, [%g3 + 0x0C]
	set (1043 << 16) | 787, %g2
	st  %g2, [%g3 + 0x04]
	set 0x21, %g2
	st  %g2, [%g3 + 0x00]


! DDR3 test
	set 64, %g2
4:
	subcc %g2, 1, %g2
	bge,a 4b
	stb %g2, [%g1+%g2]

	set 64, %g2
5:
	subcc %g2, 1, %g2
	bge,a 5b
	ldub [%g1+%g2], %g3

	add %g1, 64, %g1
	set 64, %g2
4:
	subcc %g2, 2, %g2
	bge,a 4b
	sth %g2, [%g1+%g2]

	set 64, %g2
5:
	subcc %g2, 2, %g2
	bge,a 5b
	lduh [%g1+%g2], %g3

	add %g1, 64, %g1
	set 64, %g2
4:
	subcc %g2, 4, %g2
	bge,a 4b
	st %g2, [%g1+%g2]

	set 64, %g2
5:
	subcc %g2, 4, %g2
	bge,a 5b
	ld [%g1+%g2], %g3

	add %g1, 64, %g1
	set 64, %g2
4:
	subcc %g2, 8, %g2
	bge,a 4b
	std %g2, [%g1+%g2]

	set 64, %g2
5:
	subcc %g2, 8, %g2
	bge,a 5b
	ldd [%g1+%g2], %g4

	ba 3b
	nop

	ld [%g1], %g2
	ldd [%g1], %g2
	ldd [%g1+0x10], %g2
	add %g1, 0x20, %g1
	ba  4b
	nop
	jmp %g1
	nop

.align	32
