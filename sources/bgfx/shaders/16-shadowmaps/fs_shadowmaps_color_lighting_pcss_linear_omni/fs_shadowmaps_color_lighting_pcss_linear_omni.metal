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
    float _1348 = dot(_mtl_u.u_tetraNormalGreen.xyz, in.v_position.xyz);
    float _1354 = dot(_mtl_u.u_tetraNormalYellow.xyz, in.v_position.xyz);
    float _1360 = dot(_mtl_u.u_tetraNormalBlue.xyz, in.v_position.xyz);
    float _1378 = fast::max(fast::max(_1348, _1354), fast::max(_1360, dot(_mtl_u.u_tetraNormalRed.xyz, in.v_position.xyz)));
    float3 _2463;
    float4 _2566;
    if (_1348 == _1378)
    {
        float2 _1390 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
        float _1392 = (all(_1390 > float2(0.0)) && all(_1390 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
        float _1394 = -_1392;
        _2566 = in.v_texcoord1;
        _2463 = float3(_1394, _1392, _1394);
    }
    else
    {
        float3 _2464;
        float4 _2567;
        if (_1354 == _1378)
        {
            float2 _1411 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
            float _1413 = (all(_1411 > float2(0.0)) && all(_1411 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
            _2567 = in.v_texcoord2;
            _2464 = float3(_1413, _1413, -_1413);
        }
        else
        {
            bool _1422 = _1360 == _1378;
            float3 _2465;
            if (_1422)
            {
                float2 _1430 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
                float _1432 = (all(_1430 > float2(0.0)) && all(_1430 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1434 = -_1432;
                _2465 = float3(_1434, _1434, _1432);
            }
            else
            {
                float2 _1446 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1448 = (all(_1446 > float2(0.0)) && all(_1446 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1451 = -_1448;
                _2465 = float3(_1448, _1451, _1451);
            }
            _2567 = select(in.v_texcoord4, in.v_texcoord3, bool4(_1422));
            _2464 = _2465;
        }
        _2566 = _2567;
        _2463 = _2464;
    }
    float4 _1741 = float4(_2566.xy / float2(_2566.w), _2566.z, 1.0);
    float _2455;
    do
    {
        float _1797 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
        float _1799 = sin(_1797);
        float _1801 = cos(_1797);
        float _1809 = _2566.z - _mtl_u.u_params1.x;
        float2 _1894 = _1741.xy;
        int _2444;
        float _2445;
        _2445 = 0.0;
        _2444 = 0;
        int _2469;
        float _2470;
        for (int _2443 = 0; _2443 < 16; _2445 = _2470, _2444 = _2469, _2443++)
        {
            float _1968 = float(_2443);
            float _1976 = _1968 * 2.3999631404876708984375;
            float2 _1983 = float2(cos(_1976), sin(_1976)) * sqrt((_1968 + 0.5) * 0.100000001490116119384765625);
            float _1987 = _1983.x;
            float _1992 = _1983.y;
            float4 _2017 = s_shadowMap0.sample(s_shadowMap0Sampler, (_1894 + (float2((_1987 * _1801) - (_1992 * _1799), (_1987 * _1799) + (_1992 * _1801)) * float2(0.00999999977648258209228515625))));
            float _2021 = dot(_2017, float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0));
            if (_2021 < _1809)
            {
                _2470 = _2445 + _2021;
                _2469 = _2444 + 1;
            }
            else
            {
                _2470 = _2445;
                _2469 = _2444;
            }
        }
        float _2447;
        if (_2444 > 0)
        {
            _2447 = _2445 / float(_2444);
        }
        else
        {
            _2447 = -1.0;
        }
        if (_2447 < (-0.9900000095367431640625))
        {
            _2455 = 1.0;
            break;
        }
        float _1829 = fast::max(0.0, _1809 - _2447);
        float2 _1849 = float2(fast::clamp((_mtl_u.u_smSamplingParams.z * _1829) / _2447, 0.0, 0.25), fast::clamp((_mtl_u.u_smSamplingParams.w * _1829) / _2447, 0.0, 0.25));
        float _2451;
        _2451 = 0.0;
        float _2056;
        for (int _2450 = 0; _2450 < 16; _2451 = _2056, _2450++)
        {
            float _2075 = float(_2450);
            float _2083 = _2075 * 2.3999631404876708984375;
            float2 _2090 = float2(cos(_2083), sin(_2083)) * sqrt((_2075 + 0.5) * 0.100000001490116119384765625);
            float _2094 = _2090.x;
            float _2099 = _2090.y;
            float4 _2050 = _1741 + float4(float2((_2094 * _1801) - (_2099 * _1799), (_2094 * _1799) + (_2099 * _1801)) * _1849, 0.0, 0.0);
            float _2452;
            do
            {
                float _2139 = _2050.w;
                float2 _2141 = _2050.xy / float2(_2139);
                if (any(_2141 > float2(1.0)) || any(_2141 < float2(0.0)))
                {
                    _2452 = 1.0;
                    break;
                }
                _2452 = step((_2050.z - _mtl_u.u_params1.x) / _2139, dot(s_shadowMap0.sample(s_shadowMap0Sampler, _2141, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
                break;
            } while(false);
            _2056 = _2451 + _2452;
        }
        _2455 = mix(1.0, _2451 * 0.0625, smoothstep(0.0, 0.25, float(_2444) * 0.0625));
        break;
    } while(false);
    float _2456;
    float3 _2457;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _2239 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _2243 = fast::normalize(_2239);
        float _2276 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _2258 = length(_2239);
        _2457 = _2243;
        _2456 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _2258)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _2258) * _2258))) * mix(fast::clamp((fast::max(0.0, dot(-_2243, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _2276) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _2276), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _2457 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _2456 = 1.0;
    }
    float _2323 = dot(in.v_normal, _2457);
    float2 _1501 = fast::max(float2(_2323, ((step(0.0, _2323) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _2323)) - _2457, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _2456;
    float _1509 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1501.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1501.y)) * _mtl_u.u_color.xyz) * _2455))), float3(0.4545454680919647216796875)) + (_2463 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1509) * _1509) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

