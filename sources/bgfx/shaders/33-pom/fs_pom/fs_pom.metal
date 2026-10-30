#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_pomParam;
};

constant float3 _737 = {};

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
    float3 v_ts_frag_pos [[user(locn1)]];
    float3 v_ts_light_pos [[user(locn2)]];
    float3 v_ts_view_pos [[user(locn3)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_texColor [[texture(0)]], texture2d<float> s_texNormal [[texture(1)]], texture2d<float> s_texDepth [[texture(2)]], sampler s_texColorSampler [[sampler(0)]], sampler s_texNormalSampler [[sampler(1)]], sampler s_texDepthSampler [[sampler(2)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _421 = fast::normalize(in.v_ts_view_pos - in.v_ts_frag_pos);
    float2 _713;
    do
    {
        float _514 = _mtl_u.u_pomParam.z * 0.001000000047497451305389404296875;
        if (_mtl_u.u_pomParam.x == 2.0)
        {
            _713 = in.v_texcoord0 - ((_421.xy * (s_texDepth.sample(s_texDepthSampler, in.v_texcoord0).x * _514)) / float2(_421.z));
            break;
        }
        else
        {
            float _539 = 1.0 / _mtl_u.u_pomParam.w;
            float2 _550 = (_421.xy * _514) / float2(_421.z * _mtl_u.u_pomParam.w);
            float4 _631 = s_texDepth.sample(s_texDepthSampler, in.v_texcoord0);
            float _555 = _631.x;
            float2 _708;
            _708 = in.v_texcoord0;
            float _563;
            float2 _566;
            float _570;
            float2 _709;
            float _710;
            float _712;
            int _706 = 0;
            float _707 = 0.0;
            float _711 = _555;
            for (;;)
            {
                if (_706 < 32)
                {
                    _563 = _707 + _539;
                    _566 = _708 - _550;
                    _570 = s_texDepth.sample(s_texDepthSampler, _566).x;
                    if (_570 < _563)
                    {
                        _712 = _563;
                        _710 = _570;
                        _709 = _566;
                        break;
                    }
                    _708 = _566;
                    _707 = _563;
                    _706++;
                    _711 = _570;
                    continue;
                }
                else
                {
                    _712 = _707;
                    _710 = _711;
                    _709 = _708;
                    break;
                }
            }
            if (_mtl_u.u_pomParam.x == 3.0)
            {
                _713 = _709;
                break;
            }
            else
            {
                float2 _588 = _709 + _550;
                float _591 = _710 - _712;
                _713 = mix(_709, _588, float2(_591 / (_591 - ((s_texDepth.sample(s_texDepthSampler, _588).x - _712) + _539))));
                break;
            }
            break; // unreachable workaround
        }
        break; // unreachable workaround
    } while(false);
    float2 _429 = (_mtl_u.u_pomParam.x < 2.0) ? in.v_texcoord0 : _713;
    float3 _714;
    if (_mtl_u.u_pomParam.y == 0.0)
    {
        _714 = float3(1.0);
    }
    else
    {
        _714 = s_texColor.sample(s_texColorSampler, _429).xyz;
    }
    float3 _734;
    if (_mtl_u.u_pomParam.x == 0.0)
    {
        _734 = float3(0.0, 0.0, 1.0);
    }
    else
    {
        float2 _452 = (s_texNormal.sample(s_texNormalSampler, _429).xy * 2.0) - float2(1.0);
        float _454 = _452.x;
        float3 _724;
        _724.x = _454;
        _724.y = _452.y;
        _734 = float3(_454, _452.y, sqrt(1.0 - dot(_724.xy, _724.xy)));
    }
    out.bgfx_FragData0 = float4((_714 * fast::max(dot(fast::normalize(in.v_ts_light_pos - in.v_ts_frag_pos), _734), 0.0)) + (_714 * 0.300000011920928955078125), 1.0);
    return out;
}

