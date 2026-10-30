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
    float2 _1185 = in.v_shadowcoord.xy / float2(in.v_shadowcoord.w);
    float _1187 = (all(_1185 > float2(0.0)) && all(_1185 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
    float _1190 = -_1187;
    float _2067;
    do
    {
        float _1409 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
        float _1411 = sin(_1409);
        float _1413 = cos(_1409);
        float _1421 = (in.v_shadowcoord.z / in.v_shadowcoord.w) - _mtl_u.u_params1.x;
        int _2056;
        float _2057;
        _2057 = 0.0;
        _2056 = 0;
        int _2072;
        float _2073;
        for (int _2055 = 0; _2055 < 16; _2057 = _2073, _2056 = _2072, _2055++)
        {
            float _1580 = float(_2055);
            float _1588 = _1580 * 2.3999631404876708984375;
            float2 _1595 = float2(cos(_1588), sin(_1588)) * sqrt((_1580 + 0.5) * 0.100000001490116119384765625);
            float _1599 = _1595.x;
            float _1604 = _1595.y;
            float4 _1629 = s_shadowMap0.sample(s_shadowMap0Sampler, (_1185 + (float2((_1599 * _1413) - (_1604 * _1411), (_1599 * _1411) + (_1604 * _1413)) * float2(0.00999999977648258209228515625))));
            float _1633 = dot(_1629, float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0));
            if (_1633 < _1421)
            {
                _2073 = _2057 + _1633;
                _2072 = _2056 + 1;
            }
            else
            {
                _2073 = _2057;
                _2072 = _2056;
            }
        }
        float _2059;
        if (_2056 > 0)
        {
            _2059 = _2057 / float(_2056);
        }
        else
        {
            _2059 = -1.0;
        }
        if (_2059 < (-0.9900000095367431640625))
        {
            _2067 = 1.0;
            break;
        }
        float _1441 = fast::max(0.0, _1421 - _2059);
        float2 _1461 = float2(fast::clamp((_mtl_u.u_smSamplingParams.z * _1441) / _2059, 0.0, 0.25), fast::clamp((_mtl_u.u_smSamplingParams.w * _1441) / _2059, 0.0, 0.25));
        float _2063;
        _2063 = 0.0;
        float _1668;
        for (int _2062 = 0; _2062 < 16; _2063 = _1668, _2062++)
        {
            float _1687 = float(_2062);
            float _1695 = _1687 * 2.3999631404876708984375;
            float2 _1702 = float2(cos(_1695), sin(_1695)) * sqrt((_1687 + 0.5) * 0.100000001490116119384765625);
            float _1706 = _1702.x;
            float _1711 = _1702.y;
            float4 _1662 = in.v_shadowcoord + float4(float2((_1706 * _1413) - (_1711 * _1411), (_1706 * _1411) + (_1711 * _1413)) * _1461, 0.0, 0.0);
            float _2064;
            do
            {
                float _1751 = _1662.w;
                float2 _1753 = _1662.xy / float2(_1751);
                if (any(_1753 > float2(1.0)) || any(_1753 < float2(0.0)))
                {
                    _2064 = 1.0;
                    break;
                }
                _2064 = step((_1662.z - _mtl_u.u_params1.x) / _1751, dot(s_shadowMap0.sample(s_shadowMap0Sampler, _1753, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                break;
            } while(false);
            _1668 = _2063 + _2064;
        }
        _2067 = mix(1.0, _2063 * 0.0625, smoothstep(0.0, 0.25, float(_2056) * 0.0625));
        break;
    } while(false);
    float _2068;
    float3 _2069;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _1851 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _1855 = fast::normalize(_1851);
        float _1888 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _1870 = length(_1851);
        _2069 = _1855;
        _2068 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _1870)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _1870) * _1870))) * mix(fast::clamp((fast::max(0.0, dot(-_1855, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _1888) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _1888), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _2069 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _2068 = 1.0;
    }
    float _1935 = dot(in.v_normal, _2069);
    float2 _1237 = fast::max(float2(_1935, ((step(0.0, _1935) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _1935)) - _2069, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _2068;
    float _1245 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1237.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1237.y)) * _mtl_u.u_color.xyz) * _2067))), float3(0.4545454680919647216796875)) + (float3(_1187, _1190, _1190) * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1245) * _1245) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

