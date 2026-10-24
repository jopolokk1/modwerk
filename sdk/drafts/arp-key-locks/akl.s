#NO_APP
	.file	"akl.c"
	.text
	.align	2
	.type	track_trigs, @function
track_trigs:
	move.l %d3,-(%sp)
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
	move.l (%sp)+,%d3
	rts
.L2:
	move.l order_step,%a0
	move.l order_prev,%d2
	not.l %d2
	and.l %d1,%d2
	tst.l %a0
	jlt .L4
	move.l %a0,%d0
	btst %d0,%d1
	jeq .L4
	mov3q.l #1,%d0
	move.l %a0,%d3
	lsl.l %d3,%d0
	not.l %d0
	and.l %d0,%d2
	tst.l %d2
	jeq .L3
	clr.l %d0
	btst #0,%d2
	jne .L9
.L10:
	addq.l #1,%d0
	btst %d0,%d2
	jeq .L10
.L9:
	move.l (%sp)+,%d2
	move.l %d0,order_note
	mov3q.l #1,show_shift
	move.l (%sp)+,%d3
	move.l %d1,order_prev
	rts
.L4:
	tst.l %d2
	jeq .L23
	clr.l %d0
	btst #0,%d2
	jne .L7
.L8:
	addq.l #1,%d0
	btst %d0,%d2
	jeq .L8
.L7:
	move.l (%sp)+,%d2
	move.l %d0,order_step
	mov3q.l #-1,order_note
	move.l (%sp)+,%d3
	clr.l show_shift
	move.l %d1,order_prev
	rts
.L23:
	move.l %d1,%d2
	clr.l %d0
	btst #0,%d2
	jeq .L8
	jra .L7
	.size	track_trigs, .-track_trigs
	.align	2
	.type	shift_now, @function
shift_now:
	move.l %d3,-(%sp)
	move.l %d2,-(%sp)
	move.l 12(%sp),%d1
	lea cache_shift,%a0
	mvz.b (%a0,%d1.l),%d0
	cmp.l #255,%d0
	jeq .L31
	move.l %d1,%d2
	lsl.l #5,%d2
	move.l %d2,%a0
	add.l #1187475438,%a0
	tst.b (%a0)
	jeq .L31
	moveq #10,%d3
	moveq #68,%d2
	muls.l %d1,%d3
	muls.l %d2,%d1
	move.l %d3,%a1
	add.l #1187478295,%a1
	move.l %d1,%a0
	add.l #1187474926,%a0
	move.b (%a1),%d1
	mvz.b (%a0),%d3
	move.l %d3,%a0
	addq.l #1,%a0
	move.l %a0,%d2
	mvz.b %d1,%d1
	remu.l %d2,%d3:%d1
	move.l %d0,%d1
	lsr.l #4,%d1
	cmp.l %d3,%d1
	jeq .L24
.L31:
	mvz.w #255,%d0
.L24:
	move.l (%sp)+,%d2
	move.l (%sp)+,%d3
	rts
	.size	shift_now, .-shift_now
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
	jcs .L34
	tst.l %d0
	jlt .L34
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
	jne .L34
	subq.l #1,%d0
.L34:
	move.l (%sp)+,%d2
	move.l (%sp)+,%d3
	addq.l #4,%sp
	rts
	.size	akl_snap, .-akl_snap
	.align	2
	.globl	akl_key
	.type	akl_key, @function
akl_key:
	lea (-28,%sp),%sp
	mov3q.l #7,%d0
	movem.l #1084,(%sp)
	move.l 32(%sp),%d3
	cmp.l %d3,%d0
	jcs .L41
	move.b -2147457603,%d0
	move.b -2147457602,%d2
	move.l %d3,%a0
	add.l #-2147457832,%a0
	move.b (%a0),%d4
	moveq #15,%d5
	move.l %d0,%d1
	or.l %d2,%d1
	mvz.b %d1,%d1
	cmp.l %d1,%d5
	jcs .L41
	mvz.b %d0,%d0
	mvz.b gen,%d1
	mvz.b %d2,%d2
	mvz.b %d4,%d4
	move.l %d0,%d5
	swap %d5
	clr.w %d5
	move.l %d5,%a1
	moveq #24,%d5
	lsl.l %d5,%d1
	move.l %d2,%d5
	lsl.l #8,%d5
	move.l %d5,%a0
	move.l %a1,%d5
	or.l %d5,%d1
	move.l %a0,%d5
	lea cache_for,%a0
	or.l %d5,%d1
	or.l %d4,%d1
	move.l %d1,20(%sp)
	cmp.l (%a0,%d3.l*4),%d1
	jne .L44
	lea cache_key,%a0
	mvz.b (%a0,%d3.l),%d0
	movem.l (%sp),#1084
	lea (28,%sp),%sp
	rts
.L44:
	mvz.w #2224,%d5
	move.l #635712,%d1
	muls.l %d1,%d0
	mulu.w #36568,%d2
	muls.l %d3,%d5
	add.l %d2,%d0
	move.l %d0,%a0
	add.l #1074668000,%a0
	move.l %d0,%d1
	add.l %d5,%a0
	add.l #1074704437,%d1
	lea (18640,%a0),%a1
	move.l %d1,%a2
	tst.b (%a2)
	jeq .L45
	move.b 18680(%a0),%d1
	mvz.b %d1,%d0
	tst.b %d1
	jeq .L52
.L57:
	move.l %d0,%d1
	moveq #64,%d0
	cmp.l %d1,%d0
	jcc .L48
	moveq #64,%d1
.L48:
	remu.l %d1,%d2:%d4
	move.l %d1,%d0
	subq.l #1,%d0
	mvz.w %d0,%d0
	move.l %a0,%d4
	add.l #18718,%d4
	lsl.l #5,%d2
	lsl.l #5,%d0
	add.l %d2,%a1
	add.l %d4,%d0
	lea (78,%a1),%a0
	move.l %d0,24(%sp)
.L51:
	move.b (%a0),%d2
	moveq #84,%d5
	mvz.b %d2,%d0
	cmp.l %d0,%d5
	jcc .L49
	cmp.l %a0,%d4
	jeq .L53
	lea (-32,%a0),%a0
	subq.l #1,%d1
	tst.l %d1
	jne .L51
.L58:
	st %d2
	mvz.w #255,%d0
.L49:
	lea cache_key,%a0
	move.b %d2,(%a0,%d3.l)
	lea cache_shift,%a0
	lea (79,%a1),%a1
	move.b (%a1),(%a0,%d3.l)
	move.l 20(%sp),%d1
	lea cache_for,%a0
	move.l %d1,(%a0,%d3.l*4)
	movem.l (%sp),#1084
	lea (28,%sp),%sp
	rts
.L41:
	movem.l (%sp),#1084
	mvz.w #255,%d0
	lea (28,%sp),%sp
	rts
.L45:
	add.l #1074704433,%d0
	move.l %d0,%a2
	move.b (%a2),%d1
	mvz.b %d1,%d0
	tst.b %d1
	jne .L57
.L52:
	move.l %a0,%d4
	add.l #18718,%d4
	add.l %d4,%d0
	mov3q.l #1,%d1
	lea (78,%a1),%a0
	move.l %d0,24(%sp)
	jra .L51
.L53:
	move.l 24(%sp),%a0
	subq.l #1,%d1
	tst.l %d1
	jne .L51
	jra .L58
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
	jcs .L61
	tst.l %d0
	jlt .L61
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
	jeq .L101
.L61:
	tst.l %d5
	jle .L98
	move.l %d4,%d1
	mov3q.l #7,%d2
	remu.l %d2,%d6:%d1
	divu.l %d2,%d1
	move.w #12,%a0
	lea modes,%a1
	sub.l %d1,%a0
.L70:
	moveq #126,%d7
	cmp.l %d0,%d7
	jlt .L59
	addq.l #1,%d0
	moveq #83,%d1
	cmp.l %d4,%d1
	jcs .L62
.L65:
	tst.l %d0
	jlt .L102
	move.l %d0,%d1
	moveq #12,%d7
	add.l %a0,%d1
	remu.l %d7,%d2:%d1
	mvz.w (%a1,%d6.l*2),%d3
	btst %d2,%d3
	jne .L62
.L103:
	moveq #127,%d1
	cmp.l %d0,%d1
	jeq .L62
	addq.l #1,%d0
	move.l %d0,%d1
	moveq #12,%d7
	add.l %a0,%d1
	remu.l %d7,%d2:%d1
	btst %d2,%d3
	jeq .L103
.L62:
	subq.l #1,%d5
	tst.l %d5
	jne .L70
.L59:
	movem.l (%sp),#252
	lea (24,%sp),%sp
	rts
.L102:
	subq.l #1,%d5
	tst.l %d5
	jeq .L59
	addq.l #1,%d0
	jra .L65
.L98:
	tst.l %d5
	jeq .L59
	move.l %d0,%a1
	subq.l #1,%a1
	tst.l %d0
	jle .L59
	moveq #83,%d1
	cmp.l %d4,%d1
	jcc .L104
	addq.l #1,%d5
	move.l %a1,%d0
	jra .L98
.L104:
	move.l %d4,%d2
	mov3q.l #7,%d6
	remu.l %d6,%d3:%d2
	divu.l %d6,%d2
	lea modes,%a0
	move.l %d0,%d1
	mvz.w (%a0,%d3.l*2),%d4
	moveq #12,%d3
	sub.l %d2,%d3
.L75:
	move.l %a1,%d0
	moveq #12,%d7
	add.l %d3,%d0
	remu.l %d7,%d6:%d0
	move.l %d4,%d2
	mov3q.l #1,%d0
	asr.l %d6,%d2
	and.l %d2,%d0
	btst #0,%d2
	jeq .L76
.L105:
	addq.l #1,%d5
	tst.l %d5
	jeq .L77
	tst.l %a1
	jeq .L77
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
	jne .L105
.L76:
	move.l %d1,%a0
	subq.l #2,%a0
.L80:
	move.l %d3,%d1
	mov3q.l #-1,%d7
	add.l %a0,%d1
	lea (-1,%a0),%a1
	cmp.l %a0,%d7
	jeq .L59
	moveq #12,%d6
	remu.l %d6,%d2:%d1
	btst %d2,%d4
	jeq .L85
	move.l %a0,%d1
	addq.l #1,%d5
	tst.l %d5
	jeq .L82
	tst.l %a0
	jne .L75
.L82:
	movem.l (%sp),#252
	move.l %a0,%d0
	lea (24,%sp),%sp
	rts
.L85:
	move.l %a1,%a0
	jra .L80
.L101:
	subq.l #1,%d0
	jra .L61
.L77:
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
	jeq .L111
	mov3q.l #1,%d0
	rts
.L111:
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
	jeq .L130
	move.l 24(%sp),%a1
	tst.b (%a1)
	jlt .L118
	cmp.l #255,%d0
	jeq .L131
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
.L122:
	move.l 24(%sp),%a1
	move.b %d0,(%a1)
.L118:
	movem.l (%sp),#1052
	mov3q.l #1,%d0
	lea (16,%sp),%sp
	rts
.L130:
	cmp.l %d0,%a2
	jeq .L123
	move.l 20(%sp),%d1
	moveq #68,%d2
	moveq #23,%d3
	muls.l %d2,%d1
	move.l %d1,%a0
	add.l #1187474929,%a0
	mvz.b (%a0),%d1
	subq.l #1,%d1
	cmp.l %d1,%d3
	jcs .L115
	mov3q.l #1,%d4
	and.l %d1,%d4
	move.l %d4,%a0
	btst #0,%d1
	jeq .L116
	mov3q.l #5,%a0
.L116:
	move.l 24(%sp),%a1
	tst.b (%a1)
	jlt .L118
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
	jra .L122
.L131:
	move.b (%a1),%d0
	subq.l #1,%a2
	moveq #83,%d1
	cmp.l %a2,%d1
	jcs .L122
	mvs.b %d0,%d1
	tst.b %d0
	jmi .L122
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
	jne .L122
	move.l 24(%sp),%a1
	subq.l #1,%d0
	move.b %d0,(%a1)
	jra .L118
.L115:
	move.l 24(%sp),%a0
	tst.b (%a0)
	jlt .L118
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
	jra .L122
.L123:
	movem.l (%sp),#1052
	clr.l %d0
	lea (16,%sp),%sp
	rts
	.size	akl_note, .-akl_note
	.align	2
	.globl	akl_knob
	.type	akl_knob, @function
akl_knob:
	lea (-40,%sp),%sp
	movem.l #3084,(%sp)
	move.b 1175456536,%d0
	mvz.b 1175456537,%d1
	move.b 269161676,%d2
	move.b 269161680,%d3
	move.l 1187521622,%a0
	lsl.l #8,%d1
	move.l %a0,20(%sp)
	mvz.b %d0,%d0
	move.w %d2,%a1
	move.w %d3,%a2
	or.l %d0,%d1
	move.l %d1,%a0
	tst.l %d1
	jeq .L132
	mvz.b %d2,%d0
	mov3q.l #7,%d1
	cmp.l %d0,%d1
	jcs .L132
	mvz.b %d3,%d0
	moveq #15,%d2
	cmp.l %d0,%d2
	jcs .L132
	move.l 20(%sp),%d0
	add.l #-1074668000,%d0
	cmp.l #9535680,%d0
	jhi .L132
	move.w %a1,%d0
	move.b 269161679,%d3
	move.w %a2,%d1
	move.l 20(%sp),%a1
	add.l #586355,%a1
	ext.w %d0
	move.b %d3,19(%sp)
	ext.w %d1
	move.l order_note,%d3
	move.w %d0,%d2
	mulu.w #2224,%d0
	mulu.w #36568,%d1
	move.l %d3,24(%sp)
	mov3q.l #3,%d3
	mulu.w #36,%d2
	move.l %d2,28(%sp)
	move.b 19(%sp),%d2
	add.l 28(%sp),%a1
	move.l %a1,16(%sp)
	move.l 20(%sp),%a1
	move.l 16(%sp),%a3
	lea (18640,%a1),%a1
	and.l %d3,%d2
	add.l %d1,%a1
	add.l %d0,%a1
	add.l %d0,%d1
	mvz.w #6322,%d0
	muls.l %d0,%d2
	mvz.b (%a3,%d2.l),%d0
	move.l %d0,%d2
	subq.l #1,%d2
	move.l %d2,32(%sp)
	btst #0,%d0
	jne .L134
	move.l 32(%sp),%d0
	lsr.l #1,%d0
	lea (78,%a1),%a1
	mov3q.l #5,%a2
	move.l %a1,16(%sp)
	move.l %d1,%a3
	add.l #268544620,%a3
	mulu.w #7,%d0
	move.l %a3,28(%sp)
	clr.l %d1
	lea 1(%a2,%d0.l),%a1
	add.l 44(%sp),%a1
	move.l %a1,36(%sp)
.L141:
	move.l %a0,%d0
	btst %d1,%d0
	jeq .L136
	cmp.l 24(%sp),%d1
	jeq .L136
	moveq #63,%d2
	move.l 1175264772,%d0
	move.l 16(%sp),%a2
	lsl.l #4,%d0
	add.l %d1,%d0
	and.l %d2,%d0
	moveq #84,%d2
	lsl.l #5,%d0
	add.l %d0,%a2
	mvz.b (%a2),%d3
	move.l %d3,%a1
	cmp.l %d3,%d2
	jcc .L137
	moveq #23,%d3
	cmp.l 32(%sp),%d3
	jcs .L143
	move.l 36(%sp),%a1
.L138:
	tst.l %a1
	jlt .L144
.L155:
	moveq #84,%d2
	cmp.l %a1,%d2
	jge .L139
	move.w #84,%a1
.L139:
	move.w %a1,%d3
	move.b %d3,(%a2)
	move.l 28(%sp),%a2
	move.b %d3,(%a2,%d0.l)
.L136:
	addq.l #1,%d1
	moveq #16,%d0
	cmp.l %d1,%d0
	jne .L141
	move.b gen,%d0
	mvz.b %d0,%d1
	cmp.l #255,%d1
	jeq .L145
	addq.l #1,%d0
	move.b %d0,gen
	move.l 20(%sp),%a0
	add.l #635698,%a0
	mov3q.l #1,(%a0)
	mov3q.l #1,269452696
	jsr 1073905152
	jsr 1074240840
	move.l 44(%sp),-(%sp)
	clr.l -(%sp)
	jsr 1074260376
	addq.l #8,%sp
.L132:
	movem.l (%sp),#3084
	lea (40,%sp),%sp
	rts
.L137:
	add.l 44(%sp),%a1
	tst.l %a1
	jge .L155
.L144:
	move.w #255,%a1
	move.w %a1,%d3
	move.b %d3,(%a2)
	move.l 28(%sp),%a2
	move.b %d3,(%a2,%d0.l)
	jra .L136
.L143:
	move.l 44(%sp),%a1
	jra .L138
.L134:
	move.l 32(%sp),%d0
	lsr.l #1,%d0
	lea (78,%a1),%a1
	sub.l %a2,%a2
	move.l %a1,16(%sp)
	move.l %d1,%a3
	add.l #268544620,%a3
	mulu.w #7,%d0
	move.l %a3,28(%sp)
	clr.l %d1
	lea 1(%a2,%d0.l),%a1
	add.l 44(%sp),%a1
	move.l %a1,36(%sp)
	jra .L141
.L145:
	moveq #1,%d0
	move.l 20(%sp),%a0
	add.l #635698,%a0
	mov3q.l #1,(%a0)
	move.b %d0,gen
	mov3q.l #1,269452696
	jsr 1073905152
	jsr 1074240840
	move.l 44(%sp),-(%sp)
	clr.l -(%sp)
	jsr 1074260376
	addq.l #8,%sp
	jra .L132
	.size	akl_knob, .-akl_knob
	.align	2
	.globl	akl_turn
	.type	akl_turn, @function
akl_turn:
	lea (-28,%sp),%sp
	movem.l #1036,(%sp)
	jsr track_trigs
	tst.l -2147483630
	jeq .L159
	move.b 1175456536,%d1
	mvz.b 1175456537,%d0
	lsl.l #8,%d0
	mvz.b %d1,%d1
	or.l %d1,%d0
	jeq .L159
	mov3q.l #5,%d0
	cmp.l 32(%sp),%d0
	jeq .L177
	mov3q.l #3,%d2
	cmp.l 32(%sp),%d2
	jeq .L178
.L159:
	movem.l (%sp),#1036
	clr.l %d0
	lea (28,%sp),%sp
	rts
.L177:
	move.l 36(%sp),-(%sp)
	clr.l show_shift
	jsr akl_knob
	addq.l #4,%sp
.L161:
	mov3q.l #1,%d0
.L180:
	movem.l (%sp),#1036
	lea (28,%sp),%sp
	rts
.L178:
	move.l order_note,%d1
	move.l %d1,%d0
	not.l %d0
	add.l %d0,%d0
	subx.l %d0,%d0
	neg.l %d0
	move.l order_step,%a0
	move.l %a0,%d3
	or.l %d1,%d3
	move.l %d0,show_shift
	move.b 269161676,%d0
	move.b 269161680,%d2
	move.l %d3,%a1
	move.l 1187521622,%d3
	move.l %d3,16(%sp)
	move.b %d2,12(%sp)
	tst.l %a1
	jlt .L161
	mvz.b %d0,%d2
	mov3q.l #7,%d3
	cmp.l %d2,%d3
	jcs .L161
	mvz.b 12(%sp),%d2
	moveq #15,%d3
	cmp.l %d2,%d3
	jcs .L161
	move.l 16(%sp),%a1
	add.l #-1074668000,%a1
	cmp.l #9535680,%a1
	jhi .L161
	move.l 1175264772,%d2
	ext.w %d0
	move.b 12(%sp),%d3
	move.l 16(%sp),%a2
	lsl.l #4,%d2
	mulu.w #2224,%d0
	lea (18719,%a2),%a2
	ext.w %d3
	move.l %d2,20(%sp)
	add.l 20(%sp),%a0
	move.w %d3,%d2
	moveq #63,%d3
	mulu.w #36568,%d2
	add.l %d2,%a2
	move.l %d2,%a1
	move.l %a0,%d2
	and.l %d3,%d2
	add.l %d0,%a2
	move.l %a2,%a0
	lsl.l #5,%d2
	add.l %d2,%a0
	move.b (%a0),23(%sp)
	move.l %d2,24(%sp)
	mvz.b 23(%sp),%d2
	move.l %d2,12(%sp)
	cmp.l #255,%d2
	jeq .L165
	move.l 12(%sp),%d2
	lsr.l #4,%d2
	cmp.l %d1,%d2
	jeq .L179
.L165:
	move.l 36(%sp),%d3
	move.l %d3,12(%sp)
.L164:
	tst.l 12(%sp)
	jeq .L170
	mov3q.l #7,%d3
	cmp.l 12(%sp),%d3
	jge .L167
	mov3q.l #7,12(%sp)
.L168:
	moveq #15,%d2
	and.l 12(%sp),%d2
	lsl.l #4,%d1
	or.l %d2,%d1
.L166:
	move.b gen,%d3
	move.b %d1,(%a0)
	add.l %d0,%a1
	move.l 24(%sp),%a0
	add.l #268544621,%a1
	move.b %d1,(%a1,%a0.l)
	mvz.b %d3,%d0
	move.b %d3,15(%sp)
	cmp.l #255,%d0
	jeq .L171
	move.b %d3,%d0
	move.l 16(%sp),%a0
	add.l #635698,%a0
	mov3q.l #1,(%a0)
	addq.l #1,%d0
	move.b %d0,gen
	mov3q.l #1,269452696
	jsr 1073905152
	jsr 1074240840
	move.l 36(%sp),-(%sp)
	clr.l -(%sp)
	jsr 1074260376
	addq.l #8,%sp
.L181:
	mov3q.l #1,%d0
	jra .L180
.L179:
	move.b 23(%sp),%d3
	moveq #28,%d2
	lsl.l %d2,%d3
	asr.l %d2,%d3
	add.l 36(%sp),%d3
	move.l %d3,12(%sp)
	jra .L164
.L170:
	st %d1
	jra .L166
.L167:
	moveq #-7,%d2
	cmp.l 12(%sp),%d2
	jle .L168
	moveq #-7,%d3
	moveq #15,%d2
	move.l %d3,12(%sp)
	and.l 12(%sp),%d2
	lsl.l #4,%d1
	or.l %d2,%d1
	jra .L166
.L171:
	moveq #1,%d0
	move.l 16(%sp),%a0
	add.l #635698,%a0
	mov3q.l #1,(%a0)
	move.b %d0,gen
	mov3q.l #1,269452696
	jsr 1073905152
	jsr 1074240840
	move.l 36(%sp),-(%sp)
	clr.l -(%sp)
	jsr 1074260376
	addq.l #8,%sp
	jra .L181
	.size	akl_turn, .-akl_turn
	.align	2
	.globl	akl_text_claims
	.type	akl_text_claims, @function
akl_text_claims:
	jsr track_trigs
	mov3q.l #5,%d0
	cmp.l 4(%sp),%d0
	jeq .L183
.L185:
	clr.l %d0
	rts
.L183:
	tst.l -2147483630
	jeq .L185
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
	lea (-32,%sp),%sp
	movem.l #16412,(%sp)
	move.l 36(%sp),%a0
	move.b 269161676,%d1
	move.b 269161680,%d0
	move.l 1187521622,%a1
	clr.b (%a0)
	move.b %d0,16(%sp)
	move.l order_step,%d0
	tst.l %d0
	jlt .L192
	mvz.b %d1,%d2
	mov3q.l #7,%d3
	cmp.l %d2,%d3
	jcs .L192
	mvz.b 16(%sp),%d4
	moveq #15,%d2
	cmp.l %d4,%d2
	jcs .L192
	move.l #-1074668000,%a6
	add.l %a1,%a6
	cmp.l #9535680,%a6
	jhi .L192
	move.b 16(%sp),%d3
	move.l 1175264772,%d2
	ext.w %d1
	lea (18640,%a1),%a1
	lsl.l #4,%d2
	mulu.w #2224,%d1
	ext.w %d3
	move.w %d3,%d4
	add.l %d2,%d0
	mulu.w #36568,%d4
	add.l %d4,%a1
	add.l %d1,%a1
	moveq #63,%d1
	and.l %d1,%d0
	lsl.l #5,%d0
	tst.l show_shift
	jne .L220
.L195:
	mvz.b 78(%a1,%d0.l),%d1
	moveq #84,%d4
	cmp.l %d1,%d4
	jcc .L202
	moveq #45,%d0
	clr.b %d1
	move.b %d0,5(%a0)
	move.b %d0,6(%a0)
	move.b %d1,7(%a0)
.L191:
	movem.l (%sp),#16412
	lea (32,%sp),%sp
	rts
.L192:
	moveq #45,%d3
	clr.b %d4
	move.b %d3,5(%a0)
	move.b %d3,6(%a0)
	move.b %d4,7(%a0)
	movem.l (%sp),#16412
	lea (32,%sp),%sp
	rts
.L220:
	move.l order_note,%d1
	tst.l %d1
	jlt .L195
	moveq #9,%d3
	move.l %d1,%d2
	rems.l %d3,%d4:%d2
	moveq #78,%d2
	clr.w %d3
	move.b 79(%a1,%d0.l),%d0
	move.l %d4,%a6
	move.w #11565,%d4
	lea (49,%a6),%a6
	move.b %d2,28(%sp)
	clr.b %d2
	move.w %d3,30(%sp)
	move.w %a6,%d3
	move.w %d4,25(%sp)
	mvz.b %d0,%d4
	move.b %d2,27(%sp)
	move.l %d4,%a1
	moveq #8,%d2
	move.b %d3,29(%sp)
	cmp.l %d1,%d2
	jge .L196
	move.l %d1,%a6
	lea (39,%a6),%a6
	moveq #49,%d3
	move.w %a6,%d4
	move.b %d3,29(%sp)
	move.b %d4,30(%sp)
.L196:
	cmp.l #255,%a1
	jeq .L197
	move.l %a1,%d2
	lsr.l #4,%d2
	cmp.l %d1,%d2
	jeq .L221
.L197:
	move.l %a0,%d0
	addq.l #5,%d0
	lea (28,%sp),%a6
.L200:
	move.l %d0,%a1
	addq.l #1,%d0
	move.b (%a6),(%a1)
	tst.b (%a6)+
	jne .L200
	lea (25,%sp),%a6
.L201:
	move.b (%a6),(%a0)
	addq.l #1,%a0
	tst.b (%a6)+
	jeq .L191
	move.b (%a6),(%a0)
	addq.l #1,%a0
	tst.b (%a6)+
	jne .L201
	jra .L191
.L202:
	move.l %a0,%d0
	addq.l #5,%d0
	tst.l %d1
	jne .L203
	lea (9,%a0),%a0
	lea .LC0,%a1
.L204:
	move.l %d0,%a6
	addq.l #1,%d0
	move.b (%a1)+,(%a6)
	cmp.l %a0,%d0
	jeq .L191
	move.l %d0,%a6
	addq.l #1,%d0
	move.b (%a1)+,(%a6)
	cmp.l %a0,%d0
	jne .L204
	jra .L191
.L203:
	subq.l #1,%d1
	move.l %d1,16(%sp)
	mov3q.l #7,%d2
	remu.l %d2,%d3:%d1
	lsl.l #2,%d3
	move.l %d3,%a6
	add.l #names,%a6
.L205:
	move.b (%a6)+,%d1
	addq.l #1,%a0
	move.b %d1,-1(%a0)
	jne .L205
	move.l 16(%sp),%d1
	mov3q.l #7,%d4
	divu.l %d4,%d1
	mulu.w #3,%d1
	move.l %d1,%a0
	add.l #roots,%a0
.L206:
	move.b (%a0)+,%d1
	move.l %d0,%a1
	addq.l #1,%d0
	move.b %d1,(%a1)
	jeq .L191
	move.b (%a0)+,%d1
	move.l %d0,%a1
	addq.l #1,%d0
	move.b %d1,(%a1)
	jne .L206
	jra .L191
.L221:
	moveq #15,%d3
	moveq #8,%d1
	and.l %d3,%d0
	mov3q.l #7,%d2
	eor.l %d0,%d1
	move.l %d1,%d0
	cmp.l %d1,%d2
	jcs .L198
	moveq #56,%d1
	sub.l %d0,%d1
	move.b %d1,%d0
	move.b %d0,26(%sp)
.L222:
	move.l %a0,%d0
	addq.l #5,%d0
	lea (28,%sp),%a6
	jra .L200
.L198:
	moveq #43,%d3
	add.l #40,%d0
	move.b %d0,26(%sp)
	move.b %d3,25(%sp)
	jra .L222
	.size	akl_key_text, .-akl_key_text
	.align	2
	.globl	akl_knob_claims
	.type	akl_knob_claims, @function
akl_knob_claims:
	tst.l -2147483630
	jeq .L225
	move.b 1175456536,%d1
	mvz.b 1175456537,%d0
	lsl.l #8,%d0
	mvz.b %d1,%d1
	or.l %d1,%d0
	sne %d0
	mvs.b %d0,%d0
	neg.l %d0
	rts
.L225:
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
