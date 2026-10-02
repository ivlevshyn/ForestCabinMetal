# Metal 4 from lesson 01 — binding course contract

This file applies to every lesson. The learner explicitly chose to learn Metal 4 directly. Do not teach a prior-generation renderer first and postpone Metal 4 to an elective. This course starts with no assumed graphics knowledge; teach the following responsibilities progressively.

## Environment gate

Target macOS 26 or later with Xcode 26 or later and a suitable macOS SDK. Verify the actual device reports support for the Metal 4 family. Apple silicon is the intended hardware; optional ray-tracing paths and other features may have additional requirements. A specific downloaded sample may need a newer Xcode point release than the baseline APIs.

If the learner cannot run the needed OS/SDK, explain the exact blocker and discuss their options. Do not quietly downgrade the course. No OS installation or project change is authorized merely by this document.

## Introduce responsibilities when they first matter

| Lesson | Metal 4 learning objective |
| --- | --- |
| 01 | Queue, reusable command buffer, command allocator, drawable coordination, view/layer residency, resource ownership, and one safe frame slot |
| 02 | MTL4Compiler, function descriptors, and render-pipeline creation |
| 03 | Resident mesh allocations, GPU addresses, argument tables, and indexed-draw byte ranges |
| 04 | Per-draw uniform storage; binding snapshots versus data lifetime |
| 09 | Texture/sampler resource IDs; explicit dependencies for GPU-generated mip levels if used |
| 13 | First dependent rendering passes: shadow output to main-pass sampling |
| 15–19 | Offscreen-target residency, retirement, and dependencies through HDR/post-processing |
| 21 | Unified compute encoder, dispatch-stage ownership, and compute-to-render dependencies |
| 22 | Several frame slots, allocator reuse, and cross-frame hazards |
| 24 | GPU-generated indirect arguments and IDs with explicit synchronization |
| 32 | Optional deeper compilation scheduling/caching study |

Do not lecture on the full table during lesson 01. Teach the next responsibility using one concrete need, a small experiment, and a reviewable implementation.

## The API names that matter

Use MTL4CommandQueue, MTL4CommandBuffer, MTL4CommandAllocator, MTL4RenderCommandEncoder, MTL4ComputeCommandEncoder, MTL4ArgumentTable, and MTL4Compiler where the corresponding functionality is needed. Metal 4 still uses shared objects such as MTLDevice, MTLBuffer, MTLTexture, MTLRenderPipelineState, MTLResidencySet, MTLSharedEvent, and MetalKit views. Do not invent a new MTL4-prefixed version of a shared type.

The queue submits ended Metal 4 command buffers. Do not substitute the older command-buffer commit/present/waitUntilCompleted idiom. MSL entry points, geometry math, materials, and many resource formats remain applicable, but the surrounding API contract must be Metal 4.

For pipelines, begin with straightforward synchronous creation during initialization using MTL4Compiler and Metal 4 descriptors. Explain the library/function descriptors rather than expecting the learner to infer them from old examples. More elaborate compilation behavior waits until there is an observed need.

## First-frame ownership model

Start with one frame slot. It owns an allocator, mutable frame data as it is introduced, and strong references needed until completion. A shared event begins with no pending submission. Each real submission gets a fresh increasing completion value, signaled through the queue after its GPU work.

Before CPU reuse, check whether the slot's last submitted value has completed. If not, return from that draw callback and try again on a later callback; do not busy-loop. If there has never been a submission, the slot is available. Never invent a pending value for a frame skipped before submission. Failure to observe completion is not permission to reset storage; report and investigate the error.

Only an available slot may have its allocator reset and mutable data rewritten. Retain submitted allocations and required objects until their last use completes. Queue drawable wait/signal operations and drawable presentation coordinate with display ownership; the frame event separately proves when app-owned data can be reused. Explain this distinction before implementation.

This intentionally limits overlap initially. Lesson 22 improves throughput by adding slots; it does not introduce correctness for the first time. The early gate can be implemented by nonblocking checks rather than keeping the UI waiting for the GPU.

## Bindings, residency, and bytes

Argument tables connect shader slots to buffer addresses, texture IDs, and sampler IDs. Configure the table's capacities, fill the entries, and bind it to the stage that uses them. An index buffer passed by address still needs residency and lifetime protection even if it is not in the shader argument table.

Metal snapshots relevant table bindings when encoding work. This does not copy the buffer contents. If two draws need different model matrices, give them separate records or nonoverlapping aligned regions; pointing both at one region and overwriting it for the second draw is unsafe even within one frame. Later, give each in-flight slot its own mutable regions or another proved-safe strategy.

Track app allocations in residency sets, commit membership updates, and attach the needed sets to the queue or command buffer. Include view/layer-managed allocations through the documented view/layer route and account for any additional app-owned depth/offscreen targets. Keep Swift ownership explicit. A resident allocation is not automatically safe to write, and a valid GPU address is not proof of residency.

## GPU synchronization is explicit

Metal 4 queue work does not get automatic resource-hazard protection from a tracked flag. A later encoder or dispatch may overlap an earlier one. When one stage produces bytes another needs, or later work overwrites bytes an earlier consumer still needs, express the dependency.

Use the current documentation to choose intra-pass barriers, queue consumer/producer barriers, or fences for their actual scope. Begin with conservative correct stage masks and explain them; narrow only after validation and measurement. An intra-pass barrier cannot express an arbitrary dependency between different encoders. A threadgroup barrier cannot synchronize a whole dispatch. Residency and CPU completion gates do not replace these GPU dependencies.

| Example introduced in this course | Relationship to prove |
| --- | --- |
| Shadow map | Depth producer completes before a later shader samples it |
| HDR/display | Rendering writes are visible to the display pass's texture reads |
| Bloom ping-pong | Each filter reads the preceding output; an image is not overwritten before its previous readers finish |
| Fireflies | Dispatch updates precede vertex reads; later updates wait for earlier reads when sharing state across frames |
| GPU visibility | Reset precedes culling; culling precedes argument finalization; all generated data is ready before indirect fetch and shader consumption |
| Temporal history | History writes precede next-frame reads, and reuse waits for all prior reads |

The tutor must identify the exact producer and consumer stages from the selected API documentation, including indirect fetch and copy/build operations, rather than guess stage masks. Record the relationship in a compact dependency table before coding it. No universal barrier snippet belongs in every pass blindly.

## Metal 4 review gate

For each lesson, inspect the responsibilities it introduces. By the relevant checkpoint, require evidence of correct Metal 4 submission, argument-table binding, allocation residency, resource retention, allocator reuse, and explicit dependencies. Do not demand a concept before its introduction; do not omit required safety because the scene is small.

Use Apple samples as references for a specific question. Some include both generations of renderer, and some linked technique samples predate Metal 4. Select the Metal 4 branch or translate the technique with the tutor. The learner should be able to explain every retained part.

References: [core API](REFERENCE.md#r21), [argument tables](REFERENCE.md#r22), [residency](REFERENCE.md#r23), [compilation](REFERENCE.md#r24), [completion events](REFERENCE.md#r25), [barriers](REFERENCE.md#r26), [queue](REFERENCE.md#r27), [allocator](REFERENCE.md#r28).
