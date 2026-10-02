# 19 — Build a controlled bloom effect

**Track:** Core · **Planning hint:** 3–5 small sessions (flexible, not a deadline)

[Previous: 18](./18-wind-and-cutout-foliage.md) · [Next: 20](./20-core-review-and-profiling.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Give the porch lamp and bright windows a restrained glow by building an inspectable multi-pass image effect.

## 2. Prerequisites and starting checkpoint

Lesson 18 complete; the HDR target and final tone-map pass are stable.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

Bloom takes bright linear HDR image regions, spreads some energy over neighboring pixels, and combines the result before tone mapping. It is a screen-space approximation, not illumination of scene geometry. A separable blur splits a 2D filter into horizontal and vertical passes, reducing samples for a chosen kernel.

Introduce ping-pong textures: each pass reads one image and writes another. Reading and writing the same attachment in an ordinary sampling pass is not a safe shortcut. A lower-resolution bloom chain is often sufficient but must be compared for quality.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 19.1.** Write every pass and intermediate allocation. Record argument-table bindings and residency, then draw producer/consumer dependencies and the Metal 4 barriers or fences that enforce them. Include read-before-reuse hazards when ping-pong targets are overwritten later.

2. **Task 19.2.** Extract a bright-region image using an explained threshold, optionally with a soft transition. Add a debug view of the extracted image before blurring.

3. **Task 19.3.** Implement horizontal and vertical blur passes with a small normalized kernel. Verify that a uniform image stays uniform and choose explicit edge addressing.

4. **Task 19.4.** Combine bloom with the HDR scene before exposure/tone mapping according to one documented convention. Expose strength and an off switch; avoid applying exposure twice.

5. **Task 19.5.** Try half-resolution processing, recreate targets on resize, and compare cost and appearance at a fixed scene/camera. Keep screenshots of extraction, blur, and final composition.

## 5. Predict-and-observe experiments

Predict the effect of doubling kernel radius and lowering threshold. Compare bloom on/off with the point light disabled to prove that the effect does not illuminate geometry. Test an extremely bright window for stability.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

A blur kernel whose weights do not sum appropriately changes brightness unexpectedly. Incorrect input dimensions create direction-dependent blur. Applying bloom after display gamma makes its behavior inconsistent. Reusing a target before its previous contents are consumed breaks pass dependencies.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Bloom is inspectable at intermediate stages and has an exact off path.
- [ ] Ping-pong dependencies and target sizes are correct through resize.
- [ ] Emission, local lighting, and bloom remain conceptually distinct.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Check resource usages, pass sequence, kernel weights, HDR composition, and resizing. Request a pass graph or dependency table plus intermediate images.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why can a separable filter need fewer samples?
- Why should blur read and write different images here?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 19: build a controlled bloom effect`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R10](../REFERENCE.md#r10) · [R12](../REFERENCE.md#r12) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. Use fragment-based full-screen passes first. A compute rewrite is optional after lesson 21; automatic exposure is outside this lesson.
