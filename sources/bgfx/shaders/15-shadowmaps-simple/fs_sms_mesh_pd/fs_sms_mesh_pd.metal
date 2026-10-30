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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_shadowMap [[texture(0)]], sampler s_shadowMapSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _677 = fast::normalize(_mtl_u.u_lightPos.xyz);
    float _726 = dot(in.v_normal, -_677);
    float2 _750 = fast::max(float2(_726, (step(0.0, _726) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _726)) + _677, -fast::normalize(in.v_view))), 1.0)) * 0.375), float2(0.0));
    float _1690;
    do
    {
        float2 _823 = in.v_shadowcoord.xy / float2(in.v_shadowcoord.w);
        if (any(_823 > float2(1.0)) || any(_823 < float2(0.0)))
        {
            _1690 = 1.0;
            break;
        }
        float2 _839 = float2(0.001953125) * in.v_shadowcoord.w;
        float4 _846 = in.v_shadowcoord + float4(float2(-1.5) * _839, 0.0, 0.0);
        float3 _1066 = _846.xyz / float3(_846.w);
        float4 _858 = in.v_shadowcoord + float4(float2(-1.5, -0.5) * _839, 0.0, 0.0);
        float3 _1101 = _858.xyz / float3(_858.w);
        float4 _870 = in.v_shadowcoord + float4(float2(-1.5, 0.5) * _839, 0.0, 0.0);
        float3 _1136 = _870.xyz / float3(_870.w);
        float4 _882 = in.v_shadowcoord + float4(float2(-1.5, 1.5) * _839, 0.0, 0.0);
        float3 _1171 = _882.xyz / float3(_882.w);
        float4 _894 = in.v_shadowcoord + float4(float2(-0.5, -1.5) * _839, 0.0, 0.0);
        float3 _1206 = _894.xyz / float3(_894.w);
        float4 _906 = in.v_shadowcoord + float4(float2(-0.5) * _839, 0.0, 0.0);
        float3 _1241 = _906.xyz / float3(_906.w);
        float4 _918 = in.v_shadowcoord + float4(float2(-0.5, 0.5) * _839, 0.0, 0.0);
        float3 _1276 = _918.xyz / float3(_918.w);
        float4 _930 = in.v_shadowcoord + float4(float2(-0.5, 1.5) * _839, 0.0, 0.0);
        float3 _1311 = _930.xyz / float3(_930.w);
        float4 _942 = in.v_shadowcoord + float4(float2(0.5, -1.5) * _839, 0.0, 0.0);
        float3 _1346 = _942.xyz / float3(_942.w);
        float4 _954 = in.v_shadowcoord + float4(float2(0.5, -0.5) * _839, 0.0, 0.0);
        float3 _1381 = _954.xyz / float3(_954.w);
        float _959 = ((((((((step(_1066.z - 0.004999999888241291046142578125, dot(s_shadowMap.sample(s_shadowMapSampler, _1066.xy), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0))) + step(_1101.z - 0.004999999888241291046142578125, dot(s_shadowMap.sample(s_shadowMapSampler, _1101.xy), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)))) + step(_1136.z - 0.004999999888241291046142578125, dot(s_shadowMap.sample(s_shadowMapSampler, _1136.xy), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)))) + step(_1171.z - 0.004999999888241291046142578125, dot(s_shadowMap.sample(s_shadowMapSampler, _1171.xy), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)))) + step(_1206.z - 0.004999999888241291046142578125, dot(s_shadowMap.sample(s_shadowMapSampler, _1206.xy), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)))) + step(_1241.z - 0.004999999888241291046142578125, dot(s_shadowMap.sample(s_shadowMapSampler, _1241.xy), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)))) + step(_1276.z - 0.004999999888241291046142578125, dot(s_shadowMap.sample(s_shadowMapSampler, _1276.xy), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)))) + step(_1311.z - 0.004999999888241291046142578125, dot(s_shadowMap.sample(s_shadowMapSampler, _1311.xy), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)))) + step(_1346.z - 0.004999999888241291046142578125, dot(s_shadowMap.sample(s_shadowMapSampler, _1346.xy), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)))) + step(_1381.z - 0.004999999888241291046142578125, dot(s_shadowMap.sample(s_shadowMapSampler, _1381.xy), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
        float4 _966 = in.v_shadowcoord + float4(float2(0.5) * _839, 0.0, 0.0);
        float3 _1416 = _966.xyz / float3(_966.w);
        float4 _978 = in.v_shadowcoord + float4(float2(0.5, 1.5) * _839, 0.0, 0.0);
        float3 _1451 = _978.xyz / float3(_978.w);
        float4 _990 = in.v_shadowcoord + float4(float2(1.5, -1.5) * _839, 0.0, 0.0);
        float3 _1486 = _990.xyz / float3(_990.w);
        float4 _1002 = in.v_shadowcoord + float4(float2(1.5, -0.5) * _839, 0.0, 0.0);
        float3 _1521 = _1002.xyz / float3(_1002.w);
        float4 _1014 = in.v_shadowcoord + float4(float2(1.5, 0.5) * _839, 0.0, 0.0);
        float3 _1556 = _1014.xyz / float3(_1014.w);
        float4 _1026 = in.v_shadowcoord + float4(float2(1.5) * _839, 0.0, 0.0);
        float3 _1591 = _1026.xyz / float3(_1026.w);
        _1690 = ((((((_959 + step(_1416.z - 0.004999999888241291046142578125, dot(s_shadowMap.sample(s_shadowMapSampler, _1416.xy), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)))) + step(_1451.z - 0.004999999888241291046142578125, dot(s_shadowMap.sample(s_shadowMapSampler, _1451.xy), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)))) + step(_1486.z - 0.004999999888241291046142578125, dot(s_shadowMap.sample(s_shadowMapSampler, _1486.xy), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)))) + step(_1521.z - 0.004999999888241291046142578125, dot(s_shadowMap.sample(s_shadowMapSampler, _1521.xy), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)))) + step(_1556.z - 0.004999999888241291046142578125, dot(s_shadowMap.sample(s_shadowMapSampler, _1556.xy), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)))) + step(_1591.z - 0.004999999888241291046142578125, dot(s_shadowMap.sample(s_shadowMapSampler, _1591.xy), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)))) * 0.0625;
        break;
    } while(false);
    out.bgfx_FragData0 = float4(powr(abs(abs(float3(0.100000001490116119384765625) + ((float3(1.0) * (_750.x + _750.y)) * _1690))), float3(0.4545454680919647216796875)), 1.0);
    return out;
}

