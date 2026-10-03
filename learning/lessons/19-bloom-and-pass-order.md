# 19 — Build a controlled bloom effect

**Track:** Core · **Implementation effort hint:** 3–5 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 18](./18-wind-and-cutout-foliage.md) · [Next: 20](./20-core-review-and-profiling.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Give the porch lamp and bright windows a restrained glow by building an inspectable multi-pass image effect.

## 2. Prerequisites and starting checkpoint

Lesson 18 complete; the HDR target and final tone-map pass are stable.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

Bloom takes bright linear HDR image regions, spreads some energy over neighboring pixels, and combines the result before tone mapping. It is a screen-space approximation, not illumination of scene geometry. A separable blur splits a 2D filter into horizontal and vertical passes, reducing samples for a chosen kernel.

Introduce ping-pong textures: each pass reads one image and writes another. Reading and writing the same attachment in an ordinary sampling pass is not a safe shortcut. A lower-resolution bloom chain is often sufficient but must be compared for quality.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 19.1.** Write every pass and intermediate allocation. Record argument-table bindings and residency, then draw producer/consumer dependencies and the Metal 4 barriers or fences that enforce them. Include read-before-reuse hazards when ping-pong targets are overwritten later.

2. **Task 19.2.** Extract a bright-region image using an explained threshold, optionally with a soft transition. Add a debug view of the extracted image before blurring.

3. **Task 19.3.** Implement horizontal and vertical blur passes with a small normalized kernel. Verify that a uniform image stays uniform and choose explicit edge addressing.

4. **Task 19.4.** Combine bloom with the HDR scene before exposure/tone mapping according to one documented convention. Expose strength and an off switch; avoid applying exposure twice.

5. **Task 19.5.** Try half-resolution processing, recreate targets on resize, and compare cost and appearance at a fixed scene/camera. Keep screenshots of extraction, blur, and final composition.

## 5. Common mistakes and investigation

A blur kernel whose weights do not sum appropriately changes brightness unexpectedly. Incorrect input dimensions create direction-dependent blur. Applying bloom after display gamma makes its behavior inconsistent. Reusing a target before its previous contents are consumed breaks pass dependencies.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R10](../REFERENCE.md#r10) · [R12](../REFERENCE.md#r12) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. Use fragment-based full-screen passes first. A compute rewrite is optional after lesson 21; automatic exposure is outside this lesson.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Predict the effect of doubling kernel radius and lowering threshold. Compare bloom on/off with the point light disabled to prove that the effect does not illuminate geometry. Test an extremely bright window for stability.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Bloom is inspectable at intermediate stages and has an exact off path.
- [ ] Ping-pong dependencies and target sizes are correct through resize.
- [ ] Emission, local lighting, and bloom remain conceptually distinct.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why can a separable filter need fewer samples?
- Why should blur read and write different images here?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Check resource usages, pass sequence, kernel weights, HDR composition, and resizing. Request a pass graph or dependency table plus intermediate images.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 19: build a controlled bloom effect`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
