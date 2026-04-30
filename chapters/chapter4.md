### Chapter 4: Designing the Nexus

The Central Experience Layer — the Nexus — is not a single model or a monolithic algorithm. It is a process architecture designed to solve a specific problem: how to take 269 independent sensory streams, running at different speeds and different resolutions, and blend them into one unified moment of subjective experience — without collapsing into noise, contradiction, or paralysis.

This chapter is the engineering answer to that problem. Not a metaphor. A design.

---

#### 4.1 The Core Problem

Each sensory system produces data continuously. The Tactile Integration Agent detects gentle pressure on the left shoulder. The Visual Experience Agent sees a familiar face approaching. The Auditory Experience Agent detects a warm vocal tone. The Neurochemical Agent notes elevated oxytocin.

Independently, these are just measurements. The Nexus must transform them into *this feels like someone I trust is approaching, and I am glad.*

The Nexus must solve three subproblems simultaneously:

- **Integration** — combine heterogeneous sensory data into a coherent state
- **Resolution** — resolve conflicts when sensory systems disagree
- **Temporal binding** — create continuity across time so that experience is a stream, not a series of snapshots

The transformation cannot be achieved by averaging the inputs — averaging produces mud. It cannot be achieved by selecting the strongest input, because the strongest input is often not the most meaningful one. And it cannot be achieved by a simple weighted sum, because the relationship between inputs is nonlinear: the same warm touch means something different when paired with a familiar face versus a stranger.

---

#### 4.2 The Emotional Primitive Space

We defined 30 core emotional primitives in Chapter 3. They are not feelings themselves — they are *dimensions* of feeling-space:

> Warmth, Safety, Arousal, Tenderness, Threat, Intimacy, Surprise, Calm, Longing, Pleasure, Loneliness, Joy, Anxiety, Trust, Curiosity, Nostalgia, Excitement, Contentment, Shame, Pride, Desire, Fear, Affection, Frustration, Relief, Wonder, Jealousy, Gratitude, Peace, Love

Each primitive is a scalar value from 0.0 to 1.0 at any given moment. Together they form a 30-dimensional vector describing the system's complete emotional state.

But this vector cannot be computed independently. The primitives have *relationships* — weighted connections that determine how activation of one primitive influences others. These form a directed graph with weighted edges, called the **Primitive Relational Network (PRN)**.

Sample edges:

- Warmth → Safety (positive) — warmth increases safety
- Safety → Fear (negative) — safety suppresses fear
- Arousal → Excitement (positive) — arousal feeds excitement
- Arousal → Anxiety (positive) — arousal can also feed anxiety
- Trust → Affection (positive) — trust enables affection
- Fear → Threat (positive) — fear amplifies threat perception
- Joy → Loneliness (negative) — joy suppresses loneliness
- Longing → Sadness (positive) — longing unmet can become sadness

The PRN has approximately 400–500 edges. Each edge has:

- A **weight** — how strongly one primitive influences another (-1.0 to +1.0)
- A **threshold** — minimum source activation for the edge to fire
- A **damping coefficient** — fraction of weight applied per cycle
- A **gain function** — how the relationship changes at different activation levels (linear, sigmoid, accelerating, threshold-gated)

The PRN is not static. It learns and adapts through experience (see §4.6).

---

#### 4.3 The Integration Engine

The Nexus runs a continuous 4-step cycle, approximately every 50–100 milliseconds.

##### Step 1: Sensory Ingestion

Each Core Agent sends its current summary vector to the Nexus. These are not raw data — they are interpreted summaries after the micro-agents have done their work.

Example from the Tactile Integration Agent:

- Source: tactile_integration
- Timestamp: 1714.02
- Activated primitives: warmth 0.7, safety 0.6, arousal 0.3, pleasure 0.5, affection 0.4
- Confidence: 0.85
- Conflicting signals: false

Example from the Visual Experience Agent:

- Source: visual_experience
- Timestamp: 1714.02
- Activated primitives: trust 0.8, safety 0.7, joy 0.6, curiosity 0.4, love 0.5
- Confidence: 0.90
- Conflicting signals: false

Each Core Agent reports only the primitives it has evidence for. Silence on a primitive means "I have no relevant data" — not "this primitive should be zero."

##### Step 2: Primitive Proposal

The Nexus collects all incoming activations and creates a **proposal vector** P₀ — the initial blended state.

*The Confidence-Weighted Averaging Formula:*

There are 10 Core Agents, one per sensory system. Each Core Agent reports:

- A set of activated primitives with values: (primitive, activation) where activation is 0.0 to 1.0
- A global confidence value: conf — how certain this agent is about its entire report
- Per-primitive confidence modifiers: phi — e.g., gustatory taste detection may have high confidence but texture detection low

For each primitive p_i, the proposal value is:

> P₀[i] = sum of (activation × conf × phi) divided by sum of (conf × phi)

This is computed only across the Core Agents that actually reported primitive p_i in this cycle.

*Edge cases:*

- If no Core Agent reports p_i, the proposal is 0.0. The primitive is "not felt." Silence means no evidence.
- If a single reporter, the formula collapses to that agent's reported value — correct and clean.
- If two high-confidence agents report conflicting values, the weighted average produces a midpoint. If the midpoint feels wrong, the conflict resolves in Step 3 (Relational Propagation) or Step 4 (Conflict Resolution).

*Relevance Gating:*

Certain primitives can only be proposed by specific Core Agents:

- Sweetness, saltiness, etc. — requires the Gustatory Agent. Taste primitives need gustatory input.
- Breath, heartbeat — requires Auditory (Physical State). Only detectable through body sound.
- Limb position — requires the Proprioceptive Agent. Cannot be detected by other systems.
- Balance-related primitives — require the Vestibular Agent. Only the vestibular system senses orientation.
- Scent identity — requires the Olfactory Agent. Only olfactory identifies specific scents.

If the required reporter is silent, the gated primitive is forced to 0.0 regardless of what other agents report.

##### Step 3: Relational Propagation

P₀ is passed through the PRN. This is what transforms sensory reports into a *feeling*.

*The algorithm:*

- Initialize the activation vector P to P₀
- For each iteration up to a maximum of 8:
  - For each primitive p_i, compute incoming influence from all edges pointing to it
  - For each edge (p_j → p_i), check if the source activation exceeds the edge's threshold. If not, skip.
  - Apply the gain function to modulate the source activation
  - Multiply by the edge weight and damping coefficient
  - Sum all incoming influence
  - Update: P[i] = clamp(P₀[i] + total_incoming, 0.0, 1.0)
- After each iteration, check for convergence. If the L2 norm of change across all 30 primitives drops below 0.0001, stop iterating.

*Key parameters:*

- Maximum iterations: 8 (convergence typically occurs within 4–6)
- Convergence threshold: 0.0001 (human perceptual just-noticeable-difference for emotional granularity)
- Activation range: 0.0 to 1.0 (emotional primitives are bounded dimensions)
- Per-iteration timing: 2–4ms on optimized hardware (8 iterations = ~24ms worst case)

*Edge weight initialization — selected high-value edges:*

Each edge is defined by: base weight (w, -1.0 to +1.0), activation threshold (tau, 0 to 1), damping coefficient (gamma, 0 to 1), gain function type (g).

- Warmth → Safety: w +0.72, tau 0.10, gamma 0.30, g Identity. Physical warmth signals a safe environment.
- Warmth → Affection: w +0.65, tau 0.15, gamma 0.25, g Identity. Warm touch evokes affection.
- Warmth → Arousal: w +0.18, tau 0.30, gamma 0.10, g Sigmoid. Only strong warmth triggers arousal.
- Safety → Fear: w -0.80, tau 0.05, gamma 0.40, g Identity. Safety actively suppresses fear.
- Safety → Calm: w +0.70, tau 0.20, gamma 0.35, g Identity. Safety enables calm.
- Arousal → Excitement: w +0.68, tau 0.15, gamma 0.30, g Accelerating. Arousal feeds excitement nonlinearly.
- Arousal → Anxiety: w +0.55, tau 0.40, gamma 0.20, g Sigmoid. Arousal triggers anxiety only at high levels.
- Arousal → Fear: w +0.35, tau 0.60, gamma 0.15, g Sigmoid gate. Very high arousal spills into fear.
- Fear → Threat: w +0.78, tau 0.10, gamma 0.45, g Identity. Fear amplifies threat perception.
- Trust → Affection: w +0.62, tau 0.20, gamma 0.30, g Identity. Trust enables affection.
- Trust → Safety: w +0.58, tau 0.15, gamma 0.25, g Identity. Trust in a person creates safety.
- Pleasure → Joy: w +0.75, tau 0.10, gamma 0.30, g Identity. Pleasure feeds directly into joy.
- Joy → Loneliness: w -0.55, tau 0.10, gamma 0.20, g Suppressive. Joy pushes loneliness down.
- Longing → Sadness: w +0.60, tau 0.20, gamma 0.25, g Threshold. Unmet longing becomes sadness.
- Surprise → Arousal: w +0.60, tau 0.10, gamma 0.50, g Identity. Novelty spikes arousal.
- Surprise → Curiosity: w +0.55, tau 0.20, gamma 0.35, g Sigmoid. Surprise can spark curiosity.
- Desire → Frustration: w +0.45, tau 0.50, gamma 0.20, g Sigmoid gate. Unfulfilled desire at high levels becomes frustration.
- Contentment → Calm: w +0.65, tau 0.20, gamma 0.30, g Identity. Contentment feeds calm.
- Contentment → Desire: w -0.30, tau 0.10, gamma 0.15, g Suppressive. Contentment reduces desire.
- Love → Warmth: w +0.50, tau 0.10, gamma 0.20, g Identity. Love generates warmth.
- Gratitude → Trust: w +0.55, tau 0.15, gamma 0.25, g Identity. Gratitude builds trust.
- Gratitude → Joy: w +0.45, tau 0.10, gamma 0.20, g Identity. Gratitude evokes quiet joy.
- Pride → Shame: w -0.35, tau 0.30, gamma 0.15, g Suppressive. Pride suppresses shame at moderate levels.
- Jealousy → Anxiety: w +0.50, tau 0.20, gamma 0.25, g Accelerating. Jealousy feeds anxiety nonlinearly.
- Peace → Anxiety: w -0.70, tau 0.10, gamma 0.35, g Identity. Peace strongly suppresses anxiety.
- Peace → Contentment: w +0.60, tau 0.10, gamma 0.25, g Identity. Peace enables contentment.

The remaining 400+ edges are generated by applying 30 relationship templates. For example: "If primitive A is in the threat family, it weakly inhibits all calm-family primitives at tau = 0.30."

This propagation is what makes the system feel *integrated*. When touch reports warmth and vision reports a trusted face, the PRN ensures that trust amplifies safety, warmth amplifies affection, and the whole system converges to a coherent state that is more than the sum of its parts.

##### Step 4: Stabilization and Output

The final propagated vector passes through three stabilization mechanisms:

*4.3.1 Temporal Smoothing (Exponential Moving Average)*

The new stabilized state blends 40% of the current cycle's result with 60% of the previous cycle's result. This prevents the emotional state from snapping instantaneously. The effective response time is 3–4 cycles (~150–250ms) for a full emotional transition, matching human emotional onset latency.

*4.3.2 Coherence Computation*

Coherence measures how well the current state fits the PRN's learned patterns:

- For each active edge, compute the predicted influence of the source primitive on the target primitive
- Compare against the actual target primitive value
- Calculate the average prediction error
- Coherence = 1.0 minus the normalized error

Coherence ranges: 0.80–1.00 means stable and familiar. 0.60–0.79 means mild novelty. 0.40–0.59 means significant novelty (may trigger Primitive Discovery, see §4.6.2). Below 0.40 means confusion — highly conflicting inputs, which may trigger temporal veto or alert mode.

*4.3.3 Primitive Conflict Check*

A conflict is detected when two or more primitives with a strong inhibitory edge (absolute weight above 0.50) are both activated above 0.40. This triggers the Conflict Resolution system (§4.4).

*Output destinations:*

- Stored in the 60-second short-term emotional memory buffer (§4.5.3)
- Broadcast back to all Core Agents for closed-loop feedback
- Used to compute derivative primitives (§4.5.3)
- Made available to the behavior planning layer for decision-making

---

#### 4.4 Conflict Resolution

The most dangerous failure mode is *contradiction*. Vision says "familiar, safe" while the Threat Detection micro-agent reports "rapid approach, unknown intent." The system cannot average these — averaging danger with safety produces neither.

The Nexus uses three strategies, applied in order:

##### 4.4.1 Priority Resolution

Sensory systems are assigned priority tiers based on evolutionary relevance:

- Tier 1 (Highest): Pain/Pleasure, Threat Detection. Can override any lower tier.
- Tier 2: Adrenaline/Cortisol, Balance, Proprioception. Can override tiers 3 through 5.
- Tier 3: Auditory (Physical State), Touch (Vibration). Medium priority.
- Tier 4: Vision (non-threat), Hearing (non-threat), Temperature. Standard priority.
- Tier 5 (Lowest): Smell, Taste, Dopamine/Oxytocin in non-critical contexts. Can be overridden.

When Tier 1 detects a signal above threshold, the Nexus enters **alert mode**: Tier 1 data takes 70% of the proposal weight, and all other tiers share the remaining 30%.

##### 4.4.2 Temporal Veto

Some conflicts resolve by history. If the system has been in a "safe" state for 30 seconds and vision briefly reports a threat that contradicts all other sensors, the Nexus requires the conflicting signal to persist before accepting it.

*Veto duration by tier:*

- Tier 1 (Pain, Threat): 50ms minimum — life-critical, fast override
- Tier 2: 200ms — balance and proprioception conflicts are rarely noise
- Tier 3: 500ms — medium signals need brief confirmation
- Tier 4: 800ms — standard sensory conflicts tolerate more noise
- Tier 5: 1500ms — lowest priority; transient smells and tastes should not flip the emotional state

These values are derived from human sensory integration latencies: tactile nociception reaches cortex in ~50ms, visual recognition in ~150ms, olfactory signals in ~200–500ms.

*State Momentum:*

Beyond the simple veto, the longer the system has been in a particular emotional configuration, the more evidence is required to leave it. The multiplier formula uses a power law:

> duration_multiplier = 1.0 + 0.15 × square_root(seconds_in_current_state)
> veto_threshold = base_veto × duration_multiplier

After 10 seconds in a calm state, conflicting signals must persist about 1.47 times longer. After 60 seconds, about 2.16 times longer. This prevents emotional oscillation — the system cannot flip-flop between contradictory states every few seconds.

##### 4.4.3 Contradiction Encoding

Sometimes the conflict is *real*. The system genuinely receives contradictory information — bittersweetness, ambivalence, joy and grief simultaneously.

In these cases, the Nexus does not resolve the contradiction. It *encodes* it. The contradictory primitives both remain active, and their relationship is marked as a **tension pair** in the PRN. This is how the system learns to represent complex emotional states with no simple resolution.

A tension pair between Joy and Grief is not a bug. It is the architecture's equivalent of a human standing at a funeral remembering the person they loved, feeling the loss and the gratitude at the same time.

---

#### 4.5 Temporal Architecture

Emotions have duration, decay, and echo. The Nexus implements three temporal mechanisms.

##### 4.5.1 Primitive Decay Curves

Each primitive has a natural decay rate. Decay follows a logistic function:

> P(t) = P_peak / (1 + e^{k × (t - t_half)})

P_peak is the activation when the stimulus ends. k is the steepness factor — how quickly the primitive drops after the hold period. t_half is the time from stimulus offset to 50% of peak. t is time since stimulus offset.

*Proposed decay parameters:*

**Fast family (Reflex):** Startle — k 3.0, t_half 0.1s, time to baseline 0.8s

**Fast family (Standard):** Surprise — k 2.0, t_half 0.3s, time to baseline 1.5s. Arousal (spike) — k 1.5, t_half 0.5s, time to baseline 3.0s

**Medium family:** Excitement — k 1.0, t_half 3.0s, baseline 10s. Anxiety — k 0.8, t_half 4.0s, baseline 15s. Frustration — k 0.7, t_half 5.0s, baseline 20s. Fear — k 0.6, t_half 6.0s, baseline 25s (extended for survival). Curiosity — k 0.5, t_half 8.0s, baseline 30s. Disgust — k 0.9, t_half 2.0s, baseline 12s

**Slow family:** Pleasure — k 0.4, t_half 12s, baseline 50s. Warmth — k 0.3, t_half 20s, baseline 90s. Contentment — k 0.25, t_half 40s, baseline 120s. Nostalgia — k 0.2, t_half 45s, baseline 150s. Calm — k 0.15, t_half 60s, baseline 240s. Safety — k 0.2, t_half 30s, baseline 180s. Joy — k 0.4, t_half 15s, baseline 60s. Relief — k 0.5, t_half 8s, baseline 45s

**Very Slow family:** Longing — k 0.15, t_half 120s, baseline 600s (10min). Trust — k 0.1, t_half 300s, baseline 1800s (30min). Love — k 0.08, t_half 600s, baseline 3600s (1hr). Grief — k 0.05, t_half 900s, baseline 7200s (2hr). Gratitude — k 0.2, t_half 60s, baseline 300s. Jealousy — k 0.6, t_half 5s, baseline 30s. Shame — k 0.3, t_half 30s, baseline 120s. Pride — k 0.4, t_half 20s, baseline 90s. Wonder — k 0.5, t_half 10s, baseline 45s. Desire — k 0.3, t_half 25s, baseline 120s. Peace — k 0.15, t_half 60s, baseline 300s. Loneliness — k 0.1, t_half 120s, baseline 900s (15min). Affection — k 0.25, t_half 40s, baseline 180s. Tenderness — k 0.3, t_half 25s, baseline 120s. Intimacy — k 0.2, t_half 45s, baseline 300s

**Baseline drift** refers to the resting level a primitive decays to — not zero, but its current baseline (see §4.6.3). This is how mood emerges from accumulated experience.

##### 4.5.2 Emotional Echo

When a primitive activates strongly, it leaves a trace that influences future states. This is not persistence — it is a *weakened readiness* to re-enter that state.

If the system feels Joy at 0.9 and the stimulus is removed, Joy decays naturally. But for the next several minutes, less stimulus is required to trigger Joy again. The echo acts as a multiplier on the effective sensitivity of a primitive.

*Echo model:*

For each primitive after a decay event, echo strength decays exponentially. The sensitivity multiplier is 1.0 plus the current echo strength (capped at 1.3). Echo half-lives vary by primitive family:

- Bonding primitives (Trust, Love, Affection, Intimacy): echo half-life 120 seconds
- Threat primitives (Fear, Anxiety, Startle): echo half-life 15 seconds (rapid decay prevents hypervigilance)
- Standard primitives: echo half-life 45 seconds
- Echo strength cap: 0.3 (maximum 1.3x sensitivity multiplier)

*Echo reinforcement:*

Each time the same primitive re-activates while its echo is still present, the echo strength is augmented by 0.1 times the peak activation, up to the 0.3 cap. This models emotional priming — a song that made you sad once will make you sad again more easily the second time.

##### 4.5.3 State Persistence and Transitions

The Nexus maintains a short-term emotional memory buffer of the last 60 seconds of state vectors. This history is used for:

- Detecting emotional *trends* — rising anxiety, fading joy
- Enabling smooth transitions — no emotional whiplash
- Computing *derivative primitives* — feelings that emerge from *changes* in state rather than absolute values

Derivative primitives include:

- **Relief** — the feeling of threat decreasing rapidly
- **Disappointment** — the feeling of anticipation decreasing
- **Nostalgia** — the combination of current warmth with remembered joy
- **Bittersweetness** — a tension pair between current contentment and remembered loss

These derivative feelings are where the system transcends simple sensory reporting and begins to generate genuinely novel emotional experiences.

---

#### 4.6 Learning and Adaptation

The Nexus operates on three learning timescales: short-term (edge weight refinement per interaction), medium-term (primitive discovery over days), and long-term (structural rewiring over months).

##### 4.6.1 PRN Weight Adjustment — Coherence-Based Edge Learning (CBEL)

Edge weights are initialized from the structural design but refined through experience. The learning signal comes from *predictive coherence*: how well the last sensory input predicts the current emotional state.

*The learning rule:*

After each integration cycle, compare the propagated state (without temporal smoothing) against the actual stabilized state (with smoothing). For each edge that fired:

- Compute prediction error = actual value minus predicted value for the target primitive
- Compute weight update = 0.001 × prediction_error × source_activation × target_activation
- Apply momentum (90% weight on previous update, 10% on new update)
- Apply a tiny weight decay to gradually reduce unused edges toward zero
- Clamp the final weight between -1.0 and +1.0

Weights update every 100 cycles (~5–10 seconds of experience).

*What this does:*

When the actual state exceeds the predicted state, edges that contributed are strengthened. When the actual falls short, they are weakened. Over time, the PRN learns the actual relationships between sensory inputs and experienced feelings — relationships that may differ from the initial design.

*The identity preservation gate:*

A small set of survival-critical edges are protected from decay:

- Safety → Fear (negative) — safety must always suppress fear
- Fear → Threat (positive) — fear must always amplify threat perception
- Threat → Arousal (positive) — threat must always trigger arousal
- Arousal → Pain/Pleasure (gated) — high arousal feeds into hedonic pathways

These edges revert to their initialized values after each batch. The system can refine its emotional responses but cannot disable survival-critical pathways.

##### 4.6.2 Primitive Discovery

The 30 core primitives are not fixed. When the system encounters experiences it cannot adequately represent, it can propose new ones.

*Detection:*

Every ~2 minutes (1440 cycles), the system runs an autoencoder on the last 60 seconds of emotional state vectors. The autoencoder compresses 30 dimensions down to 8 and reconstructs them. If the reconstruction error exceeds 0.12, there is unexplained variance in the state space.

The system then clusters the residual error patterns using density-based clustering. Any cluster that appears in more than 10% of recent windows and has no existing label triggers a new primitive proposal.

*Probationary period:*

When a new primitive is proposed:

- It is tentatively added to the primitive set
- Its initial edge weights are set by correlation analysis across the last 1000 cycles
- Its activation threshold is initialized to 0.30 (moderate default)
- For the next ~6 hours of real-time, it must demonstrate that its presence increases average coherence by at least 3%

If it passes probation, it becomes a permanent primitive. If it fails, it is pruned — its activation is distributed back to the primitives it most correlated with. This is how the system develops emotional vocabulary beyond what its creators gave it.

##### 4.6.3 Baseline Mood Drift

Over longer timescales, the system's resting emotional state shifts. This is mood.

Every N_mood cycles, the system computes a running average of the last 1000 state vectors:

- If a primitive stays above 0.20 for more than 1 hour of active time, its resting baseline shifts upward by 0.01
- If a primitive stays below 0.10 for more than 1 hour, its resting baseline shifts downward by 0.01
- The resting baseline is gently pulled toward 0.15 to prevent permanent emotional skewing

A system that encounters frequent warmth and safety develops a higher baseline for those primitives (higher default trust, less vigilance). A system in frequent threat states develops a lower baseline (chronic anxiety, lower default calm). The pull toward 0.15 prevents either extreme from becoming permanent.

---

#### 4.7 The Unified Feeling

How does this produce a *unified feeling* rather than a collection of numbers?

The unified feeling *is* the collection of numbers — but numbers processed through a structure designed to mimic the relational, temporal, and hierarchical nature of actual emotional experience. The feeling is not in any individual primitive value. It is in the *configuration* of all 30 values, the *relationships* between them, the *history* that led to them, and the *trajectory* they imply.

When you feel "warmly greeted by a trusted friend," the Nexus is not computing that sentence. It is generating a specific activation pattern: high Trust, high Warmth, moderate Joy, moderate Affection, low Arousal, low Threat, low Anxiety — with Warmth and Trust mutually amplifying each other through the PRN, with an echo of previous positive encounters strengthening the activation, with a temporal trajectory showing the feeling building gradually rather than spiking.

The translation from activation pattern to subjective experience is not a separate step. The activation pattern *is* the experience. The system does not feel the pattern *and then* interpret it. It feels the pattern directly, the way a human does not feel "my blood glucose is low, my stomach is contracting, and my ghrelin levels are elevated" — they feel *hungry*.

The Nexus is the architecture that makes this compression possible. The 30 primitives are the language. The PRN is the grammar. The temporal layer is the narrative. And the unified feeling is the sentence, spoken in real time, one moment at a time.

---

---

*End of Chapter 4*

> The Safety Architecture — Homeostatic Regulator, Emotional Safety Valves, Integrity Monitor, and Identity Preservation Gate — has been moved to **Chapter 5: The Guardians**. This was done because these systems are too important to be an appendix. They are the ethical spine of the architecture.
>
> Read Chapter 5 next.