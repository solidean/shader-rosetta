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
    float4 v_texcoord1 [[user(locn2)]];
    float4 v_texcoord2 [[user(locn3)]];
    float4 v_texcoord3 [[user(locn4)]];
    float4 v_texcoord4 [[user(locn5)]];
    float3 v_view [[user(locn6)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_shadowMap0 [[texture(4)]], texture2d<float> s_shadowMap1 [[texture(5)]], texture2d<float> s_shadowMap2 [[texture(6)]], texture2d<float> s_shadowMap3 [[texture(7)]], sampler s_shadowMap0Sampler [[sampler(4)]], sampler s_shadowMap1Sampler [[sampler(5)]], sampler s_shadowMap2Sampler [[sampler(6)]], sampler s_shadowMap3Sampler [[sampler(7)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float2 _1176 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
    float2 _1182 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
    float2 _1188 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
    float _2512;
    float3 _2516;
    if (all(_1176 < float2(0.9900000095367431640625)) && all(_1176 > float2(0.00999999977648258209228515625)))
    {
        float _1241 = (all(_1176 > float2(0.0)) && all(_1176 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
        float _1243 = -_1241;
        float _2507;
        do
        {
            if (any(_1176 > float2(1.0)) || any(_1176 < float2(0.0)))
            {
                _2507 = 1.0;
                break;
            }
            float _1639 = ((in.v_texcoord1.z - _mtl_u.u_params1.x) / in.v_texcoord1.w) * _mtl_u.u_params1.w;
            float4 _1708 = s_shadowMap0.sample(s_shadowMap0Sampler, _1176);
            float2 _1651 = float2(dot(_1708.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_1708.zw, float2(0.0039215688593685626983642578125, 1.0))) * _mtl_u.u_params1.w;
            float _1654 = _1651.x;
            if (_1639 < _1654)
            {
                _2507 = 1.0;
                break;
            }
            float _1667 = fast::max(_1651.y - (_1654 * _1654), _mtl_u.u_params1.z);
            float _1671 = _1639 - _1654;
            _2507 = _1667 / (_1667 + (_1671 * _1671));
            break;
        } while(false);
        _2516 = float3(_1243, _1241, _1243);
        _2512 = _2507;
    }
    else
    {
        float _2513;
        float3 _2518;
        if (all(_1182 < float2(0.9900000095367431640625)) && all(_1182 > float2(0.00999999977648258209228515625)))
        {
            float _1274 = (all(_1182 > float2(0.0)) && all(_1182 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
            float _2506;
            do
            {
                if (any(_1182 > float2(1.0)) || any(_1182 < float2(0.0)))
                {
                    _2506 = 1.0;
                    break;
                }
                float _1821 = ((in.v_texcoord2.z - _mtl_u.u_params1.x) / in.v_texcoord2.w) * _mtl_u.u_params1.w;
                float4 _1890 = s_shadowMap1.sample(s_shadowMap1Sampler, _1182);
                float2 _1833 = float2(dot(_1890.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_1890.zw, float2(0.0039215688593685626983642578125, 1.0))) * _mtl_u.u_params1.w;
                float _1836 = _1833.x;
                if (_1821 < _1836)
                {
                    _2506 = 1.0;
                    break;
                }
                float _1849 = fast::max(_1833.y - (_1836 * _1836), _mtl_u.u_params1.z);
                float _1853 = _1821 - _1836;
                _2506 = _1849 / (_1849 + (_1853 * _1853));
                break;
            } while(false);
            _2518 = float3(_1274, _1274, -_1274);
            _2513 = _2506;
        }
        else
        {
            float _2514;
            float3 _2520;
            if (all(_1188 < float2(0.9900000095367431640625)) && all(_1188 > float2(0.00999999977648258209228515625)))
            {
                float _1307 = (all(_1188 > float2(0.0)) && all(_1188 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1309 = -_1307;
                float _2505;
                do
                {
                    if (any(_1188 > float2(1.0)) || any(_1188 < float2(0.0)))
                    {
                        _2505 = 1.0;
                        break;
                    }
                    float _2003 = ((in.v_texcoord3.z - _mtl_u.u_params1.x) / in.v_texcoord3.w) * _mtl_u.u_params1.w;
                    float4 _2072 = s_shadowMap2.sample(s_shadowMap2Sampler, _1188);
                    float2 _2015 = float2(dot(_2072.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_2072.zw, float2(0.0039215688593685626983642578125, 1.0))) * _mtl_u.u_params1.w;
                    float _2018 = _2015.x;
                    if (_2003 < _2018)
                    {
                        _2505 = 1.0;
                        break;
                    }
                    float _2031 = fast::max(_2015.y - (_2018 * _2018), _mtl_u.u_params1.z);
                    float _2035 = _2003 - _2018;
                    _2505 = _2031 / (_2031 + (_2035 * _2035));
                    break;
                } while(false);
                _2520 = float3(_1309, _1309, _1307);
                _2514 = _2505;
            }
            else
            {
                float2 _1338 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1340 = (all(_1338 > float2(0.0)) && all(_1338 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1343 = -_1340;
                float _2504;
                do
                {
                    if (any(_1338 > float2(1.0)) || any(_1338 < float2(0.0)))
                    {
                        _2504 = 1.0;
                        break;
                    }
                    float _2185 = ((in.v_texcoord4.z - _mtl_u.u_params1.x) / in.v_texcoord4.w) * _mtl_u.u_params1.w;
                    float4 _2254 = s_shadowMap3.sample(s_shadowMap3Sampler, _1338);
                    float2 _2197 = float2(dot(_2254.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_2254.zw, float2(0.0039215688593685626983642578125, 1.0))) * _mtl_u.u_params1.w;
                    float _2200 = _2197.x;
                    if (_2185 < _2200)
                    {
                        _2504 = 1.0;
                        break;
                    }
                    float _2213 = fast::max(_2197.y - (_2200 * _2200), _mtl_u.u_params1.z);
                    float _2217 = _2185 - _2200;
                    _2504 = _2213 / (_2213 + (_2217 * _2217));
                    break;
                } while(false);
                _2520 = float3(_1340, _1343, _1343);
                _2514 = _2504;
            }
            _2518 = _2520;
            _2513 = _2514;
        }
        _2516 = _2518;
        _2512 = _2513;
    }
    float _2508;
    float3 _2509;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _2292 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _2296 = fast::normalize(_2292);
        float _2329 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _2311 = length(_2292);
        _2509 = _2296;
        _2508 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _2311)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _2311) * _2311))) * mix(fast::clamp((fast::max(0.0, dot(-_2296, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _2329) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _2329), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _2509 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _2508 = 1.0;
    }
    float _2376 = dot(in.v_normal, _2509);
    float2 _1395 = fast::max(float2(_2376, ((step(0.0, _2376) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _2376)) - _2509, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _2508;
    float _1403 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1395.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1395.y)) * _mtl_u.u_color.xyz) * _2512))), float3(0.4545454680919647216796875)) + (_2516 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1403) * _1403) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

