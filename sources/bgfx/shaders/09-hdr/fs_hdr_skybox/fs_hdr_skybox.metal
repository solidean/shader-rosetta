#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_mtx;
};

constant uint bgfx_sampleMask [[function_constant(0)]];
constant bool bgfx_sampleMaskEnabled = is_function_constant_defined(bgfx_sampleMask);

struct xlatMtlMain_out
{
	uint bgfx_metal_sampleMask [[sample_mask, function_constant(bgfx_sampleMaskEnabled)]];
    float4 bgfx_FragData0 [[color(0)]];
};

struct xlatMtlMain_in
{
    float2 v_texcoord0 [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texturecube<float> s_texCube [[texture(0)]], sampler s_texCubeSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _224 = s_texCube.sample(s_texCubeSampler, fast::normalize((_mtl_u.u_mtx * float4((in.v_texcoord0 * 2.0) - float2(1.0), 1.0, 0.0)).xyz));
    float _240 = ceil(log2(fast::max(fast::max(_224.x, _224.y), _224.z)));
    out.bgfx_FragData0 = float4(_224.xyz / float3(exp2(_240)), (_240 + 128.0) * 0.0039215688593685626983642578125);
    return out;
}

