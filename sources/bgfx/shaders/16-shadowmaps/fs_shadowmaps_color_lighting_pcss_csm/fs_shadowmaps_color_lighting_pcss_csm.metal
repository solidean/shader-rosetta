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
    float2 _1517 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
    float2 _1523 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
    float2 _1529 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
    float _4260;
    float3 _4264;
    if (all(_1517 < float2(0.9900000095367431640625)) && all(_1517 > float2(0.00999999977648258209228515625)))
    {
        float _1582 = (all(_1517 > float2(0.0)) && all(_1517 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
        float _1584 = -_1582;
        float _4255;
        do
        {
            float _1980 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
            float _1982 = sin(_1980);
            float _1984 = cos(_1980);
            float _1992 = (in.v_texcoord1.z / in.v_texcoord1.w) - _mtl_u.u_params1.x;
            int _4244;
            float _4245;
            _4245 = 0.0;
            _4244 = 0;
            int _4300;
            float _4301;
            for (int _4243 = 0; _4243 < 16; _4245 = _4301, _4244 = _4300, _4243++)
            {
                float _2151 = float(_4243);
                float _2159 = _2151 * 2.3999631404876708984375;
                float2 _2166 = float2(cos(_2159), sin(_2159)) * sqrt((_2151 + 0.5) * 0.100000001490116119384765625);
                float _2170 = _2166.x;
                float _2175 = _2166.y;
                float4 _2200 = s_shadowMap0.sample(s_shadowMap0Sampler, (_1517 + (float2((_2170 * _1984) - (_2175 * _1982), (_2170 * _1982) + (_2175 * _1984)) * float2(0.00999999977648258209228515625))));
                float _2204 = dot(_2200, float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0));
                if (_2204 < _1992)
                {
                    _4301 = _4245 + _2204;
                    _4300 = _4244 + 1;
                }
                else
                {
                    _4301 = _4245;
                    _4300 = _4244;
                }
            }
            float _4247;
            if (_4244 > 0)
            {
                _4247 = _4245 / float(_4244);
            }
            else
            {
                _4247 = -1.0;
            }
            if (_4247 < (-0.9900000095367431640625))
            {
                _4255 = 1.0;
                break;
            }
            float _2012 = fast::max(0.0, _1992 - _4247);
            float2 _2032 = float2(fast::clamp((_mtl_u.u_smSamplingParams.z * _2012) / _4247, 0.0, 0.25), fast::clamp((_mtl_u.u_smSamplingParams.w * _2012) / _4247, 0.0, 0.25));
            float _4251;
            _4251 = 0.0;
            float _2239;
            for (int _4250 = 0; _4250 < 16; _4251 = _2239, _4250++)
            {
                float _2258 = float(_4250);
                float _2266 = _2258 * 2.3999631404876708984375;
                float2 _2273 = float2(cos(_2266), sin(_2266)) * sqrt((_2258 + 0.5) * 0.100000001490116119384765625);
                float _2277 = _2273.x;
                float _2282 = _2273.y;
                float4 _2233 = in.v_texcoord1 + float4(float2((_2277 * _1984) - (_2282 * _1982), (_2277 * _1982) + (_2282 * _1984)) * _2032, 0.0, 0.0);
                float _4252;
                do
                {
                    float _2322 = _2233.w;
                    float2 _2324 = _2233.xy / float2(_2322);
                    if (any(_2324 > float2(1.0)) || any(_2324 < float2(0.0)))
                    {
                        _4252 = 1.0;
                        break;
                    }
                    _4252 = step((_2233.z - _mtl_u.u_params1.x) / _2322, dot(s_shadowMap0.sample(s_shadowMap0Sampler, _2324, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                    break;
                } while(false);
                _2239 = _4251 + _4252;
            }
            _4255 = mix(1.0, _4251 * 0.0625, smoothstep(0.0, 0.25, float(_4244) * 0.0625));
            break;
        } while(false);
        _4264 = float3(_1584, _1582, _1584);
        _4260 = _4255;
    }
    else
    {
        float _4261;
        float3 _4270;
        if (all(_1523 < float2(0.9900000095367431640625)) && all(_1523 > float2(0.00999999977648258209228515625)))
        {
            float _1615 = (all(_1523 > float2(0.0)) && all(_1523 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
            float _4241;
            do
            {
                float _2497 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
                float _2499 = sin(_2497);
                float _2501 = cos(_2497);
                float _2509 = (in.v_texcoord2.z / in.v_texcoord2.w) - _mtl_u.u_params1.x;
                int _4230;
                float _4231;
                _4231 = 0.0;
                _4230 = 0;
                int _4297;
                float _4298;
                for (int _4229 = 0; _4229 < 16; _4231 = _4298, _4230 = _4297, _4229++)
                {
                    float _2668 = float(_4229);
                    float _2676 = _2668 * 2.3999631404876708984375;
                    float2 _2683 = float2(cos(_2676), sin(_2676)) * sqrt((_2668 + 0.5) * 0.100000001490116119384765625);
                    float _2687 = _2683.x;
                    float _2692 = _2683.y;
                    float4 _2717 = s_shadowMap1.sample(s_shadowMap1Sampler, (_1523 + (float2((_2687 * _2501) - (_2692 * _2499), (_2687 * _2499) + (_2692 * _2501)) * float2(0.00999999977648258209228515625))));
                    float _2721 = dot(_2717, float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0));
                    if (_2721 < _2509)
                    {
                        _4298 = _4231 + _2721;
                        _4297 = _4230 + 1;
                    }
                    else
                    {
                        _4298 = _4231;
                        _4297 = _4230;
                    }
                }
                float _4233;
                if (_4230 > 0)
                {
                    _4233 = _4231 / float(_4230);
                }
                else
                {
                    _4233 = -1.0;
                }
                if (_4233 < (-0.9900000095367431640625))
                {
                    _4241 = 1.0;
                    break;
                }
                float _2529 = fast::max(0.0, _2509 - _4233);
                float2 _2549 = float2(fast::clamp((_mtl_u.u_smSamplingParams.z * _2529) / _4233, 0.0, 0.25), fast::clamp((_mtl_u.u_smSamplingParams.w * _2529) / _4233, 0.0, 0.25));
                float _4237;
                _4237 = 0.0;
                float _2756;
                for (int _4236 = 0; _4236 < 16; _4237 = _2756, _4236++)
                {
                    float _2775 = float(_4236);
                    float _2783 = _2775 * 2.3999631404876708984375;
                    float2 _2790 = float2(cos(_2783), sin(_2783)) * sqrt((_2775 + 0.5) * 0.100000001490116119384765625);
                    float _2794 = _2790.x;
                    float _2799 = _2790.y;
                    float4 _2750 = in.v_texcoord2 + float4(float2((_2794 * _2501) - (_2799 * _2499), (_2794 * _2499) + (_2799 * _2501)) * _2549, 0.0, 0.0);
                    float _4238;
                    do
                    {
                        float _2839 = _2750.w;
                        float2 _2841 = _2750.xy / float2(_2839);
                        if (any(_2841 > float2(1.0)) || any(_2841 < float2(0.0)))
                        {
                            _4238 = 1.0;
                            break;
                        }
                        _4238 = step((_2750.z - _mtl_u.u_params1.x) / _2839, dot(s_shadowMap1.sample(s_shadowMap1Sampler, _2841, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                        break;
                    } while(false);
                    _2756 = _4237 + _4238;
                }
                _4241 = mix(1.0, _4237 * 0.0625, smoothstep(0.0, 0.25, float(_4230) * 0.0625));
                break;
            } while(false);
            _4270 = float3(_1615, _1615, -_1615);
            _4261 = _4241;
        }
        else
        {
            float _4262;
            float3 _4277;
            if (all(_1529 < float2(0.9900000095367431640625)) && all(_1529 > float2(0.00999999977648258209228515625)))
            {
                float _1648 = (all(_1529 > float2(0.0)) && all(_1529 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1650 = -_1648;
                float _4227;
                do
                {
                    float _3014 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
                    float _3016 = sin(_3014);
                    float _3018 = cos(_3014);
                    float _3026 = (in.v_texcoord3.z / in.v_texcoord3.w) - _mtl_u.u_params1.x;
                    int _4216;
                    float _4217;
                    _4217 = 0.0;
                    _4216 = 0;
                    int _4294;
                    float _4295;
                    for (int _4215 = 0; _4215 < 16; _4217 = _4295, _4216 = _4294, _4215++)
                    {
                        float _3185 = float(_4215);
                        float _3193 = _3185 * 2.3999631404876708984375;
                        float2 _3200 = float2(cos(_3193), sin(_3193)) * sqrt((_3185 + 0.5) * 0.100000001490116119384765625);
                        float _3204 = _3200.x;
                        float _3209 = _3200.y;
                        float4 _3234 = s_shadowMap2.sample(s_shadowMap2Sampler, (_1529 + (float2((_3204 * _3018) - (_3209 * _3016), (_3204 * _3016) + (_3209 * _3018)) * float2(0.00999999977648258209228515625))));
                        float _3238 = dot(_3234, float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0));
                        if (_3238 < _3026)
                        {
                            _4295 = _4217 + _3238;
                            _4294 = _4216 + 1;
                        }
                        else
                        {
                            _4295 = _4217;
                            _4294 = _4216;
                        }
                    }
                    float _4219;
                    if (_4216 > 0)
                    {
                        _4219 = _4217 / float(_4216);
                    }
                    else
                    {
                        _4219 = -1.0;
                    }
                    if (_4219 < (-0.9900000095367431640625))
                    {
                        _4227 = 1.0;
                        break;
                    }
                    float _3046 = fast::max(0.0, _3026 - _4219);
                    float2 _3066 = float2(fast::clamp((_mtl_u.u_smSamplingParams.z * _3046) / _4219, 0.0, 0.25), fast::clamp((_mtl_u.u_smSamplingParams.w * _3046) / _4219, 0.0, 0.25));
                    float _4223;
                    _4223 = 0.0;
                    float _3273;
                    for (int _4222 = 0; _4222 < 16; _4223 = _3273, _4222++)
                    {
                        float _3292 = float(_4222);
                        float _3300 = _3292 * 2.3999631404876708984375;
                        float2 _3307 = float2(cos(_3300), sin(_3300)) * sqrt((_3292 + 0.5) * 0.100000001490116119384765625);
                        float _3311 = _3307.x;
                        float _3316 = _3307.y;
                        float4 _3267 = in.v_texcoord3 + float4(float2((_3311 * _3018) - (_3316 * _3016), (_3311 * _3016) + (_3316 * _3018)) * _3066, 0.0, 0.0);
                        float _4224;
                        do
                        {
                            float _3356 = _3267.w;
                            float2 _3358 = _3267.xy / float2(_3356);
                            if (any(_3358 > float2(1.0)) || any(_3358 < float2(0.0)))
                            {
                                _4224 = 1.0;
                                break;
                            }
                            _4224 = step((_3267.z - _mtl_u.u_params1.x) / _3356, dot(s_shadowMap2.sample(s_shadowMap2Sampler, _3358, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                            break;
                        } while(false);
                        _3273 = _4223 + _4224;
                    }
                    _4227 = mix(1.0, _4223 * 0.0625, smoothstep(0.0, 0.25, float(_4216) * 0.0625));
                    break;
                } while(false);
                _4277 = float3(_1650, _1650, _1648);
                _4262 = _4227;
            }
            else
            {
                float2 _1679 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1681 = (all(_1679 > float2(0.0)) && all(_1679 < float2(1.0))) ? 0.4000000059604644775390625 : 0.0;
                float _1684 = -_1681;
                float _4213;
                do
                {
                    float _3531 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
                    float _3533 = sin(_3531);
                    float _3535 = cos(_3531);
                    float _3543 = (in.v_texcoord4.z / in.v_texcoord4.w) - _mtl_u.u_params1.x;
                    int _4202;
                    float _4203;
                    _4203 = 0.0;
                    _4202 = 0;
                    int _4291;
                    float _4292;
                    for (int _4201 = 0; _4201 < 16; _4203 = _4292, _4202 = _4291, _4201++)
                    {
                        float _3702 = float(_4201);
                        float _3710 = _3702 * 2.3999631404876708984375;
                        float2 _3717 = float2(cos(_3710), sin(_3710)) * sqrt((_3702 + 0.5) * 0.100000001490116119384765625);
                        float _3721 = _3717.x;
                        float _3726 = _3717.y;
                        float4 _3751 = s_shadowMap3.sample(s_shadowMap3Sampler, (_1679 + (float2((_3721 * _3535) - (_3726 * _3533), (_3721 * _3533) + (_3726 * _3535)) * float2(0.00999999977648258209228515625))));
                        float _3755 = dot(_3751, float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0));
                        if (_3755 < _3543)
                        {
                            _4292 = _4203 + _3755;
                            _4291 = _4202 + 1;
                        }
                        else
                        {
                            _4292 = _4203;
                            _4291 = _4202;
                        }
                    }
                    float _4205;
                    if (_4202 > 0)
                    {
                        _4205 = _4203 / float(_4202);
                    }
                    else
                    {
                        _4205 = -1.0;
                    }
                    if (_4205 < (-0.9900000095367431640625))
                    {
                        _4213 = 1.0;
                        break;
                    }
                    float _3563 = fast::max(0.0, _3543 - _4205);
                    float2 _3583 = float2(fast::clamp((_mtl_u.u_smSamplingParams.z * _3563) / _4205, 0.0, 0.25), fast::clamp((_mtl_u.u_smSamplingParams.w * _3563) / _4205, 0.0, 0.25));
                    float _4209;
                    _4209 = 0.0;
                    float _3790;
                    for (int _4208 = 0; _4208 < 16; _4209 = _3790, _4208++)
                    {
                        float _3809 = float(_4208);
                        float _3817 = _3809 * 2.3999631404876708984375;
                        float2 _3824 = float2(cos(_3817), sin(_3817)) * sqrt((_3809 + 0.5) * 0.100000001490116119384765625);
                        float _3828 = _3824.x;
                        float _3833 = _3824.y;
                        float4 _3784 = in.v_texcoord4 + float4(float2((_3828 * _3535) - (_3833 * _3533), (_3828 * _3533) + (_3833 * _3535)) * _3583, 0.0, 0.0);
                        float _4210;
                        do
                        {
                            float _3873 = _3784.w;
                            float2 _3875 = _3784.xy / float2(_3873);
                            if (any(_3875 > float2(1.0)) || any(_3875 < float2(0.0)))
                            {
                                _4210 = 1.0;
                                break;
                            }
                            _4210 = step((_3784.z - _mtl_u.u_params1.x) / _3873, dot(s_shadowMap3.sample(s_shadowMap3Sampler, _3875, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                            break;
                        } while(false);
                        _3790 = _4209 + _4210;
                    }
                    _4213 = mix(1.0, _4209 * 0.0625, smoothstep(0.0, 0.25, float(_4202) * 0.0625));
                    break;
                } while(false);
                _4277 = float3(_1681, _1684, _1684);
                _4262 = _4213;
            }
            _4270 = _4277;
            _4261 = _4262;
        }
        _4264 = _4270;
        _4260 = _4261;
    }
    float _4256;
    float3 _4257;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _3973 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _3977 = fast::normalize(_3973);
        float _4010 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _3992 = length(_3973);
        _4257 = _3977;
        _4256 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _3992)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _3992) * _3992))) * mix(fast::clamp((fast::max(0.0, dot(-_3977, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _4010) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _4010), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _4257 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _4256 = 1.0;
    }
    float _4057 = dot(in.v_normal, _4257);
    float2 _1736 = fast::max(float2(_4057, ((step(0.0, _4057) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _4057)) - _4257, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _4256;
    float _1744 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1736.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1736.y)) * _mtl_u.u_color.xyz) * _4260))), float3(0.4545454680919647216796875)) + (_4264 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1744) * _1744) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

