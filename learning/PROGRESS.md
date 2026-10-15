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

- Current lesson: 05.
- Current task: 05.1–05.5 Complete; paused after fixes, review, and learner confirmation.
- Last reviewed code SHA: 615e277068c1e07e9ca8257006b2eff0f3cd1a0d.
- Current code SHA: 615e277068c1e07e9ca8257006b2eff0f3cd1a0d (this progress-only update does not change the reviewed implementation).
- Next action: wait for the learner to request lesson 06; do not begin it yet.
- Current blocker: none known.
- Evidence location: lesson 05 teaching/review conversation, ending 2026-10-16 (Europe/Warsaw). The learner answered the follow-up questions and reported "Done. You can update progress" after the final correction and request to confirm behavior. This is a general learner completion confirmation, not a detailed runtime checklist or GPU capture report. Reviewer did not build or run the submitted app.

## Review ledger

Update only the rows you work on. Status is one of Not started / In progress / Ready for review / Changes needed / Awaiting evidence / Complete / Skipped elective. A SHA belongs to the code that was actually reviewed, not a later progress-only commit.

| ID | Lesson | Status | Reviewed code SHA | Review date / evidence note |
| --- | --- | --- | --- | --- |
| 01 | Your first Metal 4 frame | Complete | ecaa90797bcfbb48951a23217d1b189298e73ff5 | 2026-10-03: source reviewed; learner reported colored output, color variation, resize/minimize/restore, skipped submission, and successful restoration. Reviewer did not execute Metal. |
| 02 | A triangle and the graphics pipeline | Complete | 826145a5387295f40dd314be31b9356057ce07c1 | 2026-10-03: source and baseline diff reviewed; learner reported expected lesson behavior and confirmed the requested Xcode GPU-debug capture checks. Understanding answers reviewed with clarifications. Reviewer did not execute Metal. |
| 03 | Send geometry from Swift to the GPU | Complete | 526aca74fe3435aeac09cbae61aabea0640f4941 | 2026-10-04: source and baseline diff reviewed; learner confirmed both colored panels, resize/minimize/restore without validation errors, expected layout/count logs, and GPU capture checks for twelve UInt16 indices and vertex-stage buffer slot 0. Understanding answers reviewed with clarifications. Reviewer did not execute Metal. |
| 04 | Move geometry with transforms and time | Complete | 030525fc7c06f6b2a5e24363f13cba59a1c53fb5 | 2026-10-12: source and baseline diff reviewed; no blocking source issues found. Learner reported everything works as expected. Mesh-preservation answer discussed; tutor explained the other answers. Marked Complete at the learner's explicit request without a further understanding answer. Reviewer did not build or execute Metal. |
| 05 | Enter 3D with perspective and depth | Complete | 615e277068c1e07e9ca8257006b2eff0f3cd1a0d | 2026-10-16: source and baseline diff reviewed; bottom-face error corrected and re-reviewed, projection assertion restored, view sizing corrected. Learner correctly identified the model matrix and rejection under the less-depth rule after explanations, then confirmed completion and authorized this update. No detailed runtime/capture report supplied; reviewer did not build or execute the submitted app. |
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

- Lesson 03: reinforce that creating a buffer allocates storage while retaining it keeps the object and allocation alive; residency enables GPU access and argument-table binding connects the address to a shader slot. Indexing saves memory when full-record reuse outweighs index storage. Stride includes array spacing required by alignment/padding. A shared position may need separate records when normals or UV coordinates differ.

- Lesson 04: learner identified preserving an initial state as a reason to keep mesh positions unchanged. Tutor expanded this to separating shape from placement and reusing one mesh for multiple objects. Tutor explained rightmost-first T × R × S order, the worked point result (0.3, 1.2, 0, 1), points with W = 1 versus directions with W = 0, and binding snapshots versus buffer contents. These tutor explanations must not be recorded as learner-provided answers. The learner explicitly requested completion without a further understanding answer. Reinforce these concepts naturally in later lessons; no outstanding answer blocks completion.

- Lesson 05: learner initially could not explain the matrix roles, associated W with projection imperfection/GPU efficiency, described depth testing as culling, and gave near/far input distances rather than normalized depth endpoints. Tutor explained model/view/projection roles, W = -view-space Z and perspective division, stored nearest depth versus back-face culling, camera movement versus FOV, and near/far mapping to 0/1. Learner's FOV answer correctly recognized that both changes can enlarge the object; the relative-distance distinction was supplied by the tutor. In follow-up, learner correctly chose the model matrix for moving only the box and said an incoming depth 0.7 is rejected under .less when 0.4 is stored; tutor made the comparison explicit. Reinforce the other concepts naturally in later lessons without attributing tutor explanations to the learner. No additional answer currently blocks completion.

## Decisions and adaptations

| Date | Decision | Reason / affected lessons |
| --- | --- | --- |
| Edition 2 | Metal 4 from lesson 01 through the entire course | Explicit learner preference; replaces edition 1 |
| 2026-10-03 | Larger related coding steps with explained snippets | Earlier preference, refined by the whole-lesson delivery decision below. |
| 2026-10-03 | Thorough theory, placed code snippets, and whole-lesson delivery | Teach in one coherent message where practical; reserve practice, questions, and commit/review for the end. Supersedes one-task-per-message and hints-first defaults. |
| 2026-10-12 | Close lesson 04 without another understanding answer | Explicit learner instruction; lesson 04 is Complete after source review and learner-reported working behavior. Tutor explanations remain distinguished from learner answers. |
| 2026-10-13 | Extract GPUData, TransformMath, MeshGeometry, and SceneResources during lesson 05 | Learner raised Renderer.swift's growing responsibilities; retain frame orchestration and animation in Renderer for now. |
| 2026-10-13 | Adapt lesson 05's pipeline-depth-format instruction to the actual Metal 4 API | The inspected SDK's MTL4RenderPipelineDescriptor has no depthAttachmentPixelFormat. Configure MTKView depth texture, render-pass actions, and MTLDepthStencilState; retain matching color format and sample count. |
| 2026-10-16 | Close lesson 05 after final source fix, follow-up answers, and learner confirmation | Learner reported completion and authorized the progress update. Preserve the limits of runtime evidence; no GPU execution or capture verification by the reviewer is implied. |

## Latest session handoff

Lesson 05, tasks 05.1–05.5, is Complete at code commit 615e277068c1e07e9ca8257006b2eff0f3cd1a0d, reviewed against baseline 9c0ad8b6e96f2cefbc65abaf4e3baeb8f7c44ea5. Initial review inspected the source and baseline diff at 3b8c2bcabd08db174873ca4e8fa066b1df2a5147; follow-up reviews inspected changes at 1d2c667b0f07a28b264c21860a5cb13bc3a71291 and 615e277068c1e07e9ca8257006b2eff0f3cd1a0d. Files inspected: Renderer.swift, TransformMath.swift, GPUData.swift, MeshGeometry.swift, SceneResources.swift, Shaders.metal, MetalView.swift, ContentView.swift, and ForestCabinMetalApp.swift. No blocking source findings remain.

The implementation uses a face-colored indexed box (24 vertices, 36 UInt16 indices) and a ground quad (4 vertices, 6 indices). Swift and MSL uniforms agree on model, view, and projection matrices with 192-byte stride and offsets 0, 64, and 128. The shader outputs projection × view × model × position without manually dividing W. Perspective uses vertical FOV pi/3, near 0.1, far 30, and aspect from the acquired drawable's pixel dimensions. Active assertions check near/far depth endpoints and perspective size scaling. A fixed view transform reverses a camera at (0, 2.5, 6) tilted downward; the rotating 1.5-unit box is centered at Y = 0.75 on the ground.

MTKView creates a private depth32Float attachment with one sample. Each pass clears depth to 1, stores it for inspection, and binds .less comparison with depth writes enabled. Counterclockwise front faces and back-face culling agree with the corrected geometry. SceneResources retains six resident buffer allocations, with distinct per-object uniforms; vertex-stage argument slots 0 and 1 are selected per draw. The existing single-frame completion gate protects uniform writes and allocator reset. Drawable and depth texture references remain retained through GPU completion. Pause/resume/reset and scene-inactivity handling remain in place. ContentView now uses minimum dimensions 320 × 240 rather than capping the drawing area.

Review corrections: the bottom-face block initially duplicated the front face; the first repair still repeated one corner, producing a degenerate triangle. Final commit 615e277068c1e07e9ca8257006b2eff0f3cd1a0d corrects that corner, yielding four distinct bottom vertices and two outward-facing triangles. The incorrect commented perspective-size assertion was replaced with the correct division by distant.w. The view's maxWidth/maxHeight were changed to minWidth/minHeight. All application corrections were made by the learner; the tutor only updates this progress file.

Evidence and understanding: on 2026-10-16 the learner correctly answered the two focused follow-up questions described above. After the final correction and request to confirm rendering, resize, and pause/reset behavior, the learner replied "Done. You can update progress". This was accepted as general completion confirmation and authorization to record Complete. No separate detailed runtime checklist, screenshot, validation log, or color/depth capture observations were supplied. The reviewer inspected the submitted source and diffs but did not build or execute those commits or inspect a GPU capture. During lesson preparation on 2026-10-13, proposed support/renderer Swift was type-checked and CPU layout/projection/rotation/winding checks were run on a scratch teaching implementation; that does not constitute execution of the learner's later submitted app.

Next action: wait for the learner to request lesson 06 (orbit camera). Lesson 06 remains Not started; do not begin it automatically.

## Previous lesson 04 handoff

The historical wait before lesson 05 below was superseded by the learner's request to start lesson 05 on 2026-10-13 and the completed review recorded above.

Lesson 04, tasks 04.1–04.5, is Complete at code commit 030525fc7c06f6b2a5e24363f13cba59a1c53fb5, reviewed against baseline 65b4c01073325d715a5c53f1b11957722e26b92b. Review inspected Renderer.swift, Shaders.metal, MetalView.swift, ContentView.swift, and their baseline diff. No blocking source issues were found. No application files were changed by the tutor.

The implementation stores one centered panel with four vertices and six UInt16 indices, then draws it twice with independent model matrices. Matrix constructors use columns and model = translation × rotation × scale. Swift GPUUniforms and MSL GPUUniforms agree on one float4x4; preparation checks size/stride 64, alignment 16, and model offset 0. Two separate shared uniform buffers are retained, registered in the committed app residency set, and exposed through vertex-stage argument-table slot 1. Mesh vertices remain at slot 0. Uniform writes and allocator reset occur after the existing single-frame completion gate. Both indexed draws reuse the same mesh while selecting distinct uniform addresses. Existing Metal 4 submission, drawable retention, view/layer residency, and event signaling remain intact.

Animation uses measured time in seconds, with a gentle sinusoidal Z rotation. Pause/resume and reset flow from ContentView through MetalView to the retained renderer. Scene inactivity clears the timestamp, and intervals greater than 0.25 seconds are discarded to avoid a suspension jump. The view requests 60 FPS. Both panels use scale (0.58, 0.70, 1), a valid adaptation from the teaching example. ContentView caps the Metal view at 640 × 480 rather than setting a minimum; this is not a lesson 04 blocker.

On 2026-10-12, the learner reported that everything works as expected. This is learner-provided runtime evidence, not reviewer execution. The reviewer did not build or execute the macOS Metal app, run its assertions, or personally inspect an Xcode GPU capture. The general report does not establish separate capture observations, measured refresh-rate comparisons, or validation logs.

The learner answered the mesh-preservation question by identifying the need for an initial state to return to, then requested explanations of the other questions. The tutor supplied those explanations. The learner then explicitly requested that lesson 04 be marked Complete without another understanding answer. On 2026-10-12, the status was updated accordingly, based on the source review with no blockers, the learner's reported working behavior, and their instruction to close the lesson. No additional learner answer or reviewer runtime verification is implied. No code correction is currently required. Next action: wait for the learner to request lesson 05. Lesson 05 remains Not started and must not begin automatically.

## Previous lesson 03 handoff

Lesson 03 is Complete at code commit 526aca74fe3435aeac09cbae61aabea0640f4941, reviewed against baseline 7c8ff82a00cd30375d0ed9c0c4bcbd8734853798. The reviewed head includes implementation commit 66641ac9b6c1b6885b15538b80b7bc1d2254236b and the subsequent merge. Review inspected Renderer.swift, Shaders.metal, MetalView.swift, and the implementation diff. No blocking source issues were found.

Swift creates eight position/color records and twelve UInt16 indices for two panels and four triangles. The CPU/MSL records agree on two float4 fields, offsets 0 and 16, alignment 16, and stride 32. Uploads use stride-based lengths and scoped source pointers. Vertex and index buffers are created during preparation, retained by renderer properties, added to an app residency set whose membership is committed, and made available through queue attachment. The vertex buffer address is bound at argument-table slot 0 for the vertex stage. The indexed draw supplies the index GPU address and valid byte length. Lesson 01's completion gate, allocator reuse, view/layer residency, and drawable retention remain intact.

On 2026-10-04, the learner confirmed both colored panels, resize/minimize/restore without validation errors, the expected layout and geometry logs (8 vertices, 256 vertex bytes, 12 indices, 24 index bytes), and GPU capture checks for twelve UInt16 indices and the vertex buffer at vertex-stage slot 0. The verdict moved from Awaiting evidence to Complete after this confirmation. Runtime and capture observations are learner-provided; the reviewer did not build or execute the macOS Metal app, and no screenshot or GPU trace was committed.

Understanding answers covered reuse through indices, array spacing, the distinct resource responsibilities, and the eight-vertex/twelve-index/four-triangle count. The tutor clarified allocation versus retention, the index-storage tradeoff, and separate records for differing UVs or normals. Reinforce these distinctions naturally rather than repeating the lesson.

The historical pause before lesson 04 was superseded by the learner's request to begin it on 2026-10-06. See the latest lesson 04 handoff above.

## Previous lesson 02 handoff

Lesson 02 is Complete at code commit 826145a5387295f40dd314be31b9356057ce07c1, reviewed against baseline 390f37ddc7333d352a83aab678b41e63f5019540. Review inspected Renderer.swift, Shaders.metal, MetalView.swift, and the implementation diff. No required source fixes were found.

The app creates solid-color and interpolated-color pipeline states during preparation using MTL4Compiler and library-function descriptors. Their attachment format and sample count match the view. The existing render pass binds the selected pipeline, disables culling, and draws three vertices selected by vertex_id in the shader. Vertex outputs use homogeneous clip positions with W = 1; the gradient fragment function receives interpolated corner colors. Lesson 01's completion gate, allocator reuse, residency setup, and drawable retention remain intact.

The learner reported that the lesson works as expected and subsequently confirmed the requested Xcode GPU-debug checks for the triangle pass, three-vertex draw, selected shader functions, and render-target output. The verdict moved from Awaiting evidence to Complete after that confirmation. Runtime and capture observations are learner-provided; the reviewer did not build or execute the macOS Metal app, and no screenshot or GPU trace was committed.

Understanding answers covered per-vertex versus per-fragment work and normalized positioning. The tutor clarified rasterization versus fragment shading, division by W = 1, and pipeline reuse outside the frame loop. Reinforce these distinctions naturally in future lessons.

Lesson 01 remains Complete at ecaa90797bcfbb48951a23217d1b189298e73ff5; its earlier review record is preserved.

At the end of lesson 02, the learner requested a pause before lesson 03. That historical pause was superseded by the learner's request to begin lesson 03 on 2026-10-04; see the latest handoff above.

## Performance baseline

Record at lesson 20 and update for major advanced milestones: chip/OS/Xcode, build mode, validation state, drawable pixel resolution, scene seed, camera, active effects, timing method, CPU/GPU results if available, and known limitations. No target or performance claim has been established yet.
