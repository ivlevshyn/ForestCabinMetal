# 16 — Give wood, stone, and metal distinct responses

**Track:** Core · **Planning hint:** 4–7 small sessions (flexible, not a deadline)

[Previous: 15](./15-linear-hdr-pipeline.md) · [Next: 17](./17-porch-light-and-emission.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Upgrade direct sunlight to a basic metallic-roughness material model so rough wood, stone, and a metal chimney behave differently under the same light.

## 2. Prerequisites and starting checkpoint

Lesson 15 complete; linear HDR lighting, normals, and view direction are available.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

A BRDF describes how a surface reflects incoming light toward a viewer. Explain diffuse versus specular reflection, the halfway vector, roughness, metallic behavior, and grazing-angle Fresnel response with pictures and simple limit cases before introducing equations.

Use one documented microfacet model: GGX distribution, a consistent geometry term, and Schlick Fresnel, with a matching roughness-to-alpha convention. The tutor must supply and explain the equations from a named primary reference; the learner implements them in stages. Roughness is not a vague shininess multiplier, and metallic surfaces should not retain the same diffuse term as a dielectric. Indirect lighting remains a clearly labeled approximation until lesson 26.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 16.1.** Add base color, roughness, and metallic parameters to materials. Make a temporary row of diagnostic spheres or rounded meshes inside the same app, with a documented roughness progression.

2. **Task 16.2.** Work through normalized N, L, V, and H for one simple surface. Handle the degenerate case where L + V is near zero. Visualize dot products before combining the model.

3. **Task 16.3.** Implement the chosen model one explained term at a time. Expose separate diffuse and specular debug views and guard near-zero denominators consistently.

4. **Task 16.4.** Combine the direct-light response with sunlight intensity and shadow visibility in linear HDR. Use the reference model's energy-sharing convention; document any approximation.

5. **Task 16.5.** Tune the cabin materials conservatively. Make the chimney metallic, wood and stone dielectric, and compare at fixed light/exposure. Keep the diagnostic material row as a debug option.

## 5. Predict-and-observe experiments

Predict the highlight change as roughness increases and as the view approaches a grazing angle. Compare metallic 0 and 1 at the same base color. Ensure a surface facing away from the light does not produce invalid values.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

Different references square roughness at different points; mixing formulas changes the model. Gamma-encoded material data corrupts the result. Excessive ambient fill can hide whether direct lighting is correct. Metallic does not mean simply adding a brighter white highlight.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] The material row shows stable, sensible roughness and metallic variation.
- [ ] Cabin materials share one explained model with finite outputs in edge cases.
- [ ] The direct-light model and its roughness convention are documented with a primary reference.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Check vector spaces, normalization, roughness clamping, denominator guards, energy sharing, and reference consistency. Evaluate controlled material comparisons before judging artistic realism.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why does rough metal still reflect its surroundings even without a sharp highlight?
- What does a roughness map contain, and why is it linear data?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 16: give wood, stone, and metal distinct responses`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R05](../REFERENCE.md#r05) · [R12](../REFERENCE.md#r12) · [R13](../REFERENCE.md#r13)

Read only what resolves the current question. No clearcoat, subsurface scattering, anisotropy, or full global illumination. Image-based indirect light arrives in lesson 26.
