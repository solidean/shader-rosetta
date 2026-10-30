






















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






float4 encodeRE8(float _r)
{
float exponent = ceil(log2(_r) );
return float4(_r / exp2(exponent)
, 0.0
, 0.0
, (exponent + 128.0) / 255.0
);
}

float decodeRE8(float4 _re8)
{
float exponent = _re8.w * 255.0 - 128.0;
return _re8.x * exp2(exponent);
}

float4 encodeRGBE8(float3 _rgb)
{
float4 rgbe8;
float maxComponent = max(max(_rgb.x, _rgb.y), _rgb.z);
float exponent = ceil(log2(maxComponent) );
rgbe8.xyz = _rgb / exp2(exponent);
rgbe8.w = (exponent + 128.0) / 255.0;
return rgbe8;
}

float3 decodeRGBE8(float4 _rgbe8)
{
float exponent = _rgbe8.w * 255.0 - 128.0;
float3 rgb = _rgbe8.xyz * exp2(exponent);
return rgb;
}

float3 encodeNormalUint(float3 _normal)
{
return _normal * 0.5 + 0.5;
}

float3 decodeNormalUint(float3 _encodedNormal)
{
return _encodedNormal * 2.0 - 1.0;
}

float2 encodeNormalSphereMap(float3 _normal)
{
return normalize(_normal.xy) * sqrt(_normal.z * 0.5 + 0.5);
}

float3 decodeNormalSphereMap(float2 _encodedNormal)
{
float zz = dot(_encodedNormal, _encodedNormal) * 2.0 - 1.0;
return float3(normalize(_encodedNormal.xy) * sqrt(1.0 - zz*zz), zz);
}

float2 octahedronWrap(float2 _val)
{



return (1.0 - abs(_val.yx) )
* mix(vec2_splat(-1.0), vec2_splat(1.0), float2(greaterThanEqual(_val.xy, vec2_splat(0.0) ) ) );
}

float2 encodeNormalOctahedron(float3 _normal)
{
_normal /= abs(_normal.x) + abs(_normal.y) + abs(_normal.z);
_normal.xy = _normal.z >= 0.0 ? _normal.xy : octahedronWrap(_normal.xy);
_normal.xy = _normal.xy * 0.5 + 0.5;
return _normal.xy;
}

float3 decodeNormalOctahedron(float2 _encodedNormal)
{
_encodedNormal = _encodedNormal * 2.0 - 1.0;

float3 normal;
normal.z = 1.0 - abs(_encodedNormal.x) - abs(_encodedNormal.y);
normal.xy = normal.z >= 0.0 ? _encodedNormal.xy : octahedronWrap(_encodedNormal.xy);
return normalize(normal);
}

float3 convertRGB2XYZ(float3 _rgb)
{



float3 xyz;
xyz.x = dot(float3(0.4124564, 0.3575761, 0.1804375), _rgb);
xyz.y = dot(float3(0.2126729, 0.7151522, 0.0721750), _rgb);
xyz.z = dot(float3(0.0193339, 0.1191920, 0.9503041), _rgb);
return xyz;
}

float3 convertXYZ2RGB(float3 _xyz)
{
float3 rgb;
rgb.x = dot(float3( 3.2404542, -1.5371385, -0.4985314), _xyz);
rgb.y = dot(float3(-0.9692660, 1.8760108, 0.0415560), _xyz);
rgb.z = dot(float3( 0.0556434, -0.2040259, 1.0572252), _xyz);
return rgb;
}

float3 convertXYZ2Yxy(float3 _xyz)
{



float inv = 1.0/dot(_xyz, float3(1.0, 1.0, 1.0) );
return float3(_xyz.y, _xyz.x*inv, _xyz.y*inv);
}

float3 convertYxy2XYZ(float3 _Yxy)
{



float3 xyz;
xyz.x = _Yxy.x*_Yxy.y/_Yxy.z;
xyz.y = _Yxy.x;
xyz.z = _Yxy.x*(1.0 - _Yxy.y - _Yxy.z)/_Yxy.z;
return xyz;
}

float3 convertRGB2Yxy(float3 _rgb)
{
return convertXYZ2Yxy(convertRGB2XYZ(_rgb) );
}

float3 convertYxy2RGB(float3 _Yxy)
{
return convertXYZ2RGB(convertYxy2XYZ(_Yxy) );
}

float3 convertRGB2Yuv(float3 _rgb)
{
float3 yuv;
yuv.x = dot(_rgb, float3(0.299, 0.587, 0.114) );
yuv.y = (_rgb.x - yuv.x)*0.713 + 0.5;
yuv.z = (_rgb.z - yuv.x)*0.564 + 0.5;
return yuv;
}

float3 convertYuv2RGB(float3 _yuv)
{
float3 rgb;
rgb.x = _yuv.x + 1.403*(_yuv.y-0.5);
rgb.y = _yuv.x - 0.344*(_yuv.y-0.5) - 0.714*(_yuv.z-0.5);
rgb.z = _yuv.x + 1.773*(_yuv.z-0.5);
return rgb;
}

float3 convertRGB2YIQ(float3 _rgb)
{
float3 yiq;
yiq.x = dot(float3(0.299, 0.587, 0.114 ), _rgb);
yiq.y = dot(float3(0.595716, -0.274453, -0.321263), _rgb);
yiq.z = dot(float3(0.211456, -0.522591, 0.311135), _rgb);
return yiq;
}

float3 convertYIQ2RGB(float3 _yiq)
{
float3 rgb;
rgb.x = dot(float3(1.0, 0.9563, 0.6210), _yiq);
rgb.y = dot(float3(1.0, -0.2721, -0.6474), _yiq);
rgb.z = dot(float3(1.0, -1.1070, 1.7046), _yiq);
return rgb;
}

float3 toLinear(float3 _rgb)
{
return pow(abs(_rgb), vec3_splat(2.2) );
}

float4 toLinear(float4 _rgba)
{
return float4(toLinear(_rgba.xyz), _rgba.w);
}

float3 toLinearAccurate(float3 _rgb)
{
float3 lo = _rgb / 12.92;
float3 hi = pow( (_rgb + 0.055) / 1.055, vec3_splat(2.4) );
float3 rgb = mix(hi, lo, float3(lessThanEqual(_rgb, vec3_splat(0.04045) ) ) );
return rgb;
}

float4 toLinearAccurate(float4 _rgba)
{
return float4(toLinearAccurate(_rgba.xyz), _rgba.w);
}

float toGamma(float _r)
{
return pow(abs(_r), 1.0/2.2);
}

float3 toGamma(float3 _rgb)
{
return pow(abs(_rgb), vec3_splat(1.0/2.2) );
}

float4 toGamma(float4 _rgba)
{
return float4(toGamma(_rgba.xyz), _rgba.w);
}

float3 toGammaAccurate(float3 _rgb)
{
float3 lo = _rgb * 12.92;
float3 hi = pow(abs(_rgb), vec3_splat(1.0/2.4) ) * 1.055 - 0.055;
float3 rgb = mix(hi, lo, float3(lessThanEqual(_rgb, vec3_splat(0.0031308) ) ) );
return rgb;
}

float4 toGammaAccurate(float4 _rgba)
{
return float4(toGammaAccurate(_rgba.xyz), _rgba.w);
}

float3 toReinhard(float3 _rgb)
{
return toGamma(_rgb/(_rgb+vec3_splat(1.0) ) );
}

float4 toReinhard(float4 _rgba)
{
return float4(toReinhard(_rgba.xyz), _rgba.w);
}

float3 toFilmic(float3 _rgb)
{
_rgb = max(vec3_splat(0.0), _rgb - 0.004);
_rgb = (_rgb*(6.2*_rgb + 0.5) ) / (_rgb*(6.2*_rgb + 1.7) + 0.06);
return _rgb;
}

float4 toFilmic(float4 _rgba)
{
return float4(toFilmic(_rgba.xyz), _rgba.w);
}

float3 toAcesFilmic(float3 _rgb)
{



float aa = 2.51f;
float bb = 0.03f;
float cc = 2.43f;
float dd = 0.59f;
float ee = 0.14f;
return saturate( (_rgb*(aa*_rgb + bb) )/(_rgb*(cc*_rgb + dd) + ee) );
}

float4 toAcesFilmic(float4 _rgba)
{
return float4(toAcesFilmic(_rgba.xyz), _rgba.w);
}

float3 luma(float3 _rgb)
{
float yy = dot(float3(0.2126729, 0.7151522, 0.0721750), _rgb);
return vec3_splat(yy);
}

float4 luma(float4 _rgba)
{
return float4(luma(_rgba.xyz), _rgba.w);
}

float3 conSatBri(float3 _rgb, float3 _csb)
{
float3 rgb = _rgb * _csb.z;
rgb = mix(luma(rgb), rgb, _csb.y);
rgb = mix(vec3_splat(0.5), rgb, _csb.x);
return rgb;
}

float4 conSatBri(float4 _rgba, float3 _csb)
{
return float4(conSatBri(_rgba.xyz, _csb), _rgba.w);
}

float3 posterize(float3 _rgb, float _numColors)
{
return floor(_rgb*_numColors) / _numColors;
}

float4 posterize(float4 _rgba, float _numColors)
{
return float4(posterize(_rgba.xyz, _numColors), _rgba.w);
}

float3 sepia(float3 _rgb)
{
float3 color;
color.x = dot(_rgb, float3(0.393, 0.769, 0.189) );
color.y = dot(_rgb, float3(0.349, 0.686, 0.168) );
color.z = dot(_rgb, float3(0.272, 0.534, 0.131) );
return color;
}

float4 sepia(float4 _rgba)
{
return float4(sepia(_rgba.xyz), _rgba.w);
}

float3 blendOverlay(float3 _base, float3 _blend)
{
float3 lt = 2.0 * _base * _blend;
float3 gte = 1.0 - 2.0 * (1.0 - _base) * (1.0 - _blend);
return mix(lt, gte, step(vec3_splat(0.5), _base) );
}

float4 blendOverlay(float4 _base, float4 _blend)
{
return float4(blendOverlay(_base.xyz, _blend.xyz), _base.w);
}

float3 adjustHue(float3 _rgb, float _hue)
{
float3 yiq = convertRGB2YIQ(_rgb);
float angle = _hue + atan2(yiq.z, yiq.y);
float len = length(yiq.yz);
return convertYIQ2RGB(float3(yiq.x, len*cos(angle), len*sin(angle) ) );
}

float4 packFloatToRgba(float _value)
{



const float4 shift = float4(255 * 255 * 255, 255 * 255, 255, 1.0);
const float4 mask = float4(0, 1.0 / 255.0, 1.0 / 255.0, 1.0 / 255.0);
float4 comp = frac(_value * shift);
comp -= comp.xxyz * mask;
return comp;
}

float unpackRgbaToFloat(float4 _rgba)
{
const float4 shift = float4(1.0 / (255.0 * 255.0 * 255.0), 1.0 / (255.0 * 255.0), 1.0 / 255.0, 1.0);
return dot(_rgba, shift);
}

float2 packHalfFloat(float _value)
{
const float2 shift = float2(255, 1.0);
const float2 mask = float2(0, 1.0 / 255.0);
float2 comp = frac(_value * shift);
comp -= comp.xx * mask;
return comp;
}

float unpackHalfFloat(float2 _rg)
{
const float2 shift = float2(1.0 / 255.0, 1.0);
return dot(_rg, shift);
}

float random(float2 _uv)
{
return frac(sin(dot(_uv.xy, float2(12.9898, 78.233) ) ) * 43758.5453);
}

float3 fixCubeLookup(float3 _v, float _lod, float _topLevelCubeSize)
{



float ax = abs(_v.x);
float ay = abs(_v.y);
float az = abs(_v.z);
float vmax = max(max(ax, ay), az);
float scale = 1.0 - exp2(_lod) / _topLevelCubeSize;
if (ax != vmax) { _v.x *= scale; }
if (ay != vmax) { _v.y *= scale; }
if (az != vmax) { _v.z *= scale; }
return _v;
}

float2 texture2DBc5(BgfxSampler2D _sampler, float2 _uv)
{
return bgfxTexture2D(_sampler, _uv).xy;
}

float3x3 cofactor(float4x4 _m)
{




return float3x3(
_m[1][1]*_m[2][2]-_m[1][2]*_m[2][1],
_m[1][2]*_m[2][0]-_m[1][0]*_m[2][2],
_m[1][0]*_m[2][1]-_m[1][1]*_m[2][0],
_m[0][2]*_m[2][1]-_m[0][1]*_m[2][2],
_m[0][0]*_m[2][2]-_m[0][2]*_m[2][0],
_m[0][1]*_m[2][0]-_m[0][0]*_m[2][1],
_m[0][1]*_m[1][2]-_m[0][2]*_m[1][1],
_m[0][2]*_m[1][0]-_m[0][0]*_m[1][2],
_m[0][0]*_m[1][1]-_m[0][1]*_m[1][0]
);
}

float toClipSpaceDepth(float _depthTextureZ)
{
return _depthTextureZ;
}

float toDepthTextureZ(float _clipSpaceZ)
{
return _clipSpaceZ;
}

float toClipSpaceY(float _y)
{
return -_y;
}

float3 clipToWorld(float4x4 _invViewProj, float3 _clipPos)
{
float4 wpos = mul(_invViewProj, float4(_clipPos, 1.0));
return wpos.xyz / wpos.w;
}



float2 sampleVogelDisk(int index, int sampleCount)
{
const float goldenAngle = 2.39996323;
float i = float(index);
float r = sqrt((i + 0.5) / float(sampleCount));
float a = i * goldenAngle;
return float2(cos(a), sin(a)) * r;
}

float2 samplePoisson(int index)
{
return sampleVogelDisk(index, 10);
}

float linstep(float _edge0, float _edge1, float _x)
{
return clamp((_x-_edge0)/(_edge1-_edge0), 0.0, 1.0);
}

float attenuation(float _dist, float3 _attn)
{
return 1.0 / ( _attn.x
+ _attn.y * _dist
+ _attn.z * _dist * _dist
);
}

float spot(float _ldotsd, float _inner, float _outer)
{
float inner = cos(radians(_inner));
float outer = cos(radians(min(_outer, _inner - 0.001)));
float spot = clamp((_ldotsd - inner) / (outer - inner), 0.0, 1.0);
return spot;
}

float2 lit(float3 _ld, float3 _n, float3 _vd, float _exp)
{

float ndotl = dot(_n, _ld);


float3 r = 2.0*ndotl*_n - _ld;
float rdotv = dot(r, _vd);
float spec = step(0.0, ndotl) * pow(max(0.0, rdotv), _exp) * (2.0 + _exp)/8.0;

return max(float2(ndotl, spec), 0.0);
}

struct Light
{
float3 l;
float3 ld;
float attn;
};

Light evalLight(float3 _v, float4 _l, float3 _spotDirection, float _spotInner, float _spotOuter, float3 _attnParams)
{
Light light;


light.l = _l.xyz;
light.ld = -normalize(light.l);
light.attn = 1.0;

if (0.0 != _l.w)
{
light.l = _l.xyz - _v;
light.ld = normalize(light.l);

float ldotsd = max(0.0, dot(-light.ld, normalize(_spotDirection)));
float falloff = spot(ldotsd, _spotOuter, _spotInner);
light.attn = attenuation(length(light.l), _attnParams) * mix(falloff, 1.0, step(90, _spotOuter));
}

return light;
}

float texcoordInRange(float2 _texcoord)
{
bool inRange = all(greaterThan(_texcoord, vec2_splat(0.0)))
&& all(lessThan (_texcoord, vec2_splat(1.0)))
;

return float(inRange);
}



float2 rotateSample(float2 _sample, float2 _sincos)
{
return float2(_sample.x * _sincos.y - _sample.y * _sincos.x,
_sample.x * _sincos.x + _sample.y * _sincos.y);
}






float interleavedGradientNoise(float2 _screenPos)
{
float3 magic = float3(0.06711056, 0.00583715, 52.9829189);
return frac(magic.z * frac(dot(_screenPos, magic.xy)));
}

float hardShadowLod(BgfxSampler2D _sampler, float lod, float4 _shadowCoord, float _bias)
{
float2 texCoord = _shadowCoord.xy/_shadowCoord.w;

bool outside = any(greaterThan(texCoord, vec2_splat(1.0)))
|| any(lessThan (texCoord, vec2_splat(0.0)))
;

if (outside)
{
return 1.0;
}

float receiver = (_shadowCoord.z-_bias)/_shadowCoord.w;
float occluder = unpackRgbaToFloat(bgfxTexture2DLod(_sampler, texCoord, lod) );

float visibility = step(receiver, occluder);
return visibility;
}

float hardShadow(BgfxSampler2D _sampler, float4 _shadowCoord, float _bias)
{
return hardShadowLod(_sampler, 0.0, _shadowCoord, _bias);
}




float PCFLodOffset(BgfxSampler2D _sampler, float lod, float2 offset, float4 _shadowCoord, float _bias, float2 _texelSize, float2 _diskRotation)
{
float result = 0.0;

for ( int i = 0; i < 16; ++i )
{
float2 jitteredOffset = rotateSample(samplePoisson(i), _diskRotation) * offset;
result += hardShadowLod(_sampler, lod, _shadowCoord + float4(jitteredOffset, 0.0, 0.0), _bias);
}
return result / float(16);
}

float PCFLod(BgfxSampler2D _sampler, float lod, float2 filterRadius, float4 _shadowCoord, float _bias, float4 _pcfParams, float2 _texelSize, float2 _diskRotation)
{
float2 offset = filterRadius * _pcfParams.zw * _texelSize * _shadowCoord.w;

return PCFLodOffset(_sampler, lod, offset, _shadowCoord, _bias, _texelSize, _diskRotation);
}

float PCF(BgfxSampler2D _sampler, float4 _shadowCoord, float _bias, float4 _pcfParams, float2 _texelSize, float2 fragCoord)
{

float2 noiseCoord = fragCoord;

float angle = interleavedGradientNoise(noiseCoord) * 6.283185;
float2 diskRotation = float2(sin(angle), cos(angle));
return PCFLod(_sampler, 0.0, float2(2.0, 2.0), _shadowCoord, _bias, _pcfParams, _texelSize, diskRotation);
}

float VSM(BgfxSampler2D _sampler, float4 _shadowCoord, float _bias, float _depthMultiplier, float _minVariance)
{
float2 texCoord = _shadowCoord.xy/_shadowCoord.w;

bool outside = any(greaterThan(texCoord, vec2_splat(1.0)))
|| any(lessThan (texCoord, vec2_splat(0.0)))
;

if (outside)
{
return 1.0;
}

float receiver = (_shadowCoord.z-_bias)/_shadowCoord.w * _depthMultiplier;
float4 rgba = bgfxTexture2D(_sampler, texCoord);
float2 occluder = float2(unpackHalfFloat(rgba.rg), unpackHalfFloat(rgba.ba)) * _depthMultiplier;

if (receiver < occluder.x)
{
return 1.0;
}

float variance = max(occluder.y - (occluder.x*occluder.x), _minVariance);
float d = receiver - occluder.x;

float visibility = variance / (variance + d*d);

return visibility;
}

float ESM(BgfxSampler2D _sampler, float4 _shadowCoord, float _bias, float _depthMultiplier)
{
float2 texCoord = _shadowCoord.xy/_shadowCoord.w;

bool outside = any(greaterThan(texCoord, vec2_splat(1.0)))
|| any(lessThan (texCoord, vec2_splat(0.0)))
;

if (outside)
{
return 1.0;
}

float receiver = (_shadowCoord.z-_bias)/_shadowCoord.w;
float occluder = unpackRgbaToFloat(bgfxTexture2D(_sampler, texCoord) );

float visibility = clamp(exp(_depthMultiplier * (occluder-receiver) ), 0.0, 1.0);

return visibility;
}


float4 blur9(BgfxSampler2D _sampler, float2 _uv0, float4 _uv1, float4 _uv2, float4 _uv3, float4 _uv4)
{

float blur;
blur = unpackRgbaToFloat(bgfxTexture2D(_sampler, _uv0) * (1.0/(1.0+2.0*(0.9+0.55+0.18+0.1) )));
blur += unpackRgbaToFloat(bgfxTexture2D(_sampler, _uv1.xy) * (0.9/(1.0+2.0*(0.9+0.55+0.18+0.1) )));
blur += unpackRgbaToFloat(bgfxTexture2D(_sampler, _uv1.zw) * (0.9/(1.0+2.0*(0.9+0.55+0.18+0.1) )));
blur += unpackRgbaToFloat(bgfxTexture2D(_sampler, _uv2.xy) * (0.55/(1.0+2.0*(0.9+0.55+0.18+0.1) )));
blur += unpackRgbaToFloat(bgfxTexture2D(_sampler, _uv2.zw) * (0.55/(1.0+2.0*(0.9+0.55+0.18+0.1) )));
blur += unpackRgbaToFloat(bgfxTexture2D(_sampler, _uv3.xy) * (0.18/(1.0+2.0*(0.9+0.55+0.18+0.1) )));
blur += unpackRgbaToFloat(bgfxTexture2D(_sampler, _uv3.zw) * (0.18/(1.0+2.0*(0.9+0.55+0.18+0.1) )));
blur += unpackRgbaToFloat(bgfxTexture2D(_sampler, _uv4.xy) * (0.1/(1.0+2.0*(0.9+0.55+0.18+0.1) )));
blur += unpackRgbaToFloat(bgfxTexture2D(_sampler, _uv4.zw) * (0.1/(1.0+2.0*(0.9+0.55+0.18+0.1) )));
return packFloatToRgba(blur);
}

float4 blur9VSM(BgfxSampler2D _sampler, float2 _uv0, float4 _uv1, float4 _uv2, float4 _uv3, float4 _uv4)
{

float2 blur;
float4 val;
val = bgfxTexture2D(_sampler, _uv0) * (1.0/(1.0+2.0*(0.9+0.55+0.18+0.1) ));
blur = float2(unpackHalfFloat(val.rg), unpackHalfFloat(val.ba));
val = bgfxTexture2D(_sampler, _uv1.xy) * (0.9/(1.0+2.0*(0.9+0.55+0.18+0.1) ));
blur += float2(unpackHalfFloat(val.rg), unpackHalfFloat(val.ba));
val = bgfxTexture2D(_sampler, _uv1.zw) * (0.9/(1.0+2.0*(0.9+0.55+0.18+0.1) ));
blur += float2(unpackHalfFloat(val.rg), unpackHalfFloat(val.ba));
val = bgfxTexture2D(_sampler, _uv2.xy) * (0.55/(1.0+2.0*(0.9+0.55+0.18+0.1) ));
blur += float2(unpackHalfFloat(val.rg), unpackHalfFloat(val.ba));
val = bgfxTexture2D(_sampler, _uv2.zw) * (0.55/(1.0+2.0*(0.9+0.55+0.18+0.1) ));
blur += float2(unpackHalfFloat(val.rg), unpackHalfFloat(val.ba));
val = bgfxTexture2D(_sampler, _uv3.xy) * (0.18/(1.0+2.0*(0.9+0.55+0.18+0.1) ));
blur += float2(unpackHalfFloat(val.rg), unpackHalfFloat(val.ba));
val = bgfxTexture2D(_sampler, _uv3.zw) * (0.18/(1.0+2.0*(0.9+0.55+0.18+0.1) ));
blur += float2(unpackHalfFloat(val.rg), unpackHalfFloat(val.ba));
val = bgfxTexture2D(_sampler, _uv4.xy) * (0.1/(1.0+2.0*(0.9+0.55+0.18+0.1) ));
blur += float2(unpackHalfFloat(val.rg), unpackHalfFloat(val.ba));
val = bgfxTexture2D(_sampler, _uv4.zw) * (0.1/(1.0+2.0*(0.9+0.55+0.18+0.1) ));
blur += float2(unpackHalfFloat(val.rg), unpackHalfFloat(val.ba));

return float4(packHalfFloat(blur.x), packHalfFloat(blur.y));
}







float3 findBlocker(BgfxSampler2D _sampler, float4 _shadowCoord, float2 _searchSize, float _bias, float2 _diskRotation)
{
int blockerCount = 0;
float avgBlockerDepth = 0.0;
float closestBlockerDepth = 0.0;
float2 texCoord = _shadowCoord.xy / _shadowCoord.w;
float receiverDepth = (_shadowCoord.z / _shadowCoord.w) - _bias;


for( int i = 0; i < 16; ++i )
{
float2 offset = rotateSample(samplePoisson(i), _diskRotation) * _searchSize;
float shadowMapDepth = unpackRgbaToFloat(bgfxTexture2D(_sampler, texCoord + offset));
if (shadowMapDepth < receiverDepth)
{
avgBlockerDepth += shadowMapDepth;
closestBlockerDepth = max(closestBlockerDepth, shadowMapDepth);
blockerCount++;
}
}


if (blockerCount > 0)
{
avgBlockerDepth /= float(blockerCount);
}
else
{
avgBlockerDepth = -1.0;
}

float blockerRatio = float(blockerCount) / float(16);
return float3(avgBlockerDepth, closestBlockerDepth, blockerRatio);
}



float PCSS(BgfxSampler2D _sampler, float4 _shadowCoord, float _bias, float4 _pcssParams, float2 _texelSize, float2 fragCoord)
{





float searchRadiusUV = 0.01;



float penumbraScaleX = _pcssParams.z;
float penumbraScaleY = _pcssParams.w;


float maxFilterRadius = 0.25;




float2 noiseCoord = fragCoord;

float noise = interleavedGradientNoise(noiseCoord);
float rotationAngle = noise * 6.283185;
float2 diskRotation = float2(sin(rotationAngle), cos(rotationAngle));


float receiverDepth = (_shadowCoord.z / _shadowCoord.w) - _bias;




float3 blockerResult = findBlocker(_sampler, _shadowCoord, float2(searchRadiusUV, searchRadiusUV), _bias, diskRotation);
float avgBlockerDepth = blockerResult.x;
float blockerRatio = blockerResult.z;

if (avgBlockerDepth < -0.99)
{
return 1.0;
}











float penumbraWidth = penumbraScaleX * max(0.0, receiverDepth - avgBlockerDepth) / avgBlockerDepth;
float penumbraHeight = penumbraScaleY * max(0.0, receiverDepth - avgBlockerDepth) / avgBlockerDepth;
float filterRadiusU = clamp(penumbraWidth, 0.0, maxFilterRadius);
float filterRadiusV = clamp(penumbraHeight, 0.0, maxFilterRadius);




float visibility = PCFLodOffset(_sampler, 0.0, float2(filterRadiusU, filterRadiusV), _shadowCoord, _bias, _texelSize, diskRotation);




float edgeFade = smoothstep(0.0, 0.25, blockerRatio);
visibility = mix(1.0, visibility, edgeFade);

return visibility;
}

static float4 u_params0;
uniform float4 u_params1;
uniform float4 u_params2;
uniform float4 u_color;

uniform float4 u_materialKa;
uniform float4 u_materialKd;
uniform float4 u_materialKs;
uniform float4 u_lightPosition;
uniform float4 u_lightAmbientPower;
uniform float4 u_lightDiffusePower;
uniform float4 u_lightSpecularPower;
uniform float4 u_lightSpotDirectionInner;
uniform float4 u_lightAttenuationSpotOuter;
static float4 u_smSamplingParams;
static float4 u_csmFarDistances;


uniform SamplerState s_shadowMap0Sampler : register(s4); uniform Texture2D s_shadowMap0Texture : register(t4); static BgfxSampler2D s_shadowMap0 = {s_shadowMap0Sampler,s_shadowMap0Texture };
uniform SamplerState s_shadowMap1Sampler : register(s5); uniform Texture2D s_shadowMap1Texture : register(t5); static BgfxSampler2D s_shadowMap1 = {s_shadowMap1Sampler,s_shadowMap1Texture };
uniform SamplerState s_shadowMap2Sampler : register(s6); uniform Texture2D s_shadowMap2Texture : register(t6); static BgfxSampler2D s_shadowMap2 = {s_shadowMap2Sampler,s_shadowMap2Texture };
uniform SamplerState s_shadowMap3Sampler : register(s7); uniform Texture2D s_shadowMap3Texture : register(t7); static BgfxSampler2D s_shadowMap3 = {s_shadowMap3Sampler,s_shadowMap3Texture };

struct Shader
{
float3 ambi;
float3 diff;
float3 spec;
};

Shader evalShader(float _diff, float _spec)
{
Shader shader;

shader.ambi = u_lightAmbientPower.xyz * u_lightAmbientPower.w * u_materialKa.xyz;
shader.diff = u_lightDiffusePower.xyz * u_lightDiffusePower.w * u_materialKd.xyz * _diff;
shader.spec = u_lightSpecularPower.xyz * u_lightSpecularPower.w * u_materialKs.xyz * _spec;

return shader;
}

float computeVisibility(BgfxSampler2D _sampler
, float4 _shadowCoord
, float _bias
, float4 _samplingParams
, float2 _texelSize
, float _depthMultiplier
, float _minVariance
, float _hardness
, float2 _fragCoord
)
{
float visibility;

float4 shadowcoord = float4(_shadowCoord.xy / _shadowCoord.w, _shadowCoord.z, 1.0);

visibility = hardShadow(_sampler, shadowcoord, _bias);

return visibility;
}

void main( float4 gl_FragCoord : SV_POSITION , float3 v_normal : NORMAL , float4 v_position : TEXCOORD7 , float4 v_texcoord1 : TEXCOORD1 , float4 v_texcoord2 : TEXCOORD2 , float4 v_texcoord3 : TEXCOORD3 , float4 v_texcoord4 : TEXCOORD4 , float3 v_view : TEXCOORD5 , out float4 bgfx_FragData0 : SV_TARGET0 )
{
float4 bgfx_VoidFrag = vec4_splat(0.0);











{
float3 colorCoverage;
float visibility;

float2 fragCoord = gl_FragCoord.xy;
float2 texelSize = vec2_splat(u_params2.z);

float2 texcoord1 = v_texcoord1.xy/v_texcoord1.w;
float2 texcoord2 = v_texcoord2.xy/v_texcoord2.w;
float2 texcoord3 = v_texcoord3.xy/v_texcoord3.w;
float2 texcoord4 = v_texcoord4.xy/v_texcoord4.w;

bool selection0 = all(lessThan(texcoord1, vec2_splat(0.99))) && all(greaterThan(texcoord1, vec2_splat(0.01)));
bool selection1 = all(lessThan(texcoord2, vec2_splat(0.99))) && all(greaterThan(texcoord2, vec2_splat(0.01)));
bool selection2 = all(lessThan(texcoord3, vec2_splat(0.99))) && all(greaterThan(texcoord3, vec2_splat(0.01)));
bool selection3 = all(lessThan(texcoord4, vec2_splat(0.99))) && all(greaterThan(texcoord4, vec2_splat(0.01)));

if (selection0)
{
float4 shadowcoord = v_texcoord1;

float coverage = texcoordInRange(shadowcoord.xy/shadowcoord.w) * 0.4;
colorCoverage = float3(-coverage, coverage, -coverage);
visibility = computeVisibility(s_shadowMap0
, shadowcoord
, u_params1.x
, u_smSamplingParams
, texelSize
, u_params1.w
, u_params1.z
, u_params1.z
, fragCoord
);
}
else if (selection1)
{
float4 shadowcoord = v_texcoord2;

float coverage = texcoordInRange(shadowcoord.xy/shadowcoord.w) * 0.4;
colorCoverage = float3(coverage, coverage, -coverage);
visibility = computeVisibility(s_shadowMap1
, shadowcoord
, u_params1.x
, u_smSamplingParams
, texelSize/2.0
, u_params1.w
, u_params1.z
, u_params1.z
, fragCoord
);
}
else if (selection2)
{
float4 shadowcoord = v_texcoord3;

float coverage = texcoordInRange(shadowcoord.xy/shadowcoord.w) * 0.4;
colorCoverage = float3(-coverage, -coverage, coverage);
visibility = computeVisibility(s_shadowMap2
, shadowcoord
, u_params1.x
, u_smSamplingParams
, texelSize/3.0
, u_params1.w
, u_params1.z
, u_params1.z
, fragCoord
);
}
else
{
float4 shadowcoord = v_texcoord4;

float coverage = texcoordInRange(shadowcoord.xy/shadowcoord.w) * 0.4;
colorCoverage = float3(coverage, -coverage, -coverage);
visibility = computeVisibility(s_shadowMap3
, shadowcoord
, u_params1.x
, u_smSamplingParams
, texelSize/4.0
, u_params1.w
, u_params1.z
, u_params1.z
, fragCoord
);
}

float3 v = v_view;
float3 vd = -normalize(v_view);
float3 n = v_normal;
Light light = evalLight(v, u_lightPosition, u_lightSpotDirectionInner.xyz, u_lightSpotDirectionInner.w, u_lightAttenuationSpotOuter.w, u_lightAttenuationSpotOuter.xyz);

float2 lc = lit(light.ld, n, vd, u_materialKs.w) * light.attn;
Shader shader = evalShader(lc.x, lc.y);


float3 fogColor = vec3_splat(0.0);
float fogDensity = 0.0035;
float LOG2 = 1.442695;
float z = length(v);
float fogFactor = clamp(1.0/exp2(fogDensity*fogDensity*z*z*LOG2), 0.0, 1.0);

float3 color = u_color.xyz;

float3 ambient = shader.ambi * color;
float3 brdf = (shader.diff + shader.spec) * color * visibility;

float3 final = toGamma(abs(ambient + brdf)) + (colorCoverage * u_params2.y);
bgfx_FragData0.xyz = mix(fogColor, final, fogFactor);
bgfx_FragData0.w = 1.0;
}
}

