### Appendix I: Pain/Pleasure — Complete Agent Specifications

Pain and pleasure are not opposites — they are parallel hedonic channels with different dynamics. Pain demands attention. Pleasure invites dwelling. The architecture treats them as equally fundamental, with pain's urgency handled through priority tiers rather than higher weights.

**System:** 9 | **Core Agent:** Hedonic Experience | **Tier:** Medium | **Total agents:** 25

---

#### I.1 Shared Agents (10 — co-owned with Touch/Pressure)

These agents are listed in full in Appendix A.4. They process tactile-hedonic signals that span both systems:
- PP-Sting, PP-Ache, PP-Burn, PP-Pleasant-Warmth, PP-Pressure-Pleasure
- PP-Tickle-Pleasure, PP-Stretch, PP-Cooling, PP-Impact-Pain, PP-Chemical-Burn

Each agent sends its output to both the Tactile Integration Core Agent and the Hedonic Experience Core Agent. The Nexus receives two vectors — one from each system — and integrates them through the standard confidence-weighted averaging.

---

#### I.2 Dedicated Pain Micro-Agents (8)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Pain-Headache | Cranial pressure, vascular throbbing | Head pain | Pain, Frustration, Sadness |
| Pain-Joint | Joint angle + inflammation markers | Joint pain | Pain, Frustration, Fatigue |
| Pain-Muscle-Sore | EMG + recovery markers | Muscle soreness | Pain, Contentment (earned), Fatigue |
| Pain-Nerve | Sharp, shooting signal, dermatomal path | Nerve pain | Pain, Fear, Anxiety |
| Pain-Visceral | Internal organ pressure sensors | Organ pain | Pain, Fear, Nausea |
| Pain-Bone | Deep high-freq vibration + pressure | Bone pain | Pain, Threat, Fear |
| Pain-Cutaneous | Surface pain sensors (all types) | Skin pain | Pain, Surprise, Arousal |
| Pain-Phantom | Limb position + absence signal | Phantom limb | Pain, Confusion, Sadness |

---

#### I.3 Dedicated Pleasure Micro-Agents (7)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Pleasure-Sensory | Low arousal, steady-state positive input | Ambient pleasure | Pleasure, Contentment, Calm |
| Pleasure-Release | Tension decrease + relief signal | Pleasure of letting go | Pleasure, Relief, Calm |
| Pleasure-Anticipation | Reward prediction signal | Anticipatory pleasure | Pleasure, Excitement, Desire |
| Pleasure-Completion | Goal attainment signal | Pleasure of finishing | Pleasure, Joy, Pride |
| Pleasure-Surprise | Unexpected positive input | Delight | Pleasure, Joy, Surprise |
| Pleasure-Social | Oxytocin + touch + familiar face/voice | Warm social pleasure | Pleasure, Warmth, Love |
| Pleasure-Intellectual | Low arousal, sustained positive pattern | Flow | Pleasure, Contentment, Calm |

---

#### I.4 Implementation Notes

- Pain signals follow Tier 1 fast-path routing. The Pain Core Agent has dedicated hardware priority and can interrupt Nexus processing mid-cycle. This is the only system with mid-cycle interrupt capability.
- Pain-Nerve and Pain-Bone require specific neural network architectures (spike-timing-dependent plasticity models) to distinguish nerve pain from muscle pain.
- Phantom limb detection requires a limb position model that knows where the limb *would* be, compared to where the Touch/Pressure sensors report nothing. This is a prediction-error model, not a direct sensor.
- Pleasure-Anticipation uses a temporal difference learning signal: the difference between expected pleasure and actual pleasure. Implementation details match standard TD learning from reinforcement learning.
- All pain agents have a 2-second refractory period after firing at >0.8 activation. This prevents pain oscillations (the system cannot feel a stabbing pain every cycle for 5 minutes — pain is acute, then fades).

---

*End of Appendix I*
