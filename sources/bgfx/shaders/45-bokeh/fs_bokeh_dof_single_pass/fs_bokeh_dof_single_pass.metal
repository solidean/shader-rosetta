#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_viewRect;
    float4 u_viewTexel;
    float4 u_params[13];
};

constant float _926 = {};

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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_color [[texture(0)]], texture2d<float> s_depth [[texture(1)]], sampler s_colorSampler [[sampler(0)]], sampler s_depthSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float _758 = 1.0 / _mtl_u.u_params[3].y;
    float _754 = fast::clamp((_758 - (1.0 / s_depth.sample(s_depthSampler, in.v_texcoord0, level(0.0)).x)) * _mtl_u.u_params[3].z, -1.0, 1.0) * _mtl_u.u_params[3].x;
    float _579 = abs(_754);
    float _592 = fract(sin(dot((in.v_texcoord0 * _mtl_u.u_viewRect.zw) + (float2(314.0, 159.0) * _mtl_u.u_params[0].z), float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875) * 6.283185482025146484375;
    float _906;
    float3 _907;
    _907 = s_color.sample(s_colorSampler, in.v_texcoord0, level(0.0)).xyz;
    _906 = 1.0;
    float3 _663;
    float _668;
    float _671;
    float _677;
    for (float _905 = _mtl_u.u_params[3].w, _909 = _592; _905 < _mtl_u.u_params[3].x; _909 = _671, _907 = _663, _906 = _668, _905 = _677)
    {
        float _910;
        do
        {
            if (_mtl_u.u_params[2].y <= 1.0)
            {
                _910 = 1.0;
                break;
            }
            _910 = (abs(fract((_909 * (_mtl_u.u_params[2].y * 0.159154951572418212890625)) + _mtl_u.u_params[0].w) - 0.5) * _mtl_u.u_params[2].w) + _mtl_u.u_params[2].z;
            break;
        } while(false);
        float2 _628 = in.v_texcoord0 + ((float2(cos(_909), sin(_909)) * _mtl_u.u_viewTexel.xy) * (_905 * _910));
        float _861 = fast::clamp((_758 - (1.0 / s_depth.sample(s_depthSampler, _628, level(0.0)).x)) * _mtl_u.u_params[3].z, -1.0, 1.0) * _mtl_u.u_params[3].x;
        float _638 = abs(_861);
        float _912;
        if (_861 > _754)
        {
            _912 = fast::clamp(_638, 0.0, _579 * 2.0);
        }
        else
        {
            _912 = _638;
        }
        _663 = _907 + mix(_907 / float3(_906), s_color.sample(s_colorSampler, _628, level(0.0)).xyz, float3(smoothstep(_905 - 0.5, _905 + 0.5, _912)));
        _668 = _906 + 1.0;
        _671 = _909 + 2.3999631404876708984375;
        _677 = _905 + (_mtl_u.u_params[3].w / _905);
    }
    out.bgfx_FragData0 = float4(powr(abs(float4(_907 * (1.0 / _906), _926).xyz), float3(0.4545454680919647216796875)), 1.0);
    return out;
}

