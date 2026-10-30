#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_mtx;
    float4 u_lightDirTime;
};

constant uint bgfx_sampleMask [[function_constant(0)]];
constant bool bgfx_sampleMaskEnabled = is_function_constant_defined(bgfx_sampleMask);

struct xlatMtlMain_out
{
	uint bgfx_metal_sampleMask [[sample_mask, function_constant(bgfx_sampleMaskEnabled)]];
    float4 bgfx_FragData0 [[color(0)]];
    float gl_FragDepth [[depth(any)]];
};

struct xlatMtlMain_in
{
    float4 v_color0 [[user(locn0)]];
    float2 v_texcoord0 [[user(locn1)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _556 = _mtl_u.u_mtx * float4(in.v_texcoord0, 0.0, 1.0);
    float3 _562 = _556.xyz / float3(_556.w);
    float4 _569 = _mtl_u.u_mtx * float4(in.v_texcoord0, 1.0, 1.0);
    float3 _578 = (_569.xyz / float3(_569.w)) - _562;
    float _579 = length(_578);
    float3 _583 = fast::normalize(_578);
    float _1642;
    _1642 = 0.0;
    float _1649;
    for (int _1641 = 0; _1641 < 64; _1642 = _1649, _1641++)
    {
        float3 _656 = _562 + (_583 * _1642);
        float _732 = fast::min(fast::min(fast::min(fast::min(fast::min(fast::min(length(fast::max(abs(_656) - float3(2.5), float3(0.0))) - 0.5, length(_656 + float3(4.0, 0.0, 0.0)) - 1.0), length(_656 + float3(-4.0, 0.0, 0.0)) - 1.0), length(_656 + float3(0.0, 4.0, 0.0)) - 1.0), length(_656 + float3(0.0, -4.0, 0.0)) - 1.0), length(_656 + float3(0.0, 0.0, 4.0)) - 1.0), length(_656 + float3(0.0, 0.0, -4.0)) - 1.0);
        if (_732 > 0.001000000047497451305389404296875)
        {
            _1649 = _1642 + _732;
        }
        else
        {
            _1649 = _1642;
        }
    }
    float _674 = (_1642 < _579) ? _1642 : 0.0;
    float4 _1646;
    float _1647;
    if (_674 > 0.5)
    {
        float3 _595 = _562 + (_583 * _674);
        float3 _816 = fast::normalize(float3(fast::min(fast::min(fast::min(fast::min(fast::min(fast::min(length(fast::max(abs(_595 + float3(0.00200000009499490261077880859375, 0.0, 0.0)) - float3(2.5), float3(0.0))) - 0.5, length(_595 + float3(4.00199985504150390625, 0.0, 0.0)) - 1.0), length(_595 + float3(-3.9979999065399169921875, 0.0, 0.0)) - 1.0), length(_595 + float3(0.00200000009499490261077880859375, 4.0, 0.0)) - 1.0), length(_595 + float3(0.00200000009499490261077880859375, -4.0, 0.0)) - 1.0), length(_595 + float3(0.00200000009499490261077880859375, 0.0, 4.0)) - 1.0), length(_595 + float3(0.00200000009499490261077880859375, 0.0, -4.0)) - 1.0) - fast::min(fast::min(fast::min(fast::min(fast::min(fast::min(length(fast::max(abs(_595 - float3(0.00200000009499490261077880859375, 0.0, 0.0)) - float3(2.5), float3(0.0))) - 0.5, length(_595 + float3(3.9979999065399169921875, 0.0, 0.0)) - 1.0), length(_595 + float3(-4.00199985504150390625, 0.0, 0.0)) - 1.0), length(_595 + float3(-0.00200000009499490261077880859375, 4.0, 0.0)) - 1.0), length(_595 + float3(-0.00200000009499490261077880859375, -4.0, 0.0)) - 1.0), length(_595 + float3(-0.00200000009499490261077880859375, 0.0, 4.0)) - 1.0), length(_595 + float3(-0.00200000009499490261077880859375, 0.0, -4.0)) - 1.0), fast::min(fast::min(fast::min(fast::min(fast::min(fast::min(length(fast::max(abs(_595 + float3(0.0, 0.00200000009499490261077880859375, 0.0)) - float3(2.5), float3(0.0))) - 0.5, length(_595 + float3(4.0, 0.00200000009499490261077880859375, 0.0)) - 1.0), length(_595 + float3(-4.0, 0.00200000009499490261077880859375, 0.0)) - 1.0), length(_595 + float3(0.0, 4.00199985504150390625, 0.0)) - 1.0), length(_595 + float3(0.0, -3.9979999065399169921875, 0.0)) - 1.0), length(_595 + float3(0.0, 0.00200000009499490261077880859375, 4.0)) - 1.0), length(_595 + float3(0.0, 0.00200000009499490261077880859375, -4.0)) - 1.0) - fast::min(fast::min(fast::min(fast::min(fast::min(fast::min(length(fast::max(abs(_595 - float3(0.0, 0.00200000009499490261077880859375, 0.0)) - float3(2.5), float3(0.0))) - 0.5, length(_595 + float3(4.0, -0.00200000009499490261077880859375, 0.0)) - 1.0), length(_595 + float3(-4.0, -0.00200000009499490261077880859375, 0.0)) - 1.0), length(_595 + float3(0.0, 3.9979999065399169921875, 0.0)) - 1.0), length(_595 + float3(0.0, -4.00199985504150390625, 0.0)) - 1.0), length(_595 + float3(0.0, -0.00200000009499490261077880859375, 4.0)) - 1.0), length(_595 + float3(0.0, -0.00200000009499490261077880859375, -4.0)) - 1.0), fast::min(fast::min(fast::min(fast::min(fast::min(fast::min(length(fast::max(abs(_595 + float3(0.0, 0.0, 0.00200000009499490261077880859375)) - float3(2.5), float3(0.0))) - 0.5, length(_595 + float3(4.0, 0.0, 0.00200000009499490261077880859375)) - 1.0), length(_595 + float3(-4.0, 0.0, 0.00200000009499490261077880859375)) - 1.0), length(_595 + float3(0.0, 4.0, 0.00200000009499490261077880859375)) - 1.0), length(_595 + float3(0.0, -4.0, 0.00200000009499490261077880859375)) - 1.0), length(_595 + float3(0.0, 0.0, 4.00199985504150390625)) - 1.0), length(_595 + float3(0.0, 0.0, -3.9979999065399169921875)) - 1.0) - fast::min(fast::min(fast::min(fast::min(fast::min(fast::min(length(fast::max(abs(_595 - float3(0.0, 0.0, 0.00200000009499490261077880859375)) - float3(2.5), float3(0.0))) - 0.5, length(_595 + float3(4.0, 0.0, -0.00200000009499490261077880859375)) - 1.0), length(_595 + float3(-4.0, 0.0, -0.00200000009499490261077880859375)) - 1.0), length(_595 + float3(0.0, 4.0, -0.00200000009499490261077880859375)) - 1.0), length(_595 + float3(0.0, -4.0, -0.00200000009499490261077880859375)) - 1.0), length(_595 + float3(0.0, 0.0, 3.9979999065399169921875)) - 1.0), length(_595 + float3(0.0, 0.0, -4.00199985504150390625)) - 1.0)));
        float _1454 = dot(_816, _mtl_u.u_lightDirTime.xyz);
        float _1644;
        _1644 = 0.0;
        for (int _1643 = 1; _1643 < 4; )
        {
            float _1511 = float(_1643);
            float3 _1518 = _595 + ((_816 * _1511) * 0.20000000298023223876953125);
            _1644 += (((_1511 * 0.20000000298023223876953125) - fast::min(fast::min(fast::min(fast::min(fast::min(fast::min(length(fast::max(abs(_1518) - float3(2.5), float3(0.0))) - 0.5, length(_1518 + float3(4.0, 0.0, 0.0)) - 1.0), length(_1518 + float3(-4.0, 0.0, 0.0)) - 1.0), length(_1518 + float3(0.0, 4.0, 0.0)) - 1.0), length(_1518 + float3(0.0, -4.0, 0.0)) - 1.0), length(_1518 + float3(0.0, 0.0, 4.0)) - 1.0), length(_1518 + float3(0.0, 0.0, -4.0)) - 1.0)) / powr(2.0, _1511));
            _1643++;
            continue;
        }
        float _627 = powr(((0.89999997615814208984375 * fast::max(0.0, _1454)) + (powr(step(0.0, _1454) * fast::max(0.0, dot(_mtl_u.u_lightDirTime.xyz - (_816 * (2.0 * _1454)), _583)), 128.0) * fast::max(0.20000000298023223876953125 + (0.800000011920928955078125 * powr(1.0 - _1454, 5.0)), 0.0))) * (1.0 - _1644), 0.4545454680919647216796875);
        _1647 = _674 / _579;
        _1646 = float4(_627, _627, _627, 1.0);
    }
    else
    {
        _1647 = 1.0;
        _1646 = in.v_color0;
    }
    out.bgfx_FragData0 = _1646;
    out.gl_FragDepth = _1647;
    return out;
}

