//
//  Shaders.metal
//  ForestCabinMetal
//
//  Created by Ivan Levshyn on 03/10/2026.
//

#include <metal_stdlib>
using namespace metal;


struct TriangleVertexOutput {
    float4 position [[position]];
    float3 color;
};

vertex TriangleVertexOutput triangleVertex(uint vertexID [[vertex_id]]){
    const float2 positions[3] = {
        float2(-0.65, -0.55),
        float2(0.65, -0.55),
        float2(0.00, 0.65)
    };
    
    const float3 colors[3] = {
        float3(1.0, 0.0, 0.0),
        float3(0.0, 1.0, 0.0),
        float3(0.0, 0.0, 1.0)
    };
    
    TriangleVertexOutput output;
    output.position = float4(positions[vertexID], 0.0, 1.0);
    output.color = colors[vertexID];
    return output;
}

fragment float4 triangleFlatFragment() {
    return float4(0.85, 0.25, 0.08, 1.0);
}

fragment float4 triangleColorFragment(TriangleVertexOutput input [[stage_in]]){
    return float4(input.color, 1.0);
}
