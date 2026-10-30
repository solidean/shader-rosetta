#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_s2hScatterSize;
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float, access::write> s_scatterColor [[texture(0)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    if ((int3(gl_GlobalInvocationID).x < int(_mtl_u.u_s2hScatterSize.x)) && (int3(gl_GlobalInvocationID).y < int(_mtl_u.u_s2hScatterSize.y)))
    {
        s_scatterColor.write(float4(0.4000000059604644775390625, 0.699999988079071044921875, 0.4000000059604644775390625, 1.0), uint2(int3(gl_GlobalInvocationID).xy));
    }
}

