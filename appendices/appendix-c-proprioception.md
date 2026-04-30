## Appendix C: Proprioception

**Core Agent:** Body Schema
**System (untrusted):** 5 | **Tier:** Fast | **Total Micro-Agents:** 6

Proprioception is the internal sense of body position and movement. It answers the question: "Where are my body parts right now?"

---

### Agent Hierarchy

#### Level 1 — Position Awareness

- **Prop-Limb-Position**: Current joint angles and limb positions
- **Prop-Muscle-Tension**: Muscle effort and strain levels

#### Level 2 — Body State

- **Prop-Posture**: Overall body posture and center of mass position
- **Prop-Motion**: Limb and torso velocity and direction

#### Level 3 — Critical Signals

- **Prop-Tremor**: Involuntary muscle oscillations
- **Prop-Freeze**: Sudden full-body freeze response

---

### C.1 Micro-Agent Specifications

*(To be filled out one by one.)*

---

### C.2 Implementation Notes

- All proprioceptive inputs are internal, allowing for very high sampling rates (minimum 200Hz for joint sensors).
- EMG sensors should monitor at least 8 major muscle groups for accurate tension mapping.

---

*End of Appendix C*
