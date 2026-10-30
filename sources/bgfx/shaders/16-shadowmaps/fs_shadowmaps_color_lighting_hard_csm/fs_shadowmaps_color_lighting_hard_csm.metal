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
    float2 _1155 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
    float2 _1161 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
    float2 _1167 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
    float _2359;
    float3 _2363;
    if (all(_1155 < float2(0.9900000095367431640625)) && all(_1155 > float2(0.00999999977648258209228515625)))
    {
        float _1220 = (all(_1155 > float2(0.0)) && all(_1155 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
        float _1222 = -_1220;
        float _2354;
        do
        {
            if (any(_1155 > float2(1.0)) || any(_1155 < float2(0.0)))
            {
                _2354 = 1.0;
                break;
            }
            _2354 = step((in.v_texcoord1.z - _mtl_u.u_params1.x) / in.v_texcoord1.w, dot(s_shadowMap0.sample(s_shadowMap0Sampler, _1155, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
            break;
        } while(false);
        _2363 = float3(_1222, _1220, _1222);
        _2359 = _2354;
    }
    else
    {
        float _2360;
        float3 _2365;
        if (all(_1161 < float2(0.9900000095367431640625)) && all(_1161 > float2(0.00999999977648258209228515625)))
        {
            float _1253 = (all(_1161 > float2(0.0)) && all(_1161 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
            float _2353;
            do
            {
                if (any(_1161 > float2(1.0)) || any(_1161 < float2(0.0)))
                {
                    _2353 = 1.0;
                    break;
                }
                _2353 = step((in.v_texcoord2.z - _mtl_u.u_params1.x) / in.v_texcoord2.w, dot(s_shadowMap1.sample(s_shadowMap1Sampler, _1161, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                break;
            } while(false);
            _2365 = float3(_1253, _1253, -_1253);
            _2360 = _2353;
        }
        else
        {
            float _2361;
            float3 _2367;
            if (all(_1167 < float2(0.9900000095367431640625)) && all(_1167 > float2(0.00999999977648258209228515625)))
            {
                float _1286 = (all(_1167 > float2(0.0)) && all(_1167 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1288 = -_1286;
                float _2352;
                do
                {
                    if (any(_1167 > float2(1.0)) || any(_1167 < float2(0.0)))
                    {
                        _2352 = 1.0;
                        break;
                    }
                    _2352 = step((in.v_texcoord3.z - _mtl_u.u_params1.x) / in.v_texcoord3.w, dot(s_shadowMap2.sample(s_shadowMap2Sampler, _1167, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                    break;
                } while(false);
                _2367 = float3(_1288, _1288, _1286);
                _2361 = _2352;
            }
            else
            {
                float2 _1317 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1319 = (all(_1317 > float2(0.0)) && all(_1317 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1322 = -_1319;
                float _2351;
                do
                {
                    if (any(_1317 > float2(1.0)) || any(_1317 < float2(0.0)))
                    {
                        _2351 = 1.0;
                        break;
                    }
                    _2351 = step((in.v_texcoord4.z - _mtl_u.u_params1.x) / in.v_texcoord4.w, dot(s_shadowMap3.sample(s_shadowMap3Sampler, _1317, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                    break;
                } while(false);
                _2367 = float3(_1319, _1322, _1322);
                _2361 = _2351;
            }
            _2365 = _2367;
            _2360 = _2361;
        }
        _2363 = _2365;
        _2359 = _2360;
    }
    float _2355;
    float3 _2356;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _2139 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _2143 = fast::normalize(_2139);
        float _2176 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _2158 = length(_2139);
        _2356 = _2143;
        _2355 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _2158)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _2158) * _2158))) * mix(fast::clamp((fast::max(0.0, dot(-_2143, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _2176) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _2176), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _2356 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _2355 = 1.0;
    }
    float _2223 = dot(in.v_normal, _2356);
    float2 _1374 = fast::max(float2(_2223, ((step(0.0, _2223) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _2223)) - _2356, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _2355;
    float _1382 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1374.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1374.y)) * _mtl_u.u_color.xyz) * _2359))), float3(0.4545454680919647216796875)) + (_2363 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1382) * _1382) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

