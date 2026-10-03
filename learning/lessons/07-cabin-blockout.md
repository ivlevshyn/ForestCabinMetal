# 07 — Build the cabin from reusable meshes

**Track:** Core · **Implementation effort hint:** 3–5 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 06](./06-orbit-camera.md) · [Next: 08](./08-normals-and-sunlight.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Turn the box into a recognizable cabin with walls, a pitched roof, door, window panels, porch supports, and chimney, assembled from a few reusable meshes.

## 2. Prerequisites and starting checkpoint

Lesson 06 complete; you can inspect objects from every side.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

Separate mesh data (shape), transform (placement), and material identity (appearance). A scene object references these rather than creating a new pipeline or buffer for every draw. This is the first useful architecture boundary; it does not require a general engine.

Build the roof as a triangular prism or a pair of sloped panels. Explain triangle winding from the outside, local origin placement, and why local mesh coordinates make reuse practical. A small parent-to-child transform example is useful for a porch assembly, but a full scene graph is optional.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 07.1.** Sketch the cabin dimensions and choose a local origin. Write a list of parts with approximate dimensions and positions. Keep units consistent with the meter-scale scene convention.

2. **Task 07.2.** Create a minimal Mesh representation that owns vertex/index buffers and draw counts. Make a scene object hold a mesh reference, transform, and simple color/material ID.

3. **Task 07.3.** Build the cabin body and roof using reusable geometry. Verify roof winding from several camera positions before adding details.

4. **Task 07.4.** Add door, window panels, porch, and chimney through data entries rather than duplicated rendering code. Offset decorative panels enough to avoid coplanar depth fighting without hiding layout mistakes.

5. **Task 07.5.** Move or scale the entire cabin deliberately. Explain whether your current assembly uses parent transforms or a shared root transform, and ensure pieces remain attached. Save a baseline screenshot.

## 5. Common mistakes and investigation

A mesh origin at an unexpected corner complicates every transform. Coplanar decorative surfaces may flicker. Accidental mesh-buffer recreation inside each object draw wastes work. Negative scale can reverse winding.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R04](../REFERENCE.md#r04) · [R05](../REFERENCE.md#r05) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. Keep flat colors. No downloaded complex models, real windows, interior, or collision system.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Create a second temporary cabin from the same mesh resources and explain what is shared and what differs. Move one part in local coordinates and predict the world-space result. Remove the duplicate after the experiment.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] The scene visibly reads as a cabin from front and rear views.
- [ ] Several objects share geometry and have independent transforms.
- [ ] Rendering code iterates scene data; adding a simple object does not require a new bespoke rendering function.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- What changes when you move an object versus edit its mesh?
- Which data should two identical porch posts share?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Review the object/mesh boundary, roof geometry, transform composition, and resource reuse. Accept alternative organization if the learner can explain it. Do not demand a scene graph framework.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 07: build the cabin from reusable meshes`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
