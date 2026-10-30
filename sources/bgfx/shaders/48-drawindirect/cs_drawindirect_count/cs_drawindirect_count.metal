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

struct indirectCountBuffer
{
    int _data[1];
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], device instanceDataIn& instanceDataIn_1 [[buffer(1)]], device indirectBuffer& indirectBuffer_1 [[buffer(2)]], device instanceBufferOut& instanceBufferOut_1 [[buffer(3)]], device indirectCountBuffer& indirectCountBuffer_1 [[buffer(4)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    int _359 = int(_mtl_u.u_drawParams.y);
    int _366 = min((_359 * _359), int(_mtl_u.u_drawParams.x));
    int _369 = (_366 / 64) + 1;
    int _372 = int(gl_GlobalInvocationID.x) * _369;
    int _378 = min(_366, ((int(gl_GlobalInvocationID.x) + 1) * _369));
    for (int _559 = _372; _559 < _378; )
    {
        float _394 = float(spvSMod(_559, _359));
        float _396 = _mtl_u.u_drawParams.z + (_394 * 0.20999999344348907470703125);
        float _399 = float(_559 / _359);
        float _401 = _mtl_u.u_drawParams.z + (_399 * 0.37000000476837158203125);
        float _403 = sin(_396);
        float _405 = cos(_396);
        float _407 = sin(_401);
        float _409 = cos(_401);
        float _433 = float(_359 - 11);
        int _481 = _559 * 5;
        instanceBufferOut_1._data[_481] = float4(_409, 0.0, _407, 0.0);
        instanceBufferOut_1._data[_481 + 1] = float4(_403 * _407, _405, (-_403) * _409, 0.0);
        instanceBufferOut_1._data[_481 + 2] = float4((-_405) * _407, _403, _405 * _409, 0.0);
        instanceBufferOut_1._data[_481 + 3] = float4(((-15.0) - (_433 * 1.2000000476837158203125)) + (_394 * 3.0), ((-15.0) - (_433 * 1.39999997615814208984375)) + (_399 * 3.0), fast::max(0.0, (float(_359) - 11.0) * 3.0), 1.0);
        instanceBufferOut_1._data[_481 + 4] = float4((sin(_mtl_u.u_drawParams.z + (_394 * 0.0909090936183929443359375)) * 0.5) + 0.5, (cos(_mtl_u.u_drawParams.z + (_399 * 0.0909090936183929443359375)) * 0.5) + 0.5, (sin(_mtl_u.u_drawParams.z * 3.0) * 0.5) + 0.5, 1.0);
        _559++;
        continue;
    }
    for (int _560 = _372; _560 < _378; )
    {
        int _517 = _560 * 2;
        indirectBuffer_1._data[_517] = uint4(uint(((device float*)&instanceDataIn_1._data[_560])[3u]), 1u, as_type<uint>(_mtl_u.bgfx_indirectArgBase.x) + uint(((device float*)&instanceDataIn_1._data[_560])[2u]), uint(((device float*)&instanceDataIn_1._data[_560])[0u]));
        indirectBuffer_1._data[_517 + 1] = uint4(uint(_560), 0u, 0u, 0u);
        _560++;
        continue;
    }
    if (int(gl_GlobalInvocationID.x) == 0)
    {
        indirectCountBuffer_1._data[0] = _366;
    }
}

