#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[3];
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float> InputTexture [[texture(0)]], texture2d<float, access::write> OutputTexture [[texture(1)]], sampler InputTextureSampler [[sampler(0)]], uint3 gl_LocalInvocationID [[thread_position_in_threadgroup]], uint3 gl_WorkGroupID [[threadgroup_position_in_grid]])
{
    uint4 _1111 = uint4(as_type<uint>(_mtl_u.u_params[0].x * (1.0 / _mtl_u.u_params[2].x)), as_type<uint>(_mtl_u.u_params[0].y * (1.0 / _mtl_u.u_params[2].y)), as_type<uint>((0.5 * (_mtl_u.u_params[0].x / _mtl_u.u_params[2].x)) - 0.5), as_type<uint>((0.5 * (_mtl_u.u_params[0].y / _mtl_u.u_params[2].y)) - 0.5));
    uint _661 = as_type<uint>(1.0 / _mtl_u.u_params[1].x);
    uint4 _1112 = uint4(_661, as_type<uint>(1.0 / _mtl_u.u_params[1].y), _661, as_type<uint>((-1.0) / _mtl_u.u_params[1].y));
    uint _548 = uint(int(gl_LocalInvocationID.x));
    uint2 _559 = uint2((_548 >> 1u) & 7u, (_548 & 1u) | ((_548 >> 3u) & 6u)) + uint2(uint(int(gl_WorkGroupID.x) << int(4u)), uint(int(gl_WorkGroupID.y) << int(4u)));
    float2 _875 = as_type<float2>(_1111.xy);
    float2 _879 = as_type<float2>(_1111.zw);
    float2 _883 = as_type<float2>(_1112.xy);
    float2 _888 = float2(0.5, -0.5) * as_type<float2>(_1112.zw);
    OutputTexture.write(InputTexture.sample(InputTextureSampler, ((((float2(_559) * _875) + _879) * _883) + _888), level(0.0)), uint2(int2(_559)));
    uint _568 = _559.x;
    uint _569 = _568 + 8u;
    uint2 _1103 = _559;
    _1103.x = _569;
    OutputTexture.write(InputTexture.sample(InputTextureSampler, ((((float2(_1103) * _875) + _879) * _883) + _888), level(0.0)), uint2(int2(_1103)));
    uint2 _1113 = uint2(_569, _559.y + 8u);
    OutputTexture.write(InputTexture.sample(InputTextureSampler, ((((float2(_1113) * _875) + _879) * _883) + _888), level(0.0)), uint2(int2(_1113)));
    _1113.x = _568;
    OutputTexture.write(InputTexture.sample(InputTextureSampler, ((((float2(_1113) * _875) + _879) * _883) + _888), level(0.0)), uint2(int2(_1113)));
}

