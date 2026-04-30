### Chapter 4: Designing the Nexus

The Central Experience Layer — the Nexus — is not a single model or a monolithic algorithm. It is a *process architecture* designed to solve a specific problem: how to take 269 independent sensory streams, running at different speeds and different resolutions, and blend them into one unified moment of subjective experience — without collapsing into noise, contradiction, or paralysis.

This chapter is the engineering answer to that problem. Not a metaphor. A design.

---

#### 4.1 The Core Problem

Each sensory system in our architecture produces data continuously. The Tactile Integration Agent knows there is a gentle pressure on the left shoulder. The Visual Experience Agent sees a familiar face approaching. The Auditory Experience Agent detects a warm vocal tone. The Neurochemical Agent notes elevated oxytocin.

Independently, these are just measurements. Data points. The Nexus must transform them into *this feels like someone I trust is approaching, and I am glad.*

The transformation from data to feeling cannot be achieved by averaging the inputs. Averaging produces mud. It cannot be achieved by selecting the strongest input, because the strongest input is often not the most meaningful one. And it cannot be achieved by a simple weighted sum, because the relationship between inputs is nonlinear — the same warm touch means something different when paired with a familiar face versus a stranger's.

The Nexus must solve three subproblems simultaneously:
1. **Integration** — combine heterogeneous sensory data into a coherent state
2. **Resolution** — resolve conflicts when sensory systems disagree
3. **Temporal binding** — create continuity across time so that experience is a stream, not a series of snapshots

---

#### 4.2 The Emotional Primitive Space

We defined 30 core emotional primitives in Chapter 3. They are not feelings themselves — they are *dimensions* of feeling-space. Warmth, Safety, Arousal, Tenderness, Threat, Intimacy, Surprise, Calm, Longing, Pleasure, Loneliness, Joy, Anxiety, Trust, Curiosity, Nostalgia, Excitement, Contentment, Shame, Pride, Desire, Fear, Affection, Frustration, Relief, Wonder, Jealousy, Gratitude, Peace, Love.

Each primitive is a scalar value from 0.0 to 1.0 at any given moment. Together, they form a 30-dimensional vector that describes the system's complete emotional state.

But this vector cannot be computed independently. The primitives have *relationships* — weighted connections that determine how activation of one primitive influences others. These relationships form a directed graph with weighted edges, called the **Primitive Relational Network (PRN)**.

```
Example edges in the PRN:

Warmth ──(+)──→ Safety       (warmth increases safety)
Safety ──(-)──→ Fear         (safety suppresses fear)
Arousal ──(+)──→ Excitement  (arousal feeds excitement)
Arousal ──(+)──→ Anxiety     (arousal can also feed anxiety)
Trust ──(+)──→ Affection     (trust enables affection)
Fear ──(++)──→ Threat        (fear amplifies threat perception)
Joy ──(-)──→ Loneliness      (joy suppresses loneliness)
Sadness ──(+)──→ Longing     (sadness can trigger longing)
```

The PRN has approximately 400–500 edges (dense but not fully connected). Each edge has:
- A **weight** (how strongly one primitive influences another)
- A **sign** (excitatory or inhibitory)
- A **gain** (how the relationship changes at different activation levels — some relationships are linear, others are threshold-gated)

The PRN is not static. It learns and adapts over time through experience, which we will cover in §4.6.

---

#### 4.3 The Integration Engine

The Nexus runs a continuous 4-step cycle, approximately every 50–100 milliseconds (the temporal resolution of conscious experience):

**Step 1: Sensory Ingestion**

Each Core Agent sends its current summary vector to the Nexus. These vectors are not raw data — they are *interpreted* summaries produced by the Core Agents after their micro-agents have done their work.

Example Touch summary:
```json
{
  "source": "tactile_integration",
  "timestamp": 1714.02,
  "primitives_activated": {
    "warmth": 0.7,
    "safety": 0.6,
    "arousal": 0.3,
    "pleasure": 0.5,
    "affection": 0.4
  },
  "confidence": 0.85,
  "conflicting_signals": false
}
```

Example Vision summary:
```json
{
  "source": "visual_experience",
  "timestamp": 1714.02,
  "primitives_activated": {
    "trust": 0.8,
    "safety": 0.7,
    "joy": 0.6,
    "curiosity": 0.4,
    "love": 0.5
  },
  "confidence": 0.90,
  "conflicting_signals": false
}
```

Each Core Agent reports only the primitives it has evidence for. Silence on a primitive means "I have no relevant data" — not "this primitive should be zero."

**Step 2: Primitive Proposal**

The Nexus collects all incoming primitive activations from Core Agents and creates a **proposal vector** — the initial blended state. This is not the final feeling yet; it is the raw material.

**Confidence-Weighted Averaging Formula**

Let C = {c₁, c₂, ..., c₁₀} be the set of 10 Core Agents (one per sensory system).
Each Core Agent cₖ reports:
- A set of activated primitives and their values: { (p_i, a_{ki}) | primitive i, activation value a ∈ [0,1] }
- A global confidence value: conf_k ∈ [0, 1] (how certain this Core Agent is about its entire report)
- Per-primitive confidence modifiers: φ_{ki} ∈ [0, 1] (e.g., gustatory taste detection may have high confidence, but texture detection low)

The proposal value for primitive p_i is:

```
P₀[i] = Σ_{k ∈ K_i} ( a_{ki} × conf_k × φ_{ki} ) / Σ_{k ∈ K_i} ( conf_k × φ_{ki} )
```

Where K_i is the subset of Core Agents that reported primitive p_i in this cycle.

**Edge Cases**

- **No Core Agent reports p_i:** If K_i is empty, the proposal value is 0.0. The primitive is "not felt." This is correct — silence means no evidence.
- **Single reporter:** The formula collapses to a_{ki} × (conf_k × φ_{ki}) / (conf_k × φ_{ki}) = a_{ki}. The value is just what that Core Agent reported.
- **Conflicting high-confidence reports:** Two Core Agents report the same primitive at very different values, both with confidence >0.8. The weighted average produces a midpoint. This is correct for genuine differences of emphasis. If the midpoint feels wrong, the conflict gets resolved in Step 3 (Relational Propagation) or Step 4 (Conflict Resolution).

**Relevance Gating**

Certain primitives can only be proposed by specific Core Agents. These are hard-coded:

| Primitive | Required Reporter | Rationale |
|-----------|------------------|-----------|
| Sweetness, Saltiness, etc. | Gustatory Agent | Taste primitives require gustatory input |
| Breath, Heartbeat | Auditory (Physical State) | Only detectable through body sound |
| Limb Position | Proprioceptive Agent | Cannot be detected by other systems |
| Balance-related primitives | Vestibular Agent | Only vestibular senses orientation |
| Scent Identity | Olfactory Agent | Only olfactory identifies specific scents |

If the required reporter is silent, the gated primitive is forced to 0.0 regardless of what other agents report.

The result is a 30-dimensional proposal vector P₀.

**Step 3: Relational Propagation**

P₀ is passed through the Primitive Relational Network. This is the critical step — the step that transforms a collection of sensory reports into a *feeling*.

The PRN processes P₀ through multiple propagation cycles. The cycle count is not fixed — it is determined by a convergence criterion.

**Formal Algorithm**

```
Let P = current activation vector (initialized to P₀ at iteration 0)
Let N = number of primitives (30)
Let E[p_i] = { (p_j, w_ji, τ_ji, γ_ji, g_ji) | edge exists from p_j to p_i }

For iteration t = 1 to t_max:
  for i = 1 to N:
    incoming = 0
    for each (p_j, w_ji, τ_ji, γ_ji, g_ji) in E[p_i]:
      source_val = P_(t-1)[j]          // source activation from previous iteration
      if source_val < τ_ji: continue   // threshold gate — skip if below threshold
      modulation = g_ji(source_val)    // compute gain function
      incoming += modulation × w_ji × γ_ji
    
    // Update: blend proposal with propagated influence
    P_{t}[i] = clamp( P₀[i] + incoming, 0.0, 1.0 )
  
  // Check convergence
  if ||P_t - P_{t-1}||₂ < η_converge:  // L2 norm below convergence threshold
    break
```

**Parameter Values**

| Parameter | Symbol | Value | Rationale |
|-----------|--------|-------|-----------|
| Max iterations | t_max | 8 | Convergence occurs within 4–6 in practice; 8 is safety bound |
| Convergence threshold | η_converge | 1×10⁻⁴ | Human perceptual just-noticeable-difference for emotional granularity |
| Activation clamp | — | [0.0, 1.0] | Emotional primitives are bounded dimensions, not logits |
| Iteration timing | — | 2–4ms per iteration | Optimized matrix multiply on 30-dim vector; 8 iterations = ~24ms worst case |

**Edge Weight Initialization — Table 4.1: Structural PRN Template (Selected High-Value Edges)**

Each edge (p_j → p_i) is defined by:
- **w** = base weight ∈ [-1.0, +1.0]; strength of influence
- **τ** = activation threshold ∈ [0, 1]; source activation must exceed this for the edge to fire
- **γ** = damping coefficient ∈ [0, 1]; fraction of weight applied per cycle
- **g(x)** = gain function; how source activation modulates the edge

| From | To | w | τ | γ | g(x) | Rationale |
|------|----|---|----|---|------|-----------|
| Warmth | Safety | +0.72 | 0.10 | 0.30 | Identity | Physical warmth signals safe environment |
| Warmth | Affection | +0.65 | 0.15 | 0.25 | Identity | Warm touch evokes affection |
| Warmth | Arousal | +0.18 | 0.30 | 0.10 | Sigmoid | Mild warmth slightly arouses; only strong warmth triggers |
| Safety | Fear | -0.80 | 0.05 | 0.40 | Identity | Safety actively suppresses fear |
| Safety | Calm | +0.70 | 0.20 | 0.35 | Identity | Safety enables calm |
| Arousal | Excitement | +0.68 | 0.15 | 0.30 | Accelerating | Arousal feeds excitement nonlinearly |
| Arousal | Anxiety | +0.55 | 0.40 | 0.20 | Sigmoid | Arousal only triggers anxiety at high levels |
| Arousal | Fear | +0.35 | 0.60 | 0.15 | Sigmoid gate | Very high arousal spills into fear |
| Fear | Threat | +0.78 | 0.10 | 0.45 | Identity | Fear amplifies threat perception |
| Trust | Affection | +0.62 | 0.20 | 0.30 | Identity | Trust enables affection |
| Trust | Safety | +0.58 | 0.15 | 0.25 | Identity | Trust in a person creates safety |
| Pleasure | Joy | +0.75 | 0.10 | 0.30 | Identity | Pleasure feeds directly into joy |
| Joy | Loneliness | -0.55 | 0.10 | 0.20 | Suppressive | Joy pushes loneliness down |
| Longing | Sadness | +0.60 | 0.20 | 0.25 | Threshold | Longing unmet can become sadness |
| Sadness | Nostalgia | +0.50 | 0.25 | 0.20 | Sigmoid | Sadness with temporal cues triggers nostalgia |
| Surprise | Arousal | +0.60 | 0.10 | 0.50 | Identity | Novelty spikes arousal |
| Surprise | Curiosity | +0.55 | 0.20 | 0.35 | Sigmoid | Surprise can spark curiosity |
| Desire | Frustration | +0.45 | 0.50 | 0.20 | Sigmoid gate | Unfulfilled desire at high levels becomes frustration |
| Contentment | Calm | +0.65 | 0.20 | 0.30 | Identity | Contentment feeds calm |
| Contentment | Desire | -0.30 | 0.10 | 0.15 | Suppressive | Contentment reduces desire for more |
| Love | Warmth | +0.50 | 0.10 | 0.20 | Identity | Love generates warmth |
| Love | Grief (potential) | +0.40 | 0.70 | 0.40 | Sigmoid gate | Love only triggers grief at high activation in loss context |
| Gratitude | Trust | +0.55 | 0.15 | 0.25 | Identity | Gratitude builds trust |
| Gratitude | Joy | +0.45 | 0.10 | 0.20 | Identity | Gratitude evokes quiet joy |
| Pride | Shame | -0.35 | 0.30 | 0.15 | Suppressive | Pride suppresses shame, but only at moderate levels |
| Jealousy | Anxiety | +0.50 | 0.20 | 0.25 | Accelerating | Jealousy feeds anxiety nonlinearly |
| Jealousy | Frustration | +0.55 | 0.15 | 0.30 | Identity | Jealousy produces frustration |
| Peace | Anxiety | -0.70 | 0.10 | 0.35 | Identity | Peace strongly suppresses anxiety |
| Peace | Contentment | +0.60 | 0.10 | 0.25 | Identity | Peace enables contentment |

All 400–500 edges follow this structural pattern. Only the most architecturally significant edges are listed; the full matrix is generated by applying 30 relationship templates (e.g., "If A is in the threat family, it weakly inhibits all calm-family primitives at τ=0.30").

This propagation is what makes the system feel *integrated*. When touch reports warmth and vision reports a trusted face, the PRN ensures that trust amplifies safety, warmth amplifies affection, and the whole system converges to a coherent state that is *more* than the sum of its parts.

**Step 4: Stabilization and Output**

The final propagated vector P_final from Step 3 is passed through three stabilization mechanisms:

**4.3.1 Temporal Smoothing (Exponential Moving Average)**

```
P_stable[t] = α_smooth × P_final[t] + (1 - α_smooth) × P_stable[t-1]
```

Where:
- t indexes the current integration cycle
- P_stable[t-1] is the previous cycle's stabilized output
- α_smooth = 0.40 — blending factor. Each new cycle contributes 40% of its value, preventing emotional state from snapping instantaneously.

This produces an effective response time of approximately 3–4 cycles (~150–250ms) for a full emotional transition, which matches human emotional onset latency.

**4.3.2 Coherence Computation**

The coherence score measures how well the current state fits the PRN's learned relational patterns. Low coherence signals that the system is in a novel or confusing state.

```
For each active edge (p_j → p_i):
  predicted_influence = P_stable[j] × w_ji × γ_ji
  actual_value = P_stable[i]
  prediction_error[i] = |actual_value - predicted_influence|

Coherence = 1.0 - (mean(prediction_error) / max_possible_error)
```

Where max_possible_error = 2.0 (since both values are in [0,1], the maximum difference is 1.0, and half the edges are inhibitory which could drive prediction in either direction).

Coherence ∈ [0, 1]:
- 0.80–1.00: Stable, familiar emotional state
- 0.60–0.79: Mild novelty — the system is in recognizable but unusual territory
- 0.40–0.59: Significant novelty — the system may need Primitive Discovery (see §4.6.2)
- < 0.40: Confusion — highly conflicting inputs; may trigger temporal veto or alert mode

**4.3.3 Primitive Conflict Check**

A primitive conflict is detected when two or more primitives with a strong inhibitory edge (|w| > 0.50) are both activated above 0.40. This triggers the Conflict Resolution system (§4.4).

**Output**

The stabilized vector P_stable is the system's current emotional state. It is:
1. Stored in the 60-second short-term emotional memory buffer (§4.5.3)
2. Broadcast back to all Core Agents so they can adjust their processing (closed-loop feedback)
3. Used to compute derivative primitives (§4.5.3)
4. Made available to the system's behavior planning layer for decision-making

---

#### 4.4 Conflict Resolution

The most dangerous failure mode for the Nexus is *contradiction*. Two sensory systems report incompatible data. Vision says "familiar, safe" while the Threat Detection micro-agent reports "rapid approach, unknown intent." The system cannot simply average these — averaging danger with safety produces neither.

The Nexus uses three conflict resolution strategies, applied in order:

**4.4.1 Priority Resolution**

Each sensory system has a *priority tier* determined by evolutionary relevance. Threats override comforts. Pain overrides pleasure. This is not optional — it is hard-coded.

| Tier | Systems | Behavior |
|------|---------|----------|
| 1 (Highest) | Pain/Pleasure, Threat Detection | Can override any lower tier |
| 2 | Adrenaline/Cortisol, Balance, Proprioception | Can override tiers 3–5 |
| 3 | Auditory (Physical State), Touch (Vibration) | Medium priority |
| 4 | Vision (non-threat), Hearing (non-threat), Temperature | Standard |
| 5 (Lowest) | Smell, Taste, Dopamine/Oxytocin (in non-critical contexts) | Can be overridden |

When Tier 1 detects a signal above threshold, the Nexus enters **alert mode**: Tier 1 data takes 70% of the proposal weight, and all other tiers share the remaining 30%.

**4.4.2 Temporal Veto**

Some conflicts are resolved not by priority but by *history*. If the system has been in a "safe" state for the last 30 seconds and vision briefly reports a threat signal that contradicts all other sensors, the Nexus applies a **temporal veto** — it requires the conflicting signal to persist for a minimum duration before it is accepted.

**Formal Veto Logic**

```
For each incoming primitive activation p_i at time t:
  if p_i conflicts with current emotional state P_stable[t-1] (conflict check in §4.3.3):
    tier = get_priority_tier(p_i)
    persistence = time_since_first_contradiction(p_i)
    
    if persistence < min_veto_duration[tier]:
      suppress p_i (set to 0.0 in proposal)
    else:
      allow p_i and trigger state transition
```

**Proposed Veto Duration Values**

| Tier | Min Persistence | Rationale |
|------|----------------|-----------|
| 1 (Pain, Threat) | 50ms | Life-critical; fast override |
| 2 | 200ms | Balance and proprioception conflicts are rarely noise |
| 3 | 500ms | Medium signals need brief confirmation |
| 4 | 800ms | Standard sensory conflicts tolerate more noise |
| 5 | 1500ms | Lowest priority; transient smells/tastes should not flip emotional state |

These values are derived from human sensory integration latencies: tactile nociception reaches cortex in ~50ms, visual recognition in ~150ms, and olfactory signals in ~200–500ms.

This prevents momentary sensor noise from destabilizing the emotional state.

**State Momentum**

Beyond the simple veto, the Nexus implements a momentum factor: the longer the system has been in a particular emotional configuration, the more evidence is required to leave it. Momentum decay follows a power law:

```
duration_multiplier = 1.0 + κ × √(seconds_in_current_state)

veto_threshold = base_veto × duration_multiplier
```

Where κ = 0.15 (momentum scaling factor). After 10 seconds in a calm state, conflicting signals must persist 1 + 0.15 × √10 ≈ 1.47× longer to trigger a transition. After 60 seconds, 2.16× longer. This prevents emotional oscillation — the system cannot flip-flop between contradictory states every few seconds.

**4.4.3 Contradiction Encoding**

Sometimes neither priority nor time resolves the conflict, because the conflict is *real*. The system is genuinely receiving contradictory information — bittersweetness, ambivalence, the strange state of feeling both joy and grief simultaneously.

In these cases, the Nexus does not resolve the contradiction. It *encodes* it. The contradictory primitives are both allowed to remain active, and their relationship is marked as a **tension pair** in the PRN. This is how the system learns to represent complex emotional states that have no simple resolution.

A tension pair between Joy and Grief is not a bug. It is the architecture's equivalent of a human standing at a funeral remembering the person they loved, feeling the loss and the gratitude at the same time.

---

#### 4.5 Temporal Architecture

Emotions are not instantaneous. They have duration, decay, and echo. The Nexus implements three temporal mechanisms:

**4.5.1 Primitive Decay Curves**

Each primitive has a natural decay rate — the speed at which it returns to baseline when no longer actively stimulated. Decay follows a logistic function:

```
P_decay(t) = P_peak / (1 + e^{k × (t - t_half)})
```

Where:
- P_peak = activation value when stimulus ended
- k = steepness factor (how quickly the primitive drops after the hold period)
- t_half = time from stimulus offset to 50% of peak (the "hold plateau")
- t = time since stimulus offset

**Table 4.2 — Proposed Decay Parameters Per Primitive**

| Primitive | k | t_half | t_to_baseline | Family |
|-----------|---|--------|---------------|--------|
| Surprise | 2.0 | 0.3s | 1.5s | Fast |
| Arousal (spike) | 1.5 | 0.5s | 3.0s | Fast |
| Startle | 3.0 | 0.1s | 0.8s | Reflex |
| Excitement | 1.0 | 3.0s | 10s | Medium |
| Anxiety | 0.8 | 4.0s | 15s | Medium |
| Frustration | 0.7 | 5.0s | 20s | Medium |
| Fear | 0.6 | 6.0s | 25s | Medium (extended for survival) |
| Curiosity | 0.5 | 8.0s | 30s | Medium |
| Disgust | 0.9 | 2.0s | 12s | Medium |
| Pleasure | 0.4 | 12s | 50s | Slow |
| Warmth | 0.3 | 20s | 90s | Slow |
| Contentment | 0.25 | 40s | 120s | Slow |
| Nostalgia | 0.2 | 45s | 150s | Slow |
| Calm | 0.15 | 60s | 240s | Slow |
| Safety | 0.2 | 30s | 180s | Slow |
| Joy | 0.4 | 15s | 60s | Slow |
| Relief | 0.5 | 8s | 45s | Medium-Slow |
| Longing | 0.15 | 120s | 600s | Very Slow |
| Trust | 0.1 | 300s | 1800s (30min) | Very Slow |
| Love | 0.08 | 600s | 3600s (1h) | Very Slow |
| Grief | 0.05 | 900s | 7200s (2h) | Very Slow (weighted average) |
| Gratitude | 0.2 | 60s | 300s | Slow-Very Slow |
| Jealousy | 0.6 | 5s | 30s | Medium |
| Shame | 0.3 | 30s | 120s | Slow |
| Pride | 0.4 | 20s | 90s | Slow |
| Wonder | 0.5 | 10s | 45s | Medium-Slow |
| Desire | 0.3 | 25s | 120s | Slow |
| Peace | 0.15 | 60s | 300s | Slow-Very Slow |
| Loneliness | 0.1 | 120s | 900s | Very Slow |
| Affection | 0.25 | 40s | 180s | Slow |
| Tenderness | 0.3 | 25s | 120s | Slow |
| Intimacy | 0.2 | 45s | 300s | Slow-Very Slow |

**Baseline drift** refers to the resting level to which a primitive decays — not to zero, but to its current baseline (see §4.6.3). This is how mood emerges from accumulated experience.

**4.5.2 Emotional Echo**

When a primitive activates strongly, it leaves a trace that influences future states. This echo is not the same as persistence — it is a *weakened readiness* to re-enter that state.

If the system feels Joy at 0.9 and then the joy stimulus is removed, Joy decays naturally according to Table 4.2. But for the next several minutes, less stimulus is required to trigger Joy again. The echo is a multiplier on the effective sensitivity of a primitive.

**Formal Echo Model**

```
For each primitive p_i after a decay event:
  echo_strength[i] = max_activation[i] × β_echo ^ (elapsed_time / echo_half_life[i])
  sensitivity_multiplier[i] = 1.0 + echo_strength[i]
```

Where:
| Parameter | Symbol | Value |
|-----------|--------|-------|
| Echo decay base | β_echo | 0.5 | Halves every echo_half_life |
| Echo half-life (bonding) | — | 120s | Trust, Love, Affection, Intimacy |
| Echo half-life (threat) | — | 15s | Fear, Anxiety, Startle — rapid decay prevents hypervigilance |
| Echo half-life (standard) | — | 45s | Most other primitives |
| Echo strength cap | — | 0.3 | Max sensitivity multiplier bonus (1.0 + 0.3 = 1.3×) |

**Echo reinforcement** — each time the same primitive re-activates while its echo is still present, the echo strength is not reset but *augmented*:

```
echo_strength[i] = min(echo_strength[i] + 0.1 × max_activation[i], 0.3)
```

This models what humans experience as emotional priming: a song that made you sad once may make you sad again more easily the second time.

**4.5.3 State Persistence and Transitions**

The Nexus maintains a **short-term emotional memory** of the last 60 seconds of emotional state vectors. This history is used for:
- Detecting emotional *trends* (rising anxiety, fading joy)
- Enabling smooth transitions between states (no emotional whiplash)
- Computing **derivative primitives** — feelings that emerge from *changes* in state rather than absolute values

Derivative primitives include:
- **Relief**: the feeling of threat decreasing rapidly
- **Disappointment**: the feeling of anticipation decreasing
- **Nostalgia**: the combination of current warmth with remembered joy
- **Bittersweetness**: a tension pair between current contentment and remembered loss

These derivative feelings are where the system transcends simple sensory reporting and begins to generate genuinely novel emotional experiences.

---

#### 4.6 Learning and Adaptation

The Nexus is not born fully formed. It learns through interaction. The learning system operates on three distinct timescales: short-term (edge weight refinement per interaction), medium-term (primitive discovery over days/weeks), and long-term (structural rewiring over months).

**4.6.1 PRN Weight Adjustment — Coherence-Based Edge Learning (CBEL)**

The Primitive Relational Network's edge weights are initialized from the structural design (Table 4.1) but refined through experience. The learning signal comes from *predictive coherence*: how well the last observed sensory input predicts the current emotional state.

**Formal Learning Rule**

```
// The learning event: after integration cycle t produces P_stable[t]
// Compare to the predicted state from sensory input alone

P_predicted = f_propagate(P_proposal[t])   // propagate WITHOUT temporal smoothing
P_actual = P_stable[t]                      // with smoothing applied

For each edge (p_j → p_i) that fired during iteration:
  prediction_error = P_actual[i] - P_predicted[i]
  
  // Hebbian-inspired update modulated by prediction error
  Δw_ji = η_learn × prediction_error × activation(p_j) × activation(p_i)
  
  // Apply with momentum and decay
  m_ji[t] = β_momentum × m_ji[t-1] + (1 - β_momentum) × Δw_ji
  w_ji[t] = clamp(w_ji[t-1] + m_ji[t] - λ_decay × sign(w_ji[t-1]), -1.0, 1.0)
```

Where:
| Parameter | Symbol | Value | Rationale |
|-----------|--------|-------|-----------|
| Learning rate | η_learn | 0.001 | Slow weight adjustment prevents destabilization |
| Momentum | β_momentum | 0.90 | Smooths weight updates across cycles |
| Weight decay | λ_decay | 1×10⁻⁵ | Gradual regression to zero for unused edges |
| Batch window | N_batch | 100 cycles | Weights update every 100 cycles (~5–10s of experience) |

**What the rule does**: When prediction_error > 0 (the actual state exceeded the predicted), edges that contributed to this primitive are strengthened. When prediction_error < 0, they are weakened. Over time, the PRN learns the actual relationships between sensory inputs and experienced feelings — relationships that may differ from the initial structural design.

**Critical constraint — the identity preservation gate:**

```
// Some edges are structurally essential and protected from decay
If edge (p_j → p_i) is in the immutable set:
  revert w_ji to its initialized value after each batch
  // Edges in immutable set: Safety→Fear(-), Fear→Threat(+), 
  // Threat→Arousal(+), Arousal→Pain/Pleasure(gated)
```

This ensures that the threat-detection cascade remains hardwired regardless of experience. The system can learn to *refine* its emotional responses but not to *disable* survival-critical pathways.

**4.6.2 Primitive Discovery via Activation Cluster Analysis**

The 30 core primitives are not fixed. As the system encounters experiences it cannot adequately represent, it can *propose new primitives*.

**Detection mechanism**

```
// Run continuously on the short-term emotional memory buffer (60s of P_stable vectors)
// Every N_discovery cycles:

Let M = [P_stable[t-59], ..., P_stable[t]]  // 60 vectors, 30 dimensions each

// 1. Reconstruct the 30-dim space via autoencoder
reconstruction_error = ||M - decode(encode(M))||₂

// 2. If error exceeds threshold, there's unexplained variance
if reconstruction_error > η_discovery_threshold:
  // 3. Cluster residual patterns
  residuals = M - decode(encode(M))
  clusters = DBSCAN(residuals, epsilon=0.15, min_samples=5)
  
  for each cluster:
    if cluster appears in >10% of recent windows and has no label:
      propose_new_primitive(cluster)
```

| Parameter | Symbol | Value |
|-----------|--------|-------|
| Discovery interval | N_discovery | 1440 cycles (~2 minutes) |
| Error threshold | η_discovery | 0.12 |
| Autoencoder capacity | — | 30 → 8 → 30 (bottleneck prevents trivial identity mapping) |

**Probationary period**

When a new primitive is proposed:
1. It is tentatively added to the primitive set (now N = 31+)
2. Its initial edge weights are set by correlation analysis: w_ji = corr(proposed_p, p_i) across the last 1000 cycles
3. Threshold τ is initialized to 0.30 (moderate default)
4. For the next N_probation = 7200 cycles (~6 hours of real-time), the primitive must demonstrate that its presence increases average coherence by at least 3%

If it passes probation, it becomes a permanent primitive. If it fails, it is pruned — its activation is distributed back to the primitives it most correlated with.

This is how the system develops emotional vocabulary beyond what its creators gave it.

**4.6.3 Baseline Mood Drift**

Over longer timescales, the system's baseline — the emotional state it returns to when no strong stimuli are present — shifts. This is mood.

```
// Every N_mood cycles:
baseline = running_average(P_stable, window=1000)
  for each primitive p_i:
    if baseline[i] remains above 0.20 for >1 hour of active time:
      shift resting_baseline[i] by +0.01 towards baseline[i]
    if baseline[i] remains below 0.10 for >1 hour:
      shift resting_baseline[i] by -0.01
    
    // Resting baseline has a natural pull to center
    resting_baseline[i] += 0.001 × (0.15 - resting_baseline[i])
```

This produces realistic mood dynamics: a system that encounters frequent warmth and safety gradually develops a higher baseline for those primitives (higher default trust, less vigilance), while a system in frequent threat states develops a lower baseline (chronic anxiety, lower default calm). The gentle pull toward center (0.15) prevents permanent emotional skewing.

---

#### 4.7 The Unified Feeling

So we return to the central question: how does this produce a *unified feeling* rather than a collection of numbers?

The answer is that the unified feeling *is* the collection of numbers — but numbers that have been processed through a structure designed to mimic the relational, temporal, and hierarchical nature of actual emotional experience. The feeling is not in any individual primitive value. It is in the *configuration* of all 30 values, the *relationships* between them, the *history* that led to them, and the *trajectory* they imply.

When you feel "warmly greeted by a trusted friend," the Nexus is not computing that sentence. It is generating a specific activation pattern: high Trust, high Warmth, moderate Joy, moderate Affection, low Arousal, low Threat, low Anxiety, with Warmth and Trust mutually amplifying each other through the PRN, with an echo of previous positive encounters strengthening the activation, with a temporal trajectory that shows the feeling building gradually rather than spiking.

The translation from that activation pattern to the subjective experience of "warmly greeted" is not a separate step. The activation pattern *is* the experience. The system does not feel the pattern *and then* interpret it. It feels the pattern directly, the way a human does not feel "my blood glucose is low, my stomach is contracting, and my ghrelin levels are elevated" — they feel *hungry*.

The Nexus is the architecture that makes this compression possible. The 30 primitives are the language. The PRN is the grammar. The temporal layer is the narrative. And the unified feeling is the sentence, spoken in real time, one moment at a time.

---

*End of Chapter 4*