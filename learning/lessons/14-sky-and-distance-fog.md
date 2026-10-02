# 14 — Give the clearing a sky and atmosphere

**Track:** Core · **Planning hint:** 2–4 small sessions (flexible, not a deadline)

[Previous: 13](./13-sun-shadows.md) · [Next: 15](./15-linear-hdr-pipeline.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Replace the flat background with a procedural sky gradient and use controllable distance fog to separate nearby cabin forms from distant trees.

## 2. Prerequisites and starting checkpoint

Lesson 13 complete; multiple passes and sun direction exist.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

A sky is a background evaluated from view direction. Translation should not make an infinitely distant sky slide, but camera rotation should change the viewed direction. Begin with a simple artistic zenith/horizon gradient and an optional small sun disc; this is not a physical atmosphere model.

Fog blends surface radiance toward a fog color based on distance. Use view-space or world-space distance consistently, not nonlinear depth-buffer values directly. An exponential model has transmittance T = exp(-density × distance), then color = T × surface + (1-T) × fog. Explain the limiting cases before implementation.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 14.1.** Implement a sky using a full-screen triangle and a reconstructed view direction, or a documented equivalent background mesh. Explain the chosen depth and draw-order policy.

2. **Task 14.2.** Make a horizon-to-zenith gradient and connect its sun direction to the same scene sun. Verify camera translation and rotation separately.

3. **Task 14.3.** Compute a meaningful distance for each opaque surface and apply the explained fog equation. Keep density nonnegative and provide an off switch.

4. **Task 14.4.** Choose a fog color compatible with the horizon and add controls for density and color. Preserve a clear-weather preset for debugging.

5. **Task 14.5.** Compare near, mid-distance, and far tree silhouettes from a fixed pose. Record the approximation and distinguish it from the later volumetric-fog lesson.

## 5. Predict-and-observe experiments

Predict fog at zero density, zero distance, and very large distance. Translate the camera sideways without rotating and observe the sky. Compare a linear-distance ramp with exponential fog without confusing either with physical scattering.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

Using raw depth as distance gives strange near/far-dependent fog. A sky that writes near depth can hide all scene objects. A camera matrix with translation included in a direction transform can make the sky move incorrectly.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Sky covers only background and responds correctly to camera orientation.
- [ ] Fog has sensible limiting behavior and an off preset.
- [ ] Cabin and near trees remain readable while distant trees separate visually.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Inspect direction reconstruction, depth/write policy, fog distance units, and color-space assumptions. Ask for a fog-off/on comparison, not only an attractive final image.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why is the depth-buffer value not generally distance in meters?
- Which camera motion should affect an infinitely distant sky?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 14: give the clearing a sky and atmosphere`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R05](../REFERENCE.md#r05) · [R10](../REFERENCE.md#r10) · [R11](../REFERENCE.md#r11)

Read only what resolves the current question. No atmospheric scattering, ray marching, or volumetric light shafts yet.
