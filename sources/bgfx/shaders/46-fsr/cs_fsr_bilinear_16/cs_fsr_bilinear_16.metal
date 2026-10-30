#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[3];
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float> InputTexture [[texture(0)]], texture2d<float, access::write> OutputTexture [[texture(1)]], sampler InputTextureSampler [[sampler(0)]], uint3 gl_LocalInvocationID [[thread_position_in_threadgroup]], uint3 gl_WorkGroupID [[threadgroup_position_in_grid]])
{
    uint4 _1112 = uint4(as_type<uint>(_mtl_u.u_params[0].x * (1.0 / _mtl_u.u_params[2].x)), as_type<uint>(_mtl_u.u_params[0].y * (1.0 / _mtl_u.u_params[2].y)), as_type<uint>((0.5 * (_mtl_u.u_params[0].x / _mtl_u.u_params[2].x)) - 0.5), as_type<uint>((0.5 * (_mtl_u.u_params[0].y / _mtl_u.u_params[2].y)) - 0.5));
    uint _662 = as_type<uint>(1.0 / _mtl_u.u_params[1].x);
    uint4 _1113 = uint4(_662, as_type<uint>(1.0 / _mtl_u.u_params[1].y), _662, as_type<uint>((-1.0) / _mtl_u.u_params[1].y));
    uint _549 = uint(int(gl_LocalInvocationID.x));
    uint2 _560 = uint2((_549 >> 1u) & 7u, (_549 & 1u) | ((_549 >> 3u) & 6u)) + uint2(uint(int(gl_WorkGroupID.x) << int(4u)), uint(int(gl_WorkGroupID.y) << int(4u)));
    float2 _876 = as_type<float2>(_1112.xy);
    float2 _880 = as_type<float2>(_1112.zw);
    float2 _884 = as_type<float2>(_1113.xy);
    float2 _889 = float2(0.5, -0.5) * as_type<float2>(_1113.zw);
    OutputTexture.write(InputTexture.sample(InputTextureSampler, ((((float2(_560) * _876) + _880) * _884) + _889), level(0.0)), uint2(int2(_560)));
    uint _569 = _560.x;
    uint _570 = _569 + 8u;
    uint2 _1104 = _560;
    _1104.x = _570;
    OutputTexture.write(InputTexture.sample(InputTextureSampler, ((((float2(_1104) * _876) + _880) * _884) + _889), level(0.0)), uint2(int2(_1104)));
    uint2 _1114 = uint2(_570, _560.y + 8u);
    OutputTexture.write(InputTexture.sample(InputTextureSampler, ((((float2(_1114) * _876) + _880) * _884) + _889), level(0.0)), uint2(int2(_1114)));
    _1114.x = _569;
    OutputTexture.write(InputTexture.sample(InputTextureSampler, ((((float2(_1114) * _876) + _880) * _884) + _889), level(0.0)), uint2(int2(_1114)));
}

