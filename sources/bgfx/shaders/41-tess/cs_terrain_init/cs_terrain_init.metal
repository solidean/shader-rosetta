#pragma clang diagnostic ignored "-Wunused-variable"

#include <metal_stdlib>
#include <simd/simd.h>
#include <metal_atomic>

using namespace metal;

struct _Global
{
    float4 bgfx_indirectArgBase;
    float4 u_params[2];
};

struct indirectBuffer
{
    uint4 _data[1];
};

struct u_SubdBufferOut
{
    uint _data[1];
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], device u_SubdBufferOut& u_SubdBufferOut_1 [[buffer(2)]], device u_SubdBufferOut& u_CulledSubdBuffer [[buffer(3)]], device indirectBuffer& indirectBuffer_1 [[buffer(4)]], device u_SubdBufferOut& atomicCounterBuffer [[buffer(5)]], device u_SubdBufferOut& u_SubdBufferIn [[buffer(9)]])
{
    int _126 = (2 * int(_mtl_u.u_params[1].x)) - 1;
    indirectBuffer_1._data[0] = uint4((_126 <= 0) ? 3u : uint(6 << _126), 0u, as_type<uint>(_mtl_u.bgfx_indirectArgBase.x), 0u);
    indirectBuffer_1._data[1] = uint4(0u);
    indirectBuffer_1._data[2] = uint4(1u, 1u, 1u, 0u);
    u_SubdBufferOut_1._data[0] = 0u;
    u_SubdBufferOut_1._data[1] = 1u;
    u_SubdBufferOut_1._data[2] = 1u;
    u_SubdBufferOut_1._data[3] = 1u;
    u_CulledSubdBuffer._data[0] = 0u;
    u_CulledSubdBuffer._data[1] = 1u;
    u_CulledSubdBuffer._data[2] = 1u;
    u_CulledSubdBuffer._data[3] = 1u;
    u_SubdBufferIn._data[0] = 0u;
    u_SubdBufferIn._data[1] = 1u;
    u_SubdBufferIn._data[2] = 1u;
    u_SubdBufferIn._data[3] = 1u;
    uint _159 = atomic_exchange_explicit((device atomic_uint*)&atomicCounterBuffer._data[0], 0u, memory_order_relaxed);
    uint _161 = atomic_exchange_explicit((device atomic_uint*)&atomicCounterBuffer._data[1], 0u, memory_order_relaxed);
    uint _163 = atomic_exchange_explicit((device atomic_uint*)&atomicCounterBuffer._data[2], 2u, memory_order_relaxed);
}

