# 28 — Trace sunlight through forest mist

**Track:** Advanced · **Implementation effort hint:** 5–8 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 27](./27-screen-space-occlusion.md) · [Next: 29](./29-temporal-antialiasing.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach this lesson in manageable steps across messages, with thorough plain-language theory, worked examples, and explained snippets with exact placement. Deliver the current step and pause before continuing. Keep understanding questions until the end of the entire lesson; no per-step quizzes or mandatory commits. Check file responsibilities before extending them and teach small extractions before code causes bloat. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Extend the simple fog into a low-resolution single-scattering volume effect that reveals sunlit mist between trees.

## 2. Prerequisites and starting checkpoint

Lesson 27 complete; readable depth, shadow sampling, and HDR composition are stable.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

Distance fog blends toward a color; volumetric fog estimates light added and lost along a view ray through a participating medium. Introduce extinction, scattering, transmittance, and step length with a one-dimensional example. Begin with a uniform or simple height-dependent density and isotropic scattering.

March from the camera to the nearest opaque surface or a capped far distance. At each step, sample sun visibility through the existing shadow map and accumulate attenuated in-scattering. Composition uses volume radiance plus transmittance times the surface/background. Step-size dependence and double-counted fog are the first correctness checks.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Explain the concepts needed for each step and demonstrate predictions yourself; ask understanding questions only in the final section of the entire lesson.

## 4. Explained implementation walkthrough

Use these task IDs to plan manageable teaching steps across messages. Deliver one coherent step at a time, grouping related tasks or splitting a large task as needed. Explain the theory and show clear Swift/MSL snippets with the actual file, type/function, add/replace action, insertion anchor, and dependencies. First check whether affected files have clear responsibilities; teach a focused extraction before adding code if needed. Include expected behavior and relevant implementation checks, then pause for the learner to apply the step or ask for help. Keep understanding questions and learner calculations until the end of the entire lesson; demonstrate predictions yourself in earlier steps. Do not require per-step commits or formal reviews. Exploratory changes and extra variations remain optional.

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

Present this consolidated section after the final teaching step, once all lesson theory and code have been explained. The learner may already have applied earlier steps. Collect all understanding questions here, along with the final checklist and submission directions; do not distribute quizzes across step boundaries.

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
