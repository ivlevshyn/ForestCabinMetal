# Progress and handoff

## Learner and environment

- Swift experience: learning Swift syntax alongside Metal; explain unfamiliar syntax.
- Graphics experience at course start: none.
- Project: interactive forest cabin diorama.
- Teaching preference (updated 2026-10-16): teach lessons in manageable steps across messages, one coherent step per response by default, then pause for the learner to apply it or ask for help. Preserve thorough plain-language theory, worked examples, and explained Swift/MSL snippets with exact placement. Keep understanding questions at the end of the entire lesson; steps may include implementation/run checks. Give the consolidated checklist and commit/review directions after the final step. Experiments remain optional; hints-first is opt-in; no per-step quizzes or mandatory commits. Proactively inspect file responsibilities and teach small extractions before files become bloated, as Renderer.swift did before lesson 05. This replaces single-message delivery; the learner still applies and runs the code.
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

- Current lesson: 07.
- Current task: 07.1–07.5 Complete at the learner's explicit request after implementation, source review, and learner-reported working behavior. Two required source fixes remain documented in the latest handoff.
- Last reviewed code SHA: 17b26c23cc774bc8078defef358c81dee0f7df55.
- Current code SHA: 17b26c23cc774bc8078defef358c81dee0f7df55 (this progress-only update does not change the reviewed implementation).
- Next action: wait for the learner to request further work. Surface the two recorded source fixes before beginning lesson 08 (normals and sunlight); app edits were not authorized in this completion update.
- Current blocker: the box helper drops its color argument, and the residency list omits the roof mesh. The learner explicitly chose “Update progress only; record both issues” and requested lesson 07 be marked Complete with these issues outstanding.
- Evidence location: this lesson 07 teaching/completion conversation, 2026-10-25 (Europe/Warsaw). The learner reported that everything works as expected and requested a completion commit. The reviewer inspected the submitted source and baseline diff, type-checked the submitted Swift renderer-related files, and ran CPU geometry/layout/camera checks. No full-app build, Metal execution, screenshot inspection, or GPU-capture inspection was performed by the reviewer. No end-of-lesson understanding answers or screenshots were supplied.

## Review ledger

Update only the rows you work on. Status is one of Not started / In progress / Ready for review / Changes needed / Awaiting evidence / Complete / Skipped elective. A SHA belongs to the code that was actually reviewed, not a later progress-only commit.

| ID | Lesson | Status | Reviewed code SHA | Review date / evidence note |
| --- | --- | --- | --- | --- |
| 01 | Your first Metal 4 frame | Complete | ecaa90797bcfbb48951a23217d1b189298e73ff5 | 2026-10-03: source reviewed; learner reported colored output, color variation, resize/minimize/restore, skipped submission, and successful restoration. Reviewer did not execute Metal. |
| 02 | A triangle and the graphics pipeline | Complete | 826145a5387295f40dd314be31b9356057ce07c1 | 2026-10-03: source and baseline diff reviewed; learner reported expected lesson behavior and confirmed the requested Xcode GPU-debug capture checks. Understanding answers reviewed with clarifications. Reviewer did not execute Metal. |
| 03 | Send geometry from Swift to the GPU | Complete | 526aca74fe3435aeac09cbae61aabea0640f4941 | 2026-10-04: source and baseline diff reviewed; learner confirmed both colored panels, resize/minimize/restore without validation errors, expected layout/count logs, and GPU capture checks for twelve UInt16 indices and vertex-stage buffer slot 0. Understanding answers reviewed with clarifications. Reviewer did not execute Metal. |
| 04 | Move geometry with transforms and time | Complete | 030525fc7c06f6b2a5e24363f13cba59a1c53fb5 | 2026-10-12: source and baseline diff reviewed; no blocking source issues found. Learner reported everything works as expected. Mesh-preservation answer discussed; tutor explained the other answers. Marked Complete at the learner's explicit request without a further understanding answer. Reviewer did not build or execute Metal. |
| 05 | Enter 3D with perspective and depth | Complete | 615e277068c1e07e9ca8257006b2eff0f3cd1a0d | 2026-10-16: source and baseline diff reviewed; bottom-face error corrected and re-reviewed, projection assertion restored, view sizing corrected. Learner correctly identified the model matrix and rejection under the less-depth rule after explanations, then confirmed completion and authorized this update. No detailed runtime/capture report supplied; reviewer did not build or execute the submitted app. |
| 06 | Explore the cabin with an orbit camera | Complete | 4901d3ad56d1a24c4f24ac8741ae10bbfb938cea | 2026-10-18: source and baseline diff reviewed; no required source fixes. Submitted CPU assertions and additional numeric camera checks passed. Learner reported expected behavior. Understanding answers reviewed with clarifications; closed at the learner's explicit request without the two further answers. Reviewer did not build or execute the full app. |
| 07 | Build the cabin from reusable meshes | Complete | 17b26c23cc774bc8078defef358c81dee0f7df55 | 2026-10-25: source and baseline diff reviewed; submitted Swift type-check and CPU geometry/layout/camera checks passed. Learner reported expected behavior and explicitly requested completion. Two required fixes remain: forward box color and register roof residency. Learner chose progress-only recording; no app changes, screenshots, understanding answers, or reviewer Metal execution. |
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

- Lesson 06: learner correctly explained that the cross product is perpendicular to both inputs and reversing its order flips right to left. Learner also correctly predicted that the box would be behind the camera with reversed forward subtraction, but named the wrong viewing direction. Tutor clarified that target − eye points toward the target (−Z for eye (0, 0, 5) and target at the origin), whereas eye − target points away (+Z). Learner attributed the scene's opposite movement to direction reversal in OrbitCamera and attributed avoiding the pole to a precondition. Tutor explained camera-relative subtraction, the pitch clamp preventing pole alignment during normal input, and a precondition detecting invalid geometry and stopping execution rather than repairing it. The learner explicitly requested completion without answering the two subsequent understanding checks. Reinforce these distinctions naturally; do not attribute tutor explanations to learner answers or require the unanswered checks before continuing.

- Lesson 07: tutor explained shape versus placement versus appearance, sharing mesh buffers while keeping per-object uniforms independent, roof winding, panel offsets, and root × part transform composition. No end-of-lesson understanding answers were supplied; do not attribute the tutor's explanations to demonstrated learner answers. Reinforce these concepts naturally. The learner explicitly requested completion and a progress-only update while retaining the two known source fixes below.

## Decisions and adaptations

| Date | Decision | Reason / affected lessons |
| --- | --- | --- |
| Edition 2 | Metal 4 from lesson 01 through the entire course | Explicit learner preference; replaces edition 1 |
| 2026-10-03 | Larger related coding steps with explained snippets | Earlier preference, refined by the whole-lesson delivery decision below. |
| 2026-10-03 | Thorough theory, placed code snippets, and whole-lesson delivery | Historical single-message preference, superseded by step-based delivery on 2026-10-16. Thorough explanation and hints-first opt-in remain. |
| 2026-10-12 | Close lesson 04 without another understanding answer | Explicit learner instruction; lesson 04 is Complete after source review and learner-reported working behavior. Tutor explanations remain distinguished from learner answers. |
| 2026-10-13 | Extract GPUData, TransformMath, MeshGeometry, and SceneResources during lesson 05 | Learner raised Renderer.swift's growing responsibilities; retain frame orchestration and animation in Renderer for now. |
| 2026-10-13 | Adapt lesson 05's pipeline-depth-format instruction to the actual Metal 4 API | The inspected SDK's MTL4RenderPipelineDescriptor has no depthAttachmentPixelFormat. Configure MTKView depth texture, render-pass actions, and MTLDepthStencilState; retain matching color format and sample count. |
| 2026-10-16 | Close lesson 05 after final source fix, follow-up answers, and learner confirmation | Learner reported completion and authorized the progress update. Preserve the limits of runtime evidence; no GPU execution or capture verification by the reviewer is implied. |
| 2026-10-16 | Teach lessons in steps across messages; questions remain at the lesson end | Explicit learner preference supersedes single-message delivery. Pause after each coherent step; no per-step quizzes or mandatory commits. |
| 2026-10-16 | Prevent file bloat proactively | Inspect responsibilities before every implementation step; teach small extractions before adding unrelated code, preserving ownership and behavior. |

| 2026-10-18 | Close lesson 06 after review and learner-reported working behavior without further understanding answers | Explicit learner request to mark the lesson done supersedes the provisional Awaiting evidence verdict. No required source fixes remain; preserve the distinction between learner answers, tutor explanations, CPU checks, and full-app runtime evidence. |

| 2026-10-25 | Mark lesson 07 Complete at the learner's request; record two unresolved source fixes without app edits | Learner reported expected behavior, then explicitly selected “Update progress only; record both issues” after the reviewer identified missing box-color forwarding and missing roof residency. Preserve these findings and the limits of runtime/understanding evidence. |

## Latest session handoff

Lesson 07, tasks 07.1–07.5, is recorded **Complete at the learner's explicit request** at reviewed code commit 17b26c23cc774bc8078defef358c81dee0f7df55, compared with baseline d78bbf74a02118f1d31992e45dee11ff58f69c12. The reviewed merge contains implementation commit fd62e4d1f8e543aab8139e019fea0c1d126e9b4f. Two required source fixes remain unresolved by the learner's explicit choice; completion is a learner-requested exception to the review criteria.

Teaching covered the cabin coordinate/dimension plan, reusable mesh/object separation (07.2a), per-object color and the 208-byte CPU/MSL uniform layout (07.2b), the cabin body and outward-wound triangular-prism roof, decorative panels/porch/chimney, and a shared root transform applied at assembly time. The learner applied and pushed the work, then reported that everything works as expected. The scene deliberately replaces the diagnostic rotating box with a stationary cabin.

File responsibilities: MeshBuffers.swift owns geometry upload and buffer/count representation; MeshGeometry.swift owns box, ground, and roof geometry plus triangle/quad builders; SceneObject.swift owns a mesh reference, model/color state, and a distinct uniform allocation; CabinScene.swift assembles ten cabin objects using shared geometry and root × part model matrices; SceneResources.swift prepares meshes, scene objects, argument table, and residency; Renderer.swift writes uniforms and draws the object list after its existing completion gate. GPUData.swift and Shaders.metal agree on model/view/projection/baseColor with 208-byte stride and baseColor offset 192. OrbitCamera.swift targets (0, 1.7, 0) at default distance 8. The cabin root is translation (0.5, 0, -0.3) × uniform scale 0.85; the ground is constructed separately.

**Unresolved required source fixes — no app edits authorized:**

1. CabinScene.swift, nested box helper in makeCabinObjects: its color argument is never forwarded to SceneObject. Add `baseColor: color,` after the model argument. At the reviewed SHA, all nine box-shaped cabin parts therefore use SceneObject's default white color instead of their declared colors.
2. SceneResources.swift, init(device:queue:): `let meshes = [boxMesh, groundMesh]` omits roofMesh. Include roofMesh so both roof vertex/index allocations are registered before residencySet.commit(). Retaining the roof buffers through scene objects does not establish GPU residency; apparently working output does not remove this requirement.

Review inspected the exact source and baseline diff for CabinScene.swift, MeshBuffers.swift, SceneObject.swift, SceneResources.swift, GPUData.swift, MeshGeometry.swift, Renderer.swift, OrbitCamera.swift, Shaders.metal, TransformMath.swift, and the Xcode project configuration. The new files belong to the app's synchronized source group. The existing completion gate, per-object uniform allocations, indexed-draw bindings, and resource retention remain intact apart from the roof residency omission described above.

Verification personally executed on the submitted source: renderer-related Swift files type-checked against the macOS 27 SDK; CPU checks passed for GPU layout, valid roof indices, eight nondegenerate outward-facing triangles, closed prism edges and volume, roof height, and camera target mapping in all presets. Earlier teaching-snippet checks of assembly contacts and root composition are separate from this submitted-source review. The reviewer did not build or run the full app or compile/execute the submitted Metal shader. No screenshots or GPU captures were supplied or committed.

The learner's general runtime confirmation is the behavior evidence. No final understanding answers were supplied. After being told about both required source fixes, the learner explicitly selected “Update progress only; record both issues.” This commit therefore changes only PROGRESS, records Complete as requested, and leaves both source issues visible for follow-up. No further understanding-answer requirement was imposed.

Next action: wait for the learner's request. Surface and resolve the two recorded source issues with the learner before beginning lesson 08; lesson 08 remains Not started. This progress-only commit does not change the reviewed code SHA.

## Previous lesson 06 handoff

Lesson 06, tasks 06.1–06.5, is Complete at reviewed code commit 4901d3ad56d1a24c4f24ac8741ae10bbfb938cea, compared with baseline ab2c112426cf9cede41d3e2e5eec63e6cc87a5bd. The reviewed merge includes implementation parent f49a187f710d9761d18e2e5d2b79fb43dbbf561b. No required source fixes were found.

Teaching was delivered in three steps: camera basis and look-at construction; orbit state and pointer/scroll controls; named diagnostic poses and resize/focus checks. The learner applied the changes and confirmed expected behavior after each step, then reported that the pushed implementation worked as expected.

File responsibilities: OrbitCamera.swift owns target/distance/yaw/pitch, eye/view calculations, limits, reset, and Baseline/Side/Elevated presets. CameraMTKView.swift owns pointer and scroll-event forwarding. MetalView.swift connects weak callbacks to the retained renderer and forwards pose requests. ContentView.swift owns animation controls and camera-preset requests. TransformMath.swift contains makeLookAt and camera assertions. Renderer.swift retains the active camera and uses its view matrix in the existing per-object uniforms, with the single-frame completion gate protecting GPU-visible writes. MeshGeometry.swift changes are formatting only; existing GPU layouts, shaders, residency, resource retention, and depth behavior are preserved.

The camera uses target (0, 0.75, 0), initial eye (0, 2.5, 6), distance 6.25, yaw 0, and pitch atan2(1.75, 6). Drag sensitivity is 0.005 radians per input unit; yaw wraps by 2π, pitch stays between 0.05 and π/2 − 0.05, and exponential zoom stays within distance 2–12. Baseline restores the initial pose; Side uses yaw π/2; Elevated uses yaw/pitch π/4 and distance 8. A request counter allows the same preset to be reapplied after manual movement without resetting the camera on ordinary SwiftUI updates.

Review inspected the exact source and baseline diff for CameraMTKView.swift, ContentView.swift, MetalView.swift, OrbitCamera.swift, Renderer.swift, TransformMath.swift, and MeshGeometry.swift, plus surrounding GPUData.swift, SceneResources.swift, Shaders.metal, and ForestCabinMetalApp.swift. During review, the reviewer compiled the submitted OrbitCamera.swift and TransformMath.swift in a scratch CPU harness and ran the submitted projection/camera assertions plus numeric checks for initial pose, quarter orbit, repeated angle/distance limits, reset, preset repeatability, expected eye positions, and target mapping. All passed. Earlier teaching snippets were also type-checked together; that is separate from building the submitted app. No full-app build, Metal execution, or GPU-capture inspection was performed by the reviewer.

Understanding and verdict: the learner's cross-product-order answer was correct, and the behind-camera outcome was correct while its direction needed correction. The tutor explained camera-relative subtraction, pitch prevention versus precondition detection, and correct versus reversed forward direction. The provisional verdict was Awaiting evidence for two short understanding follow-ups, with no required source fixes. The learner then explicitly requested, “Ok, you can update progress with this lesson marked as done.” Lesson 06 is therefore Complete at the learner's request without those additional answers. Tutor explanations remain distinguished from demonstrated learner answers. There is no outstanding answer or code correction blocking continuation.

This is a progress-only update; the reviewed implementation remains 4901d3ad56d1a24c4f24ac8741ae10bbfb938cea. Preserve the earlier lesson records below. Next action: wait for the learner to request lesson 07 (cabin blockout); lesson 07 remains Not started.

## Previous lesson 05 handoff

The historical pause before lesson 06 below was superseded by the learner's request to start lesson 06 and the completed review recorded above.

Teaching guidance update, 2026-10-16: future lessons use manageable steps across messages, with understanding questions only after the final step. Inspect file responsibilities before extending them and teach small extractions before bloat develops. Lesson 05 remains Complete; this documentation update does not change the reviewed code or begin lesson 06.

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
