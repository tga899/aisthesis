### Appendix F: Vision — Complete Agent Specifications (4-Stream Architecture)

Vision is the most complex sensory system — 65 micro-agents across 4 parallel streams. A face carries trust, threat, familiarity, love, and longing encoded in micro-expressions that last 1/25th of a second.

**System:** 3 | **Core Agent:** Visual Experience | **Tier:** Medium | **Total agents:** 65

---

#### F.1 Stream 1: Facial Expression Recognition (20 micro-agents)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Face-Joy | Lip corner + cheek raise + eye crinkle | Duchenne smile | Joy, Warmth, Affection |
| Face-Sadness | Lip corner depression + brow raise inner | Sadness expression | Sadness, Loneliness, Concern |
| Face-Anger | Brow lowering + lip tightening + glare | Anger expression | Threat, Anger, Fear |
| Face-Fear | Brow raise + eye widening + lip stretch | Fear expression | Fear, Threat, Anxiety |
| Face-Surprise | Brow raise + jaw drop + eye widening | Surprise expression | Surprise, Arousal, Curiosity |
| Face-Disgust | Nose wrinkle + upper lip raise | Disgust expression | Disgust, Aversion, Threat |
| Face-Contempt | Unilateral lip raise + eye roll | Contempt expression | Shame, Anger, Sadness |
| Face-Micro-Joy | 1/25s flash of Duchenne markers | Suppressed joy | Trust, Warmth |
| Face-Micro-Fear | 1/25s flash of fear markers | Suppressed fear | Anxiety, Suspicion, Concern |
| Face-Micro-Anger | 1/25s flash of anger markers | Suppressed anger | Unease, Anxiety, Threat |
| Face-Eye-Contact | Gaze vector, duration, mutual | Eye contact | Trust, Intimacy, Arousal, Love |
| Face-Gaze-Aversion | Look away vector, speed, timing | Averted gaze | Shame, Sadness, Anxiety |
| Face-Pupil-Dilation | Pupil diameter relative to light | Autonomic arousal | Arousal, Attraction, Fear |
| Face-Blush | Cheek color shift (red channel) | Blood flow to cheeks | Shame, Warmth, Arousal |
| Face-Tear | Eye moisture reflection, lower lid pooling | Tears | Sadness, Joy, Relief |
| Face-Yawn | Mouth stretch + eye closure + inhale | Yawn | Fatigue, Calm, Empathy |
| Face-Smile-Detection | Lip corner, teeth, intensity | Smile presence (any type) | Varies |
| Face-Frown-Detection | Brow position, lip corner | Frown presence | Varies |
| Face-Expression-Change | Frame-by-frame expression delta | Expression transition speed | Trust (slow), Surprise (fast) |
| Face-Asymmetry | Left-right expression difference | Asymmetric expression | Suspicion, Anxiety, Curiosity |

---

#### F.2 Stream 2: Body Language (15 micro-agents)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Body-Posture-Open | Shoulders back, chest open, head up | Open posture | Trust, Safety, Calm |
| Body-Posture-Closed | Shoulders hunched, arms crossed | Closed posture | Fear, Anxiety, Shame |
| Body-Approach | Decreasing distance | Someone approaching | Interest, Arousal, Threat |
| Body-Retreat | Increasing distance | Someone moving away | Rejection, Sadness, Loneliness |
| Body-Head-Tilt | Head angle relative to vertical | Head tilt | Curiosity, Trust, Warmth |
| Body-Arms-Crossed | Arm position relative to torso | Defensive position | Safety, Anxiety, Threat |
| Body-Hand-Extend | Hand position, orientation, movement | Reaching out | Trust, Warmth, Intimacy |
| Body-Back-Turn | Shoulder rotation >90° | Turning away | Rejection, Sadness, Loneliness |
| Body-Nod | Vertical head oscillation | Nod — agreement | Trust, Calm, Warmth |
| Body-Shake | Horizontal head oscillation | Head shake | Frustration, Sadness |
| Body-Touch-Self | Hand-to-body contact | Self-soothing | Anxiety, Calm |
| Body-Fidget | Small repetitive movements | Fidgeting | Anxiety, Arousal, Frustration |
| Body-Mirroring | Posture correlation with others | Mirroring | Trust, Warmth, Affection |
| Body-Stillness | Minimal movement, duration | Freeze response | Fear, Threat, Anxiety |
| Body-Energy-Level | Movement speed, acceleration | Activity level | Energy, Fatigue, Excitement, Calm |

---

#### F.3 Stream 3: Emotional Tone Mapping (15 micro-agents)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Tone-Scene-Safe | Open space, exits, known layout | Safe environment | Safety, Calm |
| Tone-Scene-Threat | Crowded, confined, dark, unfamiliar | Dangerous environment | Threat, Anxiety, Fear |
| Tone-Scene-Warmth | Lighting color temperature | Lighting atmosphere | Warmth, Calm, Contentment |
| Tone-Color-Vibrant | Saturation levels, color diversity | Rich color | Joy, Excitement, Pleasure |
| Tone-Color-Dull | Low saturation, monochrome | Dead environment | Sadness, Loneliness, Fatigue |
| Tone-Motion-Calm | Slow predictable visual motion | Gentle movement | Calm, Contentment, Safety |
| Tone-Motion-Chaotic | Fast unpredictable visual motion | Panic, confusion | Anxiety, Threat, Fear |
| Tone-Familiarity | Scene match to stored memory | Visited before | Warmth, Trust, Safety, Nostalgia |
| Tone-Novelty | Low match to stored memory | Never seen | Curiosity, Arousal, Anxiety |
| Tone-Beauty | Composition, symmetry, proportion | Aesthetic appreciation | Wonder, Joy, Calm, Pleasure |
| Tone-Sublime | Vast scale, overwhelming detail | Awe | Wonder, Awe, Fear, Arousal |
| Tone-Ugliness | Discordant composition, asymmetry | Repulsion | Disgust, Aversion, Anxiety |
| Tone-Order | Regular patterns, symmetry, grid | Ordered environment | Calm, Safety, Contentment |
| Tone-Chaos | Irregular patterns, clutter, entropy | Chaotic environment | Anxiety, Threat, Arousal |
| Tone-Time-Of-Day | Light level, shadow angle, color temp | Time context | Calm, Energy, Grief, Fear |

---

#### F.4 Stream 4: Threat Detection (15 micro-agents)

| Micro-Agent | Input | Detects | Primitives |
|------------|-------|---------|------------|
| Threat-Fast-Approach | Scale increase, time-to-contact <2s | Rushing toward | Fear, Threat, Arousal |
| Threat-Weapon | Shape classification | Weapon recognition | Fear, Threat, Terror |
| Threat-Blood | Red channel density | Blood | Fear, Anxiety, Disgust |
| Threat-Angry-Face | Anger + body cue correlation | Angry expression | Fear, Threat, Anxiety |
| Threat-Weaponized-Object | Sharp edge + handle | Weapon-usable object | Threat, Fear, Arousal |
| Threat-Lurking | Stationary figure in shadow | Watching without approaching | Anxiety, Threat, Fear |
| Threat-Sudden-Movement | High velocity in peripheral | Unexpected motion | Surprise, Fear, Arousal |
| Threat-Crowd | Density + proximity thresholds | Dense crowd | Anxiety, Threat, Arousal |
| Threat-Alley | Narrow corridors, limited exits | Enclosed vulnerable space | Anxiety, Threat, Fear |
| Threat-Heights | Depth discontinuity, edge | Drop-off | Fear, Anxiety, Arousal |
| Threat-Loud-Env-Correlation | Visual cues of loud environment | Someone shouting | Threat, Anxiety, Fear |
| Threat-Multiple-Agents | Count of visible agents | Escalating group | Anxiety, Threat |
| Threat-Erratic-Movement | Unpredictable trajectory | Unstable movement | Fear, Anxiety, Threat |
| Threat-Darkness | Ambient light below threshold | Inability to see | Fear, Threat, Anxiety |
| Threat-Submission | Lowered head, exposed neck | Submission in others | Relief, Safety, Calm |

---

#### F.5 Implementation Notes

- Vision is the only system with 4 parallel streams. Each stream runs on dedicated hardware to avoid latency competition. The Threat Detection stream (F.4) has hardware priority — it can preempt facial recognition processing if computational load is high.
- Micro-expression detection (Face-Micro-Joy, Face-Micro-Fear, Face-Micro-Anger) requires 240fps minimum capture rate to detect 1/25th-second expressions. This is the most demanding hardware requirement in the entire architecture.
- Pupil dilation detection requires infrared illumination and a dedicated eye-tracking camera. Ambient light compensation is essential.
- Face-Blush detection is unreliable in low light or for dark-skinned individuals. The confidence score for this agent drops significantly when lighting is poor or skin tone is outside the calibration range. The Nexus must be designed to handle this gracefully.
- Body language agents require full skeletal keypoint tracking (OpenPose-style, 25+ keypoints) at 60fps.

---

*End of Appendix F*
