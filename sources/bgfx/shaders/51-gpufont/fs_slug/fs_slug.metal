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
    float4 v_banding [[user(locn0), flat]];
    float4 v_glyph [[user(locn1), flat]];
    float2 v_texcoord0 [[user(locn2)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_curveData [[texture(0)]], texture2d<float> s_bandData [[texture(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    int2 _923 = int2(in.v_glyph.xy);
    int2 _926 = int2(in.v_glyph.zw);
    int _929 = _926.y & 255;
    int2 _1889 = _926;
    _1889.y = _929;
    float2 _1024 = fwidth(in.v_texcoord0);
    float2 _1027 = float2(1.0) / _1024;
    int2 _1037 = clamp(int2((in.v_texcoord0 * in.v_banding.xy) + in.v_banding.zw), int2(0), _1889);
    int _1039 = _923.x;
    int _1044 = _923.y;
    float4 _1339 = s_bandData.read(uint2(int3(_1039 + _1037.y, _1044, 0).xy), 0);
    int _1051 = int(_1339.x + 0.5);
    int _1346 = _1039 + int(_1339.y + 0.5);
    int _1355 = _1044 + (_1346 >> 12);
    int _1359 = _1346 & 4095;
    float _1837;
    float _1839;
    _1839 = 0.0;
    _1837 = 0.0;
    float _1875;
    float _1877;
    for (int _1833 = 0; _1833 < _1051; _1839 = _1877, _1837 = _1875, _1833++)
    {
        float4 _1378 = s_bandData.read(uint2(int3(_1359 + _1833, _1355, 0).xy), 0);
        int _1077 = int(_1378.x + 0.5);
        int _1081 = int(_1378.y + 0.5);
        float4 _1092 = s_curveData.read(uint2(int3(_1077, _1081, 0).xy), 0) - float4(in.v_texcoord0.xyxy);
        float2 _1103 = s_curveData.read(uint2(int3(_1077 + 1, _1081, 0).xy), 0).xy - in.v_texcoord0;
        float _1105 = _1092.x;
        float _1113 = _1027.x;
        if ((fast::max(fast::max(_1105, _1092.z), _1103.x) * _1113) < (-0.5))
        {
            break;
        }
        float _1119 = _1092.y;
        int _1434 = 11892 >> ((int(_1119 < 0.0) + ((_1092.w < 0.0) ? 2 : 0)) + ((_1103.y < 0.0) ? 4 : 0));
        int _1435 = _1434 & 257;
        if (_1435 != 0)
        {
            float2 _1446 = _1092.xy;
            float2 _1448 = _1092.zw;
            float2 _1452 = (_1446 - (_1448 * 2.0)) + _1103;
            float2 _1457 = _1446 - _1448;
            float _1459 = _1452.y;
            float _1460 = 1.0 / _1459;
            float _1462 = _1457.y;
            float _1476 = sqrt(fast::max((_1462 * _1462) - (_1459 * _1119), 0.0));
            float _1834;
            float _1835;
            if (abs(_1459) < 1.52587890625e-05)
            {
                float _1497 = _1119 * (0.5 / _1462);
                _1835 = _1497;
                _1834 = _1497;
            }
            else
            {
                _1835 = (_1462 + _1476) * _1460;
                _1834 = (_1462 - _1476) * _1460;
            }
            float _1500 = _1452.x;
            float _1505 = _1457.x * 2.0;
            float2 _1133 = float2((((_1500 * _1834) - _1505) * _1834) + _1105, (((_1500 * _1835) - _1505) * _1835) + _1105) * _1113;
            float _1840;
            float _1841;
            if ((_1434 & 1) != 0)
            {
                float _1139 = _1133.x;
                _1841 = fast::max(_1839, fast::clamp(1.0 - (abs(_1139) * 2.0), 0.0, 1.0));
                _1840 = _1837 + fast::clamp(_1139 + 0.5, 0.0, 1.0);
            }
            else
            {
                _1841 = _1839;
                _1840 = _1837;
            }
            float _1876;
            float _1878;
            if (_1435 > 1)
            {
                float _1157 = _1133.y;
                _1878 = fast::max(_1841, fast::clamp(1.0 - (abs(_1157) * 2.0), 0.0, 1.0));
                _1876 = _1840 - fast::clamp(_1157 + 0.5, 0.0, 1.0);
            }
            else
            {
                _1878 = _1841;
                _1876 = _1840;
            }
            _1877 = _1878;
            _1875 = _1876;
        }
        else
        {
            _1877 = _1839;
            _1875 = _1837;
        }
    }
    float4 _1542 = s_bandData.read(uint2(int3(((_1039 + _929) + 1) + _1037.x, _1044, 0).xy), 0);
    int _1193 = int(_1542.x + 0.5);
    int _1549 = _1039 + int(_1542.y + 0.5);
    int _1558 = _1044 + (_1549 >> 12);
    int _1562 = _1549 & 4095;
    float _1850;
    float _1852;
    _1852 = 0.0;
    _1850 = 0.0;
    float _1879;
    float _1881;
    for (int _1846 = 0; _1846 < _1193; _1852 = _1881, _1850 = _1879, _1846++)
    {
        float4 _1581 = s_bandData.read(uint2(int3(_1562 + _1846, _1558, 0).xy), 0);
        int _1219 = int(_1581.x + 0.5);
        int _1223 = int(_1581.y + 0.5);
        float4 _1234 = s_curveData.read(uint2(int3(_1219, _1223, 0).xy), 0) - float4(in.v_texcoord0.xyxy);
        float2 _1245 = s_curveData.read(uint2(int3(_1219 + 1, _1223, 0).xy), 0).xy - in.v_texcoord0;
        float _1247 = _1234.y;
        float _1255 = _1027.y;
        if ((fast::max(fast::max(_1247, _1234.w), _1245.y) * _1255) < (-0.5))
        {
            break;
        }
        float _1261 = _1234.x;
        int _1637 = 11892 >> ((int(_1261 < 0.0) + ((_1234.z < 0.0) ? 2 : 0)) + ((_1245.x < 0.0) ? 4 : 0));
        int _1638 = _1637 & 257;
        if (_1638 != 0)
        {
            float2 _1649 = _1234.xy;
            float2 _1651 = _1234.zw;
            float2 _1655 = (_1649 - (_1651 * 2.0)) + _1245;
            float2 _1660 = _1649 - _1651;
            float _1662 = _1655.x;
            float _1663 = 1.0 / _1662;
            float _1665 = _1660.x;
            float _1679 = sqrt(fast::max((_1665 * _1665) - (_1662 * _1261), 0.0));
            float _1847;
            float _1848;
            if (abs(_1662) < 1.52587890625e-05)
            {
                float _1700 = _1261 * (0.5 / _1665);
                _1848 = _1700;
                _1847 = _1700;
            }
            else
            {
                _1848 = (_1665 + _1679) * _1663;
                _1847 = (_1665 - _1679) * _1663;
            }
            float _1703 = _1655.y;
            float _1708 = _1660.y * 2.0;
            float2 _1275 = float2((((_1703 * _1847) - _1708) * _1847) + _1247, (((_1703 * _1848) - _1708) * _1848) + _1247) * _1255;
            float _1853;
            float _1854;
            if ((_1637 & 1) != 0)
            {
                float _1281 = _1275.x;
                _1854 = fast::max(_1852, fast::clamp(1.0 - (abs(_1281) * 2.0), 0.0, 1.0));
                _1853 = _1850 - fast::clamp(_1281 + 0.5, 0.0, 1.0);
            }
            else
            {
                _1854 = _1852;
                _1853 = _1850;
            }
            float _1880;
            float _1882;
            if (_1638 > 1)
            {
                float _1299 = _1275.y;
                _1882 = fast::max(_1854, fast::clamp(1.0 - (abs(_1299) * 2.0), 0.0, 1.0));
                _1880 = _1853 + fast::clamp(_1299 + 0.5, 0.0, 1.0);
            }
            else
            {
                _1882 = _1854;
                _1880 = _1853;
            }
            _1881 = _1882;
            _1879 = _1880;
        }
        else
        {
            _1881 = _1852;
            _1879 = _1850;
        }
    }
    uint _1781 = as_type<uint>(_mtl_u.u_params.x);
    uint _1809 = as_type<uint>(_mtl_u.u_params.y);
    out.bgfx_FragData0 = mix(float4(float((_1809 >> uint(24)) & 255u), float((_1809 >> uint(16)) & 255u), float((_1809 >> uint(8)) & 255u), float(_1809 & 255u)) * float4(0.0039215688593685626983642578125), float4(float((_1781 >> uint(24)) & 255u), float((_1781 >> uint(16)) & 255u), float((_1781 >> uint(8)) & 255u), float(_1781 & 255u)) * float4(0.0039215688593685626983642578125), float4(fast::clamp(fast::max(abs((_1837 * _1839) + (_1850 * _1852)) / fast::max(_1839 + _1852, 1.52587890625e-05), fast::min(abs(_1837), abs(_1850))), 0.0, 1.0)));
    return out;
}

