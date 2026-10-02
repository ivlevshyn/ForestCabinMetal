# 25 — Add surface detail with tangent-space normals

**Track:** Advanced · **Planning hint:** 4–6 small sessions (flexible, not a deadline)

[Previous: 24](./24-gpu-visibility-and-indirect-draws.md) · [Next: 26](./26-environment-lighting.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Make cabin wood grain, stone, and bark respond to light with small-scale surface detail without adding geometry.

## 2. Prerequisites and starting checkpoint

Lesson 24 complete on the default path; technical prerequisites are UVs, normals, and PBR from 09 and 16. Later techniques must continue to work.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

A normal map stores a direction relative to a surface's tangent basis, not a replacement world-space normal or a height image. Decode its RGB values from [0,1] to signed components and transform the result through tangent, bitangent, and normal (TBN). Normal textures are linear data.

Tangents depend on geometry and UV orientation. Mirrored UVs need a handedness sign. Orthogonalize the tangent against the normal and reconstruct the bitangent consistently; handle degenerate UV triangles with a documented fallback. A normal map changes shading, not silhouettes or the shadow-casting geometry.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 25.1.** Begin on one cabin wall with a flat normal texture and a deliberately simple directional normal pattern. Verify that the flat map reproduces the original lighting.

2. **Task 25.2.** Generate tangents from position/UV differences using an explained derivation. Record a handedness sign and handle degenerate UVs. Validate the basis on a simple plane before processing all meshes.

3. **Task 25.3.** Transform tangent and normal consistently into the chosen shading space. Re-orthogonalize as needed and form the bitangent with the documented handedness convention.

4. **Task 25.4.** Sample and decode the map, normalize the resulting shading normal, and feed it into the material model. Add a normal-strength control that preserves a sensible flat limit.

5. **Task 25.5.** Apply restrained maps to wood/stone/bark, with correct licensing if imported. Test rotation, nonuniform scaling, and a mirrored-UV diagnostic. Keep geometric and shading-normal debug views.

## 5. Predict-and-observe experiments

Rotate the object while the sun is fixed and verify the detail rotates with it. Flip the map green channel only as a controlled convention experiment; document the correct convention rather than keeping a mystery fix.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

Sampling a normal map as sRGB distorts directions. Treating map RGB directly as a world normal glues detail to the wrong space. Nonuniform scale and mirrored UVs expose incomplete TBN construction. More dramatic normal maps cannot fix a low-detail silhouette.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] A flat map preserves baseline shading and directional test patterns orient correctly.
- [ ] Tangent basis handles the chosen UV/scaling cases without NaNs.
- [ ] The learner distinguishes geometric visibility from perturbed surface shading.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Review tangent derivation, degenerate handling, handedness, decoding, and transformed basis. Require flat-map and rotated-object evidence.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why does a normal map not change the outline of the roof?
- Why does mirrored UV orientation affect the bitangent?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 25: add surface detail with tangent-space normals`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R05](../REFERENCE.md#r05) · [R09](../REFERENCE.md#r09) · [R13](../REFERENCE.md#r13)

Read only what resolves the current question. No parallax occlusion mapping or displacement. Imported tangent generation may be studied afterward, once the simple case is understood.
