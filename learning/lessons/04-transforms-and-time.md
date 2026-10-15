# 04 — Move geometry with transforms and time

**Track:** Core · **Implementation effort hint:** 3–4 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 03](./03-vertex-and-index-buffers.md) · [Next: 05](./05-perspective-and-depth.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach this lesson in manageable steps across messages, with thorough plain-language theory, worked examples, and explained snippets with exact placement. Deliver the current step and pause before continuing. Keep understanding questions until the end of the entire lesson; no per-step quizzes or mandatory commits. Check file responsibilities before extending them and teach small extractions before code causes bloat. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Move, rotate, and scale the wall/roof pieces using per-draw transforms, and animate a controlled motion without changing the stored mesh.

## 2. Prerequisites and starting checkpoint

Lesson 03 complete; indexed geometry works. Tutor introduces vectors and matrices from zero here.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

A vector can describe a position or direction. A matrix is a transformation rule. Teach scale and translation numerically, then homogeneous coordinates: points have W = 1 and directions W = 0. Explain identity, column-vector multiplication, and why a 4×4 matrix can express translation.

With model = translation × rotation × scale, scale acts first. Uniforms are values shared by shader invocations for a draw. Store them in resident MTLBuffer memory and provide its address through MTL4ArgumentTable. Each draw needs its own stable record or byte region: encoding a draw snapshots bindings, not the memory contents they point to. The single-frame completion gate protects reuse between frames, but does not make overwriting one record for two pending draws safe. Animation uses time, not a fixed change per frame.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Explain the concepts needed for each step and demonstrate predictions yourself; ask understanding questions only in the final section of the entire lesson.

## 4. Explained implementation walkthrough

Use these task IDs to plan manageable teaching steps across messages. Deliver one coherent step at a time, grouping related tasks or splitting a large task as needed. Explain the theory and show clear Swift/MSL snippets with the actual file, type/function, add/replace action, insertion anchor, and dependencies. First check whether affected files have clear responsibilities; teach a focused extraction before adding code if needed. Include expected behavior and relevant implementation checks, then pause for the learner to apply the step or ask for help. Keep understanding questions and learner calculations until the end of the entire lesson; demonstrate predictions yourself in earlier steps. Do not require per-step commits or formal reviews. Exploratory changes and extra variations remain optional.

1. **Task 04.1.** Transform two simple points by hand with identity and scale. Have the tutor explain matrix columns using a basis-vector picture; implement a scale constructor and test the numeric results in Swift.

2. **Task 04.2.** Design an aligned uniform record and allocate stable resident storage for it. Enter its GPU address in the argument table at a documented slot, apply the transform in MSL, and preserve immutable mesh data. Explain when the CPU may next write that region.

3. **Task 04.3.** Implement translation and a rotation about one axis from a supplied, explained equation. Predict the result for zero rotation and a quarter turn before running.

4. **Task 04.4.** Draw two objects using the same mesh and distinct uniform records or nonoverlapping byte regions. Before each draw select its record address in the argument table. Explain why changing a table entry is different from overwriting memory referenced by an earlier draw.

5. **Task 04.5.** Animate a gentle rotation using time. Add pause/reset controls and handle a long pause or app suspension without a large delta-time jump. Compare at two refresh/update rates if practical.

## 5. Common mistakes and investigation

Degrees passed to a sine function expecting radians are not a matrix bug. Mutating vertex positions each frame hides the purpose of a model transform. Frame-based increments change speed with refresh rate. A single CPU-writable GPU buffer is not automatically safe because the Mac has unified memory.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R05](../REFERENCE.md#r05) · [R06](../REFERENCE.md#r06) · [R07](../REFERENCE.md#r07) · [R22](../REFERENCE.md#r22) · [R25](../REFERENCE.md#r25)

Read only what resolves the current question. Keep the view orthographic/clip-space for this lesson. No camera or projection matrix until the next section.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section after the final teaching step, once all lesson theory and code have been explained. The learner may already have applied earlier steps. Collect all understanding questions here, along with the final checklist and submission directions; do not distribute quizzes across step boundaries.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Reverse translation and rotation order and explain orbiting versus spinning. Transform a direction with W = 0 and show why translation does not change it. Return the cabin pieces to a stable pose.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Multiple objects reuse the same mesh with independent transforms.
- [ ] Animation is time-based and can be paused/reset.
- [ ] You can predict transform order and distinguish a point from a direction.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Why keep original mesh positions unchanged?
- What does the rightmost matrix do in the adopted convention?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Check matrix order, column layout, time units, and constant lifetime. Ask for an explanation of a transformed point. A visual order-of-operations experiment is optional.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 04: move geometry with transforms and time`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
