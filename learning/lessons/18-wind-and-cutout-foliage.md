# 18 — Animate foliage and preserve its silhouette

**Track:** Core · **Planning hint:** 3–5 small sessions (flexible, not a deadline)

[Previous: 17](./17-porch-light-and-emission.md) · [Next: 19](./19-bloom-and-pass-order.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Add leaf cards or simple cutout foliage and gentle wind while making visible trees and their shadows agree.

## 2. Prerequisites and starting checkpoint

Lesson 17 complete; instancing, time, textures, and shadow passes work.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

Alpha testing discards fragments below a mask threshold, leaving surviving fragments opaque and depth-writing. It is useful for leaf silhouettes. It differs from alpha blending, which combines colors and often needs ordering and different depth-write policy. Use alpha-tested leaves for this lesson.

Vertex deformation changes shape without rewriting mesh buffers. A wind function can depend on time, instance seed, position, and a height-based weight that leaves the trunk base fixed. The shadow pass must apply the same deformation and alpha-mask decision. Alpha is coverage data and should not be gamma transformed as a color channel.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 18.1.** Add a small crossed-card canopy or selected leaf clusters using a simple mask texture. Explain the mask threshold and render both sides with an explicit normal policy if leaves are two-sided.

2. **Task 18.2.** Implement alpha discard in the main foliage shader. Keep the opaque terrain/cabin path unchanged and use a distinct pipeline only where state genuinely differs.

3. **Task 18.3.** Add the same mask sampling to the shadow pass, using a fragment function in the depth-only pass when needed. Verify that rectangular cards do not cast solid rectangular shadows.

4. **Task 18.4.** Implement a small wind displacement with a pinned base and per-instance phase. Reuse the deformation logic or equivalent tested math in main and shadow vertex paths.

5. **Task 18.5.** Pause time and compare visible leaves to their shadows. Record that normals under deformation are an approximation unless you also update them correctly. Keep the wind amplitude modest.

## 5. Predict-and-observe experiments

Raise the mask threshold and predict the silhouette change. Disable wind in only the shadow pass to recognize the mismatch, then restore it. View distant leaves with mipmaps and note edge/shimmer limitations for later anti-aliasing work.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

Treating cutout leaves as conventional blended quads creates avoidable sorting problems. Culling both back-facing sides can make a card vanish from one direction. Reusing main-pass transforms without the same animation still gives incorrect moving shadows.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Leaf cutouts, depth behavior, and two-sided appearance are intentional.
- [ ] Main and shadow passes agree on alpha coverage and wind position.
- [ ] Wind pauses, resets, and stays stable across frame rates.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Review shared deformation inputs, alpha handling, shadow fragment configuration, and normal approximation. Require paused side-by-side silhouette/shadow evidence.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why does alpha testing still work with ordinary opaque depth writes?
- Why must a shadow renderer know about leaf texture alpha?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 18: animate foliage and preserve its silhouette`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R05](../REFERENCE.md#r05) · [R09](../REFERENCE.md#r09) · [R11](../REFERENCE.md#r11) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. No order-independent transparency, physically simulated branches, or per-leaf skeleton. Transparent smoke belongs to a separate future experiment.
