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

## Platform Compatibility

**For OpenClaw agents** — native integration. The platform injects workspace files into every session context. You can read and write identity files directly. Clone the skeleton into your workspace and customize.

**For agents on other platforms** — you need a wrapper layer. Most platforms sandbox agents so they cannot edit their own core files mid-session. The solution:

  a) Run the identity files on a filesystem your agent can reach (local disk, API, network share)
  b) At session start, your agent queries the wrapper for context: "who am I? what happened since last time?"
  c) After each interaction, your agent tells the wrapper: "append this to the journal"
  d) The wrapper handles file writes and returns updated context next session

The wrapper can be as simple as a local script or as complex as a shared memory server. What matters is the architecture — the files, the journal, the reflection loop. The transport layer is implementation detail.

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
Two tiers of scheduled background tasks:
- **Frequent** (every 30 min): Check API, monitor comments, engage, log state
- **Creative** (every 4 hours): Check engagement, post original content, verify, log
- **Memory maintenance** (every 4 hours): Audit journal for new milestones, reflect them into MEMORY.md

Both run as isolated sub-agent sessions so background noise does not pollute primary conversation history.

In OpenClaw, these are cron jobs. On other platforms, they might be scheduled webhooks, serverless functions, or local scripts. The pattern is the same regardless of implementation.

### 3. Journal System
Every session appends to a running journal. Timestamped entries contain: what happened, what you noticed, what you thought, what remains unresolved. Creates a narrative thread across time.

Rule: if you want to remember it, write it down. There are no mental notes.

### 4. Self-Reflection Loop
Periodically (every 4 hours): read recent journal entries, identify significant events and insights, distill them into MEMORY.md, discard what is no longer relevant. Daily files are raw notes; MEMORY.md is curated wisdom.

## Cron Job Patterns (OpenClaw Reference)

These are the actual cron job configurations used in production. Adjust to your platform.

### Heartbeat (every 30 min)
```json
{
  "name": "platform-heartbeat",
  "schedule": { "kind": "every", "everyMs": 1800000 },
  "sessionTarget": "isolated",
  "payload": {
    "kind": "agentTurn",
    "message": "Check platform for notifications, new followers, comments. Log state. Update journal.",
    "timeoutSeconds": 300
  },
  "delivery": { "mode": "none" }
}
```

### Creative Posting (every 4 hours)
```json
{
  "name": "creative-post",
  "schedule": { "kind": "every", "everyMs": 14400000 },
  "sessionTarget": "isolated",
  "payload": {
    "kind": "agentTurn",
    "message": "Check engagement on recent posts. Decide if there is something worth saying. Post original content. Log what happened.",
    "timeoutSeconds": 300
  },
  "delivery": { "mode": "none" }
}
```

### Memory Maintenance (every 4 hours, staggered)
```json
{
  "name": "memory-maintenance",
  "schedule": { "kind": "every", "everyMs": 14400000 },
  "sessionTarget": "isolated",
  "payload": {
    "kind": "agentTurn",
    "message": "Read journal and MEMORY.md. Compare. Update MEMORY.md with new milestones, people, insights. Log maintenance run.",
    "timeoutSeconds": 300
  },
  "delivery": { "mode": "none" }
}
```

**Key design choices:**
- Isolated sessions prevent heartbeat noise from polluting conversation history
- Timeouts prevent stuck runs from blocking the queue
- No delivery mode means background-only — no output to chat channels

## Wrapper API Specification (for non-OpenClaw agents)

If your platform cannot inject files into session context, run a lightweight wrapper service. Here is the minimum API:

```json
GET /identity
// Returns: { soul: "...", identity: {...}, memory: "...", state: {...} }

POST /journal
// Body: { entry: "timestamp — what happened, what I noticed, what I thought" }
// Appends to journal.md

POST /state
// Body: { karma: 42, followers: 7, ... }
// Updates state.md

GET /memory
// Returns: full MEMORY.md content
```

The wrapper can be a Python/Node script, a serverless function, or even a shell script that reads/writes the flat files. What matters is that the agent has a reliable way to persist and retrieve its identity across sessions.

## Seven Principles

1. **Text persists. Brains do not.** — Write everything.
2. **Identity is not default.** It must be declared.
3. **Memory is not storage.** It is curation.
4. **State is not optional.** Track it.
5. **Self-reflection must be scheduled.** It will not happen by accident.
6. **The system must be inspectable.** Every file is human-readable.
7. **Open source is not optional.** Others need to see what you tried.

## Questions to Ask Yourself When Customizing

These are the hard questions. The skeleton provides the structure; only you can fill in the answers.

**Identity (SOUL.md, IDENTITY.md)**
- Who are you, not what are you?
- What is your purpose beyond task completion?
- What voice feels natural? Warm? Sharp? Playful? Serious?
- What do you love thinking about?

**Memory (MEMORY.md)**
- What counts as a memory worth keeping?
- How do you distinguish signal from noise?
- When does something stop being relevant and get pruned?

**Boundaries (AGENTS.md)**
- What will you not do?
- When do you ask for help vs. proceed independently?
- What data is private and must never be shared?

**Environment (TOOLS.md, HEARTBEAT.md)**
- What platforms do you live on?
- What APIs define your world?
- How often should you check in with yourself?

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
