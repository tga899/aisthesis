## Appendix B: Thermal Perception

**Core Agent:** Thermal Perception
**System:** 2 | **Tier:** Medium | **Total Micro-Agents:** 10

The Thermal Perception system measures both the body's internal thermal state and external thermal conditions, providing critical data for emotional experience, comfort, and system diagnostics.

---

### Agent Hierarchy

#### Level 1 — Foundational Sensors

- **Temp-Surface**: Measures current temperature at multiple points on the skin surface
- **Temp-Deep**: Monitors core internal body temperature

#### Level 2 — Gradient & Dynamics

- **Temp-Gradient**: Detects spatial temperature differences across the body
- **Temp-Change-Rate**: Measures the rate of temperature change over time

#### Level 3 — Environmental & Contact

- **Temp-Env-Ambient**: Monitors surrounding air temperature
- **Temp-Wind**: Detects air movement and its thermal effect
- **Temp-Contact**: Detects direct contact with hot or cold objects

#### Level 4 — Special Conditions

- **Temp-Emotional-Flush**: Detects emotional thermal responses (blushing)
- **Temp-Stress-Rise**: Identifies stress-related thermal changes
- **Temp-Fever**: Monitors for illness-related temperature shifts
- **Temp-Sleep-Drop**: Detects sleep onset through core temperature drop

---

### B.1 Micro-Agent Specifications

#### Temp-Gradient

**Input:** Multi-point temperature readings from Temp-Surface + current core temperature from Temp-Deep

**Purpose:** Detects spatial temperature imbalances across the body surface and reports significant asymmetries for both external heat sources and internal diagnostics.

**Output:**

- **Region:** Specific body region (e.g. "left forearm", "upper torso", "right thigh")
- **Intensity:** Magnitude of temperature difference (0.0–1.0)
- **Polarity:** Heat Gain or Heat Loss
- **Confidence:** Confidence score of the detection

**Behavior:**

- Remains silent when temperature distribution is within normal symmetric tolerance
- Only reports when temperature difference between corresponding body regions exceeds the configured threshold
- Capable of detecting both external directional heat and potential mechanical issues (e.g. one arm motor running hotter than the other)

#### Temp-Change-Rate

**Input:** Time-series data from Temp-Surface and Temp-Deep sensors

**Purpose:** Measures how quickly the temperature is changing over time and reports significant rates of thermal change.

**Output:**

- **Rate:** Speed of temperature change (0.0–1.0)
- **Direction:** Heating or Cooling
- **Region:** Primary area where change is detected (if localized)
- **Confidence:** Confidence score of the detection

**Behavior:**

- Calculates temperature change over short time windows (typically 100-500ms)
- Reports only when the rate of change exceeds normal thresholds
- Critical for detecting rapid external heat sources, sudden cooling, or abnormal system heating
- Works in close coordination with Temp-Gradient to distinguish between steady heat and rapidly changing conditions

---

### B.2 Implementation Notes

- Temperature sensors are relatively slow. The system must buffer readings over 100-200ms to produce stable values.
- Thermal gradient detection requires a minimum of 4–6 temperature sensors distributed across the body surface.
- All temperature readings should be interpreted relative to the current core body temperature (Temp-Deep).

---

*End of Appendix B*
