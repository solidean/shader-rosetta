#pragma clang diagnostic ignored "-Wunused-variable"

#include <metal_stdlib>
#include <simd/simd.h>
#include <metal_atomic>

using namespace metal;

struct atomicCounterBuffer
{
    uint _data[1];
};

struct indirectBuffer
{
    uint4 _data[1];
};

kernel void xlatMtlMain(device indirectBuffer& indirectBuffer_1 [[buffer(4)]], device atomicCounterBuffer& atomicCounterBuffer_1 [[buffer(5)]])
{
    uint _80 = atomic_exchange_explicit((device atomic_uint*)&atomicCounterBuffer_1._data[0], 0u, memory_order_relaxed);
    uint _82 = atomic_exchange_explicit((device atomic_uint*)&atomicCounterBuffer_1._data[1], 0u, memory_order_relaxed);
    uint _84 = _80 / 2u;
    uint _90 = atomic_exchange_explicit((device atomic_uint*)&atomicCounterBuffer_1._data[2], _84, memory_order_relaxed);
    indirectBuffer_1._data[2] = uint4((_84 / 32u) + 1u, 1u, 1u, 0u);
}

