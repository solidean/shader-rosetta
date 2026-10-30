#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_viewRect;
    float4x4 u_modelViewProj;
    float4 u_params;
};

struct xlatMtlMain_out
{
    float4 _entryPointOutput_v_banding [[user(locn0)]];
    float4 _entryPointOutput_v_glyph [[user(locn1)]];
    float2 _entryPointOutput_v_texcoord0 [[user(locn2)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float4 a_position [[attribute(0)]];
    float4 a_texcoord0 [[attribute(1)]];
    float4 a_texcoord1 [[attribute(2)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float4 _327 = float4(_mtl_u.u_params.w, 0.0, 0.0, _mtl_u.u_params.w);
    float4 _383 = _mtl_u.u_modelViewProj * float4(in.a_position.xy, 0.0, 1.0);
    float4 _390 = _mtl_u.u_modelViewProj * float4(fast::normalize(in.a_position.zw), 0.0, 0.0);
    float _392 = _383.w;
    float _394 = _390.w;
    float _406 = ((_392 * _390.x) - (_394 * _383.x)) * _mtl_u.u_viewRect.z;
    float _418 = ((_392 * _390.y) - (_394 * _383.y)) * _mtl_u.u_viewRect.w;
    float _424 = _392 * _394;
    float _431 = (_406 * _406) + (_418 * _418);
    float2 _445 = in.a_position.zw * (((_392 * _392) * (_424 + sqrt(_431))) / (_431 - (_424 * _424)));
    uint2 _490 = as_type<uint2>(in.a_texcoord0.zw);
    uint _470 = _490.x;
    uint _478 = _490.y;
    out.gl_Position = _mtl_u.u_modelViewProj * float4(in.a_position.xy + _445, 0.0, 1.0);
    out._entryPointOutput_v_banding = in.a_texcoord1;
    out._entryPointOutput_v_glyph = float4(float(_470 & 65535u), float(_470 >> 16u), float(_478 & 65535u), float(_478 >> 16u));
    out._entryPointOutput_v_texcoord0 = float2(in.a_texcoord0.x + dot(_445, _327.xy), in.a_texcoord0.y + dot(_445, _327.zw));
    return out;
}

