#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_lightDir;
    float4x4 u_invMvp;
    float4x4 u_lightMtx;
    float4 u_shadowDimsInv;
    float4 u_rsmAmount;
};

constant float4 _1949 = {};

constant uint bgfx_sampleMask [[function_constant(0)]];
constant bool bgfx_sampleMaskEnabled = is_function_constant_defined(bgfx_sampleMask);

struct xlatMtlMain_out
{
	uint bgfx_metal_sampleMask [[sample_mask, function_constant(bgfx_sampleMaskEnabled)]];
    float4 bgfx_FragData0 [[color(0)]];
};

struct xlatMtlMain_in
{
    float2 v_texcoord0 [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_normal [[texture(0)]], texture2d<float> s_color [[texture(1)]], texture2d<float> s_light [[texture(2)]], texture2d<float> s_depth [[texture(3)]], depth2d<float> s_shadowMap [[texture(4)]], sampler s_normalSampler [[sampler(0)]], sampler s_colorSampler [[sampler(1)]], sampler s_lightSampler [[sampler(2)]], sampler s_depthSampler [[sampler(3)]], sampler s_shadowMapSamplerComparison [[sampler(4)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _908 = s_normal.sample(s_normalSampler, in.v_texcoord0);
    float3 _788 = (_908.xyz * 2.0) + float3(-1.0);
    float4 _917 = s_depth.sample(s_depthSampler, in.v_texcoord0);
    float2 _808 = (in.v_texcoord0 * 2.0) - float2(1.0);
    float4 _934 = _mtl_u.u_invMvp * float4(_808.x, -_808.y, _917.x, 1.0);
    float4 _832 = _mtl_u.u_lightMtx * float4((_934.xyz / float3(_934.w)) + (_788 * 0.0030000000260770320892333984375), 1.0);
    float4 _1892 = _832;
    _1892.y = -_832.y;
    float _841 = _832.w;
    float2 _845 = _1892.xy / float2(_841);
    float4 _1895;
    _1895.x = _845.x;
    _1895.y = _845.y;
    float2 _854 = (_1895.xy * 0.5) + float2(0.5);
    float4 _1899;
    _1899.x = _854.x;
    _1899.y = _854.y;
    _1899.z = _832.z;
    float _1880;
    do
    {
        if (any(_1899.xy > float2(1.0)) || any(_1899.xy < float2(0.0)))
        {
            _1880 = 1.0;
            break;
        }
        float2 _1032 = float2(_mtl_u.u_shadowDimsInv.x) * _841;
        float4 _1039 = _1899 + float4(float2(-1.5) * _1032, 0.0, 0.0);
        float _1259 = _1039.z - 0.001000000047497451305389404296875;
        float4 _1051 = _1899 + float4(float2(-1.5, -0.5) * _1032, 0.0, 0.0);
        float _1292 = _1051.z - 0.001000000047497451305389404296875;
        float4 _1063 = _1899 + float4(float2(-1.5, 0.5) * _1032, 0.0, 0.0);
        float _1325 = _1063.z - 0.001000000047497451305389404296875;
        float4 _1075 = _1899 + float4(float2(-1.5, 1.5) * _1032, 0.0, 0.0);
        float _1358 = _1075.z - 0.001000000047497451305389404296875;
        float4 _1087 = _1899 + float4(float2(-0.5, -1.5) * _1032, 0.0, 0.0);
        float _1391 = _1087.z - 0.001000000047497451305389404296875;
        float4 _1099 = _1899 + float4(float2(-0.5) * _1032, 0.0, 0.0);
        float _1424 = _1099.z - 0.001000000047497451305389404296875;
        float4 _1111 = _1899 + float4(float2(-0.5, 0.5) * _1032, 0.0, 0.0);
        float _1457 = _1111.z - 0.001000000047497451305389404296875;
        float4 _1123 = _1899 + float4(float2(-0.5, 1.5) * _1032, 0.0, 0.0);
        float _1490 = _1123.z - 0.001000000047497451305389404296875;
        float4 _1135 = _1899 + float4(float2(0.5, -1.5) * _1032, 0.0, 0.0);
        float _1523 = _1135.z - 0.001000000047497451305389404296875;
        float4 _1147 = _1899 + float4(float2(0.5, -0.5) * _1032, 0.0, 0.0);
        float _1556 = _1147.z - 0.001000000047497451305389404296875;
        float4 _1159 = _1899 + float4(float2(0.5) * _1032, 0.0, 0.0);
        float _1589 = _1159.z - 0.001000000047497451305389404296875;
        float _1164 = (((((((((s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1039.xy, _1259).xy, _1259, level(0.0)) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1051.xy, _1292).xy, _1292, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1063.xy, _1325).xy, _1325, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1075.xy, _1358).xy, _1358, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1087.xy, _1391).xy, _1391, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1099.xy, _1424).xy, _1424, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1111.xy, _1457).xy, _1457, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1123.xy, _1490).xy, _1490, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1135.xy, _1523).xy, _1523, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1147.xy, _1556).xy, _1556, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1159.xy, _1589).xy, _1589, level(0.0));
        float4 _1171 = _1899 + float4(float2(0.5, 1.5) * _1032, 0.0, 0.0);
        float _1622 = _1171.z - 0.001000000047497451305389404296875;
        float4 _1183 = _1899 + float4(float2(1.5, -1.5) * _1032, 0.0, 0.0);
        float _1655 = _1183.z - 0.001000000047497451305389404296875;
        float4 _1195 = _1899 + float4(float2(1.5, -0.5) * _1032, 0.0, 0.0);
        float _1688 = _1195.z - 0.001000000047497451305389404296875;
        float4 _1207 = _1899 + float4(float2(1.5, 0.5) * _1032, 0.0, 0.0);
        float _1721 = _1207.z - 0.001000000047497451305389404296875;
        float4 _1219 = _1899 + float4(float2(1.5) * _1032, 0.0, 0.0);
        float _1754 = _1219.z - 0.001000000047497451305389404296875;
        _1880 = (((((_1164 + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1171.xy, _1622).xy, _1622, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1183.xy, _1655).xy, _1655, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1195.xy, _1688).xy, _1688, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1207.xy, _1721).xy, _1721, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1219.xy, _1754).xy, _1754, level(0.0))) * 0.0625;
        break;
    } while(false);
    float3 _874 = s_color.sample(s_colorSampler, in.v_texcoord0).xyz;
    out.bgfx_FragData0 = float4(mix(_874 * (fast::max(0.0, dot(_788, _mtl_u.u_lightDir.xyz)) * _1880), s_light.sample(s_lightSampler, in.v_texcoord0).xyz * _874, float3(_mtl_u.u_rsmAmount.x)), 1.0);
    return out;
}

