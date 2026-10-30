#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_view;
    float4 u_params;
    float4 u_ambient;
    float4 u_diffuse;
    float4 u_color;
    float4 u_specular_shininess;
    float4 u_lightPosRadius[5];
    float4 u_lightRgbInnerR[5];
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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _367 = fast::normalize(in.v_normal);
    float3 _370 = -fast::normalize(in.v_view);
    float3 _583;
    _583 = float3(0.0);
    float3 _409;
    for (int _582 = 0; _582 < 5; _583 = _409, _582++)
    {
        float _585;
        if (_mtl_u.u_params.z > 1.0)
        {
            _585 = 1.0 - step(_mtl_u.u_params.z, float(_582));
        }
        else
        {
            _585 = float(float(_582) == _mtl_u.u_params.w);
        }
        float3 _480 = (_mtl_u.u_view * float4(_mtl_u.u_lightPosRadius[_582].xyz, 1.0)).xyz - in.v_view;
        float3 _482 = fast::normalize(_480);
        float _531 = dot(_367, _482);
        _409 = _583 + (((((_mtl_u.u_diffuse.xyz * fast::max(0.0, _531)) + (_mtl_u.u_specular_shininess.xyz * (step(0.0, _531) * powr(fast::max(0.0, dot((_367 * (2.0 * _531)) - _482, _370)), _mtl_u.u_specular_shininess.w)))) * _mtl_u.u_lightRgbInnerR[_582].xyz) * (250.0 * powr(fast::max(length(_480), _mtl_u.u_lightPosRadius[_582].w), -2.0))) * _585);
    }
    out.bgfx_FragData0 = float4(fast::clamp(powr(abs((_mtl_u.u_ambient.xyz * _mtl_u.u_params.x) * _mtl_u.u_color.xyz), float3(0.4545454680919647216796875)) + powr(abs((_583 * _mtl_u.u_params.y) * _mtl_u.u_color.xyz), float3(0.4545454680919647216796875)), float3(0.0), float3(1.0)), _mtl_u.u_color.w);
    return out;
}

