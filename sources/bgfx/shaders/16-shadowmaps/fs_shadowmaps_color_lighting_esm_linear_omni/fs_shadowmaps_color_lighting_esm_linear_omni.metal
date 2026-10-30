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
    float _974 = dot(_mtl_u.u_tetraNormalGreen.xyz, in.v_position.xyz);
    float _980 = dot(_mtl_u.u_tetraNormalYellow.xyz, in.v_position.xyz);
    float _986 = dot(_mtl_u.u_tetraNormalBlue.xyz, in.v_position.xyz);
    float _1004 = fast::max(fast::max(_974, _980), fast::max(_986, dot(_mtl_u.u_tetraNormalRed.xyz, in.v_position.xyz)));
    float3 _1698;
    float4 _1753;
    if (_974 == _1004)
    {
        float2 _1016 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
        float _1018 = (all(_1016 > float2(0.0)) && all(_1016 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
        float _1020 = -_1018;
        _1753 = in.v_texcoord1;
        _1698 = float3(_1020, _1018, _1020);
    }
    else
    {
        float3 _1699;
        float4 _1754;
        if (_980 == _1004)
        {
            float2 _1037 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
            float _1039 = (all(_1037 > float2(0.0)) && all(_1037 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
            _1754 = in.v_texcoord2;
            _1699 = float3(_1039, _1039, -_1039);
        }
        else
        {
            bool _1048 = _986 == _1004;
            float3 _1700;
            if (_1048)
            {
                float2 _1056 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
                float _1058 = (all(_1056 > float2(0.0)) && all(_1056 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1060 = -_1058;
                _1700 = float3(_1060, _1060, _1058);
            }
            else
            {
                float2 _1072 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1074 = (all(_1072 > float2(0.0)) && all(_1072 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1077 = -_1074;
                _1700 = float3(_1074, _1077, _1077);
            }
            _1754 = select(in.v_texcoord4, in.v_texcoord3, bool4(_1048));
            _1699 = _1700;
        }
        _1753 = _1754;
        _1698 = _1699;
    }
    float _1692;
    do
    {
        float2 _1394 = float4(_1753.xy / float2(_1753.w), _1753.z, 1.0).xy;
        if (any(_1394 > float2(1.0)) || any(_1394 < float2(0.0)))
        {
            _1692 = 1.0;
            break;
        }
        _1692 = fast::clamp(exp((_mtl_u.u_params1.w * _mtl_u.u_params1.z) * (dot(s_shadowMap0.sample(s_shadowMap0Sampler, _1394), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)) - (_1753.z - _mtl_u.u_params1.x))), 0.0, 1.0);
        break;
    } while(false);
    float _1693;
    float3 _1694;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _1492 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _1496 = fast::normalize(_1492);
        float _1529 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _1511 = length(_1492);
        _1694 = _1496;
        _1693 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _1511)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _1511) * _1511))) * mix(fast::clamp((fast::max(0.0, dot(-_1496, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _1529) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _1529), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _1694 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _1693 = 1.0;
    }
    float _1576 = dot(in.v_normal, _1694);
    float2 _1127 = fast::max(float2(_1576, ((step(0.0, _1576) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _1576)) - _1694, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _1693;
    float _1135 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1127.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1127.y)) * _mtl_u.u_color.xyz) * _1692))), float3(0.4545454680919647216796875)) + (_1698 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1135) * _1135) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

