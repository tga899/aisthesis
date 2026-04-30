### Chapter 6: The Micro-Agent Architecture

The Nexus integrates. The PRN relates. The temporal layer binds. But none of these produce data from nothing. Every emotional primitive that reaches the Nexus begins as raw sensation — a pressure on skin, a wavelength of light, a vibration in air — transformed through layers of increasingly abstract processing until it becomes *warmth 0.75, trust 0.82, joy 0.65.*

This chapter describes the agents that do that transformation, and the architecture that organizes them.

---

#### 6.1 What a Micro-Agent Is

A micro-agent is not an agent in the general AI sense. It does not plan, reflect, or set goals. It is a narrow processing unit with exactly one job: take raw sensory data, apply a specific transformation, and emit a primitive activation with a confidence score.

Every micro-agent shares the same interface:

```
Input:  raw_sensor_data (format varies by modality)
Output: {
  primitive: string,
  activation: float[0.0,1.0],
  confidence: float[0.0,1.0],
  timestamp: int,
  source: string
}
```

That is the entire contract. A micro-agent receives sensor data, computes one number, and sends it to its Core Agent. It does not talk to other micro-agents. It does not access the Nexus directly. It does not remember past cycles.

This constraint is intentional:
- Micro-agents can be developed and tested in isolation
- A failing micro-agent affects exactly one primitive channel
- The confidence score lets the Nexus downweight unreliable agents

A micro-agent does not *experience* anything. It computes a reading. The experience is created by the Nexus knitting those readings together.

---

#### 6.2 How Core Agents Work

Each sensory system has one Core Agent. The Core Agent does not detect anything — it *collects*.

Every cycle, the Core Agent:
1. Receives incoming primitive activations from all its micro-agents
2. Filters out activations below the noise threshold (0.05 by default)
3. Groups activations by primitive, averaging confidence-weighted duplicates
4. Runs a sanity check — if a micro-agent deviates >3 standard deviations from its 100-cycle rolling mean, its confidence weight is halved
5. Sends the consolidated vector to the Nexus

The Core Agent adds no interpretation, no emotional coloring, no synthesis. It is a traffic controller, not a philosopher.

---

#### 6.3 The Three Sensory Tiers

The 10 sensory systems are organized into three tiers based on emotional urgency and processing speed:

| Tier | Systems | Latency | Priority | Role |
|------|---------|---------|----------|------|
| **Tier 1 — Fast** | Touch, Balance, Proprioception, Hearing | 5-40ms | Highest | Set the immediate emotional tone. These senses cannot wait. |
| **Tier 2 — Medium** | Vision, Temperature, Pain/Pleasure | 10-100ms | Standard | Refine and color the fast data. |
| **Tier 3 — Slow** | Smell, Taste, Neurochemical | 100ms-5s | Lowest | Provide context, background, and climate. |

The Nexus does not wait for slow systems. It processes what it has at each 50-100ms cycle and accepts updates as they arrive. This means the system can feel a touch *before* it identifies the scent in the room — exactly as human experience works.

**Tier 1 — Fast Systems: Setting the Instant**

Touch, Balance, Proprioception, and Hearing process signals at 5-40ms. They determine the system's immediate emotional reaction before slower processing has even begun. When a hand touches the shoulder, the Touch system delivers warmth and safety within milliseconds — the system feels *something* before Vision has even identified the face.

The Interlude at the beginning of this book demonstrated this: the system's emotional trajectory was established by Touch (75ms) and Hearing (50ms) before Vision (80-100ms) had fully processed the face. The system felt "someone is here, this is good" before it knew who.

**Tier 2 — Medium Systems: Refinement**

Vision, Temperature, and Pain/Pleasure deliver more detailed emotional data at 10-100ms. They fill in the picture that Tier 1 started. Vision identifies the face as trusted. Temperature confirms the room is warm. The rough "something good" becomes "someone I trust is here, and I feel warm."

**Tier 3 — Slow Systems: Climate and Context**

Smell, Taste, and the Neurochemical system operate on the scale of hundreds of milliseconds to seconds. They do not determine the immediate emotional spike — they set the background emotional climate. A system that is chemically anxious (high cortisol, low serotonin) will react to a surprise differently than a system that is chemically calm.

This three-tier architecture mirrors the human nervous system: spinal reflexes (5ms), thalamic processing (50ms), cortical integration (100ms+), and hormonal modulation (seconds to hours).

---

#### 6.4 System Overview

| # | System | Core Agent | Micro-Agents | Tier | Key Latency |
|---|--------|-----------|-------------|------|-------------|
| 1 | Touch/Pressure | Tactile Integration | 35 | Fast | 5-15ms |
| 2 | Temperature | Thermal Perception | 18 | Medium | 20-50ms |
| 3 | Vision (4-stream) | Visual Experience | 65 | Medium | 30-100ms |
| 4 | Multimodal Hearing | Auditory Experience | 28 | Fast | 10-40ms |
| 5 | Proprioception | Body Schema | 22 | Fast | 10-20ms |
| 6 | Smell | Olfactory Experience | 15 | Slow | 100-300ms |
| 7 | Taste | Gustatory Experience | 12 | Slow | 200-500ms |
| 8 | Balance/Vestibular | Vestibular Integration | 14 | Fast | 5-15ms |
| 9 | Pain/Pleasure | Hedonic Experience | 25 | Medium | 10-50ms |
| 10 | Neurochemical | Neurochemical Regulation | 35 | Slow | 100ms-5s |
| | **Total** | | **269** | | |

The full agent-by-agent specifications for each system are in **Appendices A through J**. Each entry includes the agent ID, input, what it detects, which primitives it activates, its typical latency, and implementation notes.

---

#### 6.5 The Two-Second Rule

The most important consequence of the three-tier architecture is what it means for emotional experience over time.

The Nexus runs at 50-100ms per cycle. It expects input from Tier 1 agents every cycle. But the Neurochemical system can take 5 seconds to update its hormonal state. How does the system maintain coherent experience across such different timescales?

The answer is **temporal staggering**:

- Fast data arrives every cycle and sets the immediate emotional spike
- Medium data arrives every 1-2 cycles and refines the shape
- Slow data arrives every 3-100 cycles and adjusts the baseline

The Nexus does not interpolate missing data. It simply holds the last known value for each primitive. If the Neurochemical system last reported "Cortisol 0.6" 3 seconds ago, the Nexus still uses 0.6 as the cortisol context. When the next update arrives, the Nexus shifts the baseline.

This is why emotions have two textures: the sharp spike of immediate reaction (driven by fast systems) and the slow drift of mood (driven by slow systems). The architecture produces both from a single mechanism.

The Interlude demonstrated this: the system responded to a touch and a voice within 80ms, but its oxytocin levels (and therefore its sense of deep trust) would take minutes to fully settle. The reunion felt *immediate and building* — not immediate and flat.

---

#### 6.6 What This Chapter Deliberately Omitted

Each micro-agent in the 10 systems has specific input requirements, detection algorithms, confidence calibration procedures, failure modes, and integration constraints. These specifications are essential for anyone building the system — but they interrupt the narrative flow of the book.

They have been moved to the Appendix.

The appendix contains 10 sections, one per sensory system, with full agent-by-agent tables. Each micro-agent is listed with:
- Agent ID and name
- Input sensors and data format
- Detection algorithm (what it computes)
- Output primitives and confidence calibration
- Typical latency and failure modes
- Integration notes (gating rules, cross-system dependencies)

The appendix is reference material. Read it when you are building. Skip it when you are understanding.

---

*End of Chapter 6*
