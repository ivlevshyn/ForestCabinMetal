# 07 — Build the cabin from reusable meshes

**Track:** Core · **Planning hint:** 3–5 small sessions (flexible, not a deadline)

[Previous: 06](./06-orbit-camera.md) · [Next: 08](./08-normals-and-sunlight.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Turn the box into a recognizable cabin with walls, a pitched roof, door, window panels, porch supports, and chimney, assembled from a few reusable meshes.

## 2. Prerequisites and starting checkpoint

Lesson 06 complete; you can inspect objects from every side.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

Separate mesh data (shape), transform (placement), and material identity (appearance). A scene object references these rather than creating a new pipeline or buffer for every draw. This is the first useful architecture boundary; it does not require a general engine.

Build the roof as a triangular prism or a pair of sloped panels. Explain triangle winding from the outside, local origin placement, and why local mesh coordinates make reuse practical. A small parent-to-child transform example is useful for a porch assembly, but a full scene graph is optional.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 07.1.** Sketch the cabin dimensions and choose a local origin. Write a list of parts with approximate dimensions and positions. Keep units consistent with the meter-scale scene convention.

2. **Task 07.2.** Create a minimal Mesh representation that owns vertex/index buffers and draw counts. Make a scene object hold a mesh reference, transform, and simple color/material ID.

3. **Task 07.3.** Build the cabin body and roof using reusable geometry. Verify roof winding from several camera positions before adding details.

4. **Task 07.4.** Add door, window panels, porch, and chimney through data entries rather than duplicated rendering code. Offset decorative panels enough to avoid coplanar depth fighting without hiding layout mistakes.

5. **Task 07.5.** Move or scale the entire cabin deliberately. Explain whether your current assembly uses parent transforms or a shared root transform, and ensure pieces remain attached. Save a baseline screenshot.

## 5. Predict-and-observe experiments

Create a second temporary cabin from the same mesh resources and explain what is shared and what differs. Move one part in local coordinates and predict the world-space result. Remove the duplicate after the experiment.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

A mesh origin at an unexpected corner complicates every transform. Coplanar decorative surfaces may flicker. Accidental mesh-buffer recreation inside each object draw wastes work. Negative scale can reverse winding.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] The scene visibly reads as a cabin from front and rear views.
- [ ] Several objects share geometry and have independent transforms.
- [ ] Rendering code iterates scene data; adding a simple object does not require a new bespoke rendering function.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Review the object/mesh boundary, roof geometry, transform composition, and resource reuse. Accept alternative organization if the learner can explain it. Do not demand a scene graph framework.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- What changes when you move an object versus edit its mesh?
- Which data should two identical porch posts share?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 07: build the cabin from reusable meshes`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R04](../REFERENCE.md#r04) · [R05](../REFERENCE.md#r05) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. Keep flat colors. No downloaded complex models, real windows, interior, or collision system.
