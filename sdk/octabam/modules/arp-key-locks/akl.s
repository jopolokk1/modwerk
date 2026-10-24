#NO_APP
	.file	"akl.c"
	.text
	.align	2
	.globl	akl_snap
	.type	akl_snap, @function
akl_snap:
	subq.l #4,%sp
	move.l %d3,-(%sp)
	move.l %d2,-(%sp)
	moveq #83,%d2
	move.l 20(%sp),%d1
	subq.l #1,%d1
	move.l 16(%sp),%d0
	cmp.l %d1,%d2
	jcs .L1
	tst.l %d0
	jlt .L1
	mov3q.l #7,%d3
	remu.l %d3,%d2:%d1
	divu.l %d3,%d1
	move.l %d0,%a0
	moveq #12,%d3
	lea (12,%a0),%a0
	lea modes,%a1
	sub.l %d1,%a0
	move.l %d2,8(%sp)
	move.l %a0,%d1
	remu.l %d3,%d2:%d1
	move.l 8(%sp),%d3
	mvz.w (%a1,%d3.l*2),%d1
	btst %d2,%d1
	jne .L1
	subq.l #1,%d0
.L1:
	move.l (%sp)+,%d2
	move.l (%sp)+,%d3
	addq.l #4,%sp
	rts
	.size	akl_snap, .-akl_snap
	.align	2
	.globl	akl_key
	.type	akl_key, @function
akl_key:
	lea (-20,%sp),%sp
	mov3q.l #7,%d0
	movem.l #1052,(%sp)
	move.l 24(%sp),%d3
	cmp.l %d3,%d0
	jcs .L8
	move.b -2147457603,%d0
	move.b -2147457602,%d2
	move.l %d3,%a0
	add.l #-2147457832,%a0
	move.b (%a0),%d4
	move.l %d0,%d1
	or.l %d2,%d1
	move.w %d4,%a2
	moveq #15,%d4
	mvz.b %d1,%d1
	cmp.l %d1,%d4
	jcs .L8
	move.w %a2,%d4
	mvz.b %d0,%d0
	mvz.b gen,%d1
	mvz.b %d2,%d2
	mvz.b %d4,%d4
	move.l %d4,%a2
	move.l %d0,%d4
	swap %d4
	clr.w %d4
	move.l %d4,%a1
	moveq #24,%d4
	lsl.l %d4,%d1
	move.l %d2,%d4
	lsl.l #8,%d4
	move.l %d4,%a0
	move.l %a1,%d4
	or.l %d4,%d1
	move.l %a0,%d4
	lea cache_for,%a0
	or.l %d4,%d1
	move.l %a2,%d4
	or.l %d1,%d4
	move.l %d4,16(%sp)
	cmp.l (%a0,%d3.l*4),%d4
	jne .L11
	lea cache_key,%a0
	mvz.b (%a0,%d3.l),%d0
	movem.l (%sp),#1052
	lea (20,%sp),%sp
	rts
.L11:
	move.l #635712,%d1
	muls.l %d1,%d0
	mvz.w #2224,%d1
	mulu.w #36568,%d2
	muls.l %d3,%d1
	add.l %d2,%d0
	move.l %d0,%d2
	add.l #1074668000,%d2
	move.l %d0,%a0
	add.l #1074704437,%a0
	add.l %d1,%d2
	tst.b (%a0)
	jeq .L12
	move.l %d2,%a0
	move.b 18680(%a0),%d0
	mvz.b %d0,%d1
	tst.b %d0
	jeq .L18
.L22:
	move.l %d1,%a0
	moveq #64,%d0
	cmp.l %d1,%d0
	jcc .L15
	move.w #64,%a0
.L15:
	move.l %a2,%d0
	move.l %a0,%d4
	remu.l %d4,%d1:%d0
	move.l %d2,%a2
	lea (18718,%a2),%a2
	add.l %a0,%d1
	move.l %d1,%a1
	sub.l %a0,%a1
.L17:
	move.l %d1,%d2
	move.l %a0,%d4
	remu.l %d4,%d0:%d2
	subq.l #1,%d1
	moveq #84,%d4
	lsl.l #5,%d0
	move.b (%a2,%d0.l),%d2
	mvz.b %d2,%d0
	cmp.l %d0,%d4
	jcc .L16
	cmp.l %d1,%a1
	jne .L17
	st %d2
	mvz.w #255,%d0
.L16:
	lea cache_key,%a0
	move.b %d2,(%a0,%d3.l)
	move.l 16(%sp),%d1
	lea cache_for,%a0
	move.l %d1,(%a0,%d3.l*4)
	movem.l (%sp),#1052
	lea (20,%sp),%sp
	rts
.L8:
	movem.l (%sp),#1052
	mvz.w #255,%d0
	lea (20,%sp),%sp
	rts
.L12:
	add.l #1074704433,%d0
	move.l %d0,%a0
	move.b (%a0),%d0
	mvz.b %d0,%d1
	tst.b %d0
	jne .L22
.L18:
	mov3q.l #1,%d1
	mov3q.l #1,%a0
	move.l %d2,%a2
	move.l %d1,%a1
	lea (18718,%a2),%a2
	sub.l %a0,%a1
	jra .L17
	.size	akl_key, .-akl_key
	.align	2
	.globl	akl_claims
	.type	akl_claims, @function
akl_claims:
	move.l 4(%sp),-(%sp)
	jsr akl_key
	addq.l #4,%sp
	cmp.l #255,%d0
	sne %d0
	mvs.b %d0,%d0
	neg.l %d0
	rts
	.size	akl_claims, .-akl_claims
	.align	2
	.globl	akl_note
	.type	akl_note, @function
akl_note:
	subq.l #4,%sp
	move.l %d3,-(%sp)
	move.l %d2,-(%sp)
	move.l 16(%sp),-(%sp)
	jsr akl_key
	addq.l #4,%sp
	cmp.l #255,%d0
	jeq .L31
	move.l 20(%sp),%a0
	tst.b (%a0)
	jlt .L27
	move.b (%a0),%d1
	subq.l #1,%d0
	moveq #83,%d2
	cmp.l %d0,%d2
	jcs .L30
	mvs.b %d1,%d3
	move.l %d3,%a0
	tst.b %d1
	jmi .L30
	mov3q.l #7,%d2
	remu.l %d2,%d3:%d0
	divu.l %d2,%d0
	lea (12,%a0),%a0
	moveq #12,%d2
	lea modes,%a1
	sub.l %d0,%a0
	move.l %d3,8(%sp)
	move.l %a0,%d0
	remu.l %d2,%d3:%d0
	move.l 8(%sp),%d2
	mvz.w (%a1,%d2.l*2),%d0
	btst %d3,%d0
	jne .L30
	subq.l #1,%d1
.L30:
	move.l 20(%sp),%a0
	move.b %d1,(%a0)
.L27:
	move.l (%sp)+,%d2
	mov3q.l #1,%d0
	move.l (%sp)+,%d3
	addq.l #4,%sp
	rts
.L31:
	move.l (%sp)+,%d2
	clr.l %d0
	move.l (%sp)+,%d3
	addq.l #4,%sp
	rts
	.size	akl_note, .-akl_note
	.align	2
	.globl	akl_knob
	.type	akl_knob, @function
akl_knob:
	lea (-36,%sp),%sp
	movem.l #3084,(%sp)
	move.b 1175456536,%d0
	mvz.b 1175456537,%d1
	move.b 269161676,%d2
	move.b 269161680,%d3
	move.l 1187521622,%a1
	lsl.l #8,%d1
	move.l %a1,20(%sp)
	mvz.b %d0,%d0
	move.w %d2,%a0
	move.w %d3,%a2
	or.l %d0,%d1
	move.l %d1,%a1
	tst.l %d1
	jeq .L34
	mvz.b %d2,%d0
	mov3q.l #7,%d1
	cmp.l %d0,%d1
	jcs .L34
	mvz.b %d3,%d0
	moveq #15,%d2
	cmp.l %d0,%d2
	jcs .L34
	move.l 20(%sp),%d0
	add.l #-1074668000,%d0
	cmp.l #9535680,%d0
	jhi .L34
	move.w %a0,%d0
	move.w %a2,%d1
	move.b 269161679,%d3
	move.l 20(%sp),%a0
	add.l #586355,%a0
	ext.w %d0
	ext.w %d1
	move.w %d0,%d2
	mulu.w #36568,%d1
	mulu.w #2224,%d0
	mulu.w #36,%d2
	move.l %d2,24(%sp)
	add.l 24(%sp),%a0
	mov3q.l #3,%d2
	and.l %d2,%d3
	move.l %a0,16(%sp)
	move.l 20(%sp),%a0
	move.l 16(%sp),%a3
	lea (18640,%a0),%a0
	add.l %d1,%a0
	add.l %d0,%a0
	add.l %d0,%d1
	mvz.w #6322,%d0
	muls.l %d0,%d3
	mvz.b (%a3,%d3.l),%d0
	move.l %d0,%d2
	subq.l #1,%d2
	move.l %d2,28(%sp)
	btst #0,%d0
	jne .L36
	move.l 28(%sp),%d0
	lsr.l #1,%d0
	lea (78,%a0),%a0
	mov3q.l #5,%a2
	move.l %a0,16(%sp)
	move.l %d1,%a3
	add.l #268544620,%a3
	mulu.w #7,%d0
	move.l %a3,24(%sp)
	clr.l %d1
	lea 1(%a2,%d0.l),%a0
	add.l 40(%sp),%a0
	move.l %a0,32(%sp)
.L43:
	move.l %a1,%d0
	btst %d1,%d0
	jeq .L38
	move.l 1175264772,%d0
	moveq #63,%d2
	move.l 16(%sp),%a2
	lsl.l #4,%d0
	add.l %d1,%d0
	and.l %d2,%d0
	moveq #84,%d2
	lsl.l #5,%d0
	add.l %d0,%a2
	mvz.b (%a2),%d3
	move.l %d3,%a0
	cmp.l %d3,%d2
	jcc .L39
	moveq #23,%d3
	cmp.l 28(%sp),%d3
	jcs .L45
	move.l 32(%sp),%a0
.L40:
	tst.l %a0
	jlt .L46
.L57:
	moveq #84,%d2
	cmp.l %a0,%d2
	jge .L41
	move.w #84,%a0
.L41:
	move.w %a0,%d3
	move.b %d3,(%a2)
	move.l 24(%sp),%a2
	move.b %d3,(%a2,%d0.l)
.L38:
	addq.l #1,%d1
	moveq #16,%d0
	cmp.l %d1,%d0
	jne .L43
	move.b gen,%d0
	mvz.b %d0,%d1
	cmp.l #255,%d1
	jeq .L47
	addq.l #1,%d0
	move.b %d0,gen
	move.l 20(%sp),%a0
	add.l #635698,%a0
	mov3q.l #1,(%a0)
	mov3q.l #1,269452696
	jsr 1073905152
	jsr 1074240840
	move.l 40(%sp),-(%sp)
	clr.l -(%sp)
	jsr 1074260376
	addq.l #8,%sp
.L34:
	movem.l (%sp),#3084
	lea (36,%sp),%sp
	rts
.L39:
	add.l 40(%sp),%a0
	tst.l %a0
	jge .L57
.L46:
	move.w #255,%a0
	move.w %a0,%d3
	move.b %d3,(%a2)
	move.l 24(%sp),%a2
	move.b %d3,(%a2,%d0.l)
	jra .L38
.L45:
	move.l 40(%sp),%a0
	jra .L40
.L36:
	move.l 28(%sp),%d0
	lsr.l #1,%d0
	lea (78,%a0),%a0
	sub.l %a2,%a2
	move.l %a0,16(%sp)
	move.l %d1,%a3
	add.l #268544620,%a3
	mulu.w #7,%d0
	move.l %a3,24(%sp)
	clr.l %d1
	lea 1(%a2,%d0.l),%a0
	add.l 40(%sp),%a0
	move.l %a0,32(%sp)
	jra .L43
.L47:
	moveq #1,%d0
	move.l 20(%sp),%a0
	add.l #635698,%a0
	mov3q.l #1,(%a0)
	move.b %d0,gen
	mov3q.l #1,269452696
	jsr 1073905152
	jsr 1074240840
	move.l 40(%sp),-(%sp)
	clr.l -(%sp)
	jsr 1074260376
	addq.l #8,%sp
	jra .L34
	.size	akl_knob, .-akl_knob
	.align	2
	.globl	akl_text_claims
	.type	akl_text_claims, @function
akl_text_claims:
	mov3q.l #5,%d0
	cmp.l 4(%sp),%d0
	jeq .L59
.L61:
	clr.l %d0
	rts
.L59:
	tst.l -2147483630
	jeq .L61
	move.b 1175456536,%d1
	mvz.b 1175456537,%d0
	lsl.l #8,%d0
	mvz.b %d1,%d1
	or.l %d1,%d0
	sne %d0
	mvs.b %d0,%d0
	neg.l %d0
	rts
	.size	akl_text_claims, .-akl_text_claims
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"OFF"
	.text
	.align	2
	.globl	akl_key_text
	.type	akl_key_text, @function
akl_key_text:
	lea (-12,%sp),%sp
	move.l %d3,-(%sp)
	move.l %d2,-(%sp)
	move.b 1175456536,%d1
	mvz.b 1175456537,%d0
	move.b 269161676,%d2
	lsl.l #8,%d0
	move.l 24(%sp),%a0
	mvz.b %d1,%d1
	move.b %d2,12(%sp)
	or.l %d1,%d0
	move.b 269161680,%d3
	move.l 1187521622,%a1
	clr.b (%a0)
	move.b %d3,8(%sp)
	tst.l %d0
	jeq .L68
	mvz.b %d2,%d1
	mov3q.l #7,%d2
	cmp.l %d1,%d2
	jcs .L68
	mvz.b %d3,%d1
	moveq #15,%d3
	cmp.l %d1,%d3
	jcs .L68
	move.l %a1,%d1
	add.l #-1074668000,%d1
	cmp.l #9535680,%d1
	jhi .L68
	mov3q.l #1,%d1
	and.l %d0,%d1
	btst #0,%d0
	jne .L92
.L69:
	addq.l #1,%d1
	btst %d1,%d0
	jeq .L69
.L70:
	move.l 1175264772,%d2
	move.b 8(%sp),%d3
	move.b 12(%sp),%d0
	lsl.l #4,%d2
	lea (18718,%a1),%a1
	ext.w %d3
	ext.w %d0
	move.l %d2,16(%sp)
	move.w %d3,%d2
	mulu.w #2224,%d0
	moveq #63,%d3
	mulu.w #36568,%d2
	add.l %d2,%a1
	add.l %d0,%a1
	move.l 16(%sp),%d0
	add.l %d1,%d0
	and.l %d3,%d0
	lsl.l #5,%d0
	mvz.b (%a1,%d0.l),%d1
	moveq #84,%d0
	cmp.l %d1,%d0
	jcc .L72
	moveq #45,%d1
	clr.b %d2
	move.b %d1,5(%a0)
	move.b %d1,6(%a0)
	move.b %d2,7(%a0)
.L67:
	move.l (%sp)+,%d2
	move.l (%sp)+,%d3
	lea (12,%sp),%sp
	rts
.L68:
	moveq #45,%d0
	clr.b %d1
	move.b %d0,5(%a0)
	move.b %d0,6(%a0)
	move.b %d1,7(%a0)
	move.l (%sp)+,%d2
	move.l (%sp)+,%d3
	lea (12,%sp),%sp
	rts
.L72:
	move.l %a0,%d0
	addq.l #5,%d0
	tst.l %d1
	jne .L73
	move.l %a0,%d1
	add.l #9,%d1
	lea .LC0,%a1
.L74:
	move.l %d0,%a0
	addq.l #1,%d0
	move.b (%a1)+,(%a0)
	cmp.l %d0,%d1
	jeq .L67
	move.l %d0,%a0
	addq.l #1,%d0
	move.b (%a1)+,(%a0)
	cmp.l %d0,%d1
	jne .L74
	jra .L67
.L73:
	subq.l #1,%d1
	move.l %d1,12(%sp)
	move.l %d1,%d3
	mov3q.l #7,%d2
	remu.l %d2,%d1:%d3
	lsl.l #2,%d1
	move.l %d1,%a1
	add.l #names,%a1
	move.l %a1,8(%sp)
.L75:
	move.l 8(%sp),%a1
	addq.l #1,%a0
	addq.l #1,8(%sp)
	move.b (%a1)+,%d1
	move.b %d1,-1(%a0)
	jne .L75
	move.l 12(%sp),%d1
	mov3q.l #7,%d2
	divu.l %d2,%d1
	mulu.w #3,%d1
	move.l %d1,%a0
	add.l #roots,%a0
.L76:
	move.b (%a0)+,%d1
	move.l %d0,%a1
	addq.l #1,%d0
	move.b %d1,(%a1)
	jeq .L67
	move.b (%a0)+,%d1
	move.l %d0,%a1
	addq.l #1,%d0
	move.b %d1,(%a1)
	jne .L76
	jra .L67
.L92:
	clr.l %d1
	jra .L70
	.size	akl_key_text, .-akl_key_text
	.align	2
	.globl	akl_knob_claims
	.type	akl_knob_claims, @function
akl_knob_claims:
	tst.l -2147483630
	jeq .L95
	move.b 1175456536,%d1
	mvz.b 1175456537,%d0
	lsl.l #8,%d0
	mvz.b %d1,%d1
	or.l %d1,%d0
	sne %d0
	mvs.b %d0,%d0
	neg.l %d0
	rts
.L95:
	clr.l %d0
	rts
	.size	akl_knob_claims, .-akl_knob_claims
	.section	.rodata
	.type	roots, @object
	.size	roots, 36
roots:
	.string	"C"
	.zero	1
	.string	"C#"
	.string	"D"
	.zero	1
	.string	"D#"
	.string	"E"
	.zero	1
	.string	"F"
	.zero	1
	.string	"F#"
	.string	"G"
	.zero	1
	.string	"G#"
	.string	"A"
	.zero	1
	.string	"A#"
	.string	"B"
	.zero	1
	.type	names, @object
	.size	names, 28
names:
	.string	"MAJ"
	.string	"DOR"
	.string	"PHR"
	.string	"LYD"
	.string	"MIX"
	.string	"MIN"
	.string	"LOC"
	.data
	.type	gen, @object
	.size	gen, 1
gen:
	.byte	1
	.local	cache_key
	.comm	cache_key,8,1
	.local	cache_for
	.comm	cache_for,32,2
	.section	.rodata
	.align	2
	.type	modes, @object
	.size	modes, 14
modes:
	.word	2741
	.word	1709
	.word	1451
	.word	2773
	.word	1717
	.word	1453
	.word	1387
	.ident	"GCC: (GNU) 16.2.0"
