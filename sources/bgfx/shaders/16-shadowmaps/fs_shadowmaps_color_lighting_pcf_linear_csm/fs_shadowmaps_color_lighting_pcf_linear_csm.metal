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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_shadowMap0 [[texture(4)]], texture2d<float> s_shadowMap1 [[texture(5)]], texture2d<float> s_shadowMap2 [[texture(6)]], texture2d<float> s_shadowMap3 [[texture(7)]], sampler s_shadowMap0Sampler [[sampler(4)]], sampler s_shadowMap1Sampler [[sampler(5)]], sampler s_shadowMap2Sampler [[sampler(6)]], sampler s_shadowMap3Sampler [[sampler(7)]], float4 gl_FragCoord [[position]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float2 _1661 = float2(_mtl_u.u_params2.z);
    float2 _1376 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
    float2 _1382 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
    float2 _1388 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
    float _3269;
    float3 _3273;
    if (all(_1376 < float2(0.9900000095367431640625)) && all(_1376 > float2(0.00999999977648258209228515625)))
    {
        float _1441 = (all(_1376 > float2(0.0)) && all(_1376 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
        float _1443 = -_1441;
        float4 _1793 = float4(_1376, in.v_texcoord1.z, 1.0);
        float _1819 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
        float _1821 = sin(_1819);
        float _1823 = cos(_1819);
        float2 _1862 = ((float2(2.0) * _mtl_u.u_smSamplingParams.zw) * _1661) * 1.0;
        float _3264;
        _3264 = 0.0;
        float _1905;
        for (int _3263 = 0; _3263 < 16; _3264 = _1905, _3263++)
        {
            float _1924 = float(_3263);
            float _1932 = _1924 * 2.3999631404876708984375;
            float2 _1939 = float2(cos(_1932), sin(_1932)) * sqrt((_1924 + 0.5) * 0.100000001490116119384765625);
            float _1943 = _1939.x;
            float _1948 = _1939.y;
            float4 _1899 = _1793 + float4(float2((_1943 * _1823) - (_1948 * _1821), (_1943 * _1821) + (_1948 * _1823)) * _1862, 0.0, 0.0);
            float _3283;
            do
            {
                float _1988 = _1899.w;
                float2 _1990 = _1899.xy / float2(_1988);
                if (any(_1990 > float2(1.0)) || any(_1990 < float2(0.0)))
                {
                    _3283 = 1.0;
                    break;
                }
                _3283 = step((_1899.z - _mtl_u.u_params1.x) / _1988, dot(s_shadowMap0.sample(s_shadowMap0Sampler, _1990, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                break;
            } while(false);
            _1905 = _3264 + _3283;
        }
        _3273 = float3(_1443, _1441, _1443);
        _3269 = _3264 * 0.0625;
    }
    else
    {
        float _3270;
        float3 _3275;
        if (all(_1382 < float2(0.9900000095367431640625)) && all(_1382 > float2(0.00999999977648258209228515625)))
        {
            float _1474 = (all(_1382 > float2(0.0)) && all(_1382 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
            float4 _2111 = float4(_1382, in.v_texcoord2.z, 1.0);
            float _2137 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
            float _2139 = sin(_2137);
            float _2141 = cos(_2137);
            float2 _2180 = (_mtl_u.u_smSamplingParams.zw * _1661) * 1.0;
            float _3259;
            _3259 = 0.0;
            float _2223;
            for (int _3258 = 0; _3258 < 16; _3259 = _2223, _3258++)
            {
                float _2242 = float(_3258);
                float _2250 = _2242 * 2.3999631404876708984375;
                float2 _2257 = float2(cos(_2250), sin(_2250)) * sqrt((_2242 + 0.5) * 0.100000001490116119384765625);
                float _2261 = _2257.x;
                float _2266 = _2257.y;
                float4 _2217 = _2111 + float4(float2((_2261 * _2141) - (_2266 * _2139), (_2261 * _2139) + (_2266 * _2141)) * _2180, 0.0, 0.0);
                float _3260;
                do
                {
                    float _2306 = _2217.w;
                    float2 _2308 = _2217.xy / float2(_2306);
                    if (any(_2308 > float2(1.0)) || any(_2308 < float2(0.0)))
                    {
                        _3260 = 1.0;
                        break;
                    }
                    _3260 = step((_2217.z - _mtl_u.u_params1.x) / _2306, dot(s_shadowMap1.sample(s_shadowMap1Sampler, _2308, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                    break;
                } while(false);
                _2223 = _3259 + _3260;
            }
            _3275 = float3(_1474, _1474, -_1474);
            _3270 = _3259 * 0.0625;
        }
        else
        {
            float _3271;
            float3 _3278;
            if (all(_1388 < float2(0.9900000095367431640625)) && all(_1388 > float2(0.00999999977648258209228515625)))
            {
                float _1507 = (all(_1388 > float2(0.0)) && all(_1388 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1509 = -_1507;
                float4 _2429 = float4(_1388, in.v_texcoord3.z, 1.0);
                float _2455 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
                float _2457 = sin(_2455);
                float _2459 = cos(_2455);
                float2 _2498 = (float2(0.666666686534881591796875) * (_mtl_u.u_smSamplingParams.zw * _1661)) * 1.0;
                float _3254;
                _3254 = 0.0;
                float _2541;
                for (int _3253 = 0; _3253 < 16; _3254 = _2541, _3253++)
                {
                    float _2560 = float(_3253);
                    float _2568 = _2560 * 2.3999631404876708984375;
                    float2 _2575 = float2(cos(_2568), sin(_2568)) * sqrt((_2560 + 0.5) * 0.100000001490116119384765625);
                    float _2579 = _2575.x;
                    float _2584 = _2575.y;
                    float4 _2535 = _2429 + float4(float2((_2579 * _2459) - (_2584 * _2457), (_2579 * _2457) + (_2584 * _2459)) * _2498, 0.0, 0.0);
                    float _3255;
                    do
                    {
                        float _2624 = _2535.w;
                        float2 _2626 = _2535.xy / float2(_2624);
                        if (any(_2626 > float2(1.0)) || any(_2626 < float2(0.0)))
                        {
                            _3255 = 1.0;
                            break;
                        }
                        _3255 = step((_2535.z - _mtl_u.u_params1.x) / _2624, dot(s_shadowMap2.sample(s_shadowMap2Sampler, _2626, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                        break;
                    } while(false);
                    _2541 = _3254 + _3255;
                }
                _3278 = float3(_1509, _1509, _1507);
                _3271 = _3254 * 0.0625;
            }
            else
            {
                float2 _1538 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1540 = (all(_1538 > float2(0.0)) && all(_1538 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1543 = -_1540;
                float4 _2747 = float4(_1538, in.v_texcoord4.z, 1.0);
                float _2773 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
                float _2775 = sin(_2773);
                float _2777 = cos(_2773);
                float2 _2816 = (float2(0.5) * (_mtl_u.u_smSamplingParams.zw * _1661)) * 1.0;
                float _3249;
                _3249 = 0.0;
                float _2859;
                for (int _3248 = 0; _3248 < 16; _3249 = _2859, _3248++)
                {
                    float _2878 = float(_3248);
                    float _2886 = _2878 * 2.3999631404876708984375;
                    float2 _2893 = float2(cos(_2886), sin(_2886)) * sqrt((_2878 + 0.5) * 0.100000001490116119384765625);
                    float _2897 = _2893.x;
                    float _2902 = _2893.y;
                    float4 _2853 = _2747 + float4(float2((_2897 * _2777) - (_2902 * _2775), (_2897 * _2775) + (_2902 * _2777)) * _2816, 0.0, 0.0);
                    float _3250;
                    do
                    {
                        float _2942 = _2853.w;
                        float2 _2944 = _2853.xy / float2(_2942);
                        if (any(_2944 > float2(1.0)) || any(_2944 < float2(0.0)))
                        {
                            _3250 = 1.0;
                            break;
                        }
                        _3250 = step((_2853.z - _mtl_u.u_params1.x) / _2942, dot(s_shadowMap3.sample(s_shadowMap3Sampler, _2944, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                        break;
                    } while(false);
                    _2859 = _3249 + _3250;
                }
                _3278 = float3(_1540, _1543, _1543);
                _3271 = _3249 * 0.0625;
            }
            _3275 = _3278;
            _3270 = _3271;
        }
        _3273 = _3275;
        _3269 = _3270;
    }
    float _3265;
    float3 _3266;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _3036 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _3040 = fast::normalize(_3036);
        float _3073 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _3055 = length(_3036);
        _3266 = _3040;
        _3265 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _3055)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _3055) * _3055))) * mix(fast::clamp((fast::max(0.0, dot(-_3040, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _3073) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _3073), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _3266 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _3265 = 1.0;
    }
    float _3120 = dot(in.v_normal, _3266);
    float2 _1595 = fast::max(float2(_3120, ((step(0.0, _3120) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _3120)) - _3266, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _3265;
    float _1603 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1595.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1595.y)) * _mtl_u.u_color.xyz) * _3269))), float3(0.4545454680919647216796875)) + (_3273 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1603) * _1603) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

