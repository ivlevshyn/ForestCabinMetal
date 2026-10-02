# 15 — Make lighting linear and add HDR rendering

**Track:** Core · **Planning hint:** 3–5 small sessions (flexible, not a deadline)

[Previous: 14](./14-sky-and-distance-fog.md) · [Next: 16](./16-physically-based-materials.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Render the scene into a floating-point offscreen image, then control exposure and tone mapping in a final display pass.

## 2. Prerequisites and starting checkpoint

Lesson 14 complete; texture color-space basics and an offscreen shadow pass are familiar.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

Linear light values can be added meaningfully; display-encoded sRGB values cannot be treated as linear energy. Color images are decoded on sampling when configured as sRGB. A floating-point HDR target preserves values greater than one until the display transform. This is an internal rendering choice and does not require an HDR display.

Exposure scales radiance; an exposure adjustment in stops multiplies by 2 to that power. A tone mapper compresses a large range into the displayable range. Begin with a simple explained operator and make its artistic limitations explicit. Output linear display-range color to an sRGB drawable so encoding happens once, not twice.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 15.1.** Draw a diagram of the current color path: input image decoding, lighting, fog, attachment storage, and display encoding. Identify any manual gamma operations that would now be duplicated.

2. **Task 15.2.** Allocate resident, strongly owned rgba16Float scene and depth targets and compatible MTL4Compiler pipeline states. Render to the HDR image and store it. Bind it through a fragment argument table in the display pass, with an explicit dependency from scene rendering to texture sampling.

3. **Task 15.3.** Create a full-screen display pass that samples the HDR target. Begin with controlled values, then add exposure and a simple tone-map equation explained by the tutor.

4. **Task 15.4.** Recreate size-dependent targets only with a safe retirement policy for old allocations. Update residency membership and argument-table IDs. Record formats, usage, sample counts, load/store actions, and the producer/consumer stages and barriers for each image.

5. **Task 15.5.** Use a diagnostic bright patch and a gray ramp. Compare clipping before tone mapping with preserved highlight variation afterward. Verify base-color textures are decoded once and final output is encoded once.

## 5. Predict-and-observe experiments

Increase exposure by one stop and predict the pre-tone-map value. View an HDR target with values above one in a capture. Temporarily add an extra gamma conversion to recognize the symptom, then remove it.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

Applying tone mapping per object before lighting/compositing breaks the intended pipeline. A floating target alone does not make lighting linear. Sampling the current drawable as though it were your offscreen scene can require different usage settings and is unnecessary here.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Lighting is accumulated in a linear floating-point target and displayed through one tone-map stage.
- [ ] Resize recreates all relevant targets without mismatched dimensions.
- [ ] A documented color-path diagram explains all conversions.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Review texture formats, conversion count, pipeline compatibility, attachment lifetime, and resizing. Ask for diagnostic-ramp evidence and an explanation of values above one.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why is HDR rendering useful on an ordinary display?
- What differs between exposure and making every material lighter?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 15: make lighting linear and add hdr rendering`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R09](../REFERENCE.md#r09) · [R10](../REFERENCE.md#r10) · [R12](../REFERENCE.md#r12) · [R22](../REFERENCE.md#r22) · [R23](../REFERENCE.md#r23) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. Use SDR presentation with an sRGB drawable. EDR display support, automatic exposure, and color grading are not required.
