#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[12];
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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texturecube<float> s_texCube [[texture(0)]], texturecube<float> s_texCubeIrr [[texture(1)]], sampler s_texCubeSampler [[sampler(0)]], sampler s_texCubeIrrSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _690 = fast::normalize(_mtl_u.u_params[10].xyz);
    float3 _695 = fast::normalize(in.v_normal);
    float3 _697 = fast::normalize(in.v_view);
    float3 _701 = fast::normalize(_697 + _690);
    float _705 = fast::clamp(dot(_695, _697), 0.0, 1.0);
    float _709 = fast::clamp(dot(_695, _690), 0.0, 1.0);
    float3 _1095;
    if (0.0 == _mtl_u.u_params[5].x)
    {
        _1095 = mix(float3(0.039999999105930328369140625), _mtl_u.u_params[8].xyz, float3(_mtl_u.u_params[4].y));
    }
    else
    {
        _1095 = _mtl_u.u_params[9].xyz * float3(_mtl_u.u_params[4].y);
    }
    float3 _745 = _mtl_u.u_params[8].xyz * (1.0 - _mtl_u.u_params[4].y);
    float3 _884 = float3(1.0) - _1095;
    float3 _891 = _1095 + ((_884 * powr(1.0 - fast::clamp(dot(_701, _697), 0.0, 1.0), 5.0)) * _mtl_u.u_params[4].x);
    float _915 = exp2((10.0 * _mtl_u.u_params[4].x) + 2.0);
    float _781 = 1.0 + (5.0 * (1.0 - _mtl_u.u_params[4].x));
    float4x4 _960 = transpose(float4x4(_mtl_u.u_params[0], _mtl_u.u_params[1], _mtl_u.u_params[2], _mtl_u.u_params[3]));
    float3 _805 = fast::normalize((float4((_695 * (2.0 * _705)) - _697, 0.0) * _960).xyz);
    float _969 = _805.x;
    float _970 = abs(_969);
    float _973 = abs(_805.y);
    float _976 = abs(_805.z);
    float _981 = fast::max(fast::max(_970, _973), _976);
    float _986 = 1.0 - (exp2(_781) * 0.00390625);
    float3 _1125;
    if (_970 != _981)
    {
        float3 _1110 = _805;
        _1110.x = _969 * _986;
        _1125 = _1110;
    }
    else
    {
        _1125 = _805;
    }
    float3 _1126;
    if (_973 != _981)
    {
        float3 _1113 = _1125;
        _1113.y = _1125.y * _986;
        _1126 = _1113;
    }
    else
    {
        _1126 = _1125;
    }
    float3 _1127;
    if (_976 != _981)
    {
        float3 _1116 = _1126;
        _1116.z = _1126.z * _986;
        _1127 = _1116;
    }
    else
    {
        _1127 = _1126;
    }
    float3 _1065 = (((((((_745 * (float3(1.0) - _891)) * _709) * _mtl_u.u_params[6].x) + ((_891 * ((powr(fast::clamp(dot(_695, _701), 0.0, 1.0), _915) * _709) * ((_915 + 8.0) * 0.125))) * _mtl_u.u_params[6].y)) * _mtl_u.u_params[11].xyz) + (((_745 * powr(abs(s_texCubeIrr.sample(s_texCubeIrrSampler, fast::normalize((float4(_695, 0.0) * _960).xyz)).xyz), float3(2.2000000476837158203125))) * _mtl_u.u_params[6].z) + (((_1095 + ((_884 * powr(1.0 - _705, 5.0)) * _mtl_u.u_params[4].x)) * powr(abs(s_texCube.sample(s_texCubeSampler, _1127, level(_781)).xyz), float3(2.2000000476837158203125))) * _mtl_u.u_params[6].w))) * exp2(_mtl_u.u_params[4].z)) - float3(0.0040000001899898052215576171875);
    float3 _1066 = fast::max(float3(0.0), _1065);
    float3 _1069 = _1066 * 6.19999980926513671875;
    out.bgfx_FragData0 = float4((_1066 * (_1069 + float3(0.5))) / ((_1066 * (_1069 + float3(1.7000000476837158203125))) + float3(0.0599999986588954925537109375)), 1.0);
    return out;
}

