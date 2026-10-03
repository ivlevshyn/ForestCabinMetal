# Progress and handoff

## Learner and environment

- Swift experience: learning Swift syntax alongside Metal; explain unfamiliar syntax.
- Graphics experience at course start: none.
- Project: interactive forest cabin diorama.
- Teaching preference: learner implements the app; explain APIs and Swift syntax with code snippets. Use larger, coherent coding steps with focused understanding checks.
- Mac chip: Apple M5 Max (learner-reported).
- RAM: 48 GB (learner-reported).
- macOS version: 27.0.1 (learner-reported).
- Xcode / SDK version: Xcode 27 / macOS SDK 27 (learner-reported).
- Deployment target: project configured for macOS 27.0; course baseline remains macOS 26+.
- Metal 4 support check: runtime diagnostic reported Apple M5 Max and supportsFamily(.metal4) == true.
- Repository URL / branch: https://github.com/ivlevshyn/ForestCabinMetal / main.
- App host choice: SwiftUI with MTKView embedded through NSViewRepresentable; Renderer retained as coordinator.
- Math comfort: vectors and matrices familiar from Math and Calculus lectures; no prior graphics application.

## Current position

- Current lesson: 01.
- Current task: 01.1–01.6 complete; paused after final review.
- Last reviewed code SHA: ecaa90797bcfbb48951a23217d1b189298e73ff5.
- Current code SHA: ecaa90797bcfbb48951a23217d1b189298e73ff5 (this progress-only update does not change the reviewed implementation).
- Next action: wait for the learner to request lesson 02; do not begin it yet.
- Current blocker: none known.
- Runtime evidence location: learner reports in the teaching conversation; no screenshot or GPU capture committed.

## Review ledger

Update only the rows you work on. Status is one of Not started / In progress / Ready for review / Changes needed / Awaiting evidence / Complete / Skipped elective. A SHA belongs to the code that was actually reviewed, not a later progress-only commit.

| ID | Lesson | Status | Reviewed code SHA | Review date / evidence note |
| --- | --- | --- | --- | --- |
| 01 | Your first Metal 4 frame | Complete | ecaa90797bcfbb48951a23217d1b189298e73ff5 | 2026-10-03: source reviewed; learner reported colored output, color variation, resize/minimize/restore, skipped submission, and successful restoration. Reviewer did not execute Metal. |
| 02 | A triangle and the graphics pipeline | Not started | — | — |
| 03 | Send geometry from Swift to the GPU | Not started | — | — |
| 04 | Move geometry with transforms and time | Not started | — | — |
| 05 | Enter 3D with perspective and depth | Not started | — | — |
| 06 | Explore the cabin with an orbit camera | Not started | — | — |
| 07 | Build the cabin from reusable meshes | Not started | — | — |
| 08 | Give surfaces shape with sunlight | Not started | — | — |
| 09 | Put wood, bark, and ground on surfaces | Not started | — | — |
| 10 | Organize materials without building an engine | Not started | — | — |
| 11 | Generate a small forest clearing | Not started | — | — |
| 12 | Draw a forest efficiently with instancing | Not started | — | — |
| 13 | Render shadows from the sun | Not started | — | — |
| 14 | Give the clearing a sky and atmosphere | Not started | — | — |
| 15 | Make lighting linear and add HDR rendering | Not started | — | — |
| 16 | Give wood, stone, and metal distinct responses | Not started | — | — |
| 17 | Light the cabin at dusk | Not started | — | — |
| 18 | Animate foliage and preserve its silhouette | Not started | — | — |
| 19 | Build a controlled bloom effect | Not started | — | — |
| 20 | Finish and explain the core diorama | Not started | — | — |
| 21 | Simulate fireflies on the GPU | Not started | — | — |
| 22 | Manage frames in flight deliberately | Not started | — | — |
| 23 | Skip invisible trees and simplify distant ones | Not started | — | — |
| 24 | Let the GPU choose visible instances | Not started | — | — |
| 25 | Add surface detail with tangent-space normals | Not started | — | — |
| 26 | Light materials with the surrounding sky | Not started | — | — |
| 27 | Add contact depth with screen-space occlusion | Not started | — | — |
| 28 | Trace sunlight through forest mist | Not started | — | — |
| 29 | Use previous frames without smearing motion | Not started | — | — |
| 30 | Ship an explainable advanced diorama | Not started | — | — |
| 31 | Elective: add one ray-traced effect | Not started | — | — |
| 32 | Elective: control Metal 4 pipeline compilation | Not started | — | — |

## Concepts to reinforce

- Lesson 01: ownership versus GPU completion clarified. Retaining the drawable keeps its texture alive while GPU work uses it; completion gates release and allocator reset. Learner correctly chose to retain the reference while completion is pending.
- Recording, submission, and presentation were distinguished: the encoder records into the buffer, queue commit submits for GPU execution, and drawable presentation requests display. Reinforce these distinctions naturally in future practice.

## Decisions and adaptations

| Date | Decision | Reason / affected lessons |
| --- | --- | --- |
| Edition 2 | Metal 4 from lesson 01 through the entire course | Explicit learner preference; replaces edition 1 |
| 2026-10-03 | Larger related coding steps with explained snippets | Learner requested more coding per step and explicit Swift/Metal examples. Preserve teacher-first practice and learner implementation. |

## Latest session handoff

Lesson 01 is Complete at code commit ecaa90797bcfbb48951a23217d1b189298e73ff5. Final review inspected Renderer.swift, MetalView.swift, and the lifetime-fix diff against 5d297b5e4499e18ea79920ef2581a420e4f944ef. No blocking source findings remained.

The app records a clear-only Metal 4 pass, attaches view/layer residency sets to one queue, retains the submitted drawable, presents it using queue drawable coordination, and signals an increasing shared-event value. The one-slot completion gate precedes drawable release and allocator reset; skipped callbacks do not create pending submissions. GPU feedback errors are printed.

The learner reported expected colored output, successful resize/minimize/restore, a clear-color change, an experiment recording without submission, and normal rendering after restoring submission. These are learner-provided runtime observations, not reviewer-executed verification. No timing or validation-enabled capture was supplied.

Pause here as requested. Lesson 02 remains Not started. Resume only when requested, reading its lesson and inspecting the current code before assigning the next task.

## Performance baseline

Record at lesson 20 and update for major advanced milestones: chip/OS/Xcode, build mode, validation state, drawable pixel resolution, scene seed, camera, active effects, timing method, CPU/GPU results if available, and known limitations. No target or performance claim has been established yet.
