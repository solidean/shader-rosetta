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
    float2 _1153 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
    float2 _1159 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
    float2 _1165 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
    float _2377;
    float3 _2381;
    if (all(_1153 < float2(0.9900000095367431640625)) && all(_1153 > float2(0.00999999977648258209228515625)))
    {
        float _1218 = (all(_1153 > float2(0.0)) && all(_1153 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
        float _1220 = -_1218;
        float _2372;
        do
        {
            float2 _1597 = float4(_1153, in.v_texcoord1.z, 1.0).xy;
            if (any(_1597 > float2(1.0)) || any(_1597 < float2(0.0)))
            {
                _2372 = 1.0;
                break;
            }
            _2372 = fast::clamp(exp((_mtl_u.u_params1.w * _mtl_u.u_params1.z) * (dot(s_shadowMap0.sample(s_shadowMap0Sampler, _1597), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)) - (in.v_texcoord1.z - _mtl_u.u_params1.x))), 0.0, 1.0);
            break;
        } while(false);
        _2381 = float3(_1220, _1218, _1220);
        _2377 = _2372;
    }
    else
    {
        float _2378;
        float3 _2383;
        if (all(_1159 < float2(0.9900000095367431640625)) && all(_1159 > float2(0.00999999977648258209228515625)))
        {
            float _1251 = (all(_1159 > float2(0.0)) && all(_1159 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
            float _2371;
            do
            {
                float2 _1751 = float4(_1159, in.v_texcoord2.z, 1.0).xy;
                if (any(_1751 > float2(1.0)) || any(_1751 < float2(0.0)))
                {
                    _2371 = 1.0;
                    break;
                }
                _2371 = fast::clamp(exp((_mtl_u.u_params1.w * _mtl_u.u_params1.z) * (dot(s_shadowMap1.sample(s_shadowMap1Sampler, _1751), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)) - (in.v_texcoord2.z - _mtl_u.u_params1.x))), 0.0, 1.0);
                break;
            } while(false);
            _2383 = float3(_1251, _1251, -_1251);
            _2378 = _2371;
        }
        else
        {
            float _2379;
            float3 _2385;
            if (all(_1165 < float2(0.9900000095367431640625)) && all(_1165 > float2(0.00999999977648258209228515625)))
            {
                float _1284 = (all(_1165 > float2(0.0)) && all(_1165 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1286 = -_1284;
                float _2370;
                do
                {
                    float2 _1905 = float4(_1165, in.v_texcoord3.z, 1.0).xy;
                    if (any(_1905 > float2(1.0)) || any(_1905 < float2(0.0)))
                    {
                        _2370 = 1.0;
                        break;
                    }
                    _2370 = fast::clamp(exp((_mtl_u.u_params1.w * _mtl_u.u_params1.z) * (dot(s_shadowMap2.sample(s_shadowMap2Sampler, _1905), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)) - (in.v_texcoord3.z - _mtl_u.u_params1.x))), 0.0, 1.0);
                    break;
                } while(false);
                _2385 = float3(_1286, _1286, _1284);
                _2379 = _2370;
            }
            else
            {
                float2 _1315 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1317 = (all(_1315 > float2(0.0)) && all(_1315 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1320 = -_1317;
                float _2369;
                do
                {
                    float2 _2059 = float4(_1315, in.v_texcoord4.z, 1.0).xy;
                    if (any(_2059 > float2(1.0)) || any(_2059 < float2(0.0)))
                    {
                        _2369 = 1.0;
                        break;
                    }
                    _2369 = fast::clamp(exp((_mtl_u.u_params1.w * _mtl_u.u_params1.z) * (dot(s_shadowMap3.sample(s_shadowMap3Sampler, _2059), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)) - (in.v_texcoord4.z - _mtl_u.u_params1.x))), 0.0, 1.0);
                    break;
                } while(false);
                _2385 = float3(_1317, _1320, _1320);
                _2379 = _2369;
            }
            _2383 = _2385;
            _2378 = _2379;
        }
        _2381 = _2383;
        _2377 = _2378;
    }
    float _2373;
    float3 _2374;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _2157 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _2161 = fast::normalize(_2157);
        float _2194 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _2176 = length(_2157);
        _2374 = _2161;
        _2373 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _2176)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _2176) * _2176))) * mix(fast::clamp((fast::max(0.0, dot(-_2161, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _2194) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _2194), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _2374 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _2373 = 1.0;
    }
    float _2241 = dot(in.v_normal, _2374);
    float2 _1372 = fast::max(float2(_2241, ((step(0.0, _2241) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _2241)) - _2374, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _2373;
    float _1380 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1372.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1372.y)) * _mtl_u.u_color.xyz) * _2377))), float3(0.4545454680919647216796875)) + (_2381 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1380) * _1380) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

