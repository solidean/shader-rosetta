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
    float2 v_texcoord0 [[user(locn0)]];
    float4 v_texcoord1 [[user(locn1)]];
    float4 v_texcoord2 [[user(locn2)]];
    float4 v_texcoord3 [[user(locn3)]];
    float4 v_texcoord4 [[user(locn4)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], texture2d<float> s_shadowMap0 [[texture(4)]], sampler s_shadowMap0Sampler [[sampler(4)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _426 = s_shadowMap0.sample(s_shadowMap0Sampler, in.v_texcoord0) * 0.2242152392864227294921875;
    float4 _438 = s_shadowMap0.sample(s_shadowMap0Sampler, in.v_texcoord1.xy) * 0.20179371535778045654296875;
    float4 _452 = s_shadowMap0.sample(s_shadowMap0Sampler, in.v_texcoord1.zw) * 0.20179371535778045654296875;
    float4 _466 = s_shadowMap0.sample(s_shadowMap0Sampler, in.v_texcoord2.xy) * 0.12331838905811309814453125;
    float4 _480 = s_shadowMap0.sample(s_shadowMap0Sampler, in.v_texcoord2.zw) * 0.12331838905811309814453125;
    float4 _494 = s_shadowMap0.sample(s_shadowMap0Sampler, in.v_texcoord3.xy) * 0.040358744561672210693359375;
    float4 _508 = s_shadowMap0.sample(s_shadowMap0Sampler, in.v_texcoord3.zw) * 0.040358744561672210693359375;
    float4 _522 = s_shadowMap0.sample(s_shadowMap0Sampler, in.v_texcoord4.xy) * 0.02242152392864227294921875;
    float4 _536 = s_shadowMap0.sample(s_shadowMap0Sampler, in.v_texcoord4.zw) * 0.02242152392864227294921875;
    float2 _545 = (((((((float2(dot(_426.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_426.zw, float2(0.0039215688593685626983642578125, 1.0))) + float2(dot(_438.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_438.zw, float2(0.0039215688593685626983642578125, 1.0)))) + float2(dot(_452.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_452.zw, float2(0.0039215688593685626983642578125, 1.0)))) + float2(dot(_466.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_466.zw, float2(0.0039215688593685626983642578125, 1.0)))) + float2(dot(_480.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_480.zw, float2(0.0039215688593685626983642578125, 1.0)))) + float2(dot(_494.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_494.zw, float2(0.0039215688593685626983642578125, 1.0)))) + float2(dot(_508.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_508.zw, float2(0.0039215688593685626983642578125, 1.0)))) + float2(dot(_522.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_522.zw, float2(0.0039215688593685626983642578125, 1.0)))) + float2(dot(_536.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_536.zw, float2(0.0039215688593685626983642578125, 1.0)));
    float2 _715 = fract(float2(255.0, 1.0) * _545.x);
    float2 _727 = fract(float2(255.0, 1.0) * _545.y);
    out.bgfx_FragData0 = float4(_715 - (_715.xx * float2(0.0, 0.0039215688593685626983642578125)), _727 - (_727.xx * float2(0.0, 0.0039215688593685626983642578125)));
    return out;
}

