# 03 — Send geometry from Swift to the GPU

**Track:** Core · **Planning hint:** 2–4 small sessions (flexible, not a deadline)

[Previous: 02](./02-first-triangle.md) · [Next: 04](./04-transforms-and-time.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Replace shader-hardcoded positions with Swift-owned geometry, then make an indexed rectangular wall panel. The same mesh path will serve the cabin and terrain.

## 2. Prerequisites and starting checkpoint

Lesson 02 complete: one working pipeline and triangle.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

A buffer is a sequence of bytes. Swift and MSL must agree on what those bytes mean. Distinguish a field size, its alignment, and an array element stride. Use a deliberately simple vertex structure with padded position and color fields first; discover actual Swift layout with MemoryLayout instead of guessing.

Start with direct indexed access to a typed vertex buffer in the vertex shader, using vertex_id. This route does not need a vertex descriptor. A later alternative is descriptor-driven attributes; do not accidentally combine the assumptions of both. An index buffer chooses vertices for each triangle and can reuse a vertex only when all of its attributes agree.

Metal 4 binds shader resources through an argument table. Enter the vertex buffer GPU address at the agreed buffer index, then assign the table to the vertex stage. This is distinct from retaining the buffer and registering its allocation as resident. The indexed draw also needs its index data address and valid byte range.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 03.1.** Design a vertex record on paper, including byte offsets and stride. Compare your prediction with Swift MemoryLayout and the MSL type layout rules. Record the contract in a code comment or small project note.

2. **Task 03.2.** Create an immutable vertex buffer and register its allocation in the app residency set, commit membership changes, and attach the set to the Metal 4 queue. Retain the buffer. Create a small MTL4ArgumentTable, put the buffer GPU address in the chosen slot, and bind that table to the vertex stage. Keep the triangle image unchanged.

3. **Task 03.3.** Construct a rectangle from two triangles without indices first. Count repeated vertex records and predict the memory cost.

4. **Task 03.4.** Create four vertex records and six indices. Register and retain the index allocation as well. Call the Metal 4 indexed-draw overload with the correct index type, GPU address, and byte length. Explain index count, byte offset applied to the address, and remaining valid length independently.

5. **Task 03.5.** Add a second panel with different dimensions by changing geometry data only. Inspect buffer contents in a capture and check every index against vertex count.

## 5. Predict-and-observe experiments

Intentionally supply a wrong stride in a safe diagnostic branch or mismatched field layout, observe the corruption/validation result, and restore correctness. Explain why a position shared by two faces may still need separate vertices once normals or UVs differ.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

Do not assume SIMD3<Float> has the packing you want. Binding the correct buffer at the wrong slot is still wrong. Bytes copied from a Swift array must outlive the copy operation; do not retain an unsafe pointer as though it owns array memory.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Geometry positions and colors originate in Swift buffers.
- [ ] The rectangle uses a valid index buffer with documented layout and index type.
- [ ] Resource creation is outside draw; all referenced indices are valid.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Review byte layout, buffer length, binding indices, upload ownership, and draw-index parameters. Require a concise vertex/index count explanation, not a memorized formula.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- When does an index buffer save memory?
- Why is buffer length based on stride rather than adding the apparent component sizes?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 03: send geometry from swift to the gpu`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R04](../REFERENCE.md#r04) · [R05](../REFERENCE.md#r05) · [R06](../REFERENCE.md#r06) · [R22](../REFERENCE.md#r22) · [R23](../REFERENCE.md#r23)

Read only what resolves the current question. No generalized mesh importer or shared C header is required. A carefully documented pair of small Swift/MSL structs is enough.
