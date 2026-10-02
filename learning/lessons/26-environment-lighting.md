# 26 — Light materials with the surrounding sky

**Track:** Advanced · **Planning hint:** 6–10 small sessions (flexible, not a deadline)

[Previous: 25](./25-normal-mapping.md) · [Next: 27](./27-screen-space-occlusion.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Replace the constant ambient placeholder with approximate image-based lighting (IBL), making shaded wood and reflective metal respond to the environment.

## 2. Prerequisites and starting checkpoint

Lesson 25 complete; PBR, HDR, compute, and texture sampling are understood.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

An environment map represents incoming light from directions around a point. A cubemap stores six views of those directions. Diffuse and glossy materials integrate that incoming light differently. A normal mip chain is not a physically meaningful roughness-prefiltered environment by itself.

Stage this lesson carefully: direction lookup, diffuse integration, rough-specular prefiltering, then a documented split-sum approximation using a BRDF lookup table. The tutor teaches the sampling idea and gives explained formulas from a named reference; the learner implements one small stage at a time. Bake slowly at startup or offline first; runtime rebaking is not required.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 26.1.** Create a tiny labeled cubemap or bake the current procedural sky into one. Verify all six directions and orientation with a diagnostic reflective sphere. Keep the sun-energy policy explicit to avoid counting a sharp sun twice.

2. **Task 26.2.** Implement a simple low-resolution diffuse irradiance bake. Explain cosine weighting and normalization using a constant environment, whose response should be uniform.

3. **Task 26.3.** Build a roughness-dependent specular prefilter through staged sampling. Define the roughness-to-mip mapping and check that increasing roughness broadens reflected detail.

4. **Task 26.4.** Generate or load a BRDF integration lookup table matching the material model. Keep all baked images resident and retained; order Metal 4 bake dispatches and later shader reads explicitly. Start with a tiny inspectable texture before increasing resolution/sample count.

5. **Task 26.5.** Combine diffuse and specular indirect terms with the existing direct lights. Remove the old constant ambient contribution or keep it only in an explicitly named comparison mode.

6. **Task 26.6.** Test wood, stone, and metal under both a constant environment and the sky environment. Keep exposure fixed for comparisons and document environment-locality limitations.

## 5. Predict-and-observe experiments

Rotate the environment without rotating the objects and predict reflection motion. Use a constant-color environment to reveal normalization errors. Compare roughness-prefiltered results with ordinary texture mipmaps.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

Incorrect cubemap orientation can look plausible in a sky but fail reflections. Using the direct-light geometry approximation blindly for IBL can mismatch the lookup table. The environment does not know that a roof blocks part of the sky. Double-counted ambient or sun energy makes tuning misleading.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Environment orientation passes labeled-direction tests.
- [ ] Diffuse and rough-specular indirect terms have documented, consistent conventions.
- [ ] Constant-environment and roughness tests pass, and ambient double counting is avoided.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Review bake dependencies, sample normalization, roughness mapping, lookup-table convention, and HDR formats. Permit a low-resolution slow bake; the target is understanding and correctness before speed.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why is a blurred environment not automatically the correct response for every material?
- What scene visibility does this environment approximation ignore?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 26: light materials with the surrounding sky`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R13](../REFERENCE.md#r13) · [R15](../REFERENCE.md#r15) · [R09](../REFERENCE.md#r09) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. This is a multi-session advanced lesson. No dynamic reflection probes, parallax correction, or full global illumination is required.
