#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_offset[16];
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
    float4 _603 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[0].xy));
    float4 _624 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[1].xy));
    float4 _645 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[2].xy));
    float4 _666 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[3].xy));
    float4 _687 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[4].xy));
    float4 _708 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[5].xy));
    float4 _729 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[6].xy));
    float4 _750 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[7].xy));
    float4 _771 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[8].xy));
    float4 _792 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[9].xy));
    float _526 = (((((((((_603.x * exp2((_603.w * 255.0) - 128.0)) + (_624.x * exp2((_624.w * 255.0) - 128.0))) + (_645.x * exp2((_645.w * 255.0) - 128.0))) + (_666.x * exp2((_666.w * 255.0) - 128.0))) + (_687.x * exp2((_687.w * 255.0) - 128.0))) + (_708.x * exp2((_708.w * 255.0) - 128.0))) + (_729.x * exp2((_729.w * 255.0) - 128.0))) + (_750.x * exp2((_750.w * 255.0) - 128.0))) + (_771.x * exp2((_771.w * 255.0) - 128.0))) + (_792.x * exp2((_792.w * 255.0) - 128.0));
    float4 _813 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[10].xy));
    float4 _834 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[11].xy));
    float4 _855 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[12].xy));
    float4 _876 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[13].xy));
    float4 _897 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[14].xy));
    float4 _918 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[15].xy));
    float _588 = ((((((_526 + (_813.x * exp2((_813.w * 255.0) - 128.0))) + (_834.x * exp2((_834.w * 255.0) - 128.0))) + (_855.x * exp2((_855.w * 255.0) - 128.0))) + (_876.x * exp2((_876.w * 255.0) - 128.0))) + (_897.x * exp2((_897.w * 255.0) - 128.0))) + (_918.x * exp2((_918.w * 255.0) - 128.0))) * 0.0625;
    float _936 = ceil(log2(_588));
    out.bgfx_FragData0 = float4(_588 / exp2(_936), 0.0, 0.0, (_936 + 128.0) * 0.0039215688593685626983642578125);
    return out;
}

