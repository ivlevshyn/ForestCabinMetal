# 29 — Use previous frames without smearing motion

**Track:** Advanced · **Implementation effort hint:** 7–12 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 28](./28-volumetric-sunlight.md) · [Next: 30](./30-advanced-capstone.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach this lesson in manageable steps across messages, with thorough plain-language theory, worked examples, and explained snippets with exact placement. Deliver the current step and pause before continuing. Keep understanding questions until the end of the entire lesson; no per-step quizzes or mandatory commits. Check file responsibilities before extending them and teach small extractions before code causes bloat. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Build an educational temporal anti-aliasing (TAA) path to reduce shimmering on roof edges and distant foliage, while exposing its failure cases.

## 2. Prerequisites and starting checkpoint

Lesson 28 complete. Frame resources, coordinate transforms, depth, offscreen textures, and animation are prerequisites. Teach the implementation in manageable steps across messages, allowing time to apply and debug each step. Keep understanding questions and final submission directions at the end of the entire lesson.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

TAA combines current samples with reprojected history. A small subpixel projection jitter samples different locations over time. Motion vectors map a current surface to its previous screen location, and history rejection avoids mixing unrelated surfaces after motion or occlusion changes.

Specify units and signs before coding: for example UV displacement = previous unjittered UV minus current unjittered UV, with jitter handled explicitly during lookup. Keep previous camera/object transforms and previous deformation time. A matrix-only motion vector is not correct for moving leaves. History should have a documented linear color/exposure convention and be invalidated on camera cuts, resize, and incompatible setting changes.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Explain the concepts needed for each step and demonstrate predictions yourself; ask understanding questions only in the final section of the entire lesson.

## 4. Explained implementation walkthrough

Use these task IDs to plan manageable teaching steps across messages. Deliver one coherent step at a time, grouping related tasks or splitting a large task as needed. Explain the theory and show clear Swift/MSL snippets with the actual file, type/function, add/replace action, insertion anchor, and dependencies. First check whether affected files have clear responsibilities; teach a focused extraction before adding code if needed. Include expected behavior and relevant implementation checks, then pause for the learner to apply the step or ask for help. Keep understanding questions and learner calculations until the end of the entire lesson; demonstrate predictions yourself in earlier steps. Do not require per-step commits or formal reviews. Exploratory changes and extra variations remain optional.

1. **Task 29.1.** Freeze wind, particles, and camera. Implement a small known jitter sequence and an accumulation view for a static scene. Verify subpixel shifts numerically and reset history on resize.

2. **Task 29.2.** Produce and visualize motion vectors for camera motion and rigid cabin objects using previous/current transforms. Reproject history with an explicitly documented jitter convention.

3. **Task 29.3.** Add validity checks for out-of-bounds lookup, disocclusion using compatible depth, and camera resets. Compare current-only, history-only, and accumulated views.

4. **Task 29.4.** Add a basic neighborhood clamp and tune history weight with a bright window moving across a dark background. Explain the stability-versus-ghosting tradeoff rather than hiding it.

5. **Task 29.5.** Restore wind with previous/current deformation evaluation or deliberately reject/reduce history for foliage until motion is correct. Treat fireflies and volumetric fog explicitly: a simple first policy is to composite them after opaque TAA.

6. **Task 29.6.** Place TAA coherently in the HDR chain and document exposure/bloom order. Explicitly protect history ping-pong images across frames under Metal 4, including reads before overwrite; the CPU frame-slot gate alone is not a substitute. Record motion/reset/resize comparisons and memory/GPU cost.

## 5. Common mistakes and investigation

Velocity in pixels sampled as UV units creates scale-dependent errors. Jitter counted twice shifts the image. Old history after resize or a camera cut produces ghosts. Averaging differently exposed frames without compensation creates brightness lag. Including animated particles without a history policy produces trails.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R19](../REFERENCE.md#r19) · [R11](../REFERENCE.md#r11) · [R07](../REFERENCE.md#r07) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. Build a modest educational TAA first. MetalFX is an optional comparison after the input contracts are understood; it is not a substitute for the lesson.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section after the final teaching step, once all lesson theory and code have been explained. The learner may already have applied earlier steps. Collect all understanding questions here, along with the final checklist and submission directions; do not distribute quizzes across step boundaries.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Disable history rejection to recognize disocclusion trails. Increase history weight and compare still-image stability against motion smearing. Pause wind and explain why motion vectors should change accordingly.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Static accumulation improves stability and motion reprojection has verified units/signs.
- [ ] Disocclusion, resize, camera cuts, and animated foliage have explicit handling.
- [ ] A comparison video and debug views demonstrate both benefits and remaining artifacts.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why can a perfectly valid previous pixel still belong to the wrong surface?
- Which scene changes require invalidating history even if the camera did not move?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Review current/previous state timing, jitter math, history ping-pong lifetime, depth compatibility, and composition order. Require numerical motion checks and dynamic evidence; a still screenshot cannot validate TAA.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 29: use previous frames without smearing motion`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
