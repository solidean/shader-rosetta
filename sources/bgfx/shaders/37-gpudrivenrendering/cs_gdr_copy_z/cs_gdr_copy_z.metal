#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_inputRTSize;
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_texOcclusionDepth [[texture(0)]], texture2d<float, access::write> s_texOcclusionDepthOut [[texture(1)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    if (all(float2(int3(gl_GlobalInvocationID).xy) < _mtl_u.u_inputRTSize.xy))
    {
        s_texOcclusionDepthOut.write(float4(s_texOcclusionDepth.read(uint2(int3(int3(gl_GlobalInvocationID).xy, 0).xy), 0).x), uint2(int3(gl_GlobalInvocationID).xy));
    }
}

