# 09 — Put wood, bark, and ground on surfaces

**Track:** Core · **Planning hint:** 3–4 small sessions (flexible, not a deadline)

[Previous: 08](./08-normals-and-sunlight.md) · [Next: 10](./10-materials-and-scene-data.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Add texture coordinates and sampled images to the cabin and ground, while keeping a diagnostic texture that makes mapping errors obvious.

## 2. Prerequisites and starting checkpoint

Lesson 08 complete; layout changes and fragment lighting are understood.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

A texture is structured image data on the GPU; UV coordinates identify where to sample it. A sampler specifies addressing and filtering. UVs interpolate across triangles, but a geometric corner may need different UVs on adjacent faces, requiring separate vertices.

Distinguish magnification from minification. Mipmaps are successively smaller filtered images that help when many source texels cover one screen pixel. Explain repeat versus clamp and nearest versus linear filtering through observation. Color textures should be decoded from sRGB before lighting; a data texture must not get that same color conversion.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 09.1.** Make or use a tiny asymmetric diagnostic image with labeled corners and a checker pattern. Add UVs to the vertex layout and visualize UV coordinates as color before loading the image.

2. **Task 09.2.** Load the image with MTKTextureLoader or a small manual upload. Record orientation and sRGB options. Make the texture allocation resident and keep it alive; put texture and sampler resource IDs in a Metal 4 argument table with sufficient capacity and bind it to the fragment stage. Configure sampler compatibility for this binding route as required by the SDK.

3. **Task 09.3.** Sample in the fragment function and multiply the linear base color into your diffuse material response. Check every cabin face for orientation and stretching.

4. **Task 09.4.** Explore repeat/clamp and nearest/linear sampling. Tile ground UVs. Load or generate mip levels; GPU mip generation uses the Metal 4 unified compute encoder’s copy/blit facilities and an explicit dependency before sampling the generated levels. Keep startup uploads and ongoing frame work ordered.

5. **Task 09.5.** Replace selected diagnostic surfaces with simple wood and ground textures. Record attribution for any external asset. Keep a toggle for the diagnostic image and compare distant shimmering with and without mipmaps.

## 5. Predict-and-observe experiments

Predict what UV = (2.25, 0.5) samples under repeat versus clamp. Make the ground recede into the distance and compare texture stability. Flip one image once to understand the origin issue, then restore the documented policy.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

Do not treat roughness or normal data as sRGB later. A seam is not always a filtering bug; it may be a UV discontinuity. Loading textures during every frame hides a resource-lifetime mistake. Mip filtering cannot help if mip levels were never populated.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] Cabin and ground have intentional, consistent UV mapping.
- [ ] A mipmapped texture and explicit sampler are used correctly.
- [ ] Color-space and image-origin choices are documented and diagnostic views remain available.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Check loader options, texture/sampler bindings, vertex layout, mip availability, and asset provenance. Ask for the labeled texture on the cabin before judging artistic texture quality.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Why might a box require more than eight vertices?
- What problem do mipmaps solve that a larger source image does not?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 09: put wood, bark, and ground on surfaces`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R09](../REFERENCE.md#r09) · [R05](../REFERENCE.md#r05) · [R06](../REFERENCE.md#r06) · [R22](../REFERENCE.md#r22) · [R23](../REFERENCE.md#r23) · [R16](../REFERENCE.md#r16) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. No texture atlases, compression pipeline, normal maps, or downloaded photorealistic asset pack is required.
