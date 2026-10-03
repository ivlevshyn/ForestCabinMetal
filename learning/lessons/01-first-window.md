# 01 — Your first Metal 4 frame

**Track:** Core · **Implementation effort hint:** 3–5 small sessions (flexible, not a deadline); this is not a required number of teaching messages

[Course entry](../README.md) · [Next: 02](./02-first-triangle.md)

> Tutor: read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Present the complete lesson with thorough plain-language theory, explained code snippets, and exact file/function placement in one coherent message where practical. Internal task IDs organize the walkthrough, not separate chat turns. Put independent practice, questions, and commit/review directions only in the final section. Follow [the delivery template](../templates/LESSON-DELIVERY.md).

## 1. Outcome and purpose

Create the macOS app that will eventually contain the forest cabin. The first visible result is a window filled with a color you selected, rendered through Metal. You can explain how a request made by Swift becomes GPU work and reaches the screen.

## 2. Prerequisites and starting checkpoint

No graphics prerequisites. Confirm an Apple silicon GPU with Metal 4 support, macOS 26+, and Xcode 26+ with a compatible SDK. The tutor checks actual availability before GPU work; no earlier Metal course is required.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Theory to explain thoroughly

Swift prepares commands and the GPU runs them later. In Metal 4, the device creates a command queue and a reusable command buffer independently. A command allocator owns storage for encoded commands. The CPU ends encoding and submits the buffer through the queue. The buffer does not automatically retain all referenced resources.

A drawable is an image the display system lends to the app. The queue coordinates when the GPU may write it and when rendering is finished; presentation is a separate drawable operation. Residency makes allocations accessible to the GPU, while completion tracking tells the CPU when it may reuse data or reset an allocator. Introduce these ideas in small steps with one frame slot; do not dump a triple-buffered sample on a beginner.

Tutor: expand every required concept above into a full, accessible explanation: meaning, purpose, mechanism, connection to existing code, and a worked example or boundary case. Explain unfamiliar Swift/MSL syntax and mathematical variables. These paragraphs are a coverage outline, not the entire theory lesson. Demonstrate predictions yourself here; ask the learner questions only in the final section.

## 4. Explained implementation walkthrough

Present the following task IDs as connected sections of the same complete teaching message. For each change, explain the theory and show clear Swift/MSL snippets, naming the actual file, type/function, add/replace action, insertion anchor, and dependencies. Explain the important lines and expected behavior. Do not stop for answers, code submissions, or a commit between sections. Wording below such as “predict,” “ask,” or “test” is a coverage cue: demonstrate it as a worked example here, or include a required implementation check in the final section. Exploratory changes and extra variations are optional, even when an older task description uses imperative wording.

1. **Task 01.1.** Record chip, macOS, Xcode/SDK, and the device support check for the Metal 4 family. Create a plain macOS Swift app. Choose a minimal SwiftUI/AppKit host. Inspect a Metal 4 Xcode template only as a reference; do not retain unexplained generated renderer code.

2. **Task 01.2.** Add MTKView and a retained renderer/delegate. Create MTL4CommandQueue, MTL4CommandBuffer, and MTL4CommandAllocator through the device. Label them and explain what each owns. Verify draw callbacks before encoding commands.

3. **Task 01.3.** Use one frame slot with a completion value. Initially there is no submitted work. After each actual submission, signal a new increasing value on MTLSharedEvent. Before resetting the allocator or reusing mutable data, check that the last submitted value completed; if busy, skip this callback and try on a later callback instead of spinning or blocking the UI.

4. **Task 01.4.** Obtain a nonzero-size drawable and pass descriptor. Explain the view/layer residency set and attach it appropriately to the Metal 4 queue; add separate residency for app-owned attachments if applicable. Retain referenced objects through completion. Begin the command buffer with its available allocator, encode a clear pass, end the encoder, then end the command buffer.

5. **Task 01.5.** Explain and implement queue waitForDrawable, queue commit of the ended command buffer, queue signalDrawable, and drawable present in the documented order. Schedule the completion event value after submitted work. Change the sky clear color and observe it. The tutor supplies explained callback snippets, exact placement, and the reasoning behind their sequence.

6. **Task 01.6.** Test resize and minimize/restore. An early return before submission must not create an event value that will never be signaled. If completion fails, report the error instead of recycling resources unsafely. Initialize Git if needed and commit the course plus your own app.

## 5. Common mistakes and investigation

A missing drawable can be normal. Resetting an allocator immediately after submission can corrupt in-flight commands. The command buffer does not provide the older commit/present/waitUntilCompleted workflow. Residency is not a completion signal. A SwiftUI wrapper recreating the renderer can make lifecycle problems look like GPU bugs.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, request an explanation and a focused corrected snippet with exact placement. Hints are available if you prefer them, but are not required before code.

## 6. References and scope boundary

[R02](../REFERENCE.md#r02) · [R03](../REFERENCE.md#r03) · [R21](../REFERENCE.md#r21) · [R23](../REFERENCE.md#r23) · [R25](../REFERENCE.md#r25) · [R27](../REFERENCE.md#r27) · [R28](../REFERENCE.md#r28)

Read only what resolves the current question. One correctly gated frame slot is an intentional teaching simplification. Lesson 22 later enables several frames in flight. No shaders, argument tables, or camera are needed for the clear-only pass.

## 7. Practice, questions, and submission — after the whole lesson

Present this consolidated section only after all of the lesson theory, code explanations, and expected behavior. The learner can then apply the walkthrough at their own pace. Do not require a reply or review between the earlier walkthrough sections.

### Optional exploration — not required for completion

The following ideas are optional. Skip them freely; no experiment report is required.

Predict what changes when you alter clearColor. Then deliberately skip submission for one run and explain the result before restoring it. Identify which objects should be created once and which belong to a frame.

Offer these ideas only after the full theory and implementation walkthrough. If the learner chooses to try them, keep temporary changes easy to undo. Do not include them in required evidence or completion criteria.

### Completion checklist

- [ ] The clear frame uses a real Metal 4 queue, command buffer, allocator, and render encoder.
- [ ] Drawable coordination, resource ownership/residency, and single-slot completion gating are explained and work through resize.
- [ ] The app does not recycle in-flight storage or stall the main thread in an unbounded wait.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism used in the lesson implementation.

### Understanding questions

- What memory does the allocator own, and when may it be reset?
- How do residency, GPU completion, and drawable presentation solve different problems?

Do not require exact textbook wording. Accept an explanation, example, or sketch; do not require an extra code change or experiment to demonstrate understanding.

### Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- Answers to the end-of-lesson understanding questions and any known remaining limitation. No experiment report or invented debugging issue is required.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

### Review after submission

Inspect the Metal 4 types, begin/end/queue-submission sequence, drawable coordination, residency, and event-value ownership. Verify that skipped callbacks cannot strand the frame slot and that no submitted resource is released early. Ask for a run and resize observation.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Skipped optional exploration cannot block completion. Separate required fixes from optional improvements, and explain focused corrections with code and placement when useful; the learner applies them.

### Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 01: your first metal 4 frame`. Intermediate personal commits are optional; the tutor gives these submission directions only after the whole lesson. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.
