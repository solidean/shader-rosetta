#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_lightPos;
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
    float4 v_shadowcoord [[user(locn1)]];
    float3 v_view [[user(locn2)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], depth2d<float> s_shadowMap [[texture(0)]], sampler s_shadowMapSamplerComparison [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _673 = fast::normalize(_mtl_u.u_lightPos.xyz);
    float _722 = dot(in.v_normal, -_673);
    float2 _746 = fast::max(float2(_722, (step(0.0, _722) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _722)) + _673, -fast::normalize(in.v_view))), 1.0)) * 0.375), float2(0.0));
    float _1734;
    do
    {
        float2 _819 = in.v_shadowcoord.xy / float2(in.v_shadowcoord.w);
        if (any(_819 > float2(1.0)) || any(_819 < float2(0.0)))
        {
            _1734 = 1.0;
            break;
        }
        float2 _835 = float2(0.001953125) * in.v_shadowcoord.w;
        float4 _842 = in.v_shadowcoord + float4(float2(-1.5) * _835, 0.0, 0.0);
        float3 _1061 = _842.xyz / float3(_842.w);
        float _1067 = _1061.z - 0.004999999888241291046142578125;
        float4 _854 = in.v_shadowcoord + float4(float2(-1.5, -0.5) * _835, 0.0, 0.0);
        float3 _1099 = _854.xyz / float3(_854.w);
        float _1105 = _1099.z - 0.004999999888241291046142578125;
        float4 _866 = in.v_shadowcoord + float4(float2(-1.5, 0.5) * _835, 0.0, 0.0);
        float3 _1137 = _866.xyz / float3(_866.w);
        float _1143 = _1137.z - 0.004999999888241291046142578125;
        float4 _878 = in.v_shadowcoord + float4(float2(-1.5, 1.5) * _835, 0.0, 0.0);
        float3 _1175 = _878.xyz / float3(_878.w);
        float _1181 = _1175.z - 0.004999999888241291046142578125;
        float4 _890 = in.v_shadowcoord + float4(float2(-0.5, -1.5) * _835, 0.0, 0.0);
        float3 _1213 = _890.xyz / float3(_890.w);
        float _1219 = _1213.z - 0.004999999888241291046142578125;
        float4 _902 = in.v_shadowcoord + float4(float2(-0.5) * _835, 0.0, 0.0);
        float3 _1251 = _902.xyz / float3(_902.w);
        float _1257 = _1251.z - 0.004999999888241291046142578125;
        float4 _914 = in.v_shadowcoord + float4(float2(-0.5, 0.5) * _835, 0.0, 0.0);
        float3 _1289 = _914.xyz / float3(_914.w);
        float _1295 = _1289.z - 0.004999999888241291046142578125;
        float4 _926 = in.v_shadowcoord + float4(float2(-0.5, 1.5) * _835, 0.0, 0.0);
        float3 _1327 = _926.xyz / float3(_926.w);
        float _1333 = _1327.z - 0.004999999888241291046142578125;
        float4 _938 = in.v_shadowcoord + float4(float2(0.5, -1.5) * _835, 0.0, 0.0);
        float3 _1365 = _938.xyz / float3(_938.w);
        float _1371 = _1365.z - 0.004999999888241291046142578125;
        float4 _950 = in.v_shadowcoord + float4(float2(0.5, -0.5) * _835, 0.0, 0.0);
        float3 _1403 = _950.xyz / float3(_950.w);
        float _1409 = _1403.z - 0.004999999888241291046142578125;
        float4 _962 = in.v_shadowcoord + float4(float2(0.5) * _835, 0.0, 0.0);
        float3 _1441 = _962.xyz / float3(_962.w);
        float _1447 = _1441.z - 0.004999999888241291046142578125;
        float _967 = (((((((((s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1061.xy, _1067).xy, _1067, level(0.0)) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1099.xy, _1105).xy, _1105, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1137.xy, _1143).xy, _1143, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1175.xy, _1181).xy, _1181, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1213.xy, _1219).xy, _1219, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1251.xy, _1257).xy, _1257, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1289.xy, _1295).xy, _1295, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1327.xy, _1333).xy, _1333, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1365.xy, _1371).xy, _1371, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1403.xy, _1409).xy, _1409, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1441.xy, _1447).xy, _1447, level(0.0));
        float4 _974 = in.v_shadowcoord + float4(float2(0.5, 1.5) * _835, 0.0, 0.0);
        float3 _1479 = _974.xyz / float3(_974.w);
        float _1485 = _1479.z - 0.004999999888241291046142578125;
        float4 _986 = in.v_shadowcoord + float4(float2(1.5, -1.5) * _835, 0.0, 0.0);
        float3 _1517 = _986.xyz / float3(_986.w);
        float _1523 = _1517.z - 0.004999999888241291046142578125;
        float4 _998 = in.v_shadowcoord + float4(float2(1.5, -0.5) * _835, 0.0, 0.0);
        float3 _1555 = _998.xyz / float3(_998.w);
        float _1561 = _1555.z - 0.004999999888241291046142578125;
        float4 _1010 = in.v_shadowcoord + float4(float2(1.5, 0.5) * _835, 0.0, 0.0);
        float3 _1593 = _1010.xyz / float3(_1010.w);
        float _1599 = _1593.z - 0.004999999888241291046142578125;
        float4 _1022 = in.v_shadowcoord + float4(float2(1.5) * _835, 0.0, 0.0);
        float3 _1631 = _1022.xyz / float3(_1022.w);
        float _1637 = _1631.z - 0.004999999888241291046142578125;
        _1734 = (((((_967 + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1479.xy, _1485).xy, _1485, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1517.xy, _1523).xy, _1523, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1555.xy, _1561).xy, _1561, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1593.xy, _1599).xy, _1599, level(0.0))) + s_shadowMap.sample_compare(s_shadowMapSamplerComparison, float3(_1631.xy, _1637).xy, _1637, level(0.0))) * 0.0625;
        break;
    } while(false);
    out.bgfx_FragData0 = float4(powr(abs(abs(float3(0.100000001490116119384765625) + ((float3(1.0) * (_746.x + _746.y)) * _1734))), float3(0.4545454680919647216796875)), 1.0);
    return out;
}

