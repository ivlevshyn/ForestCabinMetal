# Forest Cabin — course entry point

## Read this first

You are starting graphics programming from zero and learning unfamiliar Swift syntax alongside Metal; see PROGRESS for your current background. You will build one Metal app from a clear-colored window to an advanced forest cabin diorama. You implement the code; ChatGPT teaches, helps you debug, and reviews your submitted commits.

Each lesson is taught as a complete, substantial explanation: accessible theory, worked examples, and clear Swift/MSL snippets with exact file and function placement. The tutor expands the lesson outline rather than merely assigning its bullet points. The learner applies the code and checks the required result afterward; experiments and extra variations are optional. Practice, understanding questions, and commit/review directions appear together at the end of the whole lesson. See [the delivery template](templates/LESSON-DELIVERY.md).

**Required session context:** [TEACHING](TEACHING.md), [PROGRESS](PROGRESS.md), the current lesson, and relevant parts of [PROJECT](PROJECT.md), [METAL4](METAL4.md), and [REFERENCE](REFERENCE.md). These are the working agreement. Every lesson repeats a short reminder so the agreement is not lost when files are attached individually.

## What you will build

A compact clearing with a recognizable cabin, textured materials, terrain and trees, an orbit camera, sunlight and shadows, a warm porch light, moving foliage, fog, and bloom. The advanced path adds compute particles, deliberate resource management, visibility optimization, normal mapping, environment lighting, occlusion, volumetric mist, and temporal anti-aliasing. Optional electives investigate one ray-traced effect and a deeper Metal 4 pipeline-compilation study.

The same repository and application grow throughout. Early diagnostic shapes become scene parts or debug modes. Replacing an earlier approximation is expected: for example, simple ambient light becomes environment lighting and distance fog becomes a volume effect. No prior stage is wasted just because its implementation later evolves.

## Start with your environment

At lesson 01, tell the tutor your chip model, RAM, macOS, Xcode version, and comfort with vectors/matrices. Unknown math is taught just in time. There is no prerequisite linear-algebra course and no requirement to own an HDR display or a high-end Mac.

The default is a native macOS Swift app with MTKView and handwritten MSL shaders. Metal 4 is used from the first frame through the advanced path. The baseline is macOS 26+, Xcode 26+ with a suitable SDK, and runtime-confirmed Metal 4 support; newer sample revisions may have additional requirements. Read [METAL4](METAL4.md) for the staged API contract. See [PROJECT](PROJECT.md) for coordinate, depth, color, and resource conventions. Feature-dependent electives need actual capability checks; “Apple silicon” is not a universal performance specification.

## How to work through a lesson

1. Start from the previous reviewed checkpoint and give the tutor the branch/commit.
2. Request the whole lesson in one organized message where practical.
3. Read the full theory and explained implementation walkthrough, with exact code placement and no mandatory replies between sections.
4. Use the final practice section to apply the changes, run the app, and answer the understanding questions. Experiments and extra variations are optional and do not affect completion. Ask for debugging help whenever needed.
5. Once the lesson work is ready, follow its final commit/push instructions and request review of the exact SHA with your evidence.
6. Apply any required corrections, request re-review, and record the verdict in PROGRESS. The tutor does not automatically begin the next lesson.

If a lesson takes several sessions, record the task ID (for example 13.3) and the next action. Session-count hints describe possible implementation effort, not a required number of teaching messages or deadlines. Split teaching across messages only for a genuine limit, essential blocker, or your preference; keep the practice/questions/submission section at the end of the whole lesson. Do not rush a prerequisite simply to follow a timetable.

## Core, advanced, and electives

- **01–20: Core.** A complete, coherent diorama and a broad foundation in real-time rendering.
- **21–30: Advanced.** Continue sequentially for the default course. The renderer gains computation, more demanding lighting, optimization, and temporal state.
- **31–32: Electives.** Independent options after 30. Neither is required, and 32 does not require 31.

Default order is intentional. A future tutor may adapt it with you, but must record changed prerequisites and preserve the concepts needed by later lessons. A lesson marked skipped is not silently treated as complete.

## Course map

| ID | Lesson | Track |
| --- | --- | --- |
| 01 | [Your first Metal 4 frame](lessons/01-first-window.md) | Core |
| 02 | [A triangle and the graphics pipeline](lessons/02-first-triangle.md) | Core |
| 03 | [Send geometry from Swift to the GPU](lessons/03-vertex-and-index-buffers.md) | Core |
| 04 | [Move geometry with transforms and time](lessons/04-transforms-and-time.md) | Core |
| 05 | [Enter 3D with perspective and depth](lessons/05-perspective-and-depth.md) | Core |
| 06 | [Explore the cabin with an orbit camera](lessons/06-orbit-camera.md) | Core |
| 07 | [Build the cabin from reusable meshes](lessons/07-cabin-blockout.md) | Core |
| 08 | [Give surfaces shape with sunlight](lessons/08-normals-and-sunlight.md) | Core |
| 09 | [Put wood, bark, and ground on surfaces](lessons/09-textures-and-samplers.md) | Core |
| 10 | [Organize materials without building an engine](lessons/10-materials-and-scene-data.md) | Core |
| 11 | [Generate a small forest clearing](lessons/11-terrain-and-placement.md) | Core |
| 12 | [Draw a forest efficiently with instancing](lessons/12-instanced-forest.md) | Core |
| 13 | [Render shadows from the sun](lessons/13-sun-shadows.md) | Core |
| 14 | [Give the clearing a sky and atmosphere](lessons/14-sky-and-distance-fog.md) | Core |
| 15 | [Make lighting linear and add HDR rendering](lessons/15-linear-hdr-pipeline.md) | Core |
| 16 | [Give wood, stone, and metal distinct responses](lessons/16-physically-based-materials.md) | Core |
| 17 | [Light the cabin at dusk](lessons/17-porch-light-and-emission.md) | Core |
| 18 | [Animate foliage and preserve its silhouette](lessons/18-wind-and-cutout-foliage.md) | Core |
| 19 | [Build a controlled bloom effect](lessons/19-bloom-and-pass-order.md) | Core |
| 20 | [Finish and explain the core diorama](lessons/20-core-review-and-profiling.md) | Core |
| 21 | [Simulate fireflies on the GPU](lessons/21-compute-fireflies.md) | Advanced |
| 22 | [Manage frames in flight deliberately](lessons/22-frames-and-resource-lifetime.md) | Advanced |
| 23 | [Skip invisible trees and simplify distant ones](lessons/23-visibility-and-lod.md) | Advanced |
| 24 | [Let the GPU choose visible instances](lessons/24-gpu-visibility-and-indirect-draws.md) | Advanced |
| 25 | [Add surface detail with tangent-space normals](lessons/25-normal-mapping.md) | Advanced |
| 26 | [Light materials with the surrounding sky](lessons/26-environment-lighting.md) | Advanced |
| 27 | [Add contact depth with screen-space occlusion](lessons/27-screen-space-occlusion.md) | Advanced |
| 28 | [Trace sunlight through forest mist](lessons/28-volumetric-sunlight.md) | Advanced |
| 29 | [Use previous frames without smearing motion](lessons/29-temporal-antialiasing.md) | Advanced |
| 30 | [Ship an explainable advanced diorama](lessons/30-advanced-capstone.md) | Advanced |
| 31 | [Elective: add one ray-traced effect](lessons/31-hybrid-ray-tracing.md) | Elective |
| 32 | [Elective: control Metal 4 pipeline compilation](lessons/32-pipeline-compilation-study.md) | Elective |

## Milestones worth reviewing together

| Checkpoint | Visible outcome | Understanding to demonstrate |
| --- | --- | --- |
| 03 | Triangle and indexed panel | GPU stages, buffers, and byte layout |
| 07 | Orbitable cabin blockout | Transforms, depth, camera, and geometry reuse |
| 12 | Textured cabin in a clearing | Lighting, materials, terrain, and instancing |
| 16 | Shadows and richer surfaces | Multiple passes, linear HDR, and material response |
| 20 | Finished core day/dusk scene | Full frame explanation and measured baseline |
| 24 | Compute and GPU visibility | Parallel ownership, dependencies, and indirect rendering |
| 29 | Advanced lighting and temporal stability | Sampling, reconstruction, and history validity |
| 30 | Reproducible advanced project | Reproducible implementation and justified tradeoffs |

## Git and evidence conventions

Use your normal branch workflow; no pull-request ritual is required for every lesson. The tutor gives commit/review instructions at the end of the whole lesson. Commit when the work is ready; you may also make your own intermediate checkpoints, but they are not required after each walkthrough section. Suggested final code commit title: `lesson 07: build cabin blockout`. The review targets the actual SHA, not a moving branch name.

Keep screenshots small and named clearly, such as `evidence/lesson-13/shadows-on.png`. Large captures/videos may be attached separately instead of committed. Add the exact capture settings and commit in the accompanying note. Do not commit DerivedData or build caches.

After review, a small progress-only commit can record the reviewed code SHA. This avoids the impossible requirement to write a commit's own hash into its contents. If you change implementation after a successful review, identify whether the change affects that lesson's conclusions.

Use these status values: **Not started**, **In progress**, **Ready for review**, **Changes needed**, **Awaiting evidence**, **Complete**, and **Skipped elective**. Only mark Complete after the tutor has reviewed sufficient behavior and understanding evidence. It is acceptable for that behavior evidence to be your recorded Mac run, as long as the reviewer identifies it honestly.

## Reusable prompts

### Begin or resume

> Read learning/README.md, learning/TEACHING.md, learning/METAL4.md, learning/PROGRESS.md, and lesson [ID/path] in [repository URL] at [branch/SHA]. Read METAL4; use PROJECT and REFERENCE where needed. Inspect the current implementation, then teach the whole lesson in one substantial message where practical. Explain all necessary theory in plain language, show clear snippets with exact file/function placement, and explain the important lines. Put independent practice, questions, and commit/review directions together at the end. Do not pause after each internal step or edit my app for me.

### Ask for help

> I am on task [ID]. I expected [...], but observed [...]. Here is the relevant code/error/capture and what I tried. Explain the cause, show a focused corrected snippet with exact placement when useful, and tell me how to verify it. Use hints only if I request that style.

### Request review

> Review lesson [ID] at [code SHA] against [baseline SHA]. Here is my runtime evidence and understanding answers: [...]. Follow TEACHING and the lesson rubric. Identify what you inspected, what I reported, and what you personally ran. Give me a verdict and focused repair tasks for any blockers. Do not edit my files.

### When repository access is unavailable

Attach this README, TEACHING, PROGRESS, the current lesson, PROJECT, METAL4, and the relevant source/shader files. Include REFERENCE or the needed excerpts if the tutor cannot open linked local files. An exported project ZIP can replace individually selected source files. A private repository URL alone is not access authorization or proof of access. Do not share credentials.

## Updating the course

Keep lesson IDs stable. Internal task IDs organize the complete walkthrough; they do not require separate chat turns. Add clarifications without renumbering downstream lessons. Record substantial decisions in PROGRESS. If the installed SDK differs from the examples, adjust the API details with an explanation and keep the conceptual goal intact. The original course contains guidance, not prebuilt code or an assurance that a future tutor has executed your app.
