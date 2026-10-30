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
    float2 _1165 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
    float2 _1171 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
    float2 _1177 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
    float _2409;
    float3 _2413;
    if (all(_1165 < float2(0.9900000095367431640625)) && all(_1165 > float2(0.00999999977648258209228515625)))
    {
        float _1230 = (all(_1165 > float2(0.0)) && all(_1165 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
        float _1232 = -_1230;
        float _2404;
        do
        {
            float2 _1616 = float4(_1165, in.v_texcoord1.z, 1.0).xy;
            if (any(_1616 > float2(1.0)) || any(_1616 < float2(0.0)))
            {
                _2404 = 1.0;
                break;
            }
            _2404 = step(in.v_texcoord1.z - _mtl_u.u_params1.x, dot(s_shadowMap0.sample(s_shadowMap0Sampler, _1616, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
            break;
        } while(false);
        _2413 = float3(_1232, _1230, _1232);
        _2409 = _2404;
    }
    else
    {
        float _2410;
        float3 _2415;
        if (all(_1171 < float2(0.9900000095367431640625)) && all(_1171 > float2(0.00999999977648258209228515625)))
        {
            float _1263 = (all(_1171 > float2(0.0)) && all(_1171 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
            float _2403;
            do
            {
                float2 _1775 = float4(_1171, in.v_texcoord2.z, 1.0).xy;
                if (any(_1775 > float2(1.0)) || any(_1775 < float2(0.0)))
                {
                    _2403 = 1.0;
                    break;
                }
                _2403 = step(in.v_texcoord2.z - _mtl_u.u_params1.x, dot(s_shadowMap1.sample(s_shadowMap1Sampler, _1775, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                break;
            } while(false);
            _2415 = float3(_1263, _1263, -_1263);
            _2410 = _2403;
        }
        else
        {
            float _2411;
            float3 _2417;
            if (all(_1177 < float2(0.9900000095367431640625)) && all(_1177 > float2(0.00999999977648258209228515625)))
            {
                float _1296 = (all(_1177 > float2(0.0)) && all(_1177 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1298 = -_1296;
                float _2402;
                do
                {
                    float2 _1934 = float4(_1177, in.v_texcoord3.z, 1.0).xy;
                    if (any(_1934 > float2(1.0)) || any(_1934 < float2(0.0)))
                    {
                        _2402 = 1.0;
                        break;
                    }
                    _2402 = step(in.v_texcoord3.z - _mtl_u.u_params1.x, dot(s_shadowMap2.sample(s_shadowMap2Sampler, _1934, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                    break;
                } while(false);
                _2417 = float3(_1298, _1298, _1296);
                _2411 = _2402;
            }
            else
            {
                float2 _1327 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1329 = (all(_1327 > float2(0.0)) && all(_1327 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1332 = -_1329;
                float _2401;
                do
                {
                    float2 _2093 = float4(_1327, in.v_texcoord4.z, 1.0).xy;
                    if (any(_2093 > float2(1.0)) || any(_2093 < float2(0.0)))
                    {
                        _2401 = 1.0;
                        break;
                    }
                    _2401 = step(in.v_texcoord4.z - _mtl_u.u_params1.x, dot(s_shadowMap3.sample(s_shadowMap3Sampler, _2093, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                    break;
                } while(false);
                _2417 = float3(_1329, _1332, _1332);
                _2411 = _2401;
            }
            _2415 = _2417;
            _2410 = _2411;
        }
        _2413 = _2415;
        _2409 = _2410;
    }
    float _2405;
    float3 _2406;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _2189 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _2193 = fast::normalize(_2189);
        float _2226 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _2208 = length(_2189);
        _2406 = _2193;
        _2405 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _2208)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _2208) * _2208))) * mix(fast::clamp((fast::max(0.0, dot(-_2193, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _2226) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _2226), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _2406 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _2405 = 1.0;
    }
    float _2273 = dot(in.v_normal, _2406);
    float2 _1384 = fast::max(float2(_2273, ((step(0.0, _2273) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _2273)) - _2406, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _2405;
    float _1392 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1384.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1384.y)) * _mtl_u.u_color.xyz) * _2409))), float3(0.4545454680919647216796875)) + (_2413 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1392) * _1392) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

