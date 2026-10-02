# 06 — Explore the cabin with an orbit camera

**Track:** Core · **Planning hint:** 2–4 small sessions (flexible, not a deadline)

[Previous: 05](./05-perspective-and-depth.md) · [Next: 07](./07-cabin-blockout.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Add mouse orbit, zoom, and camera reset so you can inspect the growing scene from multiple angles.

## 2. Prerequisites and starting checkpoint

Lesson 05 complete: perspective, depth, and a fixed view transform.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

A camera pose says where the camera is in the world; the view matrix transforms the world into camera coordinates and is the inverse of that pose. Introduce normalized direction, dot product, and cross product using perpendicular axes. A look-at construction creates a camera basis from eye, target, and an up reference.

An orbit camera stores a target, distance, yaw, and pitch. This makes controls simpler than accumulating arbitrary rotation matrices. Near a vertical pole, the up reference and viewing direction can become nearly parallel, so constrain pitch for this first camera.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 06.1.** Draw eye, target, forward, right, and up for a simple pose. Calculate one direction by hand and explain why basis vectors should be normalized.

2. **Task 06.2.** Implement a view matrix from the explained look-at construction or invert a constructed rigid camera pose. Check that the camera position transforms to the view-space origin.

3. **Task 06.3.** Map drag deltas to yaw and pitch with documented sensitivity. Keep pointer handling in the host/input layer and camera math in a small camera type.

4. **Task 06.4.** Map scroll to distance with sensible limits, clamp pitch before the singularity, and add a reset pose that shows the entire cabin blockout.

5. **Task 06.5.** Store two or three named diagnostic camera poses for later comparisons. Verify controls after resizing and when the view loses and regains focus.

## 5. Predict-and-observe experiments

Temporarily omit normalization of one basis vector and observe the unintended scale. Orbit 360 degrees around the cabin and identify a winding error if any face vanishes incorrectly. Compare zoom by distance with zoom by field of view.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

The view matrix is not the camera world matrix. Cross-product order changes handedness. Zero eye-to-target distance is invalid. Input accumulated in two places can produce jitter unrelated to rendering.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Orbit, zoom limits, and reset behave predictably.
- [ ] The camera basis and view transform pass simple numeric sanity checks.
- [ ] A saved baseline pose is available for subsequent lesson evidence.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Review coordinate consistency and degenerate-input handling. Ask the learner to explain one cross product and diagnose an intentionally reversed camera direction conceptually.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why must moving the camera right shift the scene left in view space?
- What happens if forward and the up reference are parallel?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 06: explore the cabin with an orbit camera`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R05](../REFERENCE.md#r05) · [R06](../REFERENCE.md#r06)

Read only what resolves the current question. An orbit camera is enough for the whole course. A first-person controller is optional after the main course, not a prerequisite.
