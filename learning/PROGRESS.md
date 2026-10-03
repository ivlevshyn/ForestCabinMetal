# Progress and handoff

## Learner and environment

- Swift experience: learning Swift syntax alongside Metal; explain unfamiliar syntax.
- Graphics experience at course start: none.
- Project: interactive forest cabin diorama.
- Teaching preference (updated 2026-10-03): thorough, easy-to-understand theory without skipped prerequisites; explained Swift/MSL code snippets with exact file/function placement; the whole lesson in one substantial message when practical. Put independent practice, questions, and commit/review directions only at the end of the whole lesson. Experiments and extra variations are optional, require no report, and cannot block completion. The learner applies and runs the code; hints-first and task-by-task chat gates are not the default.
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

- Current lesson: 02.
- Current task: 02.1–02.5 complete; paused after final review.
- Last reviewed code SHA: 826145a5387295f40dd314be31b9356057ce07c1.
- Current code SHA: 826145a5387295f40dd314be31b9356057ce07c1 (this progress-only update does not change the reviewed implementation).
- Next action: wait for the learner to request lesson 03; do not begin it yet.
- Current blocker: none known.
- Runtime evidence location: learner reports in the teaching conversation; no screenshot or GPU capture committed.

## Review ledger

Update only the rows you work on. Status is one of Not started / In progress / Ready for review / Changes needed / Awaiting evidence / Complete / Skipped elective. A SHA belongs to the code that was actually reviewed, not a later progress-only commit.

| ID | Lesson | Status | Reviewed code SHA | Review date / evidence note |
| --- | --- | --- | --- | --- |
| 01 | Your first Metal 4 frame | Complete | ecaa90797bcfbb48951a23217d1b189298e73ff5 | 2026-10-03: source reviewed; learner reported colored output, color variation, resize/minimize/restore, skipped submission, and successful restoration. Reviewer did not execute Metal. |
| 02 | A triangle and the graphics pipeline | Complete | 826145a5387295f40dd314be31b9356057ce07c1 | 2026-10-03: source and baseline diff reviewed; learner reported expected lesson behavior and confirmed the requested Xcode GPU-debug capture checks. Understanding answers reviewed with clarifications. Reviewer did not execute Metal. |
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

- Lesson 02: vertex shaders supply corner positions and colors; rasterization determines coverage and interpolates values; fragment shaders calculate output colors. W = 1 leaves coordinates unchanged during perspective division. Reinforce that pipeline creation belongs in preparation to reuse compiled state and avoid per-frame compilation, rather than merely because the state must exist before drawing.

## Decisions and adaptations

| Date | Decision | Reason / affected lessons |
| --- | --- | --- |
| Edition 2 | Metal 4 from lesson 01 through the entire course | Explicit learner preference; replaces edition 1 |
| 2026-10-03 | Larger related coding steps with explained snippets | Earlier preference, refined by the whole-lesson delivery decision below. |
| 2026-10-03 | Thorough theory, placed code snippets, and whole-lesson delivery | Teach in one coherent message where practical; reserve practice, questions, and commit/review for the end. Supersedes one-task-per-message and hints-first defaults. |

## Latest session handoff

Lesson 02 is Complete at code commit 826145a5387295f40dd314be31b9356057ce07c1, reviewed against baseline 390f37ddc7333d352a83aab678b41e63f5019540. Review inspected Renderer.swift, Shaders.metal, MetalView.swift, and the implementation diff. No required source fixes were found.

The app creates solid-color and interpolated-color pipeline states during preparation using MTL4Compiler and library-function descriptors. Their attachment format and sample count match the view. The existing render pass binds the selected pipeline, disables culling, and draws three vertices selected by vertex_id in the shader. Vertex outputs use homogeneous clip positions with W = 1; the gradient fragment function receives interpolated corner colors. Lesson 01's completion gate, allocator reuse, residency setup, and drawable retention remain intact.

The learner reported that the lesson works as expected and subsequently confirmed the requested Xcode GPU-debug checks for the triangle pass, three-vertex draw, selected shader functions, and render-target output. The verdict moved from Awaiting evidence to Complete after that confirmation. Runtime and capture observations are learner-provided; the reviewer did not build or execute the macOS Metal app, and no screenshot or GPU trace was committed.

Understanding answers covered per-vertex versus per-fragment work and normalized positioning. The tutor clarified rasterization versus fragment shading, division by W = 1, and pipeline reuse outside the frame loop. Reinforce these distinctions naturally in future lessons.

Lesson 01 remains Complete at ecaa90797bcfbb48951a23217d1b189298e73ff5; its earlier review record is preserved.

Pause here as explicitly requested. Lesson 03 remains Not started. Resume only when requested, reading its lesson and inspecting the current code before presenting the complete lesson with theory and placed snippets.

## Performance baseline

Record at lesson 20 and update for major advanced milestones: chip/OS/Xcode, build mode, validation state, drawable pixel resolution, scene seed, camera, active effects, timing method, CPU/GPU results if available, and known limitations. No target or performance claim has been established yet.
