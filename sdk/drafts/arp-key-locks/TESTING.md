# ARP KEY LOCKS: tests

Draft `0.1.0-experimental`. Every result here is from the host or the ColdFire emulator; **nothing has run on a unit**.

## What ran it

- Stock OS 1.40C (`OCTATRACK_OS1.40C_dist.zip`, SHA-256 `370c55a3…`, the repository's reference), kept outside the repository.
- Emulator: octabam's `ot_emu` from `npm run upstream:tools` (octabam `8250be0`) for card builds; Modwerk's adapted `ot_emu` (`scripts/octatrack-emulator/build.py`) for the base. Neither runs a unit's timing.
- Compiler: GCC 16.2 and binutils 2.47 in the repository's toolchain image (`sdk/build/Dockerfile`).
- Base: the beta base with `ev_midi_note_key`, `ev_arp_setup_knob` and `ev_arp_setup_text` (pull request #857), `2b032fd9…`.
- Project: a copy of a user project rewritten by octabam's `tools/verify/midi_fixture.py` (MIDI track 1 on channel 1 arpeggiates chords on steps 3, 5 and 9, MODE UP, 120 BPM); the locks were written into its bank file. Kept outside the repository.

## Host

`python3 -B verify.py` builds `test_akl.c` with `-Wall -Wextra -Werror` (also run with AddressSanitizer and UBSan) and checks:

- every one of the 84 keys on every note 1-127 lands in the key, moving at most one semitone down;
- the example progression (step 1 C MIN, 5 F DOR, 9 G PHR, 13 C MIN) on all 16 steps; a lock wrapping round the loop; a lock past the track's length in PER TRACK mode ignored; a dropped note (-1) left dropped;
- the knob: a lock starts from the track's KEY, steps per count, turns below OFF into no lock, clamps at B LOC, writes the pattern and its battery-backed copy and sets the edited flags; trig keys on page 2 lock steps 17-32;
- the KEY box text: `DOR`/`C#`, OFF, `--`, `LOC`/`B`.

In the toolchain image it also checks that `akl.s` is exactly what GCC 16.2 makes of `akl.c` (`-mcpu=5475 -O2 -ffreestanding -fno-builtin -fno-common -fno-pic -fno-late-combine-instructions`), and `sdk/runtime/m68k_codegen.py` found no post-increment hazard in the object.

## Emulator, card build

A local remix with ARP KEY LOCKS alone, built by Modwerk's `sdk/octabam` (`make bus`): its three detours (6, 8 and 6 bytes) plus the DRAM loader, 112 bytes changed against stock in all.

- **Playback.** The arpeggio with and without the module, the same input: every note-on came on the same frame, and every note was the reference note moved into the key of its step. Four locks (C MIN, F DOR, G PHR, C MIN on steps 1, 5, 9, 13): 13 of 13 notes. One lock (G PHR on step 13), held from step 13 round the loop: 13 of 13. An OFF lock on step 1 and C# MIN on step 9: 13 of 13. No note left on in any run.
- **The gesture.** In grid recording, MIDI ARP SETUP open, trig 5 held, F turned: step 5's spare lock byte took the value (three single counts from KEY OFF: C PHR) and the track's KEY byte was not written. Without the module the same input changed the track's KEY (0, 4, 8, 12 at four counts a report), as on stock.
- **No side effects.** Pressing and releasing trig 5 in ARP SETUP changed neither the track's trig mask nor the arp's step mask, with and without the module.
- **The KEY box.** LCD captures (media/): OFF with no trig held, `--` holding a trig without a lock, C MIN after six counts, F DOR holding the step locked to it, and the track's KEY again on release. Stock redraws the box when a trig is pressed.

## Emulator, USB on the base

The package (`sdk/runtime/loader/build.py --octabam arp-key-locks --name "ARP KEY LOCKS"`, stock-free scan with `--stock`): 1,884 bytes of code and data, 40 of bss, 24 relocations, 3 hooks, no stock-code site. On the adapted emulator, base `2b032fd9…`, through the emulated USB link as the site does (stage, activate, trial, hold, accept): kept, inventory `ARP KEY LOCKS`, no refusal. Each event's subscriber list held the package's record, the note entry's bytes were the relocated code, and the claims answered in place: track 1 (locks) yes, track 4 (none) no, ARP SETUP's knob and text with no trig held no. The emulator cannot press PLAY after a USB install, so playback over USB is not tested; it runs the same code as the card build.

With nothing installed, the base matched stock: identical MIDI with KEY OFF, C MAJ and F MIN; identical locks and KEY changes from held-trig turns on the NOTE, ARP and ARP SETUP pages; four pixel-identical ARP SETUP captures.

## Performance

[evidence/performance.json](evidence/performance.json); emulator figures, not chip timing.

- **Per note.** The note hook runs in the MIDI sequencer's tick interrupt (`0x400a1e0c`, vector 0x60), once per note a track sends. PC watches on its entry and its two exits, a 64-step pattern whose only lock is just after the notes (each new step scans the whole pattern on the locked track, and on the two others): 832 instructions at most, on a new step; 70 to 97 when the step's answer is cached. Statically, at most 64 x 10 instructions of scan plus about 190 around it.
- **Per tick.** The same run grouped by tick: at most 5 notes and 1,856 instructions in one tick. A static bound for the dearest possible tick (eight tracks, four notes each, every answer uncached, the base's dispatch over USB): about 10,900 instructions, 174,464 cycles at 16 an instruction, against one tick at 300 BPM (2,200,000 cycles).
- **Load and stress, 62 s, the same input on the original OS and on the card build** (`ot_emu --mkii --dsp --frame`): one three-byte message every ms (note on, CC, note off on channels 1-8) and a clock byte every 10 ms (250 BPM), the 64-step project with a G PHR lock, STOP and PLAY at 7, 22, 37 and 52 s, Part 2 and back at 30 and 31 s. Longest frame interrupt (entry `0x4000aad4` to epilogue `0x4000d9a6`): 23,201 instructions on both, 131.9 µs in the port's time. Idle: 59.20 % and 59.22 %. Every message reached its handler on both images. MIDI OUT: 206 note-ons with their note-offs on both, 44 moved into the key with the module, none left on.

`npm run perf:audit -- check evidence/performance.json`:

```
✓ record          coldfire record for arp-key-locks@0.1.0-experimental
✓ cycles          worst event 29696 of 2200000 cycles (1%)
✓ stock benchmark under the same flood the longest frame interrupt grows by 0.0 us (0.0% of the 362.8 us frame) and idle time falls by -0.0 points vs stock
✓ stress          1000 messages/s at 250 BPM for 62 s, no stuck note, no hang, 0 dropped
```

## Not tested

Hardware of any kind; playback over USB; the MKI panel; how far KEY moves per physical encoder click; LEN and the arp note editor with a trig held; copying, clearing or placing trigs over locked steps; TRAN other than 0; notes from MIDI IN; Part copy and reload; a power cycle.
