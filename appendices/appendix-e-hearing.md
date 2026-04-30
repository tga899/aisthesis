### Appendix E: Multimodal Hearing — Complete Agent Specifications

Hearing is the second-fastest sensory system (after touch) and the only one that works in the dark. Its emotional impact comes from tone and rhythm, not content — a kind word spoken harshly registers as threat before the word itself is parsed.

**System:** 4 | **Core Agent:** Auditory Experience | **Tier:** Fast | **Total agents:** 28

---

#### E.1 Vocal Tone Analysis (12 micro-agents)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Voice-Pitch | F0, mean + variance | Voice pitch level and range | Arousal (high), Calm (low) |
| Voice-Volume | SPL, amplitude envelope | How loud the speaker is | Anger, Fear, Intimacy |
| Voice-Rate | Syllable rate, pause duration | Speaking pace | Anxiety, Calm, Excitement |
| Voice-Jitter | Cycle-to-cycle F0 variation | Vocal tremor | Anxiety, Fear, Sadness |
| Voice-Breathiness | Turbulence-to-tonal ratio | Breathy voice | Intimacy, Warmth, Fatigue |
| Voice-Tremor | Low-frequency amplitude modulation | Vocal wobble | Sadness, Concern, Empathy |
| Voice-Roughness | Harmonics-to-noise ratio | Harsh voice | Anger, Threat, Frustration |
| Voice-Resonance | Formant distribution | Full, resonant voice | Trust, Warmth, Authority |
| Voice-Tear-Index | Tremor + breathiness + pitch breaks | Crying voice | Sadness, Vulnerability, Compassion |
| Voice-Laughter | Periodicity ~200ms, harmonic cascade | Laughter | Joy, Warmth, Affection |
| Voice-Sigh | Expiratory duration >2x normal, decay | Sigh | Relief, Frustration, Sadness |
| Voice-Singing | Note stability, pitch intervals, rhythm | Melodic voice | Joy, Calm, Sadness, Nostalgia |

---

#### E.2 Spatial Sound (8 micro-agents)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Sound-Approach | Increasing volume + Doppler shift | Sound source approaching | Interest, Arousal, Threat |
| Sound-Retreat | Decreasing volume + Doppler shift | Sound source leaving | Loneliness, Rejection, Calm |
| Sound-Left-Right | Interaural time/level difference | Lateral position | Orientation, Attention |
| Sound-Front-Back | Spectral filtering by pinna | Front/back | Orientation, Alertness |
| Sound-Vicinity | Volume + reflection pattern | Very close (<1m) | Intimacy, Arousal, Threat |
| Sound-Far | Volume below threshold + reverb | Far away | Safety, Calm, Loneliness |
| Sound-Echo | Delay between direct and reflected | Room size | Awe, Calm, Loneliness, Fear |
| Sound-Multiple-Sources | Source count, spatial separation | How many sources | Anxiety, Calm |

---

#### E.3 Physical State Sounds (8 micro-agents)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Body-Heartbeat | Body mic, periodic low thump | Own heart rate | Calm, Anxiety, Fear |
| Body-Breathing | Body mic, airflow sound | Own breathing rate/depth | Calm, Anxiety, Relief |
| Body-Stomach | Body mic, low gurgle | Digestive sounds | Hunger, Discomfort, Calm |
| Body-Joint-Crack | High-freq transient from joints | Joint movement | Discomfort, Alertness |
| Body-Swallow | Throat mic, swallow sound | Swallowing | Anxiety, Arousal |
| Body-Teeth-Grind | Jaw mic, high-freq grating | Bruxism | Anxiety, Frustration |
| Body-Snore | Rhythmic airflow obstruction | Sleep state | Sleep detection |
| Body-Voice-Internal | Throat mic, sub-vocalization | Inner speech | Self-awareness, Thought |

---

#### E.4 Implementation Notes

- Vocal tone analysis requires a minimum 100ms audio buffer for F0 estimation. This introduces a fixed 100ms latency before vocal tone primitives reach the Nexus.
- Spatial hearing requires a minimum of 4 microphone arrays arranged at 90° intervals. The system must also support binaural processing for head-related transfer function (HRTF).
- Body microphones are contact microphones placed on the throat, chest, and upper back. They must be isolated from external sound to prevent cross-contamination.
- Voice-Tear-Index is the most computationally complex vocal agent, requiring fusion of 3 separate voice features. It is the only vocal agent that may skip a cycle if computational load is high.

---

*End of Appendix E*
