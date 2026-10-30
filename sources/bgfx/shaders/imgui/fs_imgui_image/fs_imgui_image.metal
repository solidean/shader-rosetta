#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_imguiOutput;
    float4 u_imageLodEnabled;
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
    float2 v_texcoord0 [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_texColor [[texture(0)]], sampler s_texColorSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _294 = s_texColor.sample(s_texColorSampler, in.v_texcoord0, level(_mtl_u.u_imageLodEnabled.x)).xyz;
    float3 _427;
    do
    {
        if (_mtl_u.u_imguiOutput.x < 0.5)
        {
            _427 = _294;
            break;
        }
        float3 _364 = mix(powr((_294 + float3(0.054999999701976776123046875)) * float3(0.947867333889007568359375), float3(2.400000095367431640625)), _294 * float3(0.077399380505084991455078125), float3(_294 <= float3(0.040449999272823333740234375))) * _mtl_u.u_imguiOutput.y;
        if (_mtl_u.u_imguiOutput.x < 1.5)
        {
            _427 = _364;
            break;
        }
        float3 _381 = powr(fast::clamp(float3(dot(float3(0.627399981021881103515625, 0.329299986362457275390625, 0.0432999990880489349365234375), _364), dot(float3(0.069099999964237213134765625, 0.91949999332427978515625, 0.011400000192224979400634765625), _364), dot(float3(0.01640000008046627044677734375, 0.087999999523162841796875, 0.895600020885467529296875), _364)), float3(0.0), float3(1.0)), float3(0.1593017578125));
        _427 = powr((float3(0.8359375) + (_381 * 18.8515625)) / (float3(1.0) + (_381 * 18.6875)), float3(78.84375));
        break;
    } while(false);
    out.bgfx_FragData0 = float4(_427, 0.20000000298023223876953125 + (0.800000011920928955078125 * _mtl_u.u_imageLodEnabled.y));
    return out;
}

