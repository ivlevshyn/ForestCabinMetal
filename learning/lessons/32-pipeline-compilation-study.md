# 32 — Elective: control Metal 4 pipeline compilation

**Track:** Elective · **Planning hint:** 4–7 small sessions (flexible, not a deadline)

[Prerequisite: 30](./30-advanced-capstone.md) · [Other elective: 31](./31-hybrid-ray-tracing.md) · [Course entry](../README.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Investigate startup and pipeline-creation cost in the existing Metal 4 renderer, then implement one measured improvement without changing scene behavior.

## 2. Prerequisites and starting checkpoint

Lesson 30 complete. Lesson 31 is not required. MTL4Compiler has already been used since lesson 02; this elective deepens that knowledge.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

Compilation translates shader representations and pipeline configurations into work executable by the GPU. It has CPU time and memory costs distinct from the GPU cost of running those shaders. Learn what happens at app build, startup, first use, and later reuse.

Study asynchronous compiler tasks, reusable pipeline variants, and pipeline harvesting/binary archives as separate options. Choose one based on a measured problem. A more elaborate compilation system is not automatically better for a small diorama, and a cache must match the relevant pipeline configuration and supported environment.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 32.1.** List pipelines, their shader functions, formats, sample counts, and creation times. Measure startup and first use separately from steady rendering; record warm versus cold conditions honestly.

2. **Task 32.2.** Identify one concrete issue: a blocking compile during interaction, duplicate equivalent pipelines, or repeat startup compilation worth studying. Establish a baseline and a narrow success criterion.

3. **Task 32.3.** Read the relevant current MTL4Compiler API. Choose one intervention: asynchronous creation with safe fallback behavior, reuse of equivalent variants, or a documented harvesting/archive workflow. Explain its ownership and invalidation rules before implementation.

4. **Task 32.4.** Implement the selected change in a small local branch. Never draw with an incomplete pipeline. Retain dependencies, publish completed state safely to the rendering thread, and handle compiler errors visibly.

5. **Task 32.5.** Compare the same day/dusk images and measure the affected CPU/startup behavior. Include the cost of cache misses or asynchronous scheduling rather than reporting only a best-case run.

6. **Task 32.6.** Write a decision note explaining the improvement, memory/complexity cost, and whether it belongs in the main renderer. Keeping the simpler baseline after a fair experiment is a valid result.

## 5. Predict-and-observe experiments

Change one pipeline-defining setting and predict whether an existing state/cache entry remains valid. Compare startup with steady-state GPU time to show they are different quantities. Exercise a controlled compile error and recover without replacing the entire renderer.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

Asynchronous compilation does not guarantee a pipeline is ready by the next draw. A cache key that omits format or specialization inputs may select an incompatible state. Faster startup does not mean faster shaders. Do not claim a cold-cache measurement without knowing which caches were actually cleared.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] A measured compilation question and reproducible baseline exist.
- [ ] One Metal 4 compilation improvement is evaluated with safe ownership/error behavior.
- [ ] Image equivalence and CPU/startup results support a clear keep-or-revert decision.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Inspect compiler task lifecycle, cache/variant keys if applicable, thread handoff, error handling, and measurement conditions. Judge the evidence and reasoning, not whether an optimization was retained.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Which cost changes when you compile earlier but run the same shader?
- What must be known before a cached pipeline is safe to reuse?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 32: elective: control metal 4 pipeline compilation`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R24](../REFERENCE.md#r24) · [R14](../REFERENCE.md#r14) · [R21](../REFERENCE.md#r21)

Read only what resolves the current question. Choose one compilation topic. This is an elective refinement of a renderer already built with Metal 4, not an API migration.
