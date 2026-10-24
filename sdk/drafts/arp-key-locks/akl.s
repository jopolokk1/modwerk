#NO_APP
	.file	"akl.c"
	.text
	.align	2
	.type	track_trigs, @function
track_trigs:
	move.l %d2,-(%sp)
	move.b 1175456536,%d0
	mvz.b 1175456537,%d1
	lsl.l #8,%d1
	mvz.b %d0,%d0
	or.l %d0,%d1
	jne .L2
	mov3q.l #-1,order_note
	mov3q.l #-1,order_step
	clr.l show_shift
.L3:
	move.l (%sp)+,%d2
	move.l %d1,order_prev
	rts
.L2:
	move.l order_step,%d0
	tst.l %d0
	jlt .L7
	btst %d0,%d1
	jne .L3
.L7:
	move.l order_prev,%d2
	not.l %d2
	and.l %d1,%d2
	tst.l %d2
	jeq .L18
	clr.l %d0
	btst #0,%d2
	jne .L8
.L9:
	addq.l #1,%d0
	btst %d0,%d2
	jeq .L9
.L8:
	move.l (%sp)+,%d2
	move.l %d0,order_step
	mov3q.l #-1,order_note
	clr.l show_shift
	move.l %d1,order_prev
	rts
.L18:
	move.l %d1,%d2
	clr.l %d0
	btst #0,%d2
	jeq .L9
	jra .L8
	.size	track_trigs, .-track_trigs
	.align	2
	.type	shift_now, @function
shift_now:
	move.l %a2,-(%sp)
	move.l %d2,-(%sp)
	move.l 12(%sp),%d1
	lea cache_shift,%a0
	move.b (%a0,%d1.l),%d0
	mvz.b %d0,%d2
	move.l %d2,%a1
	cmp.l #255,%d2
	jeq .L29
	moveq #15,%d2
	and.l %d2,%d0
	tst.b %d0
	jeq .L29
	move.l %d1,%d0
	lsl.l #5,%d0
	move.l %d0,%a0
	add.l #1187475438,%a0
	tst.b (%a0)
	jeq .L29
	moveq #10,%d0
	moveq #68,%d2
	muls.l %d1,%d0
	muls.l %d2,%d1
	add.l #1187478295,%d0
	move.l %d0,%a2
	move.l %d1,%a0
	move.b (%a2),%d0
	add.l #1187474926,%a0
	mvz.b (%a0),%d1
	addq.l #1,%d1
	mvz.b %d0,%d0
	remu.l %d1,%d2:%d0
	move.l %a1,%d0
	lsr.l #4,%d0
	cmp.l %d2,%d0
	jeq .L19
.L29:
	move.w #255,%a1
.L19:
	move.l (%sp)+,%d2
	move.l %a1,%d0
	move.l (%sp)+,%a2
	rts
	.size	shift_now, .-shift_now
	.align	2
	.type	shift_at, @function
shift_at:
	subq.l #8,%sp
	move.l %d2,-(%sp)
	move.b 269161676,%d0
	move.b 269161680,%d2
	move.l order_step,%d1
	move.w %d0,%a0
	move.b %d2,7(%sp)
	move.l 1187521622,%d0
	tst.l %d1
	jlt .L35
	move.w %a0,%d2
	mvz.b %d2,%d2
	move.l %d2,%a1
	mov3q.l #7,%d2
	cmp.l %a1,%d2
	jcs .L35
	mvz.b 7(%sp),%d2
	move.l %d2,%a1
	moveq #15,%d2
	cmp.l %a1,%d2
	jcs .L35
	move.l %d0,%a1
	add.l #-1074668000,%a1
	cmp.l #9535680,%a1
	jhi .L35
	move.l 1175264772,%d2
	add.l #18719,%d0
	move.l %d2,8(%sp)
	move.b 7(%sp),%d2
	ext.w %d2
	move.w %d2,%a1
	move.w %a0,%d2
	ext.w %d2
	move.w %d2,%a0
	move.l 8(%sp),%d2
	lsl.l #4,%d2
	move.l %d2,8(%sp)
	move.w %a1,%d2
	add.l 8(%sp),%d1
	mulu.w #36568,%d2
	move.l %d2,%a1
	add.l %a1,%d0
	move.w %a0,%d2
	mulu.w #2224,%d2
	add.l %d2,%d0
	moveq #63,%d2
	and.l %d2,%d1
	move.l (%sp)+,%d2
	lsl.l #5,%d1
	add.l %d1,%d0
	addq.l #8,%sp
	rts
.L35:
	move.l (%sp)+,%d2
	clr.l %d0
	addq.l #8,%sp
	rts
	.size	shift_at, .-shift_at
	.align	2
	.type	after_edit.constprop.0, @function
after_edit.constprop.0:
	move.b gen,%d0
	mvz.b %d0,%d1
	cmp.l #255,%d1
	jeq .L40
	addq.l #1,%d0
	move.b %d0,gen
	move.l 1187521622,%a0
	add.l #635698,%a0
	mov3q.l #1,(%a0)
	mov3q.l #1,269452696
	jsr 1073905152
	jsr 1074240840
	move.l 4(%sp),-(%sp)
	clr.l -(%sp)
	jsr 1074260376
	addq.l #8,%sp
	rts
.L40:
	moveq #1,%d0
	move.b %d0,gen
	move.l 1187521622,%a0
	add.l #635698,%a0
	mov3q.l #1,(%a0)
	mov3q.l #1,269452696
	jsr 1073905152
	jsr 1074240840
	move.l 4(%sp),-(%sp)
	clr.l -(%sp)
	jsr 1074260376
	addq.l #8,%sp
	rts
	.size	after_edit.constprop.0, .-after_edit.constprop.0
	.align	2
	.type	pick_note, @function
pick_note:
	subq.l #8,%sp
	move.l %d2,-(%sp)
	move.b 269161676,%d0
	move.l order_note,%a0
	move.b %d0,4(%sp)
	move.l order_step,%d0
	move.b 269161680,%d1
	move.b %d1,7(%sp)
	move.l 1187521622,%d1
	tst.l %d0
	jlt .L45
	mvz.b 4(%sp),%d2
	move.l %d2,%a1
	mov3q.l #7,%d2
	cmp.l %a1,%d2
	jcs .L45
	mvz.b 7(%sp),%d2
	move.l %d2,%a1
	moveq #15,%d2
	cmp.l %a1,%d2
	jcs .L46
	cmp.l #1074667999,%d1
	jls .L47
	cmp.l #1084203680,%d1
	jhi .L45
	move.l 1175264772,%d2
	move.l %d2,8(%sp)
	mov3q.l #-1,%d2
	cmp.l %a0,%d2
	jeq .L70
.L43:
	move.l (%sp)+,%d2
	addq.l #8,%sp
	rts
.L45:
	mov3q.l #-1,%d0
	cmp.l %a0,%d0
	jne .L43
.L50:
	clr.l %d0
	move.l %d0,order_note
.L71:
	move.l (%sp)+,%d2
	addq.l #8,%sp
	rts
.L70:
	move.l 8(%sp),%d2
	move.l %d1,%a0
	lea (18719,%a0),%a0
	lsl.l #4,%d2
	move.l %d2,8(%sp)
	move.b 7(%sp),%d2
	add.l 8(%sp),%d0
	ext.w %d2
	move.w %d2,%a1
	move.b 4(%sp),%d2
	move.w %a1,%d1
	ext.w %d2
	mulu.w #36568,%d1
	move.l %d1,%a1
	add.l %a1,%a0
	move.w %d2,%d1
	moveq #63,%d2
	and.l %d2,%d0
	mulu.w #2224,%d1
	lsl.l #5,%d0
	add.l %d1,%a0
	add.l %d0,%a0
	mvz.b (%a0),%d0
	cmp.l #255,%d0
	jeq .L50
	mvz.b (%a0),%d0
	lsr.l #4,%d0
	move.l %d0,order_note
	jra .L71
.L46:
	mov3q.l #-1,%d2
	cmp.l %a0,%d2
	jeq .L50
	move.l (%sp)+,%d2
	addq.l #8,%sp
	rts
.L47:
	mov3q.l #-1,%d1
	cmp.l %a0,%d1
	jeq .L50
	move.l (%sp)+,%d2
	addq.l #8,%sp
	rts
	.size	pick_note, .-pick_note
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
	jcs .L72
	tst.l %d0
	jlt .L72
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
	jne .L72
	subq.l #1,%d0
.L72:
	move.l (%sp)+,%d2
	move.l (%sp)+,%d3
	addq.l #4,%sp
	rts
	.size	akl_snap, .-akl_snap
	.align	2
	.globl	akl_key
	.type	akl_key, @function
akl_key:
	lea (-40,%sp),%sp
	mov3q.l #7,%d0
	movem.l #3196,(%sp)
	move.l 44(%sp),%d3
	cmp.l %d3,%d0
	jcs .L79
	move.b -2147457603,%d0
	move.b -2147457602,%d2
	move.l %d3,%a0
	add.l #-2147457816,%a0
	move.b (%a0),%d4
	moveq #15,%d5
	move.l %d0,%d1
	or.l %d2,%d1
	mvz.b %d1,%d1
	cmp.l %d1,%d5
	jcs .L79
	mvz.b %d0,%d0
	mvz.b gen,%d1
	moveq #24,%d5
	mvz.b %d2,%d2
	move.l %d0,%d6
	lsl.l %d5,%d1
	swap %d6
	clr.w %d6
	move.l %d2,%d5
	lsl.l #8,%d5
	mvz.b %d4,%d4
	lea cache_for,%a0
	or.l %d6,%d1
	or.l %d5,%d1
	or.l %d4,%d1
	move.l %d1,36(%sp)
	cmp.l (%a0,%d3.l*4),%d1
	jne .L82
	lea cache_key,%a0
	mvz.b (%a0,%d3.l),%d2
	move.l %d2,%d0
	movem.l (%sp),#3196
	lea (40,%sp),%sp
	rts
.L82:
	move.l #635712,%d1
	muls.l %d1,%d0
	mvz.w #2224,%d1
	mulu.w #36568,%d2
	muls.l %d3,%d1
	add.l %d2,%d0
	move.l %d0,%a2
	add.l #1074668000,%a2
	move.l %d0,%a0
	add.l #1074704437,%a0
	add.l %d1,%a2
	tst.b (%a0)
	jeq .L83
	move.b 18680(%a2),%d0
	mvz.b %d0,%d1
	tst.b %d0
	jeq .L93
.L100:
	move.l %d1,%a1
	moveq #64,%d0
	cmp.l %d1,%d0
	jcc .L86
	move.w #64,%a1
.L86:
	move.l %a1,%d5
	remu.l %d5,%d1:%d4
	lea (-1,%a1),%a0
	mvz.w %a0,%d0
	move.l %a2,%d5
	add.l #18718,%d5
	move.l %a0,32(%sp)
	move.l %d5,%a3
	move.l %d5,%a0
	lsl.l #5,%d0
	move.l %d1,%d2
	lsl.l #5,%d2
	add.l %d0,%a3
	move.l %a1,%d0
	add.l %d2,%a0
.L89:
	move.b (%a0),%d4
	moveq #84,%d6
	mvz.b %d4,%d2
	cmp.l %d2,%d6
	jcc .L87
	cmp.l %d5,%a0
	jeq .L94
	lea (-32,%a0),%a0
	subq.l #1,%d0
	tst.l %d0
	jne .L89
.L101:
	st %d4
	mvz.w #255,%d2
.L87:
	lea cache_key,%a0
	move.b %d4,(%a0,%d3.l)
	lea (18719,%a2),%a3
	lea (18647,%a2),%a2
	move.l %a2,28(%sp)
.L92:
	move.l %d1,%d0
	lsr.l #3,%d0
	move.l 28(%sp),%a2
	mov3q.l #7,%d5
	and.l %d1,%d5
	sub.l %d0,%a2
	move.l %d1,%d0
	lsl.l #5,%d0
	move.l %d0,%a0
	move.b (%a0,%a3.l),%d0
	mvz.b %d0,%d4
	cmp.l #255,%d4
	jne .L90
	mvz.b (%a2),%d4
	btst %d5,%d4
	jne .L90
	tst.l %d1
	jeq .L95
	subq.l #1,%d1
	subq.l #1,%a1
	tst.l %a1
	jne .L92
.L90:
	lea cache_shift,%a0
	move.b %d0,(%a0,%d3.l)
	move.l 36(%sp),%d1
	move.l %d2,%d0
	lea cache_for,%a0
	move.l %d1,(%a0,%d3.l*4)
	movem.l (%sp),#3196
	lea (40,%sp),%sp
	rts
.L79:
	mvz.w #255,%d2
	move.l %d2,%d0
	movem.l (%sp),#3196
	lea (40,%sp),%sp
	rts
.L83:
	add.l #1074704433,%d0
	move.l %d0,%a0
	move.b (%a0),%d0
	mvz.b %d0,%d1
	tst.b %d0
	jne .L100
.L93:
	clr.l %d0
	move.l %a2,%d5
	add.l #18718,%d5
	clr.l %d2
	mov3q.l #1,%a1
	move.l %d5,%a3
	add.l %d0,%a3
	move.l %d5,%a0
	move.l %a1,%d0
	clr.l 32(%sp)
	add.l %d2,%a0
	jra .L89
.L95:
	move.l 32(%sp),%d1
	subq.l #1,%a1
	tst.l %a1
	jne .L92
	jra .L90
.L94:
	move.l %a3,%a0
	subq.l #1,%d0
	tst.l %d0
	jne .L89
	jra .L101
	.size	akl_key, .-akl_key
	.align	2
	.globl	akl_move
	.type	akl_move, @function
akl_move:
	lea (-24,%sp),%sp
	moveq #83,%d1
	movem.l #252,(%sp)
	move.l 32(%sp),%d4
	subq.l #1,%d4
	move.l 28(%sp),%d0
	move.l 36(%sp),%d5
	cmp.l %d4,%d1
	jcs .L104
	tst.l %d0
	jlt .L104
	move.l %d4,%d2
	mov3q.l #7,%d6
	remu.l %d6,%d3:%d2
	divu.l %d6,%d2
	move.l %d0,%d1
	add.l #12,%d1
	moveq #12,%d7
	lea modes,%a0
	sub.l %d2,%d1
	remu.l %d7,%d2:%d1
	mvz.w (%a0,%d3.l*2),%d1
	btst %d2,%d1
	jeq .L144
.L104:
	tst.l %d5
	jle .L141
	move.l %d4,%d1
	mov3q.l #7,%d2
	remu.l %d2,%d6:%d1
	divu.l %d2,%d1
	move.w #12,%a0
	lea modes,%a1
	sub.l %d1,%a0
.L113:
	moveq #126,%d7
	cmp.l %d0,%d7
	jlt .L102
	addq.l #1,%d0
	moveq #83,%d1
	cmp.l %d4,%d1
	jcs .L105
.L108:
	tst.l %d0
	jlt .L145
	move.l %d0,%d1
	moveq #12,%d7
	add.l %a0,%d1
	remu.l %d7,%d2:%d1
	mvz.w (%a1,%d6.l*2),%d3
	btst %d2,%d3
	jne .L105
.L146:
	moveq #127,%d1
	cmp.l %d0,%d1
	jeq .L105
	addq.l #1,%d0
	move.l %d0,%d1
	moveq #12,%d7
	add.l %a0,%d1
	remu.l %d7,%d2:%d1
	btst %d2,%d3
	jeq .L146
.L105:
	subq.l #1,%d5
	tst.l %d5
	jne .L113
.L102:
	movem.l (%sp),#252
	lea (24,%sp),%sp
	rts
.L145:
	subq.l #1,%d5
	tst.l %d5
	jeq .L102
	addq.l #1,%d0
	jra .L108
.L141:
	tst.l %d5
	jeq .L102
	move.l %d0,%a1
	subq.l #1,%a1
	tst.l %d0
	jle .L102
	moveq #83,%d1
	cmp.l %d4,%d1
	jcc .L147
	addq.l #1,%d5
	move.l %a1,%d0
	jra .L141
.L147:
	move.l %d4,%d2
	mov3q.l #7,%d6
	remu.l %d6,%d3:%d2
	divu.l %d6,%d2
	lea modes,%a0
	move.l %d0,%d1
	mvz.w (%a0,%d3.l*2),%d4
	moveq #12,%d3
	sub.l %d2,%d3
.L118:
	move.l %a1,%d0
	moveq #12,%d7
	add.l %d3,%d0
	remu.l %d7,%d6:%d0
	move.l %d4,%d2
	mov3q.l #1,%d0
	asr.l %d6,%d2
	and.l %d2,%d0
	btst #0,%d2
	jeq .L119
.L148:
	addq.l #1,%d5
	tst.l %d5
	jeq .L120
	tst.l %a1
	jeq .L120
	move.l %a1,%d1
	subq.l #1,%a1
	move.l %a1,%d0
	moveq #12,%d7
	add.l %d3,%d0
	remu.l %d7,%d6:%d0
	move.l %d4,%d2
	mov3q.l #1,%d0
	asr.l %d6,%d2
	and.l %d2,%d0
	btst #0,%d2
	jne .L148
.L119:
	move.l %d1,%a0
	subq.l #2,%a0
.L123:
	move.l %d3,%d1
	mov3q.l #-1,%d7
	add.l %a0,%d1
	lea (-1,%a0),%a1
	cmp.l %a0,%d7
	jeq .L102
	moveq #12,%d6
	remu.l %d6,%d2:%d1
	btst %d2,%d4
	jeq .L128
	move.l %a0,%d1
	addq.l #1,%d5
	tst.l %d5
	jeq .L125
	tst.l %a0
	jne .L118
.L125:
	movem.l (%sp),#252
	move.l %a0,%d0
	lea (24,%sp),%sp
	rts
.L128:
	move.l %a1,%a0
	jra .L123
.L144:
	subq.l #1,%d0
	jra .L104
.L120:
	movem.l (%sp),#252
	move.l %a1,%d0
	lea (24,%sp),%sp
	rts
	.size	akl_move, .-akl_move
	.align	2
	.globl	akl_claims
	.type	akl_claims, @function
akl_claims:
	move.l 4(%sp),-(%sp)
	jsr akl_key
	addq.l #4,%sp
	cmp.l #255,%d0
	jeq .L154
	mov3q.l #1,%d0
	rts
.L154:
	move.l 4(%sp),-(%sp)
	jsr shift_now
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
	lea (-16,%sp),%sp
	movem.l #1052,(%sp)
	move.l 20(%sp),-(%sp)
	jsr akl_key
	move.l 24(%sp),-(%sp)
	move.l %d0,%a2
	jsr shift_now
	addq.l #8,%sp
	cmp.l #255,%a2
	jeq .L173
	move.l 24(%sp),%a1
	tst.b (%a1)
	jlt .L161
	cmp.l #255,%d0
	jeq .L174
	move.l %d0,%d1
	moveq #28,%d4
	lsl.l %d4,%d1
	asr.l %d4,%d1
	move.l %d1,-(%sp)
	move.l %a2,-(%sp)
	move.l 32(%sp),%a0
	mvs.b (%a0),%d0
	move.l %d0,-(%sp)
	jsr akl_move
	lea (12,%sp),%sp
.L165:
	move.l 24(%sp),%a1
	move.b %d0,(%a1)
.L161:
	movem.l (%sp),#1052
	mov3q.l #1,%d0
	lea (16,%sp),%sp
	rts
.L173:
	cmp.l %d0,%a2
	jeq .L166
	move.l 20(%sp),%d1
	moveq #68,%d2
	moveq #23,%d3
	muls.l %d2,%d1
	move.l %d1,%a0
	add.l #1187474929,%a0
	mvz.b (%a0),%d1
	subq.l #1,%d1
	cmp.l %d1,%d3
	jcs .L158
	mov3q.l #1,%d4
	and.l %d1,%d4
	move.l %d4,%a0
	btst #0,%d1
	jeq .L159
	mov3q.l #5,%a0
.L159:
	move.l 24(%sp),%a1
	tst.b (%a1)
	jlt .L161
	lsr.l #1,%d1
	moveq #28,%d4
	mulu.w #7,%d1
	lea 1(%a0,%d1.l),%a2
	move.l %d0,%d1
	lsl.l %d4,%d1
	asr.l %d4,%d1
	move.l %d1,-(%sp)
	move.l %a2,-(%sp)
	move.l 32(%sp),%a0
	mvs.b (%a0),%d0
	move.l %d0,-(%sp)
	jsr akl_move
	lea (12,%sp),%sp
	jra .L165
.L174:
	move.b (%a1),%d0
	subq.l #1,%a2
	moveq #83,%d1
	cmp.l %a2,%d1
	jcs .L165
	mvs.b %d0,%d1
	tst.b %d0
	jmi .L165
	mov3q.l #7,%d3
	move.l %a2,%d2
	add.l #12,%d1
	remu.l %d3,%d4:%d2
	divu.l %d3,%d2
	lea modes,%a1
	sub.l %d2,%d1
	moveq #12,%d2
	remu.l %d2,%d3:%d1
	mvz.w (%a1,%d4.l*2),%d1
	btst %d3,%d1
	jne .L165
	move.l 24(%sp),%a1
	subq.l #1,%d0
	move.b %d0,(%a1)
	jra .L161
.L158:
	move.l 24(%sp),%a0
	tst.b (%a0)
	jlt .L161
	move.l %d0,%d1
	moveq #28,%d4
	lsl.l %d4,%d1
	sub.l %a2,%a2
	asr.l %d4,%d1
	move.l %d1,-(%sp)
	move.l %a2,-(%sp)
	move.l 32(%sp),%a0
	mvs.b (%a0),%d0
	move.l %d0,-(%sp)
	jsr akl_move
	lea (12,%sp),%sp
	jra .L165
.L166:
	movem.l (%sp),#1052
	clr.l %d0
	lea (16,%sp),%sp
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
	jeq .L175
	mvz.b %d2,%d0
	mov3q.l #7,%d1
	cmp.l %d0,%d1
	jcs .L175
	mvz.b %d3,%d0
	moveq #15,%d2
	cmp.l %d0,%d2
	jcs .L175
	move.l 20(%sp),%d0
	add.l #-1074668000,%d0
	cmp.l #9535680,%d0
	jhi .L175
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
	jne .L177
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
.L184:
	move.l %a1,%d0
	btst %d1,%d0
	jeq .L179
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
	jcc .L180
	moveq #23,%d3
	cmp.l 28(%sp),%d3
	jcs .L186
	move.l 32(%sp),%a0
.L181:
	tst.l %a0
	jlt .L187
.L198:
	moveq #84,%d2
	cmp.l %a0,%d2
	jge .L182
	move.w #84,%a0
.L182:
	move.w %a0,%d3
	move.b %d3,(%a2)
	move.l 24(%sp),%a2
	move.b %d3,(%a2,%d0.l)
.L179:
	addq.l #1,%d1
	moveq #16,%d0
	cmp.l %d1,%d0
	jne .L184
	move.b gen,%d0
	mvz.b %d0,%d1
	cmp.l #255,%d1
	jeq .L188
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
.L175:
	movem.l (%sp),#3084
	lea (36,%sp),%sp
	rts
.L180:
	add.l 40(%sp),%a0
	tst.l %a0
	jge .L198
.L187:
	move.w #255,%a0
	move.w %a0,%d3
	move.b %d3,(%a2)
	move.l 24(%sp),%a2
	move.b %d3,(%a2,%d0.l)
	jra .L179
.L186:
	move.l 40(%sp),%a0
	jra .L181
.L177:
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
	jra .L184
.L188:
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
	jra .L175
	.size	akl_knob, .-akl_knob
	.align	2
	.globl	akl_turn
	.type	akl_turn, @function
akl_turn:
	subq.l #4,%sp
	move.l %d2,-(%sp)
	jsr track_trigs
	tst.l -2147483630
	jeq .L202
	move.b 1175456536,%d1
	mvz.b 1175456537,%d0
	lsl.l #8,%d0
	mvz.b %d1,%d1
	or.l %d1,%d0
	jeq .L202
	mov3q.l #5,%d0
	cmp.l 12(%sp),%d0
	jeq .L234
	mov3q.l #3,%d1
	cmp.l 12(%sp),%d1
	jeq .L235
	mov3q.l #4,%d2
	cmp.l 12(%sp),%d2
	jeq .L236
.L202:
	move.l (%sp)+,%d2
	clr.l %d0
	addq.l #4,%sp
	rts
.L234:
	move.l 16(%sp),-(%sp)
	clr.l show_shift
	jsr akl_knob
	addq.l #4,%sp
.L204:
	mov3q.l #1,%d0
.L239:
	move.l (%sp)+,%d2
	addq.l #4,%sp
	rts
.L236:
	mov3q.l #1,show_shift
	jsr shift_at
	move.l %d0,%a0
	tst.l %d0
	jeq .L204
	move.l order_note,%d0
	tst.l %d0
	jlt .L237
.L212:
	move.b (%a0),%d1
	move.w %d1,%a1
	mvz.b %d1,%d1
	cmp.l #255,%d1
	jeq .L215
	lsr.l #4,%d1
	cmp.l %d1,%d0
	jeq .L238
.L215:
	move.l 16(%sp),%d1
.L214:
	mov3q.l #7,%d2
	cmp.l %d1,%d2
	jge .L216
	mov3q.l #7,%d1
.L217:
	moveq #15,%d2
	lsl.l #4,%d0
	and.l %d2,%d1
	move.l #268525902,%a1
	or.l %d0,%d1
	move.b %d1,(%a0)
	sub.l 1187521622,%a1
	move.b %d1,(%a1,%a0.l)
	move.l 16(%sp),-(%sp)
	jsr (after_edit.constprop.0)
	addq.l #4,%sp
.L242:
	mov3q.l #1,%d0
	jra .L239
.L237:
	move.l %a0,4(%sp)
	mov3q.l #-1,order_note
	jsr pick_note
	move.l order_note,%d0
	move.l 4(%sp),%a0
	jra .L212
.L238:
	moveq #28,%d2
	move.l %a1,%d1
	lsl.l %d2,%d1
	asr.l %d2,%d1
	add.l 16(%sp),%d1
	jra .L214
.L235:
	move.l order_note,%d0
	mov3q.l #-1,%d2
	mov3q.l #1,show_shift
	cmp.l %d0,%d2
	jeq .L240
	moveq #-2,%d1
	cmp.l %d0,%d1
	jeq .L241
	add.l 16(%sp),%d0
	moveq #15,%d2
	cmp.l %d0,%d2
	jge .L210
	move.l %d2,order_note
.L231:
	jsr shift_at
.L209:
	jsr 1074240840
	move.l 16(%sp),-(%sp)
	clr.l -(%sp)
	jsr 1074260376
	addq.l #8,%sp
.L243:
	mov3q.l #1,%d0
	jra .L239
.L216:
	moveq #-7,%d2
	cmp.l %d1,%d2
	jle .L217
	moveq #-7,%d1
	moveq #15,%d2
	lsl.l #4,%d0
	and.l %d2,%d1
	move.l #268525902,%a1
	or.l %d0,%d1
	move.b %d1,(%a0)
	sub.l 1187521622,%a1
	move.b %d1,(%a1,%a0.l)
	move.l 16(%sp),-(%sp)
	jsr (after_edit.constprop.0)
	addq.l #4,%sp
	jra .L242
.L241:
	tst.l 16(%sp)
	jle .L231
	clr.l %d0
.L208:
	move.l %d0,order_note
	jsr shift_at
	jsr 1074240840
	move.l 16(%sp),-(%sp)
	clr.l -(%sp)
	jsr 1074260376
	addq.l #8,%sp
	jra .L243
.L210:
	tst.l %d0
	jge .L208
	moveq #-2,%d0
	move.l %d0,order_note
	jsr shift_at
	move.l %d0,%a0
	tst.l %d0
	jeq .L209
	mvz.b (%a0),%d0
	cmp.l #255,%d0
	jeq .L209
	move.b #-1,(%a0)
	st %d1
	move.l #268525902,%a1
	sub.l 1187521622,%a1
	move.b %d1,(%a1,%a0.l)
	move.l 16(%sp),-(%sp)
	jsr (after_edit.constprop.0)
	addq.l #4,%sp
	mov3q.l #1,%d0
	jra .L239
.L240:
	jsr pick_note
	jsr 1074240840
	move.l 16(%sp),-(%sp)
	clr.l -(%sp)
	jsr 1074260376
	addq.l #8,%sp
	jra .L243
	.size	akl_turn, .-akl_turn
	.align	2
	.globl	akl_text_claims
	.type	akl_text_claims, @function
akl_text_claims:
	jsr track_trigs
	mov3q.l #5,%d0
	cmp.l 4(%sp),%d0
	jeq .L245
.L247:
	clr.l %d0
	rts
.L245:
	tst.l -2147483630
	jeq .L247
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
	lea (-36,%sp),%sp
	movem.l #17436,(%sp)
	move.l 40(%sp),%a0
	move.b 269161676,%d1
	move.b 269161680,%d0
	move.l 1187521622,%a1
	clr.b (%a0)
	move.b %d0,20(%sp)
	move.l order_step,%d0
	tst.l %d0
	jlt .L279
	mvz.b %d1,%d2
	mov3q.l #7,%d3
	cmp.l %d2,%d3
	jcs .L279
	mvz.b 20(%sp),%d4
	moveq #15,%d2
	cmp.l %d4,%d2
	jcs .L279
	move.l #-1074668000,%a6
	add.l %a1,%a6
	cmp.l #9535680,%a6
	jhi .L279
	move.b 20(%sp),%d3
	move.l 1175264772,%d2
	ext.w %d1
	lea (18640,%a1),%a6
	lea (5,%a0),%a1
	lsl.l #4,%d2
	mulu.w #2224,%d1
	ext.w %d3
	move.w %d3,%d4
	add.l %d2,%d0
	mulu.w #36568,%d4
	add.l %d4,%a6
	add.l %d1,%a6
	moveq #63,%d1
	and.l %d1,%d0
	tst.l show_shift
	jeq .L257
	move.l order_note,%d1
	moveq #-2,%d2
	cmp.l %d1,%d2
	jeq .L279
	tst.l %d1
	jge .L284
.L257:
	lsl.l #5,%d0
	moveq #84,%d1
	mvz.b 78(%a6,%d0.l),%d0
	cmp.l %d0,%d1
	jcs .L285
	tst.l %d0
	jne .L267
	move.l %a0,%d0
	add.l #9,%d0
	lea .LC0,%a6
.L268:
	move.l %a1,%a0
	addq.l #1,%a1
	move.b (%a6)+,(%a0)
	cmp.l %d0,%a1
	jne .L268
.L253:
	movem.l (%sp),#17436
	lea (36,%sp),%sp
	rts
.L279:
	moveq #45,%d3
	clr.b %d4
	move.b %d3,5(%a0)
	move.b %d3,6(%a0)
	move.b %d4,7(%a0)
	movem.l (%sp),#17436
	lea (36,%sp),%sp
	rts
.L285:
	moveq #45,%d2
	clr.b %d3
	move.b %d2,5(%a0)
	move.b %d2,6(%a0)
	move.b %d3,7(%a0)
	movem.l (%sp),#17436
	lea (36,%sp),%sp
	rts
.L284:
	moveq #9,%d3
	move.l %d1,%d2
	rems.l %d3,%d4:%d2
	lsl.l #5,%d0
	moveq #78,%d2
	clr.w %d3
	add.l #49,%d4
	move.l %d4,20(%sp)
	move.w #11565,%d4
	move.b 79(%a6,%d0.l),%d0
	move.b %d2,32(%sp)
	clr.b %d2
	move.w %d3,34(%sp)
	move.b 23(%sp),33(%sp)
	move.w %d4,28(%sp)
	moveq #8,%d4
	mvz.b %d0,%d3
	move.b %d2,30(%sp)
	move.l %d3,%a6
	cmp.l %d1,%d4
	jge .L259
	moveq #49,%d2
	move.l %d1,%d3
	add.l #39,%d3
	move.l %d3,20(%sp)
	move.b 23(%sp),34(%sp)
	move.b %d2,33(%sp)
.L259:
	cmp.l #255,%a6
	jeq .L260
	move.l %a6,%d4
	lsr.l #4,%d4
	cmp.l %d1,%d4
	jeq .L286
.L260:
	move.l %sp,%d0
	add.l #32,%d0
.L264:
	move.l %d0,%a2
	addq.l #1,%a2
	move.b -1(%a2),(%a1)
	move.l %a2,%d0
	addq.l #1,%a1
	subq.l #1,%a2
	tst.b (%a2)+
	jne .L264
	lea (28,%sp),%a6
.L265:
	move.b (%a6),(%a0)
	addq.l #1,%a0
	tst.b (%a6)+
	jeq .L253
	move.b (%a6),(%a0)
	addq.l #1,%a0
	tst.b (%a6)+
	jne .L265
	jra .L253
.L286:
	moveq #15,%d1
	moveq #8,%d2
	and.l %d1,%d0
	moveq #8,%d1
	eor.l %d0,%d1
	move.l %d1,%a6
	move.l %d1,%d0
	subq.l #8,%a6
	cmp.l %d1,%d2
	jne .L261
	move.w #12288,%d3
	move.l %sp,%d0
	add.l #32,%d0
	move.w %d3,28(%sp)
	jra .L264
.L267:
	subq.l #1,%d0
	move.l %d0,20(%sp)
	mov3q.l #7,%d4
	remu.l %d4,%d1:%d0
	lsl.l #2,%d1
	move.l %d1,%d0
	add.l #names,%d0
.L269:
	move.l %d0,%a2
	addq.l #1,%a0
	move.b (%a2)+,%d1
	move.b %d1,-1(%a0)
	move.l %a2,%d0
	tst.b %d1
	jne .L269
	move.l 20(%sp),%d0
	mov3q.l #7,%d2
	divu.l %d2,%d0
	mulu.w #3,%d0
	move.l %d0,%a0
	add.l #roots,%a0
.L270:
	move.b (%a0)+,%d0
	addq.l #1,%a1
	move.b %d0,-1(%a1)
	jeq .L253
	move.b (%a0)+,%d0
	addq.l #1,%a1
	move.b %d0,-1(%a1)
	jne .L270
	jra .L253
.L261:
	tst.l %a6
	jlt .L287
	moveq #43,%d4
	add.l #40,%d0
	move.b %d0,29(%sp)
	move.b %d4,28(%sp)
.L288:
	move.l %sp,%d0
	add.l #32,%d0
	jra .L264
.L287:
	moveq #56,%d1
	sub.l %d0,%d1
	move.b %d1,%d0
	move.b %d0,29(%sp)
	jra .L288
	.size	akl_key_text, .-akl_key_text
	.align	2
	.globl	akl_knob_claims
	.type	akl_knob_claims, @function
akl_knob_claims:
	tst.l -2147483630
	jeq .L291
	move.b 1175456536,%d1
	mvz.b 1175456537,%d0
	lsl.l #8,%d0
	mvz.b %d1,%d1
	or.l %d1,%d0
	sne %d0
	mvs.b %d0,%d0
	neg.l %d0
	rts
.L291:
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
	.local	order_prev
	.comm	order_prev,4,2
	.local	show_shift
	.comm	show_shift,4,2
	.data
	.align	2
	.type	order_note, @object
	.size	order_note, 4
order_note:
	.long	-1
	.align	2
	.type	order_step, @object
	.size	order_step, 4
order_step:
	.long	-1
	.type	gen, @object
	.size	gen, 1
gen:
	.byte	1
	.local	cache_shift
	.comm	cache_shift,8,1
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
