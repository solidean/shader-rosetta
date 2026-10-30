#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_viewRect;
};

constant uint bgfx_sampleMask [[function_constant(0)]];
constant bool bgfx_sampleMaskEnabled = is_function_constant_defined(bgfx_sampleMask);

struct xlatMtlMain_out
{
	uint bgfx_metal_sampleMask [[sample_mask, function_constant(bgfx_sampleMaskEnabled)]];
    float4 bgfx_FragData0 [[color(0)]];
};

fragment xlatMtlMain_out xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_quadPostColor [[texture(0)]], sampler s_quadPostColorSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float2 _321 = floor(gl_FragCoord.xy) - float2(32.0, 48.0);
    float _323 = _321.x;
    float _326 = _321.y;
    float3 _446;
    if ((((_323 >= 0.0) && (_326 >= 0.0)) && (_323 < 512.0)) && (_326 < 64.0))
    {
        float _340 = _323 * 0.015625;
        uint _341 = uint(_340);
        float2 _350 = floor(float2((_323 * 0.125) - (8.0 * floor(_340)), _326 * 0.125));
        uint _445;
        do
        {
            if (0u == _341)
            {
                _445 = 85u;
                break;
            }
            if (1u == _341)
            {
                _445 = 115u;
                break;
            }
            if (2u == _341)
            {
                _445 = 101u;
                break;
            }
            if (3u == _341)
            {
                _445 = 114u;
                break;
            }
            if (4u == _341)
            {
                _445 = 70u;
                break;
            }
            if (5u == _341)
            {
                _445 = 111u;
                break;
            }
            if (6u == _341)
            {
                _445 = 110u;
                break;
            }
            _445 = 116u;
            break;
        } while(false);
        _446 = s_quadPostColor.sample(s_quadPostColorSampler, ((float2((float(_445 - 32u) * 8.0) + _350.x, _350.y) + float2(0.5)) / _mtl_u.u_viewRect.zw)).xyz;
    }
    else
    {
        _446 = float3(0.0199999995529651641845703125, 0.0199999995529651641845703125, 0.02999999932944774627685546875);
    }
    out.bgfx_FragData0 = float4(_446, 1.0);
    return out;
}

