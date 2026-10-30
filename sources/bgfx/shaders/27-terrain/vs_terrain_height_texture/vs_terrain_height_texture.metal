#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_modelViewProj;
};

struct xlatMtlMain_out
{
    float3 _entryPointOutput_v_position [[user(locn0)]];
    float2 _entryPointOutput_v_texcoord0 [[user(locn1)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_position [[attribute(0)]];
    float2 a_texcoord0 [[attribute(1)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_heightTexture [[texture(0)]], sampler s_heightTextureSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
    float3 _102 = in.a_position;
    float _157 = s_heightTexture.sample(s_heightTextureSampler, in.a_texcoord0, level(0.0)).x * 255.0;
    float3 _185 = _102;
    _185.y = _157;
    out.gl_Position = _mtl_u.u_modelViewProj * float4(_102.x, _157, _102.z, 1.0);
    out._entryPointOutput_v_position = _185;
    out._entryPointOutput_v_texcoord0 = in.a_texcoord0;
    return out;
}

