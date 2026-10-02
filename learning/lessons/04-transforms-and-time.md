# 04 — Move geometry with transforms and time

**Track:** Core · **Planning hint:** 3–4 small sessions (flexible, not a deadline)

[Previous: 03](./03-vertex-and-index-buffers.md) · [Next: 05](./05-perspective-and-depth.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Move, rotate, and scale the wall/roof pieces using per-draw transforms, and animate a controlled motion without changing the stored mesh.

## 2. Prerequisites and starting checkpoint

Lesson 03 complete; indexed geometry works. Tutor introduces vectors and matrices from zero here.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

A vector can describe a position or direction. A matrix is a transformation rule. Teach scale and translation numerically, then homogeneous coordinates: points have W = 1 and directions W = 0. Explain identity, column-vector multiplication, and why a 4×4 matrix can express translation.

With model = translation × rotation × scale, scale acts first. Uniforms are values shared by shader invocations for a draw. Store them in resident MTLBuffer memory and provide its address through MTL4ArgumentTable. Each draw needs its own stable record or byte region: encoding a draw snapshots bindings, not the memory contents they point to. The single-frame completion gate protects reuse between frames, but does not make overwriting one record for two pending draws safe. Animation uses time, not a fixed change per frame.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 04.1.** Transform two simple points by hand with identity and scale. Have the tutor explain matrix columns using a basis-vector picture; implement a scale constructor and test the numeric results in Swift.

2. **Task 04.2.** Design an aligned uniform record and allocate stable resident storage for it. Enter its GPU address in the argument table at a documented slot, apply the transform in MSL, and preserve immutable mesh data. Explain when the CPU may next write that region.

3. **Task 04.3.** Implement translation and a rotation about one axis from a supplied, explained equation. Predict the result for zero rotation and a quarter turn before running.

4. **Task 04.4.** Draw two objects using the same mesh and distinct uniform records or nonoverlapping byte regions. Before each draw select its record address in the argument table. Explain why changing a table entry is different from overwriting memory referenced by an earlier draw.

5. **Task 04.5.** Animate a gentle rotation using time. Add pause/reset controls and handle a long pause or app suspension without a large delta-time jump. Compare at two refresh/update rates if practical.

## 5. Predict-and-observe experiments

Reverse translation and rotation order and explain orbiting versus spinning. Transform a direction with W = 0 and show why translation does not change it. Return the cabin pieces to a stable pose.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

Degrees passed to a sine function expecting radians are not a matrix bug. Mutating vertex positions each frame hides the purpose of a model transform. Frame-based increments change speed with refresh rate. A single CPU-writable GPU buffer is not automatically safe because the Mac has unified memory.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Multiple objects reuse the same mesh with independent transforms.
- [ ] Animation is time-based and can be paused/reset.
- [ ] You can predict transform order and distinguish a point from a direction.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Check matrix order, column layout, time units, and constant lifetime. Ask for one hand-calculated transformed point and one visual order-of-operations experiment.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why keep original mesh positions unchanged?
- What does the rightmost matrix do in the adopted convention?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 04: move geometry with transforms and time`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R05](../REFERENCE.md#r05) · [R06](../REFERENCE.md#r06) · [R07](../REFERENCE.md#r07) · [R22](../REFERENCE.md#r22) · [R25](../REFERENCE.md#r25)

Read only what resolves the current question. Keep the view orthographic/clip-space for this lesson. No camera or projection matrix until the next section.
