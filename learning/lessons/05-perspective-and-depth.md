# 05 — Enter 3D with perspective and depth

**Track:** Core · **Implementation effort hint:** 3–5 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 04](./04-transforms-and-time.md) · [Next: 06](./06-orbit-camera.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Render a rotating box and ground plane with correct occlusion. This box is the first cabin body, not a separate demo project.

## 2. Prerequisites and starting checkpoint

Lesson 04 complete: transforms and per-draw uniforms. Basic matrix-vector multiplication is understood.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

Separate local, world, view, clip, and normalized-device coordinates. Perspective makes equal-sized objects appear smaller when farther away by producing an appropriate homogeneous W. The GPU clips and performs the perspective divide; your vertex shader returns clip coordinates.

The course uses a right-handed camera looking along -Z and Metal depth in [0,1] after division. The tutor derives or walks through a matching perspective matrix, identifying field of view, aspect, near, and far. A depth texture stores visibility information; for standard depth, clear to 1 and accept a fragment when its depth is less. Depth testing and back-face culling solve different problems.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 05.1.** Build an indexed box with clearly colored faces and a ground panel. Add a fixed view transform that places them in front of the camera; mark the camera direction in your notes.

2. **Task 05.2.** Implement perspective from an explained equation. Numerically verify that points on the near and far planes map to the intended depth endpoints. Keep near greater than zero and far greater than near.

3. **Task 05.3.** Update aspect from drawable pixel dimensions and skip zero-height frames. Compose projection × view × model in the shader.

4. **Task 05.4.** Configure the view depth attachment, matching pipeline depth format, and a depth-stencil state. Demonstrate correct overlap regardless of opaque draw order.

5. **Task 05.5.** Enable an explicit front-face convention and back-face culling after winding is verified. Capture one frame and inspect both color and depth.

## 5. Common mistakes and investigation

An OpenGL-style projection often uses the wrong depth range for Metal. Near = 0 is invalid for this perspective construction. A far/near ratio that is unnecessarily huge reduces depth precision. Incorrect winding can make a correct projection look empty.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R05](../REFERENCE.md#r05) · [R08](../REFERENCE.md#r08) · [R02](../REFERENCE.md#r02) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. Use a fixed camera pose. Reverse-Z and infinite projections are later research topics, not needed to learn basic visibility.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Disable depth testing and reverse object draw order; predict the difference. Change the near plane and field of view independently. Resize from a wide to a tall window and verify that a square is not stretched.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] The box and plane overlap correctly regardless of draw order.
- [ ] Resize preserves proportions; depth configuration matches the pass.
- [ ] You can identify each coordinate space and explain near/far clipping.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why does depth testing require storage from earlier fragments?
- What differs between moving the camera and changing field of view?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Inspect the projection endpoint checks, depth format/state/clear agreement, aspect source, and vertex output W. Check that visible occlusion matches the implemented depth configuration; disabling depth for comparison is optional.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 05: enter 3d with perspective and depth`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
