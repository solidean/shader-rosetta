#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_atmoPlanet;
    float4x4 u_skyInvViewProj;
    float4 u_skyParams;
    float4 u_sunDirection;
    float4 u_sunRadiance;
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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_sky_view [[texture(0)]], texture2d<float> s_atmo_transmittance [[texture(1)]], sampler s_sky_viewSampler [[sampler(0)]], sampler s_atmo_transmittanceSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _612 = _mtl_u.u_skyInvViewProj * float4(in.v_texcoord0, 0.0, 1.0);
    float4 _619 = _mtl_u.u_skyInvViewProj * float4(in.v_texcoord0, 1.0, 1.0);
    float3 _635 = fast::normalize((_619.xyz / float3(_619.w)) - (_612.xyz / float3(_612.w)));
    float3 _642 = -fast::normalize(_mtl_u.u_sunDirection.xyz);
    float _1000;
    do
    {
        float2 _742 = float2(_635.xz);
        float2 _747 = float2(_642.xz);
        float _749 = length(_742);
        float _751 = length(_747);
        if ((_749 < 9.9999997473787516355514526367188e-06) || (_751 < 9.9999997473787516355514526367188e-06))
        {
            _1000 = 0.0;
            break;
        }
        float2 _762 = _742 / float2(_749);
        float2 _766 = _747 / float2(_751);
        _1000 = precise::atan2((_762.x * _766.y) - (_762.y * _766.x), dot(_762, _766));
        break;
    } while(false);
    float _648 = _635.y;
    float _796 = _mtl_u.u_skyParams.x * _mtl_u.u_skyParams.x;
    float _801 = _mtl_u.u_atmoPlanet.x * _mtl_u.u_atmoPlanet.x;
    float _804 = sqrt(fast::max(_796 - _801, 0.0));
    float _809 = acos(fast::clamp(_804 / _mtl_u.u_skyParams.x, -1.0, 1.0));
    float _811 = 3.1415927410125732421875 - _809;
    float _814 = acos(fast::clamp(_648, -1.0, 1.0));
    float _1001;
    if (_814 < _811)
    {
        _1001 = (1.0 - sqrt(1.0 - (_814 / _811))) * 0.5;
    }
    else
    {
        _1001 = (sqrt(fast::clamp((_814 - _811) / fast::max(_809, 9.9999997473787516355514526367188e-05), 0.0, 1.0)) * 0.5) + 0.5;
    }
    float3 _653 = s_sky_view.sample(s_sky_viewSampler, float2((_1000 * 0.15915493667125701904296875) + 0.5, _1001), level(0.0)).xyz;
    float _656 = dot(_635, _642);
    float _867 = _796 * ((_648 * _648) - 1.0);
    float3 _1002;
    if (!((_648 < 0.0) && ((_867 + _801) >= 0.0)))
    {
        float _890 = _mtl_u.u_atmoPlanet.y * _mtl_u.u_atmoPlanet.y;
        float _897 = sqrt(_890 - _801);
        float _917 = _mtl_u.u_atmoPlanet.y - _mtl_u.u_skyParams.x;
        float3 _669 = s_atmo_transmittance.sample(s_atmo_transmittanceSampler, float2((fast::max(0.0, ((-_mtl_u.u_skyParams.x) * _648) + sqrt(fast::max(_867 + _890, 0.0))) - _917) / ((_804 + _897) - _917), _804 / _897), level(0.0)).xyz;
        float3 _687 = _653 + (((_mtl_u.u_sunRadiance.xyz * _669) * (_mtl_u.u_skyParams.z * 0.02999999932944774627685546875)) * exp2((_656 - 1.0) * 12000.0));
        float3 _1003;
        if (_656 >= _mtl_u.u_skyParams.y)
        {
            _1003 = _687 + (((_mtl_u.u_sunRadiance.xyz * _mtl_u.u_skyParams.z) * _669) * powr(fast::max(1.0 - fast::clamp((1.0 - _656) / fast::max(1.0 - _mtl_u.u_skyParams.y, 1.0000000116860974230803549289703e-07), 0.0, 1.0), 0.0), 0.300000011920928955078125));
        }
        else
        {
            _1003 = _687;
        }
        _1002 = _1003;
    }
    else
    {
        _1002 = _653;
    }
    float3 _971 = _1002 * 1.60000002384185791015625;
    out.bgfx_FragData0 = float4(fast::clamp((_971 * ((_971 * 2.5099999904632568359375) + float3(0.02999999932944774627685546875))) / ((_971 * ((_971 * 2.4300000667572021484375) + float3(0.589999973773956298828125))) + float3(0.14000000059604644775390625)), float3(0.0), float3(1.0)), 1.0);
    return out;
}

