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
    float2 _1527 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
    float2 _1533 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
    float2 _1539 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
    float _4310;
    float3 _4314;
    if (all(_1527 < float2(0.9900000095367431640625)) && all(_1527 > float2(0.00999999977648258209228515625)))
    {
        float _1592 = (all(_1527 > float2(0.0)) && all(_1527 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
        float _1594 = -_1592;
        float4 _1944 = float4(_1527, in.v_texcoord1.z, 1.0);
        float _4305;
        do
        {
            float _2000 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
            float _2002 = sin(_2000);
            float _2004 = cos(_2000);
            float _2012 = in.v_texcoord1.z - _mtl_u.u_params1.x;
            float2 _2097 = _1944.xy;
            int _4294;
            float _4295;
            _4295 = 0.0;
            _4294 = 0;
            int _4350;
            float _4351;
            for (int _4293 = 0; _4293 < 16; _4295 = _4351, _4294 = _4350, _4293++)
            {
                float _2171 = float(_4293);
                float _2179 = _2171 * 2.3999631404876708984375;
                float2 _2186 = float2(cos(_2179), sin(_2179)) * sqrt((_2171 + 0.5) * 0.100000001490116119384765625);
                float _2190 = _2186.x;
                float _2195 = _2186.y;
                float4 _2220 = s_shadowMap0.sample(s_shadowMap0Sampler, (_2097 + (float2((_2190 * _2004) - (_2195 * _2002), (_2190 * _2002) + (_2195 * _2004)) * float2(0.00999999977648258209228515625))));
                float _2224 = dot(_2220, float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0));
                if (_2224 < _2012)
                {
                    _4351 = _4295 + _2224;
                    _4350 = _4294 + 1;
                }
                else
                {
                    _4351 = _4295;
                    _4350 = _4294;
                }
            }
            float _4297;
            if (_4294 > 0)
            {
                _4297 = _4295 / float(_4294);
            }
            else
            {
                _4297 = -1.0;
            }
            if (_4297 < (-0.9900000095367431640625))
            {
                _4305 = 1.0;
                break;
            }
            float _2032 = fast::max(0.0, _2012 - _4297);
            float2 _2052 = float2(fast::clamp((_mtl_u.u_smSamplingParams.z * _2032) / _4297, 0.0, 0.25), fast::clamp((_mtl_u.u_smSamplingParams.w * _2032) / _4297, 0.0, 0.25));
            float _4301;
            _4301 = 0.0;
            float _2259;
            for (int _4300 = 0; _4300 < 16; _4301 = _2259, _4300++)
            {
                float _2278 = float(_4300);
                float _2286 = _2278 * 2.3999631404876708984375;
                float2 _2293 = float2(cos(_2286), sin(_2286)) * sqrt((_2278 + 0.5) * 0.100000001490116119384765625);
                float _2297 = _2293.x;
                float _2302 = _2293.y;
                float4 _2253 = _1944 + float4(float2((_2297 * _2004) - (_2302 * _2002), (_2297 * _2002) + (_2302 * _2004)) * _2052, 0.0, 0.0);
                float _4302;
                do
                {
                    float _2342 = _2253.w;
                    float2 _2344 = _2253.xy / float2(_2342);
                    if (any(_2344 > float2(1.0)) || any(_2344 < float2(0.0)))
                    {
                        _4302 = 1.0;
                        break;
                    }
                    _4302 = step((_2253.z - _mtl_u.u_params1.x) / _2342, dot(s_shadowMap0.sample(s_shadowMap0Sampler, _2344, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                    break;
                } while(false);
                _2259 = _4301 + _4302;
            }
            _4305 = mix(1.0, _4301 * 0.0625, smoothstep(0.0, 0.25, float(_4294) * 0.0625));
            break;
        } while(false);
        _4314 = float3(_1594, _1592, _1594);
        _4310 = _4305;
    }
    else
    {
        float _4311;
        float3 _4320;
        if (all(_1533 < float2(0.9900000095367431640625)) && all(_1533 > float2(0.00999999977648258209228515625)))
        {
            float _1625 = (all(_1533 > float2(0.0)) && all(_1533 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
            float4 _2471 = float4(_1533, in.v_texcoord2.z, 1.0);
            float _4291;
            do
            {
                float _2527 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
                float _2529 = sin(_2527);
                float _2531 = cos(_2527);
                float _2539 = in.v_texcoord2.z - _mtl_u.u_params1.x;
                float2 _2624 = _2471.xy;
                int _4280;
                float _4281;
                _4281 = 0.0;
                _4280 = 0;
                int _4347;
                float _4348;
                for (int _4279 = 0; _4279 < 16; _4281 = _4348, _4280 = _4347, _4279++)
                {
                    float _2698 = float(_4279);
                    float _2706 = _2698 * 2.3999631404876708984375;
                    float2 _2713 = float2(cos(_2706), sin(_2706)) * sqrt((_2698 + 0.5) * 0.100000001490116119384765625);
                    float _2717 = _2713.x;
                    float _2722 = _2713.y;
                    float4 _2747 = s_shadowMap1.sample(s_shadowMap1Sampler, (_2624 + (float2((_2717 * _2531) - (_2722 * _2529), (_2717 * _2529) + (_2722 * _2531)) * float2(0.00999999977648258209228515625))));
                    float _2751 = dot(_2747, float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0));
                    if (_2751 < _2539)
                    {
                        _4348 = _4281 + _2751;
                        _4347 = _4280 + 1;
                    }
                    else
                    {
                        _4348 = _4281;
                        _4347 = _4280;
                    }
                }
                float _4283;
                if (_4280 > 0)
                {
                    _4283 = _4281 / float(_4280);
                }
                else
                {
                    _4283 = -1.0;
                }
                if (_4283 < (-0.9900000095367431640625))
                {
                    _4291 = 1.0;
                    break;
                }
                float _2559 = fast::max(0.0, _2539 - _4283);
                float2 _2579 = float2(fast::clamp((_mtl_u.u_smSamplingParams.z * _2559) / _4283, 0.0, 0.25), fast::clamp((_mtl_u.u_smSamplingParams.w * _2559) / _4283, 0.0, 0.25));
                float _4287;
                _4287 = 0.0;
                float _2786;
                for (int _4286 = 0; _4286 < 16; _4287 = _2786, _4286++)
                {
                    float _2805 = float(_4286);
                    float _2813 = _2805 * 2.3999631404876708984375;
                    float2 _2820 = float2(cos(_2813), sin(_2813)) * sqrt((_2805 + 0.5) * 0.100000001490116119384765625);
                    float _2824 = _2820.x;
                    float _2829 = _2820.y;
                    float4 _2780 = _2471 + float4(float2((_2824 * _2531) - (_2829 * _2529), (_2824 * _2529) + (_2829 * _2531)) * _2579, 0.0, 0.0);
                    float _4288;
                    do
                    {
                        float _2869 = _2780.w;
                        float2 _2871 = _2780.xy / float2(_2869);
                        if (any(_2871 > float2(1.0)) || any(_2871 < float2(0.0)))
                        {
                            _4288 = 1.0;
                            break;
                        }
                        _4288 = step((_2780.z - _mtl_u.u_params1.x) / _2869, dot(s_shadowMap1.sample(s_shadowMap1Sampler, _2871, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                        break;
                    } while(false);
                    _2786 = _4287 + _4288;
                }
                _4291 = mix(1.0, _4287 * 0.0625, smoothstep(0.0, 0.25, float(_4280) * 0.0625));
                break;
            } while(false);
            _4320 = float3(_1625, _1625, -_1625);
            _4311 = _4291;
        }
        else
        {
            float _4312;
            float3 _4327;
            if (all(_1539 < float2(0.9900000095367431640625)) && all(_1539 > float2(0.00999999977648258209228515625)))
            {
                float _1658 = (all(_1539 > float2(0.0)) && all(_1539 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1660 = -_1658;
                float4 _2998 = float4(_1539, in.v_texcoord3.z, 1.0);
                float _4277;
                do
                {
                    float _3054 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
                    float _3056 = sin(_3054);
                    float _3058 = cos(_3054);
                    float _3066 = in.v_texcoord3.z - _mtl_u.u_params1.x;
                    float2 _3151 = _2998.xy;
                    int _4266;
                    float _4267;
                    _4267 = 0.0;
                    _4266 = 0;
                    int _4344;
                    float _4345;
                    for (int _4265 = 0; _4265 < 16; _4267 = _4345, _4266 = _4344, _4265++)
                    {
                        float _3225 = float(_4265);
                        float _3233 = _3225 * 2.3999631404876708984375;
                        float2 _3240 = float2(cos(_3233), sin(_3233)) * sqrt((_3225 + 0.5) * 0.100000001490116119384765625);
                        float _3244 = _3240.x;
                        float _3249 = _3240.y;
                        float4 _3274 = s_shadowMap2.sample(s_shadowMap2Sampler, (_3151 + (float2((_3244 * _3058) - (_3249 * _3056), (_3244 * _3056) + (_3249 * _3058)) * float2(0.00999999977648258209228515625))));
                        float _3278 = dot(_3274, float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0));
                        if (_3278 < _3066)
                        {
                            _4345 = _4267 + _3278;
                            _4344 = _4266 + 1;
                        }
                        else
                        {
                            _4345 = _4267;
                            _4344 = _4266;
                        }
                    }
                    float _4269;
                    if (_4266 > 0)
                    {
                        _4269 = _4267 / float(_4266);
                    }
                    else
                    {
                        _4269 = -1.0;
                    }
                    if (_4269 < (-0.9900000095367431640625))
                    {
                        _4277 = 1.0;
                        break;
                    }
                    float _3086 = fast::max(0.0, _3066 - _4269);
                    float2 _3106 = float2(fast::clamp((_mtl_u.u_smSamplingParams.z * _3086) / _4269, 0.0, 0.25), fast::clamp((_mtl_u.u_smSamplingParams.w * _3086) / _4269, 0.0, 0.25));
                    float _4273;
                    _4273 = 0.0;
                    float _3313;
                    for (int _4272 = 0; _4272 < 16; _4273 = _3313, _4272++)
                    {
                        float _3332 = float(_4272);
                        float _3340 = _3332 * 2.3999631404876708984375;
                        float2 _3347 = float2(cos(_3340), sin(_3340)) * sqrt((_3332 + 0.5) * 0.100000001490116119384765625);
                        float _3351 = _3347.x;
                        float _3356 = _3347.y;
                        float4 _3307 = _2998 + float4(float2((_3351 * _3058) - (_3356 * _3056), (_3351 * _3056) + (_3356 * _3058)) * _3106, 0.0, 0.0);
                        float _4274;
                        do
                        {
                            float _3396 = _3307.w;
                            float2 _3398 = _3307.xy / float2(_3396);
                            if (any(_3398 > float2(1.0)) || any(_3398 < float2(0.0)))
                            {
                                _4274 = 1.0;
                                break;
                            }
                            _4274 = step((_3307.z - _mtl_u.u_params1.x) / _3396, dot(s_shadowMap2.sample(s_shadowMap2Sampler, _3398, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                            break;
                        } while(false);
                        _3313 = _4273 + _4274;
                    }
                    _4277 = mix(1.0, _4273 * 0.0625, smoothstep(0.0, 0.25, float(_4266) * 0.0625));
                    break;
                } while(false);
                _4327 = float3(_1660, _1660, _1658);
                _4312 = _4277;
            }
            else
            {
                float2 _1689 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1691 = (all(_1689 > float2(0.0)) && all(_1689 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1694 = -_1691;
                float4 _3525 = float4(_1689, in.v_texcoord4.z, 1.0);
                float _4263;
                do
                {
                    float _3581 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
                    float _3583 = sin(_3581);
                    float _3585 = cos(_3581);
                    float _3593 = in.v_texcoord4.z - _mtl_u.u_params1.x;
                    float2 _3678 = _3525.xy;
                    int _4252;
                    float _4253;
                    _4253 = 0.0;
                    _4252 = 0;
                    int _4341;
                    float _4342;
                    for (int _4251 = 0; _4251 < 16; _4253 = _4342, _4252 = _4341, _4251++)
                    {
                        float _3752 = float(_4251);
                        float _3760 = _3752 * 2.3999631404876708984375;
                        float2 _3767 = float2(cos(_3760), sin(_3760)) * sqrt((_3752 + 0.5) * 0.100000001490116119384765625);
                        float _3771 = _3767.x;
                        float _3776 = _3767.y;
                        float4 _3801 = s_shadowMap3.sample(s_shadowMap3Sampler, (_3678 + (float2((_3771 * _3585) - (_3776 * _3583), (_3771 * _3583) + (_3776 * _3585)) * float2(0.00999999977648258209228515625))));
                        float _3805 = dot(_3801, float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0));
                        if (_3805 < _3593)
                        {
                            _4342 = _4253 + _3805;
                            _4341 = _4252 + 1;
                        }
                        else
                        {
                            _4342 = _4253;
                            _4341 = _4252;
                        }
                    }
                    float _4255;
                    if (_4252 > 0)
                    {
                        _4255 = _4253 / float(_4252);
                    }
                    else
                    {
                        _4255 = -1.0;
                    }
                    if (_4255 < (-0.9900000095367431640625))
                    {
                        _4263 = 1.0;
                        break;
                    }
                    float _3613 = fast::max(0.0, _3593 - _4255);
                    float2 _3633 = float2(fast::clamp((_mtl_u.u_smSamplingParams.z * _3613) / _4255, 0.0, 0.25), fast::clamp((_mtl_u.u_smSamplingParams.w * _3613) / _4255, 0.0, 0.25));
                    float _4259;
                    _4259 = 0.0;
                    float _3840;
                    for (int _4258 = 0; _4258 < 16; _4259 = _3840, _4258++)
                    {
                        float _3859 = float(_4258);
                        float _3867 = _3859 * 2.3999631404876708984375;
                        float2 _3874 = float2(cos(_3867), sin(_3867)) * sqrt((_3859 + 0.5) * 0.100000001490116119384765625);
                        float _3878 = _3874.x;
                        float _3883 = _3874.y;
                        float4 _3834 = _3525 + float4(float2((_3878 * _3585) - (_3883 * _3583), (_3878 * _3583) + (_3883 * _3585)) * _3633, 0.0, 0.0);
                        float _4260;
                        do
                        {
                            float _3923 = _3834.w;
                            float2 _3925 = _3834.xy / float2(_3923);
                            if (any(_3925 > float2(1.0)) || any(_3925 < float2(0.0)))
                            {
                                _4260 = 1.0;
                                break;
                            }
                            _4260 = step((_3834.z - _mtl_u.u_params1.x) / _3923, dot(s_shadowMap3.sample(s_shadowMap3Sampler, _3925, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                            break;
                        } while(false);
                        _3840 = _4259 + _4260;
                    }
                    _4263 = mix(1.0, _4259 * 0.0625, smoothstep(0.0, 0.25, float(_4252) * 0.0625));
                    break;
                } while(false);
                _4327 = float3(_1691, _1694, _1694);
                _4312 = _4263;
            }
            _4320 = _4327;
            _4311 = _4312;
        }
        _4314 = _4320;
        _4310 = _4311;
    }
    float _4306;
    float3 _4307;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _4023 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _4027 = fast::normalize(_4023);
        float _4060 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _4042 = length(_4023);
        _4307 = _4027;
        _4306 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _4042)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _4042) * _4042))) * mix(fast::clamp((fast::max(0.0, dot(-_4027, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _4060) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _4060), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _4307 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _4306 = 1.0;
    }
    float _4107 = dot(in.v_normal, _4307);
    float2 _1746 = fast::max(float2(_4107, ((step(0.0, _4107) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _4107)) - _4307, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _4306;
    float _1754 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1746.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1746.y)) * _mtl_u.u_color.xyz) * _4310))), float3(0.4545454680919647216796875)) + (_4314 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1754) * _1754) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

