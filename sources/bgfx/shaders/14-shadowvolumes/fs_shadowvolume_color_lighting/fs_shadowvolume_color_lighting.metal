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
    float4 u_color;
    float4 u_specular_shininess;
    float4 u_fog;
    float4 u_lightPosRadius;
    float4 u_lightRgbInnerR;
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
    float3 v_normal [[user(locn0)]];
    float3 v_view [[user(locn1)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_texStencil [[texture(1)]], sampler s_texStencilSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _453 = fast::normalize(in.v_normal);
    float3 _580 = (_mtl_u.u_view * float4(_mtl_u.u_lightPosRadius.xyz, 1.0)).xyz - in.v_view;
    float3 _582 = fast::normalize(_580);
    float _629 = dot(_453, _582);
    float4 _666 = s_texStencil.sample(s_texStencilSampler, ((gl_FragCoord.xy * _mtl_u.u_viewTexel.xy) + (_mtl_u.u_viewTexel.xy * _mtl_u.u_params.z)));
    float _497 = length(in.v_view);
    float3 _673 = powr(abs((_mtl_u.u_ambient.xyz * _mtl_u.u_params.x) * _mtl_u.u_color.xyz), float3(0.4545454680919647216796875));
    float3 _700 = mix(_mtl_u.u_fog.xyz, mix(_673, _673 + powr(abs((((((_mtl_u.u_diffuse.xyz * fast::max(0.0, _629)) + (_mtl_u.u_specular_shininess.xyz * (step(0.0, _629) * powr(fast::max(0.0, dot((_453 * (2.0 * _629)) - _582, -fast::normalize(in.v_view))), _mtl_u.u_specular_shininess.w)))) * _mtl_u.u_lightRgbInnerR.xyz) * (50.0 * powr(fast::max(length(_580), _mtl_u.u_lightPosRadius.w), -2.0))) * _mtl_u.u_params.y) * _mtl_u.u_color.xyz), float3(0.4545454680919647216796875)), float3(float(abs(((_666.x - _666.y) + (2.0 * (_666.z - _666.w))) * _mtl_u.u_svparams.x) < 9.9999997473787516355514526367188e-05))), float3(fast::clamp(1.0 / exp2((((_mtl_u.u_fog.w * _mtl_u.u_fog.w) * _497) * _497) * 1.44269502162933349609375), 0.0, 1.0)));
    out.bgfx_FragData0 = float4(_700, 1.0);
    return out;
}

