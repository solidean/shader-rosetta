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
    float _1196 = dot(_mtl_u.u_tetraNormalGreen.xyz, in.v_position.xyz);
    float _1202 = dot(_mtl_u.u_tetraNormalYellow.xyz, in.v_position.xyz);
    float _1208 = dot(_mtl_u.u_tetraNormalBlue.xyz, in.v_position.xyz);
    float _1226 = fast::max(fast::max(_1196, _1202), fast::max(_1208, dot(_mtl_u.u_tetraNormalRed.xyz, in.v_position.xyz)));
    float3 _2085;
    float4 _2169;
    if (_1196 == _1226)
    {
        float2 _1238 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
        float _1240 = (all(_1238 > float2(0.0)) && all(_1238 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
        float _1242 = -_1240;
        _2169 = in.v_texcoord1;
        _2085 = float3(_1242, _1240, _1242);
    }
    else
    {
        float3 _2086;
        float4 _2170;
        if (_1202 == _1226)
        {
            float2 _1259 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
            float _1261 = (all(_1259 > float2(0.0)) && all(_1259 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
            _2170 = in.v_texcoord2;
            _2086 = float3(_1261, _1261, -_1261);
        }
        else
        {
            bool _1270 = _1208 == _1226;
            float3 _2087;
            if (_1270)
            {
                float2 _1278 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
                float _1280 = (all(_1278 > float2(0.0)) && all(_1278 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1282 = -_1280;
                _2087 = float3(_1282, _1282, _1280);
            }
            else
            {
                float2 _1294 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1296 = (all(_1294 > float2(0.0)) && all(_1294 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1299 = -_1296;
                _2087 = float3(_1296, _1299, _1299);
            }
            _2170 = select(in.v_texcoord4, in.v_texcoord3, bool4(_1270));
            _2086 = _2087;
        }
        _2169 = _2170;
        _2085 = _2086;
    }
    float4 _1589 = float4(_2169.xy / float2(_2169.w), _2169.z, 1.0);
    float _1615 = fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy, float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) * 6.28318500518798828125;
    float _1617 = sin(_1615);
    float _1619 = cos(_1615);
    float2 _1658 = ((float2(2.0) * _mtl_u.u_smSamplingParams.zw) * float2(_mtl_u.u_params2.z * 0.25)) * 1.0;
    float _2079;
    _2079 = 0.0;
    float _1701;
    for (int _2078 = 0; _2078 < 16; _2079 = _1701, _2078++)
    {
        float _1720 = float(_2078);
        float _1728 = _1720 * 2.3999631404876708984375;
        float2 _1735 = float2(cos(_1728), sin(_1728)) * sqrt((_1720 + 0.5) * 0.100000001490116119384765625);
        float _1739 = _1735.x;
        float _1744 = _1735.y;
        float4 _1695 = _1589 + float4(float2((_1739 * _1619) - (_1744 * _1617), (_1739 * _1617) + (_1744 * _1619)) * _1658, 0.0, 0.0);
        float _2088;
        do
        {
            float _1784 = _1695.w;
            float2 _1786 = _1695.xy / float2(_1784);
            if (any(_1786 > float2(1.0)) || any(_1786 < float2(0.0)))
            {
                _2088 = 1.0;
                break;
            }
            _2088 = step((_1695.z - _mtl_u.u_params1.x) / _1784, dot(s_shadowMap0.sample(s_shadowMap0Sampler, _1786, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
            break;
        } while(false);
        _1701 = _2079 + _2088;
    }
    float _2080;
    float3 _2081;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _1878 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _1882 = fast::normalize(_1878);
        float _1915 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _1897 = length(_1878);
        _2081 = _1882;
        _2080 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _1897)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _1897) * _1897))) * mix(fast::clamp((fast::max(0.0, dot(-_1882, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _1915) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _1915), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _2081 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _2080 = 1.0;
    }
    float _1962 = dot(in.v_normal, _2081);
    float2 _1349 = fast::max(float2(_1962, ((step(0.0, _1962) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _1962)) - _2081, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _2080;
    float _1357 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1349.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1349.y)) * _mtl_u.u_color.xyz) * (_2079 * 0.0625)))), float3(0.4545454680919647216796875)) + (_2085 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1357) * _1357) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

