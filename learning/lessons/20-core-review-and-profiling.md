# 20 — Finish and explain the core diorama

**Track:** Core · **Planning hint:** 3–5 small sessions (flexible, not a deadline)

[Previous: 19](./19-bloom-and-pass-order.md) · [Next: 21](./21-compute-fireflies.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Reach a coherent first finished scene and establish an evidence-based performance baseline before adding advanced features.

## 2. Prerequisites and starting checkpoint

Lessons 01–19 complete or reviewed with explicit, resolved adaptations.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

Frame rate is a result of several interacting limits: CPU submission, GPU work, synchronization, and presentation pacing. Frame time is easier to reason about than FPS when adding costs. A prettier image does not prove a correct pipeline, and a lower draw count does not prove a faster renderer.

Use a fixed scene seed, camera, drawable pixel resolution, settings, and build configuration. Distinguish debug-validation overhead from normal execution. A profile should answer a question about a bottleneck, not merely produce a screenshot of a profiler.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 20.1.** Choose final core day and dusk camera presets. Review cabin proportions, terrain contact, tree distribution, material readability, shadows, wind, and restrained bloom. Fix integration errors rather than adding features.

2. **Task 20.2.** Make a resource/pass table and explain the whole frame from Swift input to display. Include where depth, shadows, HDR, and bloom are produced and consumed.

3. **Task 20.3.** Capture a labeled frame and inspect the main draws and intermediate textures. Run available validation; investigate relevant warnings instead of suppressing them.

4. **Task 20.4.** Measure repeated runs after warm-up at a fixed resolution. Record CPU/GPU timing when tools provide it, draw/instance counts, and memory observations. If only frame time is available, state that limitation.

5. **Task 20.5.** Form one optimization hypothesis from evidence, make one reversible change, and compare before/after quality and timing. Revert it if there is no useful benefit.

6. **Task 20.6.** Update the app README with build/run instructions, controls, representative screenshots, environment, and known limitations. Complete a review using the core rubric below.

## 5. Predict-and-observe experiments

Reduce pixel resolution while keeping geometry fixed, then reduce tree count while keeping resolution fixed. Explain what each experiment suggests about the bottleneck; neither alone is conclusive proof.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

V-sync can conceal a speed improvement in FPS. A GPU capture can alter timing. Comparing different camera poses or thermal conditions can invalidate conclusions. Do not rewrite the renderer just because a tool suggests a potential optimization.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] A reproducible day and dusk scene runs with working controls and feature toggles.
- [ ] The learner can explain every current pass and important resource lifetime.
- [ ] A baseline report records environment, settings, evidence, and one tested performance hypothesis.
- [ ] Core visual regressions and relevant validation errors are resolved or clearly scoped with reviewer agreement.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Review integration across the repository, not only the final diff. Sample earlier concepts with two practical questions. Assess technical correctness, evidence quality, and clarity; no universal FPS threshold applies without hardware/resolution context.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Where does each output image become an input?
- Which measured result would justify optimizing fragment work rather than CPU draw submission?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 20: finish and explain the core diorama`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R14](../REFERENCE.md#r14) · [R07](../REFERENCE.md#r07) · [R12](../REFERENCE.md#r12)

Read only what resolves the current question. This is a complete stopping point if you want a finished core project. The advanced path continues in the same repository and scene.
