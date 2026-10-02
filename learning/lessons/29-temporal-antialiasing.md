# 29 — Use previous frames without smearing motion

**Track:** Advanced · **Planning hint:** 7–12 small sessions (flexible, not a deadline)

[Previous: 28](./28-volumetric-sunlight.md) · [Next: 30](./30-advanced-capstone.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Build an educational temporal anti-aliasing (TAA) path to reduce shimmering on roof edges and distant foliage, while exposing its failure cases.

## 2. Prerequisites and starting checkpoint

Lesson 28 complete. Frame resources, coordinate transforms, depth, offscreen textures, and animation are prerequisites. Split this lesson across multiple sessions.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

TAA combines current samples with reprojected history. A small subpixel projection jitter samples different locations over time. Motion vectors map a current surface to its previous screen location, and history rejection avoids mixing unrelated surfaces after motion or occlusion changes.

Specify units and signs before coding: for example UV displacement = previous unjittered UV minus current unjittered UV, with jitter handled explicitly during lookup. Keep previous camera/object transforms and previous deformation time. A matrix-only motion vector is not correct for moving leaves. History should have a documented linear color/exposure convention and be invalidated on camera cuts, resize, and incompatible setting changes.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 29.1.** Freeze wind, particles, and camera. Implement a small known jitter sequence and an accumulation view for a static scene. Verify subpixel shifts numerically and reset history on resize.

2. **Task 29.2.** Produce and visualize motion vectors for camera motion and rigid cabin objects using previous/current transforms. Reproject history with an explicitly documented jitter convention.

3. **Task 29.3.** Add validity checks for out-of-bounds lookup, disocclusion using compatible depth, and camera resets. Compare current-only, history-only, and accumulated views.

4. **Task 29.4.** Add a basic neighborhood clamp and tune history weight with a bright window moving across a dark background. Explain the stability-versus-ghosting tradeoff rather than hiding it.

5. **Task 29.5.** Restore wind with previous/current deformation evaluation or deliberately reject/reduce history for foliage until motion is correct. Treat fireflies and volumetric fog explicitly: a simple first policy is to composite them after opaque TAA.

6. **Task 29.6.** Place TAA coherently in the HDR chain and document exposure/bloom order. Explicitly protect history ping-pong images across frames under Metal 4, including reads before overwrite; the CPU frame-slot gate alone is not a substitute. Record motion/reset/resize comparisons and memory/GPU cost.

## 5. Predict-and-observe experiments

Disable history rejection to recognize disocclusion trails. Increase history weight and compare still-image stability against motion smearing. Pause wind and explain why motion vectors should change accordingly.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

Velocity in pixels sampled as UV units creates scale-dependent errors. Jitter counted twice shifts the image. Old history after resize or a camera cut produces ghosts. Averaging differently exposed frames without compensation creates brightness lag. Including animated particles without a history policy produces trails.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Static accumulation improves stability and motion reprojection has verified units/signs.
- [ ] Disocclusion, resize, camera cuts, and animated foliage have explicit handling.
- [ ] A comparison video and debug views demonstrate both benefits and remaining artifacts.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Review current/previous state timing, jitter math, history ping-pong lifetime, depth compatibility, and composition order. Require numerical motion checks and dynamic evidence; a still screenshot cannot validate TAA.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why can a perfectly valid previous pixel still belong to the wrong surface?
- Which scene changes require invalidating history even if the camera did not move?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 29: use previous frames without smearing motion`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R19](../REFERENCE.md#r19) · [R11](../REFERENCE.md#r11) · [R07](../REFERENCE.md#r07) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. Build a modest educational TAA first. MetalFX is an optional comparison after the input contracts are understood; it is not a substitute for the lesson.
