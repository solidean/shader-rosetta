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
    float3 v_dir [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texturecube<float> s_texCube [[texture(0)]], texturecube<float> s_texCubeIrr [[texture(1)]], sampler s_texCubeSampler [[sampler(0)]], sampler s_texCubeIrrSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _346 = fast::normalize(in.v_dir);
    float4 _548;
    if (_mtl_u.u_params[4].w == 7.0)
    {
        float4 _386 = s_texCubeIrr.sample(s_texCubeIrrSampler, _346);
        _548 = float4(powr(abs(_386.xyz), float3(2.2000000476837158203125)), _386.w);
    }
    else
    {
        float _418 = _346.x;
        float _419 = abs(_418);
        float _422 = abs(_346.y);
        float _425 = abs(_346.z);
        float _430 = fast::max(fast::max(_419, _422), _425);
        float _435 = 1.0 - (exp2(_mtl_u.u_params[4].w) * 0.00390625);
        float3 _571;
        if (_419 != _430)
        {
            float3 _562 = _346;
            _562.x = _418 * _435;
            _571 = _562;
        }
        else
        {
            _571 = _346;
        }
        float3 _572;
        if (_422 != _430)
        {
            float3 _565 = _571;
            _565.y = _571.y * _435;
            _572 = _565;
        }
        else
        {
            _572 = _571;
        }
        float3 _573;
        if (_425 != _430)
        {
            float3 _568 = _572;
            _568.z = _572.z * _435;
            _573 = _568;
        }
        else
        {
            _573 = _572;
        }
        float4 _476 = s_texCube.sample(s_texCubeSampler, _573, level(_mtl_u.u_params[4].w));
        _548 = float4(powr(abs(_476.xyz), float3(2.2000000476837158203125)), _476.w);
    }
    float4 _371 = _548 * exp2(_mtl_u.u_params[4].z);
    float3 _519 = fast::max(float3(0.0), _371.xyz - float3(0.0040000001899898052215576171875));
    float3 _522 = _519 * 6.19999980926513671875;
    out.bgfx_FragData0 = float4((_519 * (_522 + float3(0.5))) / ((_519 * (_522 + float3(1.7000000476837158203125))) + float3(0.0599999986588954925537109375)), _371.w);
    return out;
}

