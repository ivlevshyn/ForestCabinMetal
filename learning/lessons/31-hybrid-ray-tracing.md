# 31 — Elective: add one ray-traced effect

**Track:** Elective · **Implementation effort hint:** 6–10 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 30](./30-advanced-capstone.md) · [Next: 32](./32-pipeline-compilation-study.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Add a limited ray-traced reflection to a metal object or small reflective surface in the existing clearing, retaining the rasterized renderer as the baseline.

## 2. Prerequisites and starting checkpoint

Lesson 30 complete. Check the actual device/API ray-tracing capabilities first; hardware-accelerated tracing and API availability are distinct.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

Ray tracing finds intersections along a ray rather than projecting every triangle to the screen. Acceleration structures organize triangles and instances so the GPU can skip large amounts of geometry. A bottom-level structure describes geometry; an instance-level structure references transformed geometry. These conceptual levels must be mapped to the actual Metal API in the installed SDK.

Begin with static opaque geometry and one effect. Ray origin offsets avoid immediate self-intersection, but excessive offsets miss nearby detail. A reflected ray needs a hit-shading or environment fallback policy. This is hybrid rendering, not a complete path tracer or physically complete global illumination.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 31.1.** Query supported capabilities and read the current Apple sample requirements. If unsupported, document the blocker and skip this elective without affecting main-course completion.

2. **Task 31.2.** Build acceleration structures for a static cabin/ground/test-object subset through the supported Metal 4 compute-encoder build APIs. Validate device-specific support, residency, lifetime, transforms, and explicit acceleration-structure-build-to-ray-dispatch dependencies. If this path is unsupported, skip the elective instead of silently using an older command model.

3. **Task 31.3.** Trace a diagnostic ray image that reports hit/miss or surface IDs. Check known rays against simple geometry before adding material shading.

4. **Task 31.4.** Generate reflection rays for one selected material/surface from known positions and normals. Trace them in a compute pass and shade a simple first hit or use environment light on a miss.

5. **Task 31.5.** Composite the limited reflection into HDR using an explicit material/energy policy. Keep TAA/history effects controlled until the new buffer has a valid temporal policy.

6. **Task 31.6.** Compare with the environment-only baseline and measure cost. Describe omitted alpha-tested leaves, animated wind, and dynamic-geometry updates honestly; either implement them correctly or restrict the effect to the supported subset.

## 5. Common mistakes and investigation

Building a structure does not make it ready for GPU reads without the required completion/dependency handling. Raster and ray instance transforms must match. Triangle-only opaque tracing ignores leaf alpha unless explicitly handled. Ray-tracing support does not guarantee real-time performance for arbitrary workloads.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R20](../REFERENCE.md#r20) · [R18](../REFERENCE.md#r18) · [R16](../REFERENCE.md#r16) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. Choose one effect. No full path tracer, real-time denoiser research project, or renderer rewrite.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Move a reflected object offscreen and compare this result with a screen-space technique conceptually. Test ray-origin bias on close geometry. Compare a static versus moved instance and explain when structures need updating.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] A diagnostic hit test validates the traced geometry and transforms.
- [ ] One limited reflection effect integrates with the existing renderer and has a fallback.
- [ ] Supported geometry, update policy, image limitations, and measured cost are documented.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why can a reflected object be visible even when it is outside the main camera view?
- What changes when an instance moves versus when its vertices deform?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Check support gates, structure lifetime, build/use ordering, ray coordinates, and scope of geometry correctness. Do not accept a claim of complete scene ray tracing if foliage or animation is omitted.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 31: elective: add one ray-traced effect`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
