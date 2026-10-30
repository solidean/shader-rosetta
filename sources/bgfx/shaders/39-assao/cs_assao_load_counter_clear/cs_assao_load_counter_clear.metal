#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct s_loadCounter
{
    uint _data[1];
};

kernel void xlatMtlMain(device s_loadCounter& s_loadCounter_1 [[buffer(1)]])
{
    s_loadCounter_1._data[0] = 0u;
}

