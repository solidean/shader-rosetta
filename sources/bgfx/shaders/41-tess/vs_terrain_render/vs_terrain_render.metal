#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_modelViewProj;
    float4 u_params[2];
};

struct u_CulledSubdBuffer
{
    uint _data[1];
};

struct u_VertexBuffer
{
    float4 _data[1];
};

struct xlatMtlMain_out
{
    float2 _entryPointOutput_v_texcoord0 [[user(locn0)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float2 a_texcoord0 [[attribute(0)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], const device u_CulledSubdBuffer& u_CulledSubdBuffer_1 [[buffer(3)]], const device u_VertexBuffer& u_VertexBuffer_1 [[buffer(4)]], const device u_CulledSubdBuffer& u_IndexBuffer [[buffer(5)]], texture2d<float> u_DmapSampler [[texture(0)]], sampler u_DmapSamplerSampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]])
{
    xlatMtlMain_out out = {};
    int _451 = int(gl_InstanceIndex) * 2;
    uint _455 = u_CulledSubdBuffer_1._data[_451] * 3u;
    int _479 = _451 + 1;
    float3x3 _758;
    _758 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    for (uint _757 = u_CulledSubdBuffer_1._data[_479]; _757 > 1u; )
    {
        float _602 = float(_757 & 1u);
        float _604 = 1.0 - _602;
        _758 = transpose(float3x3(float3(0.0, _604, _602), float3(0.5, _602, 0.0), float3(0.5, 0.0, _604))) * _758;
        _757 = _757 >> 1u;
        continue;
    }
    float3x4 _533 = float3x4(u_VertexBuffer_1._data[u_IndexBuffer._data[_455]], u_VertexBuffer_1._data[u_IndexBuffer._data[_455 + 1u]], u_VertexBuffer_1._data[u_IndexBuffer._data[_455 + 2u]]) * _758;
    float4 _660 = _533[0];
    float4 _692 = (_660 + ((_533[1] - _660) * in.a_texcoord0.x)) + ((_533[2] - _660) * in.a_texcoord0.y);
    _692.z = _692.z + (u_DmapSampler.sample(u_DmapSamplerSampler, ((_692.xy * 0.5) + float2(0.5)), level(0.0)).x * _mtl_u.u_params[0].x);
    out.gl_Position = _mtl_u.u_modelViewProj * _692;
    out._entryPointOutput_v_texcoord0 = (_692.xy * 0.5) + float2(0.5);
    return out;
}

