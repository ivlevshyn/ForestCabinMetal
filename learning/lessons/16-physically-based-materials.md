# 16 — Give wood, stone, and metal distinct responses

**Track:** Core · **Implementation effort hint:** 4–7 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 15](./15-linear-hdr-pipeline.md) · [Next: 17](./17-porch-light-and-emission.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Upgrade direct sunlight to a basic metallic-roughness material model so rough wood, stone, and a metal chimney behave differently under the same light.

## 2. Prerequisites and starting checkpoint

Lesson 15 complete; linear HDR lighting, normals, and view direction are available.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

A BRDF describes how a surface reflects incoming light toward a viewer. Explain diffuse versus specular reflection, the halfway vector, roughness, metallic behavior, and grazing-angle Fresnel response with pictures and simple limit cases before introducing equations.

Use one documented microfacet model: GGX distribution, a consistent geometry term, and Schlick Fresnel, with a matching roughness-to-alpha convention. The tutor must supply and explain the equations from a named primary reference; the learner implements them in stages. Roughness is not a vague shininess multiplier, and metallic surfaces should not retain the same diffuse term as a dielectric. Indirect lighting remains a clearly labeled approximation until lesson 26.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 16.1.** Add base color, roughness, and metallic parameters to materials. Make a temporary row of diagnostic spheres or rounded meshes inside the same app, with a documented roughness progression.

2. **Task 16.2.** Work through normalized N, L, V, and H for one simple surface. Handle the degenerate case where L + V is near zero. Visualize dot products before combining the model.

3. **Task 16.3.** Implement the chosen model one explained term at a time. Expose separate diffuse and specular debug views and guard near-zero denominators consistently.

4. **Task 16.4.** Combine the direct-light response with sunlight intensity and shadow visibility in linear HDR. Use the reference model's energy-sharing convention; document any approximation.

5. **Task 16.5.** Tune the cabin materials conservatively. Make the chimney metallic, wood and stone dielectric, and compare at fixed light/exposure. Keep the diagnostic material row as a debug option.

## 5. Common mistakes and investigation

Different references square roughness at different points; mixing formulas changes the model. Gamma-encoded material data corrupts the result. Excessive ambient fill can hide whether direct lighting is correct. Metallic does not mean simply adding a brighter white highlight.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R05](../REFERENCE.md#r05) · [R12](../REFERENCE.md#r12) · [R13](../REFERENCE.md#r13)

Read only what resolves the current question. No clearcoat, subsurface scattering, anisotropy, or full global illumination. Image-based indirect light arrives in lesson 26.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Predict the highlight change as roughness increases and as the view approaches a grazing angle. Compare metallic 0 and 1 at the same base color. Ensure a surface facing away from the light does not produce invalid values.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] The material row shows stable, sensible roughness and metallic variation.
- [ ] Cabin materials share one explained model with finite outputs in edge cases.
- [ ] The direct-light model and its roughness convention are documented with a primary reference.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why does rough metal still reflect its surroundings even without a sharp highlight?
- What does a roughness map contain, and why is it linear data?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Check vector spaces, normalization, roughness clamping, denominator guards, energy sharing, and reference consistency. Evaluate controlled material comparisons before judging artistic realism.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 16: give wood, stone, and metal distinct responses`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
