# 30 — Ship an explainable advanced diorama

**Track:** Advanced · **Implementation effort hint:** 4–7 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Previous: 29](./29-temporal-antialiasing.md) · Main course complete. Optional: [31 ray tracing](./31-hybrid-ray-tracing.md) or [32 compilation](./32-pipeline-compilation-study.md).

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Consolidate the advanced renderer into a reproducible, documented project that you can extend and defend technically.

## 2. Prerequisites and starting checkpoint

Lessons 01–29 reviewed, with any intentional omissions or alternative implementations recorded. Optional lessons 31–32 are not required.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

Advanced graphics work includes knowing when to disable a technique. Every approximation has inputs, quality limits, and cost. A mature result is a coherent set of choices with evidence, not the maximum number of effects enabled.

Review the full frame dependency graph, memory lifetimes, color path, visibility paths, and temporal state. A clean checkout and reproducible camera presets make the project reviewable by someone who was not present during its creation.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 30.1.** Write the frame architecture: passes, formats, coordinate spaces, materials, argument-table bindings, residency/retention, allocator ownership, event completion, and GPU barriers. Explain each technique and identify actual MTL4 queue/encoder/compiler use rather than only a Metal 4 label.

2. **Task 30.2.** Define low, medium, and high quality settings using measured costs. Ensure the lower settings preserve correct lighting and visibility rather than accidentally omitting dependencies.

3. **Task 30.3.** Run a regression tour: day/dusk, fixed and moving camera, wind/particles, empty/full visible lists, resize, minimize/restore, camera cut, and repeated settings changes. Inspect relevant validation output.

4. **Task 30.4.** Profile representative presets after warm-up at a recorded pixel resolution. Report CPU/GPU timing when available, memory, and known bottlenecks. Fix only issues supported by the evidence.

5. **Task 30.5.** Test building from a clean checkout on your Mac into a separate directory. Verify asset paths, build instructions, controls, and required tool versions. Exclude generated caches and document asset licenses.

6. **Task 30.6.** Prepare a short showcase video and an annotated explanation of one frame. Ask the tutor for a capstone review, optionally choose a small extra variation if you want further practice, such as a new material or scene arrangement.

## 5. Common mistakes and investigation

A polished video can conceal a broken clean build. Quality presets can leave stale history or mismatched targets. Optimizations can change reference behavior subtly. Do not label every remaining artistic limitation a correctness bug.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R14](../REFERENCE.md#r14) · [R18](../REFERENCE.md#r18) · [R11](../REFERENCE.md#r11) · [R26](../REFERENCE.md#r26)

Read only what resolves the current question. This completes the main course. Specialist electives are independent branches from this checkpoint, not graduation requirements.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Remove one effect you thought was essential and explain whether its measured benefit justifies the cost. Reproduce an earlier screenshot from saved settings. Explain the full path of one pixel and one tree instance from data to display.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] A clean checkout builds and reproduces documented presets on the recorded environment.
- [ ] Architecture, quality/cost tradeoffs, and known limitations are clearly documented.
- [ ] The learner explains the completed implementation and its design tradeoffs; an extra extension is optional.
- [ ] All blocking capstone findings are resolved or explicitly scoped before calling the project finished.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- Which technique would you remove first on a slower device, and why?
- Which new feature can you now design without asking for a finished implementation?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Review a representative subset deeply: lifetime/synchronization, color path, visibility correctness, temporal history, and reproducibility. Distinguish learning accomplishments from claims of production readiness. Use the review template and request missing runtime evidence.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 30: ship an explainable advanced diorama`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
