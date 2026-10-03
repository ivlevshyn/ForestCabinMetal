# 20 — Finish and explain the core diorama

**Track:** Core · **Implementation effort hint:** 3–5 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 19](./19-bloom-and-pass-order.md) · [Next: 21](./21-compute-fireflies.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Reach a coherent first finished scene and establish an evidence-based performance baseline before adding advanced features.

## 2. Prerequisites and starting checkpoint

Lessons 01–19 complete or reviewed with explicit, resolved adaptations.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

Frame rate is a result of several interacting limits: CPU submission, GPU work, synchronization, and presentation pacing. Frame time is easier to reason about than FPS when adding costs. A prettier image does not prove a correct pipeline, and a lower draw count does not prove a faster renderer.

Use a fixed scene seed, camera, drawable pixel resolution, settings, and build configuration. Distinguish debug-validation overhead from normal execution. A profile should answer a question about a bottleneck, not merely produce a screenshot of a profiler.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 20.1.** Choose final core day and dusk camera presets. Review cabin proportions, terrain contact, tree distribution, material readability, shadows, wind, and restrained bloom. Fix integration errors rather than adding features.

2. **Task 20.2.** Make a resource/pass table and explain the whole frame from Swift input to display. Include where depth, shadows, HDR, and bloom are produced and consumed.

3. **Task 20.3.** Capture a labeled frame and inspect the main draws and intermediate textures. Run available validation; investigate relevant warnings instead of suppressing them.

4. **Task 20.4.** Measure repeated runs after warm-up at a fixed resolution. Record CPU/GPU timing when tools provide it, draw/instance counts, and memory observations. If only frame time is available, state that limitation.

5. **Task 20.5.** Form one optimization hypothesis from evidence, make one reversible change, and compare before/after quality and timing. Revert it if there is no useful benefit.

6. **Task 20.6.** Update the app README with build/run instructions, controls, representative screenshots, environment, and known limitations. Complete a review using the core rubric below.

## 5. Common mistakes and investigation

V-sync can conceal a speed improvement in FPS. A GPU capture can alter timing. Comparing different camera poses or thermal conditions can invalidate conclusions. Do not rewrite the renderer just because a tool suggests a potential optimization.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R14](../REFERENCE.md#r14) · [R07](../REFERENCE.md#r07) · [R12](../REFERENCE.md#r12)

Read only what resolves the current question. This is a complete stopping point if you want a finished core project. The advanced path continues in the same repository and scene.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Reduce pixel resolution while keeping geometry fixed, then reduce tree count while keeping resolution fixed. Explain what each experiment suggests about the bottleneck; neither alone is conclusive proof.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] A reproducible day and dusk scene runs with working controls and feature toggles.
- [ ] The learner can explain every current pass and important resource lifetime.
- [ ] A baseline report records environment, settings, evidence, and one tested performance hypothesis.
- [ ] Core visual regressions and relevant validation errors are resolved or clearly scoped with reviewer agreement.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Where does each output image become an input?
- Which measured result would justify optimizing fragment work rather than CPU draw submission?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Review integration across the repository, not only the final diff. Sample earlier concepts with two practical questions. Assess technical correctness, evidence quality, and clarity; no universal FPS threshold applies without hardware/resolution context.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 20: finish and explain the core diorama`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
