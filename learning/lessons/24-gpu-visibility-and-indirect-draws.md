# 24 — Let the GPU choose visible instances

**Track:** Advanced · **Planning hint:** 5–8 small sessions (flexible, not a deadline)

[Previous: 23](./23-visibility-and-lod.md) · [Next: 25](./25-normal-mapping.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Move one well-understood tree-batch visibility decision onto the GPU and draw the compacted result using indirect draw arguments.

## 2. Prerequisites and starting checkpoint

Lesson 23 complete, plus compute and frame-lifetime concepts from 21–22.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

A GPU visibility pass tests candidate bounds, writes visible instance IDs, and produces an indirect instance count. An atomic counter lets multiple threads reserve unique output slots; it does not by itself synchronize an entire dispatch. Rendering follows only after writes are complete and visible under the applicable Metal synchronization model.

Begin with a single compatible mesh/material batch and ordinary indirect indexed drawing. This is simpler than an indirect command buffer (ICB), which stores whole commands. Preserve original instance IDs through compaction so transforms, colors, and animation stay attached to the correct tree.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 24.1.** Disable LOD for one diagnostic tree batch and preserve the CPU-culling reference. Define input bounds, output-ID capacity, counter, and exact Metal indirect-argument layout.

2. **Task 24.2.** Reset the output count with a Metal 4 blit/fill or small compute step. Insert the correct producer-to-dispatch dependency before culling. Each candidate then tests its bound, reserves an output slot atomically, and writes the original ID with capacity checks.

3. **Task 24.3.** Finalize indirect arguments in a separate ordered dispatch when needed. Add dispatch-to-dispatch synchronization explicitly. One thread cannot assume all other threadgroups have finished merely because it is writing the final record.

4. **Task 24.4.** Use the Metal 4 indirect draw overload with valid GPU addresses and index-buffer length. Make the indirect record, IDs, and original instance data resident and retained. Protect generated draw arguments and shader-read IDs with the correct producer/consumer stage dependencies from the SDK docs; do not guess the indirect-fetch stage. No per-frame CPU count readback.

5. **Task 24.5.** Compare GPU and CPU visible sets in a deliberate completed-frame readback for small deterministic cases. Exercise zero visible, all visible, boundary objects, and capacity limits.

6. **Task 24.6.** Measure costs at multiple scene sizes. Keep the simpler CPU path if the GPU path is slower for the actual cabin scene; the learning objective is an accurate comparison.

## 5. Predict-and-observe experiments

Shuffle input instance order and verify that each tree keeps its appearance. Compare sets rather than output ordering because atomic compaction order may vary. Discuss when that nondeterminism matters for transparent objects.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

A threadgroup barrier does not synchronize separate threadgroups. Resetting a counter from one invocation of the same global culling dispatch is unsafe. A count that exceeds output capacity can trigger out-of-bounds drawing. Confusing indirect arguments with an ICB obscures ownership and required API support.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Indirect drawing consumes a valid GPU-produced count without routine CPU readback.
- [ ] GPU visible sets agree with the CPU reference in controlled cases.
- [ ] Counter reset, capacity, stage dependencies, and original-ID mapping are correct.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Inspect argument struct sizes/types, atomic reservation, dispatch boundaries, shader indirection, and synchronization assumptions. Require validation and edge-count evidence; compare actual cost instead of assuming improvement.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why cannot one thread finalize a global count before other groups finish?
- What information must survive compaction besides the number of visible trees?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 24: let the gpu choose visible instances`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R04](../REFERENCE.md#r04) · [R15](../REFERENCE.md#r15) · [R16](../REFERENCE.md#r16) · [R17](../REFERENCE.md#r17) · [R18](../REFERENCE.md#r18) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. One batch is sufficient for completion. Multiple LOD bins and ICB command generation are optional extensions after this foundation.
