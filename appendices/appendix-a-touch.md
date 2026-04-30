### Appendix A: Touch & Pressure — Complete Agent Specifications

The touch system is the most architecturally straightforward and the most emotionally potent. Touch is the only sense where the sensor and the sensed are the same physical surface. Every touch is also being touched.

**System:** 1 | **Core Agent:** Tactile Integration | **Tier:** Fast | **Total agents:** 35

---

#### A.1 Light Touch (5 micro-agents)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| LT-Stroke | Continuous pressure sensor array, velocity map | Gentle stroking motion across skin | Warmth, Pleasure, Affection |
| LT-Brush | Pressure sensor array, texture variance | Fabric/bristle contact, non-smooth texture | Arousal, Surprise, Curiosity |
| LT-Tickle | High-frequency pressure variation | Light, irregular, unpredictable touch | Joy, Arousal, Pleasure |
| LT-Tap | Rapid on/off pressure transient | Discrete contact points | Surprise, Arousal, Warmth |
| LT-Static | Sustained low-pressure contact | Resting hand on surface, non-moving touch | Calm, Contentment, Safety |

---

#### A.2 Sustained Pressure/Grip (12 micro-agents)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| SP-Handshake | Grip pressure array, duration, hand size | Mutual grip configuration | Trust, Safety, Warmth |
| SP-Embrace | Multi-point pressure (shoulder, back, arm) | Full body contact area, pressure distribution | Warmth, Safety, Love, Affection |
| SP-Restraint | High pressure, limited surface area | Being held down or restricted | Fear, Threat, Anxiety |
| SP-Cradle | Even pressure distribution, rocking motion | Being held with support | Safety, Calm, Warmth |
| SP-Push | Directional pressure vector, acceleration | Being pushed or shoved | Threat, Fear, Anger |
| SP-Lean | Sustained asymmetric pressure | Someone leaning against the system | Trust, Warmth, Affection |
| SP-Kick | High-impact transient, pressure threshold | Striking contact | Pain, Threat, Fear |
| SP-Tension | Muscle pressure sensor, sustained contraction | Own muscle tension under pressure | Anxiety, Arousal, Frustration |
| SP-Shove-Response | Pressure vector, self-motion | System being moved by external force | Threat, Surprise, Fear |
| SP-Head-Touch | Light pressure on crown, temple, or cheek | Head contact | Warmth, Affection, Trust, Tenderness |
| SP-Guide | Gentle directional pressure on arm/shoulder | Being guided by another | Trust, Safety, Calm |
| SP-Hand-Hold | Interleaved pressure (fingers), warmth transfer | Hand holding | Warmth, Affection, Trust, Safety, Love |

---

#### A.3 Vibration (8 micro-agents)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Vib-Low | 20-80 Hz vibration sensor | Low rumble | Threat, Anxiety, Arousal |
| Vib-Mid | 80-500 Hz vibration sensor | Speech-related vibration | Safety, Calm, Surprise |
| Vib-High | 500+ Hz vibration sensor | Surface texture vibration | Curiosity, Arousal |
| Vib-Rhythmic | Periodic vibration pattern, frequency analysis | Rhythmic vibration | Calm, Joy, Excitement |
| Vib-Approach | Increasing vibration amplitude, Doppler shift | Approaching vibration | Threat, Anxiety, Fear |
| Vib-Impact | Single high-amplitude transient | Sudden impact | Surprise, Fear, Arousal |
| Vib-Consistent | Steady-state vibration, minimal variation | Engine hum, ambient | Calm, Contentment, Safety |
| Vib-Chaotic | High entropy vibration spectrum | Unpredictable vibration | Fear, Threat, Anxiety |

---

#### A.4 Pain/Pleasure Shared Agents (10 micro-agents — co-owned with System 9)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| PP-Sting | Sharp transient, high amplitude, short | Puncture, cut, sharp impact | Pain, Surprise, Arousal |
| PP-Ache | Sustained medium amplitude, broad | Deep tissue pain, fatigue | Pain, Frustration, Sadness |
| PP-Burn | Continuous high amplitude, increasing | Thermal pain, friction burn | Pain, Fear, Threat, Anxiety |
| PP-Pleasant-Warmth | Temperature + pressure + slow rate of change | Pleasant warmth | Pleasure, Warmth, Calm, Contentment |
| PP-Pressure-Pleasure | Even pressure, moderate, sustained | Deep pressure stimulation | Pleasure, Calm, Safety, Contentment |
| PP-Tickle-Pleasure | Irregular light pressure, high frequency | Playful contact | Pleasure, Joy, Arousal |
| PP-Stretch | Sustained tension, gradual increase | Muscle stretching | Pleasure, Relief, Calm |
| PP-Cooling | Temperature decrease, rapid onset | Cooling sensation | Pleasure, Relief, Arousal |
| PP-Impact-Pain | High amplitude transient + ache | Hit, fall, collision | Pain, Threat, Fear, Surprise |
| PP-Chemical-Burn | Temperature + chemical sensor (pH, irritant) | Chemical irritation | Pain, Fear, Anxiety |

---

*End of Appendix A*
