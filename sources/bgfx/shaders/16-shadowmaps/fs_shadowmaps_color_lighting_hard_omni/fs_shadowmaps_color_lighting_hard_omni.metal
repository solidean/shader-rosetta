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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_shadowMap0 [[texture(4)]], sampler s_shadowMap0Sampler [[sampler(4)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float _976 = dot(_mtl_u.u_tetraNormalGreen.xyz, in.v_position.xyz);
    float _982 = dot(_mtl_u.u_tetraNormalYellow.xyz, in.v_position.xyz);
    float _988 = dot(_mtl_u.u_tetraNormalBlue.xyz, in.v_position.xyz);
    float _1006 = fast::max(fast::max(_976, _982), fast::max(_988, dot(_mtl_u.u_tetraNormalRed.xyz, in.v_position.xyz)));
    float3 _1695;
    float4 _1748;
    if (_976 == _1006)
    {
        float2 _1018 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
        float _1020 = (all(_1018 > float2(0.0)) && all(_1018 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
        float _1022 = -_1020;
        _1748 = in.v_texcoord1;
        _1695 = float3(_1022, _1020, _1022);
    }
    else
    {
        float3 _1696;
        float4 _1749;
        if (_982 == _1006)
        {
            float2 _1039 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
            float _1041 = (all(_1039 > float2(0.0)) && all(_1039 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
            _1749 = in.v_texcoord2;
            _1696 = float3(_1041, _1041, -_1041);
        }
        else
        {
            bool _1050 = _988 == _1006;
            float3 _1697;
            if (_1050)
            {
                float2 _1058 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
                float _1060 = (all(_1058 > float2(0.0)) && all(_1058 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1062 = -_1060;
                _1697 = float3(_1062, _1062, _1060);
            }
            else
            {
                float2 _1074 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1076 = (all(_1074 > float2(0.0)) && all(_1074 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1079 = -_1076;
                _1697 = float3(_1076, _1079, _1079);
            }
            _1749 = select(in.v_texcoord4, in.v_texcoord3, bool4(_1050));
            _1696 = _1697;
        }
        _1748 = _1749;
        _1695 = _1696;
    }
    float _1689;
    do
    {
        float2 _1397 = _1748.xy / float2(_1748.w);
        if (any(_1397 > float2(1.0)) || any(_1397 < float2(0.0)))
        {
            _1689 = 1.0;
            break;
        }
        _1689 = step((_1748.z - _mtl_u.u_params1.x) / _1748.w, dot(s_shadowMap0.sample(s_shadowMap0Sampler, _1397, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
        break;
    } while(false);
    float _1690;
    float3 _1691;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _1489 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _1493 = fast::normalize(_1489);
        float _1526 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _1508 = length(_1489);
        _1691 = _1493;
        _1690 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _1508)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _1508) * _1508))) * mix(fast::clamp((fast::max(0.0, dot(-_1493, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _1526) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _1526), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _1691 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _1690 = 1.0;
    }
    float _1573 = dot(in.v_normal, _1691);
    float2 _1129 = fast::max(float2(_1573, ((step(0.0, _1573) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _1573)) - _1691, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _1690;
    float _1137 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1129.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1129.y)) * _mtl_u.u_color.xyz) * _1689))), float3(0.4545454680919647216796875)) + (_1695 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1137) * _1137) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

