#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_svparams;
};

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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], bool gl_FrontFacing [[front_facing]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float _187;
    if (!gl_FrontFacing)
    {
        _187 = -in.v_k;
    }
    else
    {
        _187 = in.v_k;
    }
    float _188;
    if (_mtl_u.u_svparams.y == 0.0)
    {
        _188 = -_187;
    }
    else
    {
        _188 = _187;
    }
    out.bgfx_FragData0 = float4((abs(_188 - 1.0) < 9.9999997473787516355514526367188e-05) ? 0.0039215688593685626983642578125 : 0.0, (abs(_188 + 1.0) < 9.9999997473787516355514526367188e-05) ? 0.0039215688593685626983642578125 : 0.0, (abs(_188 - 2.0) < 9.9999997473787516355514526367188e-05) ? 0.0039215688593685626983642578125 : 0.0, (abs(_188 + 2.0) < 9.9999997473787516355514526367188e-05) ? 0.0039215688593685626983642578125 : 0.0);
    return out;
}

