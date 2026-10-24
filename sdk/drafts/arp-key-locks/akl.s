#NO_APP
	.file	"akl.c"
	.text
	.align	2
	.type	held_from, @function
held_from:
	move.l %a2,-(%sp)
	move.l %d2,-(%sp)
	mvz.w 18(%sp),%d0
	move.l 20(%sp),%d1
	move.l %d1,%a2
	subq.l #1,%a2
	move.l %d0,%a0
	move.l %a0,%d2
	mvz.w %a2,%d0
	lsl.l #5,%d2
	move.l 24(%sp),%a1
	lsl.l #5,%d0
	lea (48,%a1),%a1
	add.l 12(%sp),%a1
	move.l %d2,%a0
	add.l %a1,%a0
	moveq #30,%d2
	move.l %d0,%a2
	add.l %a1,%a2
	mvz.b (%a0),%d0
	cmp.l 24(%sp),%d2
	jeq .L2
.L3:
	cmp.l #255,%d0
	jne .L1
.L28:
	subq.l #1,%d1
	cmp.l %a1,%a0
	jeq .L27
	tst.l %d1
	jeq .L1
	mvz.b -32(%a0),%d0
	lea (-32,%a0),%a0
	cmp.l #255,%d0
	jeq .L28
.L1:
	move.l (%sp)+,%d2
	move.l (%sp)+,%a2
	rts
.L9:
	tst.l %d1
	jeq .L12
	mvz.b (%a2),%d0
	move.l %a2,%a0
.L2:
	moveq #84,%d2
	cmp.l %d0,%d2
	jcc .L1
	subq.l #1,%d1
	cmp.l %a1,%a0
	jeq .L9
	tst.l %d1
	jeq .L12
	lea (-32,%a0),%a0
	mvz.b (%a0),%d0
	jra .L2
.L27:
	tst.l %d1
	jeq .L1
	mvz.b (%a2),%d0
	move.l %a2,%a0
	jra .L3
.L12:
	move.l (%sp)+,%d2
	mvz.w #255,%d0
	move.l (%sp)+,%a2
	rts
	.size	held_from, .-held_from
	.align	2
	.type	track_trigs, @function
track_trigs:
	move.l %d2,-(%sp)
	move.b 1175456536,%d0
	mvz.b 1175456537,%d1
	lsl.l #8,%d1
	mvz.b %d0,%d0
	or.l %d0,%d1
	jne .L30
	mov3q.l #-1,order_note
	mov3q.l #-1,order_step
	clr.l show_shift
.L31:
	move.l (%sp)+,%d2
	move.l %d1,order_prev
	rts
.L30:
	move.l order_step,%d0
	tst.l %d0
	jlt .L35
	btst %d0,%d1
	jne .L31
.L35:
	move.l order_prev,%d2
	not.l %d2
	and.l %d1,%d2
	tst.l %d2
	jeq .L46
	clr.l %d0
	btst #0,%d2
	jne .L36
.L37:
	addq.l #1,%d0
	btst %d0,%d2
	jeq .L37
.L36:
	move.l (%sp)+,%d2
	move.l %d0,order_step
	mov3q.l #-1,order_note
	clr.l show_shift
	move.l %d1,order_prev
	rts
.L46:
	move.l %d1,%d2
	clr.l %d0
	btst #0,%d2
	jeq .L37
	jra .L36
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
	jeq .L57
	moveq #15,%d2
	and.l %d2,%d0
	tst.b %d0
	jeq .L57
	move.l %d1,%d0
	lsl.l #5,%d0
	move.l %d0,%a0
	add.l #1187475438,%a0
	tst.b (%a0)
	jeq .L57
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
	jeq .L47
.L57:
	move.w #255,%a1
.L47:
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
	jlt .L63
	move.w %a0,%d2
	mvz.b %d2,%d2
	move.l %d2,%a1
	mov3q.l #7,%d2
	cmp.l %a1,%d2
	jcs .L63
	mvz.b 7(%sp),%d2
	move.l %d2,%a1
	moveq #15,%d2
	cmp.l %a1,%d2
	jcs .L63
	move.l %d0,%a1
	add.l #-1074668000,%a1
	cmp.l #9535680,%a1
	jhi .L63
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
.L63:
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
	jeq .L68
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
.L68:
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
	jlt .L73
	mvz.b 4(%sp),%d2
	move.l %d2,%a1
	mov3q.l #7,%d2
	cmp.l %a1,%d2
	jcs .L73
	mvz.b 7(%sp),%d2
	move.l %d2,%a1
	moveq #15,%d2
	cmp.l %a1,%d2
	jcs .L74
	cmp.l #1074667999,%d1
	jls .L75
	cmp.l #1084203680,%d1
	jhi .L73
	move.l 1175264772,%d2
	move.l %d2,8(%sp)
	mov3q.l #-1,%d2
	cmp.l %a0,%d2
	jeq .L98
.L71:
	move.l (%sp)+,%d2
	addq.l #8,%sp
	rts
.L73:
	mov3q.l #-1,%d0
	cmp.l %a0,%d0
	jne .L71
.L78:
	clr.l %d0
	move.l %d0,order_note
.L99:
	move.l (%sp)+,%d2
	addq.l #8,%sp
	rts
.L98:
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
	jeq .L78
	mvz.b (%a0),%d0
	lsr.l #4,%d0
	move.l %d0,order_note
	jra .L99
.L74:
	mov3q.l #-1,%d2
	cmp.l %a0,%d2
	jeq .L78
	move.l (%sp)+,%d2
	addq.l #8,%sp
	rts
.L75:
	mov3q.l #-1,%d1
	cmp.l %a0,%d1
	jeq .L78
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
	jcs .L100
	tst.l %d0
	jlt .L100
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
	jne .L100
	subq.l #1,%d0
.L100:
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
	move.l 44(%sp),%a0
	movem.l #1036,(%sp)
	cmp.l %a0,%d0
	jcs .L109
	move.b -2147457603,%d0
	move.b -2147457602,%d1
	move.l #-2147457832,%a1
	moveq #15,%d2
	add.l %a0,%a1
	move.b (%a1),28(%sp)
	move.b %d1,27(%sp)
	or.l %d0,%d1
	mvz.b %d1,%d1
	cmp.l %d1,%d2
	jcs .L109
	mvz.b 27(%sp),%d3
	mvz.b %d0,%d0
	mvz.b 28(%sp),%d2
	mvz.b gen,%d1
	move.l %d3,%a1
	move.l %d0,%d3
	swap %d3
	clr.w %d3
	move.l %d2,32(%sp)
	moveq #24,%d2
	lsl.l %d2,%d1
	lea cache_for,%a2
	move.l %d3,24(%sp)
	move.l %a1,%d3
	lsl.l #8,%d3
	or.l 24(%sp),%d1
	or.l %d3,%d1
	or.l 32(%sp),%d1
	cmp.l (%a2,%a0.l*4),%d1
	jne .L110
	movem.l (%sp),#1036
	lea cache_key,%a1
	mvz.b (%a1,%a0.l),%d0
	move.l %d0,%a1
	move.l %a1,%d0
	lea (40,%sp),%sp
	rts
.L110:
	move.w %a1,%d3
	move.l #635712,%d2
	muls.l %d2,%d0
	move.l %a0,%d2
	mulu.w #36568,%d3
	move.l %d3,%a1
	add.l %a1,%d0
	mvz.w #2224,%d3
	move.l %d0,%a1
	move.l %d0,%a2
	add.l #1074668000,%a1
	add.l #1074704437,%a2
	muls.l %d3,%d2
	move.l %a2,24(%sp)
	add.l %d2,%a1
	lea (18640,%a1),%a2
	move.l %a2,36(%sp)
	move.l 24(%sp),%a2
	tst.b (%a2)
	jeq .L111
	move.b 18680(%a1),%d0
	mvz.b %d0,%d2
	move.l %d2,28(%sp)
	tst.b %d0
	jeq .L115
.L118:
	move.l %d2,24(%sp)
	moveq #64,%d3
	cmp.l %d2,%d3
	jcc .L114
	moveq #64,%d2
	move.l %d2,24(%sp)
.L114:
	lea cache_shift,%a2
	move.l 32(%sp),%d0
	move.l 24(%sp),%d3
	remu.l %d3,%d2:%d0
	move.l %d2,28(%sp)
	pea 30.w
	move.l 28(%sp),-(%sp)
	move.l 36(%sp),-(%sp)
	move.l 48(%sp),-(%sp)
	move.l %d1,32(%sp)
	move.l %a0,28(%sp)
	jsr held_from
	move.l 28(%sp),%a0
	move.l %d0,%a1
	move.l #cache_key,%d0
	move.w %a1,%d3
	move.b %d3,(%a0,%d0.l)
	pea 31.w
	move.l 44(%sp),-(%sp)
	move.l 52(%sp),-(%sp)
	move.l 64(%sp),-(%sp)
	move.l %a0,44(%sp)
	move.l %a1,52(%sp)
	jsr held_from
	move.l 44(%sp),%a0
	move.b %d0,(%a2,%a0.l)
	lea cache_for,%a2
	move.l 48(%sp),%d1
	lea (32,%sp),%sp
	move.l 20(%sp),%a1
	move.l %d1,(%a2,%a0.l*4)
.L119:
	movem.l (%sp),#1036
	move.l %a1,%d0
	lea (40,%sp),%sp
	rts
.L109:
	movem.l (%sp),#1036
	move.w #255,%a1
	move.l %a1,%d0
	lea (40,%sp),%sp
	rts
.L111:
	add.l #1074704433,%d0
	move.l %d0,%a1
	move.b (%a1),%d0
	mvz.b %d0,%d2
	move.l %d2,28(%sp)
	tst.b %d0
	jne .L118
.L115:
	mov3q.l #1,24(%sp)
	pea 30.w
	lea cache_shift,%a2
	move.l 28(%sp),-(%sp)
	move.l 36(%sp),-(%sp)
	move.l 48(%sp),-(%sp)
	move.l %d1,32(%sp)
	move.l %a0,28(%sp)
	jsr held_from
	move.l 28(%sp),%a0
	move.l %d0,%a1
	move.l #cache_key,%d0
	move.w %a1,%d3
	move.b %d3,(%a0,%d0.l)
	pea 31.w
	move.l 44(%sp),-(%sp)
	move.l 52(%sp),-(%sp)
	move.l 64(%sp),-(%sp)
	move.l %a0,44(%sp)
	move.l %a1,52(%sp)
	jsr held_from
	move.l 44(%sp),%a0
	move.b %d0,(%a2,%a0.l)
	lea cache_for,%a2
	move.l 48(%sp),%d1
	lea (32,%sp),%sp
	move.l %d1,(%a2,%a0.l*4)
	move.l 20(%sp),%a1
	jra .L119
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
	jcs .L122
	tst.l %d0
	jlt .L122
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
	jeq .L162
.L122:
	tst.l %d5
	jle .L159
	move.l %d4,%d1
	mov3q.l #7,%d2
	remu.l %d2,%d6:%d1
	divu.l %d2,%d1
	move.w #12,%a0
	lea modes,%a1
	sub.l %d1,%a0
.L131:
	moveq #126,%d7
	cmp.l %d0,%d7
	jlt .L120
	addq.l #1,%d0
	moveq #83,%d1
	cmp.l %d4,%d1
	jcs .L123
.L126:
	tst.l %d0
	jlt .L163
	move.l %d0,%d1
	moveq #12,%d7
	add.l %a0,%d1
	remu.l %d7,%d2:%d1
	mvz.w (%a1,%d6.l*2),%d3
	btst %d2,%d3
	jne .L123
.L164:
	moveq #127,%d1
	cmp.l %d0,%d1
	jeq .L123
	addq.l #1,%d0
	move.l %d0,%d1
	moveq #12,%d7
	add.l %a0,%d1
	remu.l %d7,%d2:%d1
	btst %d2,%d3
	jeq .L164
.L123:
	subq.l #1,%d5
	tst.l %d5
	jne .L131
.L120:
	movem.l (%sp),#252
	lea (24,%sp),%sp
	rts
.L163:
	subq.l #1,%d5
	tst.l %d5
	jeq .L120
	addq.l #1,%d0
	jra .L126
.L159:
	tst.l %d5
	jeq .L120
	move.l %d0,%a1
	subq.l #1,%a1
	tst.l %d0
	jle .L120
	moveq #83,%d1
	cmp.l %d4,%d1
	jcc .L165
	addq.l #1,%d5
	move.l %a1,%d0
	jra .L159
.L165:
	move.l %d4,%d2
	mov3q.l #7,%d6
	remu.l %d6,%d3:%d2
	divu.l %d6,%d2
	lea modes,%a0
	move.l %d0,%d1
	mvz.w (%a0,%d3.l*2),%d4
	moveq #12,%d3
	sub.l %d2,%d3
.L136:
	move.l %a1,%d0
	moveq #12,%d7
	add.l %d3,%d0
	remu.l %d7,%d6:%d0
	move.l %d4,%d2
	mov3q.l #1,%d0
	asr.l %d6,%d2
	and.l %d2,%d0
	btst #0,%d2
	jeq .L137
.L166:
	addq.l #1,%d5
	tst.l %d5
	jeq .L138
	tst.l %a1
	jeq .L138
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
	jne .L166
.L137:
	move.l %d1,%a0
	subq.l #2,%a0
.L141:
	move.l %d3,%d1
	mov3q.l #-1,%d7
	add.l %a0,%d1
	lea (-1,%a0),%a1
	cmp.l %a0,%d7
	jeq .L120
	moveq #12,%d6
	remu.l %d6,%d2:%d1
	btst %d2,%d4
	jeq .L146
	move.l %a0,%d1
	addq.l #1,%d5
	tst.l %d5
	jeq .L143
	tst.l %a0
	jne .L136
.L143:
	movem.l (%sp),#252
	move.l %a0,%d0
	lea (24,%sp),%sp
	rts
.L146:
	move.l %a1,%a0
	jra .L141
.L162:
	subq.l #1,%d0
	jra .L122
.L138:
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
	jeq .L172
	mov3q.l #1,%d0
	rts
.L172:
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
	jeq .L191
	move.l 24(%sp),%a1
	tst.b (%a1)
	jlt .L179
	cmp.l #255,%d0
	jeq .L192
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
.L183:
	move.l 24(%sp),%a1
	move.b %d0,(%a1)
.L179:
	movem.l (%sp),#1052
	mov3q.l #1,%d0
	lea (16,%sp),%sp
	rts
.L191:
	cmp.l %d0,%a2
	jeq .L184
	move.l 20(%sp),%d1
	moveq #68,%d2
	moveq #23,%d3
	muls.l %d2,%d1
	move.l %d1,%a0
	add.l #1187474929,%a0
	mvz.b (%a0),%d1
	subq.l #1,%d1
	cmp.l %d1,%d3
	jcs .L176
	mov3q.l #1,%d4
	and.l %d1,%d4
	move.l %d4,%a0
	btst #0,%d1
	jeq .L177
	mov3q.l #5,%a0
.L177:
	move.l 24(%sp),%a1
	tst.b (%a1)
	jlt .L179
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
	jra .L183
.L192:
	move.b (%a1),%d0
	subq.l #1,%a2
	moveq #83,%d1
	cmp.l %a2,%d1
	jcs .L183
	mvs.b %d0,%d1
	tst.b %d0
	jmi .L183
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
	jne .L183
	move.l 24(%sp),%a1
	subq.l #1,%d0
	move.b %d0,(%a1)
	jra .L179
.L176:
	move.l 24(%sp),%a0
	tst.b (%a0)
	jlt .L179
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
	jra .L183
.L184:
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
	jeq .L193
	mvz.b %d2,%d0
	mov3q.l #7,%d1
	cmp.l %d0,%d1
	jcs .L193
	mvz.b %d3,%d0
	moveq #15,%d2
	cmp.l %d0,%d2
	jcs .L193
	move.l 20(%sp),%d0
	add.l #-1074668000,%d0
	cmp.l #9535680,%d0
	jhi .L193
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
	jne .L195
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
.L202:
	move.l %a1,%d0
	btst %d1,%d0
	jeq .L197
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
	jcc .L198
	moveq #23,%d3
	cmp.l 28(%sp),%d3
	jcs .L204
	move.l 32(%sp),%a0
.L199:
	tst.l %a0
	jlt .L205
.L216:
	moveq #84,%d2
	cmp.l %a0,%d2
	jge .L200
	move.w #84,%a0
.L200:
	move.w %a0,%d3
	move.b %d3,(%a2)
	move.l 24(%sp),%a2
	move.b %d3,(%a2,%d0.l)
.L197:
	addq.l #1,%d1
	moveq #16,%d0
	cmp.l %d1,%d0
	jne .L202
	move.b gen,%d0
	mvz.b %d0,%d1
	cmp.l #255,%d1
	jeq .L206
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
.L193:
	movem.l (%sp),#3084
	lea (36,%sp),%sp
	rts
.L198:
	add.l 40(%sp),%a0
	tst.l %a0
	jge .L216
.L205:
	move.w #255,%a0
	move.w %a0,%d3
	move.b %d3,(%a2)
	move.l 24(%sp),%a2
	move.b %d3,(%a2,%d0.l)
	jra .L197
.L204:
	move.l 40(%sp),%a0
	jra .L199
.L195:
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
	jra .L202
.L206:
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
	jra .L193
	.size	akl_knob, .-akl_knob
	.align	2
	.globl	akl_turn
	.type	akl_turn, @function
akl_turn:
	subq.l #4,%sp
	move.l %d2,-(%sp)
	jsr track_trigs
	tst.l -2147483630
	jeq .L220
	move.b 1175456536,%d1
	mvz.b 1175456537,%d0
	lsl.l #8,%d0
	mvz.b %d1,%d1
	or.l %d1,%d0
	jeq .L220
	mov3q.l #5,%d0
	cmp.l 12(%sp),%d0
	jeq .L252
	mov3q.l #3,%d1
	cmp.l 12(%sp),%d1
	jeq .L253
	mov3q.l #4,%d2
	cmp.l 12(%sp),%d2
	jeq .L254
.L220:
	move.l (%sp)+,%d2
	clr.l %d0
	addq.l #4,%sp
	rts
.L252:
	move.l 16(%sp),-(%sp)
	clr.l show_shift
	jsr akl_knob
	addq.l #4,%sp
.L222:
	mov3q.l #1,%d0
.L257:
	move.l (%sp)+,%d2
	addq.l #4,%sp
	rts
.L254:
	mov3q.l #1,show_shift
	jsr shift_at
	move.l %d0,%a0
	tst.l %d0
	jeq .L222
	move.l order_note,%d0
	tst.l %d0
	jlt .L255
.L230:
	move.b (%a0),%d1
	move.w %d1,%a1
	mvz.b %d1,%d1
	cmp.l #255,%d1
	jeq .L233
	lsr.l #4,%d1
	cmp.l %d1,%d0
	jeq .L256
.L233:
	move.l 16(%sp),%d1
.L232:
	mov3q.l #7,%d2
	cmp.l %d1,%d2
	jge .L234
	mov3q.l #7,%d1
.L235:
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
.L260:
	mov3q.l #1,%d0
	jra .L257
.L255:
	move.l %a0,4(%sp)
	mov3q.l #-1,order_note
	jsr pick_note
	move.l order_note,%d0
	move.l 4(%sp),%a0
	jra .L230
.L256:
	moveq #28,%d2
	move.l %a1,%d1
	lsl.l %d2,%d1
	asr.l %d2,%d1
	add.l 16(%sp),%d1
	jra .L232
.L253:
	move.l order_note,%d0
	mov3q.l #-1,%d2
	mov3q.l #1,show_shift
	cmp.l %d0,%d2
	jeq .L258
	moveq #-2,%d1
	cmp.l %d0,%d1
	jeq .L259
	add.l 16(%sp),%d0
	moveq #15,%d2
	cmp.l %d0,%d2
	jge .L228
	move.l %d2,order_note
.L249:
	jsr shift_at
.L227:
	jsr 1074240840
	move.l 16(%sp),-(%sp)
	clr.l -(%sp)
	jsr 1074260376
	addq.l #8,%sp
.L261:
	mov3q.l #1,%d0
	jra .L257
.L234:
	moveq #-7,%d2
	cmp.l %d1,%d2
	jle .L235
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
	jra .L260
.L259:
	tst.l 16(%sp)
	jle .L249
	clr.l %d0
.L226:
	move.l %d0,order_note
	jsr shift_at
	jsr 1074240840
	move.l 16(%sp),-(%sp)
	clr.l -(%sp)
	jsr 1074260376
	addq.l #8,%sp
	jra .L261
.L228:
	tst.l %d0
	jge .L226
	moveq #-2,%d0
	move.l %d0,order_note
	jsr shift_at
	move.l %d0,%a0
	tst.l %d0
	jeq .L227
	mvz.b (%a0),%d0
	cmp.l #255,%d0
	jeq .L227
	move.b #-1,(%a0)
	st %d1
	move.l #268525902,%a1
	sub.l 1187521622,%a1
	move.b %d1,(%a1,%a0.l)
	move.l 16(%sp),-(%sp)
	jsr (after_edit.constprop.0)
	addq.l #4,%sp
	mov3q.l #1,%d0
	jra .L257
.L258:
	jsr pick_note
	jsr 1074240840
	move.l 16(%sp),-(%sp)
	clr.l -(%sp)
	jsr 1074260376
	addq.l #8,%sp
	jra .L261
	.size	akl_turn, .-akl_turn
	.align	2
	.globl	akl_text_claims
	.type	akl_text_claims, @function
akl_text_claims:
	jsr track_trigs
	mov3q.l #5,%d0
	cmp.l 4(%sp),%d0
	jeq .L263
.L265:
	clr.l %d0
	rts
.L263:
	tst.l -2147483630
	jeq .L265
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
	jlt .L297
	mvz.b %d1,%d2
	mov3q.l #7,%d3
	cmp.l %d2,%d3
	jcs .L297
	mvz.b 20(%sp),%d4
	moveq #15,%d2
	cmp.l %d4,%d2
	jcs .L297
	move.l #-1074668000,%a6
	add.l %a1,%a6
	cmp.l #9535680,%a6
	jhi .L297
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
	jeq .L275
	move.l order_note,%d1
	moveq #-2,%d2
	cmp.l %d1,%d2
	jeq .L297
	tst.l %d1
	jge .L302
.L275:
	lsl.l #5,%d0
	moveq #84,%d1
	mvz.b 78(%a6,%d0.l),%d0
	cmp.l %d0,%d1
	jcs .L303
	tst.l %d0
	jne .L285
	move.l %a0,%d0
	add.l #9,%d0
	lea .LC0,%a6
.L286:
	move.l %a1,%a0
	addq.l #1,%a1
	move.b (%a6)+,(%a0)
	cmp.l %d0,%a1
	jne .L286
.L271:
	movem.l (%sp),#17436
	lea (36,%sp),%sp
	rts
.L297:
	moveq #45,%d3
	clr.b %d4
	move.b %d3,5(%a0)
	move.b %d3,6(%a0)
	move.b %d4,7(%a0)
	movem.l (%sp),#17436
	lea (36,%sp),%sp
	rts
.L303:
	moveq #45,%d2
	clr.b %d3
	move.b %d2,5(%a0)
	move.b %d2,6(%a0)
	move.b %d3,7(%a0)
	movem.l (%sp),#17436
	lea (36,%sp),%sp
	rts
.L302:
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
	jge .L277
	moveq #49,%d2
	move.l %d1,%d3
	add.l #39,%d3
	move.l %d3,20(%sp)
	move.b 23(%sp),34(%sp)
	move.b %d2,33(%sp)
.L277:
	cmp.l #255,%a6
	jeq .L278
	move.l %a6,%d4
	lsr.l #4,%d4
	cmp.l %d1,%d4
	jeq .L304
.L278:
	move.l %sp,%d0
	add.l #32,%d0
.L282:
	move.l %d0,%a2
	addq.l #1,%a2
	move.b -1(%a2),(%a1)
	move.l %a2,%d0
	addq.l #1,%a1
	subq.l #1,%a2
	tst.b (%a2)+
	jne .L282
	lea (28,%sp),%a6
.L283:
	move.b (%a6),(%a0)
	addq.l #1,%a0
	tst.b (%a6)+
	jeq .L271
	move.b (%a6),(%a0)
	addq.l #1,%a0
	tst.b (%a6)+
	jne .L283
	jra .L271
.L304:
	moveq #15,%d1
	moveq #8,%d2
	and.l %d1,%d0
	moveq #8,%d1
	eor.l %d0,%d1
	move.l %d1,%a6
	move.l %d1,%d0
	subq.l #8,%a6
	cmp.l %d1,%d2
	jne .L279
	move.w #12288,%d3
	move.l %sp,%d0
	add.l #32,%d0
	move.w %d3,28(%sp)
	jra .L282
.L285:
	subq.l #1,%d0
	move.l %d0,20(%sp)
	mov3q.l #7,%d4
	remu.l %d4,%d1:%d0
	lsl.l #2,%d1
	move.l %d1,%d0
	add.l #names,%d0
.L287:
	move.l %d0,%a2
	addq.l #1,%a0
	move.b (%a2)+,%d1
	move.b %d1,-1(%a0)
	move.l %a2,%d0
	tst.b %d1
	jne .L287
	move.l 20(%sp),%d0
	mov3q.l #7,%d2
	divu.l %d2,%d0
	mulu.w #3,%d0
	move.l %d0,%a0
	add.l #roots,%a0
.L288:
	move.b (%a0)+,%d0
	addq.l #1,%a1
	move.b %d0,-1(%a1)
	jeq .L271
	move.b (%a0)+,%d0
	addq.l #1,%a1
	move.b %d0,-1(%a1)
	jne .L288
	jra .L271
.L279:
	tst.l %a6
	jlt .L305
	moveq #43,%d4
	add.l #40,%d0
	move.b %d0,29(%sp)
	move.b %d4,28(%sp)
.L306:
	move.l %sp,%d0
	add.l #32,%d0
	jra .L282
.L305:
	moveq #56,%d1
	sub.l %d0,%d1
	move.b %d1,%d0
	move.b %d0,29(%sp)
	jra .L306
	.size	akl_key_text, .-akl_key_text
	.align	2
	.globl	akl_knob_claims
	.type	akl_knob_claims, @function
akl_knob_claims:
	tst.l -2147483630
	jeq .L309
	move.b 1175456536,%d1
	mvz.b 1175456537,%d0
	lsl.l #8,%d0
	mvz.b %d1,%d1
	or.l %d1,%d0
	sne %d0
	mvs.b %d0,%d0
	neg.l %d0
	rts
.L309:
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
