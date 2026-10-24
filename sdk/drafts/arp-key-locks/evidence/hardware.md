# ARP KEY LOCKS on a unit

**Octatrack MKII, OS 1.40C, 24 October 2026.** Tester: @jopolokk1 (the author), driven over USB by Claude Code.

## What ran

- Flashed: Modwerk's beta base `52b22249…`, built from the tester's own OS 1.40C with the repository's toolchain (byte-identical to the committed base, `.bin` SHA-256 `195203f6…`), installed with PROJECT > SYSTEM > OS UPGRADE.
- RAM-booted over USB (`npm run device -- boot`): the base with `ev_midi_note_key`, `ev_arp_setup_knob` and `ev_arp_setup_text` (pull request #857), `2b032fd9…`.
- The package, as a trial (`npm run device -- try … --seconds 1200`, then `--seconds 1800`), never accepted or kept: ARP KEY LOCKS `0.1.0-experimental`, `c654f64e…` (1,896 bytes of code and data, 3 hooks, no stock-code site), built from this folder's `akl.s` and `unit.s`. Each trial rolled back by itself.
- A scratch project (NORD3), MIDI track 1 on channel 1 to an external synth, a trig on step 1 with a chord (NOT2, NOT3) and the arpeggiator on (MODE UP).

## Reported by the tester

- Holding a trig in MIDI ARP SETUP, the KEY box showed `--` on a step without a lock; turning KEY stepped through the keys one name per detent ("a bit sensitive", acceptable); turning past OFF showed `--` again.
- With locks set, the arpeggio kept running smoothly while the key changed on the locked steps.
- With no trig held, KEY changed the track's own KEY, as on stock.
- No freeze or error on screen.

## Measured over USB MIDI

The base's USB MIDI port recorded with `aseqdump`, MIDI clock and transport sent (24 clocks a quarter note, so a step is 6 clocks):

- Locks C MAJ on step 1, C MIN on 5, C MAJ on 9, C MIN on 13, chord C-E-B (NOT2 +4, NOT3 +11), one run of 477 notes from START to STOP: steps 1-4 sent only C, E and B; steps 5-8 only C, E♭ and B♭; steps 9-12 C, E, B; steps 13-16 C, E♭, B♭. Every note was in the key that holds on its step.
- Every run that ended with STOP had every note-on matched by its note-off.
- The base's heartbeat (diagnostic ticks) advanced at 60 a second throughout both trials; the transport-refusal counter stayed at the 9 it read after the RAM boot.

## Not covered

Card builds on a unit; Keep, a power cycle with the module kept, and the project saved and reloaded with locks on a unit; the MKI; PER TRACK lengths, Part changes and copying trigs on a unit; TRAN other than 0; load and timing on the unit (the performance record is emulator figures).
