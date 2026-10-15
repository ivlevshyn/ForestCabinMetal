# 25 — Add surface detail with tangent-space normals

**Track:** Advanced · **Implementation effort hint:** 4–6 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 24](./24-gpu-visibility-and-indirect-draws.md) · [Next: 26](./26-environment-lighting.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach this lesson in manageable steps across messages, with thorough plain-language theory, worked examples, and explained snippets with exact placement. Deliver the current step and pause before continuing. Keep understanding questions until the end of the entire lesson; no per-step quizzes or mandatory commits. Check file responsibilities before extending them and teach small extractions before code causes bloat. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Make cabin wood grain, stone, and bark respond to light with small-scale surface detail without adding geometry.

## 2. Prerequisites and starting checkpoint

Lesson 24 complete on the default path; technical prerequisites are UVs, normals, and PBR from 09 and 16. Later techniques must continue to work.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

A normal map stores a direction relative to a surface's tangent basis, not a replacement world-space normal or a height image. Decode its RGB values from [0,1] to signed components and transform the result through tangent, bitangent, and normal (TBN). Normal textures are linear data.

Tangents depend on geometry and UV orientation. Mirrored UVs need a handedness sign. Orthogonalize the tangent against the normal and reconstruct the bitangent consistently; handle degenerate UV triangles with a documented fallback. A normal map changes shading, not silhouettes or the shadow-casting geometry.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Explain the concepts needed for each step and demonstrate predictions yourself; ask understanding questions only in the final section of the entire lesson.

## 4. Explained implementation walkthrough

Use these task IDs to plan manageable teaching steps across messages. Deliver one coherent step at a time, grouping related tasks or splitting a large task as needed. Explain the theory and show clear Swift/MSL snippets with the actual file, type/function, add/replace action, insertion anchor, and dependencies. First check whether affected files have clear responsibilities; teach a focused extraction before adding code if needed. Include expected behavior and relevant implementation checks, then pause for the learner to apply the step or ask for help. Keep understanding questions and learner calculations until the end of the entire lesson; demonstrate predictions yourself in earlier steps. Do not require per-step commits or formal reviews. Exploratory changes and extra variations remain optional.

1. **Task 25.1.** Begin on one cabin wall with a flat normal texture and a deliberately simple directional normal pattern. Verify that the flat map reproduces the original lighting.

2. **Task 25.2.** Generate tangents from position/UV differences using an explained derivation. Record a handedness sign and handle degenerate UVs. Validate the basis on a simple plane before processing all meshes.

3. **Task 25.3.** Transform tangent and normal consistently into the chosen shading space. Re-orthogonalize as needed and form the bitangent with the documented handedness convention.

4. **Task 25.4.** Sample and decode the map, normalize the resulting shading normal, and feed it into the material model. Add a normal-strength control that preserves a sensible flat limit.

5. **Task 25.5.** Apply restrained maps to wood/stone/bark, with correct licensing if imported. Test rotation, nonuniform scaling, and a mirrored-UV diagnostic. Keep geometric and shading-normal debug views.

## 5. Common mistakes and investigation

Sampling a normal map as sRGB distorts directions. Treating map RGB directly as a world normal glues detail to the wrong space. Nonuniform scale and mirrored UVs expose incomplete TBN construction. More dramatic normal maps cannot fix a low-detail silhouette.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R05](../REFERENCE.md#r05) · [R09](../REFERENCE.md#r09) · [R13](../REFERENCE.md#r13)

Read only what resolves the current question. No parallax occlusion mapping or displacement. Imported tangent generation may be studied afterward, once the simple case is understood.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section after the final teaching step, once all lesson theory and code have been explained. The learner may already have applied earlier steps. Collect all understanding questions here, along with the final checklist and submission directions; do not distribute quizzes across step boundaries.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Rotate the object while the sun is fixed and verify the detail rotates with it. Flip the map green channel only as a controlled convention experiment; document the correct convention rather than keeping a mystery fix.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] A flat map preserves baseline shading and directional test patterns orient correctly.
- [ ] Tangent basis handles the chosen UV/scaling cases without NaNs.
- [ ] The learner distinguishes geometric visibility from perturbed surface shading.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why does a normal map not change the outline of the roof?
- Why does mirrored UV orientation affect the bitangent?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Review tangent derivation, degenerate handling, handedness, decoding, and transformed basis. Require flat-map and rotated-object evidence.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 25: add surface detail with tangent-space normals`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
