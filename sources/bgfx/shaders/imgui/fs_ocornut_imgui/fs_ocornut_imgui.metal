#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_imguiOutput;
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
    float4 v_color0 [[user(locn0)]];
    float2 v_texcoord0 [[user(locn1)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_tex [[texture(0)]], sampler s_texSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _315 = s_tex.sample(s_texSampler, in.v_texcoord0);
    float4 _293 = _315 * in.v_color0;
    float3 _295 = _293.xyz;
    float3 _423;
    do
    {
        if (_mtl_u.u_imguiOutput.x < 0.5)
        {
            _423 = _295;
            break;
        }
        float3 _360 = mix(powr((_295 + float3(0.054999999701976776123046875)) * float3(0.947867333889007568359375), float3(2.400000095367431640625)), _295 * float3(0.077399380505084991455078125), float3(_295 <= float3(0.040449999272823333740234375))) * _mtl_u.u_imguiOutput.y;
        if (_mtl_u.u_imguiOutput.x < 1.5)
        {
            _423 = _360;
            break;
        }
        float3 _377 = powr(fast::clamp(float3(dot(float3(0.627399981021881103515625, 0.329299986362457275390625, 0.0432999990880489349365234375), _360), dot(float3(0.069099999964237213134765625, 0.91949999332427978515625, 0.011400000192224979400634765625), _360), dot(float3(0.01640000008046627044677734375, 0.087999999523162841796875, 0.895600020885467529296875), _360)), float3(0.0), float3(1.0)), float3(0.1593017578125));
        _423 = powr((float3(0.8359375) + (_377 * 18.8515625)) / (float3(1.0) + (_377 * 18.6875)), float3(78.84375));
        break;
    } while(false);
    out.bgfx_FragData0 = float4(_423, _293.w);
    return out;
}

