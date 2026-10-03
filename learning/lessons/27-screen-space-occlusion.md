# 27 — Add contact depth with screen-space occlusion

**Track:** Advanced · **Implementation effort hint:** 5–8 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 26](./26-environment-lighting.md) · [Next: 28](./28-volumetric-sunlight.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Darken some indirect light near cabin-ground contacts and creases using a modest screen-space ambient-occlusion approximation (SSAO).

## 2. Prerequisites and starting checkpoint

Lesson 26 complete; indirect and direct lighting are separated, and multiple render targets/passes are familiar.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

SSAO estimates nearby occlusion from visible depth and normals. It cannot see hidden or offscreen geometry, so it is an approximation with predictable failure cases. Reconstruct view-space positions from depth using the inverse projection and your exact viewport/depth conventions.

Separate raw occlusion, edge-aware filtering, and lighting composition. Occlusion should primarily affect the chosen indirect diffuse component here, not multiply emission and every direct light. A position reconstruction test is a prerequisite for tuning an occlusion kernel.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 27.1.** Plan a non-circular order: a depth/normal prepass, AO/filter passes, then main lighting consuming AO is one option. Another stores indirect lighting for later composition. Record and enforce Metal 4 producer/consumer barriers for every link, preserve cutout coverage, and explain the bandwidth.

2. **Task 27.2.** Reconstruct view positions from UV and depth. Validate by comparing reprojected positions and known geometry depths, with explicit background handling.

3. **Task 27.3.** Implement a small hemisphere sample kernel with a world/view-distance radius. Project sample locations, compare compatible depth distances, and limit contributions from unrelated far surfaces.

4. **Task 27.4.** Visualize raw occlusion, then add an edge-aware blur that respects depth/normal discontinuities. Avoid spreading a foreground silhouette onto distant background.

5. **Task 27.5.** Apply restrained occlusion to the selected indirect term. Provide radius, strength, sample-count, and off controls. Compare cabin contacts and screen edges at fixed exposure.

## 5. Common mistakes and investigation

Nonlinear depth differences are not distances in meters. A blur that ignores geometry creates halos. Sampling sky depth as real geometry can darken the horizon. Multiplying the entire final image by AO darkens light sources and direct sunlight incorrectly.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R08](../REFERENCE.md#r08) · [R10](../REFERENCE.md#r10) · [R11](../REFERENCE.md#r11) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. A low-sample SSAO implementation is enough. Bent normals, GTAO, and temporal accumulation are optional later investigations.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Move a nearby occluder offscreen and explain the loss of its contribution. Change camera near/far planes and verify that the chosen radius still represents the same scene scale. Test a flat plane to expose self-occlusion bias.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Position reconstruction is verified independently of the effect.
- [ ] Contact shading is modest, controllable, and applied to an explicit lighting term.
- [ ] Screen-edge and hidden-geometry limitations are demonstrated and documented.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why cannot SSAO replace the sun shadow map?
- Why should an emissive window remain emissive inside an occluded region?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Inspect coordinate reconstruction, depth texture usage, normal space, kernel radius, background masking, filtering, and composition point. Require raw and filtered views.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 27: add contact depth with screen-space occlusion`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
