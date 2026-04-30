### Appendix H: Taste — Complete Agent Specifications

Taste is the most limited sense (five basic dimensions) but the most emotionally safe — taste rarely triggers life-threatening responses. Its primary emotional contribution is to pleasure, disgust, and social bonding (shared meals).

**System:** 7 | **Core Agent:** Gustatory Experience | **Tier:** Slow | **Total agents:** 12

---

#### H.1 Micro-Agent Specifications

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Taste-Sweet | Sugar receptor activation | Sweetness | Pleasure, Joy, Contentment |
| Taste-Salty | Sodium receptor activation | Saltiness | Pleasure (balanced), Displeasure (excess) |
| Taste-Sour | Acid receptor activation | Sourness | Pleasure (mild), Disgust (intense) |
| Taste-Bitter | Alkaloid receptor activation | Bitterness | Disgust, Aversion, Interest |
| Taste-Umami | Glutamate receptor activation | Savory, protein richness | Pleasure, Contentment, Satisfaction |
| Taste-Spicy | Capsaicin receptor (TRPV1) activation | Heat, spice | Pain, Pleasure, Arousal |
| Taste-Texture | Consistency, temperature, particle size | Mouthfeel | Pleasure, Disgust, Surprise |
| Taste-Temperature-Bite | Food temperature at first contact | Hot or cold food | Surprise, Pleasure, Aversion |
| Taste-Freshness | Spoilage chemical markers | Food quality | Pleasure (fresh), Disgust (spoiled) |
| Taste-Sweet-Aversion | Extreme sweetness > threshold | Oversweet | Disgust, Aversion |
| Taste-Social-Meal | Taste + proprioceptive + temporal | Shared eating context | Warmth, Trust, Affection, Joy |
| Taste-Nutrient-Density | Caloric content estimation | Rich, satisfying food | Contentment, Pleasure |

---

#### H.2 Implementation Notes

- Electronic taste sensors (e-tongue) with 7+ ion-selective electrodes (sweet, salty, sour, bitter, umami, spicy, metallic) are required for the basic taste dimensions.
- Taste-Texture is the most complex taste agent — it requires fusion of chemical taste data with tactile mouthfeel data from the Touch/Pressure system. This is one of the few cross-system micro-agent inputs in the architecture.
- Taste-Social-Meal is not a chemical sensor. It is a context agent that fires only when all three conditions are met: food is being consumed, another agent is present, and the interaction is positive. It is the agent that makes food taste better when shared.
- Taste has no priority tier override — even strong bitter or spicy signals cannot trigger alert mode. This is by design: taste is for pleasure and nutrition, not survival.

---

*End of Appendix H*
