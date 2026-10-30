#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_atmoRayleigh;
    float4 u_atmoMie;
    float4 u_atmoOzone;
    float4 u_atmoPlanet;
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float, access::write> s_transmittance_out [[texture(0)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    do
    {
        if ((int3(gl_GlobalInvocationID).x >= 256) || (int3(gl_GlobalInvocationID).y >= 64))
        {
            break;
        }
        float2 _421 = (float2(int3(gl_GlobalInvocationID).xy) + float2(0.5)) * float2(0.00390625, 0.015625);
        float _497 = _mtl_u.u_atmoPlanet.y * _mtl_u.u_atmoPlanet.y;
        float _502 = _mtl_u.u_atmoPlanet.x * _mtl_u.u_atmoPlanet.x;
        float _504 = sqrt(_497 - _502);
        float _508 = _421.y * _504;
        float _511 = _508 * _508;
        float _518 = sqrt(_511 + _502);
        float _522 = _mtl_u.u_atmoPlanet.y - _518;
        float _533 = _522 + (_421.x * ((_508 + _504) - _522));
        float _548 = 2.0 * _518;
        float _553 = (_533 <= 0.0) ? 1.0 : fast::clamp((((_504 * _504) - _511) - (_533 * _533)) / (_548 * _533), -1.0, 1.0);
        float _559 = _518 * _518;
        float _432 = fast::max(0.0, ((-_518) * _553) + sqrt(fast::max((_559 * ((_553 * _553) - 1.0)) + _497, 0.0))) * 0.02500000037252902984619140625;
        float3 _642;
        _642 = float3(0.0);
        for (int _641 = 0; _641 < 40; )
        {
            float _442 = (float(_641) + 0.5) * _432;
            float _462 = fast::max(sqrt((_559 + (_442 * _442)) + ((_548 * _553) * _442)) - _mtl_u.u_atmoPlanet.x, 0.0);
            float _584 = -_462;
            _642 += ((((_mtl_u.u_atmoRayleigh.xyz * exp(_584 / _mtl_u.u_atmoRayleigh.w)) + float3(_mtl_u.u_atmoMie.y * exp(_584 / _mtl_u.u_atmoMie.z))) + (_mtl_u.u_atmoOzone.xyz * fast::max(0.0, 1.0 - (abs(_462 - _mtl_u.u_atmoPlanet.z) / _mtl_u.u_atmoPlanet.w)))) * _432);
            _641++;
            continue;
        }
        s_transmittance_out.write(float4(exp(-_642), 1.0), uint2(int3(gl_GlobalInvocationID).xy));
        break;
    } while(false);
}

