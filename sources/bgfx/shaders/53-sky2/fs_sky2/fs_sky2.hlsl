






















float intBitsToFloat(int _x) { return asfloat(_x); }
float2 intBitsToFloat(uint2 _x) { return asfloat(_x); }
float3 intBitsToFloat(uint3 _x) { return asfloat(_x); }
float4 intBitsToFloat(uint4 _x) { return asfloat(_x); }

float uintBitsToFloat(uint _x) { return asfloat(_x); }
float2 uintBitsToFloat(uint2 _x) { return asfloat(_x); }
float3 uintBitsToFloat(uint3 _x) { return asfloat(_x); }
float4 uintBitsToFloat(uint4 _x) { return asfloat(_x); }

uint floatBitsToUint(float _x) { return asuint(_x); }
uint2 floatBitsToUint(float2 _x) { return asuint(_x); }
uint3 floatBitsToUint(float3 _x) { return asuint(_x); }
uint4 floatBitsToUint(float4 _x) { return asuint(_x); }

int floatBitsToInt(float _x) { return asint(_x); }
int2 floatBitsToInt(float2 _x) { return asint(_x); }
int3 floatBitsToInt(float3 _x) { return asint(_x); }
int4 floatBitsToInt(float4 _x) { return asint(_x); }

uint bitfieldReverse(uint _x) { return reversebits(_x); }
uint2 bitfieldReverse(uint2 _x) { return reversebits(_x); }
uint3 bitfieldReverse(uint3 _x) { return reversebits(_x); }
uint4 bitfieldReverse(uint4 _x) { return reversebits(_x); }

uint packHalf2x16(float2 _x)
{
return (f32tof16(_x.y)<<16) | f32tof16(_x.x);
}

float2 unpackHalf2x16(uint _x)
{
return float2(f16tof32(_x & 0xffff), f16tof32(_x >> 16) );
}

struct BgfxSampler2D
{
SamplerState m_sampler;
Texture2D m_texture;
};

struct BgfxISampler2D
{
Texture2D<int4> m_texture;
};

struct BgfxUSampler2D
{
Texture2D<uint4> m_texture;
};

struct BgfxSampler2DArray
{
SamplerState m_sampler;
Texture2DArray m_texture;
};

struct BgfxSampler2DShadow
{
SamplerComparisonState m_sampler;
Texture2D m_texture;
};

struct BgfxSampler2DArrayShadow
{
SamplerComparisonState m_sampler;
Texture2DArray m_texture;
};

struct BgfxSampler3D
{
SamplerState m_sampler;
Texture3D m_texture;
};

struct BgfxISampler3D
{
Texture3D<int4> m_texture;
};

struct BgfxUSampler3D
{
Texture3D<uint4> m_texture;
};

struct BgfxSamplerCube
{
SamplerState m_sampler;
TextureCube m_texture;
};

struct BgfxSamplerCubeArray
{
SamplerState m_sampler;
TextureCubeArray m_texture;
};

struct BgfxSamplerCubeShadow
{
SamplerComparisonState m_sampler;
TextureCube m_texture;
};

struct BgfxSampler2DMS
{
Texture2DMS<float4> m_texture;
};

struct BgfxSampler2DMSArray
{
Texture2DMSArray<float4> m_texture;
};

float4 bgfxTexture2D(BgfxSampler2D _sampler, float2 _coord)
{
return _sampler.m_texture.Sample(_sampler.m_sampler, _coord);
}

float4 bgfxTexture2DBias(BgfxSampler2D _sampler, float2 _coord, float _bias)
{
return _sampler.m_texture.SampleBias(_sampler.m_sampler, _coord, _bias);
}

float4 bgfxTexture2DLod(BgfxSampler2D _sampler, float2 _coord, float _level)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level);
}

float4 bgfxTexture2DLodOffset(BgfxSampler2D _sampler, float2 _coord, float _level, int2 _offset)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level, _offset);
}

float4 bgfxTexture2DProj(BgfxSampler2D _sampler, float3 _coord)
{
float2 coord = _coord.xy * rcp(_coord.z);
return _sampler.m_texture.Sample(_sampler.m_sampler, coord);
}

float4 bgfxTexture2DProj(BgfxSampler2D _sampler, float4 _coord)
{
float2 coord = _coord.xy * rcp(_coord.w);
return _sampler.m_texture.Sample(_sampler.m_sampler, coord);
}

float4 bgfxTexture2DGrad(BgfxSampler2D _sampler, float2 _coord, float2 _dPdx, float2 _dPdy)
{
return _sampler.m_texture.SampleGrad(_sampler.m_sampler, _coord, _dPdx, _dPdy);
}

float4 bgfxTexture2DArray(BgfxSampler2DArray _sampler, float3 _coord)
{
return _sampler.m_texture.Sample(_sampler.m_sampler, _coord);
}

float4 bgfxTexture2DArrayLod(BgfxSampler2DArray _sampler, float3 _coord, float _lod)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _lod);
}

float4 bgfxTexture2DArrayLodOffset(BgfxSampler2DArray _sampler, float3 _coord, float _level, int2 _offset)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level, _offset);
}

float3 bgfxTextureSize(BgfxSampler2DArray _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float bgfxShadow2D(BgfxSampler2DShadow _sampler, float3 _coord)
{
return _sampler.m_texture.SampleCmpLevelZero(_sampler.m_sampler, _coord.xy, _coord.z);
}

float bgfxShadow2DProj(BgfxSampler2DShadow _sampler, float4 _coord)
{
float3 coord = _coord.xyz * rcp(_coord.w);
return _sampler.m_texture.SampleCmpLevelZero(_sampler.m_sampler, coord.xy, coord.z);
}

float2 bgfxTextureSize(BgfxSampler2DShadow _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float bgfxShadow2DArray(BgfxSampler2DArrayShadow _sampler, float4 _coord)
{
return _sampler.m_texture.SampleCmpLevelZero(_sampler.m_sampler, _coord.xyz, _coord.w);
}

float3 bgfxTextureSize(BgfxSampler2DArrayShadow _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float4 bgfxTexture3D(BgfxSampler3D _sampler, float3 _coord)
{
return _sampler.m_texture.Sample(_sampler.m_sampler, _coord);
}

float4 bgfxTexture3DLod(BgfxSampler3D _sampler, float3 _coord, float _level)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level);
}

int4 bgfxTexture3D(BgfxISampler3D _sampler, float3 _coord)
{
uint3 size;
_sampler.m_texture.GetDimensions(size.x, size.y, size.z);
return _sampler.m_texture.Load(int4(_coord * size, 0) );
}

uint4 bgfxTexture3D(BgfxUSampler3D _sampler, float3 _coord)
{
uint3 size;
_sampler.m_texture.GetDimensions(size.x, size.y, size.z);
return _sampler.m_texture.Load(int4(_coord * size, 0) );
}

float4 bgfxTextureCube(BgfxSamplerCube _sampler, float3 _coord)
{
return _sampler.m_texture.Sample(_sampler.m_sampler, _coord);
}

float4 bgfxTextureCubeBias(BgfxSamplerCube _sampler, float3 _coord, float _bias)
{
return _sampler.m_texture.SampleBias(_sampler.m_sampler, _coord, _bias);
}

float4 bgfxTextureCubeArray(BgfxSamplerCubeArray _sampler, float4 _coord)
{
return _sampler.m_texture.Sample(_sampler.m_sampler, _coord);
}

float4 bgfxTextureCubeArrayLod(BgfxSamplerCubeArray _sampler, float4 _coord, float _level)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level);
}

float4 bgfxTextureCubeLod(BgfxSamplerCube _sampler, float3 _coord, float _level)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level);
}

float4 bgfxTextureCubeGrad(BgfxSamplerCube _sampler, float3 _coord, float3 _dPdx, float3 _dPdy)
{
return _sampler.m_texture.SampleGrad(_sampler.m_sampler, _coord, _dPdx, _dPdy);
}

float2 bgfxTextureSize(BgfxSamplerCube _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float3 bgfxTextureSize(BgfxSamplerCubeArray _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float2 bgfxTextureSize(BgfxSamplerCubeShadow _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float bgfxShadowCube(BgfxSamplerCubeShadow _sampler, float4 _coord)
{
return _sampler.m_texture.SampleCmpLevelZero(_sampler.m_sampler, _coord.xyz, _coord.w);
}

float4 bgfxTexelFetch(BgfxSampler2D _sampler, int2 _coord, int _lod)
{
return _sampler.m_texture.Load(int3(_coord, _lod) );
}

float4 bgfxTexelFetchOffset(BgfxSampler2D _sampler, int2 _coord, int _lod, int2 _offset)
{
return _sampler.m_texture.Load(int3(_coord, _lod), _offset );
}

float2 bgfxTextureSize(BgfxSampler2D _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float2 bgfxTextureSize(BgfxISampler2D _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float2 bgfxTextureSize(BgfxUSampler2D _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float4 bgfxTextureGather0(BgfxSampler2D _sampler, float2 _coord)
{
return _sampler.m_texture.GatherRed(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather1(BgfxSampler2D _sampler, float2 _coord)
{
return _sampler.m_texture.GatherGreen(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather2(BgfxSampler2D _sampler, float2 _coord)
{
return _sampler.m_texture.GatherBlue(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather3(BgfxSampler2D _sampler, float2 _coord)
{
return _sampler.m_texture.GatherAlpha(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGatherOffset0(BgfxSampler2D _sampler, float2 _coord, int2 _offset)
{
return _sampler.m_texture.GatherRed(_sampler.m_sampler, _coord, _offset);
}

float4 bgfxTextureGatherOffset1(BgfxSampler2D _sampler, float2 _coord, int2 _offset)
{
return _sampler.m_texture.GatherGreen(_sampler.m_sampler, _coord, _offset);
}

float4 bgfxTextureGatherOffset2(BgfxSampler2D _sampler, float2 _coord, int2 _offset)
{
return _sampler.m_texture.GatherBlue(_sampler.m_sampler, _coord, _offset);
}

float4 bgfxTextureGatherOffset3(BgfxSampler2D _sampler, float2 _coord, int2 _offset)
{
return _sampler.m_texture.GatherAlpha(_sampler.m_sampler, _coord, _offset);
}

float4 bgfxTextureGather0(BgfxSampler2DArray _sampler, float3 _coord)
{
return _sampler.m_texture.GatherRed(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather1(BgfxSampler2DArray _sampler, float3 _coord)
{
return _sampler.m_texture.GatherGreen(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather2(BgfxSampler2DArray _sampler, float3 _coord)
{
return _sampler.m_texture.GatherBlue(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather3(BgfxSampler2DArray _sampler, float3 _coord)
{
return _sampler.m_texture.GatherAlpha(_sampler.m_sampler, _coord);
}

int4 bgfxTexelFetch(BgfxISampler2D _sampler, int2 _coord, int _lod)
{
return _sampler.m_texture.Load(int3(_coord, _lod) );
}

uint4 bgfxTexelFetch(BgfxUSampler2D _sampler, int2 _coord, int _lod)
{
return _sampler.m_texture.Load(int3(_coord, _lod) );
}

float4 bgfxTexelFetch(BgfxSampler2DMS _sampler, int2 _coord, int _sampleIdx)
{
return _sampler.m_texture.Load(_coord, _sampleIdx);
}

float4 bgfxTexelFetch(BgfxSampler2DMSArray _sampler, int3 _coord, int _sampleIdx)
{
return _sampler.m_texture.Load(_coord, _sampleIdx);
}

float4 bgfxTexelFetch(BgfxSampler2DArray _sampler, int3 _coord, int _lod)
{
return _sampler.m_texture.Load(int4(_coord, _lod) );
}

float4 bgfxTexelFetch(BgfxSampler3D _sampler, int3 _coord, int _lod)
{
return _sampler.m_texture.Load(int4(_coord, _lod) );
}

int4 bgfxTexelFetch(BgfxISampler3D _sampler, int3 _coord, int _lod)
{
return _sampler.m_texture.Load(int4(_coord, _lod) );
}

uint4 bgfxTexelFetch(BgfxUSampler3D _sampler, int3 _coord, int _lod)
{
return _sampler.m_texture.Load(int4(_coord, _lod) );
}

float3 bgfxTextureSize(BgfxSampler3D _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float3 bgfxTextureSize(BgfxISampler3D _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float3 bgfxTextureSize(BgfxUSampler3D _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float4 bgfxTexture3DGrad(BgfxSampler3D _sampler, float3 _coord, float3 _dPdx, float3 _dPdy)
{
return _sampler.m_texture.SampleGrad(_sampler.m_sampler, _coord, _dPdx, _dPdy);
}

float4 bgfxTexture3DLodOffset(BgfxSampler3D _sampler, float3 _coord, float _level, int3 _offset)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level, _offset);
}












bool2 lessThan(float2 _a, float2 _b) { return _a < _b; }
bool3 lessThan(float3 _a, float3 _b) { return _a < _b; }
bool4 lessThan(float4 _a, float4 _b) { return _a < _b; }

bool2 lessThanEqual(float2 _a, float2 _b) { return _a <= _b; }
bool3 lessThanEqual(float3 _a, float3 _b) { return _a <= _b; }
bool4 lessThanEqual(float4 _a, float4 _b) { return _a <= _b; }

bool2 greaterThan(float2 _a, float2 _b) { return _a > _b; }
bool3 greaterThan(float3 _a, float3 _b) { return _a > _b; }
bool4 greaterThan(float4 _a, float4 _b) { return _a > _b; }

bool2 greaterThanEqual(float2 _a, float2 _b) { return _a >= _b; }
bool3 greaterThanEqual(float3 _a, float3 _b) { return _a >= _b; }
bool4 greaterThanEqual(float4 _a, float4 _b) { return _a >= _b; }

bool2 notEqual(float2 _a, float2 _b) { return _a != _b; }
bool3 notEqual(float3 _a, float3 _b) { return _a != _b; }
bool4 notEqual(float4 _a, float4 _b) { return _a != _b; }

bool2 equal(float2 _a, float2 _b) { return _a == _b; }
bool3 equal(float3 _a, float3 _b) { return _a == _b; }
bool4 equal(float4 _a, float4 _b) { return _a == _b; }

float mix(float _a, float _b, float _t) { return lerp(_a, _b, _t); }
float2 mix(float2 _a, float2 _b, float2 _t) { return lerp(_a, _b, _t); }
float3 mix(float3 _a, float3 _b, float3 _t) { return lerp(_a, _b, _t); }
float4 mix(float4 _a, float4 _b, float4 _t) { return lerp(_a, _b, _t); }

float mod(float _a, float _b) { return _a - _b * floor(_a / _b); }
float2 mod(float2 _a, float2 _b) { return _a - _b * floor(_a / _b); }
float3 mod(float3 _a, float3 _b) { return _a - _b * floor(_a / _b); }
float4 mod(float4 _a, float4 _b) { return _a - _b * floor(_a / _b); }


float2 vec2_splat(float _x) { return float2(_x, _x); }
float3 vec3_splat(float _x) { return float3(_x, _x, _x); }
float4 vec4_splat(float _x) { return float4(_x, _x, _x, _x); }

uint2 uvec2_splat(uint _x) { return uint2(_x, _x); }
uint3 uvec3_splat(uint _x) { return uint3(_x, _x, _x); }
uint4 uvec4_splat(uint _x) { return uint4(_x, _x, _x, _x); }


float4x4 mtxFromRows(float4 _0, float4 _1, float4 _2, float4 _3)
{
return float4x4(_0, _1, _2, _3);
}

float4x4 mtxFromCols(float4 _0, float4 _1, float4 _2, float4 _3)
{
return transpose(float4x4(_0, _1, _2, _3) );
}

float3x3 mtxFromRows(float3 _0, float3 _1, float3 _2)
{
return float3x3(_0, _1, _2);
}

float3x3 mtxFromCols(float3 _0, float3 _1, float3 _2)
{
return transpose(float3x3(_0, _1, _2) );
}

float3x4 mtxFromRows(float4 _0, float4 _1, float4 _2)
{
return float3x4(_0, _1, _2);
}

float3 mtxGetRow(float3x3 _mtx, int _row)
{
return float3(_mtx[_row]);
}

float3 mtxGetColumn(float3x3 _mtx, int _column)
{
return float3(_mtx[0][_column], _mtx[1][_column], _mtx[2][_column]);
}

float4 mtxGetRow(float3x4 _mtx, int _row)
{
return float4(_mtx[_row]);
}

float3 mtxGetColumn(float3x4 _mtx, int _column)
{
return float3(_mtx[0][_column], _mtx[1][_column], _mtx[2][_column]);
}

float4 mtxGetRow(float4x4 _mtx, int _row)
{
return float4(_mtx[_row]);
}

float4 mtxGetColumn(float4x4 _mtx, int _column)
{
return float4(_mtx[0][_column], _mtx[1][_column], _mtx[2][_column], _mtx[3][_column]);
}

float mtxGetElement(float3x3 _mtx, int _column, int _row)
{
return _mtx[_row][_column];
}

float mtxGetElement(float4x4 _mtx, int _column, int _row)
{
return _mtx[_row][_column];
}

float select(bool _cond, float _true, float _false) { return _cond ? _true : _false; }
float2 select(bool _cond, float2 _true, float2 _false) { return _cond ? _true : _false; }
float3 select(bool _cond, float3 _true, float3 _false) { return _cond ? _true : _false; }
float4 select(bool _cond, float4 _true, float4 _false) { return _cond ? _true : _false; }
float2 select(bool2 _cond, float2 _true, float2 _false) { return (float2(_cond) * _true) + (float2((!_cond) ) * _false); }
float3 select(bool3 _cond, float3 _true, float3 _false) { return (float3(_cond) * _true) + (float3((!_cond) ) * _false); }
float4 select(bool4 _cond, float4 _true, float4 _false) { return (float4(_cond) * _true) + (float4((!_cond) ) * _false); }
int select(bool _cond, int _true, int _false) { return _cond ? _true : _false; }
int2 select(bool _cond, int2 _true, int2 _false) { return _cond ? _true : _false; }
int3 select(bool _cond, int3 _true, int3 _false) { return _cond ? _true : _false; }
int4 select(bool _cond, int4 _true, int4 _false) { return _cond ? _true : _false; }
int2 select(bool2 _cond, int2 _true, int2 _false) { return (int2(_cond) * _true) + (int2((!_cond) ) * _false); }
int3 select(bool3 _cond, int3 _true, int3 _false) { return (int3(_cond) * _true) + (int3((!_cond) ) * _false); }
int4 select(bool4 _cond, int4 _true, int4 _false) { return (int4(_cond) * _true) + (int4((!_cond) ) * _false); }
uint select(bool _cond, uint _true, uint _false) { return _cond ? _true : _false; }
uint2 select(bool _cond, uint2 _true, uint2 _false) { return _cond ? _true : _false; }
uint3 select(bool _cond, uint3 _true, uint3 _false) { return _cond ? _true : _false; }
uint4 select(bool _cond, uint4 _true, uint4 _false) { return _cond ? _true : _false; }
uint2 select(bool2 _cond, uint2 _true, uint2 _false) { return (uint2(_cond) * _true) + (uint2((!_cond) ) * _false); }
uint3 select(bool3 _cond, uint3 _true, uint3 _false) { return (uint3(_cond) * _true) + (uint3((!_cond) ) * _false); }
uint4 select(bool4 _cond, uint4 _true, uint4 _false) { return (uint4(_cond) * _true) + (uint4((!_cond) ) * _false); }

static float4 u_viewRect;
static float4 u_viewTexel;
static float4x4 u_view;
static float4x4 u_invView;
static float4x4 u_proj;
static float4x4 u_invProj;
static float4x4 u_viewProj;
static float4x4 u_invViewProj;
static float4x4 u_modelView;
static float4x4 u_invModelView;
static float4x4 u_modelViewProj;
static float4 u_alphaRef4;
static float4x4 u_model[1];









uniform float4 u_atmoRayleigh;
uniform float4 u_atmoMie;
uniform float4 u_atmoOzone;
uniform float4 u_atmoPlanet;
static float4 u_atmoGround;







void atmosphere_medium(float h, out float3 scatter_rayleigh, out float scatter_mie, out float3 extinction) {
float density_r = exp(-h / u_atmoRayleigh.w);
float density_m = exp(-h / u_atmoMie.z);
float density_o = max(0.0, 1.0 - abs(h - u_atmoPlanet.z) / u_atmoPlanet.w);

scatter_rayleigh = u_atmoRayleigh.xyz * density_r;
scatter_mie = u_atmoMie.x * density_m;

extinction = u_atmoRayleigh.xyz * density_r
+ vec3_splat(u_atmoMie.y * density_m)
+ u_atmoOzone.xyz * density_o;
}

float atmosphere_phase_rayleigh(float cos_theta) {
return 3.0 / (16.0 * 3.14159265359) * (1.0 + cos_theta * cos_theta);
}

float atmosphere_phase_mie(float cos_theta) {
float g = u_atmoMie.w;
float g2 = g * g;
float d = 1.0 + g2 - 2.0 * g * cos_theta;
return 3.0 / (8.0 * 3.14159265359) * ((1.0 - g2) * (1.0 + cos_theta * cos_theta)) / ((2.0 + g2) * d * sqrt(max(d, 1e-6)));
}

float atmosphere_dist_to_sphere(float r, float mu, float R) {
float disc = r * r * (mu * mu - 1.0) + R * R;
return max(0.0, -r * mu + sqrt(max(disc, 0.0)));
}

bool atmosphere_hits_ground(float r, float mu) {
return mu < 0.0 && (r * r * (mu * mu - 1.0) + u_atmoPlanet.x * u_atmoPlanet.x) >= 0.0;
}


float2 atmosphere_transmittance_uv(float r, float mu) {
float H = sqrt(u_atmoPlanet.y * u_atmoPlanet.y - u_atmoPlanet.x * u_atmoPlanet.x);
float rho = sqrt(max(r * r - u_atmoPlanet.x * u_atmoPlanet.x, 0.0));

float d = atmosphere_dist_to_sphere(r, mu, u_atmoPlanet.y);
float d_min = u_atmoPlanet.y - r;
float d_max = rho + H;

return float2((d - d_min) / (d_max - d_min), rho / H);
}

void atmosphere_transmittance_params(float2 uv, out float r, out float mu) {
float H = sqrt(u_atmoPlanet.y * u_atmoPlanet.y - u_atmoPlanet.x * u_atmoPlanet.x);
float rho = uv.y * H;

r = sqrt(rho * rho + u_atmoPlanet.x * u_atmoPlanet.x);

float d_min = u_atmoPlanet.y - r;
float d_max = rho + H;
float d = d_min + uv.x * (d_max - d_min);

mu = (d <= 0.0) ? 1.0 : clamp((H * H - rho * rho - d * d) / (2.0 * r * d), -1.0, 1.0);
}


float2 atmosphere_skyview_uv(float r, float view_zenith_cos, float sun_rel_azimuth) {
float v_horizon = sqrt(max(r * r - u_atmoPlanet.x * u_atmoPlanet.x, 0.0));
float beta = acos(clamp(v_horizon / r, -1.0, 1.0));
float zenith_horizon = 3.14159265359 - beta;
float view_zenith = acos(clamp(view_zenith_cos, -1.0, 1.0));

float v;
if (view_zenith < zenith_horizon) {
float coord = view_zenith / zenith_horizon;
v = (1.0 - sqrt(1.0 - coord)) * 0.5;
}
else {
float coord = (view_zenith - zenith_horizon) / max(beta, 1e-4);
v = sqrt(saturate(coord)) * 0.5 + 0.5;
}

float u = sun_rel_azimuth / (2.0 * 3.14159265359) + 0.5;
return float2(u, v);
}

void atmosphere_skyview_params(float2 uv, float r, out float view_zenith_cos, out float sun_rel_azimuth) {
float v_horizon = sqrt(max(r * r - u_atmoPlanet.x * u_atmoPlanet.x, 0.0));
float beta = acos(clamp(v_horizon / r, -1.0, 1.0));
float zenith_horizon = 3.14159265359 - beta;

float view_zenith;
if (uv.y < 0.5) {
float coord = 1.0 - uv.y * 2.0;
view_zenith = zenith_horizon * (1.0 - coord * coord);
}
else {
float coord = uv.y * 2.0 - 1.0;
view_zenith = zenith_horizon + beta * coord * coord;
}

view_zenith_cos = cos(view_zenith);
sun_rel_azimuth = (uv.x - 0.5) * 2.0 * 3.14159265359;
}






float3 sky2_tonemap(float3 color) {
color *= 1.6;
float3 num = color * (2.51 * color + 0.03);
float3 den = color * (2.43 * color + 0.59) + 0.14;
return saturate(num / den);
}






float3 hextile_gain3(float3 x, float r) {
float k = log(1.0 - r) / log(0.5);

float3 s = 2.0 * step(0.5, x);
float3 m = 2.0 * (1.0 - s);

float3 res = 0.5 * s + 0.25 * m * pow(max(vec3_splat(0.0), s + x * m), vec3_splat(k) );

return res.xyz / (res.x + res.y + res.z);
}

float2x2 hextile_rot2x2(float2 idx, float rotStrength) {
float angle = abs(idx.x * idx.y) + abs(idx.x + idx.y) + 3.14159265359;

if (angle < 0.0) angle += 2.0 * 3.14159265359;
if (angle > 3.14159265359) angle -= 2.0 * 3.14159265359;

angle *= rotStrength;

float cs = cos(angle);
float si = sin(angle);

return float2x2(cs, -si, si, cs);
}

float2 hextile_cen_st(float2 vertex) {
float2x2 invSkewMat = float2x2(1.0, 0.5, 0.0, 1.0 / 1.15470054);

return mul(invSkewMat, vertex) / (2.0 * sqrt(3.0) );
}

float2 hextile_hash(float2 p) {
float2 r = mul(float2x2(127.1, 311.7, 269.5, 183.3), p);

return frac(sin(r) * 43758.5453);
}

void hextile_grid(
out float w1, out float w2, out float w3
, out float2 vertex1, out float2 vertex2, out float2 vertex3
, float2 uv
) {
uv *= 2.0 * sqrt(3.0);

const float2x2 gridToSkewedGrid = float2x2(1.0, -0.57735027, 0.0, 1.15470054);
float2 skewedCoord = mul(gridToSkewedGrid, uv);

float2 baseId = floor(skewedCoord);
float3 temp = float3(frac(skewedCoord), 0.0);
temp.z = 1.0 - temp.x - temp.y;

float s = step(0.0, -temp.z);
float s2 = 2.0 * s - 1.0;

w1 = -temp.z * s2;
w2 = s - temp.y * s2;
w3 = s - temp.x * s2;

vertex1 = baseId + float2(s, s);
vertex2 = baseId + float2(s, 1.0 - s);
vertex3 = baseId + float2(1.0 - s, s);
}

void hextile_setup(
float2 uv, float rotStrength
, out float2 uv1, out float2 uv2, out float2 uv3
, out float2x2 rot1, out float2x2 rot2, out float2x2 rot3
, out float3 bary
) {
float w1, w2, w3;
float2 vertex1, vertex2, vertex3;
hextile_grid(w1, w2, w3, vertex1, vertex2, vertex3, uv);

rot1 = hextile_rot2x2(vertex1, rotStrength);
rot2 = hextile_rot2x2(vertex2, rotStrength);
rot3 = hextile_rot2x2(vertex3, rotStrength);

float2 cen1 = hextile_cen_st(vertex1);
float2 cen2 = hextile_cen_st(vertex2);
float2 cen3 = hextile_cen_st(vertex3);

uv1 = mul(uv - cen1, rot1) + cen1 + hextile_hash(vertex1);
uv2 = mul(uv - cen2, rot2) + cen2 + hextile_hash(vertex2);
uv3 = mul(uv - cen3, rot3) + cen3 + hextile_hash(vertex3);

bary = float3(w1, w2, w3);
}

float3 hextile_blend(float3 c1, float3 c2, float3 c3, float3 bary) {
float3 Lw = float3(0.299, 0.587, 0.114);
float3 Dw = float3(dot(c1, Lw), dot(c2, Lw), dot(c3, Lw) );

Dw = mix(vec3_splat(1.0), Dw, 0.6);

float3 W = Dw * pow(bary, vec3_splat(7.0) );
W /= (W.x + W.y + W.z);
W = hextile_gain3(W, 0.7);

return W.x * c1 + W.y * c2 + W.z * c3;
}




uniform SamplerState s_atmo_transmittanceSampler : register(s0); uniform Texture2D s_atmo_transmittanceTexture : register(t0); static BgfxSampler2D s_atmo_transmittance = {s_atmo_transmittanceSampler,s_atmo_transmittanceTexture };
uniform SamplerState s_atmo_multiscatterSampler : register(s1); uniform Texture2D s_atmo_multiscatterTexture : register(t1); static BgfxSampler2D s_atmo_multiscatter = {s_atmo_multiscatterSampler,s_atmo_multiscatterTexture };
uniform SamplerState s_sky_viewSampler : register(s2); uniform Texture2D s_sky_viewTexture : register(t2); static BgfxSampler2D s_sky_view = {s_sky_viewSampler,s_sky_viewTexture };
uniform SamplerState s_grassSampler : register(s3); uniform Texture2D s_grassTexture : register(t3); static BgfxSampler2D s_grass = {s_grassSampler,s_grassTexture };
uniform SamplerState s_rockSampler : register(s4); uniform Texture2D s_rockTexture : register(t4); static BgfxSampler2D s_rock = {s_rockSampler,s_rockTexture };
uniform SamplerState s_shadowMapSampler : register(s5); uniform Texture2D s_shadowMapTexture : register(t5); static BgfxSampler2D s_shadowMap = {s_shadowMapSampler,s_shadowMapTexture };

uniform float4 u_sunDirection;
uniform float4 u_sunRadiance;
uniform float4 u_cameraPos;
uniform float4 u_skyParams;
uniform float4 u_aerialParams;
uniform float4 u_shadowParams;
uniform float4x4 u_lightMtx;


float3 tr_lut(float r, float mu) {
return bgfxTexture2DLod(s_atmo_transmittance, atmosphere_transmittance_uv(r, mu), 0.0).rgb;
}

float3 ms_lut(float r, float mu_sun) {
float2 uv = float2(mu_sun * 0.5 + 0.5, (r - u_atmoPlanet.x) / (u_atmoPlanet.y - u_atmoPlanet.x));
return bgfxTexture2DLod(s_atmo_multiscatter, uv, 0.0).rgb;
}

void hexTerrainFetch(float2 uv, float rotStrength, out float3 grass, out float3 rock) {
float2 dSTdx = ddx(uv);
float2 dSTdy = ddy(-(uv));

float2 uv1, uv2, uv3;
float2x2 rot1, rot2, rot3;
float3 bary;
hextile_setup(uv, rotStrength, uv1, uv2, uv3, rot1, rot2, rot3, bary);

grass = hextile_blend(
bgfxTexture2DGrad(s_grass, uv1, mul(dSTdx, rot1), mul(dSTdy, rot1)).xyz
, bgfxTexture2DGrad(s_grass, uv2, mul(dSTdx, rot2), mul(dSTdy, rot2)).xyz
, bgfxTexture2DGrad(s_grass, uv3, mul(dSTdx, rot3), mul(dSTdy, rot3)).xyz
, bary
);

rock = hextile_blend(
bgfxTexture2DGrad(s_rock, uv1, mul(dSTdx, rot1), mul(dSTdy, rot1)).xyz
, bgfxTexture2DGrad(s_rock, uv2, mul(dSTdx, rot2), mul(dSTdy, rot2)).xyz
, bgfxTexture2DGrad(s_rock, uv3, mul(dSTdx, rot3), mul(dSTdy, rot3)).xyz
, bary
);
}


float sun_shadow(float3 wpos, float3 N, float ndotl) {
if (u_shadowParams.z < 0.5)
return 1.0;

float nOffset = u_shadowParams.y * (2.0 + 6.0 * (1.0 - ndotl) );
float4 sc = mul(u_lightMtx, float4(wpos + N * nOffset, 1.0));
float3 c = sc.xyz / sc.w;

if (c.x < 0.0 || c.x > 1.0 || c.y < 0.0 || c.y > 1.0 || c.z > 1.0)
return 1.0;

float bias = 0.0015 * (1.0 + 3.0 * (1.0 - ndotl) );
float texel = u_shadowParams.x;

float sum = 0.0;
for (int dy = -1; dy <= 1; dy++) {
for (int dx = -1; dx <= 1; dx++) {
float stored = bgfxTexture2D(s_shadowMap, c.xy + float2(float(dx), float(dy)) * texel).r;
sum += (c.z - bias > stored) ? 0.0 : 1.0;
}
}

return sum / 9.0;
}

void main( float4 gl_FragCoord : SV_POSITION , float3 v_normal : TEXCOORD0 , float3 v_wpos : TEXCOORD1 , out float4 bgfx_FragData0 : SV_TARGET0 ) {
float4 bgfx_VoidFrag = vec4_splat(0.0);

float3 N = normalize(v_normal);

float3 tw = abs(N);
tw = tw * tw * tw;
tw = tw / max(tw.x + tw.y + tw.z, 1e-4);

float3 pw = v_wpos * 0.5;

float3 grassX, rockX, grassY, rockY, grassZ, rockZ;
hexTerrainFetch(pw.zy, 0.5, grassX, rockX);
hexTerrainFetch(pw.xz, 0.5, grassY, rockY);
hexTerrainFetch(pw.xy, 0.5, grassZ, rockZ);

float3 grass = grassX * tw.x + grassY * tw.y + grassZ * tw.z;
float3 rock = rockX * tw.x + rockY * tw.y + rockZ * tw.z;


grass = pow(grass, vec3_splat(2.2));
rock = pow(rock, vec3_splat(2.2));

float slope = 1.0 - N.y;
float rockW = smoothstep(0.1, 0.1 + 0.2, slope);
float3 albedo = mix(grass, rock, rockW);

float3 to_sun = -normalize(u_sunDirection.xyz);
float mu_sun = to_sun.y;

float frag_alt = max(v_wpos.y, 0.0);
float surf_r = u_atmoPlanet.x + frag_alt;


float3 sun_t = tr_lut(surf_r, mu_sun);
float ndotl = max(dot(N, to_sun), 0.0);
float shadow = sun_shadow(v_wpos, N, ndotl);
float3 direct = albedo * (1.0 / 3.14159265359) * u_sunRadiance.rgb * sun_t * ndotl * shadow;

float lut_r = u_skyParams.x;
float3 sky_avg = bgfxTexture2DLod(s_sky_view, atmosphere_skyview_uv(lut_r, 1.00, 0.0), 0.0).rgb
+ bgfxTexture2DLod(s_sky_view, atmosphere_skyview_uv(lut_r, 0.35, 0.0), 0.0).rgb
+ bgfxTexture2DLod(s_sky_view, atmosphere_skyview_uv(lut_r, 0.35, 3.14159265359), 0.0).rgb;
sky_avg *= 1.0 / 3.0;

float3 ambient = albedo * sky_avg * (0.4 + 0.6 * saturate(N.y) ) * u_aerialParams.z;

float3 lit = direct + ambient;


float3 cam = u_cameraPos.xyz;
float3 ray = v_wpos - cam;
float dist = length(ray);
float3 vdir = ray / max(dist, 1e-6);

float cos_sun_view = dot(vdir, to_sun);
float phase_r = atmosphere_phase_rayleigh(cos_sun_view);
float phase_m = atmosphere_phase_mie(cos_sun_view);

float density = u_aerialParams.y;
float dt = dist / float(16);

float3 throughput = float3(1.0, 1.0, 1.0);
float3 inscatter = float3(0.0, 0.0, 0.0);

for (int i = 0; i < 16; i++) {
float t = (float(i) + 0.5) * dt;
float3 p = cam + vdir * t;
float alt = max(p.y, 0.0);
float sr = u_atmoPlanet.x + alt;

float3 scatter_r;
float scatter_m;
float3 extinction;
atmosphere_medium(alt, scatter_r, scatter_m, extinction);

scatter_r *= density;
scatter_m *= density;
extinction *= density;

float3 st = tr_lut(sr, mu_sun);
float3 psi = ms_lut(sr, mu_sun) * u_atmoOzone.w;

float3 S = (scatter_r * phase_r + vec3_splat(scatter_m * phase_m)) * st
+ (scatter_r + vec3_splat(scatter_m)) * psi;
S *= u_sunRadiance.rgb;

float3 step_t = exp(-extinction * dt);
float3 safe_e = max(extinction, vec3_splat(1e-7));

inscatter += throughput * (S - S * step_t) / safe_e;
throughput *= step_t;
}

float3 color = lit * throughput + inscatter * u_aerialParams.x;

bgfx_FragData0 = float4(sky2_tonemap(color), 1.0);
}

