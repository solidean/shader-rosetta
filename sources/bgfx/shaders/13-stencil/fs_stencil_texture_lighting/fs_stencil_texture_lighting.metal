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

constant float _700 = {};

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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_texColor [[texture(0)]], sampler s_texColorSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _439 = fast::normalize(in.v_normal);
    float3 _442 = -fast::normalize(in.v_view);
    float3 _693;
    _693 = float3(0.0);
    float3 _481;
    for (int _692 = 0; _692 < 5; _693 = _481, _692++)
    {
        float _695;
        if (_mtl_u.u_params.z > 1.0)
        {
            _695 = 1.0 - step(_mtl_u.u_params.z, float(_692));
        }
        else
        {
            _695 = float(float(_692) == _mtl_u.u_params.w);
        }
        float3 _554 = (_mtl_u.u_view * float4(_mtl_u.u_lightPosRadius[_692].xyz, 1.0)).xyz - in.v_view;
        float3 _556 = fast::normalize(_554);
        float _605 = dot(_439, _556);
        _481 = _693 + (((((_mtl_u.u_diffuse.xyz * fast::max(0.0, _605)) + (_mtl_u.u_specular_shininess.xyz * (step(0.0, _605) * powr(fast::max(0.0, dot((_439 * (2.0 * _605)) - _556, _442)), _mtl_u.u_specular_shininess.w)))) * _mtl_u.u_lightRgbInnerR[_692].xyz) * (250.0 * powr(fast::max(length(_554), _mtl_u.u_lightPosRadius[_692].w), -2.0))) * _695);
    }
    float3 _494 = float4(powr(abs(s_texColor.sample(s_texColorSampler, in.v_texcoord0).xyz), float3(2.2000000476837158203125)), _700).xyz;
    out.bgfx_FragData0 = float4(fast::clamp(powr(abs((_mtl_u.u_ambient.xyz * _mtl_u.u_params.x) * _494), float3(0.4545454680919647216796875)) + powr(abs((_693 * _mtl_u.u_params.y) * _494), float3(0.4545454680919647216796875)), float3(0.0), float3(1.0)), _mtl_u.u_color.w);
    return out;
}

