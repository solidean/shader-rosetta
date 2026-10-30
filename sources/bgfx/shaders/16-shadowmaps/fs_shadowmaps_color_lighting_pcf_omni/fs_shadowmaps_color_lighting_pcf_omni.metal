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
    float _1186 = dot(_mtl_u.u_tetraNormalGreen.xyz, in.v_position.xyz);
    float _1192 = dot(_mtl_u.u_tetraNormalYellow.xyz, in.v_position.xyz);
    float _1198 = dot(_mtl_u.u_tetraNormalBlue.xyz, in.v_position.xyz);
    float _1216 = fast::max(fast::max(_1186, _1192), fast::max(_1198, dot(_mtl_u.u_tetraNormalRed.xyz, in.v_position.xyz)));
    float3 _2065;
    float4 _2147;
    if (_1186 == _1216)
    {
        float2 _1228 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
        float _1230 = (all(_1228 > float2(0.0)) && all(_1228 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
        float _1232 = -_1230;
        _2147 = in.v_texcoord1;
        _2065 = float3(_1232, _1230, _1232);
    }
    else
    {
        float3 _2066;
        float4 _2148;
        if (_1192 == _1216)
        {
            float2 _1249 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
            float _1251 = (all(_1249 > float2(0.0)) && all(_1249 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
            _2148 = in.v_texcoord2;
            _2066 = float3(_1251, _1251, -_1251);
        }
        else
        {
            bool _1260 = _1198 == _1216;
            float3 _2067;
            if (_1260)
            {
                float2 _1268 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
                float _1270 = (all(_1268 > float2(0.0)) && all(_1268 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1272 = -_1270;
                _2067 = float3(_1272, _1272, _1270);
            }
            else
            {
                float2 _1284 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1286 = (all(_1284 > float2(0.0)) && all(_1284 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1289 = -_1286;
                _2067 = float3(_1286, _1289, _1289);
            }
            _2148 = select(in.v_texcoord4, in.v_texcoord3, bool4(_1260));
            _2066 = _2067;
        }
        _2147 = _2148;
        _2065 = _2066;
    }
    float _1595 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
    float _1597 = sin(_1595);
    float _1599 = cos(_1595);
    float2 _1638 = ((float2(2.0) * _mtl_u.u_smSamplingParams.zw) * float2(_mtl_u.u_params2.z * 0.25)) * _2147.w;
    float _2059;
    _2059 = 0.0;
    float _1681;
    for (int _2058 = 0; _2058 < 16; _2059 = _1681, _2058++)
    {
        float _1700 = float(_2058);
        float _1708 = _1700 * 2.3999631404876708984375;
        float2 _1715 = float2(cos(_1708), sin(_1708)) * sqrt((_1700 + 0.5) * 0.100000001490116119384765625);
        float _1719 = _1715.x;
        float _1724 = _1715.y;
        float4 _1675 = _2147 + float4(float2((_1719 * _1599) - (_1724 * _1597), (_1719 * _1597) + (_1724 * _1599)) * _1638, 0.0, 0.0);
        float _2068;
        do
        {
            float _1764 = _1675.w;
            float2 _1766 = _1675.xy / float2(_1764);
            if (any(_1766 > float2(1.0)) || any(_1766 < float2(0.0)))
            {
                _2068 = 1.0;
                break;
            }
            _2068 = step((_1675.z - _mtl_u.u_params1.x) / _1764, dot(s_shadowMap0.sample(s_shadowMap0Sampler, _1766, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
            break;
        } while(false);
        _1681 = _2059 + _2068;
    }
    float _2060;
    float3 _2061;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _1858 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _1862 = fast::normalize(_1858);
        float _1895 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _1877 = length(_1858);
        _2061 = _1862;
        _2060 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _1877)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _1877) * _1877))) * mix(fast::clamp((fast::max(0.0, dot(-_1862, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _1895) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _1895), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _2061 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _2060 = 1.0;
    }
    float _1942 = dot(in.v_normal, _2061);
    float2 _1339 = fast::max(float2(_1942, ((step(0.0, _1942) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _1942)) - _2061, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _2060;
    float _1347 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1339.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1339.y)) * _mtl_u.u_color.xyz) * (_2059 * 0.0625)))), float3(0.4545454680919647216796875)) + (_2065 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1347) * _1347) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

