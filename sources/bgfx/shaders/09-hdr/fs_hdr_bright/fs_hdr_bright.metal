#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_offset[16];
    float4 u_tonemap;
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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_texColor [[texture(0)]], texture2d<float> s_texLum [[texture(1)]], sampler s_texColorSampler [[sampler(0)]], sampler s_texLumSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _572 = s_texLum.sample(s_texLumSampler, in.v_texcoord0);
    float4 _593 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[0].xy));
    float4 _616 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[1].xy));
    float4 _639 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[2].xy));
    float4 _662 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[3].xy));
    float4 _685 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[4].xy));
    float4 _708 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[5].xy));
    float4 _731 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[6].xy));
    float4 _754 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[7].xy));
    float4 _777 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[8].xy));
    float3 _530 = (((((((((_593.xyz * exp2((_593.w * 255.0) - 128.0)) + (_616.xyz * exp2((_616.w * 255.0) - 128.0))) + (_639.xyz * exp2((_639.w * 255.0) - 128.0))) + (_662.xyz * exp2((_662.w * 255.0) - 128.0))) + (_685.xyz * exp2((_685.w * 255.0) - 128.0))) + (_708.xyz * exp2((_708.w * 255.0) - 128.0))) + (_731.xyz * exp2((_731.w * 255.0) - 128.0))) + (_754.xyz * exp2((_754.w * 255.0) - 128.0))) + (_777.xyz * exp2((_777.w * 255.0) - 128.0))) * 0.111111111938953399658203125;
    float3 _550 = (fast::max(float3(0.0), _530 - float3(_mtl_u.u_tonemap.z)) * _mtl_u.u_tonemap.x) / float3(fast::clamp(_572.x * exp2((_572.w * 255.0) - 128.0), 0.100000001490116119384765625, 0.699999988079071044921875) + 9.9999997473787516355514526367188e-05);
    out.bgfx_FragData0 = float4(powr(abs(float4((_550 * (float3(1.0) + (_550 / float3(_mtl_u.u_tonemap.y)))) / (float3(1.0) + _550), 1.0).xyz), float3(0.4545454680919647216796875)), 1.0);
    return out;
}

