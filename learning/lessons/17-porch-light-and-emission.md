# 17 — Light the cabin at dusk

**Track:** Core · **Implementation effort hint:** 2–4 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 16](./16-physically-based-materials.md) · [Next: 18](./18-wind-and-cutout-foliage.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Add a warm porch lamp and emissive window panels, producing a readable dusk scene with both local and directional light.

## 2. Prerequisites and starting checkpoint

Lesson 16 complete; the direct-light material model runs in linear HDR.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

A directional light has one direction everywhere; a point light has a position, so L and distance vary by surface. Explain inverse-square falloff and why a near-zero distance needs a documented finite-light approximation or minimum distance. Keep a small fixed light count initially.

Emission is light leaving a surface in the image. An emissive window does not automatically illuminate nearby geometry in this renderer. A separate point light provides that approximate local illumination. Bloom later makes bright areas spread on the image; it is not the same as either emission or lighting.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 17.1.** Design a small point-light record with position, color, and intensity. Document layout and whether intensity is a calibrated unit or an artistic value.

2. **Task 17.2.** Extend the direct-light calculation to one point light. Compute its world-space direction and attenuation consistently, then use the same material response as sunlight.

3. **Task 17.3.** Place the lamp under the porch and test nearby surfaces at known distances. Handle the near-light singularity deliberately and document a finite influence cutoff if used.

4. **Task 17.4.** Add an emissive term for window panels and the visible lamp mesh. Keep the point light and emissive appearance separately controllable.

5. **Task 17.5.** Create day and dusk presets controlling sun, ambient placeholder, sky, exposure, and porch lamp coherently. Keep emission independent of whether the surface faces the sun.

## 5. Common mistakes and investigation

A point-light vector must be normalized separately from its distance. Adding an emissive term before multiplying all lighting by a shadow factor incorrectly shadows emission. The lamp has no local shadow map in this lesson, so light leaks through thin geometry are an acknowledged approximation.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R12](../REFERENCE.md#r12) · [R13](../REFERENCE.md#r13)

Read only what resolves the current question. One or a few point lights are enough. Local-light shadows and many-light rendering are optional future branches.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Double the distance from an isolated point light and predict the ideal falloff ratio before applying any cutoff. Disable emission but keep the point light, then reverse the toggles and explain the two results.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] The lamp illuminates nearby cabin surfaces and attenuates with distance.
- [ ] Emission and illumination can be demonstrated independently.
- [ ] Day and dusk presets remain numerically stable at close camera/light positions.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why does a bright window not light the ground automatically?
- What distinguishes inverse-square attenuation from a linear distance fade?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Inspect space consistency, attenuation guard, emission placement in the formula, and light-count bounds. Ask the learner to identify the expected local-shadow limitation.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 17: light the cabin at dusk`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
