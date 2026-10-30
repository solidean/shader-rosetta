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
    float _997 = dot(_mtl_u.u_tetraNormalGreen.xyz, in.v_position.xyz);
    float _1003 = dot(_mtl_u.u_tetraNormalYellow.xyz, in.v_position.xyz);
    float _1009 = dot(_mtl_u.u_tetraNormalBlue.xyz, in.v_position.xyz);
    float _1027 = fast::max(fast::max(_997, _1003), fast::max(_1009, dot(_mtl_u.u_tetraNormalRed.xyz, in.v_position.xyz)));
    float3 _1749;
    float4 _1807;
    if (_997 == _1027)
    {
        float2 _1039 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
        float _1041 = (all(_1039 > float2(0.0)) && all(_1039 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
        float _1043 = -_1041;
        _1807 = in.v_texcoord1;
        _1749 = float3(_1043, _1041, _1043);
    }
    else
    {
        float3 _1750;
        float4 _1808;
        if (_1003 == _1027)
        {
            float2 _1060 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
            float _1062 = (all(_1060 > float2(0.0)) && all(_1060 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
            _1808 = in.v_texcoord2;
            _1750 = float3(_1062, _1062, -_1062);
        }
        else
        {
            bool _1071 = _1009 == _1027;
            float3 _1751;
            if (_1071)
            {
                float2 _1079 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
                float _1081 = (all(_1079 > float2(0.0)) && all(_1079 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1083 = -_1081;
                _1751 = float3(_1083, _1083, _1081);
            }
            else
            {
                float2 _1095 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1097 = (all(_1095 > float2(0.0)) && all(_1095 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1100 = -_1097;
                _1751 = float3(_1097, _1100, _1100);
            }
            _1808 = select(in.v_texcoord4, in.v_texcoord3, bool4(_1071));
            _1750 = _1751;
        }
        _1807 = _1808;
        _1749 = _1750;
    }
    float _1743;
    do
    {
        float2 _1415 = _1807.xy / float2(_1807.w);
        if (any(_1415 > float2(1.0)) || any(_1415 < float2(0.0)))
        {
            _1743 = 1.0;
            break;
        }
        float _1436 = ((_1807.z - _mtl_u.u_params1.x) / _1807.w) * _mtl_u.u_params1.w;
        float4 _1505 = s_shadowMap0.sample(s_shadowMap0Sampler, _1415);
        float2 _1448 = float2(dot(_1505.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_1505.zw, float2(0.0039215688593685626983642578125, 1.0))) * _mtl_u.u_params1.w;
        float _1451 = _1448.x;
        if (_1436 < _1451)
        {
            _1743 = 1.0;
            break;
        }
        float _1464 = fast::max(_1448.y - (_1451 * _1451), _mtl_u.u_params1.z);
        float _1468 = _1436 - _1451;
        _1743 = _1464 / (_1464 + (_1468 * _1468));
        break;
    } while(false);
    float _1744;
    float3 _1745;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _1543 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _1547 = fast::normalize(_1543);
        float _1580 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _1562 = length(_1543);
        _1745 = _1547;
        _1744 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _1562)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _1562) * _1562))) * mix(fast::clamp((fast::max(0.0, dot(-_1547, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _1580) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _1580), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _1745 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _1744 = 1.0;
    }
    float _1627 = dot(in.v_normal, _1745);
    float2 _1150 = fast::max(float2(_1627, ((step(0.0, _1627) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _1627)) - _1745, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _1744;
    float _1158 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1150.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1150.y)) * _mtl_u.u_color.xyz) * _1743))), float3(0.4545454680919647216796875)) + (_1749 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1158) * _1158) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

