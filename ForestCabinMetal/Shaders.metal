//
//  Shaders.metal
//  ForestCabinMetal
//
//  Created by Ivan Levshyn on 03/10/2026.
//

#include <metal_stdlib>
using namespace metal;

struct GPUVertex {
    float4 position;
    float4 color;
};

struct TriangleVertexOutput {
    float4 position [[position]];
    float3 color;
};

vertex TriangleVertexOutput triangleVertex(uint vertexID [[vertex_id]], device const GPUVertex *vertices [[buffer(0)]]){
    GPUVertex gpuvertex = vertices[vertexID];
    
    TriangleVertexOutput output;
    output.position = gpuvertex.position;
    output.color = gpuvertex.color.xyz;
    return output;
}

fragment float4 triangleFlatFragment() {
    return float4(0.85, 0.25, 0.08, 1.0);
}

fragment float4 triangleColorFragment(TriangleVertexOutput input [[stage_in]]){
    return float4(input.color, 1.0);
}
