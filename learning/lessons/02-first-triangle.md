# 02 — A triangle and the graphics pipeline

**Track:** Core · **Planning hint:** 2–3 small sessions (flexible, not a deadline)

[Previous: 01](./01-first-window.md) · [Next: 03](./03-vertex-and-index-buffers.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Draw a colored triangle inside the same app. Treat it as the future roof silhouette and keep it available as a diagnostic mode as the scene grows.

## 2. Prerequisites and starting checkpoint

Lesson 01 complete: a working Metal clear pass.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

A vertex shader processes vertex inputs and returns positions in homogeneous clip space. Rasterization determines which screen samples a triangle covers and interpolates values. A fragment shader computes an output color for covered fragments. A render pipeline state combines shader functions with attachment configuration; it is prepared before drawing.

For the first triangle, use three positions selected in the shader with `vertex_id` and W = 1. This isolates the pipeline from buffer layout, which arrives next. Explain the MSL `vertex` and `fragment` qualifiers, `[[position]]`, and function names in the compiled shader library. Begin with culling disabled. Colors supplied to the sRGB target should be treated as linear values.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 02.1.** Draw your three triangle coordinates on paper in the range -1 to 1 for X and Y. Predict which corner lands where. Explain how changing W would affect the later perspective divide, without implementing perspective yet.

2. **Task 02.2.** Add a .metal file to the correct build target. Implement the smallest vertex function using vertex_id to select a position. Learn the type and attribute syntax you need before writing it.

3. **Task 02.3.** Implement a fragment function that returns one color. Use MTL4Compiler with a Metal 4 render-pipeline descriptor and explained library-function descriptors referring to your compiled MSL functions. Match the view format, compile outside drawing, and report errors clearly. Some resulting shared types still have MTL names; do not invent MTL4-prefixed replacements for them.

4. **Task 02.4.** Bind the pipeline in the existing pass and issue one triangle draw with three vertices. Use a frame capture to find the draw and its output; the tutor guides you through the relevant views.

5. **Task 02.5.** Pass a different color from each vertex to the fragment function and observe interpolation. Explain why the interior has colors you never explicitly assigned to vertices.

## 5. Predict-and-observe experiments

Move one vertex outside the visible range and predict clipping. Swap two vertices with culling disabled, then briefly enable a known winding/cull setting to see why order matters. Restore the documented baseline.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

A function absent from the shader library often means target membership or spelling is wrong. A pipeline attachment-format mismatch is different from a shader compile error. A triangle draw count is a vertex count here, not a number of triangles.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] The triangle is visible with both flat and interpolated color modes.
- [ ] Pipeline state is built outside the frame loop and matches the drawable format.
- [ ] You can follow one vertex through the stages and identify the draw in a capture.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Check function linkage, vertex count, clip coordinates, output attributes, and pipeline creation lifetime. Ask the learner to move one corner to a specified screen region without receiving code.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Which part runs per vertex and which per fragment?
- Why does returning a color from the vertex function not directly paint a pixel?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 02: a triangle and the graphics pipeline`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R03](../REFERENCE.md#r03) · [R04](../REFERENCE.md#r04) · [R05](../REFERENCE.md#r05) · [R06](../REFERENCE.md#r06) · [R24](../REFERENCE.md#r24)

Read only what resolves the current question. No vertex buffers or camera yet. Use the Metal4Renderer branch of Apple’s sample only to resolve a specific question. Pipeline compilation is Metal 4 from this lesson onward.
