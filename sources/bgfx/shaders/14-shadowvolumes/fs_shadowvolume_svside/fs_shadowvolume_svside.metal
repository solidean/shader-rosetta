#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

constant uint bgfx_sampleMask [[function_constant(0)]];
constant bool bgfx_sampleMaskEnabled = is_function_constant_defined(bgfx_sampleMask);

struct xlatMtlMain_out
{
	uint bgfx_metal_sampleMask [[sample_mask, function_constant(bgfx_sampleMaskEnabled)]];
    float4 bgfx_FragData0 [[color(0)]];
};

struct xlatMtlMain_in
{
    float v_k [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], bool gl_FrontFacing [[front_facing]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float _154;
    if (!gl_FrontFacing)
    {
        _154 = -in.v_k;
    }
    else
    {
        _154 = in.v_k;
    }
    out.bgfx_FragData0 = float4((abs(_154 - 1.0) < 9.9999997473787516355514526367188e-05) ? 0.0039215688593685626983642578125 : 0.0, (abs(_154 + 1.0) < 9.9999997473787516355514526367188e-05) ? 0.0039215688593685626983642578125 : 0.0, (abs(_154 - 2.0) < 9.9999997473787516355514526367188e-05) ? 0.0039215688593685626983642578125 : 0.0, (abs(_154 + 2.0) < 9.9999997473787516355514526367188e-05) ? 0.0039215688593685626983642578125 : 0.0);
    return out;
}

