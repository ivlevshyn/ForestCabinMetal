# 10 — Organize materials without building an engine

**Track:** Core · **Implementation effort hint:** 2–3 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 09](./09-textures-and-samplers.md) · [Next: 11](./11-terrain-and-placement.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach this lesson in manageable steps across messages, with thorough plain-language theory, worked examples, and explained snippets with exact placement. Deliver the current step and pause before continuing. Keep understanding questions until the end of the entire lesson; no per-step quizzes or mandatory commits. Check file responsibilities before extending them and teach small extractions before code causes bloat. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Give wood, stone, roof, and ground distinct editable material settings while simplifying the growing draw code.

## 2. Prerequisites and starting checkpoint

Lesson 09 complete; textures and sunlight work on the cabin.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

Separate a material's data from a shader program and a pipeline state. Multiple materials can use the same shader and pipeline with different values and textures. Pipeline variants should correspond to actual GPU-state differences, not every object color.

Introduce a small material identifier, a material table, and explicit per-frame, per-object, and per-material data. A missing texture should have a documented fallback. Data organization matters because the GPU sees bindings and byte layouts, not Swift object relationships.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Explain the concepts needed for each step and demonstrate predictions yourself; ask understanding questions only in the final section of the entire lesson.

## 4. Explained implementation walkthrough

Use these task IDs to plan manageable teaching steps across messages. Deliver one coherent step at a time, grouping related tasks or splitting a large task as needed. Explain the theory and show clear Swift/MSL snippets with the actual file, type/function, add/replace action, insertion anchor, and dependencies. First check whether affected files have clear responsibilities; teach a focused extraction before adding code if needed. Include expected behavior and relevant implementation checks, then pause for the learner to apply the step or ask for help. Keep understanding questions and learner calculations until the end of the entire lesson; demonstrate predictions yourself in earlier steps. Do not require per-step commits or formal reviews. Exploratory changes and extra variations remain optional.

1. **Task 10.1.** List shader inputs as frame, object, or material data. Map each to an argument-table slot and backing allocation. Explain which bindings may change while encoding and which referenced bytes must remain stable until GPU completion.

2. **Task 10.2.** Introduce a small material record with base color, a texture reference, and any current lighting parameters. Create shared wood, stone, roof, and ground entries.

3. **Task 10.3.** Refactor objects to reference materials. Use deliberately sized Metal 4 argument tables for the stages that need them, and keep all allocations resident and strongly owned. Preserve the image and update one boundary at a time.

4. **Task 10.4.** Define fallback textures or a deliberate untextured path. Add a few simple UI/debug controls for selected material values with bounds and meaningful labels.

5. **Task 10.5.** Label pipeline, buffer, and texture resources for captures. Write a short rendering-data map: where a material is created, selected, bound, and consumed.

## 5. Common mistakes and investigation

A new material should not compile a pipeline every frame. A Swift object reference is not GPU material data. MTL4ArgumentTable is the standard binding mechanism here and is different from a shader-defined argument buffer. A table snapshot does not snapshot the bytes of your material buffer; use distinct records for draws.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R04](../REFERENCE.md#r04) · [R06](../REFERENCE.md#r06) · [R09](../REFERENCE.md#r09) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. This is a consolidation lesson. No node-based material editor, hot-reload system, or generic serialization framework.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section after the final teaching step, once all lesson theory and code have been explained. The learner may already have applied earlier steps. Collect all understanding questions here, along with the final checklist and submission directions; do not distribute quizzes across step boundaries.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Change the shared wood material and predict which objects change. Then make one object use a distinct material instance. Remove a texture asset temporarily and verify the fallback/error message instead of a crash.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Multiple objects share material data intentionally and one can override it.
- [ ] Material edits do not recreate pipelines or immutable meshes per frame.
- [ ] Fallback behavior and bindings are easy to explain and inspect.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- What is the difference between material data and pipeline state?
- Which resource should own the lifetime of a shared texture?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Compare images before/after refactoring and inspect ownership and binding consistency. Accept a simple switch or table where it is clear; do not grade design-pattern sophistication.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 10: organize materials without building an engine`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
