#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct _Global
{
    float4 u_time;
};

constant spvUnsafeArray<float3, 6> _43 = spvUnsafeArray<float3, 6>({ float3(1.0, 0.0, 0.0), float3(1.0, 1.0, 0.0), float3(1.0, 0.0, 1.0), float3(0.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), float3(0.0, 0.0, 1.0) });

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d_array<float, access::write> s_texColor [[texture(0)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    for (int _178 = 0; _178 < 6; )
    {
        int3 _159 = int3(int3(gl_GlobalInvocationID).xy, _178);
        s_texColor.write(float4((_43[_178] * 0.75) + float3(sin(_mtl_u.u_time.x * 4.0) * 0.25), 1.0), uint2(_159.xy), uint(_159.z));
        _178++;
        continue;
    }
}

