# Arp Key Locks

## Overview

Lock the arpeggiator's KEY on single steps of a MIDI track, the way you lock a parameter. Hold a trig in MIDI ARP SETUP and turn KEY: that step keeps its own key, for example F DORIAN, and the key holds until the next locked step, wrapping at the end of the pattern. The arpeggio keeps running while the key changes under it; only its notes move into the new scale. Seven modes in all twelve roots: MAJOR, DORIAN, PHRYGIAN, LYDIAN, MIXOLYDIAN, MINOR and LOCRIAN. A pattern without a lock plays the track's KEY, as on stock.

Version `0.1.0-experimental`, for OS 1.40C card builds and, for beta testers, over USB on the Modwerk base.

**Hardware status.** Not tested on a unit. Every result so far is from the ColdFire emulator ([TESTING.md](TESTING.md)).

## Controls

| Where | Gesture | What it does |
|---|---|---|
| MIDI ARP SETUP (FUNC + AMP on a MIDI track) | Hold one or more trigs, turn F (KEY) | Locks a key on each held step. Turning starts from the step's own lock, or from the track's KEY when the step has none. |
| The same | Turn F down past OFF while holding | Removes the step's lock: the step follows the lock before it again. |
| The same | Hold a trig, turn nothing | The KEY box shows the step's lock: root and mode (C / PHR), OFF, or -- for none. |

Lock values, in turning order: OFF (no correction on that step), then C MAJ, C DOR, C PHR, C LYD, C MIX, C MIN, C LOC, C# MAJ and so on to B LOC. MAJ is MAJOR and MIN natural MINOR, as stock's KEY names them; DOR, PHR, LYD, MIX and LOC are the other modes.

Everything else on ARP SETUP is stock: LEN, the arp note editor, and KEY when no trig is held, which sets the track's own KEY (OFF, MAJOR or MINOR in the twelve roots).

## Usage

Program the arpeggio as usual (NOTE and chord notes on the trigs, MODE on the AMP page). The locks decide which scale the notes fall into on each step: an out-of-key note moves one semitone down, the same rule stock's KEY follows for MAJOR and MINOR. A lock affects every note the track sends from that step on: arpeggio notes, chord notes and plain trigs.

### Quick tutorial: a scale that changes every four steps

1. Press [MIDI] and pick a MIDI track that plays an arpeggio (AMP page: MODE UP, a trig with a chord). Press [REC] for grid recording, then [FUNC] + [AMP] to open ARP SETUP.
2. Hold trig 1 and turn KEY to C MIN; release it. Hold trig 5 and turn KEY to F DOR, then trig 9 to G PHR and trig 13 to C MIN. While a trig is held the KEY box shows its lock.
3. Press [PLAY]: steps 1-4 play in C minor, 5-8 in F Dorian, 9-12 in G Phrygian, 13-16 in C minor, and the arpeggio never restarts. To remove a lock, hold its trig and turn KEY down past OFF; with no locks left the track plays its own KEY again.

### How locks combine

The lock that holds on a step is the nearest one at or before it; before the first lock of a pattern, the last one wraps round. One lock on step 1 therefore sets the whole pattern's key. The pattern's length counts, and each track's own length in PER TRACK mode. Locks are saved with the project (tested in the emulator). They sit among the step's stock locks, so by octabam's firmware notes copying a trig or a pattern carries them, and placing a new trig or clearing a trig's locks removes them, as it does stock's locks; that is not tested here.

### What changes in a stock flow

One stock gesture is touched:

- **What changes and for whom.** In MIDI ARP SETUP, turning KEY while a trig is held stores a lock on the held steps instead of changing the track's KEY, and the KEY box shows the held step's lock. On the stock OS a held trig makes no difference there: the turn edits the track's KEY. Everyone with the module in their build or module set has the gesture.
- **Why.** A step's key belongs where KEY already is, and the held-trig gesture is how every other value is locked. Stock's own lock storage has no slot for a setup value, so the lock lives in a step's spare lock byte, which stock neither edits, applies nor validates.
- **What you see and do differently.** With a trig held, KEY reads the step's lock (-- for none) and turning it edits that lock. KEY without a held trig, LEN, the arp note editor and every other page are unchanged.
- **Turning it off.** Release the trig: KEY is the track's again. Remove the module and the locks stay in the project, unused: stock never reads them.
- **Neighbouring flows checked** (emulator, MKII panel, against the original OS): KEY without a held trig; a held trig's NOTE and NLEN locks on the NOTE and ARP pages; the trig pattern and the arp's step mask while trigs are pressed in ARP SETUP. Not checked: the MKI panel, LEN or the note editor with a trig held.

## Compatibility and limitations

- OS 1.40C. Card builds patch three stock sites; over USB the Modwerk base shares them as events (`ev_midi_note_key`, `ev_arp_setup_knob`, `ev_arp_setup_text`), so the package patches no stock code. The base must carry those events.
- The track's own KEY stays stock's (OFF, MAJOR or MINOR). The other modes exist only as step locks: a value stock's Part check rejects can lose the bank at power-up, so the module keeps its modes out of the Part.
- A lock acts on the notes as the track sends them, after TRAN (read from the code; the emulator runs used TRAN 0). Notes played into the track from a MIDI keyboard are not tested.
- How far KEY moves per encoder click follows stock's KEY knob. Its feel on a unit is not tested.
- Upstream octabam's MIDI Scales adds the same modes to the track's KEY by patching the same places; the two are not built together.

## Tests and measurements

See [TESTING.md](TESTING.md). The C core (`akl.c`, compiled to `akl.s` by the reviewed GCC 16.2) is tested on the host for every key and note (`test_akl.c`, run by `verify.py`). In the emulator a card build played a four-lock progression, a single wrapping lock and an OFF lock against the same arpeggio without the module: every note fell into the step's key on exactly the same frame, with no note left on. The hold-trig gesture stored the lock and left the track's KEY alone, and the KEY box showed it. Over the emulated USB link the package installed and kept on the base, and its three events reached it. Performance: [evidence/performance.json](evidence/performance.json). Not tested on hardware.

## Authorship and licences

Original module by @jopolokk1, MIT ([LICENSE](LICENSE)); code written with Claude Code. The seven modes are common musical knowledge; the idea of offering them on the Octatrack's KEY comes from upstream octabam's MIDI Scales by radiohagen (MIT), whose code is not used here. No Elektron firmware, extracted routines or tables are included: stock sites are named by address, length and SHA-256.

## Screens and audio

[media/capture.json](media/capture.json) binds the screenshots to the build and panel walk that made them. Emulator LCD captures; no audio preview.
