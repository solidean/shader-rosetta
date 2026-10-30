#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct atomicCounterBuffer
{
    uint _data[1];
};

struct _Global
{
    float4 bgfx_indirectArgBase;
    float4 u_params[2];
};

struct indirectBuffer
{
    uint4 _data[1];
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], device indirectBuffer& indirectBuffer_1 [[buffer(4)]], device atomicCounterBuffer& atomicCounterBuffer_1 [[buffer(5)]])
{
    int _108 = (2 * int(_mtl_u.u_params[1].x)) - 1;
    indirectBuffer_1._data[0] = uint4((_108 <= 0) ? 3u : uint(6 << _108), atomicCounterBuffer_1._data[1] / 2u, as_type<uint>(_mtl_u.bgfx_indirectArgBase.x), 0u);
    indirectBuffer_1._data[1] = uint4(0u);
}

