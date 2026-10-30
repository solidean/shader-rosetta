#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

fragment void xlatMtlMain(texture2d<float, access::write> i_light [[texture(2)]], float4 gl_FragCoord [[position]])
{
    i_light.write(float4(0.0), uint2(int2(gl_FragCoord.xy)));
}

