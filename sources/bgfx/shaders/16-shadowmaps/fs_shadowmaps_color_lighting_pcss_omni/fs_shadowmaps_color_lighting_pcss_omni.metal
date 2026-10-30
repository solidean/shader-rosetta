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
    float4 u_tetraNormalGreen;
    float4 u_tetraNormalYellow;
    float4 u_tetraNormalBlue;
    float4 u_tetraNormalRed;
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
    float4 v_position [[user(locn1)]];
    float4 v_texcoord1 [[user(locn2)]];
    float4 v_texcoord2 [[user(locn3)]];
    float4 v_texcoord3 [[user(locn4)]];
    float4 v_texcoord4 [[user(locn5)]];
    float3 v_view [[user(locn6)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_shadowMap0 [[texture(4)]], sampler s_shadowMap0Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float _1338 = dot(_mtl_u.u_tetraNormalGreen.xyz, in.v_position.xyz);
    float _1344 = dot(_mtl_u.u_tetraNormalYellow.xyz, in.v_position.xyz);
    float _1350 = dot(_mtl_u.u_tetraNormalBlue.xyz, in.v_position.xyz);
    float _1368 = fast::max(fast::max(_1338, _1344), fast::max(_1350, dot(_mtl_u.u_tetraNormalRed.xyz, in.v_position.xyz)));
    float3 _2443;
    float4 _2544;
    if (_1338 == _1368)
    {
        float2 _1380 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
        float _1382 = (all(_1380 > float2(0.0)) && all(_1380 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
        float _1384 = -_1382;
        _2544 = in.v_texcoord1;
        _2443 = float3(_1384, _1382, _1384);
    }
    else
    {
        float3 _2444;
        float4 _2545;
        if (_1344 == _1368)
        {
            float2 _1401 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
            float _1403 = (all(_1401 > float2(0.0)) && all(_1401 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
            _2545 = in.v_texcoord2;
            _2444 = float3(_1403, _1403, -_1403);
        }
        else
        {
            bool _1412 = _1350 == _1368;
            float3 _2445;
            if (_1412)
            {
                float2 _1420 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
                float _1422 = (all(_1420 > float2(0.0)) && all(_1420 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1424 = -_1422;
                _2445 = float3(_1424, _1424, _1422);
            }
            else
            {
                float2 _1436 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1438 = (all(_1436 > float2(0.0)) && all(_1436 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1441 = -_1438;
                _2445 = float3(_1438, _1441, _1441);
            }
            _2545 = select(in.v_texcoord4, in.v_texcoord3, bool4(_1412));
            _2444 = _2445;
        }
        _2544 = _2545;
        _2443 = _2444;
    }
    float _2435;
    do
    {
        float _1777 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
        float _1779 = sin(_1777);
        float _1781 = cos(_1777);
        float _1789 = (_2544.z / _2544.w) - _mtl_u.u_params1.x;
        float2 _1878 = _2544.xy / float2(_2544.w);
        int _2424;
        float _2425;
        _2425 = 0.0;
        _2424 = 0;
        int _2449;
        float _2450;
        for (int _2423 = 0; _2423 < 16; _2425 = _2450, _2424 = _2449, _2423++)
        {
            float _1948 = float(_2423);
            float _1956 = _1948 * 2.3999631404876708984375;
            float2 _1963 = float2(cos(_1956), sin(_1956)) * sqrt((_1948 + 0.5) * 0.100000001490116119384765625);
            float _1967 = _1963.x;
            float _1972 = _1963.y;
            float4 _1997 = s_shadowMap0.sample(s_shadowMap0Sampler, (_1878 + (float2((_1967 * _1781) - (_1972 * _1779), (_1967 * _1779) + (_1972 * _1781)) * float2(0.00999999977648258209228515625))));
            float _2001 = dot(_1997, float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0));
            if (_2001 < _1789)
            {
                _2450 = _2425 + _2001;
                _2449 = _2424 + 1;
            }
            else
            {
                _2450 = _2425;
                _2449 = _2424;
            }
        }
        float _2427;
        if (_2424 > 0)
        {
            _2427 = _2425 / float(_2424);
        }
        else
        {
            _2427 = -1.0;
        }
        if (_2427 < (-0.9900000095367431640625))
        {
            _2435 = 1.0;
            break;
        }
        float _1809 = fast::max(0.0, _1789 - _2427);
        float2 _1829 = float2(fast::clamp((_mtl_u.u_smSamplingParams.z * _1809) / _2427, 0.0, 0.25), fast::clamp((_mtl_u.u_smSamplingParams.w * _1809) / _2427, 0.0, 0.25));
        float _2431;
        _2431 = 0.0;
        float _2036;
        for (int _2430 = 0; _2430 < 16; _2431 = _2036, _2430++)
        {
            float _2055 = float(_2430);
            float _2063 = _2055 * 2.3999631404876708984375;
            float2 _2070 = float2(cos(_2063), sin(_2063)) * sqrt((_2055 + 0.5) * 0.100000001490116119384765625);
            float _2074 = _2070.x;
            float _2079 = _2070.y;
            float4 _2030 = _2544 + float4(float2((_2074 * _1781) - (_2079 * _1779), (_2074 * _1779) + (_2079 * _1781)) * _1829, 0.0, 0.0);
            float _2432;
            do
            {
                float _2119 = _2030.w;
                float2 _2121 = _2030.xy / float2(_2119);
                if (any(_2121 > float2(1.0)) || any(_2121 < float2(0.0)))
                {
                    _2432 = 1.0;
                    break;
                }
                _2432 = step((_2030.z - _mtl_u.u_params1.x) / _2119, dot(s_shadowMap0.sample(s_shadowMap0Sampler, _2121, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                break;
            } while(false);
            _2036 = _2431 + _2432;
        }
        _2435 = mix(1.0, _2431 * 0.0625, smoothstep(0.0, 0.25, float(_2424) * 0.0625));
        break;
    } while(false);
    float _2436;
    float3 _2437;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _2219 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _2223 = fast::normalize(_2219);
        float _2256 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _2238 = length(_2219);
        _2437 = _2223;
        _2436 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _2238)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _2238) * _2238))) * mix(fast::clamp((fast::max(0.0, dot(-_2223, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _2256) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _2256), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _2437 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _2436 = 1.0;
    }
    float _2303 = dot(in.v_normal, _2437);
    float2 _1491 = fast::max(float2(_2303, ((step(0.0, _2303) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _2303)) - _2437, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _2436;
    float _1499 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1491.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1491.y)) * _mtl_u.u_color.xyz) * _2435))), float3(0.4545454680919647216796875)) + (_2443 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1499) * _1499) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

