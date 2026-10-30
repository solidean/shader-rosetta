#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_viewTexel;
    float4x4 u_view;
    float4 u_params;
    float4 u_svparams;
    float4 u_ambient;
    float4 u_diffuse;
    float4 u_specular_shininess;
    float4 u_fog;
    float4 u_lightPosRadius;
    float4 u_lightRgbInnerR;
};

constant float _792 = {};

constant uint bgfx_sampleMask [[function_constant(0)]];
constant bool bgfx_sampleMaskEnabled = is_function_constant_defined(bgfx_sampleMask);

struct xlatMtlMain_out
{
	uint bgfx_metal_sampleMask [[sample_mask, function_constant(bgfx_sampleMaskEnabled)]];
    float4 bgfx_FragData0 [[color(0)]];
};

struct xlatMtlMain_in
{
    float3 v_normal [[user(locn0)]];
    float2 v_texcoord0 [[user(locn1)]];
    float3 v_view [[user(locn2)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_texColor [[texture(0)]], texture2d<float> s_texStencil [[texture(1)]], sampler s_texColorSampler [[sampler(0)]], sampler s_texStencilSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _500 = fast::normalize(in.v_normal);
    float3 _629 = (_mtl_u.u_view * float4(_mtl_u.u_lightPosRadius.xyz, 1.0)).xyz - in.v_view;
    float3 _631 = fast::normalize(_629);
    float _678 = dot(_500, _631);
    float4 _715 = s_texStencil.sample(s_texStencilSampler, ((gl_FragCoord.xy * _mtl_u.u_viewTexel.xy) + (_mtl_u.u_viewTexel.xy * _mtl_u.u_params.z)));
    float _544 = length(in.v_view);
    float3 _563 = float4(powr(abs(s_texColor.sample(s_texColorSampler, in.v_texcoord0).xyz), float3(2.2000000476837158203125)), _792).xyz;
    float3 _754 = powr(abs((_mtl_u.u_ambient.xyz * _mtl_u.u_params.x) * _563), float3(0.4545454680919647216796875));
    float3 _781 = mix(_mtl_u.u_fog.xyz, mix(_754, _754 + powr(abs((((((_mtl_u.u_diffuse.xyz * fast::max(0.0, _678)) + (_mtl_u.u_specular_shininess.xyz * (step(0.0, _678) * powr(fast::max(0.0, dot((_500 * (2.0 * _678)) - _631, -fast::normalize(in.v_view))), _mtl_u.u_specular_shininess.w)))) * _mtl_u.u_lightRgbInnerR.xyz) * (50.0 * powr(fast::max(length(_629), _mtl_u.u_lightPosRadius.w), -2.0))) * _mtl_u.u_params.y) * _563), float3(0.4545454680919647216796875)), float3(float(abs(((_715.x - _715.y) + (2.0 * (_715.z - _715.w))) * _mtl_u.u_svparams.x) < 9.9999997473787516355514526367188e-05))), float3(fast::clamp(1.0 / exp2((((_mtl_u.u_fog.w * _mtl_u.u_fog.w) * _544) * _544) * 1.44269502162933349609375), 0.0, 1.0)));
    out.bgfx_FragData0 = float4(_781, 1.0);
    return out;
}

