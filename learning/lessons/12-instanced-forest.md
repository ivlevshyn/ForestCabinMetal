# 12 — Draw a forest efficiently with instancing

**Track:** Core · **Planning hint:** 3–4 small sessions (flexible, not a deadline)

[Previous: 11](./11-terrain-and-placement.md) · [Next: 13](./13-sun-shadows.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Surround the cabin with many varied trees while sharing trunk and canopy meshes and reducing repeated draw setup.

## 2. Prerequisites and starting checkpoint

Lesson 11 complete; deterministic placement and shared materials exist.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

Instancing draws repeated geometry with a per-instance record selected by instance_id. The mesh stays the same while transforms, colors, and other attributes vary. It reduces repeated CPU command work but does not eliminate vertex work or invisible pixels automatically.

Begin with one trunk mesh and one opaque canopy mesh. One draw per compatible mesh/material group can render many instances. Use uniform positive scale initially to simplify normal transforms; if you support nonuniform scale, preserve correct normal handling for every instance.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 12.1.** Create one simple trunk and canopy tree inside the existing scene. Verify its local origin and ground contact before generating more.

2. **Task 12.2.** Build deterministic instance records for positions, yaw, positive scale, and subtle color variation. Exclude the cabin footprint and path. Explain the CPU/MSL layout.

3. **Task 12.3.** Implement an instanced draw and fetch the correct record in the vertex function. Render trunks and canopies as separate compatible batches.

4. **Task 12.4.** Compare one tree, a few dozen, and several hundred at a fixed camera. Record draw count and instance count; do not promise a speedup before measuring.

5. **Task 12.5.** Keep an object-by-object debug mode for a small set and compare its image with the instanced path. Freeze instance data after initialization unless explicitly editing the forest.

## 5. Predict-and-observe experiments

Assign instance ID as a debug color and verify there are no missing or duplicated records. Change one instance transform and show that shared mesh data did not change. Compare CPU submission cost for equivalent scenes if your tools expose it.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

The shader can accidentally apply the model transform twice. Instance count exceeding buffer capacity is unsafe. A transform layout mismatch can look like random forest placement. Instancing does not mean every tree should use a different pipeline.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Tree placement is repeatable and respects the clearing.
- [ ] Compatible trees share buffers and render with instanced draws.
- [ ] Instanced and individual reference paths agree for a small diagnostic set.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Check instance stride, count, binding, transforms, normals, and resource immutability. Ask the learner to distinguish draw count reduction from actual GPU work reduction.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- What work remains per tree after instancing?
- Why do trunks and canopies naturally form separate batches here?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 12: draw a forest efficiently with instancing`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R04](../REFERENCE.md#r04) · [R05](../REFERENCE.md#r05) · [R06](../REFERENCE.md#r06) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. Use opaque low-poly foliage first. Cutout leaves and animation arrive in lesson 18.
