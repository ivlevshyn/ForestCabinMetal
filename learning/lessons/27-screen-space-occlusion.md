# 27 — Add contact depth with screen-space occlusion

**Track:** Advanced · **Planning hint:** 5–8 small sessions (flexible, not a deadline)

[Previous: 26](./26-environment-lighting.md) · [Next: 28](./28-volumetric-sunlight.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Darken some indirect light near cabin-ground contacts and creases using a modest screen-space ambient-occlusion approximation (SSAO).

## 2. Prerequisites and starting checkpoint

Lesson 26 complete; indirect and direct lighting are separated, and multiple render targets/passes are familiar.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

SSAO estimates nearby occlusion from visible depth and normals. It cannot see hidden or offscreen geometry, so it is an approximation with predictable failure cases. Reconstruct view-space positions from depth using the inverse projection and your exact viewport/depth conventions.

Separate raw occlusion, edge-aware filtering, and lighting composition. Occlusion should primarily affect the chosen indirect diffuse component here, not multiply emission and every direct light. A position reconstruction test is a prerequisite for tuning an occlusion kernel.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 27.1.** Plan a non-circular order: a depth/normal prepass, AO/filter passes, then main lighting consuming AO is one option. Another stores indirect lighting for later composition. Record and enforce Metal 4 producer/consumer barriers for every link, preserve cutout coverage, and explain the bandwidth.

2. **Task 27.2.** Reconstruct view positions from UV and depth. Validate by comparing reprojected positions and known geometry depths, with explicit background handling.

3. **Task 27.3.** Implement a small hemisphere sample kernel with a world/view-distance radius. Project sample locations, compare compatible depth distances, and limit contributions from unrelated far surfaces.

4. **Task 27.4.** Visualize raw occlusion, then add an edge-aware blur that respects depth/normal discontinuities. Avoid spreading a foreground silhouette onto distant background.

5. **Task 27.5.** Apply restrained occlusion to the selected indirect term. Provide radius, strength, sample-count, and off controls. Compare cabin contacts and screen edges at fixed exposure.

## 5. Predict-and-observe experiments

Move a nearby occluder offscreen and explain the loss of its contribution. Change camera near/far planes and verify that the chosen radius still represents the same scene scale. Test a flat plane to expose self-occlusion bias.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

Nonlinear depth differences are not distances in meters. A blur that ignores geometry creates halos. Sampling sky depth as real geometry can darken the horizon. Multiplying the entire final image by AO darkens light sources and direct sunlight incorrectly.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Position reconstruction is verified independently of the effect.
- [ ] Contact shading is modest, controllable, and applied to an explicit lighting term.
- [ ] Screen-edge and hidden-geometry limitations are demonstrated and documented.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Inspect coordinate reconstruction, depth texture usage, normal space, kernel radius, background masking, filtering, and composition point. Require raw and filtered views.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why cannot SSAO replace the sun shadow map?
- Why should an emissive window remain emissive inside an occluded region?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 27: add contact depth with screen-space occlusion`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R08](../REFERENCE.md#r08) · [R10](../REFERENCE.md#r10) · [R11](../REFERENCE.md#r11) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. A low-sample SSAO implementation is enough. Bent normals, GTAO, and temporal accumulation are optional later investigations.
