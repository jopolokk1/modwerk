| SPDX-License-Identifier: MIT
| ARP KEY LOCKS: the two stock sites, to akl.s (compiled from akl.c). A card build reaches the entries through its
| detours (manifest.py); over USB the base's take events reach them (runtime.json, the records below). Either way an
| entry starts with every register and the stack as at the site. Stock addresses: OS 1.40C.

        .text
        .align  2

| 0x4009fb58 (ev_midi_note_key), the MIDI note sender, once per note: d7 the track, a2 the note byte. A held lock
| moves the note into its key and sends it as it is now (0x4009fb80, where stock drops a negative note); without
| one, stock's own six bytes run: KEY's root offset at -64(%fp), 0 for KEY OFF, and the correction at 0x4009fb5e.
        .globl  akl_note_entry
akl_note_entry:
        lea     -16(%sp),%sp
        movem.l %d0-%d1/%a0-%a1,(%sp)
        move.l  %a2,-(%sp)
        move.l  %d7,-(%sp)
        jsr     akl_note
        addq.l  #8,%sp
        tst.l   %d0                       | movem and lea keep the flags
        movem.l (%sp),%d0-%d1/%a0-%a1
        lea     16(%sp),%sp
        bne.s   1f
        tst.l   -64(%fp)
        bgt.s   2f
1:      jmp     0x4009fb80
2:      jmp     0x4009fb5e

| 0x4007a2ec (ev_arp_setup_knob), the entry of MIDI ARP SETUP's encoder handler (encoder, delta), 4(%sp) and 8(%sp);
| d0-d1/a0-a1 are free there, as at any C call. KEY (5) in MIDI mode with a trig held stores step locks and returns
| to the caller; every other turn runs stock's handler from its first instruction, the two the site held.
        .globl  akl_knob_entry
akl_knob_entry:
        moveq   #5,%d0
        cmp.l   4(%sp),%d0
        bne.s   3f
        jsr     akl_knob_claims
        tst.l   %d0
        beq.s   3f
        move.l  8(%sp),-(%sp)
        jsr     akl_knob
        addq.l  #4,%sp
        rts
3:      lea     -36(%sp),%sp              | stock's own prologue, as the site held it
        movem.l %d2-%d7/%a2-%a4,(%sp)
        jmp     0x4007a2f4

        .ifdef  MODWERK_EVENTS
| The take records (struct modwerk_take {claims, entry}): note keys are taken on the tracks a lock holds on, ARP
| SETUP's turns while a trig is held in MIDI mode; the entries hand anything else back to stock.
        .globl  akl_take_note_key
akl_take_note_key:
        .long   akl_claims, akl_note_entry
        .globl  akl_take_arp_knob
akl_take_arp_knob:
        .long   akl_knob_claims, akl_knob_entry
        .endif
