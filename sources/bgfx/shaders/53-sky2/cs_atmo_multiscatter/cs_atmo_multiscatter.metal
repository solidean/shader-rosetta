#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_atmoRayleigh;
    float4 u_atmoMie;
    float4 u_atmoOzone;
    float4 u_atmoPlanet;
    float4 u_atmoGround;
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_atmo_transmittance [[texture(0)]], texture2d<float, access::write> s_multiscatter_out [[texture(1)]], sampler s_atmo_transmittanceSampler [[sampler(0)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    do
    {
        if ((int3(gl_GlobalInvocationID).x >= 32) || (int3(gl_GlobalInvocationID).y >= 32))
        {
            break;
        }
        float2 _832 = (float2(int3(gl_GlobalInvocationID).xy) + float2(0.5)) * float2(0.03125);
        float _836 = (_832.x * 2.0) - 1.0;
        float _845 = _mtl_u.u_atmoPlanet.y - _mtl_u.u_atmoPlanet.x;
        float _847 = _mtl_u.u_atmoPlanet.x + (_832.y * _845);
        float _848 = _847 + 0.00999999977648258209228515625;
        float3 _856 = float3(sqrt(fast::max(1.0 - (_836 * _836), 0.0)), 0.0, _836);
        float3 _1508;
        float3 _1509;
        _1509 = float3(0.0);
        _1508 = float3(0.0);
        float3 _1521;
        float3 _1527;
        for (int _1507 = 0; _1507 < 8; _1509 = _1527, _1508 = _1521, _1507++)
        {
            _1527 = _1509;
            _1521 = _1508;
            float3 _1074;
            float3 _1080;
            for (int _1510 = 0; _1510 < 8; _1527 = _1080, _1521 = _1074, _1510++)
            {
                float _872 = 1.0 - ((float(_1507) + 0.5) * 0.25);
                float _875 = _872 * _872;
                float _878 = sqrt(fast::max(1.0 - _875, 0.0));
                float _883 = (float(_1510) + 0.5) * 0.785398185253143310546875;
                float3 _893 = float3(_878 * cos(_883), _878 * sin(_883), _872);
                float _1116 = (_848 * _848) * (_875 - 1.0);
                float _1121 = _mtl_u.u_atmoPlanet.x * _mtl_u.u_atmoPlanet.x;
                float _1122 = _1116 + _1121;
                bool _1124 = (_872 < 0.0) && (_1122 >= 0.0);
                float _1512;
                if (_1124)
                {
                    _1512 = fast::max(0.0, (((-0.00999999977648258209228515625) - _847) * _872) - sqrt(fast::max(_1122, 0.0)));
                }
                else
                {
                    _1512 = fast::max(0.0, (((-0.00999999977648258209228515625) - _847) * _872) + sqrt(fast::max(_1116 + (_mtl_u.u_atmoPlanet.y * _mtl_u.u_atmoPlanet.y), 0.0)));
                }
                float _934 = _1512 * 0.0500000007450580596923828125;
                float _937 = dot(_893, _856);
                float _1154 = 1.0 + (_937 * _937);
                float _1155 = 0.0596831031143665313720703125 * _1154;
                float _1165 = _mtl_u.u_atmoMie.w * _mtl_u.u_atmoMie.w;
                float _1172 = (1.0 + _1165) - ((2.0 * _mtl_u.u_atmoMie.w) * _937);
                float _1189 = (0.119366206228733062744140625 * ((1.0 - _1165) * _1154)) / (((2.0 + _1165) * _1172) * sqrt(fast::max(_1172, 9.9999999747524270787835121154785e-07)));
                float3 _1515;
                float3 _1516;
                float3 _1523;
                _1523 = float3(0.0);
                _1516 = float3(0.0);
                _1515 = float3(1.0);
                for (int _1513 = 0; _1513 < 20; )
                {
                    float3 _957 = float3(0.0, 0.0, _848) + (_893 * ((float(_1513) + 0.5) * _934));
                    float _959 = length(_957);
                    float _968 = dot(_957, _856) / _959;
                    float _970 = fast::max(_959 - _mtl_u.u_atmoPlanet.x, 0.0);
                    float _1196 = -_970;
                    float _1206 = exp(_1196 / _mtl_u.u_atmoMie.z);
                    float3 _1221 = _mtl_u.u_atmoRayleigh.xyz * exp(_1196 / _mtl_u.u_atmoRayleigh.w);
                    float _1225 = _mtl_u.u_atmoMie.x * _1206;
                    float3 _1242 = (_1221 + float3(_mtl_u.u_atmoMie.y * _1206)) + (_mtl_u.u_atmoOzone.xyz * fast::max(0.0, 1.0 - (abs(_970 - _mtl_u.u_atmoPlanet.z) / _mtl_u.u_atmoPlanet.w)));
                    float3 _978 = _1221 + float3(_1225);
                    float _1278 = _mtl_u.u_atmoPlanet.y * _mtl_u.u_atmoPlanet.y;
                    float _1285 = sqrt(_1278 - _1121);
                    float _1288 = _959 * _959;
                    float _1296 = sqrt(fast::max(_1288 - _1121, 0.0));
                    float _1330 = _1288 * ((_968 * _968) - 1.0);
                    float _1305 = _mtl_u.u_atmoPlanet.y - _959;
                    float3 _997 = (((_1221 * _1155) + float3(_1225 * _1189)) * s_atmo_transmittance.sample(s_atmo_transmittanceSampler, float2((fast::max(0.0, ((-_959) * _968) + sqrt(fast::max(_1330 + _1278, 0.0))) - _1305) / ((_1296 + _1285) - _1305), _1296 / _1285), level(0.0)).xyz) * (((_968 < 0.0) && ((_1330 + _1121) >= 0.0)) ? 0.0 : 1.0);
                    float3 _1002 = exp((-_1242) * _934);
                    float3 _1005 = fast::max(_1242, float3(1.0000000116860974230803549289703e-07));
                    _1523 += ((_1515 * (_978 - (_978 * _1002))) / _1005);
                    _1516 += ((_1515 * (_997 - (_997 * _1002))) / _1005);
                    _1515 *= _1002;
                    _1513++;
                    continue;
                }
                float3 _1517;
                if (_1124)
                {
                    float _1049 = fast::clamp(dot(float3(0.0, 0.0, _848) + (_893 * _1512), _856) / _mtl_u.u_atmoPlanet.x, -1.0, 1.0);
                    float _1409 = _mtl_u.u_atmoPlanet.y * _mtl_u.u_atmoPlanet.y;
                    _1517 = _1516 + ((((_1515 * s_atmo_transmittance.sample(s_atmo_transmittanceSampler, float2((fast::max(0.0, ((-_mtl_u.u_atmoPlanet.x) * _1049) + sqrt(fast::max((_1121 * ((_1049 * _1049) - 1.0)) + _1409, 0.0))) - _845) / (sqrt(_1409 - _1121) - _845), 0.0), level(0.0)).xyz) * fast::max(_1049, 0.0)) * _mtl_u.u_atmoGround.xyz) * float3(0.3183098733425140380859375));
                }
                else
                {
                    _1517 = _1516;
                }
                _1074 = _1521 + (((_1517 * 0.079577468335628509521484375) * 12.56637096405029296875) * 0.015625);
                _1080 = _1527 + (((_1523 * 0.079577468335628509521484375) * 12.56637096405029296875) * 0.015625);
            }
        }
        s_multiscatter_out.write(float4(_1508 / fast::max(float3(1.0) - _1509, float3(9.9999997473787516355514526367188e-05)), 1.0), uint2(int3(gl_GlobalInvocationID).xy));
        break;
    } while(false);
}

