#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of signed integer mod accurate to SPIR-V specification
template<typename Tx, typename Ty>
inline Tx spvSMod(Tx x, Ty y)
{
    Tx remainder = x - y * (x / y);
    return select(Tx(remainder + y), remainder, remainder == 0 || (x >= 0) == (y >= 0));
}

struct _Global
{
    float4 bgfx_indirectArgBase;
    float4 u_drawParams;
};

struct instanceBufferOut
{
    float4 _data[1];
};

struct indirectBuffer
{
    uint4 _data[1];
};

struct instanceDataIn
{
    float4 _data[1];
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], device instanceDataIn& instanceDataIn_1 [[buffer(1)]], device indirectBuffer& indirectBuffer_1 [[buffer(2)]], device instanceBufferOut& instanceBufferOut_1 [[buffer(3)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    int _348 = int(_mtl_u.u_drawParams.y);
    int _355 = min((_348 * _348), int(_mtl_u.u_drawParams.x));
    int _358 = (_355 / 64) + 1;
    int _361 = int(gl_GlobalInvocationID.x) * _358;
    int _367 = min(_355, ((int(gl_GlobalInvocationID.x) + 1) * _358));
    for (int _542 = _361; _542 < _367; )
    {
        float _383 = float(spvSMod(_542, _348));
        float _385 = _mtl_u.u_drawParams.z + (_383 * 0.20999999344348907470703125);
        float _388 = float(_542 / _348);
        float _390 = _mtl_u.u_drawParams.z + (_388 * 0.37000000476837158203125);
        float _392 = sin(_385);
        float _394 = cos(_385);
        float _396 = sin(_390);
        float _398 = cos(_390);
        float _422 = float(_348 - 11);
        int _470 = _542 * 5;
        instanceBufferOut_1._data[_470] = float4(_398, 0.0, _396, 0.0);
        instanceBufferOut_1._data[_470 + 1] = float4(_392 * _396, _394, (-_392) * _398, 0.0);
        instanceBufferOut_1._data[_470 + 2] = float4((-_394) * _396, _392, _394 * _398, 0.0);
        instanceBufferOut_1._data[_470 + 3] = float4(((-15.0) - (_422 * 1.2000000476837158203125)) + (_383 * 3.0), ((-15.0) - (_422 * 1.39999997615814208984375)) + (_388 * 3.0), fast::max(0.0, (float(_348) - 11.0) * 3.0), 1.0);
        instanceBufferOut_1._data[_470 + 4] = float4((sin(_mtl_u.u_drawParams.z + (_383 * 0.0909090936183929443359375)) * 0.5) + 0.5, (cos(_mtl_u.u_drawParams.z + (_388 * 0.0909090936183929443359375)) * 0.5) + 0.5, (sin(_mtl_u.u_drawParams.z * 3.0) * 0.5) + 0.5, 1.0);
        _542++;
        continue;
    }
    for (int _543 = _361; _543 < _367; )
    {
        int _506 = _543 * 2;
        indirectBuffer_1._data[_506] = uint4(uint(((device float*)&instanceDataIn_1._data[_543])[3u]), 1u, as_type<uint>(_mtl_u.bgfx_indirectArgBase.x) + uint(((device float*)&instanceDataIn_1._data[_543])[2u]), uint(((device float*)&instanceDataIn_1._data[_543])[0u]));
        indirectBuffer_1._data[_506 + 1] = uint4(uint(_543), 0u, 0u, 0u);
        _543++;
        continue;
    }
}

