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
    float _1007 = dot(_mtl_u.u_tetraNormalGreen.xyz, in.v_position.xyz);
    float _1013 = dot(_mtl_u.u_tetraNormalYellow.xyz, in.v_position.xyz);
    float _1019 = dot(_mtl_u.u_tetraNormalBlue.xyz, in.v_position.xyz);
    float _1037 = fast::max(fast::max(_1007, _1013), fast::max(_1019, dot(_mtl_u.u_tetraNormalRed.xyz, in.v_position.xyz)));
    float3 _1769;
    float4 _1829;
    if (_1007 == _1037)
    {
        float2 _1049 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
        float _1051 = (all(_1049 > float2(0.0)) && all(_1049 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
        float _1053 = -_1051;
        _1829 = in.v_texcoord1;
        _1769 = float3(_1053, _1051, _1053);
    }
    else
    {
        float3 _1770;
        float4 _1830;
        if (_1013 == _1037)
        {
            float2 _1070 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
            float _1072 = (all(_1070 > float2(0.0)) && all(_1070 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
            _1830 = in.v_texcoord2;
            _1770 = float3(_1072, _1072, -_1072);
        }
        else
        {
            bool _1081 = _1019 == _1037;
            float3 _1771;
            if (_1081)
            {
                float2 _1089 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
                float _1091 = (all(_1089 > float2(0.0)) && all(_1089 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1093 = -_1091;
                _1771 = float3(_1093, _1093, _1091);
            }
            else
            {
                float2 _1105 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1107 = (all(_1105 > float2(0.0)) && all(_1105 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1110 = -_1107;
                _1771 = float3(_1107, _1110, _1110);
            }
            _1830 = select(in.v_texcoord4, in.v_texcoord3, bool4(_1081));
            _1770 = _1771;
        }
        _1829 = _1830;
        _1769 = _1770;
    }
    float _1763;
    do
    {
        float2 _1431 = float4(_1829.xy / float2(_1829.w), _1829.z, 1.0).xy;
        if (any(_1431 > float2(1.0)) || any(_1431 < float2(0.0)))
        {
            _1763 = 1.0;
            break;
        }
        float _1456 = (_1829.z - _mtl_u.u_params1.x) * _mtl_u.u_params1.w;
        float4 _1525 = s_shadowMap0.sample(s_shadowMap0Sampler, _1431);
        float2 _1468 = float2(dot(_1525.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_1525.zw, float2(0.0039215688593685626983642578125, 1.0))) * _mtl_u.u_params1.w;
        float _1471 = _1468.x;
        if (_1456 < _1471)
        {
            _1763 = 1.0;
            break;
        }
        float _1484 = fast::max(_1468.y - (_1471 * _1471), _mtl_u.u_params1.z);
        float _1488 = _1456 - _1471;
        _1763 = _1484 / (_1484 + (_1488 * _1488));
        break;
    } while(false);
    float _1764;
    float3 _1765;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _1563 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _1567 = fast::normalize(_1563);
        float _1600 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _1582 = length(_1563);
        _1765 = _1567;
        _1764 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _1582)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _1582) * _1582))) * mix(fast::clamp((fast::max(0.0, dot(-_1567, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _1600) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _1600), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _1765 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _1764 = 1.0;
    }
    float _1647 = dot(in.v_normal, _1765);
    float2 _1160 = fast::max(float2(_1647, ((step(0.0, _1647) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _1647)) - _1765, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _1764;
    float _1168 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1160.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1160.y)) * _mtl_u.u_color.xyz) * _1763))), float3(0.4545454680919647216796875)) + (_1769 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1168) * _1168) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

