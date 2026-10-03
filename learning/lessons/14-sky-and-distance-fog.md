# 14 — Give the clearing a sky and atmosphere

**Track:** Core · **Implementation effort hint:** 2–4 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 13](./13-sun-shadows.md) · [Next: 15](./15-linear-hdr-pipeline.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Replace the flat background with a procedural sky gradient and use controllable distance fog to separate nearby cabin forms from distant trees.

## 2. Prerequisites and starting checkpoint

Lesson 13 complete; multiple passes and sun direction exist.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

A sky is a background evaluated from view direction. Translation should not make an infinitely distant sky slide, but camera rotation should change the viewed direction. Begin with a simple artistic zenith/horizon gradient and an optional small sun disc; this is not a physical atmosphere model.

Fog blends surface radiance toward a fog color based on distance. Use view-space or world-space distance consistently, not nonlinear depth-buffer values directly. An exponential model has transmittance T = exp(-density × distance), then color = T × surface + (1-T) × fog. Explain the limiting cases before implementation.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 14.1.** Implement a sky using a full-screen triangle and a reconstructed view direction, or a documented equivalent background mesh. Explain the chosen depth and draw-order policy.

2. **Task 14.2.** Make a horizon-to-zenith gradient and connect its sun direction to the same scene sun. Verify camera translation and rotation separately.

3. **Task 14.3.** Compute a meaningful distance for each opaque surface and apply the explained fog equation. Keep density nonnegative and provide an off switch.

4. **Task 14.4.** Choose a fog color compatible with the horizon and add controls for density and color. Preserve a clear-weather preset for debugging.

5. **Task 14.5.** Compare near, mid-distance, and far tree silhouettes from a fixed pose. Record the approximation and distinguish it from the later volumetric-fog lesson.

## 5. Common mistakes and investigation

Using raw depth as distance gives strange near/far-dependent fog. A sky that writes near depth can hide all scene objects. A camera matrix with translation included in a direction transform can make the sky move incorrectly.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R05](../REFERENCE.md#r05) · [R10](../REFERENCE.md#r10) · [R11](../REFERENCE.md#r11)

Read only what resolves the current question. No atmospheric scattering, ray marching, or volumetric light shafts yet.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Predict fog at zero density, zero distance, and very large distance. Translate the camera sideways without rotating and observe the sky. Compare a linear-distance ramp with exponential fog without confusing either with physical scattering.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Sky covers only background and responds correctly to camera orientation.
- [ ] Fog has sensible limiting behavior and an off preset.
- [ ] Cabin and near trees remain readable while distant trees separate visually.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why is the depth-buffer value not generally distance in meters?
- Which camera motion should affect an infinitely distant sky?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Inspect direction reconstruction, depth/write policy, fog distance units, and color-space assumptions. Check evidence that fog changes with distance as intended; a fog-off/on comparison is optional.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 14: give the clearing a sky and atmosphere`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
