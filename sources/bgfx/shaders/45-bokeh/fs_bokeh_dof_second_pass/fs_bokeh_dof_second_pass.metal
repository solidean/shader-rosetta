#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_viewRect;
    float4 u_viewTexel;
    float4 u_params[13];
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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_color [[texture(0)]], sampler s_colorSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _630 = s_color.sample(s_colorSampler, in.v_texcoord0, level(0.0));
    float _618 = _630.w;
    float _490 = abs(_618);
    float _503 = fract(sin(dot((in.v_texcoord0 * _mtl_u.u_viewRect.zw) + (float2(314.0, 159.0) * _mtl_u.u_params[0].z), float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875) * 6.283185482025146484375;
    float _708;
    float3 _709;
    float _710;
    _710 = 0.0;
    _709 = _630.xyz;
    _708 = 1.0;
    float3 _574;
    float _577;
    float _579;
    float _582;
    float _588;
    for (float _707 = _mtl_u.u_params[3].w, _711 = _503; _707 < _mtl_u.u_params[3].x; _711 = _582, _710 = _577, _709 = _574, _708 = _579, _707 = _588)
    {
        float _712;
        do
        {
            if (_mtl_u.u_params[2].y <= 1.0)
            {
                _712 = 1.0;
                break;
            }
            _712 = (abs(fract((_711 * (_mtl_u.u_params[2].y * 0.159154951572418212890625)) + _mtl_u.u_params[0].w) - 0.5) * _mtl_u.u_params[2].w) + _mtl_u.u_params[2].z;
            break;
        } while(false);
        float4 _692 = s_color.sample(s_colorSampler, (in.v_texcoord0 + ((float2(cos(_711), sin(_711)) * _mtl_u.u_viewTexel.xy) * (_707 * _712))), level(0.0));
        float _680 = _692.w;
        float _549 = abs(_680);
        float _714;
        if (_680 > _618)
        {
            _714 = fast::clamp(_549, 0.0, _490 * 2.0);
        }
        else
        {
            _714 = _549;
        }
        _574 = _709 + mix(_709 / float3(_708), _692.xyz, float3(smoothstep(_707 - 0.5, _707 + 0.5, _714)));
        _577 = _710 + _714;
        _579 = _708 + 1.0;
        _582 = _711 + 2.3999631404876708984375;
        _588 = _707 + (_mtl_u.u_params[3].w / _707);
    }
    out.bgfx_FragData0 = float4(_709 * (1.0 / _708), _710 / (_708 - 1.0));
    return out;
}

