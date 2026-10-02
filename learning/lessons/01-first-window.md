# 01 — Your first Metal 4 frame

**Track:** Core · **Planning hint:** 3–5 small sessions (flexible, not a deadline)

[Course entry](../README.md) · [Next: 02](./02-first-triangle.md)

> Tutor: first read [TEACHING](../TEACHING.md), [PROGRESS](../PROGRESS.md), and [PROJECT](../PROJECT.md), and [METAL4](../METAL4.md). Use Metal 4 throughout. Teach one task at a time. Explain mechanisms and give graduated hints; do not supply the completed feature. Review the learner's implementation at a specific commit.

## 1. Outcome and purpose

Create the macOS app that will eventually contain the forest cabin. The first visible result is a window filled with a color you selected, rendered through Metal. You can explain how a request made by Swift becomes GPU work and reaches the screen.

## 2. Prerequisites and starting checkpoint

No graphics prerequisites. Confirm an Apple silicon GPU with Metal 4 support, macOS 26+, and Xcode 26+ with a compatible SDK. The tutor checks actual availability before GPU work; no earlier Metal course is required.

Inspect the actual relevant files and previous review status. If the prerequisite behavior is broken, repair that gap before layering on this lesson. Do not assume a commit title proves completion.

## 3. Concepts to teach before practice

Swift prepares commands and the GPU runs them later. In Metal 4, the device creates a command queue and a reusable command buffer independently. A command allocator owns storage for encoded commands. The CPU ends encoding and submits the buffer through the queue. The buffer does not automatically retain all referenced resources.

A drawable is an image the display system lends to the app. The queue coordinates when the GPU may write it and when rendering is finished; presentation is a separate drawable operation. Residency makes allocations accessible to the GPU, while completion tracking tells the CPU when it may reuse data or reset an allocator. Introduce these ideas in small steps with one frame slot; do not dump a triple-buffered sample on a beginner.

## 4. Guided practice

These are staged instructions for a teaching conversation, not a request to implement everything at once. After each task, ask for the learner's code/observation, inspect it, and only then choose the next task. Split a task further if it introduces more than one unfamiliar mechanism.

1. **Task 01.1.** Record chip, macOS, Xcode/SDK, and the device support check for the Metal 4 family. Create a plain macOS Swift app. Choose a minimal SwiftUI/AppKit host. Inspect a Metal 4 Xcode template only as a reference; do not retain unexplained generated renderer code.

2. **Task 01.2.** Add MTKView and a retained renderer/delegate. Create MTL4CommandQueue, MTL4CommandBuffer, and MTL4CommandAllocator through the device. Label them and explain what each owns. Verify draw callbacks before encoding commands.

3. **Task 01.3.** Use one frame slot with a completion value. Initially there is no submitted work. After each actual submission, signal a new increasing value on MTLSharedEvent. Before resetting the allocator or reusing mutable data, check that the last submitted value completed; if busy, skip this callback and try on a later callback instead of spinning or blocking the UI.

4. **Task 01.4.** Obtain a nonzero-size drawable and pass descriptor. Explain the view/layer residency set and attach it appropriately to the Metal 4 queue; add separate residency for app-owned attachments if applicable. Retain referenced objects through completion. Begin the command buffer with its available allocator, encode a clear pass, end the encoder, then end the command buffer.

5. **Task 01.5.** Explain and implement queue waitForDrawable, queue commit of the ended command buffer, queue signalDrawable, and drawable present in the documented order. Schedule the completion event value after submitted work. Change the sky clear color and observe it. The tutor supplies signatures and sequencing, not the finished callback.

6. **Task 01.6.** Test resize and minimize/restore. An early return before submission must not create an event value that will never be signaled. If completion fails, report the error instead of recycling resources unsafely. Initialize Git if needed and commit the course plus your own app.

## 5. Predict-and-observe experiments

Predict what changes when you alter clearColor. Then deliberately skip submission for one run and explain the result before restoring it. Identify which objects should be created once and which belong to a frame.

For each experiment, record the prediction, actual result, and one explanation. Keep diagnostic changes easy to undo. The tutor should teach missing concepts before asking for predictions.

## 6. Common mistakes and investigation

A missing drawable can be normal. Resetting an allocator immediately after submission can corrupt in-flight commands. The command buffer does not provide the older commit/present/waitUntilCompleted workflow. Residency is not a completion signal. A SwiftUI wrapper recreating the renderer can make lifecycle problems look like GPU bugs.

Use [the debugging field guide](../DEBUGGING.md) to isolate one hypothesis. When stuck, ask for a hint about the responsible stage before requesting a finished solution.

## 7. Acceptance criteria

- [ ] The clear frame uses a real Metal 4 queue, command buffer, allocator, and render encoder.
- [ ] Drawable coordination, resource ownership/residency, and single-slot completion gating are explained and work through resize.
- [ ] The app does not recycle in-flight storage or stall the main thread in an unbounded wait.
- [ ] Existing required behavior still works, or a deliberate replacement is explained.
- [ ] I can explain the mechanism and complete a small related variation without copying a solution.

## 8. Evidence to submit

- Exact lesson ID, task range, code commit SHA, and baseline SHA if available.
- Relevant source changes and any surrounding configuration needed to understand them.
- The runtime evidence named in this lesson: images, a short clip for motion, capture observations, or measurements as appropriate. Do not produce every kind of evidence when one is sufficient.
- A brief explanation of one experiment, one issue you diagnosed, and any remaining limitation.

The tutor must identify learner-reported runtime evidence separately from verification they personally performed. If code access is unavailable, attach the relevant files rather than relying on the repository URL.

## 9. Review rubric

Inspect the Metal 4 types, begin/end/queue-submission sequence, drawable coordination, residency, and event-value ownership. Verify that skipped callbacks cannot strand the frame slot and that no submitted resource is released early. Ask for a run and resize observation.

Use [the review template](../templates/REVIEW.md). Report **Complete**, **Changes needed**, or **Awaiting evidence**. Separate required fixes from optional improvements, and describe a focused repair exercise instead of rewriting the implementation.

## 10. Explain it back

- What memory does the allocator own, and when may it be reset?
- How do residency, GPU completion, and drawable presentation solve different problems?

Do not require exact textbook wording. Ask for an example, sketch, or tiny change when it demonstrates understanding better than prose.

## 11. Git checkpoint and handoff

Commit your own work when you are ready for review; suggested title: `lesson 01: your first metal 4 frame`. Intermediate commits are encouraged. Push using your normal Git workflow and provide the exact code SHA for review.

After review, update [PROGRESS](../PROGRESS.md) with the reviewed SHA, verdict, learning gaps, and next task. A metadata-only progress commit may follow the reviewed code commit; do not attempt to put a commit's own future SHA inside itself. Use [SESSION](../templates/SESSION.md) when pausing midway.

## 12. References and scope boundary

[R02](../REFERENCE.md#r02) · [R03](../REFERENCE.md#r03) · [R21](../REFERENCE.md#r21) · [R23](../REFERENCE.md#r23) · [R25](../REFERENCE.md#r25) · [R27](../REFERENCE.md#r27) · [R28](../REFERENCE.md#r28)

Read only what resolves the current question. One correctly gated frame slot is an intentional teaching simplification. Lesson 22 later enables several frames in flight. No shaders, argument tables, or camera are needed for the clear-only pass.
