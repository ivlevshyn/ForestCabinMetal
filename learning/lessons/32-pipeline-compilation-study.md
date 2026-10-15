# 32 — Elective: control Metal 4 pipeline compilation

**Track:** Elective · **Implementation effort hint:** 4–7 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Prerequisite: 30](./30-advanced-capstone.md) · [Other elective: 31](./31-hybrid-ray-tracing.md) · [Course entry](../README.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach this lesson in manageable steps across messages, with thorough plain-language theory, worked examples, and explained snippets with exact placement. Deliver the current step and pause before continuing. Keep understanding questions until the end of the entire lesson; no per-step quizzes or mandatory commits. Check file responsibilities before extending them and teach small extractions before code causes bloat. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Investigate startup and pipeline-creation cost in the existing Metal 4 renderer, then implement one measured improvement without changing scene behavior.

## 2. Prerequisites and starting checkpoint

Lesson 30 complete. Lesson 31 is not required. MTL4Compiler has already been used since lesson 02; this elective deepens that knowledge.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

Compilation translates shader representations and pipeline configurations into work executable by the GPU. It has CPU time and memory costs distinct from the GPU cost of running those shaders. Learn what happens at app build, startup, first use, and later reuse.

Study asynchronous compiler tasks, reusable pipeline variants, and pipeline harvesting/binary archives as separate options. Choose one based on a measured problem. A more elaborate compilation system is not automatically better for a small diorama, and a cache must match the relevant pipeline configuration and supported environment.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Explain the concepts needed for each step and demonstrate predictions yourself; ask understanding questions only in the final section of the entire lesson.

## 4. Explained implementation walkthrough

Use these task IDs to plan manageable teaching steps across messages. Deliver one coherent step at a time, grouping related tasks or splitting a large task as needed. Explain the theory and show clear Swift/MSL snippets with the actual file, type/function, add/replace action, insertion anchor, and dependencies. First check whether affected files have clear responsibilities; teach a focused extraction before adding code if needed. Include expected behavior and relevant implementation checks, then pause for the learner to apply the step or ask for help. Keep understanding questions and learner calculations until the end of the entire lesson; demonstrate predictions yourself in earlier steps. Do not require per-step commits or formal reviews. Exploratory changes and extra variations remain optional.

1. **Task 32.1.** List pipelines, their shader functions, formats, sample counts, and creation times. Measure startup and first use separately from steady rendering; record warm versus cold conditions honestly.

2. **Task 32.2.** Identify one concrete issue: a blocking compile during interaction, duplicate equivalent pipelines, or repeat startup compilation worth studying. Establish a baseline and a narrow success criterion.

3. **Task 32.3.** Read the relevant current MTL4Compiler API. Choose one intervention: asynchronous creation with safe fallback behavior, reuse of equivalent variants, or a documented harvesting/archive workflow. Explain its ownership and invalidation rules before implementation.

4. **Task 32.4.** Implement the selected change in a small local branch. Never draw with an incomplete pipeline. Retain dependencies, publish completed state safely to the rendering thread, and handle compiler errors visibly.

5. **Task 32.5.** Compare the same day/dusk images and measure the affected CPU/startup behavior. Include the cost of cache misses or asynchronous scheduling rather than reporting only a best-case run.

6. **Task 32.6.** Write a decision note explaining the improvement, memory/complexity cost, and whether it belongs in the main renderer. Keeping the simpler baseline after a fair experiment is a valid result.

## 5. Common mistakes and investigation

Asynchronous compilation does not guarantee a pipeline is ready by the next draw. A cache key that omits format or specialization inputs may select an incompatible state. Faster startup does not mean faster shaders. Do not claim a cold-cache measurement without knowing which caches were actually cleared.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R24](../REFERENCE.md#r24) · [R14](../REFERENCE.md#r14) · [R21](../REFERENCE.md#r21)

Read only what resolves the current question. Choose one compilation topic. This is an elective refinement of a renderer already built with Metal 4, not an API migration.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section after the final teaching step, once all lesson theory and code have been explained. The learner may already have applied earlier steps. Collect all understanding questions here, along with the final checklist and submission directions; do not distribute quizzes across step boundaries.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Change one pipeline-defining setting and predict whether an existing state/cache entry remains valid. Compare startup with steady-state GPU time to show they are different quantities. Exercise a controlled compile error and recover without replacing the entire renderer.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] A measured compilation question and reproducible baseline exist.
- [ ] One Metal 4 compilation improvement is evaluated with safe ownership/error behavior.
- [ ] Image equivalence and CPU/startup results support a clear keep-or-revert decision.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Which cost changes when you compile earlier but run the same shader?
- What must be known before a cached pipeline is safe to reuse?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Inspect compiler task lifecycle, cache/variant keys if applicable, thread handoff, error handling, and measurement conditions. Judge the evidence and reasoning, not whether an optimization was retained.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 32: elective: control metal 4 pipeline compilation`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
