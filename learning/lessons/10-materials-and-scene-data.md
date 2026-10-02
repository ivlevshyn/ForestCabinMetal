# 10 — Organize materials without building an engine

**Track:** Core · **Planning hint:** 2–3 small sessions (flexible, not a deadline)

[Previous: 09](./09-textures-and-samplers.md) · [Next: 11](./11-terrain-and-placement.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Give wood, stone, roof, and ground distinct editable material settings while simplifying the growing draw code.

## 2. Prerequisites and starting checkpoint

Lesson 09 complete; textures and sunlight work on the cabin.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

Separate a material's data from a shader program and a pipeline state. Multiple materials can use the same shader and pipeline with different values and textures. Pipeline variants should correspond to actual GPU-state differences, not every object color.

Introduce a small material identifier, a material table, and explicit per-frame, per-object, and per-material data. A missing texture should have a documented fallback. Data organization matters because the GPU sees bindings and byte layouts, not Swift object relationships.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 10.1.** List shader inputs as frame, object, or material data. Map each to an argument-table slot and backing allocation. Explain which bindings may change while encoding and which referenced bytes must remain stable until GPU completion.

2. **Task 10.2.** Introduce a small material record with base color, a texture reference, and any current lighting parameters. Create shared wood, stone, roof, and ground entries.

3. **Task 10.3.** Refactor objects to reference materials. Use deliberately sized Metal 4 argument tables for the stages that need them, and keep all allocations resident and strongly owned. Preserve the image and update one boundary at a time.

4. **Task 10.4.** Define fallback textures or a deliberate untextured path. Add a few simple UI/debug controls for selected material values with bounds and meaningful labels.

5. **Task 10.5.** Label pipeline, buffer, and texture resources for captures. Write a short rendering-data map: where a material is created, selected, bound, and consumed.

## 5. Predict-and-observe experiments

Change the shared wood material and predict which objects change. Then make one object use a distinct material instance. Remove a texture asset temporarily and verify the fallback/error message instead of a crash.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

A new material should not compile a pipeline every frame. A Swift object reference is not GPU material data. MTL4ArgumentTable is the standard binding mechanism here and is different from a shader-defined argument buffer. A table snapshot does not snapshot the bytes of your material buffer; use distinct records for draws.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Multiple objects share material data intentionally and one can override it.
- [ ] Material edits do not recreate pipelines or immutable meshes per frame.
- [ ] Fallback behavior and bindings are easy to explain and inspect.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Compare images before/after refactoring and inspect ownership and binding consistency. Accept a simple switch or table where it is clear; do not grade design-pattern sophistication.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- What is the difference between material data and pipeline state?
- Which resource should own the lifetime of a shared texture?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 10: organize materials without building an engine`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R04](../REFERENCE.md#r04) · [R06](../REFERENCE.md#r06) · [R09](../REFERENCE.md#r09) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. This is a consolidation lesson. No node-based material editor, hot-reload system, or generic serialization framework.
