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
    float2 _1651 = float2(_mtl_u.u_params2.z);
    float2 _1366 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
    float2 _1372 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
    float2 _1378 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
    float _3219;
    float3 _3223;
    if (all(_1366 < float2(0.9900000095367431640625)) && all(_1366 > float2(0.00999999977648258209228515625)))
    {
        float _1431 = (all(_1366 > float2(0.0)) && all(_1366 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
        float _1433 = -_1431;
        float _1799 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
        float _1801 = sin(_1799);
        float _1803 = cos(_1799);
        float2 _1842 = ((float2(2.0) * _mtl_u.u_smSamplingParams.zw) * _1651) * in.v_texcoord1.w;
        float _3214;
        _3214 = 0.0;
        float _1885;
        for (int _3213 = 0; _3213 < 16; _3214 = _1885, _3213++)
        {
            float _1904 = float(_3213);
            float _1912 = _1904 * 2.3999631404876708984375;
            float2 _1919 = float2(cos(_1912), sin(_1912)) * sqrt((_1904 + 0.5) * 0.100000001490116119384765625);
            float _1923 = _1919.x;
            float _1928 = _1919.y;
            float4 _1879 = in.v_texcoord1 + float4(float2((_1923 * _1803) - (_1928 * _1801), (_1923 * _1801) + (_1928 * _1803)) * _1842, 0.0, 0.0);
            float _3233;
            do
            {
                float _1968 = _1879.w;
                float2 _1970 = _1879.xy / float2(_1968);
                if (any(_1970 > float2(1.0)) || any(_1970 < float2(0.0)))
                {
                    _3233 = 1.0;
                    break;
                }
                _3233 = step((_1879.z - _mtl_u.u_params1.x) / _1968, dot(s_shadowMap0.sample(s_shadowMap0Sampler, _1970, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                break;
            } while(false);
            _1885 = _3214 + _3233;
        }
        _3223 = float3(_1433, _1431, _1433);
        _3219 = _3214 * 0.0625;
    }
    else
    {
        float _3220;
        float3 _3225;
        if (all(_1372 < float2(0.9900000095367431640625)) && all(_1372 > float2(0.00999999977648258209228515625)))
        {
            float _1464 = (all(_1372 > float2(0.0)) && all(_1372 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
            float _2107 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
            float _2109 = sin(_2107);
            float _2111 = cos(_2107);
            float2 _2150 = (_mtl_u.u_smSamplingParams.zw * _1651) * in.v_texcoord2.w;
            float _3209;
            _3209 = 0.0;
            float _2193;
            for (int _3208 = 0; _3208 < 16; _3209 = _2193, _3208++)
            {
                float _2212 = float(_3208);
                float _2220 = _2212 * 2.3999631404876708984375;
                float2 _2227 = float2(cos(_2220), sin(_2220)) * sqrt((_2212 + 0.5) * 0.100000001490116119384765625);
                float _2231 = _2227.x;
                float _2236 = _2227.y;
                float4 _2187 = in.v_texcoord2 + float4(float2((_2231 * _2111) - (_2236 * _2109), (_2231 * _2109) + (_2236 * _2111)) * _2150, 0.0, 0.0);
                float _3210;
                do
                {
                    float _2276 = _2187.w;
                    float2 _2278 = _2187.xy / float2(_2276);
                    if (any(_2278 > float2(1.0)) || any(_2278 < float2(0.0)))
                    {
                        _3210 = 1.0;
                        break;
                    }
                    _3210 = step((_2187.z - _mtl_u.u_params1.x) / _2276, dot(s_shadowMap1.sample(s_shadowMap1Sampler, _2278, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                    break;
                } while(false);
                _2193 = _3209 + _3210;
            }
            _3225 = float3(_1464, _1464, -_1464);
            _3220 = _3209 * 0.0625;
        }
        else
        {
            float _3221;
            float3 _3228;
            if (all(_1378 < float2(0.9900000095367431640625)) && all(_1378 > float2(0.00999999977648258209228515625)))
            {
                float _1497 = (all(_1378 > float2(0.0)) && all(_1378 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1499 = -_1497;
                float _2415 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
                float _2417 = sin(_2415);
                float _2419 = cos(_2415);
                float2 _2458 = (float2(0.666666686534881591796875) * (_mtl_u.u_smSamplingParams.zw * _1651)) * in.v_texcoord3.w;
                float _3204;
                _3204 = 0.0;
                float _2501;
                for (int _3203 = 0; _3203 < 16; _3204 = _2501, _3203++)
                {
                    float _2520 = float(_3203);
                    float _2528 = _2520 * 2.3999631404876708984375;
                    float2 _2535 = float2(cos(_2528), sin(_2528)) * sqrt((_2520 + 0.5) * 0.100000001490116119384765625);
                    float _2539 = _2535.x;
                    float _2544 = _2535.y;
                    float4 _2495 = in.v_texcoord3 + float4(float2((_2539 * _2419) - (_2544 * _2417), (_2539 * _2417) + (_2544 * _2419)) * _2458, 0.0, 0.0);
                    float _3205;
                    do
                    {
                        float _2584 = _2495.w;
                        float2 _2586 = _2495.xy / float2(_2584);
                        if (any(_2586 > float2(1.0)) || any(_2586 < float2(0.0)))
                        {
                            _3205 = 1.0;
                            break;
                        }
                        _3205 = step((_2495.z - _mtl_u.u_params1.x) / _2584, dot(s_shadowMap2.sample(s_shadowMap2Sampler, _2586, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                        break;
                    } while(false);
                    _2501 = _3204 + _3205;
                }
                _3228 = float3(_1499, _1499, _1497);
                _3221 = _3204 * 0.0625;
            }
            else
            {
                float2 _1528 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1530 = (all(_1528 > float2(0.0)) && all(_1528 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1533 = -_1530;
                float _2723 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
                float _2725 = sin(_2723);
                float _2727 = cos(_2723);
                float2 _2766 = (float2(0.5) * (_mtl_u.u_smSamplingParams.zw * _1651)) * in.v_texcoord4.w;
                float _3199;
                _3199 = 0.0;
                float _2809;
                for (int _3198 = 0; _3198 < 16; _3199 = _2809, _3198++)
                {
                    float _2828 = float(_3198);
                    float _2836 = _2828 * 2.3999631404876708984375;
                    float2 _2843 = float2(cos(_2836), sin(_2836)) * sqrt((_2828 + 0.5) * 0.100000001490116119384765625);
                    float _2847 = _2843.x;
                    float _2852 = _2843.y;
                    float4 _2803 = in.v_texcoord4 + float4(float2((_2847 * _2727) - (_2852 * _2725), (_2847 * _2725) + (_2852 * _2727)) * _2766, 0.0, 0.0);
                    float _3200;
                    do
                    {
                        float _2892 = _2803.w;
                        float2 _2894 = _2803.xy / float2(_2892);
                        if (any(_2894 > float2(1.0)) || any(_2894 < float2(0.0)))
                        {
                            _3200 = 1.0;
                            break;
                        }
                        _3200 = step((_2803.z - _mtl_u.u_params1.x) / _2892, dot(s_shadowMap3.sample(s_shadowMap3Sampler, _2894, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                        break;
                    } while(false);
                    _2809 = _3199 + _3200;
                }
                _3228 = float3(_1530, _1533, _1533);
                _3221 = _3199 * 0.0625;
            }
            _3225 = _3228;
            _3220 = _3221;
        }
        _3223 = _3225;
        _3219 = _3220;
    }
    float _3215;
    float3 _3216;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _2986 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _2990 = fast::normalize(_2986);
        float _3023 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _3005 = length(_2986);
        _3216 = _2990;
        _3215 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _3005)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _3005) * _3005))) * mix(fast::clamp((fast::max(0.0, dot(-_2990, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _3023) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _3023), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _3216 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _3215 = 1.0;
    }
    float _3070 = dot(in.v_normal, _3216);
    float2 _1585 = fast::max(float2(_3070, ((step(0.0, _3070) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _3070)) - _3216, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _3215;
    float _1593 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1585.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1585.y)) * _mtl_u.u_color.xyz) * _3219))), float3(0.4545454680919647216796875)) + (_3223 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1593) * _1593) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

