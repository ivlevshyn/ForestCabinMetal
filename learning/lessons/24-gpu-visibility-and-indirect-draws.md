# 24 — Let the GPU choose visible instances

**Track:** Advanced · **Implementation effort hint:** 5–8 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 23](./23-visibility-and-lod.md) · [Next: 25](./25-normal-mapping.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Move one well-understood tree-batch visibility decision onto the GPU and draw the compacted result using indirect draw arguments.

## 2. Prerequisites and starting checkpoint

Lesson 23 complete, plus compute and frame-lifetime concepts from 21–22.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

A GPU visibility pass tests candidate bounds, writes visible instance IDs, and produces an indirect instance count. An atomic counter lets multiple threads reserve unique output slots; it does not by itself synchronize an entire dispatch. Rendering follows only after writes are complete and visible under the applicable Metal synchronization model.

Begin with a single compatible mesh/material batch and ordinary indirect indexed drawing. This is simpler than an indirect command buffer (ICB), which stores whole commands. Preserve original instance IDs through compaction so transforms, colors, and animation stay attached to the correct tree.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 24.1.** Disable LOD for one diagnostic tree batch and preserve the CPU-culling reference. Define input bounds, output-ID capacity, counter, and exact Metal indirect-argument layout.

2. **Task 24.2.** Reset the output count with a Metal 4 blit/fill or small compute step. Insert the correct producer-to-dispatch dependency before culling. Each candidate then tests its bound, reserves an output slot atomically, and writes the original ID with capacity checks.

3. **Task 24.3.** Finalize indirect arguments in a separate ordered dispatch when needed. Add dispatch-to-dispatch synchronization explicitly. One thread cannot assume all other threadgroups have finished merely because it is writing the final record.

4. **Task 24.4.** Use the Metal 4 indirect draw overload with valid GPU addresses and index-buffer length. Make the indirect record, IDs, and original instance data resident and retained. Protect generated draw arguments and shader-read IDs with the correct producer/consumer stage dependencies from the SDK docs; do not guess the indirect-fetch stage. No per-frame CPU count readback.

5. **Task 24.5.** Compare GPU and CPU visible sets in a deliberate completed-frame readback for small deterministic cases. Exercise zero visible, all visible, boundary objects, and capacity limits.

6. **Task 24.6.** Measure costs at multiple scene sizes. Keep the simpler CPU path if the GPU path is slower for the actual cabin scene; the learning objective is an accurate comparison.

## 5. Common mistakes and investigation

A threadgroup barrier does not synchronize separate threadgroups. Resetting a counter from one invocation of the same global culling dispatch is unsafe. A count that exceeds output capacity can trigger out-of-bounds drawing. Confusing indirect arguments with an ICB obscures ownership and required API support.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R04](../REFERENCE.md#r04) · [R15](../REFERENCE.md#r15) · [R16](../REFERENCE.md#r16) · [R17](../REFERENCE.md#r17) · [R18](../REFERENCE.md#r18) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. One batch is sufficient for completion. Multiple LOD bins and ICB command generation are optional extensions after this foundation.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Shuffle input instance order and verify that each tree keeps its appearance. Compare sets rather than output ordering because atomic compaction order may vary. Discuss when that nondeterminism matters for transparent objects.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Indirect drawing consumes a valid GPU-produced count without routine CPU readback.
- [ ] GPU visible sets agree with the CPU reference in controlled cases.
- [ ] Counter reset, capacity, stage dependencies, and original-ID mapping are correct.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why cannot one thread finalize a global count before other groups finish?
- What information must survive compaction besides the number of visible trees?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Inspect argument struct sizes/types, atomic reservation, dispatch boundaries, shader indirection, and synchronization assumptions. Require validation and edge-count evidence; compare actual cost instead of assuming improvement.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 24: let the gpu choose visible instances`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
