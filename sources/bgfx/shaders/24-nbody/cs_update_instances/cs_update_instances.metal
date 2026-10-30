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
    float4 u_params[3];
};

struct prevPositionBuffer
{
    float4 _data[1];
};

struct outPrevPositionBuffer
{
    float4 _data[1];
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], device prevPositionBuffer& prevPositionBuffer_1 [[buffer(1)]], device prevPositionBuffer& currPositionBuffer [[buffer(2)]], device outPrevPositionBuffer& outPrevPositionBuffer_1 [[buffer(3)]], device outPrevPositionBuffer& outCurrPositionBuffer [[buffer(4)]], uint gl_LocalInvocationIndex [[thread_index_in_threadgroup]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    threadgroup spvUnsafeArray<float3, 512> otherEntries;
    float4 _270 = prevPositionBuffer_1._data[int(gl_GlobalInvocationID.x)];
    float4 _275 = currPositionBuffer._data[int(gl_GlobalInvocationID.x)];
    float3 _407;
    _407 = float3(0.0);
    float3 _411;
    for (int _406 = 0; _406 < as_type<int>(_mtl_u.u_params[0].y); _407 = _411, _406++)
    {
        otherEntries[int(gl_LocalInvocationIndex)] = currPositionBuffer._data[(_406 * 512) + int(gl_LocalInvocationIndex)].xyz;
        threadgroup_barrier(mem_flags::mem_threadgroup);
        _411 = _407;
        for (int _409 = 0; _409 < 512; )
        {
            float3 _384 = otherEntries[_409] - _275.xyz;
            float _387 = dot(_384, _384);
            _411 += (_384 * ((_mtl_u.u_params[0].z * _mtl_u.u_params[0].z) * (1.0 / (sqrt((_387 * _387) * _387) + 0.100000001490116119384765625))));
            _409++;
            continue;
        }
    }
    float3 _323 = _407 + ((_270.xyz - _275.xyz) * _mtl_u.u_params[0].w);
    float _325 = length(_323);
    float3 _408;
    if (_325 > 0.0)
    {
        _408 = fast::normalize(_323) * fast::min(_325, _mtl_u.u_params[2].z);
    }
    else
    {
        _408 = _323;
    }
    outPrevPositionBuffer_1._data[int(gl_GlobalInvocationID.x)] = float4(_275.xyz, 0.0);
    outCurrPositionBuffer._data[int(gl_GlobalInvocationID.x)] = float4(((_275.xyz * 2.0) - _270.xyz) + (_408 * _mtl_u.u_params[0].x), powr(fast::min(_325 * 0.3333333432674407958984375, 1.0), 0.25));
}

