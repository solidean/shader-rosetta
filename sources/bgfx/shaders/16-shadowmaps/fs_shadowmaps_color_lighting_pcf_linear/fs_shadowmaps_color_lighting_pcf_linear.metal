#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL radians() function
template<typename T>
inline T radians(T d)
{
    return d * T(0.01745329251);
}

struct _Global
{
    float4 u_params1;
    float4 u_params2;
    float4 u_color;
    float4 u_materialKa;
    float4 u_materialKd;
    float4 u_materialKs;
    float4 u_lightPosition;
    float4 u_lightAmbientPower;
    float4 u_lightDiffusePower;
    float4 u_lightSpecularPower;
    float4 u_lightSpotDirectionInner;
    float4 u_lightAttenuationSpotOuter;
    float4 u_smSamplingParams;
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
    float4 v_shadowcoord [[user(locn1)]];
    float3 v_view [[user(locn2)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_shadowMap0 [[texture(4)]], sampler s_shadowMap0Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float2 _1043 = in.v_shadowcoord.xy / float2(in.v_shadowcoord.w);
    float _1045 = (all(_1043 > float2(0.0)) && all(_1043 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
    float _1048 = -_1045;
    float4 _1221 = float4(_1043, in.v_shadowcoord.z, 1.0);
    float _1247 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
    float _1249 = sin(_1247);
    float _1251 = cos(_1247);
    float2 _1290 = ((float2(2.0) * _mtl_u.u_smSamplingParams.zw) * float2(_mtl_u.u_params2.z)) * 1.0;
    float _1711;
    _1711 = 0.0;
    float _1333;
    for (int _1710 = 0; _1710 < 16; _1711 = _1333, _1710++)
    {
        float _1352 = float(_1710);
        float _1360 = _1352 * 2.3999631404876708984375;
        float2 _1367 = float2(cos(_1360), sin(_1360)) * sqrt((_1352 + 0.5) * 0.100000001490116119384765625);
        float _1371 = _1367.x;
        float _1376 = _1367.y;
        float4 _1327 = _1221 + float4(float2((_1371 * _1251) - (_1376 * _1249), (_1371 * _1249) + (_1376 * _1251)) * _1290, 0.0, 0.0);
        float _1715;
        do
        {
            float _1416 = _1327.w;
            float2 _1418 = _1327.xy / float2(_1416);
            if (any(_1418 > float2(1.0)) || any(_1418 < float2(0.0)))
            {
                _1715 = 1.0;
                break;
            }
            _1715 = step((_1327.z - _mtl_u.u_params1.x) / _1416, dot(s_shadowMap0.sample(s_shadowMap0Sampler, _1418, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
            break;
        } while(false);
        _1333 = _1711 + _1715;
    }
    float _1712;
    float3 _1713;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _1510 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _1514 = fast::normalize(_1510);
        float _1547 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _1529 = length(_1510);
        _1713 = _1514;
        _1712 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _1529)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _1529) * _1529))) * mix(fast::clamp((fast::max(0.0, dot(-_1514, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _1547) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _1547), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _1713 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _1712 = 1.0;
    }
    float _1594 = dot(in.v_normal, _1713);
    float2 _1095 = fast::max(float2(_1594, ((step(0.0, _1594) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _1594)) - _1713, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _1712;
    float _1103 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1095.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1095.y)) * _mtl_u.u_color.xyz) * (_1711 * 0.0625)))), float3(0.4545454680919647216796875)) + (float3(_1045, _1048, _1048) * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1103) * _1103) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

