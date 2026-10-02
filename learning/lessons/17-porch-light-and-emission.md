# 17 — Light the cabin at dusk

**Track:** Core · **Planning hint:** 2–4 small sessions (flexible, not a deadline)

[Previous: 16](./16-physically-based-materials.md) · [Next: 18](./18-wind-and-cutout-foliage.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Add a warm porch lamp and emissive window panels, producing a readable dusk scene with both local and directional light.

## 2. Prerequisites and starting checkpoint

Lesson 16 complete; the direct-light material model runs in linear HDR.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

A directional light has one direction everywhere; a point light has a position, so L and distance vary by surface. Explain inverse-square falloff and why a near-zero distance needs a documented finite-light approximation or minimum distance. Keep a small fixed light count initially.

Emission is light leaving a surface in the image. An emissive window does not automatically illuminate nearby geometry in this renderer. A separate point light provides that approximate local illumination. Bloom later makes bright areas spread on the image; it is not the same as either emission or lighting.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 17.1.** Design a small point-light record with position, color, and intensity. Document layout and whether intensity is a calibrated unit or an artistic value.

2. **Task 17.2.** Extend the direct-light calculation to one point light. Compute its world-space direction and attenuation consistently, then use the same material response as sunlight.

3. **Task 17.3.** Place the lamp under the porch and test nearby surfaces at known distances. Handle the near-light singularity deliberately and document a finite influence cutoff if used.

4. **Task 17.4.** Add an emissive term for window panels and the visible lamp mesh. Keep the point light and emissive appearance separately controllable.

5. **Task 17.5.** Create day and dusk presets controlling sun, ambient placeholder, sky, exposure, and porch lamp coherently. Keep emission independent of whether the surface faces the sun.

## 5. Predict-and-observe experiments

Double the distance from an isolated point light and predict the ideal falloff ratio before applying any cutoff. Disable emission but keep the point light, then reverse the toggles and explain the two results.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

A point-light vector must be normalized separately from its distance. Adding an emissive term before multiplying all lighting by a shadow factor incorrectly shadows emission. The lamp has no local shadow map in this lesson, so light leaks through thin geometry are an acknowledged approximation.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] The lamp illuminates nearby cabin surfaces and attenuates with distance.
- [ ] Emission and illumination can be demonstrated independently.
- [ ] Day and dusk presets remain numerically stable at close camera/light positions.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Inspect space consistency, attenuation guard, emission placement in the formula, and light-count bounds. Ask the learner to identify the expected local-shadow limitation.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why does a bright window not light the ground automatically?
- What distinguishes inverse-square attenuation from a linear distance fade?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 17: light the cabin at dusk`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R12](../REFERENCE.md#r12) · [R13](../REFERENCE.md#r13)

Read only what resolves the current question. One or a few point lights are enough. Local-light shadows and many-light rendering are optional future branches.
