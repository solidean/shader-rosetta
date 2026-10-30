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
    float4 bgfx_indirectArgBase;
    float4 u_cullingConfig;
};

struct instancePredicates
{
    uint _data[1];
};

struct instanceDataOut
{
    float4 _data[1];
};

struct instanceDataIn
{
    float4 _data[1];
};

struct drawcallData
{
    uint4 _data[1];
};

struct drawcallConstData
{
    uint _data[1];
};

struct drawcallInstanceCount
{
    uint _data[1];
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], device drawcallConstData& drawcallConstData_1 [[buffer(1)]], device instanceDataIn& instanceDataIn_1 [[buffer(2)]], device instancePredicates& instancePredicates_1 [[buffer(3)]], device drawcallInstanceCount& drawcallInstanceCount_1 [[buffer(4)]], device drawcallData& drawcallData_1 [[buffer(5)]], device instanceDataOut& instanceDataOut_1 [[buffer(6)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    threadgroup spvUnsafeArray<uint, 2048> temp;
    uint _427 = uint(int(gl_GlobalInvocationID.x));
    int _430 = int(_mtl_u.u_cullingConfig.y);
    int _433 = int(_mtl_u.u_cullingConfig.w);
    uint _435 = 2u * _427;
    temp[_435] = uint(int(instancePredicates_1._data[_435] != 0u));
    uint _447 = _435 + 1u;
    temp[_447] = uint(int(instancePredicates_1._data[_447] != 0u));
    int _459 = _430 >> 1;
    int _726;
    _726 = 1;
    int _496;
    for (int _720 = _459; _720 > 0; _726 = _496, _720 = _720 >> 1)
    {
        threadgroup_barrier(mem_flags::mem_threadgroup);
        if (_427 < uint(_720))
        {
            uint _471 = uint(_726);
            int _485 = int((_471 * (_435 + 2u)) - 1u);
            temp[_485] += temp[int((_471 * _447) - 1u)];
        }
        _496 = _726 * 2;
    }
    bool _502 = _427 == 0u;
    if (_502)
    {
        temp[_430 - 1] = 0u;
    }
    int _515;
    for (int _721 = 1, _724 = _726; _721 < _430; _724 = _515, _721 *= 2)
    {
        _515 = _724 >> 1;
        threadgroup_barrier(mem_flags::mem_threadgroup);
        if (_427 < uint(_721))
        {
            uint _522 = uint(_515);
            int _528 = int((_522 * _447) - 1u);
            int _536 = int((_522 * (_435 + 2u)) - 1u);
            uint _539 = temp[_528];
            temp[_528] = temp[_536];
            temp[_536] += _539;
        }
    }
    threadgroup_barrier(mem_flags::mem_threadgroup);
    int _560 = int(_435);
    if (instancePredicates_1._data[_560] != 0u)
    {
        int _572 = 4 * _560;
        instanceDataOut_1._data[4u * temp[_560]] = instanceDataIn_1._data[_572];
        instanceDataOut_1._data[(4u * temp[_560]) + 1u] = instanceDataIn_1._data[_572 + 1];
        instanceDataOut_1._data[(4u * temp[_560]) + 2u] = instanceDataIn_1._data[_572 + 2];
        instanceDataOut_1._data[(4u * temp[_560]) + 3u] = instanceDataIn_1._data[_572 + 3];
    }
    int _613 = int(_447);
    if (instancePredicates_1._data[_613] != 0u)
    {
        int _625 = 4 * _613;
        instanceDataOut_1._data[4u * temp[_613]] = instanceDataIn_1._data[_625];
        instanceDataOut_1._data[(4u * temp[_613]) + 1u] = instanceDataIn_1._data[_625 + 1];
        instanceDataOut_1._data[(4u * temp[_613]) + 2u] = instanceDataIn_1._data[_625 + 2];
        instanceDataOut_1._data[(4u * temp[_613]) + 3u] = instanceDataIn_1._data[_625 + 3];
    }
    if (_502)
    {
        int _722 = 0;
        uint _723 = 0u;
        for (; _722 < _433; )
        {
            int _673 = _722 * 2;
            int _676 = _722 * 3;
            drawcallData_1._data[_673] = uint4(drawcallConstData_1._data[_676], drawcallInstanceCount_1._data[_722], as_type<uint>(_mtl_u.bgfx_indirectArgBase.x) + drawcallConstData_1._data[_676 + 1], drawcallConstData_1._data[_676 + 2]);
            drawcallData_1._data[_673 + 1] = uint4(_723, 0u, 0u, 0u);
            uint _706 = drawcallInstanceCount_1._data[_722];
            drawcallInstanceCount_1._data[_722] = 0u;
            _723 += _706;
            _722++;
            continue;
        }
    }
}

