# 13 — Render shadows from the sun

**Track:** Core · **Implementation effort hint:** 4–6 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 12](./12-instanced-forest.md) · [Next: 14](./14-sky-and-distance-fog.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Make the cabin, roof, and trees cast shadows onto the clearing using a directional-light shadow map.

## 2. Prerequisites and starting checkpoint

Lesson 12 complete; depth testing, coordinate spaces, and textures are understood.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

A shadow map is a depth image rendered from the light's viewpoint. The main pass transforms a surface into the light's clip space, converts to shadow texture coordinates, and compares its depth with the stored nearest depth. This tests visibility to the sun; it is separate from visibility to the camera.

A directional sun uses an orthographic light projection over the clearing. Introduce a second pass and a depth-only pipeline. The shadow texture must be stored after the light pass and usable by the main shader. Explain bias as a finite-precision workaround with tradeoffs, then small percentage-closer filtering (PCF) as an average of visibility comparisons, not blurred geometry.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 13.1.** Sketch both camera and light views. Define fixed light-space bounds that cover the compact scene. Derive or explain the matching orthographic matrix with Metal depth conventions.

2. **Task 13.2.** Allocate a resident shadow depth texture and compile a depth-only Metal 4 pipeline. Draw opaque casters with the same transforms as the main pass. Teach the first GPU producer/consumer dependency here: the later sampling pass needs an explicit Metal 4 barrier or fence after the shadow producer stage. Label and inspect both passes.

3. **Task 13.3.** Add a debug view of the shadow texture. Confirm that the roof and trees appear from the light view before trying to sample it for lighting.

4. **Task 13.4.** Transform main-pass surfaces into light coordinates, derive shadow UV/depth mapping, and handle outside coverage. Bind the shadow texture through a fragment argument table. Add a stage-correct dependency between shadow writes and reads: merely ending one encoder and starting another is not a synchronization guarantee in Metal 4.

5. **Task 13.5.** Apply shadow visibility to direct sunlight only. Tune a small documented bias, then add a small PCF neighborhood. Preserve the ambient placeholder and compare hard versus filtered edges.

## 5. Common mistakes and investigation

Depth from the camera cannot be compared directly with light-space depth. A discarded shadow attachment contains no reliable later image. Applying shadow visibility to all ambient light makes unrealistically black regions. Too-wide light bounds waste resolution.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R08](../REFERENCE.md#r08) · [R10](../REFERENCE.md#r10) · [R11](../REFERENCE.md#r11) · [R07](../REFERENCE.md#r07) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. One fixed-resolution map covering the clearing is sufficient. Cascaded shadows and temporal stabilization are optional later work.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Move the sun and predict shadow direction and length. Compare low and high shadow resolution, then too little and too much bias. Test a roof overhang where detached shadows are easy to see.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Cabin and trees cast coherent moving shadows on the ground.
- [ ] The shadow debug texture and coordinate mapping are explainable.
- [ ] Bias and coverage behavior are controlled, and the main pass samples a valid stored resource.
- [ ] A producer/consumer table and an explicit Metal 4 dependency protect shadow-map sampling.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why is a second view of the scene necessary?
- Why should increasing bias not be the first response to every shadow artifact?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Review pass order, attachment actions/usage, format compatibility, all caster transforms, comparison direction, and bounds. Require a capture plus a bias tradeoff explanation.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 13: render shadows from the sun`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
