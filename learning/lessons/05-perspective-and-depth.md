# 05 — Enter 3D with perspective and depth

**Track:** Core · **Planning hint:** 3–5 small sessions (flexible, not a deadline)

[Previous: 04](./04-transforms-and-time.md) · [Next: 06](./06-orbit-camera.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Render a rotating box and ground plane with correct occlusion. This box is the first cabin body, not a separate demo project.

## 2. Prerequisites and starting checkpoint

Lesson 04 complete: transforms and per-draw uniforms. Basic matrix-vector multiplication is understood.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

Separate local, world, view, clip, and normalized-device coordinates. Perspective makes equal-sized objects appear smaller when farther away by producing an appropriate homogeneous W. The GPU clips and performs the perspective divide; your vertex shader returns clip coordinates.

The course uses a right-handed camera looking along -Z and Metal depth in [0,1] after division. The tutor derives or walks through a matching perspective matrix, identifying field of view, aspect, near, and far. A depth texture stores visibility information; for standard depth, clear to 1 and accept a fragment when its depth is less. Depth testing and back-face culling solve different problems.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 05.1.** Build an indexed box with clearly colored faces and a ground panel. Add a fixed view transform that places them in front of the camera; mark the camera direction in your notes.

2. **Task 05.2.** Implement perspective from an explained equation. Numerically verify that points on the near and far planes map to the intended depth endpoints. Keep near greater than zero and far greater than near.

3. **Task 05.3.** Update aspect from drawable pixel dimensions and skip zero-height frames. Compose projection × view × model in the shader.

4. **Task 05.4.** Configure the view depth attachment, matching pipeline depth format, and a depth-stencil state. Demonstrate correct overlap regardless of opaque draw order.

5. **Task 05.5.** Enable an explicit front-face convention and back-face culling after winding is verified. Capture one frame and inspect both color and depth.

## 5. Predict-and-observe experiments

Disable depth testing and reverse object draw order; predict the difference. Change the near plane and field of view independently. Resize from a wide to a tall window and verify that a square is not stretched.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

An OpenGL-style projection often uses the wrong depth range for Metal. Near = 0 is invalid for this perspective construction. A far/near ratio that is unnecessarily huge reduces depth precision. Incorrect winding can make a correct projection look empty.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] The box and plane overlap correctly regardless of draw order.
- [ ] Resize preserves proportions; depth configuration matches the pass.
- [ ] You can identify each coordinate space and explain near/far clipping.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Inspect the projection endpoint checks, depth format/state/clear agreement, aspect source, and vertex output W. Ask for depth-disabled versus enabled evidence.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why does depth testing require storage from earlier fragments?
- What differs between moving the camera and changing field of view?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 05: enter 3d with perspective and depth`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R05](../REFERENCE.md#r05) · [R08](../REFERENCE.md#r08) · [R02](../REFERENCE.md#r02) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. Use a fixed camera pose. Reverse-Z and infinite projections are later research topics, not needed to learn basic visibility.
