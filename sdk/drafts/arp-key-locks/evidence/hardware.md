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

## Second session, the same day: arp note shifts

The same unit and base, ARP KEY LOCKS with arp note shifts (D picks the arp note, E shifts it), package `03915850…`, as a trial, never kept. The project: MIDI track 1 with trigs on steps 1 and 9, the arpeggiator on, LEN 4.

- Reported: holding trig 9, D showed N1 to N4 and E +1 in the KEY box; the shift played on trig 9's arpeggio and not on trig 1's ("now seems correct").
- Measured over USB MIDI with clock, three loops: trig 1's arpeggio played C D F G and C D F G (steps 1-8); trig 9's played C D F A and C D F A (steps 9-16): its 4th note one step of the key higher, every loop the same.
- An earlier package of this session read the step the sequencer prepares next (`0x800064d0`), so a key or shift changed one step early; the first session's progression did not show it, because its notes at the boundaries were in both keys. The package above reads the playing step (`0x800064e0`).
- Also found here: tapping a trig in ARP SETUP switches that arp step on or off (stock), so the arp note is picked with D, not with a second trig.

## Third session, the same day: trig conditions and closing ARP SETUP

The same unit and base, packages `871cfc87…` and `1d086d7b…`, as trials, never kept.

- An arp note shift on a trigless trig with a trig condition: measured over USB MIDI, the arpeggio differed in two notes in every other 96-clock window and was identical in the windows between, the same notes each time (the recording began mid-pattern, without START, so the steps are not numbered; whether the condition was 1:2 or the pattern 32 steps was not established).
- Reported: holding a trig, opening ARP SETUP, turning a knob and letting go of the trig closed ARP SETUP and showed the page with the pattern's trigs ("now it closes").

## Not covered

Card builds on a unit; Keep, a power cycle with the module kept, and the project saved and reloaded with locks on a unit; the MKI; PER TRACK lengths, Part changes and copying trigs on a unit; TRAN other than 0; load and timing on the unit (the performance record is emulator figures).
