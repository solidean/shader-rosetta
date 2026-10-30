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
    float3 v_normal [[user(locn0)]];
    float3 v_pos [[user(locn1)]];
    float3 v_view [[user(locn2)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texturecube<float> s_texCube [[texture(0)]], sampler s_texCubeSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _376 = fast::normalize(in.v_normal);
    float3 _378 = fast::normalize(in.v_view);
    float _469 = dot(_376, float3(0.0, 0.0, -1.0));
    float _419 = 2.099999904632568359375 + (((sin((in.v_pos.x * 3.0) + _mtl_u.u_tonemap.w) * 0.300000011920928955078125) + (cos((in.v_pos.y * 3.0) + _mtl_u.u_tonemap.w) * 0.4000000059604644775390625)) + (cos((in.v_pos.z * 3.0) + _mtl_u.u_tonemap.w) * 0.20000000298023223876953125));
    float3 _456 = ((float3((sin(_419 * 25.1327419281005859375) * 0.4000000059604644775390625) + 0.60000002384185791015625, (sin(_419 * 12.56637096405029296875) * 0.4000000059604644775390625) + 0.60000002384185791015625, (sin(_419 * 6.283185482025146484375) * 0.4000000059604644775390625) + 0.60000002384185791015625) * s_texCube.sample(s_texCubeSampler, reflect(_378, -_376)).xyz) * fast::max(0.0, _469)) + float3(fast::max(0.20000000298023223876953125 + (0.800000011920928955078125 * powr(1.0 - _469, 5.0)), 0.0) * powr(step(0.0, _469) * fast::max(0.0, dot(float3(0.0, 0.0, -1.0) - (_376 * (2.0 * _469)), _378)), 128.0));
    float _536 = ceil(log2(fast::max(fast::max(_456.x, _456.y), _456.z)));
    float3 _541 = _456 / float3(exp2(_536));
    out.bgfx_FragData0 = float4(_541, (_536 + 128.0) * 0.0039215688593685626983642578125);
    return out;
}

