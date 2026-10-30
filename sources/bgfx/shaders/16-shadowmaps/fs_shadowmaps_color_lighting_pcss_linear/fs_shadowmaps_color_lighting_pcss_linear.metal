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
    float2 _1195 = in.v_shadowcoord.xy / float2(in.v_shadowcoord.w);
    float _1197 = (all(_1195 > float2(0.0)) && all(_1195 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
    float _1200 = -_1197;
    float4 _1373 = float4(_1195, in.v_shadowcoord.z, 1.0);
    float _2087;
    do
    {
        float _1429 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
        float _1431 = sin(_1429);
        float _1433 = cos(_1429);
        float _1441 = in.v_shadowcoord.z - _mtl_u.u_params1.x;
        float2 _1526 = _1373.xy;
        int _2076;
        float _2077;
        _2077 = 0.0;
        _2076 = 0;
        int _2092;
        float _2093;
        for (int _2075 = 0; _2075 < 16; _2077 = _2093, _2076 = _2092, _2075++)
        {
            float _1600 = float(_2075);
            float _1608 = _1600 * 2.3999631404876708984375;
            float2 _1615 = float2(cos(_1608), sin(_1608)) * sqrt((_1600 + 0.5) * 0.100000001490116119384765625);
            float _1619 = _1615.x;
            float _1624 = _1615.y;
            float4 _1649 = s_shadowMap0.sample(s_shadowMap0Sampler, (_1526 + (float2((_1619 * _1433) - (_1624 * _1431), (_1619 * _1431) + (_1624 * _1433)) * float2(0.00999999977648258209228515625))));
            float _1653 = dot(_1649, float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0));
            if (_1653 < _1441)
            {
                _2093 = _2077 + _1653;
                _2092 = _2076 + 1;
            }
            else
            {
                _2093 = _2077;
                _2092 = _2076;
            }
        }
        float _2079;
        if (_2076 > 0)
        {
            _2079 = _2077 / float(_2076);
        }
        else
        {
            _2079 = -1.0;
        }
        if (_2079 < (-0.9900000095367431640625))
        {
            _2087 = 1.0;
            break;
        }
        float _1461 = fast::max(0.0, _1441 - _2079);
        float2 _1481 = float2(fast::clamp((_mtl_u.u_smSamplingParams.z * _1461) / _2079, 0.0, 0.25), fast::clamp((_mtl_u.u_smSamplingParams.w * _1461) / _2079, 0.0, 0.25));
        float _2083;
        _2083 = 0.0;
        float _1688;
        for (int _2082 = 0; _2082 < 16; _2083 = _1688, _2082++)
        {
            float _1707 = float(_2082);
            float _1715 = _1707 * 2.3999631404876708984375;
            float2 _1722 = float2(cos(_1715), sin(_1715)) * sqrt((_1707 + 0.5) * 0.100000001490116119384765625);
            float _1726 = _1722.x;
            float _1731 = _1722.y;
            float4 _1682 = _1373 + float4(float2((_1726 * _1433) - (_1731 * _1431), (_1726 * _1431) + (_1731 * _1433)) * _1481, 0.0, 0.0);
            float _2084;
            do
            {
                float _1771 = _1682.w;
                float2 _1773 = _1682.xy / float2(_1771);
                if (any(_1773 > float2(1.0)) || any(_1773 < float2(0.0)))
                {
                    _2084 = 1.0;
                    break;
                }
                _2084 = step((_1682.z - _mtl_u.u_params1.x) / _1771, dot(s_shadowMap0.sample(s_shadowMap0Sampler, _1773, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                break;
            } while(false);
            _1688 = _2083 + _2084;
        }
        _2087 = mix(1.0, _2083 * 0.0625, smoothstep(0.0, 0.25, float(_2076) * 0.0625));
        break;
    } while(false);
    float _2088;
    float3 _2089;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _1871 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _1875 = fast::normalize(_1871);
        float _1908 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _1890 = length(_1871);
        _2089 = _1875;
        _2088 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _1890)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _1890) * _1890))) * mix(fast::clamp((fast::max(0.0, dot(-_1875, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _1908) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _1908), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _2089 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _2088 = 1.0;
    }
    float _1955 = dot(in.v_normal, _2089);
    float2 _1247 = fast::max(float2(_1955, ((step(0.0, _1955) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _1955)) - _2089, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _2088;
    float _1255 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1247.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1247.y)) * _mtl_u.u_color.xyz) * _2087))), float3(0.4545454680919647216796875)) + (float3(_1197, _1200, _1200) * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1255) * _1255) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

