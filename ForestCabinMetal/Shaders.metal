#include <metal_stdlib>
using namespace metal;

struct GPUVertex {
    float4 position;
    float4 color;
};

struct GPUUniforms {
    float4x4 model;
    float4x4 view;
    float4x4 projection;
};

struct TriangleVertexOutput {
    float4 position [[position]];
    float3 color;
};

vertex TriangleVertexOutput triangleVertex(
                                           uint vertexID [[vertex_id]],
                                           device const GPUVertex *vertices [[buffer(0)]],
                                           constant GPUUniforms &uniforms [[buffer(1)]]
){
    GPUVertex gpuvertex = vertices[vertexID];
    
    TriangleVertexOutput output;
    output.position = uniforms.projection * uniforms.view * uniforms.model * gpuvertex.position;
    output.color = gpuvertex.color.xyz;
    
    return output;
    
}

fragment float4 triangleFlatFragment() {
    return float4(0.85, 0.25, 0.08, 1.0);
}

fragment float4 triangleColorFragment(TriangleVertexOutput input [[stage_in]]){
    return float4(input.color, 1.0);
}
