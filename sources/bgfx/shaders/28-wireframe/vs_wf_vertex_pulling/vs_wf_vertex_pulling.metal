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

struct indices
{
    uint _data[1];
};

struct _Global
{
    float4 u_viewRect;
    float4x4 u_modelViewProj;
    float4 u_params[3];
};

constant spvUnsafeArray<float2, 6> _283 = spvUnsafeArray<float2, 6>({ float2(-1.0), float2(-1.0, 1.0), float2(1.0, -1.0), float2(1.0, -1.0), float2(-1.0, 1.0), float2(1.0) });

struct xlatMtlMain_out
{
    float4 _entryPointOutput_v_color [[user(locn0)]];
    float4 gl_Position [[position]];
};

vertex xlatMtlMain_out xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], const device indices& positions [[buffer(1)]], const device indices& indices_1 [[buffer(2)]], uint gl_VertexIndex [[vertex_id]])
{
    spvUnsafeArray<float2, 6> _475 = spvUnsafeArray<float2, 6>({ float2(-1.0), float2(-1.0, 1.0), float2(1.0, -1.0), float2(1.0, -1.0), float2(-1.0, 1.0), float2(1.0) });
    xlatMtlMain_out out = {};
    _475 = _283;
    uint _499 = gl_VertexIndex / 6u;
    uint _503 = _499 % 3u;
    uint _514 = (_499 - _503) + ((_503 + 1u) % 3u);
    uint _867;
    do
    {
        uint _703 = _499 / 2u;
        if ((_499 % 2u) == 0u)
        {
            _867 = indices_1._data[_703] & 65535u;
            break;
        }
        else
        {
            _867 = indices_1._data[_703] >> 16u;
            break;
        }
        break; // unreachable workaround
    } while(false);
    uint _868;
    do
    {
        uint _725 = _514 / 2u;
        if ((_514 % 2u) == 0u)
        {
            _868 = indices_1._data[_725] & 65535u;
            break;
        }
        else
        {
            _868 = indices_1._data[_725] >> 16u;
            break;
        }
        break; // unreachable workaround
    } while(false);
    uint _749 = uint(_mtl_u.u_params[2].z);
    uint _752 = _867 * _749;
    uint _793 = _868 * _749;
    float4 _530 = _mtl_u.u_modelViewProj * float4(as_type<float>(positions._data[_752]), as_type<float>(positions._data[_752 + 1u]), as_type<float>(positions._data[_752 + 2u]), 1.0);
    float4 _538 = _mtl_u.u_modelViewProj * float4(as_type<float>(positions._data[_793]), as_type<float>(positions._data[_793 + 1u]), as_type<float>(positions._data[_793 + 2u]), 1.0);
    float4 _547 = float4(_mtl_u.u_params[1].xyz, _mtl_u.u_params[1].w);
    float _562 = _530.w;
    float4 _870;
    float4 _896;
    if (_562 < 0.001000000047497451305389404296875)
    {
        float4 _575 = float4((0.001000000047497451305389404296875 - _562) / (_538.w - _562));
        _896 = mix(_530, _538, _575);
        _870 = mix(_547, _547, _575);
    }
    else
    {
        _896 = _530;
        _870 = _547;
    }
    float _586 = _538.w;
    float4 _871;
    float4 _897;
    if (_586 < 0.001000000047497451305389404296875)
    {
        float4 _599 = float4((0.001000000047497451305389404296875 - _586) / (_562 - _586));
        _897 = mix(_538, _530, _599);
        _871 = mix(_547, _547, _599);
    }
    else
    {
        _897 = _538;
        _871 = _547;
    }
    float2 _615 = (_475[gl_VertexIndex % 6u] * 0.5) + float2(0.5);
    float4 _618 = float4(_615.x);
    float4 _851 = mix(_896, _897, _618);
    float2 _642 = (_897.xy / float2(_897.w)) - (_896.xy / float2(_896.w));
    float _644 = length(_642);
    float4 _899;
    if (_644 > 9.9999997473787516355514526367188e-05)
    {
        float2 _651 = _642 / float2(_644);
        float2 _685 = _851.xy + ((((float2(-_651.y, _651.x) * (0.5 * _mtl_u.u_params[2].y)) * ((2.0 * _615.y) - 1.0)) * float2(2.0 / _mtl_u.u_viewRect.z, 2.0 / _mtl_u.u_viewRect.w)) * _851.w);
        float4 _892 = _851;
        _892.x = _685.x;
        _892.y = _685.y;
        _899 = _892;
    }
    else
    {
        _899 = _851;
    }
    out.gl_Position = _899;
    out._entryPointOutput_v_color = mix(_870, _871, _618);
    return out;
}

