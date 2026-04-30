## Appendix D: Balance & Vestibular

**Core Agent:** Vestibular Integration
**System:** 8 | **Tier:** Fast | **Total Micro-Agents:** 7

The vestibular system provides the sense of head motion, orientation, and balance. It answers: "How is my head and body moving through space?"

---

### Agent Hierarchy

#### Level 1 — Basic Motion

- **Vest-Acceleration**: Linear acceleration and changes in speed
- **Vest-Rotation**: Angular velocity (turning, spinning, tilting)

#### Level 2 — Balance & Stability

- **Vest-Balance**: Real-time stability and sway monitoring
- **Vest-Tilt**: Head and body orientation relative to gravity

#### Level 3 — Critical Events

- **Vest-Freefall**: Detection of falling
- **Vest-Startle**: Sudden unexpected movement
- **Vest-Impact**: High-magnitude deceleration or collision

---

### D.1 Micro-Agent Specifications

*(To be filled out one by one.)*

---

### D.2 Implementation Notes

- 6-axis IMU (accelerometer + gyroscope) at 400Hz minimum for startle detection.
- Vest-Balance is a fusion agent requiring input from both vestibular and proprioceptive systems.

---

*End of Appendix D*
