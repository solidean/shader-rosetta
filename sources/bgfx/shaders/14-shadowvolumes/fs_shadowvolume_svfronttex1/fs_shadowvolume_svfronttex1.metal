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

fragment xlatMtlMain_out xlatMtlMain(bool gl_FrontFacing [[front_facing]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float _162 = 0.0;
    float _163 = -2.0;
    float _165 = 2.0;
    float _166 = 0.0;
    float _167 = -1.0;
    float _168 = -3.0;
    float _170 = 3.0;
    float _171 = 1.0;
    out.bgfx_FragData0 = float4((abs(gl_FrontFacing ? 0.0 : (-2.0)) < 9.9999997473787516355514526367188e-05) ? 0.0039215688593685626983642578125 : 0.0, (abs(gl_FrontFacing ? 2.0 : 0.0) < 9.9999997473787516355514526367188e-05) ? 0.0039215688593685626983642578125 : 0.0, (abs(gl_FrontFacing ? (-1.0) : (-3.0)) < 9.9999997473787516355514526367188e-05) ? 0.0039215688593685626983642578125 : 0.0, (abs(gl_FrontFacing ? 3.0 : 1.0) < 9.9999997473787516355514526367188e-05) ? 0.0039215688593685626983642578125 : 0.0);
    return out;
}

