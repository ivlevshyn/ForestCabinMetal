# 30 — Ship an explainable advanced diorama

**Track:** Advanced · **Planning hint:** 4–7 small sessions (flexible, not a deadline)

[Previous: 29](./29-temporal-antialiasing.md) · Main course complete. Optional: [31 ray tracing](./31-hybrid-ray-tracing.md) or [32 compilation](./32-pipeline-compilation-study.md).

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Consolidate the advanced renderer into a reproducible, documented project that you can extend and defend technically.

## 2. Prerequisites and starting checkpoint

Lessons 01–29 reviewed, with any intentional omissions or alternative implementations recorded. Optional lessons 31–32 are not required.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

Advanced graphics work includes knowing when to disable a technique. Every approximation has inputs, quality limits, and cost. A mature result is a coherent set of choices with evidence, not the maximum number of effects enabled.

Review the full frame dependency graph, memory lifetimes, color path, visibility paths, and temporal state. A clean checkout and reproducible camera presets make the project reviewable by someone who was not present during its creation.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 30.1.** Write the frame architecture: passes, formats, coordinate spaces, materials, argument-table bindings, residency/retention, allocator ownership, event completion, and GPU barriers. Explain each technique and identify actual MTL4 queue/encoder/compiler use rather than only a Metal 4 label.

2. **Task 30.2.** Define low, medium, and high quality settings using measured costs. Ensure the lower settings preserve correct lighting and visibility rather than accidentally omitting dependencies.

3. **Task 30.3.** Run a regression tour: day/dusk, fixed and moving camera, wind/particles, empty/full visible lists, resize, minimize/restore, camera cut, and repeated settings changes. Inspect relevant validation output.

4. **Task 30.4.** Profile representative presets after warm-up at a recorded pixel resolution. Report CPU/GPU timing when available, memory, and known bottlenecks. Fix only issues supported by the evidence.

5. **Task 30.5.** Test building from a clean checkout on your Mac into a separate directory. Verify asset paths, build instructions, controls, and required tool versions. Exclude generated caches and document asset licenses.

6. **Task 30.6.** Prepare a short showcase video and an annotated explanation of one frame. Ask the tutor for a capstone review, then choose one small unprescribed variation to implement independently, such as a new material or a new scene arrangement.

## 5. Predict-and-observe experiments

Remove one effect you thought was essential and explain whether its measured benefit justifies the cost. Reproduce an earlier screenshot from saved settings. Explain the full path of one pixel and one tree instance from data to display.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

A polished video can conceal a broken clean build. Quality presets can leave stale history or mismatched targets. Optimizations can change reference behavior subtly. Do not label every remaining artistic limitation a correctness bug.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] A clean checkout builds and reproduces documented presets on the recorded environment.
- [ ] Architecture, quality/cost tradeoffs, and known limitations are clearly documented.
- [ ] The learner completes one small independent extension and explains the reasoning.
- [ ] All blocking capstone findings are resolved or explicitly scoped before calling the project finished.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Review a representative subset deeply: lifetime/synchronization, color path, visibility correctness, temporal history, and reproducibility. Distinguish learning accomplishments from claims of production readiness. Use the review template and request missing runtime evidence.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- Which technique would you remove first on a slower device, and why?
- Which new feature can you now design without asking for a finished implementation?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 30: ship an explainable advanced diorama`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R14](../REFERENCE.md#r14) · [R18](../REFERENCE.md#r18) · [R11](../REFERENCE.md#r11) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. This completes the main course. Specialist electives are independent branches from this checkpoint, not graduation requirements.
