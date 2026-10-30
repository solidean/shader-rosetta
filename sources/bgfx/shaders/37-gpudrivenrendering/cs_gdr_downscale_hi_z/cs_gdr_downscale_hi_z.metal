#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_inputRTSize;
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_texOcclusionDepthIn [[texture(0)]], texture2d<float, access::write> s_texOcclusionDepthOut [[texture(1)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    float2 _215 = float2(int3(gl_GlobalInvocationID).xy);
    if (all(_215 < _mtl_u.u_inputRTSize.xy))
    {
        float2 _227 = _mtl_u.u_inputRTSize.zw * _215;
        s_texOcclusionDepthOut.write(float4(fast::max(fast::max(s_texOcclusionDepthIn.read(uint2(int2(_227)), 0).x, s_texOcclusionDepthIn.read(uint2(int2(_227 + float2(1.0, 0.0))), 0).x), fast::max(s_texOcclusionDepthIn.read(uint2(int2(_227 + float2(0.0, 1.0))), 0).x, s_texOcclusionDepthIn.read(uint2(int2(_227 + float2(1.0))), 0).x))), uint2(int3(gl_GlobalInvocationID).xy));
    }
}

