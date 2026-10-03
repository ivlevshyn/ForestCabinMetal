# 08 — Give surfaces shape with sunlight

**Track:** Core · **Implementation effort hint:** 3–5 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 07](./07-cabin-blockout.md) · [Next: 09](./09-textures-and-samplers.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Light the cabin and ground with a movable directional sun so roof slopes and walls read as three-dimensional forms.

## 2. Prerequisites and starting checkpoint

Lesson 07 complete; vector normalization and dot product introduced in lesson 06.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

A normal describes surface orientation, not position. Diffuse lighting depends on the angle between the outward normal N and a unit vector L pointing from the surface toward the light. The basic Lambert factor is max(dot(N,L),0). Explain the distinction between light travel direction and the direction toward the light.

Use world space consistently for this first lighting model. Normals require the inverse transpose of the model matrix's linear 3×3 part when nonuniform scaling is present. Translation must not affect them. Interpolated normals usually need normalization again in the fragment shader. A constant ambient term is an artistic placeholder, not simulated indirect light.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 08.1.** Add normals to the vertex layout and update both CPU and MSL definitions. Give each box face a constant outward normal; duplicate corner vertices where faces need different normals.

2. **Task 08.2.** Visualize normals as RGB by mapping signed components into the visible range. Inspect every face and the sloped roof before enabling lighting.

3. **Task 08.3.** Pass world-space normals using an appropriate normal matrix. Test a nonuniformly scaled object to expose the difference from transforming normals as positions.

4. **Task 08.4.** Implement diffuse sunlight using a normalized direction, light color, and intensity. Keep values modest for the current display path. Add a small clearly labeled ambient fill so unlit faces remain readable.

5. **Task 08.5.** Expose sun azimuth/elevation or a direction control. Move the camera without moving the sun and verify that the lighting stays attached to the world.

## 5. Common mistakes and investigation

Wrong sign on L lights the wrong side. Mixing view-space normals with world-space lights produces camera-dependent shading. Averaging normals across a box corner rounds its appearance. A singular zero scale cannot produce a valid inverse normal matrix.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R05](../REFERENCE.md#r05) · [R06](../REFERENCE.md#r06)

Read only what resolves the current question. No cast shadows or physically based specular response yet. The lesson is about orientation and a simple direct-light model.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Predict brightness for parallel, perpendicular, and opposite N/L vectors. Scale a diagnostic sloped surface nonuniformly and compare the proper normal transform with a deliberately naive one. Remove the incorrect path after documenting the result.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Cabin faces respond correctly to sun direction and camera motion.
- [ ] Normal visualization and a nonuniform-scale diagnostic both behave correctly.
- [ ] The ambient approximation is documented as a placeholder.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why can two vertices occupy the same position but need different normals?
- Why does lighting math require all vectors in the same space?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Inspect CPU/MSL layout changes, normal space, matrix construction, normalization, and dot-product sign. Request a normal debug image and a lit image at the same pose.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 08: give surfaces shape with sunlight`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
