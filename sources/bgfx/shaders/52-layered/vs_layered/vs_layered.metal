#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_modelViewProj;
    float4 u_eyeParams;
};

struct xlatMtlMain_out
{
    float4 _entryPointOutput_v_color0 [[user(locn0)]];
    float _entryPointOutput_v_eye [[user(locn1)]];
    float4 gl_Position [[position]];
    uint gl_Layer [[render_target_array_index]];
};

struct xlatMtlMain_in
{
    float4 a_color0 [[attribute(0)]];
    float3 a_position [[attribute(1)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], uint gl_InstanceIndex [[instance_id]])
{
    xlatMtlMain_out out = {};
    float _140 = float(gl_InstanceIndex);
    float4 _152 = _mtl_u.u_modelViewProj * float4(in.a_position, 1.0);
    _152.x = _152.x + ((((_140 * 2.0) - 1.0) * _mtl_u.u_eyeParams.x) * _152.w);
    out.gl_Position = _152;
    out._entryPointOutput_v_color0 = in.a_color0;
    out._entryPointOutput_v_eye = _140;
    out.gl_Layer = gl_InstanceIndex;
    return out;
}

