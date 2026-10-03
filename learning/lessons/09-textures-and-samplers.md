# 09 — Put wood, bark, and ground on surfaces

**Track:** Core · **Implementation effort hint:** 3–4 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 08](./08-normals-and-sunlight.md) · [Next: 10](./10-materials-and-scene-data.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Add texture coordinates and sampled images to the cabin and ground, while keeping a diagnostic texture that makes mapping errors obvious.

## 2. Prerequisites and starting checkpoint

Lesson 08 complete; layout changes and fragment lighting are understood.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

A texture is structured image data on the GPU; UV coordinates identify where to sample it. A sampler specifies addressing and filtering. UVs interpolate across triangles, but a geometric corner may need different UVs on adjacent faces, requiring separate vertices.

Distinguish magnification from minification. Mipmaps are successively smaller filtered images that help when many source texels cover one screen pixel. Explain repeat versus clamp and nearest versus linear filtering through observation. Color textures should be decoded from sRGB before lighting; a data texture must not get that same color conversion.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 09.1.** Make or use a tiny asymmetric diagnostic image with labeled corners and a checker pattern. Add UVs to the vertex layout and visualize UV coordinates as color before loading the image.

2. **Task 09.2.** Load the image with MTKTextureLoader or a small manual upload. Record orientation and sRGB options. Make the texture allocation resident and keep it alive; put texture and sampler resource IDs in a Metal 4 argument table with sufficient capacity and bind it to the fragment stage. Configure sampler compatibility for this binding route as required by the SDK.

3. **Task 09.3.** Sample in the fragment function and multiply the linear base color into your diffuse material response. Check every cabin face for orientation and stretching.

4. **Task 09.4.** Explore repeat/clamp and nearest/linear sampling. Tile ground UVs. Load or generate mip levels; GPU mip generation uses the Metal 4 unified compute encoder’s copy/blit facilities and an explicit dependency before sampling the generated levels. Keep startup uploads and ongoing frame work ordered.

5. **Task 09.5.** Replace selected diagnostic surfaces with simple wood and ground textures. Record attribution for any external asset. Keep a toggle for the diagnostic image and compare distant shimmering with and without mipmaps.

## 5. Common mistakes and investigation

Do not treat roughness or normal data as sRGB later. A seam is not always a filtering bug; it may be a UV discontinuity. Loading textures during every frame hides a resource-lifetime mistake. Mip filtering cannot help if mip levels were never populated.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R09](../REFERENCE.md#r09) · [R05](../REFERENCE.md#r05) · [R06](../REFERENCE.md#r06) · [R22](../REFERENCE.md#r22) · [R23](../REFERENCE.md#r23) · [R16](../REFERENCE.md#r16) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. No texture atlases, compression pipeline, normal maps, or downloaded photorealistic asset pack is required.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Predict what UV = (2.25, 0.5) samples under repeat versus clamp. Make the ground recede into the distance and compare texture stability. Flip one image once to understand the origin issue, then restore the documented policy.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Cabin and ground have intentional, consistent UV mapping.
- [ ] A mipmapped texture and explicit sampler are used correctly.
- [ ] Color-space and image-origin choices are documented and diagnostic views remain available.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why might a box require more than eight vertices?
- What problem do mipmaps solve that a larger source image does not?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Check loader options, texture/sampler bindings, vertex layout, mip availability, and asset provenance. Ask for the labeled texture on the cabin before judging artistic texture quality.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 09: put wood, bark, and ground on surfaces`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
