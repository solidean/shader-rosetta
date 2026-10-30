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
    float2 _1186 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
    float2 _1192 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
    float2 _1198 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
    float _2562;
    float3 _2566;
    if (all(_1186 < float2(0.9900000095367431640625)) && all(_1186 > float2(0.00999999977648258209228515625)))
    {
        float _1251 = (all(_1186 > float2(0.0)) && all(_1186 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
        float _1253 = -_1251;
        float _2557;
        do
        {
            float2 _1634 = float4(_1186, in.v_texcoord1.z, 1.0).xy;
            if (any(_1634 > float2(1.0)) || any(_1634 < float2(0.0)))
            {
                _2557 = 1.0;
                break;
            }
            float _1659 = (in.v_texcoord1.z - _mtl_u.u_params1.x) * _mtl_u.u_params1.w;
            float4 _1728 = s_shadowMap0.sample(s_shadowMap0Sampler, _1634);
            float2 _1671 = float2(dot(_1728.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_1728.zw, float2(0.0039215688593685626983642578125, 1.0))) * _mtl_u.u_params1.w;
            float _1674 = _1671.x;
            if (_1659 < _1674)
            {
                _2557 = 1.0;
                break;
            }
            float _1687 = fast::max(_1671.y - (_1674 * _1674), _mtl_u.u_params1.z);
            float _1691 = _1659 - _1674;
            _2557 = _1687 / (_1687 + (_1691 * _1691));
            break;
        } while(false);
        _2566 = float3(_1253, _1251, _1253);
        _2562 = _2557;
    }
    else
    {
        float _2563;
        float3 _2568;
        if (all(_1192 < float2(0.9900000095367431640625)) && all(_1192 > float2(0.00999999977648258209228515625)))
        {
            float _1284 = (all(_1192 > float2(0.0)) && all(_1192 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
            float _2556;
            do
            {
                float2 _1826 = float4(_1192, in.v_texcoord2.z, 1.0).xy;
                if (any(_1826 > float2(1.0)) || any(_1826 < float2(0.0)))
                {
                    _2556 = 1.0;
                    break;
                }
                float _1851 = (in.v_texcoord2.z - _mtl_u.u_params1.x) * _mtl_u.u_params1.w;
                float4 _1920 = s_shadowMap1.sample(s_shadowMap1Sampler, _1826);
                float2 _1863 = float2(dot(_1920.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_1920.zw, float2(0.0039215688593685626983642578125, 1.0))) * _mtl_u.u_params1.w;
                float _1866 = _1863.x;
                if (_1851 < _1866)
                {
                    _2556 = 1.0;
                    break;
                }
                float _1879 = fast::max(_1863.y - (_1866 * _1866), _mtl_u.u_params1.z);
                float _1883 = _1851 - _1866;
                _2556 = _1879 / (_1879 + (_1883 * _1883));
                break;
            } while(false);
            _2568 = float3(_1284, _1284, -_1284);
            _2563 = _2556;
        }
        else
        {
            float _2564;
            float3 _2570;
            if (all(_1198 < float2(0.9900000095367431640625)) && all(_1198 > float2(0.00999999977648258209228515625)))
            {
                float _1317 = (all(_1198 > float2(0.0)) && all(_1198 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1319 = -_1317;
                float _2555;
                do
                {
                    float2 _2018 = float4(_1198, in.v_texcoord3.z, 1.0).xy;
                    if (any(_2018 > float2(1.0)) || any(_2018 < float2(0.0)))
                    {
                        _2555 = 1.0;
                        break;
                    }
                    float _2043 = (in.v_texcoord3.z - _mtl_u.u_params1.x) * _mtl_u.u_params1.w;
                    float4 _2112 = s_shadowMap2.sample(s_shadowMap2Sampler, _2018);
                    float2 _2055 = float2(dot(_2112.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_2112.zw, float2(0.0039215688593685626983642578125, 1.0))) * _mtl_u.u_params1.w;
                    float _2058 = _2055.x;
                    if (_2043 < _2058)
                    {
                        _2555 = 1.0;
                        break;
                    }
                    float _2071 = fast::max(_2055.y - (_2058 * _2058), _mtl_u.u_params1.z);
                    float _2075 = _2043 - _2058;
                    _2555 = _2071 / (_2071 + (_2075 * _2075));
                    break;
                } while(false);
                _2570 = float3(_1319, _1319, _1317);
                _2564 = _2555;
            }
            else
            {
                float2 _1348 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1350 = (all(_1348 > float2(0.0)) && all(_1348 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1353 = -_1350;
                float _2554;
                do
                {
                    float2 _2210 = float4(_1348, in.v_texcoord4.z, 1.0).xy;
                    if (any(_2210 > float2(1.0)) || any(_2210 < float2(0.0)))
                    {
                        _2554 = 1.0;
                        break;
                    }
                    float _2235 = (in.v_texcoord4.z - _mtl_u.u_params1.x) * _mtl_u.u_params1.w;
                    float4 _2304 = s_shadowMap3.sample(s_shadowMap3Sampler, _2210);
                    float2 _2247 = float2(dot(_2304.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_2304.zw, float2(0.0039215688593685626983642578125, 1.0))) * _mtl_u.u_params1.w;
                    float _2250 = _2247.x;
                    if (_2235 < _2250)
                    {
                        _2554 = 1.0;
                        break;
                    }
                    float _2263 = fast::max(_2247.y - (_2250 * _2250), _mtl_u.u_params1.z);
                    float _2267 = _2235 - _2250;
                    _2554 = _2263 / (_2263 + (_2267 * _2267));
                    break;
                } while(false);
                _2570 = float3(_1350, _1353, _1353);
                _2564 = _2554;
            }
            _2568 = _2570;
            _2563 = _2564;
        }
        _2566 = _2568;
        _2562 = _2563;
    }
    float _2558;
    float3 _2559;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _2342 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _2346 = fast::normalize(_2342);
        float _2379 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _2361 = length(_2342);
        _2559 = _2346;
        _2558 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _2361)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _2361) * _2361))) * mix(fast::clamp((fast::max(0.0, dot(-_2346, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _2379) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _2379), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _2559 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _2558 = 1.0;
    }
    float _2426 = dot(in.v_normal, _2559);
    float2 _1405 = fast::max(float2(_2426, ((step(0.0, _2426) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _2426)) - _2559, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _2558;
    float _1413 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1405.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1405.y)) * _mtl_u.u_color.xyz) * _2562))), float3(0.4545454680919647216796875)) + (_2566 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1413) * _1413) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

