#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

constant float3 _854 = {};

constant uint bgfx_sampleMask [[function_constant(0)]];
constant bool bgfx_sampleMaskEnabled = is_function_constant_defined(bgfx_sampleMask);

struct xlatMtlMain_out
{
	uint bgfx_metal_sampleMask [[sample_mask, function_constant(bgfx_sampleMaskEnabled)]];
    float4 bgfx_FragData0 [[color(0)]];
    float4 bgfx_FragData1 [[color(1)]];
};

struct xlatMtlMain_in
{
    float3 v_normal [[user(locn0)]];
    float2 v_texcoord0 [[user(locn1)]];
    float4 v_texcoord1 [[user(locn2)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], texture2d<float> s_albedo [[texture(0)]], texture2d<float> s_normal [[texture(1)]], sampler s_albedoSampler [[sampler(0)]], sampler s_normalSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _603 = powr(abs(s_albedo.sample(s_albedoSampler, in.v_texcoord0).xyz), float3(2.2000000476837158203125));
    float3 _519 = fast::normalize(in.v_normal);
    float4 _616 = s_normal.sample(s_normalSampler, in.v_texcoord0);
    float3 _823;
    _823.x = _616.x;
    _823.y = _616.y;
    float2 _532 = (_823.xy * 2.0) - float2(1.0);
    float _534 = _532.x;
    float3 _827;
    _827.x = _534;
    float _536 = _532.y;
    _827.y = _536;
    float _543 = sqrt(1.0 - dot(_827.xy, _827.xy));
    float3 _853 = float3(_534, _536, _543);
    _853.x = _536;
    _853.y = _534;
    float2 _637 = dfdx(in.v_texcoord0);
    float2 _640 = dfdy(-in.v_texcoord0);
    float3 _643 = cross(dfdy(-in.v_texcoord1.xyz), _519);
    float3 _646 = cross(_519, dfdx(in.v_texcoord1.xyz));
    float3 _655 = (_643 * _637.x) + (_646 * _640.x);
    float3 _664 = (_643 * _637.y) + (_646 * _640.y);
    float _672 = rsqrt(fast::max(dot(_655, _655), dot(_664, _664)));
    float3 _560 = fast::normalize(_853 * transpose(float3x3(_655 * _672, _664 * _672, _519)));
    float _732 = _560.z;
    float2 _736 = _560.xy * (1.0 / ((abs(_560.x) + abs(_560.y)) + abs(_732)));
    float2 _771 = floor((fast::clamp((_732 <= 0.0) ? ((float2(1.0) - abs(_736.yx)) * float2((_736.x >= 0.0) ? 1.0 : (-1.0), (_736.y >= 0.0) ? 1.0 : (-1.0))) : _736, float2(-1.0), float2(1.0)) * 2047.0) + float2(2047.5));
    float _773 = _771.y;
    float _775 = floor(_773 * 0.00390625);
    float _778 = _771.x * 0.0625;
    out.bgfx_FragData0 = float4(powr(abs(_603), float3(0.4545454680919647216796875)), 1.0);
    out.bgfx_FragData1 = float4(float3(floor(_778), (fract(_778) * 256.0) + _775, _773 - (_775 * 256.0)) * float3(0.0039215688593685626983642578125), ((_543 * mix(0.89999997615814208984375, 1.0, _603.y)) * 0.60000002384185791015625) + 0.20000000298023223876953125);
    return out;
}

