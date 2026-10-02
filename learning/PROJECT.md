# Project specification and technical conventions

## The scene we are building

A compact forest clearing with one cabin: walls, pitched roof, door, window panels, porch, chimney, ground, rocks, tree trunks and canopies. Start with boxes, triangles, and simple generated meshes. The final scene has an orbit camera, readable sunlight and shadows, bark/wood/ground materials, a warm porch light, subtle wind, fog, and controllable visual effects.

Keep the clearing on the order of tens of meters across. One world unit means roughly one meter, Y is up, and the cabin begins near the origin. Exact art direction is the learner's choice. Prefer a small scene that you understand over a vast world. No character controller, collision system, interiors, networking, survival gameplay, or general scene editor is required.

## Stack and baseline

- Native macOS app, Swift for CPU/application code, MSL for GPU code, `simd` for vector and matrix types.
- `MTKView` provides the drawing surface. Use SwiftUI with an AppKit view wrapper if comfortable; a simple AppKit host is equally valid. UI framework choice is not a graphics learning objective.
- Use Metal 4 from lesson 01: `MTL4CommandQueue`, `MTL4CommandBuffer`, `MTL4CommandAllocator`, and Metal 4 encoders. Introduce `MTL4Compiler` in 02 and `MTL4ArgumentTable` in 03. Follow [METAL4](METAL4.md) for staged resource ownership, residency, and synchronization.
- No SceneKit, RealityKit, Unity, or other engine renders the scene for you. MetalKit texture loading and, later if desired, Model I/O asset loading are acceptable helpers.
- Use one Metal 4 command queue and one safely gated frame slot initially. Metal 4 does not automatically track resource hazards: residency, ownership, and synchronization are distinct responsibilities. Introduce GPU barriers with the first dependent passes. Leave heaps, aliasing, and multiple queues out of the main path.
- Baseline: macOS 26 or later, Xcode 26 or later with a matching supported SDK, and an Apple silicon GPU reporting Metal 4 support. Specific sample revisions may require a later Xcode point release. Record actual versions in lesson 01 and verify `.metal4` support plus API availability. Do not infer every optional capability or performance target from the chip name.

## Coordinate and layout contract

Adopt these defaults unless you already have a documented consistent alternative:

- Right-handed world, +Y up; the camera looks along its local -Z direction.
- Column vectors with `clipPosition = projection × view × model × localPosition`. With this convention, the rightmost transform acts first.
- Metal normalized-device depth is 0 to 1. Start with standard depth: clear to 1 and compare `less`. Do not import an OpenGL -1 to 1 depth projection unchanged.
- Perspective division occurs after the vertex shader. Keep homogeneous clip coordinates intact at its output.
- Matrices are stored as columns using Swift SIMD types. Record spaces in variable names when ambiguity matters.
- Select a front-face winding explicitly and verify it with one triangle before enabling back-face culling. Avoid negative scaling initially because it changes orientation.
- Document UV origin and any image flip once. Verify with an asymmetric test image. Render-target UV reconstruction requires its own explicit viewport mapping; do not fix every mismatch by flipping textures randomly.
- A Swift `SIMD3<Float>` does not imply a tightly packed 12-byte struct field layout. Inspect stride/alignment/offsets and make CPU/MSL layouts agree. Start with padded `float4` fields where that makes the contract clear. Do not send Swift reference types or Swift `Bool` blindly as GPU structs.

## Color and resources

Use an sRGB drawable format for ordinary display output and output linear values from shaders. Base-color images are sRGB; normal, roughness, metallic, depth, and occlusion data are linear. Before lesson 15, use modest light values; afterward accumulate lighting into a linear floating-point HDR target and tone-map once into the sRGB display target. HDR rendering does not require an HDR monitor or EDR output.

Start with a single sample per pixel. Explicit MSAA may be explored later, but all attachment and pipeline sample counts must agree. Temporal lessons assume a documented single-sample path unless deliberately adapted.

Build pipeline states with MTL4Compiler, persistent meshes, and immutable buffers outside the frame loop. Send uniforms through resident MTLBuffer allocations whose GPU addresses are entered in MTL4ArgumentTable. Use a distinct region for each draw; never overwrite data that an earlier encoded draw or submitted frame will consume. Argument-table binding snapshots do not copy the referenced buffer contents. Initially reuse one frame slot only after a signaled completion value proves its GPU work finished. Lesson 22 expands that correct single-slot design into several frames in flight.

Set attachment formats, load/store actions, and texture usage based on how each resource is consumed. Resizing must recreate size-dependent offscreen targets. Handle zero drawable size, unavailable drawables, initialization errors, and reported GPU failures without force-unwrapping everything. Retain every referenced resource through completion; register app-owned allocations and view/layer resources in appropriate residency sets. Residency alone neither retains every object for you nor resolves hazards.

## Organization that grows with the project

Begin with an app host, renderer, and one shader file. Add mesh, camera, material, scene, and pass types when they have concrete responsibilities. Suggested folders eventually include `App`, `Renderer`, `Scene`, `Shaders`, `Assets`, and `learning`; these names are guidance, not required architecture.

Maintain a minimal debug panel or keyboard controls for camera reset, time pause, technique toggles, and intermediate render targets. Reuse a few fixed camera positions for comparisons. Keep a fixed random seed for generated scenery.

## Asset policy

Start with your own tiny textures and generated geometry. External models are optional. Record the source, creator, license, and any attribution obligations for imported assets in `Assets/ATTRIBUTION.md` when the first external asset is added. Never require paid assets for a lesson. Do not commit caches, DerivedData, secrets, or multi-gigabyte GPU captures. Keep small screenshots; use external attachments for large captures when needed.

## Quality targets

Select a target pixel resolution and frame-time budget after measuring the actual Mac. Examples such as 16.7 ms for approximately 60 frames per second are arithmetic targets, not promised performance. Correctness and stable experiments come before optimization. Advanced effects must have toggles and a lower-cost configuration.
