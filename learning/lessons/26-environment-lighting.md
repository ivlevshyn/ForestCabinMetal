# 26 — Light materials with the surrounding sky

**Track:** Advanced · **Implementation effort hint:** 6–10 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 25](./25-normal-mapping.md) · [Next: 27](./27-screen-space-occlusion.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Replace the constant ambient placeholder with approximate image-based lighting (IBL), making shaded wood and reflective metal respond to the environment.

## 2. Prerequisites and starting checkpoint

Lesson 25 complete; PBR, HDR, compute, and texture sampling are understood.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

An environment map represents incoming light from directions around a point. A cubemap stores six views of those directions. Diffuse and glossy materials integrate that incoming light differently. A normal mip chain is not a physically meaningful roughness-prefiltered environment by itself.

Organize the complete walkthrough in dependency order: direction lookup, diffuse integration, rough-specular prefiltering, then a documented split-sum approximation using a BRDF lookup table. Explain sampling and the formulas from a named reference with placed snippets for each stage, without mandatory conversational pauses. The learner may implement at their own pace after reading the whole explanation. Bake slowly at startup or offline first; runtime rebaking is not required.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 26.1.** Create a tiny labeled cubemap or bake the current procedural sky into one. Verify all six directions and orientation with a diagnostic reflective sphere. Keep the sun-energy policy explicit to avoid counting a sharp sun twice.

2. **Task 26.2.** Implement a simple low-resolution diffuse irradiance bake. Explain cosine weighting and normalization using a constant environment, whose response should be uniform.

3. **Task 26.3.** Build a roughness-dependent specular prefilter through staged sampling. Define the roughness-to-mip mapping and check that increasing roughness broadens reflected detail.

4. **Task 26.4.** Generate or load a BRDF integration lookup table matching the material model. Keep all baked images resident and retained; order Metal 4 bake dispatches and later shader reads explicitly. Start with a tiny inspectable texture before increasing resolution/sample count.

5. **Task 26.5.** Combine diffuse and specular indirect terms with the existing direct lights. Remove the old constant ambient contribution or keep it only in an explicitly named comparison mode.

6. **Task 26.6.** Test wood, stone, and metal under both a constant environment and the sky environment. Keep exposure fixed for comparisons and document environment-locality limitations.

## 5. Common mistakes and investigation

Incorrect cubemap orientation can look plausible in a sky but fail reflections. Using the direct-light geometry approximation blindly for IBL can mismatch the lookup table. The environment does not know that a roof blocks part of the sky. Double-counted ambient or sun energy makes tuning misleading.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R13](../REFERENCE.md#r13) · [R15](../REFERENCE.md#r15) · [R09](../REFERENCE.md#r09) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. This is a multi-session advanced lesson. No dynamic reflection probes, parallax correction, or full global illumination is required.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Rotate the environment without rotating the objects and predict reflection motion. Use a constant-color environment to reveal normalization errors. Compare roughness-prefiltered results with ordinary texture mipmaps.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Environment orientation passes labeled-direction tests.
- [ ] Diffuse and rough-specular indirect terms have documented, consistent conventions.
- [ ] Constant-environment and roughness tests pass, and ambient double counting is avoided.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why is a blurred environment not automatically the correct response for every material?
- What scene visibility does this environment approximation ignore?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Review bake dependencies, sample normalization, roughness mapping, lookup-table convention, and HDR formats. Permit a low-resolution slow bake; the target is understanding and correctness before speed.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 26: light materials with the surrounding sky`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
