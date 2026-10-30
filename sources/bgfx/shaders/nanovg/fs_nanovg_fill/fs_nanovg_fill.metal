#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float3x3 u_scissorMat;
    float3x3 u_paintMat;
    float4 u_innerCol;
    float4 u_outerCol;
    float4 u_scissorExtScale;
    float4 u_extentRadius;
    float4 u_params;
};

constant float4 _671 = {};

constant uint bgfx_sampleMask [[function_constant(0)]];
constant bool bgfx_sampleMaskEnabled = is_function_constant_defined(bgfx_sampleMask);

struct xlatMtlMain_out
{
	uint bgfx_metal_sampleMask [[sample_mask, function_constant(bgfx_sampleMaskEnabled)]];
    float4 bgfx_FragData0 [[color(0)]];
};

struct xlatMtlMain_in
{
    float2 v_position [[user(locn0)]];
    float2 v_texcoord0 [[user(locn1)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_tex [[texture(0)]], sampler s_texSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _572 = float3(in.v_position, 1.0);
    float2 _587 = float2(0.5) - ((abs((_mtl_u.u_scissorMat * _572).xy) - _mtl_u.u_scissorExtScale.xy) * _mtl_u.u_scissorExtScale.zw);
    float _594 = fast::clamp(_587.x, 0.0, 1.0) * fast::clamp(_587.y, 0.0, 1.0);
    float _610 = fast::min(1.0, (1.0 - abs((in.v_texcoord0.x * 2.0) - 1.0)) * _mtl_u.u_params.y) * fast::min(1.0, in.v_texcoord0.y);
    float4 _667;
    if (_mtl_u.u_params.w == 0.0)
    {
        float2 _622 = abs((_mtl_u.u_paintMat * _572).xy) - (_mtl_u.u_extentRadius.xy - float2(_mtl_u.u_extentRadius.z));
        _667 = mix(_mtl_u.u_innerCol, _mtl_u.u_outerCol, float4(fast::clamp((((fast::min(fast::max(_622.x, _622.y), 0.0) + length(fast::max(_622, float2(0.0)))) - _mtl_u.u_extentRadius.z) + (_mtl_u.u_params.x * 0.5)) / _mtl_u.u_params.x, 0.0, 1.0))) * (_610 * _594);
    }
    else
    {
        float4 _668;
        if (_mtl_u.u_params.w == 1.0)
        {
            float4 _649 = s_tex.sample(s_texSampler, ((_mtl_u.u_paintMat * _572).xy / _mtl_u.u_extentRadius.xy));
            float4 _683;
            if (_mtl_u.u_params.z == 1.0)
            {
                float _488 = _649.w;
                _683 = float4(_649.xyz * _488, _488);
            }
            else
            {
                _683 = _649;
            }
            float4 _684;
            if (_mtl_u.u_params.z == 2.0)
            {
                _684 = _683.xxxx;
            }
            else
            {
                _684 = _683;
            }
            _668 = (_684 * _mtl_u.u_innerCol) * (_610 * _594);
        }
        else
        {
            float4 _669;
            if (_mtl_u.u_params.w == 2.0)
            {
                _669 = float4(1.0);
            }
            else
            {
                float4 _670;
                if (_mtl_u.u_params.w == 3.0)
                {
                    float4 _658 = s_tex.sample(s_texSampler, in.v_texcoord0);
                    float4 _681;
                    if (_mtl_u.u_params.z == 1.0)
                    {
                        float _534 = _658.w;
                        _681 = float4(_658.xyz * _534, _534);
                    }
                    else
                    {
                        _681 = _658;
                    }
                    float4 _682;
                    if (_mtl_u.u_params.z == 2.0)
                    {
                        _682 = _681.xxxx;
                    }
                    else
                    {
                        _682 = _681;
                    }
                    _670 = (_682 * _594) * _mtl_u.u_innerCol;
                }
                else
                {
                    _670 = _671;
                }
                _669 = _670;
            }
            _668 = _669;
        }
        _667 = _668;
    }
    out.bgfx_FragData0 = _667;
    return out;
}

