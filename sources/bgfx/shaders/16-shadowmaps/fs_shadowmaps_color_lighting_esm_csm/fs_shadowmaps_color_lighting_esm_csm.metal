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
    float2 _1143 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
    float2 _1149 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
    float2 _1155 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
    float _2327;
    float3 _2331;
    if (all(_1143 < float2(0.9900000095367431640625)) && all(_1143 > float2(0.00999999977648258209228515625)))
    {
        float _1208 = (all(_1143 > float2(0.0)) && all(_1143 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
        float _1210 = -_1208;
        float _2322;
        do
        {
            if (any(_1143 > float2(1.0)) || any(_1143 < float2(0.0)))
            {
                _2322 = 1.0;
                break;
            }
            _2322 = fast::clamp(exp((_mtl_u.u_params1.w * _mtl_u.u_params1.z) * (dot(s_shadowMap0.sample(s_shadowMap0Sampler, _1143), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)) - ((in.v_texcoord1.z - _mtl_u.u_params1.x) / in.v_texcoord1.w))), 0.0, 1.0);
            break;
        } while(false);
        _2331 = float3(_1210, _1208, _1210);
        _2327 = _2322;
    }
    else
    {
        float _2328;
        float3 _2333;
        if (all(_1149 < float2(0.9900000095367431640625)) && all(_1149 > float2(0.00999999977648258209228515625)))
        {
            float _1241 = (all(_1149 > float2(0.0)) && all(_1149 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
            float _2321;
            do
            {
                if (any(_1149 > float2(1.0)) || any(_1149 < float2(0.0)))
                {
                    _2321 = 1.0;
                    break;
                }
                _2321 = fast::clamp(exp((_mtl_u.u_params1.w * _mtl_u.u_params1.z) * (dot(s_shadowMap1.sample(s_shadowMap1Sampler, _1149), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)) - ((in.v_texcoord2.z - _mtl_u.u_params1.x) / in.v_texcoord2.w))), 0.0, 1.0);
                break;
            } while(false);
            _2333 = float3(_1241, _1241, -_1241);
            _2328 = _2321;
        }
        else
        {
            float _2329;
            float3 _2335;
            if (all(_1155 < float2(0.9900000095367431640625)) && all(_1155 > float2(0.00999999977648258209228515625)))
            {
                float _1274 = (all(_1155 > float2(0.0)) && all(_1155 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1276 = -_1274;
                float _2320;
                do
                {
                    if (any(_1155 > float2(1.0)) || any(_1155 < float2(0.0)))
                    {
                        _2320 = 1.0;
                        break;
                    }
                    _2320 = fast::clamp(exp((_mtl_u.u_params1.w * _mtl_u.u_params1.z) * (dot(s_shadowMap2.sample(s_shadowMap2Sampler, _1155), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)) - ((in.v_texcoord3.z - _mtl_u.u_params1.x) / in.v_texcoord3.w))), 0.0, 1.0);
                    break;
                } while(false);
                _2335 = float3(_1276, _1276, _1274);
                _2329 = _2320;
            }
            else
            {
                float2 _1305 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1307 = (all(_1305 > float2(0.0)) && all(_1305 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1310 = -_1307;
                float _2319;
                do
                {
                    if (any(_1305 > float2(1.0)) || any(_1305 < float2(0.0)))
                    {
                        _2319 = 1.0;
                        break;
                    }
                    _2319 = fast::clamp(exp((_mtl_u.u_params1.w * _mtl_u.u_params1.z) * (dot(s_shadowMap3.sample(s_shadowMap3Sampler, _1305), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)) - ((in.v_texcoord4.z - _mtl_u.u_params1.x) / in.v_texcoord4.w))), 0.0, 1.0);
                    break;
                } while(false);
                _2335 = float3(_1307, _1310, _1310);
                _2329 = _2319;
            }
            _2333 = _2335;
            _2328 = _2329;
        }
        _2331 = _2333;
        _2327 = _2328;
    }
    float _2323;
    float3 _2324;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _2107 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _2111 = fast::normalize(_2107);
        float _2144 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _2126 = length(_2107);
        _2324 = _2111;
        _2323 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _2126)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _2126) * _2126))) * mix(fast::clamp((fast::max(0.0, dot(-_2111, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _2144) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _2144), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _2324 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _2323 = 1.0;
    }
    float _2191 = dot(in.v_normal, _2324);
    float2 _1362 = fast::max(float2(_2191, ((step(0.0, _2191) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _2191)) - _2324, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _2323;
    float _1370 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1362.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1362.y)) * _mtl_u.u_color.xyz) * _2327))), float3(0.4545454680919647216796875)) + (_2331 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1370) * _1370) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

