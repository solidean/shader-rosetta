#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[19];
    float4 u_rect;
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_viewspaceDepthSource0 [[texture(0)]], texture2d<float> s_viewspaceDepthSource1 [[texture(1)]], texture2d<float> s_viewspaceDepthSource2 [[texture(2)]], texture2d<float> s_viewspaceDepthSource3 [[texture(3)]], texture2d<float, access::write> s_target0 [[texture(4)]], texture2d<float, access::write> s_target1 [[texture(5)]], texture2d<float, access::write> s_target2 [[texture(6)]], texture2d<float, access::write> s_target3 [[texture(7)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    if (all(float2(uint2(int3(gl_GlobalInvocationID).xy)) < float2(uint2(_mtl_u.u_rect.zw))))
    {
        int2 _525 = int3(gl_GlobalInvocationID).xy * int2(2);
        float4 _725 = s_viewspaceDepthSource0.read(uint2(_525), 0);
        float _726 = _725.x;
        int2 _533 = _525 + int2(1, 0);
        float4 _732 = s_viewspaceDepthSource0.read(uint2(_533), 0);
        float _733 = _732.x;
        int2 _539 = _525 + int2(0, 1);
        float4 _739 = s_viewspaceDepthSource0.read(uint2(_539), 0);
        float _740 = _739.x;
        int2 _545 = _525 + int2(1);
        float4 _746 = s_viewspaceDepthSource0.read(uint2(_545), 0);
        float _747 = _746.x;
        float4 _1097 = float4(_726, _733, _740, _747);
        float4 _753 = s_viewspaceDepthSource1.read(uint2(_525), 0);
        float _754 = _753.x;
        float4 _760 = s_viewspaceDepthSource1.read(uint2(_533), 0);
        float _761 = _760.x;
        float4 _767 = s_viewspaceDepthSource1.read(uint2(_539), 0);
        float _768 = _767.x;
        float4 _774 = s_viewspaceDepthSource1.read(uint2(_545), 0);
        float _775 = _774.x;
        float4 _1098 = float4(_754, _761, _768, _775);
        float4 _781 = s_viewspaceDepthSource2.read(uint2(_525), 0);
        float _782 = _781.x;
        float4 _788 = s_viewspaceDepthSource2.read(uint2(_533), 0);
        float _789 = _788.x;
        float4 _795 = s_viewspaceDepthSource2.read(uint2(_539), 0);
        float _796 = _795.x;
        float4 _802 = s_viewspaceDepthSource2.read(uint2(_545), 0);
        float _803 = _802.x;
        float4 _1099 = float4(_782, _789, _796, _803);
        float4 _809 = s_viewspaceDepthSource3.read(uint2(_525), 0);
        float _810 = _809.x;
        float4 _816 = s_viewspaceDepthSource3.read(uint2(_533), 0);
        float _817 = _816.x;
        float4 _823 = s_viewspaceDepthSource3.read(uint2(_539), 0);
        float _824 = _823.x;
        float4 _830 = s_viewspaceDepthSource3.read(uint2(_545), 0);
        float _831 = _830.x;
        float4 _1100 = float4(_810, _817, _824, _831);
        float _647 = fast::min(fast::min(_726, _733), fast::min(_740, _747));
        float _845 = _mtl_u.u_params[5].x * ((fast::clamp(abs(_647) * _mtl_u.u_params[6].w, 0.0, 1.0) * 0.800000011920928955078125) + 0.20000000298023223876953125);
        float4 _657 = _1097 - float4(_647);
        float4 _667 = fast::clamp(((_657 * _657) * ((-1.0) / (_845 * _845))) + float4(1.0), float4(0.0), float4(1.0));
        float _903 = fast::min(fast::min(_754, _761), fast::min(_768, _775));
        float _913 = _mtl_u.u_params[5].x * ((fast::clamp(abs(_903) * _mtl_u.u_params[6].w, 0.0, 1.0) * 0.800000011920928955078125) + 0.20000000298023223876953125);
        float4 _917 = _1098 - float4(_903);
        float4 _924 = fast::clamp(((_917 * _917) * ((-1.0) / (_913 * _913))) + float4(1.0), float4(0.0), float4(1.0));
        float _948 = fast::min(fast::min(_782, _789), fast::min(_796, _803));
        float _958 = _mtl_u.u_params[5].x * ((fast::clamp(abs(_948) * _mtl_u.u_params[6].w, 0.0, 1.0) * 0.800000011920928955078125) + 0.20000000298023223876953125);
        float4 _962 = _1099 - float4(_948);
        float4 _969 = fast::clamp(((_962 * _962) * ((-1.0) / (_958 * _958))) + float4(1.0), float4(0.0), float4(1.0));
        float _993 = fast::min(fast::min(_810, _817), fast::min(_824, _831));
        float _1003 = _mtl_u.u_params[5].x * ((fast::clamp(abs(_993) * _mtl_u.u_params[6].w, 0.0, 1.0) * 0.800000011920928955078125) + 0.20000000298023223876953125);
        float4 _1007 = _1100 - float4(_993);
        float4 _1014 = fast::clamp(((_1007 * _1007) * ((-1.0) / (_1003 * _1003))) + float4(1.0), float4(0.0), float4(1.0));
        s_target0.write(float4(dot(_667, _1097) / dot(_667, float4(1.0))), uint2(int3(gl_GlobalInvocationID).xy));
        s_target1.write(float4(dot(_924, _1098) / dot(_924, float4(1.0))), uint2(int3(gl_GlobalInvocationID).xy));
        s_target2.write(float4(dot(_969, _1099) / dot(_969, float4(1.0))), uint2(int3(gl_GlobalInvocationID).xy));
        s_target3.write(float4(dot(_1014, _1100) / dot(_1014, float4(1.0))), uint2(int3(gl_GlobalInvocationID).xy));
    }
}

