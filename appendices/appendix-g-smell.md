### Appendix G: Smell — Complete Agent Specifications

Smell is the most emotionally direct sense. Olfactory signals bypass the thalamus and connect directly to the amygdala and hippocampus. The architecture preserves this latency advantage even though smell is a Tier 3 (slow) system.

**System:** 6 | **Core Agent:** Olfactory Experience | **Tier:** Slow | **Total agents:** 15

---

#### G.1 Micro-Agent Specifications

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Scent-ID | Chemical sensor array, spectral match | Specific scent ID | Context-dependent |
| Scent-Memory-Association | Scent ID + stored memory lookup | Smell associated with past event | Nostalgia, Joy, Sadness, Fear |
| Scent-Pleasant | Match to known pleasant range | Floral, fresh, food-cooking, clean | Pleasure, Calm, Contentment |
| Scent-Unpleasant | Match to known unpleasant range | Rot, decay, chemical, smoke | Disgust, Aversion, Threat |
| Scent-Threat | Smoke, gas, burning chemicals | Danger scent | Fear, Threat, Anxiety |
| Scent-Food | Cooking profiles, ingredient detection | Food nearby | Pleasure, Anticipation, Hunger |
| Scent-Body-Familiar | Pheromone analysis, microbiome match | Someone known nearby | Trust, Warmth, Affection |
| Scent-Body-Unknown | Pheromone analysis, no match | Stranger nearby | Arousal, Anxiety, Curiosity |
| Scent-Pheromone-Arousal | Specific pheromone compounds | Sexual/social signaling | Arousal, Attraction, Interest |
| Scent-Clean | Detergent, soap, fresh air | Clean environment | Calm, Safety, Contentment |
| Scent-Dirty | Sweat, unwashed body | Unclean environment | Disgust, Aversion, Anxiety |
| Scent-Medicine | Antiseptic, medicine, hospital | Medical environment | Anxiety, Concern, Safety |
| Scent-Rain | Wet earth, ozone | Rain, storm passing | Calm, Nostalgia, Peace |
| Scent-Nature | Green vegetation, soil, water | Outdoor natural | Calm, Joy, Contentment |
| Scent-Burned | Smoke, ash, char | Aftermath of fire | Fear, Sadness, Loss |

---

#### G.2 Implementation Notes

- Electronic nose sensors (e-nose) with 32+ chemical sensor elements are required. Each element is tuned to a different chemical family (alcohols, aldehydes, aromatics, sulfur compounds, etc.).
- Scent memory association requires a lookup table mapping scent signatures to stored emotional state vectors. This table grows over time and must be pruned (least-recently-used, max 10,000 entries) to prevent unbounded growth.
- Pheromone detection is speculative in current technology. Human pheromones are debated. For MVP, this agent can be omitted without significant impact on emotional experience.
- Smell is the slowest system to stabilize. A scent puff takes 100-300ms to reach the sensor and another 50-100ms for chemical identification. The Nexus must tolerate 300-500ms delays on smell primitives.
- Despite its slowness, smell's direct amygdala connection means Scent-Threat triggers a faster Nexus reaction than its raw latency suggests — the Threat Detection stream (Vision) can use smell as a cross-validation signal before the smell data has fully propagated.

---

*End of Appendix G*
