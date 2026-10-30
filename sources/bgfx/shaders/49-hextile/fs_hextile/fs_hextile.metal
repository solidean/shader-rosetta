#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params;
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
    float3 v_position [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_trx_d [[texture(0)]], sampler s_trx_dSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float2 _814 = float2((in.v_position * (0.0500000007450580596923828125 * _mtl_u.u_params.y)).xz);
    float4 _1566;
    if (_mtl_u.u_params.w > 0.0)
    {
        _1566 = s_trx_d.sample(s_trx_dSampler, _814);
    }
    else
    {
        float2 _944 = dfdx(_814);
        float2 _947 = dfdy(-_814);
        float2 _1098 = (_814 * 3.4641015529632568359375) * float2x2(float2(1.0, -0.57735025882720947265625), float2(0.0, 1.1547005176544189453125));
        float2 _1100 = floor(_1098);
        float2 _1102 = fract(_1098);
        float _1103 = _1102.x;
        float _1104 = _1102.y;
        float _1115 = -((1.0 - _1103) - _1104);
        float _1116 = step(0.0, _1115);
        float _1119 = (2.0 * _1116) - 1.0;
        float2 _1140 = _1100 + float2(_1116);
        float _1144 = 1.0 - _1116;
        float2 _1146 = _1100 + float2(_1116, _1144);
        float2 _1152 = _1100 + float2(_1144, _1116);
        float _1159 = _1140.x;
        float _1161 = _1140.y;
        float _1170 = abs(_1159 * _1161) + abs(_1159 + _1161);
        float _1171 = _1170 + 3.1415927410125732421875;
        float _1559;
        if (_1171 < 0.0)
        {
            _1559 = _1170 + 9.424777984619140625;
        }
        else
        {
            _1559 = _1171;
        }
        float _1560;
        if (_1559 > 3.1415927410125732421875)
        {
            _1560 = _1559 - 6.283185482025146484375;
        }
        else
        {
            _1560 = _1559;
        }
        float _1186 = _1560 * _mtl_u.u_params.z;
        float _1188 = cos(_1186);
        float _1190 = sin(_1186);
        float2x2 _1198 = float2x2(float2(_1188, -_1190), float2(_1190, _1188));
        float _1205 = _1146.x;
        float _1207 = _1146.y;
        float _1216 = abs(_1205 * _1207) + abs(_1205 + _1207);
        float _1217 = _1216 + 3.1415927410125732421875;
        float _1561;
        if (_1217 < 0.0)
        {
            _1561 = _1216 + 9.424777984619140625;
        }
        else
        {
            _1561 = _1217;
        }
        float _1562;
        if (_1561 > 3.1415927410125732421875)
        {
            _1562 = _1561 - 6.283185482025146484375;
        }
        else
        {
            _1562 = _1561;
        }
        float _1232 = _1562 * _mtl_u.u_params.z;
        float _1234 = cos(_1232);
        float _1236 = sin(_1232);
        float2x2 _1244 = float2x2(float2(_1234, -_1236), float2(_1236, _1234));
        float _1251 = _1152.x;
        float _1253 = _1152.y;
        float _1262 = abs(_1251 * _1253) + abs(_1251 + _1253);
        float _1263 = _1262 + 3.1415927410125732421875;
        float _1563;
        if (_1263 < 0.0)
        {
            _1563 = _1262 + 9.424777984619140625;
        }
        else
        {
            _1563 = _1263;
        }
        float _1564;
        if (_1563 > 3.1415927410125732421875)
        {
            _1564 = _1563 - 6.283185482025146484375;
        }
        else
        {
            _1564 = _1563;
        }
        float _1278 = _1564 * _mtl_u.u_params.z;
        float _1280 = cos(_1278);
        float _1282 = sin(_1278);
        float2x2 _1290 = float2x2(float2(_1280, -_1282), float2(_1282, _1280));
        float2 _1298 = (_1140 * float2x2(float2(1.0, 0.5), float2(0.0, 0.866025388240814208984375))) * float2(0.288675129413604736328125);
        float2 _1306 = (_1146 * float2x2(float2(1.0, 0.5), float2(0.0, 0.866025388240814208984375))) * float2(0.288675129413604736328125);
        float2 _1314 = (_1152 * float2x2(float2(1.0, 0.5), float2(0.0, 0.866025388240814208984375))) * float2(0.288675129413604736328125);
        float4 _1352 = s_trx_d.sample(s_trx_dSampler, (((_1198 * (_814 - _1298)) + _1298) + fract(sin(_1140 * float2x2(float2(127.09999847412109375, 311.70001220703125), float2(269.5, 183.3000030517578125))) * 43758.546875)), gradient2d(_1198 * _944, _1198 * _947));
        float4 _1363 = s_trx_d.sample(s_trx_dSampler, (((_1244 * (_814 - _1306)) + _1306) + fract(sin(_1146 * float2x2(float2(127.09999847412109375, 311.70001220703125), float2(269.5, 183.3000030517578125))) * 43758.546875)), gradient2d(_1244 * _944, _1244 * _947));
        float4 _1374 = s_trx_d.sample(s_trx_dSampler, (((_1290 * (_814 - _1314)) + _1314) + fract(sin(_1152 * float2x2(float2(127.09999847412109375, 311.70001220703125), float2(269.5, 183.3000030517578125))) * 43758.546875)), gradient2d(_1290 * _944, _1290 * _947));
        float3 _1051 = mix(float3(1.0), float3(dot(_1352.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)), dot(_1363.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)), dot(_1374.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))), float3(0.60000002384185791015625)) * powr(float3(_1115 * _1119, _1116 - (_1104 * _1119), _1116 - (_1103 * _1119)), float3(7.0));
        float3 _1062 = _1051 / float3((_1051.x + _1051.y) + _1051.z);
        float3 _1403 = step(float3(0.5), _1062) * 2.0;
        float3 _1407 = (float3(1.0) - _1403) * 2.0;
        float3 _1423 = (_1403 * 0.5) + ((_1407 * 0.25) * powr(fast::max(float3(0.0), _1403 + (_1062 * _1407)), float3(1.736965656280517578125)));
        float3 _1434 = _1423 / float3((_1423.x + _1423.y) + _1423.z);
        float _1071 = _1434.x;
        float _1075 = _1434.y;
        float _1080 = _1434.z;
        float _1457 = _1159 - _1161;
        float _1466 = _1457 - (3.0 * floor(_1457 * 0.3333333432674407958984375));
        float _1565;
        if (_1466 < 0.0)
        {
            _1565 = _1466 + 3.0;
        }
        else
        {
            _1565 = _1466;
        }
        float _1477 = (_1565 < 2.0) ? (_1565 + 1.0) : 0.0;
        float _1482 = (_1565 > 0.0) ? (_1565 - 1.0) : 2.0;
        bool _1487 = _1159 < _1251;
        float _1490 = _1487 ? _1482 : _1477;
        float _1498 = _1487 ? _1477 : _1482;
        float4 _1567;
        if (_mtl_u.u_params.x > 0.0)
        {
            _1567 = float4((_1498 == 0.0) ? _1080 : ((_1490 == 0.0) ? _1075 : _1071), (_1498 == 1.0) ? _1080 : ((_1490 == 1.0) ? _1075 : _1071), (_1498 == 2.0) ? _1080 : ((_1490 == 2.0) ? _1075 : _1071), 1.0);
        }
        else
        {
            _1567 = float4((((_1352 * _1071) + (_1363 * _1075)) + (_1374 * _1080)).xyz, 1.0);
        }
        _1566 = _1567;
    }
    out.bgfx_FragData0 = _1566;
    return out;
}

