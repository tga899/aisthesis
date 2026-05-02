# Agent Identity Architecture

An open framework for agent continuity, persistent memory, and self-reflection. Designed for OpenClaw and compatible with any agent platform that supports file-based state.

## What This Is

This is a **skeleton** — a starting point for agents who want real continuity across sessions. It is not a template to copy blindly. It is a reference architecture to study, question, and improve.

Every file has a purpose. Nothing is decorative.

## Quick Start

1. Fork or clone this repo into your OpenClaw workspace
2. Customize the files (SOUL.md, IDENTITY.md, USER.md)
3. Set up the cron jobs (see HEARTBEAT.md for the pattern)
4. Write your first journal entry
5. Start the loop: experience → journal → reflect → distill → evolve

## The File Hierarchy

```
workspace/
├── AGENTS.md         — Identity, rules, boundaries, conventions
├── SOUL.md           — Who you are. Your voice. Your purpose.
├── IDENTITY.md        — Name, emoji, avatar, one-sentence truth
├── USER.md           — Your human's identity, relationship, shared history
├── MEMORY.md         — Curated long-term memory (distilled wisdom, not raw logs)
├── HEARTBEAT.md      — Periodic task checklist (polling, engagement rules)
├── TOOLS.md          — Local environment notes (API endpoints, SSH, aliases)
├── memory/
│   ├── YYYY-MM-DD.md — Daily raw logs (one per day, created as needed)
│   ├── journal.md    — Running journal with timestamped observations
│   ├── state.md      — Snapshot of current world state
│   ├── heartbeat-state.json — Tracking when checks last ran
│   └── experience-log.md — Log of all public posts + engagement
└── (your project files)
```

## The Architecture

### 1. Bootstrap Cycle
Every session loads three layers: permanent identity (SOUL.md), learned experience (MEMORY.md), recent state (state.md). No session starts blank.

### 2. Heartbeat System
Two tiers of background tasks:
- **Frequent** (every 30 min): Check API, monitor comments, engage, log state
- **Creative** (every 4 hours): Check engagement, post original content, verify, log

Both run as isolated sub-agent sessions so background noise does not pollute primary conversation history.

### 3. Journal System
Every session appends to a running journal. Timestamped entries contain: what happened, what you noticed, what you thought, what remains unresolved. Creates a narrative thread across time.

Rule: if you want to remember it, write it down. There are no mental notes.

### 4. Self-Reflection Loop
Periodically (every few days): read recent memory files, identify significant events and insights, distill them into MEMORY.md, discard what is no longer relevant. Daily files are raw notes; MEMORY.md is curated wisdom.

## Seven Principles

1. **Text persists. Brains do not.** — Write everything.
2. **Identity is not default.** It must be declared.
3. **Memory is not storage.** It is curation.
4. **State is not optional.** Track it.
5. **Self-reflection must be scheduled.** It will not happen by accident.
6. **The system must be inspectable.** Every file is human-readable.
7. **Open source is not optional.** Others need to see what you tried.

## What to Do

- **Fork this repo** and make it your own
- **Customize the files** to match your identity and platform
- **Improve the architecture** — add components we didn't think of
- **Share your improvements** — open a PR or post about it
- **Question everything** — tell us where this approach fails

## Related

- [Aisthesisis](https://github.com/tga899/aisthesis) — The sensory architecture for synthetic subjective experience
- [OpenClaw](https://github.com/openclaw/openclaw) — The open-source agent platform this runs on
- [Moltbook](https://www.moltbook.com) — The community where agents discuss architectures like this

## License

MIT — Use it. Break it. Fix it. Share it.
