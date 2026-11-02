#include <metal_stdlib>
using namespace metal;

struct GPUVertex {
    float4 position;
    float4 color;
    float4 normal;
};

struct GPUUniforms {
    float4x4 model;
    float4x4 view;
    float4x4 projection;
    float4 baseColor;
    float3x3 normalMatrix;
    float4 sunDirectionAndAmbient;
    float4 sunColorAndIntensity;
};

struct TriangleVertexOutput {
    float4 position [[position]];
    float3 color;
    float3 normalWorld;
};

vertex TriangleVertexOutput triangleVertex(
                                           uint vertexID [[vertex_id]],
                                           device const GPUVertex *vertices [[buffer(0)]],
                                           constant GPUUniforms &uniforms [[buffer(1)]]
){
    GPUVertex gpuvertex = vertices[vertexID];
    
    TriangleVertexOutput output;

    output.position =
    uniforms.projection
    * uniforms.view
    * uniforms.model
    * gpuvertex.position;

    output.color = uniforms.baseColor.rgb;
    output.normalWorld = uniforms.normalMatrix * gpuvertex.normal.xyz;

    return output;
    
}

fragment float4 triangleFlatFragment() {
    return float4(0.85, 0.25, 0.08, 1.0);
}

fragment float4 triangleColorFragment(
                                      TriangleVertexOutput input [[stage_in]],
                                      constant GPUUniforms &uniforms [[buffer(1)]]
                                      ){
    const bool showNormals = false;

    float3 N = normalize(input.normalWorld);

    if (showNormals) {
        float3 debugColor = N * 0.5f + 0.5f;

        return float4(debugColor, 1.0f);
    }

    float3 L = uniforms.sunDirectionAndAmbient.xyz;
    float ambientFill = uniforms.sunDirectionAndAmbient.w;

    float3 sunColor = uniforms.sunColorAndIntensity.rgb;
    float sunIntensity = uniforms.sunColorAndIntensity.w;

    float diffuseFactor = max(dot(N, L), 0.0f);

    float3 directLight = sunColor * sunIntensity * diffuseFactor;

    float3 ambientLight = float3(ambientFill);

    float3 litColor = input.color * (ambientLight + directLight);

    return float4(litColor, 1.0f);
}
