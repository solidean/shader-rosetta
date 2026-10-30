#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_tonemap;
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
    float4 v_texcoord1 [[user(locn1)]];
    float4 v_texcoord2 [[user(locn2)]];
    float4 v_texcoord3 [[user(locn3)]];
    float4 v_texcoord4 [[user(locn4)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_texColor [[texture(0)]], texture2d<float> s_texLum [[texture(1)]], texture2d<float> s_texBlur [[texture(2)]], sampler s_texColorSampler [[sampler(0)]], sampler s_texLumSampler [[sampler(1)]], sampler s_texBlurSampler [[sampler(2)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _637 = s_texColor.sample(s_texColorSampler, in.v_texcoord0);
    float3 _650 = _637.xyz * exp2((_637.w * 255.0) - 128.0);
    float4 _660 = s_texLum.sample(s_texLumSampler, in.v_texcoord0);
    float _684 = dot(float3(0.41245639324188232421875, 0.3575761020183563232421875, 0.180437505245208740234375), _650);
    float _687 = dot(float3(0.21267290413379669189453125, 0.715152204036712646484375, 0.072175003588199615478515625), _650);
    float _698 = 1.0 / dot(float3(_684, _687, dot(float3(0.01933390088379383087158203125, 0.119191996753215789794921875, 0.950304090976715087890625), _650)), float3(1.0));
    float _704 = _684 * _698;
    float _708 = _687 * _698;
    float _600 = (_687 * _mtl_u.u_tonemap.x) / (fast::clamp(_660.x * exp2((_660.w * 255.0) - 128.0), 0.100000001490116119384765625, 0.699999988079071044921875) + 9.9999997473787516355514526367188e-05);
    float _720 = (_600 * (1.0 + (_600 / _mtl_u.u_tonemap.y))) / (1.0 + _600);
    float3 _1039 = float3((_720 * _704) / _708, _720, (_720 * ((1.0 - _704) - _708)) / _708);
    float3 _618 = float3(dot(float3(3.240454196929931640625, -1.537138462066650390625, -0.498531401157379150390625), _1039), dot(float3(-0.969265997409820556640625, 1.87601077556610107421875, 0.04155600070953369140625), _1039), dot(float3(0.0556433983147144317626953125, -0.2040258944034576416015625, 1.05722522735595703125), _1039)) + ((((((((((s_texBlur.sample(s_texBlurSampler, in.v_texcoord0) * 0.2242152392864227294921875) + (s_texBlur.sample(s_texBlurSampler, in.v_texcoord1.xy) * 0.20179371535778045654296875)) + (s_texBlur.sample(s_texBlurSampler, in.v_texcoord1.zw) * 0.20179371535778045654296875)) + (s_texBlur.sample(s_texBlurSampler, in.v_texcoord2.xy) * 0.12331838905811309814453125)) + (s_texBlur.sample(s_texBlurSampler, in.v_texcoord2.zw) * 0.12331838905811309814453125)) + (s_texBlur.sample(s_texBlurSampler, in.v_texcoord3.xy) * 0.040358744561672210693359375)) + (s_texBlur.sample(s_texBlurSampler, in.v_texcoord3.zw) * 0.040358744561672210693359375)) + (s_texBlur.sample(s_texBlurSampler, in.v_texcoord4.xy) * 0.02242152392864227294921875)) + (s_texBlur.sample(s_texBlurSampler, in.v_texcoord4.zw) * 0.02242152392864227294921875)).xyz * 0.60000002384185791015625);
    out.bgfx_FragData0 = float4(powr(abs(float4(_618, 1.0).xyz), float3(0.4545454680919647216796875)), 1.0);
    return out;
}

