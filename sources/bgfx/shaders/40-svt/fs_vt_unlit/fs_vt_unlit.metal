#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_vt_settings_1;
    float4 u_vt_settings_2;
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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_vt_page_table [[texture(0)]], texture2d<float> s_vt_texture_atlas [[texture(1)]], sampler s_vt_page_tableSampler [[sampler(0)]], sampler s_vt_texture_atlasSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float2 _317 = in.v_texcoord0 * _mtl_u.u_vt_settings_1.x;
    float2 _318 = dfdx(_317);
    float2 _323 = dfdy(-_317);
    float2 _344 = in.v_texcoord0 * _mtl_u.u_vt_settings_2.y;
    float4 _366 = s_vt_page_table.sample(s_vt_page_tableSampler, (in.v_texcoord0 - (fract(_344) / float2(_mtl_u.u_vt_settings_2.y))), level(fast::clamp(floor(fast::max(0.5 * log2(fast::max(dot(_318, _318), dot(_323, _323))), 0.0)), 0.0, log2(_mtl_u.u_vt_settings_2.y))));
    out.bgfx_FragData0 = s_vt_texture_atlas.sample(s_vt_texture_atlasSampler, ((floor((_366.xy * 255.0) + float2(0.5)) + ((fract(_344 / float2(exp2(floor((_366.z * 255.0) + 0.5)))) * _mtl_u.u_vt_settings_1.z) + float2(_mtl_u.u_vt_settings_1.w))) * _mtl_u.u_vt_settings_1.y));
    return out;
}

