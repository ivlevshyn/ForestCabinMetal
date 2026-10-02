# 08 — Give surfaces shape with sunlight

**Track:** Core · **Planning hint:** 3–5 small sessions (flexible, not a deadline)

[Previous: 07](./07-cabin-blockout.md) · [Next: 09](./09-textures-and-samplers.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Light the cabin and ground with a movable directional sun so roof slopes and walls read as three-dimensional forms.

## 2. Prerequisites and starting checkpoint

Lesson 07 complete; vector normalization and dot product introduced in lesson 06.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

A normal describes surface orientation, not position. Diffuse lighting depends on the angle between the outward normal N and a unit vector L pointing from the surface toward the light. The basic Lambert factor is max(dot(N,L),0). Explain the distinction between light travel direction and the direction toward the light.

Use world space consistently for this first lighting model. Normals require the inverse transpose of the model matrix's linear 3×3 part when nonuniform scaling is present. Translation must not affect them. Interpolated normals usually need normalization again in the fragment shader. A constant ambient term is an artistic placeholder, not simulated indirect light.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 08.1.** Add normals to the vertex layout and update both CPU and MSL definitions. Give each box face a constant outward normal; duplicate corner vertices where faces need different normals.

2. **Task 08.2.** Visualize normals as RGB by mapping signed components into the visible range. Inspect every face and the sloped roof before enabling lighting.

3. **Task 08.3.** Pass world-space normals using an appropriate normal matrix. Test a nonuniformly scaled object to expose the difference from transforming normals as positions.

4. **Task 08.4.** Implement diffuse sunlight using a normalized direction, light color, and intensity. Keep values modest for the current display path. Add a small clearly labeled ambient fill so unlit faces remain readable.

5. **Task 08.5.** Expose sun azimuth/elevation or a direction control. Move the camera without moving the sun and verify that the lighting stays attached to the world.

## 5. Predict-and-observe experiments

Predict brightness for parallel, perpendicular, and opposite N/L vectors. Scale a diagnostic sloped surface nonuniformly and compare the proper normal transform with a deliberately naive one. Remove the incorrect path after documenting the result.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

Wrong sign on L lights the wrong side. Mixing view-space normals with world-space lights produces camera-dependent shading. Averaging normals across a box corner rounds its appearance. A singular zero scale cannot produce a valid inverse normal matrix.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Cabin faces respond correctly to sun direction and camera motion.
- [ ] Normal visualization and a nonuniform-scale diagnostic both behave correctly.
- [ ] The ambient approximation is documented as a placeholder.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Inspect CPU/MSL layout changes, normal space, matrix construction, normalization, and dot-product sign. Request a normal debug image and a lit image at the same pose.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why can two vertices occupy the same position but need different normals?
- Why does lighting math require all vectors in the same space?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 08: give surfaces shape with sunlight`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R05](../REFERENCE.md#r05) · [R06](../REFERENCE.md#r06)

Read only what resolves the current question. No cast shadows or physically based specular response yet. The lesson is about orientation and a simple direct-light model.
