# 12 — Draw a forest efficiently with instancing

**Track:** Core · **Implementation effort hint:** 3–4 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 11](./11-terrain-and-placement.md) · [Next: 13](./13-sun-shadows.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach this lesson in manageable steps across messages, with thorough plain-language theory, worked examples, and explained snippets with exact placement. Deliver the current step and pause before continuing. Keep understanding questions until the end of the entire lesson; no per-step quizzes or mandatory commits. Check file responsibilities before extending them and teach small extractions before code causes bloat. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Surround the cabin with many varied trees while sharing trunk and canopy meshes and reducing repeated draw setup.

## 2. Prerequisites and starting checkpoint

Lesson 11 complete; deterministic placement and shared materials exist.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

Instancing draws repeated geometry with a per-instance record selected by instance_id. The mesh stays the same while transforms, colors, and other attributes vary. It reduces repeated CPU command work but does not eliminate vertex work or invisible pixels automatically.

Begin with one trunk mesh and one opaque canopy mesh. One draw per compatible mesh/material group can render many instances. Use uniform positive scale initially to simplify normal transforms; if you support nonuniform scale, preserve correct normal handling for every instance.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Explain the concepts needed for each step and demonstrate predictions yourself; ask understanding questions only in the final section of the entire lesson.

## 4. Explained implementation walkthrough

Use these task IDs to plan manageable teaching steps across messages. Deliver one coherent step at a time, grouping related tasks or splitting a large task as needed. Explain the theory and show clear Swift/MSL snippets with the actual file, type/function, add/replace action, insertion anchor, and dependencies. First check whether affected files have clear responsibilities; teach a focused extraction before adding code if needed. Include expected behavior and relevant implementation checks, then pause for the learner to apply the step or ask for help. Keep understanding questions and learner calculations until the end of the entire lesson; demonstrate predictions yourself in earlier steps. Do not require per-step commits or formal reviews. Exploratory changes and extra variations remain optional.

1. **Task 12.1.** Create one simple trunk and canopy tree inside the existing scene. Verify its local origin and ground contact before generating more.

2. **Task 12.2.** Build deterministic instance records for positions, yaw, positive scale, and subtle color variation. Exclude the cabin footprint and path. Explain the CPU/MSL layout.

3. **Task 12.3.** Implement an instanced draw and fetch the correct record in the vertex function. Render trunks and canopies as separate compatible batches.

4. **Task 12.4.** Compare one tree, a few dozen, and several hundred at a fixed camera. Record draw count and instance count; do not promise a speedup before measuring.

5. **Task 12.5.** Keep an object-by-object debug mode for a small set and compare its image with the instanced path. Freeze instance data after initialization unless explicitly editing the forest.

## 5. Common mistakes and investigation

The shader can accidentally apply the model transform twice. Instance count exceeding buffer capacity is unsafe. A transform layout mismatch can look like random forest placement. Instancing does not mean every tree should use a different pipeline.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R04](../REFERENCE.md#r04) · [R05](../REFERENCE.md#r05) · [R06](../REFERENCE.md#r06) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. Use opaque low-poly foliage first. Cutout leaves and animation arrive in lesson 18.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section after the final teaching step, once all lesson theory and code have been explained. The learner may already have applied earlier steps. Collect all understanding questions here, along with the final checklist and submission directions; do not distribute quizzes across step boundaries.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Assign instance ID as a debug color and verify there are no missing or duplicated records. Change one instance transform and show that shared mesh data did not change. Compare CPU submission cost for equivalent scenes if your tools expose it.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] Tree placement is repeatable and respects the clearing.
- [ ] Compatible trees share buffers and render with instanced draws.
- [ ] Instanced and individual reference paths agree for a small diagnostic set.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- What work remains per tree after instancing?
- Why do trunks and canopies naturally form separate batches here?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Check instance stride, count, binding, transforms, normals, and resource immutability. Ask the learner to distinguish draw count reduction from actual GPU work reduction.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 12: draw a forest efficiently with instancing`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
