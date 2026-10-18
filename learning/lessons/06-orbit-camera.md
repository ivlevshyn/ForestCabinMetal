# 06 — Explore the cabin with an orbit camera

**Track:** Core · **Implementation effort hint:** 2–4 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 05](./05-perspective-and-depth.md) · [Next: 07](./07-cabin-blockout.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach this lesson in manageable steps across messages, with thorough plain-language theory, worked examples, and explained snippets with exact placement. Deliver the current step and pause before continuing. Keep understanding questions until the end of the entire lesson; no per-step quizzes or mandatory commits. Check file responsibilities before extending them and teach small extractions before code causes bloat. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Add mouse orbit, zoom, and camera reset so you can inspect the growing scene from multiple angles.

## 2. Prerequisites and starting checkpoint

Lesson 05 complete: perspective, depth, and a fixed view transform.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

A camera pose says where the camera is in the world; the view matrix transforms the world into camera coordinates and is the inverse of that pose. Introduce normalized direction, dot product, and cross product using perpendicular axes. A look-at construction creates a camera basis from eye, target, and an up reference.

An orbit camera stores a target, distance, yaw, and pitch. This makes controls simpler than accumulating arbitrary rotation matrices. Near a vertical pole, the up reference and viewing direction can become nearly parallel, so constrain pitch for this first camera.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Explain the concepts needed for each step and demonstrate predictions yourself; ask understanding questions only in the final section of the entire lesson.

## 4. Explained implementation walkthrough

Use these task IDs to plan manageable teaching steps across messages. Deliver one coherent step at a time, grouping related tasks or splitting a large task as needed. Explain the theory and show clear Swift/MSL snippets with the actual file, type/function, add/replace action, insertion anchor, and dependencies. First check whether affected files have clear responsibilities; teach a focused extraction before adding code if needed. Include expected behavior and relevant implementation checks, then pause for the learner to apply the step or ask for help. Keep understanding questions and learner calculations until the end of the entire lesson; demonstrate predictions yourself in earlier steps. Do not require per-step commits or formal reviews. Exploratory changes and extra variations remain optional.

1. **Task 06.1.** Draw eye, target, forward, right, and up for a simple pose. Calculate one direction by hand and explain why basis vectors should be normalized.

2. **Task 06.2.** Implement a view matrix from the explained look-at construction or invert a constructed rigid camera pose. Check that the camera position transforms to the view-space origin.

3. **Task 06.3.** Map drag deltas to yaw and pitch with documented sensitivity. Keep pointer handling in the host/input layer and camera math in a small camera type.

4. **Task 06.4.** Map scroll to distance with sensible limits, clamp pitch before the singularity, and add a reset pose that shows the entire cabin blockout.

5. **Task 06.5.** Store two or three named diagnostic camera poses for later comparisons. Verify controls after resizing and when the view loses and regains focus.

## 5. Common mistakes and investigation

The view matrix is not the camera world matrix. Cross-product order changes handedness. Zero eye-to-target distance is invalid. Input accumulated in two places can produce jitter unrelated to rendering.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R05](../REFERENCE.md#r05) · [R06](../REFERENCE.md#r06)

Read only what resolves the current question. An orbit camera is enough for the whole course. A first-person controller is optional after the main course, not a prerequisite.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section after the final teaching step, once all lesson theory and code have been explained. The learner may already have applied earlier steps. Collect all understanding questions here, along with the final checklist and submission directions; do not distribute quizzes across step boundaries.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Temporarily omit normalization of one basis vector and observe the unintended scale. Orbit 360 degrees around the cabin and identify a winding error if any face vanishes incorrectly. Compare zoom by distance with zoom by field of view.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Orbit, zoom limits, and reset behave predictably.
- [ ] The camera basis and view transform pass simple numeric sanity checks.
- [ ] A saved baseline pose is available for subsequent lesson evidence.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why must moving the camera right shift the scene left in view space?
- What happens if forward and the up reference are parallel?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Review coordinate consistency and degenerate-input handling. Ask the learner to explain one cross product and diagnose an intentionally reversed camera direction conceptually.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 06: explore the cabin with an orbit camera`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
