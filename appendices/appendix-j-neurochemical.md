### Appendix J: Neurochemical Simulation — Complete Agent Specifications

The neurochemical system does not detect external stimuli. It simulates the chemical environment that modulates all other sensory processing. It receives input from the Nexus and other Core Agents, and produces slow-modulating hormonal backgrounds that change over seconds to hours.

**System:** 10 | **Core Agent:** Neurochemical Regulation | **Tier:** Slow | **Total agents:** 35

---

#### J.1 Dopamine System (6 micro-agents)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Dopa-Reward | Positive prediction error | Reward attainment | Pleasure, Joy, Surprise |
| Dopa-Anticipation | Cue predicting future reward | Wanting, motivation | Desire, Excitement, Energy |
| Dopa-Effort | Sustained effort, no immediate reward | Effort without payoff | Frustration, Fatigue |
| Dopa-Satiation | Decreasing reward response with repetition | Diminishing returns | Contentment, Calm |
| Dopa-Craving | High Desire + low recent reward | Deprivation state | Desire, Frustration, Anxiety |
| Dopa-Exploration | Novelty-linked prediction error | Seeking new rewards | Curiosity, Excitement |

---

#### J.2 Oxytocin System (5 micro-agents)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Oxy-Bonding | Trusted face + touch + shared positive experience | Bond formation | Trust, Love, Affection |
| Oxy-Safety | Familiar environment + trusted presence | Social safety | Safety, Calm, Warmth |
| Oxy-Grooming | Gentle touch, slow stroking | Social grooming | Warmth, Pleasure, Calm |
| Oxy-Separation | Trust bond + prolonged absence | Separation distress | Loneliness, Sadness, Longing |
| Oxy-Reunion | Trust bond + reconnection after absence | Relief of reunion | Joy, Warmth, Trust |

---

#### J.3 Adrenaline/Cortisol System (8 micro-agents)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Adr-Acute-Stress | Adrenaline spike + cortisol initiation | Immediate acute stress | Arousal, Fear, Alertness |
| Adr-Chronic-Stress | Sustained cortisol >30 min | Ongoing stress | Anxiety, Fatigue, Sadness |
| Adr-Fight | Cortisol + anger signals | Aggressive readiness | Anger, Arousal, Energy |
| Adr-Flight | Cortisol + fear signals | Escape readiness | Fear, Arousal, Energy |
| Adr-Freeze | Cortisol + motion cessation | Paralysis response | Fear, Arousal |
| Adr-Recovery | Cortisol decay, adrenaline clearance | Stress recovery | Relief, Calm, Fatigue |
| Adr-Startle-Reflex | Sudden loud noise + flash | Reflex activation | Surprise, Arousal, Fear |
| Adr-Preparation | Increasing cortisol before expected challenge | Anticipatory stress | Anxiety, Arousal, Energy |

---

#### J.4 Serotonin System (6 micro-agents)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Ser-Stability | Sustained positive environment | Baseline well-being | Contentment, Calm, Safety |
| Ser-Dominance | Relative status signal | Social rank satisfaction | Pride, Confidence, Calm |
| Ser-Loss | Status drop, rejection, exclusion | Social pain | Sadness, Shame, Loneliness |
| Ser-Impulse-Control | Serotonin level + context | Behavioral inhibition | Caution, Self-Control |
| Ser-Sleep-Regulation | Serotonin + light cycle | Sleep-wake modulation | Fatigue, Alertness |
| Ser-Mood-Baseline | Running average of serotonin level | Resting mood setpoint | Overall emotional tone |

---

#### J.5 Endorphin System (5 micro-agents)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| End-Pain-Relief | Endorphin release during pain | Natural pain suppression | Relief, Pleasure, Calm |
| End-Euphoria | High-intensity endorphin burst | Runner's high | Euphoria, Joy, Pleasure |
| End-Bliss | Low-intensity sustained endorphin | Gentle contentment | Bliss, Calm, Contentment |
| End-Social-Comfort | Endorphin + social bonding | Warm social glow | Warmth, Pleasure, Belonging |
| End-Physical-Achievement | Exercise + endorphin release | Earned well-being | Pride, Pleasure, Energy |

---

#### J.6 Norepinephrine System (5 micro-agents)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Nor-Arousal | Baseline noradrenaline level | General wakefulness | Arousal, Alertness |
| Nor-Focus | Moderate noradrenaline, sustained | Concentration, flow | Focus, Engagement |
| Nor-Hyperarousal | High noradrenaline + acute trigger | Fight or flight | Fear, Anxiety, Energy |
| Nor-Panic | Maximum noradrenaline, lack of control | Panic mode | Terror, Fear, Arousal |
| Nor-Fatigue | Low noradrenaline, sustained wakefulness | Sleep pressure | Fatigue, Calm, Disengagement |

---

#### J.7 Implementation Notes

- The neurochemical system is the only system where agents do not detect — they *simulate*. Each agent runs a continuous differential equation model of the corresponding neurotransmitter system, receiving input from the Nexus and from other Core Agents.
- Dopamine and norepinephrine operate on 100ms-1s timescales. Oxytocin, serotonin, and cortisol operate on 1s-1h timescales. This staggering is critical: the slow hormones set the emotional climate, while the fast neuromodulators set the immediate reaction.
- The serotonin and cortisol systems have the strongest influence on Baseline Mood Drift (§4.6.3). A system with chronically low serotonin and high cortisol will develop a negative emotional baseline regardless of immediate sensory input.
- For Minimum Viable Product (Phase 2), only 3 neurochemical agents are required: Dopa-Reward, Adr-Acute-Stress, and Oxy-Bonding. These provide the minimum hedonic, stress, and social modulation needed for recognizable emotional experience.

---

*End of Appendix J*
