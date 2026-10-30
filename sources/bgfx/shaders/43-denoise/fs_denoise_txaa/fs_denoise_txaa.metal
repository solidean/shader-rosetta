#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_viewTexel;
    float4 u_params[13];
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
    float2 v_texcoord0 [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_color [[texture(0)]], texture2d<float> s_previousColor [[texture(1)]], texture2d<float> s_velocity [[texture(2)]], texture2d<float> s_depth [[texture(3)]], sampler s_colorSampler [[sampler(0)]], sampler s_previousColorSampler [[sampler(1)]], sampler s_velocitySampler [[sampler(2)]], sampler s_depthSampler [[sampler(3)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _1342 = s_color.sample(s_colorSampler, in.v_texcoord0);
    float3 _1016 = _1342.xyz;
    float2 _1378 = float2(_mtl_u.u_viewTexel.x, 0.0);
    float2 _1381 = float2(0.0, _mtl_u.u_viewTexel.y);
    float2 _1384 = in.v_texcoord0 - _1378;
    float2 _1386 = _1384 - _1381;
    float4 _1561 = s_depth.sample(s_depthSampler, _1386);
    float _1391 = _1561.x;
    float2 _1397 = in.v_texcoord0 - _1381;
    float4 _1570 = s_depth.sample(s_depthSampler, _1397);
    float _1402 = _1570.x;
    float2 _1408 = in.v_texcoord0 + _1378;
    float2 _1410 = _1408 - _1381;
    float4 _1579 = s_depth.sample(s_depthSampler, _1410);
    float _1415 = _1579.x;
    float4 _1588 = s_depth.sample(s_depthSampler, _1408);
    float _1426 = _1588.x;
    float4 _1597 = s_depth.sample(s_depthSampler, in.v_texcoord0);
    float _1435 = _1597.x;
    float4 _1606 = s_depth.sample(s_depthSampler, _1384);
    float _1446 = _1606.x;
    float2 _1454 = _1384 + _1381;
    float4 _1615 = s_depth.sample(s_depthSampler, _1454);
    float _1459 = _1615.x;
    float2 _1465 = in.v_texcoord0 + _1381;
    float4 _1624 = s_depth.sample(s_depthSampler, _1465);
    float _1470 = _1624.x;
    float2 _1478 = _1408 + _1381;
    float4 _1633 = s_depth.sample(s_depthSampler, _1478);
    float _1483 = _1633.x;
    float3 _2145 = select(float3(_1386, _1391), float3(_1397, _1402), bool3(_1402 < _1391));
    float3 _2147 = select(_2145, float3(_1410, _1415), bool3(_1415 < _2145.z));
    float3 _2149 = select(_2147, float3(_1408, _1426), bool3(_1426 < _2147.z));
    float3 _2151 = select(_2149, float3(in.v_texcoord0, _1435), bool3(_1435 < _2149.z));
    float3 _2153 = select(_2151, float3(_1384, _1446), bool3(_1446 < _2151.z));
    float3 _2155 = select(_2153, float3(_1454, _1459), bool3(_1459 < _2153.z));
    float3 _2157 = select(_2155, float3(_1465, _1470), bool3(_1470 < _2155.z));
    float4 _1682 = s_color.sample(s_colorSampler, _1386);
    float3 _1045 = _1682.xyz;
    float4 _1691 = s_color.sample(s_colorSampler, _1397);
    float3 _1051 = _1691.xyz;
    float4 _1700 = s_color.sample(s_colorSampler, _1410);
    float3 _1059 = _1700.xyz;
    float4 _1709 = s_color.sample(s_colorSampler, _1408);
    float3 _1065 = _1709.xyz;
    float4 _1718 = s_color.sample(s_colorSampler, _1384);
    float3 _1071 = _1718.xyz;
    float4 _1727 = s_color.sample(s_colorSampler, _1454);
    float3 _1079 = _1727.xyz;
    float4 _1736 = s_color.sample(s_colorSampler, _1465);
    float3 _1085 = _1736.xyz;
    float4 _1745 = s_color.sample(s_colorSampler, _1478);
    float3 _1093 = _1745.xyz;
    float3 _1169 = ((((((((_1045 + _1051) + _1059) + _1071) + _1016) + _1065) + _1079) + _1085) + _1093) * 0.111111111938953399658203125;
    float3 _1199 = s_previousColor.sample(s_previousColorSampler, ((in.v_texcoord0 - s_velocity.sample(s_velocitySampler, select(_2157, float3(_1478, _1483), bool3(_1483 < _2157.z)).xy).xy) + ((_mtl_u.u_params[0].xy - _mtl_u.u_params[0].zw) * _mtl_u.u_viewTexel.xy))).xyz - _1169;
    float3 _1203 = abs(_1199 / (sqrt(fast::max(float3(0.0), ((((((((((_1045 * _1045) + (_1051 * _1051)) + (_1059 * _1059)) + (_1071 * _1071)) + (_1016 * _1016)) + (_1065 * _1065)) + (_1079 * _1079)) + (_1085 * _1085)) + (_1093 * _1093)) * 0.111111111938953399658203125) - (_1169 * _1169))) * 1.39999997615814208984375));
    float3 _1218 = _1169 + (_1199 * (1.0 / fast::max(fast::max(_1203.x, _1203.y), fast::max(_1203.z, 1.0))));
    float _1220 = dot(_1016, float3(0.300000011920928955078125, 0.60000002384185791015625, 0.100000001490116119384765625));
    float _1222 = dot(_1218, float3(0.300000011920928955078125, 0.60000002384185791015625, 0.100000001490116119384765625));
    float _1233 = 1.0 - (abs(_1220 - _1222) / fast::max(fast::max(_1220, _1222), 0.20000000298023223876953125));
    float _1236 = _1233 * _1233;
    float3 _1244 = float3(mix(_mtl_u.u_params[1].x, _mtl_u.u_params[1].y, _1236));
    float3 _2113;
    if (_mtl_u.u_params[2].y > 0.0)
    {
        float _1775 = mix(1.5, 0.3333333432674407958984375, _1236);
        float _1781 = mix(-0.25, 0.3333333432674407958984375, _1236);
        float _1789 = abs(0.0);
        float _1792 = _1789 * _1789;
        float _1795 = _1792 * _1789;
        float _2101;
        if (_1789 < 1.0)
        {
            float _1803 = 6.0 * _1781;
            _2101 = ((((12.0 - (9.0 * _1775)) - _1803) * _1795) + ((((-18.0) + (12.0 * _1775)) + _1803) * _1792)) + (6.0 - (2.0 * _1775));
        }
        else
        {
            float _2102;
            if (_1789 < 2.0)
            {
                _2102 = (((((-_1775) - (6.0 * _1781)) * _1795) + (((6.0 * _1775) + (30.0 * _1781)) * _1792)) + ((((-12.0) * _1775) - (48.0 * _1781)) * _1789)) + ((8.0 * _1775) + (24.0 * _1781));
            }
            else
            {
                _2102 = 0.0;
            }
            _2101 = _2102;
        }
        float _1856 = _2101 * 0.16666667163372039794921875;
        float _1864 = abs(1.0);
        float _1867 = _1864 * _1864;
        float _1870 = _1867 * _1864;
        float _2103;
        if (_1864 < 1.0)
        {
            float _1878 = 6.0 * _1781;
            _2103 = ((((12.0 - (9.0 * _1775)) - _1878) * _1870) + ((((-18.0) + (12.0 * _1775)) + _1878) * _1867)) + (6.0 - (2.0 * _1775));
        }
        else
        {
            float _2104;
            if (_1864 < 2.0)
            {
                _2104 = (((((-_1775) - (6.0 * _1781)) * _1870) + (((6.0 * _1775) + (30.0 * _1781)) * _1867)) + ((((-12.0) * _1775) - (48.0 * _1781)) * _1864)) + ((8.0 * _1775) + (24.0 * _1781));
            }
            else
            {
                _2104 = 0.0;
            }
            _2103 = _2104;
        }
        float _1931 = _2103 * 0.16666667163372039794921875;
        float _1939 = abs(1.41421353816986083984375);
        float _1942 = _1939 * _1939;
        float _1945 = _1942 * _1939;
        float _2105;
        if (_1939 < 1.0)
        {
            float _1953 = 6.0 * _1781;
            _2105 = ((((12.0 - (9.0 * _1775)) - _1953) * _1945) + ((((-18.0) + (12.0 * _1775)) + _1953) * _1942)) + (6.0 - (2.0 * _1775));
        }
        else
        {
            float _2106;
            if (_1939 < 2.0)
            {
                _2106 = (((((-_1775) - (6.0 * _1781)) * _1945) + (((6.0 * _1775) + (30.0 * _1781)) * _1942)) + ((((-12.0) * _1775) - (48.0 * _1781)) * _1939)) + ((8.0 * _1775) + (24.0 * _1781));
            }
            else
            {
                _2106 = 0.0;
            }
            _2105 = _2106;
        }
        float _2006 = _2105 * 0.16666667163372039794921875;
        _2113 = mix((((((((((_1016 * _1856) + (_1071 * _1931)) + (_1065 * _1931)) + (_1051 * _1931)) + (_1085 * _1931)) + (_1045 * _2006)) + (_1059 * _2006)) + (_1079 * _2006)) + (_1093 * _2006)) * (1.0 / ((_1856 + (_2103 * 0.666666686534881591796875)) + (_2105 * 0.666666686534881591796875))), _1218, _1244);
    }
    else
    {
        _2113 = mix(_1016, _1218, _1244);
    }
    out.bgfx_FragData0 = float4(_2113, 1.0);
    return out;
}

