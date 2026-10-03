# 11 — Generate a small forest clearing

**Track:** Core · **Implementation effort hint:** 3–5 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 10](./10-materials-and-scene-data.md) · [Next: 12](./12-instanced-forest.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Replace the flat ground with a repeatable height-field terrain and place the cabin, path, and rocks deliberately within it.

## 2. Prerequisites and starting checkpoint

Lesson 10 complete; mesh generation, UVs, normals, and material references work.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

A height field assigns height h(x,z) to a grid. Two triangles per cell form a surface. Begin with a simple smooth analytic hill so derivatives and vertex positions are predictable; noise is an optional later variation. Smooth normals can come from neighboring heights or accumulated face normals.

The cabin needs a level foundation even on varied ground. Separate visual randomness from nondeterminism by using a fixed seed for placement. CPU generation at startup is appropriate for this small static scene; GPU generation is not inherently better.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 11.1.** Generate a rectangular grid with a small number of cells. Predict vertex and index counts and inspect winding in wireframe or a debug view before adding height.

2. **Task 11.2.** Use a gentle explained height function. Recompute smooth normals and verify their direction with the normal debug mode; update ground UV scale consistently.

3. **Task 11.3.** Flatten or smoothly blend a foundation region beneath the cabin. Explain how your boundary transition avoids a sudden ledge.

4. **Task 11.4.** Add a placement helper that queries ground height consistently with the mesh. Place rocks and mark a path while keeping the doorway clear. If interpolation is approximate, describe that limitation.

5. **Task 11.5.** Store a deterministic seed and scene dimensions. Rebuild the scene twice and compare images; alter the seed only for explicit experiments.

## 5. Common mistakes and investigation

An off-by-one grid index can connect unrelated rows. Normals computed with a different spacing than the grid tilt lighting incorrectly. Random placement can put objects inside the cabin. Sampling a different height function than the rendered mesh causes floating props.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R05](../REFERENCE.md#r05) · [R06](../REFERENCE.md#r06)

Read only what resolves the current question. Keep a finite clearing. No erosion, infinite terrain, chunk streaming, or advanced noise library is required.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Double grid density and compare silhouette, triangle count, and normal smoothness. Increase terrain amplitude and inspect the cabin foundation. Distinguish geometry detail from texture detail.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Terrain has coherent winding, UVs, and normals with no invalid indices.
- [ ] The cabin sits on a stable foundation; props follow the surface.
- [ ] A fixed seed reproduces the same arrangement.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Which changes require rebuilding the mesh?
- Why is reproducibility useful when comparing rendering techniques?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Review grid counts, boundary handling, normal generation, and foundation placement. Request wireframe and lit images from the same pose plus one count calculation.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 11: generate a small forest clearing`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
