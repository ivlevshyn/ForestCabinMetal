# 18 — Animate foliage and preserve its silhouette

**Track:** Core · **Implementation effort hint:** 3–5 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 17](./17-porch-light-and-emission.md) · [Next: 19](./19-bloom-and-pass-order.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Add leaf cards or simple cutout foliage and gentle wind while making visible trees and their shadows agree.

## 2. Prerequisites and starting checkpoint

Lesson 17 complete; instancing, time, textures, and shadow passes work.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

Alpha testing discards fragments below a mask threshold, leaving surviving fragments opaque and depth-writing. It is useful for leaf silhouettes. It differs from alpha blending, which combines colors and often needs ordering and different depth-write policy. Use alpha-tested leaves for this lesson.

Vertex deformation changes shape without rewriting mesh buffers. A wind function can depend on time, instance seed, position, and a height-based weight that leaves the trunk base fixed. The shadow pass must apply the same deformation and alpha-mask decision. Alpha is coverage data and should not be gamma transformed as a color channel.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 18.1.** Add a small crossed-card canopy or selected leaf clusters using a simple mask texture. Explain the mask threshold and render both sides with an explicit normal policy if leaves are two-sided.

2. **Task 18.2.** Implement alpha discard in the main foliage shader. Keep the opaque terrain/cabin path unchanged and use a distinct pipeline only where state genuinely differs.

3. **Task 18.3.** Add the same mask sampling to the shadow pass, using a fragment function in the depth-only pass when needed. Verify that rectangular cards do not cast solid rectangular shadows.

4. **Task 18.4.** Implement a small wind displacement with a pinned base and per-instance phase. Reuse the deformation logic or equivalent tested math in main and shadow vertex paths.

5. **Task 18.5.** Pause time and compare visible leaves to their shadows. Record that normals under deformation are an approximation unless you also update them correctly. Keep the wind amplitude modest.

## 5. Common mistakes and investigation

Treating cutout leaves as conventional blended quads creates avoidable sorting problems. Culling both back-facing sides can make a card vanish from one direction. Reusing main-pass transforms without the same animation still gives incorrect moving shadows.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R05](../REFERENCE.md#r05) · [R09](../REFERENCE.md#r09) · [R11](../REFERENCE.md#r11) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. No order-independent transparency, physically simulated branches, or per-leaf skeleton. Transparent smoke belongs to a separate future experiment.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Raise the mask threshold and predict the silhouette change. Disable wind in only the shadow pass to recognize the mismatch, then restore it. View distant leaves with mipmaps and note edge/shimmer limitations for later anti-aliasing work.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Leaf cutouts, depth behavior, and two-sided appearance are intentional.
- [ ] Main and shadow passes agree on alpha coverage and wind position.
- [ ] Wind pauses, resets, and stays stable across frame rates.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why does alpha testing still work with ordinary opaque depth writes?
- Why must a shadow renderer know about leaf texture alpha?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Review shared deformation inputs, alpha handling, shadow fragment configuration, and normal approximation. Require paused side-by-side silhouette/shadow evidence.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 18: animate foliage and preserve its silhouette`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
