# 21 — Simulate fireflies on the GPU

**Track:** Advanced · **Planning hint:** 4–6 small sessions (flexible, not a deadline)

[Previous: 20](./20-core-review-and-profiling.md) · [Next: 22](./22-frames-and-resource-lifetime.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Add a controllable swarm of fireflies around the cabin with positions updated by a compute kernel and rendered without per-frame CPU readback.

## 2. Prerequisites and starting checkpoint

Core through lesson 20 complete. Tutor introduces compute dispatch and parallel memory rules from first principles.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

A compute kernel runs work items over a grid without triangle rasterization. thread_position_in_grid identifies a work item; dispatch dimensions and threadgroup dimensions are different. A kernel must guard any index outside the valid particle count.

Use independent particles first: each invocation updates only its own record from time and immutable per-particle parameters. In-place updates are safe only under that independence and correct pass ordering. Neighbor interactions would require a new read/write strategy, often ping-pong state. Rendering can consume the updated buffer directly through instancing.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 21.1.** Define a minimal particle record and deterministic initial positions. Render a few stationary points or billboard quads using instancing before adding simulation.

2. **Task 21.2.** Create a compute function and compile it with MTL4Compiler. Configure MTL4ArgumentTable for resident particle data and bind it to MTL4ComputeCommandEncoder. First write a predictable pattern so dispatch indexing is verified before motion.

3. **Task 21.3.** Implement a simple bounded drift/orbit model with delta-time control and no neighbor reads. Handle zero particles and particle counts that are not multiples of a threadgroup size.

4. **Task 21.4.** Encode compute and the particle draw on the Metal 4 queue. Add a dependency from dispatch writes to vertex-stage particle reads; command order alone is insufficient. Distinguish this GPU barrier from the CPU single-slot completion gate, and record both in the resource-use table.

5. **Task 21.5.** Render emissive billboards with a documented additive/premultiplied blending choice, depth testing against the scene, and no inappropriate depth writes. Cap brightness and add count/pause/reset controls. Reset through ordered GPU work or wait for completion before CPU mutation; never overwrite in-flight state.

6. **Task 21.6.** Compare a tiny CPU reference update with the GPU result in a deliberate debugging readback after completion. Remove readback from the normal frame path.

## 5. Predict-and-observe experiments

Test counts 0, 1, and a non-round value such as 257. Pause simulation while orbiting the camera. Deliberately discuss why allowing every thread to update a shared counter would need an atomic operation, without adding one yet.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

Maximum threadgroup size depends on the pipeline/device; do not copy a large constant blindly. A CPU read before GPU completion is not valid verification. Bright particles are not automatically point lights. Transparent particles can obscure each other incorrectly if depth writes are enabled.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Compute updates particles consumed by rendering without routine CPU readback.
- [ ] Edge counts and paused/resumed time are safe.
- [ ] The learner can explain thread ownership, bounds checks, and compute-to-render dependency.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Inspect dispatch sizing, bounds, layouts, blending/depth state, and data races. Ask for the small reference comparison and a capture showing compute before rendering.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why is this in-place update safe while a neighbor-dependent update might not be?
- Which part makes the particles emit light visually and which, if any, lights the cabin?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 21: simulate fireflies on the gpu`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R15](../REFERENCE.md#r15) · [R16](../REFERENCE.md#r16) · [R05](../REFERENCE.md#r05) · [R07](../REFERENCE.md#r07) · [R22](../REFERENCE.md#r22) · [R24](../REFERENCE.md#r24) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. No fluid simulation or flocking. Fireflies are independent visual particles; local illumination remains the porch light.
