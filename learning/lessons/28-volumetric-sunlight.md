# 28 — Trace sunlight through forest mist

**Track:** Advanced · **Planning hint:** 5–8 small sessions (flexible, not a deadline)

[Previous: 27](./27-screen-space-occlusion.md) · [Next: 29](./29-temporal-antialiasing.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Extend the simple fog into a low-resolution single-scattering volume effect that reveals sunlit mist between trees.

## 2. Prerequisites and starting checkpoint

Lesson 27 complete; readable depth, shadow sampling, and HDR composition are stable.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

Distance fog blends toward a color; volumetric fog estimates light added and lost along a view ray through a participating medium. Introduce extinction, scattering, transmittance, and step length with a one-dimensional example. Begin with a uniform or simple height-dependent density and isotropic scattering.

March from the camera to the nearest opaque surface or a capped far distance. At each step, sample sun visibility through the existing shadow map and accumulate attenuated in-scattering. Composition uses volume radiance plus transmittance times the surface/background. Step-size dependence and double-counted fog are the first correctness checks.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 28.1.** Implement a diagnostic ray-distance view and verify ray endpoints against scene depth. Define an explicit far limit for sky pixels and a fog volume extent.

2. **Task 28.2.** Derive one step of absorption/transmittance from an explained exponential model. Test a uniform medium with no scattering against its known distance behavior.

3. **Task 28.3.** Add isotropic single scattering from the directional sun with shadow-map visibility. Accumulate front to back with a defined world-space step length and finite iteration bound.

4. **Task 28.4.** Render at reduced resolution and upsample with depth awareness. Keep volume targets resident and retained, bind them through argument tables, and synchronize producers with consumers. Compare a small full-resolution reference and inspect silhouette leakage.

5. **Task 28.5.** Composite into linear HDR before tone mapping and disable the earlier distance-fog term to avoid counting the same medium twice. Add quality, density, and off controls.

6. **Task 28.6.** Compare several step counts and measure GPU cost. Keep a clear-weather preset and explain artifacts from limited shadow coverage and missing multiple scattering.

## 5. Predict-and-observe experiments

Double the number of steps while keeping total distance fixed; a correctly scaled integral should converge rather than simply double brightness. Disable shadow visibility to show what produces the light shafts. Compare thin and dense fog.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

Forgetting step length changes energy with sample count. Marching beyond the visible surface puts fog behind an opaque wall into the result. Low-resolution upsampling can leak shafts across edges. A black fog texture may indicate incorrect transmittance initialization, not insufficient light intensity.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] The uniform-medium test and step-count convergence behave sensibly.
- [ ] Mist terminates at scene geometry and respects sun visibility.
- [ ] Composition avoids duplicate fog, and the cost/quality tradeoff is documented.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Review integration order, step units, endpoint reconstruction, shadow coordinates, transmittance bounds, and upsampling. Ask for absorption-only evidence before the final artistic scene.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why should smaller steps not automatically make the fog brighter?
- What physical behavior is missing from single scattering?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 28: trace sunlight through forest mist`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R10](../REFERENCE.md#r10) · [R11](../REFERENCE.md#r11) · [R12](../REFERENCE.md#r12) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. No volumetric clouds, multiple scattering, or temporal volume history. Use modest scene scale and a bounded sample budget.
