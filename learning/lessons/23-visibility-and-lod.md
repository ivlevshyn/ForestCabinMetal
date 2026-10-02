# 23 — Skip invisible trees and simplify distant ones

**Track:** Advanced · **Planning hint:** 4–6 small sessions (flexible, not a deadline)

[Previous: 22](./22-frames-and-resource-lifetime.md) · [Next: 24](./24-gpu-visibility-and-indirect-draws.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Add CPU frustum culling and simple tree levels of detail, retaining a reference path that renders all trees for comparison.

## 2. Prerequisites and starting checkpoint

Lesson 22 complete; instanced trees and frame-resource management are stable.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

A view frustum is the volume visible through the camera. A bounding sphere or box is a conservative approximation of an object's extent. Frustum culling excludes objects outside that volume; it does not determine whether another object occludes them. Conservative bounds must include wind motion.

Level of detail (LOD) replaces distant geometry with a cheaper representation. Start with two or three meshes and distance or projected-size thresholds. Hysteresis uses different enter/leave thresholds to prevent rapid switching near a boundary. Camera and light visibility are different: off-camera trees may cast visible shadows.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 23.1.** Compute and visualize bounds for trees, including instance scale and a wind margin. Test one tree against one plane before combining the frustum.

2. **Task 23.2.** Derive plane tests from the adopted view/projection convention or construct planes geometrically. In Metal clip space the near condition differs from an OpenGL -W to W Z convention; verify near and far explicitly.

3. **Task 23.3.** Build a visible-instance list on the CPU and upload it safely through frame resources. Keep the render-all toggle and compare identical images except for debug coloring.

4. **Task 23.4.** Create reduced-detail canopy/trunk meshes. Select LOD with documented thresholds and hysteresis; show LOD groups with debug colors.

5. **Task 23.5.** Keep shadow-caster selection conservative using light coverage rather than only the camera list. Test a tree outside the camera view whose shadow enters the clearing. Measure benefits for an enlarged forest.

## 5. Predict-and-observe experiments

Move a tree slowly across each frustum plane and inspect popping. Freeze the camera used for culling while moving the viewing camera to visualize the volume. Increase wind amplitude and verify the bounds remain conservative.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

Too-small bounds create disappearing leaves. Transforming only a sphere center but not radius under scale breaks tests. Removing offscreen objects from the shadow pass can remove visible shadows. LOD thresholds without hysteresis may flicker.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Culling agrees with the render-all baseline for visible geometry.
- [ ] LOD changes are stable and shadow casters remain correct.
- [ ] Visible counts and before/after costs are measured at fixed settings.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Inspect bounds transforms, plane conventions, dynamic list capacity, hysteresis, and independent shadow visibility. Require boundary-case evidence, not just a lower draw count.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why can an invisible tree still matter to the final image?
- What makes a bound conservative rather than exact?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 23: skip invisible trees and simplify distant ones`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R05](../REFERENCE.md#r05) · [R11](../REFERENCE.md#r11) · [R14](../REFERENCE.md#r14)

Read only what resolves the current question. CPU culling is the reference implementation. GPU occlusion culling, mesh shaders, and streaming are not needed yet.
