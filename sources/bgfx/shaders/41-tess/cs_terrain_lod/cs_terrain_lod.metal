#pragma clang diagnostic ignored "-Wunused-variable"
#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>
#include <metal_atomic>

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
    float4x4 u_invView;
    float4x4 u_modelView;
    float4x4 u_modelViewProj;
    float4 u_params[2];
};

struct u_AtomicCounterBuffer
{
    uint _data[1];
};

struct u_SubdBufferIn
{
    uint _data[1];
};

struct u_VertexBuffer
{
    float4 _data[1];
};

constant float _2315 = {};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], device u_AtomicCounterBuffer& u_SubdBufferOut [[buffer(2)]], device u_AtomicCounterBuffer& u_CulledSubdBuffer [[buffer(3)]], device u_AtomicCounterBuffer& u_AtomicCounterBuffer_1 [[buffer(5)]], device u_VertexBuffer& u_VertexBuffer_1 [[buffer(7)]], device u_SubdBufferIn& u_IndexBuffer [[buffer(8)]], device u_SubdBufferIn& u_SubdBufferIn_1 [[buffer(9)]], texture2d<float> u_DmapSampler [[texture(0)]], sampler u_DmapSamplerSampler [[sampler(0)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    do
    {
        uint _1072 = uint(int(gl_GlobalInvocationID.x));
        if (_1072 >= u_AtomicCounterBuffer_1._data[2])
        {
            break;
        }
        uint _1080 = _1072 * 2u;
        uint _1082 = u_SubdBufferIn_1._data[_1080];
        uint _1084 = _1082 * 3u;
        uint _1086 = u_IndexBuffer._data[_1084];
        float4 _1088 = u_VertexBuffer_1._data[_1086];
        uint _1094 = u_IndexBuffer._data[_1084 + 1u];
        float4 _1096 = u_VertexBuffer_1._data[_1094];
        uint _1102 = u_IndexBuffer._data[_1084 + 2u];
        float4 _1104 = u_VertexBuffer_1._data[_1102];
        uint _1108 = _1080 + 1u;
        uint _1110 = u_SubdBufferIn_1._data[_1108];
        uint _1249 = _1110 >> 1u;
        float3x3 _2288;
        _2288 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
        for (uint _2287 = _1249; _2287 > 1u; )
        {
            float _1309 = float(_2287 & 1u);
            float _1311 = 1.0 - _1309;
            _2288 = transpose(float3x3(float3(0.0, _1311, _1309), float3(0.5, _1309, 0.0), float3(0.5, 0.0, _1311))) * _2288;
            _2287 = _2287 >> 1u;
            continue;
        }
        float3x3 _2290;
        _2290 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
        for (uint _2289 = _1110; _2289 > 1u; )
        {
            float _1401 = float(_2289 & 1u);
            float _1403 = 1.0 - _1401;
            _2290 = transpose(float3x3(float3(0.0, _1403, _1401), float3(0.5, _1401, 0.0), float3(0.5, 0.0, _1403))) * _2290;
            _2289 = _2289 >> 1u;
            continue;
        }
        float3x4 _1454 = float3x4(_1088, _1096, _1104);
        float3x4 _1214 = _1454 * _2290;
        float3x4 _1217 = _1454 * _2288;
        float4 _1459 = _1214[0];
        float4 _1464 = _1214[1];
        float4 _1469 = _1214[2];
        uint _2294;
        uint _2295;
        if (_mtl_u.u_params[0].w == 0.0)
        {
            float3 _1497 = (_1464.xyz + _1469.xyz) * float3(0.5);
            float2 _1558 = (float4(_mtl_u.u_invView[3][0], _mtl_u.u_invView[3][1], _2315, _2315).xy * 0.5) + float2(0.5);
            float3 _1595 = (_1217[1].xyz + _1217[2].xyz) * float3(0.5);
            _2295 = uint((-2.0) * log2(fast::clamp(length((_mtl_u.u_modelView * float4(_1595.xy, _1595.z + (u_DmapSampler.sample(u_DmapSamplerSampler, _1558, level(0.0)).x * _mtl_u.u_params[0].x), 1.0)).xyz) * _mtl_u.u_params[0].y, 0.0, 1.0)));
            _2294 = uint((-2.0) * log2(fast::clamp(length((_mtl_u.u_modelView * float4(_1497.xy, _1497.z + (u_DmapSampler.sample(u_DmapSamplerSampler, _1558, level(0.0)).x * _mtl_u.u_params[0].x), 1.0)).xyz) * _mtl_u.u_params[0].y, 0.0, 1.0)));
        }
        else
        {
            uint _2292;
            uint _2291 = 0u;
            for (;;)
            {
                if (_2291 < 32u)
                {
                    if ((_1110 & uint(int(0x80000000) >> int(_2291))) != 0u)
                    {
                        _2292 = 31u - _2291;
                        break;
                    }
                    _2291++;
                    continue;
                }
                else
                {
                    _2292 = 4294967295u;
                    break;
                }
            }
            _2295 = _2292;
            _2294 = _2292;
        }
        uint _2297;
        uint _2296 = 0u;
        for (;;)
        {
            if (_2296 < 32u)
            {
                if ((_1110 & uint(int(0x80000000) >> int(_2296))) != 0u)
                {
                    _2297 = 31u - _2296;
                    break;
                }
                _2296++;
                continue;
            }
            else
            {
                _2297 = 4294967295u;
                break;
            }
        }
        uint _2300;
        uint _2299 = 0u;
        for (;;)
        {
            if (_2299 < 32u)
            {
                if ((_1110 & uint(int(0x80000000) >> int(_2299))) != 0u)
                {
                    _2300 = 31u - _2299;
                    break;
                }
                _2299++;
                continue;
            }
            else
            {
                _2300 = 4294967295u;
                break;
            }
        }
        if ((_2297 < _2294) && (_2300 != 31u))
        {
            uint _1851 = _1110 << 1u;
            uint _1861 = atomic_fetch_add_explicit((device atomic_uint*)&u_AtomicCounterBuffer_1._data[0], 2u, memory_order_relaxed);
            u_SubdBufferOut._data[_1861] = _1082;
            u_SubdBufferOut._data[_1861 + 1u] = _1851;
            uint _1872 = atomic_fetch_add_explicit((device atomic_uint*)&u_AtomicCounterBuffer_1._data[0], 2u, memory_order_relaxed);
            u_SubdBufferOut._data[_1872] = _1082;
            u_SubdBufferOut._data[_1872 + 1u] = _1851 | 1u;
        }
        else
        {
            if (_2297 < (_2295 + 1u))
            {
                uint _1883 = atomic_fetch_add_explicit((device atomic_uint*)&u_AtomicCounterBuffer_1._data[0], 2u, memory_order_relaxed);
                u_SubdBufferOut._data[_1883] = _1082;
                u_SubdBufferOut._data[_1883 + 1u] = _1110;
            }
            else
            {
                if (_1110 == 1u)
                {
                    uint _1898 = atomic_fetch_add_explicit((device atomic_uint*)&u_AtomicCounterBuffer_1._data[0], 2u, memory_order_relaxed);
                    u_SubdBufferOut._data[_1898] = _1082;
                    u_SubdBufferOut._data[_1898 + 1u] = _1110;
                }
                else
                {
                    if ((_1110 & 1u) == 0u)
                    {
                        uint _1918 = atomic_fetch_add_explicit((device atomic_uint*)&u_AtomicCounterBuffer_1._data[0], 2u, memory_order_relaxed);
                        u_SubdBufferOut._data[_1918] = _1082;
                        u_SubdBufferOut._data[_1918 + 1u] = _1249;
                    }
                }
            }
        }
        float4 _1144 = fast::min(fast::min(_1459, _1464), _1469);
        float4 _1152 = fast::max(fast::max(_1459, _1464), _1469);
        _1144.z = 0.0;
        _1152.z = _mtl_u.u_params[0].x;
        int _2302;
        _2302 = 0;
        float4x4 _1975;
        float4x4 _1978;
        float4x4 _1984;
        float4x4 _1987;
        float4x4 _1993;
        float4x4 _1996;
        float4x4 _2002;
        float4x4 _2005;
        spvUnsafeArray<float4, 6> _2218;
        for (; _2302 < 3; _2302++)
        {
            for (int _2306 = 0; _2306 < 2; )
            {
                int _2022 = (_2302 * 2) + _2306;
                bool _2026 = _2306 == 0;
                _1975 = transpose(_mtl_u.u_modelViewProj);
                _1978 = transpose(_mtl_u.u_modelViewProj);
                _2218[_2022].x = _mtl_u.u_modelViewProj[0][3] + (_2026 ? _1975[_2302].x : (-_1978[_2302].x));
                _1984 = transpose(_mtl_u.u_modelViewProj);
                _1987 = transpose(_mtl_u.u_modelViewProj);
                _2218[_2022].y = _mtl_u.u_modelViewProj[1][3] + (_2026 ? _1984[_2302].y : (-_1987[_2302].y));
                _1993 = transpose(_mtl_u.u_modelViewProj);
                _1996 = transpose(_mtl_u.u_modelViewProj);
                _2218[_2022].z = _mtl_u.u_modelViewProj[2][3] + (_2026 ? _1993[_2302].z : (-_1996[_2302].z));
                _2002 = transpose(_mtl_u.u_modelViewProj);
                _2005 = transpose(_mtl_u.u_modelViewProj);
                _2218[_2022].w = _mtl_u.u_modelViewProj[3][3] + (_2026 ? _2002[_2302].w : (-_2005[_2302].w));
                _2218[_2022] *= length(_2218[_2022].xyz);
                _2306++;
                continue;
            }
        }
        spvUnsafeArray<float4, 6> _2214 = _2218;
        int _2303;
        float _2304;
        _2304 = 1.0;
        _2303 = 0;
        bool _1945;
        for (;;)
        {
            _1945 = _2304 >= 0.0;
            if ((_2303 < 6) && _1945)
            {
                _2304 = dot(float4(mix(_1144.xyz, _1152.xyz, float3(_2214[_2303].xyz > float3(0.0))), 1.0), _2214[_2303]);
                _2303++;
                continue;
            }
            else
            {
                break;
            }
        }
        if ((_mtl_u.u_params[0].z == 0.0) || _1945)
        {
            uint _1169 = atomic_fetch_add_explicit((device atomic_uint*)&u_AtomicCounterBuffer_1._data[1], 2u, memory_order_relaxed);
            u_CulledSubdBuffer._data[_1169] = _1082;
            u_CulledSubdBuffer._data[_1169 + 1u] = _1110;
        }
        break;
    } while(false);
}

