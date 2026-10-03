# 23 — Skip invisible trees and simplify distant ones

**Track:** Advanced · **Implementation effort hint:** 4–6 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 22](./22-frames-and-resource-lifetime.md) · [Next: 24](./24-gpu-visibility-and-indirect-draws.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Add CPU frustum culling and simple tree levels of detail, retaining a reference path that renders all trees for comparison.

## 2. Prerequisites and starting checkpoint

Lesson 22 complete; instanced trees and frame-resource management are stable.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

A view frustum is the volume visible through the camera. A bounding sphere or box is a conservative approximation of an object's extent. Frustum culling excludes objects outside that volume; it does not determine whether another object occludes them. Conservative bounds must include wind motion.

Level of detail (LOD) replaces distant geometry with a cheaper representation. Start with two or three meshes and distance or projected-size thresholds. Hysteresis uses different enter/leave thresholds to prevent rapid switching near a boundary. Camera and light visibility are different: off-camera trees may cast visible shadows.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 23.1.** Compute and visualize bounds for trees, including instance scale and a wind margin. Test one tree against one plane before combining the frustum.

2. **Task 23.2.** Derive plane tests from the adopted view/projection convention or construct planes geometrically. In Metal clip space the near condition differs from an OpenGL -W to W Z convention; verify near and far explicitly.

3. **Task 23.3.** Build a visible-instance list on the CPU and upload it safely through frame resources. Keep the render-all toggle and compare identical images except for debug coloring.

4. **Task 23.4.** Create reduced-detail canopy/trunk meshes. Select LOD with documented thresholds and hysteresis; show LOD groups with debug colors.

5. **Task 23.5.** Keep shadow-caster selection conservative using light coverage rather than only the camera list. Test a tree outside the camera view whose shadow enters the clearing. Measure benefits for an enlarged forest.

## 5. Common mistakes and investigation

Too-small bounds create disappearing leaves. Transforming only a sphere center but not radius under scale breaks tests. Removing offscreen objects from the shadow pass can remove visible shadows. LOD thresholds without hysteresis may flicker.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R05](../REFERENCE.md#r05) · [R11](../REFERENCE.md#r11) · [R14](../REFERENCE.md#r14)

Read only what resolves the current question. CPU culling is the reference implementation. GPU occlusion culling, mesh shaders, and streaming are not needed yet.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Move a tree slowly across each frustum plane and inspect popping. Freeze the camera used for culling while moving the viewing camera to visualize the volume. Increase wind amplitude and verify the bounds remain conservative.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Culling agrees with the render-all baseline for visible geometry.
- [ ] LOD changes are stable and shadow casters remain correct.
- [ ] Visible counts and before/after costs are measured at fixed settings.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why can an invisible tree still matter to the final image?
- What makes a bound conservative rather than exact?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Inspect bounds transforms, plane conventions, dynamic list capacity, hysteresis, and independent shadow visibility. Require boundary-case evidence, not just a lower draw count.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 23: skip invisible trees and simplify distant ones`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
