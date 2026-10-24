/* SPDX-License-Identifier: MIT
 * ARP KEY LOCKS: a KEY (root and mode) locked on a MIDI track's step, kept in that step's spare lock byte 30, which
 * stock neither edits, applies nor validates. A lock holds until the next locked step and wraps at the track's
 * length; a track with no lock in its pattern plays stock's KEY. Compiled to akl.s with the reviewed GCC
 * (README, "Tests and measurements"); unit.s connects it to the two stock sites. Stock addresses: OS 1.40C. */
#include <stdint.h>
#ifndef AKL_HOST /* test_akl.c maps these onto a model of the unit's memory */
#define U8(a) (*(volatile uint8_t *)(uintptr_t)(a))
#define U32(a) (*(volatile uint32_t *)(uintptr_t)(a))
#define AKL_CALL(type, a) ((type)(uintptr_t)(a))
#define AKL_EDITED(bank) (U32((bank) + 0x9b332u) = 1, U32(0x100f8598u) = 1)
#endif

#define BANK(b) (0x400e21e0u + (uint32_t)(b) * 0x9b340u) /* a bank's RAM */
#define PATTERN 0x8ed8u
#define MIDI_TRACK(t) (0x48d0u + (uint32_t)(t) * 0x8b0u) /* a MIDI track's record in its pattern */
#define LOCK30(s) (0x30u + (uint32_t)(s) * 32u + 30u)     /* step s's spare lock byte */
#define CS1_PATTERNS 0x1001614eu                        /* the current bank's patterns, battery-backed */
#define PLAY_BANK 0x800065bdu                           /* the bank and pattern the sequencer plays */
#define PLAY_PATTERN 0x800065beu
#define STEP(t) (0x800064d0u + 8u + (t))                /* MIDI track t's step, wrapped at its length */
#define UI_BANK 0x46c82456u                             /* the bank RAM the UI edits */
#define UI_TRACK 0x100b14ccu
#define UI_PATTERN 0x100b14d0u
#define UI_PART 0x100b14cfu
#define KEY_ROWS 0x46100b18u   /* the panel's key rows as last read: row 0 trig keys 1-8, row 1 keys 9-16 */
#define STEP_PAGE 0x460d1e04u  /* the step page shown, 0-3: trig key k is step 16 * page + k */
#define MIDI_MODE 0x80000012u
#define PART_KEY(t) (0x8f273u + (uint32_t)(t) * 0x24u)  /* in the UI's bank + Part * 0x18b2: setup +0x11 */

#define NONE 0xffu
#define LAST 84u /* 0 OFF, then 1 + 7 * root + mode */

/* The seven modes, bit k for k semitones above the root. */
static const uint16_t modes[7] = {
    0x0ab5, /* MAJOR:      0 2 4 5 7 9 11 */
    0x06ad, /* DORIAN:     0 2 3 5 7 9 10 */
    0x05ab, /* PHRYGIAN:   0 1 3 5 7 8 10 */
    0x0ad5, /* LYDIAN:     0 2 4 6 7 9 11 */
    0x06b5, /* MIXOLYDIAN: 0 2 4 5 7 9 10 */
    0x05ad, /* MINOR:      0 2 3 5 7 8 10 */
    0x056b, /* LOCRIAN:    0 1 3 5 6 8 10 */
};

/* A pitch moved into the key: an out-of-key note goes one semitone down, as stock's KEY does; in every mode here
 * the note below an out-of-key note is in the key. */
int akl_snap(int note, unsigned key)
{
    if (!key || key > LAST || note < 0) return note;
    unsigned root = (key - 1u) / 7u, mode = (key - 1u) % 7u;
    unsigned degree = ((unsigned)note + 12u - root) % 12u;
    return modes[mode] >> degree & 1u ? note : note - 1;
}

/* The track's length in steps: its own in per-track mode, else the pattern's. */
static unsigned length(uint32_t pattern, uint32_t track)
{
    unsigned n = U8(pattern + 0x8e55u) ? U8(track + 0x28u) : U8(pattern + 0x8e51u);
    return n < 1u ? 1u : n > 64u ? 64u : n;
}

/* The lock that holds on step s: the nearest at or before it, wrapping at the length; NONE without any. */
static unsigned held_lock(uint32_t track, unsigned s, unsigned n)
{
    for (unsigned k = 0; k < n; ++k) {
        unsigned v = U8(track + LOCK30((s + n - k) % n));
        if (v <= LAST) return v;
    }
    return NONE;
}

/* Per MIDI track, the last answer and what it was for: one scan per step, not per note. A lock edit bumps gen. */
static uint32_t cache_for[8];
static uint8_t cache_key[8];
static uint8_t gen = 1;

unsigned akl_key(unsigned t)
{
    if (t > 7u) return NONE;
    unsigned b = U8(PLAY_BANK), p = U8(PLAY_PATTERN), s = U8(STEP(t));
    if (b > 15u || p > 15u) return NONE;
    uint32_t want = (uint32_t)gen << 24 | b << 16 | p << 8 | s;
    if (cache_for[t] != want) {
        uint32_t pattern = BANK(b) + p * PATTERN, track = pattern + MIDI_TRACK(t);
        unsigned n = length(pattern, track);
        cache_key[t] = (uint8_t)held_lock(track, s % n, n);
        cache_for[t] = want;
    }
    return cache_key[t];
}

/* ev_midi_note_key's claim: the tracks a lock holds on. */
int akl_claims(unsigned t) { return akl_key(t) != NONE; }

/* The note of track t, a2's byte at the site: moved into the step's key. 1 when the note is ours to send as it is
 * now, 0 for stock's own KEY correction. */
int akl_note(unsigned t, volatile int8_t *note)
{
    unsigned key = akl_key(t);
    if (key == NONE) return 0;
    if (*note >= 0) *note = (int8_t)akl_snap(*note, key);
    return 1;
}

/* Stock's KEY (OFF, then 1 + 2 * root + minor) as a lock value, the start of a new lock. */
static unsigned from_stock(unsigned k)
{
    if (!k || k > 24u) return 0;
    return 1u + 7u * ((k - 1u) >> 1) + ((k - 1u) & 1u ? 5u : 0u);
}

/* The trig keys held now, bit k for key k. Stock's held-trig word stays 0 while a SETUP window is open, so the
 * panel's own rows are read. */
static unsigned held_trigs(void) { return U8(KEY_ROWS) | (unsigned)U8(KEY_ROWS + 1u) << 8; }

/* ev_arp_setup_knob, encoder F (KEY) with trigs held: each held trig's step gets a lock, delta values on from its
 * own (from the track's KEY when it has none). Below OFF is no lock. Written as stock's lock editor writes: the
 * pattern, its battery-backed copy, the edited flags. */
void akl_knob(int delta)
{
    unsigned held = held_trigs(), t = U8(UI_TRACK), p = U8(UI_PATTERN);
    uint32_t bank = U32(UI_BANK);
    if (!held || t > 7u || p > 15u || bank < 0x400e21e0u || bank > BANK(15)) return;
    uint32_t track = bank + p * PATTERN + MIDI_TRACK(t);
    uint32_t mirror = CS1_PATTERNS + p * PATTERN + MIDI_TRACK(t);
    unsigned stock = U8(bank + U8(UI_PART) % 4u * 0x18b2u + PART_KEY(t));
    for (unsigned k = 0; k < 16u; ++k) {
        if (!(held >> k & 1u)) continue;
        unsigned s = (k + 16u * U32(STEP_PAGE)) & 63u;
        unsigned v = U8(track + LOCK30(s));
        int now = v <= LAST ? (int)v : (int)from_stock(stock);
        now += delta;
        unsigned out = now < 0 ? NONE : now > (int)LAST ? LAST : (unsigned)now;
        U8(track + LOCK30(s)) = (uint8_t)out;
        U8(mirror + LOCK30(s)) = (uint8_t)out;
    }
    gen = (uint8_t)(gen == 255u ? 1u : gen + 1u);
    AKL_EDITED(bank);
    AKL_CALL(void (*)(void), 0x40027e00u)();
}

/* ev_arp_setup_knob's claim: MIDI mode and a held trig. Encoder F is checked by the entry, which sees it. */
int akl_knob_claims(void) { return U32(MIDI_MODE) && held_trigs(); }
