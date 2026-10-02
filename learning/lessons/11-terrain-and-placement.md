# 11 — Generate a small forest clearing

**Track:** Core · **Planning hint:** 3–5 small sessions (flexible, not a deadline)

[Previous: 10](./10-materials-and-scene-data.md) · [Next: 12](./12-instanced-forest.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Replace the flat ground with a repeatable height-field terrain and place the cabin, path, and rocks deliberately within it.

## 2. Prerequisites and starting checkpoint

Lesson 10 complete; mesh generation, UVs, normals, and material references work.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

A height field assigns height h(x,z) to a grid. Two triangles per cell form a surface. Begin with a simple smooth analytic hill so derivatives and vertex positions are predictable; noise is an optional later variation. Smooth normals can come from neighboring heights or accumulated face normals.

The cabin needs a level foundation even on varied ground. Separate visual randomness from nondeterminism by using a fixed seed for placement. CPU generation at startup is appropriate for this small static scene; GPU generation is not inherently better.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 11.1.** Generate a rectangular grid with a small number of cells. Predict vertex and index counts and inspect winding in wireframe or a debug view before adding height.

2. **Task 11.2.** Use a gentle explained height function. Recompute smooth normals and verify their direction with the normal debug mode; update ground UV scale consistently.

3. **Task 11.3.** Flatten or smoothly blend a foundation region beneath the cabin. Explain how your boundary transition avoids a sudden ledge.

4. **Task 11.4.** Add a placement helper that queries ground height consistently with the mesh. Place rocks and mark a path while keeping the doorway clear. If interpolation is approximate, describe that limitation.

5. **Task 11.5.** Store a deterministic seed and scene dimensions. Rebuild the scene twice and compare images; alter the seed only for explicit experiments.

## 5. Predict-and-observe experiments

Double grid density and compare silhouette, triangle count, and normal smoothness. Increase terrain amplitude and inspect the cabin foundation. Distinguish geometry detail from texture detail.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

An off-by-one grid index can connect unrelated rows. Normals computed with a different spacing than the grid tilt lighting incorrectly. Random placement can put objects inside the cabin. Sampling a different height function than the rendered mesh causes floating props.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Terrain has coherent winding, UVs, and normals with no invalid indices.
- [ ] The cabin sits on a stable foundation; props follow the surface.
- [ ] A fixed seed reproduces the same arrangement.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Review grid counts, boundary handling, normal generation, and foundation placement. Request wireframe and lit images from the same pose plus one count calculation.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Which changes require rebuilding the mesh?
- Why is reproducibility useful when comparing rendering techniques?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 11: generate a small forest clearing`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R05](../REFERENCE.md#r05) · [R06](../REFERENCE.md#r06)

Read only what resolves the current question. Keep a finite clearing. No erosion, infinite terrain, chunk streaming, or advanced noise library is required.
