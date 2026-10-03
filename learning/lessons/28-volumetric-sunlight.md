# 28 — Trace sunlight through forest mist

**Track:** Advanced · **Implementation effort hint:** 5–8 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 27](./27-screen-space-occlusion.md) · [Next: 29](./29-temporal-antialiasing.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Extend the simple fog into a low-resolution single-scattering volume effect that reveals sunlit mist between trees.

## 2. Prerequisites and starting checkpoint

Lesson 27 complete; readable depth, shadow sampling, and HDR composition are stable.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

Distance fog blends toward a color; volumetric fog estimates light added and lost along a view ray through a participating medium. Introduce extinction, scattering, transmittance, and step length with a one-dimensional example. Begin with a uniform or simple height-dependent density and isotropic scattering.

March from the camera to the nearest opaque surface or a capped far distance. At each step, sample sun visibility through the existing shadow map and accumulate attenuated in-scattering. Composition uses volume radiance plus transmittance times the surface/background. Step-size dependence and double-counted fog are the first correctness checks.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 28.1.** Implement a diagnostic ray-distance view and verify ray endpoints against scene depth. Define an explicit far limit for sky pixels and a fog volume extent.

2. **Task 28.2.** Derive one step of absorption/transmittance from an explained exponential model. Test a uniform medium with no scattering against its known distance behavior.

3. **Task 28.3.** Add isotropic single scattering from the directional sun with shadow-map visibility. Accumulate front to back with a defined world-space step length and finite iteration bound.

4. **Task 28.4.** Render at reduced resolution and upsample with depth awareness. Keep volume targets resident and retained, bind them through argument tables, and synchronize producers with consumers. Compare a small full-resolution reference and inspect silhouette leakage.

5. **Task 28.5.** Composite into linear HDR before tone mapping and disable the earlier distance-fog term to avoid counting the same medium twice. Add quality, density, and off controls.

6. **Task 28.6.** Compare several step counts and measure GPU cost. Keep a clear-weather preset and explain artifacts from limited shadow coverage and missing multiple scattering.

## 5. Common mistakes and investigation

Forgetting step length changes energy with sample count. Marching beyond the visible surface puts fog behind an opaque wall into the result. Low-resolution upsampling can leak shafts across edges. A black fog texture may indicate incorrect transmittance initialization, not insufficient light intensity.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R10](../REFERENCE.md#r10) · [R11](../REFERENCE.md#r11) · [R12](../REFERENCE.md#r12) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. No volumetric clouds, multiple scattering, or temporal volume history. Use modest scene scale and a bounded sample budget.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Double the number of steps while keeping total distance fixed; a correctly scaled integral should converge rather than simply double brightness. Disable shadow visibility to show what produces the light shafts. Compare thin and dense fog.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] The uniform-medium test and step-count convergence behave sensibly.
- [ ] Mist terminates at scene geometry and respects sun visibility.
- [ ] Composition avoids duplicate fog, and the cost/quality tradeoff is documented.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why should smaller steps not automatically make the fog brighter?
- What physical behavior is missing from single scattering?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Review integration order, step units, endpoint reconstruction, shadow coordinates, transmittance bounds, and upsampling. Ask for absorption-only evidence before the final artistic scene.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 28: trace sunlight through forest mist`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
