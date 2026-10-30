#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct indirectBuffer
{
    uint4 _data[1];
};

struct _Global
{
    float4 bgfx_indirectArgBase;
    float4 u_params[3];
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], device indirectBuffer& indirectBuffer_1 [[buffer(1)]])
{
    uint _104 = as_type<uint>(_mtl_u.u_params[0].y);
    indirectBuffer_1._data[0] = uint4(6u, _104 * 512u, as_type<uint>(_mtl_u.bgfx_indirectArgBase.x), 0u);
    indirectBuffer_1._data[1] = uint4(0u);
    indirectBuffer_1._data[2] = uint4(_104, 1u, 1u, 0u);
}

