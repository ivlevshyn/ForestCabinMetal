# 22 — Manage frames in flight deliberately

**Track:** Advanced · **Implementation effort hint:** 4–6 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 21](./21-compute-fireflies.md) · [Next: 23](./23-visibility-and-lod.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Extend the correct single-slot Metal 4 renderer into several frames in flight while preserving command memory, uniform data, and all inter-pass/inter-frame dependencies.

## 2. Prerequisites and starting checkpoint

Lesson 21 complete; asynchronous command submission and compute/render dependencies are understood.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

The early renderer deliberately waits for a slot to be available before CPU reuse; it does not teach unsafe overwriting. Now allow CPU preparation to overlap earlier GPU frames. Each frame context owns a command allocator, mutable uniform regions, retained resources, and its last completion value. Reset an allocator and rewrite its data only after completion is known.

GPU/GPU dependencies remain explicit in Metal 4 even on one queue. Shared shadow/HDR/compute targets may create cross-frame read-after-write, write-after-read, and write-after-write conflicts. Either allocate the needed per-slot targets or express the dependencies correctly. Residency, object retention, argument-table snapshots, and barriers solve different problems. A reusable command-buffer object is not the same as reusable allocator memory.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 22.1.** Inventory every allocation and command allocator with its writer, reader, lifetime, residency set, and completion owner. Mark which targets are shared across frames and which must be duplicated.

2. **Task 22.2.** Design two or three frame slots, each with an allocator and safe dynamic-data regions. Track the last queue-signaled shared-event value for each slot. Draw the CPU/GPU timeline before implementing it.

3. **Task 22.3.** Replace the single-slot gate with available-slot selection. Only reset a completed slot. Encode with the matching allocator, update argument-table addresses for its immutable-for-this-frame data, and submit through MTL4CommandQueue.

4. **Task 22.4.** Audit GPU dependencies across frames, not just within one frame. A shared particle buffer must finish earlier render reads before a later update writes it. Add the correct queue-scoped dependencies or use a justified per-slot/ping-pong design.

5. **Task 22.5.** Handle early returns, reported GPU errors, and resource retirement without waiting for an unsignaled value or releasing an in-flight allocation. Retain old resize targets until their last use completes, and update residency safely.

6. **Task 22.6.** Stress camera motion, resize, particle changes, and pause/resume. Compare one slot with several under identical settings. Record overlap, memory, latency, and any target duplication cost.

## 5. Common mistakes and investigation

A modulo index does not prove a slot is available. Reusing a command-buffer object does not permit resetting its previous allocator early. Metal 4 does not gain automatic hazard tracking from a tracked flag. A binding table can be updated while backing bytes still require lifetime protection. Avoid an unbounded main-thread wait.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R07](../REFERENCE.md#r07) · [R14](../REFERENCE.md#r14) · [R21](../REFERENCE.md#r21) · [R23](../REFERENCE.md#r23) · [R25](../REFERENCE.md#r25) · [R26](../REFERENCE.md#r26) · [R28](../REFERENCE.md#r28)

Read only what resolves the current question. Keep one queue and ordinary allocations. Heaps, aliasing, and multiple queues remain outside this lesson; explicit hazards are already required by Metal 4.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Draw an unsafe allocator reset and an unsafe uniform overwrite on a timeline, then show which completion check prevents each. Compare one and several slots. Explain a cross-frame hazard that remains even though CPU uniform writes are safe.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Every frame slot has a documented allocator, mutable-data, residency, retention, and completion policy.
- [ ] GPU dependencies are correct both within frames and across shared targets between frames.
- [ ] Early exits and resize do not strand slots or release referenced resources.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why can the command-buffer object be reusable before its allocator memory may be reset?
- Which GPU hazards remain after the CPU frame-slot ring is correct?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Inspect every allocator reset, mutable write, event-value assignment, skipped-frame path, retained-resource retirement, and cross-frame target reuse. Require a timeline plus stress observations; several successful frames do not prove absence of races.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 22: manage frames in flight deliberately`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
