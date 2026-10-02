# 22 — Manage frames in flight deliberately

**Track:** Advanced · **Planning hint:** 4–6 small sessions (flexible, not a deadline)

[Previous: 21](./21-compute-fireflies.md) · [Next: 23](./23-visibility-and-lod.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Extend the correct single-slot Metal 4 renderer into several frames in flight while preserving command memory, uniform data, and all inter-pass/inter-frame dependencies.

## 2. Prerequisites and starting checkpoint

Lesson 21 complete; asynchronous command submission and compute/render dependencies are understood.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

The early renderer deliberately waits for a slot to be available before CPU reuse; it does not teach unsafe overwriting. Now allow CPU preparation to overlap earlier GPU frames. Each frame context owns a command allocator, mutable uniform regions, retained resources, and its last completion value. Reset an allocator and rewrite its data only after completion is known.

GPU/GPU dependencies remain explicit in Metal 4 even on one queue. Shared shadow/HDR/compute targets may create cross-frame read-after-write, write-after-read, and write-after-write conflicts. Either allocate the needed per-slot targets or express the dependencies correctly. Residency, object retention, argument-table snapshots, and barriers solve different problems. A reusable command-buffer object is not the same as reusable allocator memory.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 22.1.** Inventory every allocation and command allocator with its writer, reader, lifetime, residency set, and completion owner. Mark which targets are shared across frames and which must be duplicated.

2. **Task 22.2.** Design two or three frame slots, each with an allocator and safe dynamic-data regions. Track the last queue-signaled shared-event value for each slot. Draw the CPU/GPU timeline before implementing it.

3. **Task 22.3.** Replace the single-slot gate with available-slot selection. Only reset a completed slot. Encode with the matching allocator, update argument-table addresses for its immutable-for-this-frame data, and submit through MTL4CommandQueue.

4. **Task 22.4.** Audit GPU dependencies across frames, not just within one frame. A shared particle buffer must finish earlier render reads before a later update writes it. Add the correct queue-scoped dependencies or use a justified per-slot/ping-pong design.

5. **Task 22.5.** Handle early returns, reported GPU errors, and resource retirement without waiting for an unsignaled value or releasing an in-flight allocation. Retain old resize targets until their last use completes, and update residency safely.

6. **Task 22.6.** Stress camera motion, resize, particle changes, and pause/resume. Compare one slot with several under identical settings. Record overlap, memory, latency, and any target duplication cost.

## 5. Predict-and-observe experiments

Draw an unsafe allocator reset and an unsafe uniform overwrite on a timeline, then show which completion check prevents each. Compare one and several slots. Explain a cross-frame hazard that remains even though CPU uniform writes are safe.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

A modulo index does not prove a slot is available. Reusing a command-buffer object does not permit resetting its previous allocator early. Metal 4 does not gain automatic hazard tracking from a tracked flag. A binding table can be updated while backing bytes still require lifetime protection. Avoid an unbounded main-thread wait.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Every frame slot has a documented allocator, mutable-data, residency, retention, and completion policy.
- [ ] GPU dependencies are correct both within frames and across shared targets between frames.
- [ ] Early exits and resize do not strand slots or release referenced resources.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Inspect every allocator reset, mutable write, event-value assignment, skipped-frame path, retained-resource retirement, and cross-frame target reuse. Require a timeline plus stress observations; several successful frames do not prove absence of races.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why can the command-buffer object be reusable before its allocator memory may be reset?
- Which GPU hazards remain after the CPU frame-slot ring is correct?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 22: manage frames in flight deliberately`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R07](../REFERENCE.md#r07) · [R14](../REFERENCE.md#r14) · [R21](../REFERENCE.md#r21) · [R23](../REFERENCE.md#r23) · [R25](../REFERENCE.md#r25) · [R26](../REFERENCE.md#r26) · [R28](../REFERENCE.md#r28)

Read only what resolves the current question. Keep one queue and ordinary allocations. Heaps, aliasing, and multiple queues remain outside this lesson; explicit hazards are already required by Metal 4.
