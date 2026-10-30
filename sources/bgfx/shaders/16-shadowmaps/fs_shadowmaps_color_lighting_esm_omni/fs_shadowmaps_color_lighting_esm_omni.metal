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
    float _964 = dot(_mtl_u.u_tetraNormalGreen.xyz, in.v_position.xyz);
    float _970 = dot(_mtl_u.u_tetraNormalYellow.xyz, in.v_position.xyz);
    float _976 = dot(_mtl_u.u_tetraNormalBlue.xyz, in.v_position.xyz);
    float _994 = fast::max(fast::max(_964, _970), fast::max(_976, dot(_mtl_u.u_tetraNormalRed.xyz, in.v_position.xyz)));
    float3 _1678;
    float4 _1731;
    if (_964 == _994)
    {
        float2 _1006 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
        float _1008 = (all(_1006 > float2(0.0)) && all(_1006 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
        float _1010 = -_1008;
        _1731 = in.v_texcoord1;
        _1678 = float3(_1010, _1008, _1010);
    }
    else
    {
        float3 _1679;
        float4 _1732;
        if (_970 == _994)
        {
            float2 _1027 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
            float _1029 = (all(_1027 > float2(0.0)) && all(_1027 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
            _1732 = in.v_texcoord2;
            _1679 = float3(_1029, _1029, -_1029);
        }
        else
        {
            bool _1038 = _976 == _994;
            float3 _1680;
            if (_1038)
            {
                float2 _1046 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
                float _1048 = (all(_1046 > float2(0.0)) && all(_1046 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1050 = -_1048;
                _1680 = float3(_1050, _1050, _1048);
            }
            else
            {
                float2 _1062 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1064 = (all(_1062 > float2(0.0)) && all(_1062 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1067 = -_1064;
                _1680 = float3(_1064, _1067, _1067);
            }
            _1732 = select(in.v_texcoord4, in.v_texcoord3, bool4(_1038));
            _1679 = _1680;
        }
        _1731 = _1732;
        _1678 = _1679;
    }
    float _1672;
    do
    {
        float2 _1378 = _1731.xy / float2(_1731.w);
        if (any(_1378 > float2(1.0)) || any(_1378 < float2(0.0)))
        {
            _1672 = 1.0;
            break;
        }
        _1672 = fast::clamp(exp((_mtl_u.u_params1.w * _mtl_u.u_params1.z) * (dot(s_shadowMap0.sample(s_shadowMap0Sampler, _1378), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)) - ((_1731.z - _mtl_u.u_params1.x) / _1731.w))), 0.0, 1.0);
        break;
    } while(false);
    float _1673;
    float3 _1674;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _1472 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _1476 = fast::normalize(_1472);
        float _1509 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _1491 = length(_1472);
        _1674 = _1476;
        _1673 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _1491)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _1491) * _1491))) * mix(fast::clamp((fast::max(0.0, dot(-_1476, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _1509) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _1509), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _1674 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _1673 = 1.0;
    }
    float _1556 = dot(in.v_normal, _1674);
    float2 _1117 = fast::max(float2(_1556, ((step(0.0, _1556) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _1556)) - _1674, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _1673;
    float _1125 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1117.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1117.y)) * _mtl_u.u_color.xyz) * _1672))), float3(0.4545454680919647216796875)) + (_1678 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1125) * _1125) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

