# 02 — A triangle and the graphics pipeline

**Track:** Core · **Implementation effort hint:** 2–3 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 01](./01-first-window.md) · [Next: 03](./03-vertex-and-index-buffers.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Draw a colored triangle inside the same app. Treat it as the future roof silhouette and keep it available as a diagnostic mode as the scene grows.

## 2. Prerequisites and starting checkpoint

Lesson 01 complete: a working Metal clear pass.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

A vertex shader processes vertex inputs and returns positions in homogeneous clip space. Rasterization determines which screen samples a triangle covers and interpolates values. A fragment shader computes an output color for covered fragments. A render pipeline state combines shader functions with attachment configuration; it is prepared before drawing.

For the first triangle, use three positions selected in the shader with `vertex_id` and W = 1. This isolates the pipeline from buffer layout, which arrives next. Explain the MSL `vertex` and `fragment` qualifiers, `[[position]]`, and function names in the compiled shader library. Begin with culling disabled. Colors supplied to the sRGB target should be treated as linear values.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 02.1.** Draw your three triangle coordinates on paper in the range -1 to 1 for X and Y. Predict which corner lands where. Explain how changing W would affect the later perspective divide, without implementing perspective yet.

2. **Task 02.2.** Add a .metal file to the correct build target. Implement the smallest vertex function using vertex_id to select a position. Learn the type and attribute syntax you need before writing it.

3. **Task 02.3.** Implement a fragment function that returns one color. Use MTL4Compiler with a Metal 4 render-pipeline descriptor and explained library-function descriptors referring to your compiled MSL functions. Match the view format, compile outside drawing, and report errors clearly. Some resulting shared types still have MTL names; do not invent MTL4-prefixed replacements for them.

4. **Task 02.4.** Bind the pipeline in the existing pass and issue one triangle draw with three vertices. Use a frame capture to find the draw and its output; the tutor guides you through the relevant views.

5. **Task 02.5.** Pass a different color from each vertex to the fragment function and observe interpolation. Explain why the interior has colors you never explicitly assigned to vertices.

## 5. Common mistakes and investigation

A function absent from the shader library often means target membership or spelling is wrong. A pipeline attachment-format mismatch is different from a shader compile error. A triangle draw count is a vertex count here, not a number of triangles.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R03](../REFERENCE.md#r03) · [R04](../REFERENCE.md#r04) · [R05](../REFERENCE.md#r05) · [R06](../REFERENCE.md#r06) · [R24](../REFERENCE.md#r24)

Read only what resolves the current question. No vertex buffers or camera yet. Use the Metal4Renderer branch of Apple’s sample only to resolve a specific question. Pipeline compilation is Metal 4 from this lesson onward.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Move one vertex outside the visible range and predict clipping. Swap two vertices with culling disabled, then briefly enable a known winding/cull setting to see why order matters. Restore the documented baseline.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] The triangle is visible with both flat and interpolated color modes.
- [ ] Pipeline state is built outside the frame loop and matches the drawable format.
- [ ] You can follow one vertex through the stages and identify the draw in a capture.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Which part runs per vertex and which per fragment?
- Why does returning a color from the vertex function not directly paint a pixel?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Check function linkage, vertex count, clip coordinates, output attributes, and pipeline creation lifetime. Ask the learner to explain how the current vertex coordinates determine the triangle’s position; moving a corner is optional exploration.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 02: a triangle and the graphics pipeline`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
