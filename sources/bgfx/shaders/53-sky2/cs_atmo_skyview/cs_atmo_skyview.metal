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
    float4 u_atmo_params;
    float4 u_atmo_params2;
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_atmo_transmittance [[texture(0)]], texture2d<float, access::write> s_skyview_out [[texture(1)]], texture2d<float> s_atmo_multiscatter [[texture(2)]], sampler s_atmo_transmittanceSampler [[sampler(0)]], sampler s_atmo_multiscatterSampler [[sampler(2)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    do
    {
        int2 _871 = int2(_mtl_u.u_atmo_params2.zw);
        if ((int3(gl_GlobalInvocationID).x >= _871.x) || (int3(gl_GlobalInvocationID).y >= _871.y))
        {
            break;
        }
        float2 _890 = (float2(int3(gl_GlobalInvocationID).xy) + float2(0.5)) / float2(_871);
        float _1120 = _mtl_u.u_atmo_params2.y * _mtl_u.u_atmo_params2.y;
        float _1125 = _mtl_u.u_atmoPlanet.x * _mtl_u.u_atmoPlanet.x;
        float _1133 = acos(fast::clamp(sqrt(fast::max(_1120 - _1125, 0.0)) / _mtl_u.u_atmo_params2.y, -1.0, 1.0));
        float _1135 = 3.1415927410125732421875 - _1133;
        float _1137 = _890.y;
        float _1602;
        if (_1137 < 0.5)
        {
            float _1143 = 1.0 - (_1137 * 2.0);
            _1602 = _1135 * (1.0 - (_1143 * _1143));
        }
        else
        {
            float _1154 = (_1137 * 2.0) - 1.0;
            _1602 = _1135 + ((_1133 * _1154) * _1154);
        }
        float _1164 = cos(_1602);
        float _1169 = (_890.x - 0.5) * 6.283185482025146484375;
        float3 _908 = float3(sqrt(fast::max(1.0 - (_mtl_u.u_atmo_params2.x * _mtl_u.u_atmo_params2.x), 0.0)), 0.0, _mtl_u.u_atmo_params2.x);
        float _911 = _1164 * _1164;
        float _914 = sqrt(fast::max(1.0 - _911, 0.0));
        float3 _924 = float3(_914 * cos(_1169), _914 * sin(_1169), _1164);
        float _1181 = _1120 * (_911 - 1.0);
        float _1187 = _1181 + _1125;
        bool _1189 = (_1164 < 0.0) && (_1187 >= 0.0);
        float _1603;
        if (_1189)
        {
            _1603 = fast::max(0.0, ((-_mtl_u.u_atmo_params2.y) * _1164) - sqrt(fast::max(_1187, 0.0)));
        }
        else
        {
            _1603 = fast::max(0.0, ((-_mtl_u.u_atmo_params2.y) * _1164) + sqrt(fast::max(_1181 + (_mtl_u.u_atmoPlanet.y * _mtl_u.u_atmoPlanet.y), 0.0)));
        }
        float _965 = _1603 * 0.0625;
        float _968 = dot(_924, _908);
        float _1219 = 1.0 + (_968 * _968);
        float _1220 = 0.0596831031143665313720703125 * _1219;
        float _1230 = _mtl_u.u_atmoMie.w * _mtl_u.u_atmoMie.w;
        float _1237 = (1.0 + _1230) - ((2.0 * _mtl_u.u_atmoMie.w) * _968);
        float _1254 = (0.119366206228733062744140625 * ((1.0 - _1230) * _1219)) / (((2.0 + _1230) * _1237) * sqrt(fast::max(_1237, 9.9999999747524270787835121154785e-07)));
        float3 _1606;
        float3 _1607;
        _1607 = float3(0.0);
        _1606 = float3(1.0);
        for (int _1604 = 0; _1604 < 16; )
        {
            float3 _988 = float3(0.0, 0.0, _mtl_u.u_atmo_params2.y) + (_924 * ((float(_1604) + 0.5) * _965));
            float _990 = length(_988);
            float _994 = _990 - _mtl_u.u_atmoPlanet.x;
            float _999 = dot(_988, _908) / _990;
            float _1001 = fast::max(_994, 0.0);
            float _1261 = -_1001;
            float _1271 = exp(_1261 / _mtl_u.u_atmoMie.z);
            float3 _1286 = _mtl_u.u_atmoRayleigh.xyz * exp(_1261 / _mtl_u.u_atmoRayleigh.w);
            float _1290 = _mtl_u.u_atmoMie.x * _1271;
            float3 _1307 = (_1286 + float3(_mtl_u.u_atmoMie.y * _1271)) + (_mtl_u.u_atmoOzone.xyz * fast::max(0.0, 1.0 - (abs(_1001 - _mtl_u.u_atmoPlanet.z) / _mtl_u.u_atmoPlanet.w)));
            float _1339 = _mtl_u.u_atmoPlanet.y * _mtl_u.u_atmoPlanet.y;
            float _1346 = sqrt(_1339 - _1125);
            float _1349 = _990 * _990;
            float _1357 = sqrt(fast::max(_1349 - _1125, 0.0));
            float _1391 = _1349 * ((_999 * _999) - 1.0);
            float _1366 = _mtl_u.u_atmoPlanet.y - _990;
            float3 _1037 = ((((_1286 * _1220) + float3(_1290 * _1254)) * s_atmo_transmittance.sample(s_atmo_transmittanceSampler, float2((fast::max(0.0, ((-_990) * _999) + sqrt(fast::max(_1391 + _1339, 0.0))) - _1366) / ((_1357 + _1346) - _1366), _1357 / _1346), level(0.0)).xyz) * (((_999 < 0.0) && ((_1391 + _1125) >= 0.0)) ? 0.0 : 1.0)) + (((_1286 + float3(_1290)) * s_atmo_multiscatter.sample(s_atmo_multiscatterSampler, float2((_999 * 0.5) + 0.5, _994 / (_mtl_u.u_atmoPlanet.y - _mtl_u.u_atmoPlanet.x)), level(0.0)).xyz) * _mtl_u.u_atmoOzone.w);
            float3 _1042 = exp((-_1307) * _965);
            _1607 += ((_1606 * (_1037 - (_1037 * _1042))) / fast::max(_1307, float3(1.0000000116860974230803549289703e-07)));
            _1606 *= _1042;
            _1604++;
            continue;
        }
        float3 _1608;
        if (_1189)
        {
            float _1078 = fast::clamp(dot(float3(0.0, 0.0, _mtl_u.u_atmo_params2.y) + (_924 * _1603), _908) / _mtl_u.u_atmoPlanet.x, -1.0, 1.0);
            float _1508 = _mtl_u.u_atmoPlanet.y * _mtl_u.u_atmoPlanet.y;
            float _1535 = _mtl_u.u_atmoPlanet.y - _mtl_u.u_atmoPlanet.x;
            _1608 = _1607 + ((((_1606 * s_atmo_transmittance.sample(s_atmo_transmittanceSampler, float2((fast::max(0.0, ((-_mtl_u.u_atmoPlanet.x) * _1078) + sqrt(fast::max((_1125 * ((_1078 * _1078) - 1.0)) + _1508, 0.0))) - _1535) / (sqrt(_1508 - _1125) - _1535), 0.0), level(0.0)).xyz) * fast::max(_1078, 0.0)) * _mtl_u.u_atmoGround.xyz) * float3(0.3183098733425140380859375));
        }
        else
        {
            _1608 = _1607;
        }
        s_skyview_out.write(float4(_1608 * _mtl_u.u_atmo_params.xyz, 1.0), uint2(int3(gl_GlobalInvocationID).xy));
        break;
    } while(false);
}

