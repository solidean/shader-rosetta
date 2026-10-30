#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[19];
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_depthSource [[texture(0)]], texture2d<float, access::write> s_target0 [[texture(1)]], texture2d<float, access::write> s_target1 [[texture(2)]], texture2d<float, access::write> s_target2 [[texture(3)]], texture2d<float, access::write> s_target3 [[texture(4)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    if (all(float2(uint2(int3(gl_GlobalInvocationID).xy)) < float2(uint2(s_target0.get_width(), s_target0.get_height()))))
    {
        int2 _333 = int3(gl_GlobalInvocationID).xy * int2(2);
        s_target0.write(float4(_mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.read(uint2(int3(_333, 0).xy), 0).x)), uint2(int3(gl_GlobalInvocationID).xy));
        s_target1.write(float4(_mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.read(uint2(int3(_333 + int2(1, 0), 0).xy), 0).x)), uint2(int3(gl_GlobalInvocationID).xy));
        s_target2.write(float4(_mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.read(uint2(int3(_333 + int2(0, 1), 0).xy), 0).x)), uint2(int3(gl_GlobalInvocationID).xy));
        s_target3.write(float4(_mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.read(uint2(int3(_333 + int2(1), 0).xy), 0).x)), uint2(int3(gl_GlobalInvocationID).xy));
    }
}

