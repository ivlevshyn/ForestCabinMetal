# Reference shelf and compact glossary

References were selected against official Apple pages and primary technical material on 2 October 2026. They support this original learning sequence; they are not assigned for cover-to-cover reading. Some Apple documentation requires JavaScript, and sample URLs can redirect to newer versions. A future tutor must verify the relevant APIs against the learner's installed SDK rather than claim that every current page matches this course verbatim.

## How to use a reference

1. State the exact question you are trying to answer.
2. Read the smallest relevant section with the tutor.
3. Have the tutor explain the relevant idea fully with a worked example and its cabin implementation; use it in the final practice section.
4. Record any convention or version-dependent choice in the project.

Do not open a sample and copy its entire renderer. If a link moves, search its exact title on Apple Developer or the author's official site and record the replacement. For code-level questions, prefer official API documentation, specifications, or author-published technical notes.

The language-specification link is a large reference PDF. The course does not depend on a particular page number. The tutor should retrieve the precise section needed when teaching it.

## A version trap to recognize

This edition deliberately teaches Metal 4 throughout. Apple’s triangle sample can include both Metal4Renderer and a previous-generation fallback; use the former. Some older references below remain useful for mathematics or rendering techniques. Translate their submission, binding, compilation, and synchronization code to the contract in METAL4.md instead of pasting it. An MTL prefix alone does not mean a type is obsolete: many shared resource and pipeline types retain it.


## R01

**[Apple Metal sample library](https://developer.apple.com/metal/sample-code/)**

Use the index to locate an example for the current concept. Select the Metal 4 implementation when a sample includes both generations. Older samples may explain algorithms, but their command/binding code must be translated to the Metal 4 contract.

## R02

**[MTKView](https://developer.apple.com/documentation/metalkit/mtkview)**

Look up drawable size, delegate callbacks, attachment formats, and view lifecycle. Learn only the members needed for the current exercise.

## R03

**[Drawing a triangle with Metal 4](https://developer.apple.com/documentation/metal/drawing-a-triangle-with-metal-4)**

Use the Metal4Renderer path for command lifecycle, drawable coordination, and the first pipeline. The sample may also ship an older fallback renderer; that fallback is not this course. Translate explained concepts into Swift rather than copying the app.

## R04

**[MTL4RenderCommandEncoder](https://developer.apple.com/documentation/metal/mtl4rendercommandencoder)**

Use Metal 4 argument-table and drawing methods. Indexed and indirect calls use GPU addresses and explicit lengths where specified; check their Swift signatures.

## R05

**[Metal Shading Language specification](https://developer.apple.com/metal/Metal-Shading-Language-Specification.pdf)**

A large language reference, not introductory reading. Consult specific sections on types, alignment, attributes, address spaces, texture access, and atomics when needed. Use the version appropriate to the SDK.

## R06

**[Swift MemoryLayout and SIMD](https://developer.apple.com/documentation/swift/memorylayout)**

Inspect size, stride, and alignment rather than guessing GPU layouts. Also consult [simd](https://developer.apple.com/documentation/simd) for vector/matrix operations. The tutor must explain the math; a function name alone is not a lesson.

## R07

**[Resource synchronization](https://developer.apple.com/documentation/metal/resource-synchronization)**

Use the Metal 4 synchronization rules. The hazardTrackingMode flag does not provide automatic synchronization for Metal 4 queue submissions. Treat GPU pass dependencies separately from CPU frame-slot ownership.

## R08

**[Calculating primitive visibility using depth testing](https://developer.apple.com/documentation/metal/calculating-primitive-visibility-using-depth-testing)**

Use for the depth attachment/state relationship. Verify matrix conventions independently; projection conventions vary between graphics APIs.

## R09

**[Creating and sampling textures](https://developer.apple.com/documentation/metal/creating-and-sampling-textures)**

Use for texture data and sampling. Inspect loader options and format choices instead of relying on defaults.

## R10

**[Customizing render pass setup](https://developer.apple.com/documentation/metal/customizing-render-pass-setup)**

Use for offscreen targets and render-pass configuration. Draw your own producer/consumer table before copying any API sequence.

## R11

**[Modern rendering with Metal](https://developer.apple.com/documentation/metal/modern-rendering-with-metal)**

An advanced integration reference. Consult one relevant technique at a time; it is much broader than this educational renderer and is not a starter project.

## R12

**[Processing HDR images with Metal](https://developer.apple.com/documentation/metal/processing-hdr-images-with-metal)**

Use for HDR processing concepts. This course first presents to an ordinary sRGB drawable; display-specific HDR/EDR integration is separate.

## R13

**[Brian Karis: Real Shading in Unreal Engine 4 (2013)](https://cdn2.unrealengine.com/Resources/files/2013SiggraphPresentationsNotes-26915738.pdf)**

Primary technical notes for material equations and environment-light integration. Read only the selected equations with the tutor. The paper contains HLSL examples; translate the ideas into your own MSL, and keep direct-light and environment conventions distinct.

## R14

**[Metal developer tools](https://developer.apple.com/metal/tools/)**

Use for validation, frame capture, and profiling. Check which tools and UI are available in your Xcode version; do not require the newest command-line tooling to complete a lesson.

## R15

**[Performing calculations on a GPU](https://developer.apple.com/documentation/metal/performing-calculations-on-a-gpu)**

Use for a first compute kernel and dispatch. Adapt the concept to fireflies inside the existing project.

## R16

**[MTL4ComputeCommandEncoder](https://developer.apple.com/documentation/metal/mtl4computecommandencoder)**

Use the unified Metal 4 compute encoder for dispatch and its supported copy/build operations. Identify dispatch, blit, or acceleration-structure stages when planning dependencies.

## R17

**[Encoding indirect command buffers on the GPU](https://developer.apple.com/documentation/metal/encoding-indirect-command-buffers-on-the-gpu)**

An extension reference, not the minimum solution to lesson 24. Begin that lesson with an ordinary indirect instance-count draw; compare the extra responsibilities of ICBs only afterward.

## R18

**[Metal feature set tables](https://developer.apple.com/metal/capabilities/)**

Use with runtime capability queries and SDK availability annotations. Hardware family, operating system, API model, and performance are separate considerations.

## R19

**[Applying temporal antialiasing and upscaling using MetalFX](https://developer.apple.com/documentation/metalfx/applying-temporal-antialiasing-and-upscaling-using-metalfx)**

Apple reference for temporal input concepts and an optional MetalFX comparison. It is not a specification of the custom educational TAA filter. The tutor must explain the chosen custom reprojection and history-rejection math explicitly.

## R20

**[Rendering reflections in real time using ray tracing](https://developer.apple.com/documentation/metal/rendering-reflections-in-real-time-using-ray-tracing)**

Use for the optional hybrid effect. Check sample requirements and actual device support; simplify to static geometry and one effect first.

## R21

**[Understanding the Metal 4 core API](https://developer.apple.com/documentation/metal/understanding-the-metal-4-core-api)**

Required foundation from lesson 01 onward. Read the relevant portion as each feature appears. Also see [Discover Metal 4](https://developer.apple.com/videos/play/wwdc2025/205/). The tutor must explain each new responsibility rather than expecting prior Metal knowledge.

## R22

**[MTL4ArgumentTable](https://developer.apple.com/documentation/metal/mtl4argumenttable)**

Required from lesson 03. Tables provide resource bindings; snapshots at draw/dispatch encoding are not copies of the referenced allocation contents. See also MTL4RenderCommandEncoder.setArgumentTable for snapshot semantics.

## R23

**[Residency sets](https://developer.apple.com/documentation/metal/simplifying-gpu-resource-management-with-residency-sets)**

Use for allocation residency concepts. This shared article includes older command examples; use the MTL4CommandQueue APIs and the Metal4Renderer path of R03 when applying it. Explicit Swift ownership and synchronization are still required.

## R24

**[Using the Metal 4 compilation API](https://developer.apple.com/documentation/metal/using-the-metal-4-compilation-api)**

Required for basic pipeline creation in 02 and compute pipelines in 21. Advanced scheduling, flexible pipelines, and harvesting are deferred to elective 32.

## R25

**[MTLSharedEvent](https://developer.apple.com/documentation/metal/mtlsharedevent)**

Use with Metal 4 queue signaling to establish when the CPU may reuse frame data. Understand monotonic completion values before extending to multiple slots.

## R26

**[MTL4CommandEncoder barriers](https://developer.apple.com/documentation/metal/mtl4commandencoder)**

Consult each barrier variant for its scope and stage masks. Intra-pass barriers, queue producer/consumer barriers, fences, and CPU completion signals are not interchangeable.

## R27

**[MTL4CommandQueue](https://developer.apple.com/documentation/metal/mtl4commandqueue)**

Use from lesson 01 for submission, drawable coordination, residency-set attachment, and event signaling. Check current Swift signatures.

## R28

**[MTL4CommandAllocator](https://developer.apple.com/documentation/metal/mtl4commandallocator)**

Use from lesson 01. Reset command storage only after the work using it completes; distinguish allocator memory from the reusable command-buffer object.

## Glossary

Use this as a reminder after a term is taught. The tutor must still introduce new vocabulary in context.

| Term | Meaning in this project |
| --- | --- |
| Vertex | One mesh record: position and associated attributes such as normal and UV |
| Index | A reference selecting a vertex record for a primitive |
| Primitive | A basic shape submitted to rendering, usually a triangle here |
| Mesh | Geometry plus the buffers/counts used to draw it |
| Shader | A program executed on the GPU |
| Vertex shader | Transforms vertex data and produces values for rasterization |
| Fragment shader | Computes outputs for rasterized fragments; a fragment is not always a final visible pixel |
| Compute kernel | GPU function dispatched over work items without rasterizing triangles |
| Rasterization | Finding sample coverage of projected primitives and interpolating attributes |
| Pipeline state | Prepared GPU configuration including shader stages and compatible attachment settings |
| Render pass | Rendering work using a specified set of image attachments |
| Attachment | An image used as a pass output or depth/stencil surface |
| Drawable | A presentable image supplied by the view/layer for a frame |
| Command buffer | A submitted group of encoded GPU work |
| Encoder | API object through which commands for a pass are described |
| Uniform | Data shared by shader invocations for a draw/dispatch |
| Binding | Connecting a resource or value to the slot a shader expects |
| Stride | Byte distance between neighboring records in an array |
| Alignment | Required byte boundary for placing a value |
| Model matrix | Transformation from an object's local coordinates into world coordinates |
| View matrix | Transformation from world coordinates into camera coordinates |
| Projection | Mapping that produces clip coordinates from a camera-space position |
| Clip space | Homogeneous coordinates before perspective division |
| NDC | Normalized device coordinates after division by W |
| Normal | Direction perpendicular to a surface, used to describe orientation |
| UV | Coordinates used to locate texture samples |
| Sampler | Filtering and addressing rules for texture access |
| Mipmap | One resolution level in a texture's prefiltered size hierarchy |
| sRGB | A standard nonlinear color encoding, distinct from linear-light arithmetic |
| HDR target | Floating-point image that can preserve values beyond the display's ordinary range |
| Tone mapping | Mapping a broad light-value range into a displayable range |
| BRDF | A function describing directional surface reflection |
| PBR | A family of rendering/material approaches guided by physical light behavior |
| Instancing | Reusing geometry across multiple per-instance records in one draw |
| Frustum | The camera's visible volume |
| LOD | A selected level of geometric or shading detail |
| Shadow map | Depth rendered from a light's viewpoint to estimate visibility to that light |
| Alpha test | Discarding fragments using a coverage threshold |
| Alpha blending | Combining a source color with the existing destination using a blend rule |
| Threadgroup | A group of compute work items with group-local cooperation facilities |
| Atomic | An operation with indivisible access to a shared value; not a global dispatch barrier |
| Frames in flight | Submitted frame work that has not yet completed |
| Indirect draw | A draw whose arguments are read from GPU-accessible memory |
| ICB | Indirect command buffer: a resource holding commands, not just one draw's argument record |
| IBL | Lighting approximated from incoming radiance stored over environment directions |
| SSAO | An approximation of nearby occlusion using visible depth/normal information |
| TAA | Anti-aliasing using samples and history across multiple frames |
| Reprojection | Mapping current surface information into a prior frame's coordinates |
| Disocclusion | A surface becoming newly visible and lacking valid matching history |
| Acceleration structure | Spatial organization used to accelerate ray/geometry queries |

## Just-in-time math map

| Introduced in | Math to teach when needed |
| --- | --- |
| 02–03 | Coordinates, interpolation, array offsets and byte counts |
| 04 | Vectors, homogeneous points/directions, matrix multiplication, radians, sine/cosine |
| 05 | Perspective division, near/far mapping, aspect ratio |
| 06–08 | Dot/cross products, normalization, inverse transforms, inverse-transpose normals |
| 11–13 | Grid indexing, finite differences, plane/orthographic mappings |
| 14–17 | Exponential attenuation, linear color, reflection vectors, BRDF terms |
| 19–24 | Weighted sums, discrete updates, bounds/plane tests, parallel ownership |
| 25–28 | Tangent bases, numerical integration, sampling distributions, transmittance |
| 29 | Coordinate reprojection, temporal filtering, validity tests |

At each introduction, the tutor works through a numeric example, identifies units/spaces, and explains a limiting case. Do not replace the explanation with a quiz or a documentation link. Put learner calculations and understanding questions in the final practice section. Do not require a standalone linear-algebra course before continuing.
