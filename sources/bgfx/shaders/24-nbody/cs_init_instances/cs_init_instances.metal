#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[3];
};

struct prevPositionBuffer
{
    float4 _data[1];
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], device prevPositionBuffer& prevPositionBuffer_1 [[buffer(1)]], device prevPositionBuffer& currPositionBuffer [[buffer(2)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    uint _686 = as_type<uint>(_mtl_u.u_params[2].y);
    float3 _1779;
    if (_686 == 0u)
    {
        _1779 = float3(0.0);
    }
    else
    {
        float3 _1780;
        if (_686 == 1u)
        {
            uint _532 = as_type<uint>(_mtl_u.u_params[1].z) * 7u;
            uint _769 = uint(int(gl_GlobalInvocationID.x)) * 3432918353u;
            uint _820 = (_769 << 15u) | (_769 >> 17u);
            uint _774 = _820 * 461845907u;
            uint _777 = _532 ^ _774;
            uint _785 = _820 * 2934753923u;
            uint _790 = ((_785 << 15u) | (_785 >> 17u)) * 461845907u;
            uint _793 = ((((_777 << 13u) | (_777 >> 19u)) * 5u) + 3864292196u) ^ _790;
            uint _799 = (_793 ^ (_793 >> 16u)) * 2246822507u;
            uint _805 = (_799 ^ (_799 >> 13u)) * 3266489909u;
            uint _865 = (_532 + 1u) ^ _774;
            uint _881 = ((((_865 << 13u) | (_865 >> 19u)) * 5u) + 3864292196u) ^ _790;
            uint _887 = (_881 ^ (_881 >> 16u)) * 2246822507u;
            uint _893 = (_887 ^ (_887 >> 13u)) * 3266489909u;
            float2 _726 = as_type<float2>((uint2(_805 ^ (_805 >> 16u), _893 ^ (_893 >> 16u)) >> uint2(9u)) | uint2(1065353216u)) - float2(1.0);
            float _730 = _726.x * 6.28318023681640625;
            float _736 = acos((2.0 * _726.y) - 1.0) - 1.5707950592041015625;
            float _740 = cos(_736);
            _1780 = float3(cos(_730) * _740, sin(_736), sin(_730) * _740) * 20.0;
        }
        else
        {
            float3 _1781;
            if (_686 == 2u)
            {
                uint _547 = as_type<uint>(_mtl_u.u_params[1].z) * 7u;
                uint _957 = uint(int(gl_GlobalInvocationID.x)) * 3432918353u;
                uint _1008 = (_957 << 15u) | (_957 >> 17u);
                uint _962 = _1008 * 461845907u;
                uint _965 = _547 ^ _962;
                uint _973 = _1008 * 2934753923u;
                uint _978 = ((_973 << 15u) | (_973 >> 17u)) * 461845907u;
                uint _981 = ((((_965 << 13u) | (_965 >> 19u)) * 5u) + 3864292196u) ^ _978;
                uint _987 = (_981 ^ (_981 >> 16u)) * 2246822507u;
                uint _993 = (_987 ^ (_987 >> 13u)) * 3266489909u;
                uint _1057 = (_547 + 1u) ^ _962;
                uint _1073 = ((((_1057 << 13u) | (_1057 >> 19u)) * 5u) + 3864292196u) ^ _978;
                uint _1079 = (_1073 ^ (_1073 >> 16u)) * 2246822507u;
                uint _1085 = (_1079 ^ (_1079 >> 13u)) * 3266489909u;
                uint _1149 = (_547 + 2u) ^ _962;
                uint _1165 = ((((_1149 << 13u) | (_1149 >> 19u)) * 5u) + 3864292196u) ^ _978;
                uint _1171 = (_1165 ^ (_1165 >> 16u)) * 2246822507u;
                uint _1177 = (_1171 ^ (_1171 >> 13u)) * 3266489909u;
                _1781 = (as_type<float3>((uint3(_993 ^ (_993 >> 16u), _1085 ^ (_1085 >> 16u), _1177 ^ (_1177 >> 16u)) >> uint3(9u)) | uint3(1073741824u)) - float3(3.0)) * 20.0;
            }
            else
            {
                uint _584 = as_type<uint>(_mtl_u.u_params[1].z) * 7u;
                uint _1237 = uint(int(gl_GlobalInvocationID.x)) * 3432918353u;
                uint _1288 = (_1237 << 15u) | (_1237 >> 17u);
                uint _1242 = _1288 * 461845907u;
                uint _1245 = _584 ^ _1242;
                uint _1253 = _1288 * 2934753923u;
                uint _1258 = ((_1253 << 15u) | (_1253 >> 17u)) * 461845907u;
                uint _1261 = ((((_1245 << 13u) | (_1245 >> 19u)) * 5u) + 3864292196u) ^ _1258;
                uint _1267 = (_1261 ^ (_1261 >> 16u)) * 2246822507u;
                uint _1273 = (_1267 ^ (_1267 >> 13u)) * 3266489909u;
                uint _1337 = (_584 + 1u) ^ _1242;
                uint _1353 = ((((_1337 << 13u) | (_1337 >> 19u)) * 5u) + 3864292196u) ^ _1258;
                uint _1359 = (_1353 ^ (_1353 >> 16u)) * 2246822507u;
                uint _1365 = (_1359 ^ (_1359 >> 13u)) * 3266489909u;
                uint _1429 = (_584 + 2u) ^ _1242;
                uint _1445 = ((((_1429 << 13u) | (_1429 >> 19u)) * 5u) + 3864292196u) ^ _1258;
                uint _1451 = (_1445 ^ (_1445 >> 16u)) * 2246822507u;
                uint _1457 = (_1451 ^ (_1451 >> 13u)) * 3266489909u;
                float3 _613 = (as_type<float3>((uint3(_1273 ^ (_1273 >> 16u), _1365 ^ (_1365 >> 16u), _1457 ^ (_1457 >> 16u)) >> uint3(9u)) | uint3(1065353216u)) - float3(1.0)) * 6.28318023681640625;
                float _615 = _613.x;
                float _619 = _613.y;
                float _1783 = 20.0 + (3.0 * cos(_619));
                _1781 = float3(cos(_615) * _1783, 3.0 * sin(_619), sin(_615) * _1783);
            }
            _1780 = _1781;
        }
        _1779 = _1780;
    }
    uint _658 = as_type<uint>(_mtl_u.u_params[1].z) * 7u;
    uint _1571 = uint(int(gl_GlobalInvocationID.x)) * 3432918353u;
    uint _1622 = (_1571 << 15u) | (_1571 >> 17u);
    uint _1576 = _1622 * 461845907u;
    uint _1579 = (_658 + 3u) ^ _1576;
    uint _1587 = _1622 * 2934753923u;
    uint _1592 = ((_1587 << 15u) | (_1587 >> 17u)) * 461845907u;
    uint _1595 = ((((_1579 << 13u) | (_1579 >> 19u)) * 5u) + 3864292196u) ^ _1592;
    uint _1601 = (_1595 ^ (_1595 >> 16u)) * 2246822507u;
    uint _1607 = (_1601 ^ (_1601 >> 13u)) * 3266489909u;
    uint _1667 = (_658 + 4u) ^ _1576;
    uint _1683 = ((((_1667 << 13u) | (_1667 >> 19u)) * 5u) + 3864292196u) ^ _1592;
    uint _1689 = (_1683 ^ (_1683 >> 16u)) * 2246822507u;
    uint _1695 = (_1689 ^ (_1689 >> 13u)) * 3266489909u;
    float2 _1528 = as_type<float2>((uint2(_1607 ^ (_1607 >> 16u), _1695 ^ (_1695 >> 16u)) >> uint2(9u)) | uint2(1065353216u)) - float2(1.0);
    float _1532 = _1528.x * 6.28318023681640625;
    float _1538 = acos((2.0 * _1528.y) - 1.0) - 1.5707950592041015625;
    float _1542 = cos(_1538);
    prevPositionBuffer_1._data[int(gl_GlobalInvocationID.x)] = float4(_1779 - ((float3(cos(_1532) * _1542, sin(_1538), sin(_1532) * _1542) * _mtl_u.u_params[2].x) * _mtl_u.u_params[0].x), 0.0);
    currPositionBuffer._data[int(gl_GlobalInvocationID.x)] = float4(_1779, 0.0);
}

