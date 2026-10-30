#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_viewTexel;
    float4 u_params[12];
};

constant float3 _808 = {};

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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_depth [[texture(0)]], sampler s_depthSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _687 = s_depth.sample(s_depthSampler, in.v_texcoord0);
    float _487 = _687.x;
    float2 _701 = ((_mtl_u.u_params[2].xy * in.v_texcoord0) + _mtl_u.u_params[2].zw) * _487;
    float _703 = _701.x;
    float3 _807 = float3(_703, _701.y, _487);
    float _766;
    if (0.0 < _mtl_u.u_params[1].w)
    {
        _766 = abs((((_mtl_u.u_params[2].x * ((_mtl_u.u_params[0].y * _mtl_u.u_viewTexel.x) + in.v_texcoord0.x)) + _mtl_u.u_params[2].z) * _487) - _703);
    }
    else
    {
        _766 = _mtl_u.u_params[0].y;
    }
    float3 _531 = fast::normalize(_mtl_u.u_params[3].xyz - _807) * (_766 / _mtl_u.u_params[0].z);
    float4x4 _743 = transpose(float4x4(_mtl_u.u_params[8], _mtl_u.u_params[9], _mtl_u.u_params[10], _mtl_u.u_params[11]));
    float _769;
    float _770;
    float _771;
    float3 _804;
    _804 = _807 + (_531 * ((0.0 < _mtl_u.u_params[0].w) ? (0.5 + fract(sin(dot(gl_FragCoord.xy + (float2(314.0, 159.0) * _mtl_u.u_params[0].x), float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875)) : 1.0));
    _771 = 0.0;
    _770 = _mtl_u.u_params[0].z;
    _769 = 0.0;
    float _778;
    float _779;
    float _780;
    for (int _768 = 0; _768 < int(_mtl_u.u_params[0].z); _804 += _531, _771 = _780, _770 = _779, _769 = _778, _768++)
    {
        float4 _576 = float4(_804, 1.0) * _743;
        float2 _583 = _576.xy * (1.0 / _576.w);
        float3 _796;
        _796.x = _583.x;
        _796.y = _583.y;
        float2 _592 = (_796.xy * 0.5) + float2(0.5);
        _592.y = 1.0 - _592.y;
        float _604 = _804.z - s_depth.sample(s_depthSampler, _592, level(0.0)).x;
        if ((9.9999997473787516355514526367188e-05 < _604) && (_604 < _766))
        {
            _780 = _771 + fast::clamp(_766 - _604, 0.0, 1.0);
            _779 = fast::min(_770, float(_768));
            _778 = _769 + 1.0;
        }
        else
        {
            _780 = _771;
            _779 = _770;
            _778 = _769;
        }
    }
    float _772;
    if (1.5 < _mtl_u.u_params[1].z)
    {
        float _645 = 1.0 - fast::clamp(_771 * (1.0 - (_770 / _mtl_u.u_params[0].z)), 0.0, 1.0);
        _772 = _645 * _645;
    }
    else
    {
        float _773;
        if (0.5 < _mtl_u.u_params[1].z)
        {
            float _663 = 1.0 - fast::clamp(_769 * (1.0 - (_770 / _mtl_u.u_params[0].z)), 0.0, 1.0);
            _773 = _663 * _663;
        }
        else
        {
            _773 = (0.0 < _769) ? 0.0 : 1.0;
        }
        _772 = _773;
    }
    out.bgfx_FragData0 = float4(_772);
    return out;
}

