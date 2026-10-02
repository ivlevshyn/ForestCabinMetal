# Debugging field guide

Use this alongside the current lesson, not as a checklist to complete before drawing anything.

## One hypothesis at a time

State what you expected, what happened, and which pipeline stage could explain the difference. Make one small change that distinguishes explanations. Record the observation; revert diagnostic changes after learning from them. Keep a known-good camera and simple test surface inside the same app.

| Symptom | First observations to make |
| --- | --- |
| No clear color | Is the view drawing? Is there a drawable and render-pass descriptor? Did the Metal 4 queue wait for the drawable, commit the ended command buffer, and signal the drawable before presentation? |
| Clear color but no triangle | Check shader compilation, pipeline/attachment format agreement, draw count, bindings, and clip-space positions. Temporarily disable culling. |
| Distorted or exploding mesh | Inspect buffer stride, offsets, index type, index bounds, and CPU/MSL layout. |
| Object disappears after projection | Check camera direction, near/far values, homogeneous W, aspect ratio, and Metal depth convention. |
| Geometry drawn in the wrong order | Check depth attachment, clear value, comparison, depth-write enable, and unintended transparency. |
| Light moves with camera | Identify the spaces of position, normal, light, and view vectors. They must agree. |
| Stretching or inverted texture | Visualize UVs and use an asymmetric labeled texture. Verify the image-origin policy. |
| Washed-out or overly dark output | Trace sRGB decoding, linear lighting, tone mapping, and final sRGB encoding. Count conversions. |
| Flickering or nondeterministic data | Inspect writes to in-flight buffers, encoder ordering, uninitialized counters, and out-of-bounds GPU access. |
| Shadow acne or detached shadows | Inspect the shadow map, light transform, depth comparison, bias magnitude, and shadow bounds. |
| Sudden slowdown | Compare GPU and CPU time at fixed scene, resolution, settings, and camera. Check allocations and draw count. |
| Trails after motion | Inspect motion vectors, history validity, jitter convention, disocclusion, and history reset conditions. |

## Use Xcode deliberately

Enable the available Metal API and shader validation options during development. UI locations vary by Xcode version: consult the installed scheme diagnostics and official documentation. Use GPU frame capture to inspect a specific draw, its inputs, attachments, and output. Label resources and encoders so a capture tells a story.

Validation may add overhead. Record whether it was enabled when discussing performance. Do not claim a single captured frame gives reliable benchmark timings. Warm up the scene, use repeated measurements, and distinguish CPU wall time from GPU duration and presentation pacing.

## A useful help request

Provide the lesson/task, commit or relevant current files, expected result, actual result, exact error text, the smallest relevant code, and what you already tested. A screenshot and an intermediate-target view are often more useful together than either alone. Do not post only “it doesn't work.” The tutor should help you narrow the problem without demanding an exhaustive report first.

## Numerical guardrails

Check for zero-length vectors before normalization, zero or tiny denominators, invalid aspect ratios, and unstable time steps after app suspension. Clamp only where the model requires it; arbitrary clamping can hide a coordinate or layout error. Use a deliberately simple scene to test equations before tuning artistic parameters.
