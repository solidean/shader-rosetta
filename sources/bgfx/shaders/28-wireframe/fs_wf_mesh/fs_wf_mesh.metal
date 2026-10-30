#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[3];
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
    float3 v_bc [[user(locn0)]];
    float3 v_normal [[user(locn1)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _429 = fast::normalize(in.v_normal);
    float _508 = _429.x;
    float _512 = _429.y;
    float _516 = _429.z;
    float3 _642 = (((((((float3(0.272999227046966552734375, 0.2754701077938079833984375, 0.251408040523529052734375) + (((float3(-0.38416349887847900390625, -0.4234922826290130615234375, -0.4255327284336090087890625) * ((-0.48860251903533935546875) * _508)) * 2.0) * float3(0.4000000059604644775390625))) + (((float3(0.0559062957763671875, 0.05662743747234344482421875, 0.06996993720531463623046875) * (0.48860251903533935546875 * _512)) * 2.0) * float3(0.4000000059604644775390625))) + (((float3(0.120985157787799835205078125, 0.11929799616336822509765625, 0.11711196601390838623046875) * ((-0.48860251903533935546875) * _516)) * 2.0) * float3(0.4000000059604644775390625))) + (((float3(-0.17671163380146026611328125, -0.17033140361309051513671875, -0.1513450145721435546875) * ((1.09254848957061767578125 * _508) * _516)) * 1.0) * float3(0.4000000059604644775390625))) + ((float3(-0.12468211352825164794921875, -0.119340784847736358642578125, -0.096300356090068817138671875) * (((-1.09254848957061767578125) * _508) * _512)) * 0.5)) + ((float3(0.001852378598414361476898193359375, -0.0325927846133708953857421875, -0.088204495608806610107421875) * (0.3153915703296661376953125 * (((3.0 * _512) * _512) - 1.0))) * 0.5)) + ((float3(0.2963654696941375732421875, 0.2812686860561370849609375, 0.24332822859287261962890625) * (((-1.09254848957061767578125) * _516) * _512)) * 0.5)) + ((float3(-0.07982666790485382080078125, -0.109340958297252655029296875, -0.157208859920501708984375) * (0.546274244785308837890625 * ((_516 * _516) - (_508 * _508)))) * 0.5);
    float3 _682;
    if (0.0 != _mtl_u.u_params[2].x)
    {
        float3 _456 = smoothstep(float3(0.0), (abs(dfdx(in.v_bc)) + abs(dfdy(-in.v_bc))) * _mtl_u.u_params[2].y, in.v_bc);
        _682 = mix(mix(_642, _mtl_u.u_params[1].xyz, float3(_mtl_u.u_params[1].w)), _642, float3(fast::min(fast::min(_456.x, _456.y), _456.z)));
    }
    else
    {
        _682 = _642;
    }
    out.bgfx_FragData0 = float4(_682, 1.0);
    return out;
}

